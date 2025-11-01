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
		return
	end
	if CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead then
		local healthGained = 0
		local traitValues = GetHeroTraitValues("OnResourceMaxHealth")
		for i, traitData in pairs (traitValues) do
			if traitData.ResourceNamesLookup[name] then
				healthGained = healthGained + traitData.Amount * roundedAmount
			end
		end
		local manaGained = 0
		local traitValues = GetHeroTraitValues("OnResourceMaxMana")
		for i, traitData in pairs (traitValues) do
			if traitData.ResourceNamesLookup[name] then
				manaGained = manaGained + traitData.Amount * roundedAmount
			end
		end
		if healthGained > 0 and manaGained > 0 then
			AddMaxHealth( healthGained, "ResourceMaxHealth", { Silent = true })
			AddMaxMana( manaGained, "ResourceMaxMana", { Silent = true })
			thread( BonusHealthAndManaPresentation, healthGained, manaGained , 0.5 )
		elseif healthGained > 0 then
			AddMaxHealth( healthGained, "ResourceMaxHealth" )
		elseif manaGained > 0 then
			AddMaxMana( manaGained, "ResourceMaxMana" )
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

	if verboseLogging and not GameState.ResourceAssertIgnored then
		if (GameState.Resources[name] or 0) > (GameState.LifetimeResourcesGained[name] or 0) then
			DebugAssert({ Condition = false, Owner = "Gavin",
				Text = "Resource "..name.." has more Current ("..tostring(GameState.Resources[name])..") than Lifetime ("..tostring(GameState.LifetimeResourcesGained[name])..")" })
		end
	end

	if resourceData.OnAddedFunctionName ~= nil then
		CallFunctionName( resourceData.OnAddedFunctionName, name, amount, source, args )
	end
	if resourceData.OnAddVoiceLines ~= nil and not args.SkipVoiceLines then
		thread( PlayVoiceLines, resourceData.OnAddVoiceLines, true )
	end
	if not resourceData.SkipInventoryObjective and not args.SkipInventoryObjective then
		if CurrentRun.CurrentRoom.Encounter ~= nil and not IsEmpty(RequiredKillEnemies) then
			CurrentRun.CurrentRoom.Encounter.CheckInventoryObjective = true
		else
			CheckObjectiveSet( "OpenInventory" )
		end
	end

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
	
	local resourceData = ResourceData[name]
	if resourceData and resourceData.OnSpentFunctionName ~= nil then
		CallFunctionName( resourceData.OnSpentFunctionName , name, amount, source, args )
	end
	if not resourceData.SkipResourceSpendPresentation and not args.SkipResourceSpendPresentation then
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
		for id, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
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
	if SessionState.InFlashback or SessionMapState.BlockInventory then
		return false
	end

	if not CurrentRun.Hero.IsDead and not CurrentRun.CurrentRoom.AllowInventoryInCombat then
		if IsCombatEncounterActive( CurrentRun, { IgnoreMainEncounter = CurrentRun.CurrentRoom.IgnoreMainEncounterForInventory, CheckBlockCodexBeforeStart = true } ) then
			return false
		end
		if not IsEmpty( RequiredKillEnemies ) then
			return false
		end
		if IsAggroedUnitBlockingInteract() then
			return false
		end
	end
	return not AreScreensActive() and IsInputAllowed({})
end

