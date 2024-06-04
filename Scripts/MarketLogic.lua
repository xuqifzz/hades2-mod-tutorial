function UseMarketObject( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenMarketScreen()
	UseableOn({ Id = usee.ObjectId })
	MarketSessionCompletePresentation( usee, screen )
end

function GenerateMarketItems()
	if CurrentRun.MarketItems ~= nil then
		return CurrentRun.MarketItems
	end
	RandomSynchronize()
	CurrentRun.MarketItems = {}

	for categoryIndex, category in ipairs( ScreenData.MarketScreen.ItemCategories ) do
		CurrentRun.MarketItems[categoryIndex] = CurrentRun.MarketItems[categoryIndex] or {}
		local nonPriorityItems = {}
		for j, buyData in ipairs( category ) do
			if buyData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, buyData, buyData.GameStateRequirements ) then
				if buyData.Priority then
					table.insert( CurrentRun.MarketItems[categoryIndex], DeepCopyTable( buyData ) )
					DebugPrint({ Text = "added priority item" })
				else
					table.insert( nonPriorityItems, buyData )
				end
			end
		end
		for i, chosenOption in ipairs( nonPriorityItems ) do
			table.insert( CurrentRun.MarketItems[categoryIndex], DeepCopyTable( chosenOption ) )
			DebugPrint({ Text = "added non-priority item" })
		end
	end

	return marketItems
end

function OpenMarketScreen( args )
	
	args = args or {}

	local screenData = ScreenData.MarketScreen
	if IsScreenOpen( screenData.Name ) then
		return
	end

	AltAspectRatioFramesShow()

	local screen = DeepCopyTable( screenData )
	local components = screen.Components

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	screen.ActiveCategoryIndex = args.DefaultCategoryIndex or 1
	screen.NumCategories = 0

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY
	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY

	local categoryTitleX = screen.CategoryStartX
	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		if category.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, category, category.GameStateRequirements ) then
			local slotName = category.Name
			local categoryButton = CreateScreenComponent({ Name = "ButtonInventoryTab", X = categoryTitleX, Y = screen.CategoryStartY, Scale = 1.0, Group = "Combat_Menu_Overlay" })
			categoryButton.OnPressedFunctionName = "MarketScreenSelectCategory"
			categoryButton.Category = slotName
			categoryButton.CategoryIndex = categoryIndex
			screen.Components["Category"..slotName] = categoryButton

			local categoryButtonIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Scale = screen.CategoryIconScale,
					X = categoryTitleX + screen.CategoryIconOffsetX, Y = screen.CategoryStartY + screen.CategoryIconOffsetY })
			SetAnimation({ DestinationId = categoryButtonIcon.Id, Name = category.Icon })
			screen.Components["CategoryIcon"..slotName] = categoryButtonIcon
			
			--local categoryFormat = screen.CategoryFormat
			--categoryFormat.Id = categoryButton.Id
			--categoryFormat.Text = slotName
			--CreateTextBox( categoryFormat )

			if categoryIndex ~= screen.ActiveCategoryIndex then
				if not GameState.ItemsViewed[slotName] or HasUnviewedMarketItem( screen, { CategoryIndex = categoryIndex } ) then
					-- New icon
					local newButtonKey = "NewIcon"..slotName
					components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay" })
					SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "NewTabStar" })
					Attach({ Id = components[newButtonKey].Id, DestinationId = categoryButton.Id, OffsetX = screen.NewIconOffsetX, OffsetY = screen.NewIconOffsetY })
				end
			end
			screen.NumCategories = screen.NumCategories + 1
			categoryTitleX = categoryTitleX + screen.CategorySpacingX
		else
			category.Locked = true
		end
	end

	local resourceData = ResourceData[components.BasicResourceButton.ResourceName]
	SetAnimation({ DestinationId = components.BasicResourceButton.Id, Name = resourceData.IconPath or resourceData.Icon })
	ModifyTextBox({ Id = components.BasicResourceButton.Id, Text = GameState.Resources[components.BasicResourceButton.ResourceName] or 0, })

	MarketScreenDisplayCategory( screen, screen.ActiveCategoryIndex )
	WeaponShopUpdateVisibility( screen )
	UpdateMarketScreenInteractionText( screen )

	MarketScreenOpenPresentation( screen )

	HandleScreenInput( screen )
	return screen

end

