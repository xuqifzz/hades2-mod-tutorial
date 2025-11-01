function ChronosBattleStart( chronos, args )

	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if enemy ~= chronos then
			AddToGroup({ Id = id, Name = "Spawner"..chronos.ObjectId })
			thread(SetupAI, enemy )
		end
	end
end

function ChronosKillPresentation( unit, args )

	ClearPauseMenuTakeover()
	RecordEncounterClearStats()

	CurrentRun.Hero.Mute = false
	if SessionState.GameplaySlows["ChronosTimeSlow"] ~= nil then
		thread(ChronosEndTimeSlowPresentation)
		GameplaySetElapsedTimeMultiplier( { ElapsedTimeMultiplier = 0.3, Reverse = true, Name = "ChronosTimeSlow", ApplyToPlayerUnits = true, Ignore = unit } )
	end
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})
	if not IsEmpty( unit.StopAnimationsOnHitStun ) then -- since hit stun isn't applied on death
		StopAnimation({ Names = unit.StopAnimationsOnHitStun, DestinationId = unit.ObjectId, PreventChain = true })
		if unit.FxTargetIdsUsed ~= nil then
			for id, v in pairs( unit.FxTargetIdsUsed ) do
				StopAnimation({ Names = unit.StopAnimationsOnHitStun, DestinationId = id, PreventChain = true })
			end
		end
	end

	SetUnitInvulnerable( unit )
	thread( LastKillPresentation, unit )
	if IsGameStateEligible( unit, args.GigarosKillRequirements ) then
		local fadeIds = GetIds({ Names = { "Terrain_LighterColor_02", "Terrain_ClockBroken_01", "Terrain_ClockBroken_02", "Terrain_ClockBroken_03", "Terrain_ClockBroken_04", "Terrain_FX_Sand_01", "Terrain_Displacement_02" } })
		local exceptionIds = { 778354, 778586, 778180, 778186, 778113, 778106, 778564, 778587, 778214, 778130, 778187, 778190, 778189, 778192, 778191, 778188, 778109, 778112, 778111, 778105, 778108, 778110, 778108, 778116, 778117, 794361, 778183, 778179, 778182, 778632, 778633, 778640, 778114, 778115 }

		for k, removeId in ipairs(exceptionIds) do
			RemoveValueAndCollapse(fadeIds, removeId)
		end

		SetAlpha({ Ids = fadeIds, Fraction = 0, Duration = 0.2 })
	end

	SetPlayerInvulnerable( "ChronosKillPresentation" )
	AddInputBlock({ Name = "ChronosKillPresentation" })
	AddTimerBlock( CurrentRun, "ChronosKillPresentation" )
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen, nil, { IgnoreHUDShow = true } )
	end

	if GetNumShrineUpgrades("BossDifficultyShrineUpgrade") >= 4 or unit.CurrentPhase == 3 then
		SetMusicSection( 5 )
	else
		SetMusicSection( 3 )
	end

	Stop({ Id = unit.ObjectId })
	SetGoalAngle({ Id = unit.ObjectId, Angle = 210 })
	SetAnimation({ Name = "Enemy_Chronos_BattleOutro_Start", DestinationId = unit.ObjectId })
	StopAnimation({ Name = "ChronosInvincibubble", DestinationId = unit.ObjectId })
	StopAnimation({ Name = "ChronosPhase2PoweredUpFxEmitterA", DestinationId = unit.ObjectId })
	StopAnimation({ Name = "ChronosPhase2PoweredUpBackingGlow", DestinationId = unit.ObjectId })
	CreateAnimation({ Name = "ChronosPhase2PoweredUpBackingGlowFade", DestinationId = unit.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId })
	thread( PlayVoiceLines, unit.PhaseEndedVoiceLines, nil, unit )

	if unit.CurrentPhase == 3 and IsGameStateEligible(unit, { NamedRequirements = { "HecateMissing" } }) then
		wait( 4.0, RoomThreadName )
	elseif GameState.TextLinesRecord.ChronosBossOutro01 then
		wait( 2.8, RoomThreadName )
	else
		wait( 4.0, RoomThreadName )
	end

	local textLines = GetRandomEligibleTextLines( unit, unit.BossOutroTextLineSets, GetNarrativeDataValue( unit, "BossOutroTextLinePriorities" ) )
	unit.TextLinesUseWeaponIdle = nil
	PlayTextLines( unit, textLines )
	if IsGameStateEligible( unit, args.GigarosKillRequirements ) then
		ChronosGigarosKillPresentation( unit, args )
		unit.DeathAnimation = args.GigarosKillDeathAnimation or unit.DeathAnimation
		args.Message = args.GigarosKillMessage
		args.SubtitleText = args.GigarosKillSubtitle
	elseif IsGameStateEligible( unit, args.SpecialKillRequirements ) then
		ChronosSpecialKillPresentation( unit, args )
	end

	SetCameraClamp({ Ids = GetIds({ Name = "CameraClamps" }), SoftClamp = 0.75 })

	thread( PlayVoiceLines, unit.DefeatedVoiceLines, true, unit )

	AddToGroup({ Ids = GetIds({ Name = "SpawnPointsPhase2" }), Name = "InactiveSpawnPoints", DrawGroup = true })
	AddToGroup({ Ids = GetIds({ Name = "SpawnPointsPhase1" }), Name = "SpawnPoints", DrawGroup = true })
	if MapState.FamiliarUnit ~= nil then
		Teleport({ Id = MapState.FamiliarUnit.ObjectId, DestinationId = 713401 })
	end

	if IsGameStateEligible( unit, args.SpawnChronosRemainsRequirements ) then
		local remainsType = "ChronosRemains"
		if IsGameStateEligible( unit, { NamedRequirements = { "HecateMissing" }} ) then
			remainsType = "ChronosRemainsBroken"
		end
		local chronosRemains = DeepCopyTable( ObstacleData[remainsType] )
		chronosRemains.ObjectId = SpawnObstacle({ Name = remainsType, Group = "Standing", DestinationId = args.VictimTeleportId })
		CurrentRun.CurrentRoom.Encounter.ObstaclesToRestore = CurrentRun.CurrentRoom.Encounter.ObstaclesToRestore or {}
		table.insert( CurrentRun.CurrentRoom.Encounter.ObstaclesToRestore, { Name = remainsType, DestinationId = args.VictimTeleportId } )
	end

	local chronosParticleEmitterAnimationName = "ChronosBattleOutroDeathParticleEmitter"

	if IsGameStateEligible( unit, args.GigarosKillRequirements ) then
		chronosParticleEmitterAnimationName = "ChronosBattleOutroDeathParticleEmitterGigarosKill"
		local chronosRemainsKernel = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = unit.ObjectId, Group = "Combat_Menu_TraitTray_Overlay_Additive", })
		SetScale({ Id = chronosRemainsKernel, Fraction = 0, Duration = 4 })
		SetAnimation({ Name = "ChronosRemainsKernel", DestinationId = chronosRemainsKernel })
	end

	local chronosParticleEmitter = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = unit.ObjectId, Group = "Combat_Menu_TraitTray_Overlay", })
	SetAnimation({ Name = chronosParticleEmitterAnimationName, DestinationId = chronosParticleEmitter })
	Move({ Id = chronosParticleEmitter, Distance = 200, Angle = 90, Duration = 5 })

	GenericBossKillPresentation( unit, args )
	SetAnimation({ Name = "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })

	-- AdjustColorGrading({ Name = "Desaturated", Duration = 0.75 })
	PlaySound({ Name = "/SFX/TimeSlowStart" })
	
	-- Protecting against reports of enemies blocking exit after the fight
	killTaggedThreads(unit.SpawnerThreadName)
	DestroyRequiredKills( { BlockLoot = true, SkipIds = { unit.ObjectId } } )

	Destroy({ Ids = GetIds({ Name = "ChronosDeathDelete" }) })
	UseableOn({ Id = 625868 }) -- Exit door

	wait( 2.0 )

	RemoveInputBlock({ Name = "ChronosKillPresentation" })
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	
	OpenRunClearScreen()
	ClearCameraClamp({ LerpTime = 1.0 }) -- the map bounds are more restrictive during the fight

end

function ChronosGigarosKillPresentation( chronos, args )
	-- center 797656, mel spot 797655

	SetAnimation({ Name = "Melinoe_ChronosKill_Start", DestinationId = CurrentRun.Hero.ObjectId })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.1, Duration = 1.25, ZoomType = "Ease" })

	HideCombatUI("ChronosGigarosKillPresentation")
	if SessionMapState.SpellWorldReadyFx then
		SessionMapState.SpellWorldReadyFx = nil
		StopAnimation({ Names = { "SorceryReadyMoonLoopIn", "SorceryReadyMoonLoop" }, DestinationId = CurrentRun.Hero.ObjectId, PreventChain = true })
	end

	thread( PlayVoiceLines, HeroVoiceLines.ChronosFatalityVoiceLines, true )
	wait( 1.05 )

	ShakeScreen({ Speed = 200, Distance = 6, FalloffSpeed = 500, Angle = 90, Duration = 0.2 })
	wait( 0.8 )

	local cameraPanId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Standing", DestinationId = 797656, OffsetY = -1150 })

	ClearCameraClamp({ LerpTime = 0 })

	PanCamera({ Id = cameraPanId, Duration = 2.5, Retarget = true })
	FocusCamera({ Fraction = 1.2, Duration = 3, ZoomType = "Ease" })

	wait( 1.0 )

	Teleport({ Id = chronos.ObjectId, DestinationId = 797656 })
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 797655 })
	SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = 45, CompleteAngle = true })
	AdjustZLocation({ Id = CurrentRun.Hero.ObjectId, Distance = 1100 - GetZLocation({ Id = CurrentRun.Hero.ObjectId }), Duration = 0.4 })

	wait( 0.4 )

	AdjustZLocation({ Id = CurrentRun.Hero.ObjectId, Distance = 1200 - GetZLocation({ Id = CurrentRun.Hero.ObjectId }), Duration = 1.30 })

	wait( 1.25 )

	PanCamera({ Id = 797656, Duration = 0.4, OffsetY = -50, Retarget = true })

	wait( 0.15 )

	AdjustZLocation({ Id = CurrentRun.Hero.ObjectId, Distance = 0 - GetZLocation({ Id = CurrentRun.Hero.ObjectId }), Duration = 0.2 })

	wait( 0.2 )
	
	CreateAnimation({ Name = "ChronosGigarosKillFx", DestinationId = chronos.ObjectId })

	wait( 0.05 )

	ShowCombatUI("ChronosGigarosKillPresentation")
	Destroy({ Id = cameraPanId })
end

function ChronosSpecialKillPresentation( chronos, args )
	local neoChronosId = GetIdsByType({ Name = "NPC_Chronos_02" })[1]
	local neoChronos = nil

	if neoChronosId == nil then
		neoChronos = DeepCopyTable( EnemyData.NPC_Chronos_02 )
		neoChronos.ObjectId = SpawnUnit({ Name = "NPC_Chronos_02", Group = "Standing", DestinationId = chronos.ObjectId, OffsetX = -180, OffsetY = -120, })
		SetupUnit( neoChronos, CurrentRun, { IgnoreAI = true, IgnoreAssert = true, } )
		neoChronosId = neoChronos.ObjectId
		SetUnitProperty({ DestinationId = neoChronos.objectId, Property = "CollideWithObstacles", Value = false })
		SetUnitProperty({ DestinationId = neoChronos.objectId, Property = "CollideWithUnits", Value = false })

		SetAlpha({ Id = neoChronosId, Fraction = 0, Duration = 0 })
		AngleTowardTarget({ Id = neoChronosId, DestinationId = chronos.ObjectId })

		SetAlpha({ Id = neoChronosId, Fraction = 1, Duration = 0.3 })
		CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = neoChronosId })
	else
		neoChronos = ActiveEnemies[neoChronosId]
	end

	thread( PlayVoiceLines, neoChronos.BossFinisherVoiceLines ) 

	PanCamera({ Ids = { neoChronosId, chronos.ObjectId }, Duration = 1.2, Retarget = true })

	wait( 0.8 )

	SetAnimation({ Name = "NPC_Chronos_Execute_Start", DestinationId = neoChronosId })

	wait(1.96)

	CreateAnimation({ Name = "ChronosSwingLeft", DestinationId = neoChronosId })

	wait(0.2)

	thread( UnSummonNeoChronos, chronos, { PreDelay = 1.0 } )
end

