
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
	if args.ContextArtId ~= nil then
		screen.ComponentData.OlympusBackground = nil
	else
		local animationName = source.BackgroundAnimation
		if args.UseNarrativeContextArt or source.UseNarrativeContextArt then
			local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
			if roomData.NarrativeContextArt ~= nil then
				animationName = roomData.NarrativeContextArt.."_In"
			end
		end
		screen.ComponentData.OlympusBackground.AnimationName = animationName
	end
	screen.Source = source
	ScreenAnchors.ChoiceScreen = screen
	if not IsEmpty( screen.CombatUIShowGroups ) then
		for i, flagName in pairs( screen.CombatUIShowGroups ) do
			ShowCombatUI( flagName )
		end
	end
	HideCombatUI( screen.Name )
	UnblockCombatUI( "PlayTextLines" )
	
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData, args )
	
	local components = screen.Components
	if source.Icon or source.DoorIcon then
		SetAnimation({ DestinationId = screen.Components.SourceIcon.Id, Name = source.Icon or source.DoorIcon })
	end

	if args.ContextArtId ~= nil then
		components.OlympusBackground = { Id = args.ContextArtId }
	end
	
	if HeroHasTrait( "PanelRerollMetaUpgrade" ) and not source.BlockReroll then
		screen.MovedRerollUIGroup = true
		RemoveFromGroup({ Id = ScreenAnchors.Reroll, Name = "Combat_UI" })
		AddToGroup({ Id = ScreenAnchors.Reroll, Name = "Combat_Menu_Overlay", DrawGroup = true })
		
		ModifyTextBox({ Id = components.RerollIcon.Id, Text = CurrentRun.NumRerolls, AutoSetDataProperties = false, })
		SetAlpha({ Id = components.RerollIcon.Id, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })

	end
	source.HasExchange = HasExchangeOnLoot( source )
	UpgradeChoiceScreenOpenStartPresentation( screen, source )
	ToggleCombatControl({"Attack3"}, true, screen.Name )
	for weaponName, v in pairs( WeaponSetLookups.HeroSecondaryWeaponsLinked ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		end
	end
	
	SetPlayerInvulnerable("BoonMenuOpen")
	--CurrentRun.Hero.ExclusiveOnHitFunctionName = "UpgradeChoiceRetaliate"
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })

	screen.SubjectName = upgradeName
	screen.ButtonGroupName = args.ButtonGroupName
	screen.PurchaseAnimationGroupName = args.PurchaseAnimationGroupName

	waitUnmodified(0.25)

	if components.ShopLighting ~= nil then
		SetColor({ Id = components.ShopLighting.Id, Color = source.LightingColor })
	end
	if components.ShopLightingMelFace ~= nil then
		SetColor({ Id = components.ShopLightingMelFace.Id, Color = source.LightingColor })
	end
	SetColor({ Id = components.ShopBackgroundGradient.Id, Color = source.LightingColor })
	if source.BackgroundColor ~= nil then
		SetColor({ Id = components.ShopBackgroundDim.Id, Color = source.BackgroundColor })
	end

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
	CreateBoonLootButtons( screen, source, nil, args )
	
	-- Short delay to let animations finish and prevent accidental input
	waitUnmodified(0.5)

	HandleScreenInput( screen )

end

