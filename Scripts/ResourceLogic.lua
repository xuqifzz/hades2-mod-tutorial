function AddResources( eventSource, args )
	for name, amount in pairs( args ) do
		AddResource( name, amount, "AddResources" )
	end
end

function AddResource( name, amount, source, args )

	if amount == nil or amount == 0 then
		return
	end

	local roundedAmount = round( amount )

	args = args or {}
	local resourceData = ResourceData[name]
	if resourceData == nil then
		DebugAssert({ Condition = false, Text = "Missing ResourceData for "..name, Owner = "James" })
	end
	if CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead then
		local healthGained = 0
		local traitValues = GetHeroTraitValues("OnResourceMaxHealth")
		for i, traitData in pairs (traitValues) do
			if traitData.ResourceNamesLookup[name] then
				healthGained = healthGained + traitData.Amount
			end
		end
		if healthGained > 0 then
			AddMaxHealth( healthGained, "ResourceMaxHealth" )
		end
	end
	GameState.Resources[name] = (GameState.Resources[name] or 0) + roundedAmount
	if not args.NoLifetimeEffect then
		GameState.LifetimeResourcesGained[name] = (GameState.LifetimeResourcesGained[name] or 0) + roundedAmount
	end
	if not (args.IgnoreAsLastResourceGained or resourceData.IgnoreAsLastResourceGained) then
		GameState.UnviewedLastResourceGained = name
	end
	CurrentRun.ResourcesGained[name] = (CurrentRun.ResourcesGained[name] or 0) + roundedAmount

	if resourceData.OnAddedFunctionName ~= nil then
		CallFunctionName( resourceData.OnAddedFunctionName, name, amount, source, args )
	end
	if resourceData.OnAddVoiceLines ~= nil and not args.SkipVoiceLines then
		thread( PlayVoiceLines, resourceData.OnAddVoiceLines, true )
	end
	if not resourceData.SkipInventoryObjective then
		if CurrentRun.CurrentRoom.Encounter ~= nil and not IsEmpty(RequiredKillEnemies) then
			CurrentRun.CurrentRoom.Encounter.CheckInventoryObjective = true
		else
			CheckObjectiveSet( "OpenInventory" )
		end
	end

	UpdateResourceUI( name, GameState.Resources[name] )

	if args.PresentationFunctionName ~= nil then
		args.ResourceName = name
		args.Amount = amount
		args.NewTotal = GameState.Resources[name] or 0
		args.IconPath = resourceData.IconPath
		thread( CallFunctionName, args.PresentationFunctionName, source, args )
	elseif not args.Silent then
		thread( ResourceGainPresentation, name, amount, args )
	end
end

function SpendResources( resourceCosts, source, args )
	if resourceCosts == nil then
		return
	end
	args = args or {}
	local delay = args.Delay or 0

	for resourceName, resourceCost in pairs( resourceCosts ) do
		if args.StaggerDelay then
			delay = delay + args.StaggerDelay
		end
		args.Delay = delay
		SpendResource( resourceName, resourceCost, source, args )
	end
end

function SpendResource( name, amount, source, args )

	if GameState.Resources[name] == nil or GameState.Resources[name] < amount or amount == 0 then
		return false
	end

	args = args or {}

	local roundedAmount = round( amount )

	GameState.Resources[name] = (GameState.Resources[name] or 0) - roundedAmount
	if not args.NoLifetimeEffect then
		GameState.LifetimeResourcesSpent[name] = (GameState.LifetimeResourcesSpent[name] or 0) + roundedAmount
	end

	CurrentRun.ResourcesSpent[name] = (CurrentRun.ResourcesSpent[name] or 0) + roundedAmount
	if not args.SkipQuestStatusCheck then
		thread( CheckQuestStatus )
	end

	if not args.SkipUpdateResourceUI then
		UpdateResourceUI( name, GameState.Resources[name] )
	end
	
	local resourceData = ResourceData[name]
	if resourceData and resourceData.OnSpentFunctionName ~= nil then
		CallFunctionName( resourceData.OnSpentFunctionName , name, amount, source, args )
	end
	if not resourceData.SkipResourceSpendPresentation then
		thread( ResourceSpendPresentation, name, amount, args )
	end
	return true

end

function GetResourceAmount( name )
	return GameState.Resources[name] or 0
