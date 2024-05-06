function UseMailboxObject( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	GenerateMailboxItems()
	StopStatusAnimation( usee )
	local screen = OpenMailboxScreen( nil, usee )
	UseableOn({ Id = usee.ObjectId })
	MailboxSessionCompletePresentation( usee, screen )
end

function GenerateMailboxItems( args )
	args = args or {}
	if CurrentRun.MailboxItems ~= nil and not args.ForceRegenerate then
		return CurrentRun.MailboxItems
	end
	RandomSynchronize()
	CurrentRun.MailboxItems = {}

	for categoryIndex, category in ipairs( ScreenData.MailboxScreen.ItemCategories ) do
		CurrentRun.MailboxItems[categoryIndex] = CurrentRun.MailboxItems[categoryIndex] or {}
		local nonPriorityItems = {}
		for j, buyData in ipairs( category ) do
			if buyData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, buyData, buyData.GameStateRequirements ) then
				if buyData.Priority then
					local buyItem = DeepCopyTable( buyData )
					buyItem.DeliveryTime = RandomInt( buyData.DeliveryTimeMin, buyData.DeliveryTimeMax )
					table.insert( CurrentRun.MailboxItems[categoryIndex], buyItem )
					DebugPrint({ Text = "added priority item" })
				else
					table.insert( nonPriorityItems, buyData )
				end
			end
		end
		for i = 1, ScreenData.MailboxScreen.MaxNonPriorityOffers do
			if not IsEmpty( nonPriorityItems ) then
				local chosenOption = RemoveRandomValue( nonPriorityItems )
				local buyItem = DeepCopyTable( chosenOption )
				buyItem.DeliveryTime = RandomInt( buyData.DeliveryTimeMin, buyData.DeliveryTimeMax )
				table.insert( CurrentRun.MailboxItems[categoryIndex], buyItem )
				DebugPrint({ Text = "added non-priority item" })
			end
		end
	end

	return CurrentRun.MailboxItems
end

function OpenMailboxScreen( args, openedFrom )
	
	args = args or {}

	local screenData = ScreenData.MailboxScreen
	if IsScreenOpen( screenData.Name ) then
		return
	end

	AltAspectRatioFramesShow()

	local screen = DeepCopyTable( screenData )
	local components = screen.Components

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	screen.OpenedFrom = openedFrom
	screen.ActiveCategoryIndex = args.DefaultCategoryIndex or 1
	screen.NumCategories = 0

	local categoryTitleX = screen.CategoryStartX
	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		if category.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, category, category.GameStateRequirements ) then
			local slotName = category.Name
			--[[
			screen.Components["Category"..slotName] = CreateScreenComponent({ Name = "ResourceShopTab", X = categoryTitleX, Y = screen.CategoryStartY, Scale = 1.0, Group = "Combat_Menu_Overlay" })
			screen.Components["Category"..slotName].OnPressedFunctionName = "MailboxScreenSelectCategory"
			screen.Components["Category"..slotName].Category = slotName
			screen.Components["Category"..slotName].CategoryIndex = categoryIndex
			CreateTextBox({ Id = screen.Components["Category"..slotName].Id,
				Text = slotName,
				FontSize = 22,
				Color = Color.CodexTitleUnselected,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Center"
			})
			if categoryIndex ~= screen.ActiveCategoryIndex and not GameState.ItemsViewed[category.Name] then
				-- New icon
				local newButtonKey = "NewIcon"..slotName
				components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay" })
				SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "NewTabStar" })
				Attach({ Id = components[newButtonKey].Id, DestinationId = screen.Components["Category"..slotName].Id, OffsetX = -85, OffsetY = 0 })
			end
			]]
			screen.NumCategories = screen.NumCategories + 1
		else
			category.Locked = true
		end
		categoryTitleX = categoryTitleX + screen.CategorySpacingX
	end

	local resourceData = ResourceData[components.BasicResourceButton.ResourceName]
	SetAnimation({ DestinationId = components.BasicResourceButton.Id, Name = resourceData.IconPath or resourceData.Icon })
	ModifyTextBox({ Id = components.BasicResourceButton.Id, Text = GameState.Resources[components.BasicResourceButton.ResourceName] or 0, })

	MailboxScreenDisplayCategory( screen, screen.ActiveCategoryIndex )
	WeaponShopUpdateVisibility( screen )
	UpdateMailboxScreenInteractionText( screen )

	MailboxScreenOpenPresentation( screen )

	HandleScreenInput( screen )
	return screen

