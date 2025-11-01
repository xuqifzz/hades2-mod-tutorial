
function ShowSurfaceShopScreen( openedFrom )

	local screen = DeepCopyTable( ScreenData.SurfaceShop )
	if IsScreenOpen( screen.Name ) then
		return
	end

	screen.OpenedFrom = openedFrom
	AltAspectRatioFramesShow()
	
	killTaggedThreads( CombatUI.HideThreadName )
	SetPlayerInvulnerable( screen.Name )
	OnScreenOpened( screen )
	HideCombatUI( screen.Name, screen.TraitTrayArgs )
	CreateScreenFromData( screen, screen.ComponentData )
	screen.OnCloseItems = {}

	screen.ShopItemStartX = screen.ShopItemStartX + ScreenCenterNativeOffsetX
	screen.ShopItemStartY = screen.ShopItemStartY + ScreenCenterNativeOffsetY

	-- @ for testing specific items, remove the 'if'
	if IsEmpty( CurrentRun.CurrentRoom.Store ) then
		CurrentRun.CurrentRoom.Store = FillInShopOptions({ StoreData = StoreData.SurfaceShop, RoomName = CurrentRun.CurrentRoom.Name })
	end

	UpdateStoreOptionsDictionary()
	
	if TableLength( CurrentRun.CurrentRoom.Store.StoreOptions ) == 0 then
		thread( PlayVoiceLines, HeroVoiceLines.WellShopSoldOutVoiceLines, true )
	end
	local components = screen.Components

	local offeredWeaponUpgrades = {}

	wait(0.02)
	CreateSurfaceShopButtons( screen )
	
	if not IsEmpty( CurrentRun.CurrentRoom.Store.StoreOptions ) then
		thread( PlayVoiceLines, HeroVoiceLines.SurfaceShopUsedVoiceLines, true )
	end
	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function GetSurfaceShopText( upgradeData, args)
	args = args or {}
	if upgradeData.Type == "Boon" then
		return LootData[upgradeData.Name].SurfaceShopText or upgradeData.Name
	else
		if args.ForTraitTray then
			return upgradeData.SurfaceShopTraitText or upgradeData.SurfaceShopText or upgradeData.Name
		else
			return upgradeData.SurfaceShopText or upgradeData.Name
		end
	end
end
function GetSurfaceShopIcon( upgradeData )
	if upgradeData.Type == "Boon" then
		return LootData[upgradeData.Name].SurfaceShopIcon
	else
		return upgradeData.SurfaceShopIcon or upgradeData.Name
	end
end

