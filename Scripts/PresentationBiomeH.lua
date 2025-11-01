function InfestedCerberusKillPresentation( unit, args )
	RecordEncounterClearStats()
	ClipEvent({ Icon = "steam_combat", Title = GetDisplayName({ Text = args.Message }), Description = "", StartOffset = 0.0, Duration = 5.0 })

	local allBossesDead = true
	if CurrentRun.CurrentRoom.Encounter.HoldKillPresentationForUnitDeaths ~= nil then
		for k, unitName in pairs(CurrentRun.CurrentRoom.Encounter.HoldKillPresentationForUnitDeaths) do
			if unitName ~= unit.Name then
				local unitId = GetClosestUnitOfType({ Id = unit.ObjectId, DestinationName = unitName })
				if ActiveEnemies[unitId] ~= nil then
					allBossesDead = false
				end
			end
		end
	end

	if not allBossesDead then
		LastKillPresentation( unit )
		return
	end
	
	ClearGameplayElapsedTimeMultipliers()
	ClearSimSpeedChanges()
	AddInputBlock({ Name = "GenericBossKillPresentation" })

	thread( InfestedCerberusHorribleRaceConditionForTempPresentation, unit, args )
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	local deathPanSettings = args
	LockCameraMotion("InfestedCerberusKillPresentation")

	if deathPanSettings.FlashRed then
		local duration = deathPanSettings.FlashDuration or 0.5
		Flash({ Id = victimId, Speed = 0.01, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = duration, ExpireAfterCycle = true })
	end

	ClearEffect({ Ids = { victimId, killerId }, All = true, BlockAll = true, })
	EffectPostClearAll( unit )
	if unit.Frozen then
		UnfrozenPresentation( unit, { SkipPresentation = true })
	end

	if unit.DeathFx ~= nil then
		CreateAnimation({ Name = unit.DeathFx, DestinationId = unit.ObjectId, Angle = args.ImpactAngle })
		unit.DeathFx = nil
	end
	if unit.DeathAngle ~= nil then
		Halt({ Id = victimId })
		Stop({ Id = victimId })
		SetGoalAngle({ Id = victimId, Angle = unit.DeathAngle, CompleteAngle = true })
	end
	if unit.DeathAnimation ~= nil then
		SetAnimation({ Name = unit.DeathAnimation, DestinationId = unit.ObjectId })
		unit.DeathAnimation = nil
	end
	if unit.DeathSound ~= nil then
		PlaySound({ Name = unit.DeathSound, Id = unit.ObjectId })
		unit.DeathSound = nil
	end
	if unit.BossKillVoiceLines ~= nil then
		thread( PlayVoiceLines, unit.BossKillVoiceLines, false, unit )
	end
	unit.Mute = true

	PlaySound({ Name = "/SFX/StabSplatterEndSequence" })

	BlockProjectileSpawns({ ExcludeWeaponName = "WeaponLob" })
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})

	for id, name in pairs(MapState.Reticles) do
		Destroy({ Id = id })
	end
	MapState.Reticles = {}

	SetPlayerInvulnerable( "GenericBossKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	if args.AddInterBiomeTimerBlock then
		AddTimerBlock( CurrentRun, "InterBiome" )
	end
	AddTimerBlock( CurrentRun, "GenericBossKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	ClearCameraClamp({ LerpTime = 0 })
	local cameraPanTime = 1.5
	if deathPanSettings.StartPanTime then
		cameraPanTime = deathPanSettings.StartPanTime
	end
	local offsetY = unit.DeathPanOffsetY or 0
	PanCamera({ Id = victimId, Duration = cameraPanTime, OffsetY = offsetY })
	FocusCamera({ Fraction = 1.1, Duration = cameraPanTime })
	ZeroMouseTether("GenericBossKillPresentation")
	CancelWeaponFireRequests({ Id = killerId })
	ToggleCombatControl( CombatControlsDefaults, false, "BossKill" )

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen, nil, { IgnoreHUDShow = true } )
	end
	HideCombatUI("BossKill")

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if deathPanSettings.StartSound then
		PlaySound({ Name = deathPanSettings.StartSound })
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteShocked" })
	end
	if not args.IgnoreEndMusic then
		EndMusic()
	end

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, IgnoreAnimations = true, DataValue = false, DestinationId = killerId })
	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = victimId })
	thread( VictimDeathHold, victimId, 0.02, 0.5 )

	RemoveFromGroup({ Id = killerId, Names = { "Standing" } })
	AddToGroup({ Id = killerId, Name = "Combat_Menu_Overlay_Backing", DrawGroup = true })
	RemoveFromGroup({ Id = victimId, Name = "Standing" })
	AddToGroup({ Id = victimId, Name = "Combat_Menu_Overlay_Backing", DrawGroup = true })

	if deathPanSettings.EndAngle then
		SetGoalAngle({ Id = victimId, Angle = deathPanSettings.EndAngle })
	end
	 
	-- black out world
	AdjustFrame({ Color = Color.TransparentRed, Duration = 0.0, Fraction = 0 })
	ScreenAnchors.DeathBackground = ScreenAnchors.DeathBackground or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = ScreenAnchors.DeathBackground, Fraction = 10 })
	SetColor({ Id = ScreenAnchors.DeathBackground, Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 1.0, Duration = 0 })

	thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.17, Duration = 0.65 }, { ScreenPreWait = 2.8, LeftFraction = 0.3, Duration = 0.6 } } )

	thread( BossDeathFlash, { DestinationId = victimId, StartDelay = 0.52, StopDelay = 0.3, OffsetY = args.DeathFlashOffsetY or 0 } )

	wait( 0.15 )
	if killerId == CurrentRun.Hero.ObjectId then
		SetPlayerFade({ Flag = "KillPresentation"})
	else
		SetAlpha({ Id = killerId, Fraction = 0, Duration = 0.3 })
	end
	ClearEffect({ Id = killerId, Name = "KillDamageBonus" })

	wait( 5 )
	thread( GenericPresentation, unit, { PreWait = 0.7, Id = victimId, SetAlpha = 0, Duration = 0.4, })

	-- narrative outro
	local textLines = GetRandomEligibleTextLines( unit, unit.BossOutroTextLineSets, GetNarrativeDataValue( unit, "BossOutroTextLinePriorities" ) )
	PlayTextLines( unit, textLines )

	FadeOut({ Duration = 0.5, Color = Color.Black })

	PlaySound({ Name = "/VO/CerberusCuteGrowl_2" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })

	PanCamera({ Id = victimId, Duration = 5.7, EaseOut = 0.5, OffsetY = -95, Retarget = true })

	-- banner
	local textMessage = "CerberusDefeatedMessage"
	if deathPanSettings.BossDifficultyMessage and GetNumShrineUpgrades( "BossDifficultyShrineUpgrade" ) > 0 then
		textMessage = deathPanSettings.BossDifficultyMessage
	end	
	thread( DisplayInfoBanner, nil, { 
		Text = textMessage,
		Delay = 0.75, 
		TextColor = Color.White, 
		TextFadeColor = {64,230,255,255},
		FontScale = 0.9,
		Layer = "ScreenOverlay", 
		AnimationName = "InfoBannerBossKillIn",
		AnimationOutName = "InfoBannerBossKillOut",
		Duration = 3.75,
	} )

	wait( 1.25 )

	Teleport({ Id = victimId })

	wait(0.25)
	PlaySound({ Name = "/SFX/CerberusFootsteps" })
	wait(0.25)
	PlaySound({ Name = "/SFX/CerberusFootsteps" })
	wait(0.8)
	PlaySound({ Name = "/SFX/CerberusFootsteps" })
	wait(0.25)
	PlaySound({ Name = "/SFX/CerberusFootsteps" })
	wait(0.8)
	PlaySound({ Name = "/SFX/CerberusFootsteps" })
	wait(0.25)
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.02, Retarget = true })

	wait( 1.25 )

	if unit.PostOutroVoiceLines ~= nil then
		thread( PlayVoiceLines, unit.PostOutroVoiceLines )
	end
	
	RemoveFromGroup({ Id = killerId, Names = { "Combat_Menu_Overlay_Backing" } })
	AddToGroup({ Id = killerId, Name = "Standing", DrawGroup = true })
	SetAnimation({ DestinationId = killerId, Name = "MelinoeIdle" })
	ClearEffect({ Ids = { killerId }, All = true })

	FadeIn({ Duration = args.FadeInTime or 1.0 })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })

	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0.0, Duration = 0.3 })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.0, EaseOut = 0.5 })

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationId = killerId })
	if killerId == CurrentRun.Hero.ObjectId then
		ClearPlayerFade( "KillPresentation" )
	else
		SetAlpha({ Id = killerId, Fraction = 1.00, Duration = 0.3 })
	end

	local defaultZoom = 1.0
	if CurrentHubRoom ~= nil then
		defaultZoom = CurrentHubRoom.ZoomFraction or defaultZoom
	else
		defaultZoom = CurrentRun.CurrentRoom.ZoomFraction or defaultZoom
	end
	FocusCamera({ Fraction = defaultZoom, Duration = 2.0, ZoomType = "Ease" })

	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	wait( 0.5 )
	UseableOn({ Ids = { 625989, 723309, 738197 } }) -- Exit door, red shade
	UnlockCameraMotion("InfestedCerberusKillPresentation")
	RemoveInputBlock({ Name = "GenericBossKillPresentation" })
	RemoveTimerBlock( CurrentRun, "GenericBossKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "GenericBossKillPresentation" )
	ShowCombatUI("BossKill")
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	ToggleCombatControl( CombatControlsDefaults, true, "BossKill" )
	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
end

function InfestedCerberusHorribleRaceConditionForTempPresentation( unit )
	CreateAnimation({ Name = "CerbDeathTransitionFx", DestinationId = unit.ObjectId })
	wait(3.0)
	StopAnimation({ DestinationId = unit.ObjectId, Name = "CerbBibMoveTrail" })
	PlaySound({ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_TransformPoof", Id = unit.ObjectId })
  	CreateAnimation({ Name = "TeleportDisappearCerberusTransform", DestinationId = unit.ObjectId })
  	PanCamera({ Id =  unit.ObjectId, Duration = 1.2, EaseOut = 0.5, OffsetY = -200, Retarget = true })
  	wait(0.10)
  	SetAlpha({ Id = unit.ObjectId, Fraction = 0, Duration = 0.06 })
  	wait(0.07)
	SetAlpha({ Id = unit.ObjectId, Fraction = 1.0, Duration = 0.06 })
  	StopAnimation({ Name = "CerbDeathTransitionFx", DestinationId = unit.ObjectId })
	SetThingProperty({ Property = "GrannyTexture", Value = "", DestinationId = unit.ObjectId })
	SetThingProperty({ Property = "GrannyModel", Value = "Cerberus_Mesh", DestinationId = unit.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "Cerberus_Idle_Sitting", DestinationId = unit.ObjectId })
	SetScale({ Id = unit.ObjectId, Fraction = 1.5, Duration = 0.0 })
	SetAnimation({ DestinationId = unit.ObjectId, Name = "Cerberus_Idle_Sitting" })
	wait(2.3)
end

function GhostWallCollidePresentation( collidee, collider )
	--DebugPrint({ Text = tostring( collidee.ObjectId ) })
	if collidee == nil then
		return
	end
	if collidee.GhostWallPresentationCooldown == nil then
		collidee.GhostWallPresentationCooldown = false
	end
	if collider ~= nil and collider.ObjectId == CurrentRun.Hero.ObjectId then
		--SetAnimation({ Name = "MelinoeGetHit", DestinationId = collider.ObjectId })
	end
	if not collidee.GhostWallPresentationCooldown then
		collidee.GhostWallPresentationCooldown = true
		--Flash({ Id = collider.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5 })
		--Flash({ Id = collidee.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5 })
		Shake({ Id = collidee.ObjectId, Duration = 0.3, Speed = 140, Distance = 3 })
		CreateAnimation({ Name = "GhostWallImpactPuff", DestinationId = collidee.ObjectId, Group = "Standing", Scale = 0.5 })
		CreateAnimation({ Name = "GhostWallImpactFx", DestinationId = collider.ObjectId, Group = "FX_Displacement", Scale = 0.5, OffsetY = 60 })

		PlaySound({ Name = "/SFX/GhostEvaporate", ManagerCap = 2 })
		thread( PlayVoiceLines, HeroVoiceLines.GhostWallInteractionVoiceLines, true )
		wait( 0.25 )
		collidee.GhostWallPresentationCooldown = false
	end
	
end

function WheatHit( victim, triggerArgs )

	CreateAnimation({ Name = victim.DeathFx, DestinationId = victim.ObjectId, Angle = triggerArgs.ImpactAngle, ManagerCap = 500, ManagerFrameCap = 20 })	

	if triggerArgs.EffectName == nil then
		DoImpactSound( victim, triggerArgs )
	end

	if victim.SpawnObstaclesOnDeath ~= nil then
		SpawnObstaclesOnDeath( victim, triggerArgs )
	end

	table.insert( SessionMapState.DestroyRequests, victim.ObjectId )

end

function EchoPostChoicePresentation( screen, args )
	PlaySound({ Name = screen.Source.ConfirmSound or "/SFX/Menu Sounds/GodBoonChoiceConfirm" })
	SetAnimation({ Name = "Echo_Blessing", DestinationId = screen.Source.ObjectId })

	if SessionMapState.LastUpgradeChoice == "EchoLastRunBoon" then
		SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
		return
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

	local cauldronPoints = GetIdsByType({ Name = "CrossroadsCauldron02"})
	if not IsEmpty( cauldronPoints ) then
		CreateAnimation({ Name = "CauldronSmokeSmaller", DestinationId = cauldronPoints[1] })
		PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = cauldronPoints[1] })
	end

	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function FieldsEncounterEndPresentation( encounter, currentRun )
	wait( 0.1 )
	CurrentRun.CurrentRoom.EncountersCleared = (CurrentRun.CurrentRoom.EncountersCleared or 0) + 1

	thread( PlayVoiceLines, HeroVoiceLines.FieldsEncounterClearedVoiceLines, true )
	
	if encounter.RewardId then
		thread( DirectionHintPresentation, MapState.RoomRequiredObjects[encounter.RewardId], { Cooldown = 0, Delay = 0 } )
	end
end

function FieldsExitsReadyPresentation( encounter )

	PlaySound({ Name = "/Leftovers/SFX/DoorStateChangeRewardAppearance" })

	thread( PlayVoiceLines, GlobalVoiceLines.FieldsExitsUnlockedVoiceLines )

end

function CerberusStageExit(enemy, CurrentRun, aiStage)

	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_InfestedCerberus_BurrowStart" })
	if aiStage.TransitionDumbFireAttack ~= nil then
		thread( DumbFireAttack, enemy, aiStage.TransitionDumbFireAttack )
	end
	PlaySound({ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_StageChange", Id = enemy.ObjectId })
	
	ClearEffect({ Id = enemy.ObjectId, All = true })
	EffectPostClearAll( enemy )

	thread( PlayVoiceLines, HeroVoiceLines.CerberusStageTransitionVoiceLines, true )
	thread( GenericPresentation, enemy, { PreWait = 1.5, SetAlpha = 0, Duration = 0.3 } )

	BossStageTransition(enemy, currentRun, aiStage)
end

function CerberusStageEnter(enemy, CurrentRun, aiStage)

	local requirementEM =
	{
		{
			FunctionName = "RequiredShrineLevel",
			FunctionArgs =
			{
				ShrineUpgradeName = "BossDifficultyShrineUpgrade",
				Comparison = ">=",
				Value = 3,
			}
		}
	}

	Activate({ Name = "SpawnPointsPhase2" })
	CurrentRun.CurrentRoom.SpawnPoints = {}
	MapState.SpawnPoints = GetIds({ Name = "SpawnPoints" })
	LockCameraMotion("CerberusStageEnter")

	if IsGameStateEligible( enemy, requirementEM ) then
		local usedPoints = ShallowCopyTable( aiStage.TransitionArgs.TransitionRadialIds )

		SetThingProperty({ Property = "GrannyTexture", Value = aiStage.TransitionArgs.GrannyTexture, DestinationId = enemy.ObjectId })
		Teleport({ Id = enemy.ObjectId, DestinationId = RemoveRandomValue(usedPoints) })

		thread(ProcessFireProjecile, enemy, { ProjectileName = "CerberusTransitionRadial", TargetId = aiStage.TransitionArgs.TransitionRadialInitialId, FireFromTarget = true, } )
		for i = 1, aiStage.TransitionArgs.TransitionRadialCount or 6 do
			thread(ProcessFireProjecile, enemy, { ProjectileName = "CerberusTransitionRadial", TargetId = RemoveRandomValue(usedPoints), FireFromTarget = true, } )
			--DebugPrintTable(usedPoints)
		end
	end

	thread(ProcessFireProjecile, enemy, { ProjectileName = "CerberusTransitionRadial", FireProjectileAtSelf = true, FireFromTarget = true, } )

	wait(0.85)

	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 2.5 })

	AdjustZoom({ Fraction = 0.55, LerpTime = 1.2 })
	CurrentRun.CurrentRoom.ZoomFraction = 0.55

	wait(0.5)

	local ghostWallIds = GetIds({ Name = "Phase1GhostWalls" })
	SetAlpha({ Ids = ghostWallIds, Fraction = 1.0, Duration = 0.5 })

	wait(1.2)

	SetAlpha({ Id = enemy.ObjectId, Fraction = 1.0, Duration = 0.0 })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_InfestedCerberus_BurrowEmerge_Intro" })
	PlaySound({ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_PlagueRoar", Id = enemy.ObjectId })

	if IsGameStateEligible( enemy, requirementEM ) then
		wait(0.2)
		EnemyGainHitShields(enemy, 22)
	end

	SetUnitVulnerable( enemy )

	for index, ghostWallId in ipairs( ghostWallIds ) do
		CreateAnimation({ Name = "GhostWallDissipate", DestinationId = ghostWallId })
		SetAlpha({ Id = ghostWallId, Fraction = 0.0, Duration = 0.5, EaseIn = 0, EaseOut = 1 })
		wait(0.02)
	end

	Destroy({ Ids = GetIds({ Name = "Phase1Obstacles" }) })
	UnlockCameraMotion("CerberusStageEnter")

	wait(1.255)

	--AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 0.5 })

	BossStageTransition(enemy, currentRun, aiStage)
end

function H_ReloadHideGhostWalls( room, args )
	local ghostWalls = GetIdsByType({ Names = { "H_GhostWall", "H_GhostWall_Sparse" } })

	if not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = ghostWalls, Fraction = 0, Duration = 0 })
	end