end

function MailboxScreenDisplayCategory( screen, categoryIndex )

	local components = screen.Components

	local slotName = screen.ItemCategories[categoryIndex].Name
	--ModifyTextBox({ Id = components["Category"..slotName].Id, Color = Color.White })

	-- Cleanup prev category
	--[[
	local prevCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	for i, resourceName in ipairs( prevCategory ) do
		if components[resourceName] ~= nil then
			Destroy({ Id = components[resourceName].Id })
		end
	end
	ModifyTextBox({ Id = screen.Components["Category"..prevCategory.Name].Id, Color = Color.CodexTitleUnselected })
	]]

	local category = screen.ItemCategories[categoryIndex]
	local slotName = category.Name

	GameState.ItemsViewed[category.Name] = true

	-- Highlight new category
	--ModifyTextBox({ Id = components["Category"..slotName].Id, Color = Color.White })

	screen.ActiveCategoryIndex = categoryIndex

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	screen.NumItems = 0
	local firstUseable = false

	local items = CurrentRun.MailboxItems[screen.ActiveCategoryIndex]
	for itemIndex, item in ipairs( items ) do

		local buyResourceData = ResourceData[item.BuyName]
		if buyResourceData ~= nil and not item.SoldOut then
			
			item.LeftDisplayName = item.BuyName
			item.LeftDisplayAmount = item.BuyAmount
			local costDisplay = item.Cost
			local costText = "ResourceCost"
			local unaffordableColor = nil
			-- ModifyTextBox({ Id = screen.Components.OperationHeader.Id, Text = "MarketScreen_BuyingHeader" })
			--[[
			if category.FlipSides then
				for resourceName, resourceAmount in pairs( item.Cost ) do
					buyResourceData = ResourceData[resourceName]
					item.LeftDisplayName = resourceName
					item.LeftDisplayAmount = resourceAmount
					costDisplay = {}
					costDisplay[item.BuyName] = item.BuyAmount
					costText = "ResourceCostSelling"
					unaffordableColor = Color.White
					--ModifyTextBox({ Id = screen.Components.OperationHeader.Id, Text = "MarketScreen_SellingHeader" })
					break
				end
			end
			]]

			local costColor = Color.CostAffordableShop
			item.Showing = true
			if not HasResources( item.Cost ) then
				if category.HideUnaffordable then
					item.Showing = false
				else
					costColor = Color.CostUnaffordable
				end
			end

			if item.Showing then
				screen.NumItems = screen.NumItems + 1

				local purchaseButtonKey = "PurchaseButton"..screen.NumItems
				local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = "Combat_Menu_Overlay", X = itemLocationX, Y = itemLocationY, Animation = screen.ItemAnimation })
				components[purchaseButtonKey] = button
				SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = 665 })
				AttachLua({ Id = button.Id, Table = button })
				button.Screen = screen

				local purchaseButtonTitleKey = "PurchaseButtonTitle"..screen.NumItems
				components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", X = itemLocationX, Y = itemLocationY })

				components[purchaseButtonKey].OnPressedFunctionName = "HandleMailboxPurchase"
				components[purchaseButtonKey].OnMouseOverFunctionName = "MailboxScreenMouseOverItem"
				components[purchaseButtonKey].OnMouseOffFunctionName = "MailboxScreenMouseOffItem"
				if not firstUseable then
					TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
					firstUseable = true
				end

				-- Left Column

				local iconKey = "Icon"..screen.NumItems
				components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Scale = 1 })
				SetAnimation({ Name = buyResourceData.IconPath, DestinationId = components[iconKey].Id, Scale = buyResourceData.IconScale })
				Attach({ Id = components[iconKey].Id, DestinationId = components[purchaseButtonTitleKey].Id, OffsetX = screen.IconOffsetX, OffsetY = screen.IconOffsetY })

				local itemNameFormat = screen.ItemNameFormat
				itemNameFormat.Id = components[purchaseButtonKey].Id
				itemNameFormat.Text = item.BuyName
				itemNameFormat.LuaValue = item
				CreateTextBox( itemNameFormat )

				local itemDeliveryTimeFormat = screen.ItemDeliveryTimeFormat
				itemDeliveryTimeFormat.Id = components[purchaseButtonKey].Id
				itemDeliveryTimeFormat.Text = "MailboxScreen_DeliveryTime"
				itemDeliveryTimeFormat.LuaValue = item
				CreateTextBox( itemDeliveryTimeFormat )

				local itemBuyAmountFormat = screen.ItemBuyAmountFormat
				itemBuyAmountFormat.Id = components[purchaseButtonKey].Id
				itemBuyAmountFormat.LuaKey = "TempTextData"
				itemBuyAmountFormat.LuaValue = item
				if category.FlipSides then					
					itemBuyAmountFormat.Text = "MarketScreen_SellAmount"
				else
					itemBuyAmountFormat.Text = "MarketScreen_BuyAmount"
				end
				CreateTextBox( itemBuyAmountFormat )

				local currentAmountKey = "CurrentAmount"..screen.NumItems
				components[currentAmountKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", X = itemLocationX, Y = itemLocationY })
				local itemAmountFormat = screen.ItemAmountFormat
				itemAmountFormat.Id = components[currentAmountKey].Id
				itemAmountFormat.Text = "MarketScreen_InventoryAmount"
				itemAmountFormat.LuaKey = "TempTextData"
				itemAmountFormat.LuaValue = { InventoryAmount = GameState.Resources[buyResourceData.Name] or 0 }
				CreateTextBox( itemAmountFormat )

				if HasPinWithResource( item.BuyName ) then
					local pinButtonKey = "PinIcon"..screen.NumItems
					components[pinButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Animation = "StoreItemPin" })
					Attach({ Id = components[pinButtonKey].Id, DestinationId = components[purchaseButtonTitleKey].Id, OffsetX = screen.PinOffsetX, OffsetY = UIData.PinIconListOffsetY })
					components[purchaseButtonTitleKey].PinButtonId = components[pinButtonKey].Id
					-- Silent toolip
					CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "NeededPinResourceTooltip", Color = Color.Transparent })
				end

				if not item.Priority then
					CreateTextBox({ Id = components[purchaseButtonKey].Id, Text = "Market_LimitedTimeOffer", OffsetX = 250, OffsetY = 0, FontSize = 28, Color = costColor, Font = "P22UndergroundSCMedium", Justification = "Left", TextSymbolScale = textSymbolScale })
				end

				-- Right Column

				components[purchaseButtonTitleKey .. "SellText"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Scale = 1 })
				Attach({ Id = components[purchaseButtonTitleKey .. "SellText"].Id, DestinationId = components[purchaseButtonTitleKey].Id, OffsetX = 0, OffsetY = 0 })
				AddResourceCostText( components[purchaseButtonTitleKey.."SellText"].Id, costDisplay,
					{
						InitialXOffset = 350,
						InitialYOffset = -20,
						TextArgs = screen.CostTextArgs,
						CostText = costText,
						AffordableColor = Color.White,
						UnaffordableColor = unaffordableColor,
					})

				components[purchaseButtonKey].Data = item
				components[purchaseButtonKey].Index = screen.NumItems
				components[purchaseButtonKey].TitleId = components[purchaseButtonTitleKey].Id

				itemLocationY = itemLocationY + screen.ItemSpacingY
			end
		end

	end

