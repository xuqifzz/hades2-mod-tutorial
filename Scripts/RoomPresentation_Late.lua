function DoChronosOnHitConversation( victim )

	if IsGameStateEligible( victim, victim.ChronosOnHitConversationRequirements ) then

		AddInputBlock({ Name = "ChronosOnHitConversation" })

		thread( PlayVoiceLines, victim.OnHitVoiceLines )

		wait( 1.0 )

		ProcessTextLines( victim, victim.OnHitTextLineSets )
		local textLines = GetRandomEligibleTextLines( victim, victim.OnHitTextLineSets, GetNarrativeDataValue( victim, "OnHitTextLinePriorities" ) )
		RemoveInputBlock({ Name = "ChronosOnHitConversation" })
		victim.TextLinesUseWeaponIdle = true
		PlayTextLines( victim, textLines )

	end
end

function StartChronosFakeBossMusic( source, args )
	SecretMusicPlayer( "/Music/IrisMinibossMusic" )
	SetSoundCueValue({ Names = { "Section", }, Id = AudioState.SecretMusicId, Value = 2 })
end

function StartChronosFakeBossPresentation( source, args )
	CreateHealthBar( source )
end

function ChronosExit( source, args )

	args = args or {}
	wait( args.WaitTime or 0 )

	RemoveEnemyUI( source )

	--SetAnimation({ Name = "Enemy_Chronos_Field_Casting", DestinationId = source.ObjectId })

	RemoveEnemyUI( source )

	StopSecretMusic( true )

	source.NextInteractLines = nil
	UseableOff({ Id = source.ObjectId })
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )

	wait( 0.5, RoomThreadName )
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.3 })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = source.ObjectId, Property = "StopsProjectiles", Value = false })
	CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = source.ObjectId })
	AdjustColorGrading({ Name = "Off", Duration = 1.35 })

	wait( 1.0, RoomThreadName )

	source.Mute = true
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[source.ObjectId] = args.AnimationState
	end

	if MapState.RoomRequiredObjects[source.ObjectId] ~= nil and not CurrentRun.Hero.IsDead then
		MapState.RoomRequiredObjects[source.ObjectId] = nil
		wait( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end
	end
end

function ShipsLeaveRoomPresentation( currentRun, exitDoor )

	AddInputBlock({ Name = "ShipsLeaveRoomPresentation" })
	
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "ShipsLeaveRoomPresentation" )

	local exitDoorId = exitDoor.ObjectId
	local door = MapState.OfferedExitDoors[exitDoorId]

	if door ~= nil then
		thread( DestroyDoorRewardPresenation, door )
		if door.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorOpenAnimation })
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
			wait( 0.7 )
		end
	end

	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = exitDoorId, DestinationIds = heroExitIds, Distance = 800 })
	if heroExitPointId <= 0 and exitDoorId ~= nil then
		heroExitPointId = exitDoorId
	end

	if not currentRun.CurrentRoom.BlockExitPan then
		PanCamera({ Id = heroExitPointId, Duration = 10.0 })
	end

	AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = heroExitPointId })
	AdjustZoom({ Fraction = (currentRun.CurrentRoom.ZoomFraction or 0.75) * 1.1, LerpTime = 1.2 })

	thread( PlayVoiceLines, HeroVoiceLines.ShipsExitVoiceLines, false )

	-- Mel cast anim 
	SetAnimation({ Name = "Melinoe_Cast_Start", DestinationId = currentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })
	
	-- start charging energy VFX
	CreateAnimation({ DestinationId = exitDoorId, Name = "ShipsDoorBeamIn" })
	wait( 0.9 )
	CreateAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "ShipsDoorCharge" })
	wait( 0.3 )

	-- energy shot VFX and camera effects
	PlaySound({ Name = "/SFX/Player Sounds/ApolloSpecialDetonateSFX" })
	--AdjustZoom({ Fraction = (currentRun.CurrentRoom.ZoomFraction or 0.75) * 0.9, LerpTime = 0.2 })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.2 })
	CreateAnimation({ DestinationId = exitDoorId, Name = "ShipsDoorBurst" })
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.1 })

	LeaveRoomAudio( currentRun, exitDoor )
	if exitDoor.Room.ExitTowardsFunctionName ~= nil then
		CallFunctionName( exitDoor.Room.ExitTowardsFunctionName, exitDoor, exitDoor.Room.ExitTowardsFunctionArgs )
	end

	--wait(0.4)
	wait(0.1)

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	--wait(0.2)
	wait(0.02)

	--SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.3 })
	FullScreenFadeOutAnimation( currentRun.CurrentRoom.FadeOutAnimation )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "ShipsLeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function ShipsRoomEntrancePresentation( currentRun, currentRoom )
	local roomData = RoomData[currentRoom.Name] or currentRoom
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or 0.3
	local roomIntroPanDuration = currentRoom.IntroPanDuration or 2.0

	if CurrentRun.BiomeDepthCache <= 2 then
		roomIntroSequenceDuration = roomIntroSequenceDuration + 1.5
		roomIntroPanDuration = roomIntroPanDuration + 1.5
	end
	
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75), LerpTime = 0.0 })
	else
		AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75) * 0.55, LerpTime = 0.0 })
	end
	--LockCamera({ Id = 558039, Duration = 0 })
	if currentRoom.CameraStartPoint then
		LockCamera({ Id = currentRoom.CameraStartPoint, Duration = 0 }) 
		CreateAnimation({ DestinationId = currentRoom.CameraStartPoint, Name = "ShipsGustSpawnerForward", GroupName = "Combat_UI_World" })
	end

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.0 })
	Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 30 })
	wait(0.03)

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()

	if currentRoom.CameraEndPoint ~= nil then
		local cameraSetupPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRoom.CameraEndPoint, OffsetX = -80, OffsetY = 30  })
		LockCamera({ Id = cameraSetupPoint, Duration = roomIntroSequenceDuration })
		--CreateAnimation({ DestinationId = currentRoom.CameraEndPoint, Name = "ShipsGustSpawnerForward", GroupName = "Combat_UI_World" })
		thread( GustWinds, { ObjectId = cameraSetupPoint, Count = 4 })

		local heroExitIds = GetIdsByType({ Name = "HeroExit" })
		local heroExitPointId = heroExitIds[1]
		thread( GustWinds, { ObjectId = heroExitPointId, AnimationName = "ShipsGustSpawnerForward", Count = 3 })
	end

	wait( roomIntroPanDuration )
	
	AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75), LerpTime = 0.2 })
	
	wait( 0.05 )

	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "ShipsDoorBurstArrival" })
	PlaySound({ Name = "/SFX/Player Sounds/ApolloSpecialDetonateSFX" })

	wait( 0.10 )

	PanCamera({ Id = currentRoom.CameraEndPoint, OffsetX = 70, OffsetY = -34, Duration = 0.2, Retarget = true })

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1, Duration = 0.1 })
	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "DustPuffA" })
	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "ProjectileTempFlare", OffsetZ = 80 })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeDash" })
	ShakeScreen({ Speed = 500, Distance = 8, FalloffSpeed = 1000, Duration = 0.2 })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or roomData.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	wait( 0.03 )
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
end

function RoomEntranceBossFields( currentRun, currentRoom, args )
	local startId = currentRoom.HeroEndPoint or CurrentRun.Hero.ObjectId
	local nearbyGhostWalls = GetIdsByType({ Names = { "H_GhostWall", "H_GhostWall_Sparse" } })

	if not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = nearbyGhostWalls, Fraction = 0, Duration = 0 })
	end
	RoomEntranceBoss( currentRun, currentRoom, args )
end

function RoomEntranceBossShips( currentRun, currentRoom, args )

	args = args or {}

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or 0.3
	local roomIntroPanDuration = currentRoom.IntroPanDuration or 1.5

	HideCombatUI("BossEntrance")
	wait(0.03)

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75), LerpTime = 0.0 })
	else
		AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75) * 0.75, LerpTime = 0.0 })
	end
	if currentRoom.CameraStartPoint then
		LockCamera({ Id = currentRoom.CameraStartPoint, Duration = 0 })
	end
	AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75) * 0.85, LerpTime = roomIntroPanDuration + 0.03 })
	PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomIntroPanDuration + roomIntroSequenceDuration, EaseIn = 0.2 })

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.0 })
	Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 30 })
	wait(0.03)

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()

	wait( roomIntroPanDuration )

	AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75), LerpTime = 0.2 })

	wait( 0.05 )

	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "ShipsDoorBurstArrival" })
	PlaySound({ Name = "/SFX/Player Sounds/ApolloSpecialDetonateSFX" })

	wait( 0.10 )

	--[[
	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomData.IntroCameraPanDuration or roomIntroSequenceDuration })
	end
	]]

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1, Duration = 0.1 })
	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "DustPuffA" })
	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "ProjectileTempFlare", OffsetZ = 80 })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeDash" })
	ShakeScreen({ Speed = 500, Distance = 8, FalloffSpeed = 1000, Duration = 0.2 })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

	wait(0.03)

	--[[
	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, AngleTowardsIdOnEnd = args.AngleTowardsIdOnEnd } )
	end
	]]

	wait(0.03)

	if roomData.ThreadEnterVoiceLines then

		thread( PlayVoiceLines, encounterData.EnterVoiceLines or roomData.EnterVoiceLines, true )
		thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
		wait( roomIntroSequenceDuration )

	else
		if PlayVoiceLines( encounterData.EnterVoiceLines or roomData.EnterVoiceLines or GlobalVoiceLines[roomData.EnterGlobalVoiceLines], true ) then
			wait(0.3)
		else
			wait(1.8)
		end
	end

	--wait( roomIntroSequenceDuration )
	--LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnblockCombatUI("BossEntrance")
end

