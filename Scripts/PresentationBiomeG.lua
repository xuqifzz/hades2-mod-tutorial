function CrawlerMiniBossKillPresentation( unit, args )

	AddTimerBlock( CurrentRun, "CrawlerMiniBossKillPresentation" )
	SetPlayerInvulnerable( "CrawlerMiniBossKillPresentation" )
	PlaySound({ Name = "/SFX/StabSplatterEndSequence" })
	PlaySound({ Name = "/SFX/Enemy Sounds/HydraHead/EmoteFinalDying1", Id = unit.ObjectId })

	GenericBossKillPresentation(unit, args)

	RemoveTimerBlock( CurrentRun, "CrawlerMiniBossKillPresentation" )
	SetPlayerVulnerable( "CrawlerMiniBossKillPresentation" )

end

function SirenKillPresentation( unit, args )
	GenericPresentation(unit, {
		SetSoundCueValues =
			{
				{
					Name = unit.MusicStem,
					Value = 0.0,
					AudioStateId = "MusicId",
					Duration = 1.0,
				}
			},
		})

	-- don't play the rest of this if you're too far away
	if GetDistance({ Id = unit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) < 550 then
		thread( SirenKillScreenEffects, unit )
	end
end

function SirenKillScreenEffects( unit, args )
	waitUnmodified( 0.25 )

	local lastKillFxInTime = 0.08
	local lastKillFxOutTime = 0.4

	AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0.85, Duration = lastKillFxInTime })
	AdjustFrame({ Duration = lastKillFxInTime, Fraction = 1.25 })
	AdjustFullscreenBloom({ Name = "LastKillBloom", Duration = 0 })
	AddSimSpeedChange( "LastKill", { Fraction = 0.08, LerpTime = lastKillFxInTime, Priority = true } )

	waitUnmodified( 0.6 )

	AdjustRadialBlurStrength({ Fraction = 0, Duration = lastKillFxOutTime })
	AdjustFrame({ Duration = lastKillFxOutTime, Fraction = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = lastKillFxOutTime })
	RemoveSimSpeedChange( "LastKill", { LerpTime = lastKillFxOutTime } )
	waitUnmodified(  0.2 )
end

function ScyllaKillPresentation( unit, args )
	SetAlpha({ Ids = GetIds({ Name = "StageLights" }), Fraction = 1.0, Duration = 1.0 }) -- Un-Dim lights
	for k, id in pairs(GetIdsByType({ Name = "CharybdisTentacle2" })) do
		thread( Kill, ActiveEnemies[id], { BlockRespawns = true } )
	end
	for k, id in pairs(GetIdsByType({ Name = "Charybdis_ScyllaFight" })) do
		thread( Kill, ActiveEnemies[id], { BlockRespawns = true } )
	end
	Activate({ Names = { "EndConcert" } })
	for i = 1,3 do
		SpawnObstacle({ Name = "OceanusCausticsScyllaDeath", DestinationId = unit.ObjectId, Group = "Combat_Menu_Additive" })
	end
	GameState.ScyllaDefeatMusicRecord[AudioState.MusicName] = true
	GenericBossKillPresentation( unit, args )
end

function ScyllaSpotlightPresentation( flagData, scylla )
	if not flagData then
		return
	end
	local targetId = flagData.Id

	SetPlayerInvulnerable("ScyllaSpotlightPresentation")

	RestoreSirenMusic(scylla)
	waitUnmodified( 0.2, RoomThreadName )

	if flagData.SoloMusicFunction ~= nil then
		CallFunctionName( flagData.SoloMusicFunction, scylla )
	end

	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	
	-- camera
	PanCamera({ Ids = { targetId }, Duration = 0.3 })
	FocusCamera({ Fraction = flagData.ZoomFraction or 0.9, Duration = 0.3, ZoomType = "Ease" })
	-- pause the game
	AddSimSpeedChange( "ScyllaSpotlight", { Fraction = 0.1, LerpTime = 0.31, Priority = true } )

	thread( InCombatText, targetId, "FeaturedArtist", 1.4, { ShadowScale = 0.66, OffsetY = -215, PreDelay = 0.2 } )
	PlaySound({ Name = "/SFX/PoseidonWrathWaveCrash", Id = targetId, Delay = 0.2 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3Distance", Id = targetId, Delay = 0.2 })

	local randomCheers =
	{
		"/SFX/ScyllaCrowdApplause1",
		"/SFX/ScyllaCrowdApplause2",
		"/SFX/ScyllaCrowdCrappyWoo1",
		"/SFX/ScyllaCrowdCrappyWoo3"
	}
	local randomCheer = RemoveRandomValue( randomCheers )

	if CurrentRun.CurrentRoom.Name == "G_Boss02" then
		randomCheer = "/SFX/TheseusCrowdCheer"
	end

	PlaySound({ Name = randomCheer, Delay = 0.5 })
	
	if flagData.SoloVoiceLines ~= nil then
		thread( PlayVoiceLines, flagData.SoloVoiceLines )
	end

	waitUnmodified( 3.2, RoomThreadName )

	RemoveSimSpeedChange( "ScyllaSpotlight", { LerpTime = 0.25 } )

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5, OffsetX = 0, OffsetY = 0, Retarget = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.5, ZoomType = "Ease" })

	SetPlayerVulnerable("ScyllaSpotlightPresentation")
	--waitUnmodified( 2.0, RoomThreadName )
