function UseCosmeticsShop( usee, args )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	thread( MarkObjectiveComplete, "DoraDecorationIntroPrompt" )
	local screen = OpenCosmeticsShopScreen( usee, { DefaultCategoryIndex = usee.DefaultCategoryIndex } )
	UseableOn({ Id = usee.ObjectId })
	GhostAdminSessionCompletePresentation( usee, screen )
end

function OpenCosmeticsShopScreen( openedFrom, args )

	args = args or {}

	AltAspectRatioFramesShow()

	AddInputBlock({ Name = "OpenCosmeticsScreen" })
	local screen = DeepCopyTable( ScreenData.CosmeticsShop )
	screen.OpenedFrom = openedFrom
	screen.ActiveCategoryIndex = args.DefaultCategoryIndex or CurrentHubRoom.CosmeticsCategoryIndex or 1

	if IsScreenOpen( screen.Name ) then
		return
	end

	local categoryName = screen.ItemCategories[screen.ActiveCategoryIndex].Name
	CurrentRun.ScreenViewRecord[categoryName] = (CurrentRun.ScreenViewRecord[categoryName] or 0) + 1

	if not args.SkipSalute then
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = openedFrom.ObjectId })
		SetAnimation({ Name = "MelinoeSaluteToBrooding", DestinationId = CurrentRun.Hero.ObjectId })
		if CurrentRun.ScreenViewRecord[categoryName] <= 1 then
			thread( PlayVoiceLines, screen.CosmeticsOpenVoiceLines, true )
		else
			if CheckCooldown( "CanCosmeticSaluteDora", 25 ) then
				thread( PlayVoiceLines, openedFrom.InteractVoiceLines or GlobalVoiceLines.SaluteVoiceLines, true, openedFrom )
			end
		end
	else
		SetAnimation({ Name = "MelTalkBrooding01", DestinationId = CurrentRun.Hero.ObjectId })
	end

	ZeroMouseTether( screen.Name )
	LockCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 0.7, EaseIn = 0, EaseOut = 1.0 })
	HideCombatUI( screen.Name )
	if not args.SkipSalute then
		wait( 0.55 )
	end

	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY
	screen.CostDisplay.StartX = screen.CostDisplay.StartX + ScreenCenterNativeOffsetX
	screen.CostDisplay.StartY = screen.CostDisplay.StartY + ScreenCenterNativeOffsetY

	CosmeticShopDisplayCategory( screen, screen.ActiveCategoryIndex )
	GhostAdminUpdateVisibility( screen )

	UpdateGhostAdminInteractionText( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "OpenCosmeticsScreen" })

	thread( GenericScreenOpenEndPresentation, screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen

end

function CosmeticShopDisplayCategory( screen, categoryIndex )

	local components = screen.Components

	screen.ActiveCategoryIndex = categoryIndex

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	screen.AvailableItems = {}
	screen.PurchasedItems = {}

	CurrentRun.ViewableWorldUpgrades = CurrentRun.ViewableWorldUpgrades or {}
	for i, cosmeticName in ipairs( screen.ItemCategories[categoryIndex] ) do
		local cosmeticData = WorldUpgradeData[cosmeticName]
		if CosmeticShopAllowViewItem( screen, screen.ItemCategories[categoryIndex], cosmeticData ) then
			if not cosmeticData.RotateOnly or ContainsAnyKey( GameState.WorldUpgradesAdded, cosmeticData.RemoveCosmetics ) then
				CurrentRun.ViewableWorldUpgrades[cosmeticName] = true
				if GameState.WorldUpgradesAdded[cosmeticName] then
					table.insert( screen.PurchasedItems, cosmeticData )
				else
					table.insert( screen.AvailableItems, cosmeticData )
				end
			end
		end
	end

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
		components[purchaseButtonKey] = CreateScreenComponent({ Name = "BlankInteractableObstacle",
			Group = screen.ComponentData.DefaultGroup,
			X = itemLocationX,
			Y = itemLocationY,
			Animation = screen.ItemAvailableAnimation,
			Alpha = 0.0
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
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle",
				X = itemLocationX + screen.IconOffsetX,
				Y = itemLocationY,
				Scale = screen.IconScale,
				Group = screen.ComponentData.DefaultGroup,
				Animation = cosmetic.Icon,
				Alpha = 0.0,
			})
		end

		local displayName = cosmetic.Name
		local format = screen.ItemAvailableAffordableNameFormat
		if not HasResources( cosmetic.Cost ) then
			format = screen.ItemAvailableUnaffordableNameFormat
		end

		local itemNameFormat = ShallowCopyTable( format )
		itemNameFormat.Id = button.Id
		itemNameFormat.Text = displayName
		CreateTextBox( itemNameFormat )

		button.OnMouseOverFunctionName = "MouseOverGhostAdminItem"
		button.OnMouseOffFunctionName = "MouseOffGhostAdminItem"
		button.OnPressedFunctionName = "HandleCosmeticShopPurchase"
		if not firstUseable then
			screen.CursorStartX = itemLocationX
			screen.CursorStartY = itemLocationY
			firstUseable = true
		end

		button.Data = cosmetic
		button.Index = screen.NumItems
		button.DisplayName = displayName

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
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })

		-- Pin icon
		local pinButtonKey = "PinIcon"..screen.NumItems
		components[pinButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Alpha = 0.0, })
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
			components[newIconKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Alpha = 0.0, Animation = "MusicPlayerNewTrack" })
			Attach({ Id = components[newIconKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 300, OffsetY = 0 })
			components[purchaseButtonKey].NewButtonId = components[newIconKey].Id
		end

		GameState.WorldUpgradesRevealed[cosmetic.Name] = true

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	-- Purchased
	for k, cosmetic in ipairs( screen.PurchasedItems ) do

		screen.NumItems = screen.NumItems + 1

		local purchaseButtonKey = "PurchaseButton"..screen.NumItems
		components[purchaseButtonKey] = CreateScreenComponent({ Name = "BlankInteractableObstacle",
			Group = screen.ComponentData.DefaultGroup,
			X = itemLocationX,
			Y = itemLocationY,
			Animation = screen.ItemAvailableAnimation,
			Alpha = 0.0
		})
		SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
		local button = components[purchaseButtonKey]
		button.Animation = screen.ItemAvailableAnimation
		button.HighlightAnimation = screen.ItemAvailableHighlightAnimation
		AttachLua({ Id = button.Id, Table = button })
		button.Screen = screen
		button.InfoBoxName = components.InfoBoxName
		button.InfoBoxDescription = components.InfoBoxDescription
		button.InfoBoxFlavor = components.InfoBoxFlavor
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })

		if cosmetic.Icon ~= nil then
			local iconKey = "Icon"..screen.NumItems
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle",
				X = itemLocationX + screen.IconOffsetX,
				Y = itemLocationY,
				Scale = screen.IconScale,
				Group = "Combat_Menu",
				Animation = cosmetic.Icon,
				Alpha = 0.0,
			})
		end

		local itemNameFormat = ShallowCopyTable( screen.ItemPurchasedNameFormat )
		itemNameFormat.Id = button.Id
		itemNameFormat.Text = cosmetic.Name
		CreateTextBox( itemNameFormat )

		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = cosmetic.Name,
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
		button.DisplayName = cosmetic.Name
		button.Purchased = true

		-- State
		local purchaseButtonStateKey = "PurchaseButtonState"..screen.NumItems
		components[purchaseButtonStateKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX, Y = itemLocationY })

		local stateText = "Shop_Purchased"
		if cosmetic.Removable then
			if GameState.WorldUpgrades[cosmetic.Name] then
				if not cosmetic.RotateOnly then
					components[purchaseButtonKey].OnPressedFunctionName = "HandleCosmeticShopRemoval"
					stateText = "Shop_Removable"
				end
			else
				components[purchaseButtonKey].Free = true
				components[purchaseButtonKey].OnPressedFunctionName = "HandleCosmeticShopReAdd"
				stateText = "Shop_ReAdd"
			end
		end

		local itemStateFormat = ShallowCopyTable( screen.ItemStateFormat )
		itemStateFormat.Id = components[purchaseButtonStateKey].Id
		itemStateFormat.Text = stateText
		CreateTextBox( itemStateFormat )

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	SetAlpha({ Ids = { components.Scrollbar.Id, components.ScrollbarSlider.Id }, Fraction = 1.0, Duration = 0.1 })

