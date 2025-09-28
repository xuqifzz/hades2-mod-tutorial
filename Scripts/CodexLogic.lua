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
			elseif entry.UnlockGameStateRequirements ~= nil and IsGameStateEligible( entry, entry.UnlockGameStateRequirements ) then

				CodexStatus[chapterName][entryName][entryIndex].Unlocked = true
				--DebugPrint({ Text = "CodexUnlock: "..chapterName.." - "..entryName.." - Entry "..entryIndex })

				-- Auto-select once Codex has been opened once
				if GameState.ScreensViewed.Codex and not IsScreenOpen( "Codex" ) then
					CodexStatus.SelectedChapterName = chapterName
					CodexStatus.SelectedEntryNames[chapterName] = entryName
				end

				-- New Status
				CodexStatus[chapterName].New = true
				CodexStatus[chapterName][entryName].New = true

				if CodexStatus.Enabled and not SessionState.InFlashback and not SessionMapState.BlockCodexUnlockPresentation then
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

	if not args.SkipEntriesUnlockedCacheUpdate then
		GameState.CodexEntriesUnlockedCache = CalcNumCodexEntriesUnlocked()
	end

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
		if requirements == nil or IsGameStateEligible( entryData, requirements ) then
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
	if nearbyId ~= nil then
		if ActiveEnemies[nearbyId] ~= nil then
			nearbyGenusName = ActiveEnemies[nearbyId].GenusName
		elseif MapState.ActiveObstacles[nearbyId] ~= nil then
			nearbyGenusName = MapState.ActiveObstacles[nearbyId].GenusName
		end
	end

	local nearbyName = nearbyGenusName or GetName({ Id = nearbyId })
	if nearbyName == "WeaponUpgrade" then
		for weaponName, weaponData in pairs( CurrentRun.Hero.Weapons ) do
			if CodexData.Weapons.Entries[weaponName] then
				nearbyName = weaponName
				break
			end
		end
	end
	if OnlyBoonScreenOpen() and CurrentLootData then
		nearbyName = CurrentLootData.Name
	end
	if nearbyName ~= nil then
		for chapterName, chapterData in pairs( CodexData ) do
			for entryName, entryData in pairs( chapterData.Entries ) do
				if entryName == nearbyName then
					for i, subEntryData in ipairs( entryData.Entries ) do
						if subEntryData.UnlockGameStateRequirements ~= nil and IsGameStateEligible( subEntryData, subEntryData.UnlockGameStateRequirements ) then
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

	AddInputBlock({ Name = "OpenCodexScreen" })
	SetPlayerInvulnerable( "Codex" )
	AddPlayerImmuneToForce( "Codex" )
	CurrentRun.Hero.UntargetableFlags.Codex = true

	SessionMapState.BlockInfoBanners = true
	if SetThreadWait( "InfoBanner", 0.01 ) then
		wait( 0.2 )
	end

	if not HasNewEntries() or ( OnlyBoonScreenOpen() and CurrentLootData ) then
		SelectNearbyUnlockedEntry()
	end

	local screen = DeepCopyTable( ScreenData.Codex )
	screen.ChapterX = screen.ChapterX + ScreenCenterNativeOffsetX
	screen.ChapterY = screen.ChapterY + ScreenCenterNativeOffsetY
	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	OnScreenOpened( screen )
	HideCombatUI( screen.Name )
	CreateScreenFromData( screen, screen.ComponentData )

	CodexScreenOpenedPresentation( screen )
	
	local components = screen.Components
	local selectedChapterName = CodexStatus.SelectedChapterName
	if components[selectedChapterName] == nil then
		selectedChapterName = screen.DefaultChapter
	end
	CodexOpenChapter( screen, components[selectedChapterName], { FirstOpen = true } )

	screen.KeepOpen = true
	screen.AllowInput = true
	wait( 0.1 )
	RemoveInputBlock({ Name = "OpenCodexScreen" })

	HandleScreenInput( screen )

end