end

function SoloSirenKeytarist( scylla )
	scylla.TargetMusicStemVolume = 0.65
	SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 0.9, Duration = 1 })
	SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.MusicId, Value = 1.0, Duration = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0.9, Duration = 1 })
end

function SoloSirenDrummer( scylla )
	scylla.TargetMusicStemVolume = 0.65
	SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 0.9, Duration = 1 })
	SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.MusicId, Value = 0.9, Duration = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 1.0, Duration = 1 })
end

function SoloSirenVocalist( scylla )
	scylla.TargetMusicStemVolume = 1.0
	SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 1.0, Duration = 1 })
	SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.MusicId, Value = 0.9, Duration = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 0.9, Duration = 1 })
end

function RestoreSirenMusic( scylla )
	scylla.TargetMusicStemVolume = 1.0
	SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 1.0, Duration = 0.2 })
	SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.MusicId, Value = 1.0, Duration = 0.2 })
	SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = 1.0, Duration = 0.2 })
end

function PlayScyllaTauntAnim( source, args )
	if source ~= nil then
		SetAnimation({ Name = "Enemy_Scylla_Taunt", DestinationId = source.ObjectId }) --nopkg
		-- wait(0.5)
		-- ShakeScreen({ Speed = 500, Distance = 2, Duration = 0.3 })
	end
end

function NarcissusPostChoicePresentation( screen, args )
	args = args or {}
	local heroId = CurrentRun.Hero.ObjectId
	local npcId = screen.Source.ObjectId
	FreezePlayerUnit( "NarcissusPostChoicePresentation" )
	AngleTowardTarget({ Id = heroId, DestinationId = npcId })
	wait(0.25)
	SetAnimation({ Name = "MelinoeSaluteToEquip", DestinationId = heroId })
	wait(0.25)
	thread( PlayVoiceLines, HeroVoiceLines.ThankingCharacterVoiceLines, true )
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })

	local shadeIds = GetIdsByType({ Name = "ShadeHubMIdle01" })
	local reactionCount = RandomInt( 10, 20 )
	for i=1, reactionCount do
		local shadeId = RemoveRandomValue( shadeIds )
		if RandomChance( 0.25 ) then
			local emoteName = GetRandomValue( { "StatusIconEyeRoll", "StatusIconGrief" } )
			thread( PlayEmoteSimple, nil, { TargetId = shadeId, AnimationName = emoteName, OffsetZ = 60, Delay = RandomFloat( 0.5, 1.1 ) } )
		else
			thread( NarcissusAdmirerHeartPresentation, shadeId )
		end
	end

	wait(0.1)
	UnfreezePlayerUnit( "NarcissusPostChoicePresentation" )
end

function NarcissusAdmirersPresentation( source, args )
	local shadeIds = GetIdsByType({ Name = "ShadeHubMIdle01" })
	SetObstacleProperty({ DestinationIds = shadeIds, Property = "IgnoredByPathfinders", Value = true })
	while true do
		local shadeId = GetRandomValue( shadeIds )
		NarcissusAdmirerHeartPresentation( shadeId )
		wait( RandomFloat( 0.5, 1.5 ) )
	end
end

function NarcissusAdmirerHeartPresentation( sourceId )
	local heartsPerBurst = RandomInt( 1, 3 )
	for i=1, heartsPerBurst do
		CreateAnimation({ DestinationId = sourceId, Name = "StatusIconAdmire", OffsetZ = 60 })
		wait( RandomFloat( 0.1, 0.3 ) )
	end
end

function ResetScyllaMusicStem( scylla, args )

	args = args or {}
	scylla.TargetMusicStemVolume = scylla.TargetMusicStemVolume or 1

	if args.Delay then
		wait(args.Delay)
	end

	SetSoundCueValue({ Names = { scylla.MusicStem }, Id = AudioState.MusicId, Value = scylla.TargetMusicStemVolume, Duration = args.Duration or 1 })
end

