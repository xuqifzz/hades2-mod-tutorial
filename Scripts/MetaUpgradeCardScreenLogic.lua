function OpenMetaUpgradeCardScreen( source, args )
	args = args or {}
	StopStatusAnimation( source )
	ScreenAnchors.MetaUpgradeScreen = DeepCopyTable( ScreenData.MetaUpgradeCardLayout)
	local screen = ScreenAnchors.MetaUpgradeScreen
	local components = screen.Components
	screen.SourceId = source.ObjectId
	screen.OpenedFrom = source
	screen.FirstView = not GameState.ScreensViewed[screen.Name]

	screen.CostDisplay.StartX = screen.CostDisplay.StartX + ScreenCenterNativeOffsetX
	screen.CostDisplay.StartY = screen.CostDisplay.StartY + ScreenCenterNativeOffsetY

	if screen.FirstView then
		local resourceConsumable = "MetaCardPointsCommonDrop"
		local resourceData = ConsumableData[resourceConsumable]
		for resourceName, amount in pairs( resourceData.AddResources ) do
			if GetResourceAmount( resourceName ) <= 0 then
				AddResource( resourceName, amount, "FirstOpenPity", { Silent = true })
			end
		end
	end
	UseableOff({ Id = screen.SourceId })
	OnScreenOpened( screen )
	HideCombatUI( screen.Name )
	screen.ZoomLevel = GetZoomLevel()
	screen.KeepOpen = true
	local validWeapons = ConcatTableValues( ShallowCopyTable(WeaponSets.HeroSecondaryWeapons), AddLinkedWeapons( WeaponSets.HeroSecondaryWeapons ))
	for _, weaponName in pairs( validWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	SetPlayerInvulnerable(screen.Name)
	if MapState.FamiliarUnit ~= nil then
		AddInteractBlock( MapState.FamiliarUnit, "CardScreen" )
	end

	RecordStartingMetaUpgrades( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	UpdateMetaUpgradeCostText( screen )
	CreateMetaUpgradeCards( screen, {Autoselect = args.HighlightedCardName })
	screen.LastMouseOffButtonCardName = args.LastMouseOffButtonCardName
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.2 })
	local scale = 5 / screen.ZoomLevel
	SetScale({ Id = components.CardHoverFrame.Id, Fraction = scale, Duration = 0})
	if screen.FirstView then
		DoMetaUpgradeCardReveal( screen, { RevealedCardCoords = {{ Row = 1, Column = 1 }}})
	end
	wait(0.2)

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	thread( HandleCardSwapInput, screen )
	MetaUpgradeCardScreenOpenPresentation( screen )	
	
	if CanUpgradeCards() and not GameState.ScreensViewed.CardUpgradeInfoLayout then
		thread( UpgradeModeAvailablePresentation )

		OpenCardUpgradeInfoScreen( screen )
		if not screen.Exit then
			exitCanceled = true
		end
	end

	HandleScreenInput( screen )
end

function DoMetaUpgradePatches()
	for row, rowData in pairs( MetaUpgradeDefaultCardLayout ) do
		for column, cardName in pairs( rowData ) do
			GameState.MetaUpgradeCardLayout[row][column] = MetaUpgradeDefaultCardLayout[row][column]
		end
	end
	if not IsEmpty( GameState.MetaUpgradeState ) then
		if GameState.MetaUpgradeState.Tradoff ~= nil and GameState.MetaUpgradeState.TradeOff == nil then
			GameState.MetaUpgradeState.TradeOff = DeepCopyTable( GameState.MetaUpgradeState.Tradoff )
			GameState.MetaUpgradeState.Tradoff = nil
		end
		if GameState.MetaUpgradeState.TalentPoint ~= nil and GameState.MetaUpgradeState.TalentPointUpgrade == nil then
			GameState.MetaUpgradeState.TalentPointUpgrade = DeepCopyTable( GameState.MetaUpgradeState.TalentPoint )
			GameState.MetaUpgradeState.TalentPoint = nil
		end

		local toDelete = {}
		for metaUpgradeName in pairs( GameState.MetaUpgradeState ) do
			if not MetaUpgradeCardData[ metaUpgradeName ] then
				table.insert( toDelete, metaUpgradeName )
			end
		end

		for _, metaUpgradeName in pairs( toDelete ) do
			GameState.MetaUpgradeState[metaUpgradeName] = nil
		end
	end

	for name, value in pairs( GameState.ShrineUpgrades ) do
		if type(GameState.ShrineUpgrades[name]) == "boolean" then
			GameState.ShrineUpgrades[name] = 1
		end
		ShrineUpgradeExtractValues( name )
	end

	UpdateMetaUpgradeUnlockedCountCache()
end

function RecordStartingMetaUpgrades( screen )
	screen.StartingMetaUpgradeRecord = {}
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		screen.StartingMetaUpgradeRecord[ metaUpgradeName ] = metaUpgradeData.Equipped
	end
end

function GetZoomLevel()
	-- the highest locked item is the zoom level 
	local zoomLevel = 3
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			if GameState.MetaUpgradeState[cardName] and GameState.MetaUpgradeState[cardName].Unlocked then
				zoomLevel = math.max( zoomLevel, row + 1 )
				zoomLevel = math.max( zoomLevel, column + 1 )
			end
		end
	end
	if zoomLevel > 5 then
		zoomLevel = 5
	end
	return zoomLevel
end

function CreateMetaUpgradeCards( screen, cardArgs )
	cardArgs = cardArgs or {}
	local firstUsable = false
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			if row <= screen.ZoomLevel and column <= screen.ZoomLevel then
				local newCard = CreateMetaUpgradeCard( screen, row, column, cardName, cardArgs )
				if cardName == cardArgs.Autoselect or newCard.CardState == "UNLOCKED" and not firstUsable then
					firstUsable = true
					TeleportCursor({ DestinationId = newCard.Id, OffsetX = 20, OffsetY = 20, ForceUseCheck = true })
					MouseOverMetaUpgrade( newCard, true )
				end
			end
		end
	end
	if not firstUsable then
		TeleportCursor({ DestinationId = screen.Components[GetMetaUpgradeKey(1, 1)].Id, OffsetX = 20, OffsetY = 20, ForceUseCheck = true })
		MouseOverMetaUpgrade(  screen.Components[GetMetaUpgradeKey(1, 1)], true)
	end
end

