function CheckArtemisSpawn(encounter, args)
	if encounter.ArtemisId ~= nil then
		return
	end

	args = args or {}

	if encounter.WaveCount == 1 or encounter.CurrentWaveNum > 1 or RandomChance(args.FirstWaveArtemisChance or 0.1) then
		HandleArtemisSpawn( encounter, args )
	end
end

function HandleArtemisSpawn( eventSource, args )
	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource

	local newUnit = DeepCopyTable( EnemyData.NPC_Artemis_Field_01 )
	local spawnPointId = GetRandomValue( GetIds({ Name = "ArtemisSpawnPoints" }) or GetIdsByType({ Name = "CameraClamp" }) )
	if RoomData[currentRoom.Name].ArtemisUseHeroStart then
		spawnPointId = GetRandomValue( GetIdsByType({ Name = "HeroStart" }) )
	end
	spawnPointId = spawnPointId or currentRun.Hero.ObjectId
	newUnit.ObjectId = SpawnUnit({ Name = "NPC_Artemis_Field_01", Group = "Standing", DestinationId = spawnPointId })

	SetAlpha({ Id = newUnit.ObjectId, Fraction = 0, Duration = 0 })
	SetAnimation({ DestinationId = newUnit.ObjectId, Name = "Artemis_Invisible" })
	SetThingProperty({ Property = "Graphic", Value = "Artemis_Invisible", DestinationId = newUnit.ObjectId })

	currentEncounter.ArtemisId = newUnit.ObjectId
	SetupUnit( newUnit, CurrentRun, { IgnoreAI = true, IgnorePackages = true } )
	UseableOff({ Id = newUnit.ObjectId })
	MapState.RoomRequiredObjects[newUnit.ObjectId] = newUnit

	thread( ArtemisPreSpawnPresentation, eventSource )

	thread(SetupAI, newUnit )

	wait(args.WaveSpawnDelay, currentEncounter.SpawnThreadName)
end

function CheckIcarusSpawn(encounter, args)
	if encounter.IcarusId ~= nil then
		return
	end

	args = args or {}

	if encounter.WaveCount == 1 or encounter.CurrentWaveNum > 1 or RandomChance(args.FirstWaveIcarusChance or 0.1) then
		HandleIcarusSpawn( encounter, args )
	end
end

function HandleAthenaSpawn(encounter, args)
	if ( encounter.SpawnsSkipped or encounter.BlockAthenaEncounterKeepsake ) and not args.Force then
		return
	end
	args = args or {}
	waitUnmodified( 1.0 )
	if CurrentRun.Hero.IsDead then
		return
	end
	if args.LoadPackages then
		LoadPackages( { Names = args.LoadPackages, IgnoreAssert = true } )
	end

	encounter.ActiveEnemyCap = encounter.ActiveEnemyCap or encounter.ActiveEnemyCapMax
	encounter.ActiveEnemyCap = math.max(encounter.ActiveEnemyCap, 8)
	if CurrentRun.CurrentRoom.RoomSetName == "H" then -- Need to account to passive encounters
		encounter.ActiveEnemyCap = math.min(encounter.ActiveEnemyCap, 5)
	end

	while encounter.InProgress do

		waitUntil("RequiredKillEnemyKilledOrSpawned", RoomThreadName)
		waitUnmodified( 2.0 )
		if encounter.SpawnsComplete then
			break
		end
	end
	if encounter.SpawnsSkipped or CurrentRun.Hero.IsDead then
		return
	end
	if args.FromTrait or ( encounter.ExpireTrait and HeroHasTrait( encounter.ExpireTrait ))then
		local traitName = args.FromTrait or encounter.ExpireTrait 
		local traitData = GetHeroTrait( traitName )
		traitData.RemainingUses = traitData.RemainingUses - 1
		traitData.CustomTrayText = traitData.ZeroBonusTrayText
		
		if encounter.ExpireTrait then
			args = ShallowCopyTable( traitData.UniqueEncounterArgs.EncounterThreadedFunctions.Args )
		end
		ReduceTraitUses( traitData, { Force = true })
	end
	AthenaSpawnPresentation(encounter, args)
end

function AthenaUse(athena, args, user)
	if UseLoot(athena, args, user) then
		AthenaExitPresentation( athena, args )
	end
end

function HandleIcarusSpawn( eventSource, args )
	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource

	local newUnit = DeepCopyTable( EnemyData.NPC_Icarus_01 )
	local variantData = NPCVariantData.IcarusCombat
	OverwriteSelf( newUnit, variantData )

	local spawnPointId = GetRandomValue( GetIdsByType({ Name = "CameraClamp" }) ) -- GetIds({ Name = "IcarusSpawnPoints" }) or
	spawnPointId = spawnPointId or currentRun.Hero.ObjectId
	newUnit.ObjectId = SpawnUnit({ Name = "NPC_Icarus_01", Group = "Standing", DestinationId = spawnPointId })

	SetAlpha({ Id = newUnit.ObjectId, Fraction = 0, Duration = 0 })

	currentEncounter.IcarusId = newUnit.ObjectId
	SetupUnit( newUnit, CurrentRun, { IgnoreAI = true, IgnorePackages = true } )
	UseableOff({ Id = newUnit.ObjectId })
	MapState.RoomRequiredObjects[newUnit.ObjectId] = newUnit

	thread( IcarusPreSpawnPresentation, newUnit, eventSource )

	thread(SetupAI, newUnit )

	wait(args.WaveSpawnDelay, currentEncounter.SpawnThreadName)
end

function HandleHeraclesSpawn( eventSource )
	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource

	local newUnit = DeepCopyTable( EnemyData.NPC_Heracles_01 )
	local dummyEncounter = { SpawnNearId = currentRun.Hero.ObjectId, SpawnRadius = 900, }
	local spawnPointId = SelectSpawnPoint( currentRoom, newUnit, dummyEncounter, { RequireMinEndPointDistance = 400 } )
	spawnPointId = spawnPointId or currentRun.Hero.ObjectId
	newUnit.ObjectId = SpawnUnit({ Name = "NPC_Heracles_01", Group = "Standing", DestinationId = spawnPointId })
	newUnit.UseActivatePresentation = false
	newUnit.OccupyingSpawnPointId = spawnPointId
	
	AdjustZLocation({ Id = newUnit.ObjectId, Distance = 2500 })
	IgnoreGravity({ Id = newUnit.ObjectId })

	currentEncounter.HeraclesId = newUnit.ObjectId
	SetupUnit( newUnit, CurrentRun, { IgnoreAI = true, } )
	UseableOff({ Id = newUnit.ObjectId })
	MapState.RoomRequiredObjects[newUnit.ObjectId] = newUnit
	newUnit.TextLinesUseWeaponIdle = true
	
	currentEncounter.StartPlayerMoney = GameState.Resources.Money

	-- dummy enemy
	local dummyName = GetRandomValue(EncounterData[currentEncounter.Name].HeraclesDummyUnitSet)
	local dummyTarget = DeepCopyTable( EnemyData[dummyName] )
	local setupArgs = {}
	setupArgs.SkipAISetup = true
	dummyTarget.UseActivatePresentation = false
	dummyTarget.RequiredKill = false
	dummyTarget.MoneyDropOnDeath = nil
	dummyTarget.IgnoreCurseDamage = true
	dummyTarget.ObjectId = SpawnUnit({ Name = dummyName, Group = "Standing", DestinationId = spawnPointId })
	thread(SetupUnit, dummyTarget, CurrentRun, setupArgs )
	currentEncounter.DummyTargetId = dummyTarget.ObjectId

	if not EncounterData[currentEncounter.Name].SkipHeraclesSpawnPresentation then
		HeraclesSpawnPresentation( newUnit, dummyTarget )
	end
end

