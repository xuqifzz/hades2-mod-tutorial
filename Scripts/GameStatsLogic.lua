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

	local weaponStats = {}
	local highestUseCount = 0
	local highestClearCount = 0
	local lowestClearTime = 999999
	local highestShrinePoints = 0
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		weaponStats[weaponName] = {}

		weaponStats[weaponName].UseCount = GetNumRunsWithWeapon( weaponName )
		highestUseCount = math.max( highestUseCount, weaponStats[weaponName].UseCount )

		weaponStats[weaponName].ClearCount = GetNumRunsClearedWithWeapon( weaponName )
		highestClearCount = math.max( highestClearCount, weaponStats[weaponName].ClearCount )

		weaponStats[weaponName].ClearRecordTime = GetFastestRunClearTimeWithWeapon( CurrentRun, weaponName )
		lowestClearTime = math.min( lowestClearTime, weaponStats[weaponName].ClearRecordTime or 999999 )

		weaponStats[weaponName].ClearRecordShrinePoints = GetHighestShrinePointRunClearWithWeapon( CurrentRun, weaponName )
		highestShrinePoints = math.max( highestShrinePoints, weaponStats[weaponName].ClearRecordShrinePoints or 0 )
	end

	local sortedWeapons = {}
	for weaponName, weaponStat in pairs( weaponStats ) do
		local sortableWeapon = { Name = weaponName, DisplayName = GetDisplayName({ Text = weaponName }), Value = weaponStat[screen.SortKeys[GameState.RunHistoryGameStatsSortMode]], }
		if sortableWeapon.Value ~= nil and screen.SortKeys[GameState.RunHistoryGameStatsSortMode] == "ClearRecordTime" then
			sortableWeapon.Value = sortableWeapon.Value * -1 -- negate this so smaller time == better
		end
		table.insert( sortedWeapons, sortableWeapon )
	end
	table.sort( sortedWeapons, RunHistoryStatsSort )

	local locationY = screen.RowStartY

	local columnHeaders = screen.WeaponColumnHeaders

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

			-- ClearCount
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if weaponStat.ClearCount > 0 then
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

			-- ClearRecordTime
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if weaponStat.ClearRecordTime ~= nil then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearRecordTimeFormat = screen.StatFormat
				if lowestClearTime == weaponStat.ClearRecordTime then
					clearRecordTimeFormat = screen.RecordStatFormat
				end
				clearRecordTimeFormat = ShallowCopyTable( clearRecordTimeFormat )
				clearRecordTimeFormat.Id = component.Id
				clearRecordTimeFormat.Text = GetTimerString( weaponStat.ClearRecordTime, 2 )
				clearRecordTimeFormat.Justification = columnData.Justification
				CreateTextBox( clearRecordTimeFormat )
			end
		
			-- ClearRecordShrinePoints
			columnNum = columnNum + 1
			columnData = columnHeaders[columnNum]
			if weaponStat.ClearRecordShrinePoints > 0 then
				local componentName = columnData.ColumnName..i
				local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
				components[componentName] = component
				table.insert( screen.IconIds, component.Id )
				local clearRecordShrinePointsFormat = screen.StatFormat
				if highestShrinePoints == weaponStat.ClearRecordShrinePoints then
					clearRecordShrinePointsFormat = screen.RecordStatFormat
				end
				clearRecordShrinePointsFormat = ShallowCopyTable( clearRecordShrinePointsFormat )
				clearRecordShrinePointsFormat.Id = component.Id
				clearRecordShrinePointsFormat.Text = weaponStat.ClearRecordShrinePoints
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

	local columnHeaders = screen.WeaponColumnHeaders

	local traitStats = {}
	GameStatsProcessTraitsForRun( CurrentRun, traitStats )
	for runIndex, run in ipairs( GameState.RunHistory ) do
		GameStatsProcessTraitsForRun( run, traitStats )
	end

	local sortedTraits = {}
	local highestUseCount = 0
	local highestClearCount = 0
	local lowestClearTime = 999999
	local highestShrinePoints = 0
	for traitName, traitStat in pairs( traitStats ) do
		if PassesTraitFilter( screen.CurrentFilter, traitName ) then
			local sortableTrait = { Name = traitName, DisplayName = GetDisplayName({ Text = traitName }), Value = traitStat[screen.SortKeys[GameState.RunHistoryGameStatsSortMode]], }
			if sortableTrait.Value ~= nil and screen.SortKeys[GameState.RunHistoryGameStatsSortMode] == "ClearRecordTime" then
				sortableTrait.Value = sortableTrait.Value * -1 -- negate this so smaller time == better
			end
			table.insert( sortedTraits, sortableTrait )

			highestUseCount = math.max( highestUseCount, traitStat.UseCount )
			highestClearCount = math.max( highestClearCount, traitStat.ClearCount or 0 )
			lowestClearTime = math.min( lowestClearTime, traitStat.ClearRecordTime or 999999 )
			highestShrinePoints = math.max ( highestShrinePoints, traitStat.ClearRecordShrinePoints or 0 )
		end
	end
	table.sort( sortedTraits, RunHistoryStatsSort )

	screen.IconIds = {}

	local startOffsetY = offsetY
	local columnCount = 0
	screen.NumItems = 0

	local locationY = screen.RowStartY

	for i, sortedTrait in ipairs( sortedTraits ) do
		if PassesTraitFilter( screen.CurrentFilter, sortedTrait.Name ) then
			screen.NumItems = screen.NumItems + 1
			local columnNum = 1
			if screen.NumItems > screen.ScrollOffset and screen.NumItems <= screen.ScrollOffset + screen.ItemsPerPage then

				local traitName = sortedTrait.Name
				local traitStat = traitStats[traitName]

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

				-- ClearCount
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
					clearCountFormat = ShallowCopyTable( clearCountFormat )
					clearCountFormat.Id = component.Id
					clearCountFormat.Text = traitStat.ClearCount
					clearCountFormat.Justification = columnData.Justification
					CreateTextBox( clearCountFormat )
				end

				-- ClearRecordTime
				columnNum = columnNum + 1
				columnData = columnHeaders[columnNum]
				if traitStat.ClearRecordTime ~= nil then
					local componentName = columnData.ColumnName..i
					local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
					components[componentName] = component
					table.insert( screen.IconIds, component.Id )
					local clearRecordTimeFormat = screen.StatFormat
					if lowestClearTime == traitStat.ClearRecordTime then
						clearRecordTimeFormat = screen.RecordStatFormat
					end
					clearRecordTimeFormat = ShallowCopyTable( clearRecordTimeFormat )
					clearRecordTimeFormat.Id = component.Id
					clearRecordTimeFormat.Text = GetTimerString( traitStat.ClearRecordTime, 2 )
					clearRecordTimeFormat.Justification = columnData.Justification
					CreateTextBox( clearRecordTimeFormat )
				end
		
				-- ClearRecordShrinePoints
				columnNum = columnNum + 1
				columnData = columnHeaders[columnNum]
				if traitStat.ClearRecordShrinePoints ~= nil then
					local componentName = columnData.ColumnName..i
					local component = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = columnData.X, Y = locationY })
					components[componentName] = component
					table.insert( screen.IconIds, component.Id )
					local clearRecordShrinePointsFormat = screen.StatFormat
					if highestShrinePoints == traitStat.ClearRecordShrinePoints then
						clearRecordShrinePointsFormat = screen.RecordStatFormat
					end
					clearRecordShrinePointsFormat = ShallowCopyTable( clearRecordShrinePointsFormat )
					clearRecordShrinePointsFormat.Id = component.Id
					clearRecordShrinePointsFormat.Text = traitStat.ClearRecordShrinePoints
					clearRecordShrinePointsFormat.Justification = columnData.Justification
					CreateTextBox( clearRecordShrinePointsFormat )
				end

				locationY = locationY + screen.RowSpacingTraits
			end
		end
	end

