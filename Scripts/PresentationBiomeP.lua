
function RoomEntranceBossPrometheus( currentRun, currentRoom, args )
	args = args or {}

	local prometheusId = GetIdsByType({ Name = "Prometheus" })[1]
	local eagleId = GetIdsByType({ Name = "Eagle" })[1]

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter

	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	wait(0.03)

	FadeIn({ Duration = 0.0 })
	
	FullScreenFadeInAnimation( roomData.EnterWipeAnimation or GetDirectionalWipeAnimation( { TowardsId = currentRoom.HeroEndPoint, Enter = true } ) )

	if currentRoom.EnterSound ~= nil then
		PlaySound({ Name = currentRoom.EnterSound, Id = currentRoom.HeroStartPoint })
	end
	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, AngleTowardsIdOnEnd = prometheusId } )
	end
	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomData.IntroCameraPanDuration or roomIntroSequenceDuration })
	end

	wait(0.2)

	thread( PlayVoiceLines, encounterData.EnterVoiceLines or roomData.EnterVoiceLines or GlobalVoiceLines[roomData.EnterGlobalVoiceLines], true )

	wait(1.3)

	SetAnimation({ Name = "Enemy_Prometheus_IntroCall_Start", DestinationId = prometheusId })

	wait(1.35)

	SetAnimation({ Name = "Enemy_Prometheus_IntroCatch_Start", DestinationId = prometheusId })
	SetAnimation({ Name = "Enemy_Eagle_SpiralCatch", DestinationId = eagleId })

	UnblockCombatUI("BossEntrance")
end

function PrometheusBattleStart( prometheus, args )
	SetupComboPartners(prometheus, args)
	TriggerCooldown("PrometheusForesight")

	prometheus.WeaponName = "PrometheusIntro"
	local aiData = ShallowCopyTable(prometheus.DefaultAIData) or prometheus
	if WeaponData[prometheus.WeaponName] ~= nil and WeaponData[prometheus.WeaponName].AIData ~= nil then
		OverwriteTableKeys( aiData, WeaponData[prometheus.WeaponName].AIData)
	end
	aiData.WeaponName = prometheus.WeaponName

	DoAttackerAILoop( prometheus, aiData )
end

function EagleBattleStart( eagle, args )
	SetupComboPartners(eagle, args)

	eagle.WeaponName = "EagleIntro"
	local aiData = ShallowCopyTable(eagle.DefaultAIData) or eagle
	if WeaponData[eagle.WeaponName] ~= nil and WeaponData[eagle.WeaponName].AIData ~= nil then
		OverwriteTableKeys( aiData, WeaponData[eagle.WeaponName].AIData)
	end
	aiData.WeaponName = eagle.WeaponName

	DoAttackerAILoop( eagle, aiData )
end

function HeraclesIntroPresentation( heracles, args )
	SetAnimation({ Name = "Heracles_Combat_Idle_Start", DestinationId = heracles.ObjectId })
end

function PrometheusForesightPresentation(enemy, aiData, args)

	waitUnmodified(0.1)

	FocusCamera({ Fraction = 0.92, Duration = 0.5, ZoomType = "Ease" })
	PanCamera({ Ids = { enemy.ObjectId, CurrentRun.Hero.ObjectId}, Duration = 0.5, EaseIn = 0, EaseOut = 0.1 })

	waitUnmodified(0.1)

	thread( InCombatText, enemy.ObjectId, "Combat_PrometheusDodge", 1.25, { OffsetY = -220 } )
	PlaySound({ Name = "/SFX/Enemy Sounds/Prometheus/EmoteAttackingRanged", Id = enemy.ObjectId })

	waitUnmodified(0.1)

	AddSimSpeedChange( "PrometheusForesightPresentation", { Fraction = 0.05, LerpTime = 0.0001, Priority = true } )

	waitUnmodified(0.75)

	RemoveSimSpeedChange( "PrometheusForesightPresentation", { LerpTime = 0.4 } )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5, EaseIn = 0, EaseOut = 0.1, FromCurrentLocation = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 0.4, ZoomType = "Ease" })
	SetUnitVulnerable(enemy, "PrometheusForesight")
end

