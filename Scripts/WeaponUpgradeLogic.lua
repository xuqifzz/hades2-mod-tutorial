function HasAnyAspectUnlocked( weaponName )
	for traitName, traitData in pairs( TraitSetData.Aspects ) do
		if traitData.RequiredWeapon == weaponName and GameState.WorldUpgradesAdded[traitName] then
			return true
		end
	end
	return false
end

function OpenWeaponUpgradeScreen( args )

	AltAspectRatioFramesShow()

	local screen = DeepCopyTable( ScreenData.WeaponUpgradeScreen )
	
	HideCombatUI( screen.Name )
	wait( 0.1 )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY

	local weaponName = args.WeaponName
	local weaponData = WeaponData[weaponName]
	
	local components = screen.Components

	ModifyTextBox({ Id = components.TitleText.Id, Text = weaponName.."_Aspects" })
	ModifyTextBox({ Id = components.TitleFlavorText.Id, Text = weaponName.."_Aspects", UseDescription = true, })

	local weaponKills = GameState.WeaponKills[weaponName] or 0
	for i, linkedWeaponName in ipairs( WeaponSets.HeroWeaponSets[weaponName] ) do
		weaponKills = weaponKills + (GameState.WeaponKills[linkedWeaponName] or 0)
	end
	if weaponKills == 0 then
		weaponKills = nil
	end
	ModifyTextBox({ Id = components.KillsValue.Id, Text = weaponKills })

	local clearStats = WeaponUpgradeScreenGetStats( screen, weaponName )
	if clearStats ~= nil then
		if clearStats.ClearCount ~= nil then
			ModifyTextBox({ Id = components.ClearsValue.Id, Text = clearStats.ClearCount })
		end
		if clearStats.FastestTimeUnderworld ~= nil then
			ModifyTextBox({ Id = components.UnderworldClearTimeRecordValue.Id, Text = GetTimerString( clearStats.FastestTimeUnderworld, 2 ) })
		end
		if clearStats.FastestTimeSurface ~= nil then
			ModifyTextBox({ Id = components.SurfaceClearTimeRecordValue.Id, Text = GetTimerString( clearStats.FastestTimeSurface, 2 ) })
		end
		if clearStats.HighestShrinePointsUnderworld ~= nil then
			ModifyTextBox({ Id = components.UnderworldShrinePointRecordValue.Id, Text = clearStats.HighestShrinePointsUnderworld })
		end
		if clearStats.HighestShrinePointsSurface ~= nil then
			ModifyTextBox({ Id = components.SurfaceShrinePointRecordValue.Id, Text = clearStats.HighestShrinePointsSurface })
		end
	end

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
			slotData.Alpha = 0.0
			slotData.AlphaTarget = 1.0
			slotData.AlphaTargetDuration = 0.4
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

			local equippedIcon = CreateScreenComponent( screen.EquippedIcon )
			components[purchaseButtonKey.."EquippedIcon"] = equippedIcon
			button.EquippedIcon = equippedIcon
			Attach({ Id = equippedIcon.Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.EquippedIcon.OffsetX, OffsetY = screen.EquippedIcon.OffsetY })

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

	local weaponUpgradeSwitchFx = CreateScreenObstacle({ Name = "BlankObstacle", X = 200 + ScreenCenterNativeOffsetX, Y = 360 + ScreenCenterNativeOffsetY, Group = "Combat_Menu_Overlay_Additive", })
	SetAnimation({ Name = "WeaponUpgradeSwitchFx", DestinationId = weaponUpgradeSwitchFx })
	DestroyOnDelay({ Id = weaponUpgradeSwitchFx, 3 })

	local prevTraitData = GetHeroTrait(GameState.LastWeaponUpgradeName[weaponName])
	if prevTraitData and prevTraitData.LinkedSpell then
		UnequipLinkedSpell( prevTraitData )
		local traitName = SpellData[prevTraitData.LinkedSpell].TraitName
		local spellTrait = GetHeroTrait(traitName)
		RemoveTrait( CurrentRun.Hero, spellTrait.Name )
	end
	PlaySound({ Name = traitData.EquipSound or "/Leftovers/SFX/PerfectTiming" })

	if GameState.LastWeaponUpgradeName[weaponName] ~= nil then
		-- Unequip previous trait
		if prevTraitData.OnUnequipFunctionName then
			thread( CallFunctionName, prevTraitData.OnUnequipFunctionName )
		end
		if prevTraitData.StopVfxOnUnequip then
			StopAnimation({ Name = prevTraitData.StopVfxOnUnequip, DestinationId = CurrentRun.Hero.ObjectId})
		end
		RemoveTrait( CurrentRun.Hero, GameState.LastWeaponUpgradeName[weaponName] )
	end

	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName, UnloadPackages = false })
	MapState.EquippedWeapons[weaponName] = nil
			
	local weaponSetNames = WeaponSets.HeroWeaponSets[weaponName]
	if weaponSetNames ~= nil then
		for k, linkedWeaponName in ipairs( weaponSetNames ) do
			UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName, UnloadPackages = false })
			MapState.EquippedWeapons[linkedWeaponName] = nil
		end
	end
	
	EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
	MapState.EquippedWeapons[weaponName] = true
	if weaponSetNames ~= nil then
		for k, linkedWeaponName in ipairs( weaponSetNames ) do
			EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
			MapState.EquippedWeapons[linkedWeaponName] = true
		end
	end
	-- Weapon upgrade code blows away all property changes related to the weapon
	OrderAndApplyPropertyChanges( ToLookup(weaponSetNames) )

	GameState.LastWeaponUpgradeName[weaponName] = traitData.Name

	-- Equip new trait
	EquipWeaponUpgrade( existingHero, { SkipTraitHighlight = true, SkipUIUpdate = true } )
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
	SetAnimation({ DestinationId = button.EquippedIcon.Id, Name = "ActiveAspectFlash" }) --nopkg

	local weaponData = WeaponData[weaponName]
	--SetThingProperty({ Property = "GrannyModel", Value = traitData.WeaponKitGrannyModel, DestinationId = screen.Components.WeaponImage.Id })
	SetScale({ Id = screen.Components.WeaponImage.Id, Fraction = 1.25 })
	SetScale({ Id = screen.Components.WeaponImage.Id, Fraction = 2.5, Duration = 0.15, EaseIn = 0.9, EaseOut = 1.0 })
	SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation, GrannyModel = traitData.WeaponKitGrannyModel, DestinationId = screen.Components.WeaponImage.Id, CopyFromPrev = true })

