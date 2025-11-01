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

	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or 0.8
	if not roomData.IgnoreClamps then
		local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
		DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })
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
		nextRoomEntranceFunctionArgs = prevRoom.NextRoomEntranceFunctionArgsOverride or nextRoomEntranceFunctionArgs
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
		thread( ReattachCameraOnInput )
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
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })
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
	
	wait( 0.1 )
	
	FadeIn({ Duration = 1.0 })
	FullScreenFadeInAnimation()

	wait( 2.0 )

	local healTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRoom.CameraEndPoint })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic2" })
	CreateAnimation({ Name = "BoonDropFrontFlare", DestinationId = healTarget, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "DeathSequenceFxBack", DestinationId = healTarget, Group = "Combat_UI_World_Add" })
	CreateAnimation({ Name = "DeathSequenceFxFront", DestinationId = healTarget, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	ShakeScreen({ Angle = 90, Distance = 6, Speed = 300, FalloffSpeed = 300, Duration = 0.5 })
	thread( PlayVoiceLines, roomData.EnterVoiceLines or encounterData.EnterVoiceLines, true )

	wait( 0.8 )
	
	SetFixedDashPresentationValues()
	FireWeaponFromUnit({ Weapon = "WeaponBlink", Id = CurrentRun.Hero.ObjectId })
	thread( HeroAlphaDelay, currentRun, 0.30 )
	Destroy({ Id = healTarget })

	wait( 0.3 )
	
	EndFixedDashPresentationValues()

	thread( RoomOpeningUIDelay )
end

function RoomEntranceBountyStart( currentRun, currentRoom, args )

	LoadVoiceBanks({ Name = "Chaos" })
	AdjustColorGrading({ Name = "Team03", Duration = 0.01 })
	AdjustFullscreenBloom({ Name = "GoldBloom", Duration = 0.01 })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = -50, Duration = 0.01, Retarget = true, EaseIn = 0, EaseOut = 0.1 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 0.92, Duration = 0.01 })
	
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.CurrentRoom.HeroEndPoint })
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.CurrentRoom.HeroEndPoint })
	SetAnimation({ Name = "MelinoeCrossCastAnticReverse", DestinationId = CurrentRun.Hero.ObjectId, PlaySpeed = 0.15 })

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

function GetDirectionalWipeAnimation( args )
	if args.TowardsId == nil or args.TowardsId <= 0 then
		return nil
	end
	local wipeAnim = nil
	local entranceAngle = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.TowardsId })
	--DebugPrint({ Text = "entranceAngle = "..entranceAngle })
	if entranceAngle > 0 and entranceAngle < 90 then
		if args.Enter then
			wipeAnim = "RoomTransitionOut_TopRight"	
		else
			wipeAnim = "RoomTransitionIn_TopRight"	
		end
	elseif entranceAngle > 90 and entranceAngle < 180 then
		if args.Enter then
			wipeAnim = "RoomTransitionOut_TopLeft"
		else
			wipeAnim = "RoomTransitionIn_TopLeft"
		end
	elseif entranceAngle > 180 and entranceAngle < 270 then
		if args.Enter then
			wipeAnim = "RoomTransitionOut_BottomLeft"
		else
			wipeAnim = "RoomTransitionIn_BottomLeft"
		end
	else
		if args.Enter then
			wipeAnim = "RoomTransitionOut_BottomRight"
		else
			wipeAnim = "RoomTransitionIn_BottomRight"
		end
	end
	return wipeAnim
end

function RoomEntranceStandard( currentRun, currentRoom )
	local roomData = RoomData[currentRoom.Name] or currentRoom
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0

	if currentRoom.HeroEndPoint ~= nil then
		-- Disable immediately, could be sitting on top of impassibility
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })		
	end
	wait( 0.03 )

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation( currentRoom.EnterWipeAnimationOverride or roomData.EnterWipeAnimation or GetDirectionalWipeAnimation( { TowardsId = currentRoom.HeroEndPoint, Enter = true } ) )

	local roomEntranceAnimation = GetEquippedWeaponValue( "RoomEntranceAnimation" )
	if roomEntranceAnimation ~= nil then
		SetAnimation({ Name = roomEntranceAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end
	
	if roomData.DoorEntranceAnimation ~= nil then
		thread( DoorEntranceAnimation, roomData.DoorEntranceAnimation)
	end

	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision = true, UseDefaultSpeed = not roomData.EntrancePresentationUsePlayerSpeed, Invulnerable = true } )
	end
	local panDuration = roomData.IntroPanDuration or roomIntroSequenceDuration
	if currentRoom.CameraEndPoint ~= nil and panDuration > 0 then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = panDuration, EaseIn = roomData.IntroPanEaseIn, EaseOut = roomData.IntroPanEaseOut })
	end

	if currentRoom.EnterSound ~= nil then
		PlaySound({ Name = currentRoom.EnterSound, Id = currentRoom.HeroStartPoint })
	end
	wait( 0.03 )

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

	local bossId = args.BossId or GetFirstValue(GetIdsByType({ Name = args.BossType }))

	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	wait(0.03)

	FadeIn({ Duration = 0.0 })
	
	FullScreenFadeInAnimation( roomData.EnterWipeAnimation or GetDirectionalWipeAnimation( { TowardsId = currentRoom.HeroEndPoint, Enter = true } ) )

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
			wait(args.EnterWait or 1.8)
		end
	end

	if bossId ~= nil then
		if args.BossIntroSound ~= nil then
			PlaySound({ Name = args.BossIntroSound, Id = bossId })
		end
		if args.BossIntroAnimation ~= nil then
			SetAnimation({ Name = args.BossIntroAnimation, DestinationId = bossId })
		end
		if args.BossIntroAngleTowardPlayer ~= nil then
			AngleTowardTarget({ Id = bossId, DestinationId = CurrentRun.Hero.ObjectId })
		end
		wait( args.BossIntroDelay or 0 )
		if args.BossIntroShake then
			AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.2 })
			AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.2 })
			ShakeScreen({ Speed = 500, Distance = 5, FalloffSpeed = 2000, Duration = args.BossIntroShakeDuration or 1.0 })
			thread( EndTinyVerminRadialBlur, { Delay = args.BossIntroShakeDuration or 1.0 } )
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
	FullScreenFadeInAnimation( "RoomTransitionOut_Down" )
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })

	wait(0.3)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	if currentRoom.LocationText and not currentRoom.Encounter.BlockLocationText then
		thread( DisplayInfoBanner, nil, { Text = currentRoom.LocationText, Delay = 0.65, FadeColor = currentRoom.LocationTextColor or { 255, 0, 0, 255 }, Duration = 2.0, AnimationName = currentRoom.LocationAnimName, AnimationOutName = currentRoom.LocationAnimOutName, IconBackingAnimationName = currentRoom.LocationTextAnimName, IconBackingAnimationOutName = currentRoom.LocationTextAnimOutName, } )
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
	local roomData = RoomData[currentRoom.Name] or currentRoom

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
	FullScreenFadeInAnimation( "RoomTransitionOut_Down" )
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })

	wait(0.3)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	if currentRoom.LocationText and not currentRoom.Encounter.BlockLocationText then
		thread( DisplayInfoBanner, nil, { Text = currentRoom.LocationText, Delay = 0.65, FadeColor = currentRoom.LocationTextColor or { 255, 0, 0, 255 }, Duration = 2.0, AnimationName = currentRoom.LocationAnimName, AnimationOutName = currentRoom.LocationAnimOutName, IconBackingAnimationName = currentRoom.LocationTextAnimName, IconBackingAnimationOutName = currentRoom.LocationTextAnimOutName, } )
	end
	wait( 0.33 )
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

function FullScreenFadeInAnimation( animationName, colorGradeName )
	if ScreenAnchors.Transition ~= nil then
		Destroy({ Id = ScreenAnchors.Transition })
	end
	AdjustColorGrading({ Name = colorGradeName or "Rain", Duration = 0 })
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

end

function FullScreenFadeOutAnimation( animationName, colorGradeName )
	if ScreenAnchors.Transition ~= nil then
		Destroy({ Id = ScreenAnchors.Transition })
	end
	AdjustColorGrading({ Name = colorGradeName or "Rain", Duration = 1.0 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
	animationName = animationName or "RoomTransitionIn"
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = animationName })
	local uniformAspectScale = ScreenScaleX
	if ScreenScaleY > ScreenScaleX then 
		uniformAspectScale = ScreenScaleY
	end
	if not ScreenState.NativeAspetRatio then
		uniformAspectScale = uniformAspectScale + 0.1 -- Scaling isn't pixel-perfect, add some buffer
	end
	SetScale({ Id = ScreenAnchors.Transition, Fraction = uniformAspectScale })
	local notifyName = "FullScreenFadeOutAnimation"
	NotifyOnAnimationTimeRemaining({ Id = ScreenAnchors.Transition, Animation = animationName, Remaining = 0.02, Notify = notifyName, Timeout = 1.0 })
	waitUntil( notifyName )
	wait( 0.05 ) -- Buffer a couple frames after animation finishes
