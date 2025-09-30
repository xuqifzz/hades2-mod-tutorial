function ChooseLoot( excludeLootNames, forceLootName )

	local newLootName = nil
	if forceLootName ~= nil then
		newLootName = forceLootName
	else
		local eligibleLootNames = GetEligibleLootNames( excludeLootNames )
		newLootName = GetRandomValue( eligibleLootNames )
	end

	local newlootData = LootData[newLootName]
	return newlootData

end

function InitializeRewardStores( run )
	run.RewardStores = {}
	for storeName, storeData in pairs( RewardStoreData ) do
		local storeData = GetRewardStoreData( storeName )
		run.RewardStores[storeName] = DeepCopyTable( storeData )
	end
end

function GetRewardStoreData( storeName )
	if CurrentRun.ActiveBounty ~= nil then
		local bountyData = BountyData[CurrentRun.ActiveBounty]
		if bountyData ~= nil and bountyData.RewardStoreOverrides ~= nil and bountyData.RewardStoreOverrides[storeName] ~= nil then
			return bountyData.RewardStoreOverrides[storeName]
		end
	end
	return RewardStoreData[storeName]
end

function IsRoomRewardEligible( run, room, reward, previouslyChosenRewards, args )

	if not reward.AllowDuplicates and previouslyChosenRewards ~= nil then
		local previouslyChosen = false
		for k, prevReward in pairs( previouslyChosenRewards ) do
			if (prevReward.CheckDuplicatesName or prevReward.RewardType) == (reward.CheckDuplicatesName or reward.Name) then
				return false
			end
		end
	end

	if room.EligibleRewards ~= nil and not Contains( room.EligibleRewards, reward.Name ) then
		return false
	end

	if room.IneligibleRewards ~= nil and Contains( room.IneligibleRewards, reward.Name ) then
		return false
	end

	if (not args.IgnoreGameStateRequirements or not reward.AllowSkipRequirements) and ( reward.GameStateRequirements ~= nil and not IsGameStateEligible( reward, reward.GameStateRequirements ) ) then
		return false
	end

	return true

end

