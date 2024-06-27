function SetupLockedGiftRack( source )
	SetAnimation({ Name = "GiftRackClosed", DestinationId = source.ObjectId })
	Destroy({ Ids = { 421315, 421316, 421317, 421319 } })
	UseableOff({ Id = source.ObjectId })
end

function EnterHubRoomPresentation( currentRun, currentRoom )
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	-- Disable immediately, could be sitting on top of impassibility
	if currentRoom.HeroEndPoint ~= nil then
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
	end
	wait(0.1)

	FadeIn({ Duration = 0.3 })
	if CurrentRun.StoredHeroLocation ~= nil then
		Teleport({ Id = CurrentRun.Hero.ObjectId, OffsetX = CurrentRun.StoredHeroLocation.X, OffsetY = CurrentRun.StoredHeroLocation.Y })
		CurrentRun.StoredHeroLocation = nil
		SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = CurrentRun.StoredHeroAngle, CompleteAngle = true })
		CurrentRun.StoredHeroAngle = nil
	else
		if currentRoom.HeroEndPoint ~= nil then
			thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, Invulnerable = true } )
		end
		if currentRoom.CameraEndPoint ~= nil then
			PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomIntroSequenceDuration })
		end
	end

	wait(0.02)

	thread( PlayVoiceLines, currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	wait( roomIntroSequenceDuration )
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })

end

function LeaveHubRoomPresentation( currentRun, exitDoor )

	local exitDoorId = exitDoor.ObjectId

	AddInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( {"AdvancedTooltip" }, false, "LeaveHubRoom" )

	local dashedIntoDoor = false
	if HasEffect({ Id = CurrentRun.Hero.ObjectId, EffectName = "RushWeaponDisableCancelable" }) then
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "RushWeaponDisableCancelable" })
		dashedIntoDoor = true
	end

	HideCombatUI( "LeaveHubRoomPresentation" )
	
	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if exitDoor.ExitDoorOpenAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = exitDoor.ExitDoorOpenAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
		wait( 0.5 )
	end


	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = currentRun.Hero.ObjectId, DestinationIds = heroExitIds, Distance = 600 })
	if heroExitPointId > 0 then
		SetCameraClamp({ SoftClampOnly = true, SoftClamp = 0.001 })
		PanCamera({ Id = heroExitPointId, Duration = 10.0, FromCurrentLocation = true })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })

		local args = {}
		args.SuccessDistance = 30
		local exitPath = exitDoor.ExitPath or {}
		if exitDoor ~= nil and exitDoor.ExitThroughCenter then
			table.insert( exitPath, exitDoor.ObjectId )
		end
		table.insert( exitPath, heroExitPointId )
		thread( MoveHeroAlongPath, exitPath, args )
	else
		if exitDoorId ~= nil then
			AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = exitDoorId })
		end
		SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 1.0 })
	end

	LeaveRoomAudio( currentRun, exitDoor )

	if exitDoor ~= nil and exitDoor.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = exitDoor.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.3 })	
	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelOutURSA" })
	FadeOut({ Color = Color.Black, Duration = 0.24 })
	wait( 0.25 )

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( {"AdvancedTooltip" }, true, "LeaveHubRoom" )

end

function StartDeathLoopPresentation( currentRun )

	AddInputBlock({ Name = "DeathWalkBlock" })
	ZeroMouseTether("DeathPresentation")
	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })

	-- sequence speeds
	local firstPlay = false
	if GetCompletedRuns() < 1 then
		firstPlay = true
	end

	-- unit
	local initialSpeed = GetUnitDataValue({ Id = currentRun.Hero.ObjectId, Property = "Speed"})
	local fadeLightIds = ({ 566965, 566818, 566896 })
	SetUnitProperty({ Property = "Speed", Value = 0, DestinationId = currentRun.Hero.ObjectId })
	SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 315 })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = false, DestinationId = currentRun.Hero.ObjectId })
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 0 })

	SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "MelinoeDeathReEnter" })
	AudioState.RespawnSoundId = PlaySound({ Name = "/SFX/Player Sounds/PlayerRespawnHoverLoop", Id = CurrentRun.Hero.ObjectId })

	StartRoomAmbience( currentRun, CurrentHubRoom )
	TentEnterPresentation()
	local dimmerIds = GetIds({ Name = "TentIntroDimmer_01" })
	SetAlpha({ Ids = dimmerIds, Fraction = 1.0 })

	AdjustColorGrading({ Name = "Respawn", Duration = 0 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0 })
	SetAlpha({ Ids = fadeLightIds, Fraction = 0 })


	local cameraStartId = 566838
	LockCamera({ Id = 566838, OffsetY = -320, Duration = 0.01 })
	wait(0.01)
	if firstPlay then
		PanCamera({ Id = 566838, Duration = 14.0, OffsetY = -60, EaseIn = 0, Retarget = true })
	else
		PanCamera({ Id = 566838, Duration = 12.0, OffsetY = -60, EaseIn = 0, Retarget = true })
	end
	AdjustZoom({ Fraction = CurrentHubRoom.ZoomFraction or 1.23 })
	local cameraClamps = CurrentHubRoom.CameraClamps or GetDefaultClampIds()
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is non-sensical" })

	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0 })

	wait( 0.01 )
	local tentZoom = 1.0
	if firstPlay then
		--PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
		--AdjustZoom({ Fraction = CurrentHubRoom.ZoomFraction or 1.0, LerpTime = 9.0 })
		--AdjustZoom({ Fraction = tentZoom, LerpTime = 9.0 })
		--FocusCamera({ Fraction = tentZoom, Duration = 9.0 })
	else
		--PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
		--AdjustZoom({ Fraction = tentZoom, LerpTime = 6.0 })
		--FocusCamera({ Fraction = tentZoom, Duration = 6.0 })
	end


	wait(0.3)
	
	FadeIn({ Duration = 0.5 })
	--SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "Blank" })
	local healTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRun.Hero.ObjectId })
	CreateAnimation({ Name = "RespawnCircle", DestinationId = healTarget, Group = "FX_Terrain_Add" })

	local blackScreenId = SpawnObstacle({ Name = "rectangle01", DestinationId = currentRun.Hero.ObjectId, Group = "Combat_UI_World" })
	SetScale({ Id = blackScreenId, Fraction = 10 })
	SetColor({ Id = blackScreenId, Color = Color.Black })
	SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0 })
	SetAlpha({ Id = blackScreenId, Fraction = 0.0, Duration = 2.0 })

	local respawnVignette = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRun.Hero.ObjectId, Group = "FX_Terrain", })
	CreateAnimation({ Name = "RespawnVignette", DestinationId = respawnVignette, Scale = 2.0, })
	CreateAnimation({ Name = "RespawnVignette", DestinationId = respawnVignette, Scale = 1.8, })
	CreateAnimation({ Name = "RespawnVignette", DestinationId = respawnVignette, Scale = 1.6, })

	local respawnHadesSymbolFx = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRun.Hero.ObjectId, Group = "Combat_Menu_TraitTray_Additive", })
	CreateAnimation({ Name = "RespawnHadesSymbol", DestinationId = respawnHadesSymbolFx })
	CreateAnimation({ Name = "MelRespawnHeal", DestinationId = healTarget, Group = "FX_Standing_Add" })
	

	-- audio
	local prevRoom = GetPreviousRoom( currentRun )
	if prevRoom == nil or not prevRoom.SkipEnteredDeathAreaVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines.EnteredDeathAreaVoiceLines )
	end

	local heroDestination = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRun.Hero.ObjectId, OffsetX = 400, OffsetY = -260 })
	
	AdjustColorGrading({ Name = "Off", Duration = 4 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 2 })

	if firstPlay then
		wait(1.1)
	else
		wait(1.1)
	end

	SetAlpha({ Id = respawnHadesSymbolFx, Fraction = 0.0, Duration = 4.0, EaseIn = 0, EaseOut = 1 })
	SetScale({ Id = respawnHadesSymbolFx, Fraction = 0.35, Duration = 4.0, EaseIn = 0, EaseOut = 1 })
	Move({ Id = respawnHadesSymbolFx, Distance = 15, Angle = 180, Duration = 4.0, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Ids = fadeLightIds, Fraction = 1, Duration = 5 })

	--[[
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 0.25 })
	ShakeScreen({ Distance = 6, Speed = 500, Duration = 0.5 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })
	CreateAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "HecatePolymorphDissipate", Scale = 1.2, OffsetY = -200 })
	]]
	--SetUnitProperty({ Property = "Speed", Value = 95, DestinationId = currentRun.Hero.ObjectId })

	--Move({ Id = currentRun.Hero.ObjectId, DestinationId = heroDestination, SuccessDistance = 32 })

	--Stop({ Id = currentRun.Hero.ObjectId })

	local wakeUpTime = 1.15
	if firstPlay then
		wait(7.74 - wakeUpTime )
		--wait(3.75)
	else
		-- wait(1.34)
	end

	ToggleCombatControl( { "Rush" }, true, "DeathLoopStart" )

	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {1, 1, 1, 1}, Duration = 0.0 })
	StopAnimation({ Name = "MelRespawnHeal", DestinationId = healTarget })

	if firstPlay then
		SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "MelinoeDeathReEnterHeadUp" })
		wait( wakeUpTime )
		-- thread( MelReadyFlash )
	else
		local notifyName = "MelAwake"
		SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "MelinoeDeathReEnterHeadUp" })
		thread( MelReadyFlash )
		NotifyOnControlPressed({ Names = { "Rush" }, Notify = notifyName, Timeout = 1.8 + 1.34 })
		waitUntil( notifyName )
		local didSkip = not _eventTimeoutRecord[notifyName]
		if didSkip then
			FireWeaponFromUnit({ Weapon = "WeaponBlink", Id = CurrentRun.Hero.ObjectId })
		end
	end

	thread( MelFootDrop )

	SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "MelinoeDeathReEnterToIdle" })
	PlaySound({ Name = "/SFX/Player Sounds/PlayerRespawnLoopEnd", Id = CurrentRun.Hero.ObjectId })
	StopSound({ Id = AudioState.RespawnSoundId, Duration = 0.5 })
	AudioState.RespawnSoundId = nil

	DebugPrint({ Text = "Input Restored" })
	RemoveInputBlock({ Name = "DeathWalkBlock" })
	--SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "MelinoeIdle" })

	SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = currentRun.Hero.ObjectId })
	
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })

	SetAlpha({ Ids = dimmerIds, Fraction = 0, Duration = 1.0 })
	SetAlpha({ Id = respawnVignette, Fraction = 0.0, Duration = 0.6, })
	StopAnimation({ Name = "MelRespawnHeal", DestinationId = healTarget })
	Destroy({ Id = healTarget })
	if CurrentHubRoom.CameraWalls then
		CreateCameraWalls({ })
	end

	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })
	UnzeroMouseTether( "DeathPresentation" )

