OnControlPressed{ "AdvancedTooltip",
	function( triggerArgs )

		for screenName, screen in pairs( ActiveScreens ) do
			if not screen.AllowAdvancedTooltip then
				return
			end
		end

		if CurrentHubRoom ~= nil and CurrentHubRoom.BlockCombatUI then
			return
		end

		if IsEmpty( ActiveScreens ) then
			if not IsEmpty( MapState.CombatUIHide ) or not IsInputAllowed({}) then
				-- If no screen is open, controlled entirely by input status
				return
			end
		end

		if ActiveScreens.TraitTrayScreen ~= nil and not ActiveScreens.TraitTrayScreen.Closing and GetConfigOptionValue({ Name = "UseMouse" }) then
			TraitTrayScreenClose()
		else
			ShowTraitTrayScreen( { AutoPin = false } )
		end
	end
}

function ShowTraitTrayScreen( args )

	if SessionState.InFlashback then
		return
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		return
	end

	args = args or {}

	thread( HideObjectivesUI, args )
	ShowCombatUI( "TraitTray", { SkipObjectives = true } )
	ShowResourceUIs()
	OpenTraitTrayScreen( args )

end

function OpenTraitTrayScreen( args )

	local screen = DeepCopyTable( ScreenData.TraitTrayScreen )
	if args.OverwriteSelf ~= nil then
		OverwriteSelf( screen, args.OverwriteSelf )
	end
	OnScreenOpened( screen, { SkipBlockTimer = true, } )

	screen.ActiveCategoryIndex = args.DefaultCategoryIndex or 1
	screen.NumCategories = 0
	screen.AutoPin = args.AutoPin

	CreateScreenFromData( screen, screen.ComponentData, args )
	if args.DontDuckAudio then
		SetAdvancedTooltipMixing( 1 )
	end
	if args.CloseFunctionName ~= nil then
		screen.CloseFunctionName = args.CloseFunctionName
		screen.CloseFunctionArgs = args.CloseFunctionArgs
	end
	killTaggedThreads( CombatUI.HideThreadName )
	thread( MarkObjectiveComplete, "AdvancedTooltipPrompt" )
	thread( MarkObjectiveComplete, "CheckFamiliarInfoPrompt" )
	thread( MarkObjectiveComplete, "BountyAdvancedTooltip" )

	args.TransitionTime = 0
	TraitTrayScreenShowCategory( screen, screen.ActiveCategoryIndex, args )

	SetAlpha({ Ids = { HUDScreen.Components.WeaponSlotIcon.Id, HUDScreen.Components.FamiliarSlotIcon.Id }, Duration = 0.2, Fraction = ConfigOptionCache.HUDOpacity })	
	local allTraitComponents = MergeTables( HUDScreen.SlottedTraitComponents, HUDScreen.ActiveTraitComponents )
	for id, activeTraitComponent in pairs( allTraitComponents ) do
		activeTraitComponent.Screen = screen
		activeTraitComponent.OnMouseOverFunctionName = "TraitTrayIconButtonMouseOver"
		activeTraitComponent.OnMouseOffFunctionName = "TraitTrayIconButtonMouseOff"
		activeTraitComponent.OnPressedFunctionName = "PinTraitDetails"
		--ModifyTextBox({ Id = activeTraitComponent.Id, BlockTooltip = false })
		screen.Components["ActiveTrait"..TraitTrayGetUniqueName( activeTraitComponent )] = activeTraitComponent
		if activeTraitComponent.TraitData.HideInHUD then
			HUDShowTrait( activeTraitComponent.TraitData, { FadeDuration = 0.2, ForceShow = true } )
		end
	end

	if IsEmpty( screen.PossibleAutoPins ) then
		if highlightedTrait ~= nil then
			PinTraitDetails( screen, highlightedTrait, { Hover = true } )
		end
	else
		TraitTrayDoAutoPins( screen )
	end

	screen.KeepOpen = true

	if args.HideCloseButton then
		SetAlpha({ Id = screen.Components.CloseButton.Id, Fraction = 0.0, Duration = 0.0 })
		UseableOff({ Id = screen.Components.CloseButton.Id })
		SetAlpha({ Id = screen.Components.InfoButton.Id, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = screen.Components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = screen.Components.ScrollRight.Id, Fraction = 0.0, Duration = 0.0 })
	end
	if args.HideInfoButton then
		UseableOff({ Id = screen.Components.InfoButton.Id })
		screen.Components.InfoButton.OnPressedFunctionName = nil
	end

	if screen.NumCategories < 2 then
		SetAlpha({ Id = screen.Components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = screen.Components.ScrollRight.Id, Fraction = 0.0, Duration = 0.0 })
		UseableOff({ Id = screen.Components.ScrollLeft.Id })
		UseableOff({ Id = screen.Components.ScrollRight.Id })
		screen.Components.ScrollLeft.OnPressedFunctionName = nil
		screen.Components.ScrollRight.OnPressedFunctionName = nil
	end

	if not args.SkipInputHandlers then
		wait( 0.05 )
		HandleScreenInput( screen )
	end
	return screen

end

function TraitTrayDoAutoPins( screen )
	for k = 1, screen.MaxAutoPins do
		local traitButton = RemovePriorityPin( screen, screen.PossibleAutoPins )
		PinTraitDetails( screen, traitButton, { PinCollapseSpeed = 99999 } )
		if IsEmpty( screen.PossibleAutoPins ) then
			break
		end
	end
	screen.PossibleAutoPins = {}
end

