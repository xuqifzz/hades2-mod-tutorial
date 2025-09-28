function UseWeaponShop( usee, args )
	args = args or {}
	Halt({ Id = CurrentRun.Hero.ObjectId })
	EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	UsedWeaponShopPresentation( usee, args )
	local screen = OpenWeaponShopScreen( usee, args )
	UseableOn({ Id = usee.ObjectId })
end

function OpenWeaponShopScreen( openedFrom, args )

	args = args or {}
	AltAspectRatioFramesShow()
	AddInputBlock({ Name = "OpenWeaponShopScreen" })
	local screen = DeepCopyTable( ScreenData.WeaponShop )
	screen.OpenedFrom = openedFrom

	if IsScreenOpen( screen.Name ) then
		return
	end
	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	screen.ActiveCategoryIndex = args.DefaultCategoryIndex or GetWeaponShopCategoryToOpen( screen )

	local components = screen.Components
	local tabsToReveal = nil
	local tabsWithNewItems = nil

	screen.NumCategories = 0

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY
	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY
	screen.CostDisplay.StartX = screen.CostDisplay.StartX + ScreenCenterNativeOffsetX
	screen.CostDisplay.StartY = screen.CostDisplay.StartY + ScreenCenterNativeOffsetY

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
			categoryButton.OnPressedFunctionName = "WeaponShopScreenSelectCategory"
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
		else
			category.Locked = true
		end
	end

	if tabsToReveal ~= nil then
		-- Tab reveals take a while, so display the active category title early
		ModifyTextBox({ Id = components.CategoryTitleText.Id, Text = screen.ItemCategories[screen.ActiveCategoryIndex].Name })
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
				Alpha = 0.0,
				AlphaTarget = 1.0,
				AlphaTargetDuration = 0.1,
			})
			Attach({ Id = components[newButtonKey].Id, DestinationId = categoryButton.Id, OffsetX = screen.NewIconOffsetX, OffsetY = screen.NewIconOffsetY })
		end
	end

	WeaponShopScreenOpenedPresentation( screen, args )

	WeaponShopScreenDisplayCategory( screen, screen.ActiveCategoryIndex )
	WeaponShopUpdateVisibility( screen )
	UpdateWeaponShopInteractionText( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "OpenWeaponShopScreen" })

	if screen.NumCategories > 1 and not GameState.Flags.HasUsedWeaponShopNavigation then
		components.ScrollRight.Visible = true
		thread( PulseContextActionPresentation, components.ScrollRight, { OffsetX = 0, ThreadName = "WeaponShopNavigationPulse", InitialWait = 4.0 } )
	end

	thread( WeaponShopScreenOpenFinishedPresentation, screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen

end

function WeaponShopScreenDisplayCategory( screen, categoryIndex )

	local components = screen.Components

	-- Cleanup prev category
	local prevCategory = screen.ItemCategories[screen.ActiveCategoryIndex]

	local slotName = screen.ItemCategories[categoryIndex].Name
	ModifyTextBox({ Id = components["Category"..slotName].Id, Color = Color.White })

	local newButtonKey = "NewIcon"..slotName
	if components[newButtonKey] ~= nil then
		Destroy({ Id = components[newButtonKey].Id })
	end

	StopAnimation({ DestinationId = screen.Components["Category"..prevCategory.Name].Id, Name = "InventoryTabHighlightActiveCategory" })

	WeaponShopCloseCategory( screen )

	local category = screen.ItemCategories[categoryIndex]
	local slotName = category.Name

	-- Highlight new category
	CreateAnimation({ DestinationId = screen.Components["Category"..slotName].Id, Name = "InventoryTabHighlightActiveCategory", Group = "Combat_Menu_TraitTray" })
	ModifyTextBox({ Id = screen.Components.CategoryTitleText.Id, Text = category.Name })
	WeaponShopPanToKit( screen, screen.ItemCategories[categoryIndex].WeaponName )

	screen.ActiveCategoryIndex = categoryIndex

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	local availableItems = {}
	local purchasedItems = {}
	screen.ItemNames = {}

	for i, itemName in ipairs( screen.ItemCategories[screen.ActiveCategoryIndex] ) do
		local itemData = WeaponShopItemData[itemName]
		if not itemData.DebugOnly then
			if itemData.GameStateRequirements == nil or IsGameStateEligible( itemData, itemData.GameStateRequirements ) then
				if GameState.WorldUpgradesAdded[itemName] then
					if not itemData.HideAfterPurchased and ( not itemData.HideIfItemAvailable or not IsGameStateEligible( WeaponShopItemData[itemData.HideIfItemAvailable], WeaponShopItemData[itemData.HideIfItemAvailable].GameStateRequirements ) ) then
						table.insert( purchasedItems, itemData )
					end
				else
					table.insert( availableItems, itemData )
				end
				table.insert( screen.ItemNames, itemName )
			end
		end
	end

	screen.NumItems = 0
	screen.NumItemsPurchaseable = 0
	screen.NumItemsAffordable = 0

	local firstUseable = false
	screen.ItemButtons = {}

	-- Available
	for i, item in ipairs( availableItems ) do

		screen.NumItems = screen.NumItems + 1
		screen.NumItemsPurchaseable = screen.NumItemsPurchaseable + 1
		if HasResources( item.Cost ) then
			screen.NumItemsAffordable = screen.NumItemsAffordable + 1
		end

		screen.OfferedVoiceLines = screen.OfferedVoiceLines or item.OfferedVoiceLines

		local purchaseButtonKey = "PurchaseButton"..screen.NumItems
		components[purchaseButtonKey] = CreateScreenComponent({
			Name = "BlankInteractableObstacle",
			Group = "Combat_Menu",
			X = itemLocationX,
			Y = itemLocationY,
			Animation = screen.ItemAvailableAnimation,
			Alpha = 0.0,
		})
		local button = components[purchaseButtonKey]
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
		button.Animation = screen.ItemAvailableAnimation
		button.HighlightAnimation = screen.ItemAvailableHighlightAnimation
		button.Screen = screen
		screen.ItemButtons[button.Id] = button
		AttachLua({ Id = button.Id, Table = button })

		local iconData = TraitData[item.TraitUpgrade or item.Name] or item
		if iconData.Icon ~= nil then
			local iconKey = "Icon"..screen.NumItems			
			components[iconKey] = CreateScreenComponent({
				Name = "BlankObstacle",
				Group = screen.ComponentData.DefaultGroup,
				X = itemLocationX,
				Y = itemLocationY,
				Scale = iconData.IconScale or screen.IconScale,
				Animation = iconData.Icon,
				Alpha = 0.0,
			})
		end

		local format = screen.ItemAvailableAffordableNameFormat
		if not HasResources( item.Cost ) then
			format = screen.ItemAvailableUnaffordableNameFormat
		end

		local tooltipData = item
		local traitData = nil
		local traitName = item.TraitUpgrade or item.Name
		if TraitData[traitName] ~= nil then
			local weaponUpgradeLevel = GetWeaponUpgradeLevel( traitName ) 
			if not item.TraitUpgrade then
				traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName , Rarity = GetRarityKey( weaponUpgradeLevel, TraitRarityData.WeaponRarityUpgradeOrder ) })
				SetTraitTextData( traitData )
			else
				traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName , Rarity = GetRarityKey( weaponUpgradeLevel, TraitRarityData.WeaponRarityUpgradeOrder ) })
				newTraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName , Rarity = GetRarityKey( 1 + weaponUpgradeLevel, TraitRarityData.WeaponRarityUpgradeOrder ) })
				SetTraitTextData( traitData, { ReplacementTraitData = newTraitData } )
			end
			button.TraitData = traitData
			tooltipData = button.TraitData
			if item.TraitUpgrade ~= nil then
				tooltipData.NextLevel = GetWeaponUpgradeLevel( traitName ) + 1
				tooltipData.AspectRarityText = TraitRarityData.AspectRarityText[tooltipData.NextLevel]
				tooltipData.BaseWeaponName = traitData.RequiredWeapon
			end
		end

		local displayName = item.HelpTextId or item.Name
		if item.TraitUpgrade ~= nil then
			displayName = item.TraitUpgrade.."_Upgrade"
		end

		local itemNameFormat = ShallowCopyTable( format )
		itemNameFormat.Id = button.Id
		itemNameFormat.Text = displayName
		itemNameFormat.LuaKey = "TooltipData"
		itemNameFormat.LuaValue = tooltipData
		CreateTextBox( itemNameFormat )

		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = item.TraitUpgrade or item.Name,
			UseDescription = true,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = tooltipData,
		})
		if tooltipData.StatLines then
			CreateTextBox({ Id = button.Id,
				Text = tooltipData.StatLines[1],
				Color = Color.Transparent,
				LuaKey = "TooltipData",
				LuaValue = tooltipData,
			})
		end
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY + ScreenCenterNativeOffsetY })

		button.OnMouseOverFunctionName = "MouseOverWeaponShopItem"
		button.OnMouseOffFunctionName = "MouseOffWeaponShopItem"
		button.OnPressedFunctionName = "HandleWeaponShopPurchase"
		if not firstUseable then
			screen.CursorStartX = itemLocationX
			screen.CursorStartY = itemLocationY
			firstUseable = true
		end

		button.Data = item
		button.Index = screen.NumItems

		if item.PreOpenRevealVoiceLines ~= nil and not GameState.WorldUpgradesRevealed[item.Name] then
			CreateAnimation({ DestinationId = button.Id, Name = "WeaponSlotAspectReveal" }) --nopkg
		end
		
		-- Pin icon
		local pinButtonKey = "PinIcon"..screen.NumItems
		components[pinButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
		Attach({ Id = components[pinButtonKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.PinOffsetX, OffsetY = screen.PinOffsetY })
		components[purchaseButtonKey].PinButtonId = components[pinButtonKey].Id
		if HasStoreItemPin( button.Data.Name ) then
			SetAnimation({ Name = "StoreItemPin", DestinationId = components[purchaseButtonKey].PinButtonId })
			-- Silent toolip
			CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
		end

		-- New icon
		if not GameState.WorldUpgradesViewed[item.Name] then
			local newButtonKey = "NewIcon"..screen.NumItems
			components[newButtonKey] = CreateScreenComponent({
				Name = "BlankObstacle",
				Group = "Combat_Menu",
				Animation = "MusicPlayerNewTrack",
				Alpha = 0.0,
			})
			Attach({ Id = components[newButtonKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 300, OffsetY = 0 })
			components[purchaseButtonKey].NewButtonId = components[newButtonKey].Id
		end

		if not GameState.WorldUpgradesRevealed[item.Name] then
			CurrentRun.WorldUpgradesRevealed[item.Name] = true
		end
		GameState.WorldUpgradesRevealed[item.Name] = true

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	-- Purchased
	for i, item in ipairs( purchasedItems ) do

		screen.NumItems = screen.NumItems + 1

		local animName = screen.ItemAvailableAnimation
		local highlightAnimName = screen.ItemAvailableHighlightAnimation
		if not item.Removable or ( item.RotateOnly and GameState.WorldUpgrades[item.Name] ) then
			animName = screen.ItemAvailableAnimation
			highlightAnimName = screen.ItemPurchasedHighlightAnimation
		end

		local purchaseButtonKey = "PurchaseButton"..screen.NumItems
		components[purchaseButtonKey] = CreateScreenComponent({
			Name = "BlankInteractableObstacle",
			Group = "Combat_Menu",
			X = itemLocationX,
			Y = itemLocationY,
			Animation = animName,
			Alpha = 0.0,
		})
		local button = components[purchaseButtonKey]
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
		button.Animation = animName
		button.HighlightAnimation = highlightAnimName
		button.Screen = screen
		screen.ItemButtons[button.Id] = button
		AttachLua({ Id = button.Id, Table = button })
		
		local iconData = TraitData[item.TraitUpgrade or item.Name] or item
		if iconData.Icon ~= nil then
			local iconKey = "Icon"..screen.NumItems
			components[iconKey] = CreateScreenComponent({
				Name = "BlankObstacle",
				Group = screen.ComponentData.DefaultGroup,
				X = itemLocationX,
				Y = itemLocationY,
				Scale = iconData.IconScale or screen.IconScale,
				Animation = iconData.Icon,
				Alpha = 0.0,
			})
		end

		local displayName = item.RePurchaseName or item.HelpTextId or item.Name
		if item.TraitUpgrade ~= nil then
			displayName = item.TraitUpgrade.."_Upgrade"
		end
		local costText = "Shop_Purchased"

		local tooltipData = item
		local traitName = item.TraitUpgrade or item.Name

		if TraitData[traitName] ~= nil then
			local weaponUpgradeLevel = GetWeaponUpgradeLevel( traitName ) 
			button.TraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = GetRarityKey( weaponUpgradeLevel, TraitRarityData.TalentRarityUpgradeOrder ) })
			SetTraitTextData( button.TraitData )
			tooltipData = button.TraitData

			if item.TraitUpgrade ~= nil then
				tooltipData.NextLevel = weaponUpgradeLevel
				tooltipData.AspectRarityText = TraitRarityData.AspectRarityText[tooltipData.NextLevel]
				tooltipData.BaseWeaponName = button.TraitData.RequiredWeapon
			end

		end

		local itemNameFormat = ShallowCopyTable( screen.ItemPurchasedNameFormat )
		itemNameFormat.Id = button.Id
		itemNameFormat.Text = displayName
		itemNameFormat.LuaKey = "TooltipData"
		itemNameFormat.LuaValue = tooltipData
		CreateTextBox( itemNameFormat )

		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = item.TraitUpgrade or item.Name,
			UseDescription = true,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = tooltipData,
		})
		if tooltipData.StatLines then
			CreateTextBox({ Id = button.Id,
				Text = tooltipData.StatLines[1],
				Color = Color.Transparent,
				LuaKey = "TooltipData",
				LuaValue = tooltipData,
			})
		end
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY + ScreenCenterNativeOffsetY })

		button.OnMouseOverFunctionName = "MouseOverWeaponShopItem"
		button.OnMouseOffFunctionName = "MouseOffWeaponShopItem"

		if not firstUseable then
			screen.CursorStartX = itemLocationX
			screen.CursorStartY = itemLocationY
			firstUseable = true
		end

		button.Data = item
		button.Index = screen.NumItems
		button.Purchased = true

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	GameState.WorldUpgradesViewed[slotName] = true

