function UseGameStatsScreenObject( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenGameStatsScreen( usee )
	UseableOn({ Id = usee.ObjectId })
end

function OpenGameStatsScreen( openedFrom )

	local screen = DeepCopyTable( ScreenData.GameStats )
	local components = screen.Components

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	screen.HeaderY = screen.HeaderY + ScreenCenterNativeOffsetY
	screen.RowStartY = screen.RowStartY + ScreenCenterNativeOffsetY	
	screen.CategoryStartX = screen.CategoryStartX + ScreenCenterNativeOffsetX
	screen.CategoryStartY = screen.CategoryStartY + ScreenCenterNativeOffsetY

	-- Categories

	local categoryTitleX = screen.CategoryStartX
	for filterIndex, filter in ipairs( screen.TraitFilters ) do
		local filterName = filter.Name
		local categoryButton = CreateScreenComponent({ Name = "ButtonInventoryTab", X = categoryTitleX, Y = screen.CategoryStartY, Group = screen.ComponentData.DefaultGroup })
		categoryButton.OnPressedFunctionName = "GameStatsSelectCategory"
		categoryButton.Category = filterName
		categoryButton.CategoryIndex = filterIndex
		screen.Components["Category"..filterName] = categoryButton

		local categoryButtonIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Scale = screen.CategoryIconScale,
				X = categoryTitleX + screen.CategoryIconOffsetX, Y = screen.CategoryStartY + screen.CategoryIconOffsetY })
		SetAnimation({ DestinationId = categoryButtonIcon.Id, Name = filter.Icon })
		screen.Components["CategoryIcon"..filterName] = categoryButtonIcon
		
		categoryTitleX = categoryTitleX + screen.CategorySpacingX
	end

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
			headerFormat.Justification = columnData.Justification
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
	ShowWeaponStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenOpenPresentation( screen )
	wait( 0.01 )

	HandleScreenInput( screen )

end

