function DeferredCombatPresentation()
	for id, args in pairs( CombatPresentationDeferredHealthBars ) do
		UpdateHealthBarReal( args )
		CombatPresentationDeferredHealthBars[id] = nil
	end
end

function GetNumBossHealthBars()
	local bars = 0
	for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if enemy.UseBossHealthBar then
			bars = bars + 1
		end
	end
	return bars
end

function CreateHealthBar( newEnemy )

	if newEnemy == nil then
		return
	end
	if newEnemy.Health == nil or newEnemy.HideHealthBar or newEnemy.HasHealthBar then
		return
	end
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if newEnemy.UseBossHealthBar then
		if not newEnemy.HasHealthBar then
			CreateBossHealthBar( newEnemy )
		end
		return
	end

	newEnemy.HasHealthBar = true

	local offsetY = ConstantsData.DefaultHealthBarOffsetY
	if newEnemy.Scale ~= nil then
		offsetY = offsetY * newEnemy.Scale
	end
	if newEnemy.HealthBarOffsetY then
		offsetY = newEnemy.HealthBarOffsetY
	end

	local backingId = SpawnObstacle({ Name = "EnemyHealthBar", Group = "Combat_UI_World_Backing", DestinationId = newEnemy.ObjectId,
		Attach = true, AttachToMarkerName = newEnemy.HealthBarAttachToMarkerName,
		OffsetY = offsetY, TriggerOnSpawn = false })
	EnemyHealthDisplayAnchors[newEnemy.ObjectId.."back"] = backingId
	if newEnemy.HealthBuffer and newEnemy.HealthBuffer > 0 then
		SetAnimation({ DestinationId = backingId, Name = "EnemyHealthBarArmor" })
	end
	
	-- red health bar
	local screenId = SpawnObstacle({ Name = "EnemyHealthBarFill", Group = "Combat_UI_World", DestinationId = newEnemy.ObjectId,
		Attach = true, AttachToMarkerName = newEnemy.HealthBarAttachToMarkerName,
		OffsetY = offsetY, TriggerOnSpawn = false })
	EnemyHealthDisplayAnchors[newEnemy.ObjectId] = screenId

	local maxHealth = newEnemy.MaxHealth
	if newEnemy.HealthBuffer and newEnemy.HealthBuffer > 0 and not newEnemy.MaxHealthBuffer then
		newEnemy.MaxHealthBuffer = newEnemy.HealthBuffer
	end

	local displayedHealthPercent = 1
	if newEnemy.HitShields ~= nil and newEnemy.HitShields > 0 then
		displayedHealthPercent = 1
	elseif newEnemy.HealthBuffer ~= nil and newEnemy.HealthBuffer > 0 then
		displayedHealthPercent = newEnemy.HealthBuffer / newEnemy.MaxHealthBuffer
	elseif newEnemy.Health then
		displayedHealthPercent = newEnemy.Health / maxHealth
	end

	newEnemy.DisplayedHealthFraction = displayedHealthPercent
	
	-- Falloff health bar
	local backingScreenId = SpawnObstacle({ Name = "EnemyHealthBarFillSlow", Group = "Combat_UI_World_Backing", DestinationId = newEnemy.ObjectId,
		Attach = true, AttachToMarkerName = newEnemy.HealthBarAttachToMarkerName,
		OffsetY = offsetY, TriggerOnSpawn = false })
	EnemyHealthDisplayAnchors[newEnemy.ObjectId.."falloff"] = backingScreenId
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlow", Fraction = 1 - displayedHealthPercent, DestinationId = backingScreenId, Instant = true })
	SetColor({ Id = backingScreenId, Color = Color.HealthFalloff })

	if newEnemy.HealthBarScale ~= nil then
		newEnemy.BarXScale = newEnemy.HealthBarScale
	elseif newEnemy.HealthBarType ~= nil then
		if newEnemy.HealthBarType == "Small" then
			newEnemy.BarXScale = CombatUI.SmallHealthBarScale
		elseif newEnemy.HealthBarType == "Medium" then
			newEnemy.BarXScale = CombatUI.MediumHealthBarScale
		elseif newEnemy.HealthBarType == "MediumLarge" then
			newEnemy.BarXScale = CombatUI.MediumLargeHealthBarScale
		elseif newEnemy.HealthBarType == "ExtraLarge" then
			newEnemy.BarXScale = CombatUI.ExtraLargeHealthBarScale
		else
			newEnemy.BarXScale = CombatUI.LargeHealthBarScale
		end
	elseif maxHealth ~= nil then
		if maxHealth <= CombatUI.SmallHeathBarThreshold then
			newEnemy.BarXScale = CombatUI.SmallHealthBarScale
		elseif maxHealth <= CombatUI.MediumHealthBarThreshold then
			newEnemy.BarXScale = CombatUI.MediumHealthBarScale
		elseif maxHealth <= CombatUI.MediumLargeHealthBarThreshold then
			newEnemy.BarXScale = CombatUI.MediumLargeHealthBarScale
		else
			newEnemy.BarXScale = CombatUI.LargeHealthBarScale
		end
	else
		newEnemy.BarXScale = 1.0
	end

	local healthBarLength = newEnemy.BarXScale * 98

	if newEnemy.EliteIcon then
		if newEnemy.EliteAttributes ~= nil and not IsEmpty(newEnemy.EliteAttributes) then
			local attributeCount = 0
			for k, attributeName in pairs(newEnemy.EliteAttributes) do
				attributeCount = attributeCount + 1
				local attributeBadgeId = EnemyHealthDisplayAnchors[newEnemy.ObjectId.."elitebadge"..attributeName]
				if attributeBadgeId ~= nil then
					Destroy({ Id = attributeBadgeId })
				end
				attributeBadgeId = SpawnObstacle({ Name = "HealthElite", Group = "Combat_UI_World_Backing", TriggerOnSpawn = false })
				Attach({ Id = attributeBadgeId, DestinationId = screenId, OffsetX = -1 * healthBarLength/2 - 20 - (35 * (attributeCount - 1)), OffsetY = 0})
				local iconName = "EliteAttribute"..attributeName
				SetAnimation({ DestinationId = attributeBadgeId, Name = iconName })
				EnemyHealthDisplayAnchors[newEnemy.ObjectId.."elitebadge"..attributeName] = attributeBadgeId
			end
		else
			local eliteBadgeId = EnemyHealthDisplayAnchors[newEnemy.ObjectId.."elitebadge"]
			if eliteBadgeId ~= nil then
				Destroy({ Id = eliteBadgeId })
			end
			eliteBadgeId = SpawnObstacle({ Name = "HealthElite", Group = "Combat_UI_World_Backing", TriggerOnSpawn = false })
			Attach({ Id = eliteBadgeId, DestinationId = screenId, OffsetX = -1 * healthBarLength/2 - 20, OffsetY = 0})
			EnemyHealthDisplayAnchors[newEnemy.ObjectId.."elitebadge"] = eliteBadgeId
		end
	end

	if newEnemy.HeraclesBounty then
		local bountyBadgeId = EnemyHealthDisplayAnchors[newEnemy.ObjectId.."bountybadge"]
		if bountyBadgeId ~= nil then
			Destroy({ Id = bountyBadgeId })
		end
		bountyBadgeId = SpawnObstacle({ Name = "HeraclesBounty", Group = "Combat_UI_World_Backing", TriggerOnSpawn = false })
		Attach({ Id = bountyBadgeId, DestinationId = screenId, OffsetX = 0, OffsetY = 23})
		EnemyHealthDisplayAnchors[newEnemy.ObjectId.."bountybadge"] = bountyBadgeId
	end

	SetScaleX({ Ids = { backingScreenId, screenId, backingId }, Fraction = newEnemy.BarXScale })
	
	UpdateHealthBarIcons( newEnemy )
end

function CreateScorchHealthBar( newEnemy )
	-- Burn health bar
	if newEnemy.ScorchHealthBarId ~= nil then
		return
	end
	if newEnemy.UseBossHealthBar then
		return
	end
	if not newEnemy.HasHealthBar then
		return
	end
	local offsetY = ConstantsData.DefaultHealthBarOffsetY
	if newEnemy.Scale ~= nil then
		offsetY = offsetY * newEnemy.Scale
	end
	if newEnemy.HealthBarOffsetY then
		offsetY = newEnemy.HealthBarOffsetY
	end
	local attachToMarkerName = newEnemy.HealthBarAttachToMarkerName
	if newEnemy.IsPolymorphed then
		attachToMarkerName = nil
	end
	newEnemy.ScorchHealthBarId = SpawnObstacle({ Name = "EnemyHealthBarFill", Group = "Combat_UI_World_Backing", DestinationId = newEnemy.ObjectId,
		Attach = true, AttachToMarkerName = attachToMarkerName,
		OffsetY = offsetY, TriggerOnSpawn = false })
	if newEnemy.MaxHealth and newEnemy.Health < newEnemy.MaxHealth then
		SetAnimationFrameTarget({ Name = newEnemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1 - (newEnemy.Health / newEnemy.MaxHealth), DestinationId = newEnemy.ScorchHealthBarId, Instant = true })
	end
	SetColor({ Id = newEnemy.ScorchHealthBarId, Color = Color.HealthScorch })
	SetScaleX({ Id = newEnemy.ScorchHealthBarId, Fraction = newEnemy.BarXScale })
end

function UpdateHealthBarIcons( enemy )
	if not EnemyHealthDisplayAnchors[enemy.ObjectId] then
		return
	end
	local hitShields = enemy.HitShields or 0
	local maxHitShields = enemy.MaxHitShields
	local shieldIcons = EnemyHealthDisplayAnchors[enemy.ObjectId.."shieldIcons"]
	local displayedShields = 0
	if shieldIcons ~= nil then	
		displayedShields = TableLength( shieldIcons )
	end

	local healthBarLength = 620
	local shieldIconSpacer = 20
	local armorIconOffsetX = 0
	local bossHealthBarOffsetX = 0
	local bossHealthBarOffsetY = 0

	local targetLayer = "Combat_UI_World"
	local iconScale = 1
	if enemy.UseBossHealthBar then
		targetLayer = "Combat_Menu"
		iconScale = 1.5
		shieldIconSpacer = 32
		if enemy.BarXScale then
			healthBarLength = healthBarLength * enemy.BarXScale
		end
	else
		if enemy.BarXScale then
			healthBarLength = 98 * enemy.BarXScale
		end
	end

	if enemy.HealthBuffer and enemy.HealthBuffer > 0 then
		if EnemyHealthDisplayAnchors[enemy.ObjectId.."armorIcon"] == nil then
			local healthBarLength = 98 * enemy.BarXScale
			local barPipId = SpawnObstacle({ Name = "EnemyArmorIcon", Group = "Combat_UI_World", DestinationId = EnemyHealthDisplayAnchors[enemy.ObjectId], Attach = true, OffsetX = -healthBarLength/2 + 5, OffsetY = -15 })
			EnemyHealthDisplayAnchors[enemy.ObjectId.."armorIcon"] = barPipId
			armorIconOffsetX = 20
		end
	else
		local armorId = EnemyHealthDisplayAnchors[enemy.ObjectId.."armorIcon"]
		if armorId ~= nil then
			table.insert( SessionMapState.DestroyRequests, armorId )
		end
	end

	if displayedShields ~= hitShields then
		if displayedShields < hitShields then
			if not shieldIcons then
				EnemyHealthDisplayAnchors[enemy.ObjectId.."shieldIcons"] = {}
				shieldIcons = EnemyHealthDisplayAnchors[enemy.ObjectId.."shieldIcons"]
			end
			for i = displayedShields + 1, hitShields do
				local barPipId = nil
				if not enemy.UseBossHealthBar then
					barPipId = SpawnObstacle({ Name = "EnemyShieldIcon", Group = targetLayer })
				else
					barPipId = CreateScreenComponent({ Name = "EnemyShieldIcon", Group = targetLayer}).Id
					bossHealthBarOffsetX = -20
					bossHealthBarOffsetY = 15
				end
				Attach({ Id = barPipId, DestinationId = EnemyHealthDisplayAnchors[enemy.ObjectId], OffsetX = -healthBarLength/2 + (i - 0.5) * shieldIconSpacer + armorIconOffsetX + bossHealthBarOffsetX, OffsetY = -15 + bossHealthBarOffsetY })
				SetScale({ Id = barPipId, Fraction = iconScale })
				table.insert(shieldIcons, barPipId)
			end
		else
			for i = hitShields + 1, displayedShields do
				RemoveHitShieldPresentation( shieldIcons[i] )
				Destroy({Id = shieldIcons[i]})
				shieldIcons[i] = nil
			end
		end
	end
end

function UpdateHealthBar( enemy, damageAmount, damageEventArgs )
	if damageAmount == nil then
		damageAmount = 0
	end
	if damageAmount == 0 and not damageEventArgs.Force then
		return
	end
	local key = enemy.ObjectId or enemy.Name
	local screenId = EnemyHealthDisplayAnchors[key]
	local falloffId = EnemyHealthDisplayAnchors[key.."falloff"]
	local scorchId = enemy.ScorchHealthBarId
	if enemy.UseGroupHealthBar and CurrentRun.CurrentRoom.Encounter ~= nil then
		screenId = EnemyHealthDisplayAnchors[CurrentRun.CurrentRoom.Encounter.Name]
		scorchId = EnemyHealthDisplayAnchors[CurrentRun.CurrentRoom.Encounter.Name.."scorch"]
	end
	if screenId == nil then
		return
	end
	
	-- NOTE(Dexter) Performance: Queue this up to DeferredCombatPresentation()
	CombatPresentationDeferredHealthBars[key] = { enemy, screenId, falloffId, scorchId }
end

function UpdateGroupHealthBarReal( args )
	local enemy = args[1]
	local screenId = args[2]
	local encounter = CurrentRun.CurrentRoom.Encounter
	local encounterData = EncounterData[encounter.Name] or encounter
	local backingScreenId = EnemyHealthDisplayAnchors[encounter.Name.."falloff"]
	local scorchId = EnemyHealthDisplayAnchors[encounter.Name.."scorch"]

	local maxHealth = encounter.GroupMaxHealth
	local currentHealth = 0
	local predictedHealth = 0
	for k, unitId in pairs(encounter.HealthBarUnitIds) do
		local unit = ActiveEnemies[unitId]
		if unit ~= nil then
			currentHealth = currentHealth + unit.Health
			if unit.ActiveEffects and unit.ActiveEffects.BurnEffect and not MapState.GroupHealthWaiters[unitId] and not unit.InTransition then
				if unit.AIEndHealthThreshold and (unit.Health - unit.ActiveEffects.BurnEffect)/unit.MaxHealth < unit.AIEndHealthThreshold then
					predictedHealth = predictedHealth + unit.MaxHealth * unit.AIEndHealthThreshold 
				else
					predictedHealth = predictedHealth + math.max( 0, unit.Health - unit.ActiveEffects.BurnEffect )
				end
			else
				predictedHealth = predictedHealth + unit.Health
			end
		end
	end
	encounter.GroupHealth = currentHealth

	local healthFraction = currentHealth / maxHealth
	local predictedHealthFraction = predictedHealth / maxHealth
	CurrentRun.BossHealthBarRecord[encounterData.GroupHealthBarRecordName or encounter.Name] = healthFraction
	-- is screenid correct? i don't think it is
	SetAnimationFrameTarget({ Name = encounter.HealthBarFill or "EnemyHealthBarFill", Fraction = 1 - predictedHealthFraction, DestinationId = screenId, Instant = true })
	SetAnimationFrameTarget({ Name = encounter.HealthBarFill or "EnemyHealthBarFill", Fraction = 1 - healthFraction, DestinationId = scorchId, Instant = true })	

	thread( UpdateGroupHealthBarFalloff, encounter )
end

function UpdateHealthBarReal( args )

	local enemy = args[1]

	if enemy.UseGroupHealthBar then
		UpdateGroupHealthBarReal( args )
		return
	end

	local screenId = args[2]
	local falloffId = args[3]
	local scorchId = args[4]

	if enemy.IsDead then
		if enemy.UseBossHealthBar then
			CurrentRun.BossHealthBarRecord[enemy.Name] = 0
		end
		SetAnimationFrameTarget({ Name = enemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1, DestinationId = screenId, Instant = true })
		if scorchId ~= nil then
			SetAnimationFrameTarget({ Name = enemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1, DestinationId = scorchId, Instant = true })
		end
		return
	end

	local maxHealth = enemy.MaxHealth
	local currentHealth = enemy.Health
	if currentHealth == nil then
		currentHealth = maxHealth
	end

	UpdateHealthBarIcons( enemy )

	if enemy.UseBossHealthBar then
		if enemy.HealthBarLoading then
			return
		end
		local displayedHealthPercent = currentHealth / maxHealth
		local predictedHealthPercent = displayedHealthPercent
		if enemy.ActiveEffects and enemy.ActiveEffects.BurnEffect and not enemy.InTransition then
			predictedHealthPercent = math.max(0, currentHealth - enemy.ActiveEffects.BurnEffect ) / maxHealth
			if enemy.AIEndHealthThreshold and predictedHealthPercent < enemy.AIEndHealthThreshold then
				predictedHealthPercent = enemy.AIEndHealthThreshold
			end
		end

		CurrentRun.BossHealthBarRecord[enemy.Name] = displayedHealthPercent
		SetAnimationFrameTarget({ Name = enemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1 - predictedHealthPercent, DestinationId = screenId, Instant = true })
		SetAnimationFrameTarget({ Name = enemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1 - displayedHealthPercent, DestinationId = scorchId, Instant = true })
		if enemy.HitShields > 0 then
			SetColor({ Id = screenId, Color = Color.HitShield })
		else
			SetColor({ Id = screenId, Color = Color.Red })
		end
		thread( UpdateBossHealthBarFalloff, enemy )
		return
	end

	local displayedHealthPercent = 1
	local predictedHealthPercent = 1

	if enemy.SummonHealthBarEffect then
		if enemy.HealthBuffer ~= nil and enemy.HealthBuffer > 0 then
			SetColor({ Id = screenId, Color = Color.AlliedArmorHealthBar })
		else
			SetColor({ Id = screenId, Color = Color.AlliedHealthBar })
		end
		SetColor({ Id = falloffId, Color = Color.HealthBufferFalloff })
	elseif enemy.Charmed then
		SetColor({ Id = screenId, Color = Color.CharmHealth })
		SetColor({ Id = falloffId, Color = Color.HealthBufferFalloff })
	else
		if enemy.HitShields ~= nil and enemy.HitShields > 0 then
			SetColor({ Id = screenId, Color = Color.HitShield })
		elseif enemy.HealthBuffer ~= nil and enemy.HealthBuffer > 0 then
			SetColor({ Id = screenId, Color = Color.HealthBuffer })
			SetColor({ Id = falloffId, Color = Color.HealthBufferFalloff })
		else
			SetColor({ Id = screenId, Color = Color.Red })
			SetColor({ Id = falloffId, Color = Color.HealthFalloff })
		end
	end

	if enemy.HitShields ~= nil and enemy.HitShields > 0 then
		displayedHealthPercent = 1
		predictedHealthPercent = 1
	elseif enemy.HealthBuffer ~= nil and enemy.HealthBuffer > 0 then
		displayedHealthPercent = enemy.HealthBuffer / enemy.MaxHealthBuffer
		if enemy.ActiveEffects and enemy.ActiveEffects.BurnEffect then
			predictedHealthPercent = math.max(0, enemy.HealthBuffer - enemy.ActiveEffects.BurnEffect ) / enemy.MaxHealthBuffer
		else
			predictedHealthPercent = displayedHealthPercent
		end
	else
		displayedHealthPercent = currentHealth / maxHealth
		if enemy.ActiveEffects and enemy.ActiveEffects.BurnEffect then
			predictedHealthPercent = math.max(0, currentHealth - enemy.ActiveEffects.BurnEffect ) / maxHealth
		else
			predictedHealthPercent = displayedHealthPercent
		end
	end
	enemy.DisplayedHealthFraction = displayedHealthPercent
	SetAnimationFrameTarget({ Name = enemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1 - predictedHealthPercent, DestinationId = screenId, Instant = true })
	if scorchId ~= nil then
		SetAnimationFrameTarget({ Name = enemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1 - displayedHealthPercent, DestinationId = scorchId, Instant = true })
	end
	thread( UpdateEnemyHealthBarFalloff, enemy, falloffId )
end

function UpdateBossHealthBarFalloff( enemy )
	if SetThreadWait( "EnemyHealthBarFalloff"..enemy.ObjectId, CombatUI.HealthBarFalloffDelay ) then
		return
	end
	wait( CombatUI.HealthBarFalloffDelay, "EnemyHealthBarFalloff"..enemy.ObjectId )
	if enemy and not enemy.IsDead then
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlowBoss", Fraction = 1 - enemy.Health / enemy.MaxHealth, DestinationId = EnemyHealthDisplayAnchors[enemy.ObjectId .. "falloff"] })
	end
end

function UpdateGroupHealthBarFalloff( encounter )
	if SetThreadWait( "EnemyHealthBarFalloff"..encounter.Name, CombatUI.HealthBarFalloffDelay ) then
		return
	end
	wait( CombatUI.HealthBarFalloffDelay, "EnemyHealthBarFalloff"..encounter.Name )
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlowBoss", Fraction = 1 - encounter.GroupHealth / encounter.GroupMaxHealth, DestinationId = EnemyHealthDisplayAnchors[encounter.Name .. "falloff"] })
end

function UpdateEnemyHealthBarFalloff( enemy, falloffId )
	if not enemy.IsDead and not enemy.HealthBarFalloffShown then
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlow", Fraction = 0, DestinationId = falloffId, Instant = true })
		enemy.HealthBarFalloffShown = true
	end

	if SetThreadWait( "EnemyHealthBarFalloff"..enemy.ObjectId, CombatUI.HealthBarFalloffDelay ) then
		return
	end
	wait( CombatUI.HealthBarFalloffDelay, "EnemyHealthBarFalloff"..enemy.ObjectId )
	if not enemy.IsDead then
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlow", Fraction = 1 - enemy.DisplayedHealthFraction, DestinationId = EnemyHealthDisplayAnchors[enemy.ObjectId .. "falloff"] })
	end
end

function UpdatedBossHealthBarRecord( victim, attacker, args )
	if victim.IsDead then
		CurrentRun.BossHealthBarRecord[victim.Name] = 0
	else
		local healthPercent = victim.Health / victim.MaxHealth
		CurrentRun.BossHealthBarRecord[victim.Name] = healthPercent
	end
end

function RemoveHitShieldPresentation( iconId )
	CreateAnimation({ Name = "SkillProcFeedbackFx_HitShieldRemoved", DestinationId = iconId, GroupName = "Overlay" })
end

function RemoveEnemyUI( enemy )
	local enemyId = enemy.ObjectId

	if enemy.HasHealthBar then
		thread( RemoveEnemyHealthBar, enemy )
	end

	if enemy.UseBossHealthBar and ScreenAnchors.BossHealthTitles ~= nil then
		DestroyTextBox({ Id = ScreenAnchors.BossHealthTitles[enemy.ObjectId] })
		ScreenAnchors.BossHealthTitles[enemy.ObjectId] = nil
	end

	local encounter = enemy.Encounter or CurrentRun.CurrentRoom.Encounter
	if enemy.GroupHealthBarOwner then
		notifyExistingWaiters(encounter.Name.."GroupHealthBarDead")
	elseif enemy.UseGroupHealthBar then
		local anyAlive = false
		for k, id in pairs(encounter.HealthBarUnitIds) do
			if id ~= enemy.ObjectId and ActiveEnemies[id] ~= nil then
				anyAlive = true
				break
			end
		end
		if not anyAlive then
			notifyExistingWaiters(encounter.Name.."GroupHealthBarDead")
		end
	end
end

function RecreateEnemyUI( enemy )
	CreateHealthBar( enemy )
	RecreateEffectVfx( enemy )
	UpdateHealthBar( enemy, 0, { Force = true } )
	for activeEffectName, stacks in pairs( enemy.ActiveEffects ) do
		UpdateEffectStacks( enemy, activeEffectName )
	end
end

