function StopMiniBossMusic( eventSource )
	StopSecretMusic( true )
end

function StartRoomPresentation( currentRun, currentRoom, metaPointsAwarded )
	ShowingCombatUI = nil
	AddInputBlock({ Name = "StartRoomPresentation" })
	ZeroMouseTether( "StartRoomPresentation" )
	local prevRoom = GetPreviousRoom( currentRun )

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local prevRoomData = nil
	if prevRoom ~= nil then
		prevRoomData = RoomData[prevRoom.Name]
	end

	SetConfigOption({ Name = "FullscreenEffectGroup", Value = roomData.FullscreenEffectGroup or "Vignette" })

	GatherRoomPresentationObjects( currentRun, currentRoom )

	if roomData.CameraZoomWeights ~= nil then
		for id, weight in pairs( roomData.CameraZoomWeights ) do
			SetCameraZoomWeight({ Id = id, Weight = weight, ZoomSpeed = 1.0 })
		end
	end
	if roomData.ZoomFraction then
		AdjustZoom({ Fraction = roomData.ZoomFraction })
	else
		AdjustZoom({ Fraction = 1.0 })
	end

	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or 0.8
	if not roomData.IgnoreClamps then
		local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
		DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is non-sensical" })
		SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	end

	if currentRoom.CameraStartPoint ~= nil and currentRoom.CameraStartPoint > 0 then
		LockCamera({ Id = currentRoom.CameraStartPoint, Duration = 0 })
	else
		LockCamera({ Id = currentRun.Hero.ObjectId })
	end
	if currentRoom.HeroStartPoint ~= nil then
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroStartPoint, OnlyIfDestinationExits = true })
	end

	StartRoomAmbience( currentRun, currentRoom )
	thread( StartRoomMusic, currentRun, currentRoom )

	if currentRoom.CloseDoorOnReturn ~= nil then
		if MapState.ActiveObstacles[currentRoom.CloseDoorOnReturn] ~= nil and MapState.ActiveObstacles[currentRoom.CloseDoorOnReturn].CloseOnReturnAnimation ~= nil then
			SetAnimation({ Name = MapState.ActiveObstacles[currentRoom.CloseDoorOnReturn].CloseOnReturnAnimation, DestinationId = currentRoom.CloseDoorOnReturn })
		end
		currentRoom.CloseDoorOnReturn = nil
	end

	local roomEntranceFunctionName = "RoomEntranceStandard"
	local roomEntranceFunctionArgs = {}

	local nextRoomEntranceFunctionName = nil
	local nextRoomEntranceFunctionArgs = nil
	if prevRoomData ~= nil and prevRoomData.NextRoomEntranceFunctionName ~= nil then
		nextRoomEntranceFunctionName = prevRoomData.NextRoomEntranceFunctionName
		nextRoomEntranceFunctionArgs = prevRoomData.NextRoomEntranceFunctionArgs
	end
	if prevRoom then
		nextRoomEntranceFunctionName = prevRoom.NextRoomEntranceFunctionNameOverride or nextRoomEntranceFunctionName
		nextRoomEntranceFunctionArgs = prevRoom.NextRoomEntranceFunctionArgsOverride or nextRoomEntranceFunctionName
	end
	roomEntranceFunctionName = nextRoomEntranceFunctionName or roomEntranceFunctionName
	roomEntranceFunctionArgs = nextRoomEntranceFunctionArgs

	roomEntranceFunctionName = currentRoom.ForcedEntranceFunctionName or roomData.EntranceFunctionName or roomEntranceFunctionName
	roomEntranceFunctionArgs = currentRoom.ForcedEntranceFunctionArgs or roomData.EntranceFunctionArgs or roomEntranceFunctionArgs
	for i, priority in ipairs( RoomEventData.EntranceFunctionNamePriorities ) do
		if prevRoomData ~= nil and priority == nextRoomEntranceFunctionName then
			roomEntranceFunctionName = nextRoomEntranceFunctionName
			roomEntranceFunctionArgs = nextRoomEntranceFunctionArgs
			break
		elseif priority == roomData.EntranceFunctionName then
			roomEntranceFunctionName = roomData.EntranceFunctionName
			roomEntranceFunctionArgs = roomData.EntranceFunctionArgs
			break
		end
	end

	CallFunctionName( roomEntranceFunctionName, currentRun, currentRoom, roomEntranceFunctionArgs )
	RemoveInputBlock({ Name = "StartRoomPresentation" })

	if metaPointsAwarded ~= nil and metaPointsAwarded > 0 then
		MetaPointRoomRewardPresentation(metaPointsAwarded)
	end

	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })

	if not roomData.BlockCameraReattach then
		thread( ReattachCameraOnInput, currentRun )
	else
		UnzeroMouseTether( "StartRoomPresentation" )
	end

end

function GetDefaultClampIds()
	local clampIds = GetIdsByType({ Name = "CameraClamp" })
	table.sort( clampIds )
	return clampIds
end

function RestoreUnlockRoomExitsPresentation( currentRun, currentRoom )
	ZeroMouseTether( "StartRoomPresentation" )

	GatherRoomPresentationObjects( currentRun, currentRoom )

	if currentRoom.CameraZoomWeights ~= nil then
		for id, weight in pairs( currentRoom.CameraZoomWeights ) do
			SetCameraZoomWeight({ Id = id, Weight = weight, ZoomSpeed = 1.0 })
		end
	end
	if currentRoom.ZoomFraction then
		AdjustZoom({ Fraction = currentRoom.ZoomFraction })
	else
		AdjustZoom({ Fraction = 1.0 })
	end

	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or 0.8
	local cameraClamps = currentRoom.CameraClamps or GetDefaultClampIds()
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is non-sensical" })
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = currentRoom.SoftClamp })

	LockCamera({ Id = currentRun.Hero.ObjectId })

	StartRoomAmbience( currentRun, currentRoom )

	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })

	UnzeroMouseTether( "StartRoomPresentation" )

	wait(0.2) -- Let camera transitions finish before fade in
	FadeIn({ Duration = 0.5 })

end

function RoomEntranceMaterialize( currentRun, currentRoom, args )

	HideCombatUI( "RoomEntranceOpening" )
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter

	-- scene setup
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0 })
	SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "MelinoeDeathReEnter" })

	if( currentRun.Hero.AttachedLightId ~= nil ) then
		SetAlpha({ Id = currentRun.Hero.AttachedLightId, Fraction = 0 })
	end
	
	if args.HeroGoalAngle then
		SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = args.HeroGoalAngle, CompleteAngle = true })
	else
		SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 270, CompleteAngle = true })
	end
	if currentRoom.HeroStartPoint ~= nil then
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroStartPoint })
	end

	local zoomStart = args.ZoomStartFraction or currentRoom.ZoomStartFraction or 0.65
	LockCamera({ Id = currentRoom.CameraStartPoint })
	AdjustZoom({ Fraction = zoomStart, LerpTime = 0.02 })
	PanCamera({ Id = currentRoom.CameraEndPoint, Duration = 6.0, OffsetY = -60 })
	wait(0.02)
	AdjustZoom({ Fraction = currentRun.CurrentRoom.ZoomFraction or 0.75, LerpTime = 8.0 })
	PanCamera({ Id = currentRoom.CameraEndPoint, Duration = 6.0, EaseIn = 0, Retarget = true })
	--AdjustZoom({ Fraction = currentRun.CurrentRoom.ZoomFraction or 0.75, LerpTime = 6.0 })
	
	wait( 0.1 )
	
	FadeIn({ Duration = 1.0 })
	FullScreenFadeInAnimation()

	wait( 2.0 )

	local healTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRoom.CameraEndPoint })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic2" })
	CreateAnimation({ Name = "BoonDropFrontFlare", DestinationId = healTarget, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "DeathSequenceFxBack", DestinationId = healTarget, Group = "Combat_UI_World_Add" })
	CreateAnimation({ Name = "DeathSequenceFxFront", DestinationId = healTarget, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
	--SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {0, 1, 0.6, 1}, Duration = 2.0, EaseIn = 0, EaseOut = 1 })
	--waitUnmodified( 1.0 )
	--SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {1, 1, 1, 1}, Duration = 0.25, EaseIn = 0, EaseOut = 0.5 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	ShakeScreen({ Angle = 90, Distance = 6, Speed = 300, FalloffSpeed = 300, Duration = 0.5 })
	thread( PlayVoiceLines, roomData.EnterVoiceLines or encounterData.EnterVoiceLines, true )

	wait( 0.8 )

	-- scene start
	
	--[[local healTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRun.Hero.ObjectId })
	
	CreateAnimation({ Name = "RespawnCircle", DestinationId = healTarget, Group = "FX_Terrain_Add" })
	CreateAnimation({ Name = "RespawnHadesSymbol", DestinationId = healTarget, Group = "Standing_Back_Add" })
	CreateAnimation({ Name = "MelRespawnHeal", DestinationId = healTarget, Group = "FX_Standing_Add" })
	]]

	--CreateAnimation({ Name = "ConsecrationFlareSpectral", DestinationId = healTarget, Group = "FX_Standing_Add" })
	
	SetFixedDashPresentationValues()
	FireWeaponFromUnit({ Weapon = "WeaponBlink", Id = CurrentRun.Hero.ObjectId })
	thread( HeroAlphaDelay, currentRun, 0.30 )
	Destroy({ Id = healTarget })

	wait( 0.3 )
	
	EndFixedDashPresentationValues()
	--[[
	local heroDestination = currentRoom.HeroEndPoint
	Move({ Id = heroId, DestinationId = heroDestination, SuccessDistance = 32 })
	SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "" })
	]]

	thread( RoomOpeningUIDelay )
end

function RoomEntranceBountyStart( currentRun, currentRoom, args )

	AdjustColorGrading({ Name = "Team03", Duration = 0.01 })
	AdjustFullscreenBloom({ Name = "GoldBloom", Duration = 0.01 })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = -50, Duration = 0.01, Retarget = true, EaseIn = 0, EaseOut = 0.1 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 0.92, Duration = 0.01 })
	
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.CurrentRoom.HeroEndPoint })
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.CurrentRoom.HeroEndPoint })
	SetAnimation({ Name = "MelinoeCrossCastAnticReverse", DestinationId = CurrentRun.Hero.ObjectId, PlaySpeed = 0.15 })

	--CreateAnimation({ Name = "TeleportDisappear", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorcerySummonPresentationFx", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = CurrentRun.Hero.ObjectId, Scale = 0.5 })

	wait( 0.03 )
	local trialIntroDuration = 1.7
	FadeIn({ Duration = 0.3 })
	FullScreenFadeInAnimation()
	PlaySound({ Name = "/SFX/Menu Sounds/ChaosRoomEnterExit" })

	CreateAnimation({ Name = "SorceryLeapRiseStreaks", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitter", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitterBright", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "SorceryLeapFlightStreakEmitterDisplace", DestinationId = CurrentRun.Hero.ObjectId })

	AdjustColorGrading({ Name = "Off", Duration = trialIntroDuration })
	AdjustFullscreenBloom({ Name = "Off", Duration = trialIntroDuration })
	-- LoadVoiceBanks({ Name = "Chaos" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = 0, Duration = trialIntroDuration * 2.0, Retarget = true, EaseIn = 0, EaseOut = 0.1 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = trialIntroDuration * 2.0, ZoomType = "Ease" })
	wait( trialIntroDuration + 0.1 )
	SetAnimation({ Name = "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, roomData.EnterVoiceLines or encounterData.EnterVoiceLines, true )
end

function HeroAlphaDelay( currentRun, delay )
	wait( delay )
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 0.3 })

	if( currentRun.Hero.AttachedLightId ~= nil ) then
		SetAlpha({ Id = currentRun.Hero.AttachedLightId, Fraction = 1.0, Duration = 0.3 })
	end
end

function RoomOpeningUIDelay()
	wait( 0.8 )
	for i, data in pairs(GetHeroTraitValues("DelayedRunStartPresentation")) do
		thread( CallFunctionName, data.FunctionName, data.FunctionArgs )
	end
	wait( 1.62 )
	ShowCombatUI( "RoomEntranceOpening" )
	
end

function RoomEntranceStandard( currentRun, currentRoom )
	local roomData = RoomData[currentRoom.Name] or currentRoom
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	-- Disable immediately, could be sitting on top of impassibility
	if currentRoom.HeroEndPoint ~= nil then
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
	end
	wait(0.03)

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()

	local roomEntranceAnimation = GetEquippedWeaponValue( "RoomEntranceAnimation" )
	if roomEntranceAnimation ~= nil then
		SetAnimation({ Name = roomEntranceAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end
	
	if roomData.DoorEntranceAnimation ~= nil then
		thread( DoorEntranceAnimation, roomData.DoorEntranceAnimation)
	end

	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, Invulnerable = true } )
	end
	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomData.IntroPanDuration or roomIntroSequenceDuration })
	end

	if currentRoom.EnterSound ~= nil then
		PlaySound({ Name = currentRoom.EnterSound, Id = currentRoom.HeroStartPoint })
	end
	wait(0.03)


	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or roomData.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	wait( roomIntroSequenceDuration )
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
end

function DoorEntranceAnimation(args)
	local doorId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetIdsByType({ Name = args.DoorType }) })
	SetAnimation({ DestinationId = doorId, Name = args.OpenedAnimation })
	wait(args.Delay)
	SetAnimation({ DestinationId = doorId, Name = args.CloseAnimation })
end

function FastEnterPresentation( currentRun, currentRoom )
	local roomIntroSequenceDuration = 0.1

	-- Disable immediately, could be sitting on top of impassibility
	if currentRoom.HeroEndPoint ~= nil then
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
	end
	wait(0.03)

	FadeIn({ Duration = 0.3 })
	
	local roomEntranceAnimation = GetEquippedWeaponValue( "RoomEntranceAnimation" )
	if roomEntranceAnimation ~= nil then
		SetAnimation({ Name = roomEntranceAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end

	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, Invulnerable = true } )
	end
	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = RoomData[currentRoom.Name].IntroPanDuration or roomIntroSequenceDuration })
	end

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	wait( roomIntroSequenceDuration )
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.0 })

end

function RoomEntranceBoss( currentRun, currentRoom, args )
	args = args or {}

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter

	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	wait(0.03)

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	if currentRoom.EnterSound ~= nil then
		PlaySound({ Name = currentRoom.EnterSound, Id = currentRoom.HeroStartPoint })
	end
	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, AngleTowardsIdOnEnd = args.AngleTowardsIdOnEnd } )
	end
	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomData.IntroCameraPanDuration or roomIntroSequenceDuration })
	end

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
	local firstTimeBonusWait = 0
	if currentRoom.FirstTimeBonusWait ~= nil and GameState.RoomCountCache[currentRoom.Name] == nil then
		firstTimeBonusWait = currentRoom.FirstTimeBonusWait
	end
	wait( firstTimeBonusWait or 0 )

	--wait( roomIntroSequenceDuration )
	--LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnblockCombatUI("BossEntrance")
end

function RoomEntranceDrop( currentRun, currentRoom, args)
	AddInputBlock({ Name = "RoomEntrancePortal" })

	--local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	--AdjustFullscreenBloom({ Name = "NewType09" })
	--wait(0.03)

	args = args or {}

	local dropShadow = SpawnObstacle({ Name = "DrownedChambersEntranceShadowFade", DestinationId =  currentRoom.HeroEndPoint, OffsetY = -12, OffsetX = 0 })
	SetAlpha({ Id = dropShadow, Fraction = 0.2, Duration = 0.01 })
	SetScale({ Id = dropShadow, Fraction = 0.02, Duration = 0.01 })

	if args.Sound ~= nil then
		PlaySound({ Name = args.Sound, Id = CurrentRun.Hero.ObjectId })
	end

	wait(0.03)
	SetAlpha({ Id = dropShadow, Fraction = 0.80, Duration = 0.8 })
	SetScale({ Id = dropShadow, Fraction = 0.10, Duration = 0.8 })

	if currentRoom.HeroEndPoint ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	end
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0, OffsetY = -150 })
	AdjustZLocation({ Id = currentRun.Hero.ObjectId, Distance = 1800, Duration = 0.0 })
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.2, EaseIn = 0, Retarget = true})
	if args.StartZoomFraction then
		FocusCamera({ Fraction = args.StartZoomFraction, Duration = 0.01 })
	end
	wait(0.03)
	if args.StartZoomFraction then
		FocusCamera({ Fraction = currentRun.CurrentRoom.ZoomFraction, Duration = args.ZoomDuration, ZoomType = "Ease" })
	end

	ApplyUpwardForce({ Id = currentRun.Hero.ObjectId, Speed = -100 })
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })

	wait(0.3)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	if currentRoom.LocationText and not currentRoom.Encounter.BlockLocationText then
		thread( DisplayInfoBanner, nil, { Text = currentRoom.LocationText, Delay = 0.65, FadeColor = currentRoom.LocationTextColor or { 255, 0, 0, 255 }, Duration = 2.0 } )
	end
	wait (0.33)
	SetAnimation({ Name = args.LandingAnimation or "Melinoe_Drop_Entrance_Fire", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = dropShadow, Fraction = 0, Duration = 0.03 })
	ShakeScreen({ Speed = 150, Distance = 6, Duration = 0.15, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.18, Duration = 0.8 }, } )
	PlaySound({ Name = "/Leftovers/SFX/BallLand", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/FootstepsWheatHeavy2", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/FootstepsWheatHeavy2", Id = CurrentRun.Hero.ObjectId, Delay = 0.2 })
	CreateAnimation({ Name = "DustPuffBNoDecal", DestinationId = CurrentRun.Hero.ObjectId })
	--PlaySound({ Name = "/Leftovers/SFX/BigSplashRing", Id = CurrentRun.Hero.ObjectId })
	RemoveInputBlock({ Name = "RoomEntrancePortal" })

	wait( args.IntroHoldDuration or 0 )
end

function RoomEntrancePortal( currentRun, currentRoom )
	AddInputBlock({ Name = "RoomEntrancePortal" })
	--local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	--AdjustFullscreenBloom({ Name = "NewType09" })
	--wait(0.03)

	local dropShadow = SpawnObstacle({ Name = "DrownedChambersEntranceShadowFade", DestinationId =  currentRoom.HeroEndPoint, OffsetY = -12, OffsetX = 0 })
	SetAlpha({ Id = dropShadow, Fraction = 0.2, Duration = 0.01 })
	SetScale({ Id = dropShadow, Fraction = 0.02, Duration = 0.01 })
	wait(0.03)
	SetAlpha({ Id = dropShadow, Fraction = 0.80, Duration = 0.8 })
	SetScale({ Id = dropShadow, Fraction = 0.10, Duration = 0.8 })

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

	wait(0.3)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	if currentRoom.LocationText and not currentRoom.Encounter.BlockLocationText then
		thread( DisplayInfoBanner, nil, { Text = currentRoom.LocationText, Delay = 0.65, FadeColor = currentRoom.LocationTextColor or { 255, 0, 0, 255 }, Duration = 2.0 } )
	end
	wait (0.33)
	SetAnimation({ Name = "Melinoe_Drop_Entrance_Fire", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = dropShadow, Fraction = 0, Duration = 0.03 })
	ShakeScreen({ Speed = 150, Distance = 6, Duration = 0.15, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.18, Duration = 0.8 }, } )
	PlaySound({ Name = "/Leftovers/SFX/BallLand", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/FootstepsWheatHeavy2", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/FootstepsWheatHeavy2", Id = CurrentRun.Hero.ObjectId, Delay = 0.2 })
	CreateAnimation({ Name = "DustPuffBNoDecal", DestinationId = CurrentRun.Hero.ObjectId })
	--PlaySound({ Name = "/Leftovers/SFX/BigSplashRing", Id = CurrentRun.Hero.ObjectId })
	RemoveInputBlock({ Name = "RoomEntrancePortal" })

	Destroy({ Id = dropShadow })
