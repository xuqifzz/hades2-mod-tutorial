function UseGhostAdmin( usee, args )
	thread( PlayInteractAnimation, usee.ObjectId, { Animation = "MelTalkBrooding01" } )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenGhostAdminScreen( usee )
	UseableOn({ Id = usee.ObjectId })
	GhostAdminSessionCompletePresentation( usee, screen )
end

function OpenGhostAdminScreen( openedFrom, defaultCategoryIndex )

	AltAspectRatioFramesShow()

	AddInputBlock({ Name = "OpenGhostAdminScreen" })
	local screen = DeepCopyTable( ScreenData.GhostAdmin )
	screen.OpenedFrom = openedFrom
	screen.ActiveCategoryIndex = defaultCategoryIndex or 1

	if IsScreenOpen( screen.Name ) then
		return
	end

	ZeroMouseTether( screen.Name )
	LockCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 0.7, OffsetX = screen.CameraOffetX, OffsetY = screen.CameraOffetY, EaseIn = 0, EaseOut = 1.0 })
	HideCombatUI( screen.Name )
	wait( 0.35 )

	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY
	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY
	screen.CostDisplay.StartX = screen.CostDisplay.StartX + ScreenCenterNativeOffsetX
	screen.CostDisplay.StartY = screen.CostDisplay.StartY + ScreenCenterNativeOffsetY

	local components = screen.Components

	screen.NumCategories = 0

	local categoryTitleX = screen.CategoryStartX
	for slotIndex, category in ipairs( screen.ItemCategories ) do
		if category.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, category, category.GameStateRequirements ) then

			local slotName = category.Name

			local categoryButton = CreateScreenComponent({ Name = "BlankInteractableObstacle",
					X = categoryTitleX,
					Y = screen.CategoryStartY,
					Animation = category.Animations.Default,
					Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.1,
					Group = screen.ComponentData.DefaultGroup, })
			categoryButton.DefaultAnimation = category.DefaultAnimation
			categoryButton.Animations = category.Animations
			categoryButton.OnPressedFunctionName = "GhostAdminSelectCategory"
			categoryButton.OnMouseOverFunctionName = "MouseOverGhostAdminCategory"
			categoryButton.OnMouseOffFunctionName = "MouseOffGhostAdminCategory"
			categoryButton.Screen = screen
			categoryButton.CategoryIndex = slotIndex
			components["Category"..slotIndex] = categoryButton
			AttachLua({ Id = categoryButton.Id, Table = categoryButton })
			SetInteractProperty({ DestinationId = categoryButton.Id, Property = "FreeFormSelectable", Value = false })
			
			local activeOverlay = CreateScreenComponent({ Name = "BlankObstacle",
					X = categoryTitleX,
					Y = screen.CategoryStartY,
					Animation = category.Animations.Active,
					Alpha = 0.0,
					Group = screen.ComponentData.DefaultGroup, })
			categoryButton.ActiveOverlayId = activeOverlay.Id
			screen.Components["CategoryActiveOverlay"..slotIndex] = activeOverlay

			local categoryButtonIcon = CreateScreenComponent({ Name = "BlankObstacle", Scale = screen.CategoryIconScale,
					X = categoryTitleX + screen.CategoryIconOffsetX,
					Y = screen.CategoryStartY + screen.CategoryIconOffsetY,
					Animation = category.Icon,
					Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.1,
					Group = screen.ComponentData.DefaultGroup,
					})
			categoryButton.IconId = categoryButtonIcon.Id
			categoryButton.IconShiftRequests = {}
			screen.Components["CategoryIcon"..slotIndex] = categoryButtonIcon

			if slotIndex ~= screen.ActiveCategoryIndex then
				if not GameState.WorldUpgradesViewed[slotName]  then
					WeaponShopRevealCategoryPresentation( screen, category, categoryButton )
				end
				if HasUnviewedWorldUpgrade( category ) then
					-- New icon
					local newButtonKey = "NewIcon"..slotName
					components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Animation = "NewTabStar", Group = screen.ComponentData.DefaultGroup, Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.1, })
					Attach({ Id = components[newButtonKey].Id, DestinationId = categoryButton.Id, OffsetX = 0, OffsetY = -30 })
				elseif not HasUnpurchasedCosmetic( slotName ) then
					-- Complete icon
					--[[
					local completeButtonKey = "CompleteIcon"..slotName
					components[completeButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay" })
					SetAnimation({ DestinationId = components[completeButtonKey].Id , Name = "ContractorPurchasedCheckmark" })
					Attach({ Id = components[completeButtonKey].Id, DestinationId = categoryButton.Id, OffsetX = 0, OffsetY = -30 })
					]]
				end
			end

			GameState.WorldUpgradesViewed[slotName] = true

			screen.NumCategories = screen.NumCategories + 1
			categoryTitleX = categoryTitleX + screen.CategorySpacingX

		end
	end

	GhostAdminDisplayCategory( screen, components["Category"..screen.ActiveCategoryIndex] )

	GhostAdminUpdateVisibility( screen )

	UpdateGhostAdminInteractionText( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "OpenGhostAdminScreen" })

	thread( GenericScreenOpenEndPresentation, screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen

end

function GhostAdminAllowViewItem( screen, category, cosmeticData )

	if CurrentRun.ViewableWorldUpgrades[cosmeticData.Name] then
		return true
	end

	local viewRecord = CurrentRun.ScreenViewRecord[screen.Name] or 0
	if category.OneRevealPerRun and not cosmeticData.AlwaysRevealImmediately and (viewRecord > 1 or (viewRecord == 1 and not IsScreenOpen( screen.Name ))) then
		return false
	end

	 if cosmeticData.GameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, cosmeticData, cosmeticData.GameStateRequirements ) then
		return false
	end

	return true

