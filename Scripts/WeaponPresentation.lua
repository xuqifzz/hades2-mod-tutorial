function WeaponChargeStartPresentation( triggerArgs, weaponData, args )
	thread( DoRumble, {{ RightFraction = 0.17, Duration = 0.3 }} )
end

function WeaponChargeStageStartPresentation( triggerArgs, weaponData, args, stageData, stage )
	args = args or {}
	if stageData.FxOnStart then
		CreateAnimation({ Name = stageData.FxOnStart, DestinationId = CurrentRun.Hero.ObjectId } )
	end
	if stageData.AnimOnStart then
		SetAnimation({ Name = stageData.AnimOnStart, DestinationId = CurrentRun.Hero.ObjectId } )
	end
	if (args.ResetIndicator or stageData.ResetIndicator ) and MapState.ManaChargeIndicatorIds and MapState.ManaChargeIndicatorIds.BackingId then
		MapState.ShowManaChargeIndicator = true
		SetManaIndicatorAllowed( weaponData.Name )
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

function WeaponChargeStageReachedPresentation( triggerArgs, weaponData, args, stageData, stage, maxStage )
	local maxStageReached = stage == maxStage
	if MapState.ManaChargeIndicatorIds and MapState.ManaChargeIndicatorIds.BackingId then
		ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, Text = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost } ) })
		PlaySound({ Name = "/SFX/MelinoeAxeSpinCharge", Id = CurrentRun.Hero.ObjectId })
	end
	if maxStageReached then
		Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 4, MinFraction = 0.5, MaxFraction = 0.6, Color = Color.White, Duration = 0.3 })
	end
	if stageData.AnimOnComplete then
		SetAnimation({ Name = stageData.AnimOnComplete, DestinationId = CurrentRun.Hero.ObjectId } )
	end

	if maxStageReached and weaponData.MaxChargeText then
		weaponData.MaxChargeText.TargetId = CurrentRun.Hero.ObjectId
		thread( InCombatTextArgs, weaponData.MaxChargeText )
	end
	thread( DoRumble, {{ RightFraction = 0.17, Duration = 0.3 }} )

	if not stageData.HideStageReachedFx then
		ManaChargeCompletePresentation( weaponData, maxStageReached )
	end

	if weaponData.ManaIndicatorUsesStageProgression and not IsEmpty( MapState.ManaChargeIndicatorIds ) then
		SetAnimationFrameTarget({ Name = ManaIndicatorPresentation.Hold.Fill, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Fraction = stage/maxStage, Instant = true })
		if not maxStageReached then
			SetAnimation({ Name = ManaIndicatorPresentation.Hold.Fill, DestinationId = MapState.ManaChargeIndicatorIds.BackingId , PlaySpeed = 0, Scale = 1.0, OffsetY = -50 })		
		end
		MapState.ShowManaChargeIndicator = true
	end
end

function SuitMaxMissilesLockedPresentation( weaponData )
	if weaponData.MaxMissileChargeText then
		weaponData.MaxMissileChargeText.TargetId = CurrentRun.Hero.ObjectId
		thread( InCombatTextArgs, weaponData.MaxMissileChargeText )
	end
end

function StartPlayerBlinkAlpha()
	SetPlayerNotStopsProjectiles( "WeaponBlink" )
	SetPlayerFade({ Flag = "Blink", Fraction = 0.55, Duration = 0.09 })
	SetPlayerDarkside("Blink")
end

function EndPlayerBlinkAlpha()
	ClearPlayerFade("Blink")
	SetPlayerUnDarkside("Blink")
	SetPlayerStopsProjectiles( "WeaponBlink" )
end

function ClearBlinkAlpha( triggerArgs )
	if not triggerArgs.PostFire then
		EndPlayerBlinkAlpha()
	end
end

function NoSuitSpecialTargetPresentation( weaponData )
	if not IsEmpty( MapState.ManaChargeIndicatorIds ) then
		StopFlashing({ Id = MapState.ManaChargeIndicatorIds.BackingId })
	end
	SessionMapState.ManaIndicatorCustomColor = weaponData.NoTargetColor
	SessionMapState.ManaIndicatorCustomHSV = weaponData.NoTargetHSV
	SetColor({ Id = MapState.ManaChargeIndicatorIds.BackingId, Color = SessionMapState.ManaIndicatorCustomColor })
	if SessionMapState.ManaIndicatorCustomHSV then
		SetHSV({ Id = MapState.ManaChargeIndicatorIds.BackingId, HSV = SessionMapState.ManaIndicatorCustomHSV, ValueChangeType = "Absolute" })
	end
	waitUnmodified(0.05)
	if IsEmpty(SessionMapState.TargetedEnemies) then
		thread(SetManaIndicatorCustomColor, weaponData.Name, SessionMapState.ManaIndicatorCustomColor, SessionMapState.ManaIndicatorCustomHSV )
	end
end
function NoSuitSpecialTargetCombatText( weaponData )
	wait(1.0, "NoSuitTarget")
	PlaySound({ Name = "/Leftovers/SFX/InvincibleOnHit", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.WeaponSuitNoTargetVoiceLines, true )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "SuitNoTarget", Duration = 1.5, SkipRise = true, ShadowScale = 0.6, PreDelay = 0.1, OffsetY = -190} )
end

function NyxBuffReadyPresentation()
	PlaySound({ Name = "/SFX/Player Sounds/NyxTurboBoost", Id = CurrentRun.Hero.ObjectId })
	CreateAnimation({Name = "NyxBlastReadyEffect", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({Name = "NyxBlastReadyEffect2", DestinationId = CurrentRun.Hero.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.15 }, } )
end

function NyxBuffReadyEndPresentation()

end

function NyxBuffStartPresentation( reapplied, duration )
	if not reapplied then
		wait(0.06)
		CreateAnimation({Name = "KeepsakeLevelUpFlare", DestinationId = ScreenAnchors.SuitUI, GroupName = "Overlay"})
		SetAnimation({Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.SuitUI })
	end
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.SuitUIChargeAmount, Fraction = 1, Instant = true })
	
	SetAnimation({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.SuitUIChargeAmount, PlaySpeed = 100 / duration})
	SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.SuitUIChargeAmount, Fraction = 0 })
	if CheckCooldown( "NyxBuffStartPresentation", 0.3 ) then
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorCloseWithUpgrade", Id = CurrentRun.Hero.ObjectId, ManagerCap = 46 })
	end
end

function NyxBuffEndPresentation( duration )
	SetAnimation({ Name = "StaffReloadTimerOut", DestinationId = ScreenAnchors.SuitUI})
	PlaySound({ Name = "/SFX/Player Sounds/DarknessCollectionPickupSMALL", Id = CurrentRun.Hero.ObjectId })
end

function TorchExEmpowerPresentationStart()
	ShakeScreen({ Speed = 400, Distance = 4, Duration = 0.23, FalloffSpeed = 1400, Angle = 0 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.23 }, } )
end

function TorchExEmpowerPresentationEnd()
	CreateAnimation({ Name = "SupayEXEnd", DestinationId = CurrentRun.Hero.ObjectId })
end