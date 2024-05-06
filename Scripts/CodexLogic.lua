function CodexInit()
	CodexStatus = CodexStatus or {}
	CodexStatus.SelectedChapterName = CodexStatus.SelectedChapterName or ScreenData.Codex.DefaultChapter
	CodexStatus.SelectedEntryNames = CodexStatus.SelectedEntryNames or {}
	CodexStatus.SelectedEntryNames[ScreenData.Codex.DefaultChapter] = CodexStatus.SelectedEntryNames[ScreenData.Codex.DefaultChapter] or ScreenData.Codex.DefaultEntry
	-- CodexStatus.Enabled = true
end

function EnableCodex()
	CodexStatus.Enabled = true
	wait(0.25)
	CodexUnlockPresentation()
end

function CheckCodexUnlock( chapterName, entryName, args )
	if CodexData[chapterName] == nil or CodexData[chapterName].Entries[entryName] == nil then
		return
	end

	args = args or {}

	if CodexStatus[chapterName] == nil then
		CodexStatus[chapterName] = {}
	end
	if CodexStatus[chapterName][entryName] == nil then
		CodexStatus[chapterName][entryName] = {}
	end

	local showUpdate = false

	if CodexData[chapterName].Entries[entryName] ~= nil and CodexData[chapterName].Entries[entryName].Entries ~= nil then
		for entryIndex, entry in ipairs( CodexData[chapterName].Entries[entryName].Entries ) do
			
			if CodexStatus[chapterName][entryName][entryIndex] == nil then
				CodexStatus[chapterName][entryName][entryIndex] = {}
			end

			if CodexStatus[chapterName][entryName][entryIndex].Unlocked then
				-- Already unlocked
			elseif entry.UnlockGameStateRequirements ~= nil and IsGameStateEligible( CurrentRun, entry.UnlockGameStateRequirements ) then

				CodexStatus[chapterName][entryName][entryIndex].Unlocked = true
				DebugPrint({ Text = "CodexUnlock: "..chapterName.." - "..entryName.." - Entry "..entryIndex })

				-- Auto-select once Codex has been opened once
				if GameState.ScreensViewed.Codex then
					CodexStatus.SelectedChapterName = chapterName
					CodexStatus.SelectedEntryNames[chapterName] = entryName
				end

				-- New Status
				CodexStatus[chapterName].New = true
				CodexStatus[chapterName][entryName].New = true

				if CodexStatus.Enabled then
					if args.DeferShowUpdate or IsCombatEncounterActive( CurrentRun ) then
						MapState.PendingCodexUpdate = true
					else
						showUpdate = true
					end
				end
			end
		end
	end

	if showUpdate then
		thread( ShowCodexUpdate )
		thread( CheckQuestStatus )
	end

	GameState.CodexEntriesUnlockedCache = CalcNumCodexEntriesUnlocked()

end

function SelectCodexEntry( selectedEntryName )
	if not CodexStatus.Enabled then
		return
	end

	for chapterName, chapterData in pairs( CodexData ) do
		for entryName, entryData in pairs(chapterData.Entries) do
			if entryName == selectedEntryName then
				CodexStatus.SelectedChapterName = chapterName
				if CodexStatus.SelectedEntryNames == nil then
					CodexStatus.SelectedEntryNames = {}
				end
				CodexStatus.SelectedEntryNames[chapterName] = entryName
				return
			end
		end
	end
end

function HasNewEntries()
	for chapterName, chapterData in pairs( CodexData ) do
		for entryName in pairs( CodexData[chapterName].Entries ) do
			if chapterData.Entries[entryName].New then
				return true
			end
		end
	end
	return false
end

function HasUnlockedEntries( chapterName )
	if SessionState.CodexDebugUnlocked then
		return true
	end
	for entryName, entryData in pairs( CodexData[chapterName].Entries ) do
		local requirements = entryData.UnlockGameStateRequirements 
		if requirements == nil and not IsEmpty( entryData.Entries ) then
			requirements = entryData.Entries[1].UnlockGameStateRequirements
		end
		if requirements == nil or IsGameStateEligible( CurrentRun, entryData, requirements ) then
			return true
		end
	end
	return false
end