function HandleNemesisCombatSpawn( eventSource, args )
	args = args or {}
	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource

	local newUnit = DeepCopyTable( EnemyData.NPC_Nemesis_01 )
	-- local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	-- local heroExitPointId = GetClosest({ Id = currentRun.Hero.ObjectId, DestinationIds = heroExitIds, Distance = 600 })
	local variantData = NPCVariantData.NemesisCombat
	if NPCVariantData["NemesisCombat_"..CurrentRun.CurrentRoom.RoomSetName] then
		variantData = NPCVariantData["NemesisCombat_"..CurrentRun.CurrentRoom.RoomSetName]
	end
	OverwriteSelf( newUnit, variantData )

	newUnit.BlocksLootInteraction = true -- For Fields
	
	local encounterData = EncounterData[eventSource.Name] or eventSource
	local spawnNearId = currentRoom.HeroEndPoint or currentRun.Hero.ObjectId
	if args.SpawnNearPlayer then
		spawnNearId = currentRun.Hero.ObjectId
	end
	local spawnPointId = SelectSpawnPoint( currentRoom, newUnit, { SpawnNearId = spawnNearId, SpawnRadius = encounterData.NemesisSpawnRadius or 1000, SpawnRadiusMin = encounterData.NemesisSpawnRadiusMin or 500 }, { RequireLoS = true })
	spawnPointId = spawnPointId or currentRun.Hero.ObjectId
	newUnit.ObjectId = SpawnUnit({ Name = "NPC_Nemesis_01", Group = "Standing", DestinationId = spawnPointId })
	newUnit.UseActivatePresentation = false

	currentEncounter.NemesisId = newUnit.ObjectId
	SetupUnit( newUnit, CurrentRun, { IgnoreAI = true, IgnoreAssert = true } )
	MapState.RoomRequiredObjects[newUnit.ObjectId] = newUnit
	SessionMapState.Nemesis = newUnit
	UseableOff({ Id = newUnit.ObjectId })
	currentEncounter.NemesisId = newUnit.ObjectId
	AngleTowardTarget({ Id = newUnit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
end

function ActivateNemesisPostRandomEventCombat(eventSource)
	local nemesisId = GetIdsByType({ Name = "NPC_Nemesis_01" })[1]

	if nemesisId ~= nil then
		local nemesis = ActiveEnemies[nemesisId]
		if nemesis == nil or nemesis.Exiting then
			return
		end
		OverwriteSelf( nemesis, NPCVariantData.NemesisPostRandomEventCombat )
		SetupAI( nemesis )
	end
end

function SimulateCombatDestruction( source, args )
	local decalLocationIds = GetIdsByType({ Names = { "EnemyPoint", "EnemyPointMelee" } })
	local numDecals = RandomInt( args.DecalsMin, args.DecalsMax )
	for i = 1, numDecals do
		local randomDecal = GetRandomValue( args.DecalNames )
		local randomLocationId = GetRandomValue( decalLocationIds )
		CreateAnimation({ Name = randomDecal, DestinationId = randomLocationId, OffsetX = RandomFloat( -args.DecalRadius, args.DecalRadius ), OffsetY = RandomFloat( -args.DecalRadius, args.DecalRadius ) })
	end
	local legalBreakables = FindAllSwappableBreakables()
	local numDestroyBreakables = RandomInt( args.DestroyBreakablesMin, args.DestroyBreakablesMax )
	for i = 1, numDestroyBreakables do
		local breakable = RemoveRandomValue( legalBreakables )
		Kill( breakable, { SuppressSounds = true } )
	end
end

function SpawnNemesisForRandomEvents( eventSource, args )
	RandomSynchronize( 3 )
	local roomData = RoomData[CurrentRun.CurrentRoom.Name]
	local newUnit = DeepCopyTable( EnemyData.NPC_Nemesis_01 )
	local spawnPointId = SelectSpawnPoint( CurrentRun.CurrentRoom, newUnit, eventSource, args )
	newUnit.ObjectId = SpawnUnit({ Name = "NPC_Nemesis_01", Group = "Standing", DestinationId = spawnPointId })
	OverwriteSelf( newUnit, NPCVariantData[args.NPCVariantData] )
	SetupUnit( newUnit, CurrentRun, { IgnoreAI = true, } )
	SetUnitInvulnerable( newUnit )
	AngleTowardTarget({ Id = newUnit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	MapState.RoomRequiredObjects[newUnit.ObjectId] = newUnit
	SessionMapState.Nemesis = newUnit
	CheckAvailableTextLines( newUnit )
	SetAvailableUseText( newUnit )

	-- Just in case Nemesis gives you a SpellDrop
	if newUnit.NextInteractLines ~= nil and newUnit.NextInteractLines.PrePortraitExitFunctionName == "NemesisTradeChoice" then
		LoadVoiceBanks({ Name = "Selene" })
	end
	
	if not roomData.SkipNemesisSpawnPresentation then
		thread( NemesisThemePresentation, eventSource, newUnit, { WaitTime = 1.0, SkipBanner = true, SecretMusicSection = 1 } )
	end
end

function NemesisTakeRoomExit( eventSource, args )

	local nemesis = SessionMapState.Nemesis
	if nemesis.Exiting then
		return
	end

	while nemesis.InRelationshipAdvancedPresentation do
		wait( 0.2 )
	end

	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom

	UseableOff({ Id = nemesis.ObjectId })
	nemesis.SpecialInteractFunctionName = nil
	nemesis.CanReceiveGift = false
	wait( RandomFloat( args.RandomWaitMin, args.RandomWaitMax ) )

	local availableDoors = {}
	for id, door in pairs( MapState.OfferedExitDoors ) do
		if door.EncounterCost == nil and (door.HealthCost == nil or CurrentRun.Hero.Health > door.HealthCost) then
			table.insert( availableDoors, door )
		end
	end

	if TableLength( availableDoors ) <= 1 then
		NemesisTeleportExitPresentation( nemesis, args )
		return
	end

	local randomExitDoor = GetRandomValue( availableDoors )
	SetUnitProperty({ Property = "Speed", Value = nemesis.ExitSpeed, DestinationId = nemesis.ObjectId })
	local successDistance = roomData.NemesisTakeExitSuccessDistance or 130
	Move({ Id = nemesis.ObjectId, DestinationId = randomExitDoor.ObjectId, SuccessDistance = successDistance, LookAheadMultiplier = 2.0 })
	nemesis.TakingExitDoorId = randomExitDoor.ObjectId
	local notifyName = "NemesisTakeRoomExit"
	NotifyWithinDistance({ Id = nemesis.ObjectId, DestinationId = randomExitDoor.ObjectId, Distance = successDistance + 70, Notify = notifyName })
	waitUntil( notifyName )
	if randomExitDoor.InUse then
		-- Player took it already
		return
	end
	--UseableOff({ Id = randomExitDoor.ObjectId })
	randomExitDoor.UseText = nemesis.DoorTakenText
	randomExitDoor.UnlockedUseText = nemesis.DoorTakenText
	randomExitDoor.OnUseEvents = nil
	randomExitDoor.OnUsedFunctionName = "AttemptUseDoorNemesisTookPresentation"
	randomExitDoor.RerollFunctionName = nil
	local chosenRewardType = randomExitDoor.Room.ChosenRewardType
	if chosenRewardType ~= nil then
		CurrentRun.CurrentRoom.NemesisTakeExitRecord[chosenRewardType] = (CurrentRun.CurrentRoom.NemesisTakeExitRecord[chosenRewardType] or 0) + 1
		CurrentRun.NemesisTakeExitRecord[chosenRewardType] = (CurrentRun.NemesisTakeExitRecord[chosenRewardType] or 0) + 1
		GameState.NemesisTakeExitRecord[chosenRewardType] = (GameState.NemesisTakeExitRecord[chosenRewardType] or 0) + 1
	end
	local roomName = randomExitDoor.Room.Name
	if roomName ~= nil then
		CurrentRun.CurrentRoom.NemesisTakeRoomExitRecord[roomName] = (CurrentRun.CurrentRoom.NemesisTakeRoomExitRecord[roomName] or 0) + 1
		CurrentRun.NemesisTakeRoomExitRecord[roomName] = (CurrentRun.NemesisTakeRoomExitRecord[roomName] or 0) + 1
		GameState.NemesisTakeRoomExitRecord[roomName] = (GameState.NemesisTakeRoomExitRecord[roomName] or 0) + 1
	end
	if randomExitDoor.Room.CageRewards ~= nil then
		for i, reward in pairs( randomExitDoor.Room.CageRewards ) do
			local rewardType = reward.RewardType
			CurrentRun.CurrentRoom.NemesisTakeExitRecord[rewardType] = (CurrentRun.CurrentRoom.NemesisTakeExitRecord[rewardType] or 0) + 1
			CurrentRun.NemesisTakeExitRecord[rewardType] = (CurrentRun.NemesisTakeExitRecord[rewardType] or 0) + 1
			GameState.NemesisTakeExitRecord[rewardType] = (GameState.NemesisTakeExitRecord[rewardType] or 0) + 1
		end
	end
	RemoveScreenEdgeIndicator( randomExitDoor )
	
	NemesisLeaveRoomPresentation( nemesis, randomExitDoor )

end

function HandleEncounterPreSpawns( encounter )

	if not encounter.PreSpawnEnemies or SessionState.BlockSpawns then
		-- Enemies missed their chance to pre-spawn and can spawn regularly
		return
	end
	
	if encounter.SpawnsSkipped then
		return
	end
	local room = CurrentRun.CurrentRoom 
	if encounter.CanEncounterSkip and HasHeroTraitValue("SkipEncounterChance") then
		local sourceTrait = HasHeroTraitValue("SkipEncounterChance")
		local sourceTraitCanSkip = not sourceTrait.SkipEncounterValidationFunctionName or CallFunctionName( sourceTrait.SkipEncounterValidationFunctionName, encounter, sourceTrait )
		if IsTraitActive(sourceTrait) and RandomChance(sourceTrait.SkipEncounterChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } )) and sourceTraitCanSkip then
			encounter.SpawnsSkipped = true
			if sourceTrait.OnEncounterSkipFunction then
				CallFunctionName( sourceTrait.OnEncounterSkipFunction, sourceTrait )
			end
			if not IsEmpty(room.Encounters) and encounter.SkipEndEncounterEffects then
				for _, successiveEncounter in pairs(room.Encounters) do
					successiveEncounter.SpawnsSkipped = true
					if successiveEncounter ~= encounter then
						successiveEncounter.MultiEncounterSpawnSkip = true
					end
				end
			end
			return
		else
			-- Don't roll again in HandleEnemySpawns
			encounter.CanEncounterSkip = false
		end
	end
	encounter = encounter or room.Encounter

	local encounterData = EncounterData[encounter.Name] or encounter

	encounter.SpawnThreadName = encounter.Name.."SpawnThread"
	table.insert(CurrentRun.CurrentRoom.SpawnThreads, encounter.SpawnThreadName)

	encounter.ActiveSpawns = encounter.ActiveSpawns or {}

	if encounter.SpawnHazards then
		thread(HandleHazardSpawns, CurrentRun.CurrentRoom, encounter)
	end

	local wave = encounter.SpawnWaves[1]
	encounter.CurrentWaveNum = 1

	encounter.PreSpawned = true
	encounter.PreSpawning = true

	if wave.OverrideValues ~= nil then
		OverwriteTableKeys(encounter, wave.OverrideValues)
	end

	encounter.ActiveEnemyCap = CalculateActiveEnemyCap( CurrentRun, CurrentRun.CurrentRoom, encounter )
	encounter.Spawns = {}
	AddEncounterLayer( CurrentRun, CurrentRun.CurrentRoom, encounter, wave )

	local ignoreSpawnPreferences = encounter.IgnoreSpawnPreferences or false
	while GetRemainingSpawns( CurrentRun, CurrentRun.CurrentRoom, encounter ) > 0 and GetActiveEnemyCount( encounter ) < encounter.ActiveEnemyCap do
		local spawnedId = nil

		local spawnInfo = GetNextSpawn( encounter )
		local newSpawnActiveCapWeight = 1
		if EnemyData[spawnInfo.Name] ~= nil and EnemyData[spawnInfo.Name].ActiveCapWeight ~= nil then
			newSpawnActiveCapWeight = EnemyData[spawnInfo.Name].ActiveCapWeight
		end

		if GetActiveEnemyCount( encounter ) <= encounter.ActiveEnemyCap - newSpawnActiveCapWeight then
			spawnedId = HandleNextSpawn( encounter, ignoreSpawnPreferences, spawnInfo, encounterData.PreSpawnSpawnOverrides, { RequireMinEndPointDistance = encounterData.PreSpawnMinEndPointDistance } )
			if spawnedId == nil or GetActiveEnemyCount( encounter ) >= encounter.ActiveEnemyCap or spawnInfo.EndPreSpawns then
				-- Hit cap
				return
			end
		else
			return
		end
	end
end

function CanDionysusSkip( encounter, sourceTrait )
	if not CurrentRun or not CurrentRun.CurrentRoom then
		return false
	end
	
	if CurrentRun.CurrentRoom.BiomeStartRoom then
		return false
	end

	if CurrentRun.CurrentRoom.Encounters then
		for i, encounterData in pairs(CurrentRun.CurrentRoom.Encounters) do
			if encounterData.BlockDionysusEncounterKeepsake then
				return false
			end
		end
	end
	if CurrentRun.CurrentRoom.Encounter then
		if CurrentRun.CurrentRoom.Encounter.BlockDionysusEncounterKeepsake then
			return false
		end
	end
	if sourceTrait and sourceTrait.ActivatedThisBiome then
		return false
	end
	return true
end

function ProcessDionysusSkip( sourceTrait )
	if CurrentRun.ClearedBiomes >= 4 then
		sourceTrait.CustomTrayText = "PersistentDionysusSkipKeepsake_NoBiomes"
	else
		sourceTrait.CustomTrayText = "PersistentDionysusSkipKeepsake_Recharging"
	end
end

function HandleEnemySpawns( encounter )

	if SessionState.BlockSpawns then
		waitUntil( "BlockSpawnsOff" )
	end

	if encounter.SpawnsSkipped then
		if not encounter.MultiEncounterSpawnSkip then
			wait(2)
			UseHeroTraitsWithValue("SkipEncounterChance")
			if HeroHasTrait("PersistentDionysusSkipKeepsake") then
				local skipEncounterTrait = GetHeroTrait("PersistentDionysusSkipKeepsake")
				skipEncounterTrait.ActivatedThisBiome = true
				UpdateTraitNumber( skipEncounterTrait )
			end
			thread( SkipEncounterPresentation )
		end
		encounter.SpawnsComplete = true
		return
	end
	
	if encounter.CanEncounterSkip and HasHeroTraitValue("SkipEncounterChance") then
		local sourceTrait = HasHeroTraitValue("SkipEncounterChance")
		local sourceTraitCanSkip = not sourceTrait.SkipEncounterValidationFunctionName or CallFunctionName( sourceTrait.SkipEncounterValidationFunctionName, encounter, sourceTrait )
		if IsTraitActive(sourceTrait) and RandomChance(sourceTrait.SkipEncounterChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } )) and sourceTraitCanSkip then
			if sourceTrait.OnEncounterSkipFunction then
				CallFunctionName( sourceTrait.OnEncounterSkipFunction, sourceTrait )
			end
			encounter.SpawnsSkipped = true
			wait(2)
			UseHeroTraitsWithValue("SkipEncounterChance")
			if HeroHasTrait("PersistentDionysusSkipKeepsake") then
				local skipEncounterTrait = GetHeroTrait("PersistentDionysusSkipKeepsake")
				skipEncounterTrait.ActivatedThisBiome = true
				UpdateTraitNumber( skipEncounterTrait )
			end
			thread( SkipEncounterPresentation )	
			
			encounter.SpawnsComplete = true
			return
		end
	end
	local encounterData = EncounterData[encounter.Name] or encounter

	if encounter.SpawnThreadName == nil then
		encounter.SpawnThreadName = encounter.Name.."SpawnThread"
	end
	if CurrentRun.CurrentRoom.SpawnThreads[encounter.SpawnThreadName] == nil then
		table.insert(CurrentRun.CurrentRoom.SpawnThreads, encounter.SpawnThreadName)
	end

	encounter.ActiveSpawns = encounter.ActiveSpawns or {}

	if encounter.SpawnWaves == nil then
		if encounter.Spawns ~= nil then
			encounter.SpawnWaves = { {Spawns = encounter.Spawns} }
		else
			--DebugPrint({ Text = "Encounter has no spawns!" })
			encounter.SpawnsComplete = true
			return
		end
	end

	--DebugPrint({ Text = "Starting spawns for: "..encounter.Name })
	RunEventsGeneric( encounterData.EncounterSpawnsStartEvents, encounter )

	CheckObjectiveSet( encounterData.EncounterType )
	CheckObjectiveSet( encounterData.ObjectiveSets )

	encounter.ActiveEnemyCap = CalculateActiveEnemyCap( CurrentRun, CurrentRun.CurrentRoom, encounter )

	if encounter.SpawnPassiveRoomWeapons ~= nil then
		encounter.PassiveRoomWeapons = {}
		for k, name in pairs(encounter.SpawnPassiveRoomWeapons) do
			local newEnemy = DeepCopyTable( EnemyData[name] )
			newEnemy.ObjectId = SpawnUnit({ Name = name, Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId })	
			thread(SetupUnit, newEnemy, CurrentRun )
			newEnemy.Groups = newEnemy.Groups or {}
			table.insert( newEnemy.Groups, "RoomWeapon" )
			SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = _elapsedTimeMultiplier, DataValue = false, ValueChangeType = "Multiply", DestinationId = newEnemy.ObjectId })
			AddToGroup({ Id = newEnemy.ObjectId, Names = newEnemy.Groups })
			
			if not newEnemy.DontDieWithEncounter then
				table.insert(encounter.PassiveRoomWeapons, newEnemy.ObjectId)
			end
		end
	end

	local waveCount = TableLength( encounter.SpawnWaves )
	for waveNum, wave in ipairs( encounter.SpawnWaves ) do
		--DebugPrint({ Text = "Starting Wave "..waveNum.." "..encounter.Name })
		encounter.CurrentWaveNum = waveNum
		if waveNum == waveCount then
			encounter.FinalWave = true
		end

		-- Start a new wave
		RunEventsGeneric( encounterData.WaveStartUnthreadedEvents, encounter )
		RunThreadedEvents( wave.StartThreadedEvents, encounter )
		RunEventsGeneric( wave.StartUnthreadedEvents, encounter )

		if SessionState.BlockSpawns then
			waitUntil( "BlockSpawnsOff" )
		end
		wait( wave.StartDelay, encounter.SpawnThreadName )
		
		if encounter.WaveStartPresentationFunction ~= nil then
			CallFunctionName(encounter.WaveStartPresentationFunction, encounter, wave)
		end

		if wave.OverrideValues ~= nil then
			OverwriteTableKeys(encounter, wave.OverrideValues)
			encounter.ActiveEnemyCap = CalculateActiveEnemyCap( CurrentRun, CurrentRun.CurrentRoom, encounter )
		end
		
		if encounter.ProximitySpawnTriggerType ~= nil then
			local proximitySpawnTriggerIds = {}
			if encounter.ProximitySpawnTriggerStartsInactive then
				proximitySpawnTriggerIds = GetInactiveIdsByType({ Name = encounter.ProximitySpawnTriggerType })
			else
				proximitySpawnTriggerIds = GetIdsByType({ Name = encounter.ProximitySpawnTriggerType })
			end

			encounter.ProximitySpawnTriggerId = GetRandomValue( proximitySpawnTriggerIds )
			DebugAssert({ Condition = encounter.ProximitySpawnTriggerId ~= nil, Text = "No ProximitySpawnTriggerType found for encounter", Owner = "Eduardo" })
			Activate({ Id = encounter.ProximitySpawnTriggerId })

			if encounter.SpawnNearProximitySpawnTrigger then
				encounter.SpawnNearId = encounter.ProximitySpawnTriggerId
			end

			local spawnTriggerNotify = "PortalWithinDistance"
			NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = encounter.ProximitySpawnTriggerId, Distance = encounter.ProximitySpawnTriggerDistance or 300, Notify = spawnTriggerNotify })
			waitUntil(spawnTriggerNotify, encounter.EncounterThreadName)
		end

		WaveStartChanges(wave, encounter)

		local preSpawnOverrides = nil
		local nextSpawnArgs = {}
		nextSpawnArgs.RecursiveWait = 0.03
		if waveNum == 1 and encounter.PreSpawned then
			encounter.PreSpawning = false
		else
			encounter.Spawns = {}
			AddEncounterLayer( CurrentRun, CurrentRun.CurrentRoom, encounter, wave )

			if encounterData.PreSpawnEnemies and waveNum == 1 then
				encounter.PreSpawning = true
				preSpawnOverrides = encounterData.PreSpawnSpawnOverrides
				nextSpawnArgs.RequireMinEndPointDistance = encounter.PreSpawnMinEndPointDistance
			end
		end

		-- If you hit the cap during HandleEncounterPreSpawns()
		if GetActiveEnemyCount(encounter) >= encounter.ActiveEnemyCap then
			encounter.PreSpawning = false
			preSpawnOverrides = nil
		end

		local ignoreSpawnPreferences = encounter.IgnoreSpawnPreferences or false
		local storedSpawnInfo = nil
		while GetRemainingSpawns( CurrentRun, CurrentRun.CurrentRoom, encounter ) > 0 and encounter.InProgress do

			local waitForEnemyKilled = false

			if encounter.GroupReinforcements and encounter.WaitingForAllDead then
				if GetActiveEnemyCount(encounter) == 0 then
					encounter.WaitingForAllDead = false
					ignoreSpawnPreferences = true
				end
			end

			local nextSpawnInterval = RandomFloat( encounter.SpawnIntervalMin, encounter.SpawnIntervalMax )
			if encounterData.PreSpawnEnemies and encounter.PreSpawning and waveNum == 1 then
				nextSpawnInterval = 0
			end

			local spawnedId = nil
			local spawnInfo = storedSpawnInfo or GetNextSpawn( encounter )
			local newSpawnActiveCapWeight = 1
			if EnemyData[spawnInfo.Name] ~= nil and EnemyData[spawnInfo.Name].ActiveCapWeight ~= nil then
				newSpawnActiveCapWeight = EnemyData[spawnInfo.Name].ActiveCapWeight
			end

			if GetActiveEnemyCount( encounter ) <= encounter.ActiveEnemyCap - newSpawnActiveCapWeight and not encounter.WaitingForAllDead then
				storedSpawnInfo = nil
				spawnedId = HandleNextSpawn( encounter, ignoreSpawnPreferences, spawnInfo, preSpawnOverrides, nextSpawnArgs )
				if spawnedId == nil or GetActiveEnemyCount( encounter ) >= encounter.ActiveEnemyCap then
					-- Hit cap
					if encounter.NoReinforcements then
						encounter.ForceEnd = true
					else
						waitForEnemyKilled = true
					end
					if encounter.RemoveDistanceReqsForReinforcements then
						encounter.RequireMinPlayerDistance = nil
					end
					encounter.PreSpawning = false
					preSpawnOverrides = nil

					if encounter.ReinforcementsDataOverride ~= nil then
						OverwriteTableKeys( encounter, encounter.ReinforcementsDataOverride )
					end

					local minEnemiesLeft = 5
					if encounter.GroupReinforcements and GetRemainingSpawns( CurrentRun, CurrentRun.CurrentRoom, encounter ) > minEnemiesLeft then
						encounter.WaitingForAllDead = true
					end

					if encounter.GroupReinforcements and encounter.RequireNearPlayerDistance ~= nil then
						SessionMapState.SpawnPointsUsed = {}
					end
				end
			else
				storedSpawnInfo = spawnInfo
				--DebugPrint({ Text=encounter.Name.." is waiting to spawn "..spawnInfo.Name.." with weight "..newSpawnActiveCapWeight })
			end

			-- Prevent soft lock if no enemy spawned
			if spawnedId == nil and (nextSpawnInterval == nil or nextSpawnInterval <= 0) then
				nextSpawnInterval = 0.1
			end

			if waitForEnemyKilled then
				waitUntil( "RequiredEnemyKilled" )
				if CheckCancelSpawns(CurrentRun.CurrentRoom, encounter) then
					encounter.SpawnsComplete = true
					return
				end
				nextSpawnInterval = nextSpawnInterval
				nextSpawnInterval = math.max( nextSpawnInterval, 0.03 ) -- Don't handle the next spawn on the same frame as the last kill
			end

			if wave.SpawnedLastOfPriorityGroup and not wave.PausedAfterPriorityGroup and GetRemainingSpawns( CurrentRun, CurrentRun.CurrentRoom, encounter ) > 1 then
				nextSpawnInterval = EncounterData[encounter.Name].PauseDurationAfterPriorityGroup or nextSpawnInterval
				wave.PausedAfterPriorityGroup = true
			end

			--DebugAssert({ Condition = nextSpawnInterval > 0, Text = "0 spawn interval may cause freeze.", Owner = "Eduardo" })
			if SessionState.BlockSpawns then
				waitUntil( "BlockSpawnsOff" )
			end
			if encounter.ForceEnd then
				encounter.SpawnsComplete = true
				return
			end
			wait( nextSpawnInterval, encounter.SpawnThreadName )

		end

		if encounter.ForceEnd then
			encounter.SpawnsComplete = true
			return
		end

		if encounter.ProximitySpawnTriggerType ~= nil then
			thread(CheckSpawnNearIdEndPresentation, encounter.ProximitySpawnTriggerId)
		end

		if waveNum < waveCount and not wave.SkipWaitForAllDead then
			CheckForEncounterEnemiesDead( encounter )
		end

		if encounterData.AggroRemainingEnemiesOnWaveStart then
			for id, v in pairs(encounter.ActiveSpawns) do
				if ActiveEnemies[id] ~= nil and not ActiveEnemies[id].IsDead then
					thread( AggroUnit, ActiveEnemies[id] )
				end
			end
		end
	end

	encounter.SpawnsComplete = true
end

function WaveStartChanges(wave, encounter)
	if wave.EnableRoomTraps then
		EnableRoomTraps( )
	end

	if wave.DisableRoomTraps then
		DisableRoomTraps( )
	end

	if wave.PauseHazards then
		encounter.PauseHazards = true
	end

	if wave.UnpauseHazards then
		encounter.PauseHazards = false
	end
end