end

function GetResourceCost( resourceCosts, resourceName )
	
	for name, amount in pairs( resourceCosts ) do
		if name == resourceName then
			return amount 
		end
	end
	return 0
end

function HasResourceCost( resourceCosts )
	if not resourceCosts then
		return false
	end
	for name, amount in pairs( resourceCosts ) do
		if amount > 0 then
			return true
		end
	end
	return false
end

function HasResource( name, amount )
	if amount == 0 then
		return true
	end
	amount = amount or 1
	if GameState.Resources[name] == nil or GameState.Resources[name] < amount then
		return false
	end
	return true
end

function HasResources( resourceCost )
	if resourceCost == nil then
		return true
	end
	for resourceName, amount in pairs( resourceCost ) do
		if not HasResource( resourceName, amount ) then
			return false
		end
	end
	return true
end

function OnGiftPointsAdded( name, amount, source, args )

	args = args or {}
	if amount > 0 then
		local healthGained = GetTotalHeroTraitValue("GiftPointHealthMultiplier")
		if healthGained > 0 then
			AddMaxHealth( healthGained, "DionysusMaxHealthTrait" )
		end
	end

	if not IsEmpty( ActiveEnemies ) then
		for id, unit in pairs( ActiveEnemies ) do
			if not unit.PostCombatTravel and CanReceiveGift( unit ) then
				SetAvailableUseText( unit )
			end
		end
	end
end

OnControlPressed{ "Inventory",
	function( triggerArgs )
		if CanOpenInventoryScreen() then
			OpenInventoryScreen( { DefaultCategoryIndex = GameState.InventoryCategoryIndex } )
		else
			if IsInputAllowed({}) then
				CannotOpenCodexPresentation()
			end
		end
	end
}

function CanOpenInventoryScreen()
	if not IsEmpty( ActiveScreens ) then
		return false
	end
	if not IsInputAllowed({}) then
		return false
	end
	if not CurrentRun.Hero.IsDead then
		if not CurrentRun.CurrentRoom.AllowInventoryInCombat and ( IsCombatEncounterActive( CurrentRun, { IgnoreMainEncounter = CurrentRun.CurrentRoom.IgnoreMainEncounterForInventory } ) or not IsEmpty( RequiredKillEnemies ) or not IsEmpty( MapState.AggroedUnits ) ) then
			return false
		end
		if CurrentRun.CurrentRoom.StartedChallengeEncounter and not CurrentRun.CurrentRoom.ChallengeEncounter.Completed then
			return false
		end
		if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BlockCodexBeforeStart and not CurrentRun.CurrentRoom.Encounter.Completed then
			return false
		end
	end
	return true
end

