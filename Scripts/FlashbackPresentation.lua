-- Flashback01 / Hecate Flashback
function SetupFlashback01( source, args )

	SessionState.InFlashback = true

	-- Hypnos initially silent
	local hypnosId = GetIdsByType({ Name = "NPC_Hypnos_01" })
	SetAnimation({ Name = "Hypnos_Sleep_Idle_Silent", DestinationId = hypnosId })

	SetupFlashbackPlayerUnitMel( source, args )
	StartRoomAmbience( source, CurrentHubRoom )

	HideCombatUI( "Flashback" )

	-- deactivate Hecate
	UseableOff({ Id = 560340 })

	FadeOut({ Color = Color.White, Duration = 0.3 })

	SetCameraClamp({ Ids = { 566565, 561501, 561499, 561498, 567076, 567075, 567074, }, SoftClamp = 0.75 })
	AdjustZoom({ Fraction = 1.25, LerpTime = 2.0 })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	local voiceLines =
	{
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			-- None
		},
		{ Cue = "/VO/Melinoe_2103", Text = "How long... has it been..." },
	}
	thread( PlayVoiceLines, voiceLines )

	wait(0.3)

	FadeOut({ Color = Color.Black, Duration = 3.0 })
	-- AdjustColorGrading({ Name = "CrossroadsFlashback", Duration = 0.0 })

	wait(3.0)

	-- Hypnos can snore now...
	SetAnimation({ Name = "Hypnos_Sleep_Idle", DestinationId = hypnosId })

	FadeIn({ Duration = 2.0 })

	-- thread( NightmareScreenEffects )

	SetupFlashbackMusic( source, args )
	SecretMusicPlayer( "/Music/MusicExploration3_MC", { ParamNames = { "Keys", "Drums", } } )
	thread( DisplayInfoBanner, nil, { Text = args.NightmareMessage, SubtitleText = args.NightmareMessageSubtitle, Delay = 0.5, Layer = "Overlay" } )

	ActivatePrePlacedUnits( source, args )

	AddInputBlock({ Name = "SetupFlashback01" })

	local sourceId = args.Ids[1]
	local hecate = ActiveEnemies[sourceId]
	SetAnimation({ Name = "Hecate_Hub_Hide_Start", DestinationId = hecate.ObjectId })
	wait( 3.25 )

	voiceLines =
	{
		{ Cue = "/VO/Melinoe_2104", Text = "...Three... two... {#Emph}one...!" },
	}
	PlayVoiceLines( voiceLines, false )
	wait( 0.4 )

	RemoveInputBlock({ Name = "SetupFlashback01" })

	if args.TextLineSet ~= nil then
		ProcessTextLines( hecate, args.TextLineSet )
		PlayRandomRemainingTextLines( hecate, args.TextLineSet )
	end

end

function UpdateHubMainFlashback( source, args )

	if args.Hypnos then
		-- after talking to Hypnos

		-- remove hiders
		local hiderIds = GetIds({ Names = { "Dimmer_01", "Dimmer_01_ColorBurn" } })
		SetAlpha({ Ids = hiderIds, Fraction = 0.0, Duration = 0.35 })
		thread( DestroyOnDelay, hiderIds, 0.35 )

		-- destroy impassability near Hypnos
		Destroy({ Ids = { 786405, 786406, 786434 } })

	elseif args.InspectPoint then
		-- after using InspectPoint

		SecretMusicPlayer( EnemyData.NPC_Artemis_01.ThemeMusic, { ParamNames = { "Keys", } } )

		-- remove hiders
		local hiderIds = GetIds({ Names = { "Dimmer_02", "Dimmer_02_ColorBurn" } })
		SetAlpha({ Ids = hiderIds, Fraction = 0.0, Duration = 0.35 })
		thread( DestroyOnDelay, hiderIds, 0.35 )

		-- extend clamps to level 2
		SetCameraClamp({ Ids = { 585238, 585237, 585236, 424948, 567074, 566565, 583653 }, SoftClamp = 0.75 })

		-- destroy impassability near Odysseus
		Destroy({ Ids = { 585277, 585279, 585280, 585293, 585306, 585307, 585308 } })

		AdjustZoom({ Fraction = 1.06, LerpTime = 5.0 })

		thread( HecateHideAndSeekHint )
	elseif args.Hecate then
		-- after first hecate interaction

		-- remove hiders
		local hiderIds = GetIds({ Names = { "Dimmer_03", "Dimmer_03_ColorBurn" } })
		SetAlpha({ Ids = hiderIds, Fraction = 0.0, Duration = 0.35 })
		thread( DestroyOnDelay, hiderIds, 0.35 )

		-- extend clamps to level 3
		SetCameraClamp({ Ids = { 583653, 583654, 583655, 583656, 585236, 567074, }, SoftClamp = 0.75 })

		-- destroy impassability near Tent
		Destroy({ Ids = { 585282, 585281, 786476, 786475, 786474, } })

		AdjustZoom({ Fraction = 1.03, LerpTime = 5.0 })
	end

