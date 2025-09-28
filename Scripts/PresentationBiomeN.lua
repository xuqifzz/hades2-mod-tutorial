function PolyphemusBoulderIncomingPresentation()
	thread( PlayVoiceLines, HeroVoiceLines.BoulderIncomingVoiceLines, true )
end

function PolyphemusPlayerGrabApplyPresentation( triggerArgs, args )
	local victim = triggerArgs.Victim

	if args ~= nil and args.BossPolymorph then
		thread( PolymorphSimSlow )
	end
	thread( InCombatTextArgs, { TargetId = victim.ObjectId, Text = "PolyphemuGrabPlayerSuccess", ShadowScale = 0.6, PreDelay = 0.1, Duration = 1.0, OffsetY = 80 } )
	thread( PolyphemusGrabOngoingPresentation )
	if not triggerArgs.Reapplied then
		AddInputBlock({ Name = "PolyphemusPlayerGrab" })
		--SetAlpha({ Id = victim.ObjectId, Fraction = 0, Duration = 0 })
		--AdjustZoom({ Fraction = 1.05, LerpTime = 0.1, Duration = 99999 })
	end
end

function PolyphemusGrabOngoingPresentation( )
	local fireTicks = 7
	local zoomPulse = CurrentRun.CurrentRoom.ZoomFraction
	while fireTicks > 0 do
		zoomPulse = zoomPulse + 0.015
		ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.2 })
		fireTicks = fireTicks - 1
		FocusCamera({ Fraction = zoomPulse, Duration = 0.3, ZoomType = "Overshoot" })
		wait( 0.5, "PolyphemusGrabOngoingPresentation" )
	end
end

function PolyphemusPlayerGrabClearPresentation( triggerArgs, args )
	local victim = triggerArgs.Victim
	killTaggedThreads("PolyphemusGrabOngoingPresentation")
	wait( 1.17 )
	ClearPlayerFade( "PolyphemusGrab", 0.06 )
	SetAnimation({ Name = "MelinoeGetHit", DestinationId = CurrentRun.Hero.ObjectId })
	--ApplyUpwardForce({ Id = CurrentRun.Hero.ObjectId, Speed = 1200 })
	ApplyForce({ Id = CurrentRun.Hero.ObjectId, Speed = 1100, Angle = 0 })
	AdjustColorGrading({ Name = "Off", Duration = 0.8 })
	--SetAlpha({ Id = victim.ObjectId, Fraction = 1, Duration = 0 })
	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.0, Duration = 999999 })
	wait( 0.3 )
	RemoveInputBlock({ Name = "PolyphemusPlayerGrab" })
end

function PolyphemusInterruptWeaponPresentation( enemy, aiData )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "PolyphemusRetaliate", ShadowScale = 0.6, PreDelay = 0.1, Duration = 1.5, OffsetY = 80 } )
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/EmoteAlerted", Id = enemy.ObjectId, Delay = 0.2 })
end

function PlayPolyphemusTauntAnim( source, args )
	if source ~= nil then
		SetAnimation({ Name = "Enemy_Polyphemus_Taunt", DestinationId = source.ObjectId })
	end
end

function MedeaCursePostChoicePresentation( screen, args )
	local medeaId = GetIdsByType({ Name = "NPC_Medea_01"})[1]
	local cauldronPoints = GetIdsByType({ Name = "CrossroadsCauldron02"})
	PlaySound({ Name = screen.Source.ConfirmSound or "/SFX/Menu Sounds/GodBoonChoiceConfirm" })
	thread( PlayVoiceLines, GlobalVoiceLines.MiscEndVoiceLines_Medea, nil, screen.OpenedFrom, args )

	if not IsEmpty( cauldronPoints ) and medeaId ~= nil then
		AngleTowardTarget({ Id = medeaId, DestinationId = cauldronPoints[1] })
	end

	wait( 0.02 )
	ShakeScreen({ Speed = 1000, Distance = 2, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.3 }, } )
	AdjustColorGrading({ Name = screen.Source.ColorGrade or "ItemGet", Duration = 0.2 })
	SetAnimation({ Name = screen.Source.UpgradeAcquiredAnimation or "MelinoeBoonInteractPowerUp", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "ItemGetVignette", OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, Scale = 2.0, UseScreenLocation = true })
	wait( screen.Source.UpgradeAcquiredAnimationDelay or 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	ChaosBassStop()

	if not IsEmpty( cauldronPoints ) then
		CreateAnimation({ Name = "CauldronSmokeSmaller", DestinationId = cauldronPoints[1] })
		PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = cauldronPoints[1] })
	end

	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function WitchPostSpellPresentation( source, args )
	
	if args.Animation ~= nil then
		SetAnimation({ DestinationId = source.ObjectId, Name = args.Animation })
	end
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonChoiceConfirm" })
	ShakeScreen({ Speed = 1000, Distance = 2, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.3 }, } )
	AdjustColorGrading({ Name = "ItemGet", Duration = 0.2 })
	wait( 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })

	local cauldronPoints = GetIdsByType({ Names = { "CrossroadsCauldron02", "CrossroadsCauldronSet01" } })
	if not IsEmpty( cauldronPoints ) then
		CreateAnimation({ Name = "CauldronSmokeSmaller", DestinationId = cauldronPoints[1] })
		PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = cauldronPoints[1] })
	end