end

function FullScreenFadeInAnimationReroll( args )
	if ScreenAnchors.Transition ~= nil then
		Destroy({ Id = ScreenAnchors.Transition })
	end
	args = args or {}
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = "RerollTransitionOut" })
	local uniformAspectScale = ScreenScaleX
	if ScreenScaleY > ScreenScaleX then 
		uniformAspectScale = ScreenScaleY
	end
	if not ScreenState.NativeAspetRatio then
		uniformAspectScale = uniformAspectScale + 0.1 -- Scaling isn't pixel-perfect, add some buffer
	end
	SetScale({ Id = ScreenAnchors.Transition, Fraction = uniformAspectScale })
	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelInURSA" })
end

function FullScreenFadeOutAnimationReroll( args )
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	args = args or {}
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray" })
	local uniformAspectScale = ScreenScaleX
	if ScreenScaleY > ScreenScaleX then 
		uniformAspectScale = ScreenScaleY
	end
	if not ScreenState.NativeAspetRatio then
		uniformAspectScale = uniformAspectScale + 0.1 -- Scaling isn't pixel-perfect, add some buffer
	end
	SetScale({ Id = ScreenAnchors.Transition, Fraction = uniformAspectScale })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = "RerollTransitionIn" })
	wait( 0.3 )
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
	if GameState.ReachedTrueEnding and roomData.TrueEndingSecretMusic then
		secretMusic = roomData.TrueEndingSecretMusic
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
		local section = roomData.SecretMusicSection
		if roomData.SecretMusicSectionRandomizer ~= nil then
			if roomData.SecretMusicSectionRandomizer.GameStateRequirements == nil or IsGameStateEligible( roomData, roomData.SecretMusicSectionRandomizer.GameStateRequirements ) then
				section = GetRandomValue( roomData.SecretMusicSectionRandomizer.Sections )
			end
		end
		SecretMusicPlayer( secretMusic, { Section = section } )
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

function ReattachCameraOnInput( )
	local notifyName = "ReattachCameraOnInput"
	NotifyOnPlayerInput({ Notify = notifyName })
	waitUntil( notifyName )

	if CurrentRun.CurrentRoom.CancelReattachCameraOnInput then
		return
	end
	
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.0 })
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
		SetPlayerInvulnerable( "MoveHeroToRoomPosition" )
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
		SetPlayerVulnerable( "MoveHeroToRoomPosition" )
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

	if CurrentRun.RunDepthCache >= GameState.HighestRunDepthCache then
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
	local nextRoomData = nil
	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom

	AddInputBlock({ Name = "LeaveRoomPresentation" })

	SetThreadWait( "InfoBanner", 0.01 )
	
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "LeaveRoomPresentation" )

	if door ~= nil then
		nextRoomData = RoomData[door.Room.Name] or door.Room
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

	wait( 0.4 )

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	wait( 0.02 )

	if HasEventFunctionName( roomData.LeavePostPresentationEvents, "BiomeMapPresentation" ) then
		FullScreenFadeOutAnimation()
	else
		FullScreenFadeOutAnimation( nextRoomData.LeavePrevRoomWipeAnimation or currentRun.CurrentRoom.LeaveWipeAnimation or GetDirectionalWipeAnimation( { TowardsId = heroExitPointId, Enter = false } ) )
	end

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

	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = exitDoorId, DestinationIds = heroExitIds, Distance = 800 })
	if heroExitPointId > 0 then
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		local args = {}
		args.SuccessDistance = 30
		local exitPath = exitDoor.ExitPath or currentRun.CurrentRoom.ExitPath or {}
		if door ~= nil and door.ExitThroughCenter then
			table.insert( exitPath, door.ObjectId )
		end
		if door ~= nil and door.ExitThroughHeroEnd then
			table.insert( exitPath, GetClosest({ Id = door.ObjectId, DestinationIds = GetIdsByType({ Name = "HeroEnd" }) }) )
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

	FullScreenFadeOutAnimation( roomData.EnterWipeAnimation or GetDirectionalWipeAnimation( { TowardsId = heroExitPointId, Enter = false } ) )

	wait( 0.26 )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end


function LockExtraExitsPresentation( door )

	CreateAnimation({ DestinationId = door.ObjectId, Name = "OceanusManholeLockIdleIn", Group = "FX_Terrain_Top" })
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
			local entranceDirection = nil
			local entranceAngle = GetAngleBetween({ Id = startId, DestinationId = endId })
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
				table.insert( eligibleStartPairs,
					{
						HeroStartPoint = startId,
						HeroEndPoint = endId,
					})
			end
		end

		if not IsEmpty( eligibleStartPairs ) then
			local chosenPair = GetRandomValue(eligibleStartPairs)
			currentRoom.HeroStartPoint = chosenPair.HeroStartPoint
			currentRoom.HeroEndPoint = chosenPair.HeroEndPoint
		end

		currentRoom.HeroStartPoint = currentRoom.HeroStartPoint or GetFirstValue( heroStartIds )
		if currentRoom.HeroStartPointEndPointLinkIds ~= nil and currentRoom.HeroStartPointEndPointLinkIds[currentRoom.HeroStartPoint] ~= nil then
			currentRoom.HeroEndPoint = currentRoom.HeroStartPointEndPointLinkIds[currentRoom.HeroStartPoint]
		else
			currentRoom.HeroEndPoint = currentRoom.HeroEndPoint or GetFirstValue( heroEndIds )
		end
	end

	if roomData.DebugHeroStartPoint ~= nil then
		currentRoom.HeroStartPoint = roomData.DebugHeroStartPoint
		currentRoom.HeroEndPoint = GetClosest({ Id = currentRoom.HeroStartPoint, DestinationIds = GetIdsByType({ Name = "HeroEnd" }) })
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
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = args.SpecialText, PreDelay = args.Delay, Duration = 0.9, LuaKey = "TooltipData", ShadowScale = 0.7, LuaValue = { TooltipHealth = maxHealthGained }})
end