function SelectNearbyUnlockedEntry()

	-- Auto-select once Codex has been opened once
	if not GameState.ScreensViewed.Codex then
		return
	end

	local nearbyId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "NPCs", "ConsumableItems", "Loot", "EnemyTeam" }, Distance = 600 })
	local nearbyGenusName = nil
	if nearbyId ~= nil and ActiveEnemies[nearbyId] ~= nil then
		nearbyGenusName = ActiveEnemies[nearbyId].GenusName
	end

	local nearbyName = nearbyGenusName or GetName({ Id = nearbyId })
	if OnlyBoonScreenOpen() and CurrentLootData then
		nearbyName = CurrentLootData.Name
	end
	if nearbyName ~= nil then
		for chapterName, chapterData in pairs( CodexData ) do
			for entryName, entryData in pairs( chapterData.Entries ) do
				if entryName == nearbyName then
					for i, subEntryData in ipairs( entryData ) do
						if subEntryData.UnlockGameStateRequirements ~= nil and IsGameStateEligible( CurrentRun, subEntryData.UnlockGameStateRequirements ) then
							CodexStatus.SelectedChapterName = chapterName
							CodexStatus.SelectedEntryNames[chapterName] = nearbyName
							return
						end
					end
				end
			end
		end
	end
end

OnControlPressed{ "Codex",
	function( triggerArgs )
		if CanOpenCodex() then
			OpenCodexScreen()
		else
			if CodexStatus.Enabled and IsInputAllowed({}) then
				CannotOpenCodexPresentation()
			end
		end
	end
}

function OpenCodexScreen()
	if not CodexStatus.Enabled then
		return
	end
	if IsScreenOpen("Codex") then
		return
	end

	if not HasNewEntries() or ( OnlyBoonScreenOpen() and CurrentLootData ) then
		SelectNearbyUnlockedEntry()
	end

	local screen = DeepCopyTable( ScreenData.Codex )
	screen.ChapterX = screen.ChapterX + ScreenCenterNativeOffsetX
	screen.ChapterY = screen.ChapterY + ScreenCenterNativeOffsetY
	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	OnScreenOpened( screen, { SkipBlockTimer = true } )
	HideCombatUI( screen.Name )
	CreateScreenFromData( screen, screen.ComponentData )
	
	local components = screen.Components
	
	local selectedChapterName = CodexStatus.SelectedChapterName
	if components[selectedChapterName] == nil then
		selectedChapterName = screen.DefaultChapter
	end
	CodexOpenChapter( screen, components[selectedChapterName], { FirstOpen = true } )

	AddTimerBlock( CurrentRun, screen.Name )

	screen.KeepOpen = true
	screen.AllowInput = true
	wait( 0.1 )
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function CodexScreenCreateChapters( screen )

	local chapterSpacing = screen.ChapterSpacingX
	local chapterX = screen.ChapterX
	local chapterY = screen.ChapterY
	local components = screen.Components
	local numChapters = TableLength( CodexOrdering.Order )

	screen.UnlockedChapterNames = {}
	for index = 1, numChapters do
		local chapterName = CodexOrdering.Order[index]
		if HasUnlockedEntries( chapterName ) then
			--DebugPrint({ Text = "chapterName = "..chapterName })
			local chapterData = CodexData[chapterName]

			local tab = screen.Tabs[index]
			local offsetX = tab.X
			local offsetY = tab.Y
			local anim = tab.Animation

			local chapterButton = CreateScreenComponent({ Name = "BlankInteractableObstacle",
				X = chapterX + offsetX,
				Y = chapterY + offsetY,
				Animation = anim,
				Group = screen.ComponentData.DefaultGroup })
			chapterButton.ChapterName = chapterName
			chapterButton.ChapterData = chapterData
			chapterButton.TabData = tab
			chapterButton.ChapterXLocation = chapterX
			chapterButton.ChapterYLocation = chapterY
			chapterButton.OnPressedFunctionName = "CodexOpenChapter"
			chapterButton.OnMouseOverFunctionName = "MouseOverCodexChapter"
			chapterButton.OnMouseOffFunctionName = "MouseOffCodexChapter"
			chapterButton.Screen = screen
			components[chapterName] = chapterButton
			AttachLua({ Id = chapterButton.Id, Table = chapterButton })
			SetInteractProperty({ DestinationId = chapterButton.Id, Property = "FreeFormSelectable", Value = false })
			table.insert( screen.UnlockedChapterNames, chapterName )

			local activeOverlay = CreateScreenComponent({ Name = "BlankObstacle",
				X = chapterX + offsetX,
				Y = chapterY + offsetY,
				Animation = tab.Active,
				Alpha = 0.0,
				Group = screen.ComponentData.DefaultGroup })
			chapterButton.ActiveOverlayId = activeOverlay.Id
			screen.Components["CategoryActiveOverlay"..chapterName] = activeOverlay

			local categoryButtonIcon = CreateScreenComponent({ Name = "BlankObstacle", Scale = screen.CategoryIconScale,
				X = chapterX + screen.CategoryIconOffsetX + offsetX,
				Y = chapterY + screen.CategoryIconOffsetY + offsetY,
				Group = screen.ComponentData.DefaultGroup })
			chapterButton.IconId = categoryButtonIcon.Id
			chapterButton.IconShiftRequests = {}
			SetAnimation({ DestinationId = categoryButtonIcon.Id, Name = chapterData.Icon })
			screen.Components["CategoryIcon"..chapterName] = categoryButtonIcon

			chapterX = chapterX + chapterSpacing
		end
	end

	UpdateCodexContextualAction( screen )

