function DeferredCombatPresentation()
	thread(function (list)
		for index, args in pairs(list) do
			UpdateHealthBarReal( args )
		end
	end, CombatPresentationDeferredHealthBars)
	CombatPresentationDeferredHealthBars = {}
end

function GetNumBossHealthBars()
	local bars = 0
	for enemyId, enemy in pairs( ActiveEnemies ) do
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

	local offsetY = -155
	if newEnemy.Scale ~= nil then
		offsetY = offsetY * newEnemy.Scale
	end
	if newEnemy.HealthBarOffsetY then
		offsetY = newEnemy.HealthBarOffsetY
	end

	local backingId = SpawnObstacle({ Name = "EnemyHealthBar", Group = "Combat_UI_World_Backing", DestinationId = newEnemy.ObjectId, Attach = true, OffsetY = offsetY, TriggerOnSpawn = false })
	EnemyHealthDisplayAnchors[newEnemy.ObjectId.."back"] = backingId
	if newEnemy.HealthBuffer and newEnemy.HealthBuffer > 0 then
		SetAnimation({ DestinationId = backingId, Name = "EnemyHealthBarArmor" })
	end
	
	-- red health bar
	local screenId = SpawnObstacle({ Name = "EnemyHealthBarFill", Group = "Combat_UI_World", DestinationId = newEnemy.ObjectId, Attach = true, OffsetY = offsetY, TriggerOnSpawn = false })
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
	
	-- falloff  health bar
	local backingScreenId = SpawnObstacle({ Name = "EnemyHealthBarFillSlow", Group = "Combat_UI_World_Backing", DestinationId = newEnemy.ObjectId, Attach = true, OffsetY = offsetY, TriggerOnSpawn = false })
	EnemyHealthDisplayAnchors[newEnemy.ObjectId.."falloff"] = backingScreenId
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlow", Fraction = 1 - displayedHealthPercent, DestinationId = backingScreenId, Instant = true })
	SetColor({ Id = backingScreenId, Color = Color.HealthFalloff })
	
	
	-- burn  health bar
	local scorchScreenId = SpawnObstacle({ Name = "EnemyHealthBarFill", Group = "Combat_UI_World_Backing", DestinationId = newEnemy.ObjectId, Attach = true, OffsetY = offsetY, TriggerOnSpawn = false })
	EnemyHealthDisplayAnchors[newEnemy.ObjectId.."scorch"] = scorchScreenId
	SetColor({ Id = scorchScreenId, Color = Color.HealthScorch })

	
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

	EnemyHealthDisplayAnchors[newEnemy.ObjectId.."scale"] = newEnemy.BarXScale
	SetScaleX({ Ids = { backingScreenId, screenId, backingId, scorchScreenId }, Fraction = newEnemy.BarXScale })
	
	UpdateHealthBarIcons( newEnemy )
end

function UpdatePoisonEffectStacks( args )
	local stacks = args.Stacks
	local unitId = args.triggeredById
	local unit = args.Victim
	local startIconScale = 1.3

	local poisonColorA = { 121, 22, 243, 255 }
	local poisonColorB = { 255, 255, 255, 255 }
	local poisonStatusFontColor = Color.Lerp(poisonColorA, poisonColorB, (5 - stacks) / 5)
	if stacks > 5 then
		poisonStatusFontColor = poisonColorA
	end

	if not EnemyHealthDisplayAnchors[unitId] then
		CreateHealthBar( unit )
		UpdateHealthBar( unit, 0, { Force = true })
	end

	if not EnemyHealthDisplayAnchors[ unitId .. "poisonstatus" ] then

		local backingId = nil
		local scale = 1
		if unit.BarXScale then
			scale = unit.BarXScale
		end
		if unit and unit.UseBossHealthBar then
			backingId = CreateScreenObstacle({ Name = "PoisonSmall", Group = "Combat_Menu", DestinationId = EnemyHealthDisplayAnchors[unitId] })
			startIconScale = 1.3
			CreateTextBox({ Id = backingId, FontSize = 20, OffsetX = 17, OffsetY = 0,
				Font = "P22UndergroundSCHeavy",
				Justification = "Left",
				ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 2}, ShadowBlur = 0,
				OutlineThickness = 3, OutlineColor = {0.25, 0.3, 0.5, 1},
			})
		else
			backingId = SpawnObstacle({ Name = "PoisonSmall", Group = "Combat_UI_World", DestinationId = unitId, TriggerOnSpawn = false })
			CreateTextBox({ Id = backingId, FontSize = 20, OffsetX = 12, OffsetY = 0,
				Font = "P22UndergroundSCHeavy",
				Justification = "Left",
				ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 2}, ShadowBlur = 0,
				OutlineThickness = 3, OutlineColor = {0.25, 0.3, 0.5, 1},
			})
		end
		EnemyHealthDisplayAnchors[ unitId .. "poisonstatus" ] = backingId
	end

	local scaleTarget = 1.0

	SetScale({ Id = EnemyHealthDisplayAnchors[ unitId .. "poisonstatus" ], Fraction = startIconScale })
	ModifyTextBox({ Id = EnemyHealthDisplayAnchors[ unitId .. "poisonstatus" ], Text = tostring( stacks ), ScaleTarget = scaleTarget, Color = poisonStatusFontColor })
	PositionEffectStacks( unitId )
end

function ClearPoisonEffectStacks( args )
	Destroy({ Id = EnemyHealthDisplayAnchors[ args.triggeredById .. "poisonstatus" ] })
	EnemyHealthDisplayAnchors[ args.triggeredById .. "poisonstatus" ] = nil
	PositionEffectStacks( args.triggeredById )
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
					bossHealthBarOffsetY = -23
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
	if enemy.UseGroupHealthBar and CurrentRun.CurrentRoom.Encounter ~= nil then
		screenId = EnemyHealthDisplayAnchors[CurrentRun.CurrentRoom.Encounter.Name]
	end
	if screenId == nil then
		return
	end

	local scorchId = EnemyHealthDisplayAnchors[key.."scorch"]
	-- NOTE(Dexter) Performance: Queue this up to DeferredCombatPresentation()
	CombatPresentationDeferredHealthBars[key] = { enemy, screenId, scorchId }
end

function UpdateGroupHealthBarReal( args )
	local enemy = args[1]
	local screenId = args[2]
	local encounter = CurrentRun.CurrentRoom.Encounter
	local backingScreenId = EnemyHealthDisplayAnchors[encounter.Name.."falloff"]

	local maxHealth = encounter.GroupMaxHealth
	local currentHealth = 0

	for k, unitId in pairs(encounter.HealthBarUnitIds) do
		local unit = ActiveEnemies[unitId]
		if unit ~= nil then
			currentHealth = currentHealth + unit.Health
		end
	end
	encounter.GroupHealth = currentHealth

	local healthFraction = currentHealth / maxHealth
	CurrentRun.BossHealthBarRecord[encounter.Name] = healthFraction


	SetAnimationFrameTarget({ Name = encounter.HealthBarFill or "EnemyHealthBarFill", Fraction = 1 - healthFraction, DestinationId = screenId, Instant = true  })
	thread( UpdateGroupHealthBarFalloff, encounter )
end

function UpdateHealthBarReal( args )

	local enemy = args[1]

	if enemy.UseGroupHealthBar then
		UpdateGroupHealthBarReal( args )
		return
	end

	local screenId = args[2]
	local scorchId = args[3]

	if enemy.IsDead then
		if enemy.UseBossHealthBar then
			CurrentRun.BossHealthBarRecord[enemy.Name] = 0
		end
		SetAnimationFrameTarget({ Name = enemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1, DestinationId = scorchId, Instant = true })
		SetAnimationFrameTarget({ Name = enemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1, DestinationId = screenId, Instant = true })
		return
	end


	local maxHealth = enemy.MaxHealth
	local currentHealth = enemy.Health
	if currentHealth == nil then
		currentHealth = maxHealth
	end

	UpdateHealthBarIcons( enemy )

	if enemy.UseBossHealthBar then
		local healthFraction = currentHealth / maxHealth
		CurrentRun.BossHealthBarRecord[enemy.Name] = healthFraction
		SetAnimationFrameTarget({ Name = enemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1 - healthFraction, DestinationId = screenId, Instant = true })
		if enemy.HitShields > 0 then
			SetColor({ Id = screenId, Color = Color.HitShield})
		else
			SetColor({ Id = screenId, Color = Color.Red })
		end
		thread( UpdateBossHealthBarFalloff, enemy )
		return
	end

	local displayedHealthPercent = 1
	local predictedHealthPercent = 1

	if enemy.CursedHealthBarEffect then
		if enemy.HitShields ~= nil and enemy.HitShields > 0 then
			SetColor({ Id = screenId, Color = Color.CurseHitShield })
		elseif enemy.HealthBuffer ~= nil and enemy.HealthBuffer > 0 then
			SetColor({ Id = screenId, Color = Color.CurseHealthBuffer })
		else
			SetColor({ Id = screenId, Color = Color.CurseHealth })
		end
		SetColor({ Id = backingScreenId, Color = Color.CurseFalloff })
	elseif enemy.Charmed then
		SetColor({ Id = screenId, Color = Color.CharmHealth })
		SetColor({ Id = backingScreenId, Color = Color.HealthBufferFalloff })
	else
		if enemy.HitShields ~= nil and enemy.HitShields > 0 then
			SetColor({ Id = screenId, Color = Color.HitShield })
		elseif enemy.HealthBuffer ~= nil and enemy.HealthBuffer > 0 then
			SetColor({ Id = screenId, Color = Color.HealthBuffer })
			SetColor({ Id = backingScreenId, Color = Color.HealthBufferFalloff })
		else
			SetColor({ Id = screenId, Color = Color.Red })
			SetColor({ Id = backingScreenId, Color = Color.HealthFalloff })
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
	SetAnimationFrameTarget({ Name = enemy.HealthBarFill or "EnemyHealthBarFill", Fraction = 1 - displayedHealthPercent, DestinationId = scorchId, Instant = true })
	thread( UpdateEnemyHealthBarFalloff, enemy )
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

function UpdateEnemyHealthBarFalloff( enemy )
	if not enemy.IsDead and not enemy.HealthBarFalloffShown then
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlow", Fraction = 0, DestinationId = EnemyHealthDisplayAnchors[enemy.ObjectId .. "falloff"], Instant = true })
		enemy.HealthBarFalloffShown = true
	end

	if SetThreadWait( "EnemyHealthBarFalloff"..enemy.ObjectId, CombatUI.HealthBarFalloffDelay ) then
		return
	end
	wait( CombatUI.HealthBarFalloffDelay, "EnemyHealthBarFalloff"..enemy.ObjectId )
	if enemy and not enemy.IsDead then
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlow", Fraction = 1 - enemy.DisplayedHealthFraction, DestinationId = EnemyHealthDisplayAnchors[enemy.ObjectId .. "falloff"] })
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
		ScreenAnchors.BossHealthTitles[ enemy.ObjectId ] = nil
		if enemy.RageBarFill ~= nil then
			Destroy({ Id = ScreenAnchors.BossRageTitle })
			Destroy({ Id = ScreenAnchors.BossRageBack })
			Destroy({ Id = ScreenAnchors.BossRageFill })
		end
	end

	if enemy.GroupHealthBarOwner then
		notifyExistingWaiters(CurrentRun.CurrentRoom.Encounter.Name.."GroupHealthBarDead")
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
	table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."scorch"] )
	table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."falloff"] )
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
	if EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] ~= nil then
		for k, v in pairs( EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] ) do
			table.insert( toDestroy, v )
		end
	end

	if enemy.ActiveEffects then
		for effectName in pairs( enemy.ActiveEffects ) do
			local effectData = EffectData[effectName]
			if  effectData ~= nil then
				if effectData.Vfx ~= nil then
					StopAnimation({ Name = effectData.Vfx, DestinationId = enemy.ObjectId })
				end
				if effectData.BackVfx ~= nil then
					StopAnimation({ Name = effectData.BackVfx, DestinationId = enemy.ObjectId })
				end
				if not IsEmpty ( effectData.StopVfxes ) then
					StopAnimation({ Names = effectData.StopVfxes, DestinationId = enemy.ObjectId })
				end
				if not IsEmpty ( effectData.StopVfxesPreventChain ) then
					StopAnimation({ Names = effectData.StopVfxesPreventChain, DestinationId = enemy.ObjectId, PreventChain = true})
				end
				if effectData and effectData.ShowDuration and effectData.DisplaySuffix then
					table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId..effectData.DisplaySuffix.."timer"] )
					EnemyHealthDisplayAnchors[enemyId..effectData.DisplaySuffix.."timer"] = nil
				end
			end
		end
	end
	DestroyTextBox({ Ids = toDestroy })

	EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] = nil	
	EnemyHealthDisplayAnchors[enemyId] = nil
	EnemyHealthDisplayAnchors[enemyId.."back"] = nil
	EnemyHealthDisplayAnchors[enemyId.."health"] = nil
	EnemyHealthDisplayAnchors[enemyId.."armorIcon"] = nil
	EnemyHealthDisplayAnchors[enemyId.."vulnerabilityIndicator"] = nil
	EnemyHealthDisplayAnchors[enemyId.."scorch"] = nil
	EnemyHealthDisplayAnchors[enemyId.."falloff"] = nil
	if enemy.EffectSuffixNames then
		for effectName in pairs(enemy.EffectSuffixNames) do
			EnemyHealthDisplayAnchors[enemyId..effectName] = nil
		end
	end

	wait( CombatUI.DeathHoldDuration, RoomThreadName )
	SetScaleY({ Ids = toDestroy, Fraction = 0, Duration = 0.15 })
	if EnemyHealthDisplayAnchors[enemyId.."health"] ~= nil then
		SetScaleX({ Id = EnemyHealthDisplayAnchors[enemyId.."health"], Fraction = 0, Duration = 0.0 })
	end
	if EnemyHealthDisplayAnchors[enemyId.."scorch"] ~= nil then
		SetScaleX({ Id = EnemyHealthDisplayAnchors[enemyId.."scorch"], Fraction = 0, Duration = 0.0 })
	end
	if EnemyHealthDisplayAnchors[enemyId.."back"] ~= nil and EnemyHealthDisplayAnchors[enemyId.."scale"] ~= nil then
		SetScaleX({ Id = EnemyHealthDisplayAnchors[enemyId.."back"], Fraction = EnemyHealthDisplayAnchors[enemyId.."scale"] * 1.4, Duration = 0.15 })
	end
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

Using "StatusIconVulnerableArmorShatter"
Using "HealthBarArmorShatter"
Using "ArmorBreak"
function ArmorBreakPresentation( enemy )
	local enemyId = enemy.ObjectId
	local offsetY = -155
	if enemy.Scale ~= nil then
		offsetY = offsetY * enemy.Scale
	end
	if enemy.HealthBarOffsetY then
		offsetY = enemy.HealthBarOffsetY - 18
	end

	SetAnimation({ DestinationId = EnemyHealthDisplayAnchors[enemy.ObjectId.."back"], Name = "EnemyHealthBar" })

	CreateAnimations({
		DestinationId = enemyId,
		Anims =
		{
			{ Name = "StatusIconVulnerableArmorShatter", OffsetX = -50, OffsetY = offsetY },
			{ Name = "HealthBarArmorShatter", OffsetY = offsetY - 35 },
			{ Name = "ArmorBreak" }
		}
	})

	local promptId = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", Group = "Combat_UI_World", DestinationId = enemyId, OffsetY = offsetY })
	SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = promptId})
	Attach({ Id = promptId, DestinationId = enemyId, OffsetY = offsetY })
	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof", Id = enemy.ObjectId, ManagerCap = 36 })
	CreateTextBox({	Id = promptId, Text = "ArmorBreak", Justification = "CENTER",
		ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		Font = "LatoBoldItalic", FontSize = 18, Color = {255,255,255,255},
		CharacterFadeTime = 0, CharacterFadeInterval = 0, Group = "Combat_UI_World",
		AutoSetDataProperties = false,
		ScaleTarget = 6.2, ScaleDuration = 10,
		})
	Move({ Id = promptId, Distance = 100, Angle = 0, Duration = 1, EaseOut = 1, TimeModifierFraction = 0 })

	waitUnmodified(0.5)
	ModifyTextBox({ Id = promptId, FadeTarget = 0.0, FadeDuration = 0.4, ColorTarget = {1, 0, 0, 1}, ColorDuration = 0.5, AutoSetDataProperties = false })
	waitUnmodified(1.0)
	DestroyTextBox({ Id = promptId })

end

function PlayerLastStandPresentationStart( args )
	wait( 0.06, RoomThreadName )
	local secondChanceFxInTime = 0.08

	-- put up screen vfx
	ScreenAnchors.LastStandVignette = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	CreateAnimation({ Name = "LastStandVignette", DestinationId = ScreenAnchors.LastStandVignette })
	AdjustColorGrading({ Name = "DeathDefianceSubtle", Duration = secondChanceFxInTime })

	RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "Combat_Menu", DrawGroup = true })

	-- camera
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.01 })
	FocusCamera({ Fraction = 1.03, Duration = 0.045, ZoomType = "Ease" })

	-- pause the game
	AddSimSpeedChange( "LastStand", { Fraction = 0.005, LerpTime = 0.0001, Priority = true } )

	-- play voiceover
	thread( PlayerLastStandVoicelines, args )
	thread( PlayerLastStandSFX )
	waitUnmodified( 0.3, RoomThreadName )

	thread( CrowdReactionPresentation, { AnimationNames = { "StatusIconGrief", "StatusIconOhBoy", "StatusIconEmbarrassed" }, Sound = "/SFX/TheseusCrowdBoo", ReactionChance = 0.05, Requirements = { RequiredRoom = "C_Boss01" }, Delay = 1, Shake = true, RadialBlur = true } )

	-- pop the death defiance
	LostLastStandPresentation()
	UpdateLifePips()
	thread( PlayerLastStandProcText, args )

	waitUnmodified( 1.1, RoomThreadName )

end

function ScyllaSpotlightPresentation( flagData, scylla )
	if not flagData then
		return
	end
	local targetId = flagData.Id

	RestoreSirenMusic(scylla)
	waitUnmodified( 0.2, RoomThreadName )

	if flagData.SoloMusicFunction ~= nil then
		CallFunctionName( flagData.SoloMusicFunction, scylla )
	end
	
	-- camera
	PanCamera({ Ids = { targetId }, Duration = 0.3 })
	FocusCamera({ Fraction = 0.9, Duration = 0.3, ZoomType = "Ease" })
	-- pause the game
	AddSimSpeedChange( "ScyllaSpotlight", { Fraction = 0.1, LerpTime = 0.31, Priority = true } )

	thread( InCombatText, targetId, "FeaturedArtist", 1.4, { ShadowScale = 0.66, OffsetY = -215, PreDelay = 0.2 } )
	PlaySound({ Name = "/SFX/PoseidonWrathWaveCrash", Id = targetId, Delay = 0.2 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3Distance", Id = targetId, Delay = 0.2 })

	local randomCheers =
	{
		"/SFX/ScyllaCrowdApplause1",
		"/SFX/ScyllaCrowdApplause2",
		"/SFX/ScyllaCrowdCrappyWoo1",
		"/SFX/ScyllaCrowdCrappyWoo3"
	}
	local randomCheer = RemoveRandomValue( randomCheers )
	PlaySound({ Name = randomCheer, Delay = 0.5 })
	
	if flagData.SoloVoiceLines ~= nil then
		thread( PlayVoiceLines, flagData.SoloVoiceLines )
	end

	waitUnmodified( 3.2, RoomThreadName )

	RemoveSimSpeedChange( "ScyllaSpotlight", { LerpTime = 0.25 } )

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5, OffsetX = 0, OffsetY = 0, Retarget = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.5, ZoomType = "Ease" })

	--waitUnmodified( 2.0, RoomThreadName )
