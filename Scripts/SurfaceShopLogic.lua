
function ShowSurfaceShopScreen()

	local screen = DeepCopyTable( ScreenData.SurfaceShop )
	if IsScreenOpen( screen.Name ) then
		return
	end

	SetPlayerInvulnerable("StoreScreenOpen")
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	screen.OnCloseItems = {}

	screen.ShopItemStartX = screen.ShopItemStartX + ScreenCenterNativeOffsetX
	screen.ShopItemStartY = screen.ShopItemStartY + ScreenCenterNativeOffsetY

	if IsEmpty( CurrentRun.CurrentRoom.Store ) then
		CurrentRun.CurrentRoom.Store = FillInShopOptions({ StoreData = StoreData.SurfaceShop, RoomName = CurrentRun.CurrentRoom.Name })
	end

	UpdateStoreOptionsDictionary()

	local components = screen.Components

	local offeredWeaponUpgrades = {}
	
	local flavorTextOptions = { "SurfaceShop_FlavorText01" }
	local flavorText = GetRandomValue( flavorTextOptions )
	ModifyTextBox({ Id = components.ShopFlavor.Id, Text = flavorText })

	wait(0.25)
	CreateSurfaceShopButtons( screen )
	
	if not IsEmpty( CurrentRun.CurrentRoom.Store.StoreOptions ) then
		thread( PlayVoiceLines, HeroVoiceLines.SurfaceShopUsedVoiceLines, true )
	end
	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
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

	local firstUseable = false
	for itemIndex = 1, numButtons do
		local upgradeData = CurrentRun.CurrentRoom.Store.StoreOptions[itemIndex]
		
		if upgradeData ~= nil then
			if not upgradeData.Processed then
				if upgradeData.Type == "Consumable" then
					if ConsumableData[upgradeData.Name ] then
						upgradeData = GetRampedConsumableData( ConsumableData[upgradeData.Name] )
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
				local costMultiplier = 1 + ( MetaUpgradeData.ShopPricesShrineUpgrade.ChangeValue - 1 )
				costMultiplier = costMultiplier * GetTotalHeroTraitValue("StoreCostMultiplier", {IsMultiplier = true, Multiplicative = true})
				for resourceName, resourceAmount in pairs(upgradeData.ResourceCosts) do
					local baseCost = round( resourceAmount * costMultiplier )
					local penaltyCost = round( resourceAmount * costMultiplier * SurfaceShopData.ImpatienceMultiplier )
					upgradeData.ResourceCosts[resourceName] = round( baseCost * delayCostMultiplier )
					upgradeData.SpeedUpResourceCosts[resourceName] = (penaltyCost - round( baseCost * delayCostMultiplier ))
				end
				
				
				upgradeData.Processed = true
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

			if GetSurfaceShopIcon( upgradeData )  ~= nil then
				local icon = DeepCopyTable( ScreenData.UpgradeChoice.Icon )
				icon.X = itemLocationX + ScreenData.UpgradeChoice.IconOffsetX
				icon.Y = itemLocationY + ScreenData.UpgradeChoice.IconOffsetY 
				icon.Animation = GetSurfaceShopIcon( upgradeData )
				components["Icon"..itemIndex] = CreateScreenComponent( icon )
			end

			local iconKey = "HermesSpeedUp"..itemIndex
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX - 313 + 560, Y = itemLocationY - 50, Group = "Combat_Menu" })
				
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
			
			CreateTextBox(MergeTables({ Id = components[purchaseButtonCostKey].Id, Text = costString, OffsetX = 410, OffsetY = -50, FontSize = 28, Color = costColor, Font = "P22UndergroundSCMedium", Justification = "Right" },LocalizationData.SellTraitScripts.ShopButton))

			local purchaseButtonTitleKey = "PurchaseButtonTitle"..itemIndex
			components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX, Y = itemLocationY })
			local titleText = DeepCopyTable( ScreenData.UpgradeChoice.TitleText )
			titleText.Id = components[purchaseButtonTitleKey].Id
			titleText.Text = GetSurfaceShopText( upgradeData )
			titleText.LuaKey = "TempTextData"
			titleText.LuaValue = upgradeData
			titleText.Color = costColor
			CreateTextBox( titleText )

			local descriptionText = DeepCopyTable( ScreenData.UpgradeChoice.DescriptionText )
			descriptionText.Id = components[purchaseButtonKey].Id
			descriptionText.Text = GetSurfaceShopText( upgradeData )
			descriptionText.LuaKey = "TooltipData"
			descriptionText.LuaValue = upgradeData
			CreateTextBoxWithFormat( descriptionText )

			SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = ScreenData.UpgradeChoice.TooltipOffsetX })

			local purchaseButtonDeliveryKey = "PurchaseButtonDelivery"..itemIndex
			components[purchaseButtonDeliveryKey ] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })
			
			local deliveryDuration = "PendingDeliveryDuration"
			if upgradeData.Purchased then
				deliveryDuration = "SpeedUpDelivery"
			end
			CreateTextBox(MergeTables({ Id = components[purchaseButtonDeliveryKey].Id, Text = deliveryDuration,
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
			},LocalizationData.SellTraitScripts.ShopButton))

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
	--[[
	if HeroHasTrait( "PanelRerollMetaUpgrade" ) then
		local increment = 0
		if CurrentRun.CurrentRoom.SpentRerolls then
			increment = CurrentRun.CurrentRoom.SpentRerolls[CurrentRun.CurrentRoom.Store.Screen.Name] or 0
		end
		local cost = RerollCosts.Shop + increment

		local color = Color.White
		if CurrentRun.NumRerolls < cost or cost < 0 then
			color = Color.CostUnaffordable
		end
		if cost > 0 then
			components["RerollPanel"] = CreateScreenComponent({ Name = "ShopRerollButton", Scale = 1.0, Group = "Combat_Menu" })
			Attach({ Id = components["RerollPanel"].Id, DestinationId = components.ShopBackground.Id, OffsetX = -200, OffsetY = 440 })
			components["RerollPanel"].OnPressedFunctionName = "AttemptPanelReroll"
			components["RerollPanel"].RerollFunctionName = "RerollStore"
			components["RerollPanel"].Cost = cost
			components["RerollPanel"].RerollColor = {48, 25, 83, 255}
			components["RerollPanel"].RerollId = CurrentRun.CurrentRoom.Store.Screen.Name
			CreateTextBox({ Id = components["RerollPanel"].Id, Text = "RerollCount", OffsetX = 28, OffsetY = -5,
			ShadowColor = {0,0,0,1}, ShadowOffset={0,3}, OutlineThickness = 3, OutlineColor = {0,0,0,1},
			FontSize = 28, Color = color, Font = "P22UndergroundSCHeavy", LuaKey = "TempTextData", LuaValue = { Amount = cost }})
			SetInteractProperty({ DestinationId = components["RerollPanel"].Id, Property = "TooltipOffsetX", Value = 850 })
			CreateTextBox({ Id = components["RerollPanel"].Id, Text = "MetaUpgradeRerollHint", Color = Color.Transparent, Font = "P22UndergroundSCHeavy", LuaKey = "TempTextData", LuaValue = { Amount = cost }})
		end
	end
	]]

