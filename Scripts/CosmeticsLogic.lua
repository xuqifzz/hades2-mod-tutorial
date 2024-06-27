function UseCosmeticsShop( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	thread( MarkObjectiveComplete, "DoraDecorationIntroPrompt" )
	local screen = OpenCosmeticsShopScreen( usee, usee.DefaultCategoryIndex )
	UseableOn({ Id = usee.ObjectId })
	GhostAdminSessionCompletePresentation( usee, screen )
end

function OpenCosmeticsShopScreen( openedFrom, defaultCategoryIndex )

	local screen = DeepCopyTable( ScreenData.CosmeticsShop )
	screen.OpenedFrom = openedFrom
	screen.DefaultCategoryIndex = defaultCategoryIndex or CurrentHubRoom.CosmeticsCategoryIndex or 1
	screen.ActiveCategoryIndex = screen.DefaultCategoryIndex

	if IsScreenOpen( screen.Name ) then
		return
	end
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	if screen.OpenSound ~= nil then
		PlaySound({ Name = screen.OpenSound })
	end

	local components = screen.Components
	
	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0} })

	wait(0.2)

	screen.NumCategories = 0

	local categoryTitleX = screen.CategoryStartX
	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		if categoryIndex == screen.DefaultCategoryIndex then
			local slotName = category.Name
			screen.Components["Category"..slotName] = CreateScreenComponent({ Name = "ResourceShopTab", X = categoryTitleX, Y = screen.CategoryStartY, Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
			screen.Components["Category"..slotName].OnPressedFunctionName = "CosmeticShopSelectCategory"
			screen.Components["Category"..slotName].CategoryIndex = categoryIndex
			CreateTextBox({ Id = screen.Components["Category"..slotName].Id,
				Text = slotName,
				FontSize = 22,
				Color = Color.CodexTitleUnselected,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Center"
			})

			if slotName ~= screen.ActiveCategory and HasUnviewedCosmetic( slotName ) then
				-- New icon
				local newButtonKey = "NewIcon"..slotName
				components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
				SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "MusicPlayerNewTrack" })
				Attach({ Id = components[newButtonKey].Id, DestinationId = screen.Components["Category"..slotName].Id, OffsetX = 0, OffsetY = -30 })
			elseif not HasUnpurchasedCosmetic( slotName ) then
				-- Complete icon
				local completeButtonKey = "CompleteIcon"..slotName
				components[completeButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
				SetAnimation({ DestinationId = components[completeButtonKey].Id , Name = "ContractorPurchasedCheckmark" })
				Attach({ Id = components[completeButtonKey].Id, DestinationId = screen.Components["Category"..slotName].Id, OffsetX = -90, OffsetY = 0 })
			end

			screen.NumCategories = screen.NumCategories + 1
			categoryTitleX = categoryTitleX + screen.CategorySpacingX
		end
	end

	if screen.NumCategories <= 1 then
		components.ScrollLeft.OnPressedFunctionName = nil
		components.ScrollRight.OnPressedFunctionName = nil
	end

	CosmeticShopDisplayCategory( screen, screen.ActiveCategoryIndex )

	screen.Components.ScrollUp = CreateScreenComponent({ Name = "ButtonCodexUp", X = 24, Y = 227, Scale = 0.75, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
	screen.Components.ScrollUp.OnPressedFunctionName = "GhostAdminScrollUp"
	screen.Components.ScrollUp.ControlHotkey = "MenuUp"

	screen.Components.ScrollDown = CreateScreenComponent({ Name = "ButtonContractorDown", X = 24, Y = 940, Scale = 0.75, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
	screen.Components.ScrollDown.OnPressedFunctionName = "GhostAdminScrollDown"
	screen.Components.ScrollDown.ControlHotkey = "MenuDown"

	SetAlpha({ Ids = { components.ScrollUp.Id, components.ScrollDown.Id }, Fraction = 0, Duration = 0 })
	GhostAdminUpdateVisibility( screen )
	UpdateGhostAdminInteractionText( screen )

	thread( GhostAdminScreenOpenFinishedPresentation, screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen

end

function CosmeticShopDisplayCategory( screen, categoryIndex )

	local components = screen.Components

	local slotName = screen.ItemCategories[categoryIndex].Name

	ModifyTextBox({ Id = components["Category"..slotName].Id, Color = Color.White })
	DestroyTextBox({ Id = components.ShopBackgroundDim.Id })

	local newButtonKey = "NewIcon"..slotName
	if components[newButtonKey] ~= nil then
		SetAlpha({ Id = components[newButtonKey].Id, Fraction = 0.0 })
	end

	screen.ActiveCategoryIndex = categoryIndex

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	screen.AvailableItems = {}
	screen.PurchasedItems = {}

	for i, cosmeticName in ipairs( screen.ItemCategories[categoryIndex] ) do
		local cosmeticData = WorldUpgradeData[cosmeticName]
		if cosmeticData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, cosmeticData, cosmeticData.GameStateRequirements ) then
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
				DebugAssert({ Condition = false, Text = itemName.." not categorized in CosmeticData" })
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

		screen.OfferedVoiceLines = screen.OfferedVoiceLines or cosmetic.OfferedVoiceLines

		local purchaseButtonKey = "PurchaseButton"..screen.NumItems
		local buttonName = "CriticalItemShopButton"
		components[purchaseButtonKey] = CreateScreenComponent({ Name = buttonName, Group = "Combat_Menu", X = itemLocationX, Y = itemLocationY })
		local button = components[purchaseButtonKey]
		AttachLua({ Id = button.Id, Table = button })
		button.Screen = screen
		button.InfoBoxName = components.InfoBoxName
		button.InfoBoxDescription = components.InfoBoxDescription
		button.InfoBoxFlavor = components.InfoBoxFlavor
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })

		local iconKey = "Icon"..screen.NumItems
		if cosmetic.Icon ~= nil then
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX + screen.IconOffsetX, Y = itemLocationY, Scale = 0.4, Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[iconKey].Id , Name = cosmetic.Icon })
		end

		local name = cosmetic.Name
		local displayName = name

		local resourceData = ResourceData[cosmetic.ResourceName]
		local costColor = Color.CostAffordableShop
		if not HasResources( cosmetic.Cost ) then
			costColor = Color.CostUnaffordable
		elseif screen.ActiveCategoryIndex ~= screen.DefaultCategoryIndex then
			costColor = {0.5, 0.5, 0.5, 1.0}
		end

		-- Title
		local purchaseButtonTitleKey = "PurchaseButtonTitle"..screen.NumItems
		components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX, Y = itemLocationY })
		CreateTextBox({ Id = components[purchaseButtonTitleKey].Id,
			Text = displayName,
			OffsetX = -280,
			OffsetY = 0,
			FontSize = 22,
			Width = 720,
			Color = costColor,
			Font = "P22UndergroundSCMedium",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Left",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		})

		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = displayName,
			UseDescription = true,
			OffsetX = -1920, OffsetY = 0,
			Font = "P22UndergroundSCHeavy",
			Justification = "LEFT",
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = cosmetic,
		})
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })

		button.OnMouseOverFunctionName = "MouseOverGhostAdminItem"
		button.OnMouseOffFunctionName = "MouseOffGhostAdminItem"
		if screen.ActiveCategoryIndex == screen.DefaultCategoryIndex then
			button.OnPressedFunctionName = "HandleCosmeticShopPurchase"
		end
		if not firstUseable then
			TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
			firstUseable = true
		end

		button.Data = cosmetic
		button.Index = screen.NumItems
		button.TitleId = components[purchaseButtonTitleKey].Id
		button.DisplayName = name

		-- Pin icon
		local pinButtonKey = "PinIcon"..screen.NumItems
		components[pinButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
		Attach({ Id = components[pinButtonKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 200, OffsetY = 0 })
		components[purchaseButtonKey].PinButtonId = components[pinButtonKey].Id
		if HasStoreItemPin( button.Data.Name ) then
			SetAnimation({ Name = "StoreItemPin", DestinationId = components[purchaseButtonKey].PinButtonId })
			-- Silent toolip
			CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
		end

		-- New icon
		if not GameState.WorldUpgradesViewed[cosmetic.Name] then
			local newIconKey = "NewIcon"..screen.NumItems
			components[newIconKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
			Attach({ Id = components[newIconKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 300, OffsetY = 0 })
			components[purchaseButtonKey].NewButtonId = components[newIconKey].Id
			SetAnimation({ DestinationId = components[newIconKey].Id , Name = "MusicPlayerNewTrack" })

			--ModifyTextBox({ Id = components[purchaseButtonTitleKey].Id, FadeTarget = 0, Duration = 0 })
			--SetAlpha({ Id = components[purchaseButtonKey].Id, Fraction = 0, Duration = 0 })
			--if components[iconKey] ~= nil then
				--SetAlpha({ Id = components[iconKey].Id, Fraction = 0, Duration = 0 })
			--end
			--SetAlpha({ Id = components[newIconKey].Id, Fraction = 0, Duration = 0 })
		end

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	-- Purchased
	for k, cosmetic in ipairs( screen.PurchasedItems ) do

		screen.NumItems = screen.NumItems + 1

		local buttonName = "CriticalItemShopButton"
		if not cosmetic.Removable or ( cosmetic.RotateOnly and GameState.WorldUpgrades[cosmetic.Name] ) then
			buttonName = "CriticalItemShopButtonDisabled"
		end

		local purchaseButtonKey = "PurchaseButton"..screen.NumItems
		components[purchaseButtonKey] = CreateScreenComponent({ Name = buttonName, Group = "Combat_Menu", X = itemLocationX, Y = itemLocationY })
		local button = components[purchaseButtonKey]
		AttachLua({ Id = button.Id, Table = button })
		button.Screen = screen
		button.InfoBoxName = components.InfoBoxName
		button.InfoBoxDescription = components.InfoBoxDescription
		button.InfoBoxFlavor = components.InfoBoxFlavor
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })

		local purchaseButtonTitleKey = "PurchaseButtonTitle"..screen.NumItems
		components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })

		if cosmetic.Icon ~= nil then
			local iconKey = "Icon"..screen.NumItems
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX + screen.IconOffsetX, Y = itemLocationY, Scale = 0.4, Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[iconKey].Id , Name = cosmetic.Icon })
		end

		local name = cosmetic.Name
		local displayName = name

		local titleColor = {0.5, 0.5, 0.5, 1.0}
		local displayName = cosmetic.RePurchaseName or name
		local stateText = "Shop_Purchased"
		if cosmetic.Removable then
			if GameState.WorldUpgrades[name] then
				if not cosmetic.RotateOnly then
					components[purchaseButtonKey].OnPressedFunctionName = "HandleCosmeticShopRemoval"
					--titleColor = Color.CostAffordableShop
					stateText = "Shop_Removable"
				end
			else
				components[purchaseButtonKey].Free = true
				components[purchaseButtonKey].OnPressedFunctionName = "HandleCosmeticShopPurchase"
				--titleColor = Color.CostAffordableShop
				stateText = "Shop_ReAdd"
			end
		end

		-- Title
		CreateTextBox({ Id = components[purchaseButtonTitleKey].Id,
			Text = displayName,
			OffsetX = -280,
			OffsetY = 0,
			FontSize = 22,
			Width = 720,
			Color = titleColor,
			Font = "P22UndergroundSCMedium",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
			Justification = "Left",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		})
		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = displayName,
			UseDescription = true,
			OffsetX = -1920, OffsetY = 0,
			Font = "P22UndergroundSCHeavy",
			Justification = "LEFT",
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = cosmetic,
		})

		-- State
		CreateTextBox({ Id = components[purchaseButtonTitleKey].Id,
			Text = stateText,
			OffsetX = 330,
			OffsetY = 0,
			FontSize = 28,
			Color = Color.White,
			Font = "LatoBold",
			Justification = "Center",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		})

		button.OnMouseOverFunctionName = "MouseOverGhostAdminItem"
		button.OnMouseOffFunctionName = "MouseOffGhostAdminItem"

		if not firstUseable then
			TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
			firstUseable = true
		end

		button.Data = cosmetic
		button.Index = screen.NumItems
		button.TitleId = components[purchaseButtonTitleKey].Id
		button.DisplayName = name
		button.Purchased = true

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	CosmeticShopPostDisplayCategoryPresentation( screen )

