function BloomRequestStart( args )
	MapState.BloomRequests[args.SourceName] = args.BloomType
	MapState.BloomActiveSourceName = args.SourceName
	AdjustFullscreenBloom({ Name = args.BloomType, Duration = args.Duration })
end

function BloomRequestEnd( args )
	local wasActiveBloom = args.SourceName == MapState.BloomActiveSourceName
	MapState.BloomRequests[args.SourceName] = nil
	if IsEmpty( MapState.BloomRequests ) then
		AdjustFullscreenBloom({ Name = "Off", Duration = args.Duration })
		MapState.BloomActiveSourceName = nil
	elseif wasActiveBloom then
		-- Pick another arbitrary active request 
		local newBloomSourceName = GetFirstKey( MapState.BloomRequests )
		MapState.BloomActiveSourceName = newBloomSourceName
		AdjustFullscreenBloom({ Name = MapState.BloomRequests[newBloomSourceName], Duration = args.Duration })
	end	
end

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

function MetaPointRoomRewardPresentation(gained)
	thread( MetaPointRoomRewardPresentationThread, gained )
end

function MetaPointRoomRewardPresentationThread(gained)
	wait(0.5)
	thread( InCombatText, CurrentRun.Hero.ObjectId, "MetaPointGain", 1.5 , { LuaKey = "TempTextData", LuaValue = {Number = gained} })
end

function RangedFailedNoAmmoPresentation()
	if not CheckCooldown( "RangedFailedNoAmmoPresentation", 0.15 ) then
		return
	end
	thread( UpdateAmmoUI )
	thread( PulseText, { ScreenAnchorReference = "AmmoIndicatorUI", Color = Color.White, OriginalColor = Color.Red, ScaleTarget = 2.0, ScaleDuration = 0.2, HoldDuration = 0.05, PulseBias = 0.1, StartColorDuration = 0.25, EndColorDuration = 0.25 })
	PlaySound({ Name = "/SFX/Player Sounds/MelSkullsAmmoBounce", Id = CurrentRun.Hero.ObjectId })
end

function AddAmmoPresentation()
	thread( UpdateAmmoUI )

	CreateAnimation({ Name = "LobPickupFlash", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = -90 })

	if ScreenAnchors.AmmoIndicatorUI ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.AmmoIndicatorUI, ColorTarget = Color.White, ColorDuration = 0.2, AutoSetDataProperties = false, })
		thread( PulseText, { ScreenAnchorReference = "AmmoIndicatorUI", ScaleTarget = 1.3, ScaleDuration = 0.125, HoldDuration = 0.05, PulseBias = 0.1, StartColorDuration = 0.25, EndColorDuration = 0.25 } )
	end
end

function MaxHealthChangedPresentation( increase, delay )
	if delay then
		wait(delay)
	end
	local targetColor = Color.PenaltyRed
	if increase then
		targetColor = Color.UpgradeGreen
	end
	waitUnmodified(0.1)
	thread( PulseText, { Id = HUDScreen.Components.HealthBack.Id, Color = targetColor, OriginalColor = Color.White, ScaleTarget = 1.08, ScaleDuration = 0.15, HoldDuration = 0.11, ResetDuration = 0.3, PulseBias = 0.1, StartColorDuration = 0.2, EndColorDuration = 0.3 })
end

function MaxManaChangedPresentation( increase, delay )
	if delay then
		wait(delay)
	end
	local targetColor = Color.PenaltyRed
	if increase then
		targetColor = Color.RoyalBlue
	end
	waitUnmodified(0.1)
	thread( PulseText, { Id = HUDScreen.Components.ManaMeterBack.Id, Color = targetColor, OriginalColor = Color.White, ScaleTarget = 1.08, ScaleDuration = 0.15, HoldDuration = 0.11, ResetDuration = 0.3, PulseBias = 0.1, StartColorDuration = 0.2, EndColorDuration = 0.3 })
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
			elseif args.HealthProtected then
				thread( HeroArmorDamagePresentationThread, args, sourceWeaponData )
			else
				thread( HeroDamagePresentationThread, args, sourceWeaponData )
			end
		end
		if args.SourceProjectile and GetBaseDataValue({ Type = "Projectile", Name = args.SourceProjectile, Property = "IgnoreCoverageAngles"}) then
			local playerAttemptingToBlock = false
			for effectName in pairs( CurrentRun.Hero.ActiveEffects ) do
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
					UnblockableAttackPresentation( victim.ObjectId )
				end
			end
		end
	end

	if not rapidDamage then
		if CurrentRun.Hero.Health <= GetLowHealthUIThreshold( CurrentRun.Hero.MaxHealth ) and (not CurrentRun.Hero.HealthBuffer or CurrentRun.Hero.HealthBuffer <= 0 ) then
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

		if args.MajorDamage then

			CreateAnimation({ Name = "HitShroudTopHeavy", GroupName = "Vignette", UseScreenLocation = true,
				OffsetX = ScreenCenterX * 0.5, 
				OffsetY = 0,
				ScaleX = ScreenScaleX * 2, 
				ScaleY = ScreenScaleY,
			})		
			CreateAnimation({ Name = "HitShroudBottomHeavy", GroupName = "Vignette", UseScreenLocation = true,
				OffsetX = ScreenCenterX * 0.5, 
				OffsetY = ScreenCenterY,
				ScaleX = ScreenScaleX * 2, 
				ScaleY = ScreenScaleY,
			})		
			CreateAnimation({ Name = "HitShroudLeftHeavy", GroupName = "Vignette", UseScreenLocation = true,
				OffsetX = 0,
				OffsetY = ScreenCenterY * 0.5,
				ScaleX = ScreenScaleX*1.5, 
				ScaleY = ScreenScaleY,
			})		
			CreateAnimation({ Name = "HitShroudRightHeavy", GroupName = "Vignette", UseScreenLocation = true,
				OffsetX = ScreenCenterX,
				OffsetY = ScreenCenterY * 0.5,
				ScaleX = ScreenScaleX*1.5, 
				ScaleY = ScreenScaleY,
			})
			CreateAnimation({ Name = "HitShroudVignetteHeavy", GroupName = "Vignette", UseScreenLocation = true,
				OffsetX = ScreenCenterX, OffsetY = ScreenCenterY,
				ScaleX = ScreenScaleX, ScaleY = ScreenScaleY,
			})

		else 

			CreateAnimation({ Name = "HitShroudTop", GroupName = "Vignette", UseScreenLocation = true,
				OffsetX = ScreenCenterX * 0.5, 
				OffsetY = 0,
				ScaleX = ScreenScaleX * 2, 
				ScaleY = ScreenScaleY,
			})		
			CreateAnimation({ Name = "HitShroudBottom", GroupName = "Vignette", UseScreenLocation = true,
				OffsetX = ScreenCenterX * 0.5, 
				OffsetY = ScreenCenterY,
				ScaleX = ScreenScaleX * 2, 
				ScaleY = ScreenScaleY,
			})		
			CreateAnimation({ Name = "HitShroudLeft", GroupName = "Vignette", UseScreenLocation = true,
				OffsetX = 0,
				OffsetY = ScreenCenterY * 0.5,
				ScaleX = ScreenScaleX*1.5, 
				ScaleY = ScreenScaleY,
			})		
			CreateAnimation({ Name = "HitShroudRight", GroupName = "Vignette", UseScreenLocation = true,
				OffsetX = ScreenCenterX,
				OffsetY = ScreenCenterY * 0.5,
				ScaleX = ScreenScaleX*1.5, 
				ScaleY = ScreenScaleY,
			})

			CreateAnimation({ Name = "HitShroudVignette", GroupName = "Vignette", UseScreenLocation = true,
				OffsetX = ScreenCenterX, OffsetY = ScreenCenterY,
				ScaleX = ScreenScaleX, ScaleY = ScreenScaleY,
			})

		end


		thread( DoHeroHitRumble, sourceSimData )
	end
	
	if args ~= nil and sourceSimData ~= nil then
		DoWeaponHitSimulationSlow( CurrentRun.Hero, args, sourceSimData )
		DoWeaponScreenshake( sourceSimData, "HitScreenshake", { AttackerId = args.triggeredById, SourceProjectile = args.SourceProjectile, EffectName = args.EffectName } )
	end
end

function HeroArmorDamagePresentationThread( args, sourceSimData )
	if args == nil or not args.DamageAmount or args.DamageAmount > 0 then
		Shake({ Id = args.triggeredById, Distance = 2, Speed = 800, Duration = 0.7 })
		Flash({ Id = args.triggeredById, Speed = 0.65, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Yellow, Duration = 0.2, ExpireAfterCycle = true })
		CreateAnimation({ Name = "HitSparkArmorMel", DestinationId = CurrentRun.Hero.ObjectId })
		CreateAnimation({ Name = "ArmorHitFrame", UseScreenLocation = true,
			OffsetX = ScreenCenterX, OffsetY = ScreenCenterY,
			ScaleX = ScreenScaleX, ScaleY = ScreenScaleY,
			Duration = args.BloodFrameDuration or 0.3
			})
		CreateAnimation({ Name = "ArmorHitFrameDisplacement", UseScreenLocation = true,
			Group = "FX_Displacement",
			OffsetX = ScreenCenterX, OffsetY = ScreenCenterY,
			ScaleX = ScreenScaleX, ScaleY = ScreenScaleY,
			Duration = 0.3
			})
		thread( DoHeroHitRumble, sourceSimData )
	end
	if args ~= nil and sourceSimData ~= nil then
		DoWeaponHitSimulationSlow( CurrentRun.Hero, args, sourceSimData )
		DoWeaponScreenshake( sourceSimData, "HitScreenshake", { AttackerId = args.triggeredById, SourceProjectile = args.SourceProjectile, EffectName = args.EffectName } )
	end
end

function HeroFinalDamagePresentationThread( args, sourceWeaponData )

end

function HeroMajorDamagePresentationThread( args, sourceWeaponData )
	args.BloodFrameDuration = 1.0
	args.MajorDamage = true
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
	while not IsHealthHidden() and not SessionState.SafeMode and CurrentRun.Hero.Health <= GetLowHealthUIThreshold() and not IsScreenOpen("RunClear") and not CurrentRun.Hero.IsDead and CurrentRun.CurrentRoom.Encounter and
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
	local firstPulse = false
	while not IsHealthHidden() and SessionMapState.LowHealthPresentation and not CurrentRun.Hero.IsDead do
		if ShowingCombatUI and (ConfigOptionCache.LowHealthPulse or not firstPulse) then
			CreateAnimation({ Name = "HealthBarLowPulseA", DestinationId = healthBackId, GroupName = "Combat_UI_Additive" })
			ModifyTextBox({ Id = healthBackId, ColorTarget = Color.Red, ColorDuration = 0.5 })
			PulseText({ Id = healthBackId, ScaleTarget = 1.25, ScaleDuration = 0.1, HoldDuration = 0.0, PulseBias = 0.02 })
		end
		wait( 0.15, RoomThreadName )
		if ShowingCombatUI and (ConfigOptionCache.LowHealthPulse or not firstPulse) then
			CreateAnimation({ Name = "HealthBarLowPulseB", DestinationId = healthBackId, GroupName = "Combat_Menu_Overlay" })
			PulseText({ Id = healthBackId, ScaleTarget = 1.15, ScaleDuration = 0.15, HoldDuration = 0.05, PulseBias = 0.3 })
		end
		firstPulse = true
		wait( 1.5, RoomThreadName )
	end
	ModifyTextBox({ Id = healthBackId, ColorTarget = Color.White, ColorDuration = 0.5 })
	SessionMapState.LowHealthBarPulsing = false
end

function HeroTraitTransformPresentation( expiringTrait )
	wait(1)
	if CheckCooldown( "ChaosBoonTransformed", 5 ) then
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
	while not IsHealthHidden() and SessionMapState.LowHealthPresentation and not CurrentRun.Hero.IsDead and not ConfigOptionCache.EditingMode do
		if ConfigOptionCache.LowHealthPulse and (CurrentRun.CurrentRoom.Encounter and ( not CurrentRun.CurrentRoom.Encounter.Completed or ( CurrentRun.CurrentRoom.ChallengeEncounter ~= nil and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress )) ) then
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
	FrameState.DeferredPresentation = FrameState.DeferredPresentation or {}
	FrameState.DeferredPresentation.DoRootApplyPresentation = FrameState.DeferredPresentation.DoRootApplyPresentation or {}
	local id = victimId or victim.ObjectId
	table.insert( FrameState.DeferredPresentation.DoRootApplyPresentation, id )
	if victim ~= nil then
		if victim.TetherIds ~= nil then
			for k, tetherId in ipairs( victim.TetherIds ) do
				RootApplyPresentation( nil, tetherId )
			end
		end
	end
end

function DoRootApplyPresentation( ids )
	SetHSV({ Ids = ids, HSV = { 0, -0.4, -0.3 }, ValueChangeType = "Add" })
	SetColor({ Ids = ids, Color = { 35, 60, 110, 255 }, Duration = 0.125 })
	if ConfigOptionCache.GraphicsQualityPreset ~= "GraphicsQualityPreset_Low" then
		SetThingProperty({ Property = "AddColor", Value = true, DestinationId = ids })
	end