function ChronosRemainsEnterTriggerPresentation( source, args )
	CreateAnimation({ Name = "ChronosRemainsPulse", DestinationId = source.ObjectId })
	ScreenAnchors.ChronosRemainsVignette = CreateScreenObstacle({ Name = "BlankObstacle", Alpha = 0.0, Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY, })
	SetAnimation({ Name = "ChronosTimeStopFx", DestinationId = ScreenAnchors.ChronosRemainsVignette })
	AdjustColorGrading({ Name = "ChronosTimeSlow", Duration = 0.3 })
	AdjustRadialBlurDistance({ Fraction = 0.05, Duration = 0.3 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.3 })
	SetAlpha({ Id = ScreenAnchors.ChronosRemainsVignette, Fraction = 0.5, Duration = 0.3 })
end

function ChronosRemainsLeaveTriggerPresentation( source, args )
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.3 })
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	SetAlpha({ Id = ScreenAnchors.ChronosRemainsVignette, Fraction = 0.0, Duration = 0.3 })
	wait(0.3)
	Destroy({ Id = ScreenAnchors.ChronosRemainsVignette })
	ScreenAnchors.ChronosRemainsVignette = nil
end

function ChronosPostCombatReload( room, args )
	Destroy({ Ids = GetIds({ Name = "ChronosDeathDelete" }) })
	Destroy({ Ids = GetIds({ Name = "ChronosFightStartDelete" }) })
	ClearCameraClamp({ LerpTime = 1.0 }) -- the map bounds are more restrictive during the fight
end

function TartarusChamberMoverPresentation( usee, args, user )
	args = args or {}
	AddInputBlock({ Name = "MelUsedSystemObject" })
	HideUseButton( usee.ObjectId, usee )
	UseableOff({ Id = usee.ObjectId })
	MapState.RoomRequiredObjects[usee.ObjectId] = nil

	thread( PlayVoiceLines, HeroVoiceLines.ChamberMoverUsedVoiceLines )
	PanCamera({ Id = usee.ObjectId, Duration = 1.1, FromCurrentLocation = true, Retarget = true, OffsetY = 0, EaseIn = 0 })

	if not GameState.ReachedTrueEnding then
		FocusCamera({ Fraction = 1.02, Duration = 15, ZoomType = "Ease" })
	
		wait(0.1)

		Stop({ Id = CurrentRun.Hero.ObjectId })
		MoveHeroToRoomPosition({ DestinationId = 692127})
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })

		wait( 0.41 )
	else
		FocusCamera({ Fraction = 1.02, Duration = 10, ZoomType = "Ease" })
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
		CreateAnimation({ Name = "CWEntranceHadesSymbolIn", DestinationId = usee.ObjectId, OffsetZ = 120, OffsetX = -40, Group = "Combat_Menu_TraitTray" })
	end

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
  	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })

  	wait( 0.7 )
	
	AdjustFullscreenBloom({ Name = "DesaturatedLight", Duration = 0.9 })
	local vignetteAName = "NightmareVignetteLoop"
	local loopingSoundId = nil

	if not GameState.ReachedTrueEnding then
		thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.13, Duration = 1.5 }, } )
		ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })
		if ConfigOptionCache.GraphicsQualityPreset == "GraphicsQualityPreset_Low" then
			-- None
		else
			CreateAnimation({ Name = "NightmareEdgeFxSpawner", DestinationId = CurrentRun.Hero.ObjectId }) --nopkg
		end
		local vignetteA = CreateAnimation({ Name = vignetteAName, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
		DrawScreenRelative({ Id = vignetteA })
		
		AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.1 })
		AdjustRadialBlurStrength({ Fraction = 1.0, Duration = 0.1 })
		
		loopingSoundId = PlaySound({ Name = "/SFX/Menu Sounds/CauldronWhispers", Id = CurrentRun.Hero.ObjectId })
		SetAnimation({ Name = "Melinoe_Gesture", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 1.2 })

		CreateAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
		CreateAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
		CreateAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
		CreateAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })

		CreateAnimation({ Name = "CWEntranceHadesSymbolIn", DestinationId = usee.ObjectId, OffsetZ = 120, OffsetX = -40, Group = "Combat_Menu_TraitTray" })

		wait(2.6)
	else
		thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.13, Duration = 0.2 }, } )
		SetAnimation({ Name = "Melinoe_CrossCast_Start_Fast", DestinationId = CurrentRun.Hero.ObjectId })
		wait(0.25)
		SetAnimation({ Name = "MelinoeCrossCast", DestinationId = CurrentRun.Hero.ObjectId })
	end

	PlaySound({ Name = "/SFX/Menu Sounds/HadesSigilDoorUnlock" })
	
	StopAnimation({ Name = "CWEntranceHadesSymbolLoop", DestinationId = usee.ObjectId })
	SetAlpha({ Ids = usee.RewardPreviewIconIds, Fraction = 0.0, Duration = 0 })
	AdjustFullscreenBloom({ Name = "FullscreenFlash2", Duration = 0.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1 })


	if not GameState.ReachedTrueEnding then
		wait(0.3)
		StopAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId })
		StopAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId })
		StopAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId })
		StopAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId })
		StopSound({ Id = loopingSoundId, Duration = 0.4 })
		loopingSoundId = nil
	end

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1 })

	if not GameState.ReachedTrueEnding then
		StopAnimation({ Name = vignetteAName, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
		StopAnimation({ Name = "NightmareEdgeFxSpawner", DestinationId = CurrentRun.Hero.ObjectId })
	end

	ShakeScreen({ Distance = 8, Speed = 500, Duration = 0.3, FalloffSpeed = 1000 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.13, Duration = 0.5 }, } )

	PlaySound({ Name = "/SFX/PostBossGears", Id = usee.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId, Delay = 0.25 })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId, Delay = 0.5 })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId, Delay = 0.75 })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId })

	wait( 1.0 )
	thread( InCombatText, usee.ObjectId, "ChamberMoverUsed", 2.0, { ShadowScaleX = 1.2, PreDelay = 0.5 } )
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/Hades360Swipe", Id = usee.ObjectId })

	SetAlpha({ Ids = usee.RewardPreviewIconIds, Fraction = 1.0, Duration = 0.25, EaseIn = 0, EaseOut = 1 })
	SetAnimation({ DestinationIds = usee.RewardPreviewIconIds, Name = "ClockworkCountdown"..(CurrentRun.RemainingClockworkGoals or 0) })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.19, Duration = 0.45 }, } )
	
	wait( 1.50 )

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "Speed", Value = 600 }) -- to get her out the gate
	wait( 0.45, RoomThreadName )
	RemoveInputBlock({ Name = "MelUsedSystemObject" })

end

function ChronosRemainsPresentation( usee, args )
	args = args or {}
	AddInputBlock({ Name = "MelUsedChronosRemains" })
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines[args.VoiceLines] or HeroVoiceLines.LockedQuestLogVoiceLines )

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.7 )

	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 1.8 )

	SetAnimation({ Name = "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })
	
	wait( 0.5 )
	RemoveInputBlock({ Name = "MelUsedChronosRemains" })
end

function RoomEntranceChronos( currentRun, currentRoom, args )

	args = args or {}

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter

	if not GameState.ReachedTrueEnding then
		FadeOut({ Duration = 0.0, Color = Color.ChronosSand })
		AdjustColorGrading({ Name = "Off", Duration = 0.0 })
	end

	HideCombatUI("BossEntrance")
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0.0, Duration = 0.0 })
	AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = args.LandingTarget })
	PanCamera({ Id = currentRoom.CameraStartPoint, Duration = 0.01, EaseIn = 0, EaseOut = 0 })
	UseableOff({ Id = 625868 }) -- Exit door

	if AudioState.WaterSoundId == nil then
		AudioState.WaterSoundId = PlaySound({ Name = "/SandAmbienceLOUD" })
	end

	wait(0.03)

	if GameState.ReachedTrueEnding then
		FadeIn({ Duration = 0.1 })
		FullScreenFadeInAnimation( "RoomTransitionOut_TimeWarp" )
		CreateAnimation({ Name = "SandPortalOpenClose", DestinationId = CurrentRun.Hero.ObjectId })
		thread( TrueEndingTimeFxVignette )
	else
		FadeIn({ Duration = 0.65 })
	end

	wait(1.0)

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

	local chronos = ActiveEnemies[609246]
	if chronos ~= nil then
		chronos.QueuedBossIntroTextLines = GetRandomEligibleTextLines( chronos, chronos.BossIntroTextLineSets, GetNarrativeDataValue( chronos, "BossIntroTextLinePriorities" ) )
	end

	thread( PlayVoiceLines, encounterData.EnterVoiceLines or roomData.EnterVoiceLines, true, nil, { Chronos = chronos } )
	thread( PlayVoiceLines, GlobalVoiceLines[roomData.EnterGlobalVoiceLines], true )

	thread( DisplayInfoBanner, nil, { Text = "Location_IBoss01", AnimationName = "InfoBannerTartarusIn", AnimationOutName = "InfoBannerTartarusOut", Delay = 1.0, Color = Color.White, FadeColor = Color.Red } )
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
	thread( CheckQuestStatus )

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

function LeaveRoomIPreBoss01Presentation( currentRun, exitDoor )
	HideCombatUI( "LeaveRoomIPreBoss01Presentation" )
	AddInputBlock({ Name = "LeaveRoomIPreBoss01Presentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )

	LeaveRoomAudio( currentRun, exitDoor )

	SetAnimation({ Name = "Blank", DestinationId = exitDoor.ObjectId })

	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait( 0.01 )

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
	CreateAnimation({ Name = "CWSandBurst_PreBoss", DestinationId = 712195, Group = "Standing"  })
	PlaySound({ Name = "/SFX/SandDive", Id = 712195 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.3, Duration = 0.2 }, } )

	AudioState.WaterSoundId = PlaySound({ Name = "/Ambience/SandAmbienceLoop" })
	AdjustColorGrading({ Name = "ChronosSand", Duration = 1 })
	wait( 1.0 )
	FadeOut({ Duration = 0.5, Color = Color.ChronosSand })
	wait( 0.5 )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomIPreBoss01Presentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function LeaveRoomIPreBoss02Presentation( currentRun, exitDoor )
	HideCombatUI( "LeaveRoomIPreBoss02Presentation" )
	AddInputBlock({ Name = "LeaveRoomIPreBoss02Presentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )

	LeaveRoomAudio( currentRun, exitDoor )

	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait( 0.01 )

	-- spawn Chronos
	local chronosId = 774858
	if ActiveEnemies[chronosId] == nil then
		ActivatePrePlaced( exitDoor, { Types = { "NPC_Chronos_02" } } )
		SetAlpha({ Id = chronosId, Fraction = 0, Duration = 0 })
		SetAlpha({ Id = chronosId, Fraction = 1, Duration = 0.3 })
		CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = chronosId })
	end

	thread( PlayVoiceLines, GlobalVoiceLines.ChronosLaunchVoiceLines, true, ActiveEnemies[chronosId] )

	CreateAnimation({ Name = "SandPortalOpen", DestinationId = exitDoor.ObjectId })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = exitDoor.ObjectId })
	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.1, OffsetY = -50, EaseOut = 0 })
	
	wait( 1.0 )	

	SetAnimation({ Name = "Melinoe_DiveExit_Portal_Start", DestinationId = CurrentRun.Hero.ObjectId })
	
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
	CreateAnimation({ Name = "CWSandBurst_PreBoss", DestinationId = 712195, Group = "Standing" })
	StopAnimation({ Name = "SandPortalTerrainLoop", DestinationId = exitDoor.ObjectId })
	CreateAnimation({ Name = "SandPortalTerrainClose", DestinationId = exitDoor.ObjectId })
	PlaySound({ Name = "/SFX/SandDive", Id = 712195 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.3, Duration = 0.2 }, } )

	AudioState.WaterSoundId = PlaySound({ Name = "/Ambience/SandAmbienceLoop" })
	FullScreenFadeOutAnimation( "RoomTransitionIn_TimeWarp", "ChronosSand" )
	wait( 1.0 )
	FadeOut({ Duration = 0.5, Color = Color.Black })
	wait( 0.5 )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomIPreBoss02Presentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
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
	local throneId = GetIdsByType({ Name = "CWThrone01" })[1]
	local deleteIds = GetIds({ Name = "ChronosFightStartDelete" })
	FocusCamera({ Fraction = 1.1, Duration = 6.0, ZoomType = "Ease" })
	SetAnimation({ Name = "Enemy_Chronos_BattleIntro_Start", DestinationId = source.ObjectId })
	wait(0.67)

	thread( MoveHeroToRoomPosition, { MoverId = source.ObjectId, DestinationId = source.ChronosFightStartMoveId, Speed = 120, DisableCollision =  true, })

	wait( 0.65 )

	CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = throneId })
	CreateAnimation({ Name = "ChronosTeleportFxBack", DestinationId = throneId })

	SetAlpha({ Ids = deleteIds, Fraction = 0.0, Duration = 0.2  })

	wait( 0.2 )
	Destroy({ Ids = deleteIds })
	wait(3.5)
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1.0, ZoomType = "Ease" })
end