end

function WeaponShopPinItem( screen, button )
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
		AddStoreItemPin( itemName, "WeaponShopItemData" )
		AddStoreItemPinPresentation( screen.SelectedItem )
	end
end

function CloseWeaponShopScreen( screen, button, args )
	for id, itemButton in pairs( screen.ItemButtons ) do
		UseableOff({ Id = id })
	end
	killTaggedThreads( "WeaponShopNavigationPulse" )
	OnScreenCloseStarted( screen )
	WeaponShopCloseCategory( screen )
	WeaponShopScreenCloseStartPresentation( screen, args )

	CloseScreen( GetAllIds( screen.Components ), nil, screen )
	AltAspectRatioFramesHide()
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
	WeaponShopScreenCloseFinishedPresentation( screen, button )
end

function HandleWeaponShopPurchase( screen, button )
	local upgradeData = button.Data

	if not button.Free and not HasResources( upgradeData.Cost ) then
		ScreenCantAffordPresentation( screen, button )
		return
	end

	if not IsEmpty( upgradeData.Cost ) ~= nil and upgradeData.PurchaseRequirements ~= nil and not IsGameStateEligible( upgradeData.PurchaseRequirements ) then
		CantPurchasePresentation( screen.Components["PurchaseButton".. button.Index] )
		return
	end

	for resourceName, resourceCost in pairs( upgradeData.Cost ) do
		SpendResource( resourceName, resourceCost, metaUpgradeName, { TargetId = screen.Components["ResourceIconBacking"..resourceName].Id, UseScreenLocation = true, TextOffsetY = 11, TextAnchorOffsetY = -50, HoldDuration = 0, FadeOutDuration = 0.2, SkipQuestStatusCheck = true, } )
	end

	WeaponShopItemPurchasedPresentation( button, upgradeData )

	GameState.WeaponsUnlocked[upgradeData.Name] = true
	CurrentRun.WeaponsUnlocked[upgradeData.Name] = true

	AddWorldUpgrade( upgradeData.Name, { SkipQuestStatusCheck = upgradeData.SkipAutoEquip } )
	RemoveStoreItemPin( upgradeData.Name, { Purchase = true } )
	CallFunctionName( upgradeData.OnPurchasedFunctionName, upgradeData.OnPurchasedFunctionArgs )

	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = screen.Components["PurchaseButton".. button.Index].Id, OffsetX = 0 })

	Destroy({ Id = screen.Components["PurchaseButton".. button.Index].Id })
	screen.Components["PurchaseButton".. button.Index] = nil

	if screen.Components["Icon".. button.Index] ~= nil then
		Destroy({ Id = screen.Components["Icon".. button.Index].Id })
		screen.Components["Icon".. button.Index] = nil
	end

	if upgradeData.SkipAutoEquip then
		screen.SkipQuestStatusCheck = true
	end

	CloseWeaponShopScreen( screen, button, { Purchasing = true } )

	thread( DoWeaponShopPurchase, screen, button )
