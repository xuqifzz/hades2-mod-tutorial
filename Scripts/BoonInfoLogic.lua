function ShowBoonInfoScreen( lootName, codexScreen, codexEntryName, codexEntryData )

	if not GameState.ScreensViewed.BoonInfo then
		-- Default to true now
		GameState.BoonInfoScreenShowTooltips = true
	end

	local screen = DeepCopyTable( ScreenData.BoonInfo )
	screen.LootName = lootName
	screen.CodexScreen = codexScreen
	screen.CodexEntryName = codexEntryName
	screen.CodexEntryData = codexEntryData
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	local components = screen.Components
	local sourceData = EnemyData[screen.LootName] or LootData[screen.LootName] or {}
	ModifyTextBox({ Id = components.TitleText.Id, Text = sourceData.BoonInfoTitleText or codexEntryData.BoonInfoTitle, LuaKey = "TempTextData", LuaValue = { BoonName = lootName, WeaponName = codexEntryName }, })
	
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoud" })	

	if codexScreen ~= nil then
		codexScreen.Components.CloseButton.OnPressedFunctionName = nil
	end

	BoonInfoPopulateTraits( screen )
	CreateBoonInfoButtons( screen )
	TeleportCursor({ DestinationId = screen.Components["BooninfoButton1"].PurchaseButton.Id, ForceUseCheck = true })
	
	UpdateBoonInfoPageButtons( screen )

	screen.KeepOpen = true
	screen.CanClose = true
	HandleScreenInput( screen )
end

