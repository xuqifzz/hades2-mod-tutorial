function UseQuestLog( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenQuestLogScreen()
	UseableOn({ Id = usee.ObjectId })
end

function OpenQuestLogScreen( args )
	ResetKeywords()

	AltAspectRatioFramesShow()

	local screen = DeepCopyTable( ScreenData.QuestLog )
	ScreenAnchors.QuestLogScreen = screen
	local components = screen.Components

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	wait(0.3)

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	local readyToCashOutQuests = {}
	local incompleteQuests = {}
	local cashedOutQuests = {}

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		if questData.SetupEvents ~= nil then
			questData = ShallowCopyTable( questData )
			RunEventsGeneric( questData.SetupEvents, questData )
		end
		if GameState.QuestStatus[questData.Name] == "CashedOut" then
			table.insert( cashedOutQuests, questData )
		-- @ for testing, adjust this requirement to show all
		elseif IsGameStateEligible( questData, questData.UnlockGameStateRequirements ) then
			if IsGameStateEligible( questData, questData.CompleteGameStateRequirements ) then
				table.insert( readyToCashOutQuests, questData )
			else
				table.insert( incompleteQuests, questData )
			end
		end
	end

	screen.NumItems = 0
	screen.AnyNew = false
	screen.NumToCashOut = 0
	screen.ViewedQuestProgress = {}

	for k, questData in ipairs( readyToCashOutQuests ) do

		-- QuestButton
		screen.NumItems = screen.NumItems + 1
		local questButtonKey = "QuestButton"..screen.NumItems
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Scale = 1, X = itemLocationX, Y = itemLocationY, Group = screen.ComponentData.DefaultGroup })
		components[questButtonKey] = button
		components[questButtonKey].MouseOverSound = "/Leftovers/World Sounds/Caravan Interior/CardsInteract"
		components[questButtonKey].OnPressedFunctionName = "CashOutQuest"
		components[questButtonKey].OnMouseOverFunctionName = "MouseOverQuest"
		components[questButtonKey].OnMouseOffFunctionName = "MouseOffQuest"
		components[questButtonKey].Data = questData
		components[questButtonKey].Index = screen.NumItems
		button.Screen = screen
		AttachLua({ Id = components[questButtonKey].Id, Table = components[questButtonKey] })
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectInputMultiplierX", Value = 0.0 })

		local newButtonKey = "NewIcon"..screen.NumItems
		if not GameState.QuestsViewed[questData.Name] then
			-- New icon
			screen.AnyNew = true
			components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup })
			SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "QuestLogNewQuest" })
			Attach({ Id = components[newButtonKey].Id, DestinationId = components[questButtonKey].Id, OffsetX = screen.NewIconOffsetX, OffsetY = 0 })
		end

		local strikethroughKey = "Strikethrough"..screen.NumItems
		components[strikethroughKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Alpha = 0.0 })
		Attach({ Id = components[strikethroughKey].Id, DestinationId = components[questButtonKey].Id })

		local readyToCashOutFormat = screen.ReadyToCashOutFormat
		readyToCashOutFormat.Id = components[questButtonKey].Id
		readyToCashOutFormat.Text = questData.Name
		CreateTextBox( readyToCashOutFormat )
		
		local readyToCashOutFlash = screen.ReadyToCashOutFlash
		readyToCashOutFlash.Id = components[questButtonKey].Id
		Flash( readyToCashOutFlash )

		itemLocationY = itemLocationY + screen.ItemSpacingY

		screen.NumToCashOut = screen.NumToCashOut + 1

	end

	for k, questData in ipairs( incompleteQuests ) do

		-- QuestButton
		screen.NumItems = screen.NumItems + 1
		local questButtonKey = "QuestButton"..screen.NumItems
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Scale = 1, X = itemLocationX, Y = itemLocationY, Group = screen.ComponentData.DefaultGroup })
		components[questButtonKey] = button
		components[questButtonKey].MouseOverSound = "/Leftovers/World Sounds/Caravan Interior/CardsInteract"
		components[questButtonKey].OnMouseOverFunctionName = "MouseOverQuest"
		components[questButtonKey].OnMouseOffFunctionName = "MouseOffQuest"
		components[questButtonKey].Data = questData
		components[questButtonKey].Index = screen.NumItems
		button.Screen = screen
		AttachLua({ Id = components[questButtonKey].Id, Table = components[questButtonKey] })
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectInputMultiplierX", Value = 0.0 })

		local newButtonKey = "NewIcon"..screen.NumItems
		if not GameState.QuestsViewed[questData.Name] then
			-- New icon
			screen.AnyNew = true
			components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup })
			SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "QuestLogNewQuest" })
			Attach({ Id = components[newButtonKey].Id, DestinationId = components[questButtonKey].Id, OffsetX = screen.NewIconOffsetX, OffsetY = 0 })
		end

		local incomleteFormat = screen.IncompleteFormat
		incomleteFormat.Id = components[questButtonKey].Id
		incomleteFormat.Text = questData.Name
		CreateTextBox( incomleteFormat )

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	for k, questData in ipairs( cashedOutQuests ) do

		-- QuestButton
		screen.NumItems = screen.NumItems + 1
		local questButtonKey = "QuestButton"..screen.NumItems
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Scale = 1, X = itemLocationX, Y = itemLocationY, Group = screen.ComponentData.DefaultGroup })
		components[questButtonKey] = button
		components[questButtonKey].MouseOverSound = "/Leftovers/World Sounds/Caravan Interior/CardsInteract"
		components[questButtonKey].OnMouseOverFunctionName = "MouseOverQuest"
		components[questButtonKey].OnMouseOffFunctionName = "MouseOffQuest"
		components[questButtonKey].Data = questData
		components[questButtonKey].Index = screen.NumItems
		button.Screen = screen
		AttachLua({ Id = components[questButtonKey].Id, Table = components[questButtonKey] })
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectInputMultiplierX", Value = 0.0 })

		local strikethroughKey = "Strikethrough"..screen.NumItems
		components[strikethroughKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Animation = "QuestLogScreenStrikethrough", Alpha = 0.0 })
		Attach({ Id = components[strikethroughKey].Id, DestinationId = components[questButtonKey].Id })

		local cashedOutFormat = screen.CashedOutFormat
		cashedOutFormat.Id = components[questButtonKey].Id
		cashedOutFormat.Text = questData.Name
		CreateTextBox( cashedOutFormat )

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	QuestLogUpdateVisibility( screen, { ScrolledDown = true } )

	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	wait( 0.1 )

	QuestLogOpenFinishPresentation( screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )

end

function CashOutQuest( screen, button )

	local questData = button.Data
	if questData.CompleteGameStateRequirements ~= nil and not IsGameStateEligible( questData, questData.CompleteGameStateRequirements ) then
		QuestIncompletePresentation( button )
		return
	end

	if GameState.QuestStatus[button.Data.Name] ~= "CashedOut" then
		AddResource( button.Data.RewardResourceName, button.Data.RewardResourceAmount, "Quest", { SkipVoiceLines = true } )
		GameState.QuestStatus[button.Data.Name] = "CashedOut"
		QuestCashedOutPresentation( screen, button )
	end

	StopFlashing({ Id = button.Id })

	local justCashedOutFormat = screen.JustCashedOutFormat
	justCashedOutFormat.Id = button.Id
	ModifyTextBox( justCashedOutFormat )

	SetAlpha({ Id = screen.Components.RewardText.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.RewardClaimedIcon.Id, Fraction = 1.0, Duration = 0.2 })

end

function CloseQuestLogScreen( screen, button )
	killTaggedThreads( "QuestLogPulse" )
	AltAspectRatioFramesHide()
	OnScreenCloseStarted( screen )
	QuestLogScreenClosePresentation( screen, button )
	CloseScreen( GetAllIds( screen.Components ), 0.1, screen )
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
end

function HasActiveQuestForName( name )

	local requirements =
	{
		NamedRequirements = { "QuestLogUnlocked", },
	}
	if not IsGameStateEligible( screen, requirements ) then
		return false
	end

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		if --[[GameState.QuestsViewed[questName] and]] GameState.QuestStatus[questData.Name] ~= "CashedOut" and IsGameStateEligible( questData, questData.UnlockGameStateRequirements ) then
			for j, requirement in pairs( questData.CompleteGameStateRequirements ) do
				if requirement.HasAll ~= nil then
					if Contains( requirement.HasAll, name ) then
						return true
					end
				end
			end
		end
	end

	return false

end

function HasAnyQuestWithStatus( status )

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		if GameState.QuestStatus[questData.Name] == "CashedOut" then
			if status == "CashedOut" then
				return true
			end
		elseif IsGameStateEligible( questData, questData.UnlockGameStateRequirements ) then
			if IsGameStateEligible( questData, questData.CompleteGameStateRequirements ) then
				if status == "Complete" then
					return true
				end
			else
				if status == "Incomplete" then
					return true
				end
			end
		end
	end

	return false