end

function MelReadyFlash( )
	waitUnmodified( 0.12 )
	--Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.02, MinFraction = 0.6, MaxFraction = 0.6, Color = Color.Turquoise, Duration = 0.1, ExpireAfterCycle = true })
	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {0, 1, 0.6, 0.5}, Duration = 0.06, EaseIn = 0, EaseOut = 1 })
	waitUnmodified( 0.08 )
	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {1, 1, 1, 1}, Duration = 0.15, EaseIn = 0, EaseOut = 0.5 })
end

function MelFootDrop( )
	waitUnmodified( 0.05 )
	ShakeScreen({ Angle = 90, Distance = 3, Speed = 50, FalloffSpeed = 500, Duration = 0.27 })
	waitUnmodified( 0.09 )
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.19 }, } )
end

GlobalVoiceLines.BathHouseResponseVoiceLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "DoraBathHouse01" },
			},
		},

		{ Cue = "/VO/Melinoe_0423", Text = "Oh." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "DoraBathHouse02" },
			},
		},

		{ Cue = "/VO/Dora_0076", Text = "Maybe, who knows?" },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HecateBathHouse01" },
			},
		},

		{ Cue = "/VO/Melinoe_0577", Text = "{#Emph}Mm!" },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HecateBathHouse02" },
			},
		},

		{ Cue = "/VO/Melinoe_0677", Text = "Deal!" },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		ObjectType = "NPC_Nemesis_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "NemesisBathHouse01" },
			},
		},
		{ Cue = "/VO/Nemesis_0216", Text = "Like {#Emph}you {#Prev}know." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "NemesisBathHouse02" },
			},
		},
		{ Cue = "/VO/Melinoe_3114", Text = "Maybe just a {#Emph}little {#Prev}used to it, then." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosBathHouse01" },
			},
		},
		{ Cue = "/VO/Melinoe_0926", Text = "I'm sorry..." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosBathHouse02" },
			},
		},
		{ Cue = "/VO/Melinoe_0930", Text = "Nor I!" },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ErisBathHouse01" },
			},
		},
		{ Cue = "/VO/Melinoe_3478", Text = "It's perfect..." },
	},

}
GlobalVoiceLines.EnteredBathVoiceLines =
{
	{
		SkipAnim = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Melinoe_1965", Text = "{#Emph}Whew..." },
	},
	{
		SkipAnim = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Hecate_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "HecateBathHouse01", "HecateBathHouse02" },
			}
		},
		{ Cue = "/VO/Hecate_0245", Text = "Let us regain our strength..." },
		{ Cue = "/VO/Hecate_0246", Text = "These waters always seem to do the trick...", PlayFirst = true, },
		{ Cue = "/VO/Hecate_0247", Text = "Would that this were all we had to do..." },
	},
	{
		SkipAnim = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Odysseus_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "OdysseusBathHouse01", "OdysseusBathHouse02" },
			}
		},
		{ Cue = "/VO/Odysseus_0052", Text = "{#Emph}Whew...", PlayFirst = true },
		{ Cue = "/VO/Odysseus_0053", Text = "{#Emph}Ah... {#Prev}practically feel it in my bones..." },
		{ Cue = "/VO/Odysseus_0054", Text = "{#Emph}Mm{#Prev}, almost like I'm alive again, {#Emph}haha..." },
	},
	{
		SkipAnim = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Nemesis_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "NemesisBathHouse01", "NemesisBathHouse02" },
			}
		},
		{ Cue = "/VO/Nemesis_0205", Text = "Not too hot, not too cold...", PlayFirst = true },
		{ Cue = "/VO/Nemesis_0206", Text = "What are {#Emph}you {#Prev}looking at?" },
		{ Cue = "/VO/Nemesis_0207", Text = "Really shouldn't get too comfortable in here...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Nemesis_0205" }
				},
			},
		},
	},

	{
		SkipAnim = true,
		PreLineWait = 0.35,
		BreakIfPlayed = true,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Moros_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "MorosBathHouse01", "MorosBathHouse02" },
			}
		},
		{ Cue = "/VO/Moros_0106", Text = "{#Emph}Whew!", PlayFirst = true },
		{ Cue = "/VO/Moros_0107", Text = "All my fears evaporate again..." },
		{ Cue = "/VO/Moros_0108", Text = "I could stay here forever..." },		
	},

	{
		SkipAnim = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Eris_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "ErisBathHouse01", "ErisBathHouse02" },
			}
		},
		{ Cue = "/VO/Eris_0177", Text = "{#Emph}Hot hot hot hot hot...!" },
		{ Cue = "/VO/Eris_0178", Text = "It's good to be back..." },
		{ Cue = "/VO/Eris_0179", Text = "{#Emph}Aw, yeah...", PlayFirst = true },
	},

}

