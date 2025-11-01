function TyphonHeadKillPresentation( unit, args )
	
	SetPlayerInvulnerable( "TyphonHeadKillPresentation" )
	AddInputBlock({ Name = "TyphonHeadKillPresentation" })
	killTaggedThreads( "TyphonHeadWeaponCameraThread" )
	LockCamera({ Ids = heroId, Duration = 0.0, Retarget = true })

	local chronosId = GetRandomValue(GetIdsByType({Name = "Chronos_TyphonFight"}))
	if chronosId ~= nil then
		ActiveEnemies[chronosId].CannotDieFromDamage = false
		thread( Kill, ActiveEnemies[chronosId] ) -- Kill Chronos
	end
	
	if unit.IncursionUnitId ~= nil and ActiveEnemies[unit.IncursionUnitId] ~= nil and IsAlive({ Id = unit.IncursionUnitId }) then
		ApplyUpwardForce({ Id = unit.IncursionUnitId, Speed = 2000, SelfApplied = true })
		IgnoreGravity({ Id = unit.IncursionUnitId })
		SetAlpha({ Id = unit.IncursionUnitId, Fraction = 0.0, Duration = 0.5 })
		thread(DestroyOnDelay, { unit.IncursionUnitId }, 0.5 )
	end

	ClearPauseMenuTakeover()

	wait( 0.01 )
	EndMusic()
	if IsGameStateEligible( unit, args.SpecialKillRequirements ) then
		TyphonSpecialKillPresentation( unit, args )
	else
		CreateAnimation({ Name = "TyphonDeathGradient", DestinationId = ScreenAnchors.Vignette, Group = "Combat_Menu_TraitTray_Overlay" })
		thread( PlayVoiceLines, unit.DefeatedVoiceLines, true, unit )
		GenericBossKillPresentation( unit, args )
	end

	wait( 1.75 )

	Destroy({ Ids = GetIds({ Name = "TyphonHeadDeathDelete" }) })
	Activate({ Ids = GetInactiveIds({ Name = "ExitPathReveal" }) })
	UseableOn({ Id = 768210 }) -- Exit door
	RemoveInputBlock({ Name = "TyphonHeadKillPresentation" })
	SetPlayerVulnerable("TyphonHeadKillPresentation")
	OpenRunClearScreen()

end

function TyphonSpecialKillPresentation( unit, args )
	args = args or {}
	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	SessionMapState.TyphonSpecialKillPresentation = true

	-- Record the stats now so the boss can check them in the requirements for BossKillVoiceLines
	RecordEncounterClearStats()

	ClipEvent({ Icon = "steam_combat", Title = GetDisplayName({ Text = args.Message }), Description = "", StartOffset = 0.0, Duration = 5.0 })

	AddInputBlock({ Name = "TyphonSpecialKillPresentation" })
	LockCameraMotion( "TyphonSpecialKillPresentation" )

	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	EndSpellTransform()
	ClearEffect({ Ids = { victimId, killerId }, All = true, BlockAll = true, })
	EffectPostClearAll( unit )
	if unit.Frozen then
		UnfrozenPresentation( unit, { SkipPresentation = true })
	end

	BlockProjectileSpawns({ ExcludeWeaponName = "WeaponLob" })
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true, CancelQueuedProjectilesOnId = CurrentRun.Hero.ObjectId })
	
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})

	SetPlayerInvulnerable( "TyphonSpecialKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	if args.AddInterBiomeTimerBlock then
		AddTimerBlock( CurrentRun, "InterBiome" )
	end
	AddTimerBlock( CurrentRun, "TyphonSpecialKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	ZeroMouseTether("TyphonSpecialKillPresentation")
	CancelWeaponFireRequests({ Id = killerId })
	ToggleCombatControl( CombatControlsDefaults, false, "BossKill" )
	HideCombatUI("BossKill")

	ClearCameraClamp({ LerpTime = 1.0 })
	FocusCamera({ Fraction = 1.0, Duration = 2.0, })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	end

	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = victimId })
	thread( VictimDeathHold, victimId, 0.02, 0.5 )
	if args.FlashRed then
		local duration = args.FlashDuration or 0.5
		Flash({ Id = victimId, Speed = 0.01, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = duration, ExpireAfterCycle = true })
	end

	RemoveFromGroup({ Id = killerId, Names = { "Standing" } })
	AddToGroup({ Id = killerId, Name = "Combat_Menu_Overlay", DrawGroup = true })

	-- black out world
	AdjustFrame({ Color = Color.TransparentRed, Duration = 0.0, Fraction = 0 })
	ScreenAnchors.DeathBackground = ScreenAnchors.DeathBackground or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = ScreenAnchors.DeathBackground, Fraction = 10 })
	SetColor({ Id = ScreenAnchors.DeathBackground, Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 1.0, Duration = 0 })

	Stop({ Id = victimId })
	SetGoalAngle({ Id = victimId, Angle = 265, CompleteAngle = true })
	SetUnitProperty({ Property = "RotationSpeed", Value = 9999, DestinationId = victimId })
	SetUnitProperty({ Property = "CosmeticRotationSpeed", Value = 9999, DestinationId = victimId })

	wait(0.05)

	SetAnimation({ Name = "Enemy_TyphonHead_StunnedStart", DestinationId = unit.ObjectId })
	Teleport({ Id = victimId, DestinationId = killerId, OffsetY = -1000 })

	wait( 1.0 )

	SetAnimation({ Name = GetEquippedWeaponValue( "UnequipAnimation" ), DestinationId = CurrentRun.Hero.ObjectId })
	SetGoalAngle({ Id = killerId, Angle = 90 })

	wait( 0.2 )

	PanCamera({ Ids = { victimId, killerId }, Duration = 5.0, FromCurrentLocation = true, Retarget = true })

	wait( 0.8 )

	RemoveFromGroup({ Id = victimId, Name = "Standing" })
	AddToGroup({ Id = victimId, Name = "Combat_Menu_Overlay_Backing", DrawGroup = true })

	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/HadesSpearEmerge", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.TyphonFatalityVoiceLines, true )
	SetAnimation({ Name = "Melinoe_TyphonKill", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 3.4 )

	thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.17, Duration = 0.65 }, { ScreenPreWait = 2.8, LeftFraction = 0.3, Duration = 0.6 } } )

	thread( BossDeathFlash, { DestinationId = victimId, StartDelay = 0.0, StopDelay = 0.3, OffsetY = 500 } )
	CreateAnimation({ Name = "TyphonSpecialKillHitFx", DestinationId = victimId, OffsetY = 500, Group = "Combat_Menu_Overlay_Additive" })
	CreateAnimation({ Name = "TyphonDeathGradient", DestinationId = ScreenAnchors.Vignette, Group = "Combat_Menu_TraitTray_Overlay" })
	
	thread( PlayVoiceLines, unit.DefeatedVoiceLines, true, unit )

	FocusCamera({ Fraction = 1.15, Duration = 0.15, })

	wait( 0.15 )

	ShakeScreen({ Speed = 200, Distance = 2, Duration = 0.95, FalloffSpeed = 1400 })
	FocusCamera({ Fraction = 1.21, Duration = 2.1, })

	if unit.DeathSound ~= nil then
		PlaySound({ Name = unit.DeathSound, Id = unit.ObjectId })
		unit.DeathSound = nil
	end
	unit.Mute = true

	if args.StartSound then
		PlaySound({ Name = args.StartSound })
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteShocked" })
	end
	if not args.IgnoreEndMusic then
		EndMusic()
	end

	wait( 0.5 + 0.4 )

	PanCamera({ Id = victimId, Duration = 2.0, OffsetY = unit.DeathPanOffsetY or 0, Retarget = true })
	SetAnimation({ Name = "Enemy_TyphonHead_Death_Final", DestinationId = unit.ObjectId })
	unit.DeathAnimation = nil

	local cameraPanTime = args.StartPanTime or 1.5
	FocusCamera({ Fraction = args.PanZoomFraction or 1.1, Duration = cameraPanTime, ZoomType = "Undershoot" })

	if killerId == CurrentRun.Hero.ObjectId then
		SetPlayerFade({ Flag = "KillPresentation"})
	else
		SetAlpha({ Id = killerId, Fraction = 0, Duration = 0.3 })
	end
	ClearEffect({ Id = killerId, Name = "KillDamageBonus" })

	wait( cameraPanTime )

	local textMessage = "TyphonDestroyedMessage"

	thread( DisplayInfoBanner, nil, { 
		Text = textMessage or "BiomeClearedMessage", 
		Delay = 0.75, 
		TextColor = Color.White, 
		TextFadeColor = {64,230,255,255},
		Layer = "Overlay", 
		FontScale = 0.9,
		AnimationName = "InfoBannerBossKillIn",
		AnimationOutName = "InfoBannerBossKillOut",
		Duration = 3.75,

		SubtitleFont = args.SubtitleFont or "SpectralSCMedium",
		SubtitleOffsetY = args.SubtitleOffsetY or 10,
		SubtitleDelay = args.SubtitleDelay or 3.0,

		SubTextColor = args.SubTextColor or Color.NarratorVoice,
		SubtitleText = args.SubtitleText or GetRandomValue(args.SubtitleTextOptions),
		SubtitleTextRevealSound = "/Leftovers/World Sounds/MapZoomInTight",
	} )

	wait( args.EndPanTime or 5.5 )

	if CurrentRun.CurrentRoom.Encounter.BossKillGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[CurrentRun.CurrentRoom.Encounter.BossKillGlobalVoiceLines], false )
	end

	if CurrentRun.CurrentRoom.Encounter.DeathExtraSounds ~= nil then
		local randomSound = GetRandomValue( CurrentRun.CurrentRoom.Encounter.DeathExtraSounds )
		PlaySound({ Name = randomSound })
	end

	Teleport({ Id = killerId, DestinationId = roomData.TyphonSpecialKillTeleportId })
	SetAnimation({ DestinationId = killerId, Name = "MelinoeIdle" })

	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0.0, Duration = 0.3 })

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationId = killerId })
	if killerId == CurrentRun.Hero.ObjectId then
		ClearPlayerFade( "KillPresentation" )
	else
		SetAlpha({ Id = killerId, Fraction = 1.00, Duration = 0.3 })
	end
	RemoveFromGroup({ Id = killerId, Names = { "Combat_Menu_Overlay" } })
	AddToGroup({ Id = killerId, Name = "Standing", DrawGroup = true })

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0, OffsetY = -1000 })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 3.0, EaseOut = 0.5, Retarget = true })
	local defaultZoom = 1.0
	if CurrentHubRoom ~= nil then
		defaultZoom = CurrentHubRoom.ZoomFraction or defaultZoom
	else
		defaultZoom = CurrentRun.CurrentRoom.ZoomFraction or defaultZoom
	end
	FocusCamera({ Fraction = defaultZoom, Duration = 3.0, ZoomType = "Ease" })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	wait( 0.1 )

	RemoveFromGroup({ Id = victimId, Names = { "Combat_Menu_Overlay_Backing" } })
	AddToGroup({ Id = victimId, Name = "Standing", DrawGroup = true })

	wait( 0.9 )

	RemoveInputBlock({ Name = "TyphonSpecialKillPresentation" })
	RemoveTimerBlock( CurrentRun, "TyphonSpecialKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "TyphonSpecialKillPresentation" )
	UnlockCameraMotion("TyphonSpecialKillPresentation")
	ShowCombatUI("AutoHide") -- this presentation takes long enough for HUD auto-hide to kick in!
	ShowCombatUI("BossKill")
	ClearEffect({ Ids = { killerId }, All = true })
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	SessionMapState.TyphonSpecialKillPresentation = nil
	ToggleCombatControl( CombatControlsDefaults, true, "BossKill" )
	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
end


function TyphonFakeDeathTransition( typhon, currentRun, aiStage )

	GameState.TyphonFakeDeathCount = GameState.TyphonFakeDeathCount or 0

	-- Disable Chronos
	local chronosId = 793226
	local chronos = ActiveEnemies[chronosId]

	killTaggedThreads(chronos.AIThreadName)
	killTaggedThreads(chronos.AIThreadName.."Fuse")
	if chronos.DestroyIdsOnDeath ~= nil then
		Destroy({ Ids = chronos.DestroyIdsOnDeath })
	end
	killWaitUntilThreads(chronos.AIThreadName)
	killWaitUntilThreads( chronos.AINotifyName )
	chronos.AIBehavior = nil
	chronos.ActiveWeaponCombo = nil
	chronos.ChainedWeapon = nil
	chronos.ChainedWeaponOptions = nil
	chronos.ForcedWeaponInterrupt = true
	Teleport({ Id = chronosId, DestinationId = 793224 })
	SetAlpha({ Id = chronosId, Fraction = 0, Duration = 0.0 })
	DestroyRequiredKills( { BlockLoot = true, SkipIds = { typhon.ObjectId } } )

	AddInputBlock({ Name = "TyphonHeadKillPresentation" })
	killTaggedThreads( "TyphonHeadWeaponCameraThread" )
	LockCamera({ Ids = heroId, Duration = 0.0, Retarget = true })

	SetUnitInvulnerable( typhon, "TyphonHeadChronosCurse" )
	ClearEnemySeekStatus( typhon )
	ClearPauseMenuTakeover()
	AddTimerBlock( CurrentRun, "TyphonTransition" )

	wait( 0.01 )

	EndMusic()
	thread( PlayVoiceLines, typhon.DefeatedVoiceLines, true, typhon )
	CreateAnimation({ Name = "TyphonDeathGradient", DestinationId = ScreenAnchors.Vignette, Group = "Combat_Menu_TraitTray_Overlay" })

	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, All = true, })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeIdle" })
	thread(MoveHeroToRoomPosition, { DestinationId = 50059, AngleTowardsIdOnEnd = 793224 })

	TyphonFakeDeathKillPresentation( typhon, typhon.OnDeathFunctionArgs )

	SetAnimation({ DestinationId = chronos.ObjectId, Name = "Enemy_Chronos_Idle" })
	SetAlpha({ Id = chronosId, Fraction = 0, Duration = 0.0 })

	wait( 1.75 )

	typhon.CurrentPhase = typhon.CurrentPhase + 1

	typhon.MaxHealth = aiStage.NewMaxHealth or typhon.MaxHealth
	typhon.Health = typhon.MaxHealth
	if aiStage.SetHealthPercent ~= nil then
		typhon.Health = typhon.Health * aiStage.SetHealthPercent
	end

	-- not so fast
	thread( PlayVoiceLines, GlobalVoiceLines.PreBabalityVoiceLines )
	local bubbleId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ChronosCurseTimeTrap", DestinationId = bubbleId, })
	AngleTowardTarget({ Id = chronosId, DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.75 )

	MusicPlayer( "/Music/ChronosBossFightMusic" )
	SetMusicSection( 8, MusicId )

	SetAlpha({ Id = chronosId, Fraction = 1, Duration = 0.3 })
	CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = chronosId })
	SetAnimation({ DestinationId = chronosId, Name = "Enemy_Chronos_TeleportDashIn" })

	-- wait( 0.5 )
	-- FakeDeathTyphonEntrance(CurrentRun, CurrentRun.CurrentRoom, RoomData.Q_Boss02.EntranceFunctionArgs)

	LockCamera({ Ids = { CurrentRun.Hero.ObjectId, chronos.ObjectId }, Duration = 1.5 })

	wait( 0.5 )

	SetAnimation({ DestinationId = chronos.ObjectId, Name = "Enemy_Chronos_CastSlowPreFire_Slow" })

	wait( 1.65 )
	thread( PlayVoiceLines, GlobalVoiceLines.BabalityVoiceLines )

	wait( 0.5 )

	SetAnimation({ DestinationId = chronos.ObjectId, Name = "Enemy_Chronos_CastSlowFire" })
	CreateAnimation({ DestinationId = chronos.ObjectId, Name = "ChronosRadialExplosionA", })

	wait( 0.1 )

	-- Young Mel Polymorph Presentation
	CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "HecatePolymorphDissipate", })
	ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = chronos.ObjectId, EffectName = "ChronosPolymorphStun", DataProperties = EffectData.ChronosPolymorphStun.DataProperties })
	ClearCameraClamp({ LerpTime = 0.0 })
	AdjustZoom({ Fraction = 1.05, LerpTime = 0.1, })
	thread( PolymorphSimSlow )
	SetAnimation({ Name = "Melinoe_Young_Excited_Start", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 1.5 )
	local textLines = GetRandomEligibleTextLines( typhon, typhon.BossPhaseChangeTextLineSets, GetNarrativeDataValue( typhon, "BossPhaseChangeTextLinePriorities" ) )
	PlayTextLines( typhon, textLines )

	FakeDeathTyphonEntrance(CurrentRun, CurrentRun.CurrentRoom, RoomData.Q_Boss02.EntranceFunctionArgs)

	StopAnimation({ Name = "ChronosCurseTimeTrapLoop", DestinationId = bubbleId })
	CreateAnimation({ Name = "ChronosCurseTimeTrapOut", DestinationId = bubbleId })

	wait(0.5, typhon.AIThreadName)

	RemoveInputBlock({ Name = "TyphonHeadKillPresentation" })

	wait(0.5, typhon.AIThreadName)

	LockCamera({ Ids = { CurrentRun.Hero.ObjectId, typhon.ObjectId }, Duration = 1.0 })

	SetUnitVulnerable( typhon )

	thread(StartChronosPolymorphChallenge)

	wait(1.0, typhon.AIThreadName)

	Destroy({ Id = bubbleId })
	thread( PlayVoiceLines, GlobalVoiceLines.PostBabalityVoiceLines )

	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0 })

	RemoveTimerBlock( CurrentRun, "TyphonTransition")

	GameState.TyphonFakeDeathCount = GameState.TyphonFakeDeathCount + 1

	-- Enable Chronos
	chronos.ForcedNextWeapon = "ChronosTeleportOut"
	SetupAI(chronos)
