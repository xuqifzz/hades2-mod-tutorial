function OpenTalentScreen( args, spellItem )
	args = args or {}
	local screenName = "TalentScreen"
	if not args.ReadOnly and spellItem and spellItem.AddTalentPoints then
		local talentPoints = ( spellItem.AddTalentPoints - 1 ) or 0
		CurrentRun.NumTalentPoints = CurrentRun.NumTalentPoints + talentPoints
	end
	CurrentRun.Hero.UntargetableFlags[screenName] = true
	SetPlayerInvulnerable( screenName )
	AddPlayerImmuneToForce( screenName )

	-- Not allowed to quit after seeing otherwise hidden choices
	InvalidateCheckpoint()
	HideCombatUI( screenName )
	
	if spellItem ~= nil then
		AddTimerBlock( CurrentRun, "OpenTalentScreen" )
		LootPickupPresentation( spellItem )
		RecordConsumableItem( spellItem )
		MapState.RoomRequiredObjects[spellItem.ObjectId] = nil
		SetAlpha({ Id = spellItem.ObjectId, Fraction = 0, Duration = 0 })
		RemoveScreenEdgeIndicator( spellItem )
		RemoveTimerBlock( CurrentRun, "OpenTalentScreen" )
	end
	
	local screen = DeepCopyTable( ScreenData[screenName] )
	screen.ReadOnly = args.ReadOnly
	screen.StartingTalentPoints = CurrentRun.NumTalentPoints
	if screen.ReadOnly then
		screen.BlockPause = true
	end
	local components = screen.Components

	AltAspectRatioFramesShow()
	
	OnScreenOpened( screen )
	LoadVoiceBanks( { Name = "Selene" }, nil, true )

	local traitData = nil
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
		traitData = AddTraitToHero({ TraitName = CurrentRun.Hero.SlottedSpell.TraitName })
		table.insert( MapState.GeneratedSpells, CurrentRun.Hero.SlottedSpell.Name )
	end

	if not CurrentRun.Hero.SlottedSpell then	
		CurrentRun.Hero.SlottedSpell = ChooseSpell( CurrentRun.CurrentRoom, args )
		CurrentRun.Hero.SlottedSpell.Talents = CreateTalentTree( SpellData[CurrentRun.Hero.SlottedSpell.Name] )	
		traitData = AddTraitToHero({ TraitName = CurrentRun.Hero.SlottedSpell.TraitName })

	end
	screen.QueuedTalents = {}
	screen.SelectedTalent = nil
	screen.Source = spellItem
	CreateScreenFromData( screen, screen.ComponentData )
	
	UpdateAdditionalTalentPointButton( screen )

	if not traitData then
		traitData = GetHeroTrait( CurrentRun.Hero.SlottedSpell.TraitName )
	end
	SetAnimation({ DestinationId = components.SpellIcon.Id, Name = traitData.Icon})
	SetAnimation({ DestinationId = components.SpellFrame.Id, Name = GetTraitFrame( traitData ) })
	ModifyTextBox({ Id = components.SpellText.Id, Text = traitData.Name, LuaKey = "TooltipData", LuaValue = traitData  })
	ModifyTextBox({ Id = components.SpellDescription.Id, Text = traitData.Name, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData })
	if spellItem ~= nil then
		ModifyTextBox({ Id = components.TitleText.Id, Text = spellItem.MenuTitle, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData })
	
		if spellItem.FlavorTextIds ~= nil then
			local flavorText = GetRandomValue( spellItem.FlavorTextIds )		
			ModifyTextBox({ Id = components.FlavorText.Id, Text = flavorText })
		end
	end

	CreateTalentTreeIcons( screen, { ObstacleName = "ButtonTalent", OnPressedFunctionName = "OnTalentPressed"} )
	UpdateTalentButtons( screen )
	if screen.ReadOnly or screen.AllInvested then
		UseableOn({ Id = components.CloseButton.Id })
		SetAlpha({ Id = components.CloseButton.Id, Fraction = 1.0, Duration = 0.2 })
		screen.BlockPause = true
	else
		UseableOff({ Id = components.CloseButton.Id })
	end

	if spellItem ~= nil and spellItem.RespawnAfterUse then
		local newSpellItemId = SpawnObstacle({ Name = "TalentDrop", DestinationId = spellItem.ObjectId })
		local newSpellItem = CreateConsumableItem( newSpellItemId, "TalentDrop", 0 )
		newSpellItem.RespawnAfterUse = spellItem.RespawnAfterUse
		newSpellItem.RotateAfterUse = spellItem.RotateAfterUse
		spellItem.RespawnAfterUse = false
	end
	
	if HeroHasTrait( "SpellTalentKeepsake" ) then
		local trait = GetHeroTrait("SpellTalentKeepsake")
		ReduceTraitUses( trait, {Force = true })
		trait.CustomTrayText = trait.ZeroBonusTrayText
	end

	if CurrentRun.Hero.SlottedSpell.HasDuoTalent and CurrentRun.ScreenViewRecord[screenName] == 1 then
		thread(FirstTimeDuoTalentPresentation, components.SpellBacking.Id )
	end
	-- Short delay to let animations finish and prevent accidental input
	wait(0.5)
	SetAlpha({ Id = components.TalentPointText.Id, Fraction = 1.0, Duration = 0.2 })
	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function CreateTalentTreeIcons( screen, args )
	args = args or {}
	local offsetX = args.OffsetX or screen.DefaultStartX + ScreenCenterNativeOffsetX
	local offsetY = args.OffsetY or screen.DefaultStartY + ScreenCenterNativeOffsetY
	local xSpacer = args.XSpacer or screen.DefaultTalentXSpacer
	local ySpacer = args.YSpacer or screen.DefaultTalentYSpacer
	local scale = args.Scale or screen.DefaultTalentScale
	local screenObstacle = args.ObstacleName or "BlankObstacle"
	local components = screen.Components
	local spellTalents = nil
	if CurrentRun.Hero.SlottedSpell then
		spellTalents = CurrentRun.Hero.SlottedSpell.Talents
	end
	if not spellTalents then
		spellTalents = screen.TalentData
	end
	if spellTalents.OffsetY then
		offsetY = offsetY + spellTalents.OffsetY
	end
	components.TalentIds = {}
	components.TalentFrameIds = {}
	components.TalentIdsDictionary = {}
	components.TalentFramesIdsDictionary = {}
	components.LinkObjects = {}
	for i, column in ipairs( spellTalents ) do
		for s, talent in pairs( spellTalents[i] ) do
			local talentOffsetX = (talent.GridOffsetX or 0) * xSpacer
			local talentOffsetY = (talent.GridOffsetY or 0) * ySpacer

			local interactProperties = nil
			if screenObstacle ~= "BlankObstacle" then
				interactProperties =
				{
					TooltipOffsetX = ScreenCenterNativeOffsetX + screen.TooltipOffsetXStart - (i * xSpacer + offsetX + talentOffsetX),
					TooltipOffsetY = ScreenCenterNativeOffsetY + screen.TooltipOffsetYStart - (s * ySpacer + offsetY + talentOffsetY),
				}
			end
			local talentObject = CreateScreenComponent({
					Name = screenObstacle, X = i * xSpacer + offsetX + talentOffsetX, Y = s * ySpacer + offsetY + talentOffsetY,
					Group = "Combat_Menu_Overlay",
					Scale = scale,
					InteractProperties = interactProperties,
					Alpha = 0.01,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.6,
			})
			talentObject.Screen = screen
			talentObject.OnMouseOverFunctionName = "MouseOverTalentButton"
			talentObject.OnMouseOffFunctionName = "MouseOffTalentButton"
			talentObject.LinkObjects = {}
			if screenObstacle ~= "BlankObstacle" then
				CreateTextBox({ Id = talentObject.Id,
					OffsetX = 0, OffsetY = 0,
					Font = "P22UndergroundSCHeavy",
					Justification = "LEFT",
					Color = Color.Transparent,
					UseDescription = true,
				})
			end
			local talentFrameObject = CreateScreenComponent({ Name = "BlankObstacle", X = i * xSpacer + offsetX + talentOffsetX, Y = s * ySpacer + offsetY + talentOffsetY,
				Group = "Combat_Menu_Overlay",
				Scale = scale,
				Alpha = 0.0,
				AlphaTarget = 1.0,
				AlphaTargetDuration = 0.6,
				})
			if TraitData[talent.Name] and TraitData[talent.Name].IsDuoBoon then
				SetAnimation({ DestinationId = talentFrameObject .Id, Name = "BoonIcon_Frame_Duo"})
				talentObject.OverrideRarity = "Duo"
				
				local talentFrameOverlay = CreateScreenComponent({ Name = "BlankObstacle", X = i * xSpacer + offsetX + talentOffsetX, Y = s * ySpacer + offsetY + talentOffsetY,
					Group = "Combat_Menu_Overlay_Additive",
					Scale = scale,
					Alpha = 0.0,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.6,
				})
				SetAnimation({ Name = "ActiveTrait", DestinationId = talentFrameOverlay.Id, Scale = 2, })
				table.insert( components.TalentFrameIds, talentFrameOverlay.Id)
			else
				SetAnimation({ DestinationId = talentFrameObject .Id, Name = "BoonIcon_Frame_"..talent.Rarity })
			end
			table.insert( components.TalentFrameIds, talentFrameObject .Id )
			components.TalentFramesIdsDictionary[i.."_"..s] = talentFrameObject .Id
			if not screen.ReadOnly then
				talentObject.OnPressedFunctionName = args.OnPressedFunctionName
			end
			talentObject.Data = talent
			talentObject.TalentColumn = i
			talentObject.TalentRow = s
			if talent.Name and TraitData[talent.Name] then
				SetAnimation({ DestinationId = talentObject.Id, Name = TraitData[talent.Name].Icon })
			else
				DebugPrint({Text = " unable to find " .. tostring(talent.Name)})
			end
			table.insert( components.TalentIds, talentObject.Id )
			components.TalentIdsDictionary[i.."_"..s] = talentObject.Id
			--if talentObject.OnPressedFunctionName then
				components["TalentObject"..i.."_"..s] = talentObject
			--end
		end
	end

	for i, column in ipairs( spellTalents ) do
		for s, talent in pairs( spellTalents[i] ) do
			local talentObject = components["TalentObject"..i.."_"..s]
			talentObject.LinkObjects = {}
			if talent.LinkTo then
				for q, linkToIndex in pairs( talent.LinkTo ) do
					local anim = nil
					local linkGroupName = nil
					if talent.Invested then
						anim = "TalentTreeLineUnlocked"
						linkGroupName = "Combat_Menu_Overlay_Additive"
					else
						anim = "TalentTreeLineLocked"
						linkGroupName = "Combat_Menu_Overlay_Backing"
					end
					local linkObject = CreateScreenComponent({ Name = "BlankObstacle", Group = linkGroupName, Animation = anim,
						DestinationId = components.TalentIdsDictionary[i.."_"..s], Attach = true,
						Alpha = 0.0,
						AlphaTarget = 1.0,
						AlphaTargetDuration = 0.6,
					})
					table.insert( components.LinkObjects, linkObject.Id)
					table.insert( talentObject.LinkObjects, linkObject.Id)
					SetAngle({ Id = linkObject.Id, Angle = GetAngleBetween( { Id = linkObject.Id, DestinationId = components.TalentIdsDictionary[(i+1).."_"..linkToIndex] })})
					SetScaleX({ Id = linkObject.Id, Fraction = GetDistance({ Id = linkObject.Id, DestinationId = components.TalentIdsDictionary[(i+1).."_"..linkToIndex]}) / 200 })			
				end
			end
		end
	end