function HeraclesMemoryBreak( prometheus, args )
	local heraclesId = GetIdsByType({ Name = "Heracles" })[1]
	local heracles = ActiveEnemies[heraclesId]

	if heracles == nil then
		return
	end

	ClearEffect({ Id = heraclesId, Name = "HeraclesFireRotationDampening" })
	heracles.ChainedWeapon = nil
	heracles.ChainedWeaponOptions = nil
	heracles.ForcedWeaponInterrupt = args.HeraclesWeapon
end

function PrometheusKillPresentation( unit, args )

	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})
	if ActiveEnemies[unit.ComboPartnerId] ~= nil then
		thread( Kill, ActiveEnemies[unit.ComboPartnerId], { BlockRespawns = true } )
	end
	if not IsEmpty( unit.StopAnimationsOnHitStun ) then -- since hit stun isn't applied on death
		StopAnimation({ Names = unit.StopAnimationsOnHitStun, DestinationId = unit.ObjectId, PreventChain = true })
		if unit.FxTargetIdsUsed ~= nil then
			for id, v in pairs( unit.FxTargetIdsUsed ) do
				StopAnimation({ Names = unit.StopAnimationsOnHitStun, DestinationId = id, PreventChain = true })
			end
		end
	end

	SetUnitInvulnerable( unit )
	CurrentRun.BossHealthBarRecord[unit.Name] = 0

	SetPlayerInvulnerable( "PrometheusKillPresentation" )
	AddInputBlock({ Name = "PrometheusKillPresentation" })
	AddTimerBlock( CurrentRun, "PrometheusKillPresentation" )
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen, nil, { IgnoreHUDShow = true } )
	end

	EndMusic()
	thread( LastKillPresentation, unit )
	Stop({ Id = unit.ObjectId })
	SetGoalAngle({ Id = unit.ObjectId, Angle = 210 })
	if not unit.KnockedOut then
		SetAnimation({ Name = "Enemy_Prometheus_Death_Start", DestinationId = unit.ObjectId })
	end
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId })

	if GameState.TextLinesRecord.PrometheusBossOutro01 then
		wait( 2.8, RoomThreadName )
	else
		wait( 3.5, RoomThreadName )
	end

	local textLines = GetRandomEligibleTextLines( unit, unit.BossOutroTextLineSets, GetNarrativeDataValue( unit, "BossOutroTextLinePriorities" ) )
	unit.TextLinesUseWeaponIdle = nil
	PlayTextLines( unit, textLines )

	SetCameraClamp({ Ids = GetIds({ Name = "CameraClamps" }), SoftClamp = 0.75 })

	thread( PlayVoiceLines, unit.DefeatedVoiceLines, true, unit )

	StopAnimation({ Name = "PrometheusFistFire", DestinationId = unit.ObjectId })
	CreateAnimation({ Name = "PrometheusFistFire_Death", DestinationId = unit.ObjectId })
	GenericBossKillPresentation( unit, args )
	SetAnimation({ Name = "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })

	PlaySound({ Name = "/SFX/TimeSlowStart" })

	wait( 2.0 )

	RemoveInputBlock({ Name = "PrometheusKillPresentation" })
	RemoveTimerBlock( CurrentRun, "PrometheusKillPresentation" )
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false

	ClearCameraClamp({ LerpTime = 1.0 }) -- the map bounds are more restrictive during the fight

end

function HeraclesKillPresentation( unit, args )
	Stop({ Id = unit.ObjectId })
	SetAnimation({ Name = "Heracles_Combat_Idle_Start", DestinationId = unit.ObjectId })

	StopSecretMusicTheme( unit )

	wait( 1.55 )

	thread(LastKillPresentation, unit)
	SetAnimation({ Name = "Heracles_Combat_LeapExit", DestinationId = unit.ObjectId })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 1 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1 })

	wait ( 0.62 )
	AdjustZLocation({ Id = unit.ObjectId, Distance = 2000 - GetZLocation({ Id = unit.ObjectId }), Duration = 0.2 })

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1.0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1.0 })

	ShakeScreen({ Speed = 200, Distance = 2, FalloffSpeed = 1000, Duration = 0.5 })

	local prometheusId = GetFirstValue(GetIdsByType({ Name = "Prometheus" }))
	if prometheusId ~= nil and ActiveEnemies[prometheusId] ~= nil and ActiveEnemies[prometheusId].KnockedOut then
		PanCamera({ Id = prometheusId, Duration = 1.0, OffsetY = ActiveEnemies[prometheusId].DeathPanOffsetY or 0 })
	end