function ChooseRoomReward( run, room, rewardStoreName, previouslyChosenRewards, args )
	args = args or {}

	local roomData = RoomData[room.Name] or room

	if not args.IgnoreForcedReward then
		if room.NoReward then
			return nil
		end

		if CurrentRun.ActiveBounty ~= nil then
			local bountyData = BountyData[CurrentRun.ActiveBounty]
			if bountyData ~= nil and bountyData.LootOptions == nil and ContainsAny( room.LegalEncounters, bountyData.Encounters ) then
				if GameState.PackagedBountyClears[bountyData.Name] ~= nil then
					return bountyData.ForcedRewardRepeat
				else
					return bountyData.ForcedReward
				end
			end
		end

		if room.ForcedReward ~= nil then
			return room.ForcedReward
		end
		if room.ForcedFirstReward ~= nil then
			local foundFirstReward = false
			if CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.OfferedRewards ~= nil then
				for k, rewardData in pairs(CurrentRun.CurrentRoom.OfferedRewards) do
					if rewardData.Type == room.ForcedFirstReward then
						foundFirstReward = true
						break
					end
				end
			end
			if not foundFirstReward then
				return room.ForcedFirstReward
			end
		end

		if run.CurrentRoom ~= nil and run.CurrentRoom.DeferReward then
			return run.CurrentRoom.ChosenRewardType
		end

		if run.CurrentRoom ~= nil and run.CurrentRoom.PersistentExitDoorRewards and run.CurrentRoom.TimesVisited > 1 and args.Door ~= nil then
			for roomIndex = #run.RoomHistory, 1, -1 do
				local prevRoom = run.RoomHistory[roomIndex]
				if run.CurrentRoom.Name == prevRoom.Name and prevRoom.OfferedRewards ~= nil and prevRoom.OfferedRewards[args.Door.ObjectId] ~= nil then
					room.Reward = prevRoom.Reward
					return prevRoom.OfferedRewards[args.Door.ObjectId].Type
				end
			end
		end

		if room.ChooseRewardRequirements ~= nil then
			if not IsGameStateEligible( room, room.ChooseRewardRequirements ) then
				return nil
			end
		end

		local forcedRewards = args.ForcedRewards or roomData.ForcedRewards
		if forcedRewards ~= nil then
			for k, forcedReward in pairs( forcedRewards ) do
				if forcedReward.GameStateRequirements == nil or IsGameStateEligible( forcedReward, forcedReward.GameStateRequirements ) then
					room.ForceLootName = forcedReward.LootName
					room.ForcedReward = forcedReward
					room.Reward = room.ForcedReward
					DebugPrint({ Text = "Forced Reward: "..forcedReward.Name })
					return forcedReward.Name
				end
			end
		end
	end

	local rngOffset = 4 + run.NumRerolls + (args.RandomOffset or 0)
	RandomSynchronize( rngOffset )
	local eligibleRewardKeys = {}
	for key, reward in ipairs( run.RewardStores[rewardStoreName] ) do
		if IsRoomRewardEligible( CurrentRun, room, reward, previouslyChosenRewards, args ) then
			table.insert( eligibleRewardKeys, key )
		end
	end

	if IsEmpty( eligibleRewardKeys ) then
		if args.NumStoreRefills ~= nil and args.NumStoreRefills >= 2 then
			-- Final fallback
			local fallbackRewardName = "RoomRewardHealDrop"
			room.Reward = { Name = fallbackRewardName }
			return fallbackRewardName
		end
		-- Nothing eligible, add another set (no need to throw out the ineligible rewards remaining)
		local rewardStoreData = GetRewardStoreData( rewardStoreName )
		local newRewardSet = DeepCopyTable( rewardStoreData )
		ConcatTableValues( run.RewardStores[rewardStoreName], newRewardSet )
		args.NumStoreRefills = (args.NumStoreRefills or 0) + 1
		return ChooseRoomReward( run, room, rewardStoreName, previouslyChosenRewards, args )
	end

	local rewardKey = nil
	for i, priorityName in ipairs( CurrentRun.RewardPriorities ) do
		for j, eligibleRewardKey in ipairs( eligibleRewardKeys ) do
			local eligibleReward = run.RewardStores[rewardStoreName][eligibleRewardKey]
			if eligibleReward ~= nil and eligibleReward.Name == priorityName then
				DebugPrint({ Text = "Priority Reward: "..priorityName })
				rewardKey = eligibleRewardKey
				RemoveValueAndCollapse( CurrentRun.RewardPriorities, priorityName )
				break
			end
		end
	end
	if rewardKey == nil then
		rewardKey = GetRandomValue( eligibleRewardKeys )
	end
	local reward = run.RewardStores[rewardStoreName][rewardKey]
	RemoveIndexAndCollapse( run.RewardStores[rewardStoreName], rewardKey )
	room.Reward = reward -- Transition to using the full reward directly rather than its data in piecemeal
	room.ForceLootName = reward.ForceLootName or room.ForceLootName
	room.RewardOverrides = reward.Overrides

	return reward.Name

end

function GetEligibleLootNames( excludeLootNames )
	local eligibleLootNames = nil
	if ReachedMaxGods( excludeLootNames ) then
		eligibleLootNames = OrderedKeysToList( CurrentRun.LootTypeHistory )
	else
		eligibleLootNames = OrderedKeysToList( LootData )
	end

	local output = {}
	for i, lootName in pairs( eligibleLootNames ) do
		local lootData = LootData[lootName]
		if lootData and not lootData.DebugOnly and lootData.GodLoot and IsGameStateEligible( lootData, lootData.GameStateRequirements ) then
			table.insert( output, lootName )
		end
	end
	if excludeLootNames ~= nil then
		for k, excludeLootName in pairs( excludeLootNames ) do
			RemoveValue( output, excludeLootName )
		end
	end
	return output