end

function HandleCosmeticShopPurchase( screen, button, args )
	args = args or {}

	local upgradeData = button.Data

	if not button.Free and not HasResources( upgradeData.Cost ) then
		ScreenCantAffordPresentation( screen, button )
		return
	end

	if not IsEmpty( upgradeData.Cost ) ~= nil and upgradeData.PurchaseRequirements ~= nil and not IsGameStateEligible( upgradeData.PurchaseRequirements ) then
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
			if GameState.WorldUpgrades[name] then
				args.RemoveCosmeticName = name
			end
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

	thread( DoCosmeticShopPurchase, screen, button, args )
end

function DoCosmeticShopPurchase( screen, button, args )
	local itemData = button.Data
	PreActivateCosmeticPresentation( screen, button, itemData, args )
	CallFunctionName( itemData.OnActivateFunctionName, itemData.OnActivateFunctionArgs )
	ActivateConditionalItem( itemData, args )
	PostActivateCosmeticPresentation( button, itemData, args )
	CallFunctionName( itemData.OnActivateFinishedFunctionName, itemData.OnActivateFinishedFunctionArgs )
	UpdateAffordabilityStatus()
	OpenCosmeticsShopScreen( screen.OpenedFrom, { DefaultCategoryIndex = screen.ActiveCategoryIndex, SkipSalute = true } )
