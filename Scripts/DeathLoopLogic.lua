
function KillHero( victim, triggerArgs )
	
	local killer = triggerArgs.AttackerTable

	thread( CheckOnDeathPowers, victim, killer, triggerArgs.SourceWeapon )

	for k, spawnThreadName in pairs( CurrentRun.CurrentRoom.SpawnThreads ) do
		killTaggedThreads( spawnThreadName )
	end
	CurrentRun.CurrentRoom.SpawnThreads = {}
	killWaitUntilThreads( "RequiredKillEnemyKilledOrSpawned" )
	killWaitUntilThreads( "AllRequiredKillEnemiesDead" )
	killWaitUntilThreads( "AllEncounterEnemiesDead" )
	killWaitUntilThreads( "RequiredEnemyKilled" )
	killWaitUntilThreads( UIData.BoonMenuId )
	ClearGameplayElapsedTimeMultipliers()
	ClearPauseMenuTakeover()

	EndAmbience( 0.5 )
	EndMusic( AudioState.MusicId, AudioState.MusicName, triggerArgs.MusicEndTime or 0.0 )

	if killer == nil then
		killer = {}
		killer.Name = triggerArgs.AttackerName
		killer.ObjectId = triggerArgs.AttackerId
	end

	local killedByName = killer.Name or triggerArgs.SourceWeapon
	CurrentRun.KilledByName = killedByName
	GameState.LastKilledByName = killedByName or GameState.LastKilledByName

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAnimation({ Name = "ZagreusDeadStartBlood", DestinationId = CurrentRun.Hero.ObjectId })
		return
	end

	AddTimerBlock( CurrentRun, "HandleDeath" )
	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	end
	ClearHealthShroud()
	SessionMapState.HandlingDeath = true
	CurrentRun.Hero.IsDead = true
	CurrentRun.ActiveBiomeTimer = false
	CurrentRun.ActiveBiomeTimerKeepsake = false

	if ShouldIncrementEasyMode() then
		GameState.EasyModeLevel = GameState.EasyModeLevel + 1
	end
	if not CurrentRun.Cleared then -- Already recorded if cleared
		RecordRunStats()
	end

	InvalidateCheckpoint()

	FinishTargetMarker( killer )

	ResetObjectives()

	if killer.Name ~= nil and killer.ObjectId ~= nil and not killer.SkipModifiers then
		GameState.CauseOfDeath = GetGenusName( killer )
	end

	local deathPresentationFunctionName = "DeathPresentation"
	CallFunctionName( deathPresentationFunctionName, CurrentRun, killer, triggerArgs )

	AddInputBlock({ Name = "MapLoad" })

	if CurrentRun.Cleared then
		wait(0.5)
		-- PlaySound({ Name = "/Music/IrisVictoryStingerLARGE" })
		if ConfigOptionCache.DemoMode then
			PlaySound({ Name = "/Music/IrisVictoryStingerSMALL" })
			OpenMenu({ Name = "AnnouncementScreen", MessageId = "RunCleared_MessageTechTest", SignatureId = "AnnouncementSignature" })
		elseif CurrentRun.BiomesReached.F then
			PlaySound({ Name = "/Music/IrisVictoryStingerMEDIUM" })
			if not GameState.EnemyKills.Eris then
				OpenMenu({ Name = "AnnouncementScreen", MessageId = "RunCleared_Message01B", SignatureId = "AnnouncementSignature" })
			else
				OpenMenu({ Name = "AnnouncementScreen", MessageId = "RunCleared_Message01", SignatureId = "AnnouncementSignature" })
			end
		else
			PlaySound({ Name = "/Music/IrisVictoryStingerSMALL" })
			OpenMenu({ Name = "AnnouncementScreen", MessageId = "RunCleared_Message02", SignatureId = "AnnouncementSignature" })
		end
		waitUntil( "AnnouncementScreen" )
	end

	CurrentRun.CurrentRoom.EndingHealth = CurrentRun.Hero.Health
	table.insert( CurrentRun.RoomHistory, CurrentRun.CurrentRoom )
	UpdateRunHistoryCache( CurrentRun, CurrentRun.CurrentRoom )

	GameState.Resources.Money = 0
	CurrentRun.NumRerolls = GetTotalHeroTraitValue( "RerollCount" )
	CurrentRun.NumTalentPoints = GetTotalHeroTraitValue("TalentPointCount")
	CurrentRun.ShrineUpgradesDisabled = {}

	GamePhaseTick( { Ticks = GetDeathGamePhaseTicks(), SkipGarden = true })
	SessionMapState.HandlingDeath = false
	CurrentRun.Hero.Health = CurrentRun.Hero.MaxHealth
	CurrentRun.Hero.HealthBuffer = 0
	CurrentRun.Hero.Mana = CurrentRun.Hero.MaxMana
	CurrentRun.Hero.ReserveManaSources = {}
	
	if CurrentRun.Hero.Weapons.WeaponLob then
		ReloadAmmo({Name = "WeaponLob"})
	end
	for resourceName, resourceData in pairs( ResourceData ) do
		if resourceData.RunResource then
			GameState.Resources[resourceName] = 0
		end
	end
	local currentRoom = CurrentRun.CurrentRoom
	local deathMap = GameData.HubMapName
	GameState.LocationName = HubRoomData.BaseHub.SaveProfileLocationText
	RandomSetNextInitSeed()
	for deathMapName, deathMapData in pairs( HubRoomData ) do
		if deathMapData.OnDeathLoadRequirements ~= nil then
			for k, gameStateRequirements in pairs( deathMapData.OnDeathLoadRequirements ) do
				if IsGameStateEligible( CurrentRun, gameStateRequirements ) then
					deathMap = deathMapName
					break
				end
			end
		end
	end
	CurrentRun.Hero.PreDeathTraits = CurrentRun.Hero.Traits
	RequestSave({ StartNextMap = deathMap, DevSaveName = CreateDevSaveName( CurrentRun, { StartNextMap = deathMap, PostDeath = true, } ), SendSave = true })
	ClearUpgrades()
	SetConfigOption({ Name = "FlipMapThings", Value = false })

	LoadMap({ Name = deathMap, ResetBinks = true })
