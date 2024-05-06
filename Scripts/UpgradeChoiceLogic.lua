
function OpenUpgradeChoiceMenu( source, args )

	AltAspectRatioFramesShow()

	args = args or {}
	local upgradeName = source.Name
	-- Not allowed to quit after seeing otherwise hidden choices
	InvalidateCheckpoint()
	
	local screen = DeepCopyTable( ScreenData.UpgradeChoice )
	if args.OverwriteTableKeys ~= nil then
		OverwriteTableKeys( screen, args.OverwriteTableKeys )
	end
	screen.Source = source
	ScreenAnchors.ChoiceScreen = screen
	HideCombatUI( screen.Name )
	UnblockCombatUI( "PlayTextLines" )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData, args )

	if source.Icon or source.DoorIcon then
		SetAnimation({ DestinationId = screen.Components.SourceIcon.Id, Name = source.DoorIcon or source.Icon })
	end
	
	if HeroHasTrait( "PanelRerollMetaUpgrade" ) then
		screen.MovedRerollUIGroup = true
		RemoveFromGroup({ Id = ScreenAnchors.Reroll, Name = "Combat_UI" })
		AddToGroup({ Id = ScreenAnchors.Reroll, Name = "Combat_Menu_Overlay", DrawGroup = true })
	end
	source.HasExchange = HasExchangeOnLoot( source )
	UpgradeChoiceScreenOpenStartPresentation( screen, source )
	ToggleCombatControl({"Attack3"}, true, screen.Name )
	local validWeapons = ConcatTableValues( ShallowCopyTable(WeaponSets.HeroSecondaryWeapons), AddLinkedWeapons( WeaponSets.HeroSecondaryWeapons ))
	for _, weaponName in pairs( validWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	
	SetPlayerInvulnerable("BoonMenuOpen")
	--CurrentRun.Hero.ExclusiveOnHitFunctionName = "UpgradeChoiceRetaliate"
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })

	local components = screen.Components

	screen.SubjectName = upgradeName

	waitUnmodified(0.25)

	if components.ShopLighting ~= nil then
		SetColor({ Id = components.ShopLighting.Id, Color = source.LightingColor })
	end
	SetColor({ Id = components.ShopBackgroundGradient.Id, Color = source.LightingColor })

	ModifyTextBox({ Id = components.TitleText.Id, Text = source.MenuTitle })


	if CurrentRun.LootTypeHistory then
		RandomSynchronize( CurrentRun.LootTypeHistory[upgradeName] )
	else
		RandomSynchronize()
	end

	if source.FlavorTextIds ~= nil then
		local flavorText = GetRandomValue( source.FlavorTextIds )
		ModifyTextBox({ Id = components.FlavorText.Id, Text = flavorText})
	end
	
	screen.KeepOpen = true
	CreateBoonLootButtons( screen, source )
	
	-- Short delay to let animations finish and prevent accidental input
	waitUnmodified(0.5)

	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function CreateBoonLootButtons( screen, lootData, reroll )

	local components = screen.Components
	local upgradeName = lootData.Name
	local upgradeChoiceData = LootData[upgradeName]
	local upgradeOptions = lootData.UpgradeOptions
	if upgradeOptions == nil then
		SetTraitsOnLoot( lootData )
		upgradeOptions = lootData.UpgradeOptions
	end

	if not lootData.StackNum then
		lootData.StackNum = 1
	end
	if not reroll then
		lootData.StackNum = lootData.StackNum + GetTotalHeroTraitValue("PomLevelBonus")
	end
	local tooltipData = {}

	local firstOption = true

	if IsEmpty( upgradeOptions ) then
		table.insert(upgradeOptions, { ItemName = "FallbackGold", Rarity = "Common" })
	end

	local blockedIndexes = {}
	for i = 1, TableLength(upgradeOptions) do
		table.insert( blockedIndexes, i )
	end
	
	for i = 1, CalcNumLootChoices( lootData.GodLoot, lootData.TreatAsGodLootByShops ) do
		RemoveRandomValue( blockedIndexes )
	end
	
	screen.BlockedIndexes = blockedIndexes

	-- Sort traits in the following order: Melee, Secondary, Rush, Range
	table.sort(upgradeOptions, function (x, y)
		local slotToInt = function( slot )
			if slot ~= nil then
				local slotType = slot.Slot

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
				end
			end
			return 99
		end
		return slotToInt(TraitData[x.ItemName]) < slotToInt(TraitData[y.ItemName])
	end)

	local firstUnityBoon = GameState.Flags.SeenUnityBoons
	local firstUnityBoonId = nil

	screen.UpgradeButtons = {}
	for itemIndex, itemData in ipairs( upgradeOptions ) do
		local button = CreateUpgradeChoiceButton( screen, lootData, itemIndex, itemData )

		if firstOption then
			TeleportCursor({ DestinationId = button.Id, ForceUseCheck = true, })
			firstOption = false
		end
		if not firstUnityBoon and TraitData[itemData.ItemName] and TraitData[itemData.ItemName].IsElementalTrait then
			firstUnityBoon = true
			firstUnityBoonId = button.Id
			GameState.Flags.SeenUnityBoons = true
		end
		table.insert( screen.UpgradeButtons, button )
		-- stagger button animations
		waitUnmodified( 0.06 )
	end
	
	if not GameState.Flags.SeenElementalIcons and IsGameStateEligible( CurrentRun, TraitRarityData.ElementalGameStateRequirements ) then
		waitUnmodified(0.2)
		for itemIndex, itemData in ipairs( upgradeOptions ) do
			local elementIconKey = "PurchaseButton"..itemIndex.."ElementIcon"
			if components[elementIconKey] ~= nil then
				thread( ElementalIconsUnlockedPresentation, components[elementIconKey].Id )
				wait(0.4)
			end
		end
		OpenElementalPromptScreen( screen )
		GameState.Flags.SeenElementalIcons = true
	end

	if firstUnityBoon then
		thread( FirstUnityBoonPresentation, firstUnityBoonId )
	end

	if HeroHasTrait( "PanelRerollMetaUpgrade" ) then
		local cost = -1
		if lootData.BlockReroll then
			cost = -1
		elseif lootData.Name == "WeaponUpgrade" then
			cost = RerollCosts.Hammer
		else
			cost = RerollCosts.Boon
		end
		local baseCost = cost

		local name = "Boon_Reroll"
		local tooltip = "MetaUpgradeRerollHint"
		if cost >= 0 then

			local increment = 0
			if CurrentRun.CurrentRoom.SpentRerolls then
				increment = CurrentRun.CurrentRoom.SpentRerolls[lootData.ObjectId] or 0
			end
			cost = cost + increment
		else
			name = "RerollPanel_Blocked"
			tooltip = "MetaUpgradeRerollBlockedHint"
		end
		local color = Color.White
		if CurrentRun.NumRerolls < cost or cost < 0 then
			color = Color.CostUnaffordable
		end

		if CurrentRun.NumRerolls < cost or cost < 0 then
			SetAlpha({ Id = screen.Components.RerollButton.Id, Fraction = 0.0, Duration = 0.2 })
		elseif baseCost > 0 then
			components.RerollButton.OnPressedFunctionName = "AttemptPanelReroll"
			components.RerollButton.RerollFunctionName = "RerollBoonLoot"
			components.RerollButton.RerollColor = lootData.LootColor
			components.RerollButton.RerollId = lootData.ObjectId
			components.RerollButton.LootData = lootData
			components.RerollButton.Cost = cost
			ModifyTextBox({ Id = components.RerollButton.Id, Text = name, LuaKey = "TempTextData", LuaValue = { Amount = cost }})

			SetAlpha({ Id = screen.Components.RerollButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = screen.Components.RerollButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
	end
end

function CreateUpgradeChoiceButton( screen, lootData, itemIndex, itemData )
	local components = screen.Components
	local upgradeName = lootData.Name
	local upgradeChoiceData = lootData
	local itemLocationY = (ScreenCenterY - 190) + screen.ButtonSpacingY * ( itemIndex - 1 )
	local itemLocationX = ScreenCenterX - 355
	local blockedIndexes = screen.BlockedIndexes
	local upgradeData = nil
	local upgradeTitle = nil
	local upgradeDescription = nil
	local upgradeDescription2 = nil
	local tooltipData = nil
	upgradeData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, Rarity = itemData.Rarity })
	local traitNum = GetTraitCount(CurrentRun.Hero, { TraitData = upgradeData })
	if HeroHasTrait(itemData.ItemName) and not TraitData[itemData.ItemName].Hidden then
		upgradeTitle = "TraitLevel_Upgrade"
		upgradeData.Title = upgradeData.Name
	else
		upgradeTitle = GetTraitTooltipTitle( TraitData[itemData.ItemName] )
		upgradeData.Title = GetTraitTooltipTitle( TraitData[itemData.ItemName] )
	end

	if itemData.TraitToReplace ~= nil then
		upgradeData.TraitToReplace = itemData.TraitToReplace
		upgradeData.OldRarity = itemData.OldRarity
		local existingNum = GetTraitCount( CurrentRun.Hero, { Name = upgradeData.TraitToReplace } )
		local newNum = existingNum + GetTotalHeroTraitValue("ExchangeLevelBonus") 
		tooltipData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, StackNum = newNum, RarityMultiplier = upgradeData.RarityMultiplier})
		if newNum > 1 then
			upgradeTitle = "TraitLevel_Exchange"
			tooltipData.Title = GetTraitTooltipTitle( TraitData[upgradeData.Name])
			tooltipData.Level = newNum
		end
		SetTraitTextData( tooltipData )
	elseif lootData.StackOnly and upgradeData.Name ~= "FallbackGold" then
		tooltipData = GetHeroTrait( upgradeData.Name )
		local startingStackNum = tooltipData.StackNum or 1
		tooltipData.OldLevel = startingStackNum
		tooltipData.NewLevel = startingStackNum + lootData.StackNum
		local stackTooltipData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, StackNum = startingStackNum + lootData.StackNum, RarityMultiplier = tooltipData.RarityMultiplier})
		SetTraitTextData( tooltipData, { ReplacementTraitData = stackTooltipData })
		itemData.Rarity = tooltipData.Rarity
	elseif itemData.Type == "TransformingTrait" then
		local blessingData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, Rarity = itemData.Rarity })
		local curseData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.SecondaryItemName, Rarity = itemData.Rarity })
		curseData.OnExpire = curseData.OnExpire or {}
		curseData.OnExpire.TraitData = blessingData
		
		curseData.TraitTitle = "ChaosCombo_"..curseData.Name.."_"..blessingData.Name
		--blessingData.Title = "ChaosBlessingFormat"

		SetTraitTextData( blessingData )
		SetTraitTextData( curseData )

		tooltipData = MergeTables( tooltipData, blessingData )
		tooltipData = MergeTables( tooltipData, curseData )
		tooltipData.Blessing = itemData.ItemName
		tooltipData.Curse = itemData.SecondaryItemName

		upgradeTitle = curseData.TraitTitle
		upgradeDescription = curseData.Name
		upgradeDescription2 = blessingData.Name
		upgradeData = DeepCopyTable( curseData )
		upgradeData.Icon = blessingData.Icon
		upgradeData.ExtractData = upgradeData.ExtractData or {}
		local extractedData = GetExtractData( blessingData )
		for i, value in pairs(extractedData) do
			local key = value.ExtractAs
			if key then
				upgradeData.ExtractData[key] = blessingData[key]
			end
		end
	else
		if upgradeData.PrePickSacrificeBoon then
			upgradeData.SacrificedTraitName = GetRandomSacrificeTraitData().Name
		end
		tooltipData = upgradeData
		SetTraitTextData( tooltipData )
	end
	if not upgradeDescription2 then
		upgradeDescription = GetTraitTooltip( tooltipData , { Default = upgradeData.Title })
	end

	-- Setting button graphic based on boon type
	local purchaseButtonKey = "PurchaseButton"..itemIndex

	local overlayLayer = "Combat_Menu_Overlay_Backing"

	local purchaseButton = ShallowCopyTable( screen.PurchaseButton )
	purchaseButton.X = itemLocationX + screen.ButtonOffsetX
	purchaseButton.Y = itemLocationY
	--DebugPrint({ Text = "upgradeData.Rarity = "..upgradeData.Rarity })
	local backingAnim = upgradeData.UpgradeChoiceBackingAnimation or screen.RarityBackingAnimations[upgradeData.Rarity]
	if backingAnim ~= nil then
		--DebugPrint({ Text = "backingAnim = "..backingAnim })
		purchaseButton.Animation = backingAnim
	end
	components[purchaseButtonKey] = CreateScreenComponent( purchaseButton )
	components[purchaseButtonKey].BackingAnim = backingAnim
	
	if itemData.SlotEntranceAnimation ~= nil then
		CreateAnimation({ Name = itemData.SlotEntranceAnimation, DestinationId = components[purchaseButtonKey].Id })
	elseif upgradeData.Rarity == "Legendary" or upgradeData.Rarity == "Duo" then
		if TraitData[upgradeData.Name].IsDuoBoon then
			CreateAnimation({ Name = "BoonEntranceDuo", DestinationId = components[purchaseButtonKey].Id })
		else
			CreateAnimation({ Name = "BoonEntranceLegendary", DestinationId = components[purchaseButtonKey].Id }) 
		end
	end
	if Contains( blockedIndexes, itemIndex ) then
		itemData.Blocked = true
		overlayLayer = "Combat_Menu"
		AddInteractBlock( components[purchaseButtonKey], "TraitLocked" )
		ModifyTextBox({ Id = components[purchaseButtonKey].Id, BlockTooltip = true })
		thread( TraitLockedPresentation, { Screen = screen, Components = components, HighlightKey = purchaseButtonKey.."Highlight", Id = purchaseButtonKey, OffsetX = itemLocationX + screen.ButtonOffsetX + 15, OffsetY = screen.IconOffsetY + itemLocationY + 55, TooltipOffsetX = screen.TooltipOffsetX } )
	end

	local highlight = ShallowCopyTable( screen.Highlight )
	highlight.X = purchaseButton.X
	highlight.Y = purchaseButton.Y
	components[purchaseButtonKey.."Highlight"] = CreateScreenComponent( highlight )

	if upgradeData.Icon ~= nil then
		local icon = screen.Icon
		icon.X = screen.IconOffsetX + itemLocationX + screen.ButtonOffsetX
		icon.Y = screen.IconOffsetY + itemLocationY
		icon.Animation = upgradeData.Icon
		components[purchaseButtonKey.."Icon"] = CreateScreenComponent( icon )
	end

	if upgradeData.TraitToReplace ~= nil then

		screen.TraitToReplaceName = upgradeData.TraitToReplace

		local exchangeSymbol = screen.ExchangeSymbol
		components[purchaseButtonKey.."ExchangeSymbol"] = CreateScreenComponent( exchangeSymbol )
		Attach({ Id = components[purchaseButtonKey.."ExchangeSymbol"].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = exchangeSymbol.OffsetX, OffsetY = exchangeSymbol.OffsetY })
		
		components[purchaseButtonKey.."ExchangeIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = overlayLayer, Scale = screen.Icon.Scale * screen.ExchangeIconScale })
		Attach({ Id = components[purchaseButtonKey.."ExchangeIcon"].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.ExchangeIconOffsetX, OffsetY = screen.ExchangeIconOffsetY })
		SetAnimation({ DestinationId = components[purchaseButtonKey.."ExchangeIcon"].Id, Name = TraitData[upgradeData.TraitToReplace].Icon })

		components[purchaseButtonKey.."ExchangeIconFrame"] = CreateScreenComponent({ Name = "BlankObstacle", Group = overlayLayer, Scale = screen.Icon.Scale * screen.ExchangeIconScale })		
		Attach({ Id = components[purchaseButtonKey.."ExchangeIconFrame"].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.ExchangeIconOffsetX, OffsetY = screen.ExchangeIconOffsetY })
		SetAnimation({ DestinationId = components[purchaseButtonKey.."ExchangeIconFrame"].Id, Name = "BoonIcon_Frame_".. itemData.OldRarity })

		Flash({ Id = components[purchaseButtonKey.."ExchangeIcon"].Id, Speed = screen.ExchangeFlashSpeed, MinFraction = screen.ExchangeFlashMinFraction, MaxFraction = screen.ExchangeFlashMaxFraction, Color = screen.ExchangeFlashColor })
		Flash({ Id = components[purchaseButtonKey.."ExchangeIconFrame"].Id, Speed = screen.ExchangeFlashSpeed, MinFraction = screen.ExchangeFlashMinFraction, MaxFraction = screen.ExchangeFlashMaxFraction, Color = screen.ExchangeFlashColor })
		-- Flash({ Id = components[purchaseButtonKey.."ExchangeSymbol"].Id, Speed = screen.ExchangeFlashSpeed, MinFraction = screen.ExchangeFlashMinFraction, MaxFraction = screen.ExchangeFlashMaxFraction, Color = screen.ExchangeFlashColor })

		-- Hidden description for tooltip
		CreateTextBox({ Id = components[purchaseButtonKey].Id,
			Text = "WillReplace",
			Color = Color.Transparent,
			LuaKey = "PurchaseTraitData",
			LuaValue = upgradeData,
		})

	end

	local frame = screen.Frame
	frame.X = screen.IconOffsetX + itemLocationX + screen.ButtonOffsetX
	frame.Y = screen.IconOffsetY + itemLocationY
	frame.Animation = GetTraitFrame( upgradeData )
	components[purchaseButtonKey.."Frame"] = CreateScreenComponent( frame )

	-- Button data setup
	local button = components[purchaseButtonKey]
	button.OnPressedFunctionName = "HandleUpgradeChoiceSelection"
	button.OnMouseOverFunctionName = "MouseOverBoonButton"
	button.OnMouseOffFunctionName = "MouseOffBoonButton"
	button.Data = upgradeData
	button.Screen = screen
	button.UpgradeName = upgradeName
	button.Type = itemData.Type
	button.LootData = lootData
	button.LootColor = upgradeChoiceData.LootColor
	button.BoonGetColor = upgradeChoiceData.BoonGetColor
	button.Highlight = components[purchaseButtonKey.."Highlight"]
	
	AttachLua({ Id = components[purchaseButtonKey].Id, Table = components[purchaseButtonKey] })
	components[components[purchaseButtonKey].Id] = purchaseButtonKey
	-- Creates upgrade slot text
	SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = screen.TooltipOffsetX })
	local selectionString = "UpgradeChoiceMenu_PermanentItem"
	local selectionStringColor = Color.Black

		local traitData = TraitData[itemData.ItemName]
		if traitData.Slot ~= nil then
			selectionString = "UpgradeChoiceMenu_"..traitData.Slot
		end

	local textOffset = -70 - screen.ButtonOffsetX
	local exchangeIconOffset = 0
	local lineSpacing = 8
	local rarity = itemData.Rarity
	if not rarity then
		rarity = "Common"
	end
	local text = "Boon_"..rarity
	local overlayLayer = ""
	if upgradeData.CustomRarityName then
		text = upgradeData.CustomRarityName
	end
	local color = Color["BoonPatch" .. rarity]
	if upgradeData.CustomRarityColor then
		color = upgradeData.CustomRarityColor
	end

	local rarityText = ShallowCopyTable( screen.RarityText )
	rarityText.Id = button.Id
	rarityText.Text = text
	rarityText.Color = color
	CreateTextBox( rarityText )

	local titleText = ShallowCopyTable( screen.TitleText )
	titleText.Id = button.Id
	titleText.Text = upgradeTitle
	titleText.Color = color
	titleText.LuaValue = tooltipData
	CreateTextBox( titleText )

	local descriptionText = ShallowCopyTable( screen.DescriptionText )
	descriptionText.Id = button.Id
	descriptionText.Text = upgradeDescription
	descriptionText.LuaValue = tooltipData
	CreateTextBoxWithFormat( descriptionText )

	if upgradeDescription2 then
		local descriptionText2 = ShallowCopyTable( screen.DescriptionText )
		descriptionText2.Id = button.Id
		descriptionText2.Text = upgradeDescription2
		descriptionText2.LuaValue = tooltipData
		descriptionText2.OffsetY = offsetY
		descriptionText2.AppendToId = descriptionText.Id
		CreateTextBoxWithFormat( descriptionText2 )
	end

	if traitData.StatLines ~= nil then
		local appendToId = nil
		if #traitData.StatLines <= 1 then
			appendToId = descriptionText.Id
		end
		for lineNum, statLine in ipairs( traitData.StatLines ) do
			if statLine ~= "" then

				local offsetY = (lineNum - 1) * screen.LineHeight
				if upgradeData.ExtraDescriptionLine then
					offsetY = offsetY + screen.LineHeight
				end

				local statLineLeft = ShallowCopyTable( screen.StatLineLeft )
				statLineLeft.Id = button.Id
				statLineLeft.Text = statLine
				statLineLeft.OffsetY = offsetY
				statLineLeft.AppendToId = appendToId
				statLineLeft.LuaValue = tooltipData
				CreateTextBoxWithFormat( statLineLeft )

				local statLineRight = ShallowCopyTable( screen.StatLineRight )
				statLineRight.Id = button.Id
				statLineRight.Text = statLine
				statLineRight.OffsetY = offsetY
				statLineRight.AppendToId = appendToId
				statLineRight.LuaValue = tooltipData
				CreateTextBoxWithFormat( statLineRight )

			end
		end
	end

	if traitData.FlavorText ~= nil then
		local flavorText = ShallowCopyTable( screen.FlavorText )
		flavorText.Id = button.Id
		flavorText.Text = traitData.FlavorText
		CreateTextBox( flavorText )
	end

	local needsQuestIcon = false
	if not GameState.TraitsTaken[upgradeData.Name] and HasActiveQuestForName( upgradeData.Name ) then
		needsQuestIcon = true
	elseif itemData.ItemName ~= nil and not GameState.TraitsTaken[itemData.ItemName] and HasActiveQuestForName( itemData.ItemName ) then
		needsQuestIcon = true
	end

	if needsQuestIcon then
		components[purchaseButtonKey.."QuestIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX + screen.QuestIconOffsetX, Y = itemLocationY + screen.QuestIconOffsetY })
		SetAnimation({ DestinationId = components[purchaseButtonKey.."QuestIcon"].Id, Name = "QuestItemFound" })
		-- Silent toolip
		CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "TraitQuestItem", Color = Color.Transparent, LuaKey = "TooltipData", LuaValue = tooltipData, })
	end

	if not IsEmpty( upgradeData.Elements ) then
		local elementName = GetFirstValue( upgradeData.Elements )
		local elementIcon = screen.ElementIcon
		elementIcon.Name = TraitElementData[elementName].Icon
		elementIcon.X = itemLocationX + elementIcon.XShift
		elementIcon.Y = itemLocationY + elementIcon.YShift
		components[purchaseButtonKey.."ElementIcon"] = CreateScreenComponent( elementIcon )
		if not GameState.Flags.SeenElementalIcons then
			SetAlpha({ Id = components[purchaseButtonKey.."ElementIcon"].Id, Fraction = 0, Duration = 0 })
		end
	end
	return components[purchaseButtonKey]