end

function PlayPrometheusTauntAnim( source, args )
	if source ~= nil then
		--SetAnimation({ Name = "Enemy_Prometheus_Point_Alt", DestinationId = source.ObjectId })
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
	FullScreenFadeOutAnimation( "RoomTransitionIn_Up" )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "OlympusLeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function OlympusChronosPortalExitPresentation( currentRun, exitDoor )

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

	-- spawn Chronos
	local chronosId = 793059
	if ActiveEnemies[chronosId] == nil then
		ActivatePrePlaced( exitDoor, { Types = { "NPC_Chronos_02" } } )
		AngleTowardTarget({ Id = chronosId, DestinationId = CurrentRun.Hero.ObjectId })
		SetAlpha({ Id = chronosId, Fraction = 0, Duration = 0 })
		SetAlpha({ Id = chronosId, Fraction = 1, Duration = 0.3 })
		CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = chronosId })
	end

	thread( PlayVoiceLines, GlobalVoiceLines.ChronosLaunchVoiceLines, true, ActiveEnemies[chronosId] )

	PanCamera({ Id = exitDoor.ObjectId, Duration = 3.0, OffsetY = -200, FromCurrentLocation = true, Retarget = true })
	ClearCameraClamp({ LerpTime = 0.0 })

	CreateAnimation({ Name = "SandPortalOpen_Upward", DestinationId = exitDoor.ObjectId })

	local args = {}
	args.SuccessDistance = 20
	args.DisableCollision = true
	local exitPath = {}
	table.insert( exitPath, exitDoor.ObjectId )
	thread( MoveHeroAlongPath, exitPath, args )

	waitUnmodified (0.4)

	local jumpSound = PlaySound({ Name = "/SFX/BombFusePreExplode", Id = exitDoor.ObjectId })
	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 1.8 })
	Flash({ Id = exitDoorId, Speed = 0.65, MinFraction = 0, MaxFraction = 1.0, Color = Color.White, ExpireAfterCycle = true})

	waitUnmodified( 1.0 )

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Melinoe_CrossCast_Start_Fast", DestinationId = CurrentRun.Hero.ObjectId, })
	
	waitUnmodified( 0.18 )

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = CurrentRun.Hero.ObjectId })

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.25 }, } )
	SetAnimation({ Name = "MelinoeCrossCastHold", DestinationId = CurrentRun.Hero.ObjectId })
	ShakeScreen({ Speed = 400, Distance = 4, Angle = 0, FalloffSpeed = 1000, Duration = 1.0 })

	waitUnmodified( 0.05 )
	PanCamera({ Id = exitDoor.ObjectId, Duration = 0.5, OffsetY = -600, FromCurrentLocation = true, Retarget = true })
	PlaySound({ Name = "/SFX/OlympusJumpLaunchOnly" })
	StopSound({ Id = jumpSound, Duration = 0.2 })
	jumpSound = nil

	AdjustZLocation({ Id = CurrentRun.Hero.ObjectId, Distance = 1400, Duration = 0.35, })

	waitUnmodified( 0.12 )
	StopAnimation({ Name = "SandPortalTerrainLoop_Up", DestinationId = exitDoor.ObjectId })
	CreateAnimation({ Name = "SandPortalTerrainClose_Up", DestinationId = exitDoor.ObjectId })
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.032 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	LeaveRoomAudio( currentRun, exitDoor )
	if exitDoor.Room.ExitTowardsFunctionName ~= nil then
		CallFunctionName( exitDoor.Room.ExitTowardsFunctionName, exitDoor, exitDoor.Room.ExitTowardsFunctionArgs )
	end

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	wait(0.3)
	IgnoreGravity({ Id = CurrentRun.Hero.ObjectId })
	FullScreenFadeOutAnimation( "RoomTransitionIn_TimeWarp" )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "OlympusLeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function BiomeOverlookOlympus( room, args )
	if not MapState.InOverlook and IsEmpty(RequiredKillEnemies) then
		MapState.InOverlook = true

		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")
		AddInputBlock({ Name = "BiomeOverlookOlympus" })
		EndAutoSprint({ Halt = true, EndWeapon = true })

		wait( 0.1, "OverlookThread" )

		local cameraSpeed = args.CameraSpeed or 1260
		local zoomFraction = args.ZoomFraction or 0.9
		local initialDuration = args.InitialDuration or 1.2

		LockCamera({ Id = CurrentRun.Hero.ObjectId, Speed = cameraSpeed, OffsetY = -2000, Retarget = true })

		wait( initialDuration )

		OlympusOverlookFadeOutObjects()

		wait( 0.4 )

		FadeOut({ Color = Color.Black, Duration = 0.08 })

		wait( args.BlackDuration / 2 )

		FocusCamera({ Fraction = zoomFraction, Duration = 0, ZoomType = "Ease" })
		LockCamera({ Id = args.OverlookTargetStartId, OffsetY = 1200, Duration = 0, Retarget = true, EaseIn = 0 })
		wait(0.01)

		wait( args.BlackDuration / 2)

		FadeIn({ Duration = 0.1 })

		LockCamera({ Id = args.OverlookTargetStartId, Speed = cameraSpeed * 0.9, Acceleration = 800, Retarget = true })
		wait( 1.0 )
		LockCamera({ Id = args.OverlookTargetStartId, OffsetY = -3000, Speed = cameraSpeed * 0.32, Retarget = true, Acceleration = 5, FromCurrentLocation = true })

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