Using "ChronosOverlay"
Using "ChaosOverlay"
function DeathPresentation( currentRun, killer, args )

	AddInputBlock({ Name = "DeathPresentation" })
	ClearCameraClamp({ LerpTime = 0.4 })
	ZeroMouseTether("DeathPresentation")
	LockCameraMotion("DeathPresentation")
	ToggleCombatControl( CombatControlsDefaults, false, "DeathPresentation")
	HideCombatUI( "Death", { FadeDuration = 0.0 } )
	 -- Would be better to move the layers of the death sequence up but avoiding changing the many fragile layers it has
	RemoveRoomRewardPreviews()
	RemoveScreenEdgeIndicators()
	RemoveInspectPoints()
	PartnersChattingStop()
	RemoveSimSpeedChange( "NemesisFreeShot", { LerpTime = 0.0 } )
	SetConfigOption({ Name = "UseOcclusion", Value = false })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	local prevEnemies = ShallowCopyTable( RequiredKillEnemies )

	StopAnimation({ Id = killer.ObjectId, Names = { "HealthBarArmorShatter", "ArmorBreak" } })
	CleanupEnemies( { Destroy = true, DestroyIgnoreId = killer.ObjectId } )
	ExpireProjectiles({ Silent = true, BlockSpawns = true, IncludeToAdd = true })
	ClearEffect({ Id = killer.ObjectId, All = true, BlockAll = true })
	EffectPostClearAll( killer )
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	SetThreadWait("DropStoredAmmoHero", 0)
	CastEmbeddedPresentationEnd( )
	if MapState.ManaChargeIndicatorIds then
		Destroy({ Ids = { MapState.ManaChargeIndicatorIds.BackingId, } })
	end
	for k, encounter in ipairs( currentRun.CurrentRoom.ActiveEncounters ) do
		if encounter.UseGroupHealthBar then
			notifyExistingWaiters(encounter.Name.."GroupHealthBarDead")
		end
	end
	if SessionMapState.ChronosTimeSlowActive then
		thread( CallFunctionName, "ChronosEndTimeSlowPresentation" )
	end
	StopAmbientSound({ All = true })
	StopSound({ Id = AudioState.SecretMusicId, Duration = 0.25 })
	StopSound({ Id = AudioState.AmbientMusicId, Duration = 0.25 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil
	AudioState.AmbientMusicId = nil
	if AudioState.RainSoundId ~= nil then
		StopSound({ Id = AudioState.RainSoundId, Duration = 0.2 })
		AudioState.RainSoundId = nil
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
		SkipEncounterEndPresentation()
	end

	SetAudioEffectState({ Name = "SpellCharge", Value = 0 })
	SetAudioEffectState({ Name = "GlobalEcho", Value = 0 })

	if not CurrentRun.Cleared then
		ShakeScreen({ Speed = 300, Distance = 3, Duration = 0.27, FalloffSpeed = 1000 })
		FocusCamera({ Fraction = 1.0, Duration = 0.27, ZoomType = "Ease" })
		SetThingProperty({ Property = "Graphic", Value = "MelinoeGetHitActionPose", DestinationId = CurrentRun.Hero.ObjectId })
	end

	Stop({ Id = currentRun.Hero.ObjectId })
	Halt({ Id = currentRun.Hero.ObjectId })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationNames = { "GroundEnemies", "FlyingEnemies" } })

	if killer.DamagedFxStyles ~= nil then
		for _, animName in pairs(killer.DamagedFxStyles) do
			StopAnimation({ DestinationId = killer.ObjectId, Name = animName, PreventChain = true, IncludeCreatedAnimations = true })
		end
	end
	if killer.StopAnimationsOnHeroKill ~= nil then
		StopAnimation({ DestinationId = killer.ObjectId, Names = killer.StopAnimationsOnHeroKill, PreventChain = true, IncludeCreatedAnimations = true })
	end
	RemoveFromGroup({ Id = killer.ObjectId, Names = { "Standing", "GroundEnemies", "FlyingEnemies" } })
	AddToGroup({ Id = killer.ObjectId, Name = "Combat_UI", DrawGroup = true })

	if currentRun.Hero.AttachedAnimationName ~= nil then
		StopAnimation({ Name = currentRun.Hero.AttachedAnimationName, DestinationId = currentRun.Hero.ObjectId })
	end

	if MapState.BossShieldTriggers <= 0 and MapState.BossShieldFx then
		StopAnimation({ Name = MapState.BossShieldFx, DestinationId = CurrentRun.Hero.ObjectId, IncludeCreatedAnimations = true })
	end
	currentRun.Hero.Mute = false
	UnmuteSpeakerPermanent( currentRun.Hero )
	currentRun.Hero.CurrentlyPoisoned = nil
	SetPlayerInvulnerable( "PlayerDeath" )

	if not CurrentRun.Cleared then
		thread( PlayVoiceLines, GlobalVoiceLines.DeathVoiceLines )
	end

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

	-- @hack Fix for non-existent group that some vfx got put in accidentally
	CreateGroup({ Name = "Dark_FX", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "Dark_FX", DestinationName = "Standing_Back" })

	RemoveFromGroup({ Id = currentRun.Hero.ObjectId, Name = "Standing" })
	AddToGroup({ Id = currentRun.Hero.ObjectId, Name = "Combat_Menu", DrawGroup = true })
	thread( DoRumble, currentRun.Hero.HeroFinalHitRumbleParameters )

	if not CurrentRun.Cleared then
		Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.02, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, Duration = 1.51, ExpireAfterCycle = true })
		ShakeScreen({ Speed = 0, Distance = 0, Duration = 10.0 })
	end
	
	wait( 0.02 )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationId = killer.ObjectId })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathStartFwoosh" })

	if not CurrentRun.Cleared then
		PlaySound({ Name = "/SFX/Player Sounds/PlayerDeath" })

		wait( 1.11 )
		
		SetAlpha({ Id = killer.ObjectId, Fraction = 0, Duration = 0.2 })
		
		wait( 0.21 )
		PlaySound({ Name = "/SFX/Player Sounds/MelCastCircleEnd" })
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })
	end

	if CurrentRun.BountyCleared then
		PlaySound({ Name = "/Music/ChaosVictoryStinger" })
	elseif CurrentRun.Cleared then
		if GameState.ReachedTrueEnding then
			if CurrentRun.CurrentRoom.RoomSetName == "I" then
				PlaySound({ Name = "/Music/IrisHadesDeathStingerOrch_MC" })
			elseif CurrentRun.CurrentRoom.RoomSetName == "Q" and not CurrentRun.TextLinesRecord.ZeusPalaceAboutTyphonDeath01 then
				PlaySound({ Name = "/Music/IrisDeathStingerOrch_MC" })
			end
		-- if Cleared & not ReachedTrueEnding, no stingers
		end
	else
		PlaySound({ Name = currentRun.CurrentRoom.Encounter.DeathStinger or "/Music/IrisDeathStinger" })
	end

	local sceneOffsetY = -95
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 0.2, OffsetY = sceneOffsetY, Retarget = true, EaseIn = 0.0, EaseOut = 1.0 })
	FocusCamera({ Fraction = 1.47, Duration = 0.2, ZoomType = "Ease" })

	local melDeathFlash = "Blank"
	if not CurrentRun.Cleared then
		melDeathFlash = CreateScreenComponent({ Name = "BlankObstacle", Group = "Overlay", X = ScreenCenterX, Y = ScreenCenterY, Animation = "MelDeathFlash", ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	end

	SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 315, CompleteAngle = true })

	if not CurrentRun.Cleared then
		for i = 1, 16 do
			CreateAnimation({ Name = "MelDeathLine", DestinationId = ScreenAnchors.DeathBackground, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
		end
	end

	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = CurrentRun.Hero.ObjectId })

	local deathAnimation = "MelinoeDeathEscape"
	if CurrentRun.Cleared and GameState.ReachedTrueEnding then
		deathAnimation = "MelinoeDeathSuccess"
	end
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationNames = { "HeroTeam" } })
	SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 315, CompleteAngle = true })
	SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = deathAnimation })

	if CurrentRun.ActiveBounty ~= nil then
		LoadVoiceBanks("Chaos", nil, true)
		if CurrentRun.BountyCleared then
			local subtitleText = nil
			local subtitleTimeData = nil
			if GameState.PackagedBountyClears[CurrentRun.ActiveBounty] > 1 and GameState.PackagedBountyClearRecordTime[CurrentRun.ActiveBounty] == CurrentRun.GameplayTime then
				subtitleText = "PackagedBountyComplete_Subtitle"
				subtitleTimeData = { LuaKey = "TempTextData", LuaValue = { ClearTime = GetTimerString( CurrentRun.GameplayTime, 2 ) } }
			end
			thread( DisplayInfoBanner, nil, {
				Text = "PackagedBountyEndedMessage", 
				Delay = 0.75,
				TextColor = Color.White,
				FontScale = 0.85,
				AnimationName = "LocationBackingIrisChaosIn",
				AnimationOutName = "LocationBackingIrisChaosOut",
				Duration = 4.25,
				TextOffsetY = 25,
				SubTextColor = Color.ChaosVoice,
				SubtitleTextRevealSound = "/SFX/Menu Sounds/BiomeMapRewardIcon",
				SubtitleOffsetY = -10,
				SubtitleText = subtitleText,
				SubtitleData = subtitleTimeData,
			} )
		else
			-- Bounty failed
			thread( DisplayInfoBanner, nil, {
				Text = "BountyFailedMessage",
				Delay = 0.75,
				TextColor = {161, 45, 117, 255},
				FontScale = 0.85,
				AnimationName = "LocationBackingIrisChaosIn",
				AnimationOutName = "LocationBackingIrisChaosOut",
				Duration = 4.25,
				Layer = "Overlay",
				TextOffsetY = 25,
			} )
		end
	elseif CurrentRun.Cleared then
		if GameState.ReachedTrueEnding then
			thread( DisplayInfoBanner, nil, { Text = "OutroDeathMessageTrueEnding", Delay = 0.75, TextColor = Color.Turquoise, FontScale = 0.85, AnimationName = "LocationBackingIrisGenericIn", AnimationOutName = "LocationBackingIrisGenericOut", ThreadName = "Outro", Duration = 4.25, TextOffsetY = 50 } )
		else
			thread( DisplayInfoBanner, nil, { Text = "OutroDeathMessageAlt", Delay = 0.75, TextColor = Color.Turquoise, FontScale = 0.85, AnimationName = "LocationBackingIrisGenericIn", AnimationOutName = "LocationBackingIrisGenericOut", ThreadName = "Outro", Duration = 4.25, TextOffsetY = 50 } )
		end
	else
		thread( DisplayInfoBanner, nil, { Text = "DeathMessage", Delay = 0.75, TextColor = Color.Turquoise, FontScale = 0.85, AnimationName = "LocationBackingIrisGenericIn", AnimationOutName = "LocationBackingIrisGenericOut", Duration = 4.25, TextOffsetY = 50 } )
	end

	local timeToEscape = 1.00
	local deathBGPreRunTime = 0.23

	wait( deathBGPreRunTime )
	
	SetAnimation({ Name = "DeathSequenceMelBG", DestinationId = ScreenAnchors.DeathBackground })

	wait( timeToEscape )

	thread( PlayVoiceLines, GlobalVoiceLines.DeathReturnVoiceLines )

	if deathAnimation == "MelinoeDeathEscape" then
		SetAnimation({ Name = "MelinoeDeathEscape2", DestinationId = currentRun.Hero.ObjectId })
	end
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

	if ShouldIncrementEasyMode() and (CurrentRun.EasyModeIncremented or not GameState.EasyModeHadMaxPresentation) then
		thread( EasyModeLevelUpPresentation )
		wait( 3.0 )
	end

	local deathTauntTime = 3.6
	local encounter = CurrentRun.CurrentRoom.Encounter
	if CurrentRun.CurrentRoom.KilledByChaosCurse or CurrentRun.ActiveBounty then
		-- Chaos Death Taunt
		LoadPackages({ Names = "Chaos", IgnoreAssert = true })
		thread( HadesSpeakingPresentation, { SubtitleColor = LootData.TrialUpgrade.SubtitleColor }, { OverlayAnim = "ChaosOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = LootData.TrialUpgrade.DeathTauntVoiceLines, OverlayDeathFx = true } ) -- nopkg
		wait( deathTauntTime )
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
				thread( HadesSpeakingPresentation, { SubtitleColor = spurnedGodData.SubtitleColor }, { OverlayAnim = spurnedGodData.OverlayAnim, BlockScreenshake = true, PortraitDuration = 2, VoiceLines = spurnedGodData.DeathTauntVoiceLines, OverlayDeathFx = true } )
				wait( deathTauntTime )
			elseif CurrentRun.CurrentRoom.Encounter.TookChaosCurseDamage ~= nil or CurrentRun.ActiveBounty then
				-- Chaos Death Taunt
				LoadPackages({ Names = "Chaos", IgnoreAssert = true })
				thread( HadesSpeakingPresentation, { SubtitleColor = LootData.TrialUpgrade.SubtitleColor }, { OverlayAnim = "ChaosOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = LootData.TrialUpgrade.DeathTauntVoiceLines, OverlayDeathFx = true } ) -- nopkg
				wait( deathTauntTime )
			elseif CurrentRun.CurrentRoom.Encounter.ArtemisId ~= nil and not CurrentRun.CurrentRoom.Encounter.Completed then
				-- Artemis Death Taunt
				thread( HadesSpeakingPresentation, ActiveEnemies[CurrentRun.CurrentRoom.Encounter.ArtemisId] or { SubtitleColor = Color.ArtemisVoice }, { OverlayAnim = "ArtemisOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = GlobalVoiceLines.ArtemisDeathReactionVoiceLines, OverlayDeathFx = true } )
				wait( deathTauntTime )
			elseif CurrentRun.CurrentRoom.Encounter.HeraclesId ~= nil and not CurrentRun.CurrentRoom.Encounter.Completed then
				-- Heracles Death Taunt
				thread( HadesSpeakingPresentation, ActiveEnemies[CurrentRun.CurrentRoom.Encounter.HeraclesId] or { SubtitleColor = Color.HeraclesVoice }, { OverlayAnim = "HeraclesOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = GlobalVoiceLines.HeraclesDeathReactionVoiceLines, OverlayDeathFx = true } )
				wait( deathTauntTime )
			elseif CurrentRun.CurrentRoom.Encounter.IcarusId ~= nil and not CurrentRun.CurrentRoom.Encounter.Completed then
				-- Icarus Death Taunt
				thread( HadesSpeakingPresentation, ActiveEnemies[CurrentRun.CurrentRoom.Encounter.IcarusId] or { SubtitleColor = Color.IcarusVoice }, { OverlayAnim = "IcarusOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = GlobalVoiceLines.IcarusDeathReactionVoiceLines, OverlayDeathFx = true } )
				wait( deathTauntTime )
			elseif CurrentRun.CurrentRoom.Encounter.NemesisId ~= nil then
				-- Nemesis Death Taunt
				thread( HadesSpeakingPresentation, ActiveEnemies[CurrentRun.CurrentRoom.Encounter.NemesisId] or { SubtitleColor = Color.NemesisVoice }, { OverlayAnim = "NemesisOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = GlobalVoiceLines.NemesisDeathReactionVoiceLines, OverlayDeathFx = true } )
				wait( deathTauntTime )
			elseif IsGameStateEligible( encounter, chronosTauntRequirements ) then
				-- Chronos Death Taunt
				LoadVoiceBanks( { Name = "Intercom" }, nil, true )
				LoadPackages({ Names = "Chronos", IgnoreAssert = true })
				WaitForSpeechFinished()
				thread( HadesSpeakingPresentation, { SubtitleColor = Color.ChronosVoice }, { OverlayAnim = "ChronosOverlay", BlockScreenshake = true, PortraitDuration = 2, VoiceLines = GlobalVoiceLines.ChronosDeathTauntVoiceLines } )
				GameState.NightmaresOccurred = (GameState.NightmaresOccurred or 0) + 1
				CurrentRun.NightmareOccurred = true
				wait( deathTauntTime )
			end
		end
	end

	wait( 2.5 )
	
	DoomAppearancePresentation( prevEnemies )

	wait( 1.25 )
	
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.2 })

	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })

	WaitForSpeechFinished()

	-- un-chipmunkify Mel only after all speech has finished
	currentRun.Hero.SpeechParams.Chipmunk = nil
	SetAudioEffectState({ Name = "Chipmunk", Value = 0 })

	UnlockCameraMotion("DeathPresentation")
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

	--waitUnmodified( 0.5 )
	waitUnmodified( 0.2 )
	SetAlpha({ Id = objectId, Fraction = 0.0, Duration = 0.25 })

	waitUnmodified( 1.5 )
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow", Id = objectId })
	waitUnmodified( 0.25 )
	
end

function DoomAppearancePresentation( prevEnemies )

	local moros = DeepCopyTable( EnemyData.NPC_Moros_01 )
	local textLines = GetRandomEligibleTextLines( moros, moros.DeathPresentationTextLineSets, {} )
	if textLines == nil then
		return
	end

	HideGameplayTimers()

	if prevEnemies ~= nil then
		for enemyId, enemy in pairs( prevEnemies ) do
			-- Some units may not have been deleted since they had their mElapsedTimeMultiplier set to 0 and are no longer updating so they can't finish their physics
			Halt({ Id = enemyId })
		end
	end

	local currentRun = CurrentRun
	SetAudioEffectState({ Name = "Reverb", Value = 2.0 })
	moros.ObjectId = SpawnUnit({ Name = "NPC_Moros_01", Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -300, OffsetX = 150 })
	LoadPackages({ IgnoreAssert = true, Names = { "Fates" } })
	SetAlpha({ Id = moros.ObjectId, Fraction = 0, Duration = 0 })
	SetupUnit( moros, CurrentRun, { IgnoreAI = true, IgnoreAssert = true } )
	--SetGoalAngle({ Id = moros.ObjectId, Angle = 250 })

	wait( 3 )

	--PanCamera({ Ids = moros.ObjectId, Duration = 0 })
	--SetScale({ Id = moros.ObjectId, Fraction = 0.7 })
	--RemoveFromGroup({ Id = moros.ObjectId, Name = "Standing" })

	--CreateAnimation({ Name = "TeleportDisappear", DestinationId = moros.ObjectId })
	--SetAlpha({ Id = moros.ObjectId, Fraction = 1, Duration = 0.1 })

	AltAspectRatioFramesShow()
	SecretMusicPlayer( "/Music/ChaosTheme_MC" )
	DoomContextArtPresentation()

	PlayVoiceLines( moros.EntranceVoiceLines, nil, moros )

	AddToGroup({ Ids = { currentRun.Hero.ObjectId, moros.ObjectId }, Name = "Combat_UI_World_Backing", DrawGroup = true })

	RemoveInputBlock({ Name = "DeathPresentation" })
	PlayTextLines( moros, textLines, { ScreenArgs = { SkipQuestStatusCheck = true } } )
	AddInputBlock({ Name = "DeathPresentation" })

	RemoveFromGroup({ Ids = { currentRun.Hero.ObjectId, moros.ObjectId }, Name = "Combat_UI_World_Backing" })

	FadeOut({ Duration = 2.0, Color = Color.Black })

	wait( 0.5, RoomThreadName )

	StopSound({ Id = AudioState.SecretMusicId, Duration = 1.5 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

	PanCamera({ Ids = moros.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.03 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

end

function DoomContextArtPresentation()
	SessionMapState.DoomContextArtIds = {}
	for i, animName in ipairs( DoomContextArtLayers ) do
		local layer = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY, Animation = animName, Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.5 })
		table.insert( SessionMapState.DoomContextArtIds, layer.Id )
	end
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })
end

function FatesEntranceSFX()

	PlaySound({ Name = "/Music/ARStinger_Stabs_4", Delay = 0.2 })

end

function HideDoomContextArtPresentation()
	SetAlpha({ Ids = SessionMapState.DoomContextArtIds, Duration = 0.5 })
	wait( 0.5 )
	Destroy({ Ids = SessionMapState.DoomContextArtIds })
	SessionMapState.DoomContextArtIds = nil
end

function SetupArachneTheme()
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0, Duration = 0.0 })
end

function EasyModeLevelUpPresentation()

	wait( 3.9, RoomThreadName )

	local luaValue = nil
	local LuaValueUpdate = nil
	local updateDelay = nil

	local titleText = "EasyModeUpgradedTitle"

	if CurrentRun.EasyModeIncremented then
		local prevResistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel - 1 ) ) * 100 )
		local resistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
		luaValue = { Resistance = prevResistance }
		LuaValueUpdate = { Resistance = "{#HighlightFormatGraft}" .. resistance}
		updateDelay = 1.25
	else
		local resistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
		luaValue = { Resistance = resistance }
		titleText = "EasyModeUpgradedTitle_Max"
		GameState.EasyModeHadMaxPresentation = true
	end
	
	DisplayInfoBanner( nil, {
		TitleText = titleText,
		SubtitleText = "EasyModeLevelUp",
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal2",
		Color = {255, 255, 255, 255},
		TextColor = Color.White,
		SubTextColor = { 94, 180, 240, 255 },
		Icon = "EasyModeIcon",
		IconOffsetY = 15,
		TextOffsetY = 5,
		SubtitleOffsetY = 80,
		Duration = 4.35,
		IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		AdditionalAnimation = "GodHoodRays",
		AnimationName = "LocationBackingGodhoodIn",
		AnimationOutName = "LocationBackingGodhoodOut",
		IconBackingAnimationName = "LocationBackingIrisSmallSubtitleIn",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = luaValue, LuaValueUpdate = LuaValueUpdate, UpdateDelay = updateDelay, FontSize = 22, },
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

	for _, enemy in pairs( MapState.SpellSummons ) do
		if not enemy.IsDead and ActiveEnemies[ enemy.ObjectId ] then
			thread( Kill, enemy, { SuppressSounds = true, SkipDeathWeapons = true })
		end
	end

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

	RunInterstitialPresentation( gameOutroData, { Animations =
		{
			{
				AnimationName = "RemBGOutroStart",
			},
		} }
	)

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

function StackUpgradePickupPresentation( source, args, textLines )
	wait(0.37)
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
	if not upgradeData.FromTrade and not upgradeData.IgnoreForFieldsRewardClaimedVO then
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
	SetAlpha({ Id = beamTarget, Fraction = 0, Duration = 0})
	SetAlpha({ Id = beamTarget, Fraction = 1, Duration = 0.2})
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

	PlaySound({ Name = "/SFX/Menu Sounds/MoonMenuOpen" })

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

function TalentScreenCloseFinishedPresentation( screen )

	CreateAnimation({ Name = "HitSparkA", DestinationId = buttonId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/StarSelectConfirm" })
	wait( 0.02 )

	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	local globalVoiceLines = GlobalVoiceLines[roomData.CloseTalentScreenGlobalVoiceLines] or GlobalVoiceLines.TalentDropUsedVoiceLines
	thread( PlayVoiceLines, globalVoiceLines, true, nil, { AddedTraitNames = screen.AddedTraitNames } )

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
	PlaySound({ Name = args.SoundName or "/SFX/Menu Sounds/CauldronSpellCompleteNova"  })

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

function SeleneExitPresentation( source, args )

	args = args or {}
	wait( args.WaitTime or 0 )

	CreateAnimation({ Name = "TeleportDisappear", DestinationId = source.ObjectId })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.1 })

	source.NextInteractLines = nil
	UseableOff({ Id = source.ObjectId })
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )

	wait( 0.3, RoomThreadName )
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
		RemoveTimerBlock( CurrentRun, "BiomeOverlook" )

		SetThreadWait( "OverlookThread", 0.01 )
	end
end

function FountainDamagePresentation()
	PlaySound({ Name = "/SFX/Player Sounds/DionysusBlightWineDash", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "FountainDamageText_Alt", Duration = 1, LuaKey = "TempTextData", LuaValue = { TraitName = "FountainDamageBonusTrait", Amount = (GetTotalHeroTraitValue("FountainDamageBonus", {IsMultiplier = true}) - 1) * 100 } })
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

	if not args.SkipVoiceLines and CheckCooldown( "HarvestPointAvailablePresentation", 90 ) then
		if CurrentRun.UseRecord.SpellDrop and CurrentRun.UseRecord.SpellDrop > 0 then
			LoadVoiceBanks( { Name = "Selene" }, nil, true )
		end
		thread( PlayVoiceLines, GlobalVoiceLines.HarvestPointFoundVoiceLines, true )
	end
	wait( 0.25, RoomThreadName )
	PlaySound({ Name = args.PingSound or "/Leftovers/SFX/AnnouncementPing3", Id = source.ObjectId })
end

function StartDevotionTestPresentation( currentRoom, alternateLootData, alternateLootId )
	AddInputBlock({ Name = "DevotionTest" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = alternateLootId })
	wait(1.0)
	Shake({ Id = alternateLootData.ObjectId, Distance = 2, Speed = 250, Duration = 1.0  })
	PanCamera({ Ids = alternateLootData.ObjectId, Duration = 3.5, EaseIn = 0.05, EaseOut = 0.03 })
	thread( DoRumble, { { ScreenPreWait = 0.15, LeftFraction = 0.17, Duration = 1.0 }, } )
	thread( InCombatText, alternateLootId, alternateLootData.LootRejectedText, 2.5, { ShadowScaleX = 1.4 } )

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3", Id = alternateLootId })
	wait(0.5)
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteAngerSFX" })

	local textLines = GetRandomEligibleTextLines( alternateLootData, alternateLootData.RejectionTextLines, {} )
	PlayTextLines( alternateLootData, textLines )
	PanCamera({ Ids = CurrentRun.Hero.ObjectId, Duration = 1.0, EaseIn = 0.03, EaseOut = 0.03 })

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
	local textAnchorId = CreateScreenObstacle({ Name = "BlankObstacle", X = textStartX, Y = textStartY, Group = "Overlay", Alpha = ConfigOptionCache.HUDOpacity })

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
		ShadowOffsetY = 2,
		ShadowOffsetX = 0,
		ShadowAlpha = 1,
		ShadowBlur = 0,
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

function CutsceneAddLetterbox( args )
	args = args or {}
	ScreenAnchors.LetterBoxTop = ScreenAnchors.LetterBoxTop or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY - 1220 })
	ScreenAnchors.LetterBoxBottom = ScreenAnchors.LetterBoxBottom or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY + 1220 })
	SetScale({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = 5 })
	SetScaleX({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = ScreenScaleX })
	SetColor({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Color = Color.Black })
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = 1.0, Duration = 0 })
	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 270, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 90, Distance = 100, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.25 })
	if not args.Silent then
		PlaySound({ Name = "/SFX/Menu Sounds/BlackBarsWhoosh" })
	end