end

function DelayedRemoveInputBlock( delay, inputBlockName )
	wait( delay )
	RemoveInputBlock({ Name = inputBlockName })
end

function FullScreenFadeInAnimation( animationName )
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	AdjustColorGrading({ Name = "Dusk", Duration = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1 })
	AdjustColorGrading({ Name = "Off", Duration = 1 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = animationName or "RoomTransitionOut" })
	local uniformAspectScale = ScreenScaleX
	if ScreenScaleY > ScreenScaleX then 
		uniformAspectScale = ScreenScaleY
	end
	if not ScreenState.NativeAspetRatio then
		uniformAspectScale = uniformAspectScale + 0.1 -- Scaling isn't pixel-perfect, add some buffer
	end
	SetScale({ Id = ScreenAnchors.Transition, Fraction = uniformAspectScale })
	--[[ 
	if ScreenState.NeedsLetterbox then
		local frameId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray_Overlay", Animation = "GUI\\Graybox\\NativeAspectRatioFrame", Alpha = 1.0 })
		SetColor({ Id = frameId, Color = Color.Black })
		SetAlpha({ Id = frameId, Fraction = 0.0, Duration = 0.85, EaseIn = 0.0, EaseOut = 1.0 })
	elseif ScreenState.NeedsPillarbox then
		local leftId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenState.PillarboxLeftX, Y = ScreenCenterY, ScaleX = ScreenState.PillarboxScaleX, Group = "Combat_Menu_TraitTray_Overlay", Animation = "GUI\\SideBars_01", Alpha = 1.0 })
		SetColor({ Id = leftId, Color = Color.Black })
		SetAlpha({ Id = leftId, Fraction = 0.0, Duration = 0.85, EaseIn = 0.0, EaseOut = 1.0 })
		FlipHorizontal({ Id = leftId })
		local rightId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenState.PillarboxRightX, Y = ScreenCenterY, ScaleX = ScreenState.PillarboxScaleX, Group = "Combat_Menu_TraitTray_Overlay", Animation = "GUI\\SideBars_01", Alpha = 1.0 })
		SetColor({ Id = rightId, Color = Color.Black })
		SetAlpha({ Id = rightId, Fraction = 0.0, Duration = 0.85, EaseIn = 0.0, EaseOut = 1.0 })
	end
	]]

end

function FullScreenFadeOutAnimation( animationName )
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	AdjustColorGrading({ Name = "Dusk", Duration = 1 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = animationName or "RoomTransitionIn" })
	local uniformAspectScale = ScreenScaleX
	if ScreenScaleY > ScreenScaleX then 
		uniformAspectScale = ScreenScaleY
	end
	if not ScreenState.NativeAspetRatio then
		uniformAspectScale = uniformAspectScale + 0.1 -- Scaling isn't pixel-perfect, add some buffer
	end
	SetScale({ Id = ScreenAnchors.Transition, Fraction = uniformAspectScale })
	--[[ 
	if ScreenState.NeedsLetterbox then
		local frameId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray_Overlay", Animation = "GUI\\Graybox\\NativeAspectRatioFrame", Alpha = 0.0 })
		SetAlpha({ Id = frameId, Fraction = 1.0, Duration = 0.7, EaseIn = 0.0, EaseOut = 1.0 })
		SetColor({ Id = frameId, Color = Color.Black })
	elseif ScreenState.NeedsPillarbox then
		local leftId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenState.PillarboxLeftX, Y = ScreenCenterY, ScaleX = ScreenState.PillarboxScaleX, Group = "Combat_Menu_TraitTray_Overlay", Animation = "GUI\\SideBars_01", Alpha = 0.0 })
		SetAlpha({ Id = leftId, Fraction = 1.0, Duration = 0.7, EaseIn = 0.0, EaseOut = 1.0 })
		SetColor({ Id = leftId, Color = Color.Black })
		FlipHorizontal({ Id = leftId })
		local rightId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenState.PillarboxRightX, Y = ScreenCenterY, ScaleX = ScreenState.PillarboxScaleX, Group = "Combat_Menu_TraitTray_Overlay", Animation = "GUI\\SideBars_01", Alpha = 0.0 })
		SetAlpha({ Id = rightId, Fraction = 1.0, Duration = 0.7, EaseIn = 0.0, EaseOut = 1.0 })
		SetColor({ Id = rightId, Color = Color.Black })
	end
	]]
	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelOutURSA" })
	wait( 0.7 ) -- Duration of RoomTransitionIn buffered by a couple frames
end

function FullScreenFadeInAnimationReroll( color, args )
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	args = args or {}
	args.PlaySpeed = args.PlaySpeed or 1
	--AdjustFullscreenBloom({ Name = "Blur", Duration = 0 })
	--AdjustColorGrading({ Name = "Dusk", Duration = 0 })
	--AdjustFullscreenBloom({ Name = "Off", Duration = 1 })
	--AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = "RerollTransitionOut", PlaySpeed = args.PlaySpeed })
	SetColor({ Id = ScreenAnchors.Transition, Color = Color.Black, Duration = 0 })
	SetColor({ Id = ScreenAnchors.Transition, Color = color or Color.DarknessPoint, Duration = 0.5 / args.PlaySpeed })

	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelInURSA" })
end

function FullScreenFadeOutAnimationReroll( color, args )
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	args = args or {}
	args.PlaySpeed = args.PlaySpeed or 1
	--AdjustFullscreenBloom({ Name = "Blur", Duration = 1 })
	--AdjustColorGrading({ Name = "Dusk", Duration = 0.3 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = "RerollTransitionIn", PlaySpeed = args.PlaySpeed })
	SetColor({ Id = ScreenAnchors.Transition, Color = color or Color.DarknessPoint })
	SetColor({ Id = ScreenAnchors.Transition, Color = Color.Black, Duration = 1 / args.PlaySpeed })
	wait( 0.3 / args.PlaySpeed )
end

function StartRoomMusic( currentRun, currentRoom )

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = nil
	if currentRoom.Encounter ~= nil then
		encounterData = EncounterData[currentRoom.Encounter.Name]
	end

	if roomData.IgnoreMusic then
		return
	end

	local musicTrackName = nil
	if roomData.MusicRequirements == nil or IsGameStateEligible( roomData, roomData.MusicRequirements ) then
		musicTrackName = roomData.Music
	end

	local useRandomStems = true
	if roomData.BlockRandomStems or (encounterData ~= nil and encounterData.BlockRandomStems) then
		useRandomStems = false
	end

	local secretMusic = roomData.SecretMusic
	if secretMusic == nil and encounterData ~= nil then
		secretMusic = encounterData.SecretMusic
	end
	if currentRoom.ChosenRewardType == "Shop" and not currentRoom.SkipShopSecretMusic then
		secretMusic = roomData.ShopSecretMusic
	end

	local lastRoom = GetPreviousRoom( currentRun )
	if lastRoom ~= nil then
		local lastRoomData = RoomData[lastRoom.Name] or lastRoom
		local encounterNextRoomResumeMusic = false
		if lastRoom.Encounter ~= nil then
			local lastEncounterData = EncounterData[lastRoom.Encounter.Name]
			if lastEncounterData ~= nil and lastEncounterData.NextRoomResumeMusic then
				encounterNextRoomResumeMusic = true
			end
		end
		if lastRoom.EncountersOccurredCache ~= nil then
			for encounterName, v in pairs( lastRoom.EncountersOccurredCache ) do
				local encounterOccurredData = EncounterData[encounterName]
				if encounterOccurredData ~= nil and encounterOccurredData.NextRoomResumeMusic then
					encounterNextRoomResumeMusic = true
				end
			end
		end
		if secretMusic == nil and ( lastRoomData.NextRoomResumeMusic or encounterNextRoomResumeMusic ) then
			ResumeMusic()
		elseif lastRoom.NextRoomMusic ~= nil then
			if lastRoom.Encounter.NextRoomMusic then
				musicTrackName = lastRoom.Encounter.NextRoomMusic
			elseif lastRoom.NextRoomMusic then
				musicTrackName = lastRoom.NextRoomMusic
			end
		end
	end
	if roomData.StopSecretMusic and AudioState.SecretMusicId ~= nil then
		StopSecretMusic()
		if secretMusic == nil then
			ResumeMusic()
		end
	end

	if roomData.EndMusicOnEnter ~= nil and AudioState.MusicId ~= nil then
		EndMusic( AudioState.MusicId, AudioState.MusicName )
		musicTrackName = nil
	end

	if musicTrackName ~= nil then
		-- A custom track was requested, don't mix randomly
		useRandomStems = false
	end

	wait( roomData.MusicStartDelay )
	
	if secretMusic ~= nil then
		SecretMusicPlayer( secretMusic, { Section = roomData.SecretMusicSection } )
	else

		if musicTrackName ~= nil then
			MusicPlayer( musicTrackName )
		end

		if useRandomStems then
			thread( RandomStemMixer, currentRoom, AudioState.MusicId )
		end

		thread( MusicMixer, roomData )

	end

	CheckMusicEvents( currentRun, RoomStartMusicEvents )

end

function ReattachCameraOnInput( currentRun )
	local notifyName = "ReattachCameraOnInput"
	NotifyOnPlayerInput({ Notify = notifyName })
	waitUntil( notifyName )
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnzeroMouseTether( "StartRoomPresentation" )

end

function MoveHeroToRoomPosition( args )
	if not args.SkipInputBlock then
		AddInputBlock({ Name = "MoveHeroToRoomPosition" })
	end
	local heroId = args.MoverId or CurrentRun.Hero.ObjectId

	local initialSpeed = GetUnitDataValue({ Id = heroId, Property = "Speed" })
	local targetSpeed = args.Speed or initialSpeed
	if args.UseDefaultSpeed then
		targetSpeed = 540
	end

	if initialSpeed ~= targetSpeed then
		SetUnitProperty({ Property = "Speed", Value = targetSpeed, DestinationId = heroId })
	end

	if args.DisableCollision then
		SetUnitProperty({ DestinationId = heroId, Property = "CollideWithObstacles", Value = false })
		SetUnitProperty({ DestinationId = heroId, Property = "CollideWithUnits", Value = false })
	end

	if args.Invulnerable then
		SetInvulnerable({ Id = heroId })
	end

	local successDistance = args.SuccessDistance or 32
	Move({ Id = heroId, DestinationId = args.DestinationId, SuccessDistance = successDistance, ContinueToGoal = args.ContinueToGoal })
	local notifyName = "WithinDistance"..args.DestinationId
	NotifyWithinDistance({ Id = heroId, DestinationId = args.DestinationId, Distance = args.NotifyDistance or (successDistance + 8), Notify = notifyName, Timeout = args.Timeout or 5.0 })
	waitUntil( notifyName )
	Stop({ Id = heroId })
	if args.DisableCollision then
		SetUnitProperty({ DestinationId = heroId, Property = "CollideWithObstacles", Value = true })
		SetUnitProperty({ DestinationId = heroId, Property = "CollideWithUnits", Value = true })
	end

	if args.Invulnerable then
		SetVulnerable({ Id = heroId })
	end

	if initialSpeed ~= targetSpeed then
		SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = heroId })
		Halt({ Id = heroId })
	end

	if args.AngleTowardsIdOnEnd ~= nil then
		AngleTowardTarget({ Id = heroId, DestinationId = args.AngleTowardsIdOnEnd })
	end

	if not args.SkipInputBlock then
		RemoveInputBlock({ Name = "MoveHeroToRoomPosition" })
	end
end

function MoveHeroAlongPath( path, args )
	for k, id in ipairs( path ) do
		args.DestinationId = id
		MoveHeroToRoomPosition( args )
	end
end

function LeaveRoomAudio( currentRun, exitDoor )
	if currentRun == nil then
		return
	end
	if currentRun.Hero.IsDead then
		return
	end
	SetAudioEffectState({ Name = "SpellCharge", Value = 0 })
	if AudioState.FloodSoundId ~= nil then
		StopSound({ Id = AudioState.FloodSoundId, Duration = 1.0 })
		AudioState.FloodSoundId = nil
	end

	local roomData = RoomData[currentRun.CurrentRoom.Name]
	local encounterData = EncounterData[currentRun.CurrentRoom.Encounter.Name] or currentRun.CurrentRoom.Encounter

	if exitDoor.ExitVoiceLines ~= nil then
		thread( PlayVoiceLines, exitDoor.ExitVoiceLines, true )
	elseif encounterData.ExitVoiceLines ~= nil then
		thread( PlayVoiceLines, encounterData.ExitVoiceLines, true )
	elseif roomData.ExitVoiceLines ~= nil then
		thread( PlayVoiceLines, roomData.ExitVoiceLines, true )
	end

	if roomData.EndAmbienceOnExit then
		StopSound({ Id = AudioState.AmbienceId, Duration = 0.5 })
		AudioState.AmbienceId = nil
	end
	if roomData.EndMusicOnExit ~= nil then
		EndMusic( AudioState.MusicId, AudioState.MusicName, roomData.EndMusicOnExit )
	end

	local exitAmbience = roomData.ExitAmbience
	if exitAmbience ~= nil and exitAmbience ~= AmbienceName then
		StopSound({ Id = AudioState.AmbienceId, Duration = 0.5 })
		AudioState.AmbienceId = PlaySound({ Name = exitAmbience })
		AudioState.AmbienceName = exitAmbience
		SetVolume({ Id = AudioState.AmbienceId, Value = 0.0 })
		SetVolume({ Id = AudioState.AmbienceId, Value = 1.0, Duration = 0.5 })
	end
	CleanupCustomRoomSounds()
end

function CleanupCustomRoomSounds()
	if AudioState.EliteEncounterMusicId ~= nil then
		StopSound({ Id = AudioState.EliteEncounterMusicId, Duration = 0.5 })
		AudioState.EliteEncounterMusicId = nil
	end
	if AudioState.SkipEncounterMusicId ~= nil then
		StopSound({ Id = AudioState.SkipEncounterMusicId, Duration = 0.5 })
		AudioState.SkipEncounterMusicId = nil
		ResumeMusic()
	end
end

function LeaveRoomStartPresentation( exitDoor )

	if IsRecordRunDepth( CurrentRun ) then
		thread( PlayVoiceLines, GlobalVoiceLines.RecordRunDepthVoiceLines )
	end

	if CurrentRun.CurrentRoom.ChallengeEncounter ~= nil and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress then
		thread( PlayVoiceLines, HeroVoiceLines.FleeingEncounterVoiceLines, false )
	end

	for id, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if exitDoor.ObjectId == unit.TakingExitDoorId then
			thread( PlayVoiceLines, HeroVoiceLines.WonExitRaceVoiceLines, true )
		end
	end

end

function LeaveRoomPresentation( currentRun, exitDoor )

	local exitDoorId = exitDoor.ObjectId
	local door = MapState.OfferedExitDoors[exitDoorId]

	AddInputBlock({ Name = "LeaveRoomPresentation" })
	
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "LeaveRoomPresentation" )

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
	if heroExitPointId > 0 then
		if not currentRun.CurrentRoom.BlockExitPan then
			PanCamera({ Id = heroExitPointId, Duration = 10.0 })
		end
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		local args = {}
		args.SuccessDistance = 30
		local exitPath = exitDoor.ExitPath or currentRun.CurrentRoom.ExitPath or {}
		if door ~= nil and door.ExitThroughCenter then
			table.insert( exitPath, door.ObjectId )
		end
		table.insert( exitPath, heroExitPointId )
		thread( MoveHeroAlongPath, exitPath, args )
	else
		if exitDoorId ~= nil then
			AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = exitDoorId })
		end
		SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 1.0 })
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRun.CurrentRoom.ExitAnimation or RoomData.BaseRoom.ExitAnimation })
		CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRun.CurrentRoom.ExitVfx or RoomData.BaseRoom.ExitVfx })
		if door ~= nil and door.ExitPortalSound then
			PlaySound({ Name = door.ExitPortalSound or "/SFX/Menu Sounds/ChaosRoomEnterExit" })
		end
	end

	LeaveRoomAudio( currentRun, exitDoor )
	if exitDoor.Room.ExitTowardsFunctionName ~= nil then
		CallFunctionName( exitDoor.Room.ExitTowardsFunctionName, exitDoor, exitDoor.Room.ExitTowardsFunctionArgs )
	end

	wait(0.4)

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	--wait(0.2)
	wait(0.02)

	--SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.3 })
	FullScreenFadeOutAnimation( currentRun.CurrentRoom.FadeOutAnimation )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function HubCombatRoomEntrance( currentRun, exitDoor )

	local exitDoorId = exitDoor.ObjectId
	local door = MapState.OfferedExitDoors[exitDoorId]

	AddInputBlock({ Name = "LeaveRoomPresentation" })
	
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "HubCombatRoomEntrance" )

	if door ~= nil then
		DestroyDoorRewardPresenation( door )
		if door.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorOpenAnimation })
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
			wait( 0.02 )
		end
	end

	if exitDoorId ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = exitDoorId })
		local heroExitIds = GetIdsByType({ Name = "HeroExit" })
		local heroExitPointId = GetClosest({ Id = exitDoorId, DestinationIds = heroExitIds, Distance = 300 })
		if heroExitPointId < 0 then
			heroExitPointId = exitDoorId
		end
		PanCamera({ Id = heroExitPointId, Duration = 3.0 })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		local args = {}
		args.SuccessDistance = 30
		local exitPath = exitDoor.ExitPath or currentRun.CurrentRoom.ExitPath or {}
		if door ~= nil and door.ExitThroughCenter then
			table.insert( exitPath, door.ObjectId )
		end
		table.insert( exitPath, heroExitPointId )
		thread( MoveHeroAlongPath, exitPath, args )
	end

	LeaveRoomAudio( currentRun, exitDoor )

	wait(0.1)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.35 })
	--FullScreenFadeOutAnimation( currentRun.CurrentRoom.FadeOutAnimation )

	AdjustColorGrading({ Name = "Dusk", Duration = 0.4 })
	FadeOut({ Duration = 0.3, Color = Color.Black })

	wait( 0.31 )
	WaitForSpeechFinished()
	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end


function FastExitPresentation( currentRun, exitDoor )

	local exitDoorId = exitDoor.ObjectId
	local door = MapState.OfferedExitDoors[exitDoorId]

	AddInputBlock({ Name = "LeaveRoomPresentation" })
	
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "FastExitPresentation" )

	--[[
	if door ~= nil then
		DestroyDoorRewardPresenation( door )
		if door.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorOpenAnimation })
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
			wait( 0.7 )
		end
	end
	]]

	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = exitDoorId, DestinationIds = heroExitIds, Distance = 800 })
	if heroExitPointId > 0 then
		--PanCamera({ Id = heroExitPointId, Duration = 10.0 })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		local args = {}
		args.SuccessDistance = 30
		local exitPath = exitDoor.ExitPath or currentRun.CurrentRoom.ExitPath or {}
		if door ~= nil and door.ExitThroughCenter then
			table.insert( exitPath, door.ObjectId )
		end
		table.insert( exitPath, heroExitPointId )
		thread( MoveHeroAlongPath, exitPath, args )
	else
		if exitDoorId ~= nil then
			AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = exitDoorId })
		end
		SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 1.0 })
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRun.CurrentRoom.ExitAnimation or RoomData.BaseRoom.ExitAnimation })
		CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRun.CurrentRoom.ExitVfx or RoomData.BaseRoom.ExitVfx })
		if door ~= nil and door.ExitPortalSound then
			PlaySound({ Name = door.ExitPortalSound or "/SFX/Menu Sounds/ChaosRoomEnterExit" })
		end
	end

	LeaveRoomAudio( currentRun, exitDoor )

	wait(0.1)

	AdjustColorGrading({ Name = "Dusk", Duration = 0.30 })
	FadeOut({ Duration = 0.25, Color = Color.Black })

	wait( 0.26 )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end


