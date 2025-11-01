
function KillHero( victim, triggerArgs )
	
	local killer = triggerArgs.AttackerTable

	for k, spawnThreadName in pairs( CurrentRun.CurrentRoom.SpawnThreads ) do
		killTaggedThreads( spawnThreadName )
	end
	for wakeThreadName in pairs(SessionMapState.EnemySpawnDelays) do
		killTaggedThreads( wakeThreadName )
	end
	MapState.BlockSpawns = true
	CurrentRun.CurrentRoom.SpawnThreads = {}
	killWaitUntilThreads( "RequiredKillEnemyKilledOrSpawned" )
	killWaitUntilThreads( "AllRequiredKillEnemiesDead" )
	killWaitUntilThreads( "RequiredEncounterEnemiesDead" )
	killWaitUntilThreads( "RequiredEnemyKilled" )
	killWaitUntilThreads( UIData.BoonMenuId )
	ClearGameplayElapsedTimeMultipliers()
	ClearPauseMenuTakeover()
	Destroy({ Ids = GetIdsByType({ Names = { "ManaDropZeus", "PowerDrinkDrop" }})})

	EndAmbience( 0.5 )
	EndMusic( AudioState.MusicId, AudioState.MusicName, triggerArgs.MusicEndTime or 0.0 )
	SetAudioEffectState({ Name = "ChronosSlow", Value = 0 })

	if killer == nil then
		killer = {}
		killer.Name = triggerArgs.AttackerName
		killer.ObjectId = triggerArgs.AttackerId
	end
	CurrentRun.CurrentRoom.SummonEnemyName = nil

	local killedByName = killer.Name or triggerArgs.SourceWeapon
	CurrentRun.KilledByName = killedByName
	GameState.LastKilledByName = killedByName or GameState.LastKilledByName

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end

	AddTimerBlock( CurrentRun, "HandleDeath" )
	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen, nil, { IgnoreHUDShow = true } )
	end
	ClearHealthShroud()
	if SessionMapState.SpellWorldReadyFx then
		SessionMapState.SpellWorldReadyFx = nil
		StopAnimation({ Names = { "SorceryReadyMoonLoopIn", "SorceryReadyMoonLoop" }, DestinationId = CurrentRun.Hero.ObjectId, PreventChain = true })
	end
	SessionMapState.HandlingDeath = true
	CurrentRun.Hero.IsDead = true
	CurrentRun.ActiveBiomeTimer = false
	CurrentRun.SaveFirstKeepsakeSwapped = false

	if ShouldIncrementEasyMode() and not EasyModeIsAtCap() then
		GameState.EasyModeLevel = GameState.EasyModeLevel + 1
		CurrentRun.EasyModeIncremented = true
		GameState.EasyModeHadMaxPresentation = false
		SetConfigOption({ Name = "EasyModeIncremented", Value = true })
	end
	if not CurrentRun.Cleared then -- Already recorded if cleared
		RecordRunStats()
	end

	InvalidateCheckpoint()

	FinishTargetMarker( killer )

	ResetObjectives()

	if not CurrentRun.BountyCleared then
		if CurrentRun.ActiveBounty ~= nil then
			GameState.PackagedBountyClearStreak[CurrentRun.ActiveBounty] = 0
			if BountyData[CurrentRun.ActiveBounty].RandomBountyStreakEligible then
				GameState.RandomBountyClearStreak = 0
			end
		end
		if not CurrentRun.Cleared  then
			if CurrentRun.CurrentRoom.BackupCauseOfDeath ~= nil then
				GameState.CauseOfDeath = CurrentRun.CurrentRoom.BackupCauseOfDeath
				GameState.CauseOfDeathDisplay = CurrentRun.CurrentRoom.BackupCauseOfDeath
				if CurrentRun.CurrentRoom.CauseOfDeathDisplayData and IsGameStateEligible(CurrentRun.CurrentRoom, CurrentRun.CurrentRoom.CauseOfDeathDisplayData.GameStateRequirements ) then
					GameState.CauseOfDeathDisplay = CurrentRun.CurrentRoom.CauseOfDeathDisplayData.Name
				end
			elseif killer.Name ~= nil and killer.ObjectId ~= nil and not killer.SkipModifiers and not killer.ExcludeCauseOfDeath then
				GameState.CauseOfDeath = GetGenusName( killer )
				GameState.CauseOfDeathDisplay = GameState.CauseOfDeath
				if killer.CauseOfDeathDisplayData and IsGameStateEligible(killer, killer.CauseOfDeathDisplayData.GameStateRequirements ) then
					GameState.CauseOfDeathDisplay = killer.CauseOfDeathDisplayData.Name
				end
			end
		end
	end

	if not CurrentRun.PlayedTrueEnding then -- @ ending
		DeathPresentation( CurrentRun, killer, triggerArgs )
	end

	AddInputBlock({ Name = "MapLoad" })

	--[[ Early Access is complete! Thank you to all those who played, as your feedback and support were essential to the creation of Hades II.
	if CurrentRun.Cleared and not CurrentRun.ActiveBounty and not CurrentRun.PlayedTrueEnding then -- @ ending
		wait(0.5)
		if CurrentRun.BiomesReached.F then
			PlaySound({ Name = "/Music/IrisVictoryStingerMEDIUM" })
			if not GameState.EnemyKills.TyphonHead then
				OpenMenu({ Name = "AnnouncementScreen", MessageId = "RunCleared_Message01B", SignatureId = "AnnouncementSignature" })
			else
				OpenMenu({ Name = "AnnouncementScreen", MessageId = "RunCleared_Message01", SignatureId = "AnnouncementSignature" })
			end
		else
			PlaySound({ Name = "/Music/IrisVictoryStingerSMALL" })
			--[[ Early Access is complete!
			OpenMenu({ Name = "AnnouncementScreen", MessageId = "RunCleared_Message02", SignatureId = "AnnouncementSignature" })
		end
		-- waitUntil( "AnnouncementScreen" )
	end
	]]--

	CurrentRun.CurrentRoom.EndingHealth = CurrentRun.Hero.Health
	table.insert( CurrentRun.RoomHistory, CurrentRun.CurrentRoom )
	UpdateRunHistoryCache( CurrentRun, CurrentRun.CurrentRoom )

	GameState.Resources.Money = 0
	CurrentRun.NumRerolls = GetTotalHeroTraitValue( "RerollCount" )
	CurrentRun.NumTalentPoints = GetTotalHeroTraitValue("TalentPointCount")
	CurrentRun.ShrineUpgradesDisabled = {}

	GameState.GamePhaseRunsRemaining = GameState.GamePhaseRunsRemaining - 1
	if GameState.GamePhaseRunsRemaining <= 0 then
		GameState.GamePhaseRunsRemaining = GetRunsUntilNextGamePhase()
		GameState.GamePhase = GameState.GamePhase + 1
		if GameState.GamePhase > #GamePhaseData.GamePhases then
			GameState.GamePhase = 1
		end
	end

	SessionMapState.HandlingDeath = false
	CurrentRun.Hero.Health = CurrentRun.Hero.MaxHealth
	CurrentRun.Hero.HealthBuffer = 0
	CurrentRun.Hero.Mana = CurrentRun.Hero.MaxMana
	CurrentRun.Hero.ReserveManaSources = {}
	CurrentRun.Hero.ReserveHealthSources = {}
	CurrentRun.Hero.ReserveHealthExtra = 0

	for i=1, #GameState.StoreItemPins do
		if GameState.StoreItemPins[i].StoreName == "TraitData" then
			GameState.StoreItemPins[i] = nil
		end
	end
	GameState.StoreItemPins = CollapseTable( GameState.StoreItemPins )
	
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
				if IsGameStateEligible( deathMapData, gameStateRequirements ) then
					deathMap = deathMapName
					break
				end
			end
		end
	end
	if CurrentRun.Hero.PreDeathTraits == nil then
		-- used for save analysis
		CurrentRun.Hero.PreDeathTraits = CurrentRun.Hero.Traits
	end
	RequestSave({ StartNextMap = deathMap, DevSaveName = CreateDevSaveName( CurrentRun, { StartNextMap = deathMap, PostDeath = true, } ), SendSave = true })
	ClearUpgrades()
	SetConfigOption({ Name = "FlipMapThings", Value = false })
	UnloadPackages({ Names = PortraitPackages })
	LoadMap({ Name = deathMap, ResetBinks = true })
end

function ShouldIncrementEasyMode()
	if ConfigOptionCache.EasyMode and not CurrentRun.Cleared and not CurrentRun.BountyCleared and not CurrentRun.Hero.TraitDictionary.SurfacePenalty then
		return true
	end
	return false
end

function EasyModeIsAtCap()
	local multiplierCap = 1 - ConfigOptionCache.EasyModeResistanceCap
	--DebugPrint({ Text = "multiplierCap = "..multiplierCap })
	local currentMultiplier = CalcEasyModeMultiplier( GameState.EasyModeLevel )
	--DebugPrint({ Text = "currentMultiplier = "..currentMultiplier })
	if currentMultiplier <= multiplierCap + 0.001 then -- Epsilon to cover floating point rounding
		return true
	end
	return false
end

function StartDeathLoop( source, args )
	ToggleCombatControl( CombatControlsDefaults, false, "DeathLoopStart" )
	
	local hubBiomeName = "Hub"
	GameState.BiomeVisits[hubBiomeName] = (GameState.BiomeVisits[hubBiomeName] or 0) + 1
	CurrentRun.BiomesReached[hubBiomeName] = true
	
	CurrentRun.BlockDeathAreaTransitions = true
	DeathAreaRoomTransition( HubRoomData[GameData.HubMapName] )

	CallFunctionName( args.PresentationFunctionName, CurrentRun, args.PresentationFunctionArgs )

	local notifyName = "ReattachCameraOnInput"
	NotifyOnPlayerInput({ Notify = notifyName })
	waitUntil( notifyName )
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.0, FromCurrentLocation = true, })
	
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
	if SessionMapState.SprintWeaponSoundId then
		StopSound({ Id = SessionMapState.SprintWeaponSoundId, Duration = 0.2 })
		SessionMapState.SprintWeaponSoundId = nil
	end
	for obstacleId, obstacle in pairs( ShallowCopyTable( MapState.ActiveObstacles ) ) do
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

	if args.PreLoadFunctionName ~= nil then
		CallFunctionName( args.PreLoadFunctionName, source, args )
	end

	RemoveInputBlock({ Name = "DeathAreaSwitchRoom" })
	local portraitCount = 0
	for id, unit in pairs( ActiveEnemies ) do
		if unit.LoadPackages ~= nil then
			portraitCount = portraitCount + 1
		end
	end
	CurrentRun.HubPortraitCount = math.max( (CurrentRun.HubPortraitCount or 0), portraitCount )
	if CurrentRun.HubPortraitCount >= 8 then
		UnloadPackages({ Names = PortraitPackages })
	end
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

	LoadVoiceBanks( CurrentHubRoom.SpeakerName )
	LoadPackages({ Names = CurrentHubRoom.LoadPackages })

	ResetObjectives()
	RunEventsGeneric( CurrentHubRoom.StartUnthreadedEvents, CurrentHubRoom )

	StartRoomPreLoadBinks({
		Run = currentRun,
		Room = CurrentHubRoom
	})

	RunEvents( CurrentHubRoom )
	AssignObstacles( CurrentHubRoom )
	CheckInspectPoints( currentRun, CurrentHubRoom )
	StartTriggers( CurrentHubRoom, CurrentHubRoom.DistanceTriggers )

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

	CheckAutoObjectiveSets(currentRun, "RoomStart")