end

function DoWeaponShopPurchase( screen, button )
	local itemData = button.Data
	local weaponData = WeaponData[itemData.Name]
	local traitData = TraitData[itemData.Name]
	if itemData.TraitUpgrade then
		traitData = TraitData[itemData.TraitUpgrade]
	end
	if traitData ~= nil and traitData.RequiredWeapon ~= nil then
		weaponData = WeaponData[traitData.RequiredWeapon]
		GameState.LastWeaponUpgradeName[weaponData.Name] = traitData.Name
	end

	if itemData.SkipAutoEquip then
		RequestPreRunLoadoutChangeSave()
		if traitData ~= nil and ( HeroHasTrait( traitData.Name ) or CurrentRun.Hero.Weapons[itemData.WeaponName] ) then
			UnequipWeaponUpgrade({ SkipUnequipFunctionName = HeroHasTrait( traitData.Name ) })
			EquipWeaponUpgrade( CurrentRun.Hero, { SkipKitUpdate = true, SkipQuestStatusCheck = true } )
		end

		WeaponShopPurchaseNoEquipPresentation( screen, button, itemData, weaponData )
		OpenWeaponShopScreen( screen.OpenedFrom, { DefaultCategoryIndex = screen.ActiveCategoryIndex } )

		return
	end
	
	WeaponShopPurchasePreActivatePresentation( screen, button, itemData, weaponData )
	if weaponData ~= nil then
		UnequipWeaponUpgrade()
		EquipPlayerWeapon( weaponData, { SkipSound = true } )
		EquipWeaponUpgrade( CurrentRun.Hero, { SkipUIUpdate = true} )
	end

	RequestPreRunLoadoutChangeSave()

	local weaponKit = CallFunctionName( itemData.OnActivateFunctionName, itemData, itemData.OnActivateFunctionArgs )
	if weaponData ~= nil and weaponKit == nil then
		for kitId, kit in pairs( MapState.WeaponKits ) do
			if kit.Name == weaponData.Name then
				weaponKit = kit
			end
		end
	end

	ActivateConditionalItem( itemData )
	if weaponData ~= nil then
		thread( UpdateWeaponKits )
	end
	WeaponShopPurchasePostActivatePresentation( button, itemData, weaponKit )
	UpdateAffordabilityStatus()