function DionysusMusicManager( eventSource, args )

	args = args or {}
	
	-- SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = args.SecretMusicSection or 0 })
	-- SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Sax" }, Id = AudioState.SecretMusicId, Value = 0 })

end

function DionysusChoiceScreenPresentation( source, args )

	args = args or {}

	SetSoundCueValue({ Names = { "Sax" }, Id = AudioState.SecretMusicId, Value = 1.0, Duration = 1.0 })
end

function DionysusRandomizeLeopards( source, args )
	local leopardIds = GetIdsByType({ Name = "NPC_LeopardGuest" })
	local leopardAnims = ShallowCopyTable( args.LeopardAnimations )
	for _, id in ipairs( leopardIds ) do
		SetAnimation({ DestinationId = id, Name = RemoveRandomValue( leopardAnims ) })
	end
end

function PrometheusMemoryIntroPresentation( prometheus, aiData, currentRun, args )

	if MapState.Aggressor ~= nil then
		MapState.Aggressor = "Heracles"
		MapState.AggressorLock = true
	end

	if not CurrentRun.CurrentRoom.PrometheusFireWaves then
		CurrentRun.CurrentRoom.PrometheusFireWaves = 0
	end
	CurrentRun.CurrentRoom.PrometheusFireWaves = CurrentRun.CurrentRoom.PrometheusFireWaves + 1

	local notifyName = "PrometheusNotify"
	local initialSpeed = GetUnitDataValue({ Id = prometheus.ObjectId, Property = "Speed" })
	prometheus.IgnoreSpeedMultiplier = true
	prometheus.AnimOffsetX = 120
	prometheus.AnimOffsetZ = -190
	prometheus.SpeakingStatusAnimation = "StatusIconSpeaking_Large"
	
	SetThreadWait(prometheus.AIThreadName.."Fuse", 0.01)
	ClearEffect({ Id = prometheus.ObjectId, All = true })
	EffectPostClearAll( prometheus )
	SetUnitInvulnerable( prometheus, "PrometheusMemoryPresentation" )
	SetUntargetable({ Id = prometheus.ObjectId })
	LockCameraMotion("Prometheus")

	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpPreFire", })

	AngleTowardTarget({ Id = prometheus.ObjectId, DestinationId = args.LandingId })
	wait(0.33)

	LockCamera({ Id = args.CameraTargetId, Duration = 1.25 })
	FocusCamera({ Fraction = 0.65, Duration = 1.25, ZoomType = "Ease" })
	ZeroMouseTether( "PrometheusMemory" )

	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpInAir", })

	thread( PlayVoiceLines, prometheus.MemoryAttackIntroVoiceLines, nil, prometheus )

	IgnoreGravity({ Id = prometheus.ObjectId })
	SetScale({ Id = prometheus.ObjectId, Fraction = args.Scale or 3, Duration = 0.3 })
	AdjustZLocation({ Id = prometheus.ObjectId, Distance = 450 - GetZLocation({ Id = prometheus.ObjectId }), Duration = 0.3 })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "Speed", Value = args.Speed or 4000 })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "CollideWithUnits", Value = false })
	Move({ Id = prometheus.ObjectId, Angle = GetAngleBetween({ Id = prometheus.ObjectId, DestinationId = args.LandingId }), Speed = args.Speed or 4000, DestinationId = args.LandingId })
	NotifyWithinDistance({ Id = prometheus.ObjectId, DestinationId = args.LandingId, Distance = 75, Notify = notifyName, Timeout = 5.0 })
	waitUntil( notifyName )

	RemoveFromGroup({ Id = prometheus.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = prometheus.ObjectId, Name = "Combat_Menu_TraitTray_Overlay_Text", DrawGroup = true })
	Stop({ Id = prometheus.ObjectId })
	Halt({ Id = prometheus.ObjectId })
	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpLand", })
	SetGoalAngle({ Id = prometheus.ObjectId, Angle = 145, CompleteAngle = true })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "Speed", Value = initialSpeed })
