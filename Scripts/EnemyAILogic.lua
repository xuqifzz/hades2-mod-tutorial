AIThreadName = "AIThread"

function AIWait( duration, enemy, threadName, args )
	if duration == nil or duration <= 0 then
		return
	end
	wait( CalcEnemyWait( enemy, duration, args ), threadName )
end

function CheckElapsedTimeMultiplierIgnores( source, args )
	if source ~= nil and source.AIThreadName ~= nil and source.IgnoreTimeSlowEffects then
		SessionMapState.ElapsedTimeMultiplierIgnores[source.AIThreadName] = true
	end
end

function AllAIStop( usee, args )
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		killTaggedThreads( enemy.AIThreadName )
		killWaitUntilThreads( enemy.AINotifyName )
		Stop({ Id = enemy.ObjectId })
		StopAnimation({ DestinationId = enemy.ObjectId })
	end
end

function AllAIFollow( usee, args )
	AllAIStop( usee, args )
	wait( 0.02 )
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		thread( SetAI, "FollowAI", enemy, CurrentRun )
	end
end

function AllAIAttack( usee, args )
	AllAIStop( usee, args )
	wait( 0.02 )
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
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

function DieAI(enemy)
	Kill(enemy)
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
		Move({ Id = enemy.ObjectId, DestinationId = enemy.LeaderId,
				LiveOffsetFromId = enemy.LeaderId, LiveOffsetDistance = followDistance })

		wait(aiData.FollowRefreshDuration or 0.25, enemy.AIThreadName)

		if enemy.DoMinionAttack ~= nil then
			enemy.WeaponName = enemy.DoMinionAttack
			DoAttack(enemy, GetWeaponAIData(enemy))
			enemy.DoMinionAttack = nil
		end
	end

	if ActiveEnemies[enemy.LeaderId] == nil and IsAIActive( enemy ) then
		Stop({ Id = enemy.ObjectId })
		if enemy.CreatedOwnTarget ~= nil then
			Destroy({ Id = enemy.CreatedOwnTarget })
			enemy.CreatedOwnTarget = nil
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

		if enemy.DefaultAIData.IdleAnimation ~= nil then
			SetAnimation({ Name = enemy.DefaultAIData.IdleAnimation, DestinationId = enemy.ObjectId })
		end

		if aiData.WanderDistance ~= nil then
			thread(MoveToRandomLocation, enemy, enemy.ObjectId, aiData.WanderDistance, aiData.WanderDistanceMin or 0, aiData.WanderTimout )
		end
		local wanderInterval = nil
		if aiData.WanderIntervalMin ~= nil and aiData.WanderIntervalMax ~= nil then
			wanderInterval = RandomFloat(aiData.WanderIntervalMin, aiData.WanderIntervalMax)
		end

		-- Wait for target to come within range
		enemy.AINotifyName = "WithinDistanceAny_"..enemy.ObjectId
		NotifyWithinDistanceAny({ Ids = { searchId }, DestinationNames = aiData.TriggerGroups or aiData.TargetGroups,
									Distance = aiData.AttackDistance, ScaleY = aiData.AttackDistanceScaleY or 0.65,
									Notify = enemy.AINotifyName, UseLocationZ = true, Timeout = wanderInterval })
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
		if not IsAIActive( enemy ) and aiData.DisabledAnimation ~= nil then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.DisabledAnimation })
			break
		end

		if not _eventTimeoutRecord[enemy.AINotifyName] then
			DoAttackerAILoop(enemy, aiData)
			SurroundEnemiesAttacking[aiData.SurroundAIKey or enemy.Name][enemy.ObjectId] = nil
		end

		if aiData.PostAttackEndAI then
			return
		end
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

	if enemy.ActivateGameStateRequirements ~= nil and not IsGameStateEligible( enemy, enemy.ActivateGameStateRequirements) then
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

	enemy.ToggleTrap = false
	DoAttackerAILoop(enemy, aiData)

	SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.DisabledAnimation })
end

function SentryAI( enemy )

	if enemy.SentryTetherId == nil then
		enemy.SentryTetherId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId })
		enemy.DestroyIdsOnDeath = enemy.DestroyIdsOnDeath or {}
		table.insert( enemy.DestroyIdsOnDeath, enemy.SentryTetherId )
	end

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

	enemy.WeaponName = SelectWeapon(enemy)

	local aiData = ShallowCopyTable(enemy.DefaultAIData) or {}
	--DebugAssert({ Condition = enemy.DefaultAIData ~= nil, Text = enemy.Name.." has no DefaultAIData", Owner = "Eduardo" })
	if WeaponData[enemy.WeaponName] ~= nil and WeaponData[enemy.WeaponName].AIData ~= nil then
		OverwriteTableKeys( aiData, WeaponData[enemy.WeaponName].AIData)
	end
	aiData.WeaponName = enemy.WeaponName

	local targetId = GetTargetId( enemy, aiData )
	DoAttackerAILoop( enemy, aiData )

	while enemy.ChainedWeapon ~= nil or enemy.ActiveWeaponCombo ~= nil do
		enemy.WeaponName = SelectWeapon(enemy)
		--DebugPrint({ Text=enemy.WeaponName })

		aiData = ShallowCopyTable(enemy.DefaultAIData) or {}
		--DebugAssert({ Condition = enemy.DefaultAIData ~= nil, Text = enemy.Name.." has no DefaultAIData", Owner = "Eduardo" })
		if WeaponData[enemy.WeaponName] ~= nil and WeaponData[enemy.WeaponName].AIData ~= nil then
			OverwriteTableKeys( aiData, WeaponData[enemy.WeaponName].AIData)
		end
		aiData.WeaponName = enemy.WeaponName
		DoAttackerAILoop( enemy, aiData )
	end

	while enemy.IsPolymorphed do
		wait(0.5, enemy.AIThreadName )
	end

	Kill( enemy )
end

function DestructibleTreeHit( enemy, attacker, triggerArgs )
	if attacker == nil or (attacker.ObjectId ~= CurrentRun.Hero.ObjectId and triggerArgs.AttackerName ~= "ShadeMerc" ) then
		return
	end

	local hits = nil
	if triggerArgs ~= nil and triggerArgs.AttackerWeaponData ~= nil and triggerArgs.AttackerWeaponData.ImpactReactionHitsOverride ~= nil then
		hits = triggerArgs.AttackerWeaponData.ImpactReactionHitsOverride
	end
	if triggerArgs ~=nil and triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] then
		hits = ProjectileData[triggerArgs.SourceProjectile].ImpactReactionHitsOverride
	end

	if not hits then
		hits = 1
	end
	enemy.HitsTaken = enemy.HitsTaken or 0
	enemy.HitsTaken = enemy.HitsTaken + hits
	RecordObjectState( CurrentRun.CurrentRoom, enemy.ObjectId, "HitsTaken", enemy.HitsTaken )

	if attacker ~= nil then
		enemy.KillOwner = attacker.ObjectId
	end
	
	if enemy.HitsTaken >= enemy.DefaultAIData.HitsToSplinter then
		enemy.WeaponHistory = enemy.WeaponHistory or {}
		if #enemy.WeaponHistory == 0 then
		 	SetAngle({ Id = enemy.ObjectId, Angle = triggerArgs.ImpactAngle })
			DoAttackerAILoop( enemy )
			
			if enemy.DestroyedAnimation then
				SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DestroyedAnimation })
			end
			RecordObjectState( CurrentRun.CurrentRoom, enemy.ObjectId, "Animation", enemy.DestroyedAnimationToRestore or enemy.DestroyedAnimation )

			if not enemy.DestroyedStopsProjectiles then
				SetThingProperty({ Property = "StopsProjectiles",  DestinationId = enemy.ObjectId, Value = false })
				RecordObjectState(CurrentRun.CurrentRoom, enemy.ObjectId, "StopsProjectiles", false)
			end
		end
	elseif enemy.HitsTaken <= enemy.DefaultAIData.HitsToSplinter and enemy.SplinterAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.SplinterAnimation })
	end
end

function TyphonMineAI( enemy )

	enemy.WeaponName = SelectWeapon( enemy )
	table.insert( enemy.WeaponHistory, enemy.WeaponName )
	local aiData = GetWeaponAIData(enemy)

	if aiData.IdleAnimation ~= nil then
		SetAnimation({ Name = enemy.DefaultAIData.IdleAnimation, DestinationId = enemy.ObjectId })
	end

	-- Wait for target to come within range
	enemy.AINotifyName = "WithinDistanceAny_"..enemy.ObjectId
	NotifyWithinDistanceAny({ Ids = { enemy.ObjectId }, DestinationNames = aiData.TriggerGroups or aiData.TargetGroups,
								Distance = aiData.AttackDistance, ScaleY = aiData.AttackDistanceScaleY or 0.65,
								Notify = enemy.AINotifyName, UseLocationZ = true })
	waitUntil( enemy.AINotifyName )
	aiData.TargetId = NotifyResultsTable[enemy.AINotifyName]

	DoAttackerAILoop(enemy, aiData)
	Kill(enemy)
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
		RecordObjectState( CurrentRun.CurrentRoom, enemy.ObjectId, "Animation", enemy.DestroyedAnimationToRestore or enemy.DestroyedAnimation )

		SetThingProperty({ Property = "StopsProjectiles",  DestinationId = enemy.ObjectId, Value = false })
		RecordObjectState(CurrentRun.CurrentRoom, enemy.ObjectId, "StopsProjectiles", false)
	elseif enemy.DefaultAIData.HitsToSplinter - enemy.HitsTaken == 1 and enemy.SplinterAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.SplinterAnimation })
	elseif enemy.DefaultAIData.HitsToSplinter - enemy.HitsTaken > 1 then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.OnHitAnimation })
	end
end

function FireAndQuit( enemy )
	DoAttackerAILoop(enemy)
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

		if SessionMapState.SprintActive or HasEffect({ Id = CurrentRun.Hero.ObjectId, EffectName = "RushWeaponDisableMove" }) or SessionMapState.ForceShadeMercActive then

			local endAI = false

			local aiData = nil
			enemy.WeaponName = SelectWeapon( enemy )
			table.insert(enemy.WeaponHistory, enemy.WeaponName)
			aiData = GetWeaponAIData(enemy)

			-- Target skelly in PreRun
			if CurrentHubRoom ~= nil and CurrentHubRoom.ShadeMercAITarget ~= nil then
				aiData.TargetId = GetIdsByType({ Name = CurrentHubRoom.ShadeMercAITarget })[1]
			end
			if aiData.TargetId == nil then
				aiData.TargetId = GetTargetId(enemy, aiData)
			end
			
			if SessionMapState.ForceShadeMercTargetId then
				aiData.TargetId = SessionMapState.ForceShadeMercTargetId
				aiData.TargetIdOverride = SessionMapState.ForceShadeMercTargetId
			end

			if aiData.TargetId ~= 0 and enemy.WeaponName ~= nil and not enemy.SkipCanAttack then
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

	if IsEmpty( room.ActiveEncounters ) then
		return
	end

	table.insert( room.ShadeMercInactiveIds, enemy.ObjectId )
	RemoveValue( room.ShadeMercActiveIds, enemy.ObjectId )
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

function GroupAI( leader )
	if leader.UnitGroupData.LeaderFx ~= nil then
		leader.StopAnimationsOnDeath = leader.StopAnimationsOnDeath or {}
		table.insert(leader.StopAnimationsOnDeath, leader.UnitGroupData.LeaderFx)
		CreateAnimation({ Name = leader.UnitGroupData.LeaderFx, DestinationId = leader.ObjectId })
	end
	if leader.UnitGroupData.DisableLeaderUnitCollision ~= nil then
		SetUnitProperty({ Property = "CollideWithUnits",  DestinationId = leader.ObjectId, Value = false })
	end
	SetupAI( leader )

	for k, unitId in ipairs( leader.UnitGroupData.UnitIds ) do
		local minion = ActiveEnemies[unitId]
		if minion ~= nil then
			minion.DefaultAIData.FollowId = leader.ObjectId
			minion.LeaderId = leader.ObjectId
			minion.MinionAI = minion.MinionAI or "MinionFollowAI"
			minion.AIOptions = { minion.MinionAI }
			SetUnitProperty({ Property = "Speed",  DestinationId = minion.ObjectId, Value = GetUnitDataValue({ Id = minion.ObjectId, Property = "Speed" }) * 1.2 })
			SetupAI( minion )
			wait( 0.03 ) -- Space out activation
		end
	end

end

function HandleMinionWeapons(leader, aiData)
	for k, minionId in pairs(leader.UnitGroupData.UnitIds) do

		local minion = ActiveEnemies[minionId]
		if minion ~= nil then
			wait(aiData.AttackStaggerDelay, leader.AIThreadName)
			minion.DoMinionAttack = aiData.MinionWeapon
			notifyExistingWaiters(minion.AINotifyName)
			SetThreadWait(minion.AIThreadName, 0.0)
		else
			RemoveValue(leader.UnitGroupData.UnitIds, minionId)
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
		if SurroundEnemiesAttacking[enemy.SurroundAIKey or enemy.Name] ~= nil then
			SurroundEnemiesAttacking[enemy.SurroundAIKey or enemy.Name][enemy.ObjectId] = nil
		end
		if not continue then
			return
		end

	end
end

function DoAttackerAILoop( enemy, aiData )

	enemy.LastAttackerAIStartTimestamp = _worldTime
	if aiData == nil then
		enemy.WeaponName = SelectWeapon( enemy )
		--DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = enemy.Name.." has no eligible weapons.", Owner = "Eduardo" })
		aiData = GetWeaponAIData(enemy)
	end
	table.insert(enemy.WeaponHistory, enemy.WeaponName)

	if enemy.TargetIdsLeaked ~= nil then
		for id, v in pairs( enemy.TargetIdsLeaked ) do
			Destroy({ Id = id })
		end
		enemy.TargetIdsLeaked = nil
	end

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
			ActiveEnemies[enemy.ComboPartnerId].ForcedWeaponInterrupt = aiData.PartnerForceWeaponInterrupt
			ActiveEnemies[enemy.ComboPartnerId].ChainedWeapon = nil
			SetThreadWait( ActiveEnemies[enemy.ComboPartnerId].AIThreadName, 0.01 )
		end
	end

	if aiData.TargetId == nil then
		aiData.TargetId = GetTargetId(enemy, aiData)
	end

	if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
		if aiData.AttackFailWeapon ~= nil and not enemy.IsPolymorphed and (aiData.AttackFailWeaponRequirements == nil or IsEnemyWeaponEligible(enemy, WeaponData[aiData.AttackFailWeapon], aiData.AttackFailWeaponRequirements)) then
			--DebugAssert({ Condition = aiData.AttackFailWeapon ~= enemy.WeaponName, Text = "Using "..tostring(aiData.WeaponName).." as AttackFailWeapon on itself. This will infinite loop.", Owner = "Eduardo" })
			enemy.WeaponName = aiData.AttackFailWeapon
			local newAIData = GetWeaponAIData(enemy)
			DoAttackerAILoop(enemy, newAIData)
			return true
		end
		enemy.AINotifyName = "CanAttack"..enemy.ObjectId
		NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
		waitUntil( enemy.AINotifyName )
	end

	if (aiData.TargetId ~= nil and aiData.TargetId ~= 0) and (not aiData.SkipIfTargetLocationBlocked or not IsLocationBlocked({ Id = aiData.TargetId }) ) then

		-- Pre-Movement
		if aiData.RetreatBeforeAttack then
			Retreat(enemy, aiData, aiData.TargetId)
			AIWait(0.05, enemy, aiData.AIThreadName or enemy.AIThreadName)
			if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
				return true
			end
		end

		if aiData.PreMoveTrackTarget then
			Track({ Ids = { enemy.ObjectId }, DestinationIds = { aiData.TargetId }, AngleMin = enemy.AngleMin, AngleMax = enemy.AngleMax })
		end

		if aiData.PreMoveFunctionName then
			CallFunctionName( aiData.PreMoveFunctionName, enemy, aiData, aiData.PreMoveFunctionArgs )
		end

		if aiData.PreMoveVoiceLines ~= nil then
			thread( PlayVoiceLines, aiData.PreMoveVoiceLines, nil, enemy )
		end

		-- Teleportation
		if aiData.PreMoveTeleport then
			HandleEnemyTeleportation(enemy, aiData)
		end

		-- Leap
		if aiData.PreMoveLeap then
			Leap( enemy, aiData )
		end

		if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt) then
			return true
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

			if didTimeout and aiData.SkipAttackIfMoveTimeout then
				return true
			end

			if aiData.IsRushWeapon and enemy.RushCollision and aiData.RushCollisionWeapon then
				enemy.RushCollision = false
				enemy.WeaponName = aiData.RushCollisionWeapon
				local rushCollisionWeaponAIData = GetWeaponAIData(enemy)
				DoAttackerAILoop(enemy, rushCollisionWeaponAIData)
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

		-- Abort if target died during MoveWithinRange()
		if aiData.TargetRequiredKillEnemy and aiData.TargetId ~= CurrentRun.Hero.ObjectId and ActiveEnemies[aiData.TargetId] == nil and MapState.ActiveObstacles[aiData.TargetId] then
			--DebugPrint({ Text=enemy.Name.."'s TargetId is dead! Aborting weapon." })
			aiData.DoNotRepeatOnAttackFail = true
			return true
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

		if aiData.PreAttackTeleport then
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
			UpdateHealthBar( enemy, 0, { Force = true } )
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
				if aiData.PostAttackSetUnitProperties ~= nil then
					for unitProperty, unitPropertyValue in pairs(aiData.PostAttackSetUnitProperties) do
						--DebugPrint({ Text="Set "..enemy.Name.." "..unitProperty.." to "..unitPropertyValue })
						SetUnitProperty({ DestinationId = enemy.ObjectId, Value = unitPropertyValue, Property = unitProperty  })
					end
				end
				return true
			end
			if not attackSuccess then
				if aiData.AttackFailWeapon ~= nil and not enemy.IsPolymorphed and (aiData.AttackFailWeaponRequirements == nil or IsEnemyWeaponEligible(enemy, WeaponData[aiData.AttackFailWeapon], aiData.AttackFailWeaponRequirements))  then
					--DebugAssert({ Condition = aiData.AttackFailWeapon ~= enemy.WeaponName, Text = "Using "..tostring(enemy.WeaponName).." as AttackFailWeapon on itself. This will infinite loop.", Owner = "Eduardo" })
					enemy.WeaponName = aiData.AttackFailWeapon
					local newAIData = GetWeaponAIData(enemy)
					DoAttackerAILoop(enemy, newAIData)
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
		
		if SurroundEnemiesAttacking[enemy.SurroundAIKey or enemy.Name] ~= nil then
			SurroundEnemiesAttacking[enemy.SurroundAIKey or enemy.Name][enemy.ObjectId] = nil
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

		if aiData.PostAttackEndAddIncomingDamageModifier then
			AddIncomingDamageModifier( enemy, aiData.PostAttackAddIncomingDamageModifier )
		end

		if aiData.PostAttackEndRemoveIncomingDamageModifier then
			RemoveIncomingDamageModifier( enemy, aiData.PostAttackRemoveIncomingDamageModifier )
		end

		-- Post-Attack Movement
		if aiData.PostAttackRemoveEnemyUI then
			RemoveEnemyUI( enemy )
		end

		if aiData.PostAttackCreateHealthBar then
			RecreateEnemyUI( enemy )
		end

		if aiData.RetreatAfterAttack then
			Retreat(enemy, aiData, aiData.TargetId)
			
			if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
				return true
			end

			if aiData.RetreatAfterAttackEndWait ~= nil then
				Track({ Ids = { enemy.ObjectId }, DestinationIds = { aiData.TargetId } })

				AIWait(aiData.RetreatAfterAttackEndWait, enemy, aiData.AIThreadName or enemy.AIThreadName)
			end
		end

		-- Teleportation
		if aiData.PostAttackEndTeleport then
			HandleEnemyTeleportation(enemy, aiData)
		end

		-- Leap
		if aiData.PostAttackLeap then
			Leap( enemy, aiData )
		end

		if enemy.CreatedOwnTarget then
			Destroy({ Id = enemy.CreatedOwnTarget })
			enemy.CreatedOwnTarget = nil
		end

		if aiData.DeaggroAfterAttack then
			return SetAI("AggroAI", enemy, CurrentRun)
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

