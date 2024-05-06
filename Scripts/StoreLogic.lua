
function FillInShopOptions( args )
	if args == nil then
		args = {}
	end

	if args.RoomName and RoomData[args.RoomName] and RoomData[args.RoomName].PersistentStore then
		local store = GetPreviousStore( args )
		if store ~= nil then
			return store
		end
	end

	local storeData = nil
	if args.StoreData ~= nil then
		storeData = args.StoreData
	else
		storeData = StoreData
	end

	local store =
	{
		StoreOptions = {}
	}

	if storeData.Traits ~= nil then
		for i, itemName in pairs( storeData.Traits ) do
			if not Contains( storeData.GuaranteedItems, itemName) and not Contains( args.ExclusionNames, itemName) and IsTraitEligible(CurrentRun, TraitData[itemName]) then
				local upgradeData = {}
				upgradeData.Name = itemName
				upgradeData.Type = "Trait"
				table.insert( store.StoreOptions, upgradeData )
			end
		end
	end

	if storeData.Consumables ~= nil then
		for i, itemName in pairs( storeData.Consumables ) do
			if not Contains( storeData.GuaranteedItems, itemName ) and not Contains( args.ExclusionNames, itemName ) then
				local upgradeData = ConsumableData[itemName]
				if StoreItemEligible(upgradeData, args) then
					upgradeData = {}
					upgradeData.Name = itemName
					upgradeData.Type = "Consumable"
					table.insert ( store.StoreOptions, upgradeData )
				end
			end
		end
	end

	local cosmetics = {}
	local cosmeticOffers = 0
	if storeData.CosmeticOffers then
		cosmeticOffers = storeData.CosmeticOffers.Amount
		if cosmeticOffers == nil then
			cosmeticOffers = RandomInt( storeData.CosmeticOffers.Min, storeData.CosmeticOffers.Max )
		end
		if cosmeticOffers == nil or cosmeticOffers < 0 then
			cosmeticOffers = 0
		end
	end

	if storeData.CosmeticOffers ~= nil then
		for i, itemName in pairs( storeData.CosmeticOffers.Options ) do
			if not GameState.WorldUpgrades[itemName] and not Contains( args.ExclusionNames, itemName) then
				local upgradeData = {}
				upgradeData.Name = itemName
				upgradeData.Type = "Cosmetic"
				table.insert( cosmetics, upgradeData )
			end
		end

		while TableLength( cosmetics ) > cosmeticOffers do
			RemoveRandomValue( cosmetics )
		end
	end
	cosmeticOffers = math.min(TableLength(cosmetics), cosmeticOffers)

	local healOffers = {}
	local healOfferAmount = 0
	 
	if storeData.HealingOffers then
		healOfferAmount = storeData.HealingOffers.Amount
		if healOfferAmount == nil then
			healOfferAmount = RandomInt( storeData.HealingOffers.Min, storeData.HealingOffers.Max )
		end
		if healOfferAmount == nil or healOfferAmount < 0 then
			healOfferAmount = 0
		end
		if storeData.HealingOffers.Options then
			for i=1, healOfferAmount do
				local options = {}
				for i, data in pairs( storeData.HealingOffers.Options ) do
					if not Contains(args.ExclusionNames, data.Name ) and StoreItemNameEligible(data.Name, data.Type) then
						table.insert( options, data )
					end
				end

				local healOfferData = GetRandomValue( options )
				local upgradeData = DeepCopyTable( healOfferData )

				if upgradeData and not Contains( args.ExclusionNames, upgradeData.Name ) then
					table.insert( healOffers, upgradeData )
				end
			end
		elseif storeData.HealingOffers.WeightedList then
			local pickedOptions = {}
			local options = DeepCopyTable( storeData.HealingOffers.WeightedList )
			while TableLength( pickedOptions ) < healOfferAmount do
				local weightedList = {}
				for i, itemData in pairs( options ) do
					if not Contains(args.ExclusionNames, itemData.Name ) and StoreItemNameEligible(itemData.Name, itemData.Type) then
						weightedList[i] = itemData.Weight
					end
				end

				local index = GetRandomValueFromWeightedList( weightedList )
				table.insert( pickedOptions, options[index] )
				table.remove( options, index )
			end
			for s, itemData in pairs( pickedOptions ) do
				if not Contains( args.ExclusionNames, itemData.Name ) then
					table.insert( healOffers, itemData )
				end
			end
		end

	end
	local godTraits = {}
	if storeData.GodTraitOffers ~= nil then
		local godTraitNumber = RandomInt( storeData.GodTraitOffers.Min, storeData.GodTraitOffers.Max )
		local godTraitOptions = ShallowCopyTable( storeData.GodTraitOffers.Types)
		local ignoredGod = nil
		for i=1, godTraitNumber do
			local pickedGod = GetEligibleInteractedGod( ignoredGod )
			if pickedGod ~= nil then
				local upgradeData = {}
				upgradeData.Name = "RandomLoot"
				upgradeData.Type = "Boon"
				upgradeData.Args = { ForceLootName = pickedGod, BoughtFromShop = true, DoesNotBlockExit = true }
				ignoredGod = pickedGod
				table.insert( godTraits, upgradeData )
			end
		end
	end

	if storeData.MaxOffers then
		while TableLength( store.StoreOptions ) > ( storeData.MaxOffers - TableLength( godTraits ) - healOfferAmount - cosmeticOffers ) do
			RemoveRandomValue( store.StoreOptions )
		end
		store.StoreOptions = CollapseTable( store.StoreOptions )
		store.StoreOptions = CombineTables( healOffers, store.StoreOptions )
		store.StoreOptions = CombineTables( store.StoreOptions, godTraits )
		store.StoreOptions = CombineTables( store.StoreOptions, cosmetics )
	end

	if storeData.GroupsOf then
		for i, groupData in pairs(storeData.GroupsOf) do
			local options = {}
			if groupData.Options ~= nil then
				for s, itemName in pairs(groupData.Options) do
					local upgradeData = DeepCopyTable( ConsumableData[itemName] )
					if StoreItemEligible(upgradeData, args) or groupData.SkipRequirements then
						if itemName == "RandomLoot" or itemName == "BoostedRandomLoot" then
							local pickedGod = GetEligibleInteractedGod()
							if pickedGod ~= nil then
								upgradeData = {}
								upgradeData.Name = "RandomLoot"
								upgradeData.Type = "Boon"
								upgradeData.Args = { ForceLootName = pickedGod, BoughtFromShop = true, DoesNotBlockExit = true, ResourceCosts = GetProcessedValue( ConsumableData[itemName].ResourceCosts ) }
								if itemName == "BoostedRandomLoot" then
									upgradeData.Args.AddBoostedAnimation = true
									upgradeData.Args.BoonRaritiesOverride = { Legendary = 0.1, Epic = 0.25, Rare = 0.90 }
								end
								table.insert( options, upgradeData )
							end
						else
							upgradeData = {}
							upgradeData.Name = itemName
							upgradeData.Type = "Consumable"
							table.insert ( options, upgradeData )
						end
					end
				end
			end
			if groupData.OptionsData ~= nil then
				for s, itemData in pairs(groupData.OptionsData) do
					local upgradeData = DeepCopyTable( ConsumableData[itemData.Name] or LootData[itemData.Name] )
					if ( itemData.ReplaceRequirements == nil and ( StoreItemEligible(upgradeData, args) or itemData.SkipRequirements )) or ( itemData.ReplaceRequirements and IsGameStateEligible( CurrentRun, itemData.ReplaceRequirements) ) then
						local itemName = itemData.Name
						if itemName == "RandomLoot" or itemName == "BoostedRandomLoot" then
							local pickedGod = GetEligibleInteractedGod()
							if pickedGod ~= nil then
								upgradeData = {}
								upgradeData.Name = "RandomLoot"
								upgradeData.Type = "Boon"
								upgradeData.Args = { ForceLootName = pickedGod, BoughtFromShop = true, DoesNotBlockExit = true, ResourceCosts = GetProcessedValue( ConsumableData[itemName].ResourceCosts ) }
								if itemName == "BoostedRandomLoot" then
									upgradeData.Args.AddBoostedAnimation = true
									upgradeData.Args.BoonRaritiesOverride = { Legendary = 0.1, Epic = 0.25, Rare = 0.90 }
								end
							end
						else
							upgradeData = {}
							upgradeData.Name = itemData.Name
							upgradeData.Type = "Consumable"
							if itemData.Cost ~= nil then
								upgradeData.CostOverride = itemData.Cost
							elseif itemData.ResourceCosts ~= nil then
								upgradeData.ResourceCosts = itemData.ResourceCosts
							end
						end

						if itemData.UpgradeChance and RandomChance( itemData.UpgradeChance ) then
							upgradeData.AddBoostedAnimation = true
							upgradeData.Args = upgradeData.Args or {}
							upgradeData.Args.BoonRaritiesOverride = { Legendary = 0.1, Epic = 0.25, Rare = 0.90 }
							if itemData.UpgradedCost then
								upgradeData.ResourceCosts = 
								{
									Money = itemData.UpgradedCost
								}
							end
						end
						upgradeData.Weight = itemData.Weight or 1
						table.insert ( options, upgradeData )
					end
				end
			end
			if TableLength(options) > 0 then
				if groupData.WeightedList then
					local pickedOptions = {}
					local loop = 0

					while TableLength( pickedOptions ) < groupData.Offers do
						loop = loop + 1
						local weightedList = {}
						for i, optionData in pairs( options ) do
							weightedList[i] = optionData.Weight or 1
						end
					
						if loop > 100 then
							return {}
						end
						local index = GetRandomValueFromWeightedList( weightedList )
						table.insert( pickedOptions, options[index] )
						table.remove( options, index )
					end
					for s, itemData in pairs( pickedOptions ) do
						table.insert( store.StoreOptions, itemData )
					end
				else
					while TableLength( options ) > groupData.Offers do
						RemoveRandomValue( options )
					end
					for s, itemData in pairs(options) do
						table.insert( store.StoreOptions, itemData )
					end
				end
			end
		end
	end
	return store
