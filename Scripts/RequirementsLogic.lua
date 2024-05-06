Import "RequirementsData.lua"

function IsGameStateEligible( currentRun, source, requirements, args )

	args = args or {}

	if source == nil then
		args.FirstFailedRequirement = "MissingSource"
		return false
	end

	if requirements == nil then
		requirements = source
	end

	if IsEmpty( requirements ) then
		return true
	end

	if requirements.Skip then
		args.FirstFailedRequirement = "Skip"
		return false
	end

	if requirements.Force then
		return true
	end

	if SessionMapState ~= nil then
		SessionMapState.RequirementChecksThisFrame = SessionMapState.RequirementChecksThisFrame + 1
	end

	if requirements.ChanceToPlay ~= nil then
		if not RandomChance( requirements.ChanceToPlay ) then
			args.FirstFailedRequirement = "ChanceToPlay = "..requirements.ChanceToPlay
			return false
		end
	end

	if requirements.NamedRequirements ~= nil then
		for k, name in ipairs( requirements.NamedRequirements ) do
			DebugAssert({ Condition = NamedRequirementsData[name] ~= nil, Text = name.." is not a named requirement.", Owner = "Greg", })
			if not IsGameStateEligible( currentRun, source, NamedRequirementsData[name], args ) then
				return false
			end
		end
	end
	if requirements.NamedRequirementsFalse ~= nil then
		for k, name in ipairs( requirements.NamedRequirementsFalse ) do
			DebugAssert({ Condition = NamedRequirementsData[name] ~= nil, Text = name.." is not a named requirement.", Owner = "Greg", })
			if IsGameStateEligible( currentRun, source, NamedRequirementsData[name], args ) then
				return false
			end
		end
	end

	-- Hard-coded Checks

	local currentRunDepth = 0
	if currentRun.RunDepthCache ~= nil then
		currentRunDepth = currentRun.RunDepthCache
	end

	local currentBiomeDepth = 0
	if currentRun.BiomeDepthCache ~= nil then
		currentBiomeDepth = currentRun.BiomeDepthCache
	end

	if requirements.RequiredTextLines ~= nil then
		for k, textLineSet in pairs( requirements.RequiredTextLines ) do
			if GameState.TextLinesRecord[textLineSet] == nil then
				return false
			end
		end
	end

	if requirements.RequiredMinAnyTextLines ~= nil then
		local numTrue = 0
		for k, textLineSet in pairs( requirements.RequiredMinAnyTextLines.TextLines ) do
			if GameState.TextLinesRecord[textLineSet] then
				numTrue = numTrue + 1
			end
		end
		if numTrue < requirements.RequiredMinAnyTextLines.Count then
			return false
		end
	end

	if requirements.RequiredFalseTextLines ~= nil then
		for k, textLineSet in pairs( requirements.RequiredFalseTextLines ) do
			if GameState.TextLinesRecord[textLineSet] ~= nil then
				return false
			end
		end
	end

	if requirements.RequiredQueuedTextLines ~= nil then
		local anyTrue = false
		for unitId, unit in pairs( ActiveEnemies ) do
			if unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == requirements.RequiredQueuedTextLines then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end
	if requirements.RequiredAnyQueuedTextLines ~= nil then
		local anyTrue = false
		for unitId, unit in pairs( ActiveEnemies ) do
			for k, textLineSet in pairs( requirements.RequiredAnyQueuedTextLines ) do
				if unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == textLineSet then
					anyTrue = true
					break
				end
			end
		end
		if not anyTrue then
			return false
		end
	end
	if requirements.RequiredFalseQueuedTextLines ~= nil then
		for unitId, unit in pairs( ActiveEnemies ) do
			for k, textLineSet in pairs( requirements.RequiredFalseQueuedTextLines ) do
				if unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == textLineSet then
					return false
				end
			end
		end
	end

	local prevRun = GameState.RunHistory[#GameState.RunHistory]

	if requirements.RequiredWeapon ~= nil and not CurrentRun.Hero.Weapons[requirements.RequiredWeapon] then
		return false
	end

	if requirements.ConsecutiveDeathsInRoom ~= nil then
		local consecutiveDeathsInRoom = 0
		if HasSeenRoomEarlierInRun( currentRun, requirements.ConsecutiveDeathsInRoom.Name ) then
			if not currentRun.Cleared and currentRun.EndingRoomName == requirements.ConsecutiveDeathsInRoom.Name then
				-- Saw the room this run and died in it, streak continues
				consecutiveDeathsInRoom = consecutiveDeathsInRoom + 1
			else
				-- Saw the room this run and didn't die in it, streak is 0
				return false
			end
		end
		for i = #GameState.RunHistory, 1 , -1 do
			local run = GameState.RunHistory[i]
			if HasSeenRoomInRun( run, requirements.ConsecutiveDeathsInRoom.Name ) then
				if not run.Cleared and run.EndingRoomName == requirements.ConsecutiveDeathsInRoom.Name then
					-- Saw the room this run and died in it, streak continues
					consecutiveDeathsInRoom = consecutiveDeathsInRoom + 1
				else
					-- Saw the room this run and didn't die, streak is broken
					break
				end
			end
		end

		if consecutiveDeathsInRoom < requirements.ConsecutiveDeathsInRoom.Count then
			return false
		end
	end

	if requirements.ConsecutiveClearsOfRoom ~= nil then
		local consecutiveClearsOfRoom = 0
		if HasSeenRoomEarlierInRun( currentRun, requirements.ConsecutiveClearsOfRoom.Name ) then
			if currentRun.Cleared or currentRun.EndingRoomName ~= requirements.ConsecutiveClearsOfRoom.Name then
				-- Saw the room this run and didn't die in it, streak continues
				consecutiveClearsOfRoom = consecutiveClearsOfRoom + 1
			else
				-- Saw the room this run and died in it, streak is 0
				return false
			end
		end
		for i = #GameState.RunHistory, 1 , -1 do
			local run = GameState.RunHistory[i]
			if HasSeenRoomInRun( run, requirements.ConsecutiveClearsOfRoom.Name ) then
				if run.Cleared or run.EndingRoomName ~= requirements.ConsecutiveClearsOfRoom.Name then
					-- Saw the room this run and didn't die in it, streak continues
					consecutiveClearsOfRoom = consecutiveClearsOfRoom + 1
				else
					-- Saw the room this run and died in it, streak is broken
					break
				end
			end
		end
		if consecutiveClearsOfRoom < requirements.ConsecutiveClearsOfRoom.Count then
			return false
		end
	end

	if requirements.RequiredFalseSeenRoomsThisRun ~= nil then
		for k, roomName in pairs(requirements.RequiredFalseSeenRoomsThisRun) do
			if HasSeenRoomInRun( currentRun, roomName ) then
				return false
			end
		end
	end

	if requirements.RequiredSlottedTrait ~= nil then
		local hasSlot = false
		for i, traitData in pairs(CurrentRun.Hero.Traits ) do
			if traitData.Slot == requirements.RequiredSlottedTrait then
				hasSlot = true
				break
			end
			if traitData.AltSlot and traitData.AltSlot == requirements.RequiredSlottedTrait then
				hasSlot = true
				break
			end
		end

		if not hasSlot then
			return false
		end
	end

	if requirements.RequireSpell ~= nil then
		if requirements.RequireSpell == "Any" and not CurrentRun.Hero.SlottedSpell then
			return false
		elseif not SpellData[requirements.RequireSpell] then
			return false
		elseif SpellData[requirements.RequireSpell] and not HeroHasTrait( SpellData[requirements.RequireSpell].TraitName) then
			return false
		end
	end

	if requirements.RequireSpellCharged ~= nil then
		if not CurrentRun.Hero.SlottedSpell then
			return false
		elseif not SpellData[requirements.RequireSpellCharged] then
			return false
		elseif SpellData[requirements.RequireSpellCharged] and not HeroHasTrait( SpellData[requirements.RequireSpellCharged].TraitName) then
			return false
		end
		local trait = GetHeroTrait( SpellData[requirements.RequireSpellCharged].TraitName )
		local weaponData = GetWeaponData( CurrentRun.Hero, trait.PreEquipWeapons[1] )
		if CurrentRun.SpellCharge < GetManaSpendCost(weaponData) then
			return false
		end
	end

	if requirements.RequiredTrait ~= nil and ( not TraitData[requirements.RequiredTrait] or not HeroHasTrait( requirements.RequiredTrait )) then
		return false
	end

	if requirements.RequiredFalseTrait ~= nil and TraitData[requirements.RequiredFalseTrait] and HeroHasTrait( requirements.RequiredFalseTrait ) then
		return false
	end

	if requirements.RequiredFalseTraits ~= nil  then
		for i, traitName in pairs(requirements.RequiredFalseTraits) do
			if HeroHasTrait( traitName ) then
				return false
			end
		end
	end

	if requirements.RequiredTraitCount ~= nil and requirements.RequiredTraitCount > GetTotalTraitCount(CurrentRun.Hero) then
		return false
	end

	
	if requirements.RequiredRoom ~= nil then
		if currentRun.Hero.IsDead and CurrentHubRoom ~= nil then
			if CurrentHubRoom.Name ~= requirements.RequiredRoom then
				return false
			end
		elseif currentRun.CurrentRoom.Name ~= requirements.RequiredRoom then
			return false
		end
	end

	if requirements.RequiresInRun then
		if currentRun.Hero.IsDead then
			return false
		end
	end

	if requirements.RequiredMinExits ~= nil then
		if currentRun.CurrentRoom == nil then
			return false
		end
		local exitDoorsIPairs = CollapseTableOrdered( MapState.OfferedExitDoors )
		if #exitDoorsIPairs < requirements.RequiredMinExits then
			return false
		end
	end

	if requirements.RequiredMinOfferedRewardTypes ~= nil then
		local offeredTypes = {}
		if currentRun.CurrentRoom.OfferedRewards ~= nil then
			for k, offeredReward in pairs( currentRun.CurrentRoom.OfferedRewards ) do
				if offeredReward.Type ~= nil then
					offeredTypes[offeredReward.Type] = true
				end
			end
		end
		if TableLength( offeredTypes ) < requirements.RequiredMinOfferedRewardTypes then
			return false
		end
	end

	if requirements.RequiredFalseRooms ~= nil and currentRun.CurrentRoom ~= nil and Contains( requirements.RequiredFalseRooms, currentRun.CurrentRoom.Name ) then
		return false
	end

	if requirements.RequiredFalseEncounters ~= nil and Contains( requirements.RequiredFalseEncounters, currentRun.CurrentRoom.Encounter.Name ) then
		return false
	end

	if requirements.NotInCombat and IsCombatEncounterActive( currentRun ) then
		return false
	end

	if requirements.RequiredBiome ~= nil then
		if currentRun.CurrentRoom == nil or currentRun.CurrentRoom.RoomSetName ~= requirements.RequiredBiome then
			return false
		end
	end

	if requirements.RequiredBiomes ~= nil then
		if currentRun.CurrentRoom == nil or not Contains(requirements.RequiredBiomes, currentRun.CurrentRoom.RoomSetName ) then
			return false
		end
	end

	if requirements.RequiredCompletedRuns ~= nil and GetCompletedRuns() ~= requirements.RequiredCompletedRuns then
		return false
	end

	if requirements.RequiredMinCompletedRuns ~= nil and GetCompletedRuns() < requirements.RequiredMinCompletedRuns then
		return false
	end

	if requirements.RequiresLastRunCleared ~= nil and (prevRun == nil or not prevRun.Cleared) then
		return false
	end

	if requirements.RequiredMaxWeaponUpgrade ~= nil and requirements.RequiredMaxWeaponUpgradeIndex ~= nil then
		if not IsWeaponUpgradeMaxed( requirements.RequiredMaxWeaponUpgrade, requirements.RequiredMaxWeaponUpgradeIndex ) then
			return false
		end
	end

	if requirements.RequiredMinDepth ~= nil and currentRunDepth < requirements.RequiredMinDepth then
		return false
	end

	if requirements.RequiredMinBiomeDepth ~= nil and (currentBiomeDepth or 0) < requirements.RequiredMinBiomeDepth then
		return false
	end

	if requirements.RequiredPlayed ~= nil then
		for k, voiceLine in pairs( requirements.RequiredPlayed ) do
			if GameState.SpeechRecord[voiceLine] == nil then
				return false
			end
		end
	end
	if requirements.RequiredFalsePlayed ~= nil then
		for k, voiceLine in pairs( requirements.RequiredFalsePlayed ) do
			if GameState.SpeechRecord[voiceLine] ~= nil then
				return false
			end
		end
	end

	if requirements.RequiredFalsePlayedThisRun ~= nil then
		for k, voiceLine in pairs( requirements.RequiredFalsePlayedThisRun ) do
			if currentRun.SpeechRecord[voiceLine] then
				return false
			end
		end
	end

	if requirements.RequiredKillEnemiesNotFound ~= nil and not IsEmpty( RequiredKillEnemies ) then
		return false
	end

	if requirements.RequiredUnitAlive ~= nil then
		local unitId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = requirements.RequiredUnitAlive })
		if unitId <= 0 then
			return false
		end
	end
	if requirements.RequiredUnitsNotAlive ~= nil then
		for k, unit in pairs( requirements.RequiredUnitsNotAlive ) do
			local unitId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = unit })
			if unitId > 0 then
				return false
			end
		end
	end

	if requirements.RequiredMainWeapon ~= nil and not currentRun.Hero.Weapons[requirements.RequiredMainWeapon] then
		return false
	end

	if requirements.RequiredLootChoices ~= nil and requirements.RequiredLootChoices ~= CalcNumLootChoices() then
		return false
	end

	if requirements.RequiredKills ~= nil then
		for requiredKill, requiredKillCount in pairs( requirements.RequiredKills ) do
			if GameState.EnemyKills[requiredKill] == nil or GameState.EnemyKills[requiredKill] < requiredKillCount then
				return false
			end
		end
	end

	if requirements.RequiredBossPhase ~= nil and ActiveEnemies[CurrentRun.CurrentRoom.BossId] ~= nil then
		local boss = ActiveEnemies[CurrentRun.CurrentRoom.BossId]
		if boss.CurrentPhase ~= requirements.RequiredBossPhase then
			return false
		end
	end

	if requirements.RequiredMinMaximumLastStands ~= nil then
		if currentRun.Hero.MaxLastStands == nil or currentRun.Hero.MaxLastStands < requirements.RequiredMinMaximumLastStands then
			return false
		end
	end

	if requirements.RequiredMaxHealthFraction ~= nil then
		local currentHealthFraction = currentRun.Hero.Health / currentRun.Hero.MaxHealth
		if currentHealthFraction > requirements.RequiredMaxHealthFraction then
			if verboseLogging then
				args.FirstFailedRequirement = "CurrentRun.Hero.HealthFraction <= "..requirements.RequiredMaxHealthFraction.." (Current: "..tostring(currentHealthFraction)..")"
			end
			return false
		end
	end

	if requirements.RequiredMinHealthFraction ~= nil then
		local currentHealthFraction = currentRun.Hero.Health / currentRun.Hero.MaxHealth
		if currentHealthFraction < requirements.RequiredMinHealthFraction then
			if verboseLogging then
				args.FirstFailedRequirement = "CurrentRun.Hero.HealthFraction >= "..requirements.RequiredMinHealthFraction.." (Current: "..tostring(currentHealthFraction)..")"
			end
			return false
		end
	end

	if requirements.RequiredMaxLastStands ~= nil then
		if GetNumLastStands( currentRun.Hero ) > requirements.RequiredMaxLastStands then
			return false
		end
	end

	if requirements.RequiredLastGodLoot ~= nil and CurrentLootData ~= nil and CurrentLootData.Name ~= requirements.RequiredLastGodLoot then
		return false
	end

	if requirements.RequiredSwappedGodLoot ~= nil and currentRun.CurrentRoom.ReplacedTraitSource ~= requirements.RequiredSwappedGodLoot then
		return false
	end

	if requirements.RequiresLastUpgradeSwapped ~= nil and currentRun.CurrentRoom.ReplacedTraitSource == nil then
		return false
	end

	if source ~= nil then

		if requirements.HasTraitNameInRoom and not HasTraitOnLoot( source, requirements.HasTraitNameInRoom ) then
			return false
		end

		if requirements.MaxDistanceFromHero ~= nil then
			local distanceSource = args.CurrentSource or args.OriginalSource or source
			if GetDistance({ Id = distanceSource.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) > requirements.MaxDistanceFromHero then
				return false
			end
		end

		if requirements.ValuableUpgradeInRoom ~= nil then
			local meetsMinRarityRequirement = false
			local meetsHighestRarityRequirement = false
			if requirements.ValuableUpgradeInRoom.AllAtLeastRarity ~= nil and AllAtLeastRarity( source, requirements.ValuableUpgradeInRoom.AllAtLeastRarity ) then
				meetsMinRarityRequirement = true
			end
			if requirements.ValuableUpgradeInRoom.HasAtLeastRarity ~= nil and HasAtLeastRarity( source, requirements.ValuableUpgradeInRoom.HasAtLeastRarity ) then
				meetsHighestRarityRequirement = true
			end
			if not meetsMinRarityRequirement then
				args.FirstFailedRequirement = "ValuableUpgradeInRoom.AllAtLeastRarity"
				return false
			end
			if not meetsHighestRarityRequirement then
				args.FirstFailedRequirement = "ValuableUpgradeInRoom.HasAtLeastRarity"
				return false
			end
		end
	end

	if requirements.RequiredFalseRewardTypesInRoom ~= nil then
		for i, value in pairs( MapState.RoomRequiredObjects ) do
			if Contains( requirements.RequiredFalseRewardTypesInRoom, value.Name ) then
				return false
			end
		end
	end

	if requirements.RequiredFalseRewardType ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.ChosenRewardType == requirements.RequiredFalseRewardType then
			return false
		end
	end

	if requirements.NotMaxLastStands ~= nil and ( not currentRun.Hero.LastStands or not currentRun.Hero.MaxLastStands or TableLength( currentRun.Hero.LastStands ) >= currentRun.Hero.MaxLastStands ) then
		return false
	end

	if requirements.IsIdAlive ~= nil and not IsAlive({ Id = requirements.IsIdAlive }) then
		return false
	end
	if requirements.AreIdsAlive ~= nil then
		for i, id in pairs( requirements.AreIdsAlive ) do
			if not IsAlive({ Id = id }) then
				return false
			end
		end
	end
	if requirements.AreIdsNotAlive ~= nil then
		for i, id in pairs( requirements.AreIdsNotAlive ) do
			if IsAlive({ Id = id }) then
				return false
			end
		end
	end
	if requirements.IsObjectTypeAlive ~= nil then
		local id = GetIdsByType({ Name = requirements.IsObjectTypeAlive })
		if not IsAlive({ Id = id }) then
			return false
		end
	end
	if requirements.IsObjectTypeNotAlive ~= nil then
		local id = GetIdsByType({ Name = requirements.IsObjectTypeNotAlive })
		if IsAlive({ Id = id }) then
			return false
		end
	end

	if requirements.AnyQuestWithStatus ~= nil and not HasAnyQuestWithStatus( requirements.AnyQuestWithStatus ) then
		return false
	end
	if requirements.AllQuestsWithStatus ~= nil and not HasAllQuestsWithStatus( requirements.AllQuestsWithStatus ) then
		return false
	end

	if requirements.RequiredMinQuestsComplete ~= nil then
		local numQuestsComplete = 0
		if GameState.QuestStatus ~= nil then
			for questName, questStatus in pairs( GameState.QuestStatus ) do
				if questStatus == "CashedOut" then
					numQuestsComplete = numQuestsComplete + 1
				end
			end
		end
		if numQuestsComplete < requirements.RequiredMinQuestsComplete then
			return false
		end
	end
	if requirements.RequiredMaxQuestsComplete ~= nil then
		local numQuestsComplete = 0
		if GameState.QuestStatus ~= nil then
			for questName, questStatus in pairs( GameState.QuestStatus ) do
				if questStatus == "CashedOut" then
					numQuestsComplete = numQuestsComplete + 1
				end
			end
		end
		if numQuestsComplete > requirements.RequiredMaxQuestsComplete then
			return false
		end
	end

	if requirements.RequireQuestsComplete ~= nil then
		for k, questName in pairs(requirements.RequireQuestsComplete) do
			if GameState.QuestStatus[questName] ~= "CashedOut" then
				return false
			end
		end
	end

	if requirements.RequireAnyQuestsComplete ~= nil then
		local anyComplete = false
		for k, questName in pairs(requirements.RequireAnyQuestsComplete) do
			if GameState.QuestStatus[questName] == "CashedOut" then
				anyComplete = true
			end
		end
		if not anyComplete then
			return false
		end
	end

	if requirements.AnyAffordableItemInScreen ~= nil then
		local canAffordAny = false
		local screenData = ScreenData[requirements.AnyAffordableItemInScreen]
		local itemCategories = screenData.ItemCategories
		local dataStore = _G[requirements.AnyAffordableItemDataStore]
		if itemCategories ~= nil then
			for i, category in ipairs( itemCategories ) do
				if category.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, category, category.GameStateRequirements ) then
					for j, itemName in ipairs( category ) do
						local itemData = dataStore[itemName]
						if itemData ~= nil and not GameState.WorldUpgradesAdded[itemName] and not GameState.WeaponsUnlocked[itemName] and not itemData.IgnoreAffordable then
							local cost = itemData.ResourceCost or itemData.Cost
							if HasResources( cost ) then
								if GhostAdminAllowViewItem( screenData, category, itemData ) then
									--DebugPrint({ Text = "can afford: "..itemName })
									canAffordAny = true
									break
								end
							end
						end
					end
				end
			end
		end
		if not canAffordAny then
			return false
		end
	end
	if requirements.AnyAffordableMetaUpgradeItems ~= nil then
		local canAffordAny = false
		if CanIncreaseMetaUpgradeCardLimit() then
			canAffordAny = true
		else
			local current = GetCurrentMetaUpgradeCost()
			local limit = GetMaxMetaUpgradeCost()
			for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
				for column, cardName in pairs( rowData ) do
					if not canAffordAny
						and GameState.MetaUpgradeState[cardName]
						and not GameState.MetaUpgradeState[cardName].Unlocked
						and not MetaUpgradeCardData[cardName].DebugOnly
						and MetaUpgradeCardData[cardName].ResourceCost
						and HasResources(MetaUpgradeCardData[cardName].ResourceCost)
						and (HasNeighboringUnlockedCards( row, column ) or (row == 1 and column == 1))
						and current + MetaUpgradeCardData[ cardName ].Cost <= limit
						then
						canAffordAny = true
					end
				end
			end
		end
		
		if not canAffordAny then
			return false
		end
	end

	if requirements.MinRunsSinceAnyTextLines ~= nil then
		for k, textLines in pairs( requirements.MinRunsSinceAnyTextLines.TextLines ) do
			local runsSinceOccurred = 0
			for runIndex = #GameState.RunHistory + 1, 1, -1 do
				local prevRun = GameState.RunHistory[runIndex] or currentRun
				if prevRun.TextLinesRecord ~= nil and prevRun.TextLinesRecord[textLines] then
					if runsSinceOccurred < requirements.MinRunsSinceAnyTextLines.Count then
						DebugPrint({ Text = "textLines = "..textLines..", ".."runsSinceOccurred = "..runsSinceOccurred })
						return false
					end
				end
				runsSinceOccurred = runsSinceOccurred + 1
				if runsSinceOccurred >= requirements.MinRunsSinceAnyTextLines.Count then
					-- Already exceeded safely
					break
				end
			end
		end
	end
	if requirements.MaxRunsSinceAnyTextLines ~= nil then
		for k, textLines in pairs( requirements.MaxRunsSinceAnyTextLines.TextLines ) do
			local runsSinceOccurred = 0
			for runIndex = #GameState.RunHistory + 1, 1, -1 do
				local prevRun = GameState.RunHistory[runIndex] or currentRun
				if prevRun.TextLinesRecord ~= nil and prevRun.TextLinesRecord[textLines] then
					if runsSinceOccurred > requirements.MaxRunsSinceAnyTextLines.Count then
						DebugPrint({ Text = "textLines = "..textLines..", ".."runsSinceOccurred = "..runsSinceOccurred })
						return false
					else
						-- Did occur recently enough
						break
					end
				end
				runsSinceOccurred = runsSinceOccurred + 1
			end
		end
	end

	if requirements.RequiredTrueConfigOptions ~= nil then
		for k, configOption in pairs( requirements.RequiredTrueConfigOptions ) do
			if not GetConfigOptionValue({ Name = configOption }) then
				return false
			end
		end
	end
	if requirements.RequiredFalseConfigOptions ~= nil then
		for k, configOption in pairs( requirements.RequiredFalseConfigOptions ) do
			if GetConfigOptionValue({ Name = configOption }) then
				return false
			end
		end
	end

	if requirements.RequiredFalseCosmetics ~= nil then
		for k, name in pairs( requirements.RequiredFalseCosmetics ) do
			if GameState.WorldUpgrades[name] then
				return false
			end
		end
	end

	-- Generic state value checks

	if verboseLogging and DebugData.LegalGenericRequirementKeys then
		for key, value in pairs( DebugData.LegalGenericRequirementKeys ) do
			if requirements[key] then
				DebugAssert({ Condition = false, Text = key.." used at top level of GameStateRequirements on "..tostring(source.Name), Owner = "Greg" })
			end
		end
	end

	for i, requirement in ipairs( requirements ) do

		if verboseLogging and DebugData.LegalGenericRequirementKeys then
			for key, value in pairs( requirement ) do
				if not DebugData.LegalGenericRequirementKeys[key] then
					DebugAssert({ Condition = false, Text = "Unrecognized key ("..key..") used in generic GameStateRequirements on "..tostring(source.Name or source.ObjectId), Owner = "Greg" })
				end
			end
		end

		local expectedKeys = 1
		local valueToCheck = _G
		if requirement.PathFromSource then
			valueToCheck = source
			expectedKeys = expectedKeys + 1
		elseif requirement.PathFromArgs then
			valueToCheck = args
			expectedKeys = expectedKeys + 1
		end

		if requirement.FunctionName ~= nil then
			if not CallFunctionName( requirement.FunctionName, source, requirement.FunctionArgs ) then
				return false
			end
		elseif requirement.PathFalse ~= nil then
			if verboseLogging and TableLength( requirement ) > expectedKeys then
				DebugPrintTable( requirement, true )
				DebugAssert({ Condition = false, Text = "Using PathFalse with other keys on "..tostring(source.Name), Owner = "Greg", })
			end
			for j, subTable in ipairs( requirement.PathFalse ) do
				valueToCheck = valueToCheck[subTable]
				if valueToCheck == nil then
					break
				end
			end
			if valueToCheck then
				if verboseLogging then
					local keyString = ""
					if requirement.PathFromSource then
						keyString = source.Name
					end
					local firstTable = true
					for i, subTable in ipairs( requirement.PathFalse ) do
						if firstTable and not requirement.PathFromSource then
							keyString = subTable
							firstTable = false
						else
							keyString = keyString.."."..subTable
						end
					end
					args.FirstFailedRequirement = keyString.." == false (Current: "..tostring(valueToCheck)..")"
				end
				return false
			end
		elseif requirement.PathTrue ~= nil then
			if verboseLogging and TableLength( requirement ) > expectedKeys then
				DebugPrintTable( requirement, true )
				DebugAssert({ Condition = false, Text = "Using PathTrue with other keys on "..tostring(source.Name), Owner = "Greg", })
			end
			for j, subTable in ipairs( requirement.PathTrue ) do
				valueToCheck = valueToCheck[subTable]
				if (not valueToCheck) or valueToCheck == 0 then
					if verboseLogging then
						local keyString = ""
						if requirement.PathFromSource then
							keyString = source.Name
						end
						local firstTable = true
						for i, subTable in ipairs( requirement.PathTrue ) do
							if firstTable and not requirement.PathFromSource then
								keyString = subTable
								firstTable = false
							else
								keyString = keyString.."."..subTable
							end
						end
						args.FirstFailedRequirement = keyString.." == true (Current: "..tostring(valueToCheck)..")"
					end
					return false
				end
			end
		elseif requirement.PathEmpty ~= nil then
			if verboseLogging and requirement.Comparison ~= nil then
				DebugAssert({ Condition = false, Text = "Using Comparison with a PathEmpty requirement on "..tostring(source.Name), Owner = "Greg", })
			end
			for j, subTable in ipairs( requirement.PathEmpty ) do
				valueToCheck = valueToCheck[subTable]
				if valueToCheck == nil then
					break
				end
			end
			if not IsEmpty( valueToCheck ) then
				if verboseLogging then
					local keyString = ""
					if requirement.PathFromSource then
						keyString = source.Name
					end
					local firstTable = true
					for i, subTable in ipairs( requirement.PathEmpty ) do
						if firstTable and not requirement.PathFromSource then
							keyString = subTable
							firstTable = false
						else
							keyString = keyString.."."..subTable
						end
					end
					args.FirstFailedRequirement = keyString.." IsEmpty() (Current Size: "..TableLength(valueToCheck)..")"
				end
				return false
			end
		elseif requirement.PathNotEmpty ~= nil then
			if verboseLogging and requirement.Comparison ~= nil then
				DebugAssert({ Condition = false, Text = "Using Comparison with a PathNotEmpty requirement on "..tostring(source.Name), Owner = "Greg", })
			end
			for j, subTable in ipairs( requirement.PathNotEmpty ) do
				valueToCheck = valueToCheck[subTable]
				if valueToCheck == nil then
					break
				end
			end
			if IsEmpty( valueToCheck ) then
				if verboseLogging then
					local keyString = ""
					if requirement.PathFromSource then
						keyString = source.Name
					end
					local firstTable = true
					for i, subTable in ipairs( requirement.PathNotEmpty ) do
						if firstTable and not requirement.PathFromSource then
							keyString = subTable
							firstTable = false
						else
							keyString = keyString.."."..subTable
						end
					end
					args.FirstFailedRequirement = keyString.." not IsEmpty() (Current Size: "..TableLength(valueToCheck)..")"
				end
				return false
			end
		elseif requirement.Path ~= nil then

			for j, subTable in ipairs( requirement.Path ) do
				valueToCheck = valueToCheck[subTable]
				if valueToCheck == nil then
					break
				end
			end
			if requirement.UseLength then
				valueToCheck = TableLength( valueToCheck )
				--DebugPrint({ Text = "UseLength length = "..valueToCheck })
			elseif requirement.Modulo ~= nil then
				if valueToCheck ~= nil then
					valueToCheck = valueToCheck % requirement.Modulo
					--DebugPrint({ Text = "Modulo = "..valueToCheck })
				end
			elseif requirement.CountOf ~= nil then
				if verboseLogging and type(valueToCheck) ~= "table" then
					DebugAssert({ Condition = false, Text = "Using CountOf on a non-table value on "..tostring(source.Name), Owner = "Greg", })
				end
				local count = 0
				for i, keyToCount in ipairs( requirement.CountOf ) do
					if valueToCheck[keyToCount] then
						count = count + 1
					end
				end
				--DebugPrint({ Text = "CountOf count = "..count })
				valueToCheck = count
			elseif requirement.SumOf ~= nil then
				if verboseLogging and type(valueToCheck) ~= "table" then
					DebugAssert({ Condition = false, Text = "Using SumOf on a non-table value on "..tostring(source.Name), Owner = "Greg", })
				end
				local sum = 0
				for i, keyToSum in ipairs( requirement.SumOf ) do
					sum = sum + (valueToCheck[keyToSum] or 0)
				end
				--DebugPrint({ Text = "SumOf sum = "..sum })
				valueToCheck = sum
			elseif requirement.MaxOf ~= nil then
				local max = 0
				if requirement.MaxOf == "All" then
					for tableKey, tableValue in pairs( valueToCheck ) do
						max = math.max( max, tableValue )
					end
				else
					for i, keyToMax in ipairs( requirement.MaxOf ) do
						max = max + (valueToCheck[keyToMax] or 0)
					end
				end
				--DebugPrint({ Text = "MaxOf = "..max })
				valueToCheck = max
			elseif requirement.SubtractFromPath ~= nil then
				local subtractFromValue = _G
				for k, subTable in ipairs( requirement.SubtractFromPath ) do
					subtractFromValue = subtractFromValue[subTable]
					if subtractFromValue == nil then
						break
					end
				end
				--DebugPrint({ Text = "valueToCheck = "..tostring(valueToCheck) })
				--DebugPrint({ Text = "subtractFromValue = "..tostring(subtractFromValue) })
				valueToCheck = (subtractFromValue or 0) - (valueToCheck or 0)
				--DebugPrint({ Text = "valueToCheck = "..tostring(valueToCheck) })
			end

			if requirement.SumPrevRooms ~= nil then
				local prevRoomSum = 0
				--DebugPrint({ Text = "Summing previous rooms" })
				for roomsBack = 0, requirement.SumPrevRooms - 1 do
					local prevRoom = nil
					if roomsBack == 0 then
						prevRoom = CurrentRun.CurrentRoom
					else
						local roomIndex = #CurrentRun.RoomHistory - (roomsBack - 1)
						--DebugPrint({ Text = "roomIndex = "..roomIndex })
						prevRoom = CurrentRun.RoomHistory[roomIndex]
					end
					if prevRoom == nil then
						-- No more rooms to check
						break
					end
					valueToCheck = prevRoom
					for k, subTable in ipairs( requirement.Path ) do
						valueToCheck = valueToCheck[subTable]
						if valueToCheck == nil then
							break
						end
					end
					--DebugPrint({ Text = "prevRoom Name = "..prevRoom.Name })
					--DebugPrint({ Text = "prevRoom valueToCheck = "..tostring(valueToCheck) })
					if requirement.TableValuesToCount ~= nil then
						if valueToCheck ~= nil then
							for k, valueToCount in ipairs( requirement.TableValuesToCount ) do
								if valueToCheck[valueToCount] then
									prevRoomSum = prevRoomSum + 1
								end
							end
						end
						--DebugPrint({ Text = "prevRoomSum = "..prevRoomSum })
					elseif requirement.ValuesToCount ~= nil then
						for k, valueToCount in ipairs( requirement.ValuesToCount ) do
							if valueToCheck == valueToCount then
								prevRoomSum = prevRoomSum + 1
								--DebugPrint({ Text = "prevRoomSum = prevRoomSum + 1" })
								break
							end
						end
					elseif requirement.CountPathTrue ~= nil then
						if valueToCheck ~= nil then
							prevRoomSum = prevRoomSum + 1
						end
					else
						prevRoomSum = prevRoomSum + (valueToCheck or 0)
					end
				end
				valueToCheck = prevRoomSum
				--DebugPrint({ Text = "prevRoomSum = "..prevRoomSum })
			end

			if requirement.SumPrevRuns ~= nil then
				local prevRunSum = 0
				--DebugPrint({ Text = "Summing previous runs" })
				for runsBack = 0, requirement.SumPrevRuns - 1 do
					local prevRun = nil
					if runsBack == 0 then
						prevRun = CurrentRun
					else
						local runIndex = #GameState.RunHistory - (runsBack - 1)
						--DebugPrint({ Text = "runIndex = "..runIndex })
						prevRun = GameState.RunHistory[runIndex]
					end
					if prevRun == nil then
						-- No more runs to check
						break
					end
					valueToCheck = prevRun
					for k, subTable in ipairs( requirement.Path ) do
						valueToCheck = valueToCheck[subTable]
						if valueToCheck == nil then
							if verboseLogging and k == 1 then
								DebugAssert({ Condition = false, Text = "First key ("..subTable..") on SumPrevRuns is nil on "..tostring(source.Name), Owner = "Gavin", })
							end
							break
						end
					end
					if requirement.TableValuesToCount ~= nil then
						if valueToCheck ~= nil then
							for k, valueToCount in ipairs( requirement.TableValuesToCount ) do
								if valueToCheck[valueToCount] then
									prevRunSum = prevRunSum + 1
								end
							end
						end
						--DebugPrint({ Text = "prevRunSum = "..prevRunSum })
					elseif requirement.ValuesToCount ~= nil then
						for k, valueToCount in ipairs( requirement.ValuesToCount ) do
							if valueToCheck == valueToCount then
								prevRunSum = prevRunSum + 1
								--DebugPrint({ Text = "prevRunSum = prevRunSum + 1" })
								break
							end
						end
					elseif requirement.CountPathTrue ~= nil then
						if valueToCheck ~= nil then
							prevRunSum = prevRunSum + 1
						end
					else
						prevRunSum = prevRunSum + (valueToCheck or 0)
					end
					--DebugPrint({ Text = "run valueToCheck = "..tostring(valueToCheck) })
				end
				valueToCheck = prevRunSum
				--DebugPrint({ Text = "prevRunSum = "..prevRunSum })
			end

			if verboseLogging then
				local keyString = ""
				if requirement.PathFromSource then
					keyString = source.Name
				end
				local firstTable = true
				for i, subTable in ipairs( requirement.Path ) do
					if firstTable and not requirement.PathFromSource then
						keyString = subTable
						firstTable = false
					else
						keyString = keyString.."."..subTable
					end
				end
				args.FirstFailedRequirement = keyString
			end
			
			if requirement.HasNone ~= nil then
				if valueToCheck ~= nil then
					for i, valueFalse in ipairs( requirement.HasNone ) do
						if verboseLogging and type(valueToCheck) ~= "table" then
							DebugAssert({ Condition = false, Text = "Using HasNone on a non-table value on "..tostring(source.Name), Owner = "Greg", })
						end
						if valueToCheck[valueFalse] then
							if verboseLogging then
								args.FirstFailedRequirement = args.FirstFailedRequirement.." HasNone (Does have: "..tostring(valueFalse)..")"
							end
							return false
						end
					end
				end
			elseif requirement.HasAny ~= nil then
				if valueToCheck == nil then
					return false
				end
				local anyTrue = false
				if verboseLogging and type(valueToCheck) ~= "table" then
					DebugAssert({ Condition = false, Text = "Using HasAny on a non-table value on "..tostring(source.Name), Owner = "Greg", })
				end
				for i, valueTrue in ipairs( requirement.HasAny ) do
					if valueToCheck[valueTrue] then
						anyTrue = true
						break
					end
				end
				if not anyTrue then
					if verboseLogging then
						args.FirstFailedRequirement = args.FirstFailedRequirement.." HasAny"
					end
					return false
				end
			elseif requirement.HasAll ~= nil then
				if valueToCheck == nil then
					return false
				end
				if verboseLogging and type(valueToCheck) ~= "table" then
					DebugAssert({ Condition = false, Text = "Using HasAll on a non-table value on "..tostring(source.Name), Owner = "Greg", })
				end
				for i, valueTrue in ipairs( requirement.HasAll ) do
					if not valueToCheck[valueTrue] then
						if verboseLogging then
							args.FirstFailedRequirement = args.FirstFailedRequirement.." HasAll (Missing: "..tostring(valueTrue)..")"
						end
						return false
					end
				end
			elseif requirement.NotHasAll ~= nil then
				if valueToCheck ~= nil then
					if verboseLogging and type(valueToCheck) ~= "table" then
						DebugAssert({ Condition = false, Text = "Using NotHasAll on a non-table value on "..tostring(source.Name), Owner = "Greg", })
					end
					local hasAll = true
					for i, valueTrue in ipairs( requirement.NotHasAll ) do
						if not valueToCheck[valueTrue] then
							hasAll = false
							break
						end
					end
					if hasAll then
						if verboseLogging then
							args.FirstFailedRequirement = args.FirstFailedRequirement.." NotHasAll"
						end
						return false
					end
				end
			elseif requirement.IsNone ~= nil then
				if verboseLogging and type(valueToCheck) == "table" then
					DebugAssert({ Condition = false, Text = "Using IsNone on a table value on "..tostring(source.Name), Owner = "Greg", })
				end
				for i, valueFalse in ipairs( requirement.IsNone ) do
					if valueToCheck == valueFalse then
						if verboseLogging then
							args.FirstFailedRequirement = args.FirstFailedRequirement.." IsNone (Current: "..tostring(valueToCheck)..")"
						end
						return false
					end
				end
			elseif requirement.IsAny ~= nil then
				if verboseLogging and type(valueToCheck) == "table" then
					DebugAssert({ Condition = false, Text = "Using IsAny on a table value on "..tostring(source.Name or source.Cue), Owner = "Greg", })
				end
				local anyTrue = false
				for i, valueTrue in ipairs( requirement.IsAny ) do
					if valueToCheck == valueTrue then
						anyTrue = true
						break
					end
				end
				if not anyTrue then
					if verboseLogging then
						args.FirstFailedRequirement = args.FirstFailedRequirement.." IsAny (Current: "..tostring(valueToCheck)..")"
					end
					return false
				end
			elseif requirement.Comparison ~= nil then
				local comparison = requirement.Comparison
				if comparison == nil then
					DebugAssert({ Condition = false, Text = "Requirement missing Comparison on "..tostring(source.Name), Owner = "Greg", })
					break
				end

				local value = requirement.Value
				if requirement.ValuePath ~= nil then
					value = _G
					for k, subTable in ipairs( requirement.ValuePath ) do
						value = value[subTable]
						if value == nil then
							value = 0
							break
						end
					end	
					if requirement.ValuePathAddition ~= nil then
						value = value + requirement.ValuePathAddition
					end
				end

				if verboseLogging then
					args.FirstFailedRequirement = args.FirstFailedRequirement.." "..comparison.." "..tostring(value).." (Current: "..tostring(valueToCheck)..")"
				end

				if valueToCheck == nil and type(value) == "number" then
					valueToCheck = 0
				end

				if comparison == nil or comparison == "==" or comparison == "=" then
					if (valueToCheck or 0) ~= value then
						return false
					end
				elseif comparison == "~=" or comparison == "!=" then
					if (valueToCheck or 0) == value then
						return false
					end
				elseif comparison == ">=" then
					if (valueToCheck or 0) < value then
						return false
					end
				elseif comparison == ">" then
					if (valueToCheck or 0) <= value then
						return false
					end
				elseif comparison == "<=" then
					if (valueToCheck or 0) > value then
						return false
					end
				elseif comparison == "<" then
					if (valueToCheck or 0) >= value then
						return false
					end
				else
					DebugAssert({ Condition = false, Text = "Invalid requirements comparison: "..tostring(comparison), Owner = "Greg", })
				end			
			else
				DebugAssert({ Condition = false, Text = "Requirement missing Value on "..tostring(source.Name), Owner = "Greg" })
			end
		else
			if verboseLogging then
				if requirement.HasNone ~= nil or requirement.HasAny ~= nil or requirement.HasAll ~= nil or requirement.IsNone ~= nil  or requirement.IsAny ~= nil then
					DebugAssert({ Condition = false, Text = "Missing Path for requirement on "..GetTableString(source), Owner = "Greg", })
				end
			end
		end

	end

	if requirements.RequiredConsumablesThisRun ~= nil then
		local count = 0
		for k, name in pairs( requirements.RequiredConsumablesThisRun.Names ) do
			count = count + (currentRun.ConsumableRecord[name] or 0)
		end
		if count < requirements.RequiredConsumablesThisRun.Count then
			return false
		end
	end

	-- note this is for the Daedalus Hammer not Weapon Aspects
	if requirements.RequiredMinWeaponUpgrades ~= nil then
		local numUpgrades = 0
		if currentRun.LootTypeHistory and currentRun.LootTypeHistory.WeaponUpgrade then
			if currentRun.LootTypeHistory.WeaponUpgrade < requirements.RequiredMinWeaponUpgrades then
				return false
			else
				numUpgrades = currentRun.LootTypeHistory.WeaponUpgrade
			end
		end

		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.ChosenRewardType == "WeaponUpgrade" and (numUpgrades + 1) < requirements.RequiredMinWeaponUpgrades then
			return false
		elseif numUpgrades < requirements.RequiredMinWeaponUpgrades then
			return false
		end
	end

	if requirements.RequiredMaxWeaponUpgrades ~= nil then
		local numUpgrades = 0
		if currentRun.LootTypeHistory and currentRun.LootTypeHistory.WeaponUpgrade then
			if currentRun.LootTypeHistory.WeaponUpgrade > requirements.RequiredMaxWeaponUpgrades then
				return false
			else
				numUpgrades = currentRun.LootTypeHistory.WeaponUpgrade
			end
		end
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.ChosenRewardType == "WeaponUpgrade" and (numUpgrades + 1) > requirements.RequiredMaxWeaponUpgrades then
			return false
		end
	end

	if requirements.RequiredNotInStore ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Store ~= nil and currentRun.CurrentRoom.Store.StoreOptions ~=nil then
			for i, value in pairs(currentRun.CurrentRoom.Store.StoreOptions) do
				if value.Name == requirements.RequiredNotInStore then
					return false
				end
			end
		end
	end

	if requirements.RequiredMusicName ~= nil then
		if requirements.RequiredMusicName ~= AudioState.MusicName then
			return false
		end
	end

	if requirements.RequiredMusicSection ~= nil then
		if requirements.RequiredMusicSection ~= AudioState.MusicSection then
			return false
		end
	end

	if requirements.RequiredMusicSectionRoomDuration ~= nil and AudioState.MusicSectionStartDepth ~= nil then
		local duration = GetRunDepth( currentRun ) - AudioState.MusicSectionStartDepth
		if duration < requirements.RequiredMusicSectionRoomDuration then
			return false
		end
	end

	if requirements.RequiresNotFishing ~= nil and CurrentRun.Hero.FishingStarted then
		return false
	end

	if requirements.RequiredSellableGodTraits ~= nil then
		local hasSellable = false
		for index, traitData in pairs (CurrentRun.Hero.Traits) do
			if not hasSellable and IsGodTrait( traitData.Name, { ForShop = true }) and traitData.Rarity and not Contains( args.ExclusionNames, traitData.Name ) then
				hasSellable = true
			end
		end
		if not hasSellable then
			return false
		end
	end

	if requirements.RequiredUpgradeableGodTraits ~= nil then
		if not UpgradableGodTraitCountAtLeast( requirements.RequiredUpgradeableGodTraits ) then
			return false
		end
	end

	if requirements.RequiredInteractedGods ~= nil then
		if TableLength( GetEligibleInteractedGods() ) < requirements.RequiredInteractedGods then
			return false
		end
	end

	if requirements.RequiredInteractedGodsThisRun ~= nil then
		if TableLength( GetInteractedGodsThisRun() ) < requirements.RequiredInteractedGodsThisRun then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceDevotion ~= nil then
		if currentRun.LastDevotionDepth ~= nil and currentRun.LastDevotionDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceDevotion < currentRun.LastDevotionDepth then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceWellShop ~= nil then
		if currentRun.LastWellShopDepth ~= nil and currentRun.LastWellShopDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceWellShop < currentRun.LastWellShopDepth then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceShrinePointDoor ~= nil then
		if currentRun.LastShrinePointDoorDepth ~= nil and currentRun.LastShrinePointDoorDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceShrinePointDoor < currentRun.LastShrinePointDoorDepth then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceChallengeSwitch ~= nil then
		if currentRun.LastChallengeDepth ~= nil and currentRun.LastChallengeDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceChallengeSwitch < currentRun.LastChallengeDepth then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceFishingPoint ~= nil then
		if currentRun.LastFishingPointDepth ~= nil and currentRun.LastFishingPointDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceFishingPoint < currentRun.LastFishingPointDepth then
			return false
		end
	end	

	return true

end