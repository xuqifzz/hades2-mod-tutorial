function UseRunHistoryScreenObject( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenRunHistoryScreen( usee )
	UseableOn({ Id = usee.ObjectId })
end

function OpenRunHistoryScreen( openedFrom )

	local screen = DeepCopyTable( ScreenData.RunHistory )
	local components = screen.Components

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY
	screen.TraitStartX = screen.TraitStartX + ScreenCenterNativeOffsetX
	screen.TraitStartY = screen.TraitStartY + ScreenCenterNativeOffsetY
	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	ModifyTextBox({ Id = components.PackagedBountyLabel.Id, FadeTarget = 0.0 })
	ModifyTextBox({ Id = components.PackagedBountyValue.Id, FadeTarget = 0.0 })

	local categoryTitleX = screen.CategoryStartX
	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		--if category.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, category, category.GameStateRequirements ) then
			local categoryButton = CreateScreenComponent({ Name = "ButtonInventoryTab", X = categoryTitleX, Y = screen.CategoryStartY, Group = screen.ComponentData.DefaultGroup })
			categoryButton.OnPressedFunctionName = "RunHistoryScreenSelectCategory"
			categoryButton.Category = category
			categoryButton.CategoryName = category.Name
			categoryButton.CategoryIndex = categoryIndex
			screen.Components["Category"..category.Name] = categoryButton
		--end
		categoryTitleX = categoryTitleX + screen.CategorySpacingX
	end

	RunHistoryScreenOpenPresentation( screen )

	screen.NumItems = #GameState.RunHistory + 1
	screen.RunIndex = screen.NumItems
	screen.ButtonIds = {}

	RunHistoryUpdateArrows( screen )
	RunHistoryUpdateVisibility( screen )
	wait( 0.01 )

	HandleScreenInput( screen )

end

function ShowRunHistory( screen, run, index, args )

	args = args or {}

	local components = screen.Components
	Destroy({ Ids = screen.IconIds })

	ShowRunHistoryPresentation( screen, run, index )

	-- Number
	--ModifyTextBox({ Id = components.RunIndexValue.Id, Text = index })

	-- Route
	--[[
	local endingRoom = RoomData[run.EndingRoomName]
	if endingRoom ~= nil then
		ModifyTextBox({ Id = components.RunRouteValue.Id, Text = "RunHistoryScreen_Route"..endingRoom.RoomSetName })
	end
	]]

	-- Result
	local resultText = "RunHistoryScreen_Missing"
	if run.ActiveBounty then
		if run.BountyCleared then
			resultText = "RunHistoryScreenResult_BountyCleared"
		else
			resultText = "RunHistoryScreenResult_BountyFailed"
		end
	elseif run.Cleared then
		resultText = "RunHistoryScreen_Cleared"
	else
		local roomData = RoomData[run.EndingRoomName]
		if roomData ~= nil then
			resultText = roomData.ResultText
		end
	end
	ModifyTextBox({ Id = components.RunResultValue.Id, Text = resultText })

	if run.EasyModeLevel ~= nil then
		SetAlpha({ Id = components.EasyModeLabel.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.EasyModeLabel.Id, Fraction = 0.0, Duration = 0.2 })
	end

	-- ClearTime
	local timerString = "RunHistoryScreen_Missing"
	if run.GameplayTime ~= nil then
		timerString = GetTimerString( run.GameplayTime, 2 )
	end
	ModifyTextBox({ Id = components.RunClearTimeValue.Id, Text = timerString })

	-- Weapon
	local weaponText = "RunHistoryScreen_Missing"
	if run.WeaponsCache ~= nil then
		for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
			if run.WeaponsCache[weaponName] then
				weaponText = weaponName
			end
		end
	end
	ModifyTextBox({ Id = components.WeaponValue.Id, Text = weaponText })

	-- Aspect
	local aspectText = "RunHistoryScreen_Missing"
	if run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.IsWeaponEnchantment then
				aspectText = traitName
				break
			end
		end
	end
	ModifyTextBox({ Id = components.AspectValue.Id, Text = aspectText })

	-- Keepsake
	local keepsakeText = "RunHistoryScreen_Missing"
	if run.EndingKeepsakeName ~= nil then
		keepsakeText = run.EndingKeepsakeName
	elseif run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.Slot == "Keepsake" then
				keepsakeText = traitName
				break
			end
		end
	end
	ModifyTextBox({ Id = components.KeepsakeValue.Id, Text = keepsakeText })

	-- Familiar
	local familiarText = "RunHistoryScreen_Missing"
	if run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.Slot == "Familiar" then
				familiarText = traitName
				break
			end
		end
	end
	ModifyTextBox({ Id = components.FamiliarValue.Id, Text = familiarText })

	-- PackagedBounty
	local packagedBountyText = run.ActiveBounty
	if packagedBountyText ~= nil then
		ModifyTextBox({ Id = components.PackagedBountyLabel.Id, FadeTarget = 1.0, FadeDuration = 0.1 })
		ModifyTextBox({ Id = components.PackagedBountyValue.Id, Text = packagedBountyText, FadeTarget = 1.0, FadeDuration = 0.1 })
	else
		ModifyTextBox({ Id = components.PackagedBountyLabel.Id, FadeTarget = 0.0, FadeDuration = 0.1 })
		ModifyTextBox({ Id = components.PackagedBountyValue.Id, FadeTarget = 0.0, FadeDuration = 0.1 })
	end
	
	-- Traits
	ModifyTextBox({ Id = components.TraitCount.Id, Text = run.VisibleTraitCountCache })
	ModifyTextBox({ Id = components.MetaUpgradeCount.Id, Text = run.MetaUpgradeCostCache })
	ModifyTextBox({ Id = components.ShrinePointCount.Id, Text = run.ShrinePointsCache })

	RunHistoryScreenShowCategory( screen, screen.ActiveCategoryIndex )

	-- Clear Message
	--if run.RunClearMessage ~= nil then
		--thread( RunClearMessagePresentation, screen, GameData.RunClearMessageData[run.RunClearMessage.Name], { Delay = 0, Silent = true, OffsetX = 0, OffsetY = -225, ComponentId = components.DynamicTextAnchor.Id } )
	--end