end

function HandleCosmeticShopPurchase( screen, button )
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

	Destroy({ Id = screen.Components["PurchaseButtonTitle".. button.Index].Id })
	screen.Components["PurchaseButtonTitle".. button.Index] = nil

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
			local purchaseButtonTitleKey = "PurchaseButtonTitle"..button.Index
			ModifyTextBox({ Id = screen.Components[purchaseButtonTitleKey].Id, Color = costColor })
		end
	end
	-- close screen
	CloseGhostAdminScreen( screen, button )

	thread( DoCosmeticShopPurchase, screen, button )
end

function DoCosmeticShopPurchase( screen, button )
	local itemData = button.Data
	PreActivateCosmeticPresentation( screen, button, itemData )
	CallFunctionName( itemData.OnActivateFunctionName, itemData.OnActivateFunctionArgs )
	ActivateConditionalItem( itemData )
	PostActivateCosmeticPresentation( button, itemData )
	CallFunctionName( itemData.OnActivateFinishedFunctionName, itemData.OnActivateFinishedFunctionArgs )
	UpdateAffordabilityStatus()
end

function HandleCosmeticShopRemoval( screen, button )
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

	thread( DoCosmeticShopRemoval, screen, button )
end

function DoCosmeticShopRemoval( screen, button )
	local itemData = button.Data
	PreActivateCosmeticPresentation( screen, button, itemData, { Removal = true } )
	DeactivateConditionalItem( itemData )
	PostActivateCosmeticPresentation( button, itemData, { Removal = true } )