end

function SetupRoomReward( currentRun, room, previouslyChosenRewards, args )

	args = args or {}

	local prevOfferedReward = CheckPreviousReward( currentRun, room, previouslyChosenRewards, args ) or {}
	local chosenRewardType = args.ChosenRewardType or room.ChosenRewardType

	local rewardData = RewardData[room.ChosenRewardType]
	if rewardData ~= nil then
		if rewardData.SetupFunctionName ~= nil then
			CallFunctionName( rewardData.SetupFunctionName, rewardData, CurrentRun.CurrentRoom, room, previouslyChosenRewards, args, rewardData.SetupFunctionArgs )
		end
	end

	if chosenRewardType == "Empty" then
		return
	end

	if chosenRewardType == "Boon" and ( args.AlwaysSetupForceLootName or not room.ForceLootName ) then

		local excludeLootNames = {}
		if previouslyChosenRewards ~= nil then
			for i, data in pairs( previouslyChosenRewards ) do
				if data.RewardType == "Boon" then
					table.insert( excludeLootNames, data.ForceLootName )
				end
			end
		end
		-- Pre-generate specific type
		local lootData = ChooseLoot( excludeLootNames )
		if not args.IgnoreForceLootName then
			for k, trait in ipairs( CurrentRun.Hero.Traits ) do
				if trait ~= nil and trait.ForceBoonName ~= nil and trait.Uses > 0 and not Contains(excludeLootNames, trait.ForceBoonName) then
					lootData = { Name = trait.ForceBoonName }
					room.ForcedBoonNames[trait.ForceBoonName] = true
					thread( ForceBoonChosenPresentation, trait, lootData )
					break
				end
			end
		end
		if lootData == nil and room.PrevForceLootName ~= nil then
			-- Nothing eligible, try again with only the original loot excluded
			lootData = ChooseLoot( { room.PrevForceLootName } )
		end
		if lootData == nil then
			-- Nothing eligible, try again with no restrictions
			lootData = ChooseLoot()
		end
		room.ForceLootName = lootData.Name
	elseif chosenRewardType == "Devotion" then
		local devotionEncounterName = GetRandomValue(room.DevotionEncounters)
		local encounterData = EncounterData[devotionEncounterName]
		local encounter = SetupEncounter( encounterData )
		room.Encounter = encounter
		RecordEncounter( currentRun, room.Encounter )
		currentRun.LastDevotionDepth = currentRun.RunDepthCache

		room.Encounter.LootAName = prevOfferedReward.LootAName or GetInteractedGodThisRun() or GetRandomValue( GetEligibleLootNames() )
		for k, trait in ipairs( CurrentRun.Hero.Traits ) do
			if trait ~= nil and trait.ForceBoonName ~= nil and trait.Uses > 0 and Contains(GetInteractedGodsThisRun(), trait.ForceBoonName) then
				room.Encounter.LootAName = trait.ForceBoonName
			end
		end
		room.Encounter.LootBName = prevOfferedReward.LootBName or GetInteractedGodThisRun( room.Encounter.LootAName ) or GetRandomValue( GetEligibleLootNames( {room.Encounter.LootAName } ) )
	end
end

function InitClockworkGoalReward( source, args )
	CurrentRun.RemainingClockworkGoals = args.GoalRewards
	CurrentRun.MaxClockworkNonGoalRewards = RandomInt( args.MinNonGoalRewards, args.MaxNonGoalRewards )
end

function SpawnClockworkGoalReward( rewardData, room, args )
	CurrentRun.RemainingClockworkGoals = (CurrentRun.RemainingClockworkGoals or 0) - 1
	if CurrentRun.RemainingClockworkGoals <= 0 then
		CurrentRun.RemainingClockworkGoals = 0
	end
end

