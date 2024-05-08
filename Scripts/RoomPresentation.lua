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
	if prevRoomData ~= nil and prevRoomData.NextRoomEntranceFunctionName ~= nil then
		roomEntranceFunctionName = prevRoomData.NextRoomEntranceFunctionName
		roomEntranceFunctionArgs = prevRoomData.NextRoomEntranceFunctionArgs
	end
	roomEntranceFunctionName = roomData.EntranceFunctionName or roomEntranceFunctionName
	roomEntranceFunctionArgs = roomData.EntranceFunctionArgs or roomEntranceFunctionArgs
	for i, priority in ipairs( RoomEventData.EntranceFunctionNamePriorities ) do
		if prevRoomData ~= nil and priority == prevRoomData.NextRoomEntranceFunctionName then
			roomEntranceFunctionName = prevRoomData.NextRoomEntranceFunctionName
			roomEntranceFunctionArgs = prevRoomData.NextRoomEntranceFunctionArgs
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

	if not currentRoom.BlockCameraReattach then
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

	FireWeaponFromUnit({ Weapon = "WeaponBlink", Id = CurrentRun.Hero.ObjectId })
	thread( HeroAlphaDelay, currentRun, 0.30 )
	Destroy({ Id = healTarget })

	wait( 0.3 )

	--[[
	local heroDestination = currentRoom.HeroEndPoint
	Move({ Id = heroId, DestinationId = heroDestination, SuccessDistance = 32 })
	SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "" })
	]]

	thread( RoomOpeningUIDelay )
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
	--SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRoom.EntranceAnimation or RoomData.BaseSecret.EntranceAnimation })
	--AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })

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
	--SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRoom.EntranceAnimation or RoomData.BaseSecret.EntranceAnimation })
	--AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })

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
	if roomData.MusicRequirements == nil or IsGameStateEligible( currentRun, roomData.MusicRequirements ) then
		musicTrackName = currentRoom.Music
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
		local lastEncounterData = nil
		if lastRoom.Encounter ~= nil then
			lastEncounterData = EncounterData[lastRoom.Encounter.Name]
		end
		if secretMusic == nil and ( lastRoomData.NextRoomResumeMusic or (lastEncounterData ~= nil and lastEncounterData.NextRoomResumeMusic) ) then
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
	if roomData.EndMusicOnEnterDuration ~= nil and AudioState.MusicId ~= nil then
		EndMusic( AudioState.MusicId, AudioState.MusicName, roomData.EndMusicOnEnterDuration )
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

end

function LeaveRoomStartPresentation( exitDoor )

	if IsRecordRunDepth( CurrentRun ) then
		thread( PlayVoiceLines, GlobalVoiceLines.RecordRunDepthVoiceLines )
	end

	if CurrentRun.CurrentRoom.ChallengeEncounter ~= nil and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress then
		thread( PlayVoiceLines, HeroVoiceLines.FleeingEncounterVoiceLines, false )
	end

	for id, unit in pairs( ActiveEnemies ) do
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
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRun.CurrentRoom.ExitAnimation or RoomData.BaseSecret.ExitAnimation })
		CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRun.CurrentRoom.ExitVfx or RoomData.BaseSecret.ExitVfx })
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
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRun.CurrentRoom.ExitAnimation or RoomData.BaseSecret.ExitAnimation })
		CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRun.CurrentRoom.ExitVfx or RoomData.BaseSecret.ExitVfx })
		if door ~= nil and door.ExitPortalSound then
			PlaySound({ Name = door.ExitPortalSound or "/SFX/Menu Sounds/ChaosRoomEnterExit" })
		end
	end

	LeaveRoomAudio( currentRun, exitDoor )

	--[[
	wait(0.4)

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end
	]]

	wait(0.1)

	--SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.3 })
	--FullScreenFadeOutAnimation( currentRun.CurrentRoom.FadeOutAnimation )

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
	if exitDoor.SpeakerName ~= nil then
		LoadVoiceBanks({ Name = exitDoor.SpeakerName })
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
	SetConfigOption({ Name = "UseOcclusion", Value = false })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	local wereAnyEnemiesAlive = not IsEmpty( RequiredKillEnemies )

	CleanupEnemies( { Destroy = true, DestroyIgnoreId = killer.ObjectId } )
	ExpireProjectiles({ Silent = true })
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

	currentRun.Hero.SpeechParams.Chipmunk = nil
	SetAudioEffectState({ Name = "Chipmunk", Value = 0 })
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

	if CurrentRun.Cleared then
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

	if ConfigOptionCache.EasyMode and not currentRun.Cleared and not currentRun.BountyCleared and not currentRun.Hero.TraitDictionary.SurfacePenalty then
		thread( EasyModeLevelUpPresentation )
		wait( 3.0 )
	end

	local encounter = CurrentRun.CurrentRoom.Encounter
	if encounter ~= nil then
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
			elseif IsGameStateEligible( CurrentRun, chronosTauntRequirements ) then
				-- Chronos Death Taunt
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
	-- NightmareFlickerPresentation()

	if currentRun.ActiveBounty ~= nil then
		BountyPackageRunEndPresentation()
	end

	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })

	WaitForSpeechFinished()

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
	SetupUnit( moros, CurrentRun, { IgnoreAI = true, } )
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
	-- thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "GameplayTimerEnabled", } )

	thread( PlayVoiceLines, GlobalVoiceLines.ChronosSurpriseReactionVoiceLines, true )