end

function TyphonFakeDeathKillPresentation( unit, args )
	args = args or {}

	AddInputBlock({ Name = "TyphonFakeDeathKillPresentation" })
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	ClearEffect({ Ids = { victimId, killerId }, All = true })
	EffectPostClearAll( unit )
	if unit.Frozen then
		UnfrozenPresentation( unit, { SkipPresentation = true })
	end

	SetAnimation({ Name = unit.DeathAnimation, DestinationId = unit.ObjectId })
	PlaySound({ Name = unit.DeathSound, Id = unit.ObjectId })

	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})

	SetPlayerInvulnerable( "TyphonFakeDeathKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	AddTimerBlock( CurrentRun, "TyphonFakeDeathKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	ClearCameraClamp({ LerpTime = 0 })
	PanCamera({ Id = victimId, Duration = args.StartPanTime, OffsetY = unit.DeathPanOffsetY })
	FocusCamera({ Fraction = args.PanZoomFraction, Duration = args.StartPanTime })
	ZeroMouseTether("TyphonFakeDeathKillPresentation")
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

	PlaySound({ Name = args.StartSound })
	
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, IgnoreAnimations = true, DataValue = false, DestinationId = killerId })
	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = victimId })
	thread( VictimDeathHold, victimId, 0.02, 0.5 )

	Flash({ Id = victimId, Speed = 0.01, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = args.FlashDuration or 0.5, ExpireAfterCycle = true })

	RemoveFromGroup({ Id = killerId, Names = { "Standing" } })
	AddToGroup({ Id = killerId, Name = "Combat_Menu_Overlay_Backing", DrawGroup = true })
	RemoveFromGroup({ Id = victimId, Name = "Standing" })
	AddToGroup({ Id = victimId, Name = "Combat_Menu_Overlay_Backing", DrawGroup = true })

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

	wait( args.StartPanTime )

	local textMessage = args.Message
	if args.BossDifficultyMessage and GetNumShrineUpgrades( "BossDifficultyShrineUpgrade" ) > 0 then
		textMessage = args.BossDifficultyMessage
	end
	if GameState.TyphonFakeDeathCount == 1 then
		textMessage = "TyphonDefeatedMessageAlt01"
	elseif unit.FakeDeathAltMessages ~= nil and GameState.TyphonFakeDeathCount > 1 then
		textMessage = GetRandomValue(unit.FakeDeathAltMessages)
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

	wait( args.EndPanTime or 5.5 )

	if CurrentRun.CurrentRoom.Encounter.BossKillGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[CurrentRun.CurrentRoom.Encounter.BossKillGlobalVoiceLines], false )
	end

	if CurrentRun.CurrentRoom.Encounter.DeathExtraSounds ~= nil then
		local randomSound = GetRandomValue( CurrentRun.CurrentRoom.Encounter.DeathExtraSounds )
		PlaySound({ Name = randomSound })
	end

	local heroTeleportId = 50059
	Stop({ Id = killerId })
	Teleport({ Id = killerId, DestinationId = heroTeleportId })

	SetAlpha({ Ids = GetIds({ Name = "StartFX" }), Fraction = 1.0, Duration = 0.0 })
	SetAlpha({ Ids = GetIds({ Name = "BehindStorm" }), Fraction = 0.0, Duration = 0.0 })

	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0.0, Duration = 0.3 })

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationId = killerId })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = unit.SpeedMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationId = victimId })

	if killerId == CurrentRun.Hero.ObjectId then
		ClearPlayerFade( "KillPresentation" )
	else
		SetAlpha({ Id = killerId, Fraction = 1.00, Duration = 0.3 })
	end
	RemoveFromGroup({ Id = killerId, Names = { "Combat_Menu_Overlay_Backing" } })
	AddToGroup({ Id = killerId, Name = "Standing", DrawGroup = true })

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 3.0, EaseOut = 0.5 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 3.0, ZoomType = "Ease" })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	wait( 0.1 )

	RemoveFromGroup({ Id = victimId, Names = { "Combat_Menu_Overlay_Backing" } })
	AddToGroup({ Id = victimId, Name = "Standing", DrawGroup = true })

	wait( 0.9 )

	SetAnimation({ DestinationId = killerId, Name = "MelinoeIdle" })
	RemoveInputBlock({ Name = "TyphonFakeDeathKillPresentation" })
	RemoveTimerBlock( CurrentRun, "TyphonFakeDeathKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "TyphonFakeDeathKillPresentation" )
	ShowCombatUI("BossKill")
	ClearEffect({ Ids = { killerId }, All = true })
	
	if SessionMapState.ManaDropId then
		Destroy({ Id = SessionMapState.ManaDropId })
		SessionMapState.ManaDropId = nil
	end
	if SessionMapState.DrinkDropId then
		Destroy({ Id = SessionMapState.DrinkDropId })
		SessionMapState.DrinkDropId = nil
	end

	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	ToggleCombatControl( CombatControlsDefaults, true, "BossKill" )
	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
end

function FakeDeathTyphonEntrance( currentRun, currentRoom, args )

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter
	local chronos = ActiveEnemies[args.ChronosId]
	local typhon = ActiveEnemies[args.TyphonId]

	ClearCameraClamp({ LerpTime = 0 })
	HideCombatUI("BossEntrance")
	wait(0.03)

	Teleport({ Id = args.TyphonId, DestinationId = 800464, OffsetX = 0, OffsetY = -500 })
	local moveTarget = SpawnObstacle({ DestinationId = args.TyphonId, OffsetY = 650, Name = "InvisibleTarget" })
	SetThingProperty({ Property = "GrannyTexture", Value = "GR2/TyphonHeadStage3_Color", DestinationId = args.TyphonId })
	SetColor({ Id = args.TyphonId, Color = Color.Black, Duration = 0.0 })
	SetAlpha({ Id = args.TyphonId, Fraction = 0, Duration = 0 })
	AngleTowardTarget({ Id = args.TyphonId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ DestinationId = args.TyphonId, Name = args.TyphonStartAnimation })
	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 4.0, })
	PanCamera({ Id = args.TyphonIntroPanId, Duration = 4.0, EaseIn = 0.01, })

	wait( 1.5 )

	Stop({ Id = args.TyphonId })
	SetAnimation({ DestinationId = args.TyphonId, Name = args.TyphonIntroAnimation })
	SetColor({ Id = args.TyphonId, Color = Color.White, Duration = 1.0, EaseOut = 0.5 })
	SetAlpha({ Id = args.TyphonId, Fraction = 1.0, Duration = 0.25 })
	Move({ Id = args.TyphonId, DestinationId = moveTarget, OffsetX = 0, OffsetY = -500, SuccessDistance = 50, Strafe = true })

	wait(0.5)

	SetAlpha({ Ids = GetIds({ Name = "StartFX" }), Fraction = 0.0, Duration = 1.0 })

	wait(1.0)
	SetAlpha({ Ids = GetIds({ Name = "BehindStorm" }), Fraction = 1.0, Duration = 1.0 })
	
	wait(1.0)

	SetAnimation({ DestinationId = args.TyphonId, Name = "Enemy_TyphonHead_Laugh" })
	PlaySound({ Name = "/VO/Typhon_0032", DestinationId = args.TyphonId })

	--thread( PlayVoiceLines, encounterData.PreRoarVoiceLines, true )

	wait( 0.5 )
	MusicPlayer( "/Music/IrisMusicTyphon2EM" )

	wait( 1.9 )

	--thread( PlayVoiceLines, encounterData.FightStartVoiceLines, true )

	wait( args.TyphonIntroDelay or 0 )


	if not roomData.IgnoreClamps then
		local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
		DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })
		SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	end

	Destroy({ Id = moveTarget })

	UnblockCombatUI("BossEntrance")
end

function FortressMainDoorOpenPresentation( source, args )
	AddInputBlock({ Name = "FortressMainDoorOpening" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "FortressMainDoorOpening" )

	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	if roomData.GateMusic ~= nil then
		MusicPlayer( roomData.GateMusic )
		SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.MusicId, Value = 1.0, Duration = 2.0 })
	end

	local fortressDoorId = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetIdsByType({ Name = "FortressMainDoor" }), Distance = 300 })[1]

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.15, FromCurrentLocation = true, Retarget = true })
	PlayInteractAnimation( fortressDoorId, { Animation = GetEquippedWeaponValue( "WeaponInteractAnimation" ) })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = fortressDoorId })

	wait(0.7)

	SetAnimation({ Name = "FortressMainDoorOpen", DestinationId = fortressDoorId }) --nopkg
	PlaySound({ Name = "/SFX/TyphonBigDoorOpen" })
	ShakeScreen({ Speed = 500, Distance = 4, Duration = 4.0 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 4.0 }, } )

	thread( PlayVoiceLines, HeroVoiceLines.EnteredFortressVoiceLines, true )

	wait(0.5)

	local cameraPanId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -800 })
	PanCamera({ Id = cameraPanId, Duration = 8.0, FromCurrentLocation = true, EaseIn = 0 })
	FocusCamera({ Fraction = roomData.ZoomFraction * 0.85, Duration = 5, ZoomType = "Ease" })

	wait(2.5)

	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })

	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = fortressDoorId, DestinationIds = heroExitIds, Distance = 800 })
	if heroExitPointId > 0 then
		SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		local pathArgs = { SuccessDistance = 30 }
		local exitPath = CurrentRun.CurrentRoom.ExitPath or {}
		table.insert( exitPath, heroExitPointId )
		thread( MoveHeroAlongPath, exitPath, pathArgs )
	else
		if fortressDoorId ~= nil then
			AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = fortressDoorId })
		end
		SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0, Duration = 1.0 })
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = CurrentRun.CurrentRoom.ExitAnimation or RoomData.BaseRoom.ExitAnimation })
		CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = CurrentRun.CurrentRoom.ExitVfx or RoomData.BaseRoom.ExitVfx })
	end

	LeaveRoomAudio( CurrentRun, {} )

	wait(0.42)

	FullScreenFadeOutAnimation( "RoomTransitionIn_Up" )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "FortressMainDoorOpening" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function TyphonTremorPresentation( eventSource, args )

	eventSource.TyphonTremorPresentation = true
	GameState.TyphonTremorPresentation = true
	local delay = 5.0
	if args.DelayMin ~= nil and args.DelayMax ~= nil then
		delay = RandomFloat(args.DelayMin, args.DelayMax)
	end
	wait(delay)

	local soundId = PlaySound({ Name = "/Leftovers/Object Ambiences/OlympusQuakeSFX", Id = CurrentRun.Hero.ObjectId })

	ShakeScreen({ Speed = 150, Distance = 6, Duration = 3.0, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.3, Duration = 1.8 }, } )
	AdjustColorGrading({ Name = "Team02", Duration = 0.3 })

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