function HandleEnemyTeleportation( enemy, aiData )
	if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
		return
	end

	aiData.TeleportationInterval = aiData.TeleportationInterval or 0
	if aiData.TeleportationIntervalMin ~= nil and aiData.TeleportationIntervalMax then
		RandomFloat( aiData.TeleportationIntervalMin, aiData.TeleportationIntervalMax )
	end
	enemy.LastTeleportTime = enemy.LastTeleportTime or 0

	if _worldTime - enemy.LastTeleportTime >= aiData.TeleportationInterval then
		local targetPointId = aiData.TeleportToId

		if aiData.TeleportToTarget then
			targetPointId = aiData.TargetId
		elseif aiData.TeleportToComboPartner then
			targetPointId = enemy.ComboPartnerId
		elseif targetPointId == nil then
			targetPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, enemy, { SpawnNearId = aiData.TargetId or CurrentRun.Hero.ObjectId, SpawnRadius = aiData.TeleportMaxDistance or 1000, SpawnRadiusMin = aiData.TeleportMinDistance, MinPlayerArc = aiData.TeleportMinPlayerArc, MaxPlayerArc = aiData.TeleportMaxPlayerArc },
															{ RequiredSpawnPoint = aiData.TeleportToSpawnPointType, AllowNoSpawnPoint = true, SpawnAwayFromTypes = aiData.SpawnAwayFromTypes, SpawnAwayFromTypesDistance = aiData.SpawnAwayFromTypesDistance, RequireLoS = aiData.RequireTeleportTargetLoS, LoSTarget = aiData.TargetId, PreferredSpawnPoint = aiData.PreferredSpawnPoint, PreferredSpawnPointGroup = aiData.PreferredSpawnPointGroup })
		end
		-- spawn a target in case target Id is moving
		if aiData.TeleportToStaticDestination then
			targetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetPointId, OffsetX = aiData.TeleportOffsetX, OffsetY = aiData.TeleportOffsetY, ForceToValidLocation = true })
		end

		if targetPointId == nil then
			--DebugPrint({ Text="NO TELEPORT TARGET" })
			return
		end
		
		if enemy.OccupyingSpawnPointId ~= nil then
			UnoccupySpawnPoint(enemy.OccupyingSpawnPointId)
		end
		enemy.OccupyingSpawnPointId = targetPointId
		SessionMapState.SpawnPointsUsed[targetPointId] = enemy.ObjectId

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
			ClearAllEffects( enemy ) 
		end

		if aiData.StartTeleportScreenShake then
			ShakeScreen( aiData.StartTeleportScreenShake )
		end

		AIWait( aiData.PreTeleportWait, enemy, aiData.AIThreadName or enemy.AIThreadName )

		if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
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
			AIWait( aiData.MidTeleportWait, enemy, aiData.AIThreadName or enemy.AIThreadName )
			if aiData.TeleportDestinationFx ~= nil then 
				StopAnimation({ Name = aiData.TeleportDestinationFx, DestinationId = destinationFxId })
			end
			if enemy.ForcedWeaponInterrupt then
				return
			end
			if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
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
		if aiData.TeleportAlpha ~= nil then
			SetAlpha({ Id = enemy.ObjectId, Fraction = aiData.TeleportAlpha, Duration = aiData.TeleportAlphaDuration or 0 })
		end

		ClearAutoLock({ Id = CurrentRun.Hero.ObjectId })
		Teleport({ Id = enemy.ObjectId, DestinationId = targetPointId })

		thread( UnoccupySpawnPointOnDistance, enemy, targetPointId, 400 )

		if aiData.TeleportEndFx ~= nil then
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.TeleportEndFx })
		end

		if aiData.PostTeleportClearAllEffects then
			ClearAllEffects( enemy ) 
		end

		if aiData.PostTeleportAngleTowardTarget then
			AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
		end

		enemy.LastTeleportTime = _worldTime

		if aiData.TeleportationIntervalMin ~= nil and aiData.TeleportationIntervalMax ~= nil then
			aiData.TeleportationInterval = RandomFloat( aiData.TeleportationIntervalMin, aiData.TeleportationIntervalMax )
		end
		AIWait( aiData.PostTeleportWait, enemy, aiData.AIThreadName or enemy.AIThreadName )

		if createdOwnTarget then
			Destroy({ Id = teleportPointId })
		end
	end
end

function SelectWeapon( enemy )
	local nextWeapon = nil
	enemy.WeaponComboData = nil

	if enemy.ForcedWeaponInterrupt == true then
		enemy.ForcedWeaponInterrupt = nil
	end

	-- Weapon Selection

	if enemy.ForcedWeaponInterrupt ~= nil then
		enemy.WeaponName = enemy.ForcedWeaponInterrupt
		enemy.ForcedWeaponInterrupt = nil
		nextWeapon = enemy.WeaponName
	elseif enemy.ForcedNextWeapon ~= nil then
		enemy.WeaponName = enemy.ForcedNextWeapon
		enemy.ForcedNextWeapon = nil
		nextWeapon = enemy.WeaponName
	elseif enemy.ChainedWeapon ~= nil then
		if WeaponData[enemy.ChainedWeapon] ~= nil and WeaponData[enemy.ChainedWeapon].ChainChance ~= nil and not RandomChance(WeaponData[enemy.ChainedWeapon].ChainChance) then
			--DebugPrint({ Text="Failed ChainChance" })
			enemy.ChainedWeapon = nil
			return SelectWeapon(enemy)
		else
			enemy.WeaponName = enemy.ChainedWeapon
			enemy.ChainedWeapon = nil
			if WeaponData[enemy.WeaponName] ~= nil and WeaponData[enemy.WeaponName].WeaponSelectorOnly then
				nextWeapon = GetRandomValue(WeaponData[nextWeapon].SelectorOptions)
			elseif WeaponData[enemy.WeaponName] ~= nil and WeaponData[enemy.WeaponName].WeaponComboOnly then
				enemy.ActiveWeaponCombo = enemy.WeaponName
				enemy.ActiveWeaponComboIndex = 0
				nextWeapon = SelectWeapon( enemy )
			else
				nextWeapon = enemy.WeaponName
			end
		end
	elseif enemy.ActiveWeaponCombo ~= nil then
		enemy.ActiveWeaponComboIndex = enemy.ActiveWeaponComboIndex + 1
		local activeWeaponCombo = WeaponData[enemy.ActiveWeaponCombo].WeaponCombo

		if enemy.ActiveWeaponComboIndex <= #WeaponData[enemy.ActiveWeaponCombo].WeaponCombo then
			if type(activeWeaponCombo[enemy.ActiveWeaponComboIndex]) == "table" then
				local weaponComboData = activeWeaponCombo[enemy.ActiveWeaponComboIndex]

				if weaponComboData.GameStateRequirements == nil or IsGameStateEligible(enemy, weaponComboData.GameStateRequirements) then
					enemy.WeaponComboData = DeepCopyTable(weaponComboData)

					local comboWeaponOptions = ShallowCopyTable(weaponComboData.WeaponOptions) or { weaponComboData.WeaponName }
					for i, weaponOption in ipairs( comboWeaponOptions ) do
						if not weaponComboData.IgnoreRequirements and not IsEnemyWeaponEligible( enemy, WeaponData[weaponOption]) then
							RemoveValue( comboWeaponOptions, weaponOption )
						end
					end

					if IsEmpty(comboWeaponOptions) then
						return SelectWeapon( enemy )
					end

					enemy.WeaponComboData.WeaponName = GetRandomValue(comboWeaponOptions)
					enemy.WeaponName = enemy.WeaponComboData.WeaponName
					nextWeapon = enemy.WeaponName
				else
					return SelectWeapon( enemy )
				end
			else
				enemy.WeaponName = activeWeaponCombo[enemy.ActiveWeaponComboIndex]
				nextWeapon = enemy.WeaponName
			end
		end
		if enemy.ActiveWeaponComboIndex >= #WeaponData[enemy.ActiveWeaponCombo].WeaponCombo then
			enemy.ActiveWeaponCombo = nil
		end
	elseif nextWeapon == nil and enemy.WeaponOptions then
		local eligibleWeaponOptions = {}
		local forcedWeaponOptions = {}

		for k, weaponName in ipairs( enemy.WeaponOptions ) do
			local weaponData = WeaponData[weaponName]
			if weaponData == nil or weaponData.AIData == nil or IsEnemyWeaponEligible( enemy, weaponData ) then
				if IsEnemyWeaponForced( enemy, weaponName ) then
					table.insert( forcedWeaponOptions, weaponName )
				else
					table.insert( eligibleWeaponOptions, weaponName )
				end
			end
		end

		nextWeapon = GetRandomArrayValue( forcedWeaponOptions ) or GetRandomArrayValue( eligibleWeaponOptions )
	end

	-- Conditional Weapon Swaps
	if nextWeapon == nil then
		if enemy.DisarmedWeapon ~= nil then
			--DebugPrint({ Text = "Equiping disarmed weapon" })
			nextWeapon = enemy.DisarmedWeapon
		end
	end

	if WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].ConditionalWeaponSwap ~= nil then
		for k, conditionalData in pairs(WeaponData[nextWeapon].ConditionalWeaponSwap) do
			if IsGameStateEligible(enemy, conditionalData.GameStateRequirements) then
				nextWeapon = conditionalData.WeaponName
			end
		end
	end

	if enemy.Enraged and WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].AIData ~= nil and WeaponData[nextWeapon].AIData.EnragedWeaponSwap ~= nil then
		nextWeapon = WeaponData[nextWeapon].AIData.EnragedWeaponSwap
	end

	if enemy.GodUpgrade ~= nil and WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].GodUpgradeWeaponSwap ~= nil and WeaponData[nextWeapon].GodUpgradeWeaponSwap[enemy.GodUpgrade] ~= nil then
		nextWeapon = WeaponData[nextWeapon].GodUpgradeWeaponSwap[enemy.GodUpgrade]
	end

	if WeaponData[nextWeapon] ~= nil then
		if WeaponData[nextWeapon].SkipToChainedWeaponIfObstacleExists ~= nil and not IsEmpty(GetIdsByType({ Name = WeaponData[nextWeapon].SkipToChainedWeaponIfObstacleExists })) then
			nextWeapon = WeaponData[nextWeapon].AIData.ChainedWeapon
		end

		if WeaponData[nextWeapon].WeaponSelectorOnly then
			nextWeapon = GetRandomArrayValue( WeaponData[nextWeapon].SelectorOptions )
		end

		if WeaponData[nextWeapon].WeaponCombo ~= nil then
			enemy.ActiveWeaponCombo = nextWeapon
			enemy.ActiveWeaponComboIndex = 0
			if WeaponData[nextWeapon].WeaponComboOnly then
				table.insert( enemy.WeaponHistory, nextWeapon )
				return SelectWeapon( enemy )
			end
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
		if requirements.SkipRequirementsIfNotAggroed and not enemy.IsAggroed then
			return true
		end

		if requirements.RequiresNotCharmed and (enemy.Charmed or IsCharmed({ Id = enemy.ObjectId })) then
			return false
		end

		if requirements.BlockAsFirstWeapon and (enemy.WeaponHistory == nil or #enemy.WeaponHistory <= 0) then
			return false
		end

		if requirements.RequireTotalAttacks ~= nil and (enemy.WeaponHistory == nil or #enemy.WeaponHistory <= requirements.RequireTotalAttacks) then
			return false
		end

		if requirements.MaxAttackers ~= nil and TableLength( SurroundEnemiesAttacking[weaponData.SurroundAIKey or enemy.Name]) >= requirements.MaxAttackers and not IsCharmed({ Id = enemy.ObjectId }) then
			return false
		end

		if requirements.MinAttackers ~= nil and TableLength( SurroundEnemiesAttacking[weaponData.SurroundAIKey or enemy.Name]) < requirements.MinAttackers and not IsCharmed({ Id = enemy.ObjectId }) then
			return false
		end

		if requirements.MinRequiredKillEnemies ~= nil and TableLength(RequiredKillEnemies) < requirements.MinRequiredKillEnemies then
			return false
		end

		if requirements.MaxRequiredKillEnemies ~= nil and TableLength(RequiredKillEnemies) >= requirements.MaxRequiredKillEnemies then
			return false
		end

		if requirements.MapAggressor ~= nil and MapState.Aggressor ~= nil and requirements.MapAggressor ~= MapState.Aggressor then
			return false
		end

		if requirements.RequiresAMapAggressor and MapState.Aggressor == nil then
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
			for k, weaponReq in ipairs(requirements.PreviousWeaponNot) do
				if prevWeapon == weaponReq then
					return false
				end
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

		if requirements.RequirePlayerRightSide or requirements.RequirePlayerLeftSide then
			local angle = GetAngle({ Id = enemy.ObjectId }) - GetAngleBetween({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			if (angle > 0 and angle < 180) or (angle < -180 and angle > -360) then -- If the player is on the right side of the unit
				if requirements.RequirePlayerLeftSide then
					return false
				end
			else
				if requirements.RequirePlayerRightSide then
					return false
				end
			end
		end

		if requirements.MaxPlayerDistance ~= nil and not enemy.IsCharmed then
			if not IsWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = requirements.MaxPlayerDistance, ScaleY = requirements.MaxPlayerDistanceScaleY }) then
				return false
			end
		end

		if requirements.MinPlayerDistance ~= nil and not enemy.IsCharmed then
			if IsWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = requirements.MinPlayerDistance, ScaleY = requirements.MinPlayerDistanceScaleY }) then
				return false
			end
		end

		if requirements.HasEffect ~= nil and enemy.ActiveEffects[requirements.HasEffect] == nil then
			return false
		end

		if requirements.HasEffectFalse ~= nil and enemy.ActiveEffects[requirements.HasEffectFalse] ~= nil then
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

		if enemy.Health ~= nil then
			local healthPercent = enemy.Health / enemy.MaxHealth
			if requirements.HealthPercentMax ~= nil and healthPercent > requirements.HealthPercentMax then
				return false
			end
			if requirements.HealthPercentMin ~= nil and healthPercent < requirements.HealthPercentMin then
				return false
			end
		end

		if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.GroupHealth ~= nil then
			local groupHealthPercent = CurrentRun.CurrentRoom.Encounter.GroupHealth / CurrentRun.CurrentRoom.Encounter.GroupMaxHealth
			if requirements.GroupHealthPercentMax ~= nil and groupHealthPercent > requirements.GroupHealthPercentMax then
				return false
			end
			if requirements.GroupHealthPercentMin ~= nil and groupHealthPercent < requirements.GroupHealthPercentMin then
				return false
			end
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

		if requirements.RequireNumIdsOfType ~= nil and #GetIdsByType({ Name = requirements.RequireNumIdsOfType.Name }) ~= requirements.RequireNumIdsOfType.Count then
			return false
		end

		if requirements.RequireMaxIdsOfType ~= nil and #GetIdsByType({ Name = requirements.RequireMaxIdsOfType.Name }) > requirements.RequireMaxIdsOfType.Count then
			return false
		end

		if requirements.RequireMinIdsOfType ~= nil and #GetIdsByType({ Name = requirements.RequireMinIdsOfType.Name }) < requirements.RequireMinIdsOfType.Count then
			return false
		end

		if requirements.RequireNumIdsOfTypes ~= nil and #GetIdsByType({ Names = requirements.RequireNumIdsOfTypes.Names }) ~= requirements.RequireNumIdsOfTypes.Count then
			return false
		end

		if requirements.RequireMaxIdsOfTypes ~= nil and #GetIdsByType({ Names = requirements.RequireMaxIdsOfTypes.Names }) > requirements.RequireMaxIdsOfTypes.Count then
			return false
		end

		if requirements.RequireMinIdsOfTypes ~= nil and #GetIdsByType({ Names = requirements.RequireMinIdsOfTypes.Names }) < requirements.RequireMinIdsOfTypes.Count then
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

		if requirements.UnitLoSDistanceTowardPlayer ~= nil then
			local offset = CalcOffset(math.rad(GetAngleBetween({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })), requirements.UnitLoSDistanceTowardPlayer)
			local destinationMarkerId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
			local hasLoS = HasLineOfSight({ Id = enemy.ObjectId, DestinationId = destinationMarkerId, StopsUnits = true })
			Destroy({ Id = destinationMarkerId })
			if not hasLoS then
				--DebugPrint({ Text="INELIGIBLE, UNIT NO LOS USING "..enemy.WeaponName })
				return
			end
		end

		if weaponData.Requirements ~= nil and (weaponData.Requirements.RequireProjectileLoS or weaponData.Requirements.RequireUnitLoS) then
			local hasLoS = HasLineOfSight({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId,
							StopsUnits = weaponData.Requirements.LoSStopsUnits or true, StopsProjectiles = weaponData.Requirements.LoSStopsProjectiles or true,
							LineOfSightBuffer = weaponData.Requirements.LoSBuffer,
							LineOfSightEndBuffer = weaponData.Requirements.LoSEndBuffer,  })
			if not hasLoS then
				return false
			end
		end

	end

	if weaponData.GameStateRequirements ~= nil and not IsGameStateEligible( enemy, weaponData.GameStateRequirements ) then
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

	if aiData.AlwaysForce then
		return true
	end

	if aiData.ForceUseIfReady then
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

	if projectileData.GameStateRequirements ~= nil and not IsGameStateEligible( enemy, projectileData.GameStateRequirements ) then
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
	if aiData.PreMoveStop then
		Stop({ Id = enemy.ObjectId })
	end
	if aiData.PreMoveAngleTowardTarget then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = moveTargetId, AngleMin = enemy.AngleMin, AngleMax = enemy.AngleMax })
		
		if aiData.PreMoveWaitForAngleTowardTarget then
			enemy.AINotifyName = "WaitForRotation"..enemy.ObjectId
			NotifyOnRotationComplete({ Id = enemy.ObjectId, Cosmetic = true, Notify = enemy.AINotifyName, Timeout = aiData.WaitForAngleTowardTargetTimeOut or 9.0 })
			waitUntil( enemy.AINotifyName )

			if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
				return false
			end
		end
	end
	if aiData.MoveLowPass then
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 1.0 })
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
	if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
		return false
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

	if aiData.SpawnBurstOnMove then
		thread(HandleSpawnerBurst, enemy, aiData)
	end

	local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = moveTargetId }) 

	-- Dash
	if aiData.DashIfOverDistance ~= nil then
		if distanceToTarget > attackDistance and aiData.DashIfOverDistance < distanceToTarget
		and (not aiData.DashRequireLoS or HasLineOfSight({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, StopsUnits = true, CheckUnits = false, LineOfSightBuffer = 50, LineOfSightEndBuffer = 50,  }))
		then
			enemy.WeaponName = aiData.DashWeapon or GetRandomValue(aiData.DashWeapons)
			local dashWeaponAIData = GetWeaponAIData(enemy)
			dashWeaponAIData.TargetId = aiData.TargetId

			DoAttack( enemy, dashWeaponAIData )
			enemy.WeaponName = aiData.WeaponName
		end
	end

	-- If already within range
	local isWithinDistanceToTarget = IsWithinDistance({ Id = enemy.ObjectId, DestinationId = moveTargetId, Distance = attackDistance, ScaleY = aiData.AttackDistanceScaleY })
	if isWithinDistanceToTarget then
		if aiData.WithinRangeWander then
			MoveToRandomLocation( enemy, enemy.ObjectId, aiData.WithinRangeWanderDistance or 100, aiData.WithinRangeWanderDistanceMin or 0, aiData.WithinRangeWanderDuration )
		end
		if aiData.AttackDistanceMin ~= nil and aiData.AttackDistanceMin > distanceToTarget then
			Retreat(enemy, aiData, moveTargetId)
		end

		-- Skip Move() call if we are going to stop right away anyway
		if aiData.StopMoveWithinRange then
			local hasLoS = HasLineOfSight({ Id = enemy.ObjectId, DestinationId = aiData.TargetId,
							StopsUnits = aiData.RequireUnitLoS,
							StopsProjectiles = aiData.RequireProjectileLoS,
							CheckUnits = aiData.CheckUnits,
							LineOfSightBuffer = aiData.LoSBuffer,
							LineOfSightEndBuffer = aiData.LoSEndBuffer,  })
			if hasLoS or (not aiData.RequireUnitLoS and not aiData.RequireProjectileLoS) then
				return false
			end
		end
	end
	
	if aiData.MoveDumbFireWeapons ~= nil then
		for k, weaponName in pairs( aiData.MoveDumbFireWeapons ) do
			thread( DumbFireAttack, enemy, weaponName )
		end
	end

	if aiData.IsRushWeapon then
		enemy.Rushing = true
		enemy.RushStartTime = _worldTime
	end

	if aiData.MoveAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.MoveAnimation })
	end

	if aiData.MoveStartSelfVelocity then
		if not aiData.SkipSelfVelocityIfImpactSlow or not HasEffect({ Id = enemy.ObjectId, EffectName = "ImpactSlow" }) then
			ApplyForce({ Id = enemy.ObjectId, Speed = aiData.MoveStartSelfVelocity, Angle = GetAngle({ Id = enemy.ObjectId }) + (aiData.MoveStartSelfVelocityAngleOffset or 0), SelfApplied = true })
		end
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
	if aiData.MoveLowPass then
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 0.0, Duration = 1.0 })
	end

	if aiData.ApplyEffectsOnMove ~= nil and not aiData.SkipClearEffectsOnMoveEnd then
		for k, effectData in pairs(aiData.ApplyEffectsOnMove) do
			ClearEffect({ Id = enemy.ObjectId, Name = effectData.EffectName })
		end
	end
	if aiData.EndMoveDumbFireWeapons and aiData.MoveDumbFireWeapons ~= nil then
		killWaitUntilThreads(enemy.DumbFireThreadName)
		killTaggedThreads(enemy.DumbFireThreadName)
	end
	if aiData.SetStopGraphicOnMove ~= nil then
		SetUnitProperty({ Property = "StopGraphic", Value = defaultStopGraphic, DestinationId = enemy.ObjectId })
	end

	enemy.Rushing = false
	return didTimeout
