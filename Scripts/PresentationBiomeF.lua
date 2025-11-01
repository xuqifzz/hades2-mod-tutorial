function HecateLightTorches( args )
	args = args or {}
	wait( 0.5 )
	CreateAnimation({ DestinationId = args.Id or 510167, Name = "HecateTorchFlameLeft_PostKill", Group = "Standing", Scale = 1.0, OffsetY = -35 }) 
	wait( 0.06 )
	CreateAnimation({ DestinationId = args.Id or 510167, Name = "HecateTorchFlameRight_PostKill", Group = "Standing", Scale = 1.0, OffsetY = -35 })
end

function HecateBattleStart( hecate, args )

	-- wait(0.3)

	local pactLevel = GetNumShrineUpgrades( hecate.ShrineUpgradeName )
	if pactLevel >= 1 and hecate.Name == "Hecate" then
		local clones = GetIdsByType({ Name = "HecateCopyEM" })
		for k, id in pairs(clones) do
			thread(HecateBattleStart, ActiveEnemies[id], args)
		end
	end

	SetAnimation({ DestinationId = hecate.ObjectId, Name = "HecateHubOutfitBattleIntro" })
	CreateAnimation({ DestinationId = hecate.ObjectId, Name = "HecateTransformFlameDelay", Group = "Standing" })
	CreateAnimation({ DestinationId = hecate.ObjectId, Name = "HecateTransitionTorchFxL", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0 }) 
	CreateAnimation({ DestinationId = hecate.ObjectId, Name = "HecateTransitionTorchFxR", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0 }) 

	local notifyName = "HecateBattleStartAnimation"
	NotifyOnAnimationTimeRemaining({ Id = hecate.ObjectId, Animation = "HecateHubOutfitBattleIntro", Remaining = 0.01, Notify = notifyName, Timeout = 9.0 })
	waitUntil( notifyName )

	SetThingProperty({ Property = "GrannyModel", Value = "HecateBattle_Mesh", DestinationId = hecate.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "HecateTorchIdle", DestinationId = hecate.ObjectId })
	SetAnimation({ DestinationId = hecate.ObjectId, Name = "HecateBattleOutfitBattleIntro" })

	if pactLevel < 1 then
		hecate.WeaponName = "HecateBattleIntro"
		local aiData = ShallowCopyTable(hecate.DefaultAIData) or hecate
		if WeaponData[hecate.WeaponName] ~= nil and WeaponData[hecate.WeaponName].AIData ~= nil then
			OverwriteTableKeys( aiData, WeaponData[hecate.WeaponName].AIData)
		end
		aiData.WeaponName = hecate.WeaponName
		table.insert(hecate.WeaponHistory, hecate.WeaponName)
		DoAttack( hecate, aiData )
	else
		SetThingProperty({ Property = "GrannyTexture", Value ="GR2/HecateEM_Color", DestinationId = hecate.ObjectId })
		CreateAnimation({ Name = "HecateTorchFlameLeft", DestinationId = hecate.ObjectId })
		CreateAnimation({ Name = "HecateTorchFlameRight", DestinationId = hecate.ObjectId })
	end

end

function SpawnHecateClones(room, args)
	args = args or {}
	wait(args.Delay or 1.5)
	local hecate = ActiveEnemies[GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "Hecate" })]
	UnitSplit(hecate, { SpawnCount = 2, SpawnedUnit = "HecateCopyEM", RequiredSpawnPointType = "EnemyPointRanged", SkipUnitAISetup = true, DefaultGrannyTexture = true } )

	wait(0.3)
	thread( HecateLightTorches, { Id = hecate.ObjectId } )
	for id, v in pairs(hecate.SplitIds) do
		thread( HecateLightTorches, { Id = id } )
	end
end