end

function ShouldIncrementEasyMode()
	if ConfigOptionCache.EasyMode and not CurrentRun.Cleared and not CurrentRun.BountyCleared and not CurrentRun.Hero.TraitDictionary.SurfacePenalty then
		return true
	end
	return false
end

function StartDeathLoop( currentRun )
	UnloadVoiceBanks({ Name = "MelinoeField" })
	ToggleCombatControl( CombatControlsDefaults, false, "DeathLoopStart" )
	RestorePackagedBountyGameState()
	
	local hubBiomeName = "Hub"
	GameState.BiomeVisits[hubBiomeName] = (GameState.BiomeVisits[hubBiomeName] or 0) + 1
	currentRun.BiomesReached[hubBiomeName] = true
	
	currentRun.BlockDeathAreaTransitions = true
	DeathAreaRoomTransition( HubRoomData[GameData.HubMapName], { SkipShowUI = true, } )

	if currentRun.ReturnedByBoat then
		StartDeathLoopFromBoatPresentation( currentRun )
	else
		StartDeathLoopPresentation( currentRun )
	end

	local notifyName = "ReattachCameraOnInput"
	NotifyOnPlayerInput({ Notify = notifyName })
	waitUntil( notifyName )
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0, FromCurrentLocation = true, })
	
	ToggleCombatControl( CombatControlsDefaults, true, "DeathLoopStart" )
	ShowCombatUI()
end