end

function DestroyBoonLootButtons( screen, lootData )
	local components = screen.Components
	local toDestroy = {}
	for index = 1, 3 do
		local destroyIndexes = {
		"PurchaseButton"..index,
		"PurchaseButton"..index.. "Lock",
		"PurchaseButton"..index.. "Highlight",
		"PurchaseButton"..index.. "Icon",
		"PurchaseButton"..index.. "ExchangeIcon",
		"PurchaseButton"..index.. "ExchangeIconFrame",
		"PurchaseButton"..index.. "QuestIcon",
		"PurchaseButton"..index.. "ElementIcon",
		"Backing"..index,
		"PurchaseButton"..index.. "Frame",
		"PurchaseButton"..index.. "Patch",
		}
		for i, indexName in pairs( destroyIndexes ) do
			if components[indexName] then
				table.insert(toDestroy, components[indexName].Id)
				components[indexName] = nil
			end
		end
	end
	Destroy({ Ids = toDestroy })
end

function RerollBoonLoot( screen, button )	
	local lootData = button.LootData
	DestroyBoonLootButtons( screen, lootData )
	local itemNames = {}
	for i, value in pairs( lootData.UpgradeOptions ) do
		table.insert( itemNames, value.ItemName )
	end
	SetTraitsOnLoot( lootData, { ExclusionNames = { GetRandomValue( itemNames )}})
	CreateBoonLootButtons( screen, lootData, true )