end





function ScreenEdgeIndicatorSpawnPresentation( source, args, indicatorBackingId, indicatorId )
	SetAlpha({ Id = indicatorId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = indicatorId, Fraction = 1.0, Duration = 0.2 })
	CreateAnimation({ Name = "ScreenEdgeIndicatorSpawnFx", DestinationId = indicatorBackingId })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh", Id = indicatorBackingId })
	PlaySound({ Name = args.SoundName or "/SFX/Menu Sounds/MirrorCloseWithUpgrade" })
end




function ChronosInvincibubblePresentation( chronos )
	if chronos.ChronosRevealInvincibubble ~= nil then
		return
	end
	chronos.ChronosRevealInvincibubble = CreateAnimation({ Name = "ChronosInvincibubble", DestinationId = chronos.ObjectId }) --nopkg
	wait( 1.0 )
	StopAnimation({ Name = "ChronosInvincibubble", DestinationId = chronos.ObjectId })
	chronos.ChronosRevealInvincibubble = nil
end

function DoChronosOnHitConversation( victim )

	-- fake invincibility flash
	thread( ChronosInvincibubblePresentation, victim )
	Flash({ Id = victim.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.15, ExpireAfterCycle = true })
	CreateAnimation({ Name = "Chronos360BlockFront", DestinationId = victim.ObjectId }) --nopkg
	PlaySound({ Name = "/SFX/Enemy Sounds/Exalted/EnemyShieldBlock", Id = victim.ObjectId })

	if not PlayingTextLines and not victim.DoingOnHitConversation then
		victim.DoingOnHitConversation = true

		AddInputBlock({ Name = "ChronosOnHitConversation" })

		local hitCount = victim.Hits
		wait( 1.0 )

		if hitCount == 1 then
			-- don't cut off Chronos's OnHitVoiceLines on the initial hit
			WaitForSpeechFinished()
		end

		RemoveEnemyUI( victim )
		ProcessTextLines( victim, victim.OnHitTextLineSets )
		local textLines = GetRandomEligibleTextLines( victim, victim.OnHitTextLineSets, GetNarrativeDataValue( victim, "OnHitTextLinePriorities" ) )
		RemoveInputBlock({ Name = "ChronosOnHitConversation" })
		victim.TextLinesUseWeaponIdle = true
		PlayTextLines( victim, textLines )

		victim.DoingOnHitConversation = nil
	end