end

function PrometheusMemoryOutroPresentation( prometheus, aiData, currentRun, args )

	if MapState.Aggressor ~= nil then
		MapState.AggressorLock = nil
	end

	local notifyName = "PrometheusNotify"
	local initialSpeed = GetUnitDataValue({ Id = prometheus.ObjectId, Property = "Speed" })

	local landingId = GetRandomValue(args.LandingIds) or args.LandingId

	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_Memory_End", })
	wait( 1.0 )

	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpPreFire", })
	AngleTowardTarget({ Id = prometheus.ObjectId, DestinationId = landingId })
	wait(0.33)

	UnlockCameraMotion("Prometheus")
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.25 })
	FocusCamera({ Fraction = currentRun.CurrentRoom.ZoomFraction, Duration = 1.25, ZoomType = "Ease" })
	UnzeroMouseTether( "PrometheusMemory" )

	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpInAir", })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "Speed", Value = args.Speed or 4000 })
	Move({ Id = prometheus.ObjectId, DestinationId = landingId, Angle = GetAngleBetween({ Id = prometheus.ObjectId, DestinationId = landingId }), Speed = args.Speed or 4000 })
	SetScale({ Id = prometheus.ObjectId, Fraction = 1.0, Duration = 0.3 })
	NotifyWithinDistance({ Id = prometheus.ObjectId, DestinationId = landingId, Distance = 300, Notify = notifyName, Timeout = 5.0 })

	if CurrentRun.CurrentRoom.PrometheusFireWavesHit ~= nil and CurrentRun.CurrentRoom.PrometheusFireWavesHit > 0 then
		thread( PlayVoiceLines, prometheus.MemoryAttackOutroVoiceLines, nil, prometheus )
	else
		thread( PlayVoiceLines, prometheus.MemoryAttackPerfectOutroVoiceLines, nil, prometheus )
	end

	waitUntil( notifyName )	

	AddToGroup({ Id = prometheus.ObjectId, Name = "Standing", DrawGroup = true })
	RemoveFromGroup({ Id = prometheus.ObjectId, Names = { "Combat_Menu_TraitTray_Overlay_Text" } })
	AdjustZLocation({ Id = prometheus.ObjectId, Distance = 0 - GetZLocation({ Id = prometheus.ObjectId }), Duration = 0.15 })

	NotifyWithinDistance({ Id = prometheus.ObjectId, DestinationId = landingId, Distance = 75, Notify = notifyName, Timeout = 1.0 })
	waitUntil( notifyName )

	Stop({ Id = prometheus.ObjectId })
	Halt({ Id = prometheus.ObjectId })
	SetAnimation({ DestinationId = prometheus.ObjectId, Name = "Enemy_Prometheus_JumpLand", })
	AngleTowardTarget({ Id = prometheus.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "Speed", Value = initialSpeed })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "CollideWithObstacles", Value = true })
	SetUnitProperty({ DestinationId = prometheus.ObjectId, Property = "CollideWithUnits", Value = true })
	ObeyGravity({ Id = prometheus.ObjectId })
	SetTargetable({ Id = prometheus.ObjectId })
	SetUnitVulnerable( prometheus, "PrometheusMemoryPresentation" )
	SetUnitVulnerable(prometheus, "PrometheusForesight") -- In case PrometheusDashForesight got interrupted
	prometheus.IgnoreSpeedMultiplier = false
	prometheus.AnimOffsetX = EnemyData.Prometheus.AnimOffsetX
	prometheus.AnimOffsetZ = EnemyData.Prometheus.AnimOffsetZ
	prometheus.SpeakingStatusAnimation = EnemyData.Prometheus.SpeakingStatusAnimation
