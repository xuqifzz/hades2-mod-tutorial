function RelationshipAdvancedPresentation( source, args )

	args = args or {}

	if args.GameStateRequirements ~= nil and not IsGameStateEligible( source, args.GameStateRequirements ) then
		return
	end

	CurrentRun.RelationshipsAdvanced[source.Name] = true
	source.InRelationshipAdvancedPresentation = true

	AddInputBlock({ Name = "RelationshipAdvancedPresentation" })
	AddTimerBlock( CurrentRun, "RelationshipAdvancedPresentation" )
	CurrentRun.Hero.UntargetableFlags.RelationshipAdvancedPresentation = true
	SetPlayerInvulnerable( "RelationshipAdvancedPresentation" )
	SetUnitInvulnerable( source, "RelationshipAdvancedPresentation", { Silent = true } )

	wait( args.Delay )

	local backgroundDimId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray", Scale = 4.0, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	SetColor({ Id = backgroundDimId, Color = Color.Black, Duration = 0 })
	SetAlpha({ Id = backgroundDimId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = backgroundDimId, Fraction = 0.8, Duration = 0.3 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })

	SessionMapState.BlockInfoBanners = false
	thread( DisplayInfoBanner, nil, {
		TitleText = "UnlockedRelationship",
		FontScale = 1.0,
		SubtitleOffsetY = 60,
		Color = {0, 255, 168, 255},
		TextColor = Color.White,
		SubTextColor = {23, 255, 187, 255},
		Duration = 3.0,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		Layer = "Combat_Menu_TraitTray_Overlay",
		AdditionalAnimation = "GodHoodRays",
		AnimationName = "InfoBannerGiftIn",
		AnimationOutName = "InfoBannerGiftOut",
		IconBackingAnimationName = "LocationBackingIrisSmallSubtitleIn",
		IconBackingAnimationOutName = "LocationBackingIrisSmallSubtitleOut",
	} )

	wait( 0.3 )

	local heartId = CreateScreenObstacle({
		Name = "BlankObstacle",
		Group = "Combat_Menu_TraitTray_Overlay",
		X = ScreenCenterX,
		Y = 246,
		Animation = "LockedHeartIcon",
		Scale = 1.25,
		Alpha = 0.0,
		AlphaTarget = 1.0,
		AlphaTargetDuration = 0.3
	})
	local lockId = CreateScreenObstacle({
		Name = "BlankObstacle",
		Group = "Combat_Menu_TraitTray_Overlay",
		X = ScreenCenterX + 1,
		Y = 242,
		Animation = "LockedIconNoKey",
		Alpha = 0.0,
		AlphaTarget = 1.0,
		AlphaTargetDuration = 0.3,
		Scale = 1.0,
	})

	PlaySound({ Name = "/SFX/Enemy Sounds/WretchedThug/ThugChargeUp2" })
	wait( 1.0 )
	PlaySound({ Name = "/Leftovers/World Sounds/ChainRattle" })

	Shake({ Ids = { heartId, lockId }, Speed = 200, Distance = 3, Duration = 0.5 })

	wait( 0.51 )

	PlaySound({ Name = "/SFX/Menu Sounds/HeartSlotUnlock" })
	SetAnimation({ DestinationId = heartId, Name = "EmptyHeartIcon" })
	SetAnimation({ DestinationId = lockId, Name = "LockedIconRelease" })

	wait( 1.5 )

	SetAlpha({ Ids = { heartId, lockId, backgroundDimId }, Fraction = 0, Duration = 0.2 })
	wait( 0.8 )
	Destroy({ Id = { heartId, lockId, backgroundDimId } })

	thread( ShowCodexUpdate )

	source.InRelationshipAdvancedPresentation = nil

	CurrentRun.Hero.UntargetableFlags.RelationshipAdvancedPresentation = nil
	SetPlayerVulnerable( "RelationshipAdvancedPresentation" )
	SetUnitVulnerable( source, "RelationshipAdvancedPresentation" )

	RemoveTimerBlock( CurrentRun, "RelationshipAdvancedPresentation" )
	RemoveInputBlock({ Name = "RelationshipAdvancedPresentation" })

end