end

function SoloSirenKeytarist( scylla )
	scylla.TargetMusicStemVolume = 0.65
	SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 0.65, Duration = 1 })
	SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.MusicId, Value = 1.0, Duration = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0.65, Duration = 1 })
end

function SoloSirenDrummer( scylla )
	scylla.TargetMusicStemVolume = 0.65
	SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 0.65, Duration = 1 })
	SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.MusicId, Value = 0.65, Duration = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 1.0, Duration = 1 })
end

function SoloSirenVocalist( scylla )
	scylla.TargetMusicStemVolume = 1.0
	SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 1.0, Duration = 1 })
	SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.MusicId, Value = 0.65, Duration = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0.65, Duration = 1 })
end

function RestoreSirenMusic( scylla )
	scylla.TargetMusicStemVolume = 1.0
	SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 1.0, Duration = 0.2 })
	SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.MusicId, Value = 1.0, Duration = 0.2 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 1.0, Duration = 0.2 })
end

function ErisSelfBuffApply( triggerArgs )
	local victim = triggerArgs.Victim
	local effectName = triggerArgs.EffectName
	local effectData = EffectData[triggerArgs.EffectName]

	if triggerArgs.Reapplied then
		return
	end

	SetAnimation({ DestinationId = victim.ObjectId, Name = "Enemy_Eris_Yell" })
	StopAnimation({ Name = "Invincibubble", DestinationId = victim.ObjectId })

	waitUnmodified( 0.2, RoomThreadName )
	
	-- camera
	PanCamera({ Ids = { CurrentRun.Hero.ObjectId, victim.ObjectId }, Duration = 0.2 })
	FocusCamera({ Fraction = 0.9, Duration = 0.2, ZoomType = "Ease" })

	-- pause the game
	AddSimSpeedChange( "ErisSelfBuff", { Fraction = 0.1, LerpTime = 0.25, Priority = true } )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAnger" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/SkillUpgradeConfirm" })
	PlaySound({ Name = "/SFX/Enemy Sounds/Eris/EmoteLaugh", Delay = 0.15 })

	thread( InCombatText,victim.ObjectId, "ErisPowerUpActivated", 1.4, { ShadowScale = 0.66, OffsetY = -215 } )

	waitUnmodified( 2.0, RoomThreadName )

	RemoveSimSpeedChange( "ErisSelfBuff", { LerpTime = 0.25 } )

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5, OffsetX = 0, OffsetY = 0, Retarget = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.5, ZoomType = "Ease" })

	waitUnmodified( 2.0, RoomThreadName )
end

function PlayerLastStandProcText( args )
	waitUnmodified(  0.2 )
	if args.HasLastStand or not CurrentRun.Hero.MaxLastStands or CurrentRun.Hero.MaxLastStands == 1 then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_ExtraChance", 0.9, { ShadowScale = 0.66, OffsetY = 75 } )	
	else
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_LastChance", 0.9, { ShadowScale = 0.66, OffsetY = 75 } )
		PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteFiredUpLASTCHANCE", Delay = 0.5 })
	end
end

function PlayerLastStandPresentationEnd()
	RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Names = { "Combat_Menu" } })
	AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "Standing", DrawGroup = true })
	waitUnmodified( 1.0, RoomThreadName )
	local secondChanceFxOutTime = 0.4
	AdjustRadialBlurStrength({ Fraction = 0, Duration = secondChanceFxOutTime  })
	AdjustFrame({ Duration = secondChanceFxOutTime, Fraction = 0 })
	RemoveSimSpeedChange( "LastStand", { LerpTime = secondChanceFxOutTime } )
	AdjustFullscreenBloom({ Name = "DeathDefiance", Duration = secondChanceFxOutTime * 0.1 })

	SetAlpha({ Id = ScreenAnchors.LastStandVignette, Fraction = 0, Duration = 0.06 })
	if CurrentRun.Hero.LastStandTimeMultiplier then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1/CurrentRun.Hero.LastStandTimeMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "HeroTeam" } })
	end
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = secondChanceFxOutTime, ZoomType = "Ease" })

	AdjustColorGrading({ Name = "None", Duration = secondChanceFxOutTime })

	thread( function()
		wait( secondChanceFxOutTime * 0.1 )
		AdjustFullscreenBloom({ Name = "Off", Duration = secondChanceFxOutTime * 0.5, })
	end )

end

function PlayerLastStandVoicelines( args )
	if args.HasLastStand or GetNumMetaUpgradeLastStands() <= 1 then
		PlayVoiceLines( HeroVoiceLines.LastStandVoiceLines, true )
	else
		PlayVoiceLines( HeroVoiceLines.LastStandLastLifeVoiceLines )
	end
	for k, enemy in pairs( ActiveEnemies ) do
		if enemy.LastStandReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.LastStandReactionVoiceLines, true, enemy )
		end
	end
end

function PlayerBlockDeathVoicelines( args )
	thread( PlayVoiceLines, HeroVoiceLines.BlockDeathVoiceLines, true )
	for k, enemy in pairs( ActiveEnemies ) do
		if enemy.BlockDeathReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.BlockDeathReactionVoiceLines, true, enemy )
		end
	end
end

function PlayerLastStandHealingText( args )
	waitUnmodified(  0.2 )
	PlaySound({ Name = "/Leftovers/SFX/StaminaSkillProc", Id = CurrentRun.Hero.ObjectId })
	OnPlayerHealed({ ActualHealAmount = CurrentRun.Hero.Health })
	local healthFlash = HUDScreen.Components.HealthFlash
	if healthFlash ~= nil then
		CreateAnimation({ Name = "LastStandHealthBarRefillFlare", DestinationId = healthFlash.Id, Group = "Combat_Menu_Additive", OffsetY = -12, OffsetX = 40 })
	end
end

function PlayerLastStandManaGainText( args )
	if args.Delay then
		waitUnmodified( args.Delay )
	end
	thread(PopOverheadText, {Amount = args.Amount, Text = "HealingAmount", Color = Color.RoyalBlue, SkipShadow = true })
end

function PlayerLastStandSFX( )
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
	--SetAnimation({ Name = "ZagreusWrath", DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Melinoe_LastStand_Fire", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ZagreusWrathFire", DestinationId = CurrentRun.Hero.ObjectId, Color = Color.White })
	CreateAnimation({ Name = "DeathDefianceShockwave", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayerLastStandHealingText, args )
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

	CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = ScreenAnchors.LifePipIds[ index ], GroupName = "Overlay" })
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
	PlaySound({ Name = "/Leftovers/SFX/StaminaRefilled", Id = unitId })
end

function ArmorRestoredPresentation( enemy )
	local enemyId = enemy.ObjectId
	local offsetY = -155
	if enemy.Scale ~= nil then
		offsetY = offsetY * enemy.Scale
	end
	if enemy.HealthBarOffsetY then
		offsetY = enemy.HealthBarOffsetY
	end

	SetAnimation({ Name = "HealthBarArmorIcon", DestinationId = EnemyHealthDisplayAnchors[enemyId.."armor"] })
	local promptId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI_World", DestinationId = enemyId, OffsetY = offsetY })
	SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = promptId})
	Attach({ Id = promptId, DestinationId = enemyId, OffsetY = offsetY })
	CreateTextBox({	Id = promptId, Text = "ARMOR RESTORED!!", Justification = "CENTER",
		ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		Font = "LatoBoldItalic", FontSize = "40", Color = {255,255,255,255},
		CharacterFadeTime = 0, CharacterFadeInterval = 0, Group = "Combat_UI_World",
		AutoSetDataProperties = false
		})
	ModifyTextBox({ Id = promptId, ScaleTarget = 6.2, ScaleDuration = 10, AutoSetDataProperties = false })
	Move({ Id = promptId, Distance = 100, Angle = 0, Duration = 1, EaseOut = 1 })

	wait(0.25)
	ModifyTextBox({ Id = promptId, FadeTarget = 0.0, FadeDuration = 1.5, ColorTarget = {1, 0, 0, 1}, ColorDuration = 0.5, AutoSetDataProperties = false })
	wait(1.5)

	DestroyTextBox({ Id = promptId })
end

function PerfectClearObjectiveFailedPresentation( run )
	thread( PlayVoiceLines, GlobalVoiceLines.PerfectClearGotHitVoiceLines, true )
	local source = {} -- Dummy source for disembodied voice
	source.SubtitleColor = Color.HadesVoice

	if CurrentRun.CurrentRoom.Encounter.StartTime ~= nil and _worldTime - CurrentRun.CurrentRoom.Encounter.StartTime < 11 then
		if CheckCooldown( "PerfectClearEncounterFailed", 60.0 ) then
			-- thread( HadesSpeakingPresentation, source, { VoiceLines = GlobalVoiceLines.PerfectClearEncounterQuicklyFailedVoiceLines, ColorGrade = "PerfectClear", StartDelay = 1.0 } )
		end
	else
		if CheckCooldown( "PerfectClearEncounterFailed", 60.0 ) then
			-- thread( HadesSpeakingPresentation, source, { VoiceLines = GlobalVoiceLines.PerfectClearEncounterFailedVoiceLines, ColorGrade = "PerfectClear", StartDelay = 1.0 } )
		end
	end
end

function PerfectClearTraitStartPresentation( traitData )
	PlaySound({ Name = "/EmptyCue" })
	TraitUIActivateTrait( traitData )
end

function PerfectClearTraitFailedPresentation( traitData )
	TraitUIDeactivateTrait( traitData )
	PlaySound({ Name = "/SFX/ThanatosHermesKeepsakeFail" })
	thread( PlayVoiceLines, HeroVoiceLines.KeepsakeChallengeFailedVoiceLines, true )
	local existingTraitData = GetExistingUITrait( traitData )
	if existingTraitData then
		Shake({ Id = existingTraitData.AnchorId, Distance = 3, Speed = 500, Duration = 0.25 })
		Flash({ Id = existingTraitData.AnchorId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.Black, ExpireAfterCycle = true })
	end
end

function PerfectClearTraitSuccessPresentation( traitData )
	TraitUIDeactivateTrait( traitData )
	thread( PlayVoiceLines, HeroVoiceLines.PerfectClearDamageBonusUpgradedVoiceLines, true )
	local existingTraitData = GetExistingUITrait( traitData )
	if existingTraitData then
		Flash({ Id = existingTraitData.AnchorId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.LimeGreen, ExpireAfterCycle = true })
		CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = existingTraitData.AnchorId, GroupName = "Overlay" })
		thread( InCombatText, existingTraitData.AnchorId, "PerfectClearDamageBonus", 1.5 , { ScreenSpace = true, OffsetX = 170, OffsetY = 10, Angle = 0, LuaKey = "TempTextData", LuaValue = traitData })
	end
	wait( 0.45, RoomThreadName )

	local soundId = PlaySound({ Name = "/SFX/ThanatosAttackBell" })
	SetVolume({ Id = soundId, Value = 0.3 })
	CreateAnimation({ Name = "ThanatosDeathsHead_Small", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.3 })

end

function FastClearTraitStartPresentation( clearTimeThreshold, traitData )
	PlaySound({ Name = "/EmptyCue" })
	TraitUIActivateTrait( traitData, { CustomAnimation = "ActiveTraitSingle", PlaySpeed = 30 / clearTimeThreshold })
end

function FastClearTraitFailedPresentation( traitData )
	TraitUIDeactivateTrait( traitData )
	PlaySound({ Name = "/SFX/ThanatosHermesKeepsakeFail" })
	thread( PlayVoiceLines, HeroVoiceLines.KeepsakeChallengeFailedVoiceLines, true )
	local existingTraitData = GetExistingUITrait( traitData )
	if existingTraitData then
		Shake({ Id = existingTraitData.AnchorId, Distance = 3, Speed = 500, Duration = 0.25 })
		Flash({ Id = existingTraitData.AnchorId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.Black, ExpireAfterCycle = true })
	end
end

function FastClearTraitSuccessPresentation( traitData )
	TraitUIDeactivateTrait( traitData )
	thread( PlayVoiceLines, HeroVoiceLines.FastClearDodgeBonusUpgradedVoiceLines, true )
	local existingTraitData = GetExistingUITrait( traitData )
	if existingTraitData then
		Flash({ Id = existingTraitData.AnchorId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.LimeGreen, ExpireAfterCycle = true })
		CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = existingTraitData.AnchorId, GroupName = "Overlay" })
		thread( InCombatText, existingTraitData.AnchorId, "FastClearDamageBonus", 1.5 , { ScreenSpace = true, OffsetX = 170, OffsetY = 10, Angle = 0, LuaKey = "TempTextData", LuaValue = traitData })
	end
	wait( 0.45, RoomThreadName )

	local soundId = PlaySound({ Name = "/SFX/Player Sounds/HermesWhooshDashReverse" })
	PlaySound({ Name = "/Leftovers/SFX/PositiveTalismanProc_3" })
	SetVolume({ Id = soundId, Value = 0.3 })
	CreateAnimation({ Name = "HermesWings", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.3 })

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
			thread( PlayVoiceLines, GlobalVoiceLines.RevengeKillingEnemyVoiceLines, true )
		elseif not SessionMapState.FrameFlags.KillingEnemyVoiceLines then
			thread( PlayVoiceLines, GlobalVoiceLines.KillingEnemyVoiceLines, true )
			SessionMapState.FrameFlags.KillingEnemyVoiceLines = true
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
	if isCritical then
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

	if triggerArgs.WeaponName == "BaseCollision" then
		wallHit = true
		damageTextAnchor = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", DestinationId = victim.ObjectId, Group = "Combat_UI_World", OffsetX = 0 + randomOffsetX, OffsetY = offsetY + randomOffsetY })
	elseif isCritical or not damageProjectileSourceName then

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
					
					ModifyTextBox({ Id = damageTextAnchor, Text = ScreenAnchors[victim.ObjectId][damageProjectileSourceName].TargetNumber, ScaleTarget = 1.1, ScaleDuration = 0 })
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

	local isSpecialDamage = isCritical
	if isSpecialDamage then
		-- enemy takes critical / backstab / wall slam damage
		local textColor = Color.White
		if wallHit then
			textColor = Color.WallSlamDamageLight
		end
		local randomFontSize = RandomInt( 56, 62 )
		CreateTextBox({
			Id = damageTextAnchor,
			Text = "CriticalDamageAmount",
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
		if triggerArgs.ProjectileDeflected then
			color = ProjectileData.DeflectedProjectileColor.DamageTextStartColor
		elseif triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] then
			if ProjectileData[triggerArgs.SourceProjectile].DamageTextStartColor then
				color = ProjectileData[triggerArgs.SourceProjectile].DamageTextStartColor
			end
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
		ModifyTextBox({ Id = damageTextAnchor, Text = ScreenAnchors[victim.ObjectId][damageProjectileSourceName].TargetNumber })
	end

	local randomDuration = 1
	local driftOffsetX = RandomInt( -120, 120 )
	if wallHit then
		CreateAnimation({ Name = "CriticalHitWallSlam", DestinationId = victim.ObjectId })
	end
	if isSpecialDamage then
		PlaySound({ Name = "/SFX/CriticalHit", Id = victim.ObjectId })
		Shift({ Id = damageTextAnchor, OffsetX = driftOffsetX, OffsetY = -100, Duration = randomDuration * 2, EaseIn = 0.99, EaseOut = 0.1, TimeModifierFraction = 1.0 })
		waitUnmodified( 0.1)
		if wallHit then
			ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.75, ScaleDuration = 0.4, ColorTarget = Color.WallSlamDamage, ColorDuration = 0.4, AutoSetDataProperties = false })
		else
			ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.5, ScaleDuration = 0.15, ColorTarget = Color.Yellow, ColorDuration = 0.5, AutoSetDataProperties = false })
		end
	else
		Shift({ Id = damageTextAnchor, OffsetX = driftOffsetX, OffsetY = -50, Duration = randomDuration, EaseIn = 0.99, EaseOut = 0.1, TimeModifierFraction = 1.0 })
		waitUnmodified( 0.1)
		if triggerArgs.ProjectileDeflected then
			ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.75, ScaleDuration = 0.4, ColorTarget = ProjectileData.DeflectedProjectileColor.DamageTextColor, ColorDuration = 0.4, AutoSetDataProperties = false })
		elseif triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] and ProjectileData[triggerArgs.SourceProjectile].DamageTextColor then
			ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.75, ScaleDuration = 0.4, ColorTarget = ProjectileData[triggerArgs.SourceProjectile].DamageTextColor, ColorDuration = 0.4, AutoSetDataProperties = false })
		elseif triggerArgs.EffectName ~= nil and EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].DamageTextColor then
			ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.75, ScaleDuration = 0.4, ColorTarget = EffectData[triggerArgs.EffectName].DamageTextColor, ColorDuration = 0.4, AutoSetDataProperties = false })
		else
			ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.75, ScaleDuration = 0.4, ColorTarget = {0,0,0}, ColorDuration = 0.4, AutoSetDataProperties = false })
		end
	end

	if isSpecialDamage then
		waitUnmodified( 0.45)
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
	PlaySound({ Name = "/Leftovers/Menu Sounds/LevelUpFlash", Id = unitId })
	Flash({ Id = unitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.15, ExpireAfterCycle = true })
	thread( InCombatText, unitId, "ParryHit", 0.5 , { SkipShadow = true } )
end