function MarketScreenDisplayCategory( screen, categoryIndex )

	local components = screen.Components

	local slotName = screen.ItemCategories[categoryIndex].Name
	ModifyTextBox({ Id = components["Category"..slotName].Id, Color = Color.White })
	DestroyTextBox({ Id = components.BackgroundDim.Id })

	-- Cleanup prev category
	local prevCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	--[[
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
	local newButtonKey = "NewIcon"..category.Name
	if components[newButtonKey] ~= nil then
		Destroy({ Id = components[newButtonKey].Id })
	end

	StopAnimation({ DestinationId = screen.Components["Category"..prevCategory.Name].Id, Name = "InventoryTabHighlightActiveCategory" })

	-- Highlight new category
	CreateAnimation({ DestinationId = screen.Components["Category"..slotName].Id, Name = "InventoryTabHighlightActiveCategory", Group = "Combat_Menu_TraitTray" })
	--ModifyTextBox({ Id = components["Category"..slotName].Id, Color = Color.White })
	ModifyTextBox({ Id = screen.Components.CategoryTitleText.Id, Text = category.Name })

	screen.ActiveCategoryIndex = categoryIndex

	if category.FlipSides then
		-- Sell Mode
		SetAnimation({ DestinationId = screen.Components.Background.Id, Name = "ResourceShopItemsBackground_Selling" })
	else
		-- Buy Mode
		SetAnimation({ DestinationId = screen.Components.Background.Id, Name = "ResourceShopItemsBackground" })
	end

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	screen.NumItems = 0
	local firstUseable = false

	local items = CurrentRun.MarketItems[screen.ActiveCategoryIndex]
	for itemIndex, item in ipairs( items ) do

		if not item.SoldOut and ResourceData[item.BuyName] ~= nil then
			local buyResourceData = ResourceData[item.BuyName]
			item.LeftDisplayName = item.BuyName
			item.LeftDisplayAmount = item.BuyAmount
			local costDisplay = item.Cost
			local costText = "ResourceCost"
			local unaffordableColor = nil
			local anim = "GUI\\Screens\\ResourceShop\\Button-Buy"
			local highlightAnim = "GUI\\Screens\\ResourceShop\\Button-Buy_Highlight"
			if category.FlipSides then
				for resourceName, resourceAmount in pairs( item.Cost ) do
					buyResourceData = ResourceData[resourceName]
					item.LeftDisplayName = resourceName
					item.LeftDisplayAmount = resourceAmount
					costDisplay = {}
					costDisplay[item.BuyName] = item.BuyAmount
					costText = "ResourceCostSelling"
					unaffordableColor = Color.White
					anim = "GUI\\Screens\\ResourceShop\\Button-Sell"
					highlightAnim = "GUI\\Screens\\ResourceShop\\Button-Sell_Highlight"
					break
				end
				if buyResourceData == nil then
					-- Back compat for removed resources
					break
				end
			end

			item.Showing = true
			if not HasResources( item.Cost ) then
				if category.HideUnaffordable then
					item.Showing = false
				end
			end

			if item.Showing then
				screen.NumItems = screen.NumItems + 1

				local purchaseButtonKey = "PurchaseButton"..screen.NumItems
				local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = "Combat_Menu_Overlay", X = itemLocationX, Y = itemLocationY, Animation = anim })
				components[purchaseButtonKey] = button
				SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = screen.TooltipOffsetX })
				AttachLua({ Id = button.Id, Table = button })
				button.Screen = screen
				button.OnPressedFunctionName = "HandleMarketPurchase"
				button.OnMouseOverFunctionName = "MarketScreenMouseOverItem"
				button.OnMouseOffFunctionName = "MarketScreenMouseOffItem"
				button.Animation = anim
				button.HighlightAnimation = highlightAnim

				if not firstUseable then
					TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
					firstUseable = true
				end

				-- Left Column

				local iconKey = "Icon"..screen.NumItems
				components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Animation = buyResourceData.IconPath, Scale = buyResourceData.IconScale })

				local itemNameFormat = screen.ItemNameFormat
				itemNameFormat.Id = components[purchaseButtonKey].Id
				itemNameFormat.Text = item.LeftDisplayName
				itemNameFormat.LuaValue = item
				CreateTextBox( itemNameFormat )

				local itemAmountFormat = nil
				if category.FlipSides then					
					itemAmountFormat = ShallowCopyTable( screen.ItemSellAmountFormat )
				else
					itemAmountFormat = ShallowCopyTable( screen.ItemBuyAmountFormat )
				end				
				itemAmountFormat.Id = components[purchaseButtonKey].Id
				itemAmountFormat.LuaKey = "TempTextData"
				itemAmountFormat.LuaValue = item				
				CreateTextBox( itemAmountFormat )

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
					Attach({ Id = components[pinButtonKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.PinOffsetX, OffsetY = UIData.PinIconListOffsetY })
					components[purchaseButtonKey].PinButtonId = components[pinButtonKey].Id
					-- Silent toolip
					CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "NeededPinResourceTooltip", Color = Color.Transparent })
				end

				if not category.FlipSides and not GameState.ItemsViewed[item.BuyName] then
					local newIconKey = "NewIcon"..screen.NumItems
					components[newIconKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Alpha = 0.0, Animation = "MusicPlayerNewTrack" })
					Attach({ Id = components[newIconKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 375, OffsetY = 0 })
					components[purchaseButtonKey].NewButtonId = components[newIconKey].Id
				end

				-- Right Column

				local sellTextKey = "SellText"..screen.NumItems
				components[sellTextKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay" })
				AddResourceCostText( components[sellTextKey].Id, costDisplay,
					{
						InitialXOffset = screen.CostTextOffsetX,
						InitialYOffset = screen.CostTextOffsetY,
						TextArgs = screen.CostTextArgs,
						CostText = costText,
						AffordableColor = Color.White,
						UnaffordableColor = unaffordableColor,
					})

				components[purchaseButtonKey].Data = item
				components[purchaseButtonKey].Index = screen.NumItems
				components[purchaseButtonKey].Category = category
				components[purchaseButtonKey].GameStateRecord = "ItemsViewed"
				components[purchaseButtonKey].NameKey = "BuyName"

				itemLocationY = itemLocationY + screen.ItemSpacingY
			end
		end

	end

end

function CloseMarketScreen( screen, button )
	MarketScreenClosePresentation( screen, button )
	CloseScreenButton( screen, button )
	AltAspectRatioFramesHide()
	ShowCombatUI( screen.Name )
end

function HandleMarketPurchase( screen, button )
	local item = button.Data

	if not HasResources( item.Cost ) then
		MarketPurchaseFailPresentation( screen, button )
		return
	end

	screen.NumSales = screen.NumSales + 1
	GameState.MarketSales = (GameState.MarketSales or 0) + 1

	local category = screen.ItemCategories[screen.ActiveCategoryIndex]

	local buttonIds = GetAllIds(
	{
		screen.Components["PurchaseButton"..button.Index],
		screen.Components["PurchaseButtonTitle"..button.Index],
		screen.Components["SellText"..button.Index],
		screen.Components["PinIcon"..button.Index],
		screen.Components["Icon"..button.Index],
		screen.Components["CurrentAmount"..button.Index],
	})

	MarketPurchaseSuccessPresentation( screen, button )
	if item.Priority then
		MarketPurchaseSuccessRepeatablePresentation( button )
	else
		item.SoldOut = true
		UseableOff({ Ids = buttonIds })
		SetAlpha({ Ids = buttonIds, Fraction = 0, Duration = 0.2 })
		ModifyTextBox({ Ids = buttonIds, FadeTarget = 0 })
		UpdateMarketScreenInteractionText( screen )
	end
	
	local resourceArgs = { ApplyMultiplier = false, OffsetX = 600, Silent = true }
	SpendResources( item.Cost, "ResourceShop", resourceArgs )
	ModifyTextBox({ Id = screen.Components.BasicResourceButton.Id, Text = GameState.Resources[screen.Components.BasicResourceButton.ResourceName] or 0, })

	if category.HideUnaffordable and not HasResources( item.Cost ) then
		UseableOff({ Ids = buttonIds })
		SetAlpha({ Ids = buttonIds, Fraction = 0, Duration = 0.2 })
		ModifyTextBox({ Ids = buttonIds, FadeTarget = 0 })
		UpdateMarketScreenInteractionText( screen )
	end

	MarketScreenUpdateResourceStatus( screen, button )

	wait(0.1)

	AddResource( item.BuyName, item.BuyAmount, "ResourceShop", resourceArgs )
	MarketScreenUpdateResourceStatus( screen, button )
	UpdateAffordabilityStatus()

	MarketScreenPurchaseFinishPresentation( screen, button, item )

end

function MarketScreenUpdateResourceStatus( screen, button )

	local category = screen.ItemCategories[screen.ActiveCategoryIndex]

	ModifyTextBox({ Id = screen.Components.BasicResourceButton.Id, Text = GameState.Resources[screen.Components.BasicResourceButton.ResourceName] or 0, })

	for itemIndex = 1, screen.NumItems do
		local button = screen.Components["PurchaseButton"..itemIndex]
		if button ~= nil then
			local item = button.Data
			if not item.SoldOut and item.Showing then
				local buyResourceData = ResourceData[item.BuyName]
				local costDisplay = item.Cost
				local costColor = Color.White
				if category.FlipSides then
					for resourceName, resourceAmount in pairs( item.Cost ) do
						buyResourceData = ResourceData[resourceName]
						costDisplay = {}
						costDisplay[item.BuyName] = item.BuyAmount
					end
				else
					if not HasResources( costDisplay ) then
						costColor = screen.CostUnaffordableColor
					end
				end
			
				ModifyTextBox({ Id = screen.Components["PurchaseButton"..itemIndex].Id, AffectText = "NeededPinResourceTooltip", ColorTarget = Color.Transparent })
				ModifyTextBox({ Id = screen.Components["SellText"..itemIndex].Id, ColorTarget = costColor, ColorDuration = 0.1 })
				ModifyTextBox({ Id = screen.Components["CurrentAmount"..itemIndex].Id, Text = "MarketScreen_InventoryAmount", LuaKey = "TempTextData", LuaValue = { InventoryAmount = GameState.Resources[buyResourceData.Name] or 0 } })

			end
		end
	end
end

function MarketScreenSelectCategory( screen, button )
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	WeaponShopScreenHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY })
	MarketScreenDisplayCategory( screen, button.CategoryIndex )
	WeaponShopUpdateVisibility( screen )