function TraitTrayScreenSetupTabs( screen, data )
	local components = screen.Components

	local eligibleCategories = {}
	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		if category.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, category, category.GameStateRequirements ) then
			table.insert( eligibleCategories, category )
			screen.NumCategories = screen.NumCategories + 1
		else
			category.Locked = true
		end
	end

	local categoryWidth = screen.CategorySpacingX * ( screen.NumCategories - 1 )
	local categoryX = screen.CategoryCenterX - ( categoryWidth * 0.5 )

	for categoryIndex, category in ipairs( eligibleCategories ) do
		local slotName = category.Name
		local categoryButton = CreateScreenComponent({ Name = "ButtonTraitTrayTab", X = categoryX, Y = ScreenHeight - screen.CategoryStartBottomOffset, Scale = 1.0, Group = "HUD_Backing", })
		AttachLua({ Id = categoryButton.Id, Table = categoryButton })
		categoryButton.Screen = screen
		categoryButton.OnPressedFunctionName = "TraitTrayScreenSelectCategory"
		categoryButton.OnMouseOverFunctionName = "TraitTrayScreenCategoryMouseOver"
		categoryButton.OnMouseOffFunctionName = "TraitTrayScreenCategoryMouseOff"
		categoryButton.Category = slotName
		categoryButton.CategoryIndex = categoryIndex
		screen.Components["Category"..slotName] = categoryButton

		local iconComponent = HUDScreen.Components[category.IconComponent]
		if iconComponent ~= nil then
			Move({ Id = iconComponent.Id, DestinationId = categoryButton.Id, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0, OffsetX = -18, OffsetY = -4 })
		end	
		
		categoryX = categoryX + screen.CategorySpacingX
	end

	Move({ Id = HUDScreen.Components.BountyActive.Id, Distance = screen.BountyIconShiftX, Angle = 0, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
	ModifyTextBox({ Id = HUDScreen.Components.BountyActive.Id, FadeTarget = 1.0, FadeDuration = 0.2 })

end

function TraitTrayScreenShowCategory( screen, categoryIndex, args )
	args = args or {}
	AddInputBlock({ Name = "TraitTrayScreenSelectCategory" })
	local prevCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	if screen.ActiveCategoryIndex == 1 then
		SetAlpha({ Id = screen.Components.ElementPanel.Id, Fraction = 0.0, Duration = 0.1 })
	elseif screen.ActiveCategoryIndex == 2 then
		SetAlpha({ Id = screen.Components.NoMetaUpgradesHint.Id, Fraction = 0.0, Duration = 0.1 })
	elseif screen.ActiveCategoryIndex == 3 then
		SetAlpha({ Id = screen.Components.ActiveShrineBountyBacking.Id, Fraction = 0.0, Duration = 0.1 })
		SetAlpha({ Id = screen.Components.ActiveShrineBountyTarget.Id, Fraction = 0.0, Duration = 0.1 })
		SetAlpha({ Id = screen.Components.ActiveShrineBountyFrame.Id, Fraction = 0.0, Duration = 0.1 })
		SetAlpha({ Id = screen.Components.ActiveShrineBountyPoints.Id, Fraction = 0.0, Duration = 0.1 })		
		SetAlpha({ Id = screen.Components.ActiveShrineBountyWeapon.Id, Fraction = 0.0, Duration = 0.1 })
	end
	SetAnimation({ DestinationId = screen.Components["Category"..prevCategory.Name].Id, Name = "TraitTrayTab" })
	if categoryIndex ~= 1 then
		HideTraitUI( { FadeOutDuration = 0.1 } )
	end
	TraitTrayScreenRemoveItems( screen )	
	wait( args.TransitionTime or 0.02 )
	
	screen.ActiveCategoryIndex = categoryIndex
	local activeCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	-- Highlight new category
	SetAnimation({ DestinationId = screen.Components["Category"..activeCategory.Name].Id, Name = "TraitTrayTabHighlightActiveCategory" })
	SetAnimation({ DestinationId = screen.Components.Background.Id, Name = activeCategory.BackgroundAnimation })
	ModifyTextBox({ Id = screen.Components.CategoryTitleText.Id, Text = activeCategory.Name })
	CallFunctionName( activeCategory.DisplayFunctionName, screen, activeCategory, args )

	if not IsEmpty( activeCategory.SavedPins ) then
		for index, traitName in ipairs( activeCategory.SavedPins ) do
			--DebugPrint({ Text = "traitName = "..traitName })
			local traitComponent = screen.TraitComponentDictionary[traitName]
			--DebugPrint({ Text = "traitComponent = "..tostring(traitComponent) })
			PinTraitDetails( screen, traitComponent, { PinCollapseSpeed = 99999 } )
		end
	end
	if not args.AutoPin and not activeCategory.OpenedOnce then
		TraitTrayDoAutoPins( screen )
	end
	activeCategory.OpenedOnce = true
	RemoveInputBlock({ Name = "TraitTrayScreenSelectCategory" })
end

function TraitTrayScreenSelectCategory( screen, button )
	if button.CategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	TraitTrayScreenShowCategory( screen, button.CategoryIndex )
end

function TraitTrayScreenCategoryMouseOver( button )
	local screen = button.Screen
	if screen.ActiveCategoryIndex == button.CategoryIndex then
		SetAnimation({ DestinationId = button.Id, Name = "TraitTrayTabHighlightActiveCategory" })
	else
		SetAnimation({ DestinationId = button.Id, Name = "TraitTrayTabHighlight" })
	end
end

function TraitTrayScreenCategoryMouseOff( button )
	local screen = button.Screen
	if screen.ActiveCategoryIndex == button.CategoryIndex then
		SetAnimation({ DestinationId = button.Id, Name = "TraitTrayTabHighlightActiveCategory" })
	else
		SetAnimation({ DestinationId = button.Id, Name = "TraitTrayTab" })
	end
end

function TraitTrayScreenNextCategory( screen, button )
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
	TraitTrayScreenShowCategory( screen, nextCategoryIndex )
end

function TraitTrayScreenPrevCategory( screen, button )
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
	TraitTrayScreenShowCategory( screen, nextCategoryIndex )
end

function TraitTrayShowTraits( screen, activeCategory, args )
	local components = screen.Components
	local firstTrait = nil
	local highlightedTrait = nil
	local lastTrait = nil
	local displayedTraitNum = 0
	local xOffset = screen.TraitStartX
	local yOffset = ScreenHeight - screen.TraitStartBottomOffset

	ShowTraitUI( { FadeDuration = 0.2, ForceShow = true } )
	
	local currentTraits = ShallowCopyTable( CurrentRun.Hero.Traits )
	--currentTraits = CollapseTableOrdered( currentTraits )
	local orderedTraits = {}
	for i, slotName in ipairs( HUDScreen.SlottedTraitOrder ) do
		local slottedTrait = nil
		for i, trait in ipairs( currentTraits ) do
			if trait.Slot == slotName and not trait.Hidden and not IsShownInHUD( trait ) then
				slottedTrait = trait
				slottedTrait.Ordered = true
				break
			end
		end
		if slottedTrait ~= nil then
			table.insert( orderedTraits, slottedTrait )
		else
			local missingTrait = { EmptySlot = slotName }
			--DebugPrint({ Text = "slotName = "..slotName })
			table.insert( orderedTraits, missingTrait )
		end
	end	
	for i, trait in ipairs( currentTraits ) do
		if not trait.Ordered and not trait.Hidden and not IsShownInHUD( trait ) then
			table.insert( orderedTraits, trait )
		end
	end

	for i, trait in ipairs( orderedTraits ) do

		if trait.EmptySlot ~= nil then
			-- Do nothing
		else
			local traitIcon = CreateScreenComponent({ Name = "TraitTrayIconButton", X = xOffset, Y = yOffset, Group = screen.ComponentData.DefaultGroup, Scale = 0.5, Alpha = 0 })
			AttachLua({ Id = traitIcon.Id, Table = traitIcon })
			traitIcon.Screen = screen
			traitIcon.OnMouseOverFunctionName = "TraitTrayIconButtonMouseOver"
			traitIcon.OnMouseOffFunctionName = "TraitTrayIconButtonMouseOff"
			traitIcon.OnPressedFunctionName = "PinTraitDetails"
			SetAnimation({ Name = GetTraitIcon( trait ), DestinationId = traitIcon.Id })
			traitIcon.OffsetX = xOffset
			traitIcon.OffsetY = yOffset
			traitIcon.TraitData = trait
			traitIcon.PinIconScale = 0.26
			traitIcon.PinIconFrameScale = 0.27
			traitIcon.HighlightAnimScale = 0.27
			traitIcon.TrayHighlightAnimScale = 1.0
			SetAlpha({ Id = traitIcon.Id, Fraction = 1.0, Duration = 0.1 })

			-- Hidden tooltip text
			CreateTextBox({
				Id = traitIcon.Id,
				UseDescription = true,
				VariableAutoFormat = "BoldFormatGraft",
				Scale = 0.0,
				Hide = true,
			})

			if args.DisableTooltips then
				ModifyTextBox({ Id = traitIcon.Id, BlockTooltip = true })
			end

			table.insert( components, traitIcon )
			screen.Icons[traitIcon.Id] = traitIcon

			local traitFrame = GetTraitFrame( trait )
			if traitFrame ~= nil then
				local traitFrameId = CreateScreenObstacle({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = 0.5, Alpha = 0 })
				Attach({ Id = traitFrameId, DestinationId = traitIcon.Id })
				SetAnimation({ Name = traitFrame, DestinationId = traitFrameId })
				SetAlpha({ Id = traitFrameId, Fraction = 1.0, Duration = 0.1 })
				table.insert( screen.Frames, traitFrameId )
			end

			TraitUICreateText( trait, { AnchorId = traitIcon.Id, FadeDuration = 0.1 } ) 
			if trait.TraitInfoCardId ~= nil then
				SetAlpha({ Id = trait.TraitInfoCardId, Fraction = 1.0, Duration = 0.1 })
				table.insert( screen.Frames, trait.TraitInfoCardId )
				trait.TraitInfoCardId = nil
			end
			if trait.TraitInfoChargeId ~= nil then
				SetAlpha({ Id = trait.TraitInfoChargeId, Fraction = 1.0, Duration = 0.1 })
				table.insert( screen.Frames, trait.TraitInfoChargeId )
				trait.TraitInfoChargeId = nil
			end

			local uniqueTraitName = TraitTrayGetUniqueName( traitIcon )
			if uniqueTraitName == args.HighlightName or uniqueTraitName == activeCategory.PrevHighlightName then
				highlightedTrait = traitIcon
			end
			if MapState.PriorityTraitInfoHighlight ~= nil and trait.Name == MapState.PriorityTraitInfoHighlight then
				highlightedTrait = traitIcon
				MapState.PriorityTraitInfoHighlight = nil
			end
			lastTrait = traitIcon

			screen.TraitComponentDictionary[uniqueTraitName] = traitIcon
			if args.AutoPin and IsPossibleTraitAutoPin( trait ) then
				table.insert( screen.PossibleAutoPins, traitIcon )
			end

		end

		displayedTraitNum = displayedTraitNum + 1
		if displayedTraitNum % screen.TraitsPerColumn == 0 then
			xOffset = xOffset + screen.TraitSpacingX
			yOffset = ScreenHeight - screen.TraitStartBottomOffset
		else
			yOffset = yOffset + screen.TraitSpacingY
		end

	end

	if highlightedTrait == nil then
		for id, slottedTraitComponent in pairs( HUDScreen.SlottedTraitComponents ) do
			if slottedTraitComponent.TraitData.Name == MapState.PriorityTraitInfoHighlight or TraitTrayGetUniqueName( slottedTraitComponent ) == activeCategory.PrevHighlightName then
				highlightedTrait = slottedTraitComponent
				MapState.PriorityTraitInfoHighlight = nil
				break
			end
			lastTrait = lastTrait or slottedTraitComponent
		end
		for id, slottedTraitComponent in pairs( HUDScreen.ActiveTraitComponents ) do
			if slottedTraitComponent.TraitData.Name == MapState.PriorityTraitInfoHighlight or TraitTrayGetUniqueName( slottedTraitComponent ) == activeCategory.PrevHighlightName then
				highlightedTrait = slottedTraitComponent
				MapState.PriorityTraitInfoHighlight = nil
				break
			end
			lastTrait = lastTrait or slottedTraitComponent
		end
	end

	for id, traitComponent in pairs( HUDScreen.SlottedTraitComponents ) do
		screen.TraitComponentDictionary[TraitTrayGetUniqueName( traitComponent )] = traitComponent
		if args.AutoPin and IsPossibleTraitAutoPin( traitComponent.TraitData ) then
			table.insert( screen.PossibleAutoPins, traitComponent )
		end
	end
	for id, traitComponent in pairs( HUDScreen.ActiveTraitComponents ) do
		screen.TraitComponentDictionary[TraitTrayGetUniqueName( traitComponent )] = traitComponent
		if args.AutoPin and IsPossibleTraitAutoPin( traitComponent.TraitData ) then
			table.insert( screen.PossibleAutoPins, traitComponent )
		end
	end

	if IsGameStateEligible( CurrentRun, TraitRarityData.ElementalGameStateRequirements ) then
		SetAlpha({ Id = screen.Components.ElementPanel.Id, Fraction = 1.0, Duration = 0.1 })
	end

	highlightedTrait = highlightedTrait or lastTrait
	if highlightedTrait ~= nil then
		wait( 0.02 )
		SetHighlightedTraitFrame( screen, highlightedTrait )
	end

end

function TraitTrayShowMetaUpgrades( screen, activeCategory, args )

	if GetNumShrineUpgrades( "NoMetaUpgradesShrineUpgrade" ) >= 1 then
		SetAlpha({ Id = screen.Components.NoMetaUpgradesHint.Id, Fraction = 1.0, Duration = 0.1 })
		return
	end

	local equippedMetaUpgradesNum = 0
	for k, upgrade in pairs(GameState.MetaUpgradeState) do
		if upgrade.Equipped then
			equippedMetaUpgradesNum = equippedMetaUpgradesNum + 1
		end
	end

	local traitSpacingX = activeCategory.TraitSpacingX or screen.TraitSpacingX
	if equippedMetaUpgradesNum >= activeCategory.TraitsNeededForExtendedSpacing then
		traitSpacingX = activeCategory.ExtendedTraitSpacingX
	end

	local components = screen.Components
	local firstTrait = nil
	local highlightedTrait = nil
	local displayedTraitNum = 0
	local xOffset = activeCategory.TraitStartX or screen.TraitStartX
	local yOffset = ScreenHeight - (activeCategory.TraitStartBottomOffset or screen.TraitStartBottomOffset)
	--for metaUpgradeName, metaUpgradeState in pairs( GameState.MetaUpgradeState ) do
	for rowIndex, row in ipairs( MetaUpgradeDefaultCardLayout ) do
		for colIndex, metaUpgradeName in ipairs( row ) do
			local metaUpgradeState = GameState.MetaUpgradeState[metaUpgradeName]
			if metaUpgradeState ~= nil and metaUpgradeState.Equipped then
				--DebugPrint({ Text = "metaUpgradeName = "..metaUpgradeName })
				local metaUpgradeCardData = MetaUpgradeCardData[metaUpgradeName]
				if metaUpgradeCardData.TraitName ~= nil and HeroHasTrait(metaUpgradeCardData.TraitName) then
					local trait = GetHeroTrait( metaUpgradeCardData.TraitName )
					local traitFrameId = CreateScreenObstacle({ Name = "BlankObstacle", X = xOffset, Y = yOffset,  Group = screen.ComponentData.DefaultGroup, Scale = 0.7, Alpha = 0.0 })
					--Attach({ Id = traitFrameId, DestinationId = traitIcon.Id })
					SetAnimation({ Name = "DevCard_EquippedHighlight", DestinationId = traitFrameId })
					SetAlpha({ Id = traitFrameId, Fraction = 1.0, Duration = 0.1 })
					table.insert( screen.Frames, traitFrameId )

					local iconScale = 0.15
					local traitIcon = CreateScreenComponent({ Name = "TraitTrayIconButton", X = xOffset, Y = yOffset, Group = screen.ComponentData.DefaultGroup, Animation = metaUpgradeCardData.Image, Scale = iconScale, Alpha = 0.0 })
					AttachLua({ Id = traitIcon.Id, Table = traitIcon })
					traitIcon.Screen = screen
					traitIcon.OnMouseOverFunctionName = "TraitTrayIconButtonMouseOver"
					traitIcon.OnMouseOffFunctionName = "TraitTrayIconButtonMouseOff"
					traitIcon.OnPressedFunctionName = "PinTraitDetails"
					--trait.AnchorId = traitIcon.Id
					traitIcon.Icon = metaUpgradeCardData.Image
					traitIcon.IconScale = iconScale
					traitIcon.PinIconScale = 0.08
					traitIcon.PinIconFrameScale = 0.4
					traitIcon.OffsetX = xOffset
					traitIcon.OffsetY = yOffset
					traitIcon.HighlightAnim = "DevCard_Hover"
					traitIcon.HighlightAnimScale = 0.33
					traitIcon.TrayHighlightAnimScale = 1.1
					SetAlpha({ Id = traitIcon.Id, Fraction = 1.0, Duration = 0.1 })
					CreateTextBox({
						Id = traitIcon.Id,
						UseDescription = true,
						VariableAutoFormat = "BoldFormatGraft",
						Scale = 0.0,
						Hide = true,
					})

					if args.DisableTooltips then
						ModifyTextBox({ Id = traitIcon.Id, BlockTooltip = true })
					end

					table.insert( components, traitIcon )
					traitIcon.TraitData = trait
					screen.Icons[traitIcon.Id] = traitIcon

					if not firstTrait then
						highlightedTrait = traitIcon
						firstTrait = true
					end

					local uniqueTraitName = TraitTrayGetUniqueName( traitIcon )
					if uniqueTraitName == args.HighlightName or uniqueTraitName == activeCategory.PrevHighlightName then
						highlightedTrait = traitIcon
					end
					if trait.Name == MapState.TraitTrayMetaUpgradePriorityHighlight then
						highlightedTrait = traitIcon
						MapState.TraitTrayMetaUpgradePriorityHighlight = nil
					end

					screen.TraitComponentDictionary[uniqueTraitName] = traitIcon
					if screen.AutoPin and not activeCategory.OpenedOnce and IsPossibleMetaUpgradeAutoPin( trait ) then
						table.insert( screen.PossibleAutoPins, traitIcon )
					end
					
					displayedTraitNum = displayedTraitNum + 1
					if displayedTraitNum % (activeCategory.TraitsPerColumn or screen.TraitsPerColumn ) == 0 then
						xOffset = xOffset + traitSpacingX
						yOffset = ScreenHeight - (activeCategory.TraitStartBottomOffset or screen.TraitStartBottomOffset)
					else
						yOffset = yOffset + (activeCategory.TraitSpacingY or screen.TraitSpacingY)
					end

				end
			end
		end
	end

	highlightedTrait = highlightedTrait
	if highlightedTrait ~= nil then
		wait( 0.02 )
		SetHighlightedTraitFrame( screen, highlightedTrait )
	end

end

function TraitTrayShowShrineUpgrades( screen, activeCategory, args )

	local components = screen.Components
	local firstTrait = nil
	local highlightedTrait = nil
	local displayedTraitNum = 0
	local xOffset = screen.ShrineStartX
	local yOffset = ScreenHeight - screen.ShrineStartBottomOffset
	for i, shrineUpgradeName in ipairs( ShrineUpgradeOrder ) do
		local metaUpgradeData = MetaUpgradeData[shrineUpgradeName]
		local rank = GameState.ShrineUpgrades[shrineUpgradeName] or 0
		if rank >= 1 then

			local traitFrameId = CreateScreenObstacle({ Name = "BlankObstacle", X = xOffset, Y = yOffset,  Group = screen.ComponentData.DefaultGroup, Scale = screen.ShrineBackingScale, Alpha = 0.0 })
			local rank = GetNumShrineUpgrades( shrineUpgradeName )
			if rank >= TableLength( metaUpgradeData.Ranks ) then
				SetAnimation({ Name = "GUI\\Screens\\Shrine\\PactActiveMax", DestinationId = traitFrameId })
			else
				SetAnimation({ Name = "GUI\\Screens\\Shrine\\PactActive", DestinationId = traitFrameId })
			end			
			SetAlpha({ Id = traitFrameId, Fraction = 1.0, Duration = 0.1 })
			table.insert( screen.Frames, traitFrameId )

			local traitIcon = CreateScreenComponent({ Name = "TraitTrayShrineIconButton", X = xOffset, Y = yOffset, Group = screen.ComponentData.DefaultGroup, Animation = metaUpgradeData.Icon, Scale = screen.ShrineIconScale, Alpha = 0 })
			AttachLua({ Id = traitIcon.Id, Table = traitIcon })
			traitIcon.Screen = screen
			traitIcon.OnMouseOverFunctionName = "TraitTrayIconButtonMouseOver"
			traitIcon.OnMouseOffFunctionName = "TraitTrayIconButtonMouseOff"
			traitIcon.OnPressedFunctionName = "PinTraitDetails"
			traitIcon.Icon = metaUpgradeData.Icon
			traitIcon.IconScale = iconScale
			traitIcon.OffsetX = xOffset
			traitIcon.OffsetY = yOffset
			traitIcon.PinIconScale = 0.28
			traitIcon.PinIconFrameScale = 0.0
			traitIcon.HighlightAnimScale = 0.27
			traitIcon.TrayHighlightAnimScale = 1.0
			SetAlpha({ Id = traitIcon.Id, Fraction = 1.0, Duration = 0.1 })
			if CurrentRun.ShrineUpgradesDisabled[shrineUpgradeName] then
				SetColor({ Id = traitIcon.Id, Color = screen.DisabledShrineIconColor })
				traitIcon.ShrineDisabled = true
			end
			CreateTextBox({
				Id = traitIcon.Id,
				UseDescription = true,
				VariableAutoFormat = "BoldFormatGraft",
				Scale = 0.0,
				Hide = true,
			})

			if args.DisableTooltips then
				ModifyTextBox({ Id = traitIcon.Id, BlockTooltip = true })
			end

			table.insert( components, traitIcon )
			local componentData = ShallowCopyTable( metaUpgradeData )
			componentData.Rank = rank
			traitIcon.TraitData = componentData
			screen.Icons[traitIcon.Id] = traitIcon

			--local traitFrameId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", Scale = 0.5 })
			--Attach({ Id = traitFrameId, DestinationId = traitIcon.Id })
			if not firstTrait then
				highlightedTrait = traitIcon
				firstTrait = true
			end

			local uniqueTraitName = TraitTrayGetUniqueName( traitIcon )
			if uniqueTraitName == args.HighlightName or uniqueTraitName == activeCategory.PrevHighlightName then
				highlightedTrait = traitIcon
			end

			screen.TraitComponentDictionary[uniqueTraitName] = traitIcon
			if screen.AutoPin and not activeCategory.OpenedOnce and IsPossibleShrineUpgradeAutoPin( metaUpgradeData ) then
				table.insert( screen.PossibleAutoPins, traitIcon )
			end
			
			displayedTraitNum = displayedTraitNum + 1
			--[[
			if displayedTraitNum % screen.ShrinesPerColumn == 0 then
				xOffset = xOffset + screen.ShrineSpacingX
				yOffset = ScreenHeight - screen.ShrineStartBottomOffset
			else
				yOffset = yOffset + screen.ShrineSpacingY
			end
			]]
			if displayedTraitNum % screen.ShrinesPerRow == 0 then
				xOffset = screen.ShrineStartX
				yOffset = yOffset + screen.ShrineSpacingY
			else
				xOffset = xOffset + screen.ShrineSpacingX
			end

		end
	end

	if GameState.ActiveShrineBounty ~= nil and ( CurrentRun.ActiveBounty == nil or CurrentHubRoom ~= nil ) then
		local bountyData = BountyData[GameState.ActiveShrineBounty]
		if bountyData ~= nil then
			local weaponName = nil
			local matchedWeapon = false
			local shrinePoints = nil
			if bountyData.CompleteGameStateRequirements ~= nil then
				for j, completeRequirement in ipairs( bountyData.CompleteGameStateRequirements ) do
					if completeRequirement.HasAny ~= nil then
						weaponName = completeRequirement.HasAny[1]
					end
					if completeRequirement.Value ~= nil then
						shrinePoints = completeRequirement.Value
					end
				end
			end

			SetAlpha({ Id = screen.Components.ActiveShrineBountyBacking.Id, Fraction = 1.0, Duration = 0.2 })
			SetAlpha({ Id = screen.Components.ActiveShrineBountyFrame.Id, Fraction = 1.0, Duration = 0.2 })
			SetAlpha({ Id = screen.Components.ActiveShrineBountyTarget.Id, Fraction = 1.0, Duration = 0.2 })
			SetAnimation({ DestinationId = screen.Components.ActiveShrineBountyTarget.Id, Name = ScreenData.Shrine.BountyTargetIcons[bountyData.Encounter] })
			SetAlpha({ Id = screen.Components.ActiveShrineBountyPoints.Id, Fraction = 1.0, Duration = 0.2 })
			ModifyTextBox({ Id = screen.Components.ActiveShrineBountyPoints.Id, LuaKey = "TempTextData", LuaValue = { RequiredShrinePoints = shrinePoints } })
			SetAlpha({ Id = screen.Components.ActiveShrineBountyWeapon.Id, Fraction = 1.0, Duration = 0.2 })
			SetAnimation({ DestinationId = screen.Components.ActiveShrineBountyWeapon.Id, Name = ScreenData.Shrine.BountyWeaponIcons[weaponName] })
		end
	else
		SetAlpha({ Id = screen.Components.ActiveShrineBountyBacking.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = screen.Components.ActiveShrineBountyFrame.Id, Fraction = 1.0, Duration = 0.2 })
		SetAnimation({ DestinationId = screen.Components.ActiveShrineBountyFrame.Id, Name = "GUI\\Screens\\Shrine\\TestamentInactive" })
	end

	if highlightedTrait ~= nil then
		wait( 0.02 )
		SetHighlightedTraitFrame( screen, highlightedTrait )
	end

end

function RemovePriorityPin( screen, possiblePins )

	for priorityIndex, priority in ipairs( screen.PinPriorities ) do
		for key, value in pairs( priority ) do
			for k, traitButton in pairs( possiblePins ) do
				if traitButton.TraitData[key] == value then
					RemoveValue( possiblePins, traitButton )
					return traitButton
				end
			end
		end
	end

	return RemoveRandomValue( possiblePins )
end

function IsPossibleTraitAutoPin( trait )

	if trait.IsWeaponEnchantment then
		return true
	end

	if trait.Rarity == "Epic" or trait.Rarity == "Legendary" or trait.Rarity == "Heroic" or trait.IsDuoBoon or trait.Frame == "Hammer" then
		return true
	end

	local traitCount = GetTraitCount( CurrentRun.Hero, trait )
	if traitCount >= 2 then
		return true
	end

	return false
end

function IsPossibleMetaUpgradeAutoPin( trait )
	if trait.Rarity == "Rare" or trait.Rarity == "Epic" or trait.Rarity == "Legendary" or trait.Rarity == "Heroic" then
		return true
	end
	return false
end

function IsPossibleShrineUpgradeAutoPin( trait )
	local rank = GetNumShrineUpgrades( trait.Name )
	if rank >= 1 then
		return true
	end
	return false
end

function TraitTrayScreenRemoveItems( screen )
	local componentIds = {}
	for id, iconComponent in pairs( screen.Icons ) do
		table.insert( componentIds, id )
	end
	for i, id in pairs( screen.Frames ) do
		table.insert( componentIds, id )
	end
	if IsEmpty( componentIds ) then
		return
	end
	local fadeOutTime = 0.1
	SetAlpha({ Ids = componentIds, Fraction = 0, Duration = fadeOutTime, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.HoverFrame.Id, Fraction = 0.0, Duration = 0.2 })

	screen.TraitComponentDictionary = {}

	-- Save current pins
	local activeCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	activeCategory.SavedPins = {}
	if screen.MouseOverButton ~= nil then
		activeCategory.PrevHighlightName = TraitTrayGetUniqueName( screen.MouseOverButton )
	end
	for pinIndex, pin in ipairs( screen.Pins ) do
		if not pin.Button.PinFromHover then
			table.insert( activeCategory.SavedPins, TraitTrayGetUniqueName( pin.Button ) )
		end
	end

	-- Remove all pins
	PinTraitDetails( screen, nil, { RemoveHovers = true } )
	for pinIndex, pin in ipairs( ShallowCopyTable( screen.Pins ) ) do
		thread( PinTraitDetails, screen, pin.Button, { RemoveCompletely = true } )
	end
	waitUnmodified( fadeOutTime )
	Destroy({ Ids = componentIds })
end

function TraitTrayScreenInfo( screen, button )
	if screen.MouseOverButton == nil then
		return
	end
	local traitData = screen.MouseOverButton.TraitData
	if traitData.TraitTrayOpenSpellScreen or traitData.Slot == "Spell" then
		TraitTrayScreenClose( screen, button )	
		local spellData = CurrentRun.Hero.SlottedSpell
		OpenTalentScreen( { ReadOnly = true, }, nil )
	elseif traitData.Slot == "Familiar" then
		TraitTrayScreenClose( screen, button )	
		local spellData = CurrentRun.Hero.SlottedSpell
		OpenFamiliarShopScreen( MapState.FamiliarUnit, { ReadOnly = true } )
	end
end

function TraitTrayScreenClose( screen, button )
	if screen == nil or screen.Closing then
		return
	end
	screen.Closing = true

	local allTraitComponents = MergeTables( HUDScreen.SlottedTraitComponents, HUDScreen.ActiveTraitComponents )
	for id, activeTraitComponent in pairs( allTraitComponents ) do
		activeTraitComponent.Screen = nil
		activeTraitComponent.OnMouseOverFunctionName = nil
		activeTraitComponent.OnMouseOffFunctionName = nil
		activeTraitComponent.OnPressedFunctionName = nil
		ModifyTextBox({ Id = activeTraitComponent.Id, BlockTooltip = true })
		activeTraitComponent.PinIndex = nil
		screen.Components["ActiveTrait"..TraitTrayGetUniqueName( activeTraitComponent )] = nil
		if activeTraitComponent.TraitData.HideInHUD then
			HUDHideTrait( activeTraitComponent.TraitData )
		end
	end

	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		local iconComponent = HUDScreen.Components[category.IconComponent]
		if iconComponent ~= nil then
			Move({ Id = iconComponent.Id, OffsetX = iconComponent.Data.X, OffsetY = iconComponent.Data.Y, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
		end
	end
	Move({ Id = HUDScreen.Components.BountyActive.Id, Distance = screen.BountyIconShiftX, Angle = 180, Duration = 0.2, EaseIn = 0.0, EaseOut = 1.0 })
	ModifyTextBox({ Id = HUDScreen.Components.BountyActive.Id, FadeTarget = 0.0, FadeDuration = 0.2 })

	local ids = GetAllIds( screen.Components )
	table.insert( ids, screen.HoverFrame )
	ConcatTableValues( ids, screen.Frames )
	for k, pin in pairs( screen.Pins ) do
		ConcatTableValues( ids, GetAllIds( pin.Components ) )
	end
	
	if screen.CloseFunctionName ~= nil then
		CallFunctionName( screen.CloseFunctionName, screen, screen.CloseFunctionArgs )
	end
	OnScreenCloseStarted( screen )
	SetAlpha({ Ids = { HUDScreen.Components.WeaponSlotIcon.Id, HUDScreen.Components.FamiliarSlotIcon.Id }, Duration = HUDScreen.FadeOutDuration, Fraction = 0 })
	if CurrentHubRoom ~= nil then 
		HideTraitUI( { KeepActiveComponents = true } )
	end
	if CurrentRun.ActiveBounty then
		SetAlpha({ Id = HUDScreen.Components.BountyActive.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.2 })
	end
	if TableLength( ActiveScreens ) <= 1 then
		ShowTraitUI()
	end
	CloseScreen( ids, 0.05 )

	screen.TitleBox = nil
	screen.RarityBox = nil
	screen.ExitMessageBox = nil
	StartHideAfterDelayThread()
	OnScreenCloseFinished( screen )
	SetAdvancedTooltipMixing( 0 )
	ShowObjectivesUI()

	if IsScreenOpen( "UpgradeChoice" ) then
		local screenIds = GetAllIds({ 
			ScreenAnchors.ChoiceScreen.Components.PurchaseButton1, 
			ScreenAnchors.ChoiceScreen.Components.PurchaseButton2, 
			ScreenAnchors.ChoiceScreen.Components.PurchaseButton3 })
		
		if screenIds[1] then
			TeleportCursor({ DestinationId = screenIds[1], ForceUseCheck = true })
		end
	elseif IsScreenOpen( "WellShop" ) then
		local screenIds = GetAllIds({
			ScreenAnchors.StoreScreen.Components.PurchaseButton1, 
			ScreenAnchors.StoreScreen.Components.PurchaseButton2, 
			ScreenAnchors.StoreScreen.Components.PurchaseButton3 })

		screenIds = CollapseTable(screenIds)
		
		if screenIds[1] then
			TeleportCursor({ DestinationId = screenIds[1], ForceUseCheck = true })
		end
	elseif IsScreenOpen( "SpellScreen" ) then
		local screenIds = GetAllIds({
			ActiveScreens.SpellScreen.Components.PurchaseButton1, 
			ActiveScreens.SpellScreen.Components.PurchaseButton2, 
			ActiveScreens.SpellScreen.Components.PurchaseButton3 })

		screenIds = CollapseTable(screenIds)
		
		if screenIds[1] then
			TeleportCursor({ DestinationId = screenIds[1], ForceUseCheck = true })
		end
	end
	--[[
	local choiceIds = GetIdsByType({ Name = "ButtonDialogueChoice"})	
	if not IsEmpty( choiceIds ) then
		local minId = choiceIds[1]
		local minY = GetLocation({ Id = minId }).Y
		for i, id in pairs(choiceIds) do
			if GetLocation({ Id = id }).Y < minY then
				minY = GetLocation({ Id = id }).Y 
				minId = id
			end
		end
		if minId then
			TeleportCursor({ DestinationId = minId, ForceUseCheck = true })
		end
	end
	]]

end

function TraitTrayCalcPinSpacing( screen )
	local numPins = #screen.Pins
	if numPins <= screen.DefaultPins then
		return screen.DefaultPinSpacing
	end
	local pinSpacing = screen.TotalPinSpace / numPins
	return pinSpacing
end

function TraitTrayUpdatePinLocations( screen, args )
	args = args or {}
	local pinSpacing = TraitTrayCalcPinSpacing( screen )
	--DebugPrint({ Text = "pinSpacing = "..pinSpacing })
	for index, pin in ipairs( screen.Pins ) do
		local toSlideIds = GetAllIds( pin.Components )
		if pin.Components.PinIndicator ~= nil then
			RemoveValueAndCollapse( toSlideIds, pin.Components.PinIndicator.Id )
		end
		if pin.Components.LockOverlay ~= nil then
			RemoveValueAndCollapse( toSlideIds, pin.Components.LockOverlay.Id )
		end
		local groupName = "TraitTrayHover"..index
		local newOffsetY = screen.PinOffsetY + (ScreenCenterNativeOffsetY * 2) + ((index - 1) * pinSpacing)
		--DebugPrint({ Text = "index = "..index..", newOffsetY = "..newOffsetY })
		local prevOffsetY = pin.Button.PinOffsetY
		local offsetYDelta = newOffsetY - prevOffsetY
		if offsetYDelta ~= 0 then
			--DebugPrint({ Text = "index = "..index.." - offsetYDelta = "..offsetYDelta })
			local angle = 270
			if offsetYDelta < 0 then
				angle = 90
			end
			Move({ Ids = toSlideIds, Angle = angle, Distance = math.abs(offsetYDelta), Speed = args.PinCollapseSpeed or screen.PinCollapseSpeed, SmoothStep = true, Additive = true })
			pin.Button.PinOffsetY = newOffsetY
			AddToGroup({ Ids = toSlideIds, Name = groupName, DrawGroup = true })
		end
	end
end

function PinTraitDetails( screen, button, args )

	args = args or {}

	if args.RemoveHovers then
		-- Remove the previous hover
		for k, pin in pairs( screen.Pins ) do
			if pin.Button.PinFromHover then
				thread( PinTraitDetails, screen, pin.Button, { Hover = true, RemoveOnly = true, } )
				break
			end
		end
	end

	if button == nil then
		return
	end

	if button.PinIndex ~= nil then

		if args.Hover and not button.PinFromHover then
			-- Pin was locked in, don't remove from hover off
			return
		end

		local fadeOutTime = 0.2

		if not args.Hover then
			local components = screen.Pins[button.PinIndex].Components
			if button.PinFromHover then
				-- Pin it
				button.PinFromHover = false
				if components.PinIndicator == nil then
					components.PinIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay", Scale = 0.5 })
					components.PinIndicatorDetails = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay", })
				end
				Attach({ Id = components.PinIndicator.Id, DestinationId = button.Id })
				SetAnimation({ DestinationId = components.PinIndicator.Id, Name = "TraitPinIn" })
				SetAnimation({ DestinationId = components.PinIndicatorDetails.Id, Name = button.HighlightAnim or "TraitTray_Highlight" })
				SetScale({ Id = components.PinIndicatorDetails.Id, Fraction = button.HighlightAnimScale })
				Attach({ Id = components.PinIndicatorDetails.Id, DestinationId = components.Icon.Id })
				TraitTrayPinOnPresentation( screen, button )
				return
			else
				-- Unpin it
				button.PinFromHover = true
				SetAnimation({ DestinationId = components.PinIndicator.Id, Name = "TraitPinOut" })
				SetAnimation({ DestinationId = components.PinIndicatorDetails.Id, Name = "Blank" })
				TraitTrayPinOffPresentation( screen, button )
				if not args.RemoveCompletely then
					return
				end
			end
		end

		-- Toggle off
		local pin = screen.Pins[button.PinIndex]
		local componentIds = GetAllIds( pin.Components )
		SetAlpha({ Ids = componentIds, Fraction = 0, Duration = fadeOutTime })
		ModifyTextBox({ Ids = componentIds, FadeTarget = 0, FadeDuration = fadeOutTime })

		-- Slide others up
		for index, pin in ipairs( screen.Pins ) do
			if button.PinIndex ~= nil and index > button.PinIndex and pin.Button ~= nil and pin.Button.PinIndex ~= nil then
				pin.Button.PinIndex = pin.Button.PinIndex - 1
			end
		end
		RemoveIndexAndCollapse( screen.Pins, button.PinIndex )
		button.PinIndex = nil
		if not args.RemoveCompletely then
			TraitTrayUpdatePinLocations( screen, args )
		end

		waitUnmodified( fadeOutTime )
		Destroy({ Ids = componentIds })
		return
	end

	if args.RemoveOnly then
		return
	end

	if #screen.Pins >= screen.MaxPins then
		return
	end

	local pinIndex = #screen.Pins + 1
	button.PinIndex = pinIndex
	button.PinFromHover = args.Hover
	local components = {}
	screen.Pins[pinIndex] = {}
	screen.Pins[pinIndex].Components = components
	screen.Pins[pinIndex].Button = button

	local offset =
	{
		X = screen.PinOffsetX,
		Y = screen.PinOffsetY + (ScreenCenterNativeOffsetY * 2),
	}
	local pinSpacing = TraitTrayCalcPinSpacing( screen )
	offset.Y = offset.Y + ((pinIndex - 1) * pinSpacing)
	button.PinOffsetY = offset.Y
	local groupName = "TraitTrayHover"..pinIndex

	local titleBoxYOffset = -20
	local textOffset = -70 - 350

	local backingAnim = button.TraitData.InfoBackingAnimation or ScreenData.UpgradeChoice.RarityBackingAnimations[button.TraitData.Rarity]
	--DebugPrint({ Text = "backignAnim = "..tostring(backignAnim) })
	components.DetailsBacking = CreateScreenComponent({ Name = "BoonSlotBase", Group = groupName, X = offset.X, Y = offset.Y + 200, Animation = backingAnim })
	SetInteractProperty({ DestinationId = components.DetailsBacking.Id, Property = "FreeFormSelectable", Value = false })
	local detailsData = DeepCopyTable( ScreenData.UpgradeChoice.DescriptionText )
	detailsData.Id = components.DetailsBacking.Id
	detailsData.BlockTooltip = true
	CreateTextBoxWithFormat( detailsData )

	components.BlessingBacking = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X, Y = offset.Y + 200 })
	local blessingData = DeepCopyTable( ScreenData.UpgradeChoice.DescriptionText )
	blessingData.Id = components.BlessingBacking.Id
	blessingData.OffsetY =  screen.BlessingOffsetY
	blessingData.AppendToId = components.DetailsBacking.Id
	CreateTextBoxWithFormat( blessingData )

	components.StatlineBackings = {}
	for lineNum = 1, 2 do

		screen.LineHeight = ScreenData.UpgradeChoice.LineHeight

		local columnOffset = math.abs( (ScreenData.UpgradeChoice.StatLineRight.OffsetX or 0) - (ScreenData.UpgradeChoice.StatLineLeft.OffsetX or 0) )
		local offsetY = (lineNum - 1) * screen.LineHeight
		local statLineKey = "StatlineBackings"..lineNum
		components[statLineKey.."Left"] = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + textOffset, Y = offset.Y + 200 })

		local statLineLeft = ShallowCopyTable( ScreenData.UpgradeChoice.StatLineLeft )
		statLineLeft.Id = components[statLineKey.."Left"].Id
		statLineLeft.OffsetX = 0
		statLineLeft.OffsetY = offsetY
		CreateTextBoxWithFormat( statLineLeft )

		components[statLineKey.."Right"] = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + textOffset, Y = offset.Y + 200 })
		local statLineRight = ShallowCopyTable( ScreenData.UpgradeChoice.StatLineRight )
		statLineRight.Id = components[statLineKey.."Right"].Id
		statLineRight.OffsetX = (statLineRight.OffsetX or 0) + columnOffset
		statLineRight.OffsetY = offsetY
		CreateTextBoxWithFormat( statLineRight )
		table.insert( components.StatlineBackings, { components[statLineKey.."Left"].Id, components[statLineKey.."Right"].Id } )
	end
	components.TitleBox = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + textOffset, Y = offset.Y + 170 })
	CreateTextBox(MergeTables({
		Id = components.TitleBox.Id,
		FontSize = 25,
		OffsetY = -17 + titleBoxYOffset,
		Color = color,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
	}, LocalizationData.TraitTrayScripts.TitleBox))

	components.RarityBox = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X, Y = offset.Y + 200 })
	local rarityTextBox = ShallowCopyTable( ScreenData.UpgradeChoice.RarityText )
	rarityTextBox.Id = components.RarityBox.Id
	CreateTextBox( rarityTextBox )
	
	components.FlavorText = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X, Y = offset.Y})
	
	CreateTextBox( 
		MergeTables(
		{ 
			Id = components.FlavorText.Id,
			LineSpacingBottom = GetLocalizedValue(0, { { Code = "zh-TW", Value = -7 } } ),
		},
		ScreenData.UpgradeChoice.FlavorText ))
	Attach({ Id = components.FlavorText.Id, DestinationId = components.DetailsBacking.Id })

	local iconOffsetX = ScreenData.UpgradeChoice.IconoffsetX
	local iconOffsetY = ScreenData.UpgradeChoice.IconoffsetX
	local iconOffset = { X = -447, Y = 135 }
	local overlayLayer = "Combat_Menu_Overlay_Backing"

	if button.TraitData.MetaUpgrade then
		components.Frame = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + iconOffset.X, Y = offset.Y + iconOffset.Y, Scale = button.PinIconFrameScale, Animation = "DevCard_EquippedHighlight" })
	end

	if button.Icon ~= nil or button.TraitData.Icon ~= nil then
		components.Icon = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + iconOffset.X, Y = offset.Y + iconOffset.Y, Scale = button.PinIconScale })
		SetAnimation({ DestinationId = components.Icon.Id, Name = button.Icon or button.TraitData.Icon })
	end
	
	if not button.TraitData.MetaUpgrade then
		components.Frame = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + iconOffset.X, Y = offset.Y + iconOffset.Y, Scale = button.PinIconFrameScale })
		local frameAnim = GetTraitFrame( button.TraitData )
		if frameAnim ~= nil then
			SetAnimation({ DestinationId = components.Frame.Id, Name = frameAnim })
		end
	end

	local screenData = ScreenData.UpgradeChoice

	if not IsEmpty( button.TraitData.Elements ) and IsGameStateEligible( CurrentRun, TraitRarityData.ElementalGameStateRequirements ) then
		local elementName = GetFirstValue( button.TraitData.Elements )
		components.ElementalIcon = CreateScreenComponent({ Name = TraitElementData[elementName].Icon, Group = groupName, Scale = 0.5 })
		Attach({ Id = components.ElementalIcon.Id, DestinationId = components.DetailsBacking.Id, OffsetX = screenData.ElementIcon.XShift - 320, OffsetY = screenData.ElementIcon.YShift + 14 })
	end

	if not args.Hover then
		-- Immediately Pin it
		if components.PinIndicator == nil then
			components.PinIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, Scale = 0.5 })
			components.PinIndicatorDetails = CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, Scale = 0.8 })
		end
		Attach({ Id = components.PinIndicator.Id, DestinationId = button.Id })
		if button.TraitData.Slot == "Assist" or button.TraitData.Slot == "Keepsake" then
			SetAnimation({ DestinationId = components.PinIndicator.Id, Name = "TraitPinIn_NoHighlight" })
		else
			SetAnimation({ DestinationId = components.PinIndicator.Id, Name = "TraitPinIn" })
		end
		Attach({ Id = components.PinIndicatorDetails.Id, DestinationId = components.Icon.Id })
		SetAnimation({ DestinationId = components.PinIndicatorDetails.Id, Name = "Blank" })
		TraitTrayPinOnPresentation( screen, button )
	end

	SetTraitTextData( button.TraitData, { OldOnly = true } )
	
	local showingTrait = nil
	local rarityValue = 0
	for s, existingTrait in pairs( CurrentRun.Hero.Traits) do
		if (AreTraitsIdentical(existingTrait, button.TraitData) and rarityValue < GetRarityValue( existingTrait.Rarity )) then
			showingTrait = existingTrait
			rarityValue = GetRarityValue( showingTrait.Rarity )
		end
	end
	if showingTrait then
		button.OverrideRarity = showingTrait.Rarity
	end
	SetTraitTrayDetails(
	{ 
		Button = button, 
		DetailsBox = components.DetailsBacking,
		BlessingsBox = components.BlessingBacking,
		DetailTextArgs = textArgs,
		RarityBox = components.RarityBox, 
		TitleBox = components.TitleBox, 
		--Patch = components.Patch, 
		Icon = components.Icon, 
		StatLines = components.StatlineBackings,
		ElementalIcon = components.ElementalIcon,
		FlavorText = components.FlavorText,
	})

	if button.ShrineDisabled then
		components.LockOverlay = CreateScreenComponent({ Name = "BaseInteractableButton", Group = "Combat_Menu_TraitTray_Overlay", Animation = "ShrineSlotLocked" })
		Attach({ Id = components.LockOverlay.Id, DestinationId = components.DetailsBacking.Id })
	end

	TraitTrayUpdatePinLocations( screen, args )