end

function StartChronosFakeBossMusic( source, args )
	SecretMusicPlayer( "/Music/IrisMinibossMusic" )
	SetSoundCueValue({ Names = { "Section", }, Id = AudioState.SecretMusicId, Value = 2 })
end

function StartChronosFakeBossPresentation( source, args )
	CreateHealthBar( source )
end

function SpawnChronosForTaunt( source, args )
	Activate({ Id = args.UnitId })
	local newUnit = DeepCopyTable( EnemyData[args.UnitName] )
	newUnit.ObjectId = args.UnitId
	CurrentRun.SpawnedChronosForTaunt = true
	SetupUnit( newUnit, CurrentRun )
end

function ChronosExit( source, args )

	args = args or {}

	if source.CancelExitIfInteractable then
		if args.FromGiftEvent then
			if source.NextInteractLines ~= nil then
				return
			end
		else
			if CurrentRun.SpawnedChronosForTaunt and ( CanReceiveGift( source ) or source.ReceivingGift ) then
				return
			end
		end
	end

	source.Exiting = true
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

	if args.CheckCodex then
		CheckCodexUnlock( "OtherDenizens", "NPC_Chronos_01" )
	end

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

-- see also: NemesisTeleportExitPresentation
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

	local nextRoomData = RoomData[secretDoor.Room.Name] or secretDoor.Room

	-- preserve audio/VO presentation
	CleanupCustomRoomSounds()
	PlaySound({ Name = "/SFX/Menu Sounds/ChaosRoomEnterExit" })
	thread( PlayVoiceLines, HeroVoiceLines.SecretUnlockedVoiceLines )
	thread( InCombatText, secretDoor.ObjectId, "SecretPassageOpened", 1 )
	Stop({ Id = CurrentRun.Hero.ObjectId })

	if GameState.TextLinesRecord.ChaosFirstPickUp then
		local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
		SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 2 })
		wait( 0.5 )
		SetAnimation({ Name = "Melinoe_Witchcraft_Start", DestinationId = CurrentRun.Hero.ObjectId, })
	else
		wait( 2.0 )
		local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
		SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
		wait( 1.0 )
		SetAnimation({ Name = "Melinoe_Witchcraft_Start", DestinationId = CurrentRun.Hero.ObjectId, })
		wait( 0.9 )
	end

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.7 }, } )
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.5, MinFraction = 0, MaxFraction = 1.0, Color = Color.White, Duration = 1.0, ExpireAfterCycle = false })
	AdjustColorGrading({ Name = secretDoor.EntranceColorGrade or "Chaos", Duration = 0.7 })

	wait(0.6)

	-- The 'damage hit' happens here
	if secretDoor.HealthCost ~= nil and secretDoor.HealthCost > 0 then
		CreateAnimation({ Name = "SacrificeHealthFx", DestinationId = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHurt", Id = CurrentRun.Hero.ObjectId })
		thread( DisplayPlayerDamageText, { triggeredById = CurrentRun.Hero.ObjectId, PercentMaxDealt = secretDoor.HealthCost/CurrentRun.Hero.MaxHealth, DamageAmount = secretDoor.HealthCost } )
	end
	AdjustFullscreenBloom({ Name = "NewType09", Duration = 0.1 })

	wait( 0.2 )

	SetAnimation({ Name = "Melinoe_Witchcraft_End", DestinationId = CurrentRun.Hero.ObjectId, })
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
		thread( OnPlayerHealed, CurrentRun.Hero, { ActualHealAmount = doorHeal } )
	end

	FullScreenFadeOutAnimation( nextRoomData.LeavePrevRoomWipeAnimation or currentRun.CurrentRoom.LeaveWipeAnimation )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomSecretDoorPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function LeaveRoomSecretExitDoorPresentation( currentRun, secretDoor )
	local currentRoom = CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom
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

	FullScreenFadeOutAnimation( roomData.SecretExitWipeAnimation or "RoomTransitionIn_Down" )
	
	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomSecretExitDoorPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end



function SlightDescent()
	wait( 0.05 )	
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 0.12 )
	AdjustZLocation({ Id = CurrentRun.Hero.ObjectId, Distance = -25, Duration = 0.5, })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
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



function BouldyHitPresentation( victim )
	local source = ActiveEnemies[ GetClosestUnitOfType({ Id = victim.ObjectId, DestinationName = "NPC_Hades_Field_01", Distance = 9999 }) ]
	if source ~= nil then
		thread( PlayVoiceLines, source.OnHitVoiceLines, true, source )
	end
end

function BiomeOverlook( room, args )
	if not MapState.InOverlook and IsEmpty(RequiredKillEnemies) then
		AddTimerBlock( CurrentRun, "BiomeOverlook", { MapState = true } )
		MapState.InOverlook = true

		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 0.5 })
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "Keys" }, Value = 0.0, Duration = 3.0 })
		SetVolume({ Id = AudioState.MusicId, Value = 0.7, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")
		ToggleCombatControl( CombatControlsDefaults, false, "Overlook" )
		EndAutoSprint({ Halt = true, EndWeapon = true })

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




function ExitToAnomalyPresentation(currentRun, exitDoor)
	AddInputBlock({ Name = "LeaveRoomPresentation" })
	LoadVoiceBanks( { Name = "Intercom" }, nil, true )
	LoadPackages({ Names = "Chronos", IgnoreAssert = true })
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
	StopSound({ Id = AudioState.AmbienceId, Duration = 0.2 })
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
		CreateAnimation({ Name = "TimeTrapSandBubble", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = 40, })
		PlaySound({ Name = "/SFX/Enemy Sounds/Chronos/ChronosClockHand", Id = CurrentRun.Hero.ObjectId })

		wait(4.0)

		local chronos = DeepCopyTable( EnemyData.NPC_Chronos_01 )
		chronos.ObjectId = SpawnUnit({ Name = "NPC_Chronos_01", Group = "Standing", DestinationId = exitDoor.ObjectId, OffsetX = -110, OffsetY = -75, })
		SetupUnit( chronos, CurrentRun, { IgnoreAI = true, IgnoreAssert = true, } )
		SetUnitProperty({ DestinationId = chronos.objectId, Property = "CollideWithObstacles", Value = false })
		SetUnitProperty({ DestinationId = chronos.objectId, Property = "CollideWithUnits", Value = false })
		SetAlpha({ Id = chronos.ObjectId, Fraction = 0, Duration = 0 })
		AngleTowardTarget({ Id = chronos.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

		SetAlpha({ Id = chronos.ObjectId, Fraction = 1, Duration = 0.3 })
		CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = chronos.ObjectId })

		PanCamera({ Ids = chronos.ObjectId, Duration = 1.5, EaseIn = 0.03, EaseOut = 0.03 })
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
	StopAnimation({ Name = "TimeTrapSandBubbleLoop", DestinationId = CurrentRun.Hero.ObjectId })

	wait(0.01)
	FullScreenFadeOutAnimation()

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end


function AnomalyEntrancePresentation(currentRun, currentRoom, args)
	args = args or {}
	AddInputBlock({ Name = "AnomalyEntrancePresentation" })

	local currentRoomData = RoomData[currentRoom.Name] or currentRoom

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
	CreateAnimation({ Name = "TimeTrapSandBubbleLoop", DestinationId = CurrentRun.Hero.ObjectId, })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 1.0, Duration = 0.6 })
	SetAnimation({ Name = "Melinoe_Drop_Exit_FireLoop", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/Player Sounds/DemeterColdNovaRush", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteGasping", Id = CurrentRun.Hero.ObjectId, Delay = 0.2 })

	wait(0.4)
	StopAnimation({ Name = "TimeTrapSandBubbleLoop", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "TimeTrapSandBubbleOut", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.4)
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.6 })
	StopAnimation({ Name = "BoonOrbFrontFlare", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/EnemyPhaseInPoofSFX", Id = CurrentRun.Hero.ObjectId })

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	wait(0.2)
	CreateAnimation({ Name = "DustPuffBNoDecal", DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Melinoe_Drop_Entrance_Fire", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/BallLand", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/FootstepsWheatHeavy2", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/FootstepsWheatHeavy2", Id = CurrentRun.Hero.ObjectId, Delay = 0.2 })

	if currentRoomData.LocationText and not currentRoom.Encounter.BlockLocationText then
		thread( DisplayInfoBanner, nil, { Text = currentRoomData.LocationText, Delay = 0.65, FadeColor = currentRoomData.LocationTextColor or { 255, 0, 0, 255 }, Duration = 2.0, AnimationName = currentRoomData.LocationAnimName, AnimationOutName = currentRoomData.LocationAnimOutName, IconBackingAnimationName = currentRoomData.LocationTextAnimName, IconBackingAnimationOutName = currentRoomData.LocationTextAnimOutName, } )
	end
	thread(DelayedRemoveInputBlock, args.InputBlockReleaseDelay or 0.1, "AnomalyEntrancePresentation")
end

-- See also: CapturePointEncounterStartPresentation
function AnomalyStartPresentation(eventSource, args)

	LoadVoiceBanks({ Name = "Intercom" })
	LoadPackages({ Names = "Chronos" })

	wait( 0.75 )

	thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, ColorGrade = "Rain", OverlayAnim = "ChronosOverlay", VoiceLines = { GlobalVoiceLines = "AnomalyEnteredVoiceLines" }, StartSound = "/SFX/TimeSlowStart", RequireNonPlayerSource = true } )

	--AdjustFullscreenBloom({ Name = "Off", Duration = 5.0 })
	--AdjustColorGrading({ Name = "Off", Duration = 10.0 })

	wait( 5.0 )
	
	if CurrentRun.CurrentRoom.Encounter.CapturePointId == nil then
		CheckObjectiveSet("AnomalyStart")
	end

	wait( 1.66 )

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

	thread( PlayVoiceLines, GlobalVoiceLines.LeavingArenaVoiceLines )
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

	args = args or {}

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

	if args.ReturningFromElysium then
		thread( PlayVoiceLines, GlobalVoiceLines.ReturnedFromElysiumVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.AnomalyConcludedVoiceLines, true )
	end

	if currentRoom.LocationText and not currentRoom.Encounter.BlockLocationText then
		thread( DisplayInfoBanner, nil, { Text = currentRoom.LocationText, Delay = 0.65, FadeColor = currentRoom.LocationTextColor or { 255, 0, 0, 255 }, Duration = 2.0, AnimationName = currentRoom.LocationAnimName, AnimationOutName = currentRoom.LocationAnimOutName, IconBackingAnimationName = currentRoom.LocationTextAnimName, IconBackingAnimationOutName = currentRoom.LocationTextAnimOutName, } )
	end
	wait( roomIntroSequenceDuration )

	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })

	RemoveInputBlock({ Name = "EntranceFromAnomalyPresentation" })
