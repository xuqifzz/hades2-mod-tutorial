GlobalVoiceLines.AboutToFishVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Hecate_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "HecateFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Hecate_0379", Text = "Let's see what we can do." },
		{ Cue = "/VO/Hecate_0380", Text = "I much prefer to use a spear, myself...", PlayFirst = true },
		{ Cue = "/VO/Hecate_0381", Text = "Come on, you slippery bastards..." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Dora_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "DoraFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Dora_0084", Text = "This is going to be so fun..." },
		{ Cue = "/VO/Dora_0085", Text = "I'm starting to get why you hate fish so much..." },
		{ Cue = "/VO/Dora_0086", Text = "Seems like an awful lot of trouble for some weird fish...", PlayFirst = true },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Odysseus_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "OdysseusFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		-- { Cue = "/VO/Odysseus_0069", Text = "Harder to outsmart those little bastards than one might expect..." },
		{ Cue = "/VO/Odysseus_0070", Text = "These fish won't ridicule us again if I can help it!" },
		{ Cue = "/VO/Odysseus_0071", Text = "Poseidon can't help you here, little fish...", PlayFirst = true },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Nemesis_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "NemesisFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Nemesis_0175", Text = "Just like guard duty..." },
		{ Cue = "/VO/Nemesis_0176", Text = "This what you had in mind?" },
		{ Cue = "/VO/Nemesis_0177", Text = "Make it a fair fight.", PlayFirst = true },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Moros_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "MorosFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Moros_0345", Text = "Patience is a necessary skill in this pursuit...", PlayFirst = true },
		{ Cue = "/VO/Moros_0346", Text = "Perhaps there's something I can learn from your technique." },
		{ Cue = "/VO/Moros_0347", Text = "What lurks in the River Cocytus...?" },
	},

}

function FishingBlockedByEncounterPresentation( fishingPoint, args, user )
	local blockedText = "UseBlockedByMisc"
	if not IsEmpty( RequiredKillEnemies ) or not IsEmpty( MapState.AggroedUnits )then
		blockedText = "UseBlockedByEnemies"
	end
	thread( InCombatText, CurrentRun.Hero.ObjectId, blockedText, 1.0, { ShadowScale = 0.6 } )
	thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = fishingPoint.ObjectId })
end

function FishingBlockedByLavaPresentation( fishingPoint, args, user )
	thread( InCombatText, CurrentRun.Hero.ObjectId, "UseBlockedByLava", 1.0, { ShadowScale = 0.6 } )
	thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = fishingPoint.ObjectId })
end

function GiftActivityFishingStartPresentation( source, args )

	--[[
	thread( FullScreenFadeOutAnimation )
	TimePassesPresentation( source, { SkipAngleTowardTarget = true, IncludeFishingSFX = true, TimeTicks = 16 } )
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })

	Activate({ Ids = { 585640 } })
	SetAlpha({ Ids = { 585640 }, Fraction = 0 })
	SetAlpha({ Ids = { 585640 }, Fraction = 1, Duration = 0.3 })

	FullScreenFadeInAnimation()
	]]--

	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 0.0, Duration = 0.5 })

	thread( PlayVoiceLines, GlobalVoiceLines.AboutToFishVoiceLines, true )

	Activate({ Ids = { 585640 } })
	SetAlpha({ Ids = { 585640 }, Fraction = 0 })
	SetAlpha({ Ids = { 585640 }, Fraction = 1, Duration = 0.3 })

end

function GiftActivityFishingEndPresentation( source, args )

	if CurrentRun.Hero.FishingState == "Success" then
		wait( 3.5 )
	else
		wait( 1.5 )
	end
	-- SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 1.0, Duration = 0.5 })

end