function RoomEntranceCrawlerMiniBoss( currentRun, currentRoom )

	local crawlerId = 568815

	AddInputBlock({ Name = "RoomEntranceCrawlerMiniBoss" })

	EnterBiomeGRoomPresentation(currentRun, currentRoom)

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = crawlerId })
	AngleTowardTarget({ Id = crawlerId, DestinationId = CurrentRun.Hero.ObjectId })

	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or 2.0
	wait(0.03)

	PanCamera({ Id = 558001, Duration = roomIntroSequenceDuration + 1, EaseOut = 0, OffsetX = 150, OffsetY = -200 })
	AdjustZoom({ Fraction = 0.85, LerpTime = 2.0 })
	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true } )
	end

	thread( PlayVoiceLines, GlobalVoiceLines.CrawlerMiniBossEncounterStartVoiceLines, true )

	wait(roomIntroSequenceDuration)

	wait( 0.5 )

	SecretMusicPlayer( "/EmptyCue" )

	if GameState.EncountersOccurredCache.MiniBossCrawler > 1 then
		wait( 0.5 )
	else
		--SetAnimation({ Name = "ZagreusInteractionThoughtful", DestinationId = CurrentRun.Hero.ObjectId })
		wait( 2.5 )
	end

	AngleTowardTarget({ Id = crawlerId , DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/QuickSnap", Id = crawlerId })
	thread( InCombatText, crawlerId, "Alerted", 0.45, { SkipShadow = true } )
	CreateAnimation({ Name = "EliteUnitStatus2", DestinationId = crawlerId })
	wait( 0.25 )
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar", Id = crawlerId })
	SetAnimation({ Name = "Enemy_Crawler_RoarLoop", DestinationId = crawlerId })
	wait( 0.02 )

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.2 })
	Shake({ Id = crawlerId, Distance = 2, Speed = 300, Duration = 3, FalloffSpeed = 3000 })
	ShakeScreen({ Speed = 500, Distance = 5, FalloffSpeed = 2000, Duration = 1.0 })
	FocusCamera({ Fraction = 1.0, ZoomType = "Overshoot", Duration = 0.17 })
	AdjustZoom({ Fraction = currentRoom.ZoomFraction, LerpTime = 0.17 })
	CreateAnimation({ Name = "CrawlerSpawnsHowl", DestinationId = crawlerId })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

	wait( 0.5 )
	thread( EndTinyVerminRadialBlur )
	SetAnimation({ Name = "Enemy_Crawler_RoarReturnToIdle", DestinationId = crawlerId })

	SecretMusicPlayer( "/Music/IrisMinibossMusic" )
	SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = 2 })

	if GameState.EncountersOccurredCache.MiniBossCrawler > 1 then
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, ZoomType = "Ease", Duration = 1.0 })
		wait( 1.0 )
	else
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.0 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, ZoomType = "Ease", Duration = 2.0 })
		wait( 2.0 )
	end

	thread(SetupBoss, ActiveEnemies[crawlerId])

	RemoveInputBlock({ Name = "RoomEntranceCrawlerMiniBoss" })
	UnblockCombatUI("BossEntrance")
end

function RoomEntranceCharybdis( currentRun, currentRoom )

	local charybdisId = 737128
	local tentacleIds = { 737129, 737132, 737131, 737133, 737130, }

	AddInputBlock({ Name = "RoomEntranceCrawlerMiniBoss" })

	--SetAlpha({ Id = charybdisId, Fraction = 0, Duration = 0 })
	SetAlpha({ Ids = tentacleIds, Fraction = 0, Duration = 0 })

	ShipsRoomEntrancePresentation(currentRun, currentRoom)

	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or 2.0
	wait(0.03)

	PanCamera({ Id = charybdisId, Duration = roomIntroSequenceDuration + 1.1, EaseOut = 0, OffsetX = 150, OffsetY = -200 })

	wait( 0.5 )

	thread( PlayVoiceLines, GlobalVoiceLines.CharybdisEncounterStartVoiceLines, true )

	AdjustZoom({ Fraction = 0.55, LerpTime = roomIntroSequenceDuration + 1.1  })

	wait(roomIntroSequenceDuration)

	if GameState.EncountersOccurredCache.MiniBossCharybdis > 1 then
		wait( 0.5 )
	else
		--SetAnimation({ Name = "ZagreusInteractionThoughtful", DestinationId = CurrentRun.Hero.ObjectId })
		wait( 1.5 )
	end

	AngleTowardTarget({ Id = charybdisId , DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/QuickSnap", Id = charybdisId })
	thread( InCombatText, charybdisId, "Alerted", 0.45, { SkipShadow = true } )
	wait( 0.25 )
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar", Id = charybdisId })
	PlaySound({ Name = "/SFX/Enemy Sounds/Charybdis/EmoteAlerted", Id = charybdisId })
	SetAnimation({ Name = "Enemy_Charybdis_SpitFullStart", DestinationId = charybdisId })
	--SetAnimation({ Name = "Enemy_Charybdis_Appear", DestinationId = charybdisId })
	wait( 0.02 )

	SetAlpha({ Id = charybdisId, Fraction = 1, Duration = 0 })
	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.2 })
	Shake({ Id = charybdisId, Distance = 2, Speed = 300, Duration = 3, FalloffSpeed = 3000 })
	ShakeScreen({ Speed = 500, Distance = 5, FalloffSpeed = 2000, Duration = 1.0 })
	FocusCamera({ Fraction = 1.0, ZoomType = "Overshoot", Duration = 0.17 })
	AdjustZoom({ Fraction = currentRoom.ZoomFraction, LerpTime = 0.17 })
	CreateAnimation({ Name = "CrawlerSpawnsHowl", DestinationId = charybdisId })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

	wait( 2.5 )
	thread( EndTinyVerminRadialBlur )

	if GameState.EncountersOccurredCache.MiniBossCharybdis > 1 then
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, ZoomType = "Ease", Duration = 1.0 })
		wait( 1.0 )
	else
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.0 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, ZoomType = "Ease", Duration = 2.0 })
		wait( 2.0 )
	end

	--- FIGHT START
	
	SetAnimation({ Name = "Enemy_CharybdisTentacle_Surface", DestinationIds = tentacleIds })
	SetAlpha({ Ids = tentacleIds, Fraction = 1, Duration = 0 })

	thread(SetupBoss, ActiveEnemies[charybdisId])
	for k, id in pairs(tentacleIds) do
		thread(SetupBoss, ActiveEnemies[id])
	end

	RemoveInputBlock({ Name = "RoomEntranceCrawlerMiniBoss" })
	UnblockCombatUI("BossEntrance")
end

function EndTinyVerminRadialBlur()
	wait(0.8)
	AdjustRadialBlurDistance({ Fraction = 0.0, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.0, Duration = 0.2 })
end

function RoomEntranceBossBiomeG( currentRun, currentRoom, args )
	args = args or {}

	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	AdjustFullscreenBloom({ Name = "NewType09" })
	local dropShadow = SpawnObstacle({ Name = "DrownedChambersEntranceShadowFade", DestinationId =  currentRoom.HeroEndPoint, OffsetY = -12, OffsetX = 0 })
	SetAlpha({ Id = dropShadow, Fraction = 0.2, Duration = 0.01 })
	SetScale({ Id = dropShadow, Fraction = 0.05, Duration = 0.01 })
	SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 0, Duration = 0.2 })
	wait(0.03)

	SetAlpha({ Id = dropShadow, Fraction = 0.80, Duration = 0.8 })
	SetScale({ Id = dropShadow, Fraction = 0.20, Duration = 0.8 })
	if currentRoom.HeroEndPoint ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = args.AngleTowardsIdOnEnd })
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	end
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0, OffsetY = -150 })
	AdjustZLocation({ Id = currentRun.Hero.ObjectId, Distance = 1800, Duration = 0.0 })
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.2, EaseIn = 0, Retarget = true})
	wait(0.03)

	ApplyUpwardForce({ Id = currentRun.Hero.ObjectId, Speed = -100 })
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.3)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	wait(0.03)

	SetAnimation({ Name = "Melinoe_Drop_Entrance_Fire", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = dropShadow, Fraction = 0, Duration = 0.03 })
	ShakeScreen({ Speed = 150, Distance = 6, Duration = 0.15, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.18, Duration = 0.8 }, } )
	
	wait (0.33)

	CreateAnimation({ Name = "MelEntranceSplash", DestinationId = CurrentRun.Hero.ObjectId })

	if PlayVoiceLines( currentRoom.EnterVoiceLines or GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true ) then
		wait(0.3)
	else
		wait(1.8)
	end

	-- wait( roomIntroSequenceDuration )
	UnblockCombatUI("BossEntrance")
end

