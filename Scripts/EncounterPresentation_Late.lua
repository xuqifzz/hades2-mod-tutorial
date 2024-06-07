function DevotionTestPresentation()

	HideCombatUI("Devotion")
	thread( DisplayInfoBanner, nil, { AnimationName = "LocationBackingIrisGenericIn", AnimationOutName = "LocationBackingIrisGenericOut", Text = "DevotionMessage", Delay = 0.95 } )
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	AdjustColorGrading({ Name = "Devotion", Duration = 1.0 })
	local devotionSoundId = PlaySound({ Name = "/SFX/GodFavorBattleStart" })
	SetVolume({ Id = devotionSoundId, Value = 0.3 })

	wait(3.5)
	AdjustColorGrading({ Name = "Off", Duration = 2.0 })
	StopSound({ Id = devotionSoundId, Duration = 2.0 })
	wait(2.0)
	ShowCombatUI("Devotion")
end

function InvasionEncounterStartPresentation( eventSource, tollTimes, colorGrade, colorFx, playerGlobalVoiceLines, opponentGlobalVoiceLines )
	local survivalEncounter = eventSource

	AdjustColorGrading({ Name = colorGrade or "Alert", Duration = 0 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = colorFx or "FullscreenAlertColor", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	AdjustFullscreenBloom({ Name = "AlertBloom", Duration = 0.25 })

	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	local chronosOverlay = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX - 420, Y = ScreenCenterY, Group = "Events" })
	SetScale({ Id = chronosOverlay, Fraction = 1 })
	SetAlpha({ Id = chronosOverlay, Fraction = 0.0, Duration = 0 })
	Move({ Id = chronosOverlay, Angle = 270, Speed = 5 })

	SetAnimation({ Name = "ChronosOverlay", DestinationId = chronosOverlay })

	if not CurrentRun.CurrentRoom.BlockHadesOverlay then
		SetAlpha({ Id = chronosOverlay, Fraction = 1.0, Duration = 0 })
	end

	wait( 0.4, RoomThreadName )

	if playerGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[playerGlobalVoiceLines], true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.InvasionAboutToStartVoiceLines, true )
	end

	wait( 1.4, RoomThreadName )
	local source = {} -- Dummy source for disembodied voice
	source.SubtitleColor = Color.ChronosVoice
	if opponentGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[opponentGlobalVoiceLines], false, source )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.InvasionEncounterStartVoiceLines, false, source )
	end

	thread( HadesVoicelineBlur )
	AdjustFullscreenBloom({ Name = "NewType10", Duration = 1.4 })
	PlaySound({ Name = "/SFX/SurvivalChallengeStart" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )

	local activeStemTable = { "Guitar", "Bass", "Drums" }
	SetSoundCueValue({ Names = activeStemTable, Id = AudioState.MusicId, Value = 1, Duration = 0.75 })

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = chronosOverlay, Fraction = 0.0, Duration = 1 })
	wait( 1.0, RoomThreadName )
	Destroy({ Id = chronosOverlay })
	Destroy({ Ids = { fullscreenAlertColorFx, fullscreenAlertDisplacementFx } })
end

function SurvivalEncounterStartPresentation( eventSource, tollTimes, colorGrade, colorFx, playerGlobalVoiceLines, opponentGlobalVoiceLines )
	local survivalEncounter = eventSource

	AdjustColorGrading({ Name = colorGrade or "Alert", Duration = 0 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = colorFx or "FullscreenAlertColor", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	AdjustFullscreenBloom({ Name = "AlertBloom", Duration = 0.25 })

	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	--[[local hadesOverlay = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX - 420, Y = ScreenCenterY, Group = "Events" })
	SetScale({ Id = hadesOverlay, Fraction = 1 })
	SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 0 })
	Move({ Id = hadesOverlay, Angle = 270, Speed = 5 })

	SetAnimation({ Name = "HadesOverlay", DestinationId = hadesOverlay })

	if not CurrentRun.CurrentRoom.BlockHadesOverlay then
		SetAlpha({ Id = hadesOverlay, Fraction = 1.0, Duration = 0 })
	end]]

	wait( 0.4, RoomThreadName )

	thread( PlayVoiceLines, GlobalVoiceLines.ChallengeEncounterEnemySightedVoiceLines, true )

	--[[wait( 1.4, RoomThreadName )
	local source = {} -- Dummy source for disembodied voice
	source.SubtitleColor = Color.HadesVoice
	if opponentGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[opponentGlobalVoiceLines], false, source )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.SurvivalEncounterStartVoiceLines, false, source )
	end]]

	--thread( HadesVoicelineBlur )
	for index = 1, tollTimes or 3, 1 do
		SurvivalTollPulse()
	end
	AdjustFullscreenBloom({ Name = "NewType10", Duration = 1.4 })
	PlaySound({ Name = "/SFX/SurvivalChallengeStart" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )
	if tollTimes == 0 then
		wait( 2.4, RoomThreadName )
	else
		wait( 1.4, RoomThreadName )
	end

	local activeStemTable = { "Guitar", "Bass", "Drums" }
	SetSoundCueValue({ Names = activeStemTable, Id = AudioState.MusicId, Value = 1, Duration = 0.75 })

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	--SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 1 })
	wait( 1.0, RoomThreadName )
	--Destroy({ Id = hadesOverlay })
	Destroy({ Ids = { fullscreenAlertColorFx, fullscreenAlertDisplacementFx } })
end

function FloodEncounterStartPresentation( eventSource )

	-- PlaySound({ Name = "/Leftovers/SFX/StandardAscensionSFX" })
	-- PlaySound({ Name = "/SFX/Player Sounds/PoseidonWaterImpactDetonate" })

	if AudioState.FloodSoundId == nil then
		AudioState.FloodSoundId = PlaySound({ Name = "/Leftovers/Object Ambiences/WaterRushingLarge" })
	end

	wait( 2.0, RoomThreadName )

	thread( PlayVoiceLines, HeroVoiceLines.TrapsActivatedVoiceLines, true )

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )
	thread( FloodEncounterStartEndAudio )
end

function FloodEncounterStartEndAudio()
	wait( 5.0, RoomThreadName )
	StopSound({ Id = AudioState.FloodSoundId, Duration = 5.0 })
	AudioState.FloodSoundId = nil
end

function FloodTrapFireStartPresentation()
	ShakeScreen({ Speed = 900, Distance = 1, FalloffSpeed = 2000, Duration = 5.8 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 7.1 }, } )
	PlaySound({ Name = "/SFX/FloodTrapPreFire" })

	local floodTraps = GetIdsByType({ Name =  "FloodTrap" })
	for k, unitId in pairs( floodTraps ) do
		if ActiveEnemies[unitId] ~= nil then
			Shake({ Id = unitId, Distance = 3, Speed = 300, Duration = 2.0 })
			Flash({ Id = unitId, MinFraction = 0, MaxFraction = 1.0, Speed = 4, Duration = 2.0, Color = Color.Red })
			PlaySound({ Id = unitId, Name = "/SFX/DusaHiss"})
		end
	end
	wait(2.0)
