function ManaRegenPresentation( delta )
	if CheckCooldown( "ManaRegen", 0.3 ) then
		CreateAnimation({ Name = "ManaRegenFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
	end
end

function WeaponFailedNoManaPresentation( weaponData, args )
	thread( PlayVoiceLines, GlobalVoiceLines.OutOfManaVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ManaBarLowPulseA", DestinationId = HUDScreen.Components.ManaMeterFill.Id, GroupName = "Combat_UI_Additive" })
end

function ManaRefundPresentation( weaponData, functionArgs )
	CreateAnimation({ Name = "HermesWings", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
end

function ManaChargeCompletePresentationThread( weaponData, duration )
	waitUnmodified( duration, "ManaChargeComplete" )
	
	if TableLength( GetWeaponChargeStages( weaponData ) ) <= 1 or GetWeaponProperty({ WeaponName = weaponData.Name, Id = CurrentRun.Hero.ObjectId, Property = "MaxChargeStageCache", DataValue = false}) then
		ManaChargeCompletePresentation( weaponData, true )
	end
end

function ManaChargeCompletePresentation( weaponData, maxStage )
	if maxStage and not weaponData.ManualSetMaxChargeCache then
		SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "MaxChargeStageCache", Value = true, DataValue = false })
	end
	if MapState.ManaChargeIndicatorIds and MapState.ManaChargeIndicatorIds.BackingId then
		CreateAnimation({ DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Name = "ChargeIndicatorManaSparkleShower" })
		local animationName = ManaIndicatorPresentation.Hold.Fill
		if MapState.ManaChargeIndicatorData and MapState.ManaChargeIndicatorData.Fill then
			animationName = MapState.ManaChargeIndicatorData.Fill
		end
		SetAnimationFrameTarget({ Name = animationName, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Fraction = 1, Instant = true })
		SetAnimation({ Name = animationName, DestinationId = MapState.ManaChargeIndicatorIds.BackingId , PlaySpeed = 0, Scale = 1.0, OffsetY = -50 })		
		Flash({ Id = MapState.ManaChargeIndicatorIds.BackingId, Speed = 4, MinFraction = 0.5, MaxFraction = 0.9, Color = Color.White, Duration = 0.3 })
	end
end



function WeaponCooldownOutOfMana( weaponData, args, triggerArgs )
	args = args or {}
	triggerArgs = triggerArgs or {}
	if args.RequireNotFreshInput and triggerArgs.FreshInput then
		return
	end
	if CheckCooldown( weaponData.Name.."OutOfManaFunction", args.Cooldown or 0.5 )  then
		WeaponFailedNoManaPresentation (weaponData, {Force = true })
	end
end

function SetManaIndicatorDisallowed( weaponName, onCreation, manaValue)
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "OutOfManaHintCache", Value = true, DataValue = false })
	local duration = 0.1
	if onCreation then
		duration = 0
	end
	if MapState.ChargedManaWeapons and MapState.ChargedManaWeapons[weaponName] ~= nil and not IsEmpty( MapState.ManaChargeIndicatorIds ) then		
		for i, name in pairs( ManaGatherAnimations ) do
			StopAnimation({ Names = name, DestinationId = CurrentRun.Hero.ObjectId })
		end
		CreateAnimation({ Name = ManaGatherAnimations.OOM, DestinationId = CurrentRun.Hero.ObjectId })
		SetColor({ Id = MapState.ManaChargeIndicatorIds.BackingId, Color = Color.Red, Duration = duration })
		if manaValue then
			ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, Text = manaValue, FadeTarget = 0.3, FadeDuration = duration, ColorTarget = Color.Red, ColorDuration = duration })
		else
			ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, FadeTarget = 0.3, FadeDuration = duration, ColorTarget = Color.Red, ColorDuration = duration })	
		end
		--SetColor({ Id = MapState.ManaChargeIndicatorIds.PipId, Color = Color.Red, Duration = 0 })
		SetAlpha({ Id = MapState.ManaChargeIndicatorIds.PipId, Fraction = 0.3, Duration = 0 })
		Flash({ Id = MapState.ManaChargeIndicatorIds.BackingId, Speed = 3, MinFraction = 0.4, MaxFraction = 0.8, Color = Color.Red, Duration = 3.0 })
		Flash({ Id = MapState.ManaChargeIndicatorIds.PipId, Speed = 3, MinFraction = 0.0, MaxFraction = 0.4, Color = Color.Red, Duration = 3.0 })
		if not GetWeaponData( CurrentRun.Hero, weaponName).IgnoreOOMAimlineAlpha then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "SetAimlineAlpha", Parameters = { 0.3 }  })
		end
	end	