function BathHouseStartPresentation( source, args, line )
	args = args or {}

	FadeOut({ Color = Color.Black, Duration = 0.5 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	EstablishConversationStartingPoint( source )

	waitUnmodified( 0.5 )
	
	ClearCameraClamp({ LerpTime = 0 })
	Teleport({ Id = source.ObjectId, DestinationId = 558312 })
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 558314, })
	AngleTowardTarget({ Ids = { source.ObjectId, CurrentRun.Hero.ObjectId }, DestinationId = 589588 })

	LockCamera({ Id = 589588 })

	waitUnmodified( 1.5 )
	FadeIn({ Duration = 2.0 })

	waitUnmodified( 1.0 )
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
	if source.PreBathAnimationName ~= nil then
		SetAnimation({ Name = source.PreBathAnimationName,DestinationId = source.ObjectId })
	end

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })
	PanCamera({ Id = 589586, Duration = 7, EaseIn = 0.5, EaseOut = 2, Retarget = true })

	waitUnmodified( 1.5 )

	-- @ update
	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract" })
	waitUnmodified( 0.4 )
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutterInScene" })
	waitUnmodified( 0.4 )
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutterInScene" })
	waitUnmodified( 1.0 )
	PlaySound({ Name = "/Leftovers/World Sounds/ClickSplashSlosh" })
	waitUnmodified( 0.2 )
	PlaySound({ Name = "/Leftovers/World Sounds/ClickSplashSlosh" })
	waitUnmodified( 1.0 )
	PlaySound({ Name = "/Leftovers/World Sounds/ClickSplashSlosh" })
	waitUnmodified( 0.3 )
	PlaySound({ Name = "/Leftovers/World Sounds/ClickSplashSlosh" })
	waitUnmodified( 0.6 )
	PlayVoiceLines( GlobalVoiceLines.EnteredBathVoiceLines )

	AudioState.BathHouseSoundId = PlaySound({ Name = "/Leftovers/Object Ambiences/RiverWaterAmbience2" })
	SetVolume({ Id = AudioState.BathHouseSoundId, Value = 0, Duration = 0 })
	SetVolume({ Id = AudioState.BathHouseSoundId, Value = 1, Duration = 1.0 })

	waitUnmodified( line.EndWaitTime or 1.0 )
end

function BathHouseQuipPresentation( source, args, line )
	args = args or {}
	thread( PlayVoiceLines, GlobalVoiceLines.BathHouseResponseVoiceLines )

	-- local cameraClamps = CurrentHubRoom.CameraClamps or GetDefaultClampIds()
	-- SetCameraClamp({ Ids = cameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })

	StopSound({ Id = AudioState.BathHouseSoundId, Duration = 6.0 })
	AudioState.BathHouseSoundId = nil

end

function BathHouseEndPresentation( source, args )
	args = args or {}

	FadeOut({ Color = Color.Black, Duration = 0.6 })
	waitUnmodified( 0.6 )

	TeleportToConversationStartingPoint( source, args )

	waitUnmodified( 6.5 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	FadeIn({ Duration = 1.8 })
	waitUnmodified( 2.0 )
end

function FishingPierStartPresentation( source, args )
	args = args or {}

	LoadVoiceBanks({ Name = "MelinoeField" })
	FadeOut({ Color = Color.Black, Duration = 0.5 })
	EstablishConversationStartingPoint( source )
	waitUnmodified( 0.5 )

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 566617 })
	Teleport({ Id = source.ObjectId, DestinationId = 566616 })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 558317 })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = 558317 })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	FadeIn({ Duration = 2.0 })
	waitUnmodified( 2.0 )
end

function FishingPierEndPresentation( source, args )
	args = args or {}

	FadeOut({ Color = Color.Black, Duration = 0.75 })
	waitUnmodified( 0.75 )

	local timeTicks = 16
	GardenTimeTick( { Ticks = timeTicks, UpdatePlotPresentation = true, PanDuration = 0.0, SkipCameraPan = true, SkipSound = true, TickInterval = 0.0 } )
	CookTimeTick( { Ticks = timeTicks, UpdatePresentation = true, TickInterval = 0.0, } )
	MailboxTimeTick( { Ticks = timeTicks, UpdatePresentation = true, TickInterval = 0.0, } )

	TeleportToConversationStartingPoint( source, args )

	waitUnmodified( 0.5 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	FadeIn({ Duration = 2.0 })
	waitUnmodified( 2.5 )
	UnloadVoiceBanks({ Name = "MelinoeField" })
end

function TavernaStartPresentation( source, args )
	args = args or {}

	FadeOut({ Color = Color.Black, Duration = 0.5 })
	EstablishConversationStartingPoint( source )
	waitUnmodified( 0.5 )

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 589539 })
	Teleport({ Id = source.ObjectId, DestinationId = 589538 })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 586579 })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = 586579 })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	FadeIn({ Duration = 2.0 })
	waitUnmodified( 2.0 )
end

function TavernaEndPresentation( source, args )
	args = args or {}

	FadeOut({ Color = Color.Black, Duration = 0.5 })
	waitUnmodified( 0.5 )

	TeleportToConversationStartingPoint( source, args )

	waitUnmodified( 10.0 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	FadeIn({ Duration = 2.0 })
	waitUnmodified( 2.0 )
end

function EstablishConversationStartingPoint( source, args )
	MapState.ConversationStartPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = source.ObjectId })
	MapState.HeroConversationStartPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId })
end

function TeleportToConversationStartingPoint( source, args )
	args = args or {}

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.TeleportHeroToId or MapState.HeroConversationStartPointId })
	Teleport({ Id = source.ObjectId, DestinationId = args.TeleportToId or MapState.ConversationStartPointId })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.AngleHeroTowardTargetId or MapState.ConversationStartPointId })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = args.AngleTowardTargetId or MapState.HeroConversationStartPointId })

	Destroy({ Id = MapState.HeroConversationStartPointId })
	Destroy({ Id = MapState.ConversationStartPointId })
	MapState.HeroConversationStartPointId = nil
	MapState.ConversationStartPointId = nil
end

function OpenShrineScreenPrePresentation( menuObjectId, soundCue )
	PlaySound({ Name = soundCue or "/SFX/Menu Sounds/HadesMainMenuWhoosh", Id = menuObjectId })
	ZeroMouseTether("MetaupgradeMenuPresentation")
	AdjustColorGrading({ Name = "Team03", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "Default", Duration = 0.3 })
	PlayInteractAnimation( menuObjectId )
	wait( 0.12 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.30 })
	AdjustColorGrading({ Name = "Off", Duration = 0.30 })
end

function OpenShrineScreenPostPresentation( menuObjectId )
	UnzeroMouseTether("MetaupgradeMenuPresentation")
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
end