end

function GameStatsProcessTraitsForRun( run, traitStats )
	if IsSameMode( run ) and run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			traitStats[traitName] = traitStats[traitName] or {}
			traitStats[traitName].UseCount = (traitStats[traitName].UseCount or 0) + 1
			if run.Cleared then
				traitStats[traitName].ClearCount = (traitStats[traitName].ClearCount or 0) + 1
				if run.GameplayTime ~= nil and run.GameplayTime < (traitStats[traitName].ClearRecordTime or 999999) then
					traitStats[traitName].ClearRecordTime = run.GameplayTime
				end
				if run.ShrinePointsCache ~= nil and run.ShrinePointsCache > (traitStats[traitName].ClearRecordShrinePoints or 0) then
					traitStats[traitName].ClearRecordShrinePoints = run.ShrinePointsCache
				end
			end
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

function GetNumRunsWithWeapon( weaponName )
	local runCount = 0
	if CurrentRun.WeaponsCache ~= nil and CurrentRun.WeaponsCache[weaponName] then
		runCount = runCount + 1
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.WeaponsCache ~= nil and prevRun.WeaponsCache[weaponName] then
			if IsSameMode( prevRun ) then
				runCount = runCount + 1
			end
		end
	end
	return runCount
end

function GetNumRunsClearedWithWeapon( weaponName )
	local runsCleared = 0
	if CurrentRun.Cleared and CurrentRun.WeaponsCache[weaponName] then
		runsCleared = runsCleared + 1
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.WeaponsCache ~= nil and prevRun.WeaponsCache[weaponName] then
			if prevRun.Cleared and IsSameMode( prevRun ) then
				runsCleared = runsCleared + 1
			end
		end
	end
	return runsCleared
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
		if IsSameMode( prevRun ) and prevRun.Cleared and prevRun.GameplayTime ~= nil and prevRun.GameplayTime < fastestTime then
			fastestTime = prevRun.GameplayTime
		end
	end
	return fastestTime
end

function GetFastestRunClearTimeWithWeapon( currentRun, weapon )
	local fastestTime = nil
	if currentRun.Cleared and currentRun.WeaponsCache[weapon] then
		fastestTime = currentRun.GameplayTime
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.WeaponsCache ~= nil and prevRun.WeaponsCache[weapon] then
			if IsSameMode( prevRun ) and prevRun.Cleared and prevRun.GameplayTime ~= nil and (fastestTime == nil or prevRun.GameplayTime < fastestTime) then
				fastestTime = prevRun.GameplayTime
			end
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
			if (args.IgnoreSameMode or IsSameMode( prevRun )) and prevRun.Cleared and prevRun.ShrinePointsCache ~= nil and prevRun.ShrinePointsCache > highestPoints then
				highestPoints = prevRun.ShrinePointsCache
				--DebugPrint({ Text = "runIndex = "..runIndex })
				--DebugPrint({ Text = "highestPoints = "..highestPoints })
			end
		end
	end
	return highestPoints
end

function GetHighestShrinePointRunClearWithWeapon( currentRun, weapon )
	local highestPoints = 0
	if currentRun ~= nil and currentRun.Cleared and currentRun.ShrinePointsCache ~= nil and currentRun.WeaponsCache[weapon] then
		highestPoints = currentRun.ShrinePointsCache
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.WeaponsCache ~= nil and prevRun.WeaponsCache[weapon] then
			if IsSameMode( prevRun ) and prevRun.Cleared and prevRun.ShrinePointsCache ~= nil and prevRun.ShrinePointsCache > highestPoints then
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