function OpenInventoryScreen( args )
	
	local screenData = ScreenData.InventoryScreen
	if IsScreenOpen( screenData.Name ) then
		return
	end

	args = args or {}

	local screen = DeepCopyTable( screenData )
	local components = screen.Components

	screen.Args = args

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )

	CreateScreenFromData( screen, screen.ComponentData )

	screen.PinStartX = screen.PinStartX + ScreenCenterNativeOffsetX
	screen.PinStartY = screen.PinStartY + ScreenCenterNativeOffsetY

	if GameState.GamePhase and GamePhaseData.GamePhases[ GameState.GamePhase ] then
		SetAnimation({ DestinationId = components.MoonPhaseButton.Id, Name = GamePhaseData.GamePhases[ GameState.GamePhase ].Graphic })
		ModifyTextBox({ Id = components.MoonPhaseButton.Id, Text = GamePhaseData.GamePhases[ GameState.GamePhase ].Text  })
	end
	screen.ActiveCategoryIndex = args.DefaultCategoryIndex or 1

	screen.NumCategories = 0
	screen.GridStartX = screen.GridStartX + ScreenCenterNativeOffsetX
	screen.GridStartY = screen.GridStartY + ScreenCenterNativeOffsetY

	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	local categoryTitleX = screen.CategoryStartX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY
	for slotIndex, category in ipairs( screen.ItemCategories ) do
		if category.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, category, category.GameStateRequirements ) then
			if not args.CategoryLocked or slotIndex == screen.ActiveCategoryIndex then
				local slotName = category.Name
				local categoryButton = CreateScreenComponent({ Name = "ButtonInventoryTab", X = categoryTitleX, Y = screen.CategoryStartY, Group = "Combat_Menu_Overlay" })
				categoryButton.OnPressedFunctionName = "InventoryScreenSelectCategory"
				categoryButton.Category = slotName
				categoryButton.CategoryIndex = slotIndex
				screen.Components["Category"..slotName] = categoryButton

				local categoryButtonIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Scale = screen.CategoryIconScale,
					X = categoryTitleX + screen.CategoryIconOffsetX, Y = screen.CategoryStartY + screen.CategoryIconOffsetY })
				SetAnimation({ DestinationId = categoryButtonIcon.Id, Name = category.Icon })
				screen.Components["CategoryIcon"..slotName] = categoryButtonIcon

				if GameState.UnviewedLastResourceGained ~= nil then
					for i, resourceName in ipairs( category ) do
						if resourceName == GameState.UnviewedLastResourceGained then
							screen.ActiveCategoryIndex = slotIndex
							break
						end
					end
				end

				--CreateTextBoxWithScreenFormat( screen, categoryButton, "CategoryFormat", { Text = slotName } )

				--[[
				if slotIndex ~= screen.ActiveCategoryIndex and HasUnviewedCosmetic( slotName ) then
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
					Attach({ Id = components[completeButtonKey].Id, DestinationId = screen.Components["Category"..slotName].Id, OffsetX = 0, OffsetY = -20 })
				end
				]]
				screen.NumCategories = screen.NumCategories + 1
			end
		else
			category.Locked = true
		end

		categoryTitleX = categoryTitleX + screen.CategorySpacingX
	end

	if args.CategoryLocked then
		components.ScrollLeft.OnPressedFunctionName = nil
		components.ScrollRight.OnPressedFunctionName = nil
	end

	-- Resource Grid
	InventoryScreenDisplayCategory( screen, screen.ActiveCategoryIndex, args )
	if not screen.CursorSet then
		local category = screen.ItemCategories[screen.ActiveCategoryIndex]
		if category.OpenFunctionName == nil then
			TeleportCursor({ OffsetX = screen.GridStartX, OffsetY = screen.GridStartY, ForceUseCheck = true })
		else
			TeleportCursor({ OffsetX = screen.PinStartX, OffsetY = screen.PinStartY, ForceUseCheck = true })
		end
	end

	InventoryScreenOpenPresentation( screen )
	InventoryScreenUpdateVisibility( screen )
	UpdateResourceInteractionText( screen )
	thread( MarkObjectivesComplete, { "OpenInventory", "OpenInventorySkelly" } )
	wait( 0.02 )

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )
	return screen

end