end

function UpdateAdditionalTalentPointButton(	screen, args )
	args = args or {}
	local components = screen.Components		
	if screen.ReadOnly then
		return
	else
		ModifyTextBox({ Id = components.TalentPointText.Id, Text = ( CurrentRun.NumTalentPoints + 1 ) })
		CreateAnimation({ Name = "TalentPointsChangeFx", DestinationId = components.TalentPointText.Id, GroupName = "Combat_Menu_Overlay_Additive", OffsetY = 75 })
	end
end

function RecreateTalentTree( screen, button )
	local components = screen.Components
	local componentKey = "TalentObject"..button.TalentColumn.."_"..button.TalentRow
	UpdateTalentButtons( screen, true )
	TeleportCursor({ DestinationId = components[componentKey].Id, ForceUseCheck = true })
end

function UpdateTalentButtons( screen, skipUsableCheck )
	local components = screen.Components
	local firstUsable = skipUsableCheck
	screen.AllInvested = true

	local startingAlpha = 0.0
	if skipUsableCheck then
		startingAlpha = 1.0
	end

	local colorWhiteIds = {}
	local talentPriorSelectedIds = {}
	local talentInactiveIds = {}

	for i, column in ipairs( CurrentRun.Hero.SlottedSpell.Talents ) do
		for s, talent in pairs( column ) do
			local talentObject = components["TalentObject"..i.."_"..s]
			local hasPreRequisites = true
			if talentObject.Data.LinkFrom then
				hasPreRequisites = false
				for _, preReqIndex in pairs( talentObject.Data.LinkFrom ) do
					if components["TalentObject"..(i-1).."_"..preReqIndex].Data.Invested or components["TalentObject"..(i-1).."_"..preReqIndex].Data.QueuedInvested  then
						-- if any are invested, this becomes valid
						hasPreRequisites = true
					end
				end
			end
			if not hasPreRequisites and talentObject.Data.LinkTo and talentObject.Data.Bidirectional then
				for _, preReqIndex in pairs( talentObject.Data.LinkTo ) do
					if components["TalentObject"..(i+1).."_"..preReqIndex] and ( components["TalentObject"..(i+1).."_"..preReqIndex].Data.Invested or components["TalentObject"..(i+1).."_"..preReqIndex].Data.QueuedInvested ) then
						-- if any are invested, this becomes valid
						hasPreRequisites = true
					end
				end
			end
			if not hasPreRequisites and talentObject.Data.QueuedInvested then
				talentObject.Data.QueuedInvested = nil		
				CurrentRun.NumTalentPoints = CurrentRun.NumTalentPoints + 1
			end
			
			table.insert( colorWhiteIds, talentObject.Id )
			if talentObject.BadgeId then
				Destroy({ Id = talentObject.BadgeId })
				talentObject.BadgeId = nil
			end
			if talentObject.Data.Invested or talentObject.Data.QueuedInvested then
				local animation = CreateScreenComponent({ Name = "BlankObstacle",
					Group = screen.ComponentData.DefaultGroup, Scale = screen.DefaultTalentScale,
					Animation = "TalentTreeIconsUnlocked",
					DestinationId = talentObject.Id, Attach = true,
					Alpha = startingAlpha,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.6,
				})				
				talentObject.BadgeId = animation.Id
				for _, linkId in pairs( talentObject.LinkObjects ) do
					SetAnimation({ DestinationId = linkId, Name = "TalentTreeLineUnlocked" })
				end
				table.insert( talentPriorSelectedIds, talentObject.Id )
			elseif not talentObject.Data.Invested then
				screen.AllInvested = false
				if hasPreRequisites then
					talentObject.Valid = true
					local animation = CreateScreenComponent({ Name = "BlankObstacle",
						Group = screen.ComponentData.DefaultGroup, Scale = screen.DefaultTalentScale,
						Animation = "TalentTreeIconsLocked",
						DestinationId = talentObject.Id, Attach = true,
						Alpha = startingAlpha,
						AlphaTarget = 1.0,
						AlphaTargetDuration = 0.6,
					})
					talentObject.BadgeId = animation.Id
					if not firstUsable then
						firstUsable = true
						TeleportCursor({ DestinationId = talentObject.Id, ForceUseCheck = true })
						HighlightTalentButton( talentObject )
					end
				else
					-- off and unusable
					table.insert( talentInactiveIds, talentObject.Id )
				end
				
				for _, linkId in pairs( talentObject.LinkObjects ) do
					SetAnimation({ DestinationId = linkId, Name = "TalentTreeLineLocked" })
				end
			end
		end
	end

	SetColor({ Ids = colorWhiteIds, Color = Color.White })
	SetColor({ Ids = talentPriorSelectedIds, Color = screen.TalentPriorSelected })
	SetColor({ Ids = talentInactiveIds, Color = screen.TalentInactive })