function LockExtraExitsPresentation( door )

	CreateAnimation({ DestinationId = door.ObjectId, Name = "LockedIconNoKey", Group = "FX_Standing_Top" })
	thread( PlayVoiceLines, HeroVoiceLines.LockedExtraExitsFoundVoiceLines )

end

function ExitDoorUnlockedPresentation( exitDoor )

	if exitDoor.UnlockedAnimation ~= nil then
		SetAnimation({ Name = exitDoor.UnlockedAnimation, DestinationId = exitDoor.ObjectId })
	end	
	if exitDoor.RewardPreviewIconIds ~= nil then
		SetColor({ Ids = exitDoor.RewardPreviewIconIds, Color = {1.0, 1.0, 1.0, 0}, Duration = 0 })
		SetColor({ Ids = exitDoor.RewardPreviewIconIds, Color = {0, 0, 0, 1}, Duration = 0.2 })
	end
	if exitDoor.UnlockedSound ~= nil then
		PlaySound({ Name = exitDoor.UnlockedSound, Id = exitDoor.ObjectId })
	end
	if exitDoor.UnlockedGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[exitDoor.UnlockedGlobalVoiceLines], true )
	end
	wait(0.1)
	thread( PlayVoiceLines, HeroVoiceLines.ExitsUnlockedVoiceLines )

end
function ManaFountainUsedPresentation( usee, args )
	args = args or {}
	thread( PlayVoiceLines, GlobalVoiceLines.SkellyManaFountainReactionVoiceLines, true )
end

function ShrinePointDoorUsedPresentation( secretDoor, args )

	FreezePlayerUnit("SecretDoor")
	HideCombatUI( "ShrinePointDoorUsedPresentation" )
	AddInputBlock({ Name = "SecretDoorEnter" })

	PlaySound({ Name = "/SFX/HeatRewardDrop" })
	ZeroMouseTether("SecretDoor")
	PanCamera({ Id = secretDoor.ObjectId, Duration = 7.0 })
	FocusCamera({ Fraction = 1.05, Duration = 7.0, ZoomType = "Ease" })
	thread( PlayVoiceLines, HeroVoiceLines.ShrineDoorUnlockedVoiceLines, true )
	SetAnimation({ DestinationId = secretDoor.ObjectId, Name = "ShrinePointDoor_RevealedWalkable" })

	DestroyDoorRewardPresenation( secretDoor )

	SetAnimation({ Name = "Blank", DestinationId = secretDoor.DoorIconBackingId })
	thread( InCombatText, secretDoor.ObjectId, "SecretPassageOpened", 1 )
	local notifyName = "SecretDoorEnter"
	Move({ Id = CurrentRun.Hero.ObjectId, DestinationId = secretDoor.ObjectId, SuccessDistance = 32 })
	NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = secretDoor.ObjectId, Distance = 15, Notify = notifyName, Timeout = 3 })
	waitUntil( notifyName )
	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait( 1.1 )

	AdjustFullscreenBloom({ Name = "NewType09", Duration = 0.1 })
	UseableOff({ Id = secretDoor.ObjectId })
	HideUseButton( secretDoor.ObjectId, secretDoor )
	wait( 0.2 )

	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
	--thread( PlayerEnterSecretDoorPresentation, secretDoor )
	PlaySound({ Name = "/Leftovers/SFX/PlayerRespawn" })
	wait( 1.0 )

	PlaySound({ Name = "/Leftovers/SFX/FieldReviveSFX" })
	AdjustFullscreenBloom({ Name = "SaturatedLight", Duration = 0.8 })
	UnfreezePlayerUnit("SecretDoor")

	wait( 0.35 )
	RemoveInputBlock({ Name = "SecretDoorEnter" })
	--UnzeroMouseTether("SecretDoor")
end

function RemoveScreenEdgeIndicators()
	local indicatorSources = MergeTables( MapState.RoomRequiredObjects, MapState.OptionalRewards )
	indicatorSources = MergeTables( indicatorSources, MapState.OfferedExitDoors )
	for id, source in pairs( indicatorSources ) do
		RemoveScreenEdgeIndicator( source )
	end
end

function RemoveScreenEdgeIndicator( source )
	if source.IndicatorBackingId ~= nil then
		Destroy({ Id = source.IndicatorBackingId })
	end
	if source.IndicatorId ~= nil then
		Destroy({ Id = source.IndicatorId })
	end
end

function GatherRoomPresentationObjects( currentRun, currentRoom )

	if CurrentRun.StoredHeroLocation then
		return
	end

	local roomData = RoomData[currentRoom.Name] or currentRoom

	if CurrentRun.NextHeroStartPoint ~= nil and CurrentRun.NextHeroEndPoint ~= nil then
		currentRoom.HeroStartPoint = CurrentRun.NextHeroStartPoint
		CurrentRun.NextHeroStartPoint = nil
		currentRoom.HeroEndPoint = CurrentRun.NextHeroEndPoint
		CurrentRun.NextHeroEndPoint = nil
	elseif currentRoom.HeroStartPoint == nil or currentRoom.HeroEndPoint == nil then
		local heroStartIds = GetIdsByType({ Name = "HeroStart" })
		table.sort( heroStartIds )
		local heroEndIds = GetIdsByType({ Name = "HeroEnd" })
		table.sort( heroEndIds )
		local eligibleStartPairs = {}
		for k, startId in ipairs( heroStartIds ) do
			local endId = GetClosest({ Id = startId, DestinationIds = heroEndIds })
			local entranceEndId = endId
			if currentRoom.EntranceDirectionEndIdObstacleName ~= nil then
				entranceEndId = GetClosest({ Id = startId, DestinationIds = GetIdsByType({ Name = currentRoom.EntranceDirectionEndIdObstacleName }) })
			end
			local entranceDirection = nil
			local entranceAngle = GetAngleBetween({ Id = startId, DestinationId = entranceEndId })
			if roomData.CardinalEntranceDirection then
				if entranceAngle > 0 and entranceAngle < 90 then
					entranceDirection = "North"
				elseif entranceAngle > 90 and entranceAngle < 180 then
					entranceDirection = "West"
				elseif entranceAngle > 180 and entranceAngle < 270 then
					entranceDirection = "South"
				else
					entranceDirection = "East"
				end
			elseif roomData.StrictLeftRight then
				if entranceAngle > 0 and entranceAngle < 90 then
					entranceDirection = "Right"
				elseif entranceAngle > 90 and entranceAngle < 180 then
					entranceDirection = "Left"
				end
			else
				if entranceAngle < 90 or entranceAngle > 270 then
					entranceDirection = "Right"
				else
					entranceDirection = "Left"
				end
			end
			local prevRoom = GetPreviousRoom( currentRun )
			if prevRoom == nil or prevRoom.ExitDirection == nil or prevRoom.ExitDirection == entranceDirection then
				table.insert(eligibleStartPairs,
					{
						HeroStartPoint = startId,
						HeroEndPoint = endId
					})
			end
		end

		if not IsEmpty(eligibleStartPairs) then
			local chosenPair = GetRandomValue(eligibleStartPairs)
			currentRoom.HeroStartPoint = chosenPair.HeroStartPoint
			currentRoom.HeroEndPoint = chosenPair.HeroEndPoint
		end

		currentRoom.HeroStartPoint = currentRoom.HeroStartPoint or GetFirstValue(heroStartIds)
		if currentRoom.HeroStartPointEndPointLinkIds ~= nil and currentRoom.HeroStartPointEndPointLinkIds[currentRoom.HeroStartPoint] ~= nil then
			currentRoom.HeroEndPoint = currentRoom.HeroStartPointEndPointLinkIds[currentRoom.HeroStartPoint]
		else
			currentRoom.HeroEndPoint = currentRoom.HeroEndPoint or GetFirstValue(heroEndIds)
		end
	end

	if currentRoom.HeroStartPointCameraLinkIds ~= nil and currentRoom.HeroStartPointCameraLinkIds[currentRoom.HeroStartPoint] ~= nil then
		currentRoom.CameraStartPoint = currentRoom.HeroStartPointCameraLinkIds[currentRoom.HeroStartPoint]
	else
		currentRoom.CameraStartPoint = GetClosest({ Id = currentRoom.HeroStartPoint, DestinationIds = GetIdsByType({ Name = "CameraIntroStart" }) })
	end

	if currentRoom.HeroEndPointCameraLinkIds ~= nil and currentRoom.HeroEndPointCameraLinkIds[currentRoom.HeroEndPoint] ~= nil then
		currentRoom.CameraEndPoint = currentRoom.HeroEndPointCameraLinkIds[currentRoom.HeroEndPoint]
	else
		currentRoom.CameraEndPoint = GetClosest({ Id = currentRoom.HeroEndPoint, DestinationIds = GetIdsByType({ Name = "CameraIntroEnd" }) })
	end

end

function MaxHealthIncreaseText( args )
	if not args.SpecialText then
		return
	end
	local maxHealthGained = args.MaxHealthGained
	if maxHealthGained == nil then
		local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = args.MaxHealthTraitName })
		ExtractValues( CurrentRun.Hero, traitData, traitData )
		maxHealthGained = traitData.TooltipHealth
	end
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = args.SpecialText, PreDelay = args.Delay, Duration = 0.7, LuaKey = "TooltipData", ShadowScale = 0.7, OffsetY = -100,  LuaValue = { TooltipHealth = maxHealthGained }})
end

function DeathPresentation( currentRun, killer, args )

	AddInputBlock({ Name = "DeathPresentation" })
	ClearCameraClamp({ LerpTime = 0.4 })
	ZeroMouseTether("DeathPresentation")
	ToggleCombatControl( CombatControlsDefaults, false, "DeathPresentation")
	HideCombatUI( "Death", { FadeDuration = 0.0 } )
	 -- Would be better to move the layers of the death sequence up but avoiding changing the many fragile layers it has
	RemoveRoomRewardPreviews()
	RemoveScreenEdgeIndicators()
	RemoveInspectPoints()
	SetConfigOption({ Name = "UseOcclusion", Value = false })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	local wereAnyEnemiesAlive = not IsEmpty( RequiredKillEnemies )

	CleanupEnemies( { Destroy = true, DestroyIgnoreId = killer.ObjectId } )
	ExpireProjectiles({ Silent = true, BlockSpawns = true })
	ClearEffect({ Id = killer.ObjectId, All = true, BlockAll = true })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	if MapState.ManaChargeIndicatorIds then
		Destroy({ Ids = { MapState.ManaChargeIndicatorIds.BackingId, MapState.ManaChargeIndicatorIds.PipId }})
	end
	for k, encounter in pairs(currentRun.CurrentRoom.ActiveEncounters) do
		if encounter.UseGroupHealthBar then
			notifyExistingWaiters(encounter.Name.."GroupHealthBarDead")
		end
	end
	StopAmbientSound({ All = true })
	StopSound({ Id = AudioState.SecretMusicId, Duration = 0.25 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil
	if AudioState.RainSoundId ~= nil then
		StopSound({ Id = AudioState.RainSoundId, Duration = 0.2 })
		AudioState.RainSoundId = nil
	end
	if AudioState.FishingMusicId ~= nil then
		StopSound({ Id = AudioState.FishingMusicId, Duration = 0.2 })
		AudioState.FishingMusicId = nil
	end
	if AudioState.ChronosTimeSlowSoundId ~= nil then
		StopSound({ Id = AudioState.ChronosTimeSlowSoundId, Duration = 0.2 })
		AudioState.ChronosTimeSlowSoundId = nil
	end
	if AudioState.EliteEncounterMusicId ~= nil then
		StopSound({ Id = AudioState.EliteEncounterMusicId, Duration = 0.2 })
		AudioState.EliteEncounterMusicId = nil
	end
	if AudioState.SkipEncounterMusicId ~= nil then
		StopSound({ Id = AudioState.SkipEncounterMusicId, Duration = 0.2 })
		AudioState.SkipEncounterMusicId = nil
	end

	SetAudioEffectState({ Name = "SpellCharge", Value = 0 })
	SetAudioEffectState({ Name = "GlobalEcho", Value = 0 })

	SetThingProperty({ Property = "Graphic", Value = "MelinoeGetHitActionPose", DestinationId = CurrentRun.Hero.ObjectId })
	ShakeScreen({ Speed = 300, Distance = 3, Duration = 0.27, FalloffSpeed = 1000 })
	FocusCamera({ Fraction = 1.0, Duration = 0.27, ZoomType = "Ease" })

	Stop({ Id = currentRun.Hero.ObjectId })
	Halt({ Id = currentRun.Hero.ObjectId })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationNames = { "GroundEnemies", "FlyingEnemies" } })

	RemoveFromGroup({ Id = killer.ObjectId, Names = { "Standing", "GroundEnemies", "FlyingEnemies" } })
	AddToGroup({ Id = killer.ObjectId, Name = "Combat_UI", DrawGroup = true })

	if currentRun.Hero.AttachedAnimationName ~= nil then
		StopAnimation({ Name = currentRun.Hero.AttachedAnimationName, DestinationId = currentRun.Hero.ObjectId })
	end

	if MapState.BossShieldTriggers <= 0 and MapState.BossShieldFx then
		StopAnimation({ Name = MapState.BossShieldFx, DestinationId = CurrentRun.Hero.ObjectId })
	end
	currentRun.Hero.Mute = false
	SetPlayerInvulnerable( "PlayerDeath" )

	thread( PlayVoiceLines, GlobalVoiceLines.DeathVoiceLines )

	if killer.CauseOfDeathVoiceLines ~= nil then
		thread( PlayVoiceLines, killer.CauseOfDeathVoiceLines, nil, killer )
	elseif currentRun.CurrentRoom.Encounter.CauseOfDeathVoiceLines ~= nil then
		thread( PlayVoiceLines, currentRun.CurrentRoom.Encounter.CauseOfDeathVoiceLines )
	elseif currentRun.CurrentRoom.CauseOfDeathVoiceLines ~= nil then
		thread( PlayVoiceLines, currentRun.CurrentRoom.CauseOfDeathVoiceLines )
	end

	-- black out world
	StopAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "HadesReverseDarknessVignetteHold" })
	StopAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "HadesReverseDarknessGroundFog" })
	AdjustFrame({ Color = Color.TransparentRed, Duration = 0.0, Fraction = 0 })
	
	ScreenAnchors.DeathBacking = CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI_World_Backing", X = ScreenCenterX, Y = ScreenCenterY, Scale = 10.0, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	SetColor({ Id = ScreenAnchors.DeathBacking, Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.DeathBacking, Fraction = 1.0, Duration = 0 })

	ScreenAnchors.DeathBackground = CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI_World_Backing", X = ScreenCenterX, Y = ScreenCenterY, Scale = 10.0, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	SetColor({ Id = ScreenAnchors.DeathBackground, Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 1.0, Duration = 0 })

	RemoveFromGroup({ Id = currentRun.Hero.ObjectId, Name = "Standing" })
	AddToGroup({ Id = currentRun.Hero.ObjectId, Name = "Combat_Menu", DrawGroup = true })
	thread( DoRumble, currentRun.Hero.HeroFinalHitRumbleParameters )

	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.02, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, Duration = 1.51, ExpireAfterCycle = true })
	ShakeScreen({ Speed = 0, Distance = 0, Duration = 10.0 })
	
	wait( 0.02 )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationId = killer.ObjectId })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathStartFwoosh" })
	PlaySound({ Name = "/SFX/Player Sounds/PlayerDeath" })

	wait( 1.11 )
	
	SetAlpha({ Id = killer.ObjectId, Fraction = 0, Duration = 0.2 })
	
	wait( 0.21 )
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathStab" })
	if not CurrentRun.Cleared and not CurrentRun.BountyCleared then
		PlaySound({ Name = currentRun.CurrentRoom.Encounter.DeathStinger or "/Music/IrisDeathStinger" })
	else
		PlaySound({ Name = "/Music/IrisDeathStinger" })
	end

	local sceneOffsetY = -95
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 0.2, OffsetY = sceneOffsetY, Retarget = true, EaseIn = 0.0, EaseOut = 1.0 })
	FocusCamera({ Fraction = 1.47, Duration = 0.2, ZoomType = "Ease" })
	local melDeathFlash = CreateScreenComponent({ Name = "BlankObstacle", Group = "Overlay", X = ScreenCenterX, Y = ScreenCenterY, Animation = "MelDeathFlash", ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 315, CompleteAngle = true })

	for i = 1, 16 do
		CreateAnimation({ Name = "MelDeathLine", DestinationId = ScreenAnchors.DeathBackground, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
	end

	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = CurrentRun.Hero.ObjectId })

	local deathAnimation = "MelinoeDeathEscape"
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationNames = { "HeroTeam" } })
	SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 315, CompleteAngle = true })
	SetThingProperty({ Property = "Graphic", Value = deathAnimation, DestinationId = currentRun.Hero.ObjectId })

	if CurrentRun.ActiveBounty ~= nil then
		if CurrentRun.BountyCleared then
			local subtitleText = nil
			local subtitleTimeData = nil
			if GameState.PackagedBountyClears[CurrentRun.ActiveBounty] > 1 and GetBountyClearRecordTime( CurrentRun.ActiveBounty ) == CurrentRun.GameplayTime then
				subtitleText = "PackagedBountyComplete_Subtitle"
				subtitleTimeData = { LuaKey = "TempTextData", LuaValue = { ClearTime = GetTimerString( CurrentRun.GameplayTime, 2 ) } }
			end
			thread( DisplayInfoBanner, nil, {
				Text = "PackagedBountyEndedMessage", 
				Delay = 0.75,
				TextColor = Color.Turquoise,
				FontScale = 0.85,
				AnimationName = "LocationBackingIrisChaosIn",
				AnimationOutName = "LocationBackingIrisChaosOut",
				AppearSound = "/SFX/ChaosBoonChoice",
				Duration = 4.25,
				TextOffsetY = 50,
				SubTextColor = Color.ChaosVoice,
				SubtitleTextRevealSound = "/SFX/Menu Sounds/BiomeMapRewardIcon",
				SubtitleOffsetY = -10,
				SubtitleText = subtitleText,
				SubtitleData = subtitleTimeData
			} )
		else
			-- Bounty failed
			thread( DisplayInfoBanner, nil, {
				Text = "BountyFailedMessage",
				Delay = 0.75,
				TextColor = Color.Turquoise,
				FontScale = 0.85,
				AnimationName = "LocationBackingIrisChaosIn",
				AnimationOutName = "LocationBackingIrisChaosOut",
				AppearSound = "/SFX/ChaosBoonChoice",
				Duration = 4.25,
				TextOffsetY = 50
			} )
		end
	elseif CurrentRun.Cleared then
		thread( DisplayInfoBanner, nil, { Text = "OutroDeathMessageAlt", Delay = 0.75, TextColor = Color.Turquoise, FontScale = 0.85, AnimationName = "LocationBackingIrisGenericIn", AnimationOutName = "LocationBackingIrisGenericOut", ThreadName = "Outro", Duration = 4.25, TextOffsetY = 50 } )
	else
		thread( DisplayInfoBanner, nil, { Text = "DeathMessage", Delay = 0.75, TextColor = Color.Turquoise, FontScale = 0.85, AnimationName = "LocationBackingIrisGenericIn", AnimationOutName = "LocationBackingIrisGenericOut", Duration = 4.25, TextOffsetY = 50 } )
	end

	local timeToEscape = 1.00
	local deathBGPreRunTime = 0.23

	wait( deathBGPreRunTime )
	
	SetAnimation({ Name = "DeathSequenceMelBG", DestinationId = ScreenAnchors.DeathBackground })

	wait( timeToEscape )

	thread( PlayVoiceLines, GlobalVoiceLines.DeathReturnVoiceLines )

	SetThingProperty({ Property = "Graphic", Value = "MelinoeDeathEscape2", DestinationId = currentRun.Hero.ObjectId })
	SetScale({ Id = ScreenAnchors.DeathBackground, Fraction = 1 })
	SetColor({ Id = ScreenAnchors.DeathBackground, Color = Color.White })
	
	SetThingProperty({ Property = "AddColor", Value = "true", DestinationId = CurrentRun.Hero.ObjectId })
	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {1, 1, 1, 1}, Duration = 0.0 })
	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {0, 0, 0, 1}, Duration = 1.0, EaseIn = 0.9, EaseOut = 1.0})
	
	thread( DeathEscapeVFX, currentRun.Hero.ObjectId, sceneOffsetY )

	SetThingProperty({ Property = "Grip", Value = "Default", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.04 )

	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {0, 0, 0, 1}, Duration = 0.0 })	

	wait( 0.09 )
	Destroy({ Id = melDeathFlash.Id })

	wait( 0.3 )
	Teleport({ Id = killer.ObjectId, OffsetX = 0, OffsetY = 0 })
	ClearLootDrops( killer )

	wait(0.55)

	if currentRun.CurrentRoom.Encounter.DeathExtraSounds ~= nil then
		local randomSound = GetRandomValue( currentRun.CurrentRoom.Encounter.DeathExtraSounds )
		PlaySound({ Name = randomSound })
	end

	if ShouldIncrementEasyMode() then
		thread( EasyModeLevelUpPresentation )
		wait( 3.0 )
	end

	local encounter = CurrentRun.CurrentRoom.Encounter
	if CurrentRun.CurrentRoom.KilledByChaosCurse or CurrentRun.ActiveBounty then
		-- Chaos Death Taunt
		thread( HadesSpeakingPresentation, { SubtitleColor = LootData.TrialUpgrade.SubtitleColor }, { OverlayAnim = "ChaosOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = LootData.TrialUpgrade.DeathTauntVoiceLines } )
		wait( 1.1 )
	elseif encounter ~= nil then
		local encounterData = EncounterData[encounter.Name]
		local chronosTauntRequirements =
		{
			NamedRequirements = { "NightmarePresentationRequirements" },
			ChanceToPlay = 0.2
		}
		if not encounter.Completed then		
			if encounterData.HeroDeathEvents ~= nil then
				RunEventsGeneric( encounterData.HeroDeathEvents, encounter, args )
			elseif CurrentRun.CurrentRoom.Encounter.SpurnedGodName ~= nil then
				-- Olympian Death Taunt
				local spurnedGodName = CurrentRun.CurrentRoom.Encounter.SpurnedGodName
				local spurnedGodData = LootData[spurnedGodName]
				thread( HadesSpeakingPresentation, { SubtitleColor = spurnedGodData.SubtitleColor }, { OverlayAnim = spurnedGodData.OverlayAnim, BlockScreenshake = true, PortraitDuration = 2, VoiceLines = spurnedGodData.DeathTauntVoiceLines } )
				wait( 1.1 )
			elseif CurrentRun.CurrentRoom.Encounter.TookChaosCurseDamage ~= nil or CurrentRun.ActiveBounty then
				-- Chaos Death Taunt
				thread( HadesSpeakingPresentation, { SubtitleColor = LootData.TrialUpgrade.SubtitleColor }, { OverlayAnim = "ChaosOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = LootData.TrialUpgrade.DeathTauntVoiceLines } )
				wait( 1.1 )
			elseif CurrentRun.CurrentRoom.Encounter.ArtemisId ~= nil and not CurrentRun.CurrentRoom.Encounter.Completed then
				-- Artemis Death Taunt
				thread( HadesSpeakingPresentation, ActiveEnemies[CurrentRun.CurrentRoom.Encounter.ArtemisId] or { SubtitleColor = Color.ArtemisVoice }, { OverlayAnim = "ArtemisOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = GlobalVoiceLines.ArtemisDeathReactionVoiceLines } )
				wait( 1.1 )
			elseif CurrentRun.CurrentRoom.Encounter.HeraclesId ~= nil and not CurrentRun.CurrentRoom.Encounter.Completed then
				-- Heracles Death Taunt
				thread( HadesSpeakingPresentation, ActiveEnemies[CurrentRun.CurrentRoom.Encounter.HeraclesId] or { SubtitleColor = Color.HeraclesVoice }, { OverlayAnim = "HeraclesOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = GlobalVoiceLines.HeraclesDeathReactionVoiceLines } )
				wait( 1.1 )
			elseif CurrentRun.CurrentRoom.Encounter.NemesisId ~= nil then
				-- Nemesis Death Taunt
				thread( HadesSpeakingPresentation, ActiveEnemies[CurrentRun.CurrentRoom.Encounter.NemesisId] or { SubtitleColor = Color.NemesisVoice }, { OverlayAnim = "NemesisOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = GlobalVoiceLines.NemesisDeathReactionVoiceLines } )
				wait( 1.1 )
			elseif IsGameStateEligible( encounter, chronosTauntRequirements ) then
				-- Chronos Death Taunt
				LoadVoiceBanks( { Name = "Intercom" }, nil, true )
				WaitForSpeechFinished()
				thread( HadesSpeakingPresentation, { SubtitleColor = Color.ChronosVoice }, { OverlayAnim = "ChronosOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = GlobalVoiceLines.ChronosDeathTauntVoiceLines } )
				GameState.NightmaresOccurred = (GameState.NightmaresOccurred or 0) + 1
				CurrentRun.NightmareOccurred = true
				wait( 1.1 )
			end
		end
	end

	wait( 2.5 )

	DoomAppearancePresentation()

	wait( 3.5 ) -- longer wait necessary for banner
	
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.2 })

	if currentRun.ActiveBounty ~= nil then
		-- BountyPackageRunEndPresentation()
	end

	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })

	WaitForSpeechFinished()

	-- un-chipmunkify Mel only after all speech has finished
	currentRun.Hero.SpeechParams.Chipmunk = nil
	SetAudioEffectState({ Name = "Chipmunk", Value = 0 })

	RemoveInputBlock({ Name = "DeathPresentation" })
	ToggleCombatControl( CombatControlsDefaults, true, "DeathPresentation")
	SetConfigOption({ Name = "UseOcclusion", Value = true })

end

function DeathEscapeVFX( objectId, sceneOffsetY )

	waitUnmodified( 0.4 )
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic" })

	ScreenAnchors.DeathFxBack = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_UI_World_Add", X = ScreenCenterX, Y = ScreenCenterY - sceneOffsetY, Alpha = 0, Animation = "DeathSequenceFxBack" })
	ScreenAnchors.DeathFxFront = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = ScreenCenterX, Y = ScreenCenterY - sceneOffsetY, Alpha = 0, Animation = "DeathSequenceFxFront" })

	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {0, 1, 0.6, 1}, Duration = 2.0, EaseIn = 0, EaseOut = 1 })

	waitUnmodified( 1.0 )
	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {1, 1, 1, 1}, Duration = 0.25, EaseIn = 0, EaseOut = 0.5 })

	waitUnmodified( 0.5 )
	SetAlpha({ Id = objectId, Fraction = 0.0, Duration = 0.25 })

	waitUnmodified( 1.2 )
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow", Id = objectId })
	waitUnmodified( 0.25 )
	
end

function ShowFullScreenImage( image, imageData, duration )
	if not image then
		return
	end

	ScreenAnchors.PortraitDisplayAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Overlay", X = ScreenCenterX, Y = ScreenCenterY })
	local blackScreenId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = blackScreenId, Fraction = 20 })
	SetColor({ Id = blackScreenId, Color = Color.Black })
	SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0 })

	local portraitId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
	local randomScale = RandomFloat( imageData.StartScale - imageData.ScaleVariance, imageData.StartScale + imageData.ScaleVariance )
	SetScale({ Id = portraitId, Fraction = randomScale })
	SetAlpha({ Id = portraitId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = portraitId, Fraction = 1.0, Duration = 1.0 })
	SetAnimation({ Name = image, DestinationId = portraitId })

	Attach({ Id = blackScreenId, DestinationId = ScreenAnchors.PortraitDisplayAnchor })
	Attach({ Id = portraitId, DestinationId = ScreenAnchors.PortraitDisplayAnchor })

	-- Camera Pan
	--AdjustFullscreenBloom({ Name = "NewType06", Duration = 0 })
	--AdjustFullscreenBloom({ Name = "Off", Duration = 1, })
	Teleport({ Id = ScreenAnchors.PortraitDisplayAnchor, DestinationId = ScreenAnchors.PortraitDisplayAnchor, OffsetX = imageData.StartOffsetX or 0, OffsetY = imageData.StartOffsetY or 0 })
	-- Move({ Id = ScreenAnchors.PortraitDisplayAnchor, DestinationId = ScreenAnchors.PortraitDisplayAnchor, OffsetX = 0, OffsetY = 50, Duration = args.PanDuration or 9.4, EaseOut = 1.0, EaseIn = 0.0 })
	SetScale({ Id = portraitId, Fraction = imageData.EndScale, Duration = 9.8, EaseOut = 1.0, EaseIn = 0.0 })

	--wait( args.FadeOutWait or 12.0 )

	--PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	wait( duration + 0.167 )
	SetAlpha({ Id = portraitId, Fraction = 0.0, Duration = 0 })
	Destroy({ Id = portraitId })
	Destroy({ Id = blackScreenId })
	