end

function RunHistoryUpdateVisibility( screen )

	local components = screen.Components

	-- Destroy all the buttons from the last screen
	if not IsEmpty( screen.ButtonIds ) then
		Destroy({ Ids = screen.ButtonIds })
		screen.ButtonIds = {}
	end

	-- Create the new batch of buttons
	local firstIndex = screen.NumItems - screen.ScrollOffset
	local lastIndex = math.max( 1, firstIndex - screen.ItemsPerPage + 1 )
	local itemLocationY = screen.ItemStartY
	for runIndex = firstIndex, lastIndex, -1 do
		local run = GameState.RunHistory[runIndex] or CurrentRun
		local buttonKey = screen.ButtonName..runIndex
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", X = screen.ItemStartX, Y = itemLocationY, Group = screen.ComponentData.DefaultGroup })
		components[buttonKey] = button
		table.insert( screen.ButtonIds, button.Id )
		button.Screen = screen
		button.MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu"
		button.OnMouseOverFunctionName = "RunHistoryMouseOverRun"
		button.OnMouseOffFunctionName = "RunHistoryMouseOffRun"
		button.RunIndex = runIndex
		button.Run = run
		AttachLua({ Id = button.Id, Table = button })
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })

		local routeName = "MysteryResource"
		local endingRoom = RoomData[run.EndingRoomName or run.CurrentRoom.Name]
		if endingRoom ~= nil then
			routeName = "RunHistoryScreen_Route"..endingRoom.RoomSetName
			DebugAssert({ Condition = endingRoom.ResultText ~= nil, Text = "Missing ResultText for biome "..endingRoom.RoomSetName.." | Run Index:"..runIndex, Owner = "Caleb" })
		end
		local runNameFormat = nil
		if run.Cleared or ( run.ActiveBounty and run.BountyCleared ) then
			runNameFormat = ShallowCopyTable( screen.RunNameClearedFormat )
		else
			runNameFormat = ShallowCopyTable( screen.RunNameUnclearedFormat )
		end
		runNameFormat.Id = button.Id
		runNameFormat.LuaKey = "TempTextData"
		runNameFormat.LuaValue = { RunNum = runIndex, RouteName = routeName }
		CreateTextBox( runNameFormat )

		itemLocationY = itemLocationY + screen.ItemSpacingY
	end

	if screen.ScrollOffset <= 0 then
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
		UseableOff({ Id = components.ScrollUp.Id })
	else
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
		UseableOn({ Id = components.ScrollUp.Id })
	end

	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
		UseableOff({ Id = components.ScrollDown.Id })
	else
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1, Duration = 0.1 })
		UseableOn({ Id = components.ScrollDown.Id })
	end

end

function RunHistoryScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	RunHistoryUpdateVisibility( screen )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
	GenericScrollPresentation( screen, button )
end

function RunHistoryScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	RunHistoryUpdateVisibility( screen )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	GenericScrollPresentation( screen, button )
end