function DeathAreaSwitchRoom( source, args )
	AddInputBlock({ Name = "DeathAreaSwitchRoom" })
	UseableOff({ Id = source.ObjectId })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, All = true, BlockAll = true, })
	CurrentRun.NextHeroStartPoint = args.HeroStartPoint
	CurrentRun.NextHeroEndPoint = args.HeroEndPoint
	LeaveHubRoomPresentation( CurrentRun, source )
	
	for obstacleId, obstacle in pairs( MapState.ActiveObstacles ) do
		if obstacle.AIThreadName ~= nil then
			killTaggedThreads( obstacle.AIThreadName )
		end
		if obstacle.AINotifyName ~= nil then
			killWaitUntilThreads( obstacle.AINotifyName )
		end
	end

	if not SessionState.InFlashback then
		RequestSave({ StartNextMap = args.Name, DevSaveName = CreateDevSaveName( CurrentRun, { StartNextMap = args.Name } ) })
	end
	SetSoundSource({ Id = AmbientMusicId }) -- Remove until new source is created in the next room

	if args.PreLoadFunctionName ~= nil then
		CallFunctionName( args.PreLoadFunctionName, source, args )
	end

	local nextRoomData = HubRoomData[args.Name]
	RemoveInputBlock({ Name = "DeathAreaSwitchRoom" })
	LoadMap({ Name = args.Name })
end

function SetupCamera( source, args )
	args = args or {}
	if source.CameraZoomWeights ~= nil then
		for id, weight in pairs( source.CameraZoomWeights ) do
			SetCameraZoomWeight({ Id = id, Weight = weight, ZoomSpeed = 1.0 })
		end
	end
	AdjustZoom({ Fraction = source.ZoomFraction or 1.0, LerpTime = args.LerpTime })
	LockCamera({ Ids = { CurrentRun.Hero.ObjectId }, Duration = args.Duration })
end

