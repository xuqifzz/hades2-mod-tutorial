function OpenTalentScreen( args, spellItem )
	args = args or {}
	local screenName = "TalentScreen"
	if not args.ReadOnly then
		local talentPoints = ( spellItem.AddTalentPoints - 1 ) or 0
		CurrentRun.NumTalentPoints = CurrentRun.NumTalentPoints + talentPoints
	end
	CurrentRun.Hero.UntargetableFlags[screenName] = true
	SetPlayerInvulnerable( screenName )
	AddPlayerImmuneToForce( screenName )

	-- Not allowed to quit after seeing otherwise hidden choices
	InvalidateCheckpoint()
	
	if spellItem ~= nil then
		LootPickupPresentation( spellItem )
		RecordConsumableItem( spellItem )
		SetAlpha({ Id = spellItem.ObjectId, Fraction = 0, Duration = 0 })
	end
	
	local screen = DeepCopyTable( ScreenData[screenName] )
	screen.ReadOnly = args.ReadOnly
	screen.StartingTalentPoints = CurrentRun.NumTalentPoints
	if screen.ReadOnly then
		screen.BlockPause = true
	end
	local components = screen.Components

	AltAspectRatioFramesShow()
	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	
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
	SetColor({ Id = components.BackgroundTint.Id, Color = Color.Black })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.9, Duration = 0.5 })

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

	-- Short delay to let animations finish and prevent accidental input
	wait(0.5)
	screen.KeepOpen = true
	HandleScreenInput( screen )
end

function CreateTalentTreeIcons( screen, args )
	args = args or {}
	local offsetX = args.OffsetX or TalentTreeUIData.DefaultStartX + ScreenCenterNativeOffsetX
	local offsetY = args.OffsetY or TalentTreeUIData.DefaultStartY + ScreenCenterNativeOffsetY
	local xSpacer = args.XSpacer or TalentTreeUIData.DefaultTalentXSpacer
	local ySpacer = args.YSpacer or TalentTreeUIData.DefaultTalentYSpacer
	local scale = args.Scale or TalentTreeUIData.DefaultTalentScale
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

			local talentObject = CreateScreenComponent({ Name = screenObstacle, X = i * xSpacer + offsetX + talentOffsetX, Y = s * ySpacer + offsetY + talentOffsetY, Group = "Combat_Menu_Overlay", Scale = scale })
			AttachLua({ Id = talentObject.Id, Table = talentObject })
			talentObject.Screen = screen
			talentObject.OnMouseOverFunctionName = "MouseOverTalentButton"
			talentObject.OnMouseOffFunctionName = "MouseOffTalentButton"
			talentObject.LinkObjects = {}
			if screenObstacle ~= "BlankObstacle" then
				SetInteractProperty({ DestinationId = talentObject.Id, Property = "TooltipOffsetX", Value = ScreenCenterNativeOffsetX + screen.TooltipOffsetXStart - (i * xSpacer + offsetX + talentOffsetX) })
				SetInteractProperty({ DestinationId = talentObject.Id, Property = "TooltipOffsetY", Value = ScreenCenterNativeOffsetY + screen.TooltipOffsetYStart - (s * ySpacer + offsetY + talentOffsetY) })
				CreateTextBox({ Id = talentObject.Id,
					OffsetX = 0, OffsetY = 0,
					Font = "P22UndergroundSCHeavy",
					Justification = "LEFT",
					Color = Color.Transparent,
					UseDescription = true,
				})
			end
			local talentFrameObject = CreateScreenComponent({ Name = "BlankObstacle", X = i * xSpacer + offsetX + talentOffsetX, Y = s * ySpacer + offsetY + talentOffsetY, Group = "Combat_Menu_Overlay", Scale = scale })
			SetAnimation({ DestinationId = talentFrameObject .Id, Name = "BoonIcon_Frame_"..talent.Rarity })
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
				for q, linkToIndex in pairs(talent.LinkTo) do
					local linkObject = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay_Backing"})
					table.insert( components.LinkObjects, linkObject.Id)
					table.insert( talentObject.LinkObjects, linkObject.Id)
					SetAnimation({ DestinationId = linkObject.Id, Name = "TalentTreeLink" })
					Attach({ Id = linkObject.Id, DestinationId = components.TalentIdsDictionary[i.."_"..s] })
					SetAngle({ Id = linkObject.Id, Angle = GetAngleBetween( { Id = linkObject.Id, DestinationId = components.TalentIdsDictionary[(i+1).."_"..linkToIndex] })})
					SetScaleX({ Id = linkObject.Id, Fraction = GetDistance({ Id = linkObject.Id, DestinationId = components.TalentIdsDictionary[(i+1).."_"..linkToIndex]}) / 200 })
					if talent.Invested then
						SetAlpha({ Id = linkObject.Id, Fraction = 1, Duration = 0.0 })
					else
						SetAlpha({ Id = linkObject.Id, Fraction = screen.UnusableArrowAlpha, Duration = 0.0 })
					end
				end
			end
		end
	end
end