function CodexScreenCreateChapters( screen )

	local chapterX = screen.ChapterX
	local chapterY = screen.ChapterY
	local components = screen.Components
	local numChapters = TableLength( CodexOrdering.Order )

	screen.UnlockedChapterNames = {}
	for index = 1, numChapters do
		local chapterName = CodexOrdering.Order[index]
		if HasUnlockedEntries( chapterName ) then

			local chapterData = CodexData[chapterName]

			local tab = screen.Tabs[index]
			local offsetX = tab.X
			local offsetY = tab.Y

			local chapterButton = CreateScreenComponent({ Name = "BlankInteractableObstacle",
				X = chapterX + offsetX,
				Y = chapterY + offsetY,
				Animation = tab.Animation,
				Alpha = 0.0,
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
				Alpha = 0.0,
				Group = screen.ComponentData.DefaultGroup })
			chapterButton.IconId = categoryButtonIcon.Id
			chapterButton.IconShiftRequests = {}
			SetAnimation({ DestinationId = categoryButtonIcon.Id, Name = chapterData.Icon })
			screen.Components["CategoryIcon"..chapterName] = categoryButtonIcon

			chapterX = chapterX + screen.ChapterSpacingX
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
	SetAlpha({ Id = button.ActiveOverlayId, Fraction = 1.0, Duration = 0.1, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Id = screen.Components.CategoryTitleText.Id, Fraction = 1.0, Duration = 0.1, EaseIn = 0, EaseOut = 1 })
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
		if requirements == nil or SessionState.CodexDebugUnlocked or IsGameStateEligible( entryData, requirements ) then
			text = entryName
		end
		if text ~= nil then
			local entry = CreateScreenComponent({ Name = "ButtonCodexEntry", X = entryX, Y = entryY, Group = screen.ComponentData.DefaultGroup, Alpha = 0.0 })
			screen.Components[entryName] = entry
			entry.ChapterName = button.ChapterName
			entry.EntryName = entryName
			entry.EntryData = entryData
			entry.OnMouseOverFunctionName = "MouseOverCodexEntry"
			entry.OnMouseOffFunctionName = "MouseOffCodexEntry"
			entry.EntryXLocation = entryX
			entry.EntryYLocation = entryY
			entry.Screen = screen
			AttachLua({ Id = entry.Id, Table = entry })
			table.insert( button.EntryButtonIds, entry.Id )

			local entryTextFormat = ApplyLocalizedProperties( ShallowCopyTable( screen.EntryTextFormat ) )

			firstEntryName = firstEntryName or entryName
			CodexStatus.SelectedEntryNames[button.ChapterName] = CodexStatus.SelectedEntryNames[button.ChapterName] or entryName

			if entryName == CodexStatus.SelectedEntryNames[button.ChapterName] then
				entryData.New = nil
				OverwriteTableKeys( entryTextFormat, screen.SelectedFormat )
			end

			if not GameState.CodexEntriesViewed[entryName] then
				OverwriteTableKeys( entryTextFormat, screen.UnreadUnselectedFormat )
			end

			if entryData.AltImage ~= nil and IsGameStateEligible( entryData, entryData.AltImageRequirements ) then
				entry.Portrait = entryData.AltImage
			else
				entry.Portrait = entryData.Image
			end
			
			entryTextFormat.Id = entry.Id
			entryTextFormat.Text = text
			CreateTextBox( entryTextFormat )

			screen.NumItems = screen.NumItems + 1
			entry.EntryIndex = screen.NumItems
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
	if selectedEntryName ~= nil and screen.Components[selectedEntryName] == nil then
		selectedEntryName = firstEntryName
	end

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
		--DebugPrint({ Text = "selectedEntryName = "..selectedEntryName })
		local entry = screen.Components[selectedEntryName]
		if entry ~= nil then
			TeleportCursor({ OffsetX = entry.EntryXLocation, OffsetY = entry.EntryYLocation, ForceUseCheck = true })
			Teleport({ Id = screen.Components.CategoryEntryBacking.Id, OffsetX = entry.EntryXLocation, OffsetY = entry.EntryYLocation })
		else
			TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
		end
		SetAlpha({ Id = screen.Components.CategoryEntryBacking.Id, Fraction = 1, Duration = 0.1 })
	else
		TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	end

end