function RoomEntranceChronos( currentRun, currentRoom, args )

	args = args or {}

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter

	FadeOut({ Duration = 0.0, Color = Color.ChronosSand })
	AdjustColorGrading({ Name = "Off", Duration = 0.0 })

	HideCombatUI("BossEntrance")
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.0 })
	AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = args.LandingTarget })
	--PanCamera({ Id = currentRoom.HeroStartPoint, Duration = 0.01, EaseIn = 0, EaseOut = 0 })
	PanCamera({ Id = currentRoom.CameraStartPoint, Duration = 0.01, EaseIn = 0, EaseOut = 0 })

	if AudioState.WaterSoundId == nil then
		AudioState.WaterSoundId = PlaySound({ Name = "/SandAmbienceLOUD" })
	end

	wait(0.03)

	--PanCamera({ Id = currentRoom.CameraEndPoint, Duration = 10.5, EaseOut = 0.2 })
	FadeIn({ Duration = 0.65 })
	--FullScreenFadeInAnimation()

	wait(1.0)

	--PlaySound({ Name = "/Leftovers/World Sounds/BigSplash", Id = CurrentRun.Hero.ObjectId })
	ShakeScreen({ Speed = 200, Distance = 3, FalloffSpeed = 1000, Duration = 0.25 })
	SetAnimation({ Name = "Melinoe_DiveEntrance_Start", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "CWSandBurstBossEntrance", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top"  })
	CreateAnimation({ Name = "MelSandEmitterA", DestinationId = CurrentRun.Hero.ObjectId  })
	CreateAnimation({ Name = "MelSandEmitterB", DestinationId = CurrentRun.Hero.ObjectId  })
	CreateAnimation({ Name = "MelSandEmitterC", DestinationId = CurrentRun.Hero.ObjectId  })
	CreateAnimation({ Name = "MelSandEmitterD", DestinationId = CurrentRun.Hero.ObjectId  })

	if AudioState.WaterSoundId ~= nil then
		StopSound({ Id = AudioState.WaterSoundId, Duration = 0.2 })
		AudioState.WaterSoundId = nil
	end

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 0.0 })

	thread( PlayVoiceLines, encounterData.EnterVoiceLines or roomData.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[roomData.EnterGlobalVoiceLines], true )

	thread( DisplayInfoBanner, nil, { Text = "Location_IBoss01", Delay = 1.0, Color = Color.White, FadeColor = Color.Red } )
	CheckCodexUnlock( "Biomes", "BiomeHouse" )

	wait(0.1)
	thread( MoveHeroToRoomPosition, { DestinationId = args.LandingTarget, DisableCollision =  true, Speed = 500 })
	PanCamera({ Id = args.LandingTarget, Duration = 0.65, OffsetX = -300, OffsetY = 25, EaseOut = 0, Retarget = true })
	wait(0.60)
	PanCamera({ Id = args.LandingTarget, Duration = 1.3, OffsetX = -50, OffsetY = 50, EaseIn = 0, Retarget = true })
	wait( 0.45 )

	StopAnimation({ Name = "MelSandEmitterA", DestinationId = CurrentRun.Hero.ObjectId  })
	StopAnimation({ Name = "MelSandEmitterB", DestinationId = CurrentRun.Hero.ObjectId  })
	StopAnimation({ Name = "MelSandEmitterC", DestinationId = CurrentRun.Hero.ObjectId  })
	StopAnimation({ Name = "MelSandEmitterD", DestinationId = CurrentRun.Hero.ObjectId  })

	ShakeScreen({ Speed = 70, Distance = 3, FalloffSpeed = 1000, Angle = 90, Duration = 0.33 })
	wait( 1.45 )

	FocusCamera({ Fraction = currentRoom.ZoomFraction * 0.95, Duration = 8.5 })
	PanCamera({ Id = currentRoom.CameraEndPoint, Duration = 4.5, EaseIn = 0.1, EaseOut = 0 })

	wait(1.6)

	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, AngleTowardsIdOnEnd = args.AngleTowardsIdOnEnd } )
	end

	wait( 1.0 )
	StartFinalBossChronosIntroMusic()

	wait( 2.9 )

	UnblockCombatUI("BossEntrance")
end

function RoomEntrancePortalFields( currentRun, currentRoom )
	local startId = currentRoom.HeroEndPoint or CurrentRun.Hero.ObjectId
	local nearbyGhostWalls = GetIdsByType({ Names = { "H_GhostWall", "H_GhostWall_Sparse" } })

	if not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = nearbyGhostWalls, Fraction = 0, Duration = 0 })
	end

	RoomEntrancePortal( currentRun, currentRoom )
end

-- see also: NemesisExit
function NemesisLeaveRoomPresentation( nemesis, exitDoor )

	nemesis.Exiting = true
	local exitDoorId = exitDoor.ObjectId
	local door = MapState.OfferedExitDoors[exitDoorId]
	thread( PlayVoiceLines, nemesis.ExitVoiceLines, true )	
	StopSecretMusicTheme( nemesis )

	Stop({ Id = nemesis.ObjectId })
	wait(0.25)
	SetAnimation({ DestinationId = nemesis.ObjectId, Name = "Nemesis_Combat_Interact" })

	if door ~= nil then
		DestroyDoorRewardPresenation( door )
		if door.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorOpenAnimation })
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
			PlaySound({ Name = "/SFX/AdminDoorCloseSFX", Id = exitDoorId })
			wait( 0.7 )
		end
	end

	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = exitDoorId, DestinationIds = heroExitIds, Distance = 800 })
	if not exitDoor.NemesisTeleport and heroExitPointId > 0 then
		--PanCamera({ Id = heroExitPointId, Duration = 10.0 })
		SetUnitProperty({ DestinationId = nemesis.ObjectId, Property = "CollideWithObstacles", Value = false })
		local args = {}
		args.SuccessDistance = 30
		args.MoverId = nemesis.ObjectId
		args.SkipInputBlock = true
		local exitPath = exitDoor.ExitPath or CurrentRun.CurrentRoom.ExitPath or {}
		if door ~= nil and door.ExitThroughCenter then
			table.insert( exitPath, door.ObjectId )
		end
		table.insert( exitPath, heroExitPointId )
		thread( MoveHeroAlongPath, exitPath, args )
	else
		SetAlpha({ Id = nemesis.ObjectId, Fraction = 0, Duration = 1.0 })
		--SetAnimation({ DestinationId = nemesis.ObjectId, Name = CurrentRun.CurrentRoom.ExitAnimation or RoomData.BaseSecret.ExitAnimation })
		CreateAnimation({ DestinationId = nemesis.ObjectId, Name = CurrentRun.CurrentRoom.ExitVfx or RoomData.BaseSecret.ExitVfx })
		if door ~= nil and door.ExitPortalSound then
			PlaySound({ Name = door.ExitPortalSound or "/SFX/Menu Sounds/ChaosRoomEnterExit" })
		end
	end

	--LeaveRoomAudio( currentRun, exitDoor )

	wait(0.4)

	nemesis.Mute = true

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		StopAnimation({ DestinationId = exitDoorId, Names = { "ChaosDoorOpen", "ChaosDoorFloor"} })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	SetAlpha({ Id = nemesis.ObjectId, Fraction = 0.0, Duration = 1.0 })
	thread( DestroyOnDelay, { nemesis.ObjectId }, 1.0 )
end

function AttemptUseDoorNemesisTookPresentation( exitDoor )
	DebugPrint({ Text = "AttemptUseDoorNemesisTookPresentation" })

	if CheckCooldown( "DoorLocked", 1.6 ) then
		PlaySound({ Name = exitDoor.LockedUseSound or RoomData.BaseRoom.LockedUseSound, Id = exitDoor.ObjectId })
		thread( PlayVoiceLines, HeroVoiceLines.ExitBlockedByNemesisVoiceLines, true )
		thread( InCombatText, CurrentRun.Hero.ObjectId, "ExitBlockedByNemesis", 1.5, { ShadowScale = 0.66, ShadowScaleX = 0.9 } )
		if exitDoor.DoorShakeSelf ~= nil then
			Shake({ Id = exitDoor.ObjectId, Distance = 1.5, Speed = 200, Duration = 0.125 })
		end
	end
end

function LeaveRoomSecretDoorPresentation( currentRun, secretDoor )
	HideCombatUI( "LeaveRoomSecretDoorPresentation" )
	AddInputBlock({ Name = "LeaveRoomSecretDoorPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )

	-- preserve audio/VO presentation
	PlaySound({ Name = "/SFX/Menu Sounds/ChaosRoomEnterExit" })
	thread( PlayVoiceLines, HeroVoiceLines.SecretUnlockedVoiceLines )
	thread( InCombatText, secretDoor.ObjectId, "SecretPassageOpened", 1 )
	Stop({ Id = CurrentRun.Hero.ObjectId })

	-- Previously these were 1.1 and 4.5, lowered to match the VO to the timing of the damage
	if GameState.TextLinesRecord.ChaosFirstPickUp then
		wait( 0.5 )
	else
		wait( 3.9 )
	end

	-- Mel plays her MelinoeInteract animation from WeaponData
	PlayInteractAnimation( secretDoor.ObjectId, { Animation = "MelinoeBoonPreInteract" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.7 }, } )
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.5, MinFraction = 0, MaxFraction = 1.0, Color = Color.White, Duration = 1.0, ExpireAfterCycle = false })
	AdjustColorGrading({ Name = secretDoor.EntranceColorGrade or "Chaos", Duration = 0.7 })

	wait(0.6)

	-- The 'damage hit' happens here
	if secretDoor.HealthCost ~= nil and secretDoor.HealthCost > 0 then
		CreateAnimation({ Name = "SacrificeHealthFx", DestinationId = CurrentRun.Hero.ObjectId })
		thread( DisplayPlayerDamageText, { triggeredById = CurrentRun.Hero.ObjectId, PercentMaxDealt = secretDoor.HealthCost/CurrentRun.Hero.MaxHealth, DamageAmount = secretDoor.HealthCost } )
	end
	AdjustFullscreenBloom({ Name = "NewType09", Duration = 0.1 })

	wait( 0.2 )

	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
	PlaySound({ Name = "/Leftovers/SFX/PlayerRespawn" })

	-- She goes through the Oceanus-style sequence of jumping up and in
	PanCamera({ Id = secretDoor.ObjectId, Duration = 1.1, OffsetY = -50, EaseOut = 0 })	

	wait( 0.5 )	

	SetAnimation({ Name = "Melinoe_Drop_Exit_Start", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })

	wait( 0.35 )

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading" })
	local args = {}
	args.SuccessDistance = 20
	args.DisableCollision = true
	local exitPath = {}
	table.insert( exitPath, secretDoor.ObjectId )
	thread( MoveHeroAlongPath, exitPath, args )	
	
	wait( 0.2 )
	
	PanCamera({ Id = secretDoor.ObjectId, Duration = 1.2, OffsetY = 85, Retarget = true})
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.25 }, } )
	thread( SlightDescent )
	
	local doorHeal = GetDoorHealAmount( CurrentRun )
	if doorHeal > 0 then
		thread( OnPlayerHealed, { ActualHealAmount = doorHeal } )
	end

	FullScreenFadeOutAnimation()

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomSecretDoorPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function LeaveRoomSecretExitDoorPresentation( currentRun, secretDoor )
	HideCombatUI( "LeaveRoomSecretExitDoorPresentation" )
	AddInputBlock({ Name = "LeaveRoomSecretExitDoorPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )

	LeaveRoomAudio( currentRun, secretDoor )
	--thread( PlayVoiceLines, HeroVoiceLines.OceanusExitVoiceLines, true )

	if secretDoor ~= nil then
		if secretDoor.AdditionalIcons ~= nil and not IsEmpty( secretDoor.AdditionalIcons ) then
			Destroy({ Ids = GetAllValues( secretDoor.AdditionalIcons ) })
			secretDoor.AdditionalIcons = nil
		end
		DestroyDoorRewardPresenation( secretDoor )
		if secretDoor.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = secretDoor.ObjectId, Name = secretDoor.ExitDoorOpenAnimation })
		end
	end

	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait (0.01)

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })
	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	PanCamera({ Id = secretDoor.ObjectId, Duration = 1.1, OffsetY = -50, EaseOut = 0 })
	
	wait( 0.5 )	

	SetAnimation({ Name = "Melinoe_Drop_Exit_Start", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })
	
	wait( 0.35 )

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading" })
	local args = {}
	args.SuccessDistance = 20
	args.DisableCollision = true
	local exitPath = {}
	table.insert( exitPath, secretDoor.ObjectId )
	thread( MoveHeroAlongPath, exitPath, args )	
	
	wait( 0.2 )
	
	PanCamera({ Id = secretDoor.ObjectId, Duration = 1.2, OffsetY = 85, Retarget = true})
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.25 }, } )
	thread( SlightDescent )

	FullScreenFadeOutAnimation()
	
	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomSecretExitDoorPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function PlayerUseBiomeGDoorPresentation( exitDoor )

	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait (0.01)

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })
	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.1, OffsetY = -50, EaseOut = 0 })
	
	wait( 0.5 )	

	SetAnimation({ Name = "Melinoe_Drop_Exit_Start", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })
	
	wait( 0.35 )

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading" })
	local args = {}
	args.SuccessDistance = 20
	args.DisableCollision = true
	local exitPath = {}
	table.insert( exitPath, exitDoor.ObjectId )
	thread( MoveHeroAlongPath, exitPath, args )	
	
	wait( 0.20 )
	
	thread( SlightDescent )
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.2, OffsetY = 85, Retarget = true})
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.25 }, } )
end