function RemoveEnemyHealthBar( enemy )
	if enemy.RemovingHealthBar then
		return
	end
	enemy.RemovingHealthBar = true

	local enemyId = enemy.ObjectId
	if EnemyHealthDisplayAnchors[enemyId.."elitebadge"] then
		Destroy({ Id = EnemyHealthDisplayAnchors[enemyId.."elitebadge"]})
	end
	if EnemyHealthDisplayAnchors[enemyId.."bountybadge"] then
		Destroy({ Id = EnemyHealthDisplayAnchors[enemyId.."bountybadge"]})
	end
	if enemy.EliteAttributes ~= nil then
		for k, attributeName in pairs(enemy.EliteAttributes) do
			if EnemyHealthDisplayAnchors[enemyId.."elitebadge"..attributeName] then
				Destroy({ Id = EnemyHealthDisplayAnchors[enemyId.."elitebadge"..attributeName] })
			end
		end
	end

	local toDestroy = {}
	table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId] )
	table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."back"] )
	table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."health"] )
	table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."armorIcon"] )
	table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."vulnerabilityIndicator"] )
	if enemy.ScorchHealthBarId ~= nil then
		table.insert( toDestroy, enemy.ScorchHealthBarId )
	end
	table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."falloff"] )
	if EnemyHealthDisplayAnchors[enemyId.."status"] ~= nil then
		for k, v in pairs( EnemyHealthDisplayAnchors[enemyId.."status"] ) do
			table.insert( toDestroy, v )
		end
	end
	
	if enemy.CreatedDisplayAnchors ~= nil then
		for _, id in pairs( enemy.CreatedDisplayAnchors ) do
			table.insert( toDestroy, id )
		end
		enemy.CreatedDisplayAnchors = {}
	end
	enemy.EffectTextBoxes = {}
	if EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] ~= nil then
		for k, v in pairs( EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] ) do
			table.insert( toDestroy, v )
		end
	end

	if enemy.ActiveEffects ~= nil then
		for effectName in pairs( enemy.ActiveEffects ) do
			local effectData = EffectData[effectName]
			if  effectData ~= nil then
				if effectData.Vfx ~= nil then
					StopAnimation({ Name = effectData.Vfx, DestinationId = enemy.ObjectId })
				end
				if effectData.BackVfx ~= nil then
					StopAnimation({ Name = effectData.BackVfx, DestinationId = enemy.ObjectId })
				end
				if effectData.StopVfxes ~= nil then
					StopAnimation({ Names = effectData.StopVfxes, DestinationId = enemy.ObjectId })
				end
				if effectData.StopVfxesPreventChain ~= nil then
					StopAnimation({ Names = effectData.StopVfxesPreventChain, DestinationId = enemy.ObjectId, PreventChain = true})
				end
				if effectData.ShowDuration and effectData.DisplaySuffix then
					table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId..effectData.DisplaySuffix.."timer"] )
					EnemyHealthDisplayAnchors[enemyId..effectData.DisplaySuffix.."timer"] = nil
				end
			end
		end
	end
	DestroyTextBox({ Ids = toDestroy })

	wait( CombatUI.DeathHoldDuration, RoomThreadName )
	SetScaleY({ Ids = toDestroy, Fraction = 0, Duration = 0.15 })
	if EnemyHealthDisplayAnchors[enemyId.."health"] ~= nil then
		SetScaleX({ Id = EnemyHealthDisplayAnchors[enemyId.."health"], Fraction = 0, Duration = 0.0 })
	end
	if enemy.ScorchHealthBarId ~= nil then
		SetScaleX({ Id = enemy.ScorchHealthBarId, Fraction = 0, Duration = 0.0 })
	end
	if EnemyHealthDisplayAnchors[enemyId.."back"] ~= nil then
		SetScaleX({ Id = EnemyHealthDisplayAnchors[enemyId.."back"], Fraction = enemy.BarXScale * 1.4, Duration = 0.15 })
	end
	if EnemyHealthDisplayAnchors[enemyId.."falloff"] ~= nil then
		SetScaleX({ Id = EnemyHealthDisplayAnchors[enemyId.."falloff"], Fraction = enemy.BarXScale * 1.4, Duration = 0.15 })
	end

	EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] = nil
	EnemyHealthDisplayAnchors[enemyId] = nil
	EnemyHealthDisplayAnchors[enemyId.."back"] = nil
	EnemyHealthDisplayAnchors[enemyId.."health"] = nil
	EnemyHealthDisplayAnchors[enemyId.."armorIcon"] = nil
	EnemyHealthDisplayAnchors[enemyId.."vulnerabilityIndicator"] = nil
	enemy.ScorchHealthBarId = nil
	EnemyHealthDisplayAnchors[enemyId.."falloff"] = nil

	wait( 0.15, RoomThreadName )
	Destroy({ Ids = toDestroy })
	enemy.HasHealthBar = false
	enemy.RemovingHealthBar = false
end

function RecreateEffectVfx( enemy )

	if enemy.ActiveEffects then
		for effectName in pairs( enemy.ActiveEffects ) do
			local effectData = EffectData[effectName]
			if  effectData ~= nil and ( not effectData.VfxRequireKey or enemy[effectData.VfxRequireKey] )then
				if effectData.Vfx ~= nil then
					CreateAnimation({ Name = effectData.Vfx, DestinationId = enemy.ObjectId, OffsetZ = enemy.EffectVfxOffsetZ, Scale = enemy.EffectVfxScale })
				end
				if effectData.BackVfx ~= nil then
					CreateAnimation({ Name = effectData.BackVfx, DestinationId = enemy.ObjectId, OffsetZ = enemy.EffectVfxOffsetZ, Scale = enemy.EffectVfxScale })
				end
			end
		end
	end
end

Using "HealthBarArmorShatter"
Using "ArmorBreak"
function ArmorBreakPresentation( enemy )

	local offsetY = ConstantsData.DefaultHealthBarOffsetY
	if enemy.Scale ~= nil then
		offsetY = offsetY * enemy.Scale
	end
	if enemy.HealthBarOffsetY then
		offsetY = enemy.HealthBarOffsetY - 18
	end

	SetAnimation({ DestinationId = EnemyHealthDisplayAnchors[enemy.ObjectId.."back"], Name = "EnemyHealthBar" })
	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof", Id = enemy.ObjectId, ManagerCap = 36 })
	CreateAnimations({
		DestinationId = enemy.ObjectId,
		Anims =
		{
			{ Name = "HealthBarArmorShatter", OffsetY = offsetY - 35 },
			{ Name = "ArmorBreak" }
		}
	})

	table.insert( SessionMapState.PresentationQueue, { FunctionName = "ArmorBreakPresentationQueue", Source = enemy, Threaded = true } )
end

function ArmorBreakPresentationQueue( enemy )
	local offsetY = ConstantsData.DefaultHealthBarOffsetY
	if enemy.Scale ~= nil then
		offsetY = offsetY * enemy.Scale
	end
	if enemy.HealthBarOffsetY then
		offsetY = enemy.HealthBarOffsetY - 18
	end
	local promptId = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", Group = "Combat_UI_World", DestinationId = enemy.ObjectId, OffsetY = offsetY })
	SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = promptId})
	Attach({ Id = promptId, DestinationId = enemy.ObjectId, OffsetY = offsetY })
	CreateTextBox({	Id = promptId, Text = "ArmorBreak", Justification = "CENTER",
		ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		Font = "LatoBoldItalic", FontSize = 18, Color = {255,255,255,255},
		CharacterFadeTime = 0, CharacterFadeInterval = 0, Group = "Combat_UI_World",
		AutoSetDataProperties = false,
		ScaleTarget = 6.2, ScaleDuration = 10,
		})
	Move({ Id = promptId, Distance = 100, Angle = 0, Duration = 1, EaseOut = 1, TimeModifierFraction = 0 })

	waitUnmodified( 0.5 )
	ModifyTextBox({ Id = promptId, FadeTarget = 0.0, FadeDuration = 0.4, ColorTarget = {1, 0, 0, 1}, ColorDuration = 0.5, AutoSetDataProperties = false })
	waitUnmodified( 1.0 )
	Destroy({ Id = promptId })
end

-- Death Defiance presentation
function PlayerLastStandPresentationStart( args )
	wait( 0.06, RoomThreadName )
	local secondChanceFxInTime = 0.08

	-- put up screen vfx
	ScreenAnchors.LastStandVignette = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	CreateAnimation({ Name = "LastStandVignette", DestinationId = ScreenAnchors.LastStandVignette })
	AdjustColorGrading({ Name = "DeathDefianceSubtle", Duration = secondChanceFxInTime })

	RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "Combat_Menu", DrawGroup = true })
	
	local lastStandAnim = CurrentRun.Hero.LastStandAnimationOverride or "Melinoe_GetHit_LastStand" 
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = lastStandAnim })

	-- camera
	if IsEmpty(SessionMapState.LockCameraMotion) then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.01 })
		FocusCamera({ Fraction = 1.03, Duration = 0.045, ZoomType = "Ease" })
	end

	-- pause the game
	AddSimSpeedChange( "LastStand", { Fraction = 0.005, LerpTime = 0.0001, Priority = true } )

	-- play voiceover
	thread( PlayerLastStandVoicelines, args )
	thread( PlayerLastStandSFX )
	waitUnmodified( 0.3, RoomThreadName )

	-- pop the death defiance
	LostLastStandPresentation()
	UpdateLifePips()
	thread( PlayerLastStandProcText, args )

	waitUnmodified( 1.1, RoomThreadName )

end

function PlayerLastStandProcText( args )
	waitUnmodified(  0.2 )
	if args.InfiniteDeathDefiance  then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_ExtraChance_Special_A", 0.9, { ShadowScale = 0.66, OffsetY = 75 } )	
	elseif args.HasLastStand or not CurrentRun.Hero.MaxLastStands or CurrentRun.Hero.MaxLastStands == 1 or SessionMapState.InfiniteDeathDefiance then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_ExtraChance", 0.9, { ShadowScale = 0.66, OffsetY = 75 } )	
	else
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_LastChance", 0.9, { ShadowScale = 0.66, OffsetY = 75 } )
		PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteFiredUpLASTCHANCE", Delay = 0.5 })
	end
end

function PlayerLastStandPresentationEnd()
	RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Names = { "Combat_Menu" } })
	AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "Standing", DrawGroup = true })
	SetPlayerDarkside( "LastStand" )
	local secondChanceFxOutTime = 0.4
	AdjustRadialBlurStrength({ Fraction = 0, Duration = secondChanceFxOutTime  })
	AdjustFrame({ Duration = secondChanceFxOutTime, Fraction = 0 })
	RemoveSimSpeedChange( "LastStand", { LerpTime = secondChanceFxOutTime } )
	AdjustFullscreenBloom({ Name = "DeathDefiance", Duration = secondChanceFxOutTime * 0.1 })

	SetAlpha({ Id = ScreenAnchors.LastStandVignette, Fraction = 0, Duration = 0.06 })
	if CurrentRun.Hero.LastStandTimeMultiplier then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1/CurrentRun.Hero.LastStandTimeMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "HeroTeam" } })
		CurrentRun.Hero.LastStandTimeMultiplier = nil
	end

	if IsEmpty(SessionMapState.LockCameraMotion) then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = secondChanceFxOutTime, ZoomType = "Ease" })
	end

	AdjustColorGrading({ Name = "None", Duration = secondChanceFxOutTime })

	thread( function()
		wait( secondChanceFxOutTime * 0.1 )
		AdjustFullscreenBloom({ Name = "Off", Duration = secondChanceFxOutTime * 0.5, })
	end )

end

function PlayerLastStandVoicelines( args )
	if args.HasLastStand or GetNumMetaUpgradeLastStands() <= 1 then
		PlayVoiceLines( HeroVoiceLines.LastStandVoiceLines, true, CurrentRun.Hero, args )
	else
		if args.LastStandUsed and args.LastStandUsed.Name and HeroVoiceLines.UniqueLastStandSourcesLookup[args.LastStandUsed.Name] and CoinFlip() then
			PlayVoiceLines( HeroVoiceLines.LastStandVoiceLines, true, CurrentRun.Hero, args )
		else
			PlayVoiceLines( HeroVoiceLines.LastStandLastLifeVoiceLines, nil, CurrentRun.Hero, args )
		end
	end
	for k, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if enemy.LastStandReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.LastStandReactionVoiceLines, true, enemy )
		end
	end
end
function PlayerInfiniteLastStandVoicelines( args )
	CurrentRun.Hero.Mute = false
	PlayVoiceLines( HeroVoiceLines.InfiniteLastStandVoiceLines, nil, CurrentRun.Hero, args )
	CurrentRun.Hero.Mute = true
	for k, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if enemy.LastStandReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.LastStandReactionVoiceLines, true, enemy )
		end
	end
end

function PlayerLastStandHealingText( args )
	waitUnmodified(  0.2 )
	PlaySound({ Name = "/Leftovers/SFX/StaminaSkillProc", Id = CurrentRun.Hero.ObjectId })
	OnPlayerHealed( CurrentRun.Hero, { ActualHealAmount = CurrentRun.Hero.Health } )
	CreateAnimation({ Name = "LastStandHealthBarRefillFlare", DestinationId = HUDScreen.Components.HealthBack.Id, Group = "Combat_Menu_Additive", OffsetY = -12, OffsetX = 40 })
end

function PlayerLastStandManaGainText( args )
	if args.Delay then
		waitUnmodified( args.Delay )
	end
	thread(PopOverheadText, {Amount = args.Amount, Text = "HealingAmount", Color = Color.RoyalBlue, SkipShadow = true, OffsetY = 40 })
end

function PlayerInfiniteLastStandSFX()
	PlaySound({ Name = "/SFX/DeathDefianceActivate", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCastNoPoof", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHowlSlam", Id = CurrentRun.Hero.ObjectId })
end

function PlayerLastStandSFX()
	local currentRun = CurrentRun
	local hasLastStand = HasLastStand( CurrentRun.Hero )
	if hasLastStand then
		PlaySound({ Name = "/SFX/DeathDefianceActivate", Id = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteChargingAxe", Id = CurrentRun.Hero.ObjectId })
	else
		PlaySound({ Name = "/SFX/DeathDefianceActivate", Id = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteChargingAxe", Id = CurrentRun.Hero.ObjectId })
	end
end

function PlayerLastStandHealingPresentation()
	CurrentRun.Hero.LastStandTimeMultiplier = 4.5
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 4.5, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "HeroTeam" } })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmotePoweringUp", Id = CurrentRun.Hero.ObjectId })
	local lastStandAnim = CurrentRun.Hero.LastStandFireAnimationOverride or "Melinoe_LastStand_Fire" 
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = lastStandAnim })
	CreateAnimation({ Name = "DeathDefianceShockwave", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayerLastStandHealingText, args )
end


function UseLastStandDropPresentation( args )
	CreateAnimation({ Name = args.HeroFx or "LastStandFxBurst", DestinationId = CurrentRun.Hero.ObjectId })
end

function GainLastStandPresentation( index )
	if not index then
		index = TableLength( CurrentRun.Hero.LastStands )
	end
	if not ScreenAnchors.LifePipIds then
		return
	end
	CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = ScreenAnchors.LifePipIds[ index ], GroupName = "Overlay" })
end

function LostLastStandPresentation( )
	if not ScreenAnchors.LifePipIds then
		return
	end
	local index = TableLength( CurrentRun.Hero.LastStands )
	if not SessionMapState.InfiniteDeathDefiance then
		-- This is already somehwat inaccurate but let's just mute this since any issues are exacerbated during the infinite death defiance
		CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = ScreenAnchors.LifePipIds[ index ], GroupName = "Overlay" })
	end
end

-- Engraved Pin / Moros Keepsake / BlockDeathPresentation
function BlockDeathLastStandPresentationStart( args )
	wait( 0.06, RoomThreadName )
	local secondChanceFxInTime = 0.08

	-- play VO
	thread( PlayerBlockDeathVoicelines, args )

	-- put up screen vfx
	ScreenAnchors.LastStandVignette = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	CreateAnimation({ Name = "LastStandVignette", DestinationId = ScreenAnchors.LastStandVignette })
	AdjustColorGrading({ Name = "Miasma", Duration = secondChanceFxInTime })
	RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "Combat_Menu", DrawGroup = true })
	local lastStandAnim = CurrentRun.Hero.LastStandAnimationOverride or "Melinoe_GetHit_LastStand" 
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = lastStandAnim })

	-- camera
	if IsEmpty(SessionMapState.LockCameraMotion) then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.01 })
		FocusCamera({ Fraction = 1.03, Duration = 0.045, ZoomType = "Ease" })
	end

	-- pause the game
	AddSimSpeedChange( "LastStand", { Fraction = 0.005, LerpTime = 0.0001, Priority = true } )

	-- play sfx
	thread( PlayerLastStandSFX )
	waitUnmodified( 0.3, RoomThreadName )

	-- pop the death defiance
	LostLastStandPresentation()
	UpdateLifePips()
	thread( PlayerBlockDeathProcText, args )

	waitUnmodified( 1.1, RoomThreadName )

end

function PlayerBlockDeathProcText( args )
	waitUnmodified(  0.2 )
	thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_BlockedDeath", 0.9, { ShadowScale = 0.66, OffsetY = 75 } )	
end

function BlockDeathLastStandPresentationEnd()
	RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Names = { "Combat_Menu" } })
	AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "Standing", DrawGroup = true })
	local secondChanceFxOutTime = 0.4
	AdjustRadialBlurStrength({ Fraction = 0, Duration = secondChanceFxOutTime  })
	AdjustFrame({ Duration = secondChanceFxOutTime, Fraction = 0 })
	RemoveSimSpeedChange( "LastStand", { LerpTime = secondChanceFxOutTime } )
	AdjustFullscreenBloom({ Name = "DeathDefiance", Duration = secondChanceFxOutTime * 0.1 })

	SetAlpha({ Id = ScreenAnchors.LastStandVignette, Fraction = 0, Duration = 0.06 })
	if CurrentRun.Hero.LastStandTimeMultiplier then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1/CurrentRun.Hero.LastStandTimeMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "HeroTeam" } })
		CurrentRun.Hero.LastStandTimeMultiplier = nil
	end

	if IsEmpty(SessionMapState.LockCameraMotion) then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = secondChanceFxOutTime, ZoomType = "Ease" })
	end

	AdjustColorGrading({ Name = "None", Duration = secondChanceFxOutTime })

	thread( function()
		wait( secondChanceFxOutTime * 0.1 )
		AdjustFullscreenBloom({ Name = "Off", Duration = secondChanceFxOutTime * 0.5, })
	end )

end

function StartBlockDeathPresentation( tollTimes )
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteFiredUpLASTCHANCE", Delay = 0.5 })
	thread( InCombatTextArgs, 
		{
			TargetId = CurrentRun.Hero.ObjectId, 
			Text = "Hint_BlockDeath", 
			Duration = 1.5, 
			ShadowScaleX = 1.4,
			LuaKey = "TooltipData", 
			LuaValue = { SecondsLeft = tollTimes }
		})
	local shieldTrait = GetExistingUITraitName( "BlockDeathKeepsake" )
	if shieldTrait then
		TraitUIDeactivateTrait( shieldTrait )
		TraitUIActivateTrait( shieldTrait, { CustomAnimation = "ActiveTraitSingle", PlaySpeed = 30 / tollTimes })
	end
end

GlobalVoiceLines.MorosCountdownVoiceLines =
{
	BreakIfPlayed = true,
	Source = { LineHistoryName = "NPC_Moros_01", SubtitleColor = Color.MorosVoice },
	Queue = "Interrupt",

	{ Cue = "/VO/Moros_0254", Text = "Ten.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 10,
			}
		},
	},
	{ Cue = "/VO/Moros_0255", Text = "Nine.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 9,
			}
		},
	},
	{ Cue = "/VO/Moros_0256", Text = "Eight.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 8,
			}
		},
	},
	{ Cue = "/VO/Moros_0257", Text = "Seven.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 7,
			}
		},
	},
	{ Cue = "/VO/Moros_0258", Text = "Six.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 6,
			}
		},
	},
	{ Cue = "/VO/Moros_0259", Text = "Five.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 5,
			}
		},
	},
	{ Cue = "/VO/Moros_0260", Text = "Four.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 4,
			}
		},
	},
	{ Cue = "/VO/Moros_0261", Text = "Three.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 3,
			}
		},
	},
	{ Cue = "/VO/Moros_0262", Text = "Two.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 2,
			}
		},
	},
	{ Cue = "/VO/Moros_0263", Text = "One.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 1,
			}
		},
	},
	{ Cue = "/VO/Moros_0264", Text = "Zero.",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "RemainingTolls" },
				Comparison = "==",
				Value = 0,
			}
		},
	},
}
function TickBlockDeathPresentation( source, remainingTolls )
	if remainingTolls == 5 then
		thread( InCombatTextArgs, 
			{
				TargetId = CurrentRun.Hero.ObjectId, 
				Text = "Hint_BlockDeath", 
				Duration = 1.5, 
				LuaKey = "TooltipData", 
				LuaValue = { SecondsLeft = remainingTolls }
			})
	end
	SessionMapState.RemainingTolls = remainingTolls
	thread( PlayVoiceLines, GlobalVoiceLines.MorosCountdownVoiceLines, nil, source )
	thread( HeroicStandPulse, remainingTolls - 1 )
end

function BlockDeathCanceledPresentation( source )
	thread( PlayVoiceLines, GlobalVoiceLines.MorosLastStandSurvivedLines, nil, source )
end

function PlayerBlockDeathVoicelines( args )
	thread( PlayVoiceLines, HeroVoiceLines.BlockDeathVoiceLines, true )
	for k, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if enemy.BlockDeathReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.BlockDeathReactionVoiceLines, true, enemy )
		end
	end
end

function InfiniteLastStandPresentationStart( args )
	wait( 0.06, RoomThreadName )
	local secondChanceFxInTime = 0.08

	-- put up screen vfx
	ScreenAnchors.LastStandVignette = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	CreateAnimation({ Name = "LastStandVignette", DestinationId = ScreenAnchors.LastStandVignette })
	AdjustColorGrading({ Name = "DeathDefianceSubtle", Duration = secondChanceFxInTime })

	RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "Combat_Menu", DrawGroup = true })
	
	local lastStandAnim = CurrentRun.Hero.LastStandAnimationOverride or "Melinoe_GetHit_LastStand" 
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = lastStandAnim })

	-- camera
	if IsEmpty(SessionMapState.LockCameraMotion) then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.01 })
		FocusCamera({ Fraction = 1.03, Duration = 0.045, ZoomType = "Ease" })
	end

	-- pause the game
	AddSimSpeedChange( "LastStand", { Fraction = 0.005, LerpTime = 0.0001, Priority = true } )

	-- play voiceover
	thread( PlayerInfiniteLastStandVoicelines )
	thread( PlayerInfiniteLastStandSFX )
	waitUnmodified( 0.3, RoomThreadName )

	-- pop the death defiance
	LostLastStandPresentation()
	UpdateLifePips()
	thread( PlayerLastStandProcText, args )

	waitUnmodified( 1.1, RoomThreadName )

	CreateAnimation({ Name = "MelInfiniteLastStandFx", DestinationId = CurrentRun.Hero.ObjectId })
end

function InfiniteLastStandPresentationEnd()
	RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Names = { "Combat_Menu" } })
	AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "Standing", DrawGroup = true })
	SetPlayerDarkside( "LastStand" )
	local secondChanceFxOutTime = 0.4
	AdjustRadialBlurStrength({ Fraction = 0, Duration = secondChanceFxOutTime  })
	AdjustFrame({ Duration = secondChanceFxOutTime, Fraction = 0 })
	RemoveSimSpeedChange( "LastStand", { LerpTime = secondChanceFxOutTime } )
	AdjustFullscreenBloom({ Name = "DesaturatedLight", Duration = secondChanceFxOutTime * 0.1 })

	SetAlpha({ Id = ScreenAnchors.LastStandVignette, Fraction = 0, Duration = 0.06 })
	if CurrentRun.Hero.LastStandTimeMultiplier then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1/CurrentRun.Hero.LastStandTimeMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "HeroTeam" } })
		CurrentRun.Hero.LastStandTimeMultiplier = nil
	end

	if IsEmpty(SessionMapState.LockCameraMotion) then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = secondChanceFxOutTime, ZoomType = "Ease" })
	end

	AdjustColorGrading({ Name = "None", Duration = secondChanceFxOutTime })

	thread( function()
		wait( secondChanceFxOutTime * 0.1 )
		AdjustFullscreenBloom({ Name = "Off", Duration = secondChanceFxOutTime * 0.5, })
	end )

end

function LowHealthCombatTextPresentation( unitId, texts )
	local lowHealthFxInTime = 0.4
	local lowHealthFxOutTime = 0.4

	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0.85, Duration = lowHealthFxInTime  })
	AdjustFullscreenBloom({ Name = "DesaturatedLight", Duration = 0 })

	for i, text in pairs( texts ) do
		thread( InCombatText, unitId, text, 1.5 )
		waitUnmodified( 0.2)
	end
	waitUnmodified(  0.75 )

	AdjustRadialBlurStrength({ Fraction = 0, Duration = lowHealthFxOutTime  })
	AdjustFullscreenBloom({ Name = "Off", Duration = lowHealthFxOutTime })
end

function HighHealthCombatTextPresentation( unitId, texts )
	for i, text in pairs( texts ) do
		thread( InCombatText, unitId, text, 1.5 )
		PlaySound({ Name = "/SFX/WrathOver", Id = unitId })
		waitUnmodified( 0.2)
	end
end

function HeraManaRestorePresentation( unitId, text )
	if CheckCooldown( "HeraManaRestorePresentationPlayed", 1.0 ) then
		thread( InCombatText, unitId, text, 1.35 )
	end
	PlaySound({ Name = "/SFX/MagicRefillSFX", Id = unitId })
end

function PerfectClearObjectiveFailedPresentation( run )
	thread( PlayVoiceLines, GlobalVoiceLines.PerfectClearGotHitVoiceLines, true )
end

function CreateLevelDisplay( newEnemy, currentRun )

	if newEnemy.HideLevelDisplay or newEnemy.HasLevelDisplay then
		return
	end
	newEnemy.HasLevelDisplay = true

	local offsetY = -150
	if newEnemy.Scale ~= nil then
		offsetY = offsetY * newEnemy.Scale
	end
	if newEnemy.HealthBarOffsetY then
		offsetY = newEnemy.HealthBarOffsetY
	end

	if not newEnemy.UseBossHealthBar then
		if newEnemy.EliteIcon or ( newEnemy.HealthBuffer ~= nil and newEnemy.HealthBuffer > 0 ) or ( newEnemy.HitShields ~= nil and newEnemy.HitShields > 0 ) or newEnemy.Charmed then
			CreateHealthBar( newEnemy )
			UpdateHealthBar( newEnemy, 0, { Force = true })
		end
	end
	if not newEnemy.HasOutline and newEnemy.Outline ~= nil and newEnemy.HealthBuffer ~= nil and newEnemy.HealthBuffer > 0 then
		newEnemy.Outline.Id = newEnemy.ObjectId
		AddOutline( newEnemy.Outline )
		newEnemy.HasOutline = true
	end
end

function PostEnemyKillPresentation( victim, triggerArgs )

	local currentRoom = CurrentRun.CurrentRoom
	local killer = triggerArgs.AttackerTable

	local sourceProjectileData = nil
	if triggerArgs.SourceProjectile ~= nil then
		sourceProjectileData = ProjectileData[triggerArgs.SourceProjectile]
	end

	if victim.OnKillGlobalVoiceLines ~= nil and (currentRoom.Kills[victim.Name] or 0) >= (victim.KillsRequiredForVoiceLines or 0) then
		thread( PlayVoiceLines, GlobalVoiceLines[victim.OnKillGlobalVoiceLines], true, nil, { Defer = true } )
	end
	if victim.OnKillVoiceLines ~= nil then
		thread( PlayVoiceLines, victim.OnKillVoiceLines, true )
	end
	if victim.MusicStemOff then
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { victim.MusicStem }, Value = 0.0, Duration = 1.0 })
	end
	if victim.DeathVoiceLines ~= nil and not triggerArgs.Silent then
		thread( PlayVoiceLines, victim.DeathVoiceLines, nil, victim )
	end
	if sourceProjectileData ~= nil and sourceProjectileData.KillingEnemyVoiceLines ~= nil and not triggerArgs.Silent then
		thread( PlayVoiceLines, sourceProjectileData.KillingEnemyVoiceLines, true )
	end

	if RequiredKillEnemies[victim.ObjectId] ~= nil and TableLength( RequiredKillEnemies ) > 1 then
		if killer ~= nil and killer.KillingEnemyVoiceLines ~= nil then
			thread( PlayVoiceLines, killer.KillingEnemyVoiceLines, true, killer )
		elseif GameState.LastKilledByName ~= nil and GameState.LastKilledByName == victim.Name then
			thread( KillVoiceLinesQueue, victim, triggerArgs, GlobalVoiceLines.RevengeKillingEnemyVoiceLines )
		elseif not FrameState.KillingEnemyVoiceLines then
			thread( KillVoiceLinesQueue, victim, triggerArgs, GlobalVoiceLines.KillingEnemyVoiceLines )
			FrameState.KillingEnemyVoiceLines = true
		end

		if killer ~= nil and victim ~= nil and victim.ObjectId == killer.KillStealVictimId then
			local killStolenFrom = ActiveEnemies[killer.KillStolenFromId]
			if killStolenFrom ~= nil and killStolenFrom.KillStolenVoiceLines ~= nil then
				thread( PlayVoiceLines, killStolenFrom.KillStolenVoiceLines, nil, killStolenFrom )
			end
		end
	end

	RemoveEnemyUI( victim )