end

function QuestLogHideScrollButtons( screen, args )
	if args.HideLeft then
		SetAlpha({ Id = screen.Components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.2 })
		MouseOffContextualAction( screen.Components.ScrollLeft )
	end
	if args.HideRight then
		SetAlpha({ Id = screen.Components.ScrollRight.Id, Fraction = 0.0, Duration = 0.2 })
		screen.Components.ScrollRight.Visible = false
		killTaggedThreads( "QuestLogPulse" )
		MouseOffContextualAction( screen.Components.ScrollRight )
	end
end

function ShowQuestProgress( screen, questData, requirements )

	requirements = requirements or questData.DisplayedCompleteGameStateRequirements or questData.CompleteGameStateRequirements

	local index = 0
	local visibleIndex = 1
	local spacing = questData.Spacing or screen.RequirementRowSpacing
	local baseOffsetY = GetLocalizedValue( 0, screen.CompleteRequirementsOffsetY )
	local offsetY = baseOffsetY	

	local maxEntriesPerColumn = questData.MaxEntriesPerColumn or screen.RequirementEntriesPerColumn
	local currentColumn = 1
	local columnWidth = screen.RequirementColumnSpacing

	local completeColor = screen.RequirementCompleteColor
	local incompleteColor = screen.RequirementIncompleteColor

	local isComplete = IsGameStateEligible( questData, questData.CompleteGameStateRequirements )

	if questData.CustomCompleteString ~= nil and isComplete then
		local completionRequirementFormat = ShallowCopyTable( screen.CompletionRequirementFormat )
		completionRequirementFormat.Id = screen.Components.DescriptionBox.Id
		completionRequirementFormat.Text = questData.CustomCompleteString
		completionRequirementFormat.OffsetX = 0
		completionRequirementFormat.OffsetY = offsetY
		completionRequirementFormat.Color = completeColor
		CreateTextBox( completionRequirementFormat )
		QuestLogHideScrollButtons( screen, { HideLeft = true, HideRight = true } )
		screen.NumRequirements = 1
		screen.NumRequirementsColumns = 1
		return
	end

	if questData.CustomIncompleteString ~= nil and not isComplete then
		local completionRequirementFormat = ShallowCopyTable( screen.CompletionRequirementFormat )
		completionRequirementFormat.Id = screen.Components.DescriptionBox.Id
		completionRequirementFormat.Text = questData.CustomIncompleteString
		completionRequirementFormat.OffsetX = 0
		completionRequirementFormat.OffsetY = offsetY
		completionRequirementFormat.Color = incompleteColor
		CreateTextBox( completionRequirementFormat )
		QuestLogHideScrollButtons( screen, { HideLeft = true, HideRight = true } )
		screen.NumRequirements = 1
		screen.NumRequirementsColumns = 1
		return
	end

	local maxVisibleRequirements = screen.RequirementEntriesPerColumn * screen.RequirementEntriesMaxColumns
	local firstVisibleIndex = 1 + (screen.ProgressPageOffset * screen.RequirementEntriesPerColumn)
	local maxVisibleIndex = (firstVisibleIndex + maxVisibleRequirements) - 1

	-- Generic requirements
	for i, requirement in ipairs( requirements ) do

		local valueToCheck = _G
		local path = requirement.Path or requirement.PathTrue or requirement.PathFalse
		if path ~= nil then
			for j, subTable in ipairs( path ) do
				valueToCheck = valueToCheck[subTable]
				if valueToCheck == nil then
					break
				end
			end
		end
		if requirement.UseLength then
			valueToCheck = TableLength( valueToCheck )
		elseif requirement.CountOf ~= nil then
			local count = 0
			for i, keyToCount in ipairs( requirement.CountOf ) do
				if valueToCheck[keyToCount] then
					count = count + 1
				end
			end
			valueToCheck = count
		end

		if requirement.Value ~= nil then
			local currentCount = valueToCheck or 0
			local goalCount = requirement.Value
			local color = completeColor
			local text = "QuestLog_ProgressCountComplete"
			if currentCount < goalCount then
				color = incompleteColor
				text = "QuestLog_ProgressCountIncomplete"
			end

			index = index + 1
			if index >= firstVisibleIndex and index <= maxVisibleIndex then
				local completionRequirementFormat = ShallowCopyTable( screen.CompletionRequirementFormat )
				completionRequirementFormat.Id = screen.Components.DescriptionBox.Id
				completionRequirementFormat.Text = text
				completionRequirementFormat.OffsetX = ( currentColumn - 1 ) * columnWidth
				completionRequirementFormat.OffsetY = offsetY
				completionRequirementFormat.Color = color
				completionRequirementFormat.TextSymbolScale = questData.CompletionRequirementTextSymbolScale or completionRequirementFormat.TextSymbolScale
				completionRequirementFormat.LuaKey = "TempTextData"
				completionRequirementFormat.LuaValue = { Current = currentCount, Goal = goalCount }
				CreateTextBox( completionRequirementFormat )
				visibleIndex = visibleIndex + 1
				offsetY = offsetY + spacing
			end
			
			index = index + 1
			if visibleIndex > maxEntriesPerColumn * currentColumn then
				currentColumn = currentColumn + 1
				offsetY = baseOffsetY
			end
		elseif requirement.PathTrue then
			local numKeys = #requirement.PathTrue
			local finalKey = requirement.PathTrue[numKeys]
			if questData.DisplaySemiFinalRequirementKey then
				finalKey = requirement.PathTrue[numKeys - 1]
			end
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			local completionText = nil
			if not valueToCheck then
				color = incompleteColor
				text = "QuestLog_QuestProgressIncomplete"
				completionText = questData.IncompleteName
			end

			index = index + 1
			if index >= firstVisibleIndex and index <= maxVisibleIndex then

				local bulletPointFormat = ShallowCopyTable( screen.BulletPointFormat )
				bulletPointFormat.Id = screen.Components.DescriptionBox.Id
				bulletPointFormat.Text = text
				bulletPointFormat.OffsetX = ( currentColumn - 1 ) * columnWidth
				bulletPointFormat.OffsetY = offsetY
				bulletPointFormat.Text = text
				CreateTextBox( bulletPointFormat )

				local completionRequirementFormat = ShallowCopyTable( screen.CompletionRequirementFormat )
				completionRequirementFormat.Id = screen.Components.DescriptionBox.Id
				completionRequirementFormat.OffsetX = screen.CompleteRequirementsOffsetX + ( ( currentColumn - 1 ) * columnWidth )
				completionRequirementFormat.OffsetY = offsetY
				completionRequirementFormat.Color = color
				completionRequirementFormat.TextSymbolScale = questData.CompletionRequirementTextSymbolScale or completionRequirementFormat.TextSymbolScale
				completionRequirementFormat.Text = completionText or completionRequirementFormat.Text
				completionRequirementFormat.LuaKey = "TempTextData"
				completionRequirementFormat.LuaValue = { Requirement = finalKey }
				CreateTextBox( completionRequirementFormat )
				visibleIndex = visibleIndex + 1
				offsetY = offsetY + spacing
			end

			if visibleIndex > maxEntriesPerColumn * currentColumn then
				currentColumn = currentColumn + 1
				offsetY = baseOffsetY
			end
		elseif requirement.HasAll ~= nil then
			for k, key in ipairs( requirement.HasAll ) do
				local complete = false
				if valueToCheck ~= nil and ( valueToCheck[key] or ( requirement.AllowSubstitutions ~= nil and valueToCheck[requirement.AllowSubstitutions[key]] ) ) then
					complete = true
				end
				local color = completeColor
				local text = "QuestLog_QuestProgressComplete"
				local completionText = nil
				if not complete then
					color = incompleteColor
					text = "QuestLog_QuestProgressIncomplete"
					completionText = questData.IncompleteName
				end
				if questData.MetaUpgradeNotUnlockedName ~= nil and not GameState.MetaUpgradeState[key].Unlocked then
					completionText = questData.MetaUpgradeNotUnlockedName
				end

				index = index + 1
				if index >= firstVisibleIndex and index <= maxVisibleIndex then

					local bulletPointFormat = ShallowCopyTable( screen.BulletPointFormat )
					bulletPointFormat.Id = screen.Components.DescriptionBox.Id
					bulletPointFormat.Text = text
					bulletPointFormat.OffsetX = ( currentColumn - 1 ) * columnWidth
					bulletPointFormat.OffsetY = offsetY
					bulletPointFormat.Text = text
					CreateTextBox( bulletPointFormat )

					local completionRequirementFormat = ShallowCopyTable( screen.CompletionRequirementFormat )
					completionRequirementFormat.Id = screen.Components.DescriptionBox.Id
					completionRequirementFormat.OffsetX = screen.CompleteRequirementsOffsetX + ( ( currentColumn - 1 ) * columnWidth )
					completionRequirementFormat.OffsetY = offsetY
					completionRequirementFormat.Color = color
					completionRequirementFormat.TextSymbolScale = questData.CompletionRequirementTextSymbolScale or completionRequirementFormat.TextSymbolScale
					completionRequirementFormat.Text = completionText or completionRequirementFormat.Text
					completionRequirementFormat.LuaKey = "TempTextData"
					completionRequirementFormat.LuaValue = { Requirement = key }
					CreateTextBox( completionRequirementFormat )
					visibleIndex = visibleIndex + 1
					offsetY = offsetY + spacing
				end

				if visibleIndex > maxEntriesPerColumn * currentColumn then
					currentColumn = currentColumn + 1
					offsetY = baseOffsetY
				end
			end
		elseif requirement.HasAny ~= nil then
			for k, key in ipairs( requirement.HasAny ) do
				local color = completeColor
				local text = "QuestLog_QuestProgressComplete"
				local completionText = nil
				if not valueToCheck[key] then
					color = incompleteColor
					text = "QuestLog_QuestProgressIncomplete"
					completionText = questData.IncompleteName
				end
				
				index = index + 1
				if index >= firstVisibleIndex and index <= maxVisibleIndex then
					
					local bulletPointFormat = ShallowCopyTable( screen.BulletPointFormat )
					bulletPointFormat.Id = screen.Components.DescriptionBox.Id
					bulletPointFormat.Text = text
					bulletPointFormat.OffsetX = ( currentColumn - 1 ) * columnWidth
					bulletPointFormat.OffsetY = offsetY
					bulletPointFormat.Text = text
					CreateTextBox( bulletPointFormat )

					local completionRequirementFormat = ShallowCopyTable( screen.CompletionRequirementFormat )
					completionRequirementFormat.Id = screen.Components.DescriptionBox.Id
					completionRequirementFormat.OffsetX = screen.CompleteRequirementsOffsetX + ( ( currentColumn - 1 ) * columnWidth )
					completionRequirementFormat.OffsetY = offsetY
					completionRequirementFormat.Color = color
					completionRequirementFormat.TextSymbolScale = questData.CompletionRequirementTextSymbolScale or completionRequirementFormat.TextSymbolScale
					completionRequirementFormat.Text = completionText or completionRequirementFormat.Text
					completionRequirementFormat.LuaKey = "TempTextData"
					completionRequirementFormat.LuaValue = { Requirement = key }
					CreateTextBox( completionRequirementFormat )
					visibleIndex = visibleIndex + 1
					offsetY = offsetY + spacing
				end

				if visibleIndex > maxEntriesPerColumn * currentColumn then
					currentColumn = currentColumn + 1
					offsetY = baseOffsetY
				end
			end
		end

	end

	screen.NumRequirements = index
	--DebugPrint({ Text = "screen.NumRequirements = "..screen.NumRequirements })
	screen.NumRequirementsColumns = math.ceil( screen.NumRequirements / screen.RequirementEntriesPerColumn )
	--DebugPrint({ Text = "screen.NumRequirementsColumns = "..screen.NumRequirementsColumns })
	if screen.ProgressPageOffset >= 1 then
		SetAlpha({ Id = screen.Components.ScrollLeft.Id, Fraction = 1.0, Duration = 0.2 })
	else
		QuestLogHideScrollButtons( screen, { HideLeft = true } )
	end
	if screen.ProgressPageOffset <= (screen.NumRequirementsColumns - screen.RequirementEntriesMaxColumns) - 1 then
		SetAlpha({ Id = screen.Components.ScrollRight.Id, Fraction = 1.0, Duration = 0.2 })
		if not screen.Components.ScrollRight.Visible then
			screen.Components.ScrollRight.Visible = true
			if not screen.ViewedQuestProgress[questData.Name] then
				thread( PulseContextActionPresentation, screen.Components.ScrollRight, { ThreadName = "QuestLogPulse" } )
			end
		end
	else
		QuestLogHideScrollButtons( screen, { HideRight = true } )
	end
	