end

function Retreat( enemy, aiData, retreatFromId, args )

	args = args or {}
	if aiData.DontRetreatIfCharmed and IsCharmed({ Id = enemy.ObjectId }) then
		return
	end

	if aiData.RetreatGameStateRequirements ~= nil and not IsGameStateEligible( enemy, aiData.RetreatGameStateRequirements) then
		return
	end

	local distanceBetween = GetDistance({ Id = enemy.ObjectId, DestinationId = retreatFromId })
	local retreatDistance = aiData.RetreatBufferDistance - distanceBetween
	local angleBetween = GetAngleBetween({ Id = retreatFromId, DestinationId = enemy.ObjectId})
	local retreatAngle = angleBetween + RandomFloat(-0.5, 0.5)
	local retreatOffset = CalcOffset( math.rad(retreatAngle), retreatDistance)

	local retreatProximity = aiData.RetreatProximity or 100 -- Not important to stop at the retreat point precisely
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
		if moveToId ~= nil and aiData.RetreatOccupySpawnPoint then
			if enemy.OccupyingSpawnPointId ~= nil then
				UnoccupySpawnPoint(enemy.OccupyingSpawnPointId)
			end
			enemy.OccupyingSpawnPointId = moveToId
			SessionMapState.SpawnPointsUsed[moveToId] = enemy.ObjectId
		end
	end

	-- Dash
	if aiData.DashIfOverDistance ~= nil then
		local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = moveToId })
		if distanceToTarget > aiData.DashIfOverDistance then
			AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = moveToId })
			enemy.AINotifyName = "WaitForRotation"..enemy.ObjectId
			NotifyOnRotationComplete({ Id = enemy.ObjectId, Cosmetic = true, Notify = enemy.AINotifyName, Timeout = 2.0 })
			waitUntil( enemy.AINotifyName )

			enemy.WeaponName = aiData.DashWeapon or GetRandomValue(aiData.DashWeapons)
			local dashWeaponAIData = GetWeaponAIData(enemy)
			dashWeaponAIData.TargetId = aiData.TargetId

			DoAttack( enemy, dashWeaponAIData )
			enemy.WeaponName = aiData.WeaponName
		end
	end


	Move({ Id = enemy.ObjectId, DestinationId = moveToId, SuccessDistance = retreatProximity, Strafe = args.Strafe })

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

	if not aiData.SkipRetreatEndStop then
		Stop({ Id = enemy.ObjectId })
	end

	if aiData.RetreatSetAngle then
		SetGoalAngle({ Id = enemy.ObjectId, Angle = aiData.RetreatSetAngle })
	end

	if tempTarget ~= nil then
		Destroy({ Id = tempTarget })
	end

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

	if aiData.MinionWeapon and enemy.UnitGroupData ~= nil and enemy.UnitGroupData.UnitIds ~= nil then
		if aiData.MinionCatchUpBuffer ~= nil then
			wait( CalcEnemyWait( enemy, aiData.MinionCatchUpBuffer ), enemy.AIThreadName )
		end
		thread(HandleMinionWeapons, enemy, aiData)
	end

	aiData.TargetId = aiData.TargetId or GetTargetId(enemy, aiData) or CurrentRun.Hero.ObjectId
	aiData.LastTargetId = aiData.TargetId

	if aiData.WaitDurationForComboPartnerMove ~= nil then
		if ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead then
			aiData.ForcedEarlyExit = true
			return false
		end

		enemy.WaitingForPartner = true
		Stop({ Id = enemy.ObjectId })
		if aiData.WaitForComboPartnerMoveAnimation ~= nil then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.WaitForComboPartnerMoveAnimation })
		end
		wait( aiData.WaitDurationForComboPartnerMove, aiData.AIThreadName or enemy.AIThreadName )
		enemy.WaitingForPartner = false

		if ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead then
			aiData.ForcedEarlyExit = true
			return false
		end
	end

	-- PRE ATTACK
	if aiData.PreAttackSetInvulnerable then
		SetUnitInvulnerable( enemy, nil, aiData.PreAttackSetInvulnerableArgs )
	end

	if aiData.PreAttackStop then
		Stop({ Id = enemy.ObjectId })
	end
	if aiData.PreAttackStartWait ~= nil then
		AIWait(aiData.PreAttackStartWait, enemy, aiData.AIThreadName or enemy.AIThreadName)
	end
	if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
		return false
	end

	local preAttackDuration = aiData.PreAttackDuration or 0.5
	if aiData.PreAttackDuration == nil and aiData.PreAttackDurationMin ~= nil and aiData.PreAttackDurationMax ~= nil then
		preAttackDuration = RandomFloat(aiData.PreAttackDurationMin, aiData.PreAttackDurationMax)
	end

	local preAttackEndDuration = aiData.PreAttackEndDuration or math.min(0.5, preAttackDuration)
	if aiData.PreAttackEndFullDuration then
		preAttackEndDuration = preAttackDuration
	end
	local preAttackStartDuration = math.max(preAttackDuration - preAttackEndDuration, 0)

	if aiData.TrackKillSteal then
		CurrentRun.Hero.KillStolenFromId = enemy.ObjectId
		CurrentRun.Hero.KillStealVictimId = aiData.TargetId
	end

	if aiData.PreAttackSetMapFlags ~= nil then
		for k, data in pairs(aiData.PreAttackSetMapFlags) do
			local flagData = ShallowCopyTable(data)
			flagData.Id = enemy.ObjectId
			flagData.ThreadName = enemy.AIThreadName
			thread(SetMapFlag, flagData)
		end
	end

	if aiData.PreAttackAngleTowardTarget then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, AngleMin = enemy.AngleMin, AngleMax = enemy.AngleMax })

		if aiData.WaitForAngleTowardTarget then
			enemy.AINotifyName = "WaitForRotation"..enemy.ObjectId
			NotifyOnRotationComplete({ Id = enemy.ObjectId, Cosmetic = true, Notify = enemy.AINotifyName, Timeout = aiData.WaitForAngleTowardTargetTimeOut or 9.0 })
			waitUntil( enemy.AINotifyName )

			if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
				return false
			end
			
			if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt) then
				SetAnimation({ DestinationId = enemy.ObjectId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
				return true
			end
		end
	end

	if aiData.PreAttackSelfVelocity then
		if not aiData.SkipSelfVelocityIfImpactSlow or not HasEffect({ Id = enemy.ObjectId, EffectName = "ImpactSlow" }) then
			ApplyForce({ Id = enemy.ObjectId, Speed = aiData.PreAttackSelfVelocity, Angle = GetAngle({ Id = enemy.ObjectId }) + (aiData.PreAttackSelfVelocityAngleOffset or 0), SelfApplied = true })
		end
	end

	if aiData.PreAttackSelfUpwardVelocity then
		if not aiData.SkipSelfVelocityIfImpactSlow or not HasEffect({ Id = enemy.ObjectId, EffectName = "ImpactSlow" }) then
			ApplyUpwardForce({ Id = enemy.ObjectId, Speed = aiData.PreAttackSelfUpwardVelocity })
		end
	end

	if aiData.PreAttackSetZHeight ~= nil then
		AdjustZLocation({ Id = enemy.ObjectId, Distance = aiData.PreAttackSetZHeight - GetZLocation({ Id = enemy.ObjectId }), Duration = aiData.PreAttackSetZDuration or 0 })
	end

	if aiData.PreAttackSound ~= nil then
		local soundId = PlaySound({ Name = aiData.PreAttackSound, Id = enemy.ObjectId, ManagerCap = aiData.SoundManagerCap or 46 })
		if soundId > 0 then
			table.insert( enemy.StopSoundsOnHitStun, soundId )
		end
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
		SetAlpha({ Id = enemy.ObjectId, Fraction = aiData.PreAttackAlpha, Duration = aiData.PreAttackAlphaDuration or 0 })
	end
	if aiData.PreAttackAnimation then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackAnimation, SpeedMultiplier = aiData.PreAttackAnimationSpeed or 1.0 })
	end
	if aiData.PreAttackFx ~= nil then
		CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFx })
		if enemy.StopAnimationsOnHitStun then
			table.insert(enemy.StopAnimationsOnHitStun, aiData.PreAttackFx)
		end
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
		table.insert(enemy.StopAnimationsOnHitStun, aiData.PreAttackFxAtTarget)
		enemy.FxTargetIdsUsed = enemy.FxTargetIdsUsed or {}
		enemy.FxTargetIdsUsed[aiData.TargetId] = true
	end
	if aiData.PreAttackMultiFxAtTarget ~= nil then
		for k, name in pairs(aiData.PreAttackMultiFxAtTarget) do
			CreateAnimation({ DestinationId = aiData.TargetId, Name = name })
			table.insert(enemy.StopAnimationsOnHitStun, name)
			enemy.FxTargetIdsUsed = enemy.FxTargetIdsUsed or {}
			enemy.FxTargetIdsUsed[aiData.TargetId] = true
		end
	end
	if aiData.StopAnimationsOnHitStun ~= nil then
		for k, name in pairs(aiData.StopAnimationsOnHitStun) do
			table.insert(enemy.StopAnimationsOnHitStun, name)
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
		DoWeaponScreenshake( weaponData, "ChargeScreenshake", { AttackerId = enemy.ObjectId, SourceProjectile = aiData.ProjectileName } )
	end

	enemy.AttackWarningDestinationId = enemy.ObjectId

	if enemy.TetherIds ~= nil then
		for k, tetherId in ipairs( enemy.TetherIds ) do
			if enemy.Tethers[k] ~= nil and enemy.Tethers[k].OwnerPreAttackVelocity ~= nil then
				local angleToTarget = GetAngleBetween({ Id = tetherId, DestinationIds = { enemy.ObjectId, aiData.TargetId } })
				ApplyForce({ Id = tetherId, Speed = enemy.Tethers[k].OwnerPreAttackVelocity, Angle = angleToTarget })
			end
		end
	end

	if aiData.PreAttackSetUnitProperties ~= nil then
		for unitProperty, unitPropertyValue in pairs(aiData.PreAttackSetUnitProperties) do
			if aiData.PostAttackResetUnitProperties then
				aiData.PostAttackSetUnitProperties = aiData.PostAttackSetUnitProperties or {}
				aiData.PostAttackSetUnitProperties[unitProperty] = GetUnitDataValue({ Property = unitProperty, Id = enemy.ObjectId })
			end
			--DebugPrint({ Text="Set "..enemy.Name.." "..unitProperty.." to "..unitPropertyValue })
			SetUnitProperty({ DestinationId = enemy.ObjectId, Value = unitPropertyValue, Property = unitProperty  })
		end
	end

	if aiData.PreAttackSetThingProperties ~= nil then
		for unitProperty, thingPropertyValue in pairs(aiData.PreAttackSetThingProperties) do
			--DebugPrint({ Text="Set "..enemy.Name.." "..unitProperty.." to "..unitPropertyValue })
			SetThingProperty({ DestinationId = enemy.ObjectId, Value = thingPropertyValue, Property = unitProperty  })
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
			thread( DumbFireAttack, enemy, weaponName )
		end
	end

	if aiData.PreAttackRandomDumbFireWeapon ~= nil then
		local weaponName = GetRandomValue(aiData.PreAttackRandomDumbFireWeapon)
		thread( DumbFireAttack, enemy, weaponName )
	end

	if aiData.SetDumbFireThreadWait ~= nil then
		SetThreadWait(enemy.DumbFireThreadName, aiData.SetDumbFireThreadWait)
	end

	if aiData.ExpireProjectilesOnPreAttackStart then
		ExpireProjectiles({ Names = aiData.ExpireProjectilesOnPreAttackStart })
	end

	if aiData.ExpireFusedProjectilesOnPreAttackStart then
		enemy.CancelFusedProjectilesBeforeTime = _worldTime
		SetThreadWait(enemy.AIThreadName.."Fuse", 0.01)
	end

	if aiData.SpawnBurstOnPreAttackStart then
		thread(HandleSpawnerBurst, enemy, aiData)
	end

	if aiData.AIChargeTargetMarker then
		CreateTargetMarker( enemy, aiData )
	end

	if aiData.TrackTargetDuringCharge then
		Track({ Ids = { enemy.ObjectId }, DestinationIds = { aiData.TargetId }, AngleMin = enemy.AngleMin, AngleMax = enemy.AngleMax })
	end

	if aiData.PreAttackRotationDampening ~= nil then
		local dampenEffect = { Id = enemy.ObjectId, DestinationId = enemy.ObjectId, EffectName = enemy.Name .. "PreAttackRotationDampening" }
		dampenEffect.DataProperties = { Duration = 10, RotationMultiplier = aiData.PreAttackRotationDampening, TimeModifierFraction = 1 }
		ApplyEffect(dampenEffect)
		table.insert(enemy.ClearEffectsOnHitStun, dampenEffect.EffectName)
	end

	if aiData.PreAttackAddIncomingDamageModifier then
		AddIncomingDamageModifier( enemy, aiData.PreAttackAddIncomingDamageModifier )
	end

	if aiData.PreAttackRemoveIncomingDamageModifier then
		RemoveIncomingDamageModifier( enemy, aiData.PreAttackRemoveIncomingDamageModifier )
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
		if aiData.EndPreAttackFx then
			EndPreAttackFx(enemy, aiData)
		end
		return true
	end

	if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
		aiData.ForcedEarlyExit = true
		if aiData.EndPreAttackFx then
			EndPreAttackFx(enemy, aiData)
		end
		return true
	end

	-- PRE ATTACK END
	if aiData.PreAttackEndStop then
		Stop({ Id = enemy.ObjectId })
	end
	if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
		return false
	end

	if aiData.PreAttackFlashSound ~= nil then
		PlaySound({ Name = aiData.PreAttackFlashSound, Id = enemy.ObjectId, ManagerCap = aiData.SoundManagerCap })
	end
	if aiData.PreAttackEndShake then
		Shake({ Id = enemy.ObjectId, Speed = 400, Distance = 3, Duration = preAttackEndDuration })
		Flash({ Id = enemy.ObjectId, Speed = 1, MinFraction = 0, MaxFraction = aiData.PreAttackEndFlashFraction or 0.95, Color = aiData.PreAttackEndFlashColor or Color.White, Duration = preAttackEndDuration })
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

	if HeroHasTrait("FocusDamageShaveBoon") then
		for _, data in pairs( GetHeroTraitValues( "OnAttackWindUpAction")) do
			CallFunctionName( data.FunctionName, enemy, data.Args )
		end
	end

	if aiData.PreAttackMoveTowardTarget then
		-- used on Prometheus only right now, can be data-ified
		Move({ Id = enemy.ObjectId, DestinationId = aiData.TargetId,
			SuccessDistance = 50, LookAheadMultiplier = 1.5, TrackAtPathEnd = true,
			LiveOffsetFromId = enemy.ObjectId, LiveOffsetDistance = aiData.PreAttackMoveTowardTargetLiveOffsetDistance, LiveOffsetAngle = aiData.PreAttackMoveTowardTargetLiveOffsetAngle })
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
		EndPreAttackFx(enemy, aiData)
	end

	if aiData.PreAttackRotationDampening ~= nil then
		ClearEffect({ Id = enemy.ObjectId, Name = enemy.Name .. "PreAttackRotationDampening" })
	end

	if aiData.PreAttackLoopingSound ~= nil then
		StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
		enemy.PreAttackLoopingSoundId = nil
	end
	if aiData.PreAttackLoopingEndSound ~= nil then
		PlaySound({ Name = aiData.PreAttackLoopingEndSound, Id = enemy.ObjectId })
	end

	if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
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
		--DebugPrint({ Text=enemy.Name.."'s TargetId is dead! Aborting weapon." })
		aiData.DoNotRepeatOnAttackFail = true
		return false
	end

	if aiData.CancelIfTargetIsDead and aiData.TargetId ~= CurrentRun.Hero.ObjectId and ActiveEnemies[aiData.TargetId] == nil then
		--DebugPrint({ Text=enemy.Name.."'s TargetId is dead! Aborting weapon." })
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
			thread( DumbFireAttack, enemy, weaponName )
		end
	end

	if aiData.DumbFireWeapons ~= nil then
		for k, weaponName in pairs( aiData.DumbFireWeapons ) do
			thread( DumbFireAttack, enemy, weaponName )
		end
	end

	if aiData.AttackVoiceLines ~= nil then
		thread( PlayVoiceLines, aiData.AttackVoiceLines, nil, enemy )
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
		ClearAllEffects( enemy ) 
	end

	if aiData.SetUntargetable then
		SetUntargetable({ Id = enemy.ObjectId })
		ClearEnemySeekStatus( enemy )
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
		UpdateHealthBar( enemy, 0, { Force = true } )
		for activeEffectName, stacks in pairs( enemy.ActiveEffects ) do
			UpdateEffectStacks( enemy, activeEffectName )
		end
	end

	if not aiData.SkipFireWeapon then
		if not AIFireWeapon( enemy, aiData ) then
			return false
		end
	end
	if aiData.SkipFireWeaponSound then
		PlaySound({ Name = aiData.SkipFireWeaponSound, Id = enemy.ObjectId })
	end

	if aiData.AIChargeTargetMarker then
		FinishTargetMarker( enemy )
	end

	if aiData.FireFunctionName ~= nil then
		CallFunctionName( aiData.FireFunctionName, enemy, aiData, CurrentRun, aiData.FireFunctionArgs )
	end
	if aiData.FireThreadedFunctionName ~= nil then
		thread(CallFunctionName, aiData.FireThreadedFunctionName, enemy, aiData, aiData.FireThreadedFunctionArgs )
	end

	if aiData.EndDumbFireWeapons and aiData.DumbFireWeapons ~= nil then
		killWaitUntilThreads(enemy.DumbFireThreadName)
		killTaggedThreads(enemy.DumbFireThreadName)
	end

	if aiData.FireEndKillThreads then
		for k, threadName in pairs(aiData.FireEndKillThreads) do
			killWaitUntilThreads(threadName)
			killTaggedThreads(threadName)
		end
	end

	if aiData.PostAttackDumbFireWeapons ~= nil then
		for k, weaponName in pairs( aiData.PostAttackDumbFireWeapons ) do
			thread( DumbFireAttack, enemy, weaponName )
		end
	end

	if aiData.UnequipWeaponAfterUse then
		RemoveValueAndCollapse( enemy.WeaponOptions, enemy.WeaponName )
	end

	if aiData.StopAnimationAfterUse and aiData.StopAnimationAfterUse ~= nil then
		StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.StopAnimationAfterUse })
	end

	if aiData.RetreatLeapAfterUse then
		enemy.NeedsRetreatLeap = true
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

	if aiData.PostAttackAddIncomingDamageModifier then
		AddIncomingDamageModifier( enemy, aiData.PostAttackAddIncomingDamageModifier )
	end

	if aiData.PostAttackRemoveIncomingDamageModifier then
		RemoveIncomingDamageModifier( enemy, aiData.PostAttackRemoveIncomingDamageModifier )
	end

	if aiData.PostAttackFunctionName ~= nil then
		CallFunctionName( aiData.PostAttackFunctionName, enemy, aiData, CurrentRun)
	end
	if aiData.PostAttackThreadedFunctionName ~= nil then
		thread(CallFunctionName, aiData.PostAttackThreadedFunctionName, enemy, aiData, CurrentRun, aiData.PostAttackThreadedFunctionArgs )
	end

	if aiData.PostAttackTeleport then
		HandleEnemyTeleportation(enemy, aiData)
	end

	if aiData.PostAttackAlpha ~= nil then
		SetAlpha({ Id = enemy.ObjectId, Fraction = aiData.PostAttackAlpha, Duration = aiData.PostAttackAlphaDuration or 0 })
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

	if aiData.PostAttackSetUnitProperties ~= nil then
		for unitProperty, unitPropertyValue in pairs(aiData.PostAttackSetUnitProperties) do
			--DebugPrint({ Text="Set "..enemy.Name.." "..unitProperty.." to "..unitPropertyValue })
			SetUnitProperty({ DestinationId = enemy.ObjectId, Value = unitPropertyValue, Property = unitProperty  })
		end
	end

	if aiData.PostAttackSetThingProperties ~= nil then
		for unitProperty, thingPropertyValue in pairs(aiData.PostAttackSetThingProperties) do
			--DebugPrint({ Text="Set "..enemy.Name.." "..unitProperty.." to "..unitPropertyValue })
			SetThingProperty({ DestinationId = enemy.ObjectId, Value = thingPropertyValue, Property = unitProperty  })
		end
	end

	if aiData.PostAttackSetZHeight ~= nil then
		AdjustZLocation({ Id = enemy.ObjectId, Distance = aiData.PostAttackSetZHeight - GetZLocation({ Id = enemy.ObjectId }), Duration = aiData.PostAttackSetZDuration or 0 })
	end

	if aiData.PostAttackSound ~= nil then
		PlaySound({ Name = aiData.PostAttackSound, Id = enemy.ObjectId })
	end

	if aiData.PostAttackSelfVelocity then
		if not aiData.SkipSelfVelocityIfImpactSlow or not HasEffect({ Id = enemy.ObjectId, EffectName = "ImpactSlow" }) then
			ApplyForce({ Id = enemy.ObjectId, Speed = aiData.PostAttackSelfVelocity, Angle = GetAngle({ Id = enemy.ObjectId }) + (aiData.PostAttackSelfVelocityAngleOffset or 0), SelfApplied = true })
		end
	end

	if aiData.PostAttackSelfUpwardVelocity then
		if not aiData.SkipSelfVelocityIfImpactSlow or not HasEffect({ Id = enemy.ObjectId, EffectName = "ImpactSlow" }) then
			ApplyUpwardForce({ Id = enemy.ObjectId, Speed = aiData.PostAttackSelfUpwardVelocity })
		end
	end

	if aiData.UnequipWeaponAfterUse then
		RemoveValueAndCollapse( enemy.WeaponOptions, aiData.WeaponName )
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

	if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt) then
		if not WeaponData[enemy.WeaponName].SkipInterruptIdle then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
		end
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

	if aiData.PostAttackEndFunctionName ~= nil then
		CallFunctionName( aiData.PostAttackEndFunctionName, enemy, aiData, CurrentRun)
	end

	if aiData.PostAttackKillSelf then
		Kill(enemy, aiData.PostAttackKillSelfArgs)
		return true
	end

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
	enemy.IsAggroed = false
	MapState.AggroedUnits[enemy.ObjectId] = nil

	if enemy.WakeUpDelay ~= nil or (enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil) then
		local wakeUpDelay = enemy.WakeUpDelay or RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
		wait( CalcEnemyWait( enemy, wakeUpDelay, { IgnoreSpeedMultiplier = true } ), enemy.AIThreadName )
	end

	if enemy.StartAggroed then
		AggroUnit( enemy )
		return
	end

	-- Return to aggro tether
	if enemy.AggroTetherId ~= nil and IsAlive({ Id = enemy.AggroTetherId }) then
		Move({ Id = enemy.ObjectId, DestinationId = enemy.AggroTetherId, SuccessDistance = 75 })
		enemy.AINotifyName = "ReturnToTether"..enemy.ObjectId

		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = enemy.AggroTetherId, Distance = 100, Notify = enemy.AINotifyName})
		waitUntil( enemy.AINotifyName )
	end

	local originalPositionId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, Group = "Standing" })

	if not CurrentRun.CurrentRoom.BlockAggro and GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) <= enemy.AIAggroRange then
		AggroUnit( enemy )
		return
	end

	local randomNewTargetId = nil
	while IsAIActive( enemy ) and not enemy.IsAggroed do
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
			local offsetX = RandomFloat(-enemy.AIWanderDistance, enemy.AIWanderDistance)
			local offsetY = RandomFloat(-enemy.AIWanderDistance, enemy.AIWanderDistance)
			if randomNewTargetId == nil then
				randomNewTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = originalPositionId, OffsetX = offsetX, OffsetY = offsetY, Group = "Standing" })
			else
				Teleport({ Id = randomNewTargetId, UseCurrentLocation = true, OffsetX = offsetX, OffsetY = offsetY })
			end
			Move({ Id = enemy.ObjectId, DestinationId = randomNewTargetId, SuccessDistance = 50 })
		end

		if enemy.TrackPlayerBeforeAggro then
			Track({ Ids = { enemy.ObjectId }, DestinationIds = { CurrentRun.Hero.ObjectId } })
		end

		local aggroOriginId = enemy.ObjectId

		if enemy.AggroTetherId ~= nil and IsAlive({ Id = enemy.AggroTetherId }) then
			aggroOriginId = enemy.AggroTetherId
		end

		-- Within aggro range
		if not enemy.IsAggroed and not CurrentRun.CurrentRoom.BlockAggro  then
			enemy.AINotifyName = "WithinAggroRange"..enemy.ObjectId
			NotifyWithinDistance({ Id = aggroOriginId, DestinationId = CurrentRun.Hero.ObjectId, Distance = enemy.AIAggroRange, Notify = enemy.AINotifyName, Timeout = enemy.AIWanderFrequency or 1.5})
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

		if enemy.AggroWhenReady then
			AggroUnit( enemy )
		end

		local waitDuration = enemy.AggroAIRefreshDuration or 0.5
		if enemy.AggroAIRefreshDurationMin ~= nil and enemy.AggroAIRefreshDurationMax ~= nil then
			waitDuration = RandomFloat(enemy.AggroAIRefreshDurationMin, enemy.AggroAIRefreshDurationMax)
		end
		AIWait(waitDuration, enemy, enemy.AIThreadName)
	end
	if randomNewTargetId ~= nil then
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
	local battleFoeId = aiData.AmbientBattleTargetId

	if aiData.AmbientBattlePickClosestTargetIds ~= nil then
		battleFoeId = GetClosest({ Id = enemy.ObjectId, DestinationIds = aiData.AmbientBattlePickClosestTargetIds })
	end

	if battleFoeId == nil then
		local availableFoeIds = GetIds({ Names = aiData.AmbientBattleTargetGroups })
		battleFoeId = GetClosest({ Id = enemy.ObjectId, DestinationIds = availableFoeIds })
	end

	if battleFoeId == nil or battleFoeId == 0 then
		if not enemy.IsAggroed then
			return SetAI("AggroAI", enemy)
		else
			return
		end
	else
		RemoveValue(availableFoeIds, battleFoeId)
		enemy.AIAggroRange = enemy.AmbientBattleAggroRange or 800
		enemy.AggroReactionTime = enemy.AmbientBattleAggroReactionTime
	end

	if aiData.TeleportToBattleFoeChance ~= nil and RandomChance(aiData.TeleportToBattleFoeChance) then
		local teleportId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = battleFoeId, OffsetX = RandomFloat(-75, 75), OffsetY = RandomFloat(-75, 75) })
		if not IsLocationBlocked({ Id = teleportId }) then
			Teleport({ Id = enemy.ObjectId, DestinationId = teleportId })
		end
		Destroy({ Id = teleportId })
	end
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = battleFoeId })

	while IsAIActive( enemy ) and not enemy.IsAggroed do

		if enemy.AggroWhenReady then
			enemy.InAmbientBattle = false
			return AggroUnit( enemy )
		end

		if ActiveEnemies[battleFoeId] == nil and not IsAlive({ Id = battleFoeId }) then
			local availableFoeIds = GetIds({ Names = aiData.AmbientBattleTargetGroups })
			battleFoeId = GetRandomValue(availableFoeIds)

			if battleFoeId == nil then
				if not enemy.IsAggroed then
					SetAnimation({ DestinationId = enemy.ObjectId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
					return SetAI("AggroAI", enemy)
				end
			end
		end

		enemy.InAmbientBattle = true

		enemy.WeaponName = SelectWeapon(enemy)
		table.insert(enemy.WeaponHistory, enemy.WeaponName)
		aiData = GetWeaponAIData(enemy)
		aiData.TargetId = battleFoeId

		DoAttackerAILoop(enemy, aiData)

		if not CurrentRun.CurrentRoom.BlockAggro and GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) <= enemy.AIAggroRange then
			enemy.InAmbientBattle = false
			return AggroUnit( enemy )
		end

		enemy.InAmbientBattle = false
	end
	enemy.InAmbientBattle = false
end

function AggroUnit( enemy, hostileAggro )

	if enemy.IsAggroed or not enemy.CanBeAggroed then
		return false
	end

	if CurrentRun.CurrentRoom.BlockAggro then
		return false
	end

	if enemy.InAmbientBattle then
		enemy.AggroWhenReady = true
		enemy.ForcedWeaponInterrupt = true
		SetThreadWait(enemy.AIThreadName, 0.01)
		notifyExistingWaiters(enemy.AINotifyName)
		return
	end

	enemy.IsAggroed = true
	enemy.AggroWhenReady = false

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
	
	for otherEnemyId, otherEnemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
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
	if aiData.AttackFailWeapon ~= nil and not CanAttack({ Id = enemy.ObjectId }) and not enemy.IsPolymorphed and (aiData.AttackFailWeaponRequirements == nil or IsEnemyWeaponEligible(enemy, WeaponData[aiData.AttackFailWeapon], aiData.AttackFailWeaponRequirements)) then
		--DebugAssert({ Condition = aiData.AttackFailWeapon ~= enemy.WeaponName, Text = "Using "..tostring(aiData.WeaponName).." as AttackFailWeapon on itself. This will infinite loop.", Owner = "Eduardo" })
		enemy.WeaponName = aiData.AttackFailWeapon
		local newAIData = GetWeaponAIData(enemy)
		DoAttackerAILoop(enemy, newAIData)
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
			if aiData.MaxAttackers == nil or TableLength( SurroundEnemiesAttacking[surroundKey] ) < aiData.MaxAttackers or IsCharmed({ Id = enemy.ObjectId }) then
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

		if enemy.ForcedWeaponInterrupt ~= nil then
			break
		end

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

	local location = GetLocation({ Id = projectileOwnerId })
	local offset = CalcOffset(math.rad(orbitAngle), orbitDistance)
	local offsetPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = projectileOwnerId, OffsetX = offset.X, OffsetY = offset.Y * 0.48 })
	Teleport({ Id = destinationId, DestinationId = offsetPoint })
	local notifyName = "OnStopped"..destinationId

	while timeRemaining > 0 and IsAlive({ Id = destinationId }) do
		local tickDuration = math.min(speed, timeRemaining)
		orbitAngle = (orbitAngle + 10) % 360
		offset = CalcOffset(math.rad(orbitAngle), orbitDistance)
		local destinationLocation = GetLocation({ Id = destinationId })
		Move({ Id = destinationId, OffsetX = offset.X + location.X - destinationLocation.X, OffsetY = offset.Y * 0.48 + location.Y - destinationLocation.Y, Duration = tickDuration, ShiftThingsByOffset = true })
		NotifyOnStopped({ Id = destinationId, Notify = notifyName, Timeout = tickDuration })
		waitUntil( notifyName )

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
			if enemy.DoSurroundAIRetaliate or ( aiData.MaxAttackers == nil or TableLength( SurroundEnemiesAttacking[surroundAIKey] ) < aiData.MaxAttackers ) or IsCharmed({ Id = enemy.ObjectId }) then
				
				DoAttackerAILoop( enemy, aiData )
				while enemy.ChainedWeapon ~= nil do
					DoAttackerAILoop( enemy )
				end
				SurroundEnemiesAttacking[surroundAIKey][enemy.ObjectId] = nil

				enemy.LastMoveToId = nil
				enemy.DoSurroundAIRetaliate = false
			else

				if aiData.PreMoveTeleport then
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

		if weaponAIData.PreMoveTeleport then
			HandleEnemyTeleportation(enemy, weaponAIData )
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
					thread("AggroAI", enemy, currentRun)
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
					SetAI("AggroAI", enemy, CurrentRun)
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
	if not enemy.IgnoreCastSlow and enemy.ActiveEffects.ImpactSlow ~= nil and enemy.ActiveEffects.ImpactSlow > 0 then
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

	if leapTargetId == nil or not IsAlive({ Id = leapTargetId }) then
		--DebugPrint({ Text = "No valid leap target found! Aborting leap." })
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
	SetThingProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToForce", Value = true })

	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = lockedTargetId })

	if aiData.LeapChargeAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.LeapChargeAnimation })
	end
	if aiData.LeapChargeSound ~= nil then
		PlaySound({ Name = aiData.LeapChargeSound, Id = enemy.ObjectId })
	end
	wait( CalcEnemyWait( enemy, aiData.LeapPrepareTime ), enemy.AIThreadName )
	if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
		return false
	end
	enemy.ImmuneToPolymorph = true
	Stop({ Id = enemy.ObjectId })
	if aiData.AngleTowardTargetDuringLeap then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = lockedTargetId })
	end
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


	SetThingProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToForce", Value = immuneToForceReset })
	enemy.ImmuneToPolymorph = false

	if aiData.LeapAgainIfBlocked and IsLocationBlocked({ Id = enemy.ObjectId, CheckUnits = false }) then
		Leap( enemy, aiData, leapType )
	else
		wait( CalcEnemyWait( enemy, aiData.LeapRecoveryTime), enemy.AIThreadName )
	end
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
			if aiData.PreMoveTeleport then
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
			
			if HeroHasTrait("FocusDamageShaveBoon") then
				for _, data in pairs( GetHeroTraitValues( "OnAttackWindUpAction")) do
					CallFunctionName( data.FunctionName, enemy, data.Args )
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
				SetAlpha({ Id = enemy.ObjectId, Fraction = aiData.FireAlpha, Duration = aiData.FireAlphaDuration or 0 })
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
		dampenEffect.DataProperties = { Duration = 99, RotationMultiplier = aiData.FireRotationDampening, TimeModifierFraction = 1 }
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
		SetAlpha({ Id = enemy.ObjectId, Fraction = aiData.FireAlpha, Duration = aiData.FireAlphaDuration or 0 })
	end

	local weaponData = WeaponData[aiData.WeaponName]
	if weaponData ~= nil and weaponData.Sounds ~= nil and weaponData.Sounds.WeaponFireSounds ~= nil then
		DoWeaponSounds( weaponData.Sounds.WeaponFireSounds, enemy, weaponData )
	end

	local fireTicks = aiData.FireTicks
	if aiData.FireTicksMin ~= nil and aiData.FireTicksMax ~= nil then
		fireTicks = RandomInt( aiData.FireTicksMin, aiData.FireTicksMax )
	end

	if aiData.SpawnCountDampenTraits ~= nil and aiData.SpawnCountDampenFireTicks then
		for traitName in pairs(aiData.SpawnCountDampenTraits) do
			if HeroHasTrait(traitName) then
				local traitData = GetHeroTrait( traitName )
				if traitData and traitData.DebuffValue then
					fireTicks = math.floor(fireTicks * traitData.DebuffValue) 
				end
			end
		end
	end

	local fireInterval = aiData.FireInterval
	if aiData.FireIntervalMin ~= nil and aiData.FireIntervalMax ~= nil then
		fireInterval = RandomFloat( aiData.FireIntervalMin, aiData.FireIntervalMax )
	end
	
	if HasEffect({Id = enemy.ObjectId, EffectName = "ZeusAttackPenalty" }) then
		thread(FireWeaponWithinRange, { TargetId = enemy.ObjectId, WeaponName = "ZeusAttackBolt", InitialDelay = 0, Delay = 0.25, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
		if not HeroHasTrait("JoltDurationTrait") then
			ClearEffect({ Id = enemy.ObjectId, Name = "ZeusAttackPenalty" })
		end
	end

	if aiData.FireAtAllTargetsWithinRange ~= nil then
		local targetIds = GetClosestIds({ Id = enemy.ObjectId, DestinationIds = GetIdsByType({ Name = aiData.TargetTypeNames }), DestinationNames = aiData.TargetGroups, Distance = aiData.FireAtAllTargetsWithinRange })
		for k, targetId in pairs(targetIds) do
			if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
				aiData.ForcedEarlyExit = true
				return true
			end

			if not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId }) then
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

			if aiData.MinTicksBeforeEarlyCancel and fireTick >= aiData.MinTicksBeforeEarlyCancel then
				if RandomChance(aiData.CancelOnNoLosBetweenTicksChance) then
					local hasLoS = HasLineOfSight({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, StopsProjectiles = true })
					if not hasLoS then
						if aiData.ForceWeaponOnLoSCancel ~= nil then
							enemy.ForcedNextWeapon = aiData.ForceWeaponOnLoSCancel
						end
						if aiData.CancelChainedWeaponOnLoSCancel then
							enemy.ChainedWeapon = nil
						end
						return true
					end
				end
			end

			if aiData.ResetTargetPerTick then
				if enemy.CreatedOwnTarget ~= nil then
					Destroy({ Id = enemy.CreatedOwnTarget })
					enemy.CreatedOwnTarget = nil
				end

				aiData.TargetIdsUsed = aiData.TargetIdsUsed or {}
				table.insert(aiData.TargetIdsUsed, aiData.TargetId)
				
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

	if aiData.EndSpawnerThreadOnFireEnd and aiData.SpawnBurstOnFire ~= nil then
		killWaitUntilThreads(enemy.SpawnerThreadName)
		killTaggedThreads(enemy.SpawnerThreadName)
	end

	if aiData.RemoveUnitCollisionDuringAttack or aiData.AddUnitCollisionDuringAttack then
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = defaultCollideWithUnits })
	end
	if aiData.AddProjectileCollisionDuringAttack or aiData.RemoveProjectileCollisionDuringAttack then
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = defaultStopsProjectiles })
	end

	if enemy.WeaponFireLoopingSoundId ~= nil then
		StopSound({ Id = enemy.WeaponFireLoopingSoundId, Duration = 0.4 })
		enemy.WeaponFireLoopingSoundId = nil
	end
	if aiData.FireFx ~= nil then
		StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.FireFx })
	end

	if aiData.FireRotationDampening ~= nil then
		ClearEffect({ Id = enemy.ObjectId, Name = enemy.Name .. "FireRotationDampening" })
	end

	if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
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
	if enemy.ReloadSoundId ~= nil then
		StopSound({ Id = enemy.ReloadSoundId, Duration = 0.2 })
	end

	return true