function ShadeBlockPresentation( blocker, args )
	if blocker.IsDead then
		return
	end

	Flash({ Id = blocker.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.15, ExpireAfterCycle = true })
	CreateAnimation({ Name = "ShadeShieldBlock", DestinationId = blocker.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/Exalted/EnemyShieldBlock", Id = blocker.ObjectId })

	if CheckCooldown( "BlockHint"..blocker.ObjectId, 0.2 ) then
		thread( InCombatText, blocker.ObjectId, "BlockHit", 0.4, { SkipShadow = true } )
	end
end

function UnitInvulnerableHitPresentation( blocker, args )
	Flash({ Id = blocker.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.15, ExpireAfterCycle = true })
	CreateAnimation({ Name = blocker.InvulnerableHitFx, DestinationId = blocker.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/Exalted/EnemyShieldBlock", Id = blocker.ObjectId })

	if CheckCooldown( "BlockHint"..blocker.ObjectId, 0.2 ) then
		thread( InCombatText, blocker.ObjectId, "BlockHit", 0.4, { SkipShadow = true } )
	end
end

function HecateCloneHitPresentation( blocker, args )
	if blocker.IsDead then
		return
	end

	Flash({ Id = blocker.ObjectId, Speed = 0.85, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.Green, Duration = 0.15, ExpireAfterCycle = true })
	SetAlpha({ Id = blocker.ObjectId, Fraction = 0.2, Duration = 0.05 })
	PlaySound({ Name = "/Leftovers/SFX/InvincibleOnHit", Id = blocker.ObjectId })

	wait(0.15)
	SetAlpha({ Id = blocker.ObjectId, Fraction = 1.0, Duration = 0.13 })
end

function CocoonHitPresentation( unitData )
	if unitData and unitData.IsDead then
		return
	end

	local unitId = unitData.ObjectId
	Flash({ Id = unitId, Speed = 0.85, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.Red, Duration = 0.15, ExpireAfterCycle = true })
	PlaySound({ Name = "/SFX/Player Sounds/AthenaDashImpact", Id = unitId })
	CreateAnimation({ Name = "HitSparkD", DestinationId = unitId, Angle = 270, Scale = 1.3 })
end

function BlockAttackPresentation( unitId )
	if unitId ~= CurrentRun.Hero.ObjectId then
		return
	end
	PlaySound({ Name = "/SFX/Enemy Sounds/Exalted/EnemyShieldBlock", Id = unitId })
	Flash({ Id = unitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.15, ExpireAfterCycle = true })
	thread( InCombatText, unitId, "BlockHit", 0.4, { SkipShadow = true } )
	wait(0.15)
end

function UnblockableAttackPresentation( unitId )
	thread( InCombatText, unitId, "UnblockableHit", 0.8, { SkipShadow = true } )
end

function ArmorDamagePresentation( victim, args )
	thread( DoUnitArmorShake, victim, args )
	thread( DoUnitArmorSpark, victim, args )
	-- thread( PlayVoiceLines, HeroVoiceLines.StruckArmorVoiceLines, true )

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
	thread( DoWeaponHitSimulationSlow, victim, args )
	thread( DoWeaponScreenshake, sourceSimData, "HitScreenshake", { AttackerId = args.AttackerId, SourceProjectile = args.SourceProjectile, EffectName = args.EffectName, DistanceSquared = args.DistanceSquared })	
	if sourceSimData ~= nil then
		thread( DoCameraMotion, sourceSimData.HitCameraMotion )
		thread( DoWeaponHitRumble, sourceSimData, args )
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
	if victim ~= CurrentRun.Hero and sourceSimData ~= nil and sourceSimData.PresentationOnlyOnPlayerHit then
		return
	end
	thread( DoWeaponHitSimulationSlow, victim, args, sourceSimData )
	thread( DoWeaponScreenshake, sourceSimData, "HitScreenshake", args )
	if sourceSimData ~= nil then
		thread( DoCameraMotion, sourceSimData.HitCameraMotion )
		thread( DoWeaponHitRumble, sourceSimData, args )
	end
end

function SpecialHitPresentation( unit, triggerArgs )
	local attacker = triggerArgs.AttackerTable
	local unitId = unit.ObjectId
	
	local isCritical = triggerArgs.IsCrit
	local hitVulnerable = triggerArgs.HitVulnerability
	local offsetY = unit.HealthBarOffsetY or -155

	if hitVulnerable then
		CreateAnimation({ Name = "Backstab", DestinationId = unitId })
		if triggerArgs.TriggeredHitVulnerabilityMultiplier then
			if CheckCooldown( "BackstabMessagePlayed", 0.1 ) then
				thread( InCombatText, unitId, "BackstabHit", 0.3, {OffsetY = offsetY + 36, FontSize = 24, SkipFlash = true, SkipRise = true, SkipShadow = true, FadeDuration = 0.1 })
			end
		end
	end
	if triggerArgs.TriggeredVengeanceMultiplier then
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
			end

			if effectName and EffectData[effectName] and EffectData[effectName].CancelHitSpark then
				showSpark = false
			end
			if showSpark then
				CreateAnimation({ Name = "HitSparkVulnerability", DestinationId = unitId })
			end
	end
end

function WallHitPresentation( victim, triggerArgs )
	local attacker = triggerArgs.AttackerTable
	if attacker ~= nil and attacker.HitText ~= nil then
		thread( InCombatText, victim.ObjectId, attacker.HitText, 0.3, {SkipShadow = true} )
		return
	end
	if triggerArgs.AttackerName and ObstacleData[triggerArgs.AttackerName] and ObstacleData[triggerArgs.AttackerName].HitText then
		thread( InCombatText, victim.ObjectId, ObstacleData[triggerArgs.AttackerName].HitText, 0.3, {SkipShadow = true} )
		return
	end
	if triggerArgs.AttackerName and EnemyData[triggerArgs.AttackerName] then
		if EnemyData[triggerArgs.AttackerName].SkipModifiers then
			thread( InCombatText, victim.ObjectId, "PitSlamHit", 0.3, {SkipShadow = true}  )
		end
		return
	end
	
	thread( InCombatText, victim.ObjectId, "PitSlamHit", 0.3, {SkipShadow = true} )
end

function IndestructibleObstacleHitPresentation( victim, triggerArgs )

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

function WheatHit( victim, triggerArgs )

	CreateAnimation({ Name = victim.DeathFx, DestinationId = victim.ObjectId, Angle = triggerArgs.ImpactAngle })	

	if triggerArgs.EffectName == nil then
		thread( DoImpactSound, victim, triggerArgs )
	end

	if victim.OnHitShake ~= nil then
		victim.OnHitShake.Id = victim.ObjectId
		Shake( victim.OnHitShake )
	end

	if victim.SpawnObstaclesOnDeath ~= nil then
		SpawnObstaclesOnDeath( victim, triggerArgs )
	end

	Destroy({ Id = victim.ObjectId })

end

function EchoDamagePresentation( triggerArgs )


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

	wait( args.PreDelay )

	local feedbackRiser = nil

	if args.ScreenSpace then
		feedbackRiser = CreateScreenComponent({ Name = "BlankObstacleNoTimeModifier", Group = args.Group, DestinationId = targetId }).Id
	else
		feedbackRiser = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", Group = args.Group, DestinationId = targetId, OffsetY = args.OffsetY or -140 })
	end

	if args.SkipRise then
		Attach({ Id = feedbackRiser, DestinationId = targetId, OffsetY = args.OffsetY or 55 })
	end

	local locationZWithOwner = true
	if not args.SkipShadow then
		SetAnimation({  Name = "InCombatTextShadow", DestinationId = feedbackRiser, OffsetY = -10 })
		locationZWithOwner = false
	end

	if not args.SkipFlash then
		CreateAnimation({  Name = "SkillProcFeedbackFx", DestinationId = feedbackRiser, OffsetY = -10, Scale = 1.0, Group = "Combat_UI_Additive" })
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
		AutoSetDataProperties = false,
		LocationZWithOwner = locationZWithOwner,
		UseDescription = args.UseDescription,
		})

	if not args.SkipRise then
		Move({ Id = feedbackRiser, Angle = args.Angle, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 0.75 })
	end

	waitUnmodified(  args.Duration )
	ModifyTextBox({ Id = feedbackRiser, FadeTarget = 0, FadeDuration = args.FadeDuration, AutoSetDataProperties = false, })

	if not args.SkipShadow then
		SetAnimation({  Name = "InCombatTextShadowFade", DestinationId = feedbackRiser, OffsetY = -10 })
	end

	waitUnmodified( 0.41)
	Destroy({ Id = feedbackRiser })

end

function PlayerDodgePresentation()
	if CheckCooldown( "DodgePresentation", 0.3 ) then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Combat_Miss", 0.4, {SkipShadow = true} )
		CreateAnimation({ Name = "MelDodge", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
		PlaySound({ Name = "/SFX/Player Sounds/HermesWhooshDodgeSFX", Id = CurrentRun.Hero.ObjectId })
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

OnWeaponCharging{
	function( triggerArgs )
		local weaponData = GetWeaponData(triggerArgs.OwnerTable, triggerArgs.name)
		if weaponData == nil then
			return
		end
		thread( DoCameraMotion, weaponData.ChargeCameraMotion )
		thread( DoWeaponScreenshake, weaponData, "ChargeScreenshake", { AttackerId = CurrentRun.Hero.ObjectId, SourceProjectile = triggerArgs.SourceProjectile })
		if weaponData.ShowManaIndicator or (  WeaponData[triggerArgs.name] and WeaponData[triggerArgs.name] .ManaCost ) then
			thread( HandleManaChargeIndicator, triggerArgs )
		end
		if weaponData.Sounds ~= nil then
			DoWeaponSounds( weaponData.Sounds.ChargeSounds, triggerArgs.OwnerTable, weaponData )
		end
		StopWeaponSounds( "Charge", weaponData.Sounds, triggerArgs.OwnerTable )
	end
}

function DoWeaponScreenshake( sourceData, key, args )

	if SessionMapState.SecondaryEffectsThisFrame >= ConfigOptionCache.SecondaryEffectsFrameCap then
		--DebugPrint({ Text = "Ignoring secondary effect (ScreenShake) over frame budget" })
		return
	end

	local attackerId = args.AttackerId
	local projectileName = args.SourceProjectile
	local effectName = args.EffectName
	local distanceSquared = args.DistanceSquared
	local screenshakeData = nil
	if sourceData then
		screenshakeData = sourceData[key]
	end
	if screenshakeData == nil then
		local projectileData = GetProjectileData( args.AttackerTable, projectileName )
		if projectileData and key and projectileData[key] then
			screenshakeData = projectileData[key]
		end
	end

	
	if screenshakeData == nil then
		return
	end

	if projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].CancelCameraShake == true then
		return
	end

	if effectName and EffectData[effectName] and EffectData[effectName].CancelCameraShake == true then
		return
	end

	if wrathPresentation then
		return
	end
	
	if screenshakeData.DistanceThreshold and ( not distanceSquared or distanceSquared == -1 or distanceSquared > ( screenshakeData.DistanceThreshold * screenshakeData.DistanceThreshold )) then
		return
	end

	if screenshakeData.ScreenPreWait then
		wait( screenshakeData.ScreenPreWait )
	end

	if screenshakeData.DynamicAngleOffset then
		screenshakeData.Angle = GetPlayerAngle() + screenshakeData.DynamicAngleOffset
	end
	ShakeScreen( screenshakeData )
	wait( screenshakeData.Duration )

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
	if cameraData == nil or cameraData.ZoomType == "None" then
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
	if relativeCameraData.ZoomType ~= nil then
		FocusCamera( relativeCameraData )
	else
		PanCamera( relativeCameraData )
	end
	local additionalCameraWait = relativeCameraData.HoldDuration or 0
	local restoringDefault = false
	if relativeCameraData.RestoreDefaultDuration then
		waitUnmodified( relativeCameraData.Duration + additionalCameraWait )
		FocusCamera({ Fraction = defaultZoom, Duration = relativeCameraData.RestoreDefaultDuration })
		restoringDefault = true
	end
	waitUnmodified( relativeCameraData.RestoreDefaultDuration )
	if restoringDefault then
		SessionMapState.WeaponZoomActive = false
	end
end

function DoWeaponFireSimulationSlow( weaponData )
	if weaponData == nil or weaponData.FireSimSlowParameters == nil then
		return
	end
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

function DoWeaponHitSimulationSlow( victim, args, sourceSimData )
	local attackerId = args.AttackerId
	local defenderId = victim.ObjectId
	local weaponData = GetWeaponData(args.AttackerTable, args.SourceWeapon)
	local damageCrit = args.IsCrit
	local damageVulnerability = args.IsVulnerability
	local defenderData = victim
	local projectileData = nil
	local effectData = nil
	local sourceStaggerSimData = sourceSimData or weaponData
	
	if args.SourceProjectile ~= nil then
		projectileData = ProjectileData[args.SourceProjectile]
	end

	if args.EffectName ~= nil then
		effectData = EffectData[args.EffectName]
	end

	if not IsEmpty( MapState.SimSpeedChanges ) then
		return
	end
	
	if args.ProjectileDeflected or ( projectileData and projectileData.CancelSlowFrames ) or ( effectData and effectData.CancelSlowFrames ) then
		return
	end
	if sourceStaggerSimData == nil or sourceStaggerSimData.HitSimSlowParameters == nil then
		sourceStaggerSimData = projectileData
	end
	if sourceStaggerSimData == nil or sourceStaggerSimData.HitSimSlowParameters == nil then
		return
	end

	if not sourceStaggerSimData.HitPresentationIgnoresOwnership then

		if defenderData ~= nil and not defenderData.SimulationSlowOnHit and defenderData.ObjectId ~= CurrentRun.Hero.ObjectId then
			return
		end

		if attackerId ~= CurrentRun.Hero.ObjectId and defenderData ~= nil and defenderData.ObjectId ~= CurrentRun.Hero.ObjectId then
			return
		end
	end

	if sourceStaggerSimData.SimSlowDistanceThreshold and ( not args.DistanceSquared or args.DistanceSquared == -1 or args.DistanceSquared > (sourceStaggerSimData.SimSlowDistanceThreshold * sourceStaggerSimData.SimSlowDistanceThreshold )) then
		return
	end

	local criticalSlowHoldTime = 0
	local criticalCooldownTime = sourceStaggerSimData.HitSimSlowCooldown or 0
	if criticalCooldownTime == 0 or CheckCooldown( sourceStaggerSimData.Name, criticalCooldownTime ) then
		for k, simData in ipairs( sourceStaggerSimData.HitSimSlowParameters ) do
			if ShouldIncreasePlayerHitPause( args ) then
				if( k == 2) then
					criticalSlowHoldTime = 0.04
				end
			end
			waitUnmodified(  (simData.ScreenPreWait + criticalSlowHoldTime) )
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

function GetLowestSimSpeed( ignoreNames )
	local lowestSimSpeed = { Fraction = 1.0 }
	for name, simSpeed in pairs( MapState.SimSpeedChanges ) do
		if (simSpeed.Fraction or 1.0) < (lowestSimSpeed.Fraction or 1.0) and not Contains(ignoreNames, name) then
			lowestSimSpeed = simSpeed
		end
	end
	return lowestSimSpeed.Fraction
end

function ShouldIncreasePlayerHitPause( args )
	if args.IsCrit then
		return true
	end
	if args.IsVulnerability then
		-- return true -- don't increase hit pause for backstabs
	end
	if args.TriggeredByTable ~= nil and args.TriggeredByTable.IsDead then
		return true
	end

	return false
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
	thread( LastAttackHold, 0.5 )

	local lastKillFxInTime = 0.08
	local lastKillFxOutTime = 0.4

	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0.85, Duration = lastKillFxInTime })
	AdjustFrame({ Duration = lastKillFxInTime, Fraction = 1.25 })
	AdjustFullscreenBloom({ Name = "LastKillBloom", Duration = 0 })
	AddSimSpeedChange( "LastKill", { Fraction = 0.35, LerpTime = lastKillFxInTime, Priority = true } )
	SetInvulnerable({ Id = CurrentRun.Hero.ObjectId })
	if not CurrentRun.CurrentRoom.SkipLastKillSound then
		PlaySound({ Name = "/SFX/LastKillSFX", Id = unitId })
	end
	waitUnmodified(  0.6 )

	AdjustRadialBlurStrength({ Fraction = 0, Duration = lastKillFxOutTime })
	AdjustFrame({ Duration = lastKillFxOutTime, Fraction = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = lastKillFxOutTime })
	RemoveSimSpeedChange( "LastKill", { LerpTime = lastKillFxOutTime } )
	waitUnmodified(  0.2 )

	ShowCombatUI("LastKill")
	thread( LastKillVulnerable )
end

function LastAttackHold( holdDuration )
	waitUnmodified(  holdDuration )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationNames = { "HeroTeam" } })
	CurrentRun.Hero.LastStandTimeMultiplier = nil
	RemoveInputBlock({ Name = "LastKill" })
end

function LastKillVulnerable()
	wait( 1.0 )
	SetPlayerVulnerable( "LastKill" )
end