end

function TraitTrayIconButtonMouseOver( button )
	local screen = button.Screen
	if screen.Closing then
		return
	end
	screen.MouseOverButton = button
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	if ( button.TraitData.Slot == "Spell" or button.TraitData.Slot == "Familiar" ) and screen.Components.InfoButton.OnPressedFunctionName ~= nil then
		SetAlpha({ Id = screen.Components.InfoButton.Id, Fraction = 1.0, Duration = 0.2 })
	end
	Teleport({ Id = screen.Components.HoverFrame.Id, DestinationId = button.Id })
	SetAnimation({ DestinationId = screen.Components.HoverFrame.Id, Name = button.HighlightAnim or screen.Components.HoverFrame.Data.Graphic })
	SetScale({ Id = screen.Components.HoverFrame.Id, Fraction = button.TrayHighlightAnimScale or 1.0 })
	SetAlpha({ Id = screen.Components.HoverFrame.Id, Fraction = 1.0, Duration = 0.2 })
	SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX })
	SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })
	PinTraitDetails( screen, button, { Hover = true, RemoveHovers = true } )
	TraitTrayHoverOnPresentation( screen, button )
	if screen.Pins ~= nil then
		local pin = screen.Pins[button.PinIndex]
		if pin ~= nil and not pin.Button.FromHover and pin.Components.PinIndicatorDetails ~= nil then
			SetAnimation({ DestinationId = pin.Components.PinIndicatorDetails.Id, Name = button.HighlightAnim or "TraitTray_Highlight" })
			SetScale({ Id = pin.Components.PinIndicatorDetails.Id, Fraction = button.HighlightAnimScale, Duration = 0 })
			return
		end
	end