end

function GhostAdminDisplayCategory( screen, button )

	local components = screen.Components

	local prevCategoryIndex = screen.ActiveCategoryIndex
	local prevCategoryButton = components["Category"..prevCategoryIndex]

	if prevCategoryButton ~= nil then
		SetAlpha({ Id = prevCategoryButton.ActiveOverlayId, Fraction = 0.0, Duration = 0.1 })
		SetAnimation({ DestinationId = prevCategoryButton.Id, Name = prevCategoryButton.Animations.Default })
		local previousShift = not IsEmpty( prevCategoryButton.IconShiftRequests )
		prevCategoryButton.IconShiftRequests.Open = nil
		if previousShift and IsEmpty( prevCategoryButton.IconShiftRequests ) then
			Move({ Id = prevCategoryButton.IconId, Angle = 270, Distance = screen.CategoryIconMouseOverShiftDistance, Speed = screen.CategoryIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
		end
	end

	local category = screen.ItemCategories[button.CategoryIndex]
	local slotName = category.Name

	-- Highlight new category
	SetAlpha({ Id = button.ActiveOverlayId, Fraction = 1.0, Duration = 0.1 })
	ModifyTextBox({ Id = components.CategoryTitleText.Id, Text = slotName })
	local previousShift = not IsEmpty( button.IconShiftRequests )
	button.IconShiftRequests.Open = true
	if not previousShift then
		Move({ Id = button.IconId, Angle = 90, Distance = screen.CategoryIconMouseOverShiftDistance, Speed = screen.CategoryIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
	end

	local newButtonKey = "NewIcon"..slotName
	if components[newButtonKey] ~= nil then
		Destroy({ Id = components[newButtonKey].Id })
	end

	screen.ActiveCategoryIndex = button.CategoryIndex

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	screen.AvailableItems = {}
	screen.PurchasedItems = {}

	CurrentRun.ViewableWorldUpgrades = CurrentRun.ViewableWorldUpgrades or {}
	for i, cosmeticName in ipairs( screen.ItemCategories[button.CategoryIndex] ) do
		local cosmeticData = WorldUpgradeData[cosmeticName]
		DebugAssert({ Condition = cosmeticData ~= nil, Text = cosmeticName.." listed in GhostAdminData but does not exist in WorldUpgradeData" })
		if GhostAdminAllowViewItem( screen, category, cosmeticData ) then
			CurrentRun.ViewableWorldUpgrades[cosmeticName] = true
			if GameState.WorldUpgradesAdded[cosmeticName] and not cosmeticData.Repeatable then
				table.insert( screen.PurchasedItems, cosmeticData )
			else
				table.insert( screen.AvailableItems, cosmeticData )
			end
		end
	end

	-- Validation
	--[[
	if verboseLogging then
		local allItems = {}
		for i, category in ipairs( screen.ItemCategories ) do
			for j, itemName in ipairs( category ) do
				allItems[itemName] = true
			end
		end
		for itemName, item in pairs( WorldUpgradeData ) do
			if not item.DebugOnly and not allItems[itemName] then
				DebugAssert({ Condition = false, Text = itemName.." not categorized in GhostAdminData" })
			end
		end
	end
	]]

	screen.NumItems = 0
	screen.NumItemsPurchaseable = 0
	screen.NumItemsAffordable = 0

	local firstUseable = false

	-- Available
	for k, cosmetic in ipairs( screen.AvailableItems ) do

		screen.NumItems = screen.NumItems + 1
		screen.NumItemsPurchaseable = screen.NumItemsPurchaseable + 1
		if HasResources( cosmetic.Cost ) then
			screen.NumItemsAffordable = screen.NumItemsAffordable + 1
		end

		local purchaseButtonKey = "PurchaseButton"..screen.NumItems
		components[purchaseButtonKey] = CreateScreenComponent({ Name = "BlankInteractableObstacle", X = itemLocationX, Y = itemLocationY, Group = screen.ComponentData.DefaultGroup,
			Animation = screen.ItemAvailableAnimation,
			Alpha = 0.0,
			})
		SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
		local button = components[purchaseButtonKey]
		button.Animation = screen.ItemAvailableAnimation
		button.HighlightAnimation = screen.ItemAvailableHighlightAnimation
		AttachLua({ Id = button.Id, Table = button })
		button.Screen = screen
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })

		local iconKey = "Icon"..screen.NumItems
		if cosmetic.Icon ~= nil then
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX + screen.IconOffsetX, Y = itemLocationY, Scale = screen.IconScale, Group = screen.ComponentData.DefaultGroup,
				Animation = cosmetic.Icon,
				Alpha = 0.0,
				})
		end

		local name = cosmetic.Name
		local displayName = name

		local format = screen.ItemAvailableAffordableNameFormat
		local resourceData = ResourceData[cosmetic.ResourceName]
		if not HasResources( cosmetic.Cost ) then
			format = screen.ItemAvailableUnaffordableNameFormat
		end

		local itemNameFormat = ShallowCopyTable( format )
		itemNameFormat.Id = button.Id
		itemNameFormat.Text = displayName
		CreateTextBox( itemNameFormat )

		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = displayName,
			UseDescription = true,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = cosmetic,
		})
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })

		button.OnMouseOverFunctionName = "MouseOverGhostAdminItem"
		button.OnMouseOffFunctionName = "MouseOffGhostAdminItem"
		button.OnPressedFunctionName = "HandleGhostAdminPurchase"
		if not firstUseable then
			screen.CursorStartX = itemLocationX
			screen.CursorStartY = itemLocationY
			firstUseable = true
		end

		button.Data = cosmetic
		button.Index = screen.NumItems
		button.DisplayName = name

		-- Pin icon
		local pinButtonKey = "PinIcon"..screen.NumItems
		components[pinButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Alpha = 0.0, })
		Attach({ Id = components[pinButtonKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.PinOffsetX, OffsetY = UIData.PinIconListOffsetY })
		components[purchaseButtonKey].PinButtonId = components[pinButtonKey].Id
		if HasStoreItemPin( button.Data.Name ) then
			components[purchaseButtonKey].IsPinned = true
			SetAnimation({ Name = "StoreItemPin", DestinationId = components[purchaseButtonKey].PinButtonId })
			-- Silent toolip
			CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
		end

		-- New icon
		if not GameState.WorldUpgradesViewed[cosmetic.Name] then
			local newIconKey = "NewIcon"..screen.NumItems
			components[newIconKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Alpha = 0.0, Animation = "MusicPlayerNewTrack" })
			Attach({ Id = components[newIconKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 300, OffsetY = 0 })
			components[purchaseButtonKey].NewButtonId = components[newIconKey].Id
		end

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	-- Purchased
	for k, cosmetic in ipairs( screen.PurchasedItems ) do

		screen.NumItems = screen.NumItems + 1

		local animName = screen.ItemAvailableAnimation
		local highlightAnimName = screen.ItemAvailableHighlightAnimation
		if not cosmetic.Removable or ( cosmetic.RotateOnly and GameState.WorldUpgrades[cosmetic.Name] ) then
			animName = screen.ItemAvailableAnimation
			highlightAnimName = screen.ItemPurchasedHighlightAnimation
		end

		local purchaseButtonKey = "PurchaseButton"..screen.NumItems
		components[purchaseButtonKey] = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = screen.ComponentData.DefaultGroup, X = itemLocationX, Y = itemLocationY, Animation = animName, Alpha = 0.0, })
		SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
		local button = components[purchaseButtonKey]
		button.Animation = animName
		button.HighlightAnimation = highlightAnimName
		AttachLua({ Id = button.Id, Table = button })
		button.Screen = screen
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })

		if cosmetic.Icon ~= nil then
			local iconKey = "Icon"..screen.NumItems
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX + screen.IconOffsetX, Y = itemLocationY, Scale = screen.IconScale, Group = screen.ComponentData.DefaultGroup,
				Animation = cosmetic.Icon, Alpha = 0.0,
				})
		end

		local name = cosmetic.Name
		local displayName = cosmetic.RePurchaseName or name
		local costText = "Shop_Purchased"
		if cosmetic.Removable then
			if GameState.WorldUpgrades[name] then
				if not cosmetic.RotateOnly then
					components[purchaseButtonKey].OnPressedFunctionName = "HandleGhostAdminRemoval"
					costText = "Shop_Removable"
				end
			else
				components[purchaseButtonKey].Free = true
				components[purchaseButtonKey].OnPressedFunctionName = "HandleGhostAdminPurchase"
				costText = "Shop_ReAdd"
			end
		end

		local itemNameFormat = ShallowCopyTable( screen.ItemPurchasedNameFormat )
		itemNameFormat.Id = button.Id
		itemNameFormat.Text = displayName
		CreateTextBox( itemNameFormat )

		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = displayName,
			UseDescription = true,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = cosmetic,
		})
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })

		button.OnMouseOverFunctionName = "MouseOverGhostAdminItem"
		button.OnMouseOffFunctionName = "MouseOffGhostAdminItem"

		if not firstUseable then
			screen.CursorStartX = itemLocationX
			screen.CursorStartY = itemLocationY
			firstUseable = true
		end

		button.Data = cosmetic
		button.Index = screen.NumItems
		button.DisplayName = name
		button.Purchased = true

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	SetAlpha({ Ids = { components.Scrollbar.Id, components.ScrollbarSlider.Id }, Fraction = 1.0, Duration = 0.1 })

	GhostAdminPostDisplayCategoryPresentation( screen )