function ShowWeaponStats( screen )

	local components = screen.Components

	Destroy({ Ids = screen.IconIds })

	local category = screen.TraitFilters[screen.ActiveCategoryIndex]
	ModifyTextBox({ Id = screen.Components.CategoryTitleText.Id, Text = category.Name })
	ModifyTextBox({ Id = components["Category"..screen.CurrentFilter].Id, Color = Color.White })

	-- Highlight new category
	if screen.PrevCategoryName ~= screen.CurrentFilter then
		if screen.PrevCategoryName ~= nil then
			StopAnimation({ DestinationId = screen.Components["Category"..screen.PrevCategoryName].Id, Name = "InventoryTabHighlightActiveCategory" })
		end
		CreateAnimation({ DestinationId = screen.Components["Category"..screen.CurrentFilter].Id, Name = "InventoryTabHighlightActiveCategory", Group = "Combat_Menu_TraitTray" })
		screen.PrevCategoryName = screen.CurrentFilter
	end

	screen.IconIds = {}
	screen.NumItems = 0

	local locationY = screen.RowStartY
	local columnHeaders = screen.WeaponColumnHeaders

	local weaponStats = GameState.LifetimeWeaponStats

	local highestUseCount = 0
	local highestClearCount = 0
	local fastestTimeUnderworld = 999999
	local fastestTimeSurface = 999999
	local highestShrinePointsUnderworld = 0
	local highestShrinePointsSurface = 0
	for weaponName, weaponStat in pairs( weaponStats ) do
		highestUseCount = math.max( highestUseCount, weaponStat.UseCount or 0 )
		highestClearCount = math.max( highestClearCount, weaponStat.ClearCount or 0 )
		fastestTimeUnderworld = math.min( fastestTimeUnderworld, weaponStat.FastestTimeUnderworld or 999999 )
		highestShrinePointsUnderworld = math.max( highestShrinePointsUnderworld, weaponStat.HighestShrinePointsUnderworld or 0 )
		fastestTimeSurface = math.min( fastestTimeSurface, weaponStat.FastestTimeSurface or 999999 )
		highestShrinePointsSurface = math.max( highestShrinePointsSurface, weaponStat.HighestShrinePointsSurface or 0 )
	end

	local sortedWeapons = {}
	for weaponName, weaponStat in pairs( weaponStats ) do
		local sortableWeapon = { Name = weaponName, DisplayName = GetDisplayName({ Text = weaponName }), Value = weaponStat[screen.SortKeys[GameState.RunHistoryGameStatsSortMode]] }
		if sortableWeapon.Value ~= nil and screen.SortInReverse[screen.SortKeys[GameState.RunHistoryGameStatsSortMode]] then
			sortableWeapon.Value = sortableWeapon.Value * -1 -- negate this so smaller time == better
		end
		table.insert( sortedWeapons, sortableWeapon )
	end
	table.sort( sortedWeapons, RunHistoryStatsSort )

	for i, sortedWeapon in ipairs( sortedWeapons ) do

		local weaponName = sortedWeapon.Name
		local weaponStat = weaponStats[weaponName]

		if IsWeaponUnlocked( weaponName ) then
			-- Name
			local columnNum = 1
			local columnData = columnHeaders[columnNum]
			local componentName = columnData.ColumnName..i
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
			components[componentName] = component
			table.insert( screen.IconIds, component.Id )
			local nameFormat = ShallowCopyTable( screen.StatFormat )
			nameFormat.Id = component.Id
			nameFormat.Text = weaponName
			nameFormat.Justification = columnData.Justification
			CreateTextBox( nameFormat )

			-- Icon
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			local componentName = columnData.ColumnName..i
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY, Scale = screen.IconScaleWeapons })
			components[componentName] = component
			SetAnimation({ DestinationId = component.Id, Name = WeaponShopItemData[weaponName].Icon })
			table.insert( screen.IconIds, component.Id )

			-- UseCount
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			local componentName = columnData.ColumnName..i
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
			components[componentName] = component
			table.insert( screen.IconIds, component.Id )
			local useCountFormat = screen.StatFormat
			if highestUseCount == weaponStat.UseCount then
				useCountFormat = screen.RecordStatFormat
			end
			useCountFormat = ShallowCopyTable( useCountFormat )
			useCountFormat.Id = component.Id
			useCountFormat.Text = weaponStat.UseCount
			useCountFormat.Justification = columnData.Justification
			CreateTextBox( useCountFormat )

			-- BarGraph
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			local componentName = columnData.ColumnName..i
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
			components[componentName] = component
			SetAnimation({ DestinationId = component.Id, Name = "BarGraphBar" })
			local usageRate = weaponStat.UseCount / highestUseCount
			SetScaleX({ Id = component.Id, Fraction = usageRate, Duration = 0.0 })
			table.insert( screen.IconIds, component.Id )

			-- ClearCount (Underworld + Surface)
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if weaponStat.ClearCount ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearCountFormat = screen.StatFormat
				if highestClearCount == weaponStat.ClearCount then
					clearCountFormat = screen.RecordStatFormat
				end
				local clearCountFormat = ShallowCopyTable( clearCountFormat )
				clearCountFormat.Id = component.Id
				clearCountFormat.Text = weaponStat.ClearCount
				clearCountFormat.Justification = columnData.Justification
				CreateTextBox( clearCountFormat )
			end

			-- ClearRecordTime (Underworld)
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if weaponStat.FastestTimeUnderworld ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearRecordTimeFormat = screen.StatFormat
				if fastestTimeUnderworld == weaponStat.FastestTimeUnderworld then
					clearRecordTimeFormat = screen.RecordStatFormat
				end
				clearRecordTimeFormat = ShallowCopyTable( clearRecordTimeFormat )
				clearRecordTimeFormat.Id = component.Id
				clearRecordTimeFormat.Text = GetTimerString( weaponStat.FastestTimeUnderworld, 2 )
				clearRecordTimeFormat.Justification = columnData.Justification
				CreateTextBox( clearRecordTimeFormat )
			end

			-- ClearRecordShrinePoints (Underworld)
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if weaponStat.HighestShrinePointsUnderworld ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearRecordShrinePointsFormat = screen.StatFormat
				if highestShrinePointsUnderworld == weaponStat.HighestShrinePointsUnderworld then
					clearRecordShrinePointsFormat = screen.RecordStatFormat
				end
				clearRecordShrinePointsFormat = ShallowCopyTable( clearRecordShrinePointsFormat )
				clearRecordShrinePointsFormat.Id = component.Id
				clearRecordShrinePointsFormat.Text = weaponStat.HighestShrinePointsUnderworld
				clearRecordShrinePointsFormat.Justification = columnData.Justification
				CreateTextBox( clearRecordShrinePointsFormat )
			end

			-- ClearRecordTime (Surface)
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if weaponStat.FastestTimeSurface ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearRecordTimeFormat = screen.StatFormat
				if fastestTimeSurface == weaponStat.FastestTimeSurface then
					clearRecordTimeFormat = screen.RecordStatFormat
				end
				clearRecordTimeFormat = ShallowCopyTable( clearRecordTimeFormat )
				clearRecordTimeFormat.Id = component.Id
				clearRecordTimeFormat.Text = GetTimerString( weaponStat.FastestTimeSurface, 2 )
				clearRecordTimeFormat.Justification = columnData.Justification
				CreateTextBox( clearRecordTimeFormat )
			end

			-- ClearRecordShrinePoints (Surface)
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if weaponStat.HighestShrinePointsSurface ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearRecordShrinePointsFormat = screen.StatFormat
				if highestShrinePointsSurface == weaponStat.HighestShrinePointsSurface then
					clearRecordShrinePointsFormat = screen.RecordStatFormat
				end
				clearRecordShrinePointsFormat = ShallowCopyTable( clearRecordShrinePointsFormat )
				clearRecordShrinePointsFormat.Id = component.Id
				clearRecordShrinePointsFormat.Text = weaponStat.HighestShrinePointsSurface
				clearRecordShrinePointsFormat.Justification = columnData.Justification
				CreateTextBox( clearRecordShrinePointsFormat )
			end

			locationY = locationY + screen.RowSpacingWeapons
		end

	end