function FishingStartPresentation( source, args )

	local fishingPointId = args.FishingPointId
	local fishingAnimationPointId = args.FishingAnimationPointId

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = fishingPointId })
	local unequipAnim = GetEquippedWeaponValue( "UnequipAnimation" )
	if unequipAnim ~= nil then
		SetAnimation({ Name = unequipAnim, DestinationId = CurrentRun.Hero.ObjectId,  })
	end
	wait(1.0)

	thread( PlayVoiceLines, HeroVoiceLines.FishingInitiatedVoiceLines, true )

	SetAnimation({ Name = "Melinoe_Fishing_Start", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.65)

	Destroy({ Id = fishingPointId })
	--SetAlpha({ Id = fishingPointId, Fraction = 0 })
	SetAlpha({ Id = args.FishingPointId, Fraction = 0.0 })
	BlockVfx({ DestinationId = args.FishingPointId })

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom

	SetAnimation({ Name = "FishingBobberIdle", DestinationId = fishingAnimationPointId })
	CreateAnimation({ Name = "FishingSplashA", DestinationId = fishingAnimationPointId })
	PlaySound({ Name = roomData.FishingStartSound or "/Leftovers/World Sounds/BigSplash", Id = fishingAnimationPointId })
	thread( DoRumble, { { ScreenPreWait = 0.06, RightFraction = 0.18, Duration = 0.2 }, } )

	local showedObjective = CheckObjectiveSet("Fishing")
	HideCombatUI("Fishing")
	thread( InCombatTextArgs, { Text = "Fishing_Hint", TargetId = CurrentRun.Hero.ObjectId, OffsetY = -205, SkipRise = true, SkipFlash = true, Duration = 1.5, PreDelay = 1.0, ShadowScaleX = 0.66 } )

	if roomData.ZoomFraction ~= nil then
		AdjustZoom({ Fraction = roomData.ZoomFraction + 0.03, LerpTime = 2.5 })
	else
		AdjustZoom({ Fraction = 1.03, LerpTime = 2.5 })
	end

	thread( FishingInProgressPresentation )
end

function FishingInProgressPresentation()

	local fidgetInterval = RandomFloat( FishingData.FidgetInterval.Min, FishingData.FidgetInterval.Max )	

	wait ( fidgetInterval )

	if CurrentRun.Hero.FishingInput then
		return
	end
	SetAnimation({ Name = "Melinoe_Fishing_Fidget", DestinationId = CurrentRun.Hero.ObjectId })

	wait ( 10.5 - fidgetInterval )

	if CurrentRun.Hero.FishingInput then
		return
	end
	thread( PlayVoiceLines, HeroVoiceLines.FishingInProgressVoiceLines, true )

end

function FishingReadyForInputPresentation( fishingAnimationPointId )
	thread( DoRumble, { { RightTriggerStart = 0, RightTriggerFrequencyFraction = 0.7 , RightTriggerStrengthFraction = 0.5 }, } )
end

function FishingReadyForReelInputPresentation( source, args, fishData )
	thread( DoRumble, { { RightTriggerStart = 0, RightTriggerFrequencyFraction = 0.7 , RightTriggerStrengthFraction = 0.5 }, } )
	thread( FishingTargetPulse, source, args, fishData )
end

function FishingTargetPulse( source, args, fishData )
	local pulseThreshold = 5.0
	local timeRemaining = args.ReelEndTime - _worldTime
	wait( timeRemaining - pulseThreshold )
	while _worldTime < args.ReelEndTime and args.HitsRemaining > 0 do
		timeRemaining = args.ReelEndTime - _worldTime
		local pulseDuration = timeRemaining / 3.0
		local halfPulseDuration = pulseDuration / 2.0
		SetAlpha({ Id = args.FishingReelPointId, Fraction = 0.1, Duration = halfPulseDuration })
		wait( halfPulseDuration )
		SetAlpha({ Id = args.FishingReelPointId, Fraction = 1.0, Duration = halfPulseDuration })
		wait( halfPulseDuration )
		local intervalDuration = halfPulseDuration / 2.0
		wait( intervalDuration )
	end
end

function FishingCaughtPresentation( source, args )
	thread( DoRumble, { { RightTriggerStrengthFraction = 0.0}, } )
	CreateAnimation({ Name = "FishingSplashB", DestinationId = args.FishingAnimationPointId })
end

function FishingReelSequenceStartPresentation( source, args, fishData )
	CreateAnimation({ Name = "FishCatchZone", DestinationId = args.FishingReelPointId, ScaleRadius = fishData.CatchZoneRadius })
	SetAnimation({ Name = "FishingBobberIdleWithTrail", DestinationId = args.FishingAnimationPointId })
	SetAnimation({ Name = "Melinoe_Fishing_Reel_Start", DestinationId = CurrentRun.Hero.ObjectId })

	AudioState.FishingMusicId = PlaySound({ Name = "/Music/FishingMusicLoop" })

	ClearCameraClamp({ LerpTime = 1.25 })
	FocusCamera({ Fraction = 1.25, Duration = 2.75, ZoomType = "Ease" })
	PanCamera({ Id = args.FishingReelPointId, Duration = 2.75, OffsetY = -20, Retarget = true })
	ShakeScreen({ Speed = 300, Distance = 6, Duration = 0.5, FalloffSpeed = 2000 })
	thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.17, Duration = 0.65 } } )

	--thread( InCombatTextArgs, { TargetId = args.FishingReelPointId, Text = "Fishing_ReelStart", Duration = 2.0 } )
	thread( DisplayInfoBanner, nil, { Text = "Fishing_ReelStart", Delay = 0, TextColor = Color.Turquoise, Layer = "Overlay", FontScale = 0.9, AnimationName = "LocationBackingIrisDeathIn", AnimationOutName = "LocationBackingIrisDeathOut", Duration = 2.75 } )
	PlaySound({ Name = "/VO/MelinoeEmotes/EmotePoweringUp", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteFiredUpLASTCHANCE", Delay = 0 })

	thread( PlayVoiceLines, HeroVoiceLines.FishHookedVoiceLines, true )
	
	wait( 3.0 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteShocked" })
	thread( InCombatTextArgs, { TargetId = args.FishingReelPointId, Text = "Fishing_ReelHint", Duration = 2.0 } )

	local pipSpacing = 50
	local pipOffsetX = ((fishData.CatchZoneHits - 1) / 2) * -pipSpacing
	for index = 1, fishData.CatchZoneHits do
		local key = "MovePipId"..index
		args[key] = SpawnObstacle({ Name = "BlankObstacle", DestinationId = args.FishingReelPointId, OffsetX = pipOffsetX, OffsetZ = -200, })
		SetAnimation({ Name = "ExorcismPip", DestinationId = args[key] })
		pipOffsetX = pipOffsetX + pipSpacing
		wait( 0.1 )
	end
	
	wait( 1.85 )

	PlaySound({ Name = "/Leftovers/SFX/MatchStart" })

	ScreenAnchors.FishingVignette = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY, })
	SetAnimation({ Name = "FishingVignette", DestinationId = ScreenAnchors.FishingVignette })

end

function FishingReelHitPresentation( source, args, fishData )
	thread( InCombatTextArgs, { TargetId = args.FishingReelPointId, Text = "Fishing_ReelHit", Duration = 1.0 } )
	SetAnimation({ Name = "Melinoe_Fishing_Reel_Hit", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "FishingSplashA", DestinationId = args.FishingReelPointId })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteCharging", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/MidAirCollision", Id = CurrentRun.Hero.ObjectId })

	thread( FishingReelCooldownPresentation, source, args, fishData, true )
	local index = fishData.CatchZoneHits - args.HitsRemaining
	local key = "MovePipId"..index
	SetAnimation({ Name = "ExorcismPip_Full", DestinationId = args[key] })
