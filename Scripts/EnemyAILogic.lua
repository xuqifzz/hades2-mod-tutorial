AIThreadName = "AIThread"

function AIWait(duration, enemy, threadName, args)
	if enemy.IgnoreTimeSlowEffects then
		waitUnmodified( CalcEnemyWait( enemy, duration, args), threadName )
	else
		wait( CalcEnemyWait( enemy, duration, args), threadName )
	end
end

function AllAIStop( usee, args )
	for id, enemy in pairs( ActiveEnemies ) do
		killTaggedThreads( enemy.AIThreadName )
		killWaitUntilThreads( enemy.AINotifyName )
		Stop({ Id = enemy.ObjectId })
		StopAnimation({ DestinationId = enemy.ObjectId })
	end
end

function AllAIFollow( usee, args )
	AllAIStop( usee, args )
	wait( 0.02 )
	for id, enemy in pairs( ActiveEnemies ) do
		thread( SetAI, "FollowAI", enemy, CurrentRun )
	end
end

function AllAIFlee( usee, args )
	AllAIStop( usee, args )
	wait( 3.02 )
	for id, enemy in pairs( ActiveEnemies ) do
		thread(Retreat, enemy, { RetreatBufferDistance = 8000, RetreatDuration = 300, }, CurrentRun.Hero.ObjectId)
	end
end

function AllAIAttack( usee, args )
	AllAIStop( usee, args )
	wait( 0.02 )
	for id, enemy in pairs( ActiveEnemies ) do
		thread( DoAttackerAILoop, enemy )
	end
end

function FollowAI( enemy, followId )
	local aiData = GetWeaponAIData(enemy)
	local followDistance = aiData.FollowDistance or 300
	local followId = aiData.FollowId or CurrentRun.Hero.ObjectId
	while IsAIActive( enemy ) do
		--local moveOffset = CalcOffset(math.rad(RandomFloat(0, 360)), aiData.FollowDistance or 50 )
		Move({ Id = enemy.ObjectId, DestinationId = followId or CurrentRun.Hero.ObjectId, SuccessDistance = aiData.FollowSuccessDistance or 100,
				LiveOffsetFromId = followId or CurrentRun.Hero.ObjectId, LiveOffsetDistance = followDistance, LiveOffsetAngle = -180 })

		enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = followDistance, Notify = enemy.AINotifyName, Timeout = 5.0 })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )

		wait(aiData.FollowRefreshDuration or 1.0)
	end
end

function IdleAI( enemy )
	local aiData = enemy.DefaultAIData

	if enemy.WakeUpDelay ~= nil or (enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil) then
		local wakeUpDelay = enemy.WakeUpDelay or RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
		wait( CalcEnemyWait( enemy, wakeUpDelay ), enemy.AIThreadName )
	end

	if aiData.IdleAnimation ~= nil then
		SetAnimation({ Name = enemy.DefaultAIData.IdleAnimation, DestinationId = enemy.ObjectId })
	end
end

function MinionFollowAI( enemy )
	local aiData = GetWeaponAIData(enemy)
	local followDistance = aiData.FollowDistance or 300

	while IsAIActive( enemy ) and enemy.LeaderId ~= nil and ActiveEnemies[enemy.LeaderId] ~= nil do
		--local moveOffset = CalcOffset(math.rad(RandomFloat(0, 360)), aiData.FollowDistance or 50 )
		Move({ Id = enemy.ObjectId, DestinationId = enemy.LeaderId, SuccessDistance = aiData.FollowSuccessDistance or 100,
				LiveOffsetFromId = enemy.LeaderId, LiveOffsetDistance = followDistance, LiveOffsetAngle = -180 })

		enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = followDistance, Notify = enemy.AINotifyName, Timeout = 5.0 })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )

		Stop({ Id = enemy.ObjectId })

		if enemy.DoMinionAttack ~= nil then
			enemy.WeaponName = enemy.DoMinionAttack
			DoAttack(enemy, GetWeaponAIData(enemy))
			enemy.DoMinionAttack = nil
		end

		wait(aiData.FollowRefreshDuration or 0.0, enemy.AIThreadName)
	end

	if ActiveEnemies[enemy.LeaderId] == nil and IsAIActive( enemy ) then
		Stop({ Id = enemy.ObjectId })
		if enemy.CreatedOwnTarget ~= nil then
			Destroy({ Id = enemy.CreatedOwnTarget })
		end
		thread(SetAI, enemy.LeaderDeadAI, enemy)
	end
end

function GuardAI( enemy )

	while IsAIActive( enemy ) do
		enemy.WeaponName = SelectWeapon( enemy )
		table.insert( enemy.WeaponHistory, enemy.WeaponName )
		local aiData = GetWeaponAIData(enemy)


		local searchId = enemy.ObjectId
		if aiData.SearchDistanceOffset ~= nil then
			local offset = CalcOffset( math.rad( GetAngle({ Id = enemy.ObjectId }) ), aiData.SearchDistanceOffset )
			local searchOffsetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
			searchId = searchOffsetId
		end

		if aiData.IdleAnimation ~= nil then
			SetAnimation({ Name = enemy.DefaultAIData.IdleAnimation, DestinationId = enemy.ObjectId })
		end

		-- Wait for target to come within range, no timeout
		enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
		NotifyWithinDistanceAny({ Ids = { searchId }, DestinationNames = aiData.TriggerGroups or aiData.TargetGroups,
									Distance = aiData.AttackDistance, ScaleY = aiData.AttackDistanceScaleY or 0.65,
									Notify = enemy.AINotifyName, UseLocationZ = true })
		waitUntil( enemy.AINotifyName )
		aiData.TargetId = NotifyResultsTable[enemy.AINotifyName]

		if aiData.GroupTrigger then
			local enemyIds = GetIdsByType({ Name = enemy.Name })
			for k, enemyId in pairs(enemyIds) do
				if ActiveEnemies[enemyId] ~= nil then
					notifyExistingWaiters(ActiveEnemies[enemyId].AINotifyName)
				end
			end
		end

		-- If disabled while waiting
		if not IsAIActive( enemy ) then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.DisabledAnimation })
			break
		end

		DoAttackerAILoop(enemy, aiData)
		SurroundEnemiesAttacking[aiData.SurroundAIKey or enemy.Name][enemy.ObjectId] = nil
	end
end

function DefenseAI( enemy )
	
	while IsAIActive( enemy ) do
		local aiData = GetWeaponAIData(enemy, enemy.DefaultAIData.DefenseWeapon)
		aiData.AIThreadName = "DefenseAIThread"..enemy.Name.."_"..enemy.ObjectId

		-- Wait for target to come within range, no timeout
		local notifyName = "DefenseAIWithinDistance"..enemy.ObjectId
		NotifyWithinDistanceAny({ Ids = { enemy.ObjectId }, DestinationNames = aiData.TriggerGroups or aiData.TargetGroups,
									Distance = aiData.AttackDistance, ScaleY = aiData.AttackDistanceScaleY or 0.65,
									Notify = notifyName, UseLocationZ = true })
		waitUntil( notifyName )
		aiData.TargetId = NotifyResultsTable[enemy.AINotifyName]

		-- If disabled while waiting
		if not IsAIActive( enemy ) then
			break
		end

		DoAttackerAILoop(enemy, aiData)
		SurroundEnemiesAttacking[aiData.SurroundAIKey or enemy.Name][enemy.ObjectId] = nil
	end
	
end

function SafeZoneAI( enemy )

	enemy.WeaponName = SelectWeapon( enemy )
	table.insert( enemy.WeaponHistory, enemy.WeaponName )
	local aiData = GetWeaponAIData(enemy)

	if enemy.ActivateGameStateRequirements ~= nil and not IsGameStateEligible(CurrentRun, enemy, enemy.ActivateGameStateRequirements) then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.DisabledAnimation })
		return
	end


	local searchId = enemy.ObjectId
	if aiData.SearchDistanceOffset ~= nil then
		local offset = CalcOffset( math.rad( GetAngle({ Id = enemy.ObjectId }) ), aiData.SearchDistanceOffset )
		local searchOffsetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
		searchId = searchOffsetId
	end

	if aiData.IdleAnimation ~= nil then
		SetAnimation({ Name = enemy.DefaultAIData.IdleAnimation, DestinationId = enemy.ObjectId })
	end

	-- Wait for target to come within range, no timeout
	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistance({ Ids = { searchId }, DestinationId = CurrentRun.Hero.ObjectId,
								Distance = aiData.AttackDistance, ScaleY = aiData.AttackDistanceScaleY or 0.5,
								Notify = enemy.AINotifyName })
	waitUntil( enemy.AINotifyName )
	aiData.TargetId = NotifyResultsTable[enemy.AINotifyName]

	if aiData.GroupTrigger then
		local enemyIds = GetIdsByType({ Name = enemy.Name })
		for k, enemyId in pairs(enemyIds) do
			if ActiveEnemies[enemyId] ~= nil then
				notifyExistingWaiters(ActiveEnemies[enemyId].AINotifyName)
			end
		end
	end

	-- If disabled while waiting
	if not IsAIActive( enemy ) then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.DisabledAnimation })
		return
	end

	DoAttackerAILoop(enemy, aiData)

	SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.DisabledAnimation })
end

function SentryAI( enemy )

	enemy.SentryTetherId = enemy.SentryTetherId or SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId })

	enemy.WeaponName = SelectWeapon( enemy )
	table.insert( enemy.WeaponHistory, enemy.WeaponName )
	local aiData = GetWeaponAIData(enemy)


	local searchId = enemy.ObjectId
	if aiData.SearchDistanceOffset ~= nil then
		local offset = CalcOffset( math.rad( GetAngle({ Id = enemy.ObjectId }) ), aiData.SearchDistanceOffset )
		local searchOffsetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
		searchId = searchOffsetId
	end

	if aiData.IdleAnimation ~= nil then
		SetAnimation({ Name = enemy.DefaultAIData.IdleAnimation, DestinationId = enemy.ObjectId })
	end

	-- Wait for target to come within range, no timeout
	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistanceAny({ Ids = { searchId }, DestinationNames = aiData.TriggerGroups or aiData.TargetGroups,
								Distance = aiData.SentryActivateDistance, ScaleY = aiData.AttackDistanceScaleY or 0.5,
								Notify = enemy.AINotifyName, UseLocationZ = true })
	waitUntil( enemy.AINotifyName )
	aiData.TargetId = NotifyResultsTable[enemy.AINotifyName]

	if aiData.GroupTrigger then
		local enemyIds = GetIdsByType({ Name = enemy.Name })
		for k, enemyId in pairs(enemyIds) do
			if ActiveEnemies[enemyId] ~= nil then
				notifyExistingWaiters(ActiveEnemies[enemyId].AINotifyName)
			end
		end
	end

	-- If disabled while waiting
	if not IsAIActive( enemy ) then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.DisabledAnimation })
		return
	end

	if aiData.SentryActivateAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.SentryActivateAnimation })
	end

	if aiData.SentryActivateDelay ~= nil then
		wait( CalcEnemyWait( enemy, aiData.SentryActivateDelay ), enemy.AIThreadName )
	end

	SetAI("AttackerAI", enemy)
end

function ResetSentry( enemy )

	local aiData = GetWeaponAIData(enemy)

	Move({ Id = enemy.ObjectId, DestinationId = enemy.SentryTetherId, SuccessDistance = 32 })

	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId

	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = enemy.SentryTetherId, Distance = 50, Notify = enemy.AINotifyName, Timeout = timeout or 9.0 })

	waitUntil( enemy.AINotifyName, enemy.AIThreadName )

	Stop({ Id = enemy.ObjectId })

	if aiData.SentryResetAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.SentryResetAnimation })
	end

	if aiData.SentryResetDelay ~= nil then
		wait( CalcEnemyWait( enemy, aiData.SentryResetDelay ), enemy.AIThreadName )
	end

	SetAI("SentryAI", enemy)
end

function AttackAndDie( enemy )
	wait( CalcEnemyWait( enemy, 0.1), enemy.AIThreadName )

	enemy.WeaponName = enemy.WeaponName or SelectWeapon(enemy)

	local aiData = ShallowCopyTable(enemy.DefaultAIData) or {}
	DebugAssert({ Condition = enemy.DefaultAIData ~= nil, Text = enemy.Name.." has no DefaultAIData", Owner = "Eduardo" })
	if WeaponData[enemy.WeaponName] ~= nil and WeaponData[enemy.WeaponName].AIData ~= nil then
		OverwriteTableKeys( aiData, WeaponData[enemy.WeaponName].AIData)
	end
	aiData.WeaponName = enemy.WeaponName

	local targetId = GetTargetId( enemy, aiData )
	DoAttackerAILoop( enemy, aiData )
	Kill( enemy )
end

function RetaliateAttackerAILoop( enemy, attacker )
	if not enemy.Retaliating then
		enemy.Retaliating = true
		DoAttackerAILoop( enemy )

		wait(enemy.RetaliateResetDuration)
		enemy.Retaliating = false
	end
end

function DestructibleTreeHit( enemy, attacker, triggerArgs )
	if attacker == nil or attacker.ObjectId ~= CurrentRun.Hero.ObjectId then
		return
	end

	local hits = 1
	if triggerArgs ~= nil and triggerArgs.AttackerWeaponData ~= nil and triggerArgs.AttackerWeaponData.ImpactReactionHitsOverride ~= nil then
		hits = triggerArgs.AttackerWeaponData.ImpactReactionHitsOverride
	end
	enemy.HitsTaken = enemy.HitsTaken or 0
	enemy.HitsTaken = enemy.HitsTaken + hits
	RecordObjectState( CurrentRun.CurrentRoom, enemy.ObjectId, "HitsTaken", enemy.HitsTaken )

	if attacker ~= nil then
		enemy.KillOwner = attacker.ObjectId
	end
	
	if enemy.HitsTaken >= enemy.DefaultAIData.HitsToSplinter then
		if #enemy.WeaponHistory == 0 then
		 	SetAngle({ Id = enemy.ObjectId, Angle = triggerArgs.ImpactAngle })
			DoAttackerAILoop( enemy )
			
			SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DestroyedAnimation })
			RecordObjectState( CurrentRun.CurrentRoom, enemy.ObjectId, "Animation", enemy.DestroyedAnimation )

			if not enemy.DestroyedStopsProjectiles then
				SetThingProperty({ Property = "StopsProjectiles",  DestinationId = enemy.ObjectId, Value = false })
				RecordObjectState(CurrentRun.CurrentRoom, enemy.ObjectId, "StopsProjectiles", false)
			end
		end
	elseif enemy.HitsTaken <= enemy.DefaultAIData.HitsToSplinter then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.SplinterAnimation })
	end
end

function ThornTreeHit( enemy, attacker, triggerArgs )
	local hits = 1
	if triggerArgs ~= nil and triggerArgs.AttackerWeaponData ~= nil and triggerArgs.AttackerWeaponData.ImpactReactionHitsOverride ~= nil then
		hits = triggerArgs.AttackerWeaponData.ImpactReactionHitsOverride
	end
	enemy.HitsTaken = enemy.HitsTaken or 0
	enemy.HitsTaken = enemy.HitsTaken + hits
	RecordObjectState( CurrentRun.CurrentRoom, enemy.ObjectId, "HitsTaken", enemy.HitsTaken )

	if attacker ~= nil then
		enemy.KillOwner = attacker.ObjectId
	end

 	SetGoalAngle({ Id = enemy.ObjectId, Angle = triggerArgs.ImpactAngle })
	DoAttackerAILoop( enemy )
	
	if enemy.HitsTaken >= enemy.DefaultAIData.HitsToSplinter then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DestroyedAnimation })
		RecordObjectState( CurrentRun.CurrentRoom, enemy.ObjectId, "Animation", enemy.DestroyedAnimation )

		SetThingProperty({ Property = "StopsProjectiles",  DestinationId = enemy.ObjectId, Value = false })
		RecordObjectState(CurrentRun.CurrentRoom, enemy.ObjectId, "StopsProjectiles", false)
	elseif enemy.DefaultAIData.HitsToSplinter - enemy.HitsTaken == 1 and enemy.SplinterAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.SplinterAnimation })
	elseif enemy.DefaultAIData.HitsToSplinter - enemy.HitsTaken > 1 then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.OnHitAnimation })
	end
end

function DirectionalShatterAI( enemy, attacker, triggerArgs )
	SetAngle({ Id = enemy.ObjectId, Angle = triggerArgs.ImpactAngle })
	DoAttackerAILoop( enemy )
	if enemy.DefaultAIData.ShatterSpawnObstacle then
		SpawnObstacle({ Name = enemy.DefaultAIData.ShatterSpawnObstacle, DestinationId = enemy.ObjectId, Group = "Standing" })
	end
	Kill( enemy )
end

function FireAndQuit( enemy )
	DoAttackerAILoop(enemy)
	--FireWeaponFromUnit({ Weapon = enemy.WeaponName, Id = enemy.ObjectId, AutoEquip = true, })
end

function CollisionRetaliateAI( enemy )

	while IsAIActive( enemy ) do
		enemy.WeaponName = SelectWeapon( enemy )
		table.insert( enemy.WeaponHistory, enemy.WeaponName )
		local aiData = GetWeaponAIData(enemy)

		if aiData.IdleAnimation ~= nil then
			SetAnimation({ Name = enemy.DefaultAIData.IdleAnimation, DestinationId = enemy.ObjectId })
		end

		-- Wait for collision
		enemy.AINotifyName = "CollisionWith"..enemy.ObjectId
		NotifyOnCollide({ Id = enemy.ObjectId, DestinationNames = aiData.TargetGroups, PointOnly = aiData.PointOnlyCollision, Notify = enemy.AINotifyName })
		waitUntil( enemy.AINotifyName )
		local colliderId = NotifyResultsTable[enemy.AINotifyName]

		local velocity = GetVelocity({ Id = colliderId })
		if enemy.RequiredVictimVelocity ~= nil and velocity < enemy.RequiredVictimVelocity then
			wait( CalcEnemyWait( enemy, 0.1), enemy.AIThreadName )
		else
			-- If disabled while waiting
			if not IsAIActive( enemy ) then
				if aiData.DisabledAnimation ~= nil then
					SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.DisabledAnimation })
				end
				return
			end

			-- Prepare to attack
			DoAttack(enemy, aiData)

			-- Wait until target leaves before resetting
			if enemy.AIResetDistance ~= nil then
				enemy.AINotifyName = "OutsideDistance"..enemy.ObjectId
				NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = nearbyTargetId, Distance = enemy.AIResetDistance, Notify = enemy.AINotifyName })
				waitUntil( enemy.AINotifyName )

				if not IsAIActive( enemy ) then
					break
				end

				if aiData.IdleAnimation ~= nil then
					SetAnimation({ Name = enemy.IdleAnimation, DestinationId = enemy.ObjectId })
				end
				if aiData.ReloadedSound ~= nil then
					PlaySound({ Name = enemy.ReloadedSound, Id = enemy.ObjectId })
				end
			end
		end
	end
end

function PassiveAI( enemy )

	if enemy.WakeUpDelay ~= nil or (enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil) then
		local wakeUpDelay = enemy.WakeUpDelay or RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
		wait( CalcEnemyWait( enemy, wakeUpDelay ), enemy.AIThreadName )
	end

	while IsAIActive( enemy ) do
		enemy.WeaponName = SelectWeapon( enemy )
		table.insert( enemy.WeaponHistory, enemy.WeaponName )
		local aiData = GetWeaponAIData(enemy)

		if aiData.AIResetDistance ~= nil then
			-- Check if target within range
			enemy.AINotifyName = "WithinDistance_"..enemy.Name..enemy.ObjectId

			NotifyWithinDistanceAny({ Ids = { enemy.ObjectId }, DestinationNames = aiData.TargetGroups, Distance = aiData.AttackDistance, ScaleY = 0.5, Notify = enemy.AINotifyName, Timeout = aiData.Timeout or 0.1 })
			waitUntil( enemy.AINotifyName )
			aiData.TargetId = NotifyResultsTable[enemy.AINotifyName]

			if aiData.TargetId ~= nil and aiData.TargetId ~= 0 then
				-- Wait until target leaves before resetting
				enemy.AINotifyName = "OutsideDistance"..enemy.ObjectId

				NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, Distance = aiData.AIResetDistance, Notify = enemy.AINotifyName })
				waitUntil( enemy.AINotifyName )
				if aiData.IdleAnimation ~= nil then
					SetAnimation({ Name = aiData.IdleAnimation, DestinationId = enemy.ObjectId })
				end
				if aiData.ReloadedSound ~= nil then
					PlaySound({ Name = aiData.ReloadedSound, Id = enemy.ObjectId })
				end
			end
		end

		local success = DoAttack(enemy, aiData)
		if not success then
			enemy.AINotifyName = "CanAttack"..enemy.ObjectId
			NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end
		
		if not IsAIActive( enemy ) then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.DisabledAnimation })
			break
		end
	end

end

function RemoteAI( enemy )

	while IsAIActive( enemy ) do
		enemy.WeaponName = SelectWeapon( enemy )
		table.insert( enemy.WeaponHistory, enemy.WeaponName )
		local aiData = GetWeaponAIData(enemy)

		if aiData.IdleAnimation ~= nil then
			SetAnimation({ Name = aiData.IdleAnimation, DestinationId = enemy.ObjectId })
		end

		-- Wait for target to come within range, no timeout
		enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
		NotifyWithinDistanceAny({ Ids = { enemy.ObjectId }, DestinationNames = enemy.TargetGroups, Distance = aiData.AttackDistance, ScaleY = 0.5, MaxZ = aiData.MaxVictimZ, Notify = enemy.AINotifyName })
		waitUntil( enemy.AINotifyName )
		aiData.TargetId = NotifyResultsTable[enemy.AINotifyName]

		-- If disabled while waiting
		if not IsAIActive( enemy ) then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.DisabledAnimation })
			return
		end

		local linkedEnemy = ActiveEnemies[GetClosestUnitOfType({ Id = enemy.ObjectId, DestinationName = aiData.LinkedEnemy, Distance = 2000 })]

		local trapChainData = nil
		if CurrentRun.CurrentRoom.RemoteTrapChains ~= nil then
			trapChainData = CurrentRun.CurrentRoom.RemoteTrapChains[enemy.ObjectId]
		end

		DoAttack(enemy, aiData)

		if trapChainData ~= nil then
			for k, chain in ipairs(trapChainData.Chains) do
				for k, chainedEnemyId in ipairs(chain) do
					notifyExistingWaiters("WithinDistance"..chainedEnemyId)
					local chainedEnemy = ActiveEnemies[chainedEnemyId]
					if chainedEnemy ~= nil then
						local chainedWeaponAIData = ShallowCopyTable(chainedEnemy.DefaultAIData) or chainedEnemy
						if WeaponData[chainedEnemy.WeaponName] ~= nil and WeaponData[chainedEnemy.WeaponName].AIData ~= nil then
							OverwriteTableKeys( chainedWeaponAIData, WeaponData[chainedEnemy.WeaponName].AIData)
						end
						chainedWeaponAIData.WeaponName = chainedEnemy.WeaponName

						thread(DoAttack, chainedEnemy, chainedWeaponAIData )
					end
				end
				wait( CalcEnemyWait( enemy, trapChainData.ChainInterval), enemy.AIThreadName )
			end
		end

		if linkedEnemy ~= nil then
			local linkedWeaponAIData = ShallowCopyTable(linkedEnemy.DefaultAIData) or linkedEnemy
			if WeaponData[linkedEnemy.WeaponName] ~= nil and WeaponData[linkedEnemy.WeaponName].AIData ~= nil then
				OverwriteTableKeys( linkedWeaponAIData, WeaponData[linkedEnemy.WeaponName].AIData)
			end
			linkedWeaponAIData.WeaponName = linkedEnemy.WeaponName
			thread(DoAttack, linkedEnemy, linkedWeaponAIData )
		end

		if not IsAIActive( enemy ) then
			break
		end

		-- Wait until target leaves before resetting
		if aiData.AIResetDistance ~= nil then
			enemy.AINotifyName = "OutsideDistance"..enemy.ObjectId
			NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, Distance = aiData.AIResetDistance, Notify = enemy.AINotifyName })
			waitUntil( enemy.AINotifyName )

			if not IsAIActive( enemy ) then
				break
			end

			if aiData.IdleAnimation ~= nil then
				SetAnimation({ Name = aiData.IdleAnimation, DestinationId = enemy.ObjectId })
			end
			if aiData.ReloadedSound ~= nil then
				PlaySound({ Name = aiData.ReloadedSound, Id = enemy.ObjectId })
			end
		end
	end
end

function ShadeMercAI( enemy )
	local room = CurrentHubRoom or CurrentRun.CurrentRoom
	room.ShadeMercInactiveIds = room.ShadeMercInactiveIds or {}
	room.ShadeMercActiveIds = room.ShadeMercActiveIds or {}

	SetAlpha({ Id = enemy.ObjectId, Fraction = 1 })
	SetAnimation({ Name = enemy.DefaultAIData.IdleAnimation, DestinationId = enemy.ObjectId })

	while IsAIActive( enemy ) do
		-- Wait for target to come within range, no timeout
		enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId,
									Distance = enemy.DefaultAIData.RecruitDistance, ScaleY = enemy.DefaultAIData.AttackDistanceScaleY or 0.55,
									Notify = enemy.AINotifyName })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )

		if CurrentRun.Hero.SprintActive or HasEffect({ Id = CurrentRun.Hero.ObjectId, EffectName = "RushWeaponDisableMove" }) then

			local endAI = false

			local aiData = nil
			enemy.WeaponName = SelectWeapon( enemy )
			table.insert(enemy.WeaponHistory, enemy.WeaponName)
			aiData = GetWeaponAIData(enemy)
			if HeroHasTrait("ShadeMercFireballBoon") then
				aiData.ProjectileName = "ShadeMercFireball"
			end

			-- Target skelly in PreRun
			if CurrentHubRoom ~= nil and CurrentHubRoom.ShadeMercAITarget ~= nil then
				aiData.TargetId = GetIdsByType({ Name = CurrentHubRoom.ShadeMercAITarget })[1]
			end

			if aiData.TargetId == nil then
				aiData.TargetId = GetTargetId(enemy, aiData)
			end

			if aiData.TargetId ~= 0 and enemy.WeaponName ~= nil then
				thread(MarkObjectiveComplete, "ShadeMercSpiritball")
				endAI = DoAttack( enemy, aiData )
			end

			if room.CollectShadeMercs then
				CollectShadeMerc(enemy)
				return
			end


			if endAI then
				SetAnimation({ Name = enemy.DefaultAIData.DisabledAnimation, DestinationId = enemy.ObjectId })
				RecordMapState( (CurrentHubRoom or CurrentRun.CurrentRoom).Name, enemy.ObjectId, "Animation", enemy.DefaultAIData.DisabledAnimation )
				RecordMapState( (CurrentHubRoom or CurrentRun.CurrentRoom).Name, enemy.ObjectId, "SkipAISetupOnActivate", true )
				break
			else
				wait( 1.0, enemy.AIThreadName )
			end
		else
			SetAlpha({ Id = enemy.ObjectId, Fraction = 0.0, Duration = 0.2 })
			wait( 0.2, enemy.AIThreadName )
			enemy.AINotifyName = "OutsideDistance_"..enemy.Name.."_"..enemy.ObjectId
			local buffer = 50
			NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId,
									Distance = enemy.DefaultAIData.RecruitDistance + buffer, ScaleY = enemy.DefaultAIData.AttackDistanceScaleY or 0.55,
									Notify = enemy.AINotifyName })
			waitUntil( enemy.AINotifyName, enemy.AIThreadName )
			wait( 0.2, enemy.AIThreadName )
			SetAlpha({ Id = enemy.ObjectId, Fraction = 1.0, Duration = 0.2 })
		end
	end

	if room.ActiveEncounters ~= nil and IsEmpty(room.ActiveEncounters) then
		return
	end

	table.insert(room.ShadeMercInactiveIds, enemy.ObjectId)
	RemoveValue(room.ShadeMercActiveIds, enemy.ObjectId)
	notifyExistingWaiters("ShadeMercDeath")
end

function CollectShadeMerc(enemy)
	CurrentRun.ShadeMercsCollected = CurrentRun.ShadeMercsCollected + 1
	MapState.RoomRequiredObjects[enemy.ObjectId] = nil
	SetColor({ Id = enemy.ObjectId, Color = { 1.0, 0.75, 0.0, 0.75 } })
	PlaySound({ Name = "/SFX/GhostEmotes/SmileTINY", Id = enemy.ObjectId })
	thread( PlayEmoteSimple, enemy, { AnimationName = "StatusIconSmile", Delay = 0.5, ChanceToPlay = 0.1 } )

	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end
	local exitDoorId = GetRandomValue(GetIdsByType({Name = "EphyraExitDoorReturn"}))
	Move({ Id = enemy.ObjectId, DestinationId = exitDoorId, SuccessDistance = 32, })

	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = exitDoorId, Distance = 100, Notify = enemy.AINotifyName, Timeout = 8.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )

	PlaySound({ Name = "/SFX/GhostEvaporate", Id = enemy.ObjectId })
	Destroy({ Id = enemy.ObjectId })
end

function FogAI( enemy )

	local withinFog = false

	withinFog = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) < enemy.DefaultAIData.FogRadius

	while IsAIActive( enemy ) do
		if withinFog then
			StopAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DefaultAIData.OutsideFogFx })
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DefaultAIData.InsideFogFx })
			SetUnitVulnerable( enemy )

			local distanceNotify = "OutsideFogDistance"..enemy.ObjectId
			local buffer = enemy.DefaultAIData.ExitFogRadiusBuffer or enemy.DefaultAIData.FogRadiusBuffer or 0
			NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = enemy.DefaultAIData.FogRadius + buffer, Notify = distanceNotify, ScaleY = enemy.DefaultAIData.FogRadiusScaleY })
			waitUntil( distanceNotify )
			withinFog = false
		else
			StopAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DefaultAIData.InsideFogFx })
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DefaultAIData.OutsideFogFx })
			SetUnitInvulnerable( enemy )

			local distanceNotify = "WithinFogDistance"..enemy.ObjectId
			local buffer = enemy.DefaultAIData.EnterFogRadiusBuffer or enemy.DefaultAIData.FogRadiusBuffer or 0
			NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = enemy.DefaultAIData.FogRadius - buffer, Notify = distanceNotify, ScaleY = enemy.DefaultAIData.FogRadiusScaleY })
			waitUntil( distanceNotify )
			withinFog = true
		end
	end
end

function GroupAI(unitGroup)
	local followerIds = unitGroup.UnitIds
	local leaderId = RemoveRandomValue(followerIds)

	local leader = ActiveEnemies[leaderId]
	leader.MinionIds = followerIds
	if unitGroup.LeaderFx ~= nil then
		leader.StopAnimationsOnDeath = leader.StopAnimationsOnDeath or {}
		table.insert(leader.StopAnimationsOnDeath, unitGroup.LeaderFx)
		CreateAnimation({ Name = unitGroup.LeaderFx, DestinationId = leaderId })
	end
	if unitGroup.DisableLeaderUnitCollision ~= nil then
		SetUnitProperty({ Property = "CollideWithUnits",  DestinationId = leader.ObjectId, Value = false })
	end
	SetupAI( leader )

	for k, unitId in pairs(followerIds) do
		local minion = ActiveEnemies[unitId]
		minion.DefaultAIData.FollowId = leaderId
		minion.LeaderId = leaderId
		minion.MinionAI = minion.MinionAI or "MinionFollowAI"
		minion.AIOptions = { minion.MinionAI }
		SetupAI( minion )
	end

end

function HandleMinionWeapons(leader, aiData)
	for k, minionId in pairs(leader.MinionIds) do

		local minion = ActiveEnemies[minionId]
		if minion ~= nil then
			wait(aiData.AttackStaggerDelay, leader.AIThreadName)
			minion.DoMinionAttack = aiData.MinionWeapon
			notifyExistingWaiters(minion.AINotifyName)
			SetThreadWait(minion.AIThreadName, 0.0)
		else
			RemoveValue(leader.MinionIds, minionId)
		end
	end
end

function AttackerAI( enemy )
	if not enemy.IsAggroed then -- WakeUpDelay already happened in AggroAI
		if enemy.WakeUpDelay ~= nil or (enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil) then
			local wakeUpDelay = enemy.WakeUpDelay or RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
			wait( CalcEnemyWait( enemy, wakeUpDelay ), enemy.AIThreadName )
		end
	end

	while IsAIActive( enemy ) do
		if enemy.PostCombatAI and CurrentRun.CurrentRoom.Encounter.InProgress ~= nil and CurrentRun.CurrentRoom.Encounter.InProgress == false then
			SetAI( enemy.PostCombatAI, enemy )
			return
		end

		local continue = DoAttackerAILoop( enemy )
		SurroundEnemiesAttacking[enemy.SurroundAIKey or enemy.Name][enemy.ObjectId] = nil
		if not continue then
			return
		end

	end
end