end

function WeaponShopScreenSelectCategory( screen, button )
	if button.CategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	GameState.Flags.HasUsedWeaponShopNavigation = true
	killTaggedThreads( "WeaponShopNavigationPulse" )
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	AddInputBlock({ Name = "WeaponShopScreenSelectCategory" })
	WeaponShopScreenHideItems( screen )
	screen.ScrollOffset = 0
	WeaponShopScreenDisplayCategory( screen, button.CategoryIndex )
	WeaponShopUpdateVisibility( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "WeaponShopScreenSelectCategory" })
end

function WeaponShopScreenNextCategory( screen, button )
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
	GameState.Flags.HasUsedWeaponShopNavigation = true
	killTaggedThreads( "WeaponShopNavigationPulse" )
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	AddInputBlock({ Name = "WeaponShopScreenSelectCategory" })
	WeaponShopScreenHideItems( screen )
	screen.ScrollOffset = 0
	WeaponShopScreenDisplayCategory( screen, nextCategoryIndex )
	WeaponShopUpdateVisibility( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "WeaponShopScreenSelectCategory" })
end

function WeaponShopScreenPrevCategory( screen, button )
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
	GameState.Flags.HasUsedWeaponShopNavigation = true
	killTaggedThreads( "WeaponShopNavigationPulse" )
	WeaponShopScreenSelectCategoryPresentation( screen, button )
	AddInputBlock({ Name = "WeaponShopScreenSelectCategory" })
	WeaponShopScreenHideItems( screen )
	screen.ScrollOffset = 0
	WeaponShopScreenDisplayCategory( screen, nextCategoryIndex )
	WeaponShopUpdateVisibility( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "WeaponShopScreenSelectCategory" })