end

function CosmeticShopNextCategory( screen, button )
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
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY) })
	CosmeticShopDisplayCategory( screen, nextCategoryIndex )
	GhostAdminUpdateVisibility( screen )
end

function CosmeticShopPrevCategory( screen, button )
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
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY) })
	CosmeticShopDisplayCategory( screen, nextCategoryIndex )
	GhostAdminUpdateVisibility( screen )
end

function CosmeticShopSelectCategory( screen, button )
	GhostAdminSelectCategoryPresentation( screen, button )
	if button.CategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	AddInputBlock({ Name = "GhostAdminSelectCategory" })
	GhostAdminHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY) })
	CosmeticShopDisplayCategory( screen, button.CategoryIndex )
	GhostAdminUpdateVisibility( screen )
	RemoveInputBlock({ Name = "GhostAdminSelectCategory" })
end

function ActivateConditionalItems( eventSource, args )

	args = args or {}

	if args.CosmeticsShopCategoryIndex ~= nil then
		local itemNames = ScreenData.CosmeticsShop.ItemCategories[args.CosmeticsShopCategoryIndex]
		for i, itemName in ipairs( itemNames ) do
			local itemData = WorldUpgradeData[itemName]
			if itemData ~= nil then
				if GameState.WorldUpgrades[itemName] and not itemData.Disabled then
					ActivateConditionalItem( itemData )
				elseif not GetConfigOptionValue({ Name = "EditingMode" }) then
					DeactivateConditionalItem( itemData )
				end
			end
		end
	end

	if args.GhostAdminCategoryIndex ~= nil then
		local criticalItemNames = ScreenData.GhostAdmin.ItemCategories[args.GhostAdminCategoryIndex]
		for i, itemName in ipairs( criticalItemNames ) do
			local itemData = WorldUpgradeData[itemName]
			if itemData ~= nil then
				if GameState.WorldUpgrades[itemName] and not itemData.Disabled then
					ActivateConditionalItem( itemData )
				elseif not GetConfigOptionValue({ Name = "EditingMode" }) then
					DeactivateConditionalItem( itemData )
				end
			end
		end
	end