function RoomEntranceCrawlerMiniBoss( currentRun, currentRoom )

	local crawlerId = 568815

	AddInputBlock({ Name = "RoomEntranceCrawlerMiniBoss" })

	EnterBiomeGRoomPresentation(currentRun, currentRoom)

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = crawlerId })
	AngleTowardTarget({ Id = crawlerId, DestinationId = CurrentRun.Hero.ObjectId })

	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or 2.0
	wait(0.03)

	PanCamera({ Id = 558001, Duration = roomIntroSequenceDuration + 1, EaseOut = 0, OffsetX = 150, OffsetY = -200 })
	AdjustZoom({ Fraction = 0.85, LerpTime = 2.0 })
	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true } )
	end

	thread( PlayVoiceLines, GlobalVoiceLines.CrawlerMiniBossEncounterStartVoiceLines, true )

	wait(roomIntroSequenceDuration)

	wait( 0.5 )

	SecretMusicPlayer( "/EmptyCue" )

	if GameState.EncountersOccurredCache.MiniBossCrawler > 1 then
		wait( 0.5 )
	else
		--SetAnimation({ Name = "ZagreusInteractionThoughtful", DestinationId = CurrentRun.Hero.ObjectId })
		wait( 2.5 )
	end

	AngleTowardTarget({ Id = crawlerId , DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/QuickSnap", Id = crawlerId })
	thread( InCombatText, crawlerId, "Alerted", 0.45, { SkipShadow = true } )
	CreateAnimation({ Name = "EliteUnitStatus2", DestinationId = crawlerId })
	wait( 0.25 )
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar", Id = crawlerId })
	SetAnimation({ Name = "Enemy_Crawler_RoarLoop", DestinationId = crawlerId })
	wait( 0.02 )

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.2 })
	Shake({ Id = crawlerId, Distance = 2, Speed = 300, Duration = 3, FalloffSpeed = 3000 })
	ShakeScreen({ Speed = 500, Distance = 5, FalloffSpeed = 2000, Duration = 1.0 })
	FocusCamera({ Fraction = 1.0, ZoomType = "Overshoot", Duration = 0.17 })
	AdjustZoom({ Fraction = currentRoom.ZoomFraction, LerpTime = 0.17 })
	CreateAnimation({ Name = "CrawlerSpawnsHowl", DestinationId = crawlerId })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

	wait( 0.5 )
	thread( EndTinyVerminRadialBlur )
	SetAnimation({ Name = "Enemy_Crawler_RoarReturnToIdle", DestinationId = crawlerId })

	SecretMusicPlayer( "/Music/IrisMinibossMusic" )
	SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = 2 })

	if GameState.EncountersOccurredCache.MiniBossCrawler > 1 then
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, ZoomType = "Ease", Duration = 1.0 })
		wait( 1.0 )
	else
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.0 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, ZoomType = "Ease", Duration = 2.0 })
		wait( 2.0 )
	end

	thread(SetupBoss, ActiveEnemies[crawlerId])

	if GetNumShrineUpgrades( "MinibossCountShrineUpgrade" ) >= 1 then
		ActivatePrePlacedUnits( nil, { Ids = GetInactiveIdsByType({ Name = "Crawler_Shadow" }) } )
	end

	RemoveInputBlock({ Name = "RoomEntranceCrawlerMiniBoss" })
	UnblockCombatUI("BossEntrance")
end

function RoomEntranceBossBiomeG( currentRun, currentRoom, args )
	args = args or {}

	HideCombatUI("BossEntrance")
	SetAnimation({ DestinationId = args.ScyllaId, Name = "Enemy_Scylla_Intro_FireLoop" })
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	AdjustFullscreenBloom({ Name = "NewType09" })
	local dropShadow = SpawnObstacle({ Name = "DrownedChambersEntranceShadowFade", DestinationId =  currentRoom.HeroEndPoint, OffsetY = -12, OffsetX = 0 })
	SetAlpha({ Id = dropShadow, Fraction = 0.2, Duration = 0.01 })
	SetScale({ Id = dropShadow, Fraction = 0.05, Duration = 0.01 })
	SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 0, Duration = 0.2 })
	wait(0.03)

	SetAlpha({ Id = dropShadow, Fraction = 0.80, Duration = 0.8 })
	SetScale({ Id = dropShadow, Fraction = 0.20, Duration = 0.8 })
	if currentRoom.HeroEndPoint ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = args.ScyllaId })
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	end
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0, OffsetY = -150 })
	AdjustZLocation({ Id = currentRun.Hero.ObjectId, Distance = 1800, Duration = 0.0 })
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.2, EaseIn = 0, Retarget = true})
	wait(0.03)

	ApplyUpwardForce({ Id = currentRun.Hero.ObjectId, Speed = -100 })
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation( "RoomTransitionOut_Down" )
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.3)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	wait(0.03)

	SetAnimation({ Name = "Melinoe_Drop_Entrance_Fire_NoEquip", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = dropShadow, Fraction = 0, Duration = 0.03 })
	ShakeScreen({ Speed = 150, Distance = 6, Duration = 0.15, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.18, Duration = 0.8 }, } )
	
	wait (0.33)

	CreateAnimation({ Name = "MelEntranceSplash", DestinationId = CurrentRun.Hero.ObjectId })

	SetAnimation({ DestinationId = args.ScyllaId, Name = "Enemy_Scylla_Intro_End" })

	if not PlayVoiceLines( currentRoom.EnterVoiceLines or GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true ) then
		wait(1.5)
	end

	-- wait( roomIntroSequenceDuration )
	UnblockCombatUI("BossEntrance")
