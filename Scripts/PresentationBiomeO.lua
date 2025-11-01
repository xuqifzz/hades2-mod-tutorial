function ErisFlyByPresentation( enemy, aiData, currentRun, args )
	local startId = 744256
	if CurrentRun.CurrentRoom.Name == "O_Boss02" then
		startId = 793977
	end
	Teleport({ Id = enemy.ObjectId, DestinationId = startId })
	SetUnitInvulnerable( enemy, "ErisFlyByPresentation", { Silent = true } )
	ClearEffect({ Id = enemy.ObjectId, All = true })
	EffectPostClearAll( enemy )
	local zHeight = args.FlybyZHeight or 500
	AdjustZLocation({ Id = enemy.ObjectId, Distance = zHeight - GetZLocation({ Id = enemy.ObjectId }) })
	IgnoreGravity({ Id = enemy.ObjectId })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Eris_FlyByLoop" })
	SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithObstacles", Value = false })

	if args.TopGroup then
		RemoveFromGroup({ Id = enemy.ObjectId, Names = { "Standing" } })
		AddToGroup({ Id = enemy.ObjectId, Name = "Combat_Menu_TraitTray_Overlay_Text", DrawGroup = true })

		local heroExitIds = GetIdsByType({ Name = "HeroExit" })
		local heroExitPointId = heroExitIds[1]
		thread( GustWindBoss, { ObjectId = heroExitPointId, AnimationName = "ShipsGustSpawnerForward", Count = 1 } )

		local heroEntranceIds = GetIdsByType({ Name = "HeroStart" })
		local heroEntranceId = heroEntranceIds[1]
		thread( GustWindBoss, { ObjectId = heroEntranceId, AnimationName = "ShipsGustSpawnerForward", Count = 1 } )
		ShakeScreen({ Speed = 400, Distance = 12, FalloffSpeed = 1000, Duration = 0.4, Angle = 45 })
	end

	local scale = args.FlyByScale or 1.0
	local prevScale = GetThingDataValue({ Id = enemy.ObjectId, Property = "Scale" })
	SetScale({ Id = enemy.ObjectId, Fraction = scale, Duration = 0.1 })

	local duration = args.FlyByDuration or 1.0

	local speedEffect = { Id = enemy.ObjectId, DestinationId = enemy.ObjectId, EffectName = enemy.Name .. "ErisFlyBySpeed" }
	speedEffect.DataProperties = { Duration = duration, Type = "SPEED", Modifier = args.FlyBySpeedMultiplier or 6.0, TimeModifierFraction = 1 }
	ApplyEffect(speedEffect)

	local endId = 744255
	if CurrentRun.CurrentRoom.Name == "O_Boss02" then
		endId = 794420
	end
	Move({ Id = enemy.ObjectId, DestinationId = endId })

	AIWait(duration, enemy, enemy.AIThreadName)

	Stop({ Id = enemy.ObjectId })
	ObeyGravity({ Id = enemy.ObjectId })
	AdjustZLocation({ Id = enemy.ObjectId, Distance = 0 })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = "Enemy_Eris_Hidden" })
	SetUnitVulnerable( enemy, "ErisFlyByPresentation" )

	SetScale({ Id = enemy.ObjectId, Fraction = prevScale, Duration = 0.1 })
	SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithObstacles", Value = true })
	AddToGroup({ Id = enemy.ObjectId, Name = "Standing", DrawGroup = true })
	RemoveFromGroup({ Id = enemy.ObjectId, Names = { "Combat_Menu_TraitTray_Overlay_Text" } })
end