function UpdateAdditionalTalentPointButton(	screen )
	local components = screen.Components		
	if screen.ReadOnly then
		return
	else
		SetAlpha({ Ids = { components.TalentPointText.Id, components.AvailablePointsTitle.Id} , Fraction = 1, Duration = 0.2 })
		ModifyTextBox({ Id = components.TalentPointText.Id, Text = ( CurrentRun.NumTalentPoints + 1 ) })
	end
end

function RecreateTalentTree( screen, button )
	local components = screen.Components
	local componentKey = "TalentObject"..button.TalentColumn.."_"..button.TalentRow
	UpdateTalentButtons( screen )
	TeleportCursor({ DestinationId = components[componentKey].Id, ForceUseCheck = true })
end

function UpdateTalentButtons( screen )
	local components = screen.Components
	local firstUsable = nil
	screen.AllInvested = true

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
			if not hasPreRequisites and talentObject.Data.QueuedInvested then
				talentObject.Data.QueuedInvested = nil		
				CurrentRun.NumTalentPoints = CurrentRun.NumTalentPoints + 1
			end
			
			SetColor({ Id = talentObject.Id, Color = Color.White })
			if talentObject.BadgeId then
				Destroy({Id = talentObject.BadgeId})
				talentObject.BadgeId = nil
			end
			if talentObject.Data.Invested or talentObject.Data.QueuedInvested then
				local animation = CreateScreenComponent({ Name = "BlankObstacle", Group = "Overlay" })
				
				SetAnimation({ DestinationId = animation.Id, Name = "TalentInvested"})
				talentObject.BadgeId = animation.Id
				Attach({ Id = animation.Id, DestinationId = talentObject.Id})
				for _, linkId in pairs (talentObject.LinkObjects) do
					SetAlpha({ Id = linkId, Fraction = 1, Duration = 0.2 })
				end
				SetColor({ Id = talentObject.Id, Color = Color.TalentPriorSelected })
				SetColor({ Id = talentObject.BadgeId, Color = Color.TalentPriorSelected })
				
			elseif not talentObject.Data.Invested then
				screen.AllInvested = false
				if hasPreRequisites then
					talentObject.Valid = true
					local animation = CreateScreenComponent({ Name = "BlankObstacle", Group = "Overlay", Scale = TalentTreeUIData.DefaultOverlayScale })
					SetAnimation({ DestinationId = animation.Id, Name = "TalentValidHighlight" })
					Attach({ Id = animation.Id, DestinationId = talentObject.Id })
					talentObject.BadgeId = animation.Id
					if not firstUsable then
						firstUsable = true
						TeleportCursor({ DestinationId = talentObject.Id, ForceUseCheck = true })
						HighlightTalentButton( talentObject )
					end
				else
					-- off and unusable
					SetColor({ Id = talentObject.Id, Color = Color.TalentInactive })
					--local animation = CreateScreenComponent({ Name = "BlankObstacle", Group = "Overlay", Scale = TalentTreeUIData.DefaultOverlayScale })
					--SetAnimation({ DestinationId = animation.Id, Name = "LockedTalent" })
					--talentObject.BadgeId = animation.Id
					--Attach({ Id = animation.Id, DestinationId = talentObject.Id })
				end
				
				for _, linkId in pairs (talentObject.LinkObjects) do
					SetAlpha({ Id = linkId, Fraction = screen.UnusableArrowAlpha, Duration = 0.2 })
				end
			end
		end
	end
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
	DebugObject = components
	ModifyTextBox({ Id = button.Id, Text = button.Data.Name, UseDescription = true, LuaKey = "TooltipData", LuaValue = newTraitData })
	if newTraitData.StatLines then
		SetAlpha({ Id = components.StatLineLeft.Id, Fraction = 1, Duration = 0.2 })
		SetAlpha({ Id = components.StatLineRight.Id, Fraction = 1, Duration = 0.2 })
	else
		SetAlpha({ Id = components.StatLineLeft.Id, Fraction = 0, Duration = 0.2 })
		SetAlpha({ Id = components.StatLineRight.Id, Fraction = 0, Duration = 0.2 })
	end
	SetTraitTrayDetails( { TraitData = newTraitData, ForBoonInfo = true, DetailsBox = components.DetailsBacking, RarityBox = components.RarityBox, 
		StatLines = {{ components.StatLineLeft.Id, components.StatLineRight.Id }}, TitleBox = components.TitleBox, Icon = components.TalentIcon })
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
	for _, talentInfo in pairs( screen.QueuedTalents ) do
		talentInfo.Invested = true	
		if HeroHasTrait( talentInfo.Name ) then
			local traitData = GetHeroTrait( talentInfo.Name )
			IncreaseTraitLevel( traitData )
			local baseTraitData = TraitData[talentInfo.Name]
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
	OnScreenCloseStarted( screen )

	Destroy({ Ids = components.TalentIds})
	Destroy({ Ids = components.TalentFrameIds})
	Destroy({ Ids = components.LinkObjects })
	CloseScreen( GetAllIds( screen.Components ), 0.25 )
	AltAspectRatioFramesHide()
	if not screen.ReadOnly then
		CloseTalentScreenPresentation( screen )
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

	if screen.ReadOnly then
		ShowTraitTrayScreen( { AutoPin = false } )
	else
		wait( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end
	end

end