end

function DoWeaponFire( enemy, aiData )
	if aiData.AIChargeTargetMarker then
		FinishTargetMarker( enemy )
	end

	if aiData.PreFireFunctionName then
		CallFunctionName( aiData.PreFireFunctionName, enemy, aiData, CurrentRun )
	end

	if aiData.PreFireAnimation then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreFireAnimation })
	end

	if aiData.PreFireFx ~= nil then
		local preAttackFx = CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreFireFx })
		table.insert(enemy.StopAnimationsOnHitStun, aiData.PreFireFx)
	end

	if aiData.ChargeSelfVelocity then
		if not aiData.SkipSelfVelocityIfImpactSlow or not HasEffect({ Id = enemy.ObjectId, EffectName = "ImpactSlow" }) then
			ApplyForce({ Id = enemy.ObjectId, Speed = aiData.ChargeSelfVelocity, Angle = GetAngle({ Id = enemy.ObjectId }) + (aiData.ChargeSelfVelocityAngleOffset or 0), SelfApplied = true })
		end
	end

	if aiData.ChargeSelfUpwardVelocity then
		if not aiData.SkipSelfVelocityIfImpactSlow or not HasEffect({ Id = enemy.ObjectId, EffectName = "ImpactSlow" }) then
			ApplyUpwardForce({ Id = enemy.ObjectId, Speed = aiData.ChargeSelfUpwardVelocity })
		end
	end

	if aiData.FireSetZHeight ~= nil then
		AdjustZLocation({ Id = enemy.ObjectId, Distance = aiData.FireSetZHeight - GetZLocation({ Id = enemy.ObjectId }), Duration = aiData.FireSetZDuration or 0 })
	end

	if aiData.FireSetGoalAngleOffset then
		SetGoalAngle({ Id = enemy.ObjectId, Angle = GetAngle({ Id = enemy.ObjectId }) + aiData.FireSetGoalAngleOffset })
	end

	if aiData.PreFireTeleport ~= nil then
		HandleEnemyTeleportation( enemy, aiData )
	end

	if aiData.PreFireDuration then
		AIWait(aiData.PreFireDuration, enemy, aiData.AIThreadName or enemy.AIThreadName, { MinWaitTime = aiData.PreFireMinWaitTime })
	end
	
	local weaponData = WeaponData[aiData.WeaponName]
	if weaponData ~= nil then
		if weaponData.FireCameraMotion ~= nil then
			thread( DoCameraMotion, weaponData.FireCameraMotion )
		end
		local weaponDistanceSquared = nil
		if weaponData.FireScreenshake and weaponData.FireScreenshake.DistanceThreshold then
			weaponDistanceSquared = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })^2
		end
		DoWeaponScreenshake( weaponData, "FireScreenshake", { AttackerId = enemy.ObjectId, SourceProjectile = aiData.ProjectileName, DistanceSquared = weaponDistanceSquared })
		if weaponData.FireSimSlowParameters ~= nil then
			thread( DoWeaponFireSimulationSlow, weaponData )
		end
		local projectileData = ProjectileData[aiData.ProjectileName]
		if projectileData ~= nil and projectileData.FireRumbleParameters ~= nil then
			thread( DoRumble, projectileData.FireRumbleParameters )
		elseif weaponData.FireRumbleParameters ~= nil then
			thread( DoRumble, weaponData.FireRumbleParameters )
		end
		if weaponData.FireRadialBlur ~= nil then
			thread( DoWeaponFireRadialBlur, weaponData )
		end
	else
		--DebugAssert({ Condition = false, Text = "No such WeaponData "..tostring(aiData.WeaponName), Owner = "Eduardo" })
	end

	if aiData.AngleTowardsTargetWhileFiring then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, AngleMin = enemy.AngleMin, AngleMax = enemy.AngleMax })
	end

	if aiData.TrackTargetDuringFire then
		Track({ Ids = { enemy.ObjectId }, DestinationIds = { aiData.TargetId }, AngleMin = enemy.AngleMin, AngleMax = enemy.AngleMax, AngleOffset = aiData.TrackTargetAngleOffset })
	end

	if aiData.RetreatWhileFiring then
		thread( Retreat, enemy, aiData, aiData.TargetId, { Strafe = true } )
	end

	if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
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

	if aiData.SpawnObstacleOnFire ~= nil or aiData.SpawnObstaclesOnFire ~= nil then
		local obstaclesToSpawn = aiData.SpawnObstaclesOnFire or { aiData.SpawnObstacleOnFire }
		for k, obstacleName in pairs(obstaclesToSpawn) do
			local obstacleId = SpawnObstacle({ Name = obstacleName, DestinationId = enemy.ObjectId, Group = "Standing" })
			if aiData.SpawnedObstaclesSyncFlip and IsHorizontallyFlipped({ Id = enemy.ObjectId }) then
				FlipHorizontal({ Id = obstacleId })
			end
		end
	end

	if aiData.ExpireProjectilesOnFire then
		ExpireProjectiles({ Names = aiData.ExpireProjectilesOnFire })
	end

	if aiData.ExpireFusedProjectilesOnFire then
		enemy.CancelFusedProjectilesBeforeTime = _worldTime
		SetThreadWait(enemy.AIThreadName.."Fuse", 0.01)
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

	if weaponData ~= nil and weaponData.Sounds ~= nil and weaponData.Sounds.WeaponFireTickSounds ~= nil then
		DoWeaponSounds( weaponData.Sounds.WeaponFireTickSounds, enemy, weaponData )
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


	if aiData.DestroyTargetAfterFire then
		Destroy({ Id = aiData.TargetId })
	end

	if aiData.FireSelfVelocity then
		if aiData.FireSelfVelocityIfOverDistance == nil or GetDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId }) > aiData.FireSelfVelocityIfOverDistance then
			if not aiData.SkipSelfVelocityIfImpactSlow or not HasEffect({ Id = enemy.ObjectId, EffectName = "ImpactSlow" }) then
				ApplyForce({ Id = enemy.ObjectId, Speed = aiData.FireSelfVelocity, Angle = GetAngle({ Id = enemy.ObjectId }) + (aiData.FireSelfVelocityAngleOffset or 0), SelfApplied = true })
			end
		end
	end

	if aiData.FireSelfUpwardVelocity then
		if not aiData.SkipSelfVelocityIfImpactSlow or not HasEffect({ Id = enemy.ObjectId, EffectName = "ImpactSlow" }) then
			ApplyUpwardForce({ Id = enemy.ObjectId, Speed = aiData.FireSelfUpwardVelocity })
		end
	end

	if aiData.DamageSelfOnWeaponFire ~= nil then
		Damage(enemy, { DamageAmount = aiData.DamageSelfOnWeaponFire, Silent = true, PureDamage = true })
	end