function ErisSelfBuffApply( triggerArgs )
	local victim = triggerArgs.Victim
	local effectName = triggerArgs.EffectName
	local effectData = EffectData[triggerArgs.EffectName]

	if triggerArgs.Reapplied then
		return
	end

	SetAnimation({ DestinationId = victim.ObjectId, Name = "Enemy_Eris_Yell" })
	StopAnimation({ Name = "Invincibubble", DestinationId = victim.ObjectId })

	waitUnmodified( 0.2, RoomThreadName )
	
	-- camera
	PanCamera({ Ids = { CurrentRun.Hero.ObjectId, victim.ObjectId }, Duration = 0.2 })
	FocusCamera({ Fraction = 0.9, Duration = 0.2, ZoomType = "Ease" })

	-- pause the game
	AddSimSpeedChange( "ErisSelfBuff", { Fraction = 0.1, LerpTime = 0.25, Priority = true } )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAnger" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/SkillUpgradeConfirm" })
	PlaySound({ Name = "/SFX/Enemy Sounds/Eris/EmoteLaugh", Delay = 0.15 })
	thread( PlayVoiceLines, GlobalVoiceLines.ErisSelfBuffAppliedVoiceLines, true )

	thread( InCombatText,victim.ObjectId, "ErisPowerUpActivated", 1.4, { ShadowScale = 0.66, OffsetY = -215 } )

	waitUnmodified( 2.0, RoomThreadName )

	RemoveSimSpeedChange( "ErisSelfBuff", { LerpTime = 0.25 } )

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5, OffsetX = 0, OffsetY = 0, Retarget = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.5, ZoomType = "Ease" })
end

function ErisSelfBuffClear( triggerArgs )
	PlaySound({ Name = "/SFX/WrathOver2", Id = triggerArgs.triggeredById })
	thread( PlayVoiceLines, GlobalVoiceLines.ErisSelfBuffClearedVoiceLines, true )
end