function LockedSurfaceRunPresentation( usee, args )
	args = args or {}
	if CheckCooldown( "LockedSurfaceDoorUsed", 2.0 ) then
		thread( RepulseFromObject, usee, { Text = "Hint_SurfaceRunDoorLocked", OffsetZ = -100, OffsetX = -0, ShadowScaleX = 1.3, Scale = 2.0 })
		PlaySound({ Name = "/Leftovers/SFX/PlayerKilled_Small", Id = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/SFX/WrathOver2" })
	end
	thread( PlayVoiceLines, args.VoiceLines or GlobalVoiceLines.WardedDoorVoiceLines, true )

end

function SetFixedDashPresentationValues()
	SessionState.BlinkChargeDuration = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponBlink", Property = "ChargeTime" })
	local baseBlinkSpeed = GetBaseDataValue({ Type = "Weapon", Name = "WeaponBlink", Property = "ChargeTime" })
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeTime", Value = baseBlinkSpeed })
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeTimeRemaining", Value = baseBlinkSpeed, ValueChangeType = "Absolute", DataValue = false })
end

function EndFixedDashPresentationValues()
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeTime", Value = SessionState.BlinkChargeDuration })
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeTimeRemaining", Value = SessionState.BlinkChargeDuration, ValueChangeType = "Absolute", DataValue = false })
	SessionState.BlinkChargeDuration = nil
end

function StartNewRunPresentation( runDoor, args )
	LockCamera({ Id = runDoor.ObjectId, Duration = 1.3, Retarget = true })
	SetAngle({ Id = CurrentRun.Hero.ObjectId, Angle = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.DashTarget or runDoor.ObjectId }), CompleteAngle = true })
	if MapState.FamiliarUnit ~= nil then
		SetAnimation({ DestinationId = MapState.FamiliarUnit.ObjectId, Name = MapState.FamiliarUnit.StartNewRunAnimation })
	end
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
	SetFixedDashPresentationValues()
	FireWeaponFromUnit({ Weapon = "WeaponBlink", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines[args.GlobalVoiceLines] or GlobalVoiceLines.StartNewRunVoiceLines )
	wait(0.1)
	FadeOut({ Duration = 0.3, Color = Color.Black })
	EndMusic( AudioState.MusicId, AudioState.MusicName, 0.5 )
	EndAmbience( 0.5 )
	wait(0.3)
	EndFixedDashPresentationValues()
end

function PreRunOverlook()
	if not MapState.InOverlook then
		MapState.InOverlook = true

		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 0.5 })
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "Keys" }, Value = 0.0, Duration = 3.0 })
		SetVolume({ Id = AudioState.MusicId, Value = 0.7, Duration = 1.5 })

		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow", Delay = 1.5 })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")
		ToggleCombatControl( CombatControlsDefaults, false, "Overlook" )

		wait( 0.6, "OverlookThread" )
		if MapState.InOverlook then
			PanCamera({ Id = 420906, Duration = 12, EaseOut = 3, OffsetX = -20, OffsetY = -20, Retarget = true })
		end

		thread( SendCritters, { CritterName = "SingleBat", MinCount = 30, MaxCount = 70, StartX = -1150, StartY = 800, MinAngle = 15, MaxAngle = 85, MinSpeed = 300, MaxSpeed = 1000, MinInterval = 0.1, MaxInterval = 0.3, } )

		wait( 8.2, "OverlookThread" )
		ShowOverlookText()

	end
end

function ShowOverlookText()
	ScreenAnchors.OverlookText = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_Overlay" })
	CreateTextBox({ Id = ScreenAnchors.OverlookText, Text = "OverlookText", OffsetX = -900, OffsetY = 480,
			Font = "P22UndergroundSCMedium", FontSize = 28, Justification = "Left",
			LuaKey = "TempTextData", LuaValue = { FurthestRunProgress = math.max( CurrentRun.RunDepthCache, GetHighestPrevRunRepth() ) },
			Color = { 0.698, 0.702, 0.514, 0.6 },
		})
end

function PreRunBackToRoom()
	if MapState.InOverlook then
		MapState.InOverlook = false
		UnblockCombatUI("Overlook")
		ToggleCombatControl( CombatControlsDefaults, true, "Overlook" )
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.5, FromCurrentLocation = true })
		FocusCamera({ Fraction = 1.0, Duration = 1.5, ZoomType = "Ease" })

		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 0.0, Duration = 0.5 })
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "Keys" }, Value = 1.0, Duration = 1.5 })
		SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
		thread( PlayVoiceLines, HeroVoiceLines.OverlookLeaveVoiceLines )
		ClearCameraFocusOverride()
		ShowCombatUI()
		ModifyTextBox({ Id = ScreenAnchors.OverlookText, FadeTarget = 0, FadeDuration = 0.2 })

		killTaggedThreads( "OverlookThread" )
	end
end

function TentEnterPresentation()
	if SessionMapState.InTent then
		return
	end
	SessionMapState.InTent = true
	SetAlpha({ Ids = GetIds({ Name = "MainDimmer_01" }), Fraction = 1.0, Duration = 0.3 })
	SetAlpha({ Ids = GetIds({ Name = "TentDimmer_01" }), Fraction = 0.0, Duration = 0.3 })
	SetAlpha({ Ids = GetIds({ Name = "TentIntroDimmer_01" }), Fraction = 0.0, Duration = 0.3 })
	SetAudioEffectState({ Name = "Reverb", Value = -1.0 })
	if AudioState.AmbienceId ~= nil then
		SetSoundCueValue({ Name = "Tent", Value = 1.0, Id = AudioState.AmbienceId, Duration = 0.7 })
	end
	if GameState.NextBiomeStateName ~= nil then
		local biomeStateData = BiomeStateData.BiomeStates[GameState.NextBiomeStateName]
		if biomeStateData ~= nil then
			CallFunctionName( biomeStateData.DimPresentationFunctionName, args )
		end
	end

	local dora = ActiveEnemies[566832]
	if dora ~= nil and not dora.InPartnerConversation then
		if IsGameStateEligible( CurrentRun, dora, dora.CosmeticsTeleportRequirements ) then
			-- Move Dora to Main
			Teleport({ Id = dora.ObjectId, DestinationId = dora.ActiveNarrativeTeleportId or 583650 })
			dora.DefaultCategoryIndex = 1
		end
	end
end

function TentExitPresentation( eventSource, args )
	args = args or {}
	if not args.Override and not SessionMapState.InTent then
		return
	end
	SessionMapState.InTent = false
	SetAlpha({ Ids = GetIds({ Name = "MainDimmer_01" }), Fraction = 0.0, Duration = 0.3 })
	SetAlpha({ Ids = GetIds({ Name = "TentDimmer_01" }), Fraction = 1.0, Duration = 0.3 })
	SetAudioEffectState({ Name = "Reverb", Value = CurrentHubRoom.ReverbValue })
	if AudioState.AmbienceId ~= nil then
		SetSoundCueValue({ Name = "Tent", Value = 0.0, Id = AudioState.AmbienceId, Duration = 0.7 })
	end
	if GameState.NextBiomeStateName ~= nil then
		local biomeStateData = BiomeStateData.BiomeStates[GameState.NextBiomeStateName]
		if biomeStateData ~= nil then
			CallFunctionName( biomeStateData.UnDimPresentationFunctionName, args )
		end
	end

	local dora = ActiveEnemies[566832]
	if dora ~= nil and not dora.InPartnerConversation then
		if IsGameStateEligible( CurrentRun, dora, dora.CosmeticsTeleportRequirements ) then
			-- Move Dora to Main
			Teleport({ Id = dora.ObjectId, DestinationId = dora.ActiveNarrativeTeleportId or 560665, OffsetY = 0 })
			dora.DefaultCategoryIndex = 2
		end
	end
end

function DimmerPresentation( eventSource, args )
	DebugPrintTable(args)
	if args.DimmerGroups then
		for k, groupName in pairs(args.DimmerGroups) do
			SetAlpha({ Ids = GetIds({ Name = groupName }), Fraction = args.DimmerAlpha or 0, Duration = 0.3 })
		end
	end
end

function AltarEnterPresentation( eventSource, args )
	SetAlpha({ Ids = GetIds({ Name = "Logic_AltarProximity" }), Fraction = 1.0, Duration = 0.3 })
	PlaySound({ Name = "/Leftovers/SFX/AuraOn", Id = GetIds({ Name = "Logic_AltarProximity" }), })
end

function AltarExitPresentation( eventSource, args )
	SetAlpha({ Ids = GetIds({ Name = "Logic_AltarProximity" }), Fraction = 0.0, Duration = 0.5 })
end


function PostBossFirstFloorPresentation(eventSource, args)
	args = args or {}
	SetAlpha({ Ids = GetIds({ Name = "TopDimmer_01" }), Fraction = 0.0, Duration = 0.3 })
	SetAlpha({ Ids = GetIds({ Name = "BottomDimmer_01" }), Fraction = 1.0, Duration = 0.3 })
end
function PostBossSecondFloorPresentation(eventSource, args)
	args = args or {}
	SetAlpha({ Ids = GetIds({ Name = "TopDimmer_01" }), Fraction = 1.0, Duration = 0.3 })
	SetAlpha({ Ids = GetIds({ Name = "BottomDimmer_01" }), Fraction = 0.1, Duration = 0.3 })
end

function AttemptPetCerberusThread()
	-- Cerberus presently does not permit petting under any circumstance.
	thread( FailToPetCerberus )
	--thread( PetCerberus )
end

