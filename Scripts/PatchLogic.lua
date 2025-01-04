function DoPatches()

	Revision = Revision or 0

	if GameState ~= nil then

		InitializeMetaUpgradeState()
		DoMetaUpgradePatches()

		if not IsEmpty( GameState.RunHistory ) then
			PrevRun = GameState.RunHistory[#GameState.RunHistory]
			if PrevRun ~= nil then
				UpdateRunHistoryCache( PrevRun )
			end
		end

		for i = #GameState.RunHistory, math.max( #GameState.RunHistory - 10, 1 ), -1 do
			local prevRun = GameState.RunHistory[i]
			prevRun.BiomeStateChangeCount = prevRun.BiomeStateChangeCount or 0
			prevRun.BiomesReached = prevRun.BiomesReached or {}
			for keyName, v in pairs( RecentRunSaveWhitelist ) do
				prevRun[keyName] = prevRun[keyName] or {}
			end
		end

		if not GameState.BountyBackCompatChecked then
			for i = #GameState.RunHistory, 1, -1 do
				local run = GameState.RunHistory[i]
				if run.ActiveBounty ~= nil then
					if not DoesRunMatchBounty(run, run.ActiveBounty) then
						-- This bounty is bogus! Is it actually using the bounty from the last run?
						local prevActiveBounty = GameState.RunHistory[i-1].ActiveBounty
						if prevActiveBounty ~= nil and DoesRunMatchBounty(run, prevActiveBounty) then
							run.ActiveBounty = prevActiveBounty
						else
							-- Nope, it's just a regular run!
							run.ActiveBounty = nil
						end
					end
				end
			end
			GameState.BountyBackCompatChecked = true
		end

		GameState.CompletedRunsCache = GetCompletedRuns()
		if GameState.EquippedFamiliar and not GameState.FamiliarResourceSpawnChance then
			GameState.FamiliarResourceSpawnChance = FamiliarData[GameState.EquippedFamiliar].BaseResourceSpawnChance + GetFamiliarBonusResourceSpawnChance( GameState.EquippedFamiliar )
		end

		for itemName, value in pairs( GameState.WorldUpgrades ) do
			GameState.WorldUpgradesViewed[itemName] = true
		end

		for i, category in ipairs( ScreenData.MarketScreen.ItemCategories ) do
			GameState.WorldUpgradesViewed[category.Name] = GameState.ItemsViewed[category.Name]
		end

		for itemName, value in pairs( GameState.WorldUpgradesViewed ) do
			GameState.WorldUpgradesRevealed[itemName] = true
		end

		for id, plot in pairs( GameState.GardenPlots ) do
			local plotData = ObstacleData[plot.Name]
			if plotData ~= nil then
				plot.SpecialInteractFunctionName = plotData.SpecialInteractFunctionName
			end
			local seedData = GardenData.Seeds[plot.SeedName]
			if seedData == nil then
				plot.StoredGrows = 0
				plot.StoredResources = 0
				plot.SeedName = nil
				plot.UseText = "UseGardenPlotPlant"
				plot.TalkOnlyIfNoGiftOrSpecial = true
			end
		end

		for bountyName, v in pairs( GameState.BountiesCompleted ) do
			local bountyData = BountyData[bountyName]
			if bountyData ~= nil and bountyData.IsPackagedBounty then
				GameState.PackagedBountyClears[bountyName] = GameState.PackagedBountyClears[bountyName] or 1
				GameState.PackagedBountyAttempts[bountyName] = GameState.PackagedBountyAttempts[bountyName] or 1
				GameState.PackagedBountyClearRecordTime[bountyName] = GameState.PackagedBountyClearRecordTime[bountyName] or GetBountyClearRecordTime( bountyName )
			end
		end

		local foundDupes = false
		local pinNames = {}
		for index, pin in pairs( GameState.StoreItemPins ) do
			if pinNames[pin.Name] then
				-- Found dupe
				foundDupes = true
				GameState.StoreItemPins[index] = nil
			else
				pinNames[pin.Name] = true
			end
		end
		if foundDupes then
			GameState.StoreItemPins = CollapseTable( GameState.StoreItemPins )
		end

		-- Patch for current Mailbox orders of Mixer3Common to MetaFabric
		for itemId, mailbox in pairs( GameState.MailboxStatus ) do
			if mailbox ~= nil and mailbox.LeftDisplayName == "Mixer3Common" then
				mailbox.LeftDisplayName = "MetaFabric"
				mailbox.BuyName = "MetaFabric"
			end
		end

		for weaponName, traitName in pairs( GameState.LastWeaponUpgradeName ) do
			if not TraitData[traitName] then
				GameState.LastWeaponUpgradeName[weaponName] = nil
			end
		end

		if IsEmpty( GameState.ResourcesViewed ) and GameState.ScreensViewed.InventoryScreen then
			-- Assume the player has already viewed all the resources they've acquired
			for itemName, itemNum in pairs( GameState.LifetimeResourcesGained ) do
				GameState.ResourcesViewed[itemName] = true
			end
		end

		if not GameState.ResourceAssertIgnored and Revision <= 100000 then
			for name, count in pairs( GameState.Resources ) do
				if count > (GameState.LifetimeResourcesGained[name] or 0) then
					GameState.ResourceAssertIgnored = true
					DebugPrint({ Text = "GameState.ResourceAssertIgnored = true" })
					break
				end
			end
		end

		GameState.WorldUpgrades.WorldUpgradePauseChronosFight = nil
		GameState.WorldUpgradesAdded.WorldUpgradePauseChronosFight = nil

		if GameState.TextLinesRecord.DoraGrantsCosmeticsShop01 == nil then
			GameState.WorldUpgrades.Cosmetic_TentBlanket01b = nil
			GameState.WorldUpgradesAdded.Cosmetic_TentBlanket01b = nil
		end

		GameState.ShrineUpgrades.FirstDamageShrineUpgrade = nil
		GameState.ShrineUpgrades.RoomStartManaShrineUpgrade = nil
		GameState.ShrineUpgrades.NoMetaUpgradesShrineUpgrade = nil
		GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()

		if Revision <= 94275 then
			GameState.MoneySpentTowardCharonPoints = GameState.LifetimeResourcesSpent.Money or 0
			local charonPointsEarned = math.floor( GameState.MoneySpentTowardCharonPoints / ScreenData.MailboxScreen.MoneySpentPerCharonPoint )
			GameState.NextCharonPointCache = (ScreenData.MailboxScreen.MoneySpentPerCharonPoint * (charonPointsEarned + 1)) - GameState.MoneySpentTowardCharonPoints
		end

		for roomName, room in pairs( RoomData ) do
			GameState.UseRecord[roomName] = nil
		end
		for hubRoomName, hubRoom in pairs( HubRoomData ) do
			GameState.UseRecord[hubRoomName] = nil
		end
		GameState.TriggerRecord = nil
		GameState.InspectData = nil

		if GameState.DamageDealtRecord ~= nil then
			SplitUpDamageDealtRecord( GameState )
			GameState.DamageDealtRecord = nil
		end

		if not GameState.LifetimeRecordsBackCompatChecked then
			-- Clear out a bunch of old unused records
			GameState.TimesCleared = nil
			GameState.TimesClearedWeapon = nil
			GameState.WeaponRecordsClearTime = nil
			GameState.WeaponRecordsShrinePoints = nil
			GameState.ConsecutiveClearsRecord = nil
			GameState.ConsecutiveClears = nil
			GameState.RecordClearedShrineThreshold = nil

			-- Populate the new records
			for i, run in ipairs( GameState.RunHistory ) do
				UpdateLifetimeTraitRecords( run )
			end

			GameState.RemovedPreOlympusSurfaceRecords = true
		end
		
		if not GameState.RemovedPreOlympusSurfaceRecords then
			for _, stat in pairs( GameState.LifetimeTraitStats ) do
				if stat.ClearCountSurface ~= nil then
					stat.ClearCount = stat.ClearCount - stat.ClearCountSurface
					stat.ClearCountSurface = nil
					stat.FastestTimeSurface = nil
					stat.HighestShrinePointsSurface = nil
				end
			end
			for _, stat in pairs( GameState.LifetimeWeaponStats ) do
				if stat.ClearCountSurface ~= nil then
					stat.ClearCount = stat.ClearCount - stat.ClearCountSurface
					stat.ClearCountSurface = nil
					stat.FastestTimeSurface = nil
					stat.HighestShrinePointsSurface = nil
				end
			end
			GameState.RemovedPreOlympusSurfaceRecords = true
		end

		if PrevRun ~= nil and PrevRun.KeepsakeCache == nil then
			for i, run in ipairs( GameState.RunHistory ) do
				run.KeepsakeCache = {}
				if run.EndingKeepsakeName ~= nil then
					table.insert( run.KeepsakeCache, run.EndingKeepsakeName )
					run.EndingKeepsakeName = nil
				end
			end
		end

		if GameState.FamiliarStatus ~= nil then
			for familiarName, familiarStatus in pairs( GameState.FamiliarStatus ) do
				if familiarStatus.Unlocked then
					GameState.FamiliarsUnlocked[familiarName] = true
					GameState.FamiliarRestTicks[familiarName] = familiarStatus.RestTicks
				end
			end
			GameState.FamiliarUses = nil
			GameState.FamiliarStatus = nil
		end

	end

	if CurrentRun ~= nil then

		UpdateRunHistoryCache( CurrentRun )
		
		for i, room in ipairs( CurrentRun.RoomHistory ) do
			if room.Store and room.Store.SpawnedStoreItems then
				for s, spawnedItemData in pairs( room.Store.SpawnedStoreItems ) do
					CurrentRun.RoomHistory[i].Store.SpawnedStoreItems[s] =  { ObjectId = spawnedItemData.ObjectId, ResourceCost = spawnedItemData.ResourceCost }
				end
			end
			room.NumHarvestPoints = room.NumHarvestPoints or 0
			room.NumShovelPoints = room.NumShovelPoints or 0
			room.NumPickaxePoints = room.NumPickaxePoints or 0
			room.NumExorcismPoints = room.NumExorcismPoints or 0
			room.NumFishingPoints = room.NumFishingPoints or 0
			room.EncountersOccurredCache = room.EncountersOccurredCache or {}
		end
		CurrentRun.SpellCharge = CurrentRun.SpellCharge or 5000
		CurrentRun.BiomeStateChangeCount = CurrentRun.BiomeStateChangeCount or 0
		CurrentRun.ResourceNodesSeen = CurrentRun.ResourceNodesSeen or {}
		CurrentRun.ToolElementsSpawned = CurrentRun.ToolElementsSpawned or {}

		if CurrentRun.CurrentRoom ~= nil then
			RoomInit( CurrentRun.CurrentRoom )
			CurrentRun.CurrentRoom.SpawnThreads = CurrentRun.CurrentRoom.SpawnThreads or {}
			CurrentRun.CurrentRoom.ActiveEncounters = CurrentRun.CurrentRoom.ActiveEncounters or {}
			CurrentRun.CurrentRoom.SpeechRecord = CurrentRun.CurrentRoom.SpeechRecord or {}
			CurrentRun.CurrentRoom.Kills = CurrentRun.CurrentRoom.Kills or {}
			CurrentRun.CurrentRoom.RoomCreations = CurrentRun.CurrentRoom.RoomCreations or {}
			CurrentRun.CurrentRoom.EncountersOccurredCache = CurrentRun.CurrentRoom.EncountersOccurredCache or {}
			CurrentRun.CurrentRoom.NemesisTakeExitRecord = CurrentRun.CurrentRoom.NemesisTakeExitRecord or {}
			CurrentRun.CurrentRoom.TraitUses = CurrentRun.CurrentRoom.TraitUses or {}
			CurrentRun.CurrentRoom.UnavailableDoors = CurrentRun.CurrentRoom.UnavailableDoors or {}
			local room = CurrentRun.CurrentRoom
			room.NumHarvestPoints = room.NumHarvestPoints or 0
			room.NumShovelPoints = room.NumShovelPoints or 0
			room.NumPickaxePoints = room.NumPickaxePoints or 0
			room.NumExorcismPoints = room.NumExorcismPoints or 0
			room.NumFishingPoints = room.NumFishingPoints or 0
			room.UseRecord = room.UseRecord or {}
			if CurrentRun.CurrentRoom.ChallengeSwitch ~= nil and CurrentRun.CurrentRoom.ChallengeSwitch.RewardType == nil then
				CurrentRun.CurrentRoom.ChallengeSwitch = DeepCopyTable( ObstacleData.ChallengeSwitch )
			end
			if CurrentRun.CurrentRoom.SellOptions then
				local hasIndex = false
				for i, data in pairs( CurrentRun.CurrentRoom.SellOptions ) do
					if data.Index then
						hasIndex = true
					end
					if data.Value == 0 and data.Index and CurrentRun.Hero.Traits[data.Index] then
						data.Value = GetTraitValue(CurrentRun.Hero.Traits[data.Index])
					end
				end
				if hasIndex then
					CurrentRun.CurrentRoom.SellOptions = nil
				end
			end
			if CurrentRun.CurrentRoom.Store ~= nil and CurrentRun.CurrentRoom.Store.StoreOptions ~= nil then
				local giftDropIndex = nil
				for i, storeOption in pairs( CurrentRun.CurrentRoom.Store.StoreOptions ) do
					if storeOption.Type == "Cosmetic" then
						storeOption.Name = "HealDropRange"
						storeOption.Type = "Consumable"
					elseif not storeOption.Name then
						storeOption.Name = "HealDropRange"
						storeOption.Type = "Consumable"
					end
				end
			end
			CurrentRun.CurrentRoom.StoreDataName = CurrentRun.CurrentRoom.StoreDataName or RoomData[CurrentRun.CurrentRoom.Name].StoreDataName

			DebugAssert({ Condition = RoomData[CurrentRun.CurrentRoom.Name] ~= nil, Text = "Missing Room: "..tostring(CurrentRun.CurrentRoom.Name) })

			CurrentRun.CurrentRoom.SpawnRewardOnId = RoomData[CurrentRun.CurrentRoom.Name].SpawnRewardOnId
			CurrentRun.CurrentRoom.DisableRewardMagnetisim = RoomData[CurrentRun.CurrentRoom.Name].DisableRewardMagnetisim
			CurrentRun.CurrentRoom.FadeOutAnimation = RoomData[CurrentRun.CurrentRoom.Name].FadeOutAnimation
			CurrentRun.CurrentRoom.SkipLoadNextMap = RoomData[CurrentRun.CurrentRoom.Name].SkipLoadNextMap
			CurrentRun.CurrentRoom.ExitFunctionName = RoomData[CurrentRun.CurrentRoom.Name].ExitFunctionName
			CurrentRun.CurrentRoom.ZoomFraction = RoomData[CurrentRun.CurrentRoom.Name].ZoomFraction
			CurrentRun.CurrentRoom.NextHeroStartPoint = RoomData[CurrentRun.CurrentRoom.Name].NextHeroStartPoint
			CurrentRun.CurrentRoom.NextHeroEndPoint = RoomData[CurrentRun.CurrentRoom.Name].NextHeroEndPoint
			CurrentRun.CurrentRoom.HeroStartPointCameraLinkIds = RoomData[CurrentRun.CurrentRoom.Name].HeroStartPointCameraLinkIds
			CurrentRun.CurrentRoom.HeroEndPointCameraLinkIds = RoomData[CurrentRun.CurrentRoom.Name].HeroEndPointCameraLinkIds
			CurrentRun.CurrentRoom.HeroStartPointEndPointLinkIds = RoomData[CurrentRun.CurrentRoom.Name].HeroStartPointEndPointLinkIds
			CurrentRun.CurrentRoom.RushMaxRangeOverride = RoomData[CurrentRun.CurrentRoom.Name].RushMaxRangeOverride

			CurrentRun.CurrentRoom.PersistentExitDoorRewards = RoomData[CurrentRun.CurrentRoom.Name].PersistentExitDoorRewards
			CurrentRun.CurrentRoom.LinkedRoom = RoomData[CurrentRun.CurrentRoom.Name].LinkedRoom
			CurrentRun.CurrentRoom.CollectShadeMercs = RoomData[CurrentRun.CurrentRoom.Name].CollectShadeMercs
			CurrentRun.CurrentRoom.ShadeMercsRequiredForBoss = RoomData[CurrentRun.CurrentRoom.Name].ShadeMercsRequiredForBoss
			
			CurrentRun.CurrentRoom.EntranceAnimation = RoomData[CurrentRun.CurrentRoom.Name].EntranceAnimation
			CurrentRun.CurrentRoom.ExitAnimation = RoomData[CurrentRun.CurrentRoom.Name].ExitAnimation
			CurrentRun.CurrentRoom.MaintainSpellCharge = RoomData[CurrentRun.CurrentRoom.Name].MaintainSpellCharge
			
			CurrentRun.CurrentRoom.LockExtraExitsWithEncounter = RoomData[CurrentRun.CurrentRoom.Name].LockExtraExitsWithEncounter

			CurrentRun.CurrentRoom.ObstacleData = DeepCopyTable(RoomData[CurrentRun.CurrentRoom.Name].ObstacleData)
			CurrentRun.CurrentRoom.WrappingData = DeepCopyTable(RoomData[CurrentRun.CurrentRoom.Name].WrappingData)
			CurrentRun.CurrentRoom.OnUseSetRunData = DeepCopyTable(RoomData[CurrentRun.CurrentRoom.Name].OnUseSetRunData)

			if CurrentRun.CurrentRoom.ObjectStates ~= nil then
				for k, objectState in pairs( CurrentRun.CurrentRoom.ObjectStates ) do
					if objectState.Animation == "DestructibleTreeStump" then
						objectState.Animation = "DestructibleTreeStumpA"
					elseif objectState.Animation == "Breakable_HighValue" then
						objectState.Animation = "BreakableHighValueChronosPot"
					end
				end
			end

			for npcName, value in pairs( CurrentRun.NPCInteractions ) do
				if type(value) == "boolean" then
					CurrentRun.NPCInteractions[npcName] = 1
				end
			end

			-- Patch for Hecate and Scylla boss rewards changing name from Mixer#Common to MixerXBoss
			if CurrentRun.CurrentRoom.ChosenRewardType == "Mixer2CommonDrop" then
				CurrentRun.CurrentRoom.ChosenRewardType = "MixerFBossDrop"
			end
			if CurrentRun.CurrentRoom.ChosenRewardType == "Mixer4CommonDrop" then
				CurrentRun.CurrentRoom.ChosenRewardType = "MixerGBossDrop"
			end

			if CurrentRun.CurrentRoom.ForcedReward and not IsEmpty( CurrentRun.CurrentRoom.ForcedReward.ForcedUpgradeOptions) then
				local condemnedIndexes = {}
				for index, data in pairs(CurrentRun.CurrentRoom.ForcedReward.ForcedUpgradeOptions) do
					if data.Type == "Trait" and not TraitData[data.ItemName] then
						table.insert(condemnedIndexes, index)
					end
				end
				for _, index in pairs(condemnedIndexes) do
					CurrentRun.CurrentRoom.ForcedReward.ForcedUpgradeOptions[index] = nil
				end
				CurrentRun.CurrentRoom.ForcedReward.ForcedUpgradeOptions = CollapseTable( CurrentRun.CurrentRoom.ForcedReward.ForcedUpgradeOptions )
			end

		end

		local gameStateRequirements =
		{
			NamedRequirements =  { "ShrineUnlocked" },
		}
		if not IsGameStateEligible( nil, gameStateRequirements ) then
			GameState.SpentShrinePointsCache = 0
			GameState.ShrineUpgrades = {}
		end

		if CurrentRun.RewardStores == nil then
			InitializeRewardStores( CurrentRun )
		else
			for storeName, storeData in pairs( RewardStoreData ) do
				if CurrentRun.RewardStores[storeName] == nil then
					CurrentRun.RewardStores[storeName] = DeepCopyTable( storeData )
				end
			end
			for storeName, currentStore in pairs( CurrentRun.RewardStores ) do
				if storeName ~= "InvalidOverrides" then
					for rewardKey, currentReward in pairs( currentStore ) do
						if currentReward.GameStateRequirements ~= nil and
							(
								currentReward.GameStateRequirements.RequiredNotInStore ~= nil or
								currentReward.GameStateRequirements.RequiredMinRoomsSinceDevotion ~= nil or
								currentReward.GameStateRequirements.RequiredMinExits ~= nil or
								currentReward.GameStateRequirements.RequiredFalseRewardType ~= nil
							) then
							CurrentRun.RewardStores[storeName][rewardKey] = nil
						end
					end
				end
			end
			if Revision <= 97600 then
				local keys = GetAllKeys( CurrentRun.RewardStores )
				for i, key in ipairs( keys ) do
					CurrentRun.RewardStores[key] = CollapseTable( CurrentRun.RewardStores[key] )
				end
			end
		end

		if CurrentRun.LastReward and not CurrentRun.LastReward.DisplayName then	
			CurrentRun.LastReward.DisplayName = CurrentRun.LastReward.Name
			if CurrentRun.LastReward.Type == "Consumable" then
			local consumableItem = ConsumableData[CurrentRun.LastReward.Name]
				if consumableItem and consumableItem.AddResources and TableLength(consumableItem.AddResources) == 1 then
					CurrentRun.LastReward.DisplayName = ResourceData[GetFirstKey(consumableItem.AddResources)].TooltipId
				end
			end
		end
		for ghostName, ghostData in pairs( GhostData ) do
			GameState.ExorcisedNames[ghostName] = nil
			CurrentRun.ExorcisedNames[ghostName] = nil
		end
		GameState.ExorcisedNames.ExorcismPoint = nil
		CurrentRun.ExorcisedNames.ExorcismPoint = nil

		if CurrentRun.Hero ~= nil then

			CurrentRun.Hero.InvulnerableFlags = CurrentRun.Hero.InvulnerableFlags or {}
			CurrentRun.Hero.LastStands = CurrentRun.Hero.LastStands or {}
			CurrentRun.Hero.MaxLastStands = CurrentRun.Hero.MaxLastStands or TableLength( CurrentRun.Hero.LastStands )
			CurrentRun.Hero.MaxHealth = CurrentRun.Hero.MaxHealth or HeroData.MaxHealth
			CurrentRun.Hero.Health = CurrentRun.Hero.Health or CurrentRun.Hero.MaxHealth
			CurrentRun.Hero.Health = math.ceil(CurrentRun.Hero.Health)
			CurrentRun.Hero.MaxMana = CurrentRun.Hero.MaxMana or HeroData.MaxMana
			CurrentRun.Hero.Mana = CurrentRun.Hero.Mana or CurrentRun.Hero.Mana
			CurrentRun.Hero.Mana = math.ceil(CurrentRun.Hero.Mana)
			CurrentRun.Hero.Ammo = CurrentRun.Hero.Ammo or {}
			CurrentRun.Hero.WeaponDataOverride = CurrentRun.Hero.WeaponDataOverride or {}
			CurrentRun.Hero.ManaDrain = {}
			CurrentRun.Hero.AnimOffsetZ = HeroData.AnimOffsetZ
			CurrentRun.Hero.LineHistoryName = CurrentRun.Hero.LineHistoryName or HeroData.LineHistoryName

			CurrentRun.Hero.VisibleTraitCount = CurrentRun.Hero.VisibleTraitCount or 0

			CurrentRun.Hero.Speaker = CurrentRun.Hero.Speaker or HeroData.Speaker
			CurrentRun.Hero.Portrait = CurrentRun.Hero.Portrait or HeroData.Portrait

			local removedWeapons = {}
			local validWeapons = ToLookup( WeaponSets.HeroAllWeapons )
			for weaponName in pairs( CurrentRun.Hero.Weapons ) do
				if WeaponData[weaponName] ~= nil and WeaponData[weaponName].SecondaryWeapon and not CurrentRun.Hero.Weapons[WeaponData[weaponName].SecondaryWeapon] then
					CurrentRun.Hero.Weapons[WeaponData[weaponName].SecondaryWeapon] = true
				end
				if not validWeapons[weaponName] then
					table.insert( removedWeapons, weaponName )
				end
			end

			for i, weaponName in pairs(removedWeapons) do
				CurrentRun.Hero.Weapons[weaponName] = nil
			end
			for weaponName in pairs(HeroData.Weapons ) do
				CurrentRun.Hero.Weapons[weaponName] = true
			end

			local weaponDataOverride = CurrentRun.Hero.WeaponDataOverride
			if weaponDataOverride ~= nil then
				for weaponName, weaponData in pairs( weaponDataOverride ) do
					if weaponData.OnHitFunctionNames ~= nil then
						for k, functionName in ipairs( weaponData.OnHitFunctionNames ) do
							if _G[functionName] == nil then
								weaponData.OnHitFunctionNames[k] = nil
							end
						end
					end
					if weaponData.UnarmedCastCompleteGraphic ~= nil then
						weaponData.UnarmedCastCompleteGraphic = WeaponData[weaponName].UnarmedCastCompleteGraphic
					end
					if WeaponData[weaponName] and WeaponData[weaponName].OnProjectileDeathFunctionArgs and weaponData.OnProjectileDeathFunctionArgs == nil then
						weaponData.OnProjectileDeathFunctionArgs = DeepCopyTable(WeaponData[weaponName].OnProjectileDeathFunctionArgs)
					end
				end
			end

			CurrentRun.Hero.DashManeuverTimeThreshold = CurrentRun.Hero.DashManeuverTimeThreshold or HeroData.DashManeuverTimeThreshold
			CurrentRun.Hero.InvulnerableFrameMinDamage = CurrentRun.Hero.InvulnerableFrameMinDamage or HeroData.InvulnerableFrameMinDamage
			CurrentRun.Hero.StackData.AllowRarityOverride  = HeroData.StackData.AllowRarityOverride

			if not IsEmpty(CurrentRun.Hero.ManaRegenSources) then
				for key in pairs(CurrentRun.Hero.ManaRegenSources) do
					if not CurrentRun.Hero.ManaRegenSources[key] or type(CurrentRun.Hero.ManaRegenSources[key]) ~= "table" then
						CurrentRun.Hero.ManaRegenSources[key] = { Value = CurrentRun.Hero.ManaRegenSources[key] or 0 }
					end
				end
			end

			if CurrentRun.Hero.IsDead and CurrentRun.ActiveBiomeTimer then
				CurrentRun.ActiveBiomeTimer = false
			end
			if CurrentRun.Hero.OutgoingCritModifiers then
				local condemnedIds = {}
				for i, modifierData in pairs(CurrentRun.Hero.OutgoingCritModifiers) do
					if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
						modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
					end
					if modifierData.Temporary then
						table.insert(condemnedIds, i)
					end
				end
				if not IsEmpty(condemnedIds) then
				
					for i, index in pairs(condemnedIds) do
						CurrentRun.Hero.OutgoingCritModifiers[index] = nil
					end
					CurrentRun.Hero.OutgoingCritModifiers = CollapseTable(CurrentRun.Hero.OutgoingCritModifiers)
				end
			end
			if CurrentRun.Hero.OutgoingDamageModifiers then
				local condemnedIds = {}
				for i, modifierData in pairs(CurrentRun.Hero.OutgoingDamageModifiers) do
					if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
						modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
					end
					if modifierData.Temporary then
						table.insert(condemnedIds, i)
					end
				end
				if not IsEmpty(condemnedIds) then
				
					for i, index in pairs(condemnedIds) do
						CurrentRun.Hero.OutgoingDamageModifiers[index] = nil
					end
					CurrentRun.Hero.OutgoingDamageModifiers = CollapseTable(CurrentRun.Hero.OutgoingDamageModifiers)
				end
			end
			if CurrentRun.Hero.IncomingDamageModifiers then
				local condemnedIds = {}
				for i, modifierData in pairs(CurrentRun.Hero.IncomingDamageModifiers) do
					if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
						modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
					end
					if modifierData.Temporary then
						table.insert(condemnedIds, i)
					end
				end
				if not IsEmpty(condemnedIds) then
					for i, index in pairs(condemnedIds) do
						CurrentRun.Hero.IncomingDamageModifiers[index] = nil
					end
					CurrentRun.Hero.IncomingDamageModifiers = CollapseTable(CurrentRun.Hero.IncomingDamageModifiers)
				end
			end
			if CurrentRun.Hero.BoonData ~= nil then
				CurrentRun.Hero.BoonData.GameStateRequirements = HeroData.BoonData.GameStateRequirements or CurrentRun.Hero.BoonData.GameStateRequirements
			end

			if CurrentRun.Hero.RecentTraits ~= nil then
				if type(CurrentRun.Hero.RecentTraits[1]) ~= "table" then
					CurrentRun.Hero.RecentTraits = {}
				end
			else
				CurrentRun.Hero.RecentTraits = {}
			end

			local traitsToAdd = {}
			local traitsToRemove = {}
			SessionState.PatchingTraits = true

			if TableLength( CurrentRun.Hero.Traits ) ~= #CurrentRun.Hero.Traits then
				CurrentRun.Hero.Traits = CollapseTable( CurrentRun.Hero.Traits )
			end

			for i, trait in pairs(CurrentRun.Hero.Traits) do
				local traitData = TraitData[trait.Name]
				trait.AnchorId = nil
				trait.TraitIconOverlay = nil
				trait.TraitInfoCardId = nil
				trait.TraitInfoUsesId = nil
				trait.TraitInfoChargeId = nil
				trait.TraitActiveOverlay = nil
				trait.AdditionalDataAnchorId = nil
				trait.AdvancedTooltipFrame = nil
				trait.AdvancedTooltipIcon = nil
				trait.Id = trait.Id or GetTraitUniqueId()
				local addTraitToUpdate = function ( trait )
					if trait.OnExpire then
						trait.OnExpire = nil
						IncrementTableValue( traitsToRemove, trait.Name )
					else
						traitsToAdd[trait.Name] = { Rarity = trait.Rarity or "Common", StackCount = trait.StackNum or 1 }
					end

				end
				local traitData = TraitData[trait.Name]
				if TraitData[trait.Name] and trait.Icon ~= TraitData[trait.Name].Icon then
					trait.Icon = TraitData[trait.Name].Icon 
				end
				if traitData == nil then
					IncrementTableValue(traitsToRemove, trait.Name)
				elseif TableLength(trait.PropertyChanges, true) ~= TableLength(TraitData[trait.Name].PropertyChanges, true) or
				   TableLength(trait.EnemyPropertyChanges, true) ~= TableLength(TraitData[trait.Name].EnemyPropertyChanges, true) or
				   TableLength( trait.LoadBinks, true) ~= TableLength( TraitData[trait.Name].LoadBinks, true) or 
				   TableLength( trait.PreEquipWeapons, true) ~= TableLength( TraitData[trait.Name].PreEquipWeapons, true) or
				   TableLength( trait.ExtractValues, true) ~= TableLength( TraitData[trait.Name].ExtractValues, true) then
					addTraitToUpdate( trait )
				elseif trait.Name == "SupportingFireBoon" and trait.ExtractValues[1] and trait.ExtractValues[1].BaseName == "ArtemisLegendary" then
					addTraitToUpdate( trait )
				elseif trait.Name == "LastStandFamiliar" and trait.ExtractValues[1] and trait.ExtractValues[1].BaseName == "CatFamiliarBall" then
					addTraitToUpdate( trait )
				elseif trait.Name == "DemeterManaBoon" and trait.SetupFunction and trait.SetupFunction.Args and not trait.SetupFunction.Args.PercentManaRegenPerSecond then
					addTraitToUpdate( trait )
				elseif trait.Name == "StaffSelfHitAspect" and Revision <= 95285 then
					traitsToAdd[trait.Name] = { Rarity = trait.Rarity or "Common", StackCount = trait.StackNum or 1 }
				elseif trait.Name == "HephaestusCastBoon" and Revision <= 98200 then
					addTraitToUpdate( trait )
				elseif trait.Name == "ChannelSlowMetaUpgrade" and Revision <= 94115 then
					addTraitToUpdate( trait )
				elseif trait.Name == "FamiliarCatCrit" and Revision <= 79800 then
					addTraitToUpdate( trait )
				elseif trait.Name == "LastStandFamiliar" and Revision <= 79800 then
					addTraitToUpdate( trait )
				elseif trait.Name == "AthenaEncounterKeepsake" and Revision <= 102718 then
					addTraitToUpdate( trait )
				elseif trait.Name == "DemeterSprintBoon" and trait.OnWeaponFiredFunctions and trait.OnWeaponFiredFunctions.FunctionArgs and IsEmpty( trait.OnWeaponFiredFunctions.FunctionArgs.ProjectileNames ) then
					addTraitToUpdate( trait )
				elseif trait.SetupFunction ~= nil and traitData.SetupFunction == nil then
					addTraitToUpdate( trait )
				else
					for key, data in pairs (TraitData[trait.Name]) do
						if trait[key] == nil and key ~= "RemainingUses" and key ~= "Slot" and key ~= "ActiveSlotOffsetIndex" then
							addTraitToUpdate(  trait )
							break
						end
					end
				end

				if trait.PropertyChanges ~= nil then
					for k, propertyChange in pairs( trait.PropertyChanges ) do
						if propertyChange.ProjectileProperty == "DamagePerConescutiveHit" then
							addTraitToUpdate( trait )
						elseif propertyChange.WeaponProperty == "AdditionalProjectileDamageMultiplier" then
							addTraitToUpdate( trait )
						elseif propertyChange.LifeProperty == "MaxHealth" then
							addTraitToUpdate( trait )
						elseif propertyChange.LifeProperty == "Health" then
							addTraitToUpdate( trait )
						end
					end
				end

				if trait.SetupFunction ~= nil then
					if traitData ~= nil and traitData.SetupFunction ~= nil and traitData.SetupFunction.Threaded then
						trait.SetupFunction.Threaded = true
					end
				end

				if trait.ActivationRequirements ~= nil then
					for index, requirement in ipairs( trait.ActivationRequirements ) do
						if requirement.ReportValues ~= nil then
							addTraitToUpdate( trait )
							break
						end
					end
				end

				if trait.RoomsPerUpgrade and IsTraitActive(trait) then
					if trait.RoomsPerUpgrade and trait.RoomsPerUpgrade.Rarity and not IsEmpty(trait.HarvestBoons) then
						if not CurrentRun.Hero.UpgradeableTraitCountCache then
							local traitCount = 0
							if trait.DowngradeTraitNames ~= nil then
								for _, traitName in pairs( trait.DowngradeTraitNames ) do
									local targetTrait = GetHeroTrait( traitName )
									if GetUpgradedRarity(targetTrait.Rarity) ~= nil and targetTrait.RarityLevels[GetUpgradedRarity(targetTrait.Rarity)] ~= nil then
										traitCount = traitCount + 1
									end
								end
							end
							CurrentRun.Hero.UpgradeableTraitCountCache = traitCount	
						elseif CurrentRun.Hero.UpgradeableTraitCountCache == 0 then
							trait.CurrentRoom = 0
						end
					elseif trait.RoomsPerUpgrade and trait.RoomsPerUpgrade.DowngradeRarity and not IsEmpty(trait.DowngradeTraitNames) then
						if not CurrentRun.Hero.DowngradableTraitCountCache then
							local traitCount = 0
							for _, traitName in pairs( trait.DowngradeTraitNames ) do
								local targetTrait = GetHeroTrait( traitName )
								if GetDowngradedRarity(targetTrait.Rarity) ~= nil and targetTrait.RarityLevels[GetDowngradedRarity(targetTrait.Rarity)] ~= nil then
									traitCount = traitCount + 1
								end
							end
							CurrentRun.Hero.DowngradableTraitCountCache = traitCount
						elseif CurrentRun.Hero.DowngradableTraitCountCache == 0 then
							trait.CurrentRoom = 0
						end
					end
				end

				if trait.AddOutgoingDamageModifiers and trait.AddOutgoingDamageModifiers.ValidWeapons and not trait.AddOutgoingDamageModifiers.ValidWeaponsLookup then
					addTraitToUpdate( trait )
				end

				if trait.PrePickSacrificeBoon and not trait.SacrificedTraitName then
					trait.SacrificedTraitName = "None_In_Slot"
				end
				
				if not traitsToRemove[trait.Name] and not traitsToAdd[trait.Name] then			
					ExtractValues( CurrentRun.Hero, trait, trait )
				end

				if trait.Slot == "Spell" then
					local weaponName = trait.PreEquipWeapons[1]
					local data = GetWeaponData( CurrentRun.Hero, weaponName )
					if data and not data.ManaSpendCost and CurrentRun.Hero.WeaponDataOverride[weaponName] then
						CurrentRun.Hero.WeaponDataOverride[weaponName].ManaSpendCost = WeaponData[trait.PreEquipWeapons[1]].ManaSpendCost
					end
				end
			end

			if not IsEmpty( CurrentRun.TemporaryMetaUpgrades ) and GetNumShrineUpgrades( "NoMetaUpgradesShrineUpgrade" ) >= 1 then
				for metaUpgradeName in pairs( CurrentRun.TemporaryMetaUpgrades ) do
					GameState.MetaUpgradeState[metaUpgradeName].Equipped = false
					local metaUpgradeTraitName = MetaUpgradeCardData[metaUpgradeName].TraitName
					if metaUpgradeTraitName ~= nil then
						IncrementTableValue( traitsToRemove, metaUpgradeTraitName )
					end
				end
				CurrentRun.TemporaryMetaUpgrades = {}
			end

			local orderedTraitsToAdd = CollapseTableAsOrderedKeyValuePairs(traitsToAdd)
			for index, kvp in ipairs(orderedTraitsToAdd) do
				local traitName = kvp.Key
				local trait = kvp.Value
				local traitData = TraitData[traitName] or trait
				DebugPrint({Text = " Updating " .. traitName })
				RemoveWeaponTrait( traitName, { Silent = true, SkipActivatedTraitUpdate = true })
				AddTraitToHero({ TraitName = traitName, Rarity = trait.Rarity, StackNum = trait.StackCount, SkipActivatedTraitUpdate = true, FromLoot = traitData.FromLootOnUpdate })
			end

			local orderedTraitsToRemove = CollapseTableAsOrderedKeyValuePairs(traitsToRemove)
			for index, kvp in ipairs(orderedTraitsToRemove) do
				local traitName = kvp.Key
				local traitNumber = kvp.Value
				for i=1, traitNumber do
					DebugPrint({Text = " Removing " .. traitName })
					RemoveTrait( CurrentRun.Hero, traitName )
				end
			end

			if CurrentRun.Hero.VisibleNonHUDTraitCount == nil then
				local nonHUDTraitCount = 0
				for i, trait in ipairs( CurrentRun.Hero.Traits ) do
					if not trait.Hidden and not IsShownInHUD( trait ) then
						nonHUDTraitCount = nonHUDTraitCount + 1
					end
				end
				CurrentRun.Hero.VisibleNonHUDTraitCount = nonHUDTraitCount
			end

			ValidateMaxHealth()
			ValidateMaxMana()
			CleanRecentTraitsRecord()
			UpdateTalentPointInvestedCache()
			
			SessionState.PatchingTraits = false
			CurrentRun.Hero.TargetMetaRewardsRatio = CurrentRun.Hero.TargetMetaRewardsRatio or HeroData.TargetMetaRewardsRatio
			CurrentRun.Hero.CanBeFrozen = CurrentRun.Hero.CanBeFrozen or HeroData.CanBeFrozen
			CurrentRun.Hero.LowHealthVoiceLines = HeroData.LowHealthVoiceLines or CurrentRun.Hero.LowHealthVoiceLines

		end	

		-- This fixes Fields passive spawn distributions on old saves
		if CurrentRun.CurrentRoom.Encounter ~= nil then
			local encounterData = EncounterData[CurrentRun.CurrentRoom.Encounter.Name]
			if encounterData ~= nil then
				CurrentRun.CurrentRoom.Encounter.RequireNearPlayerDistance = encounterData.RequireNearPlayerDistance
				CurrentRun.CurrentRoom.Encounter.NeverDelaySpellCharge = encounterData.NeverDelaySpellCharge
				CurrentRun.CurrentRoom.Encounter.NeverDelayManaRegen = encounterData.NeverDelayManaRegen
			end
		end

		if CurrentRun.ActiveBiomeTimer and CurrentRun.ShrineUpgradesDisabled["BiomeSpeedShrineUpgrade"] then
			CurrentRun.ActiveBiomeTimer = false
		end

		if CurrentRun.DamageDealtRecord ~= nil then
			SplitUpDamageDealtRecord( CurrentRun )
			CurrentRun.DamageDealtRecord = nil
		end

		if not GameState.LifetimeRecordsBackCompatChecked then
			UpdateLifetimeTraitRecords( CurrentRun )
			GameState.LifetimeRecordsBackCompatChecked = true
		end

		--[[
		if not GameState.PatchedDuplicatedStats then
			local totalRuns = #GameState.RunHistory
			if CurrentRun.Hero ~= nil and CurrentRun.Hero.IsDead then
				totalRuns = totalRuns + 1
			end

			local totalWeaponUses = 0
			for weaponName, stat in pairs( GameState.LifetimeWeaponStats ) do
				totalWeaponUses = totalWeaponUses + (stat.UseCount or 0)
			end

			local duplicatedRuns = totalWeaponUses - totalRuns
			if duplicatedRuns > 0 then
				if CurrentRun.Hero ~= nil and CurrentRun.Hero.IsDead then
					if DeduplicateRunStats( CurrentRun ) then
						duplicatedRuns = duplicatedRuns - 1
					end
				end

				for i=#GameState.RunHistory, 1, -1 do
					if duplicatedRuns <= 0 then
						break
					end
					if DeduplicateRunStats( GameState.RunHistory[i] ) then
						duplicatedRuns = duplicatedRuns - 1
					end
				end
			end

			GameState.PatchedDuplicatedStats = true
		end
		]]

		if CurrentRun.EndingKeepsakeName ~= nil then
			table.insert( CurrentRun.KeepsakeCache, CurrentRun.EndingKeepsakeName )
			CurrentRun.EndingKeepsakeName = nil
		end

		if CurrentRun.LootTypeHistory ~= nil then
			for lootName, i in pairs(CurrentRun.LootTypeHistory) do
				if not GameData.MissingPackages[lootName] then
					LoadPackages({ Name = lootName })
				end
			end
		end
		local traitPackageNames = {}
		for i, trait in pairs( CurrentRun.Hero.Traits ) do
			if trait.PackageName ~= nil and not GameData.MissingPackages[trait.PackageName] then
				traitPackageNames[trait.PackageName] = true
			end
		end
		for packageName, v in pairs( traitPackageNames ) do
			LoadPackages({ Name = packageName })
		end

	end
	DebugPrint({ Text = "Done patching." })
end

function SplitUpDamageDealtRecord( state )

	-- Loop through all enemy weapons/projectiles.
	-- We don't know if the attack was performed by a friendly or hostile enemy, so let's just assume it was hostile.
	for weaponName, weaponData in pairs( WeaponDataEnemies ) do
		state.DamageDealtByEnemiesRecord[weaponName] = state.DamageDealtRecord[weaponName]
		if weaponData.AIData ~= nil then
			if weaponData.AIData.ProjectileName ~= nil then
				state.DamageDealtByEnemiesRecord[weaponData.AIData.ProjectileName] = state.DamageDealtRecord[weaponData.AIData.ProjectileName]
			end
			if weaponData.AIData.AttackSlots ~= nil then
				for i, slot in ipairs( weaponData.AIData.AttackSlots ) do
					if slot.ProjectileName ~= nil then
						state.DamageDealtByEnemiesRecord[slot.ProjectileName] = state.DamageDealtRecord[slot.ProjectileName]
					end
				end
			end
			if weaponData.AIData.ConditionalProjectiles ~= nil then
				for i, projData in ipairs( weaponData.AIData.ConditionalProjectiles ) do
					state.DamageDealtByEnemiesRecord[projData.ProjectileName] = state.DamageDealtRecord[projData.ProjectileName]
				end
			end
		end
	end

	-- There are a handful of enemy damage sources that slip through the cracks...
	local otherEnemyDamageSources =
	{
		"CerberusCircleSequenceProjectile",
		"CerberusTransitionRadial",
		"ChronosBoltOrbit",
		"GreekFire",
		"ZombieHRFire",
		"SatyrFire",
		"PolyphemusBoulderSky",
		"PolyphemusStomachAche",
	}
	for i, source in ipairs( otherEnemyDamageSources ) do
		state.DamageDealtByEnemiesRecord[source] = state.DamageDealtRecord[source]
	end

	-- Ignore friendly NPC attacks
	local friendlyNPCDamageSources =
	{
		"ArtemisSniperBolt",
		"IcarusBombardment",
		"IcarusBombardment_Large",
		"NemesisAttack1",
		"NemesisAttack2",
		"NemesisAttack3",
		"NemesisSpecial",
		"HeraclesArcRight",
		"HeraclesLeap",
	}

	-- Anything remaining was probably dealt by the hero
	for source, damageDealt in pairs( state.DamageDealtRecord ) do
		if state.DamageDealtByEnemiesRecord[source] == nil and not Contains( friendlyNPCDamageSources, source ) then
			state.DamageDealtByHeroRecord[source] = damageDealt
		end
	end

end

--[[
function DeduplicateRunStats( run )
	if not run.Cleared then
		return false
	end
	if run.TraitCache ~= nil then
		for traitName in pairs( run.TraitCache ) do
			GameState.LifetimeTraitStats[traitName].UseCount = GameState.LifetimeTraitStats[traitName].UseCount - 1
			GameState.LifetimeTraitStats[traitName].ClearCount = GameState.LifetimeTraitStats[traitName].ClearCount - 1
			if run.BiomesReached == nil or run.BiomesReached.F then
				GameState.LifetimeTraitStats[traitName].ClearCountUnderworld = GameState.LifetimeTraitStats[traitName].ClearCountUnderworld - 1
			else
				GameState.LifetimeTraitStats[traitName].ClearCountSurface = GameState.LifetimeTraitStats[traitName].ClearCountSurface - 1
			end
		end
	end
	if run.WeaponsCache ~= nil then
		for weaponName in pairs( run.WeaponsCache ) do
			if Contains( WeaponSets.HeroPrimaryWeapons, weaponName ) then
				GameState.LifetimeWeaponStats[weaponName].UseCount = GameState.LifetimeWeaponStats[weaponName].UseCount - 1
				GameState.LifetimeWeaponStats[weaponName].ClearCount = GameState.LifetimeWeaponStats[weaponName].ClearCount - 1
				if run.BiomesReached == nil or run.BiomesReached.F then
					GameState.LifetimeWeaponStats[weaponName].ClearCountUnderworld = GameState.LifetimeWeaponStats[weaponName].ClearCountUnderworld - 1
				else
					GameState.LifetimeWeaponStats[weaponName].ClearCountSurface = GameState.LifetimeWeaponStats[weaponName].ClearCountSurface - 1
				end
			end
		end
	end
	return true
end
]]
