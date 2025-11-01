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
	TentEnterPresentation( nil, { AmbientMusicParamsDuration = 0 } )
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
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })

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
		--thread( MelReadyFlash )
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

function HubPostBountyStartPresentation( currentRoom )
	ShowingCombatUI = nil
	AddInputBlock({ Name = "StartRoomPresentation" })
	ZeroMouseTether( "StartRoomPresentation" )

	local roomData = HubRoomData[currentRoom.Name] or currentRoom

	SetConfigOption({ Name = "FullscreenEffectGroup", Value = roomData.FullscreenEffectGroup or "Vignette" })

	if roomData.CameraZoomWeights ~= nil then
		for id, weight in pairs( roomData.CameraZoomWeights ) do
			SetCameraZoomWeight({ Id = id, Weight = weight, ZoomSpeed = 1.0 })
		end
	end
	AdjustZoom({ Fraction = roomData.ZoomFraction })

	if not roomData.IgnoreClamps then
		local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
		DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })
		SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	end

	StartRoomAmbience( CurrentRun, currentRoom )
	thread( StartRoomMusic, CurrentRun, currentRoom )

	local bountyBoardId = 561146
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = bountyBoardId, OffsetX = 0, OffsetY = 150 })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = bountyBoardId })
	LockCamera({ Id = CurrentRun.Hero.ObjectId })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = 100, Duration = 0.0, Retarget = true, EaseIn = 0, EaseOut = 0.1 })
	FocusCamera({ Fraction = roomData.ZoomFraction * 0.92, Duration = 0.01 })
	AdjustColorGrading({ Name = "Team03", Duration = 0.01 })
	AdjustFullscreenBloom({ Name = "GoldBloom", Duration = 0.01 })

	wait( 0.03 )
	FadeIn({ Duration = 0.5 })
	thread( FullScreenFadeInAnimation )

	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = 0, Duration = 2, Retarget = true, EaseIn = 0, EaseOut = 0.1 })
	FocusCamera({ Fraction = roomData.ZoomFraction, Duration = 2 })
	
	SetAnimation({ Name = "MelinoeCrossCastAnticReverse", DestinationId = CurrentRun.Hero.ObjectId, PlaySpeed = 0.15 })

	CreateAnimation({ Name = "SorcerySummonPresentationFx", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = CurrentRun.Hero.ObjectId, Scale = 0.5 })

	wait( 0.13 )
	PlaySound({ Name = "/SFX/Menu Sounds/ChaosRoomEnterExit" })

	CreateAnimation({ Name = "SorceryLeapRiseStreaks", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitter", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitterBright", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitterDisplace", DestinationId = CurrentRun.Hero.ObjectId })

	local trialIntroDuration = 1.3
	AdjustColorGrading({ Name = "Off", Duration = trialIntroDuration })
	AdjustFullscreenBloom({ Name = "Off", Duration = trialIntroDuration })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = 0, Duration = trialIntroDuration * 2.0, Retarget = true, EaseIn = 0, EaseOut = 0.1 })
	FocusCamera({ Fraction = roomData.ZoomFraction, Duration = trialIntroDuration * 2.0, ZoomType = "Ease" })

	-- audio
	local prevRoom = GetPreviousRoom( currentRun )
	if prevRoom == nil or not prevRoom.SkipEnteredDeathAreaVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines.EnteredDeathAreaVoiceLines )
		thread( PlayVoiceLines, GlobalVoiceLines.SkellyBountyReturnReactionLines )
	end

	wait( 1.7 )
	SetAnimation({ Name = "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })

	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })

	RemoveInputBlock({ Name = "StartRoomPresentation" })
	UnzeroMouseTether( "StartRoomPresentation" )
	wait( 0.5 )
	ShowCombatUI()

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
				PathTrue = { "CurrentRun", "TextLinesRecord", "HecateBathHouseEpilogue01" },
			},
		},
		{ Cue = "/VO/Melinoe_4895", Text = "...But I have my family. I have {#Emph}you." },
	},
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
		PreLineWait = 0.65,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "DoraBathHouse03" },
			},
		},

		{ Cue = "/VO/Melinoe_4679", Text = "{#Emph}Heh. {#Prev}Whenever you're ready." },
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
		ObjectType = "NPC_Odysseus_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "OdysseusBathHouse01" },
			},
		},
		{ Cue = "/VO/Odysseus_0660", Text = "It is! Agreeable it is." },
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
				PathTrue = { "CurrentRun", "TextLinesRecord", "NemesisBathHouse03" },
			},
		},
		{ Cue = "/VO/Melinoe_4445", Text = "I'll do what I can." },
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
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosBathHouse03" },
			},
		},
		{ Cue = "/VO/Melinoe_4818", Text = "Well thank the Fates..." },
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
	{
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ErisBathHouse02" },
			},
		},
		{ Cue = "/VO/Melinoe_4297", Text = "Well all right..." },
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
				PathTrue = { "CurrentRun", "TextLinesRecord", "IcarusBathHouse01" },
			},
		},

		{ Cue = "/VO/Melinoe_4538", Text = "As am I." },
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
				PathTrue = { "CurrentRun", "TextLinesRecord", "IcarusBathHouse02" },
			},
		},

		{ Cue = "/VO/Melinoe_4544", Text = "I do, too." },
	},

}
GlobalVoiceLines.EnteredBathVoiceLines =
{
	{
		SkipAnim = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Melinoe_1965", Text = "{#Emph}Whew...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_5492", Text = "{#Emph}Aah..." },
		{ Cue = "/VO/Melinoe_5493", Text = "Perfect..." },
		{ Cue = "/VO/Melinoe_5494", Text = "Just right..." },
		{ Cue = "/VO/Melinoe_4534", Text = "That's {#Emph}good...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "IcarusBathHouse01" },
				},
			},
		},
	},
	{
		SkipAnim = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "DoraBathHouse01", "DoraBathHouse02", "DoraBathHouse03" },
			},
		},
		{ Cue = "/VO/Dora_0064", Text = "Sure is steamy in here, I'll give it that!" },
		{ Cue = "/VO/Dora_0066", Text = "{#Emph}Yeah{#Prev}, this is the life...!", PlayFirst = true },
		{ Cue = "/VO/Dora_0067", Text = "{#Emph}Ahhh {#Prev}I care about absolutely nothing right now." },
		{ Cue = "/VO/Dora_0068", Text = "Bet this water's pretty comfortable!" },
		{ Cue = "/VO/Dora_0601", Text = "Well melt me into Psyche...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "DoraBathHouse03" },
				},
			},
		},
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
				HasAny = { "HecateBathHouseEpilogue01" },
			}
		},

		{ Cue = "/VO/Hecate_0801", Text = "{#Emph}Ah{#Prev}, but that's not bad..." },
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
		{ Cue = "/VO/Hecate_0559", Text = "{#Emph}<Sigh>" },
		{ Cue = "/VO/Hecate_0561", Text = "{#Emph}<Sigh>" },
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
				HasAny = { "NemesisBathHouse01", "NemesisBathHouse02", "NemesisBathHouse03" },
			},
		},
		{ Cue = "/VO/Nemesis_0205", Text = "Not too hot, not too cold...", PlayFirst = true },
		{ Cue = "/VO/Nemesis_0206", Text = "What are {#Emph}you {#Prev}looking at?" },
		{ Cue = "/VO/Nemesis_0209", Text = "Well, soak it up..." },
		{ Cue = "/VO/Nemesis_0210", Text = "{#Emph}<Sigh>" },
		{ Cue = "/VO/Nemesis_0211", Text = "Well, what is it." },
		{ Cue = "/VO/Nemesis_0212", Text = "Something on your mind?" },
		{ Cue = "/VO/Nemesis_0207", Text = "Really shouldn't get {#Emph}too {#Prev}comfortable in here...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Nemesis_0205" }
				},
			},
		},
		{ Cue = "/VO/Nemesis_0208", Text = "{#Emph}Ungh{#Prev}, damn...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Nemesis_0207" }
				},
			},
		},
	},
	{
		SkipAnim = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		BreakIfPlayed = true,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Moros_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "MorosBathHouse01", "MorosBathHouse02", "MorosBathHouse03" },
			}
		},
		{ Cue = "/VO/Moros_0106", Text = "{#Emph}Whew!", PlayFirst = true },
		{ Cue = "/VO/Moros_0107", Text = "All my fears evaporate again..." },
		{ Cue = "/VO/Moros_0108", Text = "I could stay here forever..." },
		{ Cue = "/VO/Moros_0683", Text = "The perfect warmth..." },
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
		{ Cue = "/VO/Eris_0209", Text = "We should swap outfits once we're done!" },
		{ Cue = "/VO/Eris_0210", Text = "Look at all these bubbles dying off!" },
		{ Cue = "/VO/Eris_0211", Text = "{#Emph}That's {#Prev}the stuff." },
	},
	{
		SkipAnim = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Icarus_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "IcarusBathHouse01", "IcarusBathHouse02" },
			}
		},
		{ Cue = "/VO/Icarus_0188", Text = "{#Emph}Erm, oh..." },
		{ Cue = "/VO/Icarus_0189", Text = "{#Emph}Whew, heh..." },
		{ Cue = "/VO/Icarus_0190", Text = "It's like it's {#Emph}warm...!" },
		{ Cue = "/VO/Icarus_0191", Text = "In we go, then...", PlayFirst = true },
	},
}

function BathHouseStartPresentation( source, args, line )
	args = args or {}

	-- FadeOut({ Color = Color.Black, Duration = 0.5 })
	-- PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	FullScreenFadeOutAnimation( "RoomTransitionIn_Radial" )
	EstablishConversationStartingPoint( source )

	waitUnmodified( 1.0 )
	
	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 0.0, Duration = 0.0 })
	ClearCameraClamp({ LerpTime = 0 })
	Teleport({ Id = source.ObjectId, DestinationId = 558312, OffsetY = source.PreBathOffsetY or 0 })
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 558314, })
	AngleTowardTarget({ Ids = { source.ObjectId, CurrentRun.Hero.ObjectId }, DestinationId = 589588, CompleteAngle = true })

	LockCamera({ Id = 589588 })

	FullScreenFadeInAnimation( "RoomTransitionOut_Radial" )
	-- FadeIn({ Duration = 2.0 })

	waitUnmodified( 0.5 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })
	PanCamera({ Id = 589586, Duration = 7, EaseIn = 0.5, EaseOut = 2, Retarget = true })

	waitUnmodified( 1.5 )
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
	if source.PreBathAnimationName ~= nil then
		SetAnimation({ Name = source.PreBathAnimationName,DestinationId = source.ObjectId })
	end

	waitUnmodified( 2.0 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract" })
	waitUnmodified( 0.4 )
	PlaySound({ Name = source.BathEnterSound1 or "/Leftovers/SFX/RobeFlutterInScene" })
	waitUnmodified( 0.4 )
	PlaySound({ Name = source.BathEnterSound2 or "/Leftovers/SFX/RobeFlutterInScene" })
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

	AudioState.BathHouseSoundId = PlaySound({ Name = "/Leftovers/Ambience/BathHouseAmbience" })
	SetVolume({ Id = AudioState.BathHouseSoundId, Value = 0, Duration = 0 })
	SetVolume({ Id = AudioState.BathHouseSoundId, Value = 1, Duration = 1.0 })

	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 1.0, Duration = 0.5 })
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

	-- FadeOut({ Color = Color.Black, Duration = 0.6 })
	FullScreenFadeOutAnimation( "RoomTransitionIn_Radial" )
	-- waitUnmodified( 0.6 )

	TeleportToConversationStartingPoint( source, args )

	waitUnmodified( 4.5 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	waitUnmodified( 0.5 )
	-- FadeIn({ Duration = 1.8 })
	FullScreenFadeInAnimation( "RoomTransitionOut_Radial" )
	waitUnmodified( 1.0 )
end

function FishingPierStartPresentation( source, args )
	args = args or {}

	waitUnmodified( 0.1 )
	FullScreenFadeOutAnimation( "RoomTransitionIn_Radial" )
	EstablishConversationStartingPoint( source )
	waitUnmodified( 0.25 )
	FadeOut({ Color = Color.Black, Duration = 0.0 })

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 566617 })
	Teleport({ Id = source.ObjectId, DestinationId = 566616 })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 558317 })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = 558317, CompleteAngle = true })
	waitUnmodified( 0.25 )

	-- PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation( "RoomTransitionOut_Radial" )
	waitUnmodified( 0.7 )
end

function FishingPierEndPresentation( source, args )
	args = args or {}

	FullScreenFadeOutAnimation( "RoomTransitionIn_Radial" )
	-- FadeOut({ Color = Color.Black, Duration = 0.5 })
	-- FadeOut({ Color = Color.Black, Duration = 0.75 })
	waitUnmodified( 0.35 )

	TeleportToConversationStartingPoint( source, args )

	waitUnmodified( 5.0 )

	-- PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	-- FadeIn({ Duration = 2.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	FullScreenFadeInAnimation( "RoomTransitionOut_Radial" )
	waitUnmodified( 1.0 )
end

function TavernaStartPresentation( source, args )
	args = args or {}

	FullScreenFadeOutAnimation( "RoomTransitionIn_Radial" )
	-- FadeOut({ Color = Color.Black, Duration = 0.5 })
	EstablishConversationStartingPoint( source )
	waitUnmodified( 0.25 )

	if args.IsOdysseus then
		OdysseusAtTaverna( source, args )
		waitUnmodified( 0.2 )
	end
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 589539 })
	Teleport({ Id = source.ObjectId, DestinationId = source.TavernaTeleportId or 589538 })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })

	if not args.IsOdysseus then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, CompleteAngle = true })
	end

	-- covers character rotation
	waitUnmodified( 0.3 )

	-- PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	FullScreenFadeInAnimation( "RoomTransitionOut_Radial" )
	waitUnmodified( 0.7 )
	-- FadeIn({ Duration = 0.5 })
end

-- used for Arachne
function AltTavernaStartPresentation( source, args )
	args = args or {}

	FullScreenFadeOutAnimation( "RoomTransitionIn_Radial" )
	-- FadeOut({ Color = Color.Black, Duration = 0.5 })
	-- EstablishConversationStartingPoint( source )
	SetAnimation({ Name = "MelTalkPensive01", DestinationId = CurrentRun.Hero.ObjectId })

	waitUnmodified( 0.25 )

	-- covers character rotation
	waitUnmodified( 0.3 )

	-- PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	FullScreenFadeInAnimation( "RoomTransitionOut_Radial" )
	waitUnmodified( 0.7 )
	-- FadeIn({ Duration = 0.5 })
end

function TavernaEndPresentation( source, args )
	args = args or {}

	FullScreenFadeOutAnimation( "RoomTransitionIn_Radial" )
	-- FadeOut({ Color = Color.Black, Duration = 0.5 })
	waitUnmodified( 0.25 )
	if args.IsOdysseus then
		SetAnimation({ Name = "Odysseus_Idle", DestinationId = source.ObjectId })
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if CurrentRun.Hero.IsDead then
		TeleportToConversationStartingPoint( source, args )
	end

	waitUnmodified( 8.0 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	FullScreenFadeInAnimation( "RoomTransitionOut_Radial" )
	waitUnmodified( 0.7 )
end


GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.HotSpringsBathVoiceLines =
{
	{
		PreLineWait = 0.65,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Melinoe_0672", Text = "{#Emph}Hmm..." },
	}
}

function TimePassesPresentation( source, args )

	args = args or {}

	CurrentRun.TimePassageOccurred = true

	if args.TimeTicks then
		GardenTimeTick( { Ticks = args.TimeTicks, UpdatePlotPresentation = true, PanDuration = 0.0, SkipCameraPan = true, SkipSound = true, TickInterval = 0.0 } )
		CookTimeTick( { Ticks = args.TimeTicks, UpdatePresentation = true, TickInterval = 0.0, } )
		MailboxTimeTick( { Ticks = args.TimeTicks, UpdatePresentation = true, TickInterval = 0.0, } )
	end

	if args.GlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[args.GlobalVoiceLines] )
	end

	if args.IncludeFishingSFX then
		thread( TimePassesFishingSFX, source, args )
	end

	wait( args.PreTextWait or 1.0 )

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	SetCameraClamp({ Ids = args.CameraClamps or currentRoom.CameraClamps, SoftClamp = args.SoftClamp or currentRoom.SoftClamp })
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })

	if not args.SkipAngleTowardTarget then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end

	if args.HeroAnim ~= nil then
		SetAnimation({ Name = args.HeroAnim, DestinationId = CurrentRun.Hero.ObjectId })
	end

	thread( DisplayInfoBanner, nil, {
		TitleText = args.Text or "LoungeIntermissionMessage",
		TitleTextOffsetX = 81,
		LangTitleTextOffsetX = {	
			{ Code = "el", Value = 0 },
			{ Code = "ja", Value = 0 },
			{ Code = "ko", Value = 0 },
			{ Code = "ru", Value = 0 },
			{ Code = "uk", Value = 0 },
		},
		TextRevealSound = "/Leftovers/Menu Sounds/EmoteExcitement",
		Color = Color.Gold,
		TextColor = Color.White,
		TextOffsetY = 20,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		Layer = "ScreenOverlay",
		AnimationName = "LocationBackingIrisSmallIn",
		AnimationOutName = "LocationBackingIrisSmallOut",
		AdditionalAnimation = "GodHoodRays",
		} )

	wait( args.PostTextWait or 5.0 )

	-- AdjustFullscreenBloom({ Name = "Menu", Duration = 0.5 })
	-- AdjustColorGrading({ Name = "Ascension", Duration = 0.5 })
	-- AdjustColorGrading({ Name = "Off", Duration = 5.0 })
	-- AdjustFullscreenBloom({ Name = "Off", Duration = 5.0 })

	wait( 1.0 )