end

function EndTinyVerminRadialBlur( args )
	args = args or {}
	wait( args.Delay or 0.8 )
	AdjustRadialBlurDistance({ Fraction = 0.0, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.0, Duration = 0.2 })
end

function ChronosTimeSlowPresentation( args )
	args = args or {}
	local duration = 0.05
	AdjustColorGrading({ Name = "ChronosTimeSlow", Duration = duration })
	-- AdjustFullscreenBloom({ Name = "GoldBloom", Duration = duration })
	AdjustRadialBlurDistance({ Fraction = 0.05, Duration = duration })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = duration })

	SetAudioEffectState({ Name = "ChronosSlow", Value = 1 })

	PlaySound({ Name = "/SFX/Player Sounds/TimeSlowStart" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweepSubtle" })
	if not args.IgnoreSoundLoop and AudioState.ChronosTimeSlowSoundId == nil then
		AudioState.ChronosTimeSlowSoundId = PlaySound({ Name = "/SFX/Player Sounds/TimeSlowLoop" })
	end
	if ScreenAnchors.TimeStopVignette ~= nil then
		return
	end
	ScreenAnchors.TimeStopVignette = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY, })
	SetAnimation({ Name = "ChronosTimeStopFx", DestinationId = ScreenAnchors.TimeStopVignette }) -- nopkg
	CreateAnimation({ Name = "ChronosTimeStopMelFx", DestinationId = CurrentRun.Hero.ObjectId }) -- nopkg