end

function HasUnviewedCosmetic( slotName )
	if slotName == "Music" then
		for trackName, trackData in pairs( MusicPlayerTrackData ) do
			if not trackData.DebugOnly and trackData.ResourceCost ~= nil and not GameState.WorldUpgradesAdded[trackData.Name] then
				if trackData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, trackData, trackData.GameStateRequirements ) then
					if not GameState.WorldUpgradesViewed[trackData.Name] then
						return true
					end
				end
			end
		end
	else
		for cosmeticName, cosmeticData in pairs( WorldUpgradeData ) do
			if not cosmeticData.DebugOnly and cosmeticData.ResourceCost ~= nil and not cosmeticData.Disabled and cosmeticData.Slot == slotName and not GameState.WorldUpgradesAdded[cosmeticData.Name] then
				if cosmeticData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, cosmeticData, cosmeticData.GameStateRequirements ) then
					if not GameState.WorldUpgradesViewed[cosmeticData.Name] then
						return true
					end
				end
			end
		end
	end
	return false
end

function HasUnviewedWorldUpgrade( category )
	for k, itemName in ipairs( category ) do
		local itemData = WorldUpgradeData[itemName] or WeaponShopItemData[itemName]
		if itemData ~= nil and not GameState.WorldUpgradesViewed[itemName] and ( itemData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, itemData, itemData.GameStateRequirements ) ) then
			return true
		end
	end
	return false