end

function KillVoiceLinesQueue( victim, triggerArgs, voiceLines )
	local threadName = "KillVoiceLines"
	local delay = 0.3
	if SetThreadWait( threadName, delay ) then
		return
	end
	wait( delay, threadName )
	thread( PlayVoiceLines, voiceLines, true )
end

function DoubleStrikePresentation( victim )
	
	if not ConfigOptionCache.ShowDamageNumbers then
		return
	end

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end
	if CheckCooldown( "DoubleStrikePresentation", 0.1 ) then
		PlaySound({ Name = "/SFX/Player Sounds/ApolloBlindStart", Id = victim.ObjectId })
		thread( InCombatTextArgs, { TargetId = victim.ObjectId, Text = "DoubleStrikeText", OffsetY = -220, SkipFlash = true, SkipShadow = true, SkipRise = true, Duration = 0.65, TextColor = { 246, 197, 25, 255 } })
	end
end

function DisplayDamageText( victim, triggerArgs )

	if not ConfigOptionCache.ShowDamageNumbers then
		return
	end

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	local amount = triggerArgs.DamageAmount
	local isCritical = triggerArgs.IsCrit
	local isDoubleDamage = triggerArgs.IsDoubleDamage
	local hitVulnerable = triggerArgs.HitVulnerability
	local sourceId = triggerArgs.AttackerId

	if victim == nil then
		return
	end
	if victim.SkipDamageText then
		return
	end
	if victim.BlockSelfDamageNumbers and sourceId == victim.ObjectId then
		return
	end
	
	if victim.BlockDamageNumbersByGroups and triggerArgs.AttackerTable ~= nil and ContainsAny(triggerArgs.AttackerTable.Groups, victim.BlockDamageNumbersByGroups) and not triggerArgs.ProjectileDeflected and not triggerArgs.AttackerTable.UseUniqueDamageColors then
		return
	end

	if triggerArgs.SourceProjectile ~= nil and ProjectileData[triggerArgs.SourceProjectile] ~= nil and ProjectileData[triggerArgs.SourceProjectile].SkipDamageText then
		return
	end
	
	if triggerArgs.EffectName and EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].SkipDamageText then
		return
	end

	local roundedAmount = round( amount )
	local wallHit = false
	local checkDistance = false
	local damageSourceName = triggerArgs.AttackerName
	local damageProjectileSourceName = triggerArgs.EffectName or triggerArgs.SourceProjectile
	if triggerArgs.EffectName and EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].DistanceCheckDamageNumbers then
		checkDistance = true
	end
	if not triggerArgs.EffectName and triggerArgs.AttackerWeaponData then
		damageProjectileSourceName = GetGenusName(triggerArgs.AttackerWeaponData)
		if triggerArgs.AttackerWeaponData.DamageNumberGenusName then
			damageProjectileSourceName = triggerArgs.AttackerWeaponData.DamageNumberGenusName
		end
	end
	if triggerArgs.AttackerWeaponData and triggerArgs.AttackerWeaponData.CoalesceDoubleDamageNumbersInterval and isDoubleDamage then
		if not SessionMapState.LastDoubleDamageCoalesceTime then
			SessionMapState.LastDoubleDamageCoalesceTime = _worldTimeUnmodified
		end
		if _worldTimeUnmodified - SessionMapState.LastDoubleDamageCoalesceTime < triggerArgs.AttackerWeaponData.CoalesceDoubleDamageNumbersInterval then
			damageProjectileSourceName = damageProjectileSourceName..SessionMapState.LastDoubleDamageCoalesceTime 
		else
			SessionMapState.LastDoubleDamageCoalesceTime = _worldTimeUnmodified
			damageProjectileSourceName = damageProjectileSourceName..SessionMapState.LastDoubleDamageCoalesceTime 
		end
	elseif isCritical or isDoubleDamage or triggerArgs.OverrideDamageTextStartColor then
		damageProjectileSourceName = nil
	end
	if triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] and ProjectileData[triggerArgs.SourceProjectile].BlockCoalesce then
		damageProjectileSourceName = nil
	end
	if triggerArgs.EffectName and EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].BlockCoalesce then
		damageProjectileSourceName = nil
	end

	if CombatUI.DamageTextCoalesceAll then
		damageProjectileSourceName = "AllCoalesce"
	end
	local offsetY = victim.HealthBarOffsetY or -180
	local randomOffsetX = RandomInt( -10, 10 )
	local randomOffsetY = RandomInt( -3, 3 )
	local numValuesPerRow = 3
	local spacerY = 40
	local spacerX = 65

	local damageTextAnchor = nil
	if triggerArgs.EffectName ~= nil and EffectData[triggerArgs.EffectName] then
		if EffectData[triggerArgs.EffectName].DamageOffsetY  then
			offsetY = offsetY + EffectData[triggerArgs.EffectName].DamageOffsetY		
			spacerY = 0
		end
		if EffectData[triggerArgs.EffectName].DamageRandomOffsetX then
			randomOffsetX = RandomInt( -EffectData[triggerArgs.EffectName].DamageRandomOffsetX , EffectData[triggerArgs.EffectName].DamageRandomOffsetX  )	
			spacerX = 0 
		end
	end

	if isCritical or not damageProjectileSourceName then

		local damageIndex = 0
		if ScreenAnchors[victim.ObjectId] and ScreenAnchors[victim.ObjectId].DamageProjectileSpaces then
			damageIndex = #ScreenAnchors[victim.ObjectId].DamageProjectileSpaces
		end

		damageTextAnchor = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", DestinationId = victim.ObjectId, Group = "Combat_UI_World", OffsetX = 0 + randomOffsetX, OffsetY = offsetY  - spacerY * ( 1 + math.floor(( damageIndex - 1 ) / numValuesPerRow )) + randomOffsetY })
	else
		if ScreenAnchors[victim.ObjectId] and ScreenAnchors[victim.ObjectId][damageProjectileSourceName] then
			if not IsEmpty( ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids ) then
				local checkedAnchor = ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids[#ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids]
				if ( not checkDistance or GetDistance({Id = victim.ObjectId, DestinationId = checkedAnchor }) < CombatUI.MaxDamageDistance ) and ScreenAnchors[victim.ObjectId][damageProjectileSourceName].State == "Hold" then
					ScreenAnchors[victim.ObjectId][damageProjectileSourceName].TargetNumber = ScreenAnchors[victim.ObjectId][damageProjectileSourceName].TargetNumber + roundedAmount

					damageTextAnchor = checkedAnchor
					if isDoubleDamage then
						ModifyTextBox({ 
							Id = damageTextAnchor, 
							Text = "CriticalDamageAmount",
							LuaKey = "TempTextData",
							LuaValue = { Amount = ScreenAnchors[victim.ObjectId][damageProjectileSourceName].TargetNumber }, 
							ScaleTarget = 1.1, 
							ScaleDuration = 0 })	
					else
						ModifyTextBox({ Id = damageTextAnchor, Text = ScreenAnchors[victim.ObjectId][damageProjectileSourceName].TargetNumber, ScaleTarget = 1.1, ScaleDuration = 0 })
					end
					thread( PulseCombatText, damageTextAnchor )

					RemoveValue( ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids, damageTextAnchor )
					if not IsEmpty(ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids ) then
						Destroy({Ids = ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids })
					end
					ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids = { damageTextAnchor }
					if SetThreadWait( damageTextAnchor, 0.5 ) then
						return
					end
				end
			end
		end

		if not ScreenAnchors[victim.ObjectId] then
			ScreenAnchors[victim.ObjectId] = {}
		end

		local damageIndex = 0
		if not ScreenAnchors[victim.ObjectId][damageProjectileSourceName] then
			ScreenAnchors[victim.ObjectId][damageProjectileSourceName] = {}
			ScreenAnchors[victim.ObjectId].DamageProjectileSpaces = ScreenAnchors[victim.ObjectId].DamageProjectileSpaces or {}
			table.insert( ScreenAnchors[victim.ObjectId].DamageProjectileSpaces, damageProjectileSourceName )
			damageIndex = #ScreenAnchors[victim.ObjectId].DamageProjectileSpaces
		else
			damageIndex = GetKey( ScreenAnchors[victim.ObjectId].DamageProjectileSpaces, damageProjectileSourceName )
		end
		if not ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids then
			ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids = {}
		end
		ScreenAnchors[victim.ObjectId][damageProjectileSourceName].State = "Hold"
		ScreenAnchors[victim.ObjectId][damageProjectileSourceName].TargetNumber = roundedAmount
		ScreenAnchors[victim.ObjectId][damageProjectileSourceName].DisplayedNumber = roundedAmount
		if not damageTextAnchor then
			local sign = 1
			if damageIndex % 2 == 1 then
				sign = -1
			end
			damageTextAnchor = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", DestinationId = victim.ObjectId, Group = "Combat_UI_World",
				OffsetX = math.floor((( damageIndex - 1) % numValuesPerRow + 1)/ 2 ) * spacerX * sign,
				OffsetY = offsetY - math.floor( ( damageIndex - 1) / numValuesPerRow ) * spacerY
				})
			table.insert( ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids, damageTextAnchor )
		end
	end

	local isSpecialDamage = isCritical or triggerArgs.IsDoubleDamage or triggerArgs.RandomHighRoll
	if isSpecialDamage then
		-- enemy takes critical / backstab / wall slam damage
		local textColor = Color.White
		if wallHit then
			textColor = Color.WallSlamDamageLight
		end
		if triggerArgs.IsDoubleDamage then
			textColor = Color.AresDamageLight
		end
		if triggerArgs.RandomHighRoll then
			textColor = Color.DionysusDamageLight
		end
		local randomFontSize = RandomInt( 56, 62 )
		local text = "CriticalDamageAmount"
		if isCritical and triggerArgs.IsDoubleDamage then
			text = "SuperCriticalDamageAmount"
		end
		CreateTextBox({
			Id = damageTextAnchor,
			Text = text,
			LuaKey = "TempTextData",
			LuaValue = { Amount = roundedAmount },
			Justification = "CENTER",
			ShadowBlur = 2, ShadowColor = {0,0,0,1}, ShadowOffset = {2, 2},
			OutlineThickness = 1, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = textColor,
			Font = "P22UndergroundSCHeavy",
			FontSize = randomFontSize,
			AutoSetDataProperties = false,
			FadeOpacity = 1.0,
		})
	else
		-- enemy is damaged
		local offsetY = 0
		local randomFontSize = RandomInt( 30, 35 )
		randomFontSize = randomFontSize * GetDamageNumberTextScale( roundedAmount )
		local color = {1,1,1}
		if triggerArgs.OverrideDamageTextStartColor then
			color = triggerArgs.OverrideDamageTextStartColor
		elseif triggerArgs.SourceProjectile and SessionMapState.OverrideProjectileStartColor and SessionMapState.OverrideProjectileColorName == triggerArgs.SourceProjectile then
			color = SessionMapState.OverrideProjectileStartColor
		elseif triggerArgs.ProjectileDeflected then
			color = ProjectileData.DeflectedProjectileColor.DamageTextStartColor
		elseif triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] and ProjectileData[triggerArgs.SourceProjectile].DamageTextStartColor then
			color = ProjectileData[triggerArgs.SourceProjectile].DamageTextStartColor
		elseif triggerArgs.AttackerTable ~= nil and triggerArgs.AttackerTable.DamageTextStartColor then
			color = triggerArgs.AttackerTable.DamageTextStartColor
		elseif triggerArgs.EffectName ~= nil and EffectData[triggerArgs.EffectName] then
			if EffectData[triggerArgs.EffectName].DamageTextSize then
				randomFontSize = RandomInt(EffectData[triggerArgs.EffectName].DamageTextSize, EffectData[triggerArgs.EffectName].DamageTextSize + 5 )
			end
			if EffectData[triggerArgs.EffectName].DamageTextStartColor then
				color = EffectData[triggerArgs.EffectName].DamageTextStartColor
			end
			if EffectData[triggerArgs.EffectName].DamageTextSizeOffsetY then
				offsetY = EffectData[triggerArgs.EffectName].DamageTextSizeOffsetY
			end
		end
		CreateTextBox({
			Id = damageTextAnchor,
			RawText = roundedAmount,
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {2, 2},
			OutlineThickness = 1, OutlineColor = {0,0,0},
			Color = color,
			Font = "P22UndergroundSCHeavy",
			FontSize = randomFontSize,
			AutoSetDataProperties = false,
			FadeOpacity = 1.0,
			OffsetY = offsetY,
		})
	end
	waitUnmodified( CombatUI.DamageTextHoldTime, damageTextAnchor )
	if damageProjectileSourceName and ScreenAnchors[victim.ObjectId] and ScreenAnchors[victim.ObjectId][damageProjectileSourceName] and IdExists({ Id = damageTextAnchor }) then
		ScreenAnchors[victim.ObjectId][damageProjectileSourceName].State = "Drifting"

		Unattach({ Id = damageTextAnchor, DestinationId = victim.ObjectId})
		if isDoubleDamage then
			ModifyTextBox({ 
				Id = damageTextAnchor, 
				Text = "CriticalDamageAmount",
				LuaKey = "TempTextData",
				LuaValue = { Amount = ScreenAnchors[victim.ObjectId][damageProjectileSourceName].TargetNumber }, 
				ScaleTarget = 1.1, 
				ScaleDuration = 0 })	
		else
			ModifyTextBox({ Id = damageTextAnchor, Text = ScreenAnchors[victim.ObjectId][damageProjectileSourceName].TargetNumber, ScaleTarget = 1.1, ScaleDuration = 0 })
		end
	end

	local randomDuration = 1
	local driftOffsetX = RandomInt( -120, 120 )
	if wallHit then
		CreateAnimation({ Name = "CriticalHitWallSlam", DestinationId = victim.ObjectId })
	end
	if isSpecialDamage then
		PlaySound({ Name = "/SFX/AresCritical", Id = victim.ObjectId })
		Shift({ Id = damageTextAnchor, OffsetX = driftOffsetX, OffsetY = -100, Duration = randomDuration * 2, EaseIn = 0.99, EaseOut = 0.1, TimeModifierFraction = 1.0 })
		waitUnmodified( 0.1)
		if wallHit then
			ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.75, ScaleDuration = 0.4, ColorTarget = Color.WallSlamDamage, ColorDuration = 0.4, AutoSetDataProperties = false })
		else
			local colorTarget = Color.Yellow
			if triggerArgs.IsDoubleDamage then
				colorTarget = Color.AresDamage
			elseif triggerArgs.RandomHighRoll then
				colorTarget = Color.DionysusDamage
			end
			ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.5, ScaleDuration = 0.15, ColorTarget = colorTarget, ColorDuration = 0.5, AutoSetDataProperties = false })
		end
	else
		Shift({ Id = damageTextAnchor, OffsetX = driftOffsetX, OffsetY = -50, Duration = randomDuration, EaseIn = 0.99, EaseOut = 0.1, TimeModifierFraction = 1.0 })
		waitUnmodified( 0.1)
		local endColor = {0,0,0}
		if triggerArgs.OverrideDamageTextColor then
			endColor = triggerArgs.OverrideDamageTextColor
		elseif triggerArgs.SourceProjectile and SessionMapState.OverrideProjectileColor and SessionMapState.OverrideProjectileColorName == triggerArgs.SourceProjectile then
			endColor = SessionMapState.OverrideProjectileColor
		elseif triggerArgs.ProjectileDeflected then
			endColor = ProjectileData.DeflectedProjectileColor.DamageTextColor
		elseif triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] and ProjectileData[triggerArgs.SourceProjectile].DamageTextColor then
			endColor = ProjectileData[triggerArgs.SourceProjectile].DamageTextColor
		elseif triggerArgs.EffectName ~= nil and EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].DamageTextColor then
			endColor = EffectData[triggerArgs.EffectName].DamageTextColor
		elseif triggerArgs.AttackerTable ~= nil and triggerArgs.AttackerTable.DamageTextColor then
			endColor = triggerArgs.AttackerTable.DamageTextColor
		end
			ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.75, ScaleDuration = 0.4, ColorTarget = {0,0,0}, ColorDuration = 0.4, AutoSetDataProperties = false })
		
	end

	if isSpecialDamage then
		if triggerArgs.IsDoubleDamage then
			waitUnmodified( 0.55)
		else
			waitUnmodified( 0.45)
		end
	else
		waitUnmodified( 0.2)
	end
	ModifyTextBox({ Id = damageTextAnchor, FadeTarget = 0.0, FadeDuration = 0.25, AutoSetDataProperties = false })
	waitUnmodified( 0.25)
	Destroy({ Ids = { damageTextAnchor } })
	if damageProjectileSourceName and ScreenAnchors[victim.ObjectId] and ScreenAnchors[victim.ObjectId][damageProjectileSourceName] then
		RemoveValue( ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids, damageTextAnchor )
		if IsEmpty(ScreenAnchors[victim.ObjectId][damageProjectileSourceName].Ids) then
			ScreenAnchors[victim.ObjectId][damageProjectileSourceName] = nil
			RemoveValueAndCollapse(ScreenAnchors[victim.ObjectId].DamageProjectileSpaces, damageProjectileSourceName)
		end
	end
end


function LockCameraMotion( flag )
	SessionMapState.LockCameraMotion[flag] = true
end

function UnlockCameraMotion( flag )
	SessionMapState.LockCameraMotion[flag] = nil
end

function PulseCombatText( damageTextAnchor )
	waitUnmodified( 0.05, RoomThreadName )
	ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 1, ScaleDuration = 0.1 })
end

function GetDamageNumberTextScale( damageAmount )
	local baseTextScale = 1.0
	for k, textScaleInfo in ipairs( GameData.DamageNumberTextScales ) do
		if damageAmount >= textScaleInfo.Min and damageAmount <= textScaleInfo.Max then
			return textScaleInfo.Scale
		end
	end
	return baseTextScale
end

function GetPlayerDamageNumberTextScale( damageAmount )
	local baseTextScale = 1.0
	for k, textScaleInfo in ipairs( GameData.PlayerDamageNumberTextScales ) do
		if damageAmount >= textScaleInfo.Min and damageAmount <= textScaleInfo.Max then
			return textScaleInfo.Scale
		end
	end
	return baseTextScale
end

function ParryAttackPresentation( unitId )
	if unitId ~= CurrentRun.Hero.ObjectId then
		return
	end
	PlaySound({ Name = "/Leftovers/Menu Sounds/LevelUpFlash", Id = unitId, ManagerCap = 46 })
	Flash({ Id = unitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.15, ExpireAfterCycle = true })
	thread( InCombatText, unitId, "ParryHit", 0.5 , { SkipShadow = true } )
end

function UnitInvulnerableHitPresentation( blocker, args )
	Flash({ Id = blocker.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.15, ExpireAfterCycle = true })
	CreateAnimation({ Name = blocker.InvulnerableHitFx, DestinationId = blocker.ObjectId })
	PlaySound({ Name = blocker.InvulnerableHitSound or "/SFX/Enemy Sounds/Exalted/EnemyShieldBlock", Id = blocker.ObjectId, ManagerCap = 46 })

	if CheckCooldown( "BlockHint"..blocker.ObjectId, 0.2 ) then
		thread( InCombatText, blocker.ObjectId, "BlockHit", 0.4, { SkipShadow = true } )
	end
end

function SprintPhasingUnitPresentation( blocker, args )
	if blocker.IsDead then
		return
	end

	Flash({ Id = blocker.ObjectId, Speed = 0.85, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.Green, Duration = 0.25, ExpireAfterCycle = true })
	SetAlpha({ Id = blocker.ObjectId, Fraction = 0.8, Duration = 0.06 })
	PlaySound({ Name = "/SFX/Player Sounds/MelPassThroughWhoosh", Id = blocker.ObjectId, ManagerCap = 32 })
	CreateAnimation({ Name = "UnitSprintPhaseVFX", DestinationId = blocker.ObjectId, OffsetX = 0, OffsetY = 0 }) 		

	wait(0.15)
	SetAlpha({ Id = blocker.ObjectId, Fraction = 1.0, Duration = 0.13 })
end

function SprintPhasingMelPresentation( blocker, args )
	if blocker.IsDead then
		return
	end

	Flash({ Id = blocker.ObjectId, Speed = 0.85, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.Green, Duration = 0.14, ExpireAfterCycle = true })
	SetAlpha({ Id = blocker.ObjectId, Fraction = 0.8, Duration = 0.06 })
	
	wait(0.082)
	SetAlpha({ Id = blocker.ObjectId, Fraction = 1.0, Duration = 0.13 })
end



function CocoonHitPresentation( unitData )
	if unitData and unitData.IsDead then
		return
	end

	local unitId = unitData.ObjectId
	Flash({ Id = unitId, Speed = 0.85, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.Red, Duration = 0.15, ExpireAfterCycle = true })
	PlaySound({ Name = "/SFX/Player Sounds/AthenaDashImpact", Id = unitId, ManagerCap = 32 })
	CreateAnimation({ Name = "HitSparkD", DestinationId = unitId, Angle = 270, Scale = 1.3 })
end

function BlockAttackPresentation( weaponName, unitId, attacker )
	if unitId ~= CurrentRun.Hero.ObjectId then
		return
	end
	if attacker and attacker.CanReceiveGift then
		-- Can also check for PlayerMultiplier == 0, though that's a bit slower so doing this for now
		return
	end
	if WeaponData[weaponName] and WeaponData[weaponName].BlockSound then
		PlaySound({ Name = WeaponData[weaponName].BlockSound, Id = unitId, ManagerCap = 46 })
	else
		PlaySound({ Name = "/SFX/Enemy Sounds/Exalted/EnemyShieldBlock", Id = unitId, ManagerCap = 46 })
	end
	Flash({ Id = unitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.15, ExpireAfterCycle = true })
	thread( InCombatText, unitId, "BlockHit", 0.4, { SkipShadow = true } )
	wait(0.15)
end

function UnblockableAttackPresentation( unitId )
	thread( InCombatText, unitId, "UnblockableHit", 0.8, { SkipShadow = true } )
end

function ArmorDamagePresentation( victim, args )
	DoUnitArmorShake( victim, args )
	DoUnitArmorSpark( victim, args )

	if args then
		local projectileName = args.SourceProjectile
		local effectName = args.EffectName
		if projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].CancelRumble then
			return
		end

		if effectName and EffectData[effectName] and EffectData[effectName].CancelRumble then
			return
		end
	end
	local attackerWeaponName = args.SourceWeapon
	local sourceSimData = GetWeaponData(args.AttackerTable, attackerWeaponName)
	if args.Armed and sourceSimData and sourceSimData.ArmedParameters then
		sourceSimData = sourceSimData.ArmedParameters 
	end
	if sourceSimData and sourceSimData.ExParameters and IsExWeapon(attackerWeaponName, {Combat = true }, args) then
		sourceSimData = sourceSimData.ExParameters 
	end
	if attackerWeaponName and SessionMapState.HitSimSlowOverride[ attackerWeaponName ] then
		sourceSimData = SessionMapState.HitSimSlowOverride[ attackerWeaponName ]
	end
	DoWeaponHitSimulationSlow( victim, args )
	DoWeaponScreenshake( sourceSimData, "HitScreenshake", { AttackerId = args.AttackerId, SourceProjectile = args.SourceProjectile, EffectName = args.EffectName, DistanceSquared = args.DistanceSquared })	
	if sourceSimData ~= nil then
		if sourceSimData.HitCameraMotion ~= nil then
			thread( DoCameraMotion, sourceSimData.HitCameraMotion )
		end
		if sourceSimData.HitRumbleParameters ~= nil then
			thread( DoWeaponHitRumble, sourceSimData, args )
		end
	end
end

function HealthTickDecrementPresentation( victim, args )

	if victim.HealthTickAnimations ~= nil and victim.HealthTickAnimations[victim.HealthTicks] ~= nil then
		SetAnimation({ DestinationId = victim.ObjectId, Name = victim.HealthTickAnimations[victim.HealthTicks] })
	end

	if victim.HealthTickDecrementSound ~= nil then
		PlaySound({ Name = victim.HealthTickDecrementSound, Id = victim.ObjectId })
	end

end

function DamagePresentation( victim, args )
	DoUnitHitShake( victim, args )
	if not victim.SkipUnitHitFlash then 
		DoUnitHitFlash( victim, args )
	end
	if args then
		local projectileName = args.SourceProjectile
		local effectName = args.EffectName
		if projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].CancelRumble then
			return
		end

		if effectName and EffectData[effectName] and EffectData[effectName].CancelRumble then
			return
		end
	end
	local attackerWeaponName = args.SourceWeapon
	local sourceSimData = GetWeaponData(args.AttackerTable, attackerWeaponName)
	if args.Armed and sourceSimData and sourceSimData.ArmedParameters then
		sourceSimData = sourceSimData.ArmedParameters 
	end
	if attackerWeaponName and SessionMapState.HitSimSlowOverride[ attackerWeaponName ] then
		sourceSimData = SessionMapState.HitSimSlowOverride[ attackerWeaponName ]
	end

	if victim ~= CurrentRun.Hero and sourceSimData ~= nil and sourceSimData.PresentationOnlyOnPlayerHit then
		return
	end
	DoWeaponHitSimulationSlow( victim, args, sourceSimData )
	
	if sourceSimData and sourceSimData.ExParameters and IsExWeapon(attackerWeaponName, {Combat = true }, args ) then
		sourceSimData = sourceSimData.ExParameters 
	end
	DoWeaponScreenshake( sourceSimData, "HitScreenshake", args )
	if sourceSimData ~= nil then
		if sourceSimData.HitCameraMotion ~= nil then
			thread( DoCameraMotion, sourceSimData.HitCameraMotion )
		end
		if sourceSimData.HitRumbleParameters ~= nil then
			thread( DoWeaponHitRumble, sourceSimData, args )
		end
	end