function CodexOpenEntry( screen, button, args )
	args = args or {}
	if not IsScreenOpen( "Codex" ) or IsScreenOpen("BoonInfoScreen") then
		return
	end

	if not args.LanguageChanged then
		if button.EntryName == screen.OpenEntryName and screen.Components.EntryText ~= nil then
			-- Already open
			return
		end
	end
	screen.OpenEntryName = button.EntryName
	--DebugPrint({ Text = "Opening: "..button.EntryName })
	CodexCloseEntry( screen, CodexStatus.SelectedEntryNames[button.ChapterName] )
	CodexStatus.SelectedEntryNames[button.ChapterName] = button.EntryName

	GameState.CodexEntriesViewed[button.EntryName] = true
	Destroy({ Id = screen.Components[button.EntryName].UnreadStarId })
	screen.Components[button.EntryName].UnreadStarId = nil

	SetAnimation({ DestinationId = screen.Components.CategoryEntryBacking.Id, Name = "CodexBackingEntry" })

	local selectedFormat = screen.SelectedFormat
	selectedFormat.Id = screen.Components[button.EntryName].Id
	ModifyTextBox( selectedFormat )

	CreateRelationshipBar( screen, button.EntryName )
	if CodexData[button.ChapterName].ShowKillCount then
		InitKillCountText( screen, button.EntryData )
	end

	if not args.LanguageChanged then
		CodexScreenSwapPortraitPresentation( screen, button )
	end

	if button.EntryData.Entries ~= nil then
		local text = ""
		local complete = true
		local threshold = 0
		local uniqueThresholdText = nil
		for index, unlockPortion in ipairs( button.EntryData.Entries ) do
			local subEntryData = CodexData[button.ChapterName].Entries[button.EntryName].Entries[index]
			if SessionState.CodexDebugUnlocked or subEntryData.UnlockGameStateRequirements == nil or IsGameStateEligible( screen, subEntryData.UnlockGameStateRequirements ) then
				text = GetDisplayName({ Text = unlockPortion.HelpTextId or unlockPortion.Text }) .. " "
			else	
				complete = false
			end
		end

		local lang = GetLanguage({})
		if complete then
			if Contains(ScreenData.Codex.EntryCompleteSkipNewLines, lang) then
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

		SetAlpha({ Id = screen.Components.EntryText.Id, Fraction = 1, Duration = 0.12, EaseIn = 0, EaseOut = 1 })
		ModifyTextBox({ Id = screen.Components.EntryText.Id, Text = text, LuaKey = "TempTextData", LuaValue = { Amount = threshold, Name = button.EntryName } })
		SetAlpha({ Id = screen.Components.EntryTitle.Id, Fraction = 1, Duration = 0.12, EaseIn = 0, EaseOut = 1 })
		ModifyTextBox({ Id = screen.Components.EntryTitle.Id, Text = button.EntryName })

	end

	if button.EntryData.EntryReadVoiceLines ~= nil then
		thread( PlayVoiceLines, button.EntryData.EntryReadVoiceLines )
	end

	SetAlpha({ Id = screen.Components.CategoryEntryBacking.Id, Fraction = 1, Duration = 0.1 })
	Teleport({ Id = screen.Components.CategoryEntryBacking.Id, DestinationId = button.Id })

	UpdateCodexContextualAction( screen, button )

end