end

function FirstPylonHubReturnPresentation(room, args)
	AddInputBlock({ Name = "FirstPylonHubReturnPresentation" })
	local shadeIds = { 664247, 664248, 664249 }
	Activate({ Ids = shadeIds })
	SetupUnits(shadeIds)
	HideCombatUI( "FirstPylonHubReturnPresentation" )
	CutsceneAddLetterbox()

	--Shake({ Id = 645847, Distance = 1, Speed = 150, Duration = 2.5 })
	thread( PlayVoiceLines, HeroVoiceLines.BarrierWeakenedVoiceLines )

	wait( 1.35 )

	PanCamera({ Id = 645847, Duration = 2.5 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	
	wait( 2.25 )
	
	--PlaySound({ Name = "/SFX/Player Sounds/DemeterDashShardShatter", Id = 645847 })
	--CreateAnimation({ Name = "SoulPylonDestroyedFxStanding", DestinationId = 645847, Scale = 1.0, OffsetY = 0 })
	--CreateAnimation({ Name = "PowerUpComboReadyWeaponKit", DestinationId = 645847, Scale = 1.5, OffsetY = -200 })
	thread( PlayEmoteSimple, nil, { AnimationName = "StatusIconSmile", Delay = 0.15, ChanceToPlay = 1.0, TargetId = 664247 } )
	thread( PlayEmoteSimple, nil, { AnimationName = "StatusIconSmile", Delay = 0.25, ChanceToPlay = 1.0, TargetId = 664248 } )
	thread( PlayEmoteSimple, nil, { AnimationName = "StatusIconSmile", Delay = 0.45, ChanceToPlay = 1.0, TargetId = 664249 } )

	wait( 2.25 )
	
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.3 })

	wait(0.5)
	
	RemoveInputBlock({ Name = "FirstPylonHubReturnPresentation" })

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })

	wait(0.35)
	thread( FirstPylonHubReturnPresentationEnd, room, args )
end

function FirstPylonHubReturnPresentationEnd(room, args)
	thread( HandlePylonObjective, room, args)
	wait( 0.85 )
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 0, Duration = 0.4 })
	ShowCombatUI( "FirstPylonHubReturnPresentation" )
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

	local heroExitPointId = nil
	if exitDoorId ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = exitDoorId })
		local heroExitIds = GetIdsByType({ Name = "HeroExit" })
		heroExitPointId = GetClosest({ Id = exitDoorId, DestinationIds = heroExitIds, Distance = 300 })
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

	FullScreenFadeOutAnimation( roomData.EnterWipeAnimation or GetDirectionalWipeAnimation( { TowardsId = heroExitPointId, Enter = false } ) )

	wait( 0.31 )
	WaitForSpeechFinished()
	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
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

function StartSurfacePenaltyPresentation()
	wait( 0.1 )
	thread( SurfacePenaltyPresentation )
end

