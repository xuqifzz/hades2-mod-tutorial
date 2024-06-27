function HasAnyAspectUnlocked( weaponName )
	for traitName, traitData in pairs( TraitSetData.Aspects ) do
		if traitData.RequiredWeapon == weaponName and GameState.WorldUpgradesAdded[traitName] then
			return true
		end
	end
	return false
end

function OpenWeaponUpgradeScreen( args )

	local screen = DeepCopyTable( ScreenData.WeaponUpgradeScreen )
	
	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	local weaponName = args.WeaponName
	local weaponData = WeaponData[weaponName]
	
	local components = screen.Components

	ModifyTextBox({ Id = components.TitleText.Id, Text = weaponName.."_Aspects" })
	ModifyTextBox({ Id = components.TitleFlavorText.Id, Text = weaponName.."_Aspects", UseDescription = true, })

	local weaponKills = GameState.WeaponKills[weaponName]
	ModifyTextBox({ Id = components.KillsValue.Id, Text = weaponKills })

	local weaponClears = GetNumRunsClearedWithWeapon( weaponName )
	ModifyTextBox({ Id = components.ClearsValue.Id, Text = weaponClears })

	local fastestClearTime = GetFastestRunClearTimeWithWeapon( CurrentRun, weaponName )
	if fastestClearTime ~= nil then
		ModifyTextBox({ Id = components.ClearTimeRecordValue.Id, Text = GetTimerString( fastestClearTime, 2 ) })
	end

	local highestShrinePoints = GetHighestShrinePointRunClearWithWeapon( CurrentRun, weaponName )
	ModifyTextBox({ Id = components.ShrinePointRecordValue.Id, Text = highestShrinePoints })

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoud" })

	thread( PlayVoiceLines, GlobalVoiceLines.OpenedWeaponUpgradeMenuVoiceLines, true, CurrentRun.Hero, args )

	local freeUnlockName = screen.FreeUnlocks[weaponName]
	if freeUnlockName ~= nil then
		GameState.WeaponsUnlocked[freeUnlockName] = true
	end

	local itemIndex = 0
	for i, itemName in ipairs( screen.DisplayOrder[weaponName] ) do
		local rawTraitData = TraitData[itemName]
		if rawTraitData ~= nil and GameState.WeaponsUnlocked[itemName] then
			itemIndex = itemIndex + 1

			local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemName, Rarity = GetRarityKey( GetWeaponUpgradeLevel( itemName ), TraitRarityData.WeaponRarityUpgradeOrder ) })
			SetTraitTextData( traitData )

			local purchaseButtonKey = "PurchaseButton"..itemIndex
			local slotData = DeepCopyTable( screen.ButtonSlotData )
			local locationX = screen.ItemStartX
			local locationY = screen.ItemStartY + ( (itemIndex - 1) * screen.ItemSpacingY ) 
			slotData.X = locationX
			slotData.Y = locationY
			slotData.Animation = rawTraitData.InfoBackingAnimation

			local button = CreateComponentFromData( screen, slotData )
			components[purchaseButtonKey] = button
			button.OnPressedFunctionName = "HandleWeaponUpgradeSelection"
			button.OnMouseOverFunctionName = "MouseOverWeaponUpgrade"
			button.OnMouseOffFunctionName = "MouseOffWeaponUpgrade"
			button.Screen = screen
			button.WeaponName = weaponName
			button.TraitData = traitData 
			SetInteractProperty({ DestinationId = button.Id, Property = "TooltipOffsetX", Value = screen.TooltipOffsetX })
			AttachLua({ Id = button.Id, Table = button })

			local highlight = ShallowCopyTable( screen.Highlight )
			highlight.X = button.X
			highlight.Y = button.Y
			components[purchaseButtonKey.."Highlight"] = CreateScreenComponent( highlight )
			button.Highlight = components[purchaseButtonKey.."Highlight"]
			
			-- Hidden description for tooltip
			CreateTextBox({ Id = components[purchaseButtonKey].Id,
				Text = traitData.Name,
				UseDescription = true,
				Color = Color.Transparent,
				LuaKey = "TooltipData",
				LuaValue = traitData,
			})
			if traitData.StatLines then
				CreateTextBox({ Id = components[purchaseButtonKey].Id,
					Text = traitData.StatLines[1],
					Color = Color.Transparent,
					LuaKey = "TooltipData",
					LuaValue = traitData,
				})
			end

			components[purchaseButtonKey.."EquippedIcon"] = CreateScreenComponent( screen.EquippedIcon )
			Attach({ Id = components[purchaseButtonKey.."EquippedIcon"].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.EquippedIcon.OffsetX, OffsetY = screen.EquippedIcon.OffsetY })

			local childrenNames = GetAllKeys( slotData.Children )
			for _, name in pairs( childrenNames ) do
				if Contains( slotData.ChildrenOrder, name ) then
					slotData.ChildrenOrder[GetKey(slotData.ChildrenOrder, name)] = name..itemIndex
				end
				slotData.Children[name..itemIndex] = slotData.Children[name]
				slotData.Children[name] = nil
			end

			AttachChildrenFromData( screen, components[purchaseButtonKey], slotData, screen )
		
			if traitData.Icon ~= nil then
				SetAnimation({ Name = traitData.Icon, DestinationId = components["InfoBoxIcon"..itemIndex].Id })
				SetAlpha({ Id = components["InfoBoxIcon"..itemIndex].Id, Fraction = 1.0, Duration = 0.2 })
				SetAlpha({ Id = components["InfoBoxFrame"..itemIndex].Id, Fraction = 1.0, Duration = 0.2 })
			end

			local rarityColor = Color.White
			if traitData.Rarity then
				rarityColor = Color["BoonPatch"..traitData.Rarity]
				SetAnimation({ DestinationId = components["InfoBoxFrame"..itemIndex].Id, Name = "Frame_Boon_Menu_"..traitData.Rarity })
			end
			ModifyTextBox({ Id = components["InfoBoxName"..itemIndex].Id,
				Text = traitData.Title,
				LuaKey = "TooltipData",
				LuaValue = traitData,
				Color = rarityColor,
			})
			local rarityLevel = GetRarityValue( traitData.Rarity )
			ModifyTextBox({ Id = components["InfoBoxRarity"..itemIndex].Id,
				Text = TraitRarityData.AspectRarityText[rarityLevel],
				Color = rarityColor,
			})

			ModifyTextBox({ Id = components["InfoBoxDescription"..itemIndex].Id,
				Text = traitData.Name,
				UseDescription = true,
				LuaKey = "TooltipData",
				LuaValue = traitData,
			})

			local statLine = traitData.StatLines[1]
			ModifyTextBox({ Id = components["InfoBoxStatLineLeft"..itemIndex].Id, AppendToId = components["InfoBoxDescription"..itemIndex].Id, Text = statLine, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0 })
			ModifyTextBox({ Id = components["InfoBoxStatLineRight"..itemIndex].Id, AppendToId = components["InfoBoxDescription"..itemIndex].Id, Text = statLine, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0 })
	
			ModifyTextBox({ Id = components["InfoBoxFlavor"..itemIndex].Id,
				Text = traitData.FlavorText,
			})

			if HeroHasTrait( traitData.Name ) then
				SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation, GrannyModel = traitData.WeaponKitGrannyModel, DestinationId = components.WeaponImage.Id })		
				TeleportCursor({ OffsetX = ScreenCenterX + 40, OffsetY = 20 + itemIndex * 220, ForceUseCheck = true })
			end
		end
	end

	UpdateWeaponUpgradeButtons( screen )

	screen.KeepOpen = true
	screen.CanClose = true
	HandleScreenInput( screen )
