function OpenSpellScreen( spellItem, args, user )

	args = args or {}
	args.SpellName = args.SpellName or spellItem.LootName
	
	if spellItem.ResourceCosts ~= nil and not HasResources( spellItem.ResourceCosts ) then
		CantAffordPresentation( spellItem )
		return
	end
	if args.PackageName then
		LoadPackages({ Name = args.PackageName })
	end
	if HasResourceCost(spellItem.ResourceCosts) then
		spellItem.Purchased = true
		SpendResources( spellItem.ResourceCosts, spellItem.Name or "Loot" )
		RemoveStoreItem( { Id = spellItem.ObjectId, Name = spellItem.Name } )
		if (spellItem.ResourceCosts.Money or 0) > 0 then
			CheckCharonPointsOwed( "UseLoot" )
		end
		PlaySound({ Name = "/Leftovers/Menu Sounds/StoreBuyingItem" })
		thread( PlayVoiceLines, GlobalVoiceLines.PurchasedConsumableVoiceLines, true )
	end
	local screenName = "SpellScreen"

	CurrentRun.Hero.UntargetableFlags[screenName] = true
	SetPlayerInvulnerable( screenName )
	AddPlayerImmuneToForce( screenName )

	-- Not allowed to quit after seeing otherwise hidden choices
	InvalidateCheckpoint()

	local screen = DeepCopyTable( ScreenData[screenName] )
	screen.Source = spellItem
	screen.SourceItemName = args.SourceItemName or spellItem.Name
	screen.StripRequirements = spellItem.StripRequirements
	
	HideCombatUI( screen.Name )	
	OnScreenOpened( screen )
	if HeroHasTrait( "SpellTalentKeepsake" ) then
		local trait = GetHeroTrait("SpellTalentKeepsake")
		ReduceTraitUses( trait, {Force = true })
		trait.CustomTrayText = trait.ZeroBonusTrayText
	end
	if spellItem ~= nil then
		LootPickupPresentation( spellItem )
		RecordConsumableItem( spellItem )
		MapState.RoomRequiredObjects[spellItem.ObjectId] = nil	
		if spellItem.ManualRecordUse then
			RecordUse( spellItem.ObjectId, spellItem.Name )
		end

		if spellItem.RespawnAfterUse then
			local newSpellItemId = SpawnObstacle({ Name = "SpellDrop", DestinationId = spellItem.ObjectId })
			local newSpellItem = CreateConsumableItem( newSpellItemId, "SpellDrop", 0 )
			newSpellItem.RespawnAfterUse = spellItem.RespawnAfterUse		
			newSpellItem.StripRequirements = spellItem.StripRequirements
		end
	
		SetAlpha({ Id = spellItem.ObjectId, Fraction = 0.0 })
		UseableOff({ Id = spellItem.ObjectId })
	end

	AltAspectRatioFramesShow()

	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = true })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 32 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 15 })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_Overlay" })
	
	if spellItem ~= nil and spellItem.RotateAfterUse and CurrentRun.Hero.SlottedSpell then
		MapState.GeneratedSpells = MapState.GeneratedSpells or {}
		RemoveTrait( CurrentRun.Hero, CurrentRun.Hero.SlottedSpell.Name )
		local eligibleSpells = {}
		for spellName, spellData in pairs( SpellData ) do
			if not spellData.Skip and not Contains( MapState.GeneratedSpells, spellName ) then
				table.insert( eligibleSpells, spellData )
			end
		end
		if IsEmpty( eligibleSpells ) then
			MapState.GeneratedSpells = {}
			eligibleSpells = { ChooseSpell( CurrentRun.CurrentRoom, args ) }
		end
		CurrentRun.Hero.SlottedSpell = DeepCopyTable( eligibleSpells[1] )
		CurrentRun.Hero.SlottedSpell.Talents = CreateTalentTree( SpellData[CurrentRun.Hero.SlottedSpell.Name] )	
		AddTraitToHero({ TraitName = CurrentRun.Hero.SlottedSpell.TraitName })
		table.insert( MapState.GeneratedSpells, CurrentRun.Hero.SlottedSpell.Name )
	end
	OpenSpellScreenPresentation( screen, spellItem )

	local components = screen.Components
	CreateScreenFromData( screen, screen.ComponentData )
	
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.5 })
	
	if spellItem ~= nil then
		ModifyTextBox({ Id = components.TitleText.Id, Text = spellItem.MenuTitle, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData })
	
		if spellItem.FlavorTextIds ~= nil then
			local flavorText = GetRandomValue( spellItem.FlavorTextIds )		
			ModifyTextBox({ Id = components.FlavorText.Id, Text = flavorText })
		end
	end

	CreateSpellButtons( screen )
	-- Short delay to let animations finish and prevent accidental input
	wait(0.5)
	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function ChooseSpell( room, args )
	args = args or {}
	local eligibleSpells = {}
	for spellName, spellData in pairs( SpellData ) do
		if HeroHasTrait( spellData.TraitName ) then
			return DeepCopyTable( spellData )
		end
		if args.SpellName == spellName or room.ForceLootName == spellName then
			return spellData
		end
		if IsGameStateEligible( CurrentRun, spellData, spellData.GameStateRequirements ) then
			table.insert( eligibleSpells, spellData )
		end
	end
	return DeepCopyTable( GetRandomValue( eligibleSpells ) )