function SlightDescent()
	wait( 0.05 )
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 0.12 )
	AdjustZLocation({ Id = CurrentRun.Hero.ObjectId, Distance = -25, Duration = 0.5, })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
end

function ExitBiomeGRoomPresentation( currentRun, exitDoor )
	AddInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "ExitBiomeGRoomPresentation" )
	LeaveRoomAudio( currentRun, exitDoor )

	thread( PlayerUseBiomeGDoorPresentation, exitDoor )

	if exitDoor ~= nil then
		if exitDoor.AdditionalIcons ~= nil and not IsEmpty( exitDoor.AdditionalIcons ) then
			Destroy({ Ids = GetAllValues( exitDoor.AdditionalIcons ) })
			exitDoor.AdditionalIcons = nil
		end
		DestroyDoorRewardPresenation( exitDoor )
		if exitDoor.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoor.ObjectId, Name = exitDoor.ExitDoorOpenAnimation })
		end
	end
	thread( PlayVoiceLines, HeroVoiceLines.OceanusExitVoiceLines, true )

	wait( 0.92 )

	FullScreenFadeOutAnimation()

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )	
end

function EnterBiomeGRoomPresentation( currentRun, currentRoom )
	AddInputBlock({ Name = "BiomeGRoomEntrance" })
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	AdjustFullscreenBloom({ Name = "NewType09" })

	local dropShadow = SpawnObstacle({ Name = "DrownedChambersEntranceShadowFade", DestinationId =  currentRoom.HeroEndPoint, OffsetY = -12, OffsetX = 0 })
	SetAlpha({ Id = dropShadow, Fraction = 0.2, Duration = 0.01 })
	SetScale({ Id = dropShadow, Fraction = 0.05, Duration = 0.01 })
	wait(0.03)
	SetAlpha({ Id = dropShadow, Fraction = 0.80, Duration = 0.8 })
	SetScale({ Id = dropShadow, Fraction = 0.20, Duration = 0.8 })
	if currentRoom.HeroEndPoint ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	end
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0, OffsetY = -150 })
	AdjustZLocation({ Id = currentRun.Hero.ObjectId, Distance = 1800, Duration = 0.0 })
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.2, EaseIn = 0, Retarget = true})
	wait(0.03)

	ApplyUpwardForce({ Id = currentRun.Hero.ObjectId, Speed = -100 })
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })

	--local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	wait(0.3)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	wait(0.03)

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	thread(DelayedRemoveInputBlock, 0.35, "BiomeGRoomEntrance")
	wait (0.33)
	SetAnimation({ Name = "Melinoe_Drop_Entrance_Fire", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = dropShadow, Fraction = 0, Duration = 0.03 })
	ShakeScreen({ Speed = 150, Distance = 6, Duration = 0.15, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.18, Duration = 0.8 }, } )
	CreateAnimation({ Name = "MelEntranceSplash", DestinationId = CurrentRun.Hero.ObjectId })
end

function LeaveRoomHBossPresentation( currentRun, exitDoor )
	LeaveRoomSecretExitDoorPresentation( currentRun, exitDoor )
end

function LeaveRoomHPostBossPresentation( currentRun, exitDoor, args )

	HideCombatUI( "LeaveRoomHPostBossPresentation" )
	AddInputBlock({ Name = "LeaveRoomHPostBossPresentation" })

	Stop({ Id = CurrentRun.Hero.ObjectId })
	MoveHeroToRoomPosition({ DestinationId = args.MoveTargetId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = exitDoor.ObjectId })
	SetAnimation({ Name = "Blank", DestinationId = exitDoor.ObjectId })
	wait( 0.65 )

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })

	local soundId = nil

	thread( PlayVoiceLines, GlobalVoiceLines.PostBossHiddenExitUsedVoiceLines, true )

	-- Door opening	
	if IsGameStateEligible( currentRun, args.FirstVisitRequirements ) then

		PanCamera({ Id = exitDoor.ObjectId, Duration = 2.1, OffsetY = -50, EaseOut = 0 })

		wait(1.0)

		local loopingSoundId = PlaySound({ Name = "/SFX/Menu Sounds/CauldronWhispers", Id = CurrentRun.Hero.ObjectId })
		

		wait(0.5)

		SetAnimation({ Name = "Melinoe_Gesture_ToWeaponless", DestinationId = CurrentRun.Hero.ObjectId })
		CreateAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
		CreateAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
		CreateAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
		CreateAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
		
		wait(0.3)

		CreateAnimation({ Name = "CWEntranceHadesSymbolIn", DestinationId = 637439, OffsetZ = 200 })

		wait(2.3)

		PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = CurrentRun.Hero.ObjectId })
		StopAnimation({ Name = "CWEntranceDoorGlowAnim", DestinationId = exitDoor.ObjectId })

		wait(0.4)

		
		StopSound({ Id = loopingSoundId, Duration = 0.4 })
		loopingSoundId = nil

		ShakeScreen({ Distance = 8, Speed = 500, Duration = 0.3, FalloffSpeed = 1000 })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 3.0 }, } )

		SetScale({ Ids = { 566218, 556772, 556773 }, Fraction = 0.0, Duration = 0.0 })
		CreateAnimation({ Name = "CWEntranceDoorOpen", DestinationId = 566218 })
		

		PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusRockThrowImpact", Id = 556772 })

		soundId = PlaySound({ Name = "/SFX/Menu Sounds/CWTrapDoorSlide", })
		SetVolume({ Id = soundId, Value = 2.0 })
		wait(0.05)
		StopAnimation({ Name = "CWEntranceHadesSymbolLoop", DestinationId = 637439 })
		AdjustFullscreenBloom({ Name = "FullscreenFlash2", Duration = 0.0 })
		AdjustFullscreenBloom({ Name = "Off", Duration = 1 })
		wait(0.95)
		StopAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId })
		StopAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId })
		StopAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId })
		StopAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId })

		SetAnimation({ Name = "MelinoeIdleWeaponless", DestinationId = CurrentRun.Hero.ObjectId })

		wait(1.0)

	else
		wait(0.4)
		StopAnimation({ Name = "CWEntranceDoorGlowAnim", DestinationId = exitDoor.ObjectId })
		wait(0.4)
		SetScale({ Ids = { 566218, 556772, 556773 }, Fraction = 0.0, Duration = 0.0 })
		CreateAnimation({ Name = "CWEntranceDoorOpen", DestinationId = 566218 })
		PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusRockThrowImpact", Id = 556772 })

		soundId = PlaySound({ Name = "/SFX/Menu Sounds/CWTrapDoorSlide", })
		SetVolume({ Id = soundId, Value = 2.0 })

		wait(0.75)
	end

	StopSound({ Id = soundId, Duration = 0.1 })

	wait(0.2)

	LeaveRoomAudio( currentRun, exitDoor )
	--thread( PlayVoiceLines, HeroVoiceLines.OceanusExitVoiceLines, true )

	SetAnimation({ Name = "Melinoe_Drop_Exit_Start", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })
	
	wait( 0.35 )

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.2 }, } )
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading" })
	local args = {}
	args.SuccessDistance = 20
	args.DisableCollision = true
	local exitPath = {}
	table.insert( exitPath, exitDoor.ObjectId )
	thread( MoveHeroAlongPath, exitPath, args )	
	
	wait( 0.2 )
	
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.2, OffsetY = 85, Retarget = true})
	thread( SlightDescent )

	FullScreenFadeOutAnimation()
	RemoveInputBlock({ Name = "LeaveRoomHPostBossPresentation" })