end

function ActivateConditionalItem( itemData, args )
	-- On
	args = args or {}
	if itemData.DestroyIds ~= nil then
		Destroy({ Ids = itemData.DestroyIds })
	end
	if itemData.DestroyNames ~= nil then
		Destroy({ Ids = GetIdsByType({ Name = itemData.DestroyNames }) })
	end
	if itemData.ActivateIds ~= nil then
		Activate({ Ids = itemData.ActivateIds })
		SetAlpha({ Ids = itemData.ActivateIds, Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = itemData.ActivateIds })
			SetThingProperty({ Property = "StopsLight", Value = true, DestinationIds = itemData.ActivateIds })
		end
		if itemData.ToggleVfx then
			UnblockVfx({ DestinationIds = itemData.ActivateIds, ResetCap = true })
		end
	end
	if itemData.ToggleUseability then
		UseableOn({ Ids = itemData.ToggleUseabilityIds or itemData.ActivateIds })
	end
	if itemData.DeactivateIds ~= nil and not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = itemData.DeactivateIds, Fraction = 0 })
		if itemData.ActivateStopAnimations then
			StopAnimation({ Names = itemData.ActivateStopAnimations, DestinationIds = itemData.DeactivateIds, PreventChain = true })
		end
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = itemData.DeactivateIds })
			SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = itemData.DeactivateIds })
		end
	end
	if itemData.ToggleUseabilityOffIds then
		UseableOff({ Ids = itemData.ToggleUseabilityOffIds })
	end
	if itemData.DeactivateCosmetics ~= nil then
		for k, name in pairs( itemData.DeactivateCosmetics ) do
			DeactivateConditionalItem( WorldUpgradeData[name] )
		end
	end
	if itemData.ActivateNames ~= nil then
		local activateNameIds = GetIdsByType({ Name = itemData.ActivateNames })
		Activate({ Ids = activateNameIds })
		SetAlpha({ Ids = activateNameIds, Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = activateNameIds })
			SetThingProperty({ Property = "StopsLight", Value = true, DestinationIds = activateNameIds })
		end
	end
	if itemData.DeactivateNames ~= nil and not GetConfigOptionValue({ Name = "EditingMode" }) then
		local deactivateNameIds = GetIdsByType({ Name = itemData.DeactivateNames })
		SetAlpha({ Ids = deactivateNameIds, Fraction = 0 })
	end
	if itemData.ActivateGroups ~= nil then
		Activate({ Names = itemData.ActivateGroups })
		SetAlpha({ Ids = GetIds({ Names = itemData.ActivateGroups }), Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = true, DestinationNames = itemData.ActivateGroups })
			SetThingProperty({ Property = "StopsLight", Value = true, DestinationNames = itemData.ActivateGroups })
		end
	end
	if itemData.DeactivateGroups ~= nil and not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = GetIds({ Names = itemData.DeactivateGroups }), Fraction = 0 })
	end
	if itemData.ActivateObstacles ~= nil then
		for id, obstacleData in pairs( itemData.ActivateObstacles ) do
			local obstacle = DeepCopyTable( obstacleData )
			obstacle.ObjectId = id
			Activate({ Id = obstacle.ObjectId })
			SetAlpha({ Id = obstacle.ObjectId, Fraction = 1 })
			SetupObstacle( obstacle )
		end
	end
	if itemData.ActivateRoomObstacleIds ~= nil then
		for k, id in ipairs( itemData.ActivateRoomObstacleIds ) do
			local obstacleData = CurrentHubRoom.ObstacleData[id]
			if obstacleData ~= nil then
				local obstacle = DeepCopyTable( obstacleData )
				obstacle.ObjectId = id
				if obstacle.Template ~= nil and ObstacleData[obstacle.Template] ~= nil then
					obstacle = MergeTables( ObstacleData[obstacle.Template], obstacle )
				end
				SetupObstacle( obstacle, nil, args )
			else
				DebugAssert({ Condition = false, Text = itemData.Name.." trying to activate an id that doesn't exist: "..id })
			end
		end
	end
	if itemData.ActivatePrePlaced ~= nil then
		ActivatePrePlaced( itemData, itemData.ActivatePrePlaced )
	end
	if itemData.InspectPointId ~= nil and CurrentHubRoom.InspectPoints[itemData.InspectPointId] ~= nil then
		local inspectPointData = CurrentHubRoom.InspectPoints[itemData.InspectPointId]
		local hasUsed = false
		if inspectPointData.InteractTextLineSets ~= nil then
			for textLineName, textLine in pairs( inspectPointData.InteractTextLineSets ) do
				if GameState.TextLinesRecord[textLineName] then
					hasUsed = true
				end
			end
		end
		if not hasUsed then
			inspectPointData.ObjectId = itemData.InspectPointId
			SetupInspectPoint( inspectPointData )
			SetAlpha({ Id = itemData.InspectPointId, Fraction = 1 })
			UseableOn({ Id = itemData.InspectPointId })
		end
	end

	if itemData.SetAnimations ~= nil then
		for name, animation in pairs( itemData.SetAnimations ) do
			SetAnimation({ DestinationIds = GetIdsByType({ Name = name }), Name = animation })
		end
	end
	if itemData.SetAnimationIds ~= nil then
		for id, animation in pairs( itemData.SetAnimationIds ) do
			SetAnimation({ DestinationId = id, Name = animation })
		end
	end
	if itemData.SetHSVs ~= nil then
		for name, hsv in pairs( itemData.SetHSVs ) do
			SetHSV({ Ids = GetIdsByType({ Name = name }), HSV = hsv, ValueChangeType = "Absolute" })
		end
	end
	if itemData.SetColorIds ~= nil then
		SetColor({ Ids = itemData.SetColorIds, Color = itemData.SetColorValue, SetBase = true, })
	end
	if itemData.DistanceTriggers ~= nil then
		StartTriggers( itemData, itemData.DistanceTriggers )
	end