end

function DoomAppearancePresentation( delay )

	local moros = DeepCopyTable( EnemyData.NPC_Moros_01 )
	local textLines = GetRandomEligibleTextLines( moros, moros.DeathPresentationTextLineSets, {} )
	if textLines == nil then
		return
	end

	wait( delay or 1.5 )

	local currentRun = CurrentRun
	SetAudioEffectState({ Name = "Reverb", Value = 2.0 })
	moros.ObjectId = SpawnUnit({ Name = "NPC_Moros_01", Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -300, OffsetX = 150 })
	SetAlpha({ Id = moros.ObjectId, Fraction = 0, Duration = 0 })
	SetupUnit( moros, CurrentRun, { IgnoreAI = true, IgnoreAssert = true } )
	SetGoalAngle({ Id = moros.ObjectId, Angle = 250 })
	PanCamera({ Ids = moros.ObjectId, Duration = 0 })
	SetScale({ Id = moros.ObjectId, Fraction = 0.7 })
	RemoveFromGroup({ Id = moros.ObjectId, Name = "Standing" })

	CreateAnimation({ Name = "TeleportDisappear", DestinationId = moros.ObjectId })
	SetAlpha({ Id = moros.ObjectId, Fraction = 1, Duration = 0.3 })

	thread( PlayVoiceLines, moros.EntranceVoiceLines, nil, moros )
	wait( 0.5, RoomThreadName )

	SecretMusicPlayer( "/Music/ChaosTheme_MC" )

	wait( 2.5, RoomThreadName )

	AddToGroup({ Ids = { currentRun.Hero.ObjectId, moros.ObjectId }, Name = "Combat_UI_World_Backing", DrawGroup = true })

	PlayTextLines( moros, textLines )

	RemoveFromGroup({ Ids = { currentRun.Hero.ObjectId, moros.ObjectId }, Name = "Combat_UI_World_Backing" })

	FadeOut({ Duration = 2.0, Color = Color.Black })

	wait( 0.5, RoomThreadName )

	StopSound({ Id = AudioState.SecretMusicId, Duration = 1.5 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

	PanCamera({ Ids = moros.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

end


function SetupArachneTheme()
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0, Duration = 0.0 })
end

function EasyModeLevelUpPresentation()

	wait( 3.9, RoomThreadName )

	local prevResistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel - 1 ) ) * 100 )
	local resistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
	DisplayInfoBanner( nil, {
		--SupertitleText = "EasyModeUpgradedSupertitle",
		TitleText = "EasyModeUpgradedTitle",
		SubtitleText = "EasyModeLevelUp",
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal2",
		Color = {0, 255, 168, 255},
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = Color.White,
		SubTextColor = {23, 255, 187, 255},
		Icon = "EasyModeIcon",
		IconOffsetY = 15,
		TextOffsetY = -45,
		SubtitleOffsetY = -15,
		Duration = 4.35,
		IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "P22UndergroundSCMedium",
		AdditionalAnimation = "GodHoodRays",
		AnimationName = "LocationTextBGGeneric_GodHood",
		AnimationOutName = "LocationTextBGGenericOut_GodHood",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = { Resistance = prevResistance }, LuaValueUpdate = { Resistance = "{#HighlightFormatGraft}" .. resistance}, UpdateDelay = 1.25, },
		} )
end

function EasyModeEnabledPresentation()
	local resistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
	wait(0.4)
	-- PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonChoiceConfirm" })
	wait( 0.02 )
	ShakeScreen({ Speed = 1000, Distance = 2, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.3 }, } )
	AdjustColorGrading({ Name = "ItemGet", Duration = 0.2 })
	--SetAnimation({ Name = "ZagreusLanding", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "ItemGetVignette", OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, Scale = 2.0, UseScreenLocation = true })
	wait( 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	if ConfigOptionCache.EasyMode then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "EasyModeEnabled", Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Resistance = resistance }, ShadowScaleX = 1.33 } )
	end
end

function EasyModeDisabledPresentation()
	local resistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
	wait(0.4)
	-- PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteDepressed" })
	if not ConfigOptionCache.EasyMode then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "EasyModeDisabled", Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Resistance = resistance }, ShadowScaleX = 1.33 } )
	end
end

function GameplayTimerEnabledPresentation()
	thread( PlayVoiceLines, GlobalVoiceLines.ChronosTimerOnReactionVoiceLines, true )
end

function GameplayTimerDisabledPresentation()
	thread( PlayVoiceLines, GlobalVoiceLines.ChronosTimerOffReactionVoiceLines, true )
end

function EndEarlyAccessPresentation()

	AddInputBlock({ Name = "EndEarlyAccessPresentation" })
	SetPlayerInvulnerable( "EndEarlyAccessPresentation" )

	CurrentRun.Hero.Mute = true
	CurrentRun.ActiveBiomeTimer = false
	ToggleCombatControl( CombatControlsDefaults, false, "EarlyAccessPresentation" )
	
	local gameOutroData = GetRandomEligiblePrioritizedItem( GameOutroData, GameOutroPriorities, GameState.PlayedRunOutros, GameState.RemainingRunOutros )
	GameState.PlayedRunOutros[gameOutroData.Name] = true
	gameOutroData.Header = gameOutroData.Header or gameOutroData.Name

	wait( 0.1 )
	StopAmbientSound({ All = true })
	SetAudioEffectState({ Name = "Reverb", Value = 1.5 })
	EndAmbience( 0.5 )
	EndAllBiomeStates()
	ExpireProjectiles({ Names = { "AphroditeBurst", }, BlockSpawns = true })
	FadeOut({ Duration = 0.375, Color = Color.Black })
	wait( 0.5 )

	RunInterstitialPresentation( gameOutroData )

	wait( 0.5 )

	-- first production / early access
	EndBiomeRecords()
	
	-- destroy the player / back to DeathArea
	SetPlayerVulnerable( "EndEarlyAccessPresentation" )
	RemoveInputBlock({ Name = "EndEarlyAccessPresentation" })
	ToggleCombatControl( CombatControlsDefaults, true, "EarlyAccessPresentation" )
	
	CurrentRun.Hero.Mute = false
	thread( Kill, CurrentRun.Hero )
	wait( 0.15 )

	FadeIn({ Duration = 0.5 })
end

function SendCritters( args )

	args = args or {}

	if args.ChanceToPlay ~= nil and not RandomChance( args.ChanceToPlay ) then
		return
	end

	local startId = args.StartId or CurrentRun.Hero.ObjectId
	if args.PreserveStartLocation then
		startId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = startId })
	end


	wait( args.StartDelay )

	local limit = RandomInt( args.MinCount or 1, args.MaxCount or 1 )
	for index = 1, limit, 1 do
		local startX = args.StartX or -1000
		local startY = args.StartY or -500
		if args.RandomStartOffsetX then
			startX = RandomInt( -args.RandomStartOffsetX, args.RandomStartOffsetX )
		end
		if args.RandomStartOffsetY then
			startY = RandomInt( -args.RandomStartOffsetY, args.RandomStartOffsetY )
		end


		local critterId = SpawnObstacle({ Name = args.CritterName or "SingleBat", DestinationId = startId, OffsetX = startX, OffsetY = startY, Group = args.GroupName or "FX_Standing_Top" })
		local moveAngle = RandomFloat( args.MinAngle or 45, args.MaxAngle or 135 )
		local moveSpeed = RandomFloat( args.MinSpeed or 10, args.MaxSpeed or 1000 )
		--DebugPrint({ Text = tostring(moveAngle).." | "..tostring(moveSpeed) })
		if args.CritterScaleMin and args.CritterScaleMax then
			local scale = RandomFloat( args.CritterScaleMin, args.CritterScaleMax )
			SetScale({ Id = critterId, Fraction = scale })
		end
		SetAngle({ Id = critterId, Angle = moveAngle, Speed = moveSpeed })
		Move({ Id = critterId, Angle = moveAngle, Speed = moveSpeed })
		thread( KillCritter, critterId, args.KillTime or 5.0 )
		local nextCritterWait = RandomFloat( args.MinInterval or 0.02, args.MaxInterval or 0.5 )
		wait( nextCritterWait )
	end

	if args.PreserveStartLocation then
		Destroy({ Id = startId })
	end
end

function KillCritter( objectId, killWait )
	wait( killWait )
	SetAlpha({ Id = objectId, Fraction = 0, Duration = 0.3 })
	wait(0.35)
	Destroy({ Id = objectId })
end

