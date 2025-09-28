function ShowBoonInfoScreen( args )

	local screen = DeepCopyTable( ScreenData.BoonInfo )
	screen.LootName = args.LootName
	screen.CodexScreen = args.CodexScreen
	screen.CodexEntryName = args.CodexEntryName
	screen.CodexEntryData = args.CodexEntryData
	if args.CloseFunctionName ~= nil then
		screen.CloseFunctionName = args.CloseFunctionName
		screen.CloseFunctionArgs = args.CloseFunctionArgs
	end
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	local components = screen.Components
	local sourceData = EnemyData[screen.LootName] or LootData[screen.LootName] or {}
	ModifyTextBox({ Id = components.TitleText.Id, Text = sourceData.BoonInfoTitleText or screen.CodexEntryData.BoonInfoTitle, LuaKey = "TempTextData", LuaValue = { BoonName = screen.LootName, WeaponName = screen.CodexEntryName } })
	
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoud" })	

	if screen.CodexScreen ~= nil then
		screen.CodexScreen.Components.CloseButton.OnPressedFunctionName = nil
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
		ids = ConcatTableValues( ids, { traitContainer.QuestIcon.Id, traitContainer.PinIcon.Id, traitContainer.Highlight.Id, traitContainer.Icon.Id, traitContainer.TitleBox.Id })
		if traitContainer.Frame ~= nil then
			table.insert( ids, traitContainer.Frame.Id )
		end
		for i, component in pairs( traitContainer.Components ) do
			table.insert( ids, component.Id )
		end
	end
	if screen.SelectedItem ~= nil then
		MouseOffBoonInfoItem( screen.SelectedItem )
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

function GetBoonRarityFromData( traitData )
	local rarity = "Common"
	if traitData ~= nil then
		if traitData.TalentCategory then
			if traitData.TalentCategory == "Unique" then
				rarity = "Rare"
			elseif traitData.TalentCategory == "Legendary" then
				rarity = "Epic"
			end
		elseif traitData.IsDuoBoon then
			rarity = "Duo"
		elseif traitData.RarityLevels ~= nil and traitData.RarityLevels.Legendary and not traitData.IsHammerTrait then
			rarity = "Legendary"
		end
	end
	return rarity
end

function GetBoonOverrideRarityNameFromData( traitData )
	local overrideRarityName = nil
	if traitData ~= nil then
		if traitData.TalentCategory then
			if traitData.TalentCategory == "Unique" then
				overrideRarityName = "TraitLevel_TalentLvl2"
			elseif traitData.TalentCategory == "Legendary" then
				overrideRarityName = "TraitLevel_TalentLvl3"
			end
		end
	end
	return overrideRarityName
end