function ErisKillPresentation( unit, args )
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
	AddInputBlock({ Name = "ErisKillPresentation" })
	LockCameraMotion("ErisKillPresentation")
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	local deathPanSettings = args
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

	BlockProjectileSpawns({ ExcludeWeaponName = "WeaponLob" })
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})

	for k, unitId in ipairs( GetIdsByType({ Names = unit.WipeEnemyTypesOnDeath }) ) do
		thread( Kill, ActiveEnemies[unitId] )
	end

	SetPlayerInvulnerable( "ErisKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	if args.AddInterBiomeTimerBlock then
		AddTimerBlock( CurrentRun, "InterBiome" )
	end
	AddTimerBlock( CurrentRun, "ErisKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	ClearCameraClamp({ LerpTime = 0 })
	local cameraPanTime = 1.5
	if deathPanSettings.StartPanTime then
		cameraPanTime = deathPanSettings.StartPanTime
	end
	local offsetY = unit.DeathPanOffsetY or 0
	PanCamera({ Id = victimId, Duration = cameraPanTime, OffsetY = offsetY })
	FocusCamera({ Fraction = args.PanZoomFraction or 1.1, Duration = cameraPanTime })
	ZeroMouseTether("ErisKillPresentation")
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
	if deathPanSettings.FlashRed then
		local duration = deathPanSettings.FlashDuration or 0.5
		Flash({ Id = victimId, Speed = 0.01, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = duration, ExpireAfterCycle = true })
	end

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
	PlaySound({ Name = "/SFX/StabSplatterEndSequence", Delay = 0.52 })

	wait( 0.15 )
	if killerId == CurrentRun.Hero.ObjectId then
		SetPlayerFade({ Flag = "KillPresentation"})
	else
		SetAlpha({ Id = killerId, Fraction = 0, Duration = 0.3 })
	end
	ClearEffect({ Id = killerId, Name = "KillDamageBonus" })

	wait( cameraPanTime )

	local textMessage = deathPanSettings.Message
	if deathPanSettings.BossDifficultyMessage and GetNumShrineUpgrades( "BossDifficultyShrineUpgrade" ) > 0 then
		textMessage = deathPanSettings.BossDifficultyMessage
	end

	thread( DisplayInfoBanner, nil, { 
		Text = textMessage or "BiomeClearedMessage", 
		Delay = 0.75, 
		TextColor = Color.White, 
		TextFadeColor = {64,230,255,255},
		Layer = "Overlay", 
		FontScale = 0.9,
		AnimationName = "InfoBannerBossKillIn",
		AnimationOutName = "InfoBannerBossKillOut",
		Duration = 3.75 } )

	if deathPanSettings.BatsAfterDeath then
		thread( SendCritters, { MinCount = 80, MaxCount = 90, StartX = 0, StartY = 300, MinAngle = 75, MaxAngle = 115, MinSpeed = 400, MaxSpeed = 2000, MinInterval = 0.03, MaxInterval = 0.1, GroupName = "CrazyDeathBats" } )
	end

	CreateAnimation({ DestinationId = victimId, Name = "ErisDeathHandsFxIn", Group = "Combat_Menu_Overlay_Additive" })
	local grabSoundId = PlaySound({ Name = "/SFX/Player Sounds/MelMagicalChargeLoop" })
	wait( 1.0 )
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGrabCharge" })
	wait( 1.0 )
	CreateAnimation({ DestinationId = victimId, Name = "ErisDeathHandsFxBurst", Group = "Combat_Menu_Overlay_Additive" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TitanToggleLong" })
	StopSound({ Id = grabSoundId, Duration = 0.3 })
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/HadesSkullExplode" })
	wait( 0.2 )
	PlaySound({ Name = "/SFX/Enemy Sounds/Charon/CharonPillarExplodeShort2" })
	wait( 3.3 )
	SetAlpha({ Id = victimId, Fraction = 0, Duration = 0.0 })

	if deathPanSettings.KillerEndAngle ~= nil then
		SetGoalAngle({ Id = killerId, Angle = deathPanSettings.KillerEndAngle })
	end

	if deathPanSettings.KillerTeleportId ~= nil then
		Teleport({ Id = killerId, DestinationId = deathPanSettings.KillerTeleportId })
	end
	if deathPanSettings.VictimTeleportId ~= nil then
		Teleport({ Id = victimId, DestinationId = deathPanSettings.VictimTeleportId })
	end

	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0.0, Duration = 0.3 })

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationId = killerId })
	if killerId == CurrentRun.Hero.ObjectId then
		ClearPlayerFade( "KillPresentation" )
	else
		SetAlpha({ Id = killerId, Fraction = 1.00, Duration = 0.3 })
	end
	RemoveFromGroup({ Id = killerId, Names = { "Combat_Menu_Overlay_Backing" } })
	AddToGroup({ Id = killerId, Name = "Standing", DrawGroup = true })

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 3.0, EaseOut = 0.5 })
	local defaultZoom = 1.0
	if CurrentHubRoom ~= nil then
		defaultZoom = CurrentHubRoom.ZoomFraction or defaultZoom
	else
		defaultZoom = CurrentRun.CurrentRoom.ZoomFraction or defaultZoom
	end
	FocusCamera({ Fraction = defaultZoom, Duration = 3.0, ZoomType = "Ease" })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	wait( 1.0 )
	SetAnimation({ DestinationId = killerId, Name = "MelinoeIdle" })
	UnlockCameraMotion("ErisKillPresentation")
	RemoveInputBlock({ Name = "ErisKillPresentation" })
	RemoveTimerBlock( CurrentRun, "ErisKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "ErisKillPresentation" )
	ShowCombatUI("BossKill")
	ClearEffect({ Ids = { killerId }, All = true })
	RemoveEffectBlock({ Id = killerId, All = true })
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	ToggleCombatControl( CombatControlsDefaults, true, "BossKill" )
	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
end

function PlayErisTauntAnim( source, args )
	if source ~= nil then
		SetAnimation({ Name = "Enemy_Eris_HubToCombatIdle", DestinationId = source.ObjectId })
		wait(1.2)
		SetAnimation({ Name = "Enemy_Eris_Reload_PreFight", DestinationId = source.ObjectId })
	end
end

function CirceBlessingPreChoicePresentation( source, args )
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1.0, Duration = 1.0 })
end

function CirceBlessingPostChoicePresentation( screen, args )
	
	PlaySound({ Name = screen.Source.ConfirmSound or "/SFX/Menu Sounds/GodBoonChoiceConfirm" })
	thread( PlayVoiceLines, GlobalVoiceLines.MiscEndVoiceLines_Circe, nil, screen.OpenedFrom, args )

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

	local circeId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Circe_01" })
	CreateAnimation({ Name = "StatusIconNPCRescued", DestinationId = circeId })

	local cauldronPoints = GetIdsByType({ Name = "CrossroadsCauldronSet01"})
	if not IsEmpty( cauldronPoints ) then
		CreateAnimation({ Name = "CauldronSmokeSmaller", DestinationId = cauldronPoints[1] })
		PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova", Id = cauldronPoints[1] })
	end

	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function MuteSpeaker( source )
	source.Mute = true
end

function MuteSpeakerPermanent( source )
	source.MutePermanent = true
end

function UnmuteSpeakerPermanent( source )
	source.MutePermanent = false
end