function CodexCloseChapter( screen, chapterName, chapterData, args )

	if chapterData == nil then
		return
	end
	args = args or {}

	CodexCloseEntry( screen )
	SetAlpha({ Id = screen.Components.CategoryEntryBacking.Id, Fraction = 0.0, Duration = 0.06 })
	SetAlpha({ Id = screen.Components.CategoryTitleText.Id, Fraction = 0.0, Duration = 0.06, EaseIn = 0, EaseOut = 1 })
	for entryName, entryData in pairs( chapterData.Entries ) do
		if screen.Components[entryName] ~= nil then
			if screen.Components[entryName].UnreadStarId then
				SetAlpha({ Id = screen.Components[entryName].UnreadStarId, Fraction = 0.0, Duration = 0.06, EaseIn = 0, EaseOut = 1 })
			end
			SetAlpha({ Id = screen.Components[entryName].Id, Fraction = 0.0, Duration = 0.06, EaseIn = 0, EaseOut = 1 })
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
		SetAlpha({ Id = chapterButton.ActiveOverlayId, Fraction = 0.0, Duration = 0.06, EaseIn = 0, EaseOut = 1 })
		local previousShift = not IsEmpty( chapterButton.IconShiftRequests )
		chapterButton.IconShiftRequests.Open = nil
		if previousShift and IsEmpty( chapterButton.IconShiftRequests ) then
			Move({ Id = chapterButton.IconId, Angle = 270, Distance = screen.TabIconMouseOverShiftDistance, Speed = screen.TabIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
		end
	end

end

function CodexCloseEntry( screen, entryName )

	SetAlpha({ Id = screen.Components.EntryText.Id, Fraction = 0, Duration = 0.06, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Id = screen.Components.EntryTitle.Id, Fraction = 0, Duration = 0.06, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Id = screen.Components.RelationshipBarHint.Id, Fraction = 0, Duration = 0.06, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Id = screen.Components.EnemyStatsText.Id, Fraction = 0, Duration = 0.06, EaseIn = 0, EaseOut = 1 })

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

	SetPlayerVulnerable( "Codex" )
	RemovePlayerImmuneToForce( "Codex" )
	CurrentRun.Hero.UntargetableFlags.Codex = nil
	
	screen.AllowInput = false
	screen.CloseTriggered = true

	SessionMapState.BlockInfoBanners = false

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
	CodexScreenClosedPresentation( screen, button )
	CloseScreen( destroyIds, nil, screen )
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )

end

function CreateRelationshipBar( screen, entryName )

	local narrativeData = NarrativeData[entryName]
	if narrativeData == nil then
		return false
	end

	if not GameState.WorldUpgradesAdded.WorldUpgradeRelationshipBar then
		return false
	end

	if narrativeData.HideRelationshipBar or narrativeData.GiftTextLinePriorities == nil then
		return false
	end

	screen.Components.RelationshipIcons = {}

	local giftTrackArgs = { EntryName = narrativeData.GiftTrackEntryName or entryName, CharacterName = entryName }

	local specialGiftTrackEligible = false
	if narrativeData.SpecialGiftTrackHintRequirements ~= nil then
		if IsGameStateEligible( narrativeData, narrativeData.SpecialGiftTrackHintRequirements ) then
			specialGiftTrackEligible = true
			giftTrackArgs.FullHeartTrack = narrativeData.SpecialGiftTrackFullHearts
		else
			giftTrackArgs.SpecialGiftTrackLockedHintId = narrativeData.SpecialGiftTrackLockedHintId
		end
	end
	if narrativeData.SpecialKeepsakeEventRequirements ~= nil and IsGameStateEligible( narrativeData, narrativeData.SpecialKeepsakeEventRequirements ) then
		giftTrackArgs.HasSpecialKeepsakeEvent = true
	end

	CreateGiftTrack( screen, giftTrackArgs )

	if specialGiftTrackEligible then
		giftTrackArgs.HintId = narrativeData.SpecialGiftTrackHintId
	end

	if giftTrackArgs.HintId == nil then
		return false
	end

	ModifyTextBox({
		Id = screen.Components.RelationshipBarHint.Id,
		Text = giftTrackArgs.HintId,
		LuaKey = "TempTextData",
		LuaValue = giftTrackArgs.HintValues or { CharacterName = entryName },
	})
	SetAlpha({ Id = screen.Components.RelationshipBarHint.Id, Fraction = 1, Duration = 0.2 })

	return true
end

function CreateGiftTrack( screen, args )

	local entryName = args.EntryName
	local characterName = args.CharacterName
	local giftTrackIds = {}
	local group = args.GroupName or screen.ComponentData.DefaultGroup
	local questLogUnlocked = IsGameStateEligible( nil, { NamedRequirements = { "QuestLogUnlocked" } } )

	local giftEvents = NarrativeData[entryName].GiftTextLinePriorities

	local locationX = screen.GiftTrackX + ScreenCenterNativeOffsetX
	local locationY = screen.GiftTrackY + ScreenCenterNativeOffsetY

	local npcTarget = ActiveEnemies[GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = entryName })]
	if npcTarget == nil and EnemyData[entryName] ~= nil and EnemyData[entryName].GiftTrackNPCVariant ~= nil then
		npcTarget = ActiveEnemies[GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = EnemyData[entryName].GiftTrackNPCVariant })]
	end

	local giftSource = npcTarget or EnemyData[entryName] or LootData[entryName] or ConsumableData[entryName]

	local completedEvents = {}
	local availableEvents = {} -- Only next single event for each resource type
	local lockedEvents = {}

	for i, eventName in ipairs( giftEvents ) do
		
		local giftEventData = giftSource.GiftTextLineSets[eventName]
		if giftEventData.OnGiftTrack then
			local requirementsArgs = {}
			if GameState.TextLinesRecord[giftEventData.Name] then
				table.insert( completedEvents, giftEventData )
			elseif giftEventData.GameStateRequirements ~= nil and not IsGameStateEligible( giftSource, giftEventData.GameStateRequirements, requirementsArgs ) then
				table.insert( lockedEvents, { GiftEventData = giftEventData, RequirementsArgs = requirementsArgs } )
			elseif giftEventData.AlwaysLocked then
				table.insert( lockedEvents, { GiftEventData = giftEventData, RequirementsArgs = requirementsArgs } )
			else
				local resourceData = nil
				for resourceName, resourceAmount in pairs( giftEventData.Cost ) do
					resourceData = ResourceData[resourceName]
				end
				if availableEvents[resourceData.Name] == nil then
					availableEvents[resourceData.Name] = giftEventData
				else
					-- Not really locked, but has another event of the same resource type ahead of it
					table.insert( lockedEvents, { GiftEventData = giftEventData, RequirementsArgs = requirementsArgs } )
				end
			end
		end
	end

	local completedEventsInOrder = {}
	if GameState.GiftTextLinesOrderRecord[entryName] ~= nil then
		for i, conversationName in ipairs( GameState.GiftTextLinesOrderRecord[entryName] ) do
			local giftEventData = RemoveEventWithName( completedEvents, conversationName )
			if giftEventData ~= nil then
				table.insert( completedEventsInOrder, giftEventData )
			end
		end
	end
	-- Add anything missed remaining (likely from back-compat)
	for i, giftEventData in ipairs( completedEvents ) do
		table.insert( completedEventsInOrder, giftEventData )
	end

	-- Hackery for Zagreus's unique setup
	if args.HasSpecialKeepsakeEvent ~= nil then
		table.insert( completedEventsInOrder, { FilledIcon = "FilledHeartWithGiftIcon" } )
	end
	if args.FullHeartTrack then
		local dummyEvent = {}
		for i=1,16 do
			table.insert( completedEventsInOrder, dummyEvent )
		end
	end
	if args.SpecialGiftTrackLockedHintId ~= nil then
		table.insert( lockedEvents,
		{
			GiftEventData =
			{
				Name = "DummyLockedEvent",
				LockedHintId = args.SpecialGiftTrackLockedHintId,
				Cost =
				{
					GiftPoints = 1,
				},
			},
			RequirementsArgs = {},
		} )
	end

	for i, giftEventData in ipairs( completedEventsInOrder ) do
		if giftEventData.StartBecomingCloserTrack then
			local arrowIconName = "HeartDividerIcon"
			local arrowIconId = CreateScreenComponent({ Name = "BlankObstacle", Group = group, X = locationX, Y = locationY, Animation = arrowIconName, Alpha = 0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 }).Id
			table.insert( screen.Components.RelationshipIcons, arrowIconId )
			locationX = locationX + screen.GiftTrackSpacingX
		end

		local iconName = giftEventData.FilledIcon or "FilledHeartIcon"
		if iconName == "FilledHeartWithProphecyIcon" and not questLogUnlocked then
			iconName = "FilledHeartIcon"
		end
		local newIconId = CreateScreenComponent({ Name = "BlankObstacle", Group = group, X = locationX, Y = locationY, Animation = iconName, Alpha = 0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 }).Id
		table.insert( screen.Components.RelationshipIcons, newIconId )
		locationX = locationX + screen.GiftTrackSpacingX

		if giftEventData.CompletedHintId ~= nil then
			args.HintId = giftEventData.CompletedHintId
			args.HintValues = { CharacterName = characterName }
		end
	end

	if args.HintId == nil then
		if CurrentRun.RelationshipsAdvanced[entryName] then
			args.HintId = "Codex_TrustDeepened01"
			args.HintValues = { CharacterName = characterName }
		elseif not IsEmpty( CurrentRun.GiftRecord[entryName] ) and giftSource.UnlimitedGifts == nil then
			args.HintId = "Codex_AlreadyReceivedGift"
			args.HintValues = { CharacterName = characterName }
		elseif npcTarget ~= nil then
			local giftable = true
			if npcTarget.NextInteractLines ~= nil and npcTarget.NextInteractLines.InitialGiftableOffSource ~= nil then
				giftable = false
			end
			if npcTarget.InteractTextLineSets ~= nil then
				for k, textLineSet in pairs( npcTarget.InteractTextLineSets ) do
					if CurrentRun.TextLinesRecord[textLineSet.Name] and textLineSet.GiftableOffSource then
						giftable = false
						break
					end
				end
			end
			if not giftable then
				args.HintId = "Codex_DoesntWantGiftHint"
				args.HintValues = { CharacterName = characterName }
			end
		end
	end

	local availableEventResourceOrder = { "GiftPoints", "SuperGiftPoints", "GiftPointsEpic", "GiftPointsRare", "IcarusPoints" }
	for i, resourceName in ipairs( availableEventResourceOrder ) do
		local giftEventData = availableEvents[resourceName]
		if giftEventData ~= nil then
			if giftEventData.StartBecomingCloserTrack then
				local arrowIconName = "HeartDividerIcon"
				local arrowIconId = CreateScreenComponent({ Name = "BlankObstacle", Group = group, X = locationX, Y = locationY, Animation = arrowIconName, Alpha = 0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 }).Id
				table.insert( screen.Components.RelationshipIcons, arrowIconId )
				locationX = locationX + screen.GiftTrackSpacingX
			end

			local iconName = giftEventData.UnfilledIcon or "EmptyHeartIcon"
			if iconName == "EmptyHeartWithProphecyIcon" and not questLogUnlocked then
				iconName = "EmptyHeartIcon"
			end
			local newIconId = CreateScreenComponent({ Name = "BlankObstacle", Group = group, X = locationX, Y = locationY, Animation = iconName, Alpha = 0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 }).Id
			table.insert( screen.Components.RelationshipIcons, newIconId )
			locationX = locationX + screen.GiftTrackSpacingX

			local resourceData = nil
			for resourceName, resourceAmount in pairs( giftEventData.Cost ) do
				resourceData = ResourceData[resourceName]
			end

			if args.HintId == nil then
				args.HintId = giftEventData.HintId or "Codex_DefaultGiftHint"
				DebugPrint({ Text = "Unlocked args.HintId = "..args.HintId..", giftEventData.Name = "..giftEventData.Name })
				args.HintValues = { CharacterName = characterName, ResourceName = resourceData.Name, ResourceIcon = resourceData.TextIconPath }
				Flash({ Id = newIconId, Speed = 0.8, MinFraction = 0.1, MaxFraction = 0.3, Color = Color.White })
			end
		end
	end

	for i, lockedData in ipairs( lockedEvents ) do

		local giftEventData = lockedData.GiftEventData
		--DebugPrint({ Text = "Locked giftEventData.Name = "..giftEventData.Name })
		local requirementsArgs = lockedData.RequirementsArgs

		local iconName = giftEventData.LockedIcon or "LockedHeartIcon"
		local newIconId = CreateScreenComponent({ Name = "BlankObstacle", Group = group, X = locationX, Y = locationY, Animation = iconName, Alpha = 0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 }).Id
		table.insert( screen.Components.RelationshipIcons, newIconId )
		locationX = locationX + screen.GiftTrackSpacingX

		local resourceData = nil
		for resourceName, resourceAmount in pairs( giftEventData.Cost ) do
			resourceData = ResourceData[resourceName]
		end

		if args.HintId == nil then
			if requirementsArgs.FailedRequirementIndex ~= nil and giftEventData.GameStateRequirements[requirementsArgs.FailedRequirementIndex] ~= nil and giftEventData.GameStateRequirements[requirementsArgs.FailedRequirementIndex].HintId ~= nil then
				args.HintId = giftEventData.GameStateRequirements[requirementsArgs.FailedRequirementIndex].HintId
			elseif giftEventData.LockedHintId ~= nil  then
				args.HintId = giftEventData.LockedHintId
			end
			DebugPrint({ Text = "Locked args.HintId = "..tostring(args.HintId)..", giftEventData.Name = "..giftEventData.Name })
			args.HintValues = { CharacterName = characterName, ResourceName = resourceData.Name, ResourceIcon = resourceData.TextIconPath }
			Flash({ Id = newIconId, Speed = 0.8, MinFraction = 0.1, MaxFraction = 0.3, Color = Color.White })
		end

		break -- Only ever show a single lock

	end

	if #lockedEvents > 1 then
		local newIconId = CreateScreenComponent({ Name = "BlankObstacle", Group = group, X = locationX + screen.GiftTrackMysteryHeartSpacingX, Y = locationY, Animation = "MysteryHeartIcon", Alpha = 0, AlphaTarget = 1.0, AlphaTargetDuration = 0.2 }).Id
		table.insert( screen.Components.RelationshipIcons, newIconId )
	end

