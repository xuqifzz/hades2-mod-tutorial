function UseGhostAdmin( usee, args )
	thread( PlayInteractAnimation, usee.ObjectId, { Animation = "MelTalkBrooding01" } )
	if SetThreadWait( "InfoBanner", 0.01 ) then
		wait( 0.2 )
	end
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenGhostAdminScreen( usee )
	UseableOn({ Id = usee.ObjectId })
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
	local tabsToReveal = nil
	local tabsWithNewItems = nil

	screen.NumCategories = 0

	local categoryTitleX = screen.CategoryStartX
	for slotIndex, category in ipairs( screen.ItemCategories ) do
		if category.GameStateRequirements == nil or IsGameStateEligible( category, category.GameStateRequirements ) then

			local slotName = category.Name

			local categoryButton = CreateScreenComponent({
				Name = "CriticalItemShopTab",
				Group = screen.ComponentData.DefaultGroup,
				X = categoryTitleX,
				Y = screen.CategoryStartY,
				Animation = category.Animations.Default,
				Alpha = 0.0,
			})
			categoryButton.DefaultAnimation = category.DefaultAnimation
			categoryButton.Animations = category.Animations
			categoryButton.OnPressedFunctionName = "GhostAdminSelectCategory"
			categoryButton.OnMouseOverFunctionName = "MouseOverGhostAdminCategory"
			categoryButton.OnMouseOffFunctionName = "MouseOffGhostAdminCategory"
			categoryButton.Screen = screen
			categoryButton.Category = slotName
			categoryButton.CategoryIndex = slotIndex
			components["Category"..slotIndex] = categoryButton
			AttachLua({ Id = categoryButton.Id, Table = categoryButton })
			SetInteractProperty({ DestinationId = categoryButton.Id, Property = "FreeFormSelectable", Value = false })
			
			local activeOverlay = CreateScreenComponent({
				Name = "BlankObstacle",
				Group = screen.ComponentData.DefaultGroup,
				X = categoryTitleX,
				Y = screen.CategoryStartY,
				Animation = category.Animations.Active,
				Alpha = 0.0,
			})
			categoryButton.ActiveOverlayId = activeOverlay.Id
			screen.Components["CategoryActiveOverlay"..slotIndex] = activeOverlay

			local categoryButtonIcon = CreateScreenComponent({
				Name = "BlankObstacle",
				Group = screen.ComponentData.DefaultGroup,
				X = categoryTitleX + screen.CategoryIconOffsetX,
				Y = screen.CategoryStartY + screen.CategoryIconOffsetY,
				Animation = category.Icon,
				Scale = screen.CategoryIconScale,
				Alpha = 0.0,
			})
			categoryButton.IconId = categoryButtonIcon.Id
			categoryButton.IconShiftRequests = {}
			screen.Components["CategoryIcon"..slotIndex] = categoryButtonIcon

			local shouldFadeIn = true
			if slotIndex ~= screen.ActiveCategoryIndex then
				if not GameState.WorldUpgradesRevealed[slotName] then
					tabsToReveal = tabsToReveal or {}
					table.insert( tabsToReveal, categoryButton )
					shouldFadeIn = false
				end
				if HasUnviewedWorldUpgrade( category ) then
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
			categoryTitleX = categoryTitleX + screen.CategorySpacingX

		end
	end

	if tabsToReveal ~= nil then
		-- Tab reveals take a while, so display the active category title + "active tab" animation early
		local activeTab = components.Category1
		SetAlpha({ Id = activeTab.ActiveOverlayId, Fraction = 1.0, Duration = 0.1 })
		ModifyTextBox({ Id = components.CategoryTitleText.Id, Text = screen.ItemCategories[screen.ActiveCategoryIndex].Name })
		local previousShift = not IsEmpty( activeTab.IconShiftRequests )
		activeTab.IconShiftRequests.Open = true
		if not previousShift then
			Move({ Id = activeTab.IconId, Angle = 90, Distance = screen.CategoryIconMouseOverShiftDistance, Speed = screen.CategoryIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
		end

		for i, categoryButton in ipairs( tabsToReveal ) do
			WeaponShopRevealCategoryPresentation( screen, screen.ItemCategories[categoryButton.Category], categoryButton )
		end
	end

	if tabsWithNewItems ~= nil then
		for i, categoryButton in ipairs( tabsWithNewItems ) do
			local newButtonKey = "NewIcon"..categoryButton.Category
			components[newButtonKey] = CreateScreenComponent({
				Name = "BlankObstacle",
				Group = "Combat_Menu_Overlay",
				Animation = "NewTabStar",
				Scale = 0.8,
				Alpha = 0.0,
				AlphaTarget = 1.0,
				AlphaTargetDuration = 0.1,
			})
			Attach({ Id = components[newButtonKey].Id, DestinationId = categoryButton.Id, OffsetY = -30 })
		end
	end

	GhostAdminDisplayCategory( screen, components["Category"..screen.ActiveCategoryIndex] )

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

	local viewRecord = CurrentRun.ScreenViewRecord[category.Name] or CurrentRun.ScreenViewRecord[screen.Name] or 0
	if category.OneRevealPerRun and not cosmeticData.AlwaysRevealImmediately and (viewRecord > 1 or (viewRecord == 1 and not IsScreenOpen( screen.Name ))) then
		return false
	end

	if cosmeticData.GameStateRequirements ~= nil and not IsGameStateEligible( cosmeticData, cosmeticData.GameStateRequirements ) then
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

	CurrentRun.ScreenViewRecord[category.Name] = (CurrentRun.ScreenViewRecord[category.Name] or 0) + 1

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

	screen.AvailableItems = {}
	screen.PurchasedItems = {}
	screen.ItemsToReveal = {}
	screen.NumItems = 0

	CurrentRun.ViewableWorldUpgrades = CurrentRun.ViewableWorldUpgrades or {}
	local numItemsToReveal = 0
	local maxItemsToReveal = CurrentRun.AllowedRevealsThisRun or screen.AllowedRevealsPerRun
	for i, itemName in ipairs( screen.ItemCategories[button.CategoryIndex] ) do
		local itemData = WorldUpgradeData[itemName]
		DebugAssert({ Condition = itemData ~= nil, Text = itemName.." listed in GhostAdminData but does not exist in WorldUpgradeData" })
		if GhostAdminAllowViewItem( screen, category, itemData ) then
			if GameState.WorldUpgradesAdded[itemName] and not itemData.Repeatable then
				-- purchased items
				CurrentRun.ViewableWorldUpgrades[itemName] = true
				screen.NumItems = screen.NumItems + 1
				table.insert( screen.PurchasedItems, itemData )
			elseif GameState.WorldUpgradesRevealed[itemName] or itemData.AlwaysRevealImmediately or numItemsToReveal < maxItemsToReveal then
				-- already available / immediate reveals / capped number of other reveals
				CurrentRun.ViewableWorldUpgrades[itemName] = true
				screen.NumItems = screen.NumItems + 1
				table.insert( screen.AvailableItems, itemData )
				if not GameState.WorldUpgradesRevealed[itemName] then
					screen.ItemsToReveal[itemName] = true
					numItemsToReveal = numItemsToReveal + 1
				end
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

	GameState.WorldUpgradesViewed[slotName] = true

	GhostAdminUpdateVisibility( screen, { PlaySequentialFade = true } )
	GhostAdminScreenRevealNewItemsPresentation( screen, button )

end

function GhostAdminUpdateVisibility( screen, args )
	args = args or {}
	local components = screen.Components

	if screen.SelectedItem ~= nil then
		MouseOffGhostAdminItem( screen.SelectedItem )
	end

	GhostAdminUpdateScrollbarPresentation( screen, args )

	-- Destroy all the buttons from the last screen
	Destroy({ Ids = screen.ButtonIds })
	screen.ButtonIds = {}

	-- Create the new batch of buttons
	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY
	local firstIndex = screen.ScrollOffset + 1
	local lastIndex = math.min( screen.NumItems, screen.ScrollOffset + screen.ItemsPerPage )
	for itemIndex = firstIndex, lastIndex, 1 do

		local purchased = itemIndex > #screen.AvailableItems

		local itemData = nil
		if purchased then
			itemData = screen.PurchasedItems[itemIndex - #screen.AvailableItems]
		else
			itemData = screen.AvailableItems[itemIndex]
		end
		local displayName = itemData.Name

		local button = CreateScreenComponent({
			Name = "GhostAdminItem",
			Group = screen.ComponentData.DefaultGroup,
			X = itemLocationX,
			Y = itemLocationY,
			Alpha = 0.0,
		})
		components[displayName.."Button"] = button
		button.AssociatedIds = {}
		button.Screen = screen
		button.OnMouseOverFunctionName = "MouseOverGhostAdminItem"
		button.OnMouseOffFunctionName = "MouseOffGhostAdminItem"
		if purchased then
			button.NeutralAnimation = screen.ItemPurchasedAnimation
			button.MouseOverAnimation = screen.ItemPurchasedMouseOverAnimation
			button.MouseOffAnimation = screen.ItemPurchasedMouseOffAnimation
		else
			button.OnPressedFunctionName = "HandleGhostAdminPurchase"
			button.NeutralAnimation = screen.ItemAvailableAnimation
			button.MouseOverAnimation = screen.ItemAvailableMouseOverAnimation
			button.MouseOffAnimation = screen.ItemAvailableMouseOffAnimation
		end
		button.Data = itemData
		button.Purchased = purchased
		AttachLua({ Id = button.Id, Table = button })
		SetAnimation({ DestinationId = button.Id, Name = button.NeutralAnimation })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })

		if not args.AnimateSlider then
			PlaySound({ Name = "/SFX/Menu Sounds/GodBoonSlotHighlightShimmerSFX2", Id = button.Id, })
		end

		local iconComponentName = "BlankObstacle"
		if purchased then
			iconComponentName = "GhostAdminScreenPurchasedItemIcon"
		end
		local icon = CreateScreenComponent({
			Name = iconComponentName,
			X = itemLocationX + screen.IconOffsetX,
			Y = itemLocationY,
			Scale = screen.IconScale,
			Group = screen.ComponentData.DefaultGroup,
			Animation = itemData.Icon,
			Alpha = 0.0,
		})
		table.insert( button.AssociatedIds, icon.Id )
		components[displayName.."Icon"] = icon

		local formatName = nil
		if purchased then
			formatName = "ItemPurchasedNameFormat"
		elseif HasResources( itemData.Cost ) then
			formatName = "ItemAvailableAffordableNameFormat"
			CurrentRun.WorldUpgradesAffordable[displayName] = true
		else
			formatName = "ItemAvailableUnaffordableNameFormat"
		end
		CreateTextBoxWithScreenFormat( screen, button, formatName, { Text = displayName } )

		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = displayName,
			UseDescription = true,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = itemData,
		})

		if purchased then
			local checkmarkIcon = CreateScreenComponent({
				Name = "BlankObstacle",
				Animation = "IncantationPurchasedCheckmark",
				Group = screen.ComponentData.DefaultGroup,
				Alpha = 0.0,
			})
			components[displayName.."CheckmarkIcon"] = checkmarkIcon
			table.insert( button.AssociatedIds, checkmarkIcon.Id )
			Attach({ Id = checkmarkIcon.Id, DestinationId = button.Id, OffsetX = screen.CheckmarkOffsetX })
		else
			local pinIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Alpha = 0.0, })
			components[displayName.."PinIcon"] = pinIcon
			table.insert( button.AssociatedIds, pinIcon.Id )
			Attach({ Id = pinIcon.Id, DestinationId = button.Id, OffsetX = screen.PinOffsetX, OffsetY = UIData.PinIconListOffsetY })
			button.PinButtonId = pinIcon.Id
			if HasStoreItemPin( displayName ) then
				button.IsPinned = true
				SetAnimation({ Name = "StoreItemPin", DestinationId = pinIcon.Id })
				-- Silent toolip
				CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
			end

			if not GameState.WorldUpgradesViewed[displayName] then
				local newIcon = CreateScreenComponent({
					Name = "BlankObstacle",
					Group = screen.ComponentData.DefaultGroup,
					Animation = "MusicPlayerNewTrack",
					Alpha = 0.0,
				})
				components[displayName.."NewIcon"] = newIcon
				table.insert( button.AssociatedIds, newIcon.Id )
				Attach({ Id = newIcon.Id, DestinationId = button.Id, OffsetX = 300, OffsetY = 0 })
				button.NewIconId = newIcon.Id
			end
		end

		if not screen.ItemsToReveal[displayName] then
			SetAlpha({ Id = button.Id, Fraction = 1.0, Duration = 0.1 })
			SetAlpha({ Ids = button.AssociatedIds, Fraction = 1.0, Duration = 0.1 })
			if args.PlaySequentialFade then
				wait( 0.05 )
			end
		end

		if itemIndex == firstIndex then
			screen.CursorStartX = itemLocationX
			screen.CursorStartY = itemLocationY
		end

		table.insert( screen.ButtonIds, button.Id )
		screen.ButtonIds = CombineTables( screen.ButtonIds, button.AssociatedIds )

		itemLocationY = itemLocationY + screen.ItemSpacingY
	end