function TyphonIncursionArmSlam( eventSource, args )
	local delay = 0.0
	if args.DelayMin ~= nil and args.DelayMax ~= nil then
		delay = RandomFloat(args.DelayMin, args.DelayMax)
	end
	wait(delay, RoomThreadName)

	if CurrentRun.Hero.IsDead then
		return
	end
	
	SetSoundCueValue({ Names = { "Bass" }, Id = AudioState.MusicId, Value = 1.0, Duration = 0.3 })

	local unit = DeepCopyTable(EnemyData.TyphonArm_Incursion)
	local destinationId = args.DestinationId or GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetIds({ Name = args.SpawnGroup }) })
	unit.ObjectId = SpawnUnit({ Name = "TyphonArm_Incursion", Group = "Standing", DestinationId = destinationId })
	SetupUnit(unit)
	SetUntargetable({ Id = unit.ObjectId })
	unit.AIThreadName = unit.ObjectId.."AIThread"
	local angle = 308
	if CurrentRun.CurrentRoom.Flipped then
		angle = 232
	end
	SetGoalAngle({ Id = unit.ObjectId, Angle = angle })

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonArm_SlamFireLoop" })
	AdjustZLocation({ Id = unit.ObjectId, Distance = 2000 })
	IgnoreGravity({ Id = unit.ObjectId })

	ShakeScreen({ Speed = 400, Distance = 8, FalloffSpeed = 1000, Duration = 1.0 })
	if args.CameraMotion then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.1, Duration = 3.0, ZoomType = "Ease" })
	end
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar" })

	wait(0.02, unit.AIThreadName)

	if args.CameraMotion then
		PanCamera({ Ids = { CurrentRun.Hero.ObjectId, unit.ObjectId }, Duration = 1.0 })
	end

	CreateAnimation({ DestinationId = unit.ObjectId, Name = "FallingShadowTyphonArm" })

	thread( PlayVoiceLines, HeroVoiceLines.TyphonIncursionVoiceLines, true )
	
	wait(1.0, unit.AIThreadName)
	
	ObeyGravity({ Id = unit.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusRockThrowWhoosh" })
	
	wait(0.5, unit.AIThreadName)
	CreateProjectileFromUnit({ Name = "TyphonArmSlamNova", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.5, FalloffSpeed = 1400, Angle = 90 })
	CreateAnimation({ Name = "TyphonArmSlamImpactFx", DestinationId = unit.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/CorruptedCerberus/CerberusGroundSlam" })
	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonArm_SlamPostFire" })
	wait(0.25, unit.AIThreadName)

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonArm_Exit" })
	ApplyUpwardForce({ Id = unit.ObjectId, Speed = 2200 })
	SetAlpha({ Id = unit.ObjectId, Fraction = 0.0, Duration = 0.25 })
	wait(0.25, unit.AIThreadName)
	SetSoundCueValue({ Names = { "Bass" }, Id = AudioState.MusicId, Value = 0.0, Duration = 0.3 })
	if args.CameraMotion then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.5 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 2.5, ZoomType = "Ease" })
	end

	wait(3.0, unit.AIThreadName) -- Give the projectile time to finish so attacker is not nil
	Destroy({ Id = unit.ObjectId })
end

function TyphonIncursionArmFlick( eventSource, args )
	local delay = 0.0
	if args.DelayMin ~= nil and args.DelayMax ~= nil then
		delay = RandomFloat(args.DelayMin, args.DelayMax)
	end
	wait(delay, RoomThreadName)

	if CurrentRun.Hero.IsDead then
		return
	end

	SetSoundCueValue({ Names = { "Bass" }, Id = AudioState.MusicId, Value = 1.0, Duration = 0.3 })

	local unit = DeepCopyTable(EnemyData.TyphonArm_Incursion)
	local destinationId = args.DestinationId or GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetIds({ Name = args.SpawnGroup }) })
	local spawnOffsetX = -1200
	local spawnOffsetY = -750
	if CurrentRun.CurrentRoom.Flipped then
		spawnOffsetX = spawnOffsetX * -1
	end
	unit.ObjectId = SpawnUnit({ Name = "TyphonArm_Incursion", Group = "Standing", DestinationId = destinationId, OffsetX = spawnOffsetX, OffsetY = spawnOffsetY })
	SetupUnit(unit)
	SetUntargetable({ Id = unit.ObjectId })
	unit.AIThreadName = unit.ObjectId.."AIThread"
	SetAlpha({ Id = unit.ObjectId, Fraction = 0.0, Duration = 0.0 })

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonArm_FlickPreFire" })

	ShakeScreen({ Speed = 400, Distance = 8, FalloffSpeed = 1000, Duration = 1.0 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.1, Duration = 3.0, ZoomType = "Ease" })
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar" })

	wait(0.02, unit.AIThreadName)

	thread( PlayVoiceLines, HeroVoiceLines.TyphonIncursionVoiceLines, true )

	local moveOffsetX = -400
	local moveOffsetY = -250
	if CurrentRun.CurrentRoom.Flipped then
		moveOffsetX = moveOffsetX * -1
	end
	local moveToId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = destinationId, OffsetX = moveOffsetX, OffsetY = moveOffsetY })
	AngleTowardTarget({ Id = unit.ObjectId, DestinationId = destinationId })
	Move({ Id = unit.ObjectId, DestinationId = moveToId, Strafe = true })
	SetAlpha({ Id = unit.ObjectId, Fraction = 1.0, Duration = 0.5 })

	PanCamera({ Ids = { CurrentRun.Hero.ObjectId, unit.ObjectId }, Duration = 1.0 })

	wait(0.9, unit.AIThreadName)

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonArm_FlickFire" })

	wait(0.2, unit.AIThreadName)

	local angle = 325
	if CurrentRun.CurrentRoom.Flipped then
		angle = 215
	end
	CreateProjectileFromUnit({ Name = "TyphonArmFlickWave", Id = unit.ObjectId, DestinationId = unit.ObjectId, Angle = angle })

	wait(0.3, unit.AIThreadName)

	Halt({ Id = unit.ObjectId })
	Stop({ Id = unit.ObjectId })
	Destroy({ Id = moveToId })

	wait(0.6, unit.AIThreadName)

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.5 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 2.5, ZoomType = "Ease" })

	moveOffsetX = -1200
	moveOffsetY = -750
	if CurrentRun.CurrentRoom.Flipped then
		moveOffsetX = moveOffsetX * -1
	end
	moveToId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = destinationId, OffsetX = moveOffsetX, OffsetY = moveOffsetY })
	Move({ Id = unit.ObjectId, DestinationId = moveToId, Strafe = true })
	SetAlpha({ Id = unit.ObjectId, Fraction = 0.0, Duration = 0.5 })

	wait(0.2, unit.AIThreadName)
	SetSoundCueValue({ Names = { "Bass" }, Id = AudioState.MusicId, Value = 0.0, Duration = 0.3 })

	wait(3.0, unit.AIThreadName) -- Give the projectile time to finish so attacker is not nil

	Destroy({ Id = moveToId })
	Destroy({ Id = unit.ObjectId })
end

function TyphonIncursionTailImpale( eventSource, args )
	local delay = 0.0
	if args.DelayMin ~= nil and args.DelayMax ~= nil then
		delay = RandomFloat(args.DelayMin, args.DelayMax)
	end
	wait(delay, RoomThreadName)

	if CurrentRun.Hero.IsDead then
		return
	end

	SetSoundCueValue({ Names = { "Bass" }, Id = AudioState.MusicId, Value = 1.0, Duration = 0.3 })

	local unit = DeepCopyTable(EnemyData.TyphonTail_Incursion)
	local destinationId = args.DestinationId or GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetIds({ Name = args.SpawnGroup }) })
	unit.ObjectId = SpawnUnit({ Name = "TyphonTail_Incursion", Group = "Standing", DestinationId = destinationId })
	SetupUnit(unit)
	SetUntargetable({ Id = unit.ObjectId })
	unit.AIThreadName = unit.ObjectId.."AIThread"

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpalePreFire" })
	AdjustZLocation({ Id = unit.ObjectId, Distance = 2000 })
	IgnoreGravity({ Id = unit.ObjectId })

	ShakeScreen({ Speed = 400, Distance = 8, FalloffSpeed = 1000, Duration = 1.0 })
	if args.CameraMotion then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.1, Duration = 3.0, ZoomType = "Ease" })
	end
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar" })

	wait(0.02, unit.AIThreadName)

	thread( PlayVoiceLines, HeroVoiceLines.TyphonIncursionVoiceLines, true )

	if args.CameraMotion then
		PanCamera({ Ids = { CurrentRun.Hero.ObjectId, unit.ObjectId }, Duration = 1.0 })
	end
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "FallingShadowTyphonTail" })

	wait(0.75, unit.AIThreadName)

	ObeyGravity({ Id = unit.ObjectId })

	wait(0.25, unit.AIThreadName)

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpaleFireA" })
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusRockThrowWhoosh" })

	wait(0.2, unit.AIThreadName)

	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.3, FalloffSpeed = 1400, Angle = 90 })
	CreateProjectileFromUnit({ Name = "TyphonTailImpale", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "TyphonTailIncursionImpaleFx" })

	wait(0.55, unit.AIThreadName)

	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.3, FalloffSpeed = 1400, Angle = 90 })
	CreateProjectileFromUnit({ Name = "TyphonTailImpale", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	CreateProjectileFromUnit({ Name = "TyphonTailShockwave", Id = unit.ObjectId, DestinationId = unit.ObjectId })

	wait(0.2, unit.AIThreadName)

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpalePostFire" })

	wait(0.5, unit.AIThreadName)

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_FlyUp" })
	ApplyUpwardForce({ Id = unit.ObjectId, Speed = 2000 })
	SetSoundCueValue({ Names = { "Bass" }, Id = AudioState.MusicId, Value = 0.0, Duration = 0.3 })
	SetAlpha({ Id = unit.ObjectId, Fraction = 0.0, Duration = 0.75 })

	if args.CameraMotion then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.5 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 2.5, ZoomType = "Ease" })
	end

	wait(0.5, unit.AIThreadName)


	wait(4.0, unit.AIThreadName) -- Give the projectile time to finish so attacker is not nil

	Destroy({ Id = unit.ObjectId })
end

function BiomeQLeaveRoomPresentation( currentRun, exitDoor )

	local exitDoorId = exitDoor.ObjectId
	local door = MapState.OfferedExitDoors[exitDoorId]

	AddInputBlock({ Name = "BiomeQLeaveRoomPresentation" })
	
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "BiomeQLeaveRoomPresentation" )

	if door ~= nil then
		thread( DestroyDoorRewardPresenation, door )
		if door.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorOpenAnimation })
			ClearCameraClamp({ LerpTime = 0.0 })
			ZeroMouseTether( "BiomeQLeaveRoomPresentation" )
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
			PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 0.65, FromCurrentLocation = true, Retarget = true })
			wait( 0.7 )
		else
			-- consolidate and delete when we have an exit animation above
			ClearCameraClamp({ LerpTime = 0.0 })
			ZeroMouseTether( "BiomeQLeaveRoomPresentation" )
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
			PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 0.65, FromCurrentLocation = true, Retarget = true })
			wait( 0.7 )
		end
	end
	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = exitDoorId, DestinationIds = heroExitIds, Distance = 800 })
	if heroExitPointId > 0 then
		if not currentRun.CurrentRoom.BlockExitPan then
			local cameraPanId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -1000 })
			PanCamera({ Id = cameraPanId, Duration = 3.0, FromCurrentLocation = true, EaseIn = 0 })
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

	wait(0.1)

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	wait( 0.02 )

	FullScreenFadeOutAnimation( "RoomTransitionIn_Up" )

	PlaySound({ Name = "/Leftovers/SFX/FootstepsSequence" })

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "BiomeQLeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function BiomeQBossExitPresentation( currentRun, exitDoor )

	local exitDoorId = exitDoor.ObjectId
	local door = MapState.OfferedExitDoors[exitDoorId]

	AddInputBlock({ Name = "BiomeQBossExitPresentation" })
	
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "BiomeQBossExitPresentation" )

	LeaveRoomAudio( currentRun, exitDoor )
	if door ~= nil then
		thread( DestroyDoorRewardPresenation, door )
		if door.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorOpenAnimation })
		end
		ClearCameraClamp({ LerpTime = 6.0 })
		ZeroMouseTether( "BiomeQBossExitPresentation" )
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
		--PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 5.35, FromCurrentLocation = true, Retarget = true })

		local cameraPanId = RoomData[currentRun.CurrentRoom.Name].ExitPanId or 793953
		PanCamera({ Id = cameraPanId, Duration = 9.3, FromCurrentLocation = true, EaseIn = 0 })

		wait( 0.75 )
	end
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
		table.insert( exitPath, heroExitPointId )
		thread( MoveHeroAlongPath, exitPath, args )
	end

	if exitDoor.Room.ExitTowardsFunctionName ~= nil then
		CallFunctionName( exitDoor.Room.ExitTowardsFunctionName, exitDoor, exitDoor.Room.ExitTowardsFunctionArgs )
	end


	wait(0.1)

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	wait( 0.02 )

	FullScreenFadeOutAnimation( "RoomTransitionIn_Up" )

	PlaySound({ Name = "/Leftovers/SFX/FootstepsSequence" })

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "BiomeQBossExitPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )
end