end

function TimePassesFishingSFX( source, args )
	wait(0.25)
	PlaySound({ Name = "/Leftovers/SFX/FishSpawnSplash" })
	wait(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/CaravanJump" })
	wait(1.6)
	PlaySound({ Name = "/Leftovers/SFX/FishingPlunk" })
	wait(0.5)
	PlaySound({ Name = "/Leftovers/SFX/FishSpawnSplash" })
	wait(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/CaravanWaterBuck1" })
	wait(1.0)
	PlaySound({ Name = "/Leftovers/SFX/FishSpawnSplash" })
	wait(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/CaravanWaterBuck2" })
	wait(1.0)
end

GlobalVoiceLines.LoungeRevelryVoiceLines =
{
	{
		PreLineWait = 0.4,
		PlayOnce = true,
		PlayOnceContext = "ArtemisAmbrosiaToastSpeech",
		BreakIfPlayed = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		PrelineAnim = "MelinoeSalute",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ArtemisAboutAmbrosia01" },
			},
		},
		{ Cue = "/VO/MelinoeField_4107", Text = "To the Silver Sisters!" },
	},
	{
		PreLineWait = 0.4,
		PlayOnce = true,
		PlayOnceContext = "ArachneAmbrosiaToastSpeech",
		BreakIfPlayed = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		PrelineAnim = "MelinoeSalute",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ArachneGift09" },
			},
		},
		{ Cue = "/VO/MelinoeField_4409", Text = "And I'm honored to be in that weaver's presence." },
	},
	{
		PreLineWait = 0.35,
		BreakIfPlayed = true,
		ObjectType = "NPC_Moros_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosTaverna01" },
			},
		},
		{ Cue = "/VO/Moros_0080", Text = "{#Emph}Haha! {#Prev}Yes it is." },
	},
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosTaverna02" },
			},
		},
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			AllowTalkOverTextLines = true,
			{ Cue = "/VO/Melinoe_4617", Text = "Then, to discovering our path together." },
		},
		{
			PreLineWait = 0.35,
			BreakIfPlayed = true,
			ObjectType = "NPC_Moros_01",
			AllowTalkOverTextLines = true,
			{ Cue = "/VO/Moros_0402", Text = "To discovering our path." },
		},
	},
	{
		PreLineWait = 0.25,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "DoraTaverna01" },
			},
		},
		{ Cue = "/VO/Melinoe_3730", Text = "{#Emph}Aah...! Hahaha!" },
	},
	{
		PreLineWait = 0.35,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HecateTaverna01" },
			},
		},
		{ Cue = "/VO/Melinoe_3890", Text = "To discovering the truth!" },
	},
	{
		PreLineWait = 1.25,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HecateTaverna02" },
			},
		},
		{ Cue = "/VO/Melinoe_5027", Text = "Thank you all for standing by my side!" },
	},
	{
		PreLineWait = 0.25,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "OdysseusTaverna02" },
			},
		},
		{ Cue = "/VO/Melinoe_5090", Text = "Good plan...! {#Emph}Hey{#Prev}, might we have your attention, everyone?" },
	},
	{
		PreLineWait = 0.35,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ErisTaverna01" },
			},
		},
		{ Cue = "/VO/Melinoe_4281", Text = "Well, cheers then!" },
	},
	{
		PreLineWait = 0.35,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ErisTaverna02" },
			},
		},
		{ Cue = "/VO/Melinoe_4489", Text = "We certainly may: {#Emph}To all that we can never have." },
	},
	{
		PreLineWait = 0.35,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "IcarusTaverna01" },
			},
		},
		{ Cue = "/VO/Melinoe_4553", Text = "Then let's drink to the Shades of the Crossroads!" },
	},
}

function LoungeRevelryPresentation( source, args )

	args = args or {}

	CurrentRun.TimePassageOccurred = true

	-- for ArtemisAboutAmbrosia01
	if args.IsArtemisField and SessionMapState.BlockInfoBanners then
		SessionMapState.BlockInfoBanners = false
	end

	if args.TimeTicks then
		local shouldUpdatePresentation = ( CurrentHubRoom ~= nil )
		GardenTimeTick( { Ticks = args.TimeTicks, UpdatePlotPresentation = shouldUpdatePresentation, PanDuration = 0.0, SkipCameraPan = true, SkipSound = true, TickInterval = 0.0 } )
		CookTimeTick( { Ticks = args.TimeTicks, UpdatePresentation = shouldUpdatePresentation, TickInterval = 0.0, } )
		MailboxTimeTick( { Ticks = args.TimeTicks, UpdatePresentation = shouldUpdatePresentation, TickInterval = 0.0, } )
	end

	thread( PlayVoiceLines, GlobalVoiceLines.LoungeRevelryVoiceLines, false )

	wait(1.5)
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_GlassWithIce" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_BottleCork" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_BottlePour" })
	wait(1.0)
	PlaySound({ Name = args.Sound2 or "/EmptyCue" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)

	thread( DisplayInfoBanner, nil, {
		TitleText = "LoungeIntermissionMessage",
		TitleTextOffsetX = 81,
		LangTitleTextOffsetX = {	
			{ Code = "el", Value = 0 },
			{ Code = "ja", Value = 0 },
			{ Code = "ko", Value = 0 },
			{ Code = "ru", Value = 0 },
			{ Code = "uk", Value = 0 },
		},
		TextRevealSound = "/Leftovers/Menu Sounds/EmoteExcitement",
		Color = Color.Gold,
		TextColor = Color.White,
		TextOffsetY = 20,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		AnimationName = "LocationBackingIrisSmallIn",
		AnimationOutName = "LocationBackingIrisSmallOut",
		Layer = "ScreenOverlay",
		AdditionalAnimation = "GodHoodRays",
		} )

	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_GlassesClinking" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	PlaySound({ Name = args.Sound3 or "/EmptyCue" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	AdjustFullscreenBloom({ Name = "Menu", Duration = 0.3 })
	AdjustColorGrading({ Name = "Ascension", Duration = 0.3 })
	AdjustColorGrading({ Name = "Off", Duration = 5.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 5.0 })
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(1.0)
	if args.IsArtemisField and SessionMapState.BlockInfoBanners then
		SessionMapState.BlockInfoBanners = true
	end

end

GlobalVoiceLines.GoSomeplaceReactionLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ErisBecomingCloser01" },
			},
		},
		{ Cue = "/VO/Melinoe_4492", Text = "Well... all right." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "IcarusBecomingCloser01" },
			},
		},
		{ Cue = "/VO/Melinoe_4575", Text = "Come here, you fool!" },
	},
}
function GoSomeplaceStartPresentation( source, args )
	args = args or {}

	FadeOut({ Color = Color.Black, Duration = 0.5 })
	EstablishConversationStartingPoint( source )
	thread( PlayVoiceLines, GlobalVoiceLines.GoSomeplaceReactionLines )
	waitUnmodified( 2.5 )

	if args ~= nil and args.Tent ~= nil then
		TentEnterPresentation()
		DoraTeleportHub({ DestinationId = 560665, CategoryIndex = 2 })
	end

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.GoSomeplacePoint1 or 800382 })
	Teleport({ Id = source.ObjectId, DestinationId = source.GoSomeplacePoint2 or 800381 })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	waitUnmodified( 0.3 )

	FadeIn({ Duration = 2.0 })
	waitUnmodified( 2.0 )

end

function GoSomeplaceEndPresentation( source, args )
	args = args or {}

	FadeOut({ Color = Color.Black, Duration = 0.5 })
	waitUnmodified( 0.5 )

	TeleportToConversationStartingPoint( source, args )

	waitUnmodified( 10.0 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	FadeIn({ Duration = 2.0 })
	waitUnmodified( 2.0 )
end

GlobalVoiceLines.BecomingCloserLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Nemesis_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "NemesisPostCombatBecomingCloser01" },
			},
		},
		{ Cue = "/VO/NemesisField_0450", Text = "...Look for a clasp right here at the small of my back." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Moros_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosBecomingCloser01" },
			},
		},
		{ Cue = "/VO/Moros_0410", Text = "Princess..." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Eris_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ErisBecomingCloser01" },
			},
		},
		{ Cue = "/VO/Eris_0282", Text = "Then come here..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Eris_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ErisBecomingCloser01" },
			},
		},

		{ Cue = "/VO/Eris_0336", Text = "What are we gonna do {#Emph}this {#Prev}time..." },
		{ Cue = "/VO/Eris_0337", Text = "C'mon I don't have all night." },
		{ Cue = "/VO/Eris_0338", Text = "Close your eyes..." },
		{ Cue = "/VO/Eris_0339", Text = "Hold it right there..." },
		{ Cue = "/VO/Eris_0340", Text = "I know...!" },
		{ Cue = "/VO/Eris_0341", Text = "D'you miss me, Trouble...?" },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Icarus_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "IcarusBecomingCloser01" },
			},
		},
		{ Cue = "/VO/Icarus_0360", Text = "I can't imagine that..." },
	},
}
GlobalVoiceLines.BecomingCloserAfterLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Moros_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "MorosBecomingCloser01" },
			},
		},
		{ Cue = "/VO/Moros_0551", Text = "You're safe...", PlayFirst = true },
		{ Cue = "/VO/Moros_0552", Text = "I missed this..." },
		{ Cue = "/VO/Moros_0553", Text = "Moonlight even here..." },
		{ Cue = "/VO/Moros_0554", Text = "Still your heart..." },
		{ Cue = "/VO/Moros_0555", Text = "Stay with me..." },
		{ Cue = "/VO/Moros_0556", Text = "All these shadows..." },
		{ Cue = "/VO/Moros_0557", Text = "Melinoë..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Nemesis_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "NemesisPostCombatBecomingCloser01" },
			},
		},
		{ Cue = "/VO/Nemesis_0373", Text = "...Melinoë." },
		{ Cue = "/VO/Nemesis_0374", Text = "...Princess.", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Icarus_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "IcarusBecomingCloser01" },
			},
		},

		{ Cue = "/VO/Icarus_0508", Text = "Come here..." },
		{ Cue = "/VO/Icarus_0509", Text = "You're beautiful..." },
		{ Cue = "/VO/Icarus_0510", Text = "Stay with me..." },
		{ Cue = "/VO/Icarus_0511", Text = "I can feel again..." },
		{ Cue = "/VO/Icarus_0512", Text = "Look at you..." },
		{ Cue = "/VO/Icarus_0513", Text = "My heart..." },
		{ Cue = "/VO/Icarus_0372", Text = "...Wow.", PlayFirst = true },
	}
}
function BecomingCloserPresentation( source, args )

	args = args or {}

	if not args.SkipFadeOut then
		FadeOut({ Color = Color.Black, Duration = 0.5 })
	end

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })

	waitUnmodified( args.ExtraWaitTime )

	thread( PlayVoiceLines, GlobalVoiceLines.BecomingCloserLines, true )

	if source.BecomingCloserFunctionName ~= nil then
		CallFunctionName( source.BecomingCloserFunctionName, source, args )
	end
		
	waitUnmodified( 0.4 )
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })

	if args ~= nil then
		if args.Partner == "Moros" then
			-- not shown
		elseif args.Partner == "Nemesis" then
			SetAnimation({ Name = "Nemesis_Hub_Greet", DestinationId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Nemesis_01" }) })
		elseif args.Partner == "Icarus" then
			SetAnimation({ Name = "Icarus_Flustered_End", DestinationId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Icarus_01" }) })
		elseif args.Partner == "Eris" then
			SetAnimation({ Name = "Enemy_Eris_Hub_Flattered", DestinationId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Eris_01" }) })
		end
	end
	waitUnmodified( 0.1 )

	if not args.SkipFadeOut then
		FadeIn({ Duration = 2.0 })
	end
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })

	if not args.SkipTimePassage then

		CurrentRun.TimePassageOccurred = true

		local timeTicks = GameData.PostIntermissionArgs.LuaValue.TimerTicks
		GardenTimeTick( { Ticks = timeTicks, UpdatePlotPresentation = (CurrentHubRoom ~= nil), PanDuration = 0.0, SkipCameraPan = true, SkipSound = true, TickInterval = 0.0 } )
		CookTimeTick( { Ticks = timeTicks, UpdatePresentation = (CurrentHubRoom ~= nil), TickInterval = 0.0, } )
		MailboxTimeTick( { Ticks = timeTicks, UpdatePresentation = (CurrentHubRoom ~= nil), TickInterval = 0.0, } )

	end

	wait(1.0)

	thread( DisplayInfoBanner, nil, {
		TitleText = args.Text or "BedroomIntermissionMessage",
		TextRevealSound = "/Leftovers/Menu Sounds/EmoteExcitement",
		Color = Color.Gold,
		TextColor = Color.White,
		TitleTextOffsetX = args.TitleTextOffetX or 81,
		LangTitleTextOffsetX = {
			{ Code = "el", Value = 0 },
			{ Code = "ja", Value = 0 },
			{ Code = "ko", Value = 0 },
			{ Code = "ru", Value = 0 },
			{ Code = "uk", Value = 0 },
		},
		TextOffsetY = 20,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		Layer = "ScreenOverlay",
		AnimationName = "LocationBackingIrisSmallIn",
		AnimationOutName = "LocationBackingIrisSmallOut",
		AdditionalAnimation = "GodHoodRays",
		} )

	wait( args.PostTextWait or 4.0 )

end

function BecomingCloserMorosPresentation( source, args )

--[[
{ Cue = "/VO/Moros_0568", Text = "<Chuckle>" },
{ Cue = "/VO/Moros_0569", Text = "<Chuckle>" },
{ Cue = "/VO/Moros_0570", Text = "<Laugh>" },
{ Cue = "/VO/Moros_0571", Text = "<Laugh>" },
{ Cue = "/VO/Moros_0572", Text = "<Soft Gasp>" },
{ Cue = "/VO/Moros_0573", Text = "<Sigh>" },
{ Cue = "/VO/Moros_0574", Text = "Mm." },
{ Cue = "/VO/Moros_0575", Text = "Hm." },
{ Cue = "/VO/Moros_0576", Text = "Whew..." },
]]--
	waitUnmodified(2)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.4)
	PlaySound({ Name = "/VO/Melinoe_4418" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Moros_0574" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.3)
	PlayVoiceLines( GlobalVoiceLines.BecomingCloserAfterLines, true )
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Melinoe_1948" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutterInScene" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/VO/Moros_0572" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.4)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/VO/Melinoe_1963" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutterInScene" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.6)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/VO/Melinoe_1868" })
	waitUnmodified(0.4)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.8)
	PlaySound({ Name = "/VO/Moros_0573" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutterInScene" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CobwebClear" })
	waitUnmodified(1.2)

	local melTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId })
	local nemTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Nemesis_01" }) })

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = nemTarget })
	Teleport({ Id = source.ObjectId, DestinationId = melTarget })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	waitUnmodified(0.5)
end