function OpenInventoryScreen( args )

	local screenData = ScreenData.InventoryScreen
	if IsScreenOpen( screenData.Name ) then
		return
	end

	args = args or {}

	AddInputBlock({ Name = "OpenInventoryScreen" })

	SetPlayerInvulnerable( "Inventory" )
	AddPlayerImmuneToForce( "Inventory" )
	CurrentRun.Hero.UntargetableFlags.Inventory = true

	SessionMapState.BlockInfoBanners = true
	if SetThreadWait( "InfoBanner", 0.01 ) then
		wait( 0.2 )
	end

	local screen = DeepCopyTable( screenData )
	local components = screen.Components

	screen.Args = args

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )

	CreateScreenFromData( screen, screen.ComponentData )

	screen.PinStartX = screen.PinStartX + ScreenCenterNativeOffsetX
	screen.PinStartY = screen.PinStartY + ScreenCenterNativeOffsetY

	if GameState.GamePhase and GamePhaseData.GamePhases[GameState.GamePhase] then
		SetAnimation({ DestinationId = components.MoonPhaseButton.Id, Name = GamePhaseData.GamePhases[GameState.GamePhase].Graphic })
		ModifyTextBox({ Id = components.MoonPhaseButton.Id, Text = GamePhaseData.GamePhases[GameState.GamePhase].Text  })
	end
	if GameState.BadgeRank ~= nil then
		local badgeData = BadgeData[BadgeOrderData[GameState.BadgeRank]]
		if badgeData ~= nil then
			SetAnimation({ DestinationId = components.BadgeRankIcon.Id, Name = badgeData.Icon })
		end
	end
	screen.ActiveCategoryIndex = args.DefaultCategoryIndex or 1
	if screen.ActiveCategoryIndex > #screen.ItemCategories then
		screen.ActiveCategoryIndex = #screen.ItemCategories
	end

	screen.NumCategories = 0
	screen.GridStartX = screen.GridStartX + ScreenCenterNativeOffsetX
	screen.GridStartY = screen.GridStartY + ScreenCenterNativeOffsetY

	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	local categoryTitleX = screen.CategoryStartX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY
	for slotIndex, category in ipairs( screen.ItemCategories ) do
		local locked = true
		if category.GameStateRequirements == nil or IsGameStateEligible( category, category.GameStateRequirements ) then
			if not args.CategoryLocked or slotIndex == screen.ActiveCategoryIndex then
				local slotName = category.Name
				local categoryButton = CreateScreenComponent({ Name = "ButtonInventoryTab",
					Group = "Combat_Menu_Overlay",
					X = categoryTitleX,
					Y = screen.CategoryStartY,
					Alpha = 0.0,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.6,
				})
				categoryButton.OnPressedFunctionName = "InventoryScreenSelectCategory"
				categoryButton.Category = slotName
				categoryButton.CategoryIndex = slotIndex
				screen.Components["Category"..slotName] = categoryButton

				local categoryButtonIcon = CreateScreenComponent({ Name = "BlankObstacle",
					Group = "Combat_Menu_Overlay",
					Scale = screen.CategoryIconScale,
					X = categoryTitleX + screen.CategoryIconOffsetX,
					Y = screen.CategoryStartY + screen.CategoryIconOffsetY,
					Alpha = 0.0,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.6,
				})
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

				if slotIndex ~= screen.ActiveCategoryIndex then
					local hasNewItem = false
					for i, itemName in ipairs(screen.ItemCategories[slotIndex]) do
						if CanShowResourceInInventory( ResourceData[itemName] ) and not GameState.ResourcesViewed[itemName] then
							hasNewItem = true
						end
					end
					if hasNewItem then
						-- New icon
						local newButtonKey = "NewIcon"..slotName
						components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle",
							Animation = "NewTabStar",
							Group = screen.ComponentData.DefaultGroup,
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.6,
							Scale = screen.TabStarScale,
						})
						Attach({ Id = components[newButtonKey].Id, DestinationId = categoryButton.Id, OffsetX = screen.TabStarOffsetX, OffsetY = screen.TabStarOffsetY })
					end
				end

				locked = false
				screen.NumCategories = screen.NumCategories + 1
			end
		else
			category.Locked = true
		end
		  
		if locked then
			local categoryButton = CreateScreenComponent({ Name = "BlankObstacle",
				X = categoryTitleX, Y = screen.CategoryStartY, Group = "Combat_Menu_Overlay",
				Animation = "GUI/Screens/Inventory/CategoryTabInactive",
				Scale = 0.5,
				Alpha = 0.0,
				AlphaTarget = 1.0,
				AlphaTargetDuration = 0.6,
			})
			screen.Components["InactiveCategory"..category.Name] = categoryButton
		end

		categoryTitleX = categoryTitleX + screen.CategorySpacingX
	end

	-- Resource Grid
	args.FirstOpen = true
	InventoryScreenDisplayCategory( screen, screen.ActiveCategoryIndex, args )

	InventoryScreenOpenPresentation( screen )
	InventoryScreenUpdateVisibility( screen )
	UpdateResourceInteractionText( screen )
	thread( MarkObjectivesComplete, { "OpenInventory", "OpenInventorySkelly" } )
	wait( 0.02 )

	if screen.CursorStartX ~= nil and screen.CursorStartY ~= nil then
		TeleportCursor({ OffsetX = screen.CursorStartX, OffsetY = screen.CursorStartY, ForceUseCheck = true })
	else
		local category = screen.ItemCategories[screen.ActiveCategoryIndex]
		if category.OpenFunctionName == nil then
			TeleportCursor({ OffsetX = screen.GridStartX, OffsetY = screen.GridStartY, ForceUseCheck = true })
		else
			TeleportCursor({ OffsetX = screen.PinStartX, OffsetY = screen.PinStartY, ForceUseCheck = true })
		end
	end
	RemoveInputBlock({ Name = "OpenInventoryScreen" })

	screen.KeepOpen = true
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
			local resourceComponent = components[resourceName]
			if resourceComponent ~= nil then
				if resourceComponent.NewIcon ~= nil then
					Destroy({ Id = resourceComponent.NewIcon.Id })
				end
				Destroy({ Id = resourceComponent.Highlight.Id })
				Destroy({ Id = resourceComponent.Id })
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

	local newButtonKey = "NewIcon"..slotName
	if components[newButtonKey] ~= nil then
		Destroy({ Id = components[newButtonKey].Id })
	end

	screen.ActiveCategoryIndex = categoryIndex

	screen.CloseAnimation = category.CloseAnimation
	if args.FirstOpen then
		SetAnimation({ DestinationId = components.Background.Id, Name = category.OpenAnimation })
	else
		local fromMap = screen.TransitionAnimationMap[prevCategory.CloseAnimation]
		local transitionAnimationName = fromMap[category.CloseAnimation]
		if transitionAnimationName ~= nil then
			SetAnimation({ DestinationId = components.Background.Id, Name = transitionAnimationName })
		end
	end

	if category.GamepadNavigation ~= nil then
		SetGamepadNavigation( category )
	else
		SetGamepadNavigation( screen )
	end

	if category.OpenFunctionName ~= nil then
		CallFunctionName( category.OpenFunctionName, screen )
		return
	end

	if screen.Args.PlantTarget ~= nil and GameState.WorldUpgrades.WorldUpgradeGardenMultiPlant then
		components.PinButton.OnPressedFunctionName = "GardenMultiPlantSeed"
	end
	
	local resourceLocation = { X = screen.GridStartX, Y = screen.GridStartY }
	local columnNum = 1
	for i, resourceName in ipairs( category ) do

		local resourceData = ResourceData[resourceName]
		if CanShowResourceInInventory( resourceData ) then

			local textLines = nil
			local canBeGifted = false
			local canBePlanted = false
			local spending = nil
			if screen.Args.PlantTarget ~= nil then
				if GardenData.Seeds[resourceName] then
					canBePlanted = true
				end
			elseif screen.Args.GiftTarget ~= nil then
				if screen.Args.GiftTarget.UnlimitedGifts ~= nil and screen.Args.GiftTarget.UnlimitedGifts[resourceName] then
					canBeGifted = true
				else
					spending = {}
					spending[resourceName] = 1
					textLines = GetRandomEligibleTextLines( screen.Args.GiftTarget, screen.Args.GiftTarget.GiftTextLineSets, GetNarrativeDataValue( screen.Args.GiftTarget, "GiftTextLinePriorities" ), { Spending = spending } )
					if textLines ~= nil then
						canBeGifted = true
						spending = textLines.Cost
					end
				end
			end

			local alphaTarget = 1.0
			local alphaTargetDuration = 0.2
			if not HasResource( resourceName, 1 ) then
				alphaTarget = screen.NoResourceIconAlpha
			end
			if args.FirstOpen then
				alphaTargetDuration = 0.6
			end

			local button = CreateScreenComponent({ Name = "ButtonInventoryItem",
				Scale = resourceData.IconScale or 1.0,
				Sound = "/SFX/Menu Sounds/IrisMenuBack",
				Group = "Combat_Menu_Overlay",
				X = resourceLocation.X,
				Y = resourceLocation.Y,
				Alpha = 0.0,
				AlphaTarget = alphaTarget,
				AlphaTargetDuration = alphaTargetDuration,
			})
			
			button.Screen = screen
			button.ResourceData = resourceData
			components[resourceName] = button
			SetAnimation({ DestinationId = button.Id, Name = resourceData.IconPath or resourceData.Icon })

			local buttonHighlight = CreateScreenComponent({ Name = "BlankObstacle",
				Group = "Combat_Menu_Overlay_Additive",
				X = resourceLocation.X,
				Y = resourceLocation.Y,
				Alpha = 0.0,
				AlphaTarget = 1.0,
				AlphaTargetDuration = alphaTargetDuration,
			})
			components[resourceName.."Highlight"] = buttonHighlight
			button.Highlight = buttonHighlight
		
			if canBePlanted then
				if HasResource( resourceName, 1 ) then
					button.ContextualAction = "Menu_Plant"
					button.OnPressedFunctionName = "GardenPlantSeed"

					if GameState.WorldUpgrades.WorldUpgradeGardenMultiPlant then
						local numEmptyPlots = 0
						for id, plot in pairs( GameState.GardenPlots ) do
							if plot.SeedName == nil then
								numEmptyPlots = numEmptyPlots + 1
							end
						end
						if numEmptyPlots > 1 and HasResource( resourceName, 2 ) then
							button.PinContextualAction = "Menu_MultiPlant"
							button.PlantAmount = math.min( numEmptyPlots, GameState.Resources[resourceName] )
						end
					end

					if #GardenData.Seeds[resourceName].RandomOutcomes == 1 then
						local growsIntoName = GetFirstKey( GardenData.Seeds[resourceName].RandomOutcomes[1].AddResources )
						local amountNeededByPins = GetResourceAmountNeededByPins( growsIntoName )
						if amountNeededByPins > 0 then
							local pinAnimation = "StoreItemPin"
							if HasResource( growsIntoName, amountNeededByPins ) then
								pinAnimation = "StoreItemPin_Complete"
							end
							button.PinIcon = CreateScreenComponent({
								Name = "BlankObstacle",
								Group = "Combat_Menu_Overlay",
								Scale = screen.SeedPinIconScale,
								X = resourceLocation.X + screen.SeedPinIconOffsetX,
								Y = resourceLocation.Y + screen.SeedPinIconOffsetY,
								Animation = pinAnimation,
								Alpha = 0.0,
								AlphaTarget = 1.0,
								AlphaTargetDuration = 0.2,
							})
							components[resourceName.."PinIcon"] = button.PinIcon
						end
					end
				else
					SetRGB({ Id = button.Id, Color = Color.Black })
					button.MouseOverText = "InventoryScreen_SeedNotAvailable"
				end
			elseif canBeGifted then
				if HasResources( spending ) then
					button.ContextualAction = "Menu_Gift"
					button.OnPressedFunctionName = "GiveSelectedGift"
					button.TextLines = textLines
				else
					SetRGB({ Id = button.Id, Color = Color.Black })
					button.MouseOverText = "InventoryScreen_GiftNotAvailable"
				end				
			elseif screen.Args.PlantTarget ~= nil then
				SetRGB({ Id = button.Id, Color = Color.Black })
				button.MouseOverText = "InventoryScreen_SeedNotWanted"
			elseif screen.Args.GiftTarget ~= nil then
				SetRGB({ Id = button.Id, Color = Color.Black })
				button.MouseOverText = "InventoryScreen_GiftNotWanted"
			end

			CreateTextBoxWithScreenFormat( screen, button, "ResourceCountFormat", { Text = GameState.Resources[resourceName] or 0 } )

			button.MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu"
			button.OnMouseOverFunctionName = "MouseOverResourceItem"
			button.OnMouseOffFunctionName = "MouseOffResourceItem"

			button.Viewable = not screen.Args.CategoryLocked or button.OnPressedFunctionName ~= nil
			if button.Viewable then
				-- highlight the initial selection, or the last resource you collected
				if resourceName == args.InitialSelection then
					screen.CursorStartX = resourceLocation.X
					screen.CursorStartY = resourceLocation.Y
				elseif resourceName == GameState.UnviewedLastResourceGained then
					UnviewedLastResourceGainedPresentation( screen, button )
					GameState.UnviewedLastResourceGained = nil
					screen.CursorStartX = resourceLocation.X
					screen.CursorStartY = resourceLocation.Y
				end

				-- mark unviewed resources as "new"
				if not GameState.ResourcesViewed[resourceName] then
					local newIcon = CreateScreenComponent({ Name = "BlankObstacle", Animation = "MusicPlayerNewTrack", Group = screen.ComponentData.DefaultGroup, Scale = screen.NewItemStarScale, })
					if args.FirstOpen then
						SetAlpha({ Id = newIcon.Id, Fraction = 0.0 })
						SetAlpha({ Id = newIcon.Id, Fraction = 1.0, Duration = 0.6 })
					end
					Attach({ Id = newIcon.Id, DestinationId = button.Id, OffsetX = screen.NewItemStarOffsetX, OffsetY = screen.NewItemStarOffsetY })
					button.NewIcon = newIcon
					components["NewIcon"..resourceName] = newIcon
				end
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
	if button.CategoryIndex ~= screen.ActiveCategoryIndex then
		InventoryScreenChangeCategoryPresentation( screen, button.CategoryIndex )
		InventoryScreenDisplayCategory( screen, button.CategoryIndex )
	end