function DoAttackerAILoop( enemy, aiData )

	enemy.LastAttackerAIStartTimestamp = _worldTime
	if aiData == nil then
		enemy.WeaponName = SelectWeapon( enemy )
		DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = enemy.Name.." has no eligible weapons.", Owner = "Eduardo" })
		aiData = GetWeaponAIData(enemy)
	end
	table.insert(enemy.WeaponHistory, enemy.WeaponName)

	if not aiData.SkipSurroundAICount then
		local surroundAIKey = aiData.SurroundAIKey or enemy.Name
		SurroundEnemiesAttacking[surroundAIKey] = SurroundEnemiesAttacking[surroundAIKey] or {}
		SurroundEnemiesAttacking[surroundAIKey][enemy.ObjectId] = true
	end

	if aiData.EndOrbitAIBeforeAttack then
		enemy.DisableOrbitAI = true
		SetThreadWait( aiData.AIThreadName or enemy.AIThreadName, 0.01)
	end

	if aiData.UseRamAILoop then
		RamAILoop(enemy, aiData)
		return true
	end

	if aiData.PartnerForceWeaponInterrupt then
		if enemy.ComboPartnerId ~= nil and ActiveEnemies[enemy.ComboPartnerId] ~= nil and not ActiveEnemies[enemy.ComboPartnerId].IsDead then
			ActiveEnemies[enemy.ComboPartnerId].ForcedWeaponInterrupt = aiData.PartnerForceWeaponInterrupt.."_"..enemy.ComboPartnerName
		end
	end

	if aiData.TargetId == nil then
		aiData.TargetId = GetTargetId(enemy, aiData)
	end

	if aiData.TeleportToTargetId ~= nil then
		Teleport({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
	end

	if aiData.TeleportToId ~= nil then
		Teleport({ Id = enemy.ObjectId, DestinationId = aiData.TeleportToId })
	end

	if aiData.AIPickupTypes ~= nil then
		local pickupSuccess = DoPickup( enemy, aiData )
		if aiData.CancelIfFailedPickup and not pickupSuccess then
			return true
		end
	end

	if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
		if aiData.AttackFailWeapon ~= nil then
			DebugAssert({ Condition = aiData.AttackFailWeapon ~= enemy.WeaponName, Text = "Using "..tostring(aiData.WeaponName).." as AttackFailWeapon on itself. This will infinite loop.", Owner = "Eduardo" })
			enemy.WeaponName = aiData.AttackFailWeapon
			DoAttackerAILoop(enemy)
			return true
		end
		enemy.AINotifyName = "CanAttack"..enemy.ObjectId
		NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
		waitUntil( enemy.AINotifyName )
	end

	if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
		return
	end

	if aiData.TargetId ~= nil and aiData.TargetId ~= 0 then

		-- Pre-Movement
		if aiData.RetreatBeforeAttack then
			Retreat(enemy, aiData, aiData.TargetId)
			AIWait(0.05, enemy, aiData.AIThreadName or enemy.AIThreadName)
		end

		if aiData.PreMoveFunctionName then
			CallFunctionName( aiData.PreMoveFunctionName, enemy, aiData, aiData.PreMoveFunctionArgs )
		end

		if aiData.PreMoveVoiceLines ~= nil then
			thread( PlayVoiceLines, aiData.PreMoveVoiceLines, nil, enemy )
		end

		-- Teleportation
		if aiData.TeleportToSpawnPoints then
			HandleEnemyTeleportation(enemy, aiData,aiData.TeleportToId)
		end

		-- Leap
		if aiData.PreMoveLeap then
			Leap( enemy, aiData )
		end

		-- Movement
		local moveToId = aiData.MoveToId or aiData.TargetId
		if aiData.MoveToClosestId ~= nil then
			moveToId = GetClosest({ Id = enemy.ObjectId, DestinationIds = aiData.MoveToClosestId })
		end
		if aiData.MoveToRandomSpawnPoint then
			local spawnNearId = aiData.TargetId
			if aiData.MoveToSpawnPointFromSelf then
				spawnNearId = enemy.ObjectId
			end
			moveToId = SelectSpawnPoint(CurrentRun.CurrentRoom, { Name = aiData.Name, RequiredSpawnPoint = aiData.MoveToSpawnPointType }, { SpawnNearId = spawnNearId, SpawnRadius = aiData.MoveToSpawnPointDistanceMax, SpawnRadiusMin = aiData.MoveToSpawnPointDistanceMin } )
		end
		if aiData.MoveToClosestSpawnPoint then
			moveToId = GetClosest({ Id = enemy.ObjectId, DestinationName = "SpawnPoints" })
		end
		if aiData.MoveToRandomLocation then
			MoveToRandomLocation( enemy, enemy.ObjectId, aiData.MoveToRandomLocationRadius, aiData.MoveToRandomLocationRadiusMin, aiData.MoveToRandomLocationTimeout )
		end
		if aiData.MoveToComboPartner then
			if enemy.ComboPartnerId ~= nil then
				moveToId = enemy.ComboPartnerId
			end
		end

		if aiData.OnlyClosestOfTypesMove then
			local closestId = GetClosestUnitOfType({ Id = aiData.TargetId, DestinationNames = aiData.OnlyClosestOfTypesMove })
			if closestId ~= enemy.ObjectId then
				AIWait(aiData.NotClosestSleepTime, enemy, aiData.AIThreadName or enemy.AIThreadName)
				return true
			end
		end

		if aiData.MoveWithinRange then
			local didTimeout = MoveWithinRange( enemy, moveToId, aiData )

			if aiData.EndPartnerWaitOnMoveEnd and enemy.ComboPartnerId ~= nil then
				if ActiveEnemies[enemy.ComboPartnerId] ~= nil and not ActiveEnemies[enemy.ComboPartnerId].IsDead then
					SetThreadWait( ActiveEnemies[enemy.ComboPartnerId].AIThreadName, 0.0 )
				else
					return true
				end
			end

			if didTimeout and aiData.SkipAttackAfterMoveTimeout then
				return true
			end

			if didTimeout and aiData.MoveTimeoutWeapon then
				enemy.WeaponName = aiData.MoveTimeoutWeapon
				DoAttackerAILoop(enemy)
				return true
			end

			if didTimeout and aiData.UseObstaclesOnMoveTimeout then
				local targetObstacleId = GetClosest({ Id = enemy.ObjectId, DestinationIds = GetIdsByType({ Name = aiData.UseObstaclesOnMoveTimeout }) })
				local targetObstacle = MapState.ActiveObstacles[targetObstacleId]
				if targetObstacleId ~= nil and targetObstacle ~= nil then
					local didTimeout = MoveWithinRange( enemy, targetObstacleId, aiData )

					if not didTimeout then
						CallFunctionName(targetObstacle.OnUsedFunctionName, targetObstacle, nil, enemy)
					end
				end

				return true
			end
		end

		if aiData.RemoveFromGroups then
			for k, groupName in pairs( aiData.RemoveFromGroups ) do
				RemoveFromGroup({ Id = enemy.ObjectId, Name = groupName })
			end
		end

		-- PreAttack Dash
		if aiData.PreAttackDash ~= nil and aiData.PreAttackDashChance ~= nil and RandomChance(aiData.PreAttackDashChance) then
			enemy.WeaponName = aiData.PreAttackDash
			local dashWeaponAIData = GetWeaponAIData(enemy)

			DoAttack( enemy, dashWeaponAIData )
			enemy.WeaponName = aiData.WeaponName
		end

		if aiData.PreAttackTeleportToSpawnPoints then
			HandleEnemyTeleportation(enemy, aiData)
		end

		-- Leap
		if aiData.PreAttackLeap then
			Leap( enemy, aiData )
		end

		if aiData.ChainedWeapon ~= nil then
			enemy.ChainedWeapon = aiData.ChainedWeapon
		end

		if aiData.ChainedWeaponOptions ~= nil then
			local elligibleWeapons = {}
			for k, weaponName in pairs(aiData.ChainedWeaponOptions) do
				local weaponData = WeaponData[weaponName]
				if IsEnemyWeaponEligible(enemy, weaponData) then
					if IsEnemyWeaponForced(enemy, weaponData) then
						enemy.ChainedWeapon = weaponName
						break
					else
						table.insert(elligibleWeapons, weaponName)
					end
				end
			end
			enemy.ChainedWeapon = GetRandomValue(elligibleWeapons)
		end

		if aiData.PreAttackRemoveEnemyUI then
			RemoveEnemyUI( enemy )
		end

		if aiData.PreAttackCreateHealthBar then
			CreateHealthBar( enemy )
			thread( UpdateHealthBar, enemy, 0, { Force = true } )
			for activeEffectName, stacks in pairs( enemy.ActiveEffects ) do
				UpdateEffectStacks( enemy, activeEffectName )
			end
		end

		-- Attack
		local attackSuccess = false
		while not attackSuccess do
			attackSuccess = DoAttack( enemy, aiData )
			FinishTargetMarker( enemy )
			if aiData.ForcedEarlyExit or enemy.ForcedWeaponInterrupt ~= nil then
				if aiData.InterruptAnimation ~= nil then
					SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.InterruptAnimation })
				end
				return true
			end
			if not attackSuccess then
				if aiData.AttackFailWeapon ~= nil then
					DebugAssert({ Condition = aiData.AttackFailWeapon ~= enemy.WeaponName, Text = "Using "..tostring(aiData.WeaponName).." as AttackFailWeapon on itself. This will infinite loop.", Owner = "Eduardo" })
					enemy.WeaponName = aiData.AttackFailWeapon
					DoAttackerAILoop(enemy)
					return true
				end
				if aiData.DoNotRepeatOnAttackFail then
					return true
				end
				enemy.AINotifyName = "CanAttack"..enemy.ObjectId
				NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
				waitUntil( enemy.AINotifyName )
			end
		end

		if enemy.AggroTetherId ~= nil and IsAlive({ Id = enemy.AggroTetherId }) then
			local distance = GetDistance({ Id = enemy.ObjectId, DestinationId = enemy.AggroTetherId })
			local tetherDistance = enemy.AggroTetherDistance or 500
			if distance > tetherDistance then
				enemy.ChainAggroAllEnemies = false
				return SetAI( "AggroAI", enemy )
			end
		end

		if enemy.SentryTetherId ~= nil then
			local distance = GetDistance({ Id = enemy.ObjectId, DestinationId = enemy.SentryTetherId })
			if distance > aiData.SentryTetherDistance then
				return SetAI( "ResetSentry", enemy )
			end
		end

		if aiData.RemoveFromGroups then
			for k, groupName in pairs( aiData.RemoveFromGroups ) do
				AddToGroup({ Id = enemy.ObjectId, Name = groupName })
			end
		end

		if aiData.RetreatAfterAttackChance ~= nil then
			aiData.RetreatAfterAttack = RandomChance(aiData.RetreatAfterAttackChance)
		end

		-- Post-Attack Movement
		if aiData.PostAttackRemoveEnemyUI then
			RemoveEnemyUI( enemy )
		end

		if aiData.PostAttackCreateHealthBar then
			CreateHealthBar( enemy )
			RecreateEffectVfx( enemy )
			thread( UpdateHealthBar, enemy, 0, { Force = true } )
			for activeEffectName, stacks in pairs( enemy.ActiveEffects ) do
				UpdateEffectStacks( enemy, activeEffectName )
			end
		end

		if aiData.RetreatAfterAttack then
			Retreat(enemy, aiData, aiData.TargetId)

			if aiData.RetreatAfterAttackEndWait ~= nil then
				Track({ Ids = { enemy.ObjectId }, DestinationIds = { aiData.TargetId } })

				AIWait(aiData.RetreatAfterAttackEndWait, enemy, aiData.AIThreadName or enemy.AIThreadName)
			end
		end

		-- Teleportation
		if aiData.PostAttackTeleportToSpawnPoints then
			HandleEnemyTeleportation(enemy, aiData)
		end

		-- Leap
		if aiData.PostAttackLeap then
			Leap( enemy, aiData )
		end

		if aiData.PostAttackTeleportToTargetId ~= nil then
			Teleport({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
		end

		if enemy.CreatedOwnTarget then
			Destroy({ Id = enemy.CreatedOwnTarget })
		end


		if aiData.PostAttackAI ~= nil then
			return SetAI( aiData.PostAttackAI, enemy )
		end
	else
		if enemy.SelfDestructIfNoAllies and GetRemainingSpawns(CurrentRun, CurrentRun.CurrentRoom, CurrentRun.CurrentRoom.Encounter) <= 0 then
			-- Wait to make sure nothing is mid-spawn
			wait(1.0, aiData.AIThreadName or enemy.AIThreadName)
			aiData.TargetId = GetTargetId(enemy, aiData)
			if aiData.TargetId == nil or aiData.TargetId == 0 then
				if enemy.SelfDestructWeapon then
					enemy.WeaponName = enemy.SelfDestructWeapon
					table.insert(enemy.WeaponHistory, enemy.WeaponName)

					local aiData = GetWeaponAIData(enemy)

					DoAttack(enemy, aiData)
				end
				Kill( enemy )
			end
		elseif enemy.NoTargetMoveTowardsPlayer then
			MoveWithinRange( enemy, CurrentRun.Hero.ObjectId, aiData )
		elseif enemy.SentryTetherId ~= nil and aiData.SentryResetWithNoTarget then
			return SetAI( "ResetSentry", enemy )
		else
			MoveToRandomLocation( enemy, enemy.ObjectId, enemy.NoTargetWanderDistance or 100, enemy.NoTargetWanderDistanceMin or 0, enemy.NoTargetWanderDuration )
		end
		AIWait(enemy.NoTargetWanderDuration or 0.5, enemy, aiData.AIThreadName or enemy.AIThreadName)
	end

	return true

end

function HandleEnemyTeleportation( enemy, aiData, teleportToId)

	if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
		return
	end

	aiData.TeleportationInterval = aiData.TeleportationInterval or 0
	if aiData.TeleportationIntervalMin ~= nil and aiData.TeleportationIntervalMax then
		RandomFloat( aiData.TeleportationIntervalMin, aiData.TeleportationIntervalMax )
	end
	enemy.LastTeleportTime = enemy.LastTeleportTime or 0

	if _worldTime - enemy.LastTeleportTime >= aiData.TeleportationInterval then
		local targetPointId = teleportToId

		if aiData.TeleportToRandomId ~= nil then
			targetPointId = GetRandomValue(aiData.TeleportToRandomId)
		else
			targetPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, enemy, { SpawnNearId = aiData.TargetId or CurrentRun.Hero.ObjectId, SpawnRadius = aiData.TeleportMaxDistance or 1000, SpawnRadiusMin = aiData.TeleportMinDistance },
															{ RequiredSpawnPoint = aiData.TeleportToSpawnPointType, AllowNoSpawnPoint = true, SpawnAwayFromTypes = aiData.SpawnAwayFromTypes, SpawnAwayFromTypesDistance = aiData.SpawnAwayFromTypesDistance, RequireLoS = aiData.RequireTeleportTargetLoS, LoSTarget = aiData.TargetId  })
		end
		-- spawn a target in case target Id is moving
		if aiData.TeleportToStaticDestination then
			targetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetPointId, OffsetX = aiData.TeleportOffsetX, OffsetY = aiData.TeleportOffsetY, ForceToValidLocation = true })
		end

		if targetPointId == nil then
			return
		end

		local offset = nil
		local createdOwnTarget = false
		if aiData.TeleportBehindTarget then
			local targetFacingAngle = GetAngle({ Id = aiData.LastTargetId })
			offset = CalcOffset( math.rad(targetFacingAngle), aiData.TeleportBehindTargetDistance or -100 )
		end
		if offset ~= nil then
			teleportPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetPointId, OffsetX = offset.X, OffsetY = offset.Y, ForceToValidLocation = true })
			createdOwnTarget = true
		end

		if aiData.StopBeforeTeleport then
			Stop({ Id = enemy.ObjectId })
		end
		if aiData.TeleportPreWaitFx ~= nil then
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.TeleportPreWaitFx })
		end
		if aiData.TeleportPreWaitAnimation ~= nil then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.TeleportPreWaitAnimation })
		end
		if aiData.AngleTowardsTeleportTarget then
			AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = targetPointId })
		end

		if aiData.PreTeleportClearAllEffects then
			ClearEffect({ Id = enemy.ObjectId, All = true })
		end

		if aiData.StartTeleportScreenShake then
			ShakeScreen( aiData.StartTeleportScreenShake )
		end

		AIWait(aiData.PreTeleportWait, enemy, aiData.AIThreadName or enemy.AIThreadName)

		if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
			return
		end

		local destinationFxId = nil
		if aiData.TeleportDestinationFx ~= nil then
			destinationFxId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetPointId })
			CreateAnimation({ DestinationId = destinationFxId, Name = aiData.TeleportDestinationFx })
		end

		if aiData.AngleTowardsTeleportTargetMidTeleport then
			AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = teleportToId })
		end

		if aiData.MidTeleportScreenShake then
			ShakeScreen( aiData.MidTeleportScreenShake )
		end

		if aiData.MidTeleportWait ~= nil then
			AIWait(aiData.MidTeleportWait, enemy, aiData.AIThreadName or enemy.AIThreadName)
			StopAnimation({ Name = aiData.TeleportDestinationFx, DestinationId = destinationFxId })
			if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
				return
			end
		end

		if aiData.TeleportSound ~= nil then
			PlaySound({ Name = aiData.TeleportSound, Id = enemy.ObjectId })
		end
		if aiData.TeleportStartFx ~= nil then
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.TeleportStartFx })
		end
		if aiData.TeleportAnimation ~= nil then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.TeleportAnimation })
		end

		if enemy.OccupyingSpawnPointId ~= nil then
			UnoccupySpawnPoint(enemy.OccupyingSpawnPointId)
		end
		Teleport({ Id = enemy.ObjectId, DestinationId = targetPointId })
		ClearAutoLock({ Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId })

		enemy.OccupyingSpawnPointId = targetPointId
		SessionMapState.SpawnPointsUsed[targetPointId] = enemy.ObjectId
		thread( UnoccupySpawnPointOnDistance, enemy, targetPointId, 400 )

		if aiData.TeleportEndFx ~= nil then
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.TeleportEndFx })
		end

		if aiData.PostTeleportClearAllEffects then
			ClearEffect({ Id = enemy.ObjectId, All = true })
		end

		enemy.LastTeleportTime = _worldTime

		if aiData.TeleportationIntervalMin ~= nil and aiData.TeleportationIntervalMax ~= nil then
			aiData.TeleportationInterval = RandomFloat( aiData.TeleportationIntervalMin, aiData.TeleportationIntervalMax )
		end
		AIWait(aiData.PostTeleportWait, enemy, aiData.AIThreadName or enemy.AIThreadName)

		if createdOwnTarget then
			Destroy({ Id = teleportPointId })
		end
	end
end

function SelectWeapon( enemy )
	local nextWeapon = nil

	if enemy.ForcedWeaponInterrupt ~= nil then
		if enemy.ForcedWeaponInterrupt == true then
			enemy.ForcedWeaponInterrupt = nil
		else
			enemy.WeaponName = enemy.ForcedWeaponInterrupt
			enemy.ForcedWeaponInterrupt = nil
			return enemy.WeaponName
		end
	end

	if enemy.ChainedWeapon ~= nil then
		if WeaponData[enemy.ChainedWeapon] ~= nil and WeaponData[enemy.ChainedWeapon].ChainChance ~= nil and not RandomChance(WeaponData[enemy.ChainedWeapon].ChainChance) then
			DebugPrint({ Text="Failed ChainChance" })
		else
			enemy.WeaponName = enemy.ChainedWeapon
			enemy.ChainedWeapon = nil
			if WeaponData[enemy.WeaponName] ~= nil and WeaponData[enemy.WeaponName].WeaponSelectorOnly then
				nextWeapon = GetRandomValue(WeaponData[nextWeapon].SelectorOptions)
			elseif WeaponData[enemy.WeaponName] ~= nil and WeaponData[enemy.WeaponName].WeaponComboOnly then
				enemy.ActiveWeaponCombo = enemy.WeaponName
				enemy.ActiveWeaponComboIndex = 0
				return SelectWeapon(enemy)
			else
				return enemy.WeaponName
			end
		end
	end

	if enemy.ActiveWeaponCombo ~= nil then
		enemy.ActiveWeaponComboIndex = enemy.ActiveWeaponComboIndex + 1
		local activeWeaponCombo = WeaponData[enemy.ActiveWeaponCombo].WeaponCombo
		if enemy.ActiveWeaponComboIndex <= TableLength(WeaponData[enemy.ActiveWeaponCombo].WeaponCombo) then
			enemy.WeaponName = activeWeaponCombo[enemy.ActiveWeaponComboIndex]
			return enemy.WeaponName
		else
			enemy.ActiveWeaponCombo = nil
		end
	end

	if nextWeapon == nil and enemy.WeaponOptions then
		local eligibleWeaponOptions = {}
		local forcedWeaponOptions = {}

		for k, weaponName in pairs(enemy.WeaponOptions) do
			local weaponData = WeaponData[weaponName]
			if weaponData == nil or weaponData.AIData == nil or IsEnemyWeaponEligible( enemy, weaponData ) then
				if IsEnemyWeaponForced( enemy, weaponName ) then
					table.insert(forcedWeaponOptions, weaponName)
				else
					table.insert(eligibleWeaponOptions, weaponName)
				end
				--DebugPrint({ Text = "Option "..enemy.WeaponName })
			end
		end

		nextWeapon = GetRandomValue(forcedWeaponOptions) or GetRandomValue(eligibleWeaponOptions)
	end

	if nextWeapon == nil then
		if enemy.DisarmedWeapon ~= nil then
			--DebugPrint({ Text = "Equiping disarmed weapon" })
			nextWeapon = enemy.DisarmedWeapon
		end
	end

	if enemy.Enraged and WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].AIData ~= nil and WeaponData[nextWeapon].AIData.EnragedWeaponSwap ~= nil then
		nextWeapon = WeaponData[nextWeapon].AIData.EnragedWeaponSwap
	end

	if enemy.GodUpgrade ~= nil and WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].GodUpgradeWeaponSwap ~= nil and WeaponData[nextWeapon].GodUpgradeWeaponSwap[enemy.GodUpgrade] ~= nil then
		nextWeapon = WeaponData[nextWeapon].GodUpgradeWeaponSwap[enemy.GodUpgrade]
	end

	if WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].SkipToChainedWeaponIfObstacleExists ~= nil and not IsEmpty(GetIdsByType({ Name = WeaponData[nextWeapon].SkipToChainedWeaponIfObstacleExists })) then
		nextWeapon = WeaponData[nextWeapon].AIData.ChainedWeapon
	end

	if WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].WeaponSelectorOnly then
		nextWeapon = GetRandomValue(WeaponData[nextWeapon].SelectorOptions)
	end
	if WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].WeaponCombo ~= nil then
		enemy.ActiveWeaponCombo = nextWeapon
		enemy.ActiveWeaponComboIndex = 0
		if WeaponData[nextWeapon].WeaponComboOnly then
			table.insert( enemy.WeaponHistory, nextWeapon )
			return SelectWeapon(enemy)
		end
	end

	enemy.WeaponName = nextWeapon or enemy.WeaponName
	--DebugPrint({ Text = "Selected Weapon: "..enemy.WeaponName })
	return enemy.WeaponName
end

function IsEnemyWeaponEligible( enemy, weaponData, requirements )
	requirements = requirements or weaponData.Requirements
	if requirements == nil then
		requirements = weaponData.AIData
	end

	if requirements ~= nil then
		if requirements.RequiresNotEnraged and enemy.Enraged then
			return false
		end

		if requirements.BlockAsFirstWeapon and (enemy.WeaponHistory == nil or #enemy.WeaponHistory <= 0) then
			return false
		end

		if requirements.RequireTotalAttacks ~= nil and (enemy.WeaponHistory == nil or #enemy.WeaponHistory <= requirements.RequireTotalAttacks) then
			return false
		end

		if requirements.MinRequiredKillEnemies ~= nil and TableLength(RequiredKillEnemies) < requirements.MinRequiredKillEnemies then
			return false
		end

		if requirements.MinAttacksBetweenUse ~= nil then
			local attacksSinceWeapon = NumAttacksSinceWeapon( enemy, weaponData.Name )
			--DebugPrint({ Text = "Attacks Since "..weaponData.Name.." Use: "..attacksSinceWeapon })
			if attacksSinceWeapon >= 0 and attacksSinceWeapon < requirements.MinAttacksBetweenUse then
				return false
			end
		end

		if requirements.MaxConsecutiveUses ~= nil then
			local consecutiveAttacks = NumConsecutiveUses( enemy, weaponData.Name )
			--DebugPrint({ Text = consecutiveAttacks })
			if consecutiveAttacks >= requirements.MaxConsecutiveUses then
				return false
			end
		end

		if requirements.PreviousWeaponNot ~= nil and enemy.WeaponHistory ~= nil then
			local prevWeapon = enemy.WeaponHistory[#enemy.WeaponHistory]
			if prevWeapon == requirements.PreviousWeaponNot then
				return false
			end
		end

		if requirements.MaxUses ~= nil and enemy.WeaponHistory ~= nil then
			local numUses = 0
			for i = #enemy.WeaponHistory, 1, -1 do
				local prevWeapon = enemy.WeaponHistory[i]
				if prevWeapon == weaponData.Name then
					numUses = numUses + 1
				end

				if numUses >= requirements.MaxUses then
					return false
				end
			end
		end

		if requirements.WeaponHistory ~= nil and enemy.WeaponHistory ~= nil then
			for weaponName, uses in pairs(requirements.WeaponHistory) do
				local numUses = 0
				for i = #enemy.WeaponHistory, 1, -1 do
					local prevWeapon = enemy.WeaponHistory[i]
					if prevWeapon == weaponName then
						numUses = numUses + 1
					end
				end
				if numUses < uses then
					return false
				end
			end
		end

		if requirements.WeaponHistoryMax ~= nil and enemy.WeaponHistory ~= nil then
			for weaponName, uses in pairs(requirements.WeaponHistoryMax) do
				local numUses = 0
				for i = #enemy.WeaponHistory, 1, -1 do
					local prevWeapon = enemy.WeaponHistory[i]
					if prevWeapon == weaponName then
						numUses = numUses + 1
					end
				end
				if numUses >= uses then
					return false
				end
			end
		end

		if requirements.MinPlayerArc ~= nil or requirements.MaxPlayerArc ~= nil then
			local arcDistance = CalcArcDistance( GetAngle({ Id = enemy.ObjectId }), GetAngleBetween({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) )
			
			if requirements.MinPlayerArc ~= nil and arcDistance < requirements.MinPlayerArc then
				return false
			end

			if requirements.MaxPlayerArc ~= nil and arcDistance > requirements.MaxPlayerArc then
				return false
			end
		end

		if requirements.MaxPlayerDistance ~= nil then
			local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			if distanceToPlayer > requirements.MaxPlayerDistance then
				return false
			end
		end

		if requirements.MinPlayerDistance ~= nil then
			local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			if distanceToPlayer < requirements.MinPlayerDistance then
				return false
			end
		end

		if requirements.RequiresPlayerHasEffect ~= nil and not HasEffect({ Id = CurrentRun.Hero.ObjectId, EffectName = requirements.RequiresPlayerHasEffect }) then
			return false
		end

		if requirements.RequiresPlayerFalseHasEffect ~= nil and HasEffect({ Id = CurrentRun.Hero.ObjectId, EffectName = requirements.RequiresPlayerFalseHasEffect }) then
			return false
		end

		if requirements.MaxActiveSpawns ~= nil then
			local spawnGroupName = requirements.SpawnGroupName or "Spawner"..enemy.ObjectId
			local activeSpawns = GetIds({ Name = spawnGroupName })
			if activeSpawns ~= nil and TableLength(activeSpawns) >= requirements.MaxActiveSpawns then
				return false
			end
		end

		local playerHealthPercent = CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth
		if requirements.PlayerHealthPercentMax ~= nil and playerHealthPercent > requirements.PlayerHealthPercentMax then
			return false
		end
		if requirements.PlayerHealthPercentMin ~= nil and playerHealthPercent < requirements.PlayerHealthPercentMin then
			return false
		end

		if requirements.RequiresMinions and enemy.MinionIds == nil then 
			return false
		end

		if requirements.RequiresNotLeader and enemy.MinionIds ~= nil then
			return false
		end

		if requirements.RequiresNoLeader and enemy.LeaderId ~= nil then
			return false
		end

		if requirements.RequireComboPartner and (enemy.ComboPartnerId == 0 or ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead) then
			return false
		end

		if requirements.MinDistanceFromComboPartner ~= nil and enemy.ComboPartnerId ~= 0 then
			local distanceToComboPartner = GetDistance({ Id = enemy.ObjectId, DestinationId = enemy.ComboPartnerId })
			if distanceToComboPartner < requirements.MinDistanceFromComboPartner then
				return false
			end
		end

		if requirements.MaxDistanceFromComboPartner ~= nil and enemy.ComboPartnerId ~= 0 then
			local distanceToComboPartner = GetDistance({ Id = enemy.ObjectId, DestinationId = enemy.ComboPartnerId })
			if distanceToComboPartner > requirements.MaxDistanceFromComboPartner then
				return false
			end
		end

		if requirements.RequireComboPartnerNotifyName ~= nil and enemy.ComboPartnerId ~= 0 then
			if ActiveEnemies[enemy.ComboPartnerId] ~= nil and not ActiveEnemies[enemy.ComboPartnerId].IsDead and ActiveEnemies[enemy.ComboPartnerId].AINotifyName ~= requirements.RequireComboPartnerNotifyName then
				return false
			end
		end

		if requirements.RequiredEquipment ~= nil then
			for k, requiredEquipment in pairs(requirements.RequiredEquipment) do
				if not Contains(enemy.Equipment, requiredEquipment) then
					return false
				end
			end
		end

		if requirements.RequireExistingIdsOfType ~= nil and #GetIdsByType({ Name = requirements.RequireExistingIdsOfType }) <= 0 then
			return false
		end

		if requirements.RequireExistingIdsOfTypes ~= nil and #GetIdsByType({ Names = requirements.RequireExistingIdsOfTypes }) <= 0 then
			return false
		end

		if requirements.RequireNumIdsOfType ~= nil and #GetIdsByType({ Name = requirements.RequireNumIdsOfType.Name }) == requirements.RequireNumIdsOfType.Count then
			return false
		end

		if requirements.RequireMaxIdsOfType ~= nil and #GetIdsByType({ Name = requirements.RequireMaxIdsOfType.Name }) >= requirements.RequireMaxIdsOfType.Count then
			return false
		end

		if requirements.RequireMinIdsOfType ~= nil and #GetIdsByType({ Name = requirements.RequireMinIdsOfType.Name }) >= requirements.RequireMinIdsOfType.Count then
			return false
		end

		if requirements.RequireOneOfTypesWithinAttackDistance ~= nil then
			local closestOfTypes = GetClosest({ Id = enemy.ObjectId, DestinationIds = GetIdsByType({ Names = requirements.RequireOneOfTypesWithinAttackDistance }) })
			
			if closestOfTypes == nil then
				return false
			end
			if GetDistance({ Id = enemy.ObjectId, DestinationId = closestOfTypes }) > weaponData.AIData.AttackDistance then
				return false
			end
		end

		if weaponData.Requirements ~= nil and (weaponData.Requirements.RequireProjectileLoS or weaponData.Requirements.RequireUnitLoS) then
			local hasLoS = HasLineOfSight({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId,
							StopsUnits = weaponData.Requirements.RequireUnitLoS, StopsProjectiles = weaponData.Requirements.RequireProjectileLoS,
							LineOfSightBuffer = weaponData.Requirements.LoSBuffer,
							LineOfSightEndBuffer = weaponData.Requirements.LoSEndBuffer,  })
			if not hasLoS then
				return false
			end
		end

	end

	if weaponData.GameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, weaponData.GameStateRequirements ) then
		return false
	end

	return true
end

function IsEnemyWeaponForced( enemy, weaponName )
	if WeaponData[weaponName] == nil or WeaponData[weaponName].AIData == nil then
		return false
	end

	local aiData = WeaponData[weaponName].AIData

	if aiData.ForceFirst and #enemy.WeaponHistory == 0 then
		return true
	end


	if aiData.ForceWithinPlayerDistance ~= nil then
		local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		if distanceToPlayer < aiData.ForceWithinPlayerDistance then
			return true
		end
	end

	if aiData.ForceIfComboPartnerNotifyName ~= nil then
		if ActiveEnemies[enemy.ComboPartnerId] ~= nil and not ActiveEnemies[enemy.ComboPartnerId].IsDead and ActiveEnemies[enemy.ComboPartnerId].AINotifyName == aiData.ForceIfComboPartnerNotifyName then
			return true
		end
	end

	if aiData.ForceUnderHealthPercent and enemy.Health / enemy.MaxHealth <= aiData.ForceUnderHealthPercent then
		return true
	end

	if aiData.ForceOverHealthPercent and enemy.Health / enemy.MaxHealth > aiData.ForceUnderHealthPercent then
		return true
	end

	if aiData.ForceIfTypeExists ~= nil and #GetIdsByType({ Name = aiData.ForceIfTypeExists }) > 0 then
		return true
	end

	if aiData.ForceUseIfReady and IsEnemyWeaponEligible( enemy, WeaponData[weaponName] ) then
		return true
	end

	return false
end

function IsEnemyProjectileEligible(enemy, projectileData)
	if projectileData.MaxPlayerDistance ~= nil then
		local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		if distanceToPlayer > projectileData.MaxPlayerDistance then
			return false
		end
	end

	if projectileData.MinPlayerDistance ~= nil then
		local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		if distanceToPlayer < projectileData.MinPlayerDistance then
			return false
		end
	end

	if projectileData.GameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, enemy, projectileData.GameStateRequirements ) then
		return false
	end

	return true
end

function MoveWithinRange( enemy, moveTargetId, aiData )
	if aiData == nil then
		aiData = enemy
	end

	local attackDistance = aiData.AttackDistance or 900

	if aiData.AttackDistanceBuffer ~= nil then
		attackDistance = attackDistance - aiData.AttackDistanceBuffer
	end

	-- Pre Move
	if aiData.PreMoveAngleTowardTarget then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = moveTargetId })
	end
	if aiData.PreMoveAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreMoveAnimation })
	end
	if aiData.PreMoveFx ~= nil then
		CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreMoveFx })
	end
	if aiData.PreMoveRemoveEnemyUI then
		RemoveEnemyUI( enemy )
	end
	if WeaponData[aiData.WeaponName] ~= nil and WeaponData[aiData.WeaponName].Sounds ~= nil and WeaponData[aiData.WeaponName].Sounds.PreMoveSounds ~= nil then
		DoWeaponSounds( WeaponData[aiData.WeaponName].Sounds.PreMoveSounds, enemy, WeaponData[aiData.WeaponName] )
	end
	AIWait(aiData.PreMoveDuration, enemy, aiData.AIThreadName or enemy.AIThreadName)

	if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
		aiData.ForcedEarlyExit = true
		return true
	end

	if aiData.ApplyEffectsOnMove ~= nil then
		for k, effectData in pairs(aiData.ApplyEffectsOnMove) do
			effectData.Id = enemy.ObjectId
			effectData.DestinationId = enemy.ObjectId
			ApplyEffect(effectData)
			if effectData.ClearEffectOnHit then
				table.insert(enemy.ClearEffectsOnHitStun, effectData.EffectName)
			end
		end
	end

	local defaultStopGraphic = nil
	if aiData.SetStopGraphicOnMove ~= nil then
		defaultStopGraphic = GetUnitDataValue({ Id = enemy.ObjectId, Property = "StopGraphic" })
		SetUnitProperty({ Property = "StopGraphic", Value = aiData.SetStopGraphicOnMove, DestinationId = enemy.ObjectId })
	end

	if aiData.MoveDumbFireWeapons ~= nil then
		for k, weaponName in pairs( aiData.MoveDumbFireWeapons ) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, enemy, weaponData )
		end
	end

	if aiData.SpawnBurstOnMove then
		thread(HandleSpawnerBurst, enemy, aiData)
	end

	local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = moveTargetId }) 

	-- Dash
	if aiData.DashIfOverDistance ~= nil then
		if distanceToTarget > attackDistance and aiData.DashIfOverDistance < distanceToTarget then
			enemy.WeaponName = aiData.DashWeapon
			local dashWeaponAIData = GetWeaponAIData(enemy)
			dashWeaponAIData.TargetId = aiData.TargetId

			DoAttack( enemy, dashWeaponAIData )
			enemy.WeaponName = aiData.WeaponName
		end
	end

	-- If already within range
	if distanceToTarget <= attackDistance then
		if aiData.WithinRangeWander then
			MoveToRandomLocation( enemy, enemy.ObjectId, aiData.WithinRangeWanderDistance or 100, aiData.WithinRangeWanderDistanceMin or 0, aiData.WithinRangeWanderDuration )
		end
		if aiData.AttackDistanceMin ~= nil and aiData.AttackDistanceMin > distanceToTarget then
			Retreat(enemy, aiData, moveTargetId)
		end

		-- Skip Move() call if we are going to stop right away anyway
		if aiData.StopMoveWithinRange then
			local hasLoS = HasLineOfSight({ Id = enemy.ObjectId, DestinationId = aiData.TargetId,
							StopsUnits = aiData.RequireUnitLoS, StopsProjectiles = aiData.RequireProjectileLoS,
							LineOfSightBuffer = aiData.LoSBuffer,
							LineOfSightEndBuffer = aiData.LoSEndBuffer,  })
			if hasLoS then
				if IsCharmed({ Id = enemy.ObjectId }) then
					DebugPrint({ Text="HAS LOS" })
				end
				return false
			end
		end
	end

	if aiData.MoveAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.MoveAnimation })
	end

	-- Move to target
	Move({ Id = enemy.ObjectId, DestinationId = moveTargetId,
			SuccessDistance = aiData.MoveSuccessDistance or 100, LookAheadMultiplier = enemy.LookAheadMultiplier, TrackAtPathEnd = aiData.TrackAtPathEnd,
			LiveOffsetFromId = enemy.ObjectId, LiveOffsetDistance = aiData.LiveOffsetDistance, LiveOffsetAngle = aiData.LiveOffsetAngle or 180 })

	-- Wait until within attack range
	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	local timeout = aiData.MoveWithinRangeTimeout
	if timeout == nil and aiData.MoveWithinRangeTimeoutMin ~= nil and aiData.MoveWithinRangeTimeoutMax ~= nil then
		timeout = RandomFloat(aiData.MoveWithinRangeTimeoutMin, aiData.MoveWithinRangeTimeoutMax)
	end
	if timeout ~= nil and enemy.SpeedMultiplier ~= nil then
		timeout = timeout / enemy.SpeedMultiplier
	end
	
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = moveTargetId, Distance = attackDistance, ScaleY = aiData.AttackDistanceScaleY,
		StopsUnits = aiData.RequireUnitLoS, StopsProjectiles = aiData.RequireProjectileLoS,
		LineOfSightBuffer = aiData.LoSBuffer,
		LineOfSightEndBuffer = aiData.LoSEndBuffer,
		Notify = enemy.AINotifyName, Timeout = timeout or 9.0 })

	waitUntil( enemy.AINotifyName, enemy.AIThreadName )

	local didTimeout = _eventTimeoutRecord[enemy.AINotifyName]
	if didTimeout then
		enemy.LookAheadMultiplier = math.min( (enemy.LookAheadMultiplier or 1.0) + 0.5, 3.0 )
	else
		enemy.LookAheadMultiplier = 1.0
	end

	if aiData.StopMoveWithinRange then
		Stop({ Id = enemy.ObjectId })
	end

	if aiData.ApplyEffectsOnMove ~= nil and not aiData.SkipClearEffectsOnMoveEnd then
		for k, effectData in pairs(aiData.ApplyEffectsOnMove) do
			ClearEffect({ Id = enemy.ObjectId, Name = effectData.EffectName })
		end
	end
	if aiData.SetStopGraphicOnMove ~= nil then
		SetUnitProperty({ Property = "StopGraphic", Value = defaultStopGraphic, DestinationId = enemy.ObjectId })
	end

	return didTimeout
