function ExtraDoorEncounterStartPresentation( eventSource, args )
	local survivalEncounter = eventSource

	AdjustColorGrading({ Name = colorGrade or "Alert", Duration = 0 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	AdjustFullscreenBloom({ Name = "AlertBloom", Duration = 0.25 })

	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	wait( 0.2, RoomThreadName )

	thread( PlayVoiceLines, GlobalVoiceLines.ExtraDoorEncounterStartVoiceLines, true )

	AdjustFullscreenBloom({ Name = "NewType10", Duration = 1.4 })
	PlaySound({ Name = "/SFX/SurvivalChallengeStart" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )
	
	wait( 0.2 )

	local roomData = RoomData[CurrentRun.CurrentRoom.Name]

	ResumeMusic()
	SetSoundCueValue({ Names = roomData.DefaultMusicParams or { "Guitar", "Bass", "Drums" }, Id = AudioState.MusicId, Value = 1, Duration = 0.75 })

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	wait( 0.2, RoomThreadName )
	Destroy({ Ids = { fullscreenAlertColorFx, fullscreenAlertDisplacementFx } })
	EnableRoomTraps()
end

function PerfectClearEncounterStartPresentation( eventSource )
	local encounter = eventSource

	PauseMusic()
	SecretMusicPlayer( "/Music/ErebusChallengeMusic_MC" )
	SetSoundCueValue({ Names = { "Guitar", "Bass", "Drums" }, Id = AudioState.SecretMusicId, Value = 1 })
	-- SetSoundCueValue({ Names = { "Section", }, Id = AudioState.SecretMusicId, Value = 2 })

	thread( PlayVoiceLines, GlobalVoiceLines.PerfectClearEncounterInitiatedLines, true )

	SurvivalEncounterStartPresentation( encounter, "PerfectClear", "FullscreenAlertColorDark", "PerfectClearAboutToStartVoiceLines", "PerfectClearEncounterStartVoiceLines" )

end

function PerfectClearEncounterEndPresentation( eventSource )
	local encounter = eventSource
	if AudioState.SecretMusicId ~= nil then
		EndMusic( AudioState.SecretMusicId, SecretMusicName )
		AudioState.SecretMusicId = nil
		AudioState.SecretMusicName = nil
	end
end

function EliteEncounterStartPresentation( eventSource )
	local encounter = eventSource

	PauseMusic()
	AudioState.EliteEncounterMusicId = PlaySound({ Name = "/Music/FishingMusicLoop" })
	-- SetSoundCueValue({ Names = { "Guitar", "Bass", "Drums" }, Id = AudioState.SecretMusicId, Value = 1 })
	-- SetSoundCueValue({ Names = { "Section", }, Id = AudioState.SecretMusicId, Value = 2 })

	thread( PlayVoiceLines, GlobalVoiceLines.EliteEncounterInitiatedLines, true )

	SurvivalEncounterStartPresentation( encounter, "PerfectClear", "FullscreenAlertColorDark", "PerfectClearAboutToStartVoiceLines", "PerfectClearEncounterStartVoiceLines" )
end

function EliteChallengeSpawnPresentation( unit )
	
	SetUnitInvulnerable( unit, "EliteChallengeSpawnPresentation" )
	-- camera
	FocusCamera({ Fraction = 1.03, Duration = 0.5, ZoomType = "Ease" })
	PanCamera({ Id = unit.ObjectId, Duration = 0.5, EaseIn = 0, EaseOut = 0.1 })

	waitUnmodified(0.3)

	AddSimSpeedChange( "EliteChallengeSpawnPresentation", { Fraction = 0.05, LerpTime = 0.0001, Priority = true } )

	waitUnmodified(0.3)

	if unit.EliteAttributes ~= nil then
		if unit.EliteAttributes[1] ~= nil then
			thread( InCombatText, unit.ObjectId, unit.EliteAttributes[1], 1, { OffsetY = -220 } )
			PlaySound({ Name = "/Leftovers/Menu Sounds/TeamWipe", Id = unit.ObjectId })

			waitUnmodified(1.2)
		end
		if unit.EliteAttributes[2] ~= nil then
			thread( InCombatText, unit.ObjectId, unit.EliteAttributes[2], 1, { OffsetY = -220 } )
			PlaySound({ Name = "/Leftovers/Menu Sounds/TeamWipe", Id = unit.ObjectId })

			waitUnmodified(1.0)
		end
	end

	RemoveSimSpeedChange( "EliteChallengeSpawnPresentation", { LerpTime = 0.4 } )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5, EaseIn = 0, EaseOut = 0.1 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 0.4, ZoomType = "Ease" })
	
	SetUnitVulnerable( unit, "EliteChallengeSpawnPresentation" )
end

-- some of this is in StartChallengeEncounter()
function ChallengeEncounterStartPresentation( eventSource )
	local challengeEncounter = eventSource
	local challengeSwitchId = challengeEncounter.Switch.ObjectId
	SecretMusicPlayer( "/Music/MusicExploration1_MC", { ParamNames = { "Keys", "Drums" } } )
	SetSoundCueValue({ Names = { "Section", }, Id = AudioState.SecretMusicId, Value = 2 })

	thread( PlayVoiceLines, GlobalVoiceLines.ChallengeEncounterActivatedLines, true )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAnger" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )

	SurvivalEncounterStartPresentation( challengeEncounter )
	thread( TrackTimeChallengeProgress, challengeEncounter )
end

function TrackTimeChallengeProgress( challengeEncounter )
	local notifyName = "RequiredKillEnemyKilledOrSpawned"

	wait( 3.0, RoomThreadName )
	local remainingEnemies = math.ceil(GetRemainingSpawns( CurrentRun, CurrentRun.CurrentRoom, challengeEncounter ) + TableLength(challengeEncounter.ActiveSpawns))
	if remainingEnemies <= 10 then
		UpdateObjectiveDescription("TimeChallenge", "Objective_TimeChallengeRemaining", "RemainingEnemies", remainingEnemies)
		UpdateObjective( "TimeChallenge", "RemainingEnemies", remainingEnemies )
	end

	local lastRemainingEnemies = remainingEnemies
	while not challengeEncounter.Completed do
		waitUntil( notifyName, RoomThreadName )
		lastRemainingEnemies = remainingEnemies
		remainingEnemies = math.ceil( GetRemainingSpawns( CurrentRun, CurrentRun.CurrentRoom, challengeEncounter ) + TableLength(challengeEncounter.ActiveSpawns))
		remainingEnemies = remainingEnemies + TableLength( SessionMapState.ProjectilesCarryingSpawns )
		if remainingEnemies == 10 then
			UpdateObjectiveDescription( "TimeChallenge", "Objective_TimeChallengeRemaining", "RemainingEnemies", remainingEnemies )
		end
		if remainingEnemies <= 10 then
			UpdateObjective( "TimeChallenge", "RemainingEnemies", remainingEnemies, {Pulse = lastRemainingEnemies ~= remainingEnemies} )
		end
	end
end


function EncounterEndPresentation()
	-- thread( PlayUnequipAnimation )
end

function ChallengeEncounterEndPresentation( eventSource )

	if eventSource.EncounterType == "EliteChallenge" then
		thread( PlayVoiceLines, GlobalVoiceLines.EliteEncounterClearedLines, true )
	elseif eventSource.EncounterType == "PerfectClear" then
		thread( PlayVoiceLines, GlobalVoiceLines.PerfectClearEncounterConcludedLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.ChallengeEncounterClearedVoiceLines, true )
	end

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })

	if AudioState.SecretMusicId ~= nil then
		EndMusic( AudioState.SecretMusicId, AudioState.SecretMusicName )
		AudioState.SecretMusicId = nil
		AudioState.SecretMusicName = nil
	end

	StopSound({ Id = AudioState.EliteEncounterMusicId, Duration = 0.5 })
	AudioState.EliteEncounterMusicId = nil

	thread( ResumeMusic, { Duration = 0.2, Delay = 5.0 } )
end