function CreateMetaUpgradeCard( screen, row, column, cardName, args )
	local args = args or {}
	local components = screen.Components
	local scale = 5 / screen.ZoomLevel
	local offsetX = screen.DefaultStartX + ScreenCenterNativeOffsetX / scale
	local offsetY = screen.DefaultStartY + ScreenCenterNativeOffsetY / scale
	local xSpacer = screen.DefaultTalentXSpacer
	local ySpacer = screen.DefaultTalentYSpacer
	--scale = 1
	local newObstacle = CreateScreenComponent({ 
		Name = "ButtonMetaUpgradeCard", 
		X = (column - 1) * xSpacer * scale + offsetX * scale,
		Y = (row - 1) * ySpacer * scale + offsetY * scale,
		Group = "Combat_Menu_Overlay",
		Scale = scale
	})
	
	newObstacle.OnPressedFunctionName = args.ActionFunctionName or "MetaUpgradeCardAction"
	newObstacle.OnMouseOverFunctionName = args.HighlightFunctionName or "MouseOverMetaUpgrade"
	newObstacle.OnMouseOffFunctionName = args.HighlightOffFunctionName or "MouseOffMetaUpgrade"
	newObstacle.MouseOverSound = "/SFX/Menu Sounds/VictoryScreenBoonToggle"
	newObstacle.HoverFrameId = components.CardHoverFrame.Id
	newObstacle.CardName = cardName
	newObstacle.Row = row
	newObstacle.Column = column		
	newObstacle.Screen = screen
	newObstacle.StoreName = cardName
	if args.UpgradeStoreNames then
		newObstacle.StoreName = cardName .. GetMetaUpgradeLevel( cardName ) 
	end

	if MetaUpgradeCardData[cardName].TraitName then
		newObstacle.TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = MetaUpgradeCardData[cardName].TraitName, Rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( cardName )] })
		SetTraitTextData( newObstacle.TraitData )
	end
	components[GetMetaUpgradeKey(row, column)] = newObstacle
	AttachLua({ Id = newObstacle.Id, Table = newObstacle })
	SetInteractProperty({ DestinationId = newObstacle.Id, Property = "TooltipX", Value = ScreenCenterNativeOffsetX + 1675 })
	SetInteractProperty({ DestinationId = newObstacle.Id, Property = "TooltipY", Value = ScreenCenterNativeOffsetY + 620 })
	
	

	-- auxilary items
	local cardArtOverlay = CreateScreenComponent({ 
		Name = "BlankObstacle", 
		Group = "Combat_Menu_Overlay",
		Scale = scale
	})
	newObstacle.CardArtId = cardArtOverlay.Id 
	Attach({ Id = cardArtOverlay.Id, DestinationId = newObstacle.Id })

	local cardCorners = CreateScreenComponent({ 
		Name = "Card_InfoCornersBackground", 
		X = (column - 1) * xSpacer * scale + offsetX, 
		Y = (row - 1) * ySpacer * scale + offsetY, 
		Group = "Combat_Menu_Overlay",
		Scale = scale
	})
	newObstacle.CardCornersId = cardCorners.Id 
	Attach({ Id = cardCorners.Id, DestinationId = newObstacle.Id })

	local equippedHighlight = CreateScreenComponent({ 
		Name = "Card_EquippedHighlight", 
		X = (column - 1) * xSpacer * scale + offsetX, 
		Y = (row - 1) * ySpacer * scale + offsetY, 
		Group = "Combat_Menu_Overlay_Additive",
		Scale = scale * 1.3
	})
	newObstacle.EquippedHighlightId = equippedHighlight.Id 
	SetAlpha({ Id = newObstacle.EquippedHighlightId, Fraction = 0, Duration = 0})
	Attach({ Id = equippedHighlight.Id, DestinationId = newObstacle.Id,  })

	local typeIcon = CreateScreenComponent({ 
		Name = "BlankObstacle", 
		X = (column - 1) * xSpacer * scale + offsetX,
		Y = (row - 1) * ySpacer * scale + offsetY, 
		Group = "Combat_Menu_Overlay",
		Scale = scale
	})
	newObstacle.TypeIconId = typeIcon.Id 
	Attach({ Id = typeIcon.Id, DestinationId = newObstacle.Id })

	local upgradeIcon = CreateScreenComponent({ 
		Name = "BlankObstacle", 
		X = (column - 1) * xSpacer * scale + offsetX,
		Y = (row - 1) * ySpacer * scale + offsetY, 
		Group = "Combat_Menu_Overlay",
		Scale = scale
	})
	SetAnimation({ Name = "CardUpgradeIndicator", DestinationId = upgradeIcon.Id })
	SetAlpha({ Id = upgradeIcon.Id , Fraction = 0, Duration = 0.0 })
	newObstacle.UpgradeIconId = upgradeIcon.Id 
	Attach({ Id = upgradeIcon.Id, DestinationId = newObstacle.Id })
	
	local pinIcon = CreateScreenComponent({ 
		Name = "BlankObstacle", 
		X = (column - 1) * xSpacer * scale + offsetX, 
		Y = (row - 1) * ySpacer * scale + offsetY, 
		Group = "Combat_Menu_Overlay",
		Scale = scale
	})
	newObstacle.PinButtonId = pinIcon.Id 
	Attach({ Id = pinIcon.Id, DestinationId = newObstacle.Id })
	
	UpdateMetaUpgradeCard( screen, row, column)

	return newObstacle
end