function SetupClockworkGoalReward( rewardData, currentRoom, room, previouslyChosenRewards, args, setupFunctionArgs )
	if currentRoom == nil then
		return
	end
	local currentRoomData = RoomData[currentRoom.Name]
	room.RewardPreviewOverride = currentRoomData.RewardPreviewOverride or "ClockworkCountdown"..(CurrentRun.RemainingClockworkGoals or 0)
	room.NoReroll = true

	if args.Door ~= nil and setupFunctionArgs.DistanceTrigger ~= nil then
		thread( CheckDistanceTrigger, setupFunctionArgs.DistanceTrigger, args.Door )
	end

end

function SpawnRoomReward( eventSource, args )

	args = args or {}

	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom
	local currentEncounter = CurrentRun.CurrentRoom.Encounter

	if currentRoom.Reward ~= nil and currentRoom.Reward.FunctionName ~= nil then
		CallFunctionName( currentRoom.Reward.FunctionName, eventSource, currentRoom.Reward.FunctionArgs, args )
		return
	end

	local rewardType = args.RewardOverride or currentEncounter.EncounterRoomRewardOverride or currentRoom.ChangeReward or currentRoom.ChosenRewardType

	if rewardType == nil or rewardType == "Story" or rewardType == "Empty" or rewardType == "Shop" or currentRoom.DeferReward then
		if  args.VoiceLines ~= nil then
			thread( PlayVoiceLines, args.VoiceLines, true )
		end
		return
	end

	RoomRewardPreSpawnPresentation( eventSource, args )

	if args.NofifyWaitersName ~= nil then
		notifyExistingWaiters(args.NofifyWaitersName)
	end

	local rewardData = RewardData[rewardType]
	if rewardData ~= nil then
		if rewardData.SpawnFunctionName ~= nil then
			CallFunctionName( rewardData.SpawnFunctionName, rewardData, eventSource, args )
			return
		end
	end

	local offsetTowardId = SelectRoomRewardSpawnPoint( CurrentRun.CurrentRoom )
	local lootPointId = args.SpawnRewardOnId or currentRoom.SpawnRewardOnId or currentRoom.SpawnRewardOnIdWithOffset or currentRun.Hero.ObjectId
	local angle = 0
	local lootOffset = {X=0, Y=0}

	local reward = nil

	if roomData.SpawnRewardOnLootPoint and not args.IgnoreRoomSpawnOnLootPoint then
		lootPointId = RemoveRandomValue(GetIdsByType({ Name = "LootPoint" }))
	end

	if args.SpawnRewardOnId == nil and currentRoom.SpawnRewardOnId == nil then
		angle = GetAngleBetween({ Id = currentRun.Hero.ObjectId, DestinationId = offsetTowardId })
		lootOffset = CalcOffset( math.rad(angle), 110 )
	end

	wait( currentRoom.SpawnRewardDelay, RoomThreadName )

	if rewardType == "StackUpgrade" then
		reward = CreateStackLoot({ SpawnPoint = lootPointId, OffsetX = lootOffset.X, OffsetY = lootOffset.Y, SuppressSpawnSounds = currentRoom.SuppressRewardSpawnSounds })
	elseif rewardType == "WeaponUpgrade" then
		reward = CreateWeaponLoot({ SpawnPoint = lootPointId, OffsetX = lootOffset.X, OffsetY = lootOffset.Y, SuppressSpawnSounds = currentRoom.SuppressRewardSpawnSounds })
	elseif rewardType == "HermesUpgrade" then
		reward = CheckBoonSkipShrineUpgrade( eventSource, { LootPointId = lootPointId, LootOffset = lootOffset } )
		if reward == nil then
			reward = GiveLoot({ ForceLootName = "HermesUpgrade", SpawnPoint = lootPointId, OffsetX = lootOffset.X, OffsetY = lootOffset.Y,
				SuppressSpawnSounds = currentRoom.SuppressRewardSpawnSounds, AutoLoadPackages = args.AutoLoadPackages })
		end
	elseif rewardType == "Boon" then
		local forceLootName = args.LootName or currentRoom.ForceLootName
		reward = CheckBoonSkipShrineUpgrade( eventSource, { LootPointId = lootPointId, LootOffset = lootOffset, ForceLootName = forceLootName } )
		if reward == nil then
			reward = GiveLoot({ ForceLootName = forceLootName, SpawnPoint = lootPointId, OffsetX = lootOffset.X, OffsetY = lootOffset.Y,
				SuppressSpawnSounds = currentRoom.SuppressRewardSpawnSounds, AutoLoadPackages = args.AutoLoadPackages })
			if currentRoom.ForcedReward ~= nil then
				if currentRoom.ForcedReward.ForcedUpgradeOptions ~= nil then
					reward.UpgradeOptions = currentRoom.ForcedReward.ForcedUpgradeOptions
					reward.BlockReroll = true
				end
				if currentRoom.ForcedReward.PostPickupFunctionName ~= nil then
					reward.PostPickupFunctionName = currentRoom.ForcedReward.PostPickupFunctionName
				end
			end
			local lootSpacing = 100
			local numBonusLoot = GetTotalHeroTraitValue("BonusLootAmount")
			UseHeroTraitsWithValue("BonusLootAmount")
			while numBonusLoot > 0 do
				numBonusLoot = numBonusLoot - 1
				GiveLoot({ OffsetX = lootOffset.X, OffsetY = lootOffset.Y })
				lootOffset.X = lootOffset.X + lootSpacing
			end
		end
	elseif rewardType == "TrialUpgrade" then
		reward = GiveLoot({ ForceLootName = "TrialUpgrade", SpawnPoint = lootPointId,
			OffsetX = lootOffset.X, OffsetY = lootOffset.Y, AutoLoadPackages = args.AutoLoadPackages })
	elseif rewardType == "Devotion" then
		reward = GiveLoot({ ForceLootName = currentEncounter.SpurnedGodName, ExchangeOnlyFromLootName = currentEncounter.ChosenGodName, BlockRarities = { Duo = true }, SpawnPoint = lootPointId,
			OffsetX = lootOffset.X, OffsetY = lootOffset.Y, AutoLoadPackages = args.AutoLoadPackages })
		reward.CanReceiveGift = false
	else
		local consumableId = SpawnObstacle({ Name = rewardType, DestinationId = lootPointId, Group = "Standing", OffsetX = lootOffset.X, OffsetY = lootOffset.Y })
		reward = CreateConsumableItem( consumableId, rewardType, 0, { IgnoreSounds = currentRoom.SuppressRewardSpawnSounds, RunProgressUpgradeEligible = true, AutoLoadPackages = args.AutoLoadPackages, IgnoreAssert = args.IgnoreAssert } )
		if reward ~= nil then
			reward.IgnorePurchase = true
			reward.PurchaseRequirements = nil
			reward.LootName = args.LootName
			ApplyConsumableItemResourceMultiplier( currentRoom, reward )
			if reward.ExtractValues ~= nil then
				ExtractValues( CurrentRun.Hero, reward, reward )
			end
			if not args.NotRequiredPickup then
				MapState.RoomRequiredObjects[consumableId] = reward
			end
			args.GenericReward = true
		end
	end

	if rewardData ~= nil then
		if rewardData.PostSpawnFunctionName ~= nil then
			CallFunctionName( rewardData.PostSpawnFunctionName, rewardData, reward, eventSource, args )
		end
	end

	--DebugPrint({ Text = "lootPointId = "..lootPointId })
	MapState.RewardPointsUsed[lootPointId] = reward.ObjectId
	--DebugPrint({ Text = "offsetTowardId = "..tostring(offsetTowardId) })
	if offsetTowardId ~= nil then
		MapState.RewardPointsUsed[offsetTowardId] = reward.ObjectId
	end

	RoomRewardSpawnPresentation( reward, args )
	currentRun.BiomeRewardsSpawned = (currentRun.BiomeRewardsSpawned or 0) + 1

	if currentRoom.DisableRewardMagnetisim then
		SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = reward.ObjectId })
	end

	if roomData.OnRoomRewardSpawnedFunctionName ~= nil then
		CallFunctionName( roomData.OnRoomRewardSpawnedFunctionName, currentRoom, roomData.OnRoomRewardSpawnedFunctionArgs )
	end
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.OnRoomRewardSpawnedFunctionName ~= nil then
			CallFunctionName( trait.OnRoomRewardSpawnedFunctionName, trait, trait.OnRoomRewardSpawnedFunctionArgs )
		end
	end
	CheckShrineBounties()
	CheckRandomBounties()

	if args.WaitUntilPickup then
		if reward.MenuNotify ~= nil then
			waitUntil( UIData.BoonMenuId )
		else
			reward.NotifyName = "OnUsed"..reward.ObjectId
			waitUntil( reward.NotifyName )
		end
	end

	return reward