end

function HecateHideAndSeekExit( source, args )


	args = args or {}
	UseableOff({ Id = source.ObjectId })
	wait( args.WaitTime or 0 )

	SetAnimation({ Name = "HecateHubGreet", DestinationId = source.ObjectId })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic" })
	CreateAnimation({ Name = "DeathSequenceFxBack", DestinationId = source.ObjectId, Group = "Combat_UI_World_Add", OffsetX = 15, OffsetY = 30 })
	CreateAnimation({ Name = "DeathSequenceFxFront", DestinationId = source.ObjectId, Group = "Combat_UI_World_Add", OffsetX = 15, OffsetY = 30 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })

	wait( 1.2, RoomThreadName )

	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.35 })

	wait( 2.5, RoomThreadName )

	Teleport({ Id = source.ObjectId, DestinationId = args.TeleportId })
	if args.AngleTowardTargetId ~= nil then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = args.AngleTowardTargetId })
	end
	SetAnimation({ Name = "Hecate_Hub_Hide_FireLoop", DestinationId = source.ObjectId })
	CreateAnimation({ Name = "HecateTeleportFxFront", DestinationId = source.ObjectId, Group = "FX_Standing_Add" })
	SetAlpha({ Id = source.ObjectId, Fraction = 1.0, Duration = 0.2 })

	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )

	thread( HecateHideAndSeekHint )

end

function HecateFlashback02Exit( source, args )

	args = args or {}
	UseableOff({ Id = source.ObjectId })
	wait( args.WaitTime or 0 )

	SetAnimation({ Name = "HecateHubGreet", DestinationId = source.ObjectId })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic" })
	CreateAnimation({ Name = "DeathSequenceFxBack", DestinationId = source.ObjectId, Group = "Combat_UI_World_Add", OffsetX = 15, OffsetY = 30 })
	CreateAnimation({ Name = "DeathSequenceFxFront", DestinationId = source.ObjectId, Group = "Combat_Menu_TraitTray_Overlay_Additive", OffsetX = 15, OffsetY = 30 })

	wait( 1.2, RoomThreadName )

	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.35 })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = source.ObjectId, Property = "StopsProjectiles", Value = false })

	wait( 2.5, RoomThreadName )

	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )
	source.Mute = true
end

function HecateHideAndSeekHint( source, args )

	local hecateIds = GetIdsByType({ Name = "NPC_Hecate_Story_01" })
	source = ActiveEnemies[hecateIds[1]]

	local voiceLines =
	{
		GameStateRequirements =
		{
			-- None
		},
		RandomRemaining = true,
		{ Cue = "/VO/Hecate_0523", Text = "Melinoë...!", PreLineAnim = "Hecate_Hub_Hide_Fidget" },
		{ Cue = "/VO/Hecate_0525", Text = "{#Emph}<Chuckle>" },
		{ Cue = "/VO/Hecate_0526", Text = "{#Emph}<Chuckle>" },
	}

	while true do
		wait( 22.0, "HecateHideAndSeekHint" )
		thread( PlayVoiceLines, voiceLines, nil, source, args )
		Flash({ Id = source.ObjectId, Speed = 1.0, MinFraction = 0.0, MaxFraction = 0.1, Color = Color.White, ExpireAfterCycle = true })
	end