end

function RootClearPresentation( victim, victimId )
	if victim then
		if not victim.RootActive then
			return
		end
		if victim.BlockEffectWhileRootActive then
			RemoveEffectBlock({ Id = victim.ObjectId, Name = victim.BlockEffectWhileRootActive})
			victim.BlockEffectWhileRootActive = nil
		end
		victim.RootActive = nil
	end
	
	if victim == nil or ((not victim.IsDead and (victim.Health or 0) > 0) or victim.ClearChillOnDeath) then
		SetHSV({ Id = victimId or victim.ObjectId, HSV = { 0, 0.4, 0.3 }, ValueChangeType = "Add" })
		SetColor({ Id = victimId or victim.ObjectId, Color = { 255, 255, 255, 255 }, Duration = 0.125 })
		if ConfigOptionCache.GraphicsQualityPreset ~= "GraphicsQualityPreset_Low" then
			SetThingProperty({ Property = "AddColor", Value = false, DestinationId = victimId or victim.ObjectId })
		end
		if victim ~= nil then
			if victim.TetherIds ~= nil then
				for k, tetherId in ipairs( victim.TetherIds ) do
					RootClearPresentation( nil, tetherId )
				end
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
	PlaySound({ Name = "/SFX/PetrificationStart", Id = victim.ObjectId, ManagerCap = 46 })
	if victim == CurrentRun.Hero then
		thread( PlayVoiceLines, GlobalVoiceLines.ChronosChronomancyVoiceLines, true )
	end
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
	PlaySound({ Name = "/SFX/PetrificationStart", Id = victim.ObjectId, ManagerCap = 46 })
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
	elseif victim.UnfreezeAnimation ~= nil and ( victim ~= CurrentRun.Hero or not MapState.HostilePolymorph ) then
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
	SetAnimation({ Name = GetTraitIcon(traitData), DestinationId = sacrificeIcon.Id })

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
	SetInteractProperty({ DestinationId = components[purchaseButtonKey.."Lock"].Id, Property = "TooltipOffsetX", Value = ScreenData.UpgradeChoice.TooltipOffsetX })
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
		local count = TableLength( RequiredKillEnemies )
		for id, blockedByEnemy in pairs( ShallowCopyTable( RequiredKillEnemies ) ) do
			DebugPrint({ Text = "Door Blocked By: "..GetTableString( blockedByEnemy ) })
			if count <= 1 and not blockedByEnemy.IgnoreFinalEnemyDirectionHint then
				thread( DirectionHintPresentation, blockedByEnemy, { Cooldown = 1.0, Delay = 0.0 } )
			end
		end
	elseif not IsEmpty( CurrentRun.CurrentRoom.Encounter.ActiveSpawns ) and not door.CannotBeBlockedByEnemies then
		text = "ExitBlockedByEnemies"
		voiceLines = HeroVoiceLines.ExitBlockedByEnemiesVoiceLines
		local count = TableLength( CurrentRun.CurrentRoom.Encounter.ActiveSpawns )
		for id, _ in pairs( CurrentRun.CurrentRoom.Encounter.ActiveSpawns ) do
			DebugPrint({ Text = "Door Blocked By: "..id })
			local spawn = ActiveEnemies[id]
			if count <= 1 and spawn ~= nil and not spawn.IgnoreFinalEnemyDirectionHint then
				thread( DirectionHintPresentation, spawn, { Cooldown = 1.0, Delay = 0.0 } )
			end
		end
	else
		for objectId, objectTable in pairs( MapState.RoomRequiredObjects ) do
			if objectTable.BlockExitText ~= nil then
				text = objectTable.BlockExitText
				thread( DirectionHintPresentation, objectTable, { Cooldown = 1.0, Delay = 0.0 } )
				break
			end
		end
		if door.BlockedByMultipleRequiredObjectsText ~= nil and TableLength( MapState.RoomRequiredObjects ) >= 2 then
			text = door.BlockedByMultipleRequiredObjectsText
		end

		if text == nil then
			local failedRequirement = CheckSpecialDoorRequirement( door )
			if failedRequirement ~= nil then
				text = failedRequirement
				if failedRequirement == "ExitBlockedByHealthReq" then
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
		thread( PlayVoiceLines, voiceLines, true )
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = text, Duration = 1.5, ShadowScale = 0.66, ShadowScaleX = 1.2, OffsetY = door.ExitBlockedTextOffsetY or -150 })
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

function PreRerollPanelPresentation( screen, button )
	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })
	AudioState.RerollSoundId = PlaySound({ Name = "/Leftovers/Menu Sounds/StoryRecapTextAppear" })
	thread( FullScreenFadeOutAnimation, "RerollTransitionIn", "Ascension"  )
	wait( 0.51 )
	SetVolume({ Id = rerollSoundId, Value = 0.3 })
	thread( PlayVoiceLines, HeroVoiceLines.UsedRerollPanelVoiceLines, true )
end

function PostRerollPanelPresentation( screen, button )
	wait( 0.05 )
	StopSound({ Id = AudioState.RerollSoundId, Duration = 0.3 })
	AudioState.RerollSoundId = nil
	thread( FullScreenFadeInAnimation, "RerollTransitionOut", "Ascension" )
	wait( 0.40 )
end

function OnPlayerHealed( hero, args )
	CreateAnimation({ Name = "HealthSparkleShower", DestinationId = hero.ObjectId, Group = "Overlay" })
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
	CreateAnimation({ Name = "ManaSparkleShower", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
end

function DisplayPlayerHealingText( args )

	if not ConfigOptionCache.ShowDamageNumbers then
		return
	end

	local amount = args.ActualHealAmount

	local healthColor = Color.UpgradeGreen
	thread( PopOverheadText, {Amount = amount, Text = "HealingAmount", Color = healthColor, SkipShadow = true, GroupName = "Combat_UI" } )

	PulseText({ Id = HUDScreen.Components.HealthBack.Id, ScaleTarget = 1.25, ScaleDuration = 0.35, HoldDuration = 0.0, PulseBias = 0 })
end

function DisplayEnemyHealingText( victim, args )
	local objectId = victim.ObjectId
	local amount = args.ActualHealAmount
	local healthColor = Color.UpgradeGreen
	thread( PopOverheadText, {TargetId = objectId, Amount = amount, Text = "HealingAmount", Color = healthColor, SkipShadow = true, GroupName = "Combat_UI" } )
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

function ChaosTimerReallyAboutToExpirePresentation( threshold )
	if CheckCooldown( "ChaosTimerReallyAboutToExpire", 60 ) then
		PlaySound({ Name = "/SFX/ThanatosEntranceSound" })
		thread( PlayVoiceLines, GlobalVoiceLines.ChaosWarningVoiceLines )
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosTimerAboutToExpire", Duration = 1.3, PreDelay = 0.2, ShadowScaleX = 1.3, LuaKey = "TempTextData", LuaValue = { TimeLeft = threshold } } )
	end
end

function ChaosTimerReallyAboutToExpirePing()
	PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse" })
end

function ChaosTimerExpirePresentation()
	-- CreateAnimation({ Name = "SacrificeHealthFx", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	thread( PlayVoiceLines, GlobalVoiceLines.ChaosBigHitVoiceLines )
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

function RefundKeepsakeExpiredPresentation( sourceTrait )
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	-- thread( PlayVoiceLines, HeroVoiceLines.KeepsakeExpiredVoiceLines, true )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "LimitedManaRegenDropExpired", Duration = 1.3, PreDelay = 0.2 } )
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

function DecayingBoostKeepsakeExpiredPresentation()
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.KeepsakeExpiredVoiceLines, true )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "DecayingBoostKeepsakeExpired", Duration = 1.3, PreDelay = 0.2 } )
end

function DiminishingDodgeExpiredPresentation()
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "DiminishingDodgeExpired", Duration = 1.3, PreDelay = 0.2 } )
end

function BiomeDamagePresentation( damageAmount )

	thread( DisplayPlayerDamageText, { triggeredById = CurrentRun.Hero.ObjectId, UseCustomText = "BiomeTimerDamage", PercentMaxDealt = damageAmount/CurrentRun.Hero.MaxHealth, DamageAmount = damageAmount } )
	CreateAnimation({ Name = "ThanatosDeathsHead_Small", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	PlaySound({ Name = "/SFX/HeartPulsate1", ManagerCap = 52 })
	PlaySound({ Name = "/SFX/HeartPulsate2", ManagerCap = 52, Delay = 0.35 })

end


-- Utilities below

function RepulseFromObject( object, args )
	if object.IsInvisible then
		return
	end
	local ignoreInvincibubbleOnHit = args.IgnoreInvincibubbleOnHit or object.IgnoreInvincibubbleOnHit
	if not ignoreInvincibubbleOnHit then
		CreateAnimation({ Name = object.InvincibubbleAnim or "Invincibubble", DestinationId = object.ObjectId, OffsetZ = args.OffsetZ, Scale = args.Scale })
	end
	CreateAnimation({ Name = "RadialNovaRepulsion", DestinationId = object.ObjectId, OffsetZ = args.OffsetZ, Scale = args.Scale or 0.65 })
	PlaySound({ Name = "/Leftovers/SFX/InvincibleOnHit", Id = object.ObjectId, ManagerCap = 36 })
	local playerAngle = GetPlayerAngle()
	if args.UseAngleBetween then
		playerAngle = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = object.ObjectId })
	end
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
	if not ignoreInvincibubbleOnHit then
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

	local objectId = args.TargetId or CurrentRun.Hero.ObjectId
	local amount = args.Amount
	local text = args.Text

	local randomFontSize = RandomInt( 170, 180 )
	local offsetY = args.OffsetY or 0

	if args.Delay then
		waitUnmodified( args.Delay )
	end

	local groupName = args.GroupName or "Combat_Menu_Overlay"
	local textAnchor = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", DestinationId = objectId, Group = groupName, OffsetY = args.TextAnchorOffsetY or -190, UseScreenLocation = args.UseScreenLocation })

	local color = args.Color

	local holdDuration = args.HoldDuration or 0.45
	local fadeOutDuration = args.FadeOutDuration or 0.4

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
	})

	if not args.SkipShadow then
		SetAnimation({  Name = args.ShadowAnimName or "InCombatTextShadow_Short", DestinationId = textAnchor, OffsetY = 10 + offsetY, Scale = args.ShadowScale or 0.6 })
	end

	waitUnmodified( 0.1 )
	SetColor({ Id = textAnchor, Color = Color.White, Duration = 0 })
	SetColor({ Id = textAnchor, Color = color, Duration = 0.4, EaseIn = 0.99, EaseOut = 1.0 })
	Move({ Id = textAnchor, Distance = 80, Angle = 90, Duration = 0.4, EaseIn = 0.99, EaseOut = 1.0, TimeModifierFraction = 0.0 })
	ModifyTextBox({ Id = textAnchor, ScaleTarget = 0.3, ScaleDuration = 0.2, AutoSetDataProperties = false, })
	waitUnmodified( holdDuration )
	if not args.SkipShadow then
		SetAlpha({ Id = textAnchor, Fraction = 0.0, Duration = fadeOutDuration })
	end
	waitUnmodified( fadeOutDuration )
	Destroy({ Id = textAnchor })
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
	waitUnmodified( (args.ScaleDuration * args.PulseBias) + args.HoldDuration, args.ThreadName or RoomThreadName )

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

function LootPickupPresentation( loot, args )

	args = args or {}
	if loot.PickupVoiceLines then
		thread( PlayVoiceLines, loot.PickupVoiceLines, true )
	end

	SetThreadWait( "InfoBanner", 0.01 )
	SessionMapState.BlockInfoBanners = true

	if loot.RecheckConversationOnLootPickup and loot.NextInteractLines ~= nil and not IsTextLineEligible( CurrentRun, loot, loot.NextInteractLines ) then
		loot.NextInteractLines = nil
	end

	local textLines = nil
	if loot.NextInteractLines ~= nil then
		textLines = loot.NextInteractLines
		loot.NextInteractLines = nil
	elseif loot.HasDuoBoon and loot.DuoPickupTextLines ~= nil and ( loot.DuoPickupTextLinesRequirements == nil or IsGameStateEligible( loot, loot.DuoPickupTextLinesRequirements ) ) then
		textLines = GetRandomEligibleTextLines( loot, loot.DuoPickupTextLines, {} )
		if textLines ~= nil then
			CurrentRun.HadDuoConversation = true
			local speakerNames = {}
			for _, line in ipairs( textLines ) do
				table.insert( speakerNames, string.match(line.Cue, "/VO/(%a+)_") )
			end
			LoadVoiceBank({ Names = speakerNames, IgnoreAssert = true })
			LoadPackages({ Names = speakerNames, IgnoreAssert = true })
		end
	elseif loot.BoughtFromShop and loot.BoughtTextLines ~= nil then
		if loot.BoughtTextLinesRequirements == nil or IsGameStateEligible( loot, loot.BoughtTextLinesRequirements ) then
			textLines = GetRandomEligibleTextLines( loot, loot.BoughtTextLines, GetNarrativeDataValue( loot, "BoughtTextLinePriorities" ) )
			if textLines ~= nil then
				CurrentRun.HadBoughtLootConversation = true
			end
		end
	elseif MapState.RejectedLoot ~= nil and MapState.RejectedLoot.Name == loot.Name and loot.MakeUpTextLines ~= nil then
		textLines = GetRandomEligibleTextLines( loot, loot.MakeUpTextLines, {} )
	else
		textLines = GetRandomEligibleTextLines( loot, loot.InteractTextLineSets, GetNarrativeDataValue( loot, "InteractTextLinePriorities" ) )
	end
	
	if textLines ~= nil and not loot.BlockTextLines then
		if textLines.ForcedUpgradeOptions ~= nil then
			loot.UpgradeOptions = textLines.ForcedUpgradeOptions
		end
		args.ScreenArgs = { SkipQuestStatusCheck = true, }
		-- Cancel all partner conversations immediately
		for id, unit in pairs( ActiveEnemies ) do
			if unit ~= loot and unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == textLines.Name then
				StopStatusAnimation( unit, StatusAnimations.WantsToTalk )
				break
			end
		end
		PlayTextLines( loot, textLines, args )
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
	SessionMapState.BlockInfoBanners = false