function DeathAreaRoomTransition( source, args )

	args = args or {}
	AddInputBlock({ Name = "DeathAreaTransition" })
	PreviousDeathAreaRoom = CurrentHubRoom
	CurrentHubRoom = source
	SetConfigOption({ Name = "BlockGameplayTimer", Value = true })

	UpdateTraitSummary()

	local currentRun = CurrentRun
	SetupHeroObject( CurrentHubRoom )

	if CurrentHubRoom.RichPresence ~= nil then
		SetRichPresence({ Key = "status", Value = CurrentHubRoom.RichPresence })
		SetRichPresence({ Key = "steam_display", Value = CurrentHubRoom.RichPresence })
	end

	FadeOut({ Color = Color.Black, Duration = 0 })
	SetupCamera( CurrentHubRoom )
	SwitchActiveUnit({ Id = currentRun.Hero.ObjectId })

	if CurrentHubRoom.AmbientMusicParams ~= nil then
		for param, value in pairs( CurrentHubRoom.AmbientMusicParams ) do
			SetSoundCueValue({ Id = AmbientMusicId, Name = param, Value = value, Duration = 0.5 })
		end
	end
	SetVolume({ Id = AmbientMusicId, Value = CurrentHubRoom.AmbientMusicVolume, Duration = 0.5 })
	LoadVoiceBanks( CurrentHubRoom.SpeakerName )

	ResetObjectives()
	RunEventsGeneric( CurrentHubRoom.StartUnthreadedEvents, CurrentHubRoom )

	local musicTargetIds = GetIdsByType({ Name = "NPC_Orpheus_01" })
	if IsEmpty( musicTargetIds ) then
		musicTargetIds = GetIdsByType({ Name = "HeroStart" })
	end
	SetSoundSource({ Id = AmbientMusicId, DestinationIds = musicTargetIds })
	if AmbientMusicSource ~= nil and not IsEmpty( musicTargetIds ) then
		AmbientMusicSource.ObjectId = musicTargetIds[1]
	end

	StartRoomPreLoadBinks({
		Run = currentRun,
		Room = CurrentHubRoom
	})

	RunEvents( CurrentHubRoom )
	AssignObstacles( CurrentHubRoom )
	CheckInspectPoints( currentRun, CurrentHubRoom )
	StartTriggers( CurrentHubRoom, CurrentHubRoom.DistanceTriggers )

	if CurrentHubRoom.RemoveDashFireFx then
		SetWeaponProperty({ WeaponName = "RushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "UnblockedBlinkFx", Value = "null", ValueChangeType = "Absolute" })
	end

	if currentRun.BlockDeathAreaTransitions then
		currentRun.BlockDeathAreaTransitions = false
	elseif not source.SkipStartRoomPresentation then
		StartRoomPresentation( currentRun, CurrentHubRoom )
		FadeIn({ Duration = 0.5 })
	end

	RemoveInputBlock({ Name = "DeathAreaTransition" })

	if CurrentHubRoom.CheckObjectives ~= nil then
		for k, objectiveName in pairs( CurrentHubRoom.CheckObjectives ) do
			CheckObjectiveSet( objectiveName )
		end
	end

	if not args.SkipShowUI then
		ShowCombatUI()
	end

	CheckAutoObjectiveSets(currentRun, "RoomStart")
end

function UnlockDeathAreaInteractables()

	local shopIds = { 50056 }
	local fateIds = { 50057 }

	if GetCompletedRuns() >= 2 then
		Activate({ Ids = shopIds })
	end

	if GetCompletedRuns() >= 4 then
		Activate({ Ids = fateIds })
	end

end

function UseEscapeDoor( usee, args )
	AddInputBlock({ Name = "UseEscapeDoor" })
	if args.MarkObjectiveComplete ~= nil then
		MarkObjectiveComplete( args.MarkObjectiveComplete )
	end
	StartNewRunPresentation( usee, args )
	StartOver( args )
	RemoveInputBlock({ Name = "UseEscapeDoor" })
end

function StartOver( args )

	AddInputBlock({ Name = "StartOver" })

	for index, familiarName in ipairs( FamiliarOrderData ) do
		local familiarData = FamiliarData[familiarName]
		local familiar = familiarData.Unit
		if familiar then
			CleanupEnemy( familiar )
			familiarData.Unit = nil
		end
	end

	local currentRun = CurrentRun
	EndRun( currentRun )
	CurrentHubRoom = nil
	PreviousDeathAreaRoom = nil
	currentRun = StartNewRun( currentRun, { StartingBiome = args.StartingBiome or "F", ForcedRewards = args.ForcedRewards, ActiveBounty = args.ActiveBounty, RunOverrides = args.RunOverrides } )
	StopSound({ Id = AudioState.AmbientMusicId, Duration = 1.0 })
	AudioState.AmbientMusicId = nil
	AudioState.AmbientTrackName = nil
	ResetObjectives()

	SetConfigOption({ Name = "FlipMapThings", Value = false })
	SetConfigOption({ Name = "BlockGameplayTimer", Value = false })

	AddTimerBlock( currentRun, "StartOver" )
	
	RequestSave({ StartNextMap = currentRun.CurrentRoom.Name, SaveName = "_Temp", DevSaveName = CreateDevSaveName( currentRun ) })
	ValidateCheckpoint({ Value = true })

	RemoveInputBlock({ Name = "StartOver" })
	RemoveTimerBlock( currentRun, "StartOver" )
	AddInputBlock({ Name = "MapLoad" })
	AddTimerBlock( CurrentRun, "MapLoad" )

	LoadMap({ Name = currentRun.CurrentRoom.Name, ResetBinks = true })

end

function SpawnSkelly( waitTime )

	if MapState.SkellySpawned then
		return
	end
	MapState.SkellySpawned = true
	wait( waitTime or 3.0, RoomThreadName )
	ActivatePrePlaced( nil, { LegalTypes = { "NPC_Skelly_01" } } )
	CurrentRun.SkellySpawned = true
	wait( 2.5, RoomThreadName )
	CheckConversations()

end

function ClearMapBlockers( eventSource, args )
	if args.DeleteGroups then
		for k, groupName in pairs(args.DeleteGroups) do
			Destroy({ Ids = GetIds({ Name = groupName }) })
		end
	end
	if args.SetClamps ~= nil then
		CurrentHubRoom.CameraClamps = args.SetClamps
	end
end

function NPCLittering( source, args )

	if not CurrentRun.NewErisLitterCreated then
		local numLitterSpawns = RandomInt( args.LitterSpawnsMin, args.LitterSpawnsMax )
		local litterSpawnPointIds = ShallowCopyTable( args.LitterSpawnPointIds )
		for i = 1, numLitterSpawns do
			local litterSpawnPointId = RemoveRandomValue( litterSpawnPointIds )
			if litterSpawnPointId ~= nil and GameState.ActiveLitter[litterSpawnPointId] == nil then
				-- Always created by RestoreLitter below
				--local consumableId = SpawnObstacle({ DestinationId = litterSpawnPointId, Name = args.LitterName, Group = args.LitterGroupName })
				--local consumable = CreateConsumableItem( consumableId, args.LitterName, nil, { IgnoreSounds = true } )
				--consumable.SpawnPointId = litterSpawnPointId
				GameState.ActiveLitter[litterSpawnPointId] = { Name = args.LitterName, Group = args.LitterGroupName }
			end
		end
		CurrentRun.NewErisLitterCreated = true
	end

	thread( CheckDistanceTrigger, args.UnitDistanceTrigger, source )

end

function RestoreLitter( eventSource, args )
	for id, litter in pairs( GameState.ActiveLitter ) do
		local spawnPointId = id
		if litter.Location ~= nil then
			spawnPointId = CurrentRun.Hero.ObjectId
		end
		local consumableId = SpawnObstacle({ DestinationId = spawnPointId, Name = litter.Name, Group = litter.Group })
		local consumable = CreateConsumableItem( consumableId, litter.Name, nil, { IgnoreSounds = true } )
		consumable.SpawnPointId = id
		if litter.Location ~= nil then
			Teleport({ Id = consumable.ObjectId, OffsetX = litter.Location.X, OffsetY = litter.Location.Y })
		end
	end
end

function SetupDynamicLitter( litter, args )
	args = args or {}
	local location = GetLocation({ Id = litter.ObjectId })
	GameState.ActiveLitter[litter.ObjectId] = { Name = litter.Name, Group = litter.TouchdownGroup, Location = location }
	ChangeDrawGroup( litter.ObjectId, litter.TouchdownGroup )
end

function UseTrashPoint( source, args, user )
	AddInputBlock({ Name = "UseTrashPoint" })
	HarvestStartPresentation( source, args, user )

	for resourceName, count in pairs( source.AddResources ) do
		AddResource( resourceName, count, source.Name )
	end

	GameState.ActiveLitter[source.SpawnPointId] = nil
	GameState.ActiveLitter[source.ObjectId] = nil

	UseableOff({ Id = source.ObjectId })
	--RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", "Blank" )
	--RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )
	HarvestEndPresentation( source, args, user )
	RemoveInputBlock({ Name = "UseTrashPoint" })
	Destroy({ Id = source.ObjectId })
	UpdateAffordabilityStatus()
end

function UpdateAffordabilityStatus()
	for objectId, obstacle in pairs( MapState.ActiveObstacles ) do
		if HasSetupFunction( obstacle, "PlayStatusAnimation" ) then
			StopStatusAnimation( obstacle )
			CheckSetupFunction( obstacle, "PlayStatusAnimation" )
		end
	end
end

function NPCFollowPath( source, args )
	if args.OverwriteSelf ~= nil then
		OverwriteSelf( source, args.OverwriteSelf )
	end
	thread( FollowPath, source, args.Path, args )
end


function RequestPreRunLoadoutChangeSave()
	if CurrentRun.CurrentRoom.TestRoom then
		return
	end
	CurrentRun.StoredHeroLocation = GetLocation({ Id = CurrentRun.Hero.ObjectId })
	CurrentRun.StoredHeroAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
	RequestSave({ DevSaveName = CreateDevSaveName( CurrentRun, { StartNextMap = CurrentHubRoom.Name } ).." (Loadout Change)" })
	-- Remove once saved
	CurrentRun.StoredHeroLocation = nil
	CurrentRun.StoredHeroAngle = nil
end