end

function GetRarityValue( rarity )
	local rarityOrdering = TraitRarityData.RarityValues
	return rarityOrdering[rarity] or 1
end

function GetRarityKey( index, customTable )
	local rarityTable = customTable or TraitRarityData.RarityUpgradeOrder
	return rarityTable[index]
end

function GetUpgradedRarity( baseRarity, rarityUpgradeOrder )
	local rarityTable = rarityUpgradeOrder or TraitRarityData.RarityUpgradeOrder
	baseRarity = baseRarity or "Common"
	if HasHeroTraitValue("ReplaceUpgradedRarityTable") then
		rarityTable = GetHeroTraitValues("ReplaceUpgradedRarityTable")[1]
	end
	local key = GetKey( rarityTable, baseRarity )
	if key and rarityTable[key + 1] then
		return rarityTable[key + 1]
	end
end

function GetDowngradedRarity( baseRarity )
	local rarityTable = TraitRarityData.RarityUpgradeOrder

	if HasHeroTraitValue("ReplaceUpgradedRarityTable") then
		rarityTable = GetHeroTraitValues("ReplaceUpgradedRarityTable")[1]
	end
	local key = GetKey( rarityTable, baseRarity )
	if key and rarityTable[key - 1] then
		return rarityTable[key - 1]
	end