end

function HandleCosmeticShopReAdd( screen, button )
	HandleCosmeticShopPurchase( screen, button, { ReAdd = true } )
end

function HandleCosmeticShopRemoval( screen, button )
	local itemData = button.Data
	
	GameState.WorldUpgrades[itemData.Name] = nil

	Destroy({ Id = screen.Components["PurchaseButtonState".. button.Index].Id })
	screen.Components["PurchaseButtonState".. button.Index] = nil

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
	OpenCosmeticsShopScreen( screen.OpenedFrom, { DefaultCategoryIndex = screen.ActiveCategoryIndex, SkipSalute = true } )
end

function AnyCosmeticActiveInFamily( itemData )
	if GameState.WorldUpgrades[itemData.Name] then
		return true
	end
	if itemData.RemoveCosmetics ~= nil then
		for _, name in ipairs( itemData.RemoveCosmetics ) do
			if GameState.WorldUpgrades[name] then
				return true
			end
		end
	end
	return false
end

function ActivateConditionalItems( eventSource, args )

	args = args or {}

	if args.CosmeticsShopCategoryIndex ~= nil then
		local itemNames = ScreenData.CosmeticsShop.ItemCategories[args.CosmeticsShopCategoryIndex]
		for i, itemName in ipairs( itemNames ) do
			local itemData = WorldUpgradeData[itemName]
			if itemData ~= nil then
				if ( GameState.WorldUpgrades[itemName] and not itemData.Disabled ) or ( GetConfigOptionValue({ Name = "EditingMode" }) and not AnyCosmeticActiveInFamily( itemData ) ) then
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
	if args.RemoveCosmeticName ~= nil then
		DeactivateConditionalItem( WorldUpgradeData[args.RemoveCosmeticName], { ForceDeactivate = true } )
	end
	if itemData.ActivateIds ~= nil then
		Activate({ Ids = itemData.ActivateIds })
		SetAlpha({ Ids = itemData.ActivateIds, Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = itemData.ActivateIds })
			SetThingProperty({ Property = "StopsLight", Value = true, DestinationIds = itemData.ActivateIds })
		end
	end
	if itemData.DeactivateIds ~= nil and not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = itemData.DeactivateIds, Fraction = 0 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = itemData.DeactivateIds })
			SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = itemData.DeactivateIds })
		end
	end
	if itemData.ActivateGroups ~= nil then
		Activate({ Names = itemData.ActivateGroups })
		SetAlpha({ Ids = GetIds({ Names = itemData.ActivateGroups }), Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = true, DestinationNames = itemData.ActivateGroups })
			SetThingProperty({ Property = "StopsLight", Value = true, DestinationNames = itemData.ActivateGroups })
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
	if itemData.SetAnimationIds ~= nil then
		for _, id in ipairs( itemData.SetAnimationIds ) do
			SetAnimation({ DestinationId = id, Name = itemData.SetAnimationValue })
		end
	end
	if itemData.ActivatedData ~= nil then
		local obstacle = DeepCopyTable( itemData.ActivatedData )
		obstacle.ObjectId = obstacle.ObjectId or GetCosmeticFocusId( itemData )
		obstacle.Name = itemData.Name
		for i, trigger in ipairs( obstacle.DistanceTriggers ) do
			trigger.NotifyName = trigger.NotifyName or "Notify_"..itemData.Name..i
		end
		SetupObstacle( obstacle )
		UseableOn({ Id = obstacle.ObjectId })
	end
	if itemData.ActivateFunctionName ~= nil then
		CallFunctionName( itemData.ActivateFunctionName, itemData )
	end