end


function HandleSurfaceShopAction( screen, button )
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
			else
				value.Purchased = true
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
		end
	end

	if upgradeData.PurchaseRequirements ~= nil and not IsGameStateEligible( CurrentRun, upgradeData.PurchaseRequirements ) then
		CantPurchasePresentation( screen.Components["PurchaseButton".. button.Index] )
		return
	end

	CurrentRun.SurfaceShopPurchases =  (CurrentRun.SurfaceShopPurchases or 0) + 1

	if speedUpDelivery then
		SpendResources( upgradeData.SpeedUpResourceCosts, upgradeData.Name or "WeaponUpgrade" )
		CurrentRun.CurrentRoom.Store.StoreOptions[itemIndex] = nil
		table.insert( screen.OnCloseItems, upgradeData.Name )
		ModifyTextBox({ Id = screen.Components.SelectButton.Id, Text = " " })
	else
		ModifyTextBox({ Id = screen.Components.SelectButton.Id, Text = "Menu_Rush" })
		SpendResources( upgradeData.ResourceCosts, upgradeData.Name or "WeaponUpgrade" )
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

		Destroy({ Id = screen.Components["Icon".. button.Index].Id })
		screen.Components["Icon".. button.Index] = nil

		Destroy({ Id = screen.Components["PurchaseButtonDelivery" .. button.Index].Id })
		screen.Components["PurchaseButtonDelivery" .. button.Index] = nil

		Destroy({ Id = screen.Components["PurchaseButtonCost" .. button.Index].Id })
		screen.Components["PurchaseButtonCost" .. button.Index] = nil

		Destroy({ Id = screen.Components["HermesSpeedUp" .. button.Index].Id })
		screen.Components["HermesSpeedUp" .. button.Index] = nil
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
		AddTraitToHero({ TraitData =  shopTrait})

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

	thread( PlayVoiceLines, upgradeData.PurchasedLines, true )
	for i, button in pairs(CurrentRun.CurrentRoom.Store.Buttons) do
		UpdateCostButton( button )
	end
end


function CloseSurfaceShopScreen( screen, button )
	local closeItems = DeepCopyTable( screen.OnCloseItems )
	CloseStoreScreen( screen, button )
	
	local spawnPoints = FYShuffle(GetIdsByType({ Name = "EnemyPoint" }))
	local startIndex = 1
	for s, name in pairs( closeItems ) do
		for i, trait in pairs( CurrentRun.Hero.TraitDictionary.StorePendingDeliveryItem) do
			if trait.AcquiredDepth == CurrentRun.RunDepthCache and trait.ShopItemName == name then
				local consumableId = nil
				while spawnPoints[startIndex] and SessionMapState.SurfaceShopSpawnPointsUsed[spawnPoints[startIndex]] do
					startIndex = startIndex + 1
				end
				if spawnPoints[startIndex] then
					consumableId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = spawnPoints[startIndex] })
					SessionMapState.SurfaceShopSpawnPointsUsed[spawnPoints[startIndex]] = true

				else
					consumableId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = RandomFloat(-10, 10), OffsetY = RandomFloat(-10, 10) })
				end
				SpawnStoreItemInWorld( trait.OnExpire.SpawnShopItem, consumableId )
				thread( SurfaceShopItemSameRoomPresentation, consumableId )
				thread( DestroyOnDelay, { consumableId }, 0.05 )
				RemoveTraitData( CurrentRun.Hero, trait, { SkipExpire = true })
				break
			end
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