function OpenMetaUpgradeCardUpgradeScreen( source, args )
	args = args or {}
	ScreenAnchors.UpgradeMetaUpgradeScreen = DeepCopyTable( ScreenData.MetaUpgradeCardUpgradeLayout)
	local screen = ScreenAnchors.UpgradeMetaUpgradeScreen
	local components = screen.Components
	
	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	screen.ZoomLevel = GetZoomLevel()
	screen.KeepOpen = true
	
	screen.SourceId = source.ObjectId
	screen.OpenedFrom = source
	screen.UpgradedMetaUpgrades = {}
	screen.CostDisplay.StartX = screen.CostDisplay.StartX + ScreenCenterNativeOffsetX
	screen.CostDisplay.StartY = screen.CostDisplay.StartY + ScreenCenterNativeOffsetY
	CreateScreenFromData( screen, screen.ComponentData )
	UpdateMetaUpgradeCostText( screen ) 
	CreateMetaUpgradeCards( screen, { UpgradeStoreNames = true, ActionFunctionName = "UpgradeMetaUpgradeCardAction", HighlightFunctionName = "MouseOverUpgradeMetaUpgrade", Autoselect = args.HighlightedCardName  } )
	
	screen.LastMouseOffButtonCardName = args.LastMouseOffButtonCardName
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.5 })
	local scale = 5 / screen.ZoomLevel
	SetScale({ Id = components.CardHoverFrame.Id, Fraction = scale, Duration = 0})
	wait(0.5)
	
	screen.KeepOpen = true
	local validWeapons = ConcatTableValues( ShallowCopyTable(WeaponSets.HeroSecondaryWeapons), AddLinkedWeapons( WeaponSets.HeroSecondaryWeapons ))
	for _, weaponName in pairs( validWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	HandleScreenInput( screen )
end

function CloseUpgradeMetaUpgradeCardScreen( screen, args )
	local ids = GetAllIds( screen.Components )
	args = args or {}

	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
		
			local button = screen.Components[GetMetaUpgradeKey( row, column )]
			if button then
				table.insert( ids, button.CardArtId )
				table.insert( ids, button.CardCornersId )
				table.insert( ids, button.TypeIconId )
				table.insert( ids, button.EquippedHighlightId )
				table.insert( ids, button.UpgradeIconId )
				table.insert( ids, button.PinButtonId )
			end
		end
	end
	for _, id in pairs(screen.CostRingIds) do
		table.insert( ids, id )
	end
	local closeDelay = 0
	if not args.UpgradeTransition then 
		thread( CloseMetaUpgradeCardScreenPresentation, screen )
		closeDelay = 0.15
	end
	for metaUpgradeName in pairs( screen.UpgradedMetaUpgrades ) do
		if MetaUpgradeCardData[ metaUpgradeName ].TraitName then
			RemoveWeaponTrait(	MetaUpgradeCardData[ metaUpgradeName ].TraitName, { Silent = true })	
			local cardMultiplier = 1
			if GameState.MetaUpgradeState[ metaUpgradeName ].AdjacencyBonuses and GameState.MetaUpgradeState[ metaUpgradeName ].AdjacencyBonuses.CustomMultiplier then
				cardMultiplier = cardMultiplier + GameState.MetaUpgradeState[ metaUpgradeName ].AdjacencyBonuses.CustomMultiplier 
			end
			AddTraitToHero({ 
					SkipNewTraitHighlight = true, 
					SkipQuestStatusCheck = true,
					TraitName = MetaUpgradeCardData[ metaUpgradeName ].TraitName, 
					Rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( metaUpgradeName )], CustomMultiplier = cardMultiplier })
		end
	end
	UpdateRerollUI( CurrentRun.NumRerolls )
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
	UpdateMetaUpgradeUnlockedCountCache()
	OnScreenCloseFinished( screen )
	if not args.UpgradeTransition then
		UseableOn({ Id = screen.SourceId })
		if MapState.FamiliarUnit ~= nil then
			RemoveInteractBlock( MapState.FamiliarUnit, "CardScreen" )
		end
	end
	ShowCombatUI( screen.Name )
end

function ExitUpgradeMode( screen, button )
	thread( CloseUpgradeMetaUpgradeCardScreen, screen, { UpgradeTransition = true })
	if screen.SelectedButton then
		thread( OpenMetaUpgradeCardScreen, screen.OpenedFrom, { LastMouseOffButtonCardName = screen.LastMouseOffButtonCardName, HighlightedCardName = screen.SelectedButton.CardName } )
	else
		thread( OpenMetaUpgradeCardScreen, screen.OpenedFrom,  { LastMouseOffButtonCardName = screen.LastMouseOffButtonCardName } )
	end
	thread( ExitMetaUpgradeUpgradeModePresentation, screen )
