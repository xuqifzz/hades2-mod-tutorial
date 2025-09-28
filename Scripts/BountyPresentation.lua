function PackagedBountyEarnedPresentation( bountyData )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })
	PlaySound({ Name = "/SFX/Menu Sounds/BiomeMapRewardIcon" })

	thread( PlayVoiceLines, HeroVoiceLines.PackagedBountyClearedVoiceLines )

	DisplayInfoBanner( nil, {
		TitleText = bountyData.TitleText or "BountyCompleteMessage",
		SubtitleText = bountyData.SubtitleText or "BountyCompleteSubtitle",
		AnimationName = "LocationBackingIrisChaosIn",
		AnimationOutName = "LocationBackingIrisChaosOut",
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal2",
		SubtitleTextRevealSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
		FontScale = 0.9,
		Delay = 0.4,
		Duration = 2.25,
		Color = {48, 12, 64, 255},
		TextFadeColor = {200,64,255,0},
		TextColor = Color.White,
		SubtitleFont = "SpectralSCMedium",
		SubtitleOffsetY = 10,
		SubtitleDelay = 0.5,
		SubTextColor = {180, 80, 230, 255},
		--Icon = item.Name.."Preview",
		IconMoveSpeed = 0.00001,
		IconOffsetY = 0,
		IconBackingOffsetY = -15,
		TitleFont = "SpectralSCLightTitling",
		AdditionalAnimation = "BountySparkles",
		IconBackingAnimationName = "LocationBackingIrisSubtitleStarIn",
		IconBackingAnimationOutName = "LocationBackingIrisSubtitleStarOut",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = bountyData },
		} )

end

function ShrineBountyEarnedPresentation( bountyData )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })
	PlaySound({ Name = "/SFX/Menu Sounds/BiomeMapRewardIcon" })

	thread( PlayVoiceLines, HeroVoiceLines.BountyEarnedVoiceLines, true )

	DisplayInfoBanner( nil, {
		TitleText = bountyData.TitleText or "BountyCompleteMessage",
		SubtitleText = bountyData.SubtitleText or "BountyCompleteSubtitle",
		AnimationName = "LocationBackingIrisGenericIn",
		AnimationOutName = "LocationBackingIrisGenericOut",
		AppearSound = "/SFX/Menu Sounds/MirrorCloseWithUpgrade",
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal2",
		SubtitleTextRevealSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
		FontScale = 0.9,
		Delay = 0.4,
		Duration = 2.25,
		Color = {48, 12, 64, 255},
		TextColor = Color.White,
		TextFadeColor = {200,64,255,0},
		TextOffsetY = 30,
		SubtitleFont = "SpectralSCMedium",
		SubtitleOffsetY = -5,
		SubtitleDelay = 0.75,
		SubTextColor = {194, 88, 255, 255},
		--Icon = item.Name.."Preview",
		IconMoveSpeed = 0.00001,
		IconOffsetY = 0,
		IconBackingOffsetY = -10,
		TitleFont = "SpectralSCLightTitling",
		AdditionalAnimation = "BountySparkles",
		IconBackingAnimationName = "LocationBackingIrisSubtitleStarIn",
		IconBackingAnimationOutName = "LocationBackingIrisSubtitleStarOut",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = bountyData },
		} )

end

function BountyBoardOpenedPresentation( screen )

	thread( PlayVoiceLines, HeroVoiceLines.BountyBoardOpenedVoiceLines )
	wait( 0.5 )
	for i = 1, 5 do
		local intensityComponent = screen.Components["IntensityEye"..i]
		SetAlpha({ Id =	intensityComponent.Id, Fraction = 1.0, Duration = 0.1, EaseIn = 0, EaseOut = 1 })
	end
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeEquip" })

end

function BountyBoardIneligiblePresentation( screen, button )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
end

function BountyPackagePreRunStartPresentation( bountyData, args )

	PlaySound({ Name = "/SFX/Menu Sounds/ChaosBoonConfirm" })
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

-- Chaos Trials
function EndBountyRunPresentation()

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