end

function CloseMailboxScreen( screen, button )
	MailboxScreenClosePresentation( screen, button )
	CloseScreenButton( screen, button )
	AltAspectRatioFramesHide()
	ShowCombatUI( screen.Name )
end

function HandleMailboxPurchase( screen, button )
	local item = button.Data

	if not HasResources( item.Cost ) then
		MailboxPurchaseFailPresentation( screen, button, item )
		return
	end

	screen.NumSales = screen.NumSales + 1
	GameState.MailboxSales = (GameState.MailboxSales or 0) + 1

	local category = screen.ItemCategories[screen.ActiveCategoryIndex]

	local buttonIds = GetAllIds(
	{
		screen.Components["PurchaseButton"..button.Index],
		screen.Components["PurchaseButtonTitle"..button.Index],
		screen.Components["PurchaseButtonTitle"..button.Index.."SellText"],
		screen.Components["PinIcon"..button.Index],
		screen.Components["Icon"..button.Index],
		screen.Components["CurrentAmount"..button.Index],
	})

	MailboxPurchaseSuccessPresentation( screen, item )
	item.SoldOut = true
	UseableOff({ Ids = buttonIds })
	SetAlpha({ Ids = buttonIds, Fraction = 0, Duration = 0.2 })
	ModifyTextBox({ Ids = buttonIds, FadeTarget = 0 })
	UpdateMailboxScreenInteractionText( screen )
	
	local resourceArgs = { ApplyMultiplier = false, OffsetX = 600 }
	SpendResources( item.Cost, "ResourceShop", resourceArgs )
	ModifyTextBox({ Id = screen.Components.BasicResourceButton.Id, Text = GameState.Resources[screen.Components.BasicResourceButton.ResourceName] or 0, })

	if category.HideUnaffordable and not HasResources( item.Cost ) then
		UseableOff({ Ids = buttonIds })
		SetAlpha({ Ids = buttonIds, Fraction = 0, Duration = 0.2 })
		ModifyTextBox({ Ids = buttonIds, FadeTarget = 0 })
		UpdateMailboxScreenInteractionText( screen )
	end

	MailboxScreenUpdateResourceStatus( screen, button )

	wait(0.3)

	item.TimeRemaining = item.DeliveryTime
	GameState.MailboxStatus[screen.OpenedFrom.ObjectId] = item

	MailboxScreenUpdateResourceStatus( screen, button )
	UpdateAffordabilityStatus()

	MailboxScreenPurchaseFinishPresentation( screen, button, item )
	CloseMailboxScreen( screen, button )
	SetupMailboxStatus( screen.OpenedFrom )