function HandleNextSpawn( encounter, ignoreSpawnPreferences, spawnInfo, overrides, args )
	local spawnInfo = spawnInfo or GetNextSpawn( encounter )
	local encounterData = EncounterData[encounter.Name] or encounter
	args = args or {}

	if spawnInfo == nil then
		DebugPrint({ Text = "Nothing spawned!" })
		return nil
	end
	local originalSpawnInfo = spawnInfo

	if EnemyData[spawnInfo.Name] == nil then
		DebugPrint({ Text = "Invalid name: "..spawnInfo.Name })

		-- Back Compat: If the enemy we're trying to spawn is invalid, attempt
		-- to choose another one from the encounter's EnemySet
		local validEnemyName = spawnInfo.Name
		local tries = 0
		local maxTries = TableLength( encounter.EnemySet )
		while EnemyData[validEnemyName] == nil and tries < maxTries do
			validEnemyName = GetRandomValue(encounter.EnemySet)
			tries = tries + 1
		end

		DebugAssert({ Condition = tries < maxTries, Text = "Failed to find another enemy to spawn. The game may hang because there is nothing to spawn.", Owner = "Eduardo" })
		if tries >= maxTries then
			return
		end

		spawnInfo.Name = validEnemyName
	end

	if not args.IgnoreShrineOverrides and not encounterData.BlockNextBiomeEnemyShrineUpgrade and not EnemyData[spawnInfo.Name].BlockNextBiomeEnemyShrineUpgrade then
		local nextRoomSet = NextRoomSets[CurrentRun.CurrentRoom.RoomSetName]
		if nextRoomSet == nil or ( GameState.BiomeVisits[nextRoomSet] or 0 ) > 0 then
			local nextBiomeChance = GetShrineUpgradeChangeValue( "NextBiomeEnemyShrineUpgrade" )
			if RandomChance( nextBiomeChance ) then
				spawnInfo = ShallowCopyTable( spawnInfo )
				local originalName = spawnInfo.Name
				--DebugPrint({ Text = "originalName = "..originalName })
				local swapMap = MetaUpgradeData.NextBiomeEnemyShrineUpgrade.SwapMap[originalName]
				if swapMap ~= nil then
					spawnInfo.Name = swapMap.Name
					--DebugPrint({ Text = "spawnInfo.Name = "..spawnInfo.Name })
					spawnInfo.SpawnOverrides = spawnInfo.SpawnOverrides or {}
					spawnInfo.SpawnOverrides.RequiredSpawnPoint = swapMap.RequiredSpawnPoint or "nil"
					spawnInfo.SpawnOverrides.ActiveCapWeight = swapMap.ActiveCapWeight
				else
					local nextEnemySet = MetaUpgradeData.NextBiomeEnemyShrineUpgrade.BiomeEnemySets[CurrentRun.CurrentRoom.RoomSetName]
					if nextEnemySet ~= nil then
						spawnInfo.Name = GetRandomValue( nextEnemySet )
						--DebugPrint({ Text = "spawnInfo.Name = "..spawnInfo.Name })
						spawnInfo.SpawnOverrides = spawnInfo.SpawnOverrides or {}
						spawnInfo.SpawnOverrides.RequiredSpawnPoint = "nil"
					end
				end
			end
		end
	end

	local newEnemy = DeepCopyTable( EnemyData[spawnInfo.Name] )

	if spawnInfo.SpawnOverrides ~= nil then
		OverwriteTableKeys( newEnemy, spawnInfo.SpawnOverrides )
	end

	if spawnInfo.SpawnDefaultAIDataOverrides ~= nil then
		OverwriteTableKeys( newEnemy.DefaultAIData, spawnInfo.SpawnDefaultAIDataOverrides)
	end 

	if spawnInfo.SpawnOnIds == nil then
		spawnInfo.SpawnOnIds = GetIds({ Name = spawnInfo.SpawnPointGroupName })
	end

	local spawnPointId = spawnInfo.SpawnOnId or RemoveRandomValue(CurrentRun.CurrentRoom.SpawnOnIds) or RemoveRandomValue(spawnInfo.SpawnOnIds)
 	
	if spawnPointId == nil or not IsAlive({ Id = spawnPointId }) then
		spawnPointId = SelectSpawnPoint( CurrentRun.CurrentRoom, newEnemy, encounter, args )
	end

	if spawnPointId == nil then
		return nil
	end

	if newEnemy.IsUnitGroup then
		SpawnUnitGroup(newEnemy, encounter, spawnInfo, spawnPointId)
		if not originalSpawnInfo.InfiniteSpawns then
			originalSpawnInfo.RemainingSpawns = originalSpawnInfo.RemainingSpawns - 1
		end
		return 1
	end

	if encounter.SpawnAggroed then
		newEnemy.StartAggroed = true
	end

	if ignoreSpawnPreferences then
		newEnemy.PreferredSpawnPoint = nil
	end

	local spawnPointOffset = { X = RandomInt( -5, 5 ), Y = RandomInt( -5, 5 ) }

	if encounterData.PreSpawnEnemies and encounter.PreSpawning and encounter.CurrentWaveNum == 1 then
		newEnemy.AggroReactionTimeMin = newEnemy.PreSpawnAggroReactionTimeMin
		newEnemy.AggroReactionTimeMax = newEnemy.PreSpawnAggroReactionTimeMax
		newEnemy.AIWakeDelay = encounter.PreSpawnAIWakeDelay
		newEnemy.UseActivatePresentation = false
	end

	newEnemy.ObjectId = SpawnUnit({ Name = newEnemy.Name, Group = "Standing", DestinationId = spawnPointId, OffsetX = spawnPointOffset.X, OffsetY = spawnPointOffset.Y, ForceToValidLocation = true })

	if encounterData.SpawnOverrides ~= nil then
		OverwriteTableKeys( newEnemy, encounterData.SpawnOverrides)
	end

	if encounterData.SpawnDefaultAIDataOverrides ~= nil then
		OverwriteTableKeys( newEnemy.DefaultAIData, encounterData.SpawnDefaultAIDataOverrides)
	end 

	if overrides ~= nil then
		for key, value in pairs( overrides ) do
			newEnemy[key] = value
		end
	end

	encounter.ActiveSpawns[newEnemy.ObjectId] = true
	newEnemy.Encounter = encounter

	newEnemy.OccupyingSpawnPointId = spawnPointId
	if not args.SkipSetup then
		thread(SetupUnit, newEnemy, CurrentRun )
	end

	if encounter.ProximitySpawnTriggerType ~= nil then
		thread(CheckSpawnNearIdPresentation, encounter.ProximitySpawnTriggerId, newEnemy.ObjectId)
	end

	if not originalSpawnInfo.InfiniteSpawns then
		originalSpawnInfo.RemainingSpawns = originalSpawnInfo.RemainingSpawns - 1
	end

	return newEnemy.ObjectId
end

function GetNextSpawn( encounter )

	local forcedSpawn = nil
	local remainingSpawnInfo = {}
	local remainingPrioritySpawnInfo = {}
	local remainingPriorityGroupSpawnInfo = {}
	for k, spawnInfo in orderedPairs( encounter.Spawns ) do
		if spawnInfo.InfiniteSpawns or spawnInfo.RemainingSpawns > 0 then
			local enemyData = EnemyData[spawnInfo.Name]
			if enemyData ~= nil and enemyData.LargeUnitCap ~= nil and enemyData.LargeUnitCap > 0 then
				local largeUnitCount = 0
				-- @optimization Convert to buckets by type
				for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
					if enemy.LargeUnitCap ~= nil and enemyData.LargeUnitCap > 0 then
						largeUnitCount = largeUnitCount + 1
					end
				end
				if largeUnitCount < enemyData.LargeUnitCap then
					table.insert( remainingSpawnInfo, spawnInfo )
					if spawnInfo.PrioritySpawn then
						table.insert( remainingPrioritySpawnInfo, spawnInfo )
					end
				else
					DebugPrint({ Text = "Avoiding LargeUnitCap: "..enemyData.Name })
				end
			else
				table.insert( remainingSpawnInfo, spawnInfo )
				if spawnInfo.PrioritySpawn then
					table.insert( remainingPrioritySpawnInfo, spawnInfo )
				elseif encounter.PrioritizeGroup ~= nil and enemyData ~= nil and Contains(enemyData.Groups, encounter.PrioritizeGroup) then
					table.insert( remainingPriorityGroupSpawnInfo, spawnInfo )
				end
			end

			if spawnInfo.ForceFirst then
				forcedSpawn = spawnInfo
			end
		end
	end

	if forcedSpawn ~= nil then
		return forcedSpawn
	end

	local randomSpawnInfo = GetRandomValue( remainingPrioritySpawnInfo ) or GetRandomValue( remainingPriorityGroupSpawnInfo ) or GetRandomValue( remainingSpawnInfo )

	if encounter.PrioritizeGroup ~= nil then
		local wave = encounter.SpawnWaves[encounter.CurrentWaveNum]
		local remainingPriorityGroupSpawns = 0
		for k, spawnInfo in pairs(remainingPriorityGroupSpawnInfo) do
			remainingPriorityGroupSpawns = remainingPriorityGroupSpawns + spawnInfo.RemainingSpawns
		end
		if remainingPriorityGroupSpawns == 1 then
			wave.SpawnedLastOfPriorityGroup = true
		end
	end

	return randomSpawnInfo

end

function RestoreEncounterSpawn( encounter, enemyToRestore )

	local newEnemy = DeepCopyTable( EnemyData[enemyToRestore.Name] )

	if encounter.SpawnAggroed then
		newEnemy.StartAggroed = true
	end

	if ignoreSpawnPreferences then
		newEnemy.PreferredSpawnPoint = nil
	end

	local spawnPointId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = enemyToRestore.Location.X, LocationY = enemyToRestore.Location.Y, Group = "Standing" })

	--[[
	if encounterData.PreSpawnEnemies and encounter.PreSpawning and encounter.CurrentWaveNum == 1 then
		newEnemy.AggroReactionTimeMin = newEnemy.PreSpawnAggroReactionTimeMin
		newEnemy.AggroReactionTimeMax = newEnemy.PreSpawnAggroReactionTimeMax
		newEnemy.AIWakeDelay = encounter.PreSpawnAIWakeDelay
		newEnemy.UseActivatePresentation = false
	end
	]]

	newEnemy.ObjectId = SpawnUnit({ Name = newEnemy.Name, Group = "Standing", DestinationId = spawnPointId })

	--[[
	if spawnInfo.SpawnOverrides ~= nil then
		for key, value in pairs( spawnInfo.SpawnOverrides ) do
			newEnemy[key] = value
		end
	end
	]]

	if encounter.SpawnOverrides ~= nil then
		OverwriteTableKeys(newEnemy, encounter.SpawnOverrides)
	end

	encounter.ActiveSpawns[newEnemy.ObjectId] = true
	newEnemy.Encounter = encounter

	Destroy({ Id = spawnPointId })
	thread( SetupUnit, newEnemy, CurrentRun )

end

function RestoreEncounterObstacle( encounter, obstacleToRestore )
	local newObstacle = DeepCopyTable( ObstacleData[obstacleToRestore.Name] or {} )
	obstacleToRestore.Location = obstacleToRestore.Location or {}
	newObstacle.ObjectId = SpawnObstacle({ Name = obstacleToRestore.Name, DestinationId = obstacleToRestore.DestinationId, LocationX = obstacleToRestore.Location.X, LocationY = obstacleToRestore.Location.Y, Group = obstacleToRestore.GroupName or "Standing" })
	if obstacleToRestore.Angle ~= nil then
		SetAngle({ Id = newObstacle.ObjectId, Angle = obstacleToRestore.Angle })
	end
end

function SpawnUnitGroup(unitGroup, encounter, spawnInfo, spawnOnId)
	spawnInfo = DeepCopyTable(spawnInfo) or {}
	unitGroup.UnitIds = {}

	if spawnOnId == nil then
		return
	end

	for i, unitName in ipairs( unitGroup.UnitGroup ) do
		spawnInfo.Name = unitName
		local spawnOffsetAngle = i * (360 / #unitGroup.UnitGroup)
		local spawnOffset = CalcOffset( math.rad( spawnOffsetAngle ), unitGroup.SpawnOffset or 50 )
		spawnInfo.SpawnOnId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Standing", DestinationId = spawnOnId, OffsetX = spawnOffset.X, OffsetY = spawnOffset.Y })

		if encounter ~= nil then
			if unitGroup.GroupAI ~= nil then
				spawnInfo.SpawnOverrides = spawnInfo.SpawnOverrides or {}
				spawnInfo.SpawnOverrides.SkipAISetupOnActivate = true
			end
			if i == #unitGroup.UnitGroup then
				-- Last unit in group
				spawnInfo.SpawnOverrides.SetupGroupAI = true
				spawnInfo.SpawnOverrides.UnitGroupData = DeepCopyTable( unitGroup )
			end
			local newEnemyId = HandleNextSpawn( encounter, true, spawnInfo, nil, { IgnoreShrineOverrides = true } )
			table.insert( unitGroup.UnitIds, newEnemyId )
		else
			local enemyData = EnemyData[unitName]
			local newEnemy = DeepCopyTable( enemyData )
			newEnemy.ObjectId = SpawnUnit({ Name = enemyData.Name, Group = "Standing", DestinationId = spawnInfo.SpawnOnId, OffsetX = spawnOffset.X, OffsetY = spawnOffset.Y })
			table.insert( unitGroup.UnitIds, newEnemy.ObjectId )
			if spawnInfo.SpawnOverrides ~= nil then
				OverwriteTableKeys( newEnemy, spawnInfo.SpawnOverrides )
			end
			thread( SetupUnit, newEnemy, CurrentRun )
			
			if unitGroup.GroupAI ~= nil then
				newEnemy.SkipAISetupOnActivate = true
			end
			if i == #unitGroup.UnitGroup then
				-- Last unit in group
				newEnemy.SetupGroupAI = true
				newEnemy.IsGroupLeader = true
				newEnemy.UnitGroupData = DeepCopyTable( unitGroup )
			end
		end

		Destroy({ Id = spawnInfo.SpawnOnId })
		wait( 0.02 ) -- Must space out spawns
	end

	return unitGroup.UnitIds
end

function SelectSpawnPoint( currentRoom, enemy, encounter, args, depth )

	args = args or {}
	enemy = enemy or {}
	encounter = encounter or {}
	depth = (depth or 0) + 1
	--DebugPrint({ Text = "depth = "..depth })

	if encounter.SpawnOnProximitySpawnTrigger then
		return encounter.ProximitySpawnTriggerId
	end

	local shuffledSpawnPointIds = {}
	local requiredSpawnPointType = args.RequiredSpawnPoint or enemy.RequiredSpawnPoint or encounter.RequiredSpawnPoint
	if requiredSpawnPointType ~= nil then
		if currentRoom.SpawnPoints[requiredSpawnPointType] == nil then
			local ids = GetIdsByType({ Name = requiredSpawnPointType })
			table.sort( ids )
			currentRoom.SpawnPoints[requiredSpawnPointType] = ShallowCopyTable( ids )
		end
		shuffledSpawnPointIds = FYShuffle( currentRoom.SpawnPoints[requiredSpawnPointType] or MapState.SpawnPoints )
	elseif args.CycleSpawnPoints then
		if IsEmpty( MapState.CyclingSpawnPoints ) then
			MapState.CyclingSpawnPoints = FYShuffle( MapState.SpawnPoints )
		end
		shuffledSpawnPointIds = MapState.CyclingSpawnPoints
	elseif args.PreferredSpawnPointGroup then
		shuffledSpawnPointIds = FYShuffle( GetIds({ Name = args.PreferredSpawnPointGroup }) )
	elseif args.PreferredSpawnPoint then
		local ids = GetIdsByType({ Name = args.PreferredSpawnPoint })
		table.sort( ids )
		shuffledSpawnPointIds = FYShuffle( ids )
	elseif enemy.PreferredSpawnPoint ~= nil then
		if currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] == nil then
			currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] = ShallowCopyTable( GetIdsByType({ Name = enemy.PreferredSpawnPoint }) )
		end
		shuffledSpawnPointIds = FYShuffle( currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] or MapState.SpawnPoints )
	else
		shuffledSpawnPointIds = FYShuffle( encounter.NearbySpawnPoints or MapState.SpawnPoints )
	end

	args.SpawnAwayFromTypes = args.SpawnAwayFromTypes or enemy.SpawnAwayFromTypes
	args.SpawnAwayFromTypesDistance = args.SpawnAwayFromTypesDistance or enemy.SpawnAwayFromTypesDistance
	args.SpawnCloseToGroup = args.SpawnCloseToGroup or enemy.SpawnCloseToGroup

	--DebugPrint({ Text = "TableLength(shuffledSpawnPointIds) = "..TableLength(shuffledSpawnPointIds) })
	for k, id in ipairs( shuffledSpawnPointIds ) do
		if IsSpawnPointEligible( id, encounter, currentRoom, args ) then
			if args.CycleSpawnPoints then
				RemoveValueAndCollapse( MapState.CyclingSpawnPoints, id )
			end
			return id
		end
	end

	-- Nothing eligible
	if args.SpawnCloseToGroup ~= nil then
		args.SpawnCloseToGroup = nil
		enemy.SpawnCloseToGroup = nil
		wait( args.RecursiveWait )
		local id = SelectSpawnPoint( currentRoom, enemy, encounter, args, depth )
		return id
	end
	if args.PreferredSpawnPointGroup ~= nil then
		args.PreferredSpawnPointGroup = nil
		wait( args.RecursiveWait )
		local id = SelectSpawnPoint( currentRoom, enemy, encounter, args, depth )
		return id
	end
	if args.PreferredSpawnPoint ~= nil then
		args.PreferredSpawnPoint = nil
		wait( args.RecursiveWait )
		local id = SelectSpawnPoint( currentRoom, enemy, encounter, args, depth )
		return id
	end
	if enemy.PreferredSpawnPoint ~= nil then
		enemy.PreferredSpawnPoint = nil
		wait( args.RecursiveWait )
		local id = SelectSpawnPoint( currentRoom, enemy, encounter, args, depth )
		return id
	end

	if args.RequireMinEndPointDistance ~= nil and args.RequireMinEndPointDistance > 100 then
		--DebugPrint({ Text = "No eligible spawn point nearby, increasing eligible distance." })
		args.RequireMinEndPointDistance = args.RequireMinEndPointDistance * 0.5
		wait( args.RecursiveWait )
		local id = SelectSpawnPoint( currentRoom, enemy, encounter, args, depth )
		return id
	end

	if encounter.RequireNearPlayerDistance ~= nil and encounter.RequireNearPlayerDistance < 50000 then
		--DebugPrint({ Text = "No eligible spawn point nearby, increasing eligible distance." })
		encounter.RequireNearPlayerDistance = encounter.RequireNearPlayerDistance * 1.5
		wait( args.RecursiveWait )
		local id = SelectSpawnPoint( currentRoom, enemy, encounter, args, depth )
		return id
	end

	if encounter.RequireMinPlayerDistance ~= nil and encounter.RequireMinPlayerDistance > 100 then
		--DebugPrint({ Text = "No eligible spawn point nearby, increasing eligible distance." })
		encounter.RequireMinPlayerDistance = encounter.RequireMinPlayerDistance * 0.5
		wait( args.RecursiveWait )
		local id = SelectSpawnPoint( currentRoom, enemy, encounter, args, depth )
		return id
	end

	if encounter.MinPlayerArc ~= nil then
		--DebugPrint({ Text = "No eligible spawn point nearby, removing arc requirements." })
		encounter.MinPlayerArc = nil
		wait( args.RecursiveWait )
		local id = SelectSpawnPoint( currentRoom, enemy, encounter, args, depth )
		return id
	end

	--DebugPrint({ Text = "Resetting spawn points, no eligible ids found within 5000 units" })
	if args.AllowNoSpawnPoint then
		return
	end
	
	if encounter.Name ~= nil then
		SessionMapState.SpawnPointsUsed = {}
	else
		--DebugPrint({ Text = "No Spawn Point found!" })
	end