function HadesSpeakingPresentation( eventSource, args )
	args = args or {}
	wait( args.StartDelay or 1.0, RoomThreadName )
	eventSource.LineHistoryName = eventSource.LineHistoryName or args.LineHistoryName
	eventSource.SubtitleColor = eventSource.SubtitleColor or args.SubtitleColor or Color.ChronosVoice
	PlayVoiceLines( args.VoiceLines, false, eventSource, { OnPlayedSomethingFunctionName = "DoHadesSpeakingPresentation", OnPlayedSomethingFunctionArgs = args } )
end

function DoHadesSpeakingPresentation( eventSource, args )

	if args.RequireNonPlayerSource and eventSource == CurrentRun.Hero then
		return
	end
	if not args.BlockColorGrade then
		AdjustColorGrading({ Name = args.ColorGrade or "Alert", Duration = 0 })
	end
	if args.UseSurvivalPresentation then
		thread( SurvivalEncounterStartPresentation )
	end

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColor", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	PlaySound({ Name = args.StartSound or "/Leftovers/World Sounds/ThunderHuge" })
	if not args.BlockScreenshake then
		ShakeScreen({ Speed = 100, Distance = 2, FalloffSpeed = 2000, Duration = 0.3 })
	end

	local hadesOverlayOffsetX = -420
	if args.OverlayDeathFx then
		hadesOverlayOffsetX = 0
	end

	local hadesOverlay = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + hadesOverlayOffsetX, Y = ScreenCenterY, Group = "Combat_Menu" })
	SetScale({ Id = hadesOverlay, Fraction = 1 })
	SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 0 })

	if args.OverlayDeathFx then
		ScreenAnchors.DeathPortraitOverlayFxEmitter = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay",
			Animation = "DeathPortraitOverlayFxEmitter",
			X = ScreenCenterX,
			Y = ScreenCenterY - 80,
			ScaleX = ScreenScaleX,
			ScaleY = ScreenScaleY,
		})
	end

	if args.OverlayAnim then
		SetAnimation({ Name = args.OverlayAnim, DestinationId = hadesOverlay })
	end
	if not CurrentRun.CurrentRoom.BlockHadesOverlay then
		SetAlpha({ Id = hadesOverlay, Fraction = 1.0, Duration = 0 })
	end

	thread( HadesVoicelineBlur, args )

	if args.UseNightmareSounds ~= nil then
		local randomSound = GetRandomValue({ "/Music/ARStinger_Strings_2", "/Music/ARStinger_Strings_3", "/Music/ARStinger_Strings_4" })
		PlaySound({ Name = randomSound })
	end
	
	wait( args.WaitTime or 3.0, RoomThreadName )

	AdjustFullscreenBloom({ Name = "NewType10", Duration = 1.4 })

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = args.PortraitDuration or 1 })
	wait( args.PortraitDuration or 1.0, RoomThreadName )
	Destroy({ Id = hadesOverlay })
	Destroy({ Ids = { fullscreenAlertColorFx, fullscreenAlertDisplacementFx } })
end


function ArachneRewardFoundPresentation( encounter )
	thread( PlayVoiceLines, GlobalVoiceLines.CocoonRewardFoundVoiceLines, true )
end

function ArtemisPreSpawnPresentation( eventSource, args )

	wait(1)

	PlaySound({ Name = "/SFX/ArtemisBoonChoice" })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedArthurChoir" })

	AdjustColorGrading({ Name = "Artemis", Duration = 1.0, EaseIn = 0, EaseOut = 1 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.5, EaseIn = 0, EaseOut = 1 })

	for k, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if unit.EncounterStartVoiceLines ~= nil then
			thread( PlayVoiceLines, unit.EncounterStartVoiceLines, nil, unit )
		end
	end

	thread( DisplayInfoBanner, nil, { 
		Text = "ArtemisMessage", 
		Delay = 0.2, 
		TextFadeColor = {0.4, 0.9, 0.6, 1},
		AnimationName = "InfoBannerArtemisIn",
		AnimationOutName = "InfoBannerArtemisOut", 
	} )

	wait( 0.5, RoomThreadName )

	SecretMusicPlayer( EnemyData.NPC_Artemis_01.ThemeMusic, { ParamNames = { "Keys", "Drums", } } )
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 0 })

	thread( function()
		wait( 0.5 )
		AdjustFullscreenBloom({ Name = "Off", Duration = 1.5, EaseIn = 0, EaseOut = 1 })
		AdjustColorGrading({ Name = "Off", Duration = 3.0, EaseIn = 0, EaseOut = 1 })	
	end )
end

function ArtemisAppearancePresentation( artemis )

	-- SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })
	
	AngleTowardTarget({ Id = artemis.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	
	wait( 0.1, RoomThreadName )

	thread( PlayVoiceLines, artemis.EncounterEndVoiceLines, nil, artemis )

	wait( 0.35, RoomThreadName )

	CreateAnimation({ Name = "TeleportDisappear", DestinationId = artemis.ObjectId })

	wait( 0.05, RoomThreadName)
	
	SetAlpha({ Id = artemis.ObjectId, Fraction = 1.0, Duration = 0 })
	SetAnimation({ Name = "Artemis_Appear", DestinationId = artemis.ObjectId })

	local textLines = GetRandomEligibleTextLines( artemis, artemis.InteractTextLineSets, GetNarrativeDataValue( artemis, "InteractTextLinePriorities" ) )
	SetNextInteractLines( artemis, textLines )

	wait( 1.0, RoomThreadName )	

end

function ArtemisFirstAppearancePresentation( artemis )

	AddInputBlock({ Name = "ArtemisAppearancePresentation" })
	SetPlayerInvulnerable( "ArtemisAppearancePresentation" )

	HideCombatUI( "ArtemisFirstAppearancePresentation" )
	CutsceneAddLetterbox()


	-- SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })

	PanCamera({ Ids = artemis.ObjectId, Duration = 1.95, EaseIn = 0.05, EaseOut = 0.03 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	wait( 1.0, RoomThreadName )
	
	AngleTowardTarget({ Id = artemis.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	
	wait( 0.1, RoomThreadName )

	thread( PlayVoiceLines, artemis.EncounterEndVoiceLines, nil, artemis )

	wait( 0.35, RoomThreadName )

	CreateAnimation({ Name = "TeleportDisappear", DestinationId = artemis.ObjectId })

	wait( 0.05, RoomThreadName)
	
	SetAlpha({ Id = artemis.ObjectId, Fraction = 1.0, Duration = 0 })
	SetAnimation({ Name = "Artemis_Appear", DestinationId = artemis.ObjectId })

	wait( 2.1, RoomThreadName )

	RemoveInputBlock({ Name = "ArtemisAppearancePresentation" })
	SetPlayerVulnerable( "ArtemisAppearancePresentation" )
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	Move({ Id = ScreenAnchors.LetterBoxTop, Angle = 90, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })
	Move({ Id = ScreenAnchors.LetterBoxBottom, Angle = 270, Distance = 150, EaseIn = 0.99, EaseOut = 1.0, Duration = 1.15 })

	wait(0.35)

	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom}, Fraction = 0, Duration = 0.4 })
	ShowCombatUI( "ArtemisFirstAppearancePresentation" )
end

function ArtemisExitPresentation( source, args )

	if not CurrentRun.Hero.IsDead and CurrentRun.CurrentRoom.Encounter.ArtemisId == nil then
		return
	end

	args = args or {}
	
	UseableOff({ Id = source.ObjectId })
	source.SpecialInteractFunctionName = nil
	source.CanReceiveGift = false
	source.NextInteractLines = nil
	RefreshUseButton( source.ObjectId, source )

	thread( PlayVoiceLines, source.ExitVoiceLines, false, source )

	StopSecretMusicTheme( source )

	wait( args.WaitTime or 3 )

	StopStatusAnimation( source )

	if not args.SkipAnim then
		SetAnimation({ Name = "Artemis_Disappear", DestinationId = source.ObjectId })
		wait ( 1.65 )
	end
	CreateAnimation({ Name = "TeleportDisappear", DestinationId = source.ObjectId })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.1 })

	wait( 0.5, RoomThreadName )

	source.Mute = true
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[source.ObjectId] = args.AnimationState
	end

end