end

function WeaponShopScreenHideItems( screen )

	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })
	if screen.Components.ResourceCostBacking ~= nil then
		SetAlpha({ Id = screen.Components.ResourceCostBacking.Id, Fraction = 0.0, Duration = 0.2 })
	end

	local componentIds =  {}
	for i = 1, screen.NumItems do
		local purchaseButtonKey = (screen.ButtonName or "PurchaseButton")..i
		if screen.Components[purchaseButtonKey] ~= nil then
			table.insert( componentIds, screen.Components[purchaseButtonKey].Id )
		end
		local iconKey = "Icon"..i
		if screen.Components[iconKey] ~= nil then
			table.insert( componentIds, screen.Components[iconKey].Id )
		end
		local newButtonKey = "NewIcon"..i
		if screen.Components[newButtonKey] ~= nil then
			table.insert( componentIds, screen.Components[newButtonKey].Id )
		end
		local pinButtonKey = "PinIcon"..i
		if screen.Components[pinButtonKey] ~= nil then
			table.insert( componentIds, screen.Components[pinButtonKey].Id )
		end
		local bannerIconKey = "BannerIcon"..i
		if screen.Components[bannerIconKey] ~= nil then
			table.insert( componentIds, screen.Components[bannerIconKey].Id )
		end
		if screen.Components["CurrentAmount"..i] ~= nil then
			table.insert( componentIds, screen.Components["CurrentAmount"..i].Id )
		end
		if screen.Components["SellText"..i] ~= nil then
			table.insert( componentIds, screen.Components["SellText"..i].Id )
		end
	end
	local fadeOutTime = 0.1
	SetAlpha({ Ids = componentIds, Fraction = 0, Duration = fadeOutTime })
	ModifyTextBox({ Ids = componentIds, FadeTarget = 0, FadeDuration = fadeOutTime })
	local categoryName = screen.ItemCategories[screen.ActiveCategoryIndex].Name
	ModifyTextBox({ Id = screen.Components["Category"..categoryName].Id, Color = Color.CodexTitleUnselected })
	wait( fadeOutTime )
	Destroy({ Ids = componentIds })

	if screen.Components.InfoBoxName ~= nil then
		ModifyTextBox({ Id = screen.Components.InfoBoxName.Id, FadeTarget = 0.0, })
		ModifyTextBox({ Id = screen.Components.InfoBoxDescription.Id, FadeTarget = 0.0, })
		ModifyTextBox({ Id = screen.Components.InfoBoxStatLineLeft.Id, FadeTarget = 0.0, })
		ModifyTextBox({ Id = screen.Components.InfoBoxStatLineRight.Id, FadeTarget = 0.0, })
		ModifyTextBox({ Id = screen.Components.InfoBoxFlavor.Id, FadeTarget = 0.0, })

		SetAlpha({ Id = screen.Components.InfoBoxIcon.Id, Fraction = 0.0, Duration = 0.2 })
		SetAlpha({ Id = screen.Components.InfoBoxFrame.Id, Fraction = 0.0, Duration = 0.2 })
	end

end

function WeaponShopScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	while not WeaponShopPageHasItems( screen, screen.ScrollOffset ) do
		screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	end
	GenericScrollPresentation( screen, button )
	WeaponShopUpdateVisibility( screen )
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
end

function WeaponShopScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	while not WeaponShopPageHasItems( screen, screen.ScrollOffset ) do
		screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	end
	GenericScrollPresentation( screen, button )
	WeaponShopUpdateVisibility( screen )
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })
end