end

function UpgradeMetaUpgradeCardAction( screen, button )
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
		if not MetaUpgradeAtMaxLevel( metaUpgradeName ) then
			local metaUpgradeData = MetaUpgradeCardData[metaUpgradeName]
			local resourceCost = metaUpgradeData.UpgradeResourceCost[ GetMetaUpgradeLevel( metaUpgradeName )]
			if HasResources( resourceCost ) then
				screen.ChangeMade = true
				SpendResources( resourceCost, metaUpgradeName, { SkipOverheadText = true } )
				UpdateAffordabilityStatus()

				RemoveStoreItemPin( selectedButton.CardName .. GetMetaUpgradeLevel( metaUpgradeName ), { Purchase = true } )
				RemoveStoreItemPinPresentation( selectedButton )
				IncrementTableValue(GameState.MetaUpgradeState[metaUpgradeName], "Level" )
				screen.UpgradedMetaUpgrades[metaUpgradeName] = true
				UpdateMetaUpgradeCardState( screen, selectedButton )
				
				UpgradeMetaUpgradeCardPresentation( selectedButton )
				if MetaUpgradeAtMaxLevel( metaUpgradeName ) then
					MetaUpgradeCardMaxLevelPresentation( selectedButton )
					SetAlpha({ Id = button.UpgradeIconId, Fraction = 0, Duration = 0.2 })
				end
				
				MouseOverUpgradeMetaUpgrade( selectedButton )
				if GetMetaUpgradeLevel( selectedButton.CardName ) > 1 then 
					SetAnimation({ DestinationId = selectedButton.TypeIconId, Name = "CardRarityPatch", OffsetX = -400 / screen.ZoomLevel, OffsetY = -500 / screen.ZoomLevel })
					local rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( selectedButton.CardName )]
					SetColor({ Id = selectedButton.TypeIconId, Color =  Color["BoonPatch"..rarity ]})
				end
				-- Update affordability state of all other cards
				for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
					for column, cardName in pairs( rowData ) do
						local otherButton = screen.Components[GetMetaUpgradeKey( row, column )]
						if not MetaUpgradeAtMaxLevel( cardName ) then
							local metaUpgradeData = MetaUpgradeCardData[cardName]
							local resourceCost = metaUpgradeData.UpgradeResourceCost[ GetMetaUpgradeLevel( cardName )]
							if not HasResources(resourceCost) then
								SetAlpha({ Id = otherButton.UpgradeIconId, Fraction = 0, Duration = 0.2 })
							end
						end
					end
				end
			else
				ScreenCantAffordPresentation( screen, selectedButton, resourceCost )
			end
		else
			CannotUpgradeMaxLevelMetaUpgradePresentation( screen, selectedButton )
		end
	else
		InvalidMetaUpgradeCardAction( screen, selectedButton )
	end
	UpdateUpgradeMetaUpgradeCardInteractionText( screen, selectedButton )
end

function MouseOverUpgradeMetaUpgrade( button )
	if button.Screen.ZoomInProgress or not button.Screen.KeepOpen then 
		return
	end
	if button.Screen.LastMouseOffButtonCardName == button.CardName then
		button.Screen.LastMouseOffButtonCardName = nil
	end

	local components = button.Screen.Components
	GenericMouseOverPresentation( button )
	Teleport({ Id = button.HoverFrameId, DestinationId = button.Id })
	UpdateUpgradeMetaUpgradeCardInteractionText( button.Screen, button )
	SelectMetaUpgradeButton( button.Screen, button )
	UpdateUpgradeMetaUpgradeCostDisplay( button.Screen, button )
	if button.CardState ~= "UNLOCKED" then
		ModifyTextBox({ Id = components.MetaUpgradeCardMaxLevel.Id, Text = " " })
		return
	end

	if not MetaUpgradeAtMaxLevel( button.CardName)  then
		local cardTitle = button.CardName
		local cardMultiplier = 1
		if GameState.MetaUpgradeState[ cardTitle ].AdjacencyBonuses and GameState.MetaUpgradeState[ cardTitle ].AdjacencyBonuses.CustomMultiplier then
			cardMultiplier = cardMultiplier + GameState.MetaUpgradeState[ cardTitle ].AdjacencyBonuses.CustomMultiplier
		end
		local cardData = {}
		if MetaUpgradeCardData[cardTitle].TraitName then
			cardData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = MetaUpgradeCardData[cardTitle].TraitName , Rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( cardTitle )], CustomMultiplier = cardMultiplier })
			local nextLevelCardData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = MetaUpgradeCardData[cardTitle].TraitName , Rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( cardTitle ) + 1], CustomMultiplier = cardMultiplier })
			SetTraitTextData( cardData, { ReplacementTraitData = nextLevelCardData })
		end
		if TraitData[MetaUpgradeCardData[cardTitle].TraitName].CustomUpgradeText then
			cardTitle = TraitData[MetaUpgradeCardData[cardTitle].TraitName].CustomUpgradeText
		end
		
		ModifyTextBox({ Id = components.MetaUpgradeCardText.Id, Text = cardTitle, UseDescription = true, LuaKey = "TooltipData", LuaValue = cardData })
		ModifyTextBox({ Id = components.MetaUpgradeCardMaxLevel.Id, Text = " " })
	else
		ModifyTextBox({ Id = components.MetaUpgradeCardMaxLevel.Id, Text = "MetaUpgrade_Max" })
	end