function UpdateMetaUpgradeCard( screen, row, column )
	local button = screen.Components[GetMetaUpgradeKey( row, column )]
	local cardName = button.CardName
	local text = "MetaUpgrade_Locked"
	local state = "HIDDEN"
	
	DestroyTextBox({ Id = button.Id })
	if not GameState.MetaUpgradeState[cardName] then
		return
	end

	if GameState.MetaUpgradeState[cardName].Unlocked then
		text = cardName
		state = "UNLOCKED"
	elseif HasNeighboringUnlockedCards( row, column ) or (row == 1 and column == 1) then
		text = cardName
		state = "LOCKED"
	end
	local metaUpgradeData = MetaUpgradeCardData[cardName]
	local newZoom = {}
	if state == "UNLOCKED" then
		newZoom.OffsetX = screen.DefaultCardCostTitleArgs.OffsetX * 5/screen.ZoomLevel
		newZoom.OffsetY = screen.DefaultCardCostTitleArgs.OffsetY * 5/screen.ZoomLevel
		if screen.Name == "MetaUpgradeCardUpgradeLayout" then
			SetAlpha({ Id = button.CardCornersId, Fraction = 0.0 })
			CreateTextBox( MergeAllTables({{ Id = button.Id, Text = " " },
				screen.DefaultCardCostTitleArgs, newZoom }))
			if not MetaUpgradeAtMaxLevel( cardName ) then
				local metaUpgradeData = MetaUpgradeCardData[cardName]
				local resourceCost = metaUpgradeData.UpgradeResourceCost[ GetMetaUpgradeLevel( cardName )]
				if HasResources(resourceCost) then
					SetAlpha({ Id = button.UpgradeIconId, Fraction = 1, Duration = 0.2 })
				end
			end
		else
		CreateTextBox( MergeAllTables({{ Id = button.Id, Text = MetaUpgradeCardData[cardName].Cost },
			screen.DefaultCardCostTitleArgs, newZoom }))
		end
	elseif state == "LOCKED" then
		newZoom.OffsetX = screen.LockedCardCostTitleArgs.OffsetX * 5/screen.ZoomLevel
		newZoom.OffsetY = screen.LockedCardCostTitleArgs.OffsetY * 5/screen.ZoomLevel
		CreateTextBox( MergeAllTables({{ Id = button.Id, Text = MetaUpgradeCardData[cardName].Cost },
			screen.LockedCardCostTitleArgs, newZoom }))
			
		newZoom.OffsetX = screen.LockedCardResourceTextArgs.OffsetX * 5/screen.ZoomLevel
		newZoom.OffsetY = nil
	elseif state == "HIDDEN" then
		newZoom.OffsetX = screen.HiddenCardTitleTextArgs.OffsetX * 5/screen.ZoomLevel
		newZoom.OffsetY = screen.HiddenCardTitleTextArgs.OffsetY * 5/screen.ZoomLevel
		SetAlpha({ Id = button.CardCornersId, Fraction = 0.0 })
		CreateTextBox( MergeAllTables({{ Id = button.Id, Text = text },
			screen.HiddenCardTitleTextArgs, newZoom }))
	end

	if state ~= "HIDDEN" then
		
		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = metaUpgradeData.Name,
			SkipDraw = true,
			Color = Color.Transparent,
			UseDescription = true,
			LuaKey = "TooltipData",
			LuaValue = button.TraitData or {},
		})
		if metaUpgradeData.AutoEquipText ~= nil then
			CreateTextBox({ Id = button.Id,
				Text = metaUpgradeData.AutoEquipText,
				SkipDraw = true,
				Color = Color.Transparent,
			})
		end
		
		if GetMetaUpgradeLevel( button.CardName ) > 1 then 
			SetAnimation({ DestinationId = button.TypeIconId, Name = "CardRarityPatch", OffsetX = -400 / screen.ZoomLevel, OffsetY = -500 / screen.ZoomLevel })
			local rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( button.CardName )]
			SetColor({ Id = button.TypeIconId, Color =  Color["BoonPatch"..rarity ]})
		else
			SetAnimation({ Name = "Blank", DestinationId = button.TypeIconId})
		end
		SetAnimation({ Name = MetaUpgradeCardData[button.CardName].Image, DestinationId = button.CardArtId, Scale = screen.DefaultArtScale })
		if state == "LOCKED" then
			SetHSV({ Id = button.CardArtId, HSV = {0, -1, -0.1}, ValueChangeType = "Absolute" })
			SetHSV({ Id = button.CardCornersId, HSV = {0, -1, -0.25}, ValueChangeType = "Absolute" })
			SetAlpha({ Id = button.CardArtId, Fraction = 0.15 })
			SetAlpha({ Id = button.CardCornersId, Fraction = 0.5 })
		end
		if HasStoreItemPin( button.StoreName ) then
			AddStoreItemPinPresentation( button, { AnimationName = "MetaUpgradeItemPin", SkipVoice = true })
			-- Silent toolip
			CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
		end
	else
		SetAnimation({ Name = "DevBacking", DestinationId = button.CardArtId, Scale = screen.DefaultArtScale })
	end
	button.CardState = state
	UpdateMetaUpgradeCardAnimation( button )
end	

function UpdateMetaUpgradeCardAnimation( button )

	local cardName = button.CardName
	if GameState.MetaUpgradeState[cardName].Equipped then
		SetAlpha({ Id = button.EquippedHighlightId, Fraction = 1, Duration = 0.1 })
	else
		SetAlpha({ Id = button.EquippedHighlightId, Fraction = 0, Duration = 0.1 })
	end
end

function GetMetaUpgradeKey( row, column )
	return row.."_"..column.."MetaUpgrade"
end

function MouseOverMetaUpgrade( button, screenFirstOpen )
	if button.Screen.ZoomInProgress or not button.Screen.KeepOpen then 
		return
	end
	if button.Screen.LastMouseOffButtonCardName == button.CardName then
		button.Screen.LastMouseOffButtonCardName = nil
	end
	GenericMouseOverPresentation( button )
	Teleport({ Id = button.HoverFrameId, DestinationId = button.Id })
	UpdateMetaUpgradeCardInteractionText( button.Screen, button )
	SelectMetaUpgradeButton( button.Screen, button )
	UpdateMetaUpgradeCostDisplay( button.Screen, button )
	if not screenFirstOpen then
		PulseMetaUpgradeMemCostDisplay( button.Screen, button )
	end
end

function MouseOffMetaUpgrade( button )
	if button.Screen.ZoomInProgress or not button.Screen.KeepOpen then 
		return
	end
	button.Screen.LastMouseOffButtonCardName = button.CardName
	UpdateMetaUpgradeCardInteractionText( button.Screen )
end

function HasNeighboringUnlockedCards( row, column )
	local hasNeighboring = false
	if GameState.MetaUpgradeCardLayout[row][column - 1] and GameState.MetaUpgradeState[GameState.MetaUpgradeCardLayout[row][column - 1]] and GameState.MetaUpgradeState[GameState.MetaUpgradeCardLayout[row][column - 1]].Unlocked then
		return true
	elseif GameState.MetaUpgradeCardLayout[row ][column + 1] and GameState.MetaUpgradeState[GameState.MetaUpgradeCardLayout[row][column + 1]] and GameState.MetaUpgradeState[GameState.MetaUpgradeCardLayout[row][column + 1]].Unlocked then
		return true
	elseif GameState.MetaUpgradeCardLayout[row + 1] and GameState.MetaUpgradeCardLayout[row + 1][column] and GameState.MetaUpgradeState[GameState.MetaUpgradeCardLayout[row + 1 ][column]] and GameState.MetaUpgradeState[GameState.MetaUpgradeCardLayout[row + 1 ][column]].Unlocked then
		return true
	elseif GameState.MetaUpgradeCardLayout[row - 1] and GameState.MetaUpgradeCardLayout[row - 1][column] and GameState.MetaUpgradeState[GameState.MetaUpgradeCardLayout[row - 1 ][column]] and GameState.MetaUpgradeState[GameState.MetaUpgradeCardLayout[row - 1 ][column]].Unlocked then
		return true
	end
	return false
end

function GetNeighboringCoords( row, column, includeDiagonal )
	local neighboringNames = {}
	if GameState.MetaUpgradeCardLayout[row][column - 1] then
		table.insert(neighboringNames, { Row = row, Column = column - 1 })
	end
	if GameState.MetaUpgradeCardLayout[row ][column + 1] then
		table.insert(neighboringNames, { Row = row, Column = column + 1 })
	end
	if GameState.MetaUpgradeCardLayout[row + 1] and GameState.MetaUpgradeCardLayout[row + 1][column] then
		table.insert(neighboringNames, { Row = row + 1, Column = column })
	end
	if GameState.MetaUpgradeCardLayout[row - 1] and GameState.MetaUpgradeCardLayout[row - 1][column] then
		table.insert(neighboringNames, { Row = row - 1, Column = column })
	end
	if includeDiagonal then
		if GameState.MetaUpgradeCardLayout[row - 1] and GameState.MetaUpgradeCardLayout[row - 1][column - 1] then
			table.insert(neighboringNames, { Row = row - 1, Column = column - 1 })
		end
		if GameState.MetaUpgradeCardLayout[row - 1] and GameState.MetaUpgradeCardLayout[row - 1][column + 1] then
			table.insert(neighboringNames, { Row = row - 1, Column = column + 1 })
		end
		if GameState.MetaUpgradeCardLayout[row + 1] and GameState.MetaUpgradeCardLayout[row + 1][column - 1] then
			table.insert(neighboringNames, { Row = row + 1, Column = column - 1})
		end
		if GameState.MetaUpgradeCardLayout[row + 1] and GameState.MetaUpgradeCardLayout[row + 1][column + 1] then
			table.insert(neighboringNames, { Row = row + 1, Column = column + 1})
		end
	end
	return neighboringNames