end

function StartedTextLinesPresentation( source, textLines )
	CallFunctionName( source.StartedTextLinesFunctionName, source, source.StartedTextLinesFunctionArgs )

	if textLines ~= nil and source.TextLinesPauseSingingFx then
		StopAnimation({ DestinationId = source.ObjectId, Name = source.SingingFx })
	end
	if CurrentHubRoom ~= nil and AudioState.AmbientMusicId ~= nil and not SessionState.AmbientMusicPaused then
		if textLines.PauseMusicPlayerMusic then
			PauseMusicianMusic()
		else
			SetVolume({ Id = AudioState.AmbientMusicId, Value = 0.06, Duration = 0.5 })
			SetSoundCueValue({ Name = "Vocals", Id = AudioState.AmbientMusicId, Value = 0.7, Duration = 0.33 })
			SetAudioEffectState({ Name = "VOCompression", Value = 0, Duration = 0.8 })
		end
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

	if source ~= nil and not source.TextLinesUseWeaponIdle and not textLines.SkipPreNarrativeUnequip then
		thread( PreNarrativeUnequipAnimation )
	end
	CreateDialogueBackground()
end

function CreateDialogueBackground( )
	ScreenAnchors.DialogueBackgroundId = CreateScreenObstacle({ Name = "DialogueBackground", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_Backing", ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
end

function FinishedTextLinesPresentation( source, textLines )
	CallFunctionName( source.FinishedTextLinesFunctionName, source, source.FinishedTextLinesFunctionArgs )
	if textLines ~= nil and source.TextLinesPauseSingingFx and AudioState.AmbientMusicId ~= nil then
		CreateAnimation({ Name = source.SingingFx, DestinationId = source.ObjectId, OffsetX = source.SingingAnimOffsetX or source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
	end	
	if CurrentHubRoom ~= nil and AudioState.AmbientMusicId ~= nil then
		if textLines.PauseMusicPlayerMusic then
			ResumeMusicianMusic()
		else
			SetAudioEffectState({ Name = "VOCompression", Value = 1, Duration = 0.5 })
			SetVolume({ Id = AudioState.AmbientMusicId, Value = CurrentHubRoom.AmbientMusicVolume, Duration = 0.5 })
			SetSoundCueValue({ Name = "Vocals", Id = AudioState.AmbientMusicId, Value = CurrentHubRoom.AmbientMusicParams.Vocals, Duration = 0.33 })
		end
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

	AddInputBlock({ Name = "SurpriseNPCPresentation" })
	ToggleCombatControl( {"AdvancedTooltip"}, false, "SurpriseNPC" )

	killWaitUntilThreads( "ReattachCameraOnInput" )

	PlayVoiceLines( args.VoiceLines, false, source )
	wait( args.IntroWait or 0.4, RoomThreadName )

	if not args.SkipAngleTowardTarget then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if not args.SkipPan then
		PanCamera({ Ids = args.PanIds or { source.ObjectId, CurrentRun.Hero.ObjectId }, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.03 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	end
	RemoveInputBlock({ Name = "SurpriseNPCPresentation" })

	if args.TextLineSet ~= nil then
		ProcessTextLines( source, args.TextLineSet )
		PlayRandomRemainingTextLines( source, args.TextLineSet )
	end

	if not args.SkipCameraLock then
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	end

	ToggleCombatControl( {"AdvancedTooltip"}, true, "SurpriseNPC")

end

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

function IncreasedTraitLevelPresentation( traitNamesImproved, numStacks, delay )
	if delay then
		wait( delay )
	end
	numStacks = numStacks or 1
	for traitName in pairs( traitNamesImproved ) do
		local traitTitle = traitName
		if TraitData[traitName] then 
			traitTitle = GetTraitTooltipTitle(TraitData[traitName])
		end
		CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "MegaPom_CombatText", SkipRise = false, SkipFlash = true, ShadowScale = 0.66, Duration = 1.5, OffsetY = -100, UseProgressiveStack = true, LuaKey = "TempTextData", LuaValue = { Name = traitTitle, Amount = numStacks }})
		PlaySound({ Name = "/SFX/PomegranateLevelUpSFX", DestinationId = CurrentRun.Hero.ObjectId })
		wait(0.75)
	end
end
function HeraTraitRarityPresentation( traitName, numStacks, delay )
	if delay then
		wait(delay)
	end
	UIScriptsDeferred.IgnoreElementalCountDirty = true
	numStacks = numStacks or 1
	local traitTitle = traitName
	if TraitData[traitName] then 
		traitTitle = GetTraitTooltipTitle(TraitData[traitName])
	end
	CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "HeraPom_CombatText", SkipRise = false, SkipFlash = true, ShadowScale = 0.66, Duration = 1.5, OffsetY = -100, LuaKey = "TempTextData", LuaValue = { Name = traitTitle, Amount = numStacks }})
	PlaySound({ Name = "/SFX/PomegranateLevelUpSFX", DestinationId = CurrentRun.Hero.ObjectId })
	wait(1.8)
	UIScriptsDeferred.IgnoreElementalCountDirty = nil
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

function SuperSacrificePresentation( sacrificedGod, buffedGod, totalLevels )
	wait(1)
	local buffedGodData = LootData[buffedGod]
	local sacrifiedGodData = LootData[sacrificedGod]
	CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })

	PlaySound({ Name = buffedGodData.SpawnSound or "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY", DestinationId = CurrentRun.Hero.ObjectId })

	thread( PlayVoiceLines, buffedGodData.SuperSacrificeVoiceLines, true )

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
	local offsetY = 0
	for traitName in pairs( traitNamesImproved ) do
		PlaySound({ Name = "/SFX/Player Sounds/HeraSwipeSFX1", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "RarityUpgraded_CombatText", SkipRise = false, SkipFlash = false, Duration = 0.95, ShadowScale = 0.75, ShadowScaleX = 1.28, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(1)
		-- offsetY = offsetY - 60
	end
end

function IncreasedHammerRarityPresentation( traitNamesImproved, delay )
	wait( delay )
	local offsetY = 0
	for traitName in pairs( traitNamesImproved ) do
		PlaySound({ Name = "/SFX/WeaponUpgradeHammerDrop2", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "HammerUpgraded_CombatText", SkipRise = false, SkipFlash = false, Duration = 0.95, ShadowScale = 0.75, ShadowScaleX = 1.28, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(1)
		-- offsetY = offsetY - 60
	end
end

function AddedMetaUpgradePresentation( metaUpgradesAdded, delay )
	
	waitUnmodified( delay, "MetaUpgradePresentation" )
	local offsetY = 170
	local spacerX = 320
	local startX = (-spacerX * (TableLength(metaUpgradesAdded) + 1)) / 2
	for i, metaUpgradeName in pairs( metaUpgradesAdded ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread(ShowMetaUpgradeCard, metaUpgradeName, startX + spacerX * i, offsetY )
		waitUnmodified(0.25, "MetaUpgradePresentation")
	end
end

function ShowMetaUpgradeCard(metaUpgradeName, x, y )
	local cardAnchorId = CreateScreenObstacle({ Name = "BlankObstacleNoTimeModifier", Group = "Combat_UI_World", X = ScreenCenterX  + x, Y = ScreenCenterY + y })
	local cardAnchorId2 = CreateScreenObstacle({ Name = "BlankObstacleNoTimeModifier", Group = "Combat_UI_World", X = ScreenCenterX  + x, Y = ScreenCenterY + y })
	local cardFlipFxId = CreateScreenObstacle({ Name = "BlankObstacleNoTimeModifier", Group = "Combat_UI_World_Add", X = ScreenCenterX  + x, Y = ScreenCenterY + y })
	table.insert( SessionMapState.ShownMetaUpgradeCardIds, cardAnchorId )
	thread( InCombatTextArgs, {
		ScreenSpace = true, 
		TargetId = cardAnchorId, 
		OffsetY = 130, 
		Group = "Combat_UI_World", 
		FlashGroup = "Combat_UI_World_Add",
		Text = "MetaUpgradeSelected_CombatText", 
		SkipRise = true, SkipFlash = false, 
		Duration = 2.5, ShadowScale = 0.75, 
		ShadowScaleX = 1.28, 
		LuaKey = "TempTextData", 
		LuaValue = { Name = metaUpgradeName }
	})
	local cardBackIndex = 1
	if not IsEmpty(GameState.MetaUpgradeLayoutsArt) and GameState.CurrentMetaUpgradeLayout then
		cardBackIndex = GameState.MetaUpgradeLayoutsArt[GameState.CurrentMetaUpgradeLayout] or 1
	end
	if cardBackIndex < 10 then
		cardBackIndex = "0"..cardBackIndex
	end
	SetAnimation({ Name = "CardBack_"..cardBackIndex, DestinationId = cardAnchorId2, Scale = 0.2775 })
	
	CreateAnimation({ 
		Name = "MetaUpgradeCardFlip", 
		DestinationId = cardFlipFxId,
		Group = "Combat_UI_World_Add", 
		Scale = 1,
	})
	SetScale({ Id = cardAnchorId2, Duration = 0.3, Fraction = 1.1 })
	Move({ Id = cardAnchorId2, Distance = -7, Angle = 270, Duration = 0.3})
	waitUnmodified(0.3)
	SetAlpha({ Id = cardAnchorId2, Duration = 0.2, Fraction = 0})
	waitUnmodified(1.12 - 0.3, "MetaUpgradePresentation")
	Destroy({Id = cardAnchorId2})
	SetAnimation({ Name = MetaUpgradeCardData[metaUpgradeName].Image, DestinationId = cardAnchorId, Scale = 0.2775})
	waitUnmodified(1.5, "MetaUpgradePresentation")
	SetAlpha({ Id = cardAnchorId, Duration = 0.2, Fraction = 0 })
	waitUnmodified(0.2, "MetaUpgradePresentation")
	Destroy({ Id = cardAnchorId })
	RemoveValue( SessionMapState.ShownMetaUpgradeCardIds, cardAnchorId )
	waitUnmodified(0.2, "MetaUpgradePresentation")
	Destroy({ Id = cardFlipFxId })
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

function ChaosKeepsakeAcquiredPresentation( newTraitName )
	if CurrentRun.CurrentRoom.BiomeStartRoom then
		wait( CurrentRun.CurrentRoom.IntroSequenceDuration or 0.1 )
	end
	CreateAnimation({ Name = "ChaosShiftFx", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ChaosKeepsake_NewChoice", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.2, LuaKey = "TempTextData", 
	LuaValue = { NewName = newTraitName }})
end

function HammerKeepsakeAcquiredPresentation( newTraitName )
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.BiomeStartRoom then
		wait( CurrentRun.CurrentRoom.IntroSequenceDuration or 0.1 )
	end
	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "HammerKeepsake_Acquire", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.2, LuaKey = "TempTextData", 
	LuaValue = { NewName = newTraitName }})
end
function RunStartHammerKeepsakeAcquiredPresentation()
	local traitData = nil
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
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

	if HeroHasTrait("TempHammerKeepsake") then
		local sourceKeepsake = GetHeroTrait("TempHammerKeepsake")
		sourceKeepsake.CustomTrayText = sourceKeepsake.ZeroBonusTrayText
		ReduceTraitUses( sourceKeepsake, {Force=  true })
	end
end

function HadesKeepsakeAcquiredPresentation( newTraitName )
	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "HadesKeepsake_Acquire", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.2, LuaKey = "TempTextData", 
	LuaValue = { NewName = newTraitName }})
end

function RunStartHadesKeepsakeAcquiredPresentation()
	if not IsFateValid() then
		return
	end
	local traitData = nil
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.GrantedTrait then
			traitData = trait
			break
		end
	end
	if traitData then
	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "HadesKeepsake_Acquire", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.2, LuaKey = "TempTextData", 
		LuaValue = { NewName = traitData.Name }})
	end
end