end

function SetManaIndicatorCustomColor( weaponName, color )
	
	if MapState.ChargedManaWeapons and MapState.ChargedManaWeapons[weaponName] ~= nil and not IsEmpty( MapState.ManaChargeIndicatorIds ) then
		local duration = 0.1
		if MapState.ChargedManaWeapons and MapState.ChargedManaWeapons[weaponName] ~= nil and not IsEmpty( MapState.ManaChargeIndicatorIds ) then		
			SetColor({ Id = MapState.ManaChargeIndicatorIds.BackingId, Color = color, Duration = duration })
			ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, FadeTarget = 0.3, FadeDuration = duration, ColorTarget = Color.Red, ColorDuration = duration })	
			SetAlpha({ Id = MapState.ManaChargeIndicatorIds.PipId, Fraction = 0.3, Duration = 0 })
			Flash({ Id = MapState.ManaChargeIndicatorIds.BackingId, Speed = 0.8, MinFraction = 0.0, MaxFraction = 0.8, Color = color })
			Flash({ Id = MapState.ManaChargeIndicatorIds.PipId, Speed = 0.8, MinFraction = 0.0, MaxFraction = 0.4, Color = color })
			if not GetWeaponData( CurrentRun.Hero, weaponName).IgnoreOOMAimlineAlpha then
				RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "SetAimlineAlpha", Parameters = { 0.3 }  })
			end
		end	
	end
end

function SetManaIndicatorAllowed( weaponName, args )
	args = args or {}
	if not args.IgnoreOutOfManaHintCache then
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "OutOfManaHintCache", Value = false, DataValue = false })
	end
	if MapState.ChargedManaWeapons and MapState.ChargedManaWeapons[weaponName] ~= nil and not IsEmpty( MapState.ManaChargeIndicatorIds ) then

		for i, name in pairs( ManaGatherAnimations ) do
			StopAnimation({ Names = name, DestinationId = CurrentRun.Hero.ObjectId })
		end
		CreateAnimation({ Name = ManaGatherAnimations.Default, DestinationId = CurrentRun.Hero.ObjectId })	
		local targetColor = Color.White
		if SessionMapState.ManaIndicatorCustomColor then
			targetColor = SessionMapState.ManaIndicatorCustomColor
		end
		SetColor({ Id = MapState.ManaChargeIndicatorIds.BackingId, Color = targetColor, Duration = 0.1  })
		ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, FadeTarget = 1, FadeDuration = duration, ColorTarget = targetColor, Duration = 0.1 })
		SetAlpha({ Id = MapState.ManaChargeIndicatorIds.PipId, Fraction = 1, Duration = duration })
		StopFlashing({ Id =  MapState.ManaChargeIndicatorIds.PipId})
		StopFlashing({ Id =  MapState.ManaChargeIndicatorIds.BackingId})
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "SetAimlineAlpha", Parameters = { 1 }  })
	end	
end

function PulseManaIndicator()
	if not IsEmpty( MapState.ManaChargeIndicatorIds ) then
		thread( PulseAnimation, { Id = MapState.ManaChargeIndicatorIds.BackingId, ScaleTarget= 1.05, ScaleDuration = 0.1, HoldDuration = 0 })
	end
end

function NoManaCastSecondStageForceRelease( args )
	SetAnimation({ Name = WeaponData.WeaponCast.UnarmedCastCompleteGraphic, DestinationId = CurrentRun.Hero.ObjectId })
end