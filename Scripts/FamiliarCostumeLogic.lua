function GiftFamiliarCostume( usee, args )

	AddInputBlock({ Name = "GiftFamiliarCostume" })

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )

	RemoveInputBlock({ Name = "GiftFamiliarCostume" })
	
	local screen = OpenFamiliarCostumeScreen( usee )
	UseableOn({ Id = usee.ObjectId })

end

function OpenFamiliarCostumeScreen( openedFrom, args )

	args = args or {}

	AltAspectRatioFramesShow()

	local screen = DeepCopyTable( ScreenData.FamiliarCostumeShop )
	screen.OpenedFrom = openedFrom

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY
	screen.CostDisplay.StartX = screen.CostDisplay.StartX + ScreenCenterNativeOffsetX
	screen.CostDisplay.StartY = screen.CostDisplay.StartY + ScreenCenterNativeOffsetY

	if IsScreenOpen( screen.Name ) then
		return
	end

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	
	local components = screen.Components

	SetAnimation({ DestinationId = components.FamiliarShopAnimalBacking.Id, Name = openedFrom.FamiliarShopGraphic })

	FamiliarCostumeScreenOpenedPresentation( screen, args )

	wait( 0.1 )

	FamiliarCostumeShopUpdateVisibility( screen, { PlaySequentialFade = true } )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen

end

function CloseFamiliarCostumeScreen( screen, button, args )
	args = args or {}
	UseableOff({ Ids = screen.ButtonIds })
	FamiliarCostumeScreenCloseStartPresentation( screen )
	AltAspectRatioFramesHide()
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), nil, screen )
	OnScreenCloseFinished( screen )
	FamiliarCostumeScreenCloseFinishedPresentation( screen, args )
	if not args.Purchasing then
		ShowCombatUI( screen.Name )
	end
	CheckAchievement( screen, { Name = "AchFamiliarCostumes" } )
end

function FamiliarCostumeShopUpdateVisibility( screen, args )
	args = args or {}
	local components = screen.Components

	screen.ButtonIds = {}

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY
	for index, itemName in ipairs( screen.ItemCategories[screen.OpenedFrom.Name] ) do

		local itemData = WorldUpgradeData[itemName]
		local purchased = GameState.WorldUpgrades[itemName]

		local button = CreateScreenComponent({
			Name = "GhostAdminItem",
			Group = screen.ComponentData.DefaultGroup,
			X = itemLocationX,
			Y = itemLocationY,
			Alpha = 0.0,
		})
		components[itemName.."Button"] = button
		button.AssociatedIds = {}
		button.Screen = screen
		button.OnMouseOverFunctionName = "MouseOverFamiliarCostumeItem"
		button.OnMouseOffFunctionName = "MouseOffFamiliarCostumeItem"
		if not purchased then
			button.OnPressedFunctionName = "HandleFamiliarCostumeShopPurchase"
		end
		button.NeutralAnimation = screen.ItemAvailableAnimation
		button.MouseOverAnimation = screen.ItemAvailableMouseOverAnimation
		button.MouseOffAnimation = screen.ItemAvailableMouseOffAnimation
		button.Data = itemData
		button.Purchased = purchased
		AttachLua({ Id = button.Id, Table = button })
		SetAnimation({ DestinationId = button.Id, Name = button.NeutralAnimation })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY + ScreenCenterNativeOffsetY })
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })

		local icon = CreateScreenComponent({
			Name = "BlankObstacle",
			X = itemLocationX + screen.IconOffsetX,
			Y = itemLocationY,
			Scale = screen.IconScale,
			Group = screen.ComponentData.DefaultGroup,
			Animation = itemData.Icon,
			Alpha = 0.0,
		})
		table.insert( button.AssociatedIds, icon.Id )
		components[itemName.."Icon"] = icon

		local formatName = nil
		if purchased then
			formatName = "ItemPurchasedNameFormat"
		elseif HasResources( itemData.Cost ) then
			formatName = "ItemAvailableAffordableNameFormat"
		else
			formatName = "ItemAvailableUnaffordableNameFormat"
		end
		CreateTextBoxWithScreenFormat( screen, button, formatName, { Text = itemName } )

		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = itemName,
			UseDescription = true,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = itemData,
		})

		if purchased then
			local stateIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX, Y = itemLocationY })
			table.insert( button.AssociatedIds, stateIcon.Id )
			components[itemName.."StateIcon"] = stateIcon

			local stateText = "Shop_Purchased"
			if GameState.FamiliarCostumes[screen.OpenedFrom.Name] ~= itemName then
				button.Free = true
				button.OnPressedFunctionName = "HandleFamiliarCostumeShopReAdd"
				stateText = "Shop_ReAdd"
			end

			local itemStateFormat = ShallowCopyTable( screen.ItemStateFormat )
			itemStateFormat.Id = stateIcon.Id
			itemStateFormat.Text = stateText
			CreateTextBox( itemStateFormat )
		else
			local pinIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Alpha = 0.0, })
			components[itemName.."PinIcon"] = pinIcon
			table.insert( button.AssociatedIds, pinIcon.Id )
			Attach({ Id = pinIcon.Id, DestinationId = button.Id, OffsetX = screen.PinOffsetX, OffsetY = UIData.PinIconListOffsetY })
			button.PinButtonId = pinIcon.Id
			if HasStoreItemPin( itemName ) then
				button.IsPinned = true
				SetAnimation({ Name = "StoreItemPin", DestinationId = pinIcon.Id })
				-- Silent toolip
				CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
			end

			if not GameState.WorldUpgradesViewed[itemName] then
				local newIcon = CreateScreenComponent({
					Name = "BlankObstacle",
					Group = screen.ComponentData.DefaultGroup,
					Animation = "MusicPlayerNewTrack",
					Alpha = 0.0,
				})
				components[itemName.."NewIcon"] = newIcon
				table.insert( button.AssociatedIds, newIcon.Id )
				Attach({ Id = newIcon.Id, DestinationId = button.Id, OffsetX = 300, OffsetY = 0 })
				button.NewIconId = newIcon.Id
			end
		end

		SetAlpha({ Id = button.Id, Fraction = 1.0, Duration = 0.1 })
		SetAlpha({ Ids = button.AssociatedIds, Fraction = 1.0, Duration = 0.1 })
		if args.PlaySequentialFade then
			wait( 0.05 )
		end

		if index == 1 then
			screen.CursorStartX = itemLocationX
			screen.CursorStartY = itemLocationY
		end

		table.insert( screen.ButtonIds, button.Id )
		screen.ButtonIds = CombineTables( screen.ButtonIds, button.AssociatedIds )

		itemLocationY = itemLocationY + screen.ItemSpacingY
	end