function BiomeOverlookTyphon( room, args )
	if not MapState.InOverlook and IsEmpty(RequiredKillEnemies) then
		MapState.InOverlook = true

		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 0.5 })
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "Keys" }, Value = 0.0, Duration = 3.0 })
		SetVolume({ Id = AudioState.MusicId, Value = 0.7, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })
		SetAsNonGridManaged({ Id = 769563 })
		SetAlpha({ Ids = args.OverlookFadeIds, Fraction = 0.0, Duration = 1.5 })
		EndAutoSprint({ Halt = true, EndWeapon = true })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")
		ToggleCombatControl( CombatControlsDefaults, false, "Overlook" )

		thread( BiomeOverlookTyphonThread, room, args )

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

function BiomeOverlookTyphonThread( room, args )

	wait( 2.0 )
	AdjustRadialBlurDistance({ Fraction = 0.6, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.6, Duration = 0.2 })
	local totalTime = 2

	if GameState.RoomCountCache.Q_Intro == nil then
		args.MinAppearanceTime = args.FirstAppearanceTime
		args.AppearanceChancePerSecond = 1
	end

	CurrentRun.CurrentRoom.OverlookTyphonAppearance = CurrentRun.CurrentRoom.OverlookTyphonAppearance or false
	while MapState.InOverlook do
		ShakeScreen({ Speed = RandomInt(45, 55), Distance = 5, FalloffSpeed = 0, Angle = 220, Duration = 1 })
		if not CurrentRun.CurrentRoom.OverlookTyphonAppearance and totalTime >= (args.MinAppearanceTime or 8) and RandomChance( args.AppearanceChancePerSecond or 0.1 ) then
			CurrentRun.CurrentRoom.OverlookTyphonAppearance = true
			thread( BiomeOverlookTyphonCreature, room, args )
		end
		wait( 1, "BiomeOverlookTyphonThread" )
		totalTime = totalTime + 1
	end
end

function BiomeOverlookTyphonCreature( room, args )
	SetAnimation({ Name = "Enemy_TyphonTail_Overlook", DestinationId = args.TyphonCreatureId })
end

function BiomeBackToRoomTyphon( room, args )
	AdjustRadialBlurDistance({ Fraction = 0.0, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.0, Duration = 0.2 })
	killTaggedThreads( "BiomeOverlookTyphonThread" )
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

		SetAlpha({ Ids = args.OverlookFadeIds, Fraction = 1.0, Duration = 3.0 })

		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 0.0, Duration = 0.5 })
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "Keys" }, Value = 1.0, Duration = 1.5 })
		SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 1.5 })
		thread( PlayVoiceLines, HeroVoiceLines.OverlookLeaveVoiceLines )
		ClearCameraFocusOverride()
		ShowCombatUI()

		SetThreadWait( "OverlookThread", 0.01 )
	end
end

function RoomEntranceTyphonHead( currentRun, currentRoom, args )
	args = args or {}

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter

	ClearCameraClamp({ LerpTime = 0 })
	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	wait(0.03)

	Teleport({ Id = args.TyphonId, DestinationId = args.TyphonId, OffsetX = 0, OffsetY = -500 })
	local moveTarget = SpawnObstacle({ DestinationId = args.TyphonId, OffsetY = 650, Name = "InvisibleTarget" })
	SetColor({ Id = args.TyphonId, Color = Color.Black, Duration = 0.0 })
	SetAlpha({ Id = args.TyphonId, Fraction = 0, Duration = 0 })
	AngleTowardTarget({ Id = args.TyphonId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ DestinationId = args.TyphonId, Name = args.TyphonStartAnimation })
	UseableOff({ Id = 768210 }) -- Exit door

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	if currentRoom.EnterSound ~= nil then
		PlaySound({ Name = currentRoom.EnterSound, Id = currentRoom.HeroStartPoint })
	end
	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, AngleTowardsIdOnEnd = args.AngleTowardsIdOnEnd } )
	end
	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomData.IntroCameraPanDuration or roomIntroSequenceDuration, EaseIn = 0.01, })
	end

	thread( PlayVoiceLines, encounterData.PreFightVoiceLines, true )

	wait(2.5)

	SetAnimation({ DestinationId = args.TyphonId, Name = args.TyphonIntroAnimation })
	SetColor({ Id = args.TyphonId, Color = Color.White, Duration = 1.0, EaseOut = 0.5 })
	SetAlpha({ Id = args.TyphonId, Fraction = 1.0, Duration = 0.25 })
	Move({ Id = args.TyphonId, DestinationId = moveTarget, OffsetX = 0, OffsetY = -500, SuccessDistance = 50, Strafe = true })

	wait(0.5)

	MusicPlayer( "/Music/IrisMusicTyphon2_MC" )

	SetAlpha({ Ids = GetIds({ Name = "StartFX" }), Fraction = 0.0, Duration = 1.0 })

	wait(0.5)

	local typhon = ActiveEnemies[args.TyphonId]

	CreateBossHealthBar( typhon )

	wait(1.0)
	SetAlpha({ Ids = GetIds({ Name = "BehindStorm" }), Fraction = 1.0, Duration = 1.0 })

	SetAnimation({ DestinationId = args.TyphonId, Name = "Enemy_TyphonHead_Intro_Roar_Start" })

	thread( PlayVoiceLines, encounterData.PreRoarVoiceLines, true )

	wait( 1 )

	thread( TyphonHeadHealthBarPresentation, typhon, args )
	PlaySound({ Name = args.TyphonIntroSound, Id = args.TyphonId })
	ShakeScreen({ Angle = 90, Distance = 6, Speed = 300, FalloffSpeed = 300, Duration = 1.5 })
	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.2 })

	wait( 1.4 )

	thread( PlayVoiceLines, encounterData.FightStartVoiceLines, true )

	wait( args.TyphonIntroDelay or 0 )

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1.0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1.0 })

	local firstTimeBonusWait = 0
	if currentRoom.FirstTimeBonusWait ~= nil and GameState.RoomCountCache[currentRoom.Name] == nil then
		firstTimeBonusWait = currentRoom.FirstTimeBonusWait
	end
	wait( firstTimeBonusWait or 0 )

	if not roomData.IgnoreClamps then
		local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
		DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })
		SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	end

	Destroy({ Id = moveTarget })

	--wait( roomIntroSequenceDuration )
	--LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnblockCombatUI("BossEntrance")
end

function RoomEntranceTyphonHeadEM( currentRun, currentRoom, args )

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		FadeIn({ Duration = 0.0 })
		FullScreenFadeInAnimation()
		return
	end

	ClearCameraClamp({ LerpTime = 0 })
	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = roomData.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	wait(0.03)

	Teleport({ Id = args.TyphonId, DestinationId = 800464, OffsetX = 0, OffsetY = -500 })
	local moveTarget = SpawnObstacle({ DestinationId = args.TyphonId, OffsetY = 650, Name = "InvisibleTarget" })
	SetColor({ Id = args.TyphonId, Color = Color.Black, Duration = 0.0 })
	SetAlpha({ Id = args.TyphonId, Fraction = 0, Duration = 0 })
	AngleTowardTarget({ Id = args.TyphonId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ DestinationId = args.TyphonId, Name = args.TyphonStartAnimation })
	UseableOff({ Id = 768210 }) -- Exit door

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	if currentRoom.EnterSound ~= nil then
		PlaySound({ Name = currentRoom.EnterSound, Id = currentRoom.HeroStartPoint })
	end
	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, AngleTowardsIdOnEnd = args.AngleTowardsIdOnEnd } )
	end

	-- CHRONOS INTRO
	SetAlpha({ Id = args.ChronosId, Fraction = 0, Duration = 0 })

	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomData.IntroCameraPanDuration or roomIntroSequenceDuration, EaseIn = 0.01, })
	end


	wait(1.5)
	MusicPlayer( "/Music/ChronosBossFightMusic" )
	SetMusicSection( 8, MusicId )

	SetAlpha({ Id = args.ChronosId, Fraction = 1, Duration = 0.3 })
	CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = args.ChronosId })

	wait(0.3)

	local chronos = ActiveEnemies[args.ChronosId]
	thread( PlayVoiceLines, chronos.PreFightVoiceLines, true )

	wait(2.2)

	local typhon = ActiveEnemies[args.TyphonId]
	local textLines = GetRandomEligibleTextLines( typhon, typhon.BossIntroTextLineSets, GetNarrativeDataValue( typhon, "BossIntroTextLinePriorities" ) )
	PlayTextLines( typhon, textLines )

	-- CHRONOS OUT
	CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = args.ChronosId })
	SetAlpha({ Id = args.ChronosId, Fraction = 0, Duration = 0.5 })
	SetAnimation({ DestinationId = args.ChronosId, Name = "Enemy_Chronos_TeleportDashOut" })

	PanCamera({ Id = args.TyphonIntroPanId, Duration = 4.0, EaseIn = 0.01, })
	wait( 0.5 )

	thread( PlayVoiceLines, chronos.FightStartVoiceLines, true )

	wait(1.0)

	SetAnimation({ DestinationId = args.TyphonId, Name = args.TyphonIntroAnimation })
	SetColor({ Id = args.TyphonId, Color = Color.White, Duration = 1.0, EaseOut = 0.5 })
	SetAlpha({ Id = args.TyphonId, Fraction = 1.0, Duration = 0.25 })
	Move({ Id = args.TyphonId, DestinationId = moveTarget, OffsetX = 0, OffsetY = -500, SuccessDistance = 50, Strafe = true })

	wait(0.5)

	MusicPlayer( "/Music/IrisMusicTyphon2EM" )

	SetAlpha({ Ids = GetIds({ Name = "StartFX" }), Fraction = 0.0, Duration = 1.0 })

	wait(0.5)

	local typhon = ActiveEnemies[args.TyphonId]

	CreateBossHealthBar( typhon )

	wait(1.0)
	SetAlpha({ Ids = GetIds({ Name = "BehindStorm" }), Fraction = 1.0, Duration = 1.0 })

	SetAnimation({ DestinationId = args.TyphonId, Name = "Enemy_TyphonHead_Intro_Roar_Start" })

	thread( PlayVoiceLines, encounterData.PreRoarVoiceLines, true )

	wait( 1 )

	thread( TyphonHeadHealthBarPresentation, typhon, args )
	PlaySound({ Name = args.TyphonIntroSound, Id = args.TyphonId })
	ShakeScreen({ Angle = 90, Distance = 6, Speed = 300, FalloffSpeed = 300, Duration = 1.5 })
	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.2 })

	wait( 1.4 )

	thread( PlayVoiceLines, encounterData.FightStartVoiceLines, true )

	wait( args.TyphonIntroDelay or 0 )

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1.0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1.0 })

	local firstTimeBonusWait = 0
	if currentRoom.FirstTimeBonusWait ~= nil and GameState.RoomCountCache[currentRoom.Name] == nil then
		firstTimeBonusWait = currentRoom.FirstTimeBonusWait
	end
	wait( firstTimeBonusWait or 0 )

	if not roomData.IgnoreClamps then
		local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
		DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })
		SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	end

	Destroy({ Id = moveTarget })

	--wait( roomIntroSequenceDuration )
	--LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnblockCombatUI("BossEntrance")
end

function TyphonHeadHealthBarPresentation( typhon, args )

	local bossBarId = EnemyHealthDisplayAnchors[args.TyphonId]
	local bossBarBack = EnemyHealthDisplayAnchors[args.TyphonId.."back"]
	local bossBarfalloffId = EnemyHealthDisplayAnchors[args.TyphonId.."falloff"]
	local bossBarscorchId = typhon.ScorchHealthBarId
	Destroy({ Ids = {bossBarfalloffId, bossBarscorchId} })
	typhon.ScorchHealthBarId = nil

	wait( 0.4 )

	CreateAnimation({ DestinationId = bossBarBack, Name = "TyphonHeadHealthBarShatter", })
	SetAnimation({ DestinationId = bossBarBack, Name = "Blank", })
	Destroy({ Id = bossBarId })

	wait( 0.3 )
	ModifyTextBox({ Id = bossBarBack, ColorTarget = Color.Red, ColorDuration = 1.0 })
	wait( 0.8 )

	ModifyTextBox({ Id = bossBarBack, ScaleTarget = 1.3, ScaleDuration = 0.6, ColorTarget = Color.Transparent, ColorDuration = 0.6 })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesLocationTextDisappear", Id = bossBarBack })

	wait( 0.2 )

	CreateAnimation({ DestinationId = bossBarBack, Name = "TyphonHeadHealthBarShatterFlare", Group = "Combat_Menu_Additive" })
	CreateAnimation({ DestinationId = bossBarBack, Name = "TyphonHeadHealthBarShatterGlow", Group = "Combat_Menu_Additive" })
	CreateAnimation({ DestinationId = bossBarBack, Name = "TyphonHeadHealthBarShatterGlow2", Group = "Combat_Menu_Additive" })

	DestroyTextBox({ Id = bossBarBack })
	Destroy({ Id = bossBarBack })
	ScreenAnchors.BossHealthTitles[ args.TyphonId ] = nil
	ScreenAnchors.BossHealthBack = nil
	ScreenAnchors.BossHealthFill = nil
	EnemyHealthDisplayAnchors[args.TyphonId] = nil
	EnemyHealthDisplayAnchors[args.TyphonId.."back"] = nil