GlobalVoiceLines.FailedToPetCerberusVoiceLines =
{
	PreLineWait = 0.45,
	RandomRemaining = true,
	BreakIfPlayed = true,
	PlayOnceFromTableThisRun = true,
	UsePlayerSource = true,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/MelinoeField_1750", Text = "I'd rather keep my hand..." },
	{ Cue = "/VO/MelinoeField_1751", Text = "Won't let me." },
	{ Cue = "/VO/MelinoeField_1752", Text = "OK, OK..." },
	{ Cue = "/VO/MelinoeField_1753", Text = "Sorry, boy..." },
	{ Cue = "/VO/MelinoeField_1754", Text = "Some other time...?" },
	{ Cue = "/VO/MelinoeField_1755", Text = "Stay back, got it...", PlayFirst = true },
}
function FailToPetCerberus()

	local cerberus = ActiveEnemies[ GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Cerberus_Field_01" }) ]

	local cerberusId = GetClosestUnitOfType({ Id = heroId, DestinationName = "NPC_Cerberus_Field_01" })

	if CheckCooldown( "AttemptCerberusPet", 2.0 ) then
		thread( RepulseFromObject, cerberus, { OffsetZ = -200, OffsetX = -100, Scale = 3.0 })
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_CannotPetCerberus", 1.35, { ShadowScaleX = 1.4 } )
		PlaySound({ Name = "/Leftovers/SFX/PlayerKilled_Small", Id = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/VO/CerberusBarks", Id = cerberusId })
		PlaySound({ Name = "/VO/CerberusBarks", Id = cerberusId, Delay = 1 })
	end
	thread( PlayVoiceLines, GlobalVoiceLines.FailedToPetCerberusVoiceLines, true )

end

function PetCerberusThread()
	thread( PetCerberus )
end

function PetCerberus()

	if not CurrentRun.Hero.IsDead then
		return
	end
	local cerberusId = 370007
	local cameraPanPoint = 423060
	local zagMovePoint = 423059
	local zagMovePrePoint = 422956
	local zagAnimation = "ZagreusPetting"
	local cerberusAnimation = "Cerberus_HousePetting"
	local zagAngle = 30.0
	local waitDuration1 = 4.0
	local waitDuration2 = 6.0

	AddInputBlock({ Name = "PetCerberus" })

	ZeroMouseTether("PetCerberus")
	PanCamera({ Id = cameraPanPoint, Duration = 8.0, EaseOut = 0.5 })
	thread( PlayVoiceLines, HeroVoiceLines.PetCerberusVoiceLines )

	thread( DoRumble, { { ScreenPreWait = 0.0, Duration = 1.3,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.125, LeftTriggerFrequencyFraction = 0.0175, LeftTriggerTimeout = waitDuration1 - 1.3,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.125, RightTriggerFrequencyFraction = 0.0175, RightTriggerTimeout = waitDuration1 - 1.3}, } )

	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = zagMovePrePoint }) > 30 then
		MoveHeroToRoomPosition( { DestinationId = zagMovePrePoint, DisableCollision = true } )
		NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = zagMovePrePoint, Distance = 35, Notify = "ZagCerberusPetPreMove", Timeout = 0.8 })
		waitUntil( "ZagCerberusPetPreMove" )
		MoveHeroToRoomPosition( { DestinationId = zagMovePoint, DisableCollision = true } )
	end
	wait(0.4)
	Stop({ Id = CurrentRun.Hero.ObjectId })
	SetAngle({ Id = CurrentRun.Hero.ObjectId, Angle = zagAngle, Duration = 0 })

	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = zagAnimation })
	SetAnimation({ DestinationId = cerberusId, Name = cerberusAnimation })

	thread( DoRumble, { { ScreenPreWait = 0.0, Duration = 0.5,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.125, LeftTriggerFrequencyFraction = 0.05, LeftTriggerTimeout = 0.55,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.125, RightTriggerFrequencyFraction = 0.05, RightTriggerTimeout = 0.55}, } )

	thread( DoRumble, { { ScreenPreWait = 0.5, Duration = waitDuration1 - 0.5,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.15, LeftTriggerFrequencyFraction = 0.05, LeftTriggerTimeout = waitDuration1 - 0.45,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.15, RightTriggerFrequencyFraction = 0.05, RightTriggerTimeout = waitDuration1 - 0.45}, } )

	wait(waitDuration1)
	
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 1.4,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.3, LeftTriggerFrequencyFraction = 0.15, LeftTriggerTimeout = 1.4,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.3, RightTriggerFrequencyFraction = 0.15, RightTriggerTimeout = 1.4}, } )

	thread( DoRumble, { { ScreenPreWait = 1.4, Duration = 1.25,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.15, LeftTriggerFrequencyFraction = 0.05, LeftTriggerTimeout = 1.25,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.15, RightTriggerFrequencyFraction = 0.05, RightTriggerTimeout = 1.25}, } )

	thread( DoRumble, { { ScreenPreWait = 2.65, Duration = 0.7,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.06, LeftTriggerFrequencyFraction = 0.015, LeftTriggerTimeout = 0.7,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.06, RightTriggerFrequencyFraction = 0.015, RightTriggerTimeout = 0.7}, } )

	wait(waitDuration2)

	GameState.NumCerberusPettings = (GameState.NumCerberusPettings or 0) + 1

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0, EaseOut = 0.3 })
	UnzeroMouseTether("PetCerberus")

	RemoveInputBlock({ Name = "PetCerberus" })

	CheckAchievement( { Name = "AchCerberusPets" } )
end

function PreOpenWeaponUpgradeScreenPresentation( usee )
	if GameState.ScreensViewed.WeaponUpgradeScreen then
		PlayInteractAnimation( usee.ObjectId )
	else

		thread( MarkObjectiveComplete, "AspectsRevealPrompt" )

		AddInputBlock({ Name = "WeaponKitSpecialInteractPresentation" })

		PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweepSubtle"  })

		thread( PlayVoiceLines, HeroVoiceLines.WeaponUpgradesRevealedVoiceLines )
		PlayInteractAnimation( usee.ObjectId )

		wait( 0.5 )

		thread( PowerWordPresentationWorld )

		wait( 0.5 )

		RemoveInputBlock({ Name = "WeaponKitSpecialInteractPresentation" })

	end
end

function CloseWeaponUpgradeScreenPresentation( screen )
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeEquip" })
	wait( 0.5 )
	PlaySound({ Name = equipSound or "/Leftovers/SFX/RobeFlutter", Id = CurrentRun.Hero.ObjectId })
end

function WeaponKitSpecialInteractPresentation( user, weaponKit, args )

	AddInputBlock({ Name = "WeaponKitSpecialInteractPresentation" })
	thread( PlayVoiceLines, HeroVoiceLines.WeaponKitSpecialInteractVoiceLines )

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2LOUD"  })

	Shake({ Id = user.ObjectId, Distance = 1, Speed = 200, Duration = 3, FalloffSpeed = 3000 })
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = weaponKit.ObjectId })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeSpellFire" })

	wait( 0.6 )

	PanCamera({ Ids = weaponKit.ObjectId, Duration = 5, EaseIn = 0.05, EaseOut = 0.3 })

	AdjustColorGrading({ Name = "WeaponKitInteract", Duration = 0.2 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweep"  })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	local interactVignette = CreateAnimation({ Name = "WeaponKitInteractVignette", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = interactVignette })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColorInvert", Group = "FX_Add_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	local boonSound = PlaySound({ Name = "/SFX/Player Sounds/ZagreusWeaponChargeup" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	wait( 2.4 )

	PlaySound({ Name = "/SFX/SurvivalChallengeStart" })
	StopSound({ Id = boonSound, Duration = 0.3 })
	PlaySound({ Name = weaponKit.KitInteractSpecialUnlockSound or "/Leftovers/Menu Sounds/EmoteAscended" })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.5 }, } )

	AdjustColorGrading({ Name = "Team02", Duration = 0.02 })
	AdjustFullscreenBloom({ Name = "DeathDefiance", Duration = 0.02 })

	wait(0.2)
	if weaponKit.KitInteractSpecialUnlockSound2 ~= nil then
		PlaySound({ Name = weaponKit.KitInteractSpecialUnlockSound2 })
	end

	AdjustColorGrading({ Name = "Off", Duration = 0.8 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.8 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 1.0 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })

	if args ~= nil then
		wait( args.PickupWait )
	end

	wait( 0.6 )

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })

	RemoveInputBlock({ Name = "WeaponKitSpecialInteractPresentation" })