function MaxedRelationshipPresentation( source, args )

	AddInteractBlock( source, "MaxedRelationshipPresentation" )
	if args.UseInputBlock then
		AddInputBlock({ Name = "MaxedRelationshipPresentation" })
	end

	AddTimerBlock( CurrentRun, "MaxedRelationshipPresentation", { MapState = true } )
	SessionMapState.BlockCodex = true
	SessionMapState.BlockInventory = true

	wait( args.Delay or 2.0 )

	DisplayInfoBanner( nil, {
		TitleText = args.Title or "MaxedRelationship",
		FontScale = 1.0,
		SubtitleText = args.Text,
		TextRevealSound = "/Leftovers/Menu Sounds/EmoteAffection",
		SubtitleOffsetY = 60,
		Color = {0, 255, 168, 255},
		TextColor = args.TextColor or Color.White,
		SubTextColor = {23, 255, 187, 255},
		Icon = args.Icon,
		IconOffsetY = 6,
		IconScale = 0.5,
		Duration = 4.35,
		IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		Layer = "Combat_Menu_TraitTray_Overlay",
		AdditionalAnimation = "GodHoodRays",
		AnimationName = "InfoBannerGiftIn",
		AnimationOutName = "InfoBannerGiftOut",
		IconBackingAnimationName = "LocationBackingIrisSmallSubtitleIn",
		IconBackingAnimationOutName = "LocationBackingIrisSmallSubtitleOut",
	} )

	SessionMapState.BlockCodex = nil
	SessionMapState.BlockInventory = nil
	RemoveTimerBlock( CurrentRun, "MaxedRelationshipPresentation" )
	RemoveInteractBlock( source, "MaxedRelationshipPresentation" )
	if args.UseInputBlock then
		RemoveInputBlock({ Name = "MaxedRelationshipPresentation" })
	end

	if args.EndFunctionName ~= nil then
		CallFunctionName( args.EndFunctionName, source, args.EndFunctionArgs )
	end

end

function ReceivedGiftPresentation( npc, giftAnimation )
	PlaySound({ Name = "/Leftovers/SFX/StaminaRefilled" })
	thread( PlayVoiceLines, GlobalVoiceLines.FamiliarUpgradedGlobalVoiceLines, true, nil, { FamiliarName = npc.Name } )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = npc.ObjectId })
	SetAnimation({ Name = "MelTalkGifting01", DestinationId = CurrentRun.Hero.ObjectId })

	wait(0.30)
	thread( ReceivedGiftPresentationHearts, npc, giftAnimation )
	wait(0.20)
	SetAnimation({ Name = "MelTalkGifting01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId }) 
	wait(0.65)
end

function ReceivedGiftPresentationPost( npc )
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PopOverheadText, { TargetId = npc.ObjectId, Amount = 1, Text = "HeartAmount", Color = Color.White, OffsetY = npc.GiftPresentationIconOffsetY or -20, HoldDuration = 1.7, ShadowAnimName = "InCombatTextShadow_GiftBacking" } )
	PlaySound({ Name = "/SFX/Menu Sounds/HeartGained", Id = npc.ObjectId })
end

function ReceivedGiftPresentationHearts( npc, giftAnimation )
	local giftOffsetZ = 100
	if npc.AnimOffsetZ ~= nil then
		giftOffsetZ = npc.AnimOffsetZ + 80
	end
	CreateAnimation({ DestinationId = npc.ObjectId, Name = giftAnimation, OffsetY = -giftOffsetZ })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection", Id = npc.ObjectId })
end

function PlayerReceivedGiftPresentation( npc, giftName )
	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.66 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/StarSelectConfirm" })

	thread( PlayVoiceLines, npc.GiftGivenVoiceLines, true )
	thread( PlayVoiceLines, CurrentRun.Hero.GiftReceivedVoiceLines, true )
	local npcName = npc.Name
	DisplayInfoBanner( nil, {
		Icon = TraitData[giftName].Icon,
		IconScale = 1.0,
		IconMoveSpeed = 0.0001,
		IconOffsetY = 6,
		SubtitleOffsetY = 60,
		HighlightIcon = true,
		TitleText = "NewTraitUnlocked_Title",
		AnimationName = "InfoBannerGiftIn",
		AnimationOutName = "InfoBannerGiftOut",
		IconBackingAnimationName = "LocationBackingIrisSmallSubtitleIn",
		IconBackingAnimationOutName = "LocationBackingIrisSmallSubtitleOut",
		IconBackingColor = Color.Lavender,
		IconBackingHSV = { 0.25, -0.2, 0.1},
		SubtitleText = "NewTraitUnlocked_Subtitle",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = npcName, Gift = giftName }},
	})

	thread( function()
		wait( 1.0 )
		AdjustColorGrading({ Name = "Off", Duration = 1.0, })
	end )

	if CheckObjectiveSet( "KeepsakePrompt" ) then
		UpdateAffordabilityStatus()
	end
end