function BossChillKillPresentation(unit)
	LoadVoiceBanks({ Name = "Demeter" })
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
	if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.StartTime then
		CurrentRun.CurrentRoom.Encounter.ClearTime = _worldTime - CurrentRun.CurrentRoom.Encounter.StartTime
	end

	local allBossesDead = true
	if CurrentRun.CurrentRoom.Encounter.HoldKillPresentationForUnitDeaths ~= nil then
		for k, unitName in pairs(CurrentRun.CurrentRoom.Encounter.HoldKillPresentationForUnitDeaths) do
			if unitName ~= unit.Name then
				local unitId = GetClosestUnitOfType({ Id = unit.ObjectId, DestinationName = unitName })
				if ActiveEnemies[unitId] ~= nil then
					allBossesDead = false
				end
			end
		end
	end

	if not allBossesDead then
		LastKillPresentation( unit )
		return
	end

	AddInputBlock({ Name = "GenericBossKillPresentation" })
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	local deathPanSettings = args
	ClearEffect({ Ids = { victimId, killerId }, All = true, BlockAll = true, })
	if unit.Frozen then
		UnfrozenPresentation( unit, { SkipPresentation = true })
	end
	--SetUnitInvulnerable( unit )

	if unit.DeathFx ~= nil then
		CreateAnimation({ Name = unit.DeathFx, DestinationId = unit.ObjectId, Angle = args.ImpactAngle })
		unit.DeathFx = nil
	end
	if unit.DeathAngle ~= nil then
		Halt({ Id = victimId })
		Stop({ Id = victimId })
		SetGoalAngle({ Id = victimId, Angle = unit.DeathAngle, CompleteAngle = true })
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

	CancelWeaponFireRequests({ Id = unit.ObjectId })
	BlockProjectileSpawns({ ExcludeProjectileName = "SpearWeaponThrow" })
	--ExpireProjectiles({ Names = { "DionysusLobProjectile", "LightRangedWeapon", "DusaFreezeShotNonHoming", "HarpyBeam", "HydraLavaSpit", "HarpyWhipShot", "HarpyWhipShotRage", "TheseusSpearThrow", "ShieldThrow" }, BlockSpawns = true })
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })


	SetPlayerInvulnerable( "GenericBossKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	if args.AddInterBiomeTimerBlock then
		AddTimerBlock( CurrentRun, "InterBiome" )
	end
	AddTimerBlock( CurrentRun, "GenericBossKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	SetVulnerable({ Id = victimId })
	ClearCameraClamp({ LerpTime = 0 })
	local cameraPanTime = 1.5
	if deathPanSettings.StartPanTime then
		cameraPanTime = deathPanSettings.StartPanTime
	end
	local offsetY = unit.DeathPanOffsetY or 0
	PanCamera({ Id = victimId, Duration = cameraPanTime, OffsetY = offsetY })
	FocusCamera({ Fraction = args.PanZoomFraction or 1.1, Duration = cameraPanTime })
	ZeroMouseTether("GenericBossKillPresentation")
	CancelWeaponFireRequests({ Id = killerId })
	ToggleCombatControl( CombatControlsDefaults, false, "BossKill" )
	HideCombatUI("BossKill")

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	end

	if deathPanSettings.StartSound then
		PlaySound({ Name = deathPanSettings.StartSound })
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteShocked" })
	end
	if not args.IgnoreEndMusic then
		EndMusic()
	end

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationId = killerId })
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

	thread( BossDeathFlash, 0.52, 0.3 )

	wait( 0.15 )
	if killerId == CurrentRun.Hero.ObjectId then
		SetPlayerFade({ Flag = "KillPresentation"})
	else
		SetAlpha({ Id = killerId, Fraction = 0, Duration = 0.3 })
	end
	ClearEffect({ Id = killerId, Name = "KillDamageBonus" })

	wait( cameraPanTime )

	local textMessage = deathPanSettings.Message
	if deathPanSettings.BossDifficultyMessage and GetNumShrineUpgrades( "BossDifficultyShrineUpgrade" ) > 0 then
		textMessage = deathPanSettings.BossDifficultyMessage
	end

	thread( DisplayInfoBanner, nil, { Text = textMessage or "BiomeClearedMessage", Delay = 0.75, TextColor = Color.Turquoise, Layer = "Overlay", FontScale = 0.9, AnimationName = "LocationBackingIrisDeathIn", AnimationOutName = "LocationBackingIrisDeathOut", Duration = 3.75 } )

	if deathPanSettings.BatsAfterDeath then
		thread( SendCritters, { MinCount = 80, MaxCount = 90, StartX = 0, StartY = 300, MinAngle = 75, MaxAngle = 115, MinSpeed = 400, MaxSpeed = 2000, MinInterval = 0.03, MaxInterval = 0.1, GroupName = "CrazyDeathBats" } )
	end

	if deathPanSettings.EndPanTime then
		wait( deathPanSettings.EndPanTime )
	else
		wait( 5.5 )
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

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	wait( 1.0 )
	SetAnimation({ DestinationId = killerId, Name = "MelinoeIdle" })
	RemoveInputBlock({ Name = "GenericBossKillPresentation" })
	RemoveTimerBlock( CurrentRun, "GenericBossKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "GenericBossKillPresentation" )
	ShowCombatUI("BossKill")
	ClearEffect({ Ids = { killerId }, All = true })
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	ToggleCombatControl( CombatControlsDefaults, true, "BossKill" )
	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
end

function ErisKillPresentation( unit, args )
	if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.StartTime then
		CurrentRun.CurrentRoom.Encounter.ClearTime = _worldTime - CurrentRun.CurrentRoom.Encounter.StartTime
	end

	local allBossesDead = true
	if CurrentRun.CurrentRoom.Encounter.HoldKillPresentationForUnitDeaths ~= nil then
		for k, unitName in pairs(CurrentRun.CurrentRoom.Encounter.HoldKillPresentationForUnitDeaths) do
			if unitName ~= unit.Name then
				local unitId = GetClosestUnitOfType({ Id = unit.ObjectId, DestinationName = unitName })
				if ActiveEnemies[unitId] ~= nil then
					allBossesDead = false
				end
			end
		end
	end

	if not allBossesDead then
		LastKillPresentation( unit )
		return
	end

	AddInputBlock({ Name = "GenericBossKillPresentation" })
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	local deathPanSettings = args
	ClearEffect({ Ids = { victimId, killerId }, All = true, BlockAll = true, })
	if unit.Frozen then
		UnfrozenPresentation( unit, { SkipPresentation = true })
	end
	--SetUnitInvulnerable( unit )

	if unit.DeathFx ~= nil then
		CreateAnimation({ Name = unit.DeathFx, DestinationId = unit.ObjectId, Angle = args.ImpactAngle })
		unit.DeathFx = nil
	end
	if unit.DeathAngle ~= nil then
		Halt({ Id = victimId })
		Stop({ Id = victimId })
		SetGoalAngle({ Id = victimId, Angle = unit.DeathAngle, CompleteAngle = true })
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

	CancelWeaponFireRequests({ Id = unit.ObjectId })
	BlockProjectileSpawns({ ExcludeProjectileName = "SpearWeaponThrow" })
	--ExpireProjectiles({ Names = { "DionysusLobProjectile", "LightRangedWeapon", "DusaFreezeShotNonHoming", "HarpyBeam", "HydraLavaSpit", "HarpyWhipShot", "HarpyWhipShotRage", "TheseusSpearThrow", "ShieldThrow" }, BlockSpawns = true })
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })


	SetPlayerInvulnerable( "GenericBossKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	if args.AddInterBiomeTimerBlock then
		AddTimerBlock( CurrentRun, "InterBiome" )
	end
	AddTimerBlock( CurrentRun, "GenericBossKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	SetVulnerable({ Id = victimId })
	ClearCameraClamp({ LerpTime = 0 })
	local cameraPanTime = 1.5
	if deathPanSettings.StartPanTime then
		cameraPanTime = deathPanSettings.StartPanTime
	end
	local offsetY = unit.DeathPanOffsetY or 0
	PanCamera({ Id = victimId, Duration = cameraPanTime, OffsetY = offsetY })
	FocusCamera({ Fraction = args.PanZoomFraction or 1.1, Duration = cameraPanTime })
	ZeroMouseTether("GenericBossKillPresentation")
	CancelWeaponFireRequests({ Id = killerId })
	ToggleCombatControl( CombatControlsDefaults, false, "BossKill" )
	HideCombatUI("BossKill")

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	end

	if deathPanSettings.StartSound then
		PlaySound({ Name = deathPanSettings.StartSound })
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteShocked" })
	end
	if not args.IgnoreEndMusic then
		EndMusic()
	end

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationId = killerId })
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


	thread( BossDeathFlash, 0.52, 0.3 )
	PlaySound({ Name = "/SFX/StabSplatterEndSequence", Delay = 0.52 })

	wait( 0.15 )
	if killerId == CurrentRun.Hero.ObjectId then
		SetPlayerFade({ Flag = "KillPresentation"})
	else
		SetAlpha({ Id = killerId, Fraction = 0, Duration = 0.3 })
	end
	ClearEffect({ Id = killerId, Name = "KillDamageBonus" })

	wait( cameraPanTime )

	local textMessage = deathPanSettings.Message
	if deathPanSettings.BossDifficultyMessage and GetNumShrineUpgrades( "BossDifficultyShrineUpgrade" ) > 0 then
		textMessage = deathPanSettings.BossDifficultyMessage
	end

	thread( DisplayInfoBanner, nil, { Text = textMessage or "BiomeClearedMessage", Delay = 0.75, TextColor = Color.Turquoise, Layer = "Overlay", FontScale = 0.9, AnimationName = "LocationBackingIrisDeathIn", AnimationOutName = "LocationBackingIrisDeathOut", Duration = 3.75 } )

	if deathPanSettings.BatsAfterDeath then
		thread( SendCritters, { MinCount = 80, MaxCount = 90, StartX = 0, StartY = 300, MinAngle = 75, MaxAngle = 115, MinSpeed = 400, MaxSpeed = 2000, MinInterval = 0.03, MaxInterval = 0.1, GroupName = "CrazyDeathBats" } )
	end

	CreateAnimation({ DestinationId = victimId, Name = "ErisDeathHandsFxIn", })
	local grabSoundId = PlaySound({ Name = "/SFX/Player Sounds/MelMagicalChargeLoop" })
	wait( 1.0 )
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGrabCharge" })
	wait( 1.0 )
	PanCamera({ Id = victimId, Duration = 1, OffsetY = -150, Retarget = true })
	CreateAnimation({ DestinationId = victimId, Name = "ErisDeathHandsFxBurst", })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TitanToggleLong" })
	StopSound({ Id = grabSoundId, Duration = 0.3 })
	wait( 0.2 )
	PlaySound({ Name = "/Leftovers/World Sounds/QuickSnap" })
	wait( 3.3 )
	SetAlpha({ Id = victimId, Fraction = 0, Duration = 0.0 })

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

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	wait( 1.0 )
	SetAnimation({ DestinationId = killerId, Name = "MelinoeIdle" })
	RemoveInputBlock({ Name = "GenericBossKillPresentation" })
	RemoveTimerBlock( CurrentRun, "GenericBossKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "GenericBossKillPresentation" )
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

function BossDeathFlash( startDelay, stopDelay )
	wait( startDelay )
	local bossDeathFlash = CreateScreenComponent({ Name = "BlankObstacle", Group = "Overlay" })
	SetAnimation({ DestinationId = bossDeathFlash.Id, Name = "MelDeathFlash" })
	wait( stopDelay )
	Destroy({ Id = bossDeathFlash.Id })
end

function ChronosKillPresentation( unit, args )

	ClearPauseMenuTakeover()

	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	ClearEffect({ Ids = { victimId, killerId }, All = true, BlockAll = true, })
	if not IsEmpty( unit.StopAnimationsOnHitStun ) then -- since hit stun isn't applied on death
		StopAnimation({ Names = unit.StopAnimationsOnHitStun, DestinationId = unit.ObjectId, PreventChain = true })
		if unit.FxTargetIdsUsed ~= nil then
			for id, v in pairs( unit.FxTargetIdsUsed ) do
				StopAnimation({ Names = unit.StopAnimationsOnHitStun, DestinationId = id, PreventChain = true })
			end
		end
	end

	SetUnitInvulnerable( unit )
	thread( LastKillPresentation, unit )
	SetPlayerInvulnerable( "ChronosKillPresentation" )
	AddInputBlock({ Name = "ChronosKillPresentation" })
	AddTimerBlock( CurrentRun, "ChronosKillPresentation" )
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if IsScreenOpen("TraitTrayScreen") then
		CloseAdvancedTooltipScreen()
	end

	SetMusicSection( 3 )

	Stop({ Id = unit.ObjectId })
	SetGoalAngle({ Id = unit.ObjectId, Angle = 210 })
	SetAnimation({ Name = "Enemy_Chronos_BattleOutro_Start", DestinationId = unit.ObjectId })
	StopAnimation({ Name = "ChronosInvincibubble", DestinationId = unit.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId })
	thread( PlayVoiceLines, unit.PhaseEndedVoiceLines, nil, unit )

	if GameState.TextLinesRecord.ChronosBossOutro01 then
		wait( 2.8, RoomThreadName )
	else
		wait( 4.0, RoomThreadName )
	end

	local textLines = GetRandomEligibleTextLines( unit, unit.BossOutroTextLineSets, GetNarrativeDataValue( unit, "BossOutroTextLinePriorities" ) )
	unit.TextLinesUseWeaponIdle = nil
	PlayTextLines( unit, textLines )

	SetCameraClamp({ Ids = GetIds({ Name = "CameraClamps" }), SoftClamp = 0.75 })

	thread( PlayVoiceLines, unit.DefeatedVoiceLines, true, unit )
	Destroy({ Ids = GetIds({ Name = "SpawnPointsPhase2" }) })
	if MapState.FamiliarUnit ~= nil then
		Teleport({ Id = MapState.FamiliarUnit.ObjectId, DestinationId = 713401 })
	end

	local chronosRemains = DeepCopyTable( ObstacleData.ChronosRemains )
	chronosRemains.ObjectId = SpawnObstacle({ Name = "ChronosRemains", Group = "Standing", DestinationId = args.VictimTeleportId })

	GenericBossKillPresentation( unit, args )
	SetAnimation({ Name = "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })

	--SetupObstacle(chronosRemains)
	--UseableOn({ Id = chronosRemains.ObjectId })

	-- AdjustColorGrading({ Name = "Desaturated", Duration = 0.75 })
	PlaySound({ Name = "/SFX/TimeSlowStart" })

	Destroy({ Ids = GetIds({ Name = "ChronosDeathDelete" }) })

	wait( 2.0 )

	RemoveInputBlock({ Name = "ChronosKillPresentation" })
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	
	OpenRunClearScreen()
	ClearCameraClamp({ LerpTime = 1.0 }) -- the map bounds are more restrictive during the fight

end

function ChronosRemainsEnterTriggerPresentation( source, args )
	CreateAnimation({ Name = "ChronosRemainsPulse", DestinationId = source.ObjectId })
	ScreenAnchors.ChronosRemainsVignette = CreateScreenObstacle({ Name = "BlankObstacle", Alpha = 0.0, Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY, })
	SetAnimation({ Name = "ChronosTimeStopFx", DestinationId = ScreenAnchors.ChronosRemainsVignette })
	AdjustColorGrading({ Name = "ChronosTimeSlow", Duration = 0.3 })
	AdjustRadialBlurDistance({ Fraction = 0.05, Duration = 0.3 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.3 })
	SetAlpha({ Id = ScreenAnchors.ChronosRemainsVignette, Fraction = 0.5, Duration = 0.3 })
end

function ChronosRemainsLeaveTriggerPresentation( source, args )
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.3 })
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	SetAlpha({ Id = ScreenAnchors.ChronosRemainsVignette, Fraction = 0.0, Duration = 0.3 })
	wait(0.3)
	Destroy({ Id = ScreenAnchors.ChronosRemainsVignette })
	ScreenAnchors.ChronosRemainsVignette = nil
end

function ChronosPostCombatReload( room, args )
	Destroy({ Ids = GetIds({ Name = "ChronosDeathDelete" }) })
	Destroy({ Ids = GetIds({ Name = "ChronosFightStartDelete" }) })
	ClearCameraClamp({ LerpTime = 1.0 }) -- the map bounds are more restrictive during the fight
end

function ClearShadeWeapons()
	local weaponIds = GetIdsByType({ Names = EnemyData.ShadeNaked.AIPickupTypes })
	Destroy({ Ids = weaponIds })
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

function InvisBreakPresentation()

	PlaySound({ Name = "/SFX/Player Sounds/HermesWhooshDashReverse", Id = CurrentRun.Hero.ObjectId })

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

function HitByMiasmaPresentation( victim )
	if victim ~= CurrentRun.Hero then
		return
	end

	local threadName = "PoisonGasThread"
	local fadeDuration = 0.4
	local clearDelay = 2.51

	if SetThreadWait( threadName, clearDelay ) then
		return
	end

	if victim.ChokingSound ~= nil then
		PlaySound({ Name = victim.ChokingSound, Id = victim.ObjectId })
	end
	PlaySound({ Name = "/SFX/WrathOver2", Id = victim.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.HitByMiasmaVoiceLines, true )

	AdjustFullscreenBloom({ Name = "Miasma", Duration = fadeDuration })
	AdjustColorGrading({ Name = "Miasma", Duration = fadeDuration })

	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {1,0.5,0.3,1}, Duration = fadeDuration })

	ScreenAnchors.MiasmaVignetteAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })
	ScreenAnchors.MiasmaVignette = SpawnObstacle({ Name = "BlankObstacle", DestinationId = ScreenAnchors.MiasmaVignetteAnchor, Group = "Combat_Menu_Additive" })
	SetAnimation({ Name = "MiasmaVignetteSpawner", DestinationId = ScreenAnchors.MiasmaVignette  })
	DrawScreenRelative({ Ids = { ScreenAnchors.MiasmaVignette } })
end

function MiasmaClearedPresentation( victim )
	thread( PlayVoiceLines, HeroVoiceLines.RecovedFromMiasmaVoiceLines, true )

	PlaySound({ Name = "/SFX/TimeSlowEnd", Id = victim.ObjectId })

	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {1,1,1,1}, Duration = 0.3 })

	if SessionMapState.TimeSlowActive then
		AdjustColorGrading({ Name = "MoonDust", Duration = 0.3 })
	else
		AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	end
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
	SetAnimation({ Name = "MiasmaVignetteEnd", DestinationId = ScreenAnchors.MiasmaVignette  })
	wait( 1.0 )
	Destroy({ Ids = { ScreenAnchors.MiasmaVignette, ScreenAnchors.MiasmaVignetteAnchor } })
	ScreenAnchors.MiasmaVignette = nil
	ScreenAnchors.MiasmaVignetteAnchor = nil
end
function StartLavaPresentation()
	if ScreenAnchors.LavaVignette then
		return
	end
	ScreenAnchors.LavaVignetteAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })
	ScreenAnchors.LavaVignette = SpawnObstacle({ Name = "BlankObstacle", DestinationId = ScreenAnchors.LavaVignetteAnchor, Group = "Combat_Menu_Additive" })
	SetAnimation({ Name = "LavaVignetteSpawner", DestinationId = ScreenAnchors.LavaVignette  })
	DrawScreenRelative({ Ids = { ScreenAnchors.LavaVignette } })
	AdjustColorGrading({ Name = "Team02", Duration = 0.5 })
end

function EndLavaPresentation()
	local clearDuration = 0.3
	AdjustColorGrading({ Name = "Off", Duration = clearDuration })
	SetAnimation({ Name = "LavaVignetteEnd", DestinationId = ScreenAnchors.LavaVignette  })
	wait(clearDuration)
	wait(0.5) -- additional 0.5s for flames to end
	Destroy({ Ids = { ScreenAnchors.LavaVignette, ScreenAnchors.LavaVignetteAnchor } })
	ScreenAnchors.LavaVignette = nil
	ScreenAnchors.LavaVignetteAnchor = nil
end

function StartBlockDeathPresentation( tollTimes )
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteFiredUpLASTCHANCE", Delay = 0.5 })
	thread( PlayerBlockDeathVoicelines, args )
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
function TickBlockDeathPresentation( remainingTolls )
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
	LoadVoiceBanks({ Name = "Moros" })
	SessionMapState.RemainingTolls = remainingTolls
	thread( PlayVoiceLines, GlobalVoiceLines.MorosCountdownVoiceLines )
	thread( HeroicStandPulse, remainingTolls - 1 )
end