function BecomingCloserNemesisPresentation( source, args )

	waitUnmodified(3)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/MaskUnlatch1" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/MaskUnlatch2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/MaskUnlatch1" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/MaskUnlatch2" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/MaskUnlatch1" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/SFX/ArmorIdleSFX" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/World Sounds/Unmask" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Nemesis_0360" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustle" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Melinoe_1951" })

	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustle" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/SFX/ArmorIdleSFX2" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleSoft" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Melinoe_4415" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustle" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleSoft" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleMedium" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleSoft" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/VO/Nemesis_0365" })
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustle" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleMedium" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Melinoe_1964" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/SFX/ArmorIdleSFX" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/SFX/ArmorIdleSFX2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleMedium" })
	waitUnmodified(0.2)
	PlayVoiceLines( GlobalVoiceLines.BecomingCloserAfterLines, true )
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.6)
	PlaySound({ Name = "/VO/Melinoe_1948" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleMedium" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustle" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.7)
	PlaySound({ Name = "/VO/Melinoe_4416" })
	waitUnmodified(0.6)
	PlaySound({ Name = "/VO/Nemesis_0366" })
	waitUnmodified(1.8)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Melinoe_4414" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/SFX/ArmorIdleSFX2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Unmask" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/MaskUnlatch1" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/MaskUnlatch2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/MaskUnlatch1" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/MaskUnlatch2" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/MaskUnlatch1" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Nemesis_0370" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/SFX/ArmorIdleSFX" })

	waitUnmodified(1.8)

	local melTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId })
	local nemTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Nemesis_01" }) })

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = nemTarget })
	Teleport({ Id = source.ObjectId, DestinationId = melTarget })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	waitUnmodified(0.5)
end

function BecomingCloserIcarusPresentation( source, args )
	waitUnmodified(2)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/VO/Melinoe_4414" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/VO/Icarus_0363" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Melinoe_1961" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.5)
	PlayVoiceLines( GlobalVoiceLines.BecomingCloserAfterLines, true )
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Melinoe_1948" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutterInScene" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/VO/Icarus_0370" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.6)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/VO/Melinoe_1964" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Icarus_0368" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(0.6)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutterInScene" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/VO/Melinoe_4418" })
	waitUnmodified(0.4)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
	waitUnmodified(0.8)
	PlaySound({ Name = "/VO/Icarus_0369" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutterInScene" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/RugInteract" })
	waitUnmodified(1.2)

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 800390 })
	Teleport({ Id = source.ObjectId, DestinationId = 800389 })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	waitUnmodified(0.5)
end

function BecomingCloserErisPresentation( source, args )
	waitUnmodified(2)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusGunRunningMisc" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleSoft" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusGunRunningMisc" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustle" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusGunRunningMisc" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/SFX/WingFlapLarge" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustle" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/QuickSnap2" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/VO/Melinoe_4417" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleSoft" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Eris_0147" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustle" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleSoft" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleMedium" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/World Sounds/QuickSnap2" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleSoft" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/VO/Melinoe_4416" })
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustle" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Eris_0144" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleMedium" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleMedium" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.6)
	PlaySound({ Name = "/Leftovers/World Sounds/QuickSnap2" })
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleMedium" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/VO/Eris_0163" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/WingFlapLarge" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	waitUnmodified(0.3)
	PlaySound({ Name = "/VO/Melinoe_4412" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleLimited" })
	waitUnmodified(0.6)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleMedium" })
	waitUnmodified(0.6)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustle" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/LeavesRustleSoft" })
	waitUnmodified(0.8)
	PlaySound({ Name = "/VO/Eris_0143" })
	waitUnmodified(0.5)
	PlaySound({ Name = "/VO/Melinoe_0569" })
	waitUnmodified(0.1)
	PlaySound({ Name = "/Leftovers/SFX/WingFlapLarge" })
	waitUnmodified(0.2)
	PlaySound({ Name = "/Leftovers/SFX/WingFlapLarge" })
	waitUnmodified(1.2)

	if CoinFlip() then
		Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 800383 })
		Teleport({ Id = source.ObjectId, DestinationId = 800384 })
	else
		Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 800384 })
		Teleport({ Id = source.ObjectId, DestinationId = 800383 })
	end
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	waitUnmodified(0.5)
end
function GetRandomMelBecomingCloserSound( source, args )

	local melSounds1 =
	{
		"/VO/Melinoe_0350",
		"/VO/Melinoe_0351",
		"/VO/Melinoe_0352",
		"/VO/Melinoe_0353",
		"/VO/Melinoe_4412",
		"/VO/Melinoe_4413",
		"/VO/Melinoe_4414",
		"/VO/Melinoe_4414",
	}
	if args.melSound1 then
		return RemoveRandomValue( melSounds1 )
	end
	local melSounds2 =
	{
		"/VO/Melinoe_4416",
		"/VO/Melinoe_4418",
		"/VO/Melinoe_1963",
		"/VO/Melinoe_1964",
		"/VO/Melinoe_1965",
	}
	if args.melSound2 then
		return RemoveRandomValue( melSounds1 )
	end

end

GlobalVoiceLines.HypnosDreamReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp01" },
			},
		},
		{ Cue = "/VO/Melinoe_3687", Text = "The dream's collapsing... no, wait, {#Emph}please!" },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp02" },
			},
		},
		{ Cue = "/VO/Melinoe_4649", Text = "His brother Thanatos... oh, blast, the dream's collapsing again... {#Emph}no..." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		Source = { LineHistoryName = "NPC_Hypnos_01", SubtitleColor = Color.HypnosVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp03" },
			},
		},

		{ Cue = "/VO/Hypnos_0041", Text = "{#Emph}<Gasp> Whuh? Waaaaaaaaaaaaaa!" },
	},
}

GlobalVoiceLines.HypnosDream01StartVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.05,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp02" },
			},
		},
		{
			Source = { LineHistoryName = "NPC_Hypnos_01", SubtitleColor = Color.HypnosVoice },

			{ Cue = "/VO/Hypnos_0020", Text = "{#Emph}<Inhale> <Cough>" },
		},
		{
			PreLineWait = 0.25,
			UsePlayerSource = true,
			BreakIfPlayed = true,
			{ Cue = "/VO/Melinoe_4639", Text = "The same dream as before... he's truly stuck..." },
		},
	},
	{
		PlayOnce = true,
		PreLineWait = 0.05,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp03" },
			},
		},
		{
			Source = { LineHistoryName = "NPC_Hypnos_01", SubtitleColor = Color.HypnosVoice },

			{ Cue = "/VO/Hypnos_0031", Text = "{#Emph}<Inhale> <Cough>" },
		},
		{
			PreLineWait = 0.25,
			UsePlayerSource = true,
			BreakIfPlayed = true,
			{ Cue = "/VO/Melinoe_4708", Text = "Still dreaming of this place of course." },
		},
	},

}

function HypnosDream01StartPresentation( source, args )
	args = args or {}

	SessionState.InDreamSequence = true

	waitUnmodified( 0.5 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedBeowulfStrings", Delay = 0.3 })
	FullScreenFadeOutAnimation()
	EstablishConversationStartingPoint( source, { HeroOnly = true } )
	if CurrentRun.TextLinesRecord.HypnosWakeUp02 then
		HypnosPointRefundPresentation()
	end
	if CurrentRun.TextLinesRecord.HypnosWakeUp03 then
		HypnosPointRefundPresentation()
	end

	thread( PlayVoiceLines, GlobalVoiceLines.HypnosDream01StartVoiceLines )

	StopSound({ Id = AudioState.AmbienceId, Duration = 0.5 })
	AudioState.AmbienceId = nil
	AudioState.AmbienceName = nil

	waitUnmodified( 1.5 )

	local biomeStateData = BiomeStateData.BiomeStates[GameState.NextBiomeStateName]
	if biomeStateData ~= nil then
		DimRainPresentation()
	end

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 738932 })

	-- thread( PlayDreamScreenEffects )
	SetAudioEffectState({ Name = "Reverb", Value = -1.0 })
	SetAudioEffectState({ Name = "GlobalEcho", Value = 0.5 })

	AudioState.AmbienceId = PlaySound({ Name = "/Ambience/RemembranceScreenAmbience2", Duration = 0.5 })

	local dreamHypnosId = 738827
	Activate({ Id = dreamHypnosId })
	local dreamHypnos01 = DeepCopyTable( EnemyData.NPC_Hypnos_02 )
	dreamHypnos01.ObjectId = dreamHypnosId
	SetupUnit( dreamHypnos01, CurrentRun, { IgnoreAI = true, IgnorePackages = true } )
	CheckConversations( dreamHypnos01 )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = dreamHypnosId })

	ClearCameraClamp({ LerpTime = 0 })
	SetCameraZoomWeight({ Id = 738929, Weight = 1.45, ZoomSpeed = 1.0 })
	SetCameraZoomWeight({ Id = 740440, Weight = 0.20, ZoomSpeed = 1.0 })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })

	for fromSound, toSound in pairs( GameData.DreamSequenceData.SwapSounds ) do
		SwapSound({ Name = fromSound, DestinationName = toSound })
	end

	--SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelTalkFlustered01" })

	waitUnmodified( 0.8 )

	FullScreenFadeInAnimation()

	waitUnmodified( 1.5 )

end

GlobalVoiceLines.HypnosDream02StartVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 0.05,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp02" },
			},
		},
		{
			Source = { LineHistoryName = "NPC_Hypnos_01", SubtitleColor = Color.HypnosVoice },

			{ Cue = "/VO/Hypnos_0024", Text = "{#Emph}<Inhale> <Cough>" },
		},
		{
			PreLineWait = 0.25,
			UsePlayerSource = true,
			{ Cue = "/VO/Melinoe_4643", Text = "What, this is... quite comfortable really..." },
		},
	},
	{
		PlayOnce = true,
		PreLineWait = 0.05,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp03" },
			},
		},
		{
			Source = { LineHistoryName = "NPC_Hypnos_01", SubtitleColor = Color.HypnosVoice },

			{ Cue = "/VO/Hypnos_0034", Text = "{#Emph}Zzz... <Cough> <Cough> <Cough>" },
		},
		{
			PreLineWait = 0.35,
			UsePlayerSource = true,
			{ Cue = "/VO/Melinoe_4712", Text = "{#Emph}Mm{#Prev}, I suppose I can see why he may wish to remain here." },
		},
	},
	{
		PlayOnce = true,
		PreLineWait = 0.05,
		PlayOverTextLines = true,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp03_C" },
			},
		},
		{
			Source = { LineHistoryName = "NPC_Hypnos_01", SubtitleColor = Color.HypnosVoice },

			{ Cue = "/VO/Hypnos_0037", Text = "{#Emph}<Snort> Unnggghh..." },
		},
	}
}
function HypnosDream02StartPresentation( source, args )
	args = args or {}
	SetAlpha({ Id = 799402, Fraction = 0, Duration = 0 })
	SetAlpha({ Id = 799734, Fraction = 0, Duration = 0 })
	SetAlpha({ Id = 799409, Fraction = 0, Duration = 0 })
	SetAlpha({ Id = 799735, Fraction = 0, Duration = 0 })
	
	CreateGroup({ Name = "DiscoBall" })
	InsertGroupInFront({ Name = "DiscoBall", DestinationName ="Combat_UI"})

	CreateGroup({ Name = "DiscoBallAdditive", BlendMode = "Additive" })
	InsertGroupInFront({ Name = "DiscoBallAdditive", DestinationName = "DiscoBall" })
	
	local ball = SpawnObstacle({ Name = "3DDiscoBall_SkipEncounter", DestinationId = 799402, Group = "DiscoBall" })
	local chain = SpawnObstacle({ Name = "OlympusCeilingChain01", DestinationId = 799409, Group = "DiscoBall" })
	
	SetScale({ Id = chain, Fraction = 0.51 })
	Attach({ Id = chain, DestinationId = ball, OffsetY = -97 })

	waitUnmodified( 0.5 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedBeowulfStrings", Delay = 0.3 })
	FullScreenFadeOutAnimation()
	if CurrentRun.TextLinesRecord.HypnosWakeUp03 then
		HypnosPointRefundPresentation()
	end

	StopSound({ Id = SessionMapState.HadesThemeId, Duration = 0.2 })
	SecretMusicPlayer( "/Music/HypnosLullaby" )

	thread( PlayVoiceLines, GlobalVoiceLines.HypnosDream02StartVoiceLines )

	waitUnmodified( 1.5 )

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 780969 })
	-- Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 780708 })

	local dreamHypnosId = 780928
	-- local dreamHypnosId = 780555
	Activate({ Id = dreamHypnosId })
	local dreamHypnos01 = DeepCopyTable( EnemyData.NPC_Hypnos_03 )
	-- local dreamHypnos01 = DeepCopyTable( EnemyData.NPC_Hypnos_04 )
	dreamHypnos01.ObjectId = dreamHypnosId
	SetupUnit( dreamHypnos01, CurrentRun, { IgnoreAI = true, IgnorePackages = true } )
	CheckConversations( dreamHypnos01 )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 799471 })

	ClearCameraClamp({ LerpTime = 0 })
	-- SetCameraZoomWeight({ Id = 738929, Weight = 1.45, ZoomSpeed = 1.0 })
	-- SetCameraZoomWeight({ Id = 740440, Weight = 0.20, ZoomSpeed = 1.0 })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })

	--SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelTalkFlustered01" })

	waitUnmodified( 0.8 )

	FullScreenFadeInAnimation()

	waitUnmodified( 1.5 )

end

function HypnosDream03StartPresentation( source, args )
	args = args or {}

	waitUnmodified( 0.5 )

	SetSoundCueValue({ Names = { "Weird" }, Id = AudioState.SecretMusicId, Value = 1 })
	StopSecretMusic( true )

	StopSound({ Id = AudioState.AmbienceId, Duration = 0.5 })
	AudioState.AmbienceId = nil
	AudioState.AmbienceName = nil

	AudioState.AmbienceId = PlaySound({ Name = "/Leftovers/Object Ambiences/ChimesAmbientLoop_StarMap", Duration = 0.5 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedBeowulfStrings", Delay = 0.3 })
	FullScreenFadeOutAnimation()

	waitUnmodified( 1.5 )

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 780960 })

	local dreamHypnosId = 780902
	Activate({ Id = dreamHypnosId })
	local dreamHypnos01 = DeepCopyTable( EnemyData.NPC_Hypnos_04 )
	dreamHypnos01.ObjectId = dreamHypnosId
	SetupUnit( dreamHypnos01, CurrentRun, { IgnoreAI = true, IgnorePackages = true } )
	CheckConversations( dreamHypnos01 )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = dreamHypnosId })

	ClearCameraClamp({ LerpTime = 0 })
	-- SetCameraZoomWeight({ Id = 738929, Weight = 1.45, ZoomSpeed = 1.0 })
	-- SetCameraZoomWeight({ Id = 740440, Weight = 0.20, ZoomSpeed = 1.0 })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })

	--SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelTalkFlustered01" })

	waitUnmodified( 0.8 )

	FullScreenFadeInAnimation()

	waitUnmodified( 1.5 )

end