function CreateBoonLootButtons( screen, lootData, reroll, args )

	local components = screen.Components
	local upgradeName = lootData.Name
	local upgradeChoiceData = LootData[upgradeName]
	local upgradeOptions = lootData.UpgradeOptions
	if upgradeOptions == nil then
		SetTraitsOnLoot( lootData )
		upgradeOptions = lootData.UpgradeOptions
	elseif lootData.StackOnly then
		local hasAllOptions = true
		for i, data in pairs( upgradeOptions ) do
			if not data.ItemName or not HeroHasTrait( data.ItemName ) then
				hasAllOptions = false
				break
			end
		end
		if not hasAllOptions then
			SetTraitsOnLoot( lootData )
			upgradeOptions = lootData.UpgradeOptions
		end
	end
	if not lootData.StackNum then
		lootData.StackNum = 1
	end
	if not reroll then
		lootData.StackNum = lootData.StackNum
		
		if IsFateValid() then 
			lootData.StackNum = lootData.StackNum + GetTotalHeroTraitValue("FatedPomLevelBonus")
		end
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
	
	for i = 1, CalcNumLootChoices( lootData ) do
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
		local button = CreateUpgradeChoiceButton( screen, lootData, itemIndex, itemData, args )

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
	
	if not GameState.Flags.SeenElementalIcons and IsGameStateEligible( screen, TraitRarityData.ElementalGameStateRequirements ) and ( lootData.GodLoot or lootData.TreatAsGodLootByShops) then
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
		components.RerollButton.Cost = cost
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

	if screen.Components.BoonListButton ~= nil then
		if lootData.StackOnly then
			screen.Components.BoonListButton.OnPressedFunctionName = nil
		else
			SetAlpha({ Id = screen.Components.BoonListButton.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end
end

function CreateUpgradeChoiceButton( screen, lootData, itemIndex, itemData, args )
	args = args or {}
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
	local stackNum = 0
	upgradeData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, Rarity = itemData.Rarity })
	if not upgradeData.BlockStacking and IsGodTrait(itemData.ItemName) and not lootData.IgnoreStackBoost then
		if itemData.StackNum then
			stackNum = itemData.StackNum
		else
			local maxRank = GetTotalHeroTraitValue("MaxBonusBoonRankWeighted")
			local distribution = GetHeroTraitValues("MaxBonusBoonRankDistribution", { First = true })[1]
			if not IsEmpty( distribution ) and not IsEmpty(distribution[maxRank] ) then
				stackNum = GetRandomValueFromWeightedList( distribution[maxRank] )
			else
				stackNum = RandomInt( 0, maxRank )
			end
			if IsFateValid() and GetTotalHeroTraitValue("FatedBoonLevelBonus") > 0 then
				stackNum = stackNum + GetTotalHeroTraitValue("FatedBoonLevelBonus") + 1
			end
		end
	end
	local traitNum = GetTraitCount(CurrentRun.Hero, { TraitData = upgradeData })
	if lootData.StackOnly and HeroHasTrait(itemData.ItemName) and not TraitData[itemData.ItemName].Hidden then
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
			upgradeData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, StackNum = newNum, Rarity = itemData.Rarity, RarityMultiplier = upgradeData.RarityMultiplier})
			upgradeData.TraitToReplace = itemData.TraitToReplace
		end
		SetTraitTextData( tooltipData )
	elseif stackNum > 0 and not lootData.StackOnly then
		tooltipData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, StackNum = stackNum, RarityMultiplier = upgradeData.RarityMultiplier})
		upgradeData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, Rarity = itemData.Rarity, StackNum = stackNum })
		upgradeTitle = "TraitLevel_Exchange"
		tooltipData.Title = GetTraitTooltipTitle( TraitData[upgradeData.Name])
		tooltipData.Level = stackNum
		SetTraitTextData( tooltipData )
	elseif lootData.StackOnly and upgradeData.Name ~= "FallbackGold" then
		tooltipData = GetHeroTrait( upgradeData.Name )
		local startingStackNum = tooltipData.StackNum or 1
		tooltipData.OldLevel = startingStackNum
		tooltipData.NewLevel = startingStackNum + lootData.StackNum
		local stackTooltipData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, StackNum = startingStackNum + lootData.StackNum, RarityMultiplier = tooltipData.RarityMultiplier})
		SetTraitTextData( tooltipData, { ReplacementTraitData = stackTooltipData })
		itemData.Rarity = tooltipData.Rarity
		upgradeData.Rarity = tooltipData.Rarity
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
		--upgradeData.Icon = blessingData.Icon
		upgradeData.ExtractData = upgradeData.ExtractData or {}
		local extractedData = GetExtractData( blessingData )
		for i, value in pairs(extractedData) do
			local key = value.ExtractAs
			if key then
				upgradeData.ExtractData[key] = blessingData[key]
			end
		end
	else
		if upgradeData.PrePickSacrificeBoon and upgradeData.SacrificedTraitName == nil then
			upgradeData.SacrificedTraitName = GetRandomSacrificeTraitData().Name
		end
		tooltipData = upgradeData
		SetTraitTextData( tooltipData )
	end

	if itemData.Type ~= "TransformingTrait" then
		upgradeDescription = GetTraitTooltip( tooltipData , { Default = upgradeData.Title })
	end

	if tooltipData.MergeTooltipDataFromSession then
		local newData = {}
		for key, sessionKey in pairs( tooltipData.MergeTooltipDataFromSession ) do
			newData[key] = SessionMapState[sessionKey]
			upgradeData.StatLine = SessionMapState.StatLine
			upgradeData[key] = {}
			upgradeData[key].ExtractData = {}
			for extractAs, value in pairs( SessionMapState[sessionKey].ExtractData) do
				upgradeData[key].ExtractData[extractAs] = value
			end
		end
		tooltipData = MergeTables( tooltipData, newData ) 
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
	purchaseButton.Group = args.ButtonGroupName or purchaseButton.Group
	components[purchaseButtonKey] = CreateScreenComponent( purchaseButton )
	components[purchaseButtonKey].BackingAnim = backingAnim
	
	if itemData.SlotEntranceAnimation ~= nil then
		CreateAnimation({ Name = itemData.SlotEntranceAnimation, DestinationId = components[purchaseButtonKey].Id })
	elseif TraitData[upgradeData.Name] and TraitData[upgradeData.Name].FirstTimeEntranceAnimation and not GameState.TraitsSeen[upgradeData.Name] then
		CreateAnimation({ Name = TraitData[upgradeData.Name].FirstTimeEntranceAnimation, DestinationId = components[purchaseButtonKey].Id })
	elseif upgradeData.Rarity == "Legendary" or upgradeData.Rarity == "Duo" then
		if TraitData[upgradeData.Name].IsDuoBoon then
			CreateAnimation({ Name = "BoonEntranceDuo", DestinationId = components[purchaseButtonKey].Id })
		else
			CreateAnimation({ Name = "BoonEntranceLegendary", DestinationId = components[purchaseButtonKey].Id }) 
		end
	end

	GameState.TraitsSeen[upgradeData.Name] = true

	local highlight = ShallowCopyTable( screen.Highlight )
	highlight.X = purchaseButton.X
	highlight.Y = purchaseButton.Y
	if Contains( blockedIndexes, itemIndex ) then
		itemData.Blocked = true
		overlayLayer = "Combat_Menu"
		AddInteractBlock( components[purchaseButtonKey], "TraitLocked" )
		ModifyTextBox({ Id = components[purchaseButtonKey].Id, BlockTooltip = true })
		thread( TraitLockedPresentation, { Screen = screen, Components = components, HighlightKey = purchaseButtonKey.."Highlight", Id = purchaseButtonKey, OffsetX = highlight.X, OffsetY = highlight.Y, TooltipOffsetX = screen.TooltipOffsetX } )
	end
	highlight.Group = args.ButtonGroupName or highlight.Group
	components[purchaseButtonKey.."Highlight"] = CreateScreenComponent( highlight )

	if upgradeData.Icon ~= nil then
		local icon = ShallowCopyTable( screen.Icon )
		icon.X = screen.IconOffsetX + itemLocationX + screen.ButtonOffsetX
		icon.Y = screen.IconOffsetY + itemLocationY
		icon.Animation = upgradeData.Icon
		icon.Group = args.ButtonGroupName or icon.Group
		components[purchaseButtonKey.."Icon"] = CreateScreenComponent( icon )
	end

	components[purchaseButtonKey.."PinIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", Animation = "StoreItemPin", Alpha = 0, X = screen.PinOffsetX + itemLocationX, Y = screen.PinOffsetY + itemLocationY })

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

	local frame = ShallowCopyTable( screen.Frame )
	frame.X = screen.IconOffsetX + itemLocationX + screen.ButtonOffsetX
	frame.Y = screen.IconOffsetY + itemLocationY
	frame.Animation = GetTraitFrame( upgradeData )
	frame.Group = args.ButtonGroupName or frame.Group
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
	button.PinIcon = components[purchaseButtonKey.."PinIcon"]
	button.StackNum = stackNum
	button.Index = itemIndex

	if screen.Source and screen.Source.OnPressedFunctionNameOverride then
		button.OnPressedFunctionName = screen.Source.OnPressedFunctionNameOverride 
	end
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
	descriptionText.TextSymbolScale = upgradeData.DescriptionTextSymbolScale or descriptionText.TextSymbolScale
	CreateTextBoxWithFormat( descriptionText )

	if upgradeDescription2 then
		local descriptionText2 = DeepCopyTable( screen.DescriptionText )
		descriptionText2.Id = button.Id
		descriptionText2.Text = upgradeDescription2
		descriptionText2.LuaValue = tooltipData
		descriptionText2.OffsetY = 0
		descriptionText2.LangOffsetY = nil
		descriptionText2.AppendToId = descriptionText.Id
		CreateTextBoxWithFormat( descriptionText2 )
	end

	local statLines = traitData.StatLines
	if traitData.CustomStatLinesWithShrineUpgrade ~= nil and GetNumShrineUpgrades( traitData.CustomStatLinesWithShrineUpgrade.ShrineUpgradeName ) > 0 then
		statLines = traitData.CustomStatLinesWithShrineUpgrade.StatLines
	end
	if statLines ~= nil then
		local appendToId = descriptionText.Id
		for lineNum, statLine in ipairs( statLines ) do
			if statLine ~= "" then

				local offsetY = (lineNum - 1) * screen.LineHeight

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
		components[purchaseButtonKey.."QuestIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = args.ButtonGroupName or "Combat_Menu", X = itemLocationX + screen.QuestIconOffsetX, Y = itemLocationY + screen.QuestIconOffsetY })
		SetAnimation({ DestinationId = components[purchaseButtonKey.."QuestIcon"].Id, Name = "QuestItemFound" })
		-- Silent toolip
		CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "TraitQuestItem", Color = Color.Transparent, LuaKey = "TooltipData", LuaValue = tooltipData, })
	end

	if not lootData.StackOnly and IsBoonRequiredForPins( upgradeData.Name ) then
		SetAlpha({ Id = components[purchaseButtonKey.."PinIcon"].Id, Fraction = 1 })
		-- Silent toolip
		local tooltipText = "NeededPinBoonTooltip"
		if IsBoonPinned( upgradeData.Name) then
			tooltipText = "NeededPinBoonTooltip_Pinned"
		end
		CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = tooltipText, Color = Color.Transparent })
	end

	if tooltipData.AddLuckTooltip then
		CreateTextBox({
			Text = "BoostedLuck_Tooltip",
			Id = components[purchaseButtonKey].Id,
			UseDescription = true,
			TextSymbolScale = 0,
			Color = Color.Transparent,
		})
	end

	if tooltipData.AddSpeedTooltip then
		CreateTextBox({
			Text = "BoostedSpeed_Tooltip",
			Id = components[purchaseButtonKey].Id,
			UseDescription = true,
			TextSymbolScale = 0,
			Color = Color.Transparent,
		})
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
	for index = 1, 3 do
		DestroyBoonLootButton( screen, index )
	end