end

function HasUnviewedWorldUpgrade( category )
	for k, itemName in ipairs( category ) do
		local itemData = WorldUpgradeData[itemName] or WeaponShopItemData[itemName]
		if itemData ~= nil and not GameState.WorldUpgradesViewed[itemName] and ( itemData.GameStateRequirements == nil or IsGameStateEligible( itemData, itemData.GameStateRequirements ) ) then
			return true
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

function CloseGhostAdminScreen( screen, button, args )
	args = args or {}
	OnScreenCloseStarted( screen )
	thread( GhostAdminScreenClosedPresentation, screen, button )
	CloseScreen( GetAllIds( screen.Components ), 0, screen )
	if not args.KeepAltAspectRatioFrames then
		AltAspectRatioFramesHide()
	end
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
end

function HandleGhostAdminPurchase( screen, button )
	local upgradeData = button.Data

	if not button.Free and not HasResources( upgradeData.Cost ) then
		ScreenCantAffordPresentation( screen, button )
		return
	end

	if not IsEmpty( upgradeData.Cost ) ~= nil and upgradeData.PurchaseRequirements ~= nil and not IsGameStateEligible( upgradeData.PurchaseRequirements ) then
		CantPurchasePresentation( button )
		return
	end

	GhostAdminItemPurchasedPresentation( button, upgradeData )

	AddWorldUpgrade( upgradeData.Name )
	if upgradeData.RemoveCosmetics ~= nil then
		for k, name in pairs( upgradeData.RemoveCosmetics ) do
			GameState.WorldUpgrades[name] = nil
		end
	end
	RemoveStoreItemPin( upgradeData.Name, { Purchase = true } )
	CallFunctionName( upgradeData.OnPurchasedFunctionName, upgradeData.OnPurchasedFunctionArgs )

	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = button.Id, OffsetX = 0 })

	CloseGhostAdminScreen( screen, button, { KeepAltAspectRatioFrames = true } )

	thread( DoGhostAdminPurchase, screen, button )