end

function MouseOverTalentButton( button )
	local screen = button.Screen
	local components = screen.Components
	Teleport({ Id = components.TalentHover.Id, DestinationId = button.Id })
	HighlightTalentButton( button )
	SetAlpha({ Id = components.TalentHover.Id, Fraction = 1, Duration = 0.2 })
	UpdateTalentContextualAction( button )
end

function UpdateTalentContextualAction( button )
	local screen = button.Screen
	local components = screen.Components
	if (button.Valid or button.Data.QueuedInvested) and not screen.ReadOnly then
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1, Duration = 0.2 })
		if button.Data.Invested or button.Data.QueuedInvested then
			ModifyTextBox({ Id = components.SelectButton.Id, Text = " " })
		else
			ModifyTextBox({ Id = components.SelectButton.Id, Text = "Talent_Select", LuaKey = "TempTextData", LuaValue = { Amount = CurrentRun.NumTalentPoints + 1, MaxAmount = screen.StartingTalentPoints + 1} })
		end
	end
end

function HighlightTalentButton( button )
	local screen = button.Screen
	local components = screen.Components
	local newTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = button.Data.Name, Rarity = button.Data.Rarity, ForBoonInfo = true })
	newTraitData.ForBoonInfo = true
	SetTraitTextData( newTraitData )
	ModifyTextBox({ Id = button.Id, Text = button.Data.Name, UseDescription = true, LuaKey = "TooltipData", LuaValue = newTraitData })
	if newTraitData.StatLines or ( newTraitData.CustomStatLinesWithShrineUpgrade ~= nil and GetNumShrineUpgrades( newTraitData.CustomStatLinesWithShrineUpgrade.ShrineUpgradeName ) > 0 ) then
		SetAlpha({ Id = components.StatLineLeft.Id, Fraction = 1, Duration = 0.2 })
		SetAlpha({ Id = components.StatLineRight.Id, Fraction = 1, Duration = 0.2 })
		if (newTraitData.StatLines and TableLength(newTraitData.StatLines) > 1) 
			or ( newTraitData.CustomStatLinesWithShrineUpgrade and GetNumShrineUpgrades( newTraitData.CustomStatLinesWithShrineUpgrade.ShrineUpgradeName ) > 0 and TableLength(newTraitData.CustomStatLinesWithShrineUpgrade) > 1) then
			SetAlpha({ Id = components.StatLineLeft2.Id, Fraction = 1, Duration = 0.2 })
			SetAlpha({ Id = components.StatLineRight2.Id, Fraction = 1, Duration = 0.2 })
		else
			SetAlpha({ Id = components.StatLineLeft2.Id, Fraction = 0, Duration = 0.2 })
			SetAlpha({ Id = components.StatLineRight2.Id, Fraction = 0, Duration = 0.2 })
		end
	else
		SetAlpha({ Id = components.StatLineLeft.Id, Fraction = 0, Duration = 0.2 })
		SetAlpha({ Id = components.StatLineRight.Id, Fraction = 0, Duration = 0.2 })
		SetAlpha({ Id = components.StatLineLeft2.Id, Fraction = 0, Duration = 0.2 })
		SetAlpha({ Id = components.StatLineRight2.Id, Fraction = 0, Duration = 0.2 })
	end
	
	SetTraitTrayDetails( { Button = button, TraitData = newTraitData, ForBoonInfo = true, DetailsBox = components.DetailsBacking, RarityBox = components.RarityBox, 
		StatLines = {{ components.StatLineLeft.Id, components.StatLineRight.Id }, { components.StatLineLeft2.Id, components.StatLineRight2.Id }}, TitleBox = components.TitleBox, Icon = components.TalentIcon })
	SetAnimation({ DestinationId = components.TalentFrame.Id, Name = GetTraitFrame( newTraitData) })
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonToggle", Id = button.Id })
end