function CrowdReactionPresentation( args )

	if args.Chance ~= nil and RandomChance(args.Chance) then
		return
	end

	if not CheckCooldown( "CrowdReactionPresentationPlaying", 8.0 ) and not args.SkipCooldown then
		return
	end

	if args.Requirements ~= nil and not IsGameStateEligible( args, args.Requirements ) then
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

	for k, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if enemy.CrowdReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.CrowdReactionVoiceLines, true, enemy )
		end
	end

end

function CrowdReactionPresentationEventSource( eventSource, args )
	CrowdReactionPresentation( args )
end


function ShoppingFidgetPresentation( unit )
	while unit.Shopping do
		-- thread( PlayEmoteSimple, unit, { AnimationName = "StatusIconDisgruntled", Delay = 0.5, ChanceToPlay = 0.5, OffsetZ = 160 } )
		local fidgetInterval = RandomFloat( unit.ShopEventData.FidgetIntervalMin, unit.ShopEventData.FidgetIntervalMax )
		wait( unit.ShopEventData.BrowsingVoiceLinesDelay )
		thread( PlayVoiceLines, unit.BrowsingVoiceLines, true )
		fidgetInterval = fidgetInterval - unit.ShopEventData.BrowsingVoiceLinesDelay
		wait( fidgetInterval )
	end
end

function ShoppingSuccessHeraclesPresentation( unit, args )
	args = args or {}
	thread( PlayVoiceLines, unit.PurchasedVoiceLines, true )
	if args.InstantPurchase then
		thread( PlayVoiceLines, GlobalVoiceLines.FrustratedVoiceLines, true )
	end
	SetAnimation({ Name = "Heracles_Hub_Granting", DestinationId = unit.ObjectId })
	-- DebugPrint({ Text = "Shopping success!" })
end


function ShoppingSuccessNemesisPresentation( unit, args )
	args = args or {}
	thread( PlayVoiceLines, unit.PurchasedVoiceLines, true )
	if args.InstantPurchase then
		thread( PlayVoiceLines, GlobalVoiceLines.FrustratedVoiceLines, true )
	end
	SetAnimation({ Name = "Nemesis_Hub_Interact", DestinationId = unit.ObjectId })
	-- DebugPrint({ Text = "Shopping success!" })
end

function ShoppingSuccessItemPresentation( item )
	PlaySound({ Name = "/Leftovers/Menu Sounds/StoreBuyingItem" })
	CreateAnimation({ Name = "MoneyDropCoinPickup", DestinationId = item.ObjectId })
	if item == nil then
		return
	end
	if item.AcquireText then
		thread( InCombatText, item.ObjectId, item.AcquireText )
	end
	if item.ConsumeFx ~= nil then
		CreateAnimation({ Name = item.ConsumeFx, DestinationId = item.ObjectId })
	end
	PlaySound({ Name = item.ConsumeSound or "/SFX/GyroHealthPickupMunch", Id = item.ObjectId, Delay = 0.3 })
end

function ShoppingFailedPresentation( unit )
	thread( PlayVoiceLines, unit.PurchaseStolenVoiceLines, true )
	-- thread( PlayEmoteSimple, unit, { AnimationName = "StatusIconDisgruntled", Delay = 0.5, ChanceToPlay = 1, OffsetZ = 160 } )
	DebugPrint({ Text = "Shopping failed!" })
end

function ArachneCombatDrumCheck( unit )
	local anyEnemy = false
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if not enemy.ToggleTrap and not enemy.IsDead and not enemy.Portrait and not enemy.IgnoreAutoLock and not enemy.IgnoreDamage then
			--DebugPrint({ Text = "enemy = "..GetTableString(enemy) })
			anyEnemy = true
			break
		end
	end
	if anyEnemy then
		SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 1, Duration = 0.25 })
		SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1, Duration = 0.25 })
	else
		SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0, Duration = 0.25 })
		SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0, Duration = 0.25 })
	end
end

function SetHeroAngleWithMoveOrder( args )
	if args == nil then
		return
	end
	local notifyName = "HeroAngleWithMoveOrder"
	Move({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.ObjectId, SuccessDistance = 32 })
	NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.ObjectId, Distance = 15, Notify = notifyName, Timeout = args.Timeout })
	waitUntil( notifyName )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.ObjectId })
	Stop({ Id = CurrentRun.Hero.ObjectId })
end

function AngleNPCToHero( source )
	local npcId = source.ObjectId
	local arcThreshold = source.TurnInPlaceAngleMin or 50
	local facingAngle = GetAngle({ Id = npcId })
	local angleToTarget = GetAngleBetween({ Id = npcId, DestinationId = CurrentRun.Hero.ObjectId })
	local arcDistance = CalcArcDistance( facingAngle, angleToTarget )
	if source.TurnInPlaceAnimation ~= nil then
		local playTurnAnimation = source.AlwaysPlayTurnInPlaceAnimation
		if arcDistance > arcThreshold then
			if source.TurnInPlaceDelay ~= nil then
				thread( GenericPresentation, source, { PreWait = source.TurnInPlaceDelay, AngleTowardHero = true } )
			else
				AngleTowardTarget({ Id = npcId, DestinationId = CurrentRun.Hero.ObjectId })
			end
			playTurnAnimation = true
		end
		if playTurnAnimation then
			SetAnimation({ Name = source.TurnInPlaceAnimation, DestinationId = npcId })
		end
	end
end

function CheckEnemySightedVoiceLines( source, args, contextArgs )
	local triggeredByEnemy = ActiveEnemies[contextArgs.NotifiedById]
	if triggeredByEnemy == nil or not triggeredByEnemy.ActivationFinished then
		return
	end
	if triggeredByEnemy.EnemySightedVoiceLines ~= nil then
		PlayVoiceLines( triggeredByEnemy.EnemySightedVoiceLines, true, source, args )
	end
end

function DevotionTestPresentation( source, args )

	args = args or {}

	if args.PresentationGameStateRequirements ~= nil and not IsGameStateEligible( source, args.PresentationGameStateRequirements ) then
		return
	end

	HideCombatUI("Devotion")
	thread( DisplayInfoBanner, nil,
		{
			AnimationName = "LocationBackingIrisGenericIn", AnimationOutName = "LocationBackingIrisGenericOut",
			Text = "DevotionMessage", Delay = 0.95,
		} )
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