function InventoryScreenDisplayCategory( screen, categoryIndex, args )

	args = args or {}
	local components = screen.Components
	
	-- Cleanup prev category
	local prevCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	if prevCategory.CloseFunctionName ~= nil then
		CallFunctionName( prevCategory.CloseFunctionName, screen )
	else
		for i, resourceName in ipairs( prevCategory ) do
			if components[resourceName] ~= nil then
				Destroy({ Id = components[resourceName].Id })
			end
		end
	end

	ModifyTextBox({ Id = components.InfoBoxName.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxDetails.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxFlavor.Id, FadeTarget = 0.0, })
	if screen.Components["Category"..prevCategory.Name] ~= nil then
		StopAnimation({ DestinationId = screen.Components["Category"..prevCategory.Name].Id, Name = "InventoryTabHighlightActiveCategory" })
	end

	local category = screen.ItemCategories[categoryIndex]
	if category.Locked then
		return
	end
	local slotName = category.Name

	-- Highlight new category
	CreateAnimation({ DestinationId = screen.Components["Category"..slotName].Id, Name = "InventoryTabHighlightActiveCategory", Group = "Combat_Menu_TraitTray" })
	ModifyTextBox({ Id = screen.Components.CategoryTitleText.Id, Text = category.Name })

	screen.ActiveCategoryIndex = categoryIndex

	SetAnimation({ DestinationId = components.Background.Id, Name = category.Background or screen.ComponentData.Background.AnimationName })

	if category.GamepadNavigation ~= nil then
		SetGamepadNavigation( category )
	else
		SetGamepadNavigation( screen )
	end

	if category.OpenFunctionName ~= nil then
		CallFunctionName( category.OpenFunctionName, screen )
		return
	end
	
	local resourceLocation = { X = screen.GridStartX, Y = screen.GridStartY }
	local columnNum = 1
	for i, resourceName in ipairs( category ) do

		local resourceData = ResourceData[resourceName]
		if (GameState.LifetimeResourcesGained[resourceName] or 0) > 0 or ( resourceData.RevealGameStateRequirements ~= nil and IsGameStateEligible( CurrentRun, resourceData, resourceData.RevealGameStateRequirements ) ) then

			local textLines = nil
			local canBeGifted = false
			local canBePlanted = false
			if screen.Args.PlantTarget ~= nil then
				if GardenData.Seeds[resourceName] then
					canBePlanted = true
				end
			elseif screen.Args.GiftTarget ~= nil then
				if screen.Args.GiftTarget.UnlimitedGifts ~= nil and screen.Args.GiftTarget.UnlimitedGifts[resourceName] then
					canBeGifted = true
				else
					local spending = {}
					spending[resourceName] = 1
					textLines = GetRandomEligibleTextLines( screen.Args.GiftTarget, screen.Args.GiftTarget.GiftTextLineSets, GetNarrativeDataValue( screen.Args.GiftTarget, "GiftTextLinePriorities" ), { Spending = spending } )
					if textLines ~= nil then
						canBeGifted = true
					end
				end
			end

			local button = CreateScreenComponent({ Name = "ButtonInventoryItem", Scale = resourceData.IconScale or 1.0, Sound = "/SFX/Menu Sounds/GodBoonMenuClose", Group = "Combat_Menu_Overlay", X = resourceLocation.X, Y = resourceLocation.Y })
			AttachLua({ Id = button.Id, Table = button })
			button.Screen = screen
			button.ResourceData = resourceData
			components[resourceName] = button
			SetAnimation({ DestinationId = button.Id, Name = resourceData.IconPath or resourceData.Icon })
		
			if canBePlanted then
				if HasResource( resourceName, 1 ) then
					button.ContextualAction = "Menu_Plant"
					button.OnPressedFunctionName = "GardenPlantSeed"
				else
					SetColor({ Id = button.Id, Color = Color.Black })
					button.MouseOverText = "InventoryScreen_SeedNotAvailable"
				end
			elseif canBeGifted then
				if HasResource( resourceName, 1 ) then
					button.ContextualAction = "Menu_Gift"
					button.OnPressedFunctionName = "GiveSelectedGift"
					button.TextLines = textLines
				else
					SetColor({ Id = button.Id, Color = Color.Black })
					button.MouseOverText = "InventoryScreen_GiftNotAvailable"
				end				
			elseif screen.Args.PlantTarget ~= nil then
				SetColor({ Id = button.Id, Color = Color.Black })
				button.MouseOverText = "InventoryScreen_SeedNotWanted"
			elseif screen.Args.GiftTarget ~= nil then
				SetColor({ Id = button.Id, Color = Color.Black })
				button.MouseOverText = "InventoryScreen_GiftNotWanted"
			end

			CreateTextBoxWithScreenFormat( screen, button, "ResourceCountFormat", { Text = GameState.Resources[resourceName] or 0 } )

			button.MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu"
			button.OnMouseOverFunctionName = "MouseOverResourceItem"
			button.OnMouseOffFunctionName = "MouseOffResourceItem"

			if (resourceName == args.InitialSelection) or (args.InitialSelection == nil and resourceName == GameState.UnviewedLastResourceGained) then
				UnviewedLastResourceGainedPresentation( screen, button )
				GameState.UnviewedLastResourceGained = nil
				TeleportCursor({ OffsetX = resourceLocation.X, OffsetY = resourceLocation.Y, ForceUseCheck = true })
				screen.CursorSet = true
			end

			if columnNum < screen.GridWidth then
				columnNum = columnNum + 1
				resourceLocation.X = resourceLocation.X + screen.GridSpacingX
			else
				resourceLocation.Y = resourceLocation.Y + screen.GridSpacingY
				resourceLocation.X = screen.GridStartX
				columnNum = 1
			end
		end
		
	end

end