function HecateKillPresentation( unit, args )

	AddInputBlock({ Name = "HecateKillPresentation" })
	LockCameraMotion( "HecateKillPresentation" )

	RecordEncounterClearStats()
	ClipEvent({ Icon = "steam_combat", Title = GetDisplayName({ Text = "HecateMessage" }), Description = "", StartOffset = 0.0, Duration = 5.0 })

	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = true
	local killerId = CurrentRun.Hero.ObjectId
	local victimId = unit.ObjectId
	local deathPanSettings = args
	ClearEffect({ Ids = { victimId, killerId }, All = true, BlockAll = true, })
	EffectPostClearAll( unit )
	if unit.Frozen then
		UnfrozenPresentation( unit, { SkipPresentation = true })
	end
	SetUnitInvulnerable( unit, "HecateKillPresentation" )

	local pactLevel = GetNumShrineUpgrades( unit.ShrineUpgradeName )
	if pactLevel >= 1 then
		SetThingProperty({ Property = "GrannyTexture", Value = "", DestinationId = unit.ObjectId })
	end

	if unit.DeathFx ~= nil then
		CreateAnimation({ Name = unit.DeathFx, DestinationId = unit.ObjectId, Angle = args.ImpactAngle })
		unit.DeathFx = nil
	end
	if unit.DeathSound ~= nil then
		PlaySound({ Name = unit.DeathSound, Id = unit.ObjectId })
		unit.DeathSound = nil
	end
	if unit.LastHitAnimation ~= nil then
		SetAnimation({ Name = unit.LastHitAnimation, DestinationId = unit.ObjectId })
	end
	if unit.BossKillVoiceLines ~= nil then
		thread( PlayVoiceLines, unit.BossKillVoiceLines, false, unit )
	end

	BlockProjectileSpawns({ ExcludeWeaponName = "WeaponLob" })
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})
	StopAnimation({ Names = { "HecateTorchFlameLeft", "HecateTorchFlameRight", "Invincibubble_Hecate", }, DestinationId = unit.ObjectId })

	SetPlayerInvulnerable( "HecateKillPresentation" )
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	EndRamWeapons({ Id = killerId })

	if args.AddInterBiomeTimerBlock then
		AddTimerBlock( CurrentRun, "InterBiome" )
	end
	AddTimerBlock( CurrentRun, "HecateKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	SetUnitVulnerable( unit, "HecateKillPresentation" )
	ClearCameraClamp({ LerpTime = 0 })
	local cameraPanTime = 1.5
	if deathPanSettings.StartPanTime then
		cameraPanTime = deathPanSettings.StartPanTime
	end
	local sceneOffsetY = -85
	PanCamera({ Id = victimId, Duration = 0.64, OffsetY = sceneOffsetY })
	FocusCamera({ Fraction = 1.1, Duration = 0.64 })
	ZeroMouseTether("HecateKillPresentation")	
	CancelWeaponFireRequests({ Id = killerId })
	ToggleCombatControl( CombatControlsDefaults, false, "BossKill" )

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen, nil, { IgnoreHUDShow = true } )
	end
	HideCombatUI("BossKill")

	PlaySound({ Name = "/SFX/Enemy Sounds/Hecate/HecateDefeated" })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if deathPanSettings.StartSound then
		PlaySound({ Name = deathPanSettings.StartSound })
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteShocked" })
	end
	EndMusic()

	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.12, DataValue = false, DestinationId = killerId })
	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = victimId })
	--thread( VictimDeathHold, victimId, 0.02, 0.3 )
	if deathPanSettings.FlashRed then
		--Flash({ Id = victimId, Speed = 0.01, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = 0.5, ExpireAfterCycle = true })
	end

	RemoveFromGroup({ Id = killerId, Names = { "Standing" } })
	AddToGroup({ Id = killerId, Name = "Combat_Menu", DrawGroup = true })
	RemoveFromGroup({ Id = victimId, Name = "Standing" })
	AddToGroup({ Id = victimId, Name = "Combat_Menu", DrawGroup = true })

	if deathPanSettings.EndAngle then
	--	SetGoalAngle({ Id = victimId, Angle = deathPanSettings.EndAngle })
	end

	-- black out world
	AdjustFrame({ Color = Color.TransparentRed, Duration = 0.0, Fraction = 0 })
	ScreenAnchors.DeathBackground = ScreenAnchors.DeathBackground or CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = ScreenAnchors.DeathBackground, Fraction = 10 })
	SetColor({ Id = ScreenAnchors.DeathBackground, Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 1.0, Duration = 0 })

	thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.17, Duration = 0.65 }, { ScreenPreWait = 2.8, LeftFraction = 0.3, Duration = 0.6 } } )

	Flash({ Id = victimId, Speed = 0.02, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = 1.55, ExpireAfterCycle = true })

	wait( 1.5 )
	SetAlpha({ Id = killerId, Fraction = 0, Duration = 0.3 })
	ClearEffect({ Id = killerId, Name = "KillDamageBonus" })

	local bossDeathFlash = CreateScreenComponent({ Name = "BlankObstacle", Group = "Overlay", X = ScreenCenterX, Y = ScreenCenterY - sceneOffsetY })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathStartFwoosh", Id = bossDeathFlash.Id })
	SetAnimation({ DestinationId = bossDeathFlash.Id, Name = "MelDeathFlash" })
	SetGoalAngle({ Id = victimId, Angle = 270, CompleteAngle = true })

	for i=1, 16 do
		CreateAnimation({ Name = "MelDeathLine", DestinationId = ScreenAnchors.DeathBackground, Group = "Combat_Menu_TraitTray_Overlay_Additive", OffsetY = sceneOffsetY })
	end

	if unit.DeathAnimation ~= nil then
		SetAnimation({ Name = unit.DeathAnimation, DestinationId = unit.ObjectId })
		unit.DeathAnimation = nil
	end

	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTransformFlameDark_Outro", Group = "Combat_UI", Scale = 1.2, OffsetY = sceneOffsetY  })
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTransformFlame_Outro", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.2, OffsetY = sceneOffsetY }) 
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateBattleOutroSymbolA", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0, OffsetY = sceneOffsetY }) 
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateBattleOutroSymbolB", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0, OffsetY = sceneOffsetY }) 
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateBattleOutroSymbolC", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0, OffsetY = sceneOffsetY }) 
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateBattleOutroSymbolD", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0, OffsetY = sceneOffsetY }) 
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateBattleOutroSymbolFloor", Group = "Combat_UI", Scale = 1.0, OffsetY = sceneOffsetY }) 
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateBattleOutroGlowEmitter", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0, OffsetY = sceneOffsetY }) 
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTransitionTorchFxL", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0 }) 
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTransitionTorchFxR", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0 }) 


	-- wait( 1.5 )

	local textMessage = deathPanSettings.Message
	if deathPanSettings.BossDifficultyMessage and GetNumShrineUpgrades( "BossDifficultyShrineUpgrade" ) > 0 then
		textMessage = deathPanSettings.BossDifficultyMessage
	end

	thread( DisplayInfoBanner, nil, { 
		Text = "HecateMessage", 
		Delay = 0.75, 
		TextColor = Color.White, 
		TextFadeColor = {64,230,255,255},
		FontScale = 0.9,
		Layer = "Overlay", 
		AnimationName = "InfoBannerBossKillIn",
		AnimationOutName = "InfoBannerBossKillOut",
		Duration = 3.75 } )

	if deathPanSettings.BatsAfterDeath then
		thread( SendCritters, { MinCount = 80, MaxCount = 90, StartX = 0, StartY = 300, MinAngle = 75, MaxAngle = 115, MinSpeed = 400, MaxSpeed = 2000, MinInterval = 0.03, MaxInterval = 0.1, GroupName = "CrazyDeathBats" } )
	end

	local notifyName = "HecateBattleEndAnimation"
	NotifyOnAnimationTimeRemaining({ Id = unit.ObjectId, Animation = "HecateBattleOutfitBattleOutro", Remaining = 0.01, Notify = notifyName, Timeout = 9.0 })
	waitUntil( notifyName )

	SetThingProperty({ Property = "GrannyModel", Value = "HecateHub_Mesh", DestinationId = unit.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "HecateHubTorchBattleIdle", DestinationId = unit.ObjectId })

	SetAnimation({ DestinationId = unit.ObjectId, Name = "HecateHubOutfitBattleOutro" })
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTransitionTorchFxL2", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0 }) 
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTransitionTorchFxR2", Group = "Combat_Menu_TraitTray_Overlay_Additive", Scale = 1.0 }) 

	if deathPanSettings.EndPanTime then
		wait( deathPanSettings.EndPanTime )
	else
		wait( 3.15 )
	end

	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0.0, Duration = 0.3 })
	StopAnimation({ Names = { "HecateBattleOutroSymbolFloorDarkFxA", "HecateBattleOutroSymbolFloorDarkFxB" }, DestinationId = unit.ObjectId })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationId = killerId })
	SetAlpha({ Id = killerId, Fraction = 1.00, Duration = 0.3 })
	RemoveFromGroup({ Id = killerId, Names = { "Combat_Menu" } })
	AddToGroup({ Id = killerId, Name = "Standing", DrawGroup = true })

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 3.0, EaseOut = 0.5, })
	local defaultZoom = 1.0
	if CurrentHubRoom ~= nil then
		defaultZoom = CurrentHubRoom.ZoomFraction or defaultZoom
	else
		defaultZoom = CurrentRun.CurrentRoom.ZoomFraction or defaultZoom
	end
	FocusCamera({ Fraction = defaultZoom, Duration = 3.0, ZoomType = "Ease" })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })
	SetVolume({ Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	-- Exit Narrative Events --

	--[[SetAnimation({ DestinationId = unit.ObjectId, Name = GetThingDataValue({ Id = unit.ObjectId, Property = "Graphic" }) })
	LockCamera({ Id = unit.ObjectId, Duration = 1.25 })
	Move({ Id = unit.ObjectId, DestinationId = 510277, SuccessDistance = 50 })
	local notifyName = "WithinDistance"..unit.ObjectId
	NotifyWithinDistance({ Id = unit.ObjectId, DestinationId = 510277, Distance = 50, Notify = notifyName, Timeout = 9.0, })
	waitUntil( notifyName, unit.AIThreadName )]]

	thread( PlayVoiceLines, unit.PostMatchTauntVoiceLines, true, unit )

	Stop({ Id = unit.ObjectId })
	-- AngleTowardTarget({ Id = unit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	EndMusic( AudioState.MusicId, AudioState.MusicName )
	RemoveEnemyUI( unit )

	wait( 0.1, RoomThreadName )
	AddToGroup({ Id = victimId, Name = "Standing", DrawGroup = true })
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTorchFlameLeft_PostKill", Group = "Standing", Scale = 1.0, OffsetY = -35 }) 
	wait( 0.06 )
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTorchFlameRight_PostKill", Group = "Standing", Scale = 1.0, OffsetY = -35 }) 

	if GameState.TextLinesRecord.HecateFirstExit then
		wait( 0.4, RoomThreadName )
	--else
	--	wait( 2.0, RoomThreadName )
	end

	local textLines = GetRandomEligibleTextLines( unit, unit.BossOutroTextLineSets, GetNarrativeDataValue( unit, "BossOutroTextLinePriorities" ) )
	PlayTextLines( unit, textLines )

	wait( 0.2, RoomThreadName )

	thread( PlayVoiceLines, GlobalVoiceLines.HecateReturnVoiceLines, true, unit )
	thread( PlayVoiceLines, HeroVoiceLines.HecateDefeatedVoiceLines )

	local hecateTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = unit.ObjectId, OffsetY = 30, OffsetX = 15 })
	PlaySound({ Name = "/SFX/Player Sounds/IrisDeathMagic" })
	CreateAnimation({ Name = "DeathSequenceFxBack", DestinationId = hecateTarget, Group = "FX_Dark" })
	CreateAnimation({ Name = "DeathSequenceFxFront", DestinationId = hecateTarget, Group = "FX_Standing_Add" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	--ShakeScreen({ Angle = 90, Distance = 6, Speed = 300, FalloffSpeed = 300, Duration = 0.5 })

	SetUnitProperty({ DestinationId = unit.ObjectId, Property = "CollideWithUnits", Value = false })
	SetUnitProperty({ DestinationId = unit.ObjectId, Property = "CollideWithObstacles", Value = false })
	
	wait( 1.25, RoomThreadName )

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0, })
	SetAlpha({ Id = unit.ObjectId, Fraction = 0.0, Duration = 0.2 })

	-- ---- ---- ---- --
	SetAnimation({ DestinationId = killerId, Name = "MelinoeEquip" })
	RemoveInputBlock({ Name = "HecateKillPresentation" })
	RemoveTimerBlock( CurrentRun, "HecateKillPresentation" )
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	SetPlayerVulnerable( "HecateKillPresentation" )
	UnlockCameraMotion( "HecateKillPresentation" )
	ShowCombatUI("BossKill")
	ClearEffect({ Ids = { killerId }, All = true })
	
	CurrentRun.CurrentRoom.Encounter.BossKillPresentation = false
	ToggleCombatControl( CombatControlsDefaults, true, "BossKill" )
	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
end

function HecateCloneHitPresentation( blocker, args )
	if blocker.IsDead then
		return
	end

	Flash({ Id = blocker.ObjectId, Speed = 0.85, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.Green, Duration = 0.15, ExpireAfterCycle = true })
	SetAlpha({ Id = blocker.ObjectId, Fraction = 0.2, Duration = 0.05 })
	PlaySound({ Name = "/Leftovers/SFX/InvincibleOnHit", Id = blocker.ObjectId })

	wait(0.15)
	SetAlpha({ Id = blocker.ObjectId, Fraction = 1.0, Duration = 0.13 })
end

function HecateDarkSideTransformPresentation( triggerArgs )
	local unit = triggerArgs.Victim

	thread( PlayVoiceLines, GlobalVoiceLines.HecateTransformVoiceLines, nil, unit )

	waitUnmodified( 0.2, unit.AIThreadName )

	local isFirstDarkSide = true
	for i = #unit.WeaponHistory - 1, 1, -1 do
		local prevWeapon = unit.WeaponHistory[i]
		if prevWeapon == "HecateDarkSideTransform" then
			isFirstDarkSide = false
			break
		end
	end
	
	-- camera
	if isFirstDarkSide then
		PanCamera({ Ids = { CurrentRun.Hero.ObjectId, unit.ObjectId }, Duration = 0.2 })
		FocusCamera({ Fraction = 0.9, Duration = 0.2, ZoomType = "Ease" })
	end

	-- pause the game
	AddSimSpeedChange( "HecateDarkSideTransform", { Fraction = 0.1, LerpTime = 0.25, Priority = true } )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAnger" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/SkillUpgradeConfirm" })
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTransformFlameDark", Group = "FX_Dark", })
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTransformFlame", Group = "FX_Standing_Add", })

	thread( InCombatText, unit.ObjectId, "SpellTransformTrait", 1.4, { ShadowScale = 0.66, OffsetY = -215 } )

	waitUnmodified( 0.8, unit.AIThreadName )

	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTeleportFxFront", Group = "FX_Standing_Add", OffsetZ = 150 })

	waitUnmodified( 0.2, unit.AIThreadName )

	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateSpellChargeFx", Group = "FX_Standing_Add", })
	--SetThingProperty({ Property = "GrannyTexture", Value ="GR2/HecateEM_Color", DestinationId = unit.ObjectId })
	RemoveSimSpeedChange( "HecateDarkSideTransform", { LerpTime = 0.25 } )

	if isFirstDarkSide then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5, OffsetX = 0, OffsetY = 0, Retarget = true })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.5, ZoomType = "Ease" })
	end

	waitUnmodified( 2.0, unit.AIThreadName )
