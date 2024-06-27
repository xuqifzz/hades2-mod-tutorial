
-- Old from Minos

function AtLastStandMaxPresentation( unit )
	-- stub method
end

function CantAffordPresentation( object )
	Shake({ Id = object.ObjectId, Distance = 6, Speed = 300, Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	thread( MoneyFlashRed )
	if object.NotEnoughCurrencyVoiceLines then
		thread( PlayVoiceLines, object.NotEnoughCurrencyVoiceLines, true )
	else
		thread( PlayVoiceLines, HeroVoiceLines.NotEnoughCurrencyVoiceLines, true )
	end
	ModifyTextBox({ Id = object.ObjectId, ColorTarget = Color.GhostWhite, ScaleTarget = 1.05 })
	wait( 0.1 )
	ModifyTextBox({ Id = object.ObjectId, ColorTarget = Color.Red, ColorDuration = 0.2, ScaleTarget = 1.0 })
end

function CantPurchaseWorldItemPresentation( object )
	if object ~= nil then
		Shake({ Id = object.ObjectId, Distance = 6, Speed = 300, Duration = 0.2 })
	end
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	if object.CannotPurchaseCombatText and CheckCooldown("CannotPurchaseCombatText", 1.0 ) then
		thread( InCombatTextArgs, { TargetId = object.ObjectId, Text = object.CannotPurchaseCombatText, Duration = 2, OffsetY = -140, SkipRise = true })
	end
	if object.CannotPurchaseVoiceLines then
		thread( PlayVoiceLines, object.CannotPurchaseVoiceLines, true )
	else
		thread( PlayVoiceLines, HeroVoiceLines.CannotPurchaseVoiceLines, true )
	end
end

function CantPurchasePresentation( button )
	Flash({ Id = button.Id, Speed = 2.5, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.CostCantPurchase, ExpireAfterCycle = true })
	thread( PlayVoiceLines, HeroVoiceLines.CannotPurchaseVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
end

function MoneyFlashRed()
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, ScaleTarget = 1.2, ScaleDuration = 0.0, AutoSetDataProperties = false, })
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, Color = Color.CostUnaffordable, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0, AutoSetDataProperties = false, })
	waitUnmodified(0.05)
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, ColorTarget = Color.CostUnaffordable, ColorDuration = 2.0, AutoSetDataProperties = false, })

	-- Pulses the money text

	waitUnmodified(0.06)
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, ScaleTarget = 1, ScaleDuration = 0.4, AutoSetDataProperties = false, })
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, ColorTarget = Color.White, ColorDuration = 0.4, AutoSetDataProperties = false, })
end

function SwitchWeaponImage( id, newImageName )
	SetAnimation({ DestinationId = id, Name = newImageName })
	CreateAnimation({ Name = "SwitchWeaponImageFlash", DestinationId = id, GroupName = "Combat_Menu_TraitTray_Additive" })
end

function MetaPointRoomRewardPresentation(gained)
	thread( MetaPointRoomRewardPresentationThread, gained )
end

function MetaPointRoomRewardPresentationThread(gained)
	wait(0.5)
	thread( InCombatText, CurrentRun.Hero.ObjectId, "MetaPointGain", 1.5 , { LuaKey = "TempTextData", LuaValue = {Number = gained} })
end

function RangedFailedNoAmmoPresentation()
	thread( UpdateAmmoUI )
	thread( PulseText, { ScreenAnchorReference = "AmmoIndicatorUI", Color = Color.White, OriginalColor = Color.Red, ScaleTarget = 1.5, ScaleDuration = 0.2, HoldDuration = 0.05, PulseBias = 0.1, StartColorDuration = 0.25, EndColorDuration = 0.25 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = CurrentRun.Hero.ObjectId })
end

function AddAmmoPresentation()
	thread( UpdateAmmoUI )

	CreateAnimation({ Name = "LobPickupFlash", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = -90 })

	if ScreenAnchors.AmmoIndicatorUI ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.AmmoIndicatorUI, ColorTarget = Color.White, ColorDuration = 0.2, AutoSetDataProperties = false, })
		thread( PulseText, { ScreenAnchorReference = "AmmoIndicatorUI", ScaleTarget = 1.3, ScaleDuration = 0.125, HoldDuration = 0.1, PulseBias = 0.1, StartColorDuration = 0.25, EndColorDuration = 0.25 } )
	end
end

function ActivateTempInvulnerabilityPresentation()
	if ScreenAnchors.ShieldHitAnchor ~= nil then
		return
	end
	ScreenAnchors.ShieldHitAnchor = SpawnObstacle({ Name = "BlankGeoObstacle", Group = "Standing", DestinationId =  CurrentRun.Hero.ObjectId })
	Attach({ Id = ScreenAnchors.ShieldHitAnchor, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Invincibubble_Zag_Loop", DestinationId = ScreenAnchors.ShieldHitAnchor })
end

function DisableTempInvulnerabilityPresentation( delay )
	-- Shake({ Id = ScreenAnchors.ShieldHitAnchor, Distance = 4, Speed = 300, Duration = delay })
	-- wait(delay)
	SetAnimation({Name = "InvincibubbleOut_Zag", DestinationId = ScreenAnchors.ShieldHitAnchor })
	CreateAnimation({Name = "InvincibubbleShieldPop", DestinationId = ScreenAnchors.ShieldHitAnchor })
	wait(0.1)
	Destroy({ Id = ScreenAnchors.ShieldHitAnchor })
	ScreenAnchors.ShieldHitAnchor = nil
end

function HeroDamagePresentation( args, sourceWeaponData )
	local currentHealthFraction = (CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth)
	local victim = args.TriggeredByTable or CurrentRun.Hero

	local rapidDamage = false
	if ((sourceWeaponData ~= nil and sourceWeaponData.RapidDamageType) or ( args.EffectName ~= nil and EffectData[args.EffectName] and EffectData[args.EffectName].RapidDamageType)) and not CheckCooldown( "RapidDamage", 0.6 ) then
		rapidDamage = true
	end
	args.PercentMaxDealt = args.DamageAmount / CurrentRun.Hero.MaxHealth
	if args.DamageAmount > 0 then
		thread( DisplayPlayerDamageText, args )
	end
	if args ~= nil then
		if currentHealthFraction <= 0 then
			thread( HeroFinalDamagePresentationThread, args, sourceWeaponData )
		elseif not rapidDamage then
			if args.PercentMaxDealt > HealthUI.MajorHitThreshold then
				thread( HeroMajorDamagePresentationThread, args, sourceWeaponData )
			elseif args.HitArmor then
				thread( HeroArmorDamagePresentationThread, args, sourceWeaponData )
			else
				thread( HeroDamagePresentationThread, args, sourceWeaponData )
			end
		end
		if args.SourceProjectile and GetBaseDataValue({ Type = "Projectile", Name = args.SourceProjectile, Property = "IgnoreCoverageAngles"}) then
			local playerAttemptingToBlock = false
			for effectName in pairs(CurrentRun.Hero.ActiveEffects) do
				if EffectData[effectName] and EffectData[effectName].BlockEffect then
					playerAttemptingToBlock = true
					break
				end
			end
			if playerAttemptingToBlock then
				if CheckCooldown("UnblockableAttackPresentation", 0.35) then
					local attackerId = nil
					if args.AttackerTable then
						attackerId = args.AttackerTable.ObjectId
					end
					if not attackerId then
						attackerId = CurrentRun.Hero.ObjectId
					end
					thread( UnblockableAttackPresentation, victim.ObjectId )
				end
			end
		end
	end

	if not rapidDamage then
		if CurrentRun.Hero.Health <= GetLowHealthUIThreshold( CurrentRun.Hero.MaxHealth ) and (not CurrentRun.Hero.HealthBuffer or CurrentRun.Hero.HealthBuffer <= 0 ) and not HeroHasTrait("MinorHitShieldBoon") then
			HeroDamageLowHealthPresentation()
		else
			ModifyTextBox({ Id = ScreenAnchors.HealthBack, ColorTarget = Color.Red, ColorDuration = 0, AutoSetDataProperties = false })
			ModifyTextBox({ Id = ScreenAnchors.HealthBack, ColorTarget = Color.White, ColorDuration = 0.2, AutoSetDataProperties = false })
		end
		thread( PulseText, { ScreenAnchorReference = "HealthBack", ScaleTarget = 1.25, ScaleDuration = 0.15, HoldDuration = 0.0, PulseBias = 0} )
	end

	local attacker = args.AttackerTable

	if not rapidDamage and victim.DamagedSound ~= nil and not victim.Mute then
		PlaySound({ Name = victim.DamagedSound, Id = victim.ObjectId })
	end
end

function HeroDamagePresentationThread( args, sourceSimData )
	if args == nil or not args.DamageAmount or args.DamageAmount > 0 then
		Shake({ Id = args.triggeredById, Distance = 4, Speed = 800, Duration = 0.14 })
		Flash({ Id = args.triggeredById, Speed = 2.65, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.Red, Duration = 0.2, ExpireAfterCycle = true })
		CreateAnimation({ Name = "BloodFrame", GroupName = "Vignette", UseScreenLocation = true,
			OffsetX = ScreenCenterX, OffsetY = ScreenCenterY,
			ScaleX = ScreenScaleX, ScaleY = ScreenScaleY,
			Duration = args.BloodFrameDuration or 0.3,
			})
		thread( DoRumble, CurrentRun.Hero.HeroHitRumbleParameters )
	end
	
	if args ~= nil and sourceSimData ~= nil then
		thread( DoWeaponHitSimulationSlow, CurrentRun.Hero, args, sourceSimData )
		thread( DoWeaponScreenshake, sourceSimData, "HitScreenshake", { AttackerId = args.triggeredById, SourceProjectile = args.SourceProjectile, EffectName = args.EffectName })
	end
end

function HeroArmorDamagePresentationThread( args, sourceSimData )
	if args == nil or not args.DamageAmount or args.DamageAmount > 0 then
		Shake({ Id = args.triggeredById, Distance = 2, Speed = 800, Duration = 0.7 })
		Flash({ Id = args.triggeredById, Speed = 0.65, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Yellow, Duration = 0.2, ExpireAfterCycle = true })
		CreateAnimation({ Name = "BloodFrame", UseScreenLocation = true,
			OffsetX = ScreenCenterX, OffsetY = ScreenCenterY,
			ScaleX = ScreenScaleX, ScaleY = ScreenScaleY,
			Duration = args.BloodFrameDuration or 0.3
			})
		thread( DoRumble, CurrentRun.Hero.HeroHitRumbleParameters )
	end
	if args ~= nil and sourceSimData ~= nil then
		thread( DoWeaponHitSimulationSlow, CurrentRun.Hero, args, sourceSimData )
		thread( DoWeaponScreenshake, sourceSimData, "HitScreenshake", { AttackerId = args.triggeredById, SourceProjectile = args.SourceProjectile, EffectName = args.EffectName })
	end
end

function HeroFinalDamagePresentationThread( args, sourceWeaponData )

end

function HeroMajorDamagePresentationThread( args, sourceWeaponData )
	args.BloodFrameDuration = 1.0
	thread( HeroDamagePresentationThread, args, sourceWeaponData )
	thread( DoRumble, CurrentRun.Hero.HeroMajorHitRumbleParameters )
end

function DisplayPlayerDamageText( args )

	if not ConfigOptionCache.ShowDamageNumbers then
		return
	end

	local objectId = args.triggeredById
	local amount = args.DamageAmount
	local isCritical = args.IsCrit
	local hitVulnerable = args.HitVulnerability
	local sourceId = args.AttackerId

	--local sizeAdjust = math.max( args.PercentMaxDealt / HealthUI.MajorHitThreshold * 2, 1 )
	local roundedAmount = round( amount )
	local sizeAdjust = GetPlayerDamageNumberTextScale( roundedAmount )
	local damageTextAnchor = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", DestinationId = objectId, Group = "Overlay", OffsetX = 0, OffsetY = -180 })

	local randomFontSize = RandomInt( 220, 230 )
	local holdDuration = 0.4
	if args.HitArmor then
		CreateTextBox({
			Id = damageTextAnchor,
			Text = "CombatDamageShielded",
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {255,0,0,255},
			Font = "P22UndergroundSCMedium",
			FontSize = randomFontSize,
			OffsetY = 85,
			OffsetX = 80,
			Scale = 0.6 * sizeAdjust,
			ScaleTarget = 0.6,
			LuaKey = "TempTextData",
			LuaValue = {Amount = roundedAmount},
			AutoSetDataProperties = false,
		})
	elseif args.UseCustomText then
		CreateTextBox({
			Id = damageTextAnchor,
			Text = args.UseCustomText,
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {255,0,0,255},
			Font = "P22UndergroundSCMedium",
			FontSize = randomFontSize,
			OffsetY = 85,
			OffsetX = 80,
			Scale = 0.8 * sizeAdjust,
			ScaleTarget = 0.8,
			LuaKey = "TempTextData",
			LuaValue = {Amount = roundedAmount},
			AutoSetDataProperties = false,
		})
		holdDuration = 0.6
	elseif isCritical then
		
		CreateTextBox({
			Id = damageTextAnchor,
			Text = "CombatDamageVulnerable",
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {255,0,0,255},
			Font = "P22UndergroundSCMedium",
			FontSize = randomFontSize,
			OffsetY = 85,
			OffsetX = 80,
			Scale = 0.8 * sizeAdjust,
			ScaleTarget = 0.8,
			LuaKey = "TempTextData",
			LuaValue = {Amount = roundedAmount},
			AutoSetDataProperties = false,
		})
		holdDuration = 0.6
	else
		CreateTextBox({
			Id = damageTextAnchor,
			RawText = roundedAmount,
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {255,0,0,255},
			Font = "P22UndergroundSCMedium",
			FontSize = randomFontSize,
			OffsetY = 85,
			OffsetX = 80,
			Scale = 0.6 * sizeAdjust,
			ScaleTarget = 0.6,
			AutoSetDataProperties = false,
		})
	end




	waitUnmodified(0.1)

	local randomOffsetX = RandomInt( -30, 30 )
	Shift({ Id = damageTextAnchor, OffsetX = randomOffsetX, OffsetY = -100, Duration = 0.5, EaseIn = 0.99, EaseOut = 1.0, TimeModifierFraction = 0.0 })
	ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.3, ScaleDuration = 0.15, ColorTarget = {254,0,0,255}, ColorDuration = 1.0, AutoSetDataProperties = false })
	waitUnmodified(holdDuration)
	ModifyTextBox({ Id = damageTextAnchor, FadeTarget = 0.0, FadeDuration = 0.05, AutoSetDataProperties = false })
	waitUnmodified(0.25)
	table.insert( SessionMapState.DestroyRequests, damageTextAnchor )

end

function HeroDamageLowHealthPresentation( skipStartPresentation )
	thread(HeroLowHealthPresentationThread, skipStartPresentation )
	thread(HeroLowHealthShroudPulseThread)
	thread(HeroLowHealthBarPulseThread)
end

function StartHeroLowHealthPresentation()
	PlaySound({ Name = "/SFX/LowHealthShroudAppear" })
end

function HeroLowHealthPresentationThread( skipStartPresentation )
	if SessionMapState.LowHealthPresentation then
		return
	end
	if not skipStartPresentation then
		StartHeroLowHealthPresentation()
	end
	SessionMapState.LowHealthPresentation = true
	while not SessionState.SafeMode and CurrentRun.Hero.Health <= GetLowHealthUIThreshold() and not IsScreenOpen("RunClear") and not CurrentRun.Hero.IsDead and CurrentRun.CurrentRoom.Encounter and
	( not CurrentRun.CurrentRoom.Encounter.Completed or ( CurrentRun.CurrentRoom.ChallengeEncounter ~= nil and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress )) do
		wait(1)
	end
	SessionMapState.LowHealthPresentation = false
end

function HeroLowHealthBarPulseThread()
	if SessionMapState.LowHealthBarPulsing then
		return
	end
	SessionMapState.LowHealthBarPulsing = true
	local healthBackId = HUDScreen.Components.HealthBack.Id
	while SessionMapState.LowHealthPresentation and not CurrentRun.Hero.IsDead do
		if ShowingCombatUI then
			CreateAnimation({ Name = "HealthBarLowPulseA", DestinationId = healthBackId, GroupName = "Combat_UI_Additive" })
			ModifyTextBox({ Id = healthBackId, ColorTarget = Color.Red, ColorDuration = 0.5 })
			PulseText({ Id = healthBackId, ScaleTarget = 1.25, ScaleDuration = 0.1, HoldDuration = 0.0, PulseBias = 0.02 })
		end
		wait( 0.15, RoomThreadName )
		if ShowingCombatUI then
			CreateAnimation({ Name = "HealthBarLowPulseB", DestinationId = healthBackId, GroupName = "Combat_Menu_Overlay" })
			PulseText({ Id = healthBackId, ScaleTarget = 1.15, ScaleDuration = 0.15, HoldDuration = 0.05, PulseBias = 0.3 })
		end
		wait( 1.5, RoomThreadName )
	end
	ModifyTextBox({ Id = healthBackId, ColorTarget = Color.White, ColorDuration = 0.5 })
	SessionMapState.LowHealthBarPulsing = false
end