function RunHistoryPrevRun( screen, button )
	screen.RunIndex = screen.RunIndex - 1
	if screen.RunIndex < 1 then
		screen.RunIndex = 1
		return
	end
	RunHistoryUpdateArrows( screen, button )
	RunHistorySwitchPresentation( screen, button )
	return ShowRunHistory( screen, GameState.RunHistory[screen.RunIndex] or CurrentRun, screen.RunIndex )
end

function RunHistoryNextRun( screen, button )
	screen.RunIndex = screen.RunIndex + 1
	if screen.RunIndex > #GameState.RunHistory + 1 then
		screen.RunIndex = #GameState.RunHistory + 1
		return
	end
	RunHistoryUpdateArrows( screen, button )
	RunHistorySwitchPresentation( screen, button )
	return ShowRunHistory( screen, GameState.RunHistory[screen.RunIndex] or CurrentRun, screen.RunIndex )
end

function RunHistoryUpdateArrows( screen, button )

	local components = screen.Components
	if screen.RunIndex <= 1 then
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0 })
		UseableOff({ Id = components.ScrollDown.Id })
	else
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1 })
		UseableOn({ Id = components.ScrollDown.Id })
	end

	if screen.RunIndex >= #GameState.RunHistory + 1 then
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0 })
		UseableOff({ Id = components.ScrollUp.Id })
	else
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1 })
		UseableOn({ Id = components.ScrollRight.Id })
	end
end

function CloseRunHistoryScreen( screen, button )
	RunHistoryScreenClosedPresentation( screen, button )
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ) )
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
end

function RunHistoryScreenSelectCategory( screen, button )
	if button.CategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	RunHistoryScreenShowCategory( screen, button.CategoryIndex )
end

function RunHistoryScreenNextCategory( screen, button )
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
	RunHistoryScreenShowCategory( screen, nextCategoryIndex )
end

function RunHistoryScreenPrevCategory( screen, button )
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
	RunHistoryScreenShowCategory( screen, nextCategoryIndex )
end

function RunHistoryScreenShowCategory( screen, categoryIndex, args )

	local prevCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	StopAnimation({ DestinationId = screen.Components["Category"..prevCategory.Name].Id, Name = "InventoryTabHighlightActiveCategory" })

	screen.ActiveCategoryIndex = categoryIndex
	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	ModifyTextBox({ Id = screen.Components.CategoryTitleText.Id, Text = category.Name })
	CallFunctionName( category.DisplayFunctionName, screen, button )

	CreateAnimation({ DestinationId = screen.Components["Category"..category.Name].Id, Name = "InventoryTabHighlightActiveCategory", Group = "Combat_Menu_TraitTray" })
end

function RunHistoryScreenShowTraits( screen, button )

	local run = GameState.RunHistory[screen.RunIndex] or CurrentRun
	local components = screen.Components

	local locationX = screen.TraitStartX
	local locationY = screen.TraitStartY
	
	Destroy({ Ids = screen.IconIds })
	screen.IconIds = {}

	if run.TraitCache == nil then
		return
	end
	
	local offsetX = screen.TraitColumnStartX
	local startOffsetY = offsetY
	local columnCount = 0

	local sortedTraits = {}
	for traitName, count in pairs( run.TraitCache ) do
		table.insert( sortedTraits, { Name = traitName, DisplayName = traitName, Value = count } )
	end
	table.sort( sortedTraits, RunHistoryStatsSort )
	local columnIndex = 0
	for k, sortedTrait in pairs( sortedTraits ) do
		local traitData = TraitData[sortedTrait.Name]
		if traitData ~= nil and traitData.Icon ~= nil and not traitData.HideInRunHistory and not traitData.MetaUpgrade then

			local iconKey = "Icon"..traitData.Name
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.IconScaleTraits, X = locationX, Y = locationY })
			components[iconKey] = component
			SetAnimation({ DestinationId = component.Id , Name = traitData.Icon })
			table.insert( screen.IconIds, component.Id )

			--[[
			local traitNameFormat = ShallowCopyTable( screen.TraitNameFormat )
			traitNameFormat.Id = component.Id
			traitNameFormat.Text = sortedTrait.Name
			traitNameFormat.LuaKey = "TempTextData"
			traitNameFormat.LuaValue = { Name = sortedTrait.Name, Level = sortedTrait.Count }
			CreateTextBox( traitNameFormat )
			]]

			columnCount = columnCount + 1
			if columnCount >= screen.TraitsPerColumn then
				locationX = locationX + screen.TraitSpacingX
				locationY = screen.TraitStartY
				columnCount = 0
				columnIndex = columnIndex + 1
			else
				locationY = locationY + screen.TraitSpacingY
			end
			if columnIndex >= screen.MaxColumns then
				break
			end
		end
	end