end

function ShowTraitStats( screen )

	Destroy({ Ids = screen.IconIds })

	local components = screen.Components
	local category = screen.TraitFilters[screen.ActiveCategoryIndex]
	ModifyTextBox({ Id = screen.Components.CategoryTitleText.Id, Text = category.Name })
	ModifyTextBox({ Id = components["Category"..screen.CurrentFilter].Id, Color = Color.White })

	-- Highlight new category
	if screen.PrevCategoryName ~= screen.CurrentFilter then
		if screen.PrevCategoryName ~= nil then
			StopAnimation({ DestinationId = screen.Components["Category"..screen.PrevCategoryName].Id, Name = "InventoryTabHighlightActiveCategory" })
		end
		CreateAnimation({ DestinationId = screen.Components["Category"..screen.CurrentFilter].Id, Name = "InventoryTabHighlightActiveCategory", Group = "Combat_Menu_TraitTray" })
		screen.PrevCategoryName = screen.CurrentFilter
	end

	screen.IconIds = {}
	screen.NumItems = 0

	local locationY = screen.RowStartY
	local columnHeaders = screen.WeaponColumnHeaders

	local traitStats = GameState.LifetimeTraitStats

	-- Compile the set of all eligible traits for the active filter
	local eligibleTraitStats = {}
	for traitName, traitStat in pairs( traitStats ) do
		if PassesTraitFilter( screen.CurrentFilter, traitName ) then
			eligibleTraitStats[traitName] = traitStat
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
		local sortableTrait = { Name = traitName, DisplayName = GetDisplayName({ Text = traitName }), Value = traitStat[screen.SortKeys[GameState.RunHistoryGameStatsSortMode]] }
		if sortableTrait.Value ~= nil and screen.SortInReverse[screen.SortKeys[GameState.RunHistoryGameStatsSortMode]] then
			sortableTrait.Value = sortableTrait.Value * -1 -- negate this so smaller time == better
		end
		table.insert( sortedTraits, sortableTrait )
	end
	table.sort( sortedTraits, RunHistoryStatsSort )

	for i, sortedTrait in ipairs( sortedTraits ) do
		screen.NumItems = screen.NumItems + 1
		local columnNum = 1
		if screen.NumItems > screen.ScrollOffset and screen.NumItems <= screen.ScrollOffset + screen.ItemsPerPage then

			local traitName = sortedTrait.Name
			local traitStat = eligibleTraitStats[traitName]

			-- Name
			local columnNum = 1
			local columnData = columnHeaders[columnNum]
			local componentName = columnData.ColumnName..i
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
			components[componentName] = component
			table.insert( screen.IconIds, component.Id )
			local nameFormat = ShallowCopyTable( screen.StatFormat )
			nameFormat.Id = component.Id
			nameFormat.Text = traitName
			nameFormat.Justification = columnData.Justification
			CreateTextBox( nameFormat )

			-- Icon
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			local componentName = columnData.ColumnName..i
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY, Scale = screen.IconScaleTraits })
			components[componentName] = component
			SetAnimation({ DestinationId = component.Id, Name = TraitData[traitName].Icon })
			table.insert( screen.IconIds, component.Id )

			-- UseCount
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			local componentName = columnData.ColumnName..i
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
			components[componentName] = component
			table.insert( screen.IconIds, component.Id )
			local useCountFormat = screen.StatFormat
			if highestUseCount == traitStat.UseCount then
				useCountFormat = screen.RecordStatFormat
			end
			useCountFormat = ShallowCopyTable( useCountFormat )
			useCountFormat.Id = component.Id
			useCountFormat.Text = traitStat.UseCount
			useCountFormat.Justification = columnData.Justification
			CreateTextBox( useCountFormat )

			-- BarGraph
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			local componentName = columnData.ColumnName..i
			local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
			components[componentName] = component
			SetAnimation({ DestinationId = component.Id, Name = "BarGraphBar" })
			local usageRate = traitStat.UseCount / highestUseCount
			SetScaleX({ Id = component.Id, Fraction = usageRate, Duration = 0.0 })
			table.insert( screen.IconIds, component.Id )

			-- ClearCount (Underworld + Surface)
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if traitStat.ClearCount ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearCountFormat = screen.StatFormat
				if highestClearCount == traitStat.ClearCount then
					clearCountFormat = screen.RecordStatFormat
				end
				local clearCountFormat = ShallowCopyTable( clearCountFormat )
				clearCountFormat.Id = component.Id
				clearCountFormat.Text = traitStat.ClearCount
				clearCountFormat.Justification = columnData.Justification
				CreateTextBox( clearCountFormat )
			end

			-- ClearRecordTime (Underworld)
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if traitStat.FastestTimeUnderworld ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearRecordTimeFormat = screen.StatFormat
				if fastestTimeUnderworld == traitStat.FastestTimeUnderworld then
					clearRecordTimeFormat = screen.RecordStatFormat
				end
				clearRecordTimeFormat = ShallowCopyTable( clearRecordTimeFormat )
				clearRecordTimeFormat.Id = component.Id
				clearRecordTimeFormat.Text = GetTimerString( traitStat.FastestTimeUnderworld, 2 )
				clearRecordTimeFormat.Justification = columnData.Justification
				CreateTextBox( clearRecordTimeFormat )
			end

			-- ClearRecordShrinePoints (Underworld)
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if traitStat.HighestShrinePointsUnderworld ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearRecordShrinePointsFormat = screen.StatFormat
				if highestShrinePointsUnderworld == traitStat.HighestShrinePointsUnderworld then
					clearRecordShrinePointsFormat = screen.RecordStatFormat
				end
				clearRecordShrinePointsFormat = ShallowCopyTable( clearRecordShrinePointsFormat )
				clearRecordShrinePointsFormat.Id = component.Id
				clearRecordShrinePointsFormat.Text = traitStat.HighestShrinePointsUnderworld
				clearRecordShrinePointsFormat.Justification = columnData.Justification
				CreateTextBox( clearRecordShrinePointsFormat )
			end

			-- ClearRecordTime (Surface)
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if traitStat.FastestTimeSurface ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearRecordTimeFormat = screen.StatFormat
				if fastestTimeSurface == traitStat.FastestTimeSurface then
					clearRecordTimeFormat = screen.RecordStatFormat
				end
				clearRecordTimeFormat = ShallowCopyTable( clearRecordTimeFormat )
				clearRecordTimeFormat.Id = component.Id
				clearRecordTimeFormat.Text = GetTimerString( traitStat.FastestTimeSurface, 2 )
				clearRecordTimeFormat.Justification = columnData.Justification
				CreateTextBox( clearRecordTimeFormat )
			end

			-- ClearRecordShrinePoints (Surface)
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if traitStat.HighestShrinePointsSurface ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearRecordShrinePointsFormat = screen.StatFormat
				if highestShrinePointsSurface == traitStat.HighestShrinePointsSurface then
					clearRecordShrinePointsFormat = screen.RecordStatFormat
				end
				clearRecordShrinePointsFormat = ShallowCopyTable( clearRecordShrinePointsFormat )
				clearRecordShrinePointsFormat.Id = component.Id
				clearRecordShrinePointsFormat.Text = traitStat.HighestShrinePointsSurface
				clearRecordShrinePointsFormat.Justification = columnData.Justification
				CreateTextBox( clearRecordShrinePointsFormat )
			end

			locationY = locationY + screen.RowSpacingTraits
		end
	end