end

function HasUnpurchasedCosmetic( slotName )
	if slotName == "Music" then
		for trackName, trackData in pairs( MusicPlayerTrackData ) do
			if not trackData.DebugOnly and trackData.ResourceCost ~= nil and not GameState.WorldUpgradesAdded[trackData.Name] then
				return true
			end
		end
	else
		for cosmeticName, cosmeticData in pairs( WorldUpgradeData ) do
			if not cosmeticData.DebugOnly and cosmeticData.ResourceCost ~= nil and not cosmeticData.Disabled and cosmeticData.Slot == slotName and not GameState.WorldUpgradesAdded[cosmeticData.Name] then
				return true
			end
		end
	end
	return false
end

function GhostAdminPinItem( screen, button )
	if screen.SelectedItem == nil or screen.SelectedItem.Purchased then
		return
	end
	if not GameState.WorldUpgrades.WorldUpgradePinning then
		return
	end
	local itemName = screen.SelectedItem.Data.Name
	if HasStoreItemPin( itemName ) then
		RemoveStoreItemPin( itemName )
		RemoveStoreItemPinPresentation( screen.SelectedItem )
	else
		AddStoreItemPin( itemName, "WorldUpgradeData" )
		AddStoreItemPinPresentation( screen.SelectedItem )
	end
