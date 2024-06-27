function ExtraDoorEncounterStartPresentation( eventSource, args )
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

	EndMusic( AudioState.MusicId, AudioState.MusicName, 0.3 )
	SecretMusicPlayer( "/Music/ErebusChallengeMusic_MC" )
	SetSoundCueValue({ Names = { "Guitar", "Bass", "Drums" }, Id = AudioState.SecretMusicId, Value = 1 })
	-- SetSoundCueValue({ Names = { "Section", }, Id = AudioState.SecretMusicId, Value = 2 })

	SurvivalEncounterStartPresentation( encounter, 0, "PerfectClear", "FullscreenAlertColorDark", "PerfectClearAboutToStartVoiceLines", "PerfectClearEncounterStartVoiceLines" )

end

function PerfectClearEncounterEndPresentation( eventSource )
	local encounter = eventSource
	EndMusic( AudioState.SecretMusicId, SecretMusicName )
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil
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

	SurvivalEncounterStartPresentation( challengeEncounter, 0 )
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

	thread( PlayVoiceLines, GlobalVoiceLines.ChallengeEncounterClearedVoiceLines, true )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })

	EndMusic( AudioState.SecretMusicId, SecretMusicName )
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

	--thread( HadesSpeakingPresentation, eventSource, { VoiceLines = GlobalVoiceLines.SurvivalEncounterSurvivedVoiceLines } )
	thread( ResumeMusic, { Duration = 0.2, Delay = 3.0 } )
	wait(3.0, RoomThreadName)
end

function HadesSpeakingPresentation( eventSource, args )
	args = args or {}
	wait( args.StartDelay or 1.0, RoomThreadName )
	LoadVoiceBank({ Name = "Intercom" })
	eventSource.LineHistoryName = eventSource.LineHistoryName or args.LineHistoryName
	eventSource.SubtitleColor = eventSource.SubtitleColor or args.SubtitleColor or Color.ChronosVoice
	PlayVoiceLines( args.VoiceLines, false, eventSource, { OnPlayedSomethingFunctionName = "DoHadesSpeakingPresentation", OnPlayedSomethingFunctionArgs = args } )
end

function DoHadesSpeakingPresentation( eventSource, args )

	if not args.BlockColorGrade then
		AdjustColorGrading({ Name = args.ColorGrade or "Alert", Duration = 0 })
	end
	if args.UseSurvivalPresentation then
		thread( SurvivalEncounterStartPresentation )
		wait(1)
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

	local hadesOverlay = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX - 420, Y = ScreenCenterY, Group = "Overlay" })
	SetScale({ Id = hadesOverlay, Fraction = 1 })
	SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 0 })
	Move({ Id = hadesOverlay, Angle = 270, Speed = 5 })
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

	AdjustColorGrading({ Name = "Team05", Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.5 })

	for k, unit in pairs( ActiveEnemies ) do
		if unit.EncounterStartVoiceLines ~= nil then
			thread( PlayVoiceLines, unit.EncounterStartVoiceLines, nil, unit )
		end
	end

	thread( DisplayInfoBanner, nil, { Text = "ArtemisMessage", Delay = 0.2, FadeColor = {0, 1, 0.7, 1} } )

	wait( 0.5, RoomThreadName )

	SecretMusicPlayer( EnemyData.NPC_Artemis_01.ThemeMusic, { ParamNames = { "Keys", "Drums", } } )
	SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 0 })

	thread( function()
		wait( 0.5 )
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.5 })
		AdjustColorGrading({ Name = "Off", Duration = 3.0 })	
	end )
end

function ArtemisAppearancePresentation( artemis )

	-- SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })
	
	AngleTowardTarget({ Id = artemis.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "TeleportDisappear", DestinationId = artemis.ObjectId })
	
	wait( 0.1, RoomThreadName )

	SetAlpha({ Id = artemis.ObjectId, Fraction = 1.0, Duration = 0 })
	thread( PlayVoiceLines, artemis.EncounterEndVoiceLines, nil, artemis )

	wait( 0.4, RoomThreadName )
	
	SetAnimation({ Name = "Artemis_Appear", DestinationId = artemis.ObjectId })

	wait( 1.0, RoomThreadName )	

end

function ArtemisFirstAppearancePresentation( artemis )

	AddInputBlock({ Name = "ArtemisAppearancePresentation" })
	SetPlayerInvulnerable( "ArtemisAppearancePresentation" )

	HideCombatUI( "ArtemisFirstAppearancePresentation" )
	CutsceneAddLetterbox()
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })


	-- SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })

	PanCamera({ Ids = artemis.ObjectId, Duration = 1.95, EaseIn = 0.05, EaseOut = 0.3 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	wait( 1.0, RoomThreadName )
	
	AngleTowardTarget({ Id = artemis.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "TeleportDisappear", DestinationId = artemis.ObjectId })
	
	wait( 0.1, RoomThreadName )

	SetAlpha({ Id = artemis.ObjectId, Fraction = 1.0, Duration = 0 })
	thread( PlayVoiceLines, artemis.EncounterEndVoiceLines, nil, artemis )

	wait( 0.4, RoomThreadName )
	
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
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.35 })

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