end

function GameplayTimerDisabledPresentation()
	-- thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "GameplayTimerDisabled", } )

	thread( PlayVoiceLines, GlobalVoiceLines.ChronosSurpriseReactionVoiceLines, true )

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
	FadeOut({ Duration = 0.375, Color = Color.Black })
	wait( 0.5 )

	RunInterstitialPresentation( gameOutroData )

	wait( 0.5 )

	-- first production / early access
	EndBiomeRecords()
	RecordRunCleared()
	
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
	table.insert( lineSets, GlobalVoiceLines.SwapUpgradePickedVoiceLines )
	table.insert( lineSets, upgradeData.SwapUpgradePickedVoiceLines )
	table.insert( lineSets, upgradeData.UpgradePickedVoiceLines )
	table.insert( lineSets, HeroVoiceLines.UpgradePickedVoiceLines )
	table.insert( lineSets, GlobalVoiceLines.MiscUpgradePickedVoiceLines )	
	thread( PlayFirstEligibleVoiceLines, lineSets )
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
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 2.5, ZoomType = "Ease" })
end

function CloseTalentScreenPresentation( screen )

	CreateAnimation({ Name = "HitSparkA", DestinationId = buttonId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/StarSelectConfirm" })
	wait( 0.02 )

	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	LoadVoiceBanks({ Name = "Selene" });
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
		SetAnimation({ Name = "NPCHecateExit", DestinationId = source.ObjectId })
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
	if consumableItem.Cost ~= nil and consumableItem.Cost > 0 then
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
	LoadVoiceBanks({ Name = "Hermes" })
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
	
	LoadVoiceBanks({ Name = "Selene" })

	wait( MapState.HarvestPointAvailableDelay )
	MapState.HarvestPointAvailableDelay = (MapState.HarvestPointAvailableDelay or 0) + 0.35

	thread( DirectionHintPresentation, source, { Cooldown = 0, Delay = 0, MoveDuration = 1.5, ArrowAnimationName = "ResourceFinderArrow", } )

	thread( PlayVoiceLines, GlobalVoiceLines.HarvestPointFoundVoiceLines, true )
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

	PlayRandomRemainingTextLines( alternateLootData, alternateLootData.RejectionTextLines )
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

	local textStartX = 1830
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

function AltRunDoorUnlockedFirstPresentation(room, args)

	wait( 1.0 )
	local newRunDoorId = 555784
	local newRunDoorScriptTarget = 585605

	AddInputBlock({ Name = "AltRunDoorUnlockedFirstPresentation" })
	
	HideCombatUI( "AltRunDoorUnlockedFirstPresentation" )
	ClearCameraClamp({ LerpTime = 1.35 })
	thread( PlayVoiceLines, HeroVoiceLines.AltRunDoorUnlockedVoiceLines, true )

	ScreenAnchors.LetterBoxTop = ScreenAnchors.LetterBoxTop or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY - 1220 })
	ScreenAnchors.LetterBoxBottom = ScreenAnchors.LetterBoxBottom or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY + 1220 })
	SetScale({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = 5 })
	SetScaleX({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = ScreenScaleX })
	SetColor({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Color = Color.Black })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = 1.0, Duration = 0 })
	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 270, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 90, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
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

	wait( args.FadeOutWait or 12.0 )

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