end

function ProcessFireProjecile(enemy, aiData)

	AIWait(aiData.FireProjectileStartDelay, enemy, aiData.AIThreadName or enemy.AIThreadName)

	if (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) or enemy[aiData.EndOnFlagName] or enemy.IsPolymorphed then
		return false
	end

	if aiData.SkipFireProjectileIfInTransition and (ReachedAIStageEnd(enemy) or enemy.InTransition) then
		aiData.ForcedEarlyExit = true
		return
	end
	if aiData.SkipFireProjectileIfInterrupted and (enemy.ForcedWeaponInterrupt ~= nil or enemy.WeaponName ~= aiData.WeaponName) then
		aiData.ForcedEarlyExit = true
		return
	end

	--if aiData.ProjectileName == nil and aiData.NoProjectile == nil then -- Backwards compatibility for xml weapons
		--DebugAssert({ Condition = false, Text = enemy.Name.." trying to fire "..aiData.WeaponName.." with no Projectile.", Owner = "Eduardo" })
	--end

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
			if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
				return
			end
			if aiData.CancelProjectilesOnTransition and (enemy.InTransition or CurrentRun.CurrentRoom.InStageTransition) then
				aiData.ForcedEarlyExit = true
				return true
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
	local angle = projectileData.Angle or aiData.Angle or GetAngle({ Id = enemy.ObjectId })

	if aiData.FireFromTargetIds ~= nil then
		projectileOwnerId = GetRandomValue(aiData.FireFromTargetIds)
	end

	if aiData.FireFromSelf then
		aiData.FireFromId = enemy.ObjectId
	end
	if aiData.FireFromIdTargetId then
		aiData.FireFromId = aiData.TargetId
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
	elseif aiData.FireProjectileTowardSelf then
		distanceToTarget = GetDistance({ Id = aiData.TargetId, DestinationId = enemy.ObjectId })
		angle = GetAngleBetween({ Id = aiData.TargetId, DestinationId = enemy.ObjectId })
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
			SetAnimation({ Name = projectileData.ReticleAnimation, DestinationId = destinationId, ScaleRadius = damageRadius })
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

		if projectileData.AttachToTarget then
			Attach({ Id = destinationId, DestinationId = aiData.TargetId })
		end

		local fuseStartTime = _worldTime
		enemy.AIThreadName = enemy.AIThreadName or "AIThread_"..enemy.Name.."_"..enemy.ObjectId -- If an obstacle tries to fire a projectile it has no AIThread
		if enemy.IgnoreTimeSlowEffects then
			waitUnmodified(projectileData.Fuse, enemy.AIThreadName.."Fuse")
		else
			wait(projectileData.Fuse, enemy.AIThreadName.."Fuse")
		end

		if (enemy.CancelFusedProjectilesBeforeTime ~= nil and fuseStartTime < enemy.CancelFusedProjectilesBeforeTime) or (projectileData.CancelIfOwnerAIStageEnd and (ReachedAIStageEnd(enemy) or enemy.InTransition)) then
			if projectileData.ReticleAnimation ~= nil then
				StopAnimation({ Name = projectileData.ReticleAnimation, DestinationId = destinationId })
			end
			if destroyDestinationId then
				Destroy({ Id = destinationId, ResetPlaySpeedMultipliers = true })
				MapState.Reticles[destinationId] = nil
			end
			return
		end
	end

	CurrentRun.ProjectileRecord[aiData.ProjectileName] = (CurrentRun.ProjectileRecord[aiData.ProjectileName] or 0) + 1
	GameState.ProjectileRecord[aiData.ProjectileName] = (GameState.ProjectileRecord[aiData.ProjectileName] or 0) + 1
	local projectileSpeedMultiplier = nil
	if not enemy.SkipModifiers and not aiData.ImmuneToProjectileSlow and not enemy.AlwaysTraitor then
		projectileSpeedMultiplier = GetTotalHeroTraitValue("EnemyProjectileSpeedMultiplier", {IsMultiplier = true, Multiplicative = true })
	end

	local collideWithGroups = projectileData.CollideWithGroups or enemy.ProjectilesCollideWithGroups
	if enemy.ProjectilesCollideWithGroupsCharmed ~= nil and IsCharmed({ Id = projectileOwnerId }) then
		collideWithGroups = enemy.ProjectilesCollideWithGroupsCharmed
	end

	local projectileId = CreateProjectileFromUnit({ Name = aiData.ProjectileName,
		Id = projectileOwnerId,
		DestinationId = destinationId,
		FireFromTarget = aiData.FireFromTarget,
		FireFromId = aiData.FireFromId,
		SpeedMultiplier = projectileSpeedMultiplier,
		FiredByTraitor = aiData.FireAlliedToPlayer,
		TargetIdOverride = aiData.TargetIdOverride,
		CollideWithGroups = collideWithGroups,
		DataProperties = aiData.ProjectileDataOverrides,
		BarrelLength = aiData.BarrelLength,
		SpawnFromMarker = aiData.SpawnFromMarker,
		ScaleMultiplier = aiData.ProjectileScaleMultiplier or enemy.ProjectileScaleMultiplier,
		BlastRadiusModifier = aiData.ProjectileBlastRadiusMultiplier,
		RequireLoS = aiData.RequireLoS,
		Range = aiData.Range or distanceToTarget or 0,
		MarkerPersistsAngleToTarget = aiData.TargetSpawnPoints,
		Angle = angle, })
		--AdjustZLocation = true, UseStartingZLocation = 900, Duration = 0

	if aiData.SaveProjectileId then
		enemy.ProjectileIds = enemy.ProjectileIds or {}
		table.insert(enemy.ProjectileIds, projectileId)
	end

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

	if projectileData.ExpireOnDelay ~= nil then
		--DebugPrint({ Text="projectileData.ExpireOnDelay" })
		thread(ExpireOnDelay, { projectileId }, projectileData.ExpireOnDelay)
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

		if not aiData.SkipSelfVelocityIfImpactSlow or not HasEffect({ Id = enemy.ObjectId, EffectName = "ImpactSlow" }) then
			ApplyForce({ Id = enemy.ObjectId, Speed = aiData.FireTickSelfVelocity * velocityMultiplier, Angle = GetAngle({ Id = enemy.ObjectId }) + (aiData.FireTickSelfVelocityAngleOffset or 0), SelfApplied = true })
		end
	end

	if destroyDestinationId then
		Destroy({ Id = destinationId, ResetPlaySpeedMultipliers = true })
		MapState.Reticles[destinationId] = nil
	end
end

function ProcessAttackSlots( enemy, aiData )
	local enemyOriginalPosition = GetLocation({ Id = enemy.ObjectId })
	local targetOriginalPosition = GetLocation({ Id = aiData.TargetId })

	local numAttacks = #aiData.AttackSlots
	if aiData.AttackSlotsPerTick ~= nil or (aiData.AttackSlotsPerTickMin ~= nil and aiData.AttackSlotsPerTickMax ~= nil) then
		numAttacks = aiData.AttackSlotsPerTick or RandomInt(aiData.AttackSlotsPerTickMin, aiData.AttackSlotsPerTickMax)
	end

	local attackSlots = DeepCopyTable(aiData.AttackSlots)
	local removeNum = aiData.RemoveAttackSlotCount or TableLength(aiData.AttackSlots) - numAttacks
	local skipIndexes = {}
	for k = 1, removeNum, 1 do
		local randomAttackSlot = RemoveRandomKey( attackSlots )
		skipIndexes[randomAttackSlot] = true
	end

	local randomAngle = nil
	if aiData.UseRandomAngle then
		randomAngle = RandomFloat(0, 360)
	end

	if aiData.RandomizeAttackSlotOrder then
		 FYShuffle(aiData.AttackSlots)
	end
	
	AIWait( aiData.PreAttackSlotsWait, enemy, aiData.AIThreadName or enemy.AIThreadName )

	for k, attackSlot in ipairs( aiData.AttackSlots ) do
		if skipIndexes[k] == nil then
			aiData.Angle = attackSlot.Angle or randomAngle or GetAngle({ Id = enemy.ObjectId })
			if attackSlot.UseAngleBetween then
				aiData.Angle = LuaGetAngleBetween( enemyOriginalPosition.X, enemyOriginalPosition.Y, targetOriginalPosition.X, targetOriginalPosition.Y )
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
			local anchorAngle = 0
			if attackSlot.UseMapObjectId then
				if type(attackSlot.UseMapObjectId) == "table" then
					anchor = GetLocation({ Id = attackSlot.UseMapObjectId[CurrentRun.CurrentRoom.Name] })
					anchorAngle = GetAngle({ Id = attackSlot.UseMapObjectId[CurrentRun.CurrentRoom.Name] })
				else
					anchor = GetLocation({ Id = attackSlot.UseMapObjectId })
					anchorAngle = GetAngle({ Id = attackSlot.UseMapObjectId })
				end
			elseif attackSlot.OffsetFromAttacker then
				anchor = GetLocation({ Id = enemy.ObjectId })
				anchorAngle = GetAngle({ Id = enemy.ObjectId })
			elseif attackSlot.UseTargetPosition then
				anchor = GetLocation({ Id = aiData.TargetId })
				anchorAngle = GetAngle({ Id = aiData.TargetId })
			elseif attackSlot.OffsetFromOriginalAttackerPosition then
				anchor = enemyOriginalPosition
				anchorAngle = GetAngle({ Id = enemy.ObjectId })
			else
				anchorAngle = GetAngle({ Id = aiData.TargetId })
			end

			if attackSlot.AnchorOffset ~= nil then
				local anchorOffset = CalcOffset(math.rad(anchorAngle + attackSlot.AnchorOffsetAngle), attackSlot.AnchorOffset)
				anchor.X = anchor.X + anchorOffset.X
				anchor.Y = anchor.Y + anchorOffset.Y
			end

			local angleOffset = CalcOffset(math.rad(aiData.Angle + anchorAngle), attackSlot.AnchorAngleOffset or 50)
			offset.X = offset.X + angleOffset.X
			offset.Y = offset.Y + angleOffset.Y

			if attackSlot.OffsetScaleY ~= nil then
				offset.Y = offset.Y * attackSlot.OffsetScaleY
			end
			anchor.X = anchor.X or 0
			anchor.Y = anchor.Y or 0
			local targetOffset = SpawnObstacle({ Name = "InvisibleTarget", LocationX = anchor.X + offset.X, LocationY = anchor.Y + offset.Y })

			if attackSlot.InstantTeleportToId then
				Teleport({ Id = enemy.ObjectId, DestinationId = attackSlot.InstantTeleportToId })
			end

			if attackSlot.ProjectileName ~= nil or aiData.ProjectileName ~= nil then
				local projectileAIData = DeepCopyTable(aiData)
				projectileAIData.ProjectileName = attackSlot.ProjectileName or aiData.ProjectileName
				projectileAIData.TargetId = targetOffset
				if attackSlot.AIDataOverrides ~= nil then
					projectileAIData = DeepCopyTable(projectileAIData)
					OverwriteTableKeys(projectileAIData, attackSlot.AIDataOverrides)
				end
				thread( ProcessFireProjecile, enemy, projectileAIData )
			elseif aiData.NoProjectile then
				--
			end

			thread( DestroyOnDelay, { targetOffset }, CalcEnemyWait( enemy, aiData.FireProjectileStartDelay ) + 0.1 )
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

			if aiData.EndAttackSlotsForcedWeaponInterrupt and enemy.ForcedWeaponInterrupt ~= nil then
				return false
			end
			
			if enemy[aiData.EndOnFlagName] then
				return false
			end

			if enemy.IsPolymorphed and aiData.CancelOnPolymorph then
				return
			end
		end
	end
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

