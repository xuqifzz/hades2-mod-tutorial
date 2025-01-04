-- used for both Chaos Trials and Night Missions
function BountyEarnedPresentation( bountyData, args )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })
	PlaySound({ Name = "/SFX/Menu Sounds/BiomeMapRewardIcon" })

	thread( PlayVoiceLines, HeroVoiceLines.BountyEarnedVoiceLines, true )
	thread( PlayVoiceLines, HeroVoiceLines.PackagedBountyClearedVoiceLines )

	DisplayInfoBanner( nil, {
		TitleText = bountyData.TitleText or "BountyCompleteMessage",
		SubtitleText = bountyData.SubtitleText or "BountyCompleteSubtitle",
		AnimationName = "LocationBackingIrisChaosIn",
		AnimationOutName = "LocationBackingIrisChaosOut",
		AppearSound = "/SFX/ChaosBoonChoice",
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal2",
		SubtitleTextRevealSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
		FontScale = 0.9,
		Delay = 0.4,
		Duration = 3.25,
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

	PlaySound({ Name = "/SFX/Menu Sounds/ChaosBoonConfirm" })
	AdjustColorGrading({ Name = "Team03", Duration = 2.4 })
	AdjustFullscreenBloom({ Name = "GoldBloom", Duration = 2.4 })
	-- LoadVoiceBanks({ Name = "Chaos" })
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

-- Chaos Trials
function EndBountyRunPresentation( bountyData )

	AddInputBlock({ Name = "EndBountyRunPresentation" })
	SetPlayerInvulnerable( "EndBountyRunPresentation" )
	
	FocusCamera({ Fraction = 0.88, Duration = 3, ZoomType = "Ease" })
	PlaySound({ Name = "/SFX/Menu Sounds/ChaosMiscSFX" })

	AdjustFullscreenBloom({ Name = "Default", Duration = 1.0 })
	AdjustColorGrading({ Name = "Team03", Duration = 1.0 })

	wait( 0.6 )

	CurrentRun.ActiveBiomeTimer = false
	ToggleCombatControl( CombatControlsDefaults, false, "EndBountyRunPresentation" )
		
	wait( 0.35 )
	
	PlaySound({ Name = "/SFX/Menu Sounds/ChaosSelfDamage", Id = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SacrificeHealthFx", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })

	--CreateAnimation({ Name = "LamiaSkyCast", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	
	wait( 0.08 )

	-- destroy the player / back to DeathArea
	SetPlayerVulnerable( "EndBountyRunPresentation" )
	RemoveInputBlock({ Name = "EndBountyRunPresentation" })
	ToggleCombatControl( CombatControlsDefaults, true, "EndBountyRunPresentation" )

	CurrentRun.BountyCleared = true
	
	thread( Kill, CurrentRun.Hero )
	wait( 0.08 )

	FadeIn({ Duration = 0.5 })
end