end

function GetEligibleSpells( screen, args )
	args = args or {}
	local eligibleSpells = {}
	for spellName, spellData in pairs( SpellData ) do
		if IsGameStateEligible( CurrentRun, spellData, spellData.GameStateRequirements ) or ( screen.StripRequirements and not spellData.Skip) then
			table.insert( eligibleSpells, spellData.Name )
		end
	end
	return eligibleSpells
end

function CreateSpellButtons( screen )
	local eligibleSpells = GetEligibleSpells( screen )
	local firstUseable = false
	local itemLocationStartY = screen.StartY + ScreenCenterNativeOffsetY
	local itemLocationYSpacer = screen.SpacerY

	local itemLocationStartX = screen.StartX + ScreenCenterNativeOffsetX

	local itemLocationX = itemLocationStartX
	local itemLocationY = itemLocationStartY

	local components = screen.Components

	local itemIndex = 1
	while itemIndex <= 3 and not IsEmpty( eligibleSpells ) do
		local spellName = RemoveRandomValue( eligibleSpells )
		local traitName = SpellData[spellName].TraitName
		local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName })
		SetTraitTextData( traitData )

		local purchaseButtonKey = "PurchaseButton"..itemIndex
			
		local purchaseButton = DeepCopyTable( ScreenData.UpgradeChoice.PurchaseButton )
		purchaseButton.X = itemLocationX
		purchaseButton.Y = itemLocationY
		components[purchaseButtonKey] = CreateScreenComponent( purchaseButton )
	
		local purchaseButtonTitleKey = "PurchaseButtonTitle"..itemIndex
		components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })
			
		if traitData.Icon ~= nil then
			local icon = DeepCopyTable( ScreenData.UpgradeChoice.Icon )
			icon.X = itemLocationX + ScreenData.UpgradeChoice.IconOffsetX
			icon.Y = itemLocationY + ScreenData.UpgradeChoice.IconOffsetY 
			icon.Animation = traitData.Icon
			components["Icon"..itemIndex] = CreateScreenComponent( icon )
		end

		local titleText = DeepCopyTable( ScreenData.UpgradeChoice.TitleText )
		titleText.Id = components[purchaseButtonTitleKey].Id
		titleText.Text = GetTraitTooltip( traitData )
		titleText.LuaKey = "TooltipData"
		titleText.LuaValue = traitData
		CreateTextBox( titleText )
			
		local descriptionText = DeepCopyTable( ScreenData.UpgradeChoice.DescriptionText )
		descriptionText.Id = components[purchaseButtonKey].Id
		descriptionText.Text = GetTraitTooltip( traitData )
		descriptionText.LuaKey = "TooltipData"
		descriptionText.LuaValue = traitData
		CreateTextBoxWithFormat( descriptionText )
			
		SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = ScreenData.UpgradeChoice.TooltipOffsetX })
			
		if traitData.StatLines ~= nil then
			local appendToId = nil
			if #traitData.StatLines <= 1 then
				appendToId = descriptionText.Id
			end
			for lineNum, statLine in ipairs(traitData.StatLines) do
				if statLine ~= "" then

					local offsetY = (lineNum - 1) * ScreenData.UpgradeChoice.LineHeight
					if traitData.ExtraDescriptionLine then
						offsetY = offsetY + ScreenData.UpgradeChoice.LineHeight
					end

					local statLineLeft = DeepCopyTable(ScreenData.UpgradeChoice.StatLineLeft)
					statLineLeft.Id = components[purchaseButtonKey].Id
					statLineLeft.AppendToId = appendToId
					statLineLeft.Text = statLine
					statLineLeft.OffsetY = offsetY
					statLineLeft.LuaValue = traitData
					CreateTextBoxWithFormat( statLineLeft )

					local statLineRight = DeepCopyTable(ScreenData.UpgradeChoice.StatLineRight)
					statLineRight.Id = components[purchaseButtonKey].Id
					statLineRight.AppendToId = appendToId
					statLineRight.Text = statLine
					statLineRight.OffsetY = offsetY
					statLineRight.LuaValue = traitData
					CreateTextBoxWithFormat( statLineRight )

				end
			end
		end

		local needsQuestIcon = false
		if not GameState.TraitsTaken[traitData.Name] and HasActiveQuestForName( traitData.Name ) then
			needsQuestIcon = true
		end

		if needsQuestIcon then
			components[purchaseButtonKey.."QuestIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", 
			X = itemLocationX + ScreenData.UpgradeChoice.QuestIconOffsetX - ScreenData.UpgradeChoice.ButtonOffsetX,
				Y = itemLocationY + ScreenData.UpgradeChoice.QuestIconOffsetY  })
			SetAnimation({ DestinationId = components[purchaseButtonKey.."QuestIcon"].Id, Name = "QuestItemFound" })
			-- Silent toolip
			CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "TraitQuestItem", Color = Color.Transparent, LuaKey = "TooltipData", LuaValue = traitData, })
		end

		local frame = ScreenData.UpgradeChoice.Frame
		frame.X = itemLocationX + ScreenData.UpgradeChoice.IconOffsetX
		frame.Y = itemLocationY + ScreenData.UpgradeChoice.IconOffsetY
		frame.Animation = GetTraitFrame( traitData )
		components[purchaseButtonKey.."Frame"] = CreateScreenComponent( frame )

		local button = components[purchaseButtonKey]
		button.Screen = screen
		AttachLua({ Id = button.Id, Table = button })
		button.TraitName = traitName
		button.SpellName = spellName
		button.TitleId = components[purchaseButtonTitleKey].Id
		button.OnPressedFunctionName = "AcceptAndCloseSpellScreen"
		button.OnMouseOverFunctionName = "MouseOverSpellButton"
		button.OnMouseOffFunctionName = "MouseOffSpellButton"
		if not firstUseable then
			TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
			firstUseable = true
		end	
		

		if SpellTalentData.InitialBonuses and SpellTalentData.InitialBonuses[itemIndex] then
			local bonusData = SpellTalentData.InitialBonuses[itemIndex] 
			components[purchaseButtonKey.."MoonIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu",
				X = itemLocationX + ScreenData.UpgradeChoice.BonusIconOffsetX,
				Y = itemLocationY + ScreenData.UpgradeChoice.BonusIconOffsetY })
			SetAnimation({ DestinationId = components[purchaseButtonKey.."MoonIcon"].Id, Name = bonusData.Animation, Scale = 0.5 })
			-- Silent toolip
			CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = bonusData.Text, Color = Color.Transparent, LuaKey = "TempTextData", LuaValue = bonusData })
		
			button.BonusTalentPoints = bonusData.BonusPoints or 0
		end
		itemLocationY = itemLocationY + itemLocationYSpacer
		itemIndex = itemIndex + 1
	end