end

function RoomEntranceBossFields( currentRun, currentRoom, args )
	local startId = currentRoom.HeroEndPoint or CurrentRun.Hero.ObjectId
	local nearbyGhostWalls = GetIdsByType({ Names = { "H_GhostWall", "H_GhostWall_Sparse" } })

	if not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = nearbyGhostWalls, Fraction = 0, Duration = 0 })
	end
	UseableOff({ Ids = { 625989, 723309, 738197 } }) -- Exit door, red shade
	RoomEntranceBoss( currentRun, currentRoom, args )
end

function RoomEntrancePortalFields( currentRun, currentRoom )
	local startId = currentRoom.HeroEndPoint or CurrentRun.Hero.ObjectId
	local nearbyGhostWalls = GetIdsByType({ Names = { "H_GhostWall", "H_GhostWall_Sparse" } })

	if not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = nearbyGhostWalls, Fraction = 0, Duration = 0 })
	end

	RoomEntrancePortal( currentRun, currentRoom )
end

function LeaveRoomHBossPresentation( currentRun, exitDoor )
	local currentRoom = CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom
	HideCombatUI( "LeaveRoomHBossPresentation" )
	AddInputBlock({ Name = "LeaveRoomHBossPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )

	LeaveRoomAudio( currentRun, exitDoor )

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

	thread( FullScreenFadeOutAnimation, "RoomTransitionIn" )
	
	wait( 0.2 )
	
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.2, OffsetY = 85, Retarget = true})
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.25 }, } )
	thread( SlightDescent )

	local notifyName = "LeaveRoomHBossPresentationFade"
	NotifyOnAnimationTimeRemaining({ Id = ScreenAnchors.Transition, Animation = "RoomTransitionIn", Remaining = 0.02, Notify = notifyName, Timeout = 1.0 })
	waitUntil( notifyName )
	wait( 0.05 )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomHBossPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
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

	FullScreenFadeOutAnimation( "RoomTransitionIn_Down" )
	RemoveInputBlock({ Name = "LeaveRoomHPostBossPresentation" })
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
	SecretMusicPlayer( "/Music/EchoTheme_MC" )
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })
end