function SurfacePenaltyPresentation()
	if SessionMapState.SprintActive and SessionMapState.WaitUntilAutoSprintInput then
		EndAutoSprint({ Halt = true, EndWeapon = true })
	end
	HideCombatUI( "SurfacePenaltyPresentation" )
	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait( 0.05 )

	AddInputBlock({ Name = "SurfacePenaltyApply" })
	AdjustColorGrading({ Name = "Team03", Duration = 1.0 })
	SetAnimation({ Name = "MelinoeGetHit", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.07 })
	PlaySound({ Name = "/Leftovers/SFX/GoalScoredNEW" })

	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.85, MinFraction = 0.2, MaxFraction = 0.5, Color = Color.Purple, Duration = 1.5 })

	CreateAnimation({ Name = "PowerUpComboReady", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
	CreateAnimation({ Name = "ThanatosDeathsHead_SurfacePenalty", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top", OffsetY = 100 })
	BloomRequestStart({ SourceName = "SurfacePenaltyPresentation", BloomType = "BlurryLight", Duration = 0.5 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.15, Duration = 2, ZoomType = "Ease" })

	thread( PlayVoiceLines, HeroVoiceLines.CurseActiveVoiceLines )

	Rumble({ Duration = 1.0, RightFraction = 0.17 })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 1.5 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.5 })

	waitUnmodified( 1.0 )

	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "SurfacePenalty", Duration = 1.5, ShadowScaleX = 1.2, PreDelay = 0.1, } )

	waitUnmodified( 1.0 )

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1. })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.0 })
	BloomRequestEnd({ SourceName = "SurfacePenaltyPresentation", Duration = 1.0 })
	AdjustColorGrading({ Name = "Off", Duration = 1.0 })

	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1, ZoomType = "Ease" })
--	RemoveSimSpeedChange( "WeaponCancelEffect", { LerpTime = 0.5 } )

--	waitUnmodified( 0.5 )

--	SetAnimation({ Name = "MelinoeIdleWeaponless", DestinationId = CurrentRun.Hero.ObjectId })
	RemoveInputBlock({ Name = "SurfacePenaltyApply" })
	ShowCombatUI( "SurfacePenaltyPresentation" )

end

function EphyraZoomOutDoorSort( doorA, doorB )
	return doorA.ScreenLocationY < doorB.ScreenLocationY
end