end

function FishingReelMissPresentation( source, args, fishData )
	thread( InCombatTextArgs, { TargetId = args.FishingReelPointId, Text = "Fishing_ReelMiss", Duration = 1.0, Cooldown = 1.0 } )
	SetAnimation({ Name = "Melinoe_Fishing_Reel_Miss", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/Exalted/EnemyShieldBlock" })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHurt", Id = CurrentRun.Hero.ObjectId })
	thread( FishingReelCooldownPresentation, source, args, fishData, false )

	local index = (fishData.CatchZoneHits - args.HitsRemaining) + 1
	local key = "MovePipId"..index
	SetColor({ Color = Color.Red, Id = args[key], Duration = 0.2 })
	thread( GenericPresentation, source, { PreWait = 0.5, Color = Color.White, Id = args[key], Duration = 0.2 } )

end

function FishingReelCooldownPresentation( source, args, fishData, fishHit )
	if args.HitsRemaining <= 0 or args.ReelEndTime < fishData.ReelCooldown then
		return
	end
	local timerId = SpawnObstacle({Name = "BlankObstacle", Group = "Combat_UI_World_Backing", DestinationId = args.FishingReelPointId })
	Attach({ Id = timerId, DestinationId = args.FishingReelPointId })
	local animation = "FishingReelTimerSuccess"
	if not fishHit then
		animation = "FishingReelTimerFail"
		Shake({ Id =  args.FishingReelPointId, Distance = 3, Speed = 100, Duration = 0.2 })
	end
	SetAnimation({ Name = animation, DestinationId = args.FishingReelPointId, PlaySpeed = 1 / fishData.ReelCooldown, Scale = 0.5, Group = "Combat_UI_World_Backing", OffsetY = 250 })