function RunStartChaosBlessingPresentation()
	for i,  trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.FromChaosKeepsake then
			ChaosKeepsakeAcquiredPresentation( trait.CustomTitle )
			return
		end
	end
end

function ChaosTransformationPresentation( oldTraitName, newTraitName )
	wait(0.5)
	if CheckCooldown( "ChaosBoonTransformed", 5 ) then

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
	SessionState.ElementalTraitDeactivated = nil
	if UIScriptsDeferred.ElementalPresentationData == nil then
		return
	end

	if UIScriptsDeferred.ElementalPresentationData.Gained ~= nil then
		local traitName = UIScriptsDeferred.ElementalPresentationData.Gained
		PlaySound({ Name = TraitData[traitName].ElementGainSound, Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ElementGranted_CombatText", ShadowScaleX = 1.5, SkipRise = true, SkipFlash = false, Duration = 1.8, OffsetY = 80, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.5)
	end
	if UIScriptsDeferred.ElementalPresentationData == nil then
		return
	end
	UIScriptsDeferred.ElementalPresentationData.Gained = nil

	local offsetY = -100

	for traitName in pairs( ShallowCopyTable( UIScriptsDeferred.ElementalPresentationData.Activated ) ) do
		PlaySound({ Name = "/SFX/WrathEndingWarning", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ElementalTraitActivated", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		thread( PlayVoiceLines, HeroVoiceLines.BoonActivatedVoiceLines, true )
		wait(0.75)
		offsetY = offsetY - 60
	end
	if UIScriptsDeferred.ElementalPresentationData == nil then
		return
	end
	UIScriptsDeferred.ElementalPresentationData.Activated = {} 

	for traitName in pairs( ShallowCopyTable( UIScriptsDeferred.ElementalPresentationData.Deactivated ) ) do
		if TraitData[traitName].IsElementalTrait then
			SessionState.ElementalTraitDeactivated = true
		end
		PlaySound({ Name = "/SFX/WrathOver2", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ElementalTraitDeactivated", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		thread( PlayVoiceLines, HeroVoiceLines.BoonDeactivatedVoiceLines, true )
		wait(0.75)
		offsetY = offsetY - 60
	end

	if UIScriptsDeferred.ElementalPresentationData == nil then
		return
	end
	UIScriptsDeferred.ElementalPresentationData.Deactivated = {} 
	for traitName in pairs( ShallowCopyTable( UIScriptsDeferred.ElementalPresentationData.Upgraded ) ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ElementalTraitUpgraded", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.75)
		offsetY = offsetY - 60
	end

	if UIScriptsDeferred.ElementalPresentationData == nil then
		return
	end
	UIScriptsDeferred.ElementalPresentationData.Upgraded = {} 
	for traitName in pairs( ShallowCopyTable( UIScriptsDeferred.ElementalPresentationData.Downgraded ) ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ElementalTraitDowngraded", ShadowScaleX = 1.7, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.75)
		offsetY = offsetY - 60
	end

	if UIScriptsDeferred.ElementalPresentationData == nil then
		return
	end
	UIScriptsDeferred.ElementalPresentationData.Downgraded = {} 
end

function PartnersChattingPresentation( npc, args, contextArgs )
	local partner = contextArgs.Partner
	if npc ~= nil and partner ~= nil and not npc.BlockChatting and not partner.BlockChatting then
		local threadName = "PartnersChatting"
		local chatter = npc
		if CoinFlip() then
			chatter = partner
		end
		npc.ChatBubbleId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = npc.ObjectId, OffsetZ = npc.AnimOffsetZ, Group = "Combat_UI", Attach = true, AttachToMarkerName = "speechBubble_00_M_JNT" })
		SetAnimation({ DestinationId = npc.ChatBubbleId, Name = "StatusIconChatting" })
		SetAlpha({ Id = npc.ChatBubbleId, Fraction = 0.0 })
		partner.ChatBubbleId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = partner.ObjectId, OffsetZ = partner.AnimOffsetZ, Group = "Combat_UI", Attach = true, AttachToMarkerName = "speechBubble_00_M_JNT" })
		SetAlpha({ Id = partner.ChatBubbleId, Fraction = 0.0 })
		SetAnimation({ DestinationId = partner.ChatBubbleId, Name = "StatusIconChatting" })
		wait( 2.0, threadName )
		while true do
			if npc.PlayingVoiceLine ~= nil or partner.PlayingVoiceLine ~= nil then
				wait( 2.0, threadName )
			else
				wait( RandomFloat( 1.0, 3.0 ), threadName )
				if npc.Mute or partner.Mute or npc.BlockChatting or partner.BlockChatting then
					break
				end
				SetAlpha({ Id = chatter.ChatBubbleId, Fraction = 1.0, Duration = 0.3 })
				wait( RandomFloat( 1.0, 5.0 ), threadName )
				if npc.Mute or partner.Mute or npc.BlockChatting or partner.BlockChatting then
					break
				end
				SetAlpha({ Id = chatter.ChatBubbleId, Fraction = 0.0, Duration = 0.3 })
				if chatter == npc then
					chatter = partner
				else
					chatter = npc
				end
			end
		end
		SetAlpha({ Ids = { npc.ChatBubbleId, partner.ChatBubbleId }, Fraction = 0.0, Duration = 0.3 })
		wait( 0.3 )
		Destroy({ Ids = { npc.ChatBubbleId, partner.ChatBubbleId } })
	end
end

function PartnersChattingStop()
	killTaggedThreads( "PartnersChatting" )
	for id, enemy in pairs( ActiveEnemies ) do
		if enemy.ChatBubbleId ~= nil then
			Destroy({ Id = enemy.ChatBubbleId })
		end
	end
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
function SuperGiftPointRefundPresentation()

	wait(1.1)

	PlaySound({ Name = "/SFX/GiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId })
	AddResource( "SuperGiftPoints", 1, "Item" )

end
function HypnosPointRefundPresentation()

	wait(1.1)
	AddResource( "HypnosPoints", 1, "Item", { Silent = true } )

end
function ResourceGiftedPresentation( args )

	args = args or {}
	wait( args.WaitTime or 1.1 )

	PlaySound({ Name = args.SoundName or "/Leftovers/World Sounds/Caravan Interior/SteamAcidForage", Id = CurrentRun.Hero.ObjectId })
	AddResource( args.ResourceName or "GiftPointsRare", args.ResourceAmount or 1, "Item", { SkipVoiceLines = not args.AllowOnAddVoiceLines } )
	if args.CheckSeedStatus then
		CheckSeedStatus()
	end

end
function ResourceGiftedInEventPresentation( source, args )

	args = args or {}
	wait(args.GiftWaitTime or 1.1)

	PlaySound({ Name = args.SoundName or "/Leftovers/World Sounds/Caravan Interior/SteamAcidForage", Id = CurrentRun.Hero.ObjectId })
	AddResource( args.ResourceName or "GiftPointsRare", args.ResourceAmount or 1, "Item", { SkipVoiceLines = not args.AllowOnAddVoiceLines } )

end

function TrackPlayer( source, args )
	while IsAlive({ Id = source.ObjectId }) do
		if not source.SuppressTrackPlayer then
			AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Duration = args.Duration, SetBase = args.SetBase, EaseIn = args.EaseIn, EaseOut = args.EaseOut, FollowFlips = args.FollowFlips })
		end
		local interval = args.Interval
		if args.RandomIntervalMin ~= nil then
			interval = RandomFloat( args.RandomIntervalMin, args.RandomIntervalMax )
		end
		wait( interval, args.ThreadName )
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

	if args.PlayScyllaTauntAnim ~= nil then
		thread( PlayScyllaTauntAnim, source, args )
	end

	if args.PlayZagreusTauntAnim ~= nil then
		thread( PlayZagreusTauntAnim, source, args )
	end

	wait( args.WaitTime, NarrativeThreadName )

	local newPortrait = args.Portrait

	if args.Portrait ~= nil then
		if screen.CurrentPortrait ~= nil and screen.CurrentPortrait ~= newPortrait then
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
			screen.CurrentPortrait = nil
			wait( line.PortraitExitWait or 0.3, NarrativeThreadName )

			if source.PortraitSwapMap ~= nil then
				newPortrait = source.PortraitSwapMap[newPortrait] or newPortrait
			end
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

	PlaySound({ Name = "/Leftovers/World Sounds/MelEpicSpell" })
	if args.UseChronosSound then
		PlaySound({ Name = "/SFX/Enemy Sounds/Chronos/ChronosClockHand" })
	end
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
			wait( line.PortraitExitWait or 0.3, NarrativeThreadName )

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

function FrogFamiliarReaction( args )
	local familiarId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "FrogFamiliar" })
	SetAnimation({ Name = "Familiar_Frog_Greet", DestinationId = familiarId })
	PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = familiarId })
end
function RavenFamiliarReaction( args )
	local familiarId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "RavenFamiliar" })
	SetAnimation({ Name = "Familiar_Raven_Victory_Perch", DestinationId = familiarId })
	PlaySound({ Name = "/SFX/Familiars/RavenGentleSquawk", Id = familiarId })
end
function CatFamiliarReaction( args )
	local familiarId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "CatFamiliar" })
	-- SetAnimation({ Name = "Familiar_Cat_Sleep_Awaken", DestinationId = familiarId })
	PlaySound({ Name = "/SFX/Familiars/CatMeowExclaim", Id = familiarId })
end
function HoundFamiliarReaction( args )
	local familiarId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "HoundFamiliar" })
	SetAnimation({ Name = "Familiar_Hound_Greet", DestinationId = familiarId })
	PlaySound({ Name = "/SFX/Familiars/DogBarkMisc1", Id = familiarId })
end
function PolecatFamiliarReaction( args )
	local familiarId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "PolecatFamiliar" })
	SetAnimation({ Name = "Familiar_Polecat_Greet", DestinationId = familiarId })
	PlaySound({ Name = "/SFX/Familiars/PolecatHappy3", Id = familiarId })
end

function AmbientDogsReaction( args )
	-- SetAnimation({ Name = "Familiar_Frog_Greet", DestinationId = 566831 })
	PlaySound({ Name = "/VO/CerberusBarks", Id = 738944 })
	PlaySound({ Name = "/VO/CerberusBarks2", Id = 738944, Delay = 2 })
end
function AmbientCatsReaction( args )
	-- SetAnimation({ Name = "Familiar_Frog_Greet", DestinationId = 566831 })
	PlaySound({ Name = "/SFX/Familiars/CatMeowQuestioning", Id = 738722 })
	PlaySound({ Name = "/SFX/Familiars/CatMeowExclaim2", Id = 738722, Delay = 2 })
end
function AmbientCatsSmallReaction( args )
	PlaySound({ Name = "/SFX/Familiars/CatPurr", Id = 738722 })
end
function AmbientFrogsReaction( args )
	-- SetAnimation({ Name = "Familiar_Frog_Greet", DestinationId = 566831 })
	PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = 738668 })
	PlaySound({ Name = "/SFX/Familiars/FrogCroakAngry2", Id = 738668, Delay = 2 })
end

function EagleReaction ( args )
	local eagleId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "Eagle" })
	local eagleSound = GetRandomValue({ "/SFX/Enemy Sounds/EagleCall", "/SFX/Enemy Sounds/EagleAlerted", "/SFX/Enemy Sounds/EagleAttackScream" })
	PlaySound({ Name = eagleSound, Id = eagleId })
end

function FamiliarCosmeticReaction( args )

	args = args or {}
	wait( args.PreWait or 0 )
	local familiarId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = args.FamiliarType or "CatFamiliar" })
	local familiar = ActiveEnemies[familiarId]
	PlaySound({ Name = familiar.HappySound or "/EmptyCue", Id = familiar.ObjectId })
	if args.AngleTowardId ~= nil then
		AngleTowardTarget({ Id = familiarId, DestinationId = args.AngleTowardId, Duration = 0.3, EaseIn = 0.5, EaseOut = 0.5, })
	end
	SetAnimation({ Name = familiar.UnlockStartAnimation or familiar.HappyAnimation, DestinationId = familiar.ObjectId })

end

function PlayEmoteSimple( source, args, originalArgs )

	args = args or {}
	wait( args.Delay or 0, RoomThreadName )
	if not args.TargetId and not source then
		return
	end
	if args.BlockIfSourceHasStatusAnimation and source ~= nil and source.StatusAnimation ~= nil then
		return
	end
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

	CreateAnimation({ Name = animName, DestinationId = targetId, Group = args.Group or "Combat_UI_World", OffsetZ = args.OffsetZ })
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
	StopAnimation({ Name = animName, DestinationId = targetId })
	CreateAnimation({ Name = animName.."_End", DestinationId = targetId, Group = args.Group or "Combat_UI_World", OffsetZ = args.OffsetZ })

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

