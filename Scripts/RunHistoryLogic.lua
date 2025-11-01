function UseRunHistoryScreenObject( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenRunHistoryScreen( usee )
	UseableOn({ Id = usee.ObjectId })
end

function OpenRunHistoryScreen( openedFrom )

	AltAspectRatioFramesShow()

	AddInputBlock({ Name = "OpenRunHistoryScreen" })
	local screen = DeepCopyTable( ScreenData.RunHistory )
	local components = screen.Components

	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY
	screen.TraitStartX = screen.TraitStartX + ScreenCenterNativeOffsetX
	screen.TraitStartY = screen.TraitStartY + ScreenCenterNativeOffsetY
	screen.MetaUpgradeStartY = screen.MetaUpgradeStartY + ScreenCenterNativeOffsetY
	screen.ShrineUpgradeStartX = screen.ShrineUpgradeStartX + ScreenCenterNativeOffsetX
	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		local button = components["Category"..category.Name]
		local textComponent = components[category.TextComponentName]
		Attach({ Id = textComponent.Id, DestinationId = button.Id, OffsetX = screen.CategoryIconOffsetX, OffsetY = screen.CategoryIconOffsetY })
	end

	local runDataTitleFormat = ShallowCopyTable( screen.RunDataTitleFormat )
	local runDataValueFormat = ShallowCopyTable( screen.RunDataValueFormat )
	screen.RunDataTitles = {}
	screen.RunDataIcons = {}
	screen.RunDataValues = {}
	for i=1, screen.MaxVisibleRunDataEntries do
		screen.RunDataTitles[i] = CreateScreenComponent({ Name = "BlankObstacle", X = screen.RunDataTitleX + ScreenCenterNativeOffsetX, Y = screen.RunDataStartY + ScreenCenterNativeOffsetY + screen.RunDataSpacingY * (i - 1) })
		components["RunDataTitle"..i] = screen.RunDataTitles[i]
		runDataTitleFormat.Id = screen.RunDataTitles[i].Id
		CreateTextBox( runDataTitleFormat )

		screen.RunDataIcons[i] = CreateScreenComponent({ Name = "BlankObstacle", X = screen.RunDataIconX + ScreenCenterNativeOffsetX, Y = screen.RunDataStartY + ScreenCenterNativeOffsetY + screen.RunDataSpacingY * (i - 1), Alpha = 0.0 })
		components["RunDataIcon"..i] = screen.RunDataIcons[i]

		screen.RunDataValues[i] = CreateScreenComponent({ Name = "BlankObstacle", X = screen.RunDataValueX + ScreenCenterNativeOffsetX, Y = screen.RunDataStartY + ScreenCenterNativeOffsetY + screen.RunDataSpacingY * (i - 1) })
		components["RunDataValue"..i] = screen.RunDataValues[i]
		runDataValueFormat.Id = screen.RunDataValues[i].Id
		CreateTextBox( runDataValueFormat )
	end

	RunHistoryScreenOpenPresentation( screen )

	screen.NumItems = #GameState.RunHistory + 1
	screen.ButtonIds = {}

	RunHistoryUpdateVisibility( screen )
	RunHistorySelectRun( components[screen.ButtonName..screen.NumItems] )

	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	RemoveInputBlock({ Name = "OpenRunHistoryScreen" })

	HandleScreenInput( screen )

end

function RunHistoryScreenSetupTabs( screen )
	local categoryX = screen.CategoryStartX
	for categoryIndex, category in ipairs( screen.ItemCategories ) do
		local categoryButton = CreateScreenComponent({ Name = "ButtonTraitTrayTab", X = categoryX, Y = screen.CategoryStartY, Group = screen.ComponentData.DefaultGroup, Alpha = 0 })
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
			-- unselect
			ModifyTextBox({ Id = prevButton.Id, ScaleTarget = 1.0, ScaleDuration = 0.2 })
			SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 0.0, Duration = 0.2 })
		end
	end

	screen.RunIndex = button.RunIndex

	Teleport({ Id = screen.Components.SelectionMarker.Id, DestinationId = button.Id })
	SetAlpha({ Id = screen.Components.SelectionMarker.Id, Fraction = 1.0, Duration = 0.2 })

	ShowRunHistory( screen, button )