end

function RemoveNextEventWithResource( completedEvents, resourceName )
	for i, giftEventData in ipairs( completedEvents ) do
		if giftEventData.Cost[resourceName] ~= nil then
			RemoveValueAndCollapse( completedEvents, giftEventData )
			return giftEventData
		end
	end
	return nil
end

function RemoveEventWithName( completedEvents, conversationName )
	for i, giftEventData in ipairs( completedEvents ) do
		if giftEventData.Name == conversationName then
			RemoveValueAndCollapse( completedEvents, giftEventData )
			return giftEventData
		end
	end
	return nil
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
	if not CodexStatus.Enabled or MapState.InOverlook or SessionState.InFlashback or SessionMapState.BlockCodex then
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
	return ( not AreScreensActive() or OnlyBoonScreenOpen() ) and IsInputAllowed({})
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
	ShowBoonInfoScreen( { LootName = entryData.BoonInfoEnemyName or entryData.BoonInfoLootName or currentEntryName, CodexScreen = codexScreen, CodexEntryName = currentEntryName, CodexEntryData = entryData } )

end

function CodexScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.MaxVisibleEntries
	GenericScrollPresentation( screen, button )
	CodexUpdateVisibility( screen, { AutoOpen = true, ScrolledUp = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((screen.MaxVisibleEntries - 1) * screen.ItemSpacingY), ForceUseCheck = true })
