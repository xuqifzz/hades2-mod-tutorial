function UseMailboxObject( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	GenerateMailboxItems()
	StopStatusAnimation( usee )
	local screen = OpenMailboxScreen( nil, usee )
	UseableOn({ Id = usee.ObjectId })
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
			if buyData.GameStateRequirements == nil or IsGameStateEligible( buyData, buyData.GameStateRequirements ) then
				if buyData.Priority then
					local buyItem = DeepCopyTable( buyData )
					buyItem.DeliveryTime = RandomInt( buyData.DeliveryTimeMin, buyData.DeliveryTimeMax )
					table.insert( CurrentRun.MailboxItems[categoryIndex], buyItem )
					--DebugPrint({ Text = "added priority item" })
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
				--DebugPrint({ Text = "added non-priority item" })
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
		if category.GameStateRequirements == nil or IsGameStateEligible( category, category.GameStateRequirements ) then
			local slotName = category.Name
			screen.NumCategories = screen.NumCategories + 1
		else
			category.Locked = true
		end
		categoryTitleX = categoryTitleX + screen.CategorySpacingX
	end

	local resourceData = ResourceData[components.BasicResourceButton.ResourceName]
	SetAnimation({ DestinationId = components.BasicResourceButton.Id, Name = resourceData.TextIconPath or resourceData.IconPath or resourceData.Icon })
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

	local category = screen.ItemCategories[categoryIndex]
	local slotName = category.Name

	GameState.ItemsViewed[category.Name] = true

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
				local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = "Combat_Menu_Overlay",
					X = itemLocationX,
					Y = itemLocationY,
					Animation = screen.ItemAnimation,
					Alpha = 0.0,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.3,
				})
				components[purchaseButtonKey] = button
				SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = 665 })
				AttachLua({ Id = button.Id, Table = button })
				button.Screen = screen
				button.WorldUpgradeName = "Mailbox_"..item.BuyName

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

				if not GameState.WorldUpgradesViewed[button.WorldUpgradeName] then
					local newIconKey = "NewIcon"..screen.NumItems
					components[newIconKey] = CreateScreenComponent({
						Name = "BlankObstacle",
						Group = screen.ComponentData.DefaultGroup,
						Animation = "MusicPlayerNewTrack",
						Alpha = 0.0,
					})
					Attach({ Id = components[newIconKey].Id, DestinationId = button.Id, OffsetX = 235, OffsetY = 0 })
					button.NewIconId = components[newIconKey].Id
				end

				local amountNeededByPins = GetResourceAmountNeededByPins( item.BuyName )
				if amountNeededByPins > 0 then
					local pinButtonKey = "PinIcon"..screen.NumItems
					local pinAnimation = "StoreItemPin"
					local pinTooltip = "NeededPinResourceTooltip"
					if HasResource( item.BuyName, amountNeededByPins ) then
						pinAnimation = "StoreItemPin_Complete"
						pinTooltip = "CompletedPinResourceTooltip"
					end
					components[pinButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Animation = pinAnimation })
					Attach({ Id = components[pinButtonKey].Id, DestinationId = components[purchaseButtonTitleKey].Id, OffsetX = screen.PinOffsetX, OffsetY = UIData.PinIconListOffsetY })
					components[purchaseButtonTitleKey].PinButtonId = components[pinButtonKey].Id
					components[purchaseButtonTitleKey].PinTooltip = pinTooltip
					-- Silent toolip
					CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = pinTooltip, Color = Color.Transparent })
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

	MailboxPurchaseSuccessPresentation( screen, button, item )
	item.SoldOut = true
	UseableOff({ Ids = buttonIds })
	SetAlpha({ Ids = buttonIds, Fraction = 0, Duration = 0.2 })
	ModifyTextBox({ Ids = buttonIds, FadeTarget = 0 })
	UpdateMailboxScreenInteractionText( screen )
	
	local resourceArgs = { ApplyMultiplier = false, OffsetX = 600, TextOffsetY = 11, Delay = 1.0, }
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

	SetupMailboxStatus( screen.OpenedFrom )
	CloseMailboxScreen( screen, button )

end