end

function PassesTraitFilter( filterName, traitName )

	local traitData = TraitData[traitName]
	if traitData == nil then
		return false
	end
	if traitData.Icon == nil then
		return false
	end

	if filterName == "GameStats_All" then
		return true
	end

	if filterName == "GameStats_RoomRewards" then
		if not traitData.IsWeaponEnchantment and traitData.Slot ~= "Keepsake" and traitData.Slot ~= "Assist" then
			return true
		end
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

	if filterName == "GameStats_Aspects" then
		if traitData.IsWeaponEnchantment then
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
	if screen.CurrentFilter == "GameStats_Weapons" then
		ShowWeaponStats( screen )
	else
		ShowTraitStats( screen )
	end
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
	if screen.CurrentFilter == "GameStats_Weapons" then
		ShowWeaponStats( screen )
	else
		ShowTraitStats( screen )
	end
	GameStatsUpdateVisibility( screen )
	GameStatsScreenShowCategoryPresentation( screen )
end

function GameStatsSelectCategory( screen, button )
	screen.ScrollOffset = 0
	ModifyTextBox({ Id = screen.Components["Category"..screen.CurrentFilter].Id, Color = Color.CodexTitleUnselected })
	screen.CurrentFilter = button.Category
	screen.ActiveCategoryIndex = button.CategoryIndex
	if screen.CurrentFilter == "GameStats_Weapons" then
		ShowWeaponStats( screen )
	else
		ShowTraitStats( screen )
	end
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
	if screen.CurrentFilter == "GameStats_Weapons" then
		ShowWeaponStats( screen )
	else
		ShowTraitStats( screen )
	end
	GameStatsUpdateVisibility( screen )
	GameStatsScreenShowCategoryPresentation( screen )