end

function CodexScrollDown( screen, button )
	if screen.ScrollOffset + screen.MaxVisibleEntries >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.MaxVisibleEntries
	GenericScrollPresentation( screen, button )
	CodexUpdateVisibility( screen, { AutoOpen = true, ScrolledDown = true } )
	wait(0.02)
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
				if visibleIndex == 1 and args.ScrolledDown then
					CodexOpenEntry( screen, item )
				elseif visibleIndex == screen.MaxVisibleEntries and args.ScrolledUp then
					CodexOpenEntry( screen, item )
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
			UseableOn({ Id = components.BoonInfoButton.Id })
		else
			SetAlpha({ Id = components.BoonInfoButton.Id, Fraction = 0.0, Duration = 0.0 })
			UseableOff({ Id = components.BoonInfoButton.Id })
		end
	end

end

function ValidateCodexCategories()
	if not verboseLogging then
		return
	end
	local allEntries = {}
	for categoryName, category in pairs( CodexData ) do
		DebugAssert({ Condition = Contains( CodexOrdering.Order, categoryName ), Text = categoryName.." is missing from CodexOrdering.Order", Owner = "Greg" })
		for entryName, entry in pairs( category.Entries ) do
			DebugAssert({ Condition = not allEntries[entryName], Text = entryName.." is duplicated in CodexData", Owner = "Greg" })
			DebugAssert({ Condition = Contains( CodexOrdering[categoryName], entryName ), Text = entryName.." is not included in CodexOrdering."..categoryName, Owner = "Greg" })
			allEntries[entryName] = true
		end
	end
end
