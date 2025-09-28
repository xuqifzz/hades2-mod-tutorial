function GiftFamiliarUpgrade( usee, args )

	AddInputBlock({ Name = "GiftFamiliarUpgrade" })

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )

	GiftFamiliarUpgradePresentation( usee, args )

	RemoveInputBlock({ Name = "GiftFamiliarUpgrade" })
	
	local screen = OpenFamiliarShopScreen( usee )
	UseableOn({ Id = usee.ObjectId })

end

function FamiliarShopScreenDisplayCategory( screen )

	local components = screen.Components

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	local availableItems = {}
	local purchasedItems = {}

	for i, itemName in ipairs( screen.ItemOrder ) do
		local itemData = FamiliarShopItemData[itemName]
		if not itemData.DebugOnly then
			if itemData.FamiliarName == screen.OpenedFrom.Name and ( itemData.GameStateRequirements == nil or IsGameStateEligible( itemData, itemData.GameStateRequirements ) ) then
				if GameState.FamiliarUpgrades[itemName] then
					if screen.ReadOnly or itemData.RarityLevel == 3 then
						table.insert( purchasedItems, itemData )
					end
				else
					table.insert( availableItems, itemData )
				end
			end
		end
	end

	local purchasedItemsToShow = {}
	for i, item in ipairs( purchasedItems ) do
		purchasedItemsToShow[item.ShowLastInGroup or item.Name] = item
	end
	purchasedItems = {}
	for i, itemName in ipairs( screen.ItemOrder ) do
		if purchasedItemsToShow[itemName] ~= nil then
			table.insert( purchasedItems, purchasedItemsToShow[itemName] )
		end
	end

	screen.NumItems = 0

	local firstUseable = false
	screen.ItemButtons = {}

	-- Available
	if not screen.ReadOnly then
		for i, item in ipairs( availableItems ) do

			screen.NumItems = screen.NumItems + 1

			screen.OfferedVoiceLines = screen.OfferedVoiceLines or item.OfferedVoiceLines

			local purchaseButtonKey = "PurchaseButton"..screen.NumItems
			components[purchaseButtonKey] = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = "Combat_Menu", X = itemLocationX, Y = itemLocationY, Animation = screen.ItemAvailableAnimation })
			SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
			local button = components[purchaseButtonKey]
			button.Animation = screen.ItemAvailableAnimation
			button.HighlightAnimation = screen.ItemAvailableHighlightAnimation
			screen.ItemButtons[button.Id] = button
			AttachLua({ Id = button.Id, Table = button })
			button.Screen = screen

			if item.Icon ~= nil then
				local iconKey = "Icon"..screen.NumItems
				components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Scale = item. IconScale or 0.5, Group = "Combat_Menu" })
				SetAnimation({ DestinationId = components[iconKey].Id , Name = item.Icon })
			end

			local tooltipData = item
			local displayName = item.Name
			local traitName = item.IncreaseTraitLevel
			if TraitData[traitName] ~= nil then
				local traitStacks = GetFamiliarTraitStacks( traitName )
				local oldTraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, StackNum = traitStacks })
				local newTraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, StackNum = traitStacks + 1 })
				SetTraitTextData( oldTraitData )
				SetTraitTextData( newTraitData )
				button.TraitData = { Old = oldTraitData, New = newTraitData, ExtractData = oldTraitData.ExtractData } -- ExtractData is used for tooltips, where we want to display the old/current value
				tooltipData = button.TraitData
			end
			if item.RarityLevel ~= nil then
				tooltipData.UpgradeName = displayName
				tooltipData.AspectRarityText = TraitRarityData.AspectRarityText[item.RarityLevel]
				displayName = "FamiliarShopUpgrade"
			end

			local itemNameFormat = ShallowCopyTable( screen.ItemAvailableNameFormat )
			itemNameFormat.Id = button.Id
			itemNameFormat.Text = displayName
			itemNameFormat.LuaKey = "TooltipData"
			itemNameFormat.LuaValue = tooltipData
			CreateTextBox( itemNameFormat )

			-- Hidden description for tooltip
			CreateTextBox({ Id = button.Id,
				Text = item.Name.."_Upgrade",
				UseDescription = true,
				Color = Color.Transparent,
				LuaKey = "TooltipData",
				LuaValue = tooltipData,
			})
			SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
			SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY + ScreenCenterNativeOffsetY })

			button.OnMouseOverFunctionName = "MouseOverFamiliarShopItem"
			button.OnMouseOffFunctionName = "MouseOffFamiliarShopItem"
			if not screen.ReadOnly then
				button.OnPressedFunctionName = "HandleFamiliarShopPurchase"
			end
			if not firstUseable then
				TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
				firstUseable = true
			end

			button.Data = item
			button.Index = screen.NumItems
			button.DisplayName = name
		
			-- New icon
			if not GameState.WorldUpgradesViewed[item.Name] then
				local newButtonKey = "NewIcon"..screen.NumItems
				components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
				SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "MusicPlayerNewTrack" }) --nopkg
				Attach({ Id = components[newButtonKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 300, OffsetY = 0 })
				components[purchaseButtonKey].NewButtonId = components[newButtonKey].Id
			end

			itemLocationY = itemLocationY + screen.ItemSpacingY

		end
	end

	-- Purchased
	for i, item in ipairs( purchasedItems ) do

		screen.NumItems = screen.NumItems + 1
		
		local purchaseButtonKey = "PurchaseButton"..screen.NumItems
		components[purchaseButtonKey] = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = "Combat_Menu", X = itemLocationX, Y = itemLocationY, Animation = screen.ItemPurchasedAnimation })
		SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
		local button = components[purchaseButtonKey]
		button.Animation = screen.ItemPurchasedAnimation
		button.HighlightAnimation = screen.ItemPurchasedHighlightAnimation
		screen.ItemButtons[button.Id] = button
		AttachLua({ Id = button.Id, Table = button })
		button.Screen = screen
		
		if item.Icon ~= nil then
			local iconKey = "Icon"..screen.NumItems
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Scale = item.IconScale or screen.IconScale, Group = screen.ComponentData.DefaultGroup })
			SetAnimation({ DestinationId = components[iconKey].Id , Name = item.Icon })
		end

		local tooltipData = item
		local displayName = item.Name
		local traitName = item.IncreaseTraitLevel
		if TraitData[traitName] ~= nil then
			local traitStacks = GetFamiliarTraitStacks( traitName )
			button.TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, StackNum = traitStacks })
			SetTraitTextData( button.TraitData )
			tooltipData = button.TraitData
		end
		if item.RarityLevel ~= nil then
			tooltipData.UpgradeName = displayName
			tooltipData.AspectRarityText = TraitRarityData.AspectRarityText[item.RarityLevel]
			displayName = "FamiliarShopUpgrade"
		end

		local itemNameFormat = ShallowCopyTable( screen.ItemPurchasedNameFormat )
		itemNameFormat.Id = button.Id
		itemNameFormat.Text = displayName
		itemNameFormat.LuaKey = "TooltipData"
		itemNameFormat.LuaValue = tooltipData
		CreateTextBox( itemNameFormat )

		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = item.Name,
			UseDescription = true,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = tooltipData,
		})
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY + ScreenCenterNativeOffsetY })

		button.OnMouseOverFunctionName = "MouseOverFamiliarShopItem"
		button.OnMouseOffFunctionName = "MouseOffFamiliarShopItem"

		if not firstUseable then
			TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
			firstUseable = true
		end

		button.Data = item
		button.Index = screen.NumItems
		button.DisplayName = displayName
		button.Purchased = true

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