end

function MouseOverSpellButton( component )
	local screen = component.Screen
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	SetAnimation({ DestinationId = component.Id, Name = "BoonSlotHighlight" })
end

function MouseOffSpellButton( component )
	local screen = component.Screen
	SetAlpha({ Id = screen.Components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAnimation({ DestinationId = component.Id, Name = component.BackingAnim or "BoonSlotBase" })
end

function AcceptAndCloseSpellScreen( screen, button )
	AddInputBlock({ Name = "AcceptAndCloseSpellScreen" })
	local buttonId = button.Id
	SelectSpellPresentation( screen, button )

	local components = screen.Components
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	OnScreenCloseStarted( screen )
	Destroy({ Id = screen.Source.ObjectId })
	Destroy({ Ids = components.TalentIds })
	Destroy({ Ids = components.TalentFrameIds })
	Destroy({ Ids = components.LinkObjects })
	CloseScreen( GetAllIds( screen.Components ), 0.25 )
	AltAspectRatioFramesHide()
	CloseSpellScreenPresentation( screen, button )
	
	CurrentRun.Hero.UntargetableFlags[screen.Name] = nil
	SetPlayerVulnerable( screen.Name )
	RemovePlayerImmuneToForce( screen.Name )

	OnScreenCloseFinished( screen )
	RemoveInputBlock({ Name = "AcceptAndCloseSpellScreen" })
	
	ShowCombatUI( screen.Name )	

	local traitData = AddTraitToHero({ TraitName = button.TraitName, SkipNewTraitHighlight = true })
	CurrentRun.Hero.SlottedSpell = DeepCopyTable( SpellData[button.SpellName] )
	CurrentRun.Hero.SlottedSpell.Talents = DeepCopyTable( CreateTalentTree( SpellData[button.SpellName] ) )
	local spellData = CurrentRun.Hero.SlottedSpell
	UpdateTalentPointInvestedCache()
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if traitData.TalentRarityBonus and traitData.Uses > 0 then

			local availableTalents = {}
			if spellData.Talents.Repeatable then
				availableTalents = ShallowCopyTable( spellData.Talents.Repeatable )
			else
				availableTalents = ShallowCopyTable( spellData.Talents )
			end
			local talentName = GetRandomValue( availableTalents )
			AddTraitToHero({ TraitName = talentName, Rarity = GetRarityKey(traitData.TalentRarityBonus)})
			ReduceTraitUses( traitData )
		end
	end

	if button.BonusTalentPoints then
		CurrentRun.NumTalentPoints = CurrentRun.NumTalentPoints + button.BonusTalentPoints
	end

	local showedObjective = CheckObjectiveSet(CurrentRun.Hero.SlottedSpell.Objective)
	if showedObjective then
		RefillMana()
	end
	
	wait( 0.2, RoomThreadName )
	thread( SpellReadyPresentation, traitData, 1.5 )
	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function SpellScreenOpenTraitTray( screen, button )
	SetAlpha({ Id = screen.Components.TraitTrayButton.Id, Fraction = 0.0, Duration = 0.2 })
	ShowCombatUI( screen.Name )
	ShowTraitTrayScreen( { CloseFunctionName = "SpellScreenCloseTraitTray", CloseFunctionArgs = { Screen = screen } } )
end

function SpellScreenCloseTraitTray( screen, args )
	HideCombatUI( args.Screen.Name )
	local upgradeChoiceScreenComponents = args.Screen.Components
	SetAlpha({ Id = upgradeChoiceScreenComponents.TraitTrayButton.Id, Fraction = 1.0, Duration = 0.2 })
end