end

function TyphonSpeakingPresentation( source, args )
	args = args or {}
	while true do
		ShakeScreen({ Angle = 90, Distance = 6, Speed = 400, FalloffSpeed = 300, Duration = 1.5 })
		AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.2 })
		AdjustRadialBlurStrength({ Fraction = 0.75, Duration = 0.2 })
		CreateAnimation({ Name = "TyphonSpeakingFxSpawner", DestinationId = 768121 })
		wait( 2.0, "TyphonSpeakingPresentation" )
	end
end

function TyphonSpeakingEndPresentation( source, args )
	args = args or {}
	killTaggedThreads( "TyphonSpeakingPresentation" )
	AdjustRadialBlurDistance({ Fraction = 0.0, Duration = 0.3 })
	AdjustRadialBlurStrength({ Fraction = 0.0, Duration = 0.3 })
end

function AttackTyphonHint( source, args )
	killTaggedThreads( CombatUI.HideThreadName )
	local notifyName = "AttackTyphonHint"
	NotifyOnControlPressed({ Names = { "Shout", "Attack1", "Attack2", "Attack3", }, Notify = notifyName, Timeout = args.Delay })
	waitUntil( notifyName )
	if _eventTimeoutRecord[notifyName] then

		local voiceLines =
		{
			Queue = "Always",
			PlayOnce = true,
			PreLineWait = 0.85,
			UsePlayerSource = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "EnemyKills", "TyphonHead" },
				},
			},
			{ Cue = "/VO/MelinoeField_3347", Text = "What am I doing... I have to fight!" },
		}
		thread( PlayVoiceLines, voiceLines )
	end
end

function TyphonHeadStageTransition( typhon, args )
	args = args or {}
	SessionMapState.ElapsedTimeMultiplierIgnores[typhon.AIThreadName] = true
	Stop({ Id = typhon.ObjectId })
	SetGoalAngle({ Id = typhon.ObjectId, Angle = 265 })
	SetUnitInvulnerable( typhon, "TyphonHeadStageTransition" )

	killTaggedThreads( "TyphonHeadWeaponCameraThread" )
	LockCamera({ Ids = heroId, Duration = 0.0, Retarget = true })
	wait( 0.01, typhon.AIThreadName )

	AddInputBlock({ Name = "TyphonHeadStageTransition" })
	wait( 0.1, typhon.AIThreadName )
	SetPlayerInvulnerable( "TyphonHeadStageTransition" )
	AddPlayerImmuneToForce( "TyphonHeadStageTransition" )
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, All = true, })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeIdle" })
	SessionMapState.TyphonStaggerPresentation = true
	wait( 0.1, typhon.AIThreadName )

	thread( MoveHeroToRoomPosition, { SkipInputBlock = true, DestinationId = 50065, AngleTowardsIdOnEnd = typhon.ObjectId, Timeout = 9.0 } )

	-- zoom away / lock on position
	args.CameraLockId = 779846

	LockCameraMotion( "TyphonHeadStageTransition" )
	LockCamera({ Id = args.CameraLockId, Duration = 5.0 })
	FocusCamera({ Fraction = 0.5, Duration = 3.0, ZoomType = "Ease" })
	ZeroMouseTether( "TyphonHeadStageTransition" )

	-- hide hud
	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen, nil, { IgnoreHUDShow = true } )
	end
	HideCombatUI( "TyphonHeadStageTransition" )

	DestroyRequiredKills( { BlockLoot = true, SkipIds = { typhon.ObjectId } } )
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	ClearEnemySeekStatus( typhon )

	local godSpawnId = 779826
	local zeus = DeepCopyTable( EnemyData.NPC_Zeus_01 )

	-- begin overlay presentation
	AdjustColorGrading({ Name = "Gold", Duration = 2.5 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedLuciferChoir", Delay = 0.35 })
	AdjustFullscreenBloom({ Name = "AthenaDivineInterventionBloom", Duration = 2.5 })
	AdjustRadialBlurDistance({ Fraction = 0.5, Duration = 2.0 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 2.0 })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.75 })

	SetAnimation({ Name = "Enemy_TyphonHead_RoarFire", DestinationId = typhon.ObjectId })

	wait( 0.5, typhon.AIThreadName )

	SetVolume({ Id = AudioState.MusicId, Value = 0.5, Duration = 1.0 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	AudioState.OlympianSoundId = PlaySound({ Name = "/SFX/WrathPersistentLoop" })
	StopSound({ Id = AudioState.OlympianSoundId, Duration = 10 })
	AudioState.OlympianSoundId = nil

	-- setup olympian
	zeus.ObjectId = SpawnUnit({ Name = "NPC_Zeus_01", Group = "Standing", DestinationId = godSpawnId })
	SetupUnit( zeus, CurrentRun, { IgnoreAI = true, IgnorePackages = true, } )
	SetAlpha({ Id = zeus.ObjectId, Fraction = 0, Duration = 0.0 })
	SetScale({ Id = zeus.ObjectId, Fraction = 7, Duration = 0.0 })
	SetUnitProperty({ DestinationId = zeus.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = zeus.ObjectId, Property = "CollideWithUnits", Value = false })
	AngleTowardTarget({ Id = zeus.ObjectId, DestinationId = typhon.ObjectId })

	wait( 0.5, typhon.AIThreadName )

	-- make visible
	SetAnimation({ DestinationId = zeus.ObjectId, Name = zeus.TyphonAttackEnterAnimation, })
	SetAlpha({ Id = zeus.ObjectId, Fraction = 1, Duration = 0.4 })

	RemoveFromGroup({ Id = zeus.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = zeus.ObjectId, Name = "Combat_Menu_TraitTray_Overlay_Text", DrawGroup = true })

	wait( 0.8, typhon.AIThreadName )

	thread( PlayVoiceLines, zeus.TyphonAttackArrivalLines, true )

	wait( 2.15, typhon.AIThreadName )

	thread( PlayVoiceLines, HeroVoiceLines.OlympianArrivalVoiceLines, true )

	PlaySound({ Name = "/SFX/Player Sounds/ZeusEchoPrefire" })
	PlaySound({ Name = "/SFX/Player Sounds/ZeusLightningImpact" })
	wait( 0.5, typhon.AIThreadName )

	-- fire a bunch of projectiles on Typhon
	PlaySound({ Name = "/SFX/Player Sounds/MeteorTraitImpact" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3Distance" })

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.38, Duration = 1.75 }, } )
	ShakeScreen({ Speed = 500, Distance = 6, FalloffSpeed = 1000, Duration = 1.75 })
	thread( TyphonHeadStageTransitionOlympianEffects, typhon, args )

	wait( 1.5, typhon.AIThreadName )

	-- play stun animation and update damage texture for Typhon
	SetAnimation({ Name = "Enemy_TyphonHead_StunnedStart", DestinationId = typhon.ObjectId })
	SetThingProperty({ Property = "GrannyTexture", Value = "GR2/TyphonHeadStage2_Color", DestinationId = typhon.ObjectId })

	wait( 0.75, typhon.AIThreadName )

	thread( PlayVoiceLines, HeroVoiceLines.TyphonKnockdownVoiceLines, true )

	wait( 0.75, typhon.AIThreadName )

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.25 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.25 })
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })

	SetVolume({ Id = AudioState.MusicId, Value = 1.0, Duration = 2.0 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 1 })

	-- move olympian out of scene
	SetAnimation({ DestinationId = zeus.ObjectId, Name = zeus.TyphonAttackExitAnimation, })

	wait( 0.9, typhon.AIThreadName )

	SetAlpha({ Id = zeus.ObjectId, Fraction = 0, Duration = 0.25 })

	wait( 0.3, typhon.AIThreadName )

	-- restore anything hidden / locked
	ShowCombatUI( "TyphonHeadStageTransition" )
	UnlockCameraMotion("TyphonHeadStageTransition")
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1.25, ZoomType = "Ease" })
	UnzeroMouseTether( "TyphonHeadStageTransition" )
	RemoveInputBlock({ Name = "TyphonHeadStageTransition" })
	SetPlayerVulnerable( "TyphonHeadStageTransition" )
	RemovePlayerImmuneToForce( "TyphonHeadStageTransition" )
	SessionMapState.TyphonStaggerPresentation = nil
	
	-- Restore Winter Coat if somehow player got here without popping it
	if HeroHasTrait("ReserveManaHitShieldBoon") then
		local trait = GetHeroTrait("ReserveManaHitShieldBoon")
		if not trait.HasTriggered then
			CallFunctionName(trait.SetupFunction.Name, CurrentRun.Hero, trait.SetupFunction.Args)
		end
	end
	CreateAnimation({ Name = "TyphonHeadStunnedTongueAttractIn", DestinationId = typhon.ObjectId, Group = "FX_Standing_Add" })
	--Spawn Dummy unit
	local dummy = DeepCopyTable(EnemyData.TyphonHeadStaggeredDummy)
	dummy.ObjectId = SpawnUnit({ Name = "TyphonHeadStaggeredDummy", DestinationId = typhon.ObjectId, Group = "Standing" })
	dummy.DamageSurrogate = typhon
	SetupUnit(dummy)
	SetAngle({ Id = dummy.ObjectId, Angle = GetAngle({ Id = typhon.ObjectId }) })

	SetUnitProperty({ DestinationId = typhon.ObjectId, Property = "ImmuneToStun", Value = false })
	SetUnitVulnerable( typhon, "TyphonHeadStageTransition" )
	typhon.ImpactLocationOffsetZ = -920 -- Hit fx offset
	typhon.HealthBarOffsetY = 575 -- Damage numbers offset

	local stunnedImpassabilityIds = GetInactiveIds({ Name = "StunnedImpassability" })
	Activate({ Ids = stunnedImpassabilityIds })

	-- destroy olympian
	Destroy({ Id = zeus.ObjectId })

	-- flag for VO and events
	GameState.OlympianFinalBattleAssists = (GameState.OlympianFinalBattleAssists or 0) + 1
	
	SessionMapState.ElapsedTimeMultiplierIgnores[typhon.AIThreadName] = nil
	wait( 6, typhon.AIThreadName )

	if typhon.ReachedAIStageEnd then
		CurrentRun.CurrentRoom.TyphonHighDamagePhaseSkip = true
		thread( PlayVoiceLines, HeroVoiceLines.TyphonPhaseSkipReactionVoiceLines )
	end
	
	thread( PlayVoiceLines, GlobalVoiceLines.TyphonEnragedVoiceLines )

	Destroy({ Ids = stunnedImpassabilityIds })
	SetAnimation({ Name = "Enemy_TyphonHead_StunnedEnd", DestinationId = typhon.ObjectId })
	StopAnimation({ Name = "TyphonHeadStunnedTongueAttract", DestinationId = typhon.ObjectId })
	SetUnitProperty({ DestinationId = typhon.ObjectId, Property = "ImmuneToStun", Value = true })
	typhon.HealthBarOffsetY = 150
	typhon.ImpactLocationOffsetZ = 0
	Kill(dummy)
	wait( 1, typhon.AIThreadName )
end