function SurvivalEncounterStartPresentation( eventSource, colorGrade, colorFx, playerGlobalVoiceLines, opponentGlobalVoiceLines )
	eventSource = eventSource or {}

	AdjustColorGrading({ Name = colorGrade or "Alert", Duration = 0 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	SetScaleX({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleX, Duration = 0 })
	SetScaleY({ Id = fullscreenAlertDisplacementFx, Fraction = ScreenScaleY, Duration = 0 })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = colorFx or "FullscreenAlertColor", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	thread( PlayVoiceLines, GlobalVoiceLines.ChallengeEncounterEnemySightedVoiceLines, true )

	BloomRequestStart({ SourceName = "SurvivalEncounterStartPresentation", BloomType = "NewType10", Duration = 1.4 })

	PlaySound({ Name = eventSource.StartSound or "/SFX/SurvivalChallengeStart" })

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )

	wait( 1.0, RoomThreadName )

	local activeStemTable = { "Guitar", "Bass", "Drums" }
	SetSoundCueValue({ Names = activeStemTable, Id = AudioState.MusicId, Value = 1, Duration = 0.75 })

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	BloomRequestEnd({ SourceName = "SurvivalEncounterStartPresentation", Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	wait( 1.0, RoomThreadName )
	Destroy({ Ids = { fullscreenAlertColorFx, fullscreenAlertDisplacementFx } })
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
	SetScale({ Id = capturePointSwitch.ObjectId, Fraction = 0.01, Duration = 0.25, EaseIn = 0, EaseOut = 1 })
	CreateAnimation({ DestinationId = capturePointSwitch.ObjectId, Name = "CapturePointOutFx" })

	thread( PlayVoiceLines, HeroVoiceLines.AnomalyCombatBeginsVoiceLines, true )

	SecretMusicPlayer( "/Music/IrisTimedEncounterMusic" )

	-- thread( PlayVoiceLines, GlobalVoiceLines.ChallengeSwitchActivatedLines, true )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAnger" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )

	thread( HadesSpeakingPresentation, {}, { SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = { GlobalVoiceLines = "AnomalyCombatBeginsVoiceLines" }, StartSound = "/SFX/TimeSlowStart", StartDelay = 3 } )

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

	SetScale({ Id = encounter.CapturePointId, Fraction = 0.8, Duration = 1.0, EaseIn = 0.0, EaseOut = 1.0 })
	SetAlpha({ Id = encounter.CapturePointId, Fraction = 0.0, Duration = 1.0, EaseIn = 0.0, EaseOut = 1.0 })
	wait(1.0)
end

function ChronosPolymorphChallengeStartPresentation( encounter, capturePointSwitch )
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )
end

function ChronosPolymorphChallengeEndPresentation( encounter )
	local chronosId = GetIdsByType({ Name = "Chronos_TyphonFight" })[1]
	local chronos = ActiveEnemies[chronosId]
	local typhonId = GetIdsByType({ Name = "TyphonHead" })[1]
	local typhon = ActiveEnemies[typhonId]

	if CurrentRun.Hero.IsDead then
		return
	end
	SessionMapState.ChronosPolymorphChallengeEndPresentation = true
	AddInputBlock({ Name = "ChronosPolymorphChallengeEndPresentation" })
	SetPlayerInvulnerable("ChronosPolymorphChallengeEndPresentation")
	HideCombatUI( "ChronosPolymorphChallengeEndPresentation" )

	SetColor({ Id = encounter.CapturePointId, Color = { 0.5, 0.5, 1.0, 1.0 } })
	SetScale({ Id = encounter.CapturePointId, Fraction = 0.8, Duration = 1.0, EaseIn = 0.0, EaseOut = 1.0 })
	SetAlpha({ Id = encounter.CapturePointId, Fraction = 0.0, Duration = 1.0, EaseIn = 0.0, EaseOut = 1.0 })
	thread(MarkObjectiveComplete, "CapturePointProgress")

	-- stop all Chronos AI
	if chronos ~= nil then
		killTaggedThreads(chronos.AIThreadName)
		killWaitUntilThreads(chronos.AIThreadName)
		chronos.AIBehavior = nil
		chronos.ActiveWeaponCombo = nil
		chronos.ChainedWeapon = nil
		chronos.ChainedWeaponOptions = nil
		chronos.ForcedWeaponInterrupt = nil
	end

	-- pause Typhon
	typhon.ForcedWeaponInterrupt = "TyphonHeadWait"
	notifyExistingWaiters(typhon.AIThreadName)
	SetThreadWait(typhon.AIThreadName, 0.01)

	-- music
	SetVolume({ Id = AudioState.MusicId, Value = 0.5, Duration = 1.0 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0 })

	wait ( 0.05 )

	SetGoalAngle({ Id = typhonId, Angle = 265 })
	AngleTowardTarget({ Id = chronosId, DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.ClearedBabalityVoiceLines )

	ClearCameraClamp({ LerpTime = 0.0 })
	AdjustZoom({ Fraction = 0.8, LerpTime = 0.1, })
	LockCamera({ Ids = { CurrentRun.Hero.ObjectId, chronosId }, Duration = 0.6 })

	wait( 0.5 )

	AddSimSpeedChange( "ChronosPolymorphChallengeEndPresentation", { Fraction = 0.2, LerpTime = 0.01, Priority = true } )

	-- Mel detonate nova and clear effect
	PlaySound({ Name = "/VO/MelinoeEmotes/EmotePoweringUp", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "MelinoeChronosPolymorphNovaFx", DestinationId = CurrentRun.Hero.ObjectId })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "ChronosPolymorphStun" })
	SetAnimation({ Name = "MelinoeCrossCast", DestinationId = CurrentRun.Hero.ObjectId })

	PlaySound({ Name = "/SFX/Menu Sounds/MenuMagicFlashMainMenu" })
	PlaySound({ Name = "/Leftovers/SFX/PlayerFullWipe" })

	Destroy({ Id = encounter.CapturePointId })
	encounter.CapturePointId = nil

	wait( 0.05 )

	-- knock Chronos  down

	Stop({ Id = chronosId })
	SetAnimation({ Name = "Enemy_Chronos_Knockdown_Start", DestinationId = chronosId })
	Stop({ Id = typhonId })
	SetAnimation({ Name = "Enemy_TyphonHead_StunnedStart", DestinationId = typhonId })

	wait( 0.2 )

	RemoveSimSpeedChange( "ChronosPolymorphChallengeEndPresentation", { LerpTime = 0.4 } )

	wait( 1.0 )

	SetVolume({ Id = AudioState.MusicId, Value = 1.0, Duration = 2.0 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 1 })

	--thread( PlayVoiceLines, Chronos.CriticalHealthVoiceLines, nil )

	wait( 1.0 )

	-- clear out Chronos
	SetAlpha({ Id = chronosId, Fraction = 0, Duration = 0.3 })
	CreateAnimation({ Name = "ChronosTeleportFxFront", DestinationId = chronosId })

	wait( 0.3 )

	if chronosId ~= nil then
		ActiveEnemies[chronosId].CannotDieFromDamage = false
		thread( Kill, ActiveEnemies[chronosId] ) -- Kill Chronos
	end

	SetAnimation({ Name = "Enemy_TyphonHead_StunnedEnd", DestinationId = typhonId })

	wait( 1.0 )

	LockCamera({ Ids = { CurrentRun.Hero.ObjectId, 768121 }, Duration = 1.0 })
	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.0, Duration = 999999 })

	wait( 2.0 )

	ShowCombatUI( "ChronosPolymorphChallengeEndPresentation" )
	RemoveInputBlock({ Name = "ChronosPolymorphChallengeEndPresentation" })
	SetPlayerVulnerable( "ChronosPolymorphChallengeEndPresentation" )
	SetUnitVulnerable( typhon, "TyphonHeadChronosCurse" )
	
	SessionMapState.ChronosPolymorphChallengeEndPresentation = nil

	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is nonsensical" })
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0 })

	-- resume Typhon
	--typhon.ForcedWeaponInterrupt = "TyphonHeadCenterEye"
	typhon.ChainedWeapon = nil
	typhon.ChainedWeaponOptions = nil
	SetThreadWait(typhon.AIThreadName, 0.01)
end

function HandleWrapping( eventSource, args )
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end

	args = args or {}
	
	local room = eventSource
	local encounter = room.Encounter
	local wrappingData = RoomData[room.Name].WrappingData or encounter.WrappingData
	local angle = args.Angle or -155

	if wrappingData.ObstacleWrapData ~= nil then
		for k, obstacleWrapData in pairs( wrappingData.ObstacleWrapData ) do
			for k, id in pairs( obstacleWrapData.Ids ) do
				local offset = CalcOffset(math.rad(angle), obstacleWrapData.ResetOffsetDistance)
				local resetTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = id, OffsetX = offset.X, OffsetY = offset.Y })
				obstacleWrapData.WrapCount = 0
				thread( WrapObstacle, id, obstacleWrapData, { ResetTargetId = resetTargetId, Angle = angle } )
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
					local offset = CalcOffset(math.rad(angle), i * 1750)
					local newObstacleId = SpawnObstacle({ Name = nextObstacleName, DestinationId = nextSpawnDestination.Id, Group = nextSpawnDestination.GroupName, OffsetX = offset.X, OffsetY = offset.Y })
					SetThingProperty({ Property = "StopsLight", Value = false, DestinationId = newObstacleId })
					SetThingProperty({ Property = "StopsUnits", Value = false, DestinationId = newObstacleId })
					if nextSpawnDestination.ObstacleHSVOverrides ~= nil and nextSpawnDestination.ObstacleHSVOverrides[nextObstacleName] ~= nil then
						SetHSV({ Id = newObstacleId, HSV = nextSpawnDestination.ObstacleHSVOverrides[nextObstacleName], ValueChangeType = "Absolute" })
					end
					if nextSpawnDestination.ObstacleColorOverrides ~= nil and nextSpawnDestination.ObstacleColorOverrides[nextObstacleName] ~= nil then
						SetColor({ Id = newObstacleId, Color = nextSpawnDestination.ObstacleColorOverrides[nextObstacleName], ValueChangeType = "Absolute" })
					end

					Move({ Id = newObstacleId, Angle = angle, Speed = spawnData.MoveSpeed or 500 })
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
			Move({ Id = newObstacleId, Angle = angle, Speed = spawnData.MoveSpeed or 500 })
			thread( DestroyOnDelay, { newObstacleId }, spawnData.MoveTime or 10 )

			local nextSpawnInterval = RandomFloat( spawnData.SpawnIntervalMin, spawnData.SpawnIntervalMax )
			wait(nextSpawnInterval, RoomThreadName)
		end
	end