end

function MouseOverWeaponUpgrade( button )
	local screen = button.Screen
	screen.ClipboardText = button.TraitData.Name
	if not HeroHasTrait( button.TraitData.Name ) then
		SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 1, Duration = 0.1 })
	end
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle", Id = button.Id })
	SetAnimation({ DestinationId = button.Highlight.Id, Name = "BoonHighlightIn" }) --nopkg
end

function MouseOffWeaponUpgrade( button )
	local screen = button.Screen
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 0, Duration = 0.1 })
	SetAnimation({ DestinationId = button.Highlight.Id, Name = "BoonHighlightOut" }) --nopkg
end

function CloseWeaponUpgradeScreen( screen )
	if screen == nil or not screen.CanClose then
		return
	end
	screen.CanClose = false
	SetAnimation({ DestinationId = screen.Components.Background.Id, Name = "WeaponUpgradeOut" })
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16.0 })

	local currentWeaponInSlot = GetEquippedWeapon()
	local weaponData = WeaponData[currentWeaponInSlot]
	local weaponDataOverride = GetWeaponData( CurrentRun.Hero, currentWeaponInSlot )
	local closeAnim = weaponData.PostWeaponUpgradeScreenAnimation
	local closeAngle = weaponData.PostWeaponUpgradeScreenAngle or 290
	local closeFunctionName = weaponData.PostWeaponUpgradeScreenFunctionName
	for k, trait in ipairs( CurrentRun.Hero.Traits ) do
		closeAnim = trait.PostWeaponUpgradeScreenAnimation or closeAnim
		closeAngle = trait.PostWeaponUpgradeScreenAngle or closeAngle
		closeFunctionName = trait.PostWeaponUpgradeScreenFunctionName or closeFunctionName
	end
	if closeFunctionName ~= nil and _G[closeFunctionName] ~= nil then
		_G[closeFunctionName]( CurrentRun.Hero, weaponData )
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
	AltAspectRatioFramesHide()
	
	if screen.AspectChanged then
		thread( PlayVoiceLines, GlobalVoiceLines.ClosedWeaponUpgradeMenuVoiceLines, false )
	end

	thread( CloseWeaponUpgradeScreenPresentation, screen )

	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
	wait( 0.3 )
	if GameState.ActiveObjectiveSet == nil or ObjectiveSetData[GameState.ActiveObjectiveSet] == nil or not ObjectiveSetData[GameState.ActiveObjectiveSet].BlockWeaponObjectives then
		CheckAutoObjectiveSets( CurrentRun, "WeaponPickup" )
	end
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

function UnequipLinkedSpell( traitData )
	UpdateHeroTraitDictionary()
	local spellName = traitData.LinkedSpell
	local traitName = SpellData[traitData.LinkedSpell].TraitName
	local spellTrait = GetHeroTrait(traitName)
	if not IsEmpty(spellTrait.PreEquipWeapons) then
		UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = spellTrait.PreEquipWeapons[1], UnloadPackages = true })
		MapState.EquippedWeapons[spellTrait.PreEquipWeapons[1]] = nil
	end
	SpellUnreadyPresentation( spellTrait )
	TraitUIRemove( spellTrait )
	CurrentRun.Hero.SlottedSpell = nil
	UpdateTalentPointInvestedCache()