function WeaponShopUpdateVisibility( screen )

	local components = screen.Components
	local offIds = {}
	local onIds = {}
	for index = 1, screen.NumItems do
		local questButtonKey = (screen.ButtonName or "PurchaseButton")..index
		local newButtonKey = "NewIcon"..index
		local iconKey = "Icon"..index
		local pinIconKey = "PinIcon"..index
		local sellTextKey = "SellText"..index
		local bannerIconKey = "BannerIcon"..index

		local visibleIndex = index - screen.ScrollOffset

		local button = components[questButtonKey]
		local item = button.Data

		local shouldDisplayItem = true
		if item ~= nil then
			local activeCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
			if item.SoldOut or (activeCategory.HideUnaffordable and not HasResources( item.Cost )) then
				shouldDisplayItem = false
			end
		end

		if visibleIndex >= 1 and visibleIndex <= screen.ItemsPerPage and shouldDisplayItem then
			-- Page in view
			Teleport({ Id = components[questButtonKey].Id, OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((visibleIndex - 1) * screen.ItemSpacingY) })
			table.insert( onIds, components[questButtonKey].Id )
			if components[iconKey] ~= nil then
				Teleport({ Id = components[iconKey].Id, OffsetX = screen.ItemStartX + screen.IconOffsetX, OffsetY = screen.ItemStartY + screen.IconOffsetY + ((visibleIndex - 1) * screen.ItemSpacingY) })
				table.insert( onIds, components[iconKey].Id )
			end
			if components[sellTextKey] ~= nil then
				Teleport({ Id = components[sellTextKey].Id, OffsetX = screen.ItemStartX + screen.CostTextOffsetX, OffsetY = screen.ItemStartY + screen.CostTextOffsetY + ((visibleIndex - 1) * screen.ItemSpacingY) })
				table.insert( onIds, components[sellTextKey].Id )
			end
			if components[pinIconKey] ~= nil then
				if components[pinIconKey].AlwaysVisible or HasStoreItemPin( button.Data.Name ) then
					table.insert( onIds, components[pinIconKey].Id )
				end
			end
			if components[bannerIconKey] ~= nil then
				table.insert( onIds, components[bannerIconKey].Id )
			end
			if components[newButtonKey] ~= nil then
				local record = GameState[components[questButtonKey].GameStateRecord or "WorldUpgradesViewed"]
				local nameKey = components[questButtonKey].NameKey or "Name"
				if not record[components[questButtonKey].Data[nameKey]] then
					Teleport({ Id = components[newButtonKey].Id, OffsetX = screen.ItemStartX + screen.IconOffsetX, OffsetY = screen.ItemStartY + screen.IconOffsetY + ((visibleIndex - 1) * screen.ItemSpacingY) })
					table.insert( onIds, components[newButtonKey].Id )
				end
			end
			if screen.ItemKeys ~= nil then
				for k, itemKey in pairs( screen.ItemKeys ) do
					local itemNumKey = itemKey..index
					if components[itemNumKey] ~= nil then
						Teleport({ Id = components[itemNumKey].Id, OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((visibleIndex - 1) * screen.ItemSpacingY) })
						table.insert( onIds, components[itemNumKey].Id )
					end
				end
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
			if components[iconKey] ~= nil then
				table.insert( offIds, components[iconKey].Id )
			end
			if components[newButtonKey] ~= nil then
				table.insert( offIds, components[newButtonKey].Id )
			end
			if components[pinIconKey] ~= nil then
				table.insert( offIds, components[pinIconKey].Id )
			end
			if components[bannerIconKey] ~= nil then
				table.insert( offIds, components[bannerIconKey].Id )
			end
			if screen.ItemKeys ~= nil then
				for k, itemKey in pairs( screen.ItemKeys ) do
					local itemNumKey = itemKey..index
					if components[itemNumKey] ~= nil then
						table.insert( offIds, components[itemNumKey].Id )
					end
				end
			end
		end

	end

	SetAlpha({ Ids = onIds, Fraction = 1, Duration = 0.1 })
	UseableOn({ Ids = onIds })

	SetAlpha({ Ids = offIds, Fraction = 0, Duration = 0.1 })
	UseableOff({ Ids = offIds, ForceHighlightOff = true })

	if components.ScrollUp ~= nil then
		if WeaponShopCanScrollUp( screen ) then
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollUp.Id })
		else
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
		end
	end

	if components.ScrollDown ~= nil then
		if WeaponShopCanScrollDown( screen ) then
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollDown.Id })
		else
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
		end
	end

end

function WeaponShopPageHasItems( screen, scrollOffset )
	for itemIndex = scrollOffset + 1, scrollOffset + screen.ItemsPerPage do
		if itemIndex <= screen.NumItems then
			local activeCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
			local item = screen.Components[(screen.ButtonName or "PurchaseButton")..itemIndex].Data
			if not item.SoldOut and ( not activeCategory.HideUnaffordable or HasResources( item.Cost ) ) then
				return true
			end
		end
	end
	return false
end

function WeaponShopCanScrollUp( screen )
	if screen.ScrollOffset > 0 then
		for offset = screen.ScrollOffset - screen.ItemsPerPage, 0, -screen.ItemsPerPage do
			if WeaponShopPageHasItems( screen, offset ) then
				return true
			end
		end
	end
	return false
end

function WeaponShopCanScrollDown( screen )
	if screen.ScrollOffset + screen.ItemsPerPage < screen.NumItems then
		for offset = screen.ScrollOffset + screen.ItemsPerPage, screen.NumItems, screen.ItemsPerPage do
			if WeaponShopPageHasItems( screen, offset ) then
				return true
			end
		end
	end
	return false
end

