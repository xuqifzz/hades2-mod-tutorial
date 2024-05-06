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
	
	if IsEmpty( GetWeaponChargeStages( weaponData ) ) then
		ManaChargeCompletePresentation( weaponData, true )
	end
end

function ManaChargeCompletePresentation( weaponData, maxStage )
	if MapState.ManaChargeIndicatorIds and MapState.ManaChargeIndicatorIds.BackingId then
		if maxStage then
			SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "MaxChargeStageCache", Value = true, DataValue = false })
		end
		CreateAnimation({ DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Name = "ChargeIndicatorManaSparkleShower" })
		Flash({ Id = MapState.ManaChargeIndicatorIds.BackingId, Speed = 4, MinFraction = 0.5, MaxFraction = 0.9, Color = Color.White, Duration = 0.3 })
	end
end



function WeaponCooldownOutOfMana( weaponData, args )
	args = args or {}
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

function SetManaIndicatorAllowed( weaponName )
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "OutOfManaHintCache", Value = false, DataValue = false })
	if MapState.ChargedManaWeapons and MapState.ChargedManaWeapons[weaponName] ~= nil and not IsEmpty( MapState.ManaChargeIndicatorIds ) then

		for i, name in pairs( ManaGatherAnimations ) do
			StopAnimation({ Names = name, DestinationId = CurrentRun.Hero.ObjectId })
		end
		CreateAnimation({ Name = ManaGatherAnimations.Default, DestinationId = CurrentRun.Hero.ObjectId })	
		SetColor({ Id = MapState.ManaChargeIndicatorIds.BackingId, Color = Color.White, Duration = 0.1  })
		ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, FadeTarget = 1, FadeDuration = duration, ColorTarget = Color.White, Duration = 0.1 })
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