function InventoryScreenNextCategory( screen, button )
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
	InventoryScreenChangeCategoryPresentation( screen, nextCategoryIndex )
	InventoryScreenDisplayCategory( screen, nextCategoryIndex )
	wait( 0.02 )
	local category = screen.ItemCategories[nextCategoryIndex]
	if category.OpenFunctionName == nil then
		TeleportCursor({ OffsetX = screen.GridStartX, OffsetY = screen.GridStartY, ForceUseCheck = true })
	else
		TeleportCursor({ OffsetX = screen.PinStartX, OffsetY = screen.PinStartY, ForceUseCheck = true })
	end
end

function InventoryScreenPrevCategory( screen, button )
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
	InventoryScreenChangeCategoryPresentation( screen, nextCategoryIndex )
	InventoryScreenDisplayCategory( screen, nextCategoryIndex )
	local category = screen.ItemCategories[nextCategoryIndex]
	wait( 0.02 )
	if category.OpenFunctionName == nil then
		TeleportCursor({ OffsetX = screen.GridStartX, OffsetY = screen.GridStartY, ForceUseCheck = true })
	else
		TeleportCursor({ OffsetX = screen.PinStartX, OffsetY = screen.PinStartY, ForceUseCheck = true })
	end
end

function InventoryScreenSelectCategory( screen, button )
	InventoryScreenChangeCategoryPresentation( screen, button.CategoryIndex )
	InventoryScreenDisplayCategory( screen, button.CategoryIndex )
end

function CloseInventoryScreen( screen, button )
	InventoryScreenClosePresentation( screen, button )
	CloseScreenButton( screen, button )
	ShowCombatUI( screen.Name )
	GameState.InventoryCategoryIndex = screen.ActiveCategoryIndex
end


function GiveSelectedGift( screen, button )
	AddInputBlock({ Name = "GiveSelectedGift" })
	HideCombatUI( "GiveSelectedGift" )
	CloseInventoryScreen( screen, button )
	RemoveInputBlock({ Name = "GiveSelectedGift" })
	GiveGift( screen.Args.GiftTarget, button.ResourceData.Name, 1, button.TextLines )
end

function AddStoreItemPin( name, storeName )
	local pin = { Name = name, StoreName = storeName }
	table.insert( GameState.StoreItemPins, pin )
end

function RemoveStoreItemPin( name, args )
	args = args or {}
	local foundIndex = 0
	for index, pin in ipairs( GameState.StoreItemPins ) do
		if pin.Name == name then
			foundIndex = index
			break
		end
	end
	if foundIndex > 0 then
		if args.Purchase then
			GameState.StoreItemPinsPurchased[name] = (GameState.StoreItemPinsPurchased[name] or 0) + 1
		end
		RemoveIndexAndCollapse( GameState.StoreItemPins, foundIndex )
	end
end

function HasStoreItemPin( name )
	local foundIndex = 0
	for index, pin in ipairs( GameState.StoreItemPins ) do
		if pin.Name == name then
			return true
		end
	end
	return false
end

function HasPinWithResource( resourceName )
	for index, pin in ipairs( GameState.StoreItemPins ) do
		local store = _G[pin.StoreName]
		if store ~= nil then
			local itemData = store[pin.Name]
			if itemData ~= nil then
				local cost = itemData.ResourceCost or itemData.Cost
				if cost ~= nil and (cost[resourceName] or 0) > 0 then
					return true
				end
			end
		end
	end
	return false
end