end

function RunHistoryScreenShowMetaUpgrades( screen, button )

	local run = GameState.RunHistory[screen.RunIndex] or CurrentRun
	local components = screen.Components

	local locationX = screen.TraitStartX
	local locationY = screen.TraitStartY
	
	Destroy({ Ids = screen.IconIds })
	screen.IconIds = {}

	if run.TraitCache == nil then
		return
	end
	
	local offsetX = screen.TraitColumnStartX
	local startOffsetY = offsetY
	local columnCount = 0

	local sortedTraits = {}
	for traitName, count in pairs( run.TraitCache ) do
		table.insert( sortedTraits, { Name = traitName, DisplayName = traitName, Value = count } )
	end
	table.sort( sortedTraits, RunHistoryStatsSort )
	local columnIndex = 0
	for k, sortedTrait in pairs( sortedTraits ) do
		local traitData = TraitData[sortedTrait.Name]
		if traitData ~= nil and traitData.MetaUpgrade then
			local metaUpgradeCardData = GetMetaUpgradeDataFromTraitName( traitData.Name )
			if metaUpgradeCardData ~= nil then
				local iconKey = "Icon"..traitData.Name
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.IconScaleMetaUpgrades, X = locationX, Y = locationY })
				components[iconKey] = component
			
				SetAnimation({ DestinationId = component.Id , Name = metaUpgradeCardData.Image })
				table.insert( screen.IconIds, component.Id )

				--[[
				local traitNameFormat = ShallowCopyTable( screen.TraitNameFormat )
				traitNameFormat.Id = component.Id
				traitNameFormat.Text = sortedTrait.Name
				traitNameFormat.LuaKey = "TempTextData"
				traitNameFormat.LuaValue = { Name = sortedTrait.Name, Level = sortedTrait.Count }
				CreateTextBox( traitNameFormat )
				]]

				columnCount = columnCount + 1
				if columnCount >= screen.TraitsPerColumn then
					locationX = locationX + screen.TraitSpacingX
					locationY = screen.TraitStartY
					columnCount = 0
					columnIndex = columnIndex + 1
				else
					locationY = locationY + screen.TraitSpacingY
				end
				if columnIndex >= screen.MaxColumns then
					break
				end
			end
		end
	end
end

function GetMetaUpgradeDataFromTraitName( traitName )
	for name, data in pairs( MetaUpgradeCardData ) do
		if data.TraitName == traitName then
			return data
		end
	end
	return nil
end

function RunHistoryScreenShowShrineUpgrades( screen, button )

	local run = GameState.RunHistory[screen.RunIndex] or CurrentRun
	local components = screen.Components

	local locationX = screen.TraitStartX
	local locationY = screen.TraitStartY
	
	Destroy({ Ids = screen.IconIds })
	screen.IconIds = {}

	if run.ShrineUpgradesCache == nil then
		return
	end
	
	local offsetX = screen.TraitColumnStartX
	local startOffsetY = offsetY
	local columnCount = 0

	local columnIndex = 0
	for i, upgradeName in ipairs( ShrineUpgradeOrder ) do
		local upgradeData = MetaUpgradeData[upgradeName]
		local level = run.ShrineUpgradesCache[upgradeName] or 0
		if upgradeData ~= nil and level >= 1 then		

			local iconKey = "Icon"..upgradeData.Name
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.IconScaleShrineUpgrades, X = locationX, Y = locationY })
			components[iconKey] = component			
			SetAnimation({ DestinationId = component.Id , Name = upgradeData.Icon })
			table.insert( screen.IconIds, component.Id )

			--[[
			local traitNameFormat = ShallowCopyTable( screen.TraitNameFormat )
			traitNameFormat.Id = component.Id
			traitNameFormat.Text = upgradeData.Name
			--traitNameFormat.LuaKey = "TempTextData"
			--traitNameFormat.LuaValue = { Name = sortedTrait.Name, Level = sortedTrait.Count }
			CreateTextBox( traitNameFormat )
			]]

			columnCount = columnCount + 1
			if columnCount >= screen.TraitsPerColumn then
				locationX = locationX + screen.TraitSpacingX
				locationY = screen.TraitStartY
				columnCount = 0
				columnIndex = columnIndex + 1
			else
				locationY = locationY + screen.TraitSpacingY
			end
			if columnIndex >= screen.MaxColumns then
				break
			end
		end
	end
end
