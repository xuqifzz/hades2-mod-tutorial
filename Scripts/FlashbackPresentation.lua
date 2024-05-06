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
	AdjustColorGrading({ Name = "Sepia", Duration = 0.0 })

	wait(3.0)

	-- Hypnos can snore now...
	SetAnimation({ Name = "Hypnos_Sleep_Idle", DestinationId = hypnosId })

	FadeIn({ Duration = 2.0 })

	-- thread( NightmareScreenEffects )

	SetupFlashbackMusic( source, args )
	SecretMusicPlayer( "/Music/MusicExploration3_MC", { ParamNames = { "Keys", "Drums", } } )
	thread( DisplayInfoBanner, nil, { Text = args.NightmareMessage, SubtitleText = args.NightmareMessageSubtitle, Delay = 0.5, Layer = "Overlay" } )
	CreateCameraWalls({ })

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

	if GameState.TextLinesRecord.HecateHideAndSeek01 then

		-- after first hecate interaction

		-- extend clamps to level 3
		SetCameraClamp({ Ids = { 583653, 583654, 583655, 583656, 585236, 567074, }, SoftClamp = 0.75 })

		-- remove hiders
		SetAlpha({ Ids = { 585267, 585266, 585265, 585262, 585263, 585264, 585276, 585275 }, Fraction = 0.0, Duration = 0.35 })

		-- destroy impassability near Tent
		Destroy({ Ids = { 585282, 585281 } })

		AdjustZoom({ Fraction = 1.03, LerpTime = 5.0 })

	else
		-- after using InspectPoint

		SecretMusicPlayer( EnemyData.NPC_Artemis_01.ThemeMusic, { ParamNames = { "Keys", } } )

		-- remove hiders
		SetAlpha({ Ids = { 585241, 585242, 585243, 585240, 585239, }, Fraction = 0.0, Duration = 0.35 })

		-- extend clamps to level 2
		SetCameraClamp({ Ids = { 585238, 585237, 585236, 424948, 567074, 566565, 583653 }, SoftClamp = 0.75 })

		-- destroy impassability near Odysseus
		Destroy({ Ids = { 585277, 585279, 585280, 585293, 585306, 585307, 585308 } })

		AdjustZoom({ Fraction = 1.06, LerpTime = 5.0 })

		thread( HecateHideAndSeekHint )

	end

end

function HecateHideAndSeekExit( source, args )


	args = args or {}
	UseableOff({ Id = source.ObjectId })
	wait( args.WaitTime or 0 )

	SetAnimation({ Name = "HecateHubGreet", DestinationId = source.ObjectId })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic" })
	CreateAnimation({ Name = "DeathSequenceFxBack", DestinationId = source.ObjectId, Group = "Combat_UI_World_Add" })
	CreateAnimation({ Name = "DeathSequenceFxFront", DestinationId = source.ObjectId, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })

	wait( 1.2, RoomThreadName )

	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.35 })

	wait( 2.5, RoomThreadName )

	Teleport({ Id = source.ObjectId, DestinationId = args.TeleportId })
	SetAnimation({ Name = "Hecate_Hub_Hide_Start", DestinationId = source.ObjectId })
	SetAlpha({ Id = source.ObjectId, Fraction = 1.0, Duration = 0 })

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
	CreateAnimation({ Name = "DeathSequenceFxBack", DestinationId = source.ObjectId, Group = "Combat_UI_World_Add" })
	CreateAnimation({ Name = "DeathSequenceFxFront", DestinationId = source.ObjectId, Group = "Combat_Menu_TraitTray_Overlay_Additive" })

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

	HideCombatUI( "Flashback" )

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
	thread( DisplayInfoBanner, nil, { Text = args.NightmareMessage, SubtitleText = args.NightmareMessageSubtitle, Delay = 0.5, Layer = "Overlay" } )
	CreateCameraWalls({ })
	RemoveInputBlock({ Name = "SetupFlashback02" })

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
	},
	thread( PlayVoiceLines, endVoiceLines )

	SetupFlashbackMusic( source, args )
	thread( DisplayInfoBanner, nil, { Text = args.NightmareMessage, SubtitleText = args.NightmareMessageSubtitle, Delay = 0.5, Layer = "Overlay" } )
	CreateCameraWalls({ })

	CurrentRun.BlockDeathAreaTransitions = false
	CurrentRun.CurrentRoom.BlockCameraReattach = false