end

-- Flashback02 / Hades Flashback -- HadesBedroom
function SetupFlashback02( source, args )

	SessionState.InFlashback = true

	CurrentRun.BlockDeathAreaTransitions = true
	CurrentRun.CurrentRoom.BlockCameraReattach = true
	
	AddInputBlock({ Name = "SetupFlashback02" })
	SetupFlashbackPlayerUnitHades( source, args )

	local doorOpenAnim = "HouseDoor03_Open"
	SetAnimation({ DestinationId = 555681, Name = doorOpenAnim })

	local voiceLines =
	{
		Source = { LineHistoryName = "PlayerUnit", SubtitleColor = Color.White },
		GameStateRequirements =
		{
			-- None
		},
		{ Cue = "/VO/Melinoe_2929", Text = "What... where... Father...", PreLineWait = 0.6 },
	}
	thread( PlayVoiceLines, voiceLines )

	FadeOut({ Color = Color.White, Duration = 0.3 })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	wait(0.3)

	FadeOut({ Color = Color.Black, Duration = 3.0 })

	wait(3.0)

	FadeIn({ Duration = 2.0 })

	thread( NightmareScreenEffects )

	local doorCloseAnim = "HouseDoor03_Close"
	SetAnimation({ DestinationId = 555681, Name = doorCloseAnim })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	SetupFlashbackMusic( source, args )
	thread( DisplayInfoBanner, nil, { Text = args.NightmareMessage, SubtitleText = args.NightmareMessageSubtitle, Delay = 0.5, Layer = "Overlay",
		AnimationName = "LocationBackingIrisSmallIn",
		AnimationOutName = "LocationBackingIrisSmallOut",
		IconBackingAnimationName = "LocationBackingIrisSubtitleStarIn",
		IconBackingAnimationOutName = "LocationBackingIrisSubtitleStarOut",
		SubtitleOffsetY = 15,
		SubtitleDelay = 0.5,
	} )
	CreateCameraWalls({ })
	RemoveInputBlock({ Name = "SetupFlashback02" })
end

function Flashback02Objective( source, args )
	killTaggedThreads( CombatUI.HideThreadName )
	local notifyName = "Flashback02Prompt"
	NotifyOnControlPressed({ Names = { "Up", "Down", "Left", "Right", "Move", }, Notify = notifyName, Timeout = args.Delay })
	waitUntil( notifyName )
	if _eventTimeoutRecord[notifyName] then

		local voiceLines =
		{
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				-- None
			},
			{ Cue = "/VO/Hades_0170", Text = "What am I waiting for..." },
		}
		thread( PlayVoiceLines, voiceLines )

		CheckObjectiveSet( "Flashback02Prompt" )
	end
end