end

function LeaveRoomIPreBossPresentation( currentRun, exitDoor )
	HideCombatUI( "LeaveRoomIPreBossPresentation" )
	AddInputBlock({ Name = "LeaveRoomIPreBossPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )

	LeaveRoomAudio( currentRun, exitDoor )
	--thread( PlayVoiceLines, HeroVoiceLines.OceanusExitVoiceLines, true )

	SetAnimation({ Name = "Blank", DestinationId = exitDoor.ObjectId })

	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait (0.01)

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = exitDoor.ObjectId })
	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.1, OffsetY = -50, EaseOut = 0 })
	
	wait( 1.0 )	

	SetAnimation({ Name = "Melinoe_DiveExit_Start", DestinationId = CurrentRun.Hero.ObjectId })
	
	wait( 0.53 )

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.25 }, } )
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading" })
	PlaySound({ Name = "/Leftovers/SFX/PlayerJumpMedium" })
	local args = {}
	args.SuccessDistance = 20
	args.DisableCollision = true
	local exitPath = {}
	table.insert( exitPath, exitDoor.ObjectId )
	thread( MoveHeroAlongPath, exitPath, args )

	wait( 0.1 )

	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.2, OffsetY = 85, Retarget = true})

	wait( 0.6 )
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.3 })
	CreateAnimation({ Name = "CWSandBurst", DestinationId = 712195, Group = "Standing"  })
	PlaySound({ Name = "/SFX/SandDive", Id = 712195 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.3, Duration = 0.2 }, } )

	AudioState.WaterSoundId = PlaySound({ Name = "/Ambience/SandAmbienceLoop" })
	AdjustColorGrading({ Name = "ChronosSand", Duration = 1 })
	wait(1.0)
	FadeOut({ Duration = 0.5, Color = Color.ChronosSand })
	wait( 0.5 )

	--FullScreenFadeOutAnimation()
	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomIPreBossPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function NightmareFlickerPresentation( delay )

	local requirements =
	{
		NamedRequirements = { "NightmarePresentationRequirements" },
		ChanceToPlay = 0.2
	}
	if not IsGameStateEligible( CurrentRun, requirements ) then
		return false
	end


	wait( delay )
	local firstRun = false
	if GetCompletedRuns() < 1 then
		firstRun = true
	end
	local numFlickers = 3
	local flickerSceneDuration = 1.6
	local nightmareImages =
	{ 
		--HandShake_01_Characters = { StartScale = 1.1, EndScale = 0.58, ScaleVariance = 0.1 },
		--Nightmare_ThroneRoom = { StartScale = 1.1, EndScale = 0.58, ScaleVariance = 0.2, StartOffsetX = 300, StartOffsetY = 200 },
		--Nightmare_Chronos_01 = { StartScale = 2.0, EndScale = 1.8, ScaleVariance = 0, StartOffsetX = 160, StartOffsetY = 1410 },
		--Nightmare_Chronos_02 = { StartScale = 1.0, EndScale = 0.58, ScaleVariance = 0, StartOffsetX = 0, StartOffsetY = 0 },
		Nightmare_Crossroads_01 = { StartScale = 1.2, EndScale = 0.58, ScaleVariance = 0.2, StartOffsetX = 160, StartOffsetY = 100 },
		Nightmare_Crossroads_02 = { StartScale = 1.4, EndScale = 1.1, ScaleVariance = 0.0, StartOffsetX = 1200, StartOffsetY = 100 },
		Nightmare_Crossroads_04 = { StartScale = 1.1, EndScale = 0.58, ScaleVariance = 0.1, StartOffsetY = 100 },
		Nightmare_Crossroads_05 = { StartScale = 1.1, EndScale = 0.58, ScaleVariance = 0.3, StartOffsetY = 200 },
		Nightmare_Crossroads_06 = { StartScale = 1.1, EndScale = 0.58, ScaleVariance = 0.5, StartOffsetY = 200 },
		Nightmare_Ships = { StartScale = 1.0, EndScale = 0.58, ScaleVariance = 0.1, StartOffsetY = 0 },
		Nightmare_Isles_01 = { StartScale = 1.1, EndScale = 0.58, ScaleVariance = 0.3, StartOffsetY = 300 },
		Nightmare_Isles_02 = { StartScale = 1.1, EndScale = 0.58, ScaleVariance = 0.3, StartOffsetY = 300 },
		Nightmare_Ships = { StartScale = 1.1, EndScale = 0.58, ScaleVariance = 0.3, StartOffsetY = 300 },
		--Nightmare_Moons = { StartScale = 1.1, EndScale = 0.58, ScaleVariance = 0.3, StartOffsetY = 0 },
	}

	UnloadVoiceBanks({});
	LoadVoiceBanks({ Name = "Intercom" })

	local nightmareAmbientSoundId = PlaySound({ Name = "/Leftovers/Object Ambiences/HandAmbience" })

	FadeOut({ Duration = 0.15, Color = Color.Black })
	thread( HadesSpeakingPresentation, { LineHistoryName = "NPC_Chronos_01", }, { BlockScreenshake = true, VoiceLines = GlobalVoiceLines.ChronosDeathTauntVoiceLines } )
	wait( 0.2 )
	local randomSound = GetRandomValue({ "/Music/ARStinger_Strings_2", "/Music/ARStinger_Strings_3", "/Music/ARStinger_Strings_4" })
	if firstRun then
		PlaySound({ Name = "/Music/ARStinger_Strings_4" })
	else
		PlaySound({ Name = randomSound })
	end
	for index = 1, numFlickers, 1 do
		local fullScreenImage = GetRandomKey( nightmareImages )
		if firstRun then
			if index == 1 then
				fullScreenImage = "Nightmare_Crossroads_01"
			elseif index == 2 then
				fullScreenImage = "Nightmare_Crossroads_02"
			elseif index == 3 then
				fullScreenImage = "Nightmare_Crossroads_04"
			elseif index == 4 then
				fullScreenImage = "Nightmare_Crossroads_05"
			end
 		end
		local fullScreenImageData = nightmareImages[fullScreenImage]
		thread( ShowFullScreenImage, fullScreenImage, fullScreenImageData, flickerSceneDuration )
		PlaySound({ Name = "/SFX/HeartPulsate1" })
		wait( 0.03 )
		thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.2 }, } )
		FadeIn({ Duration = 0.15 })
		wait( flickerSceneDuration )
		--PlaySound({ Name = "/SFX/HeartPulsate2" })
		FadeOut({ Duration = 0.15, Color = Color.Black })
		wait( 0.16 )
	end
	GameState.NightmaresOccurred = ( GameState.NightmaresOccurred or 0 ) + 1
	CurrentRun.NightmareOccurred = true,

	StopSound({ Id = nightmareAmbientSoundId, Duration = 2 })
	nightmareAmbientSoundId = nil

	wait( 1.2 )

	--FadeIn({ Duration = 0.3 })
end

function ChaosInteractPresentation( source, args, textLines )

	if textLines ~= nil and not textLines.IgnoreInteractAnimation then
		local interactAnim = textLines.InteractAnimation or source.InteractAnimation
		if interactAnim == nil and textLines.PlayOnce then
			interactAnim = "StatusIconWantsToTalkBoon"
		end
		if interactAnim ~= nil then
			CreateAnimation({ Name = interactAnim, DestinationId = source.ObjectId, OffsetZ = source.AnimOffsetZ })
		end
	end

	Shake({ Id = source.ObjectId, Distance = 2, Speed = 300, Duration = 3, FalloffSpeed = 3000 })
	AdjustColorGrading({ Name = "ChaosInversion", Duration = 0 })
	AdjustColorGrading({ Name = "Chaos", Duration = 1 })
	AdjustFullscreenBloom({ Name = "FullscreenFlash", Duration = 0.6 })
	AdjustRadialBlurDistance({ Fraction = 8, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = 0.2 })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenChaosDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColorDark", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	local boonSound = PlaySound({ Name = "/SFX/Menu Sounds/ChaosBoonConfirm" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	wait( 0.5 )
	ChaosBassStart()

	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.5 }, } )

	wait(0.06)

	AdjustRadialBlurDistance({ Fraction = 8, Duration = 2 })
	AdjustRadialBlurStrength({ Fraction = 1, Duration = 2 })
	AdjustColorGrading({ Name = "Off", Duration = 3.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 3.0 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 5.0 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })

	if args ~= nil then
		wait( args.PickupWait )
	end
end

function ElementalIconsUnlockedPresentation( id )
	SetAlpha({ Id = id, Fraction = 1, Duration = 0.8 })
	thread( PulseText, {Id = id, ScaleTarget = 1.35, ScaleDuration = 0.5, HoldDuration = 0.0 })
	wait(0.1)
	CreateAnimation({ Name = "ProjectileTempFlare", DestinationId = id, Group = "Combat_Menu_Overlay" })
	PlaySound({ Name = "/SFX/Player Sounds/ElectricZapSmall", Id = id })
	thread( PlayVoiceLines, HeroVoiceLines.ElementsUnlockedVoiceLines )
end

function FirstUnityBoonPresentation( id )
	CreateAnimation({ Name = "ProjectileTempFlare", DestinationId = id, Group = "Combat_Menu_Overlay" })
	thread( PlayVoiceLines, HeroVoiceLines.FirstUnityBoonUnlockedVoiceLines )
end