end

function DoGhostAdminPurchase( screen, button )
	local itemData = button.Data
	GameState.LastGhostAdminPurchase = itemData.Name
	PreActivateCriticalItemPresentation( screen, itemData )
	CallFunctionName( itemData.OnActivateFunctionName, itemData.OnActivateFunctionArgs )
	ActivateConditionalItem( itemData, { FromPurchase = true } )
	if itemData.ActivateUnits ~= nil then
		ActivatePrePlacedUnits( itemData, { Ids = itemData.ActivateUnits, CheckConversations = true, FadeInDuration = itemData.FadeInDuration, } )
		if itemData.TeleportToId ~= nil then
			Teleport({ Id = itemData.ActivateUnits, DestinationId = itemData.TeleportToId, OffsetX = itemData.TeleportOffsetX, OffsetY = itemData.TeleportOffsetY, })
		end
	end
	PostActivateCriticalItemPresentation( itemData )
	if itemData.CookTime ~= nil then
		GameState.CookStatus[screen.OpenedFrom.ObjectId] =
		{
			ItemName = itemData.Name,
			TimeRemaining = itemData.CookTime,
		}
		SetupCauldronCookStatus( screen.OpenedFrom, { PlayCauldronCloseSound = true } )
	else
		CallFunctionName( itemData.OnActivateFinishedFunctionName, itemData.OnActivateFinishedFunctionArgs )
	end
	
	thread( CheckProgressAchievements )