function ChronosMinorStageTransition( boss, currentRun, aiStage )
	wait(0.05) -- Don't overlap with the same frame as AIHealthThresholdReached() so threads don't get killed
	Stop({ Id = boss.ObjectId })
	SetAnimation({ DestinationId = boss.ObjectId, Name = "Enemy_Chronos_Idle" })
	ClearEffect({ Id = boss.ObjectId, Name = "ChronosFireRotationDampening" })
	ClearEffect({ Id = boss.ObjectId, Name = "ChronosFireRotationDampening" })
	ExpireProjectiles({ Names = { "ChronosGrindWall", "ChronosGrindVacuum", } })
	BossStageTransition( boss, currentRun, aiStage )
end

function ChronosPhaseTransition( boss, currentRun, aiStage )
	currentRun.CurrentRoom.Encounter.ChronosTransition = true
	if boss.SkipTransitionInvulnerability or aiStage.SkipTransitionInvulnerability then
		SetUnitVulnerable( boss )
	else
		SetUnitInvulnerable( boss )
	end

	-- this needs to be above the CurrentPhase transition
	thread( PlayVoiceLines, boss.PhaseEndedVoiceLines, nil, boss )

	boss.CurrentPhase = boss.CurrentPhase + 1
	if boss.CurrentPhase == 2 then
		AddTimerBlock( CurrentRun, "ChronosTransition")
	end
	Stop({ Id = boss.ObjectId })

	SetPlayerInvulnerable( "ChronosPhaseTransition" )
	AddInputBlock({ Name = "ChronosPhaseTransition" })

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen, nil, { IgnoreHUDShow = true } )
	end
	HideCombatUI("ChronosPhaseTransition")

	DestroyRequiredKills( { BlockLoot = true, SkipIds = { boss.ObjectId }, BlockDeathWeapons = true } )
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	
	if boss.CreatedDisplayAnchors ~= nil then
		local toDestroy = {}
		for _, id in pairs( boss.CreatedDisplayAnchors ) do
			table.insert( toDestroy, id )
		end
		Destroy({ Ids = toDestroy })
		boss.CreatedDisplayAnchors = {}
	end
	boss.EffectTextBoxes = {}
	
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})
	ClearAllEffects( boss ) 
	if not IsEmpty( boss.StopAnimationsOnHitStun ) then
		StopAnimation({ Names = boss.StopAnimationsOnHitStun, DestinationId = boss.ObjectId, PreventChain = true })
	end
	SetAnimation({ Name = "Enemy_Chronos_Knockdown_Start", DestinationId = boss.ObjectId })
	SetGoalAngle({ Id = boss.ObjectId, Angle = 270 })
	thread( LastKillPresentation, boss )

	SetMusicSection( 1 )

	PanCamera({ Id = boss.ObjectId, Duration = 1.20 })

	thread( SetHeroAngleWithMoveOrder, { ObjectId = boss.ObjectId, Timeout = 0.405 } )

	if boss.CurrentPhase == 3 and IsGameStateEligible(boss, { NamedRequirements = { "HecateMissing" } }) then
		AddTimerBlock( CurrentRun, "ChronosHecateMissing" )
		ClearPauseMenuTakeover()
		wait( 4.0, boss.AIThreadName )
	else
		wait( 1.25, boss.AIThreadName )
	end

	local textLines = GetRandomEligibleTextLines( boss, boss.BossPhaseChangeTextLineSets, GetNarrativeDataValue( boss, "BossPhaseChangeTextLinePriorities" ) )
	boss.TextLinesUseWeaponIdle = true

	if boss.CurrentPhase == 3 then
		SetMusicSection( 1 )
	end
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

		if SessionMapState.ManaDropId then
			Destroy({ Id = SessionMapState.ManaDropId })
			SessionMapState.ManaDropId = nil
		end

		Activate({ Name = "SpawnPointsPhase2" })
		AddToGroup({ Ids = GetIds({ Name = "SpawnPointsPhase1" }), Name = "InactiveSpawnPoints", DrawGroup = true })
		CurrentRun.CurrentRoom.SpawnPoints = {}
		MapState.SpawnPoints = GetIds({ Name = "SpawnPoints" })
		Teleport({ Id = boss.ObjectId, DestinationId = 625757 })
		Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 645921 })
		if CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId then
			Teleport({ Id = CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId , DestinationId = 645975 })
			AngleTowardTarget({ Id = CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId , DestinationId = boss.ObjectId })
		end
		if MapState.FamiliarUnit ~= nil then
			Teleport({ Id = MapState.FamiliarUnit.ObjectId, DestinationId = 645983 })
			AngleTowardTarget({ Id = MapState.FamiliarUnit.ObjectId, DestinationId = boss.ObjectId })
		end
		SetCameraClamp({ Ids = GetIds({ Name = "CameraClamps2" }), SoftClamp = 0.75 })
	elseif boss.CurrentPhase == 3 then

		CurrentRun.Hero.Mute = true
		if CurrentRun.Hero.Weapons.WeaponLob then
			ReloadAmmo({Name = "WeaponLob"})
			UpdateWeaponAmmo( "WeaponLob", 0 )
			thread( UpdateAmmoUI )
			ExpireProjectiles({ Names = {"ProjectileLobCharged", "ProjectileLob"}, BlockSpawns = true})
			Destroy({ Ids = GetIdsByType({ Name = "LobAmmoPack"})  })
		end

		if SessionMapState.ManaDropId then
			Destroy({ Id = SessionMapState.ManaDropId })
			SessionMapState.ManaDropId = nil
		end

		Activate({ Name = "SpawnPointsPhase3" })
		AddToGroup({ Ids = GetIds({ Name = "SpawnPointsPhase2" }), Name = "InactiveSpawnPoints", DrawGroup = true })
		CurrentRun.CurrentRoom.SpawnPoints = {}
		MapState.SpawnPoints = GetIds({ Name = "SpawnPoints" })
		Teleport({ Id = boss.ObjectId, DestinationId = 772105 })
		Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 772106 })
		if CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId then
			Teleport({ Id = CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId , DestinationId = 772210 })
			AngleTowardTarget({ Id = CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId , DestinationId = boss.ObjectId })
		end
		if MapState.FamiliarUnit ~= nil then
			Teleport({ Id = MapState.FamiliarUnit.ObjectId, DestinationId = 772223 })
			AngleTowardTarget({ Id = MapState.FamiliarUnit.ObjectId, DestinationId = boss.ObjectId })
		end
		SetCameraClamp({ Ids = GetIds({ Name = "CameraClamps3" }), SoftClamp = 0.75 })

		thread(ChronosHealthBarTextTransition, boss)
		
		if IsGameStateEligible( room, NamedRequirementsData.InfiniteChronosDeathDefiance ) then
			SessionMapState.InfiniteDeathDefiance = true
			UpdateLifePips( CurrentRun.Hero)
		end
	end

	wait( 0.5, boss.AIThreadName )

	if boss.CurrentPhase == 2 then
		SetMusicSection( 2 )
	elseif boss.CurrentPhase == 3 then
		SetMusicSection( 4 )
	end

	SetAnimation({ Name = "MelinoeIdle", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = boss.ObjectId })

	SetAnimation({ DestinationId = ScreenAnchors.PhaseTransitionBG, Name = "RoomTransitionOut_Radial_Fast" })
	AdjustFullscreenBloom({ Name = "ChronosPhase2Start", Duration = 0 })
	CreateAnimation({ Name = "ChronosPhase2PoweredUpFxEmitterA", DestinationId = boss.ObjectId, OffsetZ = 0 })
	CreateAnimation({ Name = "ChronosPhase2PoweredUpBackingGlow", DestinationId = boss.ObjectId, OffsetZ = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })

	wait(0.3, boss.AIThreadName)

	boss.MaxHealth = aiStage.NewMaxHealth or boss.MaxHealth
	boss.Health = boss.MaxHealth
	if aiStage.SetHealthPercent ~= nil then
		boss.Health = boss.Health * aiStage.SetHealthPercent
	end
	BossHealthBarPresentation( boss )
	if boss.CurrentPhase == 3 then
		PlaySound({ Name = "/SFX/Enemy Sounds/Chronos/EmoteChuckle", Id = boss.ObjectId, Delay = 0.1 })
	end

	wait(1.0, boss.AIThreadName)

	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.0 })
	RemoveInputBlock({ Name = "ChronosPhaseTransition" })
	SetPlayerVulnerable( "ChronosPhaseTransition" )
	ShowCombatUI("ChronosPhaseTransition")
	
	RemoveFromGroup({ Id = boss.ObjectId, Names = { "Combat_Menu" } })
	AddToGroup({ Id = boss.ObjectId, Name = "Standing", DrawGroup = true })
	
	SetUnitVulnerable( boss )
	wait(0.5, boss.AIThreadName)

	if boss.CurrentPhase == 2 then
		RemoveTimerBlock( CurrentRun, "ChronosTransition")
	end
	currentRun.CurrentRoom.Encounter.ChronosTransition = nil
end

function HouseFrontDoorUsedPresentation( usee, args, user )

	UseableOff({ Id = 711873 }) -- ChronosBossDoor
	HideCombatUI( "HouseFrontDoorUsedPresentation" )
	AddInputBlock({ Name = "HouseFrontDoorUsedPresentation" })

	Stop({ Id = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, OffsetY = -280, Duration = 11.5, Retarget = true })

	wait(0.05)

	thread( PlayVoiceLines, GlobalVoiceLines.RoomOpeningMainDoorVoiceLines, true )

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })

	wait(2.6)
	local loopingSoundId = PlaySound({ Name = "/SFX/Menu Sounds/CauldronWhispers", Id = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Melinoe_Gesture_ToWeaponless", DestinationId = CurrentRun.Hero.ObjectId })

	CreateAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "CWEntranceHadesSymbolInFail", DestinationId = 714708, OffsetZ = 220 })

	wait( 1.7 )

	wait( 2.0 )

	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = CurrentRun.Hero.ObjectId })
	StopSound({ Id = loopingSoundId, Duration = 0.4 })
	loopingSoundId = nil

	StopAnimation({ Name = "CWEntranceHadesSymbolLoopFail", DestinationId = 714708 })

	wait( 0.4 )

	PlaySound({ Name = "/SFX/PillarDestroyedBIG" })
	Shake({ Id = 711873, Duration = 1.0, Distance = 3, Speed = 300 })
	ShakeScreen({ Distance = 8, Speed = 500, Duration = 1.0, FalloffSpeed = 1000 })
	StopAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 1.15 )

	SetAnimation({ Name = "MelinoeIdleWeaponless", DestinationId = CurrentRun.Hero.ObjectId })

	wait(1.5)

	SetAnimation({ Name = "Charon_Fierce", DestinationId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Charon_01" }) })

	wait(3.5)

	MapState.RoomRequiredObjects[711873] = nil
	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	end

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25, })

	ShowCombatUI( "HouseFrontDoorUsedPresentation" )
	RemoveInputBlock({ Name = "HouseFrontDoorUsedPresentation" })
end

-- @ ending
function MirrorOffPresentation( room, args )

	local melSleepingId = 746879
	local mirrorId = 390021
	local mirrorKiraIds = GetIds({ Name = "MirrorKiraIds" })

	SetAlpha({ Id = melSleepingId, Fraction = 0.0 })
	SetAlpha({ Ids = mirrorKiraIds, Fraction = 0.0 })
	SetAnimation({ Name = "HouseMirrorInert", DestinationId = mirrorId })

end
function MirrorOnPresentation( room, args )

	local melSleepingId = 746879
	local mirrorId = 390021
	local mirrorKiraIds = GetIds({ Name = "MirrorKiraIds" })

	SetAlpha({ Id = melSleepingId, Fraction = 1.0 })
	SetAlpha({ Ids = mirrorKiraIds, Fraction = 1.0 })
	SetAnimation({ Name = "HouseMirror02", DestinationId = mirrorId })

	local gigarosId = 800279
	SetAlpha({ Id = gigarosId, Fraction = 1.0 })
	UseableOn({ Id = gigarosId })

end

