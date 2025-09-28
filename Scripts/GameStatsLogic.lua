function UseGameStatsScreenObject( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenGameStatsScreen( usee )
	UseableOn({ Id = usee.ObjectId })
end

function OpenGameStatsScreen( openedFrom )

	AltAspectRatioFramesShow()

	local screen = DeepCopyTable( ScreenData.GameStats )
	local components = screen.Components

	screen.HeaderY = screen.HeaderY + ScreenCenterNativeOffsetY
	screen.RowStartY = screen.RowStartY + ScreenCenterNativeOffsetY	
	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	-- Headers

	local columnHeaders = screen.WeaponColumnHeaders
	for k, columnData in ipairs( columnHeaders ) do
		columnData.X = columnData.X + ScreenCenterNativeOffsetX
		if columnData.HeaderX ~= nil then
			columnData.HeaderX = columnData.HeaderX + ScreenCenterNativeOffsetX
		end
		if columnData.Text ~= nil then
			local componentName = columnData.ColumnName
			local component = CreateScreenComponent({ Name = "BlankInteractableObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.HeaderX or columnData.X, Y = screen.HeaderY })
			components[componentName] = component
			local headerFormat = ShallowCopyTable( screen.HeaderFormat )
			headerFormat.Id = component.Id
			headerFormat.Text = columnData.Text
			headerFormat.Justification = columnData.HeaderJustification or columnData.Justification
			CreateTextBox( headerFormat )
			SetInteractProperty({ DestinationId = component.Id, Property = "FreeFormSelectable", Value = false })
		end
	end

	for i, sortKey in ipairs( screen.SortKeys ) do
		local component = components[sortKey]
		component.OnPressedFunctionName = "GameStatsChangeSortMode"
		component.SortModeIndex = i
		AttachLua({ Id = component.Id, Table = component })
	end

	screen.RunIndex = #GameState.RunHistory + 1

	GameState.RunHistoryGameStatsSortMode = GameState.RunHistoryGameStatsSortMode or 1
	GameStatsSetActiveColumnPresentation( screen )

	screen.CurrentFilter = screen.TraitFilters[1].Name
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenOpenPresentation( screen )
	wait( 0.01 )

	HandleScreenInput( screen )

end

function GameStatsScreenCreateCategories( screen )
	local categoryX = screen.CategoryStartX
	local categoryY = screen.CategoryStartY
	for filterIndex, filter in ipairs( screen.TraitFilters ) do
		local filterName = filter.Name
		local tab = screen.Tabs[filterIndex]
		local categoryButton = CreateScreenComponent({
			Name = "BlankInteractableObstacle",
			X = categoryX + tab.X,
			Y = categoryY + tab.Y,
			Animation = tab.Animation,
			Scale = screen.CategoryScale,
			Group = screen.ComponentData.DefaultGroup
		})
		categoryButton.OnMouseOverFunctionName = "MouseOverCodexChapter"
		categoryButton.OnMouseOffFunctionName = "MouseOffCodexChapter"
		categoryButton.OnPressedFunctionName = "GameStatsSelectCategory"
		categoryButton.Category = filterName
		categoryButton.CategoryIndex = filterIndex
		categoryButton.TabData = tab
		categoryButton.Screen = screen
		AttachLua({ Id = categoryButton.Id, Table = categoryButton })
		SetInteractProperty({ DestinationId = categoryButton.Id, Property = "FreeFormSelectable", Value = false })
		screen.Components["Category"..filterName] = categoryButton

		local activeOverlay = CreateScreenComponent({
			Name = "BlankObstacle",
			X = categoryX + tab.X,
			Y = categoryY + tab.Y,
			Animation = tab.Active,
			Scale = screen.CategoryScale,
			Alpha = 0.0,
			Group = screen.ComponentData.DefaultGroup
		})
		categoryButton.ActiveOverlayId = activeOverlay.Id
		screen.Components["CategoryActiveOverlay"..filter.Name] = activeOverlay

		local categoryButtonIcon = CreateScreenComponent({
			Name = "BlankObstacle",
			Group = screen.ComponentData.DefaultGroup,
			Scale = screen.CategoryIconScale,
			X = categoryX + tab.X,
			Y = categoryY + tab.Y
		})
		categoryButton.IconShiftRequests = {}
		categoryButton.IconId = categoryButtonIcon.Id
		SetAnimation({ DestinationId = categoryButtonIcon.Id, Name = filter.Icon })
		screen.Components["CategoryIcon"..filterName] = categoryButtonIcon
		
		categoryX = categoryX + screen.CategorySpacingX
	end
end

function ShowTraitStats( screen )

	Destroy({ Ids = screen.IconIds })

	local components = screen.Components
	local category = screen.TraitFilters[screen.ActiveCategoryIndex]
	ModifyTextBox({ Id = screen.Components.CategoryTitleText.Id, Text = category.Name })
	ModifyTextBox({ Id = components["Category"..screen.CurrentFilter].Id, Color = Color.White })

	if screen.PrevCategoryName ~= category.Name then
		if screen.PrevCategoryName ~= nil then
		local prevCategoryButton = screen.Components["Category"..screen.PrevCategoryName]
			if prevCategoryButton ~= nil then
				SetAlpha({ Id = prevCategoryButton.ActiveOverlayId, Fraction = 0.0, Duration = 0.1 })
				local previousShift = not IsEmpty( prevCategoryButton.IconShiftRequests )
				prevCategoryButton.IconShiftRequests.Open = nil
				if previousShift and IsEmpty( prevCategoryButton.IconShiftRequests ) then
					Move({ Id = prevCategoryButton.IconId, Angle = 270, Distance = screen.TabIconMouseOverShiftDistance, Speed = screen.TabIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
				end
			end
		end

		-- Highlight new category
		local newCategoryButton = components["Category"..category.Name]
		SetAlpha({ Id = newCategoryButton.ActiveOverlayId, Fraction = 1.0, Duration = 0.1 })
		SetAlpha({ Id = screen.Components.CategoryTitleText.Id, Fraction = 1.0, Duration = 0.1 })
		local previousShift = not IsEmpty( newCategoryButton.IconShiftRequests )
		newCategoryButton.IconShiftRequests.Open = true
		if not previousShift then
			Move({ Id = newCategoryButton.IconId, Angle = 90, Distance = screen.TabIconMouseOverShiftDistance, Speed = screen.TabIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
		end
		screen.PrevCategoryName = category.Name
	end

	screen.IconIds = {}
	screen.NumItems = 0

	local locationY = screen.RowStartY
	local columnHeaders = screen.WeaponColumnHeaders

	-- Compile the set of all eligible traits for the active filter
	local eligibleTraitStats = {}
	for traitName, traitStat in pairs( GameState.LifetimeTraitStats ) do
		if PassesTraitFilter( screen.CurrentFilter, traitName ) then
			eligibleTraitStats[traitName] = traitStat
		end
	end

	-- De-dupe dummy weapons and Aspects of Melinoe
	for aspectName, dummyName in pairs( screen.WeaponBaseAspectMapping ) do
		local aspectStat = ShallowCopyTable( eligibleTraitStats[aspectName] )
		local dummyStat = eligibleTraitStats[dummyName]

		if aspectStat ~= nil and dummyStat ~= nil then
			if aspectStat.UseCount ~= nil or dummyStat.UseCount ~= nil then
				aspectStat.UseCount = ( aspectStat.UseCount or 0 ) + ( dummyStat.UseCount or 0 )
			end
			if aspectStat.ClearCount ~= nil or dummyStat.ClearCount ~= nil then
				aspectStat.ClearCount = ( aspectStat.ClearCount or 0 ) + ( dummyStat.ClearCount or 0 )
			end
			if aspectStat.FastestTimeUnderworld ~= nil or dummyStat.FastestTimeUnderworld ~= nil then
				aspectStat.FastestTimeUnderworld = math.min( aspectStat.FastestTimeUnderworld or 999999, dummyStat.FastestTimeUnderworld or 999999 )
			end
			if aspectStat.FastestTimeSurface ~= nil or dummyStat.FastestTimeSurface ~= nil then
				aspectStat.FastestTimeSurface = math.min( aspectStat.FastestTimeSurface or 999999, dummyStat.FastestTimeSurface or 999999 )
			end
			if aspectStat.HighestShrinePointsUnderworld ~= nil or dummyStat.HighestShrinePointsUnderworld ~= nil then
				aspectStat.HighestShrinePointsUnderworld = math.max( aspectStat.HighestShrinePointsUnderworld or 0, dummyStat.HighestShrinePointsUnderworld or 0 )
			end
			if aspectStat.HighestShrinePointsSurface ~= nil or dummyStat.HighestShrinePointsSurface ~= nil then
				aspectStat.HighestShrinePointsSurface = math.max( aspectStat.HighestShrinePointsSurface or 0, dummyStat.HighestShrinePointsSurface or 0 )
			end
			eligibleTraitStats[aspectName] = aspectStat
			eligibleTraitStats[dummyName] = nil
		end
	end

	local highestUseCount = 0
	local highestClearCount = 0
	local fastestTimeUnderworld = 999999
	local fastestTimeSurface = 999999
	local highestShrinePointsUnderworld = 0
	local highestShrinePointsSurface = 0
	for traitName, traitStat in pairs( eligibleTraitStats ) do
		highestUseCount = math.max( highestUseCount, traitStat.UseCount or 0 )
		highestClearCount = math.max( highestClearCount, traitStat.ClearCount or 0 )
		fastestTimeUnderworld = math.min( fastestTimeUnderworld, traitStat.FastestTimeUnderworld or 999999 )
		highestShrinePointsUnderworld = math.max( highestShrinePointsUnderworld, traitStat.HighestShrinePointsUnderworld or 0 )
		fastestTimeSurface = math.min( fastestTimeSurface, traitStat.FastestTimeSurface or 999999 )
		highestShrinePointsSurface = math.max( highestShrinePointsSurface, traitStat.HighestShrinePointsSurface or 0 )
	end

	local sortedTraits = {}
	for traitName, traitStat in pairs( eligibleTraitStats ) do
		local displayName = traitName
		if TraitData[traitName].Slot == "Aspect" then
			displayName = GetKey( ScreenData.WeaponUpgradeScreen.FreeUnlocks, traitName ) or TraitData[traitName].CustomName or traitName
		end
		local sortableTrait = { Name = traitName, DisplayName = GetDisplayName({ Text = displayName }), Value = traitStat[screen.SortKeys[GameState.RunHistoryGameStatsSortMode]] }
		if sortableTrait.Value ~= nil and screen.SortInReverse[screen.SortKeys[GameState.RunHistoryGameStatsSortMode]] then
			sortableTrait.Value = sortableTrait.Value * -1 -- negate this so smaller time == better
		end
		table.insert( sortedTraits, sortableTrait )
	end
	table.sort( sortedTraits, GameStatsScreenSort )

	for i, sortedTrait in ipairs( sortedTraits ) do
		screen.NumItems = screen.NumItems + 1
		local columnNum = 1
		if screen.NumItems > screen.ScrollOffset and screen.NumItems <= screen.ScrollOffset + screen.ItemsPerPage then

			local traitName = sortedTrait.Name
			local traitStat = eligibleTraitStats[traitName]
			local positionData = { LoopIndex = i, LocationY = locationY }
			
			-- Name
			GameStatsCreateEntryTextbox( screen, positionData, { ColumnIndex = 1, Text = sortedTrait.DisplayName } )

			-- Icon
			local columnData = columnHeaders[2]
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY, Scale = screen.IconScaleTraits })
			components[columnData.ColumnName..i] = component
			SetAnimation({ DestinationId = component.Id, Name = TraitData[traitName].Icon })
			table.insert( screen.IconIds, component.Id )

			-- UseCount
			GameStatsCreateEntryTextbox( screen, positionData, { ColumnIndex = 3, Text = traitStat.UseCount, IsRecord = ( highestUseCount == traitStat.UseCount ) } )

			-- BarGraph
			local columnData = columnHeaders[4]
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
			components[columnData.ColumnName..i] = component
			SetAnimation({ DestinationId = component.Id, Name = "BarGraphBar" }) --nopkg
			local usageRate = traitStat.UseCount / highestUseCount
			SetScaleX({ Id = component.Id, Fraction = usageRate, Duration = 0.0 })
			table.insert( screen.IconIds, component.Id )

			-- ClearCount (Underworld + Surface)
			GameStatsCreateEntryTextbox( screen, positionData, { ColumnIndex = 5, Text = traitStat.ClearCount, IsRecord = ( highestClearCount == traitStat.ClearCount ) } )

			-- ClearRecordTime (Underworld)
			GameStatsCreateEntryTextbox( screen, positionData, { ColumnIndex = 6, Text = traitStat.FastestTimeUnderworld, IsTimeValue = true, IsRecord = ( fastestTimeUnderworld == traitStat.FastestTimeUnderworld ) } )

			-- ClearRecordShrinePoints (Underworld)
			GameStatsCreateEntryTextbox( screen, positionData, { ColumnIndex = 7, Text = traitStat.HighestShrinePointsUnderworld, IsRecord = ( highestShrinePointsUnderworld == traitStat.HighestShrinePointsUnderworld ) } )

			-- ClearRecordTime (Surface)
			GameStatsCreateEntryTextbox( screen, positionData, { ColumnIndex = 8, Text = traitStat.FastestTimeSurface, IsTimeValue = true, IsRecord = ( fastestTimeSurface == traitStat.FastestTimeSurface ) } )

			-- ClearRecordShrinePoints (Surface)
			GameStatsCreateEntryTextbox( screen, positionData, { ColumnIndex = 9, Text = traitStat.HighestShrinePointsSurface, IsRecord = ( highestShrinePointsSurface == traitStat.HighestShrinePointsSurface ) } )

			locationY = locationY + screen.RowSpacingTraits
		end
	end

end

function GameStatsCreateEntryTextbox( screen, positionData, args )
	local columnData = screen.WeaponColumnHeaders[args.ColumnIndex]
	local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = positionData.LocationY })
	screen.Components[columnData.ColumnName..positionData.LoopIndex] = component
	table.insert( screen.IconIds, component.Id )

	local templateFormat = screen.StatFormat
	if args.IsRecord then
		templateFormat = screen.RecordStatFormat
	end
	local format = ShallowCopyTable( templateFormat )
	format.Id = component.Id
	if args.IsTimeValue and args.Text ~= nil then
		format.Text = GetTimerString( args.Text, 2 )
	else
		format.Text = args.Text or "GameStats_Missing"
	end
	format.Justification = columnData.Justification
	CreateTextBox( format )
end

function PassesTraitFilter( filterName, traitName )

	local traitData = TraitData[traitName]
	if traitData == nil then
		return false
	end
	if traitData.Icon == nil then
		return false
	end

	if filterName == "GameStats_Boons" then
		if IsGodTrait( traitData.Name, { ForShop = true }) then
			return true
		end
	end

	if filterName == "GameStats_WeaponUpgrades" then
		if traitData.IsHammerTrait then
			return true
		end
	end

	if filterName == "GameStats_Weapons" then
		if traitData.Slot == "Aspect" then
			return true
		end
	end

	if filterName == "GameStats_Keepsakes" then
		if traitData.Slot == "Keepsake" or traitData.Slot == "Assist" then
			return true
		end
	end

	return false

end

function GameStatsNextCategory( screen, button )
	local nextCategoryIndex = screen.ActiveCategoryIndex
	nextCategoryIndex = nextCategoryIndex + 1
	if nextCategoryIndex > #screen.TraitFilters then
		nextCategoryIndex = 1
	end
	screen.ActiveCategoryIndex = nextCategoryIndex
	screen.ScrollOffset = 0
	ModifyTextBox({ Id = screen.Components["Category"..screen.CurrentFilter].Id, Color = Color.CodexTitleUnselected })
	screen.CurrentFilter = screen.TraitFilters[nextCategoryIndex].Name
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenShowCategoryPresentation( screen )
end

function GameStatsPrevCategory( screen, button )
	local nextCategoryIndex = screen.ActiveCategoryIndex
	nextCategoryIndex = nextCategoryIndex - 1
	if nextCategoryIndex < 1 then
		nextCategoryIndex = #screen.TraitFilters
	end
	screen.ActiveCategoryIndex = nextCategoryIndex
	screen.ScrollOffset = 0
	ModifyTextBox({ Id = screen.Components["Category"..screen.CurrentFilter].Id, Color = Color.CodexTitleUnselected })
	screen.CurrentFilter = screen.TraitFilters[nextCategoryIndex].Name
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenShowCategoryPresentation( screen )
end

function GameStatsSelectCategory( screen, button )
	screen.ScrollOffset = 0
	ModifyTextBox({ Id = screen.Components["Category"..screen.CurrentFilter].Id, Color = Color.CodexTitleUnselected })
	screen.CurrentFilter = button.Category
	screen.ActiveCategoryIndex = button.CategoryIndex
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenShowCategoryPresentation( screen )
end

function GameStatsUpdateVisibility( screen )
	local components = screen.Components
	if screen.ScrollOffset <= 0 then
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0 })
		UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1 })
		UseableOn({ Id = components.ScrollUp.Id })
	end

	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0 })
		UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1 })
		UseableOn({ Id = components.ScrollDown.Id })
	end

	TeleportCursor({ OffsetX = screen.CategoryStartX, OffsetY = screen.CategoryStartY + 360 })