end

function CloseInventoryScreen( screen, button )
	killTaggedThreads( "MultiPlantPulse" )

	SetPlayerVulnerable( "Inventory" )
	RemovePlayerImmuneToForce( "Inventory" )
	CurrentRun.Hero.UntargetableFlags.Inventory = nil

	SessionMapState.BlockInfoBanners = false
	local currentCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	if currentCategory.CloseFunctionName ~= nil then
		CallFunctionName( currentCategory.CloseFunctionName, screen )
	end
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
	local amount = 1
	if button.TextLines ~= nil then
		amount = button.TextLines.Cost[button.ResourceData.Name]
	end
	GiveGift( screen.Args.GiftTarget, button.ResourceData.Name, amount, button.TextLines )
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

function GetResourceAmountNeededByPins( resourceName )
	local totalCost = 0
	for index, pin in ipairs( GameState.StoreItemPins ) do
		local store = _G[pin.StoreName]
		if store ~= nil and store ~= TraitData then
			local itemData = store[pin.Name]
			if itemData ~= nil then
				local cost = itemData.ResourceCost or itemData.Cost
				if cost ~= nil and (cost[resourceName] or 0) > 0 then
					totalCost = totalCost + cost[resourceName]
				end
			end
		end
	end
	return totalCost
end

function InventoryScreenDisplayPins( screen )
	local components = screen.Components
	screen.NumItems = #GameState.StoreItemPins
	if screen.NumItems <= 0 then
		ModifyTextBox({ Id = screen.Components.EmptyCategoryHint.Id, FadeTarget = 1.0, FadeDuration = 0.2 })
	end
	screen.ScrollOffset = 0
	InventoryScreenUpdateVisibility( screen )