end

function SpecialHitPresentation( unit, triggerArgs )
	local attacker = triggerArgs.AttackerTable
	local unitId = unit.ObjectId
	
	local isCritical = triggerArgs.IsCrit
	local hitVulnerable = triggerArgs.HitVulnerability
	local offsetY = unit.HealthBarOffsetY or ConstantsData.DefaultHealthBarOffsetY
	if hitVulnerable then
		if triggerArgs.TriggeredHitVulnerabilityMultiplier then
			CreateAnimation({ Name = "Backstab", DestinationId = unitId })
			if CheckCooldown( "BackstabMessagePlayed", 0.1 ) then
				thread( InCombatText, unitId, "BackstabHit", 0.3, {OffsetY = offsetY + 36, FontSize = 24, SkipFlash = true, SkipRise = true, SkipShadow = true, FadeDuration = 0.1 })
			end
		end
	end
	if triggerArgs.TriggeredVengeanceMultiplier and not unit.HideVengeanceText then
		if CheckCooldown( "VengeanceMessagePlayed", 0.3 ) then
			thread( InCombatText, unitId, "VengeanceHit", 0.3, {OffsetY = offsetY + 36, FontSize = 24, SkipFlash = true, SkipRise = true, SkipShadow = true, FadeDuration = 0.1 })
		end
	end
	if triggerArgs.TriggeredProximityMultiplier then
		if CheckCooldown( "ProximityAnimation", 0.1 ) then
			CreateAnimation({ Name = "AphroditeOnHit", DestinationId = unitId })
		end
	end
	if unit.ActiveEffects and unit.ActiveEffects.VulnerabilityIndicator and attacker == CurrentRun.Hero then
		local projectileName = triggerArgs.SourceProjectile
		local effectName = triggerArgs.EffectName
		local showSpark = true
		if projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].CancelHitSpark then
			showSpark = false
		elseif effectName and EffectData[effectName] and EffectData[effectName].CancelHitSpark then
			showSpark = false
		end
		if showSpark then
			CreateAnimation({ Name = "HitSparkVulnerability", DestinationId = unitId })
		end
	end
end

function IndestructibleObstacleHitPresentation( victim, triggerArgs )

	if triggerArgs.SourceProjectile ~= nil then
		local sourceProjectileData = ProjectileData[triggerArgs.SourceProjectile]
		if sourceProjectileData ~= nil and sourceProjectileData.IgnoreIndestructibleHitPresentation then
			return
		end
	end

	if victim.HitFx ~= nil then
		local angle = 0
		if triggerArgs.ImpactAngle ~= nil then
			angle = triggerArgs.ImpactAngle + 180
		end
		CreateAnimation({ DestinationId = victim.ObjectId, Name = victim.HitFx, Angle = angle, OffsetZ = triggerArgs.ImpactLocationZ, ManagerCap = 300, ManagerFrameCap = 14 })
	end

	if victim.OnHitShake ~= nil then
		victim.OnHitShake.Id = victim.ObjectId
		Shake( victim.OnHitShake )
	end

	if victim.OnHitVoiceLines ~= nil or (victim.OnHitByWeaponVoiceLines ~= nil and victim.OnHitByWeaponVoiceLines[attackerWeaponName] ~= nil) then
		thread( PlayVoiceLines, victim.OnHitVoiceLines, true, victim, triggerArgs )
	end

end

function InCombatText( targetId, combatText, textDuration, args )
	args = args or {}
	args.TargetId = targetId
	args.Text = combatText
	args.Duration = textDuration
	InCombatTextArgs( args )
end

function InCombatTextEvent( source, args )
	InCombatTextArgs( args )
end

function InCombatTextArgs( args )

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	local targetId = args.TargetId
	if args.TargetHero then
		targetId = CurrentRun.Hero.ObjectId
	end

	if targetId == nil or targetId <= 0 then
		return
	end

	if args.Cooldown ~= nil and not CheckCooldown( args.Text, args.Cooldown ) then
		return
	end

	if args.Duration == nil then
		args.Duration = 0.4
	end

	if args.Angle == nil then
		args.Angle = 90
	end

	if args.Group == nil then
		args.Group = "Combat_UI_Backing"
	end

	if args.FadeDuration == nil then
		args.FadeDuration = 0.3
	end

	local stackIndex = nil
	if args.UseProgressiveStack then
		if SessionMapState.InCombatTextStackCount >= 5 then
			SessionMapState.InCombatTextStackCount = 0
		end
		SessionMapState.InCombatTextStackCount = SessionMapState.InCombatTextStackCount + 1
		stackIndex = SessionMapState.InCombatTextStackCount
		args.OffsetY = (args.OffsetY or 0) + (SessionMapState.InCombatTextStackCount - 1) * -60
	end

	wait( args.PreDelay )

	local feedbackRiser = nil

	if args.ScreenSpace then
		feedbackRiser = CreateScreenComponent({ Name = "BlankObstacleNoTimeModifier", Group = args.Group, DestinationId = targetId }).Id
	else
		feedbackRiser = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", Group = args.Group, DestinationId = targetId, OffsetX = args.OffsetX, OffsetY = args.OffsetY or -140 })
	end

	if args.SkipRise then
		Attach({ Id = feedbackRiser, DestinationId = targetId, OffsetX = args.OffsetX, OffsetY = args.OffsetY or 55 })
	end

	if args.SoundName then
		PlaySound({ Name = args.SoundName, Id = feedbackRiser })
	end

	local locationZWithOwner = true
	if not args.SkipShadow then
		SetAnimation({  Name = "InCombatTextShadow", DestinationId = feedbackRiser, OffsetY = -10 })
		locationZWithOwner = false
	end

	if not args.SkipFlash then
		CreateAnimation({  Name = args.FlashAnimation or "SkillProcFeedbackFx", DestinationId = feedbackRiser, OffsetY = -10, Scale = 1.0, Group = args.FlashGroup or "Combat_UI_Additive" })
	end

	local textJustification = "CENTER"
	local textOffsetX = 0
	if args.ImagePath ~= nil then
		args.Text = "@"..args.ImagePath.." "..args.Text
		textJustification = "LEFT"
		textOffsetX = -100
	end

	CreateTextBox({
		Id = feedbackRiser, Text = args.Text,
		Justification = textJustification,
		OffsetX = textOffsetX,
		OutlineThickness = 2.0,
		OutlineColor = {0.0, 0.0, 0.0, 1.0},
		Color = args.TextColor or {0.95, 0.95, 0.95, 1},
		Font = "P22UndergroundSCHeavy",
		FontSize = args.FontSize or 24,
		TextSymbolScale = 0.8,
		LuaKey = args.LuaKey,
		LuaValue = args.LuaValue,
		ShadowOffset = {0, 2},
		ShadowBlur = 0,
		ShadowAlpha = 1,
		ShadowColor = {0,0,0,1},
		UseDescription = args.UseDescription,
		DataProperties =
		{
			LocationZWithOwner = locationZWithOwner,
		},
	})

	if not args.SkipRise then
		local distance = args.RiseDistance or 100
		Move({ Id = feedbackRiser, Angle = args.Angle, Distance = distance, EaseIn = 0.99, EaseOut = 1.0, Duration = 0.75 })
	end

	waitUnmodified(  args.Duration )
	ModifyTextBox({ Id = feedbackRiser, FadeTarget = 0, FadeDuration = args.FadeDuration, AutoSetDataProperties = false, })

	if not args.SkipShadow then
		SetAnimation({  Name = "InCombatTextShadowFade", DestinationId = feedbackRiser, OffsetY = -10 })
	end

	if args.UseProgressiveStack and stackIndex == SessionMapState.InCombatTextStackCount then
		SessionMapState.InCombatTextStackCount = 0
	end

	waitUnmodified( 0.41)
	Destroy({ Id = feedbackRiser })

end

function PlayerDodgePresentation()
	if CheckCooldown( "DodgePresentation", 0.3 ) then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Combat_Dodge", 0.4, {SkipShadow = true, FlashAnimation = "SkillProcFeedbackFx_MissDodge", FlashGroup = "Combat_UI",} )
		CreateAnimation({ Name = "MelDodgeFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteDodging", Id = CurrentRun.Hero.ObjectId, Delay = 0.2 })
	end
end

function PlayerMissPresentation()
	if CheckCooldown( "MissPresentation", 0.3 ) then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Combat_Miss", 0.4, {SkipShadow = true, FlashAnimation = "SkillProcFeedbackFx_MissDodge", FlashGroup = "Combat_UI",} )
		CreateAnimation({ Name = "MelEnemyMissedFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteDodging", Id = CurrentRun.Hero.ObjectId, Delay = 0.2 })
	end
end

OnEffectCanceled{
	function( triggerArgs)
		local cancelingWeaponName = triggerArgs.WeaponName
		local cancelingWeaponData = WeaponData[cancelingWeaponName]
		local canceledEffectNames = triggerArgs.EffectNames
		if cancelingWeaponData == nil then
			return
		end
		if cancelingWeaponData.CancelEffectSimSlowParameters and IsCancelSimEffectAllowed( cancelingWeaponData, canceledEffectNames ) then
			thread( DoWeaponCancelEffectSimulationSlow, cancelingWeaponData )
		end
		if cancelingWeaponData.Sounds ~= nil then
			DoWeaponSounds( cancelingWeaponData.Sounds.CancelEffectSounds, triggerArgs.TriggeredByTable, cancelingWeaponData )
		end
	end
}


function IsCancelSimEffectAllowed( cancelingWeaponData, canceledEffectNames )
	local ignoreEffects = cancelingWeaponData.IgnoreCancelSimOnEffects
	if ignoreEffects == nil then
		return true
	end
	if ContainsAny( ignoreEffects, canceledEffectNames ) then
		return false
	end
	return true
end

function DoWeaponScreenshake( sourceData, key, args )

	if SessionMapState.SecondaryEffectsThisFrame >= ConfigOptionCache.SecondaryEffectsFrameCap or ( sourceData and sourceData.CancelCameraShake )then
		--DebugPrint({ Text = "Ignoring secondary effect (ScreenShake) over frame budget" })
		return
	end

	local projectileName = args.SourceProjectile	
	local screenshakeData = nil
	if sourceData then
		screenshakeData = sourceData[key]
	end
	if screenshakeData == nil then
		local projectileData = ProjectileData[projectileName]
		if projectileData and key and projectileData[key] then
			screenshakeData = projectileData[key]
		end
	end
	
	if screenshakeData == nil then
		return
	end
	if projectileName ~= nil and ProjectileData[projectileName] and ProjectileData[projectileName].CancelCameraShake then
		return
	end

	local effectName = args.EffectName
	if effectName ~= nil and EffectData[effectName] and EffectData[effectName].CancelCameraShake then
		return
	end
	
	local distanceSquared = args.DistanceSquared
	if screenshakeData.DistanceThreshold and ( not distanceSquared or distanceSquared == -1 or distanceSquared > ( screenshakeData.DistanceThreshold * screenshakeData.DistanceThreshold )) then
		return
	end

	thread( DoWeaponScreenshakeThread, screenshakeData )

end

function DoWeaponScreenshakeThread( screenshakeData )

	if screenshakeData.ScreenPreWait then
		wait( screenshakeData.ScreenPreWait )
	end

	if screenshakeData.DynamicAngleOffset then
		screenshakeData.Angle = GetPlayerAngle() + screenshakeData.DynamicAngleOffset
	end
	ShakeScreen( screenshakeData )

end

function DoUnitArmorShake( unit, args )

	if SessionMapState.SecondaryEffectsThisFrame >= ConfigOptionCache.SecondaryEffectsFrameCap then
		--DebugPrint({ Text = "Ignoring secondary effect (ArmorShake) over frame budget" })
		return
	end

	local projectileName = args.SourceProjectile
	local effectName = args.EffectName

	if args.AttackerWeaponData and args.AttackerWeaponData.CancelArmorUnitShake then
		return
	end

	if projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].CancelArmorUnitShake == true then
		return
	end

	if effectName and EffectData[effectName] and EffectData[effectName].CancelArmorUnitShake == true then
		return
	end

	local armorId = EnemyHealthDisplayAnchors[unit.ObjectId.."armor"]
	if armorId ~= nil and not (projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].CancelUnitHitFlash == true) then
		Flash({ Id = armorId, Speed = 3, MinFraction = 1, MaxFraction = 0, Color = Color.White, Duration = 0.15, ExpireAfterCycle = true })
		SessionMapState.SecondaryEffectsThisFrame = SessionMapState.SecondaryEffectsThisFrame + 1
	end
	Shake({ Id = unit.ObjectId, Distance = 10, Speed = 650, Duration = 0.15, Angle = angle })
	SessionMapState.SecondaryEffectsThisFrame = SessionMapState.SecondaryEffectsThisFrame + 1
	if not (projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].CancelUnitHitFlash == true) then
		Flash({ Id = unit.ObjectId, Speed = 2, MinFraction = 0.25, MaxFraction = 0.0, Color = Color.ArmorFlashGold, Duration = 0.24, ExpireAfterCycle = true })
		SessionMapState.SecondaryEffectsThisFrame = SessionMapState.SecondaryEffectsThisFrame + 1
	end

end

function DoUnitHitShake( unit, args )
	
	if SessionMapState.SecondaryEffectsThisFrame >= ConfigOptionCache.SecondaryEffectsFrameCap then
		--DebugPrint({ Text = "Ignoring secondary effect (HitShake) over frame budget" })
		return
	end

	local projectileName = args.SourceProjectile
	local effectName = args.EffectName

	if args.AttackerWeaponData and args.AttackerWeaponData.CancelUnitShake then
		return
	end

	if projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].CancelUnitShake == true then
		return
	end

	if effectName and EffectData[effectName] and EffectData[effectName].CancelUnitShake == true then
		return
	end

	if unit.OnHitShake then
		Shake({ Id = unit.ObjectId, Distance = unit.OnHitShake.Distance or 6, Speed = unit.OnHitShake.Speed or 550, Duration = unit.OnHitShake.Duration or 0.15 })
	else
		Shake({ Id = unit.ObjectId, Distance = 6, Speed = 550, Duration = 0.15 })
	end
	SessionMapState.SecondaryEffectsThisFrame = SessionMapState.SecondaryEffectsThisFrame + 1
end

function DoUnitHitFlash( victim, args )

	if SessionMapState.SecondaryEffectsThisFrame >= ConfigOptionCache.SecondaryEffectsFrameCap then
		--DebugPrint({ Text = "Ignoring secondary effect (HitFlash) over frame budget" })
		return
	end

	local attackerWeaponName = args.SourceWeapon
	local weaponData = GetWeaponData(args.AttackerTable, attackerWeaponName)
	local projectileName = args.SourceProjectile
	local effectName = args.EffectName

	if weaponData and weaponData.CancelUnitHitFlash and not effectName then
		return
	end

	if projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].CancelUnitHitFlash == true then
		return
	end

	if effectName and EffectData[effectName] and EffectData[effectName].CancelUnitHitFlash == true then
		return
	end
	if victim.OnHitFlash then
		Flash({ Id = victim.ObjectId, Speed = 0.85, MinFraction = victim.OnHitFlash.MaxFraction or 1.0, MaxFraction = 0.0, Color = victim.OnHitFlash.Color or Color.Red, Duration = victim.OnHitFlash.Duration or 0.03, ExpireAfterCycle = true })	
	else
		Flash({ Id = victim.ObjectId, Speed = 0.85, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, Duration = 0.03, ExpireAfterCycle = true })	
	end
	
	SessionMapState.SecondaryEffectsThisFrame = SessionMapState.SecondaryEffectsThisFrame + 1

end

Using "HitSparkArmor"
function DoUnitArmorSpark( unit, args )
	local projectileName = args.SourceProjectile
	local effectName = args.EffectName

	if args.AttackerWeaponData and args.AttackerWeaponData.CancelArmorSpark == true then
		return
	end

	if projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].CancelArmorSpark == true then
		return
	end

	if effectName and EffectData[effectName] and EffectData[effectName].CancelArmorSpark == true then
		return
	end

	local animName = unit.ArmorSparkAnimation or "HitSparkArmor"
	CreateAnimation({ Name = animName, DestinationId = unit.ObjectId, Scale = unit.HitSparkScale, OffsetZ = unit.HitSparkOffsetZ or args.ImpactLocationZ, ManagerCap = 300, ManagerFrameCap = 14 })
end

function DoWeaponSounds( soundData, parentTable, weaponData )
	if soundData == nil or parentTable == nil then
		return
	end

	local defaultManagerCap = 46
	local weaponManagerCap = nil
	local parentManagerCap = nil
	if weaponData ~= nil and weaponData.AIData ~= nil then
		weaponManagerCap = weaponData.AIData.SoundManagerCap
	end
	if parentTable.DefaultAIData ~= nil then
		parentManagerCap = parentTable.DefaultAIData.SoundManagerCap
	end

	for _, soundDatum in pairs( soundData ) do
		local inCooldown = soundDatum.Cooldown and not CheckCooldown( soundDatum.Name, soundDatum.Cooldown )
		if not inCooldown and soundDatum.Name ~= nil then
			local managerCap = weaponManagerCap or parentManagerCap or defaultManagerCap
			if parentTable ~= CurrentRun.Hero then
				managerCap = soundDatum.ManagerCap or managerCap
			end
			local soundId = PlaySound({ Name = soundDatum.Name, Id = parentTable.ObjectId, ManagerCap = managerCap })
			if soundDatum.SetPitchToPropertyValue ~= nil then
				local propertyValue = GetWeaponDataValue({ Id = parentTable.ObjectId, WeaponName = weaponData.Name, Property = soundDatum.SetPitchToPropertyValue })
				SetSoundCueValue({ Names = { "Pitch" }, Id = soundId, Value = propertyValue })
			end
			-- We only need to store a soundId if they need to be stopped elsewhere
			if soundDatum.StoppedBy ~= nil then
				if parentTable.PlayingSounds == nil then
					parentTable.PlayingSounds = {}
				end
				local soundKey = soundDatum.Name
				if soundDatum.Key ~= nil then
					soundKey = soundDatum.Key
				end
				parentTable.PlayingSounds[soundId] = soundKey
			end
		end
	end
end

function StopWeaponSounds( soundEvent, soundData, parentTable )
	if soundData == nil or parentTable == nil or parentTable.PlayingSounds == nil then
		return
	end
	for _, soundCategory in pairs( soundData ) do
		for index, soundElement in pairs( soundCategory ) do
			if soundElement.StoppedByLookup ~= nil and soundElement.StoppedByLookup[soundEvent] then
				local soundKey = soundElement.Name
				if soundElement.Key ~= nil then
					soundKey = soundElement.Key
				end
				for soundId, playingSoundKey in pairs( ShallowCopyTable( parentTable.PlayingSounds ) ) do
					if playingSoundKey == soundKey then
						StopSound({ Id = soundId, Duration = 0.2 })
						parentTable.PlayingSounds[soundId] = nil
					end
				end
			end
		end
	end
end

function DoCameraMotion( cameraData )
	if cameraData == nil or cameraData.ZoomType == "None" or not IsEmpty( SessionMapState.LockCameraMotion ) then
		return
	end
	local defaultZoom = 1.0
	if CurrentHubRoom ~= nil then
		defaultZoom = CurrentHubRoom.ZoomFraction or defaultZoom
	else
		defaultZoom = CurrentRun.CurrentRoom.ZoomFraction or defaultZoom
	end
	local relativeCameraData = ShallowCopyTable( cameraData )
	SessionMapState.WeaponZoomActive = true
	if relativeCameraData.Fraction ~= nil then
		if relativeCameraData.Fraction < 1.0 and ConfigOptionCache.GraphicsQualityPreset == "GraphicsQualityPreset_Low" then
			--DebugPrint({ Text = "Clamping zoom on Low" })
			relativeCameraData.Fraction = 1.0
		end
		relativeCameraData.Fraction = relativeCameraData.Fraction * defaultZoom
	end
	waitUnmodified( relativeCameraData.ScreenPreWait )
	if IsEmpty( SessionMapState.LockCameraMotion ) then
		if relativeCameraData.ZoomType ~= nil then
			FocusCamera( relativeCameraData )
		else
			PanCamera( relativeCameraData )
		end
	end
	local additionalCameraWait = relativeCameraData.HoldDuration or 0
	local restoringDefault = false
	if relativeCameraData.RestoreDefaultDuration then
		waitUnmodified( relativeCameraData.Duration + additionalCameraWait )
		if IsEmpty( SessionMapState.LockCameraMotion ) then
			FocusCamera({ Fraction = defaultZoom, Duration = relativeCameraData.RestoreDefaultDuration })
		end
		restoringDefault = true
	end
	waitUnmodified( relativeCameraData.RestoreDefaultDuration )
	if restoringDefault then
		SessionMapState.WeaponZoomActive = false
	end
end

function DoWeaponFireSimulationSlow( weaponData )
	if not IsEmpty( MapState.SimSpeedChanges ) then
		return
	end
	for k, simData in ipairs( weaponData.FireSimSlowParameters ) do
		waitUnmodified(  simData.ScreenPreWait )
		if simData.Fraction < 1.0 then
			AddSimSpeedChange( "WeaponFire", { Fraction = simData.Fraction, LerpTime = simData.LerpTime } )
		else
			RemoveSimSpeedChange( "WeaponFire", { LerpTime = simData.LerpTime } )
		end
	end
end

function DoWeaponCancelEffectSimulationSlow( weaponData )
	if weaponData == nil or weaponData.CancelEffectSimSlowParameters == nil then
		return
	end
	if not IsEmpty( MapState.SimSpeedChanges ) then
		return
	end
	for k, simData in ipairs( weaponData.CancelEffectSimSlowParameters ) do
		waitUnmodified(  simData.ScreenPreWait )
		if simData.Fraction < 1.0 then
			AddSimSpeedChange( "WeaponCancelEffect", { Fraction = simData.Fraction, LerpTime = simData.LerpTime } )
		else
			RemoveSimSpeedChange( "WeaponCancelEffect", { LerpTime = simData.LerpTime } )
		end
	end
end

function DoHeroHitRumble( sourceSimData )
	local simData = ShallowCopyTable( CurrentRun.Hero.HeroHitRumbleParameters )
	if sourceSimData and sourceSimData.HitRumbleParameters then
		simData = ShallowCopyTable( sourceSimData.HitRumbleParameters )
	end
	thread( DoRumble, simData )
end

function DoWeaponHitSimulationSlow( victim, args, sourceSimData )
	
	local weaponData = GetWeaponData(args.AttackerTable, args.SourceWeapon)
	local sourceStaggerSimData = sourceSimData or weaponData
	
	local projectileData = nil
	if args.SourceProjectile ~= nil then
		projectileData = ProjectileData[args.SourceProjectile]
	end

	local effectData = nil
	if args.EffectName ~= nil then
		effectData = EffectData[args.EffectName]
	end

	if not IsEmpty( MapState.SimSpeedChanges ) then
		return
	end
	
	if args.ProjectileDeflected or ( sourceStaggerSimData and sourceStaggerSimData.CancelSlowFrames ) or ( projectileData and projectileData.CancelSlowFrames ) or ( effectData and effectData.CancelSlowFrames ) then
		return
	end
	if sourceStaggerSimData == nil or sourceStaggerSimData.HitSimSlowParameters == nil then
		sourceStaggerSimData = projectileData
	end
	if sourceStaggerSimData == nil or sourceStaggerSimData.HitSimSlowParameters == nil then
		return
	end

	if not sourceStaggerSimData.HitPresentationIgnoresOwnership then

		if victim ~= nil and not victim.SimulationSlowOnHit and victim.ObjectId ~= CurrentRun.Hero.ObjectId then
			return
		end

		local attackerId = args.AttackerId
		if attackerId ~= CurrentRun.Hero.ObjectId and victim ~= nil and victim.ObjectId ~= CurrentRun.Hero.ObjectId then
			return
		end
	end

	if sourceStaggerSimData.SimSlowDistanceThreshold and ( not args.DistanceSquared or args.DistanceSquared == -1 or args.DistanceSquared > (sourceStaggerSimData.SimSlowDistanceThreshold * sourceStaggerSimData.SimSlowDistanceThreshold )) then
		return
	end

	thread( DoWeaponHitSimulationSlowThread, sourceStaggerSimData, args )

end

function DoWeaponHitSimulationSlowThread( sourceStaggerSimData, args )

	local criticalSlowHoldTime = 0
	local criticalCooldownTime = sourceStaggerSimData.HitSimSlowCooldown or 0
	if criticalCooldownTime == 0 or CheckCooldown( sourceStaggerSimData.Name, criticalCooldownTime ) then
		for k, simData in ipairs( sourceStaggerSimData.HitSimSlowParameters ) do
			--if ShouldIncreasePlayerHitPause( args ) then
			if args.IsCrit or (args.TriggeredByTable ~= nil and args.TriggeredByTable.IsDead) then
				if( k == 2) then
					criticalSlowHoldTime = 0.04
				end
			end
			waitUnmodified( simData.ScreenPreWait + criticalSlowHoldTime )
			if simData.Fraction < 1.0 then
				AddSimSpeedChange( sourceStaggerSimData.HitSimSlowCustomName or "WeaponHit", { Fraction = simData.Fraction, LerpTime = simData.LerpTime } )
			else
				RemoveSimSpeedChange( sourceStaggerSimData.HitSimSlowCustomName or "WeaponHit", { LerpTime = simData.LerpTime } )
			end
		end
	end
end

function ClearSimSpeedChanges()
	MapState.SimSpeedChanges = {}
	UpdateSimulationSpeed( nil, {} )
end

function AddSimSpeedChange( name, args )
	MapState.SimSpeedChanges[name] = args
	UpdateSimulationSpeed( name, args )