function HypnosDream01EndPresentation( source, args )
	args = args or {}

	SetSoundCueValue({ Names = { "Weird" }, Id = AudioState.SecretMusicId, Value = 1 })
	StopSecretMusic( true )

	PlaySound({ Name = "/Leftovers/Object Ambiences/ThunderOneShot" })

	ShakeScreen({ Speed = 150, Distance = 6, Duration = 3.0, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.3, Duration = 1.8 }, } )

	wait(0.3)
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })

	thread( FullScreenFadeOutAnimation )

	StopSound({ Id = AudioState.AmbienceId, Duration = 0.5 })
	AudioState.AmbienceId = nil
	AudioState.AmbienceName = nil

	thread( PlayVoiceLines, GlobalVoiceLines.HypnosDreamReactionVoiceLines )
	wait(1.4)
	PlaySound({ Name = "/SFX/WindGust" })

	local hypnosId = 370024
	if args.WakeUp then
		SetAnimation({ DestinationId = hypnosId, Name = "Hypnos_Sleep_Idle_Silent_NoZs" })
	end

	waitUnmodified( args.WaitTime or 2.8 )

	-- reset camera zoom weights
	SetCameraZoomWeight({ Id = 738929, Weight = 1.0, ZoomSpeed = 1.0 })
	SetCameraZoomWeight({ Id = 740440, Weight = 1.0, ZoomSpeed = 1.0 })

	AudioState.AmbienceId = PlaySound({ Name = "/Ambience/RunstartIntroAmbience", Duration = 0.5 })
	StopSound({ Id = SessionMapState.HadesThemeId, Duration = 0.2 })

	for fromSound, toSound in pairs( GameData.DreamSequenceData.SwapSounds ) do
		SwapSound({ Name = toSound, DestinationName = fromSound })
	end

	local biomeStateData = BiomeStateData.BiomeStates[GameState.NextBiomeStateName]
	if biomeStateData ~= nil then
		UnDimRainPresentation()
	end

	local ticks = GameData.PostDreamArgs.LuaValue.TimerTicks
	GardenTimeTick( { Ticks = ticks, UpdatePlotPresentation = true, PanDuration = 0.0, SkipCameraPan = true, SkipSound = true, TickInterval = 0.0 } )
	CookTimeTick( { Ticks = ticks, UpdatePresentation = true, TickInterval = 0.0, } )
	MailboxTimeTick( { Ticks = ticks, UpdatePresentation = true, TickInterval = 0.0, } )

	TeleportToConversationStartingPoint( source, { HeroOnly = true, AngleHeroTowardTargetId = hypnosId } )

	waitUnmodified( 1.0 )
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelTalkPensive01" })
	waitUnmodified( 0.5 )

	SessionState.InDreamSequence = false

	SetAudioEffectState({ Name = "Reverb", Value = 0.4 })
	SetAudioEffectState({ Name = "GlobalEcho", Value = 0.0 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	-- FadeIn({ Duration = 2.0 })
	FullScreenFadeInAnimation()
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	waitUnmodified( 2.0 )
end

function PlayHadesTheme( source, args )
	args = args or {}
	SessionMapState.HadesThemeId = PlaySound({ Name = "/Music/MusicPlayer/HadesThemeMusicPlayer" })
end

function EstablishConversationStartingPoint( source, args )
	args = args or {}
	if not args.HeroOnly then
		MapState.ConversationStartPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = source.ObjectId })
		source.SuppressTrackPlayer = true
	end
	MapState.HeroConversationStartPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId })
end

function TeleportToConversationStartingPoint( source, args )
	args = args or {}

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.TeleportHeroToId or MapState.HeroConversationStartPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.AngleHeroTowardTargetId or MapState.ConversationStartPointId })
	Destroy({ Id = MapState.HeroConversationStartPointId })

	if not args.HeroOnly then
		Teleport({ Id = source.ObjectId, DestinationId = args.TeleportToId or MapState.ConversationStartPointId })
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = args.AngleTowardTargetId or MapState.HeroConversationStartPointId, CompleteAngle = true })
		Destroy({ Id = MapState.ConversationStartPointId })
		source.SuppressTrackPlayer = nil
	end

	MapState.HeroConversationStartPointId = nil
	MapState.ConversationStartPointId = nil

	local cameraClamps = CurrentHubRoom.CameraClamps or GetDefaultClampIds()
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })
end

function LockedSurfaceRunPresentation( usee, args )
	args = args or {}
	if CheckCooldown( "LockedSurfaceDoorUsed", 2.0 ) then
		thread( RepulseFromObject, usee, { Text = "Hint_SurfaceRunDoorLocked", OffsetZ = -100, OffsetX = -0, ShadowScaleX = 1.3, Scale = 2.0, UseAngleBetween = true })
		PlaySound({ Name = "/Leftovers/SFX/PlayerKilled_Small", Id = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/SFX/WrathOver2" })
	end
	thread( PlayVoiceLines, args.VoiceLines or GlobalVoiceLines.WardedDoorVoiceLines, true )

end

function SetFixedDashPresentationValues()
	SessionState.BlinkChargeDuration = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponBlink", Property = "ChargeTime" })
	local slowedBlinkSpeed = 0.15
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeTime", Value = slowedBlinkSpeed })
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeTimeRemaining", Value = slowedBlinkSpeed, ValueChangeType = "Absolute", DataValue = false })
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeFx", Value = "MelBlinkCharge", })
end

function EndFixedDashPresentationValues()
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeTime", Value = SessionState.BlinkChargeDuration })
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeTimeRemaining", Value = SessionState.BlinkChargeDuration, ValueChangeType = "Absolute", DataValue = false })
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeFx", Value = nil, })
	SessionState.BlinkChargeDuration = nil
end

function StartNewRunPresentation( runDoor, args )
	LockCamera({ Id = runDoor.ObjectId, Duration = 1.3, Retarget = true })
	SetAngle({ Id = CurrentRun.Hero.ObjectId, Angle = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.DashTarget or runDoor.ObjectId }), CompleteAngle = true })
	if MapState.FamiliarUnit ~= nil then
		local familiar = MapState.FamiliarUnit
		if familiar.StartNewRunFunctionName ~= nil then
			thread( CallFunctionName, familiar.StartNewRunFunctionName, familiar, args )
		else
			SetAnimation({ DestinationId = familiar.ObjectId, Name = familiar.StartNewRunAnimation })
		end
	end
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
	SetFixedDashPresentationValues()
	FireWeaponFromUnit({ Weapon = "WeaponBlink", Id = CurrentRun.Hero.ObjectId })
	killTaggedThreads( "SpawnSkelly" )
	local skellyId = GetIdsByType({ Name = "NPC_Skelly_01" })[1]
	if skellyId ~= nil then
		killTaggedThreads( "Activating"..skellyId )
	end
	killTaggedThreads( "SkellySpawnVoiceLines" )
	thread( PlayVoiceLines, GlobalVoiceLines[args.GlobalVoiceLines] or GlobalVoiceLines.StartNewRunVoiceLines )
	wait(0.1)
	FadeOut({ Duration = 0.3, Color = Color.Black })
	EndMusic( AudioState.MusicId, AudioState.MusicName, 0.5 )
	EndAmbience( 0.5 )
	wait(0.3)
	EndFixedDashPresentationValues()
end

function TentEnterPresentation( source, args )
	if SessionMapState.InTent then
		return
	end
	args = args or {}
	SessionMapState.InTent = true
	SetAlpha({ Ids = GetIds({ Name = "MainDimmer_01" }), Fraction = 1.0, Duration = 0.3 })
	SetAlpha({ Ids = GetIds({ Name = "TentDimmer_01" }), Fraction = 0.0, Duration = 0.3 })
	SetAlpha({ Ids = GetIds({ Name = "TentIntroDimmer_01" }), Fraction = 0.0, Duration = 0.3 })
	SetAudioEffectState({ Name = "Reverb", Value = -1.0 })
	if AudioState.AmbienceId ~= nil then
		SetSoundCueValue({ Name = "Tent", Value = 1.0, Id = AudioState.AmbienceId, Duration = 0.7 })
	end
	if AudioState.AmbientMusicId ~= nil then
		UpdateAmbientMusicParameters( { Params = CurrentHubRoom.AmbientMusicParamsInTent, Duration = args.AmbientMusicParamsDuration or 0.7 } )
	end
	if GameState.NextBiomeStateName ~= nil then
		local biomeStateData = BiomeStateData.BiomeStates[GameState.NextBiomeStateName]
		if biomeStateData ~= nil then
			CallFunctionName( biomeStateData.DimPresentationFunctionName, args )
		end
	end

	-- Move Dora to Tent
	SessionMapState.OnWestSide = false
	killTaggedThreads( "DoraTeleportHub" )
	DoraTeleportHub( { DestinationId = 583650, CategoryIndex = 1 } )
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
	if AudioState.AmbientMusicId ~= nil then
		UpdateAmbientMusicParameters( { Duration = 0.7 } )
	end
	if GameState.NextBiomeStateName ~= nil then
		local biomeStateData = BiomeStateData.BiomeStates[GameState.NextBiomeStateName]
		if biomeStateData ~= nil then
			CallFunctionName( biomeStateData.UnDimPresentationFunctionName, args )
		end
	end

	-- Move Dora to Main
	killTaggedThreads( "DoraTeleportHub" )
	DoraTeleportHub( { DestinationId = 560665, CategoryIndex = 2 } )
end

function OncePerRunTentExitPresentation( eventSource, args )
	thread( DisplayInfoBanner, eventSource, args.DisplayInfoBannerArgs )
	waitUnmodified( args.CheckCodexDelay )
	CheckCodexUnlock( "Biomes", "Hub" )
	CheckCodexUnlock( "OtherDenizens", "NPC_Chronos_01" )
end

function HubWestSideEnterPresentation( eventSource, args )
	if SessionMapState.OnWestSide then
		return
	end
	SessionMapState.OnWestSide = true
	if GameState.WorldUpgrades.WorldUpgradeTaverna then
		-- Move Dora to Taverna
		DoraTeleportHub( { DestinationId = 742268, CategoryIndex = 3 } )
	end
end

function HubEastSideEnterPresentation( eventSource, args )
	if not SessionMapState.OnWestSide then
		return
	end
	SessionMapState.OnWestSide = false
	if GameState.WorldUpgrades.WorldUpgradeTaverna then
		-- Move Dora to Main
		DoraTeleportHub( { DestinationId = 560665, CategoryIndex = 2 } )
	end
end

function AltarEnterPresentation( eventSource, args )
	SetAlpha({ Ids = GetIds({ Name = "Logic_AltarProximity" }), Fraction = 1.0, Duration = 0.3, EaseIn = 0, EaseOut = 1 })
	PlaySound({ Name = "/Leftovers/SFX/AuraOn", Id = GetIds({ Name = "Logic_AltarProximity" }), })
	SessionMapState.AltarEnterPresentation = true
end

function AltarExitPresentation( eventSource, args )
	SetAlpha({ Ids = GetIds({ Name = "Logic_AltarProximity" }), Fraction = 0.0, Duration = 0.5, EaseIn = 0, EaseOut = 1 })
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
GlobalVoiceLines.PetCerberusVoiceLines =
{
	{
		PreLineWait = 0.65,
		RandomRemaining = true,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeCerberusPetSpeech", Time = 10 },
		},

		{ Cue = "/VO/MelinoeField_3891", Text = "There's a good boy..." },
		{ Cue = "/VO/MelinoeField_3892", Text = "You like that, don't you...?" },
		{ Cue = "/VO/MelinoeField_3893", Text = "You know me now, don't you?" },
		{ Cue = "/VO/MelinoeField_3894", Text = "Just this one head, I know..." },
		{ Cue = "/VO/MelinoeField_3895", Text = "Don't snap my head off, boy..." },
		{ Cue = "/VO/MelinoeField_3896", Text = "You're a fine dog.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_3899", Text = "There you go..." },
		{ Cue = "/VO/MelinoeField_3900", Text = "Let me get that for you..." },
		{ Cue = "/VO/MelinoeField_3898", Text = "Calmed down since the Fields have you?",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Story01" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3897", Text = "Now don't be jealous, Hecuba.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "HoundFamiliar" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Story01" },
				},
			},
		},
	},
	{
		PreLineWait = 0.65,
		RandomRemaining = true,
		BreakIfPlayed = true,
		ObjectTypes = { "NPC_Hades_02", "NPC_Hades_Field_01" },
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_Story01" },
			},
		},
		Cooldowns =
		{
			{ Name = "HadesSpokeRecently", Time = 8 },
			{ Name = "HadesCerberusPetSpeech", Time = 12 },
		},
		{ Cue = "/VO/Hades_0336", Text = "Correct technique.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3891" },
				},
			},
		},
		{ Cue = "/VO/Hades_0337", Text = "He tolerates it.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3892" },
				},
			},
		},
		{ Cue = "/VO/Hades_0338", Text = "He does.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3893" },
				},
			},
		},
		{ Cue = "/VO/Hades_0339", Text = "An important rule.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3894" },
				},
			},
		},
		{ Cue = "/VO/Hades_0340", Text = "Heed her, Cerberus.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3895" },
				},
			},
		},
		{ Cue = "/VO/Hades_0341", Text = "He is aware.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3896" },
				},
			},
		},
		{ Cue = "/VO/Hades_0342", Text = "He got his exercise.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3898" },
				},
			},
		},
		{ Cue = "/VO/Hades_0343", Text = "Such attention for this dog.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3899" },
				},
			},
		},
		{ Cue = "/VO/Hades_0344", Text = "He is amenable.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3900" },
				},
			},
		},
	},
	{
		PreLineWait = 0.65,
		RandomRemaining = true,
		BreakIfPlayed = true,
		ObjectType = "NPC_Persephone_01",
		Cooldowns =
		{
			{ Name = "PersephoneSpokeRecently", Time = 8 },
			{ Name = "PersephoneCerberusPetSpeech", Time = 12 },
		},

		{ Cue = "/VO/Persephone_0040", Text = "Isn't he?",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3891" },
				},
			},
		},
		{ Cue = "/VO/Persephone_0041", Text = "I think he does.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3892" },
				},
			},
		},
		{ Cue = "/VO/Persephone_0042", Text = "He remembers.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3893" },
				},
			},
		},
		{ Cue = "/VO/Persephone_0043", Text = "Careful now...",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3894" },
				},
			},
		},
		{ Cue = "/VO/Persephone_0044", Text = "He probably won't.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3895" },
				},
			},
		},
		{ Cue = "/VO/Persephone_0045", Text = "The very best.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3896" },
				},
			},
		},
		{ Cue = "/VO/Persephone_0046", Text = "She's all right.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3897" },
				},
			},
		},
		{ Cue = "/VO/Persephone_0047", Text = "He's resting up.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3898" },
				},
			},
		},
		{ Cue = "/VO/Persephone_0048", Text = "Good boy, Cerberus.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3899" },
				},
			},
		},
		{ Cue = "/VO/Persephone_0049", Text = "That's the way.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_3900" },
				},
			},
		},
	}
}

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

	PanCamera({ Ids = weaponKit.ObjectId, Duration = 5, EaseIn = 0.05, EaseOut = 0.03 })

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
	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = 558175 })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	CreateAnimation({ Name = "CauldronCastGlow", DestinationId = 558175 })
	CreateAnimation({ Name = args.CauldronCastFxAnimation or "CauldronSmokeLarge", DestinationId = 558175, Group  = args.CauldronFxGroup or "Combat_Menu_Overlay" })
	CreateAnimation({ Name = args.CauldronVignetteAnimation or "CauldronFullscreenDarken", UseScreenLocation = true, OffsetX = ScreenCenterX * 0.5, OffsetY = ScreenCenterY * 0.5, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY, Group  = "Combat_Menu" })

	local interactVignette = CreateAnimation({ Name = "CauldronCastVignette", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
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

	AdjustColorGrading({ Name = "Thanatos", Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "CauldronCastBloom", Duration = 0.2 })
	ShakeScreen({ Speed = 800, Distance = 3, FalloffSpeed = 5000, Duration = 1.3 })
	thread( DoRumble, { { ScreenPreWait = 0.1, LeftFraction = 0.17, Duration = 1.4 }, } )

	wait( 1.1 )

	AdjustColorGrading({ Name = "Off", Duration = 1.8 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.8 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 1.45 })
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
	if args.SoundName ~= nil then
		PlaySound({ Name = args.SoundName, Id = usee.ObjectId })
	end
	thread( PlayVoiceLines, HeroVoiceLines[args.VoiceLines] or HeroVoiceLines.LockedQuestLogVoiceLines, true )
	if args.CannotUseText ~= nil then
		thread( InCombatText, CurrentRun.Hero.ObjectId, usee.CannotUseText, 1 )
	end
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
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlayAll = 0.33,

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
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,

		{ Cue = "/VO/Melinoe_3776", Text = "Who's a good girl?" },
		{ Cue = "/VO/Melinoe_3777", Text = "You're a good girl." },
		{ Cue = "/VO/Melinoe_3778", Text = "Headmistress raised you well." },
		{ Cue = "/VO/Melinoe_3779", Text = "You're all right." },
		{ Cue = "/VO/Melinoe_3780", Text = "Good girl, Hecuba." },
		{ Cue = "/VO/Melinoe_3781", Text = "Hail Hecuba." },
	},
}

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
	source.SetupEvents = nil

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

	SetAnimation({ Name = "Hecate_Hub_Explaining_Start", DestinationId = leadParticipant.ObjectId })

	local randomVoiceLines = GetRandomValue( leadParticipant.CauldronWitchcraftVoiceLines )
	PlayVoiceLines( randomVoiceLines, true, leadParticipant )

	source.UseText = nil
	source.OnUsedFunctionName = nil
	UseableOff({ Id = source.ObjectId })

	wait( 1.0 )

	SetAnimation({ Name = "Hecate_Hub_Explaining_End", DestinationId = leadParticipant.ObjectId })


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
function CauldronCastingVoiceLines( source, args )
	PlayVoiceLines( args.VoiceLines, true )