end

function FloodTrapFireEndPresentation()
	-- nothing yet!
end

function HadesVoicelineBlur( args )
	wait( 0.85, RoomThreadName )
	if args == nil or not args.BlockScreenshake then
		ShakeScreen({ Speed = 900, Distance = 8, FalloffSpeed = 2000, Duration = 1.05 })
	end
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 1.1 }, } )
	AdjustRadialBlurDistance({ Fraction = 0.4, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.4, Duration = 0.2 })
	wait( 1.3, RoomThreadName )
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.2 })
end

function SurvivalTollPulse()
	PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse" })
	ShakeScreen({ Speed = 300, Distance = 3, FalloffSpeed = 2000, Duration = 0.3 })
	AdjustColorGrading({ Name = "Alert", Duration = 0.02 })
	AdjustFullscreenBloom({ Name = "AlertBloom", Duration = 0.02 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	wait( 0.02, RoomThreadName )
	AdjustColorGrading({ Name = "Alert", Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	wait( 1.0, RoomThreadName )
end

function HeroicStandPulse( remainingPulses )
	PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse" })
	ShakeScreen({ Speed = 300, Distance = 3, FalloffSpeed = 2000, Duration = 0.3 })
	AdjustColorGrading({ Name = "Alert", Duration = 0.02 })
	AdjustFullscreenBloom({ Name = "AlertBloom", Duration = 0.02 })
	wait( 0.02, RoomThreadName )
	if remainingPulses <= 3 then
		AdjustColorGrading({ Name = "Off", Duration = 1 })
		AdjustFullscreenBloom({ Name = "Off", Duration = 1 })
	else
		AdjustColorGrading({ Name = "Off", Duration = 0.25 })
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.25 })
	end
end

function SurvivalObjectivePresentation( survivalEncounter )
	local playedHurryLines = false

	while survivalEncounter.RemainingTime > 0 and not survivalEncounter.TimeIsUp and not survivalEncounter.Completed do
		if survivalEncounter.RemainingTime <= 10 then
			if not playedHurryLines and survivalEncounter.TimeExpiringGlobalVoiceLines ~= nil then
				thread( PlayVoiceLines, GlobalVoiceLines[survivalEncounter.TimeExpiringGlobalVoiceLines], true )
				playedHurryLines = true
			end

			UpdateObjective( survivalEncounter.EncounterType, "RemainingSeconds", math.ceil(survivalEncounter.RemainingTime), {Pulse = true } )
			PlaySound({ Name = "/Leftovers/SFX/FieldReviveSFX" })
			wait( 1.0, RoomThreadName )
		else
			UpdateObjective( survivalEncounter.EncounterType, "RemainingSeconds", math.ceil(survivalEncounter.RemainingTime))
			PlaySound({ Name = "/Leftovers/SFX/PowerToggleNew" })
			wait( 1.0, RoomThreadName )
		end
	end
	UpdateObjective( survivalEncounter.EncounterType, "RemainingSeconds", 1)
end

function CapturePointEncounterStartPresentation( encounter, capturePointSwitch )

	SetAnimation({ Name = "MelinoeBoonInteractPowerUp", DestinationId = CurrentRun.Hero.ObjectId, AnimationSpeed = 0.5 })
	SetScale({ Id = capturePointSwitch.ObjectId, Fraction = 0.01, Duration = 0.75 })

	thread( PlayVoiceLines, HeroVoiceLines.AnomalyCombatBeginsVoiceLines, true )

	SecretMusicPlayer( "/Music/IrisTimedEncounterMusic" )

	-- thread( PlayVoiceLines, GlobalVoiceLines.ChallengeSwitchActivatedLines, true )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAnger" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )

	thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = GlobalVoiceLines.AnomalyCombatBeginsVoiceLines, StartSound = "/SFX/TimeSlowStart", StartDelay = 3 } )

	SurvivalEncounterStartPresentation( encounter, 0 )
	Destroy({ Id = capturePointSwitch.ObjectId })

end
function CapturePointEncounterEndPresentation( encounter )
	SetColor({ Id = encounter.CapturePointId, Color = { 0.5, 0.5, 1.0, 1.0 } })
	local rewardPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints" })
	CurrentRun.CurrentRoom.SpawnRewardOnId = rewardPointId
	Move({ Id = encounter.CapturePointId, DestinationId = rewardPointId, Speed = 400 })
	NotifyWithinDistance({ Id = encounter.CapturePointId, DestinationId = CurrentRun.CurrentRoom.SpawnRewardOnId, Distance = 100, Notify = "CapturePointEnd" })
	waitUntil( "CapturePointEnd" )

	SetScale({ Id = encounter.CapturePointId, Fraction = 0.01, Duration = 1.0, EaseIn = 0.05 })
	wait(1.0)
end


function WrappingEncounterStartPresentation( eventSource )
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end

	thread( HandleWrapping, eventSource )
	wait( 2.0, RoomThreadName )
	Activate({ Ids = { 548133, 548134 } })

	ShakeScreen({ Speed = 100, Distance = 2, FalloffSpeed = 2000, Duration = 3.0 })
	PlaySound({ Name = "/SFX/DeathBoatMoveStart" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 1.0 }, } )

	wait( 3.0, RoomThreadName )
	SecretMusicPlayer( "/Music/IrisMinibossMusic" )
	SetSoundCueValue({ Names = { "Section", }, Id = AudioState.SecretMusicId, Value = 2 })

	wait( 3.0, RoomThreadName )
end