end

function RoomEntranceBoss02BiomeG( currentRun, currentRoom, args )
	thread( RoomEntranceBoss02TentaclePresentation, currentRun, currentRoom, args )
	RoomEntranceBossBiomeG( currentRun, currentRoom, args )
end

function RoomEntranceBoss02TentaclePresentation( currentRun, currentRoom, args )
	AngleTowardTarget({ Ids = args.TentacleIdsOrdered, DestinationId = 609649 })
	SetAlpha({ Ids = args.TentacleIdsOrdered, Fraction = 0 })
	SetAnimation({ DestinationIds = args.TentacleIdsOrdered, Name = "Enemy_CharybdisTentacle_Hidden" })
	wait( 0.5 )
	for i, tentacle in ipairs( args.TentacleIdsOrdered ) do
		SetAlpha({ Id = tentacle, Fraction = 1, Duration = 0.1 })
		SetAnimation({ DestinationId = tentacle, Name = "Enemy_CharybdisTentacle2_Surface" })
		if i % 2 == 0 then
			wait (0.3)
		end
	end
end

function ExitBiomeGRoomPresentation( currentRun, exitDoor )
	AddInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , false, "LeaveRoom" )
	HideCombatUI( "ExitBiomeGRoomPresentation" )
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

	thread( PlayVoiceLines, HeroVoiceLines.OceanusExitVoiceLines, true )

	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait (0.01)

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })
	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.1, OffsetY = -50, EaseOut = 0 })
	
	wait( 0.5 )	

	SetAnimation({ Name = "Melinoe_Drop_Exit_Start", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = 0.5 })
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "Tallness", Value = 400 })

	wait( 0.35 )

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading" })
	local args = {}
	args.SuccessDistance = 20
	args.DisableCollision = true
	local exitPath = {}
	table.insert( exitPath, exitDoor.ObjectId )
	thread( MoveHeroAlongPath, exitPath, args )	
	
	wait( 0.20 )
	
	thread( SlightDescent )
	PanCamera({ Id = exitDoor.ObjectId, Duration = 1.2, OffsetY = 85, Retarget = true})
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.25 }, } )

	FullScreenFadeOutAnimation( "RoomTransitionIn_Down" )

	WaitForSpeechFinished()

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleCombatControl( { "AdvancedTooltip" } , true, "LeaveRoom" )	
end

function EnterBiomeGRoomPresentation( currentRun, currentRoom )
	AddInputBlock({ Name = "BiomeGRoomEntrance" })
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	AdjustFullscreenBloom({ Name = "NewType09" })

	local dropShadow = SpawnObstacle({ Name = "DrownedChambersEntranceShadowFade", DestinationId =  currentRoom.HeroEndPoint, OffsetY = -12, OffsetX = 0 })
	SetAlpha({ Id = dropShadow, Fraction = 0.2, Duration = 0.01 })
	SetScale({ Id = dropShadow, Fraction = 0.05, Duration = 0.01 })
	wait(0.03)
	SetAlpha({ Id = dropShadow, Fraction = 0.80, Duration = 0.8 })
	SetScale({ Id = dropShadow, Fraction = 0.20, Duration = 0.8 })
	if currentRoom.HeroEndPoint ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	end
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0, OffsetY = -150 })
	AdjustZLocation({ Id = currentRun.Hero.ObjectId, Distance = 1800, Duration = 0.0 })
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.2, EaseIn = 0, Retarget = true})
	wait(0.03)

	ApplyUpwardForce({ Id = currentRun.Hero.ObjectId, Speed = -100 })
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation( "RoomTransitionOut_Down" )
	SetAnimation({ Name = "Melinoe_Drop_Exit_End", DestinationId = CurrentRun.Hero.ObjectId })

	--local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	wait(0.3)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	wait(0.03)

	thread( PlayVoiceLines, currentRoom.Encounter.EnterVoiceLines or currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	thread(DelayedRemoveInputBlock, 0.35, "BiomeGRoomEntrance")
	wait (0.33)
	SetAnimation({ Name = "Melinoe_Drop_Entrance_Fire", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = dropShadow, Fraction = 0, Duration = 0.03 })
	ShakeScreen({ Speed = 150, Distance = 6, Duration = 0.15, FalloffSpeed = 500, Angle = 90 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.18, Duration = 0.8 }, } )
	CreateAnimation({ Name = "MelEntranceSplash", DestinationId = CurrentRun.Hero.ObjectId })
end

function ScyllaActivatePresentation(enemy)
	SetAlpha({ Ids = { 616658 }, Fraction = 0, Duration = 1.0 }) -- Destroy Spotlight
	SetAlpha({ Ids = GetIds({ Name = "StageLights" }), Fraction = 0.25, Duration = 1.0 }) -- Dim lights
end