end

function DeactivateConditionalItem( itemData, args )
	if itemData == nil then
		return
	end

	-- Off
	args = args or {}
	if itemData.RemoveCosmetics == nil or not ContainsAnyKey( GameState.WorldUpgrades, itemData.RemoveCosmetics ) or args.ForceDeactivate then
		if itemData.ActivateIds ~= nil then
			SetAlpha({ Ids = itemData.ActivateIds, Fraction = 0 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = itemData.ActivateIds })
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = itemData.ActivateIds })
			end
		end
		if itemData.ActivateGroups ~= nil then
			SetAlpha({ Ids = GetIds({ Names = itemData.ActivateGroups }), Fraction = 0 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationNames = itemData.ActivateGroups })
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationNames = itemData.ActivateGroups })
			end
		end
		if itemData.DeactivateIds ~= nil then
			SetAlpha({ Ids = itemData.DeactivateIds, Fraction = 1 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = itemData.DeactivateIds })
				SetThingProperty({ Property = "StopsLight", Value = true, DestinationIds = itemData.DeactivateIds })
			end
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
		if itemData.ActivatedData ~= nil then
			local obstacleId = itemData.ActivatedData.ObjectId or GetCosmeticFocusId( itemData )
			UseableOff({ Id = obstacleId })
			for i, trigger in ipairs( itemData.ActivatedData.DistanceTriggers ) do
				killWaitUntilThreads( trigger.NotifyName or "Notify_"..itemData.Name..i )
			end
		end
		if itemData.DeactivateFunctionName ~= nil then
			CallFunctionName( itemData.DeactivateFunctionName, itemData )
		end
	end
end

function HasNewCosmeticsAvailable( source, args )
	args = args or {}

	local categoryIndex = args.CategoryIndex
	if categoryIndex == nil and ActiveScreens.CosmeticsShop ~= nil then
		categoryIndex = ActiveScreens.CosmeticsShop.ActiveCategoryIndex
	end

	if categoryIndex ~= nil then
		for k, itemName in ipairs( ScreenData.CosmeticsShop.ItemCategories[categoryIndex] ) do
			local itemData = WorldUpgradeData[itemName]
			if itemData ~= nil and not GameState.WorldUpgradesRevealed[itemName] and ( itemData.GameStateRequirements == nil or IsGameStateEligible( itemData, itemData.GameStateRequirements ) ) then
				return true
			end
		end
	end

	return false