end

function UseArtemisJoinSong( usee, args )
	local user = CurrentRun.Hero
	if CurrentRun.Hero.JoinedInArtemisSong then
		CurrentRun.Hero.JoinedInArtemisSong = false
		SetSoundCueValue({ Id = AudioState.AmbientMusicId, Names = { "Vocals2" }, Value = 0.0, Duration = 0.2 })
		SetAnimation({ Name = "Melinoe_Singing_End", DestinationId = user.ObjectId })
		StopAnimation({ DestinationId = user.ObjectId, Name = "StatusSinging" })
		UnfreezePlayerUnit( "ArtemisSong" )
		AddInteractBlock( usee, "ArtemisSongLeft" )
		thread( PlayVoiceLines, HeroVoiceLines.StoppedSingingVoiceLines, true, usee )
		wait( 1.0 )
		RemoveInteractBlock( usee, "ArtemisSongLeft" )
		OverwriteSelf( usee, usee.SingingOverwriteSelf )
		RefreshUseButton( usee.ObjectId, usee )
	else
		AddInputBlock({ Name = "ArtemisSongJoinIn" })
		SetSoundCueValue({ Id = AudioState.AmbientMusicId, Names = { "Vocals2" }, Value = 1.0, Duration = 0.5 })
		SetAnimation({ Name = "Melinoe_Singing_Start", DestinationId = user.ObjectId })
		CreateAnimation({ Name = "StatusSinging", DestinationId = user.ObjectId, OffsetX = -40, OffsetY = -120, OffsetZ = 120 })
		AngleTowardTarget({ Id = user.ObjectId, DestinationId = usee.ObjectId })
		CurrentRun.Hero.JoinedInArtemisSong = true
		thread( PlayVoiceLines, usee.SingingReactionVoiceLines, true, usee )
		wait( 1.0 )
		RemoveInputBlock({ Name = "ArtemisSongJoinIn" })
		FreezePlayerUnit( "ArtemisSong", { AllowedKeys = { "SpecialInteract" } }  )
		usee.UseTextTalkAndSpecial = "ArtemisSingingLeave"
		usee.UseTextSpecial = "ArtemisSingingLeave"
	end
end

function GhostEavesdroppers( source, args )
	local randomGroup = GetRandomValue( args.RandomGroups )
	if randomGroup ~= nil then
		Activate({ Ids = randomGroup })
		if (CurrentRun.SpecialInteractRecord[args.InspectPoint.Name] or 0) <= 0 then
			local randomGhostId = GetRandomValue( randomGroup )
			local inspectPoint = DeepCopyTable( args.InspectPoint )
			local inspectPointId = SpawnObstacle({ Name = inspectPoint.Name, DestinationId = randomGhostId, OffsetZ = 90 })
			inspectPoint.ObjectId = inspectPointId
			AttachLua({ Id = inspectPointId, Table = inspectPoint })
			CurrentRun.NumGhostGroupsActive = (CurrentRun.NumGhostGroupsActive or 0) + 1
		end
	end
end

function UseGhostEavesdropper( usee, args, user )
	AddInputBlock({ Name = "SpecialInteractShade" })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	-- PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.ShadeEavesdropVoiceLines, true, usee )
	-- emotes handled in ShadeEavesdropVoiceLines =

	wait( 0.3 )

	-- Need to convert to proper named entries and too much data to re-write
	local randomLines = {}
	for i, line in ipairs( usee.RandomLines ) do
		randomLines[line.Name] = line
	end

	local randomLine = GetRandomEligiblePrioritizedItem( randomLines, nil, GameState.PlayedGhostEavesdroppers, GameState.RemainingGhostEavesdroppers )
	local dialogueBackgroundId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = usee.ObjectId, OffsetY = -325, OffsetX = 80, Group = "Combat_Menu" })
	if randomLine ~= nil then
		GameState.PlayedGhostEavesdroppers[randomLine.Name] = true

		SetAnimation({ DestinationId = dialogueBackgroundId, Name = "GhostEavesdropperDialogue" })
		CreateTextBox({ Id = dialogueBackgroundId,
			Text = randomLine.Name,
			OffsetX = -210,
			OffsetY = -25,
			Font = "LatoItalic",
			FontSize = 17,
			Justification = "Left",
			Width = 420,
			Color = Color.White,
			UseDescription = true,
			LuaKey = "TempTextData",
			LuaValue = usee,
			})
		CreateTextBox({ Id = dialogueBackgroundId,
			Text = randomLine.Name,
			OffsetY = 58,
			Font = "LatoMedium",
			FontSize = 17,
			Justification = "Center",
			Width = 375,
			Color = Color.White,
			LuaKey = "TempTextData",
			LuaValue = usee,
			})
	end

	SetAlpha({ Id = usee.ObjectId, Fraction = 0.0, Duration = 0.4 })
	UseableOff({ Id = usee.ObjectId })

	local soundNames =
	{
		"/SFX/GhostEmotes/Disgruntled",
		"/SFX/GhostEmotes/DisgruntledLARGE",
		"/SFX/GhostEmotes/DisgruntledSMALL",
		"/SFX/GhostEmotes/DisgruntledTiny",
		"/SFX/GhostEmotes/Embarrassed",
		"/SFX/GhostEmotes/EmbarrassedLARGE",
		"/SFX/GhostEmotes/EmbarrassedSMALL",
		"/SFX/GhostEmotes/EmbarrassedTINY",
		"/SFX/GhostEmotes/Fear",
		"/SFX/GhostEmotes/FearLARGE",
		"/SFX/GhostEmotes/FearSMALL",
		"/SFX/GhostEmotes/FearTINY",
		"/SFX/GhostEmotes/Grief",
		"/SFX/GhostEmotes/GriefLARGE",
		"/SFX/GhostEmotes/GriefSMALL",
		"/SFX/GhostEmotes/GriefTINY",
		"/SFX/GhostEmotes/Smile",
		"/SFX/GhostEmotes/SmileLARGE",
		"/SFX/GhostEmotes/SmileSMALL",
		"/SFX/GhostEmotes/SmileTINY",
	}
	local soundName = RemoveRandomValue( soundNames )
	PlaySound({ Name = soundName, Id = usee.ObjectId, Delay = 0.3 })

	local animationNames =
	{
		"StatusIconSmile",
		"StatusIconOhBoy",
		"StatusIconEmbarrassed",
		-- "StatusIconDetermined",
		"StatusIconVictory",
	}
	local animationName = RemoveRandomValue( animationNames )
	thread( PlayEmoteSimple, usee, { AnimationName = animationName, OffsetZ = -50, Delay = 1.08 } )

	wait( 1.25 )
	RemoveInputBlock({ Name = "SpecialInteractShade" })

	local notifyName = "UseGhostEavesdropper"
	NotifyOutsideDistanceAll({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId, Distance = 300, Notify = notifyName })
	waitUntil( notifyName )
	wait( 0.5 )
	SetAlpha({ Id = dialogueBackgroundId, Fraction = 0.0, Duration = 0.2 })

end

function UseExorcisedGhostsPreRun( usee, args, user )

	AddInputBlock({ Name = "SpecialInteractExorcisedGhost" })
	CurrentRun.UseExorcisedGhostsPreRun = true

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.ShadeEavesdropVoiceLines, true, usee )
	-- emotes handled in ShadeEavesdropVoiceLines =

	SetAlpha({ Id = usee.ObjectId, Fraction = 0.0, Duration = 0.4 })
	UseableOff({ Id = usee.ObjectId })

	SetAnimation({ Name = GetEquippedWeaponValue( "UnequipAnimation" ) or "MelinoeIdleWeaponless", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 0.55 )
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 1.25 )
	RemoveInputBlock({ Name = "SpecialInteractExorcisedGhost" })

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
		SetThingProperty({ DestinationId = spawnId, Property = "SortMode", Value = "Secondary" })
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
			PlayEmoteSimple( ghost, { AnimationName = "StatusIconOhBoy", ChanceToPlay = 0.75, OffsetZ = ghost.EmoteOffsetZ } )
			PlaySound({ Name = "/SFX/GhostEmotes/EmbarrassedTINY", Id = ghost.ObjectId })
		else
			PlayEmoteSimple( ghost, { AnimationName = "StatusIconSmile", ChanceToPlay = 0.75, OffsetZ = ghost.EmoteOffsetZ } )
			PlaySound({ Name = "/SFX/GhostEmotes/SmileTINY", Id = ghost.ObjectId })
		end
	end

	-- moved to DeathLoopData
	-- thread( PlayVoiceLines, HeroVoiceLines.GhostTrainVoiceLines, true )

end

function GhostFollowerLoseAggroPresentation( ghost, args )

	if CheckCooldown( "GhostLostAggroRecently", 60 ) then
		if CoinFlip() then
			PlayEmoteSimple( ghost, { AnimationName = "StatusIconEmbarrassed", ChanceToPlay = 0.25, OffsetZ = ghost.EmoteOffsetZ } )
			PlaySound({ Name = "/SFX/GhostEmotes/DisgruntledTINY", Id = ghost.ObjectId })
		else
			PlayEmoteSimple( ghost, { AnimationName = "StatusIconSmile", ChanceToPlay = 0.25, OffsetZ = ghost.EmoteOffsetZ } )
			PlaySound({ Name = "/SFX/GhostEmotes/GriefTINY", Id = ghost.ObjectId })
		end
	end

end

-- Hades Fountain
function UseHadesFountain( usee, args )
	args = args or {}
	AddInputBlock({ Name = "SpecialInteractFountain" })
	HideUseButton( usee.ObjectId, usee )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.FountainPrayerVoiceLines, true, usee )

	wait( 1.25 )
	RemoveInputBlock({ Name = "SpecialInteractFountain" })
end

function UseSunMoonTimeSculpture( usee, args )
	args = args or {}
	AddInputBlock({ Name = "UseSunMoonTimeSculpture" })
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.AdmireOlympusStatueVoiceLines, true, usee )
	wait( 1.45 )
	RemoveInputBlock({ Name = "UseSunMoonTimeSculpture" })
	wait( 30.75, RoomThreadName )
	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
		if args.LinkedIds ~= nil then
			UseableOn({ Ids = args.LinkedIds })
		end
	end
end

function OdysseusArriveAtTable( source, args, node )
	Stop({ Id = source.ObjectId })
	wait( 1.0, source.AIThreadName )
	if GetDistance({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) < args.GreetDistance and CheckCooldown( "OdysseusGreet", 60 ) then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		SetAnimation({ Name = "Odysseus_Salute", DestinationId = source.ObjectId })
	end
	wait( 5.0, source.AIThreadName )
end

function OdysseusArriveAtGardenPlot( source, args, node )
	Stop({ Id = source.ObjectId })
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

function OdysseusArriveAtShade( source, args, node )
	Stop({ Id = source.ObjectId })
	wait( 1.0, source.AIThreadName )
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = node.Id })
	SetAnimation({ Name = "Odysseus_Surveying", DestinationId = source.ObjectId })

	wait( 3.0, source.AIThreadName )

	thread( PlayEmoteSimple, source, { TargetId = node.Id, AnimationName = "StatusIconSmile", })

	wait( 4.0, source.AIThreadName )
end

function OdysseusAtTaverna( source, args )
	CheckDistanceTriggerThread( source, PresetEventArgs.OdysseusFeasting )
	SessionMapState.OdysseusAtTaverna = true
	SetGoalAngle({ Id = source.ObjectId, Angle = 333 })
	SetAnimation({ Name = "Odysseus_Drinking_Idle1", DestinationId = source.ObjectId })
	for k, v in pairs( source.TavernaOverrides ) do
		source[k] = v
	end
end

function RevealTavernaPresentation( source )

	ResourceGiftedPresentation( { ResourceName = "SuperGiftPoints", SoundName = "/SFX/GiftAmbrosiaBottlePickup" } )
	ClearMapBlockers( source, { DeleteGroups = { "Taverna_Blocker", "TavernaDimmer_01" }, } )

end

function PostRevealTavernaPresentation( source )

	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteCheerfulSFX" })
	wait( 0.3 )

	local allShadeIds = GetIdsByType({ Names = { "ShadeHubIdle01", "ShadeHubSIdle01", "ShadeHubMIdle01", "ShadeHubHatIdle01", "ShadeHubBroomIdle01", "ShadeHubGarlicIdle01", "ShadeHubBerriesIdle01" } })
	local tavernaShadeIds = GetClosestIds({ Id = 586582, Distance = 1000, DestinationIds = allShadeIds })
	for i, id in ipairs( tavernaShadeIds ) do
		local emoteOffsetZ = nil
		if MapState.ActiveObstacles[id] ~= nil then
			emoteOffsetZ = MapState.ActiveObstacles[id].EmoteOffsetZ
		end
		thread( PlayEmoteSimple, nil, { TargetId = id, AnimationName = "StatusIconSmile", Delay = 0.1 * i, OffsetZ = emoteOffsetZ } )
	end

	PlaySound({ Name = "/SFX/Menu Sounds/Lounge_GlassWithIce" })
	wait( 0.3 )
	PlaySound({ Name = "/SFX/Menu Sounds/Lounge_GlassesClinking" })
	wait( 0.2 )
	PlaySound({ Name = "/SFX/ScyllaCrowdApplause1" })

end

function TavernaClearedRunPresentation( source )
	local allShadeIds = GetIdsByType({ Names = { "ShadeHubIdle01", "ShadeHubSIdle01", "ShadeHubMIdle01", "ShadeHubHatIdle01", "ShadeHubBroomIdle01", "ShadeHubGarlicIdle01", "ShadeHubBerriesIdle01" } })
	local tavernaShadeIds = GetClosestIds({ Id = 586582, Distance = 1000, DestinationIds = allShadeIds })
	local emotes = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }
	for i, id in ipairs( tavernaShadeIds ) do
		local emoteOffsetZ = nil
		if MapState.ActiveObstacles[id] ~= nil then
			emoteOffsetZ = MapState.ActiveObstacles[id].EmoteOffsetZ
		end
		if RandomChance( 0.75 ) then
			thread( PlayEmoteSimple, nil, { TargetId = id, AnimationName = GetRandomValue( emotes ), Delay = 0.1 * i, OffsetZ = emoteOffsetZ } )
		end
	end

	thread( PlayVoiceLines, HeroVoiceLines.TavernaVictoryVoiceLines, true )
	PlaySound({ Name = "/SFX/ScyllaCrowdApplause1" })
end

function RevealFishingPointPresentation( source )

	ResourceGiftedPresentation( { ResourceName = "GiftPointsEpic", SoundName = "/Leftovers/SFX/BigFishSplash" } )
	ClearMapBlockers( source, { DeleteGroups = { "Docks_Blocker", "DocksDimmer_01" }, } )

end

function RevealBathHousePresentation( source )

	ResourceGiftedPresentation()
	ClearMapBlockers( source, { DeleteGroups = { "Bath_Blocker", "BathDimmer_01" }, } )

end

function UpdateEscapeDoorForLimitGraspShrineUpgrade( source, args )
	args = args or {}

	local shouldLock = false
	if GetNumShrineUpgrades( "LimitGraspShrineUpgrade" ) >= 1 then
		local graspPercent = (GameState.MetaUpgradeCostCache / GameState.MaxMetaUpgradeCostCache) * 100
		if graspPercent > MetaUpgradeData.LimitGraspShrineUpgrade.ChangeValue then
			shouldLock = true
		end
	end

	local escapeDoorIds = args.EscapeDoorIds or { source.ObjectId }
	for i, escapeDoorId in ipairs( escapeDoorIds ) do
		local escapeDoor = MapState.ActiveObstacles[escapeDoorId]
		if escapeDoor ~= nil then
			if shouldLock then
				escapeDoor.UseText = "LimitGraspShrineUpgradeEscapeDoorClosed"
				escapeDoor.OnUsedFunctionName = "LimitGraspShrineUpgradeEscapeDoorClosed"
				if escapeDoor.OnUsedFunctionArgs.StartingBiome == "N" then
					SetAnimation({ DestinationId = escapeDoor.ObjectId, Name = "LimitGraspShrineUpgradeDoorExitLockedNE" })
				else
					SetAnimation({ DestinationId = escapeDoor.ObjectId, Name = "LimitGraspShrineUpgradeDoorExitLockedSW" })
				end
			else
				local defaultData = HubRoomData.Hub_PreRun.ObstacleData[escapeDoor.ObjectId]
				escapeDoor.UseText = defaultData.UseText
				escapeDoor.OnUsedFunctionName = defaultData.OnUsedFunctionName
				if escapeDoor.OnUsedFunctionArgs.StartingBiome == "N" then
					SetAnimation({ DestinationId = escapeDoor.ObjectId, Name = "DoorExitLightSoftNE" })
				else
					SetAnimation({ DestinationId = escapeDoor.ObjectId, Name = "DoorExitLightSoftSW" })
				end
			end
		end
	end
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