-- Flashback02 -- DeathArea / Hub
function SetupFlashback02_DeathArea( source, args )

	SessionState.InFlashback = true

	SetupFlashbackPlayerUnitHades( source, args )

	HideCombatUI( "Flashback" )

	local doorOpenAnim = "HouseDoor03_Open"
	SetAnimation({ DestinationId = 555681, Name = doorOpenAnim })

	thread( PlayVoiceLines, GlobalVoiceLines.StartNightmareVoiceLines )

	FadeIn({ Duration = 2.0 })

	thread( NightmareScreenEffects )

	local doorCloseAnim = "HouseDoor03_Close"
	SetAnimation({ DestinationId = 555681, Name = doorCloseAnim })
	PlaySound({ Name = "/SFX/AdminDoorCloseSFX", Id = 555681, Delay = 0.4 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
	
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	
	local endVoiceLines =
	{
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			-- None
		},
		{ Cue = "/VO/Hades_0002", Text = "{#Emph}<Gasp>" },
	}
	thread( PlayVoiceLines, endVoiceLines )

	SetupFlashbackMusic( source, args )
	--thread( DisplayInfoBanner, nil, { Text = args.NightmareMessage, SubtitleText = args.NightmareMessageSubtitle, Delay = 0.5, Layer = "Overlay" } )
	CreateCameraWalls({ })

	CurrentRun.BlockDeathAreaTransitions = false
	CurrentRun.CurrentRoom.BlockCameraReattach = false

end

-- Flashback03 -- Chronos
GlobalVoiceLines.ChronosRemembranceVoiceLines =
{
	{
		PreLineWait = 0.76,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Chronos_1406", Text = "All this time... for naught. Perhaps the Fates themselves always knew my plans would be undone, again." },
	},
}
GlobalVoiceLines.ChronosBetterPastVoiceLines =
{
	{
		PreLineWait = 1.75,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Chronos_1519", Text = "Is this... the future...? Or is it the past...? Not merely mine... but yours, Granddaughter...? Everybody in this House...?" },
	},
}
function SetupFlashback03( source, args )

	SessionState.InFlashback = true
	
	SetupFlashbackPlayerUnitChronos( source, args )
	StartRoomAmbience( source, CurrentRun.CurrentRoom )
	CheckConversations()

	local youngMelId = GetIdsByType({ Name = "NPC_Melinoe_Story_01" })[1]
	SetAnimation({ Name = "Melinoe_Young_Idle_Crouched", DestinationId = youngMelId })

	SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = { 815704, 814992, 816714 } }) -- door and kitchen island impassability

	if MapState.InitialSpeed == nil then
		MapState.InitialSpeed = GetUnitDataValue({ Id = CurrentRun.Hero.ObjectId, Property = "Speed" })
	end
	SetUnitProperty({ Property = "Speed", Value = 300, DestinationId = CurrentRun.Hero.ObjectId })

	HideCombatUI( "Flashback" )

	FadeOut({ Color = Color.Black, Duration = 3.0 })

	SetCameraClamp({ Ids = { 555717, 422050, 422049, 422048, 422047, 422046, 422045, 422043, 40009, 555718 }, SoftClamp = 0.75 })
	AdjustZoom({ Fraction = 0.82, LerpTime = 2.0 })
	SetGoalAngle ({ Id = CurrentRun.Hero.ObjectId, Angle = 150, CompleteAngle = true })

	-- PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	wait(0.3)

	PlayVoiceLines( GlobalVoiceLines.ChronosRemembranceVoiceLines )
	FadeIn({ Duration = 0.0 })
	local fullscreenBlackImageId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay", Animation = "Backgrounds/rectangle_01", Scale = 10, Color = Color.Black })

	wait(1.0)
	FullScreenFadeInAnimation( "RoomTransitionIn_TimeWarp_Alt", "ChronosSand" )

	-- PlaySound({ Name = "/Leftovers/Menu Sounds/TimeTunnelChime" })
	wait(1.5)

	local voiceLines =
	{
		{ Cue = "/VO/Chronos_1408", Text = "Three... two... {#Emph}one...!" },
	}
	PlayVoiceLines( voiceLines )

	-- PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })

	thread( NightmareScreenEffects )
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.0, OffsetY = -350, Retarget = true })
	wait( 0.5 )

	Destroy({ Id = fullscreenBlackImageId })
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation( "RoomTransitionOut_Down" )
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 6.0, OffsetY = -150, Retarget = true })

	wait( 0.8 )

	-- SetupFlashbackMusic( source, args )
	-- SecretMusicPlayer( "/Music/MusicExploration3_MC", { ParamNames = { "Keys", "Drums", } } )
	thread( DisplayInfoBanner, nil, { Text = "Location_ChronosFlashback", SubtitleText = "Location_ChronosFlashback_Subtitle", Delay = 0.5, Layer = "Overlay",
		AnimationName = "LocationBackingIrisSmallIn",
		AnimationOutName = "LocationBackingIrisSmallOut",
		IconBackingAnimationName = "LocationBackingIrisSubtitleStarIn",
		IconBackingAnimationOutName = "LocationBackingIrisSubtitleStarOut",
		SubtitleOffsetY = 15,
		SubtitleDelay = 0.5,
	} )

	AddInputBlock({ Name = "SetupFlashback03" })
	Activate({ Id = 815960 })

	wait( 0.5 )
	SecretMusicPlayer( "/Music/HypnosLullaby" )

	wait( 0.5 )

	voiceLines =
	{
		{ Cue = "/VO/Chronos_1409", Text = "Ready or not, hence I go...", PreLineWait = 1.0 },
	}
	PlayVoiceLines( voiceLines, false )
	wait( 0.4 )

	RemoveInputBlock({ Name = "SetupFlashback03" })