function CharybdisScyllaFightStartPresentation( enemy )
	wait( 4.0, RoomThreadName )

	SetAnimation({ Name = "Enemy_Charybdis_SpitFullStart", DestinationId = enemy.ObjectId })

	wait( 2.5, RoomThreadName )

	PlaySound({ Name = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_13_SFX", Id = enemy.ObjectId })
	SetAlpha({ Id = enemy.ObjectId, Fraction = 1, Duration = 0 })
	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.2 })
	Shake({ Id = enemy.ObjectId, Distance = 2, Speed = 300, Duration = 3, FalloffSpeed = 3000 })
	ShakeScreen({ Speed = 500, Distance = 5, FalloffSpeed = 2000, Duration = 1.0 })
	CreateAnimation({ Name = "CrawlerSpawnsHowl", DestinationId = enemy.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

	wait( 2.5, RoomThreadName )
	thread( EndTinyVerminRadialBlur )
end

function FloodEncounterStartPresentation( eventSource, encounter )

	if AudioState.FloodSoundId == nil then
		AudioState.FloodSoundId = PlaySound({ Name = "/Leftovers/Object Ambiences/WaterRushingLarge" })
	end

	wait( 2.0, RoomThreadName )
	if encounter.Completed then
		if AudioState.FloodSoundId ~= nil then
			StopSound({ Id = AudioState.FloodSoundId, Duration = 5.0 })
			AudioState.FloodSoundId = nil
		end
		return
	end

	thread( PlayVoiceLines, HeroVoiceLines.TrapsActivatedVoiceLines, true )

	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )
	thread( FloodEncounterStartEndAudio )
end

function FloodEncounterStartEndAudio()
	wait( 5.0, RoomThreadName )
	if AudioState.FloodSoundId ~= nil then
		StopSound({ Id = AudioState.FloodSoundId, Duration = 5.0 })
		AudioState.FloodSoundId = nil
	end
end

function FloodTrapFireStartPresentation(args)
	args = args or {}
	ShakeScreen({ Speed = 900, Distance = 1, FalloffSpeed = 2000, Duration = 5.8 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 7.1 }, } )
	PlaySound({ Name = "/SFX/FloodTrapPreFire" })

	local floodTraps = GetIdsByType({ Name =  "FloodTrap" })
	for k, unitId in pairs( floodTraps ) do
		if ActiveEnemies[unitId] ~= nil then
			Shake({ Id = unitId, Distance = 3, Speed = 300, Duration = 2.0 })
			SetAnimation({ Name = "FloodTrapPreparingToFire", DestinationId = unitId })
			PlaySound({ Id = unitId, Name = "/SFX/DusaHiss"})
		end
	end
	wait(args.WaitDuration or 2.0)
end

function FloodTrapFireEndPresentation()
	-- nothing yet!
end

function CharybdisTentacleHidePresentation( enemy )
	--wait( 2.2, "CharybdisTentacleHide"..tostring(enemy.ObjectId) )
	SetAnimation({ Name = "Enemy_CharybdisTentacle2_Burrow", DestinationId = enemy.ObjectId })
	ClearEffect({ Id = enemy.ObjectId, All = true })
	wait( 0.98, "CharybdisTentacleHide"..tostring(enemy.ObjectId) )
	SetAlpha({ Id = enemy.ObjectId, Fraction = 0, Duration = 0.3 })
end
function CharybdisTentacleSurfacePresentation( enemy, currentRun, aiStage )
	wait( aiStage.WaitDuration or 2.2, "CharybdisTentacleHide"..tostring(enemy.ObjectId) )
	SetAnimation({ Name = "Enemy_CharybdisTentacle2_Surface", DestinationId = enemy.ObjectId })
	killTaggedThreads("CharybdisTentacleHide"..tostring(enemy.ObjectId) )
	SetAlpha({ Id = enemy.ObjectId, Fraction = 1, Duration = 0.0 })
	wait( 1.2 )
end

function CharybdisRevealPresentation( source )

	local enemyCameraId = 793541
	local enemyId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "Charybdis_ScyllaFight" })

	SetAnimation({ DestinationId = ScreenAnchors.DialogueBackgroundId, Name = "DialogueBackgroundOut" })

	waitUnmodified( 0.1 )
	Destroy({ Id = ScreenAnchors.DialogueBackgroundId })

	PanCamera({ Id = enemyCameraId, Duration = 2.3, EaseIn = 0, EaseOut = 0.03 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	waitUnmodified( 0.3 )

	SetAnimation({ Name = "Enemy_Charybdis_SpitFullStart", DestinationId = enemyId })

	waitUnmodified( 2.5, RoomThreadName )

	PlaySound({ Name = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_12_SFX", Id = enemyId })
	PlaySound({ Name = "/SFX/Enemy Sounds/Charybdis/EmoteAlerted", Id = enemyId })
	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.2 })
	Shake({ Id = enemyId, Distance = 2, Speed = 300, Duration = 3, FalloffSpeed = 3000 })
	ShakeScreen({ Speed = 500, Distance = 5, FalloffSpeed = 2000, Duration = 1.0 })
	CreateAnimation({ Name = "CrawlerSpawnsHowl", DestinationId = enemyId })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

	waitUnmodified( 2.5, RoomThreadName )
	thread( EndTinyVerminRadialBlur )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.3 })

	waitUnmodified( 0.5 )
	CreateDialogueBackground()