function HeroTraitTransformPresentation( expiringTrait )
	wait(1)
	if CheckCooldown( "ChaosBoonTransformed", 5 ) then
		LoadVoiceBanks({ Name = "Chaos" })
		CreateAnimation({ Name = "ChaosShiftFx", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
		-- CreateAnimation({ Name = "HermesShiftFx", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
		thread( PlayVoiceLines, HeroVoiceLines.TrialUpgradeTransformedVoiceLines, true )
		ShakeScreen({ Speed = 500, Distance = 4, Duration = 0.3 })
		AdjustColorGrading({ Name = expiringTrait.ColorGrade or "Team02", Duration = 0.2 })
		wait(0.25)
		AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	end
end

function HeroShopDeliveryPresentation( expiringTrait )
	wait(1)
	if CheckCooldown( "HermesDelivery", 5 ) then
		CreateAnimation({ Name = "HermesShiftFx", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
		thread( PlayVoiceLines, HeroVoiceLines.HermesDeliveryVoiceLines, true )
		ShakeScreen({ Speed = 500, Distance = 4, Duration = 0.3 })
		AdjustColorGrading({ Name = expiringTrait.ColorGrade or "Team02", Duration = 0.2 })
		wait(0.25)
		AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	end
end

function KeepsakeLevelUpPresentation( traitName )
	wait(1.25)
	local existingTraitData = GetExistingUITraitName( traitName )
	if existingTraitData ~= nil and existingTraitData.AnchorId ~= nil then
		CreateAnimation({ Name = "KeepsakeSparkleEmitter", DestinationId = existingTraitData.AnchorId, GroupName = "Overlay" })
		PlaySound({ Name = existingTraitData.EquipSound or "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY", Id = CurrentRun.Hero.ObjectId })
	end
	CreateAnimation({ Name = "KeepsakeLevelUpFlare", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "KeepsakeAdvance", 2.0 , { ShadowScaleX = 1.5, LuaKey = "TempTextData", LuaValue = { Name = tostring(traitName) } })
end

function HeroLowHealthShroudPulseThread()
	if SessionMapState.LowHealthShouldPulsing then
		return
	end
	SessionMapState.LowHealthShouldPulsing = true
	while SessionMapState.LowHealthPresentation and not CurrentRun.Hero.IsDead and not ConfigOptionCache.EditingMode do
		if CurrentRun.CurrentRoom.Encounter and ( not CurrentRun.CurrentRoom.Encounter.Completed or ( CurrentRun.CurrentRoom.ChallengeEncounter ~= nil and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress )) then
			CreateHealthShroud()
		else
			DestroyHealthShroud()
		end
		-- how often to check health shroud status
		wait(1)
	end
	DestroyHealthShroud()
	SessionMapState.LowHealthShouldPulsing = false
end

function ChillApplyPresentation( victim, victimId )
	SetHSV({ Id = victimId or victim.ObjectId, HSV = { 0, -0.4, -0.1 }, ValueChangeType = "Add" })
	SetColor({ Id = victimId or victim.ObjectId, Color = { 8, 48 , 130, 255 }, Duration = 0.125 })
	if ConfigOptionCache.GraphicsQualityPreset ~= "GraphicsQualityPreset_Low" then
		SetThingProperty({ Property = "AddColor", Value = true, DestinationId = victimId or victim.ObjectId })
	end
	if victim ~= nil and victim.TetherIds ~= nil then
		for k, tetherId in ipairs( victim.TetherIds ) do
			ChillApplyPresentation( nil, tetherId )
		end
	end
end

function ChillClearPresentation( victim, victimId )
	if victim == nil or ((not victim.IsDead and (victim.Health or 0) > 0) or victim.ClearChillOnDeath) then
		SetHSV({ Id = victimId or victim.ObjectId, HSV = { 0, 0.4, 0.1 }, ValueChangeType = "Add" })
		SetColor({ Id = victimId or victim.ObjectId, Color = { 255, 255, 255, 255 }, Duration = 0.125 })
		if ConfigOptionCache.GraphicsQualityPreset ~= "GraphicsQualityPreset_Low" then
			SetThingProperty({ Property = "AddColor", Value = false, DestinationId = victimId or victim.ObjectId })
		end
		if victim ~= nil and victim.TetherIds ~= nil then
			for k, tetherId in ipairs( victim.TetherIds ) do
				ChillClearPresentation( nil, tetherId )
			end
		end
	end
end

function RootApplyPresentation( victim, victimId )
	if victim then
		victim.RootActive = true
	end
	SetHSV({ Id = victimId or victim.ObjectId, HSV = { 0, -0.4, -0.3 }, ValueChangeType = "Add" })
	SetColor({ Id = victimId or victim.ObjectId, Color = { 120, 120, 160, 255 }, Duration = 0.125 })
	if ConfigOptionCache.GraphicsQualityPreset ~= "GraphicsQualityPreset_Low" then
		SetThingProperty({ Property = "AddColor", Value = true, DestinationId = victimId or victim.ObjectId })
	end
	if victim ~= nil and victim.TetherIds ~= nil then
		for k, tetherId in ipairs( victim.TetherIds ) do
			RootApplyPresentation( nil, tetherId )
		end
	end
end

function RootClearPresentation( victim, victimId )
	if victim then
		if not victim.RootActive then
			return
		end
		victim.RootActive = nil
	end
	
	if victim == nil or ((not victim.IsDead and (victim.Health or 0) > 0) or victim.ClearChillOnDeath) then
		SetHSV({ Id = victimId or victim.ObjectId, HSV = { 0, 0.4, 0.3 }, ValueChangeType = "Add" })
		SetColor({ Id = victimId or victim.ObjectId, Color = { 255, 255, 255, 255 }, Duration = 0.125 })
		if ConfigOptionCache.GraphicsQualityPreset ~= "GraphicsQualityPreset_Low" then
			SetThingProperty({ Property = "AddColor", Value = false, DestinationId = victimId or victim.ObjectId })
		end
		if victim ~= nil and victim.TetherIds ~= nil then
			for k, tetherId in ipairs( victim.TetherIds ) do
				RootClearPresentation( nil, tetherId )
			end
		end
	end
end

function StasisPresentation( victim )
	Shake({ Id = victim.ObjectId, Distance = 2, Speed = 100, Duration = 0.5 })
	if victim.Frozen then
		-- Already frozen
		return
	end
	SetHSV({ Id = victim.ObjectId, HSV = { 0, -1, 0 }, ValueChangeType = "Add" })
	SetColor({ Id = victim.ObjectId, Color = { 128, 108, 98, 255 }, Duration = 0.125 })
	SetThingProperty({ Property = "AddColor", Value = true, DestinationId = victim.ObjectId })

	if not victim.IgnoreFrozenAnimFreeze then
		SetThingProperty({ Property = "AnimFreeze", Value = true, DestinationId = victim.ObjectId, DataValue = false })
	end
	-- CreateAnimation({ Name = "UnitFrozenFx", DestinationId = victim.ObjectId, Group = "Overlay" })
	PlaySound({ Name = "/SFX/PetrificationStart", Id = victim.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.ChronosChronomancyVoiceLines, true )
	if victim.FrozenSound ~= nil then
		PlaySound({ Name = victim.FrozenSound, Id = victim.ObjectId })
	end
end

function FrozenPresentation( victim )
	Shake({ Id = victim.ObjectId, Distance = 2, Speed = 100, Duration = 0.5 })
	thread( DisplayFreezeEscapeHint, victim )
	if victim.Frozen then
		-- Already frozen
		return
	end
	SetHSV({ Id = victim.ObjectId, HSV = { 0, -1, 0 }, ValueChangeType = "Add" })
	SetColor({ Id = victim.ObjectId, Color = { 128, 128, 128, 255 }, Duration = 0.125 })
	if not victim.IgnoreFrozenAnimFreeze then
		SetThingProperty({ Property = "AnimFreeze", Value = true, DestinationId = victim.ObjectId, DataValue = false })
	end
	CreateAnimation({ Name = "UnitFrozenFx", DestinationId = victim.ObjectId, Group = "Overlay" })
	PlaySound({ Name = "/SFX/PetrificationStart", Id = victim.ObjectId })
	if victim.FrozenSound ~= nil then
		PlaySound({ Name = victim.FrozenSound, Id = victim.ObjectId })
	end
end

function UnfrozenPresentation( victim, args )
	args = args or {}
	Flash({ Id = victim.ObjectId, Speed = 6, MinFraction = 0, MaxFraction = 1, Color = Color.White, ExpireAfterCycle = true })
	SetHSV({ Id = victim.ObjectId, HSV = { 0, 1, 0 }, ValueChangeType = "Add" })
	SetColor({ Id = victim.ObjectId, Color = { 255, 255, 255, 255 }, Duration = 0.125 })
	SetThingProperty({ Property = "AddColor", Value = false, DestinationId = victim.ObjectId })
	SetThingProperty({ Property = "AnimFreeze", Value = false, DestinationId = victim.ObjectId, DataValue = false })
	if args.SkipPresentation then
		return
	end
	if victim.IsDead and victim.DeathAnimation ~= nil then
		SetAnimation({ Name = victim.DeathAnimation, DestinationId = victim.ObjectId })
	elseif victim.UnfreezeAnimation ~= nil then
		SetAnimation({ Name = victim.UnfreezeAnimation, DestinationId = victim.ObjectId })
	end
	StopAnimation({ Name = "UnitFrozenFx", DestinationId = victim.ObjectId })
	CreateAnimation({ Name = "UnitUnfrozen", DestinationId = victim.ObjectId })
	PlaySound({ Name = "/SFX/PetrificationFree", Id = victim.ObjectId })
	if victim.UnFrozenSound ~= nil then
		PlaySound({ Name = victim.UnFrozenSound, Id = victim.ObjectId })
	end
end

function FreezeEscapeInputPresentation( victim )
	Shake({ Id = victim.ObjectId, Distance = 2, Speed = 300, Duration = 0.2 })
	CreateAnimation({ Name = "PetrifyCrumble", DestinationId = victim.ObjectId,  })
	PlaySound({ Name = "/SFX/PetrificationStruggle", Id = victim.ObjectId })
end

function DisplayFreezeEscapeHint( victim )
	if victim ~= CurrentRun.Hero then
		return
	end
	wait(1.5)
	if victim.FreeEscapeAttempts >= 3 then
		return
	end

	if CheckCooldown("FreezeEscapeHint", 2.0) and HasEffect({ Id = victim.ObjectId, EffectName = "FreezeStun" }) then
		thread( InCombatText, victim.ObjectId, "PlayerUnitFrozen", 1.75 )
	end
end

function TraitSacrificedPresentation( traitData )
	if traitData == nil or not traitData.AnchorId then
		return
	end

	local sacrificeIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Scale = ScreenData.UpgradeChoice.Icon.Scale })
	Teleport({ Id = sacrificeIcon.Id, DestinationId = traitData.AnchorId })
	SetAnimation({ Name = GetTraitIcon(traitData), DestinationId = sacrificeIcon.Id, Group = "Combat_Menu_Overlay" })

	local sacrificeFrame = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Scale = ScreenData.UpgradeChoice.Icon.Scale })
	SetAnimation({ DestinationId = sacrificeFrame.Id, Name = "BoonIcon_Frame_".. (traitData.Rarity or "Common")})
	Attach({ Id = sacrificeFrame.Id, DestinationId = sacrificeIcon.Id})

	wait(1.2, RoomThreadName)

	CreateAnimation({ Name = "TraitUpdate", DestinationId = sacrificeIcon.Id, GroupName = "Combat_Menu_Additive" })
	if traitData.Icon then
		SetAnimation({ DestinationId = sacrificeIcon.Id, Name = traitData.Icon })
	end

	local fadeDuration = 1
	SetScale({ Id = sacrificeIcon.Id, Fraction = 0, Duration = fadeDuration, })
	SetColor({ Id = sacrificeIcon.Id, Color = Color.TransparentRed, Duration = fadeDuration, EaseOut = 1})
	SetColor({ Id = sacrificeFrame.Id, Color = Color.TransparentRed, Duration = fadeDuration, EaseOut = 1})
	wait(fadeDuration, RoomThreadName)
	Destroy({ Ids = { sacrificeIcon.Id, sacrificeFrame.Id }})
end

function TraitLockedPresentation( args )
	local purchaseButtonKey = args.Id
	local offsetX = args.OffsetX
	local offsetY = args.OffsetY
	local components = args.Components
	components[purchaseButtonKey.."Lock"] = CreateScreenComponent({ Name = "BaseInteractableButton", Group = "Combat_Menu_Overlay", X = offsetX, Y = offsetY })
	components[purchaseButtonKey.."Lock"].Screen = args.Screen
	components[purchaseButtonKey.."Lock"].HighlightKey = args.HighlightKey
	components[purchaseButtonKey.."Lock"].OnMouseOverFunctionName = "MouseOverBlockedButton"
	components[purchaseButtonKey.."Lock"].OnMouseOffFunctionName = "MouseOffBlockedButton"
	CreateTextBox({ Id = components[purchaseButtonKey.."Lock"].Id,
		Text = "{$Keywords.ReducedLootChoices}",
		OffsetX = 0, OffsetY = -30,
		Color = Color.Transparent,
		Width = 675,
	})
	AttachLua({ Id = components[purchaseButtonKey.."Lock"].Id, Table = components[purchaseButtonKey.."Lock"] })
	SetInteractProperty({ DestinationId = components[purchaseButtonKey.."Lock"].Id, Property = "TooltipOffsetX", Value = args.TooltipOffsetX })
	wait(0.25)

	PlaySound({ Name = "/Leftovers/Menu Sounds/TitanToggleLong" })

	if components[purchaseButtonKey.."Patch"] then
		SetColor({ Id = components[purchaseButtonKey.."Patch"].Id, Color = Color.DimGray })
	end

	SetAnimation({ DestinationId = components[purchaseButtonKey.."Lock"].Id, Name = "BoonSlotLocked" })
end

function CannotUseDoorPresentation( door )
	local text = door.CannotUseText
	local voiceLines = door.ExitBlockedVoiceLines or HeroVoiceLines.InteractionBlockedVoiceLines

	if door.CannotUseTextOverride then
		text = door.CannotUseTextOverride
	elseif not IsEmpty( RequiredKillEnemies ) and not door.CannotBeBlockedByEnemies then
		text = "ExitBlockedByEnemies"
		voiceLines = HeroVoiceLines.ExitBlockedByEnemiesVoiceLines
		for id, blockedByEnemy in pairs( RequiredKillEnemies ) do
			DebugPrint({ Text = "Door Blocked By: "..GetTableString( blockedByEnemy ) })
		end
	elseif not IsEmpty( CurrentRun.CurrentRoom.Encounter.ActiveSpawns ) and not door.CannotBeBlockedByEnemies then
		text = "ExitBlockedByEnemies"
		voiceLines = HeroVoiceLines.ExitBlockedByEnemiesVoiceLines
		for id, _ in pairs( CurrentRun.CurrentRoom.Encounter.ActiveSpawns ) do
			DebugPrint({ Text = "Door Blocked By: "..id })
		end
	else
		local hintDelay = 0.0
		for objectId, objectTable in pairs( MapState.RoomRequiredObjects ) do
			if objectTable.BlockExitText ~= nil then
				text = objectTable.BlockExitText
				thread( DirectionHintPresentation, objectTable, { Cooldown = 1.0, Delay = hintDelay } )
				hintDelay = hintDelay + 0.2
			end
		end
		if door.BlockedByMultipleRequiredObjectsText ~= nil and TableLength( MapState.RoomRequiredObjects ) >= 2 then
			text = door.BlockedByMultipleRequiredObjectsText
		end

		if text == nil then
			local failedRequirement = CheckSpecialDoorRequirement( door )
			if failedRequirement ~= nil then
				text = failedRequirement
				if failedRequirement == "ExitBlockedByShrinePointReq" then
					voiceLines = door.ExitBlockedByShrinePointsVoiceLines
					--PulseActiveShrinePoints()
				elseif failedRequirement == "ExitBlockedByHealthReq" or failedRequirement == "ExitBlockedByMaxHealthReq" then
					voiceLines = HeroVoiceLines.ExitBlockedByHealthVoiceLines
				end
			end
		end
	end

	if text == nil then
		text = "ExitNotActive"
	end

	if CheckCooldown( "DoorLocked", 1.6 ) then
		PlaySound({ Name = door.LockedUseSound or RoomData.BaseRoom.LockedUseSound, Id = door.ObjectId })
		thread( PlayVoiceLines, GlobalVoiceLines.ErisAttemptedExitVoiceLines, true )
		thread( PlayVoiceLines, voiceLines, true )
		thread( InCombatText, CurrentRun.Hero.ObjectId, text, 1.5, { ShadowScale = 0.66, ShadowScaleX = 1.2 } )
		if door.DoorShakeSelf ~= nil then
			Shake({ Id = door.ObjectId, Distance = 1.5, Speed = 200, Duration = 0.125 })
		end
	end
end

function CannotUseObjectPresentation( object )
	if CheckCooldown( "ObjectLocked", 2.0 ) then
		UseableOff({ Id = object.ObjectId })
		thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
		Shake({ Id = object.ObjectId, Distance = 3, Speed = 1000, Duration = 0.2 })
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = object.Id })
		thread( InCombatText, CurrentRun.Hero.ObjectId, "UseBlockedByLava", 1.5, { ShadowScale = 0.66 } )
	end
	wait( 2.5, RoomThreadName )
	UseableOn({ Id = object.ObjectId })
end

function CannotUseZoomOutPresentation( object )
	if CheckCooldown( "ObjectLocked", 2.0 ) then
		UseableOff({ Id = object.ObjectId })
		thread( PlayVoiceLines, GlobalVoiceLines.CannotUseZoomOutVoiceLines, true )
		Shake({ Id = object.ObjectId, Distance = 2, Speed = 200, Duration = 0.25 })
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = object.Id })
		thread( InCombatText, CurrentRun.Hero.ObjectId, "UseBlockedByWorldUpgrade", 1.5, { ShadowScale = 0.66 } )
	end
	wait( 2.5, RoomThreadName )
	UseableOn({ Id = object.ObjectId })
end

function CannotUseFieldsRewardFinderPresentation( object )
	if CheckCooldown( "ObjectLocked", 2.0 ) then
		UseableOff({ Id = object.ObjectId })
		thread( PlayVoiceLines, GlobalVoiceLines.CannotUseRewardFinderVoiceLines, true )
		Shake({ Id = object.ObjectId, Distance = 2, Speed = 200, Duration = 0.25 })
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = object.Id })
		thread( InCombatText, CurrentRun.Hero.ObjectId, "UseBlockedByWorldUpgrade", 1.5, { ShadowScaleX = 1.35 } )
	end
	wait( 2.5, RoomThreadName )
	UseableOn({ Id = object.ObjectId })
end