end

function OpenFamiliarShopScreen( openedFrom, args )

	args = args or {}

	AltAspectRatioFramesShow()

	local screen = DeepCopyTable( ScreenData.FamiliarShop )
	screen.OpenedFrom = openedFrom
	screen.ReadOnly = args.ReadOnly

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	if IsScreenOpen( screen.Name ) then
		return
	end

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	if args.ReadOnly then
		GameState.WorldUpgradesViewed.FamiliarUpgradeScreen = true
	else
		thread( MarkObjectiveComplete, "FamiliarUpgradePrompt" )
	end
	
	local components = screen.Components

	screen.NumCategories = 0

	if screen.ReadOnly then
		SetAlpha({ Id = components.CloseButton.Id, Fraction = 1, Duration = 0.2 })
		UseableOn({ Id = components.CloseButton.Id })
	else
		components.CloseButton.OnPressedFunctionName = nil
	end

	SetAnimation({ DestinationId = components.FamiliarShopAnimalBacking.Id, Name = openedFrom.FamiliarShopGraphic })

	FamiliarShopScreenOpenedPresentation( screen, args )

	local components = screen.Components

	wait( 0.3 )

	FamiliarShopScreenDisplayCategory( screen )
	FamiliarShopUpdateVisibility( screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen

end

function CloseFamiliarShopScreen( screen, button, args )
	args = args or {}
	for id, itemButton in pairs( screen.ItemButtons ) do
		UseableOff({ Id = id })
	end
	FamiliarShopScreenCloseStartPresentation( screen )
	AltAspectRatioFramesHide()
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), nil, screen, args )
	OnScreenCloseFinished( screen )
	if not args.HideCombatUI then
		ShowCombatUI( screen.Name )
	end
	FamiliarShopScreenCloseFinishedPresentation( screen )
	if screen.ReadOnly then
		ShowTraitTrayScreen( { AutoPin = false } )
	end
end