end

function DeactivateConditionalItem( itemData )

	if itemData == nil then
		return
	end

	-- Off
	if itemData.RemoveCosmetics == nil or not ContainsAnyKey( GameState.WorldUpgrades, itemData.RemoveCosmetics ) or itemData.IndependentToggle then
		if itemData.ActivateIds ~= nil then
			SetAlpha({ Ids = itemData.ActivateIds, Fraction = 0 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = itemData.ActivateIds })
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = itemData.ActivateIds })
			end
			if itemData.ToggleVfx then
				BlockVfx({ DestinationIds = itemData.ActivateIds })
			end
			if itemData.DeactivateStopAnimations then
				StopAnimation({ Names = itemData.DeactivateStopAnimations, DestinationIds = itemData.ActivateIds, PreventChain = true })
			end
		end
		if itemData.ToggleUseability then
			UseableOff({ Ids = itemData.ToggleUseabilityIds or itemData.ActivateIds })
		end
		if itemData.ActivateNames ~= nil then
			local activateNameIds = GetIdsByType({ Name = itemData.ActivateNames })
			SetAlpha({ Ids = activateNameIds, Fraction = 0 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = activateNameIds })
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = activateNameIds })
			end
		end
		if itemData.ActivateGroups ~= nil then
			SetAlpha({ Ids = GetIds({ Names = itemData.ActivateGroups }), Fraction = 0 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationNames = itemData.ActivateGroups })
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationNames = itemData.ActivateGroups })
			end
		end
		if itemData.RemovalDeactivateIds ~= nil or itemData.DeactivateIds ~= nil then
			SetAlpha({ Ids = itemData.RemovalDeactivateIds or itemData.DeactivateIds, Fraction = 1 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = itemData.RemovalDeactivateIds or itemData.DeactivateIds })
				SetThingProperty({ Property = "StopsLight", Value = true, DestinationIds = itemData.RemovalDeactivateIds or itemData.DeactivateIds })
			end
		end
		if itemData.ConnectedIds then
			SetAlpha({ Ids = itemData.ConnectedIds, Fraction = 0 })
		end
		if itemData.InspectPointId ~= nil and CurrentHubRoom.InspectPoints[itemData.InspectPointId] ~= nil then
			local inspectPointData = CurrentHubRoom.InspectPoints[itemData.InspectPointId]
			local hasUsed = false
			if inspectPointData.InteractTextLineSets ~= nil then
				for textLineName, textLine in pairs( inspectPointData.InteractTextLineSets ) do
					if GameState.TextLinesRecord[textLineName] then
						hasUsed = true
					end
				end
			end
			if not hasUsed then
				UseableOff({ Id = itemData.InspectPointId })
				SetAlpha({ Id = itemData.InspectPointId, Fraction = 0 })
			end
		end
		if itemData.DeactivateAnimations ~= nil then
			for name, animation in pairs( itemData.DeactivateAnimations ) do
				SetAnimation({ DestinationIds = GetIdsByType({ Name = name }), Name = animation })
			end
		end
		if itemData.DeactivateAnimationIds ~= nil then
			for id, animation in pairs( itemData.DeactivateAnimationIds ) do
				SetAnimation({ DestinationId = id, Name = animation })
			end
		end
	end
end