function CannotUseKeepsakeRackPresentation( rackId )
	thread( PlayVoiceLines, HeroVoiceLines.GiftRackLockedVoiceLines, true )
	if CheckCooldown( "RackLocked", 1.3 ) then
		PlaySound({ Name = RoomData.BaseRoom.LockedUseSound, Id = rackId })
		Shake({ Id = rackId, Distance = 2, Speed = 300, Duration = 0.25 })
		thread( InCombatText, CurrentRun.Hero.ObjectId, "AwardMenuLocked", 1.0 )
	end
end

function BlockedKeepsakePresentation( screen, button )
	Shake({ Id = button.Id, Distance = 3, Speed = 1000, Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = button.Id })
	if CheckCountInWindow( "KeepsakeBlocked", 1.0, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
	end
end

function DirectionHintPresentation( goal, args )

	if goal == nil then
		return
	end

	args = args or {}

	if CheckCooldown( "DirectionHint", args.Cooldown or 0.75 ) then

		wait( args.Delay or 0.5, RoomThreadName )

		local indicatorId = SpawnObstacle({ Name = args.ArrowAnimationName or "DirectionHintArrow", Group = "FX_Standing_Add", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetZ = 0 })
		SetScale({ Id = indicatorId, Fraction = 0.0 })
		AdjustZLocation({ Id = indicatorId, Distance = 100 })
		SetScale({ Id = indicatorId, Fraction = 2.0, Duration = 0.25 })
		local angle = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = goal.ObjectId })
		SetAngle({ Id = indicatorId, Angle = angle })
		local moveDuration = args.MoveDuration or 1
		local distance = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = goal.ObjectId })
		moveDuration = moveDuration * distance / 750
		Move({ Id = indicatorId, DestinationId = goal.ObjectId, Duration = moveDuration, SmoothStep = true })
		PlaySound({ Name = "/Leftovers/SFX/PowerUpFwoosh", id = indicatorId })

		wait( moveDuration - 0.125, RoomThreadName )

		SetScale({ Id = indicatorId, Fraction = 0, EaseIn = 0, EaseOut = 1, Duration = 0.125 })
		CreateAnimation({ Name = "ResourceFinderGlint", DestinationId = indicatorId })
		wait(0.125)

		Destroy({ Id = indicatorId })

	end

end

function CannotRerollPanelPresentation( button )
	Flash({ Id = button.Id, Speed = 2.64, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, Duration = 0.15, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = button.Id })
	if CheckCountInWindow( "RerollAttempt", 1.0, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.CannotRerollVoiceLines, true )
	end
end

function RerollPanelPresentation( screen, button )
	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })
	local rerollSoundId = PlaySound({ Name = "/Leftovers/Menu Sounds/StoryRecapTextAppear" })
	FullScreenFadeOutAnimationReroll( button.RerollColor )
	SetVolume({ Id = rerollSoundId, Value = 0.3 })

	thread( PlayVoiceLines, HeroVoiceLines.UsedRerollPanelVoiceLines, true )
	wait(0.8)

	StopSound({ Id = rerollSoundId, Duration = 0.3 })

	FullScreenFadeInAnimationReroll( button.RerollColor)
	-- thread( PlayVoiceLines, HeroVoiceLines.RerollOutcomeVoiceLines, true )
end

function OnPlayerHealed( args )
	CreateAnimation({ Name = "HealthSparkleShower", DestinationId = CurrentRun.Hero.ObjectId, Group = "Overlay" })
	thread( DisplayPlayerHealingText, args )
end

function OnPlayerArmorGain( args )
	if not( args.Silent ) and args.Amount > 0 then
		if args.Delay ~= nil then
			wait ( args.Delay )
		end
		CreateAnimation({ Name = "ArmorSparkleShower", DestinationId = CurrentRun.Hero.ObjectId, Group = "Overlay" })
		PlaySound({ Name = "/SFX/Player Sounds/MelinoeAxeGroudClunk", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ArmorIncrease", FontSize = 30, Duration = 0.7, LuaKey = "TooltipData", SkipShadow = true, OffsetY = -100,  LuaValue = { TooltipArmor = args.Amount }})
	end
end

function OnManaRestored( args )
	CreateAnimation({ Name = "ManaSparkleShower", DestinationId = CurrentRun.Hero.ObjectId, Group = "Overlay" })
	-- thread( DisplayPlayerHealingText, args )
end

function DisplayPlayerHealingText( args )

	if not ConfigOptionCache.ShowDamageNumbers then
		return
	end

	local amount = args.ActualHealAmount

	local healthColor = Color.UpgradeGreen
	thread(PopOverheadText, {Amount = amount, Text = "HealingAmount", Color = healthColor, SkipShadow = true })

	local healthFlash = HUDScreen.Components.HealthFlash
	if healthFlash ~= nil then
		CreateAnimation({ Name = "HealthBarFlash", DestinationId = healthFlash.Id, Group = "Overlay", OffsetY = -12, OffsetX = 40})
		SetScaleX({ Id = healthFlash.Id, Fraction = CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth, Duration = 0 })
	end

	PulseText({ Id = healthBackId, ScaleTarget = 1.25, ScaleDuration = 0.35, HoldDuration = 0.0, PulseBias = 0 })
end

function DisplayEnemyHealingText( victim, args )
	local objectId = victim.ObjectId
	local amount = args.ActualHealAmount
	local healthColor = Color.UpgradeGreen
	thread(PopOverheadText, {TargetId = objectId, Amount = amount, Text = "HealingAmount", Color = healthColor, SkipShadow = true })
end

function FirstTimeWeaponPickupPresentation( weaponKit )
	CreateAnimation({ Name = "HitSparkA", DestinationId = weaponKit.ObjectId })
	wait( 0.75 )
	ShakeScreen({ Speed = 1000, Distance = 8, Duration = 0.3 })
	AdjustColorGrading({ Name = "Team02", Duration = 0.2 })
	CreateAnimation({ Name = "ItemGet_Weapon", DestinationId = weaponKit.ObjectId, Scale = 2.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.2 }, } )
	--wait( 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	wait(0.1)
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 40107 })
	local playerKitAnimation = weaponKit.FirstTimeEquipAnimation
	SetAnimation({ Name = playerKitAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	if weaponKit.FirstTimeEquipSound ~= nil then
		PlaySound({ Name = weaponKit.FirstTimeEquipSound })
	end
end

function BiomeTimerAboutToExpirePresentation( threshold )
	if CheckCooldown( "BiomeTimerAboutToExpire", 60 ) then
		-- Pulse Timer
		PlaySound({ Name = "/SFX/ThanatosEntranceSound" })
		thread( PlayVoiceLines, HeroVoiceLines.BiomeTimerAboutToExpireVoiceLines, true )
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "BiomeTimerAboutToExpire", Duration = 1.3, PreDelay = 0.2, ShadowScaleX = 1.5, LuaKey = "TempTextData", LuaValue = { TimeLeft = threshold } } )
	end
end

function ChaosTimerAboutToExpirePresentation( threshold )
	if CheckCooldown( "ChaosTimerAboutToExpire", 60 ) then
		PlaySound({ Name = "/SFX/ThanatosEntranceSound" })
		--thread( PlayVoiceLines, HeroVoiceLines.BiomeTimerAboutToExpireVoiceLines, true )
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosTimerAboutToExpire", Duration = 1.3, PreDelay = 0.2, ShadowScaleX = 1.3, LuaKey = "TempTextData", LuaValue = { TimeLeft = threshold } } )
	end
end

function TimedBuffExpiredPresentation( traitData )
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "TimedKeepsakeExpired", Duration = 1.45, PreDelay = 0.2, ShadowScaleX = 1.3, LuaKey = "TempTextData", LuaValue = { TimeLeft = threshold } } )
end

function TemporaryHealExpirationPresentation()
	waitUnmodified( 0.25 )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "TemporaryHealExpirationTrait_Triggered", Duration = 1.45 } )
	CreateAnimation({ Name = "HealConsumableFx", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/StaminaSkillProc", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.UsedHealDropVoiceLines, true )
end

function BiomeTimerExpiredPresentation()

	AdjustColorGrading({ Name = "Thanatos", Duration = 0.5 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.5 })
	ShakeScreen({ Distance = 7, Speed = 400, FalloffSpeed = 2000, Duration = 0.5 })
	PlaySound({ Name = "/SFX/ThanatosEntranceSound" })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "BiomeTimerExpired", Duration = 1.3, PreDelay = 0.2, ShadowScaleX = 1.4 } )
	thread( PlayVoiceLines, HeroVoiceLines.BiomeTimerExpiredVoiceLines, true )

	thread( function()
		wait( 1.0 )
		AdjustColorGrading({ Name = "Off", Duration = 3.0, })
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.5, })
	end )
end

function SpeedKeepsakeActivatedPresentation ( traitData )
	thread( InCombatTextArgs, { ShadowScaleX = 2.0, TargetId = CurrentRun.Hero.ObjectId, Text = "SpeedKeepsakeActivated", Duration = 1.3, PreDelay = 0.2, LuaKey = "TempTextData", LuaValue = traitData } )
	TraitUIActivateTrait( traitData )
end

function SpeedKeepsakeExpiredPresentation()
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "SpeedKeepsakeExpired", Duration = 1.3, PreDelay = 0.2 } )
end

function RefundKeepsakeExpiredPresentation( sourceTrait )
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.KeepsakeExpiredVoiceLines, true )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ManaKeepsakeExpired", Duration = 1.3, PreDelay = 0.2 } )
end


function LowHealthCritKeepsakeExpiredPresentation( sourceTrait )
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.KeepsakeExpiredVoiceLines, true )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "LowHealthCritKeepsakeExpired", Duration = 1.3, PreDelay = 0.2 } )
end

function DoorHealKeepsakeExpiredPresentation( sourceTrait )
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.KeepsakeExpiredVoiceLines, true )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "DoorHealReserveKeepsakeExpired", Duration = 1.3, PreDelay = 0.2 } )			
end

function DiminishingDodgeExpiredPresentation()
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "DiminishingDodgeExpired", Duration = 1.3, PreDelay = 0.2 } )
end

function BiomeDamagePresentation( damageAmount )

	thread( DisplayPlayerDamageText, { triggeredById = CurrentRun.Hero.ObjectId, UseCustomText = "BiomeTimerDamage", PercentMaxDealt = damageAmount/CurrentRun.Hero.MaxHealth, DamageAmount = damageAmount } )
	CreateAnimation({ Name = "ThanatosDeathsHead_Small", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	PlaySound({ Name = "/SFX/HeartPulsate1" })
	PlaySound({ Name = "/SFX/HeartPulsate2", Delay = 0.35 })

end

OnAutoUseFailed{
	function( triggerArgs )
		if not triggerArgs.OnCooldown then
			AutoUseFailedPresentation( triggerArgs.TriggeredByTable, triggerArgs.UserId )
		end
	end
}

function AutoUseFailedPresentation( useTarget, userId )

	if useTarget == nil or SessionMapState.HandlingDeath then
		return
	end
	PlaySound({ Name = useTarget.CannotUseSound or "/Leftovers/SFX/OutOfAmmo", Id = useTarget.ObjectId })
	if CheckCooldown( "AutoUseFailed", 1 ) then
		thread( InCombatText, userId, useTarget.CannotUseText, 0.75 )
	end
end

function RelationshipChangedPresentation( entryName, sourceIds, finalGiftLevel )
	local hiddenIconId = nil
	local componentIds = ShallowCopyTable(sourceIds)
	if not IsGiftBarCompletelyUnlocked( entryName ) then
		hiddenIconId = componentIds[finalGiftLevel + 2]
	end
	if hiddenIconId then
		SetAlpha({ Id = hiddenIconId, Fraction = 0, Duration = 0 })
	end
	wait( 0.5 )
	local postDivider = false
	
	for index, componentId in pairs(componentIds) do
		if GiftData[entryName][index] and GiftData[entryName][index].HeartDividerAfter then
			componentIds[index + 1] = nil
			break
		end
	end
	componentIds = CollapseTableOrdered(componentIds)
	for index, componentId in pairs(componentIds) do
		if index > finalGiftLevel then
			break
		end
		wait( 0.1)
		thread(RelationshipChangedIconPresentation, componentId, index, postDivider, index == finalGiftLevel )
		if GiftData[entryName][index] and GiftData[entryName][index].HeartDividerAfter then
			postDivider = true
		end
	end
	wait(0.1)
	if hiddenIconId then
		SetAlpha({ Id = hiddenIconId, Fraction = 1, Duration = 0.3 })
	end
end

function RelationshipChangedIconPresentation( componentId, index, postDivider, isFinal )
	local screen = ScreenData.Codex
	local scaleTarget = 1.3
	local dividerOffset = 0
	if postDivider then
		dividerOffset = 108
	end
	if isFinal then
		scaleTarget = 2
		CreateAnimation({ Name = "CodexFilledHeartShine", DestinationId = componentId, OffsetX = screen.BaseIconOffsetX + screen.SpacerX * index + dividerOffset })
	end
	if screen and screen.Components and screen.Components.RelationshipIcons and screen.Components.RelationshipIcons[index] then
		PlaySound({ Name = "/SFX/Menu Sounds/HeartsAddedCodex", Id = componentId })
		thread( PulseAnimation, { Id = componentId, StartGroup = "Combat_Menu_Overlay", TargetGroup = "Combat_Menu_TraitTray_Backing", ScaleTarget= scaleTarget, ScaleDuration = 0.3, HoldDuration = 0.3 })
	end
end


-- Utilities below

function RepulseFromObject( object, args )
	if object.IsInvisible then
		return
	end
	if not object.IgnoreInvincibubbleOnHit then
		CreateAnimation({ Name = object.InvincibubbleAnim or "Invincibubble", DestinationId = object.ObjectId, OffsetZ = args.OffsetZ, Scale = args.Scale })
	end
	CreateAnimation({ Name = "RadialNovaRepulsion", DestinationId = object.ObjectId, OffsetZ = args.OffsetZ, Scale = args.Scale or 0.65 })
	PlaySound({ Name = "/Leftovers/SFX/InvincibleOnHit", Id = object.ObjectId, ManagerCap = 36 })
	local playerAngle = GetPlayerAngle()
	ApplyForce({ Id = CurrentRun.Hero.ObjectId, Speed = args.Speed or 950, MaxSpeed = args.MaxSpeed or 950, Angle = playerAngle + 180 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.2 }, } )
	if args.VoiceLines ~= nil then
		thread( PlayVoiceLines, args.VoiceLines, true )
	end
	-- grip change to get the feel of sudden knockback
	SetThingProperty({ Property = "Grip", Value = 7000, DestinationId = CurrentRun.Hero.ObjectId, })
	ShakeScreen({ Speed = 1000, Distance = 8, Duration = 0.12 })
	AdjustRadialBlurDistance({ Fraction = 0.2, Duration = 0.002 })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = 0.002 })
	waitUnmodified( 0.1 )
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.06 })

	if args.Text ~= nil and CheckCooldown( "RepulseFromObject", 1.25 ) then
		thread( InCombatText, CurrentRun.Hero.ObjectId, args.Text, 1.5, { ShadowScaleX = args.ShadowScaleX } )
	end
	waitUnmodified( 0.10 )
	if not object.IgnoreInvincibubbleOnHit then
		StopAnimation({ Name = object.InvincibubbleAnim or "Invincibubble", DestinationId = object.ObjectId })
	end
	SetThingProperty({ Property = "Grip", Value = "Default", DestinationId = CurrentRun.Hero.ObjectId })
end

function ShowInvincibubbleOnObject( object, args )
	if object.IsInvisible then
		return
	end
	if object.ShowingInvincibubble then
		return
	end
	object.ShowingInvincibubble = true
	CreateAnimation({ Name = object.InvincibubbleAnim or "Invincibubble", DestinationId = object.ObjectId, OffsetZ = args.OffsetZ, Scale = args.Scale })
	PlaySound({ Name = "/Leftovers/SFX/InvincibleOnHit", Id = object.ObjectId })
	if args.Text ~= nil and CheckCooldown( "RepulseFromObject", 1.25 ) then
		thread( InCombatText, CurrentRun.Hero.ObjectId, args.Text, 1.5 )
	end
	waitUnmodified( 0.10 )
	StopAnimation({ Name = object.InvincibubbleAnim or "Invincibubble", DestinationId = object.ObjectId })
	object.ShowingInvincibubble = false
end

function PopOverheadText( args )
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if not args.TargetId and ( not CurrentRun or not CurrentRun.Hero ) then
		return
	end

	local objectId = args.TargetId or CurrentRun.Hero.ObjectId
	local amount = args.Amount
	local text = args.Text

	local randomOffsetX = RandomInt( -10, 10 )
	if args.NoRandomOffset then
		randomOffsetX = 0
	end
	local randomFontSize = RandomInt( 170, 180 )
	local offsetY = args.OffsetY or 0

	local roundedAmount = round( amount )
	if args.Delay then
		waitUnmodified( args.Delay )
	end

	local groupName = "Combat_Menu_Overlay"
	local textHold = SpawnObstacle({ Name = "InvisibleTargetNoTimeModifier", DestinationId = objectId, Group = groupName, OffsetX = randomOffsetX, OffsetY = -270 })
	local textAnchor = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", DestinationId = objectId, Group = groupName, OffsetX = 0, OffsetY = -190 })
	local textEnd = SpawnObstacle({ Name = "InvisibleTargetNoTimeModifier", DestinationId = objectId, Group = groupName, OffsetX = randomOffsetX, OffsetY = -200 })

	local color = args.Color

	local holdDuration = args.HoldDuration or 0

	CreateTextBox({
		Id = textAnchor, Text = text,
		Justification = "CENTER",
		ShadowBlur = 0, ShadowColor = {60,100,70,1}, ShadowOffset = {0, 5},
		OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
		Color = color,
		Font = "P22UndergroundSCMedium",
		FontSize = randomFontSize,
		OffsetY = (args.TextOffsetY or 20) + offsetY,
		OffsetX = 0,
		Scale = 0.6,
		ScaleTarget = 0.6,
		LuaKey = "TempTextData",
		LuaValue = args,
		AutoSetDataProperties = false,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	})

	if not args.SkipShadow then
		SetAnimation({  Name = args.ShadowAnimName or "InCombatTextShadow_Short", DestinationId = textAnchor, OffsetY = 10 + offsetY, Scale = args.ShadowScale or 0.6 })
	end

	waitUnmodified( 0.1 )
	SetColor({ Id = textAnchor, Color = Color.White, Duration = 0 })
	SetColor({ Id = textAnchor, Color = color, Duration = 0.4, EaseIn=0.99, EaseOut=1.0 })
	Move({ Id = textAnchor, DestinationId = textHold, Speed = 200, EaseIn = 0.99, EaseOut = 1.0, TimeModifierFraction = 0.0 })
	ModifyTextBox({ Id = textAnchor, ScaleTarget = 0.3, ScaleDuration = 0.2, AutoSetDataProperties = false, })
	waitUnmodified( 0.45 )
	Move({ Id = textAnchor, DestinationId = textEnd, Speed = 10, EaseIn = 0, EaseOut = 1.0, TimeModifierFraction = 0.0 })
	waitUnmodified( holdDuration )
	if not args.SkipShadow then
		SetAlpha({ Id = textAnchor, Fraction = 0.0, Duration = 0.4 })
	end
	waitUnmodified( 0.4 )
	Destroy({ Ids = { textAnchor, textHold, textEnd } })