end

function SpawnPerfectClearRoomReward( eventSource, args )
	local encounter = CurrentRun.CurrentRoom.Encounter

	if encounter.PlayerTookDamage then
		CurrentRun.CurrentRoom.ChangeReward = "RoomRewardConsolationPrize"
	end
	SpawnRoomReward(eventSource, args)
end

function CalcMetaProgressRatio( run )

	local rewardStoreCounts = {}
	rewardStoreCounts.Total = 0
	rewardStoreCounts.MetaProgress = 0

	for i, room in ipairs( run.RoomHistory ) do
		CalcRoomRewardStores( room, rewardStoreCounts )
	end
	CalcRoomRewardStores( CurrentRun.CurrentRoom, rewardStoreCounts )

	if rewardStoreCounts.Total == 0 then
		--DebugPrint({ Text = "CalcMetaProgressRatio = 0.0 (0/0)" })
		return nil
	end

	local ratio = rewardStoreCounts.MetaProgress / rewardStoreCounts.Total
	--DebugPrint({ Text = "CalcMetaProgressRatio = "..ratio.." ("..rewardStoreCounts.MetaProgress.."/"..rewardStoreCounts.Total..")" })
	return ratio

end

function CalcRoomRewardStores( room, rewardStoreCounts )
	local roomData = RoomData[room.Name] or room
	if roomData.IgnoreForRewardStoreCount then
		return
	end
	local hasEncounterRewardStore = false
	if room.Encounters ~= nil then
		for j, encounter in ipairs( room.Encounters ) do
			if encounter.RewardStoreName ~= nil then
				hasEncounterRewardStore = true
				rewardStoreCounts.Total = (rewardStoreCounts.Total or 0) + 1
				rewardStoreCounts[encounter.RewardStoreName] = (rewardStoreCounts[encounter.RewardStoreName] or 0) + 1
			end
		end
	end
	--DebugPrint({ Text = room.Name.." - room.RewardStoreName = "..tostring(room.RewardStoreName) })
	if not hasEncounterRewardStore and room.ChosenRewardType ~= nil and room.RewardStoreName ~= nil then
		rewardStoreCounts.Total = (rewardStoreCounts.Total or 0) + 1
		rewardStoreCounts[room.RewardStoreName] = (rewardStoreCounts[room.RewardStoreName] or 0) + 1
	end
end

function RewardStoreAddPriority( args, trait )
	table.insert( CurrentRun.RewardPriorities, args.Name )

	local rewardStoreName = args.RewardStoreName or "RunProgress"

	if CurrentRun.RewardStores ~= nil then
		local storeHasPriority = false
		for i, reward in ipairs( CurrentRun.RewardStores[rewardStoreName] ) do
			if reward.Name == args.Name then
				storeHasPriority = true
				break
			end
		end
		if not storeHasPriority then
			-- Priority isn't in carousel, add another set (no need to throw out the ineligible rewards remaining)
			local rewardStoreData = GetRewardStoreData( rewardStoreName )
			local newRewardSet = DeepCopyTable( rewardStoreData )
			ConcatTableValues( CurrentRun.RewardStores[rewardStoreName], newRewardSet )
		end
	end
	
end