end

function UnoccupySpawnPoint(spawnPointId)
	SessionMapState.SpawnPointsUsed[spawnPointId] = nil
end

function UnoccupySpawnPointOnDistance(enemy, spawnPointId, distance)
	wait(0.1)
	enemy.SpawnPointNotify = "OutsideSpawnPointDistance_"..enemy.Name.."_"..enemy.ObjectId
	NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = spawnPointId, Distance = distance, Notify = enemy.SpawnPointNotify })
	waitUntil( enemy.SpawnPointNotify )
	if SessionMapState.SpawnPointsUsed[spawnPointId] == enemy.ObjectId then
		UnoccupySpawnPoint(spawnPointId)
	end
end

function IsSpawnPointEligible( spawnPointId, encounter, currentRoom, args )

	if SessionMapState.SpawnPointsUsed[spawnPointId] ~= nil then
		return false
	end

	if args.CheckRewardPointsUsed and MapState.RewardPointsUsed[spawnPointId] ~= nil then
		return false
	end

	if args.IgnoreIds ~= nil and Contains(args.IgnoreIds, spawnPointId) then
		return false
	end

	if encounter.SpawnNearId ~= nil and encounter.SpawnRadius ~= nil then
		SessionMapState.DistanceCache[spawnPointId] = SessionMapState.DistanceCache[spawnPointId] or {}
		if encounter.ForceDistanceCalculation or encounter.SpawnNearId == CurrentRun.Hero.ObjectId or ActiveEnemies[encounter.SpawnNearId] ~= nil then
			SessionMapState.DistanceCache[spawnPointId][encounter.SpawnNearId] = GetDistance({ Id = spawnPointId, DestinationId = encounter.SpawnNearId })
		end
		local distance = SessionMapState.DistanceCache[spawnPointId][encounter.SpawnNearId] or GetDistance({ Id = spawnPointId, DestinationId = encounter.SpawnNearId })
		SessionMapState.DistanceCache[spawnPointId][encounter.SpawnNearId] = distance
		if distance > encounter.SpawnRadius then
			return false
		end
		if encounter.SpawnRadiusMin ~= nil and distance < encounter.SpawnRadiusMin then
			return false
		end
	end

	if args.SpawnNearId ~= nil and args.SpawnRadius ~= nil then
		local distance = GetDistance({ Id = spawnPointId, DestinationId = args.SpawnNearId })
		if distance > args.SpawnRadius then
			return false
		end
		if args.SpawnRadiusMin ~= nil and distance < args.SpawnRadiusMin then
			return false
		end
	end

	local minPlayerArc = args.MinPlayerArc or encounter.MinPlayerArc
	local maxPlayerArc = args.MaxPlayerArc or encounter.MaxPlayerArc
	if minPlayerArc ~= nil or maxPlayerArc ~= nil then
		local arcDistance = CalcArcDistance( GetAngle({ Id = CurrentRun.Hero.ObjectId }), GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = spawnPointId }) )
		if minPlayerArc ~= nil and arcDistance < minPlayerArc then
			return false
		end

		if maxPlayerArc ~= nil and arcDistance > maxPlayerArc then
			return false
		end
	end

	if args.RequireMinEndPointDistance ~= nil then
		local endPoint = currentRoom.HeroEndPoint or GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetIdsByType({ Name = "HeroEnd" }) }) or CurrentRun.Hero.ObjectId
		local closestEndPoint = GetClosest({ Id = spawnPointId, DestinationId = endPoint, Distance = args.RequireMinEndPointDistance })
		if closestEndPoint ~= 0 then
			return false
		end
	end

	local distanceToHero = nil
	if encounter.RequireMinPlayerDistance ~= nil and currentRoom.HeroEndPoint ~= nil then
		distanceToHero = distanceToHero or GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = spawnPointId })
		if distanceToHero < encounter.RequireMinPlayerDistance then
			return false
		end
	end

	if encounter.RequireNearPlayerDistance ~= nil then
		distanceToHero = distanceToHero or GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = spawnPointId })
		if distanceToHero > encounter.RequireNearPlayerDistance then
			return false
		end
	end

	if encounter.EligibleSpawnPoints ~= nil then
		if not Contains(encounter.EligibleSpawnPoints, spawnPointId) then
			return false
		end
	end

	if args.SpawnAwayFromTypes ~= nil then
		local typeIds = GetClosestIds({ Id = spawnPointId, DestinationIds = GetIdsByType({ Names = args.SpawnAwayFromTypes }), Distance = args.SpawnAwayFromTypesDistance or 300 })
		if #typeIds > 0 then
			return false
		end
	end

	if args.SpawnCloseToGroup ~= nil then
		local typeIds = GetClosestIds({ Id = spawnPointId, DestinationIds = GetIds({ Name = args.SpawnCloseToGroup }), Distance = args.SpawnCloseToGroupDistance or 300 })
		if #typeIds == 0 then
			return false
		end
	end

	if args.RequireLoS then
		local hasLoS = HasLineOfSight({ Id = spawnPointId, DestinationId = args.LoSTarget, StopsUnits = true,
							LineOfSightBuffer = args.LoSBuffer or 50,
							LineOfSightEndBuffer = args.LoSEndBuffer or 50,  })
		if not hasLoS then
			wait( 0.02 ) -- Distribute workload
			return false
		end
	end

	return true
end

ConstantsData.MaxActiveEnemyCount = 10

function CalculateActiveEnemyCap( currentRun, currentRoom, currentEncounter )
	local encounterData = EncounterData[currentEncounter.Name] or currentEncounter
	local enemyCap = currentEncounter.ActiveEnemyCapBase or ConstantsData.MaxActiveEnemyCount
	local maxEnemyCap =  encounterData.ActiveEnemyCapMax or ConstantsData.MaxActiveEnemyCount
	local depth = currentRun.BiomeDepthCache or 0
	if currentEncounter.UseRunDepth then
		depth = currentRun.RunDepthCache or 0
	elseif currentEncounter.UseEncounterDepth then
		depth = currentRun.BiomeEncounterDepth or 0
	end

	if currentEncounter.ActiveEnemyCapDepthRamp then
		enemyCap = enemyCap + (depth * currentEncounter.ActiveEnemyCapDepthRamp)
	end
	if currentEncounter.ActiveEnemyCapMin ~= nil and currentEncounter.ActiveEnemyCapMax ~= nil then
		enemyCap = RandomInt(currentEncounter.ActiveEnemyCapMin, currentEncounter.ActiveEnemyCapMax)
	end

	enemyCap = enemyCap + ( GetNumShrineUpgrades( "EnemyCountShrineUpgrade" ) * 0.4 )

	if currentEncounter.ActiveEnemyCapBonus ~= nil then
		enemyCap = enemyCap + currentEncounter.ActiveEnemyCapBonus
		--DebugPrint({ Text="Active Enemy Cap Bonus: +"..currentEncounter.ActiveEnemyCapBonus })
	end

	if currentEncounter.ActiveEnemyCapMaxModifier ~= nil then
		maxEnemyCap = maxEnemyCap + currentEncounter.ActiveEnemyCapMaxModifier
	end

	if enemyCap > maxEnemyCap then
		enemyCap = maxEnemyCap
	end

	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId then
		local assistUnit = ActiveEnemies[CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId]
		if assistUnit and not assistUnit.IsDead then
			local activeCapWeight = assistUnit.ActiveCapWeight or 1
			enemyCap = enemyCap + activeCapWeight
		end
	end

	if MapState ~= nil then
		for _, enemy in pairs (MapState.SpellSummons ) do
			local activeCapWeight = enemy.ActiveCapWeight or 1
			enemyCap = enemyCap + activeCapWeight
		end
	end
	
	if enemyCap > ConstantsData.MaxActiveEnemyCount then
		enemyCap = ConstantsData.MaxActiveEnemyCount
	end

	local debugCapOverride = GetConfigOptionValue({ Name = "DebugEnemyCapOverride" })
	if debugCapOverride > 0 then
		enemyCap = debugCapOverride
	end
	--DebugPrint({ Text = "Active Enemy Cap " .. enemyCap .. " = " .. (currentEncounter.ActiveEnemyCapBase or ConstantsData.MaxActiveEnemyCount) .. " (Base) + " .. (currentEncounter.ActiveEnemyCapDepthRamp or 0) .. " (ActiveEnemyCapDepthRamp) * " .. depth .. " (Depth)"  })
	return enemyCap
end

function HandleTimedSpawns( eventSource, args )

	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource

	local newSpawns = currentEncounter.SpawnWaves
	local nextLayerIndex = 1

	local timeLimit = currentEncounter.TimeLimit
	local startingTime = _worldTime
	currentEncounter.RemainingTime = timeLimit
	currentEncounter.TimeModifier = currentEncounter.TimeModifier or 0

	CheckObjectiveSet( currentEncounter.EncounterType )
	CheckObjectiveSet( EncounterData[currentEncounter.Name].ObjectiveSets )

	UpdateObjective( currentEncounter.EncounterType, "RemainingSeconds", math.ceil(currentEncounter.RemainingTime))
	thread( SurvivalObjectivePresentation, currentEncounter )

	currentEncounter.ActiveEnemyCap = CalculateActiveEnemyCap(currentRun, currentRoom, currentEncounter)

	if currentEncounter.SpawnHazards then
		thread(HandleHazardSpawns, currentRoom, currentEncounter)
	end

	if SessionState.BlockSpawns then
		waitUntil( "BlockSpawnsOff" )
	end
	wait( 1.0, RoomThreadName )

	local spawnIntervalStart = 0
	local nextSpawnInterval = 0

	local lastTrapActivateTime = 0
	local trapType = GetRandomValue(currentEncounter.TrapTypes)
	currentEncounter.DisabledTrapIds = GetIds({ Name = "Traps" })
	currentEncounter.EnabledTrapIds = {}

	-- While there is still time
	currentEncounter.TimeIsUp = false
	while currentEncounter.RemainingTime > 0 do
		-- Check if there are new spawn layers to add
		if newSpawns ~= nil and newSpawns[nextLayerIndex] ~= nil and currentEncounter.RemainingTime <= newSpawns[nextLayerIndex].AddAtTime then
			AddEncounterLayer(currentRun, currentRoom, currentEncounter, newSpawns[nextLayerIndex])
			nextLayerIndex = nextLayerIndex + 1
		end

		-- Spawn a new unit
		if _worldTime > spawnIntervalStart + nextSpawnInterval then
			if currentEncounter.ActiveEnemyCap == nil or GetActiveEnemyCount(currentEncounter) < currentEncounter.ActiveEnemyCap then
				HandleNextSpawn(currentEncounter)
			elseif GetActiveEnemyCount(currentEncounter) >= currentEncounter.ActiveEnemyCap then
				if currentEncounter.SpawnIntervalMin == 0 and currentEncounter.SpawnIntervalMax == 0 then
					nextSpawnInterval = 0.2
				end
			end

			nextSpawnInterval = RandomFloat( currentEncounter.SpawnIntervalMin, currentEncounter.SpawnIntervalMax )
			spawnIntervalStart = _worldTime
		end

		if CurrentRun.CurrentRoom.ElapsedTimeMultiplier then
			startingTime = startingTime + ( 1 - CurrentRun.CurrentRoom.ElapsedTimeMultiplier) * 0.25
		end
		if SessionState.BlockSpawns then
			waitUntil( "BlockSpawnsOff" )
		end
		wait( 0.25, RoomThreadName )
		currentEncounter.RemainingTime = timeLimit - (_worldTime - startingTime) + currentEncounter.TimeModifier
	end
	currentEncounter.TimeIsUp = true
	--thread( HadesSpeakingPresentation, eventSource, { VoiceLines = GlobalVoiceLines.SurvivalEncounterSurvivedVoiceLines } )

	if currentEncounter.EncounterType == "SurvivalChallenge" then
		thread(DestroyRequiredKills, ({ BlockLoot = true, DestroyInterval = currentEncounter.DestroyEnemyInterval or 0.05, BlockDeathWeapons = true }) )
	end
	thread( MarkObjectiveComplete, currentEncounter.EncounterType )
end

function AddEncounterLayer( currentRun, currentRoom, currentEncounter, layerData )

	for k, spawnInfo in pairs( layerData.Spawns ) do
		spawnInfo.RemainingSpawns = CalcTotalSpawns( currentRun, currentRoom, currentEncounter, spawnInfo )

		if spawnInfo.Name == nil then
			spawnInfo.Name = k
			DebugPrint({ Text = "WARNING "..k.."'s spawnInfo had no name, adding now" })
		end

		currentEncounter.Spawns[spawnInfo.Name] = spawnInfo
		--DebugPrint({ Text = spawnInfo.Name.." added to encounter ("..spawnInfo.RemainingSpawns..")" })
	end
end

function GetActiveEnemyCount(encounter)
	if encounter ~= nil and encounter.UseEncounterActiveCap then
		return GetEncounterActiveEnemyCount( encounter )
	end
	local count = 0
	for id, enemy in pairs( ShallowCopyTable( RequiredKillEnemies ) ) do
		if not enemy.SkipActiveCount then
			local activeCapWeight = enemy.ActiveCapWeight or 1
			count = count + activeCapWeight
		end
	end
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId then
		local assistUnit = ActiveEnemies[CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId]
		if assistUnit and not assistUnit.IsDead then
			local activeCapWeight = assistUnit.ActiveCapWeight or 1
			count = count + activeCapWeight
		end
	end
	for _, enemy in pairs (MapState.SpellSummons ) do
		local activeCapWeight = enemy.ActiveCapWeight or 1
		count = count + activeCapWeight
	end
	return count
end

function GetEncounterActiveEnemyCount( encounter )
	local count = 0
	for id, k in pairs( encounter.ActiveSpawns ) do
		local enemy = ActiveEnemies[id]
		if enemy ~= nil and not enemy.SkipActiveCount then
			local activeCapWeight = enemy.ActiveCapWeight or 1
			count = count + activeCapWeight
		end
	end
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId then
		local assistUnit = ActiveEnemies[CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId]
		if assistUnit and not assistUnit.IsDead then
			local activeCapWeight = assistUnit.ActiveCapWeight or 1
			count = count + activeCapWeight
		end
	end
	for _, enemy in pairs (MapState.SpellSummons ) do
		local activeCapWeight = enemy.ActiveCapWeight or 1
		count = count + activeCapWeight
	end
	--DebugPrint({ Text=encounter.Name.." Active Count: "..count })
	return count
end

function CheckForAllEnemiesDead( eventSource, args )
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource or CurrentRun.CurrentRoom.Encounter
	if not IsEmpty( RequiredKillEnemies ) or not IsEmpty( SessionMapState.ProjectilesCarryingSpawns ) then
		local notifyName = "AllRequiredKillEnemiesDead"
		waitUntil( notifyName, RoomThreadName )
		--DebugPrint({ Text = notifyName })
	end
	wait( 0.01 ) -- Let last killed enemy finish cleanup
	currentEncounter.InProgress = false
	OnAllEnemiesDead(currentRoom, currentEncounter)