end

function CloseGhostAdminScreen( screen, button )
	OnScreenCloseStarted( screen )
	thread( GhostAdminScreenClosedPresentation, screen, button )
	CloseScreen( GetAllIds( screen.Components ), 0 )
	AltAspectRatioFramesHide()
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
end

function HandleGhostAdminPurchase( screen, button )
	local upgradeData = button.Data

	if not button.Free and not HasResources( upgradeData.Cost ) then
		ScreenCantAffordPresentation( screen, button )
		return
	end

	if not IsEmpty( upgradeData.Cost ) ~= nil and upgradeData.PurchaseRequirements ~= nil and not IsGameStateEligible( CurrentRun, upgradeData.PurchaseRequirements ) then
		CantPurchasePresentation( screen.Components["PurchaseButton".. button.Index] )
		return
	end

	GhostAdminItemPurchasedPresentation( button, upgradeData )

	table.insert( screen.SaleData, upgradeData )
	screen.NumSales = screen.NumSales + 1

	AddWorldUpgrade( upgradeData.Name )
	if upgradeData.Names ~= nil then
		for i, name in pairs( upgradeData.Names ) do
			AddWorldUpgrade( name )
		end
	end
	if upgradeData.RemoveCosmetics ~= nil then
		for k, name in pairs( upgradeData.RemoveCosmetics ) do
			GameState.WorldUpgrades[name] = nil
		end
	end
	RemoveStoreItemPin( upgradeData.Name, { Purchase = true } )
	CallFunctionName( upgradeData.OnPurchasedFunctionName, upgradeData.OnPurchasedFunctionArgs )

	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = screen.Components["PurchaseButton".. button.Index].Id, OffsetX = 0 })

	Destroy({ Id = screen.Components["PurchaseButton".. button.Index].Id })
	screen.Components["PurchaseButton".. button.Index] = nil

	if screen.Components["Icon".. button.Index] ~= nil then
		Destroy({ Id = screen.Components["Icon".. button.Index].Id })
		screen.Components["Icon".. button.Index] = nil
	end

	for i, button in pairs( screen.Components ) do
		if button.Data ~= nil and button.Data.ResourceCost ~= nil then
			local costColor = Color.CostAffordable
			if not HasResource( button.Data.ResourceName, button.Data.ResourceCost ) then
				costColor = Color.CostUnaffordable
			end
			ModifyTextBox({ Id = screen.Components["PurchaseButton"..button.Index].Id, Color = costColor })
		end
	end
	-- close screen
	CloseGhostAdminScreen( screen, button )

	thread( DoGhostAdminPurchase, screen, button )
end

function DoGhostAdminPurchase( screen, button )
	local itemData = button.Data
	PreActivateCriticalItemPresentation( screen, button, itemData )
	CallFunctionName( itemData.OnActivateFunctionName, itemData.OnActivateFunctionArgs )
	ActivateConditionalItem( itemData, { FromPurchase = true } )
	if itemData.ActivateUnits ~= nil then
		ActivatePrePlacedUnits( itemData, { Ids = itemData.ActivateUnits, CheckConversations = true, FadeInDuration = itemData.FadeInDuration, } )
		if itemData.TeleportToId ~= nil then
			Teleport({ Id = itemData.ActivateUnits, DestinationId = itemData.TeleportToId, OffsetX = itemData.TeleportOffsetX, OffsetY = itemData.TeleportOffsetY, })
		end
	end
	PostActivateCriticalItemPresentation( button, itemData )
	if itemData.CookTime ~= nil then
		GameState.CookStatus[screen.OpenedFrom.ObjectId] =
		{
			ItemName = itemData.Name,
			TimeRemaining = itemData.CookTime,
		}
		SetupCauldronCookStatus( screen.OpenedFrom )
	else
		CallFunctionName( itemData.OnActivateFinishedFunctionName, itemData.OnActivateFinishedFunctionArgs )
	end
	-- OpenGhostAdminScreen( screen.ActiveCategory )
