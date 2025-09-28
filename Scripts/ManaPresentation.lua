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
		CreateAnimation({ DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Name = "ChargeIndicatorManaSparkleShower", Group = "Combat_UI_World_Add" })
		local animationName = ManaIndicatorPresentation.Hold.Fill
		local loopingAnim = false
		if MapState.ManaChargeIndicatorData then
			if MapState.ManaChargeIndicatorData.Loop then
				animationName = MapState.ManaChargeIndicatorData.Loop
				loopingAnim = true
			elseif MapState.ManaChargeIndicatorData.Fill then
				animationName = MapState.ManaChargeIndicatorData.Fill
			end
		end
		if loopingAnim then
			MapState.ManaChargeIndicatorLooping = true
			SetAnimation({ Name = animationName, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Scale = 1.0, OffsetY = -50 })	
		else
			SetAnimationFrameTarget({ Name = animationName, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Fraction = 1, Instant = true })
			SetAnimation({ Name = animationName, DestinationId = MapState.ManaChargeIndicatorIds.BackingId , PlaySpeed = 0, Scale = 1.0, OffsetY = -50 })	
		end
		MapState.ShowManaChargeIndicator = true
		Flash({ Id = MapState.ManaChargeIndicatorIds.BackingId, Speed = 4, MinFraction = 0.5, MaxFraction = 0.9, Color = Color.White, Duration = 0.3 })
	end
end



function WeaponCooldownOutOfMana( weaponData, args, triggerArgs )
	args = args or {}
	triggerArgs = triggerArgs or {}
	if args.RequireNotFreshInput and triggerArgs.FreshInput then
		TriggerCooldown( weaponData.Name.."OutOfManaFunction", args.Cooldown or 0.5 )
		SessionMapState.FreshInputOOMStateEnabled = true
		return
	end
	if CheckCooldown( weaponData.Name.."OutOfManaFunction", args.Cooldown or 0.5 )  then
		if not args.RequireNotFreshInput or SessionMapState.FreshInputOOMStateEnabled then
			WeaponFailedNoManaPresentation (weaponData, {Force = true })
			SessionMapState.FreshInputOOMStateEnabled = nil
		end
	end
end

function SetManaIndicatorDisallowed( weaponName, onCreation, manaValue, args )
	local room = CurrentHubRoom or CurrentRun.CurrentRoom
	if room and room.OutOfManaEvents ~= nil then
		RunEventsGeneric( room.OutOfManaEvents, room, args )
	end
	local duration = 0.1
	if onCreation then
		duration = 0
	end
	if MapState.ChargedManaWeapons and MapState.ChargedManaWeapons[weaponName] ~= nil and not IsEmpty( MapState.ManaChargeIndicatorIds ) then		
		for i, name in pairs( ManaGatherAnimations ) do
			StopAnimation({ Name = name, DestinationId = CurrentRun.Hero.ObjectId })
		end
		if MapState.ManaChargeIndicatorLooping then	
			SetAnimationFrameTarget({ Name = MapState.ManaChargeIndicatorData.Fill, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Fraction = 0, Instant = true })
			SetAnimation({ Name = MapState.ManaChargeIndicatorData.Fill, DestinationId = MapState.ManaChargeIndicatorIds.BackingId , PlaySpeed = 0, Scale = 1.0, OffsetY = -50 })	
		end
		CreateAnimation({ Name = ManaGatherAnimations.OOM, DestinationId = CurrentRun.Hero.ObjectId })
		SetHSV({ Id = MapState.ManaChargeIndicatorIds.BackingId, HSV = {0,0,0} , ValueChangeType = "Absolute" })
		SetRGB({ Id = MapState.ManaChargeIndicatorIds.BackingId, Color = Color.Red, Duration = duration })
		SetRGB({ Id = MapState.ManaChargeIndicatorIds.BadgeId, Color = Color.Red, Duration = duration })
		if MapState.ShowManaChargeIndicator then
			if manaValue then
				ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, Text = manaValue, FadeTarget = 0.3, FadeDuration = duration, ColorTarget = Color.Red, ColorDuration = duration })
			else
				ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, FadeTarget = 0.3, FadeDuration = duration, ColorTarget = Color.Red, ColorDuration = duration })	
			end
			Flash({ Id = MapState.ManaChargeIndicatorIds.BackingId, Speed = 3, MinFraction = 0.4, MaxFraction = 0.8, Color = Color.Red, Duration = 3.0 })
		end
		if not GetWeaponData( CurrentRun.Hero, weaponName).IgnoreOOMAimlineAlpha then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "SetAimlineAlpha", Parameters = { 0.3 }  })
		end
	end	