end

function FishingEndPresentation( fishData, fishingAnimationPointId, args )

	SetAlpha({ Id = fishingAnimationPointId, Fraction = 0, Duration = 0 })
	if fishData ~= nil and fishData.CatchZoneHits ~= nil then
		for index = 1, fishData.CatchZoneHits do
			local key = "MovePipId"..index
			SetAlpha({ Id = args[key], Fraction = 0.0, Duration = 0.0 })
		end
	end

	SetAlpha({ Id = ScreenAnchors.FishingVignette, Fraction = 0.0, Duration = 1.0 })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1.0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom

	if fishData ~= nil and args.Success then

		GameState.FishingSuccesses = (GameState.FishingSuccesses or 0) + 1
		CurrentRun.FishingSuccesses = (CurrentRun.FishingSuccesses or 0) + 1
		GameState.FishCaught[fishData.Name] = (GameState.FishCaught[fishData.Name] or 0) + 1
		CurrentRun.FishCaught[fishData.Name] = (CurrentRun.FishCaught[fishData.Name] or 0) + 1
		if args.UsedFamiliar then
			GameState.FishingSuccessesFamiliar = (GameState.FishingSuccessesFamiliar or 0) + 1
			CurrentRun.FishingSuccessesFamiliar = (CurrentRun.FishingSuccessesFamiliar or 0) + 1
		else
			GameState.FishingSuccessesManual = (GameState.FishingSuccessesManual or 0) + 1
			CurrentRun.FishingSuccessesManual = (CurrentRun.FishingSuccessesManual or 0) + 1
		end

		thread( MarkObjectiveComplete, "Fishing" )
		thread( PlayVoiceLines, fishData.FishCaughtVoiceLines )

		CreateAnimation({ Name = "FishingSplashA", DestinationId = fishingAnimationPointId })
		CreateAnimation({ Name = "FishingSplashB", DestinationId = fishingAnimationPointId })
		
		--Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 2, Speed = 200, Duration = 0.35 })
		PlaySound({ Name = "/SFX/CriticalHit" })
		if args.UsedFamiliar then
			PlaySound({ Name = "/SFX/Familiars/CatMeowExclaim2", Id = MapState.FamiliarUnit.ObjectId })
		else
			PlaySound({ Name = "/VO/MelinoeEmotes/EmoteAttackingStaff" })
		end
		thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.28, Duration = 0.4 }, } )
		wait(0.1)
		PlaySound({ Name = "/SFX/Player Sounds/ZagreusWhooshDropIn" })

		StopSound({ Id = AudioState.FishingMusicId, Duration = 0.5 })
		AudioState.FishingMusicId = nil

		wait(0.2)
		--Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 2, Speed = 200, Duration = 0.35 })
		PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegDeathSplash", Id = fishingAnimationPointId })
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteCharging" })
		if not args.UsedFamiliar then
			SetAnimation({ Name = "Melinoe_Fishing_Success", DestinationId = CurrentRun.Hero.ObjectId })
		end
		thread( DoRumble, { { ScreenPreWait = 0.7, LeftFraction = 0.35, Duration = 0.4 }, } )
		
		local resourceTimes = 1
		if RandomChance( GetTotalHeroTraitValue("DoubleToolRewardChance")) then
			resourceTimes = resourceTimes + 1
		end
		
		if resourceTimes > 1 then
			thread( ChaosRewardIncreasedPresentation, fishingAnimationPointId )
			waitUnmodified( 0.25, RoomThreadName )
		end
		AddResource( fishData.Name, 1 * resourceTimes, "Fishing" )

		PlaySound({ Name = "/Leftovers/SFX/VictoryScreenUpdateSFX", Delay = 1 })

		local fishingText = "Fishing_SuccessGoodTitle"

		thread( PlayVoiceLines, fishData.FishIdentifiedVoiceLines )

		thread( DisplayInfoBanner, nil, {
			Icon = fishData.Name,
			TitleText = fishingText,
			TextOffsetY = -20,
			SubtitleText = "Fishing_SuccessSubtitle",
			SubtitleData = { LuaKey = "TempTextData", LuaValue = fishData },
			IconOffsetY = 20,
			SubtitleOffsetY = 100,
			HighlightIcon = true,
			IconMoveSpeed = 0.1,
			IconScale = 0.64,
			AdditionalAnimation = "FishCatchPresentationSparkles",
			IconBacking = "FishCatchIconBacking",
			AnimationName = "LocationTextBGFish",
			AnimationOutName = "LocationTextBGFishOut",
		})

		CheckCodexUnlock( "Fish", fishData.Name )

		wait ( 0.22 )
		ApplyForce({ Id = CurrentRun.Hero.ObjectId, Speed = 640, Angle = GetAngleBetween({ DestinationId = CurrentRun.Hero.ObjectId, Id = fishingAnimationPointId}) })

		wait( 0.88 )

		if MapState.FamiliarUnit ~= nil and MapState.FamiliarUnit.Name == "CatFamiliar" then
			PlaySound({ Name = MapState.FamiliarUnit.VictorySound or "/EmptyCue", Id = MapState.FamiliarUnit.ObjectId })
			--thread( PlayEmoteSimple, MapState.FamiliarUnit, { AnimationName = MapState.FamiliarUnit.VictoryEmoteAnim or "StatusIconSmile" } )
		end

	else
		GameState.FishingFails = (GameState.FishingFails or 0) + 1
		CurrentRun.FishingFails = (CurrentRun.FishingFails or 0) + 1

		StopSound({ Id = AudioState.FishingMusicId, Duration = 0.3 })
		AudioState.FishingMusicId = nil

		thread( MarkObjectiveFailed, "Fishing" )
		--Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 2, Speed = 200, Duration = 0.35 })
		SetAnimation({ Name = "Melinoe_Fishing_Failure", DestinationId = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = roomData.FishingFailSound or "/Leftovers/SFX/BigSplashRing", Delay = 0.3 })
		PlaySound({ Name = "/SFX/CrappyRewardDrop", Delay = 0.5 })

		PlaySound({ Name = "/Leftovers/SFX/ImpCrowdLaugh" })
		thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.7 }, } )

		if CurrentRun.Hero.FishingState == "TooEarly" then
			thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtVoiceLines, true )

			thread( DisplayInfoBanner, nil, {
				TitleText = "Fishing_FailedTitle",
				SubtitleText = "Fishing_FailedEarly",
			})

		else
			if CurrentRun.Hero.FishingState == "TooLate" then
				thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtVoiceLines, true )
			elseif CurrentRun.Hero.FishingState == "WayLate" then
				thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtTooLateVoiceLines, true )
			else
				thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtVoiceLines, true )
			end

			thread( DisplayInfoBanner, nil, {
			TitleText = "Fishing_FailedTitle",
			SubtitleText = "Fishing_FailedLate",
			})
		end
		if CurrentRun.Hero.IsDead then
			wait( 2.3 )
		else
			wait( 1.1 )
		end
	end
	CurrentRun.Hero.FishingStarted = false
	RemoveTimerBlock( CurrentRun, "Fishing" )
	UnfreezePlayerUnit("Fishing")
	UnblockCombatUI("Fishing")

	if roomData.ZoomFraction ~= nil then
		AdjustZoom({ Fraction = roomData.ZoomFraction, LerpTime = 1.5 })
	else
		AdjustZoom({ Fraction = 1.0, LerpTime = 1.5 })
	end
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5 })
	--wait( 1.5 )
	wait( 1.51 )
	Destroy({ Id = ScreenAnchors.FishingVignette })
	local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