end

function OnAllEnemiesDead(currentRoom, currentEncounter)
	local encounterData = EncounterData[currentEncounter.Name] or currentEncounter
	if currentEncounter.TimerBlock ~= nil then
		RemoveTimerBlock( CurrentRun, currentEncounter.TimerBlock )
	end

	if ShouldDoLastKillPresentation( currentEncounter ) then
		local lastKillFunctionName = currentEncounter.LastKillPresentationFunction or "LastKillPresentation"
		CallFunctionName( lastKillFunctionName, LastEnemyKilled, currentEncounter.LastKillPresentationFunctionArgs )
	end

	if encounterData.SkipOnAllEnemiesDeadCleanup then
		return
	end
	--ExpireProjectiles({ Names = { "RatPoisonShake", "RatDeathPuddle", "LavaPuddleLarge", "LavaSplash", "ArcherTrapWeapon", "ArcherTrapWeapon",
	--								"SteamTrap", "SteamTrapFast", "ZombieSpawnerLob", "ZombieSpawnerLob_Elite", "GreekFire", "ZombieHRFire", "PolyphemusBoulderSky" } })
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "Inked" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "StyxPoison" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "DamageOverTime" })
	if currentEncounter.PassiveRoomWeapons ~= nil then
		for k, id in pairs( currentEncounter.PassiveRoomWeapons ) do
			if ActiveEnemies[id] ~= nil then
				CleanupEnemy( ActiveEnemies[id] )
			end
		end
		Destroy({ Ids = currentEncounter.PassiveRoomWeapons })
	end

	local killHazardEnemies = { "LavaSplash" }
	for k, enemyType in pairs(killHazardEnemies) do
		for k, enemyId in pairs( GetIdsByType({ Name = enemyType }) ) do
			if ActiveEnemies[enemyId] ~= nil then
				Kill( ActiveEnemies[enemyId] )
			end
		end
	end
	SetThreadWait( "PolyphemusBoulderManager", 0.01 )

	thread(MarkObjectiveComplete, "KillRequiredEnemies")
	if currentEncounter.EncounterType == "PerfectClear" then
		--thread( HadesSpeakingPresentation, eventSource, { VoiceLines = { GlobalVoiceLines = "PerfectClearEncounterClearedVoiceLines" }, ColorGrade = "PerfectClear" } )
		if not currentEncounter.PlayerTookDamage then
			thread(MarkObjectiveComplete, "PerfectClear")
			thread( PlayVoiceLines, GlobalVoiceLines.PerfectClearEncounterFailedLines, true )
		end
		thread(MarkObjectiveComplete, "PerfectClearCleanup")
		thread( PlayVoiceLines, GlobalVoiceLines.PerfectClearEncounterClearedLines, true )
	end

	if currentEncounter.CheckInventoryObjective then
		CheckObjectiveSet( "OpenInventory" )
	end
end

function CheckForEncounterEnemiesDead( eventSource, args )
	args = args or {}
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource or CurrentRun.CurrentRoom.Encounter
	if args.RequiredRemainingCount ~= nil then
		currentEncounter.RequiredRemainingCountOverride = args.RequiredRemainingCount
	end
	local requiredRemainingCount = currentEncounter.RequiredRemainingCountOverride or currentEncounter.WaveRequiredRemainingCount or 0
	if currentEncounter.ActiveSpawns ~= nil and TableLength(currentEncounter.ActiveSpawns) > requiredRemainingCount then
		local notifyName = "RequiredEncounterEnemiesDead"..currentEncounter.Name
		waitUntil( notifyName )
		--DebugPrint({ Text = notifyName })
	end
	if args.RequiredRemainingCount ~= nil then
		currentEncounter.RequiredRemainingCountOverride = nil
	end
	if args.EndEncounterAfter then
		currentEncounter.InProgress = false
	end
	wait( 0.01 ) -- Let last killed enemy finish cleanup
	if currentEncounter.AllAddsDeadGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[currentEncounter.AllAddsDeadGlobalVoiceLines], true )
	end
	if args.EndEncounterAfter then
		OnAllEnemiesDead(currentRoom, currentEncounter)
	end
end

function ShouldDoLastKillPresentation( currentEncounter )
	if currentEncounter.SkipLastKillPresentation then
		return false
	end
	if CurrentRun.CurrentRoom.SkipLastKillPresentation then
		return false
	end
	if LastEnemyKilled == nil then
		return false
	end
	if SessionMapState.HandlingDeath then
		return false
	end
	local currentWaveNum = currentEncounter.CurrentWaveNum or 1
	if currentEncounter.SpawnWaves ~= nil and TableLength(currentEncounter.SpawnWaves) > currentWaveNum then
		return false
	end

	return true
end

function EncounterAudio( eventSource )

	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource or CurrentRun.CurrentRoom.Encounter
	local encounterData = EncounterData[currentEncounter.Name] or currentEncounter

	if encounterData.StartVoiceLines ~= nil then
		thread( PlayVoiceLines, encounterData.StartVoiceLines )
	end
	if encounterData.StartGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[encounterData.StartGlobalVoiceLines] )
	elseif not encounterData.SkipCombatBeginsVoiceLines and not GetConfigOptionValue({ Name = "EditingMode" }) then
		thread( PlayVoiceLines, GlobalVoiceLines.CombatBeginsVoiceLines, true )
	end
	thread( MusicMixer, encounterData )
end

function PostCombatAudio( eventSource )

	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource or CurrentRun.CurrentRoom.Encounter

	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentEncounter.Name] or currentEncounter

	if encounterData.PostCombatAudioEvents ~= nil then
		RunEventsGeneric( encounterData.PostCombatAudioEvents, currentEncounter )
	end
	if roomData.PostCombatAudioEvents ~= nil then
		RunEventsGeneric( roomData.PostCombatAudioEvents, currentRoom )
	end

	if currentRoom.MultipleEncountersData ~= nil and not currentEncounter.LastEncounter then
		return
	end

	local endMusicDuration = roomData.EndMusicOnCombatOver or encounterData.EndMusicOnCombatOver
	if endMusicDuration ~= nil then
		EndMusic( AudioState.MusicId, AudioState.MusicName, endMusicDuration )
	end
	if currentRoom.EndSecretMusicOnCombatOver ~= nil then
		SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 10 })
		AudioState.SecretMusicId = nil
		AudioState.SecretMusicName = nil
		ResumeMusic()
	end

	if currentEncounter.Spawns ~= nil or encounterData.ForceCombatResolvedAudio then
		-- VO
		if currentEncounter.ArtemisId == nil or currentEncounter.HeraclesId == nil then
			local currentHealth = currentRun.Hero.Health
			local currentHealthFraction = currentRun.Hero.Health / currentRun.Hero.MaxHealth
			local prevRoom = GetPreviousRoom( currentRun )
			local roomCombatResolvedVoiceLines = roomData.CombatResolvedVoiceLines
			if roomCombatResolvedVoiceLines ~= nil then
				thread( PlayVoiceLines, roomCombatResolvedVoiceLines, true )
			else
				-- if you suffered a lot of damage and were reduced to low health
				if prevRoom ~= nil and prevRoom.EndingHealth ~= nil and prevRoom.EndingHealth - currentHealth >= 25 and currentHealthFraction < 0.3 then
					thread( PlayVoiceLines, GlobalVoiceLines.CombatResolvedLowHealthVoiceLines, true )
				end
				thread( PlayVoiceLines, GlobalVoiceLines.CombatResolvedVoiceLines, true )
			end
		else
			-- @todo Presumably dead code with the above condition always true
			for k, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
				if unit.EncounterEndVoiceLines ~= nil then
					thread( PlayVoiceLines, unit.EncounterEndVoiceLines, nil, unit )
				end
			end
		end

		if MusicSection ~= 2 and not roomData.IgnorePostCombatGuitar then
			SetSoundCueValue({ Names = { "Guitar" }, Id = AudioState.MusicId, Value = 0, Duration = 0.25 })
		end
		if currentEncounter.MuteSecretMusicDrumsOnCombatOver and AudioState.SecretMusicId ~= nil then
			SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.SecretMusicId, Value = 0 })
		end

		CheckMusicEvents( currentRun, roomData.CombatOverMusicEvents or CombatOverMusicEvents )

	end

end

function TriggerPostBossEvents( eventSource, args )
	local delay = 0.5
	local keepsakeDelay = 3.5
	if GetTotalHeroTraitValue("PostBossCards") > 0 then
		AddRandomMetaUpgrades( GetTotalHeroTraitValue("PostBossCards"), { Delay = delay })
		delay = delay + keepsakeDelay
	end
		
	if HeroHasTrait("BossMetaUpgradeKeepsake") then
		local upgradeTrait = GetHeroTrait("BossMetaUpgradeKeepsake")
		if upgradeTrait.RemainingUses > 0 then
			AddRandomMetaUpgrades(2, { RarityLevel = GetTotalHeroTraitValue("PostBossCardRarity"), Delay = delay })
			UseHeroTraitsWithValue( "PostBossCardRarity" )
			upgradeTrait.CustomName = upgradeTrait.ZeroBonusTrayText or "BossMetaUpgradeKeepsake_Expired"
		end
	end
	for k, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.UsesAsBosses then
			trait.RemainingUses = trait.RemainingUses - 1
			if trait.RemainingUses <= 0 then
				table.insert( traitsToRemove, trait )
			end
			TraitUIUpdateText( trait )
		end
		if trait.Name == "LowHealthCritKeepsake" and IsTraitActive( trait ) then
			trait.CustomName = trait.ZeroBonusTrayText
			ReduceTraitUses( trait, { Force = true })

			trait.MaxHealthMultiplier = 1
			trait.CapMaxHealth = -1
			if trait.PropertyChanges and trait.PropertyChanges[1] then
				ApplyUnitPropertyChange( CurrentRun.Hero, trait.PropertyChanges[1], true, true)
				trait.PropertyChanges[1].ChangeValue = 1
			end
			ValidateMaxHealth()
			FrameState.RequestUpdateHealthUI = true
			if not currentEncounter or not currentEncounter.BlockPostBossKeepsakeExpiration then
				thread( LowHealthCritKeepsakeExpiredPresentation, trait )
			end
		end
	end
end
function StartDevotionTest( currentEncounter, args )
 
	thread( PlayVoiceLines, GlobalVoiceLines.DevotionLootGrantedVoiceLines )

	local lootA = GiveLoot({ OffsetX = -85, OffsetY = 35, ForceLootName = currentEncounter.LootAName, BlockRarities = { Duo = true }, SuppressSpawnSounds = true })
	lootA.CanReceiveGift = false
	lootA.BlockTextLines = true
	SetThingProperty({ Property = "SortBoundsScale", Value = 1, DestinationId = lootA.ObjectId })
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = lootA.ObjectId })

	local lootB = GiveLoot({ OffsetX = 85, OffsetY = -35, ForceLootName = currentEncounter.LootBName, BlockRarities = { Duo = true }, SuppressSpawnSounds = true })
	lootB.CanReceiveGift = false
	lootB.BlockTextLines = true
	SetThingProperty({ Property = "SortBoundsScale", Value = 1, DestinationId = lootB.ObjectId })
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = lootB.ObjectId })

	waitUntil( UIData.BoonMenuId )

	local lootAId = lootA.ObjectId
	local lootBId = lootB.ObjectId
	local newLoots = { lootAId, lootBId }
	-- upgrade enemies with alternate upgrade
	local chosenLootName = NotifyResultsTable[ UIData.BoonMenuId ]
	local alternateLootId = nil
	local alternateLootData = nil
	if lootA.Name == chosenLootName then
		alternateLootId = lootBId
		alternateLootData = lootB
	else
		alternateLootId = lootAId
		alternateLootData = lootA
	end
	currentEncounter.ChosenGodName = chosenLootName
	currentEncounter.SpurnedGodName = alternateLootData.Name

	if EnemyData[alternateLootData.Name.."RoomWeapon"] ~= nil then
		currentEncounter.SpawnPassiveRoomWeapons = currentEncounter.SpawnPassiveRoomWeapons or {}
		table.insert(currentEncounter.SpawnPassiveRoomWeapons, alternateLootData.Name.."RoomWeapon")
	end
	MapState.RejectedLoot = alternateLootData
	UseableOff({ Ids = newLoots })
	StartDevotionTestPresentation( CurrentRun.CurrentRoom, alternateLootData, alternateLootId )
	Destroy({ Ids = newLoots })
	EnableRoomTraps()
	MapState.RoomRequiredObjects[alternateLootId] = nil
	RemoveInputBlock({ Name = "DevotionTest" })
	wait(0.5)
	StartEncounterEffects( currentEncounter )
end

function StartApolloDevotionSound( eventSource, args, triggerArgs )
	if args.Cue then
		wait(0.85)
		if ProjectileExists({ Id = triggerArgs.ProjectileId }) then
			local apolloTarget = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY })
			local soundCue = PlaySound({ Name = args.Cue, Id = apolloTarget })
			SessionMapState.ApolloDevotionIds[ triggerArgs.ProjectileId ] = { Id = apolloTarget, SoundId = soundCue }
		end
	end
end

function EndApolloDevotionSound( eventSource, args, triggerArgs )
	local data = SessionMapState.ApolloDevotionIds[ triggerArgs.ProjectileId ]
	if data then
		StopSound({ Id = data.SoundId, Duration = 0.2 })
		Destroy({ Id = data.Id})
		SessionMapState.ApolloDevotionIds[ triggerArgs.ProjectileId ] = nil
	end
end

function TyphonTailIntro( eventSource, args )

	local unit = ActiveEnemies[args.TailId]

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpalePreFire" })
	AdjustZLocation({ Id = unit.ObjectId, Distance = 2000 })
	IgnoreGravity({ Id = unit.ObjectId })

	ShakeScreen({ Speed = 400, Distance = 8, FalloffSpeed = 1000, Duration = 1.0 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.15, Duration = 2.0, ZoomType = "Ease" })
	PlaySound({ Name = "/SFX/Enemy Sounds/Typhon/TailPreAttack" })

	wait(0.02)

	LockCamera({ Ids = { unit.ObjectId }, Duration = 1.0})
	CreateAnimation({ DestinationId = unit.ObjectId, Name = "FallingShadowTyphonTail" })
	
	wait(0.75)

	thread( PlayVoiceLines, HeroVoiceLines.TyphonIncursionVoiceLines )

	ObeyGravity({ Id = unit.ObjectId })

	wait(0.25)

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpaleFireA" })
	PlaySound({ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusRockThrowWhoosh" })

	wait(0.2)
	
	if args.DelayedStart then
		StartEncounterEffects( )
	end

	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.5, FalloffSpeed = 1400, Angle = 90 })
	CreateProjectileFromUnit({ Name = "TyphonTailImpale", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	CreateAnimation({ Name = "EnemyBurrowExitHuge", DestinationId = unit.ObjectId })

	wait(0.55)

	ShakeScreen({ Speed = 800, Distance = 15, Duration = 0.5, FalloffSpeed = 1400, Angle = 90 })
	CreateProjectileFromUnit({ Name = "TyphonTailImpale", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	CreateProjectileFromUnit({ Name = "TyphonTailShockwave", Id = unit.ObjectId, DestinationId = unit.ObjectId })
	
	wait(0.2)

	SetAnimation({ DestinationId = unit.ObjectId, Name = "Enemy_TyphonTail_ImpalePostFire" })

	if args.SetCameraClampIds ~= nil then
		SetCameraClamp({ Ids = args.SetCameraClampIds })
	end

	wait(0.5)

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.5 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 2.5, ZoomType = "Ease" })

	unit.ForcedNextWeapon = "TyphonRampage"

	thread(SetupBoss, unit)
	CurrentRun.CurrentRoom.BossId = args.TailId
	notifyExistingWaiters("TyphonTailAmbushComplete")

	StopAnimation({ DestinationId = unit.ObjectId, Name = "EnemyBurrowExitHuge", IncludeCreatedAnimations = true })
	SetSoundCueValue({ Names = { "Guitar", "Bass" }, Id = AudioState.MusicId, Value = 1.0, Duration = 0.3 })

end

function WaitForTyphonTailStart( eventSource, args )
	waitUntil("TyphonTailAmbushComplete")
end

function BossIntro( eventSource, args )

	if SessionState.BlockSpawns then
		waitUntil( "BlockSpawnsOff" )
	end

	HideCombatUI("BossIntro")
	AddInputBlock({ Name = "BossIntro" })
	AddTimerBlock( CurrentRun, "BossIntro" )
	ToggleCombatControl( {"AdvancedTooltip"}, false, "BossIntro")
	SessionMapState.BlockInfoBanners = true

	if args.StopSecretMusic and AudioState.SecretMusicId ~= nil then
		StopSecretMusic()
		ResumeMusic()
	end

	PlayVoiceLines( args.VoiceLines )

	local didPan = false
	if args.ProcessTextLinesIds ~= nil then
		for k, id in ipairs( args.ProcessTextLinesIds ) do
			if ActiveEnemies[id] ~= nil then

				wait( args.PreTextLinesWaitTime or 0.5, RoomThreadName )

				local enemy = ActiveEnemies[id]
				if not args.SkipAngleTowardTarget then
					AngleTowardTarget({ Id = id, DestinationId = CurrentRun.Hero.ObjectId })
				end
				local cameraDuration = args.DurationIn or 1.5
				if not args.SkipCameraPan then
					PanCamera({ Ids = args.PanTargetIds or id, Duration = cameraDuration, EaseIn = 0.05, EaseOut = 0.03 })
					didPan = true
				end
				if args.UsePanSound then
					PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })
				end

				local textLines = enemy.QueuedBossIntroTextLines or GetRandomEligibleTextLines( enemy, enemy.BossIntroTextLineSets, GetNarrativeDataValue( enemy, "BossIntroTextLinePriorities" ) )
				PlayTextLines( enemy, textLines, args )
				if textLines ~= nil and didPan then
					local remainingPanTime = cameraDuration - (args.TotalElapsedTime or 0)
					wait( remainingPanTime )
				end

				if not args.SkipBossMusic then
					StartBossRoomMusic()
				end
			end
		end
	end
	if args.ResetRoomZoom then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 6.0, ZoomType = "Ease" })
	end
	if args.SetCameraClampIds ~= nil then
		SetCameraClamp({ Ids = args.SetCameraClampIds })
	end

	if args.SetupBossIds ~= nil then
		for k, id in ipairs(args.SetupBossIds) do
			if ActiveEnemies[id] ~= nil then
				thread(SetupBoss, ActiveEnemies[id])
				-- used for Final Boss EM4
				CurrentRun.CurrentRoom.BossId = id
			end
		end
	end

	if args.UnlockDelay ~= nil then
		wait(args.UnlockDelay)
	end

	if args.SetupBossTypes ~= nil then
		for k, unitType in ipairs(args.SetupBossTypes) do
			for k, id in ipairs(GetIdsByType({ Name = unitType })) do
				if ActiveEnemies[id] ~= nil then
					thread(SetupBoss, ActiveEnemies[id])
					-- used for Final Boss EM4
					CurrentRun.CurrentRoom.BossId = id
				end
			end
		end
	end

	if args.SetupUnitIdAIs ~= nil then
		wait( 0.02 ) -- Space out activation
		for k, id in ipairs(args.SetupUnitIdAIs) do
			if ActiveEnemies[id] ~= nil then
				thread(SetupAI, ActiveEnemies[id])
			end
		end
	end

	if args.SetupUnitTypeAIs ~= nil then
		wait( 0.02 ) -- Space out activation
		for k, unitType in ipairs(args.SetupUnitTypeAIs) do
			for k, id in ipairs(GetIdsByType({ Name = unitType })) do
				if ActiveEnemies[id] ~= nil then
					thread(SetupAI, ActiveEnemies[id])
				end
			end
		end
	end
	
	if args.LockCameraWithBoss then
		LockCamera({ Ids = CombineTables({ CurrentRun.Hero.ObjectId }, args.SetupBossIds), Duration = args.DurationOut or 1.25, EaseIn = 0.04, EaseOut = 0.275 })
	elseif didPan then
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = args.DurationOut or 1.25, EaseIn = 0.04, EaseOut = 0.275 })
	end
	if args.BossIntroSound ~= nil then
		PlaySound({ Name = args.BossIntroSound, Id = CurrentRun.CurrentRoom.BossId })
	end
	if args.Music ~= nil then
		MusicPlayer( args.Music )
	end

	SessionMapState.BlockInfoBanners = false
	RemoveInputBlock({ Name = "BossIntro" })
	RemoveTimerBlock( CurrentRun, "BossIntro" )
	ToggleCombatControl( {"AdvancedTooltip"}, true, "BossIntro" )
	ShowCombatUI("BossIntro")
	if args.DelayedStart then
		StartEncounterEffects( )
	end