end

function InventoryScreenHidePins( screen )
	Destroy({ Ids = screen.PinIds })
	Destroy({ Ids = screen.CostIds })
	SetAlpha({ Id = screen.Components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	ModifyTextBox({ Id = screen.Components.EmptyCategoryHint.Id, FadeTarget = 0.0, FadeDuration = 0.0 })
	screen.NumItems = 0
	DestroyTextBox({ Id = screen.Components.RequirementsText.Id })
	Destroy({ Ids = screen.TraitRequirements })
	screen.TraitRequirements = {}
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
			local color = textLineEntry.SubtitleColor or source.NarrativeFadeInColor or source.SubtitleColor or Color.NarratorVoice
			local formatName = string.format("LineHistoryFormat_R%d_G%d_B%d", color[1], color[2], color[3])
			if TextFormats[formatName] == nil then
				local newFormat = { Name = formatName, Color = color, Graft = true, AutoSetDataProperties = true }
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
	UseableOff({ Id = screen.Components.ScrollUp.Id })
	UseableOff({ Id = screen.Components.ScrollDown.Id })
end

function InventoryScreenScrollUp( screen, button )
	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	if category.AlwaysShowScrollArrows then
		ModifyTextBox({ Id = screen.Components.LineHistory.Id, ScrollAmount = screen.LineHistoryScrollTick })
		InventoryScreenUpdateVisibility( screen )
		return
	end
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.PinsPerPage
	GenericScrollPresentation( screen, button )
	InventoryScreenUpdateVisibility( screen, { AnimateSlider = true } )
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.PinStartX - 30, OffsetY = screen.PinStartY + ((screen.PinsPerPage - 1) * screen.PinSpacingY), ForceUseCheck = true })
end