function DoAssistPresentation( assistData )
	local currentRun = CurrentRun
	SetPlayerInvulnerable( "Super" )
	AddInputBlock({ Name = "AssistPreSummon" })

	PlaySound({ Name = assistData.ProcSound or "/Leftovers/SFX/AuraThrowLarge" })
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })

	
	thread( DoRumble, { { LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.4, LeftTriggerFrequencyFraction = 0.15, LeftTriggerTimeout = 0.3, }, } )

	thread( PlayVoiceLines, HeroVoiceLines.AssistActivatedVoiceLines, true )
	AdjustFullscreenBloom({ Name = "LastKillBloom", Duration = 0 })

	--local assistDimmer = CreateScreenComponent({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
	local assistDimmer = SpawnObstacle({ Name = "rectangle01", DestinationId = currentRun.Hero.ObjectId, Group = "Combat_UI" })
	Teleport({ Id = assistDimmer, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })
	DrawScreenRelative({ Ids = { assistDimmer } })
	SetScale({ Id = assistDimmer, Fraction = 10 })
	SetColor({ Id = assistDimmer, Color = {20, 20, 20, 255} })
	--SetAlpha({ Id = assistDimmer, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = assistDimmer, Fraction = 0.8, Duration = 0 })

	--RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Names = { "Standing" } })
	--AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "FX_Standing_Top", DrawGroup = true })

	--FocusCamera({ Fraction = 1.0, Duration = 0.6, ZoomType = "Ease" })
	--PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.6 })
	wait( 0.06 )
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	AddSimSpeedChange( "Assist", { Fraction = 0.005, LerpTime = 0 } )
	SetAnimation({ Name = "ZagreusSummon", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SuperStartFlare", DestinationId = CurrentRun.Hero.ObjectId, Color = assistData.AssistPresentationColor or Color.Red })
	--CreateAnimation({ Name = "SuperStartFlare", DestinationId = CurrentRun.Hero.ObjectId, Scale = 0.6 })

	waitUnmodified(  0.32 )

	local currentRun = CurrentRun
	HideCombatUI("AssistPresentationPortrait")

	--SetAnimation({ Name = "ZagreusLanding", DestinationId = currentRun.Hero.ObjectId })

	ApplyEffectFromWeapon({ Id = currentRun.Hero.ObjectId, DestinationId = currentRun.Hero.ObjectId, WeaponName = "ShoutSelfSlow", EffectName = "ShoutSelfSlow", AutoEquip = true })
	Rumble({ Fraction = 0.7, Duration = 0.3 })
	--AdjustZoom({Fraction = 0.9, LerpTime = 0.02})
	AdjustFullscreenBloom({ Name = "LightningStrike", Duration = 0 })
	AdjustFullscreenBloom({ Name = "WrathPhase2", Duration = 0.1, })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0 })
	AdjustRadialBlurDistance({ Fraction = 0.125, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.03, })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.03, })

	local wrathPresentationOffsetY = 100
	local wrathStreak = SpawnObstacle({ Name = "BlankObstacle", DestinationId = currentRun.Hero.ObjectId, Group = "Combat_UI" })
	Teleport({ Id = wrathStreak, OffsetX = (1920/2), OffsetY = 800 + wrathPresentationOffsetY })
	DrawScreenRelative({ Ids = { wrathStreak } })
	CreateAnimation({ Name = "WrathPresentationStreak", DestinationId = wrathStreak, Color = assistData.AssistPresentationColor or Color.Red })

	local portraitOffsetXBuffer = assistData.AssistPresentationPortraitOffsetX or 0
	local portraitOffsetYBuffer = assistData.AssistPresentationPortraitOffsetY or 0

	local godImage = SpawnObstacle({ Name = "BlankObstacle", DestinationId = currentRun.Hero.ObjectId, Group = "Combat_Menu" })
	Teleport({ Id = godImage, OffsetX = -300 + portraitOffsetXBuffer, OffsetY = (1080/2) + 80 + wrathPresentationOffsetY + portraitOffsetYBuffer })
	DrawScreenRelative({ Ids = { godImage } })
	CreateAnimation({ Name = assistData.AssistPresentationPortrait, DestinationId = godImage, Scale = "1.0" })

	local godImage2 = SpawnObstacle({ Name = "BlankObstacle", DestinationId = currentRun.Hero.ObjectId, Group = "Combat_UI" })
	Teleport({ Id = godImage2, OffsetX = 60, OffsetY = (1080/2) + 90 + wrathPresentationOffsetY })
	DrawScreenRelative({ Ids = { godImage2 } })
	if assistData.AssistPresentationPortrait2 then
		CreateAnimation({ Name = assistData.AssistPresentationPortrait2, DestinationId = godImage2, Scale = "1.0" })
	end

	local wrathStreakFront = SpawnObstacle({ Name = "BlankObstacle", DestinationId = currentRun.Hero.ObjectId, Group = "Combat_Menu_Overlay" })
	Teleport({ Id = wrathStreakFront, OffsetX = 900, OffsetY = 1150 + wrathPresentationOffsetY })
	DrawScreenRelative({ Ids = { wrathStreakFront } })
	CreateAnimation({ Name = "WrathPresentationBottomDivider", DestinationId = wrathStreakFront, Scale = "1.25", Color = assistData.AssistPresentationColor or Color.Red })

	local wrathVignette = SpawnObstacle({ Name = "BlankObstacle", DestinationId = currentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	Teleport({ Id = wrathVignette, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })
	DrawScreenRelative({ Ids = { wrathVignette } })
	CreateAnimation({ Name = "WrathVignette", DestinationId = wrathVignette, Color = Color.Red })

	-- audio
	local dummyGodSource = {}
	--thread( PlayVoiceLines, LootData[traitData.God .. "Upgrade"].ShoutVoiceLines, false, dummyGodSource )
	--PlaySound({ Name = LootData[traitData.God .. "Upgrade"].ShoutActivationSound or "/Leftovers/SFX/MeteorStrikeShort" })
	-- AudioState.ShoutEffectSoundId = PlaySound({ Name = "/SFX/WrathStart", Id = CurrentRun.Hero.ObjectId })

	AddSimSpeedChange( "Assist", { Fraction = 0.1, LerpTime = 0.06 } )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 3, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "HeroTeam" } })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	Move({ Id = godImage, Angle = 8, Distance = 800, Duration = 0.2, EaseIn = 0.2, EaseOut = 1, TimeModifierFraction = 0 })

		Move({ Id = godImage2, Angle = 8, Distance = 800, Duration = 0.2, EaseIn = 0.2, EaseOut = 1, TimeModifierFraction = 0 })

	Move({ Id = wrathStreakFront, Angle = 8, Distance = 200, Duration = 0.5, EaseIn = 0.9, EaseOut = 1, TimeModifierFraction = 0 })
	Move({ Id = playerImage, Angle = 170, Speed = 50, TimeModifierFraction = 0 })

	--SetColor({ Id = godImage, Color = {0, 0, 0, 1}, Duration = 0.05, TimeModifierFraction = 0 })
	SetColor({ Id = wrathVignette, Color = {0, 0, 0, 0.4}, Duration = 0.05, TimeModifierFraction = 0 })

	waitUnmodified(  0.25 )
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSurpriseSFX" })

	AdjustFullscreenBloom({ Name = "Off", Duration = 0.1, })
	Move({ Id = godImage, Angle = 8, Distance = 100, Duration = 1, EaseIn = 0.5, EaseOut = 0.5, TimeModifierFraction = 0 })

		Move({ Id = godImage2, Angle = 8, Distance = 100, Duration = 1, EaseIn = 0.5, EaseOut = 0.5, TimeModifierFraction = 0 })

	Move({ Id = wrathStreakFront, Angle = 8, Distance = 25, Duration = 1, EaseIn = 0.5, EaseOut = 1, TimeModifierFraction = 0 })

	waitUnmodified(  0.55 )
	AdjustZoom({Fraction = currentRun.CurrentRoom.ZoomFraction or 0.9, LerpTime = 0.25})

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })

	RemoveInputBlock({ Name = "AssistPreSummon" })
	for k, enemy in pairs( ActiveEnemies ) do
		if enemy.AssistReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.AssistReactionVoiceLines, nil, enemy )
		end
	end

	thread( CrowdReactionPresentation, { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, Sound = "/SFX/TheseusCrowdCheer", ReactionChance = 0.05, Requirements = { RequiredRoom = "C_Boss01" }, Delay = 1, Shake = true, RadialBlur = true } )

	SetAlpha({ Id = godImage, Fraction = 0, Duration = 0.12, TimeModifierFraction = 0 })

		SetAlpha({ Id = godImage2, Fraction = 0, Duration = 0.12, TimeModifierFraction = 0 })

	SetAlpha({ Id = wrathVignette, Fraction = 0, Duration = 0.06 })
	SetColor({ Id = assistDimmer, Color = {0.0, 0, 0, 0}, Duration = 0.06 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.06 })
	--ModifyTextBox({ Id = defianceText, FadeTarget = 0.0, FadeDuration = 0.3, ColorTarget = {1, 0, 0, 1}, ColorDuration = 0.3 })

	waitUnmodified(  0.06 )
	--RemoveFromGroup({ Id = CurrentRun.Hero.ObjectId, Names = { "FX_Standing_Top" } })
	--AddToGroup({ Id = CurrentRun.Hero.ObjectId, Name = "Standing", DrawGroup = true })
end

function DoHadesAssistPresentation( assistData, enemyId )
	local currentRun = CurrentRun
	SetPlayerInvulnerable( "Super" )
	AddInputBlock({ Name = "AssistPreSummon" })

	PlaySound({ Name = assistData.ProcSound or "/Leftovers/SFX/AuraThrowLarge" })
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })

	AdjustFullscreenBloom({ Name = "LastKillBloom", Duration = 0 })

	local assistDimmer = SpawnObstacle({ Name = "rectangle01", DestinationId = enemyIdz, Group = "Combat_UI" })
	Teleport({ Id = assistDimmer, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })
	DrawScreenRelative({ Ids = { assistDimmer } })
	SetScale({ Id = assistDimmer, Fraction = 10 })
	SetColor({ Id = assistDimmer, Color = {20, 20, 20, 255} })
	SetAlpha({ Id = assistDimmer, Fraction = 0.8, Duration = 0 })

	wait( 0.06 )
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	AddSimSpeedChange( "Assist", { Fraction = 0.005, LerpTime = 0 } )

	waitUnmodified(  0.32 )

	local currentRun = CurrentRun
	HideCombatUI("AssistPresentationPortrait")

	Rumble({ RightFraction = 0.7, Duration = 0.3 })
	--AdjustZoom({Fraction = 0.9, LerpTime = 0.02})
	AdjustFullscreenBloom({ Name = "LightningStrike", Duration = 0 })
	AdjustFullscreenBloom({ Name = "WrathPhase2", Duration = 0.1, })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0 })
	AdjustRadialBlurDistance({ Fraction = 0.125, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.03, })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.03, })

	local wrathPresentationOffsetY = 100
	local wrathStreak = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_UI" })
	Teleport({ Id = wrathStreak, OffsetX = (1920/2), OffsetY = 800 + wrathPresentationOffsetY })
	DrawScreenRelative({ Ids = { wrathStreak } })
	CreateAnimation({ Name = "WrathPresentationStreak", DestinationId = wrathStreak, Color = assistData.AssistPresentationColor or Color.Red })

	local portraitOffsetXBuffer = assistData.AssistPresentationPortraitOffsetX or 0
	local portraitOffsetYBuffer = assistData.AssistPresentationPortraitOffsetY or 0

	local godImage = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu" })
	Teleport({ Id = godImage, OffsetX = -300 + portraitOffsetXBuffer, OffsetY = (1080/2) + 80 + wrathPresentationOffsetY + portraitOffsetYBuffer })
	DrawScreenRelative({ Ids = { godImage } })
	CreateAnimation({ Name = assistData.AssistPresentationPortrait, DestinationId = godImage, Scale = "1.0" })

	local godImage2 = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_UI" })
	Teleport({ Id = godImage2, OffsetX = 60, OffsetY = (1080/2) + 80 + wrathPresentationOffsetY })
	DrawScreenRelative({ Ids = { godImage2 } })
	if assistData.AssistPresentationPortrait2 then
		CreateAnimation({ Name = assistData.AssistPresentationPortrait2, DestinationId = godImage2, Scale = "1.0" })
	end

	local wrathStreakFront = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu_Overlay" })
	Teleport({ Id = wrathStreakFront, OffsetX = 900, OffsetY = 1150 + wrathPresentationOffsetY })
	DrawScreenRelative({ Ids = { wrathStreakFront } })
	CreateAnimation({ Name = "WrathPresentationBottomDivider", DestinationId = wrathStreakFront, Scale = "1.25", Color = assistData.AssistPresentationColor or Color.Red })

	local wrathVignette = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	CreateAnimation({ Name = "WrathVignette", DestinationId = wrathVignette, Color = Color.Red })

	-- audio
	local dummyGodSource = {}

	AddSimSpeedChange( "Assist", { Fraction = 0.1, LerpTime = 0.06 } )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 3, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "HeroTeam" } })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	Move({ Id = godImage, Angle = 8, Distance = 800, Duration = 0.2, EaseIn = 0.2, EaseOut = 1, TimeModifierFraction = 0 })

	Move({ Id = godImage2, Angle = 8, Distance = 800, Duration = 0.2, EaseIn = 0.2, EaseOut = 1, TimeModifierFraction = 0 })

	Move({ Id = wrathStreakFront, Angle = 8, Distance = 200, Duration = 0.5, EaseIn = 0.9, EaseOut = 1, TimeModifierFraction = 0 })
	Move({ Id = playerImage, Angle = 170, Speed = 50, TimeModifierFraction = 0 })

	--SetColor({ Id = godImage, Color = {0, 0, 0, 1}, Duration = 0.05, TimeModifierFraction = 0 })
	SetColor({ Id = wrathVignette, Color = {0, 0, 0, 0.4}, Duration = 0.05, TimeModifierFraction = 0 })

	waitUnmodified(  0.25 )
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSurpriseSFX" })

	AdjustFullscreenBloom({ Name = "Off", Duration = 0.1, })
	Move({ Id = godImage, Angle = 8, Distance = 100, Duration = 1, EaseIn = 0.5, EaseOut = 0.5, TimeModifierFraction = 0 })

		Move({ Id = godImage2, Angle = 8, Distance = 100, Duration = 1, EaseIn = 0.5, EaseOut = 0.5, TimeModifierFraction = 0 })

	Move({ Id = wrathStreakFront, Angle = 8, Distance = 25, Duration = 1, EaseIn = 0.5, EaseOut = 1, TimeModifierFraction = 0 })

	waitUnmodified(  0.55 )
	AdjustZoom({Fraction = currentRun.CurrentRoom.ZoomFraction or 0.9, LerpTime = 0.25})

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })

	RemoveInputBlock({ Name = "AssistPreSummon" })

	SetAlpha({ Id = godImage, Fraction = 0, Duration = 0.12, TimeModifierFraction = 0 })

	SetAlpha({ Id = godImage2, Fraction = 0, Duration = 0.12, TimeModifierFraction = 0 })

	SetAlpha({ Id = wrathVignette, Fraction = 0, Duration = 0.06 })
	SetColor({ Id = assistDimmer, Color = {0.0, 0, 0, 0}, Duration = 0.06 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.06 })

	waitUnmodified(  0.06 )
end

function AssistCompletePresentation( assistData )
	wait(1.35, RoomThreadName)
	local currentRun = CurrentRun
	thread( PlayVoiceLines, HeroVoiceLines.AssistCompletedVoiceLines, true )
end

function AssistFailedPresentation( attacker )
	if ( attacker.IsDead and CurrentHubRoom ~= nil and not CurrentHubRoom.AllowAssistFailedPresentation ) or not IsInputAllowed({}) then
		return
	end

	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "AssistNotAvailable", Duration = 0.75, Cooldown = 2.0 } )
	thread( PlayVoiceLines, HeroVoiceLines.AssistUnavailableVoiceLines )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo2", Id = attacker.ObjectId })
	CreateAnimation({ Name = "SuperNotChargedFlare", DestinationId = attacker.ObjectId, Scale = 0.5, OffsetZ = 160 })

	for k, enemy in pairs( ActiveEnemies ) do
		if enemy.AssistFailedReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.AssistFailedReactionVoiceLines, nil, enemy )
		end
	end

end

function DoAssistPresentationPostWeapon( assistData )
	AddSimSpeedChange( "Assist", { Fraction = 0.3, LerpTime = 0.3 } )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, ValueChangeType = "Absolute", DataValue = false, DestinationNames = { "HeroTeam" } })
	waitUnmodified(  assistData.AssistPostWeaponSlowDuration or 0 )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, ValueChangeType = "Absolute", DataValue = false, DestinationNames = { "HeroTeam" } })
	RemoveSimSpeedChange( "Assist", { LerpTime = 0.3 } )
	thread( CleanUpShoutPresentation, fullscreenAlertDisplacementFx)
	ShowCombatUI("AssistPresentationPortrait")
	thread( RevulnerablePlayerAfterShout )
end

function DoReactionPresentation( victim, reaction )

	if victim.BlockReactions then
		return
	end

	if reaction.ReactionSound ~= nil then
		PlaySound({ Name = reaction.ReactionSound, Id = victim.ObjectId })
	end

	if reaction.ShakeScreenSpeed then
		ShakeScreen({ Speed = reaction.ShakeScreenSpeed, Distance = reaction.ShakeScreenDistance, FalloffSpeed = reaction.ShakeScreenFalloffSpeed, Duration = reaction.ShakeScreenDuration, })
		wait(reaction.ShakeScreenDuration)
	end

	if reaction.Shake then
		Shake({ Id = victim.ObjectId, Speed = reaction.ShakeSpeed, Distance = reaction.ShakeDistance, Duration = reaction.ShakeDuration, ApplyToChildren = true })
	end

	if reaction.DisappearDuration ~= nil then
		victim.BlockReactions = true
		SetAlpha({ Id = victim.ObjectId, Fraction = 0.0, Duration = 0.0 })
		wait( reaction.DisappearDuration, RoomThreadName )
		if victim.ReappearSound ~= nil then
			PlaySound({ Name = victim.ReappearSound, Id = victim.ObjectId })
		end
		victim.BlockReactions = false
		local reappearDuration = 1.0
		SetAlpha({ Id = victim.ObjectId, Fraction = 1.0, Duration = reappearDuration })
		wait( reappearDuration, RoomThreadName )
	end

end

function RevulnerablePlayerAfterShout()
	waitUnmodified(  0.4 )
	SetPlayerVulnerable( "Super" )
end


function CleanUpShoutPresentation( fullscreenAlertDisplacementFx )
	waitUnmodified(  0.08 )
	Destroy({ Ids = { fullscreenAlertDisplacementFx } })
	StopSound({ Id = AudioState.ShoutEffectSoundId, Duration = 0.2 })
	AudioState.ShoutEffectSoundId = nil
	StopSound({ Id = AudioState.TheseusShoutEffectSoundId, Duration = 0.2 })
	AudioState.TheseusShoutEffectSoundId = nil
end

function ActivateFusePresentation( enemy )
	wait(0.05)
	if enemy.FuseAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.FuseAnimation })
	end
	if enemy.FlashOnFuse then
		Flash({ Id = enemy.ObjectId, Speed = 3, MinFraction = 0, MaxFraction = 0.5, Color = Color.Yellow, Duration = enemy.FuseDuration })
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

function DoWeaponFireRumble( weaponData, projectileData )

	if weaponData == nil then
		return
	end
	
	if projectileData and projectileData.FireRumbleParameters then
		DoRumble( projectileData.FireRumbleParameters )
	elseif weaponData.FireRumbleParameters then
		DoRumble( weaponData.FireRumbleParameters )
	end
end

function DoWeaponHitRumble( weaponData, args )
	if weaponData == nil then
		return
	end
	
	if weaponData.RumbleDistanceThreshold and ( not args.DistanceSquared or args.DistanceSquared == -1 or args.DistanceSquared > (weaponData.RumbleDistanceThreshold * weaponData.RumbleDistanceThreshold )) then
		return
	end
	
	if weaponData.HitRumbleParameters then
		DoRumble( weaponData.HitRumbleParameters )
	end