end

function WrapObstacle( id, obstacleWrapData, args )

	if obstacleWrapData.WrapCount > 0 then
		Teleport({ Id = id, DestinationId = args.ResetTargetId, OffsetX = args.OvershootOffsetX })
	end

	Move({ Id = id, Angle = args.Angle, Speed = SessionMapState.WrappingMoveSpeed[id] or obstacleWrapData.MoveSpeed or 500 })

	if obstacleWrapData.MoveDistance ~= nil then
		local notifyName = "WrapObstacle"..id
		NotifyOutsideDistance({ Id = id, DestinationId = args.ResetTargetId, Distance = obstacleWrapData.MoveDistance, Notify = notifyName })
		waitUntil( notifyName )
		local distance = GetDistance({ Id = id, DestinationId = args.ResetTargetId })
		args.OvershootOffsetX = distance - obstacleWrapData.MoveDistance -- assuming movement only on the X axis...
	else
		wait( obstacleWrapData.MoveTime, RoomThreadName )
	end

	obstacleWrapData.WrapCount = obstacleWrapData.WrapCount + 1
	thread( WrapObstacle, id, obstacleWrapData, args )

end

function IcarusPreChoicePresentation( source, args )

	wait( 1.0 )

	SetAnimation({ Name = "Icarus_Offer_Start", DestinationId = source.ObjectId })
end

function IcarusPostChoicePresentation( screen, args )
	
	thread( PlayVoiceLines, GlobalVoiceLines.MiscEndVoiceLines_Icarus, nil )

	PlaySound({ Name = screen.Source.ConfirmSound or "/SFX/Menu Sounds/GodBoonChoiceConfirm" })

	wait( 0.02 )
	AdjustColorGrading({ Name = screen.Source.ColorGrade or "ItemGet", Duration = 0.2 })
	SetAnimation({ Name = screen.Source.UpgradeAcquiredAnimation or "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "ItemGetVignette", OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, Scale = 2.0, UseScreenLocation = true })
	wait( screen.Source.UpgradeAcquiredAnimationDelay or 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })

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
	source.BlockChatting = true
	RefreshUseButton( source.ObjectId, source )

	wait( 1 )

	SetAnimation({ Name = "Icarus_Offer_End", DestinationId = source.ObjectId })

	wait( 1.5 )

	thread( PlayVoiceLines, source.ExitVoiceLines )

	StopSecretMusicTheme( source )

	wait( args.WaitTime or 0.5 )

	StopStatusAnimation( source )

	SetAnimation({ Name = "Icarus_FlyExit_TakeOff", DestinationId = source.ObjectId })
	
	wait ( 0.36 )

	AdjustZLocation({ Id = source.ObjectId, Duration = 0.22, Distance = 800 })
	IgnoreGravity({ Id = source.ObjectId })

	wait ( 0.11 )

	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.11 })
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

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })

	PlaySound({ Name = "/SFX/WindGust", Delay = 0.6 })

	AdjustColorGrading({ Name = "LateAfternoon", Duration = 0.5 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.5 })

	for k, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if unit.EncounterStartVoiceLines ~= nil then
			thread( PlayVoiceLines, unit.EncounterStartVoiceLines, nil, unit )
		end
	end
	SessionMapState.IcarusPlayedEncounterStartLines = true

	IcarusFlyByPresentation( icarus, { TargetId = CurrentRun.Hero.ObjectId }, CurrentRun, { FlyByZHeight = 450, FlyByDuration = 1.0, FlyBySpeed = 4500, FlyByScale = 1.8, })

	-- thread( DisplayInfoBanner, nil, { Text = "IcarusMessage", Delay = 0.2, FadeColor = {1, 0, 0.7, 1} } )

	wait( 0.2, RoomThreadName )

	SecretMusicPlayer( icarus.ThemeMusic, { ParamNames = { "Keys", "Drums", } } )
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 0 })

	thread( function()
		wait( 0.3 )
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.5 })
		AdjustColorGrading({ Name = "Off", Duration = 3.0 })	
	end )
end