function TyphonHeadStageTransitionEM( typhon, args )
	args = args or {}

	-- Disable Chronos
	local chronosId = 793226
	local chronos = ActiveEnemies[chronosId]

	killTaggedThreads(chronos.AIThreadName)
	chronos.AIBehavior = nil
	chronos.ChainedWeapon = nil
	chronos.ChainedWeaponOptions = nil
	chronos.ForcedWeaponInterrupt = true
	SetAlpha({ Id = chronosId, Fraction = 0, Duration = 0.0 })

	Stop({ Id = typhon.ObjectId })
	SetGoalAngle({ Id = typhon.ObjectId, Angle = 265 })
	SetUnitInvulnerable( typhon, "TyphonHeadStageTransition" )

	killTaggedThreads( "TyphonHeadWeaponCameraThread" )
	LockCamera({ Ids = heroId, Duration = 0.0, Retarget = true })
	wait( 0.01, typhon.AIThreadName )

	AddInputBlock({ Name = "TyphonHeadStageTransition" })
	wait( 0.1, typhon.AIThreadName )
	SetPlayerInvulnerable( "TyphonHeadStageTransition" )
	AddPlayerImmuneToForce( "TyphonHeadStageTransition" )
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, All = true, })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeIdle" })
	SessionMapState.TyphonStaggerPresentation = true
	wait( 0.1, typhon.AIThreadName )

	thread( MoveHeroToRoomPosition, { SkipInputBlock = true, DestinationId = 50065, AngleTowardsIdOnEnd = typhon.ObjectId, Timeout = 9.0 } )

	-- zoom away / lock on position
	args.CameraLockId = 779846

	LockCameraMotion( "TyphonHeadStageTransition" )
	LockCamera({ Id = args.CameraLockId, Duration = 5.0 })
	FocusCamera({ Fraction = 0.5, Duration = 3.0, ZoomType = "Ease" })
	ZeroMouseTether( "TyphonHeadStageTransition" )

	-- hide hud
	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen, nil, { IgnoreHUDShow = true } )
	end
	HideCombatUI( "TyphonHeadStageTransition" )

	DestroyRequiredKills( { BlockLoot = true, SkipIds = { typhon.ObjectId } } )
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	ExpireProjectiles({ Names = { "ChronosRipple", "ChronosRushRipple", "ChronosGrindVacuum", "ChronosGrindWall" }, BlockSpawns = true })
	killTaggedThreads("TyphonHeadIncursionThread")
	if typhon.IncursionUnitId ~= nil and ActiveEnemies[typhon.IncursionUnitId] ~= nil and IsAlive({ Id = typhon.IncursionUnitId }) then
		if ActiveEnemies[typhon.IncursionUnitId].ExitAnimation ~= nil then
			SetAnimation({ DestinationId = typhon.IncursionUnitId, Name = ActiveEnemies[typhon.IncursionUnitId].ExitAnimation })
		end
		ExpireProjectiles({ Names = { "TyphonArmSlamNova", "TyphonArmFlickWave", "TyphonTailImpale", "TyphonTailShockwave" } })
		ApplyUpwardForce({ Id = typhon.IncursionUnitId, Speed = 2000, SelfApplied = true })
		IgnoreGravity({ Id = typhon.IncursionUnitId })
		SetAlpha({ Id = typhon.IncursionUnitId, Fraction = 0.0, Duration = 0.5 })
		thread(DestroyOnDelay, { typhon.IncursionUnitId }, 0.5 )
	end
	ClearEnemySeekStatus( typhon )

	-- begin overlay presentation
	--PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedLuciferChoir", Delay = 0.35 })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.75 })

	SetAnimation({ Name = "Enemy_TyphonHead_RoarFire", DestinationId = typhon.ObjectId })

	wait( 0.5, typhon.AIThreadName )

	SetVolume({ Id = AudioState.MusicId, Value = 0.5, Duration = 1.0 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	AudioState.OlympianSoundId = PlaySound({ Name = "/SFX/WrathPersistentLoop" })
	StopSound({ Id = AudioState.OlympianSoundId, Duration = 10 })
	AudioState.OlympianSoundId = nil

	SetAnimation({ Name = "Enemy_TyphonHead_Laugh", DestinationId = typhon.ObjectId })

	-- setup chronos
	Stop({ Id = chronos.ObjectId })
	Teleport({ Id = chronos.ObjectId, DestinationId = 779826 })
	SetScale({ Id = chronos.ObjectId, Fraction = 4, Duration = 0.0 })
	SetUnitProperty({ DestinationId = chronos.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = chronos.ObjectId, Property = "CollideWithUnits", Value = false })
	SetGoalAngle({ Id = chronos.ObjectId, Angle = 135 })
	RemoveFromGroup({ Id = chronos.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = chronos.ObjectId, Name = "Combat_Menu_TraitTray_Overlay_Text", DrawGroup = true })
	AdjustZLocation({ Id = chronos.ObjectId, Distance = 500 - GetZLocation({ Id = chronos.ObjectId }), Duration = 0 })
	IgnoreGravity({ Id = chronos.ObjectId })

	wait( 3.0, typhon.AIThreadName )

	-- make chronos visible
	PlaySound({ Name = "/SFX/Enemy Sounds/Chronos/ChronosClockHand", Id = chronos.ObjectId })
	SetAlpha({ Id = chronos.ObjectId, Fraction = 1, Duration = 0.1 })
	SetAnimation({ DestinationId = chronos.ObjectId, Name = "Enemy_Chronos_TeleportDashIn" })
	CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = chronos.ObjectId })

	wait( 0.3, typhon.AIThreadName )
	thread( PlayVoiceLines, GlobalVoiceLines.SkipZeusVoiceLines, nil, chronos )

	-- restore anything hidden / locked
	ShowCombatUI( "TyphonHeadStageTransition" )
	RemoveInputBlock({ Name = "TyphonHeadStageTransition" })
	SetUnitVulnerable( typhon, "TyphonHeadStageTransition" )
	SetPlayerVulnerable( "TyphonHeadStageTransition" )
	RemovePlayerImmuneToForce( "TyphonHeadStageTransition" )
	SessionMapState.TyphonStaggerPresentation = nil

	thread(EndChronosScreenBlock, typhon, chronos)

	-- Restore Winter Coat if somehow player got here without popping it
	if HeroHasTrait("ReserveManaHitShieldBoon") then
		local trait = GetHeroTrait("ReserveManaHitShieldBoon")
		if not trait.HasTriggered then
			CallFunctionName(trait.SetupFunction.Name, CurrentRun.Hero, trait.SetupFunction.Args)
		end
	end
end

function EndChronosScreenBlock(typhon, chronos)

	SetAnimation({ DestinationId = chronos.ObjectId, Name = "Enemy_Chronos_Annoying_Start" })

	-- Chronos troll duration
	wait( 5.0, typhon.AIThreadName )

	-- make Chronos invisible
	SetAnimation({ DestinationId = chronos.ObjectId, Name = "Enemy_Chronos_TeleportDashOut" })
	CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = chronos.ObjectId })

	wait( 0.3, typhon.AIThreadName )

	SetAlpha({ Id = chronos.ObjectId, Fraction = 0, Duration = 0.1 })

	wait( 0.5, typhon.AIThreadName)

	SetVolume({ Id = AudioState.MusicId, Value = 1.0, Duration = 2.0 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 1 })

	AdjustZLocation({ Id = chronos.ObjectId, Distance = 0 - GetZLocation({ Id = chronos.ObjectId }), Duration = 0 })
	ObeyGravity({ Id = chronos.ObjectId })
	SetScale({ Id = chronos.ObjectId, Fraction = 1, Duration = 0.0 })
	SetUnitProperty({ DestinationId = chronos.ObjectId, Property = "CollideWithObstacles", Value = true })
	SetUnitProperty({ DestinationId = chronos.ObjectId, Property = "CollideWithUnits", Value = true })
	AddToGroup({ Id = chronos.ObjectId, Name = "Standing", DrawGroup = true })
	RemoveFromGroup({ Id = chronos.ObjectId, Name = "Combat_Menu_TraitTray_Overlay_Text", DrawGroup = true })

	UnlockCameraMotion("TyphonHeadStageTransition")
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1.25, ZoomType = "Ease" })
	UnzeroMouseTether( "TyphonHeadStageTransition" )

	-- Enable Chronos
	SetupAI(chronos)
end

function TyphonChronosStageTransition( typhon, args )
	local chronosId = 793226
	local chronos = ActiveEnemies[chronosId]

	killTaggedThreads(chronos.AIThreadName)
	chronos.AIBehavior = nil
	chronos.ChainedWeapon = nil
	chronos.ChainedWeaponOptions = nil
	chronos.ForcedWeaponInterrupt = nil

	ExpireProjectiles({ Names = { "ChronosRipple", "ChronosRushRipple", "ChronosGrindVacuum", "ChronosGrindWall" }, BlockSpawns = true })
	SetThreadWait(chronos.AIThreadName.."Fuse", 0.01)

	CreateAnimation({ DestinationId = chronosId, Name = "ChronosTeleportFxFront" })
	SetAnimation({ DestinationId = chronosId, Name = "Enemy_Chronos_TeleportDashOut" })
	wait(0.3)

	chronos.ForcedWeaponInterrupt = args.ChronosWeapon
	SetupAI(chronos)
end

function TyphonHeadStageTransitionOlympianEffects( source, args )
	local olympianTargetIds = GetIds({ Name = "OlympianTargets" })
	local olympianVfx =
	{
		"ZeusLightningIris",
	}

	PlaySound({ Name = "/SFX/ZeusWrathThunder", Id = currentTargetId })
	local duration = 3
	local vfxDelay = 0.05
	for i = 1, (duration / vfxDelay) do
		local currentTargetId = GetRandomValue( olympianTargetIds )
		local currentVfx = GetRandomValue( olympianVfx )
		CreateAnimation({ Name = currentVfx, DestinationId = currentTargetId })
		PlaySound({ Name = "/SFX/Player Sounds/ZeusLightningImpact", Id = currentTargetId })
		wait( vfxDelay )
	end
end

function TyphonTailAmbushSetup( source, args )
	SetAnimation({ DestinationId = 768130, Name = "Enemy_TyphonTail_Hidden" })
end

function TyphonHeadVolleyPresentation(typhon, args)

	LockCameraMotion("Typhon")
	local heroId = CurrentRun.Hero.ObjectId
	PanCamera({ Ids = { heroId, typhon.ObjectId }, Duration = 1.5 })
	AdjustZoom({ Fraction = 0.5, LerpTime = 1.5  })
	wait(3.0, "TyphonHeadWeaponCameraThread" )
	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.0  })
	LockCamera({ Ids = heroId, Duration = 1.0 })
	UnlockCameraMotion("Typhon")
end

function TyphonHeadCannonPresentation(typhon, args)

	LockCameraMotion("Typhon")
	local heroId = CurrentRun.Hero.ObjectId
	LockCamera({ Ids = { heroId, typhon.ObjectId }, Duration = 1.75, OffsetY = -210, FromCurrentLocation = true })
	AdjustZoom({ Fraction = 0.65, LerpTime = 1.75  })
	wait(2.0, "TyphonHeadWeaponCameraThread" )
	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.2  })
	LockCamera({ Id = heroId, Duration = 1.2, EaseIn = 0.99, FromCurrentLocation = true })
	wait(1.25, "TyphonHeadWeaponCameraThread" )
	UnlockCameraMotion("Typhon")
end

