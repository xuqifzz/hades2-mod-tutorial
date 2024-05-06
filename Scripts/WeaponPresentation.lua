function WeaponChargeStartPresentation( triggerArgs, weaponData, args )
	thread( DoRumble, {{ RightFraction = 0.17, Duration = 0.3 }} )
end

function WeaponChargeStageStartPresentation( triggerArgs, weaponData, args, stageData )

	if stageData.FxOnStart then
		CreateAnimation({ Name = stageData.FxOnStart, DestinationId = CurrentRun.Hero.ObjectId } )
	end
	if stageData.AnimOnStart then
		SetAnimation({ Name = stageData.AnimOnStart, DestinationId = CurrentRun.Hero.ObjectId } )
	end
	if stageData.ResetIndicator and MapState.ManaChargeIndicatorIds and MapState.ManaChargeIndicatorIds.BackingId then
		SetAnimationFrameTarget({ Name = ManaIndicatorPresentation.Hold.Fill, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Fraction = 0, Instant = true })
		SetAnimation({ Name = ManaIndicatorPresentation.Hold.Fill, DestinationId = MapState.ManaChargeIndicatorIds.BackingId , PlaySpeed = 1 / ( stageData.Wait * GetLuaWeaponSpeedMultiplier( weaponData.Name )), Scale = 1.0, OffsetY = -50 })
		SetAnimationFrameTarget({ Name = ManaIndicatorPresentation.Hold.Fill, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Fraction = 1})
		ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, Text = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost } )})
	end
	StopWeaponSounds( "ChargeStage", weaponData.Sounds, CurrentRun.Hero )
	if weaponData.Sounds and weaponData.Sounds.ChargeStageSounds and stage == 1 then
		DoWeaponSounds( weaponData.Sounds.ChargeStageSounds, CurrentRun.Hero, weaponData )
	end
	thread( DoWeaponChargeRumble, stageData )

end

function WeaponChargeStageReachedPresentation( triggerArgs, weaponData, args, stageData, maxStage )
	if MapState.ManaChargeIndicatorIds and MapState.ManaChargeIndicatorIds.BackingId then
		ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, Text = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost } ) })	PlaySound({ Name = "/SFX/MelinoeAxeSpinCharge", Id = CurrentRun.Hero.ObjectId })
	end
	if maxStage then
		Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 4, MinFraction = 0.5, MaxFraction = 0.6, Color = Color.White, Duration = 0.3 })
	end
	if stageData.AnimOnComplete then
		SetAnimation({ Name = stageData.AnimOnComplete, DestinationId = CurrentRun.Hero.ObjectId } )
	end

	if maxStage and weaponData.MaxChargeText then
		weaponData.MaxChargeText.TargetId = CurrentRun.Hero.ObjectId
		thread( InCombatTextArgs, weaponData.MaxChargeText )
	end
	thread( DoRumble, {{ RightFraction = 0.17, Duration = 0.3 }} )

	if not stageData.HideStageReachedFx then
		ManaChargeCompletePresentation( weaponData, maxStage )
	end

end

function StartPlayerBlinkAlpha()
	SetPlayerFade({ Flag = "Blink", Fraction = 0.55, Duration = 0.09 })
	if IsEmpty(MapState.TransformArgs) then
		SetThingProperty({ Property = "GrannyTexture", Value ="Models/Melinoe/MelinoeTransform_Color", DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function EndPlayerBlinkAlpha()
	ClearPlayerFade("Blink")
	if IsEmpty(MapState.TransformArgs) then
		SetThingProperty({ Property = "GrannyTexture", Value = "null", DestinationId = CurrentRun.Hero.ObjectId })
		SetupCostume( MapState.HostilePolymorph )
	end
end

function ClearBlinkAlpha( triggerArgs )
	if not triggerArgs.PostFire then
		EndPlayerBlinkAlpha()
	end
end