function BoonInteractPresentation( source, args, textLines )
	args = args or {}

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

	if not args.SkipAnim then
		SetAnimation({ Name = args.Anim or "MelinoeBoonInteract", DestinationId = CurrentRun.Hero.ObjectId })
	end

	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.3 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })
	AdjustColorGrading({ Name = "BoonInteract", Duration = 0.3 })
	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "BoonInteractDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "BoonInteractFx", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	local boonSound = PlaySound({ Name = "/SFX/Player Sounds/ZagreusWeaponChargeup" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	waitUnmodified( 0.5 )
	PlaySound({ Name = "/SFX/SurvivalChallengeStart2" })
	StopSound({ Id = boonSound, Duration = 0.3 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.5 }, } )

	AdjustColorGrading({ Name = "Devotion", Duration = 0.1 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.1 })

	waitUnmodified(0.06)

	AdjustColorGrading({ Name = "Off", Duration = 3.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 3.0 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 3.0 )

	waitUnmodified( args.PickupWait )
end

function UpgradeAcquiredPresentation( screen, upgradeData )
	PlaySound({ Name = upgradeData.ConfirmSound or "/SFX/Menu Sounds/GodBoonChoiceConfirm" })
	local lineSets = { HeroVoiceLines.ReturnToHubVoiceLines }
	if not upgradeData.FromTrade then
		table.insert( lineSets, GlobalVoiceLines.FieldsRewardClaimedVoiceLines )
	else
	end
	table.insert( lineSets, HeroVoiceLines.SwapUpgradePickedVoiceLines )
	table.insert( lineSets, upgradeData.SwapUpgradePickedVoiceLines )
	table.insert( lineSets, upgradeData.UpgradePickedVoiceLines )
	table.insert( lineSets, HeroVoiceLines.UpgradePickedVoiceLines )
	table.insert( lineSets, GlobalVoiceLines.MiscUpgradePickedVoiceLines )
	thread( PlayFirstEligibleVoiceLines, lineSets, upgradeData )
	wait( 0.02 )
	ShakeScreen({ Speed = 1000, Distance = 2, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.3 }, } )
	AdjustColorGrading({ Name = upgradeData.ColorGrade or "ItemGet", Duration = 0.2 })
	SetAnimation({ Name = screen.Source.UpgradeAcquiredAnimation or "MelinoeBoonInteractPowerUp", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "ItemGetVignette", OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, Scale = 2.0, UseScreenLocation = true })
	wait( screen.Source.UpgradeAcquiredAnimationDelay or 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	ChaosBassStop()
end

function ManaUpgradeInteractPresentation( source, args, textLines )

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

	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.3 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })
	AdjustColorGrading({ Name = "BoonInteract", Duration = 0.3 })
	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "BoonInteractDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "BoonInteractFx", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	local boonSound = PlaySound({ Name = "/SFX/Player Sounds/ZagreusWeaponChargeup" })
	ShakeScreen({ Speed = 400, Distance = 4, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	wait( 0.5 )
	PlaySound({ Name = "/Leftovers/Menu Sounds/RosterPickup" })
	StopSound({ Id = boonSound, Duration = 0.3 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.5 }, } )

	AdjustColorGrading({ Name = "NightMoon", Duration = 0.1 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.1 })

	wait(0.06)

	AdjustColorGrading({ Name = "Off", Duration = 3.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 3.0 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 3.0 )

	if args ~= nil then
		wait( args.PickupWait )
	end
end

function SpellDropInteractPresentation( source, args, textLines )

	AdjustColorGrading({ Name = "NightMoon", Duration = 0.5 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })

	if not args.SkipInteractAnim then
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
		thread( PlayInteractAnimation, source.ObjectId  )
	end

	wait( 0.5 )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
	SetAnimation({ Name= "MelTalkGifting01", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.35 })
	local beamTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = source.ObjectId, OffsetY = -560 })
	CreateAnimation({ Name = "MoonbeamsColor", DestinationId = beamTarget, Group = "FX_Standing_Add" })
	PanCamera({ Id = source.ObjectId, OffsetY = -220, Retarget = true, Duration = 4.5 })
	FocusCamera({ Fraction = (CurrentRun.CurrentRoom.ZoomFraction or 1) * 0.875, Duration = 5.0, ZoomType = "Ease" })
	
	if GameState.UseRecord.SpellDrop ~= nil then
		if args ~= nil then
			wait( 1 or args.PickupWait )
		end
	end

	if textLines ~= nil and not textLines.IgnoreInteractAnimation then
		local interactAnim = textLines.InteractAnimation or source.InteractAnimation
		if interactAnim == nil and textLines.PlayOnce then
			interactAnim = "StatusIconWantsToTalkBoon"
		end
		if interactAnim ~= nil then
			CreateAnimation({ Name = interactAnim, DestinationId = source.ObjectId, OffsetZ = source.AnimOffsetZ })
		end
	end

	Shake({ Id = source.ObjectId, Distance = 3, Speed = 100, Duration = 1, FalloffSpeed = 3000 })

	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.3 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })
	AdjustColorGrading({ Name = "BoonInteract", Duration = 0.3 })
	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "BoonInteractDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "BoonInteractFx", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	local boonSound = PlaySound({ Name = "/SFX/Enemy Sounds/Hades/HadesPhase2Start" })
	ShakeScreen({ Speed = 400, Distance = 4, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	wait( 0.8 )
	PlaySound({ Name = "/Leftovers/Menu Sounds/RosterPickup" })
	StopSound({ Id = boonSound, Duration = 0.3 })
	--PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.5 }, } )

	AdjustFullscreenBloom({ Name = "Off", Duration = 0.1 })

	wait(0.06)

	AdjustColorGrading({ Name = "Off", Duration = 3.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 3.0 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 3.0 )

	if args ~= nil then
		-- wait( args.PickupWait )
		wait( 1.2 )
	end
	SetAnimation({ Name= "MelTalkGifting01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })
	SetAlpha({ Id = beamTarget, Fraction = 0, Duration = 0.5 })
end

function OpenSpellScreenPresentation( screen, spellItem )

	PlaySound({ Name = "/Leftovers/SFX/AuraThrowSmallASCENSION" })

	if spellItem ~= nil then
		thread( PlayVoiceLines, spellItem.UpgradeMenuOpenVoiceLines, true, spellItem )
	end
end

function CloseSpellScreenPresentation( screen, button )

	CreateAnimation({ Name = "HitSparkA", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/SeleneMoonPickup" })
	wait( 0.02 )
	ShakeScreen({ Speed = 1000, Distance = 2, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.3 }, } )
	AdjustColorGrading({ Name = "ItemGet", Duration = 0.2 })
	SetAnimation({ Name = "MelinoeBoonInteractPowerUp", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "ItemGetVignette", OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, Scale = 2.0, UseScreenLocation = true })
	wait( 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	SpellDropInteractPresentationEnd()
end

function SpellDropInteractPresentationEnd( )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = 0, Retarget = true, Duration = 2.5 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 2.5, ZoomType = "Ease" })
end

function CloseTalentScreenPresentation( screen )

	CreateAnimation({ Name = "HitSparkA", DestinationId = buttonId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/StarSelectConfirm" })
	wait( 0.02 )

	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	local globalVoiceLines = GlobalVoiceLines[roomData.CloseTalentScreenGlobalVoiceLines] or GlobalVoiceLines.TalentDropUsedVoiceLines
	thread( PlayVoiceLines, globalVoiceLines, true )

	ShakeScreen({ Speed = 1000, Distance = 2, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.3 }, } )
	AdjustColorGrading({ Name = "ItemGet", Duration = 0.2 })
	SetAnimation({ Name = "MelinoeBoonInteractPowerUp", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "ItemGetVignette", OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, Scale = 2.0, UseScreenLocation = true })
	wait( 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })

	--SpellDropInteractPresentationEnd()
end

function LegendaryAspectPresentation( source, args )

	wait( args.WaitTime or 0 )

	AdjustColorGrading({ Name = "LegendaryProphecy", Duration = 0.2 })
	AdjustFullscreenBloom({ Name = "WeaponAspect", Duration = 0.2 })
	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova"  })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	local interactVignette = CreateAnimation({ Name = "WeaponKitInteractVignette_Prophecy", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = interactVignette })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColorInvert", Group = "FX_Add_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	ShakeScreen({ Speed = 600, Distance = 9, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.35, Duration = 0.30 }, } )

	wait( 0.3 )

	ShakeScreen({ Speed = 800, Distance = 3, FalloffSpeed = 500, Duration = 1.3 })
	thread( DoRumble, { { ScreenPreWait = 0.1, LeftFraction = 0.17, Duration = 1.4 }, } )

	wait( 2.1 )

	AdjustColorGrading({ Name = "Off", Duration = 0.8 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.8 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 1.0 )
end

function CannotRerollPresentation( run, target )

	Shake({ Id = target.ObjectId, Distance = 1, Speed = 300, Duration = 0.3, FalloffSpeed = 3000 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = target.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.CannotRerollVoiceLines, true )
end

function PreRerollPresentation( run, target )

	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })

	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.66 })
	target.RerollSoundId = PlaySound({ Name = "/Leftovers/Menu Sounds/StoryRecapTextAppear" })
	SetVolume({ Id = target.RerollSoundId, Value = 0.3 })

	thread( PlayVoiceLines, HeroVoiceLines.UsedRerollVoiceLines, true )

	wait(0.5)

	PlayInteractAnimation( target.ObjectId )
	AdjustColorGrading({ Name = "None", Duration = 0 })
	AdjustFullscreenBloom({ Name = "NewType06", Duration = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1, })

	local door = target
	if door.RewardPreviewBackingIds ~= nil then
		local backingId = door.RewardPreviewBackingIds[door.RerollIndex or 1]
		CreateAnimation({ Name = "RoomRewardShatterReRoll", DestinationId = backingId })
	end

end

function DestroyDoorRewardPresenation( door )

	if door.AdditionalIcons ~= nil and not IsEmpty( door.AdditionalIcons ) then
		Destroy({ Ids = GetAllValues( door.AdditionalIcons ) })
		door.AdditionalIcons = nil
	end

	if door.RewardPreviewIconIds ~= nil then
		for i, doorIconId in ipairs( door.RewardPreviewIconIds ) do
			SetScale({ Id = doorIconId, Fraction = 0, Duration = 0.1, EaseIn = 0.9, EaseOut = 1.0 })
			SetThingProperty({ Property = "AddColor", Value = true, DestinationId = doorIconId })
			thread( DestroyOnDelay, { doorIconId }, 1.4 )
			CreateAnimation({ Name = "RoomRewardShatter", DestinationId = doorIconId })
			--SetAlpha({ Id = door.RewardPreviewBackingIds[i], Fraction = 0, Duration = 0.1 })
			Destroy({ Id = door.RewardPreviewBackingIds[i] })
			if i < #door.RewardPreviewIconIds then
				wait( 0.2 )
			end
		end
	end
	door.RewardPreviewIconIds = nil
	door.RewardPreviewBackingIds = nil
end

function PostRerollPresentation( run, target )
	AdjustColorGrading({ Name = "Off", Duration = 1.0 })
	StopSound({ Id = target.RerollSoundId, Duration = 0.3 })
	if target.RewardPreviewIconIds ~= nil then
		SetColor({ Ids = target.RewardPreviewIconIds, Color = {1.0, 1.0, 1.0, 0}, Duration = 0 })
		SetColor({ Ids = target.RewardPreviewIconIds, Color = {0, 0, 0, 1}, Duration = 0.2 })
	end
	thread( PlayVoiceLines, HeroVoiceLines.RerollOutcomeVoiceLines, true )
	wait(0.5)
end

function NPCTeleportToExit( enemy, exitId, delay )
	wait(delay or 0, enemy.AIThreadName)
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = enemy.ObjectId })
	wait(0.05, enemy.AIThreadName)
	Teleport({ Id = enemy.ObjectId, DestinationId = exitId })
	wait(0.05, enemy.AIThreadName)
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = enemy.ObjectId })
	wait(0.5, enemy.AIThreadName)
	thread( DirectionHintPresentation, enemy )
end


function HecateExit( source, args )

	args = args or {}
	wait( args.WaitTime or 0 )

	if not args.SkipAnim then
		--SetAnimation({ Name = "NPCHecateExit", DestinationId = source.ObjectId })
	end

	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic" })
	CreateAnimation({ Name = "DeathSequenceFxBack", DestinationId = source.ObjectId, Group = "Combat_UI_World_Add" })
	CreateAnimation({ Name = "DeathSequenceFxFront", DestinationId = source.ObjectId, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.35 })

	source.NextInteractLines = nil
	UseableOff({ Id = source.ObjectId })
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )

	wait( 0.5, RoomThreadName )
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = source.ObjectId, Property = "StopsProjectiles", Value = false })

	source.Mute = true
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[source.ObjectId] = args.AnimationState
	end

end

function BiomeBackToRoom( room, args )
	args = args or {}
	if MapState.InOverlook then
		MapState.InOverlook = false
		UnblockCombatUI("Overlook")
		ToggleCombatControl( CombatControlsDefaults, true, "Overlook" )
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.5, FromCurrentLocation = true })
		FocusCamera({ Fraction = room.ZoomFraction or 1.0, Duration = 1.5, ZoomType = "Ease" })
		if not args.SkipReturnSound then
			PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
		end

		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 0.0, Duration = 0.5 })
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "Keys" }, Value = 1.0, Duration = 1.5 })
		SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 1.5 })
		thread( PlayVoiceLines, HeroVoiceLines.OverlookLeaveVoiceLines )
		ClearCameraFocusOverride()
		ShowCombatUI()

		SetThreadWait( "OverlookThread", 0.01 )
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
		local heroDestination = overlookData.HeroBeamPoint
		Move({ Id = CurrentRun.Hero.ObjectId, DestinationId = heroDestination, SuccessDistance = 32 })

		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )

		SetCameraFocusOverride()
		HideCombatUI("Overlook")

		Halt({ Id = CurrentRun.Hero.ObjectId })

		thread( FadeBackgroundForestOut )

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
		--FullScreenFadeOutAnimation()
		AddInputBlock({ Name = "Overlook" })
		
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.5, FromCurrentLocation = true })
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.01, Retarget = true, EaseIn = 0 })
		Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = overlookData.ReturnPositionId })
		--FullScreenFadeInAnimation()
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

function OverlookFlourish()
	local overlookData = CurrentRun.CurrentRoom.OverlookData
	if CurrentHubRoom ~= nil then
		overlookData = CurrentHubRoom.OverlookData
	end

	while MapState.InOverlook do
		local notifyName = "OverlookFlourish"
		NotifyOnControlPressed({ Names = { "Rush", }, Notify = notifyName })
		waitUntil( notifyName )

		SetAnimation({ DestinationId = overlookData.FlourishId, Name = overlookData.FlourishAnimation })

		if overlookData.FlourishSound ~= nil then
			PlaySound({ Name = overlookData.FlourishSound })
		end

		wait(overlookData.FlourishRefreshDelay or 3.0)
	end
end

function PassiveGoldGainPresentation( amount )
	wait(1)
	PlaySound({ Name = "/Leftovers/Menu Sounds/CoinLand", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "GoldPerRoomText", Duration = 1, LuaKey = "TempTextData", LuaValue = { TraitName = "ChamberGoldTrait", Amount = amount }})
end

function FountainDamagePresentation()
	PlaySound({ Name = "/SFX/Player Sounds/DionysusBlightWineDash", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "FountainDamageText_Alt", Duration = 1, LuaKey = "TempTextData", LuaValue = { TraitName = "FountainDamageBonusTrait", Amount = (GetTotalHeroTraitValue("FountainDamageBonus", {IsMultiplier = true}) - 1) * 100 } })
end

function AssistHintPresentation( source, args )
	for traitName, traitDatas in pairs( CurrentRun.Hero.TraitDictionary ) do
		if TraitData[traitName] and TraitData[traitName].Slot == "Assist" and not IsEmpty(traitDatas) and traitDatas[1] and traitDatas[1].AnchorId then
			local existingTraitData = GetExistingUITraitName( traitName )
			local offsetX = 220
			if GetLanguage({}) == "ja" then
				offsetX = offsetX + 30
			end
			thread( InCombatTextArgs, { TargetId = traitDatas[1].AnchorId, Text = "AssistAvailableHint", Duration = 1.25, ScreenSpace = true, OffsetX = offsetX, OffsetY = 0 })
			PlaySound({ Name = existingTraitData.EquipSound or "/Leftovers/SFX/PositiveTalismanProc_1", Id = traitDatas[1].AnchorId })
			return
		end
	end
	thread( InCombatText, CurrentRun.Hero.ObjectId, "AssistAvailableHint", 1 )
end

function ConsumableUsedPresentation( run, consumableItem, args )

	if consumableItem.OnConsumedGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[consumableItem.OnConsumedGlobalVoiceLines], true )
	end
	if consumableItem.Cost ~= nil and consumableItem.Cost > 0 and not consumableItem.IgnorePurchase then
		PlaySound({ Name = "/Leftovers/Menu Sounds/StoreBuyingItem" })
		if consumableItem.PurchasedVoiceLines ~= nil then
			thread( PlayVoiceLines, consumableItem.PurchasedVoiceLines, true )
		elseif consumableItem.OnPurchaseGlobalVoiceLines ~= nil then
			thread( PlayVoiceLines, GlobalVoiceLines[consumableItem.OnPurchaseGlobalVoiceLines], true )
		else
			if not consumableItem.BlockPurchasedVoiceLines then
				thread( PlayVoiceLines, GlobalVoiceLines.PurchasedConsumableVoiceLines, true )
			end
		end
	end
	if consumableItem.PlayInteract then
		PlayInteractAnimation( consumableItem.ObjectId )
	end
	if consumableItem.AcquireText then
		thread( InCombatText, consumableItem.ObjectId, consumableItem.AcquireText )
	end

	if consumableItem.ConsumeFx ~= nil then
		CreateAnimation({ Name = consumableItem.ConsumeFx, DestinationId = consumableItem.ObjectId })
	end
	PlaySound({ Name = consumableItem.ConsumeSound or "/SFX/GyroHealthPickupMunch", Id = consumableItem.ObjectId })
	thread( PlayVoiceLines, consumableItem.ConsumedVoiceLines, true )

end

function StorePurchasePresentation( screen, button, upgradeData, speedUpDelivery )
	args = args or {}
	PlaySound({ Name = upgradeData.OnPurchaseSound or "/Leftovers/Menu Sounds/StoreSellingItem" })
	if upgradeData.OnPurchaseGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[upgradeData.OnPurchaseGlobalVoiceLines], true )
	else
		if speedUpDelivery then
			PlaySound({ Name = "/SFX/Menu Sounds/HermesMainMenuSFX" })
			thread( PlayVoiceLines, GlobalVoiceLines.RushWellShopItemVoiceLines, true )
		else
			thread( PlayVoiceLines, GlobalVoiceLines.StandardWellShopItemVoiceLines, true )
		end
	end
end

Using "ResourceFinderArrow"
function HarvestPointAvailablePresentation( source, args )
	args = args or {}
	if not GameState.WorldUpgradesAdded.WorldUpgradeResourceFinder then
		return
	end
	if not IsUseable({ Id = source.ObjectId }) then
		return
	end
	
	wait( MapState.HarvestPointAvailableDelay )
	MapState.HarvestPointAvailableDelay = (MapState.HarvestPointAvailableDelay or 0) + 0.35

	thread( DirectionHintPresentation, source, { Cooldown = 0, Delay = 0, MoveDuration = 1.5, ArrowAnimationName = "ResourceFinderArrow", } )

	if CheckCooldown( "HarvestPointAvailablePresentation", 90 ) then
		thread( PlayVoiceLines, GlobalVoiceLines.HarvestPointFoundVoiceLines, true )
	end
	wait( 0.25, RoomThreadName )
	PlaySound({ Name = "/Leftovers/SFX/AnnouncementPing3", Id = source.ObjectId })
end

function FishingPointAvailablePresentation( source, args )
	args = args or {}
	if not GameState.WorldUpgradesAdded.WorldUpgradeResourceFinder then
		return
	end
	if not IsUseable({ Id = source.ObjectId }) then
		return
	end

	wait( MapState.HarvestPointAvailableDelay )
	MapState.HarvestPointAvailableDelay = (MapState.HarvestPointAvailableDelay or 0) + 0.35

	SetAnimation({ Name = "FishingPointActive", DestinationId = source.ObjectId })
	thread( DirectionHintPresentation, source, { Cooldown = 0, Delay = 0, MoveDuration = 1.5, ArrowAnimationName = "ResourceFinderArrow", } )
	wait( 0.25, RoomThreadName )
	PlaySound({ Name = "/Leftovers/SFX/AnnouncementPing7", Id = source.ObjectId })
end