end

function UpdateChronosFlashback( source, args )
	Destroy({ Id = 818405 }) -- kitchen impassability
	local hiderIds = GetIds({ Name = "KitchenDimmers01" })
	SetAlpha({ Ids = hiderIds, Fraction = 0.0, Duration = 0.35 })
	thread( DestroyOnDelay, hiderIds, 0.35 )
end

function ChronosCrouchPresentation( source, args )
	args = args or {}

	AddInputBlock({ Name = "ChronosCrouchPresentation" })

	PanCamera({ Ids = { CurrentRun.Hero.ObjectId, source.ObjectId }, Duration = 5, Retarget = true })

	local angle = 210
	local offset = CalcOffset( math.rad(angle), 160 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = source.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10

	thread( PlayVoiceLines, GlobalVoiceLines.ChronosHideAndSeekVoiceLines )

	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	SetGoalAngle ({ Id = CurrentRun.Hero.ObjectId, Angle = 28, })
	wait( 0.3 )

	SetAnimation({ Name = "NPC_Chronos_Enlightened_Crouch_Start", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 1.0 )

	--SetGoalAngle ({ Id = source.ObjectId, Angle = 215, })
	SetAnimation({ Name = "Melinoe_Young_Idle_Crouched_End", DestinationId = source.ObjectId })

	RemoveInputBlock({ Name = "ChronosCrouchPresentation" })

	wait( 0.3 )
end

Using "EndingFlashback"
function Flashback03MemoryPresentation( source, args )

	AddInputBlock({ Name = "Flashback03MemoryPresentation" })
	killTaggedThreads( "NightmareScreenEffects" )

	local removeIds = { 813561 }

	if MapState.InitialSpeed ~= nil then
		SetUnitProperty({ Property = "Speed", Value = MapState.InitialSpeed, DestinationId = CurrentRun.Hero.ObjectId })
		MapState.InitialSpeed = nil
	end

	PanCamera({ Ids = { CurrentRun.Hero.ObjectId, source.ObjectId }, Duration = 40, OffsetY = -600, Retarget = true })

	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 10 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

	wait(1.35)

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.1 }, } )
	ShakeScreen({ Speed = 50, Distance = 4, FalloffSpeed = 1000, Duration = 0.1, Angle = 90 })
	PlaySound({ Name = "/SFX/Player Sounds/TagSFX", Id = 816998 })

	wait(5.15)

	PlaySound({ Name = "/Leftovers/Menu Sounds/TimeTunnelChime" })

	SecretMusicPlayer( "/Music/MusicPlayer/OrpheusSong1MusicPlayer2" )

	AdjustColorGrading({ Name = "Sepia", Duration = 3 })
	AdjustFullscreenBloom({ Name = "Flashback03TransitionA", Duration = 0 })
	SetAlpha({ Id = ScreenAnchors.FullscreenAlertFxAnchor, Fraction = 0, Duration = 8})
	AdjustFullscreenBloom({ Name = "Flashback03TransitionB", Duration = 10 })

	PlayVoiceLines( GlobalVoiceLines.ChronosBetterPastVoiceLines )

	wait( 1.1 )
	AltAspectRatioFramesShow()
	wait( 0.2 )

	Destroy({ Ids = removeIds })

	AdjustFullscreenBloom({ Name = "Off", Duration = 0.01 })
	AdjustColorGrading({ Name = "Off", Duration = 0.01 })
	ShowMemorySequence()

	AltAspectRatioFramesHide()
	RemoveInputBlock({ Name = "Flashback03MemoryPresentation" })
	MelBackToBedroomPresentation( source, args )