end

function Retreat( enemy, aiData, retreatFromId )

	if aiData.DontRetreatIfCharmed and IsCharmed({ Id = enemy.ObjectId }) then
		return
	end

	if aiData.RetreatGameStateRequirements ~= nil and not IsGameStateEligible(CurrentRun, enemy, aiData.RetreatGameStateRequirements) then
		return
	end

	local distanceBetween = GetDistance({ Id = enemy.ObjectId, DestinationId = retreatFromId })
	local retreatDistance = aiData.RetreatBufferDistance - distanceBetween
	local angleBetween = GetAngleBetween({ Id = retreatFromId, DestinationId = enemy.ObjectId})
	local retreatAngle = angleBetween + RandomFloat(-0.5, 0.5)
	local retreatOffset = CalcOffset( math.rad(retreatAngle), retreatDistance)

	local retreatProximity = 100 -- Not important to stop at the retreat point precisely
	if retreatDistance <= retreatProximity then
		return
	end

	local tempTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = retreatOffset.X, OffsetY = retreatOffset.Y, Group = "Standing" })
	local moveToId = tempTarget
	if aiData.RetreatToId then
		moveToId = aiData.RetreatToId
	elseif aiData.RetreatToSpawnPoints then
		local spawnNearId = tempTarget
		if aiData.RetreatToSpawnPointFromSelf then
			spawnNearId = enemy.ObjectId
		end
		moveToId = SelectSpawnPoint(CurrentRun.CurrentRoom, { Name = aiData.Name, RequiredSpawnPoint = aiData.RetreatToSpawnPointType }, { SpawnNearId = spawnNearId, SpawnRadius = aiData.RetreatToSpawnPointRadius or 500, SpawnRadiusMin = aiData.RetreatToSpawnPointRadiusMin } )
		--moveToId = GetClosest({ Id = tempTarget, DestinationName = "SpawnPoints" })
	end

	-- Dash
	if aiData.DashIfOverDistance ~= nil then
		local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = moveToId })
		if distanceToTarget > aiData.DashIfOverDistance then
			AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = moveToId })
			enemy.AINotifyName = "WaitForRotation"..enemy.ObjectId
			NotifyOnRotationComplete({ Id = enemy.ObjectId, Cosmetic = true, Notify = enemy.AINotifyName, Timeout = 2.0 })
			waitUntil( enemy.AINotifyName )
			wait(0.5)

			enemy.WeaponName = aiData.DashWeapon
			local dashWeaponAIData = GetWeaponAIData(enemy)
			dashWeaponAIData.TargetId = aiData.TargetId

			DoAttack( enemy, dashWeaponAIData )
			enemy.WeaponName = aiData.WeaponName
		end
	end

	Move({ Id = enemy.ObjectId, DestinationId = moveToId, SuccessDistance = retreatProximity })

	-- Wait until within range
	local timeout = aiData.RetreatTimeout
	if timeout == nil and aiData.RetreatTimeoutMin ~= nil and aiData.RetreatTimeoutMax ~= nil then
		timeout = RandomFloat(aiData.RetreatTimeoutMin, aiData.RetreatTimeoutMax)
	end

	local retreatStartTime = _worldTime
	local retreatDuration = aiData.RetreatDuration or 0
	if retreatDuration == 0 and aiData.RetreatDurationMin ~= nil and aiData.RetreatDurationMax ~= nil then
		retreatDuration = RandomFloat(aiData.RetreatDurationMin, aiData.RetreatDurationMax)
	end
	local retreatEndTime = _worldTime + retreatDuration

	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = moveToId, Distance = retreatProximity + 20, Notify = enemy.AINotifyName, Timeout = timeout or 5.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )

	Stop({ Id = enemy.ObjectId })

	if aiData.RetreatSetAngle then
		SetGoalAngle({ Id = enemy.ObjectId, Angle = aiData.RetreatSetAngle })
	end

	Destroy({ Id = tempTarget })

	if aiData.RetreatWaitDuration then
		AIWait( aiData.RetreatWaitDuration, enemy, aiData.AIThreadName or enemy.AIThreadName )
	end

	if _worldTime < retreatEndTime then
		Track({ Ids =  { enemy.ObjectId }, DestinationIds = { aiData.TargetId } })
		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, Distance = aiData.AttackDistance, Notify = enemy.AINotifyName, Timeout = retreatEndTime - _worldTime })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )
	end
end

function DoAttack( enemy, aiData )

	if aiData == nil then
		aiData = enemy
	end

	if aiData.MinionWeapon and enemy.MinionIds ~= nil then
		thread(HandleMinionWeapons, enemy, aiData)
	end

	aiData.TargetId = aiData.TargetId or CurrentRun.Hero.ObjectId
	aiData.LastTargetId = aiData.TargetId

	-- PRE ATTACK
	if aiData.PreAttackSetInvulnerable then
		SetUnitInvulnerable( enemy )
	end

	if aiData.PreAttackStop then
		Stop({ Id = enemy.ObjectId })
	end
	if aiData.PreAttackStartWait ~= nil then
		AIWait(aiData.PreAttackStartWait, enemy, aiData.AIThreadName or enemy.AIThreadName)
	end
	if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
		return false
	end

	local preAttackDuration = aiData.PreAttackDuration or 0.5
	if aiData.PreAttackDuration == nil and aiData.PreAttackDurationMin ~= nil and aiData.PreAttackDurationMax ~= nil then
		preAttackDuration = RandomFloat(aiData.PreAttackDurationMin, aiData.PreAttackDurationMax)
	end

	local preAttackEndDuration = aiData.PreAttackEndDuration or math.min(0.5, preAttackDuration)
	local preAttackStartDuration = math.max(preAttackDuration - preAttackEndDuration, 0)

	if aiData.TrackKillSteal then
		CurrentRun.Hero.KillStolenFromId = enemy.ObjectId
		CurrentRun.Hero.KillStealVictimId = aiData.TargetId
	end

	if aiData.PreAttackAngleTowardTarget then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })

		if aiData.WaitForAngleTowardTarget then
			enemy.AINotifyName = "WaitForRotation"..enemy.ObjectId
			NotifyOnRotationComplete({ Id = enemy.ObjectId, Cosmetic = true, Notify = enemy.AINotifyName, Timeout = aiData.WaitForAngleTowardTargetTimeOut or 9.0 })
			waitUntil( enemy.AINotifyName )

			if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
				return false
			end
		end
	end

	if aiData.PreAttackSelfVelocity then
		ApplyForce({ Id = enemy.ObjectId, Speed = aiData.PreAttackSelfVelocity, Angle = GetAngle({ Id = enemy.ObjectId }) + (aiData.PreAttackSelfVelocityAngleOffset or 0), SelfApplied = true })
	end

	if aiData.PreAttackSelfUpwardVelocity then
		ApplyUpwardForce({ Id = enemy.ObjectId, Speed = aiData.PreAttackSelfUpwardVelocity })
	end

	if aiData.PreAttackSetZHeight ~= nil then
		AdjustZLocation({ Id = enemy.ObjectId, Distance = aiData.PreAttackSetZHeight - GetZLocation({ Id = enemy.ObjectId }), Duration = aiData.PreAttackSetZDuration or 0 })
	end

	if aiData.PreAttackSound ~= nil then
		local soundId = PlaySound({ Name = aiData.PreAttackSound, Id = enemy.ObjectId, ManagerCap = aiData.SoundManagerCap or 46 })
		table.insert(enemy.StopSoundsOnHitStun, soundId)
	end
	if aiData.PreAttackLowPass then
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 1.0 })
	end
	if aiData.ProjectileName ~= nil and WeaponData[aiData.WeaponName].Sounds ~= nil and WeaponData[aiData.WeaponName].Sounds.ChargeSounds ~= nil then
		DoWeaponSounds( WeaponData[aiData.WeaponName].Sounds.ChargeSounds, enemy, WeaponData[aiData.WeaponName] )
	end
	if aiData.PreAttackLoopingSound ~= nil then
		if enemy.PreAttackLoopingSoundId ~= nil then
			StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
			enemy.PreAttackLoopingSoundId = nil
		end
		enemy.PreAttackLoopingSoundId = PlaySound({ Name = aiData.PreAttackLoopingSound, Id = enemy.ObjectId })
	end

	if aiData.PreAttackVoiceLines ~= nil then
		thread( PlayVoiceLines, aiData.PreAttackVoiceLines, nil, enemy )
	end

	if aiData.PreAttackStopAnimations ~= nil then
		StopAnimation({ DestinationId = enemy.ObjectId, Names = aiData.PreAttackStopAnimations, PreventChain = true, })
	end
	if aiData.PreAttackAlpha ~= nil then
		SetAlpha({ Id = enemy.ObjectId, Fraction = aiData.PreAttackAlpha })
	end
	if aiData.PreAttackAnimation then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackAnimation, SpeedMultiplier = aiData.PreAttackAnimationSpeed or 1.0 })
	end
	if aiData.PreAttackFx ~= nil then
		CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFx })
		table.insert(enemy.StopAnimationsOnHitStun, aiData.PreAttackFx)
	end
	if aiData.PreAttackMultiFx ~= nil then
		for k, name in pairs(aiData.PreAttackMultiFx) do
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = name })
			table.insert(enemy.StopAnimationsOnHitStun, name)
		end
	end
	if aiData.PreAttackFxBetween ~= nil then
		CreateAnimationsBetween({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, Animation = aiData.PreAttackFxBetween, Stretch = true, MaintainStretch = aiData.PreAttackFxMaintainStretch, UseZLocation = false, Group = "FX_Standing_Add" })
		table.insert(enemy.StopAnimationsOnHitStun, aiData.PreAttackFxBetween)
	end
	if aiData.PreAttackFxAtTarget then
		CreateAnimation({ DestinationId = aiData.TargetId, Name = aiData.PreAttackFxAtTarget })
	end
	if aiData.PreAttackMultiFxAtTarget ~= nil then
		for k, name in pairs(aiData.PreAttackMultiFxAtTarget) do
			CreateAnimation({ DestinationId = aiData.TargetId, Name = name })
		end
	end

	if aiData.PreAttackFxAtProjectileStartLocation then
		local angle = GetAngleBetween({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
		local offset = CalcOffset( math.rad(angle), aiData.BarrelLength )
		local offsetPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
		CreateAnimation({ DestinationId = offsetPoint, Name = aiData.PreAttackFxAtProjectileStartLocation })
		table.insert(enemy.StopAnimationsOnHitStun, aiData.PreAttackFxAtProjectileStartLocation)
	end
	
	local weaponData = WeaponData[aiData.WeaponName]
	if weaponData ~= nil then
		thread( DoWeaponScreenshake, weaponData, "ChargeScreenshake", { AttackerId = enemy.ObjectId, SourceProjectile = aiData.ProjectileName })
	end


	enemy.AttackWarningDestinationId = enemy.ObjectId
	if aiData.AttackWarningAnimation ~= nil then
		if aiData.AttackWarningAtTargetLocation then
			enemy.AttackWarningDestinationId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = aiData.TargetId })
		end
		CreateAnimation({ Name = aiData.AttackWarningAnimation, DestinationId = enemy.AttackWarningDestinationId, ScaleRadius = aiData.AttackWarningAnimationRadius })
	end

	if enemy.TetherIds ~= nil then
		for k, tetherId in ipairs( enemy.TetherIds ) do
			if enemy.Tethers[k] ~= nil and enemy.Tethers[k].OwnerPreAttackVelocity ~= nil then
				local angleToTarget = GetAngleBetween({ Id = tetherId, DestinationIds = { enemy.ObjectId, aiData.TargetId } })
				ApplyForce({ Id = tetherId, Speed = enemy.Tethers[k].OwnerPreAttackVelocity, Angle = angleToTarget })
			end
		end
	end

	if aiData.PreAttackFunctionName ~= nil then
		CallFunctionName( aiData.PreAttackFunctionName, enemy, aiData, CurrentRun, aiData.PreAttackFunctionArgs)
	end
	if aiData.PreAttackThreadedFunctionName ~= nil then
		thread(CallFunctionName, aiData.PreAttackThreadedFunctionName, enemy, aiData, CurrentRun, aiData.PreAttackThreadedFunctionArgs)
	end

	if aiData.PreAttackDumbFireWeapons ~= nil then
		for k, weaponName in pairs( aiData.PreAttackDumbFireWeapons ) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, enemy, weaponData )
		end
	end

	if aiData.PreAttackRandomDumbFireWeapon ~= nil then
		local weaponName = GetRandomValue(aiData.PreAttackRandomDumbFireWeapon)
		local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
		weaponData.Name = weaponName
		thread( DumbFireAttack, enemy, weaponData )
	end

	if aiData.SetDumbFireThreadWait ~= nil then
		SetThreadWait(enemy.DumbFireThreadName, aiData.SetDumbFireThreadWait)
	end

	if aiData.ExpireProjectilesOnPreAttackStart then
		ExpireProjectiles({ Names = aiData.ExpireProjectilesOnPreAttackStart })
	end

	if aiData.SpawnBurstOnPreAttackStart then
		thread(HandleSpawnerBurst, enemy, aiData)
	end

	if aiData.AIChargeTargetMarker then
		CreateTargetMarker( enemy, aiData )
	end

	if aiData.TrackTargetDuringCharge then
		Track({ Ids = { enemy.ObjectId }, DestinationIds = { aiData.TargetId } })
	end

	if aiData.PreAttackRotationDampening ~= nil then
		local dampenEffect = { Id = enemy.ObjectId, DestinationId = enemy.ObjectId, EffectName = enemy.Name .. "PreAttackRotationDampening" }
		dampenEffect.DataProperties = { Duration = preAttackDuration, RotationMultiplier = aiData.PreAttackRotationDampening, TimeModifierFraction = 1 }
		ApplyEffect(dampenEffect)
		table.insert(enemy.ClearEffectsOnHitStun, dampenEffect.EffectName)
	end

	if aiData.ApplyEffectsOnPreAttackStart ~= nil then
		for k, effectData in pairs(aiData.ApplyEffectsOnPreAttackStart) do
			effectData.Id = enemy.ObjectId
			effectData.DestinationId = enemy.ObjectId
			if effectData.DataProperties and not effectData.DataProperties.TimeModifierFraction then
				effectData.DataProperties.TimeModifierFraction = 1
			end
			ApplyEffect(effectData)
			if effectData.ClearEffectOnHit then
				table.insert(enemy.ClearEffectsOnHitStun, effectData.EffectName)
			end
		end
	end

	if aiData.CancelIfTargetIsDead and ActiveEnemies[aiData.TargetId] ~= nil then
		ActiveEnemies[aiData.TargetId].EndThreadNameWaitOnDeath = aiData.AIThreadName or enemy.AIThreadName
	end

	if aiData.WaitDurationForComboPartnerMove ~= nil then
		if ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead then
			aiData.ForcedEarlyExit = true
			return false
		end

		enemy.WaitingForPartner = true
		wait( aiData.WaitDurationForComboPartnerMove, aiData.AIThreadName or enemy.AIThreadName )
		enemy.WaitingForPartner = false

		if ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead then
			aiData.ForcedEarlyExit = true
			return false
		end
	end

	if aiData.PreAttackWaitForAnimation and aiData.PreAttackAnimation ~= nil then
		enemy.AINotifyName = "PreAttackWaitForAnimation"..enemy.ObjectId
		NotifyOnAnimationTimeRemaining({ Id = enemy.ObjectId, Animation = aiData.PreAttackAnimation, Remaining = preAttackEndDuration + 0.01, Notify = enemy.AINotifyName, Timeout = 9.0 })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )
	else
		AIWait(preAttackStartDuration, enemy, aiData.AIThreadName or enemy.AIThreadName,  { MinWaitTime = aiData.PreAttackStartMinWaitTime })
	end
	
	if aiData.CancelIfTargetIsDead and ActiveEnemies[aiData.TargetId] ~= nil then
		ActiveEnemies[aiData.TargetId].EndThreadNameWaitOnDeath = nil
	end

	if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt)  then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
		aiData.ForcedEarlyExit = true
		if enemy.PreAttackLoopingSoundId ~= nil then
			StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
			enemy.PreAttackLoopingSoundId = nil
		end
		return true
	end

	if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
		aiData.ForcedEarlyExit = true
		if aiData.EndPreAttackFx then
			if aiData.PreAttackFx ~= nil then
				StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFx })
			end
			if aiData.PreAttackMultiFx ~= nil then
				for k, name in pairs(aiData.PreAttackMultiFx) do
					StopAnimation({ DestinationId = enemy.ObjectId, Name = name })
				end
			end
			if aiData.PreAttackFxBetween ~= nil then
				StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFxBetween })
			end
			if aiData.PreAttackFxAtTarget ~= nil then
				StopAnimation({ DestinationId = aiData.TargetId, Name = aiData.PreAttackFxAtTarget })
			end
			if aiData.PreAttackMultiFxAtTarget ~= nil then
				for k, name in pairs( aiData.PreAttackMultiFxAtTarget ) do
					StopAnimation({ DestinationId = aiData.TargetId, Name = name })
				end
			end
		end
		return true
	end

	-- PRE ATTACK END
	if aiData.PreAttackEndStop then
		Stop({ Id = enemy.ObjectId })
	end
	if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
		return false
	end

	if aiData.PreAttackFlashSound ~= nil then
		PlaySound({ Name = aiData.PreAttackFlashSound, Id = enemy.ObjectId, ManagerCap = aiData.SoundManagerCap })
	end
	if aiData.PreAttackEndShake then
		Shake({ Id = enemy.ObjectId, Speed = 400, Distance = 3, Duration = preAttackEndDuration })
		Flash({ Id = enemy.ObjectId, Speed = 1, MinFraction = 0, MaxFraction = aiData.PreAttackEndFlashFraction or 0.95, Color = Color.White, Duration = preAttackEndDuration })
	end
	if aiData.PreAttackEndShakeSound ~= nil then
		PlaySound({ Name = aiData.PreAttackEndShakeSound, Id = enemy.ObjectId, ManagerCap = aiData.SoundManagerCap })
	end

	if aiData.SpawnBurstOnPreAttackEnd then
		thread(HandleSpawnerBurst, enemy, aiData)
	end

	if aiData.PreAttackEndFunctionName ~= nil then
		CallFunctionName( aiData.PreAttackEndFunctionName, enemy, aiData, aiData.PreAttackEndFunctionArgs )
	end

	if aiData.CancelIfTargetIsDead and ActiveEnemies[aiData.TargetId] ~= nil then
		ActiveEnemies[aiData.TargetId].EndThreadNameWaitOnDeath = aiData.AIThreadName or enemy.AIThreadName
	end

	--DebugPrint({ Text=enemy.WeaponName.." preAttackEndDuration: "..CalcEnemyWait( enemy, preAttackEndDuration ) })
	AIWait(preAttackEndDuration, enemy, aiData.AIThreadName or enemy.AIThreadName,  { MinWaitTime = aiData.PreAttackEndMinWaitTime })

	if aiData.CancelIfTargetIsDead and ActiveEnemies[aiData.TargetId] ~= nil then
		ActiveEnemies[aiData.TargetId].EndThreadNameWaitOnDeath = nil
	end

	if aiData.StopBeforeFire then
		Stop({ Id = enemy.ObjectId })
	end

	if aiData.PreAttackLowPass then
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 0.0, Duration = 1.0 })
	end

	if aiData.EndPreAttackFx then
		if aiData.PreAttackFx ~= nil then
			StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFx })
		end
		if aiData.PreAttackMultiFx ~= nil then
			for k, name in pairs( aiData.PreAttackMultiFx ) do
				StopAnimation({ DestinationId = enemy.ObjectId, Name = name })
			end
		end
		if aiData.PreAttackFxBetween ~= nil then
			StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFxBetween })
		end
		if aiData.PreAttackFxAtTarget ~= nil then
			StopAnimation({ DestinationId = aiData.TargetId, Name = aiData.PreAttackFxAtTarget })
		end
		if aiData.PreAttackMultiFxAtTarget ~= nil then
			for k, name in pairs( aiData.PreAttackMultiFxAtTarget ) do
				StopAnimation({ DestinationId = aiData.TargetId, Name = name })
			end
		end
	end

	if aiData.AttackWarningAnimation ~= nil then
		StopAnimation({ Name = aiData.AttackWarningAnimation, DestinationId = enemy.AttackWarningDestinationId })
	end

	if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
		return false
	end

	if aiData.PreAttackEndSwapWeapon ~= nil then
		local swapToWeaponName = GetRandomValue(aiData.PreAttackEndSwapWeapon)

		enemy.WeaponName = swapToWeaponName
		table.insert( enemy.WeaponHistory, enemy.WeaponName )
		aiData = GetWeaponAIData(enemy)
	end

	if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt) then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
		return true
	end

	if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
		aiData.ForcedEarlyExit = true
		return true
	end

	if aiData.FireProjectileAtTarget and not IsAlive({ Id = aiData.TargetId }) then
		DebugPrint({ Text=enemy.Name.."'s TargetId is dead! Aborting weapon." })
		aiData.DoNotRepeatOnAttackFail = true
		return false
	end

	if aiData.CancelIfTargetIsDead and aiData.TargetId ~= CurrentRun.Hero.ObjectId and ActiveEnemies[aiData.TargetId] == nil then
		DebugPrint({ Text=enemy.Name.."'s TargetId is dead! Aborting weapon." })
		aiData.DoNotRepeatOnAttackFail = true
		return false
	end

	-- CONDITIONAL WEAPONS
	if aiData.ConditionalWeaponFire ~= nil then
		local eligibleWeaponFires = {}
		for k, weaponData in pairs(aiData.ConditionalWeaponFire) do
			if IsEnemyWeaponEligible(enemy, weaponData) then
				table.insert(eligibleWeaponFires, weaponData.WeaponName)
			end
		end
		if not IsEmpty(eligibleWeaponFires) then
			local selectedWeaponName = GetRandomValue(eligibleWeaponFires)

			enemy.WeaponName = selectedWeaponName
			table.insert(enemy.WeaponHistory, enemy.WeaponName)
			OverwriteTableKeys(aiData, GetWeaponAIData(enemy))
		end
	end

	-- ATTACK
	if aiData.ThreadFunctionName ~= nil then
		thread(CallFunctionName, aiData.ThreadFunctionName, enemy, aiData, CurrentRun)
	end
	if aiData.FireStartFunctionName ~= nil then
		CallFunctionName( aiData.FireStartFunctionName, enemy, aiData, CurrentRun, aiData.FireStartFunctionArgs )
	end

	if aiData.SpawnBurstOnFire then
		thread(HandleSpawnerBurst, enemy, aiData)
	end

	if aiData.RageDumbFireWeapons ~= nil and enemy.Enraged then
		for k, weaponName in pairs( aiData.RageDumbFireWeapons ) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, enemy, weaponData )
		end
	end

	if aiData.DumbFireWeapons ~= nil then
		for k, weaponName in pairs( aiData.DumbFireWeapons ) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, enemy, weaponData )
		end
	end

	if aiData.RandomSpawnEncounter ~= nil and aiData.SpawnEncounter == nil then
		aiData.SpawnEncounter = GetRandomValue(aiData.RandomSpawnEncounter)
	end

	if aiData.SpawnEncounter ~= nil then
		local encounter = DeepCopyTable( EncounterData[aiData.SpawnEncounter] )
		if encounter.Generated then
			GenerateEncounter(CurrentRun, CurrentRun.CurrentRoom, encounter)
		end
		enemy.SpawnedEncounter = encounter
		if encounter.StartGlobalVoiceLines ~= nil then
			thread( PlayVoiceLines, GlobalVoiceLines[encounter.StartGlobalVoiceLines] )
		end
		thread( StartEncounter, CurrentRun, CurrentRun.CurrentRoom, encounter )
	end

	if aiData.ApplyEffectsToAllies ~= nil then
		for k, effectData in pairs(aiData.ApplyEffectsToAllies) do
			effectData.Id = enemy.ObjectId
			effectData.DestinationIds = GetAllAllyIds(enemy)
			ApplyEffect(effectData)
		end
	end

	if aiData.ClearAllEffects then
		ClearEffect({ Id = enemy.ObjectId, All = true })
	end

	if aiData.SetUntargetable then
		SetUntargetable({ Id = enemy.ObjectId })
	end

	if aiData.SetTargetable then
		SetTargetable({ Id = enemy.ObjectId })
	end

	if aiData.SetMapFlags ~= nil then
		for k, flagData in pairs(aiData.SetMapFlags) do
			flagData.Id = enemy.ObjectId
			thread(SetMapFlag, flagData)
		end
	end

	if aiData.FireMoveTowardTarget then
		Move({ Id = enemy.ObjectId, DestinationId = aiData.TargetId,
			SuccessDistance = aiData.MoveSuccessDistance or 100, LookAheadMultiplier = enemy.LookAheadMultiplier, TrackAtPathEnd = aiData.TrackAtPathEnd,
			LiveOffsetFromId = enemy.ObjectId, LiveOffsetDistance = aiData.LiveOffsetDistance, LiveOffsetAngle = aiData.LiveOffsetDistance or 180 })
	end

	if aiData.FireCreateHealthBar then
		CreateHealthBar( enemy )
		RecreateEffectVfx( enemy )
		thread( UpdateHealthBar, enemy, 0, { Force = true } )
		for activeEffectName, stacks in pairs( enemy.ActiveEffects ) do
			UpdateEffectStacks( enemy, activeEffectName )
		end
	end

	if not aiData.SkipFireWeapon then
		if not AIFireWeapon( enemy, aiData ) then
			return false
		end
	end

	if aiData.AIChargeTargetMarker then
		FinishTargetMarker( enemy )
	end

	if aiData.FireFunctionName ~= nil then
		CallFunctionName( aiData.FireFunctionName, enemy, aiData, CurrentRun, aiData.FireFunctionArgs )
	end

	if aiData.PostAttackDumbFireWeapons ~= nil then
		for k, weaponName in pairs( aiData.PostAttackDumbFireWeapons ) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, enemy, weaponData )
		end
	end

	if aiData.UnequipWeaponAfterUse then
		RemoveValue(enemy.WeaponOptions, enemy.WeaponName)
	end

	if aiData.StopAnimationAfterUse and aiData.StopAnimationAfterUse ~= nil then
		StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.StopAnimationAfterUse })
	end

	if aiData.LoseEquipmentOnUse ~= nil then
		for k, equipment in pairs(aiData.LoseEquipmentOnUse) do
			RemoveValue(enemy.Equipment, equipment)
		end
	end

	if aiData.RetreatLeapAfterUse then
		enemy.NeedsRetreatLeap = true
	end

	if aiData.PreAttackLoopingSound ~= nil then
		StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
		enemy.PreAttackLoopingSoundId = nil
	end
	if aiData.PreAttackLoopingEndSound ~= nil then
		PlaySound({ Name = aiData.PreAttackLoopingEndSound, Id = enemy.ObjectId })
	end

	if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt) then
		if not WeaponData[enemy.WeaponName].SkipInterruptIdle then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
		end
		return true
	end

	if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
		aiData.ForcedEarlyExit = true
		return true
	end

	-- POST ATTACK
	if aiData.PostAttackStop then
		Stop({ Id = enemy.ObjectId })
	end

	if aiData.PostAttackStartSetVulnerable then
		SetUnitVulnerable(enemy)
	end

	if aiData.PostAttackFunctionName ~= nil then
		CallFunctionName( aiData.PostAttackFunctionName, enemy, aiData, CurrentRun)
	end
	if aiData.PostAttackThreadedFunctionName ~= nil then
		thread(CallFunctionName, aiData.PostAttackThreadedFunctionName, enemy, aiData, CurrentRun, aiData.PostAttackThreadedFunctionArgs )
	end

	if aiData.PostAttackAlpha ~= nil then
		SetAlpha({ Id = enemy.ObjectId, Fraction = aiData.PostAttackAlpha })
	end
	if aiData.PostAttackAnimation and GetExistingAnimationPriority( enemy ) == nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PostAttackAnimation })
	end

	if aiData.PostAttackFx then
		if aiData.PostAttackFXOnPlayer then
			CreateAnimation({ Name = aiData.PostAttackFx, DestinationId = CurrentRun.Hero.ObjectId })
		else
			CreateAnimation({ Name = aiData.PostAttackFx, DestinationId = enemy.ObjectId })
		end
	end
	if aiData.StopAnimationsOnEnd then
		for k, animationName in pairs(aiData.StopAnimationsOnEnd) do
			StopAnimation({ DestinationId = enemy.ObjectId, Name = animationName })
		end
	end

	if aiData.PostAttackSound ~= nil then
		PlaySound({ Name = aiData.PostAttackSound, Id = enemy.ObjectId })
	end

	if aiData.AttackVoiceLines ~= nil then
		thread( PlayVoiceLines, aiData.AttackVoiceLines, nil, enemy )
	end

	if aiData.UnequipWeaponAfterUse then
		RemoveValue(enemy.WeaponOptions, aiData.WeaponName)
	end

	if aiData.PostAttackDurationMin ~= nil and aiData.PostAttackDurationMax ~= nil then
		local waitTime = RandomFloat(aiData.PostAttackDurationMin, aiData.PostAttackDurationMax)
		AIWait(waitTime, enemy, enemy.AIThreadName)
	else
		AIWait(aiData.PostAttackDuration, enemy, enemy.AIThreadName, { MinWaitTime = aiData.PostAttackMinWaitTime })
	end

	if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
		aiData.ForcedEarlyExit = true
		return true
	end

	if aiData.PostAttackEndMusicStemVolume then
		SetSoundCueValue({ Names = { enemy.MusicStem }, Id = AudioState.MusicId, Value = aiData.PostAttackEndMusicStemVolume, Duration = 1 })
	end

	if aiData.PostAttackEnemyDataOverrides then
		OverwriteTableKeys(enemy, aiData.PostAttackEnemyDataOverrides)
	end

	if aiData.PostAttackEndSetVulnerable then
		SetUnitVulnerable(enemy)
	end

	local postAttackCooldown = aiData.PostAttackCooldown
	if aiData.PostAttackCooldown == nil and aiData.PostAttackCooldownMin ~= nil and aiData.PostAttackCooldownMax ~= nil then
		postAttackCooldown = RandomFloat(aiData.PostAttackCooldownMin, aiData.PostAttackCooldownMax)
	end

	if aiData.PostAttackCooldownRetreat then
		thread(Retreat, enemy, aiData, aiData.TargetId)
	end

	AIWait(postAttackCooldown, enemy, aiData.AIThreadName or enemy.AIThreadName, { MinWaitTime = aiData.PostAttackCooldownMinWaitTime })

	if enemy.DisableAIWhenReady then
		return true
	end

	if aiData.IdleAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.IdleAnimation })
	end

	if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
		aiData.ForcedEarlyExit = true
		return true
	end

	return true