function ShoppingFidgetPresentation( unit )
	while unit.Shopping do
		thread( PlayEmoteSimple, unit, { AnimationName = "StatusIconDisgruntled", Delay = 0.5, ChanceToPlay = 0.5, OffsetZ = 160 } )
		local fidgetInterval = RandomFloat( unit.ShopEventData.FidgetIntervalMin, unit.ShopEventData.FidgetIntervalMax )
		wait( unit.ShopEventData.BrowsingVoiceLinesDelay )
		thread( PlayVoiceLines, unit.BrowsingVoiceLines, true )
		fidgetInterval = fidgetInterval - unit.ShopEventData.BrowsingVoiceLinesDelay
		wait( fidgetInterval )
	end
end

function ShoppingSuccessPresentation( unit, args )
	args = args or {}
	thread( PlayVoiceLines, unit.PurchasedVoiceLines, true )
	if args.InstantPurchase then
		thread( PlayVoiceLines, GlobalVoiceLines.FrustratedVoiceLines, true )
	end
	DebugPrint({ Text = "Shopping success!" })
end

function ShoppingSuccessNemesisPresentation( unit, args )
	args = args or {}
	thread( PlayVoiceLines, unit.PurchasedVoiceLines, true )
	if args.InstantPurchase then
		thread( PlayVoiceLines, GlobalVoiceLines.FrustratedVoiceLines, true )
	end
	SetAnimation({ Name = "Nemesis_Hub_Interact", DestinationId = unit.ObjectId })
	DebugPrint({ Text = "Shopping success!" })
end

function ShoppingSuccessItemPresentation( item )
	PlaySound({ Name = "/Leftovers/Menu Sounds/StoreBuyingItem" })
	if item == nil then
		return
	end
	if item.AcquireText then
		thread( InCombatText, item.ObjectId, item.AcquireText )
	end
	if item.ConsumeFx ~= nil then
		CreateAnimation({ Name = item.ConsumeFx, DestinationId = item.ObjectId })
	end
	PlaySound({ Name = item.ConsumeSound or "/SFX/GyroHealthPickupMunch", Id = item.ObjectId })
	--CreateAnimation({ Name = "ThanatosTeleport", DestinationId = item.KitId })
end

function ShoppingFailedPresentation( unit )
	thread( PlayVoiceLines, unit.PurchaseStolenVoiceLines, true )
	-- thread( PlayEmoteSimple, unit, { AnimationName = "StatusIconDisgruntled", Delay = 0.5, ChanceToPlay = 1, OffsetZ = 160 } )
	DebugPrint({ Text = "Shopping failed!" })
end

function ArachneCombatDrumCheck( unit )
	local anyEnemy = false
	for id, enemy in pairs( ActiveEnemies ) do
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


function MoveHeroToNPCFrontAngle( args )
	if args == nil then
		return
	end
	local offsetAngle = GetAngle({ Id = args.ObjectId })
	local offset = CalcOffset( math.rad (offsetAngle), args.Distance or 300)
	local targetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId, Group = "Scripting", OffsetX = offset.X, OffsetY = offset.Y })
	local notifyName = "HeroAngleWithMoveOrder"
	Move({ Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, SuccessDistance = 32 })
	NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, Distance = 32, Notify = notifyName, Timeout = args.Timeout })
	waitUntil( notifyName )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.ObjectId })
	Stop({ Id = CurrentRun.Hero.ObjectId })
end


function MoveHeroToArtemisFrontAngle( args )
	if args == nil then
		args = { }
	end
	local targetIdGroup = GetIdsByType({ Name = "NPC_Artemis_Field_01" })  
	local artemisId = targetIdGroup[1]
	local offsetAngle = GetAngle({ Id = artemisId })
	local offset = CalcOffset( math.rad (offsetAngle), args.Distance or 150 )
	local targetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = artemisId, Group = "Scripting", OffsetX = offset.X, OffsetY = offset.Y })
	local notifyName = "HeroAngleWithMoveOrder"
	--CreateAnimation({ Name = "InspectPointLoop", DestinationId = targetId })
	Move({ Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, SuccessDistance = 32 })
	NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, Distance = 32, Notify = notifyName, Timeout = args.Timeout or 3.5 })
	waitUntil( notifyName )
	wait( 0.040 )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = artemisId })
	wait( 0.885 )
end

function AngleNPCToHero( source )
	local npcId = source.ObjectId
	local arcThreshold = 50
	local facingAngle = GetAngle({ Id = npcId })
	local angleToTarget = GetAngleBetween({ Id = npcId, DestinationId = CurrentRun.Hero.ObjectId })
	local arcDistance = CalcArcDistance( facingAngle, angleToTarget )
	DebugPrint({ Text = tostring(arcDistance) })
	if arcDistance > arcThreshold then
		AngleTowardTarget({ Id = npcId, DestinationId = CurrentRun.Hero.ObjectId })
		SetAnimation({ Name = source.TurnInPlaceAnimation, DestinationId = npcId })
	end
end