function IsSellTraitShopEligible( currentRoom )
	if currentRoom.ForceSellShop then
		return true
	end
	if not currentRoom.SellShopChanceSuccess then
		return false
	end
	if currentRoom.SellShopRequirements ~= nil and not IsGameStateEligible( currentRoom, currentRoom.SellShopRequirements ) then
		return false
	end
	return true
end

function GenerateSellTraitShop( currentRoom, args )
	args = args or {}
	GenerateSellTraitValues( currentRoom, args )
	if currentRoom.SellOptions == nil then
		currentRoom.SellOptions = {}
		for i = 1, args.SellOptionCount or 3 do
			if IsEmpty( currentRoom.SellValues ) then
				break
			end
			--DebugPrint({ Text = "TableLength( currentRoom.SellValues ) = "..TableLength(currentRoom.SellValues) })
			table.insert( currentRoom.SellOptions, RemoveRandomValue( currentRoom.SellValues ) )
		end
	end
end

function GenerateSellTraitValues( currentRoom, args )
	args = args or {}
	currentRoom.SellValues = {}
	for index, traitData in pairs( CurrentRun.Hero.Traits ) do
		if IsGodTrait( traitData.Name, { ForShop = true }) and traitData.Rarity and not Contains( args.ExclusionNames, traitData.Name ) then
			currentRoom.SellValues[traitData.Name] = { Name = traitData.Name, Value = GetTraitValue( traitData ) }
		end
	end
end

function OpenSellTraitMenu( args )

	args = args or {}

	local screen = DeepCopyTable( ScreenData.SellTraits )

	SetPlayerInvulnerable( screen.Name )
	OnScreenOpened( screen )
	HideCombatUI( screen.Name, screen.TraitTrayArgs )
	CreateScreenFromData( screen, screen.ComponentData )	

	screen.ShopItemStartX = screen.ShopItemStartX + ScreenCenterNativeOffsetX
	screen.ShopItemStartY = screen.ShopItemStartY + ScreenCenterNativeOffsetY

	local outdatedData = false
	if CurrentRun.CurrentRoom.SellOptions == nil then
		outdatedData = true
	else
		for itemIndex, sellData in pairs( CurrentRun.CurrentRoom.SellOptions ) do
			if sellData.Name and not HeroHasTrait( sellData.Name ) then
				outdatedData = true
			end
		end
	end
	if outdatedData then
		CurrentRun.CurrentRoom.SellOptions = nil
		GenerateSellTraitShop( CurrentRun.CurrentRoom )
	end

	wait( 0.25 )
	CreateSellButtons( screen )

	if TableLength( CurrentRun.CurrentRoom.SellOptions ) > 0 then
		thread( PlayVoiceLines, HeroVoiceLines.SellTraitShopUsedVoiceLines, true )
	else
		thread( PlayVoiceLines, HeroVoiceLines.SellTraitShopSoldOutVoiceLines, true )
	end

	screen.KeepOpen = true
	HandleScreenInput( screen )

end