function CreateBoonInfoButton( screen, traitName, index )
		
	local screenData = ScreenData.UpgradeChoice

	local traitInfo = {}
	traitInfo.Components = {}
	table.insert( screen.TraitContainers, traitInfo )
	local offset = { X = screen.ButtonStartX, Y = screen.ButtonStartY + index * screenData.ButtonSpacingY }
	local itemLocationX = offset.X + ScreenCenterNativeOffsetX
	local itemLocationY = offset.Y + ScreenCenterNativeOffsetY

	screen.Components["BooninfoButton"..index] = traitInfo

	local traitData = TraitData[traitName]
	local rarity = GetBoonRarityFromData( traitData )
	local overrideRarityName = GetBoonOverrideRarityNameFromData( traitData )

	local consumable = GetRampedConsumableData( ConsumableData[traitName], { ForceMin = true } )
	local newTraitData = consumable or GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = rarity, ForBoonInfo = true, ForceMin = true })
	newTraitData.ForBoonInfo = true
	SetTraitTextData( newTraitData )

	local backingAnim = screenData.RarityBackingAnimations[rarity]
	if traitData ~= nil and traitData.UpgradeChoiceBackingAnimation ~= nil then
		backingAnim = traitData.UpgradeChoiceBackingAnimation
	end
	
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
	descriptionText.TextSymbolScale = newTraitData.DescriptionTextSymbolScale or descriptionText.TextSymbolScale
	descriptionText.Id = traitInfo.PurchaseButton.Id
	CreateTextBoxWithFormat( descriptionText )

	if not newTraitData.HideStatLinesInCodex then
		local statLines = newTraitData.StatLines
		if newTraitData.CustomStatLinesWithShrineUpgrade ~= nil and GetNumShrineUpgrades( newTraitData.CustomStatLinesWithShrineUpgrade.ShrineUpgradeName ) > 0 then
			statLines = newTraitData.CustomStatLinesWithShrineUpgrade.StatLines
		end
		if statLines ~= nil then
			local appendToId = descriptionText.Id
			for lineNum, statLine in ipairs( statLines ) do
				if statLine ~= "" then

					local offsetY = (lineNum - 1) * screenData.LineHeight
				
					local statLineLeft = ShallowCopyTable( screenData.StatLineLeft )
					statLineLeft.Id = traitInfo.PurchaseButton.Id
					statLineLeft.Text = statLine
					statLineLeft.OffsetY = offsetY
					statLineLeft.AppendToId = appendToId
					statLineLeft.LuaValue = newTraitData
					CreateTextBoxWithFormat( statLineLeft )

					local statLineRight = ShallowCopyTable( screenData.StatLineRight )
					statLineRight.Id = traitInfo.PurchaseButton.Id
					statLineRight.Text = statLine
					statLineRight.OffsetY = offsetY
					statLineRight.AppendToId = appendToId
					statLineRight.LuaValue = newTraitData
					CreateTextBoxWithFormat( statLineRight )

				end
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

	traitInfo.QuestIcon = CreateScreenComponent({
		Name = "BlankObstacle",
		Group = "Combat_Menu_TraitTray_Overlay",
		X = offset.X + screenData.QuestIconOffsetX + ScreenCenterNativeOffsetX,
		Y = offset.Y + screenData.QuestIconOffsetY + ScreenCenterNativeOffsetY
	})
	traitInfo.TraitName = traitName
	traitInfo.Index = index

	traitInfo.PinIcon = CreateScreenComponent({
		Name = "BlankObstacle",
		Group = "Combat_Menu_TraitTray_Overlay",
		Animation = "StoreItemPin",
		Alpha = 0.0,
		X = offset.X + ScreenData.UpgradeChoice.PinOffsetX + ScreenCenterNativeOffsetX,
		Y = offset.Y + ScreenData.UpgradeChoice.PinOffsetY + ScreenCenterNativeOffsetY
	})
	traitInfo.PurchaseButton.PinButtonId = traitInfo.PinIcon.Id
	if HasStoreItemPin( traitName ) then
		SetAlpha({ Id = traitInfo.PinIcon.Id, Fraction = 1 })
		-- Silent toolip
		CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = "NeededPinBoonTooltip_Codex", Color = Color.Transparent })
	end
	
	if IsGameStateEligible( screen, TraitRarityData.ElementalGameStateRequirements ) and not IsEmpty( newTraitData.Elements ) then
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

	if not GameState.TraitsTaken[traitName] and not GameState.ItemInteractions[traitName] and HasActiveQuestForName( traitName ) then
		SetAnimation({ DestinationId = traitInfo.QuestIcon.Id, Name = "QuestItemFound" })
	else
		SetAnimation({ DestinationId = traitInfo.QuestIcon.Id, Name = "Blank" })
	end

	BoonInfoScreenUpdateTooltipToggle( screen, button )

	if CurrentRun.BannedTraits[traitName] and CurrentHubRoom == nil then
		local bannedOverlay = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay", Animation = "BoonInfoSlotLocked", X = purchaseButton.X, Y = purchaseButton.Y })
		table.insert( traitInfo.Components, bannedOverlay )
	end

end