end

function ChronosEndTimeSlowPresentation()
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.3 })
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })

	SetAudioEffectState({ Name = "ChronosSlow", Value = 0 })
	PlaySound({ Name = "/SFX/Player Sounds/TimeSlowEnd" })

	if AudioState.ChronosTimeSlowSoundId ~= nil then
		StopSound({ Id = AudioState.ChronosTimeSlowSoundId, Duration = 0.3 })
		AudioState.ChronosTimeSlowSoundId = nil
	end

	StopAnimation({ Name = "ChronosTimeStopMelFx", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = ScreenAnchors.TimeStopVignette, Fraction = 0.0, Duration = 0.3 })
	wait(0.3) 
	Destroy({ Id = ScreenAnchors.TimeStopVignette })
	ScreenAnchors.TimeStopVignette = nil
end

function OlympusSkyEntrancePresentation( currentRun, currentRoom, args )
	args = args or {}
	SessionMapState.SkyEntranceInProgress = true
	currentRoom.BlockAggro = true
	local notifyName = args.NotifyName or "SkyEntranceInput"
	currentRoom.EntrancePresentationNotifyName = notifyName

	local startPointOptions = GetIds({ Name = "SkySpawnPoints" }) or { currentRoom.HeroEndPoint }
	local startPoint = nil

	if ActiveEnemies ~= nil and not IsEmpty(ActiveEnemies) then
		startPoint = GetClosest({ Id = GetRandomValue(ActiveEnemies).ObjectId, DestinationIds = startPointOptions,  })
	else
		startPoint = GetRandomValue(startPointOptions)
	end

	AddInputBlock({ Name = "OlympusSkyEntrancePresentation" })
	SetPlayerInvulnerable( "OlympusSkyEntrance" )
	if not args.NoInput then
		ToggleCombatControl( CombatControlsDefaults, false, "OlympusSkyEntrancePresentation" )
	end
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
	FullScreenFadeInAnimation( "RoomTransitionOut_Down" )

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
		local destinationId = GetClosest({ Id = currentRun.Hero.ObjectId, DestinationIds = GetIds({ Name = "SpawnPoints" }) })
		if destinationId == nil or destinationId == 0 then
			destinationId = currentRoom.HeroEndPoint
		end
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = destinationId })
		wait( 0.15 )
	end

	wait( 0.01 )

	PlaySound({ Name = "/SFX/OlympusJumpSlam", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteAttackingFierce", Id = CurrentRun.Hero.ObjectId })

	StopSound({ Id = airSoundId, Duration = 0.2 })

	AdjustZLocation({ Id = currentRun.Hero.ObjectId, Distance = 500, Duration = 0.0 })
	ApplyUpwardForce({ Id = currentRun.Hero.ObjectId, Speed = -2000 })
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.0 })
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.05 )

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
			enemy.AggroReactionTime = nil
			enemy.AggroReactionTimeMin = 0.05
			enemy.AggroReactionTimeMax = 0.3
			SetThreadWait(enemy.AIThreadName, 0.01)
			notifyExistingWaiters(enemy.AINotifyName)
		end
	end

	wait( 0.4 )

	RemoveInputBlock({ Name = "OlympusSkyEntrancePresentation" })
	ToggleCombatControl( CombatControlsDefaults, true, "OlympusSkyEntrancePresentation" )
	SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })

	wait( 0.05 )
	
	SessionMapState.SkyEntranceInProgress = nil
	SetPlayerVulnerable( "OlympusSkyEntrance" )
end

function TrueEndingTimeFxVignette()
	AdjustColorGrading({ Name = "ChronosTimeSlow", Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "EndingTimeVignetteBloom", Duration = 1.0 })
	ScreenAnchors.TimeFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "FX_Standing_Top", X = ScreenCenterX, Y = ScreenCenterY })		
	CreateAnimation({ Name = "EndingTimeVignetteFx", DestinationId = ScreenAnchors.TimeFxAnchor }) --nopkg
	wait(4.0)
	StopAnimation({ Name = "EndingTimeVignetteFx", DestinationId = ScreenAnchors.TimeFxAnchor })
	AdjustFullscreenBloom({ Name = "Off", Duration = 4.0 })
	AdjustColorGrading({ Name = "Off", Duration = 4.0 })
	wait(3.0)
	Destroy({ Id = ScreenAnchors.TimeFxAnchor })
end

