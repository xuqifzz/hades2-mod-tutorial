function UseQuestLog( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenQuestLogScreen()
	UseableOn({ Id = usee.ObjectId })
end

function OpenQuestLogScreen( args )
	ResetKeywords()
	local screen = DeepCopyTable( ScreenData.QuestLog )
	ScreenAnchors.QuestLogScreen = screen
	local components = screen.Components

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	--wait(0.2)

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	local readyToCashOutQuests = {}
	local incompleteQuests = {}
	local cashedOutQuests = {}

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
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

	for k, questData in ipairs( readyToCashOutQuests ) do

		-- QuestButton
		screen.NumItems = screen.NumItems + 1
		local questButtonKey = "QuestButton"..screen.NumItems
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Scale = 1, X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })
		components[questButtonKey] = button
		components[questButtonKey].MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu"
		components[questButtonKey].OnPressedFunctionName = "CashOutQuest"
		components[questButtonKey].OnMouseOverFunctionName = "MouseOverQuest"
		components[questButtonKey].OnMouseOffFunctionName = "MouseOffQuest"
		components[questButtonKey].Data = questData
		components[questButtonKey].Index = screen.NumItems
		button.Screen = screen
		AttachLua({ Id = components[questButtonKey].Id, Table = components[questButtonKey] })

		local newButtonKey = "NewIcon"..screen.NumItems
		if not GameState.QuestsViewed[questData.Name] then
			-- New icon
			screen.AnyNew = true
			components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "QuestLogNewQuest" })
			Attach({ Id = components[newButtonKey].Id, DestinationId = components[questButtonKey].Id, OffsetX = screen.NewIconOffsetX, OffsetY = 0 })
		end

		local strikethroughKey = "Strikethrough"..screen.NumItems
		components[strikethroughKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Animation = "QuestLogStrikethrough", Alpha = 0.0 })
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
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Scale = 1, X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })
		components[questButtonKey] = button
		components[questButtonKey].MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu"
		components[questButtonKey].OnMouseOverFunctionName = "MouseOverQuest"
		components[questButtonKey].OnMouseOffFunctionName = "MouseOffQuest"
		components[questButtonKey].Data = questData
		components[questButtonKey].Index = screen.NumItems
		button.Screen = screen
		AttachLua({ Id = components[questButtonKey].Id, Table = components[questButtonKey] })

		local newButtonKey = "NewIcon"..screen.NumItems
		if not GameState.QuestsViewed[questData.Name] then
			-- New icon
			screen.AnyNew = true
			components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
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
		local button = CreateScreenComponent({ Name = "BlankInteractableObstacle", Scale = 1, X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })
		components[questButtonKey] = button
		components[questButtonKey].MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu"
		components[questButtonKey].OnMouseOverFunctionName = "MouseOverQuest"
		components[questButtonKey].OnMouseOffFunctionName = "MouseOffQuest"
		components[questButtonKey].Data = questData
		components[questButtonKey].Index = screen.NumItems
		button.Screen = screen
		AttachLua({ Id = components[questButtonKey].Id, Table = components[questButtonKey] })

		local strikethroughKey = "Strikethrough"..screen.NumItems
		components[strikethroughKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Animation = "QuestLogStrikethrough", Alpha = 0.0 })
		Attach({ Id = components[strikethroughKey].Id, DestinationId = components[questButtonKey].Id })

		local cashedOutFormat = screen.CashedOutFormat
		cashedOutFormat.Id = components[questButtonKey].Id
		cashedOutFormat.Text = questData.Name
		CreateTextBox( cashedOutFormat )

		itemLocationY = itemLocationY + screen.ItemSpacingY

	end

	QuestLogUpdateVisibility( screen )

	wait( 0.1 )
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

	ModifyTextBox({ Id = screen.Components.RewardText.Id, Color = screen.RewardCashedOutColor })

end

function CloseQuestLogScreen( screen, button )
	--SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = screen.CloseAnimation })
	killTaggedThreads("QuestLogPulse")
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.1 )
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
	thread( CheckProgressAchievements )
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

function HasActiveQuestForItem( name )

	local requirements =
	{
		NamedRequirements = { "QuestLogUnlocked", },
	}
	if not IsGameStateEligible( nil, requirements ) then
		return false
	end

	for k, questName in ipairs( QuestOrderData ) do
		-- @todo
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

function HasAllQuestsWithStatus( status )

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		if GameState.QuestStatus[questData.Name] ~= status then
			return false
		end
	end

	return true

end

function QuestLogHideScrollButtons( screen, args )
	if args.HideLeft then
		SetAlpha({ Id = screen.Components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.2 })
		MouseOffContextualAction( screen.Components.ScrollLeft )
	end
	if args.HideRight then
		SetAlpha({ Id = screen.Components.ScrollRight.Id, Fraction = 0.0, Duration = 0.2 })
		screen.Components.ScrollRight.Visible = false
		killTaggedThreads("QuestLogPulse")
		MouseOffContextualAction( screen.Components.ScrollRight )
	end
end

function ShowQuestProgress( screen, questData, requirements )

	requirements = requirements or questData.CompleteGameStateRequirements

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
		completionRequirementFormat.OffsetX = screen.CompleteRequirementsOffsetX + ( ( currentColumn - 1 ) * columnWidth )
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
		completionRequirementFormat.OffsetX = screen.CompleteRequirementsOffsetX + ( ( currentColumn - 1 ) * columnWidth )
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
				completionRequirementFormat.OffsetX = screen.CompleteRequirementsOffsetX + ( ( currentColumn - 1 ) * columnWidth )
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
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			local completionText = nil
			if not valueToCheck then
				color = incompleteColor
				text = "QuestLog_QuestProgressIncomplete"
				completionText = questData.IncompleteName
			end

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
				local color = completeColor
				local text = "QuestLog_QuestProgressComplete"
				local completionText = nil
				if valueToCheck == nil or not valueToCheck[key] then
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
			thread( QuestLogPulsePageButton, screen.Components.ScrollRight )
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
	QuestLogUpdateVisibility( screen )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
	GenericScrollPresentation( screen, button )
end

function QuestLogScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	QuestLogUpdateVisibility( screen )
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	GenericScrollPresentation( screen, button )
end

function QuestLogUpdateVisibility( screen )

	local components = screen.Components
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