function BiomeMapPresentation( source, args )

	local labelData =
	{
		{ Text = "BiomeF", OffsetX = -700, OffsetY = 250 },
		{ Text = "BiomeG", OffsetX = 0, OffsetY = 530 },
	},

	AddInputBlock({ Name = "BiomeMapPresentation" })
	local groupName = "Combat_UI"
	local backgroundId = CreateScreenObstacle({ Name = "rectangle01", Group = groupName, X = ScreenCenterX, Y = ScreenCenterY, Scale = 10.0, Color = Color.Black })
	local biomeMapId = CreateScreenObstacle({ Name = "BlankObstacle", Group = groupName, X = ScreenCenterX, Y = ScreenCenterY, Animation = "GUI\\BiomeMap\\BiomeMap" })

	for k, label in pairs( labelData ) do
		CreateTextBox({
			Id = biomeMapId,
			Text = label.Text,
			OffsetX = label.OffsetX,
			OffsetY = label.OffsetY,
			Font = "LatoBoldItalic",
			FontSize = 32,
			Color = Color.Purple,
			Justification = "Center"
		})
	end

	local melId = CreateScreenObstacle({ Name = "BlankObstacle3D", Group = groupName, X = ScreenCenterX, Y = ScreenCenterY, Scale = 1.0 })
	SetThingProperty({ Property = "GrannyModel", Value = "MelMarker_Mesh", DestinationId = melId })
	SetAnimation({ Name = "MelMarkerIdle", DestinationId = melId })
	if args.StartOffsetX ~= nil then
		Move({ Id = biomeMapId, OffsetX = -args.StartOffsetX, OffsetY = -args.StartOffsetY, Duration = 0.0, ShiftThingsByOffset = true })
		Move({ Id = melId, OffsetX = -args.HeroStartOffsetX, OffsetY = -args.HeroStartOffsetY, Duration = 0.0, ShiftThingsByOffset = true })
	end
	local melAngle = math.atan2( -args.MoveOffsetY, args.MoveOffsetX )
	SetAngle({ Id = melId, Angle = math.deg( melAngle ) })
	FullScreenFadeInAnimation()
	wait( 2.0 )
	SetAnimation({ Name = "MelMarkerMove", DestinationId = melId })
	Move({ Id = biomeMapId, OffsetX = -args.MoveOffsetX, OffsetY = -args.MoveOffsetY, Duration = args.MoveDuration, EaseIn = args.MoveEaseIn, EaseOut = args.MoveEaseOut, ShiftThingsByOffset = true })
	wait( args.MoveDuration )
	SetAnimation({ Name = "MelMarkerJump", DestinationId = melId })
	wait( 1.5 )
	FullScreenFadeOutAnimation()
	RemoveInputBlock({ Name = "BiomeMapPresentation" })
end

function BouldyHitPresentation( victim )
	local source = ActiveEnemies[ GetClosestUnitOfType({ Id = victim.ObjectId, DestinationName = "NPC_Hades_Field_01", Distance = 9999 }) ]
	thread( PlayVoiceLines, source.OnHitVoiceLines, true, source )
end

function BiomeOverlook( room, args )
	if not MapState.InOverlook and IsEmpty(RequiredKillEnemies) then
		MapState.InOverlook = true

		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 0.5 })
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "Keys" }, Value = 0.0, Duration = 3.0 })
		SetVolume({ Id = AudioState.MusicId, Value = 0.7, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")
		ToggleCombatControl( CombatControlsDefaults, false, "Overlook" )

		wait( 0.1, "OverlookThread" )
		if MapState.InOverlook then
			local overlookTime = args.Duration or 8
			local overlookEaseInTime = args.EaseIn or 0
			local overlookEaseOutTime = args.EaseOut or 3
			PanCamera({ Id = args.PanTargetId, Duration = overlookTime, EaseIn = overlookEaseInTime, EaseOut = overlookEaseOutTime, Retarget = true })
			if args.ZoomFraction then
				FocusCamera({ Fraction = args.ZoomFraction, Duration = overlookTime, ZoomType = "Ease" })
			end
		end
	end
end

function BiomeOverlookShips( room, args )
	if not MapState.InOverlook and IsEmpty(RequiredKillEnemies) then
		MapState.InOverlook = true

		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 0.5 })
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "Keys" }, Value = 0.0, Duration = 3.0 })
		SetVolume({ Id = AudioState.MusicId, Value = 0.7, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")
		AddInputBlock({ Name = "BiomeOverlookShips" })

		wait( 0.1, "OverlookThread" )
		if MapState.InOverlook then
			local overlookTime = args.Duration or 8
			local overlookEaseInTime = args.EaseIn or 0
			local overlookEaseOutTime = args.EaseOut or 3
			PanCamera({ Id = args.PanTargetId, Duration = overlookTime, EaseIn = overlookEaseInTime, EaseOut = overlookEaseOutTime, Retarget = true })
			if args.ZoomFraction then
				FocusCamera({ Fraction = args.ZoomFraction, Duration = overlookTime, ZoomType = "Ease" })
			end
		end
		wait( args.BlackoutDuration )
		FadeOut({ Color = Color.Black, Duration = 0.1 })
		wait( args.BlackDuration )
		FadeIn({ Duration = 0.3 })
		thread( WaitForEndOverlookAdvancedInput, room, args, "BiomeBackToRoomShips" )
	end
end

function BiomeBackToRoomShips( room, args )
	BiomeBackToRoom( room, args )
	wait(0.5)
	RemoveInputBlock({ Name = "BiomeOverlookShips" })
end

function ExitToAnomalyPresentation(currentRun, exitDoor)
	AddInputBlock({ Name = "LeaveRoomPresentation" })
	LoadVoiceBanks({ Name = "Intercom" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "ExitToAnomalyPresentation" )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = exitDoor.ObjectId })

	local chronos = DeepCopyTable( EnemyData.NPC_Chronos_01 )
	local textLines = GetRandomEligibleTextLines( chronos, chronos.DeathPresentationTextLineSets, {} )


	-- Oceanus exit presentation
	if exitDoor ~= nil then
		DestroyDoorRewardPresenation( exitDoor )
		if exitDoor.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoor.ObjectId, Name = exitDoor.ExitDoorOpenAnimation })
		end
	end
	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait (0.01)

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })
	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.1, OffsetY = -50, EaseOut = 0 })
	wait(0.5)	
	ModifySubtitles({ SuppressLyrics = true })
	SecretMusicPlayer( "/Music/BlankMusicCue" )
	AudioState.AmbienceId = PlaySound({ Name = "/Leftovers/Ambience/MatchSiteAAmbience" })
	
	SetAnimation({ Name = "Melinoe_Drop_Exit_Start", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })

	wait (0.35)

	local args = {}
	args.SuccessDistance = 20
	args.DisableCollision = true
	local exitPath = {}
	table.insert( exitPath, exitDoor.ObjectId )
	thread( MoveHeroAlongPath, exitPath, args )	

	CurrentRun.Hero.ExitAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })

	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof" })
	Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 4, Speed = 300, Duration = 3.0 })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHurt", Delay = 0.2 })

	wait (0.4)
	--end Oceanus

	local firstVisitRequirements =
	{
		{
			PathFalse = { "GameState", "TextLinesRecord", "ChronosAnomalyIntro01" }
		},
		{
			PathFalse = { "GameState", "TextLinesRecord", "ChronosAnomalyIntro01_B" }			
		}
	}

	-- Anomaly effects
	if IsGameStateEligible( currentRun, firstVisitRequirements ) then
		thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, WaitTime = 3, ColorGrade = "Rain", VoiceLines = GlobalVoiceLines.AnomalyLocatedVoiceLines } )
		wait(0.25)
		CreateAnimation({ Name = "Invincibubble", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = 40, })

		wait(4.5)

		local chronos = DeepCopyTable( EnemyData.NPC_Chronos_01 )
		local nearbyId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "SpawnPoints" }, Distance = 500 })

		chronos.ObjectId = SpawnUnit({ Name = "NPC_Chronos_01", Group = "Standing", DestinationId = nearbyId })
		SetupUnit( chronos, CurrentRun, { IgnoreAI = true, } )
		SetAlpha({ Id = chronos.ObjectId, Fraction = 0, Duration = 0 })
		AngleTowardTarget({ Id = chronos.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

		SetAlpha({ Id = chronos.ObjectId, Fraction = 1, Duration = 0.3 })
		CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = chronos.ObjectId })

		PanCamera({ Ids = chronos.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		local chronosTimeSlowSoundId = PlaySound({ Name = "/SFX/Player Sounds/TimeSlowLoop" })
		ChronosTimeSlowPresentation( { IgnoreSoundLoop = true } )

		wait( 2.5 )

		PlayTextLines( chronos, textLines )
		SetAudioEffectState({ Name = "ChronosSlow", Value = 0 })
		PlaySound({ Name = "/SFX/Player Sounds/TimeSlowEnd" })
		StopSound({ Id = chronosTimeSlowSoundId, Duration = 0.3 })
	else
		thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, WaitTime = 3, ColorGrade = "Rain", OverlayAnim = "ChronosOverlay", VoiceLines = GlobalVoiceLines.AnomalyLocatedVoiceLines } )
		wait(0.25)
		CreateAnimation({ Name = "Invincibubble", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = 40, })
		wait(2.75)
	end

	LeaveRoomAudio( currentRun, exitDoor )
	ModifySubtitles({ SuppressLyrics = false })
	wait(0.29)
	CreateAnimation({ Name = "BoonOrbFrontFlare", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0, Duration = 0.24 })
	StopAnimation({ Name = "Invincibubble", DestinationId = CurrentRun.Hero.ObjectId })

	--EndTimeSlowPresentation()

	wait(0.01)
	FullScreenFadeOutAnimation()

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end