function TyphonHeadSummonPresentation(typhon, aiData, currentRun, args)

	LockCameraMotion("Typhon")
	local heroId = CurrentRun.Hero.ObjectId
	PanCamera({ Ids = { heroId, typhon.ObjectId }, Duration = 1.5 })
	AdjustZoom({ Fraction = 0.65, LerpTime = 1.5  })

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3Distance" })
	PlaySound({ Name = "/SFX/Enemy Sounds/Typhon/EmotePowerCharging", Id = typhon.ObjectId })

	-- used for VO
	CurrentRun.CurrentRoom.TyphonHiding = true
	SetUnitInvulnerable( typhon, "TyphonHeadSummonPresentation" )

	wait(1.5, "TyphonHeadWeaponCameraThread" )

	thread( PlayVoiceLines, HeroVoiceLines.TyphonRetreatReactionVoiceLines )

	local hidingFxIds = CombineTables(GetInactiveIds({ Name = "HidingFX" }), GetIds({ Name = "HidingFX" }))
	Activate({ Ids = hidingFxIds })
	SetAlpha({ Ids = hidingFxIds, Fraction = 0, Duration = 0.0 })
	SetAlpha({ Ids = hidingFxIds, Fraction = 1, Duration = 3.0 })

	wait(1.5, "TyphonHeadWeaponCameraThread" )

	SetCameraClamp({ Ids = { 779909, 779905, 779906, 779907, 779908, 779846, } })
	LockCamera({ Ids = heroId, Duration = 1.5 })
	AdjustZoom({ Fraction = 0.75, LerpTime = 1.5  })

	if CoinFlip() then
		thread( TyphonHeadTailWeapon, typhon, args )
	else
		thread( TyphonHeadArmWeapon, typhon, args )
	end

	if TableLength(RequiredKillEnemies) > 1 or not IsEmpty( SessionMapState.ProjectilesCarryingSpawns ) then
		thread( TyphonHeadSummonPresentationEarlyEnd, typhon, aiData )
		wait( aiData.PostAttackDuration or 15.0, "TyphonHeadWeaponCameraThread" )
		killTaggedThreads("TyphonHeadSummonPresentationEarlyEnd")
	else
		SetThreadWait(typhon.AIThreadName, 0.01)
	end

	wait(2.0, "TyphonHeadWeaponCameraThread" )

	if args.NewGrannyTexture ~= nil then
		SetThingProperty({ Property = "GrannyTexture", Value = args.NewGrannyTexture, DestinationId = typhon.ObjectId })
	end

	SetAlpha({ Ids = hidingFxIds, Fraction = 0, Duration = 0.75 })
	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.5  })
	PanCamera({ Ids = { heroId, typhon.ObjectId }, OffsetY = -170, EaseOut = 0.9, Duration = 1.95 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	CurrentRun.CurrentRoom.TyphonHiding = false

	wait(2.0, "TyphonHeadWeaponCameraThread" )

	thread( PlayVoiceLines, HeroVoiceLines.TyphonInjuredReactionVoiceLines )

	LockCamera({ Ids = heroId, Duration = 1.5 })
	SetCameraClamp({ Ids = {  768528, 768529, 768530, 50061, 50062, 768526, 768527, } })
	SetUnitVulnerable( typhon, "TyphonHeadSummonPresentation" )

	UnlockCameraMotion("Typhon")
end

function TyphonHeadSummonPresentationEarlyEnd(typhon, aiData)

	while TableLength(RequiredKillEnemies) > 1 or not IsEmpty( SessionMapState.ProjectilesCarryingSpawns ) do
		waitUntil("RequiredKillEnemyKilledOrSpawned", "TyphonHeadSummonPresentationEarlyEnd")
	end
	wait(0.1, "TyphonHeadSummonPresentationEarlyEnd")
	if not typhon.InTransition then
		return
	end
	SetThreadWait("TyphonHeadWeaponCameraThread", 0.01)
	SetThreadWait(typhon.AIThreadName, 0.01)
	killTaggedThreads("TyphonHeadIncursionThread")
	if typhon.IncursionUnitId ~= nil and ActiveEnemies[typhon.IncursionUnitId] ~= nil and IsAlive({ Id = typhon.IncursionUnitId }) then
		if ActiveEnemies[typhon.IncursionUnitId].ExitAnimation ~= nil then
			SetAnimation({ DestinationId = typhon.IncursionUnitId, Name = ActiveEnemies[typhon.IncursionUnitId].ExitAnimation })
		end
		ExpireProjectiles({ Names = { "TyphonArmSlamNova", "TyphonArmFlickWave", "TyphonTailImpale", "TyphonTailShockwave" } })
		ApplyUpwardForce({ Id = typhon.IncursionUnitId, Speed = 2000, SelfApplied = true })
		IgnoreGravity({ Id = typhon.IncursionUnitId })
		SetAlpha({ Id = typhon.IncursionUnitId, Fraction = 0.0, Duration = 0.5 })
		thread(DestroyOnDelay, { typhon.IncursionUnitId }, 0.5 )
	end
end

function TyphonHeadTailWeapon( typhon, args )


	local unit = DeepCopyTable(EnemyData.TyphonTail_Incursion)
	local targetId = CurrentRun.Hero.ObjectId
	unit.OutgoingDamageModifiers = { { NonPlayerMultiplier = 0, } }
	unit.ObjectId = SpawnUnit({ Name = "TyphonTail_Incursion", Group = "Standing", DestinationId = targetId })
	typhon.IncursionUnitId = unit.ObjectId
	SetupUnit(unit)
	SetAlpha({ Id = unit.ObjectId, Fraction = 0.0, Duration = 0.0 })
	SetUntargetable({ Id = unit.ObjectId })

	wait( 2.0, "TyphonHeadIncursionThread" ) -- Moved this over from TyphonHeadSummonPresentation to start the thread and early end earlier
	wait( args.IncursionDelay or 0, "TyphonHeadIncursionThread" )

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpalePreFire" })
	SetAlpha({ Id = unit.ObjectId, Fraction = 1.0, Duration = 0.0 })
	AdjustZLocation({ Id = unit.ObjectId, Distance = 2000 })
	IgnoreGravity({ Id = unit.ObjectId })

	ShakeScreen({ Speed = 400, Distance = 8, FalloffSpeed = 1000, Duration = 1.0 })
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar" })

	wait(0.02, "TyphonHeadIncursionThread")

	CreateAnimation({ DestinationId = unit.ObjectId, Name = "FallingShadowTyphonTail" })
	
	wait(0.75, "TyphonHeadIncursionThread")
	
	ObeyGravity({ Id = unit.ObjectId })

	wait(0.25, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpaleFireA" })
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusRockThrowWhoosh" })

	wait(0.2, "TyphonHeadIncursionThread")

	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.5, FalloffSpeed = 1400, Angle = 90 })
	CreateProjectileFromUnit({ Name = "TyphonTailImpale", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	
	wait(0.55,"TyphonHeadIncursionThread")

	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.5, FalloffSpeed = 1400, Angle = 90 })
	CreateProjectileFromUnit({ Name = "TyphonTailImpale", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	CreateProjectileFromUnit({ Name = "TyphonTailShockwave", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	
	wait(0.2, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpalePostFire" })

	wait(0.25, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_Retreat" })
	AdjustZLocation({ Id = unit.ObjectId, Distance = 1000, Duration = 1 })
	IgnoreGravity({ Id = unit.ObjectId })

	wait(1.0, "TyphonHeadIncursionThread")

	Move({ Id = unit.ObjectId, DestinationId = targetId })
	NotifyWithinDistance({ Id = unit.ObjectId, DestinationId = targetId, Distance = 75, Notify = "TailAttack", Timeout = 2.0 })
	waitUntil( "TailAttack" )

	Stop({ Id = unit.ObjectId })
	Halt({ Id = unit.ObjectId })

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpalePreFire" })

	ShakeScreen({ Speed = 400, Distance = 8, FalloffSpeed = 1000, Duration = 1.0 })
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar" })

	wait(0.02, "TyphonHeadIncursionThread")

	CreateAnimation({ DestinationId = unit.ObjectId, Name = "FallingShadowTyphonTail" })
	
	wait(0.75, "TyphonHeadIncursionThread")

	ObeyGravity({ Id = unit.ObjectId })

	wait(0.25, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpaleFireA" })
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusRockThrowWhoosh" })

	wait(0.2, "TyphonHeadIncursionThread")

	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.5, FalloffSpeed = 1400, Angle = 90 })
	CreateProjectileFromUnit({ Name = "TyphonTailImpale", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	
	wait(0.55)

	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.5, FalloffSpeed = 1400, Angle = 90 })
	CreateProjectileFromUnit({ Name = "TyphonTailImpale", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	CreateProjectileFromUnit({ Name = "TyphonTailShockwave", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	
	wait(0.2, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpalePostFire" })

	wait(0.25, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_Retreat" })
	ApplyUpwardForce({ Id = unit.ObjectId, Speed = 2000 })
	IgnoreGravity({ Id = unit.ObjectId })

	SetAlpha({ Id = unit.ObjectId, Fraction = 0.0, Duration = 0.5 })
	wait(5.0, "TyphonHeadIncursionThread") -- Give the projectile time to finish so attacker is not nil

	typhon.IncursionUnitId = nil
	Destroy({ Id = unit.ObjectId })
end


function TyphonHeadArmWeapon( typhon, args )
	local armUnit = DeepCopyTable(EnemyData.TyphonArm_Incursion)
	local armUnitSpawnId = 779875
	armUnit.OutgoingDamageModifiers = { { NonPlayerMultiplier = 0, } }
	armUnit.ObjectId = SpawnUnit({ Name = "TyphonArm_Incursion", Group = "Standing", DestinationId = armUnitSpawnId })
	SetupUnit(armUnit)
	typhon.IncursionUnitId = armUnit.ObjectId
	SetUntargetable({ Id = armUnit.ObjectId })
	SetAlpha({ Id = armUnit.ObjectId, Fraction = 0.0, Duration = 0.0 })

	wait( 2.0, "TyphonHeadIncursionThread" ) -- Moved this over from TyphonHeadSummonPresentation to start the thread and early end earlier
	wait( args.IncursionDelay or 0, "TyphonHeadIncursionThread" )

	SetAlpha({ Id = armUnit.ObjectId, Fraction = 1.0, Duration = 0.0 })
	SetGoalAngle({ Id = armUnit.ObjectId, Angle = 308 })
	AdjustZLocation({ Id = armUnit.ObjectId, Distance = 2000 })
	IgnoreGravity({ Id = armUnit.ObjectId })
	ShakeScreen({ Speed = 400, Distance = 8, FalloffSpeed = 1000, Duration = 1.0 })
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar" })

	wait(0.02, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = armUnit.ObjectId, Name = "Enemy_TyphonArm_SlamFireLoop" })
	CreateAnimation({ DestinationId = armUnit.ObjectId, Name = "FallingShadowTyphonArm" })

	wait(1.0, "TyphonHeadIncursionThread")
	
	ObeyGravity({ Id = armUnit.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusRockThrowWhoosh" })
	
	wait(0.5, "TyphonHeadIncursionThread")
	CreateProjectileFromUnit({ Name = "TyphonArmSlamNova", Id = armUnit.ObjectId, DestinationId = armUnit.ObjectId })
	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.5, FalloffSpeed = 1400, Angle = 90 })
	CreateAnimation({ Name = "TyphonArmSlamImpactFx", DestinationId = armUnit.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/CorruptedCerberus/CerberusGroundSlam" })
	SetAnimation({ DestinationId = armUnit.ObjectId, Name = "Enemy_TyphonArm_SlamPostFire" })
	wait(0.5, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = armUnit.ObjectId, Name = "Enemy_TyphonArm_CastPreFire" })

	wait(1.33, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = armUnit.ObjectId, Name = "Enemy_TyphonArm_CastFire" })
	
	wait(0.8, "TyphonHeadIncursionThread")
	CreateProjectileFromUnit({ Name = "TyphonArmFlickWave", Id = armUnit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = GetAngleBetween({ Id = armUnit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) + RandomFloat(-20, 20) })
	wait(0.1, "TyphonHeadIncursionThread")
	CreateProjectileFromUnit({ Name = "TyphonArmFlickWave", Id = armUnit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = GetAngleBetween({ Id = armUnit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) + RandomFloat(-20, 20) })
	wait(0.1, "TyphonHeadIncursionThread")
	CreateProjectileFromUnit({ Name = "TyphonArmFlickWave", Id = armUnit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = GetAngleBetween({ Id = armUnit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) + RandomFloat(-20, 20) })
	wait(0.5, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = armUnit.ObjectId, Name = "Enemy_TyphonArm_CastPostFire" })
	wait(0.25, "TyphonHeadIncursionThread")

	SetAnimation({ DestinationId = armUnit.ObjectId, Name = "Enemy_TyphonArm_Exit" })
	AdjustZLocation({ Id = armUnit.ObjectId, Distance = 2000, Duration = 1.0 })
	IgnoreGravity({ Id = armUnit.ObjectId })
	wait(0.25, "TyphonHeadIncursionThread")

	SetAlpha({ Id = armUnit.ObjectId, Fraction = 0.0, Duration = 0.75 })
	wait(3.0, "TyphonHeadIncursionThread") -- Give the projectile time to finish so attacker is not nil
	typhon.IncursionUnitId = nil
	Destroy({ Id = armUnit.ObjectId })

end


function TyphonHeadGustPresentation(typhon, args)
	AdjustRadialBlurDistance({ Fraction = 0.6, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.6, Duration = 0.2 })
	local soundId = PlaySound({ Name = "/SFX/Enemy Sounds/Typhon/TyphonStormLoop", Id = typhon.ObjectId, })
	ShakeScreen({ Speed = 600, Distance = 10, FalloffSpeed = 0, Angle = 180, Duration = 5 })
	wait( 5.5 )
	StopSound({ Id = soundId, Duration = 0.25 })

	AdjustRadialBlurDistance({ Fraction = 0.0, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.0, Duration = 0.2 })
end

function TyphonHeadRoarPresentation(typhon, args)
	AdjustRadialBlurDistance({ Fraction = 0.6, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.6, Duration = 0.2 })

	ShakeScreen({ Speed = RandomInt(45, 55), Distance = 5, FalloffSpeed = 0, Angle = 220, Duration = 4 })
	wait( 4.5 )

	AdjustRadialBlurDistance({ Fraction = 0.0, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.0, Duration = 0.2 })
end


function TyphonCameraRaindropsPresentation( args )

	local cameraRainDropletContainer = CreateScreenComponent({
		Name = "BlankObstacle",
		Group = "Combat_UI_World",
		X = 0,
		Y = 0,
	})

	while true do
		local delay = RandomFloat( 0.01, 0.3 )
		wait( delay )
		local dropletAnimationNum = RandomInt( 1, 8 )
		local offset = CalcOffset( RandomFloat( 0.0, math.pi * 2 ), RandomFloat( 250, 290 ) )
		offset.X = offset.X * (16/9*ScreenScaleX/ScreenScaleY) + ScreenCenterX * 0.5;
		offset.Y = offset.Y + ScreenCenterY * 0.5;
		local scale = math.pow( RandomFloat(0.3, 0.8), 2 )

		CreateAnimation({ Name = "TyphonScreenWaterDroplet0" .. dropletAnimationNum, DestinationId = cameraRainDropletContainer, UseScreenLocation = true, OffsetX = offset.X, OffsetY = offset.Y, Scale = scale })
		CreateAnimation({ Name = "TyphonScreenWaterDropletHighlight0" .. dropletAnimationNum, DestinationId = cameraRainDropletContainer, UseScreenLocation = true, OffsetX = offset.X, OffsetY = offset.Y, Scale = scale })
	end

end

function RoomEntranceBossTwins( currentRun, currentRoom, args )
	args = args or {}

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

	for k, id in pairs(args.BossIds) do
		if args.BossIntroSound ~= nil then
			PlaySound({ Name = args.BossIntroSound, Id = id })
		end
		if args.BossIntroAnimation ~= nil then
			SetAnimation({ Name = args.BossIntroAnimation, DestinationId = id })
		end
		if args.BossIntroAngleTowardPlayer ~= nil then
			AngleTowardTarget({ Id = id, DestinationId = CurrentRun.Hero.ObjectId })
		end
		wait( args.BossStaggerDelay or 0 )
	end
	wait( args.BossIntroDelay or 0 )

	local firstTimeBonusWait = 0
	if currentRoom.FirstTimeBonusWait ~= nil and GameState.RoomCountCache[currentRoom.Name] == nil then
		firstTimeBonusWait = currentRoom.FirstTimeBonusWait
	end
	wait( firstTimeBonusWait or 0 )

	--wait( roomIntroSequenceDuration )
	--LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnblockCombatUI("BossEntrance")
end


-- @ ending
function CheckTyphonReward( source, args )

	if not GameState.WorldUpgradesAdded.WorldUpgradeStormStop then
		return
	end

	-- only give the reward the first time
	if GameState.TyphonDefeatedWithStormStop then
		return
	end

	wait( 0.5, RoomThreadName )
	GiveRandomConsumables(
	{
		LootOptions = args.LootOptions,
		ForceToValidLocation = true,
		KeepCollision = true,
	})

	GameState.TyphonDefeatedWithStormStop = true

end

function SetupMelWalk( source, args )
	SetUnitProperty({ Property = "StartGraphic", Value = "MelinoeWalkStart", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "MelinoeWalk", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StopGraphic", Value = "MelinoeWalkStop", DestinationId = CurrentRun.Hero.ObjectId })
	for i, rushWeaponName in pairs( WeaponSets.HeroRushWeapons ) do
		SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	if MapState.InitialSpeed == nil then
		MapState.InitialSpeed = GetUnitDataValue({ Id = CurrentRun.Hero.ObjectId, Property = "Speed" })
	end
	SetUnitProperty({ Property = "Speed", Value = 120, DestinationId = CurrentRun.Hero.ObjectId })
end

function RestoreMelRun( source, args )
	args = args or {}
	if args.WaitForInputAllowed then
		local notifyName = "RestoreMelRun_InputAllowed"
		NotifyOnInputAllowed({ Notify = notifyName })
		waitUntil( notifyName )
	end
	if MapState.InitialSpeed == nil then
		return
	end
	if not args.SkipWalkStopAnimation then
		SetAnimation({ Name = "MelinoeWalkStop", DestinationId = CurrentRun.Hero.ObjectId })
	end
	SetUnitProperty({ Property = "StartGraphic", Value = "MelinoeStart", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "MelinoeRun", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StopGraphic", Value = "MelinoeStop", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = MapState.InitialSpeed, DestinationId = CurrentRun.Hero.ObjectId })
	MapState.InitialSpeed = nil
end

function SetupPalaceForcefield( source, args )

	local outsidePalaceHiderIds = GetIds({ Name = "OutsidePalaceHiderIds" })
	SetThingProperty({ Property = "CausesOcclusion", Value = false, DestinationIds = outsidePalaceHiderIds })
	SetAlpha({ Ids = outsidePalaceHiderIds, Fraction = 0.0 })

	SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = { 792640 } })
	SetThingProperty({ Property = "StopsProjectiles", Value = false, DestinationIds = { 792640 } })
	-- Destroy({ Ids = drawbridgeIds })

	-- Destroy({ Ids = GetIds({ Name = "TyphonHeadDeathDelete" }) })

end

function DisablePalaceForcefield( source, args )

	AddInputBlock({ Name = "LowerPalacePresentation" })
	UseableOff({ Id = source.ObjectId })

	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
	EndAutoSprint()
	
	wait( 0.05 )

	if IsGameStateEligible( source, args.ForceWalkRequirements ) then
		SetupMelWalk()
	end

	local insidePalaceHiderIds = GetIds({ Name = "InsidePalaceHiderIds" })
	local outsidePalaceHiderIds = GetIds({ Name = "OutsidePalaceHiderIds" })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
	-- SetAnimation({ Name = "MelinoeInteract", DestinationId = CurrentRun.Hero.ObjectId })

	thread( PlayVoiceLines, GlobalVoiceLines.PalaceEntranceUsedVoiceLines, true )

	AdjustFullscreenBloom({ Name = "DesaturatedLight", Duration = 0.9 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.13, Duration = 1.5 }, } )

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })
	local vignetteAName = "NightmareVignetteLoop"
	if ConfigOptionCache.GraphicsQualityPreset == "GraphicsQualityPreset_Low" then
		-- None
	else
		CreateAnimation({ Name = "NightmareEdgeFxSpawner", DestinationId = CurrentRun.Hero.ObjectId }) --nopkg
	end
	local vignetteA = CreateAnimation({ Name = vignetteAName, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	DrawScreenRelative({ Id = vignetteA })
	
	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.1 })
	AdjustRadialBlurStrength({ Fraction = 1.0, Duration = 0.1 })
	
	local loopingSoundId = PlaySound({ Name = "/SFX/Menu Sounds/CauldronWhispers", Id = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Melinoe_Gesture", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 1.2 })

	CreateAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	CreateAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })

	wait(2.6)

	AdjustFullscreenBloom({ Name = "FullscreenFlash2", Duration = 0.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1 })

	wait(0.3)
	StopAnimation({ Name = "MelHPostBossHandFxLeft", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRight", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxLeftB", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "MelHPostBossHandFxRightB", DestinationId = CurrentRun.Hero.ObjectId })
	StopSound({ Id = loopingSoundId, Duration = 0.4 })
	loopingSoundId = nil

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1 })

	StopAnimation({ Name = vignetteAName, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	StopAnimation({ Name = "NightmareEdgeFxSpawner", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.5 )

	AdjustColorGrading({ Name = "LegendaryProphecy", Duration = 0.2 })
	AdjustFullscreenBloom({ Name = "WeaponAspect", Duration = 0.2 })
	PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCompleteNova"  })

	CreateAnimation({ Name = "PalaceSunFlareLargeGlowIn", DestinationId = 798804, Group = "Overlook" })
	local sunFlareScale = GetThingDataValue({ Id = 798804, Property = "Scale" })
	SetScale({ Id = 798804, Fraction = sunFlareScale * 2 })
	Move({ Id = 798804, DestinationId = 798806, Duration = 0 })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	--local interactVignette = CreateAnimation({ Name = "WeaponKitInteractVignette_Prophecy", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	--DrawScreenRelative({ Id = interactVignette })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColorInvert", Group = "FX_Add_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	ShakeScreen({ Speed = 600, Distance = 9, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.35, Duration = 0.30 }, } )

	wait( 0.3 )
	if not GameState.ReachedTrueEnding then
		PlaySound({ Name = "/SFX/OlympianForcefieldDisable" })
	end

	ShakeScreen({ Speed = 800, Distance = 3, FalloffSpeed = 500, Duration = 1.3 })
	thread( DoRumble, { { ScreenPreWait = 0.1, LeftFraction = 0.17, Duration = 1.4 }, } )

	wait( 0.5 )
	StopSound({ Id = AudioState.AmbienceId, Duration = 1.0 })
	AudioState.AmbienceId = nil
	AudioState.AmbienceName = nil

	if GameState.ReachedTrueEnding then
		FullScreenFadeOutAnimation( "RoomTransitionIn_TimeWarp" )
		wait( 1.0 )
		Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 792641 })
		SetAlpha({ Ids = outsidePalaceHiderIds, Fraction = 1.0, Duration = 0.5 })
		SetAlpha({ Ids = insidePalaceHiderIds, Fraction = 0.0, Duration = 0.5 })
		FullScreenFadeInAnimation( "RoomTransitionOut_TimeWarp" )
		thread( TrueEndingTimeFxVignette )
	else
		SetAlpha({ Ids = outsidePalaceHiderIds, Fraction = 1.0, Duration = 0.5 })
		SetAlpha({ Ids = insidePalaceHiderIds, Fraction = 0.0, Duration = 0.5 })
		thread( MoveHeroToRoomPosition, { DisableCollision = true, DestinationId = 792641 } )
	end

	AdjustFullscreenBloom({ Name = "SaturatedLight", Duration = 0.1 })

	wait( 0.5 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 8 })

	-- toggle impassability
	SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = { 776143 } })
	SetThingProperty({ Property = "StopsProjectiles", Value = false, DestinationIds = { 776143 } })

	wait( 0.5 )


	AudioState.AmbienceId = PlaySound({ Name = "/Leftovers/Object Ambiences/CommonwealthAmbience", Duration = 0.5 })

	SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = { 792640 } })
	SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationIds = { 792640 } })

	AdjustColorGrading({ Name = "Off", Duration = 0.8 })
--	AdjustFullscreenBloom({ Name = "Off", Duration = 0.8 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 1.0 )

	RemoveInputBlock({ Name = "LowerPalacePresentation" })

	SetupApolloMusic( nil, args.ApolloMusicArgs )

	thread( DisplayInfoBanner, nil, {
		Text = "Location_SurfaceEnding",
		Delay = 4.0,
		Layer = "Overlay",
		AnimationName = "InfoBannerPalaceofZeusIn",
		AnimationOutName = "InfoBannerPalaceofZeusOut",
		BackingGradientAnimationName = "LocationBackingGradientPalace",
		FontScale = 0.8,
	} )
end

function BiomeOverlookQPostBoss( room, args )
	if not MapState.InOverlook and IsEmpty(RequiredKillEnemies) then
		MapState.InOverlook = true
		local sunFlareScale = GetThingDataValue({ Id = 798804, Property = "Scale" })
		SetScale({ Id = 798804, Fraction = sunFlareScale, Duration = 8, EaseIn = 0, EaseOut = 1 })
		Move({ Id = 798804, DestinationId = 798807, Duration = 6, EaseIn = 0, EaseOut = 1 })

		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 0.5 })
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "Keys" }, Value = 0.0, Duration = 3.0 })
		SetVolume({ Id = AudioState.MusicId, Value = 0.7, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")
		ToggleCombatControl( CombatControlsDefaults, false, "Overlook" )
		EndAutoSprint({ Halt = true, EndWeapon = true })

		thread( FlockOfBirds )

		wait( 0.1, "OverlookThread" )
		if MapState.InOverlook then
			local overlookTime = args.Duration or 8
			local overlookEaseInTime = args.EaseIn or 0
			local overlookEaseOutTime = args.EaseOut or 3
			PanCamera({ Ids = { args.PanTargetId, CurrentRun.Hero.ObjectId }, Duration = overlookTime, EaseIn = overlookEaseInTime, EaseOut = overlookEaseOutTime, Retarget = true })
			if args.ZoomFraction then
				FocusCamera({ Fraction = args.ZoomFraction, Duration = overlookTime, ZoomType = "Ease" })
			end
		end

	end
end

function BiomeBackToRoomQPostBoss( room, args )
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

		RestoreMelRun()

		SetThreadWait( "OverlookThread", 0.01 )

		wait(1.0)

	end
end

function FlockOfBirds()
	wait(0.3)
	thread( SendCritters, 
		{ 
			MinCount = 12, MaxCount = 15, 
			StartX = -3200, StartY = -1970,
			MinAngle = -2, MaxAngle = 6, 
			MinSpeed = 100, MaxSpeed = 600, 
			MinInterval = 0.1, MaxInterval = 0.15, 
			CritterScaleMin = 0.3, CritterScaleMax = 0.55,
			GroupName = "Terrain_Below_02", 
			KillTime = 25,
			CritterName = "SingleBatWhite"
		}
	)
end

function SetupApolloMusic( source, args )
	if AudioState.AmbientMusicId == nil then
		AudioState.AmbientMusicId = PlaySound({ Name = "/Music/ApolloSong", Id = args.ApolloId })
	end
	SetSoundSource({ Id = AudioState.AmbientMusicId, DestinationId = args.ApolloId })
	SetVolume({ Id = AudioState.AmbientMusicId, Value = args.Volume or 1.0 })
	for param, value in pairs( args.Params ) do
		SetSoundCueValue({ Id = AudioState.AmbientMusicId, Name = param, Value = value, Duration = args.Duration })
	end
	if args.TrackOffset ~= nil or args.TrackOffsetMin ~= nil then
		SetSoundPosition({ Id = AudioState.AmbientMusicId, Position = args.TrackOffset or RandomFloat( args.TrackOffsetMin, args.TrackOffsetMax ) })
	end
	if args.ApolloId ~= nil then
		CreateAnimation({ Name = "StatusSinging", DestinationId = args.ApolloId, OffsetX = 40, OffsetY = -120, OffsetZ = 130 }) -- should match below!
	end
end

function PauseApolloSinging( source, args )
	SetAnimation({ DestinationId = source.ObjectId, Name = "Apollo_Singing_End" })
	SetSoundCueValue({ Id = AudioState.AmbientMusicId, Name = "Vocals", Value = 0, Duration = 0 })
	StopAnimation({ Name = "StatusSinging", DestinationId = source.ObjectId })
end

function ResumeApolloSinging( source, args )
	SetAnimation({ DestinationId = source.ObjectId, Name = "Apollo_Singing_Start" })
	SetSoundCueValue({ Id = AudioState.AmbientMusicId, Name = "Vocals", Value = 1.0, Duration = 0.5 })
	CreateAnimation({ Name = "StatusSinging", DestinationId = source.ObjectId, OffsetX = 40, OffsetY = -120, OffsetZ = 130 }) -- should match above!
end

function SetupPalaceExitPoint( source, args )

	local exitPointId = 792347
	SetAlpha({ Id = exitPointId, Fraction = 0.0 })
	UseableOff({ Id = exitPointId })
	SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = { 792347 } })
	SetThingProperty({ Property = "StopsProjectiles", Value = false, DestinationIds = { 792347 } })

end

function ActivatePalaceExitPoint( source, args )

	local exitPointId = 792347

	CreateAnimation({ Name = "BoonOrbSpawn", GroupName = "FX_Standing_Top", DestinationId = exitPointId })
	SetAlpha({ Id = exitPointId, Fraction = 1.0, Duration = 0.5 })
	UseableOn({ Id = exitPointId })
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX", Id = exitPointId })
	SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = { 792347 } })
	SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationIds = { 792347 } })

	local dummyBoon = MapState.ActiveObstacles[exitPointId]
	ProcessTextLines( dummyBoon, dummyBoon.InteractTextLineSets )