end

function GhostAdminPurchaseSequenceFinished( source, args )
	args = args or {}
	UseableOn({ Ids = args.UseableOnIds })
	UpdateAffordabilityStatus()
end

function AddWorldUpgrade( name, args )

	args = args or {}

	if not args.SkipQuestStatusCheck and not GameState.WorldUpgrades[name] then
		thread( CheckQuestStatus )
	end

	DebugAssert({ Condition = GameState.WorldUpgradesViewed[name], Text = "Adding an unviewed world upgrade: "..name, Owner = "Caleb" })

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
	GameState.WorldUpgradesViewed[name] = true
	GameState.WorldUpgradesRevealed[name] = true
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
	AddInputBlock({ Name = "GhostAdminSelectCategory" })
	wait( 0.1 )
	screen.ScrollOffset = 0
	local nextCategoryButton = screen.Components["Category"..nextCategoryIndex]
	GhostAdminDisplayCategory( screen, nextCategoryButton )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "GhostAdminSelectCategory" })
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
	AddInputBlock({ Name = "GhostAdminSelectCategory" })
	wait( 0.1 )
	screen.ScrollOffset = 0
	local nextCategoryButton = screen.Components["Category"..nextCategoryIndex]
	GhostAdminDisplayCategory( screen, nextCategoryButton )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "GhostAdminSelectCategory" })