function AnomalyEntrancePresentation(currentRun, currentRoom, args)
	AddInputBlock({ Name = "AnomalyEntrancePresentation" })
	--AdjustFullscreenBloom({ Name = "NewType09" })
	--wait(0.03)

	if currentRoom.HeroEndPoint ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	end
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0 })
	SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = CurrentRun.Hero.ExitAngle or 240, CompleteAngle = true })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.0 })

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()

	wait(0.5)

	CreateAnimation({ Name = "BoonOrbFrontFlare", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "Invincibubble", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = 40, })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 1.0, Duration = 0.6 })
	SetAnimation({ Name = "Melinoe_Drop_Exit_FireLoop", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/Player Sounds/DemeterColdNovaRush", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteGasping", Id = CurrentRun.Hero.ObjectId, Delay = 0.2 })

	wait(0.8)
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.6 })
	StopAnimation({ Name = "BoonOrbFrontFlare", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "Invincibubble", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/EnemyPhaseInPoofSFX", Id = CurrentRun.Hero.ObjectId })

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	wait(0.2)
	CreateAnimation({ Name = "DustPuffBNoDecal", DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Melinoe_Drop_Entrance_Fire", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/BallLand", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/FootstepsWheatHeavy2", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/FootstepsWheatHeavy2", Id = CurrentRun.Hero.ObjectId, Delay = 0.2 })

	if currentRoom.LocationText and not currentRoom.Encounter.BlockLocationText then
		thread( DisplayInfoBanner, nil, { Text = currentRoom.LocationText, Delay = 0.65, FadeColor = currentRoom.LocationTextColor or { 255, 0, 0, 255 }, Duration = 2.0 } )
	end
	thread(DelayedRemoveInputBlock, 0.1, "AnomalyEntrancePresentation")
end

-- See also: CapturePointEncounterStartPresentation
function AnomalyStartPresentation(eventSource, args)

	LoadVoiceBanks({ Name = "Intercom" })

	wait( 0.75 )

	thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, ColorGrade = "Rain", OverlayAnim = "ChronosOverlay", VoiceLines = GlobalVoiceLines.AnomalyEnteredVoiceLines, StartSound = "/SFX/TimeSlowStart" } )

	--AdjustFullscreenBloom({ Name = "Off", Duration = 5.0 })
	--AdjustColorGrading({ Name = "Off", Duration = 10.0 })
	
	CheckObjectiveSet("AnomalyStart")

	wait( 6.66 )

	thread( PlayVoiceLines, HeroVoiceLines.AnomalySearchingForExitVoiceLines, true )

end

-- See also: CapturePointEncounterStartPresentation
function AnomalyEndPresentation(eventSource, args)

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	StopSecretMusic( true )

	thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = GlobalVoiceLines.AnomalySurvivedVoiceLines, StartSound = "/SFX/TimeSlowStart" } )

	thread( PlayVoiceLines, HeroVoiceLines.AnomalyEncounterSurvivedVoiceLines, true )

end

function AnomalyExitPresentation(currentRun, exitDoor)
	AddInputBlock({ Name = "AnomalyExitPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "AnomalyExitPresentation" )

	LeaveRoomAudio( currentRun, exitDoor )
	wait(0.1)

	SetAnimation({ Name = "MelinoeDeathEscape", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 1.8 })

	wait(1.15)
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic" })
	wait(0.2)
	CreateAnimation({ Name = "DeathSequenceFxFront", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "DeathSequenceFxBack", DestinationId = CurrentRun.Hero.ObjectId })

	waitUnmodified( 1.05 )
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.7 }, } )
	waitUnmodified( 0.25 )
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.25 })
	waitUnmodified( 1.2 )
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow", Id = CurrentRun.Hero.ObjectId })

	FullScreenFadeOutAnimation()

	RemoveInputBlock({ Name = "AnomalyExitPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
	ClearAllControlBlocks()
	ClearAllMoveBlocks()
end

function EntranceFromAnomalyPresentation(currentRun, currentRoom, args)

	AddInputBlock({ Name = "EntranceFromAnomalyPresentation" })
	local roomData = RoomData[currentRoom.Name] or currentRoom
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0

	SetAnimation({ Name = "MelinoeDeathReEnterHeadUp", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })

	if currentRoom.HeroEndPoint ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
		PanCamera({ Id = currentRoom.HeroEndPoint, Duration = 0 })
	end
	wait(0.03)

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	
	if roomData.DoorEntranceAnimation ~= nil then
		thread( DoorEntranceAnimation, roomData.DoorEntranceAnimation)
	end
	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomData.IntroPanDuration or roomIntroSequenceDuration })
	end

	waitUnmodified( 0.4 )
	SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "Melinoe_Combat_Return_ReEnter" })

	-- thread( HadesSpeakingPresentation, {}, { StartDelay = 0, SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = GlobalVoiceLines.AnomalyConcludedVoiceLines, StartSound = "/SFX/TimeSlowStart" } )
	thread( PlayVoiceLines, GlobalVoiceLines.AnomalyConcludedVoiceLines, true )

	if currentRoom.LocationText and not currentRoom.Encounter.BlockLocationText then
		thread( DisplayInfoBanner, nil, { Text = currentRoom.LocationText, Delay = 0.65, FadeColor = currentRoom.LocationTextColor or { 255, 0, 0, 255 }, Duration = 2.0 } )
	end
	wait( roomIntroSequenceDuration )

	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })

	RemoveInputBlock({ Name = "EntranceFromAnomalyPresentation" })
end

function ScyllaActivatePresentation(enemy)
	SetAlpha({ Ids = { 616658 }, Fraction = 0, Duration = 1.0 }) -- Destroy Spotlight
	SetAlpha({ Ids = GetIds({ Name = "StageLights" }), Fraction = 0.25, Duration = 1.0 }) -- Dim lights
end

function HubMapViewPresentationStart()
	local roomData = RoomData[CurrentRun.CurrentRoom.Name]
	roomData.NHubMapView = true
	PanCamera({ Id = 660497, FromCurrentLocation = true, Duration = 0.65, ZoomType = "Undershoot" })
	FocusCamera({ Fraction = 0.30, Duration = 0.65 })
	ClearCameraClamp({ LerpTime = 0.15 })
end

function HubMapViewPresentationEnd()
	local roomData = RoomData[CurrentRun.CurrentRoom.Name]
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.3, Retarget = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.3 })
	if not roomData.IgnoreClamps then
		local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
		DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is non-sensical" })
		SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	end
	wait( 0.31 )
	roomData.NHubMapView = false
end

function HandleNHubWingDimmers( room, args )

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end
	CurrentRun.ClosedDoors.N_Hub = CurrentRun.ClosedDoors.N_Hub or {}

	for groupName, doorIds in pairs(args) do
		local shouldDim = true
		for k, doorId in pairs(doorIds) do
			if CurrentRun.ClosedDoors.N_Hub[doorId] == nil and (CurrentRun.CurrentRoom.UnavailableDoors == nil or CurrentRun.CurrentRoom.UnavailableDoors[doorId] == nil) then
				shouldDim = false
			end
		end

		if shouldDim then
			Destroy({ Ids = GetIds({ Name = groupName }) })
		end
	end
end

function BountyBoardUnlockedFirstPresentation(room, args)

	wait( 1.0 )
	local bountyBoardId = 561146

	AddInputBlock({ Name = "BountyBoardUnlockedFirstPresentation" })
	
	HideCombatUI( "BountyBoardUnlockedFirstPresentation" )
	ClearCameraClamp({ LerpTime = 1.35 })
	thread( PlayVoiceLines, HeroVoiceLines.BountyBoardUnlockedVoiceLines, true )

	ScreenAnchors.LetterBoxTop = ScreenAnchors.LetterBoxTop or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY - 1220 })
	ScreenAnchors.LetterBoxBottom = ScreenAnchors.LetterBoxBottom or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY + 1220 })
	SetScale({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 5 })
	SetColor({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Color = Color.Black })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 1.0, Duration = 0 })
	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 270, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 90, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	wait( 1.35 )

	PanCamera({ Id = bountyBoardId, Duration = 2.6, EaseIn = 0, EaseOut = 0.99 })
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

	ScreenAnchors.LetterBoxTop = ScreenAnchors.LetterBoxTop or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY - 1220 })
	ScreenAnchors.LetterBoxBottom = ScreenAnchors.LetterBoxBottom or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY + 1220 })
	SetScale({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 5 })
	SetColor({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Color = Color.Black })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 1.0, Duration = 0 })
	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 270, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 90, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	wait( 1.35 )

	PanCamera({ Id = shrineId, Duration = 2.6, EaseIn = 0, EaseOut = 0.99 })
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

	ScreenAnchors.LetterBoxTop = ScreenAnchors.LetterBoxTop or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY - 1220 })
	ScreenAnchors.LetterBoxBottom = ScreenAnchors.LetterBoxBottom or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY + 1220 })
	SetScale({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 5 })
	SetColor({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Color = Color.Black })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 1.0, Duration = 0 })
	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 270, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 90, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

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

function FieldsRoomEntrancePresentation( currentRun, currentRoom )
	local startId = currentRoom.HeroEndPoint or CurrentRun.Hero.ObjectId
	local nearbyGhostWalls = GetIdsByType({ Names = { "H_GhostWall", "H_GhostWall_Sparse" } })

	if not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = nearbyGhostWalls, Fraction = 0, Duration = 0 })
	end

	RoomEntranceStandard( currentRun, currentRoom )
end

function FieldsLeaveRoomPresentation( currentRun, exitDoor )
	
	local nearbyGhostWalls = GetClosestIds({ Id = exitDoor.ObjectId, DestinationIds = GetIdsByType({ Names = { "H_GhostWall", "H_GhostWall_Sparse" } }), Distance = 2000 })

	SetAnimation({ DestinationIds = nearbyGhostWalls, Name = "GhostWallFadeOut" })
	SetAlpha({ Ids = nearbyGhostWalls, Fraction = 0, Duration = 1.0 })

	thread( PlayVoiceLines, HeroVoiceLines.FieldsExitVoiceLines, true )
	LeaveRoomPresentation( currentRun, exitDoor )