end

function DoWeaponChargeRumble( weaponData )
	if weaponData == nil then
		return
	end
	if weaponData.ChargeRumbleParameters then
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
		--waitUnmodified(  rumbleData.ScreenPreWait, RumbleThreadName )
		waitUnmodified(  rumbleData.ScreenPreWait )
		if rumbleData.Fraction then
			Rumble({ Fraction = rumbleData.Fraction, Duration = rumbleData.Duration,
			LeftTriggerStart = rumbleData.LeftTriggerStart, LeftTriggerEnd = rumbleData.LeftTriggerEnd, LeftTriggerStrengthFraction = rumbleData.LeftTriggerStrengthFraction, LeftTriggerFrequencyFraction = rumbleData.LeftTriggerFrequencyFraction, LeftTriggerTimeout = rumbleData.LeftTriggerTimeout,
			RightTriggerStart = rumbleData.RightTriggerStart, RightTriggerEnd = rumbleData.RightTriggerEnd, RightTriggerStrengthFraction = rumbleData.RightTriggerStrengthFraction, RightTriggerFrequencyFraction = rumbleData.RightTriggerFrequencyFraction, RightTriggerTimeout = rumbleData.RightTriggerTimeout})
		else
			Rumble({ LeftFraction = rumbleData.LeftFraction, RightFraction = rumbleData.RightFraction, Duration = rumbleData.Duration,
			LeftTriggerStart = rumbleData.LeftTriggerStart, LeftTriggerEnd = rumbleData.LeftTriggerEnd, LeftTriggerStrengthFraction = rumbleData.LeftTriggerStrengthFraction, LeftTriggerFrequencyFraction = rumbleData.LeftTriggerFrequencyFraction, LeftTriggerTimeout = rumbleData.LeftTriggerTimeout,
			RightTriggerStart = rumbleData.RightTriggerStart, RightTriggerEnd = rumbleData.RightTriggerEnd, RightTriggerStrengthFraction = rumbleData.RightTriggerStrengthFraction, RightTriggerFrequencyFraction = rumbleData.RightTriggerFrequencyFraction, RightTriggerTimeout = rumbleData.RightTriggerTimeout})
		end
	end
end

function DoWeaponFireRadialBlur( weaponData )

	if weaponData == nil then
		return
	end
	if weaponData.FireRadialBlur then
		DoWeaponRadialBlur( weaponData.FireRadialBlur )
	end
end

function OnHitShakePresentation( shakeArgs )
	Shake( shakeArgs )
	wait( shakeArgs.Duration )
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

	local damagedFx = GetDamagedFx( victim, sourceProjectileData )
	if damagedFx ~= nil then
		CreateAnimation({ DestinationId = victim.ObjectId, Name = damagedFx, Angle = angle, OffsetZ = triggerArgs.ImpactLocationZ, ManagerCap = 300, ManagerFrameCap = 14 })
	end

	if victim.OnDamagedVoiceLines ~= nil then
		thread( PlayVoiceLines, victim.OnDamagedVoiceLines, true )
	end

end

function GetDamagedFx( victim, sourceProjectileData )

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
	local angle = 0
	if triggerArgs.ImpactAngle ~= nil then
		angle = triggerArgs.ImpactAngle + 180
	end
	if victim.InvulnerableHitFx ~= nil then
		CreateAnimation({ DestinationId = victim.ObjectId, Name = victim.InvulnerableHitFx, Angle = angle, OffsetZ = triggerArgs.ImpactLocationZ, ManagerCap = 300, ManagerFrameCap = 14 })
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

end

function PerfectDashStartPresentation( triggerArgs )
	CreateAnimation({ Name = "PowerUpPerfectDash", DestinationId = CurrentRun.Hero.ObjectId })
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.5, MinFraction = 0.3, MaxFraction = 0, Color = Color.Turquoise, Duration = 0.5, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/PerfectTiming", Id = triggerArgs.triggeredById })
end

function PerfectDashEndPresentation( triggerArgs, text )
	local displayText = text or "PerfectDashActivated"
	if CheckCooldown( "PerfectDashActivated", 0.5 ) and displayText ~= nil then
		thread( InCombatTextArgs, { Text = displayText, TargetId = CurrentRun.Hero.ObjectId, Duration = 0.35, PreDelay = 0.21, FontScale = 20, SkipRise = true, OffsetY = -160, SkipShadow = true } )
	end
	wait( 0.1, RoomThreadName )
end

function EquipPlayerWeaponPresentation( weaponData, args )
	wait( 0.02 )
	if not args.SkipSound then
		PlaySound({ Name = "/SFX/Menu Sounds/WeaponEquipChunk", Id = CurrentRun.Hero.ObjectId })
	end
	thread( PlayVoiceLines, weaponData.EquipVoiceLines, false )
	if weaponData.ShowStaffUI then
		thread( ShowStaffUI )
	else
		thread( HideStaffUI, true )
	end
	thread(HideAxeUI, true )
	thread(HideDaggerUI, true )
	thread(HideTorchUI, true )
	if weaponData.ShowAmmoUI then
		thread( ShowAmmoUI )
	else
		thread( HideAmmoUI )
	end
end

function EquipPlayerToolPresentation( toolKit )
	wait( 0.02 )
	-- PlaySound({ Name = "/SFX/Player Sounds/ToolEquip", Id = toolKit.ObjectId })
	thread( PlayVoiceLines, toolKit.EquipVoiceLines, false )

	-- CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })
	-- AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = toolKit.ObjectId })
	-- SetAnimation({ Name = "MelinoeSpellFire", DestinationId = CurrentRun.Hero.ObjectId })

	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract", Id = CurrentRun.Hero.ObjectId })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.2 }, } )

	Shake({ Id = toolKit.ObjectId, Distance = 2, Speed = 100, Duration = 0.3, FalloffSpeed = 3000 })

	SetAnimation({ Name = toolKit.Icon, DestinationId = HUDScreen.Components.ToolIcon.Id })
	SetScale({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 2.5, Duration = 0.06 })
	Flash({ Id = HUDScreen.Components.ToolIcon.Id, Speed = 1.5, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.Gold, ExpireAfterCycle = true })

	SetAlpha({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 1.0, Duration = HUDScreen.FadeInDuration })

	waitUnmodified( 0.02 )

	SetScale({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 1.0, Duration = 0.35, SmoothStep = true })
end

function HighlightPlayerToolPresentation( toolKit )

	SetScale({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 2.5, Duration = 0.06 })
	Flash({ Id = HUDScreen.Components.ToolIcon.Id, Speed = 1.5, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.Gold, ExpireAfterCycle = true })

	SetAlpha({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 1.0, Duration = HUDScreen.FadeInDuration })

	waitUnmodified( 0.02 )
	PlaySound({ Name = "/Leftovers/SFX/SprintChargeUp", Id = HUDScreen.Components.ToolIcon.Id })

	SetScale({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 1.0, Duration = 0.35, SmoothStep = true })

	wait(0.5)

	SetScale({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 2.5, Duration = 0.06 })
	Flash({ Id = HUDScreen.Components.ToolIcon.Id, Speed = 1.5, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.Gold, ExpireAfterCycle = true })

	SetAlpha({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 1.0, Duration = HUDScreen.FadeInDuration })

	waitUnmodified( 0.02 )
	PlaySound({ Name = "/Leftovers/SFX/SprintChargeUp", Id = HUDScreen.Components.ToolIcon.Id })

	SetScale({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 1.0, Duration = 0.35, SmoothStep = true })

	wait(0.5)

	SetScale({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 2.5, Duration = 0.06 })
	Flash({ Id = HUDScreen.Components.ToolIcon.Id, Speed = 1.5, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.Gold, ExpireAfterCycle = true })

	SetAlpha({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 1.0, Duration = HUDScreen.FadeInDuration })

	waitUnmodified( 0.02 )
	PlaySound({ Name = "/Leftovers/SFX/SprintChargeUp", Id = HUDScreen.Components.ToolIcon.Id })

	SetScale({ Id = HUDScreen.Components.ToolIcon.Id, Fraction = 1.0, Duration = 0.35, SmoothStep = true })

end

function UnitActivatePresentation( unit, args )

	SetThingProperty({ Property = "StopsProjectiles", Value = false, DestinationId = unit.ObjectId })

	if unit.DoActivateFxAtNearestTypeId ~= nil then
		unit.ActivateFxDestination = GetClosest({ Id = unit.ObjectId, DestinationIds = GetIdsByType({ Name = unit.DoActivateFxAtNearestTypeId }) })
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
	if unit.ActivateSwoopPresentation then
		local previousSpot = SpawnObstacle({ Name = "BlankObstacle", DestinationId = unit.ObjectId })
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
		Teleport({ Id = unit.ObjectId, OffsetX = randomOffsetX, OffsetY = randomOffsetY, UseCurrentLocation = true })
		--wait( 0.02 )
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = "Speed", Value = 800 })
		Move({ Id = unit.ObjectId, DestinationId = previousSpot, SuccessDistance = 32 })
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
		wait( unit.ActivateDuration or 0.3, "Activating"..unit.ObjectId )
	end

	if unit.ActivateGravity ~= nil then
		SetThingProperty({ DestinationId = unit.ObjectId, Property = "Gravity", Value = originalGravity })
	end

	if unit.ActivateSwoopPresentation ~= nil then
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = "Speed", Value = originalSpeed })
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = "CollideWithUnits", Value = true })
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = "CollideWithObstacles", Value = true })
	end

	if unit.ActivateMoveToSpawnPoint then
		if unit.ActivateMoveInvulnerable then
			SetInvulnerable({ Id = unit.ObjectId })
		end

		local nearbySpawnPoint = SelectSpawnPoint(CurrentRun.CurrentRoom, unit, { SpawnNearId = unit.ObjectId, SpawnRadius = unit.OnActivateMoveRadius or 400  })
		Move({ Id = unit.ObjectId, DestinationId = nearbySpawnPoint, SuccessDistance = 32 })

		if unit.ActivateWaitForMove then
			local moveNotify = "ActivateMoveToSpawnPoint"..unit.ObjectId
			NotifyWithinDistance({ Id = unit.ObjectId, DestinationId = nearbySpawnPoint, Distance = 40, Notify = moveNotify, Timeout = unit.OnActivateMoveTimeout or 1.5 })
			waitUntil( moveNotify )
		end

		if unit.ActivateMoveInvulnerable then
			SetVulnerable({ Id = unit.ObjectId })
		end
	end

	if unit.PostActivateAnimation ~= nil then
		SetAnimation({ DestinationId = unit.ObjectId, Name = unit.PostActivateAnimation })
	end

	if unit.PostActivateDuration ~= nil then
		wait ( unit.PostActivateDuration )
	end

	if unit.PostActivateStop then
		Stop({ Id = unit.ObjectId })
	end

	SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationId = unit.ObjectId })
end

function PreSpawnFx( unit )
	if unit.ActivateFxPreSpawn ~= nil then
		wait( unit.ActivateFxPreSpawnDelay )
		CreateAnimation({ Name = unit.ActivateFxPreSpawn, DestinationId = unit.ObjectId })
		if unit.ActivateFxPreSound ~= nil then
			PlaySound({ Name = unit.ActivateFxPreSound, Id = unit.ObjectId })
		end
	end
end

function FadeUnitActivation( unit )
	wait( unit.ActivateFadeInDelay or 0 )
	SetAlpha({ Id = unit.ObjectId, Fraction = 0 })
	SetAlpha({ Id = unit.ObjectId, Fraction = 1.0, Duration = unit.ActivateFadeInDuration or 2.0 })
end

function TintUnitActivation( unit )
	wait( unit.ActivateTintDelay or 0 )
	SetColor({ Id = unit.ObjectId, Color = {0, 0, 0, 1} })
	SetColor({ Id = unit.ObjectId, Color = {1, 1, 1, 1}, Duration = unit.ActivateTintDuration or 2.0 })
end

function UnusedWeaponBonusPresentation()
	CreateAnimation({ Name = "BonesSparkleBurst", DestinationId = CurrentRun.Hero.ObjectId })
	
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/StickInteract", Id = HUDScreen.Components.InventoryIcon.Id })
end

PolymorphPresentationData =
{
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
		Default = "Enemy_Sheep_OnHit",
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

function PolymorphApplyPresentation( triggerArgs, args )
	local victim = triggerArgs.Victim

	if args ~= nil and args.BossPolymorph then
		thread( PolymorphSimSlow )
	end
	thread( InCombatTextArgs, { TargetId = victim.ObjectId, Text = "Polymorphed", Duration = 1.5, ShadowScaleX = 0.6, PreDelay = 0.1, Duration = 1.5, OffsetY = -20 } )
	
	victim.SpeechParams = victim.SpeechParams or {}
	victim.SpeechParams.Chipmunk = 1
	if victim == CurrentRun.Hero then
		SetAudioEffectState({ Name = "Chipmunk", Value = 0.5 })
	end

	EndRamWeapons({ Id = victim.ObjectId })
	if not triggerArgs.Reapplied then
		for k, soundName in ipairs( PolymorphPresentationData.ApplyPlaySounds ) do
			PlaySound({ Name = soundName, Id = triggerArgs.triggeredById })
		end
		for k, animName in ipairs( PolymorphPresentationData.ApplyCreateAnimations ) do
			CreateAnimation({ Name = animName, DestinationId =  triggerArgs.triggeredById })
		end

		if PolymorphPresentationData.DisableAnimFreeze then
			SetThingProperty({ Property = "AnimFreeze", Value = false, DestinationId = victim.ObjectId, DataValue = false })
		end

		local anim = nil
		for i, propertyChange in ipairs( PolymorphPresentationData.ThingProperties ) do
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
				SetThingProperty({ Property = key, Value = value, DestinationId = victim.ObjectId })
			end
		end
		if victim.Weapons then
			for key, value in pairs( PolymorphPresentationData.WeaponProperties ) do
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
				local newValue = PolymorphPresentationData.StunAnimations[key]
				if newValue then
					victim["PrePolymorphStunAnimation"..key] = value
				end
				victim.StunAnimations[key] = newValue
			end
		end
		if anim ~= nil then
			SetAnimation({ Name = anim, DestinationId = victim.ObjectId })
		end

		for key, value in pairs( PolymorphPresentationData.UnitProperties ) do
			victim["PrePolymorph"..key] = GetUnitDataValue({ Property = key, Id = victim.ObjectId })
			if value == "nil" then
				value = nil
			end
			SetUnitProperty({ Property = key, Value = value, DestinationId = victim.ObjectId })
		end

		for key, value in pairs( PolymorphPresentationData.LifeProperties ) do
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
	end
	thread( PlayVoiceLines, GlobalVoiceLines.SpellPolymorphReactionVoiceLines )

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
	
	victim.SpeechParams = victim.SpeechParams or {}
	victim.SpeechParams.Chipmunk = nil
	if victim == CurrentRun.Hero then
		SetAudioEffectState({ Name = "Chipmunk", Value = GetTotalHeroTraitValue("BaseChipmunkValue") })
	end

	for k, soundName in ipairs( PolymorphPresentationData.ClearPlaySounds ) do
		PlaySound({ Name = soundName, Id = victim.ObjectId })
	end
	for k, animName in ipairs( PolymorphPresentationData.ClearCreateAnimations ) do
		CreateAnimation({ Name = animName, DestinationId =  victim.ObjectId })
	end

	if PolymorphPresentationData.DisableAnimFreeze then
		SetThingProperty({ Property = "AnimFreeze", Value = false, DestinationId = victim.ObjectId, DataValue = false })
	end

	for i, propertyChange in ipairs( PolymorphPresentationData.ThingProperties ) do
		for key, value in pairs( propertyChange ) do
			SetThingProperty({ Property = key, Value = victim["PrePolymorph"..key], DestinationId = victim.ObjectId })
		end
	end
	if victim.PrePolymorphGraphic ~= nil then
		SetAnimation({ Name = victim.PrePolymorphGraphic, DestinationId = victim.ObjectId })
	end
	if victim.StunAnimations then 
		for key, value in pairs( PolymorphPresentationData.StunAnimations ) do
			victim.StunAnimations[key] = victim["PrePolymorphStunAnimation"..key]
		end
	end
	if victim.Weapons then
		for weaponName in pairs( victim.Weapons ) do
			for key, value in pairs( PolymorphPresentationData.WeaponProperties ) do
				SetWeaponProperty({ WeaponName = weaponName, Property = key, Value = victim["PrePolymorph"..weaponName..key], DestinationId = victim.ObjectId })
			end
		end
	end
	for key, value in pairs( PolymorphPresentationData.UnitProperties ) do
		SetUnitProperty({ Property = key, Value = victim["PrePolymorph"..key], DestinationId = victim.ObjectId })
	end
	for key, value in pairs( PolymorphPresentationData.LifeProperties ) do
		local dataValue = true
		if key == "InvulnerableCoverage" then
			dataValue = false
		end
		SetLifeProperty({ Property = key, Value = victim["PrePolymorph"..key], DestinationId = victim.ObjectId, DataValue = dataValue })
	end

	if args ~= nil and args.BossPolymorph and CurrentRun.CurrentRoom.ZoomFraction then
		AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.0, Duration = 999999 })
	end

end

function PolyphemusPlayerGrabApplyPresentation( triggerArgs, args )
	local victim = triggerArgs.Victim

	if args ~= nil and args.BossPolymorph then
		thread( PolymorphSimSlow )
	end
	thread( InCombatTextArgs, { TargetId = victim.ObjectId, Text = "PolyphemuGrabPlayerSuccess", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, Duration = 1.0, OffsetY = 80 } )
	thread( PolyphemusGrabOngoingPresentation )
	if not triggerArgs.Reapplied then
		AddInputBlock({ Name = "PolyphemusPlayerGrab" })
		--SetAlpha({ Id = victim.ObjectId, Fraction = 0, Duration = 0 })
		--AdjustZoom({ Fraction = 1.05, LerpTime = 0.1, Duration = 99999 })
	end
end

function PolyphemusGrabOngoingPresentation( )
	local fireTicks = 7
	local zoomPulse = CurrentRun.CurrentRoom.ZoomFraction
	while fireTicks > 0 do
		zoomPulse = zoomPulse + 0.015
		ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.2 })
		fireTicks = fireTicks - 1
		FocusCamera({ Fraction = zoomPulse, Duration = 0.3, ZoomType = "Overshoot" })
		wait( 0.5 )
	end
end

function PolyphemusPlayerGrabClearPresentation( triggerArgs, args )
	local victim = triggerArgs.Victim
	wait( 1.17 )
	ClearPlayerFade( "PolyphemusGrab", 0.06 )
	SetAnimation({ Name = "MelinoeGetHit", DestinationId = CurrentRun.Hero.ObjectId })
	--ApplyUpwardForce({ Id = CurrentRun.Hero.ObjectId, Speed = 1200 })
	ApplyForce({ Id = CurrentRun.Hero.ObjectId, Speed = 1100, Angle = 0 })
	AdjustColorGrading({ Name = "Off", Duration = 0.8 })
	--SetAlpha({ Id = victim.ObjectId, Fraction = 1, Duration = 0 })
	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.0, Duration = 999999 })
	wait( 0.3 )
	RemoveInputBlock({ Name = "PolyphemusPlayerGrab" })
