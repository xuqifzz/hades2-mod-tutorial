function BountyTurnInPresentation( source, args )
	args = args or {}
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })
	local vignetteA = CreateAnimation({ Name = "CauldronCastVignetteLoop", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = vignetteA })
	local vignetteB = CreateAnimation({ Name = "NightmareEdgeFxSpawner", DestinationId = CurrentRun.Hero.ObjectId })
	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.1 })
	AdjustRadialBlurStrength({ Fraction = 1.0, Duration = 0.1 })

	AddInputBlock({ Name = "MelBountyTurnIn" })

	SetAnimation({ Name = "MelinoeBountyTurnInStart", DestinationId = CurrentRun.Hero.ObjectId })

	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCloseWithUpgrade" })

	PlaySound({ Name = "/SFX/Menu Sounds/CharonMainMenuSFX" })

	thread( PlayVoiceLines, HeroVoiceLines.BountyTurnedInVoiceLines )

	wait(0.7)

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1 })

	StopAnimation({ Name = "CauldronCastVignetteLoop", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	StopAnimation({ Name = "NightmareEdgeFxSpawner", DestinationId = CurrentRun.Hero.ObjectId })

	SetAnimation({ Name = source.TurnOffAnimation, DestinationId = source.ObjectId })
	StopStatusAnimation( source )

	wait(0.37)
	RemoveInputBlock({ Name = "MelBountyTurnIn" })
end

function BountyEarnedPresentation( bountyData, args )
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })
	PlaySound({ Name = "/SFX/Menu Sounds/BiomeMapRewardIcon" })
	LoadVoiceBanks({ Name = "Chaos" })

	thread( PlayVoiceLines, HeroVoiceLines.BountyEarnedVoiceLines, true )

	DisplayInfoBanner( nil, {
		TitleText = bountyData.TitleText or "BountyCompleteMessage",
		SubtitleText = bountyData.SubtitleText or "BountyCompleteSubtitle",
		AnimationName = "LocationBackingIrisChaosIn",
		AnimationOutName = "LocationBackingIrisChaosOut",
		AppearSound = "/SFX/ChaosBoonChoice",
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal2",
		SubtitleTextRevealSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
		FontScale = 0.9,
		Delay = 0.6,
		Duration = 2.5,
		Color = {0, 255, 168, 255},
		TextColor = Color.White,
		SupertitleFont = "P22UndergroundSCMedium",
		SupertitleTextColor = {190, 190, 190, 255},
		SupertitleTextDelay = 1.0,
		SubtitleFont = "SpectralSCLightTitling",
		SubtitleOffsetY = 25,
		SubtitleDelay = 0.75,
		SubTextColor = {194, 88, 255, 255},
		--Icon = item.Name.."Preview",
		IconMoveSpeed = 0.00001,
		IconOffsetY = 0,
		TitleFont = "SpectralSCLightTitling",
		AdditionalAnimation = "BountySparkles",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = bountyData },
		} )
end

function BountyBoardOpenedPresentation( screen )

	thread( PlayVoiceLines, HeroVoiceLines.BountyBoardOpenedVoiceLines )

end

function BountyBoardIneligiblePresentation( screen, button )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
	ModifyTextBox({ Id = button.Screen.Components.UnlockHint.Id, ColorTarget = Color.Red, ScaleTarget = 1.02, ScaleDuration = 0.1 })
	wait( 0.1 )
	ModifyTextBox({ Id = button.Screen.Components.UnlockHint.Id, ColorTarget = { 155, 155, 155, 180 }, ColorDuration = 0.3, ScaleTarget = 1.0, ScaleDuration = 1 })
end

function BountyPackagePreRunStartPresentation( bountyData, args )

	LoadVoiceBanks({ Name = "Chaos" })
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCloseWithUpgrade" })
	AdjustColorGrading({ Name = "Team03", Duration = 2.4 })
	AdjustFullscreenBloom({ Name = "GoldBloom", Duration = 2.4 })
	thread( PlayVoiceLines, GlobalVoiceLines.StartNewPackagedBountyVoiceLines, nil, nil, args )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = -180, Duration = 6.0, Retarget = true, EaseIn = 0, EaseOut = 0.1 })
	FocusCamera({ Fraction = 0.775, Duration = 6 })
	SetAnimation({ Name = "MelinoeCrossCastAntic", DestinationId = CurrentRun.Hero.ObjectId, PlaySpeed = 0.07 })
	--AdjustZLocation({ Id = CurrentRun.Hero.ObjectId, Distance = 30, Duration = 3.0 })
	--SetScale({ Id = 561146, Fraction = 1.22, Duration = 5 })
	SetScale({ Id = 560754, Fraction = 5.14, Duration = 8 })
	wait( 2.1 )
	FullScreenFadeOutAnimation()

end

function BountyPackageRunEndPresentation( bountyName )

	--[[
	local titleText = "BountyCompleteMessage"
	if not GameState.BountiesCompleted[bountyName] then
		titleText = "BountyFailedMessage"
	end
	]]--

	DisplayInfoBanner( nil, {
		--SupertitleText = "EasyModeUpgradedSupertitle",
		TitleText = "PackagedBountyEndedMessage",
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal2",
		SubtitleText = "PackagedBountyEnded_Subtitle",
		SubtitleTextRevealSound = "/Leftovers/Menu Sounds/EmoteThoughtful",

		AnimationName = "LocationBackingIrisChaosIn",
		AnimationOutName = "LocationBackingIrisChaosOut",
		AppearSound = "/SFX/ChaosBoonChoice",
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal2",
		SubtitleTextRevealSound = "/Leftovers/Menu Sounds/EmoteThoughtful",

		Color = {0, 255, 168, 255},
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = Color.White,
		SubTextColor = {23, 255, 187, 255},
		SubtitleFont = "SpectralSCLightTitling",
		SubtitleOffsetY = 25,
		SubtitleDelay = 0.75,
		Duration = 4.35,
		IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "P22UndergroundSCMedium",
		Layer = "ScreenOverlay",
		--SubtitleData = { LuaKey = "TempTextData", LuaValue = { Resistance = prevResistance }, LuaValueUpdate = { Resistance = "{#HighlightFormatGraft}" .. resistance}, UpdateDelay = 1.25, },
		} )

end

function EndBountyRunPresentation( bountyData )

	AddInputBlock({ Name = "EndBountyRunPresentation" })
	SetPlayerInvulnerable( "EndBountyRunPresentation" )

	wait( 1.0 )

	CurrentRun.ActiveBiomeTimer = false
	ToggleCombatControl( CombatControlsDefaults, false, "EndBountyRunPresentation" )
		
	wait( 0.35 )
	CreateAnimation({ Name = "SacrificeHealthFx", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 0.35 )

	-- destroy the player / back to DeathArea
	SetPlayerVulnerable( "EndBountyRunPresentation" )
	RemoveInputBlock({ Name = "EndBountyRunPresentation" })
	ToggleCombatControl( CombatControlsDefaults, true, "EndBountyRunPresentation" )

	CurrentRun.BountyCleared = true
	
	thread( Kill, CurrentRun.Hero )
	wait( 0.15 )

	FadeIn({ Duration = 0.5 })
end