function InventoryScreenScrollDown( screen, button )
	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	if category.AlwaysShowScrollArrows then
		ModifyTextBox({ Id = screen.Components.LineHistory.Id, ScrollAmount = -screen.LineHistoryScrollTick })
		InventoryScreenUpdateVisibility( screen )
		return
	end
	if screen.ScrollOffset + screen.PinsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.PinsPerPage
	GenericScrollPresentation( screen, button )
	InventoryScreenUpdateVisibility( screen, { AnimateSlider = true } )
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.PinStartX - 30, OffsetY = screen.PinStartY, ForceUseCheck = true })
end

function InventoryScreenUpdateVisibility( screen, args )

	args = args or {}
	local components = screen.Components
	local category = screen.ItemCategories[screen.ActiveCategoryIndex]

	if category.ShowPins then

		if screen.SelectedPin ~= nil then
			InventoryScreenMouseOffPin( screen.SelectedPin )
		end

		-- Destroy all the buttons from the last screen
		Destroy({ Ids = screen.PinIds })
		screen.PinIds = {}

		-- Create the new batch of buttons
		local itemLocationY = screen.PinStartY
		local firstIndex = screen.NumItems - screen.ScrollOffset
		local lastIndex = math.max( 1, firstIndex - screen.PinsPerPage + 1 )
		for pinIndex = firstIndex, lastIndex, -1 do

			local pin = GameState.StoreItemPins[pinIndex]
			local store = _G[pin.StoreName]
			local itemData = store[pin.Name]

			local button = CreateScreenComponent({
				Name = "BlankInteractableObstacle",
				X = screen.PinStartX,
				Y = itemLocationY,
				Group = screen.ComponentData.DefaultGroup,
				Animation = "InventoryScreenForgetMeNotButton",
			})
			components[itemData.Name.."Backing"] = button
			table.insert( screen.PinIds, button.Id )
			button.Screen = screen
			button.MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu"
			button.OnMouseOverFunctionName = "InventoryScreenMouseOverPin"
			button.OnMouseOffFunctionName = "InventoryScreenMouseOffPin"
			button.ItemData = itemData
			if pinIndex == 1 then
				button.IsLastInList = true
			end
			AttachLua({ Id = button.Id, Table = button })
			SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })

			local iconData = TraitData[itemData.TraitUpgrade or itemData.Name] or itemData
			local iconName = iconData.Icon or itemData.Image
			local iconScaleFactor = screen.PinIconScale
			if store == TraitData then
				iconScaleFactor = screen.PinTraitIconScale
			end
			local icon = CreateScreenComponent({
				Name = "BlankObstacle",
				X = screen.PinStartX + screen.PinIconOffsetX,
				Y = itemLocationY + screen.PinIconOffsetY,
				Scale = (pin.IconScale or itemData.IconScale or 1.0) * iconScaleFactor,
				Group = screen.ComponentData.DefaultGroup,
				Animation = iconName,
			})
			table.insert( screen.PinIds, icon.Id )
			components[itemData.Name.."Icon"] = icon

			local displayName = itemData.DisplayName or itemData.HelpTextId or itemData.Name
			local tooltipData = {}
			local traitName = itemData.TraitUpgrade or itemData.Name
			if itemData.TraitUpgrade ~= nil then
				displayName = itemData.TraitUpgrade.."_Upgrade"
				tooltipData.NextLevel = GetWeaponUpgradeLevel( traitName ) + 1
				tooltipData.AspectRarityText = TraitRarityData.AspectRarityText[tooltipData.NextLevel]
			end
			if itemData.CostIncrease ~= nil then
				tooltipData.CurrentValue = GameState.MaxMetaUpgradeCostCache
				tooltipData.NextValue = GameState.MaxMetaUpgradeCostCache + itemData.CostIncrease
			end

			local nameFormat = "PinNameAffordableFormat"
			if store == TraitData then
				if TraitRequirements[itemData.Name] ~= nil and not HasTraitRequirements( itemData.Name ) then
					nameFormat = "PinNameUnaffordableFormat"
				end
			else
				if not HasResources( itemData.UpgradeResoureCost or itemData.ResourceCost or itemData.Cost ) then
					nameFormat = "PinNameUnaffordableFormat"
				end
			end
			CreateTextBoxWithScreenFormat( screen, button, nameFormat, { Text = displayName, LuaKey = "TooltipData", LuaValue = tooltipData } )

			itemLocationY = itemLocationY + screen.PinSpacingY

		end

	end

	local scrollFraction = GetScrollOffsetFraction({ Id = screen.Components.LineHistory.Id })

	if category.AlwaysShowScrollArrows then

		local sliderTargetY = Lerp( screen.LineHistoryScrollbarSliderTopY + ScreenCenterNativeOffsetY, screen.LineHistoryScrollbarSliderBottomY + ScreenCenterNativeOffsetY, scrollFraction )
		local slideDuration = 0.0
		if args.AnimateSlider then
			slideDuration = 0.2
		end
		Move({ Id = components.LineHistoryScrollbarSlider.Id, OffsetX = components.LineHistoryScrollbarSlider.X, OffsetY = sliderTargetY, Duration = slideDuration, EaseIn = 0.0, EaseOut = 1.0 })

		SetInteractProperty({ DestinationIds = { components.ScrollUp.Id, components.ScrollDown.Id }, Property = "FreeFormSelectable", Value = false })
		SetInteractProperty({ DestinationId = components.LineHistoryScrollbar.Id, Property = "FreeFormSelectable", Value = true })
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
		SetInteractProperty({ DestinationIds = { components.ScrollUp.Id, components.ScrollDown.Id }, Property = "FreeFormSelectable", Value = true })
		SetInteractProperty({ DestinationId = components.LineHistoryScrollbar.Id, Property = "FreeFormSelectable", Value = false })
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