end

function UpdateWeaponUpgradeButtons( screen, weaponName )
	local components = screen.Components
	for itemIndex = 1, 5 do
		local purchaseButtonKey = "PurchaseButton"..itemIndex
		local purchaseButton = components[purchaseButtonKey]
		if purchaseButton ~= nil then
			local traitData = purchaseButton.TraitData
			if HeroHasTrait( traitData.Name ) then
				SetAlpha({ Id = components[purchaseButtonKey.."EquippedIcon"].Id, Fraction = 1.0, Duration = 0.1 })
			else
				SetAlpha({ Id = components[purchaseButtonKey.."EquippedIcon"].Id, Fraction = 0.0, Duration = 0.1 })
			end
		end
	end
end

function SelectWeaponUpgrade( screen, weaponName, traitData )

	if GameState.LastWeaponUpgradeName[weaponName] == traitData.Name then
		-- Already equipped
		return
	end

	PlaySound({ Name = traitData.EquipSound or "/Leftovers/SFX/PerfectTiming" })

	if GameState.LastWeaponUpgradeName[weaponName] ~= nil then
		-- Unequip previous trait
		RemoveTrait( CurrentRun.Hero, GameState.LastWeaponUpgradeName[weaponName] )
	end

	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName, UnloadPackages = false })
	local weaponSetNames = WeaponSets.HeroWeaponSets[weaponName]
	if weaponSetNames ~= nil then
		for k, linkedWeaponName in ipairs( weaponSetNames ) do
			UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName, UnloadPackages = false })
		end
	end

	EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })

	if weaponSetNames ~= nil then
		for k, linkedWeaponName in ipairs( weaponSetNames ) do
			EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
		end
	end

	GameState.LastWeaponUpgradeName[weaponName] = traitData.Name

	-- Equip new trait
	EquipWeaponUpgrade( existingHero, { SkipTraitHighlight = true } )
	thread( PlayVoiceLines, GlobalVoiceLines.SwitchedWeaponUpgradeVoiceLines, true )

	screen.AspectChanged = true