end

function RemoveSimSpeedChange( name, args )
	MapState.SimSpeedChanges[name] = nil
	UpdateSimulationSpeed( name, args )
end

function UpdateSimulationSpeed( name, args )
	if IsEmpty( MapState.SimSpeedChanges ) then
		AdjustSimulationSpeed({ Fraction = 1.0, LerpTime = args.LerpTime })
		return
	end
	local lowestSimSpeed = args
	for name, simSpeed in pairs( MapState.SimSpeedChanges ) do
		if (simSpeed.Fraction or 1.0) < (lowestSimSpeed.Fraction or 1.0) then
			lowestSimSpeed = simSpeed
		end
	end
	AdjustSimulationSpeed({ Fraction = lowestSimSpeed.Fraction, LerpTime = lowestSimSpeed.LerpTime })
end

function DoWeaponRadialBlur( blurInfo )
	AdjustRadialBlurDistance({ Fraction = blurInfo.Distance, Duration = blurInfo.FXInTime })
	AdjustRadialBlurStrength({ Fraction = blurInfo.Strength, Duration = blurInfo.FXInTime })
	waitUnmodified(  blurInfo.FXHoldTime )
	AdjustRadialBlurDistance({ Fraction = 0, Duration = blurInfo.FXOutTime })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = blurInfo.FXOutTime })
end

function LastKillPresentation( unit )
	--DebugPrint({ Text = "Last Kill Playing" })
	local unitId = unit.ObjectId

	HideCombatUI( "LastKill" )
	SetPlayerInvulnerable( "LastKill" )
	waitUnmodified(  0.15 )
	AddInputBlock({ Name = "LastKill" })
	CurrentRun.Hero.LastStandTimeMultiplier = nil
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationNames = { "HeroTeam" } })

	local lastKillFxInTime = 0.08
	local lastKillFxOutTime = 0.4

	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0.85, Duration = lastKillFxInTime })
	AdjustFrame({ Duration = lastKillFxInTime, Fraction = 1.25 })
	AdjustFullscreenBloom({ Name = "LastKillBloom", Duration = 0 })
	AddSimSpeedChange( "LastKill", { Fraction = 0.35, LerpTime = lastKillFxInTime, Priority = true } )
	if not CurrentRun.CurrentRoom.SkipLastKillSound then
		PlaySound({ Name = "/SFX/LastKillSFX", Id = unitId })
	end

	waitUnmodified( 0.5 )

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationNames = { "HeroTeam" } })
	CurrentRun.Hero.LastStandTimeMultiplier = nil
	RemoveInputBlock({ Name = "LastKill" })

	waitUnmodified( 0.1 )

	AdjustRadialBlurStrength({ Fraction = 0, Duration = lastKillFxOutTime })
	AdjustFrame({ Duration = lastKillFxOutTime, Fraction = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = lastKillFxOutTime })
	RemoveSimSpeedChange( "LastKill", { LerpTime = lastKillFxOutTime } )
	waitUnmodified(  0.2 )

	ShowCombatUI("LastKill")
	thread( LastKillVulnerable )
end

function LastKillVulnerable()
	wait( 1.0 )
	SetPlayerVulnerable( "LastKill" )
end

function ExecutePresentation( unit, triggerArgs )
	triggerArgs = triggerArgs or {}
	wait(0.2)
	local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = unit.ObjectId })
	CreateAnimation({ DestinationId = dropLocation, Name = "ShivaExecuteFxBright", Group = "FX_Standing_Add"  }) --nopkg
	CreateAnimation({ DestinationId = dropLocation, Name = "ShivaExecuteFxDark", Group = "FX_Dark"  }) --nopkg
	Destroy({ Id = dropLocation })
end

function BossResistChillKillPresentation(unit)
	AddSimSpeedChange( "ChillKill", { Fraction = 0.005, LerpTime = 0 } )
	local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = unit.ObjectId })
	AdjustColorGrading({ Name = "Frozen", Duration = 0.4 })
	CreateAnimation({ DestinationId = dropLocation, Name = "DemeterWinterHarvest" })
	waitUnmodified( 0.86) -- 52 frames for DemeterWinterHarvest Scythe to appear before slicing
	InCombatTextArgs ({ TargetId = unit.ObjectId, Text = "NotPolymorphed", Duration = 1.25, Cooldown = 2.0 } )	
	thread( PlayVoiceLines, GlobalVoiceLines.PrometheusDodgeFatalityLines )
	waitUnmodified( 0.2 )
	AdjustColorGrading({ Name = "Off", Duration = 0.4 })
	RemoveSimSpeedChange( "ChillKill", { LerpTime = 0.3 } )
	Destroy({ Id = dropLocation })
end

function BossChillKillPresentation(unit)
	AddSimSpeedChange( "ChillKill", { Fraction = 0.005, LerpTime = 0 } )
	local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = unit.ObjectId })
	AdjustColorGrading({ Name = "Frozen", Duration = 0.4 })
	CreateAnimation({ DestinationId = dropLocation, Name = "DemeterWinterHarvest" })
	thread( PlayVoiceLines, GlobalVoiceLines.DemeterFatalityVoiceLines, true )
	waitUnmodified( 0.86) -- 52 frames for DemeterWinterHarvest Scythe to appear before slicing
	CreateAnimation({ DestinationId = dropLocation, Name = "DemeterBossIceShatter" })
	waitUnmodified( 0.85)
	AdjustColorGrading({ Name = "Off", Duration = 0.4 })
	RemoveSimSpeedChange( "ChillKill", { LerpTime = 0.3 } )
	Destroy({ Id = dropLocation })
end

function GenericBossKillPresentation( unit, args )
	args = args or {}

	local allBossesDead = true
	local encounterData = EncounterData[CurrentRun.CurrentRoom.Encounter.Name]
	if encounterData.HoldKillPresentationForUnitDeaths ~= nil then
		local unitIds = GetIdsByType({ Names = encounterData.HoldKillPresentationForUnitDeaths })
		for k, id in pairs(unitIds) do
			if ActiveEnemies[id] ~= nil and not ActiveEnemies[id].IsDead then
				allBossesDead = false
				break
			end
		end
	end
	if not allBossesDead then
		if unit.DeathAnimationIfNotAllBossesDead then
			unit.DeathAnimation = unit.DeathAnimationIfNotAllBossesDead
			unit.ManualDeathAnimation = false
		end
		if unit.LastKillIfNotAllBossesDead then
			LastKillPresentation( unit )
		end
		return
	end

	-- Record the stats now so the boss can check them in the requirements for BossKillVoiceLines
	RecordEncounterClearStats()

	if unit.IsBoss then
		ClipEvent({ Icon = "steam_combat", Title = GetDisplayName({ Text = args.Message }), Description = "", StartOffset = 0.0, Duration = 5.0 })
	end

	if args.EndMusicEarly ~= nil then
		EndMusic()
	end
	if args.EndSecretMusicEarly ~= nil then
		SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 10 })
		AudioState.SecretMusicId = nil
		AudioState.SecretMusicName = nil
	end
	if args.MusicMutedStems ~= nil then
		SetSoundCueValue({ Names = args.MusicMutedStems, Id = AudioState.MusicId, Value = 0, Duration = 0.5 })
	end

	AddInputBlock({ Name = "GenericBossKillPresentation" })
	LockCameraMotion("GenericBossKillPresentation")
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	local deathPanSettings = args
	ClearEffect({ Ids = { victimId, killerId }, All = true, BlockAll = true, })
	EffectPostClearAll( unit )
	if unit.Frozen then
		UnfrozenPresentation( unit, { SkipPresentation = true })
	end

	if unit.DeathFx ~= nil then
		CreateAnimation({ Name = unit.DeathFx, DestinationId = unit.ObjectId, Angle = args.ImpactAngle })
		unit.DeathFx = nil
	end
	if unit.DeathAngle ~= nil then
		Halt({ Id = victimId })
		Stop({ Id = victimId })
		SetGoalAngle({ Id = victimId, Angle = unit.DeathAngle, CompleteAngle = true })
	end
	if unit.AngleTowardClosestTypeOnDeath then
		AngleTowardTarget({ Id = unit.ObjectId, DestinationId = GetClosest({ Id = unit.ObjectId, DestinationIds = GetIdsByType({ Name = unit.AngleTowardClosestTypeOnDeath }) }) })
	end
	if unit.DeathAnimation ~= nil then
		SetAnimation({ Name = unit.DeathAnimation, DestinationId = unit.ObjectId })
		unit.DeathAnimation = nil
	end
	if unit.DeathSound ~= nil then
		PlaySound({ Name = unit.DeathSound, Id = unit.ObjectId })
		unit.DeathSound = nil
	end
	if unit.BossKillVoiceLines ~= nil then
		thread( PlayVoiceLines, unit.BossKillVoiceLines, false, unit )
	end
	unit.Mute = true

	BlockProjectileSpawns({ ExcludeWeaponName = "WeaponLob" })
	if args.BlockMapSpawns then
		MapState.BlockSpawns = true
	end
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})

	if args.DestroyGroup then
		Destroy({ Ids = GetIds({ Name = args.DestroyGroup }) })
	end

	SetPlayerInvulnerable( "GenericBossKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	if args.AddInterBiomeTimerBlock then
		AddTimerBlock( CurrentRun, "InterBiome" )
	end
	AddTimerBlock( CurrentRun, "GenericBossKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	ClearCameraClamp({ LerpTime = 0 })
	local cameraPanTime = deathPanSettings.StartPanTime or 1.5
	local offsetY = unit.DeathPanOffsetY or 0
	PanCamera({ Id = victimId, Duration = cameraPanTime, OffsetY = offsetY })
	FocusCamera({ Fraction = args.PanZoomFraction or 1.1, Duration = cameraPanTime, ZoomType = "Undershoot" })
	ZeroMouseTether("GenericBossKillPresentation")
	CancelWeaponFireRequests({ Id = killerId })
	ToggleCombatControl( CombatControlsDefaults, false, "BossKill" )

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen, nil, { IgnoreHUDShow = true } )
	end
	HideCombatUI("BossKill")

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if deathPanSettings.StartSound then
		PlaySound({ Name = deathPanSettings.StartSound })
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteShocked" })
	end
	if not args.IgnoreEndMusic then
		EndMusic()
	end

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, IgnoreAnimations = true, DataValue = false, DestinationId = killerId })
	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = victimId })
	thread( VictimDeathHold, victimId, 0.02, 0.5 )
	if deathPanSettings.FlashRed then
		local duration = deathPanSettings.FlashDuration or 0.5
		Flash({ Id = victimId, Speed = 0.01, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = duration, ExpireAfterCycle = true })
	end

	RemoveFromGroup({ Id = killerId, Names = { "Standing" } })
	AddToGroup({ Id = killerId, Name = "Combat_Menu_Overlay_Backing", DrawGroup = true })
	RemoveFromGroup({ Id = victimId, Name = "Standing" })
	AddToGroup({ Id = victimId, Name = "Combat_Menu_Overlay_Backing", DrawGroup = true })

	if deathPanSettings.EndAngle then
		SetGoalAngle({ Id = victimId, Angle = deathPanSettings.EndAngle })
	end

	-- black out world
	AdjustFrame({ Color = Color.TransparentRed, Duration = 0.0, Fraction = 0 })
	ScreenAnchors.DeathBackground = ScreenAnchors.DeathBackground or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = ScreenAnchors.DeathBackground, Fraction = 10 })
	SetColor({ Id = ScreenAnchors.DeathBackground, Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 1.0, Duration = 0 })

	thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.17, Duration = 0.65 }, { ScreenPreWait = 2.8, LeftFraction = 0.3, Duration = 0.6 } } )

	thread( BossDeathFlash, { DestinationId = victimId, StartDelay = 0.52, StopDelay = 0.3, OffsetY = args.DeathFlashOffsetY or 0 } )

	wait( 0.15 )
	if killerId == CurrentRun.Hero.ObjectId then
		SetPlayerFade({ Flag = "KillPresentation"})
	else
		SetAlpha({ Id = killerId, Fraction = 0, Duration = 0.3 })
	end
	ClearEffect({ Id = killerId, Name = "KillDamageBonus" })

	wait( cameraPanTime )

	if args.ShiftDistance ~= nil then
		local angle = GetAngleBetween({ Id = unit.ObjectId, DestinationId = args.ShiftTowardId })
		Move({ Id = unit.ObjectId, Angle = angle, Speed = args.ShiftDistance * 4.0, Distance = args.ShiftDistance })
	end

	local textMessage = deathPanSettings.Message

	-- for CrawlerMiniboss & others
	if unit.AltDeathMessageTextIds ~= nil then
		local eligibleTextIds = {}
		for k, altTextIdData in pairs( unit.AltDeathMessageTextIds ) do
			if altTextIdData.GameStateRequirements == nil or IsGameStateEligible( altTextIdData, altTextIdData.GameStateRequirements ) then
				table.insert( eligibleTextIds, altTextIdData.TextId )
			end
		end
		if not IsEmpty( eligibleTextIds ) then
			textMessage = GetRandomValue( eligibleTextIds )
		end
	end

	if deathPanSettings.BossDifficultyMessage and GetNumShrineUpgrades( "BossDifficultyShrineUpgrade" ) > 0 then
		textMessage = deathPanSettings.BossDifficultyMessage
	end

	thread( DisplayInfoBanner, nil, { 
		Text = textMessage or "BiomeClearedMessage", 
		Delay = 0.75, 
		TextColor = Color.White, 
		TextFadeColor = {64,230,255,255},
		Layer = "Overlay", 
		FontScale = 0.9,
		AnimationName = "InfoBannerBossKillIn",
		AnimationOutName = "InfoBannerBossKillOut",
		Duration = 3.75,

		SubtitleFont = args.SubtitleFont or "SpectralSCMedium",
		SubtitleOffsetY = args.SubtitleOffsetY or 10,
		SubtitleDelay = args.SubtitleDelay or 3.0,

		SubTextColor = args.SubTextColor or Color.NarratorVoice,
		SubtitleText = args.SubtitleText or GetRandomValue(args.SubtitleTextOptions),
		SubtitleTextRevealSound = "/Leftovers/World Sounds/MapZoomInTight",
	} )

	if deathPanSettings.BatsAfterDeath then
		thread( SendCritters, { MinCount = 80, MaxCount = 90, StartX = 0, StartY = 300, MinAngle = 75, MaxAngle = 115, MinSpeed = 400, MaxSpeed = 2000, MinInterval = 0.03, MaxInterval = 0.1, GroupName = "CrazyDeathBats" } )
	end

	wait( deathPanSettings.EndPanTime or 5.5 )

	if CurrentRun.CurrentRoom.Encounter.BossKillGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[CurrentRun.CurrentRoom.Encounter.BossKillGlobalVoiceLines], false )
	end

	if CurrentRun.CurrentRoom.Encounter.DeathExtraSounds ~= nil then
		local randomSound = GetRandomValue( CurrentRun.CurrentRoom.Encounter.DeathExtraSounds )
		PlaySound({ Name = randomSound })
	end

	if deathPanSettings.KillerEndAngle ~= nil then
		SetGoalAngle({ Id = killerId, Angle = deathPanSettings.KillerEndAngle })
	end

	if deathPanSettings.KillerTeleportId ~= nil then
		Teleport({ Id = killerId, DestinationId = deathPanSettings.KillerTeleportId })
	end
	if deathPanSettings.VictimTeleportId ~= nil then
		Teleport({ Id = victimId, DestinationId = deathPanSettings.VictimTeleportId })
	end

	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0.0, Duration = 0.3 })

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationId = killerId })
	if killerId == CurrentRun.Hero.ObjectId then
		ClearPlayerFade( "KillPresentation" )
	else
		SetAlpha({ Id = killerId, Fraction = 1.00, Duration = 0.3 })
	end
	RemoveFromGroup({ Id = killerId, Names = { "Combat_Menu_Overlay_Backing" } })
	AddToGroup({ Id = killerId, Name = "Standing", DrawGroup = true })

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 3.0, EaseOut = 0.5 })
	local defaultZoom = 1.0
	if CurrentHubRoom ~= nil then
		defaultZoom = CurrentHubRoom.ZoomFraction or defaultZoom
	else
		defaultZoom = CurrentRun.CurrentRoom.ZoomFraction or defaultZoom
	end
	FocusCamera({ Fraction = defaultZoom, Duration = 3.0, ZoomType = "Ease" })

	if args.SetCameraClampIds then
		SetCameraClamp({ Ids = args.SetCameraClampIds })
	end

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	wait( 0.1 )

	RemoveFromGroup({ Id = victimId, Names = { "Combat_Menu_Overlay_Backing" } })
	AddToGroup({ Id = victimId, Name = "Standing", DrawGroup = true })

	wait( 0.9 )

	SetAnimation({ DestinationId = killerId, Name = "MelinoeIdle" })
	RemoveInputBlock({ Name = "GenericBossKillPresentation" })
	RemoveTimerBlock( CurrentRun, "GenericBossKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "GenericBossKillPresentation" )
	UnlockCameraMotion("GenericBossKillPresentation")
	ShowCombatUI("BossKill")
	ClearEffect({ Ids = { killerId }, All = true })
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	ToggleCombatControl( CombatControlsDefaults, true, "BossKill" )
	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
end

function ScreamerDistortionEffect( victim, attacker, triggerArgs )
	if attacker == nil then
		return
	end
	AdjustRadialBlurDistance({ Fraction = 2.25, Duration = 0.09 })
	AdjustRadialBlurStrength({ Fraction = 0.85, Duration = 0.09  })
	ShakeScreen({ Speed = 900, Distance = 4, Duration = 0.8, FalloffSpeed = 1400 })
	AdjustFullscreenBloom({ Name = "CerberusSummon", Duration = 0.09 })
	waitUnmodified( 1.0 )

	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.3 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.3  })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
end

function BossDeathFlash( args )
	wait( args.StartDelay )
	CreateAnimation({ DestinationId = args.DestinationId, Name = "MelDeathFlash", OffsetY = args.OffsetY or 0 })
	wait( args.StopDelay )
	StopAnimation({ DestinationId = args.DestinationId, Name = "MelDeathFlash" })
end

function TyphonHeadPostCombatReload( room, args )
	Destroy({ Ids = GetIds({ Name = "TyphonHeadDeathDelete" }) })
	Activate({ Ids = GetInactiveIds({ Name = "ExitPathReveal" }) })
end

function VictimDeathHold( victimId, startDelay, endDelay )
	wait( startDelay )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationId = victimId })
	wait( endDelay )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationId = victimId })
end

function InvulnerabilityFramePresentationStart( victim, damage, heroHealthThreshold )
	ActivateTempInvulnerabilityPresentation()
	if damage >= heroHealthThreshold then
		-- thread( InCombatText, CurrentRun.Hero.ObjectId, "MassiveHit", 1.2 )
	else
		-- thread( InCombatText, CurrentRun.Hero.ObjectId, "MassiveHits", 1.2 )
	end
	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof", Id = victim.ObjectId  })
	thread( PlayVoiceLines, CurrentRun.Hero.LowHealthVoiceLines, true )
end

function InvulnerabilityFramePresentationEnd( victim, damage, heroHealthThreshold )
	DisableTempInvulnerabilityPresentation()
end

function StartWavePresentation( encounter, wave )

	if not encounter.SkipNextWaveVoicelines then
		local totalWaveCount = TableLength(encounter.SpawnWaves)
		if encounter.CurrentWaveNum == totalWaveCount and ( totalWaveCount >= 3 ) then
			thread( PlayVoiceLines, HeroVoiceLines.FinalWaveVoiceLines, true )
		elseif encounter.CurrentWaveNum > 1 then
			thread( PlayVoiceLines, HeroVoiceLines.NextWaveVoiceLines, true )
		end
	end

	if wave.StartGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[wave.StartGlobalVoiceLines] )
	end
end

function DoImpactSound( victim, args )
	
	if victim.ImpactSound ~= nil then
		-- Material system override
		PlaySound({ Name = victim.ImpactSound, Id = victim.ObjectId, ManagerCap = 32 })
		return
	end

	local attackerWeaponName = args.SourceWeapon
	local attackerProjectileName = args.SourceProjectile
	local victimName = victim.Name
	local victimId = victim.ObjectId
	local victimIsInvulnerable = args.IsInvulnerable

	local sourceData = nil

	if attackerProjectileName ~= nil then
		sourceData = ProjectileData[attackerProjectileName]
	end

	if sourceData == nil or sourceData.Sounds == nil or sourceData.Sounds.ImpactSounds == nil and attackerWeaponName ~= nil then
		if args.AttackerTable ~= nil then
			sourceData = GetWeaponData(args.AttackerTable, attackerWeaponName)
		else
			sourceData = WeaponData[attackerWeaponName]
		end
		if args.Armed and souceData and sourceData.ArmedParameters and sourceData.ArmedParameters.Sounds and sourceData.ArmedParameters.Sounds.ImpactSounds then
			sourceData = sourceData.ArmedParameters
		end
	end

	if sourceData == nil or sourceData.Sounds == nil or sourceData.Sounds.ImpactSounds == nil then
		return
	end
	local soundData = sourceData.Sounds.ImpactSounds
	local managerCap = nil
	if victim ~= nil then

		if victim.SilentImpact then
			return
		end

		local impactSound = nil
		if victimIsInvulnerable then
			impactSound = soundData.Invulnerable
			managerCap = 26
		elseif victim.HealthBuffer ~= nil and victim.HealthBuffer > 0 then
			impactSound = soundData.Armored
			managerCap = 26
		end
		if impactSound == nil and victim.Material ~= nil then
			impactSound = soundData[victim.Material]
			if impactSound == nil and victim.MaterialAlt ~= nil then
				impactSound = soundData[victim.MaterialAlt]	
			end
			managerCap = 32
		end
		if impactSound == nil then
			impactSound = soundData.Default
			managerCap = 26
		end
		if impactSound ~= nil then
			PlaySound({ Name = impactSound, Id = victim.ObjectId, ManagerCap = managerCap })
		end
		return

	end

	local impactSound = soundData.Default
	if impactSound ~= nil then
		PlaySound({ Name = impactSound, Id = victimId, ManagerCap = managerCap })
	end
end

function HitInvulnerablePresentation( victim, attacker, triggerArgs )
	if not victim.IsDead and victim.HitInvulnerableText and victim ~= nil and victim.AIBehavior ~= nil and attackerWeaponData ~= nil and not attackerWeaponData.NoHitInvulnerableText and triggerArgs.DealsDamageOrControlEffect then
		-- Enemy must be fully spawned and active
		if CheckCooldown( "HitInvulnerableText", 0.25) then
			thread( InCombatText, victimId, victim.HitInvulnerableText, 0.4, { SkipShadow = true } )
		end
		if attacker ~= nil and attacker == CurrentRun.Hero and not attacker.IsDead then
			thread( PlayVoiceLines, HeroVoiceLines.HitInvulnerableVoiceLines, true, attacker )
		end
	end

	if victim.HitInvulnerablePresentationThreadedFunctionName ~= nil then
		thread( CallFunctionName, victim.HitInvulnerablePresentationThreadedFunctionName, victim )
	end
	if victim.InvulnerableVoiceLines then
		thread( PlayVoiceLines, victim.InvulnerableVoiceLines, nil, victim )
	end
	if victim.InvulnerableHitSound ~= nil then
		PlaySound({ Name = victim.InvulnerableHitSound, Id = victim.ObjectId })
	end
	local attackerWeaponName = triggerArgs.SourceWeapon
	if victim.RepulseOnMeleeInvulnerableHit and attackerWeaponName ~= nil and triggerArgs.EffectName == nil then
		local repulsed = false
		if Contains( WeaponSets.HeroMeleeRangeWeapons, attackerWeaponName ) then
			local distanceToPlayer = GetDistance({ Id = victim.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			if distanceToPlayer < victim.RepulseOnMeleeInvulnerableHit then
				RepulseFromObject( victim, { Scale = victim.InvincibubbleScale } )
				repulsed = true
			end
		end
		if not repulsed and not victim.IgnoreInvincibubbleOnHit then
			ShowInvincibubbleOnObject( victim, { Scale = victim.InvincibubbleScale } )
		end
	elseif victim.AlwaysShowInvulnerabubbleOnInvulnerableHit then
		ShowInvincibubbleOnObject( victim, { Scale = victim.InvincibubbleScale } )
	end

	if victim.HitInvulnerableExpireProjectiles then
		ExpireProjectiles({ ProjectileIds = { triggerArgs.ProjectileId } })
	end
end

function EnemyDodgePresentation( victim, triggerArgs )

	thread( InCombatText, victim.ObjectId, "Combat_Dodge", 0.45, { OffsetY = victim.HealthBarOffsetY, SkipFlash = true, PreDelay = RandomFloat(0.1, 0.15), SkipShadow = true } )
	
	if victim.DodgeVoiceLines ~= nil then
		thread( PlayVoiceLines, unit.DodgeVoiceLines, nil, unit )
	end

	if victim.DodgeAnimation ~= nil then
		SetAnimation({ DestinationId = victim.ObjectId, Name = victim.DodgeAnimation })
	end
end

function OnInvisStartPresentation( unit )
	thread( InCombatText, unit.ObjectId, "Startled", 0.45, { OffsetY = unit.HealthBarOffsetY, SkipFlash = true, PreDelay = RandomFloat(0.1, 0.15), SkipShadow = true } )

	if unit.OnInvisStartVoiceLines ~= nil then
		thread( PlayVoiceLines, unit.OnInvisStartVoiceLines, nil, unit )
	end
	if unit.InvisStartSound then
		PlaySound({ Name = unit.InvisStartSound, Id = unit.ObjectId })
	end
end

function HitBySmokeTrapWeaponPresentation( victim )
	if victim ~= CurrentRun.Hero then
		return
	end

	local threadName = "PoisonGasThread"
	local clearDelay = 0.5

	if SetThreadWait( threadName, clearDelay ) then
		return
	end

	if victim.ChokingSound ~= nil then
		PlaySound({ Name = victim.ChokingSound, Id = victim.ObjectId })
	end

	AdjustFullscreenBloom({ Name = "Blurry", Duration = 4.5 })
	AdjustColorGrading({ Name = "SmokeTrap", Duration = 4.5 })
	wait( clearDelay, threadName )
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })

end