end

-- Flashback03 -- Chronos -- MemorySequence
GlobalVoiceLines.MemorySequenceVoiceLines =
{
	Queue = false,
	UsePlayerSource = true,

	-- persephone & cerberus
	{ Cue = "/VO/MelinoeField_5132", Text = "{#Emph}Hahah! {#Prev}Yay!", LineHistoryName = "PlayerUnit_Flashback",

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 8.3 }, },

	-- martial training
	{ Cue = "/VO/MelinoeField_5133", Text = "Take that!", LineHistoryName = "PlayerUnit_Flashback",

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 0.3 }, },

	-- pool of styx
	{ Cue = "/VO/MelinoeField_5134", Text = "Right this way please!", LineHistoryName = "PlayerUnit_Flashback",

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 4.5 }, },

	-- history lesson
	{ Cue = "/VO/MelinoeField_5135", Text = "What happened then...?", LineHistoryName = "PlayerUnit_Flashback",

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 4.6 }, },

	-- lounge time
	{ Cue = "/VO/MelinoeField_5137", Text = "I don't know if that's {#Emph}me...", LineHistoryName = "PlayerUnit_Flashback",

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 6.3 }, },

	-- game table
	{ Cue = "/VO/MelinoeField_5138", Text = "I finally won!", LineHistoryName = "PlayerUnit_Flashback",

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 4.1 }, },

	-- singing with orpheus
	{ Cue = "/VO/MelinoeField_5139", Text = "{!Icons.Music}It's in the blood...{!Icons.Music}", LineHistoryName = "PlayerUnit_Flashback",

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 4.2 }, },

	-- the mirror of night
	{ Cue = "/VO/MelinoeField_5140", Text = "Night and Darkness guide me...", LineHistoryName = "PlayerUnit_Flashback",

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 5.4  }, },
}
GlobalVoiceLines.MemorySequenceVoiceLines2 =
{
	Queue = false,

	-- persephone & cerberus
	{ Cue = "/VO/Persephone_0145", Text = "{#Emph}Hahah! {#Prev}Easy there, Cerberus!",
		Source = { LineHistoryName = "NPC_Persephone_01", SubtitleColor = Color.PersephoneVoice },

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 4.8 }, },

	-- martial training
	{ Cue = "/VO/Achilles_0002", Text = "That's it, lass! Just like we trained!",
		Source = { LineHistoryName = "NPC_Achilles_01", SubtitleColor = Color.AchillesVoice },

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 3.4 }, },

	-- pool of styx
	{ Cue = "/VO/Achilles_0009", Text = "Unbelievable.",
		Source = { LineHistoryName = "NPC_Thanatos_01", SubtitleColor = Color.ThanatosVoice },

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 3.8 }, },

	-- history lesson
	{ Cue = "/VO/Chronos_1462", Text = "Why, the bloodiest part!",
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 4.1 }, },

	-- lounge time
	{ Cue = "/VO/Achilles_0007", Text = "I got you something.",
		Source = { LineHistoryName = "NPC_Megaera_01", SubtitleColor = Color.MegVoice },

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 1.1 }, },

	{ Cue = "/VO/Achilles_0010", Text = "{#Emph}Ooh!",
		Source = { LineHistoryName = "NPC_Dusa_01", SubtitleColor = Color.DusaVoice },

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 0.1 }, },

	-- game table
	{ Cue = "/VO/Zagreus_0477", Text = "{#Emph}Hahaha{#Prev}, blast...",
		Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 2.9 }, },

	-- singing with orpheus
	{ Cue = "/VO/Achilles_0008", Text = "{#Emph}Ah.",
		Source = { LineHistoryName = "NPC_Orpheus_01", SubtitleColor = Color.OrpheusVoice },

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 5.1 }, },

	-- the mirror of night
	{ Cue = "/VO/Nyx_0125", Text = "Focus...",
		Source = { LineHistoryName = "NPC_Nyx_01", SubtitleColor = Color.NyxVoice },

	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 2.9 }, },
}
-- Time Tunnel
function ShowMemorySequence()

	CurrentRun.Hero.SubtitleColor = Color.White 
	CurrentRun.Hero.NarrativeFadeInColor = Color.Teal

	thread( PlayVoiceLines, GlobalVoiceLines.MemorySequenceVoiceLines )
	thread( PlayVoiceLines, GlobalVoiceLines.MemorySequenceVoiceLines2 )

	local illustrationId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Animation = "EndingFlashback", X = ScreenCenterX, Y = ScreenCenterY, Alpha = 0.0 })
	SetAlpha({ Id = illustrationId, Fraction = 1.0, Duration = 0.0 })


	wait( 0.75 )
	-- FullScreenFadeInAnimation()

	--local loopingSoundId = PlaySound({ Name = "/Leftovers/Object Ambiences/ReconstructionAmbience" })

	waitUnmodified( 67.0 )

	StopSound({ Id = AudioState.SecretMusicId, Duration = 5 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

	--StopSound({ Id = loopingSoundId, Duration = 0.4 })
	--loopingSoundId = nil

	FullScreenFadeOutAnimation( "RoomTransitionIn_TimeWarp_Slow" )
	waitUnmodified( 1.1 )

	Destroy({ Id = illustrationId })
end

-- Helpers
function SetupFlashbackPlayerUnitMel( source, args )
	ToggleCombatControl( {"Rush"} , true )
	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = "WeaponBlink", UnloadPackages = false })
	MapState.EquippedWeapons.WeaponBlink = nil
	EquipWeapon({ Name = "FlashbackMelBlink", DestinationId = CurrentRun.Hero.ObjectId, LoadPackages = true })
	MapState.EquippedWeapons.FlashbackMelBlink = true
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 575841 })
end