function MouseOffTalentButton( button )
	local screen = button.Screen
	local components = screen.Components
	SetAlpha({ Id = components.SelectButton.Id, Fraction = 0, Duration = 0.2 })
	SetAlpha({ Id = components.TalentHover.Id, Fraction = 0, Duration = 0.2 })
end

function OnTalentPressed( screen, button )
	local components = screen.Components
	local selectedTalent = CurrentRun.Hero.SlottedSpell.Talents[button.TalentColumn][button.TalentRow]
	if selectedTalent.Invested or selectedTalent.QueuedInvested then
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = components.TalentPin.Id })
	elseif button.Valid then	
		screen.SelectedTalent =  selectedTalent
		PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonPin", Id = components.TalentPin.Id })
		CreateAnimation({ Name = "HexReadyFlashTalent", DestinationId = button.Id, GroupName = "Combat_Menu_TraitTray_Overlay_Additive", Scale = (screen.DefaultTalentScale * 1.5) })	
		TryCloseTalentTree( screen, button )
		UpdateTalentContextualAction( button )
	else
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = components.TalentPin.Id })
	end
end

function LeaveTalentTree( screen, button )
	local components = screen.Components
	if not screen.ReadOnly and not screen.AllInvested then
		return
	end
	TryCloseTalentTree(screen, button)