end

function MailboxScreenUpdateResourceStatus( screen, button )

	local category = screen.ItemCategories[screen.ActiveCategoryIndex]

	ModifyTextBox({ Id = screen.Components.BasicResourceButton.Id, Text = GameState.Resources[screen.Components.BasicResourceButton.ResourceName] or 0, })

	for itemIndex = 1, screen.NumItems do
		local button = screen.Components["PurchaseButton"..itemIndex]
		if button ~= nil then
			local item = button.Data
			if not item.SoldOut and item.Showing then
				local buyResourceData = ResourceData[item.BuyName]
				local costDisplay = item.Cost
				local itemNameColor = Color.CostAffordableShop
				local costColor = Color.White
				if category.FlipSides then
					for resourceName, resourceAmount in pairs( item.Cost ) do
						buyResourceData = ResourceData[resourceName]
						costDisplay = {}
						costDisplay[item.BuyName] = item.BuyAmount
					end
				else
					if not HasResources( costDisplay ) then
						costColor = Color.CostUnaffordable
						itemNameColor = Color.CostUnaffordable
					end
				end
			
				ModifyTextBox({ Id = screen.Components["PurchaseButton"..itemIndex].Id, ColorTarget = itemNameColor, ColorDuration = 0.1 })
				ModifyTextBox({ Id = screen.Components["PurchaseButton"..itemIndex].Id, AffectText = "NeededPinResourceTooltip", ColorTarget = Color.Transparent })
				ModifyTextBox({ Id = screen.Components["PurchaseButtonTitle"..itemIndex.."SellText"].Id, ColorTarget = costColor, ColorDuration = 0.1 })
				ModifyTextBox({ Id = screen.Components["CurrentAmount"..itemIndex].Id, Text = GameState.Resources[buyResourceData.Name] or 0 })
			end
		end
	end
end

function MailboxScreenSelectCategory( screen, button )
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	WeaponShopScreenHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY })
	MailboxScreenDisplayCategory( screen, button.CategoryIndex )
	WeaponShopUpdateVisibility( screen )