function WeaponFiredGenericPresentation( source, weaponData, args, triggerArgs )
	thread( GenericPresentation, source, args )
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
		SetAnimation({ Name = args.SetAnimation, DestinationId = args.Id or source.ObjectId, SpeedMultiplier = speedMultiplier })
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

	if args.RemoveOutline then
		RemoveOutline({ Id = source.ObjectId })
	end

	if args.AddOutline then
		AddOutline({ Id = source.ObjectId })
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
	if args.SetCameraClampIds ~= nil then
		SetCameraClamp({ Ids = args.SetCameraClampIds })
	end

	if args.LoadVoiceBanks ~= nil then
		LoadVoiceBank({ Names = args.LoadVoiceBanks, IgnoreAssert = args.IgnoreAssert })
	end
	if args.LoadPackages ~= nil then
		LoadPackages({ Names = args.LoadPackages, IgnoreAssert = args.IgnoreAssert })
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
	wait( args.PostWait )

end

function DestroyGroup( source, args )
	Destroy({ Ids = GetIds({ Name = args.GroupName }) })
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



function StartTimeSlowPresentation( duration )
	SessionState.TimeStopSoundId = PlaySound({ Name = "/SFX/TimeSlowStart" })
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
	if SessionState.TimeStopSoundId then
		StopSound({ Id = SessionState.TimeStopSoundId, Duration = 0.3 })
	end
	wait(0.3) 
	Destroy({ Id = ScreenAnchors.TimeStopVignette })
	ScreenAnchors.TimeStopVignette = nil
	SessionState.TimeStopSoundId = nil
end


function StartSpellSlowPresentation()
	thread( PlayVoiceLines, GlobalVoiceLines.ChronosSpellResistVoiceLines, true )
	local duration = 0.25
	SetAudioEffectState({ Name = "SpellCharge", Value = 1 })
	-- AdjustFullscreenBloom({ Name = "MoonDustBloom", Duration = duration })
	AdjustColorGrading({ Name = "MoonDust", Duration = duration })
	AdjustRadialBlurDistance({ Fraction = 0.05, Duration = duration })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = duration })
	if ConfigOptionCache.GraphicsQualityPreset ~= "GraphicsQualityPreset_Low" then
		CreateAnimation({ Name = "SpellSlowFx", DestinationId = CurrentRun.Hero.ObjectId })
	end
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

	if not encounter.SkipShipsEncounterSetup then
		wait(2.0, RoomThreadName)
	end
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

function TempArmorEndWarnPresentation()
	PlaySound({ Name = "/SFX/HexEndingWarning", Id = CurrentRun.Hero.ObjectId })
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.5, Color = Color.White,  ExpireAfterCycle = true })
end

function StartBlinkTrailPresentation()
	if not IsEmpty(MapState.BlinkDropTrail) then
		for id, ids in pairs(MapState.BlinkDropTrail) do	
			SetAnimation({ Name = "BlinkTrailFxOut", DestinationId = id, CopyFromPrev = true })
			thread(DestroyOnDelay, { id }, 0.1 )
		end
		
		MapState.BlinkDropTrail = {}
	end
	local initialId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing" })
	local blinkIds = { initialId }
	local blinkAnimationIds = {}
	local nextClipRegenTime  = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponBlink", Property = "ClipRegenInterval" }) or 0
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

function PreDamagePresentation( enemy, damageAmount, damageData )
	thread( DisplayDamageText, enemy, { DamageAmount = damageAmount, SourceProjectile = "Keepsake" } )
	PlaySound({ Name = "/SFX/StabSplatter", Id = enemy.ObjectId })
	--CreateAnimation({ Name = "ZeusLightningIris", DestinationId = enemy.ObjectId })
	if damageData.VoiceLines and damageData.VoiceLines ~= "null" then
		thread( PlayVoiceLines, damageData.VoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.OdysseusPreDamageVoiceLines, true )
	end
	local text = damageData.Text or "PreDamageHit"
	if enemy.UseGroupHealthBar and CurrentRun.CurrentRoom.Encounter ~= nil then
		thread( InCombatTextArgs, { TargetId = EnemyHealthDisplayAnchors[CurrentRun.CurrentRoom.Encounter.Name], OffsetY = 0, SkipRise = true, ScreenSpace = true, Group = "Overlay", Text = text, Duration = 1.5 } )
	elseif EnemyHealthDisplayAnchors[enemy.ObjectId] then
		thread( InCombatTextArgs, { TargetId = EnemyHealthDisplayAnchors[enemy.ObjectId], OffsetY = 0, SkipRise = true, ScreenSpace = true, Group = "Overlay", Text = text, Duration = 1.5 } )
	end
end

function HadesPreDamagePresentation( enemy, damageAmount, damageData )
	
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

	PlaySound({ Name = "/SFX/StabSplatterEndSequence", Id = enemy.ObjectId })

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

function SprintShieldTriggeredPresentation()
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "HitShields", Duration = 1.0 } )
	PlaySound({ Name = "/SFX/EurydiceKeepsakeProc", Id = CurrentRun.Hero.ObjectId })
end


function BossShieldTriggeredPresentation()
	if CheckCooldown( "HitShieldsText", 1.0 ) then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "HitShields", Duration = 1.0 } )
	end
	PlaySound({ Name = "/SFX/EurydiceKeepsakeProc", Id = CurrentRun.Hero.ObjectId })
end

function DaggerBlockTriggeredPresentation( functionArgs )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "RiposteHit", Duration = 1.0, ShadowScaleX = 0.7 } )

	CreateAnimation({ Name = "ArtemisParryFlare", DestinationId = CurrentRun.Hero.ObjectId, GroupName = "FX_Standing_Add" }) --nopkg
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteAttackingStaff", Id = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = functionArgs.ActivatedVfx, DestinationId = CurrentRun.Hero.ObjectId })
	waitUnmodified(0.05)
	CreateAnimation({ Name = functionArgs.ActivatedVfx, DestinationId = CurrentRun.Hero.ObjectId })			
end

function DaggerBlockClearedPresentation( functionArgs )
	StopAnimation({ Name = functionArgs.ActivatedVfx, DestinationId = CurrentRun.Hero.ObjectId })
end

function DaggerBlockActivePresentation( traitData, reloadTime )
	wait(reloadTime, "DaggerBlockShield" )
	if not CurrentRun.Hero.IsDead then
		PlaySound({ Name = "/SFX/Menu Sounds/KeepsakeArtemisArrow", Id = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/SFX/Menu Sounds/MenuMagicFlashLong", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "RiposteCooldown", Duration = 1.0, ShadowScaleX = 0.7 } )
		if ScreenAnchors.DaggerUI then
			SetAnimation({ Name = "StaffReloadTimerReady", SuppressSounds = true, DestinationId = ScreenAnchors.DaggerUI })
		end
	end
end

function PerfectChargeRefundPresentation()
	-- thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "StaffRefund", Duration = 1.0 } )
	-- PlaySound({ Name = "/Leftovers/SFX/PositiveTalismanProc_1", Id = CurrentRun.Hero.ObjectId })
end

function StopHephaestusVfx()
end

function AddReadiedMassiveAttackPresentation( traitName )
	local traitData = TraitData[traitName]
	if traitData.BlastReadyVfx and traitData.BlastReadyDarkVfx and SessionMapState.ReadiedMassiveAttacks[traitName] == nil and not MapState.HostilePolymorph then
		CreateAnimation({ Name = traitData.BlastReadyVfx, DestinationId = CurrentRun.Hero.ObjectId })
		CreateAnimation({ Name = traitData.BlastReadyDarkVfx, DestinationId = CurrentRun.Hero.ObjectId })
		SessionMapState.ReadiedMassiveAttacks[ traitName ] = true
	end
end