end

function CloseGameStatsScreen( screen, button )
	GameStatScreenClosePresentation( screen, button )
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
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenScrollPresentation( screen )
end

function GameStatsScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenScrollPresentation( screen )
end

function IsRecordRunDepth( currentRun )
	local highestRunDepth = GetHighestPrevRunRepth( currentRun )
	if currentRun.RunDepthCache >= highestRunDepth then
		return true
	end
	return false
end

function GetHighestPrevRunRepth( currentRun )
	local highestRunDepth = 0
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.RunDepthCache > highestRunDepth then
			highestRunDepth = prevRun.RunDepthCache
		end
	end
	return highestRunDepth
end

function GetFastestRunClearTime( currentRun )
	local fastestTime = 999999
	if currentRun.Cleared then
		fastestTime = currentRun.GameplayTime
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.Cleared and prevRun.GameplayTime ~= nil and prevRun.GameplayTime < fastestTime then
			fastestTime = prevRun.GameplayTime
		end
	end
	return fastestTime
end

function GetHighestShrinePointRunClear( currentRun, args )
	args = args or {}
	local highestPoints = 0
	if currentRun ~= nil and currentRun.Cleared and currentRun.ShrinePointsCache ~= nil then
		if args.RequiredBiome == nil or currentRun.BiomesReached[args.RequiredBiome] then
			highestPoints = currentRun.ShrinePointsCache
		end
	end
	for runIndex, prevRun in ipairs( GameState.RunHistory ) do
		if args.RequiredBiome == nil or (prevRun.BiomesReached ~= nil and prevRun.BiomesReached[args.RequiredBiome]) then
			if prevRun.Cleared and prevRun.ShrinePointsCache ~= nil and prevRun.ShrinePointsCache > highestPoints then
				highestPoints = prevRun.ShrinePointsCache
			end
		end
	end
	return highestPoints
end

function RunHasOneOfTraits( run, traits )
	if run.TraitCache == nil then
		return false
	end
	for k, traitName in pairs( traits ) do
		if run.TraitCache[traitName] then
			return true
		end
	end
	return false
end

function RunHasTraits( run, traits )
	if run.TraitCache == nil then
		return false
	end
	for k, traitName in pairs( traits ) do
		if not run.TraitCache[traitName] then
			return false
		end
	end
	return true
end

function RunHistoryStatsSort( itemA, itemB )
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