function HandleWrapping( eventSource )
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end
	
	local room = eventSource
	local encounter = room.Encounter
	local wrappingData = RoomData[room.Name].WrappingData or encounter.WrappingData
	wrappingData.StartingIds = GetIds({ Name = wrappingData.StartingGroupName })
	wrappingData.EndingIds = GetIds({ Name = wrappingData.EndingGroupName })

	local offset = CalcOffset(math.rad(-155), -2000)
	Teleport({ Ids = wrappingData.EndingIds, DestinationIds = wrappingData.EndingIds, OffsetX = offset.X, OffsetY = offset.Y, ShiftThingsByOffset = true })

	--wait( 3.0, RoomThreadName )

	Move({ Ids = wrappingData.StartingIds, Angle = -155, Speed = 300, EaseIn = 0.5 })
	thread( DestroyOnDelay, wrappingData.StartingIds, 5.0 )

	if wrappingData.ObstacleWrapData ~= nil then
		for k, obstacleWrapData in pairs( wrappingData.ObstacleWrapData ) do
			if obstacleWrapData.Destroy then
				Destroy({ Ids = obstacleWrapData.Ids })
			else
				for k, id in pairs( obstacleWrapData.Ids ) do
					offset = CalcOffset(math.rad(-155), obstacleWrapData.ResetOffsetDistance)
					local resetTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = id, OffsetX = offset.X, OffsetY = offset.Y })
					obstacleWrapData.WrapCount = 0
					thread( WrapObstacle, id, obstacleWrapData, encounter, resetTargetId )
				end
			end
		end
	end

	local spawnData = wrappingData.SpawnData
	if spawnData ~= nil then
		if spawnData.PreSpawnObstacles then
			for i = 1, 5 do
				local nextObstacleName = GetRandomValue(spawnData.ObstacleNames)
				local nextSpawnDestination = GetRandomValue(spawnData.SpawnPoints)
				if not nextSpawnDestination.SkipPreSpawn then
					local offset = CalcOffset(math.rad(-155), i * 1750)
					local newObstacleId = SpawnObstacle({ Name = nextObstacleName, DestinationId = nextSpawnDestination.Id, Group = nextSpawnDestination.GroupName, OffsetX = offset.X, OffsetY = offset.Y })
					SetThingProperty({ Property = "StopsLight", Value = false, DestinationId = newObstacleId })
					SetThingProperty({ Property = "StopsUnits", Value = false, DestinationId = newObstacleId })
					if nextSpawnDestination.ObstacleHSVOverrides ~= nil and nextSpawnDestination.ObstacleHSVOverrides[nextObstacleName] ~= nil then
						SetHSV({ Id = newObstacleId, HSV = nextSpawnDestination.ObstacleHSVOverrides[nextObstacleName], ValueChangeType = "Absolute" })
					end
					if nextSpawnDestination.ObstacleColorOverrides ~= nil and nextSpawnDestination.ObstacleColorOverrides[nextObstacleName] ~= nil then
						SetColor({ Id = newObstacleId, Color = nextSpawnDestination.ObstacleColorOverrides[nextObstacleName], ValueChangeType = "Absolute" })
					end

					Move({ Id = newObstacleId, Angle = -155, Speed = spawnData.MoveSpeed or 500 })
					thread( DestroyOnDelay, { newObstacleId }, spawnData.MoveTime or 10 )
				end
			end
		end

		while true do
			local nextObstacleName = GetRandomValue(spawnData.ObstacleNames)
			local nextSpawnDestination = GetRandomValue(spawnData.SpawnPoints)
			local groupName = nextSpawnDestination.GroupName
			if nextSpawnDestination.ObstacleGroupOverrides ~= nil then
				groupName = nextSpawnDestination.ObstacleGroupOverrides[nextObstacleName] or groupName
			end
			local newObstacleId = SpawnObstacle({ Name = nextObstacleName, DestinationId = nextSpawnDestination.Id, Group = groupName })
			SetThingProperty({ Property = "StopsLight", Value = false, DestinationId = newObstacleId })
			SetThingProperty({ Property = "StopsUnits", Value = false, DestinationId = newObstacleId })
			if nextSpawnDestination.ObstacleHSVOverrides ~= nil and nextSpawnDestination.ObstacleHSVOverrides[nextObstacleName] ~= nil then
				SetHSV({ Id = newObstacleId, HSV = nextSpawnDestination.ObstacleHSVOverrides[nextObstacleName], ValueChangeType = "Absolute" })
			end
			if nextSpawnDestination.ObstacleColorOverrides ~= nil and nextSpawnDestination.ObstacleColorOverrides[nextObstacleName] ~= nil then
				SetColor({ Id = newObstacleId, Color = nextSpawnDestination.ObstacleColorOverrides[nextObstacleName], ValueChangeType = "Absolute" })
			end
			Move({ Id = newObstacleId, Angle = -155, Speed = spawnData.MoveSpeed or 500 })
			thread( DestroyOnDelay, { newObstacleId }, spawnData.MoveTime or 10 )

			local nextSpawnInterval = RandomFloat( spawnData.SpawnIntervalMin, spawnData.SpawnIntervalMax )
			wait(nextSpawnInterval, RoomThreadName)
		end
	end
end

function WrapObstacle( id, obstacleWrapData, encounter, resetTargetId )

	local moveTime = obstacleWrapData.MoveTime
	if obstacleWrapData.WrapCount == 0 then
		wait( obstacleWrapData.FirstWrapDelay, RoomThreadName )
		moveTime = obstacleWrapData.FirstMoveTime or moveTime
	else
		Teleport({ Id = id, DestinationId = resetTargetId })
	end

	Move({ Id = id, Angle = -155, Speed = obstacleWrapData.MoveSpeed or 500 })
	wait( moveTime, RoomThreadName )


	obstacleWrapData.WrapCount = obstacleWrapData.WrapCount + 1
	thread( WrapObstacle, id, obstacleWrapData, encounter, resetTargetId )

end

function WrappingEncounterEndPresentation( eventSource )
	ShakeScreen({ Speed = 100, Distance = 2, FalloffSpeed = 2000, Duration = 4.0 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 1.0 }, } )
	PlaySound({ Name = "/Leftovers/SFX/AnnouncementThunder" })
	PlaySound({ Name = "/SFX/PillarDestroyed" })

	SetSoundCueValue({ Names = { "Section", }, Id = AudioState.SecretMusicId, Value = 10 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

	local wrappingData = eventSource.WrappingData
	for k, obstacleWrapData in pairs( wrappingData.ObstacleWrapData ) do
		Move({ Ids = obstacleWrapData.Ids, Angle = -155, Speed = 300, Distance = 900 })
	end

	for k, id in pairs(wrappingData.EndingIds) do
		local offset = CalcOffset(math.rad(-155), 2000)
		Move({ Id = id, DestinationId = id, OffsetX = offset.X, OffsetY = offset.Y, Duration = 3.0, EaseOut = 0.999 })
	end

	wait( 2.8, RoomThreadName )
	PlaySound({ Name = "/SFX/PillarDestroyed" })
	ShakeScreen({ Speed = 100, Distance = 2, FalloffSpeed = 2000, Duration = 1.0 })

	Destroy({ Ids = GetIds({ Name = "WaterEndingObjectsDestroy" }) })

	wait( 0.7, RoomThreadName )
	local murderBoatAnimation = "MurderBoatGateReverse"
	SetAnimation({ DestinationId = 548134, Name = murderBoatAnimation })
end


function IcarusExitPresentation( source, args )

	if not CurrentRun.Hero.IsDead and CurrentRun.CurrentRoom.Encounter.IcarusId == nil then
		return
	end

	args = args or {}
	
	UseableOff({ Id = source.ObjectId })
	source.SpecialInteractFunctionName = nil
	source.CanReceiveGift = false
	source.NextInteractLines = nil
	RefreshUseButton( source.ObjectId, source )

	wait( 2.5 )

	thread( PlayVoiceLines, source.ExitVoiceLines )

	StopSecretMusicTheme( source )

	wait( args.WaitTime or 0.5 )

	StopStatusAnimation( source )

	if not args.SkipAnim then
		--SetAnimation({ Name = "Artemis_Disappear", DestinationId = source.ObjectId })
		wait ( 1.65 )
	end
	CreateAnimation({ Name = "TeleportDisappear", DestinationId = source.ObjectId })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.35 })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = source.ObjectId, Property = "StopsProjectiles", Value = false })

	wait( 0.5, RoomThreadName )

	source.Mute = true
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[source.ObjectId] = args.AnimationState
	end