end

function DestroyBoonLootButton( screen, index )
	local components = screen.Components
	local toDestroy = {}
	local destroyIndexes = {
	"PurchaseButton"..index,
	"PurchaseButton"..index.. "Lock",
	"PurchaseButton"..index.. "Highlight",
	"PurchaseButton"..index.. "Icon",
	"PurchaseButton"..index.. "ExchangeIcon",
	"PurchaseButton"..index.. "ExchangeIconFrame",
	"PurchaseButton"..index.. "QuestIcon",
	"PurchaseButton"..index.. "PinIcon",
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
	Destroy({ Ids = toDestroy })
end

function RerollBoonLoot( screen, button )	
	local lootData = button.LootData
	DestroyBoonLootButtons( screen, lootData )
	local itemNames = {}
	for i, value in pairs( lootData.UpgradeOptions ) do
		table.insert( itemNames, value.ItemName )
	end
	SetTraitsOnLoot( lootData, { BoonRaritiesOverride = lootData.RarityChances, IgnoreAllRarityBonus = true, IgnoreRoomRarityBonus = true, ExclusionNames = { GetRandomValue( itemNames )}})
	
	ModifyTextBox({ Id = screen.Components.RerollIcon.Id, Text = CurrentRun.NumRerolls, AutoSetDataProperties = false, })
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
	local key = GetKey( rarityTable, baseRarity )
	if key and rarityTable[key + 1] then
		return rarityTable[key + 1]
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

	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot then
			occupiedSlots[traitData.Slot] = true
		end
	end

	for index, traitName in ipairs(traitNames) do

		if TraitData[traitName] and (lootData.StripRequirements or IsTraitEligible( TraitData[traitName] )) then
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

	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
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
		if IsTraitEligible( TraitData[traitName] ) and not HeroHasTrait(traitName) and occupiedSlots[slot] and GetUpgradedRarity(occupiedSlots[slot].Rarity) ~= nil and ( onlyFromLootName == nil or LootData[onlyFromLootName].TraitIndex[occupiedSlots[slot].TraitName] ) then
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

	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
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
		if dependencyTable and not HeroHasTrait( traitName ) and ( IsTraitEligible( TraitData[traitName] ) or lootData.StripRequirements ) then
			valid = HasTraitRequirements( traitName )

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
		elseif IsTraitEligible( TraitData[traitName] ) or lootData.StripRequirements then
			valid = HasTraitRequirements( traitName )
		end

		if valid then
			table.insert( linkedTraits, traitName )
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
		local traitData = TraitData[upgradeData.ItemName]
		if not lootData.StackOnly and HeroHasTrait(upgradeData.ItemName) then
			table.insert(toRemove, upgradeData)
		elseif not lootData.StripRequirements and not IsTraitEligible( traitData, { AllowBannedTraits = lootData.StackOnly } ) then
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
		RemoveWeaponTrait( upgradeData.TraitToReplace )
		newTrait = AddTraitToHero({ TraitData = upgradeData, FromLoot = true })
		currentRun.CurrentRoom.ReplacedTraitSource = GetLootSourceName(upgradeData.TraitToReplace)
		IncrementTableValue(CurrentRun, "SacrificeTraitCount" )
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
	if not args.DoubleBoonChance then
		LogUpgradeChoice( button )
	end
	CurrentRun.PickedTraits[upgradeData.Name] = true
	SessionMapState.LastUpgradeChoice = upgradeData.Name
	PlaySound({ Name = button.LootData.UpgradeSelectedSound or "/SFX/HeatRewardDrop", Id = buttonId })
	SetAlpha({ Id = buttonId, Fraction = 0 })
	
	CreateAnimation({ Name = "BoonGetBlack", DestinationId = buttonId, Scale = 1.0, Group = screen.ButtonGroupName or "Combat_Menu" })
	CreateAnimation({ Name = "BoonGet", DestinationId = buttonId, Scale = 1.0, Group = screen.PurchaseAnimationGroupName or "Combat_Menu_Additive", Color = button.BoonGetColor or button.LootColor })

	--wait( 0.4, RoomThreadName )
	local doubleBoonTrait = HasHeroTraitValue("DoubleBoonChance")
	if doubleBoonTrait and doubleBoonTrait.Uses > 0 and ( button.LootData.GodLoot or button.LootData.TreatAsGodLootByShops) and not button.LootData.BlockDoubleBoon and RandomChance(doubleBoonTrait.DoubleBoonChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
		local validOtherChoices = {} 
		for i, lootbutton in pairs( screen.UpgradeButtons ) do
			if lootbutton ~= button and not lootbutton.Data.TraitToReplace then
				table.insert( validOtherChoices, lootbutton )
			end
		end
		if not IsEmpty( validOtherChoices ) then
			DestroyBoonLootButton( screen, button.Index )
			waitUnmodified(0.8)
			local nextButton = GetRandomValue( validOtherChoices )
			ReduceTraitUses( doubleBoonTrait )
			DoubleBoonPresentation( screen, nextButton )
			CheckNewTraitManaReserveShrineUpgrade( newTrait, { IsGodLoot = true } )
			if HeroHasTrait("ElementalRarityUpgradeBoon") then
				local trait = GetHeroTrait("ElementalRarityUpgradeBoon")
				if trait.Activated and nextButton.Data.Rarity and nextButton.Data.Rarity == "Common" then
					nextButton.LootData.UpgradeOnPick = true
				end
			end
			HandleUpgradeChoiceSelection( screen, nextButton, { DoubleBoonChance = true } )
			return
		end
	end
	local source = screen.Source
	local spawnTarget = nil
	local duplicateOnClose = false
	local name = source.Name
	if source.CanDuplicate and RandomChance( GetTotalHeroTraitValue("DoubleRewardChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
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
	CheckNewTraitManaReserveShrineUpgrade( newTrait, { IsGodLoot = ( button.LootData.GodLoot or button.LootData.TreatAsGodLootByShops ) } )
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

	SetLightBarColor({ PlayerIndex = 1, Color = CurrentRun.Hero.LightBarColor or { 0.0, 0.0, 0.0, 0.0 } })

end

function CloseUpgradeChoiceScreen( screen, button )
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	if screen.Components.ShopBackground ~= nil then
		SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = "BoonSelectMelOut" })
	end
	if screen.Components.ShopLightingMelFace ~= nil then
		SetAlpha({ Id = screen.Components.ShopLightingMelFace.Id, Fraction = 0.0, Duration = 0.125, EaseIn = 0.9, EaseOut = 1 })
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
	killTaggedThreads( "RarifyPulse" )
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.25 )
	AltAspectRatioFramesHide()
	if not button.LootData.SelectionSound then
		PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	else
		PlaySound({ Name = button.LootData.SelectionSound })
	end
	for weaponName, v in pairs( WeaponSetLookups.HeroSecondaryWeaponsLinked ) do
		if MapState.EquippedWeapons[weaponName] then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true  })
		end
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
	if screen.Source.RarityBoosted and not screen.Source.ForceCommonWithoutCurse then
		UseHeroTraitsWithValue("RarityBonus", true )
	end

	if ( screen.Source.GodLoot or screen.Source.TreatAsGodLootByShops ) and not screen.Source.IgnoreRestrictBoonChoices then
		UseHeroTraitsWithValue( "RestrictBoonChoices", true )
	end
	if screen.Source.UseSwapTrait then
		local forceSwapTrait = HasHeroTraitValue("ForceSwaps")
		if forceSwapTrait and forceSwapTrait.Uses > 0 then
			forceSwapTrait.Uses = forceSwapTrait.Uses - 1
			UpdateTraitNumber( forceSwapTrait )
			if forceSwapTrait.Uses <= 0 then
				RemoveTraitData( CurrentRun.Hero, forceSwapTrait )
			end
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
				Chosen = tostring( upgradeData.ItemName == button.Data.Name or upgradeData.SecondaryItemName == button.Data.Name ),
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
	local lootData = screen.Source

	if not lootData.GodLoot and not lootData.TreatAsGodLootByShops then
		return
	end
	local components = screen.Components
	local button = screen.MouseOverButton

	local upgradeTraitData = nil
	for _, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.RarityUpgradeData then
			if not traitData.RarityUpgradeData.LootName and ( button.LootData.GodLoot or button.LootData.TreatAsGodLootByShops) and (not traitData.RarityUpgradeData.RequireNotExcludeFromLastRunBoon or not button.LootData.ExcludeFromLastRunBoon ) then
				if not traitData.RarityUpgradeData.RequireFated  or ( traitData.RarityUpgradeData.RequireFated and IsFateValid()) then 
					upgradeTraitData = traitData
				end
			end
			if lootData.Name == traitData.RarityUpgradeData.LootName then
				-- More specific upgrades always take priority over general ones
				if not traitData.RarityUpgradeData.RequireFated  or ( traitData.RarityUpgradeData.RequireFated and IsFateValid()) then 
					upgradeTraitData = traitData
				end
				break
			end
		end
	end
	
	if not upgradeTraitData or not upgradeTraitData.RarityUpgradeData.Uses or upgradeTraitData.RarityUpgradeData.Uses <= 0 then
		return
	end
	local traitData = button.Data
	if not traitData or ( upgradeTraitData.RarityUpgradeData.MaxRarity and GetRarityValue( traitData.Rarity ) > upgradeTraitData.RarityUpgradeData.MaxRarity ) then
		return
	end
	
	if screen.UpgradedRarity and not upgradeTraitData.RarityUpgradeData.MultiUse then
		return
	end

	if TryUpgradeBoon( lootData, screen, button ) then
		if not IsEmpty(upgradeTraitData.RarityUpgradeData.RarifyVoiceLines) then
			thread( PlayVoiceLines, upgradeTraitData.RarityUpgradeData.RarifyVoiceLines, true )
		end
		upgradeTraitData.RarityUpgradeData.Uses = upgradeTraitData.RarityUpgradeData.Uses - 1
		TraitUIUpdateText( GetHeroTrait( upgradeTraitData.Name ) )	
		if upgradeTraitData.RarityUpgradeData.Uses <= 0 then
			if not upgradeTraitData.Slot then
				RemoveTraitData( CurrentRun.Hero, upgradeTraitData )
			else
				ReduceTraitUses( upgradeTraitData, { Force = true })
			end
			if not upgradeTraitData.LootName and upgradeTraitData.ZeroBonusTrayText then
				upgradeTraitData.CustomName = upgradeTraitData.ZeroBonusTrayText
			end
		end
		screen.UpgradedRarity = true
		local notifyName = "ScreenInput"
		if screen.Name ~= nil then
			notifyName = notifyName..screen.Name
		end
		TeleportCursor({ DestinationId = button.Id, ForceUseCheck = true, })
		killTaggedThreads( "RarifyPulse" )
	end