end

function UnequipWeaponUpgrade( args )
	args = args or {}
	local currentWeaponName = GetEquippedWeapon()
	local condemnedTraits = {}
	local parentTraitData = nil
	for _, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.IsWeaponEnchantment then
			table.insert(condemnedTraits, traitData )
			if traitData.LinkedSpell then
				UnequipLinkedSpell( traitData )
				local traitName = SpellData[traitData.LinkedSpell].TraitName
				local spellTrait = GetHeroTrait(traitName)
				table.insert(condemnedTraits, spellTrait)
			end
			if not args.SkipUnequipFunctionName and traitData.OnUnequipFunctionName then
				thread( CallFunctionName, traitData.OnUnequipFunctionName )
			end
			if traitData.StopVfxOnUnequip then
				StopAnimation({ Name = traitData.StopVfxOnUnequip, DestinationId = CurrentRun.Hero.ObjectId})
			end
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
			AddTraitToHero({ SkipNewTraitHighlight = args.SkipTraitHighlight, TraitName = currentWeaponData.DummyTraitName, SkipUIUpdate = args.SkipUIUpdate, SkipQuestStatusCheck = args.SkipQuestStatusCheck })
			if not args.SkipUIUpdate then
				UpdateWeaponKitUpgrade( currentWeaponName, traitName )
			end
		end
		return
	end

	if HeroHasTrait( traitName ) then
		-- Already equipped
		return
	end
	local numRanks = GetWeaponUpgradeLevel( traitName )
	local rarity = TraitRarityData.WeaponRarityUpgradeOrder[numRanks]

	AddTraitToHero({ SkipNewTraitHighlight = args.SkipTraitHighlight, SkipQuestStatusCheck = args.SkipQuestStatusCheck, TraitName = traitName, Rarity = rarity })
	if TraitData[traitName].LinkedSpell then
		local spellName = TraitData[traitName].LinkedSpell
		local traitName = SpellData[TraitData[traitName].LinkedSpell].TraitName
		local traitData = AddTraitToHero({ TraitName = traitName, SkipUIUpdate = args.SkipUIUpdate, SkipNewTraitHighlight = args.SkipTraitHighlight, SkipQuestStatusCheck = args.SkipQuestStatusCheck })
		if traitData.CheckChargeFunctionName then
			thread( CallFunctionName, traitData.CheckChargeFunctionName, CurrentRun.Hero )
		end
		CurrentRun.Hero.SlottedSpell = DeepCopyTable( SpellData[spellName] )
		CurrentRun.Hero.SlottedSpell.Talents = DeepCopyTable( CreateTalentTree( SpellData[spellName] ) )
		local spellData = CurrentRun.Hero.SlottedSpell
		UpdateTalentPointInvestedCache()
		UpdateSpellActiveStatus()
		UpdateHeroTraitDictionary()
	end
	UpdateWeaponKitUpgrade( currentWeaponName, traitName, args )
	RefillMana()

	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		local weaponData = WeaponData[weaponName]
		if weaponData.DummyTraitName ~= nil then
			RemoveTrait( CurrentRun.Hero, weaponData.DummyTraitName )
		end
	end

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

function WeaponUpgradeScreenGetStats( screen, weaponName )
	local traitNames = {}
	for i, itemName in ipairs( screen.DisplayOrder[weaponName] ) do
		table.insert( traitNames, itemName )
		local dummyName = ScreenData.GameStats.WeaponBaseAspectMapping[itemName]
		if dummyName ~= nil then
			table.insert( traitNames, dummyName )
		end
	end

	local result = {}
	for i, traitName in ipairs( traitNames ) do
		local traitStat = GameState.LifetimeTraitStats[traitName]
		if traitStat ~= nil then
			if traitStat.ClearCount ~= nil then
				result.ClearCount = (result.ClearCount or 0) + traitStat.ClearCount
			end
			if traitStat.FastestTimeUnderworld ~= nil and traitStat.FastestTimeUnderworld < (result.FastestTimeUnderworld or 999999) then
				result.FastestTimeUnderworld = traitStat.FastestTimeUnderworld
			end
			if traitStat.FastestTimeSurface ~= nil and traitStat.FastestTimeSurface < (result.FastestTimeSurface or 999999) then
				result.FastestTimeSurface = traitStat.FastestTimeSurface
			end
			if traitStat.HighestShrinePointsUnderworld ~= nil and traitStat.HighestShrinePointsUnderworld > (result.HighestShrinePointsUnderworld or 0) then
				result.HighestShrinePointsUnderworld = traitStat.HighestShrinePointsUnderworld
			end
			if traitStat.HighestShrinePointsSurface ~= nil and traitStat.HighestShrinePointsSurface > (result.HighestShrinePointsSurface or 0) then
				result.HighestShrinePointsSurface = traitStat.HighestShrinePointsSurface
			end
		end
	end
	return result
end