end

function PolyphemusInterruptWeaponPresentation( enemy, aiData )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "PolyphemusRetaliate", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, Duration = 1.5, OffsetY = 80 } )
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/EmoteAlerted", Id = enemy.ObjectId, Delay = 0.2 })
end

function HeroRootApplyPresentation( triggerArgs )
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteStunned", Id = triggerArgs.triggeredById, Delay = 0.1 })
end

function HeroRootClearPresentation( triggerArgs )
end

function HecateBattleStart( hecate, args )

	-- wait(0.3)

	SetAnimation({ DestinationId = hecate.ObjectId, Name = "HecateHubOutfitBattleIntro" })
	CreateAnimation({ DestinationId = hecate.ObjectId, Name = "HecateTransformFlameDark", Group = "FX_Dark" })
	CreateAnimation({ DestinationId = hecate.ObjectId, Name = "HecateTransformFlame", Group = "FX_Standing_Add" })

	local notifyName = "HecateBattleStartAnimation"
	NotifyOnAnimationTimeRemaining({ Id = hecate.ObjectId, Animation = "HecateHubOutfitBattleIntro", Remaining = 0.01, Notify = notifyName, Timeout = 9.0 })
	waitUntil( notifyName )

	SetThingProperty({ Property = "GrannyModel", Value = "HecateBattle_Mesh", DestinationId = hecate.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "HecateTorchIdle", DestinationId = hecate.ObjectId })
	SetAnimation({ DestinationId = hecate.ObjectId, Name = "HecateBattleOutfitBattleIntro" })

	hecate.WeaponName = "HecateBattleIntro"
	local aiData = ShallowCopyTable(hecate.DefaultAIData) or hecate
	if WeaponData[hecate.WeaponName] ~= nil and WeaponData[hecate.WeaponName].AIData ~= nil then
		OverwriteTableKeys( aiData, WeaponData[hecate.WeaponName].AIData)
	end
	aiData.WeaponName = hecate.WeaponName
	DoAttack( hecate, aiData )
end

function ChronosBattleStart( chronos, args )

	for id, enemy in pairs(ActiveEnemies) do
		if enemy ~= chronos then
			AddToGroup({ Id = id, Name = "Spawner"..chronos.ObjectId })
			thread(SetupAI, enemy )
		end
	end
end

function HecateKillPresentation( unit, args )

	AddInputBlock({ Name = "HecateKillPresentation" })

	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	local deathPanSettings = args
	ClearEffect({ Ids = { victimId, killerId }, All = true, BlockAll = true, })
	if unit.Frozen then
		UnfrozenPresentation( unit, { SkipPresentation = true })
	end
	SetUnitInvulnerable( unit )

	if unit.DeathFx ~= nil then
		CreateAnimation({ Name = unit.DeathFx, DestinationId = unit.ObjectId, Angle = args.ImpactAngle })
		unit.DeathFx = nil
	end
	if unit.DeathSound ~= nil then
		PlaySound({ Name = unit.DeathSound, Id = unit.ObjectId })
		unit.DeathSound = nil
	end
	if unit.LastHitAnimation ~= nil then
		SetAnimation({ Name = unit.LastHitAnimation, DestinationId = unit.ObjectId })
	end
	if unit.BossKillVoiceLines ~= nil then
		thread( PlayVoiceLines, unit.BossKillVoiceLines, false, unit )
	end

	CancelWeaponFireRequests({ Id = unit.ObjectId })
	BlockProjectileSpawns({ ExcludeProjectileName = "SpearWeaponThrow" })
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	StopAnimation({ Names = { "HecateTorchFlameLeft", "HecateTorchFlameRight", "Invincibubble_Hecate", }, DestinationId = unit.ObjectId })

	SetPlayerInvulnerable( "HecateKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	if args.AddInterBiomeTimerBlock then
		AddTimerBlock( CurrentRun, "InterBiome" )
	end
	AddTimerBlock( CurrentRun, "HecateKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	SetVulnerable({ Id = victimId })
	ClearCameraClamp({ LerpTime = 0 })
	local cameraPanTime = 1.5
	if deathPanSettings.StartPanTime then
		cameraPanTime = deathPanSettings.StartPanTime
	end
	local sceneOffsetY = -85
	PanCamera({ Id = victimId, Duration = 0.64, OffsetY = sceneOffsetY })
	FocusCamera({ Fraction = 1.1, Duration = 0.64 })
	ZeroMouseTether("HecateKillPresentation")	
	CancelWeaponFireRequests({ Id = killerId })
	ToggleCombatControl( CombatControlsDefaults, false, "BossKill" )
	HideCombatUI("BossKill")

	PlaySound({ Name = "/SFX/Enemy Sounds/Hecate/HecateDefeated" })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	end

	if deathPanSettings.StartSound then
		PlaySound({ Name = deathPanSettings.StartSound })
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteShocked" })
	end
	EndMusic()

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.12, DataValue = false, DestinationId = killerId })
	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = victimId })
	--thread( VictimDeathHold, victimId, 0.02, 0.3 )
	if deathPanSettings.FlashRed then
		--Flash({ Id = victimId, Speed = 0.01, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = 0.5, ExpireAfterCycle = true })
	end

	RemoveFromGroup({ Id = killerId, Names = { "Standing" } })
	AddToGroup({ Id = killerId, Name = "Combat_Menu", DrawGroup = true })
	RemoveFromGroup({ Id = victimId, Name = "Standing" })
	AddToGroup({ Id = victimId, Name = "Combat_Menu", DrawGroup = true })

	if deathPanSettings.EndAngle then
	--	SetGoalAngle({ Id = victimId, Angle = deathPanSettings.EndAngle })
	end

	-- black out world
	AdjustFrame({ Color = Color.TransparentRed, Duration = 0.0, Fraction = 0 })
	ScreenAnchors.DeathBackground = ScreenAnchors.DeathBackground or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = ScreenAnchors.DeathBackground, Fraction = 10 })
	SetColor({ Id = ScreenAnchors.DeathBackground, Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 1.0, Duration = 0 })

	thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.17, Duration = 0.65 }, { ScreenPreWait = 2.8, LeftFraction = 0.3, Duration = 0.6 } } )

	Flash({ Id = victimId, Speed = 0.02, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = 1.55, ExpireAfterCycle = true })

	wait( 1.5 )
	SetAlpha({ Id = killerId, Fraction = 0, Duration = 0.3 })
	ClearEffect({ Id = killerId, Name = "KillDamageBonus" })

	local bossDeathFlash = CreateScreenComponent({ Name = "BlankObstacle", Group = "Overlay", X = ScreenCenterX, Y = ScreenCenterY - sceneOffsetY })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathStartFwoosh", Id = bossDeathFlash.Id })
	SetAnimation({ DestinationId = bossDeathFlash.Id, Name = "MelDeathFlash" })
	SetGoalAngle({ Id = victimId, Angle = 270, CompleteAngle = true })

	for i=1, 16 do
		CreateAnimation({ Name = "MelDeathLine", DestinationId = ScreenAnchors.DeathBackground, Group = "Combat_Menu_TraitTray_Overlay_Additive", OffsetY = sceneOffsetY })
	end

	if unit.DeathAnimation ~= nil then
		SetAnimation({ Name = unit.DeathAnimation, DestinationId = unit.ObjectId })
		unit.DeathAnimation = nil
	end

	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTransformFlameDark", Group = "Combat_UI_World_Add", Scale = 1.2, OffsetY = sceneOffsetY  })
  	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTransformFlame", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.2, OffsetY = sceneOffsetY })

	-- wait( 1.5 )

	local textMessage = deathPanSettings.Message
	if deathPanSettings.BossDifficultyMessage and GetNumShrineUpgrades( "BossDifficultyShrineUpgrade" ) > 0 then
		textMessage = deathPanSettings.BossDifficultyMessage
	end

	thread( DisplayInfoBanner, nil, { Text = "HecateMessage", Delay = 0.75, TextColor = Color.Turquoise, Layer = "Overlay", FontScale = 1, AnimationName = "LocationBackingIrisDeathIn", AnimationOutName = "LocationBackingIrisDeathOut", Duration = 3.75 } )


	if deathPanSettings.BatsAfterDeath then
		thread( SendCritters, { MinCount = 80, MaxCount = 90, StartX = 0, StartY = 300, MinAngle = 75, MaxAngle = 115, MinSpeed = 400, MaxSpeed = 2000, MinInterval = 0.03, MaxInterval = 0.1, GroupName = "CrazyDeathBats" } )
	end

	local notifyName = "HecateBattleEndAnimation"
	NotifyOnAnimationTimeRemaining({ Id = unit.ObjectId, Animation = "HecateBattleOutfitBattleOutro", Remaining = 0.01, Notify = notifyName, Timeout = 9.0 })
	waitUntil( notifyName )

	SetThingProperty({ Property = "GrannyModel", Value = "HecateHub_Mesh", DestinationId = unit.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "HecateHubTorchBattleIdle", DestinationId = unit.ObjectId })
	SetAnimation({ DestinationId = unit.ObjectId, Name = "HecateHubOutfitBattleOutro" })

	if deathPanSettings.EndPanTime then
		wait( deathPanSettings.EndPanTime )
	else
		wait( 3.15 )
	end

	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0.0, Duration = 0.3 })

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationId = killerId })
	SetAlpha({ Id = killerId, Fraction = 1.00, Duration = 0.3 })
	RemoveFromGroup({ Id = killerId, Names = { "Combat_Menu" } })
	AddToGroup({ Id = killerId, Name = "Standing", DrawGroup = true })

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 3.0, EaseOut = 0.5, OffsetY = -120 })
	local defaultZoom = 1.0
	if CurrentHubRoom ~= nil then
		defaultZoom = CurrentHubRoom.ZoomFraction or defaultZoom
	else
		defaultZoom = CurrentRun.CurrentRoom.ZoomFraction or defaultZoom
	end
	FocusCamera({ Fraction = defaultZoom, Duration = 3.0, ZoomType = "Ease" })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	-- Exit Narrative Events --

	--[[SetAnimation({ DestinationId = unit.ObjectId, Name = GetThingDataValue({ Id = unit.ObjectId, Property = "Graphic" }) })
	LockCamera({ Id = unit.ObjectId, Duration = 1.25 })
	Move({ Id = unit.ObjectId, DestinationId = 510277, SuccessDistance = 50 })
	local notifyName = "WithinDistance"..unit.ObjectId
	NotifyWithinDistance({ Id = unit.ObjectId, DestinationId = 510277, Distance = 50, Notify = notifyName, Timeout = 9.0, })
	waitUntil( notifyName, unit.AIThreadName )]]

	thread( PlayVoiceLines, unit.PostMatchTauntVoiceLines, true, unit )

	Stop({ Id = unit.ObjectId })
	-- AngleTowardTarget({ Id = unit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	EndMusic( AudioState.MusicId, AudioState.MusicName )
	RemoveEnemyUI( unit )

	if GameState.TextLinesRecord.HecateFirstExit then
		wait( 0.5, RoomThreadName )
	--else
	--	wait( 2.0, RoomThreadName )
	end

	local textLines = GetRandomEligibleTextLines( unit, unit.BossOutroTextLineSets, GetNarrativeDataValue( unit, "BossOutroTextLinePriorities" ) )
	PlayTextLines( unit, textLines )

	wait( 0.3, RoomThreadName )

	thread( PlayVoiceLines, GlobalVoiceLines.HecateReturnVoiceLines, true, unit )
	thread( PlayVoiceLines, HeroVoiceLines.HecateDefeatedVoiceLines )

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })

	local hecateTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = unit.ObjectId, OffsetY = 30, OffsetX = -5 })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic" })
	CreateAnimation({ Name = "DeathSequenceFxBack", DestinationId = hecateTarget, Group = "Combat_UI_World_Add" })
	CreateAnimation({ Name = "DeathSequenceFxFront", DestinationId = hecateTarget, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	--ShakeScreen({ Angle = 90, Distance = 6, Speed = 300, FalloffSpeed = 300, Duration = 0.5 })

	SetUnitProperty({ DestinationId = unit.ObjectId, Property = "CollideWithUnits", Value = false })
	SetUnitProperty({ DestinationId = unit.ObjectId, Property = "CollideWithObstacles", Value = false })
	
	wait( 1.25, RoomThreadName )

	SetAlpha({ Id = unit.ObjectId, Fraction = 0.0, Duration = 0.2 })

	-- ---- ---- ---- --
	SetAnimation({ DestinationId = killerId, Name = "MelinoeEquip" })
	RemoveInputBlock({ Name = "HecateKillPresentation" })
	RemoveTimerBlock( CurrentRun, "HecateKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "HecateKillPresentation" )
	ShowCombatUI("BossKill")
	ClearEffect({ Ids = { killerId }, All = true })
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	ToggleCombatControl( CombatControlsDefaults, true, "BossKill" )
	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
end

function InfestedCerberusKillPresentation( unit, args )
	if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.StartTime then
		CurrentRun.CurrentRoom.Encounter.ClearTime = _worldTime - CurrentRun.CurrentRoom.Encounter.StartTime
	end

	local allBossesDead = true
	if CurrentRun.CurrentRoom.Encounter.HoldKillPresentationForUnitDeaths ~= nil then
		for k, unitName in pairs(CurrentRun.CurrentRoom.Encounter.HoldKillPresentationForUnitDeaths) do
			if unitName ~= unit.Name then
				local unitId = GetClosestUnitOfType({ Id = unit.ObjectId, DestinationName = unitName })
				if ActiveEnemies[unitId] ~= nil then
					allBossesDead = false
				end
			end
		end
	end

	if not allBossesDead then
		LastKillPresentation( unit )
		return
	end
	
	ClearGameplayElapsedTimeMultipliers()
	ClearSimSpeedChanges()
	AddInputBlock({ Name = "GenericBossKillPresentation" })

	thread( InfestedCerberusHorribleRaceConditionForTempPresentation, unit, args )
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	local deathPanSettings = args

	if deathPanSettings.FlashRed then
		local duration = deathPanSettings.FlashDuration or 0.5
		Flash({ Id = victimId, Speed = 0.01, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = duration, ExpireAfterCycle = true })
	end

	ClearEffect({ Ids = { victimId, killerId }, All = true, BlockAll = true, })
	if unit.Frozen then
		UnfrozenPresentation( unit, { SkipPresentation = true })
	end
	--SetUnitInvulnerable( unit )

	if unit.DeathFx ~= nil then
		CreateAnimation({ Name = unit.DeathFx, DestinationId = unit.ObjectId, Angle = args.ImpactAngle })
		unit.DeathFx = nil
	end
	if unit.DeathAngle ~= nil then
		Halt({ Id = victimId })
		Stop({ Id = victimId })
		SetGoalAngle({ Id = victimId, Angle = unit.DeathAngle, CompleteAngle = true })
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

	PlaySound({ Name = "/SFX/StabSplatterEndSequence" })

	CancelWeaponFireRequests({ Id = unit.ObjectId })
	BlockProjectileSpawns({ ExcludeProjectileName = "SpearWeaponThrow" })
	--ExpireProjectiles({ Names = { "DionysusLobProjectile", "LightRangedWeapon", "DusaFreezeShotNonHoming", "HarpyBeam", "HydraLavaSpit", "HarpyWhipShot", "HarpyWhipShotRage", "TheseusSpearThrow", "ShieldThrow" }, BlockSpawns = true })
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })

	for id, name in pairs(MapState.Reticles) do
		Destroy({ Id = id })
	end
	MapState.Reticles = {}

	SetPlayerInvulnerable( "GenericBossKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	if args.AddInterBiomeTimerBlock then
		AddTimerBlock( CurrentRun, "InterBiome" )
	end
	AddTimerBlock( CurrentRun, "GenericBossKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	SetVulnerable({ Id = victimId })
	ClearCameraClamp({ LerpTime = 0 })
	local cameraPanTime = 1.5
	if deathPanSettings.StartPanTime then
		cameraPanTime = deathPanSettings.StartPanTime
	end
	local offsetY = unit.DeathPanOffsetY or 0
	PanCamera({ Id = victimId, Duration = cameraPanTime, OffsetY = offsetY })
	FocusCamera({ Fraction = 1.1, Duration = cameraPanTime })
	ZeroMouseTether("GenericBossKillPresentation")
	CancelWeaponFireRequests({ Id = killerId })
	ToggleCombatControl( CombatControlsDefaults, false, "BossKill" )
	HideCombatUI("BossKill")

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	end

	if deathPanSettings.StartSound then
		PlaySound({ Name = deathPanSettings.StartSound })
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteShocked" })
	end
	if not args.IgnoreEndMusic then
		EndMusic()
	end

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationId = killerId })
	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = victimId })
	thread( VictimDeathHold, victimId, 0.02, 0.5 )

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

	thread( BossDeathFlash, 0.52, 0.3 )

	wait( 0.15 )
	if killerId == CurrentRun.Hero.ObjectId then
		SetPlayerFade({ Flag = "KillPresentation"})
	else
		SetAlpha({ Id = killerId, Fraction = 0, Duration = 0.3 })
	end
	ClearEffect({ Id = killerId, Name = "KillDamageBonus" })

	wait( 5 )

	-- narrative outro
	local textLines = GetRandomEligibleTextLines( unit, unit.BossOutroTextLineSets, GetNarrativeDataValue( unit, "BossOutroTextLinePriorities" ) )
	PlayTextLines( unit, textLines )

	FadeOut({ Duration = 0.5, Color = Color.Black })

	PlaySound({ Name = "/VO/CerberusCuteGrowl_2" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })

	PanCamera({ Id = victimId, Duration = 5.7, EaseOut = 0.5, OffsetY = -95, Retarget = true })

	-- banner
	local textMessage = "CerberusDefeatedMessage"
	if deathPanSettings.BossDifficultyMessage and GetNumShrineUpgrades( "BossDifficultyShrineUpgrade" ) > 0 then
		textMessage = deathPanSettings.BossDifficultyMessage
	end	
	thread( DisplayInfoBanner, nil, { Text = textMessage, Delay = 0.75, TextColor = Color.Turquoise, Layer = "ScreenOverlay", FontScale = 0.9, AnimationName = "LocationBackingIrisDeathIn", AnimationOutName = "LocationBackingIrisDeathOut", Duration = 3.75 } )

	wait( 1.25 )

	Teleport({ Id = victimId })

	wait(0.25)
	PlaySound({ Name = "/SFX/CerberusFootsteps" })
	wait(0.25)
	PlaySound({ Name = "/SFX/CerberusFootsteps" })
	wait(0.8)
	PlaySound({ Name = "/SFX/CerberusFootsteps" })
	wait(0.25)
	PlaySound({ Name = "/SFX/CerberusFootsteps" })
	wait(0.8)
	PlaySound({ Name = "/SFX/CerberusFootsteps" })
	wait(0.25)
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.02, Retarget = true })

	wait( 1.25 )

	if unit.PostOutroVoiceLines ~= nil then
		thread( PlayVoiceLines, unit.PostOutroVoiceLines )
	end
	
	RemoveFromGroup({ Id = killerId, Names = { "Combat_Menu_Overlay_Backing" } })
	AddToGroup({ Id = killerId, Name = "Standing", DrawGroup = true })
	SetAnimation({ DestinationId = killerId, Name = "MelinoeIdle" })
	ClearEffect({ Ids = { killerId }, All = true })

	FadeIn({ Duration = args.FadeInTime or 1.0 })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })

	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0.0, Duration = 0.3 })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.0, EaseOut = 0.5 })

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationId = killerId })
	if killerId == CurrentRun.Hero.ObjectId then
		ClearPlayerFade( "KillPresentation" )
	else
		SetAlpha({ Id = killerId, Fraction = 1.00, Duration = 0.3 })
	end

	local defaultZoom = 1.0
	if CurrentHubRoom ~= nil then
		defaultZoom = CurrentHubRoom.ZoomFraction or defaultZoom
	else
		defaultZoom = CurrentRun.CurrentRoom.ZoomFraction or defaultZoom
	end
	FocusCamera({ Fraction = defaultZoom, Duration = 2.0, ZoomType = "Ease" })

	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	wait( 0.5 )
	RemoveInputBlock({ Name = "GenericBossKillPresentation" })
	RemoveTimerBlock( CurrentRun, "GenericBossKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "GenericBossKillPresentation" )
	ShowCombatUI("BossKill")
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	ToggleCombatControl( CombatControlsDefaults, true, "BossKill" )
	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
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
	if chargeTime < 0.15 then
		return 0.15
	end
	return chargeTime
end

function HandleManaChargeIndicator( triggerArgs )

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	local groupName = "Combat_Menu_Backing"

	local weaponData = GetWeaponData( CurrentRun.Hero, triggerArgs.name )
	if weaponData.ArmedCastChargeStage and SessionMapState.CastArmDisabled then
		return
	end
	local duckChargeTime = GetHideChargeDuration( weaponData )
	local chargeTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = triggerArgs.name, Property = "ChargeTime" })
	local chargePercent = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = triggerArgs.name, Property = "MinChargeToFire" })
	
	if weaponData.ChargeWeaponStages then
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
		
	local notifyName = triggerArgs.name.."IndicatorFire"

	if weaponData.SkipManaIndicatorIfZeroManaCost and manaCost == 0 then
		return
	end

	if weaponData.SkipManaIndicatorIfOutOfMana and CurrentRun.Hero.Mana < manaCost then
		return
	end
	
	MapState.ChargedManaWeapons = MapState.ChargedManaWeapons or {}
	MapState.ChargedManaWeapons[triggerArgs.name] = false
		
	if MapState.ExShieldTriggers > 0 and MapState.ExShieldFx and MapState.ExShieldWeapons[triggerArgs.name] then
		CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = MapState.ExShieldFx })
	end

	if duckChargeTime > 0 then
		NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = triggerArgs.name, ChargeFraction = 0.0, Comparison = "<=", Timeout = duckChargeTime, TimeModifierFraction = 0.0 })
		waitUntil( notifyName )
		if not _eventTimeoutRecord[notifyName] then
			MapState.ChargedManaWeapons[triggerArgs.name] = nil
			
			if MapState.ExShieldFx and MapState.ExShieldWeapons[triggerArgs.name] then
				StopAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = MapState.ExShieldFx })
			end
			return
		end
	end

	if weaponData.ManaChargeStartAnimation then
		SetAnimation({ Name = weaponData.ManaChargeStartAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end

	local backingId = SpawnObstacle({Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -200, Group = groupName })		
	Attach({ Id = backingId , DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -250 })
	SetAnimation({ Name = indicatorData.TransitionIn, DestinationId = backingId , Scale = 1.0, OffsetY = -50 })
	waitUnmodified(0.1)

	CreateAnimation({ Name = ManaGatherAnimations.Default, DestinationId = CurrentRun.Hero.ObjectId })
	local color = Color.White
	SetAnimation({ Name = indicatorData.Fill, DestinationId = backingId , PlaySpeed = 1 / ( chargeTime * chargePercent - duckChargeTime), Scale = 1.0, OffsetY = -50})
		
	if MapState.ManaChargeIndicatorIds then
		Destroy({ Ids = { MapState.ManaChargeIndicatorIds.BackingId, MapState.ManaChargeIndicatorIds.PipId }})
	end
	MapState.ManaChargeIndicatorCost = MapState.ManaChargeIndicatorCost or manaCost
	MapState.ManaChargeIndicatorData = indicatorData
	MapState.ManaChargeIndicatorIds = {}
	MapState.ManaChargeIndicatorIds.BackingId = backingId

	if (not reserveMana and CurrentRun.Hero.Mana < MapState.ManaChargeIndicatorCost) or (reserveMana and GetHeroMaxAvailableMana() < MapState.ManaChargeIndicatorCost) then
		SetColor({ Id = backingId, Color = Color.Red })
	end

	local manaCostText = CreateTextBox({ 
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
	local manaPipId = SpawnObstacle({Name = "BlankObstacle",  DestinationId = CurrentRun.Hero.ObjectId, OffsetX = -20, OffsetY = -252, Group = groupName })
	Attach({ Id = manaPipId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = -20, OffsetY = -252 })
	SetAnimation({ Name = "ManaTimerIcon", DestinationId = manaPipId, })
	MapState.ManaChargeIndicatorIds.PipId = manaPipId
	
	if (not reserveMana and CurrentRun.Hero.Mana < MapState.ManaChargeIndicatorCost) or (reserveMana and GetHeroMaxAvailableMana() < MapState.ManaChargeIndicatorCost) then
		SetManaIndicatorDisallowed( triggerArgs.name, true )
	end
	thread( ManaChargeCompletePresentationThread, weaponData, chargeTime * chargePercent - duckChargeTime )
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = triggerArgs.name, ChargeFraction = 0.0, Comparison = "<=" })
	waitUntil( notifyName )
	killTaggedThreads("ManaChargeComplete")
	ClearManaChargeIndicator( triggerArgs.name )
	MapState.ChargedManaWeapons[triggerArgs.name] = nil

	if MapState.ExShieldFx and MapState.ExShieldWeapons[triggerArgs.name] then
		StopAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = MapState.ExShieldFx })
	end