end

function SetupBoss(enemy)

	if SessionState.BlockSpawns then
		waitUntil( "BlockSpawnsOff" )
	end

	if enemy.FightStartGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[enemy.FightStartGlobalVoiceLines], nil, enemy )
	end

	if enemy.PreBossHealthBarSetupFunctionName ~= nil then
		CallFunctionName(enemy.PreBossHealthBarSetupFunctionName, enemy, enemy.PreBossHealthBarSetupFunctionArgs)
	end

	if not enemy.HideHealthBar then
		thread(CreateBossHealthBar, enemy)
	end
	wait(enemy.AISetupDelay)

	if enemy.PreBossAISetupFunctionName ~= nil then
		CallFunctionName(enemy.PreBossAISetupFunctionName, enemy)
	end

	SetupAI(enemy)
end

function BossStageTransition(boss, currentRun, aiStage)
	local bossId = boss.ObjectId

	if boss.SkipTransitionInvulnerability or aiStage.SkipTransitionInvulnerability then
		SetUnitVulnerable( boss )
	else
		SetUnitInvulnerable( boss )
	end

	if aiStage.MoveToId ~= nil then
		MoveWithinRange(boss, aiStage.MoveToId, boss)
	end

	if aiStage.ClearEffects then
		ClearAllEffects( boss ) 
	end

	if aiStage.TransitionAnimation then
		SetAnimation({ DestinationId = bossId, Name = aiStage.TransitionAnimation })
	end

	if aiStage.TransitionSound ~= nil then
		PlaySound({ Name = aiStage.TransitionSound })
	end

	if aiStage.MusicStemOff then
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { boss.MusicStem }, Value = 0.0, Duration = 1.0 })
	end

	if aiStage.MusicStemOn then
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { boss.MusicStem }, Value = 1.0, Duration = 1.0 })
	end

	if aiStage.LowPassOn then
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 1.0 })
	end

	if aiStage.LowPassOff then
		SetSoundCueValue({ Id = AudioState.MusicId, Names = { "LowPass" }, Value = 0.0, Duration = 1.0 })
	end

	if aiStage.MusicSection then
		SetSoundCueValue({ Names = { "Section" }, Id = AudioState.MusicId, Value = aiStage.MusicSection })
	end

	if aiStage.PlaySound ~= nil then
		PlaySound({ Id = boss.ObjectId, Name = aiStage.PlaySound })
	end

	if aiStage.CombatText ~= nil then
		thread(InCombatText, bossId, aiStage.CombatText, 3)
	end

	if aiStage.StageTransitionVoiceLines ~= nil and IsAlive({ Id = bossId }) then
		thread( PlayVoiceLines, aiStage.StageTransitionVoiceLines, nil, boss )
	end
	if aiStage.StageTransitionGlobalVoiceLines ~= nil and IsAlive({ Id = bossId }) then
		thread( PlayVoiceLines, GlobalVoiceLines[aiStage.StageTransitionGlobalVoiceLines], nil, boss )
	end

	aiStage.FireWeapon = aiStage.FireWeapon or GetRandomValue(aiStage.FireRandomWeapon)
	if aiStage.FireWeapon ~= nil then
		boss.WeaponName = aiStage.FireWeapon
		local aiData = GetWeaponAIData(boss)

		boss.ForcedWeaponInterrupt = nil
		DoAttackerAILoop( boss, aiData )
	end

	wait( aiStage.WaitDuration or 2.0)

	if aiStage.NewVulnerability == nil or aiStage.NewVulnerability == true then
		SetUnitVulnerable( boss )
		StopAnimation({ Name = "Invincibubble", DestinationId = bossId })
	end
end

function StartChallengeEncounter( challengeSwitch )
	local challengeSwitchId = challengeSwitch.ObjectId
	SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.InProgressAnimationName })
	if challengeSwitch.UnlockedFxAnimationName ~= nil then
		StopAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.UnlockedFxAnimationName })
	end
	if challengeSwitch.InProgressFxAnimationName ~= nil then
		CreateAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.InProgressFxAnimationName, Group = "FX_Standing_Add" })
	end
	challengeSwitch.IsOpen = false
	challengeSwitch.UseText = "UseChallengeSwitchInProgress"
	RefreshUseButton( challengeSwitch.ObjectId, challengeSwitch )

	ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", LuaValue = round(challengeSwitch.StartingValue), Format = "LootFormat", FadeTarget = 1.0, FadeDuration = 0.5 })
	
	SetScaleX({ Id = challengeSwitch.ValueTextAnchor, Fraction = 0.66 })

	if CurrentRun.CurrentRoom.WellShop then
		SetAnimation({ DestinationId = CurrentRun.CurrentRoom.WellShop.ObjectId, Name = "WellShopRelock" })
		UseableOff({ Id = CurrentRun.CurrentRoom.WellShop.ObjectId })
	end

	local encounter = CurrentRun.CurrentRoom.ChallengeEncounter
	CurrentRun.CurrentRoom.StartedChallengeEncounter = true
	encounter.InProgress = true
	local difficultyModifer = challengeSwitch.DifficultyModifier or 0
	local difficultyMultiplier = challengeSwitch.DifficultyMultiplier or 1
	encounter.DifficultyRating = (encounter.DifficultyRating * difficultyMultiplier) + difficultyModifer
	RecordEncounter( CurrentRun, CurrentRun.CurrentRoom.ChallengeEncounter )

	EnableRoomTraps()
	HandleTrapChains( encounter )

	challengeSwitch.CurrentValue = challengeSwitch.StartingValue
	if challengeSwitch.UseLootDecay then
		thread( HandleChallengeLootDecay, challengeSwitch, CurrentRun.CurrentRoom.ChallengeEncounter )
	end
	StartEncounter( CurrentRun, CurrentRun.CurrentRoom, CurrentRun.CurrentRoom.ChallengeEncounter )
end

function EndChallengeEncounter( challengeEncounter )
	local challengeSwitch = challengeEncounter.Switch
	
	if challengeSwitch.InProgressFxAnimationName ~= nil then
		StopAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.InProgressFxAnimationName })
	end
	
	if challengeEncounter.EndedEarly then
		return
	end

	thread(MarkObjectiveComplete, challengeEncounter.EncounterType)

	ChallengeEncounterEndPresentation(challengeEncounter)

	SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.ReadyToOpenAnimationName })
	UseableOn({ Id = challengeSwitch.ObjectId })
	challengeSwitch.UseText = challengeSwitch.ChallengeResolvedUseText
	RefreshUseButton( challengeSwitch.ObjectId, challengeSwitch )
	challengeSwitch.ReadyToUse = true

	if CurrentRun.CurrentRoom.WellShop then
		SetAnimation({ DestinationId = CurrentRun.CurrentRoom.WellShop.ObjectId, Name = "WellShopUnlocked" })
		UseableOn({ Id = CurrentRun.CurrentRoom.WellShop.ObjectId })
	end
end

function EndCapturePointChallengeEncounter(encounter)
	local challengeSwitch = encounter.Switch

	if encounter.EndedEarly then
		return
	end

	if encounter.CapturePointProgress >= 100 then
		thread(MarkObjectiveComplete, "CapturePointProgress")
	else
		thread(MarkObjectiveFailed, "CapturePointProgress", true)
		if challengeSwitch ~= nil then
			SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.FailedAnimationName })
			UseableOff({ Id = challengeSwitch.ObjectId })
			--challengeSwitch.UseText = challengeSwitch.ChallengeFailedUseText
			--RefreshUseButton( challengeSwitch.ObjectId, challengeSwitch )
		end
	end

	-- ChallengeEncounterEndPresentation(encounter)

	if encounter.CapturePointProgress >= 100 then
		if challengeSwitch ~= nil then
			SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.UnlockedAnimationName })
			if challengeSwitch.UnlockedFxAnimationName ~= nil then
				CreateAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.UnlockedFxAnimationName })
			end

			UseableOff({ Id = challengeSwitch.ObjectId })
			HandleChallengeLoot( challengeSwitch, encounter )
		else
			local reward = SpawnRoomReward(encounter)
			reward.CanDuplicate = false
		end

		encounter.LootDestinationId = encounter.CapturePointId
	end

	if CurrentRun.CurrentRoom.WellShop then
		SetAnimation({ DestinationId = CurrentRun.CurrentRoom.WellShop.ObjectId, Name = "WellShopUnlocked" })
		UseableOn({ Id = CurrentRun.CurrentRoom.WellShop.ObjectId })
	end
end

function HandleHazardSpawns( currentRoom, currentEncounter )
	local spawnData = currentRoom.HazardData
	if spawnData == nil then
		return
	end
	spawnData.SpawnIds = GetIds({ Name = spawnData.SpawnPointGroupName or "Hazards" })
	if IsEmpty(spawnData.SpawnIds) then
		return
	end

	if spawnData.StartDelay ~= nil then
		wait( spawnData.StartDelay, RoomThreadName )
	end

	spawnData.TimesSpawned = 0
	local spawnRate = spawnData.SpawnRate or 0.3
	local spawnStagger = spawnData.SpawnStagger or 0.1
	currentEncounter = currentEncounter or currentRoom.Encounter
	while currentEncounter ~= nil and not currentEncounter.Completed do
		if currentEncounter.PauseHazards then
			wait(0.5, RoomThreadName)
		else
			spawnRate = spawnData.SpawnRate or 0.3
			if spawnData.SkipInitialDelay and spawnData.TimesSpawned == 0 then
				spawnRate = 0.1
			end
			wait( spawnRate, RoomThreadName )

			if currentRoom.Encounter == nil or currentRoom.Encounter.Completed then
				break
			elseif not currentEncounter.PauseHazards then
				local spawnsPerBurst = spawnData.SpawnsPerBurst
				if spawnData.SpawnsPerBurstMin ~= nil and spawnData.SpawnsPerBurstMax ~= nil then
					spawnsPerBurst = RandomInt(spawnData.SpawnsPerBurstMin, spawnData.SpawnsPerBurstMax)
				end
				spawnData.SpawnIds = GetIds({ Name = spawnData.SpawnPointGroupName or "Hazards" })
				for i=1, spawnsPerBurst do
					if not currentEncounter.InProgress then
						return
					end
					local destinationId = RemoveRandomValue(spawnData.SpawnIds)
					if IsEmpty(spawnData.SpawnIds) then
						spawnData.SpawnIds = GetIds({ Name = spawnData.SpawnPointGroupName or "Hazards" })
					end

					local newHazard = DeepCopyTable( EnemyData[spawnData.ObstacleName] )
					newHazard.ObjectId = SpawnUnit({ Name = spawnData.ObstacleName, Group = "Standing", DestinationId = destinationId })
					thread(SetupUnit, newHazard, CurrentRun )
					wait(spawnStagger, RoomThreadName)
				end
				spawnData.TimesSpawned = spawnData.TimesSpawned + 1
			end
		end
	end
end

function RegenerateElysiumPillar(pillar, currentRun)

	wait(pillar.RegenerateStartDelay, RoomThreadName)

	if pillar.RegenerateStartAnimation ~= nil then
		CreateAnimation({ DestinationId = pillar.ObjectId, Name = pillar.RegenerateStartAnimation, OffsetZ = 200 })
	end

	wait(pillar.RegenerateDuration, RoomThreadName)

	if pillar.RegenerateAnimation ~= nil then
		SetAnimation({ DestinationId = pillar.ObjectId, Name = pillar.RegenerateAnimation })
		local notifyName = "RegenWaitForAnimation"..pillar.ObjectId
		NotifyOnAnimationTimeRemaining({ Id = pillar.ObjectId, Animation = pillar.RegenerateAnimation, Remaining = 0, Notify = notifyName })
		waitUntil( notifyName )
	end

	local newData = ObstacleData[pillar.RegenerateAs]
	local newObject = DeepCopyTable( newData )
	newObject.ObjectId = pillar.ObjectId
	AttachLua({ Id = pillar.ObjectId, Table = newObject })
	if pillar.RegenPropertyChanges ~= nil then
		ApplyUnitPropertyChanges( newObject, pillar.RegenPropertyChanges, true )
	end
	if newObject.SpawnPropertyChanges ~= nil then
		ApplyUnitPropertyChanges( newObject, newObject.SpawnPropertyChanges, true )
	end
	RecordObjectState( CurrentRun.CurrentRoom, pillar.ObjectId, "SwapData", pillar.RegenerateAs )

	--local newPillar = SpawnObstacle({ Name = pillar.RegenerateAs, DestinationId = pillar.ObjectId, Group = "Standing" })
	--DebugPrint({ Text = GetThingDataValue({ Id = pillar.ObjectId, Property = "Scale" }) })
	--SetScale({ Id = newPillar, Fraction = GetThingDataValue({ Id = pillar.ObjectId, Property = "Scale" }) })
	--Destroy({ Id = pillar.ObjectId })
end

function TrackNemesisChallengeProgress( encounter, victim, killer )
	if victim.IgnoreThanatosChallengeTracker then
		return
	end

	if killer ~= nil and killer.KillOwner ~= nil then
		if killer.KillOwner == CurrentRun.Hero.ObjectId then
			killer = CurrentRun.Hero
		else
			killer = ActiveEnemies[killer.KillOwner]
		end
	end

	local maxTimeSincePlayerDamage = encounter.MaxTimeSincePlayerDamage or 5
	if killer == nil then
		encounter.PlayerKills = encounter.PlayerKills + 1
		UpdateObjective( "PlayerKills", "PlayerKills", encounter.PlayerKills, { Pulse = true } )
	else
		if killer.ObjectId == encounter.NemesisId then
			encounter.NemesisKills = encounter.NemesisKills + 1
			UpdateObjective( "NemesisKills", "NemesisKills", encounter.NemesisKills, { Pulse = true } )
		elseif killer == CurrentRun.Hero or killer.Charmed then
			encounter.PlayerKills = encounter.PlayerKills + 1
			UpdateObjective( "PlayerKills", "PlayerKills", encounter.PlayerKills, { Pulse = true } )
		elseif killer.DamageType ~= nil and killer.DamageType == "Ally" then
			encounter.PlayerKills = encounter.PlayerKills + 1
			UpdateObjective( "PlayerKills", "PlayerKills", encounter.PlayerKills, { Pulse = true } )
		elseif victim ~= nil and victim.TimeOfLastPlayerDamage ~= nil and _worldTime - victim.TimeOfLastPlayerDamage < maxTimeSincePlayerDamage then
			encounter.PlayerKills = encounter.PlayerKills + 1
			UpdateObjective( "PlayerKills", "PlayerKills", encounter.PlayerKills, { Pulse = true } )
		end
	end