end

function GetPreviousStore( args )
	if CurrentRun.RoomCreations[args.RoomName] == nil then
		return nil
	end

	for roomIndex = #CurrentRun.RoomHistory, 1, -1 do
		local room = CurrentRun.RoomHistory[roomIndex]
		if room.Name == args.RoomName and room.Store and room.Store.StoreOptions then
			return { StoreOptions = DeepCopyTable( room.Store.StoreOptions )}
		end
	end
	return nil
end

function RerollStore( screen, button )
	if IsEmpty( CurrentRun.CurrentRoom.Store.StoreOptions )then
		return
	end
	DestroyStoreButtons( screen )
	local randomExclusion = nil
	if not IsEmpty(CurrentRun.CurrentRoom.Store.StoreOptions ) then
		randomExclusion = { GetRandomValue( CurrentRun.CurrentRoom.Store.StoreOptions ).Name }
	end
	CurrentRun.CurrentRoom.Store.StoreOptions = FillInShopOptions({ StoreData = StoreData.RoomShop, RoomName = CurrentRun.CurrentRoom.Name, ExclusionNames = randomExclusion }).StoreOptions
	if not IsEmpty(CurrentRun.CurrentRoom.IndexesPurchased) then
		for _, index in pairs(CurrentRun.CurrentRoom.IndexesPurchased) do
			CurrentRun.CurrentRoom.Store.StoreOptions[index] = nil
		end
		CurrentRun.CurrentRoom.Store.StoreOptions = CollapseTable( CurrentRun.CurrentRoom.Store.StoreOptions )
	end
	CreateStoreButtons( screen )
end

function StoreItemNameEligible( itemName, itemCategory)
	if itemCategory == "Consumable" then
		return StoreItemEligible( ConsumableData[itemName] )
	elseif itemCategory == "Trait" then
		return StoreItemEligible( TraitData[itemName] )
	end
end

function StoreItemEligible( itemData, args )
	if itemData.RequiredNextMaps and (args.RoomName == nil or not Contains( itemData.RequiredNextMaps, args.RoomName )) then
		return false
	end

	if itemData.RequiredFalseNextMaps and Contains( itemData.RequiredFalseNextMaps, args.RoomName ) then
		return false
	end

	if itemData.RequireUpgradableTraits and not UpgradableGodTraitCountAtLeast( 0 )  then
		return false
	end
	if itemData.GameStateRequirements then
		return IsGameStateEligible( CurrentRun, itemData.GameStateRequirements )
	else
		return true
	end
end

function RemoveStoreItem( args )
	if CurrentRun == nil or CurrentRun.CurrentRoom == nil or CurrentRun.CurrentRoom.Store == nil or IsEmpty( CurrentRun.CurrentRoom.Store.StoreOptions ) then
		return
	end
	for i, data in pairs( CurrentRun.CurrentRoom.Store.StoreOptions ) do
		local dataArgs = data.Args or {}
		if args.IsBoon and data.Type == "Boon" and data.Args and data.Args.ForceLootName == args.Name and TableLength(dataArgs.BoonRaritiesOverride) == TableLength(args.BoonRaritiesOverride) then
			if dataArgs.BoonRaritiesOverride == args.BoonRaritiesOverride then
				CurrentRun.CurrentRoom.Store.StoreOptions[i] = nil
				break
			elseif dataArgs.BoonRaritiesOverride ~= nil and args.BoonRaritiesOverride ~= nil and dataArgs.BoonRaritiesOverride.Epic == args.BoonRaritiesOverride.Epic and  dataArgs.BoonRaritiesOverride.Rare == args.BoonRaritiesOverride.Rare then
				CurrentRun.CurrentRoom.Store.StoreOptions[i] = nil
				break
			end
		elseif data.Name == ( args.Name .. "Drop" ) then
			CurrentRun.CurrentRoom.Store.StoreOptions[i] = nil
			break
		elseif data.Name == args.Name then
			CurrentRun.CurrentRoom.Store.StoreOptions[i] = nil
			break
		end
	end
	if CurrentRun.CurrentRoom.Store.SpawnedStoreItems then
		for i, data in pairs(CurrentRun.CurrentRoom.Store.SpawnedStoreItems ) do
			if data.ObjectId == args.Id then
				CurrentRun.CurrentRoom.Store.SpawnedStoreItems[i] = nil
				if CurrentRun.CurrentRoom.WatchedItemIndex == i then
					notifyExistingWaiters( "ShopItem" )
					break
				end
			end
		end
	end
	CurrentRun.CurrentRoom.StoreItemsPurchased = (CurrentRun.CurrentRoom.StoreItemsPurchased or 0) + 1