end

-- Helpers
function SetupFlashbackPlayerUnitMel( source, args )
	DisableWeapons()
	ToggleCombatControl( {"Rush"} , true )
	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = "WeaponBlink", UnloadPackages = false })
	EquipWeapon({ Name = "FlashbackMelBlink", DestinationId = CurrentRun.Hero.ObjectId, LoadPackages = true })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 575841 })
end

function SetupFlashbackPlayerUnitHades( source, args )
	CurrentRun.Hero.SubtitleColor = { 242, 79, 66, 255 }
	DisableWeapons()
	LoadVoiceBanks({ "Hades" })
	ToggleCombatControl( {"Rush"} , true )

	SetScale({ Id = CurrentRun.Hero.ObjectId, Fraction = 1.3 })
	SetAnimation({ Name = "HadesFlashback_Idle", DestinationId = CurrentRun.Hero.ObjectId })
	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = "WeaponBlink", UnloadPackages = false })
	EquipWeapon({ Name = "FlashbackHadesBlink", DestinationId = CurrentRun.Hero.ObjectId, LoadPackages = not GameData.MissingPackages["FlashbackHadesBlink"] })
	-- SwapSound({ Name = "/VO/MelinoeEmotes/EmoteEvading", DestinationName = "/SFX/Enemy Sounds/Hades/EmoteEvading" })
	-- SwapSound({ Name = "/SFX/Player Sounds/MelDash", DestinationName = "/SFX/Enemy Sounds/Hades/HadesDash" })
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

function NightmareScreenEffects( source, args )

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })
	local vignetteA = CreateAnimation({ Name = "CauldronCastVignetteLoop", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = vignetteA })
	local vignetteB = CreateAnimation({ Name = "NightmareEdgeFxSpawner", DestinationId = CurrentRun.Hero.ObjectId })
	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.1 })
	AdjustRadialBlurStrength({ Fraction = 1.0, Duration = 0.1 })

	while SessionState.InFlashback and not CurrentHubRoom.Name == "Flashback_Hub_Main" do
		AdjustColorGrading({ Name = "NightmareLC", Duration = 3 })
		wait( 3, RoomThreadName )
		AdjustColorGrading({ Name = "NightmareHalf", Duration = 3 })
		wait( 3, RoomThreadName )
	end
end

function FlashbackExpandClamps()

	CheckConversations()
	SetCameraClamp({ Ids = { 422050, 422043, 422045, 422046, 422047 }, SoftClamp = 0.75 })

end

function ConcludeFlashback()

	SessionState.InFlashback = false

	StopSound({ Id = AudioState.SecretMusicId, Duration = 5 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

	CurrentRun.Hero.SubtitleColor = HeroData.SubtitleColor
	CurrentRun.Hero.AttachedAnimationName = HeroData.AttachedAnimationName
	CurrentRun.Hero.Portrait = HeroData.Portrait

	AdjustRadialBlurDistance({ Fraction = 3.0, Duration = 2 })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = 2 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweep" })

	wait(1.5)
	AddInputBlock({ Name = "ConcludingNightmare" })

	FullScreenFadeOutAnimation()
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	wait(1.5)
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	DestroyCameraWalls({ })
	ShowCombatUI( "Flashback" )

	-- this ensures presentation in StartDeathLoop() occurs
	CurrentHubRoom = nil

	RemoveInputBlock({ Name = "ConcludingNightmare" })
	RequestSave({ StartNextMap = GameData.HubMapName, DevSaveName = CreateDevSaveName( CurrentRun, { StartNextMap = GameData.HubMapName, PostDeath = true, } ) })
	LoadMap({ Name = "Hub_Main", ResetBinks = false })
	wait(0.1)
	-- Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 310036, OffsetY = 150 })
	wait(0.5)
	ResumeMusic()
	thread( PlayVoiceLines, HeroVoiceLines.FlashbackEndedVoiceLines )
end