function CreateBoonInfoButtons( screen )

	-- Destroy previous buttons
	local ids = {}
	for i, traitContainer in pairs( screen.TraitContainers ) do
		ids = ConcatTableValues( ids, { traitContainer.QuestIcon.Id, traitContainer.Highlight.Id, traitContainer.Icon.Id, traitContainer.TitleBox.Id })
		if traitContainer.Frame ~= nil then
			table.insert( ids, traitContainer.Frame.Id )
		end
		for i, component in pairs( traitContainer.Components ) do
			table.insert( ids, component.Id )
		end
	end
	Destroy({ Ids = ids })

	--DebugPrintTable( EnemyData[screen.LootName] )

	--DebugPrintTable( traitList )
	for i = screen.StartingIndex, screen.StartingIndex + screen.NumPerPage - 1 do 
		local traitName = screen.TraitList[i]
		if traitName ~= nil then
			CreateBoonInfoButton( screen, traitName, (i - screen.StartingIndex) + 1 )
		end
	end

	local currentPageNum = math.floor( screen.StartingIndex / screen.NumPerPage ) + 1
	local numPages = math.ceil( #screen.TraitList / screen.NumPerPage )
	ModifyTextBox({ Id = screen.Components.PageNumber.Id, LuaKey = "TempTextData", LuaValue = { CurrentPageNum = currentPageNum, NumPages = numPages }, })

end

function CreateBoonInfoButton( screen, traitName, index )
		
	local screenData = ScreenData.UpgradeChoice

	local traitInfo = {}
	local overrideRarityName = nil
	traitInfo.Components = {}
	table.insert( screen.TraitContainers, traitInfo )
	local offset = { X = screen.ButtonStartX, Y = screen.ButtonStartY + index * screenData.ButtonSpacingY }
	local itemLocationX = offset.X + ScreenCenterNativeOffsetX
	local itemLocationY = offset.Y + ScreenCenterNativeOffsetY

	screen.Components["BooninfoButton"..index] = traitInfo

	local rarity = "Common"
	local traitData = TraitData[traitName]
	if traitData ~= nil then
		if traitData.TalentCategory then
			if traitData.TalentCategory == "Unique" then
				rarity = "Rare"
				overrideRarityName = "TraitLevel_TalentLvl2"
			elseif traitData.TalentCategory == "Legendary" then
				rarity = "Epic"
				overrideRarityName = "TraitLevel_TalentLvl3"
			end
		elseif traitData.IsDuoBoon then
			rarity = "Duo"
		elseif traitData.RarityLevels ~= nil and traitData.RarityLevels.Legendary then
			rarity = "Legendary"
		end
	end

	local consumable = GetRampedConsumableData( ConsumableData[traitName], nil, { ForceMin = true } )
	local newTraitData = consumable or GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = rarity, ForBoonInfo = true })
	newTraitData.ForBoonInfo = true
	SetTraitTextData( newTraitData )

	local backingAnim = screenData.RarityBackingAnimations[rarity]
	
	local purchaseButton = ShallowCopyTable( screenData.PurchaseButton )
	purchaseButton.Group = "Combat_Menu_TraitTray"
	if backingAnim ~= nil then
		purchaseButton.Animation = backingAnim
	end
	purchaseButton.X = itemLocationX + screenData.ButtonOffsetX
	purchaseButton.Y = itemLocationY
	purchaseButton.TraitData = newTraitData
	local button = CreateScreenComponent( purchaseButton )
	traitInfo.PurchaseButton = button
	button.TraitData = newTraitData
	button.Screen = screen
	button.OnMouseOverFunctionName = "MouseOverBoonInfoItem"
	button.OnMouseOffFunctionName = "MouseOffBoonInfoItem"
	SetInteractProperty({ DestinationId = button.Id, Property = "TooltipOffsetX", Value = screen.TooltipOffsetX })
	SetInteractProperty({ DestinationId = button.Id, Property = "TooltipOffsetY", Value = screen.TooltipOffsetY })
	--SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX })
	--SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })
	AttachLua({ Id = button.Id, Table = button })
	table.insert( traitInfo.Components, button )

	local rarityColor = newTraitData.CustomRarityColor or Color["BoonPatch"..rarity]

	traitInfo.TitleBox = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay", X = purchaseButton.X, Y = purchaseButton.Y })
	local titleText = ShallowCopyTable( screenData.TitleText )
	titleText.Id = traitInfo.TitleBox.Id
	titleText.Text = newTraitData.Name
	titleText.LuaValue = newTraitData
	titleText.Color = rarityColor
	CreateTextBox( titleText )
	table.insert( traitInfo.Components, traitInfo.TitleBox )

	local descriptionText = ShallowCopyTable( screenData.DescriptionText )
	descriptionText.Text = newTraitData.CodexName or newTraitData.Name
	descriptionText.LuaValue = newTraitData
	descriptionText.Id = traitInfo.PurchaseButton.Id
	CreateTextBoxWithFormat( descriptionText )

	if newTraitData.StatLines ~= nil then
		local appendToId = nil
		if #newTraitData.StatLines <= 1 then
			appendToId = descriptionText.Id
		end
		for lineNum, statLine in ipairs( newTraitData.StatLines ) do
			if statLine ~= "" then
				
				local statLineLeft = ShallowCopyTable( screenData.StatLineLeft )
				statLineLeft.Id = traitInfo.PurchaseButton.Id
				statLineLeft.Text = statLine
				statLineLeft.OffsetY = (lineNum - 1) * screenData.LineHeight
				statLineLeft.AppendToId = appendToId
				statLineLeft.LuaValue = newTraitData
				CreateTextBoxWithFormat( statLineLeft )

				local statLineRight = ShallowCopyTable( screenData.StatLineRight )
				statLineRight.Id = traitInfo.PurchaseButton.Id
				statLineRight.Text = statLine
				statLineRight.OffsetY = (lineNum - 1) * screenData.LineHeight
				statLineRight.AppendToId = appendToId
				statLineRight.LuaValue = newTraitData
				CreateTextBoxWithFormat( statLineRight )

			end
		end
	end

	if newTraitData.FlavorText ~= nil then
		local flavorText = ShallowCopyTable( screenData.FlavorText )
		flavorText.Id = traitInfo.PurchaseButton.Id
		flavorText.Text = newTraitData.FlavorText
		CreateTextBox( flavorText )
	end

	local rarityText = ShallowCopyTable( screenData.RarityText )
	rarityText.Id = traitInfo.PurchaseButton.Id
	rarityText.Text = overrideRarityName or newTraitData.CustomRarityName or "Boon_"..tostring(rarity)
	rarityText.Color = rarityColor 
	CreateTextBox( rarityText )

	local highlight = ShallowCopyTable( screenData.Highlight )
	highlight.X = purchaseButton.X
	highlight.Y = purchaseButton.Y
	highlight.Group = "Combat_Menu_TraitTray_Overlay"
	button.Highlight = CreateScreenComponent( highlight )
	traitInfo.Highlight = button.Highlight
	
	local icon = ShallowCopyTable( screenData.Icon )
	icon.X = screenData.IconOffsetX + itemLocationX + screenData.ButtonOffsetX
	icon.Y = screenData.IconOffsetY + itemLocationY
	icon.Group = "Combat_Menu_TraitTray_Overlay"
	traitInfo.Icon = CreateScreenComponent( icon )

	if not newTraitData.NoFrame then
		local frame = ShallowCopyTable( screenData.Frame )
		frame.X = screenData.IconOffsetX + itemLocationX + screenData.ButtonOffsetX
		frame.Y = screenData.IconOffsetY + itemLocationY
		frame.Group = "Combat_Menu_TraitTray_Overlay"
		frame.Animation = "Frame_Boon_Menu_"..( newTraitData.Frame or rarity )
		traitInfo.Frame = CreateScreenComponent( frame )
	end

	traitInfo.QuestIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay",
		X = offset.X + screenData.QuestIconOffsetX + ScreenCenterNativeOffsetX, Y = offset.Y + screenData.QuestIconOffsetY + ScreenCenterNativeOffsetY })
	traitInfo.TraitName = traitName
	traitInfo.Index = index
	
	if IsGameStateEligible( CurrentRun, TraitRarityData.ElementalGameStateRequirements ) and not IsEmpty( newTraitData.Elements ) then
		local elementName = GetFirstValue( newTraitData.Elements )
		local elementIcon = ShallowCopyTable( screenData.ElementIcon )
		elementIcon.Group = "Combat_Menu_TraitTray_Overlay"
		elementIcon.Name = TraitElementData[elementName].Icon
		elementIcon.X = itemLocationX + elementIcon.XShift
		elementIcon.Y = itemLocationY + elementIcon.YShift
		local elementIconComponent = CreateScreenComponent( elementIcon )
		table.insert( traitInfo.Components, elementIconComponent )
	end
	
	SetTraitTrayDetails(
	{
		TraitData = newTraitData, 
		ForBoonInfo = true,
		--DetailsBox = traitInfo.DetailsBacking,
		--RarityBox = traitInfo.RarityBox, 
		--TitleBox = traitInfo.TitleBox, 
		Patch = traitInfo.Patch, 
		Icon = traitInfo.Icon, 
		Frame = traitInfo.Frame,
		--StatLines = traitInfo.StatlineBackings,
		--ElementalIcons = traitInfo.ElementalIcons 
	})

	if not GameState.TraitsTaken[traitName] and HasActiveQuestForName( traitName ) then
		SetAnimation({ DestinationId = traitInfo.QuestIcon.Id, Name = "QuestItemFound" })
	else
		SetAnimation({ DestinationId = traitInfo.QuestIcon.Id, Name = "Blank" })
	end

	BoonInfoScreenUpdateTooltipToggle( screen, button )