end

function CreateTargetMarker( enemy, aiData )
	if enemy.TargetMarkerCreated then
		return
	end
	local targetMarker = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = aiData.TargetId })
	Attach({ Id = targetMarker, DestinationId = aiData.TargetId })
	CreateAnimation({ Name = aiData.AIChargeTargetMarker, DestinationId = targetMarker })
	enemy.TargetMarkerCreated = { Anim = aiData.AIChargeTargetMarker, Id = targetMarker }
end

function FinishTargetMarker( enemy )
	if enemy.TargetMarkerCreated then
		StopAnimation({ DestinationId = enemy.TargetMarkerCreated.Id, Name = enemy.TargetMarkerCreated.Anim, PreventChain = true })
		enemy.TargetMarkerCreated = nil
	end
end

-- Wanders until the player is within aggro range, then switches to PostAggroAI or AttackerAI
function AggroAI( enemy )
	enemy.CanBeAggroed = true

	if enemy.WakeUpDelay ~= nil or (enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil) then
		local wakeUpDelay = enemy.WakeUpDelay or RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
		wait( CalcEnemyWait( enemy, wakeUpDelay, { IgnoreSpeedMultiplier = true } ), enemy.AIThreadName )
	end

	if enemy.StartAggroed then
		AggroUnit( enemy )
		return
	end
	enemy.IsAggroed = false

	local aggroRange = enemy.AIAggroRange or 500

	-- Return to aggro tether
	if enemy.AggroTetherId ~= nil and IsAlive({ Id = enemy.AggroTetherId }) then
		Move({ Id = enemy.ObjectId, DestinationId = enemy.AggroTetherId, SuccessDistance = 75 })
		enemy.AINotifyName = "ReturnToTether"..enemy.ObjectId

		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = enemy.AggroTetherId, Distance = 100, Notify = enemy.AINotifyName})
		waitUntil( enemy.AINotifyName )
	end

	local originalPositionId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, Group = "Standing" })

	if GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) <= aggroRange then
		AggroUnit( enemy )
		return
	end

	while IsAIActive( enemy ) and not enemy.IsAggroed do
		local randomNewTargetId = nil
		
		if enemy.WanderTowardTypes ~= nil then
			local wanderTarget = GetRandomValue( GetIdsByType({ Names = enemy.WanderTowardTypes }) )
			Move({ Id = enemy.ObjectId, DestinationId = wanderTarget, SuccessDistance = 50 })
		elseif enemy.WanderTowardPlayer then
			Move({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, SuccessDistance = 50 })
		elseif enemy.WanderSpawnPoints ~= nil then
			if IsEmpty( enemy.WanderSpawnPointsRemaining ) then
				enemy.WanderSpawnPointsRemaining = ShallowCopyTable( enemy.WanderSpawnPoints )
			end
			local wanderTarget = RemoveRandomValue( enemy.WanderSpawnPointsRemaining )
			Move({ Id = enemy.ObjectId, DestinationId = wanderTarget, SuccessDistance = 50 })
		elseif enemy.AIWanderDistance ~= nil then
			randomNewTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = originalPositionId, OffsetX = RandomFloat(-enemy.AIWanderDistance, enemy.AIWanderDistance), OffsetY = RandomFloat(-enemy.AIWanderDistance, enemy.AIWanderDistance), Group = "Standing" })
			Move({ Id = enemy.ObjectId, DestinationId = randomNewTargetId, SuccessDistance = 50 })
		end

		local aggroOriginId = enemy.ObjectId

		if enemy.AggroTetherId ~= nil and IsAlive({ Id = enemy.AggroTetherId }) then
			aggroOriginId = enemy.AggroTetherId
		end

		-- Within aggro range
		if not enemy.IsAggroed then
			enemy.AINotifyName = "WithinAggroRange"..enemy.ObjectId
			NotifyWithinDistance({ Id = aggroOriginId, DestinationId = CurrentRun.Hero.ObjectId, Distance = aggroRange, Notify = enemy.AINotifyName, Timeout = enemy.AIWanderFrequency or 1.5})
			waitUntil( enemy.AINotifyName )

			if not _eventTimeoutRecord[enemy.AINotifyName] then
				Destroy({ Id = originalPositionId })
				Destroy({ Id = randomNewTargetId })
				AggroUnit( enemy )
			end
		end

		if enemy.AggroIfLastAlive and TableLength( RequiredKillEnemies ) == 1 then
			Destroy({ Id = originalPositionId })
			Destroy({ Id = randomNewTargetId })
			AggroUnit( enemy )
		end

		AIWait(enemy.AggroAIRefreshDuration or 0.5, enemy, enemy.AIThreadName)
		Destroy({ Id = randomNewTargetId })
	end
	Destroy({ Id = originalPositionId })
end

function ChooseWanderSpawnPoints( enemy, args )
	enemy.WanderSpawnPoints = {}
	for k, id in ipairs( MapState.SpawnPoints ) do
		local distance = GetDistance({ Id = id, DestinationId = enemy.ObjectId })
		if distance < args.Radius then
			table.insert( enemy.WanderSpawnPoints, id )
		end
	end
end

function AmbientBattleAggroAI( enemy )
	enemy.CanBeAggroed = true

	if enemy.StartAggroed then
		AggroUnit( enemy )
		return
	end
	enemy.IsAggroed = false

	-- wait for other units to spawn
	wait(0.1, enemy.AIThreadName)
	TakeAmbientBattleDamage(enemy)

	local aiData = enemy.DefaultAIData

	-- Pick an NPC foe to fight
	local battleFoeId = nil
	local availableFoeIds = GetIds({ Names = aiData.AmbientBattleTargetGroups })
	battleFoeId = GetRandomValue(availableFoeIds)

	if battleFoeId == nil then
		return SetAI("AggroAI", enemy)
	end

	local battleFoe = ActiveEnemies[battleFoeId]
	TakeAmbientBattleDamage(battleFoe)
	if aiData.TeleportToBattleFoeChance ~= nil and RandomChance(aiData.TeleportToBattleFoeChance) then
		Teleport({ Id = enemy.ObjectId, DestinationId = battleFoeId, OffsetX = RandomFloat(-75, 75), OffsetY = RandomFloat(-75, 75) })
	end
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = battleFoeId })

	while IsAIActive( enemy ) and not enemy.IsAggroed and ActiveEnemies[battleFoeId] ~= nil do

		enemy.WeaponName = SelectWeapon(enemy)
		table.insert(enemy.WeaponHistory, enemy.WeaponName)
		aiData = GetWeaponAIData(enemy)
		aiData.TargetId = battleFoeId

		DoAttackerAILoop(enemy, aiData)
	end
end

function AggroUnit( enemy, hostileAggro )

	if enemy.IsAggroed then
		return
	end

	enemy.IsAggroed = true

	local reactionTime = enemy.AggroReactionTime or 0
	if enemy.AggroReactionTime == nil and enemy.AggroReactionTimeMin ~= nil and enemy.AggroReactionTimeMax ~= nil then
		reactionTime = RandomFloat(enemy.AggroReactionTimeMin, enemy.AggroReactionTimeMax)
	end

	AIWait(reactionTime, enemy, enemy.AIThreadName)

	PlaySound({ Name = enemy.IsAggroedSound or "/Leftovers/SFX/ImpRef01_GoDown", Id = enemy.ObjectId, ManagerCap = 28 })
	Stop({ Id = enemy.ObjectId })
	if enemy.RotateOnAggro then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = GetTargetId(enemy)})
	end

	if not enemy.SkipAlertedText then
		thread( InCombatText, enemy.ObjectId, "Alerted", 0.45, { OffsetY = enemy.HealthBarOffsetY, SkipShadow = true }  )
	end
	if enemy.AggroAnimation ~= nil and not enemy.IsPolymorphed then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.AggroAnimation })
	end

	AIWait(enemy.AggroDuration, enemy, enemy.AIThreadName)

	thread( AggroNearbyUnits, enemy, hostileAggro )

	if enemy.AdditionalPostAggroAIFunctions ~= nil then
		for k, aiFunctionName in pairs(enemy.AdditionalPostAggroAIFunctions) do
			thread( SetAI, aiFunctionName, enemy )
		end
	end
	
	local previouslyStealthed = IsEmpty(MapState.AggroedUnits)
	MapState.AggroedUnits[enemy.ObjectId] = true
	
	if previouslyStealthed then
		thread( UpdateSpellActiveStatus )
	end

	local newAI = enemy.PostAggroAI or "AttackerAI"
	return SetAI( newAI, enemy )
end

function AggroNearbyUnits( enemy, hostileAggro )
	if not enemy.ChainAggroAllEnemies then
		return
	end
	
	for otherEnemyId, otherEnemy in pairs( ActiveEnemies ) do
		if otherEnemy ~= nil and otherEnemy.CanBeAggroed and otherEnemy.CanBeChainAggroed and not otherEnemy.IsAggroed and enemy.ObjectId ~= otherEnemyId then
			local aggroRange = otherEnemy.p or otherEnemy.AIAggroRange or 0
			if hostileAggro and otherEnemy.AIHostileChainAggroRange ~= nil then
				aggroRange = otherEnemy.AIHostileChainAggroRange
			end
			if not otherEnemy.IsAggroed and GetDistance({ Id = enemy.ObjectId, DestinationId = otherEnemyId }) < aggroRange then
				thread( AggroUnit, otherEnemy )
			end
		end
	end

end

function CheckStun( enemy, aiData )
	if aiData.AttackFailWeapon ~= nil and not CanAttack({ Id = enemy.ObjectId }) then
		enemy.WeaponName = aiData.AttackFailWeapon
		DoAttackerAILoop(enemy)
		SurroundEnemiesAttacking[enemy.SurroundAIKey or enemy.Name][enemy.ObjectId] = nil
		return true
	end
end

function HideAndPeekAI( enemy )

	SurroundEnemiesAttacking = SurroundEnemiesAttacking or {}

	while IsAIActive( enemy ) do

		if not CanAttack({ Id = enemy.ObjectId }) then
			enemy.AINotifyName = "CanAttack"..enemy.ObjectId
			NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end

		-- Pick weapon
		enemy.WeaponName = SelectWeapon( enemy )
		table.insert( enemy.WeaponHistory, enemy.WeaponName )
		local aiData = GetWeaponAIData(enemy)

		aiData.TargetId = GetTargetId(enemy, aiData)

		if aiData.TargetId ~= nil and aiData.TargetId ~= 0 then

			-- Retreat if target is too close
			local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
			if aiData.RetreatDistance ~= nil and distanceToTarget < aiData.RetreatDistance then
				Retreat(enemy, aiData, aiData.TargetId)
			end

			-- Hide behind cover if found
			local coverId = GetClosest({ Id = enemy.ObjectId, DestinationNames = { "Standing" }, StopsProjectiles = true })
			if coverId > 0 then
				Move({ Id = enemy.ObjectId, DestinationId = coverId, LiveOffsetFromId = aiData.TargetId, LiveOffsetDistance = aiData.CoverHugDistance, SuccessDistance = 50 })
			end
			if aiData.TakeCoverDurationMin and aiData.TakeCoverDurationMax then
				local coverDuration = RandomFloat( aiData.TakeCoverDurationMin, aiData.TakeCoverDurationMax )
				wait( CalcEnemyWait( enemy, coverDuration ), enemy.AIThreadName )
			else
				wait( CalcEnemyWait( enemy, aiData.TakeCoverDuration ), enemy.AIThreadName )
			end
			CheckStun( enemy, aiData, aiData.TargetId )

			-- Wait to be re-aggroed
			Stop({ Id = enemy.ObjectId })
			local enemyId = enemy.ObjectId
			enemy.AINotifyName = "WaitingForAggro"..enemy.ObjectId

			local peekMultiplier = enemy.PeekAggroMultiplier or 1
			NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = enemy.AIAggroRange * peekMultiplier, Notify = enemy.AINotifyName })
			waitUntil( enemy.AINotifyName )
			wait( CalcEnemyWait( enemy, 0.1 ), enemy.AIThreadName )
			CheckStun( enemy, aiData, aiData.TargetId )

			local surroundKey = aiData.SurroundAIKey or enemy.Name
			if aiData.MaxAttackers == nil or TableLength( SurroundEnemiesAttacking[surroundKey] ) < aiData.MaxAttackers then
				DoAttackerAILoop( enemy, aiData )
				FinishTargetMarker( enemy )
				SurroundEnemiesAttacking[surroundKey][enemy.ObjectId] = nil
			end
			CheckStun( enemy, aiData, aiData.TargetId )

		else
			wait( CalcEnemyWait( enemy, 1.0 ), enemy.AIThreadName )
			CheckStun( enemy, aiData, aiData.TargetId )
		end
	end

end

function OrbitAI( enemy, aiData )

	if enemy.Orbiting then
		return
	end

	if IsCharmed({ Id = enemy.ObjectId }) then
			return SetAI( "AttackerAI", enemy )
	end

	local aiData = aiData or enemy.DefaultAIData
	aiData.TargetId = aiData.TargetId or CurrentRun.Hero.ObjectId
	local orbitAngle = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId })
	local orbitDirection = 1

	if aiData.RandomOrbitDirection and RandomChance(0.5) then
		orbitDirection = -1
	end

	if aiData.OrbitAIDuration ~= nil or (aiData.OrbitAIDurationMin ~= nil and aiData.OrbitAIDurationMax ~= nil) then
		enemy.Orbiting = true
		thread(EndOrbitAITimer, enemy, aiData)
	end

	while IsAIActive( enemy ) and not enemy.DisableOrbitAI do
		Move({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, LiveOffsetFromId = aiData.TargetId, LiveOffsetDistance = aiData.OrbitDistance, LiveOffsetAngle = orbitAngle, SuccessDistance = 50 })
		enemy.AINotifyName = "OnStopped"..enemy.ObjectId
		NotifyOnStopped({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = aiData.OrbitTickDuration or 1.0 })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )

		orbitAngle = (orbitAngle + aiData.OrbitTickDegrees * orbitDirection) % 360
	end
	enemy.DisableOrbitAI = false
	enemy.Orbiting = false

	if aiData.PostOrbitAI ~= nil then
		thread(CallFunctionName, aiData.PostOrbitAI, enemy, aiData, CurrentRun, args )
	end

end

function OrbitId(destinationId, projectileOwnerId, duration, orbitSpeed)
	local timeRemaining = duration - 1
	local orbitAngle = GetAngleBetween({ Id = projectileOwnerId, DestinationId = destinationId })
	local orbitDistance =  GetDistance({ Id = projectileOwnerId, DestinationId = destinationId })
	local speed = 0.25 / orbitSpeed

	local offset = CalcOffset(math.rad(orbitAngle), orbitDistance)
	local offsetPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = projectileOwnerId, OffsetX = offset.X, OffsetY = offset.Y * 0.48 })
	Teleport({ Id = destinationId, DestinationId = offsetPoint })

	while timeRemaining > 0 do
		local tickDuration = math.min(speed, timeRemaining)
		orbitAngle = (orbitAngle + 10) % 360
		offset = CalcOffset(math.rad(orbitAngle), orbitDistance)
		local movePoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = projectileOwnerId, OffsetX = offset.X, OffsetY = offset.Y * 0.48 })
		Move({ Id = destinationId, DestinationId = movePoint, Duration = tickDuration })
		local notifyName = "OnStopped"..destinationId
		NotifyOnStopped({ Id = destinationId, Notify = notifyName, Timeout = tickDuration })
		waitUntil( notifyName)

		Destroy({ Id = movePoint })
		timeRemaining = timeRemaining - tickDuration
	end
	
	Destroy({ Id = offsetPoint })
	Stop({ Id = destinationId })
end

function WanderToId(destinationId, projectileData)
	local timeRemaining = projectileData.Fuse - projectileData.WanderOwnerDetonateBuffer - 1
	local originalDestinationId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = destinationId })

	local offset = CalcOffset(RandomFloat(0,360), projectileData.WanderRadius)
	local offsetPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = originalDestinationId, OffsetX = offset.X, OffsetY = offset.Y * 0.55 })
	Teleport({ Id = destinationId, DestinationId = offsetPoint })

	while timeRemaining > 0 do
		local tickDuration = math.min(RandomFloat(projectileData.WanderTickMin or 0.5, projectileData.WanderTickMax or 0.75), timeRemaining)
		local moveOffset = CalcOffset(RandomFloat(0,360), projectileData.WanderRadius)
		local movePoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = originalDestinationId, OffsetX = moveOffset.X, OffsetY = moveOffset.Y * 0.55 })
		Move({ Id = destinationId, DestinationId = movePoint, Speed = projectileData.WanderSpeed })
		local notifyName = "OnStopped"..destinationId
		NotifyOnStopped({ Id = destinationId, Notify = notifyName, Timeout = tickDuration })
		waitUntil( notifyName)

		Destroy({ Id = movePoint })
		timeRemaining = timeRemaining - tickDuration
	end

	Move({ Id = destinationId, DestinationId = originalDestinationId, Speed = projectileData.WanderSpeed })
	
	Destroy({ Id = offsetPoint })
	Destroy({ Id = originalDestinationId })
end

function EndOrbitAITimer( enemy, aiData )
	local duration = aiData.OrbitAIDuration
	if aiData.OrbitAIDurationMin ~= nil then
		duration = RandomFloat(aiData.OrbitAIDurationMin, aiData.OrbitAIDurationMax)
	end
	wait(duration, enemy.AIThreadName)
	enemy.DisableOrbitAI = true
	SetThreadWait(enemy.AIThreadName, 0.01)
end

function SurroundAI( enemy )

	SurroundEnemiesAttacking = SurroundEnemiesAttacking or {}
	SurroundEnemiesAttacking[enemy.Name] = SurroundEnemiesAttacking[enemy.Name] or {}

	while IsAIActive( enemy ) do

		if not CanAttack({ Id = enemy.ObjectId }) then
			enemy.AINotifyName = "CanAttack"..enemy.ObjectId
			NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end

		-- Pick weapon
		enemy.WeaponName = SelectWeapon( enemy )
		table.insert( enemy.WeaponHistory, enemy.WeaponName )
		local aiData = GetWeaponAIData(enemy)

		aiData.TargetId = GetTargetId( enemy, aiData )

		if aiData.TargetId ~= nil then

			local surroundAIKey = aiData.SurroundAIKey or enemy.Name
			SurroundEnemiesAttacking[surroundAIKey] = SurroundEnemiesAttacking[surroundAIKey] or {}
			if enemy.DoSurroundAIRetaliate or ( aiData.MaxAttackers == nil or TableLength( SurroundEnemiesAttacking[surroundAIKey] ) < aiData.MaxAttackers ) then
				
				DoAttackerAILoop( enemy, aiData )
				while enemy.ChainedWeapon ~= nil do
					DoAttackerAILoop( enemy )
				end
				SurroundEnemiesAttacking[surroundAIKey][enemy.ObjectId] = nil

				enemy.LastMoveToId = nil
			end
			enemy.DoSurroundAIRetaliate = false

			if aiData.TeleportToSpawnPoints then
				HandleEnemyTeleportation(enemy, aiData)
			end

			local distanceBuffer = aiData.SurroundDistanceBuffer or 50
			if aiData.MaintainSurroundDistance then
				local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })

				if distanceToTarget >= aiData.SurroundDistance + distanceBuffer or distanceToTarget <= aiData.SurroundDistance - distanceBuffer then
					if aiData.SurroundUsingSpawnPoints then
						local offset = CalcOffset(math.rad(GetAngleBetween({ DestinationId = aiData.TargetId, Id = enemy.ObjectId })), distanceToTarget - aiData.SurroundDistance - distanceBuffer)
						local offsetPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
						local movePoints = GetIdsByType({ Name = aiData.SurroundSpawnPointTypes or "EnemyPoint" })
						RemoveValue( movePoints, enemy.LastMoveToId )
						local moveToId = GetClosest({ Id = offsetPoint, DestinationIds = movePoints, Distance = 1000 })
						Destroy({ Id = offsetPoint })
						enemy.LastMoveToId = moveToId
						
						if moveToId ~= 0 then
							Move({ Id = enemy.ObjectId, DestinationId = moveToId, SuccessDistance = 60 })
							enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
							NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = moveToId, Distance = 85, Notify = enemy.AINotifyName, Timeout = aiData.SuroundMoveTimeout or 3.0 })
							waitUntil( enemy.AINotifyName )
						else
							wait(0.1)
						end
					else
						Move({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, LiveOffsetFromId = aiData.TargetId, LiveOffsetDistance = aiData.SurroundDistance, LiveOffsetAngle = 180, SuccessDistance = 75 })
					end
				end
			elseif aiData.SurroundDistance ~= nil then
				Track({ Ids = { enemy.ObjectId }, DestinationIds = { aiData.TargetId } })

				local timeout = aiData.SurroundRefreshInterval or 3.0
				local minTrackTime = aiData.SurroundMinTrackTime or 1.0
				wait(minTrackTime, enemy.AIThreadName)

				enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
				NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, Distance = aiData.SurroundDistance, Notify = enemy.AINotifyName, Timeout = timeout - minTrackTime })
				waitUntil( enemy.AINotifyName )

			elseif aiData.SurroundRetaliateDistance ~= nil then
				Track({ Ids = { enemy.ObjectId }, DestinationIds = { aiData.TargetId } })
				
				enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
				NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, Distance = aiData.SurroundRetaliateDistance, Notify = enemy.AINotifyName, Timeout = aiData.SurroundRefreshInterval or 3.0 })
				waitUntil( enemy.AINotifyName )

				if not _eventTimeoutRecord[enemy.AINotifyName] then
					enemy.DoSurroundAIRetaliate = true
				end
			end
			
			wait( CalcEnemyWait( enemy, aiData.SurroundRefreshInterval), enemy.AIThreadName )
		else
			wait( CalcEnemyWait( enemy, 1.0), enemy.AIThreadName )
		end
	end

end

function SurroundAIRetaliate( enemy )
	enemy.DoSurroundAIRetaliate = true
	notifyExistingWaiters(enemy.AINotifyName)
end

function LeapIntoRangeAI( enemy, currentRun )
	MapState.LeapPointsOccupied = MapState.LeapPointsOccupied or {}

	while IsAIActive( enemy, currentRun ) do
		-- Pick weapon
		enemy.WeaponName = SelectWeapon( enemy )
		table.insert( enemy.WeaponHistory, enemy.WeaponName )

		local weaponAIData = GetWeaponAIData(enemy)
		local targetId = GetTargetId( enemy, weaponAIData )

		if not CanAttack({ Id = enemy.ObjectId }) then
			enemy.AINotifyName = "CanAttack"..enemy.ObjectId
			NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end

		if weaponAIData.TeleportToSpawnPoints then
			HandleEnemyTeleportation(enemy, weaponAIData, currentRun, targetId)
		end

		if targetId ~= nil and targetId ~= 0 then
			-- Check if player is too far or has no path
			local needsLeap = false
			local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = targetId })
			if weaponAIData.LeapWhenTargetBeyondDistance ~= nil and distanceToTarget > weaponAIData.LeapWhenTargetBeyondDistance then
				needsLeap = true
			elseif weaponAIData.LeapWhenTargetWithinDistance ~= nil and distanceToTarget < weaponAIData.LeapWhenTargetWithinDistance then
				needsLeap = true
			elseif weaponAIData.LeapWhenTargetOutOfSight then
				local hasLineOfSight = HasLineOfSight({ Id = enemy.ObjectId, DestinationId = targetId, StopsProjectiles = false, StopsUnits = true, PreferAvoidUnits = true })
				if not hasLineOfSight then
					needsLeap = true
				end
			end

			if needsLeap then
				-- Leap to close gap
				Leap(enemy, weaponAIData, targetId )
			end

			if enemy.NeedsRetreatLeap then
				Leap(enemy, weaponAIData, targetId, "Retreat" )
				enemy.NeedsRetreatLeap = false
				if weaponAIData.DeaggroAfterRetreat then
					thread(AggroAI, enemy, currentRun)
					return
				end
			elseif enemy.NeedsFlankLeap then
				Leap(enemy, weaponAIData, targetId, "Flank" )
				enemy.NeedsFlankLeap = false
			end

			DoAttackerAILoop( enemy, weaponAIData )

			if weaponAIData.RepositionLeap then
				Leap(enemy, weaponAIData, targetId )
			end
		else
			if enemy.NeedsRetreatLeap then
				Leap(enemy, weaponAIData, targetId, "Retreat" )
				enemy.NeedsRetreatLeap = false
				if weaponAIData.DeaggroAfterRetreat then
					SetAI(AggroAI, enemy, CurrentRun)
				end
			end

			wait( CalcEnemyWait( enemy, 1.0), enemy.AIThreadName )
		end
	end
end

function Leap( enemy, aiData, leapType )
	if not CanMove({ Id = enemy.ObjectId }) then
		return
	end

	local leapTargetId = nil
	local validPoints = {}
	if leapType == "Flank" then
		-- Needs to pick a point on the other side of the player
		leapTargetId = aiData.TargetId
	elseif leapType == "Retreat" then
		local nearbyPoints = GetClosestIds({ Id = aiData.TargetId, DestinationName = "SpawnPoints", Distance = aiData.RetreatLeapDistance })
		for k, pointId in pairs(nearbyPoints) do
			if MapState.LeapPointsOccupied[pointId] == nil then
				local distanceTargetToPoint = GetDistance({ Id = aiData.TargetId, DestinationId = pointId })
				local minDistance = aiData.RetreatLeapMinDistance or 0
				if distanceTargetToPoint > minDistance then
					table.insert(validPoints, pointId)
				end
			end
		end
		leapTargetId = GetRandomValue(validPoints)
	else
		if aiData.LeapToTarget then
			leapTargetId = aiData.TargetId
		else
			leapTargetId = SelectSpawnPoint(CurrentRun.CurrentRoom, enemy,
				{ SpawnNearId = aiData.TargetId or CurrentRun.Hero.ObjectId, SpawnRadius = aiData.LeapDistanceMax or 1000, SpawnRadiusMin = aiData.LeapDistanceMin },
				{ RequireLoS = aiData.RequireLeapTargetLoS, LoSTarget = aiData.TargetId })
		end
	end

	if leapTargetId == nil then
		DebugPrint({ Text = "No valid leap target found!" })
		return
	end

	if IsLocationBlocked({ Id = leapTargetId }) then
		return
	end

	SessionMapState.SpawnPointsUsed[leapTargetId] = enemy.ObjectId

	local lockedTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = leapTargetId })
	if aiData.LeapWarningAnimation ~= nil then
		CreateAnimation({ Name = aiData.LeapWarningAnimation, DestinationId = lockedTargetId })
	end

	local immuneToForceReset = GetThingDataValue({ Id = enemy.ObjectId, Property = "ImmuneToForce" })
	--local immuneToStunReset = GetUnitDataValue({ Id = enemy.ObjectId, Property = "ImmuneToStun" })
	SetThingProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToForce", Value = true })
	--SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToStun", Value = true })

	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = lockedTargetId })

	if aiData.LeapChargeAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.LeapChargeAnimation })
	end
	if aiData.LeapChargeSound ~= nil then
		PlaySound({ Name = aiData.LeapChargeSound, Id = enemy.ObjectId })
	end
	wait( CalcEnemyWait( enemy, aiData.LeapPrepareTime ), enemy.AIThreadName )
	if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
		return false
	end
	enemy.ImmuneToPolymorph = true
	--SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithObstacles", Value = false })
	--SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = false })
	Stop({ Id = enemy.ObjectId })
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = lockedTargetId })
	ApplyForce({ Id = enemy.ObjectId, Angle = GetAngleBetween({ Id = enemy.ObjectId, DestinationId = lockedTargetId }), Speed = aiData.LeapSpeed, SelfApplied = true })
	local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = lockedTargetId })
	local neededHangTime = (distanceToTarget / aiData.LeapSpeed) + 0.05
	ApplyUpwardForce({ Id = enemy.ObjectId, HangTime = neededHangTime })
	if aiData.LeapAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.LeapAnimation })
	end
	if aiData.LeapSound ~= nil then
		PlaySound({ Name = aiData.LeapSound, Id = enemy.ObjectId })
	end
	wait( CalcEnemyWait( enemy, neededHangTime ), enemy.AIThreadName )
	-- Landed
	if aiData.LeapLandingAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.LeapLandingAnimation })
	end
	thread( UnoccupySpawnPointOnDistance, enemy, leapTargetId, 150 )
	if aiData.LeapLandingSound ~= nil then
		PlaySound({ Name = aiData.LeapLandingSound, Id = enemy.ObjectId, ManagerCap = 28 })
	end
	if aiData.LeapWarningAnimation ~= nil then
		StopAnimation({ Name = aiData.LeapWarningAnimation, DestinationId = lockedTargetId })
	end
	Destroy({ Id = lockedTargetId })
	--SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithObstacles", Value = true })
	--SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = true })

	SetThingProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToForce", Value = immuneToForceReset })
	--SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToStun", Value = immuneToStunReset })
	--SetVulnerable({ Id = enemy.ObjectId })
	enemy.ImmuneToPolymorph = false
	wait( CalcEnemyWait( enemy, aiData.LeapRecoveryTime), enemy.AIThreadName )
end