end

function PulseText( args )
	if args.Id == nil and args.ScreenAnchorReference == nil then
		return
	end
	if args.ScaleOriginal == nil then
		args.ScaleOriginal = 1
	end
	if args.ScaleDuration == nil then
		args.ScaleDuration = 0.05
	end
	if args.PulseBias == nil then
		args.PulseBias = 0.5
	end

	-- ModifyTextBox ScaleDuration is actually seconds per 1 unit of scale
	local textBoxScaleDuration = args.ScaleDuration / (args.ScaleTarget - args.ScaleOriginal)
	local id = args.Id or ScreenAnchors[args.ScreenAnchorReference]
	ModifyTextBox({ Id = id, ScaleTarget = args.ScaleTarget, ScaleDuration = textBoxScaleDuration * args.PulseBias, AutoSetDataProperties = false, ColorTarget = args.Color, ColorDuration = args.StartColorDuration or 1.0, FadeTarget = 1, FadeDuration = 0 })
	waitUnmodified( (args.ScaleDuration * args.PulseBias) + args.HoldDuration, RoomThreadName )

	id = args.Id or ScreenAnchors[args.ScreenAnchorReference]
	ModifyTextBox({ Id = id, ScaleTarget = args.ScaleOriginal, ScaleDuration = args.ResetDuration or (textBoxScaleDuration * (1 - args.PulseBias)), AutoSetDataProperties = false, ColorTarget = args.OriginalColor, ColorDuration = args.EndColorDuration or 1.0, FadeTarget = 1, FadeDuration = 0 })
end

function PulseAnimation(args)
	if args.PulseBias == nil then
		args.PulseBias = 0.5
	end
	if args.StartGroup and args.TargetGroup then
		RemoveFromGroup({ Id = args.Id, Names = { args.StartGroup } })
		AddToGroup({ Id = args.Id, Name = args.TargetGroup, DrawGroup = true })
	end

	if args.ScaleTarget ~= nil then
		if args.ScaleOriginal == nil then
			args.ScaleOriginal = 1
		end
		SetScale({ Id = args.Id, Fraction = args.ScaleTarget, Duration = args.ScaleDuration * args.PulseBias})
		wait(args.ScaleDuration + args.HoldDuration)
		SetScale({ Id = args.Id, Fraction = args.ScaleOriginal, Duration = args.ScaleDuration * (1 - args.PulseBias)})
	else
		if args.ScaleOriginalX == nil then
			args.ScaleOriginalX = 1
		end

		if args.ScaleTargetX == nil then
			args.ScaleTargetX = args.ScaleOriginalX
		end

		if args.ScaleOriginalY == nil then
			args.ScaleOriginalY = 1
		end

		if args.ScaleTargetY == nil then
			args.ScaleTargetY = args.ScaleTargetY
		end
		SetScaleX({ Id = args.Id, Fraction = args.ScaleTargetX, Duration = args.ScaleDuration * args.PulseBias})
		SetScaleY({ Id = args.Id, Fraction = args.ScaleTargetY, Duration = args.ScaleDuration * args.PulseBias})
		wait(args.ScaleDuration + args.HoldDuration)
		SetScaleX({ Id = args.Id, Fraction = args.ScaleOriginalX, Duration = args.ScaleDuration * (1 - args.PulseBias)})
		SetScaleY({ Id = args.Id, Fraction = args.ScaleOriginalY, Duration = args.ScaleDuration * (1 - args.PulseBias)})
	end

	if args.StartGroup and args.TargetGroup then
		RemoveFromGroup({ Id = args.Id, Name = args.TargetGroup })
		AddToGroup({ Id = args.Id, Names = { args.StartGroup }, DrawGroup = true })
	end
end

function InteractBlockedByEnemiesPresentation( usee, args, user )
	RepulseFromObject( usee, { Text = "UseBlockedByEnemies", OffsetZ = -70, Scale = 0.65, VoiceLines = HeroVoiceLines.InteractionBlockedVoiceLines, ShadowScale = 0.66 } )
	CreateAnimation({ Name = "ShoutFlare", DestinationId = usee.ObjectId })
end

function GodLootPickupPresentation( loot, args )
	args = args or {}
	SetLightBarColor({ PlayerIndex = 1, Color = loot.LootColor })
	if not args.SkipSound then
		PlaySound({ Name = loot.PickupSound or "/SFX/Menu Sounds/GodBoonInteract" })
	end
end

function dumpA(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dumpA(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function LootPickupPresentation( loot )

	if loot.PickupVoiceLines then
		thread( PlayVoiceLines, loot.PickupVoiceLines, true )
	end

	local textLines = nil
	if loot.NextInteractLines ~= nil then
		textLines = loot.NextInteractLines
		loot.NextInteractLines = nil
	elseif loot.HasDuoBoon and loot.DuoPickupTextLines ~= nil and not CurrentRun.HadDuoConversation then
		textLines = GetRandomEligibleTextLines( loot, loot.DuoPickupTextLines, {} )
		if textLines ~= nil then
			CurrentRun.HadDuoConversation = true
			for _, line in ipairs(textLines) do
				LoadVoiceBank({ Name = line.Cue })
			end
		end
	elseif loot.BoughtFromShop and loot.BoughtTextLines ~= nil and not CurrentRun.HadBoughtLootConversation then
		CurrentRun.HadBoughtLootConversation = true
		textLines = GetRandomEligibleTextLines( loot, loot.BoughtTextLines, GetNarrativeDataValue( loot, "BoughtTextLinePriorities" ) )
	elseif CurrentRun.CurrentRoom.RejectedLootData ~= nil and CurrentRun.CurrentRoom.RejectedLootData.Name == loot.Name and loot.MakeUpTextLines ~= nil then
		textLines = GetRandomEligibleTextLines( loot, loot.MakeUpTextLines, {} )
	else
		textLines = GetRandomEligibleTextLines( loot, loot.InteractTextLineSets, GetNarrativeDataValue( loot, "InteractTextLinePriorities" ) )
	end
	
	if textLines ~= nil and not loot.BlockTextLines then
		PlayTextLines( loot, textLines, { ScreenArgs = { SkipCheckQuestStatus = true } } )
	else
		AddInputBlock({ Name = "LootPickupFunction" })
		local globalVoiceLines = GlobalVoiceLines[loot.PickupGlobalVoiceLines or "BoonUsedVoiceLines"]
		if globalVoiceLines ~= nil then
			thread( PlayVoiceLines, globalVoiceLines, true, loot )
		end
		local pickupFunctionName = loot.PickupFunctionName or "BoonInteractPresentation"
		if pickupFunctionName ~= nil then
			CallFunctionName( pickupFunctionName, loot, { PickupWait = 1.15 } )
		end
		RemoveInputBlock({ Name = "LootPickupFunction" })
	end
end

function StartedTextLinesPresentation( source, textLines )
	CallFunctionName( source.StartedTextLinesFunctionName, source, source.StartedTextLinesFunctionArgs )

	if textLines ~= nil and source.TextLinesPauseSingingFx then
		StopAnimation({ DestinationId = source.ObjectId, Name = source.SingingFx })
	end
	if CurrentHubRoom ~= nil and AmbientMusicId ~= nil then
		SetVolume({ Id = AmbientMusicId, Value = math.min( CurrentHubRoom.AmbientMusicVolume or 1.0, 0.5 ), Duration = 0.25 })
	end

	if source ~= nil and source.StartTextLinesAnimation and not textLines.IgnoreSourceStartEndAnimations then
		SetAnimation({ DestinationId = source.ObjectId, Name = source.StartTextLinesAnimation })
	end
	if source ~= nil and textLines.StartPartnerTextLinesAnimation and source.PartnerObjectId then
		SetAnimation({ DestinationId = source.PartnerObjectId, Name = textLines.StartPartnerTextLinesAnimation })
	end
	if source.StartTextLinesAngleTowardHero ~= nil and not textLines.IgnoreStartTextLinesAngleTowardHero then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end

	if source ~= nil and not source.TextLinesUseWeaponIdle then
		thread( PreNarrativeUnequipAnimation )
	end
	CreateDialogueBackground()
end

function CreateDialogueBackground( )
	ScreenAnchors.DialogueBackgroundId = CreateScreenObstacle({ Name = "DialogueBackground", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_Backing", ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
end

function FinishedTextLinesPresentation( source, textLines )
	CallFunctionName( source.FinishedTextLinesFunctionName, source, source.FinishedTextLinesFunctionArgs )
	if textLines ~= nil and source.TextLinesPauseSingingFx and AmbientMusicId ~= nil then
		CreateAnimation({ Name = source.SingingFx, DestinationId = source.ObjectId, OffsetX = source.SingingAnimOffsetX or source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
	end	
	if CurrentHubRoom ~= nil and AmbientMusicId ~= nil then
		SetVolume({ Id = AmbientMusicId, Value = CurrentHubRoom.AmbientMusicVolume or 1.0, Duration = 0.25 })
	end
	if source ~= nil and source.EndTextLinesAnimation and not textLines.IgnoreSourceStartEndAnimations then
		SetAnimation({ DestinationId = source.ObjectId, Name = source.EndTextLinesAnimation })
	end
	if source ~= nil and textLines.EndPartnerTextLinesAnimation and source.PartnerObjectId then
		SetAnimation({ DestinationId = source.PartnerObjectId, Name = textLines.EndPartnerTextLinesAnimation })
	end	
	if source ~= nil and source.EndTextLinesVfx and not textLines.IgnoreSourceStartEndAnimations then
		CreateAnimation({ Name = source.EndTextLinesVfx, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
	end
	if source ~= nil and source.EndTextLinesThreadedFunctionName and not textLines.IgnoreSourceEndTextLinesThreadedFunctionName then
		local threadedFunction = _G[source.EndTextLinesThreadedFunctionName]
		if threadedFunction ~= nil then
			thread( threadedFunction, source, source.EndTextLinesFunctionArgs, textLines )
		end
	end
	SetAnimation({ DestinationId = ScreenAnchors.DialogueBackgroundId, Name = "DialogueBackgroundOut" })

	wait( 0.1, RoomThreadName )
	Destroy({ Id = ScreenAnchors.DialogueBackgroundId })
end

function SurpriseNPCPresentation( source, args )

	if args.SourceId ~= nil then
		source = ActiveEnemies[args.SourceId]
	end

	local checkingMeterUnlock = GiftData[source.Name] and not IsGameStateEligible(CurrentRun, GiftData[source.Name].UnlockGameStateRequirements )

	AddInputBlock({ Name = "SurpriseNPCPresentation" })
	ToggleCombatControl( {"AdvancedTooltip"}, false, "SurpriseNPC" )

	killWaitUntilThreads( "ReattachCameraOnInput" )

	PlayVoiceLines( args.VoiceLines, false, source )
	wait( args.IntroWait or 0.4, RoomThreadName )

	AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	if not args.SkipPan then
		PanCamera({ Ids = args.PanIds or { source.ObjectId, CurrentRun.Hero.ObjectId }, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	end
	RemoveInputBlock({ Name = "SurpriseNPCPresentation" })

	if args.TextLineSet ~= nil then
		ProcessTextLines( source, args.TextLineSet )
		PlayRandomRemainingTextLines( source, args.TextLineSet )
	end

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	ToggleCombatControl( {"AdvancedTooltip"}, true, "SurpriseNPC")

	if checkingMeterUnlock and GiftData[source.Name] and IsGameStateEligible(CurrentRun, GiftData[source.Name].UnlockGameStateRequirements ) then
		thread( GiftTrackUnlockedPresentation, source.Name )
	end
end

GlobalVoiceLines = GlobalVoiceLines or {}


function PlayCharacterAnim( source, args )
	if args.UsePlayerSource ~= nil then
		source = CurrentRun.Hero
	end
	if source ~= nil then
		if args.AngleNPCToHero ~= nil then
			AngleNPCToHero( source )
		end
		wait( args.WaitTime or 0.25 )
		SetAnimation({ Name = args.Name, DestinationId = source.ObjectId })
	end

end

function PlayHecateTauntAnim( source, args )
	if source ~= nil then
		SetAnimation({ Name = "HecateHubPreFightTaunt", DestinationId = source.ObjectId })
		wait(0.5)
		ShakeScreen({ Speed = 500, Distance = 2, Duration = 0.3 })
	end
end



function PlayedMusicPlayerTrackPresentation( trackName )
	wait( 0.85, RoomThreadName )
	if not MusicPlayerTrackPaused then
		thread( PlayVoiceLines, GlobalVoiceLines.PlayedMusicTrackVoiceLines, true )
	end
end

GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.HotSpringsBathVoiceLines =
{
	{
		PreLineWait = 0.65,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Melinoe_0672", Text = "{#Emph}Hmm..." },
	}
}

function TimePassesPresentation( source, args )

	args = args or {}

	if args.TimeTicks then
		GardenTimeTick( { Ticks = args.TimeTicks, UpdatePlotPresentation = true, PanDuration = 0.0, SkipCameraPan = true, SkipSound = true, TickInterval = 0.0 } )
		CookTimeTick( { Ticks = args.TimeTicks, UpdatePresentation = true, TickInterval = 0.0, } )
		MailboxTimeTick( { Ticks = args.TimeTicks, UpdatePresentation = true, TickInterval = 0.0, } )
	end

	if args.GlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[args.GlobalVoiceLines] )
	end

	wait( args.PreTextWait or 1.0 )

	SetCameraClamp({ Ids = CurrentHubRoom.CameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })

	if not args.SkipAngleTowardTarget then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end

	if args.HeroAnim ~= nil then
		SetAnimation({ Name = args.HeroAnim, DestinationId = CurrentRun.Hero.ObjectId })
	end

	if args.IncludeFishingSFX ~= nil then
		thread( TimePassesFishingSFX, source, args )
	end

	thread( DisplayInfoBanner, nil, {
		--SupertitleText = "EasyModeUpgradedSupertitle",
		TitleText = args.Text or "LoungeIntermissionMessage",
		-- SubtitleText = args.Text,
		TextRevealSound = "/Leftovers/Menu Sounds/EmoteExcitement",
		Color = Color.Gold,
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = Color.White,
		TextOffsetY = 20,
		-- SubTextColor = {23, 255, 187, 255},
		-- Icon = EasyModeIcon,
		-- Duration = 4.35,
		-- IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "P22UndergroundSCMedium",
		Layer = "ScreenOverlay",
		AdditionalAnimation = "GodHoodRays",
		} )

	wait( args.PostTextWait or 5.0 )

	-- AdjustFullscreenBloom({ Name = "Menu", Duration = 0.5 })
	-- AdjustColorGrading({ Name = "Ascension", Duration = 0.5 })
	-- AdjustColorGrading({ Name = "Off", Duration = 5.0 })
	-- AdjustFullscreenBloom({ Name = "Off", Duration = 5.0 })

	wait( 1.0 )
end

function TimePassesFishingSFX( source, args )

	wait(1.5)
	PlaySound({ Name = "/Leftovers/SFX/FishSpawnSplash" })
	wait(0.5)
	PlaySound({ Name = "/SFX/Menu Sounds/Lounge_BeerBottleOpen" })
	wait(0.5)
	PlaySound({ Name = "/Leftovers/SFX/FishSpawnSplash" })
	wait(1.0)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	PlaySound({ Name = "/Leftovers/SFX/FishSpawnSplash" })
	wait(0.5)

end

function LoungeRevelryPresentation( source, args )

	args = args or {}

	if args.TimeTicks then
		GardenTimeTick( { Ticks = args.TimeTicks, UpdatePlotPresentation = true, PanDuration = 0.0, SkipCameraPan = true, SkipSound = true, TickInterval = 0.0 } )
		CookTimeTick( { Ticks = args.TimeTicks, UpdatePresentation = true, TickInterval = 0.0, } )
		MailboxTimeTick( { Ticks = args.TimeTicks, UpdatePresentation = true, TickInterval = 0.0, } )
	end

	local voiceLines =
	{
		ObjectType = "NPC_Moros_01",
		AllowTalkOverTextLines = true,
		-- @ hack
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_3353" },
			},
		},
		{ Cue = "/VO/Moros_0080", Text = "{#Emph}Haha! {#Prev}Yes it is." },
	}
	thread( PlayVoiceLines, voiceLines, false )

	wait(1.5)
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_GlassWithIce" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_BottleCork" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_BottlePour" })
	wait(1.0)
	PlaySound({ Name = args.Sound2 or "/EmptyCue" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)

	thread( DisplayInfoBanner, nil, {
		--SupertitleText = "EasyModeUpgradedSupertitle",
		TitleText = "LoungeIntermissionMessage",
		-- SubtitleText = args.Text,
		TextRevealSound = "/Leftovers/Menu Sounds/EmoteExcitement",
		Color = Color.Gold,
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = Color.White,
		TextOffsetY = 20,
		-- SubTextColor = {23, 255, 187, 255},
		-- Icon = EasyModeIcon,
		-- Duration = 4.35,
		-- IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "AlegreyaSansSCRegular",
		Layer = "ScreenOverlay",
		AdditionalAnimation = "GodHoodRays",
		} )

	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_GlassesClinking" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	PlaySound({ Name = args.Sound3 or "/EmptyCue" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	AdjustFullscreenBloom({ Name = "Menu", Duration = 0.3 })
	AdjustColorGrading({ Name = "Ascension", Duration = 0.3 })
	AdjustColorGrading({ Name = "Off", Duration = 5.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 5.0 })
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(1.0)

end

function IncreasedTraitLevelPresentation( traitNamesImproved, numStacks )
	numStacks = numStacks or 1
	local offsetY = 0
	for traitName in pairs( traitNamesImproved ) do
		local traitTitle = traitName
		if TraitData[traitName] then 
			traitTitle = GetTraitTooltipTitle(TraitData[traitName])
		end
		CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "MegaPom_CombatText", SkipRise = false, SkipFlash = true, ShadowScale = 0.66, Duration = 1.5, OffsetY = -100 + offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitTitle, Amount = numStacks }})
		PlaySound({ Name = "/SFX/PomegranateLevelUpSFX", DestinationId = CurrentRun.Hero.ObjectId })
		offsetY = offsetY - 60
		wait(0.75)
	end
end

function ChaosHammerPresentation( traitRemoved, traitsAdded )
	CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	if traitRemoved then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosAnvilRemove_CombatText", SkipRise = false, SkipFlash = false, ShadowScaleX = 1.5, Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Name = traitRemoved }})
		PlaySound({ Name = "/Leftovers/SFX/ScorePyreDousePoof", DestinationId = CurrentRun.Hero.ObjectId })
		wait(0.75)
	end
	local offsetY = -200
	for _, traitName in pairs( traitsAdded ) do
		PlaySound({ Name = "/SFX/WeaponUpgradeHammerPickup", DestinationId = CurrentRun.Hero.ObjectId })
		CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosAnvilAdd_CombatText", SkipRise = false, SkipFlash = false, ShadowScale = 0.75, OffsetY = offsetY, Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.75)
		offsetY = offsetY - 60
	end
end

function HestiaSacrificePresentation( removedTraitName )
	wait(1)
	CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	thread( PlayVoiceLines, GlobalVoiceLines.HestiaSacrificeVoiceLines )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosAnvilRemove_CombatText", SkipRise = false, SkipFlash = false, ShadowScaleX = 1.5, Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Name = removedTraitName }})
	PlaySound({ Name = "/Leftovers/SFX/ScorePyreDousePoof", DestinationId = CurrentRun.Hero.ObjectId })
end

function SuperSacrificePresentation( sacrificedGod, buffedGod, totalLevels )
	wait(1)
	local buffedGodData = LootData[buffedGod]
	local sacrifiedGodData = LootData[sacrificedGod]
	CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	thread( PlayVoiceLines, buffedGodData.RarityUpgradeVoiceLines, true )

	PlaySound({ Name = buffedGodData.SpawnSound or "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY", DestinationId = CurrentRun.Hero.ObjectId })

	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = buffedGodData.SuperSacrificeCombatText or "SuperSacrifice_CombatText", SkipRise = false, SkipFlash = false, ShadowScaleX = 1.33, Duration = 1.5, 
	LuaKey = "TempTextData", 
	LuaValue = { 
		Name = buffedGod,
		Amount = totalLevels,
	}})
end

function RandomStoreItemPresentation( itemData )

	thread( PlayVoiceLines, GlobalVoiceLines.PurchasedRandomItemVoiceLines, true )

	wait( 0.50 )
	--AdjustColorGrading({ Name = "Mythmaker", Duration = 0.3 })

	wait( 0.5 )

	-- PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })
	CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "RandomStoreItem_CombatText", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.5, LuaKey = "TempTextData", LuaValue = { Name = itemData.Name }})

	wait( 0.3 )
	--AdjustColorGrading({ Name = "None", Duration = 0 })