end

function HandleFamiliarCostumeShopPurchase( screen, button, args )
	args = args or {}

	local upgradeData = button.Data

	if not button.Free and not HasResources( upgradeData.Cost ) then
		ScreenCantAffordPresentation( screen, button )
		return
	end

	FamiliarCostumeItemPurchasedPresentation( button, upgradeData )

	AddWorldUpgrade( upgradeData.Name )
	RemoveStoreItemPin( upgradeData.Name, { Purchase = true } )

	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = button.Id, OffsetX = 0 })

	CloseFamiliarCostumeScreen( screen, button, { Purchasing = true } )

	thread( DoFamiliarCostumeShopPurchase, screen, button, args )
end

function HandleFamiliarCostumeShopReAdd( screen, button )
	HandleFamiliarCostumeShopPurchase( screen, button, { ReAdd = true } )
end

function DoFamiliarCostumeShopPurchase( screen, button, args )
	args = args or {}
	local itemData = button.Data
	GameState.FamiliarCostumes[screen.OpenedFrom.Name] = itemData.Name
	if args.ReAdd then
		FamiliarCostumeReAddPresentation( screen, button, itemData )
	else
		FamiliarCostumePurchasePresentation( screen, button, itemData )
	end
	UpdateAffordabilityStatus()
	ShowCombatUI( screen.Name )
end

function SetupFamiliarCostume( familiar, args )
	args = args or {}
	local currentCostume = GameState.FamiliarCostumes[familiar.Name]
	if currentCostume ~= nil then
		local costumeData = WorldUpgradeData[currentCostume]
		SetThingProperty({ DestinationId = familiar.ObjectId, Property = "GrannyModel", Value = costumeData.GrannyModel })
		if costumeData.Outline ~= nil then
			local outlineData = ShallowCopyTable( costumeData.Outline )
			outlineData.Id = familiar.ObjectId
			AddOutline( outlineData )
			familiar.HasOutline = true
		elseif familiar.HasOutline then
			RemoveOutline({ Id = familiar.ObjectId })
			familiar.HasOutline = nil
		end
		SetAnimation({ DestinationId = familiar.ObjectId, Name = args.Animation or familiar.IdleAnimation })
	end
end