end

function HecateDarkSideEndPresentation( triggerArgs )
	local unit = triggerArgs.Victim

	--thread( InCombatText, unit.ObjectId, "SpellTransformTrait".." end", 1.4, { ShadowScale = 0.66, OffsetY = -215 } )

	StopAnimation({ DestinationId = unit.ObjectId, Name = "HecateSpellChargeFx", IncludeCreatedAnimations = true })
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "HecateTeleportFxFront", Group = "FX_Standing_Add", OffsetZ = 150 })
	waitUnmodified( 0.2, unit.AIThreadName )
	--SetThingProperty({ Property = "GrannyTexture", Value = "", DestinationId = unit.ObjectId })
end

-- @ ending
function HecateKidnappingEntrancePresentation( source, args )
	local hecateId = GetIdsByType({ Name = "Hecate" })[1]
	SetAnimation({ Name = "Hecate_Combat_Frozen", DestinationId = hecateId })
	CreateAnimation({ Name= "NightmareStatisFxHecate", DestinationId = hecateId })
	SetUntargetable({ Id = hecateId })
	StopSecretMusic()
	StartFinalBossChronosIntroMusic()
end
function HecateKidnappingExitPresentation( source, args )
	AddTimerBlock( CurrentRun, "InterBiome" )

	AddInputBlock({ Name = "HecateKidnappingExitPresentation" })

	local hecateId = GetIdsByType({ Name = "Hecate" })[1]
	local chronosId = GetIdsByType({ Name = "NPC_Chronos_01" })[1]

	wait( 0.5 )

	CreateAnimation({ DestinationId = hecateId, Name = "ChronosTeleportFxFront" })
	SetAlpha({ Id = hecateId, Fraction = 0, Duration = 0.2 })

	CreateAnimation({ DestinationId = chronosId, Name = "ChronosTeleportFxFront" })
	SetAlpha({ Id = chronosId, Fraction = 0, Duration = 0.2 })

	wait( 1.0 )
	StopSound({ Id = AudioState.MusicId, Value = 0.0, Duration = 1 })
	AudioState.MusicId = nil
	AudioState.MusicName = nil
	AudioState.MusicSection = nil
	AudioState.MusicPaused = nil

	StopAnimation({ DestinationId = hecateId, Name = "NightmareStatisFxHecate", IncludeCreatedAnimations = true })
	RequiredKillEnemies[hecateId] = nil
	Destroy({ Ids = { hecateId, chronosId }})

	RemoveInputBlock({ Name = "HecateKidnappingExitPresentation" })