end

function ShowRunHistory( screen, button )

	local components = screen.Components

	Destroy({ Ids = screen.IconIds })
	screen.SortedTraits = nil

	local run = button.Run
	ShowRunHistoryPresentation( screen, run )

	if run.EasyModeLevel ~= nil then
		SetAlpha({ Id = components.EasyModeLabel.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.EasyModeLabel.Id, Fraction = 0.0, Duration = 0.2 })
	end

	local runErased = false
	if run.WeaponsCache == nil then
		runErased = true
		SetAlpha({ Id = components.RunErasedText.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.RunErasedText.Id, Fraction = 0.0, Duration = 0.2 })
	end

	-- Theme
	thread( SetRunHistoryThemePresentation, screen, { NewAnimationIndex = button.AnimationIndex } )
	screen.LastSelectedAnimationIndex = button.AnimationIndex

	-- Result
	local resultString = nil
	local wasSuccess = false
	if run.RunResult == RunResultData.BountySuccess then
		resultString = "RunHistoryScreenResult_BountyCleared"
		wasSuccess = true
	elseif run.RunResult == RunResultData.BountyFail then
		resultString = "RunHistoryScreenResult_BountyFailed"
	elseif WasRunSuccess( run ) then
		resultString = "RunHistoryScreen_Cleared"
		wasSuccess = true
	else
		local roomData = RoomData[run.EndingRoomName]
		if roomData ~= nil then
			DebugAssert({ Condition = roomData.ResultText ~= nil, Text = "ResultText for "..roomData.Name.." is nil", Owner = "Caleb" })
			resultString = roomData.ResultText
		else
			resultString = "RunHistoryScreenResult_UnknownFail"
		end
	end

	if wasSuccess then
		SetAlpha({ Id = components.ResultRibbonSuccess.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.ResultRibbonSuccess.Id, Fraction = 0.0, Duration = 0.2 })
	end

	local subtitle = run.ActiveBounty or run.VictoryMessage
	if subtitle ~= nil then
		ModifyTextBox({ Id = components.SupertitleResultText.Id, Text = resultString, FadeTarget = 1.0, FadeDuration = 0.2 })
		if run.ActiveBounty ~= nil then
			ModifyTextBox({ Id = components.SubtitleResultText.Id, Text = "RunHistoryScreen_PackagedBounty", FadeTarget = 1.0, FadeDuration = 0.2, LuaKey = "TooltipData", LuaValue = { BountyName = subtitle } })
		else
			ModifyTextBox({ Id = components.SubtitleResultText.Id, Text = subtitle, FadeTarget = 1.0, FadeDuration = 0.2 })
		end
		ModifyTextBox({ Id = components.ResultText.Id, FadeTarget = 0.0, FadeDuration = 0.1 })
	else
		ModifyTextBox({ Id = components.ResultText.Id, Text = resultString, FadeTarget = 1.0, FadeDuration = 0.2 })
		ModifyTextBox({ Id = components.SupertitleResultText.Id, FadeTarget = 0.0, FadeDuration = 0.1 })
		ModifyTextBox({ Id = components.SubtitleResultText.Id, FadeTarget = 0.0, FadeDuration = 0.1 })
	end

	-- Biome Card
	if wasSuccess then
		SetAlpha({ Id = components.BiomeCard.Id, Fraction = 0.0, Duration = 0.2 })
	else
		local biomeImage = "RunHistorySplash_FailureUnknown"
		if run.EndingRoomName ~= nil and RoomData[run.EndingRoomName].RoomSetName ~= nil then
			local roomSetName = RoomData[run.EndingRoomName].RoomSetName
			if roomSetName == "N_SubRooms" then
				roomSetName = "N"
			elseif roomSetName == "Anomaly" then
				roomSetName = "B"
			end

			local biomeName = "Biome"..roomSetName
			for entryName, entryData in pairs( CodexData.Biomes.Entries ) do
				if entryName == biomeName then
					biomeImage = entryData.Image
					break
				end
			end
		end
		SetAlpha({ Id = components.BiomeCard.Id, Fraction = 1.0, Duration = 0.2 })
		SetAnimation({ DestinationId = components.BiomeCard.Id, Name = biomeImage })
	end

	-- Killed By Card
	if wasSuccess then
		SetAlpha({ Id = components.KilledByCard.Id, Fraction = 0.0, Duration = 0.2 })
	else
		local killedByName = run.KilledByName
		local killedByImage = nil
		local enemyData = EnemyData[killedByName]
		if enemyData ~= nil then
			if enemyData.RunHistoryPortrait ~= nil then
				killedByImage = enemyData.RunHistoryPortrait
			elseif enemyData.RunHistoryKilledByName ~= nil then
				killedByName = enemyData.RunHistoryKilledByName
			elseif Contains( enemyData.InheritFrom, "Shadow" ) then
				for i, parentName in ipairs( enemyData.InheritFrom ) do
					if parentName ~= "Shadow" then
						killedByName = parentName
						break
					end
				end
			elseif Contains( enemyData.InheritFrom, "Elite" ) then
				for i, parentName in ipairs( enemyData.InheritFrom ) do
					if parentName ~= "Elite" then
						killedByName = parentName
						break
					end
				end
			elseif enemyData.GenusName ~= nil then
				killedByName = enemyData.GenusName
			end
		end
		if killedByName ~= nil and killedByImage == nil then
			for categoryName, categoryData in pairs( CodexData ) do
				for entryName, entryData in pairs( categoryData.Entries ) do
					if entryName == killedByName then
						killedByImage = entryData.Image
						break
					end
				end
			end
		end

		killedByImage = killedByImage or "RunHistorySplash_FailureUnknown"
		SetAlpha({ Id = components.KilledByCard.Id, Fraction = 1.0, Duration = 0.2 })
		SetAnimation({ DestinationId = components.KilledByCard.Id, Name = killedByImage })
	end

	-- Time
	local timerString = nil
	if run.GameplayTime ~= nil then
		timerString = GetTimerString( run.GameplayTime, 2 )
		ModifyTextBox({ Id = components.TimeText.Id, Text = timerString, FadeTarget = 1.0, FadeDuration = 0.2 })
	else
		ModifyTextBox({ Id = components.TimeText.Id, FadeTarget = 0.0, FadeDuration = 0.2 })
	end

	-- Setup misc run data
	local runDataIndex = 1
	for i=1, screen.MaxVisibleRunDataEntries do
		ModifyTextBox({ Id = screen.RunDataTitles[i].Id, FadeTarget = 0.0, FadeDuration = 0.2 })
		SetAlpha({ Id = screen.RunDataIcons[i].Id, Fraction = 0.0, Duration = 0.2 })
		ModifyTextBox({ Id = screen.RunDataValues[i].Id, FadeTarget = 0.0, FadeDuration = 0.2 })
	end

	-- Weapon
	local weaponString = nil
	local weaponIconAnim = nil
	if run.WeaponsCache ~= nil then
		for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
			if run.WeaponsCache[weaponName] then
				weaponString = weaponName
				weaponIconAnim = WeaponShopItemData[weaponName].Icon
			end
		end
	end
	if weaponString ~= nil and run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.IsWeaponEnchantment and ScreenData.WeaponUpgradeScreen.FreeUnlocks[weaponString] ~= traitName then
				weaponString = traitName
				weaponIconAnim = traitData.Icon
				break
			end
		end
	end
	if weaponString ~= nil then
		ModifyTextBox({ Id = screen.RunDataTitles[runDataIndex].Id, Text = "RunHistoryScreen_Weapon", FadeTarget = 1.0, FadeDuration = 0.2 })
		SetAnimation({ DestinationId = screen.RunDataIcons[runDataIndex].Id, Name = weaponIconAnim, OffsetY = screen.WeaponIconOffsetY })
		SetAlpha({ Id = screen.RunDataIcons[runDataIndex].Id, Fraction = 1.0, Duration = 0.2 })
		SetScale({ Id = screen.RunDataIcons[runDataIndex].Id, Fraction = screen.WeaponIconScale })
		ModifyTextBox({ Id = screen.RunDataValues[runDataIndex].Id, Text = weaponString, FadeTarget = 1.0, FadeDuration = 0.2 })
		runDataIndex = runDataIndex + 1
	end

	-- Familiar
	local familiarString = nil
	if run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.Slot == "Familiar" and traitData.Icon ~= nil then
				familiarString = traitName
				break
			end
		end
	end
	if familiarString ~= nil then
		ModifyTextBox({ Id = screen.RunDataTitles[runDataIndex].Id, Text = "RunHistoryScreen_Assist", FadeTarget = 1.0, FadeDuration = 0.2 })
		SetAnimation({ DestinationId = screen.RunDataIcons[runDataIndex].Id, Name = TraitData[familiarString].Icon, OffsetY = screen.FamiliarIconOffsetY })
		SetAlpha({ Id = screen.RunDataIcons[runDataIndex].Id, Fraction = 1.0, Duration = 0.2 })
		SetScale({ Id = screen.RunDataIcons[runDataIndex].Id, Fraction = screen.FamiliarIconScale })
		ModifyTextBox({ Id = screen.RunDataValues[runDataIndex].Id, Text = familiarString, FadeTarget = 1.0, FadeDuration = 0.2 })
		runDataIndex = runDataIndex + 1
	end

	-- Keepsakes
	if not IsEmpty( run.KeepsakeCache ) then
		local keepsakesToShow = {}
		for i, keepsakeName in ipairs( run.KeepsakeCache ) do
			if TraitData[keepsakeName] ~= nil then
				table.insert( keepsakesToShow, keepsakeName )
			end
		end
		local numKeepsakes = #keepsakesToShow
		for i, keepsakeString in ipairs( keepsakesToShow ) do
			if i == 1 then
				local keepsakeTitleString = "RunHistoryScreen_Keepsake"
				if numKeepsakes > 1 then
					keepsakeTitleString = "RunHistoryScreen_KeepsakePlural"
				end
				ModifyTextBox({ Id = screen.RunDataTitles[runDataIndex].Id, Text = keepsakeTitleString, FadeTarget = 1.0, FadeDuration = 0.2 })
			end
			SetAnimation({ DestinationId = screen.RunDataIcons[runDataIndex].Id, Name = TraitData[keepsakeString].Icon, OffsetY = screen.KeepsakeIconOffsetY })
			SetAlpha({ Id = screen.RunDataIcons[runDataIndex].Id, Fraction = 1.0, Duration = 0.2 })
			SetScale({ Id = screen.RunDataIcons[runDataIndex].Id, Fraction = screen.KeepsakeIconScale })
			ModifyTextBox({ Id = screen.RunDataValues[runDataIndex].Id, Text = keepsakeString, FadeTarget = 1.0, FadeDuration = 0.2 })
			runDataIndex = runDataIndex + 1
		end
	end
	
	-- Trait Tray
	local numTabs = 0
	local showTraits = false
	local showOverflowTraits = false
	local showMetaUpgrades = false
	local showShrineUpgrades = false

	screen.SortedTraits = RunHistoryGetSortedTraits( run )
	if not runErased then
		if #screen.SortedTraits > 0 then
			showTraits = true
			numTabs = numTabs + 1
			if #screen.SortedTraits > (screen.TraitsPerColumn * screen.TraitMaxColumns) then
				showOverflowTraits = true
				numTabs = numTabs + 1
			end
		end
		if (run.MetaUpgradeCostCache or 0) > 0 then
			showMetaUpgrades = true
			numTabs = numTabs + 1
		end
		if (run.ShrinePointsCache or 0) > 0 then
			showShrineUpgrades = true
			numTabs = numTabs + 1
		end
	end

	local tabX = screen.CategoryStartX
	if numTabs > 3 then
		tabX = screen.CategoryStartX - (screen.CategorySpacingX * 0.5)
	end

	if showTraits then
		Teleport({ Id = components.CategoryTraitTray_Category_Traits.Id, OffsetX = tabX, OffsetY = screen.CategoryStartY })
		ModifyTextBox({ Id = components.TraitCount.Id, Text = #screen.SortedTraits })
		SetAlpha({ Ids = { components.TraitCount.Id, components.CategoryTraitTray_Category_Traits.Id }, Fraction = 1.0, Duration = 0.2 })
		UseableOn({ Id = components.CategoryTraitTray_Category_Traits.Id })
		screen.ItemCategories[1].Locked = false
		tabX = tabX + screen.CategorySpacingX
	else
		SetAlpha({ Ids = { components.TraitCount.Id, components.CategoryTraitTray_Category_Traits.Id }, Fraction = 0.0, Duration = 0.2 })
		UseableOff({ Id = components.CategoryTraitTray_Category_Traits.Id })
		screen.ItemCategories[1].Locked = true
	end

	if showOverflowTraits then
		Teleport({ Id = components.CategoryTraitTray_Category_OverflowTraits.Id, OffsetX = tabX, OffsetY = screen.CategoryStartY })
		SetAlpha({ Ids = { components.OverflowTraitLabel.Id, components.CategoryTraitTray_Category_OverflowTraits.Id }, Fraction = 1.0, Duration = 0 })
		UseableOn({ Id = components.CategoryTraitTray_Category_OverflowTraits.Id })
		screen.ItemCategories[2].Locked = false
		tabX = tabX + screen.CategorySpacingX
	else
		SetAlpha({ Ids = { components.OverflowTraitLabel.Id, components.CategoryTraitTray_Category_OverflowTraits.Id }, Fraction = 0.0, Duration = 0 })
		UseableOff({ Id = components.CategoryTraitTray_Category_OverflowTraits.Id })
		screen.ItemCategories[2].Locked = true
	end

	if showMetaUpgrades then
		Teleport({ Id = components.CategoryTraitTray_Category_MetaUpgrades.Id, OffsetX = tabX, OffsetY = screen.CategoryStartY })
		ModifyTextBox({ Id = components.MetaUpgradeCount.Id, Text = run.MetaUpgradeCostCache })
		SetAlpha({ Ids = { components.MetaUpgradeCount.Id, components.CategoryTraitTray_Category_MetaUpgrades.Id }, Fraction = 1.0, Duration = 0.2 })
		UseableOn({ Id = components.CategoryTraitTray_Category_MetaUpgrades.Id })
		screen.ItemCategories[3].Locked = false
		tabX = tabX + screen.CategorySpacingX
	else
		SetAlpha({ Ids = { components.MetaUpgradeCount.Id, components.CategoryTraitTray_Category_MetaUpgrades.Id }, Fraction = 0.0, Duration = 0.2 })
		UseableOff({ Id = components.CategoryTraitTray_Category_MetaUpgrades.Id })
		screen.ItemCategories[3].Locked = true
	end

	if showShrineUpgrades then
		Teleport({ Id = components.CategoryTraitTray_Category_ShrineUpgrades.Id, OffsetX = tabX, OffsetY = screen.CategoryStartY })
		ModifyTextBox({ Id = components.ShrinePointCount.Id, Text = run.ShrinePointsCache })
		SetAlpha({ Ids = { components.ShrinePointCount.Id, components.CategoryTraitTray_Category_ShrineUpgrades.Id }, Fraction = 1.0, Duration = 0.2 })
		UseableOn({ Id = components.CategoryTraitTray_Category_ShrineUpgrades.Id })
		screen.ItemCategories[4].Locked = false
	else
		SetAlpha({ Ids = { components.ShrinePointCount.Id, components.CategoryTraitTray_Category_ShrineUpgrades.Id }, Fraction = 0.0, Duration = 0.2 })
		UseableOff({ Id = components.CategoryTraitTray_Category_ShrineUpgrades.Id })
		screen.ItemCategories[4].Locked = true
	end

	-- if the tab we were on is no longer visible, default to the first visible tab
	local currentCategory = screen.ItemCategories[screen.ActiveCategoryIndex]
	if currentCategory ~= nil and currentCategory.Locked then
		for index, category in ipairs( screen.ItemCategories ) do
			if not category.Locked then
				screen.ActiveCategoryIndex = index
				TraitTrayScreenCategoryMouseOff( components["Category"..currentCategory.Name] )
				break
			end
		end
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
		local button = CreateScreenComponent({
			Name = "BlankInteractableObstacle",
			X = screen.ItemStartX,
			Y = itemLocationY,
			Group = screen.ComponentData.DefaultGroup,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.2
		})
		components[screen.ButtonName..runIndex] = button
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
		if WasBountyRun( run ) then
			routeName = "RunHistoryScreen_RouteBounty"
			button.AnimationIndex = 5
		elseif WasSurfaceRun( run ) then
			routeName = "RunHistoryScreen_RouteN"
			button.AnimationIndex = 3
		elseif WasUnderworldRun( run ) then
			routeName = "RunHistoryScreen_RouteF"
			button.AnimationIndex = 1
		else
			DebugAssert({ Condition = false, Text = "Could not determine the route for run "..runIndex.."!", Owner = "Caleb" })
			button.AnimationIndex = 1
		end
		local runNameFormat = nil
		if WasRunSuccess( run ) then
			runNameFormat = ShallowCopyTable( screen.RunNameClearedFormat )
		else
			runNameFormat = ShallowCopyTable( screen.RunNameUnclearedFormat )
			button.AnimationIndex = button.AnimationIndex + 1
		end
		runNameFormat.Id = button.Id
		runNameFormat.LuaKey = "TempTextData"
		runNameFormat.LuaValue = { RunNum = runIndex, RouteName = routeName }
		CreateTextBox( runNameFormat )

		itemLocationY = itemLocationY + screen.ItemSpacingY
	end

	SetAlpha({ Id = components.HoverMarker.Id, Fraction = 0.0 })

	if screen.ScrollOffset <= 0 then
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
		UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
		UseableOn({ Id = components.ScrollUp.Id })
	end

	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
		UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
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
	GenericScrollPresentation( screen, button )
	RunHistoryUpdateVisibility( screen )
	wait( 0.02 )
	RunHistorySelectRun( screen.Components[screen.ButtonName..(screen.NumItems - (screen.ScrollOffset + (screen.ItemsPerPage - 1)))] )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
end

function RunHistoryScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	GenericScrollPresentation( screen, button )
	RunHistoryUpdateVisibility( screen )
	wait( 0.02 )
	RunHistorySelectRun( screen.Components[screen.ButtonName..(screen.NumItems - screen.ScrollOffset)] )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
end

function CloseRunHistoryScreen( screen, button )
	RunHistoryScreenClosedPresentation( screen, button )
	AltAspectRatioFramesHide()
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0, screen )
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
end

function RunHistoryScreenSelectCategory( screen, button )
	if button.CategoryIndex == screen.ActiveCategoryIndex then
		return
	end
	screen.ViewingTraitTray = true
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
	if screen.ViewingTraitTray then
		wait( 0.02 )
		TeleportCursor({ OffsetX = screen.TraitStartX, OffsetY = screen.TraitStartY, ForceUseCheck = true })
	end
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
	if screen.ViewingTraitTray then
		wait( 0.02 )
		TeleportCursor({ OffsetX = screen.TraitStartX, OffsetY = screen.TraitStartY, ForceUseCheck = true })
	end
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
	CallFunctionName( category.DisplayFunctionName, screen, button, category.DisplayFunctionArgs )
end

function RunHistoryGetSortedTraits( run )
	local sortedTraits = {}
	if run.TraitCache == nil then
		return sortedTraits
	end
	for traitName, count in pairs( run.TraitCache ) do
		local traitData = TraitData[traitName]
		if traitData ~= nil and traitData.Icon ~= nil and not traitData.HideInRunHistory and not traitData.MetaUpgrade and not traitData.Hidden then

			local traitSortInfo = { TraitData = traitData }

			if traitData.Slot ~= nil then
				if traitData.Slot == "Spell" then
					traitSortInfo.SlotIndex = 10 -- arbitrary, just a high number
				else
					traitSortInfo.SlotIndex = GetIndex( ScreenData.HUD.SlottedTraitOrder, traitData.Slot )
				end
			elseif traitData.IsTalent then
				traitSortInfo.SlotIndex = 11
			elseif traitData.IsHammerTrait then
				traitSortInfo.SlotIndex = 12
			else
				traitSortInfo.SlotIndex = 999
			end

			traitSortInfo.RarityIndex = GetIndex( TraitRarityData.BoonRarityRollOrder, GetBoonRarityFromData( traitData ) )

			local sourceName = nil
			if traitData.IsHammerTrait then
				sourceName = "WeaponUpgrade"
			elseif not traitData.IsTalent and traitData.Slot ~= "Spell" then
				sourceName = GetLootSourceName( traitData.Name, { ForBoonInfo = true, CheckEnemyData = true } )
			end

			traitSortInfo.ChapterIndex = 999
			traitSortInfo.IndexInChapter = 0
			if not traitData.IsHammerTrait and not traitData.IsTalent and traitData.Slot ~= "Spell" then
				local codexSourceName = sourceName
				local enemyData = EnemyData[sourceName]
				if enemyData ~= nil and enemyData.GenusName ~= nil then
					codexSourceName = enemyData.GenusName
				end
				for i, chapterName in ipairs( CodexOrdering.Order ) do
					traitSortInfo.IndexInChapter = GetIndex( CodexOrdering[chapterName], codexSourceName )
					if traitSortInfo.IndexInChapter ~= 0 then
						traitSortInfo.ChapterIndex = i
						break
					end
				end
			end

			traitSortInfo.TraitSortOrder = 999
			if traitData.IsTalent or traitData.Slot == "Spell" then
				-- We don't have an order lookup table for spells/talents yet.
			else
				local traitSortOrderList = ScreenData.BoonInfo.TraitSortOrder[sourceName]
				if traitSortOrderList ~= nil then
					traitSortInfo.TraitSortOrder = GetIndex( traitSortOrderList, traitData.Name )
				else
					local traitSortOrderData = EnemyData[sourceName] or LootData[sourceName]
					if traitSortOrderData ~= nil then
						traitSortOrderList = traitSortOrderData.Traits
						traitSortInfo.TraitSortOrder = GetIndex( traitSortOrderList, traitData.Name )
					end
				end
			end
			
			table.insert( sortedTraits, traitSortInfo )

		end
	end
	table.sort( sortedTraits, RunHistoryTraitSort )
	return sortedTraits
end

function RunHistoryScreenShowTraits( screen, button, args )

	args = args or {}

	local run = GameState.RunHistory[screen.RunIndex] or CurrentRun
	local components = screen.Components

	local locationX = screen.TraitStartX
	local locationY = screen.TraitStartY

	screen.FirstItem = nil

	local countInColumn = 0
	local columnIndex = 0
	local firstIndex = 1
	if args.Overflow then
		firstIndex = (screen.TraitsPerColumn * screen.TraitMaxColumns) + 1
	end
	for i = firstIndex, #screen.SortedTraits do
		local sortedTrait = screen.SortedTraits[i]
		local traitData = sortedTrait.TraitData
		local iconKey = "Icon"..traitData.Name
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.TraitIconScale, X = locationX, Y = locationY, Animation = traitData.Icon, Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 })
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
		local frame = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.TraitIconScale, X = locationX, Y = locationY, Animation = GetTraitFrame( traitDataWithRarity ), Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 })
		components[frameKey] = frame
		table.insert( screen.IconIds, frame.Id )

		countInColumn = countInColumn + 1
		if countInColumn >= screen.TraitsPerColumn then
			locationX = locationX + screen.TraitSpacingX
			locationY = screen.TraitStartY
			countInColumn = 0
			columnIndex = columnIndex + 1
		else
			locationY = locationY + screen.TraitSpacingY
		end
		if columnIndex >= screen.TraitMaxColumns then
			break
		end
	end