end

function IcarusPreSpawnPresentation( icarus, eventSource, args )

	wait(1)

	--PlaySound({ Name = "/SFX/ArtemisBoonChoice" })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedArthurChoir" })

	AdjustColorGrading({ Name = "Team06", Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.5 })

	for k, unit in pairs( ActiveEnemies ) do
		if unit.EncounterStartVoiceLines ~= nil then
			thread( PlayVoiceLines, unit.EncounterStartVoiceLines, nil, unit )
		end
	end

	thread( DisplayInfoBanner, nil, { Text = "IcarusMessage", Delay = 0.2, FadeColor = {1, 0, 0.7, 1} } )

	wait( 0.5, RoomThreadName )

	SecretMusicPlayer( icarus.ThemeMusic, { ParamNames = { "Keys", "Drums", } } )
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 0 })

	thread( function()
		wait( 0.5 )
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.5 })
		AdjustColorGrading({ Name = "Off", Duration = 3.0 })	
	end )
end

function IcarusAppearancePresentation( icarus )

	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })
	
	AngleTowardTarget({ Id = icarus.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "TeleportDisappear", DestinationId = icarus.ObjectId })
	
	wait( 0.1, RoomThreadName )

	SetAlpha({ Id = icarus.ObjectId, Fraction = 1.0, Duration = 0 })
	thread( PlayVoiceLines, icarus.EncounterEndVoiceLines, nil, icarus )

	wait( 0.4, RoomThreadName )
	
	--SetAnimation({ Name = "Artemis_Appear", DestinationId = icarus.ObjectId })

	wait( 1.0, RoomThreadName )	

end

function HeraclesPreSpawnPresentation( heracles )

end


function HeraclesSpawnPresentation( )

	HideCombatUI("HeraclesIntro")

	local encounter = CurrentRun.CurrentRoom.Encounter
	local heracles = ActiveEnemies[encounter.HeraclesId]
	local dummyTarget = ActiveEnemies[encounter.DummyTargetId]

	-- before arrival
	-- PlaySound({ Name = "/Leftovers/SFX/GoalScored" })

	local encounterData = EncounterData[encounter.Name]
	wait(encounterData.HeraclesSpawnWait or 1.5)

	local teleportId = nil
	if ActiveEnemies[dummyTarget.ObjectId] == nil then
		teleportId = SelectSpawnPoint(CurrentRun.CurrentRoom, heracles, { SpawnNearId = CurrentRun.Hero.ObjectId, SpawnRadius = 500, SpawnRadiusMin = 100 })
	else
		teleportId = dummyTarget.ObjectId
	end

	SetPlayerInvulnerable( "HeraclesSpawnPresentation" )

	Teleport({ Id = heracles.ObjectId, DestinationId = teleportId })
	SetAnimation({ DestinationId = heracles.ObjectId, Name = "Heracles_Combat_Taunt" })

	-- wait( 0.2 )

	ObeyGravity({ Id = heracles.ObjectId })
	ApplyUpwardForce({ Id = heracles.ObjectId, Speed = -3500 })

	PlaySound({ Name = "/SFX/Enemy Sounds/Heracles/EmotePowerCharging", Id = heracles.ObjectId })

	local preBloom = GetBloomSettingName({ })
	AdjustFullscreenBloom({ Name = "BlurryLight", Duration = 0.5 })

	Rumble({ Duration = 0.3, RightFraction = 0.17 })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.35 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.35 })

	wait( 0.5, RoomThreadName )

	SecretMusicPlayer( heracles.ThemeMusic )
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 0 })
	SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1 })

	PlaySound({ Name = "/SFX/Enemy Sounds/Heracles/EmotePowerAttacking", Id = heracles.ObjectId })

	thread( DisplayDamageText, dummyTarget, { DamageAmount = 9999, SourceProjectile = "Heracles", IsCrit = true } )
	thread( Kill, dummyTarget)

	PlaySound({ Name = "/SFX/StabSplatterEndSequence", Id = heracles.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGroundSlam", Id = heracles.ObjectId })
	CreateAnimation({ Name = "HydraTouchdownFx", DestinationId = heracles.ObjectId })

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1.5 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.5 })
	AdjustFullscreenBloom({ Name = preBloom, Duration = 1.5 })

	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 1.5 })

	AddInputBlock({ Name = "HeraclesSpawnPresentation" })
	SetPlayerInvulnerable( "HeraclesSpawnPresentation" )

	-- thread( PlayVoiceLines, HeroVoiceLines.HeraclesSpawningVoiceLines, true )

	-- after arrival

	PanCamera({ Ids = heracles.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	--[[
	SecretMusicPlayer( "/Music/IrisMusicShips1_MC" )
	SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })
	]]--

	thread( DisplayInfoBanner, nil, { Text = "HeraclesMessage", Delay = 0.25, Duration = 1.8, FadeColor = {0, 1, 0.7, 1} } )
	PlaySound({ Name = "/Leftovers/SFX/GoalScoredNEW" })

	AngleTowardTarget({ Id = heracles.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.3, RoomThreadName )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = heracles.ObjectId })

	thread( PlayVoiceLines, heracles.EntranceVoiceLines, nil, heracles )

	wait( 0.1, RoomThreadName )

	PanCamera({ Ids = heracles.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	wait( 0.2, RoomThreadName )

	ProcessTextLines( heracles, heracles.BossIntroTextLineSets )

	if GameState.TextLinesRecord.HeraclesCombat01 then
		wait( 2.2, RoomThreadName )
	else
		wait( 2.7, RoomThreadName )
	end

	RemoveInputBlock({ Name = "HeraclesSpawnPresentation" })
	SetPlayerVulnerable( "HeraclesSpawnPresentation" )

	local textLines = GetRandomEligibleTextLines( heracles, heracles.BossIntroTextLineSets, GetNarrativeDataValue( heracles, "BossIntroTextLinePriorities" ) )
	PlayTextLines( heracles, textLines )

	SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1 })

	-- SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 1 })
	-- SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })

	ShowCombatUI("HeraclesIntro")

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	SetPlayerVulnerable( "HeraclesSpawnPresentation" )

	SetupAI(heracles )
end

function HeraclesEncounterStartPresentation( heracles )

	for k, unit in pairs( ActiveEnemies ) do
		if unit.EncounterStartVoiceLines ~= nil then
			thread( PlayVoiceLines, unit.EncounterStartVoiceLines, nil, unit )
		end
	end

	wait( 0.8, RoomThreadName )
	-- PlaySound({ Name = "/SFX/Enemy Sounds/Minotaur/EmoteSustainedAttacking", Id = heracles.ObjectId })

	wait( 0.5, RoomThreadName )

