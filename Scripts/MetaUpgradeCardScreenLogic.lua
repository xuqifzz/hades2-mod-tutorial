function OpenMetaUpgradeCardScreen( source, args )
	args = args or {}

	StopStatusAnimation( source )

	AltAspectRatioFramesShow()

	local screen = DeepCopyTable( ScreenData.MetaUpgradeCardLayout )
	local components = screen.Components
	screen.SourceId = source.ObjectId
	screen.OpenedFrom = source
	screen.FirstView = not GameState.ScreensViewed[screen.Name]
	screen.CostDisplay.StartX = screen.CostDisplay.StartX + ScreenCenterNativeOffsetX
	screen.CostDisplay.StartY = screen.CostDisplay.StartY + ScreenCenterNativeOffsetY
	screen.StartingFateValid = PreRunIsFateValid()
	screen.StartingHasLastStand = HasLastStand( CurrentRun.Hero )
	screen.StartingHealth = CurrentRun.Hero.MaxHealth
	screen.StartingMana = CurrentRun.Hero.MaxMana
	screen.RevealingCards = 0
	
	if screen.FirstView then
		local resourceConsumable = "MetaCardPointsCommonDrop"
		local resourceData = ConsumableData[resourceConsumable]
		for resourceName, amount in pairs( resourceData.AddResources ) do
			if GetResourceAmount( resourceName ) <= 0 then
				AddResource( resourceName, amount, "FirstOpenPity", { Silent = true, SkipVoiceLines = true } )
			end
		end
	end
	UseableOff({ Id = screen.SourceId })
	OnScreenOpened( screen )
	HideCombatUI( screen.Name )
	screen.ZoomLevel = GetZoomLevel()
	screen.KeepOpen = true
	for weaponName, v in pairs( WeaponSetLookups.HeroSecondaryWeaponsLinked ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		end
	end
	SetPlayerInvulnerable(screen.Name)
	if MapState.FamiliarUnit ~= nil then
		AddInteractBlock( MapState.FamiliarUnit, "CardScreen" )
	end

	RecordStartingMetaUpgrades( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	InitializeMetaUpgradePins( screen )
	CreateBones( screen )
	UpdateMetaUpgradeCostText( screen )
	CreateMetaUpgradeCards( screen, {Autoselect = args.HighlightedCardName })
	Teleport({ Id = screen.Components.MemCostModule.Id, DestinationId = screen.Components.MemCostModuleBaseTarget.Id })
	screen.LastMouseOffButtonCardName = args.LastMouseOffButtonCardName
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.3, Duration = 0.2 })
	local scale = 5 / screen.ZoomLevel
	SetScale({ Id = components.CardHoverFrame.Id, Fraction = scale, Duration = 0})
	MetaUpgradeCardScreenUpdateLayoutSets( screen )
	UpdateMetaUpgradeCardInteractionText( screen )
	wait(0.2)

	screen.KeepOpen = true
	thread( HandleCardSwapInput, screen )
	MetaUpgradeCardScreenOpenPresentation( screen )	
	if CanIncreaseMetaUpgradeCardLimit() and GetCurrentMetaUpgradeLimitLevel() == 0 and GetMaximumUnlockedMetaUpgradeCost() > GetMaxMetaUpgradeCost() then
		OpenGraspLimitScreen( screen, { UnlockedCards = true } )
		MetaUpgradeCardScreenResetCursor( screen )
		CreateAnimation({ Name = "MEMCanAffordBadge", DestinationId = screen.Components.MemCostModule.Id, OffsetY = -210})
	elseif CanIncreaseMetaUpgradeCardLimit() and GetCurrentMetaUpgradeLimitLevel() == 0 then
		OpenGraspLimitScreen( screen, { CanAfford = true } )
		MetaUpgradeCardScreenResetCursor( screen )
		CreateAnimation({ Name = "MEMCanAffordBadge", DestinationId = screen.Components.MemCostModule.Id, OffsetY = -210})
	elseif CanUpgradeCards() and not GameState.ScreensViewed.CardUpgradeInfoLayout then
		thread( UpgradeModeAvailablePresentation )

		OpenCardUpgradeInfoScreen( screen )
		if not screen.Exit then
			exitCanceled = true
		end
	elseif CanUpgradeCards() and GetResourceAmount("CardUpgradePoints") >= 13 and HasAffordableMetaUpgradeUpgrade() and not GameState.Flags.SecondUpgradeReminder then
		thread( UpgradeModeAvailablePresentation )

		GameState.Flags.SecondUpgradeReminder = true
		OpenCardUpgradeInfoScreen( screen )
		if not screen.Exit then
			exitCanceled = true
		end
	end
	HandleScreenInput( screen )
end

function CreateBones( screen )
	local components = screen.Components
	screen.CostRingIds = screen.CostRingIds or {} 
	for i = 1, 30 do
		local currentRingId = CreateScreenObstacle({ Name = "BlankObstacle", DestinationId = components.CostTextRingTarget.Id, Group = "Combat_Menu_Overlay_Backing" })
		SetAnimation({ Name = "Mem_Bone_"..i, DestinationId = currentRingId})
		Attach({ Id = currentRingId, DestinationId = components.CostTextRingTarget.Id })
		table.insert( screen.CostRingIds, currentRingId )
	end
end

function DoMetaUpgradePatches()
	for row, rowData in pairs( MetaUpgradeDefaultCardLayout ) do
		GameState.MetaUpgradeCardLayout[row] = GameState.MetaUpgradeCardLayout[row] or {}
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
		for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
			if not MetaUpgradeCardData[ metaUpgradeName ] then
				table.insert( toDelete, metaUpgradeName )
			end
			if metaUpgradeData.Level and metaUpgradeData.Level > 1 then
				GameState.Flags.HasUpgradedCards = true
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
	GameState.CurrentMetaUpgradeLayout = GameState.CurrentMetaUpgradeLayout or 1
	GameState.SavedMetaUpgradeLayouts = GameState.SavedMetaUpgradeLayouts or {}
	GameState.MetaUpgradeLayoutsArt = GameState.MetaUpgradeLayoutsArt or {}
	
	UpdateMetaUpgradeUnlockedCountCache()
end

function ValidateMetaUpgradeLayout()
	local hasChange = false
	while GetCurrentMetaUpgradeCost() > GetMaxMetaUpgradeCost() do
		for cost=1,5 do
			local unequip = false
			for i, metaUpgradeName in ipairs( MetaUpgradeUnequipPatchData [ cost ] ) do
				if MetaUpgradeCardEquipped(metaUpgradeName) then
					GameState.MetaUpgradeState[metaUpgradeName].Equipped = nil
					unequip = true
					hasChange = true
					break
				end
			end
			if unequip then
				break
			end
		end
	end
	CheckAutoEquipCards()
	if hasChange then
		SaveCurrentMetaUpgradeSet()
	end
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

function MetaUpgradeCardScreenResetCursor( screen, args )
	if GetConfigOptionValue({ Name = "UseMouse" }) then
		return
	end
	local destination = nil
	if args ~= nil and args.Destination ~= nil then
		destination = args.Destination
	elseif screen.SelectedButton ~= nil and screen.SelectedButton.Name ~= "MetaUpgradeMemCostBackground" then
		destination = screen.SelectedButton
	else
		destination = screen.Components[GetMetaUpgradeKey(1, 1)]
	end
	TeleportCursor({ DestinationId = destination.Id, OffsetX = 20, OffsetY = 20, ForceUseCheck = true })
	MouseOverMetaUpgrade( destination, true)
end

function CreateMetaUpgradeCards( screen, cardArgs )
	cardArgs = cardArgs or {}
	local firstUsable = false
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			if row <= screen.ZoomLevel and column <= screen.ZoomLevel then
				local newCard = CreateMetaUpgradeCard( screen, row, column, cardName, cardArgs )
				if cardName == cardArgs.Autoselect or ( newCard.CardState == "UNLOCKED" and not firstUsable and not cardArgs.Autoselect ) then
					firstUsable = true
					MetaUpgradeCardScreenResetCursor( screen, { Destination = newCard })
				end
			end
		end
	end
	if not firstUsable then
		MetaUpgradeCardScreenResetCursor( screen )
	end
end