end

function HecateMissingPresentation( source, args )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25, FromCurrentLocation = true })
	AddTimerBlock( CurrentRun, "InterBiome" )
end

GlobalVoiceLines.SummonAthenaVoiceLines =
{
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "ArachneCurseQuestComplete01" },
			},
		},
		{
			PreLineWait = 0.6,
			ObjectType = "NPC_Athena_01",
			AllowTalkOverTextLines = true,

			{ Cue = "/VO/Athena_0060", Text = "{#Emph}Hmph." },
		},
	}
}
function SummonAthena( source, args )

	local athena = DeepCopyTable( EnemyData.NPC_Athena_01 )
	local arachneId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Arachne_01" })

	athena.ObjectId = SpawnUnit({ Name = "NPC_Athena_01", Group = "Standing", DestinationId = arachneId, OffsetX = 150, OffsetY = 300, })

	Destroy({ Id = ScreenAnchors.DialogueBackgroundId })

	SecretMusicPlayer( "/Music/MusicPlayer/Iris/IrisMusicBiomeStartOlympusMusicPlayer" )

	SetupUnit( athena, CurrentRun, { IgnoreAI = true, IgnoreAssert = true, } )
	SetUnitProperty({ DestinationId = athena.objectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = athena.objectId, Property = "CollideWithUnits", Value = false })
	SetAlpha({ Id = athena.ObjectId, Fraction = 0, Duration = 0 })
	AngleTowardTarget({ Id = athena.ObjectId, DestinationId = arachneId })
	AdjustZLocation({ Id = athena.ObjectId, Distance = 2000 - GetZLocation({ Id = athena.ObjectId }) })
	IgnoreGravity({ Id = athena.ObjectId })

	AdjustColorGrading({ Name = "Gold", Duration = 2.5 })
	BloomRequestStart({ SourceName = "AthenaSpawnPresentation", BloomType = "AthenaDivineInterventionBloom", Duration = 1.0 })
	
	PanCamera({ Ids = { athena.ObjectId, arachneId }, Duration = 2, Retarget = true})

	PlaySound({ Name = "/SFX/AthenaBoonChoice" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedArthurChoir" })

	wait(1.0)

	SetAnimation({ Name = "Athena_Leap_Entrance", DestinationId = athena.ObjectId })
	AdjustZLocation({ Id = athena.ObjectId, Distance = 0 - GetZLocation({ Id = athena.ObjectId }), Duration = 0.1 })
	SetAlpha({ Id = athena.ObjectId, Fraction = 1, Duration = 0.05 })

	thread( PlayVoiceLines, GlobalVoiceLines.SummonAthenaVoiceLines )
	PlaySound({ Name = "/SFX/Player Sounds/AthenaSlamSFX", Id = athena.ObjectId })

	wait(0.1)

	CreateAnimation({ DestinationId = athena.ObjectId, Name = "AthenaLandingNovaDetonateFx", })

	wait( 1.5, RoomThreadName )

	BloomRequestEnd({ SourceName = "AthenaSpawnPresentation", Duration = 0.25 })
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })

	CreateDialogueBackground()