function InventoryScreenDisplayPins( screen )
	local locationX = screen.PinStartX
	local locationY = screen.PinStartY
	local components = screen.Components
	screen.PinIds = screen.PinIds or {}
	if IsEmpty( GameState.StoreItemPins ) then
		ModifyTextBox({ Id = components.EmptyCategoryHint.Id, FadeTarget = 1.0, Duration = 0.2 })
	else
		ModifyTextBox({ Id = components.EmptyCategoryHint.Id, FadeTarget = 0.0, Duration = 0.2 })
	end
	screen.NumItems = 0
	screen.PinButtons = {}
	for index, pin in ipairs( GameState.StoreItemPins ) do
		local store = _G[pin.StoreName]
		if store ~= nil then
			local itemData = store[pin.Name]
			if itemData ~= nil and itemData.Name ~= nil then

				screen.NumItems = screen.NumItems + 1
				
				local buttonBacking = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = screen.ComponentData.DefaultGroup,
					Animation = "InventoryScreenForgetMeNotButton",
					X = locationX,
					Y = locationY })
				SetInteractProperty({ DestinationId = buttonBacking.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
				SetInteractProperty({ DestinationId = buttonBacking.Id, Property = "FreeFormSelectOffsetY", Value = screen.FreeFormSelectOffsetY })
				table.insert( screen.PinIds, buttonBacking.Id )
				buttonBacking.OnMouseOverFunctionName = "InventoryScreenMouseOverPin"
				buttonBacking.OnMouseOffFunctionName = "InventoryScreenMouseOffPin"
				AttachLua({ Id = buttonBacking.Id, Table = buttonBacking })
				buttonBacking.Screen = screen
				buttonBacking.ItemData = itemData
				components[itemData.Name.."Backing"] = buttonBacking
				table.insert( screen.PinButtons, buttonBacking )
				
				local icon = CreateScreenComponent({ Name = "BlankObstacle", Scale = (pin.IconScale or itemData.IconScale or 1.0) * screen.PinIconScale, Group = screen.ComponentData.DefaultGroup,
					X = locationX + screen.PinIconOffsetX,
					Y = locationY + screen.PinIconOffsetY,
					})
				table.insert( screen.PinIds, icon.Id )
				components[itemData.Name.."Icon"] = icon
				
				local iconName = itemData.Icon or itemData.Image
				if iconName ~= nil then
					SetAnimation({ DestinationId = icon.Id, Name = iconName })
				end

				local displayName = itemData.DisplayName or itemData.HelpTextId or itemData.Name
				local tooltipData = {}
				local traitName = itemData.TraitUpgrade or itemData.Name
				if itemData.TraitUpgrade ~= nil then
					displayName = itemData.TraitUpgrade.."_Upgrade"
					tooltipData.NextLevel = GetWeaponUpgradeLevel( traitName ) + 1
					tooltipData.AspectRarityText = TraitRarityData.AspectRarityText[tooltipData.NextLevel]
				end

				local nameFormat = "PinNameAffordableFormat"
				if not HasResources( itemData.UpgradeResoureCost or itemData.ResourceCost or itemData.Cost ) then
					nameFormat = "PinNameUnaffordableFormat"
				end
				CreateTextBoxWithScreenFormat( screen, buttonBacking, nameFormat, { Text = displayName, LuaKey = "TooltipData", LuaValue = tooltipData } )

				locationY = locationY + screen.PinSpacingY
				if screen.NumItems % screen.PinsPerPage == 0 then
					locationY = screen.PinStartY
				end
			end
		end
	end
	InventoryScreenUpdateVisibility( screen )
end

function InventoryScreenHidePins( screen )
	Destroy({ Ids = screen.PinIds })
	Destroy({ Ids = screen.CostIds })
	SetAlpha({ Id = screen.Components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	ModifyTextBox({ Id = screen.Components.EmptyCategoryHint.Id, FadeTarget = 0.0, Duration = 0.2 })
	screen.NumItems = 0
	InventoryScreenUpdateVisibility( screen )
end

function InventoryScreenDisplayLineHistory( screen )
	local locationX = screen.PinStartX
	local locationY = screen.PinStartY
	local components = screen.Components
	SetAlpha({ Id = screen.Components.LineHistory.Id, Fraction = 1.0, Duration = 0.0 })
	SetAlpha({ Id = screen.Components.LineHistoryGradient.Id, Fraction = 1.0, Duration = 0.0 })
	SetAlpha({ Id = screen.Components.LineHistoryScrollbar.Id, Fraction = 1.0, Duration = 0.0 })
	SetAlpha({ Id = screen.Components.LineHistoryScrollbarSlider.Id, Fraction = 1.0, Duration = 0.0 })
	screen.NumItems = 0

	if not screen.LineHistorySetup then
		screen.LineHistorySetup = true
		for index, textLineEntry in ipairs( CurrentRun.LineHistory ) do
			screen.NumItems = screen.NumItems + 1

			local source = EnemyData[textLineEntry.SourceName] or LootData[textLineEntry.SourceName] or { Name = "NPC_Unnamed_01" } 
			local sourceName = textLineEntry.SpeakerName or source.Speaker or source.Name
			local formatName = "LineHistoryFormat"..sourceName
			if TextFormats[formatName] == nil then
				local newFormat = { Name = formatName, Color = textLineEntry.SubtitleColor or source.NarrativeFadeInColor or source.SubtitleColor, Graft = true, AutoSetDataProperties = true }
				CreateFormatContainer( newFormat )
				TextFormats[formatName] = newFormat
			end

			local numLineBreaks = 2
			if index == 1 then
				numLineBreaks = 0
			end
			ModifyTextBox({ Id = screen.Components.LineHistory.Id,
				RawText = "{#"..formatName.."}",
				Append = true,
				NumLineBreaks = numLineBreaks,
			})
			ModifyTextBox({ Id = screen.Components.LineHistory.Id,
				RawText = GetDisplayName({ Text = sourceName }),
				Append = true,
			})
			ModifyTextBox({ Id = screen.Components.LineHistory.Id,
				RawText = "{#Prev} ",
				Append = true,
			})

			ModifyTextBox({ Id = screen.Components.LineHistory.Id,
				Text = textLineEntry.Text,
				RawText = textLineEntry.RawText,
				Append = true,
				NumLineBreaks = 1,
			})

			locationY = locationY + screen.LineHistorySpacingY
			if screen.NumItems % screen.PinsPerPage == 0 then
				locationY = screen.PinStartY
			end
		end
		-- Start at bottom
		wait( 0.02 )
		ModifyTextBox({ Id = screen.Components.LineHistory.Id, ScrollAmount = -99999 })
	end
	
	InventoryScreenUpdateVisibility( screen )
end

function InventoryScreenHideLineHistory( screen )
	SetAlpha({ Id = screen.Components.LineHistory.Id, Fraction = 0.0, Duration = 0.0 })
	screen.NumItems = 0
	InventoryScreenUpdateVisibility( screen )
	SetAlpha({ Id = screen.Components.LineHistoryGradient.Id, Fraction = 0.0, Duration = 0.0 })
	SetAlpha({ Id = screen.Components.LineHistoryScrollbar.Id, Fraction = 0.0, Duration = 0.0 })
	SetAlpha({ Id = screen.Components.LineHistoryScrollbarSlider.Id, Fraction = 0.0, Duration = 0.0 })
	SetAlpha({ Id = screen.Components.ScrollUp.Id, Fraction = 0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.ScrollDown.Id, Fraction = 0, Duration = 0.2 })
end

function InventoryScreenScrollUp( screen, button )
	--ModifyTextBox({ Id = screen.Components.LineHistory.Id, ScrollAmount = 100 })
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.PinsPerPage
	InventoryScreenUpdateVisibility( screen, { AnimateSlider = true } )
	TeleportCursor({ OffsetX = screen.PinStartX - 30, OffsetY = screen.PinStartY + ((screen.PinsPerPage - 1) * screen.PinSpacingY), ForceUseCheck = true })
	--WeaponShopScreenScrollPresentation( screen, button )
end

function InventoryScreenScrollDown( screen, button )
	--ModifyTextBox({ Id = screen.Components.LineHistory.Id, ScrollAmount = -100 })
	if screen.ScrollOffset + screen.PinsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.PinsPerPage
	InventoryScreenUpdateVisibility( screen, { AnimateSlider = true } )
	TeleportCursor({ OffsetX = screen.PinStartX - 30, OffsetY = screen.PinStartY, ForceUseCheck = true })
	--WeaponShopScreenScrollPresentation( screen, button )
end

function InventoryScreenUpdateVisibility( screen, args )

	args = args or {}
	local components = screen.Components
	local offIds = {}
	local onIds = {}

	for itemNum, button in ipairs( screen.PinButtons ) do		
		local itemData = button.ItemData
		local visibleIndex = itemNum - screen.ScrollOffset
		local buttonBacking = components[itemData.Name.."Backing"]
		local icon = components[itemData.Name.."Icon"]
		if visibleIndex >= 1 and visibleIndex <= screen.PinsPerPage and not buttonBacking.Removed then
			-- Page in view
			Teleport({ Id = buttonBacking.Id, OffsetX = screen.PinStartX, OffsetY = screen.PinStartY + ((visibleIndex - 1) * screen.PinSpacingY) })
			table.insert( onIds, buttonBacking.Id )

			Teleport({ Id = icon.Id, OffsetX = screen.PinStartX + screen.PinIconOffsetX, OffsetY = screen.PinStartY + ((visibleIndex - 1) * screen.PinSpacingY) })
			table.insert( onIds, icon.Id )

		else
			-- Page out of view
			table.insert( offIds, buttonBacking.Id )
			table.insert( offIds, icon.Id )
		end
	end

	SetAlpha({ Ids = onIds, Fraction = 1.0 })
	UseableOn({ Ids = onIds })

	SetAlpha({ Ids = offIds, Fraction = 0.0 })
	UseableOff({ Ids = offIds, ForceHighlightOff = true })

	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	local scrollFraction = GetScrollOffsetFraction({ Id = screen.Components.LineHistory.Id })

	if category.AlwaysShowScrollArrows then

		local sliderTargetY = Lerp( screen.LineHistoryScrollbarSliderTopY + ScreenCenterNativeOffsetY, screen.LineHistoryScrollbarSliderBottomY + ScreenCenterNativeOffsetY, scrollFraction )
		local slideDuration = 0.0
		if args.AnimateSlider then
			slideDuration = 0.2
		end
		Move({ Id = components.LineHistoryScrollbarSlider.Id, OffsetX = components.LineHistoryScrollbarSlider.X, OffsetY = sliderTargetY, Duration = slideDuration, EaseIn = 0.0, EaseOut = 1.0 })

		if scrollFraction <= 0.0 then
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
			SetAlpha({ Id = components.LineHistoryGradient.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
		else
			SetAlpha({ Id = components.LineHistoryGradient.Id, Fraction = 1, Duration = 0.1 })
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollUp.Id })
		end
	else
		SetAlpha({ Id = components.LineHistoryGradient.Id, Fraction = 0, Duration = 0.1 })
		if screen.ScrollOffset <= 0 or screen.NumItems == 0 then
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
		else
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollUp.Id })
		end
	end

	if category.AlwaysShowScrollArrows then
		if scrollFraction >= 1.0 then
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
		else
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollDown.Id })
		end
	else
		if screen.ScrollOffset + screen.PinsPerPage >= screen.NumItems  then
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
		else
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollDown.Id })
		end
	end