end

function PrometheusMemoryOnHit(victim, victimId, triggerArgs)
	CurrentRun.CurrentRoom.PrometheusFireWavesHit = CurrentRun.CurrentRoom.PrometheusFireWavesHit or 0
	CurrentRun.CurrentRoom.PrometheusFireWavesHit = CurrentRun.CurrentRoom.PrometheusFireWavesHit + 1
	if ProjectileData[triggerArgs.SourceProjectile].OnHitVoiceLines ~= nil then
		thread( PlayVoiceLines, ProjectileData[triggerArgs.SourceProjectile].OnHitVoiceLines, nil, triggerArgs.AttackerTable )
	end
end

function PrometheusSummonPresentation( prometheus, aiData, currentRun, args )

	local enemyData = EnemyData[args.SpawnName]
	enemyData.ActivateAnimation = nil
	enemyData.ActivateDuration = 0
	enemyData.WakeUpDelay = 2

	local flyByEnemy = DeepCopyTable( enemyData )
	flyByEnemy.ObjectId = SpawnUnit({ Name = args.SpawnName, Group = "Combat_Menu_TraitTray_Overlay_Text", DestinationId = args.HarpyStartId, })
	SetupUnit( flyByEnemy, currentRun )
	SetUnitInvulnerable({ Id = flyByEnemy.ObjectId })

	AdjustZLocation({ Id = flyByEnemy.ObjectId, Distance = args.ZHeight - GetZLocation({ Id = flyByEnemy.ObjectId }) })
	IgnoreGravity({ Id = flyByEnemy.ObjectId })
	SetAnimation({ DestinationId = flyByEnemy.ObjectId, Name = "Enemy_HarpyCutter_Move" })
	SetGoalAngle({ Id = flyByEnemy.ObjectId, Angle = 45, CompleteAngle = true })

	SetUnitProperty({ DestinationId = flyByEnemy.ObjectId, Property = "CollideWithUnits", Value = false })
	SetUnitProperty({ DestinationId = flyByEnemy.ObjectId, Property = "CollideWithObstacles", Value = false })

	SetScale({ Id = flyByEnemy.ObjectId, Fraction = args.Scale or 5 })
	SetUnitProperty({ DestinationId = flyByEnemy.ObjectId, Property = "Speed", Value = args.Speed })

	Move({ Id = flyByEnemy.ObjectId, DestinationId = args.HarpyEndId })
	NotifyWithinDistance({ Id = flyByEnemy.ObjectId, DestinationId = args.HarpyEndId, Distance = 75, Notify = "HarpySummon", Timeout = 1.0 })
	waitUntil( "HarpySummon" )

	SetAlpha({ Id = flyByEnemy.ObjectId, Fraction = 0.0, Duration = 0.0 })
	KillEnemy( flyByEnemy, {} )
	Destroy({ Id = flyByEnemy.ObjectId })
end

function UseGodStatueTrapPresentation( statue, args )
	
	Shake({ Id = statue.ObjectId, Speed = 400, Distance = 3, Duration = 0.5 })
	Flash({ Id = statue.ObjectId, Speed = 1, MinFraction = 0, MaxFraction = 0.95, Color = Color.White, Duration = 0.5 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweep", Id = statue.ObjectId })
	PlaySound({ Name = "/SFX/WrathStartNoEmote", Id = statue.ObjectId })

	thread( PlayVoiceLines, statue.InteractVoiceLines, true )

end

function OlympusEaglePreSpawnPresentation()

	wait(1.0)

	PlaySound({ Name = "/SFX/WindGust" })
	wait( 0.3)
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusFistWindmillWhoosh" })
	PlaySound({ Name = "/SFX/Enemy Sounds/EagleAttackScream" })

	AdjustRadialBlurDistance({ Fraction = 2.25, Duration = 0.09 })
	AdjustRadialBlurStrength({ Fraction = 0.85, Duration = 0.09  })
	ShakeScreen({ Speed = 900, Distance = 2, Duration = 0.8, FalloffSpeed = 1400 })
	AdjustFullscreenBloom({ Name = "CerberusSummon", Duration = 0.09 })

	waitUnmodified( 0.4 )

	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.3 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.3  })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