end

function UnSummonAthena( source, args )

	args = args or {}

	local athenaId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Athena_01" })
	local partnerId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "NPC_Arachne_01" }, })
	MapState.RoomRequiredObjects[athenaId] = nil

	AdjustColorGrading({ Name = "Gold", Duration = 1.5 })
	BloomRequestStart({ SourceName = "AthenaExitPresentation", BloomType = "AthenaDivineInterventionBloom", Duration = 1.5 })

	AdjustRadialBlurDistance({ Fraction = 0.3, Duration = 0.5 })
	AdjustRadialBlurStrength({ Fraction = 1.2, Duration = 0.5 })
	PlaySound({ Name = "/SFX/AthenaWrathHolyShield", Id = source.ObjectId })

	wait( args.WaitTime or 0.5 )

	SetAnimation({ Name = "Athena_Leap_Exit", DestinationId = athenaId })

	SecretMusicPlayer( "/Music/BlankMusicCue" )

	wait ( 0.45 )
	AdjustZLocation({ Id = athenaId, Distance = 2000 - GetZLocation({ Id = athenaId }), Duration = 0.1 })

	wait ( 0.05 )
	SetAlpha({ Id = athenaId, Fraction = 0.0, Duration = 0.05 })

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.25 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.25 })
	BloomRequestEnd({ SourceName = "AthenaExitPresentation", Duration = 0.25 })
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })

	PanCamera({ Ids = { CurrentRun.Hero.ObjectId }, Duration = 1.0, Retarget = true})
	wait(0.1)
	ActiveEnemies[athenaId] = nil
	Destroy({ Id = athenaId })

end

function SetupHecateBossIntroTextLines( source, args )
	source.QueuedBossIntroTextLines = GetRandomEligibleTextLines( source, source.BossIntroTextLineSets, GetNarrativeDataValue( source, "BossIntroTextLinePriorities" ) )
	SessionMapState.QueuedBossIntroTextLines = source.QueuedBossIntroTextLines
end