end


function HeraclesEncounterEndPresentation( heracles )

	thread( PlayVoiceLines, heracles.EncounterEndVoiceLines, nil, heracles )
	SetAnimation({ DestinationId = heracles.ObjectId, Name = "Heracles_Hub_Idle_Start" })

	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 1 })

	wait(1.0)
	HeraclesObjectiveResultPresentation( heracles )

	CheckAvailableTextLines( heracles )
	SetAvailableUseText( heracles )

	if heracles.NextInteractLines == nil then
		local notifyName = "HeraclesDistance"
		NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = heraclesId, Distance = 150, Notify = notifyName })
		waitUntil( notifyName )
		HeraclesExit( heracles, { AnimationState = "NPCHeraclesExit", WaitTime = 3.0 })
	end	

end

function HeraclesObjectiveResultPresentation( heracles )
	local encounter = CurrentRun.CurrentRoom.Encounter
	wait(2.0)
	if encounter.PlayerMoneyObjective ~= nil and encounter.PlayerMoneyObjective > 0 then
		thread( PlayVoiceLines, heracles.EncounterLostVoiceLines, nil, heracles )
	end
	wait(1.5)
	if (encounter.HeraclesMoneyObjective or 0) > (encounter.PlayerMoneyObjective or 0) then
		-- Player loss
		thread( MarkObjectiveComplete, "HeraclesMoney" )
		wait(1.2)
		thread( MarkObjectiveComplete, "PlayerMoney" )
	else
		-- Player win
		thread( MarkObjectiveComplete, "PlayerMoney" )
		wait(1.2)
		thread( MarkObjectiveComplete, "HeraclesMoney" )
	end
end

function HeraclesExit( source, args )

	if not CurrentRun.Hero.IsDead and CurrentRun.CurrentRoom.Encounter.HeraclesId == nil then
		return
	end

	args = args or {}

	local heraclesId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Heracles_01" })
	local heracles = ActiveEnemies[heraclesId]

	if heracles == nil then
		return
	end

	UseableOff({ Id = heracles.ObjectId })
	heracles.SpecialInteractFunctionName = nil
	heracles.CanReceiveGift = false

	thread( PlayVoiceLines, heracles.ExitVoiceLines )
	wait( args.WaitTime or 3 )

	CreateAnimation({ Name = "TeleportDisappear", DestinationId = heracles.ObjectId })
	SetAlpha({ Id = heracles.ObjectId, Fraction = 0.0, Duration = 0.35 })

	heracles.NextInteractLines = nil
	heracles.Mute = true
	UseableOff({ Id = heracles.ObjectId })
	MapState.RoomRequiredObjects[heracles.ObjectId] = nil
	SetUnitProperty({ DestinationId = heracles.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = heracles.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = heracles.ObjectId, Property = "StopsProjectiles", Value = false })
	RefreshUseButton( heracles.ObjectId, heracles )
	StopStatusAnimation( heracles )

	StopSecretMusicTheme( heracles )

	wait( 0.5, RoomThreadName )
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[heracles.ObjectId] = args.AnimationState
	end

	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function HeraclesRequiredKillPresentation ( encounter, victim, killer )
	if CurrentRun.ActiveObjectives.HeraclesMoney == nil then
		CheckObjectiveSet( "HeraclesChallenge" )
	end
	--InCombatText( victim.ObjectId, "HeraclesKillBounty", 0.8, { LuaKey = "Amount", LuaValue = victim.HeraclesCombatMoneyValue }  )
	local objectiveId = CurrentRun.ActiveObjectives.HeraclesMoney.ObjectId
	local objectiveValue = encounter.HeraclesMoneyObjective
	if killer == CurrentRun.Hero then
		objectiveId = CurrentRun.ActiveObjectives.PlayerMoney.ObjectId
		objectiveValue = encounter.PlayerMoneyObjective
	end

	FlyTextToUI(
		encounter,
		{
			Amount = victim.HeraclesCombatMoneyValue,
			Text = "HeraclesKillBounty",
			IconPath = ResourceData.Money.IconPath,
			StartId = victim.ObjectId,
			EndId = objectiveId,
			SkipShadow = true,
			OffsetY = 150,
			OffsetX = 0,
			PopDuration = 0.4,
			EndOffsetX = 350,
		}
	)
	
	if killer == CurrentRun.Hero then
		UpdateObjectiveDescription( "PlayerMoney", "Objective_PlayerMoney", "PlayerMoney", objectiveValue )
	else
		UpdateObjectiveDescription( "HeraclesMoney", "Objective_HeraclesMoney", "HeraclesMoney", objectiveValue )
	end
	PulseText( {Id = objectiveId, ScaleOriginal = 0.4, ScaleTarget = 0.42, ScaleDuration = 0.1, HoldDuration = 0.0})
end

function MedeaMusicManager( eventSource, args )

	args = args or {}
	
	-- SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = args.SecretMusicSection or 0 })
	-- SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })

end

function NemesisSpawnPresentation( eventSource, nemesis )

	local encounter = eventSource
	SetAnimation({ Name = "Nemesis_Hub_Idle", DestinationId = nemesis.ObjectId })

	wait( 0.5, RoomThreadName )

	AddInputBlock({ Name = "NemesisSpawnPresentation" })
	SetPlayerInvulnerable( "NemesisSpawnPresentation" )

	-- this specifically affects NemesisCombat
	NemesisThemePresentation( eventSource, nemesis, { SkipBanner = true } )

	SetAnimation({ Name = "Nemesis_Hub_Equip", DestinationId = nemesis.ObjectId })
	AngleTowardTarget({ Id = nemesis.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	PanCamera({ Ids = nemesis.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3, Retarget = true })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	wait( 0.5, RoomThreadName )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = nemesis.ObjectId })

	wait( 2.5, RoomThreadName )

	RemoveInputBlock({ Name = "NemesisSpawnPresentation" })
	SetPlayerVulnerable( "NemesisSpawnPresentation" )
	ProcessTextLines( nemesis, nemesis.CombatIntroTextLineSets )
	nemesis.TextLinesUseWeaponIdle = true
	PlayRandomRemainingTextLines( nemesis, nemesis.CombatIntroTextLineSets )