end

function OlympusEagleSpawnPresentation( eagle )

	SetAnimation({ DestinationId = eagle.ObjectId, Name = "Enemy_Eagle_Invisible" })
	wait(0.5)
	PlaySound({ Name = "/SFX/Enemy Sounds/EagleAlerted", Id = eagle.ObjectId })

	local initialScale = GetThingDataValue({ Id = eagle.ObjectId, Property = "Scale" })
	local initialZHeight = GetZLocation({ Id = eagle.ObjectId })

	Teleport({ Id = eagle.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = -2000, OffsetY = 1750 })
	IgnoreGravity({ Id = eagle.ObjectId })
	SetAnimation({ DestinationId = eagle.ObjectId, Name = "Enemy_Eagle_Glide" })
	PlaySound({ Name = "/SFX/HellFireShoot", Id = eagle.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusFistWindmillWhoosh", Id = eagle.ObjectId })
	PlaySound({ Name = "/SFX/WindGust", Id = eagle.ObjectId })

	SetGoalAngle({ Id = eagle.ObjectId, Angle = 30, CompleteAngle = true })

	RemoveFromGroup({ Id = eagle.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = eagle.ObjectId, Name = "Combat_Menu_TraitTray_Overlay_Text", DrawGroup = true })

	SetScale({ Id = eagle.ObjectId, Fraction = 5 })

	Move({ Id = eagle.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = 30, Speed = 10000 })

	wait( 1.0 )

	SetAnimation({ DestinationId = eagle.ObjectId, Name = "Enemy_Eagle_Invisible" })
	Stop({ Id = eagle.ObjectId })
	Halt({ Id = eagle.ObjectId })
	ObeyGravity({ Id = eagle.ObjectId })
	SetScale({ Id = eagle.ObjectId, Fraction = initialScale })
	AddToGroup({ Id = eagle.ObjectId, Name = "Standing", DrawGroup = true })
	RemoveFromGroup({ Id = eagle.ObjectId, Names = { "Combat_Menu_TraitTray_Overlay_Text" } })

	wait( 0.5 )
	AngleTowardTarget({ Id = eagle.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	notifyExistingWaiters("EagleSpawnPresentationEnded")

	if not GameState.IntroducedEagle then
		thread(OlympusEagleFirstSpawnPresentation, eagle )
	end
	thread( PlayVoiceLines, HeroVoiceLines.EagleIncomingVoiceLines, true )
end

function OlympusEagleFirstSpawnPresentation( eagle )
	GameState.IntroducedEagle = true
	waitUnmodified(1.0)

	FocusCamera({ Fraction = 1.03, Duration = 0.5, ZoomType = "Ease" })
	PanCamera({ Id = eagle.ObjectId, Duration = 0.5, EaseIn = 0, EaseOut = 0.1 })
	PlaySound({ Name = "/Leftovers/SFX/TextReveal" })

	waitUnmodified(0.3)

	AddSimSpeedChange( "OlympusEagleFirstSpawnPresentation", { Fraction = 0.18, LerpTime = 0.1, Priority = true } )

	waitUnmodified(0.3)
	-- thread( InCombatText, eagle.ObjectId, eagle.Name, 1 )
	waitUnmodified(2.0)

	RemoveSimSpeedChange( "OlympusEagleFirstSpawnPresentation", { LerpTime = 0.4 } )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5, EaseIn = 0, EaseOut = 0.1 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 0.4, ZoomType = "Ease" })
end

function SatyrGuestHitPresentation( victim, args )
	if not CheckCooldown( "SatyrGuestHitPresentation"..victim.ObjectId, 1.25 ) then
		return
	end
	SetAnimation({ Name = args.OnHitAnimation, DestinationId = victim.ObjectId, })
	ShowInvincibubbleOnObject( victim, { Scale = victim.InvincibubbleScale or 1 } )
end