function StartOrRefreshLavaPresentation()
	if ScreenAnchors.LavaVignetteId ~= nil or HasThread( "LavaFalloff" ) then
		SetThreadWait( "LavaFalloff", 0.5 )
		return
	end

	ScreenAnchors.LavaVignetteId = CreateScreenObstacle({ Name = "BlankObstacle",
		Group = "Combat_Menu_Additive",
		Animation = "LavaVignetteSpawner",
		X = ScreenCenterX, Y = ScreenCenterY + ScreenCenterNativeOffsetY,
		ScaleX = ScreenScaleX })
	--BloomRequestStart({ SourceName = "LavaVignette", BloomType = "Team02", Duration = 0.5 })
	wait( 0.5, "LavaFalloff" )
	EndLavaPresentation()
end

function EndLavaPresentation()
	local clearDuration = 0.3
	--BloomRequestEnd({ SourceName = "LavaVignette", Duration = clearDuration })
	SetAnimation({ Name = "LavaVignetteEnd", DestinationId = ScreenAnchors.LavaVignetteId })
	wait(clearDuration)
	wait(0.5) -- additional 0.5s for flames to end
	Destroy({ Id = ScreenAnchors.LavaVignetteId })
	ScreenAnchors.LavaVignetteId = nil
end


function StartPoisonPresentation(unit)
	if ScreenAnchors.PoisonVignetteId == nil then
		ScreenAnchors.PoisonVignetteId = CreateScreenObstacle({ Name = "BlankObstacle",
			Group = "Combat_Menu_Additive",
			Animation = "PoisonVignette",
			X = ScreenCenterX, Y = ScreenCenterY,
			ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	end
	unit.CurrentlyPoisoned = true
	unit.TimesPoisoned = unit.TimesPoisoned or 0
	unit.TimesPoisoned = unit.TimesPoisoned + 1
	if CheckCooldown( "PoisonAppliedTextCooldown", 1.5 ) then
		thread( InCombatText, unit.ObjectId, "DebuffPoisoned", 1.2 )
	end
	PlaySound({ Name = "/SFX/Player Sounds/DionysusShieldDash", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TitanToggleLong", Id = CurrentRun.Hero.ObjectId })
	PlayVoiceLines( HeroVoiceLines.PoisonAppliedVoiceLines, true )
	if unit.TimesPoisoned == 1 then
		wait(1.0)
		local fountains = GetIdsByType({ Name = "PoisonCure" })
		for k, fountainId in pairs(fountains) do
			thread( DirectionHintPresentation, { ObjectId = fountainId }, { Cooldown = 0 } )
			thread( InCombatText, fountainId, "UsePoisonCure", 1.75 )
		end
	end
end

function EndPoisonPresentation()
	local clearDuration = 0.3
	SetAnimation({ Name = "PoisonVignetteEnd", DestinationId = ScreenAnchors.PoisonVignetteId  })
	wait(clearDuration)
	Destroy({ Id = ScreenAnchors.PoisonVignetteId })
	ScreenAnchors.PoisonVignetteId = nil
	wait(0.5) -- additional 0.5s for flames to end
	CurrentRun.Hero.CurrentlyPoisoned = nil
end

function DoReactionPresentation( victim, reaction )

	if victim.BlockReactions then
		return
	end

	if reaction.ReactionSound ~= nil then
		PlaySound({ Name = reaction.ReactionSound, Id = victim.ObjectId, ManagerCap = 26 })
	end

	if reaction.ShakeScreenSpeed then
		ShakeScreen({ Speed = reaction.ShakeScreenSpeed, Distance = reaction.ShakeScreenDistance, FalloffSpeed = reaction.ShakeScreenFalloffSpeed, Duration = reaction.ShakeScreenDuration, })
		wait(reaction.ShakeScreenDuration)
	end

	if reaction.Shake then
		Shake({ Id = victim.ObjectId, Speed = reaction.ShakeSpeed, Distance = reaction.ShakeDistance, Duration = reaction.ShakeDuration, ApplyToChildren = true })
	end

	if reaction.CombatText then
		thread( InCombatText, victim.ObjectId, reaction.CombatText, 1.2 )
	end

	if reaction.DisappearDuration ~= nil then
		victim.BlockReactions = true
		SetAlpha({ Id = victim.ObjectId, Fraction = 0.0, Duration = 0.0 })
		wait( reaction.DisappearDuration, RoomThreadName )
		if victim.ReappearSound ~= nil then
			PlaySound({ Name = victim.ReappearSound, Id = victim.ObjectId, ManagerCap = 26 })
		end
		victim.BlockReactions = false
		local reappearDuration = 1.0
		SetAlpha({ Id = victim.ObjectId, Fraction = 1.0, Duration = reappearDuration })
		wait( reappearDuration, RoomThreadName )
	end

end

function ActivateFusePresentation( enemy )
	wait(0.05)
	if enemy.IsDead then
		return
	end
	if enemy.FuseAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.FuseAnimation })
	end
	if enemy.FlashOnFuse then
		Flash({ Id = enemy.ObjectId, Speed = 3, MinFraction = 0, MaxFraction = 0.5, Color = enemy.FlashOnFuseColor or Color.Yellow, Duration = enemy.FuseDuration })
	end
	if enemy.FuseActivationSound ~= nil then
		enemy.FuseSoundId = PlaySound({ Name = enemy.FuseActivationSound, Id = enemy.ObjectId })
	end
	if enemy.FuseWarningAnimation ~= nil then
		local damageRadius = nil
		if enemy.FuseWarningProjectileName ~= nil then
			damageRadius = GetBaseDataValue({ Type = "Projectile", Name = enemy.FuseWarningProjectileName, Property = "DamageRadius" })
		end
		CreateAnimation({ Name = enemy.FuseWarningAnimation, DestinationId = enemy.ObjectId, ScaleRadius = damageRadius })
	end
end

function PostActivatFusePresentation( enemy )
	if enemy.FuseWarningAnimation then
		StopAnimation({ Name = enemy.FuseWarningAnimation, DestinationId = enemy.ObjectId })
	end
	if enemy.FuseSoundId ~= nil then
		StopSound({ Id = enemy.FuseSoundId, Duration = 0.3 })
	end
end

function PostFuseRevivePresentation( enemy )
	if enemy.PostFuseReviveAnimation then
		SetAnimation({ Name = enemy.PostFuseReviveAnimation, DestinationId = enemy.ObjectId })
	end
end

-- Vibration

function DoWeaponHitRumble( weaponData, args )
	if weaponData.RumbleDistanceThreshold and ( not args.DistanceSquared or args.DistanceSquared == -1 or args.DistanceSquared > (weaponData.RumbleDistanceThreshold * weaponData.RumbleDistanceThreshold )) then
		return
	end	
	DoRumble( weaponData.HitRumbleParameters )
end

function DoWeaponChargeRumble( weaponData )
	if weaponData.ChargeRumbleParameters ~= nil then
		DoRumble( weaponData.ChargeRumbleParameters )
	end
end

--RumbleThreadName = "RumbleThread"

function DoRumble( args )
	if args == nil then
		return
	end
	--[[
	if HasThread( RumbleThreadName ) then
		return
	end
	]]
	for k, rumbleData in ipairs( args ) do
		--waitUnmodified( rumbleData.ScreenPreWait, RumbleThreadName )
		waitUnmodified( rumbleData.ScreenPreWait )
		if rumbleData.Fraction then
			Rumble({ Fraction = rumbleData.Fraction, Duration = rumbleData.Duration,
			LeftTriggerStart = rumbleData.LeftTriggerStart, LeftTriggerEnd = rumbleData.LeftTriggerEnd, LeftTriggerStrengthFraction = rumbleData.LeftTriggerStrengthFraction, LeftTriggerFrequencyFraction = rumbleData.LeftTriggerFrequencyFraction, LeftTriggerTimeout = rumbleData.LeftTriggerTimeout,
			RightTriggerStart = rumbleData.RightTriggerStart, RightTriggerEnd = rumbleData.RightTriggerEnd, RightTriggerStrengthFraction = rumbleData.RightTriggerStrengthFraction, RightTriggerFrequencyFraction = rumbleData.RightTriggerFrequencyFraction, RightTriggerTimeout = rumbleData.RightTriggerTimeout,
			IgnoreTriggersIfControlNotDefault = rumbleData.IgnoreTriggersIfControlNotDefault })
		else
			Rumble({ LeftFraction = rumbleData.LeftFraction, RightFraction = rumbleData.RightFraction, Duration = rumbleData.Duration,
			LeftTriggerStart = rumbleData.LeftTriggerStart, LeftTriggerEnd = rumbleData.LeftTriggerEnd, LeftTriggerStrengthFraction = rumbleData.LeftTriggerStrengthFraction, LeftTriggerFrequencyFraction = rumbleData.LeftTriggerFrequencyFraction, LeftTriggerTimeout = rumbleData.LeftTriggerTimeout,
			RightTriggerStart = rumbleData.RightTriggerStart, RightTriggerEnd = rumbleData.RightTriggerEnd, RightTriggerStrengthFraction = rumbleData.RightTriggerStrengthFraction, RightTriggerFrequencyFraction = rumbleData.RightTriggerFrequencyFraction, RightTriggerTimeout = rumbleData.RightTriggerTimeout,
			IgnoreTriggersIfControlNotDefault = rumbleData.IgnoreTriggersIfControlNotDefault })
		end
	end
end

function DoWeaponFireRadialBlur( weaponData )

	if weaponData == nil then
		return
	end
	if weaponData.FireRadialBlur ~= nil then
		DoWeaponRadialBlur( weaponData.FireRadialBlur )
	end
end

function GenericDamagePresentation( victim, triggerArgs )

	-- @todo Combine with other DamagePresentation()
	if victim.HitShield ~= nil and victim.HitShield > 0 then
		return
	end

	if victim.HealthBuffer ~= nil and victim.HealthBuffer > 0 then
		return
	end

	if triggerArgs.EffectName ~= nil and EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].CancelHitSpark  then
		return
	end

	local sourceProjectileData = nil
	if triggerArgs.SourceProjectile ~= nil then
		sourceProjectileData = ProjectileData[triggerArgs.SourceProjectile]
	end

	if sourceProjectileData and sourceProjectileData.CancelHitSpark then
		return
	end

	local angle = 0
	if triggerArgs.ImpactAngle ~= nil then
		angle = triggerArgs.ImpactAngle + 180
	end

	local damagedFx = GetDamagedFx( victim, sourceProjectileData, triggerArgs )
	if damagedFx ~= nil and not victim.SkipDamagedFx then
		local locationX = nil
		local locationY = nil
		local overrideLocation = nil
		if victim.DamagedFxAtImpactLocation and not triggerArgs.IgnoreDamagedFxAtImpactLocation then
			locationX = triggerArgs.ImpactLocationX
			locationY = triggerArgs.ImpactLocationY
			overrideLocation = true
		end
		CreateAnimation({ DestinationId = victim.ObjectId, Name = damagedFx,
			Angle = angle,
			LocationX = locationX,
			LocationY = locationY,
			OverrideLocation = overrideLocation,
			OffsetZ = (victim.ImpactLocationOffsetZ or 0) + (triggerArgs.ImpactLocationZ or 0),
			ManagerCap = 300, ManagerFrameCap = 14 })
	end

	if victim.HealthDamageSound ~= nil then
		PlaySound({ Name = victim.HealthDamageSound, Id = victim.ObjectId, ManagerCap = 52 })
	end

end

function GetDamagedFx( victim, sourceProjectileData, triggerArgs)
	if victim == CurrentRun.Hero and HasHeroTraitValue("MoneyShieldData") and triggerArgs.DamageAmount > 0 then
		local trait = HasHeroTraitValue("MoneyShieldData")
		if trait.MoneyShieldData.DamagedFxOverride then
			return trait.MoneyShieldData.DamagedFxOverride 
		end
	end
	if sourceProjectileData ~= nil then
		if sourceProjectileData.DamagedFx ~= nil then
			return sourceProjectileData.DamagedFx
		end
		if victim.DamagedFxStyles ~= nil and sourceProjectileData.DamagedFxStyle ~= nil and victim.DamagedFxStyles[sourceProjectileData.DamagedFxStyle] ~= nil then
			return victim.DamagedFxStyles[sourceProjectileData.DamagedFxStyle]
		end
	end

	if victim.DamagedFxStyles ~= nil then
		return victim.DamagedFxStyles.Default
	end

	return nil

end

function BlockedDamageInvulnerablePresentation( victim, triggerArgs )
	if CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		return
	end
	local angle = 0
	if triggerArgs.ImpactAngle ~= nil then
		angle = triggerArgs.ImpactAngle + 180
	end
	if victim.InvulnerableHitFx ~= nil then
		CreateAnimation({ DestinationId = victim.ObjectId, Name = victim.InvulnerableHitFx, Angle = angle, ManagerCap = 300, ManagerFrameCap = 14 })
	end
	if victim.InvulnerableHitFlash then
		Flash({ Id = victim.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.15, ExpireAfterCycle = true })
		PlaySound({ Name = victim.InvulnerableHitSound or "/SFX/Enemy Sounds/Exalted/EnemyShieldBlock", Id = victim.ObjectId })
	end
	if victim.InvulnerableBlockHint and CheckCooldown( "BlockHint"..victim.ObjectId, 0.2 ) then
		thread( InCombatText, victim.ObjectId, "BlockHit", 0.4, { SkipShadow = true } )
	end
end

function KillPresentation( victim, killer, args )

	if args.Silent then
		return
	end

	if victim.DeathAnimation ~= nil and not victim.ManualDeathAnimation then
		SetAnimation({ Name = victim.DeathAnimation, DestinationId = victim.ObjectId })
		if victim.SkipDestroy then
			RecordObjectState( CurrentRun.CurrentRoom, victim.ObjectId, "Animation", victim.DeathAnimation )
		end
	end
	if victim.DeathFx ~= nil then
		CreateAnimation({ Name = victim.DeathFx, DestinationId = victim.ObjectId, Angle = args.ImpactAngle })
	end
	if not args.SuppressSounds then
		if victim.DeathSound ~= nil then
			PlaySound({ Name = victim.DeathSound, Id = victim.ObjectId, ManagerCap = victim.DeathSoundManagerCap or 46 })
		end
		if victim.OnKillVoiceLines ~= nil then
			thread( PlayVoiceLines, victim.OnKillVoiceLines, true )
		end
	end
	
	if victim.OnDeathShakeScreenSpeed ~= nil then
		local distanceToPlayer = GetDistance({ Id = args.triggeredById, DestinationId = CurrentRun.Hero.ObjectId })
		local shakeSpeed = victim.OnDeathShakeScreenSpeed or 0
		local shakeDistance = victim.OnDeathShakeScreenDistance or 0
		local shakeDuration = victim.OnDeathShakeScreenDuration or 0
		if distanceToPlayer > 500 and distanceToPlayer <= 1000 then
			shakeSpeed = shakeSpeed * 0.75
			shakeDistance = shakeDistance * 0.75
			shakeDuration = shakeDuration * 0.75
		elseif distanceToPlayer > 1000 then
			shakeSpeed = shakeSpeed * 0.5
			shakeDistance = shakeDistance * 0.5
			shakeDuration = shakeDuration * 0.5
		end
		ShakeScreen({ Speed = shakeSpeed, Distance = shakeDistance, Duration = shakeDuration, FalloffSpeed = victim.OnDeathShakeScreenFalloff, Angle = victim.OnDeathShakeScreenAngle })
	end

	if killer ~= nil and victim ~= nil and killer.NonHeroKillCombatText ~= nil and not victim.HideHealthBar and victim ~= CurrentRun.Hero then
		if killer.NonHeroKillCombatTextUsePlayerSource then
			if CheckCooldown( "TrapKillTextCooldown", 0.6 ) then
				thread( InCombatText, CurrentRun.Hero.ObjectId, killer.NonHeroKillCombatText, 0.8, { SkipShadow = true } )
			end
		else
			if CheckCooldown( "TrapKillTextCooldown", 0.6 ) then
				thread( InCombatText, killer.ObjectId, killer.NonHeroKillCombatText, 0.8, { SkipShadow = true } )
			end
		end
	end

	if args.SourceProjectile ~= nil and ProjectileData[args.SourceProjectile] ~= nil and ProjectileData[args.SourceProjectile].KillPresentationCombatTextEnemyTeam ~= nil then
		if Contains(victim.Groups, "EnemyTeam") then
			thread( InCombatText, victim.ObjectId, ProjectileData[args.SourceProjectile].KillPresentationCombatTextEnemyTeam, 0.8, { SkipShadow = true } )
		end
	end
end

function EquipPlayerWeaponPresentation( weaponData, args )
	wait( 0.02 )
	if not args.SkipSound then
		PlaySound({ Name = "/SFX/Menu Sounds/WeaponEquipChunk", Id = CurrentRun.Hero.ObjectId })
	end
	thread( PlayVoiceLines, weaponData.EquipVoiceLines, false )
	thread( HideAxeUI, args )
	thread( HideDaggerUI, args )
	thread( HideLobUI, args )
	thread( HideSuitUI, args )
	if weaponData.ShowAmmoUI and ShowingCombatUI then
		thread( ShowAmmoUI )
	else
		thread( HideAmmoUI )
	end
end

function UnitActivatePresentation( unit, args )

	SetThingProperty({ Property = "StopsProjectiles", Value = false, DestinationId = unit.ObjectId })

	if unit.DoActivateFxAtNearestTypeId ~= nil then
		if MapState.TypeIdsCache[unit.DoActivateFxAtNearestTypeId] == nil then
			MapState.TypeIdsCache[unit.DoActivateFxAtNearestTypeId] = GetIdsByType({ Name = unit.DoActivateFxAtNearestTypeId })
		end
		unit.ActivateFxDestination = GetClosest({ Id = unit.ObjectId, DestinationIds = MapState.TypeIdsCache[unit.DoActivateFxAtNearestTypeId] })
		if unit.ActivateFxDestination == 0 then
			unit.ActivateFxDestination = nil
		end
	end

	if unit.ActivateFx ~= nil then
		CreateAnimation({ Name = unit.ActivateFx, DestinationId = unit.ActivateFxDestination or unit.ObjectId })
	end

	if unit.ActivateFx2 ~= nil then
		CreateAnimation({ Name = unit.ActivateFx2, DestinationId = unit.ActivateFxDestination or unit.ObjectId })
	end

	if unit.ActivateStartOffsetZ ~= nil then
		AdjustZLocation({ Id = unit.ObjectId, Distance = unit.ActivateStartOffsetZ })
	end
	if unit.ActivateFallForce ~= nil then
		ApplyUpwardForce({ Id = unit.ObjectId, Speed = -unit.ActivateFallForce })
	end
	local originalGravity = nil
	if unit.ActivateGravity ~= nil then
		originalGravity = GetThingDataValue({ Id = unit.ObjectId, Property = "Gravity" })
		SetThingProperty({ DestinationId = unit.ObjectId, Property = "Gravity", Value = unit.ActivateGravity })
	end

	local originalSpeed = nil
	local previousUnitCollide = nil
	local moveToId = nil
	if unit.ActivateSwoopPresentation then
		moveToId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = unit.ObjectId })
		originalSpeed = GetUnitDataValue({ Id = unit.ObjectId, Property = "Speed" })
		local randomOffsetX = RandomInt( 1000, 1000 )
		local randomOffsetY = RandomInt( 600, 600 )
		if RandomChance( 0.5 ) then
			randomOffsetX = randomOffsetX * -1
		elseif RandomChance( 0.5 ) then
			randomOffsetY = randomOffsetY * -1
		end
		local randomScale = RandomFloat( 2.0, 3.0 )
		SetScale({ Id = unit.ObjectId, Fraction = randomScale })
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = "CollideWithUnits", Value = false })
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = "CollideWithObstacles", Value = false })
		SetThingProperty({ DestinationId = unit.ObjectId, Property = "StopsProjectiles", Value = false })
		Teleport({ Id = unit.ObjectId, OffsetX = randomOffsetX, OffsetY = randomOffsetY, UseCurrentLocation = true })
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = "Speed", Value = 800 })
		Move({ Id = unit.ObjectId, DestinationId = moveToId, SuccessDistance = 32 })
		SetScale({ Id = unit.ObjectId, Fraction = 1.0, Duration = 1.0 })
	end

	if unit.ActivateTint then
		SetColor({ Id = unit.ObjectId, Color = {0,0,0,1} })
		thread( TintUnitActivation, unit )
	end

	if unit.ActivateStartAlpha then
		SetAlpha({ Id = unit.ObjectId, Fraction = unit.ActivateStartAlpha or 1.0 })
	end

	if unit.ActivateFadeIn then
		thread( FadeUnitActivation, unit )
	end

	if unit.ActivateScaleIn then
		SetScale({ Id = unit.ObjectId, Fraction = 0, Duration = 0 })
		SetScale({ Id = unit.ObjectId, Fraction = 1, Duration = unit.ActivateScaleInDuration or 1.0 })
		thread( TintUnitActivation, unit )
	end

	if unit.ActivateAnimation ~= nil then
		SetAnimation({ Name = unit.ActivateAnimation, DestinationId = unit.ObjectId })
	end

	if unit.ActivateFxPreSpawn ~= nil then
		thread( PreSpawnFx, unit )
	end

	if unit.ActivateVerticalForce ~= nil and not args.IgnoreActivateVerticalForce then
		ApplyUpwardForce({ Id = unit.ObjectId, Speed = unit.ActivateVerticalForce })
	end

	if unit.ActivateWaitForAnimation and unit.ActivateAnimation ~= nil then
		local activateNotify = "ActivateWaitForAnimation"..unit.ObjectId
		NotifyOnAnimationTimeRemaining({ Id = unit.ObjectId, Animation = unit.ActivateAnimation, Remaining = 0.01, Notify = activateNotify, Timeout = 9.0 })
		waitUntil( activateNotify )
	else
		local activateDuration = (unit.ActivateDuration or 0.3) / unit.SpeedMultiplier
		--DebugPrint({ Text = "activateDuration = "..activateDuration })
		wait( activateDuration, "Activating"..unit.ObjectId )
	end

	if unit.ActivateGravity ~= nil then
		SetThingProperty({ DestinationId = unit.ObjectId, Property = "Gravity", Value = originalGravity })
	end

	if unit.ActivateSwoopPresentation then

		local moveNotify = "ActivateMove"..unit.ObjectId
		NotifyWithinDistance({ Id = unit.ObjectId, DestinationId = moveToId, Distance = 80, Notify = moveNotify, Timeout = 9.0 })
		waitUntil( moveNotify )
		Destroy({ Id = moveToId })

		SetUnitProperty({ DestinationId = unit.ObjectId, Property = "Speed", Value = originalSpeed })
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = "CollideWithUnits", Value = true })
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = "CollideWithObstacles", Value = true })
		SetThingProperty({ DestinationId = unit.ObjectId, Property = "StopsProjectiles", Value = true })
	end

	if unit.ActivateMoveToSpawnPoint then
		if unit.ActivateMoveInvulnerable then
			SetUnitInvulnerable( unit, "UnitActivatePresentation" )
		end

		local nearbySpawnPoint = SelectSpawnPoint(CurrentRun.CurrentRoom, unit, { SpawnNearId = unit.ObjectId, SpawnRadius = unit.OnActivateMoveRadius or 400  })
		Move({ Id = unit.ObjectId, DestinationId = nearbySpawnPoint, SuccessDistance = 32 })

		if unit.ActivateWaitForMove then
			local moveNotify = "ActivateMoveToSpawnPoint"..unit.ObjectId
			NotifyWithinDistance({ Id = unit.ObjectId, DestinationId = nearbySpawnPoint, Distance = 40, Notify = moveNotify, Timeout = unit.OnActivateMoveTimeout or 1.5 })
			waitUntil( moveNotify )
		end

		if unit.ActivateMoveInvulnerable then
			SetUnitVulnerable( unit, "UnitActivatePresentation" )
		end
	end

	if unit.PostActivateAnimation ~= nil then
		SetAnimation({ DestinationId = unit.ObjectId, Name = unit.PostActivateAnimation })
	end

	if unit.PostActivateScreenshake ~= nil then
		if unit.PostActivateScreenshake.DistanceThreshold ~= nil then
			local unitDistanceSquared = GetDistance({ Id = unit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })^2
			if unitDistanceSquared ~= -1 and unitDistanceSquared <= ( unit.PostActivateScreenshake.DistanceThreshold * unit.PostActivateScreenshake.DistanceThreshold ) then
				ShakeScreen( unit.PostActivateScreenshake )
			end
		else
			ShakeScreen( unit.PostActivateScreenshake )
		end
	end

	if unit.PostActivateStop then
		Stop({ Id = unit.ObjectId })
	end

	SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationId = unit.ObjectId })
end

function PreSpawnFx( unit )
	if unit.ActivateFxPreSpawn ~= nil then
		wait( (unit.ActivateFxPreSpawnDelay or 0) / unit.SpeedMultiplier )
		CreateAnimation({ Name = unit.ActivateFxPreSpawn, DestinationId = unit.ObjectId })
		if unit.ActivateFxPreSound ~= nil then
			PlaySound({ Name = unit.ActivateFxPreSound, Id = unit.ObjectId })
		end
	end
end

function FadeUnitActivation( unit )
	wait( (unit.ActivateFadeInDelay or 0) / unit.SpeedMultiplier )
	SetAlpha({ Id = unit.ObjectId, Fraction = 0 })
	SetAlpha({ Id = unit.ObjectId, Fraction = 1.0, Duration = unit.ActivateFadeInDuration or 2.0 })
end

function TintUnitActivation( unit )
	wait( (unit.ActivateTintDelay or 0) / unit.SpeedMultiplier )
	SetColor({ Id = unit.ObjectId, Color = {0, 0, 0, 1} })
	SetColor({ Id = unit.ObjectId, Color = {1, 1, 1, 1}, Duration = unit.ActivateTintDuration or 2.0 })
end

function UnusedWeaponBonusPresentation()
	CreateAnimation({ Name = "BonesSparkleBurst", DestinationId = CurrentRun.Hero.ObjectId })
	
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/StickInteract", Id = HUDScreen.Components.InventoryIcon.Id })
end