end
function NemesisSpawnPresentationFields( eventSource )

	local nemesis = ActiveEnemies[eventSource.NemesisId]

	--HideCombatUI("NemesisIntro")
	SetPlayerInvulnerable( "NemesisSpawnPresentation" )

	SetAnimation({ DestinationId = nemesis.ObjectId, Name = "Nemesis_Combat_Idle" })

	AdjustZLocation({ Id = nemesis.ObjectId, Distance = 2500 })
	IgnoreGravity({ Id = nemesis.ObjectId })

	--PlaySound({ Name = "/SFX/Enemy Sounds/Heracles/EmotePowerCharging", Id = nemesis.ObjectId })

	local preBloom = GetBloomSettingName({ })
	AdjustFullscreenBloom({ Name = "BlurryLight", Duration = 0.5 })

	Rumble({ Duration = 0.3, RightFraction = 0.17 })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.35 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.35 })

	wait( 0.5, RoomThreadName )

	-- this specifically affects NemesisCombat
	NemesisThemePresentation( eventSource, nemesis, { SkipBanner = true } )
	
	ObeyGravity({ Id = nemesis.ObjectId })
	ApplyUpwardForce({ Id = nemesis.ObjectId, Speed = -3500 })
	PlaySound({ Name = "/SFX/Player Sounds/MelWhooshDropIn", Id = nemesis.ObjectId })

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1.5 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.5 })
	AdjustFullscreenBloom({ Name = preBloom, Duration = 1.5 })

	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 1.5 })

	AddInputBlock({ Name = "NemesisSpawnPresentation" })

	-- after arrival

	PanCamera({ Ids = nemesis.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	PlaySound({ Name = "/Leftovers/SFX/GoalScoredNEW" })

	wait( 0.5, RoomThreadName )

	PanCamera({ Ids = nemesis.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	AngleTowardTarget({ Id = nemesis.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.35, RoomThreadName )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = nemesis.ObjectId })

	wait( 4, RoomThreadName )

	RemoveInputBlock({ Name = "NemesisSpawnPresentation" })
	SetPlayerVulnerable( "NemesisSpawnPresentation" )

	ProcessTextLines( nemesis, nemesis.CombatIntroTextLineSets )
	nemesis.TextLinesUseWeaponIdle = true
	PlayRandomRemainingTextLines( nemesis, nemesis.CombatIntroTextLineSets )

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })
end

function NemesisThemePresentation( eventSource, nemesis, args )

	args = args or {}
	
	wait( args.WaitTime, RoomThreadName )

	if not args.SkipBanner then
		PlaySound({ Name = "/SFX/ChaosBoonChoice" })

		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedLuciferChoir" })

		AdjustColorGrading({ Name = "Team03", Duration = 1.0 })
		AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.5 })

		thread( DisplayInfoBanner, nil, { Text = "NemesisMessage", Delay = 0.2, TextColor = Color.Fuchsia, FadeColor = {0, 1, 0.7, 1}, AnimationName = "LocationBackingIrisGenericIn", AnimationOutName = "LocationBackingIrisGenericOut", FontScale = 0.9 } )
	end
	thread( PlayVoiceLines, nemesis.SpawnVoiceLines, nil, nemesis )
	
	wait( 0.5, RoomThreadName )

	SecretMusicPlayer( nemesis.ThemeMusic )
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = args.SecretMusicSection or 0 })
	SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })

	thread( function()
		wait( 0.5 )
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.5 })
		AdjustColorGrading({ Name = "Off", Duration = 3.0 })	
	end )

end

function NemesisFieldsApproachPresentation( nemesis, args )
	args = args or {}
	AngleTowardTarget({ Id = nemesis.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = nemesis.TurnInPlaceAnimation, DestinationId = nemesis.ObjectId })

	if AudioState.SecretMusicName ~= nemesis.ThemeMusic then
		-- First approach
		SecretMusicPlayer( nemesis.ThemeMusic )
		SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = args.SecretMusicSection or 0 })
		SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 1 })
		SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })
	
		OverwriteSelf( nemesis, NPCVariantData.NemesisFieldsPreRandomEventCombat )
		SetupAI( nemesis )
	else
		-- Repeated approach
		PauseMusic( { Duration = args.MusicTransitionTime } )
		wait( args.MusicTransitionTime )
		ResumeSound({ Id = AudioState.SecretMusicId, Duration = args.MusicTransitionTime })
	end
end

function NemesisFieldsBackAwayFromPresentation( nemesis, args )
	args = args or {}
	PauseSound({ Id = AudioState.SecretMusicId, Duration = args.MusicTransitionTime })
	wait( args.MusicTransitionTime )
	ResumeMusic( { Duration = args.MusicTransitionTime } )
end

function NemesisPostTradeCheckExits( nemesis, args )
	args = args or {}
	wait( args.Delay )
	local requiredObjects = ShallowCopyTable( MapState.RoomRequiredObjects )
	if nemesis.ItemGiven ~= nil then
		requiredObjects[nemesis.ItemGiven.ObjectId] = nil
	end
	if not IsEmpty( requiredObjects ) then
		NemesisTeleportExitPresentation( nemesis, args )
	end
end

function NemesisPostFieldsCombatCheckExits( nemesis, args )
	args = args or {}
	wait( args.Delay )
	local requiredObjects = ShallowCopyTable( MapState.RoomRequiredObjects )
	requiredObjects[nemesis.ObjectId] = nil
	if IsEmpty( requiredObjects ) then
		NemesisTakeRoomExit( nemesis, args )
	else
		NemesisTeleportExitPresentation( nemesis, args )
	end
end

function NemesisEncounterStartPresentation( eventSource )
	local encounter = eventSource
	local nemesis = ActiveEnemies[encounter.NemesisId]

	CallFunctionName(encounter.SpawnPresentationFunction or "NemesisSpawnPresentation", encounter, nemesis)
	SetupAI( nemesis )

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1 })

	wait( 1.25, RoomThreadName )

	thread( PlayVoiceLines, nemesis.EncounterStartVoiceLines, nil, nemesis )
end

function NemesisEncounterEndPresentation( eventSource )
	local encounter = eventSource
	local nemesis = ActiveEnemies[encounter.NemesisId]

	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 1 })

	if nemesis == nil then -- Most likely if the player died during reward sequence
		return
	end
	
	killTaggedThreads( nemesis.AIThreadName )
	killWaitUntilThreads( nemesis.AINotifyName )
	SetAI("NemesisPostCombat", nemesis)
end

function NemesisBetPresentation( eventSource, args )
	args = args or {}
	local encounter = eventSource
	local nemesis = ActiveEnemies[encounter.NemesisId]

	if nemesis == nil then -- Most likely if the player died during reward sequence
		return
	end

	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 1 })

	if args.Result == "playerwin" then

		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "BetWinner", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, Duration = 1.5 } )
		CreateAnimation({ Name = "MoneyShower", DestinationId = CurrentRun.Hero.ObjectId })

	elseif args.Result == "playerloss" then

		thread( InCombatTextArgs, { TargetId = nemesis.ObjectId, Text = "BetWinner", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, Duration = 1.5 } )
		CreateAnimation({ Name = "MoneyShower", DestinationId = nemesis.ObjectId })

	end

end

