function UseCosmeticsShop( usee, args )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	thread( MarkObjectiveComplete, "DoraDecorationIntroPrompt" )
	local screen = OpenCosmeticsShopScreen( usee, { DefaultCategoryIndex = usee.DefaultCategoryIndex } )
	UseableOn({ Id = usee.ObjectId })
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

	UpdateGhostAdminInteractionText( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "OpenCosmeticsScreen" })

	thread( GenericScreenOpenEndPresentation, screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen

end

function CloseCosmeticsShopScreen( screen, button, args )
	args = args or {}
	OnScreenCloseStarted( screen )
	thread( CosmeticsShopScreenClosedPresentation, screen, button )
	CloseScreen( GetAllIds( screen.Components ), 0, screen )
	if not args.KeepAltAspectRatioFrames then
		AltAspectRatioFramesHide()
	end
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
end

function CosmeticShopDisplayCategory( screen, categoryIndex )

	local components = screen.Components

	screen.ActiveCategoryIndex = categoryIndex

	SetAnimation({ DestinationId = components.BackgroundBack.Id, Name = screen.ItemCategories[categoryIndex].BackingAnimation })

	screen.AvailableItems = {}
	screen.PurchasedItems = {}
	screen.NumItems = 0

	CurrentRun.ViewableWorldUpgrades = CurrentRun.ViewableWorldUpgrades or {}
	for i, cosmeticName in ipairs( screen.ItemCategories[categoryIndex] ) do
		local cosmeticData = WorldUpgradeData[cosmeticName]
		if CosmeticShopAllowViewItem( screen, screen.ItemCategories[categoryIndex], cosmeticData ) then
			if not cosmeticData.RotateOnly or ContainsAnyKey( GameState.WorldUpgradesAdded, cosmeticData.RemoveCosmetics ) then
				CurrentRun.ViewableWorldUpgrades[cosmeticName] = true
				CurrentRun.WorldUpgradesRevealed[cosmeticName] = true
				GameState.WorldUpgradesRevealed[cosmeticName] = true
				screen.NumItems = screen.NumItems + 1
				if GameState.WorldUpgradesAdded[cosmeticName] then
					table.insert( screen.PurchasedItems, cosmeticData )
				else
					table.insert( screen.AvailableItems, cosmeticData )
				end
			end
		end
	end

	CosmeticShopUpdateVisibility( screen )

end

function CosmeticShopUpdateVisibility( screen, args )
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
		if not purchased then
			button.OnPressedFunctionName = "HandleCosmeticShopPurchase"
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
		components[displayName.."Icon"] = icon

		local formatName = nil
		if purchased then
			formatName = "ItemPurchasedNameFormat"
		elseif HasResources( itemData.Cost ) then
			formatName = "ItemAvailableAffordableNameFormat"
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
			local stateIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = itemLocationX, Y = itemLocationY })
			table.insert( button.AssociatedIds, stateIcon.Id )
			components[displayName.."StateIcon"] = stateIcon

			local stateText = "Shop_Purchased"
			if itemData.Removable then
				if GameState.WorldUpgrades[displayName] then
					if not itemData.RotateOnly then
						button.OnPressedFunctionName = "HandleCosmeticShopRemoval"
						stateText = "Shop_Removable"
					end
				else
					button.Free = true
					button.OnPressedFunctionName = "HandleCosmeticShopReAdd"
					stateText = "Shop_ReAdd"
				end
			end

			local itemStateFormat = ShallowCopyTable( screen.ItemStateFormat )
			itemStateFormat.Id = stateIcon.Id
			itemStateFormat.Text = stateText
			CreateTextBox( itemStateFormat )
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

		SetAlpha({ Id = button.Id, Fraction = 1.0, Duration = 0.1 })
		SetAlpha({ Ids = button.AssociatedIds, Fraction = 1.0, Duration = 0.1 })
		if args.PlaySequentialFade then
			wait( 0.05 )
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

function HandleCosmeticShopPurchase( screen, button, args )
	args = args or {}

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

	if not GameState.WorldUpgradesAdded[upgradeData.Name] then
		local cacheName = screen.ItemCategories[screen.ActiveCategoryIndex].CacheName
		GameState.CosmeticsPurchasedCountCache[cacheName] = GameState.CosmeticsPurchasedCountCache[cacheName] + 1
		GameState.CosmeticsPurchasedCountCache.Total = GameState.CosmeticsPurchasedCountCache.Total + 1
	end

	AddWorldUpgrade( upgradeData.Name )
	if upgradeData.RemoveCosmetics ~= nil then
		for k, name in pairs( upgradeData.RemoveCosmetics ) do
			if GameState.WorldUpgrades[name] then
				args.RemoveCosmeticName = name
			end
			GameState.WorldUpgrades[name] = nil
		end
	end
	if upgradeData.AutoUnlockCosmeticName ~= nil then
		UnlockWorldUpgrade( upgradeData.AutoUnlockCosmeticName )
	end
	RemoveStoreItemPin( upgradeData.Name, { Purchase = true } )
	CallFunctionName( upgradeData.OnPurchasedFunctionName, upgradeData.OnPurchasedFunctionArgs )

	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = button.Id, OffsetX = 0 })

	-- close screen
	CloseCosmeticsShopScreen( screen, button )

	thread( DoCosmeticShopPurchase, screen, button, args )
end