end

function GetPriorityTraits( traitNames, lootData, args )
	if traitNames == nil then
		return {}
	end
	args = args or {}

	local priorityOptions = {}
	local heroHasPriorityTrait = false
	local occupiedSlots = {}
	local guaranteedSlots = {"Melee", "Secondary"} 
	local traitsWithGuaranteedSlot = {}

	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot then
			occupiedSlots[traitData.Slot] = true
		end
	end

	for index, traitName in ipairs(traitNames) do

		if TraitData[traitName] and (lootData.StripRequirements or IsTraitEligible(CurrentRun, TraitData[traitName])) then
			if not HeroHasTrait(traitName) and not occupiedSlots[TraitData[traitName].Slot] then
				local data = { ItemName = traitName, Type = "Trait"}
				table.insert(priorityOptions, data)
				if Contains(guaranteedSlots, TraitData[traitName].Slot) then
					table.insert(traitsWithGuaranteedSlot, traitName)
				end
			else
				heroHasPriorityTrait = true
			end
		end
	end

	if heroHasPriorityTrait then
		return { GetRandomValue(priorityOptions) }
	end
	while TableLength( priorityOptions ) > GetTotalLootChoices() do
		RemoveRandomValue( priorityOptions )
		priorityOptions = CollapseTable( priorityOptions )
	end
	local hasGuarantee = false
	if IsEmpty(traitsWithGuaranteedSlot)  then
		hasGuarantee = true
	end
	
	for i, option in pairs(priorityOptions) do
		if Contains(guaranteedSlots, TraitData[option.ItemName].Slot) then
			hasGuarantee = true
		end
	end
	if not hasGuarantee then
		priorityOptions[1].ItemName = GetRandomValue( traitsWithGuaranteedSlot )
	end
	return priorityOptions
end