function StartDevotionTestPresentation( currentRoom, alternateLootData, alternateLootId )
	AddInputBlock({ Name = "DevotionTest" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = alternateLootId })
	wait(1.0)
	Shake({ Id = alternateLootData.ObjectId, Distance = 2, Speed = 250, Duration = 1.0  })
	PanCamera({ Ids = alternateLootData.ObjectId, Duration = 3.5, EaseIn = 0.05, EaseOut = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.15, LeftFraction = 0.17, Duration = 1.0 }, } )
	thread( InCombatText, alternateLootId, alternateLootData.LootRejectedText, 2.5, { ShadowScaleX = 1.4 } )

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3", Id = alternateLootId })
	wait(0.5)
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteAngerSFX" })

	local textLines = GetRandomEligibleTextLines( alternateLootData, alternateLootData.RejectionTextLines, {} )
	PlayTextLines( alternateLootData, textLines )
	PanCamera({ Ids = CurrentRun.Hero.ObjectId, Duration = 1.0, EaseIn = 0.05, EaseOut = 0.3 })

	if alternateLootData.RejectionVoiceLines ~= nil then
		thread( PlayVoiceLines, alternateLootData.RejectionVoiceLines )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.GodRejectedVoiceLines, true )
	end
	wait(0.45)
	if alternateLootData.LootRejectionAnimation then
		CreateAnimation({ Name = alternateLootData.LootRejectionAnimation, DestinationId = alternateLootId })
	else
		CreateAnimation({ Name = "BoonOrbDissipate", DestinationId = alternateLootId, Color = Color.Red })
	end
	PlaySound({ Name = "/SFX/GodFavorBattleStart" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
end

function BiomeTimeCheckpointPresentation( run, additionalTime )

	wait( 1.0, RoomThreadName )

	local textStartX = 1830 + (ScreenCenterNativeOffsetX * 2.0)
	local textStartY = 180
	local textAnchorId = CreateScreenObstacle({ Name = "BlankObstacle", X = textStartX, Y = textStartY, Group = "Overlay" })

	CreateTextBox({
		Id = textAnchorId,
		Text = "BiomeTimeCheckpoint",
		LuaKey = "TempTextData",
		LuaValue = { Time = GetTimerString( additionalTime, 2 ) },
		OffsetX = 0,
		OffsetY = 0,
		Font = "LatoBoldItalic",
		FontSize = 22,
		Color = Color.White,
		OutlineThickness = 0,
		OutlineColor = {0.0, 0.0, 0.0,1},
		ShadowColor = {0,0,0,1},
		ShadowOffsetY=2,
		ShadowOffsetX=0,
		ShadowAlpha=1,
		ShadowBlur=0,
	})


	SetAnimation({ Name = "BiomeTimerTimeAdded", DestinationId = textAnchorId })

	wait( 2.0, RoomThreadName )

	Move({ Id = textAnchorId, OffsetX = textStartX, OffsetY = textStartY + 25, Duration = 0.5, EaseIn = 0, EaseOut = 1 })
	ModifyTextBox({ Id = textAnchorId, FadeTarget = 0, FadeDuration = 0.5 })

	wait( 0.5, RoomThreadName )

	Destroy({ Id = textAnchorId })
end

function MoneyDropPresentation( moneyDrop, args )
	PlaySound({ Name = "/SFX/GoldCoinPickup", Id = moneyDrop.ObjectId, ManagerCap = 28 })
end

function HandleWeaponAspectsRevealObjective()
	wait(2.3)
	CheckObjectiveSet("AspectsRevealPrompt")
end

function EncounterCostDoorUsedPresentation( exitDoor, args )
	AddInputBlock({ Name = "EncounterDoorPresentation" })
	FreezePlayerUnit( "EncounterDoorPresentation" )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = exitDoor.ObjectId })
	SetAnimation({ Name = "Melinoe_Cast_Start", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.32)
	SetAnimation({ Name = "Melinoe_Cast_Fire", DestinationId = CurrentRun.Hero.ObjectId })
	UnfreezePlayerUnit("EncounterDoorPresentation")
	RemoveInputBlock({ Name = "EncounterDoorPresentation" })
end

function CutsceneAddLetterbox()
	ScreenAnchors.LetterBoxTop = ScreenAnchors.LetterBoxTop or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY - 1220 })
	ScreenAnchors.LetterBoxBottom = ScreenAnchors.LetterBoxBottom or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY + 1220 })
	SetScale({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = 5 })
	SetScaleX({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = ScreenScaleX })
	SetColor({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Color = Color.Black })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = 1.0, Duration = 0 })
	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 270, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 90, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
end


function AltRunDoorUnlockedFirstPresentation(room, args)

	wait( 1.0 )
	local newRunDoorId = 555784
	local newRunDoorScriptTarget = 585605

	AddInputBlock({ Name = "AltRunDoorUnlockedFirstPresentation" })
	
	HideCombatUI( "AltRunDoorUnlockedFirstPresentation" )
	ClearCameraClamp({ LerpTime = 1.35 })
	thread( PlayVoiceLines, HeroVoiceLines.AltRunDoorUnlockedVoiceLines, true )

	CutsceneAddLetterbox()
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	wait( 1.35 )

	PanCamera({ Id = newRunDoorScriptTarget, Duration = 2.3, EaseIn = 0, EaseOut = 0.99 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	wait( 4.0 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.3 })

	wait(0.5)
	
	RemoveInputBlock({ Name = "AltRunDoorUnlockedFirstPresentation" })
	ShowCombatUI( "AltRunDoorUnlockedFirstPresentation" )

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })

	thread( AltRunDoorReturnPresentationEnd )

end


function ScreenEdgeIndicatorSpawnPresentation( source, args, indicatorBackingId, indicatorId )
	SetAlpha({ Id = indicatorId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = indicatorId, Fraction = 1.0, Duration = 0.2 })
	CreateAnimation({ Name = "ScreenEdgeIndicatorSpawnFx", DestinationId = indicatorBackingId })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh", Id = indicatorBackingId })
	PlaySound({ Name = args.SoundName or "/SFX/Menu Sounds/MirrorCloseWithUpgrade" })
end

function AltRunDoorReturnPresentationEnd()
	CheckObjectiveSet( "SurfaceDoorPrompt" )
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

function ViewPortraitPresentation( eventSource, args )

	local portraitStartScale = 0.93
	local portraitEndScale = 0.63

	if not PlayingTextLines then
		UseableOff({ Id = eventSource.ObjectId })
	end

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = eventSource.ObjectId })
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })

	AddInputBlock({ Name = "ShowingInterstitial" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	HideCombatUI("ShowingInterstitial")
	if args.PauseMusic then
		PauseMusic()
	end

	SetVolume({ Id = AudioState.AmbienceId, Value = 0.0, Duration = 0.5 })
	AudioState.PortraitAmbienceId = PlaySound({ Name = "/Ambience/MusicExploration4AMBIENCEIris" })

	if args.PortraitGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[args.PortraitGlobalVoiceLines] )
	else
		thread( PlayVoiceLines, HeroVoiceLines.UsedFamilyPortraitVoiceLines )
	end

	wait( args.StartDelay or 0 )

	if args.FadeInTime then
		FadeIn({ Duration = args.FadeInTime })
	end

	if args.SecretMusic then
		SecretMusicPlayer( args.SecretMusic )
		SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = args.SecretMusicSection })
		SetSoundCueValue({ Names = args.SecretMusicActiveStems, Id = SecretMusicId, Value = 1, Duration = args.SecretMusicActiveStemsDuration or 1 })
		SetSoundCueValue({ Names = args.SecretMusicMutedStems, Id = SecretMusicId, Value = 0, Duration = args.SecretMusicMutedStemsDuration or 1 })
	end

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })

	ScreenAnchors.PortraitDisplayAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Overlay", X = ScreenCenterX, Y = ScreenCenterY })
	local blackScreenId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = blackScreenId, Fraction = 10 })
	SetColor({ Id = blackScreenId, Color = Color.Black })
	SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0 })

	local portraitId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
	SetScale({ Id = portraitId, Fraction = portraitStartScale })
	SetAlpha({ Id = portraitId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = portraitId, Fraction = 1.0, Duration = 1.0 })
	SetAnimation({ Name = args.PortraitAnimationName, DestinationId = portraitId })

	Attach({ Id = blackScreenId, DestinationId = ScreenAnchors.PortraitDisplayAnchor })
	Attach({ Id = portraitId, DestinationId = ScreenAnchors.PortraitDisplayAnchor })

	-- Camera Pan
	AdjustFullscreenBloom({ Name = "NewType06", Duration = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1, Delay = 0 })
	Teleport({ Id = ScreenAnchors.PortraitDisplayAnchor, DestinationId = ScreenAnchors.PortraitDisplayAnchor, OffsetX = 0, OffsetY = 0 })
	-- Move({ Id = ScreenAnchors.PortraitDisplayAnchor, DestinationId = ScreenAnchors.PortraitDisplayAnchor, OffsetX = 0, OffsetY = 50, Duration = args.PanDuration or 9.4, EaseOut = 1.0, EaseIn = 0.0 })
	
	SetScale({ Id = portraitId, Fraction = portraitEndScale, Duration = args.PanDuration or 9.8, EaseOut = 1.0, EaseIn = 0.0 })

	local totalSequenceDuration = 12.0
	local durationBeforeAllowingInput = 6.5

	wait( durationBeforeAllowingInput )

	local notifyName = "PortraitPressAnyButton"
	local timeoutDuration = totalSequenceDuration - durationBeforeAllowingInput
	NotifyOnControlPressed({ Names = { "Confirm", "Rush", "Attack1", "Attack2", "Attack3", "Attack4", "Interact", "Codex", "Shout", "AutoLock", }, Notify = notifyName, Timeout = timeoutDuration })
	waitUntil( notifyName )

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })

	StopSound({ Id = AudioState.PortraitAmbienceId, Duration = 1.0 })
	AudioState.PortraitAmbienceId = nil
	SetVolume({ Id = AudioState.AmbienceId, Value = 1.0, Duration = 1.0 })

	wait(0.375)
	
	SetAlpha({ Id = blackScreenId, Fraction = 0.0, Duration = 0.375 })
	SetAlpha({ Id = portraitId, Fraction = 0.0, Duration = 0.375 })

	wait(0.625)
	Destroy({ Id = portraitId })
	Destroy({ Id = blackScreenId })
	Destroy({ Id = ScreenAnchors.PortraitDisplayAnchor })

	if args.SecretMusic then
		StopSound({ Id = SecretMusicId, Duration = 2 })
		ResumeMusic()
		SecretMusicId = nil
		SecretMusicName = nil
	end

	if args.PauseMusic then
		ResumeMusic()
	end

	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })

	RemoveInputBlock({ Name = "ShowingInterstitial" })
	UnblockCombatUI("ShowingInterstitial")

	thread( FamilyPortraitUsabilityToggle, eventSource )

end

function FamilyPortraitUsabilityToggle( eventSource )

	if not PlayingTextLines then
		wait( 15.0, RoomThreadName )
		UseableOn({ Id = eventSource.ObjectId })
	else
		wait( 10.0, RoomThreadName )
		UseableOn({ Id = eventSource.ObjectId })
	end

end

function OlympusTremorPresentation( eventSource, args )

	eventSource.OlympusTremorPresentation = true
	local delay = 5.0
	if args.DelayMin ~= nil and args.DelayMax ~= nil then
		delay = RandomFloat(args.DelayMin, args.DelayMax)
	end
	wait(delay)

	local soundId = PlaySound({ Name = "/Leftovers/Object Ambiences/OlympusQuakeSFX", Id = CurrentRun.Hero.ObjectId })

	ShakeScreen({ Speed = 150, Distance = 6, Duration = 3.0, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.3, Duration = 1.8 }, } )
	AdjustColorGrading({ Name = "Team01", Duration = 0.3 })

	local targetIds = { }
	for index = 1, 16, 1 do
		local randomOffsetX = RandomInt( -1800, 1800 )
		local randomOffsetY = RandomInt( -200, 200 )
		local targetId = SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Standing_Top", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = randomOffsetX, OffsetY = randomOffsetY - 800 })
		CreateAnimation({ Name = "OlympusTremorStreaks", GroupName = "FX_Standing_Top", DestinationId = targetId })
		local randomSpeed = RandomInt( 7000, 11000 )
		Move({ Id = targetId, Angle = 270, Speed = randomSpeed })
		-- UseScreenLocation = true,  OffsetX = ScreenCenterX, OffsetY = ScreenCenterY,
		local randomWait = RandomFloat( 0.03, 0.13 )
		table.insert( targetIds, targetId )
		wait(randomWait)
	end

	wait(0.3)
	
	AdjustColorGrading({ Name = "Off", Duration = 1.0 })
	
	thread( PlayVoiceLines, HeroVoiceLines.TremorReactionVoiceLines, false )
	Destroy({ Ids = targetIds })

	StopSound({ Id = soundId, Duration = 3.0 })
end

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
	PlaySound({ Name = "/SFX/ShipsDoorTeleport" })

	-- Mel cast anim 
	SetAnimation({ Name = "Melinoe_Cast_Start", DestinationId = currentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })
	
	-- start charging energy VFX
	CreateAnimation({ DestinationId = exitDoorId, Name = "ShipsDoorMelZwoop", Group = "FX_Standing_Add" })
	wait( 1.2 )

	-- energy shot VFX and camera effects
	PlaySound({ Name = "/SFX/ShipsDoorUse" })
	--AdjustZoom({ Fraction = (currentRun.CurrentRoom.ZoomFraction or 0.75) * 0.9, LerpTime = 0.2 })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.2 })
	-- CreateAnimation({ DestinationId = exitDoorId, Name = "ShipsDoorBurst" })
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

function ShipsRoomEntrancePresentation( currentRun, currentRoom, args )

	args = args or {}

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or 0.3
	local roomIntroPanDuration = roomData.IntroPanDuration or 2.0

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
		if not args.SkipGusts then
			thread( GustWinds, { ObjectId = cameraSetupPoint, Count = 4 })
		end

		local heroExitIds = GetIdsByType({ Name = "HeroExit" })
		local heroExitPointId = heroExitIds[1]

		if not args.SkipGusts then
			thread( GustWinds, { ObjectId = heroExitPointId, AnimationName = "ShipsGustSpawnerForward", Count = 3 })
		end
	end

	wait( roomIntroPanDuration )
	
	AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75), LerpTime = 0.2 })
	
	wait( 0.05 )

	-- CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "ShipsDoorBurstArrival" })
	PlaySound({ Name = "/SFX/ShipsTeleportArrive", Id = CurrentRun.Hero.ObjectId })

	wait( 0.10 )

	PanCamera({ Id = currentRoom.CameraEndPoint, OffsetX = 70, OffsetY = -34, Duration = 0.2, Retarget = true })

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1, Duration = 0.1 })
	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "DustPuffA" })
	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "ShipsDoorMelZwoop_In", OffsetZ = 80 })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeDash" })
	ShakeScreen({ Speed = 500, Distance = 8, FalloffSpeed = 1000, Duration = 0.2 })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or roomData.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	wait( 0.03 )
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
end