function LimitGraspShrineUpgradeEscapeDoorClosed( usee, args )
	AddInputBlock({ Name = "UseEscapeDoor" })

	args = args or {}
	if CheckCooldown( "ExitFailedDueToShrine", 2.0 ) then
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = usee.ObjectId })
		thread( DirectionHintPresentation, MapState.ActiveObstacles[args.AltarId], { Cooldown = 1.0, Duration = 4.0, Delay = 0.0 } )
		thread( InCombatText, CurrentRun.Hero.ObjectId, "LimitGraspShrineUpgrade_ExitsBlocked", 1.8, { ShadowScale = 0.66 } )
		thread( PlayVoiceLines, HeroVoiceLines.DocksDoorShutVoiceLines, true )
		thread( RepulseFromObject, CurrentRun.Hero, { Scale = CurrentRun.Hero.InvincibubbleScale } )
	end
	RemoveInputBlock({ Name = "UseEscapeDoor" })
end

function ShadeSignSway( source, args )
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CardboardInteract", Id = source.ObjectId })
	local swayAngle = RandomFloat( -70, 70 )
	SetAngle({ Id = source.ObjectId, Angle = swayAngle, Duration = 0.3, EaseIn = 1.0, EaseOut = 1.0 })
	wait( 0.3 )
	SetAngle({ Id = source.ObjectId, Angle = 0, Duration = 0.3, EaseIn = 1.0, EaseOut = 1.0 })
end

-- how else shall one prove to others that their fate is their own?
function SpecialInteractChangeNextRunRNG( usee, args )

	GameState.NextRunSeed = GetClockSeed()
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "SpecialInteractChangeNextRunRNG" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	local animation = GetEquippedWeaponValue( "UnequipAnimation" )
	if animation ~= nil then
		SetAnimation({ Name = animation, DestinationId = CurrentRun.Hero.ObjectId })
	end
	wait( 0.45 )
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.ChangedRNGVoiceLines, true )
	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.66 })
	Shake({ Ids = { 420947, 555784, }, Distance = 2, Speed = 120, Duration = 0.66 })
	thread( InCombatTextArgs, { TargetId = usee.ObjectId, Text = "ChangedNextRunRNG", PreDelay = 0.6, Duration = 2.4, OffsetY = -200 } )
	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })
	wait( 1.3 )
	AdjustColorGrading({ Name = "None", Duration = 1 })
	thread( InCombatTextArgs, { TargetId = 589873, Text = "RerollDie", PreDelay = 0, Duration = 0.8, OffsetY = -100, RiseDistance = 40 } )
	thread( InCombatTextArgs, { TargetId = 589874, Text = "RerollDie", PreDelay = 0, Duration = 0.8, OffsetY = -100, RiseDistance = 40 } )
	SetAnimation({ Name = "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 0.15 )
	RemoveInputBlock({ Name = "SpecialInteractChangeNextRunRNG" })

end

function RiverGhostPresentation( source, args )
	SetAnimation({ DestinationId = source.ObjectId, Name = args.Animation })
	wait( args.PostWait )
end

function SetupErisWarningSignCosmeticThread( source, args )
	thread( SetupErisWarningSignCosmetic, source, args )
end

function SetupErisWarningSignCosmetic( source, args )
	wait( 0.02 )
	local erisId = GetIdsByType({ Name = "NPC_Eris_01" })[1]
	if erisId == nil or not IsGameStateEligible( ActiveEnemies[erisId], args.ErisGameStateRequirements ) then
		-- Eris's face will appear when you activate this sign, even if she's not around
		if not SessionMapState.CosmeticsPurchased[source.Name] then
			SetAlpha({ Ids = args.SignIds, Fraction = 0.0 })
		end
	end
end

function OverlookAdvanced(room, args)
	if MapState.HasDoneOverlookAdvanced then
		return
	end

	local overlookData = CurrentRun.CurrentRoom.OverlookData
	if CurrentHubRoom ~= nil then
		overlookData = CurrentHubRoom.OverlookData
	end
	if not MapState.InOverlook and (CurrentRun.Hero.IsDead or CurrentRun.CurrentRoom.Encounter.Completed) then
		MapState.InOverlook = true
		AddInputBlock({ Name = "OverlookAdvanced" })
		EndAutoSprint({ Halt = true, EndWeapon = true })
		local heroDestination = overlookData.HeroBeamPoint
		Move({ Id = CurrentRun.Hero.ObjectId, DestinationId = heroDestination, SuccessDistance = 32 })

		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )

		SetCameraFocusOverride()
		HideCombatUI("Overlook")

		Halt({ Id = CurrentRun.Hero.ObjectId })

		thread( FadeBackgroundForestOut )

		if GameState.GamePhase and GamePhaseData.GamePhases[GameState.GamePhase] then
			local moonId = GetIdsByType({ Name = "ErebusOverlookMoon01"})[1]
			SetAnimation({ Name = GamePhaseData.GamePhases[GameState.GamePhase].ErebusOverlookAnimation, DestinationId = moonId })
		end

		if overlookData.FadeIdsOnEnd ~= nil then
			SetAlpha({ Ids = overlookData.FadeIdsOnEnd, Fraction = 0, Duration = 2.0 })
		end

		if overlookData.CameraSlideFromHeroPosition ~= nil then
			ClearCameraClamp({ Duration = 0.5 })
			if overlookData.CameraSpeed then
				LockCamera({ Id = CurrentRun.Hero.ObjectId, Speed = overlookData.CameraSpeed, OffsetY = -2000, Retarget = true })
			else
				LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = overlookData.CameraStartPanDuration, OffsetY = -2000, Retarget = true })
			end
			FocusCamera({ Fraction = 0.9, Duration = overlookData.CameraStartPanDuration, ZoomType = "Ease" })
			wait( overlookData.CameraStartPanRelocateDuration )
			-- FadeOut({ Color = Color.Black, Duration = 0.1 })
		end

		-- Advanced Start
		MapState.InOverlookAdvanced = true
		MapState.HasDoneOverlookAdvanced = true
		ZeroMouseTether( "Overlook" )
		--FullScreenFadeOutAnimation()
		--SetCameraClamp({ Ids = overlookData.CameraClamps })

		
		if overlookData.CameraRelocateStartId then
			LockCamera({ Id = overlookData.CameraRelocateStartId, Duration = 0.01, Retarget = true, EaseIn = 0 })
			wait( 0.02 )
			--PanCamera({ Id = overlookData.CameraRelocateStartId, OffsetY = overlookData.CameraRelocatePanOffsetY, Duration = overlookData.CameraRelocatePanDuration, Retarget = true, EaseIn = 0, EaseOut = 2.0 })
			LockCamera({ Id = overlookData.CameraRelocateStartId, OffsetY = overlookData.CameraRelocatePanOffsetY, Speed = overlookData.CameraSpeed * 0.9, Retarget = true, })
		end
		if overlookData.ZoomFraction then
			FocusCamera({ Fraction = overlookData.ZoomFraction, Duration = 0.01, ZoomType = "Ease" })
		end

		wait( 0.04 )
		
		wait( overlookData.CameraEndStartDelay or 0.0, "OverlookThread" )

		LockCamera({ Id = overlookData.CameraRelocateEndId, SpeedTarget = overlookData.CameraSpeed * 0.1, Acceleration = 800, Retarget = true, FromCurrentLocation = true })
		--PanCamera({ Id = overlookData.CameraRelocateEndId, Duration = overlookData.CameraRelocateExtendedPanDuration or 0.01, Retarget = true, EaseIn = 0.2, EaseOut = 2.0, FromCurrentLocation = true })
		FocusCamera({ Fraction = overlookData.EndZoomFraction, Duration =  overlookData.CameraRelocateExtendedPanDuration, ZoomType = "Ease" })
		
		--RemoveInputBlock({ Name = "OverlookAdvanced" })
		thread( WaitForEndOverlookAdvancedInput, room, overlookData, "EndOverlookAdvanced" )
	end
end

function FadeBackgroundForestOut()
	local backgroundForestIds = GetIds({ Names = { "Erebus_Standing_01", "Erebus_Terrain_Decor_01", "Erebus_Terrain_Decor_02", "Erebus_Terrain_Decor_03" } })
	local stragglerIds = { 588600, 588508, 588562, 588577, 588513, 588522, 588525, 588476, 588507, 588463, 589326, 588472, 588602, }
	wait( 0.9 )
	SetAlpha({ Ids = backgroundForestIds, Fraction = 0.0, Duration = 0.5 })
	SetAlpha({ Ids = stragglerIds, Fraction = 0.0, Duration = 0.5 })
end

function FadeBackgroundForestIn()
	local backgroundForestIds = GetIds({ Names = { "Erebus_Standing_01", "Erebus_Terrain_Decor_01", "Erebus_Terrain_Decor_02", "Erebus_Terrain_Decor_03" } })
	local stragglerIds = { 588600, 588508, 588562, 588577, 588513, 588522, 588525, 588476, 588507, 588463, 589326, 588472, 588602, }
	wait( 0.1 )
	SetAlpha({ Ids = backgroundForestIds, Fraction = 1.0, Duration = 0.3 })
	SetAlpha({ Ids = stragglerIds, Fraction = 1.0, Duration = 0.3 })
end

function WaitForEndOverlookAdvancedInput(room, overlookData, returnFunction)
	local notifyName = "OverlookPressAnyButton"
	NotifyOnControlPressed({ Names = { "Confirm", "Rush", "Attack1", "Attack2", "Attack3", "Attack4", "Interact", "Codex", "Shout", "AutoLock", }, Notify = notifyName })
	waitUntil( notifyName )

	CallFunctionName(returnFunction, room, overlookData)
end

function EndOverlookAdvanced(room, overlookData)
	overlookData = overlookData or room.OverlookData or {}

	if MapState.InOverlookAdvanced then
		MapState.InOverlookAdvanced = false
		AddInputBlock({ Name = "Overlook" })
		
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.5, FromCurrentLocation = true })
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.01, Retarget = true, EaseIn = 0 })
		Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = overlookData.ReturnPositionId })
		FocusCamera({ Fraction = room.ZoomFraction or 1.0, Duration = 1.5, ZoomType = "Ease" })

		thread( FadeBackgroundForestIn )
	
		wait( 1.5 )
		local cameraClamps = CurrentRun.CurrentRoom.CameraClamps or GetDefaultClampIds()
		SetCameraClamp({ Ids = cameraClamps })
		
		AdjustColorGrading({ Name = "Off", Duration = 1.0, })
		BiomeBackToRoom( room, overlookData )
		SetAnimation({ Name = "MoonbeamsColor", DestinationId = 561017 })
		RemoveInputBlock({ Name = "Overlook" })
		RemoveInputBlock({ Name = "OverlookAdvanced" })
	elseif MapState.InOverlook then
		BiomeBackToRoom( room, overlookData )
	end

end

function PreRunCameraPresentation(room, args)

	wait( 1.0 )

	AddInputBlock({ Name = "PreRunCameraPresentation" })
	
	HideCombatUI( "PreRunCameraPresentation" )
	ClearCameraClamp({ LerpTime = 1.35 })
	thread( PlayVoiceLines, args.PanVoiceLines, true )

	CutsceneAddLetterbox()

	wait( 1.35 )

	PanCamera({ Id = args.PanTargetId, Duration = args.PanDuration, EaseIn = 0.0, EaseOut = 0.01 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	wait( args.HoldDuration )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.3, EaseIn = 0.01, EaseOut = 0.03 })

	wait(0.5)
	
	RemoveInputBlock({ Name = "PreRunCameraPresentation" })
	ShowCombatUI( "PreRunCameraPresentation" )

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })

	CheckObjectiveSet( args.ObjectiveSet )
	thread( PreRunCameraPresentationEnd )

end

function UpdateFamilyPortraitVisibility( eventSource, args )
	args = args or {}
	wait( args.PreWait )
	local usedThisRun = CurrentRun.UseRecord[eventSource.Name]
	if usedThisRun or IsGameStateEligible( eventSource, args.StartHiddenGameStateRequirements ) then
		CurrentRun.FamilyPortraitHidden = true
		UseableOff({ Id = eventSource.ObjectId })
		SetAnimation({ DestinationId = eventSource.ObjectId, Name = eventSource.HiddenAnimation })
		if not args.Silent then
			PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ClothInteract2" })
			thread( PlayVoiceLines, HeroVoiceLines.CoveredFamilyPortraitVoiceLines )
		end
	end
end

function ViewPortraitPresentation( eventSource, args )

	args = args or {}

	if not PlayingTextLines then
		UseableOff({ Id = eventSource.ObjectId })
	end

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = eventSource.ObjectId })
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })

	AddInputBlock({ Name = "ShowingInterstitial" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	HideCombatUI("ShowingInterstitial")

	SetVolume({ Id = AudioState.AmbienceId, Value = 0.0, Duration = 0.5 })
	AudioState.PortraitAmbienceId = PlaySound({ Name = "/Ambience/MusicExploration4AMBIENCEIris" })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })

	ScreenAnchors.PortraitDisplayAnchor = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY })
	local blackScreenId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_UI_Backing", Animation = "FamilyPortraitBackground" })
	local portraitId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu", Animation = eventSource.PortraitAnimation, Scale = args.StartScale })

	Attach({ Id = blackScreenId, DestinationId = ScreenAnchors.PortraitDisplayAnchor })
	Attach({ Id = portraitId, DestinationId = ScreenAnchors.PortraitDisplayAnchor })

	SetAlpha({ Id = blackScreenId, Fraction = 0 })

	local cameraTargetId = SpawnObstacle({ Name = "InvisibleTarget" })
	Teleport({ Id = cameraTargetId, DestinationIsScreenRelative = true, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })
	PanCamera({ Id = cameraTargetId, Duration = 1.0, EaseIn = 0, EaseOut = 0, Retarget = true, FromCurrentLocation = true })

	-- Camera Pan
	AdjustFullscreenBloom({ Name = "NewType06", Duration = 0.15 })
	wait(0.02)
	AdjustFullscreenBloom({ Name = "Off", Duration = 1 })
	SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0.3 })
	
	SetScale({ Id = portraitId, Fraction = args.EndScale, Duration = args.PanDuration, EaseOut = 1.0, EaseIn = 0.0 })

	if args.UnthreadedVoiceLines then
		PlayVoiceLines( HeroVoiceLines.UsedFamilyPortraitVoiceLines )
	else
		thread( PlayVoiceLines, HeroVoiceLines.UsedFamilyPortraitVoiceLines )

		local totalSequenceDuration = 12.0
		local durationBeforeAllowingInput = 6.5

		wait( durationBeforeAllowingInput )

		local notifyName = "PortraitPressAnyButton"
		local timeoutDuration = totalSequenceDuration - durationBeforeAllowingInput
		NotifyOnControlPressed({ Names = { "Confirm", "Rush", "Attack1", "Attack2", "Attack3", "Attack4", "Interact", "Codex", "Shout", "AutoLock", }, Notify = notifyName, Timeout = timeoutDuration })
		waitUntil( notifyName )
	end

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })

	StopSound({ Id = AudioState.PortraitAmbienceId, Duration = 1.0 })
	AudioState.PortraitAmbienceId = nil
	SetVolume({ Id = AudioState.AmbienceId, Value = 1.0, Duration = 1.0 })

	wait(0.375)
	
	SetAlpha({ Id = blackScreenId, Fraction = 0.0, Duration = 0.375 })
	SetAlpha({ Id = portraitId, Fraction = 0.0, Duration = 0.375 })

	if IsGameStateEligible( eventSource, eventSource.SetupEvents[1].GameStateRequirements ) then
		UpdateFamilyPortraitVisibility( eventSource )
	end

	wait(0.625)
	Destroy({ Ids = { portraitId, blackScreenId, ScreenAnchors.PortraitDisplayAnchor, cameraTargetId } })

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.65, EaseIn = 0, EaseOut = 0, Retarget = true })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
	RemoveInputBlock({ Name = "ShowingInterstitial" })
	UnblockCombatUI("ShowingInterstitial")