function IcarusAppearancePresentation( icarus )

	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })
	
	AngleTowardTarget({ Id = icarus.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Icarus_FlyExit_Landing", DestinationId = icarus.ObjectId })

	SetScale({ Id = icarus.ObjectId, Fraction = 1.0, Duration = 0 })
	AddToGroup({ Id = icarus.ObjectId, Name = "Standing", DrawGroup = true })
	RemoveFromGroup({ Id = icarus.ObjectId, Names = { "Combat_Menu_TraitTray_Overlay_Text" } })
	icarus.SkipInvulnerableOnHitPresentation = false

	AdjustZLocation({ Id = icarus.ObjectId, Distance = 800 - GetZLocation({ Id = icarus.ObjectId }), Duration = 0 })
	IgnoreGravity({ Id = icarus.ObjectId })

	AdjustZLocation({ Id = icarus.ObjectId, Distance = 0 - GetZLocation({ Id = icarus.ObjectId }), Duration = 0.22 })
	SetAlpha({ Id = icarus.ObjectId, Fraction = 1.0, Duration = 0.08 })

	wait( 0.22, RoomThreadName )

	ObeyGravity({ Id = icarus.ObjectId })
	SetUnitProperty({ DestinationId = icarus.ObjectId, Property = "CollideWithObstacles", Value = true })
	thread( PlayVoiceLines, icarus.EncounterEndVoiceLines, nil, icarus )

	wait( 1.4, RoomThreadName )
end

function IcarusFlyByPresentation( icarus, aiData, currentRun, args )

	if args.ReverseDirection then
		Teleport({ Id = icarus.ObjectId, DestinationId = aiData.TargetId, OffsetX = 2100, OffsetY = -1200 })
	else
		Teleport({ Id = icarus.ObjectId, DestinationId = aiData.TargetId, OffsetX = -2100, OffsetY = 1200 })
	end

	icarus.SkipInvulnerableOnHitPresentation = true
	local zHeight = args.FlyByZHeight or 500
	AdjustZLocation({ Id = icarus.ObjectId, Distance = zHeight - GetZLocation({ Id = icarus.ObjectId }) })
	IgnoreGravity({ Id = icarus.ObjectId })
	SetAnimation({ DestinationId = icarus.ObjectId, Name = "Icarus_Fly_FireLoop" })
	SetUnitProperty({ DestinationId = icarus.ObjectId, Property = "CollideWithObstacles", Value = false })

	local scale = args.FlyByScale or 1.0
	local prevScale = GetThingDataValue({ Id = icarus.ObjectId, Property = "Scale" })
	SetScale({ Id = icarus.ObjectId, Fraction = scale, Duration = 0.1 })
	SetAlpha({ Id = icarus.ObjectId, Fraction = 1.0, Duration = 0.3 })

	RemoveFromGroup({ Id = icarus.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = icarus.ObjectId, Name = "Combat_Menu_TraitTray_Overlay_Text", DrawGroup = true })

	local angle = 30
	if args.ReverseDirection then
		angle = 210
	end

	SetGoalAngle({ Id = icarus.ObjectId, Angle = angle, Duration = 0 })
	Move({ Id = icarus.ObjectId, Angle = angle, Speed = args.FlyBySpeed or 5000 })

	AIWait((args.FlyByDuration or 1.0) - 0.1, icarus, icarus.AIThreadName)

	SetAlpha({ Id = icarus.ObjectId, Fraction = 0.0, Duration = 0.1 })

	wait( 0.1, icarus, icarus.AIThreadName )

	Stop({ Id = icarus.ObjectId })
	ObeyGravity({ Id = icarus.ObjectId })
	AdjustZLocation({ Id = icarus.ObjectId, Distance = 0 - GetZLocation({ Id = icarus.ObjectId }) })
	SetScale({ Id = icarus.ObjectId, Fraction = prevScale, Duration = 0.5 })
	icarus.SkipInvulnerableOnHitPresentation = false
	SetUnitProperty({ DestinationId = icarus.ObjectId, Property = "CollideWithObstacles", Value = true })
	AddToGroup({ Id = icarus.ObjectId, Name = "Standing", DrawGroup = true })
	RemoveFromGroup({ Id = icarus.ObjectId, Names = { "Combat_Menu_TraitTray_Overlay_Text" } })
end


function HeraclesPreSpawnPresentation( heracles )

end


function HeraclesSpawnPresentation( )

	HideCombatUI("HeraclesIntro")

	local encounter = CurrentRun.CurrentRoom.Encounter
	local heracles = ActiveEnemies[encounter.HeraclesId]
	local dummyTarget = ActiveEnemies[encounter.DummyTargetId]

	-- before arrival

	local encounterData = EncounterData[encounter.Name]
	local spawnWaitDuration = encounterData.HeraclesSpawnWait or 1.5
	
	wait(spawnWaitDuration/2.5)
	AngleTowardTarget({ Id = dummyTarget.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	thread( InCombatText, dummyTarget.ObjectId, "Alerted", 0.45, { OffsetY = dummyTarget.HealthBarOffsetY, SkipShadow = true }  )
	PlaySound({ Name = dummyTarget.IsAggroedSound or "/EmptyCue", Id = dummyTarget.ObjectId, ManagerCap = 28 })
	wait(spawnWaitDuration/2.5)

	local teleportId = nil
	if ActiveEnemies[dummyTarget.ObjectId] == nil then
		teleportId = SelectSpawnPoint(CurrentRun.CurrentRoom, heracles, { SpawnNearId = CurrentRun.Hero.ObjectId, SpawnRadius = 500, SpawnRadiusMin = 100 })
	else
		teleportId = dummyTarget.ObjectId
	end

	SetPlayerInvulnerable( "HeraclesSpawnPresentation" )

	Teleport({ Id = heracles.ObjectId, DestinationId = teleportId })
	SetAnimation({ DestinationId = heracles.ObjectId, Name = "Heracles_Combat_Taunt" })

	ObeyGravity({ Id = heracles.ObjectId })
	ApplyUpwardForce({ Id = heracles.ObjectId, Speed = -3500 })

	PlaySound({ Name = "/SFX/Enemy Sounds/Heracles/EmotePowerCharging", Id = heracles.ObjectId })

	BloomRequestStart({ SourceName = "HeraclesSpawnPresentation", BloomType = "BlurryLight", Duration = 0.5 })

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
	CreateAnimation({ Name = "HydraTouchdownFx", DestinationId = heracles.ObjectId }) --nopkg

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1.5 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.5 })
	BloomRequestEnd({ SourceName = "HeraclesSpawnPresentation", Duration = 1.5 })

	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 1.5 })

	AddInputBlock({ Name = "HeraclesSpawnPresentation" })
	EndAutoSprint({ Halt = true, EndWeapon = true })
	SetPlayerInvulnerable( "HeraclesSpawnPresentation" )

	-- after arrival

	PanCamera({ Ids = heracles.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.03 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })
	PlaySound({ Name = "/Leftovers/SFX/GoalScoredNEW" })

	AngleTowardTarget({ Id = heracles.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.3, RoomThreadName )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = heracles.ObjectId })

	PlayVoiceLines( heracles.EntranceVoiceLines, nil, heracles )

	wait( 0.1, RoomThreadName )

	PanCamera({ Ids = heracles.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.03 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	wait( 0.5, RoomThreadName )

	ProcessTextLines( heracles, heracles.BossIntroTextLineSets )

	RemoveInputBlock({ Name = "HeraclesSpawnPresentation" })
	SetPlayerVulnerable( "HeraclesSpawnPresentation" )

	local textLines = GetRandomEligibleTextLines( heracles, heracles.BossIntroTextLineSets, GetNarrativeDataValue( heracles, "BossIntroTextLinePriorities" ) )
	PlayTextLines( heracles, textLines )

	SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 1 })

	ShowCombatUI("HeraclesIntro")

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	SetPlayerVulnerable( "HeraclesSpawnPresentation" )

	SetupAI(heracles )
end

function HeraclesEncounterStartPresentation( heracles )

	for k, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
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
end

function HeraclesObjectiveResultPresentation( heracles )
	local encounter = CurrentRun.CurrentRoom.Encounter
	if encounter.PlayerMoneyObjective ~= nil and encounter.PlayerMoneyObjective > 0 then
		thread( PlayVoiceLines, heracles.DuesPaidVoiceLines, nil, heracles )
		SetAnimation({ Name = "Heracles_Hub_Granting", DestinationId = heracles.ObjectId })
	end
	wait(1.5)
	thread( MarkObjectiveComplete, "PlayerMoney" )
end