function DumbFireAttack( enemy, weaponName )
	enemy.DumbFireThreadName = "DumbFireThreadName"..enemy.ObjectId

	if weaponName == nil then
		--DebugAssert({ Condition = weaponName ~= nil, Text = "DumbFireAttack has no weapon name.", Owner = "Eduardo" })
		return
	end

	local aiData = GetWeaponAIData(enemy, weaponName)

	if aiData.AlwaysUseDumbFireThreadName then
    	aiData.AIThreadName = enemy.DumbFireThreadName
	end

	if aiData.CancelIfNoComboPartner and (enemy.ComboPartnerId == nil or ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead ) then
		return
	end

	if aiData.CancelOutsideDistanceFromComboPartner and GetDistance({ Id = enemy.ObjectId, DestinationId = enemy.ComboPartnerId }) > aiData.CancelOutsideDistanceFromComboPartner then
		return

	end

	local wakeUpDelay = aiData.DumbFireWakeUpDelay
	if aiData.DumbFireWakeUpDelayMin ~= nil and aiData.DumbFireWakeUpDelayMax ~= nil then
		wakeUpDelay = RandomFloat(aiData.DumbFireWakeUpDelayMin, aiData.DumbFireWakeUpDelayMax)
	end
	wait( CalcEnemyWait( enemy, wakeUpDelay ), enemy.AIThreadName )

	local timesFired = 0
	while IsAIActive( enemy ) do
		if enemy.IsPolymorphed and aiData.CancelOnPolymorph then
			return
		end

		aiData.TargetId = GetTargetId(enemy, aiData)

		local preAttackDuration = aiData.PreAttackDuration
		if aiData.PreAttackDurationMin ~= nil and aiData.PreAttackDurationMax ~= nil then
			preAttackDuration = RandomFloat(aiData.PreAttackDurationMin, aiData.PreAttackDurationMax)
		end

		if aiData.PreAttackVoiceLines ~= nil then
			thread( PlayVoiceLines, aiData.PreAttackVoiceLines, nil, enemy )
		end

		if aiData.PreAttackFx ~= nil then
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFx })
			enemy.CreatedAnimations = enemy.CreatedAnimations or {}
			table.insert( enemy.CreatedAnimations, aiData.PreAttackFx )
		end
		
		if aiData.PreAttackThreadedFunctionName ~= nil then
			thread(CallFunctionName, aiData.PreAttackThreadedFunctionName, enemy, aiData, CurrentRun, aiData.PreAttackThreadedFunctionArgs)
		end

		wait( CalcEnemyWait( enemy, preAttackDuration ), enemy.DumbFireThreadName )

		if aiData.EndPreAttackFx then
			EndPreAttackFx(enemy, aiData)
		end

		local fireTicks = aiData.FireTicks or 1
		if aiData.FireTicksMin ~= nil and aiData.FireTicksMax ~= nil then
			fireTicks = RandomInt( aiData.FireTicksMin, aiData.FireTicksMax )
		end

		if aiData.TargetId ~= nil then
			for fireTick = 1, fireTicks, 1 do
				if enemy.IsPolymorphed or (not aiData.SkipCanAttack and not CanAttack({ Id = enemy.ObjectId })) then
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
						thread( DumbFireAttack, enemy, weaponName )
					end
				end

				DoWeaponFire( enemy, aiData )
				local fireInterval = aiData.FireInterval
				if aiData.FireIntervalMin ~= nil and aiData.FireIntervalMax ~= nil then
					fireInterval = RandomFloat( aiData.FireIntervalMin, aiData.FireIntervalMax )
				end
				wait( CalcEnemyWait( enemy, fireInterval), enemy.DumbFireThreadName )


				if enemy.CreatedOwnTarget then
					Destroy({ Id = enemy.CreatedOwnTarget })
					enemy.CreatedOwnTarget = nil
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
			dumbFireInterval = RandomFloat( aiData.DumbFireIntervalMin, aiData.DumbFireIntervalMax )
		end
		wait( CalcEnemyWait( enemy, dumbFireInterval), enemy.DumbFireThreadName )

		if dumbFireInterval == nil then
			break
		end

		if enemy[aiData.EndOnFlagName] then
			break
		end

	end

	if IsAIActive( enemy ) then
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
			DumbFireAttack( enemy, aiData.ChainedWeapon )
		end
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


			if aiData.SpawnOverrides ~= nil then
				OverwriteTableKeys( newEnemy, aiData.SpawnOverrides )
			end

			if aiData.SpawnDefaultAIDataOverrides ~= nil then
				OverwriteTableKeys( newEnemy.DefaultAIData, aiData.SpawnDefaultAIDataOverrides)
			end 

			local offset = { X = aiData.SpawnOffsetX or 0, Y = aiData.SpawnOffsetY or 0 }
			local spawnPointId = aiData.SpawnOnId or RemoveFirstValue(spawnOnIdsOrdered) or RemoveRandomValue(spawnOnIds) or GetRandomValue(GetIds({ Name = aiData.SpawnOnGroupName }))
			
			local spawnNearId = enemy.ObjectId
			if aiData.SpawnNearPlayer then
				spawnNearId = CurrentRun.Hero.ObjectId
			end

			if spawnPointId == nil then
				if aiData.SpawnOnSpawnPoints then
					local newSpawnPoint = SelectSpawnPoint( CurrentRun.CurrentRoom, newEnemy,
						{ ForceDistanceCalculation = true, SpawnNearId = spawnNearId, SpawnRadius = aiData.SpawnRadius, SpawnRadiusMin = aiData.SpawnRadiusMin, RequiredSpawnPoint = aiData.RequiredSpawnPointType, RequireMinPlayerDistance = aiData.RequireMinPlayerDistance, PreferredSpawnPointGroup = aiData.PreferredSpawnPointGroup },
						{ RecursiveWait = 0.03 } )
					spawnPointId = newSpawnPoint
				elseif aiData.SpawnTowardSpawnPoints then
					spawnPointId = spawnNearId
					local closestSpawnPoint = GetClosest({ Id = spawnNearId, DestinationName = "SpawnPoints" })
					local angle = GetAngleBetween({ Id = spawnNearId, DestinationId = closestSpawnPoint })
					offset = CalcOffset( math.rad(angle), math.min(110, GetDistance({ Id = spawnNearId, DestinationId = closestSpawnPoint })) )
				elseif aiData.SpawnRadius ~= nil then
					--offsetX = RandomInt(-aiData.SpawnRadius, aiData.SpawnRadius)
					--offsetY = RandomInt(-aiData.SpawnRadius, aiData.SpawnRadius)
				elseif aiData.SpawnOnRandomId ~= nil then
					spawnPointId = GetRandomValue(aiData.SpawnOnRandomId)
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
			if aiData.SpawnForce then
				thread(DelayedApplyForce, { DelayDuration = 0.16, Id = newEnemy.ObjectId, Speed = aiData.SpawnForce, Angle = GetAngle({ Id = enemy.ObjectId }), SelfApplied = true })
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
			local spawnRate = aiData.SpawnRate or 0.3
			if aiData.SpawnRateMin ~= nil and aiData.SpawnRateMax ~= nil then
				spawnRate = RandomFloat(aiData.SpawnRateMin, aiData.SpawnRateMax)
			end
			wait( CalcEnemyWait( enemy, spawnRate), enemy.SpawnerThreadName )
		else
			break
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
		if aiData.PreMoveTeleport then
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
									Distance = enemy.TriggerDistance, ScaleY = enemy.TriggerDistanceScaleY, Notify = enemy.AINotifyName, Timeout = enemy.ExpirationDuration })

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

function UnitSplit( enemy, aiData )
	local spawnGroupName = "Spawner"..enemy.ObjectId

	if not enemy.IsBoss then
		RemoveEnemyUI( enemy )
		enemy.HasHealthBar = false
	end
	ClearEffect({ Id = enemy.ObjectId, All = true })
	EffectPostClearAll( enemy )

	enemy.SplitIds = {}

	for i=1, aiData.SpawnCount do
		local enemyData = EnemyData[aiData.SpawnedUnit]
		local newEnemy = DeepCopyTable( enemyData )
		newEnemy.SkipChallengeKillCounts = true
		local spawnPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, newEnemy, { SpawnNearId = enemy.ObjectId, SpawnRadius = aiData.SpawnRadius, SpawnRadiusMin = aiData.SpawnRadiusMin, },
																				{ PreferredSpawnPoint = aiData.PreferredSpawnPointType, RequiredSpawnPoint = aiData.RequiredSpawnPointType, SpawnAwayFromTypes = aiData.SpawnAwayFromTypes, SpawnAwayFromTypesDistance = aiData.SpawnAwayFromTypesDistance })
		if spawnPointId ~= nil then
			newEnemy.OccupyingSpawnPointId = spawnPointId
			SessionMapState.SpawnPointsUsed[spawnPointId] = newEnemy.ObjectId
			thread( UnoccupySpawnPointOnDistance, newEnemy, spawnPointId, 400 )

			newEnemy.ObjectId = SpawnUnit({ Name = aiData.SpawnedUnit, Group = "Standing", DestinationId = spawnPointId, ForceToValidLocation = true })
			enemy.SplitIds[newEnemy.ObjectId] = true

			thread(SetupUnit, newEnemy, CurrentRun, { SkipAISetup = aiData.SkipUnitAISetup } )
			AddToGroup({ Id = newEnemy.ObjectId, Name = spawnGroupName })
			newEnemy.SkipActiveCount = true

			AngleTowardTarget({ Id = newEnemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

			if aiData.SyncChainedWeapons then
				newEnemy.ChainedWeapon = enemy.ChainedWeapon
			end

			if newEnemy.EliteIcon or ( newEnemy.HealthBuffer ~= nil and newEnemy.HealthBuffer > 0 ) then
				CreateHealthBar( newEnemy )
				UpdateHealthBar( newEnemy, 0, { Force = true })
				newEnemy.Outline.Id = newEnemy.ObjectId
				AddOutline( newEnemy.Outline )
			end

			if aiData.DefaultGrannyTexture then
				SetThingProperty({ Property = "GrannyModel", Value = "HecateHub_Mesh", DestinationId = newEnemy.ObjectId })
				SetThingProperty({ Property = "GrannyTexture", Value = "", DestinationId = newEnemy.ObjectId })
				SetAnimation({ DestinationId = newEnemy.ObjectId, Name = "HecateHubTorchBattleIdle" })
				newEnemy.AIWakeDelay = 5.0
			end
		end
	end
end

function HecateComboBreakerSplit(enemy, aiData)

	for id, k in pairs(enemy.SplitIds) do
		local clone = ActiveEnemies[id]
		if clone ~= nil then
			clone.ForcedWeaponInterrupt = "HecateTeleport2"
			enemy.ChainedWeapon = nil
			SetThreadWait(clone.AIThreadName, 0.01)
		end
	end
	wait(0.01, enemy.AIThreadName)
	ClearEffect({ Id = enemy.ObjectId, All = true })
	EffectPostClearAll( enemy )
	enemy.ForcedWeaponInterrupt = "HecateTeleport2"
	enemy.ChainedWeapon = GetRandomValue({"HecateRangedTorchesHoming_Short"})
end

function ClearAllEffects( enemy ) 
	ClearEffect({ Id = enemy.ObjectId, All = true })
	EffectPostClearAll( enemy )
	ClearEnemySeekStatus( enemy )
end

function ClearEnemyEffect( enemy, aiData, currentRun, args )
	ClearEffect({ Id = enemy.ObjectId, Name = args.EffectName })
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
	
	if IsGameStateEligible( enemy, requirements ) then		
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
	
	if IsGameStateEligible( requirements ) then		
		thread( DirectionHintPresentation, enemy )
		ArtemisAppearancePresentation( enemy )
	else
		ArtemisFirstAppearancePresentation( enemy )
	end]]
	thread( DirectionHintPresentation, enemy )
	IcarusAppearancePresentation( enemy )

	CheckAvailableTextLines( enemy )
	UseableOn({ Id = enemy.ObjectId })

	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = 400, Notify = enemy.AINotifyName, Timeout = 10.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )
	enemy.PostCombatTravel = false
end

function NemesisPostCombat( enemy )
	enemy.PostCombatTravel = true
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Nemesis_Combat_Idle" })
	local moveToId = SelectLootSpawnPoint(CurrentRun.CurrentRoom) or CurrentRun.Hero.ObjectId
	local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = moveToId })

	Move({ Id = enemy.ObjectId, DestinationId = moveToId, SuccessDistance = 40 })
	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = moveToId, Distance = roomData.NemesisRewardMoveDistance or 100, Notify = enemy.AINotifyName, Timeout = 10.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )

	Stop({ Id = enemy.ObjectId })
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Nemesis_Combat_Unequip" })
end