end

function UseDummyLoot( usee, args, user )
	AddInputBlock({ Name = "UseDummyLoot" })
	PlayInteractAnimation( usee.ObjectId, { Animation = "MelinoeBoonPreInteract" } )
	RemoveInputBlock({ Name = "UseDummyLoot" })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonInteract" })

	local textLines = GetRandomEligibleTextLines( usee, usee.InteractTextLineSets, GetNarrativeDataValue( usee, "InteractTextLinePriorities" ) )
	PlayTextLines( usee, textLines, { ScreenArgs = { SkipCheckQuestStatus = true } } )
end

function ActivateApollo()

	local apolloId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Apollo_Story_01" })
	local apollo = ActiveEnemies[apolloId]
	apollo.NextInteractLines = GetRandomEligibleTextLines( apollo, apollo.InteractTextLineSets, GetNarrativeDataValue( apollo, "InteractTextLinePriorities" ) )
	SetNextInteractLines( apollo, apollo.NextInteractLines )
	SetAvailableUseText( apollo )

end

function SetupZeusHeraFinalInteraction( source, args )
	wait( 0.02 )
	local heraId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Hera_Story_01" })
	local hera = ActiveEnemies[heraId]
	hera.BlockDeathToChronosSalute = true
end

function BlockDemeterInteraction( source, args )
	wait( 0.02 )
	AddInteractBlock( source, "BlockDemeterInteraction" )
	StopStatusAnimation( source )
end

function RestoreDemeterInteraction()

	local demeterId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Demeter_Story_01" })
	local demeter = ActiveEnemies[demeterId]
	RemoveInteractBlock( demeter, "BlockDemeterInteraction" )
	PlayStatusAnimation( demeter, { Animation = StatusAnimations.WantsToTalk } )
	demeter.BlockDeathToChronosSalute = true

end

function OlympianSaluteResponse()
	ResetCooldown( "MelinoeSaluteSpeech" )
end