end

function TraitTrayIconButtonMouseOff( button )
	local screen = button.Screen
	screen.MouseOverButton = nil
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.InfoButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.HoverFrame.Id, Fraction = 0.0, Duration = 0.2 })
	PinTraitDetails( screen, nil, { RemoveHovers = true } )
	if screen.Pins ~= nil then
		local pin = screen.Pins[button.PinIndex]
		if pin ~= nil and pin.Components.PinIndicatorDetails ~= nil then
			SetAnimation({ DestinationId = pin.Components.PinIndicatorDetails.Id, Name = "Blank" })
			return
		end
	end
end

function SetHighlightedTraitFrame( screen, button )
	screen.CursorStartX = button.OffsetX
	screen.CursorStartY = button.OffsetY
	TeleportCursor({ OffsetX = button.OffsetX, OffsetY = button.OffsetY, ForceUseCheck = true })
end

function SetTraitTrayDetails( args )

	local button = args.Button or {}
	local detailsBox = args.DetailsBox
	local blessingBox = args.BlessingsBox
	local rarityBox = args.RarityBox
	local titleBox = args.TitleBox
	local patch = args.Patch
	local icon = args.Icon
	local statlines = args.StatLines
	local elementalIcon = args.ElementalIcon 
	local flavorText = args.FlavorText
	local traitData = args.TraitData or button.TraitData

	local forTraitTray = true
	if args.ForBoonInfo then
		forTraitTray = false
	end

	local title = GetTraitTooltipTitle( traitData )
	local traitCount = 1
	if not button.ForBoonInfo then 
		traitCount = GetTraitCount( CurrentRun.Hero, { TraitData = traitData } )
	end
	if traitCount > 1 then
		title = "TraitLevel_Current"
		traitData.OldLevel = traitCount
		if not traitData.Title then
			traitData.Title = GetTraitTooltipTitle( traitData )
		end
	end

	local titleColor = Color.White
	local rarityPatchColor = Color.Transparent
	
	if traitData.CustomRarityColor then
		rarityPatchColor = traitData.CustomRarityColor
		titleColor = traitData.CustomRarityColor
	elseif button.OverrideRarity ~= nil and button.OverrideRarity ~= "Common" then
		rarityPatchColor = Color["BoonPatch"..button.OverrideRarity]
		titleColor = Color["BoonPatch"..button.OverrideRarity]
	elseif traitData.Rarity ~= nil and traitData.Rarity ~= "Common" then
		rarityPatchColor = Color["BoonPatch"..traitData.Rarity]
		titleColor = Color["BoonPatch"..traitData.Rarity]
	else
		local rarityLevel = GetNumShrineUpgrades( traitData.Name )
		if rarityLevel > 0 then
			local rarityName = TraitRarityData.WeaponRarityUpgradeOrder[rarityLevel]
			titleColor = Color["BoonPatch"..rarityName]
		end
	end

	if titleBox ~= nil then
		ModifyTextBox({ Id = titleBox.Id, Text = title, Color = titleColor, LuaKey = "TooltipData", LuaValue = traitData })
	end

	local name = GetTraitTooltip( traitData, { ForTraitTray = forTraitTray } )
	if detailsBox ~= nil then
		ModifyTextBox({ Id = detailsBox.Id, Text = name, LuaKey = "TooltipData", LuaValue = traitData, UseDescription = true })
	end
	if blessingBox ~= nil and traitData.OnExpire ~= nil and traitData.OnExpire.TraitData ~= nil then
		ModifyTextBox({ Id = blessingBox.Id, Text = traitData.OnExpire.TraitData.Name, LuaKey = "TooltipData", LuaValue = traitData, UseDescription = true })
	end

	if button.Id then
		DestroyTextBox({ Id = button.Id })
		CreateTextBox({
			Text = name,
			LuaKey = "TooltipData",
			LuaValue = traitData,
			Id = button.Id,
			UseDescription = true,
			TextSymbolScale = 0,
			Color = Color.Transparent,
		})
	end
	if statlines ~= nil then
		local targetStatLines = traitData.StatLines
		if forTraitTray and traitData.TrayStatLines then
			targetStatLines = traitData.TrayStatLines 
		end		
		if traitData.CustomStatLinesWithShrineUpgrade and GetNumShrineUpgrades( traitData.CustomStatLinesWithShrineUpgrade.ShrineUpgradeName ) > 0 then
			targetStatLines = traitData.CustomStatLinesWithShrineUpgrade.StatLines
			if forTraitTray and traitData.CustomStatLinesWithShrineUpgrade.TrayStatLines then
				targetStatLines = traitData.CustomStatLinesWithShrineUpgrade.TrayStatLines 
			end		
		end

		if not IsEmpty( targetStatLines ) then
			local appendToId = nil
			if #targetStatLines <= 1 then
				appendToId = detailsBox.Id
			end
			for lineNum, statLine in ipairs( targetStatLines ) do
				ModifyTextBox({ Id = statlines[lineNum][1], Text = statLine, LuaKey = "TooltipData", LuaValue = traitData, AppendToId = appendToId })
				ModifyTextBox({ Id = statlines[lineNum][2], Text = statLine, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData, AppendToId = appendToId })
				CreateTextBox({
					Text = statLine,
					LuaKey = "TooltipData",
					LuaValue = traitData,
					UseDescription = true, 
					Id = button.Id,
					TextSymbolScale = 0,
					Color = Color.Transparent,
				})
			end
		end
	end

	local rarityText = " "
	if traitData.CustomRarityName then
		rarityText = traitData.CustomRarityName
	elseif traitData.CustomRarityLevels ~= nil then
		local rarityLevel = GetRarityValue( button.OverrideRarity or traitData.Rarity )
		rarityText = traitData.CustomRarityLevels[rarityLevel]
	elseif traitData.IsTalent then
		local rarityLevel = GetRarityValue( traitData.Rarity )
		rarityText = TraitRarityData.TalentRarity[rarityLevel]
	elseif traitData.IsWeaponEnchantment then
		local rarityLevel = GetRarityValue( traitData.Rarity )
		rarityText = TraitRarityData.AspectRarityText[rarityLevel]
	elseif traitData.Ranks ~= nil then
		local rarityLevel = GameState.ShrineUpgrades[traitData.Name]
		rarityText = TraitRarityData.ShrineRarityText[rarityLevel]
		local rarityName = TraitRarityData.WeaponRarityUpgradeOrder[rarityLevel]
		rarityPatchColor = Color["BoonPatch"..rarityName]
		titleColor = rarityPatchColor
	elseif button.OverrideRarity then
		rarityText = "Boon_"..tostring(button.OverrideRarity)
	elseif traitData.Rarity ~= nil then
		rarityText = "Boon_"..tostring(traitData.Rarity)
	end

	if rarityBox ~= nil then
		ModifyTextBox({ Id = rarityBox.Id, Color = rarityPatchColor, Text = rarityText })
	end
	SetAnimation({ Name = button.Icon or GetTraitIcon( traitData ), DestinationId = icon.Id })

	local flavorTextStr = nil
	if traitData.SourceName ~= nil then
		local sourceData = MetaUpgradeCardData[traitData.SourceName]
		if sourceData ~= nil then
			flavorTextStr = sourceData.FlavorTextData[1].Name
		end
	end

	if flavorText ~= nil then
		ModifyTextBox({ Id = flavorText.Id,
			Text = flavorTextStr or traitData.FlavorText or traitData.SignoffText or " ",
		})
	end