function GetReplacementTraits( traitNames, onlyFromLootName )
	if traitNames == nil then
		return {}
	end

	local priorityOptions = {}
	local occupiedSlots = {}

	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot then
			if not occupiedSlots[traitData.Slot] then
				occupiedSlots[traitData.Slot] = { TraitName = traitData.Name, Rarity = "Common" }
			end
			if  traitData.Rarity ~= nil and GetRarityValue( traitData.Rarity ) > GetRarityValue( occupiedSlots[traitData.Slot].Rarity ) then
				occupiedSlots[traitData.Slot].Rarity = traitData.Rarity
			end
		end
	end

	for index, traitName in ipairs(traitNames) do
		local slot = TraitData[traitName].Slot
		if IsTraitEligible( CurrentRun, TraitData[traitName] ) and not HeroHasTrait(traitName) and occupiedSlots[slot] and GetUpgradedRarity(occupiedSlots[slot].Rarity) ~= nil and ( onlyFromLootName == nil or LootData[onlyFromLootName].TraitIndex[occupiedSlots[slot].TraitName] ) then
			local data = { ItemName = traitName, Type = "Trait", TraitToReplace = occupiedSlots[slot].TraitName, OldRarity = occupiedSlots[slot].Rarity, Rarity = GetUpgradedRarity(occupiedSlots[slot].Rarity) }
			table.insert(priorityOptions, data)
		end
	end
	return { GetRandomValue(priorityOptions) }
end

function GetEligibleWeaponTraits( traitNames )
	if not traitNames then 
		return 
	end
	local ineligibleTraits = {}

	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		local traitSlot = traitData.Slot
		if traitSlot  ~= nil then
			-- If the traits overlap type and aren't the same name then that slot is taken
			for s, possibleTraitName in pairs( traitNames ) do
				local possibleTraitData = TraitData[possibleTraitName]
				if possibleTraitData ~= nil and traitSlot == possibleTraitData.Slot then
					table.insert(ineligibleTraits, possibleTraitName)
				end
			end
		end
	end

	local eligibleTraits = {}
	if traitNames ~= nil then
	for i, traitName in pairs(traitNames) do
		if not Contains(ineligibleTraits, traitName) then
			table.insert(eligibleTraits, traitName)
		end
	end
	end

	return eligibleTraits
end

function GetPriorityDependentTraits ( lootData )
	if not lootData.Traits then	
		return
	end

	local linkedTraits = {}
	local orderedLinkedUpgrades = CollapseTableAsOrderedKeyValuePairs( lootData.Traits )
	for i, kvp in ipairs( orderedLinkedUpgrades ) do
		local traitName = kvp.Value

		local dependencyTable = TraitRequirements[traitName]
		local valid = false
		if dependencyTable and not HeroHasTrait( traitName ) and ( IsTraitEligible( CurrentRun, TraitData[traitName]) or lootData.StripRequirements ) then
			if dependencyTable.OneOf ~= nil then
				for j, dependentTraitName in ipairs(dependencyTable.OneOf) do
					if not valid and HeroHasTrait(dependentTraitName) then
						valid = true
					end
				end
			end
			

			if dependencyTable.TwoOf ~= nil then
				local numTraits = 0
				for j, dependentTraitName in ipairs(dependencyTable.TwoOf) do
					if HeroHasTrait(dependentTraitName) then
						numTraits = numTraits + 1
					end
				end
				if numTraits >= 2 then
					valid = true
				end
			end

			if not valid and dependencyTable.OneFromEachSet ~= nil then
				valid = true
				for i, traitSet in ipairs(dependencyTable.OneFromEachSet) do
					local foundInSet = false
					for j, dependentTraitName in ipairs(dependencyTable.OneFromEachSet[i]) do
						if not foundInSet and HeroHasTrait(dependentTraitName) then
							foundInSet = true
						end
					end
					if not foundInSet then
						valid = false
						break
					end
				end
			end

			if valid and dependencyTable.PriorityChance ~= nil then
				table.insert( linkedTraits, { TraitName = traitName, PriorityChance = dependencyTable.PriorityChance })
			end
		end
	end

	return linkedTraits
end
function GetEligibleTraitUpgrades ( lootData )
	local eligibleTraits = {}
	local linkedTraits = {}
	local orderedUpgrades = CollapseTableAsOrderedKeyValuePairs( lootData.Traits )
	for i, kvp in ipairs( orderedUpgrades) do
		local traitName = kvp.Value
		local valid = false
		if not TraitRequirements[traitName] then
			valid = true
		elseif IsTraitEligible( CurrentRun, TraitData[traitName]) or lootData.StripRequirements then
			local dependencyTable = TraitRequirements[traitName]
			if dependencyTable.OneOf ~= nil then
				for j, dependentTraitName in ipairs(dependencyTable.OneOf) do
					if not valid and HeroHasTrait(dependentTraitName) then
						valid = true
					end
				end
			end

			if dependencyTable.TwoOf ~= nil then
				local numTraits = 0
				for j, dependentTraitName in ipairs(dependencyTable.TwoOf) do
					if HeroHasTrait(dependentTraitName) then
						numTraits = numTraits + 1
					end
				end
				if numTraits >= 2 then
					valid = true
				end
			end

			if not valid and dependencyTable.OneFromEachSet ~= nil then
				valid = true
				for i, traitSet in ipairs(dependencyTable.OneFromEachSet) do
					local foundInSet = false
					for j, dependentTraitName in ipairs(dependencyTable.OneFromEachSet[i]) do
						if not foundInSet and HeroHasTrait(dependentTraitName) then
							foundInSet = true
						end
					end
					if not foundInSet then
						valid = false
						break
					end
				end

			end
		end

		if valid then
			table.insert( linkedTraits, traitName )
		end
	end
	if not IsEmpty(lootData.OffersElementalTrait) then
		for _, elementName in pairs( lootData.OffersElementalTrait ) do
			if IsGameStateEligible( CurrentRun, TraitElementData[elementName].GameStateRequirements ) then
				local orderedElementalUpgrades = CollapseTableAsOrderedKeyValuePairs( TraitElementData[elementName].Traits )
				for i, kvp in ipairs( orderedElementalUpgrades ) do
					local traitName = kvp.Value
					table.insert( linkedTraits, traitName )
				end
			end
		end
	end

	return CombineTablesIPairs(eligibleTraits, linkedTraits )
end