end

function CheckQuestStatus( args )

	local requirements =
	{
		NamedRequirements = { "QuestLogUnlocked", },
	}
	if not IsGameStateEligible( nil, requirements ) then
		return false
	end

	args = args or {}
	
	local threadName = "CheckQuestsComplete"
	if not args.Silent then
		if SetThreadWait( threadName, 0.3 ) then
			return
		end
		wait( 0.3, threadName )
	end

	local questAdded = false
	local questCompleted = false

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		local thisQuestAdded = false
		if GameState.QuestStatus[questData.Name] == nil then
			-- Locked
			if IsGameStateEligible( questData, questData.UnlockGameStateRequirements ) then
				-- Unlocked
				GameState.QuestStatus[questData.Name] = "Unlocked"
				thisQuestAdded = true
			end
			if not args.Silent then
				wait( 0.02, threadName ) -- Distribute workload over frames
			end
		end
		if GameState.QuestStatus[questData.Name] == "Unlocked" then
			if IsGameStateEligible( questData, questData.CompleteGameStateRequirements ) then
				-- Completed
				GameState.QuestStatus[questData.Name] = "Complete"
				GameState.QuestsCompleted[questData.Name] = true
				questCompleted = true
				-- If you simultaneously unlock and complete a quest, skip the unlock presentation.
				if thisQuestAdded then
					thisQuestAdded = false
				end
			end
			if not args.Silent then
				wait( 0.02, threadName ) -- Distribute workload over frames
			end
		end
		questAdded = questAdded or thisQuestAdded
	end

	if not args.Silent then
		if questCompleted then
			QuestCompletedPresentation( nil, threadName )
			wait( 0.2, threadName )
			thread( CheckProgressAchievements )
		end
		if questAdded then
			QuestAddedPresentation( nil, threadName )
			wait( 0.2, threadName )
		end
	end

