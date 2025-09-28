function UseMarketObject( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenMarketScreen()
	UseableOn({ Id = usee.ObjectId })
	MarketSessionCompletePresentation( usee, screen )
end

function GenerateMarketItems( source, args )
	args = args or {}
	if args.RefreshOncePerRun and CurrentRun.MarketItems ~= nil then
		return
	end

	CurrentRun.MarketItems = CurrentRun.MarketItems or {}
	for categoryIndex, category in ipairs( ScreenData.MarketScreen.ItemCategories ) do
		if ( category.RefreshOncePerRun and args.RefreshOncePerRun ) or ( not category.RefreshOncePerRun and not args.RefreshOncePerRun ) then
			CurrentRun.MarketItems[categoryIndex] = {}
			local nonPriorityItems = {}
			for j, buyData in ipairs( category ) do
				local requirementsMet = buyData.GameStateRequirements == nil or IsGameStateEligible( buyData, buyData.GameStateRequirements )
				if requirementsMet or category.ShowItemsWithUnmetRequirements then
					if ( category.ShowItemsWithUnmetRequirements and requirementsMet ) or ( not category.ShowItemsWithUnmetRequirements and buyData.Priority ) then
						table.insert( CurrentRun.MarketItems[categoryIndex], DeepCopyTable( buyData ) )
					else
						table.insert( nonPriorityItems, buyData )
					end
				end
			end
			for i, chosenOption in ipairs( nonPriorityItems ) do
				local dataCopy = DeepCopyTable( chosenOption )
				if category.ShowItemsWithUnmetRequirements then
					dataCopy.HasUnmetRequirements = true
				end
				table.insert( CurrentRun.MarketItems[categoryIndex], dataCopy )
			end
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

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	screen.ActiveCategoryIndex = args.DefaultCategoryIndex or 1

	-- Regenerate sell/exchange items dynamically.
	-- Purchaseable items will have already been generated upfront in DeathLoopData.
	GenerateMarketItems()

	local components = screen.Components
	local tabsToReveal = nil
	local tabsWithNewItems = nil

	screen.NumCategories = 0

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY
	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY

	local categoryTitleX = screen.CategoryStartX
	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		if category.GameStateRequirements == nil or IsGameStateEligible( category, category.GameStateRequirements ) then
			local slotName = category.Name
			local categoryButton = CreateScreenComponent({
				Name = "ButtonInventoryTab",
				X = categoryTitleX,
				Y = screen.CategoryStartY,
				Group = "Combat_Menu_Overlay",
				Alpha = 0.0
			})
			categoryButton.OnPressedFunctionName = "MarketScreenSelectCategory"
			categoryButton.Category = slotName
			categoryButton.CategoryIndex = categoryIndex
			screen.Components["Category"..slotName] = categoryButton

			local categoryButtonIcon = CreateScreenComponent({
				Name = "BlankObstacle",
				Group = "Combat_Menu_Overlay",
				Scale = screen.CategoryIconScale,
				Alpha = 0.0,
				X = categoryTitleX + screen.CategoryIconOffsetX,
				Y = screen.CategoryStartY + screen.CategoryIconOffsetY
			})
			SetAnimation({ DestinationId = categoryButtonIcon.Id, Name = category.Icon })
			categoryButton.IconId = categoryButtonIcon.Id
			screen.Components["CategoryIcon"..slotName] = categoryButtonIcon

			local shouldFadeIn = true
			if categoryIndex ~= screen.ActiveCategoryIndex then
				if not GameState.WorldUpgradesRevealed[slotName] then
					tabsToReveal = tabsToReveal or {}
					table.insert( tabsToReveal, categoryButton )
					shouldFadeIn = false
				end
				if HasUnviewedMarketItem( screen, { CategoryIndex = categoryIndex } ) then
					tabsWithNewItems = tabsWithNewItems or {}
					table.insert( tabsWithNewItems, categoryButton )
				end
			end

			if shouldFadeIn then
				SetAlpha({ Id = categoryButton.Id, Fraction = 1.0, Duration = 0.1 })
				SetAlpha({ Id = categoryButtonIcon.Id, Fraction = 1.0, Duration = 0.1 })
			end

			screen.NumCategories = screen.NumCategories + 1
			GameState.WorldUpgradesRevealed[slotName] = true
		else
			category.Locked = true
		end

		if category.Locked then
			local categoryButton = CreateScreenComponent({
				Name = "BlankObstacle",
				X = categoryTitleX,
				Y = screen.CategoryStartY,
				Group = "Combat_Menu_Overlay",
				Animation = "GUI/Screens/Inventory/CategoryTabInactive",
				Scale = 0.5,
				Alpha = 0.0
			})
			screen.Components["InactiveCategory"..category.Name] = categoryButton
			SetAlpha({ Id = categoryButton.Id, Fraction = 1.0, Duration = 0.1 })
		end

		categoryTitleX = categoryTitleX + screen.CategorySpacingX
	end

	if tabsToReveal ~= nil then
		-- Tab reveals take a while, so display the active category title and currency info early
		ModifyTextBox({ Id = components.CategoryTitleText.Id, Text = screen.ItemCategories[screen.ActiveCategoryIndex].Name })
		local currencyResourceName = screen.ItemCategories[screen.ActiveCategoryIndex].CurrencyResourceName
		local resourceData = ResourceData[currencyResourceName]
		SetAnimation({ DestinationId = components.BasicResourceButton.Id, Name = resourceData.TextIconPath or resourceData.IconPath or resourceData.Icon })
		ModifyTextBox({ Id = components.BasicResourceButton.Id, Text = GameState.Resources[currencyResourceName] or 0, })

		for i, categoryButton in ipairs( tabsToReveal ) do
			WeaponShopRevealCategoryPresentation( screen, screen.ItemCategories[categoryButton.Category], categoryButton )
		end
	end

	if tabsWithNewItems ~= nil then
		for i, categoryButton in ipairs( tabsWithNewItems ) do
			local newButtonKey = "NewIcon"..categoryButton.Category
			components[newButtonKey] = CreateScreenComponent({
				Name = "BlankObstacle",
				Animation = "NewTabStar",
				Group = "Combat_Menu_Overlay",
				Alpha = 0.0,
				AlphaTarget = 1.0,
				AlphaTargetDuration = 0.1,
			})
			Attach({ Id = components[newButtonKey].Id, DestinationId = categoryButton.Id, OffsetX = screen.NewTabIconOffsetX, OffsetY = screen.NewTabIconOffsetY })
		end
	end

	MarketScreenDisplayCategory( screen, screen.ActiveCategoryIndex, { FirstOpen = true } )
	WeaponShopUpdateVisibility( screen )
	UpdateMarketScreenInteractionText( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )

	MarketScreenOpenPresentation( screen )

	HandleScreenInput( screen )
	return screen

end

function MarketScreenDisplayCategory( screen, categoryIndex, args )

	args = args or {}
	screen.SelectedItem = nil

	local components = screen.Components

	local slotName = screen.ItemCategories[categoryIndex].Name
	ModifyTextBox({ Id = components["Category"..slotName].Id, Color = Color.White })
	DestroyTextBox({ Id = components.BackgroundDim.Id })

	-- Cleanup prev category
	local prevCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	StopAnimation({ DestinationId = screen.Components["Category"..prevCategory.Name].Id, Name = "InventoryTabHighlightActiveCategory" })

	local category = screen.ItemCategories[categoryIndex]
	local slotName = category.Name

	GameState.WorldUpgradesViewed[category.Name] = true
	local newButtonKey = "NewIcon"..category.Name
	if components[newButtonKey] ~= nil then
		Destroy({ Id = components[newButtonKey].Id })
	end

	-- Highlight new category
	CreateAnimation({ DestinationId = screen.Components["Category"..slotName].Id, Name = "InventoryTabHighlightActiveCategory", Group = "Combat_Menu_Overlay" })
	ModifyTextBox({ Id = screen.Components.CategoryTitleText.Id, Text = category.Name })

	screen.ActiveCategoryIndex = categoryIndex

	local currencyResourceName = screen.ItemCategories[categoryIndex].CurrencyResourceName
	local resourceData = ResourceData[currencyResourceName]
	SetAnimation({ DestinationId = components.BasicResourceButton.Id, Name = resourceData.TextIconPath or resourceData.IconPath or resourceData.Icon })
	ModifyTextBox({ Id = components.BasicResourceButton.Id, Text = GameState.Resources[currencyResourceName] or 0, })

	if not args.FirstOpen and screen.CurrentFlipSides ~= category.FlipSides then
		if category.FlipSides then
			-- Sell Mode
			SetAnimation({ DestinationId = screen.Components.Background.Id, Name = "MarketScreenTransitionBuyToSell" })
			screen.CloseAnimation = "MarketScreenOutSell"
			screen.CurrentFlipSides = true
		else
			-- Buy Mode
			SetAnimation({ DestinationId = screen.Components.Background.Id, Name = "MarketScreenTransitionSellToBuy" })
			screen.CloseAnimation = "MarketScreenOutBuy"
			screen.CurrentFlipSides = false
		end
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
			local anim = "MarketScreenButtonBuy"
			local highlightAnim = "MarketScreenButtonInBuy"
			local mouseOffAnim = "MarketScreenButtonOutBuy"
			local purchaseAnim = "MarketScreenButtonPurchaseBuy"
			if category.FlipSides then
				for resourceName, resourceAmount in pairs( item.Cost ) do
					buyResourceData = ResourceData[resourceName]
					item.LeftDisplayName = resourceName
					item.LeftDisplayAmount = resourceAmount
					costDisplay = {}
					costDisplay[item.BuyName] = item.BuyAmount
					costText = "ResourceCostSelling"
					unaffordableColor = Color.White
					anim = "MarketScreenButtonSell"
					highlightAnim = "MarketScreenButtonInSell"
					mouseOffAnim = "MarketScreenButtonOutSell"
					purchaseAnim = "MarketScreenButtonPurchaseSell"
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
				local button = CreateScreenComponent({
					Name = "BlankInteractableObstacle",
					Group = "Combat_Menu_Overlay",
					X = itemLocationX,
					Y = itemLocationY,
					Animation = anim,
					Alpha = 0.0,
				})
				components[purchaseButtonKey] = button
				SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = screen.TooltipOffsetX })
				if category.FlipSides then
					SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "RepeatDelay", Value = 0.6 })
					button.InputBlockDuration = 0.02
				end
				AttachLua({ Id = button.Id, Table = button })
				button.Screen = screen
				button.OnPressedFunctionName = "HandleMarketPurchase"
				button.OnMouseOverFunctionName = "MarketScreenMouseOverItem"
				button.OnMouseOffFunctionName = "MarketScreenMouseOffItem"
				button.Animation = anim
				button.HighlightAnimation = highlightAnim
				button.MouseOffAnimation = mouseOffAnim
				button.PurchaseAnimation = purchaseAnim

				if not firstUseable then
					screen.CursorStartX = itemLocationX
					screen.CursorStartY = itemLocationY
					firstUseable = true
				end

				-- Left Column

				local iconKey = "Icon"..screen.NumItems
				components[iconKey] = CreateScreenComponent({
					Name = "BlankObstacle",
					Group = "Combat_Menu_Overlay",
					Animation = buyResourceData.IconPath,
					Scale = buyResourceData.IconScale,
					Alpha = 0.0,
				})

				local itemNameFormat = screen.ItemNameFormat
				if item.HasUnmetRequirements then
					itemNameFormat = screen.UnmetRequirementsItemNameFormat
				end
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
				components[currentAmountKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", X = itemLocationX, Y = itemLocationY, Alpha = 0.0 })
				local itemAmountFormat = screen.ItemAmountFormat
				itemAmountFormat.Id = components[currentAmountKey].Id
				itemAmountFormat.Text = "MarketScreen_InventoryAmount"
				itemAmountFormat.LuaKey = "TempTextData"
				itemAmountFormat.LuaValue = { InventoryAmount = GameState.Resources[buyResourceData.Name] or 0 }
				CreateTextBox( itemAmountFormat )

				local amountNeededByPins = GetResourceAmountNeededByPins( item.BuyName )
				if amountNeededByPins > 0 then
					local pinButtonKey = "PinIcon"..screen.NumItems
					local pinAnimation = "StoreItemPin"
					local pinTooltip = "NeededPinResourceTooltip"
					if HasResource( item.BuyName, amountNeededByPins ) then
						pinAnimation = "StoreItemPin_Complete"
						pinTooltip = "CompletedPinResourceTooltip"
					end
					components[pinButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Animation = pinAnimation, Alpha = 0.0 })
					components[pinButtonKey].AlwaysVisible = true
					Attach({ Id = components[pinButtonKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.PinOffsetX, OffsetY = UIData.PinIconListOffsetY })
					components[purchaseButtonKey].PinButtonId = components[pinButtonKey].Id
					components[purchaseButtonKey].PinTooltip = pinTooltip
					-- Silent toolip
					CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = pinTooltip, Color = Color.Transparent })
				end

				local bannerIcon = nil
				if not item.Priority then
					bannerIcon = screen.LimitedOfferBannerIcon
					CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "Market_LimitedTimeOffer", Color = Color.Transparent })
				elseif item.HasUnmetRequirements then
					bannerIcon = screen.NeededResourceBannerIcon
					CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "MarketEarlySellWarningTooltip", Color = Color.Transparent })
				end

				if bannerIcon ~= nil then
					local bannerIconKey = "BannerIcon"..screen.NumItems
					components[bannerIconKey] = CreateScreenComponent({
						Name = "BlankObstacle",
						Group = "Combat_Menu_Overlay",
						Animation = bannerIcon,
						Alpha = 0.0,
					})
					Attach({ Id = components[bannerIconKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.BannerIconOffsetX, OffsetY = screen.BannerIconOffsetY })
				end

				if not category.FlipSides and not GameState.ItemsViewed[item.BuyName] then
					local newIconKey = "NewIcon"..screen.NumItems
					components[newIconKey] = CreateScreenComponent({
						Name = "BlankObstacle",
						Group = screen.ComponentData.DefaultGroup,
						Animation = "MusicPlayerNewTrack",
						Alpha = 0.0,
					})
					Attach({ Id = components[newIconKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.NewIconOffsetX, OffsetY = screen.NewIconOffsetY })
					components[purchaseButtonKey].NewButtonId = components[newIconKey].Id
				end

				-- Right Column

				local sellTextKey = "SellText"..screen.NumItems
				components[sellTextKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Alpha = 0.0 })
				Attach({ Id = components[sellTextKey].Id, DestinationId = components[purchaseButtonKey].Id })
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

	UpdateMarketScreenInteractionText( screen )

end

function CloseMarketScreen( screen, button )
	UpdateAffordabilityStatus()
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

	local isRapidPurchase = NotifyResultsTable.LastUseWasRepeat

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
		screen.Components["BannerIcon"..button.Index],
		screen.Components["CurrentAmount"..button.Index],
	})

	if isRapidPurchase then
		MarketRapidPurchasePresentation( screen, button )
	else
		MarketPurchaseSuccessPresentation( screen, button )
	end

	if item.Priority then
		if not isRapidPurchase then
			MarketPurchaseSuccessRepeatablePresentation( button )
		end
	else
		item.SoldOut = true
		UseableOff({ Ids = buttonIds })
		SetAlpha({ Ids = buttonIds, Fraction = 0, Duration = 0.2 })
		ModifyTextBox({ Ids = buttonIds, FadeTarget = 0 })
		UpdateMarketScreenInteractionText( screen )
	end
	
	local resourceArgs = { ApplyMultiplier = false, OffsetX = 600, Silent = true }
	SpendResources( item.Cost, "ResourceShop", resourceArgs )
	ModifyTextBox({ Id = screen.Components.BasicResourceButton.Id, Text = GameState.Resources[category.CurrencyResourceName] or 0, })

	if category.HideUnaffordable and not HasResources( item.Cost ) then
		item.SoldOut = true
		UseableOff({ Ids = buttonIds })
		SetAlpha({ Ids = buttonIds, Fraction = 0, Duration = 0.2 })
		ModifyTextBox({ Ids = buttonIds, FadeTarget = 0 })
		UpdateMarketScreenInteractionText( screen )
	end

	MarketScreenUpdateResourceStatus( screen )

	if isRapidPurchase then
		wait(0.02)
	else
		wait(0.1)
	end

	AddResource( item.BuyName, item.BuyAmount, "ResourceShop", resourceArgs )
	MarketScreenUpdateResourceStatus( screen )

	MarketScreenPurchaseFinishPresentation( screen, button, item )

	CheckAchievement( screen, { Name = "AchEarnPrestige1" } )