function HeraclesExit( source, args )

	local heraclesId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Heracles_01" })

	if not CurrentRun.Hero.IsDead and heraclesId == nil then
		return
	end

	args = args or {}

	local heracles = ActiveEnemies[heraclesId]

	if heracles == nil then
		return
	end

	if heracles.Exiting then
		return
	end

	if args.SkipIfStillInteractable then
		if heracles.NextInteractLines ~= nil and not GameState.TextLinesRecord[heracles.NextInteractLines.Name] then
			return
		end
		if CanReceiveGift( heracles ) then
			-- Don't leave but unlock exits if only gifting left
			MapState.RoomRequiredObjects[heracles.ObjectId] = nil
			wait( 0.2 )
			if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
				UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
			end
			return
		end
	end

	UseableOff({ Id = heracles.ObjectId })
	heracles.SpecialInteractFunctionName = nil
	heracles.CanReceiveGift = false
	heracles.Exiting = true

	thread( PlayVoiceLines, heracles.ExitVoiceLines )
	wait( args.WaitTime or 3.0 )

	SetAnimation({ Name = "Heracles_Combat_Idle_Start", DestinationId = heracles.ObjectId })

	StopSecretMusicTheme( heracles )

	wait( 1.55 )

	SetAnimation({ Name = "Heracles_Combat_LeapExit", DestinationId = heracles.ObjectId })


	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 1 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1 })

	wait ( 0.62 )
	AdjustZLocation({ Id = heracles.ObjectId, Distance = 2000 - GetZLocation({ Id = heracles.ObjectId }), Duration = 0.2 })

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1.0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1.0 })

	ShakeScreen({ Speed = 200, Distance = 2, FalloffSpeed = 1000, Duration = 0.5 })

	wait ( 0.1 )
	SetAlpha({ Id = heracles.ObjectId, Fraction = 0.0, Duration = 0.1 })

	heracles.NextInteractLines = nil
	heracles.Mute = true
	UseableOff({ Id = heracles.ObjectId })
	MapState.RoomRequiredObjects[heracles.ObjectId] = nil
	SetUnitProperty({ DestinationId = heracles.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = heracles.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = heracles.ObjectId, Property = "StopsProjectiles", Value = false })
	RefreshUseButton( heracles.ObjectId, heracles )
	StopStatusAnimation( heracles )

	wait( 0.5, RoomThreadName )
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[heracles.ObjectId] = args.AnimationState
	end

	if not args.SkipObjective then
		thread( HandlePylonObjective, CurrentRun.CurrentRoom, args)
	end

	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function HeraclesRequiredKillPresentation ( encounter, victim, killer )
	if ScreenState.ActiveObjectives.PlayerMoney == nil then
		CheckObjectiveSet( "HeraclesChallenge" )
	end
	if ScreenState.ActiveObjectives.PlayerMoney ~= nil then
		local objectiveId = ScreenState.ActiveObjectives.PlayerMoney.ObjectId
		FlyTextToUI(
			encounter,
			{
				Amount = victim.HeraclesBounty,
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
	end
	
	local objectiveValue = encounter.PlayerMoneyObjective
	UpdateObjectiveDescription( "PlayerMoney", "Objective_PlayerMoney", "PlayerMoney", objectiveValue )
	UpdateObjective( "Objective_PlayerMoney", "PlayerMoney", objectiveValue )
end

function AthenaSpawnPresentation(encounter, args)
	local encounterData = EncounterData[encounter.Name]
	args = args or {}
	
	SetPlayerInvulnerable( "AthenaSpawnPresentation" )
	AddTimerBlock( CurrentRun, "AthenaPresence", { MapState = true } )
	local athena = DeepCopyTable( EnemyData.NPC_Athena_01 )
	local spawnPointId = SelectSpawnPoint( CurrentRun.CurrentRoom, athena, { SpawnNearId = CurrentRun.Hero.ObjectId, SpawnRadius = 700, SpawnRadiusMin = 400 })
	spawnPointId = spawnPointId or CurrentRun.Hero.ObjectId
	athena.ObjectId = SpawnUnit({ Name = "NPC_Athena_01", Group = "Standing", DestinationId = spawnPointId })
	athena.OccupyingSpawnPointId = spawnPointId
	local overrideRarity = {}
	if args.RarityLevelBonus then
		overrideRarity[TraitRarityData.WeaponRarityUpgradeOrder[args.RarityLevelBonus]] = 1
		athena.BoonRaritiesOverride = overrideRarity
		if args.RarityLevelBonus > 1 then
			athena.IgnoreTempRarityBonus = true
		end
	end
	SetupUnit( athena, CurrentRun, { IgnoreAI = true, IgnorePackages = true, } )
	SetAlpha({ Id = athena.ObjectId, Fraction = 0.0, Duration = 0 })
	AdjustZLocation({ Id = athena.ObjectId, Distance = 2000 - GetZLocation({ Id = athena.ObjectId }) })
	IgnoreGravity({ Id = athena.ObjectId })
	thread( PlayVoiceLines, athena.EncounterStartVoiceLines, nil, athena )

	UseableOff({ Id = athena.ObjectId })

	PlaySound({ Name = "/SFX/AthenaBoonChoice" })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedArthurChoir" })

	thread( DisplayInfoBanner, nil, { 
		Text = "AthenaMessage", 
		Delay = 0.2,
		TextFadeColor = {1, 0.8, 0.4, 1},
		AnimationName = "InfoBannerAthenaIn",
		AnimationOutName = "InfoBannerAthenaOut", 
		FontScale = 0.9,
	} )

	wait( 1.2 )

	AdjustColorGrading({ Name = "Gold", Duration = 2.5 })
	BloomRequestStart({ SourceName = "AthenaSpawnPresentation", BloomType = "AthenaDivineInterventionBloom", Duration = 2.5 })

	AdjustRadialBlurDistance({ Fraction = 0.5, Duration = 2.0 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 2.0 })

	wait( 2.0, RoomThreadName )


	Rumble({ Duration = 0.3, RightFraction = 0.17 })

	HideCombatUI("AthenaIntro")

	PanCamera({ Ids = athena.ObjectId, Duration = 1.0, EaseIn = 0.05, EaseOut = 0.03 })

	wait( 0.4, RoomThreadName )
	AngleTowardTarget({ Id = athena.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Athena_Leap_Entrance", DestinationId = athena.ObjectId })
	SetAlpha({ Id = athena.ObjectId, Fraction = 1.0, Duration = 0.05 })
	AdjustZLocation({ Id = athena.ObjectId, Distance = 0 - GetZLocation({ Id = athena.ObjectId }), Duration = 0.1 })
	wait( 0.1, RoomThreadName )

	MapState.BlockRespawns = true
	MapState.BlockSpawns = true
	CreateProjectileFromUnit({ Name = "AthenaLandingNova", Id = athena.ObjectId, })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.75 })

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.25 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.25 })
	BloomRequestEnd({ SourceName = "AthenaSpawnPresentation", Duration = 0.25 })
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })

	wait(1.0)

	ObeyGravity({ Id = athena.ObjectId })

	for id, enemy in pairs( ShallowCopyTable( RequiredKillEnemies ) ) do -- Avoid modification while iterating
		thread( DisplayDamageText, enemy, { DamageAmount = 9999, SourceProjectile = "Athena", IsCrit = true } )
		thread( Kill, enemy, { BlockRespawns = true } )
		waitUnmodified(0.01)
	end
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do -- Get aggroed, but not required enemies as well.
		if enemy.IsAggroed then
			thread( DisplayDamageText, enemy, { DamageAmount = 9999, SourceProjectile = "Athena", IsCrit = true } )
			thread( Kill, enemy, { BlockRespawns = true } )
			waitUnmodified(0.01)
		end
	end

	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })

	PlaySound({ Name = "/SFX/AthenaWrathHolyShield", Id = athena.ObjectId })
	ProcessTextLines( athena, athena.InteractTextLineSets )
	thread( PlayVoiceLines, athena.EncounterEndVoiceLines, nil, athena )

	wait( 0.7, RoomThreadName )

	CheckAvailableTextLines( athena )
	SetAvailableUseText( athena )

	ShowCombatUI("AthenaIntro")

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	SetPlayerVulnerable( "AthenaSpawnPresentation" )

	wait( 0.3, RoomThreadName )

	UseableOn({ Id = athena.ObjectId })
end

function AthenaExitPresentation( source, args )

	args = args or {}
	
	UseableOff({ Id = source.ObjectId })
	source.SpecialInteractFunctionName = nil
	source.CanReceiveGift = false
	source.NextInteractLines = nil
	RefreshUseButton( source.ObjectId, source )

	wait( 3.5 )

	-- SetAnimation({ Name = "Icarus_Offer_End", DestinationId = source.ObjectId })

	thread( PlayVoiceLines, source.ExitVoiceLines )

	AdjustColorGrading({ Name = "Gold", Duration = 1.5 })
	BloomRequestStart({ SourceName = "AthenaExitPresentation", BloomType = "AthenaDivineInterventionBloom", Duration = 1.5 })

	AdjustRadialBlurDistance({ Fraction = 0.3, Duration = 0.5 })
	AdjustRadialBlurStrength({ Fraction = 1.2, Duration = 0.5 })
	PlaySound({ Name = "/SFX/AthenaWrathHolyShield", Id = source.ObjectId })

	wait( args.WaitTime or 0.5 )

	SetAnimation({ Name = "Athena_Leap_Exit", DestinationId = source.ObjectId })

	wait ( 0.45 )
	AdjustZLocation({ Id = source.ObjectId, Distance = 2000 - GetZLocation({ Id = source.ObjectId }), Duration = 0.1 })

	wait ( 0.05 )
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.05 })

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.25 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.25 })
	BloomRequestEnd({ SourceName = "AthenaExitPresentation", Duration = 0.25 })
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })

	source.NextInteractLines = nil
	source.Mute = true
	UseableOff({ Id = source.ObjectId })
	MapState.RoomRequiredObjects[source.ObjectId] = nil
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = source.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = source.ObjectId, Property = "StopsProjectiles", Value = false })
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )
	RemoveScreenEdgeIndicator( source )
	
	RemoveTimerBlock( CurrentRun, "AthenaPresence" )
end