end

function GetCoordsInRow( row )
	local neighboringNames = {}
	local maxCol = GetZoomLevel()
	for i = 1, maxCol do
		if GameState.MetaUpgradeCardLayout[row][ i ] then
			table.insert(neighboringNames, { Row = row, Column = i })
		end
	end
	return neighboringNames
end

function GetMetaUpgradeCardButton( screen, metaUpgradeName )
	
	local components = screen.Components
	local coords = GetMetaUpgradeCardCoords( metaUpgradeName )
	if coords then
		local button = components[GetMetaUpgradeKey(coords.Row, coords.Column)]
		if button and button.CardName == metaUpgradeName then
			return button
		end
	end

	-- fallback
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			local button = components[GetMetaUpgradeKey(row, column)]
			if button and button.CardName == metaUpgradeName then
				return button
			end
		end
	end
	return nil
end

function UpdateMetaUpgradeCostText( screen, nextIncrease )
	if not screen.KeepOpen then
		return
	end
	local components = screen.Components
	local currentCost = GetCurrentMetaUpgradeCost()
	local maxCost = GetMaxMetaUpgradeCost()
	if nextIncrease then
		maxCost = maxCost + nextIncrease
	end
	local color = Color.CostAffordable
	if currentCost > maxCost then
		color = Color.CostUnaffordable
	end
	screen.CostRingIds = screen.CostRingIds or {} 
	Destroy({Ids = screen.CostRingIds })
	screen.CostRingIds = {}
	for i = 1, maxCost do
		local currentRingId = CreateScreenObstacle({ Name = "BlankObstacle", DestinationId = components.CostTextRingTarget.Id, Group = "Combat_Menu_Overlay" })
		SetAnimation({ Name = string.format("RingSegment_%02d_%02d", maxCost, i), DestinationId = currentRingId})
		if i <= currentCost then
			SetColor({ Id = currentRingId, Color = Color.MEMBlue})
		else
			SetColor({ Id = currentRingId, Color = Color.MEMDark})
		end
		Attach({ Id = currentRingId, DestinationId = components.CostTextRingTarget.Id })
		table.insert( screen.CostRingIds, currentRingId )
	end
	ModifyTextBox({ Id = components.CurrentCostText.Id, Text = currentCost, Color = color })
	ModifyTextBox({ Id = components.MaxCostText.Id, Text = maxCost .. "{!Icons.ManaCrystal}"})

	if CanIncreaseMetaUpgradeCardLimit() then
	
		SetAlpha({ Id = components.MemNotifyUpgradeAvailableFrame.Id, Fraction = 1, Duration = 0.1 })
	else
		SetAlpha({ Id = components.MemNotifyUpgradeAvailableFrame.Id, Fraction = 0, Duration = 0.1 })
	end
end

function GetCurrentMetaUpgradeLimitLevel()
	if GameState.MetaUpgradeLimitLevel then
		return GameState.MetaUpgradeLimitLevel
	end
	return 0
end

function GetCurrentMetaUpgradeCost()
	local totalCost = 0
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if MetaUpgradeCardData[ metaUpgradeName ] and MetaUpgradeCardData[ metaUpgradeName ].Cost and metaUpgradeData.Equipped then
			totalCost = MetaUpgradeCardData[ metaUpgradeName ].Cost + totalCost
		end
	end
	if GetNumShrineUpgrades( "NoMetaUpgradesShrineUpgrade" ) <= 0 then
		GameState.MetaUpgradeCostCache = totalCost
	else
		GameState.MetaUpgradeCostCache = 0
	end
	return totalCost
end

function UpdateMetaUpgradeUnlockedCountCache()
	local num = 0
	local numMaxUpgrades = 0
	for metaUpgradeName, metaUpgrade in pairs( GameState.MetaUpgradeState ) do
		local metaUpgradeData = MetaUpgradeCardData[metaUpgradeName]
		if metaUpgradeData ~= nil and metaUpgradeData.Cost ~= nil and metaUpgrade.Unlocked then
			num = num + 1
		end
		if metaUpgrade.Level >= #metaUpgradeData.UpgradeResourceCost + 1 then
			numMaxUpgrades = numMaxUpgrades + 1
		end
	end
	GameState.MetaUpgradeUnlockedCountCache = num
	GameState.MetaUpgradeMaxLevelCountCache = numMaxUpgrades
end

function GetMaxMetaUpgradeCost()
	local metaUpgradeLimit = MetaUpgradeCostData.StartingMetaUpgradeLimit
	for i = 1, GetCurrentMetaUpgradeLimitLevel() do
		if MetaUpgradeCostData.MetaUpgradeLevelData[i] then
			metaUpgradeLimit = metaUpgradeLimit  + MetaUpgradeCostData.MetaUpgradeLevelData[i].CostIncrease
		end
	end
	GameState.MaxMetaUpgradeCostCache = metaUpgradeLimit
	return metaUpgradeLimit
end

function UpdateMetaUpgradeCostDisplay( screen, button )
	local components = screen.Components
	if button.CardState == "LOCKED" and MetaUpgradeCardData[button.CardName].ResourceCost then
		AddResourceCostDisplay( screen, MetaUpgradeCardData[button.CardName].ResourceCost, screen.CostDisplay )
		SetAlpha({ Id = components.MetaUpgradeResourceCostBacking.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.MetaUpgradeResourceCostBacking.Id, Fraction = 0.0, Duration = 0.2 })
	end
end