function CreateSellButtons( screen )

	local itemLocationStartY = screen.ShopItemStartY
	local itemLocationYSpacer = screen.ShopItemSpacerY
	local itemLocationMaxY = itemLocationStartY + 4 * itemLocationYSpacer

	local itemLocationStartX = screen.ShopItemStartX
	local itemLocationXSpacer = screen.ShopItemSpacerX
	local itemLocationMaxX = itemLocationStartX + 1 * itemLocationXSpacer

	local itemLocationX = itemLocationStartX
	local itemLocationY = itemLocationStartY

	local components = screen.Components

	local firstOption = true
	local sellList = {}
	local upgradeOptionsTable = {}
	for itemIndex, sellData in pairs( CurrentRun.CurrentRoom.SellOptions ) do
		for index, traitData in pairs( CurrentRun.Hero.Traits ) do
			if sellData.Name == traitData.Name and traitData.Rarity and ( upgradeOptionsTable[traitData.Name] == nil or GetRarityValue( upgradeOptionsTable[traitData.Name].Rarity ) > GetRarityValue( traitData.Rarity ) ) then
				upgradeOptionsTable[traitData.Name] = { Data = traitData, Value = sellData.Value }
			end
		end
	end

	for i, value in pairs( upgradeOptionsTable ) do
		table.insert( sellList, value )
	end

	local screenData = ScreenData.UpgradeChoice

	for itemIndex, sellData in ipairs( sellList ) do
		local upgradeData = sellData.Data
		if upgradeData ~= nil then
			local tooltipData = upgradeData
			local traitData = upgradeData
			SetTraitTextData( traitData )

			local purchaseButtonKey = "PurchaseButton"..itemIndex		
			local purchaseButton = DeepCopyTable( ScreenData.UpgradeChoice.PurchaseButton )
			purchaseButton.X = itemLocationX
			purchaseButton.Y = itemLocationY
			components[purchaseButtonKey] = CreateScreenComponent( purchaseButton )
			local button = components[purchaseButtonKey]
			button.Value = sellData.Value
			button.UpgradeName = traitData.Name
			button.ItemIndex = itemIndex

			local title = GetTraitTooltipTitle( traitData )
			local traitCount = GetTraitCount( CurrentRun.Hero, { TraitData = traitData } )
			if traitCount > 1 then
				title = "TraitLevel_Current"
				traitData.OldLevel = traitCount
				if not traitData.Title then
					traitData.Title = GetTraitTooltipTitle( traitData )
				end
			end

			local titleColor = Color.White
			local rarityPatchColor = Color.Transparent
	
			if traitData.CustomRarityColor then
				rarityPatchColor = traitData.CustomRarityColor
				titleColor = traitData.CustomRarityColor
			elseif button.OverrideRarity ~= nil and button.OverrideRarity ~= "Common" then
				rarityPatchColor = Color["BoonPatch"..button.OverrideRarity]
				titleColor = Color["BoonPatch"..button.OverrideRarity]
			elseif traitData.Rarity ~= nil and traitData.Rarity ~= "Common" then
				rarityPatchColor = Color["BoonPatch"..traitData.Rarity]
				titleColor = Color["BoonPatch"..traitData.Rarity]
			else
				local rarityLevel = GetNumShrineUpgrades( traitData.Name )
				if rarityLevel > 0 then
					local rarityName = TraitRarityData.WeaponRarityUpgradeOrder[rarityLevel]
					titleColor = Color["BoonPatch"..rarityName]
				end
			end

			local highlight = ShallowCopyTable( ScreenData.UpgradeChoice.Highlight )
			highlight.X = purchaseButton.X
			highlight.Y = purchaseButton.Y
			components[purchaseButtonKey.."Highlight"] = CreateScreenComponent( highlight )
			components[purchaseButtonKey].Highlight = components[purchaseButtonKey.."Highlight"]
	
			local icon = ShallowCopyTable( ScreenData.UpgradeChoice.Icon )
			icon.X = itemLocationX + ScreenData.UpgradeChoice.IconOffsetX
			icon.Y = itemLocationY + ScreenData.UpgradeChoice.IconOffsetY 
			icon.Animation = upgradeData.Icon
			components[purchaseButtonKey.."Icon"] = CreateScreenComponent( icon )

			local frame = ShallowCopyTable( ScreenData.UpgradeChoice.Frame )
			frame.X = itemLocationX + ScreenData.UpgradeChoice.IconOffsetX
			frame.Y = itemLocationY + ScreenData.UpgradeChoice.IconOffsetY 
			frame.Animation = GetTraitFrame( upgradeData )
			components[purchaseButtonKey.."Frame"] = CreateScreenComponent( frame )

			if IsGameStateEligible( screen, TraitRarityData.ElementalGameStateRequirements ) and not IsEmpty( traitData.Elements ) then
				local elementName = GetFirstValue( traitData.Elements )
				local elementIcon = ShallowCopyTable( screenData.ElementIcon )
				elementIcon.Group = screenData.ComponentData.DefaultGroup
				elementIcon.Name = TraitElementData[elementName].Icon
				elementIcon.X = itemLocationX + elementIcon.XShift - 350
				elementIcon.Y = itemLocationY + elementIcon.YShift
				components[purchaseButtonKey.."ElementIcon"] = CreateScreenComponent( elementIcon )
			end

			local rarity = upgradeData.Rarity
			if not rarity then
				rarity = "Common"
			end
			local text = "Boon_"..rarity
			local overlayLayer = ""
			if upgradeData.CustomRarityName then
				text = upgradeData.CustomRarityName
			end
			local color = Color["BoonPatch"..rarity]
			if upgradeData.CustomRarityColor then
				color = upgradeData.CustomRarityColor
			end

			local rarityText = ShallowCopyTable( screenData.RarityText )
			rarityText.Id = button.Id
			rarityText.Text = text
			rarityText.Color = color
			CreateTextBox( rarityText )

			local titleText = ShallowCopyTable( screenData.TitleText )
			titleText.Id = button.Id
			titleText.Text = title
			titleText.Color = titleColor
			titleText.LuaValue = traitData
			CreateTextBox( titleText )

			local descriptionText = ShallowCopyTable( screenData.DescriptionText )
			descriptionText.Id = button.Id
			descriptionText.Text = GetTraitTooltip( upgradeData )
			descriptionText.LuaKey = "TooltipData"
			descriptionText.LuaValue = upgradeData
			CreateTextBoxWithFormat( descriptionText )
			
			SetInteractProperty({ DestinationId = button.Id, Property = "TooltipOffsetX", Value = ScreenData.UpgradeChoice.TooltipOffsetX })

			local sellAmountFormat = ShallowCopyTable( screen.SellAmountFormat )
			sellAmountFormat.Id = components[purchaseButtonKey.."Icon"].Id
			sellAmountFormat.Text = "Sell_ItemCost"
			sellAmountFormat.LuaKey = "TempTextData"
			sellAmountFormat.LuaValue = { Amount = button.Value }
			CreateTextBox( sellAmountFormat )
			
			local statLines = upgradeData.StatLines
			local statLineData = upgradeData
			if statLines ~= nil then
				for lineNum, statLine in ipairs( statLines ) do
					if statLine ~= "" then

						local offsetY = (lineNum - 1) * ScreenData.UpgradeChoice.LineHeight
						if statLineData.ExtraDescriptionLine then
							offsetY = offsetY + ScreenData.UpgradeChoice.LineHeight
						end

						local statLineLeft = DeepCopyTable(ScreenData.UpgradeChoice.StatLineLeft)
						statLineLeft.Id = components[purchaseButtonKey].Id
						statLineLeft.Text = statLine
						statLineLeft.OffsetY = offsetY
						statLineLeft.LuaValue = statLineData
						statLineLeft.AppendToId = descriptionText.Id
						CreateTextBoxWithFormat( statLineLeft )

						local statLineRight = DeepCopyTable(ScreenData.UpgradeChoice.StatLineRight)
						statLineRight.Id = components[purchaseButtonKey].Id
						statLineRight.Text = statLine
						statLineRight.OffsetY = offsetY
						statLineRight.AppendToId = descriptionText.Id
						statLineRight.LuaValue = statLineData
						CreateTextBoxWithFormat( statLineRight )

					end
				end
			end

			button.Screen = screen
			AttachLua({ Id = button.Id, Table = button })
			button.Data = upgradeData
			button.WeaponName = currentWeapon
			button.Index = itemIndex
			button.OnPressedFunctionName = "HandleSellChoiceSelection"
			button.OnMouseOverFunctionName = "MouseOverWellShopButton"
			button.OnMouseOffFunctionName = "MouseOffWellShopButton"

			if firstOption then
				TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
				firstOption = false
			end
		end

		itemLocationX = itemLocationX + itemLocationXSpacer
		if itemLocationX >= itemLocationMaxX then
			itemLocationX = itemLocationStartX
			itemLocationY = itemLocationY + itemLocationYSpacer
		end
	end

	UpdateStoreReroll( screen, CurrentRun.CurrentRoom.SellOption, "SellTraitScreenReroll" )