end

function BountyBoardUnlockedFirstPresentation(room, args)

	wait( 1.0 )
	local bountyBoardId = 561146

	AddInputBlock({ Name = "BountyBoardUnlockedFirstPresentation" })
	
	HideCombatUI( "BountyBoardUnlockedFirstPresentation" )
	ClearCameraClamp({ LerpTime = 1.35 })
	thread( PlayVoiceLines, HeroVoiceLines.BountyBoardUnlockedVoiceLines, true )

	CutsceneAddLetterbox()

	wait( 1.35 )

	PanCamera({ Id = bountyBoardId, Duration = 2.6, EaseIn = 0.01, EaseOut = 0.01 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash2", Delay = 2.2 })

	wait( 4.6 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.8 })

	wait( 0.5 )

	CheckObjectiveSet( "BountyPrompt" )
	
	RemoveInputBlock({ Name = "BountyBoardUnlockedFirstPresentation" })
	ShowCombatUI( "BountyBoardUnlockedFirstPresentation" )

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })

	thread( BountyBoardReturnPresentationEnd )
end

function ShrineUnlockedFirstPresentation(room, args)

	wait( 1.0 )
	local shrineId = 589694

	AddInputBlock({ Name = "ShrineUnlockedFirstPresentation" })
	
	HideCombatUI( "ShrineUnlockedFirstPresentation" )
	ClearCameraClamp({ LerpTime = 1.35 })
	thread( PlayVoiceLines, HeroVoiceLines.ShrineUnlockedVoiceLines, true )

	CutsceneAddLetterbox()

	wait( 1.35 )

	PanCamera({ Id = shrineId, Duration = 2.6, EaseIn = 0.01, EaseOut = 0.01 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark", Delay = 2.2 })

	wait( 4.6 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.8 })

	wait( 0.5 )
	
	RemoveInputBlock({ Name = "ShrineUnlockedFirstPresentation" })
	ShowCombatUI( "ShrineUnlockedFirstPresentation" )

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })

	thread( ShrineReturnPresentationEnd )
end

function TrophyQuestUnlockedFirstPresentation(room, args)

	wait( 1.0 )
	local trophyId = 589734
	AddInputBlock({ Name = "TrophyQuestUnlockedFirstPresentation" })
	HideCombatUI( "TrophyQuestUnlockedFirstPresentation" )
	ClearCameraClamp({ LerpTime = 1.35 })
	thread( PlayVoiceLines, HeroVoiceLines.TrophyQuestUnlockedVoiceLines, true )

	CutsceneAddLetterbox()

	wait( 1.35 )

	PanCamera({ Id = trophyId, Duration = 2.8, EaseIn = 0, EaseOut = 0.5 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement", Delay = 2.4 })

	wait( 4.6 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.2 })

	wait( 0.5 )
	
	RemoveInputBlock({ Name = "TrophyQuestUnlockedFirstPresentation" })
	ShowCombatUI( "TrophyQuestUnlockedFirstPresentation" )

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })

	thread( TrophyQuestReturnPresentationEnd )
end

function BountyBoardReturnPresentationEnd()
	CheckObjectiveSet( "BountyBoardUnlockedPrompt" )
	wait( 0.85 )
	local cameraClamps = CurrentHubRoom.CameraClamps or GetDefaultClampIds()
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 0, Duration = 0.4 })
	ShowCombatUI()
end

function ShrineReturnPresentationEnd()
	CheckObjectiveSet( "ShrineUnlockedPrompt" )
	wait( 0.85 )
	local cameraClamps = CurrentHubRoom.CameraClamps or GetDefaultClampIds()
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 0, Duration = 0.4 })
	ShowCombatUI()
end

function PreRunCameraPresentationEnd()
	wait( 0.85 )
	local cameraClamps = CurrentHubRoom.CameraClamps or GetDefaultClampIds()
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 0, Duration = 0.4 })
	ShowCombatUI()
end

function TrophyQuestReturnPresentationEnd()
	CheckObjectiveSet( "TrophyQuestUnlockedPrompt" )
	wait( 0.85 )
	local cameraClamps = CurrentHubRoom.CameraClamps or GetDefaultClampIds()
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 0, Duration = 0.4 })
	ShowCombatUI()
end

function DoraStopDissipateFx( source, args )
	StopAnimation({ DestinationId = source.ObjectId, Name = "DoraDissipateFxLoop" })
end

function DoraCheckForNewItems( source, args )
	while source.PlayingEndVoiceLines do
		wait( 0.1 )
	end
	if not source.Hidden and source.NextInteractLines ~= nil and source.NextInteractLines.StatusAnimation then
		return false
	end
	if CanSpecialInteract( source ) and IsGameStateEligible( source, { NamedRequirements = { "CosmeticsShopUnlocked" } } ) then
		if HasNewCosmeticsAvailable( source, { CategoryIndex = source.DefaultCategoryIndex } ) then
			PlayStatusAnimation( source, { Animation = "StatusIconNewItemsInStock" } )
			return true
		end
	end
end

function DoraStartHaunting( source, args )
	args = args or {}

	if args.PreWait ~= nil then
		wait( args.PreWait )
	end

	if source.IsHaunting then
		return
	end
	source.IsHaunting = IsGameStateEligible( source, source.HauntingRequirements )
	if not source.IsHaunting then
		return
	end

	if source.NextInteractLines ~= nil and source.NextInteractLines.StatusAnimation then
		StopStatusAnimation( source )
	end
	SetAnimation({ Name = "Dora_Invisible", DestinationId = source.ObjectId }) --nopkg
	thread( TrackPlayer, source, { Interval = 2.0, Duration = 1.0, EaseIn = 0.0, EaseOut = 1.0, ThreadName = "DoraTrackPlayerThread" } )

	local threadName = "DoraHauntingThread"
	local notifyName = "DoraHauntingNotify"
	while true do

		source.Hidden = true
		if not DoraCheckForNewItems( source ) then
			StopStatusAnimation( source, "StatusIconNewItemsInStock" )
		end

		-- Wait for Mel to approach...
		NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { source.ObjectId }, Distance = 420, Notify = notifyName, ScaleY = 0.75 })
		waitUntil( notifyName )

		-- Appear!
		source.Hidden = false
		thread( PlayVoiceLines, source.ApproachVoiceLines, true, source )
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = source.ObjectId, Fraction = 1.0, Duration = 0.2 })
		if source.NextInteractLines ~= nil and source.NextInteractLines.StatusAnimation then
			StopStatusAnimation( source, "StatusIconNewItemsInStock" )
			PlayStatusAnimation( source, { Animation = source.NextInteractLines.StatusAnimation } )
		end

		-- Wait for Mel to leave...
		wait( 0.5, threadName )
		NotifyOutsideDistanceAll({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, Distance = 500, Notify = notifyName, ScaleY = 0.75 })
		waitUntil( notifyName )

		-- Disappear!
		local statusAnim = source.StatusAnimation
		if statusAnim ~= "StatusIconNewItemsInStock" then
			StopStatusAnimation( source, "StatusIconNewItemsInStock" )
			StopStatusAnimation( source )
			if statusAnim ~= nil then
				-- StatusAnimations should be refactored to use a base object instead of only VFX
				CreateAnimation({ Name = statusAnim.."_End", DestinationId = source.ObjectId, Group = "Combat_UI_World", OffsetZ = source.AnimOffsetZ })
			end
		end
		thread( PlayVoiceLines, GlobalVoiceLines.DoraHidingVoiceLines, true, source )
		SetAnimation({ Name = source.AnimationsForModel.Dora_Disappear[source.ActiveModel], DestinationId = source.ObjectId })
		wait( 1.0, threadName )

	end
end

function DoraStopHaunting( source )
	source.IsHaunting = false
	killTaggedThreads( "DoraHauntingThread" )
	killTaggedThreads( "DoraTrackPlayerThread" )
	killWaitUntilThreads( "DoraHauntingNotify" )
end

function DoraTeleportHub( args )
	local dora = ActiveEnemies[566832]
	if dora ~= nil and ( args.Force or IsGameStateEligible( dora, dora.CosmeticsTeleportRequirements ) ) then
		DoraStopHaunting( dora )
		if not args.SkipHaunting then
			thread( DoraStartHaunting, dora, { PreWait = 0.02 } )
		end
		CreateAnimation({ DestinationId = dora.ObjectId, Name = "EnemyDeathFx_DoraTeleport" })
		Teleport({ Id = dora.ObjectId, DestinationId = args.DestinationId })
		CreateAnimation({ DestinationId = args.DestinationId, Name = "EnemyDeathFx_DoraTeleport" })
		dora.DefaultCategoryIndex = args.CategoryIndex
		if dora.SpecialInteractBlockedUntilTeleport then
			dora.SpecialInteractBlockedUntilTeleport = nil
			SetAvailableUseText( dora )
		end
	end
end

function DoraTeleportExit( source, args )

	args = args or {}

	if args.HideUntilNextRun then
		CurrentRun.BlockDoraSpawn = true
	end
	SessionMapState.DoraDidTeleportExit = true

	DoraStopHaunting( source )
	killWaitUntilThreads( "DoraApproach" )

	local modelAnims = source.AnimationsForModel.Dora_Disappear
	local anim = modelAnims[source.ActiveModel]

	SetAnimation({ Name = anim, DestinationId = source.ObjectId })

	source.NextInteractLines = nil
	source.SpecialInteractFunctionName = nil
	source.RepulseOnMeleeInvulnerableHit = nil
	UseableOff({ Id = source.ObjectId })
	RemoveFromGroup({ Id = source.ObjectId, Name = "NPCs" })
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )
	source.Mute = true

	wait( 1.0, RoomThreadName )

	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.3 })

end

function TeleportDoraForIncantation( source )

	local dora = ActiveEnemies[566832]
	StopStatusAnimation( dora )

	local hubMainTeleportId = 560665
	if not IsWithinDistance({ Id = dora.ObjectId, DestinationId = hubMainTeleportId, Distance = 50 }) then
		DoraTeleportHub( { Force = true, SkipHaunting = true, DestinationId = hubMainTeleportId } )
		AngleTowardTarget({ Id = dora.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		wait( 0.3 )
	end

	GenericPresentation( dora, PresetAudioArgs.DoraNormalAppearArgs )

end

function HypnosReturnToSleep( source, args )

	if CurrentRun.EventState[source.ObjectId] ~= nil then
		-- Already running
		return
	end

	if GameState.TextLinesRecord.ThanatosWithHypnos06 then
		if args.LowChanceToPlay ~= nil and not RandomChance( args.LowChanceToPlay ) then
			return
		end
	else
		if args.HighChanceToPlay ~= nil and not RandomChance( args.HighChanceToPlay ) then
			return
		end
	end

	CurrentRun.EventState[source.ObjectId] = { FunctionName = "HypnosReturnToSleep", Args = args }

	while true do

		wait( RandomFloat( args.RandomWaitMin, args.RandomWaitMax ), RoomThreadName )

		local notifyName = "HypnosReturnToSleep"
		NotifyOutsideDistanceAll({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, Distance = args.OutsideDistance, Notify = notifyName })
		waitUntil( notifyName )

		-- Back to Sleep
		SetAnimation({ Name = args.OutsideAnimation, DestinationId = source.ObjectId })
		CreateAnimation({ Name = args.OutsideVfx, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
		thread( PlayVoiceLines, GlobalVoiceLines[args.OutsideGlobalVoiceLines], true )
		wait( 2.0, RoomThreadName )

		SetAnimation({ Name = args.OutsideAnimation, DestinationId = source.ObjectId })

		notifyName = "HypnosWakeup"
		NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { source.ObjectId }, Distance = args.InsideDistance, Notify = notifyName })
		waitUntil( notifyName )

		-- Wakeup
		SetAnimation({ Name = args.InsideAnimation, DestinationId = source.ObjectId })
		StopAnimation({ Name = args.OutsideVfx, DestinationId = source.ObjectId })
		CreateAnimation({ Name = args.InsideVfx, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
		thread( PlayVoiceLines, GlobalVoiceLines[args.InsideGlobalVoiceLines], true )
		Flash({ Id = source.ObjectId, Speed = 1, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.White, ExpireAfterCycle = true })
		Shake({ Id = source.ObjectId, Distance = 3, Speed = 150, Duration = 0.65 })

	end
end

function WretchedBrokerReaction( args )

	args = args or {}
	wait( args.Delay or 0, RoomThreadName )

	local broker = MapState.ActiveObstacles[558096]
	if broker ~= nil then
		PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = broker.ObjectId })
		thread( PlayEmoteSimple, broker, { AnimationName = "StatusIconSmile", Group = "Combat_UI_Backing", OffsetZ = broker.EmoteOffsetZ, BlockIfSourceHasStatusAnimation = true })
	end
end
function WretchedBrokerFlashbackReaction( args )

	args = args or {}
	wait( args.Delay or 0, RoomThreadName )

	local broker = MapState.ActiveObstacles[558096]
	if broker ~= nil then
		PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = broker.ObjectId })
		thread( PlayEmoteSimple, broker, { AnimationName = "StatusIconSmile", Group = "Combat_UI_Backing", OffsetZ = broker.EmoteOffsetZ, BlockIfSourceHasStatusAnimation = true })
	end
end

function LearnedSageReaction( args )
	PlaySound({ Name = "/SFX/GhostEmotes/EmbarrassedTINY", Id = 589466 })
	thread( PlayEmoteSimple, source, { TargetId = 589466, AnimationName = "StatusIconSmile", OffsetZ = 80 })
end

function RecordKeeperReaction( args )
	PlaySound({ Name = "/SFX/GhostEmotes/SmileTINY", Id = 589467 })
	thread( PlayEmoteSimple, source, { TargetId = 589467, AnimationName = "StatusIconOhBoy", OffsetZ = 0 })
end

function MusicMakerReaction( args )
	PlaySound({ Name = "/SFX/GhostEmotes/EmbarrassedLARGE", Id = 738510 })
	-- thread( PlayEmoteSimple, source, { TargetId = 738510, AnimationName = "StatusIconVictory", OffsetZ = 50 })
end

GlobalVoiceLines.SkellyHitQuestCompleteVoiceLines =
{
	PreLineWait = 0.4,
	Queue = "Interrupt",
	RecheckRequirementsPostWait = true,
	RequiresSourceAlive = true,
	GameStateRequirements =
	{
		-- None
	},
	ObjectType = "NPC_Skelly_01",

	-- All right that's enough! Unless you want to keep going?
	{ Cue = "/VO/Skelly_0004", Text = "All right that's enough! Unless you want to keep going?" },
}

function SkellyHitQuestCompletePresentation( victim )
	thread( PlayVoiceLines, GlobalVoiceLines.SkellyHitQuestCompleteVoiceLines, nil, victim )
end

function CenterInteractRange( npc, args )
	args = args or {}
	SetInteractProperty({ DestinationId = npc.ObjectId, Property = "OffsetX", Value = 0 })
	SetInteractProperty({ DestinationId = npc.ObjectId, Property = "OffsetY", Value = 0 })
	if args.Distance ~= nil then
		SetInteractProperty({ DestinationId = npc.ObjectId, Property = "Distance", Value = args.Distance })
	end
end

function ErisExitPresentation( eris, args )

	args = args or {}

	UseableOff({ Id = eris.ObjectId })
	RemoveFromGroup({ Id = eris.ObjectId, Name = "NPCs" })

	eris.Mute = true

	SetAnimation({ Name = "Enemy_Eris_HubToCombatIdle", DestinationId = eris.ObjectId, SpeedMultiplier = 2 })
	wait( 0.66 )
	if args.NoLaugh then
		SetAnimation({ Name = "Enemy_Eris_FlyUp_Start_Quiet", DestinationId = eris.ObjectId })
	else
		SetAnimation({ Name = "Enemy_Eris_FlyUp_Start", DestinationId = eris.ObjectId })
	end
	wait ( 0.45 )
	AdjustZLocation({ Id = eris.ObjectId, Distance = 800, Duration = 0.55 })
	wait ( 0.45 )
	SetAlpha({ Id = eris.ObjectId, Fraction = 0.0, Duration = 0.2 })
	SetUnitProperty({ DestinationId = eris.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = eris.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = eris.ObjectId, Property = "StopsProjectiles", Value = false })	