function GetEligibleUpgrades( upgradeOptions, lootData, upgradeChoiceData )
	local eligibleUpgrades = {}

	if lootData.StackOnly then
		local upgradeableGodTraitsKVPs = CollapseTableAsOrderedKeyValuePairs(GetAllUpgradeableGodTraits( lootData.StackNum ))
		for i, kvp in ipairs( upgradeableGodTraitsKVPs ) do
			local traitName = kvp.Key
			table.insert(eligibleUpgrades, { ItemName = traitName, Type = "Trait"})
		end
	else
		if upgradeChoiceData.WeaponUpgrades then 
			local eligibleWeaponUpgrades = GetEligibleWeaponTraits(upgradeChoiceData.WeaponUpgrades)
			for i, traitName in pairs(eligibleWeaponUpgrades) do
				table.insert(eligibleUpgrades, { ItemName = traitName, Type = "Trait"})
			end
		end

		local eligibleTraitUpgrades = GetEligibleTraitUpgrades(upgradeChoiceData) or {}

		for i, traitName in ipairs(eligibleTraitUpgrades) do
			table.insert(eligibleUpgrades, { ItemName = traitName, Type = "Trait"})
		end
	end

	local toRemove = {}
	for i, upgradeData in ipairs(eligibleUpgrades) do
		local data = nil
			data = TraitData[upgradeData.ItemName]

		if not lootData.StackOnly and HeroHasTrait(upgradeData.ItemName) then
			table.insert(toRemove, upgradeData)
		elseif not lootData.StripRequirements and lootData.StackOnly and not IsTraitEligible(CurrentRun, data) then
			table.insert(toRemove, upgradeData)
		elseif not lootData.StripRequirements and not IsTraitEligible(CurrentRun, data) then
			table.insert(toRemove, upgradeData)
		end
	end

	for i, value in ipairs(toRemove) do
		RemoveValue(eligibleUpgrades, value )
	end
	eligibleUpgrades = CollapseTableOrdered(eligibleUpgrades)
	return eligibleUpgrades
end

function HandleUpgradeChoiceSelection( screen, button, args )
	local buttonId = button.Id
	local upgradeData = button.Data
	local currentRun = CurrentRun
	args = args or {}

	screen.ChoiceMade = true
	
	currentRun.CurrentRoom.ReplacedTraitSource = nil

	-- handle trait
	local newTrait = nil
	if upgradeData.TraitToReplace then
		local numOldTrait = CurrentRun.Hero.TraitDictionary[upgradeData.TraitToReplace][1].StackNum or 1
		numOldTrait = numOldTrait + GetTotalHeroTraitValue("ExchangeLevelBonus")
		RemoveWeaponTrait( upgradeData.TraitToReplace )
		newTrait = AddTraitToHero({ TraitData = upgradeData, FromLoot = true })
		IncreaseTraitLevel( upgradeData, numOldTrait - 1 )
		currentRun.CurrentRoom.ReplacedTraitSource = GetLootSourceName(upgradeData.TraitToReplace)
	else
		if button.LootData.StackOnly and upgradeData.Name ~= "FallbackGold" then
			local traitData = CurrentRun.Hero.TraitDictionary[upgradeData.Name][1]
			if traitData then
				IncreaseTraitLevel( traitData, button.LootData.StackNum )
			end
		else
			if button.LootData.UpgradeOnPick then
				local newButton = TryUpgradeBoon( button.LootData, screen, button )
				if newButton then
					upgradeData = newButton.Data
					waitUnmodified(0.8)
				end
			end
			newTrait = AddTraitToHero({ TraitData = upgradeData, PreProcessedForDisplay = true, FromLoot = true })
		end
	end
	if button.LootData.BanUnpickedBoonsEligible and not args.DoubleBoonChance then
		local numBans = MetaUpgradeData.BanUnpickedBoonsShrineUpgrade.ChangeValue
		if numBans >= 1 then
			local banCount = 0
			for index, otherUpgradeButton in ipairs( screen.UpgradeButtons ) do
				if otherUpgradeButton.Data.Name ~= upgradeData.Name then
					CurrentRun.BannedTraits[otherUpgradeButton.Data.Name] = true
					thread( BanUnpickedBoonPresentation, screen, otherUpgradeButton )
					banCount = banCount + 1
					if banCount >= numBans then
						break
					end
				end
			end
		end
	end
	LogUpgradeChoice( button )
	PlaySound({ Name = button.LootData.UpgradeSelectedSound or "/SFX/HeatRewardDrop", Id = buttonId })
	CreateAnimation({ Name = "BoonGetBlack", DestinationId = buttonId, Scale = 1.0, GroupName = "Combat_Menu" })
	CreateAnimation({ Name = "BoonGet", DestinationId = buttonId, Scale = 1.0, GroupName = "Combat_Menu_Additive", Color = button.BoonGetColor or button.LootColor })
	--wait( 0.4, RoomThreadName )
	local doubleBoonTrait = HasHeroTraitValue("DoubleBoonChance")
	if doubleBoonTrait and doubleBoonTrait.Uses > 0 and ( button.LootData.GodLoot or button.LootData.TreatAsGodLootByShops) and not button.LootData.BlockDoubleBoon and RandomChance(doubleBoonTrait.DoubleBoonChance) then
		local validOtherChoices = {}
		for i, lootbutton in pairs( screen.UpgradeButtons ) do
			if lootbutton ~= button and not lootbutton.Data.TraitToReplace then
				table.insert( validOtherChoices, lootbutton )
			end
		end
		if not IsEmpty( validOtherChoices ) then
			waitUnmodified(0.8)
			local nextButton = GetRandomValue( validOtherChoices )
			ReduceTraitUses( doubleBoonTrait )
			DoubleBoonPresentation( screen, nextButton )
			HandleUpgradeChoiceSelection( screen, nextButton, { DoubleBoonChance = true } )
			return
		end
	end
	local source = screen.Source
	local spawnTarget = nil
	local duplicateOnClose = false
	local name = source.Name
	if source.CanDuplicate and RandomChance( GetTotalHeroTraitValue("DoubleRewardChance")) then
		duplicateOnClose = true
		spawnTarget = SpawnObstacle({ Name = "InvisibleTarget", Group = "Standing", DestinationId = source.ObjectId })
	end
	if source.DestroyOnPickup then
		Destroy({ Id = source.ObjectId })
		RemoveScreenEdgeIndicator( source )
	end
	MapState.RoomRequiredObjects[source.ObjectId] = nil
	if source.LastRewardEligible then
		CurrentRun.LastReward = { Type = "Boon", Name = source.Name, DisplayName = source.Name }
	end

	CloseUpgradeChoiceScreen( screen, button )
	IncrementTableValue( GameState.LootPickups, button.UpgradeName )
	CheckCodexUnlock( "OlympianGods", button.UpgradeName )
	CheckCodexUnlock( "ChthonicGods", button.UpgradeName )
	CheckCodexUnlock( "Items", button.UpgradeName )
	if not screen.SkipUpgradePresentationAndExitUnlock then
		UpgradeAcquiredPresentation( screen, button.LootData )
	end
	if duplicateOnClose and spawnTarget then
		local newLoot = CreateLoot({ Name = name, SpawnPoint = spawnTarget })
		newLoot.CanDuplicate = false
		thread( DoubleRewardPresentation, newLoot.ObjectId )
		Destroy({ Id = spawnTarget })
	end
	if not screen.SkipUpgradePresentationAndExitUnlock then
		waitUnmodified( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end
	end

	CheckNewTraitManaReserveShrineUpgrade( newTrait )

	SetLightBarColor({ PlayerIndex = 1, Color = CurrentRun.Hero.LightBarColor or { 0.0, 0.0, 0.0, 0.0 } })

end

function CloseUpgradeChoiceScreen( screen, button )
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	if screen.Components.ShopBackground ~= nil then
		SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = "BoonSelectMelOut" })
	end
	if screen.Components.ShopLighting ~= nil then
		SetAnimation({ DestinationId = screen.Components.ShopLighting.Id, Name = "BoonSelectFxOut" })
	end
	for index = 1, 3 do
		if screen.Components["PurchaseButton"..index] then
			SetAnimation({ DestinationId = screen.Components["PurchaseButton"..index].Id, Name = "BoonSlotOut" })
		end
	end

	local useableOffButtonIds = {}
	for index = 1, 3 do
		if screen.Components["PurchaseButton"..index] and screen.Components["PurchaseButton"..index].Id then
			table.insert(useableOffButtonIds, screen.Components["PurchaseButton"..index].Id)
		end
	end
	UseableOff({ Ids = useableOffButtonIds, ForceHighlightOff = true })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.25 )
	AltAspectRatioFramesHide()
	if not button.LootData.SelectionSound then
		PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	else
		PlaySound({ Name = button.LootData.SelectionSound })
	end
	local validWeapons = ConcatTableValues( ShallowCopyTable(WeaponSets.HeroSecondaryWeapons), AddLinkedWeapons( WeaponSets.HeroSecondaryWeapons ))
	for _, weaponName in pairs( validWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true  })
	end
	if screen.MovedRerollUIGroup then
		screen.MovedRerollUIGroup = nil
		RemoveFromGroup({ Id = ScreenAnchors.Reroll, Names = { "Combat_Menu_Overlay" } })
		AddToGroup({ Id = ScreenAnchors.Reroll, Name = "Combat_UI", DrawGroup = true })
	end
	SetPlayerVulnerable( "BoonMenuOpen" )
	CurrentRun.Hero.ExclusiveOnHitFunctionName = nil
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name, { SkipUpdateTraitSummary = true } )

	NotifyResultsTable[ UIData.BoonMenuId ] = screen.SubjectName
	notifyExistingWaiters( UIData.BoonMenuId )
	CheckObjectiveSet( "AdvancedTooltipPrompt" )
	if screen.Source.ForceCommon and not screen.Source.ForceCommonWithoutCurse then
		UseHeroTraitsWithValue( "ForceCommon", true )
	end

	if screen.Source.GodLoot or screen.Source.TreatAsGodLootByShops then
		UseHeroTraitsWithValue( "RestrictBoonChoices", true )
	end
	if screen.Source.UseSwapTrait then
		local forceSwapTrait = HasHeroTraitValue("ForceSwaps")
		if forceSwapTrait then
			forceSwapTrait.Uses = forceSwapTrait.Uses - 1
			UpdateTraitNumber( forceSwapTrait )
		end
	end
	if not IsEmpty(LootObjects)  then
		for itemId, item in pairs( LootObjects ) do
			if IsAlive({ Id = itemId }) then
				if not IsRarityForcedCommon( item.Name ) then
					RandomSynchronize()
					item.RarityChances = GetRarityChances( item )
				end
				item.UpgradeOptions = nil
			end
		end
	end
	ScreenAnchors.ChoiceScreen = nil