end

function CheckHeraclesBounty( unit, encounter )

	local encounter = unit.Encounter
	if encounter == nil then
		return
	end
	local encounterData = EncounterData[encounter.Name] or encounter

	local wave = encounter.SpawnWaves[encounter.CurrentWaveNum]
	wave.HeraclesBounties = wave.HeraclesBounties or 0
	wave.MaxHeraclesBounties = encounterData.HeraclesBountyPerWave or RandomInt(encounterData.HeraclesBountyPerWaveMin, encounterData.HeraclesBountyPerWaveMax)

	if wave.HeraclesBounties < wave.MaxHeraclesBounties then
		local remaningBounties = wave.MaxHeraclesBounties - wave.HeraclesBounties
		if GetRemainingSpawns( CurrentRun, CurrentRun.CurrentRoom, encounter ) > remaningBounties then
			success = RandomChance(0.5)
		else
			success = true
		end

		if success then
			wave.HeraclesBounties = wave.HeraclesBounties + 1
			unit.HeraclesBounty = encounterData.HeraclesBountyValue
			HeraclesBountySpawnPresentation(unit, wave.HeraclesBounties)
		end
	end
end

function TrackHeraclesChallengeProgress( encounter, victim, killer )
	if victim.IgnoreThanatosChallengeTracker then
		return
	end

	if victim.HeraclesBounty == nil then
		return
	end

	if killer ~= nil and killer.KillOwner ~= nil then
		if killer.KillOwner == CurrentRun.Hero.ObjectId then
			killer = CurrentRun.Hero
		else
			killer = ActiveEnemies[killer.KillOwner]
		end
	end

	encounter.HeraclesMoneyObjective = encounter.HeraclesMoneyObjective or 0
	encounter.PlayerMoneyObjective = encounter.PlayerMoneyObjective or 0

	local maxTimeSincePlayerDamage = encounter.MaxTimeSincePlayerDamage or 5
	if killer == nil then
		encounter.PlayerMoneyObjective = encounter.PlayerMoneyObjective + victim.HeraclesBounty
		killer = CurrentRun.Hero
		thread(HeraclesRequiredKillPresentation, encounter, victim, killer)
	else
		if killer.ObjectId == encounter.HeraclesId then
			encounter.HeraclesMoneyObjective = encounter.HeraclesMoneyObjective + victim.HeraclesBounty
			--thread(HeraclesRequiredKillPresentation, encounter, victim, killer)
		elseif killer == CurrentRun.Hero then
			encounter.PlayerMoneyObjective = encounter.PlayerMoneyObjective + victim.HeraclesBounty
			thread(HeraclesRequiredKillPresentation, encounter, victim, killer)
		elseif killer.DamageType ~= nil and killer.DamageType == "Ally" then
			encounter.PlayerMoneyObjective = encounter.PlayerMoneyObjective + victim.HeraclesBounty
			killer = CurrentRun.Hero
			thread(HeraclesRequiredKillPresentation, encounter, victim, killer)
		elseif victim ~= nil and victim.TimeOfLastPlayerDamage ~= nil and _worldTime - victim.TimeOfLastPlayerDamage < maxTimeSincePlayerDamage then
			encounter.PlayerMoneyObjective = encounter.PlayerMoneyObjective + victim.HeraclesBounty
			killer = CurrentRun.Hero
			thread(HeraclesRequiredKillPresentation, encounter, victim, killer)
		end
	end

end

function HandleTrapChains( eventSource )
	local roomTrapChainData = CurrentRun.CurrentRoom.PassiveTrapChains
	if roomTrapChainData == nil then
		return
	end
	for k, trapChainData in ipairs(roomTrapChainData) do
		thread( HandleTrapChain, trapChainData, eventSource )
	end
end

function HandleTrapChain( trapChainData, encounter )
	wait( trapChainData.StartDelay, RoomThreadName )
	while encounter.InProgress do
		for k, chain in ipairs(trapChainData.Chains) do
			for k, trapId in ipairs(chain) do
				local chainedEnemy = ActiveEnemies[trapId]
				notifyExistingWaiters("WithinDistance"..trapId)

				local chainedWeaponAIData = ShallowCopyTable(chainedEnemy.DefaultAIData) or chainedEnemy
				if WeaponData[chainedEnemy.WeaponName] ~= nil and WeaponData[chainedEnemy.WeaponName].AIData ~= nil then
					OverwriteTableKeys( chainedWeaponAIData, WeaponData[chainedEnemy.WeaponName].AIData)
				end
				chainedWeaponAIData.WeaponName = chainedEnemy.WeaponName

				if not chainedEnemy.AIDisabled then
					thread(DoAttack, chainedEnemy, chainedWeaponAIData )
				end
			end
			wait( trapChainData.ChainInterval, RoomThreadName )
		end
		wait( trapChainData.ChainCooldown, RoomThreadName )
	end
end

function SetupGroupHealthBar(encounter, args)
	encounter.HealthBarUnitIds = {}

	encounter.HealthBarUnitIds = GetIdsByType({ Names = encounter.GroupHealthBarTypes })
	encounter.GroupMaxHealth = 0
	for k, unitId in pairs(encounter.HealthBarUnitIds) do
		local unit = ActiveEnemies[unitId]
		if unit ~= nil then
			unit.UseGroupHealthBar = true
			encounter.GroupMaxHealth = encounter.GroupMaxHealth + unit.MaxHealth
		end
	end
	encounter.GroupHealth = encounter.GroupMaxHealth

	thread(CheckRemoveGroupHealthBar, encounter)
end

function BoatRopeSwing(ropeSwing, args, user)

	local currentRoom = CurrentRun.CurrentRoom
	
	if currentRoom.RopeSwings ~= nil and currentRoom.RopeSwings[ropeSwing.ObjectId] ~= nil then
		if user.ObjectId == CurrentRun.Hero.ObjectId then
			AddInputBlock({ Name = "BoatRopeSwing" })
			SetPlayerInvulnerable( "BoatRopeSwing" )
		end

		SetUnitProperty({ DestinationId = user.ObjectId, Property = "CollideWithObstacles", Value = false })
		ApplyUpwardForce({ Id = user.ObjectId, Speed = 4000 })
		Move({ Id = user.ObjectId, DestinationId = currentRoom.RopeSwings[ropeSwing.ObjectId].DestinationId })
		AngleTowardTarget({ Id = user.ObjectId, DestinationId = currentRoom.RopeSwings[ropeSwing.ObjectId].DestinationId })

		if user.ObjectId == CurrentRun.Hero.ObjectId then
			PanCamera({ Id = currentRoom.RopeSwings[ropeSwing.ObjectId].DestinationId, Duration = 1.2, EaseIn = 0.1 })
		end

		wait(0.4)
		Halt({ Id = user.ObjectId })
		Teleport({ Id = user.ObjectId, DestinationId = currentRoom.RopeSwings[ropeSwing.ObjectId].DestinationId })
			
		if user.ObjectId == CurrentRun.Hero.ObjectId then
			LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.2, EaseIn = 1.0 })
		end
			
		ApplyUpwardForce({ Id = user.ObjectId, Speed = -4000 })
		wait(0.1)
		SetUnitProperty({ DestinationId = user.ObjectId, Property = "CollideWithObstacles", Value = true })
		
		if user.ObjectId == CurrentRun.Hero.ObjectId then	
			RemoveInputBlock({ Name = "BoatRopeSwing" })
			wait(0.2)
			SetPlayerVulnerable( "BoatRopeSwing" )
		end
	end
end

function ClockworkManager(eventSource, args)
	local currentRoom = eventSource

	while true do
		wait(args.Interval, RoomThreadName)

		if GetConfigOptionValue({ Name = "EditingMode" }) then
			return
		end

		for obstacleId, obstacleData in pairs( ShallowCopyTable( MapState.ActiveObstacles ) ) do
			if obstacleData.ClockworkReaction ~= nil then
				thread(DoReaction, obstacleData, obstacleData.ClockworkReaction)
			end
		end

		if currentRoom.Encounter.InProgress then
			for enemyId, enemyData in pairs( ShallowCopyTable( ActiveEnemies ) ) do
				if enemyData.ClockworkReaction ~= nil then
					thread(CallFunctionName, enemyData.ClockworkReaction, enemyData)
				end
			end
		end

		--PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse" })
		--ShakeScreen({ Speed = 300, Distance = 3, FalloffSpeed = 2000, Duration = 0.3 })
		--thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )

	end
end

function ToggleCover( coverObstacle )

	if coverObstacle.ToggledOn then
		if coverObstacle.ToggleOffAnimation ~= nil then
			SetAnimation({ DestinationId = coverObstacle.ObjectId, Name = coverObstacle.ToggleOffAnimation })
		end
		if coverObstacle.ToggleCollision then
			SetThingProperty({ Property = "StopsProjectiles", Value = false, DestinationId = coverObstacle.ObjectId })
			SetThingProperty({ Property = "StopsUnits", Value = false, DestinationId = coverObstacle.ObjectId })
		end

		coverObstacle.ToggledOn = false
	else
		if IsLocationValid({ Id = coverObstacle.ObjectId, CheckObstacles = false, CheckUnits = true, UnitCheckPolygon = true }) then
			if coverObstacle.ToggleOnAnimation ~= nil then
				SetAnimation({ DestinationId = coverObstacle.ObjectId, Name = coverObstacle.ToggleOnAnimation })
			end
			if coverObstacle.ToggleCollision then
				SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationId = coverObstacle.ObjectId })
				SetThingProperty({ Property = "StopsUnits", Value = true, DestinationId = coverObstacle.ObjectId })
			end
			coverObstacle.ToggledOn = true
		else
			--DebugPrint({ Text = "ToggleCover blocked for: "..coverObstacle.ObjectId })
		end
	end
end

function HandleManualCapturePointStart(encounter)
	local spawnPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, { PreferredSpawnPoint = "EnemyPoint" }, {SpawnNearId = CurrentRun.Hero.ObjectId, SpawnRadius = encounter.CapturePointSpawnRadius or 9999, SpawnRadiusMin = encounter.CapturePointSpawnRadiusMin or 1250 } )
	local capturePointSwitchId = SpawnObstacle({ Name = "CapturePointSwitch", DestinationId = spawnPointId, Group = "Standing" }) --nopkg
	--CurrentRun.CurrentRoom.SpawnRewardOnIdWithOffset = capturePointSwitchId
	--SessionMapState.SpawnPointsUsed[spawnPointId] = true

	waitUntil("StartCapturePoint")
end

function StartCapturePointEncounter( eventSource )
	local encounter = CurrentRun.CurrentRoom.Encounter

	UseableOff({ Id = eventSource.ObjectId })
	thread( MarkObjectiveComplete, "AnomalyStart")

	encounter.CapturePointId = SpawnObstacle({ Name = "CapturePoint", DestinationId = eventSource.ObjectId, Group = "FX_Terrain_Add" }) --nopkg
	CapturePointEncounterStartPresentation(encounter, eventSource)
	thread(TrackCapturePointChallengeProgressReal, encounter)
	thread(HandleCapturePointMovement, encounter)
	notifyExistingWaiters("StartCapturePoint")
end

function HandleCapturePointMovement(encounter)

	while encounter.InProgress and encounter.CapturePointId ~= nil do
		if RandomChance(encounter.CapturePointMoveChance or 0.5) then
			local nearbyPoints = GetClosestIds({ Id = encounter.CapturePointId, DestinationIds = GetIds({ Name = "SpawnPoints" }), Distance = encounter.CapturePointMoveSearchDistance or 800 })
			local nextPoint = GetRandomValue(nearbyPoints)
			local moveSpeed = encounter.CapturePointMoveSpeed or 100
			if encounter.CapturePointMoveSpeedMin then
				moveSpeed = RandomInt( encounter.CapturePointMoveSpeedMin, encounter. CapturePointMoveSpeedMax)
			end
			Move({ Id = encounter.CapturePointId, DestinationId = nextPoint, Speed = moveSpeed })
			
			local notifyName = "CapturePointMove"
			NotifyWithinDistance({ Id = encounter.CapturePointId, DestinationId = nextPoint, Distance = 50, Notify = notifyName, Timeout = encounter.CapturePointMoveTimeout or 10.0 })
			waitUntil( notifyName )
			wait( encounter.CapturePointMoveSuccessWaitDuration or 1.0 )
		else
			wait(encounter.CapturePointMoveWaitDuration or 5.0, RoomThreadName)
		end
	end
end

function TrackCapturePointChallengeProgress( encounter )
	thread(TrackCapturePointChallengeProgressReal, encounter)
end

function TrackCapturePointChallengeProgressReal( encounter )

	if encounter.CapturePointId == nil then
		encounter.CapturePointId = GetRandomValue(GetInactiveIdsByType({ Name = "CapturePoint" }))
		if encounter.CapturePointId == nil then
			encounter.CapturePointId = SpawnObstacle({ Name = "CapturePoint", DestinationId = GetRandomValue(GetIdsByType({ Name = "EnemyPoint" })) }) --nopkg
		else
			Activate({ Id = encounter.CapturePointId })
		end
	end

	encounter.CapturePointProgress = encounter.StartingCaptureProgress or 20

	CheckObjectiveSet( "CapturePoint" )

	local notifyName = ""
	while encounter.CapturePointProgress < 100 do
		notifyName = "WaitForWithinCapturePoint"
		StopAnimation({ Name = "ChronosAnomalyCircleSand", DestinationId = encounter.CapturePointId })
		StopAnimation({ Name = "ChronosAnomalyCircleSandIn", DestinationId = encounter.CapturePointId, PreventChain = true })
		SetAnimation({ Name = "ChronosAnomalyCircleInactive", DestinationId = encounter.CapturePointId }) --nopkg
		NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = encounter.CapturePointId, Distance = encounter.CapturePointRadius or 450, ScaleY = 0.5, Notify = notifyName, Timeout = encounter.CapturePointTickDuration or 1.0 })
		waitUntil( notifyName )

		while _eventTimeoutRecord[notifyName] and encounter.CapturePointProgress > 0 do
			_eventTimeoutRecord[notifyName] = nil
			encounter.CapturePointProgress = encounter.CapturePointProgress - (1 * (encounter.CapturePointTickAmountMultiplier or 1) )

			local shouldPulse = false
			if CheckCooldown("CapturePointProgressPulse", 1.0) then
				shouldPulse = true
			end
			UpdateObjective( "CapturePointProgress", "CaptureProgress", encounter.CapturePointProgress, { PulseNegative = shouldPulse, PulseSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGrab" } )

			thread( DirectionHintPresentation, {ObjectId = encounter.CapturePointId}, { Cooldown = 5.0, Delay = 0 } )

			NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = encounter.CapturePointId, Distance = encounter.CapturePointRadius or 450, ScaleY = 0.5, Notify = notifyName, Timeout = encounter.CapturePointTickDuration or 1.0 })
			waitUntil( notifyName )
		end

		if encounter.CapturePointProgress >= 100 or encounter.CapturePointProgress <= 0 then
			break
		end

		notifyName = "CapturePointProgress"
		NotifyOutsideDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = encounter.CapturePointId, Distance = encounter.CapturePointRadius or 450, ScaleY = 0.5, Notify = notifyName, Timeout = encounter.CapturePointTickDuration or 1.0 })
		SetAnimation({ Name = "ChronosAnomalyCircle", DestinationId = encounter.CapturePointId }) -- nopkg
		waitUntil( notifyName )
		
		while _eventTimeoutRecord[notifyName] and encounter.CapturePointProgress < 100 do
			_eventTimeoutRecord[notifyName] = nil
			encounter.CapturePointProgress = encounter.CapturePointProgress + (1 * (encounter.CapturePointTickAmountMultiplier or 1) )

			UpdateObjectiveDescription( "CapturePointProgress", "Objective_CapturePointProgress", "CaptureProgress", encounter.CapturePointProgress )
			NotifyOutsideDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = encounter.CapturePointId, Distance = encounter.CapturePointRadius or 450, ScaleY = 0.5, Notify = notifyName, Timeout = encounter.CapturePointTickDuration or 1.0 })
			waitUntil( notifyName )
		end
	end

	encounter.ForceEnd = true
	encounter.InProgress = false
	SetThreadWait(encounter.SpawnThreadName, 0.01)
	notifyExistingWaiters("RequiredEnemyKilled")

	CapturePointEncounterEndPresentation(encounter)

	Destroy({ Id = encounter.CapturePointId })
end