end

function SetupStageLights(room)

	room.LightIds = GetIdsByType({ Name = "ScyllaStageLightFlash" })

	room.FireSpawnIds = GetIds({ Name = "StageFire" })
end

function FlashRoomLights(markerData, args)

	if SessionMapState.IsPaused then
		return
	end

	local room = CurrentRun.CurrentRoom
	if room.LightIds == nil then
		return
	end

	for i = 1, 15 do
		SetAlpha({ Ids = room.LightIds, Fraction = 0.25, Duration = 0.1 })
		waitUnmodified(0.15)
		SetAlpha({ Ids = room.LightIds, Fraction = 1.0, Duration = 0.1 })
		waitUnmodified(0.15)
	end
	SetAlpha({ Ids = GetIds({ Name = "StageLights" }), Fraction = 0.25, Duration = 0.1 }) -- Dim lights
end

function FlashRoomFire(markerData, args)

	if SessionMapState.IsPaused then
		return
	end

	local room = CurrentRun.CurrentRoom
	if room.FireSpawnIds == nil then
		return
	end

	local soundId = nil

	for i = 1, 4 do
		for k, id in pairs(room.FireSpawnIds) do
			CreateAnimation({ DestinationId = id, Name = "EMScyllaFlame" })
		end
		if soundId ~= nil then
			StopSound({ Id = soundId, Duration = args.StopSoundOnFinishFade or 0 })
		end
		if args.Sound ~= nil then
			soundId = PlaySound({ Name = args.Sound })
		end
		waitUnmodified(1.5)
	end

	if soundId ~= nil then
		StopSound({ Id = soundId, Duration = args.StopSoundOnFinishFade })
	end
end

function CharybdisGrowl( markerData, args )
	local charybdisId = GetIdsByType({ Name = "Charybdis_ScyllaFight" })[1]
	if charybdisId ~= nil and ActiveEnemies[charybdisId] then
		PlaySound({ Name = args.Sound })
	end
end

GlobalVoiceLines.SummonOdysseusVoiceLines =
{
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "ScyllaAboutOdysseusQuest01" },
			},
		},
		{
			PreLineWait = 0.6,
			ObjectType = "Scylla",
			AllowTalkOverTextLines = true,

			{ Cue = "/VO/Scylla_0295", Text = "Odysseus..." },
		},
		{
			PreLineWait = 0.4,
			ObjectType = "NPC_Odysseus_01",
			PreLineAnim = "Odysseus_Greet",
			AllowTalkOverTextLines = true,

			{ Cue = "/VO/Odysseus_0566", Text = "Scylla and the Sirens..." },
		},
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "ScyllaAboutOdysseusQuest02" },
			},
		},
		{
			PreLineWait = 0.6,
			ObjectType = "Scylla",
			AllowTalkOverTextLines = true,

			{ Cue = "/VO/Scylla_0300", Text = "Hello again, sailor." },
		},
		{
			PreLineWait = 0.4,
			ObjectType = "NPC_Odysseus_01",
			PreLineAnim = "Odysseus_Greet",
			AllowTalkOverTextLines = true,

			{ Cue = "/VO/Odysseus_0566", Text = "Scylla and the Sirens..." },
		},
	},
	-- Polyphemus
	{
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasAny = { "PolyphemusAboutOdysseusQuest01" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "N_Boss01", "N_Boss02" },
				},
			},
			{
				PreLineWait = 0.4,
				ObjectType = "NPC_Odysseus_01",
				PreLineAnim = "Odysseus_Greet",
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/Odysseus_0570", Text = "It's been a while, Polyphemus." },
			},
		},
	},
	-- Circe
	{
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasAny = { "CirceAboutOdysseusQuest01" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_Story01" },
				},
			},
			{
				PreLineWait = 0.4,
				ObjectType = "NPC_Odysseus_01",
				PreLineAnim = "Odysseus_Greet",
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/Odysseus_0574", Text = "Hello again..." },
			},
		},
	},
}
GlobalVoiceLines.UnSummonOdysseusVoiceLines =
{
	-- Circe
	{
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasAny = { "CirceAboutOdysseusQuest01" },
				},
			},
			{
				PreLineWait = 0.4,
				ObjectType = "NPC_Odysseus_01",
				PreLineAnim = "Odysseus_Greet",
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/Odysseus_0580", Text = "That's all. Goodbye..." },
			},
		},
	},
}
function SummonOdysseus( source, args )
	args = args or {}
	local odysseus = DeepCopyTable( EnemyData.NPC_Odysseus_01 )
	local partnerId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "NPC_Circe_01", "Polyphemus", "Scylla" }, })

	if args.SummonTargetIds ~= nil and args.SummonTargetIds[CurrentRun.CurrentRoom.Name] ~= nil then
		odysseus.ObjectId = SpawnUnit({ Name = "NPC_Odysseus_01", Group = "Standing", DestinationId = args.SummonTargetIds[CurrentRun.CurrentRoom.Name], })
	else
		odysseus.ObjectId = SpawnUnit({ Name = "NPC_Odysseus_01", Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = -180, OffsetY = -120, })
	end

	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 0, Duration = 0.2 })
	SetupUnit( odysseus, CurrentRun, { IgnoreAI = true, IgnoreAssert = true, } )
	UseableOff({ Id = odysseus.ObjectId })
	SetUnitProperty({ DestinationId = odysseus.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = odysseus.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = odysseus.ObjectId, Property = "StopsProjectiles", Value = false })
	AngleTowardTarget({ Id = odysseus.ObjectId, DestinationId = partnerId, CompleteAngle = true })
	SetAlpha({ Id = odysseus.ObjectId, Fraction = 0, Duration = 0 })

	wait( 0.3 )

	CreateAnimation({ Name = "OdysseusTeleportFx", DestinationId = odysseus.ObjectId })
	CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = odysseus.ObjectId, OffsetY = -100 })
	PlaySound({ Name = "/SFX/Player Sounds/FamiliarAppearPoof", DestinationId = odysseus.ObjectId })

	wait(0.1)

	SetAlpha({ Id = odysseus.ObjectId, Fraction = 1, Duration = 0.3 })

	PlayVoiceLines( GlobalVoiceLines.SummonOdysseusVoiceLines )
	waitUnmodified( 0.5 )
	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 1, Duration = 0.0 })