end

function StoreRewardRandomStackPresentation()

	-- CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	-- PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse", DestinationId = CurrentRun.Hero.ObjectId })

end

function IncreasedTraitRarityPresentation( traitNamesImproved, delay )
	wait( delay )
	local offsetY = -100
	for traitName in pairs( traitNamesImproved ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "RarityUpgraded_CombatText", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScale = 0.75, ShadowScaleX = 1.28, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.75)
		offsetY = offsetY - 60
	end
end

function AddedMetaUpgradePresentation( metaUpgradesAdded, delay )
	waitUnmodified( delay )
	local offsetY = 200
	local spacerX = 320
	local startX = (-spacerX * (TableLength(metaUpgradesAdded) + 1)) / 2
	for i, metaUpgradeName in pairs( metaUpgradesAdded ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread(ShowMetaUpgradeCard, metaUpgradeName, startX + spacerX * i, offsetY )
		waitUnmodified(0.25)
	end
end

function ShowMetaUpgradeCard(metaUpgradeName, x, y )
	local cardAnchorId = CreateScreenObstacle({ Name = "BlankObstacleNoTimeModifier", Group = "Overlay", X = ScreenCenterX  + x, Y = ScreenCenterY + y })
	thread( InCombatTextArgs, {
		ScreenSpace = true, 
		TargetId = cardAnchorId, 
		OffsetX = 100, 
		OffsetY = 150, 
		Group = "Overlay", 
		Text = "MetaUpgradeSelected_CombatText", 
		SkipRise = true, SkipFlash = false, 
		Duration = 2.5, ShadowScale = 0.75, 
		ShadowScaleX = 1.28, 
		LuaKey = "TempTextData", 
		LuaValue = { Name = metaUpgradeName }
	})
	CreateAnimation({ 
		Name = "MetaUpgradeCardFlip", 
		DestinationId = cardAnchorId,
		Group = "Combat_UI_Backing", 
		Scale = 1,
	})
	waitUnmodified(1.12)
	SetAnimation({ Name = MetaUpgradeCardData[metaUpgradeName].Image, DestinationId = cardAnchorId, Scale = 0.2775})
	waitUnmodified(1.5)
	SetAlpha({ Id = cardAnchorId, Duration = 0.2, Fraction = 0 })
	waitUnmodified(0.2)
	Destroy({ Id = cardAnchorId })
	waitUnmodified(0.2)
end


function ReducedTraitRarityPresentation( traitNamesDowngraded, delay )
	wait( delay )
	local offsetY = -100
	for traitName in pairs( traitNamesDowngraded ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "RarityDowngraded_CombatText", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScale = 0.75, ShadowScaleX = 1.28, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.75)
		offsetY = offsetY - 60
	end
end

function BoonGrantedPresentation( traitNamesImproved, delay )
	if delay then
		wait( delay )
	end
	local offsetY = -100
	for traitName in pairs( traitNamesImproved ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "BoonGranted_CombatText", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.35, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(1.5)
		offsetY = offsetY - 60
	end
end
function HarvestBoonTraitPresentation( traitNamesImproved, delay )
	if delay then
		wait( delay )
	end
	local offsetY = -100
	for traitName in pairs( traitNamesImproved ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "HarvestBoon_CombatText_Initial", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.35, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(1.5)
		offsetY = offsetY - 60
	end
end

function ChaosKeepsakeAcquiredPresentation( newTraitName )
	CreateAnimation({ Name = "ChaosShiftFx", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ChaosKeepsake_NewChoice", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.2, LuaKey = "TempTextData", 
	LuaValue = { NewName = newTraitName }})
end

function HammerKeepsakeAcquiredPresentation( newTraitName )
	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "HammerKeepsake_Acquire", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.2, LuaKey = "TempTextData", 
	LuaValue = { NewName = newTraitName }})
end
function RunStartHammerKeepsakeAcquiredPresentation()
	local traitData = nil
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.IsHammerTrait and trait.RemainingUses then
			traitData = trait
			break
		end
	end
	if traitData then
	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "HammerKeepsake_Acquire", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.2, LuaKey = "TempTextData", 
		LuaValue = { NewName = traitData.Name }})
	end
end

function HammerKeepsakeLostPresentation( traitName )
	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "HammerKeepsake_Lost", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.2, LuaKey = "TempTextData", 
	LuaValue = { Name = traitName }})
end

function RunStartChaosBlessingPresentation()
	for i,  trait in pairs(CurrentRun.Hero.Traits) do
		if trait.FromChaosKeepsake then
			ChaosKeepsakeAcquiredPresentation( trait.CustomTitle )
			return
		end
	end
end

function ChaosTransformationPresentation( oldTraitName, newTraitName )
	wait(0.5)
	if CheckCooldown( "ChaosBoonTransformed", 5 ) then

		LoadVoiceBanks({ Name = "Chaos" })
		CreateAnimation({ Name = "ChaosShiftFx", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
		-- CreateAnimation({ Name = "HermesShiftFx", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
		thread( PlayVoiceLines, HeroVoiceLines.TrialUpgradeTransformedVoiceLines, true )
		ShakeScreen({ Speed = 500, Distance = 4, Duration = 0.3 })

		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ChaosKeepsake_OldChoice", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.5, LuaKey = "TempTextData", 
		LuaValue = { OldName = oldTraitName }})

		wait(1.25)

		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ChaosKeepsake_NewChoice", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.5, LuaKey = "TempTextData", 
		LuaValue = { NewName = newTraitName }})

	end
end

function SetupElementalTraitUpdatedPresentation( activatedTraitNames, deactivatedTraitNames, upgradedTraitNames, downgradedTraitNames )
	UIScriptsDeferred.ElementalCountDirty = true
	if not UIScriptsDeferred.ElementalPresentationData  then
		UIScriptsDeferred.ElementalPresentationData = { Activated = ToLookup(activatedTraitNames), Deactivated = ToLookup(deactivatedTraitNames), Upgraded = ToLookup(upgradedTraitNames), Downgraded = ToLookup(downgradedTraitNames) }
		return
	end
	local traitCount = 0
	for i, name in pairs( activatedTraitNames ) do
		if UIScriptsDeferred.ElementalPresentationData.Deactivated[name] then
			UIScriptsDeferred.ElementalPresentationData.Deactivated[name] = nil
		else
			UIScriptsDeferred.ElementalPresentationData.Activated[name] = true
		end
	end
	for i, name in pairs( deactivatedTraitNames ) do
		if UIScriptsDeferred.ElementalPresentationData.Activated[name] then
			UIScriptsDeferred.ElementalPresentationData.Activated[name] = nil
		else
			UIScriptsDeferred.ElementalPresentationData.Deactivated[name] = true
		end
	end
	for i, name in pairs( upgradedTraitNames ) do
		if UIScriptsDeferred.ElementalPresentationData.Downgraded[name] then
			UIScriptsDeferred.ElementalPresentationData.Downgraded[name] = nil
		else
			UIScriptsDeferred.ElementalPresentationData.Upgraded[name] = true
		end
	end
	for i, name in pairs( downgradedTraitNames ) do
		if UIScriptsDeferred.ElementalPresentationData.Upgraded[name] then
			UIScriptsDeferred.ElementalPresentationData.Upgraded[name] = nil
		else
			UIScriptsDeferred.ElementalPresentationData.Downgraded[name] = true
		end
	end
end