GlobalVoiceLines.GigarosFoundVoiceLines =
{
	{
		Queue = "Interrupt",
		UsePlayerSource = true,
		PreLineWait = 0.45,

		{ Cue = "/VO/MelinoeField_3857", Text = "Gigaros... this must be {#Emph}it...!" },
		-- { Cue = "/VO/MelinoeField_3858", Text = "Our bond is strong by touch alone..." },
		{ Cue = "/VO/MelinoeField_5120", Text = "No mere dream... its essence is real..." },
	},
}

function RoomEntranceIPostBoss( currentRun, currentRoom )
	for i, rushWeaponName in pairs( WeaponSets.HeroRushWeapons ) do
		SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	RoomEntranceStandard( currentRun, currentRoom )
end

function RoomEntranceIChronosFlashback( currentRun, currentRoom )
	for i, rushWeaponName in pairs( WeaponSets.HeroRushWeapons ) do
		SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	SetupFlashback03( currentRoom, {} )
end

function DreamBedPresentation( usee, args, user )

	args = args or {}
	AddInputBlock({ Name = "MelUsedSystemObject" })
	HideUseButton( usee.ObjectId, usee )
	UseableOff({ Id = usee.ObjectId })

	StopAnimation({ Name = "IPostBossBedSparkles", DestinationId = usee.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.DreamBedUsedLines )

	if not GameState.TextLinesRecord.ZagreusPastFirstMeeting then
		wait(3.4)
	end

	SetAnimation({ Name = "Melinoe_DeathHover_Start", DestinationId = CurrentRun.Hero.ObjectId })

	wait(0.5)

	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = CurrentRun.Hero.ObjectId })

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.7 }, } )
	AdjustColorGrading({ Name = "Chaos", Duration = 0.7 })

	wait( 0.2 )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })

	wait( 2.5 )

	PlaySound({ Name = "/Leftovers/SFX/PlayerRespawn" })

	wait(1.35)
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedBeowulfStrings", Delay = 0.3 })

	FullScreenFadeOutAnimation()

	SetAudioEffectState({ Name = "Reverb", Value = 2.0 })
	SetAudioEffectState({ Name = "GlobalEcho", Value = 0.5 })

	AudioState.AmbienceId = PlaySound({ Name = "/Ambience/RemembranceScreenAmbience2", Duration = 0.5 })

	if MapState.FamiliarUnit ~= nil then
		CallFunctionName( MapState.FamiliarUnit.StopAIFunctionName, MapState.FamiliarUnit )
		Destroy({ Id = MapState.FamiliarUnit.ObjectId })
		MapState.FamiliarUnit = nil
	end
	for fromSound, toSound in pairs( GameData.NightmareSequenceData.SwapSounds ) do
		SwapSound({ Name = fromSound, DestinationName = toSound })
	end
	SetPlayerDarkside("NightmareSequence")
	thread( NightmareScreenEffects )

	-- used for VO
	CurrentRun.CurrentRoom.InDreamState = true

	MirrorOnPresentation()

	-- remove the inspect points
	Destroy({ Ids = { 772209, 772210 } })

	waitUnmodified( 2.5 )

	AdjustFullscreenBloom({ Name = "Off", Duration = 0.0 })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	FullScreenFadeInAnimation()

	wait( 0.45, RoomThreadName )
	thread( PlayVoiceLines, GlobalVoiceLines.DreamPresentationLines )

	SetAnimation({ Name = "MelinoeDeathReEnterToIdle", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 1.0 )

	RemoveInputBlock({ Name = "MelUsedSystemObject" })
end

function PingHadesSpear( source, args )
	if CurrentRun.UseRecord.DreamBed01 and not CurrentRun.UseRecord.HadesSpear01 then
		thread( DirectionHintPresentation, { ObjectId = source.ObjectId }, { Cooldown = 5.0, Delay = 0 } )
	end
end

function UseHadesSpearPresentation( usee, args, user )
	AddInputBlock({ Name = "UseHadesSpearPresentation" })
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	wait( 0.01 )
	SetAnimation({ Name = "Melinoe_UseGigaros_Start", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	PlayVoiceLines( GlobalVoiceLines.GigarosFoundVoiceLines )
	SetAnimation({ Name = "Melinoe_UseGigaros_End", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "GigarosPickupParticleBurst", DestinationId = usee.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful", Id = usee.ObjectId })
	SetAlpha({ Id = usee.ObjectId, Fraction = 0.0, Duration = 1 })
	ResourceGiftedPresentation( { ResourceName = "HadesSpearPoints", SoundName = "/SFX/Enemy Sounds/Hades/HadesSpearEmerge" } )
	UseableOff({ Id = usee.ObjectId })
	RemoveInputBlock({ Name = "UseHadesSpearPresentation" })
end

function TimeMirrorPresentation( usee, args, user )
	args = args or {}
	AddInputBlock({ Name = "MelUsedSystemObject" })
	HideUseButton( usee.ObjectId, usee )
	UseableOff({ Id = usee.ObjectId })
	MapState.RoomRequiredObjects[usee.ObjectId] = nil

	thread( PlayVoiceLines, GlobalVoiceLines.MirrorUsedLines )

	PanCamera({ Id = 800300, Duration = 5.0, })
	
	wait(0.1)

	Stop({ Id = CurrentRun.Hero.ObjectId })
	AdjustFullscreenBloom({ Name = "DesaturatedLight", Duration = 0.9 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.13, Duration = 1.5 }, } )

	local loopingSoundId = PlaySound({ Name = "/SFX/Menu Sounds/CauldronWhispers", Id = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_Gesture", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 1.15 })

	--SetAnimation({ Name = "Melinoe_Gesture_ToWeaponless", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })

	CreateAnimation({ Name = "CWEntranceHadesSymbolIn_Flipped", DestinationId = usee.ObjectId, OffsetZ = 140, OffsetY = -20, OffsetX = -40, Group = "Combat_Menu_TraitTray" })

	wait(2.95)

	Destroy({ Ids = GetIds({ Name = "MirrorCollision" }) })

	SetAnimation({ Name = "HouseMirrorInert", DestinationId = 390021 })
	CreateAnimation({ Name = "ZagMirrorPortalLoop", DestinationId = 390021, OffsetZ = 0 })
	CreateAnimation({ Name = "MirrorShatter", DestinationId = usee.ObjectId, Group = "Standing" })
	
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1 })
	
	ShakeScreen({ Distance = 6, Speed = 500, Duration = 0.3, FalloffSpeed = 1000 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.13, Duration = 0.5 }, } )

	PlaySound({ Name = "/SFX/Menu Sounds/HadesSigilDoorUnlock" })
	
	StopAnimation({ Name = "CWEntranceHadesSymbolLoop", DestinationId = usee.ObjectId })
	SetAlpha({ Ids = usee.RewardPreviewIconIds, Fraction = 0.0, Duration = 0 })
	AdjustFullscreenBloom({ Name = "FullscreenFlash2", Duration = 0.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1 })

	wait(1.3)
	StopAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId })
	StopSound({ Id = loopingSoundId, Duration = 0.4 })
	loopingSoundId = nil

	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId, Delay = 0.25 })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId, Delay = 0.5 })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId, Delay = 0.75 })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = usee.ObjectId })

	PanCamera({ Id = 800301, Duration = 6.2, FromCurrentLocation = true, })

	wait( 0.55 )

	--PlaySound({ Name = "/Leftovers/Menu Sounds/PlayerKilledLong_Large" })
	--wait( 0.3 )
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorTransition" })


	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "Speed", Value = 600 })
	MoveHeroToRoomPosition({ DisableCollision = true, DestinationId = 800300 })


	wait( 0.05 )
	
	CreateAnimation({ Name = "ZagMirrorPortalTransitionFx", DestinationId = 390021 })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0, Duration = 0.02 })

	wait( 0.45 )

	SetAlpha({ Ids = insidePalaceHiderIds, Fraction = 0.0, Duration = 0.5 })
	SetAlpha({ Ids = outsidePalaceHiderIds, Fraction = 1.0, Duration = 0.5 })
	StopSound({ Id = AudioState.AmbienceId, Duration = 1.0 })
	AudioState.AmbienceId = nil
	AudioState.AmbienceName = nil


	local mirrorTransitionDurationIn = 0.25
	local mirrorTransitionDurationOut = 0.5
	AdjustRadialBlurDistance({ Fraction = 0.12, Duration = mirrorTransitionDurationIn, EaseIn = 0.9, EaseOut = 1.0 })
	AdjustRadialBlurStrength({ Fraction = 10, Duration = mirrorTransitionDurationIn, EaseIn = 0.9, EaseOut = 1.0 })
	AdjustFullscreenBloom({ Name = "MirrorTransition", Duration = mirrorTransitionDurationIn })

	SetThingProperty({ Property = "Graphic", Value = "Melinoe_Hover_Idle", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StartGraphic", Value = "Melinoe_Hover_Run_Start", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "Melinoe_Hover_Run_FireLoop", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StopGraphic", Value = "Melinoe_Hover_Run_End", DestinationId = CurrentRun.Hero.ObjectId })
	--PlaySound({ Name = "/SFX/Menu Sounds/MirrorTransition" })

	thread( MoveHeroToRoomPosition, { DisableCollision = true, DestinationId = 772205 } )

	wait( 0.5 )
	

	AdjustRadialBlurDistance({ Fraction = 0.0, Duration = mirrorTransitionDurationOut, EaseIn = 0, EaseOut = 1.0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = mirrorTransitionDurationOut, EaseIn = 0, EaseOut = 1.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = mirrorTransitionDurationOut })

	AudioState.AmbienceId = PlaySound({ Name = "/SFX/Menu Sounds/MirrorAmbienceLoop", Duration = 0.5 })

	wait( 1.0 )
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 1, Duration = 1 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.19, Duration = 0.45 }, } )
	SecretMusicPlayer( "/Music/MusicExploration4_MC_Mirror" )
	
	wait( 1.1 )

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.4, FromCurrentLocation = true, })

	wait( 0.4 )

	thread( PlayVoiceLines, GlobalVoiceLines.TimeHallPresentationLines )
	-- SetSoundCueValue({ Names = { "Bass", "Drums" }, Id = AudioState.SecretMusicId, Value = 1 })
	-- SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 0 })

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })

	LockCamera({ Id = CurrentRun.Hero.ObjectId, FromCurrentLocation = true, })
	RemoveInputBlock({ Name = "MelUsedSystemObject" })

end

function DreamSpeechPresentation()
	SetAnimation({ Name = "Melinoe_Hover_End", DestinationId = CurrentRun.Hero.ObjectId })
end

function ZagreusSpearEquipPresentation( source, args )
	SetAlpha({ Id = source.ObjectId, Fraction = 0, Duration = 0.3 })
	PlaySound({ Name = "/SFX/Menu Sounds/ZagGigarosEquip" })
	CreateAnimation({ Name = "ZagMirrorPortalFadeIn", DestinationId = 741552, })
	wait( 1.0 )

	SetScale({ Id = source.ObjectId, Fraction = 0.9, })
	Move({ Id = source.ObjectId, Angle = 0, Distance = 30, Speed = 9999 })
	SetGoalAngle ({ Id = source.ObjectId, Angle = 330, CompleteAngle = true })
	SetAnimation({ Name = "Enemy_Zagreus_Spear_Idle", DestinationId = source.ObjectId })

	StopAnimation({ Name = "ZagMirrorPortalLoop", DestinationId = 741552, })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.3, Duration = 0.3 })
end