function AddReadiedMassiveAttackPolymorphPresentation()
	for massiveTraitName, v in pairs(SessionMapState.ReadiedMassiveAttacks) do
		local traitData = TraitData[massiveTraitName]
		if traitData.BlastReadyVfx ~= nil then
			CreateAnimation({ Name = traitData.BlastReadyVfx, DestinationId = CurrentRun.Hero.ObjectId })
		end
		if traitData.BlastReadyDarkVfx ~= nil then
			CreateAnimation({ Name = traitData.BlastReadyDarkVfx, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end
end

function RemoveReadiedMassiveAttackPresentation( traitName )
	local traitData = TraitData[traitName]
	if traitData.BlastReadyVfx ~= nil then
		StopAnimation({ Name = traitData.BlastReadyVfx, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if traitData.BlastReadyDarkVfx ~= nil then
		StopAnimation({ Name = traitData.BlastReadyDarkVfx, DestinationId = CurrentRun.Hero.ObjectId })
	end
	SessionMapState.ReadiedMassiveAttacks[traitName] = nil
end

function PlayerArmorBreakPresentation( traitData )

	thread( PlayerArmorBreakSimSpeed )

	local offsetY = -155
	CreateAnimations({
		DestinationId = CurrentRun.Hero.ObjectId,
		Anims =
		{
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
	-- these are also playing from SpellSummonPresentation
	-- PlaySound({ Name = "/SFX/Player Sounds/ApolloSpecialDetonateSFX", Id = newEnemy.ObjectId })
	-- CreateAnimation({ Name = "SorcerySummonPresentationFx", DestinationId = newEnemy.ObjectId })
	PlaySound({ Name = newEnemy.IsAggroedSound, Id = newEnemy.ObjectId })
	thread( InCombatText, newEnemy.ObjectId, "RaiseDeadActivated", 1.2, { PreDelay = 0.25, ShadowScaleX = 1.0, SkipFlash = true })
end

function BonusHealthAndManaPresentation( bonusHealth, bonusMana, delay)
	if delay then
		wait(delay )
	end
	CreateAnimation({ Name = "HealthSparkleShower", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/PlayerProjectileDeflect", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "MaxHealthAndManaIncrease", 0.9, { ShadowScaleX = 0.6, LuaKey = "TooltipData", LuaValue = {TooltipHealth = bonusHealth, TooltipMana = bonusMana }} )
end

function BonusManaPresentation( bonusMana )
	CreateAnimation({ Name = "HealthSparkleShower", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/PlayerProjectileDeflect", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "PostEncounterMaxManaIncrease", 0.9, { ShadowScaleX = 0.6, LuaKey = "TooltipData", LuaValue = { TooltipMana = bonusMana }} )
end

function PotionClearCastPresentation( duration )
	PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup", Id = CurrentRun.Hero.ObjectId})
	thread( DrainClearCastMeter, duration )
end

function PoseidonClearCastPresentation( )
	CreateAnimation({ Name = "PoseidonClearCastFx", DestinationId = CurrentRun.Hero.ObjectId })
end

function ShowCrystalPresentation( unit, args )
	args = args or {}
	local id = unit.ObjectId
 	CreateAnimation({ Name = "SerenityChargedBurst", DestinationId = id })
	local clearCastDuration = duration
	local activeCirceCrystals = args.Duration or 5
	local durationPerCrystal = activeCirceCrystals / 5
	local crystalFadeTime = 0.25
	local circeCrystals = {}
	SessionMapState.Crystals = {}
	for i = 1, activeCirceCrystals do
		circeCrystals[ "Front" .. i ] = SpawnObstacle({ Name = "BlankObstacle", DestinationId = id })
		circeCrystals[ "Back" .. i ] = SpawnObstacle({ Name = "BlankObstacle", DestinationId = id, Group = "FX_Dark" })
		Attach({ Id = circeCrystals[ "Front" .. i ], DestinationId = id })
		Attach({ Id = circeCrystals[ "Back" .. i ], DestinationId = id })
		SetAnimation({ Name = "CirceCrystalRotateFront" .. i, DestinationId = circeCrystals[ "Front" .. i ]})
		SetAnimation({ Name = "CirceCrystalRotateBack" .. i, DestinationId = circeCrystals[ "Back" .. i ]})
		table.insert( SessionMapState.Crystals, circeCrystals[ "Front" .. i ])
		table.insert( SessionMapState.Crystals, circeCrystals[ "Back" .. i ])
	end

	if unit.TargetHeight and unit.TargetHeight == unit.SkyHeight then
		SetAlpha({ Ids = SessionMapState.Crystals, Fraction = 0, Duration = 0 })
	end		
	
	while activeCirceCrystals > 0 do
		wait( durationPerCrystal - crystalFadeTime )
		local fadeCrystalIds = { circeCrystals[ "Front" .. activeCirceCrystals ], circeCrystals[ "Back" .. activeCirceCrystals ] }
		SetScale({ Ids = fadeCrystalIds, Fraction = 0.8, Duration = crystalFadeTime, EaseIn = 0, EaseOut = 1 })		
		SetColor({ Ids = fadeCrystalIds, Color = {1.0, 0.0, 1.0, 0.0}, Duration = crystalFadeTime, EaseIn = 0, EaseOut = 1 })
		wait( crystalFadeTime )
		PlaySound({ Name = "/SFX/CrystalPieceBreak", Id = fadeCrystalIds })
		Destroy({ Ids = fadeCrystalIds })
		activeCirceCrystals = activeCirceCrystals - 1
	end
	SessionMapState.Crystals = nil
end

function DrainClearCastMeter( duration )
 	CreateAnimation({ Name = "SerenityChargedBurst", DestinationId = CurrentRun.Hero.ObjectId })
	local clearCastDuration = duration
	local activeCirceCrystals = 5
	local durationPerCrystal = clearCastDuration / activeCirceCrystals
	local crystalFadeTime = 0.25
	local circeCrystals = {}

	for i = 1, activeCirceCrystals do
		circeCrystals[ "Front" .. i ] = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId })
		circeCrystals[ "Back" .. i ] = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Dark" })
		Attach({ Id = circeCrystals[ "Front" .. i ], DestinationId = CurrentRun.Hero.ObjectId })
		Attach({ Id = circeCrystals[ "Back" .. i ], DestinationId = CurrentRun.Hero.ObjectId })
		SetAnimation({ Name = "CirceCrystalRotateFront" .. i, DestinationId = circeCrystals[ "Front" .. i ]})
		SetAnimation({ Name = "CirceCrystalRotateBack" .. i, DestinationId = circeCrystals[ "Back" .. i ]})
	end

	while activeCirceCrystals > 0 do
		wait( durationPerCrystal - crystalFadeTime )
		local fadeCrystalIds = { circeCrystals[ "Front" .. activeCirceCrystals ], circeCrystals[ "Back" .. activeCirceCrystals ] }
		SetScale({ Ids = fadeCrystalIds, Fraction = 0.8, Duration = crystalFadeTime, EaseIn = 0, EaseOut = 1 })		
		SetColor({ Ids = fadeCrystalIds, Color = {1.0, 0.0, 1.0, 0.0}, Duration = crystalFadeTime, EaseIn = 0, EaseOut = 1 })
		wait( crystalFadeTime )
		PlaySound({ Name = "/SFX/CrystalPieceBreak", Id = fadeCrystalIds })
		Destroy({ Ids = fadeCrystalIds })
		activeCirceCrystals = activeCirceCrystals - 1
	end
end

function EndClearCastPresentation()
	StopAnimation({Name = "ErisPowerUpFx", DestinationId = CurrentRun.Hero.ObjectId })
end

function FrenzyStartAnimation()
	if ScreenAnchors.AxeUI then
		CreateAnimation({Name = "KeepsakeLevelUpFlare", DestinationId = ScreenAnchors.AxeUI, GroupName = "Overlay"})
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHowlSlam", Id = CurrentRun.Hero.ObjectId})
	end
end

function OverheatStartPresentation( triggerArgs )
	if ScreenAnchors.LobUI then
		CreateAnimation({Name = "KeepsakeLevelUpFlare", DestinationId = ScreenAnchors.LobUI, GroupName = "Overlay"})
	end
end

function PerfectDamageBoonRenewed()
	if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		return
	end
	PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup", Id = CurrentRun.Hero.ObjectId})
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "PerfectDamageBonusBoon_Triggered", Duration = 1.45, PreDelay = 0.1, LuaKey = "TempTextData", LuaValue = { TimeLeft = threshold } } )
end

function PerfectDamageBoonExpire()
	if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		return
	end
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "PerfectDamageBonusBoon_Expired", Duration = 1.45, PreDelay = 0.1, LuaKey = "TempTextData", LuaValue = { TimeLeft = threshold } } )
end
function MedeaCursePreChoicePresentation( source, args )
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1.0, Duration = 1.0 })
end

function KeepsakeScreenSaveFirstPresentation( button )
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitementShort", Id = button.Id })
end
function KeepsakeScreenClearSaveFirstPresentation( button )
	PlaySound({ Name = "/Leftovers/Menu Sounds/WaxUp", Id = button.Id })
end


function SetPlayerTempArmorPresentation( flag )
	if IsEmpty( SessionMapState.TempArmorPresentation ) then
		CreateAnimation({ Name = HeroData.TempArmorVfx, DestinationId = CurrentRun.Hero.ObjectId })
		CreateAnimation({ Name = "HephaestusArmorUp", DestinationId = CurrentRun.Hero.ObjectId })
	end
	SessionMapState.TempArmorPresentation[flag] = true
	SessionMapState.TempArmorPresentationOut[flag] = true
end

function CheckPlayerTempArmorFalloffPresentation( flag )
	SessionMapState.TempArmorPresentationOut[ flag ] = nil
	if IsEmpty( SessionMapState.TempArmorPresentationOut ) then
		CreateAnimation({ Name = "HephaestusArmorOut", DestinationId = CurrentRun.Hero.ObjectId })
		TempArmorEndWarnPresentation()
		return
	end
end

function RemovePlayerTempArmorPresentation( flag )
	SessionMapState.TempArmorPresentation[ flag ] = nil
	SessionMapState.TempArmorPresentationOut[ flag ] = nil
	if IsEmpty(SessionMapState.TempArmorPresentation) then
		StopAnimation({ Name = HeroData.TempArmorVfx, DestinationId = CurrentRun.Hero.ObjectId })
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
	CreateAnimation({ Name = "BiomeStateGoldFx", DestinationId = toastAnchor, OffsetX = 0, OffsetY = 0, Group = "Combat_Menu_Additive" })
	thread( InCombatTextArgs, { TargetId = toastAnchor, Text = "PermafySuccess", PreDelay = 0.05, Duration = 1.75, ShadowScaleX = 1.3, OffsetY = -190, Justification = "Center", FontSize = 30, LuaKey = "TempTextData", LuaValue = { Name = itemName } } )
	wait( 1.0 )
end

function DoubleBoonPresentation( screen, nextButton )
	wait( 0.05 )
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

function PoseidonPotionPresentation( consumable, args)
	CreateAnimation({ Name = "PoseidonElementalKnockupFxAlt", DestinationId = consumable.ObjectId })
end

function DoubleRewardPresentation( objectId )
	CreateAnimation({ Name = "PoseidonElementalKnockupFxAlt", DestinationId = objectId })
	ApplyUpwardForce({ Id = objectId, Speed = RandomFloat( 500, 700 ) })
	ApplyForce({ Id = objectId, Speed = RandomFloat( 75, 260 ), Angle = RandomFloat( 0, 360 ) })
	wait( 0.75 )
	thread( PlayVoiceLines, GlobalVoiceLines.PoseidonDoubleRewardReactionLines )

	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })
	local toastAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu_Additive" })
	DrawScreenRelative({ Id = toastAnchor })
	CreateAnimation({ Name = "BiomeStateGoldFx", DestinationId = toastAnchor, OffsetX = 0, OffsetY = 0, Group = "Combat_Menu_Additive" })
	thread( InCombatText, objectId, "Hint_DoubleItem", 0.75 )
end

function SkipEncounterPresentation( )

	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })
	PauseMusic()
	if AudioState.SkipEncounterMusicId == nil then
		AudioState.SkipEncounterMusicId = PlaySound({ Name = "/Music/MusicPlayer/Iris/DionysusMusicMusicPlayer" })
	end

	CreateGroup({ Name = "DiscoBall" })
	InsertGroupInFront({ Name = "DiscoBall", DestinationName ="Combat_UI"})

	CreateGroup({ Name = "DiscoBallAdditive", BlendMode = "Additive" })
	InsertGroupInFront({ Name = "DiscoBallAdditive", DestinationName = "DiscoBall" })

	local ball = SpawnObstacle({ Name = "3DDiscoBall_SkipEncounter", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = 1200, Group = "DiscoBall" })
	local chain = SpawnObstacle({ Name = "OlympusCeilingChain01", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = 1200, Group = "DiscoBall" })
	SetScale({ Id = chain, Fraction = 0.51 })
	Attach({ Id = chain, DestinationId = ball, OffsetY = -97 })
	Attach({ Id = ball, DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -650 })
	SetAlpha({ Ids = {ball, chain}, Fraction = 0 })
	
	SessionMapState.SkipEncounterIds = { ball, chain }

	wait( 0.25 )
	local hasTrait = false
	for k, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait ~= nil and trait.Title == "PersistentDionysusSkipKeepsake" then
			hasTrait = true
			break
		end
	end
	if hasTrait then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_EncounterSkip", 1.25 )
	else
		thread( InCombatText, CurrentRun.Hero.ObjectId, "SkipEncounterKeepsakeExpired", 1.25 )
	end
			

	wait( 0.5 )

	CreateAnimation({ Name =  "ProjectileTempFlare", DestinationId = ball, Scale = 2.0, OffsetY = 200 })
	SetAlpha({ Ids = {ball, chain}, Fraction = 1.0, Duration = 0.2 })

	PlaySound({ Name = "/SFX/DionysusBoonWineLaugh" })
	thread( PlayVoiceLines, GlobalVoiceLines.SkippedEncounterVoiceLines )

	local toastAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu_Additive" })
	DrawScreenRelative({ Id = toastAnchor })
	CreateAnimation({ Name = "BiomeStateGoldFx", DestinationId = toastAnchor, OffsetX = 0, OffsetY = 0, Group = "Combat_Menu_Additive" })

end

function SkipEncounterEndPresentation()
	
	if AudioState.SkipEncounterMusicId ~= nil then
		StopSound({ Id = AudioState.SkipEncounterMusicId, Duration = 0.3 })
		AudioState.SkipEncounterMusicId = nil
		PlaySound({ Name = "/SFX/Menu Sounds/RecordScratch" })
	end
	StopAnimation({ Name = "DiscoBallReflections_SkipEncounter", DestinationId = SessionMapState.SkipEncounterIds[1] })
	thread( DestroyOnDelay, ShallowCopyTable(SessionMapState.SkipEncounterIds), 1 )
	Unattach({ Id = SessionMapState.SkipEncounterIds[1], DestinationId = CurrentRun.Hero.ObjectId })
	Move({ Ids = SessionMapState.SkipEncounterIds, Angle = 90, Speed = 500, EaseIn = 0.99, EaseOut = 1.0 })
	wait(0.25)
	SetAlpha({ Ids = SessionMapState.SkipEncounterIds, Fraction = 0, Duration = 0.2 })
	
	SessionMapState.SkipEncounterIds = nil
end

function ConvertMetaRewardPresentation( sourceDrop )

	AddInputBlock({ Name = "ConvertMetaRewardPresentation" })
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
	RemoveInputBlock({ Name = "ConvertMetaRewardPresentation" })

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





function ChronosRepulseFromObject( object, args, triggerArgs )
	triggerArgs = triggerArgs or {}
	if not triggerArgs.SourceWeapon then
		return
	end
	local validWeapons = ConcatTableValues( ShallowCopyTable( WeaponSets.HeroAllWeapons ), AddLinkedWeapons( WeaponSets.HeroAllWeapons ) )
	if not Contains(validWeapons, triggerArgs.SourceWeapon ) then
		return
	end
	RepulseFromObject( object, args )
end

function ChronosNPCSetup( source, args )
	args = args or {}
	CheckDistanceTriggerThread( source, PresetEventArgs.ChronosGreeting )
	if args.RequiredRoomInteraction then
		MapState.RoomRequiredObjects[source.ObjectId] = source
	end
end
function NeoChronosNPCSetup( source, args )
	args = args or {}
	if args.HideUntilWithinDistance then
		SetAlpha({ Id = source.ObjectId, Fraction = 0.0 })
		source.Hidden = true
	end
	CheckDistanceTriggerThread( source, PresetEventArgs.NeoChronosGreeting )
	if args.RequiredRoomInteraction then
		MapState.RoomRequiredObjects[source.ObjectId] = source
	end
end
function NeoChronosAppear( source, args )
	if source.Hidden then
		SetAlpha({ Id = source.ObjectId, Fraction = 1.0, Duration = 0.3 })
		CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = source.ObjectId })
		source.Hidden = nil
	end
end

function CirceRemoveShrinePresentation( shrineUpgradeName, delay )
	wait( delay )
	local offsetY = -100
	PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "ShrineUpgradeRemoved_CombatText", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScale = 0.75, ShadowScaleX = 1.28, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = shrineUpgradeName }})	
end

function CirceEnlargePresentation()

	PlaySound({ Name = "/SFX/Enemy Sounds/Wringer/WringerChargeUp", Id = CurrentRun.Hero.ObjectId, Delay = 1.0 })


end

function CirceShrinkPresentation()

	PlaySound({ Name = "/SFX/ThanatosHermesKeepsakeFail", Id = CurrentRun.Hero.ObjectId, Delay = 1.0 })

end

function BouldyBlessingPresentation( traitName )

	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "GainedBouldyBlessing", SkipRise = false, SkipFlash = false, Duration = 1.0, ShadowScale = 0.75, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
end


function UnlockCosmeticsShop( source, args )

	args = args or {}

	OverwriteSelf( source, source.PostActivateEvents[1].Args )

	DisplayInfoToast( source, { WaitTime = 3.1, Title = "Toast_CosmeticShop_Title", Text = "Toast_CosmeticShop_Subtitle", Duration = 2, GiftResource = true, GiftWaitTime = 0, ResourceName = "CosmeticsPoints", ResourceAmount = 300, SoundName = "/Leftovers/Menu Sounds/WellPurchase_Fabric" } )

	wait(0.5)

	CheckObjectiveSet( "DoraDecorationIntroPrompt" )
end


function NemesisDamageContestStartPresentation( source, args )
	thread( PlayVoiceLines, source.StartDamageContestVoiceLines, nil, source )
	source.SkipInvulnerableOnHitPresentation = true
	SetAnimation({ Name = "Nemesis_Hub_Equip", DestinationId = source.ObjectId })
end