end

function FishingWayLatePresentation()
	wait( 14, RoomThreadName )
	while not CurrentRun.Hero.FishingInput do
		thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtWayTooLateVoiceLines, true )
		wait( 1.5, RoomThreadName )
		if not CurrentRun.Hero.FishingInput then
			thread( InCombatTextArgs, { Text = "Fishing_StopHint", TargetId = CurrentRun.Hero.ObjectId, Duration = 1.25 } )
		end
		wait( 28.0, RoomThreadName )
		if CurrentRun.Hero.FishingInput then
			break
		end
	end
end

function FamiliarFishingPresentation( fishingPoint )

	AddInputBlock({ Name = "MelFamiliarFishing" })
	AddTimerBlock( CurrentRun, "Fishing" )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = MapState.FamiliarUnit.ObjectId })
	SetAnimation({ Name = "Melinoe_CrossCast_Start_Fast", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = MapState.FamiliarUnit.EquipSound or "/EmptyCue", Id = MapState.FamiliarUnit.ObjectId })

	local familiar = MapState.FamiliarUnit
	familiar.AttackBlocks.Fishing = true


	StopAnimation({ Name = familiar.DefaultAIData.RecruitAnimation, DestinationId = familiar.ObjectId })
	familiar.RecruitAnimationId = nil

	thread( PlayVoiceLines, HeroVoiceLines.FamiliarHarvestVoiceLines, true )

	waitUnmodified( 0.4 )
	SetAnimation({ Name = "MelinoeCrossCast", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = fishingPoint.ObjectId, })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = MapState.FamiliarUnit.ObjectId, OffsetZ = -60 })

	waitUnmodified( 0.3 )

	PlaySound({ Name = "/SFX/Familiars/CatMeowQuestioning", Id = familiar.ObjectId })
	
	SetAnimation({ Name = "Familiar_Cat_Sleep_Awaken", DestinationId = familiar.ObjectId })
	
	if GetDistance({ Id = familiar.ObjectId, DestinationId = fishingPoint.ObjectId }) >= FamiliarData.CatFamiliar.MinDistanceToTeleportForFishing then
		SetAnimation({ Name = "Familiar_Cat_DropIn_Exit", DestinationId = familiar.ObjectId })
		wait(0.2)
		-- teleport to the closest spawn point first
		CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = familiar.ObjectId })
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.2 })
		wait( 0.65 )
		AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = fishingPoint.ObjectId })
		PlaySound({ Name = "/SFX/Familiars/CatGrumpy", Id = familiar.ObjectId })

		local spawnPointId = GetClosest({ Id = fishingPoint.ObjectId, DestinationNames = "SpawnPoints", RequiredLocationUnblocked = true, })
		if spawnPointId == 0 then
			-- fall back to the hero's position if no spawn points exist
			spawnPointId = CurrentRun.Hero.ObjectId
		end
		Teleport({ Id =  familiar.ObjectId, DestinationId = spawnPointId })
		CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = familiar.ObjectId })
		SetAnimation({ Name = "Familiar_Cat_DropIn_Enter", DestinationId = familiar.ObjectId })
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.2 })
		wait( 0.5 )
	else
		-- wait for the awaken animation to finish
		wait( 1.0 )
	end
	--SetAnimation({ Name = "MelinoeBoonInteractPowerUp", DestinationId = CurrentRun.Hero.ObjectId })

	Move({ Id = familiar.ObjectId, DestinationId = fishingPoint.ObjectId, SuccessDistance = 150, OnFailGoToNearestToGoal = true })
	local notifyName = "FamiliarNotify"		
	NotifyOnStopped({ Id = familiar.ObjectId, Notify = notifyName, Timeout = 8.0 })
	waitUntil( notifyName )	
	Stop({ Id = familiar.ObjectId })
	wait( 0.02 )
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = fishingPoint.ObjectId })
	SetAnimation({ Name = "Familiar_Cat_Fish_Start", DestinationId = familiar.ObjectId })
	wait( RandomFloat( 1.0, 1.5 ) )

	SetAnimation({ Name = "Familiar_Cat_Fish_Swipe", DestinationId = familiar.ObjectId })
	
	wait( 0.8 )

	RemoveInputBlock({ Name = "MelFamiliarFishing" })
	RemoveTimerBlock( CurrentRun, "Fishing" )
	familiar.AttackBlocks.Fishing = nil

	SetAnimation({ Name = "FishingPointUsed", DestinationId = fishingPoint.ObjectId })

	PlaySound({ Name = "/SFX/Player Sounds/ZagreusGunReloadCompleteFlashLucifer" })

end