function GigarosSpellPresentation( source, args, originalArgs )
	wait( args.PreWait, NarrativeThreadName )
	SetAnimation({ Name = args.SetAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	PowerWordPresentation( source, args, originalArgs )
end

function BedroomToChronosSanctumPresentation( source, args )

	StopSecretMusic()
	EndAmbience()

	FullScreenFadeOutAnimation( "RoomTransitionIn_TimeWarp_Slow" )

	thread( PlayVoiceLines, GlobalVoiceLines.ZagreusPastFollowUpLines )
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })

	wait(2.0)

	SetAudioEffectState({ Name = "Reverb", Value = 1.0 })
	SetAudioEffectState({ Name = "GlobalEcho", Value = 0.65 })

	-- Set up the camera and overlays
	ClearCameraClamp({ LerpTime = 0 })
	FocusCamera({ Fraction = 0.82, Duration = 0 })
	PanCamera({ Id = 772217 }) -- offscreen camera target
	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 0.0, Duration = 0.0 })
	StopAnimation({ Name = SessionMapState.NightmareVignetteAnimationName, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	
	-- PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	wait(2.0)

	AudioState.AmbienceId = PlaySound({ Name = "/Leftovers/Object Ambiences/EvilLairAmbienceMatchSiteE", Duration = 0.5 })

	wait(1.0)
	thread( DisplayInfoBanner, nil,
		{
			Text = "Location_Sanctum",
			SubtitleText = "Location_Sanctum_Subtitle",
			Delay = 1.5,
			SubtitleDelay = 0.5,
			SubtitleOffsetY = 15,
			Duration = 3.5,
			Layer = "Overlay",
			AnimationName = "LocationBackingIrisSmallIn",
			AnimationOutName = "LocationBackingIrisSmallOut",
			IconBackingAnimationName = "LocationBackingIrisSubtitleStarIn",
			IconBackingAnimationOutName = "LocationBackingIrisSubtitleStarOut",
		} )

	-- Begin the dramatic narrative sequence...
	local chronosId = 772221
	local zagreusId = 741734

	SetAnimation({ Name = "Enemy_Zagreus_Spear_Idle", DestinationId = zagreusId })
	SetAlpha({ Id = zagreusId, Fraction = 1, Duration = 0 })
	SetScale({ Id = zagreusId, Fraction = 1.0, })
	Teleport({ Id = zagreusId, DestinationId = 772219 })
	AdjustZLocation({ Id = zagreusId, Distance = 0 - GetZLocation({ Id = zagreusId }) })
	AngleTowardTarget({ Id = zagreusId, DestinationId = chronosId })
	SetAnimation({ Name = "Enemy_Chronos_Knockdown_FireLoop", DestinationId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Chronos_Story_01" }) })

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation( "RoomTransitionOut_TimeWarp_Slow" )

	PanCamera({ Id = chronosId, Duration = 14.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedHel", Delay = 0.25 })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow", Delay = 2 })
	waitUnmodified( 1.0 )
	SecretMusicPlayer( "/Music/MusicStyx1_MC_Chronos" )

	waitUnmodified( 7.0 )

	thread( PlayVoiceLines, GlobalVoiceLines.ChronosSanctumGreetingLines )
	thread( SatyrBattleSounds )
	waitUnmodified( 14.0 )
	PanCamera({ Id = 800310, Duration = 9, })
	waitUnmodified( 3.0 )

	MoveHeroToRoomPosition({ MoverId = zagreusId, DestinationId = 772234, DisableCollision = true, Speed = 500 })

	waitUnmodified( 3.1 )

	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 1.0, Duration = 0.5 })

end

function SatyrBattleSounds()

	-- satyr 1
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/ZagSmokeDisappear", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/HadesSpearEmerge", Id = 772219 })
	wait(0.6)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/EmoteAlerted", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerEvade2", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerRangedAttackWhoosh", Id = 772219 })
	wait(1.2)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusDash", Id = 772219 })
	wait(0.1)
	PlaySound({ Name = "/VO/ZagreusEmotes/EmoteHeavyShieldThrow", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/Hades360Swipe", Id = 772219 })
	wait(0.6)
	PlaySound({ Name = "/SFX/MetalBoneSmashSHIELD", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrRatCatcher/EmoteHurt", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/EnemyDeathSFXIris", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/EmoteDying", Id = 772219 })

	-- satyr 2
	wait(0.5)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrCultist/EmoteAlerted", Id = 772219 })
	wait(0.5)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusDash", Id = 772219 })
	wait(0.1)
	PlaySound({ Name = "/VO/ZagreusEmotes/EmoteHeavySpecialAttack", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/HadesSpearStab", Id = 772219 })
	wait(0.6)
	PlaySound({ Name = "/SFX/MetalBoneSmashSHIELD", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrCultist/EmoteHurt", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrCultist/EmoteDying", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/EnemyDeathSFXIris", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusDash", Id = 772219 })

	-- satyr 3
	wait(0.6)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/EmoteAlerted", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerEvade2", Id = 772219 })
	wait(0.1)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusDash", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/VO/ZagreusEmotes/EmoteHeavyShieldThrow", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusSpearThrow", Id = 772219 })
	wait(0.6)
	PlaySound({ Name = "/SFX/MetalBoneSmashSHIELD", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/Satyr/EmoteHurt", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/Satyr/EmoteDying", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/EnemyDeathSFXIris", Id = 772219 })

	-- satyr 4
	wait(0.5)
	PlaySound({ Name = "/SFX/Enemy Sounds/Satyr/EmoteTaunting", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerRangedAttackWhoosh", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusDash", Id = 772219 })
	wait(0.1)
	PlaySound({ Name = "/VO/ZagreusEmotes/EmoteHeavySpecialAttack", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/HadesFireSkullImpact", Id = 772219 })
	wait(0.6)
	PlaySound({ Name = "/SFX/MetalOrganicHitSHIELD", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/EmoteHurt", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/EmoteDying", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/EnemyDeathSFXIris", Id = 772219 })

	-- satyr 5
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/ZagSmokeDisappear", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/HadesSpearEmerge", Id = 772219 })
	wait(0.6)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/EmoteAlerted", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerEvade2", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerRangedAttackWhoosh", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusDash", Id = 772219 })
	wait(0.1)
	PlaySound({ Name = "/VO/ZagreusEmotes/EmoteHeavyShieldThrow", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/Hades360Swipe", Id = 772219 })
	wait(0.6)
	PlaySound({ Name = "/SFX/MetalBoneSmashSHIELD", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/EmoteHurt", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/EnemyDeathSFXIris", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/EmoteDying", Id = 772219 })

	-- satyr 6
	wait(0.6)
	PlaySound({ Name = "/SFX/Enemy Sounds/Satyr/EmoteAlerted", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerEvade2", Id = 772219 })
	wait(0.1)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusDash", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/VO/ZagreusEmotes/EmoteHeavyShieldThrow", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusSpearThrow", Id = 772219 })
	wait(0.3)
	PlaySound({ Name = "/SFX/MetalBoneSmashSHIELD", Id = 772219 })
	wait(0.2)
	PlaySound({ Name = "/SFX/Enemy Sounds/Satyr/EmoteHurt", Id = 772219 })
	PlaySound({ Name = "/SFX/MetalBoneSmashSHIELD", Id = 772219 })
	wait(0.4)
	PlaySound({ Name = "/SFX/Enemy Sounds/Satyr/EmoteDying", Id = 772219 })
	PlaySound({ Name = "/SFX/Enemy Sounds/EnemyDeathSFXIris", Id = 772219 })

	wait(1.3)
	PlaySound({ Name = "/SFX/LastKillSFX", Id = 772219 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0, Duration = 0.25 })

end

GlobalVoiceLines.ChronosCorneredVoiceLines =
{
	{
		ObjectTypes = { "NPC_Zagreus_Past_01" },
		PreLineWait = 0.76,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Zagreus_0111", Text = "...That's it, I'm stabbing you." },
	},
	{
		ObjectTypes = { "NPC_Chronos_01", "NPC_Chronos_Story_01" },
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Chronos_1306", Text = "No, wait!" },
	},
}

function ChronosSanctumExitPresentation( source, args )

	args = args or {}

	AdjustRadialBlurDistance({ Fraction = 3.0, Duration = 2 })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = 2 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweep" })

	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 10 })
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

	thread( PlayVoiceLines, GlobalVoiceLines.ChronosCorneredVoiceLines )
	wait( 1.65 )
	SetAnimation({ Name = "Enemy_Zagreus_Threaten", DestinationId = 741734 })
	wait( 0.25 )
	FullScreenFadeOutAnimation( "RoomTransitionIn_TimeWarp_Alt", "ChronosSand" )
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1 })

	EndAmbience()
	--PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedHel" })

	waitUnmodified( 1.5 )

	local nextRoom = CreateRoom( RoomData.I_ChronosFlashback01 )
	CurrentRun.CurrentRoom = nextRoom
	RequestSave({ StartNextMap = nextRoom.Name, SaveName = "_Temp", DevSaveName = CreateDevSaveName( CurrentRun ) })
	LoadMap({ Name = nextRoom.Name, LoadBackgroundColor = nextRoom.LoadBackgroundColor })

	-- see SetupFlashback03
end

GlobalVoiceLines.SanctumToBedroomVoiceLines =
{
	{
		UsePlayerSource = true,
		PreLineWait = 0.8,
		{ Cue = "/VO/MelinoeField_5141", Text = "{#Emph}<Gasp> {#Prev}I... remember... all of that?" },
		{ Cue = "/VO/MelinoeField_5214", Text = "My life... the way it could have been...?", PreLineWait = 1.0 },
		{ Cue = "/VO/MelinoeField_5142", Text = "Oh gods... Zagreus... did it work...?", PreLineWait = 1.2 },
		{ Cue = "/VO/MelinoeField_5143", Text = "What's going on out there...?", PreLineWait = 1.1 },
	},
}

function MelBackToBedroomPresentation( source, args )
	AddInputBlock({ Name = "MelBackToBedroomPresentation" })

	-- Conclude flashback
	SessionState.InFlashback = false

	wait( 0.8 )

	DestroyCameraWalls({ })

	-- Restore Mel to her normal self
	CurrentRun.Hero.SubtitleColor = HeroData.SubtitleColor
	CurrentRun.Hero.NarrativeFadeInColor = HeroData.NarrativeFadeInColor
	CurrentRun.Hero.LineHistoryName = HeroData.LineHistoryName
	CurrentRun.Hero.AttachedAnimationName = HeroData.AttachedAnimationName

	--SetThingProperty({ Property = "ExtentScale", Value = "Default", DestinationId = CurrentRun.Hero.ObjectId })
	SetScale({ Id = CurrentRun.Hero.ObjectId, Fraction = 1.0 })
	SetThingProperty({ Property = "GrannyModel", Value = "Default", DestinationId = CurrentRun.Hero.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "Default", DestinationId = CurrentRun.Hero.ObjectId })
	SetThingProperty({ Property = "Tallness", Value = "Default", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StartGraphic", Value = "MelinoeStart", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "MelinoeRun", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StopGraphic", Value = "MelinoeStop", DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
	CurrentRun.Hero.AnimOffsetZ = HeroData.AnimOffsetZ
	SetConfigOption({ Name = "SubtitleASubString", Value = "Mel" })

	-- Move Mel next to the bed, facing it
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 746922 })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 310036 })
	SetAnimation({ Name = "Melinoe_KnockedDown_FireLoop", DestinationId = CurrentRun.Hero.ObjectId })

	SetAudioEffectState({ Name = "Reverb", Value = -1 })
	SetAudioEffectState({ Name = "GlobalEcho", Value = 0 })

	StopAnimation({ Name = SessionMapState.NightmareVignetteAnimationName, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })

	-- PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.0, OffsetY = -350, Retarget = true })

	waitUnmodified( 1.0 )

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 14.0, OffsetY = -150, Retarget = true })

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation( "RoomTransitionOut_TimeWarp_Slow" )
	AdjustColorGrading({ Name = "Sepia", Duration = 0.01 })
	wait(0.01)
	AdjustColorGrading({ Name = "Off", Duration = 4 })

	waitUnmodified( 0.5 )

	thread( PlayVoiceLines, GlobalVoiceLines.SanctumToBedroomVoiceLines )

	waitUnmodified( 8.5 )

	SetAnimation({ Name = "Melinoe_KnockedDown_End", DestinationId = CurrentRun.Hero.ObjectId })

	thread( DisplayInfoBanner, nil, { Text = "PostNightmareMessage", SubtitleText = "PostNightmareMessage_Subtitle", Delay = 0.5, Layer = "Overlay",
		AnimationName = "LocationBackingIrisSmallIn",
		AnimationOutName = "LocationBackingIrisSmallOut",
		IconBackingAnimationName = "LocationBackingIrisSubtitleStarIn",
		IconBackingAnimationOutName = "LocationBackingIrisSubtitleStarOut",
		SubtitleOffsetY = 15,
		SubtitleDelay = 0.5,
	} )


	waitUnmodified( 0.45 )

	RemoveInputBlock({ Name = "MelBackToBedroomPresentation" })

end

function StartTrueEndingMusic()

	SecretMusicPlayer( "/Music/MusicHadesReset2_MC" )
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 0 })
	SetSoundCueValue({ Names = { "Drums", "Bass" }, Id = AudioState.SecretMusicId, Value = 0 })

end