end

function RunShopGeneration( room )
	if IsWellShopEligible( CurrentRun, room ) then
		roomData.Store = FillInShopOptions({ StoreData = StoreData.RoomShop, RoomName = room.Name })
	end
	if IsSurfaceShopEligible( CurrentRun, room ) then
		roomData.Store = FillInShopOptions({ StoreData = StoreData.SurfaceShop, RoomName = room.Name })
	end
	if room.StoreDataName == nil and room.ChosenRewardType == "Shop" then
		room.StoreDataName = "WorldShop"
	end
	if room.StoreDataName ~= nil then
		local storeData = StoreData[room.StoreDataName]
		if storeData ~= nil then
			room.Store = FillInShopOptions({ RoomName = roomData.Name, StoreData = storeData })
		end
	end
end

function SetupWorldShop( source, args )
	if source.StoreDataName == nil then
		return
	end
	if args.VoiceLines ~= nil then
		thread( PlayVoiceLines, args.VoiceLines, true )
	end
	SpawnStoreItemsInWorld( source, args )
	if args.ActivateUnitsByType ~= nil then
		ActivatePrePlaced( source, { LegalTypes = args.ActivateUnitsByType } )
	end
	if args.ActivateIdsByType ~= nil then
		local ids = GetInactiveIds({ Names = args.ActivateIdsByType })
		Activate({ Ids = ids })
	end
end

function CheckChallengeSwitchItemValidity( currentRun )
	-- unfortunately, too many things rely on the current store item generation flow to use anything more generic @alice
	if not currentRun or not currentRun.CurrentRoom or not currentRun.CurrentRoom.Store or not currentRun.CurrentRoom.Store.StoreOptions then
		return
	end
	if not currentRun.CurrentRoom.ChallengeSwitch then
		return
	end
	
	local hasChallengeSwitchRequirement = false
	for i, itemData in pairs( currentRun.CurrentRoom.Store.StoreOptions ) do
		if itemData then
			if itemData.Type == "Trait" then
				if TraitData[itemData.Name] and TraitData[itemData.Name].RequiredNoChallengeSwitchInRoom then
					hasChallengeSwitchRequirement = true
				end
			elseif itemData.Type == "Consumable" then
				if ConsumableData[itemData.Name] and ConsumableData[itemData.Name].RequiredNoChallengeSwitchInRoom then
					hasChallengeSwitchRequirement = true
				end
			end
		end
	end

	if hasChallengeSwitchRequirement then
		currentRun.CurrentRoom.Store.StoreOptions = FillInShopOptions({ StoreData = StoreData.RoomShop, RoomName = CurrentRun.CurrentRoom.Name }).StoreOptions
	end
end

function StartShopping( unit, delay )
	wait( delay )
	while PlayingTextLines do
		local eventData = unit.ShopEventData
		local delay = RandomFloat ( eventData.DelayMin, eventData.DelayMax )
		wait( delay )
	end
	notifyExistingWaiters( "ShopItem" )
end

function CheckHeraclesShoppingEvent( eventSource, args )
	args = args or {}
	args.NPCName = "NPC_Heracles_01"
	args.ShoppingSuccessPresentationFunction = "ShoppingSuccessPresentation"
	eventSource.HeraclesShopping = true
	CurrentRun.HeraclesShopped = true
	thread( CheckShoppingEventThread, eventSource, args )
end

function CheckNemesisShoppingEvent( eventSource, args )
	args = args or {}
	args.NPCName = "NPC_Nemesis_01"
	args.ShoppingSuccessPresentationFunction = "ShoppingSuccessNemesisPresentation"
	eventSource.NemesisShopping = true
	CurrentRun.NemesisShopped = true
	thread( CheckShoppingEventThread, eventSource, args )
end

function CheckShoppingEventThread( eventSource, args )
	if not CurrentRun.CurrentRoom.Store or IsEmpty(CurrentRun.CurrentRoom.Store.SpawnedStoreItems) then
		return
	end
	CurrentRun.ShoppingEvent = true
	local shoppingNPCId = GetInactiveIdsByType({ Name = args.NPCName })[1]
	if shoppingNPCId then
		ActivatePrePlacedUnits( nil, { Ids = { shoppingNPCId }})
		local targetShopItem = RandomInt( 1, 3 )
		CurrentRun.CurrentRoom.WatchedItemIndex = targetShopItem
		local shoppingNPC = ActiveEnemies[ shoppingNPCId ]
		if args.NPCVariantData ~= nil then
			OverwriteSelf( shoppingNPC, NPCVariantData[args.NPCVariantData] )
		end
		local eventData = shoppingNPC.ShopEventData
		local instantPurchase = false
		local delay = RandomFloat( eventData.DelayMin, eventData.DelayMax )
		if RandomChance( eventData.InstantChance ) then
			delay = 2.5
			instantPurchase = true
		elseif RandomChance( eventData.NeverChance ) then
			delay = 3600
		end
		shoppingNPC.Shopping = true
		shoppingNPC.RequiredRoomInteraction = false
		MapState.RoomRequiredObjects[shoppingNPC.ObjectId] = nil
		AngleTowardTarget({ Id = shoppingNPC.ObjectId, DestinationId = CurrentRun.CurrentRoom.Store.SpawnedStoreItems[targetShopItem].ObjectId })
		thread( StartShopping, shoppingNPC, delay )
		thread( ShoppingFidgetPresentation, shoppingNPC )
		waitUntil( "ShopItem" )
		local storeItem = CurrentRun.CurrentRoom.Store.SpawnedStoreItems[targetShopItem]
		if storeItem ~= nil then
			local worldDrop = MapState.ActiveObstacles[storeItem.ObjectId]
			if worldDrop ~= nil then
				worldDrop.BlockUse = true
			end
			ShoppingSuccessItemPresentation( worldDrop )
			Destroy({ Id = storeItem.ObjectId })
			RefreshUseButton( storeItem.ObjectId, storeItem )
			CallFunctionName( args.ShoppingSuccessPresentationFunction, shoppingNPC, { InstantPurchase = instantPurchase } )
			CurrentRun.CurrentRoom.Store.SpawnedStoreItems[targetShopItem] = nil
		else
			ShoppingFailedPresentation( shoppingNPC )
		end

		if shoppingNPC.StoreExitFunctionName then
			CallFunctionName( shoppingNPC.StoreExitFunctionName, shoppingNPC, { DelayMin = eventData.ExitDelayMin, DelayMax = eventData.ExitDelayMax, UseAnim = true } )
		end

		shoppingNPC.Shopping = false
	end
end