function EphyraZoomOut( usee )
	AddInputBlock({ Name = "EphyraZoomOut" })
	AddTimerBlock( CurrentRun, "EphyraZoomOut" )
	SessionMapState.BlockPause = true
	thread( HideCombatUI, "EphyraZoomOut", { SkipHideObjectives = true } )
	SetPlayerInvulnerable( "EphyraZoomOut" )
	
	UseableOff({ Id = usee.ObjectId })

	ClearCameraClamp({ LerpTime = 0.8 })
	thread( SendCritters, { MinCount = 20, MaxCount = 20, StartX = 0, RandomStartOffsetX = 1200, StartY = 300, MinAngle = 75, MaxAngle = 115, MinSpeed = 400, MaxSpeed = 2000, MinInterval = 0.001, MaxInterval = 0.001, GroupName = "CrazyDeathBats" } )

	local cameraTargetId = SpawnObstacle({ Name = "InvisibleTarget" })
	Teleport({ Id = cameraTargetId, DestinationIsScreenRelative = true, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY - 350 })
	PanCamera({ Id = cameraTargetId, Duration = 1.0, EaseIn = 0, EaseOut = 0, Retarget = true, FromCurrentLocation = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 0.95, Duration = 1, ZoomType = "Ease" })

	wait( 0.50 )

	local groupName = "Combat_Menu_Backing"
	local idsCreated = {}

	ScreenAnchors.EphyraZoomBackground = CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY })
	table.insert( idsCreated, ScreenAnchors.EphyraZoomBackground )
	SetScale({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 5 })
	SetColor({ Ids = { ScreenAnchors.EphyraZoomBackground }, Color = Color.Black })
	SetAlpha({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 0, Duration = 0 })
	SetAlpha({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 1.0, Duration = 0.2 })

	local letterboxIds = {}
	if ScreenState.NeedsLetterbox then
		local letterboxId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu", Animation = "GUI\\Graybox\\NativeAspectRatioFrame", Alpha = 0.0 })
		table.insert( letterboxIds, letterboxId )
		SetAlpha({ Id = letterboxId, Fraction = 1.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
	elseif ScreenState.NeedsPillarbox then
		local pillarboxLeftId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenState.PillarboxLeftX, Y = ScreenCenterY, ScaleX = ScreenState.PillarboxScaleX, Group = "Combat_Menu", Animation = "GUI\\SideBars_01", Alpha = 0.0 })
		table.insert( letterboxIds, pillarboxLeftId )
		SetAlpha({ Id = pillarboxLeftId, Fraction = 1.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
		FlipHorizontal({ Id = pillarboxLeftId })
		local pillarboxRightId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenState.PillarboxRightX, Y = ScreenCenterY, ScaleX = ScreenState.PillarboxScaleX, Group = "Combat_Menu", Animation = "GUI\\SideBars_01", Alpha = 0.0 })
		table.insert( letterboxIds, pillarboxRightId )
		SetAlpha({ Id = pillarboxRightId, Fraction = 1.0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
	end

	wait( 0.21 )

	ScreenAnchors.EphyraMapId = CreateScreenObstacle({ Name = "rectangle01", Group = groupName, X = ScreenCenterX, Y = ScreenCenterY })
	table.insert( idsCreated, ScreenAnchors.EphyraMapId )
	SetAnimation({ Name = usee.MapAnimation, DestinationId = ScreenAnchors.EphyraMapId })
	SetHSV({ Id = ScreenAnchors.EphyraMapId, HSV = { 0, -0.15, 0 }, ValueChangeType = "Add" })

	local exitDoorsIPairs = CollapseTableOrdered( MapState.OfferedExitDoors )
	local sortedDoors = {}
	for index, door in ipairs( exitDoorsIPairs ) do
		if not door.SkipUnlock then
			local room = door.Room
			local rawScreenLocation = ObstacleData[usee.Name].ScreenLocations[door.ObjectId]
			if rawScreenLocation ~= nil then
				door.ScreenLocationX = rawScreenLocation.X
				door.ScreenLocationY = rawScreenLocation.Y
				table.insert( sortedDoors, door )
			end
		end
	end
	table.sort( sortedDoors, EphyraZoomOutDoorSort )

	local attachedCircles = {}
	for index, door in ipairs( sortedDoors ) do
		local room = door.Room
		local screenLocation = { X = door.ScreenLocationX + ScreenCenterNativeOffsetX, Y = door.ScreenLocationY + ScreenCenterNativeOffsetY }
		local rewardBackingId = CreateScreenObstacle({ Name = "BlankGeoObstacle", Group = groupName, X = screenLocation.X, Y = screenLocation.Y, Scale = 0.6 })
		if room.RewardStoreName == "MetaProgress" then
			SetAnimation({ Name = "RoomRewardAvailable_Back_Meta", DestinationId = rewardBackingId })
		else
			SetAnimation({ Name = "RoomRewardAvailable_Back_Run", DestinationId = rewardBackingId })
		end
		table.insert( attachedCircles, rewardBackingId )

		local rewardIconId = CreateScreenObstacle({ Name = "RoomRewardPreview", Group = groupName, X = screenLocation.X, Y = screenLocation.Y, Scale = 0.6 })
		SetColor({ Id = rewardIconId, Color = { 0,0,0,1} })
		table.insert( attachedCircles, rewardIconId )
		local rewardHidden = false
		if HasHeroTraitValue( "HiddenRoomReward" ) then
			SetAnimation({ DestinationId = rewardIconId, Name = "ChaosPreview" })
			rewardHidden = true
		elseif room.ChosenRewardType == nil or room.ChosenRewardType == "Story" then
			SetAnimation({ DestinationId = rewardIconId, Name = "StoryPreview", SuppressSounds = true })
		elseif room.ChosenRewardType == "Shop" then
			SetAnimation({ DestinationId = rewardIconId, Name = "ShopPreview", SuppressSounds = true })
		elseif room.ChosenRewardType == "Boon" and room.ForceLootName then
			local previewIcon = LootData[room.ForceLootName].DoorIcon or LootData[room.ForceLootName].Icon
			if room.BoonRaritiesOverride ~= nil and LootData[room.ForceLootName].DoorUpgradedIcon ~= nil then
				previewIcon = LootData[room.ForceLootName].DoorUpgradedIcon
			end
			SetAnimation({ DestinationId = rewardIconId, Name = previewIcon, SuppressSounds = true })
		elseif room.ChosenRewardType == "Devotion" then

			local rewardIconAId = CreateScreenObstacle({ Name = "RoomRewardPreview", Group = groupName, X = screenLocation.X + 12, Y = screenLocation.Y - 11, Scale = 0.6 })
			SetColor({ Id = rewardIconAId, Color = { 0,0,0,1} })
			SetAnimation({ DestinationId = rewardIconAId, Name = LootData[room.Encounter.LootAName].DoorIcon, SuppressSounds = true })
			table.insert( attachedCircles, rewardIconAId )
					
			local rewardIconBId = CreateScreenObstacle({ Name = "RoomRewardPreview", Group = groupName, X = screenLocation.X - 12, Y = screenLocation.Y + 11, Scale = 0.6 })
			SetColor({ Id = rewardIconBId, Color = { 0,0,0,1} })
			SetAnimation({ DestinationId = rewardIconBId, Name = LootData[room.Encounter.LootBName].DoorIcon, SuppressSounds = true })
			table.insert( attachedCircles, rewardIconBId )
		else
			local animName = room.ChosenRewardType
			local lootData = LootData[room.ChosenRewardType]
			if lootData ~= nil then
				animName = lootData.DoorIcon or lootData.Icon or animName
			end
			local consumableData = ConsumableData[room.ChosenRewardType]
			if consumableData ~= nil then
				animName = consumableData.DoorIcon or consumableData.Icon or animName
			end
			SetAnimation({ DestinationId = rewardIconId, Name = animName, SuppressSounds = true })
		end

		local subIcons = PopulateDoorRewardPreviewSubIcons( door, { ChosenRewardType = room.ChosenRewardType, RewardHidden = rewardHidden } )

		local iconSpacing = 30
		local numSubIcons = #subIcons
		local isoOffset = iconSpacing * -0.5 * (numSubIcons - 1)
		for i, iconData in ipairs( subIcons ) do
			local iconId = CreateScreenObstacle({ Name = "BlankGeoObstacle", Group = groupName, Scale = 0.6 })
			local offsetAngle = 330
			if IsHorizontallyFlipped({ Id = door.ObjectId }) then
				offsetAngle = 30
				FlipHorizontal({ Id = iconId })
			end
			local offset = CalcOffset( math.rad( offsetAngle ), isoOffset )
			Attach({ Id = iconId, DestinationId = rewardBackingId, OffsetX = offset.X, OffsetY = offset.Y, OffsetZ = 60, })
			SetAnimation({ DestinationId = iconId, Name = iconData.Animation or iconData.Name })
			table.insert( attachedCircles, iconId )
			isoOffset = isoOffset + iconSpacing
		end

		if IsHorizontallyFlipped({ Id = door.ObjectId }) then
			local ids = ( { rewardBackingId, rewardIconId } )
			if not IsEmpty( ids ) then
				FlipHorizontal({ Ids = ids })
			end
		end

	end

	local melScreenLocation = ObstacleData[usee.Name].ScreenLocations[usee.ObjectId]
	ScreenAnchors.MelIconId = nil
	if melScreenLocation ~= nil then
		ScreenAnchors.MelIconId = CreateScreenObstacle({ Name = "rectangle01", Group = groupName, Animation = "Mel_Icon", X = melScreenLocation.X + ScreenCenterNativeOffsetX, Y = melScreenLocation.Y + ScreenCenterNativeOffsetY })
		table.insert( idsCreated, ScreenAnchors.MelIconId )
	end

	SetAlpha({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 0.0, Duration = 0.35 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShort" })
	wait( 0.5 )

	local zoomOutTime = 0.5

	ScreenAnchors.EphyraZoomBackground = CreateScreenObstacle({ Name = "rectangle01", Group = groupName, X = ScreenCenterX, Y = ScreenCenterY })
	table.insert( idsCreated, ScreenAnchors.EphyraZoomBackground )
	SetScale({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 5 })
	SetColor({ Ids = { ScreenAnchors.EphyraZoomBackground }, Color = Color.Black })
	SetAlpha({ Ids = { ScreenAnchors.EphyraZoomBackground }, Fraction = 0, Duration = 0 })

	PlayInteractAnimation( usee.ObjectId )

	--FocusCamera({ Fraction = 0.195, Duration = 1, ZoomType = "Ease" })
	--PanCamera({ Id = 664260, Duration = 1.0, EaseIn = 0.3, EaseOut = 0.3 })

	wait(0.3)
	local notifyName = "ephyraZoomBackIn"
	NotifyOnControlPressed({ Names = { "Use", "Rush", "Shout", "Attack2", "Attack1", "Attack3", "AutoLock", "Cancel", }, Notify = notifyName })
	waitUntil( notifyName )
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShort" })

	--FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.0, Duration = 0.5, ZoomType = "Ease" })
	--PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5 })

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 0.5 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 0.5 })
	SetAlpha({ Ids = { ScreenAnchors.EphyraZoomBackground, ScreenAnchors.MelIconId, ScreenAnchors.EphyraMapId, }, Fraction = 0, Duration = 0.25 })
	SetAlpha({ Ids = attachedCircles, Fraction = 0, Duration = 0.15 })
	SetAlpha({ Ids = letterboxIds, Fraction = 0, Duration = 0.15 })
	Destroy({ Ids = attachedCircles })
	
	local exitDoorsIPairs = CollapseTableOrdered( MapState.OfferedExitDoors )
	for index, door in ipairs( exitDoorsIPairs ) do
		if not door.SkipUnlock then
			SetScale({ Id = door.DoorIconId, Fraction = 1, Duration = 0.15 })
			AddToGroup({ Id = door.DoorIconId, Name = "FX_Standing_Top", DrawGroup = true })
		end
	end

	Destroy({ Id = cameraTargetId })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = 0, Duration = 0.65, EaseIn = 0, EaseOut = 0, Retarget = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.65, ZoomType = "Ease" })
	local roomData = RoomData[CurrentRun.CurrentRoom.Name]
	if not roomData.IgnoreClamps then
		local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
		DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })
		SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	end
	wait(0.45)

	thread( ShowCombatUI, "EphyraZoomOut" )
	--SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom, }, Fraction = 0, Duration = 0.25 })
	
	RemoveTimerBlock( CurrentRun, "EphyraZoomOut" )
	RemoveInputBlock({ Name = "EphyraZoomOut" })
	SessionMapState.BlockPause = false

	wait( 0.4 )
	Destroy({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom, ScreenAnchors.EphyraZoomBackground, ScreenAnchors.MelIconId, ScreenAnchors.EphyraMapId } })
	
	wait( 0.35 )
	SetPlayerVulnerable( "EphyraZoomOut" )
	UseableOn({ Id = usee.ObjectId })

	Destroy({ Ids = idsCreated })
	Destroy({ Ids = letterboxIds })
