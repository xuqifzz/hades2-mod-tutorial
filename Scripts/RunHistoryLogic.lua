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

	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY
	screen.TraitStartX = screen.TraitStartX + ScreenCenterNativeOffsetX
	screen.TraitStartY = screen.TraitStartY + ScreenCenterNativeOffsetY
	screen.MetaUpgradeStartY = screen.MetaUpgradeStartY + ScreenCenterNativeOffsetY
	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	local runDataTitleFormat = ShallowCopyTable( screen.RunDataTitleFormat )
	local runDataValueFormat = ShallowCopyTable( screen.RunDataValueFormat )
	screen.RunDataTitles = {}
	screen.RunDataValues = {}
	for i=1, screen.MaxVisibleRunDataEntries do
		screen.RunDataTitles[i] = CreateScreenComponent({ Name = "BlankObstacle", X = screen.RunDataTitleX, Y = screen.RunDataStartY + screen.RunDataSpacingY * (i - 1) })
		components["RunDataTitle"..i] = screen.RunDataTitles[i]
		runDataTitleFormat.Id = screen.RunDataTitles[i].Id
		CreateTextBox( runDataTitleFormat )

		screen.RunDataValues[i] = CreateScreenComponent({ Name = "BlankObstacle", X = screen.RunDataValueX, Y = screen.RunDataStartY + screen.RunDataSpacingY * (i - 1) })
		components["RunDataValue"..i] = screen.RunDataValues[i]
		runDataValueFormat.Id = screen.RunDataValues[i].Id
		CreateTextBox( runDataValueFormat )
	end

	RunHistoryScreenOpenPresentation( screen )

	screen.NumItems = #GameState.RunHistory + 1
	screen.ButtonIds = {}

	RunHistoryUpdateVisibility( screen )
	RunHistorySelectRun( components[screen.ButtonName..screen.NumItems] )
	RunHistoryUpdateArrows( screen )
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })

	HandleScreenInput( screen )

end

function RunHistoryScreenSetupTabs( screen )
	local categoryX = screen.CategoryStartX
	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		local categoryButton = CreateScreenComponent({ Name = "ButtonTraitTrayTab", X = categoryX, Y = screen.CategoryStartY, Group = screen.ComponentData.DefaultGroup })
		categoryButton.Screen = screen
		categoryButton.OnMouseOverFunctionName = "TraitTrayScreenCategoryMouseOver"
		categoryButton.OnMouseOffFunctionName = "TraitTrayScreenCategoryMouseOff"
		categoryButton.OnPressedFunctionName = "RunHistoryScreenSelectCategory"
		categoryButton.Category = category
		categoryButton.CategoryName = category.Name
		categoryButton.CategoryIndex = categoryIndex
		screen.Components["Category"..category.Name] = categoryButton
		AttachLua({ Id = categoryButton.Id, Table = categoryButton })
		categoryX = categoryX + screen.CategorySpacingX
	end
end

function RunHistorySelectRun( button )
	local screen = button.Screen
	if screen.Closing then
		return
	end
	if screen.RunIndex == button.RunIndex then
		return
	end

	if screen.RunIndex ~= nil then
		local prevButton = screen.Components[screen.ButtonName..screen.RunIndex]
		if prevButton ~= nil then
			RunHistoryUnselectRun( prevButton )
		end
	end

	screen.RunIndex = button.RunIndex

	Teleport({ Id = screen.Components.SelectionMarker.Id, DestinationId = button.Id, OffsetX = screen.Components.SelectionMarker.Data.ButtonOffsetX, OffsetY = screen.Components.SelectionMarker.Data.ButtonOffsetY })
	SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 1.0, Duration = 0.2 })

	ShowRunHistory( screen, button.Run, button.RunIndex )
end

function RunHistoryUnselectRun( button )
	local screen = button.Screen
	ModifyTextBox({ Id = button.Id, ScaleTarget = 1.0, ScaleDuration = 0.2 })
	SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 0.0, Duration = 0.2 })
end