end

function CodexPrevChapter( screen, button )
	if IsScreenOpen("BoonInfoScreen") or not screen.AllowInput then
		return
	end
	
	local prevChapterIndex = GetKey( screen.UnlockedChapterNames, CodexStatus.SelectedChapterName ) or 0
	if prevChapterIndex <= 1 then
		return
	end
	prevChapterIndex = prevChapterIndex - 1

	local prevChapterName = screen.UnlockedChapterNames[prevChapterIndex]
	local prevChapterButton = screen.Components[prevChapterName]
	CodexOpenChapter( screen, prevChapterButton, { FirstOpen = true } )

	UpdateCodexContextualAction( screen )
end

function CodexNextChapter( screen, button )
	if IsScreenOpen("BoonInfoScreen") or not screen.AllowInput then
		return
	end
	local nextChapterIndex = GetKey( screen.UnlockedChapterNames, CodexStatus.SelectedChapterName ) or 0
	if nextChapterIndex >= #screen.UnlockedChapterNames then
		return
	end
	nextChapterIndex = nextChapterIndex + 1

	local nextChapterName = screen.UnlockedChapterNames[nextChapterIndex]
	local nextChapterButton = screen.Components[nextChapterName]
	CodexOpenChapter( screen, nextChapterButton, { FirstOpen = true } )

	UpdateCodexContextualAction( screen )

end