end

function GhostAdminPurchaseSequenceFinished( source, args )
	args = args or {}
	UseableOn({ Ids = args.UseableOnIds })
	UpdateAffordabilityStatus()
end

function HandleGhostAdminRemoval( screen, button )
	local itemData = button.Data

	GameState.WorldUpgrades[itemData.Name] = nil

	Destroy({ Id = screen.Components["PurchaseButtonTitle".. button.Index].Id })
	screen.Components["PurchaseButtonTitle".. button.Index] = nil

	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = screen.Components["PurchaseButton".. button.Index].Id, OffsetX = 0 })

	Destroy({ Id = screen.Components["PurchaseButton".. button.Index].Id })
	screen.Components["PurchaseButton".. button.Index] = nil

	if screen.Components["Icon".. button.Index] ~= nil then
		Destroy({ Id = screen.Components["Icon".. button.Index].Id })
		screen.Components["Icon".. button.Index] = nil
	end

	-- close screen
	CloseGhostAdminScreen( screen, button )

	thread( DoGhostAdminRemoval, screen, button )
end

function DoGhostAdminRemoval( screen, button )
	PreActivateCriticalItemPresentation( button, button.Data, { Removal = true } )
	DeactivateConditionalItem( button.Data )
	PostActivateCriticalItemPresentation( button, button.Data, { Removal = true } )
end

function AddWorldUpgrade( name, args )

	args = args or {}

	if not args.SkipQuestCheck and not GameState.WorldUpgrades[name] then
		thread( CheckQuestStatus )
	end

	-- Current ownership
	GameState.WorldUpgrades[name] = true
	-- Record of it ever being added
	GameState.WorldUpgradesAdded[name] = true
	CurrentRun.WorldUpgradesAdded[name] = true
end

function UnlockWorldUpgrade( name )
	if not GameState.WorldUpgradesAdded[name] then
		GameState.WorldUpgrades[name] = true
	end
	GameState.WorldUpgradesAdded[name] = true
end

function GhostAdminHideItems( screen )

	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })

	SetAlpha({ Ids = { screen.Components.Scrollbar.Id, screen.Components.ScrollbarSlider.Id }, Fraction = 0, Duration = 0.1 })

	local componentIds =  {}
	for i = 1, screen.NumItems do
		local purchaseButtonKey = "PurchaseButton"..i
		table.insert( componentIds, screen.Components[purchaseButtonKey].Id )
		local iconKey = "Icon"..i
		table.insert( componentIds, screen.Components[iconKey].Id )
		local newButtonKey = "NewIcon"..i
		if screen.Components[newButtonKey] ~= nil then
			table.insert( componentIds, screen.Components[newButtonKey].Id )
		end
	end
	local fadeOutTime = 0.1
	SetAlpha({ Ids = componentIds, Fraction = 0, Duration = fadeOutTime })
	ModifyTextBox({ Id = screen.Components["Category"..screen.ActiveCategoryIndex].Id, Color = Color.CodexTitleUnselected })
	wait( fadeOutTime )
	Destroy({ Ids = componentIds })

	--ModifyTextBox({ Id = screen.Components.InfoBoxName.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = screen.Components.InfoBoxDescription.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = screen.Components.InfoBoxFlavor.Id, FadeTarget = 0.0, })

end