function SpawnStoreItemsInWorld( room, args )
	
	if room.StoreDataName ~= nil then
		local storeData = StoreData[room.StoreDataName]
		if storeData ~= nil then
			room.Store = FillInShopOptions({ RoomName = room.Name, StoreData = storeData })
		end
	end

	if room.Store ~= nil then
		local kitIds = GetIdsByType({ Name = "LootPoint" })
		table.sort( kitIds )
		room.Store.SpawnedStoreItems = {}
		local sortedList = CollapseTableAsOrderedKeyValuePairs( room.Store.StoreOptions )
		for i, kvp in ipairs( sortedList ) do
			local index = kvp.Key
			local itemData = kvp.Value
			if kitIds[index] ~= nil  then
				SpawnStoreItemInWorld( itemData, kitIds[index] )
			end
		end
	end

end

function SpawnStoreItemInWorld( itemData, kitId )
	local spawnedItem = nil
	if itemData.Name == "WeaponUpgradeDrop" then
		spawnedItem = CreateWeaponLoot({ SpawnPoint = kitId, ResourceCosts = itemData.ResourceCosts or GetProcessedValue( ConsumableData.WeaponUpgradeDrop.ResourceCosts ), DoesNotBlockExit = true, SuppressSpawnSounds = true, } )
	elseif itemData.Name =="ShopHermesUpgrade" then
		spawnedItem = CreateHermesLoot({ SpawnPoint = kitId, ResourceCosts = itemData.ResourceCosts or GetProcessedValue( ConsumableData.ShopHermesUpgrade.ResourceCosts ), DoesNotBlockExit = true, SuppressSpawnSounds = true, BoughtFromShop = true, AddBoostedAnimation = itemData.AddBoostedAnimation, BoonRaritiesOverride = itemData.BoonRaritiesOverride })
		spawnedItem.CanReceiveGift = false
		SetThingProperty({ Property = "SortBoundsScale", Value = 1.0, DestinationId = spawnedItem.ObjectId })
	elseif itemData.Name =="ShopManaUpgrade" then
		spawnedItem = CreateManaLoot({ SpawnPoint = kitId, ResourceCosts = itemData.ResourceCosts or GetProcessedValue( ConsumableData.ShopManaUpgrade.ResourceCosts ), DoesNotBlockExit = true, SuppressSpawnSounds = true, BoughtFromShop = true, AddBoostedAnimation = itemData.AddBoostedAnimation, BoonRaritiesOverride = itemData.BoonRaritiesOverride })
		spawnedItem.CanReceiveGift = false
		SetThingProperty({ Property = "SortBoundsScale", Value = 1.0, DestinationId = spawnedItem.ObjectId })
	elseif itemData.Type == "Consumable" then
		local consumablePoint = SpawnObstacle({ Name = itemData.Name, DestinationId = kitId, Group = "Standing" })
		local upgradeData =  GetRampedConsumableData( ConsumableData[itemData.Name] or LootData[itemData.Name] )
		spawnedItem = CreateConsumableItemFromData( consumablePoint, upgradeData, itemData.CostOverride )
		spawnedItem.CanDuplicate = false
		spawnedItem.CanReceiveGift = false
		ApplyConsumableItemResourceMultiplier( CurrentRun.CurrentRoom, spawnedItem )
		ExtractValues( CurrentRun.Hero, spawnedItem, spawnedItem )
	elseif itemData.Type == "Boon" then
		itemData.Args.SpawnPoint = kitId
		itemData.Args.DoesNotBlockExit = true
		itemData.Args.SuppressSpawnSounds = true
		itemData.Args.SuppressFlares = true
		spawnedItem = GiveLoot( itemData.Args )
		spawnedItem.CanReceiveGift = false
		SetThingProperty({ Property = "SortBoundsScale", Value = 1.0, DestinationId = spawnedItem.ObjectId })
	end
	if spawnedItem ~= nil then
		spawnedItem.SpawnPointId = kitId
		if not itemData.PendingShopItem then
			SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = spawnedItem.ObjectId })
			spawnedItem.UseText = spawnedItem.PurchaseText or "Shop_UseText"
			spawnedItem.IconPath = spawnedItem.TextIconPath or spawnedItem.IconPath
			table.insert( CurrentRun.CurrentRoom.Store.SpawnedStoreItems, { KitId = kitId, ObjectId = spawnedItem.ObjectId, ResourceCosts = spawnedItem.ResourceCosts} )
		else
			MapState.SurfaceShopItems = MapState.SurfaceShopItems or {}
			table.insert( MapState.SurfaceShopItems, spawnedItem.Name )
		end
			return spawnedItem

	else
		DebugPrint({Text = " Not spawned?!" .. itemData.Name})
	end
end

function UpdateCostText( object, textExists )
	textExists = textExists or false
	if object.ResourceCosts ~= nil then
		local costFontColor = Color.CostAffordable
		local costAmount = 0
		for name, amount in pairs( object.ResourceCosts) do
			if name == "Money" then
				costAmount = amount 
			end
		end
		if costAmount == 0 then
			return
		end
		if not HasResources(object.ResourceCosts) and not object.Purchased then
			costFontColor = Color.CostUnaffordable
		end
		if object.HealthCost and not object.Purchased then
			if CurrentRun.Hero.Health > object.HealthCost then
				costFontColor = Color.CostAffordableShop
			else
				costFontColor = Color.CostUnaffordable
			end
			costAmount = object.HealthCost
		end

		if textExists then
			ModifyTextBox({ Id = object.ObjectId, ColorTarget = costFontColor, ColorDuration = 0.2 })
		else
			CreateTextBox({ Id = object.ObjectId, Text = "Shop_ItemCost", TextSymbolScale = 0.6, LuaKey = "TempTextData", LuaValue = { Amount = costAmount }, FontSize = 24, OffsetY = -75, Color = costFontColor, Justification = "CENTER",
				Font="NumericP22UndergroundSCMedium",
				FontSize=36,
				ShadowColor = {0,0,0,1},
				ShadowOffset= {0,2},
				ShadowAlpha=1,
				ShadowBlur=0,
				OutlineColor={0,0,0,1},
				OutlineThickness=2,

			})
		end
	end
end