end

function CreateTraitRequirements( screen, traitName )

	DestroyTextBox({ Id = screen.Components.RequirementsText.Id })
	Destroy({ Ids = screen.TraitRequirements })
	screen.TraitRequirements = {}

	local traitData = TraitData[traitName]
	if not traitData then
		traitData = ConsumableData[traitName]
	end
	local startY = screen.RequirementsStartY
	local startX = screen.RequirementsStartX
	local hasRequirement = false
	
	local requirementData = TraitRequirements[traitName]
	if requirementData ~= nil then
		hasRequirement = true
		if requirementData.OneOf ~= nil then
			startY = CreateTraitRequirementList( screen, { Text = "BoonInfo_OneOf", TextSingular = "BoonInfo_OneOf_Singular" }, requirementData.OneOf, startY )
		elseif requirementData.TwoOf ~= nil then
			startY = CreateTraitRequirementList( screen, { Text = "BoonInfo_TwoOf", TextSingular = "BoonInfo_OneOf_Singular" }, requirementData.TwoOf, startY )
		elseif requirementData.OneFromEachSet ~= nil then
			for i, set in pairs( requirementData. OneFromEachSet ) do
				startY = CreateTraitRequirementList( screen, { Text = "BoonInfo_OneOf", TextSingular = "BoonInfo_OneOf_Singular" }, set, startY )
			end
		end
	end

	if traitData.GameStateRequirements ~= nil and not traitData.BoonInfoIgnoreRequirements then
		hasRequirement = true
		-- Generic requirements
		for i, requirement in ipairs( traitData.GameStateRequirements ) do

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
				local color = Color.White
				local numKeys = #path
				local finalKey = path[numKeys]
				if currentCount >= goalCount then
					color = Color.BoonInfoAcquired
				end

				local listRequirementHeaderFormat = ShallowCopyTable( screen.ListRequirementHeaderFormat )
				listRequirementHeaderFormat.Id = screen.Components.RequirementsText.Id
				listRequirementHeaderFormat.Text = "BoonInfo_Elements"
				listRequirementHeaderFormat.Color = color
				listRequirementHeaderFormat.OffsetY = startY
				CreateTextBox( listRequirementHeaderFormat )
				startY = startY + screen.ListRequirementHeaderSpacingY

				local countRequirementFormat = ShallowCopyTable( screen.CountRequirementFormat )
				local icon = nil
				if screen.IconMap[finalKey] ~= nil then
					countRequirementFormat.Text = "BoonInfo_CountRequirementIcon"
					icon = Icons[screen.IconMap[finalKey]]
					countRequirementFormat.TextSymbolScale = 0.7
				end
				countRequirementFormat.Id = screen.Components.RequirementsText.Id
				countRequirementFormat.OffsetY = startY
				countRequirementFormat.Color = color
				countRequirementFormat.LuaValue = { FinalKey = finalKey, FinalKeyIcon = icon, Value = requirement.Value }
				CreateTextBox( countRequirementFormat )
					
				startY = startY + screen.ListRequirementSpacingY
			end
		end

	end

	if not hasRequirement then
		local noRequirementsFormat = ShallowCopyTable( screen.NoRequirementsFormat )
		noRequirementsFormat.Id = screen.Components.RequirementsText.Id
		noRequirementsFormat.OffsetY = startY
		CreateTextBox( noRequirementsFormat )
	end