end

function QuestLogScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	QuestLogUpdateVisibility( screen, { ScrolledUp = true } )
	--GenericScrollPresentation( screen, button )
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
end

function QuestLogScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	QuestLogUpdateVisibility( screen, { ScrolledDown = true } )
	--GenericScrollPresentation( screen, button )
	wait( 0.02 )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
end

function QuestLogUpdateVisibility( screen, args )

	args = args or {}
	local components = screen.Components

	GhostAdminUpdateScrollbarPresentation( screen, { AnimateSlider = true } )

	SetAlpha({ Id = components.SelectionMarker.Id, Fraction = 0 })

	for index = 1, screen.NumItems do
		local questButtonKey = (screen.ButtonName or "QuestButton")..index
		local newButtonKey = "NewIcon"..index
		local strikethroughKey = "Strikethrough"..index

		local visibleIndex = index - screen.ScrollOffset

		if visibleIndex >= 1 and visibleIndex <= screen.ItemsPerPage then
			-- Page in view
			Teleport({ Id = components[questButtonKey].Id, OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((visibleIndex - 1) * screen.ItemSpacingY) })
			SetAlpha({ Id = components[questButtonKey].Id, Fraction = 1 })
			if components[newButtonKey] ~= nil and not GameState.QuestsViewed[components[questButtonKey].Data.Name] then
				SetAlpha({ Id = components[newButtonKey].Id, Fraction = 1 })
			end
			if components[strikethroughKey] ~= nil and GameState.QuestStatus[components[questButtonKey].Data.Name] == "CashedOut" then
				SetAlpha({ Id = components[strikethroughKey].Id, Fraction = 1 })
			end
			UseableOn({ Id = components[questButtonKey].Id })
			if visibleIndex == 1 and args.ScrolledDown then
				MouseOverQuest( components[questButtonKey] )
			elseif visibleIndex == screen.ItemsPerPage and args.ScrolledUp then
				MouseOverQuest( components[questButtonKey] )
			end
		else
			-- Page out of view
			SetAlpha({ Id = components[questButtonKey].Id, Fraction = 0 })
			if components[newButtonKey] ~= nil then
				SetAlpha({ Id = components[newButtonKey].Id, Fraction = 0 })
			end
			if components[strikethroughKey] ~= nil then
				SetAlpha({ Id = components[strikethroughKey].Id, Fraction = 0 })
			end
			UseableOff({ Id = components[questButtonKey].Id, ForceHighlightOff = true  })
		end
	end

end

function ValidateQuestData()
	if not verboseLogging then
		return
	end
	for i, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		DebugAssert({ Condition = questData ~= nil, Text = "Non-existent quest included in QuestOrderData: "..questName, Owner = "Greg" })
		if questData ~= nil then
			DebugAssert({ Condition = questData.Decal ~= nil, Text = questName.." is missing a Decal!", Owner = "Greg" })
		end
	end
end