end

function UnSummonOdysseus( source, args )
	args = args or {}

	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 0, Duration = 0.25 })
	local odysseusId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Odysseus_01" })
	MapState.RoomRequiredObjects[odysseusId] = nil
	PlayVoiceLines( GlobalVoiceLines.UnSummonOdysseusVoiceLines )

	CreateAnimation({ Name = "OdysseusTeleportFx", DestinationId = odysseusId })
	CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = odysseusId, OffsetY = -100 })
	PlaySound({ Name = "/SFX/Player Sounds/FamiliarAppearPoof", DestinationId = odysseusId })

	wait(0.1)

	SetAlpha({ Id = odysseusId, Fraction = 0, Duration = 0.1 })

	wait(1)
	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 1, Duration = 0.25 })
	ActiveEnemies[odysseusId] = nil
	Destroy({ Id = odysseusId })

end

function ScyllaFinalStandPresentation()
	CurrentRun.CurrentRoom.ZoomFraction = CurrentRun.CurrentRoom.ZoomFraction * 1.2
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1.0, ZoomType = "Ease" })
end

GlobalVoiceLines.AcquireMixerForCirceQuestVoiceLines =
{
	Queue = "Interrupt",
	PreLineWait = 0.45,
	GameStateRequirements =
	{
		{
			PathFalse = { "GameState", "Flags", "AcquiredMixerForCirceQuest" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "CirceAboutScyllaQuest01" }
		},
		{
			Path = { "GameState", "SpentShrinePointsCache" },
			Comparison = ">=",
			Value = 10,
		},
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

	{ Cue = "/VO/MelinoeField_4335", Text = "Circe wanted me to curse one of these Pearls...", IgnoreMute = true, },
	{ Cue = "/VO/MelinoeField_4336", Text = "{#Emph}May your ambitions... {#Prev}no. I mustn't...", PreLineWait = 0.65, IgnoreMute = true, BreakIfPlayed = true },
}

function UseScyllaPearl( usee, args, user )
	if IsGameStateEligible( nil, GlobalVoiceLines.AcquireMixerForCirceQuestVoiceLines.GameStateRequirements ) then
		ScyllaQuestPearlPresentation( usee, args, user )
	else
		UseConsumableItem( usee )
	end
end

function ScyllaQuestPearlPresentation( usee, args, user )

	thread( PlayVoiceLines, GlobalVoiceLines.AcquireMixerForCirceQuestVoiceLines )

	args = args or {}
	AddInputBlock({ Name = "MelUsedSystemObject" })
	HideUseButton( usee.ObjectId, usee )
	UseableOff({ Id = usee.ObjectId })

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
  	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })

  	wait( 2.7 )
	
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
	SetAnimation({ Name = "Melinoe_Witchcraft_Start", DestinationId = CurrentRun.Hero.ObjectId, })

	wait(3.2)

	StopSound({ Id = loopingSoundId, Duration = 0.4 })
	loopingSoundId = nil

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 1 })

	StopAnimation({ Name = vignetteAName, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	StopAnimation({ Name = "NightmareEdgeFxSpawner", DestinationId = CurrentRun.Hero.ObjectId })

	SetAnimation({ Name = "MelTalkBrooding01", DestinationId = CurrentRun.Hero.ObjectId, })

	AdjustFullscreenBloom({ Name = "FullscreenFlash2", Duration = 0.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1 })

	wait( 1.9 )

	SetAnimation({ Name = "MelTalkBrooding01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId, })

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	
	wait( 0.8, RoomThreadName )

	RemoveInputBlock({ Name = "MelUsedSystemObject" })

	GameState.Flags.AcquiredMixerForCirceQuest = true
	SetAnimation({ Name = "MelinoeInteractWeaponless", DestinationId = CurrentRun.Hero.ObjectId, })
	usee.PlayInteract = false
	UseConsumableItem( usee )
end

function ScyllaNewSongPresentation( source, args )
	SetPlayerInvulnerable("ScyllaNewSongPresentation")

	-- text setup
	local textX = 100 + ScreenCenterNativeOffsetX
	local textY = ScreenHeight - ScreenCenterNativeOffsetY - 380
	local songTextId = CreateScreenObstacle({ Name = "BlankObstacle", X = textX, Y = textY, Alpha = 0.0 })
	local textArgs =
	{
		Id = songTextId,
		Justification = "Left",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {5, 5},
		OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
		Font = "P22UndergroundSCMedium",
		FontSize = 36,
		AutoSetDataProperties = false,
		OpacityWithOwner = true,
	}
	CreateTextBox( MergeTables( { Text = "SongVideo01_BandName" }, textArgs ) )
	CreateTextBox( MergeTables( { Text = "SongVideo01_SongTitle", OffsetY = 70 }, textArgs ) )
	CreateTextBox( MergeTables( { Text = "SongVideo01_Album", OffsetY = 140 }, textArgs ) )
	textArgs.FontSize = 24
	CreateTextBox( MergeTables( { Text = "SongVideo01_Label", OffsetY = 205 }, textArgs ) )

	-- start the song!
	local drummerId = GetIdsByType({ Name = "SirenDrummer" })[1]
	local keytaristId = GetIdsByType({ Name = "SirenKeytarist" })[1]
	local roomData = RoomData[CurrentRun.CurrentRoom.Name]
	SetMusicSection( 2 )
	SetSoundCueValue({ Names = roomData.DefaultMusicParams or { "Guitar", "Bass", "Drums" }, Id = AudioState.MusicId, Value = 1, Duration = 0.5 })

	CutsceneAddLetterbox( { Silent = true } )
	wait( 0.2, RoomThreadName )
	
	-- camera
	PanCamera({ Id = source.ObjectId, Duration = 18, OffsetY = -300, Retarget = true })
	FocusCamera({ Fraction = 1.0, Duration = 18, ZoomType = "Ease" })

	wait( 4.3, RoomThreadName )

	SetSoundPosition({ Id = AudioState.MusicId, Position = 451 })
	PlaySound({ Name = "/SFX/ScyllaCrowdApplause1", })

	wait( 2.5, RoomThreadName )

	SetAnimation({ Name = "Enemy_SirenKeytar_NewSong_Start", DestinationId = keytaristId })
	SetAnimation({ Name = "Enemy_SirenDrummer_NewSong_Start", DestinationId = drummerId })

	wait( 2.0, RoomThreadName )


	SetAlpha({ Id = songTextId, Fraction = 1.0, Duration = 1.0 })

	wait( 4.0, RoomThreadName )

	SetAnimation({ Name = "Enemy_SirenDrummer_NewSong_Start", DestinationId = drummerId })

	wait( 1.0, RoomThreadName )

	SetAnimation({ Name = "Enemy_Scylla_NewSong_Start", DestinationId = source.ObjectId })

	CreateAnimation({ Name = "StageSpotlight", DestinationId = source.ObjectId, Group = "FX_Add_Top" })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", source.ObjectId })

	wait( 1, RoomThreadName )
	
	SetAlpha({ Id = songTextId, Fraction = 0.0, Duration = 1.0 })
	thread( DestroyOnDelay, { songTextId }, 1.0 )

	wait( 4, RoomThreadName )

	SetAnimation({ Name = "Enemy_SirenDrummer_NewSong_Start", DestinationId = drummerId })

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 4, Retarget = true })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 4, ZoomType = "Ease" })

	wait( 2, RoomThreadName )

	SetAlpha({ Ids = { ScreenAnchors.LetterBoxTop, ScreenAnchors.LetterBoxBottom }, Fraction = 0, Duration = 1.5 })

	wait( 1, RoomThreadName )

	SetAnimation({ Name = "MelinoeEquip", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 1, RoomThreadName )

	StopAnimation({ Name = "StageSpotlight", DestinationId = source.ObjectId, })
	SetAnimation({ Name = "Enemy_Scylla_NewSong_End", DestinationId = source.ObjectId })
	SetAnimation({ Name = "Enemy_SirenKeytar_NewSong_End", DestinationId = keytaristId })
	SetPlayerVulnerable("ScyllaNewSongPresentation")
end