end

function CauldronCastingPresentation( source, args )

	wait( args.WaitTime or 0 )

	AdjustColorGrading({ Name = "HadesBloodstone", Duration = 0.2 })
	-- AdjustFullscreenBloom({ Name = "WeaponAspect", Duration = 0.2 })
	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova"  })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	CreateAnimation({ Name = "CauldronCastGlow", DestinationId = 558175 })
	CreateAnimation({ Name = "CauldronSmokeLarge", DestinationId = 558175, Group  = "FX_Standing_Top" })

	local interactVignette = CreateAnimation({ Name = "CauldronCastVignette", DestinationId = 558175 })
	DrawScreenRelative({ Id = interactVignette })

	if args.AdditionalAnimation ~= nil then
		local additionalAnimation = CreateAnimation({ Name = args.AdditionalAnimation, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
		DrawScreenRelative({ Id = additionalAnimation })
	end

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	CreateAnimation({ Name = "FullscreenAlertColorInvert", Group = "FX_Add_Top", DestinationId = 588175 })

	ShakeScreen({ Speed = 600, Distance = 9, FalloffSpeed = 2000, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.35, Duration = 0.30 }, } )

	wait( 0.3 )

	AdjustColorGrading({ Name = "Team06", Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "CauldronCastBloom", Duration = 0.2 })
	ShakeScreen({ Speed = 800, Distance = 3, FalloffSpeed = 5000, Duration = 1.3 })
	thread( DoRumble, { { ScreenPreWait = 0.1, LeftFraction = 0.17, Duration = 1.4 }, } )

	wait( 2.1 )

	AdjustColorGrading({ Name = "Off", Duration = 0.8 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.8 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertDisplacementFx }, 1.0 )

end

function DeathAreaAttackFailPresentation( weaponData, args )

	if weaponData.NoExpressiveAnim then
		return
	end
	if not args.FreshInput or not args.Controllable then
		return
	end

	if CheckCooldown( "AttackCheck", 0.2 ) then
		if CheckCountInWindow( "CannotAttack", 1.0, 4 ) and CheckCooldown( "CannotAttack", 30.0 ) then
			thread( PlayVoiceLines, HeroVoiceLines.CannotFightVoiceLines, true )
			thread( InCombatText, args.triggeredById, "NoWeaponsInTheHouse", 1.35, { ShadowScaleX = 1.25 } )
		end
	end

end

function UseLockedSystemObjectPresentation( usee, args )
	args = args or {}
	AddInputBlock({ Name = "MelUsedSystemObject" })
	UseableOff({ Id = usee.ObjectId })
	if args.LinkedIds ~= nil then
		UseableOff({ Ids = args.LinkedIds })
	end
	HideUseButton( usee.ObjectId, usee )
	if not args.BlockAngleTowardTarget then
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	end
	thread( PlayVoiceLines, HeroVoiceLines[args.VoiceLines] or HeroVoiceLines.LockedQuestLogVoiceLines, true )
	if CurrentHubRoom ~= nil and CurrentHubRoom.Name ~= "Hub_PreRun" then
		SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
		wait( 1.45 )
	else
		if not args.SkipAnim then
			local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
			SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
			wait( 0.5 )
			SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
			wait( 1.5 )
		end
	end
	RemoveInputBlock({ Name = "MelUsedSystemObject" })
	wait( 30.75, RoomThreadName )
	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
		if args.LinkedIds ~= nil then
			UseableOn({ Ids = args.LinkedIds })
		end
	end
end

GlobalVoiceLines.UsedCrossroadsPet01VoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.3,

	{ Cue = "/VO/Melinoe_3405", Text = "Hi, gang. Headmistress must have some important tasks for you.", PlayFirst = true },
	{ Cue = "/VO/Melinoe_3406", Text = "How fare my favorite hound and polecat friends?", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_3405" }
			},
		},
	},
	{ Cue = "/VO/Melinoe_3407", Text = "You two please keep an eye on things while I'm away.", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_3405" }
			},
		},
	},
	{ Cue = "/VO/Melinoe_3408", Text = "Headmistress couldn't ask for better Familiars than you two.", PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_3405" }
			},
		},
	},
	{ Cue = "/VO/Melinoe_0329", Text = "You keep the Headmistress in pleasant company. She's an important job to do." },
	{ Cue = "/VO/Melinoe_0330", Text = "How have my favorite creatures been surviving recently?" },
	{ Cue = "/VO/Melinoe_0331", Text = "You all look like you're being fed your share." },
	{ Cue = "/VO/Melinoe_0246", Text = "I got you something.", },
	{ Cue = "/VO/Melinoe_0247", Text = "I got you this.", },
	{ Cue = "/VO/Melinoe_0248", Text = "Got something for you.", },
	{ Cue = "/VO/Melinoe_0249", Text = "Here you go!", },
}
function UseCrossroadsPet01( usee, args )

	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "MelUsedCrossroadsPet" })
	SetAnimation({ Name = "MelinoeGatherStart", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })

	wait( 0.1)

	Shake({ Id = usee.ObjectId, Distance = 1.5, Speed = 150, Duration = 0.15 })
	PlaySound({ Name = "/VO/CerberusCuteGrowl_3", Id = usee.ObjectId })

	thread( PlayVoiceLines, GlobalVoiceLines.UsedCrossroadsPet01VoiceLines )
	SetAnimation({ Name = "MelinoeGatherPickup", DestinationId = CurrentRun.Hero.ObjectId })

	Shake({ Id = 558691, Distance = 1.5, Speed = 150, Duration = 0.15 })
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/EmoteAttacking", Id = usee.ObjectId })

	wait( 1.5 )

	RemoveInputBlock({ Name = "MelUsedCrossroadsPet" })
	wait( 30.75, RoomThreadName )

	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end

end


function CauldronPresentationBurst()

	CreateAnimation({ Name = "CauldronSmokeSmaller", DestinationId = 558175 })
	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = 558175 })

end

function CauldronPresentationRing()

	-- CreateAnimation({ Name = "CastCircleIn", DestinationId = 556921 })

	wait(3)

	-- CreateAnimation({ Name = "CastCircleOut", DestinationId = 556921 })

end

function CauldronAssistCompletePresentation( source, args )
	args = args or {}
	thread( PlayVoiceLines, GlobalVoiceLines.HecateCauldronAssistanceLines )
end

function SetupCauldronWitchcraftPresentation( source, args )

	local leadParticipant = ActiveEnemies[args.LeadParticipantId]
	if leadParticipant == nil then
		return
	end

	if leadParticipant.NextInteractLines ~= nil and leadParticipant.NextInteractLines.PlayOnce then
		-- Already has a conversation
		return
	end

	-- No longer interactable
	leadParticipant.NextInteractLines = nil
	leadParticipant.InteractTextLineSets = nil
	leadParticipant.CanReceiveGift = false
	leadParticipant.SpecialInteractFunctionName = nil

	source.UseText = "UseCauldronJoinWitchcraft"
	source.OnUsedFunctionName = "UseCauldronJoinWitchcraft"

	local offset = CalcOffset( math.rad(40), 220 )
	Teleport({ Id = leadParticipant.ObjectId, DestinationId = args.CenterPointId, OffsetX = offset.X, OffsetY = offset.Y })
	AngleTowardTarget({ Id = leadParticipant.ObjectId, DestinationId = args.CenterPointId })

	local angle = 150
	for i, otherParticipantId in ipairs( args.OtherParticipantIds ) do
		local offset = CalcOffset( math.rad(angle), 300 )
		offset.Y = offset.Y * 0.5
		Teleport({ Id = otherParticipantId, DestinationId = args.CenterPointId, OffsetX = offset.X, OffsetY = offset.Y })
		AngleTowardTarget({ Id = otherParticipantId, DestinationId = args.CenterPointId })
		angle = angle + 50
	end

	thread( CauldronWitchcraftPresentation, source, args )