-- True Ending
function DeathAreaRestoredEntrance( currentRun, currentRoom )
	local roomData = RoomData[currentRoom.Name] or currentRoom

	SessionMapState.BlockCodexUnlockPresentation = true
	SessionMapState.BlockCodex = true

	AddInputBlock({ Name = "DeathAreaRestoredEntrance" })

	thread( PlayVoiceLines, roomData.EnterVoiceLines, true )

	local chronosId = 774365
	ActiveEnemies[chronosId].AnimOffsetZ = -30
	SetAnimation({ Name = "Enemy_Chronos_Knockdown_FireLoop", DestinationId = chronosId })

	SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
	wait( 3.8 )

	CutsceneAddLetterbox( { Silent = true } )
	FadeIn({ Duration = 0.0 })	
	FullScreenFadeInAnimation( currentRoom.EnterWipeAnimationOverride or roomData.EnterWipeAnimation or GetDirectionalWipeAnimation( { TowardsId = currentRoom.HeroEndPoint, Enter = true } ) )
	
	thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision = true, UseDefaultSpeed = not roomData.EntrancePresentationUsePlayerSpeed, Invulnerable = true } )

	PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomData.IntroSequenceDuration, EaseIn = roomData.IntroPanEaseIn, EaseOut = roomData.IntroPanEaseOut })

	wait( 0.03 )

	wait( roomData.IntroSequenceDuration )
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })

	PlaySound({ Name = "/Music/ARStinger_Strings_2" })
	SecretMusicPlayer( "/Music/MusicHadesReset3_MC" )
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 0 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })

	local hadesId = 774441
	local persephoneId = 774443
	local zagreusId = 774442
	SetAlpha({ Ids = { hadesId, persephoneId, zagreusId }, Fraction = 0 })

	wait( 0.3 )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 774443 })
	SetAnimation({ Name = "MelTalkBrooding01", DestinationId = CurrentRun.Hero.ObjectId })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	wait( 1.1 )
	MoveHeroToRoomPosition( { DestinationId = 774447 } )

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	thread( DeathAreaRestoredEntranceLetterboxFade )
	
	wait( 0.4 )

	RemoveInputBlock({ Name = "DeathAreaRestoredEntrance" })
end

function DeathAreaRestoredEntranceLetterboxFade()
	wait( 1.15 )
	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = 0, Duration = 0.4 })
end

GlobalVoiceLines.PromptFamilyRescueVoiceLines =
{
	{
		PreLineWait = 1.35,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Chronos_Story_01",

		{ Cue = "/VO/Chronos_1377", Text = "Go on, then..." },
	},
}
GlobalVoiceLines.FamilyEntranceVoiceLines =
{
	{
		PreLineWait = 0.25,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		ObjectType = "NPC_Hades_Story_01",

		{ Cue = "/VO/Hades_0207", Text = "{#Emph}Augh...! <Gasp>" },
	},
	{
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		PreLineAnim = "MelTalkBroodingFull01",

		{ Cue = "/VO/MelinoeField_3575", Text = "Father! Mother... Brother...!" },
	}
}
GlobalVoiceLines.FamilyUnfrozenVoiceLines =
{
	Queue = false,
	{
		PreLineWait = 0.3,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		StatusAnimation = "StatusIconSpeaking_Persephone_Falling",
		ObjectType = "NPC_Persephone_01",

		{ Cue = "/VO/Persephone_0009", Text = "{#Emph}<Gasp> Augh... {#Prev}Hades... I..." },
	},
	{
		PreLineWait = 0.6,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,
		{ Cue = "/VO/MelinoeField_4971", Text = "Mother...!" },
	},
}
GlobalVoiceLines.FamilyUnfrozenVoiceLinesZag =
{
	{
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		SkipAnim = true,
		ObjectType = "NPC_Zagreus_01",

		{ Cue = "/VO/Zagreus_0112", Text = "{#Emph}<Gasp>" },
	},
}

function SummonFamilyMembers( source, args )

	Destroy({ Id = ScreenAnchors.DialogueBackgroundId })

	SecretMusicPlayer( "/Music/EndThemeAcoustic" )
	wait( 0.3 )

	local zagreusId = 774442
	SetAlpha({ Id = zagreusId, Fraction = 1.0, Duration = 0.2 })
	SetAnimation({ DestinationId = zagreusId, Name = "Zagreus_Frozen" })
	CreateAnimation({ DestinationId = zagreusId, Name = "ChronosTeleportFxFront" })	
	UseableOff({ Id = zagreusId })
	wait( 0.2 )
	thread( PlayVoiceLines, GlobalVoiceLines.FamilyEntranceVoiceLines )

	local hadesId = 774441
	SetAlpha({ Id = hadesId, Fraction = 1.0, Duration = 0.2 })
	CreateAnimation({ DestinationId = hadesId, Name = "ChronosTeleportFxFront" })
	UseableOff({ Id = hadesId })
	wait( 0.3 )

	local persephoneId = 774443
	SetAlpha({ Id = persephoneId, Fraction = 1.0, Duration = 0.2 })
	SetAnimation({ DestinationId = persephoneId, Name = "Persephone_Frozen" })
	CreateAnimation({ DestinationId = persephoneId, Name = "ChronosTeleportFxFront" })
	UseableOff({ Id = persephoneId })

	wait( 5.3 )
	CreateDialogueBackground()

end

function SetupFamilyRescueCamera( source, args )
	Activate({ Ids = { 800724, 800723 } })
	thread( PlayVoiceLines, GlobalVoiceLines.PromptFamilyRescueVoiceLines )
end

function FamilyRescuePresentation( source, args )

	AddInputBlock({ Name = "FamilyRescuePresentation" })
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	wait( 0.01 )

	PanCamera({ Id = args.PanId, Duration = 20.0, Retarget = true })

	SetAnimation({ Name = "Melinoe_Gesture", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.8 })
	CreateAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })

	PlaySound({ Name = "/Leftovers/World Sounds/MapText" })

	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic2", Id = CurrentRun.Hero.ObjectId, Delay = 2.5 })

	
	thread( PlayVoiceLines, args.VoiceLines )
	wait(0.4)
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
	wait(3.5)
	-- SecretMusicPlayer( "/Music/EndThemeORCHESTRAL" )

	local persephoneId = 774443
	SetAnimation({ DestinationId = persephoneId, Name = "Persephone_Sitting_Start" })
	StopAnimation({ DestinationId = persephoneId, Name = "NightmareStasisFxPersephone", IncludeCreatedAnimations = true })
	StopAnimation({ DestinationId = persephoneId, Names = { "NightmareStasisFxFrontPersephone", "NightmareStasisFxTerrainA", "NightmareStasisFxTerrainB", "NightmareStasisFxTerrainC", "NightmareStasisFxBack" }, })
	StopAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.1 )

	local zagreusId = 774442
	local zagreus = ActiveEnemies[zagreusId]
	SetAnimation({ DestinationId = zagreusId, Name = "Zagreus_KnockedDown_Start" })
	StopAnimation({ DestinationId = zagreusId, Name = "NightmareStasisFxZagreus", IncludeCreatedAnimations = true })
	StopAnimation({ DestinationId = zagreusId, Names = { "NightmareStasisFxFrontZagreus", "NightmareStasisFxTerrainA", "NightmareStasisFxTerrainB", "NightmareStasisFxTerrainC", "NightmareStasisFxBack" }, })
	CreateAnimation({ DestinationId = persephoneId, Name = "NightmareStasisFxEndPersephone" })
	CreateAnimation({ DestinationId = zagreusId, Name = "NightmareStasisFxEndZagreus" })

	thread( PlayVoiceLines, GlobalVoiceLines.FamilyUnfrozenVoiceLinesZag )
	thread( PlayVoiceLines, GlobalVoiceLines.FamilyUnfrozenVoiceLines )

	wait( 2.8 )

	local offset = CalcOffset( math.rad( GetAngle({ Id = persephoneId }) ), 135 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = persephoneId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition({ DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true })
	end
	thread( DestroyOnDelay, { offsetPointId }, 5 )

	SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = 145 })
	SetAnimation({ Name = "Melinoe_Assist", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 3.2 )
	ProcessTextLines( zagreus, args.TextLineSet )
	PlayRandomRemainingTextLines( zagreus, args.TextLineSet )

	RemoveInputBlock({ Name = "FamilyRescuePresentation" })

end

function HadesOfficialDecree()

	Destroy({ Id = ScreenAnchors.DialogueBackgroundId })

	SecretMusicPlayer( "/Music/EndThemeORCHESTRAL" )
	wait( 0.4 )

	--local hadesId = 774441
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelTalkPensive01", SpeedMultiplier = 0.35 })
	PlaySound({ Name = "/VO/Melinoe_0337", Id = CurrentRun.Hero.ObjectId, Delay = 1.0 })

	wait( 2.79 )
	CreateDialogueBackground()
end

GlobalVoiceLines.DeathAreaRestorationVoiceLines =
{
	{
		PreLineWait = 0.45,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		Source = { LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice },

		{ Cue = "/VO/Hades_0382", Text = "Then be so kind as to get these chains off me, so we can get to work!" },
	},
	{
		PreLineWait = 3.55,
		Source = { LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice },

		{ Cue = "/VO/Storyteller_0523", Text = "{#Emph}And so, the Princess of the Dead remained in the House of Hades with the Titan of Time and the rest, to aid in the recovery of however much was not forever lost.", TextLimit = 300, NoTarget = true },
		{ Cue = "/VO/Storyteller_0517", PreLineWait = 1.25, Text = "{#Emph}The rightful Underworld King and Queen were swift to organize this relatively painless task, and Shades of the Dead still loyal to their cause answered the call.", TextLimit = 300, NoTarget = true },
		{ Cue = "/VO/Storyteller_0524", PreLineWait = 1.25, Text = "{#Emph}They and the Titan picked up many pieces of the past...", NoTarget = true },
		{ Cue = "/VO/Storyteller_0525", PreLineWait = 1.25, Text = "{#Emph}...and soon, the House grew more like how it used to be. But then, a summons from Olympus arrived, and the Princess knew her stay had reached its end...", TextLimit = 300, NoTarget = true },
	},
}
GlobalVoiceLines.TimeToGoVoiceLines =
{
	{
		PreLineWait = 1.08,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,

		{ Cue = "/VO/MelinoeField_4278", Text = "{#Emph}<Sigh> {#Prev}Well, this is it..." },
	},
}
function DeathAreaRestorationPresentation( source, args )

	args = args or {}

	-- StopSecretMusic()

	waitUnmodified( 0.5 )

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	FullScreenFadeOutAnimation( "RoomTransitionIn_Right" )
	
	thread( PlayVoiceLines, GlobalVoiceLines.DeathAreaRestorationVoiceLines )
	--wait( 5.8 )
	wait( 5.3 )
	DeathAreaRestorationIllustrationPresentation()

	StopSound({ Id = AudioState.AmbienceId, Duration = 0.5 })
	AudioState.AmbienceId = nil
	AudioState.AmbienceName = nil

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 3.0, OffsetY = -500, Retarget = true })
	SetCameraClamp({ Ids = CurrentRun.CurrentRoom.RestoredCameraClamps, SoftClamp = CurrentRun.CurrentRoom.SoftClamp })
	waitUnmodified( 1.5 )

	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 421154 })
	SetAnimation({ Name = "MelinoeIdle", DestinationId = CurrentRun.Hero.ObjectId })
	SetupMelWalk()

	-- teleport the characters
	local persephoneId = 774443
	SetAnimation({ DestinationId = persephoneId, Name = "Persephone_Idle" })
	-- Teleport({ Id = persephoneId, DestinationId = 800751 })
	Teleport({ Id = persephoneId, DestinationId = 800751 })
	UseableOn({ Id = persephoneId })
	SetInteractProperty({ DestinationId = persephoneId, Property = "OffsetX", Value = -10 })
	SetInteractProperty({ DestinationId = persephoneId, Property = "OffsetY", Value = 110 })
	SetInteractProperty({ DestinationId = persephoneId, Property = "Distance", Value = 120 })

	local zagreusId = 774442
	SetAnimation({ DestinationId = zagreusId, Name = "Zagreus_Idle" })
	SetGoalAngle ({ Id = zagreusId, Angle = 210, CompleteAngle = true })
	Teleport({ Id = zagreusId, DestinationId = 391547 })
	UseableOn({ Id = zagreusId })

	local hecateId = 774366
	Teleport({ Id = hecateId, DestinationId = 774445 })
	SetGoalAngle ({ Id = hecateId, Angle = 201, CompleteAngle = true })

	Destroy({ Id = 774441 }) -- chained hades
	Destroy({ Id = 774365 }) -- old chronos

	ActivatePrePlaced( source,
	{
		Types = { "NPC_Selene_01", "NPC_Chronos_02", "NPC_Nyx_Story_01" },
	})

	CheckPriorityConversations( source, args ) -- activates the other NPCs

	local chronosId = 774458
	UseableOff({ Id = chronosId, "UsePersephoneInteractRangeOnly" })

	AudioState.AmbienceId = PlaySound({ Name = "/Ambience/MusicExploration4AMBIENCEIris", Duration = 0.5 })
	SetAudioEffectState({ Name = "Reverb", Value = 1.75 })
	SetAudioEffectState({ Name = "GlobalEcho", Value = 0.1 })

	SessionMapState.BlockCodex = nil

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 774444 })

	waitUnmodified( 2.0 )

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 4, Retarget = true })

	FullScreenFadeInAnimation( "RoomTransitionOut_Down" )
	thread( PlayVoiceLines, GlobalVoiceLines.TimeToGoVoiceLines )

	waitUnmodified( 2.0 )