end

function HandleWeaponUpgradeSelection( screen, button )
	local weaponName = button.WeaponName
	local traitData = button.TraitData

	if GameState.LastWeaponUpgradeName[weaponName] == traitData.Name then
		-- Already equipped
		return
	end

	SelectWeaponUpgrade( screen, weaponName, traitData )
	UpdateWeaponUpgradeButtons( screen, weaponName )
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 0, Duration = 0.1 })

	local weaponData = WeaponData[weaponName]
	--SetThingProperty({ Property = "GrannyModel", Value = traitData.WeaponKitGrannyModel, DestinationId = screen.Components.WeaponImage.Id })
	SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation, GrannyModel = traitData.WeaponKitGrannyModel, DestinationId = screen.Components.WeaponImage.Id, CopyFromPrev = true })	

end

function MouseOverWeaponUpgrade( button )
	local screen = button.Screen
	if not HeroHasTrait( button.TraitData.Name ) then
		SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 1, Duration = 0.1 })
	end
	SetAnimation({ DestinationId = button.Highlight.Id, Name = "BoonSlotHighlight" })
end

function MouseOffWeaponUpgrade( button )
	local screen = button.Screen
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 0, Duration = 0.1 })
	SetAnimation({ DestinationId = button.Highlight.Id, Name = "BoonHighlightOut" })
end

function CloseWeaponUpgradeScreen( screen )
	if screen == nil or not screen.CanClose then
		return
	end
	screen.CanClose = false
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16.0 })

	local currentWeaponInSlot = GetEquippedWeapon()
	local weaponData = WeaponData[currentWeaponInSlot]
	local weaponDataOverride = GetWeaponData( CurrentRun.Hero, currentWeaponInSlot )
	local closeAnim = weaponData.PostWeaponUpgradeScreenAnimation
	local closeAngle = weaponData.PostWeaponUpgradeScreenAngle or 290
	local closeFunctionName = weaponData.PostWeaponUpgradeScreenFunctionName
	for k, trait in pairs( CurrentRun.Hero.Traits ) do
		closeAnim = trait.PostWeaponUpgradeScreenAnimation or closeAnim
		closeAngle = trait.PostWeaponUpgradeScreenAngle or closeAngle
		closeFunctionName = trait.PostWeaponUpgradeScreenFunctionName or closeFunctionName
	end
	if closeFunctionName ~= nil and _G[closeFunctionName] ~= nil then
		_G[closeFunctionName]( CurrentRun.Hero )
	end
	if closeAnim ~= nil then
		SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = closeAngle, CompleteAngle = true })
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = closeAnim })
	end

	if screen.AspectChanged then
		RequestPreRunLoadoutChangeSave()
	end

	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	
	-- check if player equipped a different trait since opening screen
	if screen.HasChanges or screen.ChangedEquipment then
		thread( PlayVoiceLines, GlobalVoiceLines.ClosedWeaponUpgradeMenuVoiceLines, false )
		if MapState.WeaponKits ~= nil then
			for kitId, kitData in pairs( MapState.WeaponKits ) do
				if kitData ~= nil and kitData.Name == currentWeaponInSlot then
					StopAnimation({ Name = "WeaponBonusFxBack", DestinationId = kitId })
					if GetWeaponKitAnimation( weaponData.Name, "Equipped" ) ~= nil then
						SetAnimation({ Name = GetWeaponKitAnimation( weaponData.Name, "Equipped" ), DestinationId = kitId })
					end
				end
			end
		end
	end

	thread( CloseWeaponUpgradeScreenPresentation, screen )

	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
	wait( 0.3 )
	CheckAutoObjectiveSets( CurrentRun, "WeaponPickup" )