PolymorphPresentationData =
{
	Sheep =
	{
		SpeedModifier = 0.35,
		ApplyPlaySounds =
		{
			"/Leftovers/SFX/BallTossWyrm",
			"/VO/MelinoeEmotes/EmoteSheepStartled",
		},
		ApplyCreateAnimations =
		{
	        "HecatePolymorphDissipate2",
	        "HecatePolymorphDisplace",
	        "HecateCloneDeathFx",
	        "HecateCloneDeathFx2",
		},
		DisableAnimFreeze = true,
		ThingProperties =
		{
			{
				GrannyModel = "PolyphemusSheep_Mesh",
			},
			{
				Graphic = "Enemy_Sheep_Idle",
			},
		},
		LifeProperties =
		{
			InvulnerableCoverage = 0,
		},
		UnitProperties =
		{
			MoveGraphic = "Enemy_Sheep_Move",
			StartGraphic = "nil",
			StopGraphic = "Enemy_Sheep_MoveStop",
		},
		WeaponProperties = 
		{
			TriggerReleaseGraphic = "nil",
			FireEndGraphic = "nil",
		},
		StunAnimations = 
		{
			Default = "Enemy_Sheep_OnHit_Mel",
		},

		LuaProperties = 
		{
			DamagedAnimation = "Enemy_Sheep_OnHit_Mel",
			SkipDamageAnimation = false,
		},
		ClearPlaySounds =
		{
			"/SFX/Enemy Sounds/Hades/HadesAmmoExitPoof",
			"/VO/MelinoeEmotes/EmoteGasping",
		},
		ClearCreateAnimations =
		{
			"TeleportDisappearSmall",
		},
		WeaponNames =
		{
			"WeaponMorphedBlink",
			"WeaponMorphedAttack",
		}
	},

	Pig =
	{
		SpeedModifier = 0.25,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "O_Story01" }
			}
		},

		ApplyPlaySounds =
		{
			"/Leftovers/SFX/BallTossWyrm",
			"/VO/MelinoeEmotes/EmotePigStartled",
		},
		ApplyCreateAnimations =
		{
	        "HecatePolymorphDissipate2",
	        "HecatePolymorphDisplace",
	        "HecateCloneDeathFx",
	        "HecateCloneDeathFx2",
		},
		DisableAnimFreeze = true,
		ThingProperties =
		{
			{
				GrannyModel = "Pig_Mesh",
			},
			{
				Graphic = "Enemy_Pig_Idle",
			},
		},
		LifeProperties =
		{
			InvulnerableCoverage = 0,
		},
		UnitProperties =
		{
			MoveGraphic = "Enemy_Pig_Move",
			StartGraphic = "nil",
			StopGraphic = "Enemy_Pig_MoveStop",
		},
		WeaponProperties = 
		{
			TriggerReleaseGraphic = "nil",
			FireEndGraphic = "nil",
		},
		LuaProperties = 
		{
			DamagedAnimation = "Enemy_Pig_OnHit_Mel",
			SkipDamageAnimation = false,
		},
		ClearPlaySounds =
		{
			"/SFX/Enemy Sounds/Hades/HadesAmmoExitPoof",
			"/VO/MelinoeEmotes/EmoteGasping",
		},
		ClearCreateAnimations =
		{
			"TeleportDisappearSmall",
		},
		WeaponNames =
		{
			"WeaponMorphedBlink_Pig",
			"WeaponMorphedAttack_Pig",
		}
	},

	Rat =
	{
		SpeedModifier = 0.6,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "F_Boss02" }
			}
		},

		ApplyPlaySounds =
		{
			"/Leftovers/SFX/BallTossWyrm",
			"/VO/MelinoeEmotes/EmoteRatStartled",
		},
		ApplyCreateAnimations =
		{
	        "HecatePolymorphDissipate2",
	        "HecatePolymorphDisplace",
	        "HecateCloneDeathFx",
	        "HecateCloneDeathFx2",
		},
		DisableAnimFreeze = true,
		ThingProperties =
		{
			{
				GrannyModel = "RatThugGiant_Mesh",
			},
			{
				GrannyTexture = "GR2/RatThugWhite_Color",
			},
			{
				Graphic = "Melinoe_Crawler_Idle",
			},
		},
		LuaProperties = 
		{
			DamagedSound = "/VO/MelinoeEmotes/EmoteRatHit",
			SkipDamageAnimation = true,
		},
		LifeProperties =
		{
			InvulnerableCoverage = 0,
		},
		UnitProperties =
		{
			MoveGraphic = "Melinoe_Crawler_Move",
			StartGraphic = "nil",
			StopGraphic = "nil",
		},
		WeaponProperties = 
		{
			TriggerReleaseGraphic = "nil",
			FireEndGraphic = "nil",
		},
		StunAnimations = 
		{
			--Default = "Enemy_SatyrRat_OnHit",
		},
		ClearPlaySounds =
		{
			"/SFX/Enemy Sounds/Hades/HadesAmmoExitPoof",
			"/VO/MelinoeEmotes/EmoteGasping",
		},
		ClearCreateAnimations =
		{
			"TeleportDisappearSmall",
		},
		WeaponNames =
		{
			"WeaponMorphedBlink_Rat",
			"WeaponMorphedAttack_Rat",
		},
	},

	YoungMel =
	{
		Scale = 1.2,
		ApplyPlaySounds =
		{
			"/Leftovers/SFX/BallTossWyrm",
			--"/VO/MelinoeEmotes/EmoteSheepStartled",
		},
		ApplyCreateAnimations =
		{
	        "HecatePolymorphDissipate2",
	        "HecatePolymorphDisplace",
	        "HecateCloneDeathFx",
	        "HecateCloneDeathFx2",
		},
		DisableAnimFreeze = true,
		ThingProperties =
		{
			{
				GrannyModel = "YoungMel_Mesh",
			},
			{
				Graphic = "Melinoe_Young_Idle",
			},
			{
				Grip = 5000,
			}
		},
		LifeProperties =
		{
			InvulnerableCoverage = 0,
		},
		UnitProperties =
		{
			MoveGraphic = "Melinoe_Young_Run_FireLoop",
			StartGraphic = "Melinoe_Young_Run_Start",
			StopGraphic = "Melinoe_Young_Run_End",
			Speed = 320
		},
		WeaponProperties = 
		{
			TriggerReleaseGraphic = "nil",
			FireEndGraphic = "nil",
		},
		SwapAnimations = 
		{
			MelinoeInteract = "Melinoe_Young_Interact_Start"
		},
		LuaProperties = 
		{
			DamagedAnimation = "Melinoe_Young_GetHit",
			LastStandAnimationOverride = "Melinoe_Young_GetHit_LastStand",
			LastStandFireAnimationOverride = "Melinoe_Young_LastStand_Fire",
		},
		ClearPlaySounds =
		{
			"/SFX/Enemy Sounds/Hades/HadesAmmoExitPoof",
			"/VO/MelinoeEmotes/EmoteGasping",
		},
		ClearCreateAnimations =
		{
			"TeleportDisappearSmall",
		},
	}
}

function PolymorphApplyPresentation( triggerArgs, args )
	args = args or {}
	local victim = triggerArgs.Victim
	local polymorphData = PolymorphPresentationData.Sheep
	if args.PolymorphType ~= nil then
		polymorphData = PolymorphPresentationData[args.PolymorphType]
	end

	if args ~= nil and args.BossPolymorph then
		thread( PolymorphSimSlow )
	end
	PlaySound({ Name = "/SFX/Player Sounds/MelStaffFissureSizzle", Id = victim.ObjectId, ManagerCap = 50 })

	if not args.SkipPolymorphText then
		thread( InCombatTextArgs, { TargetId = victim.ObjectId, Text = "Polymorphed", ShadowScaleX = 0.6, PreDelay = 0.1, Duration = 1.5, OffsetY = -20 } )
	end

	victim.SpeechParams = victim.SpeechParams or {}
	victim.SpeechParams.Chipmunk = 1
	if victim == CurrentRun.Hero then
		SetAudioEffectState({ Name = "Chipmunk", Value = 0.5 })
	end

	EndRamWeapons({ Id = victim.ObjectId })
	if not triggerArgs.Reapplied then
		if victim.HealthBarAttachToMarkerName and EnemyHealthDisplayAnchors[victim.ObjectId] then
			local offsetY = ConstantsData.DefaultHealthBarOffsetY
			if victim.Scale ~= nil then
				offsetY = offsetY * victim.Scale
			end
			if victim.HealthBarOffsetY then
				offsetY = victim.HealthBarOffsetY
			end
			Unattach({ Ids = 
			{
				EnemyHealthDisplayAnchors[victim.ObjectId.."back"],
				EnemyHealthDisplayAnchors[victim.ObjectId],
				EnemyHealthDisplayAnchors[victim.ObjectId.."falloff"],
				victim.ScorchHealthBarId,
			}, DestinationId = victim.ObjectId }) 
			
			Attach({ Id = EnemyHealthDisplayAnchors[victim.ObjectId.."back"], DestinationId = victim.ObjectId, OffsetY = offsetY }) 
			Attach({ Id = EnemyHealthDisplayAnchors[victim.ObjectId], DestinationId = victim.ObjectId, OffsetY = offsetY }) 
			Attach({ Id = EnemyHealthDisplayAnchors[victim.ObjectId.."falloff"], DestinationId = victim.ObjectId, OffsetY = offsetY }) 
			if victim.ScorchHealthBarId ~= nil then
				Attach({ Id = victim.ScorchHealthBarId, DestinationId = victim.ObjectId, OffsetY = offsetY }) 
			end
		end

		for k, soundName in ipairs( polymorphData.ApplyPlaySounds ) do
			PlaySound({ Name = soundName, Id = triggerArgs.triggeredById, ManagerCap = 46 })
		end
		for k, animName in ipairs( polymorphData.ApplyCreateAnimations ) do
			CreateAnimation({ Name = animName, DestinationId =  triggerArgs.triggeredById })
		end

		if polymorphData.DisableAnimFreeze then
			SetThingProperty({ Property = "AnimFreeze", Value = false, DestinationId = victim.ObjectId, DataValue = false })
		end
			
		for effectName in pairs( victim.ActiveEffects ) do
			local effectData = EffectData[effectName]
			if effectData and effectData.DisplaySuffix then
				if effectData.AttachIconToUnit and effectData.AttachToMarker and victim.UniqueIconAttachments and victim.UniqueIconAttachments[effectData.DisplaySuffix] then
					Unattach({ Id = victim.CreatedDisplayAnchors[ victim.ObjectId .. effectData.DisplaySuffix ], DestinationId = victim.ObjectId, OffsetY = effectData.IconYOffset, OffsetX = effectData.IconXOffset })
					Attach({ Id = victim.CreatedDisplayAnchors[ victim.ObjectId .. effectData.DisplaySuffix ], DestinationId = victim.ObjectId, OffsetY = effectData.IconYOffset, OffsetX = effectData.IconXOffset })
				end
			end
		end
		local anim = nil
		for i, propertyChange in ipairs( polymorphData.ThingProperties ) do
			for key, value in pairs( propertyChange ) do
				if key == "Graphic" then
					anim = value
				end
				victim["PrePolymorph"..key] = GetThingDataValue({ Property = key, Id = victim.ObjectId })
				if value == "nil" then
					value = nil
				end
				if key == "GrannyModel" and victim.PolymorphModelOverride then
					value = victim.PolymorphModelOverride
				end
				if key == "GrannyTexture" then
					victim["PrePolymorph"..key] = "nil"
				end
				SetThingProperty({ Property = key, Value = value, DestinationId = victim.ObjectId })
			end
		end
		if victim.Weapons then
			for key, value in pairs( polymorphData.WeaponProperties ) do
				for weaponName in pairs( victim.Weapons ) do
					victim["PrePolymorph"..weaponName..key] = GetWeaponDataValue({ WeaponName = weaponName, Property = key, Id = victim.ObjectId })
					if value == "nil" then
						value = nil
					end
					SetWeaponProperty({ WeaponName = weaponName, Property = key, Value = value, DestinationId = victim.ObjectId })
				end
			end
		end
		if victim.StunAnimations then
			for key, value in pairs(victim.StunAnimations) do
				local newValue = polymorphData.StunAnimations[key]
				if newValue then
					victim["PrePolymorphStunAnimation"..key] = value
				end
				victim.StunAnimations[key] = newValue
			end
		end
		if anim ~= nil then
			SetAnimation({ Name = anim, DestinationId = victim.ObjectId })
		end
		if polymorphData.SwapAnimations then
			for fromAnim, toAnim in pairs( polymorphData.SwapAnimations ) do
				SwapAnimation({ Name = fromAnim, DestinationName = toAnim })
			end
		end
		if polymorphData.LuaProperties then
			for key, value in pairs( polymorphData.LuaProperties ) do
				victim["PrePolymorph"..key] = victim[key]
				if value == "nil" then
					value = nil
				end
				victim[key] = value
			end
		end
		for key, value in pairs( polymorphData.UnitProperties ) do
			victim["PrePolymorph"..key] = GetUnitDataValue({ Property = key, Id = victim.ObjectId })
			if value == "nil" then
				value = nil
			end
			SetUnitProperty({ Property = key, Value = value, DestinationId = victim.ObjectId })
		end

		for key, value in pairs( polymorphData.LifeProperties ) do
			victim["PrePolymorph"..key] = GetLifeDataValue({ Property = key, Id = victim.ObjectId })
			if value == "nil" then
				value = nil
			end
			local dataValue = true
			if key == "InvulnerableCoverage" then
				dataValue = false
			end
			SetLifeProperty({ Property = key, Value = value, DestinationId = victim.ObjectId, DataValue = dataValue })
		end
		if args ~= nil and args.BossPolymorph then
			AdjustZoom({ Fraction = 1.05, LerpTime = 0.1, Duration = 99999 })
		end
		if polymorphData.Scale ~= nil or victim.PolymorphScaleOverride then
			SetScale({ Id = victim.ObjectId, Fraction = polymorphData.Scale or victim.PolymorphScaleOverride, Duration = 0 })
		end
	end
	if victim ~= CurrentRun.Hero then
		thread( PlayVoiceLines, GlobalVoiceLines.SpellPolymorphReactionVoiceLines )
		SetThingProperty({ Property = "GrannyTexture", Value = "", DestinationId = victim.ObjectId })
	end

end

function PolymorphSimSlow()
	wait( 0.02 )
	AddSimSpeedChange( "Polymorph", { Fraction = 0.2, LerpTime = 0.3, Priority = true } )
	waitUnmodified( 1.4 )
	RemoveSimSpeedChange( "Polymorph", { LerpTime = 0.05 } )
end

function PolymorphClearPresentation( triggerArgs, args )
	local victim = triggerArgs.Victim
	if victim.IsDead then
		return
	end
	local polymorphData = PolymorphPresentationData.Sheep
	if args and args.PolymorphType ~= nil then
		polymorphData = PolymorphPresentationData[args.PolymorphType]
	end
	
	victim.SpeechParams = victim.SpeechParams or {}
	victim.SpeechParams.Chipmunk = nil
	if victim == CurrentRun.Hero then
		SetAudioEffectState({ Name = "Chipmunk", Value = GetTotalHeroTraitValue("BaseChipmunkValue") })
	elseif victim.GrannyTexture then
		SetThingProperty({ Property = "GrannyTexture", Value = victim.GrannyTexture, DestinationId = victim.ObjectId })
	end
	
	for effectName in pairs( victim.ActiveEffects ) do
		local effectData = EffectData[effectName]
		if effectData and effectData.DisplaySuffix then
			if effectData.AttachIconToUnit and effectData.AttachToMarker and victim.UniqueIconAttachments and victim.UniqueIconAttachments[effectData.DisplaySuffix] then
				Unattach({ Id = victim.CreatedDisplayAnchors[ victim.ObjectId .. effectData.DisplaySuffix ], DestinationId = victim.ObjectId, OffsetY = effectData.IconYOffset, OffsetX = effectData.IconXOffset })
				Attach({ Id = victim.CreatedDisplayAnchors[ victim.ObjectId .. effectData.DisplaySuffix ], DestinationId = victim.ObjectId, OffsetY = effectData.IconYOffset, OffsetX = effectData.IconXOffset, MarkerName = victim.UniqueIconAttachments[effectData.DisplaySuffix] })
			end
		end
	end
	for k, soundName in ipairs( polymorphData.ClearPlaySounds ) do
		PlaySound({ Name = soundName, Id = victim.ObjectId, ManagerCap = 46 })
	end
	for k, animName in ipairs( polymorphData.ClearCreateAnimations ) do
		CreateAnimation({ Name = animName, DestinationId =  victim.ObjectId })
	end

	if polymorphData.DisableAnimFreeze then
		SetThingProperty({ Property = "AnimFreeze", Value = false, DestinationId = victim.ObjectId, DataValue = false })
	end

	for i, propertyChange in ipairs( polymorphData.ThingProperties ) do
		for key, value in pairs( propertyChange ) do
			SetThingProperty({ Property = key, Value = victim["PrePolymorph"..key], DestinationId = victim.ObjectId })
		end
	end
	if polymorphData.SwapAnimations then
		for fromAnim, toAnim in pairs( polymorphData.SwapAnimations ) do
			SwapAnimation({ Name = fromAnim, Reverse = true })
		end
	end
	if polymorphData.Scale ~= nil or victim.PolymorphScaleOverride then
		SetScale({ Id = victim.ObjectId, Fraction = 1, Duration = 0 })
	end
	if victim.PrePolymorphGraphic ~= nil then
		SetAnimation({ Name = victim.PrePolymorphGraphic, DestinationId = victim.ObjectId })
	end
	if victim.StunAnimations then 
		for key, value in pairs( polymorphData.StunAnimations ) do
			victim.StunAnimations[key] = victim["PrePolymorphStunAnimation"..key]
		end
	end
	if victim.Weapons then
		for weaponName in pairs( victim.Weapons ) do
			for key, value in pairs( polymorphData.WeaponProperties ) do
				SetWeaponProperty({ WeaponName = weaponName, Property = key, Value = victim["PrePolymorph"..weaponName..key], DestinationId = victim.ObjectId })
			end
		end
	end
	
	for key, value in pairs( polymorphData.UnitProperties ) do
		SetUnitProperty({ Property = key, Value = victim["PrePolymorph"..key], DestinationId = victim.ObjectId })
	end
	for key, value in pairs( polymorphData.LifeProperties ) do
		local dataValue = true
		if key == "InvulnerableCoverage" then
			dataValue = false
		end
		SetLifeProperty({ Property = key, Value = victim["PrePolymorph"..key], DestinationId = victim.ObjectId, DataValue = dataValue })
	end
	if polymorphData.LuaProperties then
		for key, value in pairs( polymorphData.LuaProperties ) do
			if victim["PrePolymorph"..key] == "nil" then
				victim[key] = nil
			else
				victim[key] = victim["PrePolymorph"..key]
			end
		end
	end
	if victim.HealthBarAttachToMarkerName and EnemyHealthDisplayAnchors[victim.ObjectId] then
		local offsetY = ConstantsData.DefaultHealthBarOffsetY
		if victim.Scale ~= nil then
			offsetY = offsetY * victim.Scale
		end
		if victim.HealthBarOffsetY then
			offsetY = victim.HealthBarOffsetY
		end

		Attach({ Id = EnemyHealthDisplayAnchors[victim.ObjectId.."back"], DestinationId = victim.ObjectId, MarkerName = victim.HealthBarAttachToMarkerName,OffsetY = offsetY }) 
		Attach({ Id = EnemyHealthDisplayAnchors[victim.ObjectId], DestinationId = victim.ObjectId, MarkerName = victim.HealthBarAttachToMarkerName, OffsetY = offsetY }) 
		Attach({ Id = EnemyHealthDisplayAnchors[victim.ObjectId.."falloff"], DestinationId = victim.ObjectId, MarkerName = victim.HealthBarAttachToMarkerName, OffsetY = offsetY }) 
		if victim.ScorchHealthBarId ~= nil then
			Attach({ Id = victim.ScorchHealthBarId, DestinationId = victim.ObjectId, MarkerName = victim.HealthBarAttachToMarkerName, OffsetY = offsetY }) 
		end
	end
	if args ~= nil and args.BossPolymorph and CurrentRun.CurrentRoom.ZoomFraction then
		AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.0, Duration = 999999 })
	end

end



function HeroRootApplyPresentation( triggerArgs )
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteStunned", Id = triggerArgs.triggeredById, Delay = 0.1 })
end

function HeroRootClearPresentation( triggerArgs )
end


function CastArmedPresentation( weaponData )
end

function GetHideChargeDuration( weaponData )
	if not weaponData.HideChargeDuration or weaponData.HideChargeDuration <= 0 then
		return 0
	end
	local chargeTime = weaponData.HideChargeDuration * GetLuaWeaponSpeedMultiplier( weaponData.Name )
	if weaponData.HideChargeDurationIncludesBlinkDuration then
		local blinkDuration = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponBlink", Property = "BlinkDuration" }) + GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponBlink", Property = "ChargeTime" })
		if _worldTimeUnmodified < ( MapState.LastBlinkTimeUnmodified + blinkDuration) then
			chargeTime = chargeTime + (MapState.LastBlinkTimeUnmodified + blinkDuration) - _worldTimeUnmodified
		end
	end
	local minChargeTime = weaponData.MinWeaponChargeTime or WeaponData.DefaultWeaponValues.MinWeaponChargeTime
	if chargeTime < minChargeTime then
		return minChargeTime
	end
	return chargeTime
end

function HandleManaChargeIndicator( triggerArgs )

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if SessionMapState.BlockStagedCharge[triggerArgs.name] or SessionMapState.WeaponsDisabled then
		return
	end
	local groupName = "Combat_Menu_Backing"

	local weaponData = GetWeaponData( CurrentRun.Hero, triggerArgs.name )
	if weaponData.ArmedCastChargeStage and not IsEmpty(MapState.CastArmDisable) then
		return
	end
	local duckChargeTime = GetHideChargeDuration( weaponData )
	local chargeTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = triggerArgs.name, Property = "ChargeTime" })
	local chargePercent = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = triggerArgs.name, Property = "MinChargeToFire" })
	
	if not IsEmpty(weaponData.ChargeWeaponStages) then
		chargeTime = weaponData.ChargeWeaponStages[1].Wait * GetLuaWeaponSpeedMultiplier( weaponData.Name )
		chargePercent = 1
	end
	local autoFire = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = triggerArgs.name, Property = "LockTriggerForCharge" }) 
		
	local indicatorData = ManaIndicatorPresentation.AutoComplete
	if not autoFire or GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = triggerArgs.name, Property = "RefreshProjectileOnFire" }) then
		indicatorData = ManaIndicatorPresentation.Hold
	end
	local manaCost = GetManaCost( weaponData, true, { ManaCostOverride = weaponData.ManaDisplayOverride } )
	local reserveMana = false
	if manaCost == 0 and GetManaReservationCost( weaponData ) > 0 then
		manaCost = GetManaReservationCost( weaponData ) 
		reserveMana = true
	end
	if manaCost == 0 and weaponData.ChargeWeaponStages and weaponData.ChargeWeaponStages[1].ManaCost then
		manaCost = GetManaCost( weaponData, false, { ManaCostOverride = weaponData.ChargeWeaponStages[1].ManaCost })
	end
	local weaponName = triggerArgs.name
	
	local notifyName = weaponName.."IndicatorFire"
	
	if HasThread( notifyName ) then
		return
	end
	if HasWaitUntil( notifyName ) then
		return 
	end
	if weaponData.SkipManaIndicatorIfZeroManaCost and manaCost == 0 then
		return
	end

	if weaponData.SkipManaIndicatorIfOutOfMana and CurrentRun.Hero.Mana < manaCost and not LastMomentManaRestoreEligible(manaCost) then
		return
	end
	
	MapState.ChargedManaWeapons[weaponName] = false
	notifyExistingWaiters("ChargeManaWeaponStart")
	if duckChargeTime > 0 then
		NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponName, ChargeFraction = 0.0, Comparison = "<=", Timeout = duckChargeTime, TimeModifierFraction = 0.0 })
		waitUntil( notifyName )
		if not _eventTimeoutRecord[notifyName] then
			MapState.ChargedManaWeapons[weaponName] = nil
			ClearManaChargeIndicator( weaponName )
			return
		end
	end

	if weaponData.ManaChargeStartAnimation then
		SetAnimation({ Name = weaponData.ManaChargeStartAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end

	local firstCreation = true
	if MapState.ManaChargeIndicatorIds.BackingId ~= nil then
		firstCreation = false
	end
	
	local backingId = MapState.ManaChargeIndicatorIds.BackingId or SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -200, Group = groupName })		
	local badgeId = MapState.ManaChargeIndicatorIds.BadgeId or SpawnObstacle({ Name = "BlankObstacle", DestinationId = backingId, Attach = true })		
	
	if weaponData.CustomManaIndicatorOffsetY then
		Attach({ Id = backingId , DestinationId = CurrentRun.Hero.ObjectId, OffsetY = weaponData.CustomManaIndicatorOffsetY })
	else
		Attach({ Id = backingId , DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -250 })
	end
	SetAnimation({ Name = indicatorData.TransitionIn, DestinationId = backingId, OffsetY = -50 })
	
	if SessionMapState.ManaIndicatorCustomColor then
		SetColor({ Id = backingId, Color = SessionMapState.ManaIndicatorCustomColor, Duration = 0 })
	end
	if SessionMapState.ManaIndicatorCustomHSV then
		SetHSV({ Id = MapState.ManaChargeIndicatorIds.BackingId, HSV = SessionMapState.ManaIndicatorCustomHSV, ValueChangeType = "Absolute" })
	end

	waitUnmodified(0.1, notifyName )
	if SessionMapState.SprintBonusCharge and HeroHasTrait("MagicCritMetaUpgrade") then
		CreateAnimation({ Name = ManaIndicatorPresentation.SprintPowerBadge, DestinationId = MapState.ManaChargeIndicatorIds.BackingId })
	end
	if not MapState.HostilePolymorph then
		CreateAnimation({ Name = ManaGatherAnimations.Default, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if chargeTime * chargePercent - duckChargeTime < 0 then
		SetAnimation({ Name = indicatorData.Fill, DestinationId = backingId, PlaySpeed = 0, Scale = 1.0, OffsetY = -50 })
		SetAnimationFrameTarget({ Name = indicatorData.Fill, DestinationId = backingId, Fraction = 1, Instant = true })
		SetAnimation({ Name = indicatorData.Fill, DestinationId = backingId, PlaySpeed = 0, Scale = 1.0, OffsetY = -50 })	
	else
		SetAnimation({ Name = indicatorData.Fill, DestinationId = backingId , PlaySpeed = 1 / ( chargeTime * chargePercent - duckChargeTime), OffsetY = -50 })
	end
	MapState.ShowManaChargeIndicator = true
	
	MapState.ManaChargeIndicatorCost = MapState.ManaChargeIndicatorCost or manaCost
	MapState.ManaChargeIndicatorData = indicatorData
	MapState.ManaChargeIndicatorIds.BackingId = backingId
	MapState.ManaChargeIndicatorIds.BadgeId = badgeId
	local duration = 0.1
	if firstCreation then
		duration = 0
	end
	if HasOutgoingCritModifierType(CurrentRun.Hero, "DifferentOmegaChance" ) and SessionMapState.LastExMove and SessionMapState.LastExMove ~= weaponData.Name 
		and ( SessionMapState.LastExMove ~= "WeaponCast" or ( not Contains( WeaponSets.HeroRangedWeapons, weaponData.Name ))) then

		SetAlpha({ Id = badgeId, Fraction = 1, Duration = duration })
	else
		SetAlpha({ Id = badgeId, Fraction = 0, Duration = duration })
	end

	if (not reserveMana and CurrentRun.Hero.Mana < MapState.ManaChargeIndicatorCost) or (reserveMana and GetHeroMaxAvailableMana() < MapState.ManaChargeIndicatorCost) then
		SetRGB({ Ids = { backingId, badgeId }, Color = Color.Red })
	end

	if firstCreation then
		SetAnimation({ Name = ManaIndicatorPresentation.DifferentMoveBadge, DestinationId = badgeId })
		CreateTextBox({ 
			Id = backingId, 
			Text = MapState.ManaChargeIndicatorCost,
			FontSize = 22,
			OffsetX = 0, OffsetY = -2,
			Color = { 255, 255, 255, 255},
			Font = "NumericP22UndergroundSCMedium",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			OutlineThickness = 3,
			Justification = "Center",
		})
	else
		ModifyTextBox({ Id = backingId, Text = MapState.ManaChargeIndicatorCost })
	end
	
	if (not reserveMana and CurrentRun.Hero.Mana < MapState.ManaChargeIndicatorCost) or (reserveMana and GetHeroMaxAvailableMana() < MapState.ManaChargeIndicatorCost) then
		if LastMomentManaRestoreEligible( MapState.ManaChargeIndicatorCost) then
			thread( SetManaIndicatorCustomColor, weaponName, Color.ManaRestoreEligible, ManaIndicatorPresentation.LastMomentManaRestoreEligibleHSV)
		else
			SetManaIndicatorDisallowed( weaponName, true )
		end
	else
		SetManaIndicatorAllowed( weaponName )
	end
	thread( ManaChargeCompletePresentationThread, weaponData, chargeTime * chargePercent - duckChargeTime )
	
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponName, ChargeFraction = 0.0, Comparison = "<=" })
	waitUntil( notifyName )
	
	notifyExistingWaiters("ChargeManaWeaponFire")
	killTaggedThreads("ManaChargeComplete")
	ClearManaChargeIndicator( weaponName )
	MapState.ChargedManaWeapons[weaponName] = nil