end

function UpdateMailboxScreenInteractionText( screen, button )

	local components = screen.Components

	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	if button ~= nil and button.Data ~= nil and button.Data.Cost ~= nil and HasResources( button.Data.Cost ) then
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

end

function CheckCharonPointsOwed( sourceName )
	
	if not IsGameStateEligible( CurrentRun, ScreenData.MailboxScreen.CharonPointsRequirements ) then
		return
	end

	local lifetimeOwed = math.floor( (GameState.LifetimeResourcesSpent.Money or 0) / ScreenData.MailboxScreen.MoneySpentPerCharonPoint )
	DebugPrint({ Text = "lifetimeOwed = "..lifetimeOwed })
	local lifetimeRecieved = GameState.LifetimeResourcesGained.CharonPoints or 0
	DebugPrint({ Text = "lifetimeRecieved = "..lifetimeRecieved })
	GameState.NextCharonPointCache = (ScreenData.MailboxScreen.MoneySpentPerCharonPoint * (lifetimeOwed + 1)) - GameState.LifetimeResourcesSpent.Money
	local currentlyOwed = lifetimeOwed - lifetimeRecieved
	if currentlyOwed > 0 then
		AddResource( "CharonPoints", currentlyOwed, sourceName, { PresentationDelay = 0.5 } )
		CharonPointsGrantedPresentation( currentlyOwed, sourceName )
	end

end

function MailboxTimeTick( args )
	args = args or {}
	AddInputBlock({ Name = "MailboxTimeTick" })
	for tick = 1, (args.Ticks or 1) do
		for mailboxId, mailboxStatus in pairs( GameState.MailboxStatus ) do
			if args.MailboxId == nil or mailboxId == args.MailboxId then
				if mailboxStatus.TimeRemaining ~= nil and mailboxStatus.TimeRemaining > 0 then
					mailboxStatus.TimeRemaining = mailboxStatus.TimeRemaining - 1
					if mailboxStatus.TimeRemaining <= 0 then
						CurrentRun.AnyMailboxReady = true
					end
					if args.UpdatePresentation then
						local source = MapState.ActiveObstacles[mailboxId]
						SetupMailboxStatus( source, args )
					end
				end
			end
		end
		wait( args.TickInterval )
	end
	RemoveInputBlock({ Name = "MailboxTimeTick" })
end

function SetupMailboxStatus( source, args )
	args = args or {}
	UseableOff({ Id = source.ObjectId })
	local mailboxStatus = GameState.MailboxStatus[source.ObjectId]
	if mailboxStatus == nil then
		local defaultData = HubRoomData.Hub_Main.ObstacleData[source.ObjectId]
		source.UseText = defaultData.UseText
		source.OnUsedFunctionName = defaultData.OnUsedFunctionName
		DestroyTextBox({ Id = source.ObjectId })
		SessionMapState.MailboxTextBoxCreated = nil
		UseableOn({ Id = source.ObjectId })
		return
	end
	if mailboxStatus.TimeRemaining >= 1 then
		source.UseText = "UseMailbox_DeliveryPending"
		source.OnUsedFunctionName = "UseMailboxDeliveryPendingPresentation"
	else
		source.UseText = "UseMailbox_DeliveryReady"
		source.OnUsedFunctionName = "UseMailboxDeliveryReady"
	end
	SetupMailboxDeliveryPendingPresentation( source, args )
	UseableOn({ Id = source.ObjectId })
end

function UseMailboxDeliveryReady( source, args )
	AddInputBlock({ Name = "UseMailboxDeliveryReady" })
	StopStatusAnimation( source )
	local item = GameState.MailboxStatus[source.ObjectId]
	GameState.MailboxStatus[source.ObjectId] = nil
	thread( UseMailboxDeliveryReadyPresentation, source, args )
	wait(0.1)
	AddResource( item.BuyName, item.BuyAmount, "ResourceShop" )
	SetupMailboxStatus( source, args )
	wait(0.1)
	RemoveInputBlock({ Name = "UseMailboxDeliveryReady" })
end