function GetWeaponShopCategoryToOpen( screen )
	-- Until you learn how to navigate the tabs, always open to the first tab
	if not GameState.Flags.HasUsedWeaponShopNavigation then
		return 1
	end
	-- If aspects haven't been unlocked, then default to the first tab with an affordable item
	if not GameState.WorldUpgrades.WorldUpgradeWeaponUpgradeSystem then
		for categoryIndex, category in ipairs( screen.ItemCategories ) do
			if GameState.WorldUpgradesRevealed[category.Name] and (category.GameStateRequirements == nil or IsGameStateEligible( category, category.GameStateRequirements )) then
				for i, itemName in ipairs( category ) do
					local itemData = WeaponShopItemData[itemName]
					if not itemData.DebugOnly and not GameState.WorldUpgrades[itemName] and HasResources( itemData.Cost ) and (itemData.GameStateRequirements == nil or IsGameStateEligible( itemData, itemData.GameStateRequirements )) then
						return categoryIndex
					end
				end
			end
		end
	end
	-- Open to the first category with an unviewed item
	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		if GameState.WorldUpgradesRevealed[category.Name] and (category.GameStateRequirements == nil or IsGameStateEligible( category, category.GameStateRequirements )) then
			for i, itemName in ipairs( category ) do
				local itemData = WeaponShopItemData[itemName]
				if not itemData.DebugOnly and not GameState.WorldUpgradesViewed[itemName] and (itemData.GameStateRequirements == nil or IsGameStateEligible( itemData, itemData.GameStateRequirements )) then
					return categoryIndex
				end
			end
		end
	end
	-- Open to the equipped weapon's upgrade tab
	if GameState.WorldUpgradesAdded.WorldUpgradeWeaponUpgradeSystem then
		local equippedWeapon = GetEquippedWeapon()
		for categoryIndex, category in ipairs( screen.ItemCategories ) do
			if category.WeaponName == equippedWeapon and GameState.WorldUpgradesRevealed[category.Name] and (category.GameStateRequirements == nil or IsGameStateEligible( category, category.GameStateRequirements )) then
				return categoryIndex
			end
		end
	end
	return 1
end

function UpdateWeaponKitUpgrade( weaponName, traitName, args )
	if MapState.WeaponKits == nil or weaponName == nil or traitName == nil then
		return
	end
	args = args or {}

	for kitId, weaponKit in pairs( MapState.WeaponKits ) do
		if weaponKit.Name == weaponName then
			local traitData = GetHeroTrait(traitName)
			DebugAssert({Condition = traitData ~= nil, Text = "Trait data not found"})
			if not args.SkipKitUpdate then
				SetAnimation({ Name = weaponKit.EquippedKitAnimation, GrannyModel = traitData.WeaponKitGrannyModel, DestinationId = weaponKit.ObjectId, CopyFromPrev = true })
			end
			if traitData.ReplacementGrannyModels ~= nil then
				for originalModel, attachmentModel in pairs(traitData.ReplacementGrannyModels) do 
					SetThingProperty({ Property = "GrannyAlternateModelAttachment", Value = attachmentModel, OriginalAttachmentModel = originalModel, DestinationId = CurrentRun.Hero.ObjectId })
				end
			end	
			return
		end
	end
end

function AssignWeaponKits( eventSource, args )

	MapState.WeaponKitIds = GetIdsByType({ Name = "WeaponKit01" })
	table.sort( MapState.WeaponKitIds )
	MapState.WeaponKits = {}

	local packages = {}
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		table.insert( packages, weaponName )
		local linkdWeaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if linkdWeaponNames ~= nil then
			ConcatTableValues( packages, linkedWeaponNames )
		end
	end
	LoadPackages({ Names = packages })

	for index, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
	
		local kitId = MapState.WeaponKitIds[index]
		local weaponKit = DeepCopyTable( WeaponData[weaponName] )
		if not weaponKit.DebugOnly then
			
			AttachLua({ Id = kitId, Table = weaponKit })
			weaponKit.ObjectId = kitId
			MapState.WeaponKits[kitId] = weaponKit

			local kitModel = weaponKit.GrannyModel
		
			-- Change kit model if aspect trait is active
			local activeTraitName = GameState.LastWeaponUpgradeName[weaponName]
			local activeTraitData = TraitData[activeTraitName]
			if activeTraitData ~= nil then
				kitModel = activeTraitData.WeaponKitGrannyModel
			end
			SetAnimation({ Name = weaponKit.UnequippedKitAnimation, GrannyModel = kitModel, DestinationId = weaponKit.ObjectId })
			CreateAnimation({ Name = "WeaponKitBaseFx", DestinationId = weaponKit.ObjectId, Group = "FX_Dark" })

			if kitId and ( args.IgnoreRequirements or IsWeaponUnlocked( weaponName )) then
				-- Unlocked			
				weaponKit.OnUsedFunctionName = "UseWeaponKit"
			else
				-- Locked
				UseableOff({ Id = kitId })
				SetAlpha({ Id = kitId, Fraction = 0.0 })
			end

			if IsBonusUnusedWeapon( weaponKit.Name ) then
				CreateAnimation({ Name = "WeaponKitDarkThirst", DestinationId = kitId }) -- nopkg
			end
		else
			UseableOff({ Id = kitId })
			SetAlpha({ Id = kitId, Fraction = 0.0 })
		end
	end
	for remainingIndex = #WeaponSets.HeroPrimaryWeapons + 1, #MapState.WeaponKitIds do
		local remainingKitId = MapState.WeaponKitIds[remainingIndex]
		SetAlpha({ Id = remainingKitId, Fraction = 0.0 })
	end

	UpdateWeaponKits()
end