function FieldsEncounterActivatedPresentation( rewardCage, args )
	args = args or {}
	PlayInteractAnimation( rewardCage.ObjectId, { Animation = GetEquippedWeaponValue( "WeaponInteractAnimation" ) })
	local extraArgs = ShallowCopyTable( args )
	extraArgs.Encounter = rewardCage.Encounter
	thread( PlayVoiceLines, HeroVoiceLines.FieldsEncounterStartedVoiceLines, true, nil, extraArgs )
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
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_InfestedCerberus_BurrowEmerge_Intro" })
	AdjustRadialBlurDistance({ Fraction = 10, Duration = 3.0 })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = 3.0 })
	wait(1.5)
	ShakeScreen({ Speed = 900, Distance = 12, FalloffSpeed = 600, Duration = 0.45, Angle = 90 })
	wait(1.5)
	PanCamera({ Ids = CurrentRun.Hero.ObjectId, Duration = 1.5 })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1.0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1.0 })
end

function UseFieldsRewardFinderPresentation( source )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement", Id = source.ObjectId })
	PlaySound({ Name = "/SFX/GoldenBoughInteract", Id = source.ObjectId })
	SetAnimation({ DestinationId = source.ObjectId, Name = source.UseAnimation })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", source.UseAnimation )
	Shake({ Id = source.ObjectId, Distance = 1.5, Speed = 200, Duration = 0.125 })
	thread( PlayVoiceLines, GlobalVoiceLines.UsedRewardFinderVoiceLines, true )
	GameState.FieldsRewardFindersActivated = (GameState.FieldsRewardFindersActivated or 0) + 1
end

GlobalVoiceLines.AcquireMixerForMedeaQuestVoiceLines =
{
	PreLineWait = 0.35,
	GameStateRequirements =
	{
		{
			PathFalse = { "GameState", "Flags", "AcquiredMixerForMedeaQuest" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "MedeaAboutConcoctionQuest01" }
		},
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

	{ Cue = "/VO/MelinoeField_4337", Text = "These Tears are for Lady Medea alone.", IgnoreMute = true },
}

function OnMixerHBossAdded( name, amount, source, args )
	if IsGameStateEligible( nil, GlobalVoiceLines.AcquireMixerForMedeaQuestVoiceLines.GameStateRequirements ) then
		thread( PlayVoiceLines, GlobalVoiceLines.AcquireMixerForMedeaQuestVoiceLines )
		GameState.Flags.AcquiredMixerForMedeaQuest = true
	end
end