function RamAILoop( enemy, aiData )
	if not CanAttack({ Id = enemy.ObjectId }) then
		enemy.AINotifyName = "CanAttack"..enemy.ObjectId
		NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
		waitUntil( enemy.AINotifyName )
	end

	aiData.TargetId = GetTargetId( enemy, aiData )
	if aiData.TargetId ~= nil and aiData.TargetId ~= 0 then
		-- Setup move
		aiData.AttackDistance = aiData.SetupDistance
		aiData.MoveWithinRangeTimeout = aiData.SetupTimeout
		MoveWithinRange( enemy, targetId, aiData )

		if not _eventTimeoutRecord[enemy.AINotifyName] then
			-- Teleportation
			if aiData.TeleportToSpawnPoints then
				HandleEnemyTeleportation(enemy, aiData)
			end

			-- Prepare to ram
			if aiData.PreAttackStop then
				Stop({ Id = enemy.ObjectId })
			end
			if aiData.TrackTargetDuringCharge then
				Track({ Ids = { enemy.ObjectId }, DestinationIds = { aiData.TargetId } })
			end
			if aiData.PreAttackShake ~= nil then
				Shake({ Id = enemy.ObjectId, Speed = aiData.PreAttackShake, Distance = 3, Duration = aiData.PreAttackDuration })
			end
			if aiData.PreAttackFlash ~= nil then
				Flash({ Id = enemy.ObjectId, Speed = aiData.PreAttackFlash, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = aiData.PreAttackDuration })
			end
			if aiData.PreAttackSound ~= nil then
				PlaySound({ Name = aiData.PreAttackSound, Id = enemy.ObjectId, ManagerCap = aiData.SoundManagerCap or 46 })
			end
			if aiData.PreAttackAnimation ~= nil then
				SetAnimation({ Name = aiData.PreAttackAnimation, DestinationId = enemy.ObjectId })
			end
			if aiData.PreAttackFx ~= nil then
				CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFx })
			end
			wait( CalcEnemyWait( enemy, aiData.PreAttackDuration ), enemy.AIThreadName )
			
			if HeroHasTrait("LightningDebuffBoon") then
				for _, data in pairs( GetHeroTraitValues( "OnAttackWindUp")) do
					local hasRequiredEffects = true
					for i, effectGenusName in pairs( data.ValidEffectGroups ) do
						if not HasEffectWithEffectGroup( enemy, genusName ) then
							hasRequiredEffects = false
						end
					end
					if hasRequiredEffects then
						CreateZeusBolt({ ProjectileName = data.ProjectileName, TargetId = enemy.ObjectId, DamageMultiplier = data.DamageMultiplier})
						ClearEffect({ Id = enemy.ObjectId, Name = data.ClearEffectOnHit })
					end
				end
			end
			if HasEffect({Id = enemy.ObjectId, EffectName = "ZeusAttackPenalty" }) then
				thread(FireWeaponWithinRange, { TargetId = enemy.ObjectId, WeaponName = "ZeusAttackBolt", InitialDelay = 0, Delay = 0.25, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
				if not HeroHasTrait("JoltDurationTrait") then
					ClearEffect({ Id = enemy.ObjectId, Name = "ZeusAttackPenalty" })
				end
			end
			if aiData.RamEffectName ~= nil and WeaponEffectData[aiData.RamEffectName] ~= nil then
				effectData = DeepCopyTable(WeaponEffectData[aiData.RamEffectName])
				effectData.Id = enemy.ObjectId
				effectData.DestinationId = enemy.ObjectId
				ApplyEffect( effectData )
			end
			if aiData.FireSound ~= nil then
				PlaySound({ Name = aiData.FireSound, Id = enemy.ObjectId })
			end
			if aiData.FireAlpha ~= nil then
				SetAlpha({ Id = enemy.ObjectId, Fraction = aiData.FireAlpha })
			end
			if aiData.FireAnimation ~= nil then
				SetAnimation({ Name = aiData.FireAnimation, DestinationId = enemy.ObjectId })
			end
			if aiData.FireFx ~= nil then
				CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.FireFx })
			end
			-- Ram move
			aiData.AttackDistance = aiData.RamDistance
			aiData.MoveWithinRangeTimeout = aiData.RamTimeout
			MoveWithinRange( enemy, aiData.TargetId, aiData )
			Stop({ Id = enemy.ObjectId })
			if aiData.PostAttackAnimation ~= nil then
				SetAnimation({ Name = aiData.PostAttackAnimation, DestinationId = enemy.ObjectId })
			end
			wait( CalcEnemyWait( enemy, aiData.RamRecoverTime ), enemy.AIThreadName )
		end
	else
		MoveToRandomLocation( enemy, enemy.ObjectId, aiData.NoTargetWanderDistance or 100, aiData.NoTargetWanderDistance or 0, aiData.NoTargetWanderDuration )
		wait( CalcEnemyWait( enemy, aiData.NoTargetWanderDuration or 0.5 ), enemy.AIThreadName )
	end

	if aiData.RetreatAfterRam then
		Retreat(enemy, aiData, aiData.TargetId)
	end
end

function AIFireWeapon( enemy, aiData )

	if aiData.FireWeaponAtSelf then
		aiData.TargetId = enemy.ObjectId
	end

	if aiData.ProjectileOptions ~= nil then
		aiData.ProjectileName = GetRandomValue(aiData.ProjectileOptions)
	end

	if aiData.AttackSound ~= nil then
		PlaySound({ Name = aiData.AttackSound, Id = enemy.ObjectId })
	end

	if aiData.FireRotationDampening ~= nil then
		local dampenEffect = { Id = enemy.ObjectId, DestinationId = enemy.ObjectId, EffectName = enemy.Name .. "FireRotationDampening" }
		dampenEffect.DataProperties = { Duration = 999, RotationMultiplier = aiData.FireRotationDampening, TimeModifierFraction = 1 }
		ApplyEffect(dampenEffect)
		table.insert(enemy.ClearEffectsOnHitStun, dampenEffect.EffectName)
	end

	if aiData.WeaponFireLoopingSound ~= nil then
		if enemy.WeaponFireLoopingSoundId ~= nil then
			StopSound({ Id = enemy.WeaponFireLoopingSoundId, Duration = 0.4 })
			enemy.WeaponFireLoopingSoundId = nil
		end
		enemy.WeaponFireLoopingSoundId = PlaySound({ Name = aiData.WeaponFireLoopingSound, Id = enemy.ObjectId })
	end

	if aiData.ApplyEffectsOnWeaponFire ~= nil then
		for k, effectData in pairs(aiData.ApplyEffectsOnWeaponFire) do
			effectData.Id = enemy.ObjectId
			effectData.DestinationId = enemy.ObjectId
			if effectData.DataProperties and not effectData.DataProperties.TimeModifierFraction then
				effectData.DataProperties.TimeModifierFraction = 1
			end
			ApplyEffect(effectData)
			if effectData.ClearEffectOnHit then
				table.insert(enemy.ClearEffectsOnHitStun, effectData.EffectName)
			end
		end
	end

	local defaultCollideWithUnits = nil
	local defaultStopsProjectiles = nil
	if aiData.RemoveUnitCollisionDuringAttack then
		defaultCollideWithUnits = GetUnitDataValue({ Id = enemy.ObjectId, Property = "CollideWithUnits" })
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = false })
	end
	if aiData.AddUnitCollisionDuringAttack then
		defaultCollideWithUnits = GetUnitDataValue({ Id = enemy.ObjectId, Property = "CollideWithUnits" })
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = true })
	end
	if aiData.AddProjectileCollisionDuringAttack then
		defaultStopsProjectiles = GetThingDataValue({ Id = enemy.ObjectId, Property = "StopsProjectiles" })
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = true })
	end
	if aiData.RemoveProjectileCollisionDuringAttack then
		defaultStopsProjectiles = GetThingDataValue({ Id = enemy.ObjectId, Property = "StopsProjectiles" })
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = false })
	end
	if aiData.FireAlpha ~= nil then
		SetAlpha({ Id = enemy.ObjectId, Fraction = aiData.FireAlpha })
	end

	local fireTicks = aiData.FireTicks
	if aiData.FireTicksMin ~= nil and aiData.FireTicksMax ~= nil then
		fireTicks = RandomInt( aiData.FireTicksMin, aiData.FireTicksMax )
	end

	local fireInterval = aiData.FireInterval
	if aiData.FireIntervalMin ~= nil and aiData.FireIntervalMax ~= nil then
		fireInterval = RandomFloat( aiData.FireIntervalMin, aiData.FireIntervalMax )
	end
	if HeroHasTrait("LightningDebuffBoon") then
		for _, data in pairs( GetHeroTraitValues( "OnAttackWindUp")) do
			local hasRequiredEffects = true
			for i, effectGenusName in pairs( data.ValidEffectGroups ) do
				if not HasEffectWithEffectGroup( enemy, effectGenusName ) then
					hasRequiredEffects = false
				end
			end
			if hasRequiredEffects then
				CreateZeusBolt({ ProjectileName = data.ProjectileName, TargetId = enemy.ObjectId, DamageMultiplier = data.DamageMultiplier})
				ClearEffect({ Id = enemy.ObjectId, Name = data.ClearEffectOnHit })
			end
		end
	end
	if HasEffect({Id = enemy.ObjectId, EffectName = "ZeusAttackPenalty" }) then
		thread(FireWeaponWithinRange, { TargetId = enemy.ObjectId, WeaponName = "ZeusAttackBolt", InitialDelay = 0, Delay = 0.25, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
		if not HeroHasTrait("JoltDurationTrait") then
			ClearEffect({ Id = enemy.ObjectId, Name = "ZeusAttackPenalty" })
		end
	end

	if aiData.FireAtAllTargetsWithinRange ~= nil then
		local targetIds = GetClosestIds({ Id = enemy.ObjectId, DestinationNames = aiData.TargetGroups, Distance = aiData.FireAtAllTargetsWithinRange })
		--DebugPrintTable({ TableName = "Target Ids: ", PrintTable = targetIds })
		for k, targetId in pairs(targetIds) do
			if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
				aiData.ForcedEarlyExit = true
				return true
			end

			if not aiData.SkipCanAttack and  not CanAttack({ Id = enemy.ObjectId }) then
				return false
			end

			aiData.TargetId = targetId

			DoWeaponFire( enemy, aiData )

			if aiData.FireIntervalWaitForAnimation and aiData.FireAnimation ~= nil then
				enemy.AINotifyName = "FireWaitForAnimation"..enemy.ObjectId
				NotifyOnAnimationTimeRemaining({ Id = enemy.ObjectId, Animation = aiData.FireAnimation, Remaining = 0, Notify = enemy.AINotifyName, Timeout = 9.0 })
				waitUntil( enemy.AINotifyName, aiData.AIThreadName or enemy.AIThreadName )
			else
				AIWait(fireInterval or 0, enemy, aiData.AIThreadName or enemy.AIThreadName)
			end
		end
	elseif fireTicks ~= nil then
		for fireTick = 1, fireTicks, 1 do
			aiData.FireTick = fireTick
			if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
				aiData.ForcedEarlyExit = true
				return true
			end

			if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt) then
				if not WeaponData[enemy.WeaponName].SkipInterruptIdle then
					SetAnimation({ DestinationId = enemy.ObjectId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
				end
				return true
			end

			if not aiData.FireAsPlayerProjectile and not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
				return false
			end

			if aiData.ResetTargetPerTick then
				if enemy.CreatedOwnTarget ~= nil then
					Destroy({ Id = enemy.CreatedOwnTarget })
				end
				
				aiData.TargetId = GetTargetId(enemy, aiData)
			end

			if aiData.ApplyEffectsOnWeaponTick ~= nil then
				for k, effectData in pairs(aiData.ApplyEffectsOnWeaponTick) do
					effectData.Id = enemy.ObjectId
					effectData.DestinationId = enemy.ObjectId
					ApplyEffect(effectData)
					if effectData.DataProperties and not effectData.DataProperties.TimeModifierFraction then
						effectData.DataProperties.TimeModifierFraction = 1
					end
					if effectData.ClearEffectOnHit then
						table.insert(enemy.ClearEffectsOnHitStun, effectData.EffectName)
					end
				end
			end

			if aiData.SpawnBurstPerTick then
				thread(HandleSpawnerBurst, enemy, aiData)
			end

			DoWeaponFire( enemy, aiData )

			if aiData.FireIntervalWaitForAnimation and aiData.FireAnimation ~= nil then
				enemy.AINotifyName = "FireWaitForAnimation"..enemy.ObjectId
				NotifyOnAnimationTimeRemaining({ Id = enemy.ObjectId, Animation = aiData.FireAnimation, Remaining = 0, Notify = enemy.AINotifyName, Timeout = 9.0 })
				waitUntil( enemy.AINotifyName, aiData.AIThreadName or enemy.AIThreadName )
			else
				AIWait(fireInterval or 0, enemy, aiData.AIThreadName or enemy.AIThreadName)
			end
		end
	else
		DoWeaponFire( enemy, aiData )
	end

	if aiData.WaitUntilProjectileDeath ~= nil then
		enemy.AINotifyName = "ProjectilesDead"..enemy.ObjectId
		NotifyOnProjectilesDead({ Name = aiData.WaitUntilProjectileDeath, Notify = enemy.AINotifyName })
		waitUntil( enemy.AINotifyName, aiData.AIThreadName or enemy.AIThreadName )
	elseif aiData.FireWaitForAnimation and aiData.FireAnimation ~= nil then
		enemy.AINotifyName = "FireWaitForAnimation"..enemy.ObjectId
		NotifyOnAnimationTimeRemaining({ Id = enemy.ObjectId, Animation = aiData.FireAnimation, Remaining = 0, Notify = enemy.AINotifyName, Timeout = 9.0 })
		waitUntil( enemy.AINotifyName, aiData.AIThreadName or enemy.AIThreadName )
	else
		AIWait(aiData.FireDuration, enemy, aiData.AIThreadName or enemy.AIThreadName, { MinWaitTime = aiData.FireDurationMinWaitTime })
	end


	if aiData.RemoveUnitCollisionDuringAttack or aiData.AddUnitCollisionDuringAttack then
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = defaultCollideWithUnits })
	end
	if aiData.AddProjectileCollisionDuringAttack or aiData.RemoveProjectileCollisionDuringAttack then
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = defaultStopsProjectiles })
	end

	if enemy.WeaponFireLoopingSoundId ~= nil then
		StopSound({ Id = enemy.WeaponFireLoopingSoundId, Duration = 0.4 })
	end

	if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
		return false
	end

	if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt)  then
		if not WeaponData[enemy.WeaponName].SkipInterruptIdle then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
		end
		return true
	end

	if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
		aiData.ForcedEarlyExit = true
		return true
	end

	-- Post-attack recover window
	if aiData.ReloadingLoopSound ~= nil then
		enemy.ReloadSoundId = PlaySound({ Name = aiData.ReloadingLoopSound, Id = enemy.ObjectId })
	end
	if aiData.FireFx ~= nil then
		StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.FireFx })
	end

	if aiData.FireRotationDampening ~= nil then
		ClearEffect({ Id = enemy.ObjectId, Name = enemy.Name .. "FireRotationDampening" })
	end

	if aiData.ApplyEffectsOnWeaponFire ~= nil and aiData.ClearWeaponFireEffectsOnFireEnd then
		for k, effectData in pairs(aiData.ApplyEffectsOnWeaponFire) do
			ClearEffect({ Id = enemy.ObjectId, Name = effectData.EffectName })
		end
	end
	if aiData.ApplyEffectsOnPreAttackStart ~= nil and aiData.ClearPreAttackStartEffectsOnFireEnd then
		for k, effectData in pairs(aiData.ApplyEffectsOnPreAttackStart) do
			ClearEffect({ Id = enemy.ObjectId, Name = effectData.EffectName })
		end
	end
	StopSound({ Id = enemy.ReloadSoundId, Duration = 0.2 })

	return true

end

function DoWeaponFire( enemy, aiData )
	if aiData.AIChargeTargetMarker then
		FinishTargetMarker( enemy )
	end

	if aiData.PreFireAnimation then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreFireAnimation })
	end

	if aiData.PreFireFx ~= nil then
		local preAttackFx = CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreFireFx })
		table.insert(enemy.StopAnimationsOnHitStun, aiData.PreFireFx)
	end

	if aiData.ChargeSelfVelocity then
		ApplyForce({ Id = enemy.ObjectId, Speed = aiData.ChargeSelfVelocity, Angle = GetAngle({ Id = enemy.ObjectId }) + (aiData.ChargeSelfVelocityAngleOffset or 0), SelfApplied = true })
	end

	if aiData.ChargeSelfUpwardVelocity then
		ApplyUpwardForce({ Id = enemy.ObjectId, Speed = aiData.ChargeSelfUpwardVelocity })
	end

	if aiData.FireSetZHeight ~= nil then
		AdjustZLocation({ Id = enemy.ObjectId, Distance = aiData.FireSetZHeight - GetZLocation({ Id = enemy.ObjectId }), Duration = aiData.FireSetZDuration or 0 })
	end

	if aiData.PreFireDuration then
		AIWait(aiData.PreFireDuration, enemy, aiData.AIThreadName or enemy.AIThreadName, { MinWaitTime = aiData.PreFireMinWaitTime })
	end
	
	local weaponData = WeaponData[aiData.WeaponName]
	if weaponData ~= nil then
		thread( DoCameraMotion, weaponData.FireCameraMotion )
		local weaponDistanceSquared = nil
		if weaponData.FireScreenshake and weaponData.FireScreenshake.DistanceThreshold then
			weaponDistanceSquared = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })^2
		end
		thread( DoWeaponScreenshake, weaponData, "FireScreenshake", { AttackerId = enemy.ObjectId, SourceProjectile = aiData.ProjectileName, DistanceSquared = weaponDistanceSquared })
		thread( DoWeaponFireSimulationSlow, weaponData )
		thread( DoWeaponFireRumble, weaponData, ProjectileData[aiData.ProjectileName] )
		thread( DoWeaponFireRadialBlur, weaponData )
		if weaponData.FiredHeroVoiceLines ~= nil then
			thread( PlayVoiceLines, HeroVoiceLines[weaponData.FiredHeroVoiceLines], true )
		end
	else
		DebugAssert({ Condition = false, Text = "No such WeaponData "..tostring(aiData.WeaponName), Owner = "Eduardo" })
	end

	if aiData.AngleTowardsTargetWhileFiring then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
	end

	if aiData.TrackTargetDuringFire then
		Track({ Ids = { enemy.ObjectId }, DestinationIds = { aiData.TargetId } })
	end

	if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
		return false
	end
	if aiData.FireAnimation then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.FireAnimation })
	end
	if aiData.FireFx then
		local offset = CalcOffset(math.rad(GetAngle({Id = enemy.ObjectId})), aiData.FireFxOffset or 0 )
		CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.FireFx, OffsetX = offset.X, OffsetY = offset.Y })
	end
	if aiData.FireFxAtTarget then
		local offset = CalcOffset(math.rad(GetAngle({Id = enemy.ObjectId})), aiData.FireFxAtTargetOffset or 0 )
		CreateAnimation({ DestinationId = aiData.TargetId, Name = aiData.FireFxAtTarget, OffsetX = offset.X, OffsetY = offset.Y })
	end

	if aiData.ExpireProjectilesOnFire then
		ExpireProjectiles({ Names = aiData.ExpireProjectilesOnFire })
	end

	if aiData.ConditionalProjectiles ~= nil then
		local eligibleProjectileDatas = {}
		for k, projectileData in pairs(aiData.ConditionalProjectiles) do
			if IsEnemyProjectileEligible(enemy, projectileData) then
				table.insert(eligibleProjectileDatas, projectileData)
			end
		end
		if not IsEmpty(eligibleProjectileDatas) then
			local selectedProjectileData = GetRandomValue(eligibleProjectileDatas)
			OverwriteTableKeys(aiData, selectedProjectileData)
		end
	end

	if weaponData ~= nil and weaponData.Sounds ~= nil and weaponData.Sounds.WeaponFireSounds ~= nil then
		DoWeaponSounds( weaponData.Sounds.WeaponFireSounds, enemy, weaponData )
	end

	if aiData.AttackSlots ~= nil then
		ProcessAttackSlots( enemy, aiData )
	elseif aiData.FireFromTorches then
		for k, torchId in pairs(enemy.TorchIds) do
			aiData.FireFromTarget = true
			aiData.FireFromTargetId = torchId
			thread(ProcessFireProjecile, enemy, aiData)
		end
	else
		thread(ProcessFireProjecile, enemy, aiData)
	end

	if aiData.FireSelfVelocity then
		ApplyForce({ Id = enemy.ObjectId, Speed = aiData.FireSelfVelocity, Angle = GetAngle({ Id = enemy.ObjectId }) + (aiData.FireSelfVelocityAngleOffset or 0), SelfApplied = true })
	end

	if aiData.FireSelfUpwardVelocity then
		ApplyUpwardForce({ Id = enemy.ObjectId, Speed = aiData.FireSelfUpwardVelocity })
	end
end

function ProcessFireProjecile(enemy, aiData)

	AIWait(aiData.FireProjectileStartDelay, enemy, aiData.AIThreadName or enemy.AIThreadName)

	if aiData.ProjectileName == nil and aiData.NoProjectile == nil then -- Backwards compatibility for xml weapons
		FireWeaponFromUnit({ Weapon = aiData.WeaponName, Id = enemy.ObjectId, DestinationId = aiData.TargetId, AutoEquip = true })
	end

	if aiData.ProjectileName == nil or aiData.NoProjectile then
		return
	end

	if aiData.NumProjectiles then

		local projectileStartAngleOffset = aiData.ProjectileStartAngleOffset or 0
		if aiData.ProjectileStartAngleOffsetMin ~= nil and aiData.ProjectileStartAngleOffsetMax ~= nil then
			projectileStartAngleOffset = RandomFloat(aiData.ProjectileStartAngleOffsetMin, aiData.ProjectileStartAngleOffsetMax)
		end
		local projectileAngleInterval = aiData.ProjectileAngleInterval
		if aiData.ProjectileAngleEvenlySpaced then
			projectileAngleInterval = 360 / aiData.NumProjectiles
		end

		for i = 1, aiData.NumProjectiles do
			if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
				break
			end
			local projectileData = DeepCopyTable(ProjectileData[aiData.ProjectileName]) or {}
			local projectileIndexMultiplier = i - math.ceil(aiData.NumProjectiles / 2)

			if projectileAngleInterval ~= nil then
				projectileData.Angle = GetAngle({ Id = enemy.ObjectId }) + (projectileIndexMultiplier * projectileAngleInterval) + projectileStartAngleOffset
			end

			AIFireProjectile( enemy, aiData, projectileData )

			AIWait(aiData.ProjectileInterval, enemy, aiData.AIThreadName or enemy.AIThreadName)
		end
	else
		AIFireProjectile( enemy, aiData )
	end
end

function AIFireProjectile( enemy, aiData, projectileData )
	local destroyDestinationId = false
	if aiData.WeaponName ~= nil and WeaponData[aiData.WeaponName].Sounds ~= nil and WeaponData[aiData.WeaponName].Sounds.FireSounds ~= nil then
		DoWeaponSounds( WeaponData[aiData.WeaponName].Sounds.FireSounds, enemy, WeaponData[aiData.WeaponName] )
	end
	projectileData = projectileData or {}
	local projectileOwnerId = aiData.FireFromTargetId or enemy.ObjectId
	local destinationId = aiData.TargetId
	local distanceToTarget = nil
	local angle = projectileData.Angle or GetAngle({ Id = enemy.ObjectId })

	if aiData.FireFromTargetIds ~= nil then
		projectileOwnerId = GetRandomValue(aiData.FireFromTargetIds)
	end

	if ProjectileData[aiData.ProjectileName] ~= nil then
		OverwriteTableKeys( projectileData, ProjectileData[aiData.ProjectileName])
	end

	if projectileData.ProjectileFireSound ~= nil then
		PlaySound({ Name = projectileData.ProjectileFireSound, Id = enemy.ObjectId })
	end

	if aiData.FireProjectileAtTarget then
		destinationId = aiData.TargetId
	end
	if aiData.FireProjectileAtSelf then
		destinationId = enemy.ObjectId
	end

	if aiData.FireProjectileNoDestination then
		destinationId = nil
	end

	if aiData.ProjectileDestinationOffsetFromTarget then
		local offsetAngle = angle or 0
		if aiData.ProjectileOffsetRandomAngle then
			offsetAngle = RandomFloat(0, 360)
		elseif aiData.ProjectileOffsetAngle then
			offsetAngle = aiData.ProjectileOffsetAngle
		end

		local offsetDistance = aiData.ProjectileOffsetDistance
		if aiData.ProjectileOffsetDistanceMin ~= nil and aiData.ProjectileOffsetDistanceMax ~= nil then
			offsetDistance = RandomFloat(aiData.ProjectileOffsetDistanceMin, aiData.ProjectileOffsetDistanceMax)
		end

		local offset = CalcOffset(math.rad(offsetAngle), offsetDistance)
		if aiData.ProjectileOffsetDistanceScaleY ~= nil then
			offset.Y = offset.Y * aiData.ProjectileOffsetDistanceScaleY
		end

		destinationId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = aiData.TargetId, Group = "Scripting", OffsetX = offset.X, OffsetY = offset.Y })
		destroyDestinationId = true
	elseif aiData.ProjectileLeadTarget then
		local targetFacingAngle = GetAngle({ Id = destinationId })
		local targetVelocity = GetVelocity({ Id = destinationId })
		local velocityMultiplier = aiData.ProjectileLeadMultiplier or 1
		local offset = CalcOffset( math.rad(targetFacingAngle), targetVelocity * velocityMultiplier * 0.5 )
		destinationId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = destinationId, OffsetX = offset.X, OffsetY = offset.Y, Group = "Scripting" })
		destroyDestinationId = true
	end

	if aiData.NoProjectileAngle then
		angle = nil
	end
	if aiData.FireProjectileTowardTarget then
		distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
		angle = GetAngleBetween({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
	end
	if aiData.CalculateDistanceToTarget then
		distanceToTarget = GetDistance({ Id = destinationId or enemy.ObjectId, DestinationId = aiData.TargetId })
	end
	if aiData.FireProjectileAngle then
		angle = aiData.FireProjectileAngle
	end
	if aiData.FireProjectileAngleRelative then
		angle = GetAngle({ Id = enemy.ObjectId }) + aiData.FireProjectileAngleRelative
	end
	if aiData.FireAsPlayerProjectile then
		projectileOwnerId = CurrentRun.Hero.ObjectId
	end
	
	if aiData.Spread ~= nil then
		angle = angle or GetAngle({ Id = enemy.ObjectId })
		angle = angle + RandomFloat(-aiData.Spread, aiData.Spread)
	end

	if aiData.SpawnFromRandomMarker ~= nil then
		aiData.SpawnFromMarker = GetRandomValue(aiData.SpawnFromRandomMarker)
	end

	if aiData.SkipIfInvalidLocation and IsLocationBlocked({ Id = destinationId }) then
		return
	end

	local fuseSound = nil
	if projectileData.Fuse ~= nil and projectileData.Fuse > 0 then
		if not destroyDestinationId then -- Fuse is threaded so we need a new script target since the enemy will clean TargetId up before firing
			if projectileData.ReticleAnimation then
				destinationId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = destinationId, Group = projectileData.ReticleGroupName or "FX_Terrain_Top" })
			else
				destinationId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = destinationId, Group = "Scripting" })
			end
			destroyDestinationId = true
			enemy.DestroyIdsOnDeath = enemy.DestroyIdsOnDeath or {}
			table.insert(enemy.DestroyIdsOnDeath, destinationId)
		end

		if projectileData.ReticleAnimation ~= nil then
			local damageRadius = GetBaseDataValue({ Type = "Projectile", Name = aiData.ProjectileName, Property = "DamageRadius" })
			SetAnimation({ Name = projectileData.ReticleAnimation, DestinationId = destinationId, ScaleRadius = damageRadius, Group = "FX_Terrain_Top" })
			if projectileData.ReticleUseProjectileAngle then
				if aiData.AttackSlots ~= nil then
					SetAngle({ Id = destinationId, Angle = aiData.Angle })
				else
					SetAngle({ Id = destinationId, Angle = angle })
				end
			end
			if not enemy.IgnoreTimeSlowEffects and GetGameplayElapsedTimeMultiplier() ~= 1 then
				SetAnimationSpeedMultiplier({ DestinationId = destinationId, PlaySpeed = GetGameplayElapsedTimeMultiplier() })
			end
			MapState.Reticles[destinationId] = projectileData.ReticleAnimation
		end

		if projectileData.FuseSound ~= nil or aiData.FuseSound ~= nil then
			fuseSound = PlaySound({ Name = projectileData.FuseSound or aiData.FuseSound, Id = destinationId })
			enemy.ProjectileFuseSoundIds = enemy.ProjectileFuseSoundIds or {}
			enemy.ProjectileFuseSoundIds[fuseSound] = true
		end

		if projectileData.OrbitOwner then
			thread(OrbitId, destinationId, projectileOwnerId, projectileData.Fuse - projectileData.OrbitOwnerDetonateBuffer, projectileData.OrbitSpeed)
		end

		if projectileData.WanderToOwner then
			thread(WanderToId, destinationId, projectileData)
		end

		wait(projectileData.Fuse, enemy.AIThreadName)

		if projectileData.CancelIfOwnerAIStageEnd and (ReachedAIStageEnd(enemy) or enemy.InTransition) then
			if projectileData.ReticleAnimation ~= nil then
				StopAnimation({ Name = projectileData.ReticleAnimation, DestinationId = destinationId })
			end
			if destroyDestinationId then
				Destroy({ Id = destinationId })
				MapState.Reticles[destinationId] = nil
			end
			return
		end
	end

	CurrentRun.ProjectileRecord[aiData.ProjectileName] = (CurrentRun.ProjectileRecord[aiData.ProjectileName] or 0) + 1
	GameState.ProjectileRecord[aiData.ProjectileName] = (GameState.ProjectileRecord[aiData.ProjectileName] or 0) + 1
	local projectileSpeedMultiplier = 1
	if not enemy.SkipModifiers and not aiData.ImmuneToProjectileSlow and not enemy.AlwaysTraitor then
		projectileSpeedMultiplier = GetTotalHeroTraitValue("EnemyProjectileSpeedMultiplier", {IsMultiplier = true, Multiplicative = true })
	end
	local projectileId = CreateProjectileFromUnit({ Name = aiData.ProjectileName, Id = projectileOwnerId, DestinationId = destinationId, FireFromTarget = aiData.FireFromTarget, SpeedMultiplier = projectileSpeedMultiplier, FiredByTraitor = aiData.FireAlliedToPlayer,
								BarrelLength = aiData.BarrelLength, SpawnFromMarker = aiData.SpawnFromMarker, ScaleMultiplier = enemy.ProjectileScaleMultiplier, BlastRadiusModifier = enemy.ProjectileBlastRadiusMultiplier, RequireLoS = aiData.RequireLoS, Range = aiData.Range or distanceToTarget or 0, MarkerPersistsAngleToTarget = aiData.TargetSpawnPoints, Angle = angle })

	if projectileData.ReticleAnimation ~= nil then
		StopAnimation({ Name = projectileData.ReticleAnimation, DestinationId = destinationId })
	end
	if fuseSound ~= nil then
		StopSound({ Id = fuseSound, Duration = projectileData.StopSoundOnFinishFade or 0.2 })
		enemy.ProjectileFuseSoundIds[fuseSound] = false
	end
	if aiData.SetAngleTowardProjectileAngle then
		SetAngle({ Id = enemy.ObjectId, Angle = angle })
	end
	if aiData.AngleTowardProjectileDestination then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = destinationId })
	end

	if projectileData.ExpireOldestCap ~= nil then
		SessionMapState.ExpireOldestProjectiles[projectileId] = true
		table.insert( SessionMapState.ExpireOldestProjectilesOrder, projectileId )
		while TableLength( SessionMapState.ExpireOldestProjectilesOrder ) > projectileData.ExpireOldestCap do
			local oldestProjectileId = table.remove( SessionMapState.ExpireOldestProjectilesOrder, 1 )
			--DebugPrint({ Text = "oldestProjectileId = "..oldestProjectileId })
			if SessionMapState.ExpireOldestProjectiles[oldestProjectileId] ~= nil then
				--DebugPrint({ Text=oldestProjectileId })
				ExpireProjectiles({ ProjectileId = oldestProjectileId })
			end
		end
	end

	if projectileData.CarriesSpawns then
		if enemy.RequiredKill then 
			SessionMapState.ProjectilesCarryingSpawns[projectileId] = true
		end
		SessionMapState.ProjectileSpawnRecord[projectileId] = enemy.ObjectId
	end

	if aiData.EndScale ~= nil then
		SetProjectileScale({ Id = projectileId, Fraction = aiData.EndScale, Duration = aiData.ScaleDuration })
	end

	if aiData.ExpireProjectilesOnHitStun then
		table.insert(enemy.ExpireProjectileIdsOnHitStun, projectileId)
	end
	if aiData.ExpireProjectilesOnFreeze then
		table.insert(enemy.ExpireProjectileIdsOnFreeze, projectileId)
	end
	if aiData.ExpireProjectilesOnPolymorph then
		table.insert(enemy.ExpireProjectileIdsOnPolymorph, projectileId)
	end
	if aiData.DamageRadiusFractionByHealthPercent then
		table.insert(enemy.DamageRadiusIdsByHealthPercent, projectileId)
		SetDamageRadiusMultiplier({ Id = projectileId, Fraction = enemy.Health / enemy.MaxHealth , Duration = 0.0 })
	end

	if aiData.FireTickSelfVelocity ~= nil then
		local velocityMultiplier = 1
		if aiData.FireTick ~= nil and aiData.FireTickSelfVelocityConsecutiveMultiplier then
			velocityMultiplier = aiData.FireTickSelfVelocityConsecutiveMultiplier ^ aiData.FireTick
		end
		ApplyForce({ Id = enemy.ObjectId, Speed = aiData.FireTickSelfVelocity * velocityMultiplier, Angle = GetAngle({ Id = enemy.ObjectId }) + (aiData.FireTickSelfVelocityAngleOffset or 0), SelfApplied = true })
	end

	if destroyDestinationId then
		Destroy({ Id = destinationId })
		MapState.Reticles[destinationId] = nil
	end
end