function GetWeaponKit( weaponName )
	if IsEmpty( MapState.WeaponKits ) then
		return
	end
	for kitId, weaponKit in pairs( MapState.WeaponKits ) do
		if weaponKit.Name == weaponName then
			return weaponKit
		end
	end
	return nil
end

function ActivateWeaponKit( itemData, args )
	local weaponKit = GetWeaponKit( itemData.Name )
	weaponKit.OnUsedFunctionName = "UseWeaponKit"
	SetWeaponKitUseText( weaponKit )
	UseableOn({ Id = weaponKit.ObjectId })
	return weaponKit
end

function UpdateWeaponKits( args )

	if MapState.WeaponKits == nil then
		return
	end

	args = args or {}
	local fadeTime = args.FadeTime or 0.2

	for kitId, weaponKit in pairs( MapState.WeaponKits ) do
		if IsWeaponUnlocked( weaponKit.Name ) then
			if CurrentRun.Hero.Weapons[weaponKit.Name] ~= nil then
				-- Equipped
				-- SetAlpha({ Id = kitId, Fraction = 0.4, Duration = fadeTime })
				CreateAnimation({ Name = "WeaponKitEquippedFront", DestinationId = kitId, Group = "Standing" })
				CreateAnimation({ Name = "WeaponKitEquippedBack", DestinationId = kitId, Group = "Standing" })

				if GetWeaponKitAnimation( weaponKit.Name, "Equipped") ~= nil then
					SetAnimation({ Name = GetWeaponKitAnimation( weaponKit.Name, "Equipped"), DestinationId = kitId, CopyFromPrev = true })
				end
				ModifyTextBox({ Id = kitId, FadeTarget = 0.5, Duration = fadeTime })

				if HasAnyAspectUnlocked( weaponKit.Name ) then
					UseableOn({ Id = kitId })
					if weaponKit.AspectAnimId == nil then
						weaponKit.AspectAnimId = CreateAnimation({ Name = weaponKit.AspectAvailableAnimation, DestinationId = kitId })
					end
				else
					UseableOff({ Id = kitId })
					StopAnimation({ Name = weaponKit.AspectAvailableAnimation, DestinationId = kitId })
					weaponKit.AspectAnimId = nil
				end

			end
			SetWeaponKitUseText( weaponKit )
		end
	end


	for kitId, weaponKit in pairs( MapState.WeaponKits ) do
		if IsWeaponUnlocked( weaponKit.Name ) then
			if CurrentRun.Hero.Weapons[weaponKit.Name] == nil then
				-- Unequipped
				UseableOn({ Id = kitId })
				ModifyTextBox({ Id = kitId, FadeTarget = 1.0, Duration = fadeTime })
				if GetWeaponKitAnimation( weaponKit.Name, "Unequipped") ~= nil then
					SetAnimation({ Name = GetWeaponKitAnimation( weaponKit.Name, "Unequipped"), DestinationId = kitId, CopyFromPrev = true })
				end
				SetAlpha({ Id = kitId, Fraction = 1.0, Duration = fadeTime })
				StopAnimation({ Name = "WeaponKitEquippedFront", DestinationId = kitId })
				StopAnimation({ Name = "WeaponKitEquippedBack", DestinationId = kitId })

				if HasAnyAspectUnlocked( weaponKit.Name ) then
					if weaponKit.AspectAnimId == nil then
						weaponKit.AspectAnimId = CreateAnimation({ Name = weaponKit.AspectAvailableAnimation, DestinationId = kitId })
					end
				else
					StopAnimation({ Name = weaponKit.AspectAvailableAnimation, DestinationId = kitId })
					weaponKit.AspectAnimId = nil
				end

			end
		end
	end

	UpdateShrineRunDoorArrow()

end

function SetWeaponKitUseText( weaponKit )
	if CurrentRun.Hero.Weapons[weaponKit.Name] ~= nil then
		-- Equipped
		if HasAnyAspectUnlocked( weaponKit.Name ) then
			weaponKit.UseText = "UseWeaponKit_Aspects"
		else
			-- Blank
		end
	elseif IsWeaponUnlocked( weaponKit.Name ) then
		-- Unequipped
		if IsBonusUnusedWeapon( weaponKit.Name ) then
			weaponKit.UseText = WeaponData[weaponKit.Name].UseText .."_UnusedBonus"
		else
			weaponKit.UseText = WeaponData[weaponKit.Name].UseText
		end
		weaponKit.ResourceBonus = TraitData.UnusedWeaponBonusTrait.AddResources
	end
end

function ShouldShowWeaponShopWantsToTalkIndicator( source, args )
	for _, category in ipairs( ScreenData.WeaponShop.ItemCategories ) do
		if category.GameStateRequirements == nil or IsGameStateEligible( category, category.GameStateRequirements ) then
			for _, itemName in ipairs( category ) do
				local itemData = WeaponShopItemData[itemName]
				if itemData ~= nil and ( itemData.GameStateRequirements == nil or IsGameStateEligible( itemData, itemData.GameStateRequirements ) ) then
					if not GameState.WorldUpgradesViewed[itemName] or ( itemData.Priority and not GameState.WorldUpgradesAdded[itemName] and HasResources( itemData.Cost ) ) then
						return true
					end
				end
			end
		end
	end
	return false
end