function OlympusSkyExitPresentation( currentRun, exitDoor )

	CurrentRun.CurrentRoom.NextRoomEntranceFunctionNameOverride = exitDoor.NextRoomEntranceFunctionName
	CurrentRun.CurrentRoom.NextRoomEntranceFunctionArgsOverride = exitDoor.NextRoomEntranceFunctionArgs
	AddInputBlock({ Name = "OlympusLeaveRoomPresentation" })
	
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "OlympusLeaveRoomPresentation" )

	local exitDoorId = exitDoor.ObjectId
	local door = MapState.OfferedExitDoors[exitDoorId]

	Stop({ Id = CurrentRun.Hero.ObjectId })
	waitUnmodified (0.01)
	PlayInteractAnimation( exitDoorId, { Animation = GetEquippedWeaponValue( "WeaponInteractAnimation" ) } )

	if door ~= nil then
		thread( DestroyDoorRewardPresenation, door )
		if door.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorOpenAnimation })
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
			-- wait( 0.7 )
		end
	end

	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = exitDoorId, DestinationIds = heroExitIds, Distance = 800 })
	if heroExitPointId <= 0 and exitDoorId ~= nil then
		heroExitPointId = exitDoorId
	end

	thread( PlayVoiceLines, HeroVoiceLines.OlympusSkyExitVoiceLines, false )

	local args = {}
	args.SuccessDistance = 20
	args.DisableCollision = true
	local exitPath = {}
	table.insert( exitPath, exitDoor.ObjectId )
	thread( MoveHeroAlongPath, exitPath, args )

	--waitUnmodified( 0.35 )
	--Stop({ Id = CurrentRun.Hero.ObjectId })

	waitUnmodified (0.01)

	local jumpSound = PlaySound({ Name = "/SFX/BombFusePreExplode", Id = exitDoor.ObjectId })
	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 1.8 })
	Flash({ Id = exitDoorId, Speed = 0.65, MinFraction = 0, MaxFraction = 1.0, Color = Color.White, ExpireAfterCycle = true})

	waitUnmodified( 0.5 )

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Melinoe_CrossCast_Start_Fast", DestinationId = CurrentRun.Hero.ObjectId, })
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.5, OffsetY = -400, Retarget = true })
	
	waitUnmodified( 0.18 )

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.25 }, } )
	SetAnimation({ Name = "MelinoeCrossCastHold", DestinationId = CurrentRun.Hero.ObjectId })
	ShakeScreen({ Speed = 400, Distance = 4, Angle = 0, FalloffSpeed = 1000, Duration = 1.0 })

	waitUnmodified( 0.05 )
	PlaySound({ Name = "/SFX/OlympusJumpLaunchOnly" })
	StopSound({ Id = jumpSound, Duration = 0.2 })
	jumpSound = nil

	AdjustZLocation({ Id = CurrentRun.Hero.ObjectId, Distance = 1400, Duration = 0.35, })

	waitUnmodified( 0.12 )

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	LeaveRoomAudio( currentRun, exitDoor )
	if exitDoor.Room.ExitTowardsFunctionName ~= nil then
		CallFunctionName( exitDoor.Room.ExitTowardsFunctionName, exitDoor, exitDoor.Room.ExitTowardsFunctionArgs )
	end

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	IgnoreGravity({ Id = CurrentRun.Hero.ObjectId })
	FullScreenFadeOutAnimation( currentRun.CurrentRoom.FadeOutAnimation )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "OlympusLeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function OlympusSkyEntrancePresentation( currentRun, currentRoom, args )
	currentRoom.BlockAggro = true
	local notifyName = args.NotifyName or "SkyEntranceInput"
	currentRoom.EntrancePresentationNotifyName = notifyName
	local startPoint = GetRandomValue(GetIds({ Name = "SkySpawnPoints" })) or currentRoom.HeroEndPoint

	AddInputBlock({ Name = "OlympusSkyEntrancePresentation" })
	SetPlayerInvulnerable( "OlympusSkyEntrance" )
	ToggleCombatControl( CombatControlsDefaults, false, "OlympusSkyEntrancePresentation" )
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	AdjustFullscreenBloom({ Name = "NewType09" })

	if startPoint ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = startPoint })
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = startPoint })
	end
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0, OffsetY = -150 })
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.2, EaseIn = 0, Retarget = true})
	AdjustZoom({ Fraction = 0.5, LerpTime = 0.0 })
	wait(0.03)
	local airSoundId = PlaySound({ Name = "/Leftovers/Ambience/WhippingWindLoopLoud", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/GasBomb", Id = CurrentRun.Hero.ObjectId })

	ApplyUpwardForce({ Id = currentRun.Hero.ObjectId, Speed = -100 })
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	--
	RemoveInputBlock({ Name = "OlympusSkyEntrancePresentation" })
	RemoveInputBlock({ Name = "StartRoom" })
	RemoveInputBlock({ Name = "StartRoomPresentation" })

	-- Start these earlier than normal in this case
	RunEventsGeneric( currentRun.CurrentRoom.Encounter.EncounterSpawnsStartEvents, currentRun.CurrentRoom.Encounter )
	currentRun.CurrentRoom.Encounter.RanEncounterSpawnsStartEvents = true

	SetAnimation({ Name = "HeroTouchdownCircle", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.0 })
	SetUnitProperty({ Property = "MoveGraphic", Value = nil, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithUnits", Value = false, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = false, DestinationId = CurrentRun.Hero.ObjectId })

	AdjustZoom({ Fraction = currentRoom.ZoomFraction, LerpTime = 3.65 })

	wait(1.0) -- buffer before you can dash-to-slam-down

	if not GameState.SkyEntranceInputSuccess and GameState.SkyEntranceIntroduced then
		CheckObjectiveSet("SkyEntranceInput")
	end

	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	ToggleCombatControl( { "Rush" }, true, "OlympusSkyEntrancePresentation" )
	NotifyOnControlPressed({ Names = { "Rush" }, Notify = notifyName, Timeout = 2.35 })

	thread( PlayVoiceLines, HeroVoiceLines.OlympusSkyEntranceVoiceLines, false )

	waitUntil( notifyName )

	if not _eventTimeoutRecord[notifyName] then
		thread( MarkObjectiveComplete, "SkyEntranceInput" )
		GameState.SkyEntranceInputSuccess = true
	else
		thread( MarkObjectiveFailed, "SkyEntranceInput" )
	end
	GameState.SkyEntranceIntroduced = true

	Stop({ Id = currentRun.Hero.ObjectId })
	AddInputBlock({ Name = "OlympusSkyEntrancePresentation" })

	if IsLocationBlocked({ Id = currentRun.Hero.ObjectId }) then
		LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0.3, Retarget = true })
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = GetClosest({ Id = currentRun.Hero.ObjectId, DestinationIds = GetIds({ Name = "SpawnPoints" }) }) })
		wait( 0.15 )
	end

	wait( 0.15 )

	PlaySound({ Name = "/SFX/OlympusJumpSlam", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteAttackingFierce", Id = CurrentRun.Hero.ObjectId })

	StopSound({ Id = airSoundId, Duration = 0.2 })

	AdjustZLocation({ Id = currentRun.Hero.ObjectId, Distance = 900, Duration = 0.0 })
	ApplyUpwardForce({ Id = currentRun.Hero.ObjectId, Speed = -2000 })
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.0 })
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.15 )

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 0.25 })

	StopAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Names = { "HeroTouchdownCircleA", "HeroTouchdownCircleShadow", "HeroTouchdownFx" } })

	SetUnitProperty({ Property = "CollideWithUnits", Value = true, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "MelinoeRun", DestinationId = CurrentRun.Hero.ObjectId })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })

	wait( 0.03 )

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	wait( 0.1 )

	currentRoom.BlockAggro = false
	CreateProjectileFromUnit({ Name = "HeroSkyTouchdown", Id = currentRun.Hero.ObjectId, DestinationId = currentRun.Hero.ObjectId, FireFromTarget = true })
	SetAnimation({ Name = "Melinoe_HeroLanding", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = dropShadow, Fraction = 0, Duration = 0.03 })
	ShakeScreen({ Speed = 150, Distance = 6, Duration = 0.15, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.18, Duration = 0.8 }, } )
	
	-- Aggro all units
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if not enemy.IsDead and not enemy.IsAggroed then
			enemy.AggroWhenReady = true
			enemy.ForcedWeaponInterrupt = true
			SetThreadWait(enemy.AIThreadName, 0.01)
			notifyExistingWaiters(enemy.AINotifyName)
		end
	end

	wait( 0.4 )

	RemoveInputBlock({ Name = "OlympusSkyEntrancePresentation" })
	ToggleCombatControl( CombatControlsDefaults, true, "OlympusSkyEntrancePresentation" )
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })

	wait( 0.05 )

	SetPlayerVulnerable( "OlympusSkyEntrance" )
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
	PlaySound({ Name = "/SFX/ShipsTeleportArrive", Id = CurrentRun.Hero.ObjectId })

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
	SetUntargetable({ Ids = tentacleIds })

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
	thread( InCombatText, charybdisId, "Alerted", 0.45, { SkipShadow = true, OffsetY = -550 } )
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
	SetTargetable({ Ids = tentacleIds })

	thread(SetupBoss, ActiveEnemies[charybdisId])
	for k, id in pairs(tentacleIds) do
		thread(SetupBoss, ActiveEnemies[id])
	end

	if GetNumShrineUpgrades( "MinibossCountShrineUpgrade" ) >= 1 then
		ActivatePrePlacedUnits( nil, { Ids = GetInactiveIdsByType({ Name = "Swab_Shadow" }) } )
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
		CreateAnimation({ DestinationId = nemesis.ObjectId, Name = CurrentRun.CurrentRoom.ExitVfx or RoomData.BaseRoom.ExitVfx })
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
	-- Should probably call full CleanupEnemy() but keeping this narrow
	killTaggedThreads( nemesis.AIThreadName )
	killWaitUntilThreads( nemesis.AINotifyName )
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
	CleanupCustomRoomSounds()
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
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "Tallness", Value = 400 })

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
	if args.FirstVisitRequirements == nil or IsGameStateEligible( exitDoor, args.FirstVisitRequirements ) then

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
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 4 })
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
		{
			Text = "Hub", OffsetX = 20, OffsetY = -440,
			Glow = nil, GlowOffsetX = nil, GlowOffsetY = nil,
		},
		{
			Text = "BiomeF", OffsetX = -680, OffsetY = 263,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_F", GlowOffsetX = -690, GlowOffsetY = 270 + 355,
			SelectedLoopScale = 1.0, SelectedLoopOffsetX = -680, SelectedLoopOffsetY = 270 + 340,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_F", FogOffsetX = -680, FogOffsetY = 270 + 340,
		},
		{
			Text = "BiomeG", OffsetX = 20, OffsetY = 480,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_G", GlowOffsetX = 20, GlowOffsetY = 480 + 340,
			SelectedLoopScale = 0.5, SelectedLoopOffsetX = 20, SelectedLoopOffsetY = 480 + 340,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_G", FogOffsetX = 20, FogOffsetY = 480 + 340,
			--SpotlightScale = 1.5,
		},
		{
			Text = "BiomeH", OffsetX = 633, OffsetY = 1335,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_H", GlowOffsetX = 643, GlowOffsetY = 750 + 320,
			SelectedLoopScale = 0.55, SelectedLoopOffsetX = 629, SelectedLoopOffsetY = 728 + 340,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_H", FogOffsetX = 661, FogOffsetY = 750 + 340,
		},
		{
			Text = "BiomeI", OffsetX = 33, OffsetY = 1935,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_I", GlowOffsetX = 11, GlowOffsetY = 1260 + 290,
			SelectedLoopScale = 0.60, SelectedLoopOffsetX = 10, SelectedLoopOffsetY = 1160 + 340,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_I", FogOffsetX = 30, FogOffsetY = 1260 + 340,
		},

		{
			Text = "BiomeN", OffsetX = 626, OffsetY = -250,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_N", GlowOffsetX = 613, GlowOffsetY = -610,
			SelectedLoopScale = 0.5, SelectedLoopOffsetX = 604, SelectedLoopOffsetY = -614,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_N", FogOffsetX = 604, FogOffsetY = -614,
		},

		{
			Text = "BiomeO", OffsetX = -460, OffsetY = -885,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_O", GlowOffsetX = 15, GlowOffsetY = -910,
			SelectedLoopScale = 0.65, SelectedLoopOffsetX = 12, SelectedLoopOffsetY = -905,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_O", FogOffsetX = 15, FogOffsetY = -910,
		},

		{
			Text = "BiomeP", OffsetX = 16, OffsetY = -1875,
			Glow = "GUI\\BiomeMap\\BiomeMap_Glow_P", GlowOffsetX = 16, GlowOffsetY = -1540,
			SelectedLoopScale = 0.5, SelectedLoopOffsetX = 16, SelectedLoopOffsetY = -1560,
			Fog = "GUI\\BiomeMap\\BiomeMap_Fog_P", FogOffsetX = 16, FogOffsetY = -1560,
		},
	}

	killTaggedThreads("MetaUpgradePresentation")
	for _, id in pairs(SessionMapState.ShownMetaUpgradeCardIds) do
		StopAnimation({  Names = { "MetaUpgradeCardFlip", "CardFlipGlowA", "CardFlipGlowB" }, DestinationId = id })
	end
	Destroy({ Ids = CollapseTable(SessionMapState.ShownMetaUpgradeCardIds) })

	AddInputBlock({ Name = "BiomeMapPresentation" })
	LoadPackages({ Name = "BiomeMap", IgnoreAssert = true })

	GameState.BiomeMapRecord[args.BiomeStart] = (GameState.BiomeMapRecord[args.BiomeStart] or 0) + 1

	-- setup biome map
	local groupName = "Combat_UI"
	local backgroundId = SpawnObstacle({ Name = "rectangle01", Group = groupName, LocationX = 0.0, LocationY = 0.0, SortById = true })
	SetColor({ Id = backgroundId, Color = Color.Black, Duration = 0 })
	SetScale({ Id = backgroundId, Fraction = 10.0 })
	local biomeMapId = SpawnObstacle({ Name = "BlankObstacle", Group = groupName, LocationX = 0.0, LocationY = 0.0, SortById = true })
	SetAnimation({ DestinationId = biomeMapId, Name = "GUI\\BiomeMap\\BiomeMap" }) -- nopkg
	CreateAnimation({ Name = "BiomeMapAnimations", DestinationId = biomeMapId })
	ClearCameraClamp({ LerpTime = 0 })
	PanCamera({ Id = biomeMapId, Duration = 0.0 })
	LockCamera({ Id = biomeMapId, Duration = 0.0 })
	local mapIds = {}
	table.insert( mapIds, biomeMapId )
	local startingGlowId = nil
	local endingGlowId = nil
	local selectedCircleId = nil
	local selectedCircleEndScale = nil
	local endingFogId = nil
	local endingSpotlightId = nil

	-- setup vignette
	local vignetteId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay",
		X = ScreenCenterX, Y = ScreenCenterY,
		ScaleX = ScreenScaleX, ScaleY = ScreenScaleY,
		Animation = "BiomeMapVignetteLoop" })
	
	-- setup map glows & labels
	for k, label in pairs( labelData ) do

		--ShowBiomeMapLabel( label, biomeMapId ) -- don't show label in Biome Map version

		if label.Glow ~= nil then
			local startingAlpha = 0.0
			if label.Text == args.BiomeStart then
				startingAlpha = 1.0
			end
			local glowId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI_Additive", LocationX = label.GlowOffsetX, LocationY = label.GlowOffsetY })
			SetAnimation({ DestinationId = glowId, Name = label.Glow })
			SetAlpha({ Id = glowId, Fraction = startingAlpha, Duration = 0 })
			if label.Text == args.BiomeStart then
				startingGlowId = glowId
			elseif label.Text == args.BiomeEnd then
				endingGlowId = glowId
			end
			table.insert( mapIds, glowId )
		end

		if label.Text == args.BiomeEnd then
			local startingAlpha = 0.0
			selectedCircleId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", LocationX = label.SelectedLoopOffsetX, LocationY = label.SelectedLoopOffsetY })
			--SetAnimation({ DestinationId = selectedCircleId, Name = "BiomeMapSelectedLoop" })
			SetAlpha({ Id = selectedCircleId, Fraction = startingAlpha, Duration = 0 })
			selectedCircleEndScale = label.SelectedLoopScale
			SetScale({ Id = selectedCircleId, Fraction = label.SelectedLoopScale * 1.12, Duration = 0 })
			table.insert( mapIds, selectedCircleId )
		end

		if label.Text ~= args.BiomeStart and label.Text ~= args.BiomeEnd and label.Fog ~= nil and not Contains( args.PreviousBiomes, label.Text ) then
			local fogId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", LocationX = label.FogOffsetX, LocationY = label.FogOffsetY })
			SetAnimation({ DestinationId = fogId, Name = label.Fog })
			SetAlpha({ Id = fogId, Fraction = 1.0, Duration = 0 })
			SetScale({ Id = fogId, Duration = 12, Fraction = 1.25 })
			table.insert( mapIds, fogId )
		end
		if label.Text == args.BiomeEnd and label.Fog ~= nil then
			endingFogId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", LocationX = label.FogOffsetX, LocationY = label.FogOffsetY })
			SetAnimation({ DestinationId = endingFogId, Name = label.Fog })
			SetAlpha({ Id = endingFogId, Fraction = 1.0, Duration = 0 })
			table.insert( mapIds, endingFogId )

			endingSpotlightId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Text", LocationX = label.FogOffsetX, LocationY = label.FogOffsetY })
			SetAnimation({ DestinationId = endingSpotlightId, Name = "GUI\\BiomeMap\\Spotlight_01"}) --nopkg
			SetAlpha({ Id = endingSpotlightId, Fraction = 0, Duration = 0 })
			SetScale({ Id = endingSpotlightId, Fraction = label.SpotlightScale or 1.0 })
			table.insert( mapIds, endingSpotlightId )
		end
	end

	-- setup marker units
	local melId = SpawnObstacle({ Name = "BlankObstacle3D", Group = "Combat_Menu_TraitTray", SortById = true,
		LocationX = args.HeroStartOffsetX, LocationY = args.HeroStartOffsetY })
	SetThingProperty({ Property = "GrannyModel", Value = "MelMarker_Mesh", DestinationId = melId })
	SetAnimation({ Name = "MelMarkerIdle", DestinationId = melId })
	
	-- adjust scale of Mel based on Circe's spells
	if HeroHasTrait( "CirceEnlargeTrait" ) then
		SetScale({ Id = melId, Fraction = 1.70 })
	elseif HeroHasTrait( "CirceShrinkTrait" ) then
		SetScale({ Id = melId, Fraction = 0.65 })
	end

	local playerTeamIds = { melId }
	local familiarId = nil
	if MapState.FamiliarUnit ~= nil and MapState.FamiliarUnit.MarkerModel ~= nil then
		familiarId = SpawnObstacle({ Name = "BlankObstacle3D", Group = "Combat_Menu_TraitTray", SortById = true,
			LocationX = args.FamiliarStartOffsetX, LocationY = args.FamiliarStartOffsetY })
		SetThingProperty({ Property = "GrannyModel", Value = MapState.FamiliarUnit.MarkerModel, DestinationId = familiarId })
		SetAnimation({ Name = MapState.FamiliarUnit.MarkerIdleAnimation, DestinationId = familiarId })
		table.insert( playerTeamIds, familiarId )
	end

	local extraObjectIds = { }
	if args.ExtraObjects ~= nil then
		for i, objectData in pairs( args.ExtraObjects ) do
			local id = SpawnObstacle({ Name = objectData.Name, Group = "Combat_Menu_TraitTray", SortById = true,
				LocationX = objectData.OffsetX, LocationY = objectData.OffsetY })
			table.insert( extraObjectIds, id )
			if objectData.Model ~= nil then
				SetThingProperty({ Property = "GrannyModel", Value = objectData.Model, DestinationId = id })
			end
			if objectData.Animation ~= nil then
				SetAnimation({ Name = objectData.Animation, DestinationId = id })
			end
			if objectData.Angle ~= nil then
				SetAngle({ Angle = objectData.Angle, Id = id })
			end
		end
	end

	local melAngle = math.atan2( -args.HeroMoveOffsetY, args.HeroMoveOffsetX )
	SetAngle({ Ids = playerTeamIds, Angle = math.deg( melAngle ) })

	-- setup visual effects
	CreateAnimation({ Name = "BiomeMapDustEmitter", DestinationId = startingGlowId })
	CreateAnimation({ Name = "BiomeMapDustEmitter", DestinationId = endingGlowId })
	SetScale({ Id = vignetteId, Duration = 10, Fraction = 1.2 })

	-- camera start
	wait( 0.02 )
	if args.CrossroadsStart then
		AdjustZoom({ Fraction = 0.785, LerpTime = 0 })
	else
		LockCamera({ Id = melId, Duration = 0 })
		AdjustZoom({ Fraction = 0.950, LerpTime = 0 })
	end

	-- presentation starts
	FullScreenFadeInAnimation()
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	thread( PlayVoiceLines, HeroVoiceLines.RegionClearedVoiceLines, true )

	-- camera setup
	local destinationId = SpawnObstacle({ Name = "InvisibleTarget", Group = groupName, SortById = true,
		LocationX = args.HeroStartOffsetX + args.HeroMoveOffsetX, LocationY = args.HeroStartOffsetY + args.HeroMoveOffsetY })
	
	-- show completed bounties from previous region
	for bountyName, v in pairs( CurrentRun.BountiesCompleted ) do
		local bountyData = BountyData[bountyName]
		if bountyData ~= nil then
			local prevRoom = GetPreviousRoom( CurrentRun )
			if CurrentRun.CurrentRoom.Encounter.Name == bountyData.Encounter or
				prevRoom.Encounter.Name == bountyData.Encounter then

				BiomeMapShowBounty( source, args, bountyData )

				SetAlpha({ Id = args.TargetItemId, Fraction = 1.0 })
				SetAlpha({ Id = args.BountyBackingId, Fraction = 1.0 })
				SetAlpha({ Id = args.ShrinePointItemId, Fraction = 1.0 })
				SetAlpha({ Id = args.WeaponItemId, Fraction = 1.0 })

				wait(1.1)
				CreateAnimation({ Name = "ExorcismCorrectFlash", DestinationId = args.TargetItemId, Group = "Combat_Menu_TraitTray_Overlay", Scale = 0.9, OffsetY = -45, OffsetX = 10 })
				PlaySound({ Name = "/SFX/Menu Sounds/BiomeMapRewardIcon", Id = args.TargetItemId })
				wait(0.05)
				SetColor({ Id = args.TargetItemId, Color = Color.Black, Duration = 0.25})
				SetColor({ Id = args.BountyBackingId, Color = Color.Black, Duration = 0.25})
				SetColor({ Id = args.ShrinePointItemId, Color = Color.Black, Duration = 0.25})
				SetColor({ Id = args.WeaponItemId, Color = Color.Black, Duration = 0.25})
				ModifyTextBox({ Id = args.ShrinePointItemId, Color = Color.Black }) 
				SetAlpha({ Id = args.ShrinePointItemId, Fraction = 0, Duration = 0.25 })
				wait(0.05)
			end
		end
	end
	
	local cameraDuration = 1.0
	local cameraEndOffsetY = 0
	if args.CameraEndOffsetY then
		cameraEndOffsetY = args.CameraEndOffsetY
	end
	if args.CrossroadsStart then
		wait(1.5)
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
		PanCamera({ Id = destinationId, Duration = cameraDuration, EaseIn = 0, EaseOut = 0.5 })
		FocusCamera({ Fraction = 0.90, Duration = cameraDuration, ZoomType = "Ease" })
	else
		cameraDuration = 1.95
		if args.ShrinePointItemId then
			wait(0.35)
			SetScale({ Id = args.TargetItemId, Fraction = 0, Duration = 0.2 })
			SetScale({ Id = args.BountyBackingId, Fraction = 0, Duration = 0.2 })
			SetScale({ Id = args.ShrinePointItemId, Fraction = 0, Duration = 0.2 })
			SetScale({ Id = args.WeaponItemId, Fraction = 0, Duration = 0.2 })
			StopAnimation({ Name = "StaffReloadTimerReady", DestinationId = args.TargetItemId })
		else
			wait(1.05)
		end

		if GameState.BiomeMapRecord[args.BiomeStart] <= 1 then
			wait( args.AdditionalFirstTimeWait )
		end

		PanCamera({ Id = destinationId, OffsetY = cameraEndOffsetY, Duration = cameraDuration, EaseIn = 0, EaseOut = 0.5 })
		FocusCamera({ Fraction = 0.85, Duration = cameraDuration, ZoomType = "Ease" })
		SetAlpha({ Id = endingFogId, Fraction = 0.0, Duration = 1.5 })
		local currentScale = GetThingDataValue({ Id = endingFogId, Property = "Scale" })
		SetScale({ Id = endingFogId, Fraction = currentScale * 1.5, Duration = 1.5 })
		PlaySound({ Name ="/SFX/Menu Sounds/HadesMainMenuWhoosh" })
		SetAlpha({ Id = startingGlowId, Fraction = 0.0, Duration = 0.3 })
		SetAlpha({ Id = endingGlowId, Fraction = 1.0, Duration = 0.3 })
		SetAlpha({ Id = endingSpotlightId, Fraction = 0.55, Duration = 1.0 })
	end
	wait( 1.5 )

	-- move pieces
	SetAnimation({ Name = "MelMarkerMove", DestinationId = melId })
	local moveSound = PlaySound({ Name = "/SFX/Player Sounds/HermesRushSpeedTrailSFX", Id = melId })
	SetVolume({ Id = moveSound, Value = 0.8, Duration = 0.0 })
	Move({ Id = melId, OffsetX = args.HeroMoveOffsetX, OffsetY = args.HeroMoveOffsetY, Duration = args.HeroMoveDuration, EaseIn = args.MoveEaseIn, EaseOut = args.MoveEaseOut, ShiftThingsByOffset = true })
	thread( BiomeMapPresentationFamiliar, source, args, familiarId )
	
	wait( 1.0 )
	
	-- punctuation VFX
	if selectedCircleId ~= nil then
		SetAnimation({ DestinationId = selectedCircleId, Name = "BiomeHilightSummoningCircleAnim" }) -- nopkg
		--SetAlpha({ Id = selectedCircleId, Fraction = 1.0, Duration = 0.3 })
		SetScale({ Id = selectedCircleId, Fraction = selectedCircleEndScale, Duration = 0.3 })
	end
	PlaySound({ Name = "/SFX/Menu Sounds/MenuMagicFlashLong", Id = selectedCircleId })

	wait( 0.1 )

	-- marker land
	SetAnimation({ Name = "MelMarkerIdle", DestinationId = melId })
	CreateAnimation({ Name = "BiomeMapDustRingShadow", DestinationId = melId, GroupName = "Combat_UI", Scale = 0.31, OffsetY = 80, OffsetX = 10 })
	CreateAnimation({ Name = "BiomeMapDustRing", DestinationId = melId, GroupName = "Combat_UI", Scale = 0.62, OffsetY = 80, OffsetX = 10 })
	PlaySound({ Name = "/Leftovers/SFX/PlayerSkid", Id = melId })
	StopSound({ Id = moveSound, Duration = 0.3 })
	
	-- jump any banners
	if not IsEmpty( extraObjectIds ) then
		SetAnimation({ Name = "BannerMarkerJump", DestinationIds = extraObjectIds })
		Move({ Id = extraObjectIds, OffsetX = -200, OffsetY = -100, Duration = 10, EaseIn = 0.1, EaseOut = 2.0, ShiftThingsByOffset = true })
		PlaySound({ Name = "/SFX/CharonOarImpact", Id = melId })
	end

	-- show any bounties on the current region
	if args.ShrineBounty ~= nil and GameState.ActiveShrineBounty ~= nil and ( CurrentRun.ActiveBounty == nil or CurrentHubRoom ~= nil ) then
		local bountyData = BountyData[GameState.ActiveShrineBounty]
		if bountyData ~= nil and bountyData.Encounter == args.ShrineBounty then
			
			BiomeMapShowBounty( source, args, bountyData )		

			wait( 0.65 )
			CreateAnimation({ Name = "ShoutFlare", DestinationId = args.TargetItemId, Group = "Combat_Menu_TraitTray", Scale = 1.5, OffsetY = 120 })
			CreateAnimation({ Name = "TraitUpdate", DestinationId = args.TargetItemId, Group = "Combat_Menu_TraitTray", Scale = 2.0 })
			PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash2" })

			wait( 0.10 )

			SetAlpha({ Id = args.TargetItemId, Fraction = 1.0 })
			SetAlpha({ Id = args.BountyBackingId, Fraction = 1.0 })
			SetAlpha({ Id = args.ShrinePointItemId, Fraction = 1.0 })
			SetAlpha({ Id = args.WeaponItemId, Fraction = 1.0 })

			wait( 0.88 )

			if not IsEmpty( extraObjectIds ) then
				SetAnimation({ Name = "BannerMarkerIdle", DestinationIds = extraObjectIds })
				PlaySound({ Name = "/SFX/CharonOarImpact", Id = melId })
				Stop({ Ids = extraObjectIds })
			end
		end
	end
	if args.CrossroadsStart then
		wait( 2.2 )
	else
		wait( 1.6 )
	end
	if GameState.BiomeMapRecord[args.BiomeStart] <= 1 then
		wait( args.AdditionalFirstTimeWait )
	end
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	FullScreenFadeOutAnimation()
	RemoveInputBlock({ Name = "BiomeMapPresentation" })