function SelectMetaUpgradeButton( screen, button )
	local components = screen.Components
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })
	
	screen.SelectedButton = button

	if not button or button.CardState == "HIDDEN" then
	
		ModifyTextBox({ Id = components.MetaUpgradeCardTitle.Id, Text = "MetaUpgrade_Locked" })
		ModifyTextBox({ Id = components.MetaUpgradeCardText.Id, Text = "MetaUpgrade_Hidden" })
		SetAnimation({ DestinationId = components.MetaUpgradeCardArt.Id, Name = "DevBacking", Scale = 0.66, OffsetX = -82, OffsetY = -160 })
		if components.MetaUpgradeCardFlavorText then
			ModifyTextBox({ Id = components.MetaUpgradeCardFlavorText.Id, Text = " " })
			components.MetaUpgradeCardFlavorText.Text = nil
		end	
		if components.MetaUpgradeCardAutoEquipText then
			ModifyTextBox({ Id = components.MetaUpgradeCardAutoEquipText.Id, Text = " " })
			components.MetaUpgradeCardAutoEquipText.Text = nil
		end
		return
	end

	-- Set card information
	if button.CardState == "LOCKED" or button.CardState == "UNLOCKED" then	
		local cardTitle = button.CardName
		local cardData = {}
		local cardMultiplier = 1
		if GameState.MetaUpgradeState[ cardTitle ].AdjacencyBonuses and GameState.MetaUpgradeState[ cardTitle ].AdjacencyBonuses.CustomMultiplier then
			cardMultiplier = cardMultiplier + GameState.MetaUpgradeState[ cardTitle ].AdjacencyBonuses.CustomMultiplier
		end
		if MetaUpgradeCardData[cardTitle].TraitName then
			cardData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = MetaUpgradeCardData[cardTitle].TraitName , Rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( cardTitle )], CustomMultiplier = cardMultiplier })
			SetTraitTextData( cardData )
		end
		if MetaUpgradeCardData[button.CardName].Image then
			SetAnimation({ DestinationId = components.MetaUpgradeCardArt.Id, Name = MetaUpgradeCardData[button.CardName].Image, Scale = 0.66, OffsetX = -82, OffsetY = -160 })
			
			if GetMetaUpgradeLevel( button.CardName ) > 1 then 
				SetAnimation({ DestinationId = components.MetaUpgradeCardArtPatch.Id, Name = "LargeCardRarityPatch"})
				local rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( button.CardName )]
				SetColor({ Id = components.MetaUpgradeCardArtPatch.Id, Color =  Color["BoonPatch"..rarity ]})
			else
				SetAnimation({ Name = "Blank", DestinationId = components.MetaUpgradeCardArtPatch.Id})
			end

			if button.CardState == "LOCKED" then
				SetHSV({ Id = components.MetaUpgradeCardArt.Id, HSV = {0, -1, -0.1}, ValueChangeType = "Absolute" })
			else
				SetHSV({ Id = components.MetaUpgradeCardArt.Id, HSV = {0, 0, 0}, ValueChangeType = "Absolute" })
			end
		end

		--[[
		if MetaUpgradeCardData[button.CardName].Type then
			
			SetAnimation({ Id = components.MetaUpgradeCardType.Id, Name= "DevCard_TypeIcon_".. MetaUpgradeCardData[button.CardName].Type })
		else
			SetAnimation({ Id = components.MetaUpgradeCardType.Id, Name= "Blank" })
		end
		]]
		
		local metaUpgradeCardData = MetaUpgradeCardData[button.CardName]
		if components.MetaUpgradeCardFlavorText then
			if button.CardState == "UNLOCKED" and MetaUpgradeCardData[button.CardName].FlavorTextData then
				for i, flavorTextData in ipairs(MetaUpgradeCardData[button.CardName].FlavorTextData) do
					if IsGameStateEligible(CurrentRun, flavorTextData.GameStateRequirements) then
						if components.MetaUpgradeCardFlavorText.Text ~= flavorTextData.Name then
							components.MetaUpgradeCardFlavorText.Text = flavorTextData.Name
							DestroyTextBox({ Id = components.MetaUpgradeCardFlavorText.Id })
							CreateTextBox( MergeTables({ Id = components.MetaUpgradeCardFlavorText.Id, Text = flavorTextData.Name }, screen.CardFlavorTextArgs))
						end
					end
				end
			else
				ModifyTextBox({ Id = components.MetaUpgradeCardFlavorText.Id, Text = " " })
				components.MetaUpgradeCardFlavorText.Text = nil
			end
		end
		ModifyTextBox({ Id = components.MetaUpgradeCardTitle.Id, Text = cardTitle })
		DebugData.CardData = metaUpgradeCardData
		ModifyTextBox({ Id = components.MetaUpgradeCardText.Id, Text = cardTitle, UseDescription = true, LuaKey = "TooltipData", LuaValue = cardData })
		if metaUpgradeCardData.AutoEquipText ~= nil then
			ModifyTextBox({ Id = components.MetaUpgradeCardAutoEquipText.Id, Text = metaUpgradeCardData.AutoEquipText, LuaKey = "TooltipData", LuaValue = cardData, FadeTarget = 1.0 })
		else
			ModifyTextBox({ Id = components.MetaUpgradeCardAutoEquipText.Id, FadeTarget = 0.0 })
		end
		
	end
end

function CheckAutoEquipCards( screen )
	local autoEquipMetaUpgrades = {}
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if metaUpgradeData.Unlocked and MetaUpgradeCardData[metaUpgradeName].AutoEquipRequirements then
			if CheckAutoEquipRequirements(MetaUpgradeCardData[metaUpgradeName].AutoEquipRequirements) then
				if not MetaUpgradeCardEquipped(metaUpgradeName) then
					autoEquipMetaUpgrades[ metaUpgradeName ] = true
				end
			elseif MetaUpgradeCardEquipped(metaUpgradeName) then
				autoEquipMetaUpgrades[ metaUpgradeName ] = false
			end
		end
	end

	for metaUpgradeName, equipValue in pairs( autoEquipMetaUpgrades ) do
		if equipValue then
			EquipMetaUpgradeBonusCardPresentation( screen, GetMetaUpgradeCardButton( screen, metaUpgradeName ))
			GameState.MetaUpgradeState[metaUpgradeName].Equipped = true
		else			
			UnequipMetaUpgradeBonusCardPresentation( screen, GetMetaUpgradeCardButton( screen, metaUpgradeName ))
			GameState.MetaUpgradeState[metaUpgradeName].Equipped = nil
		end
	end
end