end

function TryCloseTalentTree( screen, button )
	local components = screen.Components
	
	if not screen.AllInvested and not screen.ReadOnly then
		IncrementTableValue( CurrentRun, "InvestedTalentPoints" )
		if not screen.SelectedTalent then
			return
		else
			table.insert( screen.QueuedTalents, screen.SelectedTalent )
			screen.SelectedTalent.QueuedInvested = true
		end
		
		if CurrentRun.NumTalentPoints and CurrentRun.NumTalentPoints > 0 then
			CurrentRun.NumTalentPoints = CurrentRun.NumTalentPoints - 1
			RecreateTalentTree( screen, button )
			UpdateAdditionalTalentPointButton( screen )
			if not screen.AllInvested then
				return
			end
		end
	end

	SetAlpha({ Id = components.TalentHover.Id, Fraction = 0, Duration = 0.2 })
	screen.AddedTraitNames = {}
	for _, talentInfo in pairs( screen.QueuedTalents ) do
		talentInfo.Invested = true
		
		local baseTraitData = TraitData[talentInfo.Name]
		if baseTraitData.IsDuoBoon then
			CurrentRun.Hero.SlottedSpell.ObtainedDuoTalent = true
		end
		screen.AddedTraitNames[talentInfo.Name] = true
		if HeroHasTrait( talentInfo.Name ) then
			local traitData = GetHeroTrait( talentInfo.Name )
			IncreaseTraitLevel( traitData )
			if baseTraitData.AcquireFunctionName then
				thread( CallFunctionName, baseTraitData.AcquireFunctionName, baseTraitData.AcquireFunctionArgs, traitData )
			end
		else
			AddTraitToHero({ TraitName = talentInfo.Name, Rarity = talentInfo.Rarity, FromLoot = true })
		end
	end
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	UpdateTalentPointInvestedCache()
	wait( 0.3 ) -- Let confirm animation play
	SetAnimation({ Name = "TalentScreenOut", DestinationId = screen.Components.BackgroundImage.Id })
	OnScreenCloseStarted( screen )

	if screen.Source and screen.Source.DestroySourceOnClose then
		Destroy({ Id = screen.Source.ObjectId })
	end

	local ids = GetAllIds( screen.Components )
	ConcatTableValues( ids, components.TalentIds )
	ConcatTableValues( ids, components.TalentFrameIds )
	ConcatTableValues( ids, components.LinkObjects )
	for i, column in ipairs( CurrentRun.Hero.SlottedSpell.Talents ) do
		for s, talent in pairs( column ) do
			local talentObject = components["TalentObject"..i.."_"..s]
			if talentObject ~= nil and talentObject.BadgeId ~= nil then
				table.insert( ids, talentObject.BadgeId )
			end
		end
	end
	CloseScreen( ids, nil, screen, { CloseDestroyWait = 0.5 } )
	AltAspectRatioFramesHide()
	if not screen.ReadOnly then
		TalentScreenCloseFinishedPresentation( screen )
		if HeroHasTrait("SpellTalentKeepsake") then
			local traitData = GetHeroTrait("SpellTalentKeepsake")
			traitData.CustomTrayText = traitData.ZeroBonusTrayText
			ReduceTraitUses( traitData, {Force = true })
		end
	end
	if screen.Source and CurrentRun.AllSpellInvestedCache then
		screen.Source.CanDuplicate = false
	end
	CurrentRun.Hero.UntargetableFlags[screen.Name] = nil
	SetPlayerVulnerable( screen.Name )
	RemovePlayerImmuneToForce( screen.Name )
	
	OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
	if screen.Source and screen.Source.DoSpellInteractEndOnClose then
		SpellDropInteractPresentationEnd()
	end
	if screen.ReadOnly then
		ShowTraitTrayScreen( { AutoPin = false } )
	else
		notifyExistingWaiters( UIData.TalentMenuId )
		wait( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end
	end

end