function SetupFlashbackPlayerUnitHades( source, args )
	CurrentRun.Hero.SubtitleColor = { 242, 79, 66, 255 }
	CurrentRun.Hero.EmoteOffsetY = -350
	CurrentRun.Hero.EmoteOffsetX = 80

	LoadVoiceBanks({ "Hades" })
	ToggleCombatControl( {"Rush"} , true )

	SetScale({ Id = CurrentRun.Hero.ObjectId, Fraction = 1.3 })
	SetAnimation({ Name = "HadesFlashback_Idle", DestinationId = CurrentRun.Hero.ObjectId })
	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = "WeaponBlink", UnloadPackages = false })
	MapState.EquippedWeapons.WeaponBlink = nil
	EquipWeapon({ Name = "FlashbackHadesBlink", DestinationId = CurrentRun.Hero.ObjectId, LoadPackages = not GameData.MissingPackages["FlashbackHadesBlink"] })
	MapState.EquippedWeapons.FlashbackHadesBlink = true
end

function SetupFlashbackPlayerUnitChronos( source, args )
	CurrentRun.Hero.SubtitleColor = Color.ChronosVoice
	CurrentRun.Hero.NarrativeFadeInColor = Color.ChronosVoice
	CurrentRun.Hero.EmoteOffsetY = -350
	CurrentRun.Hero.EmoteOffsetX = 80

	LoadVoiceBanks({ "Chronos" })

	-- Temporarily dress Mel up as Chronos rather than using a separate unit, since she has to change back in the same map.
	-- See MelBackToBedroomPresentation for the inverse operation.

	--SetThingProperty({ Property = "ExtentScale", Value = 1.2, DestinationId = CurrentRun.Hero.ObjectId })
	SetScale({ Id = CurrentRun.Hero.ObjectId, Fraction = 1.3 })
	SetThingProperty({ Property = "GrannyModel", Value = "Chronos_Mesh", DestinationId = CurrentRun.Hero.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "NPC_Chronos_Enlightened_Hover", DestinationId = CurrentRun.Hero.ObjectId })
	SetThingProperty({ Property = "Tallness", Value = 400, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StartGraphic", Value = "NPC_Chronos_Enlightened_Move_Start", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "NPC_Chronos_Enlightened_Move", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StopGraphic", Value = "NPC_Chronos_Enlightened_Move_Stop", DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "NPC_Chronos_Enlightened_Hover", DestinationId = CurrentRun.Hero.ObjectId })
	CurrentRun.Hero.AnimOffsetZ = -40
	SetConfigOption({ Name = "SubtitleASubString", Value = "Chronos" })