end

function ClearManaChargeIndicator( weaponName, animationKeyOverride )
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "MaxChargeStageCache", Value = false, DataValue = false })
	for i, name in pairs( ManaGatherAnimations ) do
		StopAnimation({ Names = name, DestinationId = CurrentRun.Hero.ObjectId })
	end
	MapState.ManaChargeIndicatorCost = nil
	if MapState.ManaChargeIndicatorIds then
		if animationKeyOverride then
			SetAnimation({ Name = MapState.ManaChargeIndicatorData[animationKeyOverride], DestinationId = MapState.ManaChargeIndicatorIds.BackingId, OffsetY = -50 })
		elseif MapState.ChargedManaWeapons[weaponName] then
			SetAnimation({ Name = MapState.ManaChargeIndicatorData.Dissipate, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, OffsetY = -50 })
		else
			SetAnimation({ Name = MapState.ManaChargeIndicatorData.Cancel, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, OffsetY = -50 })
		end
		ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, ColorTarget = {0, 0, 1, 0}, ColorDuration = 0.15 })
		SetColor({ Id = MapState.ManaChargeIndicatorIds.PipId, Color = {0, 0, 1, 0}, Duration = 0.15 })
		thread( DestroyOnDelay, { MapState.ManaChargeIndicatorIds.BackingId, MapState.ManaChargeIndicatorIds.PipId }, 0.333 )
		if MapState.ExShieldFx then
			StopAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = MapState.ExShieldFx })
		end
		MapState.ManaChargeIndicatorIds = {}
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

function CrawlerMiniBossKillPresentation( unit, args )

	AddTimerBlock( CurrentRun, "CrawlerMiniBossKillPresentation" )
	SetPlayerInvulnerable( "CrawlerMiniBossKillPresentation" )
	PlaySound({ Name = "/SFX/StabSplatterEndSequence" })
	PlaySound({ Name = "/SFX/Enemy Sounds/HydraHead/EmoteFinalDying1", Id = unit.ObjectId })

	GenericBossKillPresentation(unit, args)

	RemoveTimerBlock( CurrentRun, "CrawlerMiniBossKillPresentation" )
	SetPlayerVulnerable( "CrawlerMiniBossKillPresentation" )

end

function PolyphemusBoulderIncomingPresentation()
	thread( PlayVoiceLines, HeroVoiceLines.BoulderIncomingVoiceLines, true )
end

function GhostWallCollidePresentation( collidee, collider )
	--DebugPrint({ Text = tostring( collidee.ObjectId ) })
	if collidee == nil then
		return
	end
	if collidee.GhostWallPresentationCooldown == nil then
		collidee.GhostWallPresentationCooldown = false
	end
	if collider ~= nil and collider.ObjectId == CurrentRun.Hero.ObjectId then
		--SetAnimation({ Name = "MelinoeGetHit", DestinationId = collider.ObjectId })
	end
	if not collidee.GhostWallPresentationCooldown then
		collidee.GhostWallPresentationCooldown = true
		--Flash({ Id = collider.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5 })
		--Flash({ Id = collidee.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5 })
		Shake({ Id = collidee.ObjectId, Duration = 0.3, Speed = 140, Distance = 3 })
		CreateAnimation({ Name = "GhostWallImpactPuff", DestinationId = collidee.ObjectId, Group = "Standing", Scale = 0.5 })
		CreateAnimation({ Name = "GhostWallImpactFx", DestinationId = collider.ObjectId, Group = "FX_Displacement", Scale = 0.5, OffsetY = 60 })

		PlaySound({ Name = "/SFX/GhostEvaporate", ManagerCap = 2 })
		thread( PlayVoiceLines, HeroVoiceLines.GhostWallInteractionVoiceLines, true )
		wait( 0.25 )
		collidee.GhostWallPresentationCooldown = false
	end
	
end

function InfestedCerberusHorribleRaceConditionForTempPresentation( unit )
	wait(3.0)
	StopAnimation({ DestinationId = unit.ObjectId, Name = "CerbBibMoveTrail" })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
  	CreateAnimation({ Name = "TeleportDisappear", DestinationId = unit.ObjectId, Scale = 2.5 })
  	PanCamera({ Id =  unit.ObjectId, Duration = 1.2, EaseOut = 0.5, OffsetY = -30, Retarget = true })
  	wait(0.10)
  	SetAlpha({ Id = unit.ObjectId, Fraction = 0, Duration = 0.06 })
  	wait(0.07)
	SetAlpha({ Id = unit.ObjectId, Fraction = 1.0, Duration = 0.06 })
	SetThingProperty({ Property = "GrannyModel", Value = "Cerberus_Mesh", DestinationId = unit.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "Cerberus_Idle_Sitting", DestinationId = unit.ObjectId })
	SetAnimation({ DestinationId = unit.ObjectId, Name = "Cerberus_Idle_Sitting" })
end

function ChronosTimeSlowPresentation( args )
	args = args or {}
	local duration = 0.05
	AdjustColorGrading({ Name = "ChronosTimeSlow", Duration = duration })
	-- AdjustFullscreenBloom({ Name = "GoldBloom", Duration = duration })
	AdjustRadialBlurDistance({ Fraction = 0.05, Duration = duration })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = duration })

	SetAudioEffectState({ Name = "ChronosSlow", Value = 1 })

	PlaySound({ Name = "/SFX/Player Sounds/TimeSlowStart" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweepSubtle" })
	if not args.IgnoreSoundLoop and AudioState.ChronosTimeSlowSoundId == nil then
		AudioState.ChronosTimeSlowSoundId = PlaySound({ Name = "/SFX/Player Sounds/TimeSlowLoop" })
	end
	if ScreenAnchors.TimeStopVignette ~= nil then
		return
	end
	ScreenAnchors.TimeStopVignette = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY, })
	SetAnimation({ Name = "ChronosTimeStopFx", DestinationId = ScreenAnchors.TimeStopVignette })
	CreateAnimation({ Name = "ChronosTimeStopMelFx", DestinationId = CurrentRun.Hero.ObjectId })
end

function ChronosEndTimeSlowPresentation()
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.3 })
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })

	SetAudioEffectState({ Name = "ChronosSlow", Value = 0 })
	PlaySound({ Name = "/SFX/Player Sounds/TimeSlowEnd" })

	if AudioState.ChronosTimeSlowSoundId ~= nil then
		StopSound({ Id = AudioState.ChronosTimeSlowSoundId, Duration = 0.3 })
		AudioState.ChronosTimeSlowSoundId = nil
	end

	StopAnimation({ Name = "ChronosTimeStopMelFx", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = ScreenAnchors.TimeStopVignette, Fraction = 0.0, Duration = 0.3 })
	wait(0.3) 
	Destroy({ Id = ScreenAnchors.TimeStopVignette })
	ScreenAnchors.TimeStopVignette = nil
end

function SpellChargeTimeSlowPresentation()

	--[[
	local duration = 0.05
	AdjustFullscreenBloom({ Name = "MoonDustBloom", Duration = duration })
	AdjustColorGrading({ Name = "Respawn", Duration = duration })
	AdjustRadialBlurDistance({ Fraction = 0.05, Duration = duration })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = duration })
	]]
	
	CreateAnimation({ Name = "SpellChargeVignette", DestinationId = CurrentRun.Hero.ObjectId })

end

function SpellChargeTimeSlowPresentationSoftVignette()
	CreateAnimation({ Name = "SpellChargeVignetteSoft", DestinationId = CurrentRun.Hero.ObjectId })
end

function SpellChargeEndTimeSlowPresentation()
	local duration = 0
	AdjustRadialBlurStrength({ Fraction = 0, Duration = duration })
	AdjustColorGrading({ Name = "Off", Duration = duration })
	AdjustFullscreenBloom({ Name = "Off", Duration = duration })
end

function SirenKillPresentation( unit, args )
	GenericPresentation(unit, {
		SetSoundCueValues =
			{
				{
					Name = unit.MusicStem,
					Value = 0.0,
					AudioStateId = "MusicId",
					Duration = 1.0,
				}
			},
		})

	-- don't play the rest of this if you're too far away
	if GetDistance({ Id = unit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) < 550 then
		thread( SirenKillScreenEffects, unit )
	end
end

function SirenKillScreenEffects( unit, args )
	waitUnmodified( 0.25 )

	local lastKillFxInTime = 0.08
	local lastKillFxOutTime = 0.4

	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0.85, Duration = lastKillFxInTime })
	AdjustFrame({ Duration = lastKillFxInTime, Fraction = 1.25 })
	AdjustFullscreenBloom({ Name = "LastKillBloom", Duration = 0 })
	AddSimSpeedChange( "LastKill", { Fraction = 0.08, LerpTime = lastKillFxInTime, Priority = true } )

	waitUnmodified( 0.6 )

	AdjustRadialBlurStrength({ Fraction = 0, Duration = lastKillFxOutTime })
	AdjustFrame({ Duration = lastKillFxOutTime, Fraction = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = lastKillFxOutTime })
	RemoveSimSpeedChange( "LastKill", { LerpTime = lastKillFxOutTime } )
	waitUnmodified(  0.2 )
end

function ScyllaKillPresentation( unit, args )
	SetAlpha({ Ids = GetIds({ Name = "StageLights" }), Fraction = 1.0, Duration = 1.0 }) -- Un-Dim lights
	GenericBossKillPresentation( unit, args )
end

function SpawnKillPresentation( unit )
	thread( PlayVoiceLines, GlobalVoiceLines.ZeusInstaKillVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/PlayerKilledNEW", Id = unit.ObjectId })
	if CheckCooldown( "SpawnKillPresentationCooldown", 1.0 ) then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_SpawnKill", 0.75, { PreDelay = 0.25 } )
	end
end

function ErisFlyByPresentation( enemy, aiData, CurrentRun, args )
	
	Teleport({ Id = enemy.ObjectId, DestinationId = 744256 })
	SetInvulnerable({ Id = enemy.ObjectId })
	ClearEffect({ Id = enemy.ObjectId, All = true })
	local zHeight = args.FlybyZHeight or 500
	AdjustZLocation({ Id = enemy.ObjectId, Distance = zHeight - GetZLocation({ Id = enemy.ObjectId }) })
	IgnoreGravity({ Id = enemy.ObjectId })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Eris_StrafeFireLoop" })
	SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithObstacles", Value = false })

	if args.TopGroup then
		RemoveFromGroup({ Id = enemy.ObjectId, Names = { "Standing" } })
		AddToGroup({ Id = enemy.ObjectId, Name = "Combat_Menu_TraitTray_Overlay_Text", DrawGroup = true })

		local heroExitIds = GetIdsByType({ Name = "HeroExit" })
		local heroExitPointId = heroExitIds[1]
		thread( GustWindBoss, { ObjectId = heroExitPointId, AnimationName = "ShipsGustSpawnerForward", Count = 1 } )

		local heroEntranceIds = GetIdsByType({ Name = "HeroStart" })
		local heroEntranceId = heroEntranceIds[1]
		thread( GustWindBoss, { ObjectId = heroEntranceId, AnimationName = "ShipsGustSpawnerForward", Count = 1 } )
		ShakeScreen({ Speed = 400, Distance = 12, FalloffSpeed = 1000, Duration = 0.4, Angle = 45 })
	end

	local scale = args.FlyByScale or 1.0
	local prevScale = GetThingDataValue({ Id = enemy.ObjectId, Property = "Scale" })
	SetScale({ Id = enemy.ObjectId, Fraction = scale, Duration = 0.1 })

	local duration = args.FlyByDuration or 1.0

	local speedEffect = { Id = enemy.ObjectId, DestinationId = enemy.ObjectId, EffectName = enemy.Name .. "ErisFlyBySpeed" }
	speedEffect.DataProperties = { Duration = duration, Type = "SPEED", Modifier = args.FlyBySpeedMultiplier or 6.0, TimeModifierFraction = 1 }
	ApplyEffect(speedEffect)
	Move({ Id = enemy.ObjectId, DestinationId = 744255 })

	AIWait(duration, enemy, enemy.AIThreadName)

	Stop({ Id = enemy.ObjectId })
	ObeyGravity({ Id = enemy.ObjectId })
	AdjustZLocation({ Id = enemy.ObjectId, Distance = 0 })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Eris_Hidden" })
	SetVulnerable({ Id = enemy.ObjectId })

	SetScale({ Id = enemy.ObjectId, Fraction = prevScale, Duration = 0.1 })
	SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithObstacles", Value = true })
	AddToGroup({ Id = enemy.ObjectId, Name = "Standing", DrawGroup = true })
	RemoveFromGroup({ Id = enemy.ObjectId, Names = { "Combat_Menu_TraitTray_Overlay_Text" } })
end