function ProcessAttackSlots( enemy, aiData )
	local enemyOriginalPosition = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, Group = "Scripting" })
	local targetOriginalPosition = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = aiData.TargetId, Group = "Scripting" })
	local numAttacks = #aiData.AttackSlots
	if aiData.AttackSlotsPerTick ~= nil or (aiData.AttackSlotsPerTickMin ~= nil and aiData.AttackSlotsPerTickMax ~= nil) then
		numAttacks = aiData.AttackSlotsPerTick or RandomInt(aiData.AttackSlotsPerTickMin, aiData.AttackSlotsPerTickMax)
	end

	local attackSlots = DeepCopyTable(aiData.AttackSlots)
	local removeNum = aiData.RemoveAttackSlotCount or TableLength(aiData.AttackSlots) - numAttacks
	local skipIndexes = {}
	for k = 1, removeNum, 1 do
		table.insert(skipIndexes, RemoveRandomKey(attackSlots))
	end

	local randomAngle = nil
	if aiData.UseRandomAngle then
		randomAngle = RandomFloat(0, 360)
	end

	if aiData.RandomizeAttackSlotOrder then
		 FYShuffle(aiData.AttackSlots)
	end

	for k, attackSlot in ipairs(aiData.AttackSlots) do
		if not Contains(skipIndexes, k) then
			aiData.Angle = attackSlot.Angle or randomAngle or 0
			if attackSlot.UseAngleBetween then
				aiData.Angle = GetAngleBetween({ Id = enemyOriginalPosition, DestinationId = targetOriginalPosition })
			elseif attackSlot.UseAttackerAngle then
				aiData.Angle = GetAngle({ Id = enemy.ObjectId })
			elseif attackSlot.UseRandomAngle then
				aiData.Angle = RandomFloat(0, 360)
			end
			aiData.Angle = aiData.Angle + (attackSlot.OffsetAngle or 0)

			if attackSlot.OffsetDistanceMin ~= nil and attackSlot.OffsetDistanceMax ~= nil then
				attackSlot.OffsetDistance = RandomFloat(attackSlot.OffsetDistanceMin, attackSlot.OffsetDistanceMax)
			end

			local offset = CalcOffset(math.rad(aiData.Angle), attackSlot.OffsetDistance or 0)
			if attackSlot.OffsetX ~= nil then
				offset.X = offset.X + attackSlot.OffsetX
			end
			if attackSlot.OffsetY ~= nil then
				offset.Y = offset.Y + attackSlot.OffsetY
			end
			if attackSlot.OffsetRadius ~= nil then
				offset.X = offset.X + RandomFloat(-attackSlot.OffsetRadius, attackSlot.OffsetRadius)
				offset.Y = offset.Y + RandomFloat(-attackSlot.OffsetRadius, attackSlot.OffsetRadius)
			end

			local anchor = targetOriginalPosition
			if attackSlot.UseMapObjectId then
				if type(attackSlot.UseMapObjectId) == "table" then
					anchor = attackSlot.UseMapObjectId[CurrentRun.CurrentRoom.Name]
				else
					anchor = attackSlot.UseMapObjectId
				end
			elseif attackSlot.OffsetFromAttacker then
				anchor = enemy.ObjectId
			elseif attackSlot.UseTargetPosition then
				anchor = aiData.TargetId
			end

			if attackSlot.AnchorOffset ~= nil then
				local anchorOffset = CalcOffset(math.rad(GetAngle({ Id = anchor })), attackSlot.AnchorOffset)
				anchor = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = anchor, OffsetX = anchorOffset.X, OffsetY = anchorOffset.Y })
			end

			local angleOffset = CalcOffset(math.rad(aiData.Angle + GetAngle({ Id = anchor })), attackSlot.AnchorAngleOffset or 50)
			offset.X = offset.X + angleOffset.X
			offset.Y = offset.Y + angleOffset.Y

			if attackSlot.OffsetScaleY ~= nil then
				offset.Y = offset.Y * attackSlot.OffsetScaleY
			end
			local targetOffset = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = anchor, OffsetX = offset.X, OffsetY = offset.Y })

			if attackSlot.TeleportToId then
				Teleport({ Id = enemy.ObjectId, DestinationId = attackSlot.TeleportToId })
			end
			if attackSlot.InstantAngleTowardsTarget then
				AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = targetOffset })
			end

			AIWait(aiData.AttackSlotPreFireWait, enemy, aiData.AIThreadName or enemy.AIThreadName)

			if attackSlot.ProjectileName ~= nil or aiData.ProjectileName ~= nil then
				local projectileAIData = DeepCopyTable(aiData)
				projectileAIData.ProjectileName = attackSlot.ProjectileName or aiData.ProjectileName
				projectileAIData.TargetId = targetOffset
				if attackSlot.AIDataOverrides ~= nil then
					projectileAIData = DeepCopyTable(projectileAIData)
					OverwriteTableKeys(projectileAIData, attackSlot.AIDataOverrides)
				end
				thread(ProcessFireProjecile, enemy, projectileAIData)
			elseif aiData.NoProjectile then
				--
			else
				FireWeaponFromUnit({ Weapon = aiData.WeaponName, Id = enemy.ObjectId, DestinationId = targetOffset, AutoEquip = true })
			end

			thread( DestroyOnDelay, { targetOffset }, CalcEnemyWait( enemy, aiData.FireProjectileStartDelay) + 0.1 )
			if attackSlot.AnchorOffset ~= nil then
				Destroy({ Id = anchor })
			end
			if attackSlot.PauseDuration then
				AIWait(attackSlot.PauseDuration, enemy, aiData.AIThreadName or enemy.AIThreadName)
			end
			if aiData.AttackSlotInterval then
				AIWait(aiData.AttackSlotInterval, enemy, aiData.AIThreadName or enemy.AIThreadName)
			end

			if ReachedAIStageEnd(enemy) then
				aiData.ForcedEarlyExit = true
				return true
			end

			if aiData.EndAttackSlotsOnHit and not CanAttack({ Id = enemy.ObjectId }) then
				return false
			end
		end
	end
	Destroy({ Id = enemyOriginalPosition })
	Destroy({ Id = targetOriginalPosition })
end

function MoveToRandomLocation( enemy, originId, radius, radiusMin, timeout )
	-- Move to a random location
	local randomOffsetX = RandomFloat( radiusMin or 0, radius )
	local randomOffsetY = RandomFloat( radiusMin or 0, radius )
	if CoinFlip() then
		randomOffsetX = randomOffsetX * -1
	end
	if CoinFlip() then
		randomOffsetY = randomOffsetY * -1
	end
	local randomNewTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = originId, OffsetX = randomOffsetX, OffsetY = randomOffsetY, Group = "Standing" })
	Move({ Id = enemy.ObjectId, DestinationId = randomNewTargetId, SuccessDistance = 75 })

	-- Wait until within range of target positon
	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId

	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = randomNewTargetId, Distance = 50, Notify = enemy.AINotifyName, Timeout = timeout or 3.0 })
	waitUntil( enemy.AINotifyName )

	Destroy({ Id = randomNewTargetId })
end

function DumbFireAttack( enemy, weaponData )
	enemy.DumbFireThreadName = "DumbFireThreadName"..enemy.ObjectId
	local weaponName = weaponData.Name

	local aiData = ShallowCopyTable(enemy.DefaultAIData) or {}
	DebugAssert({ Condition = enemy.DefaultAIData ~= nil, Text = enemy.Name.." has no DefaultAIData", Owner = "Eduardo" })
	if weaponData ~= nil then
		if weaponData.AIData ~= nil then
			OverwriteTableKeys( aiData, weaponData.AIData)
		else
			OverwriteTableKeys( aiData, weaponData)
		end
	end
	aiData.WeaponName = weaponName

	if aiData.AlwaysUseDumbFireThreadName then
    	aiData.AIThreadName = enemy.DumbFireThreadName
	end

	if aiData.CancelIfNoComboPartner and (enemy.ComboPartnerId == nil or ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead ) then
		return
	end

	if aiData.CancelOutsideDistanceFromComboPartner and GetDistance({ Id = enemy.ObjectId, DestinationId = enemy.ComboPartnerId }) > aiData.CancelOutsideDistanceFromComboPartner then
		return

	end

	local preAttackDuration = aiData.PreAttackDuration
	if aiData.PreAttackDurationMin ~= nil and aiData.PreAttackDurationMax ~= nil then
		preAttackDuration = RandomFloat(aiData.PreAttackDurationMin, aiData.PreAttackDurationMax)
	end

	if aiData.PreAttackVoiceLines ~= nil then
		thread( PlayVoiceLines, aiData.PreAttackVoiceLines, nil, enemy )
	end

	wait( CalcEnemyWait( enemy, preAttackDuration ), enemy.DumbFireThreadName )
	local timesFired = 0
	while IsAIActive( enemy ) do
		if enemy.IsPolymorphed and aiData.CancelOnPolymorph then
			return
		end

		aiData.TargetId = GetTargetId(enemy, aiData)

		local fireTicks = aiData.FireTicks or 1
		if aiData.FireTicksMin ~= nil and aiData.FireTicksMax ~= nil then
			fireTicks = RandomInt( aiData.FireTicksMin, aiData.FireTicksMax )
		end

		if aiData.TargetId ~= nil then
			for fireTick = 1, fireTicks, 1 do
				if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
					break
				end
				if enemy[aiData.EndOnFlagName] then
					break
				end
				if aiData.ResetTargetPerTick then
					aiData.TargetId = GetTargetId(enemy, aiData)
				end

				if aiData.FireFxAtTarget ~= nil then
					CreateAnimation({ DestinationId = aiData.TargetId, Name = aiData.FireFxAtTarget })
				end

				if aiData.FireFunctionName ~= nil then
					CallFunctionName( aiData.FireFunctionName ,enemy, aiData, CurrentRun )
				end

				if aiData.SpawnBurstOnFire then
					thread(HandleSpawnerBurst, enemy, aiData)
				end

				if aiData.DumbFireWeapons ~= nil then
					for k, weaponName in pairs( aiData.DumbFireWeapons ) do
						local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
						weaponData.Name = weaponName
						thread( DumbFireAttack, enemy, weaponData )
					end
				end

				DoWeaponFire( enemy, aiData )
				wait( CalcEnemyWait( enemy, aiData.FireInterval), enemy.DumbFireThreadName )


				if enemy.CreatedOwnTarget then
					Destroy({ Id = enemy.CreatedOwnTarget })
				end
			end
		end

		timesFired = timesFired + 1
		if aiData.EndDumbFireOnTimesFired ~= nil and timesFired >= aiData.EndDumbFireOnTimesFired then
			break
		end

		if aiData.PostAttackDurationMin ~= nil and aiData.PostAttackDurationMax ~= nil then
			local waitTime = RandomFloat(aiData.PostAttackDurationMin, aiData.PostAttackDurationMax)
			wait( CalcEnemyWait( enemy, waitTime ), enemy.DumbFireThreadName )
		else
			wait( CalcEnemyWait( enemy, aiData.PostAttackDuration ), enemy.DumbFireThreadName )
		end


		local dumbFireInterval = aiData.DumbFireInterval
		if aiData.DumbFireIntervalMin ~= nil and aiData.DumbFireIntervalMax ~= nil then
			dumbFireInterval = RandomFloat( aiData.FireIntervalMin, aiData.FireIntervalMax )
		end
		wait( CalcEnemyWait( enemy, dumbFireInterval), enemy.DumbFireThreadName )

		if dumbFireInterval == nil then
			break
		end

		if enemy[aiData.EndOnFlagName] then
			break
		end

	end

	if aiData.ChainedWeaponOptions ~= nil then
		local elligibleWeapons = {}
		for k, weaponName in pairs(aiData.ChainedWeaponOptions) do
			local weaponData = WeaponData[weaponName]
			if IsEnemyWeaponEligible(enemy, weaponData) then
				if IsEnemyWeaponForced(enemy, weaponData) then
					aiData.ChainedWeapon = weaponName
					break
				else
					table.insert(elligibleWeapons, weaponName)
				end
			end
		end
		aiData.ChainedWeapon = GetRandomValue(elligibleWeapons)
	end

	if aiData.ChainedWeapon ~= nil then
		local newWeaponData = WeaponData[aiData.ChainedWeapon].AIData or WeaponData[aiData.ChainedWeapon]
		newWeaponData.Name = aiData.ChainedWeapon
		DumbFireAttack( enemy, newWeaponData )
	end
end

function SpawnChronosBanners( enemy, aiData )
	local newEnemy = DeepCopyTable( EnemyData.BattleStandard )
	local spawnPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, newEnemy, { SpawnNearId = enemy.ObjectId, SpawnRadius = aiData.SpawnRadius, SpawnRadiusMin = aiData.SpawnRadiusMin, RequiredSpawnPoint = aiData.RequiredSpawnPointType })
	newEnemy.ObjectId = SpawnUnit({ Name = "BattleStandard", Group = "Standing", DestinationId = spawnPointId, ForceToValidLocation = true })
	newEnemy.OccupyingSpawnPointId = spawnPointId
	if enemy.Encounter ~= nil then
		enemy.Encounter.ActiveSpawns[newEnemy.ObjectId] = true
		newEnemy.Encounter = enemy.Encounter
	end
	SessionMapState.SpawnPointsUsed[spawnPointId] = newEnemy.ObjectId
	thread(SetupUnit, newEnemy, CurrentRun )
end

function HandleSpawnerBurst(enemy, aiData)
	enemy.SpawnerThreadName = "SpawnerThreadName"..enemy.ObjectId
	local spawnGroupName = "Spawner"..enemy.ObjectId

	local originalColor = enemy.Color

	local spawnCount = aiData.SpawnsPerBurst
	if aiData.SpawnsPerBurstMin ~= nil and aiData.SpawnsPerBurstMax ~= nil then
		spawnCount  = RandomInt(aiData.SpawnsPerBurstMin, aiData.SpawnsPerBurstMax)
	end

	if aiData.SpawnCountDampenTraits ~= nil then
		for traitName in pairs(aiData.SpawnCountDampenTraits) do
			if HeroHasTrait(traitName) then
				local traitData = GetHeroTrait( traitName )
				if traitData and traitData.DebuffValue then
					spawnCount = spawnCount * traitData.DebuffValue 
				end
			end
		end
	end

	wait(aiData.SpawnBurstDelay, enemy.SpawnerThreadName)

	local spawnOnIds = ShallowCopyTable(aiData.SpawnOnIds)
	local spawnOnIdsOrdered = ShallowCopyTable(aiData.SpawnOnIdsOrdered)

	for i=1, spawnCount do
		if NumAlive({ Name = spawnGroupName }) < aiData.MaxActiveSpawns and IsAIActive( enemy ) then

			if not aiData.SkipLocationBlockedCheck and IsLocationBlocked({ Id = enemy.ObjectId }) then
				return
			end

			if aiData.SpawnSound ~= nil then
				PlaySound({ Name = aiData.SpawnSound, Id = enemy.ObjectId })
			end
			if aiData.SpawnColor ~= nil then
				SetColor({ Color = aiData.SpawnColor, Id = enemy.ObjectId })
			end

			if aiData.CreateSpawnAnimation then
				SetAnimation({ DestinationId = aiData.ObjectId, Name = aiData.CreateSpawnAnimation })
			end

			-- Spawn enemy
			local spawnName = GetRandomValue(aiData.SpawnerOptions)

			local enemyData = EnemyData[spawnName]
			local newEnemy = DeepCopyTable( enemyData )
			ClearLootDrops( newEnemy )
			newEnemy.SkipChallengeKillCounts = true

			local offset = { X = 0, Y = 0 }
			local spawnPointId = aiData.SpawnOnId or RemoveFirstValue(spawnOnIdsOrdered) or RemoveRandomValue(spawnOnIds) or GetRandomValue(GetIds({ Name = aiData.SpawnOnGroupName }))
			
			local spawnNearId = enemy.ObjectId
			if aiData.SpawnNearPlayer then
				spawnNearId = CurrentRun.Hero.ObjectId
			end

			if spawnPointId == nil then
				if aiData.SpawnOnSpawnPoints then
					local newSpawnPoint = SelectSpawnPoint(CurrentRun.CurrentRoom, newEnemy, {SpawnNearId = spawnNearId, SpawnRadius = aiData.SpawnRadius, SpawnRadiusMin = aiData.SpawnRadiusMin, RequiredSpawnPoint = aiData.RequiredSpawnPointType })
					spawnPointId = newSpawnPoint
				elseif aiData.SpawnTowardSpawnPoints then
					spawnPointId = spawnNearId
					local closestSpawnPoint = GetClosest({ Id = spawnNearId, DestinationName = "SpawnPoints" })
					local angle = GetAngleBetween({ Id = spawnNearId, DestinationId = closestSpawnPoint })
					offset = CalcOffset( math.rad(angle), math.min(110, GetDistance({ Id = spawnNearId, DestinationId = closestSpawnPoint })) )
				elseif aiData.SpawnRadius ~= nil then
					offsetX = RandomInt(-aiData.SpawnRadius, aiData.SpawnRadius)
					offsetY = RandomInt(-aiData.SpawnRadius, aiData.SpawnRadius)
				end
			end

			if spawnPointId == nil then
				spawnPointId = enemy.ObjectId
			end
			newEnemy.ObjectId = SpawnUnit({ Name = spawnName, Group = "Standing", DestinationId = spawnPointId, OffsetX = offset.X, OffsetY = offset.Y })
			newEnemy.OccupyingSpawnPointId = spawnPointId
			if enemy.Encounter ~= nil then
				enemy.Encounter.ActiveSpawns[newEnemy.ObjectId] = true
				newEnemy.Encounter = enemy.Encounter
			end
			SessionMapState.SpawnPointsUsed[spawnPointId] = newEnemy.ObjectId
			thread( UnoccupySpawnPointOnDistance, newEnemy, spawnPointId, 400 )
			local charmDuration = GetCharmDuration({ Id = enemy.ObjectId })

			if aiData.SpawnedAggroTetherDistance ~= nil then
				newEnemy.AggroTetherId = enemy.ObjectId
				newEnemy.AggroTetherDistance = aiData.SpawnedAggroTetherDistance
			end
			if aiData.SpawnAggroed then
				newEnemy.StartAggroed = true
			end
			if aiData.SpawnsSkipActivatePresentation then
				newEnemy.UseActivatePresentation = false
			end
			if aiData.SpawnFx then
				CreateAnimation({ DestinationId = newEnemy.ObjectId, Name = aiData.SpawnFx })
			end
			thread(SetupUnit, newEnemy, CurrentRun )
			AddToGroup({ Id = newEnemy.ObjectId, Name = spawnGroupName })
			newEnemy.SkipActiveCount = true
			if charmDuration > 0 then			
				ApplyEffect({ 
					Id = CurrentRun.Hero.ObjectId, 
					DestinationId = newEnemy.ObjectId, 
					EffectName = "Charm",
					DataProperties = 
					{
						Type = "CHARM",
						Duration = charmDuration,
						Active = true,
						TimeModifierFraction = 0,
					}
				})
			end
			wait( CalcEnemyWait( enemy, aiData.SpawnRate), enemy.SpawnerThreadName )
		end
	end

	if aiData.PostCreateSpawnAnimation then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PostCreateSpawnAnimation })
	end
	if aiData.SpawnColor ~= nil then
		SetColor({ Color = originalColor, Id = enemy.ObjectId, Duration = aiData.PostAttackCooldown })
	end
end

function ClearLootDrops( enemyData )
	enemyData.MoneyDropOnDeath = nil
	enemyData.MoneyDropOnHit = nil
end

function BlendInAI( enemy )

	local firstLoop = true

	enemy.WeaponName = SelectWeapon( enemy )
	table.insert( enemy.WeaponHistory, enemy.WeaponName )
	local aiData = GetWeaponAIData(enemy)

	while IsAIActive( enemy ) do
		enemy.ForcedWeaponInterrupt = nil
		
		-- Teleportation
		if aiData.TeleportToSpawnPoints then
			HandleEnemyTeleportation(enemy, aiData)
		end

		aiData.TargetId = GetTargetId(enemy, aiData)
		-- Find target to blend with
		local blendWithId = 0
		if enemy.BlendWithRandom then
			blendWithId = GetRandomValue( GetIdsByType({ Name = aiData.BlendWithNames }) )
		else
			blendWithId = GetClosestUnitOfType({ Id = aiData.TargetId, DestinationNames = aiData.BlendWithNames, MinDistance = aiData.BlendMinDistance, Distance = aiData.BlendMaxDistance })
		end
		if blendWithId > 0 then

			while true do
				-- Move to target
				Move({ Id = enemy.ObjectId, DestinationId = blendWithId, SuccessDistance = aiData.MoveSuccessDistance })

				-- Wait until within range
				enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
				local timeout = aiData.AttackWhileMovingInterval
				if timeout == nil and aiData.AttackWhileMovingIntervalMin ~= nil and aiData.AttackWhileMovingIntervalMax ~= nil then
					timeout = RandomFloat(aiData.AttackWhileMovingIntervalMin, aiData.AttackWhileMovingIntervalMax)
				end
				NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = blendWithId, Distance = aiData.MoveSuccessDistance,
					StopsUnits = aiData.RequireUnitLoS, StopsProjectiles = aiData.RequireProjectileLoS,
					LineOfSightBuffer = aiData.LoSBuffer,
					LineOfSightEndBuffer = aiData.LoSEndBuffer,
					Notify = enemy.AINotifyName, Timeout = timeout })
				waitUntil( enemy.AINotifyName, enemy.AIThreadName )

				Stop({ Id = enemy.ObjectId })
				if _eventTimeoutRecord[enemy.AINotifyName] then
					if enemy.LayDrop then
						LayDrop( enemy, aiData, CurrentRun )
					else
						DoAttack( enemy, aiData )
					end
				else
					-- Reached goal
					break
				end

				if not IsAlive({ Id = blendWithId }) then
					-- Target was killed
					blendWithId = GetClosestUnitOfType({ Id = enemy.ObjectId, DestinationNames = aiData.BlendWithNames, MinDistance = aiData.BlendMinDistance, Distance = aiData.BlendMaxDistance })
					if blendWithId == 0 then
						-- No other target to switch to
						break
					end
				end

			end

			wait( CalcEnemyWait( enemy, aiData.BlendInTime), enemy.AIThreadName )
		else
			-- No target found
			MoveToRandomLocation( enemy, enemy.ObjectId, aiData.AIWanderDistance, aiData.AIWanderDistanceMin, aiData.AIWanderDistanceDuration )
			wait( CalcEnemyWait( enemy, 0.02), enemy.AIThreadName )
		end

		local blendTimeout = RandomFloat( aiData.BlendTimeoutMin, aiData.BlendTimeoutMax )
		if aiData.AttackWhileBlending then
			blendTimeout = RandomFloat( aiData.AttackWhileBlendingIntervalMin, aiData.AttackWhileBlendingIntervalMax )
		end

		-- Wait for player to come close as long as you're not the last alive
		local consecutiveAttacks = 0
		while TableLength( RequiredKillEnemies ) > 1 and (aiData.MaxConsecutiveAttacks == nil or consecutiveAttacks < aiData.MaxConsecutiveAttacks) do
			consecutiveAttacks = consecutiveAttacks + 1

			enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
			NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, Distance = aiData.AttackDistance, Notify = enemy.AINotifyName, Timeout = blendTimeout })
			waitUntil( enemy.AINotifyName )

			if _eventTimeoutRecord[enemy.AINotifyName] then
				if enemy.LayDrop then
					LayDrop( enemy, aiData, CurrentRun )
				else
					DoAttackerAILoop( enemy, aiData )
					SurroundEnemiesAttacking[aiData.SurroundAIKey or enemy.Name][enemy.ObjectId] = nil
				end
			else
				-- Reached goal
				break
			end
		end

		-- Lay drop when you start moving again
		if aiData.AttackOnMoveStart or TableLength( RequiredKillEnemies ) <= 1 then
			if enemy.LayDrop then
				LayDrop( enemy, aiData, CurrentRun )
			else
				DoAttackerAILoop( enemy, aiData )
				SurroundEnemiesAttacking[aiData.SurroundAIKey or enemy.Name][enemy.ObjectId] = nil
			end
			wait( CalcEnemyWait( enemy, aiData.PostAttackOnMoveStartWait), enemy.AIThreadName )
		end

		firstLoop = false

	end

end

function LayDrop( enemy, aiData )

	local spawnGroupName = "Spawner"..enemy.ObjectId
	enemy.Spawns = enemy.Spawns or {}

	if aiData.MaxActiveSpawns == nil or NumAlive({ Name = spawnGroupName }) < aiData.MaxActiveSpawns then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreLayDropAnimation })
		wait( CalcEnemyWait( enemy, aiData.PreAttackDuration), enemy.AIThreadName )

		local newEnemy = nil
		if aiData.SpawnDropAsUnit then
			newEnemy = DeepCopyTable( EnemyData[aiData.DropName] )
			newEnemy.ObjectId = SpawnUnit({ Name = aiData.DropName, Group = "Standing", DestinationId = enemy.ObjectId })
			thread(SetupUnit, newEnemy, CurrentRun )
		elseif aiData.SpawnDropAsConsumable then
			local consumableId = SpawnObstacle({ Name = aiData.DropName, DestinationId = enemy.ObjectId, Group = "Standing" })
			newEnemy = CreateConsumableItem( consumableId, aiData.DropName )
			ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( 500, 700 ) })
			ApplyForce({ Id = consumableId, Speed = RandomFloat( 75, 560 ), Angle = RandomFloat( 0, 360 ) })
		else
			newEnemy = DeepCopyTable( ObstacleData[aiData.DropName] )
			newEnemy.ObjectId = SpawnObstacle({ Name = aiData.DropName, Group = "Standing", DestinationId = enemy.ObjectId })
		end
		AddToGroup({ Id = newEnemy.ObjectId, Name = spawnGroupName })
		enemy.Spawns[newEnemy.ObjectId] = newEnemy
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.LayDropAnimation })

		if aiData.DropOffsetZ ~= nil then
			AdjustZLocation({ Id = newEnemy.ObjectId, Distance = aiData.DropOffsetZ })
		end
		if aiData.DropUpwardForce ~= nil then
			ApplyUpwardForce({ Id = newEnemy.ObjectId, Speed = aiData.DropUpwardForce })
		end
		if aiData.DropScaleInDuration ~= nil then
			SetScale({ Id = newEnemy.ObjectId, Fraction = 0.0, Duration = 0.0 })
			SetScale({ Id = newEnemy.ObjectId, Fraction = 1.0, Duration = aiData.DropScaleInDuration })
		end

	end
	wait( CalcEnemyWait( enemy, enemy.PostAttackDuration), enemy.AIThreadName )

end

function MineAI( enemy )

	if enemy.TriggerDistance ~= nil then
		local enemyId = enemy.ObjectId
		enemy.AINotifyName = "WithinDistance"..enemyId

		NotifyWithinDistanceAny({ Ids = { enemyId }, DestinationNames = enemy.TriggerGroups,
									Distance = enemy.TriggerDistance, Notify = enemy.AINotifyName, Timeout = enemy.ExpirationDuration })

		waitUntil( enemy.AINotifyName )
	end

	if _eventTimeoutRecord[enemy.AINotifyName] then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DissipateAnimation or "LovesickHeartMineDissipate" })
		wait( CalcEnemyWait( enemy, 0.4), enemy.AIThreadName )
		-- SetAlpha({ Id = enemy.ObjectId, Fraction = 0.0, Duration = 1.0 })
		-- wait( CalcEnemyWait( enemy, 1.0), enemy.AIThreadName )
		enemy.OnDeathFireWeapons = nil
		--SetLifeProperty({ DestinationId = enemy.ObjectId, Property = "DeathSound", Value = nil })
		Kill( enemy )
	else
		ActivateFuse( enemy )
	end
end

function SkyAttackerAI( enemy, CurrentRun )

	if enemy.WakeUpDelay ~= nil or (enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil) then
		local wakeUpDelay = enemy.WakeUpDelay or RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
		wait( CalcEnemyWait( enemy, wakeUpDelay ), enemy.AIThreadName )
	end

	while IsAIActive( enemy ) do
		if not CanAttack({ Id = enemy.ObjectId }) then
			enemy.AINotifyName = "CanAttack"..enemy.ObjectId
			NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end

		enemy.WeaponName = SelectWeapon( enemy )
		table.insert(enemy.WeaponHistory, enemy.WeaponName)
		local aiData = GetWeaponAIData(enemy)

		aiData.TargetId = GetTargetId(enemy, aiData)

		if aiData.TargetId ~= nil and aiData.TargetId ~= 0 then
			ClearEffect({ Id = enemy.ObjectId, Name = "HermesSlow" })
			if aiData.ResetSkyAttackSound ~= nil then
				PlaySound({ Name = aiData.ResetSkyAttackSound, Id = enemy.ObjectId })
			end
			if aiData.LaunchAnimation ~= nil then
				SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.LaunchAnimation })
			end
			if aiData.StopAnimationsOnLaunch ~= nil then
				StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.StopAnimationsOnLaunch })
			end
			if aiData.ShadowAnimationGroundName ~= nil then
				StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.ShadowAnimationGroundName })
			end
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.ShadowAnimationFadeOutName })

			ApplyUpwardForce({ Id = enemy.ObjectId, Speed = 5000 })
			wait( 0.5, enemy.AIThreadName )
			enemy.BlockingLocation = false
			enemy.InSky = true
			IgnoreGravity({ Id = enemy.ObjectId })
			SetAlpha({ Id = enemy.ObjectId, Fraction = 0.0 })
			SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsUnits", Value = false })
			SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = false })

			-- Disapear
			local hideDuration = aiData.PostLaunchHideDuration or RandomFloat(aiData.PostLaunchHideDurationMin, aiData.PostLaunchHideDurationMax)
			wait( CalcEnemyWait( enemy,aiData.PostLaunchHideDuration, { IgnoreSpeedMultiplier = true }), enemy.AIThreadName )
			Teleport({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.ShadowAnimationFadeInName })
			wait( CalcEnemyWait( enemy,aiData.PostLaunchHideFadeInDuration, { IgnoreSpeedMultiplier = true }), enemy.AIThreadName )


			-- Pre-Attack Movement
			if aiData.RetreatBeforeAttack then
				Retreat(enemy, aiData, aiData.TargetId)
				wait( CalcEnemyWait( enemy, 0.05), enemy.AIThreadName )
			end

			-- Movement
			MoveWithinRange( enemy, aiData.MoveToId or aiData.TargetId, aiData )

			while aiData.WaitIfBlockedDistance ~= nil and IsLocationBlockedWithinDistance( enemy, aiData.WaitIfBlockedDistance ) do
				Retreat( enemy, aiData, aiData.TargetId )
				wait( CalcEnemyWait( enemy, RandomFloat(aiData.WaitIfBlockedDurationMin or 0.5, aiData.WaitIfBlockedDurationMax or 5.0)), enemy.AIThreadName )
				MoveWithinRange( enemy, aiData.MoveToId or aiData.TargetId, aiData )
			end

			if aiData.PreAttackVoiceLines ~= nil then
				thread( PlayVoiceLines, aiData.PreAttackVoiceLines, nil, enemy )
			end

			-- Attack
			local attackSuccess = false
			while not attackSuccess do
				enemy.BlockingLocation = true
				enemy.InSky = false
				ObeyGravity({ Id = enemy.ObjectId })
				SetAlpha({ Id = enemy.ObjectId, Fraction = 1.0 })
				SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsUnits", Value = true })
				SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = true })

				-- @experiment Snap isometric
				local currentAngle = GetAngle({ Id = enemy.ObjectId })
				if currentAngle > 90 and currentAngle < 270 then
					SetGoalAngle({ Id = enemy.ObjectId, Angle = 210, CompleteAngle = true })
				else
					SetGoalAngle({ Id = enemy.ObjectId, Angle = 330, CompleteAngle = true })
				end

				Stop({ Id = enemy.ObjectId })
				Halt({ Id = enemy.ObjectId })
				attackSuccess = DoAttack( enemy, aiData )
				if not attackSuccess then
					enemy.AINotifyName = "CanAttack"..enemy.ObjectId
					NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
					waitUntil( enemy.AINotifyName )
				end
			end
		else
			if enemy.NoTargetMoveTowardsPlayer then
				MoveWithinRange( enemy, CurrentRun.Hero.ObjectId, aiData )
			end
			wait( CalcEnemyWait( enemy, enemy.NoTargetWanderDuration or 0.5), enemy.AIThreadName )
		end
	end
end

function IsLocationBlockedWithinDistance( source, distance )
	for enemyId, enemy in pairs( ActiveEnemies ) do
		if enemy.BlockingLocation and enemy.ObjectId ~= source.ObjectId then
			if GetDistance({ Id = enemy.ObjectId, DestinationId = source.ObjectId }) < distance then
				return true
			end
		end
	end
	return false
end