function CreateTraitRequirements( screen, traitName )

	DestroyTextBox({ Id = screen.Components.RequirementsText.Id })
	Destroy({ Ids = screen.TraitRequirements })
	screen.TraitRequirements = {}

	local traitData = TraitData[traitName]
	if not traitData then
		traitData = ConsumableData[traitName]
	end
	local startY = ScreenData.BoonInfo.RequirementsStartY
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

	if traitData.LinkedGod ~= nil then
		hasRequirement = true
		startY = CreateLinkedGodRequirementList( screen, traitData, startY )
	end

	local incompatibleTraits = {}

	if traitData.GameStateRequirements ~= nil and not traitData.BoonInfoIgnoreRequirements then
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

			if traitData.IsHammerTrait then
				if ( requirement.HasNone ~= nil and #path == 3 and path[1] == "CurrentRun" and path[2] == "Hero" and path[3] == "TraitDictionary" ) or
					( requirement.IsNone ~= nil and #path == 3 and path[1] == "GameState" and path[2] == "LastWeaponUpgradeName" ) then
					for i, traitName in ipairs( requirement.HasNone or requirement.IsNone ) do
						local traitData = TraitData[traitName]
						if traitData.CodexGameStateRequirements == nil or IsGameStateEligible( traitData, traitData.CodexGameStateRequirements ) then
							table.insert( incompatibleTraits, traitName )
						end
					end
				end
				if requirement.IsAny ~= nil and #path == 3 and path[1] == "GameState" and path[2] == "LastWeaponUpgradeName" then
					local anyRequirementsVisible = false
					for i, traitName in ipairs( requirement.IsAny ) do
						local traitData = TraitData[traitName]
						if traitData.CodexGameStateRequirements == nil or IsGameStateEligible( traitData, traitData.CodexGameStateRequirements ) then
							anyRequirementsVisible = true
							break
						end
					end
					if anyRequirementsVisible then
						hasRequirement = true
						startY = CreateTraitRequirementList( screen, { Text = "BoonInfo_OneOf", TextSingular = "BoonInfo_OneOf_Singular" }, requirement.IsAny, startY )
					end
				end
			elseif requirement.Value ~= nil then
				local currentCount = valueToCheck or 0
				local goalCount = requirement.Value
				local color = Color.White
				local requirementMet = false
				local numKeys = #path
				local finalKey = path[numKeys]
				if ( requirement.Comparison == ">=" and currentCount >= goalCount ) or ( requirement.Comparison == "<=" and currentCount <= goalCount ) then
					color = Color.BoonInfoAcquired
					requirementMet = true
				end

				local headerText = "BoonInfo_Elements"
				if numKeys == 4 and path[3] == "GodBoonRarities" then
					headerText = "BoonInfo_GodBoonRarities"
				end
				local listRequirementHeaderFormat = ShallowCopyTable( ScreenData.BoonInfo.ListRequirementHeaderFormat )
				listRequirementHeaderFormat.Id = screen.Components.RequirementsText.Id
				listRequirementHeaderFormat.Text = headerText
				listRequirementHeaderFormat.Color = color
				listRequirementHeaderFormat.OffsetY = startY
				CreateTextBox( listRequirementHeaderFormat )
				startY = startY + ScreenData.BoonInfo.ListRequirementHeaderSpacingY

				local countRequirementFormat = nil
				if requirementMet then
					countRequirementFormat = ShallowCopyTable( ScreenData.BoonInfo.CountRequirementAcquiredFormat )
				else
					countRequirementFormat = ShallowCopyTable( screen.CountRequirementUnacquiredFormat )
				end
				local icon = nil
				local needBulletIcon = false
				if finalKey == "HighestBaseElementCount" then
					countRequirementFormat.Text = "BoonInfo_HighestBaseElementCount"
					countRequirementFormat.TextSymbolScale = 0.7
					countRequirementFormat.OffsetX = countRequirementFormat.OffsetX + 20
					needBulletIcon = true
				elseif ScreenData.BoonInfo.IconMap[finalKey] ~= nil then
					countRequirementFormat.Text = "BoonInfo_CountRequirementIcon"
					icon = Icons[ScreenData.BoonInfo.IconMap[finalKey]]
					countRequirementFormat.TextSymbolScale = 0.7
					countRequirementFormat.OffsetX = countRequirementFormat.OffsetX + 20
					needBulletIcon = true
				end
				countRequirementFormat.Id = screen.Components.RequirementsText.Id
				countRequirementFormat.OffsetY = startY
				countRequirementFormat.LuaValue = { FinalKey = finalKey, FinalKeyIcon = icon, Value = requirement.Value }
				CreateTextBox( countRequirementFormat )

				if needBulletIcon then
					local bulletPointFormat = ShallowCopyTable( ScreenData.BoonInfo.BulletPointFormat )
					bulletPointFormat.Id = screen.Components.RequirementsText.Id
					bulletPointFormat.OffsetY = startY
					CreateTextBox( bulletPointFormat )
				end

				local godPlate = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", Animation = ScreenData.BoonInfo.GenericHeaderIcon, Scale = ScreenData.BoonInfo.GenericHeaderIconScale, Alpha = 0.0 })
				table.insert( screen.TraitRequirements, godPlate.Id )
				Attach({ Id = godPlate.Id, DestinationId = screen.Components.RequirementsText.Id, OffsetY = listRequirementHeaderFormat.OffsetY })
				if not screen.ShowTooltips then
					SetAlpha({ Id = godPlate.Id, Fraction = 1.0, Duration = 0.2 })
				end

				hasRequirement = true
				startY = startY + ScreenData.BoonInfo.ListRequirementHeaderSpacingY
			end
		end

	end

	if not IsEmpty( incompatibleTraits ) then
		local metRequirement = true
		for i, traitName in ipairs( incompatibleTraits ) do
			if HeroHasTrait( traitName ) then
				metRequirement = false
				break
			end
		end
		local color = Color.White
		if metRequirement then
			color = Color.BoonInfoAcquired
		end
		local listRequirementHeaderFormat = ShallowCopyTable( ScreenData.BoonInfo.ListRequirementHeaderFormat )
		listRequirementHeaderFormat.Id = screen.Components.RequirementsText.Id
		listRequirementHeaderFormat.Text = "BoonInfo_NoneOf"
		listRequirementHeaderFormat.Color = color
		listRequirementHeaderFormat.OffsetY = startY
		CreateTextBox( listRequirementHeaderFormat )
		startY = startY + ScreenData.BoonInfo.ListRequirementHeaderSpacingY

		for i, traitName in ipairs( incompatibleTraits ) do
			local listRequirementFormat = nil
			if HeroHasTrait( traitName ) then
				listRequirementFormat = ShallowCopyTable( ScreenData.BoonInfo.ListRequirementAcquiredFormat )
			else
				listRequirementFormat = ShallowCopyTable( screen.ListRequirementUnacquiredFormat )
			end
			listRequirementFormat.Id = screen.Components.RequirementsText.Id
			listRequirementFormat.OffsetY = startY
			listRequirementFormat.LuaValue = { TraitName = traitName }
			CreateTextBox( listRequirementFormat )

			startY = startY + ScreenData.BoonInfo.ListRequirementSpacingY
		end

		hasRequirement = true
		startY = startY + ScreenData.BoonInfo.ListRequirementHeaderSpacingY
	end

	if not hasRequirement then
		local noRequirementsFormat = ShallowCopyTable( screen.NoRequirementsFormat )
		noRequirementsFormat.Id = screen.Components.RequirementsText.Id
		noRequirementsFormat.OffsetX = screen.NoRequirementsOffsetX
		noRequirementsFormat.OffsetY = startY
		CreateTextBox( noRequirementsFormat )
	end
end

function CreateTraitRequirementList( screen, headerTextArgs, traitList, startY, metRequirement )
	if traitList == nil then
		return
	end
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

	local listRequirementHeaderFormat = ShallowCopyTable( ScreenData.BoonInfo.ListRequirementHeaderFormat )
	listRequirementHeaderFormat.Id = screen.Components.RequirementsText.Id
	listRequirementHeaderFormat.Text = headerText
	listRequirementHeaderFormat.Color = color
	listRequirementHeaderFormat.OffsetY = startY
	CreateTextBox( listRequirementHeaderFormat )

	startY = startY + ScreenData.BoonInfo.ListRequirementHeaderSpacingY
	local sharedGod = nil
	local allSame = true
	for i, traitName in ipairs( traitList ) do
		local traitData = TraitData[traitName]
		if traitData.CodexGameStateRequirements == nil or IsGameStateEligible( traitData, traitData.CodexGameStateRequirements ) then 
			local lootSourceName = GetLootSourceName( traitName, { ForBoonInfo = true } )
			if not sharedGod then
				sharedGod = lootSourceName
			elseif sharedGod ~= lootSourceName and not LootData[sharedGod].TraitIndex[traitName] then
				allSame = false
			end
		
			local listRequirementFormat = nil
			if HeroHasTrait( traitName ) then
				listRequirementFormat = ShallowCopyTable( ScreenData.BoonInfo.ListRequirementAcquiredFormat )
			else
				listRequirementFormat = ShallowCopyTable( screen.ListRequirementUnacquiredFormat )
			end
			listRequirementFormat.Id = screen.Components.RequirementsText.Id
			listRequirementFormat.OffsetY = startY
			listRequirementFormat.LuaValue = { TraitName = traitName }
			CreateTextBox( listRequirementFormat )

			startY = startY + ScreenData.BoonInfo.ListRequirementSpacingY
		end
	end

	local headerIcon = ScreenData.BoonInfo.GenericHeaderIcon
	local headerIconScale = ScreenData.BoonInfo.GenericHeaderIconScale
	if allSame and sharedGod and LootData[sharedGod].BoonInfoIcon then
		headerIcon = LootData[sharedGod].BoonInfoIcon
		headerIconScale = ScreenData.BoonInfo.GodIconScale
	end
	local godPlate = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", Animation = headerIcon, Scale = headerIconScale, Alpha = 0.0 })
	table.insert( screen.TraitRequirements, godPlate.Id )
	Attach({ Id = godPlate.Id, DestinationId = screen.Components.RequirementsText.Id, OffsetY = originalY })
	if not screen.ShowTooltips then
		SetAlpha({ Id = godPlate.Id, Fraction = 1.0, Duration = 0.2 })
	end

	startY = startY + ScreenData.BoonInfo.ListRequirementHeaderSpacingY
	return startY
end

function CreateLinkedGodRequirementList( screen, traitData, startY )

	local hasMetGod = CurrentRun.Hero.MetGods[traitData.LinkedGod]
	local keepsakeName = traitData.GameStateRequirements.OrRequirements[2][1].PathTrue[4]
	local hasKeepsake = CurrentRun.Hero.TraitDictionary[keepsakeName]

	local color = Color.White
	if hasMetGod or hasKeepsake then
		color = Color.BoonInfoAcquired
	end

	local originalY = startY

	-- header
	local listRequirementHeaderFormat = ShallowCopyTable( ScreenData.BoonInfo.ListRequirementHeaderFormat )
	listRequirementHeaderFormat.Id = screen.Components.RequirementsText.Id
	listRequirementHeaderFormat.Text = "BoonInfo_LinkedGod_Header"
	listRequirementHeaderFormat.Color = color
	listRequirementHeaderFormat.OffsetY = startY
	CreateTextBox( listRequirementHeaderFormat )

	startY = startY + ScreenData.BoonInfo.ListRequirementHeaderSpacingY

	-- any boon
	local listRequirementFormat = nil
	if hasMetGod then
		listRequirementFormat = ShallowCopyTable( ScreenData.BoonInfo.ListRequirementAcquiredFormat )
	else
		listRequirementFormat = ShallowCopyTable( screen.ListRequirementUnacquiredFormat )
	end
	listRequirementFormat.Id = screen.Components.RequirementsText.Id
	listRequirementFormat.Text = "BoonInfo_LinkedGod_Boon"
	listRequirementFormat.OffsetY = startY
	listRequirementFormat.LuaValue = { LinkedGod = traitData.LinkedGod }
	CreateTextBox( listRequirementFormat )

	startY = startY + ScreenData.BoonInfo.ListRequirementSpacingY

	-- keepsake
	if hasKeepsake then
		listRequirementFormat = ShallowCopyTable( ScreenData.BoonInfo.ListRequirementAcquiredFormat )
	else
		listRequirementFormat = ShallowCopyTable( screen.ListRequirementUnacquiredFormat )
	end

	listRequirementFormat.Id = screen.Components.RequirementsText.Id
	listRequirementFormat.OffsetY = startY
	listRequirementFormat.LuaValue = { TraitName = keepsakeName }
	CreateTextBox( listRequirementFormat )

	startY = startY + ScreenData.BoonInfo.ListRequirementSpacingY

	-- icon
	local boonIcon = LootData[traitData.LinkedGod].BoonInfoIcon
	if boonIcon then
		local godPlate = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", Animation = boonIcon, Scale = ScreenData.BoonInfo.GodIconScale, Alpha = 0.0 })
		table.insert( screen.TraitRequirements, godPlate.Id )
		Attach({ Id = godPlate.Id, DestinationId = screen.Components.RequirementsText.Id, OffsetY = originalY })
		if not screen.ShowTooltips then
			SetAlpha({ Id = godPlate.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end

	startY = startY + ScreenData.BoonInfo.ListRequirementHeaderSpacingY

	return startY
end

function MouseOverBoonInfoItem( button )
	GenericMouseOverPresentation( button )
	local screen = button.Screen
	screen.SelectedItem = button
	screen.ClipboardText = button.TraitData.Name
	SetAnimation({ DestinationId = button.Highlight.Id, Name = "BoonSlotHighlight" })
	CreateTraitRequirements( screen, button.TraitData.Name )
	if GameState.WorldUpgrades.WorldUpgradePinningBoons and screen.CodexEntryData.BoonInfoAllowPinning then
		screen.Components.PinButton.Visible = true
		if HasStoreItemPin( button.TraitData.Name ) then
			ModifyTextBox({ Id = screen.Components.PinButton.Id, Text = screen.Components.PinButton.AltText })
		else
			ModifyTextBox({ Id = screen.Components.PinButton.Id, Text = screen.Components.PinButton.Text })
		end
		SetAlpha({ Id = screen.Components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
		if not GameState.Flags.HasPinnedAnyBoon and not screen.FirstPinPrompt then
			thread( PulseContextActionPresentation, screen.Components.PinButton, { ThreadName = "BoonPinPulse" } )
			screen.FirstPinPrompt = true
		end
	end
end

function MouseOffBoonInfoItem( button )
	local screen = button.Screen
	screen.SelectedItem = nil
	SetAnimation({ DestinationId = button.Highlight.Id, Name = "BoonHighlightOut" })
	
	DestroyTextBox({ Id = screen.Components.RequirementsText.Id })
	Destroy({ Ids = screen.TraitRequirements })
	screen.TraitRequirements = {}

	SetAlpha({ Id = screen.Components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	screen.Components.PinButton.Visible = false
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
	GenericScrollPresentation( screen, button )
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
	GenericScrollPresentation( screen, button )
end

function UpdateBoonInfoPageButtons( screen )
	local components = screen.Components
	if screen.TraitList[screen.StartingIndex + screen.NumPerPage] then
		SetAlpha({ Id = components.PageDown.Id, Fraction = 1, Duration = 0 })
		UseableOn({ Id = components.PageDown.Id })
	else
		SetAlpha({ Id = components.PageDown.Id, Fraction = 0, Duration = 0 })
		UseableOff({ Id = components.PageDown.Id, ForceHighlightOff = true })
	end
	if screen.TraitList[screen.StartingIndex - screen.NumPerPage] then
		SetAlpha({ Id = components.PageUp.Id, Fraction = 1, Duration = 0 })
		UseableOn({ Id = components.PageUp.Id })
	else
		SetAlpha({ Id = components.PageUp.Id, Fraction = 0, Duration = 0 })
		UseableOff({ Id = components.PageUp.Id, ForceHighlightOff = true })
	end
end

function BoonInfoScreenToggleTooltips( screen, button )
	screen.ShowTooltips = not screen.ShowTooltips
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
			ModifyTextBox({ Id = component.PurchaseButton.Id, BlockTooltip = not screen.ShowTooltips })
		end
	end
	if not screen.ShowTooltips then
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
	killTaggedThreads( "BoonPinPulse" )

	local ids = GetAllIds( screen.Components )
	for i, traitContainer in pairs( screen.TraitContainers ) do
		ids = ConcatTableValues( ids,
			{
				traitContainer.PurchaseButton.Id, traitContainer.QuestIcon.Id, traitContainer.PinIcon.Id,
				traitContainer.Highlight.Id, traitContainer.Icon.Id, traitContainer.TitleBox.Id,
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
	if screen.CloseFunctionName ~= nil then
		CallFunctionName( screen.CloseFunctionName, screen, screen.CloseFunctionArgs )
	end
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

	DebugAssert({ Condition = screen.TraitSortOrder[screen.LootName] ~= nil, Text = screen.LootName.." doesn't have a defined trait sort order", Owner = "Caleb" })

	screen.TraitList = {}

	local codexWeaponName = nil
	if screen.LootName == "WeaponUpgrade" then
		if screen.CodexScreen ~= nil then
			codexWeaponName = screen.CodexScreen.OpenEntryName
		else
			codexWeaponName = GetEquippedWeapon()
		end
	end

	for i, traitName in ipairs( screen.TraitSortOrder[screen.LootName] ) do
		local traitData = TraitData[traitName]
		if traitData ~= nil and ( not traitData.CodexWeapon or traitData.CodexWeapon == codexWeaponName ) and ( traitData.CodexGameStateRequirements == nil or IsGameStateEligible( traitData, traitData.CodexGameStateRequirements ) ) then
			table.insert( screen.TraitList, traitName )
		elseif ConsumableData[traitName] ~= nil then
			table.insert( screen.TraitList, traitName )
		end
	end

end

function BoonInfoPinItem( screen, button )
	if screen.SelectedItem == nil then
		return
	end
	if not GameState.WorldUpgrades.WorldUpgradePinningBoons or not screen.CodexEntryData.BoonInfoAllowPinning then
		return
	end
	local itemName = screen.SelectedItem.TraitData.Name
	if HasStoreItemPin( itemName ) then
		RemoveStoreItemPin( itemName )
		RemoveStoreItemPinPresentation( screen.SelectedItem, { Text = "NeededPinBoonTooltip_Codex" } )
		ModifyTextBox({ Id = screen.Components.PinButton.Id, Text = screen.Components.PinButton.Text })
	else
		AddStoreItemPin( itemName, "TraitData" )
		AddStoreItemPinPresentation( screen.SelectedItem, { Text = "NeededPinBoonTooltip_Codex" } )
		ModifyTextBox({ Id = screen.Components.PinButton.Id, Text = screen.Components.PinButton.AltText })
	end
	BoonInfoScreenUpdateTooltipToggle( screen )
	GameState.Flags.HasPinnedAnyBoon = true
	killTaggedThreads( "BoonPinPulse" )
end