function MetaUpgradeCardAction( screen, button )
	local selectedButton = button
	
	if screen.PickedUpButton then
		screen.ChangeMade = true
		DoCardSwap( screen, button )
		return
	end
	local metaUpgradeName = selectedButton.CardName
	local zoomOutDelay = 0
	local revealCardData = {}
	local expandPsyche = false
	if selectedButton.CardState == "UNLOCKED" then
		if MetaUpgradeCardData[metaUpgradeName].AutoEquipRequirements then
			if not MetaUpgradeCardEquipped(metaUpgradeName) then
				InvalidMetaUpgradeCardAction( screen, selectedButton )
			end
		else
			if MetaUpgradeCardEquipped( metaUpgradeName ) then
				screen.ChangeMade = true
				UnequipMetaUpgradeCardPresentation( screen, selectedButton )
				GameState.MetaUpgradeState[metaUpgradeName].Equipped = nil
				UpdateMetaUpgradeCardState( screen, selectedButton )
			else
				if GetCurrentMetaUpgradeCost() + MetaUpgradeCardData[ metaUpgradeName ].Cost > GetMaxMetaUpgradeCost() then
					MetaUpgradeCardOverLimitPresentation( screen, button )
					return
				else
					screen.ChangeMade = true
					EquipMetaUpgradeButton( screen, selectedButton )
				end
			end
			UpdateMetaUpgradeCostText( screen )
			PulseMetaUpgradeMemCostDisplay( screen, selectedButton )
		end
	elseif selectedButton.CardState == "LOCKED" then
		local metaUpgradeData = MetaUpgradeCardData[metaUpgradeName]
		if HasResources( metaUpgradeData.ResourceCost ) then
			screen.ChangeMade = true
			SpendResources( metaUpgradeData.ResourceCost, metaUpgradeName, { SkipOverheadText = true } )
			UnlockMetaUpgradeCardPresentation( screen, selectedButton, metaUpgradeData )
			zoomOutDelay = 1
			GameState.MetaUpgradeState[metaUpgradeName].Unlocked = true
			UpdateMetaUpgradeCard( screen, selectedButton.Row, selectedButton.Column )
			if metaUpgradeData.AutoEquipRequirements then
				UpdateMetaUpgradeCardState( screen, selectedButton )
			end
			for i, coordData in pairs( GetNeighboringCoords( selectedButton.Row, selectedButton.Column )) do
				local newButton = screen.Components[GetMetaUpgradeKey( coordData.Row, coordData.Column )]
				if not newButton or newButton.CardState == "HIDDEN" then
					table.insert( revealCardData, coordData )
				end
			end
			UpdateMetaUpgradeUnlockedCountCache()
			UpdateAffordabilityStatus()

			RemoveStoreItemPin( selectedButton.CardName, { Purchase = true } )
			RemoveStoreItemPinPresentation( selectedButton )
			SelectMetaUpgradeButton( screen, selectedButton )
			if GetCurrentMetaUpgradeCost() + MetaUpgradeCardData[ selectedButton.CardName  ].Cost <= GetMaxMetaUpgradeCost() then
				EquipMetaUpgradeButton( screen, selectedButton)
			elseif not GameState.Flags.MetaUpgradeExpandPsycheHint then
				GameState.Flags.MetaUpgradeExpandPsycheHint = true
				expandPsyche = true
			else
				PulseMetaUpgradeMemCostDisplay( screen, selectedButton )
			end
			SetHSV({ Id = selectedButton.CardCornersId, HSV = {0, 0, 0}, ValueChangeType = "Absolute" })
			SetAlpha({ Id = selectedButton.CardCornersId, Fraction = 1 })
		else
			ScreenCantAffordPresentation( screen, selectedButton, metaUpgradeData.ResourceCost )
		end
	end
	UpdateMetaUpgradeCardInteractionText( screen, selectedButton )
	DoMetaUpgradeCardReveal( screen, { ZoomOutDelay = zoomOutDelay, RevealedCardCoords = revealCardData, AutoEquipFailed = expandPsyche })
end

function EquipMetaUpgradeButton( screen, selectedButton )
	local metaUpgradeName = selectedButton.CardName
	EquipMetaUpgradeCardPresentation( screen, selectedButton )
	GameState.MetaUpgradeState[metaUpgradeName].Equipped = true
	UpdateMetaUpgradeCardState( screen, selectedButton )
	UpdateMetaUpgradeCostText( screen )
end

function MetaUpgradeCardEquipped( metaUpgradeName )
	if GameState.MetaUpgradeState[metaUpgradeName] and GameState.MetaUpgradeState[metaUpgradeName].Equipped then
		return true
	end
	return false
end
function CanIncreaseMetaUpgradeCardLimit()
	if not MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ] then
		return false
	end
	local nextCostData = MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ].ResourceCost
	if nextCostData and HasResources(nextCostData) then
		return true
	end
	return false
end

function IncreaseMetaUpgradeCardLimit( screen, button )
	if not MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ] then
		CannotAffordMetaUpgradeLimitPresentation( screen, button )
		return
	end

	local nextCostData = MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ].ResourceCost
	if nextCostData then
		if HasResources(nextCostData) then
			UpgradeMetaUpgradeLimitPresentation( screen, button )
			SpendResources (nextCostData, "IncreaseCardLimit", { SkipOverheadText = true })
			IncrementTableValue( GameState, "MetaUpgradeLimitLevel", 1 )
			MouseOverMetaUpgradeCardLimit( button )
			UpdateAffordabilityStatus()
		else
			ScreenCantAffordPresentation( screen, button, nextCostData)
		end
	else
		CannotAffordMetaUpgradeLimitPresentation( screen, button )
	end
end

function MouseOverMetaUpgradeCardLimit( button )
	local screen = button.Screen
	if not screen or not screen.KeepOpen then
		return
	end
	local components = screen.Components

	GenericMouseOverPresentation( button )
	
	button.Screen.SelectedButton = button

	SetAlpha({ Id = components.CardHoverFrame.Id, Fraction = 0, Duration = 0.1 })
	SetAlpha({ Id = components.MemHighlightFrame.Id, Fraction = 1, Duration = 0.1 })
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	if components.MetaUpgradeCardFlavorText then
		ModifyTextBox({ Id = components.MetaUpgradeCardFlavorText.Id, Text = " " })
	end
	DestroyTextBox({ Ids = screen.CostIds })
	local nextMetaUpgradeLevel = MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ]
	if not nextMetaUpgradeLevel then
		ModifyTextBox({ Id = components.MetaUpgradeCardTitle.Id, Text = "IncreaseMetaUpgradeCard" })
		ModifyTextBox({ Id = components.MetaUpgradeCardText.Id, Text = "Max_MetaUpgrade" })
		if components.MetaUpgradeCardAutoEquipText then
			ModifyTextBox({ Id = components.MetaUpgradeCardAutoEquipText.Id, Text = " " })
			components.MetaUpgradeCardAutoEquipText.Text = nil
		end
	else

		nextCostData = nextMetaUpgradeLevel.ResourceCost
		if nextCostData then
			SetAnimation({ DestinationId = components.MetaUpgradeCardArt.Id, Name = "CardArt_17", Scale = 0.66, OffsetX = -82, OffsetY = -160 })
			UpdateMetaUpgradeCostText( screen, nextMetaUpgradeLevel.CostIncrease  )
			AddResourceCostDisplay( screen, nextCostData, screen.CostDisplay )
			ModifyTextBox({ Id = components.MetaUpgradeCardTitle.Id, Text = "IncreaseMetaUpgradeCard" })
			ModifyTextBox({ Id = components.MetaUpgradeCardText.Id, Text = "IncreaseMetaUpgradeCard", UseDescription = true, LuaKey = "TempTextData", LuaValue = { Amount = nextMetaUpgradeLevel.CostIncrease}})	
			
			if components.MetaUpgradeCardAutoEquipText then
				ModifyTextBox({ Id = components.MetaUpgradeCardAutoEquipText.Id, Text = " " })
				components.MetaUpgradeCardAutoEquipText.Text = nil
			end
		end
	end
	UpdateMetaUpgradeCardInteractionText( screen, { Name = "MemCostModule" })
end

function MouseOffMetaUpgradeCardLimit( button )
	local screen = button.Screen
	if not screen then
		return
	end
	local components = screen.Components
	UpdateMetaUpgradeCostText( screen )
	SetAnimation({ DestinationId = components.MetaUpgradeCardArt.Id, Name = "DevBacking", Scale = 0.66, OffsetX = -82, OffsetY = -160 })
	ModifyTextBox({ Id = components.MetaUpgradeCardTitle.Id, Text = " " })
	ModifyTextBox({ Id = components.MetaUpgradeCardText.Id, Text = " " })
	SetAlpha({ Id = components.CardHoverFrame.Id, Fraction = 1, Duration = 0.1 })
	SetAlpha({ Id = components.MemHighlightFrame.Id, Fraction = 0, Duration = 0.1 })

	UpdateMetaUpgradeCardInteractionText( screen )
end