function CreateMetaUpgradeCard( screen, row, column, cardName, args )
	local args = args or {}
	local components = screen.Components
	local scale = 5 / screen.ZoomLevel
	local scaleLerp = 1 - (screen.ZoomLevel - 3) / 2 
	local offsetX = screen.DefaultStartX 
	local offsetY = screen.DefaultStartY + screen.ScaledStartY * ( scaleLerp )
	local xSpacer = screen.DefaultTalentXSpacer
	local ySpacer = screen.DefaultTalentYSpacer
	
	local locationX = (column - 1) * xSpacer * scale + offsetX * scale + ScreenCenterNativeOffsetX
	local locationY = (row - 1) * ySpacer * scale + offsetY * scale + ScreenCenterNativeOffsetY
	local newObstacle = CreateScreenComponent({ 
		Name = "ButtonMetaUpgradeCard", 
		X = locationX,
		Y = locationY,
		Group = "Combat_Menu_Overlay",
		Scale = scale
	})
	
	newObstacle.OnPressedFunctionName = args.ActionFunctionName or "MetaUpgradeCardAction"
	newObstacle.OnMouseOverFunctionName = args.HighlightFunctionName or "MouseOverMetaUpgrade"
	newObstacle.OnMouseOffFunctionName = args.HighlightOffFunctionName or "MouseOffMetaUpgrade"
	newObstacle.MouseOverSound = "/Leftovers/World Sounds/Caravan Interior/CardsInteract"
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
	SetInteractProperty({ DestinationId = newObstacle.Id, Property = "TooltipX", Value = ScreenCenterNativeOffsetX + screen.TooltipX })
	SetInteractProperty({ DestinationId = newObstacle.Id, Property = "TooltipY", Value = ScreenCenterNativeOffsetY + screen.TooltipY })	

	newObstacle.CardArtId = newObstacle.Id 
	
	-- auxilary items

	local equippedHighlight = CreateScreenComponent({ 
		Name = "Card_EquippedHighlight", 
		X = locationX, 
		Y = locationY, 
		Group = screen.ComponentData.DefaultHighlightGroup,
		Scale = scale
	})
	newObstacle.EquippedHighlightId = equippedHighlight.Id 
	SetAlpha({ Id = newObstacle.EquippedHighlightId, Fraction = 0, Duration = 0 })
	Attach({ Id = equippedHighlight.Id, DestinationId = newObstacle.Id,  })

	local cardCorners = CreateScreenComponent({ 
		Name = "Card_InfoCornersBackground",
		Group = screen.ComponentData.DefaultCornerGroup,
		Scale = scale
	})
	newObstacle.CardCornersId = cardCorners.Id 
	Attach({ Id = cardCorners.Id, DestinationId = newObstacle.Id })
	
	local rarityIndicator = CreateScreenComponent({ 
		Name = "BlankObstacle",
		Group = screen.ComponentData.DefaultCornerGroup,
		Scale = scale
	})
	newObstacle.RarityBadgeId = rarityIndicator.Id 
	Attach({ Id = rarityIndicator.Id, DestinationId = newObstacle.Id })
	
	local upgradeIcon = CreateScreenComponent({ 
		Name = "BlankObstacle", 
		X = (column - 1) * xSpacer * scale + offsetX,
		Y = (row - 1) * ySpacer * scale + offsetY, 
		Group = screen.ComponentData.DefaultCornerGroup,
		Scale = scale
	})
	SetAnimation({ Name = "CardUpgradeIndicator", DestinationId = upgradeIcon.Id })
	SetAlpha({ Id = upgradeIcon.Id , Fraction = 0, Duration = 0.0 })
	newObstacle.UpgradeIconId = upgradeIcon.Id 
	Attach({ Id = upgradeIcon.Id, DestinationId = newObstacle.Id })

	local cardCornerTextBox = CreateScreenComponent({ 
		Name = "BlankObstacle",
		Group = screen.ComponentData.DefaultCornerGroup,
		Scale = scale
	})
	newObstacle.CostTextId = cardCornerTextBox.Id 
	Teleport({ Id = cardCornerTextBox.Id, DestinationId = cardCorners.Id })

	local pinIcon = CreateScreenComponent({ 
		Name = "BlankObstacle", 
		Group = "Combat_Menu_Overlay",
		Scale = scale
	})
	newObstacle.PinButtonId = pinIcon.Id 
	Attach({ Id = pinIcon.Id, DestinationId = newObstacle.Id })
	UpdateMetaUpgradeCard( screen, row, column)

	return newObstacle
end

function RecreateMetaUpgradeCostText( button, group )

	DestroyTextBox({ Id = button.CostTextId })
	local screen = button.Screen
	local row = button.Row
	local column = button.Column
	local cardName = button.CardName
	local state = "HIDDEN"
	local group = group or ScreenData.MetaUpgradeCardLayout.ComponentData.DefaultGroup
	local scaleLerp = 1 - (screen.ZoomLevel - 3) / 2
	local newZoom =
	{
		OffsetX = Lerp(screen.DefaultCardCostTitleArgs.StartOffsetX, screen.DefaultCardCostTitleArgs.EndOffsetX, scaleLerp ) * 5/screen.ZoomLevel,
		OffsetY = screen.DefaultCardCostTitleArgs.OffsetY * 5/screen.ZoomLevel,
		Group = group
	}
	if not GameState.MetaUpgradeState[cardName] then
		return
	end

	if GameState.MetaUpgradeState[cardName].Unlocked then
		state = "UNLOCKED"
	elseif HasNeighboringUnlockedCards( row, column ) or (row == 1 and column == 1) then
		state = "LOCKED"
	end
	if state == "UNLOCKED" then
		local textArgs = ShallowCopyTable(screen.DefaultCardCostTitleArgs)
		textArgs.ScaleTarget = 5 / screen.ZoomLevel
		CreateTextBox( MergeAllTables({{ Id = button.CostTextId, Text = MetaUpgradeCardData[cardName].Cost, },
			textArgs, newZoom }))
	elseif state == "LOCKED" then
			local textArgs = ShallowCopyTable(screen.LockedCardCostTitleArgs)
			textArgs.ScaleTarget = 5 / screen.ZoomLevel
		CreateTextBox( MergeAllTables({{ Id = button.CostTextId, Text = MetaUpgradeCardData[cardName].Cost, },
			textArgs, newZoom }))
	elseif state == "HIDDEN" then
			local textArgs = ShallowCopyTable(screen.HiddenCardTitleTextArgs)
			textArgs.ScaleTarget = 5 / screen.ZoomLevel
		CreateTextBox( MergeAllTables({{ Id = button.CostTextId, Text = text, },
			textArgs, newZoom }))
	end
end

function UpdateMetaUpgradeCard( screen, row, column, skipCostText )
	local button = screen.Components[GetMetaUpgradeKey( row, column )]
	local cardName = button.CardName
	local text = "MetaUpgrade_Locked"
	local state = "HIDDEN"
	if not GameState.MetaUpgradeState[cardName] then
		return
	end
	if not skipCostText then
		RecreateMetaUpgradeCostText( button )
	end
	if GameState.MetaUpgradeState[cardName].Unlocked then
		text = cardName
		state = "UNLOCKED"
	elseif HasNeighboringUnlockedCards( row, column ) or (row == 1 and column == 1) then
		text = cardName
		state = "LOCKED"
	end
	local metaUpgradeData = MetaUpgradeCardData[cardName]
	local fadeCard = false
	if state == "UNLOCKED" then
		if screen.Name == "MetaUpgradeCardUpgradeLayout" then
			if not MetaUpgradeAtMaxLevel( cardName ) then
				local metaUpgradeData = MetaUpgradeCardData[cardName]
				local resourceCost = metaUpgradeData.UpgradeResourceCost[ GetMetaUpgradeLevel( cardName )]
				if HasResources(resourceCost) then
					SetAlpha({ Id = button.UpgradeIconId, Fraction = 1, Duration = 0.2 })
					ModifyTextBox({ Id = button.CostTextId, Text = " " })
				else
					fadeCard = true
				end
			else
				ModifyTextBox({ Id = button.CostTextId, Text = "MetaUpgrade_Ineligible" })
			end
			SetAlpha({ Id = button.CardCornersId, Fraction = 1})
		else
			SetAlpha({ Id = button.CardCornersId, Fraction = 1})
		end
	elseif state == "LOCKED" then
		if screen.Name == "MetaUpgradeCardUpgradeLayout" then
			fadeCard = true
		else
			SetAlpha({ Id = button.CardCornersId, Fraction = 1.0 })
		end
	elseif state == "HIDDEN" then
		if screen.Name == "MetaUpgradeCardUpgradeLayout" then
			fadeCard = true
		else
			SetAlpha({ Id = button.CardCornersId, Fraction = 0.0 })
		end
	end

	if state ~= "HIDDEN" then
		DestroyTextBox({ Id = button.Id })
		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = metaUpgradeData.Name,
			SkipDraw = true,
			Color = Color.Transparent,
			UseDescription = true,
			LuaKey = "TooltipData",
			LuaValue = button.TraitData or {},
		})
		if metaUpgradeData.ShowLastStandWarning and ( HasLastStand( CurrentRun.Hero ) or GameState.MetaUpgradeState.LastStand.Equipped ) then
			CreateTextBox({ Id = button.Id,
				Text = "ExtraLivesWarning_Tooltip",
				UseDescription = true,
				OffsetX = 0, OffsetY = 0,
				Color = Color.Transparent,
			})
		end
		if metaUpgradeData.AutoEquipText ~= nil then
			CreateTextBox({ Id = button.Id,
				Text = metaUpgradeData.AutoEquipText,
				SkipDraw = true,
				Color = Color.Transparent,
			})
		end
		
		
		SetAnimation({ Name = MetaUpgradeCardData[button.CardName].Image, DestinationId = button.CardArtId, Scale = screen.DefaultArtScale })
		if state == "LOCKED" then
			SetAnimation({ DestinationId = button.CardCornersId, Name = "RarityCircleCommon" }) --nopkg
			SetHSV({ Id = button.CardArtId, HSV = {0, -1, -0.1}, ValueChangeType = "Absolute" })
			SetHSV({ Id = button.CardCornersId, HSV = {0, -1, -0.25}, ValueChangeType = "Absolute" })
		else
			local rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( button.CardName )]
			SetAnimation({ DestinationId = button.CardCornersId, Name = "RarityCircle".. rarity })
		end
		if HasStoreItemPin( button.StoreName ) then
			AddStoreItemPinPresentation( button, { AnimationName = "MetaUpgradeItemPin", SkipVoice = true })
			-- Silent toolip
			CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
		end
	else
		SetAnimation({ Name = "DevBacking", DestinationId = button.CardArtId, Scale = screen.DefaultArtScale })
		SetAnimation({ DestinationId = button.RarityBadgeId, Name =  "Blank" })
	end
	if fadeCard then
		SetAlpha({ Id = button.CardCornersId, Fraction = 0.2, Duration = 0.2 })
		SetAlpha({ Id = button.CardArtId, Fraction = 0.2, Duration = 0.2 })
		ModifyTextBox({ Id = button.CostTextId, Text = " " })
	end
	button.CardState = state
	UpdateMetaUpgradeCardAnimation( button )