end

function GameStatsChangeSortMode( screen, button )
	local sortMode = GameState.RunHistoryGameStatsSortMode
	local prevSortMode = sortMode
	if button.SortModeIndex ~= nil then
		sortMode = button.SortModeIndex
	else
		sortMode = sortMode + 1
		if sortMode > #screen.SortKeys then
			sortMode = 1
		end
	end
	GameState.RunHistoryGameStatsSortMode = sortMode

	ModifyTextBox({ Id = screen.Components[screen.SortKeys[prevSortMode]].Id, Color = screen.HeaderFormat.Color })
	GameStatsSetActiveColumnPresentation( screen )

	screen.ScrollOffset = 0
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenShowCategoryPresentation( screen )
end

function CloseGameStatsScreen( screen, button )
	GameStatScreenClosePresentation( screen, button )
	AltAspectRatioFramesHide()
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ) )
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
end

function GameStatsScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	GenericScrollPresentation( screen, button )
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
end

function GameStatsScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	GenericScrollPresentation( screen, button )
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
end

function GameStatsScreenSort( itemA, itemB )
	if itemA.Value ~= itemB.Value then
		if itemA.Value == nil then
			return false
		elseif itemB.Value == nil then
			return true
		else
			return itemA.Value > itemB.Value
		end
	end
	return itemA.DisplayName < itemB.DisplayName
end