function HeraclesPostCombat( enemy )
	enemy.PostCombatTravel = true
	AddTimerBlock( CurrentRun, "HeraclesPostCombat" )
	local moveToId = SelectLootSpawnPoint(CurrentRun.CurrentRoom) or CurrentRun.Hero.ObjectId
	local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = moveToId })

	Move({ Id = enemy.ObjectId, DestinationId = moveToId, SuccessDistance = 40 })
	enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = moveToId, Distance = 100, Notify = enemy.AINotifyName, Timeout = 10.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )

	Stop({ Id = enemy.ObjectId })
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	enemy.PostCombatTravel = false
	enemy.TextLinesUseWeaponIdle = nil
	RemoveTimerBlock( CurrentRun, "HeraclesPostCombat" )
	UseableOn({ Id = enemy.ObjectId })
	HeraclesEncounterEndPresentation( enemy )

	AddInteractBlock( enemy, "HeraclesPostCombat" )
	wait(1.3)

	HeraclesObjectiveResultPresentation( enemy )
	if CurrentRun.CurrentRoom.Encounter.PlayerMoneyObjective > 0 then
		local consumableId = SpawnObstacle({ Name = "RoomMoneyDrop", DestinationId = enemy.ObjectId, Group = "Standing" })
		local reward = CreateConsumableItem( consumableId, "RoomMoneyDrop", 0 )
		reward.DropMoney = CurrentRun.CurrentRoom.Encounter.PlayerMoneyObjective
		MapState.RoomRequiredObjects[reward.ObjectId] = reward
		ApplyUpwardForce({ Id = consumableId, Speed = 425 })
		ApplyForce({ Id = consumableId, Speed = 350, Angle = GetAngle({ Id = enemy.ObjectId }), SelfApplied = true })
	end

	CheckAvailableTextLines( enemy )
	SetAvailableUseText( enemy )
	RemoveInteractBlock( enemy, "HeraclesPostCombat" )

	if enemy.NextInteractLines == nil then
		if CanReceiveGift( enemy ) then
			MapState.RoomRequiredObjects[enemy.ObjectId] = nil
			wait( 0.2 )
			if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
				UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
			end
		else
			HeraclesExit( enemy, { WaitTime = 1.5 })
		end
	end	
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
	elseif aiData.TargetPlayer then
		targetId = CurrentRun.Hero.ObjectId
		
	elseif aiData.UseTargetId then
		targetId = aiData.UseTargetId

	elseif aiData.TargetFromGroup ~= nil then
		local eligibleIds = {}

		local targetDistanceId = enemy.ObjectId
		if aiData.TargetDistanceFromPlayer then
			targetDistanceId = CurrentRun.Hero.ObjectId
		end
		if aiData.TargetRange ~= nil then
			eligibleIds = GetClosestIds({ Id = targetDistanceId, DestinationIds = GetIds({ Name = aiData.TargetFromGroup }), Distance = aiData.TargetRange })
		elseif aiData.TargetMinDistance ~= nil then
			for k, id in pairs( GetIds({ Name = aiData.TargetFromGroup })) do
				if not IsWithinDistance({ Id = targetDistanceId, DestinationId = id, Distance = aiData.TargetMinDistance, ScaleY = aiData.TargetMinDistanceScaleY }) then
					table.insert( eligibleIds, id )
				end
			end
		else
			eligibleIds = GetIds({ Name = aiData.TargetFromGroup })
		end

		if aiData.TargetClosest then
			targetId = GetClosest({ Id = enemy.ObjectId, DestinationIds = eligibleIds })
		else
			targetId = GetRandomValue( eligibleIds )
		end

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
		elseif aiData.UseAngleBetweenPlayer then
			offsetAngle = GetAngleBetween({ DestinationId = CurrentRun.Hero.ObjectId, Id = enemy.ObjectId })
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
		if enemy.CreatedOwnTarget ~= nil then
			enemy.TargetIdsLeaked = enemy.TargetIdsLeaked or {}
			enemy.TargetIdsLeaked[enemy.CreatedOwnTarget] = true
		end
		enemy.CreatedOwnTarget = newTargetId

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
				elseif aiData.TargetTypes ~= nil and not Contains(aiData.TargetTypes, requiredKillEnemy.Name) then
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
			targetId = GetClosest({ Id = enemy.ObjectId, DestinationIds = eligibleIds, Distance = aiData.TargetMaxDistance or 1500, IgnoreInvulnerable = true, IgnoreHomingIneligible = true, IgnoreSelf = true })
		
		elseif aiData.TargetClosestToPlayer then
			targetId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = eligibleIds, Distance = aiData.TargetMaxDistance or 1500, IgnoreInvulnerable = true, IgnoreHomingIneligible = true, IgnoreSelf = true })
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
		targetId = GetClosest({ Id = enemy.ObjectId, DestinationIds = GetIdsByType({ Name = aiData.TargetClosestOfType, Names = aiData.TargetClosestOfTypes }), Distance = aiData.TargetMaxDistance or 1500, IgnoreSelf = true })
	elseif aiData.TargetClosestOfTypeToPlayer or aiData.TargetClosestOfTypesToPlayer then
		targetId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetIdsByType({ Name = aiData.TargetClosestOfTypeToPlayer, Names = aiData.TargetClosestOfTypesToPlayer }), Distance = aiData.TargetMaxDistance or 1500, IgnoreSelf = true })
	elseif aiData.TargetSpawnPoints then
		local nearId = CurrentRun.Hero.ObjectId
		if aiData.TargetSpawnPointsNearSelf then
			nearId = enemy.ObjectId
		end
		local ignoreIds = {}
		if aiData.DoNotRepeatSpawnPointIds then
			ignoreIds = aiData.TargetIdsUsed
		end
		targetId = SelectSpawnPoint(CurrentRun.CurrentRoom, { Name = enemy.Name, RequiredSpawnPoint = aiData.TargetSpawnPointsType }, { SpawnNearId = nearId, SpawnRadius = aiData.TargetSpawnPointsRadius or 1000, SpawnRadiusMin = aiData.TargetSpawnPointsRadiusMin }, { IgnoreIds = ignoreIds, RequireLoS = aiData.TargetSpawnPointsRequireLoS, LoSTarget = enemy.ObjectId } )
		if targetId ~= nil and aiData.OccupyTargetSpawnPoint then
			if enemy.OccupyingSpawnPointId ~= nil then
				UnoccupySpawnPoint(enemy.OccupyingSpawnPointId)
			end
			enemy.OccupyingSpawnPointId = targetId
			SessionMapState.SpawnPointsUsed[targetId] = enemy.ObjectId
			if aiData.UnoccupySpawnPointOnDistance then
				thread( UnoccupySpawnPointOnDistance, enemy, targetId, 150 )
			end
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
		if aiData.TargetAngleOffset ~= nil then
			offsetAngle = offsetAngle + aiData.TargetAngleOffset
		elseif aiData.TargetAngleOffsetMin ~= nil and aiData.TargetAngleOffsetMax ~= nil then
			offsetAngle = offsetAngle + RandomFloat(aiData.TargetAngleOffsetMin, aiData.TargetAngleOffsetMax)
		end
		local offsetDistance = aiData.TargetOffsetDistance or 0
		if aiData.TargetOffsetDistanceMin ~= nil and aiData.TargetOffsetDistanceMax ~= nil then
			offsetDistance = RandomFloat(aiData.TargetOffsetDistanceMin, aiData.TargetOffsetDistanceMax)
		end
		local offset = CalcOffset(math.rad(offsetAngle), offsetDistance)
		if aiData.OffsetDistanceScaleY ~= nil then
			offset.Y = offset.Y * aiData.OffsetDistanceScaleY
		end
		targetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = aiData.AnchorTargetId or targetId, Group = "Scripting", OffsetX = aiData.OffsetX or offset.X, OffsetY = aiData.OffsetY or offset.Y })
		if enemy.CreatedOwnTarget ~= nil then
			enemy.TargetIdsLeaked = enemy.TargetIdsLeaked or {}
			enemy.TargetIdsLeaked[enemy.CreatedOwnTarget] = true
		end
		enemy.CreatedOwnTarget = targetId
	end

	if aiData.TargetPlayerIfNoTarget and (targetId == nil or targetId == 0) then
		targetId = CurrentRun.Hero.ObjectId
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

		enemy.InTransition = true

		RandomSynchronize( 3 + k )
		enemy.AIStageActive = k

		if aiStage.EMStageDataOverrides ~= nil then
			local pactLevel = GetNumShrineUpgrades( enemy.ShrineUpgradeName )
			if pactLevel >= enemy.BossDifficultyShrineRequiredCount then
				OverwriteTableKeys(aiStage, aiStage.EMStageDataOverrides)
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

		if aiStage.UnequipAllWeapons then
			enemy.WeaponOptions = {}
		end

		if aiStage.SetMapFlags ~= nil then
			for k, flagData in ipairs( aiStage.SetMapFlags ) do
				flagData.Id = enemy.ObjectId
				thread( SetMapFlag, flagData )
			end
		end

		if aiStage.EquipWeapons ~= nil then
			for k, weaponName in ipairs( aiStage.EquipWeapons ) do
				table.insert( enemy.WeaponOptions, weaponName )
			end
		end

		if aiStage.EquipRandomWeapon ~= nil then
			local eligibleWeapons = {}
			for k, weaponName in ipairs( aiStage.EquipRandomWeapon ) do
				local weaponData = WeaponData[weaponName]
				if Contains( enemy.WeaponOptions, weaponName ) then
						-- skip
				elseif weaponData ~= nil and not IsEnemyWeaponEligible( enemy, weaponData, weaponData.EquipRequirements ) then
						-- skip
				else
					table.insert( eligibleWeapons, weaponName )
				end
			end
			local weaponName = GetRandomArrayValue( eligibleWeapons )
			if weaponName ~= nil then
				table.insert( enemy.WeaponOptions, weaponName )
			end
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

		if aiStage.WipeEnemyTypes ~= nil then
			for k, unitId in ipairs( GetIdsByType({ Names = aiStage.WipeEnemyTypes }) ) do
				thread( Kill, ActiveEnemies[unitId] )
			end
		end

		if aiStage.ExpireProjectiles ~= nil then
			ExpireProjectiles({ Names = aiStage.ExpireProjectiles, BlockSpawns = true })
		end

		if aiStage.EndThreadNameWaits then
			for k, threadName in pairs(aiStage.EndThreadNameWaits) do
				SetThreadWait(threadName, 0.1)
			end
		end

		if aiStage.KillDumbFireThreads then
			killWaitUntilThreads(enemy.DumbFireThreadName)
			killTaggedThreads(enemy.DumbFireThreadName)
		end

		if aiStage.DataOverrides then
			OverwriteTableKeys(enemy, aiStage.DataOverrides)
		end

		if aiStage.AIDataOverrides then
			OverwriteTableKeys(enemy.DefaultAIData, aiStage.AIDataOverrides)
		end

		if aiStage.RandomSpawnEncounter ~= nil and aiStage.SpawnEncounter == nil then
			aiStage.SpawnEncounter = GetRandomArrayValue( aiStage.RandomSpawnEncounter )
		end

		if aiStage.SpawnEncounter ~= nil then
			local encounterName = aiStage.SpawnEncounter
			local encounter = DeepCopyTable( EncounterData[encounterName] )
			if encounter.Generated then
				GenerateEncounter( CurrentRun, CurrentRun.CurrentRoom, encounter )
			end
			enemy.SpawnedEncounter = encounter
			if encounter.StartGlobalVoiceLines ~= nil then
				thread( PlayVoiceLines, GlobalVoiceLines[encounter.StartGlobalVoiceLines] )
			end
			thread( StartEncounter, CurrentRun, CurrentRun.CurrentRoom, encounter )
		end

		if enemy.AIEndWithSpawnedEncounterTimeout then
			CheckCooldown( enemy.Name.."AIEndWithSpawnedEncounterTimeout", enemy.AIEndWithSpawnedEncounterTimeout )
		end

		if aiStage.ThreadedEvents ~= nil then
			RunThreadedEvents( aiStage.ThreadedEvents, enemy )
		end

		CallFunctionName( aiStage.TransitionFunction, enemy, CurrentRun, aiStage )

		RunEventsGeneric( aiStage.TransitionUnthreadedEvents, enemy )

		if aiStage.DumbFireWeapons ~= nil then
			for k, weaponName in ipairs( aiStage.DumbFireWeapons ) do
				thread( DumbFireAttack, enemy, weaponName )
			end
		end

		enemy.InTransition = false

		-- Regular AI
		local aiFunctionName = GetRandomArrayValue( aiStage.RandomAIFunctionNames )
		if aiFunctionName ~= nil then
			SetAI( aiFunctionName, enemy )
		end

		if aiStage.EnableRoomTraps then
			DisableRoomTraps()
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

	--if verboseLogging and not IsAlive({ Id = enemy.ObjectId }) then
		--DebugAssert({ false, Text = enemy.Name.." ("..enemy.ObjectId..") doesn't exist but still running AI", Owner = "Eduardo" })
	--end

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
			if enemy.AIEndWithSpawnedEncounterTimeout ~= nil and CheckCooldownNoTrigger(enemy.Name.."AIEndWithSpawnedEncounterTimeout", enemy.AIEndWithSpawnedEncounterTimeout) then
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
	
	MapState.IdleUnits[enemy.ObjectId] = nil
	
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
	if enemy.SpeedMultiplier ~= nil and not args.IgnoreSpeedMultiplier and not enemy.IgnoreSpeedMultiplier then -- TODO: Change enemy.IgnoreSpeedMultiplier to instead pass in aiData and make it weapon specific
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
	--DebugAssert({ Condition = enemy.DefaultAIData ~= nil, Text = enemy.Name.." has no DefaultAIData", Owner = "Eduardo" })
	if WeaponData[weaponName] ~= nil and WeaponData[weaponName].AIData ~= nil then
		local weaponAIData = ShallowCopyTable(WeaponData[weaponName].AIData)

		if weaponAIData.ConditionalData ~= nil then
			for k, conditionalData in pairs(weaponAIData.ConditionalData) do
				if IsGameStateEligible( enemy, conditionalData.GameStateRequirements) then
					OverwriteTableKeys( weaponAIData, conditionalData.Data)
				end
			end
		end

		if enemy.WeaponComboData ~= nil and enemy.WeaponComboData.DataOverrides ~= nil and weaponName == enemy.WeaponComboData.WeaponName then
			OverwriteTableKeys( weaponAIData, enemy.WeaponComboData.DataOverrides)
		end

		OverwriteTableKeys( aiData, weaponAIData)
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

	if enemy.WakeUpDelay ~= nil or (enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil) then
		local wakeUpDelay = enemy.WakeUpDelay or RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
		wait( wakeUpDelay, enemy.AIThreadName )
	end

	PlaySound({ Name = enemy.IsAggroedSound or "/Leftovers/SFX/ImpRef01_GoDown", Id = enemy.ObjectId, ManagerCap = 28 })
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
		--local exitId = RoomData[CurrentRun.CurrentRoom.Name].SheepExitId or 658446
		local exitId = GetClosest({ Id = enemy.ObjectId, DestinationIds = GetIds({ Name = "SheepSpawnPoints" }) })
		Move({ Id = enemy.ObjectId, DestinationId = exitId, SuccessDistance = aiData.MoveSuccessDistance or 50, })
		enemy.AINotifyName = "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId
		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = exitId, Distance = 75, Notify = enemy.AINotifyName, Timeout = 20.0 })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )

		Kill(enemy, { Silent = true })
		if enemy.EscapedVFX ~= nil then
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = enemy.EscapedVFX })
		end
	end
end

function SheepHit( enemy, attacker, triggerArgs )
	SetAngle({ Id = enemy.ObjectId, Angle = triggerArgs.ImpactAngle })
	ApplyForce({ Id = enemy.ObjectId, Speed = enemy.SheepHitVelocity or 1500, Angle = triggerArgs.ImpactAngle })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Sheep_DashPreFire" })
end

function PigHit( enemy, attacker, triggerArgs )
	SetAngle({ Id = enemy.ObjectId, Angle = triggerArgs.ImpactAngle })
	ApplyForce({ Id = enemy.ObjectId, Speed = enemy.PigHitVelocity or 1500, Angle = triggerArgs.ImpactAngle })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Pig_Dash_Start" })
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
		enemy.CleanupResetColorGrading = true
	end

	SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.BeginPickupAnimation })
	CreateAnimation({ DestinationId = aiData.TargetId, Name = aiData.PickupFx })

	wait(aiData.BeginPickupDuration or 0.3, enemy.AIThreadName)

	if ReachedAIStageEnd(enemy) or CurrentRun.CurrentRoom.InStageTransition then
		aiData.ForcedEarlyExit = true
		AdjustColorGrading({ Name = "Off", Duration = 0.3 })
		enemy.CleanupResetColorGrading = false
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.3, EaseIn = 0.3 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.3, ZoomType = "Ease" })
		return true
	end

	local arc = aiData.TargetArcRange or 120
	local facingAngle = GetAngle({ Id = enemy.ObjectId })
	local angleToTarget = GetAngleBetween({ Id = enemy.ObjectId, DestinationId = aiData.TargetId })
	local isWithinDistance = IsWithinDistance({ Id = enemy.ObjectId, DestinationId = aiData.TargetId, Distance = aiData.AttackDistance, ScaleY = aiData.AttackDistanceScaleY })
	local arcDistance = CalcArcDistance( facingAngle, angleToTarget )

	if not isWithinDistance or arcDistance > arc or IsInvulnerable({ Id = aiData.TargetId }) then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.8, EaseIn = 0.3 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.8, ZoomType = "Ease" })
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PickupFailedAnimation })
		AdjustColorGrading({ Name = "Off", Duration = 0.8 })
		enemy.CleanupResetColorGrading = false
		thread( InCombatTextArgs, { TargetId = enemy.ObjectId, Text = "PolyphemuGrabTargetFailed", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, OffsetY = 80 } )
		return
	end

	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	enemy.CleanupResetColorGrading = false

	SetGoalAngle({ Id = enemy.ObjectId, Angle = 90 })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PickupAnimation })
	
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.2, EaseIn = 0.3 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1.2, ZoomType = "Ease" })

	if aiData.TargetId ~= nil and ActiveEnemies[aiData.TargetId] ~= nil then
		ActiveEnemies[aiData.TargetId].OnDeathThreadedFunctionName = "SpawnSheepGhost"
		if ActiveEnemies[aiData.TargetId].Name ~= "Sheep" then
			Kill(ActiveEnemies[aiData.TargetId])
			ApplyEffect({ DestinationId = enemy.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "PolyphemusStomachAche", DataProperties = EffectData.PolyphemusStomachAche.EffectData })
			thread( PlayVoiceLines, enemy.BadMealVoiceLines, nil, enemy )
			wait(aiData.AIPickupDuration or 2.0, enemy.AIThreadName)
			SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Polyphemus_GrabReturnUnsatisfied" })
		else
			thread( InCombatTextArgs, { TargetId = enemy.ObjectId, Text = "PolyphemuGrabSheepSuccess", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, OffsetY = 80 } )
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
				MedeaRanged = true,
				MedeaDaggerMelee = true,
				PoisonPuddle = true,
				PoisonPuddleSmall = true,
				PoisonPuddleLarge = true,
			},
			ValidWeaponMultiplier = 0,
			Temporary = true,
		})
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "MedeaPoison" })
		AddEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "MedeaPoison" })
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = enemy.ObjectId, EffectName = "PolyphemusPlayerGrab", DataProperties = EffectData.PolyphemusPlayerGrab.EffectData })
		SetAnimation({ Name = "MelinoeIdle", DestinationId = CurrentRun.Hero.ObjectId })
		SetPlayerFade({ Flag = "PolyphemusGrab", Duration = 0.34 })
		ApplyUpwardForce({ Id = CurrentRun.Hero.ObjectId, Speed = 400 })
		wait( 0.31, enemy.AIThreadName )
		Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, OffsetY = -110 })
		AddPlayerImmuneToForce("PolyphemusPickup")
		thread( PlayVoiceLines, GlobalVoiceLines.PolyphemusGrabbedPlayerVoiceLines )
		wait(0.35, enemy.AIThreadName)
		--AdjustFullscreenBloom({ Name = "Default", Duration = AIPickupDuration })
		
		wait(aiData.AIPickupDuration or 2.0, enemy.AIThreadName)
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "PolyphemusPlayerGrab" })
		RemoveIncomingDamageModifier( CurrentRun.Hero, "GrabImmunity")
		SetLifeProperty({ Property = "ConsecutiveHits", Value = 0, ValueChangeType = "Absolute", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
		RemovePlayerImmuneToForce("PolyphemusPickup")
		RemoveInputBlock({ Name = "PolyphemusPlayerPreGrab" })
		RemoveEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "MedeaPoison" })
		RemoveValue(enemy.ActiveInputBlocks, "PolyphemusPlayerPreGrab")
		--AdjustFullscreenBloom({ Name = "Off", Duration = AIPickupDuration })
	else
		thread( InCombatTextArgs, { TargetId = enemy.ObjectId, Text = "PolyphemuGrabTargetFailed", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, OffsetY = 80 } )
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
		UpdateHealthBar( unit, 0, { Force = true } )
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

function FloodManager( source, args )

	if IsEmpty( GetIdsByType({ Names = args.Types }) ) then
		return
	end

	local firstWait = 0
	if args.FirstIntervalMin ~= nil and args.FirstIntervalMax ~= nil then
		firstWait = RandomFloat( args.FirstIntervalMin, args.FirstIntervalMax )
	end
	wait( firstWait, RoomThreadName )
	local encounter = CurrentRun.CurrentRoom.Encounter
	if encounter.Completed then
		return
	end
	FloodEncounterStartPresentation( source, encounter )

	while not encounter.Completed do

		FireFloodTraps( args )
		
		local waitTime = RandomFloat( args.IntervalMin, args.IntervalMax )
		wait( waitTime, RoomThreadName )

		if encounter.Completed then
			break
		end
		if GetConfigOptionValue({ Name = "EditingMode" }) then
			break
		end
	end
end

function FireFloodTraps( enemy, aiData, currentRun, args)
	args = args or {}
	if args.MaxPlayerDistance ~= nil then
		if GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) > args.MaxPlayerDistance then
			return false
		end
	end

	--FloodTrapFireStartPresentation()

	args = args or {}
	for k, typeName in pairs(args.Types or { "FloodTrap" }) do
		for k, unitId in pairs( GetIdsByType({ Name = typeName }) ) do
			if ActiveEnemies[unitId] ~= nil then
				thread(DoAttackerAILoop, ActiveEnemies[unitId])
			end
		end
	end
	
	--thread( FloodTrapFireEndPresentation )
end

function GetAllAllyIds(unit)
	local unitFriendly = GetUnitDataValue({ Id = unit.ObjectId, Property = "FriendlyToPlayer" })
	--DebugPrint({ Text=unitFriendly }) -- returning nil
	local unitIds = GetAllKeys(ActiveEnemies)

	local allyIds = {}

	for k, unitId in pairs(unitIds) do
		if GetUnitDataValue({ Id = unitId, Property = "FriendlyToPlayer" }) == unitFriendly then
			table.insert(allyIds, unitId)
		end
	end

	return allyIds
end

function HecateStageTransition1(enemy, CurrentRun, aiStage)

	ClearEffect({ Id = enemy.ObjectId, Name = "HecateDarkSide" })
	killTaggedThreads("HecateDarkSideRangedThread")
	StopAnimation({ DestinationId = enemy.ObjectId, Name = "HecateSpellChargeFx", IncludeCreatedAnimations = true })

	CreateAnimation({ DestinationId = enemy.ObjectId, Name = "HecateTeleportFxFront" })
	Teleport({ Id = enemy.ObjectId, DestinationId = RoomData[CurrentRun.CurrentRoom.Name].HecateStageTransitionPoint or 510277 })
	CreateAnimation({ DestinationId = enemy.ObjectId, Name = "HecateTeleportFxFront" })
	thread( PlayVoiceLines, GlobalVoiceLines.HecatePhaseChangeVoiceLines, nil, enemy )

	local midPhaseWeapons = {}
	for i, weapon in ipairs( aiStage.MidPhaseWeapons ) do
		local weaponData = WeaponData[weapon]
		if IsGameStateEligible( enemy, (weaponData.GameStateRequirements or {}) ) then
			table.insert( midPhaseWeapons, weapon )
		end
	end
	enemy.MidPhaseWeapon =  GetRandomValue(midPhaseWeapons)
	table.insert(enemy.WeaponOptions, enemy.MidPhaseWeapon)
end

function HecateStageTransition2(enemy, CurrentRun, aiStage)

	ClearEffect({ Id = enemy.ObjectId, Name = "HecateDarkSide" })
	killTaggedThreads("HecateDarkSideRangedThread")
	StopAnimation({ DestinationId = enemy.ObjectId, Name = "HecateSpellChargeFx", IncludeCreatedAnimations = true })

	CreateAnimation({ DestinationId = enemy.ObjectId, Name = "HecateTeleportFxFront" })
	Teleport({ Id = enemy.ObjectId, DestinationId = RoomData[CurrentRun.CurrentRoom.Name].HecateStageTransitionPoint or 510277 })
	CreateAnimation({ DestinationId = enemy.ObjectId, Name = "HecateTeleportFxFront" })
	thread( PlayVoiceLines, GlobalVoiceLines.HecatePhaseChangeVoiceLines, nil, enemy )

	table.insert(enemy.WeaponOptions, enemy.MidPhaseWeapon)
end

function TakeAmbientBattleDamage(enemy)
	if enemy == nil or enemy.TakenAmbientBattleDamage then
		return
	end

	if enemy.TakeAmbientBattleDamageChance ~= nil and not RandomChance(enemy.TakeAmbientBattleDamageChance) then
		return
	end

	local damageMin = enemy.AmbientBattleDamageMin
	local damageMax = enemy.AmbientBattleDamageMax

	if enemy.Encounter.AmbientBattleDamagePerGroup ~= nil then
		for groupName, battleDamageData in pairs(enemy.Encounter.AmbientBattleDamagePerGroup) do
			if Contains(enemy.Groups, groupName) then
				damageMin = battleDamageData.Min
				damageMax = battleDamageData.Max
			end
		end
	end

	if damageMin == nil or damageMax == nil then
		enemy.TakenAmbientBattleDamage = true
		return
	end

	local amount = RandomFloat(damageMin, damageMax)

	local maxHealth = enemy.MaxHealthBuffer or enemy.MaxHealth

	Damage( enemy, { DamageAmount = maxHealth * amount , Silent = true, PureDamage = true } )
	if not enemy.IsDead then
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlow", Fraction = 1 - (enemy.DisplayedHealthFraction or 1.0), DestinationId = EnemyHealthDisplayAnchors[enemy.ObjectId.."falloff"], Instant = true })
		enemy.HealthBarFalloffShown = true
	end
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
	CreateAnimation({ Name = "RadialNovaDevotion-Artemis", DestinationId = consumableId }) --nopkg
	UseableOn({ Id = consumableId })
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