end

Using "DevCard_Hover"
function RunHistoryScreenShowMetaUpgrades( screen, button )

	local run = GameState.RunHistory[screen.RunIndex] or CurrentRun
	local components = screen.Components

	local locationX = screen.TraitStartX
	local locationY = screen.MetaUpgradeStartY

	screen.FirstItem = nil

	if run.TraitCache == nil then
		return
	end

	local allMetaUpgradeTraits = {}
	for traitName, count in pairs( run.TraitCache ) do
		local traitData = TraitData[traitName]
		if traitData ~= nil and traitData.MetaUpgrade then
			allMetaUpgradeTraits[traitName] = true
		end
	end

	local sortedTraits = {}
	for rowIndex, row in ipairs( MetaUpgradeDefaultCardLayout ) do
		for colIndex, metaUpgradeName in ipairs( row ) do
			local traitName = MetaUpgradeCardData[metaUpgradeName].TraitName
			if allMetaUpgradeTraits[traitName] then
				table.insert( sortedTraits, TraitData[traitName] )
			end
		end
	end

	local countInColumn = 0
	local columnIndex = 0
	for i, traitData in ipairs( sortedTraits ) do
		local metaUpgradeCardData = GetMetaUpgradeDataFromTraitName( traitData.Name )
		if metaUpgradeCardData ~= nil then
			local frameKey = "IconFrame"..traitData.Name
			local frame = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = 0.7, X = locationX, Y = locationY, Animation = "DevCard_EquippedHighlight", Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 })
			components[frameKey] = frame
			table.insert( screen.IconIds, frame.Id )

			local iconKey = "Icon"..traitData.Name
			local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.MetaUpgradeIconScale, X = locationX, Y = locationY, Animation = metaUpgradeCardData.Image, Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 })
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

			countInColumn = countInColumn + 1
			if countInColumn >= screen.MetaUpgradesPerColumn then
				locationX = locationX + screen.MetaUpgradeSpacingX
				locationY = screen.MetaUpgradeStartY
				countInColumn = 0
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
			local frame = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.ShrineUpgradeBackingScale, X = locationX, Y = locationY, Animation = "GUI\\Screens\\Shrine\\PactActive", Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 })
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
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.ShrineUpgradeIconScale, X = locationX, Y = locationY, Alpha = 0.0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 })
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

function RunHistoryTraitSort( itemA, itemB )

	-- Sort by Slot
	if itemA.SlotIndex ~= itemB.SlotIndex then
		return itemA.SlotIndex < itemB.SlotIndex
	end

	-- Sort by Rarity
	if itemA.RarityIndex ~= itemB.RarityIndex then
		return itemA.RarityIndex < itemB.RarityIndex
	end

	-- Sort by Boon-Giver's Codex order
	if itemA.ChapterIndex ~= itemB.ChapterIndex then
		return itemA.ChapterIndex < itemB.ChapterIndex
	end
	if itemA.IndexInChapter ~= itemB.IndexInChapter then
		return itemA.IndexInChapter < itemB.IndexInChapter
	end

	-- Sort by Boon Info order
	return itemA.TraitSortOrder < itemB.TraitSortOrder

end