end

function HandleSellChoiceSelection( screen, button )
	RemoveWeaponTrait( button.UpgradeName, { Silent = true } )
	AddResource( "Money", button.Value, "TraitSell" )

	for index, sellData in pairs( CurrentRun.CurrentRoom.SellOptions ) do
		if sellData.Name == button.UpgradeName then
			CurrentRun.CurrentRoom.SellOptions[index] = nil
		end
	end
	
	CurrentRun.CurrentRoom.TraitsSold = (CurrentRun.CurrentRoom.TraitsSold or 0) + 1
	CurrentRun.TraitsSold = (CurrentRun.TraitsSold or 0) + 1
	GameState.TraitsSold = (GameState.TraitsSold or 0) + 1

	local purchaseButtonKey = "PurchaseButton"..button.ItemIndex
	local clearIds = {}
	if screen.Components[purchaseButtonKey] ~= nil then
		table.insert( clearIds, screen.Components[purchaseButtonKey].Id )
	end
	if screen.Components[purchaseButtonKey.."Highlight"] ~= nil then
		table.insert( clearIds, screen.Components[purchaseButtonKey.."Highlight"].Id )
	end
	if screen.Components[purchaseButtonKey.."Icon"] ~= nil then
		table.insert( clearIds, screen.Components[purchaseButtonKey.."Icon"].Id )
	end
	if screen.Components[purchaseButtonKey.."Frame"] ~= nil then
		table.insert(clearIds, screen.Components[purchaseButtonKey.."Frame"].Id )
	end
	if screen.Components[purchaseButtonKey.."ElementIcon"] ~= nil then
		table.insert(clearIds, screen.Components[purchaseButtonKey.."ElementIcon"].Id )
	end
	if screen.Components[purchaseButtonKey.."Patch"] ~= nil then
		table.insert(clearIds, screen.Components[purchaseButtonKey.."Patch"].Id )
	end
	if screen.Components[purchaseButtonKey.."IconOverlay"] ~= nil then
		table.insert(clearIds, screen.Components[purchaseButtonKey.."IconOverlay"].Id )
	end
	if not IsEmpty( clearIds ) then
		Destroy({ Ids = clearIds })
	end

	--CreateAnimation({ Name = "BoonSlotPurchase", DestinationId = screen.Components["Backing".. button.Index].Id, OffsetX = 0 })
	PlaySound({ Name = "/SFX/Menu Sounds/SellTraitShopConfirm" })
	thread( PlayVoiceLines, HeroVoiceLines.SoldTraitVoiceLines, true )