function NemesisDamageContestCountdownPresentation( source, args, timeRemaining )
	thread( InCombatText, source.ObjectId, "NemesisDamageContestCountdown", 0.65, { LuaKey = "TempTextData", LuaValue = { TimeRemaining = timeRemaining } } )
	local bellSound = PlaySound({ Name = "/SFX/ThanatosAttackBell", })
	SetVolume({ Id = bellSound, Value = 0.3 })
end

function NemesisDamageContestHitPresentation( source, args )
	SetAnimation({ Name = "Nemesis_Combat_OnHit", DestinationId = source.ObjectId })
end

function NemesisDamageContestFinalHitPresentation( source, args )
	SetAnimation({ Name = "Nemesis_Combat_Knockdown_Start", DestinationId = source.ObjectId })
end

function NemesisDamageContestSuccessPresentation( source, args )
	wait( 0.55 )
	SetAnimation({ Name = "Nemesis_Combat_Unequip", DestinationId = source.ObjectId })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	wait( 1.05 )
	thread( PlayVoiceLines, source.PlayerWonDamageContestVoiceLines, nil, source )
	source.SkipInvulnerableOnHitPresentation = false	
	ShakeScreen({ Speed = 300, Distance = 2, FalloffSpeed = 4000, Duration = 0.5 })
	-- PlaySound({ Name = "/Leftovers/SFX/PositiveTalismanProc_3" })
	-- CreateAnimation({ Name = "PowerUpPerfectDash", DestinationId = source.ObjectId })
	wait (0.4)
end

function NemesisDamageContestGreatSuccessPresentation( source, args )
	SetAnimation({ Name = "Nemesis_Combat_Knockdown_End", DestinationId = source.ObjectId })
	wait( 1.05 )
	SetAnimation({ Name = "Nemesis_Combat_Unequip", DestinationId = source.ObjectId })
	wait( 1.05 )
	thread( PlayVoiceLines, source.PlayerWonDamageContestBigVoiceLines, nil, source )
	source.SkipInvulnerableOnHitPresentation = false	
	ShakeScreen({ Speed = 300, Distance = 2, FalloffSpeed = 4000, Duration = 0.5 })
	-- PlaySound({ Name = "/Leftovers/SFX/PositiveTalismanProc_3" })
	-- CreateAnimation({ Name = "PowerUpPerfectDash", DestinationId = source.ObjectId })
	wait (0.4)
end

function NemesisDamageContestFailPresentation( source, args )
	SetAnimation({ Name = "Nemesis_Combat_Unequip", DestinationId = source.ObjectId })
	wait( 1.05 )
	thread( PlayVoiceLines, source.PlayerLostDamageContestVoiceLines, nil, source )
	source.SkipInvulnerableOnHitPresentation = false
	ShakeScreen({ Speed = 300, Distance = 2, FalloffSpeed = 4000, Duration = 0.5 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	CreateAnimation({ Name = "ShoutFlare", DestinationId = source.ObjectId })
	wait (0.4)
end







function EchoLastRunBoonPresentation( traitName )
	wait(1.25)
	CreateAnimation({ Name = "KeepsakeLevelUpFlare", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "EchoLastRunBoon_CombatText", 2.0 , { ShadowScaleX = 1.35, LuaKey = "TempTextData", LuaValue = { Name = tostring(traitName) } })
end

function EchoDoubleBoonLevelPresentation( traitName )
	wait(1.25)
	CreateAnimation({ Name = "KeepsakeLevelUpFlare", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "EchoDoubleBoonLevel_CombatText", 2.0 , { ShadowScaleX = 1.35, LuaKey = "TempTextData", LuaValue = { Name = tostring(traitName) } })
end

function CerberusReaction( usee, args )

	local cerberusId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "NPC_Cerberus_Field_01" })
	local cerberusSounds =
	{
		"/VO/CerberusWhineHappy",
		"/VO/CerberusWhineSad",
		"/VO/CerberusGrowl",
	}
	local cerberusSound = GetRandomValue( cerberusSounds )
	PlaySound({ Name = cerberusSound, Id = cerberusId, Delay = 0.5 })

end



function ChaosRewardIncreasedPresentation( sourceId, delay )
	waitUnmodified(delay, RoomThreadName)
	PlaySound({ Name = "/Leftovers/SFX/DoorStateChangeRewardAppearance" })
	thread( InCombatTextArgs, { TargetId = sourceId, Text = "IncreasedResourceSuccess", Duration = 0.75 })
end

function ChaosManaDrainPresentation()
	if CheckCooldown("ChaosManaDrain", 0.5) then
		CreateAnimation({ Name = "SacrificeManaFx", DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function SpawnHermesInPerson( source, args )
	local unitData = EnemyData[args.UnitName]
	local unit = DeepCopyTable( unitData )
	unit.RoomRequiredObject = true

	unit.ObjectId = SpawnUnit({ Name = unitData.Name, Group = "Standing", DestinationId = args.SpawnPoints[CurrentRun.CurrentRoom.Name] or source.ObjectId })

	local runningSoundId = PlaySound({ Name = "/SFX/Player Sounds/HermesRushSpeedTrailSFX", Id = unit.ObjectId })
	SetVolume({ Id = runningSoundId, Value = 0.0, Duration = 1.6 })

	SetupUnit( unit, CurrentRun, { IgnorePackages = true } )
	AddInteractBlock( unit, "SpawnHermesInPerson" )
	SetAlpha({ Id = unit.ObjectId, Fraction = 0.0, Duration = 0.0 })
	wait( 0.05 )

	wait( args.WaitTime or 2.0)

	local hermesTraits = {}
	for _, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.OnExpire and trait.OnExpire.SpawnShopItem then
			table.insert( hermesTraits, trait )
		end
	end
	if not IsEmpty( hermesTraits ) then
		SessionMapState.HasSurfaceShopDelivery = true
	end

	if not args.SkipCheckTextLines then
		CheckAvailableTextLines( unit, args )
	end
	thread( PlayVoiceLines, GlobalVoiceLines.HermesFirstSpawnVoiceLines )

	if not args.SkipMusic then
		SecretMusicPlayer( unit.ThemeMusic )
		SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 0 })
		SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 0 })
		SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1 })
	end

	if not args.SkipPan then
		PanCamera({ Ids = { unit.ObjectId, CurrentRun.Hero.ObjectId}, Duration = args.PanTime or 3.0, Retarget = true, FromCurrentLocation = true })
	end
	wait( 0.1 )
	StartHermesVisualEffects( unit )
	SetAnimation({ Name = "Hermes_Enter", DestinationId = unit.ObjectId })
	SetAlpha({ Id = unit.ObjectId, Fraction = 1.0, Duration = 0.3 })
	wait( args.PostWaitTime or 0.6 )
	RemoveInteractBlock( unit, "SpawnHermesInPerson" )
	if args.AngleTowardCharon then
		AngleTowardTarget({ Id = unit.ObjectId, DestinationId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Charon_01" }), Duration = 0.1 })
	else
		AngleTowardTarget({ Id = unit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Duration = 0.1 })
	end
	for _, trait in pairs( hermesTraits ) do
		RemoveTraitData( CurrentRun.Hero, trait, { Silent = true })
	end
	waitUntil( "HermesUsed" )
end

function StartHermesVisualEffects( unit )
	AdjustFullscreenBloom({ Name = "DesaturatedLight", Duration = 0.3 })
	AdjustColorGrading({ Name = "Ascension", Duration = 0.3 })
	CreateAnimation({ Name = "HermesDashBase", DestinationId = unit.ObjectId })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.5 })
	CreateAnimation({ Name = "HermesWings", DestinationId = unit.ObjectId })
	PlaySound({ Name = "/SFX/HermesBoonWhoosh", Id = unit.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.3 }, } )
	thread( EndHermesEntranceVisuals )
end

function EndHermesEntranceVisuals( )
	wait( 1.5 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 1 })
	AdjustColorGrading({ Name = "Off", Duration = 1 })
end

function RemoveHermesInPerson( source, args )
	args = args or {}
	AddInteractBlock( source, "RemoveHermesInPerson" )

	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 1.1 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.1 })
	ShakeScreen({ Speed = 500, Distance = 5, FalloffSpeed = 1000, Duration = 1.0 })

	if args.EndThemeMusic then
		StopSecretMusicTheme( source )
	end
	
	wait( args.WaitTime or 1.0 )

	SetGoalAngle({ Id = source.ObjectId, Angle = 320, })
	SetAnimation({ Name = "Hermes_Exit", DestinationId = source.ObjectId, })
	if not args.SkipPan then
		PanCamera({ Ids = CurrentRun.Hero.ObjectId, Duration = 1.5, Retarget = true })
	end

	wait( 0.85 )

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1 })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.3 })

	source.SpecialInteractFunctionName = nil
	source.CanReceiveGift = false
	source.Mute = true
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = source.ObjectId, Property = "StopsProjectiles", Value = false })

	CreateAnimation({ Name = "HermesWings", DestinationId = source.ObjectId })
	StartHermesVisualEffects( source )
	local runningSoundId = PlaySound({ Name = "/SFX/Player Sounds/HermesRushSpeedTrailSFX", Id = source.ObjectId })
	SetVolume({ Id = runningSoundId, Value = 0.0, Duration = 3 })

	if not args.SkipBoonDrop then
		local loot = GiveLoot({ SpawnPoint = source.ObjectId, OffsetX = 50, OffsetY = 50, ForceLootName = "HermesUpgrade" })
		loot.BlockTextLines = true
		loot.NotifyName = "HermesUsed"
	end

	MapState.RoomRequiredObjects[source.ObjectId] = nil
	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end
end

function AresRendApplyPresentation( unit, triggerArgs, functionArgs )
	if not unit or unit.SkipModifiers or unit.CannotDieFromDamage or triggerArgs.Reapplied or (functionArgs.IgnoreProjectile and triggerArgs.SourceProjectile == functionArgs.IgnoreProjectile) then
		return
	end
	PlaySound({ Name = "/SFX/AresRendApply", Id = unit.ObjectId, ManagerCap = 46 })
	waitUnmodified( 0.10 )
	CreateAnimation({ Name = "AresMissingDamageFx", DestinationId = unit.ObjectId, Angle = triggerArgs.ImpactAngle }) -- nopkg
	if not functionArgs.HitSimSlowParametersFalseTraitName or not HeroHasTrait( functionArgs.HitSimSlowParametersFalseTraitName ) then
		DoWeaponHitSimulationSlow( unit, triggerArgs, functionArgs )
	end
end

function FirstSummonHitPresentation( unit, triggerArgs, functionArgs )
	if not unit or unit.SkipModifiers or unit.CannotDieFromDamage or triggerArgs.Reapplied or (functionArgs.IgnoreProjectile and triggerArgs.SourceProjectile == functionArgs.IgnoreProjectile) then
		return
	end
	PlaySound({ Name = "/SFX/AresRendApply", Id = unit.ObjectId, ManagerCap = 46 })
	waitUnmodified( 0.10 )
	CreateAnimation({ Name = "AresMissingDamageFx", DestinationId = unit.ObjectId, Angle = triggerArgs.ImpactAngle }) -- nopkg
	if not functionArgs.HitSimSlowParametersFalseTraitName or not HeroHasTrait( functionArgs.HitSimSlowParametersFalseTraitName ) then
		DoWeaponHitSimulationSlow( unit, triggerArgs, functionArgs )
	end
end

function PoseidonSprintBallDetachPresentation( targetId )
	local attachedTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId })
		
	PlaySound({ Name = "/SFX/Player Sounds/PoseidonWaterDashUpgrade", Id = attachedTargetId })

	thread(DestroyOnDelay, {attachedTargetId}, 0.1 )
end






function MoneyShieldBlockPresentation( blockedDamage, moneySpent )
	thread(InCombatText, CurrentRun.Hero.ObjectId, "MoneyHit", 0.3, {SkipShadow = true, SkipFlash = true, FontSize = 36, LuaKey = "TempTextData", LuaValue = { Amount = moneySpent }})
	CreateAnimation({ Name = "MoneyDropCoinPickup", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = 120})
	PlaySound({ Name = "/SFX/GoldCoinJackpotUrnDeath", Id = CurrentRun.Hero.ObjectId })
end

function MoneyShieldDeactivatedPresentation()
	wait(0.3)
	if not CurrentRun.Hero.IsDead then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "OutOfMoney", 0.8 )
		PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	end
end

function StoreRestockPresentation( button )
	CreateAnimation({ Name = "BoonEntranceLegendary", DestinationId = button.Id }) 
end

function WorldShopItemRestockPresentation( targetId )
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = targetId, Scale = 0.5 })
	CreateAnimation({ Name = "HermesWings", DestinationId = targetId })
end

function GrantedLowHealthBonusBuffStatePresentation( traitName, args, presentationArgs )
	local presentationArgs = presentationArgs or {}
	local startDelay = presentationArgs.TotalDelay or 0.5
	LowHealthBonusBuffStatePresentation( startDelay + 0.5 )	
end