end

function CauldronWitchcraftPresentation( source, args )
	
	wait( 3.0 )
	CurrentRun.CauldronWitchcraftOccurred = true
	GameState.CauldronWitchcraftCount = (GameState.CauldronWitchcraftCount or 0) + 1
	SessionMapState.CauldronWitchcraftOccurring = true

	local leadParticipant = ActiveEnemies[args.LeadParticipantId]

	CreateAnimation({ Name = "CauldronSmokeSmaller", DestinationId = source.ObjectId })
	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = source.ObjectId })

	thread( LightRangedSalute, leadParticipant, args )

	SetAnimation({ Name = "HecateHubGreet", DestinationId = leadParticipant.ObjectId })

	local randomVoiceLines = GetRandomValue( leadParticipant.CauldronWitchcraftVoiceLines )
	PlayVoiceLines( randomVoiceLines, true, leadParticipant )

	source.UseText = nil
	source.OnUsedFunctionName = nil
	UseableOff({ Id = source.ObjectId })

	wait( 1.0 )

	if CurrentRun.Hero.JoinedInWitchcraft then
		SetAnimation({ Name = "Melinoe_Witchcraft_End", DestinationId = CurrentRun.Hero.ObjectId })
	end
	RemoveInputBlock({ Name = "CauldronWitchcraftJoinIn" })	
	UnfreezePlayerUnit( "CauldronWitchcraft" )
	CurrentRun.Hero.JoinedInWitchcraft = false	
	SessionMapState.CauldronWitchcraftOccurring = false

	wait( 1.0 )

	CreateAnimation({ Name = "CastCircle", DestinationId = source.ObjectId })

end

function UseCauldronJoinWitchcraft( usee, args, user )
	if CurrentRun.Hero.JoinedInWitchcraft then
		CurrentRun.Hero.JoinedInWitchcraft = false
		SetAnimation({ Name = "Melinoe_Witchcraft_End", DestinationId = user.ObjectId })
		UnfreezePlayerUnit( "CauldronWitchcraft" )
		StopSpeech({ Id = user.ObjectId })
		usee.UseText = nil
		usee.OnUsedFunctionName = nil
		RefreshUseButton( usee.ObjectId, usee )
		wait( 1.0 )
		usee.UseText = "UseCauldronJoinWitchcraft"
		usee.OnUsedFunctionName = "UseCauldronJoinWitchcraft"
		RefreshUseButton( usee.ObjectId, usee )
	else
		AddInputBlock({ Name = "CauldronWitchcraftJoinIn" })
		SetAnimation({ Name = "Melinoe_Witchcraft_Start", DestinationId = user.ObjectId })
		AngleTowardTarget({ Id = user.ObjectId, DestinationId = usee.ObjectId })
		CurrentRun.Hero.JoinedInWitchcraft = true
		wait( 1.0 )
		RemoveInputBlock({ Name = "CauldronWitchcraftJoinIn" })
		FreezePlayerUnit( "CauldronWitchcraft", { AllowedKeys = { "Use" } }  )
		usee.UseText = "UseCauldronLeaveWitchcraft"
	end
end

function CauldronCastingJoinInVoiceLines( source, args )
	if CurrentRun.Hero.JoinedInWitchcraft then
		PlayVoiceLines( args.VoiceLines, true )
	end
end

function GhostEavesdroppers( source, args )
	local randomGroup = GetRandomValue( args.RandomGroups )
	if randomGroup ~= nil then
		Activate({ Ids = randomGroup })
		local randomGhostId = GetRandomValue( randomGroup )
		local inspectPoint = DeepCopyTable( args.InspectPoint )
		local inspectPointId = SpawnObstacle({ Name = inspectPoint.Name, DestinationId = randomGhostId, OffsetZ = 90 })
		inspectPoint.ObjectId = inspectPointId
		AttachLua({ Id = inspectPointId, Table = inspectPoint })
	end
end

function UseGhostEavesdropper( usee, args, user )
	AddInputBlock({ Name = "SpecialInteractShade" })

	--[[
	local randomLine = GetRandomValue( usee.RandomLines )
	thread( InCombatText, usee.ObjectId, randomLine, 1.0, { UseDescription = true } )
	]]--
	SetAlpha({ Id = usee.ObjectId, Fraction = 0.0, Duration = 0.4 })
	UseableOff({ Id = usee.ObjectId })

	wait( 0.10 )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	-- PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.ShadeEavesdropVoiceLines, true, usee )
	-- emotes handled in ShadeEavesdropVoiceLines =

	local animationNames =
	{
		"StatusIconSmile",
		"StatusIconOhBoy",
		"StatusIconEmbarrassed",
		-- "StatusIconDetermined",
		"StatusIconVictory",
	}
	local animationName = RemoveRandomValue( animationNames )
	thread( PlayEmoteSimple, usee, { AnimationName = animationName, Delay = 1.08 } )

	wait( 1.25 )
	RemoveInputBlock({ Name = "SpecialInteractShade" })
end

function GhostFollowers( source, args )

	if CurrentRun.GhostFollowersSpawned == nil and not RandomChance( args.SpawnChance ) then
		return
	end

	CurrentRun.GhostFollowersSpawned = CurrentRun.GhostFollowersSpawned or RandomInt( args.SpawnCountMin, args.SpawnCountMax )
	local spawnPointId = GetClosest({ Id = CurrentRun.NextHeroStartPoint or CurrentRun.Hero.ObjectId, DestinationIds = args.SpawnPointIds })
	local prevId = nil
	for i = 1, CurrentRun.GhostFollowersSpawned do
		local spawnType = GetRandomValue( args.SpawnTypes )
		local spawnOffset = CalcOffset( math.rad( RandomFloat( 0, 360 ) ), RandomFloat( 0, args.SpawnRadius ) )
		local spawnId = SpawnObstacle({ Name = spawnType, Group = args.GroupName or "Standing", DestinationId = spawnPointId, OffsetX = spawnOffset.X, OffsetY = spawnOffset.Y })
		local spawn = DeepCopyTable( ObstacleData[spawnType] )
		spawn.ObjectId = spawnId
		SetupObstacle( spawn )
		if args.ScaleMin and args.ScaleMax then
			spawn.Scale = RandomFloat( args.ScaleMin, args.ScaleMax )
			SetScale({ Fraction = spawn.Scale, Id = spawn.ObjectId })
		end
		SetAngle({ Id = spawn.ObjectId, Angle = RandomFloat( 0, 360 ), Duration = 0.1 })
		local followerArgs = ShallowCopyTable( args )
		followerArgs.FollowId = prevId
		thread( GhostFollowerAI, spawn, followerArgs )
		prevId = spawnId
	end
end