function ShipsLeaveRoomPresentation( currentRun, exitDoor )
	
	RunWeaponMethod({ Id = currentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
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

	Halt({ Id = CurrentRun.Hero.ObjectId })
	wait( 0.02 )

	AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = heroExitPointId })
	AdjustZoom({ Fraction = (currentRun.CurrentRoom.ZoomFraction or 0.75) * 1.1, LerpTime = 1.2 })

	thread( PlayVoiceLines, HeroVoiceLines.ShipsExitVoiceLines, false )
	PlaySound({ Name = "/SFX/ShipsDoorTeleport" })

	-- Mel cast anim 
	SetAnimation({ Name = "Melinoe_Cast_Start", DestinationId = currentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })
	
	-- start charging energy VFX
	CreateAnimation({ DestinationId = exitDoorId, Name = "ShipsDoorMelZwoop", Group = "FX_Standing_Add" }) --nopkg
	wait( 1.2 )

	-- energy shot VFX and camera effects
	PlaySound({ Name = "/SFX/ShipsDoorUse" })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.2 })
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.1 })

	LeaveRoomAudio( currentRun, exitDoor )
	if exitDoor.Room.ExitTowardsFunctionName ~= nil then
		CallFunctionName( exitDoor.Room.ExitTowardsFunctionName, exitDoor, exitDoor.Room.ExitTowardsFunctionArgs )
	end

	wait(0.1)

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	wait(0.02)

	FullScreenFadeOutAnimation( "RoomTransitionIn_TopRight" )

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
		roomIntroSequenceDuration = roomIntroSequenceDuration + 0.5
		roomIntroPanDuration = roomIntroPanDuration + 0.5
	end
	
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75), LerpTime = 0.0 })
	else
		AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75) * (roomData.IntroZoomFactor or 0.55), LerpTime = 0.0 })
	end
	if currentRoom.CameraStartPoint then
		LockCamera({ Id = currentRoom.CameraStartPoint, Duration = 0 }) 
		CreateAnimation({ DestinationId = currentRoom.CameraStartPoint, Name = "ShipsGustSpawnerForward", GroupName = "Combat_UI_World" })
	end

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.0 })
	Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 30 })
	wait(0.03)

	FadeIn({ Duration = 0.0 })

	FullScreenFadeInAnimation( "RoomTransitionOut_TopRight" )

	if currentRoom.CameraEndPoint ~= nil then
		local cameraSetupPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRoom.CameraEndPoint, OffsetX = -80, OffsetY = 30  })
		LockCamera({ Id = cameraSetupPoint, Duration = roomIntroSequenceDuration })
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

	--PanCamera({ Id = currentRoom.CameraEndPoint, OffsetX = 70, OffsetY = -34, Duration = 0.2, Retarget = true })

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1, Duration = 0.1 })
	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "DustPuffA" })
	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "ShipsDoorMelZwoop_In", OffsetZ = 80 }) --nopkg
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeDash" })
	ShakeScreen({ Speed = 500, Distance = 8, FalloffSpeed = 1000, Duration = 0.2 })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or roomData.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	wait( 0.03 )
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
end

function RoomEntranceBossShips( currentRun, currentRoom, args )

	args = args or {}

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or 0.3
	local roomIntroPanDuration = roomData.IntroPanDuration or 1.5

	SetAnimation({ Name = args.BossIntroAnimation, DestinationId = args.BossId })

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
	FullScreenFadeInAnimation( "RoomTransitionOut_TopRight" )

	wait( roomIntroPanDuration )

	AdjustZoom({ Fraction = (currentRoom.ZoomFraction or 0.75), LerpTime = 0.2 })

	wait( 0.05 )

	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "ShipsDoorBurstArrival" })
	PlaySound({ Name = "/SFX/ShipsTeleportArrive", Id = CurrentRun.Hero.ObjectId })

	wait( 0.10 )

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1, Duration = 0.1 })
	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "DustPuffA" })
	CreateAnimation({ DestinationId = currentRoom.HeroEndPoint, Name = "ProjectileTempFlare", OffsetZ = 80 })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeDash" })
	ShakeScreen({ Speed = 500, Distance = 8, FalloffSpeed = 1000, Duration = 0.2 })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

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