end

function GhostAdminSelectCategory( screen, button )
	if button.CategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	GhostAdminSelectCategoryPresentation( screen, button )
	AddInputBlock({ Name = "GhostAdminSelectCategory" })
	wait( 0.1 )
	screen.ScrollOffset = 0
	GhostAdminDisplayCategory( screen, button )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "GhostAdminSelectCategory" })
end

function GhostAdminScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	GenericScrollPresentation( screen, button )
	GhostAdminUpdateVisibility( screen, { AnimateSlider = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
end

function GhostAdminScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	GenericScrollPresentation( screen, button )
	GhostAdminUpdateVisibility( screen, { AnimateSlider = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
end

function SetupCauldronCookStatus( source, args )
	if source == nil then
		return
	end
	args = args or {}
	AddInteractBlock( source, "SetupCauldronCookStatus" )
	local cookStatus = GameState.CookStatus[source.ObjectId]
	if cookStatus == nil then
		local defaultData = HubRoomData.Hub_Main.ObstacleData[source.ObjectId]
		source.UseText = defaultData.UseText
		source.OnUsedFunctionName = defaultData.OnUsedFunctionName
		Destroy({ Id = SessionMapState.CauldronCookTopId })
		Destroy({ Id = SessionMapState.CauldronCookTimerId })
		SessionMapState.CauldronCookTopId = nil
		SessionMapState.CauldronCookTimerId = nil
		RemoveInteractBlock( source, "SetupCauldronCookStatus" )
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
	RemoveInteractBlock( source, "SetupCauldronCookStatus" )
end

function UseCauldronCookComplete( source, args )
	AddInputBlock({ Name = "UseCauldronCookComplete" })
	AddInteractBlock( source, "UseCauldronCookComplete" )
	local hecate = ActiveEnemies[556921]
	if hecate ~= nil then
		AddInteractBlock( hecate, "UseCauldronCookComplete" )
	end
	StopStatusAnimation( source )
	UseCauldronCookCompletePresentation( source, args )
	local cookStatus = GameState.CookStatus[source.ObjectId]
	local itemData = WorldUpgradeData[cookStatus.ItemName]
	CallFunctionName( itemData.OnActivateFinishedFunctionName, itemData.OnActivateFinishedFunctionArgs )
	GameState.CookStatus[source.ObjectId] = nil
	SetupCauldronCookStatus( source, args )
	RemoveInputBlock({ Name = "UseCauldronCookComplete" })
	wait( 1.0 )
	-- Wait for smoke incantation to finish
	RemoveInteractBlock( source, "UseCauldronCookComplete" )
	-- Smoke Bink is still going, can't start a conversation with Hecate yet
	wait( 0.5 )
	if hecate ~= nil then
		RemoveInteractBlock( hecate, "UseCauldronCookComplete" )
	end
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
	for i, itemName in pairs( ScreenData.MusicPlayer.Songs ) do
		allItems[itemName] = true
	end
	for i, itemCategory in pairs( ScreenData.FamiliarCostumeShop.ItemCategories ) do
		for j, itemName in ipairs( itemCategory ) do
			allItems[itemName] = true
		end
	end
	for itemName, item in pairs( WorldUpgradeData ) do
		if not item.DebugOnly and item.Cost ~= nil and not allItems[itemName] then
			DebugAssert({ Condition = false, Text = item.Name.." is not listed in GhostAdmin.ItemCategories, CosmeticsData.ItemCategories, MusicPlayer.Songs, or FamiliarCostumeShop.ItemCategories" })
		end
	end
end

function RequireAffordableGhostAdminItems( source, args )
	local screenData = ScreenData.GhostAdmin

	local hasAny = false
	for i, itemName in ipairs( args.HasAny or args.HasNone ) do
		local itemData = WorldUpgradeData[itemName]
		if itemData ~= nil and not GameState.WorldUpgradesAdded[itemName] then
			local cost = itemData.ResourceCost or itemData.Cost
			if HasResources( cost ) then
				if GhostAdminAllowViewItem( screenData, screenData.ItemCategories[args.CategoryIndex], itemData ) then
					hasAny = true
					break
				end
			end
		end
	end

	if (args.HasAny ~= nil and hasAny) or (args.HasNone ~= nil and not hasAny) then
		return true
	end

	return false
end