function ShowRunHistory( screen, run, index, args )

	args = args or {}

	local components = screen.Components
	Destroy({ Ids = screen.IconIds })

	ShowRunHistoryPresentation( screen, run, index )

	if run.EasyModeLevel ~= nil then
		SetAlpha({ Id = components.EasyModeLabel.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.EasyModeLabel.Id, Fraction = 0.0, Duration = 0.2 })
	end

	local runDataIndex = 1

	for i=1, screen.MaxVisibleRunDataEntries do
		ModifyTextBox({ Id = screen.RunDataTitles[i].Id, FadeTarget = 0.0, FadeDuration = 0 })
		ModifyTextBox({ Id = screen.RunDataValues[i].Id, FadeTarget = 0.0, FadeDuration = 0 })
	end

	-- Result
	local resultString = nil
	if run.ActiveBounty then
		if run.BountyCleared then
			resultString = "RunHistoryScreenResult_BountyCleared"
		else
			resultString = "RunHistoryScreenResult_BountyFailed"
		end
	elseif run.Cleared then
		resultString = "RunHistoryScreen_Cleared"
	else
		local roomData = RoomData[run.EndingRoomName]
		if roomData ~= nil then
			resultString = roomData.ResultText
		end
	end
	if resultString ~= nil then
		ModifyTextBox({ Id = screen.RunDataTitles[runDataIndex].Id, Text = "RunHistoryScreen_Result", FadeTarget = 1.0, FadeDuration = 0 })
		ModifyTextBox({ Id = screen.RunDataValues[runDataIndex].Id, Text = resultString, FadeTarget = 1.0, FadeDuration = 0 })
		runDataIndex = runDataIndex + 1
	end

	-- Killed By
	local killedByString = nil
	if not run.Cleared then
		killedByString = run.KilledByName
	end
	if killedByString ~= nil then
		ModifyTextBox({ Id = screen.RunDataTitles[runDataIndex].Id, Text = "RunHistoryScreen_KilledBy", FadeTarget = 1.0, FadeDuration = 0 })
		ModifyTextBox({ Id = screen.RunDataValues[runDataIndex].Id, Text = killedByString, FadeTarget = 1.0, FadeDuration = 0 })
		runDataIndex = runDataIndex + 1
	end

	-- Time
	local timerString = nil
	if run.GameplayTime ~= nil then
		timerString = GetTimerString( run.GameplayTime, 2 )
	end
	if timerString ~= nil then
		ModifyTextBox({ Id = screen.RunDataTitles[runDataIndex].Id, Text = "RunHistoryScreen_Time", FadeTarget = 1.0, FadeDuration = 0 })
		ModifyTextBox({ Id = screen.RunDataValues[runDataIndex].Id, Text = timerString, FadeTarget = 1.0, FadeDuration = 0 })
		runDataIndex = runDataIndex + 1
	end

	-- Weapon
	local weaponString = nil
	if run.WeaponsCache ~= nil then
		for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
			if run.WeaponsCache[weaponName] then
				weaponString = weaponName
			end
		end
	end
	if weaponString ~= nil and run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.IsWeaponEnchantment and ScreenData.WeaponUpgradeScreen.FreeUnlocks[weaponString] ~= traitName then
				weaponString = traitName
				break
			end
		end
	end
	if weaponString ~= nil then
		ModifyTextBox({ Id = screen.RunDataTitles[runDataIndex].Id, Text = "RunHistoryScreen_Weapon", FadeTarget = 1.0, FadeDuration = 0 })
		ModifyTextBox({ Id = screen.RunDataValues[runDataIndex].Id, Text = weaponString, FadeTarget = 1.0, FadeDuration = 0 })
		runDataIndex = runDataIndex + 1
	end

	-- Familiar
	local familiarString = nil
	if run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.Slot == "Familiar" then
				familiarString = traitName
				break
			end
		end
	end
	if familiarString ~= nil then
		ModifyTextBox({ Id = screen.RunDataTitles[runDataIndex].Id, Text = "RunHistoryScreen_Assist", FadeTarget = 1.0, FadeDuration = 0 })
		ModifyTextBox({ Id = screen.RunDataValues[runDataIndex].Id, Text = familiarString, FadeTarget = 1.0, FadeDuration = 0 })
		runDataIndex = runDataIndex + 1
	end

	-- Keepsakes
	if not IsEmpty( run.KeepsakeCache ) then
		for i=1,4 do
			if run.KeepsakeCache[i] ~= nil then
				if i == 1 then
					ModifyTextBox({ Id = screen.RunDataTitles[runDataIndex].Id, Text = "RunHistoryScreen_Keepsakes", FadeTarget = 1.0, FadeDuration = 0 })
				end
				ModifyTextBox({ Id = screen.RunDataValues[runDataIndex].Id, Text = run.KeepsakeCache[i], FadeTarget = 1.0, FadeDuration = 0 })
				runDataIndex = runDataIndex + 1
			end
		end
	end

	-- PackagedBounty
	local packagedBountyString = run.ActiveBounty
	if packagedBountyString ~= nil then
		ModifyTextBox({ Id = screen.RunDataTitles[runDataIndex].Id, Text = "RunHistoryScreen_PackagedBounty", FadeTarget = 1.0, FadeDuration = 0 })
		ModifyTextBox({ Id = screen.RunDataValues[runDataIndex].Id, Text = packagedBountyString, FadeTarget = 1.0, FadeDuration = 0 })
		runDataIndex = runDataIndex + 1
	end
	
	-- Traits
	local visibleTraitCount = 0
	local showTraits = false
	local showMetaUpgrades = false
	local showShrineUpgrades = false
	if run.TraitCache ~= nil then
		for traitName in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.Icon ~= nil and not traitData.HideInRunHistory and not traitData.MetaUpgrade and not traitData.Hidden then
				visibleTraitCount = visibleTraitCount + 1
			end
		end
		if visibleTraitCount > 0 then
			showTraits = true
		end
		if run.MetaUpgradeCostCache ~= nil and run.MetaUpgradeCostCache > 0 then
			showMetaUpgrades = true
		end
		if run.ShrinePointsCache ~= nil and run.ShrinePointsCache > 0 then
			showShrineUpgrades = true
		end
	end

	if showTraits then
		ModifyTextBox({ Id = components.TraitCount.Id, Text = visibleTraitCount })
		SetAlpha({ Ids = { components.TraitCount.Id, components.CategoryTraitTray_Category_Traits.Id }, Fraction = 1.0, Duration = 0.1 })
		UseableOn({ Id = components.CategoryTraitTray_Category_Traits.Id })
		screen.ItemCategories[1].Locked = false
	else
		SetAlpha({ Ids = { components.TraitCount.Id, components.CategoryTraitTray_Category_Traits.Id }, Fraction = 0.0, Duration = 0.1 })
		UseableOff({ Id = components.CategoryTraitTray_Category_Traits.Id })
		screen.ItemCategories[1].Locked = true
	end

	if showMetaUpgrades then
		ModifyTextBox({ Id = components.MetaUpgradeCount.Id, Text = run.MetaUpgradeCostCache })
		SetAlpha({ Ids = { components.MetaUpgradeCount.Id, components.CategoryTraitTray_Category_MetaUpgrades.Id }, Fraction = 1.0, Duration = 0.1 })
		UseableOn({ Id = components.CategoryTraitTray_Category_MetaUpgrades.Id })
		screen.ItemCategories[2].Locked = false
		
	else
		SetAlpha({ Ids = { components.MetaUpgradeCount.Id, components.CategoryTraitTray_Category_MetaUpgrades.Id }, Fraction = 0.0, Duration = 0.1 })
		UseableOff({ Id = components.CategoryTraitTray_Category_MetaUpgrades.Id })
		screen.ItemCategories[2].Locked = true
	end

	if showShrineUpgrades then
		ModifyTextBox({ Id = components.ShrinePointCount.Id, Text = run.ShrinePointsCache })
		SetAlpha({ Ids = { components.ShrinePointCount.Id, components.CategoryTraitTray_Category_ShrineUpgrades.Id }, Fraction = 1.0, Duration = 0.1 })
		UseableOn({ Id = components.CategoryTraitTray_Category_ShrineUpgrades.Id })
		screen.ItemCategories[3].Locked = false
	else
		SetAlpha({ Ids = { components.ShrinePointCount.Id, components.CategoryTraitTray_Category_ShrineUpgrades.Id }, Fraction = 0.0, Duration = 0.1 })
		UseableOff({ Id = components.CategoryTraitTray_Category_ShrineUpgrades.Id })
		screen.ItemCategories[3].Locked = true
	end

	if showTraits or showMetaUpgrades or showShrineUpgrades then
		SetAlpha({ Id = components.RunErasedText.Id, Fraction = 0.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.RunErasedText.Id, Fraction = 1.0, Duration = 0.2 })
	end

	RunHistoryScreenShowCategory( screen, screen.ActiveCategoryIndex )