function HandleFamiliarShopPurchase( screen, button )
	local upgradeData = button.Data

	if not IsEmpty( upgradeData.Cost ) ~= nil and upgradeData.PurchaseRequirements ~= nil and not IsGameStateEligible( upgradeData.PurchaseRequirements ) then
		CantPurchasePresentation( screen.Components["PurchaseButton".. button.Index] )
		return
	end

	FamiliarShopItemPurchasedPresentation( button, upgradeData )

	GameState.FamiliarUpgrades[upgradeData.Name] = true
	AddWorldUpgrade( upgradeData.Name )
	CallFunctionName( upgradeData.OnPurchasedFunctionName, upgradeData.OnPurchasedFunctionArgs )

	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = button.Id })

	Destroy({ Id = button.Id })
	screen.Components["PurchaseButton".. button.Index] = nil

	if screen.Components["Icon".. button.Index] ~= nil then
		Destroy({ Id = screen.Components["Icon".. button.Index].Id })
		screen.Components["Icon".. button.Index] = nil
	end

	-- close screen
	CloseFamiliarShopScreen( screen, button, { HideCombatUI = true, FadeOutTime = screen.OnPurchasedFadeOutTime } )

	thread( DoFamiliarShopPurchase, screen, button )
end

function DoFamiliarShopPurchase( screen, button )
	local itemData = button.Data
	FamiliarShopPurchasePreActivatePresentation( screen, button, itemData )
	ActivateConditionalItem( itemData )
	FamiliarShopPurchasePostActivatePresentation( screen, button, itemData )
	UpdateAffordabilityStatus()
	UpdateFamiliarKits( { DoEquip = true } )
	ShowCombatUI( screen.Name )
	if itemData.FamiliarName == GameState.EquippedFamiliar then
		CheckObjectiveSet( "CheckFamiliarUpgradeInfoPrompt" )
	end
	CheckAchievement( screen, { Name = "AchAllFamiliarsMax" } )
end

function FamiliarShopUpdateVisibility( screen )

	local components = screen.Components
	local offIds = {}
	local onIds = {}
	for index = 1, screen.NumItems do
		local questButtonKey = (screen.ButtonName or "PurchaseButton")..index
		local purchaseButtonTitleKey = "PurchaseButtonTitle"..index
		local newButtonKey = "NewIcon"..index
		local iconKey = "Icon"..index

		local visibleIndex = index - screen.ScrollOffset

		if visibleIndex >= 1 and visibleIndex <= screen.ItemsPerPage then
			-- Page in view
			Teleport({ Id = components[questButtonKey].Id, OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((visibleIndex - 1) * screen.ItemSpacingY) })
			table.insert( onIds, components[questButtonKey].Id )
			if components[purchaseButtonTitleKey] ~= nil then
				Teleport({ Id = components[purchaseButtonTitleKey].Id, OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((visibleIndex - 1) * screen.ItemSpacingY) })
				table.insert( onIds, components[purchaseButtonTitleKey].Id )
			end
			if components[iconKey] ~= nil then
				Teleport({ Id = components[iconKey].Id, OffsetX = screen.ItemStartX + screen.IconOffsetX, OffsetY = screen.ItemStartY + screen.IconOffsetY + ((visibleIndex - 1) * screen.ItemSpacingY) })
				table.insert( onIds, components[iconKey].Id )
			end
			if components[newButtonKey] ~= nil and not GameState.WorldUpgradesViewed[components[questButtonKey].Data.Name] then
				Teleport({ Id = components[newButtonKey].Id, OffsetX = screen.ItemStartX + screen.IconOffsetX, OffsetY = screen.ItemStartY + screen.IconOffsetY + ((visibleIndex - 1) * screen.ItemSpacingY) })
				table.insert( onIds, components[newButtonKey].Id )
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
			if components[purchaseButtonTitleKey] ~= nil then
				table.insert( offIds, components[purchaseButtonTitleKey].Id )
			end
			if components[iconKey] ~= nil then
				table.insert( offIds, components[iconKey].Id )
			end
			if components[newButtonKey] ~= nil then
				table.insert( offIds, components[newButtonKey].Id )
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

	SetAlpha({ Ids = onIds, Fraction = 1 })
	UseableOn({ Ids = onIds })

	SetAlpha({ Ids = offIds, Fraction = 0 })
	UseableOff({ Ids = offIds, ForceHighlightOff = true })

	if components.ScrollUp ~= nil then
		if screen.ScrollOffset <= 0 then
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
		else
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollUp.Id })
		end
	end

	if components.ScrollDown ~= nil then
		if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
		else
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollDown.Id })
		end
	end

end

function AnyFamiliarUpgradesAvailable( source, args )
	for upgradeName, upgradeData in pairs( FamiliarShopItemData ) do
		if GameState.FamiliarsUnlocked[upgradeData.FamiliarName] and GameState.FamiliarUpgrades[upgradeName] == nil then
			if not upgradeData.DebugOnly and ( upgradeData.GameStateRequirements == nil or IsGameStateEligible( upgradeData, upgradeData.GameStateRequirements ) ) then
				return true
			end
		end
	end
	return false
end

function GetFamiliarTraitStacks( traitName )
	local traitStacks = 1
	for upgradeName, upgradeData in pairs( FamiliarShopItemData ) do
		if not upgradeData.DebugOnly and GameState.FamiliarUpgrades[upgradeName] and upgradeData.IncreaseTraitLevel == traitName then
			traitStacks = traitStacks + 1
		end
	end
	return traitStacks
end