function QIntroEntrancePresentation( currentRun, currentRoom, args )
	args = args or {}

	local startPoint = GetRandomValue(GetIds({ Name = "SkySpawnPoints" }))

	AddInputBlock({ Name = "QIntroEntrancePresentation" })
	SetPlayerInvulnerable( "QIntroEntrancePresentation" )
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

	if GameState.ReachedTrueEnding then
		CreateAnimation({ Name = "SandPortalExit_Down", DestinationId = CurrentRun.Hero.ObjectId }) --nopkg
		FullScreenFadeInAnimation( "RoomTransitionOut_TimeWarp" ) --nopkg
		thread( TrueEndingTimeFxVignette )
	else
		FullScreenFadeInAnimation()
	end

	-- Start these earlier than normal in this case
	RunEventsGeneric( currentRun.CurrentRoom.Encounter.EncounterSpawnsStartEvents, currentRun.CurrentRoom.Encounter )
	currentRun.CurrentRoom.Encounter.RanEncounterSpawnsStartEvents = true

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.0 })
	SetUnitProperty({ Property = "MoveGraphic", Value = nil, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithUnits", Value = false, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = false, DestinationId = CurrentRun.Hero.ObjectId })

	AdjustZoom({ Fraction = currentRoom.ZoomFraction, LerpTime = 3.65 })

	wait(0.35)

	thread( PlayVoiceLines, HeroVoiceLines.OlympusSkyEntranceVoiceLines, false )

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

	SetUnitProperty({ Property = "CollideWithUnits", Value = true, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "MelinoeRun", DestinationId = CurrentRun.Hero.ObjectId })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })

	wait( 0.03 )

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	wait( 0.1 )

	CreateProjectileFromUnit({ Name = "HeroSkyTouchdown", Id = currentRun.Hero.ObjectId, DestinationId = currentRun.Hero.ObjectId, FireFromTarget = true })
	SetAnimation({ Name = "Melinoe_HeroLanding", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = dropShadow, Fraction = 0, Duration = 0.03 })
	ShakeScreen({ Speed = 150, Distance = 6, Duration = 0.15, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.18, Duration = 0.8 }, } )

	wait( 2.29 )

	RemoveInputBlock({ Name = "QIntroEntrancePresentation" })

	wait( 0.05 )

	SetPlayerVulnerable( "QIntroEntrancePresentation" )
end

function HitByMiasmaPresentation( victim )
	if victim ~= CurrentRun.Hero then
		return
	end

	local threadName = "PoisonGasThread"
	local fadeDuration = 0.4
	local clearDelay = 2.51

	if SetThreadWait( threadName, clearDelay ) then
		return
	end

	if victim.ChokingSound ~= nil then
		PlaySound({ Name = victim.ChokingSound, Id = victim.ObjectId })
	end
	PlaySound({ Name = "/SFX/WrathOver2", Id = victim.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.HitByMiasmaVoiceLines, true )

	AdjustFullscreenBloom({ Name = "Miasma", Duration = fadeDuration })
	AdjustColorGrading({ Name = "Miasma", Duration = fadeDuration })

	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {1,0.5,0.3,1}, Duration = fadeDuration })

	ScreenAnchors.MiasmaVignetteAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })
	ScreenAnchors.MiasmaVignette = SpawnObstacle({ Name = "BlankObstacle", DestinationId = ScreenAnchors.MiasmaVignetteAnchor, Group = "Combat_Menu_Additive" })
	SetAnimation({ Name = "MiasmaVignetteSpawner", DestinationId = ScreenAnchors.MiasmaVignette  })
	DrawScreenRelative({ Ids = { ScreenAnchors.MiasmaVignette } })
end

function MiasmaClearedPresentation( victim )
	thread( PlayVoiceLines, HeroVoiceLines.RecovedFromMiasmaVoiceLines, true )

	PlaySound({ Name = "/SFX/TimeSlowEnd", Id = victim.ObjectId })

	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {1,1,1,1}, Duration = 0.3 })

	if SessionMapState.TimeSlowActive then
		AdjustColorGrading({ Name = "MoonDust", Duration = 0.3 })
	else
		AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	end
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
	SetAnimation({ Name = "MiasmaVignetteEnd", DestinationId = ScreenAnchors.MiasmaVignette  })
	wait( 1.0 )
	Destroy({ Ids = { ScreenAnchors.MiasmaVignette, ScreenAnchors.MiasmaVignetteAnchor } })
	ScreenAnchors.MiasmaVignette = nil
	ScreenAnchors.MiasmaVignetteAnchor = nil
end


function RoomEntranceCBossPresentation(currentRun, currentRoom, args)
	local roomData = RoomData[currentRoom.Name] or currentRoom

	local zagreusId = GetIdsByType({ Name = "Zagreus" })[1]

	AddInputBlock({ Name = "RoomEntranceCBossPresentation" })

	PlaySound({ Name = "/SFX/TheseusCrowdCheer" })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = zagreusId })
	SetAnimation({ Name = "Zagreus_Idle", DestinationId = zagreusId })

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
	LockCamera({ Id = currentRoom.CameraStartPoint, Duration = 0, OffsetY = -150 })
	AdjustZLocation({ Id = currentRun.Hero.ObjectId, Distance = 1800, Duration = 0.0 })
	PanCamera({ Id = currentRoom.CameraStartPoint, Duration = 1.2, EaseIn = 0, Retarget = true})
	wait(0.03)

	ApplyUpwardForce({ Id = currentRun.Hero.ObjectId, Speed = -100 })
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation( "RoomTransitionOut_Down" )
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })

	wait(0.3)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })

	wait(0.03)

	thread( PlayVoiceLines, GlobalVoiceLines.ZagreusBossGreetingLines )

	if currentRoom.LocationText and not currentRoom.Encounter.BlockLocationText then
		thread( DisplayInfoBanner, nil, { Text = currentRoom.LocationText, Delay = 0.65, FadeColor = currentRoom.LocationTextColor or { 255, 0, 0, 255 }, Duration = 2.0, AnimationName = roomData.LocationAnimName, AnimationOutName = roomData.LocationAnimOutName, IconBackingAnimationName = currentRoom.LocationTextAnimName, IconBackingAnimationOutName = currentRoom.LocationTextAnimOutName, } )
	end
	
	wait( 0.33 )
	SetAnimation({ Name = "Melinoe_Drop_Entrance_Fire_NoEquip", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = dropShadow, Fraction = 0, Duration = 0.03 })
	ShakeScreen({ Speed = 150, Distance = 6, Duration = 0.15, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.18, Duration = 0.8 }, } )
	PlaySound({ Name = "/Leftovers/SFX/BallLand", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/FootstepsWheatHeavy2", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/FootstepsWheatHeavy2", Id = CurrentRun.Hero.ObjectId, Delay = 0.2 })
	CreateAnimation({ Name = "DustPuffBNoDecal", DestinationId = CurrentRun.Hero.ObjectId })
	RemoveInputBlock({ Name = "RoomEntranceCBossPresentation" })

	Destroy({ Id = dropShadow })

	wait( 2.0 )

end

function ContractExitPresentation(currentRun, exitDoor, args)
	AddInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "ContractExitPresentation" )

	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait (0.01)

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = exitDoor.ObjectId })

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.1, OffsetY = -50, EaseOut = 0 })
	wait(0.5)	
	ModifySubtitles({ SuppressLyrics = true })
	SecretMusicPlayer( "/Music/BlankMusicCue" )
	StopSound({ Id = AudioState.AmbienceId, Duration = 0.2 })
	AudioState.AmbienceId = PlaySound({ Name = "/Leftovers/Ambience/MatchSiteAAmbience" })
	

	wait (0.35)

	SetAnimation({ Name = "MelTalkBrooding01", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })

	CurrentRun.Hero.ExitAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })

	local firstVisitRequirements =
	{
		{
			PathFalse = { "GameState", "TextLinesRecord", "ZagreusBossFirstMeeting" }
		},
	}
	-- longer the first time
	if IsGameStateEligible( exitDoor,firstVisitRequirements ) then
		thread( PlayVoiceLines, HeroVoiceLines.ContractAcceptedVoiceLines )
		PanCamera({ Id = exitDoor, Duration = 9, OffsetY = 120, Retarget = true })
		FocusCamera({ Fraction = 0.95, Duration = 9 })
		wait(4.1)
	else
		PlayVoiceLines( HeroVoiceLines.ContractAcceptedVoiceLines )
	end

	SetAnimation({ Name = "MelinoeInteractWeaponless", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.2)
	CreateAnimation({ Name = "ContractTeleportFx", DestinationId = exitDoor.ObjectId, Scale = 0.7 })
	SetAlpha({ Id = exitDoor.ObjectId, Fraction = 0.0, Duration = 0.1 })
	PlaySound({ Name = "/SFX/Enemy Sounds/Chronos/ChronosTeleport", Id = CurrentRun.Hero.ObjectId })
	wait( 0.1 )
	CreateAnimation({ Name = "HadesContractFx", DestinationId = CurrentRun.Hero.ObjectId, })
	PlaySound({ Name = "/SFX/ShipsDoorTeleport", Id = CurrentRun.Hero.ObjectId })

	wait(1.0)

	CreateAnimation({ Name = "ContractTeleportFx", DestinationId = CurrentRun.Hero.ObjectId, })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0, Duration = 0.1 })

	wait(0.01)

	ModifySubtitles({ SuppressLyrics = false })
	FullScreenFadeOutAnimation( "RoomTransitionIn_Down" )
	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end