function CreateSurfaceShopButtons( screen )

	local itemLocationStartY = screen.ShopItemStartY
	local itemLocationYSpacer = screen.ShopItemSpacerY
	local itemLocationMaxY = itemLocationStartY + 4 * itemLocationYSpacer

	local itemLocationStartX = screen.ShopItemStartX
	local itemLocationXSpacer = screen.ShopItemSpacerX
	local itemLocationMaxX = itemLocationStartX + 1 * itemLocationXSpacer

	local itemLocationTextBoxOffset = 380

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
	
	RandomSynchronize( GetRunDepth( CurrentRun ) )
	local firstUseable = false
	for itemIndex = 1, numButtons do
		local upgradeData = CurrentRun.CurrentRoom.Store.StoreOptions[itemIndex]
		if upgradeData ~= nil then
			if not upgradeData.Processed then
				if upgradeData.Type == "Consumable" then
					if ConsumableData[upgradeData.Name ] then
						local purchaseRequirements = nil
						if upgradeData.ReplacePurchaseRequirements ~= nil then
							purchaseRequirements = ShallowCopyTable( upgradeData.ReplacePurchaseRequirements )
						end
						upgradeData = GetRampedConsumableData( ConsumableData[upgradeData.Name] )
						if purchaseRequirements then
							upgradeData.PurchaseRequirements = purchaseRequirements
						end
					elseif LootData[ upgradeData.Name ] then
						upgradeData = GetRampedConsumableData( LootData[upgradeData.Name] )
					end
					upgradeData.Type = "Consumable"
				elseif upgradeData.Type == "Boon" and upgradeData.Args.ForceLootName then
					upgradeData.ResourceCosts = GetRampedConsumableData( ConsumableData.RandomLoot ).ResourceCosts
					upgradeData.Type = "Boon"
					upgradeData.Name = upgradeData.Args.ForceLootName
				end
				
				upgradeData.RoomDelay = RandomInt( SurfaceShopData.DelayMin, SurfaceShopData.DelayMax )
				local delayCostMultiplier = SurfaceShopData.DelayPriceDiscount[upgradeData.RoomDelay]
				if not delayCostMultiplier then
					delayCostMultiplier = SurfaceShopData.DelayPriceDiscount[#SurfaceShopData.DelayPriceDiscount]
				end
				upgradeData.SpeedUpResourceCosts = {}
				upgradeData.BaseResourceCosts = {}
				local costMultiplier = GetShopCostMultiplier()
				for resourceName, resourceAmount in pairs(upgradeData.ResourceCosts) do
					local baseCost = round( resourceAmount * costMultiplier )
					local penaltyCost = round( resourceAmount * costMultiplier * SurfaceShopData.ImpatienceMultiplier )
					upgradeData.BaseResourceCosts[resourceName] = resourceAmount
					upgradeData.ResourceCosts[resourceName] = round( baseCost * delayCostMultiplier )
					upgradeData.SpeedUpResourceCosts[resourceName] = (penaltyCost - round( baseCost * delayCostMultiplier ))
				end
				
				
				upgradeData.Processed = true
			end

			CurrentRun.CurrentRoom.Store.StoreOptions[itemIndex] = upgradeData
			local tooltipData = upgradeData

			local surfaceShopIcon = GetSurfaceShopIcon( upgradeData )
			local icon = nil
			if surfaceShopIcon ~= nil then
				icon = DeepCopyTable( ScreenData.UpgradeChoice.Icon )
				icon.X = itemLocationX + ScreenData.UpgradeChoice.IconOffsetX
				icon.Y = itemLocationY + ScreenData.UpgradeChoice.IconOffsetY
				icon.Animation = surfaceShopIcon
				icon.Alpha = 0.0
				icon.AlphaTarget = 1.0
				icon.AlphaTargetDuration = 0.2

				local iconBackingKey = "IconBacking"..itemIndex
				components[iconBackingKey] = CreateScreenComponent({ Name = "BlankObstacle",
					Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2,
					X = icon.X + screen.IconBackingOffsetX, Y = icon.Y + screen.IconBackingOffsetY,
					Group = "Combat_Menu", Animation = "SurfaceShopIconBacking"
				})
			end


			local purchaseButtonKey = "PurchaseButton"..itemIndex
			local purchaseButton = DeepCopyTable( ScreenData.UpgradeChoice.PurchaseButton )
			purchaseButton.X = itemLocationX
			purchaseButton.Y = itemLocationY
			--purchaseButton.Alpha = 0.0
			--purchaseButton.AlphaTarget = 1.0
			--purchaseButton.AlphaTargetDuration = 0.2
			components[purchaseButtonKey] = CreateScreenComponent( purchaseButton )

			local highlight = ShallowCopyTable( ScreenData.UpgradeChoice.Highlight )
			highlight.X = purchaseButton.X
			highlight.Y = purchaseButton.Y
			components[purchaseButtonKey.."Highlight"] = CreateScreenComponent( highlight )
			components[purchaseButtonKey].Highlight = components[purchaseButtonKey.."Highlight"]

			if surfaceShopIcon ~= nil then				
				components["Icon"..itemIndex] = CreateScreenComponent( icon )
			end

			local iconKey = "HermesSpeedUp"..itemIndex
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX + 457, Y = itemLocationY - 50, Group = "Combat_Menu" })
				
			if upgradeData.Purchased then
				SetAnimation({ DestinationId = components[iconKey].Id , Name = "SurfaceShopBuyNowSticker" })
			end

			local itemBackingKey = "Backing"..itemIndex
			components[itemBackingKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX + itemLocationTextBoxOffset, Y = itemLocationY })

			local costString = "@GUI\\Icons\\Currency"
			local targetResourceCosts = upgradeData.ResourceCosts
			if upgradeData.Purchased then
				targetResourceCosts = upgradeData.SpeedUpResourceCosts
			end
			if upgradeData.ResourceCosts then 
				local costAmount = GetResourceCost( targetResourceCosts, "Money" )
				costString = costAmount .. " " .. costString
			end

			local costColor = Color.CostAffordableShop
			if not HasResources( targetResourceCosts ) then
				costColor = Color.CostUnaffordable
			end
			local titleColor = costColor
			if not CurrentRun.CurrentRoom.FirstPurchase and HasHeroTraitValue("FirstPurchaseDiscount") and ( costColor == Color.CostAffordableShop ) then
				costColor = Color.CostAffordableDiscount
			end
			local button = components[purchaseButtonKey]
			button.Screen = screen
			AttachLua({ Id = button.Id, Table = button })
			button.OnMouseOverFunctionName = "MouseOverSurfaceShopButton"
			button.OnMouseOffFunctionName = "MouseOffSurfaceShopButton"
			button.OnPressedFunctionName = "HandleSurfaceShopAction"
			if not firstUseable then
				TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
				firstUseable = true
			end

			local purchaseButtonCostKey = "PurchaseButtonCost"..itemIndex
			components[purchaseButtonCostKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })
			local costText = DeepCopyTable( ScreenData.UpgradeChoice.CostText )
			costText.Text = costString
			costText.Color = costColor
			costText.Id = components[purchaseButtonCostKey].Id
			CreateTextBox( costText )

			local purchaseButtonTitleKey = "PurchaseButtonTitle"..itemIndex
			components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX, Y = itemLocationY })
			local titleText = DeepCopyTable( ScreenData.UpgradeChoice.TitleText )
			titleText.Id = components[purchaseButtonTitleKey].Id
			titleText.Text = GetSurfaceShopText( upgradeData )
			titleText.LuaKey = "TempTextData"
			titleText.LuaValue = upgradeData
			titleText.Color = titleColor
			CreateTextBox( titleText )

			local descriptionText = DeepCopyTable( ScreenData.UpgradeChoice.DescriptionText )
			descriptionText.Id = components[purchaseButtonKey].Id
			descriptionText.Text = GetSurfaceShopText( upgradeData )
			descriptionText.LuaKey = "TooltipData"
			descriptionText.LuaValue = upgradeData
			CreateTextBoxWithFormat( descriptionText )

			SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = ScreenData.UpgradeChoice.TooltipOffsetX })
			
			local statLines = upgradeData.StatLines
			local statLineData = upgradeData
			if upgradeData.CustomStatLinesWithShrineUpgrade ~= nil and GetNumShrineUpgrades( upgradeData.CustomStatLinesWithShrineUpgrade.ShrineUpgradeName ) > 0 then
				statLines = upgradeData.CustomStatLinesWithShrineUpgrade.StatLines
			end
			if statLines then
				for lineNum, statLine in ipairs(statLines) do
					if statLine ~= "" then

						local offsetY = (lineNum - 1) * ScreenData.UpgradeChoice.LineHeight

						local statLineLeft = DeepCopyTable(ScreenData.UpgradeChoice.StatLineLeft)
						statLineLeft.Id = components[purchaseButtonKey].Id
						statLineLeft.Text = statLine
						statLineLeft.OffsetY = offsetY
						statLineLeft.LuaValue = statLineData
						statLineLeft.AppendToId = descriptionText.Id
						CreateTextBoxWithFormat( statLineLeft )

						local statLineRight = DeepCopyTable(ScreenData.UpgradeChoice.StatLineRight)
						statLineRight.Id = components[purchaseButtonKey].Id
						statLineRight.Text = statLine
						statLineRight.OffsetY = offsetY
						statLineRight.AppendToId = descriptionText.Id
						statLineRight.LuaValue = statLineData
						CreateTextBoxWithFormat( statLineRight )

					end
				end
			end

			local purchaseButtonDeliveryKey = "PurchaseButtonDelivery"..itemIndex
			components[purchaseButtonDeliveryKey ] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })
			
			local deliveryDuration = "PendingDeliveryDuration"
			if upgradeData.Purchased then
				deliveryDuration = "SpeedUpDelivery"
			end
			CreateTextBox({ Id = components[purchaseButtonDeliveryKey].Id, Text = deliveryDuration,
				FontSize = 18,
				OffsetX = -245, OffsetY = 80,
				Width = 720,
				Color = Color.White,
				Font = "LatoMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				VerticalJustification = "BOTTOM",
				LuaKey = "TempTextData",
				LuaValue = { Delay = upgradeData.RoomDelay }
			})

			components[purchaseButtonKey].Data = upgradeData
			components[purchaseButtonKey].WeaponName = currentWeapon
			components[purchaseButtonKey].Index = itemIndex
			components[purchaseButtonKey].TitleId = components[purchaseButtonTitleKey].Id
			components[purchaseButtonKey].CostId = components[purchaseButtonCostKey].Id

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