end

function BlockAchillesInteraction( source, args )
	wait( 0.02 )
	AddInteractBlock( source, "BlockAchillesInteraction" )
	StopStatusAnimation( source )
end

function RestoreAchillesInteraction()

	local achillesId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Achilles_01" })
	local achilles = ActiveEnemies[achillesId]
	RemoveInteractBlock( achilles, "BlockAchillesInteraction" )
	PlayStatusAnimation( achilles, { Animation = StatusAnimations.WantsToTalk } )

end

Using "HouseRenovation"
function DeathAreaRestorationIllustrationPresentation()

	local illustrationId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Animation = "HouseRenovation", X = ScreenCenterX + 960, Y = ScreenCenterY, Alpha = 0.0 })

	PlaySound({ Name = "/SFX/Menu Sounds/AdminConstructionSound", Delay = 0.25 })
	AltAspectRatioFramesShow()
	FullScreenFadeInAnimation( "RoomTransitionOut_Right" )

	local loopingSoundId = PlaySound({ Name = "/Leftovers/Object Ambiences/ReconstructionAmbience" })

	SetAlpha({ Id = illustrationId, Fraction = 1.0, Duration = 0.01 })
	Shift({ Id = illustrationId, OffsetX = -1920, OffsetY = 0, Duration = 44.0, EaseIn = 0, EaseOut = 1.0 })
	waitUnmodified( 43.0 )

	StopSound({ Id = loopingSoundId, Duration = 0.4 })
	loopingSoundId = nil

	FullScreenFadeOutAnimation( "RoomTransitionIn_Down" )
	waitUnmodified( 0.5 )
	AltAspectRatioFramesHide()

	Destroy({ Id = illustrationId })

end

function DeathAreaRestoredUpdateHallwayBlocks( source, args )
	local firstImpassabilityId = 800606
	local secondImpassabilityId = 800607
	if IsAlive({ Id = firstImpassabilityId }) and CurrentRun.TextLinesRecord.ZagreusTrueEnding01 and CurrentRun.TextLinesRecord.AchillesTrueEnding01 and CurrentRun.TextLinesRecord.CerberusTrueEnding01 and CurrentRun.TextLinesRecord.PersephoneTrueEnding01 then
		local hiderIds = GetIds({ Names = { "HallwayDimmers01" } })
		SetAlpha({ Ids = hiderIds, Fraction = 0.0, Duration = 0.35 })
		thread( DestroyOnDelay, hiderIds, 0.35 )
		Destroy({ Id = firstImpassabilityId })
		-- PlayStatusAnimation( ActiveEnemies[774443], { Animation = "StatusIconWantsToTalk" } ) -- persephone
		PlayStatusAnimation( ActiveEnemies[774463], { Animation = "StatusIconWantsToTalk" } ) -- hades
		-- PlayStatusAnimation( ActiveEnemies[800752], { Animation = "StatusIconWantsToTalk" } ) -- achilles
	elseif IsAlive({ Id = secondImpassabilityId }) and CurrentRun.TextLinesRecord.HadesTrueEnding01 then
		local hiderIds = GetIds({ Names = { "HallwayDimmers02" } })
		SetAlpha({ Ids = hiderIds, Fraction = 0.0, Duration = 0.35 })
		thread( DestroyOnDelay, hiderIds, 0.35 )
		Destroy({ Id = secondImpassabilityId })
		PlayStatusAnimation( ActiveEnemies[774446], { Animation = "StatusIconWantsToTalk" } ) -- nyx
	end
end

function SetupEndSceneZoom( source )
	FocusCamera({ Fraction = 0.9, Duration = 12.0 })
	PanCamera({ Id = 555661, Duration = 12.0, })
end

GlobalVoiceLines.NyxExitVoiceLines =
{
	{
		PreLineWait = 0.4,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		PreLineAnim = "Nyx_Greeting",
		ObjectType = "NPC_Nyx_Story_01",

		{ Cue = "/VO/Nyx_0034", Text = "Farewell." },
	},
}
function NyxFarewellPresentation( source )

	local nyxId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Nyx_Story_01" })
	SetAnimation({ DestinationId = ScreenAnchors.DialogueBackgroundId, Name = "DialogueBackgroundOut" })

	waitUnmodified( 0.1 )
	Destroy({ Id = ScreenAnchors.DialogueBackgroundId })

	thread( PlayVoiceLines, GlobalVoiceLines.NyxExitVoiceLines )

	waitUnmodified( 2.25, RoomThreadName )
	CreateDialogueBackground()
end

function EnsembleFamilyEnterPresentation( source, args )
	local hadesId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Hades_02" })
	local persephoneId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Persephone_01" })
	local zagreusId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Zagreus_01" })

	SetGoalAngle({ Id = hadesId, Angle = 330 })
	SetGoalAngle({ Id = persephoneId, Angle = 320 })
	SetGoalAngle({ Id = zagreusId, Angle = 340 })

	SetAlpha({ Id = hadesId, Fraction = 0.0, Duration = 0.0 })
	SetAlpha({ Id = persephoneId, Fraction = 0.0, Duration = 0.0 })
	SetAlpha({ Id = zagreusId, Fraction = 0.0, Duration = 0.0 })

	wait( 0.6 )

	-- silently teleport Hades, Persephone, & Zag just offscreen
	Teleport({ Id = hadesId, DestinationId = 555690 })
	Teleport({ Id = persephoneId, DestinationId = 555689 })
	Teleport({ Id = zagreusId, DestinationId = 556836 })

	SetAlpha({ Id = hadesId, Fraction = 1.0, Duration = 0.2 })
	SetAlpha({ Id = persephoneId, Fraction = 1.0, Duration = 0.2 })
	SetAlpha({ Id = zagreusId, Fraction = 1.0, Duration = 0.2 })
end

function EnsembleRidersEnterPresentation( source )

	local hecateId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Hecate_Story_01" })
	local hecate = ActiveEnemies[hecateId]
	if hecate ~= nil then
		Destroy({ Id = hecate.ChatBubbleId })
	end
	local chronosId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Chronos_02" })
	local chronos = ActiveEnemies[chronosId]
	if chronos ~= nil then
		Destroy({ Id = chronos.ChatBubbleId })
	end

	SetGoalAngle({ Id = hecateId, Angle = 160 })
	SetGoalAngle({ Id = chronosId, Angle = 150 })

	SetAnimation({ DestinationId = ScreenAnchors.DialogueBackgroundId, Name = "DialogueBackgroundOut" })

	waitUnmodified( 0.1 )
	Destroy({ Id = ScreenAnchors.DialogueBackgroundId })

	-- teleport in Hecate
	SetAlpha({ Id = hecateId, Fraction = 0.0, Duration = 0.35 })

	wait( 0.5, RoomThreadName )
	SecretMusicPlayer( "/Music/ArtemisTheme_MC" )

	Teleport({ Id = hecateId, DestinationId = 555692 })
	SetAnimation({ Name = "HecateHubGreet", DestinationId = hecateId })
	CreateAnimation({ Name = "HecateTeleportFxFront", DestinationId = hecateId, Group = "FX_Standing_Add" })
	SetAlpha({ Id = hecateId, Fraction = 1.0, Duration = 0.2 })
 
 	-- teleport in Chronos
	SetAlpha({ Id = chronosId, Fraction = 0.0, Duration = 0.35 })
	wait( 1.5, RoomThreadName )

	Teleport({ Id = chronosId, DestinationId = 555691 })
	CreateAnimation({ DestinationId = chronosId, Name = "ChronosTeleportFxFront" })
	SetAlpha({ Id = chronosId, Fraction = 1.0, Duration = 0.2 })

	wait( 1.0, RoomThreadName )
end

function ChariotDeparturePresentation( source, args )
	AddInputBlock({ Name = "ChariotDeparturePresentation" })
	PanCamera({ Id = 555661, Duration = 25.0, OffsetY = -180, Retarget = true, FromCurrentLocation = true, })
	wait( 7.0 )
	AdjustFullscreenBloom({ Name = "NewType07", Duration = 5 })
end

function DeathAreaRestoredToCreditsPresentation()
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedEnding" })

	FullScreenFadeOutAnimation( "RoomTransitionIn_Up" )

	wait( 2.0 )

	RemoveInputBlock({ Name = "ChariotDeparturePresentation" })
	local nextRoom = CreateRoom( RoomData.EndCredits01 )
	CurrentRun.CurrentRoom = nextRoom
	UnloadPackages({ Names = { "Achilles" } }) -- Just need to get back under limit
	RequestSave({ StartNextMap = nextRoom.Name, SaveName = "_Temp", DevSaveName = CreateDevSaveName( CurrentRun ) })
	LoadMap({ Name = nextRoom.Name, LoadBackgroundColor = nextRoom.LoadBackgroundColor })

end

function RoomEntranceEndCredits( currentRun, currentRoom, args )
	args = args or {}

	FullScreenFadeInAnimation( "RoomTransitionOut_Up")
	AdjustFullscreenBloom({ Name = "NewType07", Duration = 0.01 })
	PanCamera({ Id = args.CameraLockId, Duration = 0, OffsetY = 180, })

	AdjustColorGrading({ Name = "Off", Duration = 0.0 })
	AltAspectRatioFramesShow()

	SetAnimation({ Name = "Horse_FlyingIdle_Chronos_Idle", DestinationId = args.ChariotId })

	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0, })

	wait(0.03)

	LockCamera({ Id = args.CameraLockId, Duration = 3, Retarget = true })
	FadeIn({ Duration = 0.65 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })

	wait( 2.65 )
	PlayVoiceLines( roomData.EnterVoiceLines, true )

end

GlobalVoiceLines.ChronosEndCreditsSendOffVoiceLines =
{
	{
		PreLineWait = 0.65,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		Source = { LineHistoryName = "NPC_Chronos_02", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Chronos_1335", Text = "Right. Off I go." },
	},
}
GlobalVoiceLines.ChronosExitReactionVoiceLines =
{
	{
		PreLineWait = 1.65,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_0432", Text = "{#Emph}<Sigh>" },
	},
}
GlobalVoiceLines.TwinsEntranceVoiceLines =
{
	{
		PreLineWait = 0.45,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		Source = { LineHistoryName = "NPC_Apollo_01", SubtitleColor = Color.ApolloVoice },

		{ Cue = "/VO/Apollo_0203", Text = "Well good evening!" },
	},
	{
		PreLineWait = 0.45,
		PlayOverTextLines = true,
		AllowTalkOverTextLines = true,
		Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },

		{ Cue = "/VO/Artemis_0381", Text = "Thought we'd drop in!" },
	},
}
function TwinsEntrancePresentation( source )

	waitUnmodified( 0.1 )
	SetAnimation({ DestinationId = ScreenAnchors.DialogueBackgroundId, Name = "DialogueBackgroundOut" })
	waitUnmodified( 0.1 )	
	Destroy({ Id = ScreenAnchors.DialogueBackgroundId })

	thread( PlayVoiceLines, GlobalVoiceLines.ChronosEndCreditsSendOffVoiceLines )

	local notifyName = "ChariotAnimationComplete"
	NotifyOnAnimationTimeRemaining({ Id = source.ObjectId, Animation = "Horse_FlyingIdle_Chronos_Idle", Remaining = 0.032, Notify = notifyName, Timeout = 10 })
	waitUntil( notifyName )

	SetAnimation({ Name = "Horse_FlyingIdle_Chronos_Out", DestinationId = source.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.ChronosExitReactionVoiceLines )

	waitUnmodified( 4, RoomThreadName )

	PlayVoiceLines( GlobalVoiceLines.TwinsEntranceVoiceLines )

	waitUnmodified( 0.5 )
	CreateDialogueBackground()

end

function CreditsSecretMusicOff()
	SecretMusicPlayer( "/EmptyCue" )
end

function SetupEndingCredits()
	AddInputBlock({ Name = "EndingCredits" })
	SecretMusicPlayer( "/Music/ArtemisTheme_MC" )
	SetAlpha({ Id = 723539, Fraction = 0.0 }) -- hide the constellation
	SetAlpha({ Ids = { 780633, 780634}, Fraction = 0.0 }) -- hide Artemis and Apollo
	AdjustFullscreenBloom({ Name = "EndCreditsBloomIris", Duration = 0.5 })
	local windEmitter = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_UI", })
	CreateGroup({ Name = "Cloud_02_FX" })
	CreateGroup({ Name = "Cloud_03_FX" })
	CreateGroup({ Name = "Moon_Add_Fx", BlendMode = "Additive" })
	InsertGroupInFront({ Name = "Cloud_02_FX", DestinationName = "Cloud_02" })
	InsertGroupInFront({ Name = "Cloud_03_FX", DestinationName = "Cloud_03" })
	InsertGroupInFront({ Name = "Moon_Add_Fx", DestinationName = "Characters" })
	SetAnimation({ Name = "EndCreditsWindFxEmitter", DestinationId = windEmitter })
	CreateAnimation({ Name = "EndCreditsMoonParticlesEmitter", DestinationId = windEmitter })
	CreateAnimation({ Name = "EndCreditsChariotSparkleEmitter", DestinationId = 780625 })
	CreateAnimation({ Name = "EndCreditsCloudFxEmitter", DestinationId = 780625 })
	StopAnimation({ Name = "LaurelCindersSpawner", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "LaurelCindersSpawner_EndCredits", DestinationId = CurrentRun.Hero.ObjectId })
end

function HandleEndingCreditsWrapping( source, args )
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end

	for k, obstacleWrapData in ipairs( args ) do
		for i, id in pairs( obstacleWrapData.Ids ) do
			if i == 1 then
				local resetTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = id, OffsetX = obstacleWrapData.ResetOffsetDistance, OffsetY = 0 })
				obstacleWrapData.WrapCount = 0
				thread( WrapObstacle, id, obstacleWrapData, { ResetTargetId = resetTargetId, Angle = 0 } )
			else
				Attach({ Id = id, DestinationId = obstacleWrapData.Ids[1], OffsetX = -obstacleWrapData.MoveDistance * (i - 1), OffsetY = 0 })
			end
		end
	end