function ChronosTimeSlow( enemy, aiData, CurrentRun, args )
	SessionMapState.ChronosTimeSlowActive = true
	GameplaySetElapsedTimeMultiplier( { ElapsedTimeMultiplier = 0.3, Name = "ChronosTimeSlow", ApplyToPlayerUnits = true, SkipPresentation = true, Ignore = enemy } )
	thread( CallFunctionName, "ChronosTimeSlowPresentation" )
	thread( EndChronosTimeSlow, enemy, aiData )
end

function EndChronosTimeSlow( enemy, aiData )

	waitUnmodified( aiData.TimeSlowDuration or 10, enemy.AIThreadName )
	thread( CallFunctionName, "ChronosEndTimeSlowPresentation" )
	GameplaySetElapsedTimeMultiplier( { ElapsedTimeMultiplier = 0.3, Reverse = true, Name = "ChronosTimeSlow", ApplyToPlayerUnits = true, Ignore = enemy } )
	SessionMapState.ChronosTimeSlowActive = nil
end

function OilPuddleOnHit( enemy, args )

	local attacker = args.AttackerTable

	if not CheckCooldownNoTrigger("NewOilSpawned", 1) then
		return
	end

	if not enemy.Lit then
		local forceIgnite = false
		if attacker == CurrentRun.Hero and args.SourceWeapon ~= nil  then
			local weaponName = args.SourceWeapon
			if WeaponSetLookups.HeroPrimaryWeaponsLinked[weaponName] and CurrentRun.Hero.SlottedTraits.Melee and GetLootSourceName(CurrentRun.Hero.SlottedTraits.Melee) == "HestiaUpgrade" then
				forceIgnite = true
			elseif WeaponSetLookups.HeroSecondaryWeaponsLinked[weaponName] and CurrentRun.Hero.SlottedTraits.Secondary and GetLootSourceName(CurrentRun.Hero.SlottedTraits.Secondary) == "HestiaUpgrade" then
				forceIgnite = true
			elseif WeaponSetLookups.HeroRangedWeaponsLinked[weaponName] and CurrentRun.Hero.SlottedTraits.Ranged and GetLootSourceName(CurrentRun.Hero.SlottedTraits.Ranged) == "HestiaUpgrade" then
				forceIgnite = true
			end
		end
		if forceIgnite or ( ProjectileData[args.SourceProjectile] ~= nil and ProjectileData[args.SourceProjectile].CanIgnite ) then
			enemy.Lit = true
			SetLifeProperty({ Property = "TriggerOnHit", Value = false, DestinationId = enemy.ObjectId, DataValue = true })
			DoAttackerAILoop(enemy)
		end
	else
		local douseFire = false
		if douseFire or ( ProjectileData[args.SourceProjectile] ~= nil and ProjectileData[args.SourceProjectile].DouseFire ) then
			enemy.Lit = false
			DouseFire(enemy.ObjectId)
			ExpireProjectiles({ ProjectileIds = enemy.ProjectileIds })
		end
	end
end

function CharybdisTransition( enemy, CurrentRun, aiStage )

	local defaultZoom = CurrentRun.CurrentRoom.ZoomFraction

	enemy.WeaponName = aiStage.TransitionWeapon
	--DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = enemy.Name.." has no eligible weapons.", Owner = "Eduardo" })
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
	CheckCooldown("NewOilSpawned", 1)
end

function ScyllaFightTrackSpotlight(enemy)
	Stop({ Id = enemy.ObjectId })
	Track({ Ids = { enemy.ObjectId }, DestinationIds = { MapState.SpotlightUnitId } })
end
function EnforcerBoostActivate(unit, aiData, currentRun, args)
	args = args or {}

	thread( InCombatText, unit.ObjectId, "Enraged!", 0.45, { OffsetY = unit.HealthBarOffsetY, SkipShadow = true }  )
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "EliteUnitStatus2" })

	unit.SpeedMultiplier = unit.SpeedMultiplier or 1.0
	unit.SpeedMultiplier = unit.SpeedMultiplier * args.SpeedMultiplier
	SetUnitProperty({ DestinationId = unit.ObjectId, Property = "Speed", Value = GetUnitDataValue({ Id = unit.ObjectId, Property = "Speed" }) * args.SpeedMultiplier })
	SetElapsedTimeMultiplier( unit.SpeedMultiplier * args.ElapsedTimeMultiplier, unit.AIThreadName)
end

function MatiOpenEye( enemy )
	if not enemy.MatiEyeOpened then
		if not enemy.IsPolymorphed then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Mati_IdlePostEyeClosed" })
		end
		enemy.MatiEyeOpened = true
		AIWait(0.28, enemy, enemy.AIThreadName)
		RemoveIncomingDamageModifier( enemy, "MatiEyeClosed" )
		if not enemy.IsElite or (enemy.IsElite and enemy.HealthBuffer <= 0) then
			SetUnitProperty({ Property = "ImmuneToStun", Value = false, DestinationId = enemy.ObjectId })
		end
	end
end

function MatiCloseEye( enemy, aiData )
	if enemy.MatiEyeOpened and not enemy.IsPolymorphed then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Mati_IdlePreEyeClosed" })
		AddIncomingDamageModifier( enemy, enemy.CloseEyeAddIncomingDamageModifier )
		enemy.MatiEyeOpened = false
		SetUnitProperty({ Property = "ImmuneToStun", Value = true, DestinationId = enemy.ObjectId })
	end
end

function CheckEagleRetreat( unit, attacker, TriggerDistance )
	if unit.Health <= 0 then
		Stop({ Id = unit.ObjectId })
		CleanupEnemy( unit )

		--thread(LastKillPresentation, unit)
		PanCamera({ Ids = { unit.ObjectId, CurrentRun.Hero.ObjectId }, Duration = 1.2, EaseIn = 0.3 })
		FocusCamera({ Fraction = 0.9, Duration = 1.2, ZoomType = "Ease" })
		SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_Eagle_AscendPreFire" }) --nopkg

		wait(0.7)

		AdjustZLocation({ Id = unit.ObjectId, Distance = 2000 - GetZLocation({ Id = unit.ObjectId }), Duration = 0.3 })
		PlaySound({ Name = "/SFX/QuickSnap", Id = unit.ObjectId })
		thread( InCombatText, unit.ObjectId, "PolyphemuGrabTargetFailed", 0.45, { SkipShadow = true } )

		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.8, EaseIn = 0.3 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.8, ZoomType = "Ease" })
	end
end

function EliteMetallicInvulnerability( enemy )

	SetUnitInvulnerable(enemy)

	wait(3.0, enemy.AIThreadName)

	while IsAIActive( enemy ) and TableLength( RequiredKillEnemies ) > 1 do

		waitUntil( "RequiredEnemyKilled" )
	end

	SetUnitVulnerable(enemy)
end

function EagleAttackAndFlee( enemy )

	waitUntil( "EagleSpawnPresentationEnded" )

	enemy.WeaponName = enemy.DefaultAIData.OlympusStartWeapon or "EagleDive_Olympus"
	HandleEnemyTeleportation(enemy, GetWeaponAIData(enemy))
	DoAttack(enemy, GetWeaponAIData(enemy))

	notifyExistingWaiters("EagleEntranceAttackEnded")

	local numAttacks = RandomInt(enemy.DefaultAIData.OlympusWeaponCountMin, enemy.DefaultAIData.OlympusWeaponCountMax)
	enemy.WeaponOptions = enemy.DefaultAIData.OlympusWeaponOptions
	for i = 1, numAttacks do
		DoAttackerAILoop(enemy)
	end

	enemy.WeaponName = enemy.DefaultAIData.OlympusEndWeapon or "EagleFlyUpWhirlwind_Olympus"
	DoAttack(enemy, GetWeaponAIData(enemy))


	if enemy.FledVoiceLines ~= nil then
		thread( PlayVoiceLines, enemy.FledVoiceLines, nil, enemy )
	end

	--SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Eagle_AscendPreFire" }) --nopkg
	Kill(enemy, { Silent = true, BlockRespawns = true })

	if enemy.RaiseEncounterActiveEnemyCapBonusOnExit then
		enemy.Encounter.ActiveEnemyCapMaxModifier = enemy.Encounter.ActiveEnemyCapMaxModifier + enemy.RaiseEncounterActiveEnemyCapBonusOnExit
		--DebugPrint({ Text="Eagle left, raising Encounter ActiveEnemyCap back." })
	end
end

function EndPreAttackFx(enemy, aiData)

	if aiData.PreAttackFx ~= nil then
		StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFx, PreventChain = true })
	end
	if aiData.PreAttackMultiFx ~= nil then
		for k, name in pairs(aiData.PreAttackMultiFx) do
			StopAnimation({ DestinationId = enemy.ObjectId, Name = name, PreventChain = true })
		end
	end
	if aiData.PreAttackFxBetween ~= nil then
		StopAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFxBetween, PreventChain = true })
	end
	if aiData.PreAttackFxAtTarget ~= nil then
		StopAnimation({ DestinationId = aiData.TargetId, Name = aiData.PreAttackFxAtTarget, PreventChain = true })
	end
	if aiData.PreAttackMultiFxAtTarget ~= nil then
		for k, name in pairs( aiData.PreAttackMultiFxAtTarget ) do
			StopAnimation({ DestinationId = aiData.TargetId, Name = name, PreventChain = true })
		end
	end
end

function UseGodStatueTrap( statue, args )

	if IsEmpty(RequiredKillEnemies) then
		CannotUseObjectPresentation(statue)
		return
	end

	UseGodStatueTrapPresentation( statue, args )

	statue.TimesFired = statue.TimesFired or 0
	if statue.TimesFired < statue.MaxUses then
		thread(DoAttack, statue, GetWeaponAIData(statue) )
		statue.TimesFired = statue.TimesFired + 1

		if statue.TimesFired >= statue.MaxUses then
			SetAnimation({ DestinationId = statue.ObjectId, Name = statue.DepletedAnimation })
			UseableOff({ Id = statue.ObjectId })
		end
	end
end

function TyphonHeadEggAI(enemy)

	local duration = enemy.DefaultAIData.HatchDuration or 8
	for i = 1, duration do
		CreateAnimation({ Name = "TyphonHeadEggPulse", DestinationId = enemy.ObjectId })
		if i >= duration - 2 then
			Flash({ Id = enemy.ObjectId, Speed = 6 - ((duration - i) * 2), MinFraction = 0, MaxFraction = 0.35, Color = Color.White, Duration = 1 })
		end
		if i == duration then
			--PlaySound({ Name = "", Id = enemy.ObjectId })
			Shake({ Id = enemy.ObjectId, Speed = 400, Distance = 4, Duration = 1.0 })
		end
		AIWait(1.0, enemy, enemy.AIThreadName)
	end

	if enemy.DefaultAIData.SpawnFx ~= nil then
		CreateAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DefaultAIData.SpawnFx })
	end
	thread( PlayVoiceLines, enemy.HatchVoiceLines, nil, enemy )
	local enemyData = EnemyData[GetRandomValue(enemy.DefaultAIData.SpawnOptions)]
	local newEnemy = DeepCopyTable( enemyData )
	newEnemy.StartAggroed = true
	if newEnemy.IsUnitGroup then
		SpawnUnitGroup( newEnemy, nil, nil, enemy.ObjectId)
	else
		newEnemy.ObjectId = SpawnUnit({ Name = newEnemy.Name, Group = "Standing", DestinationId = enemy.ObjectId })
		thread(SetupUnit, newEnemy, CurrentRun, { SkipPresentation = true } )
	end

	Kill(enemy)
end

function PrometheusPostAttackForesight(enemy, aiData, currentRun, args)

	waitUnmodified(0.05)
	if CheckCooldownNoTrigger( "PrometheusForesight", aiData.ForesightCooldown ) and RandomChance( aiData.ForesightChance ) then
		if IsEmpty( MapState.ChargedManaWeapons ) then
			waitUntil("ChargeManaWeaponFire", enemy.AIThreadName)
		end

		TriggerCooldown("PrometheusForesight")

		SetUnitInvulnerable(enemy, "PrometheusForesight")
		enemy.ForcedWeaponInterrupt = "PrometheusDashForsight"
		notifyExistingWaiters( enemy.AINotifyName )
		SetThreadWait( enemy.AIThreadName, 0.1 )
	end
end

function PrometheusCancelPostAttackForesight(enemy, aiData)
	killWaitUntilThreads("ChargeManaWeaponFire")
end

function ReapplyProjectileSpeedMultiplier( projectileData, args, triggerArgs )
	local projectileSpeedMultiplier = GetTotalHeroTraitValue("EnemyProjectileSpeedMultiplier", {IsMultiplier = true, Multiplicative = true })
	if triggerArgs.ProjectileId and projectileSpeedMultiplier ~= 1 then
		SetProjectileProperty({ ProjectileId = triggerArgs.ProjectileId, Property = "SpeedMultiplier", Value = projectileSpeedMultiplier })
	end
end

function HandleEnemyRushCollision(victim, triggerArgs, args)
	if victim.Rushing and _worldTime - (victim.RushStartBuffer or 0.3) > victim.RushStartTime then
		victim.RushCollision = true
		Stop({ Id = victim.ObjectId })
		notifyExistingWaiters(victim.AINotifyName)
	end
end

function HecateWolfHowl(hecate, aiData)
	Halt({ Id = hecate.ObjectId })
	local distanceToTarget = GetDistance({ Id = hecate.ObjectId, DestinationId = aiData.TargetId })

	AngleTowardTarget({ Id = hecate.ObjectId, DestinationId = aiData.TargetId })

	SetAnimation({ Name = aiData.PreLeapAnimation, DestinationId = hecate.ObjectId })
	wait( aiData.PreLeapTime, hecate.AIThreadName )

	SetUnitProperty({ DestinationId = hecate.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = hecate.ObjectId, Property = "CollideWithUnits", Value = false })
	CreateAnimation({ Name = "SorceryLeapRiseStreaks", DestinationId = hecate.ObjectId })
	if aiData.LeapRiseSound then
		PlaySound({ Name = aiData.LeapRiseSound, Id = hecate.ObjectId })
	end
	AdjustZLocation({ Id = hecate.ObjectId, Distance = aiData.RiseDistance, Duration = aiData.RiseTime, EaseIn = 0.85, EaseOut = 1.0 })
	wait( aiData.RiseTime + aiData.HangTime, hecate.AIThreadName )

	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitter", DestinationId = hecate.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitterBright", DestinationId = hecate.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitterDisplace", DestinationId = hecate.ObjectId })
	SetAnimation({ Name = aiData.LeapAnimation, DestinationId = hecate.ObjectId })

	if aiData.LeapFlightSound then
		PlaySound({ Name = aiData.LeapFlightSound, Id = hecate.ObjectId })
	end

	local landingEaseIn = 0.0
	local landingEaseOut = 0.1

	AdjustZLocation({Id = hecate.ObjectId, Distance = -GetZLocation({ Id = hecate.ObjectId }), Duration = aiData.LandingTime, EaseIn = landingEaseIn, EaseOut = landingEaseOut })
	Move({ Id = hecate.ObjectId, 
		Angle = GetAngleBetween({ Id = hecate.ObjectId, DestinationId = aiData.TargetId }), 
		Distance = distanceToTarget, 
		Speed = distanceToTarget / aiData.LandingTime,
		EaseIn = landingEaseIn, EaseOut = landingEaseOut })
	
	--thread( LeapSimSlow, weaponData, weaponData.LandingTime )
	wait(aiData.LandingTime, hecate.AIThreadName)

	if aiData.LeapLandingSound then
		PlaySound({ Name = aiData.LeapLandingSound, Id = hecate.ObjectId })
	end
	Halt({ Id = hecate.ObjectId })
	SetUnitProperty({ DestinationId = hecate.ObjectId, Property = "CollideWithObstacles", Value = true })
	SetUnitProperty({ DestinationId = hecate.ObjectId, Property = "CollideWithUnits", Value = true })
	--SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = immuneToForceReset })
end

function CharybdisScyllaFightGroupAI( scylla, args )
	while CurrentRun.CurrentRoom.Encounter.InProgress do
		TentacleCoordinatedAttack(scylla, args)
		wait(args.AttackRate, scylla.AIThreadName)
	end
end

function TentacleCoordinatedAttack(scylla, args)
	local coordinatedWeaponOption = SelectWeapon(ActiveEnemies[args.TentacleIdsOrdered[1]])

	for index, tentacleId in ipairs(args.TentacleIdsOrdered) do
		local tentacleUnit = ActiveEnemies[tentacleId]
		if not tentacleUnit.Hiding then
			tentacleUnit.WeaponName = coordinatedWeaponOption
			thread(DoAttack, tentacleUnit, GetWeaponAIData(tentacleUnit))
			wait(RandomFloat(args.AttackTimingVarianceMin, args.AttackTimingVarianceMax), scylla.AIThreadName)
		end
	end
end

function MedeaCorpseExplode(enemy, aiData, CurrentRun, args )

	if ActiveEnemies[aiData.TargetId] == nil or ActiveEnemies[aiData.TargetId].IsDead then
		return
	end

	ActiveEnemies[aiData.TargetId].ForcedWeaponInterrupt = "ZombieCorpseExplode"
	notifyExistingWaiters( ActiveEnemies[aiData.TargetId].AINotifyName )
	SetThreadWait(ActiveEnemies[aiData.TargetId].AIThreadName, 0.01)
	thread( InCombatText, aiData.TargetId, "Polymorphed", 1.45, { OffsetY = ActiveEnemies[aiData.TargetId].HealthBarOffsetY, SkipShadow = true }  )

end

function EnemyGainHitShields( enemy, count )
	if enemy.MaxHitShields == nil then
		return
	end
	count = count or 1
	enemy.HitShields = enemy.HitShields or 0
	enemy.HitShields = math.min(enemy.HitShields + count, enemy.MaxHitShields )
	if not enemy.HasHealthBar then
		CreateHealthBar( enemy )
	end
	UpdateHealthBar( enemy, 0, { Force = true } )
end

function PrometheusHeraclesRoleSwitcher(encounter, args)

	MapState.Aggressor = "Prometheus"
	local heracles = ActiveEnemies[GetFirstValue(GetIdsByType({ Name = "Heracles" }))]
	local prometheus = ActiveEnemies[GetFirstValue(GetIdsByType({ Name = "Prometheus" }))]

	wait(args.Interval or 10, "PrometheusHeraclesRoleSwitcher")

	while encounter.InProgress do
		if heracles == nil or heracles.IsDead then
			MapState.Aggressor = nil
			return
		end

		if prometheus == nil or prometheus.KnockedOut then
			MapState.Aggressor = nil
			thread( PlayVoiceLines, GlobalVoiceLines.PrometheusKnockedOutLines, nil, heracles )
			return
		end

		if not MapState.AggressorLock then
			if MapState.Aggressor == "Prometheus" then
				MapState.Aggressor = "Heracles"
				thread( PlayVoiceLines, GlobalVoiceLines.PrometheusTagInLines, nil, prometheus )
			else
				MapState.Aggressor = "Prometheus"
				thread( PlayVoiceLines, GlobalVoiceLines.HeraclesTagInLines, nil, heracles )
			end
		end

		wait(args.Interval or 10, "PrometheusHeraclesRoleSwitcher")
	end
end

function TentacleDeathCheck(tentacle)
	for id, enemy in pairs(RequiredKillEnemies) do
		if id ~= tentacle.ObjectId and enemy.Name == "CharybdisTentacle2" then
			return
		end
	end
	thread( Kill, ActiveEnemies[737136] ) -- Charybdis
	thread(LastKillPresentation, tentacle)
	thread( PlayVoiceLines, GlobalVoiceLines.ScyllaCharybdisDeathReactionVoiceLines )
end

function ZagreusUseCastAmmo(enemy, aiData, currentRun, args)
	enemy.CastAmmo = enemy.CastAmmo - 1
end
function ZagreusCollectCastAmmo(enemy, aiData, currentRun, args)
	enemy.CastAmmo = enemy.CastAmmo + 1
end