end

function FieldsBridgeCharonMusic()
	wait(1)
	SecretMusicPlayer( "/Music/CharonShopTheme" )
end

function FieldsBridgeEchoMusic()
	wait(1)
	SecretMusicPlayer( "/Music/MusicExploration3_MC" )
end

function StartFinalBossChronosIntroMusic()
	StopSecretMusic( true )
	MusicPlayer( "/Music/ChronosBossFightMusic" )
	SetMusicSection( 8, MusicId )
end
function StartFinalBossChronosMusic()
	MusicPlayer( "/Music/ChronosBossFightMusic" )
	SetMusicSection( 0, MusicId )
end

function StartFinalBossChronos( source, args )
	thread( ChronosThronePresentation, source, args )
	StartFinalBossChronosMusic()
end

function ChronosThronePresentation( source, args )
	FocusCamera({ Fraction = 1.1, Duration = 6.0, ZoomType = "Ease" })
	SetAnimation({ Name = "Enemy_Chronos_BattleIntro_Start", DestinationId = source.ObjectId })
	wait(0.67)
	thread( MoveHeroToRoomPosition, { MoverId = source.ObjectId, DestinationId = source.ChronosFightStartMoveId, Speed = 120, DisableCollision =  true, })
	wait(0.85)
	Destroy({ Ids = GetIds({ Name = "ChronosFightStartDelete" }) })
	wait(3.5)
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1.0, ZoomType = "Ease" })
end

function ShipsExitsUnlockedPresentation()
	thread( PlayVoiceLines, HeroVoiceLines.ShipsCanExitVoiceLines, false )
end

function ShipsSteeringWheelChoicePresentation( wheel )
	local heroId = CurrentRun.Hero.ObjectId
	PanCamera({ Ids = { heroId, wheel.ObjectId }, Duration = 2.5 })
	FocusCamera({ Fraction = 0.965, Duration = 2.5, ZoomType = "Ease" })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/NauticalBell", Id = wheelId }) 
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0.0, Duration = 0.25 })
	--thread( GustWinds, { ObjectId = wheel.ObjectId, Count = 2 } )
	thread( PlayVoiceLines, HeroVoiceLines.ShipsRouteChoiceOfferedVoiceLines, false, CurrentRun.Hero, { Wheel = wheel } )
end

function ShipsSteeringWheelSelectionPresentation( wheelId )
	ResumeMusic()
	thread( RandomStemMixer, CurrentRun.CurrentRoom, AudioState.MusicId )
end

function ShipWheelUsedPresentation( wheel )
	AddInputBlock({ Name = "UseShipWheel" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })
	SetPlayerInvulnerable( "ShipWheelUsedPresentation" )

	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/NauticalBellCharon", Id = wheelId })

	for id, unit in pairs(ActiveEnemies) do
		if unit.DieOnWheelUse then
			thread(Kill, unit)
			thread( PlayVoiceLines, HeroVoiceLines.ShipsMutinyVoiceLines, true )
		end
	end

	thread( PlayInteractAnimation, wheel.ObjectId, { Animation = GetEquippedWeaponValue( "WeaponInteractAnimation" ) } )
	--ShakeScreen({ Angle = 135, Distance = 8, Speed = 300, FalloffSpeed = 1000, Duration = 2.0 })

	thread( PlayVoiceLines, HeroVoiceLines.ShipsRouteChoiceMadeVoiceLines, false, CurrentRun.Hero, { Wheel = wheel } )

	CurrentRun.CurrentRoom.WindSound = PlaySound({ Name = "/Leftovers/SFX/WindAmbienceLocal" })
	PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })
end


function ShipWheelEnd( rewardWheel )
	wait( 0.5 )

	UseShipWheel( rewardWheel )

	local wheelObstacleId = GetIdsByType({ Name = "ShipsSteeringWheel" })[1]
	local wheelObstacle = MapState.ActiveObstacles[wheelObstacleId]

	if CurrentRun.CurrentRoom.Encounter.LastEncounter then
		thread( DestroyShipWheelPresentation, wheelObstacle )
	end


	local heroId = CurrentRun.Hero.ObjectId
	PanCamera({ Id = heroId, Duration = 1.0, OffsetX = 0, OffsetY = 0, Retarget = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1.0, ZoomType = "Ease" })

	StopSound({ Id = CurrentRun.CurrentRoom.WindSound, Duration = 3.0 })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
	RemoveInputBlock({ Name = "UseShipWheel" })
	UnblockCombatUI( "UseShipWheel" )
	SetPlayerVulnerable( "ShipWheelUsedPresentation" )
end

function UseShipWheelForward( wheel )
	
	if not IsEmpty( MapState.RoomRequiredObjects ) then
		thread( CannotUseDoorPresentation, wheel )
		return
	end

	UseableOff({ Id = wheel.ObjectId })
	RefreshUseButton( wheel.ObjectId, wheel )
	ShipWheelUsedPresentation( wheel )
	SetAnimation({ Name = "ShipsSteeringWheel_Forward", DestinationId = wheel.ObjectId })
	thread( GustWinds, { ObjectId = wheel.ObjectId, Count = 4 } )
	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = heroExitIds[1]
	thread( GustWinds, { ObjectId = heroExitPointId, AnimationName = "ShipsGustSpawnerLeft", Count = 3 } )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetX = 50, OffsetY = -100, Duration = 1.0, Retarget = true, FromCurrentLocation = true })
	ShakeScreen({ Angle = 45, Distance = 20, Speed = 20, FalloffSpeed = 5, Duration = 1.0 })
	wait( 0.5 )
	ShipWheelEnd( wheel )
end

function UseShipWheelLeft( wheel )
	
	if not IsEmpty( MapState.RoomRequiredObjects ) then
		thread( CannotUseDoorPresentation, wheel )
		return
	end

	ShipWheelUsedPresentation( wheel )
	SetAnimation({ Name = "ShipsSteeringWheel_Left", DestinationId = wheel.WheelObstacleId })
	thread( GustWinds, { ObjectId = wheel.ObjectId, AnimationName = "ShipsGustSpawnerLeft", Count = 4 } )
	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = heroExitIds[1]
	thread( GustWinds, { ObjectId = heroExitPointId, AnimationName = "ShipsGustSpawnerLeft", Count = 3 } )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetX = -100, OffsetY = -50, Duration = 1.0, Retarget = true, FromCurrentLocation = true })
	ShakeScreen({ Angle = 135, Distance = 20, Speed = 20, FalloffSpeed = 5, Duration = 1.0 })
	wait( 0.5 )
	ShipWheelEnd( wheel )
end

function UseShipWheelRight( wheel )
	
	if not IsEmpty( MapState.RoomRequiredObjects ) then
		thread( CannotUseDoorPresentation, wheel )
		return
	end
	
	ShipWheelUsedPresentation( wheel )
	SetAnimation({ Name = "ShipsSteeringWheel_Right", DestinationId = wheel.WheelObstacleId })
	thread( GustWinds, { ObjectId = wheel.ObjectId, AnimationName = "ShipsGustSpawnerRight", Count = 4 } )
	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = heroExitIds[1]
	thread( GustWinds, { ObjectId = heroExitPointId, AnimationName = "ShipsGustSpawnerLeft", Count = 3 } )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetX = 100, OffsetY = 50, Duration = 1.0, Retarget = true, FromCurrentLocation = true })
	ShakeScreen({ Angle = 225, Distance = 20, Speed = 20, FalloffSpeed = 5, Duration = 1.0 })
	wait( 0.5 )
	ShipWheelEnd( wheel )
end

function GustWinds( args )
	local count = args.Count or 1
	local animation = args.AnimationName or "ShipsGustSpawnerForward"

	for index = 0, count, 1 do
		local randomOffsetX = RandomFloat( -1200, 1200 )
		local randomOffsetY = RandomFloat( -350, 350 )
		CreateAnimation({ DestinationId = args.ObjectId, Name = animation, OffsetX = randomOffsetX, OffsetY = randomOffsetY })
		wait( RandomFloat( 0.6, 1.1 ) )
		PlaySound({ Name = "/SFX/WindGust", DestinationId = args.ObjectId })
	end
end

function GustWindBoss( args )
	local count = args.Count or 1
	local animation = args.AnimationName or "ShipsGustSpawnerForward"

	for index = 0, count, 1 do
		local randomOffsetX = RandomFloat( -200, 200 )
		local randomOffsetY = RandomFloat( -250, 250 )
		CreateAnimation({ DestinationId = args.ObjectId, Name = animation, OffsetX = randomOffsetX, OffsetY = randomOffsetY, Scale = 2.0, GroupName = "Combat_Menu_TraitTray_Overlay_Text" })
		-- wait( RandomFloat( 0.6, 1.1 ) )
		PlaySound({ Name = "/SFX/WindGust", DestinationId = args.ObjectId })
	end
end


function DestroyShipWheelPresentation( wheel )
	wait( 0.75 )
	CreateAnimation({ DestinationId = wheel.ObjectId, Name = "ZagGrenadeExplosionBase", Scale = 1.8 })
	PlaySound({ Name = "/SFX/Explosion1", DestinationId = wheel.ObjectId })
	wait(0.1)
	SpawnObstacle({ Name = "ShipsSteeringWheelDestroyed", DestinationId = wheel.ObjectId, Group = "Standing" })
	Destroy({ Id = wheel.ObjectId })

	thread( PlayVoiceLines, HeroVoiceLines.ShipsWheelDestroyedVoiceLines )

	if AudioState.MusicSection == 0 then
		SetMusicSection( 1 )
	end
end