end

function MarketScreenSellAll( screen, button )
	local buttonIds = GetAllIds(
	{
		screen.Components["PurchaseButton"..button.Index],
		screen.Components["PurchaseButtonTitle"..button.Index],
		screen.Components["SellText"..button.Index],
		screen.Components["PinIcon"..button.Index],
		screen.Components["Icon"..button.Index],
		screen.Components["BannerIcon"..button.Index],
		screen.Components["CurrentAmount"..button.Index],
	})
	UseableOff({ Ids = buttonIds })
	SetAlpha({ Ids = buttonIds, Fraction = 0, Duration = 0.2 })
	ModifyTextBox({ Ids = buttonIds, FadeTarget = 0 })

	local item = button.Data
	item.SoldOut = true

	local sellKey = GetFirstKey(item.Cost)
	local sellCount = GameState.Resources[sellKey]

	local newCost = ShallowCopyTable( item.Cost )
	newCost[sellKey] = newCost[sellKey] * sellCount

	local resourceArgs = { Silent = true }
	SpendResources( newCost, "ResourceShop", resourceArgs )
	AddResource( item.BuyName, item.BuyAmount * sellCount, "ResourceShop", resourceArgs )

	MarketSellAllPresentation( screen, button )
	MarketScreenUpdateResourceStatus( screen )
	UpdateMarketScreenInteractionText( screen )
	UpdateAffordabilityStatus()