end

function MarketScreenNextCategory( screen, button )
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	local nextCategoryIndex = screen.ActiveCategoryIndex
	for i = 1, #screen.ItemCategories do
		nextCategoryIndex = nextCategoryIndex + 1
		if nextCategoryIndex > #screen.ItemCategories then
			nextCategoryIndex = 1
		end
		if not screen.ItemCategories[nextCategoryIndex].Locked then
			break
		end
	end
	if nextCategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	WeaponShopScreenHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY })
	MarketScreenDisplayCategory( screen, nextCategoryIndex )
	WeaponShopUpdateVisibility( screen )
end

function MarketScreenPrevCategory( screen, button )
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	local nextCategoryIndex = screen.ActiveCategoryIndex
	for i = 1, #screen.ItemCategories do
		nextCategoryIndex = nextCategoryIndex - 1
		if nextCategoryIndex < 1 then
			nextCategoryIndex =  #screen.ItemCategories
		end
		if not screen.ItemCategories[nextCategoryIndex].Locked then
			break
		end
	end
	if nextCategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	WeaponShopScreenHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY })
	MarketScreenDisplayCategory( screen, nextCategoryIndex )
	WeaponShopUpdateVisibility( screen )
end

function UpdateMarketScreenInteractionText( screen, button )

	local components = screen.Components

	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	if button ~= nil and button.Data ~= nil and button.Data.Cost ~= nil and HasResources( button.Data.Cost ) then
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		if category.FlipSides then
			ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.AltText })
		else
			ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.Text })
		end
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

	if screen.NumCategories >= 2 then
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 1.0, Duration = 0.0 })
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 1.0, Duration = 0.0 })
	else
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 0.0, Duration = 0.0 })
	end	

end

function HasUnviewedMarketItem( source, args )
	args = args or {}
	for i, category in ipairs( ScreenData.MarketScreen.ItemCategories ) do
		if args.CategoryIndex == nil or i == args.CategoryIndex then
			if not category.FlipSides and IsGameStateEligible( CurrentRun, category, category.GameStateRequirements ) then
				for j, item in ipairs( category ) do
					if not GameState.ItemsViewed[item.BuyName] and IsGameStateEligible( CurrentRun, item, item.GameStateRequirements ) then
						for k, marketItem in ipairs( CurrentRun.MarketItems[i] ) do
							if marketItem.BuyName == item.BuyName then
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
end