function NoMetaUpgradeCardsUnlocked()
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if metaUpgradeData.Unlocked then
			return false
		end
	end
	return true

end
function HasAvailableMetaUpgradeCapacity( screen )

	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if not metaUpgradeData.Equipped 
			and metaUpgradeData.Unlocked 
			and not MetaUpgradeCardData[metaUpgradeName].AutoEquipRequirements 
			and MetaUpgradeCardData[metaUpgradeName].Cost > 0
			and GetCurrentMetaUpgradeCost() + MetaUpgradeCardData[metaUpgradeName].Cost <= GetMaxMetaUpgradeCost() then
			return true
		end
	end
	return false
end

function UpdateMetaUpgradeCardInteractionText( screen, button )

	local components = screen.Components

	local selectButtonText = nil
	local canPin = false

	--local textData = {}
	if button ~= nil then
		if button.Name == "MemCostModule" then
			if MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ] then
				--table.insert( textData, "MetaUpgradeMem_Upgrade" )
				selectButtonText = "MetaUpgradeMem_Upgrade"
			else
				--table.insert( textData, "Max_MetaUpgrade_Action" )
				-- selectButtonText = "Max_MetaUpgrade_Action"
			end
		elseif button.CardState == "HIDDEN" then
		elseif button.CardState == "LOCKED" then
			--table.insert( textData, "MetaUpgrade_Unlock" )
			selectButtonText = "MetaUpgrade_Unlock"
		
			if GameState.WorldUpgrades.WorldUpgradePinning then
				--table.insert( textData, "MetaUpgrade_Pin" )
				canPin = true
			end
		else
			local cardName = button.CardName
			if MetaUpgradeCardData[cardName] and not MetaUpgradeCardData[cardName].AutoEquipRequirements then
				if GameState.MetaUpgradeState[cardName].Equipped then
					--table.insert( textData, "MetaUpgrade_Unequip" )
					selectButtonText = "MetaUpgrade_Unequip"
				else
					--table.insert( textData, "MetaUpgrade_Equip" )
					selectButtonText = "MetaUpgrade_Equip"
				end
			end

			if IsGameStateEligible( CurrentRun, MetaUpgradeSwapGameStateRequirement ) then
				if screen.PickedUpButton then
					if screen.PickedUpButton == button then
						--table.insert( textData, "MetaUpgrade_CancelSwap" )
						selectButtonText = "MetaUpgrade_CancelSwap"
					else
						--table.insert( textData, "MetaUpgrade_EndSwap" )
						selectButtonText = "MetaUpgrade_EndSwap"
					end
				else
					--table.insert( textData, "MetaUpgrade_StartSwap" )
					selectButtonText = "MetaUpgrade_StartSwap"
				end
			end
		end
	end

	if selectButtonText ~= nil then
		ModifyTextBox({ Id = components.SelectButton.Id, Text = selectButtonText })
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

	if canPin then
		SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
	
	if CanUpgradeCards() then	
		--table.insert( textData, "MetaUpgradeMem_UpgradeMode")
		SetAlpha({ Id = components.UpgradeModeButton.Id, Fraction = 1.0, Duration = 0.2 })
		ModifyTextBox({ Id = components.UpgradeModeButton.Id, LuaKey = "TempTextData", LuaValue = {Amount = GetResourceAmount("CardUpgradePoints")} })
	else
		SetAlpha({ Id = components.UpgradeModeButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

	--table.insert( textData, "MetaUpgradeMem_Exit")
	--AddContextualAction( screen, textData )

end

function RecordMetaUpgradeChanges( screen )
	SessionState.MetaUpgradeChanges = { CardData = {} }
	local hasChanged = false
	local numEquipped = 0
	local startEquipped = 0
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if metaUpgradeData.Equipped then
			numEquipped = numEquipped + 1
		end
		if screen.StartingMetaUpgradeRecord[ metaUpgradeName ] then
			startEquipped = startEquipped + 1
		end
		if metaUpgradeData.Equipped ~= screen.StartingMetaUpgradeRecord[ metaUpgradeName ] then
			if metaUpgradeData.Equipped then
				SessionState.MetaUpgradeChanges.CardData[metaUpgradeName] = { Equipped = true }
				hasChanged = true
			else
				SessionState.MetaUpgradeChanges.CardData[metaUpgradeName] = { Unequipped = true }
				hasChanged = true
			end
		end
	end

	SessionState.MetaUpgradeChanges.HasChanged = hasChanged
	SessionState.MetaUpgradeChanges.StartingEquippedCount = startEquipped
	SessionState.MetaUpgradeChanges.EquippedCount = numEquipped
	SessionState.MetaUpgradeChanges.FewerCardsEquipped = startEquipped > numEquipped
	SessionState.MetaUpgradeChanges.MoreCardsEquipped = startEquipped < numEquipped

end
function CloseMetaUpgradeCardScreen( screen, args )
	args = args or {}
	local exitCanceled = false
	local closeDelay = 0
	if not args.UpgradeTransition then 
		if NoMetaUpgradeCardsUnlocked() then
			OpenNoUpgradeInfoScreen( screen )
			if not screen.Exit then
				exitCanceled = true
			end
		end
		if HasAvailableMetaUpgradeCapacity( screen ) then
			OpenBelowLimitScreen( screen )
			if not screen.Exit then
				exitCanceled = true
			end
		end
		if exitCanceled then
			TeleportCursor({ DestinationId = screen.Components[GetMetaUpgradeKey(1, 1)].Id, OffsetX = 20, OffsetY = 20, ForceUseCheck = true })
			MouseOverMetaUpgrade(  screen.Components[GetMetaUpgradeKey(1, 1)], true )
			return
		end
		
		closeDelay = 0.15
		thread( CloseMetaUpgradeCardScreenPresentation, screen )
	end

	RecordMetaUpgradeChanges( screen )
	for metaUpgradeName, data in pairs( SessionState.MetaUpgradeChanges.CardData) do
		if data.Equipped and MetaUpgradeCardData[ metaUpgradeName ].TraitName then
			local cardMultiplier = 1
			if GameState.MetaUpgradeState[ metaUpgradeName ].AdjacencyBonuses and GameState.MetaUpgradeState[ metaUpgradeName ].AdjacencyBonuses.CustomMultiplier then
				cardMultiplier = cardMultiplier + GameState.MetaUpgradeState[ metaUpgradeName ].AdjacencyBonuses.CustomMultiplier 
			end
			AddTraitToHero({ 
					SkipNewTraitHighlight = true, 
					TraitName = MetaUpgradeCardData[ metaUpgradeName ].TraitName, 
					Rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( metaUpgradeName )], CustomMultiplier = cardMultiplier })
		elseif data.Unequipped then
			RemoveWeaponTrait(	MetaUpgradeCardData[ metaUpgradeName ].TraitName, { Silent = true })
		end
	end
	CurrentRun.NumRerolls = GetTotalHeroTraitValue( "RerollCount" )
	
	local ids = GetAllIds( screen.Components )
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
		
			local button = screen.Components[GetMetaUpgradeKey( row, column )]
			if button then
				table.insert( ids, button.CardArtId )
				table.insert( ids, button.CardCornersId )
				table.insert( ids, button.UpgradeIconId )
				table.insert( ids, button.TypeIconId )
				table.insert( ids, button.EquippedHighlightId )
				table.insert( ids, button.PinButtonId )
			end
		end
	end
	for _, id in pairs(screen.CostRingIds) do
		table.insert( ids, id )
	end
	OnScreenCloseStarted( screen )

	if screen.ChangeMade then
		RequestPreRunLoadoutChangeSave()
	end

	CloseScreen( ids, closeDelay )
	
	if not args.UpgradeTransition then
		local validWeapons = ConcatTableValues( ShallowCopyTable(WeaponSets.HeroSecondaryWeapons), AddLinkedWeapons( WeaponSets.HeroSecondaryWeapons ))
		for _, weaponName in pairs( validWeapons ) do
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true  })
		end
	end
	SetPlayerVulnerable( screen.Name )
	UpdateMetaUpgradeUnlockedCountCache()
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
	if not args.UpgradeTransition then
		UseableOn({ Id = screen.SourceId })
		if MapState.FamiliarUnit ~= nil then
			RemoveInteractBlock( MapState.FamiliarUnit, "CardScreen" )
		end
	end
	UpdateRerollUI( CurrentRun.NumRerolls )
	ValidateMaxHealth()
	ValidateMaxMana()
	if not IsGameStateEligible(CurrentRun, { AnyAffordableMetaUpgradeItems = true }) then
		StopCurrentStatusAnimation( screen.OpenedFrom ) 
	end

	if not NoMetaUpgradeCardsUnlocked() then
		thread( MarkObjectiveComplete, "CardPrompt" )
	end
	DebugPrint({Text = " screen end "})