function ShowStoreScreen()

	local screen = DeepCopyTable( ScreenData.WellShop )
	if IsScreenOpen( screen.Name ) then
		return
	end

	SetPlayerInvulnerable("StoreScreenOpen")
	OnScreenOpened( screen )
	HideCombatUI( screen.Name )
	CreateScreenFromData( screen, screen.ComponentData )
	
	CurrentRun.CurrentRoom.IndexesPurchased = CurrentRun.CurrentRoom.IndexesPurchased or {}

	screen.ShopItemStartX = screen.ShopItemStartX + ScreenCenterNativeOffsetX
	screen.ShopItemStartY = screen.ShopItemStartY + ScreenCenterNativeOffsetY

	UpdateStoreOptionsDictionary()

	PlaySound({ Name = "/SFX/Menu Sounds/WellShopOpenNew" })
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedShopLines, true )

	ScreenAnchors.StoreScreen = screen
	local components = screen.Components

	local offeredWeaponUpgrades = {}

	-- Flavor Text
	local flavorTextOptions = { "WellShop_FlavorText01", "WellShop_FlavorText02", "WellShop_FlavorText03" }
	local flavorText = GetRandomValue( flavorTextOptions )
	ModifyTextBox({ Id = components.ShopFlavor.Id, Text = flavorText })

	wait(0.25)	
	CreateStoreButtons( screen )

	if not IsEmpty( CurrentRun.CurrentRoom.Store.StoreOptions ) then
		thread( PlayVoiceLines, HeroVoiceLines.WellShopUsedVoiceLines, true )
	end
	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function CreateStoreButtons( screen )

	local itemLocationStartY = screen.ShopItemStartY
	local itemLocationYSpacer = screen.ShopItemSpacerY
	local itemLocationMaxY = itemLocationStartY + 4 * itemLocationYSpacer

	local itemLocationStartX = screen.ShopItemStartX
	local itemLocationXSpacer = screen.ShopItemSpacerX
	local itemLocationMaxX = itemLocationStartX + 1 * itemLocationXSpacer

	local itemLocationX = itemLocationStartX
	local itemLocationY = itemLocationStartY

	local components = screen.Components

	local numButtons = StoreData.WorldShop.MaxOffers
	if numButtons == nil then
		numButtons = 0
		for i, groupData in pairs( StoreData.WorldShop.GroupsOf ) do
			numButtons = numButtons + groupData.Offers
		end
	end

	local firstUseable = false
	for itemIndex = 1, numButtons do
		local upgradeData = CurrentRun.CurrentRoom.Store.StoreOptions[itemIndex]

		if upgradeData ~= nil then
			if not upgradeData.Processed then
				if upgradeData.Type == "Trait" then
					upgradeData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = upgradeData.Name })
					if upgradeData.CostIncreasePerStack ~= nil then
						upgradeData.Cost = upgradeData.Cost + GetTraitCount(CurrentRun.Hero, { TraitData = upgradeData }) * upgradeData.CostIncreasePerStack
					end
					upgradeData.Type = "Trait"
					SetTraitTextData( upgradeData )
				elseif upgradeData.Type == "Consumable" then
					upgradeData = GetRampedConsumableData( ConsumableData[upgradeData.Name] )
					upgradeData.Type = "Consumable"
				elseif upgradeData.Type == "Cosmetic" then
					upgradeData = DeepCopyTable( WorldUpgradeData[upgradeData.Name] )
					upgradeData.Type = "Cosmetic"
				elseif upgradeData.Type == "Boon" and upgradeData.Args.ForceLootName then
					upgradeData = DeepCopyTable( LootData[ upgradeData.Args.ForceLootName ])
					upgradeData.ResourceCosts = DeepCopyTable( ConsumableData.RandomLoot.ResourceCosts )
				end

				local costMultiplier = 1 + ( MetaUpgradeData.ShopPricesShrineUpgrade.ChangeValue - 1 )
				costMultiplier = costMultiplier * GetTotalHeroTraitValue("StoreCostMultiplier", {IsMultiplier = true, Multiplicative = true})

				if costMultiplier ~= 1 then
					if HasResourceCost( upgradeData.ResourceCosts ) then
						for resourceName, resourceAmount in pairs(upgradeData.ResourceCosts) do		
							upgradeData.ResourceCosts[resourceName] = round( resourceAmount * costMultiplier )
						end
					end
					if upgradeData.HealthCost then
						upgradeData.HealthCost = round( upgradeData.HealthCost * costMultiplier )
					end
				end
				

				upgradeData.Processed = true
			elseif upgradeData.Type == "Trait" then
				RecalculateStoreTraitDurations( upgradeData )
			end

			CurrentRun.CurrentRoom.Store.StoreOptions[itemIndex] = upgradeData
			local tooltipData = upgradeData

			local purchaseButtonKey = "PurchaseButton"..itemIndex			
			local purchaseButton = DeepCopyTable( ScreenData.UpgradeChoice.PurchaseButton )
			purchaseButton.X = itemLocationX
			purchaseButton.Y = itemLocationY
			components[purchaseButtonKey] = CreateScreenComponent( purchaseButton )

			local highlight = ShallowCopyTable( ScreenData.UpgradeChoice.Highlight )
			highlight.X = purchaseButton.X
			highlight.Y = purchaseButton.Y
			components[purchaseButtonKey.."Highlight"] = CreateScreenComponent( highlight )
			components[purchaseButtonKey].Highlight = components[purchaseButtonKey.."Highlight"]

	
			if upgradeData.Icon ~= nil then
				local icon = DeepCopyTable( ScreenData.UpgradeChoice.Icon )
				icon.X = itemLocationX + ScreenData.UpgradeChoice.IconOffsetX
				icon.Y = itemLocationY + ScreenData.UpgradeChoice.IconOffsetY 
				icon.Animation = upgradeData.Icon
				components["Icon"..itemIndex] = CreateScreenComponent( icon )
			end
			local purchaseButtonTitleKey = "PurchaseButtonTitle"..itemIndex
			components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX, Y = itemLocationY })

			local needsQuestIcon = false
			if not GameState.TraitsTaken[upgradeData.Name] and not GameState.ItemInteractions[upgradeData.Name] and HasActiveQuestForName( upgradeData.Name ) then
				needsQuestIcon = true
			end
			if needsQuestIcon then
				components[purchaseButtonKey.."QuestIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu",
					X = itemLocationX + ScreenData.UpgradeChoice.QuestIconOffsetX - ScreenData.UpgradeChoice.ButtonOffsetX,
					Y = itemLocationY + ScreenData.UpgradeChoice.QuestIconOffsetY })
				SetAnimation({ DestinationId = components[purchaseButtonKey.."QuestIcon"].Id, Name = "QuestItemFound" })
				-- Silent toolip
				CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "TraitQuestItem", Color = Color.Transparent, LuaKey = "TooltipData", LuaValue = tooltipData })
			end

			if HeroHasTrait("ExtendedShopTrait") then
				local infinityIcon = nil
				local trait = GetHeroTrait("ExtendedShopTrait")
				if trait and trait.ValidPermanentItemsLookup[upgradeData.Name] and IsTraitActive(trait) then
					upgradeData.CloseScreenStore = upgradeData.CloseScreen
					upgradeData.CloseScreen = true
					upgradeData.MakePermanent = true
					infinityIcon = trait.PermanentItemBadgeAnimationName
				elseif upgradeData.MakePermanent then
					upgradeData.MakePermanent = false
					upgradeData.CloseScreen = upgradeData.CloseScreenStore
				end
				if infinityIcon then
					components[purchaseButtonKey.."Permafy"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu",
						X = itemLocationX + ScreenData.UpgradeChoice.QuestIconOffsetX - ScreenData.UpgradeChoice.ButtonOffsetX,
						Y = itemLocationY + ScreenData.UpgradeChoice.QuestIconOffsetY })
					SetAnimation({ DestinationId = components[purchaseButtonKey.."Permafy"].Id, Name = infinityIcon, Scale = 0.5 })
					-- Silent toolip
					-- CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "PermafyShopItem", Color = Color.Transparent, LuaKey = "TooltipData", LuaValue = tooltipData })
				end
			end
			local costString = "@GUI\\Icons\\Currency"
			local costAmount = 0
			if upgradeData.ResourceCosts then
				for name, amount in pairs( upgradeData.ResourceCosts) do
					if name == "Money" then
						costAmount = amount 
					end
				end
			end

			costString = costAmount .. " " .. costString
			local costColor = Color.CostAffordableShop
			if GetResourceAmount( "Money" ) < costAmount then
				costColor = Color.CostUnaffordable
			end

			if upgradeData.HealthCost then
				costString = upgradeData.HealthCost .. " @GUI\\Icons\\Life"
				if CurrentRun.Hero.Health > upgradeData.HealthCost then
					costColor = Color.CostAffordableShop
				else
					costColor = Color.CostUnaffordable
				end
			end
			

			local titleText = DeepCopyTable( ScreenData.UpgradeChoice.TitleText )
			titleText.Id = components[purchaseButtonTitleKey].Id
			titleText.Text = GetTraitTooltip( upgradeData )
			titleText.LuaKey = "TempTextData"
			titleText.LuaValue = upgradeData
			titleText.Color = costColor
			CreateTextBox( titleText )

			local descriptionText = DeepCopyTable( ScreenData.UpgradeChoice.DescriptionText )
			descriptionText.Id = components[purchaseButtonKey].Id
			descriptionText.Text = GetTraitTooltip( upgradeData )
			descriptionText.LuaKey = "TooltipData"
			descriptionText.LuaValue = upgradeData
			CreateTextBoxWithFormat( descriptionText )
			
			SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = ScreenData.UpgradeChoice.TooltipOffsetX })
			
			CreateTextBox(MergeTables({ Id = components[purchaseButtonTitleKey].Id, Text = costString, OffsetX = 410, OffsetY = -60, FontSize = 28, Color = costColor, Font = "P22UndergroundSCMedium", Justification = "Right" },LocalizationData.SellTraitScripts.ShopButton))

			local statLines = upgradeData.StatLines
			local statLineData = upgradeData
			if upgradeData.MakePermanent and HeroHasTrait("ExtendedShopTrait") then
				local trait = GetHeroTrait("ExtendedShopTrait")
				statLines = {"ExtendedStoreUsesRemainingDisplay1"}
				statLineData = { RemainingUses = trait.BossExtension }
			end
			if statLines then
				for lineNum, statLine in ipairs(statLines) do
					if statLine ~= "" then

						local offsetY = (lineNum - 1) * ScreenData.UpgradeChoice.LineHeight
						if statLineData.ExtraDescriptionLine then
							offsetY = offsetY + ScreenData.UpgradeChoice.LineHeight
						end

						local statLineLeft = DeepCopyTable(ScreenData.UpgradeChoice.StatLineLeft)
						statLineLeft.Id = components[purchaseButtonKey].Id
						statLineLeft.Text = statLine
						statLineLeft.OffsetY = offsetY
						statLineLeft.LuaValue = statLineData
						CreateTextBoxWithFormat( statLineLeft )

						local statLineRight = DeepCopyTable(ScreenData.UpgradeChoice.StatLineRight)
						statLineRight.Id = components[purchaseButtonKey].Id
						statLineRight.Text = statLine
						statLineRight.OffsetY = offsetY
						statLineRight.LuaValue = statLineData
						CreateTextBoxWithFormat( statLineRight )

					end
				end
			end

			local button = components[purchaseButtonKey]
			button.Screen = screen
			AttachLua({ Id = button.Id, Table = button })
			button.Data = upgradeData
			button.WeaponName = currentWeapon
			button.Index = itemIndex
			button.TitleId = components[purchaseButtonTitleKey].Id
			button.OnPressedFunctionName = "HandleStorePurchase"
			button.OnMouseOverFunctionName = "MouseOverWellShopButton"
			button.OnMouseOffFunctionName = "MouseOffWellShopButton"
			if not firstUseable then
				TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
				firstUseable = true
			end
			
			if CurrentRun.CurrentRoom.Store.Buttons == nil then
				CurrentRun.CurrentRoom.Store.Buttons = {}
			end
			table.insert(CurrentRun.CurrentRoom.Store.Buttons, components[purchaseButtonKey])
		end
		itemLocationX = itemLocationX + itemLocationXSpacer
		if itemLocationX >= itemLocationMaxX then
			itemLocationX = itemLocationStartX
			itemLocationY = itemLocationY + itemLocationYSpacer
		end
	end
	UpdateStoreReroll( screen )