end

function CosmeticShopAllowViewItem( screen, category, cosmeticData )
	if CurrentRun.ViewableWorldUpgrades[cosmeticData.Name] then
		return true
	end

	local viewRecord = CurrentRun.ScreenViewRecord[category.Name] or 0
	if not cosmeticData.AlwaysRevealImmediately and (viewRecord > 1 or (viewRecord == 1 and not IsScreenOpen( screen.Name ))) then
		return false
	end

	if cosmeticData.GameStateRequirements ~= nil and not IsGameStateEligible( cosmeticData, cosmeticData.GameStateRequirements ) then
		return false
	end

	return true
end

function HasUnpurchasedCosmetics( source, args )
	args = args or {}

	local categoryIndex = args.CategoryIndex
	if categoryIndex == nil and ActiveScreens.CosmeticsShop ~= nil then
		categoryIndex = ActiveScreens.CosmeticsShop.ActiveCategoryIndex
	end

	if categoryIndex ~= nil then
		for k, itemName in ipairs( ScreenData.CosmeticsShop.ItemCategories[categoryIndex] ) do
			local itemData = WorldUpgradeData[itemName]
			if itemData ~= nil and not GameState.WorldUpgrades[itemName] and ( itemData.GameStateRequirements == nil or IsGameStateEligible( itemData, itemData.GameStateRequirements ) ) then
				return true
			end
		end
	end

	return false
end

function ShowAmbientCritters( cosmeticData )
	local critterType = cosmeticData.Name
	HideAmbientCritters( cosmeticData ) -- hide all critters by default

	CurrentRun.AmbientCritterVisibleGroups = CurrentRun.AmbientCritterVisibleGroups or {}
	if CurrentRun.AmbientCritterVisibleGroups[critterType] == nil then
		CurrentRun.AmbientCritterVisibleGroups[critterType] = {}
		local eligibleOptions = {}
		for groupName, groupData in pairs( cosmeticData.CritterGroups ) do
			if groupData.GameStateRequirements == nil or IsGameStateEligible( groupData, groupData.GameStateRequirements ) then
				table.insert( eligibleOptions, groupName )
			end
		end

		-- TODO: Eventually this should pick a random subset of animals, but for now let's show them all...
		for i, groupName in ipairs( eligibleOptions ) do
			table.insert( CurrentRun.AmbientCritterVisibleGroups[critterType], groupName )
		end
	end

	for i, groupName in ipairs( CurrentRun.AmbientCritterVisibleGroups[critterType] ) do
		local ids = GetIds({ Name = groupName })
		SetAlpha({ Ids = ids, Fraction = 1.0, Duration = 0.0 })
		for _, id in ipairs( ids ) do
			local critterData = cosmeticData.CritterGroups[groupName][id]
			if critterData ~= nil then
				if critterData.Animations ~= nil then
					local animName = GetRandomValue( critterData.Animations )
					SetAnimation({ DestinationId = id, Name = animName })
					MapState.ActiveObstacles[id].AnimName = animName
				end
				-- TODO: Activate distance triggers
			end
		end
	end
end

function HideAmbientCritters( cosmeticData )
	for groupName, groupData in pairs( cosmeticData.CritterGroups ) do
		local ids = GetIds({ Name = groupName })
		SetAlpha({ Ids = ids, Fraction = 0.0, Duration = 0.0 })
		for _, id in ipairs( ids ) do
			local critterData = groupData[id]
			if critterData ~= nil then
				-- TODO: Remove distance triggers
			end
		end
	end
end