end

function EndingCreditsPresentation( source, args )

	AltAspectRatioFramesShow() -- these were hidden at the end of the preceding narrative screen

	LockCamera({ Id = args.CameraPanId, Duration = 5 })
	FocusCamera({ Fraction = args.CameraZoom, Duration = 5, ZoomType = "Ease" })

	thread( TwinsSingingStart, source, args )

	-- start scrolling faster for the giddy-up moment
	local roomData = RoomData.EndCredits01
	for i, wrappingData in ipairs( roomData.StartUnthreadedEvents[2].Args ) do
		local id = wrappingData.Ids[1]
		SessionMapState.WrappingMoveSpeed[id] = wrappingData.AltMoveSpeed
		Move({ Id = id, Angle = 0, Speed = wrappingData.AltMoveSpeed })
	end

	-- start the song!
	wait( CreditsData.PreSongDelay )
	SessionMapState.PauseMusicOnPauseScreen = true
	StopSecretMusic()
	thread( MusicPlayer, "/Music/IrisEndTheme" )
	SetSoundCueValue({ Id = AudioState.AmbienceId, Name = "Wind", Value = 0, Duration = 20 })

	-- countdown until we go back to the hub
	thread( EndCreditsExitTimer )

	-- credits, go!
	local layoutData =
	{
		StartY = ScreenHeight - ScreenCenterNativeOffsetY,
	}
	for i, credit in ipairs( CreditsData.ScrollingCredits ) do
		SpawnCredit( credit, CreditsData.ScrollingCredits[i + 1], layoutData )
	end

	notifyExistingWaiters( "CreditsScrollEnded" )

end

function SpawnCredit( credit, nextCredit, layoutData )

	if credit.Delay ~= nil then
		wait( credit.Delay )
	end

	if credit.SetScrollSpeed ~= nil then
		layoutData.ScrollSpeed = credit.SetScrollSpeed
	end

	if credit.ThreadedFunctionName ~= nil then
		thread( CallFunctionName, credit.ThreadedFunctionName, credit.ThreadedFunctionArgs )
	end

	if credit.Graphic ~= nil then
		local graphicId = CreateScreenObstacle({ Name = "BlankObstacle", Group = credit.Group or CreditsData.CreditsGroup, Animation = credit.Graphic, X = credit.X + ScreenCenterNativeOffsetX, Y = layoutData.StartY })
		Move({ Id = graphicId, Angle = 90, Speed = layoutData.ScrollSpeed })
		thread( DestroyOnDelay, { graphicId }, (layoutData.StartY - ScreenCenterNativeOffsetY + credit.SpacingY) / layoutData.ScrollSpeed )
		wait( credit.SpacingY / layoutData.ScrollSpeed )
		return
	end

	local formatData = CreditsData.Formats[credit.Format]
	if formatData == nil then
		return
	end

	if credit.Text ~= nil then
		local creditId = CreateScreenObstacle({ Name = "BlankObstacle", Group = CreditsData.CreditsGroup, X = formatData.X + ScreenCenterNativeOffsetX, Y = layoutData.StartY })

		local textBoxData = ShallowCopyTable( formatData )
		textBoxData.X = 0
		textBoxData.Text = credit.Text
		textBoxData.Id = creditId
		CreateTextBox( textBoxData )

		Move({ Id = creditId, Angle = 90, Speed = layoutData.ScrollSpeed })
		thread( DestroyOnDelay, { creditId }, (layoutData.StartY - ScreenCenterNativeOffsetY + formatData.FontSize) / layoutData.ScrollSpeed )
	end

	local creditSpacingY = credit.SpacingY or formatData.SpacingY
	if nextCredit ~= nil then
		-- usually the right column is responsible for adding spacing below it, but if there's only a left column, we still need the additional spacing
		if credit.Format == "CreditName_Left" and nextCredit.Format ~= "CreditName_Right" then
			creditSpacingY = CreditsData.Formats.ColumnRight.SpacingY
		end
	end

	if creditSpacingY ~= 0 then
		wait( creditSpacingY / layoutData.ScrollSpeed )
	end

end

function TwinsSingingStart( source, args )
	local notifyName = "ChariotAnimationComplete"
	NotifyOnAnimationTimeRemaining({ Id = args.ChariotId, Animation = "Horse_FlyingIdle_Twins_Idle", Remaining = 0.032, Notify = notifyName, Timeout = 10 })
	waitUntil( notifyName )
	SetAnimation({ Name = "Horse_FlyingIdle_Twins_Singing_Start", DestinationId = args.ChariotId })
end

function EndCreditsExitTimer()

	if verboseLogging then
		thread( EndCreditsDebugTimer )
	end

	-- wait for the song to finish...
	wait( CreditsData.SongDuration )

	wait( 0.3 )
	AudioState.PostCreditsMusicId = PlaySound({ Name = "/Music/EndThemeORCHESTRAL" }) -- follow on track
	waitUntil( "CreditsScrollEnded" ) -- stop gap to make sure it plays out

	FadeOut({ Color = Color.Black, Duration = 1.0 })
	wait( 1.0 )
	RemoveInputBlock({ Name = "EndingCredits" })

	-- The End
	CurrentRun.PlayedTrueEnding = true
	GameState.ReachedTrueEnding = true

	-- automatically unlock this special cosmetic
	UnlockWorldUpgrade( "Cosmetic_SunMoonTimeSculpture01" )
	GameState.WorldUpgrades.Cosmetic_SunMoonTimeSculpture01 = true

	Kill( CurrentRun.Hero )

end

function EndCreditsDebugTimer()
	local startTime = _worldTimeUnmodified
	while true do
		wait( 0.02 )
		DebugPrint({ Text = ((_worldTimeUnmodified - startTime) / CreditsData.SongDuration * 100).."%%" })
	end
end

function ShowEndCreditsConstellation( args )
	local constellationId = 723539
	AdjustFullscreenBloom({ Name = "DesaturatedLight", Duration = 0.6 })
	SetAnimation({ DestinationId = constellationId, Name = args.Name })
	SetAlpha({ Id = constellationId, Fraction = 1.0, Duration = args.FadeInDuration or 1.0 })
	thread( EndCreditConstellationBloom )
	wait( args.HoldDuration or 4.0 )
	SetAlpha({ Id = constellationId, Fraction = 0.0, Duration = args.FadeOutDuration or 1.0 })
end

function EndCreditConstellationBloom()
	wait( 0.6 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.5 })
end

function EndCreditsSetupBirds()
	wait( 2.0 )
	SetAnimation({ DestinationId = 780637, Name = "EndCreditsBirdFlockEmitter" })
end

function SummonNeoChronos( source, args )
	args = args or {}

	local destId = CurrentRun.Hero.ObjectId

	if args.UseSourceForDestination then
		destId = source.ObjectId
	end

	local chronos = DeepCopyTable( EnemyData.NPC_Chronos_02 )
	chronos.ObjectId = SpawnUnit({ Name = "NPC_Chronos_02", Group = "Standing", DestinationId = destId, OffsetX = -180, OffsetY = -120, })
	SetupUnit( chronos, CurrentRun, { IgnoreAI = true, IgnoreAssert = true, } )
	SetUnitProperty({ DestinationId = chronos.objectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = chronos.objectId, Property = "CollideWithUnits", Value = false })
	SetAlpha({ Id = chronos.ObjectId, Fraction = 0, Duration = 0 })
	AngleTowardTarget({ Id = chronos.ObjectId, DestinationId = source.ObjectId })

	SetAlpha({ Id = chronos.ObjectId, Fraction = 1, Duration = 0.3 })
	CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = chronos.ObjectId })

	PanCamera({ Id = chronos.ObjectId, Duration = 1.2, OffsetY = 85, Retarget = true})

end

function UnSummonNeoChronos( source, args )
	args = args or {}

	wait( args.PreDelay or 0 )

	local chronosId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Chronos_02" })
	MapState.RoomRequiredObjects[chronosId] = nil

	SetAlpha({ Id = chronosId, Fraction = 0, Duration = 0.3 })
	CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = chronosId })
	PanCamera({ Id = 704917, Duration = 1.2, OffsetY = 85, Retarget = true})
	wait(0.5)
	ActiveEnemies[chronosId] = nil
	Destroy({ Id = chronosId })

end

function PlayZagreusTauntAnim( source, args )

	SecretMusicPlayer( "/Music/UnseenOnesFight" )
	SetAnimation({ Name = "Enemy_Zagreus_Spear_Equip", DestinationId = source.ObjectId })
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 0 })
	SetMusicSection( 8, AudioState.SecretMusicId )
end

function StartZagreusBossFight()
	SetMusicSection( 2, AudioState.SecretMusicId )
	PlaySound({ Name = "/SFX/TheseusCrowdCheer", Delay = 2 })
	SetAnimation({ Name = "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })
end

function AttemptPetCerberusThread( cerberus )
	-- @ ending
	if not GameState.TextLinesRecord.CerberusTrueEnding01 then
		thread( FailToPetCerberus, cerberus )
	else
		thread( PetCerberus, cerberus )
	end
end

function FailToPetCerberus( cerberus )

	if CheckCooldown( "AttemptCerberusPet", 2.0 ) then
		thread( RepulseFromObject, cerberus, { IgnoreInvincibubbleOnHit = true, Scale = 3 })
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_CannotPetCerberus", 1.35, { ShadowScaleX = 1.4 } )
		PlaySound({ Name = "/Leftovers/SFX/PlayerKilled_Small", Id = CurrentRun.Hero.ObjectId })
		SetAnimation({ DestinationId = cerberus.ObjectId, Name = "Cerberus_PetDecline" })
	end
	thread( PlayVoiceLines, GlobalVoiceLines.FailedToPetCerberusVoiceLines, true )

end

function PetCerberus( cerberus )

	AddInteractBlock( cerberus, "PetCerberus" )
	AddInputBlock({ Name = "PetCerberus" })
	ZeroMouseTether( "PetCerberus" )

	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	MoveHeroToRoomPosition( { DestinationId = roomData.CerberusPetTargetId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = 10, ContinueToGoal = true } )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = cerberus.ObjectId })
	wait( 0.3 )

	if not SessionMapState.WeaponsDisabled then
		local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
		SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
		wait( 0.65 )
	end

	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "Melinoe_PetCerberus" })
	SetAnimation({ DestinationId = cerberus.ObjectId, Name = "Cerberus_Pet" })
	thread( PlayVoiceLines, GlobalVoiceLines.PetCerberusVoiceLines, true )

	wait( 6.8 )
	UnzeroMouseTether( "PetCerberus" )
	RemoveInputBlock({ Name = "PetCerberus" })

	wait( 3.0 )
	RemoveInteractBlock( cerberus, "PetCerberus" )

end