end

function CreateTraitRequirementList( screen, headerTextArgs, traitList, startY, metRequirement )
	if traitList == nil then
		return
	end
	local startX = 0
	local originalY = startY
	local headerText = headerTextArgs.Text
	if TableLength(traitList) == 1 and headerTextArgs.TextSingular then
		headerText = headerTextArgs.TextSingular
	end
	
	if metRequirement == nil then
		for i, traitName in ipairs( traitList ) do
			if HeroHasTrait( traitName ) then
				metRequirement = true
			end
		end
	end

	local color = Color.White
	if metRequirement then
		color = Color.BoonInfoAcquired
	end

	local listRequirementHeaderFormat = ShallowCopyTable( screen.ListRequirementHeaderFormat )
	listRequirementHeaderFormat.Id = screen.Components.RequirementsText.Id
	listRequirementHeaderFormat.Text = headerText
	listRequirementHeaderFormat.Color = color
	listRequirementHeaderFormat.OffsetY = startY
	CreateTextBox( listRequirementHeaderFormat )

	startY = startY + screen.ListRequirementHeaderSpacingY
	local sharedGod = nil
	local allSame = true
	for i, traitName in ipairs( traitList ) do
		if not sharedGod then
			sharedGod = GetLootSourceName( traitName )
		elseif sharedGod ~= GetLootSourceName(traitName) then
			allSame = false
		end
		local displayedTraitName = traitName
		if TraitData[traitName].BoonInfoRequirementText then
			displayedTraitName = TraitData[traitName].BoonInfoRequirementText 
		end
		
		local listRequirementFormat = ShallowCopyTable( screen.ListRequirementUnacquiredFormat )
		if HeroHasTrait( traitName ) then
			listRequirementFormat = ShallowCopyTable( screen.ListRequirementAcquiredFormat )
		end
		listRequirementFormat.Id = screen.Components.RequirementsText.Id
		listRequirementFormat.OffsetY = startY
		listRequirementFormat.LuaValue = { TraitName = displayedTraitName }
		CreateTextBox( listRequirementFormat )

		startY = startY + screen.ListRequirementSpacingY
	end
	if allSame and sharedGod and LootData[sharedGod].BoonInfoIcon then
		local godPlate = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", Animation = LootData[sharedGod].BoonInfoIcon, Scale = screen.GodIconScale, Alpha = 0.0 })
		table.insert( screen.TraitRequirements, godPlate.Id )
		Attach({ Id = godPlate.Id, DestinationId = screen.Components.RequirementsText.Id, OffsetX = startX, OffsetY = originalY })
		if not GameState.BoonInfoScreenShowTooltips then
			SetAlpha({ Id = godPlate.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end

	startY = startY + screen.ListRequirementHeaderSpacingY
	return startY
end

function MouseOverBoonInfoItem( button )
	GenericMouseOverPresentation( button )
	local screen = button.Screen
	SetAnimation({ DestinationId = button.Highlight.Id, Name = "BoonSlotHighlight" })
	CreateTraitRequirements( screen, button.TraitData.Name )
end

function MouseOffBoonInfoItem( button )
	local screen = button.Screen
	SetAnimation({ DestinationId = button.Highlight.Id, Name = "BoonHighlightOut" })
	
	DestroyTextBox({ Id = screen.Components.RequirementsText.Id })
	Destroy({ Ids = screen.TraitRequirements })
	screen.TraitRequirements = {}
end

function BoonInfoScreenPrevious( screen, button )
	if not screen.TraitList[screen.StartingIndex - screen.NumPerPage] then
		return 
	end
	local components = screen.Components
	screen.StartingIndex = screen.StartingIndex - screen.NumPerPage
	CreateBoonInfoButtons( screen )
	UpdateBoonInfoPageButtons( screen )
	TeleportCursor({ DestinationId = screen.Components["BooninfoButton3"].PurchaseButton.Id, ForceUseCheck = true })
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOut" })
end

function BoonInfoScreenNext( screen, button )
	if not screen.TraitList[screen.StartingIndex + screen.NumPerPage] then
		return 
	end
	local components = screen.Components
	screen.StartingIndex = screen.StartingIndex + screen.NumPerPage
	CreateBoonInfoButtons( screen )
	UpdateBoonInfoPageButtons( screen )
	TeleportCursor({ DestinationId = screen.Components["BooninfoButton1"].PurchaseButton.Id, ForceUseCheck = true })
end

function UpdateBoonInfoPageButtons( screen )
	local components = screen.Components
	if screen.TraitList[screen.StartingIndex + screen.NumPerPage] then
		SetAlpha({ Id = components.PageDown.Id, Fraction = 1, Duration = 0 })
		UseableOn({ Id = components.PageDown.Id })
	else
		SetAlpha({ Id = components.PageDown.Id, Fraction = 0, Duration = 0 })
		UseableOff({ Id = components.PageDown.Id })
	end
	if screen.TraitList[screen.StartingIndex - screen.NumPerPage] then
		SetAlpha({ Id = components.PageUp.Id, Fraction = 1, Duration = 0 })
		UseableOn({ Id = components.PageUp.Id })
	else
		SetAlpha({ Id = components.PageUp.Id, Fraction = 0, Duration = 0 })
		UseableOff({ Id = components.PageUp.Id })
	end
end

function BoonInfoScreenToggleTooltips( screen, button )
	GameState.BoonInfoScreenShowTooltips = not GameState.BoonInfoScreenShowTooltips
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	BoonInfoScreenUpdateTooltipToggle( screen, button )
end

function BoonInfoScreenUpdateTooltipToggle( screen, button )

	if screen.CodexEntryData.NoRequirements then
		SetAlpha({ Id = screen.Components.RequirementsTitle.Id, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = screen.Components.RequirementsText.Id, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = screen.Components.ToggleTooltipsButton.Id, Fraction = 0.0, Duration = 0.0 })
		screen.Components.ToggleTooltipsButton.OnUsedFunctionName = nil
		UseableOff({ Id = screen.Components.ToggleTooltipsButton.Id })
		return
	end

	for name, component in pairs( screen.Components ) do
		if component.PurchaseButton ~= nil then
			ModifyTextBox({ Id = component.PurchaseButton.Id, BlockTooltip = not GameState.BoonInfoScreenShowTooltips })
		end
	end
	if not GameState.BoonInfoScreenShowTooltips then
		SetAlpha({ Id = screen.Components.RequirementsTitle.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = screen.Components.RequirementsText.Id, Fraction = 1.0, Duration = 0.2 })
		ModifyTextBox({ Id = screen.Components.ToggleTooltipsButton.Id, Text = "BoonInfo_ShowTooltips" })
		for k, id in pairs( screen.TraitRequirements ) do 
			SetAlpha({ Id = id, Fraction = 1.0, Duration = 0.2 })
		end
	else
		SetAlpha({ Id = screen.Components.RequirementsTitle.Id, Fraction = 0.0, Duration = 0.2 })
		SetAlpha({ Id = screen.Components.RequirementsText.Id, Fraction = 0.0, Duration = 0.2 })
		ModifyTextBox({ Id = screen.Components.ToggleTooltipsButton.Id, Text = "BoonInfo_ShowRequirements" })
		for k, id in pairs( screen.TraitRequirements ) do 
			SetAlpha({ Id = id, Fraction = 0.0, Duration = 0.2 })
		end
	end
end

function CloseBoonInfoScreen( screen, button )
	if screen == nil or not screen.CanClose then
		return
	end
	screen.CanClose = false
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	local ids = GetAllIds( screen.Components )
	for i, traitContainer in pairs( screen.TraitContainers ) do
		ids = ConcatTableValues( ids,
			{
				traitContainer.PurchaseButton.Id, traitContainer.QuestIcon.Id, traitContainer.Highlight.Id, traitContainer.Icon.Id,
				traitContainer.TitleBox.Id,
			})
		if traitContainer.Frame ~= nil then
			table.insert( ids, traitContainer.Frame.Id )
		end
		for i, component in pairs( traitContainer.Components ) do
			table.insert( ids, component.Id )
		end
		
	end
	ids = ConcatTableValues( ids, screen.TraitRequirements )
	UseableOff({ Ids = ids })
	OnScreenCloseStarted( screen )
	CloseScreen( ids , 0.15 )
	OnScreenCloseFinished( screen )
	
	local codexScreen = screen.CodexScreen
	if codexScreen ~= nil then
		SetGamepadNavigation( codexScreen )
		CodexUpdateVisibility( codexScreen )
		codexScreen.Components.CloseButton.OnPressedFunctionName = "CloseCodexScreen"
		local selectedEntryName = CodexStatus.SelectedEntryNames[CodexStatus.SelectedChapterName]
		if selectedEntryName ~= nil then
			local entry = codexScreen.Components[selectedEntryName]
			if entry ~= nil then
				TeleportCursor({ OffsetX = entry.EntryXLocation, OffsetY = entry.EntryYLocation, ForceUseCheck = true })
			end
		end
	end
	
end

function BoonInfoPopulateTraits( screen )
	--screen.HiddenTraits = {}

	screen.TraitList = {}

	local allTraitsList = nil
	if screen.TraitDictionary[screen.LootName] ~= nil then
		allTraitsList = GetAllKeys( screen.TraitDictionary[screen.LootName] )
		table.sort( allTraitsList, BoonInfoSort )
	else
		allTraitsList = (EnemyData[screen.LootName] or LootData[screen.LootName]).Traits
	end

	--[[
	for traitName, requirements in pairs( screen.HiddenTraitData ) do
		if not IsGameStateEligible( CurrentRun, requirements ) then
			screen.HiddenTraits[traitName] = true
		end
	end
	]]

	for i, traitName in ipairs( allTraitsList ) do
		--if not TraitData[traitName] or not TraitData[traitName].RequiredTrait or not screen.HiddenTraits[TraitData[traitName].RequiredTrait ] then
		local traitData = TraitData[traitName]
		if traitData ~= nil and ( traitData.RequiredWeapon == nil or traitData.RequiredWeapon == screen.CodexEntryName ) then
			table.insert( screen.TraitList, traitName )
		elseif ConsumableData[traitName] ~= nil then
			table.insert( screen.TraitList, traitName )
		end
	end

end

function BoonInfoSort( itemA, itemB )
	local traitA = TraitData[itemA] or ConsumableData[itemA]
	local traitB = TraitData[itemB] or ConsumableData[itemB]
	if traitA == nil then
		return true
	end
	if traitB == nil then
		return false
	end
	local slotToInt = 
		function( trait )
			if trait ~= nil then
				local slotType = trait.Slot

				if slotType == "Melee" then
					return 0
				elseif slotType == "Secondary" then
					return 1
				elseif slotType == "Ranged" then
					return 2
				elseif slotType == "Rush" then
					return 3
				elseif slotType == "Mana" then
					return 4
				elseif slotType == "Spell" then
					return 5 + GetKey(SpellDisplayData.SpellTraitOrdering, trait.Name )
				end

				if ScreenData.BoonInfo.TraitRequirementsDictionary[trait.Name] then
					return 99
				end
			end
			
			return 5
		end
	local rarityToInt = 
		function ( trait )
			if trait ~= nil then
				if trait.IsDuoBoon then
					return 4
				elseif trait.RarityLevels and trait.RarityLevels.Legendary and not Contains( trait.InheritFrom, "ChaosBlessingTrait" ) then
					return 3
				end
				return 1
			else
				return 2
			end
		end
		
	local weaponToInt = 
		function ( trait )
			if trait ~= nil then
				local value = 99
				if trait.RequiredWeapon == "SwordWeapon" or Contains(trait.RequiredWeapons, "SwordWeapon") then
					value = 0
				elseif trait.RequiredWeapon == "BowWeapon" or Contains(trait.RequiredWeapons, "BowWeapon") then
					value = 10
				elseif trait.RequiredWeapon == "BowSplitShot" or Contains(trait.RequiredWeapons, "BowSplitShot") then
					value = 11
				elseif trait.RequiredWeapon == "ShieldWeapon" or Contains(trait.RequiredWeapons, "ShieldWeapon") then
					value = 20
				elseif trait.RequiredWeapon == "SpearWeapon" or Contains(trait.RequiredWeapons, "SpearWeapon") then
					value = 30
				elseif trait.RequiredWeapon == "SpearWeaponThrow" or Contains(trait.RequiredWeapons, "SpearWeaponThrow") then
					value = 31
				elseif trait.RequiredWeapon == "GunWeapon" or Contains(trait.RequiredWeapons, "GunWeapon") then
					value = 40
				elseif trait.RequiredWeapon == "FistWeapon" or Contains(trait.RequiredWeapons, "FistWeapon") then
					value = 50
				end
				if trait.RequiredTrait then
					value = value + 2
				end
				return value
			end
			return 99
		end
		
	local chaosToInt = 
		function ( trait )
			if trait ~= nil then
				if trait.RarityLevels and trait.RarityLevels.Legendary then
					return 4
				end
				if trait.IsElementalTrait  then
					return 3
				end
				if Contains( trait.InheritFrom, "ChaosBlessing" ) then
					return 2
				elseif Contains( trait.InheritFrom, "ChaosCurse" ) then
					return 1
				end
			end
			return 99
		end

	local talentToInt = 
		function ( trait )
			if trait ~= nil and trait.TalentCategory then
				if trait.TalentCategory == "Repeatable" then
					if TraitRequirements[trait.Name] and not IsEmpty(TraitRequirements[trait.Name].OneOf) then
						if TableLength(TraitRequirements[trait.Name].OneOf) > 1 then 
							return 10 - TableLength(TraitRequirements[trait.Name].OneOf)
						else
							return 11 + GetKey( SpellDisplayData.SpellTraitOrdering, TraitRequirements[trait.Name].OneOf[1] )
						end
					end
					return 0
				elseif trait.TalentCategory == "Unique" or trait.TalentCategory == "Legendary" then
					if TraitRequirements[trait.Name] and not IsEmpty(TraitRequirements[trait.Name].OneOf) then
						local rarityAdjustment = 0
						if trait.TalentCategory == "Legendary" then
							rarityAdjustment = 1
						end
						return 20 + GetKey( SpellDisplayData.SpellTraitOrdering, TraitRequirements[trait.Name].OneOf[1] ) * 10 + rarityAdjustment
					end
					return 90
				end
			end
			return 99
		end
	if slotToInt(traitA) ~= slotToInt(traitB) then
		return slotToInt(traitA) < slotToInt(traitB)
	end
	if talentToInt(traitA) ~= talentToInt(traitB) then
		return talentToInt(traitA) < talentToInt(traitB)
	end
	if rarityToInt(traitA) ~= rarityToInt(traitB) then
		return rarityToInt(traitA) < rarityToInt(traitB)
	end
	if weaponToInt(traitA) ~= weaponToInt(traitB) then
		return weaponToInt(traitA) < weaponToInt(traitB)
	end
	if chaosToInt(traitA) ~= chaosToInt(traitB) then
		return chaosToInt(traitA) < chaosToInt(traitB)
	end
	
	if traitA.Name ~= traitB.Name then
		return traitA.Name < traitB.Name
	end
	return false
end