end

function HubPostBountyLoad( source, args )

	args = args or {}
	AddInputBlock({ Name = "DeathAreaTransition" })
	PreviousDeathAreaRoom = CurrentHubRoom
	CurrentHubRoom = source
	SetConfigOption({ Name = "BlockGameplayTimer", Value = true })
	RestorePackagedBountyGameState()

	UpdateTraitSummary()

	SetupHeroObject( CurrentHubRoom )

	if CurrentHubRoom.RichPresence ~= nil then
		SetRichPresence({ Key = "status", Value = CurrentHubRoom.RichPresence })
		SetRichPresence({ Key = "steam_display", Value = CurrentHubRoom.RichPresence })
	end

	FadeOut({ Color = Color.Black, Duration = 0 })
	SetupCamera( CurrentHubRoom )
	SwitchActiveUnit({ Id = CurrentRun.Hero.ObjectId })

	LoadVoiceBanks( CurrentHubRoom.SpeakerName )

	ResetObjectives()
	local bountyBoardId = 561146
	CurrentRun.FamiliarSpawnNearId = bountyBoardId
	RunEventsGeneric( CurrentHubRoom.StartUnthreadedEvents, CurrentHubRoom )

	StartRoomPreLoadBinks({
		Run = CurrentRun,
		Room = CurrentHubRoom
	})

	RunEvents( CurrentHubRoom )
	AssignObstacles( CurrentHubRoom )
	CheckInspectPoints( CurrentRun, CurrentHubRoom )
	StartTriggers( CurrentHubRoom, CurrentHubRoom.DistanceTriggers )

	HubPostBountyStartPresentation( CurrentHubRoom )

	RemoveInputBlock({ Name = "DeathAreaTransition" })

	if CurrentHubRoom.CheckObjectives ~= nil then
		for k, objectiveName in pairs( CurrentHubRoom.CheckObjectives ) do
			CheckObjectiveSet( objectiveName )
		end
	end

	CheckAutoObjectiveSets( CurrentRun, "RoomStart" )
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

	-- Silence the world
	ExpireProjectiles({ Silent = true, BlockSpawns = true })
	Destroy({ Ids = GetIdsByType({ Name = "LobAmmoPack"}) })
	killTaggedThreads( "CheckRoomExitsReady" )

	for index, familiarName in ipairs( FamiliarOrderData ) do
		local familiarData = FamiliarData[familiarName]
		local familiar = familiarData.Unit
		if familiar then
			CleanupEnemy( familiar )
			familiarData.Unit = nil
		end
	end

	WaitForSpeechFinished()

	local currentRun = CurrentRun
	EndRun( currentRun )
	CurrentHubRoom = nil
	PreviousDeathAreaRoom = nil

	if GameState.NextRunSeed ~= nil then
		RandomSetNextInitSeed( { Seed = GameState.NextRunSeed } )
		GameState.NextRunSeed = nil
	end
	
	HideCombatUI( "StartOver" )
	currentRun = StartNewRun( currentRun,
		{
			StartingBiome = args.StartingBiome or "F",
			RandomOffset = args.RandomOffset,
			ForcedRewards = args.ForcedRewards,
			ActiveBounty = args.ActiveBounty,
			RunOverrides = args.RunOverrides,
			StartingRoomOverrides = args.StartingRoomOverrides,
		})
	GameState.LocationName = currentRun.CurrentRoom.SaveProfileLocationText
	StopMusicianMusic( { Duration = 1.0 } )
	ResetObjectives()

	SetConfigOption({ Name = "FlipMapThings", Value = false })
	SetConfigOption({ Name = "BlockGameplayTimer", Value = false })

	AddTimerBlock( currentRun, "StartOver" )
	
	RequestSave({ StartNextMap = currentRun.CurrentRoom.Name, SaveName = "_Temp", DevSaveName = CreateDevSaveName( currentRun ) })
	ValidateCheckpoint({ Value = true })
	
	UnblockCombatUI( "StartOver" )
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
	wait( waitTime or 3.0, "SpawnSkelly" )
	ActivatePrePlaced( nil, { LegalTypes = { "NPC_Skelly_01" }, IgnorePackages = true } )
	wait( 2.5, "SpawnSkelly" )
	CheckConversations( nil, { RequireNoPartner = true } )

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

	wait( args.PreWaitForDistanceTrigger )

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

	local trashPointIds = nil
	if GameState.WorldUpgradesAdded.WorldUpgradeErisTrashPickup then
		trashPointIds = GetIdsByType({ Name = "TrashPointsDrop" })
		-- make sure the trash you picked up is collected first
		for i, id in ipairs( trashPointIds ) do
			if id == source.ObjectId and i > 1 then
				local otherId = trashPointIds[1]
				trashPointIds[1] = source.ObjectId
				trashPointIds[i] = otherId
				break
			end
		end
	else
		trashPointIds = { source.ObjectId }
	end
	for i, trashPointId in ipairs( trashPointIds ) do
		local trashPoint = MapState.ActiveObstacles[trashPointId]
		GameState.ActiveLitter[trashPoint.SpawnPointId] = nil
		GameState.ActiveLitter[trashPoint.ObjectId] = nil
	end

	HarvestStartPresentation( source, { PresentationFunctionName = "UsedTrashPointPresentation", TrashPointIds = trashPointIds }, user )

	local trashPointCount = #trashPointIds
	for resourceName, count in pairs( source.AddResources ) do
		AddResource( resourceName, count * trashPointCount, source.Name )
	end

	UseableOff({ Ids = trashPointIds })
	HarvestEndPresentation( source, args, user )
	RemoveInputBlock({ Name = "UseTrashPoint" })
	Destroy({ Ids = trashPointIds })
	UpdateAffordabilityStatus()