end

function MarketScreenShowSellAllPrompt( screen )
	if not screen.ItemCategories[screen.ActiveCategoryIndex].FlipSides then
		return
	end
	if screen.SelectedItem == nil then
		return
	end

	local button = screen.SelectedItem
	if button.Data.SoldOut then
		return
	end

	OpenSellAllMarketPromptScreen( screen, button )
	if screen.DoSellAll then
		MarketScreenSellAll( screen, button )
	end
	screen.DoSellAll = nil
end

function MarketScreenUpdateResourceStatus( screen )

	local category = screen.ItemCategories[screen.ActiveCategoryIndex]

	ModifyTextBox({ Id = screen.Components.BasicResourceButton.Id, Text = GameState.Resources[category.CurrencyResourceName] or 0, })

	for itemIndex = 1, screen.NumItems do
		local button = screen.Components["PurchaseButton"..itemIndex]
		if button ~= nil then
			local item = button.Data
			if not item.SoldOut and item.Showing then
				local buyResourceData = ResourceData[item.BuyName]
				local costDisplay = item.Cost
				local costColor = Color.White
				local hasEnoughForPins = false
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
					if button.PinButtonId ~= nil then
						local amountNeededByPins = GetResourceAmountNeededByPins( item.BuyName )
						if HasResource( item.BuyName, amountNeededByPins ) then
							hasEnoughForPins = true
							SetAnimation({ DestinationId = button.PinButtonId, Name = "StoreItemPin_Complete" })
						end
					end
				end
			
				if hasEnoughForPins then
					local purchaseButton = screen.Components["PurchaseButton"..itemIndex]
					if purchaseButton.PinTooltip == "NeededPinResourceTooltip" then
						DestroyTextBox({ Id = purchaseButton.Id, AffectText = purchaseButton.PinTooltip, RemoveTooltips = true })
						purchaseButton.PinTooltip = "CompletedPinResourceTooltip"
						CreateTextBox({ Id = purchaseButton.Id, TextSymbolScale = 0, Text = purchaseButton.PinTooltip, Color = Color.Transparent })
					end
				end
				ModifyTextBox({ Id = screen.Components["SellText"..itemIndex].Id, ColorTarget = costColor, ColorDuration = 0.1 })
				ModifyTextBox({ Id = screen.Components["CurrentAmount"..itemIndex].Id, Text = "MarketScreen_InventoryAmount", LuaKey = "TempTextData", LuaValue = { InventoryAmount = GameState.Resources[buyResourceData.Name] or 0 } })

			end
		end
	end