function RoomEntranceCharybdis( currentRun, currentRoom )

	local charybdisId = 737128
	local tentacleIds = { 737129, 737132, 737131, 737133, 737130, }

	AddInputBlock({ Name = "RoomEntranceCrawlerMiniBoss" })

	--SetAlpha({ Id = charybdisId, Fraction = 0, Duration = 0 })
	SetAlpha({ Ids = tentacleIds, Fraction = 0, Duration = 0 })
	SetUntargetable({ Ids = tentacleIds })
	AngleTowardTarget({ Ids = tentacleIds, DestinationId = CurrentRun.Hero.ObjectId })

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
	PlaySound({ Name = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_12_SFX", Id = charybdisId })
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
	for k, id in pairs(tentacleIds) do
		CreateAnimation({ DestinationId = id, Name =  "CharybdisTailBurstA" })
		SetAlpha({ Id = id, Fraction = 1, Duration = 0 })
		SetAnimation({ Name = "Enemy_CharybdisTentacle_Surface", DestinationId = id })
		SetTargetable({ Id = id })
		wait( 0.05 )
	end

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
		EndAutoSprint({ Halt = true, EndWeapon = true })

		SessionMapState.BlockInfoBanners = true
		SetThreadWait( "InfoBanner", 0.01 )

		thread( BiomeOverlookShipsFadeIdsOut )

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
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.4, EaseOut = 1, EaseIn = 0, Retarget = true, FromCurrentLocation = true })
	FadeOut({ Color = Color.Black, Duration = 0.3 })
	thread( BiomeOverlookShipsFadeIdsIn )
	wait( 0.3 )
	BiomeBackToRoom( room, args )
	wait( args.BlackDuration )
	SessionMapState.BlockInfoBanners = false
	FadeIn({ Duration = 0.3 })
	RemoveInputBlock({ Name = "BiomeOverlookShips" })
end

function BiomeOverlookShipsFadeIdsOut()
	local backgroundIds = GetIds({ Names = { "Standing", "Terrain_Decor_01", "Terrain_Decor_02", "Terrain_Decor_03", "Terrain_Decor_04" } })
	local stragglerIds = { 739889, 739887, 739890, 739977, 739978, 739980, 739979, }
	wait( 0.9 )
	SetAlpha({ Ids = backgroundIds, Fraction = 0.0, Duration = 0.5 })
	SetAlpha({ Ids = stragglerIds, Fraction = 0.0, Duration = 0.5 })
end

function BiomeOverlookShipsFadeIdsIn()
	local backgroundIds = GetIds({ Names = { "Standing", "Terrain_Decor_01", "Terrain_Decor_02", "Terrain_Decor_03", "Terrain_Decor_04" } })
	local stragglerIds = { 739889, 739887, 739890, }
	local beamIds = { 739977, 739978, 739980, 739979, }
	wait( 0.1 )
	SetAlpha({ Ids = backgroundIds, Fraction = 1.0, Duration = 0.3 })
	SetAlpha({ Ids = stragglerIds, Fraction = 1.0, Duration = 0.3 })
	SetAlpha({ Ids = beamIds, Fraction = 1.0, Duration = 10.0 })
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
	SetLifeProperty({ Property = "TriggerOnHit", Value = true, DestinationId = id, DataValue = true })
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
	thread( HeraclesExit ) -- If he's waiting for a potential gift
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

	UseableOff({ Id = wheel.ObjectId })
	UseableOff({ Ids = GetIdsByType({ Name = "ShipsSteeringWheelRight" }) })

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
	
	UseableOff({ Id = wheel.ObjectId })
	UseableOff({ Ids = GetIdsByType({ Name = "ShipsSteeringWheelLeft" }) })
	
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

	if wheel == nil then
		return
	end

	CreateAnimation({ DestinationId = wheel.ObjectId, Name = "ShipsSteeringWheelBreak", Group = "FX_Standing" }) --nopkg
	SpawnObstacle({ Name = "ShipsSteeringWheelDestroyed", DestinationId = wheel.ObjectId, Group = "Standing" })
	RecordObjectState( CurrentRun.CurrentRoom, wheel.ObjectId, "SpawnInPlace", "ShipsSteeringWheelDestroyed" )
	Destroy({ Id = wheel.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, wheel.ObjectId, "Destroyed", true )

	thread( PlayVoiceLines, HeroVoiceLines.ShipsWheelDestroyedVoiceLines )

	if AudioState.MusicSection == 0 then
		SetMusicSection( 1 )
	end
end