end

function RunHistoryUpdateVisibility( screen )

	local components = screen.Components

	-- Destroy all the buttons from the last screen
	if not IsEmpty( screen.ButtonIds ) then
		Destroy({ Ids = screen.ButtonIds })
		screen.ButtonIds = {}
	end

	screen.RunIndex = nil

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
		if run.ActiveBounty then
			routeName = "RunHistoryScreen_PackagedBounty"
		else
			local endingRoom = RoomData[run.EndingRoomName or run.CurrentRoom.Name]
			if endingRoom ~= nil then
				routeName = "RunHistoryScreen_Route"..endingRoom.RoomSetName
				DebugAssert({ Condition = endingRoom.ResultText ~= nil, Text = "Missing ResultText for biome "..endingRoom.RoomSetName.." | Run Index:"..runIndex, Owner = "Caleb" })
			end
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
	RunHistorySelectRun( screen.Components[screen.ButtonName..(screen.NumItems - (screen.ScrollOffset + (screen.ItemsPerPage - 1)))] )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
	GenericScrollPresentation( screen, button )
end

function RunHistoryScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	RunHistoryUpdateVisibility( screen )
	RunHistorySelectRun( screen.Components[screen.ButtonName..(screen.NumItems - screen.ScrollOffset)] )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	GenericScrollPresentation( screen, button )
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
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.TraitStartX, OffsetY = screen.TraitStartY, ForceUseCheck = true })
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
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.TraitStartX, OffsetY = screen.TraitStartY, ForceUseCheck = true })
end