-- see also: NemesisLeaveRoomPresentation / function NemesisExit
function NemesisTeleportExitPresentation( nemesis, args )
	args = args or {}

	local nemesisId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Nemesis_01" })
	local nemesis = nemesis or ActiveEnemies[nemesisId]
	nemesis.Exiting = true

	if not args.SkipVoice then
		thread( PlayVoiceLines, nemesis.ExitVoiceLines, nil, nemesis, { IgnoreMute = true } )
	end

	local delay = 0
	if args.DelayMin ~= nil and args.DelayMax ~= nil then
		delay = RandomFloat( args.DelayMin, args.DelayMax )
	end
	wait( delay )
	
	UseableOff({ Id = nemesis.ObjectId })
	nemesis.SpecialInteractFunctionName = nil
	nemesis.CanReceiveGift = false
	nemesis.Mute = true
	RemoveScreenEdgeIndicator( nemesis )

	SetAnimation({ Name = "Nemesis_Hub_Exit", DestinationId = nemesis.ObjectId })

	killTaggedThreads( nemesis.AIThreadName )
	killWaitUntilThreads( nemesis.AINotifyName )
	killWaitUntilThreads( "NemesisRandomEventGreeting" )

	StopSecretMusicTheme( nemesis )

	wait( 0.98 )
	SetUnitProperty({ DestinationId = nemesis.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = nemesis.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = nemesis.ObjectId, Property = "StopsProjectiles", Value = false })
	wait( 0.13 )
	SetAlpha({ Id = nemesis.ObjectId, Fraction = 0.0, Duration = 0 })

end

function CrowdReactionPresentation( args )

	if args.Chance ~= nil and RandomChance(args.Chance) then
		return
	end

	if not CheckCooldown( "CrowdReactionPresentationPlaying", 8.0 ) and not args.SkipCooldown then
		return
	end

	if args.Requirements ~= nil and not IsGameStateEligible( CurrentRun, args, args.Requirements ) then
		return
	end

	local reactionIds = nil
	if args.Ids ~= nil then
		reactionIds = args.Ids
	elseif args.Groups then
		reactionIds = GetIds({ Names = args.Groups })
	else
		reactionIds = GetIds({ Name = args.Group or "CrowdReaction" })
	end

	wait(args.Delay, RoomThreadName)

	if args.Sound ~= nil then
		PlaySound({ Name = args.Sound })
	end
	for k, id in pairs(reactionIds) do
		if RandomChance(args.ReactionChance) then
			local animationName = args.AnimationName
			if args.AnimationNames ~= nil then
				animationName = GetRandomValue(args.AnimationNames)
			end
			thread(PlayEmote, { TargetId = id, AnimationName = animationName, Shake = args.Shake } )
		end
	end

	if args.RadialBlur then
		AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.1 })
		AdjustRadialBlurStrength({ Fraction = 0.45, Duration = 0.1 })
	end

	wait(args.Duration or 0.8, RoomThreadName)

	if args.RadialBlur then
		AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.1 })
		AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.1 })
	end

	for k, enemy in pairs( ActiveEnemies ) do
		if enemy.CrowdReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.CrowdReactionVoiceLines, true, enemy )
		end
	end

end

function CrowdReactionPresentationEventSource( eventSource, args )
	CrowdReactionPresentation( args )
end

function ScyllaBoostPresentation( enemy, aiData )
	--[[AdjustColorGrading({ Name = colorGrade or "Alert", Duration = 0 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = colorFx or "FullscreenAlertColor", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	AdjustFullscreenBloom({ Name = "AlertBloom", Duration = 0.25 })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.6 })

	wait( 0.5, RoomThreadName )
	AdjustColorGrading({ Name = "AlectoRage", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )
	Destroy({ Ids = { fullscreenAlertColorFx, fullscreenAlertDisplacementFx } })]]

	local allyIds = GetIdsByType({ Names = { "SirenDrummer", "SirenKeytarist" } })
	for k, id in pairs(allyIds) do
		CreateAnimation({ DestinationId = id, Name = aiData.AllyBoostFx })
	end
	--[[AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })]]
end

function ScyllaBoostEndPresentation(enemy, aiData)
	local allyIds = GetIdsByType({ Names = { "SirenDrummer", "SirenKeytarist" } })
	for k, id in pairs(allyIds) do
		StopAnimation({ DestinationId = id, Name = aiData.AllyBoostFx })
	end
end

function FieldsEncounterActivatedPresentation( rewardCage, args )
	PlayInteractAnimation( rewardCage.ObjectId, { Animation = GetEquippedWeaponValue( "WeaponInteractAnimation" ) })
	thread( PlayVoiceLines, HeroVoiceLines.FieldsEncounterStartedVoiceLines, true )
	thread( FieldsEncounterStartPresentation )
	if MapState.FamiliarUnit ~= nil and MapState.FamiliarUnit.OnFieldsEncounterActivatedFunctionName ~= nil then
		thread( CallFunctionName, MapState.FamiliarUnit.OnFieldsEncounterActivatedFunctionName, MapState.FamiliarUnit )
	end
end

function FieldsEncounterStartPresentation( eventSource, args )
	local survivalEncounter = eventSource

	AdjustColorGrading({ Name = colorGrade or "Alert", Duration = 0 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = colorFx or "FullscreenAlertColor", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	AdjustFullscreenBloom({ Name = "AlertBloom", Duration = 0.25 })

	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	wait( 0.2, RoomThreadName )

	AdjustFullscreenBloom({ Name = "NewType10", Duration = 1.4 })
	PlaySound({ Name = "/SFX/SurvivalChallengeStart" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )
	
	wait( 0.2 )

	local roomData = RoomData[CurrentRun.CurrentRoom.Name]

	local musicSetup = RandomInt( 1, 3 )
	local randomStems = nil
	if musicSetup == 1 then
		randomStems = { "Drums", "Guitar" }
	elseif musicSetup == 2 then
		randomStems = { "Drums", "Bass", }
	elseif musicSetup == 3 then
		randomStems = { "Drums", "Guitar", "Bass", }
	end
	if AudioState.SecretMusicId == nil then
		ResumeMusic()
	end
	SetSoundCueValue({ Names = randomStems, Id = AudioState.MusicId, Value = 1, Duration = 0.75 })
	if AudioState.MusicSection == 0 then
		SetSoundCueValue({ Names = { "Section", }, Id = AudioState.MusicId, Value = 1 })
	end

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	wait( 0.2, RoomThreadName )
	Destroy({ Ids = { fullscreenAlertColorFx, fullscreenAlertDisplacementFx } })
end

function InfestedCerberusSetupPresentation( enemy )
	SetAlpha({ Id = enemy.ObjectId, Fraction = 0, Duration = 0 })
end

function InfestedCerberusSpawnPresentation( enemy )
	PanCamera({ Id = enemy.ObjectId, Duration = 2.0 })
	ShakeScreen({ Speed = 550, Distance = 7, FalloffSpeed = 800, Duration = 1.1, Angle = 0 })
	thread( DoRumble, { { ScreenPreWait = 0.04, LeftFraction = 0.17, Duration = 1.3 }, { ScreenPreWait = 1.5, RightFraction = 0.5, Duration = 0.6 } } )
	SetAlpha({ Id = enemy.ObjectId, Fraction = 1, Duration = 0.3 })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_InfestedCerberus_BurrowEmerge" })
	AdjustRadialBlurDistance({ Fraction = 10, Duration = 3.0 })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = 3.0 })
	wait(1.5)
	ShakeScreen({ Speed = 900, Distance = 12, FalloffSpeed = 600, Duration = 0.45, Angle = 90 })
	wait(1.5)
	PanCamera({ Ids = CurrentRun.Hero.ObjectId, Duration = 1.5 })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1.0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1.0 })