function InventoryScreenRemovePin( screen, button )
	if screen.SelectedPin == nil then
		return
	end
	InventoryScreenRemovePinPresentation( screen, button, screen.SelectedPin )
	RemoveStoreItemPin( screen.SelectedPin.ItemData.Name )
	screen.NumItems = screen.NumItems - 1
	if screen.NumItems <= 0 then
		ModifyTextBox({ Id = screen.Components.EmptyCategoryHint.Id, FadeTarget = 1.0, FadeDuration = 0.2 })
	end
	if screen.SelectedPin.IsLastInList and screen.NumItems > 0 then
		TeleportCursor({ DestinationId = screen.SelectedPin.Id, OffsetY = -screen.PinSpacingY, ForceUseCheck = true })
	end
	InventoryScreenMouseOffPin( screen.SelectedPin )

	-- Auto-scroll up if needed
	if screen.NumItems > 0 and screen.ScrollOffset >= screen.NumItems then
		InventoryScreenScrollUp( screen )
	else
		InventoryScreenUpdateVisibility( screen )
	end
end

function AddRerolls( source, args )
	args = args or {}
	CurrentRun.NumRerolls = CurrentRun.NumRerolls + args.Amount
	ShowRerollUI()
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
	if screen.Closing then
		return
	end
	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	if category.AlwaysShowScrollArrows then
		if IsControlDown({ Name = "Up" }) or ( IsControlDown({ Name = "Select" }) and GetUseTargetId({ }) == screen.Components.ScrollUp.Id ) then
			ModifyTextBox({ Id = screen.Components.LineHistory.Id, ScrollAmount = screen.LineHistoryScrollSpeed * elapsed })
			InventoryScreenUpdateVisibility( screen )
		elseif IsControlDown({ Name = "Down" }) or ( IsControlDown({ Name = "Select" }) and GetUseTargetId({ }) == screen.Components.ScrollDown.Id ) then
			ModifyTextBox({ Id = screen.Components.LineHistory.Id, ScrollAmount = -screen.LineHistoryScrollSpeed * elapsed })
			InventoryScreenUpdateVisibility( screen )
		elseif IsControlDown({ Name = "Select" }) and ( GetUseTargetId({ }) == screen.Components.LineHistoryScrollbar.Id or screen.DraggingScrollbar ) then
			screen.DraggingScrollbar = true
			local cursorLocation = GetCursorScreenLocation({ })
			local sliderTopY = screen.LineHistoryScrollbarSliderTopY + ScreenCenterNativeOffsetY
			local sliderBottomY = screen.LineHistoryScrollbarSliderBottomY + ScreenCenterNativeOffsetY
			local fraction = (cursorLocation.Y - sliderTopY) / (sliderBottomY - sliderTopY)
			ModifyTextBox({ Id = screen.Components.LineHistory.Id, ScrollToFraction = fraction })
			InventoryScreenUpdateVisibility( screen )
		else
			screen.DraggingScrollbar = false
		end
	end
end

function CanShowResourceInInventory( resourceData )
	return (GameState.LifetimeResourcesGained[resourceData.Name] or 0) > 0 or ( resourceData.RevealGameStateRequirements ~= nil and IsGameStateEligible( resourceData, resourceData.RevealGameStateRequirements ) )
end

function ValidateResourceCategories()
	if not verboseLogging then
		return
	end
	local allItems = {}
	for i, itemCategory in pairs( ScreenData.InventoryScreen.ItemCategories ) do
		for j, itemName in ipairs( itemCategory ) do
			allItems[itemName] = true
		end
	end
	for i, itemName in pairs( ResourceDisplayOrderData ) do
		if not allItems[itemName] then
			DebugAssert({ Condition = false, Text = itemName.." is not listed in ScreenData.InventoryScreen.ItemCategories" })
		end
	end
end