function GhostFollowerAI( ghost, args )
	local followDistance = args.FollowDistance
	local followId = args.FollowId or CurrentRun.Hero.ObjectId

	local firstLoop = true
	local aggroed = false

	wait( 0.5 )

	while true do

		if SessionMapState.InTent then
			waitUntil( "WithinDistanceHub_MainTentExit" )
		end

		local distanceBetween = GetDistance({ Id = ghost.ObjectId, DestinationId = followId, UseTargetMoveTarget = true })
		if distanceBetween > args.LoseAggroDistance then

			aggroed = false
			GhostFollowerLoseAggroPresentation( ghost, args )

			if not firstLoop and args.LoseAggroMeetUpId ~= nil then
				AngleTowardTarget({ Id = ghost.ObjectId, DestinationId = args.LoseAggroMeetUpId, Duration = args.RotationDuration or 0.2, EaseIn = 0.0, EaseOut = 1.0 })
				local targetOffset = CalcOffset( math.rad( RandomFloat( 0, 360 ) ), RandomFloat( 0.0, args.LoseAggroMeetUpRadis ) )
				Move({ Id = ghost.ObjectId, DestinationId = args.LoseAggroMeetUpId, OffsetX = targetOffset.X, OffsetY = targetOffset.Y, Speed = args.Speed, EaseIn = args.EaseIn or 0.01, EaseOut = args.EaseOut or 1.0, })
				wait( 1.0 )
			end

			ghost.AINotifyName = "WithinDistance"..ghost.ObjectId
			NotifyWithinDistance({ Id = ghost.ObjectId, DestinationId = followId, Distance = args.AggroDistance, Notify = ghost.AINotifyName })
			waitUntil( ghost.AINotifyName, ghost.AIThreadName )

			aggroed = true
			GhostFollowerGainAggroPresentation( ghost, args )
		elseif firstLoop then
			GhostFollowerGainAggroPresentation( ghost, args )
		end

		firstLoop = false

		wait( 0.02 )

		if not SessionMapState.InTent then
			local angletBetween = GetAngleBetween({ Id = followId, DestinationId = ghost.ObjectId })
			local targetOffset = CalcOffset( math.rad( angletBetween ), followDistance )
			AngleTowardTarget({ Id = ghost.ObjectId, DestinationId = followId, UseTargetMoveTarget = true, Duration = args.RotationDuration or 0.2, EaseIn = 0.0, EaseOut = 1.0 })
			if distanceBetween > args.CloseMoveDistance then
				Move({ Id = ghost.ObjectId, DestinationId = followId, UseTargetMoveTarget = true, OffsetX = targetOffset.X, OffsetY = targetOffset.Y, Speed = args.Speed, EaseIn = args.EaseIn or 0.01, EaseOut = args.EaseOut or 1.0, })
			else
				Move({ Id = ghost.ObjectId, DestinationId = followId, UseTargetMoveTarget = true, OffsetX = targetOffset.X, OffsetY = targetOffset.Y, Duration = args.CloseMoveDuration, EaseIn = args.EaseIn or 0.01, EaseOut = args.EaseOut or 1.0, })
			end

			ghost.AINotifyName = "OutsideDistanceOrStopped"..ghost.ObjectId
			NotifyOnStopped({ Id = ghost.ObjectId, Notify = ghost.AINotifyName })
			waitUntil( ghost.AINotifyName, ghost.AIThreadName )

			wait( 0.02 )

			AngleTowardTarget({ Id = ghost.ObjectId, DestinationId = followId, Duration = args.RotationDuration or 0.2, EaseIn = 0.0, EaseOut = 1.0 })

			wait( 0.02 )

			ghost.AINotifyName = "OutsideDistance"..ghost.ObjectId
			NotifyOutsideDistance({ Id = ghost.ObjectId, DestinationId = followId, Distance = followDistance + args.BufferDistance, Notify = ghost.AINotifyName })
			waitUntil( ghost.AINotifyName, ghost.AIThreadName )

		end

		wait( 0.02 )

	end
end

function GhostFollowerGainAggroPresentation( ghost, args )
	AngleTowardTarget({ Id = ghost.ObjectId, DestinationId = args.FollowId or CurrentRun.Hero.ObjectId, Duration = args.RotationDuration or 0.2, SmoothStep = true })

	if CheckCooldown( "GhostGainedAggroRecently", 60 )	then
		if CoinFlip() then
			PlayEmoteSimple( ghost, { AnimationName = "StatusIconOhBoy", ChanceToPlay = 0.75 } )
			PlaySound({ Name = "/SFX/GhostEmotes/EmbarrassedTINY", Id = ghost.ObjectId })
		else
			PlayEmoteSimple( ghost, { AnimationName = "StatusIconSmile", ChanceToPlay = 0.75 } )
			PlaySound({ Name = "/SFX/GhostEmotes/SmileTINY", Id = ghost.ObjectId })
		end
	end

	thread( PlayVoiceLines, HeroVoiceLines.GhostTrainVoiceLines, true )

end

function GhostFollowerLoseAggroPresentation( ghost, args )

	if CheckCooldown( "GhostLostAggroRecently", 60 ) then
		if CoinFlip() then
			PlayEmoteSimple( ghost, { AnimationName = "StatusIconEmbarrassed", ChanceToPlay = 0.25 } )
			PlaySound({ Name = "/SFX/GhostEmotes/DisgruntledTINY", Id = ghost.ObjectId })
		else
			PlayEmoteSimple( ghost, { AnimationName = "StatusIconSmile", ChanceToPlay = 0.25 } )
			PlaySound({ Name = "/SFX/GhostEmotes/GriefTINY", Id = ghost.ObjectId })
		end
	end

end

function OdysseusArriveAtTable( source, args, node )
	wait( 1.0, source.AIThreadName )
	if GetDistance({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) < args.GreetDistance and CheckCooldown( "OdysseusGreet", 60 ) then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		SetAnimation({ Name = "Odysseus_Salute", DestinationId = source.ObjectId })
	end
	wait( 5.0, source.AIThreadName )
end

function OdysseusArriveAtGardenPlot( source, args, node )
	wait( 1.0, source.AIThreadName )
	if GetDistance({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) < args.GreetDistance and CheckCooldown( "OdysseusGreet", 60 ) then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		SetAnimation({ Name = "Odysseus_Salute", DestinationId = source.ObjectId })
		wait( 5.0, source.AIThreadName )
	elseif CoinFlip() then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = node.Id })
		SetAnimation({ Name = "Odysseus_Surveying", DestinationId = source.ObjectId })
		wait( 7.0, source.AIThreadName )
	else
		wait( 3.0, source.AIThreadName )
	end
end

function OdysseusAtTaverna( source, args )
	CheckDistanceTriggerThread( source, PresetEventArgs.OdysseusFeasting )
	SessionMapState.OdysseusAtTaverna = true
end

function MorosObserveFatedList( source, args, node )
	local fatedListId = 560662
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = fatedListId })
	wait( 1.2, source.AIThreadName )
	SetAnimation({ Name = "Moros_Considers", DestinationId = source.ObjectId })
	wait( 6.4, source.AIThreadName )
end

function MorosObservingInterrupt( source, args, textLines )
	killTaggedThreads( source.AIThreadName )
	killWaitUntilThreads( source.AINotifyName )
	Stop({ Id = source.ObjectId })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Moros_Attention", DestinationId = source.ObjectId })
	wait( 1.0 )
end

function RevealTavernaPresentation( source )

	ResourceGiftedPresentation( { ResourceName = "SuperGiftPoints", SoundName = "/SFX/GiftAmbrosiaBottlePickup" } )
	ClearMapBlockers( source, { DeleteGroups = { "Taverna_Blocker", "TavernaDimmer_01" }, } )

end

function RevealFishingPointPresentation( source )

	ResourceGiftedPresentation( { ResourceName = "GiftPointsEpic", SoundName = "/Leftovers/SFX/BigFishSplash" } )
	ClearMapBlockers( source, { DeleteGroups = { "Docks_Blocker", "DocksDimmer_01" }, } )

end

function RevealBathHousePresentation( source )

	ResourceGiftedPresentation()
	ClearMapBlockers( source, { DeleteGroups = { "Bath_Blocker", "BathDimmer_01" }, } )

end

function TechTestEscapeDoorClosed( usee, args )
	AddInputBlock({ Name = "UseEscapeDoor" })

	args = args or {}
	if CheckCooldown( "LockedSurfaceDoorUsed", 2.0 ) then
		thread( RepulseFromObject, usee, { Text = "Hint_TechTestConcluded", OffsetZ = -100, OffsetX = -0, ShadowScaleX = 1.3, Scale = 2.0 })
		PlaySound({ Name = "/Leftovers/SFX/PlayerKilled_Small", Id = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = usee.ObjectId })
	end
	thread( PlayVoiceLines, GlobalVoiceLines.EndTechTestVoiceLines, true )
	RemoveInputBlock({ Name = "UseEscapeDoor" })
end