end


function HandleSurfaceShopAction( screen, button )
	local components = screen.Components
	local upgradeData = button.Data
	local costAmount = 0
	local speedUpDelivery = false
	local itemData = nil
	local itemIndex = nil
	for i, value in pairs (CurrentRun.CurrentRoom.Store.StoreOptions) do
		if value.Name == upgradeData.Name then
			itemData = value	
			itemIndex = i
			if value.Purchased then
				speedUpDelivery = true
			end
		end
	end

	if speedUpDelivery then
		if not HasResources( upgradeData.SpeedUpResourceCosts ) then
			Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
			CantAffordPresentation( upgradeData )
			return
		end
	else
		if not HasResources( upgradeData.ResourceCosts ) then
			Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
			CantAffordPresentation( upgradeData )
			return
		else
			itemData.Purchased = true
			button.Purchased = true
		end
	end

	if upgradeData.PurchaseRequirements ~= nil and not IsGameStateEligible( upgradeData, upgradeData.PurchaseRequirements ) then
		CantPurchasePresentation( screen.Components["PurchaseButton".. button.Index] )
		return
	end
	local wasFirstPurchase = not CurrentRun.CurrentRoom.FirstPurchase and HasHeroTraitValue("FirstPurchaseDiscount")
	CurrentRun.CurrentRoom.FirstPurchase = true
	CurrentRun.SurfaceShopPurchases =  (CurrentRun.SurfaceShopPurchases or 0) + 1
	GameState.SurfaceShopPurchases = (GameState.SurfaceShopPurchases or 0) + 1


	if speedUpDelivery then
		SpendResources( upgradeData.SpeedUpResourceCosts, upgradeData.Name or "WeaponUpgrade" )
		CurrentRun.CurrentRoom.Store.StoreOptions[itemIndex] = nil
		table.insert( screen.OnCloseItems, upgradeData.Name )
		ModifyTextBox({ Id = screen.Components.SelectButton.Id, Text = " " })
	else
		ModifyTextBox({ Id = screen.Components.SelectButton.Id, Text = "Menu_Rush" })
		SpendResources( upgradeData.ResourceCosts, upgradeData.Name or "WeaponUpgrade" )
	end

	if wasFirstPurchase then

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
				local delayCostMultiplier = SurfaceShopData.DelayPriceDiscount[upgradeData.RoomDelay]
				if not delayCostMultiplier then
					delayCostMultiplier = SurfaceShopData.DelayPriceDiscount[#SurfaceShopData.DelayPriceDiscount]
				
				end
				local costMultiplier = GetShopCostMultiplier()
				for resourceName, resourceAmount in pairs(upgradeData.BaseResourceCosts) do
					local baseCost = round( resourceAmount * costMultiplier )
					local penaltyCost = round( resourceAmount * costMultiplier * SurfaceShopData.ImpatienceMultiplier )
					upgradeData.ResourceCosts[resourceName] = round( baseCost * delayCostMultiplier )
					upgradeData.SpeedUpResourceCosts[resourceName] = (penaltyCost - round( baseCost * delayCostMultiplier ))
				end
				
				local purchaseButtonKey = "PurchaseButton"..itemIndex
				components[purchaseButtonKey].Data = upgradeData

				local costString = "@GUI\\Icons\\Currency"
				local targetResourceCosts = upgradeData.ResourceCosts
				if upgradeData.Purchased then
					targetResourceCosts = upgradeData.SpeedUpResourceCosts
				end
				if upgradeData.ResourceCosts then 
					local costAmount = GetResourceCost( targetResourceCosts, "Money" )
					costString = costAmount .. " " .. costString
				end
				ModifyTextBox({ Id = screen.Components[purchaseButtonKey].CostId, Text = costString })		
			end
		end
	end

	StorePurchasePresentation( screen, button, upgradeData, speedUpDelivery )

	if speedUpDelivery then
		if screen.Components["PurchaseButton"..button.Index.."QuestIcon"] ~= nil then
			Destroy({ Id = screen.Components["PurchaseButton"..button.Index.."QuestIcon"].Id })
			screen.Components["PurchaseButton"..button.Index.."QuestIcon"] = nil
		end

		Destroy({ Id = screen.Components["PurchaseButtonTitle".. button.Index].Id })
		screen.Components["PurchaseButtonTitle".. button.Index] = nil

		CreateAnimation({ Name = "BoonSlotPurchase", DestinationId = screen.Components["Backing".. button.Index].Id, OffsetX = -380 })

		Destroy({ Id = screen.Components["PurchaseButton".. button.Index].Id })
		screen.Components["PurchaseButton".. button.Index] = nil

		Destroy({ Id = screen.Components["PurchaseButton"..button.Index.."Highlight"].Id })
		screen.Components["PurchaseButton"..button.Index.."Highlight"] = nil

		Destroy({ Id = screen.Components["IconBacking".. button.Index].Id })
		screen.Components["IconBacking".. button.Index] = nil

		Destroy({ Id = screen.Components["Icon".. button.Index].Id })
		screen.Components["Icon".. button.Index] = nil

		Destroy({ Id = screen.Components["PurchaseButtonDelivery" .. button.Index].Id })
		screen.Components["PurchaseButtonDelivery" .. button.Index] = nil

		Destroy({ Id = screen.Components["PurchaseButtonCost" .. button.Index].Id })
		screen.Components["PurchaseButtonCost" .. button.Index] = nil

		Destroy({ Id = screen.Components["HermesSpeedUp" .. button.Index].Id })
		screen.Components["HermesSpeedUp" .. button.Index] = nil

		local excludeNames = { itemData.Name }
		if not CurrentRun.CurrentRoom.FirstSpeedUpPurchase and HasHeroTraitValue("FirstPurchaseDiscount") then
			for _, value in pairs(CurrentRun.CurrentRoom.Store.StoreOptions) do
				if value and value.Name then
					table.insert(excludeNames, value.Name)
				end
			end
			local rerollSurfaceData = DeepCopyTable( StoreData.SurfaceShop )
			for i, data in pairs(rerollSurfaceData.GroupsOf) do
				if data.Offers > 1 then
					data.Offers = 1
				end
			end
			local newOptions = FillInShopOptions({ StoreData = rerollSurfaceData, RoomName = CurrentRun.CurrentRoom.Name, ExclusionNames = excludeNames  }).StoreOptions
			local targetIndex = button.Index 
			if not IsEmpty(newOptions) and button.Index == 3 and newOptions[2] then
				-- The Surface shop has 2 slots that are pulled from the same pool. This catches the case the exclusions leave only one item in those two slots
				targetIndex = 2
			end
			if IsEmpty(newOptions) or not newOptions[ targetIndex ] then
				targetIndex = button.Index
				newOptions = FillInShopOptions({ StoreData = StoreData.SurfaceShop, RoomName = CurrentRun.CurrentRoom.Name }).StoreOptions
			end
			CurrentRun.CurrentRoom.Store.StoreOptions[ button.Index ] = newOptions[ targetIndex ]
			CurrentRun.CurrentRoom.FirstSpeedUpPurchase = true
			InvalidateCheckpoint()
		end
		CloseSurfaceShopScreen( screen, button  )
	else
		local shopTrait = DeepCopyTable(TraitData.StorePendingDeliveryItem)
		shopTrait.RemainingUses = itemData.RoomDelay 
		shopTrait.OnExpire = { SpawnShopItem = DeepCopyTable( itemData  ) }
		if shopTrait.OnExpire.SpawnShopItem.Args then
			shopTrait.OnExpire.SpawnShopItem.Args.ResourceCosts = { Money = 0 }
		else
			shopTrait.OnExpire.SpawnShopItem.ResourceCosts = { Money = 0 }
			shopTrait.OnExpire.SpawnShopItem.CostOverride = 0
		end
		shopTrait.OnExpire.SpawnShopItem.PendingShopItem = true
		shopTrait.AcquiredDepth = CurrentRun.RunDepthCache
		shopTrait.ShopItemName = itemData.Name 
		shopTrait.ItemDisplayName = GetSurfaceShopText(itemData, {ForTraitTray = true })
		if itemData.Name == "SpellDrop" then
			CurrentRun.PendingSpellDrop = true
		end
		AddTraitToHero({ TraitData =  shopTrait, SkipUIUpdate = true })

		ModifyTextBox({ Id = screen.Components["PurchaseButtonDelivery" .. button.Index].Id, Text = "SpeedUpDelivery"})

		local costString = "@GUI\\Icons\\Currency"
		if upgradeData.ResourceCosts then 
			costAmount = GetResourceCost( upgradeData.SpeedUpResourceCosts, "Money")
			costString = costAmount .. " " .. costString
		end

		SwitchToSpeedupPresentation( screen.Components["PurchaseButtonDelivery" .. button.Index].Id )
		SetAnimation({ DestinationId = screen.Components["HermesSpeedUp".. button.Index].Id , Name = "SurfaceShopBuyNowSticker" })
		ModifyTextBox({ Id = screen.Components["PurchaseButtonCost"..button.Index].Id, Text = costString })
	end
	UpdateHeroTraitDictionary()
	thread( PlayVoiceLines, upgradeData.PurchasedLines, true )
	for i, button in pairs(CurrentRun.CurrentRoom.Store.Buttons) do

		if button.Purchased then
			UpdateCostButton( button, button.Data.SpeedUpResourceCosts )
		else
			UpdateCostButton( button )
		end
	end
end


function CloseSurfaceShopScreen( screen, button )
	local closeItems = DeepCopyTable( screen.OnCloseItems )
	AddInteractBlock( screen.OpenedFrom, "CloseSurfaceShopScreen" )
	CloseStoreScreen( screen, button )
	
	local startIndex = 1
	for s, name in pairs( closeItems ) do
		local condemnedTrait = nil
		if not IsEmpty( CurrentRun.Hero.TraitDictionary.StorePendingDeliveryItem ) then
			for i, trait in pairs( CurrentRun.Hero.TraitDictionary.StorePendingDeliveryItem ) do
				if trait.AcquiredDepth == CurrentRun.RunDepthCache and trait.ShopItemName == name then
					local spawnPointId = SelectSurfaceItemSpawnPoint()
					local rewardItem = SpawnStoreItemInWorld( trait.OnExpire.SpawnShopItem, spawnPointId )
					if rewardItem ~= nil then
						rewardItem.BlockBoughtTextLines = true
					end
					thread( SurfaceShopItemSameRoomPresentation, spawnPointId )
					condemnedTrait = trait
					break
				end
			end
			RemoveTraitData( CurrentRun.Hero, condemnedTrait, { SkipExpire = true })
		end
	end
	wait( 0.1 )
	RemoveInteractBlock( screen.OpenedFrom, "CloseSurfaceShopScreen" )
end

function LoadResourcesForPendingDeliveryItem( unit, args, contextArgs, trait )
	if not trait or not trait.ShopItemName then
		return
	end
	local itemData = ConsumableData[trait.ShopItemName] or LootData[trait.ShopItemName]
	if itemData ~= nil then
		if itemData.SpeakerName ~= nil then
			LoadVoiceBanks( itemData.SpeakerName )
		end
		if itemData.LoadPackages ~= nil then
			LoadPackages({ Names = itemData.LoadPackages })
		end
	end

end

function MouseOverSurfaceShopButton( component )
	local screen = component.Screen
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	SetAnimation({ DestinationId = component.Highlight.Id, Name = "BoonSlotHighlight" })
	if component.Data.Purchased then
		ModifyTextBox({ Id = screen.Components.SelectButton.Id, Text = "Menu_Rush" })
	else
		ModifyTextBox({ Id = screen.Components.SelectButton.Id, Text = "Menu_Buy" })
	end
end

function MouseOffSurfaceShopButton( component )
	local screen = component.Screen
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAnimation({ DestinationId = component.Highlight.Id, Name = "BoonHighlightOut" })
	ModifyTextBox({ Id = screen.Components.SelectButton.Id, Text = " " })
end

function SelectSurfaceItemSpawnPoint()
	if MapState.SurfaceItemSpawnPoints == nil then
		MapState.SurfaceItemSpawnPoints = {}
		for i, id in pairs( GetIds({ Name = "SpawnPoints" }) ) do
			MapState.SurfaceItemSpawnPoints[id] = true
		end
		for i, id in pairs( GetIdsByType({ Name = "LootPoint" }) ) do
			MapState.SurfaceItemSpawnPoints[id] = true
		end
		for i, id in pairs( GetIdsByType({ Name = "FamiliarPoint" }) ) do
			MapState.SurfaceItemSpawnPoints[id] = true
		end
		for i, id in pairs( GetIds({ Name = "AltRewardSpawnPoints" }) ) do
			MapState.SurfaceItemSpawnPoints[id] = true
		end
	end
	for id, reward in pairs( MapState.RewardPointsUsed ) do
		MapState.SurfaceItemSpawnPoints[id] = nil
	end
	if IsEmpty( MapState.SurfaceItemSpawnPoints ) then
		return CurrentRun.Hero.ObjectId
	end
	local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetAllKeys( MapState.SurfaceItemSpawnPoints ) })	
	if spawnPointId <= 0 then
		return CurrentRun.Hero.ObjectId
	end
	MapState.SurfaceItemSpawnPoints[spawnPointId] = nil
	return spawnPointId
end