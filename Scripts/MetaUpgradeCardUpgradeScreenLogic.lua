function OpenMetaUpgradeCardUpgradeScreen( source, args )
	args = args or {}

	local screen = DeepCopyTable( ScreenData.MetaUpgradeCardUpgradeLayout )
	local components = screen.Components	
	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	screen.ZoomLevel = GetZoomLevel()
	screen.KeepOpen = true
	
	screen.SourceId = source.ObjectId
	screen.OpenedFrom = source
	screen.StartingHealth = args.StartingHealth
	screen.StartingMana = args.StartingMana
	screen.UpgradedMetaUpgrades = {}
	screen.CostDisplay.StartX = screen.CostDisplay.StartX + ScreenCenterNativeOffsetX
	screen.CostDisplay.StartY = screen.CostDisplay.StartY + ScreenCenterNativeOffsetY
	CreateScreenFromData( screen, screen.ComponentData )
	--CreateBones( screen )
	UpdateMetaUpgradeCostText( screen ) 
	CreateMetaUpgradeCards( screen, { UpgradeStoreNames = true, ActionFunctionName = "UpgradeMetaUpgradeCardAction", HighlightFunctionName = "MouseOverUpgradeMetaUpgrade", Autoselect = args.HighlightedCardName  } )
	
	screen.LastMouseOffButtonCardName = args.LastMouseOffButtonCardName
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.3, Duration = 0.5 })
	local scale = 5 / screen.ZoomLevel
	SetScale({ Id = components.CardHoverFrame.Id, Fraction = scale, Duration = 0})
	CreateAnimation({ Name = "MetaUpgradeInsightModeFxStartGlow", DestinationId = components.MemCostModuleBacking.Id, Group = "Combat_Menu_Overlay_Additive" })
	wait(0.5)
	
	screen.KeepOpen = true
	for weaponName, v in pairs( WeaponSetLookups.HeroSecondaryWeaponsLinked ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		end
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
				table.insert( ids, button.CostTextId )
				table.insert( ids, button.CardCornersId )
				table.insert( ids, button.RarityBadgeId )
				table.insert( ids, button.EquippedHighlightId )
				table.insert( ids, button.UpgradeIconId )
				table.insert( ids, button.PinButtonId )
				StopAnimation({ DestinationId = button.CardArtId,
					Names = { "CardUpgrade", "CardUpgradeMaxLevel", "CardUpgradeGlowMaxLevel", "CardUpgradeShineMaxLevel", "CardUpgradeSpectralSparks", "CardUpgradeSpectralSparksMaxLevel", } })
			end
		end
	end

	local closeDelay = 0
	if not args.UpgradeTransition then 
		thread( CloseMetaUpgradeCardScreenPresentation, screen )
		if screen.StartingHealth ~= CurrentRun.Hero.MaxHealth then
			thread( MaxHealthChangedPresentation, CurrentRun.Hero.MaxHealth > screen.StartingHealth, 0.65 )
		end
		if screen.StartingMana ~= CurrentRun.Hero.MaxMana then
			thread( MaxManaChangedPresentation, CurrentRun.Hero.MaxMana > screen.StartingMana, 0.65 )
		end
		closeDelay = 0.15
	end
	for metaUpgradeName in pairs( screen.UpgradedMetaUpgrades ) do
		if MetaUpgradeCardData[ metaUpgradeName ].TraitName and GameState.MetaUpgradeState[ metaUpgradeName ].Equipped then
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
	StopAnimation({ Names = { "MetaUpgradeHandLargeGlowIn", "MetaUpgradeHandLargeGlowLoop", }, DestinationId = screen.Components.MemCostModuleBacking.Id })
	StopAnimation({ Names = { "CardUnlockShineLarge", "CardUpgradeSpectralSparksLarge", }, DestinationId = screen.Components.MetaUpgradeCardArt.Id })
	if screen.ChangeMade then
		RequestPreRunLoadoutChangeSave()
	end

	CloseScreen( ids, closeDelay, screen, args )
	if not args.UpgradeTransition then
		for weaponName, v in pairs( WeaponSetLookups.HeroSecondaryWeaponsLinked ) do
			if MapState.EquippedWeapons[weaponName] then
				SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			end
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
	if not args.IgnoreAspectRatioFrame then
		AltAspectRatioFramesHide()
	end
	ShowCombatUI( screen.Name )
end

function ExitUpgradeMode( screen, button )
	if screen.ExitingUpgradeMode or ScreenState.InTransition then
		return
	end
	screen.ExitingUpgradeMode = true
	ScreenState.InTransition = true
	AddInputBlock({ Name = "ExitUpgradeMode" })

	thread( PlayVoiceLines, GlobalVoiceLines.SwitchFromUpgradeCardModeVoiceLines, true )
	FadeOut({ Color = Color.Black, Duration = 0.1 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TarotCardsShuffle" })
	wait( 0.1 )
	-- Immediately close the upgrade mode screen under full black
	CloseUpgradeMetaUpgradeCardScreen( screen, { UpgradeTransition = true, IgnoreAspectRatioFrame = true, FadeOutTime = 0.0 } )
	wait( 0.1 ) -- Wait for cleanup and Bink to finish
	-- Now can create the regular screen and fade in
	if screen.SelectedButton then
		thread( OpenMetaUpgradeCardScreen, screen.OpenedFrom, { LastMouseOffButtonCardName = screen.LastMouseOffButtonCardName, HighlightedCardName = screen.SelectedButton.CardName } )
	else
		thread( OpenMetaUpgradeCardScreen, screen.OpenedFrom,  { LastMouseOffButtonCardName = screen.LastMouseOffButtonCardName } )
	end
	FadeIn({ Duration = 0 })
	RemoveInputBlock({ Name = "ExitUpgradeMode" })
	FullScreenFadeInAnimationReroll()
	wait( 1.05 )

	ScreenState.InTransition = false
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
	local components = button.Screen.Components
	if selectedButton.CardState == "UNLOCKED" then
		if not MetaUpgradeAtMaxLevel( metaUpgradeName ) then
			local metaUpgradeData = MetaUpgradeCardData[metaUpgradeName]
			local resourceCost = metaUpgradeData.UpgradeResourceCost[ GetMetaUpgradeLevel( metaUpgradeName )]
			
			if HasResources( resourceCost ) then
				screen.ChangeMade = true
				for resourceName, resourceCost in pairs( resourceCost ) do
					SpendResource( resourceName, resourceCost, metaUpgradeName, { TargetId = components["ResourceIconBacking"..resourceName].Id, UseScreenLocation = true, TextOffsetY = 11, TextAnchorOffsetY = -50, SkipQuestStatusCheck = true } )
				end
				UpdateAffordabilityStatus()

				RemoveStoreItemPin( selectedButton.CardName .. GetMetaUpgradeLevel( metaUpgradeName ), { Purchase = true } )
				RemoveStoreItemPinPresentation( selectedButton )
				IncrementTableValue(GameState.MetaUpgradeState[metaUpgradeName], "Level" )
				screen.UpgradedMetaUpgrades[metaUpgradeName] = true
				UpdateMetaUpgradeCardState( screen, selectedButton )
				GameState.Flags.HasUpgradedCards = true

				UpgradeMetaUpgradeCardPresentation( selectedButton )
				if MetaUpgradeAtMaxLevel( metaUpgradeName ) then
					MetaUpgradeCardMaxLevelPresentation( selectedButton )
					SetAlpha({ Id = button.UpgradeIconId, Fraction = 0, Duration = 0.2 })
					SetAlpha({ Id = components.MetaUpgradeMaxRank.Id, Fraction = 1, Duration = 0 })
					SetAnimation({ DestinationId = components.MetaUpgradeMaxRank.Id, Name = "MetaUpgradeUpgradeScreenMaxRankAchieved" })
				end
				
				MouseOverUpgradeMetaUpgrade( selectedButton )
				if GetMetaUpgradeLevel( selectedButton.CardName ) > 1 then 
					local rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( selectedButton.CardName )]
					SetAnimation({ DestinationId = selectedButton.CardCornersId, Name = "RarityCircle".. rarity })
					SetAnimation({ DestinationId = components.MetaUpgradeCardArtPatch.Id, Name = "RarityFrameLarge".. rarity .. "In" })
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
								SetAlpha({ Id = otherButton.Id, Fraction = 0.2, Duration = 0.2 })
								SetAlpha({ Id = otherButton.CardCornersId, Fraction = 0.2, Duration = 0.2 })
							end
						end
					end
				end

				CheckAchievement( screen, { Name = "AchAllArcanaMax" } )

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
	SetAlpha({ Id = components.MetaUpgradeCardArt.Id, Fraction = 1, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardArtPatch.Id, Fraction = 1, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardTitle.Id, Fraction = 1, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardAutoEquipText.Id, Fraction = 1, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardText.Id, Fraction = 1, Duration = 0.2 })

	GenericMouseOverPresentation( button )
	Teleport({ Id = button.HoverFrameId, DestinationId = button.Id })
	UpdateUpgradeMetaUpgradeCardInteractionText( button.Screen, button )
	SelectMetaUpgradeButton( button.Screen, button )
	UpdateUpgradeMetaUpgradeCostDisplay( button.Screen, button )
	if button.CardState ~= "UNLOCKED" then
		return
	end
	SetAlpha({ Id = components.MetaUpgradeCardMaxLevel.Id, Fraction = 1, Duration = 0.2 })

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
		SetAlpha({ Id = components.MetaUpgradeMaxRank.Id, Fraction = 0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.MetaUpgradeMaxRank.Id, Fraction = 1, Duration = 0.2 })
	end
end

function UpdateUpgradeMetaUpgradeCardInteractionText( screen, button )

	local components = screen.Components

	local selectButtonText = nil
	local canPin = false
	local canInspect = false

	if button.CardState == "UNLOCKED" then
		if CanUpgradeMetaUpgrade( button.CardName ) then
			selectButtonText = "MetaUpgradeCard_Upgrade"
			if GameState.WorldUpgrades.WorldUpgradePinning then
				canPin = true
				ModifyTextBox({ Id = components.PinButton.Id, Text = "Menu_Pin" })
			end
		else
			canInspect = true
			ModifyTextBox({ Id = components.PinButton.Id, Text = "MetaUpgradeCard_Inspect" })
			if not GameState.Flags.InspectedMetaUpgrade and not screen.PulseInspectPresentation then
				thread( PulseContextActionPresentation, components.PinButton, { InitialWait = 0.1, ThreadName = "InspectPulse", PulseOnce = true } )
				screen.PulseInspectPresentation = true
			end
		end
	end

	if selectButtonText ~= nil then
		ModifyTextBox({ Id = components.SelectButton.Id, Text = selectButtonText })
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

	if canPin or button ~= nil then
		components.PinButton.Visible = true
		SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
	else
		components.PinButton.Visible = nil
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

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
		SetAlpha({ Id = components.MetaUpgradeResourceCostBacking.Id, Fraction = 0.0, Duration = 0.2 })
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
	if screen.SelectedButton.CardState ~= "UNLOCKED" then
		return
	end

	if not CanUpgradeMetaUpgrade( screen.SelectedButton.CardName ) then
		MetaUpgradeCardUpgradeScreenInspect( screen, button )
		return
	end

	local itemName = screen.SelectedButton.CardName .. GetMetaUpgradeLevel( screen.SelectedButton.CardName )
	if HasStoreItemPin( itemName ) then
		RemoveStoreItemPin( itemName )
		RemoveStoreItemPinPresentation( screen.SelectedButton )
	else
		AddStoreItemPin( itemName, "MetaUpgradeCardUpgradeData" )
		AddStoreItemPinPresentation( screen.SelectedButton, { AnimationName = "MetaUpgradeItemPin" })
	end
end

function MetaUpgradeCardUpgradeScreenInspect( screen, button )
	GameState.Flags.InspectedMetaUpgrade = true
	AddInputBlock({ Name = "MetaUpgradeCardUpgradeScreenInspect" })
	MouseOffMetaUpgrade( screen.SelectedButton )
	local components = screen.Components
	SetAlpha({ Id = components.InspectBackground.Id, Fraction = screen.InspectBackgroundAlpha, Duration = 0.2 })
	SetAlpha({ Id = components.MetaUpgradeCardArt.Id, Fraction = 1.0, Duration = 0.2 })
	--SetAlpha({ Id = components.MetaUpgradeCardArtPatch.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InspectName.Id, Text = screen.SelectedButton.CardName })
	SetAlpha({ Id = components.InspectName.Id, Fraction = 1.0, Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/TarotCardSpecialInteract" })
	thread( PlayVoiceLines, MetaUpgradeCardData[screen.SelectedButton.CardName].EquipVoiceLines, true )

	for i, flavorTextData in ipairs( MetaUpgradeCardData[screen.SelectedButton.CardName].FlavorTextData ) do
		if IsGameStateEligible( flavorTextData, flavorTextData.GameStateRequirements ) then
			ModifyTextBox({ Id = components.InspectFlavorText.Id, Text = flavorTextData.Name })
			SetAlpha({ Id = components.InspectFlavorText.Id, Fraction = 1.0, Duration = 0.2 })
			break
		end
	end	
	SetScale({ Id = components.MetaUpgradeCardArt.Id, Fraction = screen.InspectCardScale, Duration = 0.2 })
	--SetScale({ Id = components.MetaUpgradeCardArtPatch.Id, Fraction = 1.0, Duration = 0.2 })
	Move({ Id = components.MetaUpgradeCardArt.Id, OffsetX = screen.InspectLocationX, OffsetY = screen.InspectLocationY, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })

	wait(0.3)
	local notifyName = "MetaUpgradeCardUpgradeScreenInspectClose"
	NotifyOnControlPressed({ Names = { "Use", "Rush", "Shout", "Attack2", "Attack1", "Attack3", "AutoLock", "Cancel", "Confirm", "Select", "ItemPin", }, Notify = notifyName })
	waitUntil( notifyName )

	SetAlpha({ Id = components.InspectBackground.Id, Fraction = 0.0, Duration = 0.2 })
	SetScale({ Id = components.MetaUpgradeCardArt.Id, Fraction = components.MetaUpgradeCardArt.Scale, Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CardsInteract" })

	--SetScale({ Id = components.MetaUpgradeCardArtPatch.Id, Fraction = components.MetaUpgradeCardArtPatch.Scale, Duration = 0.2 })
	SetAlpha({ Id = components.InspectName.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InspectFlavorText.Id, Fraction = 0.0, Duration = 0.2 })
	Move({ Id = components.MetaUpgradeCardArt.Id, OffsetX = components.MetaUpgradeCardArt.X, OffsetY = components.MetaUpgradeCardArt.Y, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
	MouseOverUpgradeMetaUpgrade( screen.SelectedButton )
	RemoveInputBlock({ Name = "MetaUpgradeCardUpgradeScreenInspect" })
end