end

function UpdateMetaUpgradeCardState( screen, button )
	CheckAutoEquipCards( screen )
	CheckAutoEquipCards( screen )	-- To fix. This is because a auto-equip ability may be processed before the "surrounded" auto-equip check @alice
	UpdateMetaUpgradeCardAdjacencyBonuses()
	if button then
		SelectMetaUpgradeButton( screen, button )
		UpdateMetaUpgradeCostDisplay( screen, button )
	end
	
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
		
			local button = screen.Components[GetMetaUpgradeKey( row, column )]
			if button then
				UpdateMetaUpgradeCardAnimation( button )
			end
		end
	end
end

function HandleCardSwapInput( screen )

	while screen.KeepOpen do
		NotifyOnControlPressed({ Names = {"Attack3"}, Notify = "CardSwapInput" })
		waitUntil( "CardSwapInput" )
		if IsGameStateEligible( CurrentRun, MetaUpgradeSwapGameStateRequirement ) then
			if not screen.PickedUpButton then
				-- Pick up card + start presentation
				if screen.SelectedButton.CardState == "UNLOCKED" then
					screen.PickedUpButton = screen.SelectedButton
					Teleport({ Id = screen.Components.CardSwapFrame.Id, DestinationId = screen.SelectedButton.Id })
				end
			else
				-- Swap cards
				DoCardSwap( screen, screen.SelectedButton  )
			end
			
			UpdateMetaUpgradeCardInteractionText( screen, screen.SelectedButton )
		end
		wait(0.1)
	end
end

function DoCardSwap( screen, button )
	if not screen.PickedUpButton or not button then
		return
	end
	if button.CardState ~= "UNLOCKED" then
		return
	end
	Teleport({ Id = screen.Components.CardSwapFrame.Id, OffsetX = -1000, OffsetY = -1000 })
	if button == screen.PickedUpButton then	
		screen.PickedUpButton = nil
		return
	end
	
	local components = screen.Components
	local cardTargetAId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = button.Id })
	local cardTargetBId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = screen.PickedUpButton.Id })
	
	local cardA = screen.PickedUpButton
	local cardB = button

	local cardACoord = { Row = cardA.Row, Column = cardA.Column }
	local cardBCoord = { Row = cardB.Row, Column = cardB.Column }

	Move({ Id = cardA.Id, DestinationId = cardTargetAId, Duration = 0.2, EaseIn = 0, EaseOut = 1 })
	Move({ Id = cardB.Id, DestinationId = cardTargetBId, Duration = 0.2, EaseIn = 0, EaseOut = 1 })
	
	GameState.MetaUpgradeCardLayout[ cardACoord.Row ][ cardACoord.Column ] = cardB.CardName
	GameState.MetaUpgradeCardLayout[ cardBCoord.Row ][ cardBCoord.Column ] = cardA.CardName
	
	cardA.Row = cardBCoord.Row
	cardB.Row = cardACoord.Row

	cardA.Column = cardBCoord.Column
	cardB.Column = cardACoord.Column
	
	components[GetMetaUpgradeKey(cardACoord.Row, cardACoord.Column)] = cardB
	components[GetMetaUpgradeKey(cardBCoord.Row, cardBCoord.Column)] = cardA
	
	screen.PickedUpButton = nil
	Destroy({ Ids = { cardTargetAId, cardTargetBId }})
	UpdateMetaUpgradeCardState( screen, cardB )
	thread( SetCardOnDelay, cardA.Id, 0.2)
end


function SetCardOnDelay( id, delay )
	wait( delay, RoomThreadName )	
	TeleportCursor({ DestinationId = id, OffsetX = 20, OffsetY = 20, ForceUseCheck = true })
end

function CanUpgradeCards()
	return IsGameStateEligible( CurrentRun, ScreenData.MetaUpgradeCardUpgradeLayout.GameStateRequirements )
end

function EnterUpgradeMode( screen, button )
	if not CanUpgradeCards() then
		return
	end
	thread( CloseMetaUpgradeCardScreen, screen, { UpgradeTransition = true })
	if screen.SelectedButton then
		thread( OpenMetaUpgradeCardUpgradeScreen, screen.OpenedFrom, { LastMouseOffButtonCardName = screen.LastMouseOffButtonCardName, HighlightedCardName = screen.SelectedButton.CardName })
	else
		thread( OpenMetaUpgradeCardUpgradeScreen, screen.OpenedFrom, { LastMouseOffButtonCardName = screen.LastMouseOffButtonCardName })
	end
	thread( EnterMetaUpgradeUpgradeModePresentation, screen )
end

function MetaUpgradeCardScreenPinItem( screen, button )
	if screen.SelectedButton == nil then
		return
	end
	if screen.SelectedButton.CardName == button.Screen.LastMouseOffButtonCardName then
		return
	end
	if not GameState.WorldUpgrades.WorldUpgradePinning then
		return
	end
	if screen.SelectedButton.CardState ~= "LOCKED" or screen.SelectedButton.Name == "MemCostModule" then
		return
	end
	local itemName = screen.SelectedButton.CardName
	if HasStoreItemPin( itemName ) then
		RemoveStoreItemPin( itemName )
		RemoveStoreItemPinPresentation( screen.SelectedButton )
	else
		AddStoreItemPin( itemName, "MetaUpgradeCardData" )
		AddStoreItemPinPresentation( screen.SelectedButton, { AnimationName = "MetaUpgradeItemPin" })
	end
end