end

function ChronosMinorStageTransition( boss, currentRun, aiStage )
	Stop({ Id = boss.ObjectId })
	SetAnimation({ DestinationId = boss.ObjectId, Name = "Enemy_Chronos_Idle" })
	ExpireProjectiles({ Names = { "ChronosGrindWall", "ChronosGrindVacuum", } })
	BossStageTransition( boss, currentRun, aiStage )
end

function ChronosPhaseTransition( boss, currentRun, aiStage )
	boss.InTransition = true

	-- this needs to be above the CurrentPhase transition
	thread( PlayVoiceLines, boss.PhaseEndedVoiceLines, nil, boss )

	boss.CurrentPhase = boss.CurrentPhase + 1

	Stop({ Id = boss.ObjectId })

	SetPlayerInvulnerable( "ChronosPhaseTransition" )
	AddInputBlock({ Name = "ChronosPhaseTransition" })
	HideCombatUI("ChronosPhaseTransition")

	DestroyRequiredKills( { BlockLoot = true, SkipIds = { boss.ObjectId }, BlockDeathWeapons = true } )
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	ClearEffect({ Ids = { boss.ObjectId }, All = true })
	if not IsEmpty( boss.StopAnimationsOnHitStun ) then
		StopAnimation({ Names = boss.StopAnimationsOnHitStun, DestinationId = boss.ObjectId, PreventChain = true })
	end
	SetAnimation({ Name = "Enemy_Chronos_Knockdown_Start", DestinationId = boss.ObjectId })
	SetGoalAngle({ Id = boss.ObjectId, Angle = 270 })
	thread( LastKillPresentation, boss )

	SetMusicSection( 1 )

	PanCamera({ Id = boss.ObjectId, Duration = 1.20 })

	thread( SetHeroAngleWithMoveOrder, { ObjectId = boss.ObjectId, Timeout = 0.405 } )

	wait( 1.25, boss.AIThreadName )

	local textLines = GetRandomEligibleTextLines( boss, boss.BossPhaseChangeTextLineSets, GetNarrativeDataValue( boss, "BossPhaseChangeTextLinePriorities" ) )
	boss.TextLinesUseWeaponIdle = true
	PlayTextLines( boss, textLines )

	thread( PlayVoiceLines, boss.NextPhaseVoiceLines, nil, boss )

	wait( 1.12, RoomThreadName )

	SetAnimation({ Name = "Enemy_Chronos_Teleport_Disappear", DestinationId = boss.ObjectId })

	wait( 1.1, RoomThreadName )
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3Distance" })

	ScreenAnchors.PhaseTransitionBG = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI_World_Backing", X = ScreenCenterX, Y = ScreenCenterY })
	local uniformAspectScale = ScreenScaleX
	if ScreenScaleY > ScreenScaleX then 
		uniformAspectScale = ScreenScaleY
	end
	if not ScreenState.NativeAspetRatio then
		uniformAspectScale = uniformAspectScale + 0.1 -- Scaling isn't pixel-perfect, add some buffer
	end
	SetScale({ Id = ScreenAnchors.PhaseTransitionBG, Fraction = uniformAspectScale })
	SetAnimation({ DestinationId = ScreenAnchors.PhaseTransitionBG, Name = "RoomTransitionIn" })

	RemoveFromGroup({ Id = boss.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = boss.ObjectId, Name = "Combat_Menu", DrawGroup = true })

	wait( 0.8, RoomThreadName )

	if boss.CurrentPhase == 2 then
		if CurrentRun.Hero.Weapons.WeaponLob then
			ReloadAmmo({Name = "WeaponLob"})
			UpdateWeaponAmmo( "WeaponLob", 0 )
			thread( UpdateAmmoUI )
			ExpireProjectiles({ Names = {"ProjectileLobCharged", "ProjectileLob"}, BlockSpawns = true})
			Destroy({ Ids = GetIdsByType({ Name = "LobAmmoPack"})  })
		end
		Activate({ Name = "SpawnPointsPhase2" })
		Destroy({ Ids = GetIds({ Name = "SpawnPointsPhase1" }) })
		Teleport({ Id = boss.ObjectId, DestinationId = 625757 })
		Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 645921 })
		if MapState.FamiliarUnit ~= nil then
			Teleport({ Id = MapState.FamiliarUnit.ObjectId, DestinationId = 645983 })
			AngleTowardTarget({ Id = MapState.FamiliarUnit.ObjectId, DestinationId = boss.ObjectId })
		end
		SetCameraClamp({ Ids = GetIds({ Name = "CameraClamps2" }), SoftClamp = 0.75 })
	end

	wait( 0.5, boss.AIThreadName )

	SetMusicSection( 2 )

	SetAnimation({ Name = "MelinoeIdle", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = boss.ObjectId })

	SetAnimation({ DestinationId = ScreenAnchors.PhaseTransitionBG, Name = "RoomTransitionOut" })

	wait(0.3, boss.AIThreadName)

	boss.MaxHealth = aiStage.NewMaxHealth or boss.MaxHealth
	boss.Health = boss.MaxHealth
	if aiStage.SetHealthPercent ~= nil then
		boss.Health = boss.Health * aiStage.SetHealthPercent
	end
	BossHealthBarPresentation( boss )

	wait(1.0, boss.AIThreadName)

	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.0 })
	RemoveInputBlock({ Name = "ChronosPhaseTransition" })
	SetPlayerVulnerable( "ChronosPhaseTransition" )
	ShowCombatUI("ChronosPhaseTransition")
	
	RemoveFromGroup({ Id = boss.ObjectId, Names = { "Combat_Menu" } })
	AddToGroup({ Id = boss.ObjectId, Name = "Standing", DrawGroup = true })
	
	--[[ Fire passive weapons
	if aiStage.DumbFireWeapons ~= nil then
		for k, weaponName in pairs(aiStage.DumbFireWeapons) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, boss, currentRun, weaponData )
		end
	end]]
	SetThingProperty({ Property = "GrannyMaskAlpha", Value = 1.0, DestinationId = boss.ObjectId })
	SetUnitVulnerable( boss )
	wait(0.5, boss.AIThreadName)
	boss.InTransition = false
end