end

function SetupFlashbackMusic( source, args )

	StopSecretMusic()
	StopMusicianMusic( nil, { Duration = 0.2 } )
	wait(0.4)

	SecretMusicPlayer( args.SecretMusic )
	SetSoundCueValue({ Names = { "Section", }, Id = AudioState.SecretMusicId, Value = 0 })
	SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums", "Bass" }, Id = AudioState.SecretMusicId, Value = 0 })

end

function StopHadesFlashbackSpeech( source, args )
	StopSpeech({ Id = 816999 })
end

function NightmareScreenEffects( source, args )

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY })
	local vignetteAName = "NightmareVignetteLoop"
	SessionMapState.NightmareVignetteAnimationName = vignetteAName
	local vignetteA = CreateAnimation({ Name = vignetteAName, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	DrawScreenRelative({ Id = vignetteA })
	
	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.1 })
	AdjustRadialBlurStrength({ Fraction = 1.0, Duration = 0.1 })

	while SessionState.InFlashback and (CurrentHubRoom == nil or CurrentHubRoom.Name ~= "Flashback_Hub_Main") do
		AdjustColorGrading({ Name = "NightmareLC", Duration = 3 })
		wait( 3, "NightmareScreenEffects" )
		AdjustColorGrading({ Name = "NightmareHalf", Duration = 3 })
		wait( 3, "NightmareScreenEffects" )
	end
end

function FlashbackExpandClamps()

	CheckConversations()
	SetCameraClamp({ Ids = { 422050, 422043, 422045, 422046, 422047 }, SoftClamp = 0.75 })

end

function ConcludeFlashback()

	SessionState.InFlashback = false

	AddInputBlock({ Name = "ConcludingNightmare" })

	StopSound({ Id = AudioState.SecretMusicId, Duration = 5 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

	CurrentRun.Hero.SubtitleColor = HeroData.SubtitleColor
	CurrentRun.Hero.LineHistoryName = nil
	CurrentRun.Hero.AttachedAnimationName = HeroData.AttachedAnimationName
	CurrentRun.Hero.Portrait = HeroData.Portrait

	AdjustRadialBlurDistance({ Fraction = 3.0, Duration = 2 })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = 2 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweep" })

	wait(1.5)

	FullScreenFadeOutAnimation()
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	DestroyCameraWalls({ })
	ShowCombatUI( "Flashback" )

	-- this ensures presentation in StartDeathLoop() occurs
	CurrentHubRoom = nil

	RemoveInputBlock({ Name = "ConcludingNightmare" })
	RequestSave({ StartNextMap = GameData.HubMapName, DevSaveName = CreateDevSaveName( CurrentRun, { StartNextMap = GameData.HubMapName, PostDeath = true, } ) })
	UnloadPackages({ Names = PortraitPackages })
	LoadMap({ Name = "Hub_Main", ResetBinks = false })
	wait(0.1)
	-- Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 310036, OffsetY = 150 })
	wait(0.5)
	ResumeMusic()
	thread( PlayVoiceLines, HeroVoiceLines.FlashbackEndedVoiceLines )
end