end

function InvenotryScreenRemovePin( screen, button )
	if screen.SelectedPin == nil or screen.SelectedPin.Removed then
		return
	end
	RemoveStoreItemPin( screen.SelectedPin.ItemData.Name )
	screen.SelectedPin.Removed = true
	InventoryScreenUpdateVisibility( screen )
end

function AddRerolls( source, args )
	args = args or {}
	CurrentRun.NumRerolls = CurrentRun.NumRerolls + args.Amount
	UpdateRerollUI( CurrentRun.NumRerolls )
end

function InventoryScreenMoonPhaseButtonMouseOver( button )
	local screen = button.Screen
	SetAlpha({ Id = screen.Components.MoonPhaseButtonHighlight.Id, Fraction = 1.0, Duration = 0.1 })
end

function InventoryScreenMoonPhaseButtonMouseOff( button )
	local screen = button.Screen
	SetAlpha({ Id = screen.Components.MoonPhaseButtonHighlight.Id, Fraction = 0.0, Duration = 0.1 })
end

function InventoryScreenUpdate( screen, args, elapsed )
	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	if category.AlwaysShowScrollArrows then
		if IsControlDown({ Name = "Up" }) or ( IsControlDown({ Name = "Select" }) and GetUseTargetId({ }) == screen.Components.ScrollUp.Id ) then
			ModifyTextBox({ Id = screen.Components.LineHistory.Id, ScrollAmount = screen.LineHistoryScrollSpeed * elapsed })
			InventoryScreenUpdateVisibility( screen )
		elseif IsControlDown({ Name = "Down" }) or ( IsControlDown({ Name = "Select" }) and GetUseTargetId({ }) == screen.Components.ScrollDown.Id ) then
			ModifyTextBox({ Id = screen.Components.LineHistory.Id, ScrollAmount = -screen.LineHistoryScrollSpeed * elapsed })
			InventoryScreenUpdateVisibility( screen )
		end
	end
end