end

function CloseSellTraitScreen( screen, button )
	SetAnimation({ Name = "SellShopOut", DestinationId = screen.Components.ShopBackground.Id })
	
	local useableOffButtonIds = {}
	for index = 1, 3 do
		if screen.Components["PurchaseButton"..index] and screen.Components["PurchaseButton"..index].Id then
			table.insert(useableOffButtonIds, screen.Components["PurchaseButton"..index].Id)
		end
	end
	UseableOff({ Ids = useableOffButtonIds, ForceHighlightOff = true })

	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	SetPlayerVulnerable("SellTraitMenuOpen")
	OnScreenCloseFinished( screen )

end


function SellTraitScreenReroll( screen )
	SellTraitScreenDestroyButtons( screen )
	local exclusions = {}
	if not IsEmpty( CurrentRun.CurrentRoom.SellOptions ) and not IsEmpty( CurrentRun.CurrentRoom.SellValues ) then
		exclusions = { GetRandomValue( CurrentRun.CurrentRoom.SellOptions ).Name }
	end
	CurrentRun.CurrentRoom.SellOptions = nil
	GenerateSellTraitShop( CurrentRun.CurrentRoom, { ExclusionNames = exclusions } )
	CreateSellButtons( screen )
end

function SellTraitScreenDestroyButtons( screen )
	local components = screen.Components
	local toDestroy = {}
	for index = 1, 3 do
		local destroyIndexes =
		{
			"PurchaseButton"..index,
			"PurchaseButton"..index.."Icon",
			"PurchaseButton"..index.."IconOverlay",
			"PurchaseButton"..index.."ElementIcon",
			"Backing"..index,
			"PurchaseButtonTitle"..index,
			"PurchaseButton"..index.."Frame",
			"PurchaseButton"..index.."Patch",
			"PurchaseButton"..index.."Highlight",
		}
		for i, indexName in pairs( destroyIndexes ) do
			if components[indexName] ~= nil then
				table.insert( toDestroy, components[indexName].Id )
			end
		end
	end

	Destroy({ Ids = toDestroy })
end

function GetBaseRarityValue( traitData )
	local rarityKey = traitData.Rarity
	if traitData.IsElementalTrait then
		rarityKey = "Elemental"
	end
	
	if traitData.Rarity and SellTraitData.RarityValues[rarityKey] then
		return math.floor( RandomInt( SellTraitData.RarityValues[rarityKey].Min, SellTraitData.RarityValues[rarityKey].Max ) / SellTraitData.RoundToNearestValue ) * SellTraitData.RoundToNearestValue
	end
	return SellTraitData.BaseValue
end

function GetTraitValue( traitData )
	local baseValue = GetBaseRarityValue( traitData )
	local stackValue = (GetTraitCount(CurrentRun.Hero, { TraitData = traitData }) - 1) * math.floor( RandomInt( SellTraitData.StackValue.Min, SellTraitData.StackValue.Max ) / SellTraitData.RoundToNearestValue ) * SellTraitData.RoundToNearestValue
	return round(( baseValue + stackValue ))
end