end

function UpdateUpgradeMetaUpgradeCardInteractionText( screen, button )

	local components = screen.Components

	local selectButtonText = nil
	local canPin = false

	--local textData = {}
	if button.Name == "MemCostModule" then
		if MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ] then
			--table.insert( textData, "MetaUpgradeMem_Upgrade" )
			selectButtonText = "MetaUpgradeMem_Upgrade"
		else
			--table.insert( textData, "Max_MetaUpgrade_Action" )
			selectButtonText = "Max_MetaUpgrade_Action"
		end
	elseif button.CardState == "UNLOCKED" and CanUpgradeMetaUpgrade( button.CardName) then
		--table.insert( textData, "MetaUpgradeMem_Upgrade" )
		selectButtonText = "MetaUpgradeMem_Upgrade"
		if GameState.WorldUpgrades.WorldUpgradePinning then
			--table.insert( textData, "MetaUpgrade_Pin" )
			canPin = true
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

	--table.insert( textData, "MetaUpgradeMem_ExitUpgradeMode")
	
	--table.insert( textData, "MetaUpgradeMem_Exit")
	
	--AddContextualAction( screen, textData )
end

function CanUpgradeMetaUpgrade( metaUpgradeName )
	return MetaUpgradeCardData[metaUpgradeName].UpgradeResourceCost and MetaUpgradeCardData[metaUpgradeName].UpgradeResourceCost[ GetMetaUpgradeLevel( metaUpgradeName )]
end

function MetaUpgradeAtMaxLevel( metaUpgradeName )
	-- The same thing for now
	return not CanUpgradeMetaUpgrade( metaUpgradeName )
end

function UpdateUpgradeMetaUpgradeCostDisplay( screen, button )
	local components = screen.Components
	if button.CardState == "UNLOCKED" then
		if CanUpgradeMetaUpgrade( button.CardName ) then 
			AddResourceCostDisplay( screen, MetaUpgradeCardData[button.CardName].UpgradeResourceCost[GetMetaUpgradeLevel( button.CardName )], screen.CostDisplay )
		end
		SetAlpha({ Id = components.MetaUpgradeResourceCostBacking.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.MetaUpgradeResourceCostBacking.Id, Fraction = 0.0, Duration = 0.2 })
	end
end
function MetaUpgradeCardUpgradeScreenPinItem( screen, button )
	if screen.SelectedButton == nil then
		return
	end
	if screen.SelectedButton.CardName == button.Screen.LastMouseOffButtonCardName then
		return
	end
	
	if not GameState.WorldUpgrades.WorldUpgradePinning then
		return
	end
	if screen.SelectedButton.CardState ~= "UNLOCKED" or not CanUpgradeMetaUpgrade( screen.SelectedButton.CardName) or screen.SelectedButton.Name == "MemCostModule" then
		return
	end
	local itemName = screen.SelectedButton.CardName
	if HasStoreItemPin( itemName.. GetMetaUpgradeLevel( itemName ) ) then
		RemoveStoreItemPin( itemName .. GetMetaUpgradeLevel( itemName ) )
		RemoveStoreItemPinPresentation( screen.SelectedButton )
	else
		AddStoreItemPin( itemName .. GetMetaUpgradeLevel( itemName ), "MetaUpgradeCardUpgradeData" )
		AddStoreItemPinPresentation( screen.SelectedButton, { AnimationName = "MetaUpgradeItemPin" })
	end
end