end	

function UpdateMetaUpgradeCardAnimation( button )
	local screen = button.Screen
	local cardName = button.CardName
	
	if screen.Name == "MetaUpgradeCardUpgradeLayout" then
		ModifyTextBox({ Id = button.CostTextId, ColorTarget = Color.MetaUpgradeCardUpgradeInactive, ColorDuration = 0.1 })
	else
		if GameState.MetaUpgradeState[cardName].Equipped then
			SetAnimation({ Name = MetaUpgradeCardData[button.CardName].Image, DestinationId = button.CardArtId, Scale = screen.DefaultArtScale })
			SetAlpha({ Id = button.EquippedHighlightId, Fraction = 1, Duration = 0.1 })
			ModifyTextBox({ Id = button.CostTextId, ColorTarget = Color.LightGreen, ColorDuration = 0.1 })
		else
			if button.CardState == "UNLOCKED" or button.CardState == "LOCKED" then
				SetAnimation({ Name = MetaUpgradeCardData[button.CardName].Image.."_Inactive", DestinationId = button.CardArtId, Scale = screen.DefaultArtScale })
			end
			SetAlpha({ Id = button.EquippedHighlightId, Fraction = 0, Duration = 0.1 })
			ModifyTextBox({ Id = button.CostTextId, ColorTarget = Color.White, ColorDuration = 0.1 })
		end
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
	local screen = button.Screen
	local components = screen.Components
	SetAlpha({ Id = components.MetaUpgradeCardArt.Id, Fraction = 1, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardArtPatch.Id, Fraction = 1, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardTitle.Id, Fraction = 1, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardAutoEquipText.Id, Fraction = 1, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardText.Id, Fraction = 1, Duration = 0.2 })
	if components.MetaUpgradeCardFlavorText then
		SetAlpha({ Id = components.MetaUpgradeCardFlavorText.Id, Fraction = 1, Duration = 0.2 })
	end
	GenericMouseOverPresentation( button )
	Teleport({ Id = button.HoverFrameId, DestinationId = button.Id })
	UpdateMetaUpgradeCardInteractionText( button.Screen, button )
	SelectMetaUpgradeButton( button.Screen, button )
	UpdateMetaUpgradeCostDisplay( button.Screen, button )
	if not screenFirstOpen then
		PulseMetaUpgradeMemCostDisplay( button.Screen, button )
		if GameState.MetaUpgradeUnlockedCountCache <= 0 and button.CardState == "LOCKED" then
			if not screen.FirstSelectPrompt then
				thread( PulseContextActionPresentation, screen.Components.SelectButton, { InitialWait = 3.0, TimeBetweenPulses = 3.0, ThreadName = "SelectButtonPulse" } )
				screen.FirstSelectPrompt = true
			else
				SetThreadWait( "SelectButtonPulse", 0.5 )
			end
		end
	end
end

function MouseOffMetaUpgrade( button )
	if button.Screen.ZoomInProgress or not button.Screen.KeepOpen then 
		return
	end

	local screen = button.Screen
	local components = screen.Components
	
	screen.RestoreZoomButton = nil
	SetAlpha({ Id = components.MetaUpgradeCardArt.Id, Fraction = 0, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardArtPatch.Id, Fraction = 0, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardTitle.Id, Fraction = 0, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardAutoEquipText.Id, Fraction = 0, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardText.Id, Fraction = 0, Duration = 0.2 })
	if components.MetaUpgradeCardFlavorText then
		SetAlpha({ Id = components.MetaUpgradeCardFlavorText.Id, Fraction = 0, Duration = 0.2 })
	end
	if components.MetaUpgradeCardMaxLevel then
		SetAlpha({ Id = components.MetaUpgradeCardMaxLevel.Id, Fraction = 0, Duration = 0.2 })
	end
	if components.MetaUpgradeMaxRank then
		SetAlpha({ Id = components.MetaUpgradeMaxRank.Id, Fraction = 0, Duration = 0.2 })
	end
	SetAlpha({ Id = components.CardHoverFrame.Id, Fraction = 1, Duration = 0.1 })
	if components.MemHighlightFrame then
		SetAlpha({ Id = components.MemHighlightFrame.Id, Fraction = 0, Duration = 0.1 })
	end
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	StopMetaUpgradeMemCostPulse( screen )
	button.Screen.LastMouseOffButtonCardName = button.CardName
	UpdateMetaUpgradeCardInteractionText( button.Screen )
	MetaupgradeUpdateCardZoom( screen )
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

function GetCoordsInColumn( col )
	local neighboringNames = {}
	local maxRow = GetZoomLevel()
	for i = 1, maxRow do
		if GameState.MetaUpgradeCardLayout[ i ][ col ] then
			table.insert(neighboringNames, { Row = i, Column = col })
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

function InitializeMetaUpgradePins( screen )
	local components = screen.Components
	local pinIcon = CreateScreenComponent({ Name = "BlankObstacle",  Group = "Combat_Menu_Overlay" })
	components.MemCostModule.PinButtonId = pinIcon.Id
	Attach({ Id = pinIcon.Id, DestinationId = components.MemCostModule.Id, OffsetX = components.MemCostModule.PinOffsetX, OffsetY = components.MemCostModule.PinOffsetY })
	if HasStoreItemPin( "MetaUpgradeLevelData".. GetCurrentMetaUpgradeLimitLevel() + 1 ) then
		AddStoreItemPinPresentation( components.MemCostModule, { AnimationName = "MetaUpgradeItemPin", SkipVoice = true })
		-- Silent toolip
		CreateTextBox({ Id = components.MemCostModule.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
	end
end

function UpdateMetaUpgradeCostText( screen, nextIncrease )
	if not screen.KeepOpen or screen.Name == "MetaUpgradeCardUpgradeLayout" then
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

	-- pips
	screen.CostPipIds = screen.CostPipIds or {}
	Destroy({Ids = screen.CostPipIds })
	screen.CostPipIds = {}
	for i = 1, maxCost do
		local currentRingId = CreateScreenObstacle({ Name = "BlankObstacle", DestinationId = components.PipRingTarget.Id, Group = "Combat_Menu" })
		SetAnimation({ Name = string.format("RingSegment_%02d_%02d", maxCost, i), DestinationId = currentRingId})
		if i <= currentCost then
			SetColor({ Id = currentRingId, Color = Color.MEMBlue})
		else
			if nextIncrease and i > ( maxCost - nextIncrease ) then
				SetColor({ Id = currentRingId, Color = Color.BonesActive})
				Flash({ Id = currentRingId, Speed = 1, MinFraction = 0, MaxFraction = 1, Color = Color.MEMDark })
			else
				SetColor({ Id = currentRingId, Color = Color.MEMDark})
			end
		end
		Attach({ Id = currentRingId, DestinationId = components.PipRingTarget.Id })
		table.insert( screen.CostPipIds, currentRingId )
	end

	-- bones
	if not IsEmpty(screen.CostRingIds) then
		for i = 1, 30 do
			local currentRingId = screen.CostRingIds[i]
			if not (nextIncrease and i > ( maxCost - nextIncrease ) and i <= maxCost ) then
				StopFlashing({ Id = currentRingId })
			end
			if i <= currentCost then
				SetColor({ Id = currentRingId, Color = Color.BonesActive})
			elseif i > currentCost and i <= maxCost then
				if nextIncrease and i > ( maxCost - nextIncrease ) then
					Flash({ Id = currentRingId, Speed = 1, MinFraction = 0, MaxFraction = 1, Color = Color.BonesInactive })
				else
					SetColor({ Id = currentRingId, Color = Color.BonesInactive})
				end
			else
				SetColor({ Id = currentRingId, Color = Color.BonesLocked})
			end
		end
	end
	ModifyTextBox({ Id = components.CurrentCostText.Id, Text = currentCost, Color = color })
	ModifyTextBox({ Id = components.MaxCostText.Id, Text = maxCost })
	if currentCost < 10 then
		Attach({ Id = components.CurrentCostText.Id, DestinationId = components.MemCostModule.Id, OffsetX = -3 })
	else
		Attach({ Id = components.CurrentCostText.Id, DestinationId = components.MemCostModule.Id, OffsetX = 0 })
	end
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
	GameState.MetaUpgradeCostCache = totalCost
	return totalCost
end

function GetMaximumUnlockedMetaUpgradeCost()
	local totalCost = 0
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if MetaUpgradeCardData[ metaUpgradeName ] and MetaUpgradeCardData[ metaUpgradeName ].Cost and metaUpgradeData.Unlocked then
			totalCost = MetaUpgradeCardData[ metaUpgradeName ].Cost + totalCost
		end
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
		SetAlpha({ Id = components.MetaUpgradeResourceCostBacking.Id, Fraction = 0.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.MetaUpgradeResourceCostBacking.Id, Fraction = 0.0, Duration = 0.2 })
	end
end

function SelectMetaUpgradeButton( screen, button )
	local components = screen.Components
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })
	
	screen.SelectedButton = button
	screen.ClipboardText = button.CardName

	if not button or button.CardState == "HIDDEN" then
	
		ModifyTextBox({ Id = components.MetaUpgradeCardTitle.Id, Text = "MetaUpgrade_Locked" })
		ModifyTextBox({ Id = components.MetaUpgradeCardText.Id, Text = "MetaUpgrade_Hidden" })
		SetHSV({ Id = components.MetaUpgradeCardArt.Id, HSV = {0, 0, 0}, ValueChangeType = "Absolute" })
		SetAnimation({ DestinationId = components.MetaUpgradeCardArt.Id, Name = "DevBacking" })
		SetAnimation({ DestinationId = components.MetaUpgradeCardArtPatch.Id, Name = "Blank" })
		if components.MetaUpgradeCardFlavorText then
			ModifyTextBox({ Id = components.MetaUpgradeCardFlavorText.Id, Text = " " })
			components.MetaUpgradeCardFlavorText.Text = nil
		end	
		if components.MetaUpgradeCardAutoEquipText then
			ModifyTextBox({ Id = components.MetaUpgradeCardAutoEquipText.Id, Text = " " })
			components.MetaUpgradeCardAutoEquipText.Text = nil
		end
		MetaupgradeUpdateCardZoom( screen, button )
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
			SetAnimation({ DestinationId = components.MetaUpgradeCardArt.Id, Name = MetaUpgradeCardData[button.CardName].Image })
			
			local rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( button.CardName )]
			SetAnimation({ DestinationId = components.MetaUpgradeCardArtPatch.Id, Name = "RarityFrameLarge" .. rarity })
			
			if button.CardState == "LOCKED" then
				SetHSV({ Id = components.MetaUpgradeCardArt.Id, HSV = {0, -1, -0.1}, ValueChangeType = "Absolute" })
				SetAnimation({ DestinationId = components.MetaUpgradeCardArtPatch.Id, Name = "Blank" })
			
			else
				SetHSV({ Id = components.MetaUpgradeCardArt.Id, HSV = {0, 0, 0}, ValueChangeType = "Absolute" })
			end
		end
		
		local metaUpgradeCardData = MetaUpgradeCardData[button.CardName]
		if components.MetaUpgradeCardFlavorText then
			if button.CardState == "UNLOCKED" and MetaUpgradeCardData[button.CardName].FlavorTextData then
				for i, flavorTextData in ipairs(MetaUpgradeCardData[button.CardName].FlavorTextData) do
					if IsGameStateEligible( flavorTextData, flavorTextData.GameStateRequirements ) then
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
		if metaUpgradeCardData.CustomTextWithShrineUpgrade and GetNumShrineUpgrades( metaUpgradeCardData.CustomTextWithShrineUpgrade.ShrineUpgradeName ) > 0 then
			cardTitle = metaUpgradeCardData.CustomTextWithShrineUpgrade.CardTitle
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
	MetaupgradeUpdateCardZoom( screen, button )