end

function TryUpgradeBoon( lootData, screen, button )
	if not CheckCooldown("RarifyInputCooldown", 0.45) then
		return
	end
	local components = screen.Components

	local traitData = button.Data
	local sacrificeTrait = traitData.SacrificedTraitName
	local validUpgradeIndex = false
	if lootData.UpgradeOptions ~= nil then
		for i, upgradeData in pairs( lootData.UpgradeOptions ) do
			if not traitData.BlockMenuRarify and traitData.Name == upgradeData.ItemName and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil then
				upgradeData.Rarity = GetUpgradedRarity(traitData.Rarity)
				validUpgradeIndex = i
			end
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
		"PurchaseButton"..validUpgradeIndex.. "PinIcon",
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
		lootData.UpgradeOptions[validUpgradeIndex].StackNum = button.StackNum
		local newButton = CreateUpgradeChoiceButton( screen, lootData, validUpgradeIndex, lootData.UpgradeOptions[validUpgradeIndex])
		if newButton.Data and sacrificeTrait then
			newButton.Data.SacrificedTraitName = sacrificeTrait
		end
		local notifyName = "ScreenInput"
		if screen.Name ~= nil then
			notifyName = notifyName..screen.Name
		end
		if screen.UpgradeButtons then
			screen.UpgradeButtons[validUpgradeIndex] = newButton  
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
	screen.ClipboardText = component.Data.Name
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	SetAnimation({ DestinationId = component.Highlight.Id, Name = "BoonSlotHighlight" })
	if screen.Source and screen.Source.ChoiceTextOverride then
		ModifyTextBox({ Id = screen.Components.SelectButton.Id, Text = screen.Source.ChoiceTextOverride })
	elseif component.Data.TraitToReplace ~= nil then
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
	local multiUse = false
	for _, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.RarityUpgradeData then
			if not traitData.RarityUpgradeData.LootName and ( button.LootData.GodLoot or button.LootData.TreatAsGodLootByShops) and (not traitData.RarityUpgradeData.RequireNotExcludeFromLastRunBoon or not button.LootData.ExcludeFromLastRunBoon ) then
				upgradeTraitData = traitData
			end
			if lootData.Name == traitData.RarityUpgradeData.LootName then
				-- More specific upgrades always take priority over general ones
				upgradeTraitData = traitData
				break
			end
		end
	end
	
	local validUpgradeIndex = false
	if  upgradeTraitData and upgradeTraitData.RarityUpgradeData.Uses then
		local uses = upgradeTraitData.RarityUpgradeData.Uses
		if upgradeTraitData.RarityUpgradeData.RequireFated and not IsFateValid() then
			uses = 0
		end
		if uses > 0 then
			local traitData = button.Data
			if traitData.MultiUse then
				multiUse = true
			end
			for i, upgradeData in pairs(lootData.UpgradeOptions) do
				if not traitData.BlockMenuRarify and traitData.Name == upgradeData.ItemName and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil and GetRarityValue( traitData.Rarity ) <= upgradeTraitData.RarityUpgradeData.MaxRarity then
					upgradeData.Rarity = GetUpgradedRarity(traitData.Rarity)
					validUpgradeIndex = true
				end
			end
		end
	end
	local multiUse = false
	if upgradeTraitData and upgradeTraitData.RarityUpgradeData.MultiUse then
		multiUse = true
	end
	if validUpgradeIndex and (not screen.UpgradedRarity or multiUse) and not screen.TraitTrayOpened then
		local text = "Boon_Upgrade"
		if multiUse then
			text = "Boon_Upgrade_Count"
		end
		screen.Components.RarifyButton.Visible = true
		SetAlpha({ Id = screen.Components.RarifyButton.Id, Fraction = 1.0, Duration = 0.2 })
		ModifyTextBox({ Id = screen.Components.RarifyButton.Id, Text = text, LuaKey = "TempTextData", LuaValue = { Amount = upgradeTraitData.RarityUpgradeData.Uses, MaxAmount = upgradeTraitData.RarityMultiplier } } )
		if not screen.FirstRarifyPrompt then
			thread( PulseContextActionPresentation, screen.Components.RarifyButton, { ThreadName = "RarifyPulse" } )
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
	if screen.Components.BoonListButton then
		SetAlpha({ Id = screen.Components.BoonListButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
	if screen.Components.RerollIcon then
		SetAlpha({ Id = screen.Components.RerollIcon.Id, Fraction = 0.0, Duration = 0.2 })
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
	HideCombatUI( args.Screen.Name, traitTrayScreen.TraitTrayArgs )
	local upgradeChoiceScreenComponents = args.Screen.Components
	SetAlpha({ Id = upgradeChoiceScreenComponents.TraitTrayButton.Id, Fraction = 1.0, Duration = 0.2 })
	for index = 1, 3 do
		if traitTrayScreen.Components["PurchaseButton"..index] then
			RemoveInteractBlock( traitTrayScreen.Components["PurchaseButton"..index], "TraitTray" )
			if index == 1 then
				TeleportCursor({ DestinationId = upgradeChoiceScreenComponents["PurchaseButton"..index].Id, ForceUseCheck = true })
			end
		end
	end
	if upgradeChoiceScreenComponents.RerollButton then
		local cost = upgradeChoiceScreenComponents.RerollButton.Cost
		if upgradeChoiceScreenComponents.RerollButton.OnPressedFunctionName ~= nil 
			and cost and CurrentRun.NumRerolls >= cost and cost >= 0 then
			SetAlpha({ Id = upgradeChoiceScreenComponents.RerollButton.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end
	if upgradeChoiceScreenComponents.BoonListButton then
		if upgradeChoiceScreenComponents.BoonListButton.OnPressedFunctionName ~= nil then
			SetAlpha({ Id = upgradeChoiceScreenComponents.BoonListButton.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end
	if upgradeChoiceScreenComponents.AcceptButton then
		if IsUseable({ Id = upgradeChoiceScreenComponents.AcceptButton.Id }) then
			SetAlpha({ Id = upgradeChoiceScreenComponents.AcceptButton.Id, Fraction = 1.0, Duration = 0.2 })
		end
	end
	if upgradeChoiceScreenComponents.CloseButton then
		SetAlpha({ Id = upgradeChoiceScreenComponents.CloseButton.Id, Fraction = 1.0, Duration = 0.2 })
	end
	if HeroHasTrait( "PanelRerollMetaUpgrade" ) and args.Screen.Source and not args.Screen.Source.BlockReroll and upgradeChoiceScreenComponents.RerollIcon then
		ModifyTextBox({ Id = upgradeChoiceScreenComponents.RerollIcon.Id, Text = CurrentRun.NumRerolls, AutoSetDataProperties = false, })
		SetAlpha({ Id = upgradeChoiceScreenComponents.RerollIcon.Id, Duration = HUDScreen.FadeInDuration, Fraction = ConfigOptionCache.HUDOpacity })

	end
end

function UpgradeChoiceScreenCloseBoonInfo( screen, args )
	local upgradeChoiceScreen = args.Screen
	if upgradeChoiceScreen.UpgradeButtons ~= nil then
		for i, button in ipairs( upgradeChoiceScreen.UpgradeButtons ) do
			DestroyTextBox({ Id = button.Id, AffectText = "NeededPinBoonTooltip" })
			DestroyTextBox({ Id = button.Id, AffectText = "NeededPinBoonTooltip_Pinned" })
			if IsBoonRequiredForPins( button.Data.Name ) then
				SetAlpha({ Id = button.PinIcon.Id, Fraction = 1 })
				local tooltipText = "NeededPinBoonTooltip"
				if IsBoonPinned( button.Data.Name ) then
					tooltipText = "NeededPinBoonTooltip_Pinned"
				end
				CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = tooltipText, Color = Color.Transparent })
			else
				SetAlpha({ Id = button.PinIcon.Id, Fraction = 0 })
			end
		end
	end
end

function UpgradeChoiceRetaliate( victim, triggerArgs )
	local attacker = triggerArgs.AttackerTable
	if attacker ~= nil then
		Kill( attacker )
	end
end

function AttemptOpenUpgradeChoiceBoonInfo( screen, button )

	local sourceName = screen.Source.Name
	local entryName = nil
	local entryData = nil

	if sourceName == "WeaponUpgrade" then
		for equippedWeaponName, _ in pairs( CurrentRun.Hero.Weapons ) do
			if CodexData.Weapons.Entries[equippedWeaponName] then
				entryName = equippedWeaponName
				entryData = CodexData.Weapons.Entries[entryName]
				break
			end
		end
	else
		for categoryName, categoryData in pairs( CodexData ) do
			if categoryName ~= "Weapons" then
				for codexEntryName, codexEntryData in pairs( categoryData.Entries ) do
					if codexEntryName == sourceName or codexEntryData.BoonInfoEnemyName == sourceName then
						entryName = codexEntryName
						entryData = codexEntryData
						break
					end
				end
			end
		end
	end

	HideTopMenuScreenTooltips({ })
	ShowBoonInfoScreen( { LootName = sourceName, CodexEntryName = entryName, CodexEntryData = entryData, CloseFunctionName = "UpgradeChoiceScreenCloseBoonInfo", CloseFunctionArgs = { Screen = screen } } )

end

function IsBoonRequiredForPins( traitName )
	for i, pin in ipairs( GameState.StoreItemPins ) do
		if pin.Name == traitName then
			return true
		end

		local requirements = TraitRequirements[pin.Name]
		if requirements ~= nil then
			if requirements.OneOf ~= nil then
				if Contains( requirements.OneOf, traitName ) and not ContainsAnyKey( CurrentRun.Hero.TraitDictionary, requirements.OneOf ) then
					return true
				end
			end
			if requirements.TwoOf ~= nil then
				if Contains( requirements.TwoOf, traitName ) then
					local haveCount = 0
					for existingTraitName in pairs( CurrentRun.Hero.TraitDictionary ) do
						if Contains( requirements.TwoOf, existingTraitName ) then
							haveCount = haveCount + 1
						end
					end
					if haveCount < 2 then
						return true
					end
				end
			end
			if requirements.OneFromEachSet ~= nil then
				for j, set in ipairs( requirements.OneFromEachSet ) do
					if Contains( set, traitName ) and not ContainsAnyKey( CurrentRun.Hero.TraitDictionary, set )  then
						return true
					end
				end
			end
		end
	end
	return false
end

function IsBoonPinned( traitName )
	for i, pin in ipairs( GameState.StoreItemPins ) do
		if pin.Name == traitName then
			return true
		end
	end
	return false
end