function MailboxScreenUpdateResourceStatus( screen, button )

	ModifyTextBox({ Id = screen.Components.BasicResourceButton.Id, Text = GameState.Resources[screen.Components.BasicResourceButton.ResourceName] or 0, })

	for itemIndex = 1, screen.NumItems do
		local button = screen.Components["PurchaseButton"..itemIndex]
		if button ~= nil then
			local item = button.Data
			if not item.SoldOut and item.Showing then
				local costColor = Color.White
				if not HasResources( item.Cost ) then
					costColor = Color.CostUnaffordable
				end
				ModifyTextBox({ Id = screen.Components["PurchaseButtonTitle"..itemIndex.."SellText"].Id, ColorTarget = costColor, ColorDuration = 0.1 })
			end
		end
	end

end

function UpdateMailboxScreenInteractionText( screen, button )
	local components = screen.Components
	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	if button ~= nil and button.Data ~= nil then
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
end

function SetupCharonPoints( sourceName )
	if GameState.LifetimeResourcesGained.CharonPoints == 1 then
		-- After you collect your first CharonPoint, you need to spend 1000 more to earn the next reward,
		-- no matter how much you spent previously.
		GameState.MoneySpentTowardCharonPoints = ScreenData.MailboxScreen.MoneySpentPerCharonPoint
		GameState.NextCharonPointCache = ScreenData.MailboxScreen.MoneySpentPerCharonPoint
	end
end

function HandleCharonPurchase( sourceName, spent )
	
	local prevMoneySpent = GameState.MoneySpentTowardCharonPoints
	GameState.MoneySpentTowardCharonPoints = prevMoneySpent + spent

	if not IsGameStateEligible( nil, ScreenData.MailboxScreen.CharonPointsRequirements ) then
		return
	end

	local prevCharonPointsEarned = math.floor( prevMoneySpent / ScreenData.MailboxScreen.MoneySpentPerCharonPoint )
	local charonPointsEarned = math.floor( GameState.MoneySpentTowardCharonPoints / ScreenData.MailboxScreen.MoneySpentPerCharonPoint )

	GameState.NextCharonPointCache = (ScreenData.MailboxScreen.MoneySpentPerCharonPoint * (charonPointsEarned + 1)) - GameState.MoneySpentTowardCharonPoints

	local currentlyOwed = charonPointsEarned - prevCharonPointsEarned
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
	if source == nil then
		return
	end
	args = args or {}
	local mailboxStatus = GameState.MailboxStatus[source.ObjectId]
	if mailboxStatus == nil then
		local defaultData = HubRoomData.Hub_Main.ObstacleData[source.ObjectId]
		source.UseText = defaultData.UseText
		source.OnUsedFunctionName = defaultData.OnUsedFunctionName
		Destroy({ Id = SessionMapState.MailboxTimerId })
		SessionMapState.MailboxTimerId = nil
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

function ShouldShowMailboxWantsToTalkIndicator( source, args )
	if not IsEmpty( GameState.MailboxStatus ) then
		return false
	end

	if CurrentRun.UseRecord.Mailbox then
		return false
	end

	-- Always notify until you purchase something
	if (GameState.MailboxSales or 0) <= 0 and GameState.Resources.CharonPoints >= 1 then
		return true
	end

	local lastEligibleItem = nil
	for i, item in ipairs( ScreenData.MailboxScreen.ItemCategories[1] ) do
		if item.GameStateRequirements == nil or IsGameStateEligible( item, item.GameStateRequirements ) then
			lastEligibleItem = item
			-- Check for unviewed items
			if not GameState.WorldUpgradesViewed["Mailbox_"..item.BuyName] then
				return true
			end
		end
	end

	if lastEligibleItem ~= nil and HasResources( lastEligibleItem.Cost ) then
		return true
	end

	return false
end

function IsMailboxItemInStock( source, args )
	DebugAssert({ Condition = CurrentRun.MailboxItems ~= nil, Text = "Checking Mailbox stock before it has been initialized!", Owner = "Caleb" })
	for i, itemData in ipairs( CurrentRun.MailboxItems[1] ) do
		if itemData.BuyName == args.Name then
			return true
		end
	end
	return false
end