function RunHistoryScreenShowCategory( screen, categoryIndex, args )
	local components = screen.Components

	Destroy({ Ids = screen.IconIds })
	screen.IconIds = {}

	local prevCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	SetAnimation({ DestinationId = components["Category"..prevCategory.Name].Id, Name = "TraitTrayTab" })

	local category = screen.ItemCategories[categoryIndex]
	SetAnimation({ DestinationId = components["Category"..category.Name].Id, Name = "TraitTrayTabHighlightActiveCategory" })

	if categoryIndex ~= screen.ActiveCategoryIndex then
		PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })
	end

	ModifyTextBox({ Id = components.TraitName.Id, FadeTarget = 0.0, FadeDuration = 0.1 })
	SetAlpha({ Id = components.HoverFrame.Id, Fraction = 0.0, Duration = 0.1 })

	screen.ActiveCategoryIndex = categoryIndex
	local category = screen.ItemCategories[screen.ActiveCategoryIndex]
	CallFunctionName( category.DisplayFunctionName, screen, button )
end

function RunHistoryScreenShowTraits( screen, button )

	local run = GameState.RunHistory[screen.RunIndex] or CurrentRun
	local components = screen.Components

	local locationX = screen.TraitStartX
	local locationY = screen.TraitStartY

	screen.FirstItem = nil

	if run.TraitCache == nil then
		return
	end
	
	local offsetX = screen.TraitColumnStartX
	local columnCount = 0

	local sortedTraits = {}
	for traitName, count in pairs( run.TraitCache ) do
		table.insert( sortedTraits, { Name = traitName, DisplayName = traitName, Value = count } )
	end
	table.sort( sortedTraits, RunHistoryStatsSort )
	local columnIndex = 0
	for k, sortedTrait in pairs( sortedTraits ) do
		local traitData = TraitData[sortedTrait.Name]
		if traitData ~= nil and traitData.Icon ~= nil and not traitData.HideInRunHistory and not traitData.MetaUpgrade and not traitData.Hidden then

			local iconKey = "Icon"..traitData.Name
			local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.TraitIconScale, X = locationX, Y = locationY, Animation = traitData.Icon })
			button.Screen = screen
			button.OnMouseOverFunctionName = "MouseOverRunHistoryItem"
			button.OnMouseOffFunctionName = "MouseOffRunHistoryItem"
			button.Data = traitData
			button.HighlightAnim = "TraitTray_Highlight"
			button.HighlightScale = screen.TraitIconScale
			if screen.FirstItem == nil then
				screen.FirstItem = button
			end
			components[iconKey] = button
			table.insert( screen.IconIds, button.Id )
			AttachLua({ Id = button.Id, Table = button })

			local traitDataWithRarity = ShallowCopyTable( traitData )
			traitDataWithRarity.Rarity = GetBoonRarityFromData( traitData )

			local frameKey = "IconFrame"..traitData.Name
			local frame = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.TraitIconScale, X = locationX, Y = locationY, Animation = GetTraitFrame( traitDataWithRarity ) })
			components[frameKey] = frame
			table.insert( screen.IconIds, frame.Id )

			columnCount = columnCount + 1
			if columnCount >= screen.TraitsPerColumn then
				locationX = locationX + screen.TraitSpacingX
				locationY = screen.TraitStartY
				columnCount = 0
				columnIndex = columnIndex + 1
			else
				locationY = locationY + screen.TraitSpacingY
			end
			if columnIndex >= screen.TraitMaxColumns then
				break
			end
		end
	end