end

function BiomeMapShowBounty( source, args, bountyData )

	local screen = ScreenData.Shrine
	local bountyGroupName = "Combat_Menu_TraitTray"

	local shrineBountyOffsets =
	{
		BossHecate01 =
		{
			X = -675, 
			Y = 842,
		},
		BossScylla01 =
		{
			X = 27, 
			Y = 1063,
		},
		BossInfestedCerberus01 =
		{
			X = 640, 
			Y = 1317,
		},
		BossChronos01 =
		{
			X = 40, 
			Y = 1717,
		},

		BossPolyphemus01 =
		{
			X = 625, 
			Y = -340,
		},
		BossEris01 =
		{
			X = 18, 
			Y = -560,
		},
		BossPrometheus01 =
		{
			X = 24, 
			Y = -1335,
		},
	}
	local offset = shrineBountyOffsets[bountyData.Encounter]

	args.TargetItemId = SpawnObstacle({ Name = "BlankObstacle", Group = bountyGroupName, SortById = true,
		LocationX = offset.X + screen.BountyTargetOffsetY, LocationY = offset.Y + screen.BountyTargetOffsetY })
	SetAnimation({ Name = screen.BountyTargetIcons[bountyData.Encounter], DestinationId = args.TargetItemId })
	SetScale({ Id = args.TargetItemId, Fraction = screen.BountyBossIconScale })
	SetAlpha({ Id = args.TargetItemId, Fraction = 0 })

	args.BountyBackingId = SpawnObstacle({ Name = "BlankObstacle", Group = bountyGroupName, SortById = true,
		LocationX = offset.X, LocationY = offset.Y })
	SetAnimation({ Name = "GUI\\Screens\\Shrine\\Testament", DestinationId = args.BountyBackingId })
	SetScale({ Id = args.BountyBackingId, Fraction = screen.BountyBossIconScale })
	SetAlpha({ Id = args.BountyBackingId, Fraction = 0 })

	local shrinePoints = 0
	local weaponName = nil
	if bountyData.CompleteGameStateRequirements ~= nil then
		for j, completeRequirement in ipairs( bountyData.CompleteGameStateRequirements ) do
			if completeRequirement.HasAny ~= nil then
				weaponName = completeRequirement.HasAny[1]
			end
			if completeRequirement.Value ~= nil then
				shrinePoints = completeRequirement.Value
			end
		end
	end

	args.ShrinePointItemId = SpawnObstacle({ Name = "BlankObstacle", Group = bountyGroupName, SortById = true,
		LocationX = offset.X + screen.BountyShrinePointsOffsetX, LocationY = offset.Y + screen.BountyShrinePointsOffsetY })
	local bountyShrinePointsFormat = ShallowCopyTable( screen.BountyShrinePointsFormat )
	bountyShrinePointsFormat.Id = args.ShrinePointItemId
	bountyShrinePointsFormat.Text = "ShrineScreen_BountyShrinePoints"
	bountyShrinePointsFormat.LuaKey = "TempTextData"
	bountyShrinePointsFormat.LuaValue = { RequiredShrinePoints = shrinePoints }
	bountyShrinePointsFormat.DataProperties =
	{
		OpacityWithOwner = true,
	}
	CreateTextBox( bountyShrinePointsFormat )
	SetAlpha({ Id = args.ShrinePointItemId, Fraction = 0 })

	args.WeaponItemId = SpawnObstacle({ Name = "BlankObstacle", Group = bountyGroupName, SortById = true,
		LocationX = offset.X + screen.BountyWeaponOffsetX, LocationY = offset.Y + screen.BountyWeaponOffsetY })
	SetAnimation({ Name = screen.BountyWeaponIcons[weaponName], DestinationId = args.WeaponItemId })
	SetScale({ Id = args.WeaponItemId, Fraction = screen.BountyWeaponIconScale })
	SetAlpha({ Id = args.WeaponItemId, Fraction = 0 })
end

function ShowBiomeMapLabel( label, biomeMapId )

	local labelBannerId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI", LocationX = label.OffsetX + 3, LocationY = label.OffsetY + 6, SortById = true })
	SetAnimation({ DestinationId = labelBannerId, Name = "GUI\\BiomeMap\\BiomeMap_Banner_01" }) --nopkg
	
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

function BiomeMapPresentationFamiliar( source, args, familiarId )
	if familiarId == nil then
		return
	end
	local randomWait = RandomFloat( 0.44, 0.66 )
	wait( randomWait )
	-- PlaySound({ Name = "/SFX/CharonOarImpact", Id = melId })
	--SetAnimation({ Name = MapState.FamiliarUnit.MarkerMoveAnimation, DestinationId = familiarId })
	Move({ Id = familiarId, OffsetX = args.FamiliarMoveOffsetX, OffsetY = args.FamiliarMoveOffsetY, Duration = args.FamiliarMoveDuration, EaseIn = args.MoveEaseIn, EaseOut = args.MoveEaseOut, ShiftThingsByOffset = true })
	wait( args.FamiliarMoveDuration )
	SetAnimation({ Name = MapState.FamiliarUnit.MarkerJumpAnimation, DestinationId = familiarId })
	CreateAnimation({ Name = "BiomeMapDustRing", DestinationId = familiarId, GroupName = "Combat_UI", Scale = 0.5, OffsetY = 70 })
--	PlaySound({ Name = "/Leftovers/SFX/WyrmJump", Id = familiarId })
end

function BouldyHitPresentation( victim )
	local source = ActiveEnemies[ GetClosestUnitOfType({ Id = victim.ObjectId, DestinationName = "NPC_Hades_Field_01", Distance = 9999 }) ]
	if source ~= nil then
		thread( PlayVoiceLines, source.OnHitVoiceLines, true, source )
	end
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
	FadeOut({ Color = Color.Black, Duration = 0.3 })
	wait( 0.3 )
	BiomeBackToRoom( room, args )
	wait( args.BlackDuration )
	FadeIn({ Duration = 0.3 })
	RemoveInputBlock({ Name = "BiomeOverlookShips" })
end

function BiomeOverlookOlympus( room, args )
	if not MapState.InOverlook and IsEmpty(RequiredKillEnemies) then
		MapState.InOverlook = true

		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")
		AddInputBlock({ Name = "BiomeOverlookOlympus" })

		wait( 0.1, "OverlookThread" )

		local cameraSpeed = args.CameraSpeed or 1260
		local zoomFraction = args.ZoomFraction or 0.9
		local initialDuration = args.InitialDuration or 1.2

		LockCamera({ Id = CurrentRun.Hero.ObjectId, Speed = cameraSpeed, OffsetY = -2000, Retarget = true })

		wait( initialDuration )

		OlympusOverlookFadeOutObjects()

		wait( 0.5 )

		FadeOut({ Color = Color.Black, Duration = 0.1 })

		wait( args.BlackDuration / 2)

		FocusCamera({ Fraction = zoomFraction, Duration = 0, ZoomType = "Ease" })
		LockCamera({ Id = args.OverlookTargetStartId, OffsetY = 1200, Duration = 0, Retarget = true, EaseIn = 0 })
		wait(0.01)

		wait( args.BlackDuration / 2)

		FadeIn({ Duration = 0.1 })

		LockCamera({ Id = args.OverlookTargetStartId, Speed = cameraSpeed * 0.9, Acceleration = 800, Retarget = true })
		wait( 1.0 )
		LockCamera({ Id = args.OverlookTargetStartId, OffsetY = -3000, Speed = cameraSpeed * 0.25, Retarget = true, Acceleration = 5, FromCurrentLocation = true })

		thread( WaitForEndOverlookAdvancedInput, room, args, "BiomeBackToRoomOlympus" )
	end
end

function OlympusOverlookFadeOutObjects()
	local backgroundIds = GetIds({ Names = { "Terrain_Below_03", "Terrain_Below_05", "Clouds_Below_02", "Standing_FX", "Standing" } })
	SetAlpha({ Ids = backgroundIds, Fraction = 0.0, Duration = 0.5 })
end

function OlympusOverlookFadeInObjects()
	local backgroundIds = GetIds({ Names = { "Terrain_Below_03", "Terrain_Below_05", "Clouds_Below_02", "Standing_FX", "Standing"  } })
	SetAlpha({ Ids = backgroundIds, Fraction = 1.0, Duration = 0.0 })
end

function BiomeBackToRoomOlympus( room, args )
	FadeOut({ Color = Color.Black, Duration = 0.3 })
	wait( 0.3 )
	OlympusOverlookFadeInObjects()
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Retarget = true })
	BiomeBackToRoom( room, args )
	wait( args.BlackDuration )
	FadeIn({ Duration = 0.3 })
	RemoveInputBlock({ Name = "BiomeOverlookOlympus" })
end

function ExitToAnomalyPresentation(currentRun, exitDoor)
	AddInputBlock({ Name = "LeaveRoomPresentation" })
	LoadVoiceBanks( { Name = "Intercom" }, nil, true )
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

	PlaySound({ Name = "/SFX/Enemy Sounds/Chronos/ChronosPreDash", Id = CurrentRun.Hero.ObjectId })
	Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 4, Speed = 300, Duration = 3.0 })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteGasping", Delay = 0.2 })

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
	if IsGameStateEligible( exitDoor,firstVisitRequirements ) then
		thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, WaitTime = 3, ColorGrade = "Rain", VoiceLines = GlobalVoiceLines.AnomalyLocatedVoiceLines } )
		wait(0.25)
		CreateAnimation({ Name = "Invincibubble", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = 40, })
		PlaySound({ Name = "/SFX/Enemy Sounds/Chronos/ChronosClockHand", Id = CurrentRun.Hero.ObjectId })

		wait(4.0)

		local chronos = DeepCopyTable( EnemyData.NPC_Chronos_01 )
		local nearbyId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "SpawnPoints" }, Distance = 500 })

		chronos.ObjectId = SpawnUnit({ Name = "NPC_Chronos_01", Group = "Standing", DestinationId = nearbyId })
		SetupUnit( chronos, CurrentRun, { IgnoreAI = true, IgnoreAssert = true, } )
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
		StopSound({ Id = chronosTimeSlowSoundId, Duration = 0.3 })

		wait( 0.5 )
	else
		thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, WaitTime = 2, ColorGrade = "Rain", OverlayAnim = "ChronosOverlay", VoiceLines = GlobalVoiceLines.AnomalyLocatedVoiceLines } )
		wait(0.25)
		CreateAnimation({ Name = "Invincibubble", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = 40, })
		PlaySound({ Name = "/SFX/Enemy Sounds/Chronos/ChronosClockHand", Id = CurrentRun.Hero.ObjectId })
		wait(2.75)
	end

	LeaveRoomAudio( currentRun, exitDoor )
	ModifySubtitles({ SuppressLyrics = false })
	wait(0.29)
	PlaySound({ Name = "/SFX/Enemy Sounds/Chronos/ChronosTeleport", Id = CurrentRun.Hero.ObjectId })
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

	thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, ColorGrade = "Rain", OverlayAnim = "ChronosOverlay", VoiceLines = { GlobalVoiceLines = "AnomalyEnteredVoiceLines" }, StartSound = "/SFX/TimeSlowStart" } )

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

	thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = { GlobalVoiceLines = "AnomalySurvivedVoiceLines" }, StartSound = "/SFX/TimeSlowStart" } )

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

	-- thread( HadesSpeakingPresentation, {}, { StartDelay = 0, SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = { GlobalVoiceLines = "AnomalyConcludedVoiceLines" }, StartSound = "/SFX/TimeSlowStart" } )
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

	CutsceneAddLetterbox()
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

	CutsceneAddLetterbox()
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

	CutsceneAddLetterbox()
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
	local ghostWallAnim = "GhostWallFadeOut" -- for packaging
	
	SetAnimation({ DestinationIds = nearbyGhostWalls, Name = ghostWallAnim })
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

function ShipsEndOilFires()
	ExpireProjectiles({ Names = { "OilPuddleFire", "OilPuddleFire02", "OilPuddleFire03", "OilPuddleFire04" } })
	ExpireProjectiles({ Names = { "OilPuddleFireFlying", "OilPuddleFire02Flying", "OilPuddleFire03Flying", "OilPuddleFire04Flying" } })

	local oilPuddleIds = GetIdsByType({ Names = { "OilPuddle", "OilPuddle02", "OilPuddle03", "OilPuddle04" } })
	for k, id in pairs(oilPuddleIds) do
		DouseFire(id)
	end
end

function DouseFire(id)
	StopAnimation({ DestinationId = id, Names = { "OilPuddle01Burn", "OilPuddle02Burn", "OilPuddle03Burn", "OilPuddle04Burn", "OilPuddleSparks", "OilPuddleIgniteGlowAmbient", "OilPuddleIgniteGlow" } })
	if ActiveEnemies[id] ~= nil then
		ActiveEnemies[id].Lit = false
	end
	SetAnimation({ DestinationId = id, Name = GetThingDataValue({ Id = id, Property = "Graphic" }) })
end

function ShipsSteeringWheelChoicePresentation( wheel )
	local heroId = CurrentRun.Hero.ObjectId
	if IsEmpty(MapState.SurfaceShopItems) then
		PanCamera({ Ids = { heroId, wheel.ObjectId }, Duration = 2.5 })
		--FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 0.85, Duration = 2.5, ZoomType = "Ease" })
		local zoomAmount = CurrentRun.CurrentRoom.ZoomFraction
		local dist = GetDistance({ Id = heroId, DestinationId = wheel.ObjectId })
		if dist ~= nil and dist > 0 then
			if dist > 1000 then
				zoomAmount = zoomAmount * Lerp( 0.6, 1.0, 1000 / dist )
			else
				zoomAmount = zoomAmount * 1.05
			end
		end
		FocusCamera({ Fraction = zoomAmount, Duration = 2.5, ZoomType = "Ease" })
	end
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

	for id, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
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

	CreateAnimation({ DestinationId = wheel.ObjectId, Name = "ShipsSteeringWheelBreak", Group = "FX_Standing" })
	SpawnObstacle({ Name = "ShipsSteeringWheelDestroyed", DestinationId = wheel.ObjectId, Group = "Standing" })
	Destroy({ Id = wheel.ObjectId })

	thread( PlayVoiceLines, HeroVoiceLines.ShipsWheelDestroyedVoiceLines )

	if AudioState.MusicSection == 0 then
		SetMusicSection( 1 )
	end
end

function SpawnOlympusCorpses( encounter, args )

	wait( 0.02 ) -- Wait for GridManager to initialize

	local count = RandomInt(args.CountMin, args.CountMax)
	for i = 1, count do
		local spawnPointId = RemoveRandomValue(args.SpawnOnIds)
		if spawnPointId == nil then
			spawnPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, { PreferredSpawnPoint = "EnemyPointSupport" }, encounter)
		end

		if spawnPointId ~= nil then
			local obstacleName = GetRandomValue(args.ObstacleOptions)
			local newObstacle = DeepCopyTable(ObstacleData[obstacleName])
			newObstacle.ObjectId = SpawnObstacle({ Name = obstacleName, DestinationId = spawnPointId, Group = "Standing" })
			SetupObstacle(newObstacle)

			wait(0.01) -- give the obstacle time to spawn so it can do IsLocationValid 

			if not IsLocationValid({ Id = newObstacle.ObjectId, CheckObstacles = true, CheckUnits = true, UnitCheckPolygon = true }) then
				DebugPrint({ Text=newObstacle.ObjectId })
				Destroy({ Id = newObstacle.ObjectId })
			else
				newObstacle.OccupyingSpawnPointId = spawnPointId
				SessionMapState.SpawnPointsUsed[spawnPointId] = newObstacle.ObjectId
			end
		end
	end
end