function StartChronosPolymorphChallenge()
	local encounter = CurrentRun.CurrentRoom.Encounter

	SetMapFlag({ FlagName = "ChronosPolymorph", Id = 768121})

	encounter.CapturePointId = SpawnObstacle({ Name = "CapturePoint", DestinationId = 50059, Group = "FX_Terrain_Add" }) --nopkg
	ChronosPolymorphChallengeStartPresentation(encounter)
	thread(TrackChronosPolymorphChallengeProgressReal, encounter)
	thread(HandleCapturePointMovement, encounter)
	notifyExistingWaiters("StartCapturePoint")
end

function TrackChronosPolymorphChallengeProgressReal( encounter )

	if encounter.CapturePointId == nil then
		encounter.CapturePointId = GetRandomValue(GetInactiveIdsByType({ Name = "CapturePoint" }))
		if encounter.CapturePointId == nil then
			encounter.CapturePointId = SpawnObstacle({ Name = "CapturePoint", DestinationId = GetRandomValue(GetIdsByType({ Name = "EnemyPoint" })) }) --nopkg
		else
			Activate({ Id = encounter.CapturePointId })
		end
	end

	encounter.CapturePointProgress = 0

	CheckObjectiveSet( "CapturePoint" )
	UpdateObjectiveDescription( "CapturePointProgress", "Objective_CapturePointProgress", "CaptureProgress", encounter.CapturePointProgress )

	local notifyName = ""
	while encounter.CapturePointProgress < 100 do
		notifyName = "WaitForWithinCapturePoint"
		StopAnimation({ Name = "ChronosAnomalyCircleSand", DestinationId = encounter.CapturePointId })
		StopAnimation({ Name = "ChronosAnomalyCircleSandIn", DestinationId = encounter.CapturePointId, PreventChain = true })
		SetAnimation({ Name = "ChronosAnomalyCircleInactive", DestinationId = encounter.CapturePointId }) --nopkg
		NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = encounter.CapturePointId, Distance = encounter.CapturePointRadius or 450, ScaleY = 0.5, Notify = notifyName, Timeout = encounter.CapturePointTickDuration or 1.0 })
		waitUntil( notifyName )

		-- Outside Capture Point
		while _eventTimeoutRecord[notifyName] and encounter.CapturePointProgress > 0 do
			_eventTimeoutRecord[notifyName] = nil

			thread( DirectionHintPresentation, {ObjectId = encounter.CapturePointId}, { Cooldown = 5.0, Delay = 0 } )

			NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = encounter.CapturePointId, Distance = encounter.CapturePointRadius or 450, ScaleY = 0.5, Notify = notifyName, Timeout = encounter.CapturePointTickDuration or 1.0 })
			waitUntil( notifyName )
		end

		if encounter.CapturePointProgress >= 100 then
			break
		end

		-- Inside Capture Point
		notifyName = "CapturePointProgress"
		NotifyOutsideDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = encounter.CapturePointId, Distance = encounter.CapturePointRadius or 450, ScaleY = 0.5, Notify = notifyName, Timeout = encounter.CapturePointTickDuration or 1.0 })
		SetAnimation({ Name = "ChronosAnomalyCircle", DestinationId = encounter.CapturePointId }) -- nopkg
		waitUntil( notifyName )
		
		while _eventTimeoutRecord[notifyName] and encounter.CapturePointProgress < 100 do
			_eventTimeoutRecord[notifyName] = nil
			encounter.CapturePointProgress = encounter.CapturePointProgress + (1 * (encounter.CapturePointTickAmountMultiplier or 1) )

			UpdateObjectiveDescription( "CapturePointProgress", "Objective_CapturePointProgress", "CaptureProgress", encounter.CapturePointProgress )
			NotifyOutsideDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = encounter.CapturePointId, Distance = encounter.CapturePointRadius or 450, ScaleY = 0.5, Notify = notifyName, Timeout = encounter.CapturePointTickDuration or 0.15 })
			waitUntil( notifyName )
		end
	end

	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames, BlockSpawns = true })
	RemoveValue(MapState.Flags.ChronosPolymorph, 768121 )
	ChronosPolymorphChallengeEndPresentation(encounter)
end

function SetupArachneCombatEncounter( eventSource, args )
	SpawnArachneCocoons( eventSource, args )

	local roomRewardCocoon = MapState.ActiveObstacles[GetRandomValue(CurrentRun.CurrentRoom.CoocoonIds)]
	roomRewardCocoon.OnDeathFunctionName = "SpawnRoomReward"
	roomRewardCocoon.OnDeathFunctionArgs = { NofifyWaitersName = "ArachneRewardFound" }
	roomRewardCocoon.OnDeathThreadedFunctionName = "ArachneCombatRewardSpawnPresentation"
	roomRewardCocoon.SpawnUnitOnDeath = nil
	roomRewardCocoon.OnKillVoiceLines = GlobalVoiceLines.PositiveReactionVoiceLines
	CurrentRun.CurrentRoom.SpawnRewardOnId = roomRewardCocoon.ObjectId
end

function SpawnArachneCocoons( eventSource, args )
	args = args or {}

	local cocoonIds = {}
	local cocoonCount = RandomInt(args.CocoonCountMin or eventSource.CocoonCountMin, args.CocoonCountMax or eventSource.CocoonCountMax)

	for i = 1, cocoonCount do
		local spawnPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, { PreferredSpawnPoint = "EnemyPoint", RequiredSpawnPoint = args.RequiredSpawnPointType }, {} )
		if spawnPointId == nil then
			return
		end
		local cocoonName = GetRandomValue(args.CocoonOptions or eventSource.CocoonOptions)
		local cocoonId = SpawnObstacle({ DestinationId = spawnPointId, Name = cocoonName, Group = "Standing", TriggerOnSpawn = false })
		local cocoon = DeepCopyTable( ObstacleData[cocoonName] )
		cocoon.ObjectId = cocoonId
		cocoon.OccupyingSpawnPointId = spawnPointId
		table.insert(cocoonIds, cocoonId)
		SetupObstacle( cocoon )
		AddAutoLockTarget({ Id = cocoonId })
		CurrentRun.CurrentRoom.CoocoonIds = cocoonIds
	end
end

function WaitForArachneRewardFound( encounter )
	waitUntil("ArachneRewardFound")
	ArachneRewardFoundPresentation( encounter )
end

function ScyllaCoverManager( encounter, args )
	local room = CurrentRun.CurrentRoom

	local threadName = "ScyllaCoverManager"
	table.insert(CurrentRun.CurrentRoom.SpawnThreads, threadName)

	while encounter.InProgress do
		wait(args.CoverChangeInterval, threadName)

		local coverIds = {}
		local coverOptionIds = ShallowCopyTable(args.CoverSpawnIds)
		if RandomChance(args.CoverSpawnChance) then
			local numCover = RandomInt(1, TableLength(coverOptionIds))
			for i = 1, numCover do
				local destinationId = RemoveRandomValue(coverOptionIds)
				if GetClosestUnitOfType({ Id = destinationId, DestinationName = "Scylla", Distance = 100 }) == 0 then
					local newCoverId = SpawnObstacle({ Name = args.SpawnName, DestinationId = destinationId, Group = "Standing" })
					table.insert(coverIds, newCoverId)
					CreateAnimation({ Name = args.SpawnFx, DestinationId = newCoverId })
					wait( 0.1, threadName )
				end
			end
		end

		if not IsEmpty(coverIds) then
			ShakeScreen({ Distance = 3, Speed = 300, Duration = 0.75, FalloffSpeed = 3000 })
		end

		wait(args.CoverChangeInterval, threadName)
		

		if not IsEmpty(coverIds) then
			ShakeScreen({ Distance = 3, Speed = 300, Duration = 0.75, FalloffSpeed = 3000 })
		end

		for k, coverId in pairs(coverIds) do
			CreateAnimation({ Name = args.DestroyFx, DestinationId = coverId })
			Destroy({ Id = coverId })
			wait( 0.1, threadName )
		end
	end
end

function ApplyScyllaFightSpotlight( scylla, args )
	local encounter = CurrentRun.CurrentRoom.Encounter
	if CurrentRun.CurrentRoom.Name ~= "G_Boss02" then
		args.Flags.Charybdis = nil
	end
	local flagData = GetRandomValue(args.Flags)

	-- Guarantee Jetty on the first fight
	if GameState.EncountersOccurredCache.BossScylla01 == 1 then
		flagData = args.Flags.Keytarist
	end
	-- Guarantee Charybdis on first EM fight
	if CurrentRun.CurrentRoom.Name == "G_Boss02" and GameState.EncountersOccurredCache.BossScylla02 == 1 then
		flagData = args.Flags.Charybdis
	end

	flagData.Id = GetFirstValue(GetIdsByType({ Name = flagData.Name }))

	encounter.ScyllaId = scylla.ObjectId

	CreateAnimation({ Name = "StageSpotlight", DestinationId = flagData.Id, Group = "FX_Add_Top" })
	CreateAnimation({ Name = "ScyllaBoostedFxSpawner", DestinationId = flagData.Id })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", flagData.Id })

	if flagData.ApplyEffect ~= nil then
		flagData.ApplyEffect.Id = scylla.ObjectId
		flagData.ApplyEffect.DestinationId = flagData.Id
		if flagData.ApplyEffect.DataProperties and not flagData.ApplyEffect.DataProperties.TimeModifierFraction then
			flagData.ApplyEffect.DataProperties.TimeModifierFraction = 1
		end
		ApplyEffect(flagData.ApplyEffect)
	end

	if ActiveEnemies[flagData.Id] ~= nil then
		ActiveEnemies[flagData.Id].SpotlightFlag = flagData

		if args.UnequipWeapons then
			RemoveAllValues(ActiveEnemies[flagData.Id].WeaponOptions, args.UnequipWeapons)
			DebugPrintTable(ActiveEnemies[flagData.Id].WeaponOptions)
		end
	end
	MapState.SpotlightUnitId = flagData.Id

	thread( SetMapFlag, flagData)

	thread( ScyllaSpotlightPresentation, flagData, scylla )
end

function RemoveScyllaFightSpotlight( enemy, args )
	local flagData = enemy.SpotlightFlag
	if flagData ~= nil then
		RemoveValue(MapState.Flags[flagData.FlagName], enemy.SpotlightFlag.Id )
		CreateAnimation({ Name = "StageSpotlightFade", DestinationId = flagData.Id, Group = "Additive_01" })
		StopAnimation({ Name = "StageSpotlight", DestinationId = flagData.Id })
		StopAnimation({ Name = "ScyllaBoostedFxSpawner", DestinationId = flagData.Id })
		enemy.HasSpotlight = false

		if flagData.ApplyEffect ~= nil then
			ClearEffect({ Id = flagData.Id, Name = flagData.ApplyEffect })
		end

		if enemy.MusicStem ~= "Vocals" then
			ActiveEnemies[CurrentRun.CurrentRoom.Encounter.ScyllaId].TargetMusicStemVolume = 1.0
			SetSoundCueValue({ Names = { "Vocals" }, Id = AudioState.MusicId, Value = 1.0, Duration = 1 })
		end
		if enemy.MusicStem ~= "Guitar" then
			local targetValue = 0
			for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
				if enemy.MusicStem == "Guitar" and not enemy.IsDead then
					targetValue = 1.0
				end
			end
			SetSoundCueValue({ Guitar = { "Guitar" }, Id = AudioState.MusicId, Value = targetValue, Duration = 1 })
		end
		if enemy.MusicStem ~= "Drums" then
			local targetValue = 0
			for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
				if enemy.MusicStem == "Drums" and not enemy.IsDead then
					targetValue = 1.0
				end
			end
			SetSoundCueValue({ Names = { "Drums" }, Id = AudioState.MusicId, Value = targetValue, Duration = 1 })
		end
	end
end

function StartFieldsEncounter( rewardCage, args )

	local activeEncounterCount = 0
	for k, encounter in ipairs( CurrentRun.CurrentRoom.ActiveEncounters ) do
		if not encounter.ExitsDontRequireCompleted and not encounter.Completed then
			activeEncounterCount = activeEncounterCount + 1
		end
	end

	if activeEncounterCount > 0 then
		thread( CannotUseObjectPresentation, rewardCage )
		return
	end

	for id, object in pairs( MapState.RoomRequiredObjects ) do
		if object.BlockFieldsEncounterStart then
			thread( CannotUseObjectPresentation, rewardCage )
			return
		end
	end

	rewardCage.UseText = "UseChallengeSwitchInProgress"
	rewardCage.OnUsedFunctionName = "InteractBlockedByEnemiesPresentation"
	if rewardCage.OnUsedAnimation ~= nil then
		SetAnimation({ DestinationId = rewardCage.ObjectId, Name = rewardCage.OnUsedAnimation })
	end

	if rewardCage.Encounter == nil then
		-- Back-compat
		rewardCage.Encounter = ChooseEncounter( CurrentRun, CurrentRun.CurrentRoom, { LegalEncounters = rewardCage.LegalEncounters } )
	end
	rewardCage.Encounter.RewardId = rewardCage.RewardId

	FieldsEncounterActivatedPresentation(rewardCage, args)
	MapState.EncounterOverride = rewardCage.Encounter
	rewardCage.Encounter.SpawnNearId = rewardCage.ObjectId
	rewardCage.Encounter.SpawnRadius = 2000
	rewardCage.Encounter.NearbySpawnPoints = {}
	for k, spawnPointId in ipairs( MapState.SpawnPoints ) do
		SessionMapState.DistanceCache[spawnPointId] = SessionMapState.DistanceCache[spawnPointId] or {}
		local distance = SessionMapState.DistanceCache[spawnPointId][rewardCage.Encounter.SpawnNearId] or GetDistance({ Id = spawnPointId, DestinationId = rewardCage.Encounter.SpawnNearId })
		SessionMapState.DistanceCache[spawnPointId][rewardCage.Encounter.SpawnNearId] = distance
		if distance < rewardCage.Encounter.SpawnRadius then
			table.insert( rewardCage.Encounter.NearbySpawnPoints, spawnPointId )
		end
	end
	if CurrentRun.CurrentRoom.RewardCageSpawnPoints ~= nil and CurrentRun.CurrentRoom.RewardCageSpawnPoints[rewardCage.SpawnPointId] then
		rewardCage.Encounter.EligibleSpawnPoints = GetIds({ Name = CurrentRun.CurrentRoom.RewardCageSpawnPoints[rewardCage.SpawnPointId] })
	end
	StartEncounter( CurrentRun, CurrentRun.CurrentRoom, rewardCage.Encounter )

	UseableOff({ Id = rewardCage.ObjectId })
	UseableOn({ Id = rewardCage.RewardId })
	if rewardCage.UnlockedAnimation ~= nil then
		CreateAnimation({ DestinationId = rewardCage.ObjectId, Name = rewardCage.UnlockedAnimation })
	end
	Destroy({ Id = rewardCage.ObjectId })
	ExpireProjectiles({ Name = "Miasma" })
end

function SpawnShipCaptainUnit(encounter, args)
	local wheelId = GetIdsByType({ Name = "ShipsSteeringWheel" })[1]

	if wheelId ~= nil and wheelId ~= 0 then
		local dummyName = GetRandomValue(args.UnitOptions)
		local dummyTarget = DeepCopyTable( EnemyData[dummyName] )
		local setupArgs = {}
		setupArgs.SkipAISetup = true
		dummyTarget.UseActivatePresentation = false
		dummyTarget.RequiredKill = false
		dummyTarget.MoneyDropOnDeath = nil
		dummyTarget.BlocksLootInteraction = false
		dummyTarget.HideHealthBar = true
		dummyTarget.MaxHealth = 1
		dummyTarget.DieOnWheelUse = true
		local spawnPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = wheelId, OffsetX = -75, OffsetY = 75  })
		dummyTarget.ObjectId = SpawnUnit({ Name = dummyName, Group = "Standing", DestinationId = spawnPoint })
		thread(SetupUnit, dummyTarget, CurrentRun, setupArgs )
		AngleTowardTarget({ Id = dummyTarget.ObjectId, DestinationId = wheelId })
		Destroy({ Id = spawnPoint })
	end
end

function WaitForWithinDistance(encounter, args)
	local notifyName = encounter.Name.."WithinDistanceOf"..args.DestinationId
	NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = args.DestinationId, Distance = args.Distance or 500, ScaleY = args.DistanceScaleY, Notify = notifyName })
	waitUntil(notifyName, RoomThreadName)
end

function RecordEncounterClearStats( encounter )
	encounter = encounter or CurrentRun.CurrentRoom.Encounter
	if encounter ~= nil and encounter.StartTime and not encounter.ClearTime then
		encounter.ClearTime = CurrentRun.GameplayTime - encounter.StartTime
		if EncounterData[encounter.Name].RecordClearStats then
			CurrentRun.EncounterClearStats[encounter.Name] =
			{
				ClearTime = encounter.ClearTime,
				TookDamage = encounter.PlayerTookDamage,
			}
		end
	end
end

function RandomizeChronosClockface(eventSource, args)

	local clockNumbers = GetIds({ Name = "ClockFacePointsPhase3" })
	local locationIds = {}

	for k, clockId in pairs(clockNumbers) do
		table.insert( locationIds, SpawnObstacle({ Name = "InvisibleTarget", DestinationId = clockId }) )
	end

	for k, clockId in pairs(clockNumbers) do
		local destinationId = RemoveRandomValue(locationIds)
		Teleport({ Id = clockId, DestinationId = destinationId })
		Destroy({ Id = destinationId })
	end
end