function CodexOpenChapter( screen, button, args )
	
	args = args or {}
	local firstOpen = args.FirstOpen
	local selectLast = args.SelectLast

	if not IsScreenOpen( "Codex" ) then
		return
	end

	if button.ChapterName == CodexStatus.SelectedChapterName and not firstOpen then
		-- Already open
		return
	end

	CodexCloseChapter( screen, CodexStatus.SelectedChapterName, CodexData[CodexStatus.SelectedChapterName], args )
	CodexStatus.SelectedChapterName = button.ChapterName

	-- Highlight new category
	SetAlpha({ Id = button.ActiveOverlayId, Fraction = 1.0, Duration = 0.1 })
	SetAlpha({ Id = screen.Components.CategoryTitleText.Id, Fraction = 1.0, Duration = 0.1 })
	ModifyTextBox({ Id = screen.Components.CategoryTitleText.Id, Text = button.ChapterData.TitleText })
	local previousShift = not IsEmpty( button.IconShiftRequests )
	button.IconShiftRequests.Open = true
	if not previousShift then
		Move({ Id = button.IconId, Angle = 90, Distance = screen.TabIconMouseOverShiftDistance, Speed = screen.TabIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
	end

	CodexScreenOpenChapterPresentation( screen, button )

	local entryX = screen.ItemStartX
	local entryY = screen.ItemStartY	

	button.EntryButtonIds = {}
	
	local numEntries = TableLength( CodexOrdering[button.ChapterName] )

	screen.NumItems = 0
	screen.ActiveEntries = {}
	screen.ScrollOffset = 0

	local firstEntryName = nil

	for i = 1, numEntries do
		local entryName = CodexOrdering[button.ChapterName][i]
		local entryData = button.ChapterData.Entries[entryName]
		if entryData == nil then
			DebugAssert({ Condition = false, Text = "Missing entry for CodexData."..button.ChapterName.."["..entryName.."]", Owner = "Greg" })
			break
		end

		local text = nil
		local requirements = entryData.UnlockGameStateRequirements 
		if requirements == nil and not IsEmpty( entryData.Entries ) then
			requirements = entryData.Entries[1].UnlockGameStateRequirements
			if CodexData[button.ChapterName].ShowKillCount then
				DebugAssert({ Condition = (requirements == nil or requirements[1].SumOf ~= nil), Text = "Codex enemy entry for "..entryName.." is missing a SumOf requirement", Owner = "Caleb" })
			end
		end
		if requirements == nil or SessionState.CodexDebugUnlocked or IsGameStateEligible( CurrentRun, entryData, requirements ) then
			text = entryName
		end
		if text ~= nil then
			local entry = CreateScreenComponent({ Name = "ButtonCodexEntry", X = entryX, Y = entryY, Group = screen.ComponentData.DefaultGroup, Alpha = 0.0 })
			screen.Components[entryName] = entry
			entry.ChapterName = button.ChapterName
			entry.EntryName = entryName
			entry.EntryData = entryData
			entry.OnPressedFunctionName = "CodexOpenEntry"
			entry.OnMouseOverFunctionName = "MouseOverCodexEntry"
			entry.OnMouseOffFunctionName = "MouseOffCodexEntry"
			entry.EntryXLocation = entryX
			entry.EntryYLocation = entryY
			entry.Screen = screen
			AttachLua({ Id = entry.Id, Table = entry })
			table.insert( button.EntryButtonIds, screen.Components[entryName].Id )

			local entryTextFormat = ShallowCopyTable( screen.EntryTextFormat )

			firstEntryName = firstEntryName or entryName
			CodexStatus.SelectedEntryNames[button.ChapterName] = CodexStatus.SelectedEntryNames[button.ChapterName] or entryName

			if entryName == CodexStatus.SelectedEntryNames[button.ChapterName] then
				entryData.New = nil
				OverwriteTableKeys( entryTextFormat, screen.SelectedFormat )
			end

			if not GameState.CodexEntriesViewed[entryName] then
				--screen.Components[entryName].UnreadStarId = CreateScreenObstacle({ Name = "CodexUnreadStar", X = entryX + screen.UnreadStarOffsetX, Y = entryY, Group = screen.ComponentData.DefaultGroup })
				OverwriteTableKeys( entryTextFormat, screen.UnreadUnselectedFormat )
			end
			
			entryTextFormat.Id = screen.Components[entryName].Id
			entryTextFormat.Text = text
			CreateTextBox( entryTextFormat )

			screen.NumItems = screen.NumItems + 1
			screen.Components[entryName].EntryIndex = screen.NumItems
			table.insert( screen.ActiveEntries, entryName )
			entryY = entryY + screen.ItemSpacingY
		else
			if CodexStatus.SelectedEntryNames[button.ChapterName] == entryName then
				-- Entry was removed or locked
				CodexStatus.SelectedEntryNames[button.ChapterName] = nil
			end
		end

	end

	local selectedEntryName = CodexStatus.SelectedEntryNames[button.ChapterName] or firstEntryName
	if selectedEntryName ~= nil and screen.Components[selectedEntryName] ~= nil then
		local selectedFormat = screen.SelectedFormat
		selectedFormat.Id = screen.Components[selectedEntryName].Id
		ModifyTextBox( selectedFormat )
		CodexOpenEntry( screen, screen.Components[selectedEntryName], { AutoOpen = true } )
		while screen.Components[selectedEntryName].EntryIndex > ( screen.ScrollOffset + screen.MaxVisibleEntries ) do
			screen.ScrollOffset = screen.ScrollOffset + screen.MaxVisibleEntries
		end
		
	end

	CodexUpdateVisibility( screen )
	
	if selectedEntryName ~= nil then
		DebugPrint({ Text = "selectedEntryName = "..selectedEntryName })
		local entry = screen.Components[selectedEntryName]
		if entry ~= nil then
			wait( 0.02 )
			TeleportCursor({ OffsetX = entry.EntryXLocation, OffsetY = entry.EntryYLocation, ForceUseCheck = true })
		else
			TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
		end
	else
		TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	end

end


function CodexOpenEntry( screen, button, args )
	args = args or {}
	if not IsScreenOpen( "Codex" ) or IsScreenOpen("BoonInfoScreen") then
		return
	end

	if button.EntryName == screen.OpenEntryName and screen.Components.EntryText ~= nil then
		-- Already open
		return
	end
	screen.OpenEntryName = button.EntryName
	--DebugPrint({ Text = "Opening: "..button.EntryName })
	CodexCloseEntry( screen, CodexStatus.SelectedEntryNames[button.ChapterName] )
	CodexStatus.SelectedEntryNames[button.ChapterName] = button.EntryName

	GameState.CodexEntriesViewed[button.EntryName] = true
	Destroy({ Id = screen.Components[button.EntryName].UnreadStarId })
	screen.Components[button.EntryName].UnreadStarId = nil

	local selectedFormat = screen.SelectedFormat
	selectedFormat.Id = screen.Components[button.EntryName].Id
	ModifyTextBox( selectedFormat )

	CodexScreenOpenEntryPresentation( screen, button, args )

	CreateRelationshipBar( screen, button.EntryName )
	if CodexData[button.ChapterName].ShowKillCount then
		InitKillCountText( screen, button.EntryData )
	end

	SetAlpha({ Id = screen.Components.Image.Id, Fraction = 1 })
	SetAlpha({ Id = screen.Components.ImageShadow.Id, Fraction = 1.0 })

	if button.EntryData.Image ~= nil then
		SetAnimation({ DestinationId = screen.Components.Image.Id, Name = button.EntryData.Image })
		SetAnimation({ DestinationId = screen.Components.ImageShadow.Id, Name = button.EntryData.Image })
	end

	if button.EntryData.Entries ~= nil then
		local text = ""
		local complete = true
		local threshold = 0
		local uniqueThresholdText = nil
		for index, unlockPortion in ipairs( button.EntryData.Entries ) do
			local subEntryData = CodexData[button.ChapterName].Entries[button.EntryName].Entries[index]
			if SessionState.CodexDebugUnlocked or subEntryData.UnlockGameStateRequirements == nil or IsGameStateEligible( CurrentRun, subEntryData.UnlockGameStateRequirements ) then
				text = GetDisplayName({ Text = unlockPortion.HelpTextId or unlockPortion.Text }) .. " "
			else	
				complete = false
			end
		end

		local lang = GetLanguage({})
		if complete then
			if Contains(LocalizationData.CodexScripts.EntryCompleteSkipNewLines, lang) then
				text = text .. " " .. GetDisplayName({Text = "Codex_Complete"})
			else
				text = text .. " \\n " .. GetDisplayName({Text = "Codex_Complete"})
			end
		else
			text = text .. " \\n " .. GetDisplayName({Text = "Codex_Custom_Story_Requirement"})
		end
		if threshold <= 0 then
			threshold = 1
		end

		SetAlpha({ Id = screen.Components.EntryText.Id, Fraction = 1, Duration = 0.2 })
		ModifyTextBox({ Id = screen.Components.EntryText.Id, Text = text, LuaKey = "TempTextData", LuaValue = { Amount = threshold, Name = button.EntryName } })
		SetAlpha({ Id = screen.Components.EntryTitle.Id, Fraction = 1, Duration = 0.2 })
		ModifyTextBox({ Id = screen.Components.EntryTitle.Id, Text = button.EntryName })

	end

	if button.EntryData.EntryReadVoiceLines ~= nil then
		thread( PlayVoiceLines, button.EntryData.EntryReadVoiceLines )
	end
	
	UpdateCodexContextualAction( screen, button )

end

function CodexCloseChapter( screen, chapterName, chapterData, args )

	if chapterData == nil then
		return
	end
	args = args or {}

	CodexCloseEntry( screen )

	SetAlpha({ Id = screen.Components.CategoryTitleText.Id, Fraction = 0.0, Duration = 0.1 })
	for entryName, entryData in pairs( chapterData.Entries ) do
		if screen.Components[entryName] ~= nil then
			if screen.Components[entryName].UnreadStarId then
				SetAlpha({ Id = screen.Components[entryName].UnreadStarId, Fraction = 0.0, Duration = 0.1 })
			end
			SetAlpha({ Id = screen.Components[entryName].Id, Fraction = 0.0, Duration = 0.1 })
		end
	end
	wait( 0.1 )

	for entryName, entryData in pairs( chapterData.Entries ) do
		if screen.Components[entryName] ~= nil then
			if screen.Components[entryName].UnreadStarId then
				Destroy({ Id = screen.Components[entryName].UnreadStarId })
				screen.Components[entryName].UnreadStarId = nil
			end
			Destroy({ Id = screen.Components[entryName].Id })
			screen.Components[entryName] = nil
		end
	end
	if screen.Components.CodexSelectionUp then
		Destroy({ Id = screen.Components.CodexSelectionUp.Id })
		screen.Components.CodexSelectionUp = nil
	end
	if screen.Components.CodexSelectionDown then
		Destroy({ Id = screen.Components.CodexSelectionDown.Id })
		screen.Components.CodexSelectionDown = nil
	end
	local chapterButton = screen.Components[chapterName]
	if chapterButton ~= nil then
		SetAlpha({ Id = chapterButton.ActiveOverlayId, Fraction = 0.0, Duration = 0.1 })
		local previousShift = not IsEmpty( chapterButton.IconShiftRequests )
		chapterButton.IconShiftRequests.Open = nil
		if previousShift and IsEmpty( chapterButton.IconShiftRequests ) then
			Move({ Id = chapterButton.IconId, Angle = 270, Distance = screen.TabIconMouseOverShiftDistance, Speed = screen.TabIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
		end
	end

end

function CodexCloseEntry( screen, entryName )

	SetAlpha({ Id = screen.Components.EntryText.Id, Fraction = 0, Duration = 0.1 })
	SetAlpha({ Id = screen.Components.EntryTitle.Id, Fraction = 0, Duration = 0.1 })
	SetAlpha({ Id = screen.Components.RelationshipBarHint.Id, Fraction = 0, Duration = 0.1 })
	SetAlpha({ Id = screen.Components.EnemyStatsText.Id, Fraction = 0, Duration = 0.1 })
	SetAlpha({ Id = screen.Components.Image.Id, Fraction = 0.0, Duration = 0.1 })
	SetAlpha({ Id = screen.Components.ImageShadow.Id, Fraction = 0.0, Duration = 0.1 })

	if screen.Components.RelationshipBar ~= nil then
		Destroy({ Id = screen.Components.RelationshipBar.Id })
		screen.Components.RelationshipBar = nil
	end

	if screen.Components.RelationshipIcons ~= nil then
		Destroy({ Ids = screen.Components.RelationshipIcons })
		screen.Components.RelationshipIcons = nil
	end

	if entryName ~= nil and screen.Components[entryName] ~= nil then
		local unselectedFormat = screen.UnselectedFormat
		unselectedFormat.Id = screen.Components[entryName].Id
		ModifyTextBox( unselectedFormat )
	end

end

function CloseCodexScreen( screen, button )
	if not screen or not screen.AllowInput then
		return
	end
	
	screen.AllowInput = false
	screen.CloseTriggered = true

	local destroyIds = GetAllIds( screen.Components )
	if screen.Components.RelationshipIcons then
		for i, componentId in pairs(screen.Components.RelationshipIcons) do
			table.insert(destroyIds, componentId )
		end
	end
	for _, entry in pairs(screen.Components) do
		if entry.UnreadStarId then
			table.insert(destroyIds, entry.UnreadStarId )
		end
	end
	UseableOff({ Ids = destroyIds })
	OnScreenCloseStarted( screen )
	CloseScreen( destroyIds , 0.15 )

	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
	
	if ScreenAnchors.ChoiceScreen ~= nil then
		local screenIds = GetAllIds({ 
			ScreenAnchors.ChoiceScreen.Components.PurchaseButton1, 
			ScreenAnchors.ChoiceScreen.Components.PurchaseButton2, 
			ScreenAnchors.ChoiceScreen.Components.PurchaseButton3 })
		
		if screenIds[1] then
			TeleportCursor({ DestinationId = screenIds[1], ForceUseCheck = true })
		end
	end
end

function CreateRelationshipBar( screen, entryName )

	if NarrativeData[entryName] == nil then
		return false
	end
	if not GameState.WorldUpgradesAdded.WorldUpgradeRelationshipBar then
		return false
	end

	local giftEvents = NarrativeData[entryName].GiftTextLinePriorities
	if giftEvents == nil then
		return false
	end

	screen.Components.RelationshipIcons = {}

	local giftTrackArgs = { Name = entryName, }
	CreateGiftTrack( screen, giftTrackArgs )

	if giftTrackArgs.HintId == nil then
		return false
	end

	ModifyTextBox({
		Id = screen.Components.RelationshipBarHint.Id,
		Text = giftTrackArgs.HintId,
		LuaKey = "TempTextData",
		LuaValue = giftTrackArgs.HintValues or {},
	})
	wait( 0.03 ) -- Need to give 1 frame to render at new position
	SetAlpha({ Id = screen.Components.RelationshipBarHint.Id, Fraction = 1, Duration = 0.2 })

	return true
end

function CreateGiftTrack( screen, args )

	local entryName = args.Name
	local giftTrackIds = {}
	local group = args.GroupName or screen.ComponentData.DefaultGroup

	local giftEvents = NarrativeData[entryName].GiftTextLinePriorities

	local locationX = screen.GiftTrackX + ScreenCenterNativeOffsetX
	local locationY = screen.GiftTrackY + ScreenCenterNativeOffsetY
	local iconCount = 0
	local row = 1
	
	for i, eventName in ipairs( giftEvents ) do
		local giftSource = EnemyData[entryName] or LootData[entryName] or ConsumableData[entryName]
		local giftEventData = giftSource.GiftTextLineSets[eventName]
		local onGiftTrack = giftEventData.OnGiftTrack
		if giftEventData.AltGiftTrackEvent ~= nil and GameState.TextLinesRecord[giftEventData.AltGiftTrackEvent] then
			--DebugPrint({ Text = "giftEventData.AltGiftTrackEvent = "..giftEventData.AltGiftTrackEvent })
			giftEventData = giftSource.GiftTextLineSets[giftEventData.AltGiftTrackEvent]
		end
		if onGiftTrack then
			local resourceData = nil
			for resourceName, resourceAmount in pairs( giftEventData.Cost ) do
				resourceData = ResourceData[resourceName]
			end
			iconCount = iconCount + 1

			local newIconId = CreateScreenComponent({ Name = "BlankObstacle", Group = group, X = locationX, Y = locationY, Angle = screen.GiftTrackAngle }).Id
			table.insert( screen.Components.RelationshipIcons, newIconId )

			if GameState.TextLinesRecord[giftEventData.Name] then
				local iconName = giftEventData.FilledIcon or "FilledHeartIcon"
				SetAnimation({ Name = iconName, DestinationId = newIconId })
			elseif giftEventData.GameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, giftEventData, giftEventData.GameStateRequirements ) then
				local iconName = "LockedHeartIcon"
				SetAnimation({ Name = iconName, DestinationId = newIconId })
				if args.HintId == nil and giftEventData.LockedHintId ~= nil then
					args.HintId = giftEventData.LockedHintId
					DebugPrint({ Text = "Locked args.HintId = "..args.HintId..", eventName = "..eventName })
					args.HintValues = { CharacterName = entryName, ResourceName = resourceData.Name, ResourceIcon = resourceData.IconPath }
					Flash({ Id = newIconId, Speed = 0.5, MinFraction = 0.1, MaxFraction = 0.2, Color = Color.White })
				end	
			else
				local iconName = giftEventData.UnfilledIcon or "EmptyHeartIcon"
				SetAnimation({ Name = iconName, DestinationId = newIconId })
				if args.HintId == nil then
					args.HintId = giftEventData.HintId or "Codex_DefaultGiftHint"
					DebugPrint({ Text = "Unlocked args.HintId = "..args.HintId..", eventName = "..eventName })
					args.HintValues = { CharacterName = entryName, ResourceName = resourceData.Name, ResourceIcon = resourceData.IconPath }
					Flash({ Id = newIconId, Speed = 0.5, MinFraction = 0.1, MaxFraction = 0.2, Color = Color.White })
				end
			end

			if iconCount % screen.GiftTrackIconsPerRow == 0 then
				locationX = screen.GiftTrackX + ScreenCenterNativeOffsetX
				locationY = screen.GiftTrackY + ScreenCenterNativeOffsetY
				local offset = CalcOffset( math.rad( screen.GiftTrackAngle - 90 ), screen.GiftTrackSpacingY )
				locationX = locationX + (offset.X * row)
				locationY = locationY + (offset.Y * row)
				row = row + 1
			else
				local offset = CalcOffset( math.rad( screen.GiftTrackAngle ), screen.GiftTrackSpacingX )
				locationX = locationX + offset.X
				locationY = locationY + offset.Y
			end

		end
	end
end

function InitKillCountText( screen, entryData )
	local killCount = 0
	local enemyVariants = entryData.Entries[1].UnlockGameStateRequirements[1].SumOf
	for i, enemyName in ipairs( enemyVariants ) do
		killCount = killCount + (GameState.EnemyKills[enemyName] or 0)
	end

	local enemyData = { KillCount = killCount }
	ModifyTextBox({
		Id = screen.Components.EnemyStatsText.Id,
		Text = "Codex_EnemyStats",
		LuaKey = "TempTextData",
		LuaValue = enemyData,
	})
	SetAlpha({ Id = screen.Components.EnemyStatsText.Id, Fraction = 1, Duration = 0.2 })
end

function CanOpenCodex()
	if not CodexStatus.Enabled or MapState.InOverlook then
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
	return ( not AreScreensActive() or OnlyBoonScreenOpen()) and IsInputAllowed({})
end

function OnlyBoonScreenOpen()
	local openScreens = TableLength(ActiveScreens)

	return  (openScreens == 1 and AreScreensActive("BoonMenu")) or ( openScreens == 2 and AreScreensActive("BoonMenu") and AreScreensActive("Codex"))
end

function CalcNumCodexEntriesUnlocked()
	local unlockCount = 0
	for chapterName, chapterData in pairs( CodexData ) do
		for entryName, entryData in pairs( CodexData[chapterName].Entries ) do
			if CodexStatus[chapterName] ~= nil and CodexStatus[chapterName][entryName] ~= nil and CodexStatus[chapterName][entryName][1] ~= nil and CodexStatus[chapterName][entryName][1].Unlocked then
				unlockCount = unlockCount + 1
			end
		end
	end
	return unlockCount
end

function AttemptOpenCodexBoonInfo( codexScreen, button )

	if codexScreen == nil or codexScreen.Components.CloseButton == nil or codexScreen.CloseTriggered then
		-- Codex screen isn't done opening or in the process of closing
		return
	end

	local currentEntryName = CodexStatus.SelectedEntryNames[CodexStatus.SelectedChapterName]
	local entryData = CodexData[CodexStatus.SelectedChapterName].Entries[currentEntryName]
	ShowBoonInfoScreen( entryData.BoonInfoEnemyName or entryData.BoonInfoLootName or currentEntryName, codexScreen, currentEntryName, entryData )

end

function HasCodexEntryBeenFound( requiredEntryName, requiredEntryIndex )
	local codexEntryFound = false
	for chapterName, chapterData in pairs( CodexData ) do
		for entryName in pairs( CodexData[chapterName].Entries ) do
			if entryName == requiredEntryName then
				if CodexStatus[chapterName] == nil or CodexStatus[chapterName][entryName] == nil or CodexStatus[chapterName][entryName][requiredEntryIndex] == nil or not CodexStatus[chapterName][entryName][requiredEntryIndex].Unlocked or CodexStatus[chapterName][entryName].New then
					return false
				else
					local allUnlocked = true
					for i = 1, requiredEntryIndex do
						if not CodexStatus[chapterName][entryName][i] or not CodexStatus[chapterName][entryName][i].Unlocked then
							allUnlocked = false
							break
						end
					end
					if allUnlocked then
						codexEntryFound = true
					end
				end
			end
		end
	end
	if not codexEntryFound then
		return false
	end
	return true
end

function CodexScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.MaxVisibleEntries
	CodexUpdateVisibility( screen )
	thread( CodexUpdateCursorUp, screen, button )
end

function CodexUpdateCursorUp( screen, button )
	-- @hack Need to wait for screen to re-allow input again
	wait(0.04)
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((screen.MaxVisibleEntries - 1) * screen.ItemSpacingY), ForceUseCheck = true })
end

function CodexScrollDown( screen, button )
	if screen.ScrollOffset + screen.MaxVisibleEntries >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.MaxVisibleEntries
	CodexUpdateVisibility( screen )
	thread( CodexUpdateCursorDown, screen, button )	
end

function CodexUpdateCursorDown( screen, button )
	-- @hack Need to wait for screen to re-allow input again
	wait(0.04)
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
end

function CodexUpdateVisibility( screen, args )

	args = args or {}
	local components = screen.Components
	local offIds = {}
	local onIds = {}

	for index, entryName in ipairs( screen.ActiveEntries ) do

		local visibleIndex = index - screen.ScrollOffset
		local questButtonKey = entryName
		local item = components[entryName]

		if visibleIndex >= 1 and visibleIndex <= screen.MaxVisibleEntries then
			-- Page in view
			
			if item ~= nil then
				item.EntryXLocation = screen.ItemStartX
				item.EntryYLocation = screen.ItemStartY + ((visibleIndex - 1) * screen.ItemSpacingY)
				Teleport({ Id = item.Id, OffsetX = item.EntryXLocation, OffsetY = item.EntryYLocation })
				table.insert( onIds, item.Id )
				--DebugPrint({ Text = "entryName = "..entryName })
				if item.UnreadStarId ~= nil then
					--Teleport({ Id = item.UnreadStarId, OffsetX = screen.ItemStartX + screen.UnreadStarOffsetX, OffsetY = screen.ItemStartY + ((visibleIndex - 1) * screen.ItemSpacingY) })
					table.insert( onIds, item.UnreadStarId )
				end
			end

		else
			-- Page out of view
			if item ~= nil then
				table.insert( offIds, item.Id )
				if item.UnreadStarId ~= nil then
					table.insert( offIds, item.UnreadStarId )
					DebugPrint({ Text = "OFF: entryName = "..entryName })
				end
				
			end
		end

	end

	SetAlpha({ Ids = onIds, Fraction = 1, Duration = 0.1 })
	UseableOn({ Ids = onIds })

	SetAlpha({ Ids = offIds, Fraction = 0, Duration = 0.1 })
	UseableOff({ Ids = offIds, ForceHighlightOff = true })

	if not args.IgnoreArrows then
		if screen.ScrollOffset <= 0 then
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
		else
			SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollUp.Id })
		end

		if screen.ScrollOffset + screen.MaxVisibleEntries >= screen.NumItems then
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
			UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
		else
			SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1, Duration = 0.1 })
			UseableOn({ Id = components.ScrollDown.Id })
		end
	end

end


function UpdateCodexContextualAction( screen, button )

	local components = screen.Components
	if button ~= nil and components.BoonInfoButton ~= nil then
		if ScreenData.BoonInfo.TraitDictionary[button.EntryName] ~= nil or button.EntryData.BoonInfoEnemyName ~= nil or button.EntryData.BoonInfoLootName ~= nil then
			SetAlpha({ Id = components.BoonInfoButton.Id, Fraction = 1.0, Duration = 0.3 })
			components.BoonInfoButton.Disabled = false
		else
			SetAlpha({ Id = components.BoonInfoButton.Id, Fraction = 0.0, Duration = 0.0 })
			components.BoonInfoButton.Disabled = true
		end
	end

end