function GhostAdminNextCategory( screen, button )
	if screen.NumCategories <= 1 then
		return
	end
	GhostAdminSelectCategoryPresentation( screen, button )
	local nextCategoryIndex = screen.ActiveCategoryIndex + 1
	if nextCategoryIndex > #screen.ItemCategories then
		nextCategoryIndex = 1
	end
	if nextCategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	GhostAdminHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	local nextCategoryButton = screen.Components["Category"..nextCategoryIndex]
	GhostAdminDisplayCategory( screen, nextCategoryButton )
	GhostAdminUpdateVisibility( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
end

function GhostAdminPrevCategory( screen, button )
	if screen.NumCategories <= 1 then
		return
	end
	GhostAdminSelectCategoryPresentation( screen, button )
	local nextCategoryIndex = screen.ActiveCategoryIndex - 1
	if nextCategoryIndex < 1 then
		nextCategoryIndex = #screen.ItemCategories
	end
	if nextCategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	GhostAdminHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	local nextCategoryButton = screen.Components["Category"..nextCategoryIndex]
	GhostAdminDisplayCategory( screen, nextCategoryButton )
	GhostAdminUpdateVisibility( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
end

function GhostAdminSelectCategory( screen, button )
	GhostAdminSelectCategoryPresentation( screen, button )
	if button.CategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	AddInputBlock({ Name = "GhostAdminSelectCategory" })
	GhostAdminHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	GhostAdminDisplayCategory( screen, button )
	GhostAdminUpdateVisibility( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "GhostAdminSelectCategory" })
end

function GhostAdminScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	GhostAdminUpdateVisibility( screen, { AnimateSlider = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
	GhostAdminScreenScrollPresentation( screen, button )
end

function GhostAdminScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	GhostAdminUpdateVisibility( screen, { AnimateSlider = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	GhostAdminScreenScrollPresentation( screen, button )
end

function GhostAdminUpdateVisibility( screen, args )

	args = args or {}
	local components = screen.Components
	local offIds = {}
	local onIds = {}
	for index = 1, screen.NumItems do
		local questButtonKey = "PurchaseButton"..index
		local purchaseButtonTitleKey = "PurchaseButtonTitle"..index
		local newButtonKey = "NewIcon"..index
		local iconKey = "Icon"..index
		local pinButtonKey = "PinIcon"..index

		local visibleIndex = index - screen.ScrollOffset

		if visibleIndex >= 1 and visibleIndex <= screen.ItemsPerPage then
			-- Page in view
			Teleport({ Id = components[questButtonKey].Id, OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((visibleIndex - 1) * screen.ItemSpacingY) })
			table.insert( onIds, components[questButtonKey].Id )
			Teleport({ Id = components[iconKey].Id, OffsetX = screen.ItemStartX + screen.IconOffsetX, OffsetY = screen.ItemStartY + screen.IconOffsetY + ((visibleIndex - 1) * screen.ItemSpacingY) })
			table.insert( onIds, components[iconKey].Id )
			if components[newButtonKey] ~= nil and not GameState.WorldUpgradesViewed[components[questButtonKey].Data.Name] then
				Teleport({ Id = components[newButtonKey].Id, OffsetX = screen.ItemStartX + screen.IconOffsetX, OffsetY = screen.ItemStartY + screen.IconOffsetY + ((visibleIndex - 1) * screen.ItemSpacingY) })
				table.insert( onIds, components[newButtonKey].Id )
			end
			if components[pinButtonKey] ~= nil and components[questButtonKey].IsPinned then
				--Teleport({ Id = components[pinButtonKey].Id, OffsetX = screen.ItemStartX + screen.IconOffsetX, OffsetY = screen.ItemStartY + screen.IconOffsetY + ((visibleIndex - 1) * screen.ItemSpacingY) })
				table.insert( onIds, components[pinButtonKey].Id )
			end

			if visibleIndex == 1 then
				SetInteractProperty({ DestinationId = components[questButtonKey].Id, Property = "FreeFormSelectOffsetY", Value = 20 })
			elseif visibleIndex == screen.ItemsPerPage then
				SetInteractProperty({ DestinationId = components[questButtonKey].Id, Property = "FreeFormSelectOffsetY", Value = -20 })
			else
				SetInteractProperty({ DestinationId = components[questButtonKey].Id, Property = "FreeFormSelectOffsetY", Value = 0 })
			end

		else
			-- Page out of view
			table.insert( offIds, components[questButtonKey].Id )
			table.insert( offIds, components[iconKey].Id )
			if components[newButtonKey] ~= nil then
				table.insert( offIds, components[newButtonKey].Id )
			end
			if components[pinButtonKey] ~= nil then
				table.insert( offIds, components[pinButtonKey].Id )
			end
		end

	end

	SetAlpha({ Ids = onIds, Fraction = 1, Duration = 0.1 })
	UseableOn({ Ids = onIds })

	SetAlpha({ Ids = offIds, Fraction = 0, Duration = 0.1 })
	UseableOff({ Ids = offIds, ForceHighlightOff = true })

	local maxScrollOffset = math.max( 1, math.floor( screen.NumItems / screen.ItemsPerPage ) * screen.ItemsPerPage )
	local sliderTargetY = Lerp( screen.ScrollbarSliderTopY + ScreenCenterNativeOffsetY, screen.ScrollbarSliderBottomY + ScreenCenterNativeOffsetY, screen.ScrollOffset / maxScrollOffset )
	local slideDuration = 0.0
	if args.AnimateSlider then
		slideDuration = 0.2
	end
	Move({ Id = components.ScrollbarSlider.Id, OffsetX = components.ScrollbarSlider.X, OffsetY = sliderTargetY, Duration = slideDuration, EaseIn = 0.0, EaseOut = 1.0 })

	if not args.IgnoreArrows then
		if screen.ScrollOffset <= 0 then
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
		else
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollUp.Id })
		end

		if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
		else
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollDown.Id })
		end
	end

end

function SetupCauldronCookStatus( source, args )
	args = args or {}
	UseableOff({ Id = source.ObjectId })
	local cookStatus = GameState.CookStatus[source.ObjectId]
	if cookStatus == nil then
		local defaultData = HubRoomData.Hub_Main.ObstacleData[source.ObjectId]
		source.UseText = defaultData.UseText
		source.OnUsedFunctionName = defaultData.OnUsedFunctionName
		Destroy({ Id = SessionMapState.CauldronCookTopId })
		Destroy({ Id = SessionMapState.CauldronCookTimerId })
		SessionMapState.CauldronCookTopId = nil
		SessionMapState.CauldronCookTimerId = nil
		UseableOn({ Id = source.ObjectId })
		return
	end
	if cookStatus.TimeRemaining >= 1 then
		source.UseText = "UseCauldron_CookActive"
		source.OnUsedFunctionName = "UseCauldronCookActivePresentation"
	else
		source.UseText = "UseCauldron_CookReady"
		source.OnUsedFunctionName = "UseCauldronCookComplete"
	end
	SetupCauldronCookActivePresentation( source, args )
	UseableOn({ Id = source.ObjectId })
end

function UseCauldronCookComplete( source, args )
	AddInputBlock({ Name = "UseCauldronCookComplete" })
	StopStatusAnimation( source )
	UseCauldronCookCompletePresentation( source, args )
	local cookStatus = GameState.CookStatus[source.ObjectId]
	local itemData = WorldUpgradeData[cookStatus.ItemName]
	CallFunctionName( itemData.OnActivateFinishedFunctionName, itemData.OnActivateFinishedFunctionArgs )
	GameState.CookStatus[source.ObjectId] = nil
	SetupCauldronCookStatus( source, args )
	RemoveInputBlock({ Name = "UseCauldronCookComplete" })
end

function CookTimeTick( args )
	args = args or {}
	AddInputBlock({ Name = "CookTimeTick" })
	for tick = 1, (args.Ticks or 1) do
		for cookId, cookStatus in pairs( GameState.CookStatus ) do
			if args.CookId == nil or cookId == args.CookId then
				if cookStatus.TimeRemaining ~= nil and cookStatus.TimeRemaining > 0 then
					cookStatus.TimeRemaining = cookStatus.TimeRemaining - 1
					if args.UpdatePresentation then
						local source = MapState.ActiveObstacles[cookId]
						SetupCauldronCookStatus( source, args )
					end
				end
			end
		end
		wait( args.TickInterval )
	end
	RemoveInputBlock({ Name = "CookTimeTick" })
end

function ValidateItemCategories()
	if not verboseLogging then
		return
	end
	local allItems = {}
	for i, itemCategory in pairs( ScreenData.GhostAdmin.ItemCategories ) do
		for j, itemName in ipairs( itemCategory ) do
			allItems[itemName] = true
		end
	end
	for i, itemCategory in pairs( ScreenData.CosmeticsShop.ItemCategories ) do
		for j, itemName in ipairs( itemCategory ) do
			allItems[itemName] = true
		end
	end
	for itemName, item in pairs( WorldUpgradeData ) do
		if not item.DebugOnly and item.Cost ~= nil and not allItems[itemName] then
			DebugAssert({ Condition = false, Text = item.Name.." is not listed in either GhostAdmin.ItemCategories or CosmeticsData.ItemCategories" })
		end
	end
end