end

function ClearManaChargeIndicator( weaponName, animationKeyOverride )
	
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "MaxChargeStageCache", Value = false, DataValue = false })
	StopAnimation({ Names = GetAllValues( ManaGatherAnimations ), DestinationId = CurrentRun.Hero.ObjectId })
	MapState.ManaChargeIndicatorCost = nil
	MapState.ManaChargeIndicatorLooping = nil
	if MapState.ManaChargeIndicatorIds and MapState.ManaChargeIndicatorData then
		if MapState.ShowManaChargeIndicator then
			if animationKeyOverride then
				SetAnimation({ Name = MapState.ManaChargeIndicatorData[animationKeyOverride], DestinationId = MapState.ManaChargeIndicatorIds.BackingId, OffsetY = -50 })
			elseif MapState.ChargedManaWeapons[weaponName] then
				SetAnimation({ Name = MapState.ManaChargeIndicatorData.Dissipate, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, OffsetY = -50 })
			else
				SetAnimation({ Name = MapState.ManaChargeIndicatorData.Cancel, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, OffsetY = -50 })
			end
			MapState.ShowManaChargeIndicator = nil
		end
		ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, FadeTarget = 0, FadeDuration = 0.15, ColorTarget = {0, 0, 1, 0}, ColorDuration = 0.15 })
		SetAlpha({ Id = MapState.ManaChargeIndicatorIds.BadgeId, Fraction = 0, Duration = 0.1 })
	end
end

function HuntersMarkApplyPresentation( triggerArgs )
	thread( InCombatTextArgs, { TargetId = triggerArgs.Victim.ObjectId, Text = "MarkedForCrit", ShadowScale = 0.6, PreDelay = 0.35, Duration = 2.5, OffsetY = 80, SkipRise = true } )
end

function HuntersMarkUnitDeathPresentation( victim )
	--thread( InCombatTextArgs, { TargetId = victim.ObjectId, Text = "KILLED WITH CRIT", ShadowScale = 0.6, PreDelay = 0.35, Duration = 1.5, OffsetY = 80 } )
end

function WebSlowedPresentation( triggerArgs )
	if CheckCooldown( "WebSlowedRecently", 1.2 ) then
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId, Delay = 0.15 })
		thread( InCombatText, CurrentRun.Hero.ObjectId, "WebSlowHit", 0.3, {SkipShadow = true} )
	end
end

function FirstOnHitSound( source, args, contextArgs )
	if source.FirstOnHitSoundPlayed == nil then
		PlaySound({ Name = args.Sound, Id = source.ObjectId })
		source.FirstOnHitSoundPlayed = true
	end
end


function SpellChargeTimeSlowPresentation()

	--[[
	local duration = 0.05
	AdjustFullscreenBloom({ Name = "MoonDustBloom", Duration = duration })
	AdjustColorGrading({ Name = "Respawn", Duration = duration })
	AdjustRadialBlurDistance({ Fraction = 0.05, Duration = duration })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = duration })
	]]
	
	CreateAnimation({ Name = "SpellChargeVignette", DestinationId = ScreenAnchors.Vignette })

end

function SpellChargeTimeSlowPresentationSoftVignette()
	CreateAnimation({ Name = "SpellChargeVignetteSoft", DestinationId = ScreenAnchors.Vignette })
end

function SpellChargeEndTimeSlowPresentation()
	local duration = 0
	AdjustRadialBlurStrength({ Fraction = 0, Duration = duration })
	AdjustColorGrading({ Name = "Off", Duration = duration })
	AdjustFullscreenBloom({ Name = "Off", Duration = duration })
end


function SpawnKillPresentation( unit )
	thread( PlayVoiceLines, GlobalVoiceLines.ZeusInstaKillVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/PlayerKilledNEW", Id = unit.ObjectId })
	if CheckCooldown( "SpawnKillPresentationCooldown", 1.0 ) then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_SpawnKill", 0.75, { PreDelay = 0.25 } )
	end
end

function HighRollHitPresentation()
	if CheckCooldown("HighRollHitPresentation", 5 )then
		PlaySound({ Name = "/SFX/Menu Sounds/KeepsakeDionysusCup", Id = CurrentRun.Hero.ObjectId })
	end
end

function ErisReloadJamPresentation(enemy, aiData, currentRun, args)

	PlaySound({ Name = "/SFX/Player Sounds/ErisGunJam", Id = enemy.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/CaravanDamage", Id = enemy.ObjectId, Delay = 0.3 })

end

function ChronosTyphonFightHitPresentation( blocker )
	if blocker.IsDead then
		return
	end
	if not CheckCooldown( "ChronosTyphonFightHitPresentation", 0.3 ) then
		return
	end

	Flash({ Id = blocker.ObjectId, Speed = 0.85, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.Yellow, Duration = 0.15, ExpireAfterCycle = true })
	SetAlpha({ Id = blocker.ObjectId, Fraction = 0.2, Duration = 0.05 })
	PlaySound({ Name = "/Leftovers/SFX/InvincibleOnHit", Id = blocker.ObjectId })
	if blocker.InvulnerableHitFx ~= nil then
		CreateAnimation({ Name = blocker.InvulnerableHitFx, DestinationId = blocker.ObjectId })
	end
	
	thread( PlayVoiceLines, blocker.InvulnerableVoiceLines, nil, blocker )

	wait(0.15)
	SetAlpha({ Id = blocker.ObjectId, Fraction = 1.0, Duration = 0.13 })
end

function AllyHitPresentation(unit, args, triggerArgs)
	if unit.IsDead then
		return
	end

	if triggerArgs.AttackerId ~= CurrentRun.Hero.ObjectId then
		return
	end

	Flash({ Id = unit.ObjectId, Speed = 0.85, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.Transparent, Duration = 0.15, ExpireAfterCycle = true })
	SetAlpha({ Id = unit.ObjectId, Fraction = 0.2, Duration = 0.05 })
	PlaySound({ Name = "/Leftovers/SFX/InvincibleOnHit", Id = unit.ObjectId, ManagerCap = 46 })

	wait(0.15)
	SetAlpha({ Id = unit.ObjectId, Fraction = 1.0, Duration = 0.13 })
end

function CastEmbeddedPresentationStart( )
	if ScreenAnchors.BloodstoneVignetteId == nil then
		ScreenAnchors.BloodstoneVignetteId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu",
			Animation = "BloodstoneVignette",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			ScaleX = ScreenScaleX,
			ScaleY = ScreenScaleY,
			})
	end

	thread( PlayVoiceLines, GlobalVoiceLines.ZagreusBoilingBloodVoiceLines, true )

	thread( InCombatText, CurrentRun.Hero.ObjectId, "HitByHadesAmmo", 0.8, {OffsetY = -60} )

end

function CastEmbeddedPresentationEnd( )
	if ScreenAnchors.BloodstoneVignetteId ~= nil then
		SetAlpha({ Id = ScreenAnchors.BloodstoneVignetteId, Fraction = 0, Duration = 0.25 })
		wait( 0.25 )
		Destroy({ Id = ScreenAnchors.BloodstoneVignetteId })
		ScreenAnchors.BloodstoneVignetteId = nil
	end
end

function AmmoPackPickup(ammoPack, zag, args)
	if not IsWithinDistance({ Id = zag.ObjectId, DestinationId = ammoPack.ObjectId, Distance = args.WithinDistance / 3 }) then
		Move({ Id = ammoPack.ObjectId, DestinationId = zag.ObjectId, Speed = 400, EaseIn = 0.1, UseTargetMoveTarget = true })

		local notifyName = ammoPack.ObjectId.."PickupTrigger"
		NotifyWithinDistance({ Id = zag.ObjectId, DestinationId = ammoPack.ObjectId, Distance = args.WithinDistance / 3, Timeout = 3.0, Notify = notifyName })
		waitUntil(notifyName)
	end

	PlaySound({ Id = zag.ObjectId, Name = "/SFX/BloodstoneAmmoPickup" })
	CreateAnimation({ Name = "QuickFlashRedSmall", DestinationId = zag.ObjectId })
	ZagreusCollectCastAmmo(zag)
	Destroy({ Id = ammoPack.ObjectId })
end

function ZagreusKillPresentation( unit, args )
	args = args or {}

	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})
	if not IsEmpty( unit.StopAnimationsOnHitStun ) then -- since hit stun isn't applied on death
		StopAnimation({ Names = unit.StopAnimationsOnHitStun, DestinationId = unit.ObjectId, PreventChain = true })
		if unit.FxTargetIdsUsed ~= nil then
			for id, v in pairs( unit.FxTargetIdsUsed ) do
				StopAnimation({ Names = unit.StopAnimationsOnHitStun, DestinationId = id, PreventChain = true })
			end
		end
	end

	SetUnitInvulnerable( unit )
	CurrentRun.BossHealthBarRecord[unit.Name] = 0
	ClearEffect({ Ids = { unit.ObjectId, CurrentRun.Hero.ObjectId }, All = true, BlockAll = true, })
	EffectPostClearAll( unit )
	if unit.Frozen then
		UnfrozenPresentation( unit, { SkipPresentation = true })
	end

	SetThreadWait("DropStoredAmmoHero", 0)

	SetPlayerInvulnerable( "ZagreusKillPresentation" )
	AddInputBlock({ Name = "ZagreusKillPresentation" })
	AddTimerBlock( CurrentRun, "ZagreusKillPresentation" )
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	end

	StopSecretMusic(true)
	thread( LastKillPresentation, unit )

	if unit.DeathAngle ~= nil then
		Halt({ Id = unit.ObjectId })
		Stop({ Id = unit.ObjectId })
		SetGoalAngle({ Id = unit.ObjectId, Angle = unit.DeathAngle, CompleteAngle = true })
	end

	SetAnimation({ Name = "Enemy_Zagreus_Death_Start", DestinationId = unit.ObjectId })
	CreateAnimation({ Name = "ZagreusDeathDefianceBlood", DestinationId = unit.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId })

	wait( 2.8, RoomThreadName )

	local textLines = GetRandomEligibleTextLines( unit, unit.BossOutroTextLineSets, GetNarrativeDataValue( unit, "BossOutroTextLinePriorities" ) )
	unit.TextLinesUseWeaponIdle = nil
	PlayTextLines( unit, textLines )

	SetCameraClamp({ Ids = GetIds({ Name = "CameraClamps" }), SoftClamp = 0.75 })

	thread( PlayVoiceLines, unit.DefeatedVoiceLines, true, unit )

	local allBossesDead = true
	local encounterData = EncounterData[CurrentRun.CurrentRoom.Encounter.Name]
	if encounterData.HoldKillPresentationForUnitDeaths ~= nil then
		local unitIds = GetIdsByType({ Names = encounterData.HoldKillPresentationForUnitDeaths })
		for k, id in pairs(unitIds) do
			if ActiveEnemies[id] ~= nil and not ActiveEnemies[id].IsDead then
				allBossesDead = false
				break
			end
		end
	end
	if not allBossesDead then
		if unit.DeathAnimationIfNotAllBossesDead then
			unit.DeathAnimation = unit.DeathAnimationIfNotAllBossesDead
			unit.ManualDeathAnimation = false
		end
		if unit.LastKillIfNotAllBossesDead then
			LastKillPresentation( unit )
		end
		return
	end

	-- Record the stats now so the boss can check them in the requirements for BossKillVoiceLines
	RecordEncounterClearStats()

	if unit.IsBoss then
		ClipEvent({ Icon = "steam_combat", Title = GetDisplayName({ Text = args.Message }), Description = "", StartOffset = 0.0, Duration = 5.0 })
	end

	if args.EndSecretMusicEarly ~= nil then
		SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 10 })
		AudioState.SecretMusicId = nil
		AudioState.SecretMusicName = nil
	end
	if args.MusicMutedStems ~= nil then
		SetSoundCueValue({ Names = args.MusicMutedStems, Id = AudioState.MusicId, Value = 0, Duration = 0.5 })
	end

	LockCameraMotion("ZagreusKillPresentation")
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	local deathPanSettings = args

	if unit.DeathFx ~= nil then
		CreateAnimation({ Name = unit.DeathFx, DestinationId = unit.ObjectId, Angle = args.ImpactAngle })
		unit.DeathFx = nil
	end
	if unit.AngleTowardClosestTypeOnDeath then
		AngleTowardTarget({ Id = unit.ObjectId, DestinationId = GetClosest({ Id = unit.ObjectId, DestinationIds = GetIdsByType({ Name = unit.AngleTowardClosestTypeOnDeath }) }) })
	end
	if unit.DeathAnimation ~= nil then
		SetAnimation({ Name = unit.DeathAnimation, DestinationId = unit.ObjectId })
		unit.DeathAnimation = nil
	end
	if unit.DeathSound ~= nil then
		PlaySound({ Name = unit.DeathSound, Id = unit.ObjectId })
		unit.DeathSound = nil
	end
	if unit.BossKillVoiceLines ~= nil then
		thread( PlayVoiceLines, unit.BossKillVoiceLines, false, unit )
	end
	unit.Mute = true

	BlockProjectileSpawns({ ExcludeWeaponName = "WeaponLob" })
	if args.BlockMapSpawns then
		MapState.BlockSpawns = true
	end
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })

	if args.DestroyGroup then
		Destroy({ Ids = GetIds({ Name = args.DestroyGroup }) })
	end

	SetPlayerInvulnerable( "ZagreusKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	if args.AddInterBiomeTimerBlock then
		AddTimerBlock( CurrentRun, "InterBiome" )
	end
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	ClearCameraClamp({ LerpTime = 0 })
	local cameraPanTime = deathPanSettings.StartPanTime or 1.5
	local offsetY = unit.DeathPanOffsetY or 0
	PanCamera({ Id = victimId, Duration = cameraPanTime, OffsetY = offsetY })
	FocusCamera({ Fraction = args.PanZoomFraction or 1.1, Duration = cameraPanTime, ZoomType = "Undershoot" })
	ZeroMouseTether("ZagreusKillPresentation")
	CancelWeaponFireRequests({ Id = killerId })
	ToggleCombatControl( CombatControlsDefaults, false, "BossKill" )

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen, nil, { IgnoreHUDShow = true } )
	end
	HideCombatUI("BossKill")

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if deathPanSettings.StartSound then
		PlaySound({ Name = deathPanSettings.StartSound })
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteShocked" })
	end

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, IgnoreAnimations = true, DataValue = false, DestinationId = killerId })
	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = victimId })
	thread( VictimDeathHold, victimId, 0.02, 0.5 )
	if deathPanSettings.FlashRed then
		local duration = deathPanSettings.FlashDuration or 0.5
		Flash({ Id = victimId, Speed = 0.01, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = duration, ExpireAfterCycle = true })
	end

	RemoveFromGroup({ Id = killerId, Names = { "Standing" } })
	AddToGroup({ Id = killerId, Name = "Combat_Menu_Overlay_Backing", DrawGroup = true })
	RemoveFromGroup({ Id = victimId, Name = "Standing" })
	AddToGroup({ Id = victimId, Name = "Combat_Menu_Overlay_Backing", DrawGroup = true })

	if deathPanSettings.EndAngle then
		SetGoalAngle({ Id = victimId, Angle = deathPanSettings.EndAngle })
	end

	-- black out world
	AdjustFrame({ Color = Color.TransparentRed, Duration = 0.0, Fraction = 0 })
	ScreenAnchors.DeathBackground = ScreenAnchors.DeathBackground or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = ScreenAnchors.DeathBackground, Fraction = 10 })
	SetColor({ Id = ScreenAnchors.DeathBackground, Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 1.0, Duration = 0 })

	thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.17, Duration = 0.65 }, { ScreenPreWait = 2.8, LeftFraction = 0.3, Duration = 0.6 } } )

	thread( BossDeathFlash, { DestinationId = victimId, StartDelay = 0.52, StopDelay = 0.3, OffsetY = args.DeathFlashOffsetY or 0 } )

	wait( 0.15 )
	if killerId == CurrentRun.Hero.ObjectId then
		SetPlayerFade({ Flag = "KillPresentation"})
	else
		SetAlpha({ Id = killerId, Fraction = 0, Duration = 0.3 })
	end
	ClearEffect({ Id = killerId, Name = "KillDamageBonus" })

	wait( cameraPanTime )

	if args.ShiftDistance ~= nil then
		local angle = GetAngleBetween({ Id = unit.ObjectId, DestinationId = args.ShiftTowardId })
		Move({ Id = unit.ObjectId, Angle = angle, Speed = args.ShiftDistance * 4.0, Distance = args.ShiftDistance })
	end

	local textMessage = deathPanSettings.Message

	-- for CrawlerMiniboss & others
	if unit.AltDeathMessageTextIds ~= nil then
		local eligibleTextIds = {}
		for k, altTextIdData in pairs( unit.AltDeathMessageTextIds ) do
			if altTextIdData.GameStateRequirements == nil or IsGameStateEligible( altTextIdData, altTextIdData.GameStateRequirements ) then
				table.insert( eligibleTextIds, altTextIdData.TextId )
			end
		end
		if not IsEmpty( eligibleTextIds ) then
			textMessage = GetRandomValue( eligibleTextIds )
		end
	end

	if deathPanSettings.BossDifficultyMessage and GetNumShrineUpgrades( "BossDifficultyShrineUpgrade" ) > 0 then
		textMessage = deathPanSettings.BossDifficultyMessage
	end

	thread( DisplayInfoBanner, nil, { 
		Text = textMessage or "BiomeClearedMessage", 
		Delay = 0.75, 
		TextColor = Color.White, 
		TextFadeColor = {64,230,255,255},
		Layer = "Overlay", 
		FontScale = 0.9,
		AnimationName = "InfoBannerBossKillIn",
		AnimationOutName = "InfoBannerBossKillOut",
		Duration = 3.75,

		SubtitleFont = args.SubtitleFont or "SpectralSCMedium",
		SubtitleOffsetY = args.SubtitleOffsetY or 10,
		SubtitleDelay = args.SubtitleDelay or 3.0,

		SubTextColor = args.SubTextColor or Color.NarratorVoice,
		SubtitleText = args.SubtitleText or GetRandomValue(args.SubtitleTextOptions),
		SubtitleTextRevealSound = "/Leftovers/World Sounds/MapZoomInTight",
	} )

	if deathPanSettings.BatsAfterDeath then
		thread( SendCritters, { MinCount = 80, MaxCount = 90, StartX = 0, StartY = 300, MinAngle = 75, MaxAngle = 115, MinSpeed = 400, MaxSpeed = 2000, MinInterval = 0.03, MaxInterval = 0.1, GroupName = "CrazyDeathBats" } )
	end

	wait( 1.0 )

	CreateAnimation({ DestinationId = unit.ObjectId, Name = "ErisDeathHandsFxIn", Group = "Combat_Menu_Overlay_Additive" })
	local grabSoundId = PlaySound({ Name = "/SFX/Player Sounds/MelMagicalChargeLoop" })
	wait( 1.0 )
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGrabCharge" })
	wait( 0.5 )
	SetAnimation({ Name = "Enemy_Zagreus_Death_Disappear", DestinationId = unit.ObjectId })
	wait( 0.5 )
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "ErisDeathHandsFxBurst", Group = "Combat_Menu_Overlay_Additive" })
	AdjustZLocation({ Id = unit.ObjectId, Distance = -200 - GetZLocation({ Id = unit.ObjectId }), Duration = 0.3 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TitanToggleLong" })
	StopSound({ Id = grabSoundId, Duration = 0.3 })
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/HadesSkullExplode" })
	wait( 0.2 )
	PlaySound({ Name = "/SFX/Enemy Sounds/Charon/CharonPillarExplodeShort2" })
	wait( 3.3 )
	SetAlpha({ Id = unit.ObjectId, Fraction = 0, Duration = 0.0 })

	if CurrentRun.CurrentRoom.Encounter.BossKillGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[CurrentRun.CurrentRoom.Encounter.BossKillGlobalVoiceLines], false )
	end

	if CurrentRun.CurrentRoom.Encounter.DeathExtraSounds ~= nil then
		local randomSound = GetRandomValue( CurrentRun.CurrentRoom.Encounter.DeathExtraSounds )
		PlaySound({ Name = randomSound })
	end

	if deathPanSettings.KillerEndAngle ~= nil then
		SetGoalAngle({ Id = killerId, Angle = deathPanSettings.KillerEndAngle })
	end

	if deathPanSettings.KillerTeleportId ~= nil then
		Teleport({ Id = killerId, DestinationId = deathPanSettings.KillerTeleportId })
	end
	if deathPanSettings.VictimTeleportId ~= nil then
		Teleport({ Id = victimId, DestinationId = deathPanSettings.VictimTeleportId })
	end

	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0.0, Duration = 0.3 })

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationId = killerId })
	if killerId == CurrentRun.Hero.ObjectId then
		ClearPlayerFade( "KillPresentation" )
	else
		SetAlpha({ Id = killerId, Fraction = 1.00, Duration = 0.3 })
	end
	RemoveFromGroup({ Id = killerId, Names = { "Combat_Menu_Overlay_Backing" } })
	AddToGroup({ Id = killerId, Name = "Standing", DrawGroup = true })

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 3.0, EaseOut = 0.5 })
	local defaultZoom = 1.0
	if CurrentHubRoom ~= nil then
		defaultZoom = CurrentHubRoom.ZoomFraction or defaultZoom
	else
		defaultZoom = CurrentRun.CurrentRoom.ZoomFraction or defaultZoom
	end
	FocusCamera({ Fraction = defaultZoom, Duration = 3.0, ZoomType = "Ease" })

	if args.SetCameraClampIds then
		SetCameraClamp({ Ids = args.SetCameraClampIds })
	end

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	wait( 0.1 )

	RemoveFromGroup({ Id = victimId, Names = { "Combat_Menu_Overlay_Backing" } })
	AddToGroup({ Id = victimId, Name = "Standing", DrawGroup = true })

	wait( 0.9 )

	--CrowdReactionPresentation( {} )

	CreateAnimation({ Name = "ElysiumConfettiEmitterBurst", DestinationId = CurrentRun.Hero.ObjectId, }) -- nopkg
	CreateAnimation({ Name = "StageSpotlight", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Add_Top" }) --nopkg

	SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = 270 })
	SetAnimation({ Name = "MelinoeSaluteToEquip", DestinationId = CurrentRun.Hero.ObjectId })

	PlaySound({ Name = "/SFX/TheseusCrowdCheer" })
	wait( 1.2 )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ZagContractGranted", Duration = 1.25 } )
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	wait( 2.0 )
	StopAnimation({ Name = "ElysiumConfettiEmitterBurst", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "StageSpotlight", DestinationId = CurrentRun.Hero.ObjectId })

	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "ZagreusKillPresentation" )
	UnlockCameraMotion("ZagreusKillPresentation")
	ShowCombatUI("BossKill")
	ClearEffect({ Ids = { killerId }, All = true })
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	ToggleCombatControl( CombatControlsDefaults, true, "BossKill" )
	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })

	PlaySound({ Name = "/SFX/TimeSlowStart" })

	RemoveInputBlock({ Name = "ZagreusKillPresentation" })
	RemoveTimerBlock( CurrentRun, "ZagreusKillPresentation" )
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false

	ClearCameraClamp({ LerpTime = 1.0 }) -- the map bounds are more restrictive during the fight
end