function DoPickup( enemy, aiData, pickupTarget )
	aiData = aiData or enemy
	local pickupRange = aiData.AIPickupRange or 100
	enemy.Pickups = enemy.Pickups or 0

	if pickupTarget == nil then
		local eligibleTargets = GetIdsByType({ Names = aiData.AIPickupTypes })
		pickupTarget = GetClosest({ Id = enemy.ObjectId, DestinationIds = eligibleTargets })
	end

	enemy.PickupTarget = MapState.ActiveObstacles[pickupTarget] or ActiveEnemies[pickupTarget]

	local forceFailTime = nil
	if aiData.PickupTimeAllowance ~= nil then
		forceFailTime = _worldTime + aiData.PickupTimeAllowance
	end

	while IsAlive({ Id = pickupTarget }) and pickupTarget ~= nil do
		-- Move to target
		Move({ Id = enemy.ObjectId, DestinationId = pickupTarget, Distance = 10, SuccessDistance = 40 })

		if aiData.MoveToTargetSound ~= nil then
			PlaySound({ Name = aiData.MoveToTargetSound, Id = enemy.ObjectId })
		end
		if aiData.MoveToTargetText ~= nil then
			thread( InCombatText, enemy.ObjectId, enemy.MoveToTargetText, 1.5 )
		end

		-- Wait until within range
		enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId

		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = pickupTarget, Distance = pickupRange, Notify = enemy.AINotifyName, Timeout = aiData.MoveToPickupTimeout or 5.0 })
		waitUntil( enemy.AINotifyName )
		if _eventTimeoutRecord[enemy.AINotifyName] then
			-- Remove collision for next attempt if timed out
			DebugPrint({ Text = "Pickup timeout" })
			SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithObstacles", Value = false })
			SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = false })
			enemy.PickupTarget = nil
			return false
		end

		-- Begin pick up
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToForce", Value = true })
		local endTime = _worldTime + aiData.AIPickupTime
		if IsAlive({ Id = pickupTarget }) then
			Stop({ Id = enemy.ObjectId })
			Shake({ Id = enemy.ObjectId, Distance = 3, Speed = 500, Duration = aiData.AIPickupTime })
			Flash({ Id = enemy.ObjectId, Speed = 1.0, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = aiData.AIPickupTime, ExpireAfterCycle = true })
			thread( PlayVoiceLines, enemy.RespawningVoiceLines, true )
			if aiData.BeginPickupSound ~= nil then
				PlaySound({ Name = aiData.BeginPickupSound, Id = aiData.ObjectId })
			end
			if aiData.BeginPickupText ~= nil then
				thread( InCombatText, enemy.ObjectId, aiData.PickupText, aiData.AIPickupTime )
			end
			if aiData.BeginPickupAnimation ~= nil then
				SetAnimation({ Name = aiData.BeginPickupAnimation, DestinationId = enemy.ObjectId })
			end

			if enemy.PickupTarget ~= nil and enemy.PickupTarget.BeginPickupAnimation then
				SetAnimation({ Name = enemy.PickupTarget.BeginPickupAnimation, DestinationId = pickupTarget })
			end

			while _worldTime < endTime do
				if not IsAlive({ Id = pickupTarget }) or not CanAttack({ Id = enemy.ObjectId }) then
					StopFlashing({ Id = enemy.ObjectId })
					if aiData.PickupFailedAnimation ~= nil then
						SetAnimation({ Name = aiData.PickupFailedAnimation, DestinationId = enemy.ObjectId })
					end
					if enemy.PickupTarget ~= nil and enemy.PickupTarget.PickupFailedAnimation then
						SetAnimation({ Name = enemy.PickupTarget.PickupFailedAnimation, DestinationId = enemy.PickupTarget.ObjectId })
					end
					enemy.PickupTarget = nil
					return false
				end
				wait( CalcEnemyWait( enemy, 0.1 ), enemy.AIThreadName )
			end

			-- Pick up
			if IsAlive({ Id = pickupTarget }) then
				if aiData.PickupSound ~= nil then
					PlaySound({ Name = aiData.PickupSound, Id = enemy.ObjectId })
				end
				if aiData.PickupText ~= nil then
					thread( InCombatText, enemy.ObjectId, aiData.PickupText, 1.75 )
				end
				if aiData.PickupFx ~= nil then
					CreateAnimation({ Name = aiData.PickupFx, DestinationId = enemy.ObjectId })
				end
				if aiData.PickupAnimation ~= nil then
					SetAnimation({ Name = aiData.PickupAnimation, DestinationId = enemy.ObjectId })
				end
				Flash({ Id = enemy.ObjectId, Speed = 0.65, MinFraction = 1.0, MaxFraction = 0, Color = Color.Gold, ExpireAfterCycle = true })

				ProcessPickup( enemy, pickupTarget )
				Destroy({ Id = pickupTarget })
				enemy.Pickups = enemy.Pickups + 1
				enemy.PickupTarget = nil
				return true
			else
				SetThingProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToForce", Value = false })
			end
		end

		if forceFailTime ~= nil and _worldTime >= forceFailTime then
			enemy.PickupTarget = nil
			return false
		end
	end

	enemy.PickupTarget = nil
	return false
end

function ProcessPickup(enemy, pickupTarget)
	if MapState.ActiveObstacles[pickupTarget] == nil then
		return
	end

	local pickupType = MapState.ActiveObstacles[pickupTarget].Name
	local pickupData = ObstacleData[pickupType] or ConsumableData[pickupType]

	if pickupData == nil then
		DebugPrint({ Text = pickupType.." had no obstacle data" })
		return
	end

	if pickupData.SwapToUnitOnPickup ~= nil then
		local oldEnemy = enemy
		local newEnemyName = pickupData.SwapToUnitOnPickup
		if enemy.IsSuperElite and EnemyData[newEnemyName.."SuperElite"] ~= nil then
			newEnemyName = newEnemyName.."SuperElite"
		elseif enemy.IsElite and EnemyData[newEnemyName.."Elite"] ~= nil then
			newEnemyName = newEnemyName.."Elite"
		end
		local newEnemy =  DeepCopyTable( EnemyData[newEnemyName] )
		newEnemy.ObjectId = SpawnUnit({ Name = newEnemyName, InheritGroupNames = true, DestinationId = oldEnemy.ObjectId })
		thread(SetupUnit, newEnemy, CurrentRun )
		local charmDuration = GetCharmDuration({ Id = oldEnemy.ObjectId })
		if charmDuration > 0 then
			ApplyEffect({ 
				Id = CurrentRun.Hero.ObjectId, 
				DestinationId = newEnemy.ObjectId, 
				EffectName = "Charm",
				DataProperties = 
				{
					Type = "CHARM",
					Duration = charmDuration,
					Active = true,
					TimeModifierFraction = 0,
				}
			})
		end
		thread( PlayVoiceLines, oldEnemy.RespawnedVoiceLines, true )
		RemoveOnDeathWeapons( oldEnemy )
		Kill( oldEnemy )
	end

	if pickupData.IsEnemyWeapon and SessionMapState.WeaponSpawnPointsUsed ~= nil then
		SessionMapState.WeaponSpawnPointsUsed[pickupTarget] = nil
	end

	if pickupData.AddWeaponOptionOnPickup ~= nil then
		table.insert(enemy.WeaponOptions, pickupData.AddWeaponOptionOnPickup)
	end
	if pickupData.AddEquipmentOnPickup ~= nil then
		table.insert(enemy.Equipment, pickupData.AddEquipmentOnPickup)
	end
	if pickupData.AddHealthBuffer ~= nil then
		if enemy.HealthBuffer == 0 then
			DoEnemyHealthBuffered( enemy )
			ArmorRestoredPresentation(enemy)
		end
		enemy.HealthBuffer = (enemy.HealthBuffer or 0) + pickupData.AddHealthBuffer
	end

	if pickupData.AttachAnimation ~= nil then
		CreateAnimation({ Name = pickupData.AttachAnimation, DestinationId = enemy.ObjectId })
	end
end

function UnitSplit( enemy, aiData )
	local spawnGroupName = "Spawner"..enemy.ObjectId

	if not enemy.IsBoss then
		RemoveEnemyUI( enemy )
		enemy.HasHealthBar = false
	end
	ClearEffect({ Id = enemy.ObjectId, All = true })

	enemy.SplitIds = {}

	for i=1, aiData.SpawnCount do
		local enemyData = EnemyData[aiData.SpawnedUnit]
		local newEnemy = DeepCopyTable( enemyData )
		newEnemy.SkipChallengeKillCounts = true
		local spawnPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, newEnemy, { SpawnNearId = enemy.ObjectId, SpawnRadius = aiData.SpawnRadius, SpawnRadiusMin = aiData.SpawnRadiusMin, },
																				{ RequiredSpawnPoint = aiData.RequiredSpawnPointType, SpawnAwayFromTypes = aiData.SpawnAwayFromTypes, SpawnAwayFromTypesDistance = aiData.SpawnAwayFromTypesDistance })
		newEnemy.OccupyingSpawnPointId = spawnPointId
		SessionMapState.SpawnPointsUsed[spawnPointId] = newEnemy.ObjectId
		thread( UnoccupySpawnPointOnDistance, newEnemy, spawnPointId, 400 )

		newEnemy.ObjectId = SpawnUnit({ Name = aiData.SpawnedUnit, Group = "Standing", DestinationId = spawnPointId, ForceToValidLocation = true })
		enemy.SplitIds[newEnemy.ObjectId] = true

		thread(SetupUnit, newEnemy, CurrentRun )
		AddToGroup({ Id = newEnemy.ObjectId, Name = spawnGroupName })
		newEnemy.SkipActiveCount = true

		if aiData.SyncChainedWeapons then
			newEnemy.WeaponName = enemy.ChainedWeapon
		end

		if newEnemy.EliteIcon or ( newEnemy.HealthBuffer ~= nil and newEnemy.HealthBuffer > 0 ) then
			CreateHealthBar( newEnemy )
			UpdateHealthBar( newEnemy, 0, { Force = true })
			newEnemy.Outline.Id = newEnemy.ObjectId
			AddOutline( newEnemy.Outline )
		end
	end
end

function ArtemisPostCombat( enemy )
	enemy.PostCombatTravel = true
	local moveToId = SelectLootSpawnPoint(CurrentRun.CurrentRoom) or CurrentRun.Hero.ObjectId

	SetThingProperty({ Property = "Graphic", Value = "Artemis_Idle", DestinationId = enemy.ObjectId })
	Stop({ Id = enemy.ObjectId })
	wait(0.05, enemy.AIThreadName)
	Teleport({ Id = enemy.ObjectId, DestinationId = moveToId })
	wait(0.05, enemy.AIThreadName)

	-- check for first presentation
	local requirements =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "ArtemisFirstMeeting" },
		},
	}
	
	if IsGameStateEligible( CurrentRun, requirements ) then		
		thread( DirectionHintPresentation, enemy )
		ArtemisAppearancePresentation( enemy )
	else
		ArtemisFirstAppearancePresentation( enemy )
	end

	UseableOn({ Id = enemy.ObjectId })

	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = 400, Notify = enemy.AINotifyName, Timeout = 10.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )
	enemy.PostCombatTravel = false
end

function IcarusPostCombat( enemy )
	enemy.PostCombatTravel = true
	local moveToId = SelectLootSpawnPoint(CurrentRun.CurrentRoom) or CurrentRun.Hero.ObjectId

	Stop({ Id = enemy.ObjectId })
	wait(0.05, enemy.AIThreadName)
	Teleport({ Id = enemy.ObjectId, DestinationId = moveToId })
	wait(0.05, enemy.AIThreadName)

	--[[ check for first presentation
	local requirements =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "ArtemisFirstMeeting" },
		},
	}
	
	if IsGameStateEligible( CurrentRun, requirements ) then		
		thread( DirectionHintPresentation, enemy )
		ArtemisAppearancePresentation( enemy )
	else
		ArtemisFirstAppearancePresentation( enemy )
	end]]
	thread( DirectionHintPresentation, enemy )
	IcarusAppearancePresentation( enemy )

	UseableOn({ Id = enemy.ObjectId })

	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = 400, Notify = enemy.AINotifyName, Timeout = 10.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )
	enemy.PostCombatTravel = false
end

function NemesisPostCombat( enemy )
	enemy.PostCombatTravel = true
	local moveToId = SelectLootSpawnPoint(CurrentRun.CurrentRoom) or CurrentRun.Hero.ObjectId
	local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = moveToId })

	Move({ Id = enemy.ObjectId, DestinationId = moveToId, SuccessDistance = 40 })
	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = moveToId, Distance = 100, Notify = enemy.AINotifyName, Timeout = 10.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )

	Stop({ Id = enemy.ObjectId })
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Nemesis_Combat_Unequip" })
end

function HeraclesPostCombat( enemy )
	enemy.PostCombatTravel = true
	local moveToId = SelectLootSpawnPoint(CurrentRun.CurrentRoom) or CurrentRun.Hero.ObjectId
	local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = moveToId })

	Move({ Id = enemy.ObjectId, DestinationId = moveToId, SuccessDistance = 40 })
	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = moveToId, Distance = 100, Notify = enemy.AINotifyName, Timeout = 10.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )

	Stop({ Id = enemy.ObjectId })
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = 400, Notify = enemy.AINotifyName, Timeout = 10.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )
	enemy.PostCombatTravel = false
	UseableOn({ Id = enemy.ObjectId })
	--SetAnimation({ DestinationId = enemy.ObjectId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
	thread( HeraclesEncounterEndPresentation, enemy )
end

function EnemyInvisibility( enemy, aiData, args )
	args = args or {}

	aiData.InvisibilityInterval = aiData.InvisibilityInterval or 0
	enemy.LastInvisibilityTime = enemy.LastInvisibilityTime or 0

	if _worldTime - enemy.LastInvisibilityTime >= aiData.InvisibilityInterval then

		ClearEffect({ Id = enemy.ObjectId, All = true })
		SetLifeProperty({ DestinationId = enemy.ObjectId, Property = "InvulnerableFx", Value = nil })
		enemy.SkipInvulnerableOnHitPresentation = true

		local alpha = args.Alpha or 0.0
		local color = args.Color or { 0, 0, 0, 0 }

		SetAlpha({ Id = enemy.ObjectId, Fraction = alpha, Duration = aiData.InvisibilityFadeOutDuration })
		SetColor({ Id = enemy.ObjectId, Color = color, Duration = aiData.InvisibilityFadeOutDuration })

		if args.CreateAnimation then
			CreateAnimation({ Name = args.CreateAnimation, DestinationId = enemy.ObjectId })
		end
		if args.Animation then
			SetAnimation({ Name = args.Animation, DestinationId = enemy.ObjectId })
		end
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = false })
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = false })
		enemy.PreInvisibilityImmuneToStun = GetUnitDataValue({ Id = enemy.ObjectId, Property = "ImmuneToStun" })
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToStun", Value = true })
		SetUnitInvulnerable( enemy )
		wait( aiData.InvisibilityFadeOutDuration, enemy.AIThreadName )
		if enemy.Phase2VFX ~= nil then
  			StopAnimation({ Name = enemy.Phase2VFX, DestinationId = enemy.ObjectId })
		end
		enemy.IsInvisible = true
		enemy.LastInvisibilityTime = _worldTime
		if not enemy.UseBossHealthBar then
			local enemyId = enemy.ObjectId
			if EnemyHealthDisplayAnchors[enemyId.."elitebadge"] then
				Destroy({ Id = EnemyHealthDisplayAnchors[enemyId.."elitebadge"]})
			end
			if enemy.EliteAttributes ~= nil then
				for k, attributeName in pairs(enemy.EliteAttributes) do
					if EnemyHealthDisplayAnchors[enemyId.."elitebadge"..attributeName] then
						Destroy({ Id = EnemyHealthDisplayAnchors[enemyId.."elitebadge"..attributeName]})
					end
				end
			end

			local toDestroy = {}
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."back"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."health"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."armorIcon"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."vulnerabilityIndicator"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."falloff"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."scorch"] )
			if EnemyHealthDisplayAnchors[enemyId.."status"] ~= nil then
				for k, v in pairs( EnemyHealthDisplayAnchors[enemyId.."status"] ) do
					table.insert( toDestroy, v )
				end
			end
			if enemy.EffectSuffixNames then
				for effectName in pairs(enemy.EffectSuffixNames) do
					table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId..effectName] )
				end
			end
			EnemyHealthDisplayAnchors[enemyId.."status"] = nil
			
			if enemy.EffectSuffixNames then
				for effectName in pairs(enemy.EffectSuffixNames) do
					EnemyHealthDisplayAnchors[enemyId..effectName] = nil
				end
			end

			if EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] ~= nil then
				for k, v in pairs( EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] ) do
					table.insert( toDestroy, v )
				end
			end
			EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] = nil

			DestroyTextBox({ Ids = toDestroy })
			Destroy({ Ids = toDestroy })
			enemy.HasHealthBar = false
		end
		
		if aiData.PostInvisibilityFunction ~= nil then
			CallFunctionName( aiData.PostInvisibilityFunction, enemy, aiData, CurrentRun, args )
		end
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function EnemyHandleInvisibleAttack( enemy, aiData, args )
	args = args or {}
	if enemy.IsInvisible and not aiData.KeepInvisibility then
		if enemy.CurrentPhase ~= nil and enemy.CurrentPhase >= 2 and enemy.Phase2VFX ~= nil then
  			CreateAnimation({ Name = enemy.Phase2VFX, DestinationId = enemy.ObjectId })
		end
  	
		SetLifeProperty({ DestinationId = enemy.ObjectId, Property = "InvulnerableFx", Value = "Invincibubble_Hades" })
		enemy.IsInvisible = false
		CreateHealthBar( enemy )
		UpdateHealthBar( enemy, 0, { Force = true })

		if enemy.InvisibilityEndSound ~= nil then
			PlaySound({ Name = enemy.InvisibilityEndSound })
		end
		SetUnitVulnerable( enemy )
		SetAlpha({ Id = enemy.ObjectId, Fraction = 1.0, Duration = aiData.InvisibilityFadeInDuration })
		SetColor({ Id = enemy.ObjectId, Color = { 255, 255, 255, 255 }, Duration = aiData.InvisibilityFadeInDuration })
		if args.CreateAnimation then
			CreateAnimation({ Name = args.CreateAnimation, DestinationId = enemy.ObjectId })
		end
		if args.Animation then
			CreateAnimation({ Name = args.Animation, DestinationId = enemy.ObjectId })
		end
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = true })
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToStun", Value = enemy.PreInvisibilityImmuneToStun })
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = true })
		enemy.SkipInvulnerableOnHitPresentation = false
		wait( CalcEnemyWait( enemy, aiData.InvisibilityFadeInDuration ), enemy.AIThreadName )
	end
end

function EnrageUnit(enemy, startDelay)
	wait( startDelay )
	if not IsAlive({ Id = enemy.ObjectId }) then
		return
	end

	DebugPrint({ Text = "Enraging: "..enemy.Name })
	if enemy.EnragedMoveSpeedBonus ~= nil then
		enemy.MoveSpeedReset = GetUnitDataValue({ Id = enemy.ObjectId, Property = "Speed" })
		local enragedMoveSpeed = enemy.EnragedMoveSpeedBonus + enemy.MoveSpeedReset
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "Speed", Value = enragedMoveSpeed })
	end

	enemy.Enraged = true
	if enemy.EnragedPresentation ~= nil then
		CallFunctionName( enemy.EnragedPresentation, enemy, CurrentRun )
	end

	wait( enemy.EnragedDuration )

	if enemy.PermanentEnraged then
		local notifyName = enemy.ObjectId.."PermanentEnraged"
		NotifyOnAllDead({ Ids = { enemy.ObjectId }, Notify = notifyName })
		waitUntil( notifyName )
		AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	else
		EndEnemyEnrage(enemy, CurrentRun)
	end
end

function EndEnemyEnrage(enemy)
	local screenId = ScreenAnchors.BossRageFill
	enemy.Enraged = false
	StopFlashing({ Id = screenId })
	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	if enemy.RageExpiredSound ~= nil then
		PlaySound({ Name = enemy.RageExpiredSound })
	end
	if enemy.RageExpiredVoiceLines ~= nil then
		thread( PlayVoiceLines, enemy.RageExpiredVoiceLines, nil, enemy )
	end
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1.0, DestinationId = screenId })
	if enemy.EnragedMoveSpeedBonus ~= nil then
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "Speed", Value = enemy.MoveSpeedReset })
	end
end

function SpawnSupportAI( enemy )
	if IsEmpty(enemy.SupportAINames) then
		return
	end

	local supportUnit = DeepCopyTable( EnemyData[enemy.SupportUnitName] )
	supportUnit.ObjectId = SpawnUnit({ Name = enemy.SupportUnitName, Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId })
	supportUnit.SupportAINames = enemy.SupportAINames
	enemy.SupportAIUnitId = supportUnit.ObjectId
	thread(SetupUnit, supportUnit, CurrentRun )
end

-- Sets and runs an enemy's AIBehavior
function SetAI( newAIName, enemy, args )
	if enemy.DisableAIWhenReady then
		enemy.DisableAIWhenReady = false
		enemy.AIDisabled = true
		return
	end

	enemy.AIBehavior = newAIName
	return CallFunctionName( newAIName, enemy, args )
end

function GetTargetId( enemy, aiData )
	aiData = aiData or enemy
	local targetId = nil
	if IsEmpty( CurrentRun.Hero.UntargetableFlags ) then
		targetId = CurrentRun.Hero.ObjectId
	end	

	if aiData.TargetSelf then
		targetId = enemy.ObjectId

	elseif aiData.UseTargetId then
		targetId = aiData.UseTargetId

	elseif aiData.TargetRandomFromGroup ~= nil then
		targetId = GetRandomValue(GetIds({ Name = aiData.TargetRandomFromGroup }) )

	elseif aiData.UseRandomTargetId then
		targetId = GetRandomValue(aiData.UseRandomTargetId)

	elseif aiData.TargetComboPartner then
		targetId = enemy.ComboPartnerId

	elseif aiData.CreateOwnTarget then
		local offsetAngle = 0
		if aiData.RandomTargetAngle then
			offsetAngle = RandomFloat(0, 360)
		elseif aiData.TargetAngleOptions ~= nil then
			offsetAngle = GetRandomValue( aiData.TargetAngleOptions )
		else
			offsetAngle = GetAngle({ Id = enemy.ObjectId })
		end
		if aiData.TargetAngleOffset ~= nil then
			offsetAngle = offsetAngle + aiData.TargetAngleOffset
		end
		if aiData.TargetAngleSpread then
			offsetAngle = offsetAngle + RandomFloat(-aiData.TargetAngleSpread/2, aiData.TargetAngleSpread/2)
		end
		local offsetDistance = aiData.TargetOffsetDistance or 100
		if aiData.TargetOffsetDistanceMin ~= nil and aiData.TargetOffsetDistanceMax ~= nil then
			offsetDistance = RandomFloat(aiData.TargetOffsetDistanceMin, aiData.TargetOffsetDistanceMax)
		end
		local offset = CalcOffset(math.rad(offsetAngle), offsetDistance)
		if aiData.OffsetDistanceScaleY ~= nil then
			offset.Y = offset.Y * aiData.OffsetDistanceScaleY
		end
		local newTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = aiData.AnchorTargetId or enemy.ObjectId, Group = "Scripting", OffsetX = offset.X, OffsetY = offset.Y })
		targetId = newTargetId
		enemy.CreatedOwnTarget = targetId

	elseif aiData.TargetRequiredKillEnemy or IsCharmed({ Id = enemy.ObjectId }) then
		targetId = nil
		local eligibleIds = {}
		local targetOptions = ShallowCopyTable(RequiredKillEnemies)
		if IsEmpty(targetOptions) then
			for k, id in pairs(GetIds({ Name = "EnemyTeam" })) do
				if MapState.AggroedUnits[id] then
					targetOptions[id] = ActiveEnemies[id]
				end
			end
		end
		
		for enemyId, requiredKillEnemy in pairs( targetOptions ) do
			if requiredKillEnemy ~= enemy then
				if aiData.IgnoreSelfType and requiredKillEnemy.Name == enemy.Name then
					--DebugPrint({ Text = "INGORE IgnoreSelfType" })
				elseif aiData.IgnoreTypes ~= nil and Contains(aiData.IgnoreTypes, requiredKillEnemy.Name) then
					--DebugPrint({ Text = "INGORE IgnoreTypes" })
				elseif aiData.IngoreCursedByThanatos and HasEffect({ Id = requiredKillEnemy.ObjectId, EffectName = "ThanatosCurse" }) then
					--DebugPrint({ Text = "INGORE IngoreCursedByThanatos" })
				elseif aiData.IgnoreInvulnerable and IsInvulnerable({ Id = requiredKillEnemy.ObjectId }) then
					--DebugPrint({ Text = "INGORE IgnoreInvulnerable" })
				elseif requiredKillEnemy.InSky then
					--DebugPrint({ Text = "INGORE InSky" })
				elseif not requiredKillEnemy.ActivationFinished then
					--DebugPrint({ Text = "INGORE ActivationFinished" })
				elseif requiredKillEnemy.Untargetable then
					--DebugPrint({ Text = "INGORE Untargetable" })
				elseif aiData.TargetGroups and not ContainsAny(aiData.TargetGroups, requiredKillEnemy.Groups) then
					--DebugPrint({ Text = "INGORE TargetGroups" })
				elseif aiData.TargetWeak then
					if requiredKillEnemy.Health / requiredKillEnemy.MaxHealth < 1.0 then
						table.insert(eligibleIds, enemyId)
					end
				elseif aiData.TargetMinDistance then
					if GetDistance({ Id = enemy.ObjectId, DestinationId = enemyId }) > aiData.TargetMinDistance then
						table.insert(eligibleIds, enemyId)
					end
				elseif aiData.TargetMaxDistance then
					if GetDistance({ Id = enemy.ObjectId, DestinationId = enemyId }) <= aiData.TargetMaxDistance then
						table.insert(eligibleIds, enemyId)
					end
				else
					table.insert(eligibleIds, enemyId)
				end
			end
		end

		if aiData.TargetPlayerAndRequiredKills then
			table.insert(eligibleIds, CurrentRun.Hero.ObjectId)
		end

		if aiData.TargetClosest then
			targetId = GetClosest({ Id = enemy.ObjectId, DestinationIds = eligibleIds, Distance = 1500, IgnoreInvulnerable = true, IgnoreHomingIneligible = true, IgnoreSelf = true })
		
		elseif aiData.TargetClosestToPlayer then
			targetId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = eligibleIds, Distance = 1500, IgnoreInvulnerable = true, IgnoreHomingIneligible = true, IgnoreSelf = true })
		elseif aiData.TargetName ~= nil then
			local ids = GetIdsByType({ Name = aiData.TargetName })
			targetId = GetRandomValue(ids)
		else
			targetId = GetRandomValue(eligibleIds)
		end

		if aiData.TargetPlayerIfNoFriends and targetId == nil then
			targetId = CurrentRun.Hero.ObjectId
		end
	elseif aiData.TargetClosestOfType or aiData.TargetClosestOfTypes then
		targetId = GetClosest({ Id = enemy.ObjectId, DestinationIds = GetIdsByType({ Name = aiData.TargetClosestOfType, Names = aiData.TargetClosestOfTypes }), Distance = 1500, IgnoreSelf = true })
	elseif aiData.TargetSpawnPoints then
		local nearId = CurrentRun.Hero.ObjectId
		if aiData.TargetSpawnPointsNearSelf then
			nearId = enemy.ObjectId
		end
		targetId = SelectSpawnPoint(CurrentRun.CurrentRoom, { Name = enemy.Name, RequiredSpawnPoint = aiData.TargetSpawnPointsType }, { SpawnNearId = nearId, SpawnRadius = aiData.TargetSpawnPointsPlayerRadius or aiData.TargetSpawnPointsRadius or 1000, SpawnRadiusMin = aiData.TargetSpawnPointsPlayerRadiusMin or aiData.TargetSpawnPointsRadiusMin } )
		if aiData.OccupyTargetSpawnPoint then
			if enemy.OccupyingSpawnPointId ~= nil then
				UnoccupySpawnPoint(enemy.OccupyingSpawnPointId)
			end
			enemy.OccupyingSpawnPointId = targetId
			SessionMapState.SpawnPointsUsed[targetId] = enemy.ObjectId
		end

	elseif aiData.TargetName ~= nil then
		local ids = GetIdsByType({ Name = aiData.TargetName })
		targetId = GetRandomValue(ids)
	elseif not IsEmpty( MapState.TauntTargetIds ) then
		targetId = GetRandomKey( MapState.TauntTargetIds )
	elseif targetId == CurrentRun.Hero.ObjectId and CurrentRun.Hero.Invisible and CurrentRun.CurrentRoom.InvisTargetId then
		targetId = CurrentRun.CurrentRoom.InvisTargetId

		if aiData.CancelIfInvisTarget then
			targetId = nil
		end
	end

	if aiData.CreateOwnTargetFromOriginalTarget then
		local offsetAngle = GetAngle({ Id = enemy.ObjectId })
		if aiData.RandomTargetAngle then
			offsetAngle = RandomFloat(0, 360)
		elseif aiData.UseTargetAngle then
			offsetAngle = GetAngle({ Id = aiData.AnchorTargetId or targetId })
		elseif aiData.UseAngleBetweenTarget then
			offsetAngle = GetAngleBetween({ DestinationId = aiData.AnchorTargetId or targetId, Id = enemy.ObjectId })
		elseif aiData.TargetAngleOptions ~= nil then
			offsetAngle = GetRandomValue( aiData.TargetAngleOptions )
		end
		local offsetDistance = aiData.TargetOffsetDistance or 0
		if aiData.TargetOffsetDistanceMin ~= nil and aiData.TargetOffsetDistanceMax ~= nil then
			offsetDistance = RandomFloat(aiData.TargetOffsetDistanceMin, aiData.TargetOffsetDistanceMax)
		end
		local offset = CalcOffset(math.rad(offsetAngle), offsetDistance)
		if aiData.OffsetDistanceScaleY ~= nil then
			offset.Y = offset.Y * aiData.OffsetDistanceScaleY
		end
		targetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = aiData.AnchorTargetId or targetId, Group = "Scripting", OffsetX = offset.X, OffsetY = offset.Y })
		enemy.CreatedOwnTarget = targetId
	end

	if aiData.AnchorTargetIdAfterFirstTick and aiData.AnchorTargetId == nil then
		aiData.AnchorTargetId = targetId
	end

	return targetId
end

function StagedAI( enemy )

	for k, aiStage in ipairs( enemy.AIStages ) do

		if CurrentRun.Hero.IsDead then
			-- Immediately cut on hero death
			return false
		end

		if aiStage.SelectRandomAIStage ~= nil then
			--DebugAssert({ Condition = TableLength(enemy[aiStage.SelectRandomAIStage]) > 0, Text = "No more AI stages to choose from", Owner = "Eduardo" })
			local newAIStage = RemoveRandomValue(enemy[aiStage.SelectRandomAIStage])
			OverwriteTableKeys(aiStage, newAIStage)
		end

		if aiStage.SelectPactLevelAIStage ~= nil then
			local shrineLevel = GetNumMetaUpgrades( enemy.ShrineMetaUpgradeName )
			local newAIStage = enemy[aiStage.SelectPactLevelAIStage][shrineLevel] or enemy[aiStage.SelectPactLevelAIStage].Default
			if newAIStage ~= nil then
				OverwriteTableKeys(aiStage, newAIStage)
			end
		end

		if aiStage.AIData ~= nil then
			enemy.AIEndHealthThreshold = nil
			enemy.AIEndWithSpawnedEncounter = nil
			enemy.AIEndGroupHealthThreshold = nil
			MapState.GroupHealthWaiters[enemy.ObjectId] = nil
			enemy.AIEndLastAlive = nil
			enemy.ReachedAIStageEnd = nil
			enemy.ChainedWeapon = nil
			enemy.ActiveWeaponCombo = nil

			if aiStage.AIData.ThresholdOverrideIfInRoom ~= nil and CurrentRun.CurrentRoom.Name == aiStage.AIData.ThresholdOverrideIfInRoom.Room then
				aiStage.AIData.AIEndHealthThreshold = aiStage.AIData.ThresholdOverrideIfInRoom.Value
			end

			OverwriteTableKeys( enemy, aiStage.AIData )

			if enemy.AIEndGroupHealthThreshold ~= nil then
				MapState.GroupHealthWaiters[enemy.ObjectId] = enemy.AIEndGroupHealthThreshold
			end
		end

		if aiStage.DisableRoomTraps then
			DisableRoomTraps( )
		end

		enemy.ChainedWeapon = nil
		enemy.ForcedWeaponInterrupt = nil

		if aiStage.UnequipWeapons ~= nil then
			for k, weaponName in pairs(aiStage.UnequipWeapons) do
				RemoveValue(enemy.WeaponOptions, weaponName)
			end
		end
		if aiStage.UnequipAllWeapons then
			enemy.WeaponOptions = {}
		end

		if aiStage.SetMapFlags ~= nil then
			for k, flagData in pairs(aiStage.SetMapFlags) do
				flagData.Id = enemy.ObjectId
				thread(SetMapFlag, flagData)
			end
		end

		if aiStage.EquipWeapons ~= nil then
			for k, weaponName in pairs(aiStage.EquipWeapons) do
				table.insert(enemy.WeaponOptions, weaponName)
			end
		end

		if aiStage.EquipRandomWeapon ~= nil then
			local eligibleWeapons = {}
			for k, weaponName in pairs(aiStage.EquipRandomWeapon) do
				local weaponData = WeaponData[weaponName]
				if Contains(enemy.WeaponOptions, weaponName) then
						-- skip
				elseif weaponData ~= nil and not IsEnemyWeaponEligible(enemy, weaponData, weaponData.EquipRequirements) then
						-- skip
				else
					table.insert(eligibleWeapons, weaponName)
				end
			end
			local weaponName = GetRandomValue( eligibleWeapons )
			if weaponName ~= nil then
				table.insert(enemy.WeaponOptions, weaponName)
			end
		end

		if aiStage.AddSupportAIWeaponOptions ~= nil then
			local supportAIUnit = ActiveEnemies[enemy.SupportAIUnitId]
			if supportAIUnit ~= nil then
				for supportAIName, addWeaponOptions in pairs(aiStage.AddSupportAIWeaponOptions) do
					ConcatTableValues( supportAIUnit.SupportAIWeaponOptions[supportAIName], aiStage.AddSupportAIWeaponOptions[supportAIName] )
				end
			end
		end

		if aiStage.SetRageWeapon ~= nil then
			enemy.RageWeapon = aiStage.SetRageWeapon
		end

		if aiStage.EnableRoomTraps then
			EnableRoomTraps()
		end

		if aiStage.NewVulnerability ~= nil then
			if aiStage.NewVulnerability then
				SetUnitVulnerable( enemy )
			else
				SetUnitInvulnerable( enemy )

			end
		end

		if aiStage.EndSpawnedEncounter ~= nil then
			killTaggedThreads(enemy.SpawnedEncounter.SpawnThreadName)
			enemy.SpawnedEncounter.ForceEnd = true
		end

		if aiStage.WipeEnemyTypes ~= nil then
			for k, unitId in pairs(GetIdsByType({ Names = aiStage.WipeEnemyTypes })) do
				thread(Kill, ActiveEnemies[unitId])
			end
		end

		if aiStage.KillDumbFireThreads then
			killWaitUntilThreads(enemy.DumbFireThreadName)
			killTaggedThreads(enemy.DumbFireThreadName)
		end

		if aiStage.RandomSpawnEncounter ~= nil and aiStage.SpawnEncounter == nil then
			aiStage.SpawnEncounter = GetRandomValue(aiStage.RandomSpawnEncounter)
		end

		if aiStage.SpawnEncounter ~= nil or aiStage.SpawnEncounterByPactLevel ~= nil then
			local encounterName = aiStage.SpawnEncounter
			if aiStage.SpawnEncounterByPactLevel then
				local shrineLevel = GetNumMetaUpgrades( enemy.ShrineMetaUpgradeName )
				encounterName = aiStage.SpawnEncounterByPactLevel[shrineLevel]
			end
			local encounter = DeepCopyTable( EncounterData[encounterName] )
			if encounter.Generated then
				GenerateEncounter(CurrentRun, CurrentRun.CurrentRoom, encounter)
			end
			enemy.SpawnedEncounter = encounter
			if encounter.StartGlobalVoiceLines ~= nil then
				thread( PlayVoiceLines, GlobalVoiceLines[encounter.StartGlobalVoiceLines] )
			end
			thread( StartEncounter, CurrentRun, CurrentRun.CurrentRoom, encounter )
		end

		if enemy.AIEndWithSpawnedEncounterTimeout then
			CheckCooldown(enemy.AIEndWithSpawnedEncounter, enemy.AIEndWithSpawnedEncounterTimeout)
		end

		-- Transistion
		if aiStage.ThreadedFunctions ~= nil then
			for k, aiFunctionName in pairs(aiStage.ThreadedFunctions) do
				thread( CallFunctionName, aiFunctionName, enemy, CurrentRun )
			end
		end

		if aiStage.ThreadedEvents ~= nil then
			RunThreadedEvents( aiStage.ThreadedEvents, enemy )
		end

		CallFunctionName( aiStage.TransitionFunction, enemy, CurrentRun, aiStage )

		if aiStage.ClearObstacleTypes then
			Destroy({ Ids = GetIdsByType({ Name = aiStage.ClearObstacleTypes }) })
		end

		if aiStage.DestroyGroup then
			Destroy({ Ids = GetIds({ Name = aiStage.DestroyGroup }) })
		end

		if aiStage.DumbFireWeapons ~= nil then
			for k, weaponName in pairs( aiStage.DumbFireWeapons ) do
				local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
				weaponData.Name = weaponName
				thread( DumbFireAttack, enemy, weaponData )
			end
		end

		-- Regular AI
		local aiFunctionName = GetRandomValue( aiStage.RandomAIFunctionNames )
		if aiFunctionName ~= nil then
			SetAI( aiFunctionName, enemy )
		end

		if aiStage.EnableRoomTraps then
			DisableRoomTraps()
		end

		if aiStage.StageEndEndSpawnEncounter then
			killTaggedThreads(enemy.SpawnedEncounter.SpawnThreadName)
			enemy.SpawnedEncounter.ForceEnd = true
			RemoveValue(CurrentRun.CurrentRoom.ActiveEncounters, enemy.SpawnedEncounter)
		end
	end

