function DoPatches()

	Revision = Revision or 0
	if Revision > 0 and RevisionFirstSave == nil then
		RevisionFirstSave = Revision
	end

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
			for keyName, v in pairs( RecentRunTablesSaveWhitelist ) do
				prevRun[keyName] = prevRun[keyName] or {}
			end
		end

		GameState.CompletedRunsCache = GetCompletedRuns()

		if GameState.FamiliarResourceSpawnChance then
			GameState.FamiliarResourceSpawnChance = nil
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

		for name, status in pairs( GameState.QuestStatus ) do
			if status == "Complete" or status == "CashedOut" then
				GameState.QuestsCompleted[name] = true
			end
		end

		for id, plot in pairs( GameState.GardenPlots ) do
			if plot.StoredGrows ~= nil then
				plot.ReadyForHarvest = (plot.StoredGrows >= 1)
				plot.StoredGrows = nil
			end

			if plot.TimesUsed == nil then
				if plot.SeedName ~= nil then
					plot.TimesUsed = 1
				else
					plot.TimesUsed = 0
				end
			end

			if plot.PlayedRevealStatus == nil then
				plot.PlayedRevealStatus = (plot.StatusAnimation ~= nil)
			end

			local plotData = ObstacleData[plot.Name]
			if plotData ~= nil then
				plot.SpecialInteractFunctionName = plotData.SpecialInteractFunctionName
				plot.UnlimitedGifts = plotData.UnlimitedGifts
			end

			local seedData = GardenData.Seeds[plot.SeedName]
			if seedData == nil then
				plot.GrowTimeRemaining = nil
				plot.ReadyForHarvest = false
				plot.SeedName = nil
				plot.UseText = "UseGardenPlotPlant"
				plot.TalkOnlyIfNoGiftOrSpecial = true
			end
		end

		if GameState.BountiesCompleted ~= nil then
			for bountyName, v in pairs( GameState.BountiesCompleted ) do
				local bountyData = BountyData[bountyName]
				if bountyData ~= nil then
					if bountyData.IsPackagedBounty then
						-- These were not being recorded on old saves for some reason.
						if GameState.PackagedBountyClearRecordTime[bountyName] == nil then
							local bestTime = 999999
							for i, runData in ipairs( GameState.RunHistory ) do
								if runData.ActiveBounty == bountyName and runData.BountyCleared and runData.GameplayTime < bestTime then
									bestTime = runData.GameplayTime
								end
							end
							if CurrentRun ~= nil and CurrentRun.ActiveBounty == bountyName and CurrentRun.BountyCleared and CurrentRun.GameplayTime < bestTime then
								bestTime = CurrentRun.GameplayTime
							end
							GameState.PackagedBountyClearRecordTime[bountyName] = bestTime
						end
					else
						GameState.ShrineBountiesCompleted[bountyName] = true
					end
				end
			end
			GameState.BountiesCompleted = nil
		end

		local swappedBountiesCompleted = {}
		for bountyName, v in pairs( GameState.ShrineBountiesCompleted ) do
			local newBountyName = BountyData.ShrineBountyNameSwapMap[bountyName] or bountyName
			swappedBountiesCompleted[newBountyName] = v
		end
		GameState.ShrineBountiesCompleted = swappedBountiesCompleted

		local modifiedStoreItemPins = false
		local pinNames = {}
		for index, pin in pairs( GameState.StoreItemPins ) do
			if pinNames[pin.Name] then
				-- Found dupe
				modifiedStoreItemPins = true
				GameState.StoreItemPins[index] = nil
			else
				pinNames[pin.Name] = true
				if _G[pin.StoreName] == nil or _G[pin.StoreName][pin.Name] == nil then
					modifiedStoreItemPins = true
					GameState.StoreItemPins[index] = nil
				end
			end
		end
		if modifiedStoreItemPins then
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

		local worldUpgradesToRemove =
		{
			"WorldUpgradeMemPointsCommonRunProgress",
		}
		if GameState.TextLinesRecord.DoraGrantsCosmeticsShop01 == nil then
			table.insert( worldUpgradesToRemove, "Cosmetic_TentBlanket01b" )
		end
		for i, upgradeName in ipairs( worldUpgradesToRemove ) do
			GameState.WorldUpgrades[upgradeName] = nil
			GameState.WorldUpgradesAdded[upgradeName] = nil
		end

		for shrineUpgrade, value in pairs( GameState.ShrineUpgrades ) do
			if MetaUpgradeData[shrineUpgrade] == nil then
				GameState.ShrineUpgrades[shrineUpgrade] = nil
			end
		end

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

			GameState.RemovedPreTyphonSurfaceRecords = true
		end
		
		if not GameState.RemovedPreTyphonSurfaceRecords then
			for _, stat in pairs( GameState.LifetimeTraitStats ) do
				if stat.ClearCountSurface ~= nil then
					stat.ClearCount = stat.ClearCount - stat.ClearCountSurface
					stat.ClearCountSurface = nil
					stat.FastestTimeSurface = nil
					stat.HighestShrinePointsSurface = nil
				end
			end
			GameState.RemovedPreTyphonSurfaceRecords = true
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
				end
			end
			GameState.FamiliarUses = nil
			GameState.FamiliarStatus = nil
		end

		-- Remove pins for cards / grasp level that were already at max rank
		if not GameState.RemovedMaxRankMetaUpgradePins then
			local maxRankGraspName = "MetaUpgradeLevelData"..(#MetaUpgradeCostData.MetaUpgradeLevelData + 1)
			if HasStoreItemPin( maxRankGraspName ) then
				RemoveStoreItemPin( maxRankGraspName )
			end
			for cardName, cardData in pairs( MetaUpgradeCardData ) do
				local maxRankCardName = cardName..(#cardData.UpgradeResourceCost + 1)
				if HasStoreItemPin( maxRankCardName ) then
					RemoveStoreItemPin( maxRankCardName )
				end
			end
			GameState.RemovedMaxRankMetaUpgradePins = true
		end

		if not GameState.PatchedSpeechRecords2 then
			for cue, value in pairs( ShallowCopyTable( GameState.SpeechRecord ) ) do
				if type(value) == "boolean" then
					GameState.SpeechRecord[cue] = 1
				end
			end
			if CurrentRun ~= nil then
				for cue, value in pairs( ShallowCopyTable( CurrentRun.SpeechRecord ) ) do
					if type(value) == "boolean" then
						CurrentRun.SpeechRecord[cue] = 1
					end
				end
				if CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.SpeechRecord ~= nil then
					for cue, value in pairs( ShallowCopyTable( CurrentRun.CurrentRoom.SpeechRecord ) ) do
						if type(value) == "boolean" then
							CurrentRun.CurrentRoom.SpeechRecord[cue] = 1
						end
					end
				end
			end
			GameState.PatchedSpeechRecords2 = true
		end

		if GameState.TextLinesRecord.ErisGift01_B then
			GameState.TextLinesRecord.ErisGift01_B = nil
			GameState.TextLinesRecord.ErisGift01 = true
		end

		for sourceName, giftRecordOrder in pairs( GameState.GiftRecord ) do
			local giftSource = LootData[sourceName] or EnemyData[sourceName]
			local narrativeData = NarrativeData[sourceName]
			if giftSource ~= nil and narrativeData ~= nil then
				local missingFirstGiftEvent = false
				if IsEmpty( GameState.GiftTextLinesOrderRecord[sourceName] ) then
					missingFirstGiftEvent = true
				else
					for i, eventName in ipairs( GameState.GiftTextLinesOrderRecord[sourceName] ) do
						local eventData = giftSource.GiftTextLineSets[eventName]
						if eventData ~= nil and eventData.OnGiftTrack then
							if eventName ~= narrativeData.GiftTextLinePriorities[1] then
								missingFirstGiftEvent = true
							end
							break
						end
					end
				end
				if missingFirstGiftEvent then
					GameState.GiftTextLinesOrderRecord[sourceName] = {}
					local giftEvents = narrativeData.GiftTextLinePriorities
					if giftEvents ~= nil then
						--DebugPrint({ Text = "sourceName = "..sourceName })
						local completedEvents = {}
						for i, eventName in ipairs( giftEvents ) do
							--DebugPrint({ Text = "eventName = "..eventName })
							local giftEventData = giftSource.GiftTextLineSets[eventName]
							if giftEventData.OnGiftTrack and GameState.TextLinesRecord[giftEventData.Name] then
								table.insert( completedEvents, giftEventData )
								--DebugPrint({ Text = "completedEvents = "..eventName })
							end
						end
						for i, resourceName in ipairs( giftRecordOrder ) do
							local giftEventData = RemoveNextEventWithResource( completedEvents, resourceName )
							if giftEventData ~= nil then
								table.insert( GameState.GiftTextLinesOrderRecord[sourceName], giftEventData.Name )
							end
						end
					end
				end
			end
		end

		if IsEmpty( GameState.UnlockedMusicPlayerSongs ) then
			for i, songName in ipairs( ScreenData.MusicPlayer.Songs ) do
				if GameState.WorldUpgrades[songName] then
					table.insert( GameState.UnlockedMusicPlayerSongs, songName )
				end
			end
		else
			local songsToRemove = {}
			for i, songName in ipairs( GameState.UnlockedMusicPlayerSongs ) do
				if WorldUpgradeData[songName] == nil then
					table.insert( songsToRemove, songName )
				end
			end
			if not IsEmpty( songsToRemove ) then
				for i, songName in ipairs( songsToRemove ) do
					RemoveValueAndCollapse( GameState.UnlockedMusicPlayerSongs, songName )
				end
				if GameState.MusicPlayerPlaylist ~= nil then
					GameState.MusicPlayerPlaylist = MusicPlayerGetShuffledPlaylist()
				end
			end
		end

		if GameState.EasyModeLevel >= 2 then
			SetConfigOption({ Name = "EasyModeIncremented", Value = true })
		end

		GameState.LifetimeWeaponStats = nil

		if StoredGameState ~= nil and StoredGameState.RunHistory ~= nil then
			StoredGameStateInit( StoredGameState )
		end

		if GameState.HighestRunDepthCache == 0 then
			local highestDepth = 1
			if CurrentRun ~= nil and CurrentRun.RunDepthCache ~= nil and highestDepth < CurrentRun.RunDepthCache then
				highestDepth = CurrentRun.RunDepthCache
			end
			for _, run in ipairs( GameState.RunHistory ) do
				if run.RunDepthCache ~= nil and highestDepth < run.RunDepthCache then
					highestDepth = run.RunDepthCache
				end
			end
			GameState.HighestRunDepthCache = highestDepth
		end

		if GameState.FastestUnderworldClearTimeCache == 0 or GameState.FastestSurfaceClearTimeCache == 0 then
			local fastestTimeUnderworld = 999999
			local fastestTimeSurface = 999999
			if CurrentRun ~= nil and CurrentRun.Cleared and CurrentRun.GameplayTime ~= nil then
				if (CurrentRun.BiomesReached == nil or CurrentRun.BiomesReached.F) then
					if fastestTimeUnderworld > CurrentRun.GameplayTime then
						fastestTimeUnderworld = CurrentRun.GameplayTime
					end
				else
					if fastestTimeSurface > CurrentRun.GameplayTime then
						fastestTimeSurface = CurrentRun.GameplayTime
					end
				end
			end
			for _, run in ipairs( GameState.RunHistory ) do
				if run.Cleared and run.GameplayTime ~= nil then
					if run.BiomesReached == nil or run.BiomesReached.F then
						if fastestTimeUnderworld > run.GameplayTime then
							fastestTimeUnderworld = run.GameplayTime
						end
					else
						if fastestTimeSurface > run.GameplayTime then
							fastestTimeSurface = run.GameplayTime
						end
					end
				end
			end
			GameState.FastestUnderworldClearTimeCache = fastestTimeUnderworld
			GameState.FastestSurfaceClearTimeCache = fastestTimeSurface
		end

		if not GameState.PatchedRunResults3 then
			for _, run in ipairs( GameState.RunHistory ) do
				if run.RunResult == nil then
					run.RunResult = GetRunResult( run )
				end
			end
			if CurrentRun ~= nil and CurrentRun.RunResult == nil and CurrentRun.Hero ~= nil and ( CurrentRun.Hero.IsDead or CurrentRun.Cleared ) then
				CurrentRun.RunResult = GetRunResult( CurrentRun )
			end
			GameState.PatchedRunResults3 = true
		end

		if not GameState.PatchedShrineBountyRewards then
			for bountyName, bountyData in pairs( BountyData ) do
				if not bountyData.IsPackagedBounty then
					if bountyData.LootOptions ~= nil and bountyData.LootOptions[1] ~= nil and bountyData.LootOptions[1].Overrides ~= nil and bountyData.LootOptions[1].Overrides.AddResources ~= nil then
						local reward = bountyData.LootOptions[1].Overrides.AddResources.WeaponPointsRare or 0
						if GameState.ShrineBountiesCompleted[bountyName] and reward > 1 then
							AddResource( "WeaponPointsRare", reward - 1, "Patch", { Silent = true, SkipVoiceLines = true } )
						end
					end
				end
			end
			GameState.PatchedShrineBountyRewards = true
		end

		if GameState.LastBossHealthBarRecord.BossScylla01 ~= nil then
			GameState.LastBossHealthBarRecord.Scylla = GameState.LastBossHealthBarRecord.BossScylla01
			GameState.LastBossHealthBarRecord.BossScylla01 = nil
			GameState.LastBossHealthBarRecord.BossScylla02 = nil
		end

		if GameState.LastBossDifficultyRecord.BossScylla01 ~= nil then
			GameState.LastBossDifficultyRecord.Scylla = GameState.LastBossDifficultyRecord.BossScylla01
			GameState.LastBossDifficultyRecord.BossScylla01 = nil
		end

		if GameState.Resources.MysteryResource ~= nil then
			GameState.Resources.MysteryResource = nil
			GameState.LifetimeResourcesGained.MysteryResource = nil
		end

		GameState.Resources.CosmeticsPointsCommon = nil
		GameState.LifetimeResourcesGained.CosmeticsPointsCommon = nil

		if GameState.CosmeticsPurchasedCountCache.Total == nil then
			local totalPurchased = 0
			for i, category in ipairs( ScreenData.CosmeticsShop.ItemCategories ) do
				local categoryCount = 0
				for j, itemName in ipairs( category ) do
					if GameState.WorldUpgradesAdded[itemName] and not Contains( GameData.WorldUpgradeAutomaticUnlocks, itemName ) then
						categoryCount = categoryCount + 1
						totalPurchased = totalPurchased + 1
					end
				end
				GameState.CosmeticsPurchasedCountCache[category.CacheName] = categoryCount
			end
			GameState.CosmeticsPurchasedCountCache.Total = totalPurchased
		end

		if GameState.ClearedRunsCache > 0 and IsEmpty( GameState.PlayedRunClearMessages ) then
			GameState.ClearedUnderworldRunsCache = GameState.ClearedUnderworldRunsCache or 0
			if GameState.ClearedUnderworldRunsCache >= 1 then
				GameState.PlayedRunClearMessages.ClearUnderworldNumOne = true
			end
			if GameState.ClearedUnderworldRunsCache >= 10 then
				GameState.PlayedRunClearMessages.ClearUnderworldNumTen = true
			end
			if GameState.ClearedUnderworldRunsCache >= 50 then
				GameState.PlayedRunClearMessages.ClearUnderworldNumFifty = true
			end
			if GameState.ClearedUnderworldRunsCache >= 100 then
				GameState.PlayedRunClearMessages.ClearUnderworldNumOneHundred = true
			end
			if GameState.ClearedUnderworldRunsCache >= 250 then
				GameState.PlayedRunClearMessages.ClearUnderworldNumTwoFifty = true
			end
			if GameState.ClearedUnderworldRunsCache >= 500 then
				GameState.PlayedRunClearMessages.ClearUnderworldNumFiveHundred = true
			end

			GameState.ClearedSurfaceRunsCache = GameState.ClearedSurfaceRunsCache or 0
			if GameState.ClearedSurfaceRunsCache >= 1 then
				GameState.PlayedRunClearMessages.ClearSurfaceNumOne = true
			end
			if GameState.ClearedSurfaceRunsCache >= 10 then
				GameState.PlayedRunClearMessages.ClearSurfaceNumTen = true
			end
			if GameState.ClearedSurfaceRunsCache >= 50 then
				GameState.PlayedRunClearMessages.ClearSurfaceNumFifty = true
			end
			if GameState.ClearedSurfaceRunsCache >= 100 then
				GameState.PlayedRunClearMessages.ClearSurfaceNumOneHundred = true
			end
			if GameState.ClearedSurfaceRunsCache >= 250 then
				GameState.PlayedRunClearMessages.ClearSurfaceNumTwoFifty = true
			end
			if GameState.ClearedSurfaceRunsCache >= 500 then
				GameState.PlayedRunClearMessages.ClearSurfaceNumFiveHundred = true
			end
		end

		if GameState.WorldUpgradesViewed.WeaponShop_Tools then
			GameState.Flags.HasUsedWeaponShopNavigation = true
		end

		if not GameState.PatchedFinalBossMixers then
			local mixerIAmount = GameState.Resources.MixerIBoss or 0
			local mixerQAmount = GameState.Resources.MixerQBoss or 0
			local mixerIReserve = 0
			local mixerQReserve = 0
			if CurrentRun ~= nil and CurrentRun.Hero ~= nil and not CurrentRun.Hero.IsDead and CurrentRun.Cleared then
				if CurrentRun.BiomesReached.I then
					mixerIReserve = 1
				elseif CurrentRun.BiomesReached.Q then
					mixerQReserve = 1
				end
			end
			local mixerICashOutValue = (mixerIAmount - mixerIReserve) * 50
			local mixerQCashOutValue = (mixerQAmount - mixerQReserve) * 100
			AddResource( "CosmeticsPoints", mixerICashOutValue + mixerQCashOutValue, "Patch", { Silent = true, SkipVoiceLines = true, SkipInventoryObjective = true } )
			GameState.Resources.MixerIBoss = mixerIReserve
			GameState.Resources.MixerQBoss = mixerQReserve
			GameState.PatchedFinalBossMixers = true
		end

		if not GameState.PatchedClearedWithRecords then
			if GameState.ClearedWithWeapons.I ~= nil then
				for weaponName in pairs( GameState.ClearedWithWeapons.I ) do
					GameState.ClearedWithWeapons[weaponName] = true
				end
			end
			if GameState.ClearedWithWeapons.Q ~= nil then
				for weaponName in pairs( GameState.ClearedWithWeapons.Q ) do
					GameState.ClearedWithWeapons[weaponName] = true
				end
			end
			for traitName, traitData in pairs( TraitData ) do
				if traitData.Slot == "Aspect" then
					if GameState.LifetimeTraitStats[traitName] ~= nil and (GameState.LifetimeTraitStats[traitName].ClearCount or 0) > 0 then
						local actualTraitName = GetKey( ScreenData.GameStats.WeaponBaseAspectMapping, traitName ) or traitName
						GameState.ClearedWithAspects[actualTraitName] = true
					end
				end
			end
			for familiarName, familiarData in pairs( FamiliarData ) do
				if familiarData.TraitNames ~= nil then
					local traitName = familiarData.TraitNames[1]
					if GameState.LifetimeTraitStats[traitName] ~= nil and (GameState.LifetimeTraitStats[traitName].ClearCount or 0) > 0 then
						GameState.ClearedWithFamiliars[familiarName] = true
					end
				end
			end
			GameState.PatchedClearedWithRecords = true
		end

		if not GameState.PatchedHecateAboutChronosBossW01 then
			GameState.TextLinesRecord.HecateAboutChronosBossW01 = nil
			GameState.PatchedHecateAboutChronosBossW01 = true
		end
		if GameState.TextLinesRecord.HecateAboutTyphonFight03 and not GameState.TextLinesRecord.ZeusPalaceFirstMeeting then
			GameState.TextLinesRecord.HecateAboutTyphonFight03 = nil
		end

		if GameState.TraitsTaken then
			if Revision <= 127486 then
				if not GameState.TextLinesRecord.MedeaAboutConcoctionQuestComplete01 then
					GameState.TraitsTaken.NewStatusDamage = nil
				end
				if not GameState.TextLinesRecord.CirceAboutScyllaQuestcomplete01 then
					GameState.TraitsTaken.ExPolymorphBoon = nil
				end
				if not GameState.TextLinesRecord.DionysusPostTrueEnding then
					GameState.TraitsTaken.RandomBaseDamageBoon = nil
				end
			end
		end

		local cauldronCookStatus = GameState.CookStatus[558175]
		if cauldronCookStatus ~= nil and cauldronCookStatus.ItemName == "WorldUpgradeCardUpgradePoints" then
			cauldronCookStatus.ItemName = "WorldUpgradeCardUpgradePoints2"
		end

		GameState.AchievementsUnlocked.AchExorciseShades = nil

		if not GameState.UseRecord.HadesSpear01 then
			GameState.Resources.HadesSpearPoints = nil
			GameState.LifetimeResourcesGained.HadesSpearPoints = nil
		end
		if not GameState.TyphonDefeatedWithStormStop then
			GameState.Resources.MixerMythic = nil
			GameState.LifetimeResourcesGained.MixerMythic = nil
		end

		if GameState.WorldUpgradesAdded.WorldUpgradePostBossSellTraitShops and not GameState.WorldUpgradesAdded.WorldUpgradeRestoreSellTraitShop then
			UnlockWorldUpgrade( "WorldUpgradeRestoreSellTraitShop" )
		end

		if not GameState.PatchedCosmeticRefunds then
			PatchCosmeticRefunds()
			GameState.PatchedCosmeticRefunds = true
		end

		if not GameState.PatchedPostGigarosMixerIBoss then
			if GameState.TextLinesRecord.ZagreusPastMeeting05 and not GameState.TextLinesRecord.ZagreusPastMeeting04_3 and not GameState.WorldUpgradesAdded.WorldUpgradeTimeStop then
				local amountNeededForIncantations = WorldUpgradeData.WorldUpgradeTimeStop.Cost.MixerIBoss
				if not GameState.WorldUpgradesAdded.WorldUpgradeStormStop then
					amountNeededForIncantations = amountNeededForIncantations + WorldUpgradeData.WorldUpgradeStormStop.Cost.MixerIBoss
				end
				if amountNeededForIncantations > GameState.Resources.MixerIBoss then
					AddResource( "MixerIBoss", amountNeededForIncantations - GameState.Resources.MixerIBoss, "Patch", { Silent = true, SkipVoiceLines = true, SkipInventoryObjective = true } )
				end
			end
			GameState.PatchedPostGigarosMixerIBoss = true
		end

		if GameState.TextLinesRecord.ZagreusPastMeeting06_B then
			GameState.TextLinesRecord.ZagreusPastMeeting06 = true
		end

		if GameState.StoryResetCount > 0 and GameState.WorldUpgradesRevealed.WorldUpgradeAmbrosia then
			GameState.TextLinesRecord.DemeterPalacePostTrueEnding01 = true
		end

		if not GameState.ReachedTrueEnding and GameState.SpeechRecord["/VO/Chronos_1058"] then
			GameState.SpeechRecord["/VO/Chronos_1058"] = nil
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
			RoomInit( room )
		end
		CurrentRun.SpellCharge = CurrentRun.SpellCharge or 5000
		CurrentRun.BiomeStateChangeCount = CurrentRun.BiomeStateChangeCount or 0

		if CurrentRun.CurrentRoom ~= nil then
			RoomInit( CurrentRun.CurrentRoom )
			
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

			DebugAssert({ Condition = RoomData[CurrentRun.CurrentRoom.Name] ~= nil, Text = "Missing Room: "..tostring(CurrentRun.CurrentRoom.Name) })

			CurrentRun.CurrentRoom.StoreDataName = CurrentRun.CurrentRoom.StoreDataName or RoomData[CurrentRun.CurrentRoom.Name].StoreDataName

			CurrentRun.CurrentRoom.SpawnRewardOnId = RoomData[CurrentRun.CurrentRoom.Name].SpawnRewardOnId
			CurrentRun.CurrentRoom.ZeusManaSpawnPoints = RoomData[CurrentRun.CurrentRoom.Name].ZeusManaSpawnPoints
			CurrentRun.CurrentRoom.SkipUnusedWeaponBonusReward = RoomData[CurrentRun.CurrentRoom.Name].SkipUnusedWeaponBonusReward
			CurrentRun.CurrentRoom.SkipTimedDropResources = RoomData[CurrentRun.CurrentRoom.Name].SkipTimedDropResources
			CurrentRun.CurrentRoom.DisableRewardMagnetisim = RoomData[CurrentRun.CurrentRoom.Name].DisableRewardMagnetisim
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
			CurrentRun.CurrentRoom.IgnoreEncounterUses = RoomData[CurrentRun.CurrentRoom.Name].IgnoreEncounterUses
			CurrentRun.CurrentRoom.SkipRoomsPerUpgrade = RoomData[CurrentRun.CurrentRoom.Name].SkipRoomsPerUpgrade
			CurrentRun.CurrentRoom.CauseOfDeathDisplayData = RoomData[CurrentRun.CurrentRoom.Name].CauseOfDeathDisplayData
			
			CurrentRun.CurrentRoom.LockExtraExitsWithEncounter = RoomData[CurrentRun.CurrentRoom.Name].LockExtraExitsWithEncounter
			CurrentRun.CurrentRoom.ZagContractRewardDestinationId = RoomData[CurrentRun.CurrentRoom.Name].ZagContractRewardDestinationId

			CurrentRun.CurrentRoom.ObstacleData = DeepCopyTable(RoomData[CurrentRun.CurrentRoom.Name].ObstacleData)
			CurrentRun.CurrentRoom.WrappingData = DeepCopyTable(RoomData[CurrentRun.CurrentRoom.Name].WrappingData)

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

			if CurrentRun.CurrentRoom.ChosenExorcismPointData ~= nil and CurrentRun.CurrentRoom.ChosenExorcismPointData.Animation == "ExorcismPointGhost" then
				CurrentRun.CurrentRoom.ChosenExorcismPointData = nil
			end


			if CurrentRun.CurrentRoom.ChosenPickaxePointData ~= nil and CurrentRun.CurrentRoom.ChosenPickaxePointData.Geometry == nil then
				for k, option in pairs( PickaxePointData.WeightedOptions ) do
					if option.ResourceName == CurrentRun.CurrentRoom.ChosenPickaxePointData.ResourceName and option.Geometry ~= nil then
						CurrentRun.CurrentRoom.ChosenPickaxePointData.Geometry = option.Geometry
					end					
				end			
			end

			-- Removing PlantMoney invalidated stored indices, so reroll the harvest points
			if Revision <= 107534 then
				CurrentRun.CurrentRoom.HarvestPointChoicesOptions = {}
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
		CurrentRun.ExorcisedNames.ExorcismPointGhost = nil
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
			CurrentRun.Hero.ManaRegenSources = CurrentRun.Hero.ManaRegenSources or {}
			CurrentRun.Hero.Ammo = CurrentRun.Hero.Ammo or {}
			CurrentRun.Hero.WeaponDataOverride = CurrentRun.Hero.WeaponDataOverride or {}
			CurrentRun.Hero.HeroTraitValuesCache = CurrentRun.Hero.HeroTraitValuesCache or {}
			CurrentRun.Hero.FirstTraitWithPropertyCache = CurrentRun.Hero.FirstTraitWithPropertyCache or {}
			CurrentRun.Hero.ManaDrain = {}
			CurrentRun.Hero.AnimOffsetZ = HeroData.AnimOffsetZ
			CurrentRun.Hero.LineHistoryName = CurrentRun.Hero.LineHistoryName or HeroData.LineHistoryName
			CurrentRun.Hero.Outline = CurrentRun.Hero.Outline or HeroData.Outline
			CurrentRun.Hero.SpeakingStatusAnimation = CurrentRun.Hero.SpeakingStatusAnimation or HeroData.SpeakingStatusAnimation

			CurrentRun.Hero.VisibleTraitCount = CurrentRun.Hero.VisibleTraitCount or 0
			CurrentRun.Hero.TraitDictionary = CurrentRun.Hero.TraitDictionary or {}

			CurrentRun.Hero.Speaker = CurrentRun.Hero.Speaker or HeroData.Speaker
			CurrentRun.Hero.Portrait = CurrentRun.Hero.Portrait or HeroData.Portrait
			CurrentRun.Hero.EmoteOffsetX = CurrentRun.Hero.EmoteOffsetX or HeroData.EmoteOffsetX
			CurrentRun.Hero.EmoteOffsetY = CurrentRun.Hero.EmoteOffsetY or HeroData.EmoteOffsetY
			CurrentRun.Hero.LastStandTimeMultiplier = nil
			
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

			if CurrentRun.Hero.SlottedSpell and CurrentRun.Hero.SlottedSpell.Talents then
				if not SpellData[CurrentRun.Hero.SlottedSpell.Name] then
					CurrentRun.Hero.SlottedSpell = nil
				else
					for _, columnData in ipairs( CurrentRun.Hero.SlottedSpell.Talents ) do
						for i, data in pairs( columnData ) do
							if not TraitData[data.Name] then
								data.Name = GetRandomValue( SpellData[CurrentRun.Hero.SlottedSpell.Name].Talents.Repeatable )
							end
						end
					end
				end
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
				if weaponDataOverride.WeaponCast and Revision <= 105535 then
					weaponDataOverride.WeaponCast.OnChargeCancelFunctionName = nil
					weaponDataOverride.WeaponCast.OnChargeFunctionName = nil
				end
			end

			CurrentRun.Hero.DashManeuverTimeThreshold = CurrentRun.Hero.DashManeuverTimeThreshold or HeroData.DashManeuverTimeThreshold
			CurrentRun.Hero.InvulnerableFrameMinDamage = CurrentRun.Hero.InvulnerableFrameMinDamage or HeroData.InvulnerableFrameMinDamage
			CurrentRun.Hero.StackData.AllowRarityOverride  = HeroData.StackData.AllowRarityOverride

			if CurrentRun.Hero.ManaRegenSources ~= nil then
				for key in pairs( CurrentRun.Hero.ManaRegenSources ) do
					if not CurrentRun.Hero.ManaRegenSources[key] or type(CurrentRun.Hero.ManaRegenSources[key]) ~= "table" then
						CurrentRun.Hero.ManaRegenSources[key] = { Value = CurrentRun.Hero.ManaRegenSources[key] or 0 }
					end
				end
			end
			if not IsEmpty( CurrentRun.Hero.LastStands ) then
				local priorityLastStand = nil
				for i, lastStand in ipairs( CurrentRun.Hero.LastStands ) do
					if i ~= #CurrentRun.Hero.LastStands and (lastStand.Priority or lastStand.Name == "Athena") then
						priorityLastStand = lastStand
					end
				end
				if priorityLastStand then
					RemoveValueAndCollapse( CurrentRun.Hero.LastStands, priorityLastStand )
					table.insert( CurrentRun.Hero.LastStands, priorityLastStand )
				end
			end
			if CurrentRun.Hero.IsDead and CurrentRun.ActiveBiomeTimer then
				CurrentRun.ActiveBiomeTimer = false
			end
			if CurrentRun.Hero.OutgoingCritModifiers then
				local condemnedIds = {}
				for i, modifierData in ipairs( CurrentRun.Hero.OutgoingCritModifiers ) do
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
					CurrentRun.Hero.OutgoingCritModifiers = CollapseTable( CurrentRun.Hero.OutgoingCritModifiers )
				end
			end
			if CurrentRun.Hero.OutgoingDamageModifiers then
				local condemnedIds = {}
				for i, modifierData in ipairs( CurrentRun.Hero.OutgoingDamageModifiers ) do
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
					CurrentRun.Hero.OutgoingDamageModifiers = CollapseTable( CurrentRun.Hero.OutgoingDamageModifiers )
				end
			end
			if CurrentRun.Hero.IncomingDamageModifiers ~= nil then
				local condemnedIds = {}
				for i, modifierData in ipairs( CurrentRun.Hero.IncomingDamageModifiers ) do
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

			local traitsToAdd = {}
			local traitsToRemove = {}
			SessionState.PatchingTraits = true

			MapState = MapState or {}
			MapState.EquippedWeapons = {}
			MapState.WeaponCharge = {}
			MapState.TemporaryHealthBufferSources = MapState.TemporaryHealthBufferSources or {}
			if TableLength( CurrentRun.Hero.Traits ) ~= #CurrentRun.Hero.Traits then
				CurrentRun.Hero.Traits = CollapseTable( CurrentRun.Hero.Traits )
			end

			for i, trait in ipairs( CurrentRun.Hero.Traits ) do
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
				if trait.DoorHealReserve then
					trait.DoorHealReserve = round( trait.DoorHealReserve )
				end
				local addTraitToUpdate = function ( trait )
					if trait.OnExpire then
						trait.OnExpire = nil
						IncrementTableValue( traitsToRemove, trait.Name )
					elseif not traitsToRemove[trait.Name] then
						traitsToAdd[trait.Name] = { Rarity = trait.Rarity or "Common", StackCount = trait.StackNum or 1 }
					end

				end
				local traitData = TraitData[trait.Name]
				if TraitData[trait.Name] and trait.Icon ~= TraitData[trait.Name].Icon then
					trait.Icon = TraitData[trait.Name].Icon 
				end
				if traitData == nil then
					traitsToAdd[trait.Name] = nil
					IncrementTableValue(traitsToRemove, trait.Name)
				elseif TableLength(trait.PropertyChanges, true) ~= TableLength(TraitData[trait.Name].PropertyChanges, true) or
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
				elseif trait.Name == "StaffClearCastAspect" and Revision <= 113307 then
					addTraitToUpdate( trait )
				elseif trait.Name == "SuitComboAspect" and Revision <= 123655 then
					addTraitToUpdate( trait )
				elseif trait.Name == "PoseidonSprintBoon" and Revision <= 109231 then
					addTraitToUpdate( trait )
				elseif trait.Name == "PoseidonWeaponBoon" and Revision <= 121817 then
					addTraitToUpdate( trait )
				elseif trait.Name == "SupportingFireBoon" and Revision <= 125940 then
					addTraitToUpdate( trait )
				elseif trait.Name == "PoseidonManaBoon" and Revision <= 121402 then
					addTraitToUpdate( trait )
				elseif trait.Name == "LobCloseAttackAspect" and Revision <= 113005 then
					traitsToAdd[trait.Name] = { Rarity = trait.Rarity or "Common", StackCount = trait.StackNum or 1 }
				elseif trait.Name == "StaffSelfHitAspect" and Revision <= 95285 then
					traitsToAdd[trait.Name] = { Rarity = trait.Rarity or "Common", StackCount = trait.StackNum or 1 }
				elseif trait.Name == "HeraSpecialBoon" and Revision <= 113544 then
					addTraitToUpdate( trait )
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
				elseif trait.Name == "DodgeFamiliar" and Revision <= 108751 then
					addTraitToUpdate( trait )
				elseif trait.Name == "TimeSlowDemeterTalent" and Revision <= 123498 then
					addTraitToUpdate( trait )
				elseif trait.Name == "SpawnDamageCurse" and Revision <= 111100 then
					addTraitToUpdate( trait )
				elseif trait.Name == "SummonDamageSplitTalent" and Revision <= 121907 then
					addTraitToUpdate( trait )
				elseif trait.Name == "CirceEnlargeTrait" and Revision <= 116074 then
					addTraitToUpdate( trait )
				elseif trait.Name == "CirceShrinkTrait" and Revision <= 116074 then
					addTraitToUpdate( trait )
				elseif trait.Name == "LobGunAspect" and Revision <= 118920 then
					addTraitToUpdate( trait )
				elseif trait.Name == "SpawnKillBoon" and Revision <= 124923 then
					addTraitToUpdate( trait )
				elseif trait.Name == "DoubleExManaBoon" and Revision <= 123614 then
					addTraitToUpdate( trait )
				elseif trait.Name == "ChaosSpeedBlessing" and Revision <= 132769 then
					addTraitToUpdate( trait )
				elseif trait.Name == "ChaosExSpeedBlessing" and Revision <= 132769 then
					addTraitToUpdate( trait )
				elseif trait.Name == "PotionPoseidonTalent" and Revision <= 122512 then
					addTraitToUpdate( trait )
				elseif trait.Name == "ChaosManaFocusCurse" and trait.OnExpire and not trait.OnExpire.RemoveReservedMana then
					trait.OnExpire.RemoveReservedMana = TraitData[trait.Name].OnExpire.RemoveReservedMana
				elseif trait.Name == "ChaosCommonCurse" and trait.OnExpire and not trait.OnExpire.RecheckBoons then
					trait.OnExpire.RecheckBoons = TraitData[trait.Name].OnExpire.RecheckBoons
				elseif trait.Name == "UnusedWeaponBonusTrait2" and trait.BossEncounterEndFunctionName ~= nil then
					addTraitToUpdate( trait )
				elseif trait.Name == "DemeterSprintBoon" and trait.OnWeaponFiredFunctions and trait.OnWeaponFiredFunctions.FunctionArgs and IsEmpty( trait.OnWeaponFiredFunctions.FunctionArgs.ProjectileNames ) then
					addTraitToUpdate( trait )
				elseif trait.SetupFunction ~= nil and traitData.SetupFunction == nil then
					addTraitToUpdate( trait )
				else
					for key, data in pairs (TraitData[trait.Name]) do
						if trait[key] == nil and not PatchIgnoreTraitKeys[key] then
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
					if trait.RoomsPerUpgrade and trait.RoomsPerUpgrade.Rarity then
						local traitCount = 0
							for _, targetTrait in pairs( CurrentRun.Hero.Traits ) do
							if GetUpgradedRarity(targetTrait.Rarity) ~= nil and targetTrait.RarityLevels ~= nil and targetTrait.RarityLevels[GetUpgradedRarity(targetTrait.Rarity)] ~= nil then
								traitCount = traitCount + 1
							end
						end
					end
				end

				if trait.AddOutgoingDamageModifiers and trait.AddOutgoingDamageModifiers.ValidWeapons and not trait.AddOutgoingDamageModifiers.ValidWeaponsLookup then
					addTraitToUpdate( trait )
				end

				if trait.FamiliarTrait and GameState.EquippedFamiliar ~= nil and Revision <= 107666 then
					for _, familiarTraitName in ipairs( FamiliarData[GameState.EquippedFamiliar].TraitNames ) do
						addTraitToUpdate( { Name = familiarTraitName, StackNum = GetFamiliarTraitStacks( familiarTraitName ) } )
					end
				end

				if trait.PrePickSacrificeBoon and not trait.SacrificedTraitName then
					trait.SacrificedTraitName = "None_In_Slot"
				end
				
				if not traitsToRemove[trait.Name] and not traitsToAdd[trait.Name] then			
					ExtractValues( CurrentRun.Hero, trait, trait )
				end

				if trait.OnWeaponFiredFunctions and trait.OnWeaponFiredFunctions.ValidWeapons and not trait.OnWeaponFiredFunctions.ValidWeaponsLookup then
					addTraitToUpdate( trait )
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
				local trait = AddTraitToHero({ TraitName = traitName, Rarity = trait.Rarity, StackNum = trait.StackCount, SkipActivatedTraitUpdate = true, FromLoot = traitData.FromLootOnUpdate })
				if trait.MergeTooltipDataFromSession then
					trait.StatLines = {}
					trait.TrayStatLines = {}
				end
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
			
			CurrentRun.Hero.HealthBuffer = 0

			ValidateMaxHealth()
			ValidateMaxMana()
			UpdateTalentPointInvestedCache()
			
			SessionState.PatchingTraits = false
			CurrentRun.Hero.TargetMetaRewardsRatio = CurrentRun.Hero.TargetMetaRewardsRatio or HeroData.TargetMetaRewardsRatio
			CurrentRun.Hero.TargetMetaRewardsAdjustSpeed = CurrentRun.Hero.TargetMetaRewardsAdjustSpeed or HeroData.TargetMetaRewardsAdjustSpeed
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

			if CurrentRun.CurrentRoom.Encounter.Name == "O_Empty" then
				CurrentRun.CurrentRoom.Encounter.StartRoomUnthreadedEvents = nil
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

		if CurrentRun.EndingKeepsakeName ~= nil then
			table.insert( CurrentRun.KeepsakeCache, CurrentRun.EndingKeepsakeName )
			CurrentRun.EndingKeepsakeName = nil
		end

		if CurrentRun.BiomeBoonSkips ~= nil then
			local room = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
			local roomSetName = room.RoomSetName
			if roomSetName == "N_SubRooms" then
				roomSetName = "N"
			elseif room.UsePreviousRoomSet then
				local previousRoom = GetPreviousRoom( CurrentRun ) or room
				roomSetName = previousRoom.RoomSetName
			end
			CurrentRun.BiomeBoonSkipCount = CurrentRun.BiomeBoonSkips[roomSetName] or 0
			CurrentRun.BiomeBoonSkips = nil
		end

		if CurrentRun.Cleared and CurrentRun.CurrentRoom.RoomSetName == "P" then
			CurrentRun.Cleared = nil
		end

		if CurrentRun.BountiesCompleted ~= nil then
			for bountyName,v in pairs( CurrentRun.BountiesCompleted ) do
				local bountyData = BountyData[bountyName]
				if bountyData ~= nil and not bountyData.IsPackagedBounty then
					CurrentRun.ShrineBountiesCompleted[bountyName] = true
				end
			end
			CurrentRun.BountiesCompleted = nil
		end

		if CurrentRun.BossHealthBarRecord.BossScylla01 ~= nil then
			CurrentRun.BossHealthBarRecord.Scylla = CurrentRun.BossHealthBarRecord.BossScylla01
			CurrentRun.BossHealthBarRecord.BossScylla01 = nil
		elseif CurrentRun.BossHealthBarRecord.BossScylla02 ~= nil then
			CurrentRun.BossHealthBarRecord.Scylla = CurrentRun.BossHealthBarRecord.BossScylla02
			CurrentRun.BossHealthBarRecord.BossScylla02 = nil
		end

		if CurrentRun.ArtemisSingingInHub then
			CurrentRun.ArtemisHubSong = "/Music/ArtemisSong_MC"
			CurrentRun.ArtemisSingingInHub = nil
		end

		if CurrentRun.TextLinesRecord.ZagreusPastMeeting06_B then
			CurrentRun.TextLinesRecord.ZagreusPastMeeting06 = true
		end

		if CurrentRun.LootTypeHistory ~= nil and not CurrentRun.Hero.IsDead then
			for lootName, i in pairs( CurrentRun.LootTypeHistory ) do
				if not GameData.MissingPackages[lootName] then
					LoadPackages({ Name = lootName })
				end
			end
		end
		local traitPackageNames = {}
		for i, trait in ipairs( CurrentRun.Hero.Traits ) do
			local traitData = TraitData[trait.Name]
			if traitData ~= nil and traitData.PackageName ~= nil and not GameData.MissingPackages[traitData.PackageName] then
				traitPackageNames[traitData.PackageName] = true
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
		"AthenaLandingNova",
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

function PatchCosmeticRefunds()
	local originalCosts =
	{
		Cosmetic_AmbientCats = 1050,
		Cosmetic_AmbientDogs = 1450,
		Cosmetic_AmbientFrogs = 350,
		Cosmetic_ApolloLyre = 1350,
		Cosmetic_Aquarium = 900,
		Cosmetic_ArachneTapestry = 1200,
		Cosmetic_ArtemisAmaranthus = 500,
		Cosmetic_ArtemisFlowerCircle01 = 200,
		Cosmetic_ArtemisFlowerCircle01a = 250,
		Cosmetic_ArtemisFlowerCircle01b = 350,
		Cosmetic_ArtemisLyre = 450,
		Cosmetic_ArtemisTarget = 400,
		Cosmetic_BathChangingScreens = 200,
		Cosmetic_BathSoaps = 350,
		Cosmetic_BathTowelRacks = 250,
		Cosmetic_BirdHouse = 1300,
		Cosmetic_BrokerLantern01 = 170,
		Cosmetic_BrokerWagon01 = 1600,
		Cosmetic_BrokerWagon02 = 1800,
		Cosmetic_CardDeck01 = 500,
		Cosmetic_CardDeck02 = 900,
		Cosmetic_CardDeck03 = 1100,
		Cosmetic_CardDeck04 = 1400,
		Cosmetic_CardDeck05 = 1600,
		Cosmetic_CardDeck06 = 1800,
		Cosmetic_CardDeck07 = 2200,
		Cosmetic_CatScratcher = 1300,
		Cosmetic_Cauldron01a = 3200,
		Cosmetic_Cauldron01b = 3400,
		Cosmetic_CauldronPillars01a = 600,
		Cosmetic_CauldronPillars01b = 650,
		Cosmetic_CauldronPillars01c = 700,
		Cosmetic_CauldronRing01a = 500,
		Cosmetic_CauldronRing01b = 550,
		Cosmetic_ChronosHourglass = 1900,
		Cosmetic_EmployeeOfTheMonth = 650,
		Cosmetic_ErisJerkyShelf = 250,
		Cosmetic_ErisTrashcan = 400,
		Cosmetic_ErisWarningSign01 = 950,
		Cosmetic_ExitCharm = 900,
		Cosmetic_ExitCharm02 = 900,
		Cosmetic_ExitCharm03 = 900,
		Cosmetic_ExitCharm04 = 900,
		Cosmetic_ExitCharm05 = 900,
		Cosmetic_FallenLeaves01 = 250,
		Cosmetic_FallenLeaves02 = 300,
		Cosmetic_FamiliarEffigy01 = 850,
		Cosmetic_FamiliarEffigy01a = 850,
		Cosmetic_FamiliarEffigy01b = 850,
		Cosmetic_FanPoster01 = 550,
		Cosmetic_FanPoster01a = 600,
		Cosmetic_FanPoster01b = 650,
		Cosmetic_FarmBench01 = 180,
		Cosmetic_FarmGardenTools01 = 150,
		Cosmetic_FarmPillars01 = 450,
		Cosmetic_FarmWell01 = 850,
		Cosmetic_FishingSign01 = 750,
		Cosmetic_FishingSign01a = 750,
		Cosmetic_FishingSign01b = 750,
		Cosmetic_FrinosRock01a = 600,
		Cosmetic_FrinosRock01b = 550,
		Cosmetic_HecateKey = 1050,
		Cosmetic_HermesShoes = 1450,
		Cosmetic_HypnosLanterns01a = 110,
		Cosmetic_HypnosLanterns01b = 150,
		Cosmetic_HypnosPedestal01a = 500,
		Cosmetic_HypnosPedestal01b = 500,
		Cosmetic_HypnosPillars01a = 650,
		Cosmetic_HypnosRug = 200,
		Cosmetic_IcarusBombs01 = 350,
		Cosmetic_IcarusMaps = 450,
		Cosmetic_IcarusRug01 = 150,
		Cosmetic_IcarusRug02 = 250,
		Cosmetic_IcarusTable01 = 800,
		Cosmetic_IcarusWings = 1650,
		Cosmetic_MainHangingRope01a = 450,
		Cosmetic_MainLanterns01a = 310,
		Cosmetic_MainLanterns01b = 330,
		Cosmetic_MainTeaLights = 1600,
		Cosmetic_MorosChaise = 600,
		Cosmetic_MorosRug = 350,
		Cosmetic_MorosScrolls = 650,
		Cosmetic_MorosSpools = 1100,
		Cosmetic_MorosTentCanopy = 550,
		Cosmetic_MorosTerrain = 180,
		Cosmetic_NemesisBraziers = 800,
		Cosmetic_NemesisChair = 700,
		Cosmetic_NemesisGrindstone = 500,
		Cosmetic_NemesisRug = 400,
		Cosmetic_NemesisScales = 850,
		Cosmetic_OdysseusRug = 160,
		Cosmetic_OdysseusRug02 = 190,
		Cosmetic_OdysseusTable01a = 1000,
		Cosmetic_OdysseusTrojanHorse = 1950,
		Cosmetic_OdysseusVase = 550,
		Cosmetic_PandoraJar = 1450,
		Cosmetic_RespawnCircleFlowers = 750,
		Cosmetic_RiverLanterns = 350,
		Cosmetic_RiverLanterns02 = 370,
		Cosmetic_SkellyFloor01a = 220,
		Cosmetic_SkellyFloor01b = 240,
		Cosmetic_SkellyZagreusStatue = 2200,
		Cosmetic_TavernaCauldron02 = 400,
		Cosmetic_TavernaChairs01a = 220,
		Cosmetic_TavernaChairs01b = 260,
		Cosmetic_TavernaChairs01c = 280,
		Cosmetic_TavernaMusicStage01 = 300,
		Cosmetic_TavernaMusicStage02 = 400,
		Cosmetic_TavernaShrimpCocktails = 150,
		Cosmetic_TavernaStarMosaic = 1500,
		Cosmetic_TavernaTables01a = 1200,
		Cosmetic_TavernaTables01b = 1400,
		Cosmetic_TavernaTables01c = 1250,
		Cosmetic_TentBlanket01b = 160,
		Cosmetic_TentBlanket01c = 180,
		Cosmetic_TentCandle01b = 140,
		Cosmetic_TentQuilt = 110,
		Cosmetic_TentShelf01a = 400,
		Cosmetic_TentShelf01b = 650,
		Cosmetic_TentTable01b = 390,
		Cosmetic_TentTable01c = 410,
		Cosmetic_ThanPoster = 1100,
		Cosmetic_TrainingDummy01a = 2000,
		Cosmetic_TrainingDummy01b = 1850,
		Cosmetic_WitchTrinkets02 = 110,
		Song_ArachneTheme = 250,
		Song_ArtemisSong = 500,
		Song_ArtemisTheme = 300,
		Song_BiomeStartOlympus = 800,
		Song_CharonShopTheme = 150,
		Song_CirceTheme = 250,
		Song_ClockworkTartarusMiniboss = 400,
		Song_ClockworkTartarusRegular = 400,
		Song_DionysusMusic = 700,
		Song_EchoTheme = 250,
		Song_EndThemeAcoustic = 600,
		Song_Ephyra2 = 500,
		Song_Ephyra3 = 500,
		Song_Erebus2 = 350,
		Song_Exploration1 = 350,
		Song_Exploration2 = 350,
		Song_FilthyArp = 500,
		Song_FishingMusicLoop = 200,
		Song_HeraclesTheme = 250,
		Song_HypnosMusic = 700,
		Song_IcarusTheme = 250,
		Song_MedeaTheme = 250,
		Song_MinibossTheme = 200,
		Song_MourningFields1 = 300,
		Song_MourningFields2 = 300,
		Song_NarcissusTheme = 250,
		Song_NemesisTheme = 250,
		Song_Olympus1 = 800,
		Song_Olympus2 = 800,
		Song_Scylla1a = 150,
		Song_Scylla1b = 550,
		Song_Scylla2a = 150,
		Song_Scylla2b = 550,
		Song_Scylla3a = 350,
		Song_Scylla3b = 850,
		Song_Scylla4a = 350,
		Song_Scylla4b = 850,
		Song_Ships1 = 400,
		Song_Ships2 = 400,
		Song_TimedEncounter = 200,
	}

	local amountOwed = 0
	for cosmeticName, originalCost in pairs( originalCosts ) do
		if GameState.WorldUpgradesAdded[cosmeticName] and WorldUpgradeData[cosmeticName] ~= nil then
			local currentCost = WorldUpgradeData[cosmeticName].Cost.CosmeticsPoints or 0
			if currentCost < originalCost then
				amountOwed = amountOwed + (originalCost - currentCost)
				--DebugPrint({ Text = "Owed "..(originalCost - currentCost).." for "..cosmeticName })
			end
		end
	end

	AddResource( "CosmeticsPoints", amountOwed, "Patch", { Silent = true, SkipVoiceLines = true, SkipInventoryObjective = true } )

end