end

function GetTraitIndex( trait )
	if trait.Slot == nil then
		if CurrentRun.Hero and CurrentRun.Hero.RecentTraits then
			for i, recentTraitData in pairs(CurrentRun.Hero.RecentTraits) do
				if AreTraitsIdentical( trait, recentTraitData ) then
					return i
				end
			end
			return -1
		else
			return -1
		end
	end

	if trait.Slot == "Assist" then
		return -1
	elseif trait.Slot == "Melee" then
		return 0
	elseif trait.Slot == "Secondary" then
		return 1
	elseif trait.Slot == "Ranged" then
		return 2
	elseif trait.Slot == "Rush" then
		return 3
	elseif trait.Slot == "Mana" then
		return 4
	elseif trait.Slot == "Spell" then
		return 5
	elseif trait.Slot == "Keepsake" then
		return 6
	elseif trait.Slot == "Familiar" then
		return 7
	end
end

function IsShownInHUD( trait )
	if trait.Hidden then
		return false
	end
	if trait.Slot ~= nil and Contains( ScreenData.HUD.SlottedTraitOrder, trait.Slot ) then
		return true
	end
	if SessionMapState.HUDTraitsShown[trait.Name] then
		return true
	end
	if trait.ShowInHUD or (trait.RemainingUses or 0) > 0 or (trait.Uses or 0) > 0 or ( trait.RoomsPerUpgrade ~= nil and trait.RoomsPerUpgrade.Amount > 1 and IsTraitActive(trait) ) then
		return true
	end
	return false
end

function CleanRecentTraitsRecord()
	if not CurrentRun or not CurrentRun.Hero or not CurrentRun.Hero.RecentTraits then
		return
	end
	for index, recentTraitData in pairs(CurrentRun.Hero.RecentTraits) do
		if not HeroHasTrait(recentTraitData.Name) or not recentTraitData.Id then
			CurrentRun.Hero.RecentTraits[index] = nil
		end
	end
	CurrentRun.Hero.RecentTraits = CollapseTable( CurrentRun.Hero.RecentTraits )
end

function TraitTrayGetUniqueName( traitComponent )
	if traitComponent.ActiveOffsetIndex ~= nil then
		return traitComponent.TraitData.Name..traitComponent.ActiveOffsetIndex
	else
		return traitComponent.TraitData.Name
	end
end