end

function ChooseMedeaIntroPresentation( room, args )
	wait( 0.01 )

	-- queue the boss intro text lines before checking requirements
	local enemy = nil
	if args.ProcessTextLinesIds ~= nil then
		for k, id in ipairs( args.ProcessTextLinesIds ) do
			if ActiveEnemies[id] ~= nil then
				enemy = ActiveEnemies[id]
				enemy.QueuedBossIntroTextLines = GetRandomEligibleTextLines( enemy, enemy.BossIntroTextLineSets, GetNarrativeDataValue( enemy, "BossIntroTextLinePriorities" ) )
				break
			end
		end
	end

	if enemy ~= nil and IsGameStateEligible( enemy, args.AlreadyPresentRequirements ) then
		MedeaIntroPresentation_AlreadyPresent( room, args )
	else
		MedeaIntroPresentation( room, args )
	end
end

function MedeaIntroPresentation( room, args )
	SetAlpha({ Id = args.MedeaId, Fraction = 0, Duration = 0.01 })
	wait( args.Delay )
	CreateAnimation({ Name = "MedeaTeleportFx", DestinationId = args.MedeaId, })
	SetAnimation({ DestinationId = args.MedeaId, Name = "Enemy_Medea_TeleportIn_Slow" })
	SetGoalAngle({ Id = args.MedeaId, Angle = args.Angle })
	SetAlpha({ Id = args.MedeaId, Fraction = 1, Duration = 0.2 })
end

function MedeaIntroPresentation_AlreadyPresent( room, args )
	SessionMapState.MedeaAlreadyPresent = true
	SetAlpha({ Id = args.MedeaId, Fraction = 1, Duration = 0.0 })
	SetGoalAngle({ Id = args.MedeaId, Angle = args.Angle })
end

function DestroyEphyraBarrier( room, args )
	Destroy({ Ids = GetIds({ Names = args.Groups }) })
end