end

function UpdateStoreReroll( screen )
	local components = screen.Components
	if HeroHasTrait( "PanelRerollMetaUpgrade" ) and not IsEmpty( CurrentRun.CurrentRoom.Store.StoreOptions ) then
		local increment = 0
		if CurrentRun.CurrentRoom.SpentRerolls then
			increment = CurrentRun.CurrentRoom.SpentRerolls[screen.Name] or 0
		end
		local cost = RerollCosts.Shop + increment

		local color = Color.White
		if CurrentRun.NumRerolls < cost or cost < 0 then
			color = Color.CostUnaffordable
		end

		if CurrentRun.NumRerolls < cost or cost < 0 then
			SetAlpha({ Id = screen.Components.RerollButton.Id, Fraction = 0.0, Duration = 0.2 })
		elseif cost > 0 then
			components.RerollButton.RerollFunctionName = "RerollStore"
			components.RerollButton.Cost = cost
			components.RerollButton.RerollColor = {48, 25, 83, 255}
			components.RerollButton.RerollId = screen.Name
			ModifyTextBox({ Id = components.RerollButton.Id, Text = "Boon_Reroll", LuaKey = "TempTextData", LuaValue = { Amount = cost }})

			SetAlpha({ Id = screen.Components.RerollButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = screen.Components.RerollButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
	else
		components.RerollButton.RerollFunctionName = nil
		SetAlpha({ Id = screen.Components.RerollButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
end
function DestroyStoreButtons( screen )
	local components = screen.Components
	local toDestroy = {}
	for index = 1, StoreData.RoomShop.MaxOffers do
		local destroyIndexes =
		{
			"ItemBackingSoldOut"..index,
			"PurchaseButton"..index,
			"PurchaseButton"..index.. "Highlight",
			"PurchaseButton"..index.."QuestIcon",
			"Icon"..index,
			"Backing"..index,
			"PurchaseButtonTitle"..index,
		}
		for i, indexName in pairs( destroyIndexes ) do
			if components[indexName] then
				table.insert(toDestroy, components[indexName].Id)
			end
		end
	end
	if components["RerollPanel"] then
		table.insert(toDestroy, components["RerollPanel"].Id)
	end
	Destroy({ Ids = toDestroy })
	CurrentRun.CurrentRoom.Store.Buttons = {}
end

function RecalculateStoreTraitDurations( traitData )
	local traitName = traitData.Name
	if not TraitData[traitName] then
		return
	end

	if traitData.RemainingUses ~= nil and TraitData[traitName].RemainingUses then
		traitData.RemainingUses = TraitData[traitName].RemainingUses
	end

	if not IsEmpty( CurrentRun.Hero.Traits ) and traitData.RemainingUses ~= nil then
		for i, data in pairs( GetHeroTraitValues( "TraitDurationIncrease" )) do
			if data.ValidTraits == nil or Contains( data.ValidTraits, traitName ) then
				if traitData.RemainingUses ~= nil and TraitData[traitName].RemainingUses then
					traitData.RemainingUses = TraitData[traitName].RemainingUses + data.Amount
				end
			end
		end
	end
end

function StartUpStore()
	RandomSynchronize(11)
	if CurrentRun.CurrentRoom.Store == nil then
		CurrentRun.CurrentRoom.Store = FillInShopOptions({ RoomName = CurrentRun.CurrentRoom.Name, StoreData = StoreData.RoomShop })
	end
	if TableLength( CurrentRun.CurrentRoom.Store.StoreOptions ) == 0 then
		thread( PlayVoiceLines, HeroVoiceLines.WellShopSoldOutVoiceLines, true )
	end
	ShowStoreScreen()
end

function CloseStoreScreen( screen, button )
	CurrentRun.CurrentRoom.Store.StoreOptions = CollapseTable( CurrentRun.CurrentRoom.Store.StoreOptions )
	local components = screen.Components
	local useableOffButtonIds = {}
	for index = 1, StoreData.RoomShop.MaxOffers do
		if components["PurchaseButton"..index] and components["PurchaseButton"..index].Id then
			table.insert(useableOffButtonIds, components["PurchaseButton"..index].Id)
		end
	end
	UseableOff({ Ids = useableOffButtonIds })
	OnScreenCloseStarted( screen )
	if screen.CloseAnimationName and components.ShopBackground then
		SetAnimation({ Name = screen.CloseAnimationName, DestinationId = components.ShopBackground.Id })
	end
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	CurrentRun.CurrentRoom.Store.Buttons = {}
	ScreenAnchors.StoreScreen = nil
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name, { SkipUpdateTraitSummary = true } )
	--ShowCombatUI( screen.Name )
	thread( MarkObjectiveComplete, "ShopPrompt" )
	SetPlayerVulnerable("StoreScreenOpen")

	if CurrentRun.CurrentRoom.Store.CosmeticUnlocked ~= nil then
		thread( DisplayInfoBanner, nil, {
			TitleText = "Store_CosmeticUnlocked_Title",
			SubtitleText = "Store_CosmeticUnlocked_Subtitle",
			SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = CurrentRun.CurrentRoom.Store.CosmeticUnlocked }}
		})
		CurrentRun.CurrentRoom.Store.CosmeticUnlocked = nil
	end
end

function HandleStorePurchase( screen, button )
	local upgradeData = button.Data
	
	if upgradeData.HealthCost and CurrentRun.Hero.Health <= upgradeData.HealthCost then
		Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
		CantAffordPresentation( upgradeData )
		return
	end
	
	local costAmount = 0
	if upgradeData.ResourceCosts then
		for name, amount in pairs( upgradeData.ResourceCosts) do
			if name == "Money" then
				costAmount = amount 
			end
		end
	end

	if GetResourceAmount( "Money" ) < costAmount then
		Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
		CantAffordPresentation( upgradeData )
		return
	end

	if costAmount ~= nil and costAmount > 0 and upgradeData.PurchaseRequirements ~= nil and not IsGameStateEligible( CurrentRun, upgradeData.PurchaseRequirements ) then
		CantPurchasePresentation( screen.Components["PurchaseButton".. button.Index] )
		return
	end

	StorePurchasePresentation( screen, button, upgradeData )

	CurrentRun.WellPurchases =  (CurrentRun.WellPurchases or 0) + 1

	SpendResources( upgradeData.ResourceCosts, upgradeData.Name or "WeaponUpgrade", { SkipQuestStatusCheck = true, } )
	if upgradeData.ResourceCosts ~= nil and (upgradeData.ResourceCosts.Money or 0) > 0 then
		CheckCharonPointsOwed( "HandleStorePurchase" )
	end

	local values = {}
	local purchaseIndexOffset = 0
	for i, value in pairs (CurrentRun.CurrentRoom.Store.StoreOptions) do
		if Contains( CurrentRun.CurrentRoom.IndexesPurchased, i ) then
			purchaseIndexOffset = purchaseIndexOffset + 1
			if Contains( CurrentRun.CurrentRoom.IndexesPurchased, i + purchaseIndexOffset ) then
				purchaseIndexOffset = purchaseIndexOffset + 1
			end
		end
		if value.Name == upgradeData.Name then
			table.insert(CurrentRun.CurrentRoom.IndexesPurchased, i + purchaseIndexOffset )
			table.sort( CurrentRun.CurrentRoom.IndexesPurchased )
			CurrentRun.CurrentRoom.Store.StoreOptions[i] = nil
		end
	end

	if upgradeData.Type == "Trait" then
		if upgradeData.MakePermanent and HeroHasTrait("ExtendedShopTrait") then
			local trait = GetHeroTrait("ExtendedShopTrait")
			upgradeData.UsesAsEncounters = false
			upgradeData.UsesAsRooms = false
			upgradeData.UsesAsBosses = true
			upgradeData.RemainingUses = trait.BossExtension
			upgradeData.StatLines = {"ExtendedStoreUsesRemainingDisplay1"}
			UseHeroTraitsWithValue( "BossExtension", true )
			thread( PermafyShopItemPresentation, upgradeData.Name )
		end
		AddTraitToHero({ TraitData = upgradeData, SkipQuestStatusCheck = true, })
		IncrementTableValue( GameState.ItemInteractions, upgradeData.Name )
		CheckCodexUnlock( "Items", upgradeData.Name )
	elseif upgradeData.Type == "Consumable" then
		local consumableName = upgradeData.Name
		local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing" })
		local consumable = CreateConsumableItemFromData( consumableId, upgradeData, 0 )
		consumable.CanDuplicate = false
	end

	if upgradeData.CloseScreen then
		thread( PlayVoiceLines, upgradeData.PurchasedLines, true )
		SetAnimation({ Name = "WellShopOut", DestinationId = screen.Components.ShopBackground.Id })
		CloseStoreScreen( screen, button )
		return
	end
	if upgradeData.StoreCostMultiplier then
		for index, currentUpgradeData in pairs (CurrentRun.CurrentRoom.Store.StoreOptions) do
			if currentUpgradeData and currentUpgradeData.ResourceCosts then
				for resourceName, resourceAmount in pairs(currentUpgradeData.ResourceCosts) do		
					currentUpgradeData.ResourceCosts[resourceName] = round( currentUpgradeData.ResourceCosts[resourceName] * upgradeData.StoreCostMultiplier )
				end
			end
		end
	end
	if upgradeData.ValidPermanentItemsLookup or upgradeData.StoreCostMultiplier then
		DestroyStoreButtons( screen )
		CreateStoreButtons( screen )
	end

	if screen.Components["PurchaseButton"..button.Index.."Highlight"] ~= nil then
		Destroy({ Id = screen.Components["PurchaseButton"..button.Index.."Highlight"].Id })
		screen.Components["PurchaseButton"..button.Index.."Highlight"] = nil
	end
	if screen.Components["PurchaseButton"..button.Index.."QuestIcon"] ~= nil then
		Destroy({ Id = screen.Components["PurchaseButton"..button.Index.."QuestIcon"].Id })
		screen.Components["PurchaseButton"..button.Index.."QuestIcon"] = nil
	end
	if screen.Components["PurchaseButton"..button.Index.."Permafy"] ~= nil then
		Destroy({ Id = screen.Components["PurchaseButton"..button.Index.."Permafy"].Id })
		screen.Components["PurchaseButton"..button.Index.."Permafy"] = nil
	end

	Destroy({ Id = screen.Components["PurchaseButtonTitle".. button.Index].Id })
	screen.Components["PurchaseButtonTitle".. button.Index] = nil

	--CreateAnimation({ Name = "BoonSlotPurchase", DestinationId = screen.Components["Backing".. button.Index].Id, OffsetX = -380 })

	Destroy({ Id = screen.Components["PurchaseButton".. button.Index].Id })
	screen.Components["PurchaseButton".. button.Index] = nil

	if screen.Components["Icon".. button.Index] then
		Destroy({ Id = screen.Components["Icon".. button.Index].Id })
		screen.Components["Icon".. button.Index] = nil
	end

	thread( PlayVoiceLines, upgradeData.PurchasedLines, true )

	for i, button in pairs(CurrentRun.CurrentRoom.Store.Buttons) do
		UpdateCostButton( button )
	end
	UpdateStoreReroll( screen )
end


function UpdateCostButton(button)
	if button == nil then
		return
	end

	local upgradeData = button.Data
	local costColor = Color.CostAffordableShop
	if not IsEmpty( upgradeData.ResourceCosts ) then
		local costAmount = 0
		for name, amount in pairs( upgradeData.ResourceCosts) do
			if name == "Money" then
				costAmount = amount 
			end
		end

		if GetResourceAmount( "Money" ) < costAmount then
			costColor = Color.CostUnaffordable
		end
	end
	if upgradeData.HealthCost then
		if CurrentRun.Hero.Health > upgradeData.HealthCost then
			costColor = Color.CostAffordableShop
		else
			costColor = Color.CostUnaffordable
		end
	end
	ModifyTextBox({ Id = button.TitleId, Color = costColor })
	if button.CostId then
		ModifyTextBox({ Id = button.CostId, Color = costColor })
	end
end

function UnwrapRandomLoot( spawnId )
	AddInputBlock({ Name = "RandomLoot" })
	RandomSynchronize()
	InvalidateCheckpoint()
	local obstacleId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = spawnId })
	local reward = GiveLoot({ SpawnPoint = obstacleId }) -- Debug: , ForceLootName = "HestiaUpgrade" })
	reward.BoughtFromShop = true
	reward.WasRandomLoot = true
	UseableOff({ Id = reward.ObjectId })
	UnwrapLootPresentation( reward )
	Destroy({ Id = obstacleId })
	wait(0.7)
	UseableOn({ Id = reward.ObjectId })
	SetInteractProperty({ DestinationId = reward.ObjectId, Property = "AutoActivate", Value = true })
	SetInteractProperty({ DestinationId = reward.ObjectId, Property = "Distance", Value = 1000 })

	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })

	RemoveInputBlock({ Name = "RandomLoot" })
	HideUseButton( reward.ObjectId, reward, 0 )