end

function RunHistoryScreenShowMetaUpgrades( screen, button )

	local run = GameState.RunHistory[screen.RunIndex] or CurrentRun
	local components = screen.Components

	local locationX = screen.TraitStartX
	local locationY = screen.MetaUpgradeStartY

	screen.FirstItem = nil

	if run.TraitCache == nil then
		return
	end
	
	local offsetX = screen.TraitColumnStartX
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
				local frameKey = "IconFrame"..traitData.Name
				local frame = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = 0.7, X = locationX, Y = locationY, Animation = "DevCard_EquippedHighlight" })
				components[frameKey] = frame
				table.insert( screen.IconIds, frame.Id )

				local iconKey = "Icon"..traitData.Name
				local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.MetaUpgradeIconScale, X = locationX, Y = locationY, Animation = metaUpgradeCardData.Image })
				button.Screen = screen
				button.OnMouseOverFunctionName = "MouseOverRunHistoryItem"
				button.OnMouseOffFunctionName = "MouseOffRunHistoryItem"
				button.Data = metaUpgradeCardData
				button.HighlightAnim = "DevCard_Hover"
				button.HighlightScale = screen.MetaUpgradeIconScale * 3.5
				if screen.FirstItem == nil then
					screen.FirstItem = button
				end
				components[iconKey] = button
				table.insert( screen.IconIds, button.Id )
				AttachLua({ Id = button.Id, Table = button })

				columnCount = columnCount + 1
				if columnCount >= screen.MetaUpgradesPerColumn then
					locationX = locationX + screen.MetaUpgradeSpacingX
					locationY = screen.MetaUpgradeStartY
					columnCount = 0
					columnIndex = columnIndex + 1
				else
					locationY = locationY + screen.MetaUpgradeSpacingY
				end
				if columnIndex >= screen.TraitMaxColumns then
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

	screen.FirstItem = nil

	if run.ShrineUpgradesCache == nil then
		return
	end

	local locationX = screen.ShrineUpgradeStartX
	local locationY = screen.TraitStartY
	
	local rowCount = 0
	local rowIndex = 0
	for i, upgradeName in ipairs( ShrineUpgradeOrder ) do
		local upgradeData = MetaUpgradeData[upgradeName]
		local level = run.ShrineUpgradesCache[upgradeName] or 0
		if upgradeData ~= nil and level >= 1 then

			local frameKey = "IconFrame"..upgradeData.Name
			local frame = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.ShrineUpgradeBackingScale, X = locationX, Y = locationY, Animation = "GUI\\Screens\\Shrine\\PactActive" })
			frame.Screen = screen
			frame.OnMouseOverFunctionName = "MouseOverRunHistoryItem"
			frame.OnMouseOffFunctionName = "MouseOffRunHistoryItem"
			frame.Data = upgradeData
			frame.HighlightAnim = "GUI\\Screens\\Shrine\\PactHover"
			frame.HighlightScale = screen.ShrineUpgradeBackingScale
			if screen.FirstItem == nil then
				screen.FirstItem = frame
			end
			components[frameKey] = frame
			table.insert( screen.IconIds, frame.Id )
			AttachLua({ Id = frame.Id, Table = frame })

			local iconKey = "Icon"..upgradeData.Name
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.ShrineUpgradeIconScale, X = locationX, Y = locationY })
			components[iconKey] = component			
			SetAnimation({ DestinationId = component.Id , Name = upgradeData.Icon })
			table.insert( screen.IconIds, component.Id )

			rowCount = rowCount + 1
			if rowCount >= screen.ShrineUpgradesPerRow then
				locationY = locationY + screen.ShrineUpgradeSpacingY
				locationX = screen.ShrineUpgradeStartX
				rowCount = 0
				rowIndex = rowIndex + 1
			else
				locationX = locationX + screen.ShrineUpgradeSpacingX
			end
			if rowIndex >= screen.ShrineUpgradesMaxRows then
				break
			end
		end
	end
end