function ElementalTraitUpdatedPresentationReal( )
	UIScriptsDeferred.ElementalCountDirty = false
	if not UIScriptsDeferred.ElementalPresentationData then
		return
	end

	if UIScriptsDeferred.ElementalPresentationData.Gained ~= nil then
		local traitName = UIScriptsDeferred.ElementalPresentationData.Gained
		PlaySound({ Name = TraitData[traitName].ElementGainSound, Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ElementGranted_CombatText", ShadowScaleX = 1.5, SkipRise = true, SkipFlash = false, Duration = 1.8, OffsetY = 80, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.5)
	end
	UIScriptsDeferred.ElementalPresentationData.Gained = nil

	local offsetY = -100

	for traitName in pairs( UIScriptsDeferred.ElementalPresentationData.Activated ) do
		PlaySound({ Name = "/SFX/WrathEndingWarning", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ElementalTraitActivated", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		thread( PlayVoiceLines, HeroVoiceLines.BoonActivatedVoiceLines, true )
		wait(0.75)
		offsetY = offsetY - 60
	end
	UIScriptsDeferred.ElementalPresentationData.Activated = {} 

	for traitName in pairs( UIScriptsDeferred.ElementalPresentationData.Deactivated ) do
		PlaySound({ Name = "/SFX/WrathOver2", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ElementalTraitDeactivated", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		thread( PlayVoiceLines, HeroVoiceLines.BoonDectivatedVoiceLines, true )
		wait(0.75)
		offsetY = offsetY - 60
	end
	UIScriptsDeferred.ElementalPresentationData.Deactivated = {} 
	for traitName in pairs( UIScriptsDeferred.ElementalPresentationData.Upgraded ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ElementalTraitUpgraded", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.75)
		offsetY = offsetY - 60
	end
	UIScriptsDeferred.ElementalPresentationData.Upgraded = {} 
	for traitName in pairs( UIScriptsDeferred.ElementalPresentationData.Downgraded ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ElementalTraitDowngraded", ShadowScaleX = 1.7, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.75)
		offsetY = offsetY - 60
	end
	UIScriptsDeferred.ElementalPresentationData.Downgraded = {} 
end

function GenericThankCharacterPresentation( npc, partner, textLinesPlayed, args )
	args = args or {}
	local heroId = CurrentRun.Hero.ObjectId
	FreezePlayerUnit( "GenericThankCharacterPresentation" )
	AngleTowardTarget({ Id = heroId, DestinationId = npc.ObjectId })
	wait(0.25)
	SetAnimation({ Name = "MelinoeSaluteToEquip", DestinationId = heroId })
	wait(0.25)
	thread( PlayVoiceLines, HeroVoiceLines.ThankingCharacterVoiceLines, true )
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })

	if args.CreateAnimation ~= nil then
		CreateAnimation({ Name = args.CreateAnimation, DestinationId = npc.ObjectId })
	end
	wait(0.1)
	UnfreezePlayerUnit( "GenericThankCharacterPresentation" )
end

function GiftPointRefundPresentation()

	wait(1.1)

	PlaySound({ Name = "/SFX/GiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId })
	AddResource( "GiftPoints", 1, "Item" )

end
function GiftPointRareRefundPresentation()

	wait(1.1)

	PlaySound({ Name = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY", Id = CurrentRun.Hero.ObjectId })
	AddResource( "GiftPointsRare", 1, "Item" )

end
function GiftPointEpicRefundPresentation()

	wait(1.1)

	PlaySound({ Name = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY", Id = CurrentRun.Hero.ObjectId })
	AddResource( "GiftPointsEpic", 1, "Item" )

end
function ResourceGiftedPresentation( args )

	args = args or {}
	wait( args.WaitTime or 1.1 )

	PlaySound({ Name = args.SoundName or "/Leftovers/World Sounds/Caravan Interior/SteamAcidForage", Id = CurrentRun.Hero.ObjectId })
	AddResource( args.ResourceName or "GiftPointsRare", args.ResourceAmount or 1, "Item" )
	if args.CheckSeedStatus then
		CheckSeedStatus()
	end

end
function ResourceGiftedInEventPresentation( source, args )

	args = args or {}
	wait(args.WaitTime or 1.1)

	PlaySound({ Name = args.SoundName or "/Leftovers/World Sounds/Caravan Interior/SteamAcidForage", Id = CurrentRun.Hero.ObjectId })
	AddResource( args.ResourceName or "GiftPointsRare", 1, "Item" )

end

function HadesGiftPointRefundPresentation()

	wait(1.1)

	PlaySound({ Name = "/SFX/GiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/GiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId, Delay = 0.4 })
	PlaySound({ Name = "/SFX/GiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId, Delay = 0.8 })
	AddResource( "GiftPoints", 5, "Item" )

end


function MaxedRelationshipPresentation( source, args )

	wait( args.Delay or 2.0 )

	DisplayInfoBanner( nil, {
		--SupertitleText = "EasyModeUpgradedSupertitle",
		TitleText = args.Title or "MaxedRelationship",
		FontScale = args.TitleTextScale or 1.0,
		SubtitleText = args.Text,
		TextRevealSound = args.TextRevealSound or "/Leftovers/Menu Sounds/EmoteAffection",
		TextOffsetY = args.TextOffsetY,
		Color = {0, 255, 168, 255},
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = args.TextColor or Color.White,
		SubTextColor = {23, 255, 187, 255},
		Icon = args.Icon,
		IconOffsetY = args.IconOffsetY or 6,
		IconScale = args.IconScale or 0.635,
		Duration = 4.35,
		IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "P22UndergroundSCMedium",
		Layer = "Combat_Menu_TraitTray_Overlay",
		AdditionalAnimation = "GodHoodRays",
		AnimationName = args.AnimationName or "LocationTextBGRelationship",
		AnimationOutName = args.AnimationOutName or "LocationTextBGRelationshipOut",
		} )

	if args.VoiceLines then
		thread( PlayVoiceLines, args.VoiceLines, true )
	end

	if args.DoHadesRefund then
		thread( HadesGiftPointRefundPresentation )
	end

end

--[[
function KeyAchievementPresentation( source, args )

	AddInputBlock({ Name = "KeyAchievementPresentation" })
	HideCombatUI("KeyAchievementPresentation")

	wait( args.Delay or 0.2 )

	PlaySound({ Name = args.Sound or "/Music/VictoryStinger" })

	thread( DisplayInfoBanner, nil, { Text = args.Title, Delay = 0.2, OffsetY = 0, Color = Color.White, FadeColor = Color.Gold, TextDelay = 2.5, Duration = 4, TextOffsetY = -180, AnimationName = "EndFrameIn", AnimationOutName = "EndFrameOut", Layer = "ScreenOverlay" } )

	wait( 7.3 )

	RemoveInputBlock({ Name = "KeyAchievementPresentation" })
	UnblockCombatUI("KeyAchievementPresentation")

end

function MatchModelToFirstLinePortrait( source, args )
	if source.NextInteractLines ~= nil then
		local firstLine = source.NextInteractLines[1]
		if firstLine.Portrait ~= nil then
			MatchModelToPortrait( source, { Portrait = firstLine.Portrait } )
			if args.Animations ~= nil then
				SetAnimation({ Name = args.Animations[firstLine.Portrait], DestinationId = source.ObjectId })
			end
		else
			if args.Animations ~= nil then
				SetAnimation({ Name = args.Animations.Default, DestinationId = source.ObjectId })
			end
		end
	end
end
]]

function TrackPlayer( source, args )
	while IsAlive({ Id = source.ObjectId }) do
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Duration = args.Duration, SetBase = args.SetBase, EaseIn = args.EaseIn, EaseOut = args.EaseOut, FollowFlips = args.FollowFlips })
		local interval = args.Interval
		if args.RandomIntervalMin ~= nil then
			interval = RandomFloat( args.RandomIntervalMin, args.RandomIntervalMax )
		end
		wait( interval )
	end
end

function MatchModelToPortrait( source, args, screen, line )
	args = args or {}
	local portraitData = source.PortraitData[args.Portrait or screen.CurrentPortrait]
	if portraitData == nil then
		return
	end
	if portraitData.Model ~= source.ActiveModel then
		source.ActiveModel = portraitData.Model
		SetThingProperty({ Property = "GrannyModel", Value = source.ActiveModel, DestinationId = source.ObjectId })
		SetThingProperty({ Property = "Graphic", Value = portraitData.Animation, DestinationId = source.ObjectId })
		if args.TransitionVfx ~= nil then
			CreateAnimation({ Name = args.TransitionVfx, DestinationId = source.ObjectId })
		end
	end
	SetAnimation({ Name = line.PostPortraitSetAnim or portraitData.Animation, DestinationId = source.ObjectId })
end

function PlayEmoteAnimFromSource( source, args, screen, line )

	if args.PowerWordPresentation ~= nil and args.PowerWordWaitTime ~= nil then
		thread( PowerWordPresentation, source, { WaitTime = args.PowerWordWaitTime }, screen, line )
	end

	wait( args.WaitTime, NarrativeThreadName )

	local newPortrait = args.Portrait

	if args.Portrait ~= nil then
		if screen.CurrentPortrait ~= nil and screen.CurrentPortrait ~= newPortrait then
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
			wait( line.PortraitExitWait or 0.3 )

			screen.CurrentPortrait = newPortrait
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait })
			if source.OnPortraitSetFunctionName ~= nil then
				local lineCopy = ShallowCopyTable( line )
				lineCopy.PostPortraitSetAnim = nil -- Never want to re-use this for a mid-line portrait switch
				CallFunctionName( source.OnPortraitSetFunctionName, source, source.OnPortraitSetFunctionArgs, screen, lineCopy )
			end
		end
	end

	if args.Anim ~= nil then
		local targetId = args.AnimTarget or source.ObjectId
		if args.AnimTarget == "Hero" then
			targetId = CurrentRun.Hero.ObjectId
		end
		SetAnimation({ Name = args.Anim, DestinationId = targetId })
	end

	if args.DoShake then
		Flash({ Id = screen.PortraitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5, ExpireAfterCycle = true })
		Shake({ Id = screen.PortraitId, Distance = 5, Speed = 600, Duration = 1.0, FalloffSpeed = 2000, })
	end

	if args.DoFlash then

		AdjustColorGrading({ Name = "Team02", Duration = 0.1 })
		AdjustFullscreenBloom({ Name = "NewType07", Duration = 0.1 })

		wait(0.3)
		PlaySound({ Name = "/SFX/Player Sounds/ZagreusGuanYuSpearSpin"  })

		AdjustColorGrading({ Name = "Off", Duration = 0.75 })
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.75 })

	end

	if args.Emote ~= "None" then
		CreateAnimation({ Name = args.Emote, DestinationId = screen.PortraitId, OffsetX = source.EmoteOffsetX, OffsetY = source.EmoteOffsetY })
	end

	wait( args.WaitTime2, NarrativeThreadName )

	local newPortrait2 = args.Portrait2
	if args.Portrait2 ~= nil then
		if screen.CurrentPortrait ~= nil and screen.CurrentPortrait ~= newPortrait2 then
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
			wait( line.PortraitExitWait or 0.3 )

			screen.CurrentPortrait = newPortrait2
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait })
		end
	end

	if args.Anim2 ~= nil then
		local targetId = args.AnimTarget or source.ObjectId
		if args.AnimTarget == "Hero" then
			targetId = CurrentRun.Hero.ObjectId
		end
		SetAnimation({ Name = args.Anim2, DestinationId = targetId })
	end

	if args.DoShake2 then
		Flash({ Id = screen.PortraitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5, ExpireAfterCycle = true })
		Shake({ Id = screen.PortraitId, Distance = 5, Speed = 600, Duration = 1.0, FalloffSpeed = 2000, })
	end

	if args.DoFlash2 then

		AdjustColorGrading({ Name = "Team02", Duration = 0.1 })
		AdjustFullscreenBloom({ Name = "NewType07", Duration = 0.1 })

		wait(0.3)
		PlaySound({ Name = "/SFX/Player Sounds/ZagreusGuanYuSpearSpin"  })

		AdjustColorGrading({ Name = "Off", Duration = 0.75 })
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.75 })

	end

	if args.Emote2 ~= nil and args.Emote2 ~= "None" then
		CreateAnimation({ Name = args.Emote2, DestinationId = screen.PortraitId, OffsetX = source.EmoteOffsetX, OffsetY = source.EmoteOffsetY })
	end
end

function PowerWordPresentation( source, args, screen, line )

	wait( args.WaitTime, NarrativeThreadName )

	Flash({ Id = screen.PortraitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5, ExpireAfterCycle = true })
	Shake({ Id = screen.PortraitId, Distance = 2, Speed = 200, Duration = 1.0, Angle = 0 })

	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuOpenREMEMBRANCE" })
	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "NewType07", Duration = 0.1 })

	ShakeScreen({ Speed = 900, Distance = 8, FalloffSpeed = 2000, Duration = 1.05 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 1.0 }, } )
	wait(0.5)
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	AdjustColorGrading({ Name = "Off", Duration = 3.0 })

end

-- copied from LegendaryAspectPresentation()
function PowerWordPresentationWorld( source, args )

	args = args or {}
	wait( args.WaitTime or 0 )

	AdjustColorGrading({ Name = "WeaponKitInteract", Duration = 0.2 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweep"  })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	local interactVignette = CreateAnimation({ Name = "WeaponKitInteractVignette", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = interactVignette })

	--local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	--DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColorInvert", Group = "FX_Add_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	wait( 2.4 )

	AdjustColorGrading({ Name = "Off", Duration = 0.8 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.8 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 1.0 )

end

function MagicWordPresentation( source, args, screen, line )
	args = args or {}

	thread( PlayInteractAnimation, source.ObjectId )

	wait( args.StartWait, NarrativeThreadName )

	local newPortrait = args.Portrait

	if args.Portrait ~= nil then
		if screen.CurrentPortrait ~= nil and screen.CurrentPortrait ~= newPortrait then
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
			wait( line.PortraitExitWait or 0.3 )

			screen.CurrentPortrait = newPortrait
			if screen.CurrentContextArt ~= nil then
				SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait })
			end
			if source.OnPortraitSetFunctionName ~= nil then
				local lineCopy = ShallowCopyTable( line )
				lineCopy.PostPortraitSetAnim = nil -- Never want to re-use this for a mid-line portrait switch
				CallFunctionName( source.OnPortraitSetFunctionName, source, source.OnPortraitSetFunctionArgs, screen, lineCopy )
			end
		end
	end

	if args.SetBoonAnimation then
		SetAnimation({ Name = "MelinoeBoonInteract", DestinationId = CurrentRun.Hero.ObjectId })
	end

	Flash({ Id = screen.PortraitId, Speed = 0.85, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.White, Duration = 0.5, ExpireAfterCycle = true })

	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })

	-- AudioState.MagicSoundId = PlaySound({ Name = "/Leftovers/Ambience/StarPickerAmbienceLoop" })

	wait( args.EndWait, NarrativeThreadName )

	-- SetVolume({ Id = AudioState.MagicSoundId, Value = 0.0, Duration = 0.5 })
	-- AudioState.MagicSoundId = nil

	Flash({ Id = screen.PortraitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5, ExpireAfterCycle = true })
	Shake({ Id = screen.PortraitId, Distance = 2, Speed = 200, Duration = 1.0, Angle = 0 })

	PlaySound({ Name = "/Leftovers/SFX/GoalScored" })
	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "NewType07", Duration = 0.1 })

	ShakeScreen({ Speed = 900, Distance = 8, FalloffSpeed = 2000, Duration = 1.05 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 1.0 }, } )
	wait(0.5)
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	AdjustColorGrading({ Name = "Off", Duration = 3.0 })


end

function DoraReturnToHaunting( source, args )

	if CurrentRun.EventState[source.ObjectId] ~= nil then
		-- Already running
		return
	end

	if source.InPartnerConversation then
		return
	end

	CurrentRun.EventState[source.ObjectId] = { FunctionName = "DoraReturnToHaunting", Args = args }

	while true do

		wait( RandomFloat( args.RandomWaitMin, args.RandomWaitMax ), RoomThreadName )

		local notifyName = "DoraReturnToHaunting"
		NotifyOutsideDistanceAll({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, Distance = args.OutsideDistance, Notify = notifyName })
		waitUntil( notifyName )

		-- Back to Haunting
		SetAnimation({ Name = args.OutsideAnimationsForModel[source.ActiveModel], DestinationId = source.ObjectId })
		-- CreateAnimation({ Name = args.OutsideVfx, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
		thread( PlayVoiceLines, GlobalVoiceLines[args.OutsideGlobalVoiceLines], true )
		wait( 2.0, RoomThreadName )

		notifyName = "DoraAppear"
		NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { source.ObjectId }, Distance = args.InsideDistance, Notify = notifyName })
		waitUntil( notifyName )

		-- Appearance
		SetAnimation({ Name = args.InsideAnimationsForModel[source.ActiveModel], DestinationId = source.ObjectId })
		-- StopAnimation({ Name = args.OutsideVfx, DestinationId = source.ObjectId })
		-- CreateAnimation({ Name = args.InsideVfx, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
		thread( PlayVoiceLines, GlobalVoiceLines[args.InsideGlobalVoiceLines], true )
		Flash({ Id = source.ObjectId, Speed = 1, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.White, ExpireAfterCycle = true })
		Shake({ Id = source.ObjectId, Distance = 3, Speed = 150, Duration = 0.65 })

	end
end

function DoraTeleportExit( source, args )

	args = args or {}

	local modelAnims = source.AnimationsForModel.Dora_Disappear
	local anim = modelAnims[source.ActiveModel]

	SetAnimation({ Name = anim, DestinationId = source.ObjectId })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.35 })

	source.NextInteractLines = nil
	source.SpecialInteractFunctionName = nil
	UseableOff({ Id = source.ObjectId })
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )

	wait( 0.5, RoomThreadName )

	source.Mute = true

end

function HypnosReturnToSleep( source, args )

	if CurrentRun.EventState[source.ObjectId] ~= nil then
		-- Already running
		return
	end

	if GameState.TextLinesRecord.ThanatosWithHypnos06 then
		if args.LowChanceToPlay ~= nil and not RandomChance( args.LowChanceToPlay ) then
			return
		end
	else
		if args.HighChanceToPlay ~= nil and not RandomChance( args.HighChanceToPlay ) then
			return
		end
	end

	CurrentRun.EventState[source.ObjectId] = { FunctionName = "HypnosReturnToSleep", Args = args }

	while true do

		wait( RandomFloat( args.RandomWaitMin, args.RandomWaitMax ), RoomThreadName )

		local notifyName = "HypnosReturnToSleep"
		NotifyOutsideDistanceAll({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, Distance = args.OutsideDistance, Notify = notifyName })
		waitUntil( notifyName )

		-- Back to Sleep
		SetAnimation({ Name = args.OutsideAnimation, DestinationId = source.ObjectId })
		CreateAnimation({ Name = args.OutsideVfx, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
		thread( PlayVoiceLines, GlobalVoiceLines[args.OutsideGlobalVoiceLines], true )
		wait( 2.0, RoomThreadName )

		SetAnimation({ Name = args.OutsideAnimation, DestinationId = source.ObjectId })

		notifyName = "HypnosWakeup"
		NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { source.ObjectId }, Distance = args.InsideDistance, Notify = notifyName })
		waitUntil( notifyName )

		-- Wakeup
		SetAnimation({ Name = args.InsideAnimation, DestinationId = source.ObjectId })
		StopAnimation({ Name = args.OutsideVfx, DestinationId = source.ObjectId })
		CreateAnimation({ Name = args.InsideVfx, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
		thread( PlayVoiceLines, GlobalVoiceLines[args.InsideGlobalVoiceLines], true )
		Flash({ Id = source.ObjectId, Speed = 1, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.White, ExpireAfterCycle = true })
		Shake({ Id = source.ObjectId, Distance = 3, Speed = 150, Duration = 0.65 })

	end
end

function WretchedBrokerReaction( args )
	PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = 558096 })
	thread( PlayEmoteSimple, source, { TargetId = 558096, AnimationName = "StatusIconSmile", OffsetZ = 140 })
end

function LearnedSageReaction( args )
	PlaySound({ Name = "/SFX/GhostEmotes/EmbarrassedTINY", Id = 589466 })
	thread( PlayEmoteSimple, source, { TargetId = 589466, AnimationName = "StatusIconSmile", OffsetZ = 150 })
end

function RecordKeeperReaction( args )
	PlaySound({ Name = "/SFX/GhostEmotes/SmileTINY", Id = 589467 })
	thread( PlayEmoteSimple, source, { TargetId = 589467, AnimationName = "StatusIconOhBoy", OffsetZ = 50 })
end

function FrogFamiliarReaction( args )
	SetAnimation({ Name = "Familiar_Frog_Greet", DestinationId = 566831 })
	PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = 566831 })
end

function PlayEmoteSimple( source, args, originalArgs )

	args = args or {}
	wait( args.Delay or 0, RoomThreadName )

	local targetId = args.TargetId or source.ObjectId
	if args.UseOriginalSource and originalArgs ~= nil and originalArgs.OriginalSource ~= nil then
		targetId = originalArgs.OriginalSource.ObjectId
	end
	local duration = RandomFloat( args.DurationMin or 1, args.DurationMax or 2 )

	if args.ChanceToPlay ~= nil then
		if not RandomChance( args.ChanceToPlay ) then
			args.FirstFailedRequirement = "ChanceToPlay = "..args.ChanceToPlay
			return false
		end
	end

	local animName = args.AnimationName or GetRandomValue( args.AnimationNames )

	CreateAnimation({ Name = animName, DestinationId = targetId, Group = "Combat_UI_World", OffsetZ = args.OffsetZ })
	if args.Sound ~= nil then
		PlaySound({ Name = args.Sound, Id = targetId })
	end
	if args.AngleTowardHeroDuration ~= nil then
		AngleTowardTarget({ Id = targetId, DestinationId = CurrentRun.Hero.ObjectId, Duration = args.AngleTowardHeroDuration, EaseIn = 0.5, EaseOut = 0.5, })
	end
	if args.ShakeSpeed ~= nil then
		Shake({ Id = targetId, Speed = args.ShakeSpeed, Distance = args.ShakeDistance or 1.25, Duration = duration })
	end
	wait( duration, RoomThreadName )

	-- Clean up
	StopAnimation({ Name = animName, DestinationId = targetId, Group = "Combat_UI_World" })
	CreateAnimation({ Name = animName.."_End", DestinationId = targetId, Group = "Combat_UI_World", OffsetZ = args.OffsetZ })

end

function PlayEmote( args )
	args.TargetId = args.TargetId or args.Target.ObjectId
	args.Target = args.Target or MapState.ActiveObstacles[args.TargetId]
	if args.Target == nil or args.Target.Emotes == nil then
		-- Too many PlayEmote calls are made with no data right now
		--DebugAssert({ Condition = false, Text = "PlayEmote Target data does not exist" })
		return
	end

	local emoteData = args.Target.Emotes[args.EmoteName] or {}
	local animationName = args.AnimationName or emoteData.AnimationName
	local soundName = args.SoundName or emoteData.SoundName

	if animationName == nil then
		return
	end

	local delay = RandomFloat( args.delayMin or 0.1, args.DelayMax or 0.4 )
	local duration = RandomFloat( args.DurationMin or 1, args.DurationMax or 2 )

	wait( delay, RoomThreadName )

	if MapState.ActiveObstacles[args.TargetId] == nil then
		return
	end

	CreateAnimation({ Name = animationName, DestinationId = args.TargetId, Group = "Combat_UI_World", OffsetZ = args.OffsetZ or args.Target.EmoteOffsetZ })
	if args.PlaySound and soundName ~= nil then
		PlaySound({ Name = soundName, Id = args.TargetId })
	end
	if args.Shake then
		Shake({ Id = args.TargetId, Speed = 150, Distance = 1.25, Duration = duration })
	end

	-- Clean up
	wait( duration, RoomThreadName )
	if MapState.ActiveObstacles[args.TargetId] == nil then
		return
	end
	StopAnimation({ Name = animationName, DestinationId = args.TargetId, Group = "Combat_UI_World" })
	CreateAnimation({ Name = animationName.."_End", DestinationId = args.TargetId, Group = "Combat_UI_World", OffsetZ = args.OffsetZ or args.Target.EmoteOffsetZ })
end