end

function UpdateAffordabilityStatus()
	for objectId, obstacle in pairs( ShallowCopyTable( MapState.ActiveObstacles ) ) do
		if HasEventFunctionName( obstacle.SetupEvents, "PlayStatusAnimation" ) then
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

function HideAmbientCritters( source, args )
	local allCritterGroups = {}
	for i, event in ipairs( source.StartUnthreadedEvents ) do
		if event.FunctionName == "ActivateAmbientCritters" then
			allCritterGroups = CombineTables( allCritterGroups, event.Args.Groups )
		end
	end
	local ids = GetIds({ Names = allCritterGroups })
	SetAlpha({ Ids = ids, Fraction = 0 })
end

function ActivateAmbientCritters( source, args )
	local allGroups = ShallowCopyTable( args.Groups )
	local numGroupsToActivate = RandomInt( args.MinGroupsToActivate, args.MaxGroupsToActivate )
	for i=1, math.min( numGroupsToActivate, #allGroups ) do
		local group = RemoveRandomValue( allGroups )
		local ids = GetIds({ Name = group })
		-- Make the critter visible
		SetAlpha({ Ids = ids, Fraction = 1 })
		-- Randomize its animation, if applicable
		for _, id in ipairs( ids ) do
			if MapState.ActiveObstacles[id] ~= nil and MapState.ActiveObstacles[id].AmbientAnimations ~= nil then
				SetAnimation({ DestinationId = id, Name = GetRandomValue( MapState.ActiveObstacles[id].AmbientAnimations ) })
			end
		end
	end
end

function GamePhaseTick( args )
	args = args or {}
	GardenTimeTick( args )
	CookTimeTick( args )
	MailboxTimeTick( args )
end

function GetRunsUntilNextGamePhase()
	return RandomInt( GamePhaseData.MinRunsPerPhase, GamePhaseData.MaxRunsPerPhase )
end