end

function AwardRandomStoreItem( args )
	local options = {}
	for i, traitName in pairs( args.Traits ) do
		if TraitData[traitName] and IsGameStateEligible( CurrentRun, TraitData[traitName]) then
			table.insert( options, { Name = traitName, Type = "Trait" })
		end
	end
	for i, consumableName in pairs( args.Consumables ) do
		if ConsumableData[consumableName] and StoreItemEligible( CurrentRun, ConsumableData[consumableName])
			and ( ConsumableData[consumableName].PurchaseRequirements == nil or IsGameStateEligible( ConsumableData[consumableName].PurchaseRequirements )) then

			table.insert( options, { Name = consumableName, Type = "Consumable" })
		end
	end
	if IsEmpty( options ) then
		return
	end

	local randomItem = GetRandomValue( options )
	if randomItem.Type == "Trait" then
		AddTraitToHero({TraitName = randomItem.Name})
		local traitData = GetHeroTrait( randomItem.Name )
		if traitData.StoreCostMultiplier then
			for index, currentUpgradeData in pairs (CurrentRun.CurrentRoom.Store.StoreOptions) do
				if currentUpgradeData and currentUpgradeData.ResourceCosts then
					for resourceName, resourceAmount in pairs(currentUpgradeData.ResourceCosts) do		
						currentUpgradeData.ResourceCosts[resourceName] = round( currentUpgradeData.ResourceCosts[resourceName] * traitData.StoreCostMultiplier )
					end
				end
			end
		end
	elseif randomItem.Type == "Consumable" then
		local consumableName = randomItem.Name
		local playerId = GetIdsByType({ Name = "_PlayerUnit" })
		local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = playerId, Group = "Standing" })
		local consumable = CreateConsumableItem( consumableId, consumableName, 0 )
		consumable.IgnorePurchase = true
		consumable.CanDuplicate = false
		if consumable.AddMaxHealthArgs then
			consumable.AddMaxHealthArgs.Silent = true
		end
	end

	thread( RandomStoreItemPresentation, randomItem )