function MedeaMusicManager( eventSource, args )

	args = args or {}
	
	-- SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = args.SecretMusicSection or 0 })
	-- SetSoundCueValue({ Names = { "Keys" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })

end

function NemesisSpawnPresentation( eventSource, nemesis )

	AddInputBlock({ Name = "NemesisSpawnPresentation" })

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	end

	local encounter = eventSource
	SetAnimation({ Name = "Nemesis_Hub_Idle", DestinationId = nemesis.ObjectId })

	wait( 0.6, RoomThreadName )

	SetPlayerInvulnerable( "NemesisSpawnPresentation" )
	AddPlayerImmuneToForce( "NemesisSpawnPresentation" )

	-- this specifically affects NemesisCombat
	NemesisThemePresentation( eventSource, nemesis, { SkipBanner = true } )

	SetAnimation({ Name = "Nemesis_Hub_Equip", DestinationId = nemesis.ObjectId })
	AngleTowardTarget({ Id = nemesis.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	PanCamera({ Ids = nemesis.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.03, Retarget = true })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	wait( 0.35, RoomThreadName )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = nemesis.ObjectId })

	wait( 2.8, RoomThreadName )

	RemoveInputBlock({ Name = "NemesisSpawnPresentation" })
	SetPlayerVulnerable( "NemesisSpawnPresentation" )
	RemovePlayerImmuneToForce( "NemesisSpawnPresentation" )
	
	ProcessTextLines( nemesis, nemesis.CombatIntroTextLineSets )
	nemesis.TextLinesUseWeaponIdle = true
	local textLines = GetRandomEligibleTextLines( nemesis, nemesis.CombatIntroTextLineSets, GetNarrativeDataValue( nemesis, "CombatIntroTextLinePriorities" ) )
	PlayTextLines( nemesis, textLines )

end

function NemesisSpawnPresentationFields( eventSource )

	local nemesis = ActiveEnemies[eventSource.NemesisId]

	--HideCombatUI("NemesisIntro")
	SetPlayerInvulnerable( "NemesisSpawnPresentation" )
	AddPlayerImmuneToForce( "NemesisSpawnPresentation" )

	AdjustZLocation({ Id = nemesis.ObjectId, Distance = 1500 })
	IgnoreGravity({ Id = nemesis.ObjectId })
	SetAlpha({ Id = nemesis.ObjectId, Fraction = 0.0, Duration = 0.0 })

	--PlaySound({ Name = "/SFX/Enemy Sounds/Heracles/EmotePowerCharging", Id = nemesis.ObjectId })

	BloomRequestStart({ SourceName = "NemesisSpawnPresentationFields", BloomType = "BlurryLight", Duration = 0.5 })

	Rumble({ Duration = 0.3, RightFraction = 0.17 })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.35 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.35 })

	if not IsEmpty( SessionMapState.SkipEncounterIds ) then
		thread( SkipEncounterEndPresentation )
	end

	wait( 1.0, RoomThreadName )

	-- this specifically affects NemesisCombat
	NemesisThemePresentation( eventSource, nemesis, { SkipBanner = true } )
	
	ObeyGravity({ Id = nemesis.ObjectId })
	ApplyUpwardForce({ Id = nemesis.ObjectId, Speed = -2000 })
	SetAlpha({ Id = nemesis.ObjectId, Fraction = 1.0, Duration = 0.2 })
	SetAnimation({ DestinationId = nemesis.ObjectId, Name = "Nemesis_Combat_Entrance" })
	PlaySound({ Name = "/SFX/Player Sounds/MelWhooshDropIn", Id = nemesis.ObjectId })

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.5 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.5 })
	BloomRequestEnd({ SourceName = "NemesisSpawnPresentationFields", Duration = 1.5 })

	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 1.5 })

	AddInputBlock({ Name = "NemesisSpawnPresentation" })

	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	end

	-- after arrival

	PanCamera({ Ids = nemesis.ObjectId, Duration = 1.5, EaseIn = 0.03, EaseOut = 0.03 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	PlaySound({ Name = "/Leftovers/SFX/GoalScoredNEW" })

	wait( 0.5, RoomThreadName )

	PanCamera({ Ids = nemesis.ObjectId, Duration = 1.5, EaseIn = 0.03, EaseOut = 0.03 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	AngleTowardTarget({ Id = nemesis.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.35, RoomThreadName )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = nemesis.ObjectId })

	wait( 2.8, RoomThreadName )

	RemoveInputBlock({ Name = "NemesisSpawnPresentation" })

	ProcessTextLines( nemesis, nemesis.CombatIntroTextLineSets )
	nemesis.TextLinesUseWeaponIdle = true
	local textLines = GetRandomEligibleTextLines( nemesis, nemesis.CombatIntroTextLineSets, GetNarrativeDataValue( nemesis, "CombatIntroTextLinePriorities" ) )
	PlayTextLines( nemesis, textLines )
	
	SetPlayerVulnerable( "NemesisSpawnPresentation" )
	RemovePlayerImmuneToForce( "NemesisSpawnPresentation" )

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

	if not nemesis.TakingExitDoorId then
		AngleTowardTarget({ Id = nemesis.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		SetAnimation({ Name = nemesis.TurnInPlaceAnimation, DestinationId = nemesis.ObjectId })
	end

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

	CurrentRun.CurrentRoom.CancelReattachCameraOnInput = true
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

	nemesis.TextLinesUseWeaponIdle = nil
	nemesis.BlocksLootInteraction = false -- For Fields
	
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

		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "BetWinner", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, } )
		CreateAnimation({ Name = "MoneyShower", DestinationId = CurrentRun.Hero.ObjectId })

	elseif args.Result == "playerloss" then

		thread( InCombatTextArgs, { TargetId = nemesis.ObjectId, Text = "BetWinner", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, } )
		CreateAnimation({ Name = "MoneyShower", DestinationId = nemesis.ObjectId })

	end

end

-- see also: NemesisLeaveRoomPresentation
function NemesisTeleportExitPresentation( nemesis, args )
	args = args or {}

	if nemesis.Exiting then
		return
	end

	local nemesisId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Nemesis_01" })
	local nemesis = nemesis or ActiveEnemies[nemesisId]
	nemesis.Exiting = true

	while nemesis.InRelationshipAdvancedPresentation do
		wait( 0.2 )
	end

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

	wait( 0.92 )

	AdjustZLocation({ Id = nemesis.ObjectId, Duration = 0.20, Distance = 1000 })
	IgnoreGravity({ Id = nemesis.ObjectId })

	wait( 0.06 )
	SetUnitProperty({ DestinationId = nemesis.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = nemesis.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = nemesis.ObjectId, Property = "StopsProjectiles", Value = false })
	wait( 0.08 )
	SetAlpha({ Id = nemesis.ObjectId, Fraction = 0.0, Duration = 0.06 })

end

function ArachneExit( source, args )

	args = args or {}
	
	local arachneId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "NPC_Arachne_01", "NPC_Arachne_Home_01" } })
	local arachne = ActiveEnemies[arachneId]

	if arachne == nil then
		return
	end

	UseableOff({ Id = arachne.ObjectId })
	arachne.SpecialInteractFunctionName = nil
	arachne.CanReceiveGift = false

	thread( PlayVoiceLines, arachne.ExitVoiceLines )
	wait( args.WaitTime or 2.6 )

	CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = arachne.ObjectId })
	PlaySound({ Name = "/SFX/Player Sounds/FamiliarAppearPoof", Id = arachne.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/SpiderSkitter", Id = arachne.ObjectId })
	SetAlpha({ Id = arachne.ObjectId, Fraction = 0.0, Duration = 0.1 })
	SetAlpha({ Id = args.WebObstacle, Fraction = 0.0, Duration = 0.1 })

	wait( 0.1 )

	arachne.NextInteractLines = nil
	arachne.Mute = true
	UseableOff({ Id = arachne.ObjectId })
	MapState.RoomRequiredObjects[arachne.ObjectId] = nil
	SetUnitProperty({ DestinationId = arachne.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = arachne.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = arachne.ObjectId, Property = "StopsProjectiles", Value = false })
	RefreshUseButton( arachne.ObjectId, arachne )
	StopStatusAnimation( arachne )

	wait( 0.5, RoomThreadName )
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[arachne.ObjectId] = args.AnimationState
	end

end

function HeraclesBountySpawnPresentation( unit, bountyCount )
	local encounter = unit.Encounter
	if encounter == nil then
		return
	end
	local encounterData = EncounterData[encounter.Name] or encounter
	
	CreateAnimation({ Name = encounterData.HeraclesBountyAttachedAnimation, DestinationId = unit.ObjectId })

	if CheckCooldown( "HeraclesObjectiveText", 300 ) and bountyCount == 1 then 
		thread( InCombatTextArgs, { PreDelay = 0.5, Text = "BountyTarget", TargetId = CurrentRun.Hero.ObjectId, Duration = 2.5, OffsetY = -180, SkipRise = true } )
	end
	PlaySound({ Name = "/SFX/Enemy Sounds/GoldElemental/GoldElementalDeathSFX", Id = CurrentRun.Hero.ObjectId })

	unit.StopAnimationsOnDeath = unit.StopAnimationsOnDeath or {}
	table.insert(unit.StopAnimationsOnDeath, encounterData.HeraclesBountyAttachedAnimation)
end