end

function MarketScreenSelectCategory( screen, button )
	if button.CategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	WeaponShopScreenHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	MarketScreenDisplayCategory( screen, button.CategoryIndex )
	WeaponShopUpdateVisibility( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
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
	MarketScreenDisplayCategory( screen, nextCategoryIndex )
	WeaponShopUpdateVisibility( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
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
	MarketScreenDisplayCategory( screen, nextCategoryIndex )
	WeaponShopUpdateVisibility( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
end

function UpdateMarketScreenInteractionText( screen, button )

	local components = screen.Components

	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	if button == nil or button.Data == nil then
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		SetAlpha({ Id = components.SellAllButton.Id, Fraction = 0.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		if screen.ActiveCategoryIndex == 3 then
			ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.AltTexts[1] })
		elseif screen.ActiveCategoryIndex == 4 then
			ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.AltTexts[2] })
		else
			ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.Text })
		end
		if category.FlipSides then
			SetAlpha({ Id = components.SellAllButton.Id, Fraction = 1.0, Duration = 0.2 })
			if screen.ActiveCategoryIndex == 4 then
				ModifyTextBox({ Id = components.SellAllButton.Id, Text = components.SellAllButton.AltTexts[1] })
			else
				ModifyTextBox({ Id = components.SellAllButton.Id, Text = components.SellAllButton.Text })
			end
		else
			SetAlpha({ Id = components.SellAllButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
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
			if not category.FlipSides and (category.GameStateRequirements == nil or IsGameStateEligible( category, category.GameStateRequirements ) ) then
				for j, item in ipairs( category ) do
					if not GameState.ItemsViewed[item.BuyName] and (item.GameStateRequirements == nil or IsGameStateEligible( item, item.GameStateRequirements ) ) then
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

function HasAllWorldUpgradesRequiringResource( source, args )
	args = args or {}
	local resourceName = args.ResourceName or GetFirstKey( source.Cost )
	for worldUpgrade, worldUpgradeData in pairs( WorldUpgradeData ) do
		if worldUpgradeData.Cost ~= nil and worldUpgradeData.Cost[resourceName] ~= nil then
			if worldUpgradeData.Repeatable then
				if worldUpgradeData.OnActivateFinishedFunctionArgs ~= nil and worldUpgradeData.OnActivateFinishedFunctionArgs.ResourceName ~= nil and not HasAllWorldUpgradesRequiringResource(source, { ResourceName = worldUpgradeData.OnActivateFinishedFunctionArgs.ResourceName }) then
					return false
				end
			elseif not GameState.WorldUpgradesAdded[worldUpgrade] then
				return false
			end
		end
	end
	for weaponName, weaponData in pairs( WeaponShopItemData ) do
		if weaponData.Cost ~= nil and weaponData.Cost[resourceName] ~= nil then
			if not GameState.WeaponsUnlocked[weaponName] then
				return false
			end
		end
	end
	return true
end

function IsMarketItemInStock( source, args )
	for categoryIndex, categoryItems in ipairs( CurrentRun.MarketItems ) do
		for itemIndex, itemData in ipairs( categoryItems ) do
			if itemData.BuyName == args.Name and not itemData.SoldOut then
				return true
			end
		end
	end
	return false
end