function GenericPresentation( source, args )

	args = args or {}
	if args.InputBlock ~= nil then
		AddInputBlock({ Name = args.InputBlock })
	end
	wait( args.PreWait )

	if args.OverwriteSourceKeys ~= nil then
		for key, value in pairs( args.OverwriteSourceKeys ) do
			source[key] = value
		end
	end

	if args.SetModel ~= nil then
		source.ActiveModel = args.SetModel
		SetThingProperty({ Property = "GrannyModel", Value = source.ActiveModel, DestinationId = source.ObjectId })
	end
	if args.ThingProperties ~= nil then
		for key, value in pairs( args.ThingProperties ) do
			SetThingProperty({ Property = key, Value = value, DestinationId = source.ObjectId })
		end
	end

	if args.AddToGroup ~= nil then
		AddToGroup({ Id = source.ObjectId, Name = args.AddToGroup })
	end

	if args.SetAnimation ~= nil then
		local speedMultiplier = nil
		if args.AnimationSpeedMultiplierMin ~= nil and args.AnimationSpeedMultiplierMax ~= nil then
			speedMultiplier = RandomFloat( args.AnimationSpeedMultiplierMin, args.AnimationSpeedMultiplierMax )
		end
		SetAnimation({ Name = args.SetAnimation, DestinationId = source.ObjectId, SpeedMultiplier = speedMultiplier })
	end
	if args.PlaySpeed ~= nil or args.PlaySpeedMin ~= nil then
		SetAnimationSpeedMultiplier({ DestinationId = source.ObjectId, PlaySpeed = args.PlaySpeed or RandomFloat( args.PlaySpeedMin, args.PlaySpeedMax ) })
	end

	if args.StopStatusAnimation then
		StopCurrentStatusAnimation( source )
	end

	if args.CreateAnimation ~= nil then
		CreateAnimation({ Name = args.CreateAnimation, DestinationId = source.ObjectId })
	end

	if args.Sound ~= nil then
		PlaySound({ Name = args.Sound, Id = source.ObjectId })
	end

	if args.FadeOutIds ~= nil then
		SetAlpha({ Ids = args.FadeOutIds, Fraction = 0.0, Duration = args.Duration or 0.3 })
	end
	if args.SetAlpha ~= nil then
		SetAlpha({ Id = args.Id or source.ObjectId, Ids = args.Ids, Fraction = args.SetAlpha, Duration = args.Duration })
	end
	if args.AlphaMin ~= nil and args.AlphaMax ~= nil then
		local fraction = RandomFloat( args.AlphaMin, args.AlphaMax )
		SetAlpha({ Id = source.ObjectId, Fraction = fraction, Duration = args.Duration })
	end
	if args.ScaleMin ~= nil and args.ScaleMax ~= nil then
		local fraction = RandomFloat( args.ScaleMin, args.ScaleMax )
		SetScale({ Id = source.ObjectId, Fraction = fraction, Duration = args.Duration })
	end

	if args.Color ~= nil then
		SetColor({ Id = args.Id or source.ObjectId, Ids = args.Ids, Color = args.Color, Duration = args.Duration, SetBase = args.SetBase })
	end

	if args.UseableOff then
		UseableOff({ Id = args.Id or source.ObjectId })
	end
	if args.UseableOn then
		UseableOn({ Id = args.Id or source.ObjectId })
	end
	if args.UseableOffIds ~= nil then
		UseableOff({ Ids = args.UseableOffIds })
	end
	if args.UseableOnIds ~= nil then
		UseableOn({ Ids = args.UseableOnIds })
	end

	if args.AddInteractBlock ~= nil then
		AddInteractBlock( source, args.AddInteractBlock )
	end
	if args.RemoveInteractBlock ~= nil then
		RemoveInteractBlock( source, args.RemoveInteractBlock )
	end

	if args.ActivateIds ~= nil then
		Activate({ Ids = args.ActivateIds })
	end

	if args.AngleTowardTarget ~= nil then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = args.AngleTowardTarget })
	end
	if args.AngleTowardHero ~= nil then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if args.AngleHeroTowardSource ~= nil then
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
	end
	if args.SetAngle ~= nil then
		SetAngle({ Id = source.ObjectId, Angle = args.SetAngle })
	end
	
	if args.SetUntargetable then
		SetUntargetable({ Id = source.ObjectId })
	end

	if args.SetSoundCueValues ~= nil then
		for i, paramData in ipairs( args.SetSoundCueValues ) do
			SetSoundCueValue({ Names = { paramData.Name, }, Id = AudioState[paramData.AudioStateId], Value = paramData.Value, Duration = paramData.Duration })
		end
	end
	if args.EndMusic then
		EndMusic( AudioState.MusicId, AudioState.MusicName )
	end

	if args.VoiceLines ~= nil then
		PlayVoiceLines( args.VoiceLines, true, source )
	end
	if args.ThreadedVoiceLines ~= nil then
		thread( PlayVoiceLines, args.ThreadedVoiceLines, true, source )
	end
	if args.SourceThreadedVoiceLines ~= nil then
		thread( PlayVoiceLines, source[args.SourceThreadedVoiceLines], true )
	end

	if args.CheckTextLinesStatusAnimation and source.NextInteractLines ~= nil and source.NextInteractLines.StatusAnimation then
		PlayStatusAnimation( source, { Animation = source.NextInteractLines.StatusAnimation } )
	end

	if args.ApplyEffectOnHero ~= nil then
		if args.ApplyEffectOnHeroProperties ~= nil then
			ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = source.ObjectId, EffectName = args.ApplyEffectOnHero, DataProperties = args.ApplyEffectOnHeroProperties })
		else
			ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = source.ObjectId, EffectName = args.ApplyEffectOnHero })
		end
	end

	if args.KillTaggedThread ~= nil then
		killTaggedThreads( args.KillTaggedThread )
	end

	if args.InputBlock ~= nil then
		RemoveInputBlock({ Name = args.InputBlock })
	end

	if args.EndFunctionName ~= nil then
		CallFunctionName( args.EndFunctionName, source, args.EndFunctionArgs )
	end

end

function UnwrapLootPresentation( reward )

	thread( PlayVoiceLines, reward.BlindBoxOpenedVoiceLines, true )

	--[[
	if CoinFlip() then
		thread( PlayVoiceLines, reward.BlindBoxOpenedVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.UnwrappedLootVoiceLines, true )
	end


	thread( PlayVoiceLines, GlobalVoiceLines.UnwrappedLootVoiceLines, true )

	wait( 0.5 )

	thread( PlayVoiceLines, reward.BlindBoxOpenedVoiceLines, true )

	wait( 2.5 )
	]]--

end

function AddKeepsakeChargePresentation( traitData )
	local existingUITrait = GetExistingUITrait( traitData )
	if existingUITrait then
		CreateAnimation({ Name = "NewTraitHighlight", DestinationId = existingUITrait.AnchorId })
	end
end

function CheckSpawnNearIdPresentation(spawnNearId, spawnedId)
	local obstacleData = MapState.ActiveObstacles[spawnNearId]
	if obstacleData ~= nil then
		if obstacleData.CreateAnimationBetween ~= nil then
			CreateAnimationsBetween({ Animation = obstacleData.CreateAnimationBetween, DestinationId = spawnedId, Id = spawnNearId,
									  Length = GetDistance({ Id = spawnNearId, DestinationId = spawnedId }), Stretch = true, UseZLocation = false, Group = "FX_Standing_Add" })
		end
	end
end

function CheckSpawnNearIdEndPresentation(spawnNearId)
	wait(0.5)

	if MapState.ActiveObstacles[spawnNearId] ~= nil and MapState.ActiveObstacles[spawnNearId].ProximitySpawnTriggerEndAnimation ~= nil then
		SetAnimation({ DestinationId = spawnNearId, Name = MapState.ActiveObstacles[spawnNearId].ProximitySpawnTriggerEndAnimation })
	end
end

GlobalVoiceLines.SkellyHitQuestCompleteVoiceLines =
{
	PreLineWait = 0.4,
	Queue = "Interrupt",
	RecheckRequirementsPostWait = true,
	RequiresSourceAlive = true,
	GameStateRequirements =
	{
		-- None
	},
	ObjectType = "NPC_Skelly_01",

	-- All right that's enough! Unless you want to keep going?
	{ Cue = "/VO/Skelly_0004", Text = "All right that's enough! Unless you want to keep going?" },
}

function SkellyHitQuestCompletePresentation( victim )
	thread( PlayVoiceLines, GlobalVoiceLines.SkellyHitQuestCompleteVoiceLines, nil, victim )
end

function StartTimeSlowPresentation( duration )
	PlaySound({ Name = "/SFX/TimeSlowStart" })
	duration = duration or 0.3
	-- AdjustColorGrading({ Name = "TimeStopB", Duration = duration })
	AdjustFullscreenBloom({ Name = "TimeStopBloom", Duration = duration })
	AdjustRadialBlurDistance({ Fraction = 0.05, Duration = duration })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = duration })

	if ScreenAnchors.TimeStopVignette ~= nil then
		return
	end
	ScreenAnchors.TimeStopVignette = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY, })
	SetAnimation({ Name = "TimeStopFx", DestinationId = ScreenAnchors.TimeStopVignette })

end
function EndTimeSlowPresentation()
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.3 })
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
	SetAlpha({ Id = ScreenAnchors.TimeStopVignette, Fraction = 0.0, Duration = 0.3 })
	wait(0.3) 
	Destroy({ Id = ScreenAnchors.TimeStopVignette })
	ScreenAnchors.TimeStopVignette = nil
end


function StartSpellSlowPresentation()
	thread( PlayVoiceLines, GlobalVoiceLines.ChronosSpellResistVoiceLines, true )
	local duration = 0.25
	SetAudioEffectState({ Name = "SpellCharge", Value = 1 })
	-- AdjustFullscreenBloom({ Name = "MoonDustBloom", Duration = duration })
	AdjustColorGrading({ Name = "MoonDust", Duration = duration })
	AdjustRadialBlurDistance({ Fraction = 0.05, Duration = duration })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = duration })
	CreateAnimation({ Name = "SpellSlowFx", DestinationId = CurrentRun.Hero.ObjectId })
end

function SpellSlowWarnPresentation()
	PlaySound({ Name = "/SFX/HexEndingWarning", Id = CurrentRun.Hero.ObjectId })
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.5, Color = Color.White,  ExpireAfterCycle = true })
end

function EndSpellSlowPresentation()
	SetAudioEffectState({ Name = "SpellCharge", Value = 0 })
	PlaySound({ Name = "/SFX/Player Sounds/TimeSlowEnd" })
end

function MultipleEncounterStartPresentation(encounter, currentRun)
	if encounter.RoomChanges ~= nil then
		if encounter.RoomChanges.CameraClamps ~= nil then
			SetCameraClamp({ Ids = encounter.RoomChanges.CameraClamps })
		end

		if encounter.RoomChanges.ZoomFraction ~= nil then
			AdjustZoom({ Fraction = encounter.RoomChanges.ZoomFraction, LerpTime = 1.0 })
		end

		if encounter.RoomChanges.ActivateObstacles ~= nil then
			Activate({ Ids = encounter.RoomChanges.ActivateObstacles })
		end

		if encounter.RoomChanges.DeactivateObstacles ~= nil then
			SetAlpha({ Ids = encounter.RoomChanges.DeactivateObstacles, Fraction = 0.0, Duration = 1.5 })
		end

		if encounter.RoomChanges.DestroyObstacles ~= nil then
			Destroy({ Ids = encounter.RoomChanges.DestroyObstacles })
		end

		if encounter.RoomChanges.ResetRoomSpawnPoints then
			CurrentRun.CurrentRoom.SpawnPoints = {}
			MapState.SpawnPoints = GetIds({ Name = "SpawnPoints" })
		end
	end
	wait(2.0, RoomThreadName)
end

function NHubBossDoorExitPresentation(doorId, exitDoor)

	AddInputBlock({ Name = "ExitingEphyraHub" })

	AdjustColorGrading({ Name = "Thanatos", Duration = 0.5 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.5 })
	ShakeScreen({ Distance = 7, Speed = 400, FalloffSpeed = 2000, Duration = 0.5 })

	wait( 0.5, RoomThreadName )

	-- thread( PlayVoiceLines, GlobalVoiceLines.ExitEphyraHubVoiceLines )

	local room = CurrentRun.CurrentRoom

	LockCamera({ Id = cameraId, Duration = 1.25, EaseIn = 0.04, EaseOut = 0.275, Duration = 10 })

	-- FadeOut({ Color = Color.White, Duration = 2 })

	wait( 1.5 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.5 })
	AdjustColorGrading({ Name = "Off", Duration = 3.0 })		

	wait(0.5)

	RemoveInputBlock({ Name = "ExitingEphyraHub" })

end

function CollectRemainingMercenariesPresentation()
	wait(0.20)
	PlaySound({ Id = CurrentRun.Hero.ObjectId, Name = "/VO/Melinoe_0275" })
	wait(1.8)
end

function EncounterStartInvulnerableWarnPresentation()
	PlaySound({ Name = "/SFX/HexEndingWarning", Id = CurrentRun.Hero.ObjectId })
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.5, Color = Color.White,  ExpireAfterCycle = true })
end

function StartBlinkTrailPresentation()
	local initialId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing" })
	local blinkIds = { initialId }
	local blinkAnimationIds = {}
	local nextClipRegenTime  = GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponBlink", Property = "NextClipRegenTime" }) or 0
	local waitPeriod = nextClipRegenTime + (GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponBlink", Property = "BlinkDuration" }) or 0) - 0.08
	local startTime = _worldTime
	local maxTrailLength = 99 

	MapState.BlinkDropTrail = MapState.BlinkDropTrail or {}
	MapState.BlinkDropTrail[initialId] = blinkIds
	while MapState.BlinkDropTrail and MapState.BlinkDropTrail[initialId] and (_worldTime - startTime) < waitPeriod do
		wait (0.0666, "BlinkTrailPresentation")
		local distance = GetDistance({ Id = blinkIds [#blinkIds], DestinationId = CurrentRun.Hero.ObjectId })
		if distance > 0 then
			local targetId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing" })
			table.insert( blinkIds, targetId )
			CreateAnimationsBetween({ Animation = "BlinkTrailFxIn", DestinationId = blinkIds [#blinkIds], Id = blinkIds [#blinkIds - 1], Stretch = true, UseZLocation = false, Group = "Standing", SetAnimation = true, MatchOwnerToAnimation = true})
			if TableLength(blinkIds) > maxTrailLength then
				local lastItemId = table.remove( blinkIds, 1 )
				SetAnimation({ Name = "BlinkTrailFxOut", DestinationId = lastItemId, CopyFromPrev = true })
				thread(DestroyOnDelay, { lastItemId }, 0.09 )
			end
		end
	end
	if MapState.BlinkDropTrail then
		MapState.BlinkDropTrail[ initialId ] = nil
	end
	local lastItemId = table.remove( blinkIds )
	Destroy({Id = lastItemId})
	local outDuration = 0.16 -- time to remove trail over
	local waitInterval = outDuration/#blinkIds
	local minWaitInterval = 0.06
	local skipInterval = 1
	local skipCounter = 0
	if waitInterval < minWaitInterval then
		local multiplier = math.ceil(minWaitInterval/waitInterval)
		waitInterval = waitInterval * multiplier
		skipInterval = multiplier
	end

	local finalAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing" })
	Attach({ Id = finalAnchor, DestinationId = CurrentRun.Hero.ObjectId })
	if GetDistance({ Id = finalAnchor, DestinationId = CurrentRun.Hero.ObjectId }) > 0 then
		CreateAnimationsBetween({ Animation = "BlinkTrailFxIn", DestinationId = blinkIds [#blinkIds - 1], Id = finalAnchor, Stretch = true, UseZLocation = false, Group = "Standing", SetAnimation = true, MatchOwnerToAnimation = true})
	end
	while not IsEmpty( blinkIds ) do
		while skipCounter < skipInterval do
			local lastItemId = table.remove( blinkIds, 1 )
			SetAnimation({ Name = "BlinkTrailFxOut", DestinationId = lastItemId, CopyFromPrev = true })
			thread(DestroyOnDelay, { lastItemId }, 0.1 )
			skipCounter = skipCounter + 1
		end
		skipCounter = 0
		wait( waitInterval, "BlinkTrailPresentation")
	end
	Destroy({ Id = finalAnchor })
end

function TerminateBlinkTrail()
	if IsEmpty(MapState.BlinkDropTrial) then
		return
	end
	for id, ids in pairs(MapState.BlinkDropTrail) do	
		Destroy({ Ids = ids })
	end
	MapState.BlinkDropTrail = {}
	killTaggedThreads("BlinkTrailPresentation")
end

function UpgradeBoonRarityPresentation( button )
	CreateAnimation({ Name = "BoonEntranceDuo", Scale = 1.21, OffsetX = 40, DestinationId = button.Id })

	if CurrentLootData.RarityUpgradeVoiceLines ~= nil then
		thread( PlayVoiceLines, CurrentLootData.RarityUpgradeVoiceLines, true )
	end
end

function OnionTransformationPresentation( source )
	Shake({ Id = source.ObjectId, Distance = 2, Speed = 300, Duration = 2, FalloffSpeed = 3000 })
	wait(2)
end

function PreDamagePresentation( enemy, damageAmount, damageData )
	LoadVoiceBank({ Name = "Odysseus"})
	thread( DisplayDamageText, enemy, { DamageAmount = damageAmount, SourceProjectile = "Keepsake" } )
	PlaySound({ Name = "/SFX/StabSplatter", Id = enemy.ObjectId })
	--CreateAnimation({ Name = "ZeusLightningIris", DestinationId = enemy.ObjectId })
	if damageData.VoiceLines and damageData.VoiceLines ~= "null" then
		thread( PlayVoiceLines, damageData.VoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.OdysseusLaughVoiceLines, true )
	end
	local text = damageData.Text or "PreDamageHit"
	if enemy.UseGroupHealthBar and CurrentRun.CurrentRoom.Encounter ~= nil then
		thread( InCombatTextArgs, { TargetId = EnemyHealthDisplayAnchors[CurrentRun.CurrentRoom.Encounter.Name], OffsetY = 0, SkipRise = true, ScreenSpace = true, Group = "Overlay", Text = text, Duration = 1.5 } )
	elseif EnemyHealthDisplayAnchors[enemy.ObjectId] then
		thread( InCombatTextArgs, { TargetId = EnemyHealthDisplayAnchors[enemy.ObjectId], OffsetY = 0, SkipRise = true, ScreenSpace = true, Group = "Overlay", Text = text, Duration = 1.5 } )
	end
end

function HadesPreDamagePresentation( enemy, damageAmount, damageData )
	LoadVoiceBanks({ Name = "Hades" })
	CreateAnimation({ Name = "HadesSymbolShatter", DestinationId = enemy.ObjectId, SpeedMultiplier = 2.0 })

	if damageData.VoiceLines and damageData.VoiceLines ~= "null" then
		thread( PlayVoiceLines, damageData.VoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.HadesCurseVoiceLines, true )
	end

	waitUnmodified( 0.9 )

	AddSimSpeedChange( "PreDamageHadesPresentation", { Fraction = 0.04, LerpTime = 0.05, Priority = true } )
	waitUnmodified( 0.65 )
	local text = damageData.Text or "PreDamageHit"
	thread( InCombatTextArgs, { TargetId = enemy.ObjectId, OffsetY = -350, Text = text, Duration = 1.0 } )
	thread( DisplayDamageText, enemy, { DamageAmount = damageAmount, SourceProjectile = "Keepsake" } )
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/Hades360Swipe", Id = enemy.ObjectId })

	waitUnmodified( 0.35 )
	RemoveSimSpeedChange( "PreDamageHadesPresentation", { LerpTime = 0.04 } )
end

function DaggerFinalHitPresentation( text, amount )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = text, Duration = 0.5, OffsetY = -140 })
	CreateAnimation({ Name = "SuperStartFlare", DestinationId = CurrentRun.Hero.ObjectId })
end

function StaffHealPresentation( text )
	--thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = text, Duration = 0.5, OffsetY = -140 })
end

function ManaTraitGainedPresentation ( traitName )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = traitName, Duration = 0.5, OffsetY = -140 })
	CreateAnimation({ Name = "SuperStartFlare", DestinationId = CurrentRun.Hero.ObjectId })
end

function SprintShieldTriggeredPresentation()
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "HitShields", Duration = 1.0 } )
	PlaySound({ Name = "/SFX/EurydiceKeepsakeProc", Id = CurrentRun.Hero.ObjectId })
end


function BossShieldTriggeredPresentation()
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "HitShields", Duration = 1.0 } )
	PlaySound({ Name = "/SFX/EurydiceKeepsakeProc", Id = CurrentRun.Hero.ObjectId })