function RoomStartLowHealthBonusBuffStatePresentation()
	if CurrentRun and GetPreviousRoom( CurrentRun ) and GetPreviousRoom( CurrentRun ).NextRoomEntranceFunctionArgsOverride  and GetPreviousRoom( CurrentRun ).NextRoomEntranceFunctionArgsOverride.NotifyName  then
		waitUntil(GetPreviousRoom( CurrentRun ).NextRoomEntranceFunctionArgsOverride.NotifyName)
	end
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.EncounterType ~= "Boss" then
		local waitTime = CurrentRun.CurrentRoom.EntrancePresentationDelay or 0.8	
		thread(LowHealthBonusBuffStatePresentation, waitTime )
	end
end
function LowHealthBonusBuffStatePresentation( delay )
	wait( delay )
	local offsetY = -100
	if HeroHasTrait("LowHealthBuffMetaUpgrade") then
		if not HasLastStand( CurrentRun.Hero ) then
			thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "NoLastStandsEffectActivated", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = "LowHealthBuffMetaUpgrade" }})	
			PlaySound({ Name = "/Leftovers/SFX/PlayerMovementPower", Id = CurrentRun.Hero.ObjectId })
		else
			thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "NoLastStandsEffectDeactivated", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = "LowHealthBuffMetaUpgrade" }})	
			PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = CurrentRun.Hero.ObjectId })
		end
	end
end

function FatedValidityStatePresentation( delay )
	wait( delay )
	local offsetY = -100
	if PreRunIsFateValid() then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "NoRerollEffectActivated", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY })	
		PlaySound({ Name = "/Leftovers/SFX/PlayerMovementPower", Id = CurrentRun.Hero.ObjectId })
	else
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "NoRerollEffectDeactivated", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY })	
		PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	end
end
function InRunFateDisabledPresentation( delay )
	wait( delay )
	local offsetY = -100
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "NoRerollEffectDeactivated", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY })	
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
end

function InRunHadesBoonRemoved( traitName, delay )
	wait( delay )
	local offsetY = -100
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "HadesBoonRemoved", ShadowScaleX = 1.5, SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})	
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
end

function BankPayoutPresentation( amount, delay ) 
	thread( InCombatTextArgs, { PreDelay = 0.5, TargetId = CurrentRun.Hero.ObjectId, Text = "BankBoonPayout_CombatText", Duration = 1.0, LuaKey = "TempTextData", ShadowScaleX = 1.1, LuaValue = { Amount = amount }} )
	PlaySound({ Name = "/Leftovers/Menu Sounds/MakingMoneyChaChing", Delay = 0.5 })
end

function ArachneCombatRewardSpawnPresentation(cocoon, args)
	CreateAnimation({ DestinationId = cocoon.ObjectId, Name = "ItemGet" })
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })
end

function LastShotFiredPresentation( triggerArgs )
	CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "LobMelLastAmmoFlash" })
	PlaySound({ Name = "/Leftovers/SFX/AuraPerfectThrow", Id = CurrentRun.Hero.ObjectId })
end

function SwapAnimations( source, args )
	for fromAnim, toAnim in pairs( args ) do
		SwapAnimation({ Name = fromAnim, DestinationName = toAnim })
	end
end

function SetupCerberusStory( source, args )
	if args.ActivateUnitsByType ~= nil then
		ActivatePrePlaced( source, { LegalTypes = args.ActivateUnitsByType } )
	end
	if args.ActivateIdsByGroup ~= nil then
		local ids = GetInactiveIds({ Names = args.ActivateIdsByGroup })
		Activate({ Ids = ids })
	end
end

function DisplayTrueEndingInfoBanner( source, args )

	AddInputBlock({ Name = "DisplayTrueEndingInfoBanner" })

	if AudioState.PostCreditsMusicId ~= nil then
		StopSound({ Id = AudioState.PostCreditsMusicId, Duration = args.PostCreditsMusicFadeOutDuration })
		AudioState.PostCreditsMusicId = nil
	end

	wait( args.PreWait )

	local backgroundId = CreateScreenObstacle({
		Name = "rectangle01",
		X = ScreenCenterX,
		Y = ScreenCenterY,
		Group = "Combat_Menu_TraitTray_Overlay",
		Scale = 10,
		Color = {8, 20, 15, 255},
		Alpha = 0.0,
		AlphaTarget = 1.0,
		AlphaTargetDuration = 0.4
	})

	local infoBannerDuration = 5.55

	thread( DisplayInfoBanner, nil, {
		TitleText = args.Title,
		TitleTextWidth = 1700,
		FontScale = 1.35,
		TextOffsetY = 210,
		SkipTextScaling = true,
		Color = {0, 255, 168, 255},
		TextColor = args.TextColor or Color.White,
		TextRevealSound = args.Stinger,
		Duration = infoBannerDuration,
		TitleFont = "SpectralSCLightTitling",
		Layer = "Combat_Menu_TraitTray_Overlay",
		AdditionalAnimation = "TrueEndingBannerFx",
		AnimationName = "InfoBannerTrueEndingIn",
		AnimationOutName = "InfoBannerTrueEndingOut",
	} )

	wait( infoBannerDuration )

	SetAlpha({ Id = backgroundId, Fraction = 0.0, Duration = 0.3 })
	wait( 0.3 )
	Destroy({ Id = backgroundId })

	if args.EndFunctionName ~= nil then
		CallFunctionName( args.EndFunctionName )
	end

	RemoveInputBlock({ Name = "DisplayTrueEndingInfoBanner" })

end

function PostEpiloguePresentation( source, args )

	AddInputBlock({ Name = "PostEpiloguePresentation" })

	wait( 0.1 )
	StopAmbientSound({ All = true })
	SetAudioEffectState({ Name = "Reverb", Value = 1.5 })
	StopSecretMusic()
	if not args.SkipInitialWait then
		wait( 3.5 )
	end

	FadeOut({ Color = Color.Black, Duration = 0.1 })
	SecretMusicPlayer( "/Music/MusicExploration1_MC" )
	wait( 1.5 )
	FadeIn({ Color = Color.Black, Duration = 2.0 })

	local gameOutroData = DeepCopyTable( GameOutroData.Outro_Epilogue01 )
	GameState.PlayedRunOutros[gameOutroData.Name] = true
	gameOutroData.Header = gameOutroData.Header or gameOutroData.Name

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })
	RunInterstitialPresentation( gameOutroData,
		{
			SkipFadeIn = true,
			SkipSound = true,
			Animations =
			{
				{
					AnimationName = "ElysiumPetalSpawner",
					GroupName = "Combat_Menu_Overlay",
					X = ScreenCenterNativeOffsetX,
					Y = ScreenCenterNativeOffsetY,
				},
				{
					AnimationName = "PalaceSunFlare_Epilogue",
					GroupName = "Combat_Menu_Overlay_Additive",
					X = ScreenCenterNativeOffsetX + 1000,
					Y = ScreenCenterNativeOffsetY - 300,
				},
				{
					AnimationName = "EpilogueOutro",

					Alpha = 0.0,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 1.0,

					Scale = 1,
					ScaleEaseIn = 0.0,
					ScaleEaseOut = 1.0,
				},
			},
		} )

	FadeIn({ Duration = 0.5 })
	StopSecretMusic()
	wait( 1.25 )

	DisplayTrueEndingInfoBanner( nil, args )

	RemoveInputBlock({ Name = "PostEpiloguePresentation" })

end

function ZagreusDeathDefiancePresentation( boss, currentRun, aiStage )
	AddTimerBlock( CurrentRun, "ZagreusDeathDefiancePresentation")
	SetPlayerInvulnerable( "ZagreusDeathDefiancePresentation" )
	AddInputBlock({ Name = "ZagreusDeathDefiancePresentation" })
	SetUnitInvulnerable( boss )
	
	if boss.PreAttackLoopingSound ~= nil then
		StopSound({ Id = boss.PreAttackLoopingSoundId, Duration = 0.2 })
		boss.PreAttackLoopingSoundId = nil
	end

	thread( PlayVoiceLines, boss.PhaseEndedVoiceLines, nil, boss )
	Stop({ Id = boss.ObjectId })
	
	boss.CurrentPhase = boss.CurrentPhase + 1

	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	if not IsEmpty( boss.StopAnimationsOnHitStun ) then
		StopAnimation({ Names = boss.StopAnimationsOnHitStun, DestinationId = boss.ObjectId, PreventChain = true })
	end

	AdjustColorGrading({ Name = "DeathDefianceSubtle", Duration = secondChanceFxInTime, Delay = 0.0, })
	SetAnimation({ Name = "Enemy_Zagreus_DeathDefiance", DestinationId = boss.ObjectId })
	CreateAnimation({ Name = "ZagreusDeathDefianceBlood", DestinationId = boss.ObjectId })
	SetGoalAngle({ Id = boss.ObjectId, Angle = 270 })
	PanCamera({ Id = boss.ObjectId, Duration = 0.30 })
	FocusCamera({ Fraction = 1.03, Duration = 0.045, ZoomType = "Ease" })
	wait( 0.25, boss.AIThreadName )
	AddSimSpeedChange( "LastStand", { Fraction = 0.005, LerpTime = 0.0001, Priority = true } )

	local textLines = GetRandomEligibleTextLines( boss, boss.BossPhaseChangeTextLineSets, GetNarrativeDataValue( boss, "BossPhaseChangeTextLinePriorities" ) )
	boss.TextLinesUseWeaponIdle = true
	PlayTextLines( boss, textLines )

	PlaySound({ Name = "/SFX/DeathDefianceActivate", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/VO/ZagreusEmotes/EmoteCharging", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, boss.NextPhaseVoiceLines, nil, boss )
	thread( CrowdReactionPresentation, { AnimationNames = { "StatusIconGrief", "StatusIconOhBoy", "StatusIconEmbarrassed" }, Sound = "/SFX/TheseusCrowdBoo", ReactionChance = 0.05, Delay = 1, Shake = true, RadialBlur = true } )
	thread( InCombatText, boss.ObjectId, "Hint_ExtraChance_Zagreus", 0.9, { ShadowScale = 0.66, OffsetY = 75 } )

	boss.MaxHealth = aiStage.NewMaxHealth or boss.MaxHealth
	boss.Health = boss.MaxHealth
	if aiStage.SetHealthPercent ~= nil then
		boss.Health = boss.Health * aiStage.SetHealthPercent
	end
	thread(BossHealthBarPresentation, boss )

	local secondChanceFxOutTime = 0.4
	AdjustRadialBlurStrength({ Fraction = 0, Duration = secondChanceFxOutTime  })
	AdjustFrame({ Duration = secondChanceFxOutTime, Fraction = 0 })
	AdjustFullscreenBloom({ Name = "DeathDefiance", Duration = secondChanceFxOutTime * 0.1 })

	waitUnmodified( 1.0, RoomThreadName )

	AdjustColorGrading({ Name = "Off", Duration = secondChanceFxOutTime * 1.5 })
	RemoveSimSpeedChange( "LastStand", { LerpTime = secondChanceFxOutTime } )
	AdjustFullscreenBloom({ Name = "Off", Duration = secondChanceFxOutTime * 0.5 })

	waitUnmodified( 0.4, RoomThreadName )

	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = secondChanceFxOutTime, ZoomType = "Ease" })
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.0 })
	RemoveInputBlock({ Name = "ZagreusDeathDefiancePresentation" })
	SetPlayerVulnerable( "ZagreusDeathDefiancePresentation" )
	ShowCombatUI("ZagreusDeathDefiancePresentation")
	
	RemoveFromGroup({ Id = boss.ObjectId, Names = { "Combat_Menu" } })
	AddToGroup({ Id = boss.ObjectId, Name = "Standing", DrawGroup = true })
	
	SetUnitVulnerable( boss )
	wait(0.5, boss.AIThreadName)

	RemoveTimerBlock( CurrentRun, "ZagreusDeathDefiancePresentation")
end

function HideGameplayTimers()
	CurrentRun.ActiveBiomeTimer = false
	SetConfigOption({ Name = "BlockGameplayTimer", Value = true })
end

function GoldifyPresentation( source )
	AddInputBlock({ Name = "GoldifyPresentation" })
	SessionMapState.GoldifySource = source.Name
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	wait( 0.02)
	PlayInteractAnimation( source.ObjectId, { Animation = GetEquippedWeaponValue( "WeaponInteractAnimation" ) })
	RemoveInputBlock({ Name = "GoldifyPresentation" })
	wait( 0.2 )
	CreateAnimation({ Name = "ChronosGoldifyFx", DestinationId = source.ObjectId })
	ShakeScreen({ Speed = 200, Distance = 5, Angle = 90, Duration = 0.15 })
	thread( PlayVoiceLines, GlobalVoiceLines.ChronosGoldifyVoiceLines )
	wait( 0.1 )
	PlaySound({ Name = "/SFX/GoldCoinRewardUse" })
end

function PickSpawnAngle(unit, args)
	if unit.SpawnAnglePerMap ~= nil and unit.SpawnAnglePerMap[CurrentRun.CurrentRoom.Name] ~= nil then
		SetAngle({ Id = unit.ObjectId, Angle = unit.SpawnAnglePerMap[CurrentRun.CurrentRoom.Name] })
	end
end