end


function LogUpgradeChoice( button )
	if CurrentRun == nil then
		return
	end
	if CurrentRun.LootChoiceHistory == nil then
		CurrentRun.LootChoiceHistory = {}
	end

	local depth = 0
	if not IsEmpty(CurrentRun.RoomHistory) then
		depth = TableLength(CurrentRun.RoomHistory)
	end

	local data =
	{
		Depth = depth,
		UpgradeName = button.LootData.Name,
		UpgradeChoices = {}
	}

	if button.LootData.UpgradeOptions == nil then
		return
	end

	for i, upgradeData in pairs(button.LootData.UpgradeOptions) do
		if not upgradeData.Blocked then
			local choiceData =
			{
				Chosen = tostring( upgradeData.ItemName == button.Data.Name ),
				Name = tostring(upgradeData.ItemName),
				Rarity = tostring(upgradeData.Rarity),
			}
			if upgradeData.TraitToReplace ~= nil then
				choiceData.TraitToReplace = upgradeData.TraitToReplace
				choiceData.OldRarity = upgradeData.OldRarity
			end
			table.insert( data.UpgradeChoices, choiceData )
		end
	end

	table.insert( CurrentRun.LootChoiceHistory, data )
end

function UpgradeMouseOverUpgradeChoice( screen, button )
	if screen.MouseOverButton == nil then
		return
	end
	if screen.UpgradedRarity then
		return
	end
	local lootData = screen.Source
	if not lootData.GodLoot then
		return
	end

	local components = screen.Components
	local button = screen.MouseOverButton

	local upgradeTraitData = nil
	for _, traitData in pairs( CurrentRun.Hero.Traits ) do
		if traitData.RarityUpgradeData and lootData.Name == traitData.RarityUpgradeData.LootName then
			upgradeTraitData = traitData
			break
		end
	end
	
	if not upgradeTraitData or not upgradeTraitData.RarityUpgradeData.Uses or upgradeTraitData.RarityUpgradeData.Uses <= 0 then
		return
	end
	local traitData = button.Data
	if not traitData or ( upgradeTraitData.RarityUpgradeData.MaxRarity and GetRarityValue( traitData.Rarity ) > upgradeTraitData.RarityUpgradeData.MaxRarity ) then
		return
	end

	if TryUpgradeBoon( lootData, screen, button ) then
		upgradeTraitData.RarityUpgradeData.Uses = upgradeTraitData.RarityUpgradeData.Uses - 1
		if upgradeTraitData.RarityUpgradeData.Uses <= 0 then
			ReduceTraitUses( upgradeTraitData, { Force = true })
		end
		screen.UpgradedRarity = true
		TraitUIUpdateText( GetHeroTrait( upgradeTraitData.Name ) )	
		local notifyName = "ScreenInput"
		if screen.Name ~= nil then
			notifyName = notifyName..screen.Name
		end
		TeleportCursor({ DestinationId = button.Id, ForceUseCheck = true, })
	end
end