end

function ExShieldTriggeredPresentation()
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "HitShields", Duration = 1.0 } )
	PlaySound({ Name = "/SFX/EurydiceKeepsakeProc", Id = CurrentRun.Hero.ObjectId })
end

function HitShieldTriggeredPresentation()
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "HitShields", Duration = 1.0 } )
	PlaySound({ Name = "/SFX/EurydiceKeepsakeProc", Id = CurrentRun.Hero.ObjectId })
end

function DaggerBlockTriggeredPresentation( functionArgs )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "RiposteHit", Duration = 1.0, ShadowScaleX = 0.7 } )

	CreateAnimation({ Name = "HephMassiveHitDark", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteAttackingStaff", Id = CurrentRun.Hero.ObjectId })

	CreateAnimation({ Name = functionArgs.ActivatedVfx, DestinationId = CurrentRun.Hero.ObjectId })			
end

function DaggerBlockClearedPresentation( functionArgs )
	StopAnimation({ Name = functionArgs.ActivatedVfx, DestinationId = CurrentRun.Hero.ObjectId })
end

function DaggerBlockActivePresentation( traitData, reloadTime )
	wait(reloadTime, RoomThreadName )
	if not CurrentRun.Hero.IsDead then
		PlaySound({ Name = "/SFX/Menu Sounds/KeepsakeArtemisArrow", Id = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/SFX/Menu Sounds/MenuMagicFlashLong", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "RiposteCooldown", Duration = 1.0, ShadowScaleX = 0.7 } )
		if ScreenAnchors.DaggerUI then
			SetAnimation({ Name = "StaffReloadTimerReady", SuppressSounds = true, DestinationId = ScreenAnchors.DaggerUI, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
		end
	end
end

function PerfectChargeRefundPresentation()
	-- thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "StaffRefund", Duration = 1.0 } )
	-- PlaySound({ Name = "/Leftovers/SFX/PositiveTalismanProc_1", Id = CurrentRun.Hero.ObjectId })
end

function PlayerArmorBreakPresentation( traitData )

	thread( PlayerArmorBreakSimSpeed )

	local offsetY = -155
	CreateAnimations({
		DestinationId = CurrentRun.Hero.ObjectId,
		Anims =
		{
			{ Name = "StatusIconVulnerableArmorShatter", OffsetX = -50, OffsetY = offsetY },
			{ Name = "HealthBarArmorShatter", OffsetY = offsetY - 35 },
			{ Name = "ArmorBreak" }
		}
	})
	local promptId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI_World", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = offsetY })
	SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = promptId})
	Attach({ Id = promptId, DestinationId = CurrentRun.Hero.ObjectId, OffsetY = offsetY })
	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof", Id = CurrentRun.Hero.ObjectId, ManagerCap = 36 })
	thread( PlayVoiceLines, GlobalVoiceLines.CostumeDestroyedVoiceLines, true )
	CreateTextBox({	Id = promptId, Text = "ArmorBreak", Justification = "CENTER",
		ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		Font = "LatoBoldItalic", FontSize = 18, Color = {255,255,255,255},
		CharacterFadeTime = 0, CharacterFadeInterval = 0, Group = "Combat_UI_World",
		AutoSetDataProperties = false,
		ScaleTarget = 6.2, ScaleDuration = 10,
		})
	Move({ Id = promptId, Distance = 100, Angle = 0, Duration = 1, EaseOut = 1 })

	CreateAnimation({ Name = "ItemGet_Weapon", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.7 })
	waitUnmodified(1.0)
	ModifyTextBox({ Id = promptId, FadeTarget = 0.0, FadeDuration = 0.4, ColorTarget = {1, 0, 0, 1}, ColorDuration = 0.5, AutoSetDataProperties = false })
	waitUnmodified(1.0)
	DestroyTextBox({ Id = promptId })
	if traitData then
		thread( TraitSacrificedPresentation, traitData)
	end
end

function PlayerArmorBreakSimSpeed( )
	wait( 0.1 )
	AddSimSpeedChange( "PlayerArmorBreak", { Fraction = 0.05, LerpTime = 0.05, Priority = true } )
	waitUnmodified( 0.6 )
	RemoveSimSpeedChange( "PlayerArmorBreak", { LerpTime = 0.05 } )
end

function RaiseDeadPresentation( newEnemy )
	PlaySound({ Name = "/SFX/Menu Sounds/LegendaryBoonShimmer2", Id = newEnemy.ObjectId })
	CreateAnimation({ Name = "SorcerySummonPresentationFx", DestinationId = newEnemy.ObjectId })
	thread( InCombatText, newEnemy.ObjectId, "RaiseDeadActivated", 1.2, { PreDelay = 0.5, ShadowScaleX = 1.0 })
end

function BonusHealthAndManaPresentation( bonusHealth, bonusMana )
	CreateAnimation({ Name = "HealthSparkleShower", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/PlayerProjectileDeflect", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "MaxHealthAndManaIncrease", 0.9, { ShadowScaleX = 0.6, LuaKey = "TooltipData", LuaValue = {TooltipHealth = bonusHealth, TooltipMana = bonusMana }} )
end

function BonusManaPresentation( bonusMana )
	CreateAnimation({ Name = "HealthSparkleShower", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/PlayerProjectileDeflect", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "PostEncounterMaxManaIncrease", 0.9, { ShadowScaleX = 0.6, LuaKey = "TooltipData", LuaValue = { TooltipMana = bonusMana }} )
end

function ClearCastChargedPresentation()
	if ScreenAnchors.StaffUI then
		CreateAnimation({Name = "KeepsakeLevelUpFlare", DestinationId = ScreenAnchors.StaffUI, GroupName = "Overlay"})
		SetAnimation({Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.StaffUI })
	end
end

function StartClearCastPresentation( duration )
	if ScreenAnchors.StaffUI and duration then
		CreateAnimation({Name = "ErisPowerUpFx", DestinationId = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup", Id = CurrentRun.Hero.ObjectId})
		thread( InCombatTextArgs, { TargetId = ScreenAnchors.StaffUI, Text = "Hint_StaffClearCastBuff", Duration = 3.0, ShadowScaleX = 0.8, OffsetX = 0, OffsetY = -65, ScreenSpace = true, SkipRise = true })
		thread( DrainClearCastMeter, duration )
		--thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "Hint_StaffClearCastBuff", Duration = 2.0, ShadowScaleX = 0.8, OffsetX = 20 })
	end
end

function DrainClearCastMeter( duration )
	SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.StaffUIChargeAmount, PlaySpeed = 100 / duration })
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.StaffUIChargeAmount, Fraction = 0 })
end
function EndClearCastPresentation()
	if ScreenAnchors.StaffUI then
		SetAnimation({ Name = "StaffReloadTimerOut", DestinationId = ScreenAnchors.StaffUI})
	end
	
	StopAnimation({Name = "ErisPowerUpFx", DestinationId = CurrentRun.Hero.ObjectId })
end

function PerfectDamageBoonRenewed()
	PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup", Id = CurrentRun.Hero.ObjectId})
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "PerfectDamageBonusBoon_Triggered", Duration = 1.45, PreDelay = 0.1, LuaKey = "TempTextData", LuaValue = { TimeLeft = threshold } } )
end

function PerfectDamageBoonExpire()
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "PerfectDamageBonusBoon_Expired", Duration = 1.45, PreDelay = 0.1, LuaKey = "TempTextData", LuaValue = { TimeLeft = threshold } } )
end
function MedeaCursePreChoicePresentation( source, args )
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1.0, Duration = 1.0 })
end

function OncePerMenuRarifyPresentation( button, baseColor )
	waitUnmodified(1, "RarifyPulse")
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitementShort", Id = button.Id })
	PulseText({ Id = button.Id, Color = Color.BoonPatchRare, OriginalColor = Color.ContextActionLabel, ScaleTarget = 1.25, ScaleDuration = 0.2, HoldDuration = 0.1, StartColorDuration = 0.1, EndColorDuration = 2, ResetDuration = 4.0 })
	waitUnmodified(4, "RarifyPulse")
	ContinuousRarifyPresentation( button, baseColor )
end

function ContinuousRarifyPresentation( button, baseColor )
	while button and button.Screen and button.Screen.KeepOpen do
		waitUnmodified(1.0)
		if button.Visible then
			SetAnimation({ Name = "SkillProcFeedbackFx", DestinationId = button.Id, GroupName = "ScreenOverlay", OffsetX = -150 })
			PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitementShort", Id = button.Id })
			PulseText({ Id = button.Id, Color = Color.BoonPatchRare, OriginalColor = Color.ContextActionLabel, ScaleTarget = 1.25, ScaleDuration = 0.2, HoldDuration = 0.1, StartColorDuration = 0.1, EndColorDuration = 2, ResetDuration = 4.0 })
		end
		waitUnmodified(4.0, "RarifyPulse")	
	end
end

function SetPlayerFade( args )
	args = args or {}
	args.Flag = args.Flag or "Generic"
	args.Fraction = args.Fraction or 0
	args.Duration = args.Duration or 0.3
	
	MapState.PlayerAlphaFlags = MapState.PlayerAlphaFlags or {}
	MapState.PlayerAlphaFlags[args.Flag] = args.Fraction
	local lowestVisible = 1
	for flag, fraction in pairs( MapState.PlayerAlphaFlags ) do
		lowestVisible = math.min( lowestVisible, fraction )
	end

	if lowestVisible == args.Fraction then
		SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = args.Fraction, Duration = args.Duration })
	end
end

function ClearPlayerFade( flag, duration )
	duration = duration or 0.3

	MapState.PlayerAlphaFlags = MapState.PlayerAlphaFlags or {}
	MapState.PlayerAlphaFlags[flag] = nil

	local lowestVisible = 1
	for flag, fraction in pairs( MapState.PlayerAlphaFlags ) do
		lowestVisible = math.min( lowestVisible, fraction )
	end

	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = lowestVisible, Duration = duration })
end



function PermafyShopItemPresentation( itemName )

	wait( 0.45 )

	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })
	local toastAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu_Additive" })
	DrawScreenRelative({ Id = toastAnchor })
	CreateAnimation({ Name = "BiomeStateGoldFx", DestinationId = toastAnchor, OffsetX = 0, OffsetY = 0, Group = "Combat_Menu_Additive" })
	thread( InCombatTextArgs, { TargetId = toastAnchor, Text = "PermafySuccess", SkipRise = true, PreDelay = 0.05, Duration = 1.75, ShadowScaleX = 1.3, OffsetX = ScreenCenterX, OffsetY = -390, Group = "Combat_Menu_Additive",
	Justification = "Center", FontSize = 30, LuaKey = "TempTextData", LuaValue = { Name = itemName }})
	wait( 1.0 )
end

function DoubleBoonPresentation( screen, nextButton )
	wait( 0.05 )

	LoadVoiceBanks({ Name = "Echo" })
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })
	thread( PlayVoiceLines, GlobalVoiceLines.EchoKeepsakeLines, true )
	CreateAnimation({ Name = "BiomeStateGoldFx", DestinationId = nextButton.Id, OffsetX = 0, OffsetY = 0, Group = "Combat_Menu_Additive" })
	thread( InCombatTextArgs, { TargetId = nextButton.Id, Text = "DoubleBoonSuccess", ScreenSpace = true, SkipRise = true, PreDelay = 0.05, Duration = 1.0, OffsetX = 0, OffsetY = 0, Group = "Combat_Menu_Additive", Justification = "Center", FontSize = 30 })
	Flash({ Id = nextButton.Id, Duration = 1.0, Speed = 1, MinFraction = 0, MaxFraction = 0.7, Color = Color.White, })
	wait( 1.0 )
	Flash({ Id = nextButton.Id, Duration = 1.0, Speed = 1, MinFraction = 0, MaxFraction = 0.4, Color = Color.White, })
	wait( 1.0 )
	Flash({ Id = nextButton.Id, Duration = 1.0, Speed = 1, MinFraction = 0, MaxFraction = 0.2, Color = Color.White, })
	wait( 0.8 )
end
function DoubleRewardPresentation( objectId )
	LoadVoiceBank({ Name = "Poseidon" })
	CreateAnimation({ Name = "PoseidonElementalKnockupFxAlt", DestinationId = objectId })
	ApplyUpwardForce({ Id = objectId, Speed = RandomFloat( 500, 700 ) })
	ApplyForce({ Id = objectId, Speed = RandomFloat( 75, 260 ), Angle = RandomFloat( 0, 360 ) })
	wait( 0.75 )
	thread( PlayVoiceLines, GlobalVoiceLines.PoseidonCheerVoiceLines )

	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })
	local toastAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu_Additive" })
	DrawScreenRelative({ Id = toastAnchor })
	CreateAnimation({ Name = "BiomeStateGoldFx", DestinationId = toastAnchor, OffsetX = 0, OffsetY = 0, Group = "Combat_Menu_Additive" })
	thread( InCombatText, objectId, "Hint_DoubleItem", 0.75 )
end

function ConvertMetaRewardPresentation( sourceDrop )

	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })
	PlayInteractAnimation( sourceDrop.ObjectId )

	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.66 })

	thread( PlayVoiceLines, HeroVoiceLines.UsedTransformVoiceLines, true )

	wait(0.5)

	AdjustColorGrading({ Name = "None", Duration = 0 })
	AdjustFullscreenBloom({ Name = "NewType06", Duration = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1, })
	AdjustColorGrading({ Name = "Off", Duration = 1.0 })

	thread( PlayVoiceLines, HeroVoiceLines.RerollOutcomeVoiceLines )

end

function HouseFrontDoorUsedPresentation( usee, args, user )

	UseableOff({ Id = 711873 }) -- ChronosBossDoor
	HideCombatUI( "HouseFrontDoorUsedPresentation" )
	AddInputBlock({ Name = "HouseFrontDoorUsedPresentation" })

	Stop({ Id = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = -280, Duration = 11.5, Retarget = true })

	wait(0.05)

	thread( PlayVoiceLines, GlobalVoiceLines.RoomOpeningMainDoorVoiceLines, true )

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })

	wait(2.6)
	local loopingSoundId = PlaySound({ Name = "/SFX/Menu Sounds/CauldronWhispers", Id = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Melinoe_Gesture_ToWeaponless", DestinationId = CurrentRun.Hero.ObjectId })

	CreateAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "CWEntranceHadesSymbolInFail", DestinationId = 714708, OffsetZ = 220 })

	wait( 1.7 )

	wait( 2.0 )

	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = CurrentRun.Hero.ObjectId })
	StopSound({ Id = loopingSoundId, Duration = 0.4 })
	loopingSoundId = nil

	StopAnimation({ Name = "CWEntranceHadesSymbolLoopFail", DestinationId = 714708 })

	wait( 0.4 )

	PlaySound({ Name = "/SFX/PillarDestroyedBIG" })
	Shake({ Id = 711873, Duration = 1.0, Distance = 3, Speed = 300 })
	ShakeScreen({ Distance = 8, Speed = 500, Duration = 1.0, FalloffSpeed = 1000 })
	StopAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 1.15 )

	SetAnimation({ Name = "MelinoeIdleWeaponless", DestinationId = CurrentRun.Hero.ObjectId })

	wait(1.5)

	SetAnimation({ Name = "Charon_Fierce", DestinationId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Charon_01" }) })

	wait(3.5)

	MapState.RoomRequiredObjects[711873] = nil
	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	end

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25, })

	ShowCombatUI( "HouseFrontDoorUsedPresentation" )
	RemoveInputBlock({ Name = "HouseFrontDoorUsedPresentation" })
end

function AddOverheadText( source, args )
	CreateTextBox({
		Id = source.ObjectId,
		Text = args.OverheadText,
		Font = args.OverheadTextFont or "LatoSemibold",
		FontSize = args.OverheadTextFontSize or 16,
		OffsetY = args.OverheadTextOffset or -65,
		Color = args.OverheadTextColor or Color.White
		})
end