end

function IcarusHubExitPresentation( icarus, args )

	args = args or {}
	
	CurrentRun.IcarusExitedHub = true

	UseableOff({ Id = icarus.ObjectId })
	RemoveFromGroup({ Id = icarus.ObjectId, Name = "NPCs" })

	icarus.Mute = true
	
	wait ( args.WaitTime or 0.5 )

	SetAnimation({ Name = "Icarus_FlyExit_TakeOff", DestinationId = icarus.ObjectId })
	
	wait ( 0.36 )

	AdjustZLocation({ Id = icarus.ObjectId, Duration = 0.22, Distance = 800 })
	IgnoreGravity({ Id = icarus.ObjectId })

	wait ( 0.11 )

	SetAlpha({ Id = icarus.ObjectId, Fraction = 0.0, Duration = 0.11 })
	SetUnitProperty({ DestinationId = icarus.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = icarus.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = icarus.ObjectId, Property = "StopsProjectiles", Value = false })

end

function NyxExitPresentation( source )

	args = args or {}
	
	UseableOff({ Id = source.ObjectId })
	source.SpecialInteractFunctionName = nil
	source.CanReceiveGift = false
	source.NextInteractLines = nil
	source.BlockChatting = true
	RefreshUseButton( source.ObjectId, source )

	wait( args.WaitTime or 3 )

	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = source.ObjectId })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.1 })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = source.ObjectId, Property = "StopsProjectiles", Value = false })

	wait( 0.5, RoomThreadName )

	source.Mute = true
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[source.ObjectId] = args.AnimationState
	end

end


function PreRunBacktrackHintPresentation( source, args, contextArgs  )

	local newRunDoor = MapState.ActiveObstacles[args.NewRunDoorId]
	SessionState.PreRunBacktrackHintTrigger = true

	CutsceneAddLetterbox()

	AddInputBlock({ Name = "PreRunBacktrackHintPresentation" })
	EndBlinkWeapons({ Id = CurrentRun.Hero.ObjectId })
	killTaggedThreads( "CheckAutoSprint" ) -- Should probably go inside EndAutoSprint but don't want to make a global change there now
	EndAutoSprint({ Halt = true, EndWeapon = true })
	wait( 0.35 )

	HideCombatUI( "PreRunBacktrackHintPresentation" )
	ClearCameraClamp({ LerpTime = 1.35 })
	thread( PlayVoiceLines, HeroVoiceLines.NewDoorHintVoiceLines, true )
	thread( DirectionHintPresentation, newRunDoor, { Delay = 0.0 } )
	contextArgs.Repeat = false

	wait( 0.85 )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = newRunDoor.ObjectId })

	PanCamera({ Id = newRunDoor.ObjectId, Duration = 2.8, EaseIn = 0.01, EaseOut = 0.01 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	wait( 4.0 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.3 })

	wait( 0.5 )
	
	RemoveInputBlock({ Name = "PreRunBacktrackHintPresentation" })
	ShowCombatUI( "PreRunBacktrackHintPresentation" )

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })

	thread( PreRunBacktrackHintPresentationEnd )
	
end

function PreRunBacktrackHintPresentationEnd()
	wait( 0.85 )
	local cameraClamps = CurrentHubRoom.CameraClamps or GetDefaultClampIds()
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 0, Duration = 0.4 })
	ShowCombatUI()
end

-- @ ending
function BlockHubExitForNarrative( source, args )

	source.BlockedByNarrative = true

	thread( CheckDistanceTrigger, args.DistanceTrigger, source )

	local lightIds = { 586702, 586701, 586872, 585235, 585232 }
	SetAlpha({ Ids = lightIds, Fraction = 0.0 })

end

function UnblockHubExitForNarrative()

	local exitId = 391697
	MapState.ActiveObstacles[exitId].BlockedByNarrative = false

	killWaitUntilThreads( "BlockHubExitForNarrativeTrigger" )

	local lightIds = { 586702, 586701, 586872, 585235, 585232 }
	SetAlpha({ Ids = lightIds, Fraction = 1.0, Duration = 0.2 })

end

function HubPostCreditsStartPresentation( currentRun, args )

	args = args or {}

	if AudioState.PostCreditsMusicId == nil then
		AudioState.PostCreditsMusicId = PlaySound({ Name = "/Music/EndThemeORCHESTRAL" })
	end

	AddInputBlock({ Name = "DeathWalkBlock" })
	ZeroMouseTether("DeathPresentation")
	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })

	-- unit
	local initialSpeed = GetUnitDataValue({ Id = CurrentRun.Hero.ObjectId, Property = "Speed"})
	SetUnitProperty({ Property = "Speed", Value = 0, DestinationId = CurrentRun.Hero.ObjectId })
	SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = 90 })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = false, DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 1.0, Duration = 0 })
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 780542 })

	-- SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeDeathReEnter" })
	-- AudioState.RespawnSoundId = PlaySound({ Name = "/SFX/Player Sounds/PlayerRespawnHoverLoop", Id = CurrentRun.Hero.ObjectId })

	StartRoomAmbience( CurrentRun, CurrentHubRoom )
	TentEnterPresentation()
	local dimmerIds = GetIds({ Name = "TentIntroDimmer_01" })
	SetAlpha({ Ids = dimmerIds, Fraction = 1.0 })

	-- AdjustColorGrading({ Name = "Respawn", Duration = 0 })
	-- AdjustFullscreenBloom({ Name = "Subtle", Duration = 0 })
	local fadeLightIds = ({ 566965, 566818, 566896 })
	SetAlpha({ Ids = fadeLightIds, Fraction = 0 })

	local cameraStartId = 780542
	LockCamera({ Id = cameraStartId, Duration = 0.01 })
	wait(0.01)
	PanCamera({ Id = cameraStartId, Duration = 0.0, OffsetY = 0, EaseIn = 0, Retarget = true })
	AdjustZoom({ Fraction = CurrentHubRoom.ZoomFraction or 1.23 })
	local cameraClamps = CurrentHubRoom.CameraClamps or GetDefaultClampIds()
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })

	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0 })

	wait(0.3)
	--[[
	
	local healTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "RespawnCircle", DestinationId = healTarget, Group = "FX_Terrain_Add" })

	local blackScreenId = SpawnObstacle({ Name = "rectangle01", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_UI_World" })
	SetScale({ Id = blackScreenId, Fraction = 10 })
	SetColor({ Id = blackScreenId, Color = Color.Black })
	SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0 })
	SetAlpha({ Id = blackScreenId, Fraction = 0.0, Duration = 2.0 })

	local respawnVignette = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Terrain", })
	CreateAnimation({ Name = "RespawnVignette", DestinationId = respawnVignette, Scale = 2.0, })
	CreateAnimation({ Name = "RespawnVignette", DestinationId = respawnVignette, Scale = 1.8, })
	CreateAnimation({ Name = "RespawnVignette", DestinationId = respawnVignette, Scale = 1.6, })

	local respawnHadesSymbolFx = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu_TraitTray_Additive", })
	CreateAnimation({ Name = "RespawnHadesSymbol", DestinationId = respawnHadesSymbolFx })
	CreateAnimation({ Name = "MelRespawnHeal", DestinationId = healTarget, Group = "FX_Standing_Add" })
	
	AdjustColorGrading({ Name = "Off", Duration = 4 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 2 })

	wait(1.1)

	SetAlpha({ Id = respawnHadesSymbolFx, Fraction = 0.0, Duration = 4.0, EaseIn = 0, EaseOut = 1 })
	SetScale({ Id = respawnHadesSymbolFx, Fraction = 0.35, Duration = 4.0, EaseIn = 0, EaseOut = 1 })
	Move({ Id = respawnHadesSymbolFx, Distance = 15, Angle = 180, Duration = 4.0, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Ids = fadeLightIds, Fraction = 1, Duration = 5 })

	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {1, 1, 1, 1}, Duration = 0.0 })
	StopAnimation({ Name = "MelRespawnHeal", DestinationId = healTarget })

	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeDeathReEnterHeadUp" })
	wait( 1.15 )

	thread( MelFootDrop )

	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeDeathReEnterToIdle" })
	PlaySound({ Name = "/SFX/Player Sounds/PlayerRespawnLoopEnd", Id = CurrentRun.Hero.ObjectId })
	StopSound({ Id = AudioState.RespawnSoundId, Duration = 0.5 })
	AudioState.RespawnSoundId = nil
	]]--

	SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = CurrentRun.Hero.ObjectId })
	
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })

	SetAlpha({ Ids = dimmerIds, Fraction = 0, Duration = 1.0 })
	-- SetAlpha({ Id = respawnVignette, Fraction = 0.0, Duration = 0.6, })
	-- StopAnimation({ Name = "MelRespawnHeal", DestinationId = healTarget })
	-- Destroy({ Id = healTarget })
	if CurrentHubRoom.CameraWalls then
		CreateCameraWalls({ })
	end

	local portrait = MapState.ActiveObstacles[589483]
	FadeIn({ Duration = 0.5 })
	ViewPortraitPresentation( portrait, args.PortraitArgs )
	ProcessTextLines( portrait, args.PostPortraitTextLines )
	PlayRandomRemainingTextLines( portrait, args.PostPortraitTextLines )

	-- restore resources formerly in escrow
	if GameState.ResourcesInEscrow.MixerIBoss ~= nil then
		AddResource( "MixerIBoss", GameState.ResourcesInEscrow.MixerIBoss, "Escrow", { Silent = true, SkipVoiceLines = true } )
	end
	if GameState.ResourcesInEscrow.MixerQBoss ~= nil then
		AddResource( "MixerQBoss", GameState.ResourcesInEscrow.MixerQBoss, "Escrow", { Silent = true, SkipVoiceLines = true } )
	end
	GameState.ResourcesInEscrow.MixerIBoss = nil
	GameState.ResourcesInEscrow.MixerQBoss = nil

	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })
	UnzeroMouseTether( "DeathPresentation" )
	RemoveInputBlock({ Name = "DeathWalkBlock" })

end

function HubPostStoryResetStartPresentation( currentRun, args )

	args = args or {}

	TentExitPresentation( nil, { Override = true } )

	AddInputBlock({ Name = "DeathWalkBlock" })
	ZeroMouseTether("DeathPresentation")
	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })

	-- unit
	local initialSpeed = GetUnitDataValue({ Id = CurrentRun.Hero.ObjectId, Property = "Speed"})
	SetUnitProperty({ Property = "Speed", Value = 0, DestinationId = CurrentRun.Hero.ObjectId })
	SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = 45 })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = false, DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 1.0, Duration = 0 })
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 743556, OffsetX = 200 })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "Melinoe_DeathHover_Start" })

	StartRoomAmbience( CurrentRun, CurrentHubRoom )

	wait(0.3)

	SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = CurrentRun.Hero.ObjectId })
	
	local cameraClamps = CurrentHubRoom.CameraClamps or GetDefaultClampIds()
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = CurrentHubRoom.SoftClamp })

	if CurrentHubRoom.CameraWalls then
		CreateCameraWalls({ })
	end

	FadeIn({ Duration = 0.5 })
	FullScreenFadeInAnimation("RoomTransitionOut_TimeWarp")

	thread( PlayVoiceLines, HeroVoiceLines.StoryResetEndVoiceLines )

	wait( 0.8 )

	SetAnimation({ Name = "MelinoeDeathReEnterToIdle", DestinationId = CurrentRun.Hero.ObjectId })
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })

	thread( DisplayInfoBanner, nil, {
		Text = "Location_Home",
		SubtitleText = "Location_Crossroads_StoryReset",
		SubtitleOffsetY = 15,
		SubtitleDelay = 0.75,
		Color = Color.White,
		FadeColor = Color.Red,
		AnimationName = "LocationBackingIrisDeathIn",
		AnimationOutName = "LocationBackingIrisDeathOut",
		Delay = 1.2,
		Duration = 4.25,
	} )

	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })
	UnzeroMouseTether( "DeathPresentation" )
	RemoveInputBlock({ Name = "DeathWalkBlock" })

end

function HypnosExitPresentation( source, args )

	args = args or {}
	
	UseableOff({ Id = source.ObjectId })
	source.SpecialInteractFunctionName = nil
	source.CanReceiveGift = false
	source.NextInteractLines = nil
	RefreshUseButton( source.ObjectId, source )

	wait( 0.3, RoomThreadName )

	CreateAnimation({ Name = "TeleportDisappear", DestinationId = source.ObjectId })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.1 })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithUnits", Value = false })

	wait( 0.5, RoomThreadName )

	source.Mute = true
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[source.ObjectId] = args.AnimationState
	end

end

-- vintage import
function SkellyBackstoryPresentationStart()

	StopSecretMusic()
	StopMusicianMusic( nil, { Duration = 0.2 } )

	SecretMusicPlayer( "/Music/MusicExploration3_MC" )
	SetVolume({ Id = AudioState.SecretMusicId, Value = 0.6 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })

	AdjustColorGrading({ Name = "Sepia", Duration = 4.0 })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

end

function SkellyBackstoryPresentationEnd()

	wait(4)

	SetAudioEffectState({ Name = "VOCompression", Value = 1 })
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 10 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

	AdjustColorGrading({ Name = "Off", Duration = 4.0 })

end

function ActivateHubAquarium( itemData )
	CreateAnimation({ DestinationId = itemData.ActivateIds[1], Name = "CrossroadsAquariumSound" })
end

function DeactivateHubAquarium( itemData )
	StopAnimation({ DestinationId = itemData.ActivateIds[1], Name = "CrossroadsAquariumSound" })
end

function UseAquariumPresentation( usee )

	local totalFishCaught = 0
	for fish, count in pairs( GameState.FishCaught ) do
		totalFishCaught = totalFishCaught + count
	end
	AddInteractBlock( usee, "UseAquarium" )
	AddInputBlock({ Name = "UseAquarium" })
	thread( InCombatTextArgs, { TargetId = usee.ObjectId, Text = "UseAquariumInfo", Duration = 2.0, PreDelay = 0.35, LuaKey = "TempTextData", ShadowScaleX = 0.35, OffsetY = -170,  LuaValue = { TotalCaught = totalFishCaught }})
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.UsedAquariumVoiceLines )

	wait( 1.85 )
	RemoveInputBlock({ Name = "UseAquarium" })

	wait( 10.85, RoomThreadName )
	RemoveInteractBlock( usee, "UseAquarium" )

end

function SetupArachneDangling( source, args )
	SetAnimation({ DestinationId = source.ObjectId, Name = "Arachne_Weaving" })
	AddToGroup({ Id = source.ObjectId, Name = "Standing", DrawGroup = true })
	SetGoalAngle({ Id = source.ObjectId, Angle = 270 })
	AdjustZLocation({ Id = source.ObjectId, Distance = 200 - GetZLocation({ Id = source.ObjectId }) })
	Activate({ Id = args.WebObstacle, })
end

function FamiliarPointsGiftedPresentation( args )
	ResourceGiftedPresentation( args )
	thread( PlayVoiceLines, args.VoiceLines )
	killTaggedThreads( CombatUI.HideThreadName )
	CheckObjectiveSet( "FamiliarPrompt" )
end

function SetupStoryResetObject()
	local storyResetObject = MapState.ActiveObstacles[742624]
	if storyResetObject ~= nil then
		if GameState.TextLinesRecord.InspectHadesFountain02 then
			storyResetObject.OnUsedFunctionName = "OpenStoryResetPromptScreen"
		end
		SetAnimation({ DestinationId = 741509, Name = "Tilesets\\Crossroads\\Crossroads_FountainWall_02" })
		SetAnimation({ DestinationId = 743214, Name = "Tilesets\\Crossroads\\Crossroads_FountainWall_02b" })
		SetAnimation({ DestinationIds = { 743226, 743215, 743461 }, Name = "Tilesets\\Crossroads\\Crossroads_FountainWall_02a" })
		SetColor({ Ids = { 743217, 743216 }, Color = { 82, 59, 36, 255 }, SetBase = true })
	end
end