end

function MetaupgradeUpdateCardZoom( screen, card )

	local scale = 5 / screen.ZoomLevel
	local increasedScale = scale * ScreenData.MetaUpgradeCardLayout.MouseoverArtScale /  ScreenData.MetaUpgradeCardLayout.DefaultArtScale
	local zoomDuration = 0.16
	local zoomEaseIn = 0.99
	local zoomEaseOut = 1
	local scaleLerp = 1 - (screen.ZoomLevel - 3) / 2
	local xOffset = Lerp(ScreenData.MetaUpgradeCardLayout.StartMouseoverCostXOffset, ScreenData.MetaUpgradeCardLayout.EndMouseoverCostXOffset, scaleLerp) * scale
	local yOffset = ScreenData.MetaUpgradeCardLayout.MouseoverCostYOffset * scale
	local speed = math.sqrt( xOffset * xOffset + yOffset * yOffset ) / zoomDuration
	if screen.LastZoomButton then
		local groupedLayerIds = 
		{
			screen.LastZoomButton.Id,
			screen.LastZoomButton.CardArtId,
			screen.LastZoomButton.PinButtonId,
			screen.LastZoomButton.HoverFrameId,
		}
		local allIds = ConcatTableValues( groupedLayerIds,  
		{
			screen.LastZoomButton.RarityBadgeId,
			screen.LastZoomButton.CostTextId,
			screen.LastZoomButton.EquippedHighlightId,
			screen.LastZoomButton.UpgradeIconId,
			screen.LastZoomButton.CardCornersId,
		})

		SetScale({ Ids = allIds, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
		SetScale({ Ids = allIds, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })

		RemoveFromGroup({ Ids = groupedLayerIds, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.MouseOverGroup})
		AddToGroup({ Ids = groupedLayerIds, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.DefaultGroup, DrawGroup = true })
		
		RemoveFromGroup({ Id = screen.LastZoomButton.EquippedHighlightId, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.MouseOverHighlightGroup})
		AddToGroup({ Id = screen.LastZoomButton.EquippedHighlightId, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.DefaultHighlightGroup, DrawGroup = true })
		
		RemoveFromGroup({ Id = screen.LastZoomButton.RarityBadgeId, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.MouseOverCornerGroup})
		AddToGroup({ Id = screen.LastZoomButton.RarityBadgeId, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.DefaultCornerGroup, DrawGroup = true })
		
		RemoveFromGroup({ Ids = { screen.LastZoomButton.CardCornersId, screen.LastZoomButton.CostTextId, screen.LastZoomButton.UpgradeIconId }, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.MouseOverCornerGroup})
		AddToGroup({ Ids = { screen.LastZoomButton.CardCornersId, screen.LastZoomButton.CostTextId, screen.LastZoomButton.UpgradeIconId }, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.DefaultCornerGroup, DrawGroup = true })
		
		Move({ Id = screen.LastZoomButton.CostTextId, DestinationId = screen.LastZoomButton.CardCornersId, OffsetX = 0, OffsetY = 0, Speed = speed, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })	
		ModifyTextBox({ Id = screen.LastZoomButton.CostTextId, ScaleTarget = scale, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
	end

	if card then
	
		local groupedLayerIds = 
		{
			card.Id,
			card.CardArtId,
			card.PinButtonId,
			card.HoverFrameId,
		}
		local allIds = ConcatTableValues( groupedLayerIds,  
		{
			card.RarityBadgeId,
			card.CostTextId,
			card.EquippedHighlightId,
			card.CardCornersId,
			card.UpgradeIconId,
		})

		SetScale({ Ids = allIds, Fraction = increasedScale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
	
		SetScale({ Id = card.HoverFrameId, Fraction = scale, Duration = 0 })
		SetScale({ Id = card.HoverFrameId, Fraction = increasedScale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
		
		RemoveFromGroup({ Ids = groupedLayerIds, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.DefaultGroup})
		AddToGroup({ Ids = groupedLayerIds, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.MouseOverGroup, DrawGroup = true })
		
		RemoveFromGroup({ Id = card.EquippedHighlightId, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.DefaultHighlightGroup})
		AddToGroup({ Id = card.EquippedHighlightId, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.MouseOverHighlightGroup, DrawGroup = true })
		
		RemoveFromGroup({ Ids = { card.CardCornersId, card.CostTextId, card.RarityBadgeId, card.UpgradeIconId }, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.DefaultCornerGroup})
		AddToGroup({ Ids = { card.CardCornersId, card.CostTextId, card.RarityBadgeId, card.UpgradeIconId }, Name = ScreenData.MetaUpgradeCardLayout.ComponentData.MouseOverCornerGroup, DrawGroup = true })

		Move({ Id = card.CostTextId, DestinationId = card.CardCornersId, OffsetX = xOffset, OffsetY = yOffset, Speed = speed, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
		ModifyTextBox({ Id = card.CostTextId, ScaleTarget = increasedScale, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
	end
	screen.LastZoomButton = card
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
			if screen then
				EquipMetaUpgradeBonusCardPresentation( screen, GetMetaUpgradeCardButton( screen, metaUpgradeName ))
			end
			GameState.MetaUpgradeState[metaUpgradeName].Equipped = true
		else			
			if screen then
				UnequipMetaUpgradeBonusCardPresentation( screen, GetMetaUpgradeCardButton( screen, metaUpgradeName ))
			end
			GameState.MetaUpgradeState[metaUpgradeName].Equipped = nil
		end
	end
end

function MetaUpgradeCardAction( screen, button )
	local selectedButton = button
	local components = screen.Components

	if screen.PickedUpButton then
		screen.ChangeMade = true
		DoCardSwap( screen, button )
		return
	end
	killTaggedThreads( "SelectButtonPulse" )
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
			for resourceName, resourceCost in pairs( metaUpgradeData.ResourceCost ) do
				SpendResource( resourceName, resourceCost, metaUpgradeName, { TargetId = components["ResourceIconBacking"..resourceName].Id, UseScreenLocation = true, TextOffsetY = 11, TextAnchorOffsetY = -50, SkipQuestStatusCheck = true } )
			end
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
			local scale = 2.00
			CreateAnimation({ Name = "CardUnlockShineLarge", --nopkg
				ScaleX = 0.7975 * scale,
				ScaleY = 0.957 * scale,
				DestinationId = components.MetaUpgradeCardArt.Id, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
			
			SetHSV({ Id = components.MetaUpgradeCardArt.Id, Duration = 0.1, HSV = {0, 0, 0}, ValueChangeType = "Absolute" })
			SetHSV({ Id = selectedButton.CardCornersId, HSV = {0, 0, 0}, ValueChangeType = "Absolute" })
			SetThingProperty({ Property = "AddColor", Value = true, DestinationId = components.MetaUpgradeCardArt.Id })
			SetThingProperty({ Property = "AddColor", Value = true, DestinationId = selectedButton.CardCornersId })
			SetColor({ Color = {0.5,1,0.8,1}, Id = components.MetaUpgradeCardArt.Id })
			SetColor({ Color = {0.5,1,0.8,1}, Id = selectedButton.CardCornersId })
			SetColor({ Color = {0,0,0,1}, Id = components.MetaUpgradeCardArt.Id, Duration = 2, EaseIn = 0.99, EaseOut = 1 })
			SetColor({ Color = {0,0,0,1}, Id = selectedButton.CardCornersId, Duration = 2, EaseIn = 0.99, EaseOut = 1 })

		else
			ScreenCantAffordPresentation( screen, selectedButton, metaUpgradeData.ResourceCost )
		end
	end
	UpdateMetaUpgradeCardInteractionText( screen, selectedButton )
	DoMetaUpgradeCardReveal( screen, { SelectedButton = selectedButton, ZoomOutDelay = zoomOutDelay, RevealedCardCoords = revealCardData, AutoEquipFailed = expandPsyche })
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
	local targetButton = button
	if button.RedirectClick then
		targetButton = screen.Components[button.RedirectClick]
	end
	if not MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ] then
		CannotAffordMetaUpgradeLimitPresentation( screen, targetButton )
		return
	end

	local nextCostData = MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ].ResourceCost
	if nextCostData then
		if HasResources(nextCostData) then
		
			RemoveStoreItemPin( "MetaUpgradeLevelData".. GetCurrentMetaUpgradeLimitLevel() + 1, { Purchase = true } )
			RemoveStoreItemPinPresentation( targetButton )

			UpgradeMetaUpgradeLimitPresentation( screen, targetButton )
			for resourceName, resourceCost in pairs( nextCostData ) do
				SpendResource( resourceName, resourceCost, "IncreaseCardLimit", { TargetId = screen.Components["ResourceIconBacking"..resourceName].Id, UseScreenLocation = true, TextOffsetY = 11, TextAnchorOffsetY = -80, SkipQuestStatusCheck = true } )
			end
			IncrementTableValue( GameState, "MetaUpgradeLimitLevel", 1 )
			MouseOverMetaUpgradeCardLimit( targetButton )
			UpdateAffordabilityStatus()
			StopAnimation({ Name = "MEMCanAffordBadge", DestinationId = targetButton.Id })

			CheckAchievement( screen, { Name = "AchMaxMem" } )

		else
			ScreenCantAffordPresentation( screen, targetButton, nextCostData)
		end
	else
		CannotAffordMetaUpgradeLimitPresentation( screen, targetButton )
	end
end

function MouseOverMetaUpgradeCardLimit( button )
	local screen = button.Screen
	if not screen or not screen.KeepOpen then
		return
	end
	local components = screen.Components

	GenericMouseOverPresentation( button )
	local nextCostData = MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ]
	if nextCostData then
		MouseOverMetaUpgradeLimitPresentation( screen, components.MemCostModule )
		ModifyTextBox({ Ids = { components.CurrentCostText.Id, components.SlashText.Id, components.MaxCostText.Id}, ScaleTarget = screen.MouseoverMemScale, ScaleDuration = 0.1 })
		SetAnimation({ Name = "MetaUpgradeGhostHandFxSelectedIn", DestinationId = components.MemCostModuleBackingFx.Id })
		StopAnimation({ Names = { "MetaUpgradeHandLargeGlowIn", "MetaUpgradeHandLargeGlowLoop" }, DestinationId = components.MemCostModuleBackingFx.Id })
		CreateAnimation({ Name = "MetaUpgradeHandLargeGlowIn", DestinationId = components.MemCostModuleBackingFx.Id, Group = "Combat_Menu_Overlay_Additive" })
		Move({ Id = components.MemCostModule.Id, DestinationId = components.MemCostModuleHoverTarget.Id, Duration = 0.1})
	end

	button.Screen.SelectedButton = button
	
	SetAlpha({ Id = components.CardHoverFrame.Id, Fraction = 0, Duration = 0.1 })
	SetAlpha({ Id = components.MemHighlightFrame.Id, Fraction = 1, Duration = 0.1 })
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	SetAnimation({ Name = "Blank", DestinationId = components.MetaUpgradeCardArtPatch.Id })


	if components.MetaUpgradeCardMaxLevel then
		ModifyTextBox({ Id = components.MetaUpgradeCardMaxLevel.Id, Text = " " })
	end
	DestroyTextBox({ Ids = screen.CostIds })
	
	SetAlpha({ Id = components.MetaUpgradeCardTitle.Id, Fraction = 1, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardText.Id, Fraction = 1, Duration = 0.2 })
	if components.MetaUpgradeCardFlavorText then
		components.MetaUpgradeCardFlavorText.Text = button.FlavorText
		DestroyTextBox({ Id = components.MetaUpgradeCardFlavorText.Id })
		CreateTextBox( MergeTables({ Id = components.MetaUpgradeCardFlavorText.Id, Text = button.FlavorText }, screen.CardFlavorTextArgs))
	end

	local nextMetaUpgradeLevel = MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ]
	if not nextMetaUpgradeLevel then
		SetAnimation({ DestinationId = components.MetaUpgradeCardArt.Id, Name = "Blank" })	
		ModifyTextBox({ Id = components.MetaUpgradeCardTitle.Id, Text = "IncreaseMetaUpgradeCard" })
		ModifyTextBox({ Id = components.MetaUpgradeCardText.Id, Text = "Max_MetaUpgrade" })
		if components.MetaUpgradeCardFlavorText  then
			SetAlpha({ Id = components.MetaUpgradeCardFlavorText.Id, Fraction = 1, Duration = 0.2 })
			ModifyTextBox({ Id = components.MetaUpgradeCardFlavorText.Id, Text = "Max_MetaUpgrade_FlavorText01" })
		end
		if components.MetaUpgradeCardAutoEquipText then
			ModifyTextBox({ Id = components.MetaUpgradeCardAutoEquipText.Id, Text = " " })
			components.MetaUpgradeCardAutoEquipText.Text = nil
		end
	else
		nextCostData = nextMetaUpgradeLevel.ResourceCost
		if nextCostData then
			SetAnimation({ DestinationId = components.MetaUpgradeCardArt.Id, Name = "DevBacking" })
			SetHSV({ Id = components.MetaUpgradeCardArt.Id, HSV = {0, -1, -0.1}, ValueChangeType = "Absolute" })
			UpdateMetaUpgradeCostText( screen, nextMetaUpgradeLevel.CostIncrease  )
			AddResourceCostDisplay( screen, nextCostData, screen.CostDisplay )
			ModifyTextBox({ Id = components.MetaUpgradeCardTitle.Id, Text = "IncreaseMetaUpgradeCard" })
			ModifyTextBox({ Id = components.MetaUpgradeCardText.Id, Text = "IncreaseMetaUpgradeCard", UseDescription = true, LuaKey = "TempTextData", LuaValue = { Amount = nextMetaUpgradeLevel.CostIncrease}})	
			
			if components.MetaUpgradeCardAutoEquipText then
				ModifyTextBox({ Id = components.MetaUpgradeCardAutoEquipText.Id, Text = " " })
				components.MetaUpgradeCardAutoEquipText.Text = nil
			end
			if components.MetaUpgradeCardFlavorText then
				ModifyTextBox({ Id = components.MetaUpgradeCardFlavorText.Id, Text = " " })
				components.MetaUpgradeCardFlavorText.Text = nil
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
	ModifyTextBox({ Ids = { components.CurrentCostText.Id, components.SlashText.Id, components.MaxCostText.Id}, ScaleTarget = 1, ScaleDuration = 0.1 })
	
	SetAnimation({ Name = "MetaUpgradeGhostHandFxSelectedOut", DestinationId = components.MemCostModuleBackingFx.Id })
	StopAnimation({ Names = { "MetaUpgradeHandLargeGlowIn", "MetaUpgradeHandLargeGlowLoop" }, DestinationId = components.MemCostModuleBackingFx.Id })
	Move({ Id = components.MemCostModule.Id, DestinationId = components.MemCostModuleBaseTarget.Id, Duration = 0.1})

	UpdateMetaUpgradeCostText( screen )
	
	SetAnimation({ DestinationId = components.MetaUpgradeCardArt.Id, Name = "DevBacking" })
	ModifyTextBox({ Id = components.MetaUpgradeCardTitle.Id, Text = " " })
	ModifyTextBox({ Id = components.MetaUpgradeCardText.Id, Text = " " })
	SetAlpha({ Id = components.CardHoverFrame.Id, Fraction = 1, Duration = 0.1 })
	SetAlpha({ Id = components.MemHighlightFrame.Id, Fraction = 0, Duration = 0.1 })
	SetAlpha({ Id = components.MetaUpgradeCardFlavorText.Id, Fraction = 0, Duration = 0.1 })

	UpdateMetaUpgradeCardInteractionText( screen )
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })
	screen.SelectedButton = nil
end


function NoMetaUpgradeCardsUnlocked()
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if metaUpgradeData.Unlocked then
			return false
		end
	end
	return true

end
function ShouldShowMetaUpgradeCapacityHint( screen )
	-- Ignore if Queen or Judgement are active
	if ( GameState.MetaUpgradeState.BonusRarity and GameState.MetaUpgradeState.BonusRarity.Equipped ) 
		or ( GameState.MetaUpgradeState.CardDraw and GameState.MetaUpgradeState.CardDraw.Equipped ) then
		return false
	end

	-- Ignore if Sorceress deactivated and you have 16+ grasp
	if GameState.MetaUpgradeState.ChanneledCast and not GameState.MetaUpgradeState.ChanneledCast.Equipped and GetMaxMetaUpgradeCost() >= 16 then
		return false
	end
	
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
				
				if GameState.WorldUpgrades.WorldUpgradePinning then
					--table.insert( textData, "MetaUpgrade_Pin" )
					canPin = true
				end
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

			if IsGameStateEligible( screen, MetaUpgradeSwapGameStateRequirement ) then
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
		components.SelectButton.Visible = true
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		components.SelectButton.Visible = false
	end

	if MetaUpgradeCardScreenCanSwapLayoutArt( screen ) then
		ModifyTextBox({ Id = components.PinButton.Id, Text = components.PinButton.AltTexts[1] })
		SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
		screen.Components.PinButton.Visible = true
		if not GameState.ScreensViewed.LayoutSetSwap and not screen.FirstTimeLayoutSetSwapPresentation then
			thread( PulseContextActionPresentation, screen.Components.PinButton, { ThreadName = "SwapLayoutArtPulse", InitialWait = 0.5, PulseOnce = true } )
			screen.FirstTimeLayoutSetSwapPresentation = true
		end
	elseif canPin then
		ModifyTextBox({ Id = components.PinButton.Id, Text = components.PinButton.Text })
		SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
	
	if components.UpgradeModeButton and screen.Name ~= "MetaUpgradeCardUpgradeLayout" then
		if CanUpgradeCards() then
			SetAlpha({ Id = components.UpgradeModeButton.Id, Fraction = 1.0, Duration = 0.2 })
			ModifyTextBox({ Id = components.UpgradeModeButton.Id, LuaKey = "TempTextData", LuaValue = {Amount = GetResourceAmount("CardUpgradePoints")} })
			components.UpgradeModeButton.Visible = true
			if not GameState.Flags.HasUpgradedCards and not screen.FirstTimeUpgradeCardPresentation then
				thread( PulseContextActionPresentation, components.UpgradeModeButton, { InitialWait = 1.0, Color = Color.Gold, PulseOnce = true, ThreadName = "FirstUpgradeCardPresentation" } )
				screen.FirstTimeUpgradeCardPresentation = true
			elseif GetResourceAmount("CardUpgradePoints") >= 10 and HasAffordableMetaUpgradeUpgrade() and not screen.UpgradeAffordableCardPresentation  then
				thread( PulseContextActionPresentation, components.UpgradeModeButton, { InitialWait = 1.0, Color = Color.Gold, PulseOnce = true, ThreadName = "UpgradeCardPresentation" } )
				screen.UpgradeAffordableCardPresentation = true
			end
		else
			SetAlpha({ Id = components.UpgradeModeButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
	end
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
	if screen.RevealingCards > 0  then
		return
	end
	if screen.SwappingLayoutArtIndex ~= nil then
		MetaUpgradeCardScreenLayoutSetSwapClose( screen )
		return
	end
	killTaggedThreads( "SelectButtonPulse" )
	local exitCanceled = false
	local closeDelay = 0
	if not args.UpgradeTransition then 
		if NoMetaUpgradeCardsUnlocked() then
			OpenNoUpgradeInfoScreen( screen )
			if not screen.Exit then
				exitCanceled = true
			end
		end
		if ShouldShowMetaUpgradeCapacityHint( screen ) then
			OpenBelowLimitScreen( screen )
			if not screen.Exit then
				exitCanceled = true
			end
		end
		if exitCanceled then
			MetaUpgradeCardScreenResetCursor( screen )
			return
		end
		
		closeDelay = 0.15
		thread( CloseMetaUpgradeCardScreenPresentation, screen )
	end
	RecordMetaUpgradeChanges( screen )
	UpdateEscapeDoorForLimitGraspShrineUpgrade( nil, { EscapeDoorIds = { 420947, 555784 } } )
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

	StopAnimation({ Names = { "MetaUpgradeHandLargeGlowIn", "MetaUpgradeHandLargeGlowLoop" }, DestinationId = screen.Components.MemCostModuleBackingFx.Id })

	local ids = GetAllIds( screen.Components )
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
		
			local button = screen.Components[GetMetaUpgradeKey( row, column )]
			if button then
				table.insert( ids, button.CardArtId )
				table.insert( ids, button.CardCornersId )
				table.insert( ids, button.UpgradeIconId )
				table.insert( ids, button.RarityBadgeId )
				table.insert( ids, button.EquippedHighlightId )
				table.insert( ids, button.PinButtonId )
				table.insert( ids, button.CostTextId )
			end
		end
	end
	for _, id in pairs(screen.CostRingIds) do
		table.insert( ids, id )
	end
	for _, id in pairs(screen.CostPipIds) do
		table.insert( ids, id )
	end
	table.insert( ids, screen.Components.MemCostModule.PinButtonId )
	OnScreenCloseStarted( screen )

	if screen.ChangeMade and GameState.CompletedObjectiveSets.CardPrompt then
		RequestPreRunLoadoutChangeSave()
	end

	CloseScreen( ids, closeDelay )
	
	if not args.UpgradeTransition then
		for weaponName, v in pairs( WeaponSetLookups.HeroSecondaryWeaponsLinked ) do
			if MapState.EquippedWeapons[weaponName] then
				SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true  })
			end
		end
	end
	SetPlayerVulnerable( screen.Name )
	UpdateMetaUpgradeUnlockedCountCache()
	OnScreenCloseFinished( screen )
	
	if not args.IgnoreAspectRatioFrame then
		AltAspectRatioFramesHide()
	end
	ShowCombatUI( screen.Name )
	if not args.UpgradeTransition then
		UseableOn({ Id = screen.SourceId })
		if MapState.FamiliarUnit ~= nil then
			RemoveInteractBlock( MapState.FamiliarUnit, "CardScreen" )
		end
		if screen.StartingHealth ~= CurrentRun.Hero.MaxHealth then
			thread( MaxHealthChangedPresentation, CurrentRun.Hero.MaxHealth > screen.StartingHealth, 0.3)
		end
		if screen.StartingMana ~= CurrentRun.Hero.MaxMana then
			thread( MaxManaChangedPresentation, CurrentRun.Hero.MaxMana > screen.StartingMana, 0.3 )
		end
	end
	UpdateRerollUI( CurrentRun.NumRerolls )
	ValidateMaxHealth()
	ValidateMaxMana()
	if not IsGameStateEligible( screen, { { FunctionName = "RequireAffordableMetaUpgrade" } } ) then
		StopCurrentStatusAnimation( screen.OpenedFrom )
	end

	if not NoMetaUpgradeCardsUnlocked() then
		thread( MarkObjectiveComplete, "CardPrompt" )
	end

	local showLastStandState = false
	if SessionState.MetaUpgradeChanges.CardData.LowHealthBonus and SessionState.MetaUpgradeChanges.CardData.LowHealthBonus.Equipped then
		-- Equipping Strength always prompts the text	
		showLastStandState = true
	end
	if GameState.MetaUpgradeState.LowHealthBonus.Equipped and SessionState.MetaUpgradeChanges.CardData and SessionState.MetaUpgradeChanges.CardData.LastStand and SessionState.MetaUpgradeChanges.CardData.LastStand.Unequipped and not HasLastStand(CurrentRun.Hero) then	
		-- If Strength is equipped and you unequip Death to the point that you activate Strength, show the text
		showLastStandState = true
	end
	if GameState.MetaUpgradeState.LowHealthBonus.Equipped and SessionState.MetaUpgradeChanges.CardData and SessionState.MetaUpgradeChanges.CardData.LastStand and SessionState.MetaUpgradeChanges.CardData.LastStand.Equipped and not screen.StartingHasLastStand then	
		-- If Strength is equipped and you equip Death and it was your first source of DDs, show the text
		showLastStandState = true
	end
	local delay = 0
	if showLastStandState then
		thread( LowHealthBonusBuffStatePresentation )
		delay = delay + 0.5
	end
	
	if FatedEnableKeepsakes[GameState.LastAwardTrait] and screen.StartingFateValid ~= PreRunIsFateValid() then
		thread( FatedValidityStatePresentation, delay )
	end
end

function UpdateMetaUpgradeCardState( screen, origButton )
	CheckAutoEquipCards( screen )
	CheckAutoEquipCards( screen )
	UpdateMetaUpgradeCardAdjacencyBonuses()
	if origButton then
		SelectMetaUpgradeButton( screen, origButton )
		UpdateMetaUpgradeCostDisplay( screen, origButton )
	end
	-- Specific death defiance dependencies

	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
		
			local button = screen.Components[GetMetaUpgradeKey( row, column )]
			if button then
				UpdateMetaUpgradeCardAnimation( button )
				if origButton.CardName == "LastStand" and button.CardName == "LowHealthBonus" then
					UpdateMetaUpgradeCard( screen, row, column, true )
				end
			end
		end
	end
end

function HandleCardSwapInput( screen )

	while screen.KeepOpen do
		NotifyOnControlPressed({ Names = {"Attack3"}, Notify = "CardSwapInput" })
		waitUntil( "CardSwapInput" )
		if IsGameStateEligible( screen, MetaUpgradeSwapGameStateRequirement ) then
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
	return IsGameStateEligible( nil, ScreenData.MetaUpgradeCardUpgradeLayout.GameStateRequirements )
end

function EnterUpgradeMode( screen, button )
	if not CanUpgradeCards() then
		return
	end
	if screen.SwappingLayoutArtIndex ~= nil then
		return
	end
	if screen.EnteringUpgradeMode or ScreenState.InTransition then
		return
	end
	screen.EnteringUpgradeMode = true
	ScreenState.InTransition = true
	AddInputBlock({ Name = "EnterUpgradeMode" })

	thread( PlayVoiceLines, GlobalVoiceLines.SwitchToUpgradeCardModeVoiceLines, true )
	FadeOut({ Color = Color.Black, Duration = 0.1 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TarotCardsShuffle" })
	wait( 0.1 )
	-- Immediately close the regular mode screen under full black
	CloseMetaUpgradeCardScreen( screen, { UpgradeTransition = true, IgnoreAspectRatioFrame = true, FadeOutTime = 0.0 } )
	StopAnimation({ Names = { "MetaUpgradeHandLargeGlowIn", "MetaUpgradeHandLargeGlowLoop" }, DestinationId = screen.Components.MemCostModuleBackingFx.Id })
	wait( 0.1 ) -- Wait for cleanup and Bink to finish
	-- Now can create the upgrade mode screen and fade in
	if screen.SelectedButton then
		thread( OpenMetaUpgradeCardUpgradeScreen, screen.OpenedFrom, { StartingHealth = screen.StartingHealth, StartingMana = screen.StartingMana, LastMouseOffButtonCardName = screen.LastMouseOffButtonCardName, HighlightedCardName = screen.SelectedButton.CardName })
	else
		thread( OpenMetaUpgradeCardUpgradeScreen, screen.OpenedFrom, { StartingHealth = screen.StartingHealth, StartingMana = screen.StartingMana, LastMouseOffButtonCardName = screen.LastMouseOffButtonCardName })
	end	
	FadeIn({ Duration = 0 })
	RemoveInputBlock({ Name = "EnterUpgradeMode" })
	FullScreenFadeInAnimationReroll()
	wait( 1.05 )

	ScreenState.InTransition = false
end

function SaveCurrentMetaUpgradeSet()
	GameState.SavedMetaUpgradeLayouts[GameState.CurrentMetaUpgradeLayout] = {}
	for metaUpgradeName, metaUpgradeState in pairs( GameState.MetaUpgradeState ) do
		if GameState.MetaUpgradeState[metaUpgradeName].Equipped then
			GameState.SavedMetaUpgradeLayouts[GameState.CurrentMetaUpgradeLayout][metaUpgradeName] = true
		end
	end
end
function LoadCurrentMetaUpgradeSet( screen, button )
	for metaUpgradeName, metaUpgradeState in pairs( GameState.MetaUpgradeState ) do
		if GameState.MetaUpgradeState[metaUpgradeName].Equipped then
			GameState.MetaUpgradeState[metaUpgradeName].Equipped = nil
		end
	end
	if not IsEmpty(GameState.SavedMetaUpgradeLayouts[GameState.CurrentMetaUpgradeLayout]) then
		for metaUpgradeName in pairs( GameState.SavedMetaUpgradeLayouts[GameState.CurrentMetaUpgradeLayout] ) do
			GameState.MetaUpgradeState[metaUpgradeName].Equipped = true
		end
	end
	
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
		
			local button = screen.Components[GetMetaUpgradeKey( row, column )]
			if button then
				UpdateMetaUpgradeCardAnimation( button )
			end
		end
	end
	UpdateMetaUpgradeCostText( screen )
end

function MetaUpgradeCardScreenSelectLayout( screen, button )

	SaveCurrentMetaUpgradeSet()

	GameState.PrevMetaUpgradeLayout = GameState.CurrentMetaUpgradeLayout
	GameState.CurrentMetaUpgradeLayout = button.MetaUpgradeLayoutNum

	if GameState.CurrentMetaUpgradeLayout ~= GameState.PrevMetaUpgradeLayout then
		MetaUpgradeCardScreenLayoutChangeOut( screen, button )
		LoadCurrentMetaUpgradeSet( screen, button )
		MetaUpgradeCardScreenUpdateLayoutSets( screen, button )
		MetaUpgradeCardScreenLayoutChangeIn( screen, button )
	end
end

function MetaUpgradeCardScreenNextLayout( screen, button )
	
	if screen.SwappingLayoutArtIndex ~= nil then
		return
	end

	SaveCurrentMetaUpgradeSet()

	GameState.CurrentMetaUpgradeLayout = GameState.CurrentMetaUpgradeLayout + 1
	if GameState.CurrentMetaUpgradeLayout > MetaUpgradeSaveLayoutData.MaximumMetaUpgradeLayouts then
		GameState.CurrentMetaUpgradeLayout = 1
	end

	MetaUpgradeCardScreenLayoutChangeOut( screen, button )
	LoadCurrentMetaUpgradeSet( screen, button )
	MetaUpgradeCardScreenUpdateLayoutSets( screen, button )
	MetaUpgradeCardScreenLayoutChangeIn( screen, button )
end

function MetaUpgradeCardScreenPrevLayout( screen, button )
	
	if screen.SwappingLayoutArtIndex ~= nil then
		return
	end

	SaveCurrentMetaUpgradeSet()

	GameState.CurrentMetaUpgradeLayout = GameState.CurrentMetaUpgradeLayout - 1
	if GameState.CurrentMetaUpgradeLayout < 1 then
		GameState.CurrentMetaUpgradeLayout = MetaUpgradeSaveLayoutData.MaximumMetaUpgradeLayouts
	end
	
	MetaUpgradeCardScreenLayoutChangeOut( screen, button )
	LoadCurrentMetaUpgradeSet( screen, button )
	MetaUpgradeCardScreenUpdateLayoutSets( screen, button )
	MetaUpgradeCardScreenLayoutChangeIn( screen, button )
end

function MetaUpgradeCardScreenCanSwapLayoutArt( screen )
	if GameState.WorldUpgradesAdded.Cosmetic_CardDeck01 then
		if not GetConfigOptionValue({ Name = "UseMouse" }) or screen.LastMouseOverLayout ~= nil then
			return true
		end
	end
	return false
end

function MetaUpgradeCardScreenPinItem( screen, button )
	
	
	if MetaUpgradeCardScreenCanSwapLayoutArt( screen ) then
		MetaUpgradeCardScreenLayoutSetSwapOpen( screen, button )
		return
	end
	if screen.SelectedButton == nil then
		return
	end
	local selectedButton = screen.SelectedButton
	if screen.SelectedButton.RedirectClick == "MemCostModule" then
		selectedButton = screen.Components.MemCostModule
	end
	if selectedButton.CardName == button.Screen.LastMouseOffButtonCardName and selectedButton.Name ~= "MetaUpgradeMemCostBacking" then
		return
	end
	if not GameState.WorldUpgrades.WorldUpgradePinning then
		return
	end
	if selectedButton.CardState ~= "LOCKED" and selectedButton.Name ~= "MetaUpgradeMemCostBacking" then
		return
	end
	local itemName = selectedButton.CardName
	local storeName = "MetaUpgradeCardData"
	if selectedButton.Name == "MetaUpgradeMemCostBacking" then
		if MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1] == nil then
			return
		end
		itemName = "MetaUpgradeLevelData".. GetCurrentMetaUpgradeLimitLevel() + 1
		storeName = "MetaUpgradeCostDataStore"
	end
	if HasStoreItemPin( itemName ) then
		RemoveStoreItemPin( itemName )
		RemoveStoreItemPinPresentation( selectedButton )
	else
		AddStoreItemPin( itemName, storeName )
		AddStoreItemPinPresentation( selectedButton, { AnimationName = "MetaUpgradeItemPin" })
	end
end

function MetaUpgradeCardScreenLayoutSetSwapOpen( screen, button )
	if screen.SwappingLayoutArtIndex ~= nil then
		return
	end
	HideTopMenuScreenTooltips({ })
	GameState.ScreensViewed.LayoutSetSwap = true
	screen.SwappingLayoutArtIndex = screen.LastMouseOverLayout or GameState.CurrentMetaUpgradeLayout
	SetAlpha({ Id = screen.Components.LayoutArtSwapBackground.Id, Fraction = screen.LayoutSetArtOptionsBackgroundOpacity, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.LayoutArtSwapActionBarBackground.Id, Fraction = 1.0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.LayoutArtSwapCloseButton.Id, Fraction = 1.0, Duration = 0.2 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelInURSA" })

	UseableOn({ Id = screen.Components.LayoutArtSwapCloseButton.Id })
	screen.Components.CloseButton.ControlHotkeys = nil
	screen.Components.LayoutArtSwapCloseButton.ControlHotkeys = { "Cancel" }
	SetAlpha({ Id = screen.Components.LayoutArtSwapSelectionHighlight.Id, Fraction = 1.0, Duration = 0.2 })
	SetScale({ Id = screen.Components.LayoutArtSwapSelectionHighlight.Id, Fraction = screen.LayoutSetArtOptionsScale, Duration = 0.0 })
	SetAnimation({ DestinationId = screen.Components.LayoutArtSwapSelectionHighlight.Id, Name = screen.Components.LayoutArtSwapSelectionHighlight.AnimationName })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = screen.Components.LayoutArtSwapBackground.GroupName })
	local locationX = screen.LayoutSetArtOptionsStartX + ScreenCenterNativeOffsetX
	local locationY = screen.LayoutSetArtOptionsStartY + ScreenCenterNativeOffsetY
	local numOptions = 0
	for i, option in ipairs( screen.LayoutSetArtOptions ) do
		if option.GameStateRequirements == nil or IsGameStateEligible( option, option.GameStateRequirements ) then
			numOptions = numOptions + 1
			local layoutSetArtOption = CreateScreenComponent({ 
				Name = "BlankInteractableObstacle",
				X = locationX,
				Y = locationY,
				Group = screen.Components.LayoutArtSwapBackground.GroupName,
				Scale = screen.LayoutSetArtOptionsScale,
				Animation = "DeckArt_"..GetTwoDigitString( option.TextureNum ),
			})
			layoutSetArtOption.OptionNum = i
			layoutSetArtOption.TextureNum = option.TextureNum
			layoutSetArtOption.Screen = screen
			layoutSetArtOption.OnMouseOverFunctionName = "MouseOverLayoutSetArt"
			layoutSetArtOption.OnMouseOffFunctionName = "MouseOffLayoutSetArt"
			layoutSetArtOption.OnPressedFunctionName = "SelectLayoutSetArt"
			screen.Components["LayoutSetArtOption"..i] = layoutSetArtOption

			-- mark unviewed resources as "new"
			if not GameState.LayoutSetArtViewed[option.TextureNum] then
				local newIcon = CreateScreenComponent({ Name = "BlankObstacle", Animation = "MusicPlayerNewTrack",
					X = locationX + screen.LayoutSetArtOptionsNewIconOffsetX,
					Y = locationY + screen.LayoutSetArtOptionsNewIconOffsetY,
					Group = screen.Components.LayoutArtSwapBackground.GroupName,
					Scale = screen.NewItemStarScale, 
					Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2,
				})	
				layoutSetArtOption.NewIcon = newIcon
				screen.Components["LayoutSetArtNewIcon"..i] = newIcon
			end

			if (GameState.MetaUpgradeLayoutsArt[screen.SwappingLayoutArtIndex] or 1) == option.TextureNum then
				Teleport({ Id = screen.Components.LayoutArtSwapSelectionHighlight.Id, DestinationId = layoutSetArtOption.Id })
				TeleportCursor({ DestinationId = layoutSetArtOption.Id, ForceUseCheck = true })
			end

			if numOptions % screen.LayoutSetArtOptionsNumColumns == 0 then
				locationX = screen.LayoutSetArtOptionsStartX + ScreenCenterNativeOffsetX
				locationY = locationY + screen.LayoutSetArtOptionsSpacingY
			else
				locationX = locationX + screen.LayoutSetArtOptionsSpacingX
			end
		end
	end
end

function MouseOverLayoutSetArt( button )
	local screen = button.Screen
	if screen.SwappingLayoutArtClosing then
		return
	end
	GameState.LayoutSetArtViewed[button.TextureNum] = true
	SetAnimation({ DestinationId = button.Id, Name = "DeckArt_Mouseover_"..GetTwoDigitString( button.TextureNum ) })
	SetScale({ Id = button.Id, Fraction = screen.LayoutSetArtOptionsMouseOverScale, Duration = screen.LayoutSetArtOptionsScaleDuration })
	if (GameState.MetaUpgradeLayoutsArt[screen.SwappingLayoutArtIndex] or 1) == button.TextureNum then
		SetAnimation({ DestinationId = screen.Components.LayoutArtSwapSelectionHighlight.Id, Name = "DeckArt_Mouseover_Selected" })
		SetScale({ Id = screen.Components.LayoutArtSwapSelectionHighlight.Id, Fraction = screen.LayoutSetArtOptionsMouseOverScale, Duration = screen.LayoutSetArtOptionsScaleDuration })
	end	
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = screen.Components.LayoutArtSwapSelectionHighlight.Id })
	SetAlpha({ Id = screen.Components.LayoutArtSwapSelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	if button.NewIcon ~= nil then
		SetAlpha({ Id = button.NewIcon.Id, Fraction = 0.0, Duration = 0.2 })
	end
end

function MouseOffLayoutSetArt( button )
	local screen = button.Screen
	SetAnimation({ DestinationId = button.Id, Name = "DeckArt_"..GetTwoDigitString( button.TextureNum ) })
	SetScale({ Id = button.Id, Fraction = screen.LayoutSetArtOptionsScale, Duration = screen.LayoutSetArtOptionsScaleDuration })
	if (GameState.MetaUpgradeLayoutsArt[screen.SwappingLayoutArtIndex] or 1) == button.TextureNum then
		SetAnimation({ DestinationId = screen.Components.LayoutArtSwapSelectionHighlight.Id, Name = "DeckArt_Selected" })
		SetScale({ Id = screen.Components.LayoutArtSwapSelectionHighlight.Id, Fraction = screen.LayoutSetArtOptionsScale, Duration = screen.LayoutSetArtOptionsScaleDuration })
	end	
	SetAlpha({ Id = screen.Components.LayoutArtSwapSelectButton.Id, Fraction = 0.0, Duration = 0.2 })
end

function SelectLayoutSetArt( screen, button )
	GameState.MetaUpgradeLayoutsArt[screen.SwappingLayoutArtIndex] = button.TextureNum
	Teleport({ Id = screen.Components.LayoutArtSwapSelectionHighlight.Id, DestinationId = button.Id })
	SetAnimation({ DestinationId = screen.Components.LayoutArtSwapSelectionHighlight.Id, Name = "DeckArt_Mouseover_Selected" })
	SetScale({ Id = screen.Components.LayoutArtSwapSelectionHighlight.Id, Fraction = screen.LayoutSetArtOptionsMouseOverScale, Duration = 0.0 })
	-- this sound should not repeat when selecting an already-selected backing
	PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuSwitch", Id = screen.Components.LayoutArtSwapSelectionHighlight.Id })
	MetaUpgradeCardScreenUpdateLayoutSets( screen, button )
end

function MetaUpgradeCardScreenLayoutSetSwapClose( screen, button )
	screen.SwappingLayoutArtClosing = true
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	SetAlpha({ Id = screen.Components.LayoutArtSwapBackground.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.LayoutArtSwapActionBarBackground.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.LayoutArtSwapCloseButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.LayoutArtSwapSelectButton.Id, Fraction = 0.0, Duration = 0.2 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelOutURSA" })

	UseableOff({ Id = screen.Components.LayoutArtSwapCloseButton.Id })
	screen.Components.CloseButton.ControlHotkeys = { "Cancel" }
	screen.Components.LayoutArtSwapCloseButton.ControlHotkeys = nil 
	SetAlpha({ Id = screen.Components.LayoutArtSwapSelectionHighlight.Id, Fraction = 0.0, Duration = 0.2 })
	SetScale({ Id = screen.Components.LayoutArtSwapSelectionHighlight.Id, Fraction = screen.LayoutSetArtOptionsScale, Duration = 0.05 })
	for i, option in ipairs( screen.LayoutSetArtOptions ) do
		local layoutSetArtOption = screen.Components["LayoutSetArtOption"..i]
		if layoutSetArtOption ~= nil then
			SetAlpha({ Id = layoutSetArtOption.Id, Fraction = 0.0, Duration = 0.2 })
			UseableOff({ Id = layoutSetArtOption.Id })
			if layoutSetArtOption.NewIcon ~= nil then
				SetAlpha({ Id = layoutSetArtOption.NewIcon.Id, Fraction = 0.0, Duration = 0.2 })
			end
		end
	end
	wait( 0.2 )	
	for i, option in ipairs( screen.LayoutSetArtOptions ) do
		local layoutSetArtOption = screen.Components["LayoutSetArtOption"..i]
		if layoutSetArtOption ~= nil then
			Destroy({ Id = layoutSetArtOption.Id })
			if layoutSetArtOption.NewIcon ~= nil then
				Destroy({ Id = layoutSetArtOption.NewIcon.Id })
			end
		end
	end
	screen.SwappingLayoutArtIndex = nil
	screen.SwappingLayoutArtClosing = nil
	MetaUpgradeCardScreenResetCursor( screen )
end