end

function EquipLastWeaponUpgrade( eventSource, args )
	EquipWeaponUpgrade( CurrentRun.Hero, args )
end

function GetEquippedWeapon()
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		if CurrentRun.Hero.Weapons[weaponName] then
			return weaponName
		end
	end
end

function GetWeaponKitAnimation( weaponName, type )
	local referencedTable = WeaponData[weaponName]
	
	if type == "Equipped" then
		return referencedTable.EquippedKitAnimation
	elseif type == "Unequipped" then
		return referencedTable.UnequippedKitAnimation
	elseif type == "BonusUnequipped" then
		return referencedTable.BonusUnequippedKitAnimation
	elseif type == "BonusEquipped" then
		return referencedTable.BonusEquippedKitAnimation
	end

end

function UnequipWeaponUpgrade()
	local currentWeaponName = GetEquippedWeapon()
	local condemnedTraits = {}
	for _, traitData in pairs(CurrentRun.Hero.Traits) do
		if traitData.IsWeaponEnchantment then
			table.insert(condemnedTraits, traitData )
		end
	end
	for _, traitData in pairs(condemnedTraits) do
		RemoveTraitData( CurrentRun.Hero, traitData )
	end
	
end

function EquipWeaponUpgrade( hero, args )
	args = args or {}
	local currentWeaponName = GetEquippedWeapon()
	local currentWeaponData = WeaponData[currentWeaponName]

	local traitName = GameState.LastWeaponUpgradeName[currentWeaponName]
	if traitName == nil then
		if currentWeaponData ~= nil and currentWeaponData.DummyTraitName ~= nil and not HeroHasTrait( currentWeaponData.DummyTraitName ) then
			AddTraitToHero({ SkipNewTraitHighlight = args.SkipTraitHighlight, TraitName = currentWeaponData.DummyTraitName })
			UpdateWeaponKitUpgrade(currentWeaponName, traitName)
		end
		return
	end

	if HeroHasTrait( traitName ) then
		-- Already equipped
		return
	end
	local numRanks = GetWeaponUpgradeLevel( traitName )
	local rarity = TraitRarityData.WeaponRarityUpgradeOrder[numRanks]
	AddTraitToHero({ SkipNewTraitHighlight = args.SkipTraitHighlight, TraitName = traitName, Rarity = rarity })
	UpdateWeaponKitUpgrade(currentWeaponName, traitName)
	RefillMana()
end

function GetWeaponUpgradeLevel( traitName )
	local numRanks = 1
	for unlockName, value in pairs( GameState.WeaponsUnlocked ) do
		local shopItemData = WeaponShopItemData[unlockName]
		if shopItemData ~= nil and shopItemData.TraitUpgrade == traitName then
			numRanks = numRanks + 1
		end
	end
	return numRanks
end

function IsWeaponUpgradeAtMax( traitName )
	for itemName, itemData in pairs ( WeaponShopItemData ) do
		if ( itemName == traitName or itemData.TraitUpgrade == traitName ) and not GameState.WeaponsUnlocked[itemName] then
			return false
		end
	end
	return true
end