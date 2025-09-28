function SwitchToSpeedupPresentation( id )
	CreateAnimation({ Name = "BoonEntranceLegendary", DestinationId = id })
end

function SurfaceShopItemSameRoomPresentation( targetId )
	local newTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId })
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = newTargetId, Scale = 0.5 })
	thread( PlayVoiceLines, GlobalVoiceLines.SpecialDeliveryVoiceLines, true )
	HermesWipePresentation()
	CreateAnimation({ Name = "HermesWings", DestinationId = CurrentRun.Hero.ObjectId })
end

function SurfaceShopItemPresentation( targetId )
	local newTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId })
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = newTargetId, Scale = 0.5 })
	thread( PlayVoiceLines, GlobalVoiceLines.SpecialDeliveryVoiceLines, true )
	HermesWipePresentation()
	CreateAnimation({ Name = "HermesWings", DestinationId = CurrentRun.Hero.ObjectId })
end

function HermesWipePresentation()
	PlaySound({ Name = "/Leftovers/SFX/AuraThrowLarge" })
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })
	LoadPackages({ Name = "Hermes", IgnoreAssert = true })

	thread( DoRumble, { { LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.4, LeftTriggerFrequencyFraction = 0.15, LeftTriggerTimeout = 0.3, }, } )

	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0 })
	AdjustRadialBlurDistance({ Fraction = 0.125, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.03, Delay= 0 })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.03, Delay= 0 })

	local wrathPresentationOffsetY = 150
	local wrathStreak = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_UI" })
	SetScaleX({ Id = wrathStreak, Fraction = ScreenScaleX, Duration = 0 })
	Teleport({ Id = wrathStreak, OffsetX = ScreenCenterX, OffsetY = 800 + wrathPresentationOffsetY })
	DrawScreenRelative({ Ids = { wrathStreak } })
	CreateAnimation({ Name = "WrathPresentationStreak_Fast", DestinationId = wrathStreak, Color = {255, 90, 0, 255}, })

	local godImage = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu" })
	Teleport({ Id = godImage, OffsetX = -300, OffsetY = (1080/2) + 80 + wrathPresentationOffsetY })
	DrawScreenRelative({ Ids = { godImage } })
	SetAnimation({ Name = "Portrait_Hermes_Default_01_Wrath", DestinationId = godImage, Scale = 1.0 })

	local wrathStreakFront = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu_Overlay" })
	Teleport({ Id = wrathStreakFront, OffsetX = ScreenCenterX - (ScreenWidth * 0.03125), OffsetY = 1150 + wrathPresentationOffsetY })
	SetScaleX({ Id = wrathStreakFront, Fraction = ScreenScaleX, Duration = 0 })
	DrawScreenRelative({ Ids = { wrathStreakFront } })
	CreateAnimation({ Name = "WrathPresentationBottomDivider_Fast", DestinationId = wrathStreakFront, Scale = 1.25, Color = {255, 90, 0, 255}, })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	Move({ Id = godImage, Angle = 8, Distance = 800, Duration = 0.2, EaseIn = 0.2, EaseOut = 1, TimeModifierFraction = 0 })
	Move({ Id = wrathStreakFront, Angle = 8, Distance = 200, Duration = 0.5, EaseIn = 0.9, EaseOut = 1, TimeModifierFraction = 0 })
	Move({ Id = playerImage, Angle = 170, Speed = 50, TimeModifierFraction = 0 })

	SetColor({ Id = godImage, Color = {0, 0, 0, 1}, Duration = 0.05, TimeModifierFraction = 0 })

	waitUnmodified( 0.1, RoomThreadName )

	SetColor({ Id = godImage, Color = {1,1,1,1}, Duration = 0.1, TimeModifierFraction = 0 })

	waitUnmodified( 0.15, RoomThreadName )

	Move({ Id = godImage, Angle = 8, Distance = 100, Duration = 0.5, EaseIn = 0.5, EaseOut = 0.5, TimeModifierFraction = 0 })
	Move({ Id = wrathStreakFront, Angle = 8, Distance = 25, Duration = 0.5, EaseIn = 0.5, EaseOut = 1, TimeModifierFraction = 0 })

	waitUnmodified( 0.3, RoomThreadName )

	SetAlpha({ Id = godImage, Fraction = 0, Duration = 0.12, TimeModifierFraction = 0 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.06 })

	waitUnmodified(0.26, RoomThreadName )
	StopAnimation({ Name = "Portrait_Hermes_Default_01_Wrath", DestinationId = godImage, PreventChain = true, IncludeCreatedAnimations = true })
	Destroy({ Ids = { godImage, wrathStreak, wrathStreakFront } })

end