end

function ManaFountainHintPresentation( source, args, contextArgs )
	contextArgs = contextArgs or {}
	if contextArgs.IgnoreHint then
		return
	end
	local fountain = MapState.ActiveObstacles[args.FountainId]
	thread( DirectionHintPresentation, fountain, { Cooldown = 3.0, Delay = 1.0 } )
end

function SetManaIndicatorCustomColor( weaponName, color, hsv )
	if MapState.ChargedManaWeapons and MapState.ChargedManaWeapons[weaponName] ~= nil and not IsEmpty( MapState.ManaChargeIndicatorIds ) then
		local duration = 0.1
		if MapState.ChargedManaWeapons and MapState.ChargedManaWeapons[weaponName] ~= nil and not IsEmpty( MapState.ManaChargeIndicatorIds ) then		
			if hsv then
				SetHSV({ Id = MapState.ManaChargeIndicatorIds.BackingId, HSV = hsv, ValueChangeType = "Absolute" })
				SetColor({ Id = MapState.ManaChargeIndicatorIds.BackingId, Color = Color.White, Duration = duration })
				SetRGB({ Id = MapState.ManaChargeIndicatorIds.BadgeId, Color = Color.White, Duration = duration })
			else
				SetColor({ Id = MapState.ManaChargeIndicatorIds.BackingId, Color = color, Duration = duration })
				SetRGB({ Id = MapState.ManaChargeIndicatorIds.BadgeId, Color = color, Duration = duration })
				Flash({ Id = MapState.ManaChargeIndicatorIds.BackingId, Speed = 0.8, MinFraction = 0.0, MaxFraction = 0.8, Color = color })
			end
			StopFlashing({ Id =  MapState.ManaChargeIndicatorIds.BackingId })
			ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, FadeTarget = 1, FadeDuration = duration, ColorTarget = color, ColorDuration = duration })	
			if not GetWeaponData( CurrentRun.Hero, weaponName).IgnoreOOMAimlineAlpha then
				RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "SetAimlineAlpha", Parameters = { 0.3 }  })
			end
		end	
	end
end

function SetManaIndicatorAllowed( weaponName, args )
	args = args or {}
	if MapState.ShowManaChargeIndicator and MapState.ChargedManaWeapons and MapState.ChargedManaWeapons[weaponName] ~= nil and not IsEmpty( MapState.ManaChargeIndicatorIds ) and not MapState.HostilePolymorph then

		for i, name in pairs( ManaGatherAnimations ) do
			StopAnimation({ Name = name, DestinationId = CurrentRun.Hero.ObjectId })
		end
		CreateAnimation({ Name = ManaGatherAnimations.Default, DestinationId = CurrentRun.Hero.ObjectId })	
		local targetColor = Color.White
		local targetHSV = {0,0,0}
		if SessionMapState.ManaIndicatorCustomColor then
			targetColor = SessionMapState.ManaIndicatorCustomColor
		end
		if SessionMapState.ManaIndicatorCustomHSV then
			targetHSV = SessionMapState.ManaIndicatorCustomHSV
		end
		SetHSV({ Id = MapState.ManaChargeIndicatorIds.BackingId, HSV = targetHSV, ValueChangeType = "Absolute" })
		SetColor({ Id = MapState.ManaChargeIndicatorIds.BackingId, Color = targetColor, Duration = 0.1  })
		SetRGB({ Id = MapState.ManaChargeIndicatorIds.BadgeId, Color = targetColor, Duration = 0.1  })
		ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, FadeTarget = 1, FadeDuration = duration, ColorTarget = targetColor, Duration = 0.1 })
		StopFlashing({ Id =  MapState.ManaChargeIndicatorIds.BackingId })
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "SetAimlineAlpha", Parameters = { 1 }  })
	end	
end

function PulseManaIndicator()
	if not IsEmpty( MapState.ManaChargeIndicatorIds ) then
		thread( PulseAnimation, { Id = MapState.ManaChargeIndicatorIds.BackingId, ScaleTarget= 1.05, ScaleDuration = 0.1, HoldDuration = 0 })
	end
end

function NoManaCastSecondStageForceRelease( args )
	if not MapState.HostilePolymorph then
		SetAnimation({ Name = WeaponData.WeaponCast.UnarmedCastCompleteGraphic, DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function StopIdleManaRegenerationPresentation()
	CreateAnimation({ Name = "DemeterManaBoonEndFx", DestinationId = CurrentRun.Hero.ObjectId })				
	StopAnimation({ Name = "DemeterManaBoonFx", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "DemeterManaBoonFxC", DestinationId = CurrentRun.Hero.ObjectId })			
end