end

function GiveRandomTemporaryKeepsake( args )
	local validTraits = {}

	for i, traitName in pairs( args.Traits ) do
		if IsKeepsakeUnlocked( traitName ) and GameState.LastAwardTrait ~= traitName then
			DebugPrint({Text = " valid traits " .. traitName })
			table.insert( validTraits, traitName )
		end
	end
	local pickedTraitName = GetRandomValue( validTraits )
	local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = pickedTraitName, Rarity = GetRarityKey(GetKeepsakeLevel( pickedTraitName ))})
	traitData.RemainingUses = 3
	traitData.UsesAsEncounters = true
	traitData.Slot = nil
	traitData.LargeIconOverride = traitData.Icon
	traitData.CustomName = "TemporaryKeepsake"
	traitData.CustomTitle = "TemporaryKeepsake"
	AddTraitToHero({ TraitData = traitData })
end

function MouseOverWellShopButton( component )
	local screen = component.Screen
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	SetAnimation({ DestinationId = component.Highlight.Id, Name = "BoonSlotHighlight" })
end

function MouseOffWellShopButton( component )
	local screen = component.Screen
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAnimation({ DestinationId = component.Highlight.Id, Name = "BoonHighlightOut" })
end

function UpdateStoreOptionsDictionary()
	CurrentRun.CurrentRoom.StoreOptionsDictionary = {}
	CurrentRun.CurrentRoom.StoreOptionsAffordableDictionary = {}
	for i, storeOption in pairs( CurrentRun.CurrentRoom.Store.StoreOptions ) do
		CurrentRun.CurrentRoom.StoreOptionsDictionary[storeOption.Name] = true
		if HasResources( storeOption.ResourceCosts ) then
			CurrentRun.CurrentRoom.StoreOptionsAffordableDictionary[storeOption.Name] = true
		end
	end
end