function DoCosmeticShopPurchase( screen, button, args )
	local itemData = button.Data
	SessionMapState.CosmeticsPurchased[itemData.Name] = true
	PreActivateCosmeticPresentation( screen, button, itemData, args )
	CallFunctionName( itemData.OnActivateFunctionName, itemData.OnActivateFunctionArgs )
	ActivateConditionalItem( itemData, args )
	if itemData.AutoUnlockCosmeticName ~= nil then
		ActivateConditionalItem( WorldUpgradeData[itemData.AutoUnlockCosmeticName] )
	end
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

	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = button.Id, OffsetX = 0 })

	CloseCosmeticsShopScreen( screen, button )

	thread( DoCosmeticShopRemoval, screen, button )
end

function DoCosmeticShopRemoval( screen, button )
	local itemData = button.Data
	PreActivateCosmeticPresentation( screen, button, itemData, { Removal = true } )
	DeactivateConditionalItem( itemData )
	PostActivateCosmeticPresentation( button, itemData, { Removal = true } )
	OpenCosmeticsShopScreen( screen.OpenedFrom, { DefaultCategoryIndex = screen.ActiveCategoryIndex, SkipSalute = true } )
end

function CosmeticShopScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	GenericScrollPresentation( screen, button )
	CosmeticShopUpdateVisibility( screen, { AnimateSlider = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
end

function CosmeticShopScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	GenericScrollPresentation( screen, button )
	CosmeticShopUpdateVisibility( screen, { AnimateSlider = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })
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
	if itemData.ActivateUniqueIds ~= nil then
		Activate({ Ids = itemData.ActivateUniqueIds })
		SetAlpha({ Ids = itemData.ActivateUniqueIds, Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = "Default", DestinationIds = itemData.ActivateUniqueIds })
		end
		if itemData.ToggleShadows or itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsLight", Value = "Default", DestinationIds = itemData.ActivateUniqueIds })
		end
	end
	if itemData.ActivateIds ~= nil then
		Activate({ Ids = itemData.ActivateIds })
		SetAlpha({ Ids = itemData.ActivateIds, Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = "Default", DestinationIds = itemData.ActivateIds })
		end
		if itemData.ToggleShadows or itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsLight", Value = "Default", DestinationIds = itemData.ActivateIds })
		end
	end
	if itemData.DeactivateIds ~= nil and not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = itemData.DeactivateIds, Fraction = 0 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = itemData.DeactivateIds })
		end
		if itemData.ToggleShadows or itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = itemData.DeactivateIds })
		end
	end
	if itemData.ActivateGroups ~= nil then
		Activate({ Names = itemData.ActivateGroups })
		SetAlpha({ Ids = GetIds({ Names = itemData.ActivateGroups }), Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = "Default", DestinationNames = itemData.ActivateGroups })
		end
		if itemData.ToggleShadows or itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsLight", Value = "Default", DestinationNames = itemData.ActivateGroups })
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
	if itemData.SetAnimationValue ~= nil then
		for _, id in ipairs( itemData.SetAnimationIds or itemData.ActivateIds ) do
			SetAnimation({ DestinationId = id, Name = itemData.SetAnimationValue })
		end
	end
	if itemData.ActivateFunctionName ~= nil then
		CallFunctionName( itemData.ActivateFunctionName, itemData, itemData.ActivateFunctionArgs )
	end
	if itemData.ToggleUseable then
		UseableOn({ Ids = itemData.ActivateIds })
	end
end

function DeactivateConditionalItem( itemData, args )
	if itemData == nil then
		return
	end

	-- Off
	args = args or {}
	if itemData.ActivateUniqueIds ~= nil then
		SetAlpha({ Ids = itemData.ActivateUniqueIds, Fraction = 0 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = itemData.ActivateUniqueIds })
		end
		if itemData.ToggleShadows or itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = itemData.ActivateUniqueIds })
		end
	end
	if itemData.RemoveCosmetics == nil or not ContainsAnyKey( GameState.WorldUpgrades, itemData.RemoveCosmetics ) or args.ForceDeactivate then
		if itemData.ActivateIds ~= nil then
			SetAlpha({ Ids = itemData.ActivateIds, Fraction = 0 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = itemData.ActivateIds })
			end
			if itemData.ToggleShadows or itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = itemData.ActivateIds })
			end
		end
		if itemData.ActivateGroups ~= nil then
			SetAlpha({ Ids = GetIds({ Names = itemData.ActivateGroups }), Fraction = 0 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationNames = itemData.ActivateGroups })
			end
			if itemData.ToggleShadows or itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationNames = itemData.ActivateGroups })
			end
		end
		if itemData.DeactivateIds ~= nil then
			SetAlpha({ Ids = itemData.DeactivateIds, Fraction = 1 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = "Default", DestinationIds = itemData.DeactivateIds })
			end
			if itemData.ToggleShadows or itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsLight", Value = "Default", DestinationIds = itemData.DeactivateIds })
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
		if itemData.DeactivateFunctionName ~= nil then
			CallFunctionName( itemData.DeactivateFunctionName, itemData, itemData.DeactivateFunctionArgs )
		end
		if itemData.ToggleUseable then
			UseableOff({ Ids = itemData.ActivateIds })
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
		local category = ScreenData.CosmeticsShop.ItemCategories[categoryIndex]
		for k, itemName in ipairs( category ) do
			local itemData = WorldUpgradeData[itemName]
			if itemData ~= nil and not GameState.WorldUpgradesViewed[itemName] and CosmeticShopAllowViewItem( ScreenData.CosmeticsShop, category, itemData ) then
				return true
			end
		end
	end

	return false
end

function CosmeticShopAllowViewItem( screen, category, cosmeticData )
	if cosmeticData.Hidden then
		return false
	end

	if CurrentRun.ViewableWorldUpgrades[cosmeticData.Name] or GameState.WorldUpgradesAdded[cosmeticData.Name] then
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