end

function IsAIActive( enemy )

	if CurrentRun.Hero.IsDead then
		-- Immediately cut on hero death
		if CurrentHubRoom == nil or not CurrentHubRoom.AllowEnemyAIActive then
			return false
		end
	end

	if enemy.DisableAIWhenReady then
		enemy.AIDisabled = true
		enemy.DisableAIWhenReady = false
		return false
	end

	if enemy.IsDead then
		return false
	end

	if ReachedAIStageEnd(enemy) then
		return false
	end

	if enemy.AIDisabled then
		return false
	end

	return true

end

function ReachedAIStageEnd(enemy)
	if enemy.ReachedAIStageEnd then
		return true
	end
	if enemy.AIEndHealthThreshold ~= nil and enemy.Health / enemy.MaxHealth <= enemy.AIEndHealthThreshold then
		return true
	end
	if enemy.AIEndWithSpawnedEncounter ~= nil then
		if enemy.SpawnedEncounter.Completed then
			return true
		else
			if enemy.AIEndWithSpawnedEncounterTimeout ~= nil and CheckCooldown(enemy.AIEndWithSpawnedEncounter, enemy.AIEndWithSpawnedEncounterTimeout) then
				enemy.AIEndWithSpawnedEncounterTimeout = nil
				return true
			end
		end
	end
	local encounter = CurrentRun.CurrentRoom.Encounter
	if enemy.AIEndGroupHealthThreshold and encounter.GroupHealth / encounter.GroupMaxHealth <= enemy.AIEndGroupHealthThreshold then
		return true
	end
	if enemy.AIEndLastAlive and TableLength(RequiredKillEnemies) <= 1 then
		return true
	end
	return false
end

function IdleAIStage(enemy)
	MapState.IdleUnits = MapState.IdleUnits or {}
	MapState.IdleUnits[enemy.ObjectId] = true

	if enemy.IdleAIAnimation ~= nil then
		SetAnimation({ Name = enemy.IdleAIAnimation, DestinationId = enemy.ObjectId })
	end
	
	while IsAIActive(enemy) do
		wait(0.5, enemy.AIThreadName)
	end
	
	MapState.IdleUnits[enemy.ObjectId] = false
	
	if enemy.IdleAIEndAnimation ~= nil then
		SetAnimation({ Name = enemy.IdleAIEndAnimation, DestinationId = enemy.ObjectId })
	end
end

function EmptyAI()
	
end

function NumAttacksSinceWeapon( enemy, weaponName )

	if weaponName == nil or enemy == nil or enemy.WeaponHistory == nil then
		return -1
	end

	if WeaponData[weaponName].GenusName ~= nil then
		weaponName = WeaponData[weaponName].GenusName
	end

	local numAttacks = 0
	for i = #enemy.WeaponHistory, 1, -1 do
		local prevWeapon = enemy.WeaponHistory[i]
		local skipWeapon = false
		if WeaponData[prevWeapon] ~= nil then
			if WeaponData[prevWeapon].SkipWeaponCount then
				skipWeapon = true
			end
			if WeaponData[prevWeapon].GenusName ~= nil then
				prevWeapon = WeaponData[prevWeapon].GenusName
			end
		end
		if prevWeapon == weaponName then
			return numAttacks
		end
		if not skipWeapon then
			numAttacks = numAttacks + 1
		end
	end

	-- Never seen
	return -1
end

function NumConsecutiveUses( enemy, weaponName )
	if weaponName == nil or enemy == nil or enemy.WeaponHistory == nil then
		return -1
	end

	if WeaponData[weaponName].GenusName ~= nil then
		weaponName = WeaponData[weaponName].GenusName
	end

	local numAttacks = 0
	for i = #enemy.WeaponHistory, 1, -1 do
		local prevWeapon = enemy.WeaponHistory[i]
		local skipWeapon = false
		if WeaponData[prevWeapon] ~= nil then
			if WeaponData[prevWeapon].ChainedOnly then
				skipWeapon = true
			end
			if WeaponData[prevWeapon].GenusName ~= nil then
				prevWeapon = WeaponData[prevWeapon].GenusName
			end
		end
		if not skipWeapon then
			if prevWeapon == weaponName then
				numAttacks = numAttacks + 1
			else
				return numAttacks
			end
		end
	end
	return numAttacks
end

function CalcEnemyWait( enemy, duration, args )
	args = args or {}
	if duration == nil or duration <= 0 then
		return 0
	end
	if enemy.SpeedMultiplier ~= nil and not args.IgnoreSpeedMultiplier then
		duration = duration / enemy.SpeedMultiplier
	end
	if enemy.Enraged and enemy.EnragedWaitMultiplier ~= nil then
		duration = duration * enemy.EnragedWaitMultiplier
	end
	if args.MinWaitTime ~= nil and duration < args.MinWaitTime then
		--DebugPrint({ Text=enemy.WeaponName.." increased to MinWaitTime of "..args.MinWaitTime.." from "..duration })
		duration = args.MinWaitTime
	end
	return duration
end

function GetWeaponAIData(enemy, weaponName)
	weaponName = weaponName or enemy.WeaponName
	local aiData = ShallowCopyTable(enemy.DefaultAIData) or {}
	DebugAssert({ Condition = enemy.DefaultAIData ~= nil, Text = enemy.Name.." has no DefaultAIData", Owner = "Eduardo" })
	if WeaponData[weaponName] ~= nil and WeaponData[weaponName].AIData ~= nil then
		local weaponData = ShallowCopyTable(WeaponData[weaponName].AIData)

		if WeaponData[weaponName].ShrineAIDataOverwrites ~= nil and GetNumMetaUpgrades(WeaponData[enemy.WeaponName].ShrineMetaUpgradeName) >= WeaponData[enemy.WeaponName].ShrineMetaUpgradeRequiredLevel then
			OverwriteTableKeys( weaponData, WeaponData[weaponName].ShrineAIDataOverwrites)
		end

		if weaponData.ConditionalData ~= nil then
			for k, conditionalData in pairs(weaponData.ConditionalData) do
				if IsGameStateEligible(CurrentRun, enemy, conditionalData.GameStateRequirements) then
					OverwriteTableKeys( weaponData, conditionalData.AIData)
				end
			end
		end

		OverwriteTableKeys( aiData, weaponData)
	end
	aiData.WeaponName = weaponName

	if enemy.SwapAnimations ~= nil then
		for k, v in pairs(aiData) do
			if enemy.SwapAnimations[v] ~= nil then
				aiData[k] = enemy.SwapAnimations[v]
			end
		end
	end

	return aiData
end

function SheepAI( enemy )
	local aiData = DeepCopyTable(enemy.DefaultAIData)
	local polyphemusId = GetClosestUnitOfType({ Id = enemy.ObjectId, DestinationName = "Polyphemus" })

	thread( InCombatText, enemy.ObjectId, "Alerted", 0.45, { OffsetY = enemy.HealthBarOffsetY, SkipShadow = true }  )

	local exitTime = 999999
	if aiData.ExitMapAfterDuration ~= nil then
		exitTime = _worldTime + aiData.ExitMapAfterDuration
	end

	while ActiveEnemies[enemy.ObjectId] ~= nil and _worldTime < exitTime do
		Move({ Id = enemy.ObjectId, DestinationId = polyphemusId,
			SuccessDistance = aiData.MoveSuccessDistance or 50, LookAheadMultiplier = enemy.LookAheadMultiplier, TrackAtPathEnd = aiData.TrackAtPathEnd,
			LiveOffsetFromId = enemy.ObjectId, LiveOffsetDistance = aiData.LiveOffsetDistance, LiveOffsetAngle = aiData.LiveOffsetDistance or 180 })

		enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = polyphemusId, Distance = 75, Notify = enemy.AINotifyName, Timeout = 5.0 })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )

		wait( aiData.PostMoveIdleDuration or 1.0, enemy.AIThreadName)
	end

	while ActiveEnemies[enemy.ObjectId] ~= nil do
		Move({ Id = enemy.ObjectId, DestinationId = 658446, SuccessDistance = aiData.MoveSuccessDistance or 50, })
		enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = 658446, Distance = 200, Notify = enemy.AINotifyName, Timeout = 5.0 })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )

		if GetDistance({ Id = enemy.ObjectId, DestinationId = 658446 }) < 250 then
			Kill(enemy, { Silent = true })
		end
	end
end

function SheepHit( enemy, attacker, triggerArgs )
 	SetAngle({ Id = enemy.ObjectId, Angle = triggerArgs.ImpactAngle })
 	ApplyForce({ Id = enemy.ObjectId, Speed = enemy.SheepHitVelocity or 1500, Angle = triggerArgs.ImpactAngle })
 	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Sheep_DashPreFire" })
end

function PolyphemusPickup( enemy, aiData, args )
	args = args or {}
	if args.WaitAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = args.WaitAnimation })
	end

	Shake({ Id = enemy.ObjectId, Speed = 250, Distance = 2, Duration = 0.95 })
	Flash({ Id = enemy.ObjectId, Speed = 1, MinFraction = 0, MaxFraction = 0.65, Color = Color.White, Duration = 0.95 })

	if aiData.TriggerDistance ~= nil then
		local notifyName = "PolyphemusPickup"
		NotifyWithinDistanceAny({ Ids = enemy.ObjectId, DestinationIds = GetClosestIds({ Id = enemy.ObjectId, DestinationIds = GetIds({ Names = aiData.TargetGroups }), Distance = 9999, IgnoreSelf = true }), Distance = args.TriggerDistance or 200, Notify = notifyName, Timeout = args.Timeout })
		waitUntil(notifyName)

		aiData.TargetId = GetClosest({ Id = enemy.ObjectId, DestinationNames = aiData.TargetGroups, IgnoreSelf = true })
	end

	if aiData.TargetId ~= nil and aiData.TargetId == CurrentRun.Hero.ObjectId then
		PanCamera({ Ids = { enemy.ObjectId, CurrentRun.Hero.ObjectId }, Duration = 1.2, EaseIn = 0.3 })
		FocusCamera({ Fraction = 0.9, Duration = 1.2, ZoomType = "Ease" })
		AdjustColorGrading({ Name = "Alert", Duration = 2.5 })
	end

	SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.BeginPickupAnimation })
	CreateAnimation({ DestinationId = aiData.TargetId, Name = aiData.PickupFx })

	wait(aiData.BeginPickupDuration or 0.3, enemy.AIThreadName)

	if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
		aiData.ForcedEarlyExit = true
		AdjustColorGrading({ Name = "Off", Duration = 0.3 })
		return true
	end

	local arc = aiData.TargetArcRange or 120
	local facingAngle = GetAngle({ Id = enemy.ObjectId })
	local angleToTarget = GetAngleBetween({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
	local distance = GetDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
	local arcDistance = CalcArcDistance( facingAngle, angleToTarget )

	if distance > aiData.AttackDistance or arcDistance > arc or IsInvulnerable({ Id = aiData.TargetId }) then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.8, EaseIn = 0.3 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.8, ZoomType = "Ease" })
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PickupFailedAnimation })
		AdjustColorGrading({ Name = "Off", Duration = 0.8 })
		thread( InCombatTextArgs, { TargetId = enemy.ObjectId, Text = "PolyphemuGrabTargetFailed", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, Duration = 1.5, OffsetY = 80 } )
		return
	end

	AdjustColorGrading({ Name = "Off", Duration = 0.3 })

	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = 674117 })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PickupAnimation })
	
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.2, EaseIn = 0.3 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1.2, ZoomType = "Ease" })

	if aiData.TargetId ~= nil and ActiveEnemies[aiData.TargetId] ~= nil and GetDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId }) < 300 then
		if ActiveEnemies[aiData.TargetId].Name ~= "Sheep" then
			Kill(ActiveEnemies[aiData.TargetId])
			ApplyEffect({ DestinationId = enemy.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "PolyphemusStomachAche", DataProperties = EffectData.PolyphemusStomachAche.EffectData })
			thread( PlayVoiceLines, enemy.BadMealVoiceLines, nil, enemy )
			wait(aiData.AIPickupDuration or 2.0, enemy.AIThreadName)
			SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Polyphemus_GrabReturnUnsatisfied" })
		else
			thread( InCombatTextArgs, { TargetId = enemy.ObjectId, Text = "PolyphemuGrabSheepSuccess", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, Duration = 1.5, OffsetY = 80 } )
			Kill(ActiveEnemies[aiData.TargetId])
			thread( PlayVoiceLines, enemy.GoodMealVoiceLines, nil, enemy )
			if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
				aiData.ForcedEarlyExit = true
				return true
			end
			UnitConsumeHeal( enemy, aiData )
		end
	elseif aiData.TargetId ~= nil and aiData.TargetId == CurrentRun.Hero.ObjectId then
		AddInputBlock({ Name = "PolyphemusPlayerPreGrab" })
		table.insert(enemy.ActiveInputBlocks, "PolyphemusPlayerPreGrab")

		AddIncomingDamageModifier( CurrentRun.Hero,
		{
			Name = "GrabImmunity",
			ValidProjectilesLookup = 
			{
				ZombieHRFire = true,
				ZombieHeavyRangedToss = true,
				ZombieHeavyRangedShove = true,
				ZombieHeavyRangedShove_Elite = true,
				SheepRam = true,
				SheepSickAura = true,
				SheepExplode = true,
				ZombieMelee = true,
			},
			ValidWeaponMultiplier = 0,
			Temporary = true,
		})
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = enemy.ObjectId, EffectName = "PolyphemusPlayerGrab", DataProperties = EffectData.PolyphemusPlayerGrab.EffectData })
		SetAnimation({ Name = "MelinoeGetHit", DestinationId = CurrentRun.Hero.ObjectId })
		SetPlayerFade({ Flag = "PolyphemusGrab", Duration = 0.34 })
		ApplyUpwardForce({ Id = CurrentRun.Hero.ObjectId, Speed = 400 })
		wait( 0.31, enemy.AIThreadName )
		Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, OffsetY = -110 })
		thread( PlayVoiceLines, GlobalVoiceLines.PolyphemusGrabbedPlayerVoiceLines )
		wait(0.35, enemy.AIThreadName)
		--AdjustFullscreenBloom({ Name = "Default", Duration = AIPickupDuration })
		
		wait(aiData.AIPickupDuration or 2.0, enemy.AIThreadName)
		RemoveIncomingDamageModifier( CurrentRun.Hero, "GrabImmunity")
		SetLifeProperty({ Property = "ConsecutiveHits", Value = 0, ValueChangeType = "Absolute", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
		RemoveInputBlock({ Name = "PolyphemusPlayerPreGrab" })
		RemoveValue(enemy.ActiveInputBlocks, "PolyphemusPlayerPreGrab")
		--AdjustFullscreenBloom({ Name = "Off", Duration = AIPickupDuration })
	else
		thread( InCombatTextArgs, { TargetId = enemy.ObjectId, Text = "PolyphemuGrabTargetFailed", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, Duration = 1.5, OffsetY = 80 } )
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PickupFailedAnimation })
	end
end

function SpawnSheepGhost( sheep )
	local sheepGhost = DeepCopyTable(ObstacleData.SmallGhost01)
	sheepGhost.ObjectId = SpawnObstacle({ Name = "SmallGhost01", Group = "Standing", DestinationId = sheep.ObjectId, TriggerOnSpawn = false, OffsetY = -100 })
	SetupObstacle(sheepGhost)
	SetColor({ Id = sheepGhost.ObjectId, Color = { 1, 1, 1, 0.6 } })
	SetHSV({ Id = sheepGhost.ObjectId, HSV = { 0, -1, 0 }, ValueChangeType = "Absolute" })

	local destinationId = GetRandomValue({ 674117, 658446, 658447, }) or GetRandomValue(MapState.SpawnPoints)
	local randomSpeed = RandomFloat( 90, 125 )
	Move({ Id = sheepGhost.ObjectId, DestinationId = destinationId, Speed = randomSpeed })
	AngleTowardTarget({ Id = sheepGhost.ObjectId, DestinationId = destinationId })

	local notifyName = sheepGhost.ObjectId.."WithinDistance"
	NotifyWithinDistance({ Id = sheepGhost.ObjectId, DestinationId = destinationId, Distance = 60, Notify = notifyName, Timeout = 25.0 })
	waitUntil( notifyName )

	SetAlpha({ Id = sheepGhost.ObjectId, Fraction = 0, Duration = 0.8 })
	wait(0.8)
	Destroy({ Id = sheepGhost.ObjectId })
end

function UnitConsumeHeal( unit, aiData )
	if aiData.ConsumeFx ~= nil then
		CreateAnimation({ DestinationId = urnId, Name = aiData.ConsumeFx })
	end
	for i=1, aiData.HealTicksPerConsume do
		wait(CalcEnemyWait( unit, aiData.HealTickInterval ), unit.AIThreadName)
		if ReachedAIStageEnd(unit) or CurrentRun.CurrentRoom.InStageTransition then
			aiData.ForcedEarlyExit = true
			return true
		end
		Heal( unit, { HealAmount = aiData.HealPerTick, triggeredById = unit.ObjectId, OffsetY = -200 } )
		CreateAnimation({ Name = "Heal", DestinationId = unit.ObjectId })
		thread( UpdateHealthBar, unit, 0, { Force = true } )
	end
	if aiData.StopAnimationsOnConsumeEnd then
		for k, animationName in pairs(aiData.StopAnimationsOnConsumeEnd) do
			StopAnimation({ DestinationId = unit.ObjectId, Name = animationName })
		end
	end
	if aiData.SetAnimationOnConsumeEnd then
		SetAnimation({ DestinationId = unit.ObjectId, Name = aiData.SetAnimationOnConsumeEnd })
	end
end

function WeaponSetImmuneToStun( enemy, aiData )
	enemy.WeaponDefaultImmuneToStun = GetUnitDataValue({ Id = enemy.ObjectId, Property = "ImmuneToStun" })
	SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToStun", Value = true })
end

function WeaponRevertStunImmunity( enemy, aiData)
	SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToStun", Value = enemy.WeaponDefaultImmuneToStun })
end

function FloodManager(source, args)

	if IsEmpty(GetIdsByType({ Names = args.Types })) then
		return
	end

	local firstWait = 0
	if args.FirstIntervalMin ~= nil and args.FirstIntervalMax ~= nil then
		firstWait = RandomFloat(args.FirstIntervalMin, args.FirstIntervalMax)
	end
	wait( firstWait, RoomThreadName )
	FloodEncounterStartPresentation( source )

	local encounter = CurrentRun.CurrentRoom.Encounter
	while not encounter.Completed do

		FloodTrapFireStartPresentation()
		FireFloodTraps(args)
		thread( FloodTrapFireEndPresentation )
		
		local waitTime = RandomFloat(args.IntervalMin, args.IntervalMax)
		wait( waitTime, RoomThreadName )

		if encounter.Completed then
			break
		end
		if GetConfigOptionValue({ Name = "EditingMode" }) then
			break
		end
	end
end

function FireFloodTraps( args )
	for k, typeName in pairs(args.Types or { "FloodTrap" }) do
		for k, unitId in pairs( GetIdsByType({ Name = typeName }) ) do
			if ActiveEnemies[unitId] ~= nil then
				thread(DoAttackerAILoop, ActiveEnemies[unitId])
			end
		end
	end
end

function GetAllAllyIds(unit)
	local unitFriendly = GetUnitDataValue({ Id = unit.ObjectId, Property = "FriendlyToPlayer" })
	DebugPrint({ Text=unitFriendly }) -- returning nil
	local unitIds = GetAllKeys(ActiveEnemies)

	local allyIds = {}

	for k, unitId in pairs(unitIds) do
		if GetUnitDataValue({ Id = unitId, Property = "FriendlyToPlayer" }) == unitFriendly then
			table.insert(allyIds, unitId)
		end
	end

	return allyIds
end

--[[
function ScyllaArmorBreak(unit)

	ApplyEffect({ Id = unit.ObjectId, DestinationId = unit.ObjectId,
		EffectName = "ScyllaArmorBreak", Duration = 500.0,
		DisableMove = true, DisableRotate = true, DisableAttack = true, AddSelfEffect = true })
    SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_MaleGrey_Corpse" })
	wait(unit.ArmorRestoreDelay or 5.0, unit.AIThreadName)

	DoEnemyHealthBuffered( unit )
	ArmorRestoredPresentation(unit)
	AddOutline( unit.Outline )
	unit.HealthBuffer = unit.ArmorRestoreHealthBuffer
end 
]]--

function HecateStageTransition1(enemy, CurrentRun, aiStage)

	CreateAnimation({ DestinationId = enemy.ObjectId, Name = "HecateTeleportFxFront" })
	Teleport({ Id = enemy.ObjectId, DestinationId = 510277 })
	CreateAnimation({ DestinationId = enemy.ObjectId, Name = "HecateTeleportFxFront" })
	thread( PlayVoiceLines, GlobalVoiceLines.HecatePhaseChangeVoiceLines, nil, enemy )

	local midPhaseWeapons = {}
	for i, weapon in ipairs( aiStage.MidPhaseWeapons ) do
		local weaponData = WeaponData[weapon]
		if IsGameStateEligible(CurrentRun, enemy, (weaponData.GameStateRequirements or {}) ) then
			table.insert( midPhaseWeapons, weapon )
		end
	end
	enemy.MidPhaseWeapon =  GetRandomValue(midPhaseWeapons)
	table.insert(enemy.WeaponOptions, enemy.MidPhaseWeapon)
end

function HecateStageTransition2(enemy, CurrentRun, aiStage)

	CreateAnimation({ DestinationId = enemy.ObjectId, Name = "HecateTeleportFxFront" })
	Teleport({ Id = enemy.ObjectId, DestinationId = 510277 })
	CreateAnimation({ DestinationId = enemy.ObjectId, Name = "HecateTeleportFxFront" })
	thread( PlayVoiceLines, GlobalVoiceLines.HecatePhaseChangeVoiceLines, nil, enemy )

	table.insert(enemy.WeaponOptions, enemy.MidPhaseWeapon)
end

function OnUseBallista(unit, args)
	--[[ Press and hold aim
	unit.WeaponName = SelectWeapon( unit )
	table.insert(unit.WeaponHistory, unit.WeaponName)
	aiData = GetWeaponAIData(unit)
	aiData.TargetId = GetTargetId( enemy, aiData )
	Track({ Id = unit.ObjectId, DestinationId = aiData.TargetId })
	while IsControlDown({ Name = "Interact" }) do
		wait(0.05)
	end]]
	-- Fire when released
	UseableOff({ Id = unit.ObjectId })
	DoAttackerAILoop(unit, aiData)
	UseableOn({ Id = unit.ObjectId })
end


function SetupHordeBoss(enemy)
	return
end

function TakeAmbientBattleDamage(enemy)
	if enemy ~= nil and enemy.TakenAmbientBattleDamage then
		return
	end

	Damage(enemy, { DamageAmount = enemy.MaxHealth * 0.1 , Silent = true, PureDamage = true })
	enemy.TakenAmbientBattleDamage = true
end

function ArtemisHealDrop(projectileData, args)
	local consumableId = SpawnObstacle({ Name = "HealDropMinor", LocationX = args.LocationX, LocationY = args.LocationY, Group = "Standing", })
	AdjustZLocation({ Id = consumableId, Distance = 1000 })
	UseableOff({ Id = consumableId })
	consumable = CreateConsumableItem( consumableId, "HealDropMinor", 0 )
	SetThingProperty({ Property = "Gravity", Value = 2500, DestinationId = consumableId })

	wait(1.0)
	PlaySound({ Name = projectileData.DropSound, Id = consumableId })
	CreateAnimation({ Name = "RadialNovaDevotion-Artemis", DestinationId = consumableId })
	UseableOn({ Id = consumableId })
end

function PolyphemusWaitForPlayerAction( enemy, aiData, args )
	Stop({ Id = enemy.ObjectId })

	local notifyName = "PlayerAction"
	NotifyOnControlPressed({ Names = { "Rush", "Shout", "Attack2", "Attack1", "Attack3", "AutoLock" }, Notify = notifyName })
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = args.TriggerDistance or 200, Notify = notifyName })

	wait(args.ReactionTime)
	thread( InCombatText, enemy.ObjectId, "Alerted", 0.45, { OffsetY = enemy.HealthBarOffsetY, SkipShadow = true }  )
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
end

function CheckWeaponInterrupt( enemy )
	local weaponData = WeaponData[enemy.WeaponName]
	if weaponData ~= nil and weaponData.AIData.InterruptOnDamaged then
		local doInterrupt = true
		if weaponData.AIData.InterruptOnDamagedGracePeriod ~= nil and _worldTime < enemy.LastAttackerAIStartTimestamp + weaponData.AIData.InterruptOnDamagedGracePeriod then
			doInterrupt = false
		elseif weaponData.AIData.InterruptOnDamagedGracePeriodEnd ~= nil and _worldTime > enemy.LastAttackerAIStartTimestamp + weaponData.AIData.InterruptOnDamagedGracePeriodEnd then
			doInterrupt = false
		end
		if doInterrupt then
			enemy.ForcedWeaponInterrupt = weaponData.AIData.InterruptWeapon or enemy.DefaultAIData.InterruptWeapon or true
			SetThreadWait(enemy.AIThreadName, 0.01)
			notifyExistingWaiters(enemy.AIThreadName)
		end
	end
end

function HandleUnitDefenseApply( enemy )
	SetUnitVulnerable(enemy)
	enemy.DefenseReady = false
	wait( CalcEnemyWait( enemy, enemy.DefenseCooldown) )
	if IsAIActive( enemy ) then
		SetUnitInvulnerable(enemy)
		enemy.DefenseReady = true
	end
end

function ChronosTimeSlow( enemy, aiData, CurrentRun, args )
	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = 0.3, Name = "ChronosTimeSlow", ApplyToPlayerUnits = true, SkipPresentation = true })
	thread( CallFunctionName, "ChronosTimeSlowPresentation" )
	thread(EndChronosTimeSlow, enemy, aiData)
end

function EndChronosTimeSlow( enemy, aiData )

	waitUnmodified(aiData.TimeSlowDuration or 10, enemy.AIThreadName)
	thread( CallFunctionName, "ChronosEndTimeSlowPresentation" )
	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = 0.3, Reverse = true, Name = "ChronosTimeSlow", ApplyToPlayerUnits = true })
end

function OilPuddleOnHit( enemy, args )

	if not enemy.Lit then
		local attacker = args.AttackerTable
		local forceIgnite = false
		if attacker == CurrentRun.Hero and args.SourceWeapon then
			local weaponName = args.SourceWeapon
			if WeaponSetLookups.HeroPrimaryWeapons[weaponName] and CurrentRun.Hero.SlottedTraits.Melee and GetLootSourceName(CurrentRun.Hero.SlottedTraits.Melee) == "HestiaUpgrade" then
				forceIgnite = true
			elseif WeaponSetLookups.HeroSecondaryWeapons[weaponName] and CurrentRun.Hero.SlottedTraits.Secondary and GetLootSourceName(CurrentRun.Hero.SlottedTraits.Secondary) == "HestiaUpgrade" then
				forceIgnite = true
			elseif WeaponSetLookups.HeroRangedWeapons[weaponName] and CurrentRun.Hero.SlottedTraits.Ranged and GetLootSourceName(CurrentRun.Hero.SlottedTraits.Ranged) == "HestiaUpgrade" then
				forceIgnite = true
			end
		end
		if forceIgnite or ( ProjectileData[args.SourceProjectile] ~= nil and ProjectileData[args.SourceProjectile].CanIgnite ) then
			enemy.Lit = true
			DoAttackerAILoop(enemy)
		end
	end
end

function CharybdisTransition( enemy, CurrentRun, aiStage )

	local defaultZoom = CurrentRun.CurrentRoom.ZoomFraction

	enemy.WeaponName = aiStage.TransitionWeapon
	DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = enemy.Name.." has no eligible weapons.", Owner = "Eduardo" })
	local aiData = GetWeaponAIData(enemy)
	table.insert(enemy.WeaponHistory, enemy.WeaponName)

	local heroId = CurrentRun.Hero.ObjectId
	PanCamera({ Ids = { heroId, enemy.ObjectId }, Duration = 2.5 })
	CurrentRun.CurrentRoom.ZoomFraction = 0.55
	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.5  })

	AIWait(1.0, enemy, aiData.AIThreadName or enemy.AIThreadName)

	DoAttack( enemy, aiData )

	PanCamera({ Id = heroId, Duration = 1.0, OffsetX = 0, OffsetY = 0, Retarget = true })
	CurrentRun.CurrentRoom.ZoomFraction = defaultZoom
	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.5  })
end

function SelectTentacleBurrowPoints( enemy, aiData )

	if RoomData[CurrentRun.CurrentRoom.Name].TentacleBurrowPoints == nil then
		return
	end

	MapState.TentacleBurrowPoints = MapState.TentacleBurrowPoints or {}

	local numUses = 0
	for i = #enemy.WeaponHistory, 1, -1 do
		local prevWeapon = enemy.WeaponHistory[i]
		if prevWeapon == enemy.WeaponName then
			numUses = numUses + 1
		end
	end

	if MapState.TentacleBurrowPoints[numUses] == nil then
		local randomBurrowPoints = GetRandomValue( RoomData[CurrentRun.CurrentRoom.Name].TentacleBurrowPoints )
		MapState.TentacleBurrowPoints[numUses] = ShallowCopyTable( randomBurrowPoints )
	end

	aiData.TargetId = RemoveRandomValue( MapState.TentacleBurrowPoints[numUses] )
end

function ErisOilTransition(enemy, args)
	wait(args.Delay or 2.25)
	local newOilIds = GetInactiveIds({ Name = args.GroupName })
	ActivatePrePlacedUnits( enemy, { Ids = newOilIds } )
	SetAlpha({ Ids = newOilIds, Fraction = 0, Duration = 0 })
	SetAlpha({ Ids = newOilIds, Fraction = 1, Duration = 1.0 })
end

function ScyllaFightTrackSpotlight(enemy)
	Stop({ Id = enemy.ObjectId })
	Track({ Ids = { enemy.ObjectId }, DestinationIds = { MapState.SpotlightUnitId } })
end