function TryUpgradeBoon( lootData, screen, button )

	local components = screen.Components

	local traitData = button.Data
	local validUpgradeIndex = false
	for i, upgradeData in pairs(lootData.UpgradeOptions) do
		if traitData.Name == upgradeData.ItemName and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil then
			upgradeData.Rarity = GetUpgradedRarity(traitData.Rarity)
			validUpgradeIndex = i
		end
	end
	if validUpgradeIndex then
		
		local toDestroy = {}
		local destroyIndexes = {
		"PurchaseButton"..validUpgradeIndex,
		"PurchaseButton"..validUpgradeIndex.. "Lock",
		"PurchaseButton"..validUpgradeIndex.. "Highlight",
		"PurchaseButton"..validUpgradeIndex.. "Icon",
		"PurchaseButton"..validUpgradeIndex.. "ExchangeIcon",
		"PurchaseButton"..validUpgradeIndex.. "ExchangeIconFrame",
		"PurchaseButton"..validUpgradeIndex.. "QuestIcon",
		"PurchaseButton"..validUpgradeIndex.. "ElementIcon",
		"Backing"..validUpgradeIndex,
		"PurchaseButton"..validUpgradeIndex.. "Frame",
		"PurchaseButton"..validUpgradeIndex.. "Patch",
		}
		for i, indexName in pairs( destroyIndexes ) do
			if components[indexName] then
				table.insert(toDestroy, components[indexName].Id)
				components[indexName] = nil
			end
		end
		Destroy({ Ids = toDestroy })
		UpgradeBoonRarityPresentation( button )
		local newButton = CreateUpgradeChoiceButton( screen, lootData, validUpgradeIndex, lootData.UpgradeOptions[validUpgradeIndex])
		local notifyName = "ScreenInput"
		if screen.Name ~= nil then
			notifyName = notifyName..screen.Name
		end
		NotifyOnInteract({ Ids = { newButton.Id }, Notify = notifyName })
		return newButton
	end
end

function MouseOverBlockedButton( component )
	local screen = component.Screen
	if not screen.KeepOpen then
		return
	end
	
	SetAnimation({ DestinationId = screen.Components[component.HighlightKey].Id, Name = "BoonSlotHighlight" })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle", Id = component.Id })
end

function MouseOffBlockedButton( component )
	local screen = component.Screen
	SetAnimation({ DestinationId = screen.Components[component.HighlightKey].Id, Name = "BoonHighlightOut" })
end

function MouseOverBoonButton( component )
	local screen = component.Screen
	if not screen.KeepOpen then
		return
	end

	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle", Id = component.Id })
	screen.MouseOverButton = component
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	SetAnimation({ DestinationId = component.Highlight.Id, Name = "BoonSlotHighlight" })
	if component.Data.TraitToReplace ~= nil then
		ModifyTextBox({ Id = screen.Components.SelectButton.Id, Text = "Boon_Sacrifice" })
	else
		ModifyTextBox({ Id = screen.Components.SelectButton.Id, Text = "Boon_Select" })
	end
	
	UpgradeChoiceScreenCheckRarifyButton( screen, component )
end

function MouseOffBoonButton( component )
	local screen = component.Screen
	
	screen.Components.RarifyButton.Visible = nil
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = screen.Components.RarifyButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAnimation({ DestinationId = component.Highlight.Id, Name = "BoonHighlightOut" })
end


function UpgradeChoiceScreenCheckRarifyButton( screen, button )
	local textData = {}
	local lootData = button.LootData
	
	local upgradeTraitData = nil
	for _, traitData in pairs( CurrentRun.Hero.Traits ) do
		if traitData.RarityUpgradeData and lootData.Name == traitData.RarityUpgradeData.LootName then
			upgradeTraitData = traitData
			break
		end
	end
	
	local validUpgradeIndex = false
	if  upgradeTraitData and upgradeTraitData.RarityUpgradeData.Uses and upgradeTraitData.RarityUpgradeData.Uses > 0 then
		local traitData = button.Data
		for i, upgradeData in pairs(lootData.UpgradeOptions) do
			if traitData.Name == upgradeData.ItemName and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil and GetRarityValue( traitData.Rarity ) <= upgradeTraitData.RarityUpgradeData.MaxRarity then
				upgradeData.Rarity = GetUpgradedRarity(traitData.Rarity)
				validUpgradeIndex = true
			end
		end

	end
	
	if validUpgradeIndex and not screen.UpgradedRarity and not screen.TraitTrayOpened then
	
		screen.Components.RarifyButton.Visible = true
		SetAlpha({ Id = screen.Components.RarifyButton.Id, Fraction = 1.0, Duration = 0.2 })
		ModifyTextBox({ Id = screen.Components.RarifyButton.Id, Text = "Boon_Upgrade", LuaKey = "TempTextData", LuaValue = { Amount = upgradeTraitData.RarityUpgradeData.Uses, MaxAmount = upgradeTraitData.RarityMultiplier } } )
		if not screen.FirstRarifyPrompt then
			thread( OncePerMenuRarifyPresentation, screen.Components.RarifyButton, baseColor )
			screen.FirstRarifyPrompt = true
		end
	else
		screen.Components.RarifyButton.Visible = false
		SetAlpha({ Id = screen.Components.RarifyButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
end


function UpgradeChoiceScreenOpenTraitTray( screen, button )
	screen.TraitTrayOpened = true
	if screen.Components.SelectButton then
		SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
	if screen.Components.RerollButton then
		SetAlpha({ Id = screen.Components.RerollButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
	if screen.Components.RarifyButton then
		screen.Components.RarifyButton.Visible = nil
		SetAlpha({ Id = screen.Components.RarifyButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
	if screen.Components.AcceptButton then
		SetAlpha({ Id = screen.Components.AcceptButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
	if screen.Components.CloseButton then
		SetAlpha({ Id = screen.Components.CloseButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
	SetAlpha({ Id = screen.Components.TraitTrayButton.Id, Fraction = 0.0, Duration = 0.2 })

	for index = 1, 3 do
		if screen.Components["PurchaseButton"..index] then
			AddInteractBlock( screen.Components["PurchaseButton"..index], "TraitTray" )
		end
	end

	ShowCombatUI( screen.Name )
	ShowTraitTrayScreen( { HighlightName = screen.TraitToReplaceName, CloseFunctionName = "UpgradeChoiceScreenCloseTraitTray", CloseFunctionArgs = { Screen = screen }, HideInfoButton = true, } )
end

function UpgradeChoiceScreenCloseTraitTray( screen, args )
	local traitTrayScreen = args.Screen
	traitTrayScreen.TraitTrayOpened = false
	HideCombatUI( args.Screen.Name )
	local upgradeChoiceScreenComponents = args.Screen.Components
	SetAlpha({ Id = upgradeChoiceScreenComponents.TraitTrayButton.Id, Fraction = 1.0, Duration = 0.2 })
	for index = 1, 3 do
		if traitTrayScreen.Components["PurchaseButton"..index] then
			RemoveInteractBlock( traitTrayScreen.Components["PurchaseButton"..index], "TraitTray" )
		end
	end
	if upgradeChoiceScreenComponents.RerollButton then
		if upgradeChoiceScreenComponents.RerollButton.OnPressedFunctionName ~= nil then
			SetAlpha({ Id = upgradeChoiceScreenComponents.RerollButton.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end
	if upgradeChoiceScreenComponents.AcceptButton then
		if not upgradeChoiceScreenComponents.AcceptButton.Disabled then
			SetAlpha({ Id = upgradeChoiceScreenComponents.AcceptButton.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end
	if upgradeChoiceScreenComponents.CloseButton then
		SetAlpha({ Id = upgradeChoiceScreenComponents.CloseButton.Id, Fraction = 1.0, Duration = 0.2 })
	end
end

function UpgradeChoiceRetaliate( victim, triggerArgs )
	local attacker = triggerArgs.AttackerTable
	if attacker ~= nil then
		Kill( attacker )
	end
end