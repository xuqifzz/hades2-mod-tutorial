function UseShrineObject( usee, args )
	UseableOff({ Id = usee.ObjectId })
	OpenShrineScreenPrePresentation( usee.ObjectId )
	StopStatusAnimation( usee )
	OpenShrineScreen( args )
	OpenShrineScreenPostPresentation( usee.ObjectId )
	UseableOn({ Id = usee.ObjectId })
end

function OpenShrineScreen( args )
	args = args or {}

	AltAspectRatioFramesShow()

	local screen = DeepCopyTable( ScreenData.Shrine )
	local components = screen.Components

	local showHint = true
	if GameState.ScreensViewed.Shrine then
		showHint = false
	end

	SetAlpha({ Id = HUDScreen.Components.BountyReadyConfirm.Id, Fraction = 0.0, Duration = 0.2 })

	HideCombatUI( screen.Name )
	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )

	OverwriteTableKeys( screen, args )

	local firstView = not GameState.ScreensViewed[screen.Name]

	components.LevelUpStatHighlight = CreateScreenComponent({ Name = "ShrineStatHighlight", Group = "Combat_Menu" })
	SetAlpha({ Id = components.LevelUpStatHighlight.Id, Fraction = 0.0 })
	ScreenAnchors.LevelUpStatHighlightId = components.LevelUpStatHighlight.Id

	screen.NumItems = 0

	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY
	screen.BountyRowStartX = screen.BountyRowStartX + ScreenCenterNativeOffsetX
	screen.BountyRowStartY = screen.BountyRowStartY + ScreenCenterNativeOffsetY

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY
	local firstUseable = false
	for index, upgradeName in ipairs( ShrineUpgradeOrder ) do
		local upgradeData = MetaUpgradeData[upgradeName]

		local backing = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = itemLocationX, Y = itemLocationY, Scale = screen.IconBackingScale })
		components["ItemBacking"..index] = backing
		AttachLua({ Id = backing.Id, Table = backing })
		backing.Screen = screen
		backing.Data = upgradeData

		local button = CreateScreenComponent({ Name = "ButtonShrineItem", Group = screen.ComponentData.DefaultGroup, X = itemLocationX, Y = itemLocationY, Animation = upgradeData.Icon, Scale = screen.IconScale })
		components["ItemButton"..index] = button
		AttachLua({ Id = button.Id, Table = button })
		button.Screen = screen
		button.Data = upgradeData
		button.Backing = backing
		button.OnMouseOverFunctionName = "ShrineScreenMouseOverItem"
		button.OnMouseOffFunctionName = "ShrineScreenMouseOffItem"
		button.OnPressedFunctionName = "ShrineScreenRankUp"

		local highlight = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = itemLocationX, Y = itemLocationY,
			Animation = screen.SelectionHighlight.AnimationName, Scale = screen.SelectionHighlight.Scale, Alpha = 0.0 })
		components["ItemHighlight"..index] = highlight
		AttachLua({ Id = highlight.Id, Table = highlight })
		highlight.Screen = screen
		button.Highlight = highlight

		local nextRankBacking = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = itemLocationX + screen.NextRankBackingOffsetX, Y = itemLocationY + screen.NextRankBackingOffsetY, Alpha = 0.0 })
		components["NextRankBacking"..index] = nextRankBacking
		AttachLua({ Id = nextRankBacking.Id, Table = nextRankBacking })
		nextRankBacking.Screen = screen
		button.NextRankBacking = nextRankBacking

		ShrineUpgradeExtractValues( upgradeName )

		local nextRankFormat = ShallowCopyTable( screen.NextRankFormat )
		nextRankFormat.Id = button.Id
		nextRankFormat.Text = "ShrineScreen_NextRankPoints"
		CreateTextBox( nextRankFormat )
		ShrineScreenUpdateNextRankText( button )

		-- Hidden description for tooltips
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY + ScreenCenterNativeOffsetY })
		CreateTextBox({ Id = button.Id,
			Text = upgradeName,
			UseDescription = true,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = upgradeData,
		})

		if index == 1 and not showHint then
			TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
		end

		if index % screen.ItemsPerRow == 0 then
			itemLocationX = screen.ItemStartX
			itemLocationY = itemLocationY + screen.ItemSpacingY
		else
			itemLocationX = itemLocationX + screen.ItemSpacingX
		end		

		screen.NumItems = screen.NumItems + 1
		
	end

	screen.PrevShrineUpgrades = ShallowCopyTable( GameState.ShrineUpgrades )

	ShrineScreenUpdateItems( screen )

	local currentWeaponName = GetEquippedWeapon()

	local completeBountyNum = 0
	local availableBountyNum = 0
	local totalBountyNum = 0
	local itemLocationX = screen.BountyRowStartX
	local itemLocationY = screen.BountyRowStartY
	for i, bountyName in ipairs( screen.BountyOrder ) do
		local bountyData = BountyData[bountyName]
		local weaponName = nil
		local matchedWeapon = false
		local shrinePoints = nil
		if bountyData.CompleteGameStateRequirements ~= nil then
			for j, completeRequirement in ipairs( bountyData.CompleteGameStateRequirements ) do
				if completeRequirement.HasAny ~= nil then
					weaponName = completeRequirement.HasAny[1]
					if CurrentRun.Hero.Weapons[weaponName] then
						matchedWeapon = true
					end
				end
				if completeRequirement.Value ~= nil then
					shrinePoints = completeRequirement.Value
				end
			end
			
			totalBountyNum = totalBountyNum + 1
			if GameState.BountiesCompleted[bountyName] then
				completeBountyNum = completeBountyNum + 1
			else
				if bountyData.UnlockGameStateRequirements ~= nil and IsGameStateEligible( CurrentRun, bountyData, bountyData.UnlockGameStateRequirements ) then		
					availableBountyNum = availableBountyNum + 1
					local key = "BountyAvailable"..availableBountyNum
					if availableBountyNum <= screen.MaxBountiesAvailable then

						local targetItem = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup,
							X = itemLocationX + screen.BountyTargetOffsetX, Y = itemLocationY + screen.BountyTargetOffsetY,
							Animation = screen.BountyTargetIcons[bountyData.Encounter], Scale = screen.BountyBossIconScale })
						components[key.."Target"] = targetItem

						local bountyBacking = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup,
							X = itemLocationX, Y = itemLocationY,
							Animation = "GUI\\Screens\\Shrine\\Testament",
							Scale = 1.0 })
						components[key.."Backing"] = bountyBacking

						local shrinePointItem = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup,
							X = itemLocationX + screen.BountyShrinePointsOffsetX, Y = itemLocationY + screen.BountyShrinePointsOffsetY })
						shrinePointItem.BountyData = bountyData
						shrinePointItem.MatchedWeapon = matchedWeapon
						shrinePointItem.RequiredShrinePoints = shrinePoints
						components[key.."ShrinePoints"] = shrinePointItem
						local bountyShrinePointsFormat = ShallowCopyTable( screen.BountyShrinePointsFormat )
						bountyShrinePointsFormat.Id = shrinePointItem.Id
						bountyShrinePointsFormat.Text = "ShrineScreen_BountyShrinePoints"
						bountyShrinePointsFormat.LuaKey = "TempTextData"
						bountyShrinePointsFormat.LuaValue = { RequiredShrinePoints = shrinePoints }
						CreateTextBox( bountyShrinePointsFormat )

						--[[
						local weaponLink = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = itemLocationX + screen.BountyLinkLeftOffsetX, Y = itemLocationY,
							Animation = "GUI\\Screens\\Shrine\\LinkLeft",
							Alpha = 0.0,
							})
						components[key.."WeaponLink"] = weaponLink
						]]
						local weaponItem = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup,
							X = itemLocationX + screen.BountyWeaponOffsetX, Y = itemLocationY + screen.BountyWeaponOffsetY,
							Animation = screen.BountyWeaponIcons[weaponName], Scale = screen.BountyWeaponIconScale })
						components[key.."Weapon"] = weaponItem

						--[[
						local targetLink = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, X = itemLocationX + screen.BountyRowWeaponOffsetX + screen.BountyLinkRightOffsetX, Y = itemLocationY,
							Animation = "GUI\\Screens\\Shrine\\LinkRight",
							Alpha = 0.0,
							})
						components[key.."TargetLink"] = targetLink
						]]

						if availableBountyNum % screen.BountyItemsPerRow == 0 then
							itemLocationX = screen.BountyRowStartX
							itemLocationY = itemLocationY + screen.BountyRowSpacingY
						else
							itemLocationX = itemLocationX + screen.BountyRowSpacingX
						end

					end
				end
			end

		end
	end

	ModifyTextBox({ Id = components.BountyHeader.Id, LuaKey = "TempTextData", LuaValue = { WeaponName = currentWeaponName, Completed = completeBountyNum, Total = totalBountyNum, }, })

	if components.SkellyQuestSurface ~= nil then
		local surfaceShrinePointRecord = GetHighestShrinePointRunClear( CurrentRun, { RequiredBiome = "N", IgnoreSameMode = true } )
		DebugPrint({ Text = "surfaceShrinePointRecord = "..surfaceShrinePointRecord })
		local underworldShrinePointRecord = GetHighestShrinePointRunClear( CurrentRun, { RequiredBiome = "F", IgnoreSameMode = true } )
		DebugPrint({ Text = "underworldShrinePointRecord = "..underworldShrinePointRecord })
		for i, shrinePointThreshold in ipairs( screen.ShrinePointThresholds ) do
			if surfaceShrinePointRecord >= shrinePointThreshold and underworldShrinePointRecord >= shrinePointThreshold and i < #screen.ShrinePointThresholds then
				-- Both runs complete, move to next threshold
			else
				screen.NextSkellyShrinePointGoal = shrinePointThreshold
				if surfaceShrinePointRecord >= shrinePointThreshold then
					SetAnimation({ DestinationId = components.SkellyQuestSurface.Id, Name = "GUI\\Screens\\Shrine\\SkellyComplete" })
					ModifyTextBox({ Id = components.SkellyQuestSurface.Id, Text = "ShrineScreen_SkellyStatueSurface_Complete", FadeTarget = 1.0 })
					SetAlpha({ Id = components.SkellyQuestSurfaceStrikethrough.Id, Fraction = 1.0, Duration = 0.2 })
				else
					ModifyTextBox({ Id = components.SkellyQuestSurface.Id, Text = "ShrineScreen_SkellyStatueSurface_Incomplete", FadeTarget = 1.0 })
				end
				if underworldShrinePointRecord >= shrinePointThreshold then
					SetAnimation({ DestinationId = components.SkellyQuestUnderworld.Id, Name = "GUI\\Screens\\Shrine\\SkellyComplete" })
					ModifyTextBox({ Id = components.SkellyQuestUnderworld.Id, Text = "ShrineScreen_SkellyStatueUnderworld_Complete", FadeTarget = 1.0 })
					SetAlpha({ Id = components.SkellyQuestUnderworldStrikethrough.Id, Fraction = 1.0, Duration = 0.2 })
				else
					ModifyTextBox({ Id = components.SkellyQuestUnderworld.Id, Text = "ShrineScreen_SkellyStatueUnderworld_Incomplete", FadeTarget = 1.0 })
				end
				break
			end
		end
	end

	ShrineScreenUpdateActivePoints( screen, nil, { Duration = 0.0 } )
	screen.StartingBounty = screen.ActiveBounty

	if showHint then
		GenericInfoPresentation( screen )
		TeleportCursor({ OffsetX = 1470, OffsetY = 280, ForceUseCheck = true })
	end

	screen.KeepOpen = true
	HandleScreenInput( screen )

end

function CloseShrineUpgradeScreen( screen, button )

	UpdateSeenMetaUpgrades()
	if screen.AnyChangeMade then
		RequestPreRunLoadoutChangeSave()
	end
	if screen.CloseAnimation ~= nil then
		SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = screen.CloseAnimation })
	end
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.1 )
	AltAspectRatioFramesHide()
	ShowCombatUI( screen.Name )
	OnScreenCloseFinished( screen )

	thread( MarkObjectiveComplete, "UseShrinePrompt" )

	if (screen.PrevShrineUpgrades.NoMetaUpgradesShrineUpgrade or 0) <= 0 and (GameState.ShrineUpgrades.NoMetaUpgradesShrineUpgrade or 0) >= 1 then
		-- NoMetaUpgradesShrineUpgrade turned ON
		UnequipMetaUpgrades()
		GetCurrentMetaUpgradeCost()
	elseif (screen.PrevShrineUpgrades.NoMetaUpgradesShrineUpgrade or 0) >= 1 and (GameState.ShrineUpgrades.NoMetaUpgradesShrineUpgrade or 0) <= 0 then
		-- NoMetaUpgradesShrineUpgrade turned OFF
		EquipPreRunMetaUpgrades()
		GetCurrentMetaUpgradeCost()
	end

	ModifyFormatContainer({ Name = "ShrinePenaltyFormat", Color = screen.ActiveVariableColor })
	UpdateShrineRunDoorArrow()
	if screen.ActiveBounty ~= nil and screen.ActiveBounty ~= screen.StartingBounty and GameState.SpentShrinePointsCache ~= 0 then
		thread( BountyReadyConfirmPresentation, screen, button )
	end

end

function GetTotalSpentShrinePoints()
	local total = 0
	for name, activeRank in pairs( GameState.ShrineUpgrades ) do
		local upgradeData = MetaUpgradeData[name]
		if upgradeData ~= nil then
			for rank = 1, activeRank do
				local rankData = upgradeData.Ranks[rank]
				if rankData ~= nil then
					total = total + rankData.Points
				end
			end
		end
	end
	--[[
	for name, activeRank in pairs( CurrentRun.ShrineUpgrades ) do
		local upgradeData = MetaUpgradeData[name]
		if upgradeData ~= nil then
			for rank = 1, activeRank do
				local rankData = upgradeData.Ranks[rank]
				if rankData ~= nil then
					total = total + rankData.Points
				end
			end
		end
	end
	]]
	return total
end

function GetMaxShrinePoints()
	local total = 0
	for i, name in pairs( ShrineUpgradeOrder ) do
		local upgradeData = MetaUpgradeData[name]
		if upgradeData ~= nil then
			for rank, rankData in ipairs( upgradeData.Ranks ) do
				total = total + rankData.Points
			end
		end
	end
	return total
end

function ShrineScreenRankDown( screen, button )
	if screen.SelectedItem == nil then
		return
	end
	local upgradeData = screen.SelectedItem.Data
	local upgradeName = upgradeData.Name
	if (GameState.ShrineUpgrades[upgradeName] or 0) <= 0 then
		ShrineScreenAlreadyAtMinPresentation( screen, screen.SelectedItem )
		return
	end

	GameState.ShrineUpgrades[upgradeName] = (GameState.ShrineUpgrades[upgradeName] or 0) - 1
	if GameState.ShrineUpgrades[upgradeName] < 0 then
		GameState.ShrineUpgrades[upgradeName] = 0
	end
	ShrineUpgradeExtractValues( upgradeName )
	GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
	screen.AnyChangeMade = true
	ShrineScreenRankDownPresentation( screen, screen.SelectedItem )
end

function ShrineScreenRankUp( screen, button )
	if screen.SelectedItem == nil then
		return
	end
	local upgradeData = screen.SelectedItem.Data
	local upgradeName = upgradeData.Name
	local maxRank = TableLength( upgradeData.Ranks )
	if (GameState.ShrineUpgrades[upgradeName] or 0) >= maxRank then
		ShrineScreenAlreadyAtMaxPresentation( screen, screen.SelectedItem )
		return
	end

	GameState.ShrineUpgrades[upgradeName] = (GameState.ShrineUpgrades[upgradeName] or 0) + 1	
	if GameState.ShrineUpgrades[upgradeName] > maxRank then
		GameState.ShrineUpgrades[upgradeName] = maxRank
	end
	ShrineUpgradeExtractValues( upgradeName )
	GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
	screen.AnyChangeMade = true
	ShrineScreenRankUpPresentation( screen, screen.SelectedItem )
end

function ShrineUpgradeExtractValues( upgradeName )
	local upgradeData = MetaUpgradeData[upgradeName]
	if upgradeData ~= nil and upgradeData.Ranks ~= nil then
		local rank = GetNumShrineUpgrades( upgradeName ) or 0
		if rank >= 1 then			
			if rank > #upgradeData.Ranks then
				rank = #upgradeData.Ranks
			end
			upgradeData.ChangeValue = upgradeData.Ranks[rank].ChangeValue
		else
			upgradeData.ChangeValue = upgradeData.InactiveChangeValue
		end	
		ProcessSimpleExtractValues( upgradeData )
		if rank == 0 and upgradeData.InactiveDisplayValue ~= nil then
			upgradeData.DisplayValue = upgradeData.InactiveDisplayValue
		end
	end
end

function GetNumShrineUpgrades( upgradeName )
	if CurrentRun ~= nil and CurrentRun.ShrineUpgradesDisabled[upgradeName] then
		return 0
	end
	return GameState.ShrineUpgrades[upgradeName] or 0
end

function GetShrineUpgradeChangeValue( upgradeName )
	local upgradeData = MetaUpgradeData[upgradeName]
	local rank = GameState.ShrineUpgrades[upgradeName] or 0
	if rank > #upgradeData.Ranks then
		rank = #upgradeData.Ranks
	end
	if rank == 0 or CurrentRun.ShrineUpgradesDisabled[upgradeName] then
		return upgradeData.InactiveChangeValue
	end
	return upgradeData.Ranks[rank].ChangeValue
end

function CheckEggRespawn( victim, triggerArgs )
	if triggerArgs.BlockRespawns or victim.BlockRespawnShrineUpgrade then
		return false
	end
	local encounterData = EncounterData[CurrentRun.CurrentRoom.Encounter.Name] or CurrentRun.CurrentRoom.Encounter
	if encounterData.BlockRespawnShrineUpgrade then
		return false
	end
	local eggChance = GetShrineUpgradeChangeValue( "EnemyRespawnShrineUpgrade" )
	if RandomChance( eggChance ) then
		local egg = DeepCopyTable( ObstacleData["RespawnEgg"] )
		local eggId = SpawnObstacle({ Name = "RespawnEgg", DestinationId = victim.ObjectId, SkipIfBlocked = true, Group = "Standing", })
		egg.SpawnedFromName = victim.Name
		egg.ObjectId = eggId
		SetupObstacle( egg )
		--RequiredKillEnemies[egg.ObjectId] = egg
		--ActiveEnemies[egg.ObjectId] = egg
		table.insert( SessionMapState.DeferredTableWrite, { TableName = "RequiredKillEnemies", Key = egg.ObjectId, Value = egg } )
		table.insert( SessionMapState.DeferredTableWrite, { TableName = "ActiveEnemies", Key = egg.ObjectId, Value = egg } )
		if victim.Encounter ~= nil then
			victim.Encounter.ActiveSpawns[egg.ObjectId] = true
			egg.Encounter = victim.Encounter
		end
		local spawnForce = RandomFloat( MetaUpgradeData.EnemyRespawnShrineUpgrade.SpawnForceMin, MetaUpgradeData.EnemyRespawnShrineUpgrade.SpawnForceMax )
		ApplyForce({ Id = egg.ObjectId, Speed = spawnForce, Angle = triggerArgs.ImpactAngle })
		UseableOff({ Id = egg.ObjectId })
		thread( GenericPresentation, egg, { PreWait = MetaUpgradeData.EnemyRespawnShrineUpgrade.UseableDelay, UseableOn = true } )
		return true
	end
	return false
end

function RespawnEggCountdown( egg, args )

	egg.AIThreadName = "RespawnEgg"..egg.ObjectId
	egg.TicksRemaining = args.Ticks
	while egg.TicksRemaining > 0 do
		RespawnEggCountdownTickPresentation( egg, args )
		wait( args.Interval, egg.AIThreadName )
		egg.TicksRemaining = egg.TicksRemaining - 1
	end

	local enemyData = EnemyData[egg.SpawnedFromName]
	local newEnemy = DeepCopyTable( enemyData )
	newEnemy.ObjectId = SpawnUnit({ Name = enemyData.Name, Group = "Standing", DestinationId = egg.ObjectId })
	RespawnEggRespawnPresentation( egg, newEnemy )

	RequiredKillEnemies[egg.ObjectId] = nil	
	ActiveEnemies[egg.ObjectId] = nil
	if egg.Encounter ~= nil then
		egg.Encounter.ActiveSpawns[egg.ObjectId] = nil
		newEnemy.Encounter = egg.Encounter
		newEnemy.Encounter.ActiveSpawns[newEnemy.ObjectId] = true
	end

	SetupUnit( newEnemy, CurrentRun, { IgnoreActivateVerticalForce = true } )
	Destroy({ Id = egg.ObjectId })

end

function RespawnEggPickedUp( usee, args, user )
	local egg = usee
	killTaggedThreads( egg.AIThreadName )
	RespawnEggPickedUpPresentation( usee, args, user )
	notifyExistingWaiters( "RequiredKillEnemyKilledOrSpawned" )
	
	RequiredKillEnemies[egg.ObjectId] = nil
	ActiveEnemies[egg.ObjectId] = nil
	if egg.Encounter ~= nil then
		egg.Encounter.ActiveSpawns[egg.ObjectId] = nil
	end
	
	Destroy({ Id = egg.ObjectId })
	if IsEmpty( RequiredKillEnemies ) and IsEmpty( SessionMapState.ProjectilesCarryingSpawns ) then
		notifyExistingWaiters( "AllRequiredKillEnemiesDead" )
		DebugPrint({ Text = "AllRequiredKillEnemiesDead" })
	end
	if egg.Encounter ~= nil and IsEmpty( egg.Encounter.ActiveSpawns ) then
		notifyExistingWaiters( "AllEncounterEnemiesDead"..egg.Encounter.Name )
	end
end

function ApplyEliteAttribute( enemy, attributeName )
	if enemy.EliteAttributeData == nil or enemy.EliteAttributeData[attributeName] == nil then
		DebugPrint({ Text=enemy.Name.." does not have the attribute "..attributeName.." defined!" })
		return
	end
	table.insert(enemy.EliteAttributes, attributeName)
	if enemy.IsClone and enemy.EliteAttributeData[attributeName].SkipApplyOnClones then
		return
	end

	local attributeData = enemy.EliteAttributeData[attributeName]
	local enemyAIData = enemy.DefaultAIData or enemy

	if attributeData.DataOverrides ~= nil then
		OverwriteTableKeys(enemy, attributeData.DataOverrides)
	end

	if attributeData.AIDataOverrides ~= nil then
		OverwriteTableKeys(enemyAIData, attributeData.AIDataOverrides)
	end

	if attributeData.AddWeaponOptions ~= nil then
		for k, weaponName in pairs(attributeData.AddWeaponOptions) do
			table.insert(enemy.WeaponOptions, weaponName)
		end
	end

	if attributeData.AddDumbFireWeaponsOnSpawn ~= nil then
		enemy.AddDumbFireWeaponsOnSpawn = enemy.AddDumbFireWeaponsOnSpawn or {}
		enemy.AddDumbFireWeaponsOnSpawn = CombineTables(enemy.AddDumbFireWeaponsOnSpawn, attributeData.AddDumbFireWeaponsOnSpawn)
	end

	if attributeData.WeaponPropertyChanges ~= nil then
		for k, weaponName in pairs( enemy.WeaponOptions ) do
			ApplyWeaponPropertyChanges( enemy, weaponName, attributeData.WeaponPropertyChanges )
		end
	end

	if attributeData.ThreadedFunctionName ~= nil then
		thread( CallFunctionName, attributeData.ThreadedFunctionName, enemy, attributeData.ThreadedFunctionArgs )
	end
end

function PickEliteAttributes( currentRoom, enemy )

	if currentRoom.Encounter ~= nil and EncounterData[currentRoom.Encounter.Name].BlockEliteAttributes then
		return
	end

	if enemy.EliteAttributeOptions == nil or IsEmpty(enemy.EliteAttributeOptions) then
		return
	end

	enemy.EliteAttributeCount = GetNumShrineUpgrades( "EnemyEliteShrineUpgrade" )
	local attributeOptions = {}
	for k, attributeName in pairs(enemy.EliteAttributeOptions) do
		if IsEliteAttributeEligible(enemy, attributeName) then
			table.insert(attributeOptions, attributeName)
		end
	end

	for i=1, enemy.EliteAttributeCount do
		if IsEmpty(attributeOptions) then
			DebugPrint({ Text="RunLogic.lua:795 ".."Ran out of legal Elite Attribute options!" })
			break
		end
		local attributeName = RemoveRandomValue(attributeOptions)
		currentRoom.EliteAttributes[enemy.Name] = currentRoom.EliteAttributes[enemy.Name] or {}
		table.insert(currentRoom.EliteAttributes[enemy.Name], attributeName)
		RemoveAllValues(attributeOptions, attributeName)
		if enemy.EliteAttributeData[attributeName].BlockAttributes ~= nil then
			for k, blockedAttributeName in pairs(enemy.EliteAttributeData[attributeName].BlockAttributes) do
				RemoveAllValues(attributeOptions, blockedAttributeName)
			end
		end
	end

end

function IsEliteAttributeEligible( enemy, attributeName )
	local attributeRequirements = enemy.EliteAttributeData[attributeName].Requirements or enemy.EliteAttributeData[attributeName]

	if attributeRequirements.RequiresFalseSuperElite and enemy.IsSuperElite then
		return false
	end

	if CurrentRun.BannedEliteAttributes[attributeName] then
		return false
	end

	if Contains( enemy.BlockAttributes, attributeName ) then
		return false
	end

	if not IsGameStateEligible( CurrentRun, enemy.EliteAttributeData[attributeName], attributeRequirements ) then
		return false
	end

	return true
end

function ShrineEliteAttributeManaDrain( enemy, args )
	wait( RandomFloat( args.StartDelayMin, args.StartDelayMax ) )
	while not enemy.IsDead do
		wait( args.TickInterval )
		ManaDelta( args.Amount, { IgnoreSpend = true } )
		thread( ShrineEliteAttributeManaDrainTickPresentation, enemy, args )
	end
end

function ShrineEliteAttributeHitStun( victim, attacker, triggerArgs, args )
	local effectName = args.EffectName
	local dataProperties = MergeTables(	EffectData[effectName].EffectData, args.DataProperties )
	ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
end

function SpawnErisForCurse( source, args )
	local unitData = EnemyData[args.UnitName]
	local newUnit = DeepCopyTable( unitData )
	OverwriteSelf( newUnit, NPCVariantData.ErisCurseGiver )
	newUnit.ObjectId = SpawnUnit({ Name = unitData.Name, Group = "Standing", DestinationId = args.SpawnOnId })
	newUnit.GiveRandomConsumables = args.GiveRandomConsumables
	MapState.RoomRequiredObjects[newUnit.ObjectId] = newUnit
	SetupUnit( newUnit, CurrentRun )
	if args.GoalAngle ~= nil then
		SetGoalAngle({ Id = newUnit.ObjectId, Angle = args.GoalAngle, CompleteAngle = true })
	end
end

function ApplyErisCurse( source, args )
	CurrentRun.ErisCurseStartingDepth = CurrentRun.EncounterDepth
	local trait = AddTrait( CurrentRun.Hero, args.TraitName )
	CallFunctionName( trait.EncounterEndFunctionName, trait, trait.EncounterEndFunctionArgs )
	UpdateTraitSummary()
	ErisCurseAppliedPresentation( source, args )
end

function ErisCurseEnemySetup( trait, unit, args )
	unit.HealthMultiplier = (unit.HealthMultiplier or 1.0) + CurrentRun.ErisCurseHealthMultiplier
	AddOutgoingDamageModifier( unit, { Name = "ErisCurse", GlobalMultiplier = CurrentRun.ErisCurseDamageMultiplier, } )
end

function ErisCurseUpdate( trait, args )
	local encounterAdditions = math.min( CurrentRun.EncounterDepth - (CurrentRun.ErisCurseStartingDepth or 0), args.MaxEncounterAdditions or 99 )

	CurrentRun.ErisCurseHealthMultiplier = args.BaseDamageMultiplierAddition + ((args.PerEncounterHealthMultiplierAddition or 0) * encounterAdditions)
	CurrentRun.ErisCurseHealthMultiplierDisplay = CurrentRun.ErisCurseHealthMultiplier * 100

	CurrentRun.ErisCurseDamageMultiplier = 1.0 + args.BaseDamageMultiplierAddition + ((args.PerEncounterDamageMultiplierAddition or 0) * encounterAdditions)
	CurrentRun.ErisCurseDamageMultiplierDisplay = (CurrentRun.ErisCurseDamageMultiplier - 1.0) * 100
end

function ErisCurseBackCompatSpawnDrops( source, args )
	local spawnPointIds = ShallowCopyTable( args.SpawnPointIds )
	for runIndex, run in ipairs( GameState.RunHistory ) do
		for curseConversationName, curseConversation in pairs( VariantSetData.NPC_Eris_01.ErisCurseGiver.InteractTextLineSets ) do
			if run.TextLinesRecord ~= nil and run.TextLinesRecord[curseConversationName] and not GameState.ErisCurseRewardTaken[runIndex] then
				local spawnPointId = RemoveRandomValue( spawnPointIds ) or source.ObjectId
				if runIndex <= 3 then	
					local giveConsumablesArgs = ShallowCopyTable( args.OceanusRandomConsumables )
					giveConsumablesArgs.DestinationId = spawnPointId
					giveConsumablesArgs.AddUnthreadedOnUseEvent =
					{
						FunctionName = "ErisCurseRewardTaken",
						Args = { RunNum = runIndex },
					}
					GiveRandomConsumables( giveConsumablesArgs )
				elseif runIndex <= 7 then
					local giveConsumablesArgs = ShallowCopyTable( args.FieldsRandomConsumables )
					giveConsumablesArgs.DestinationId = spawnPointId
					giveConsumablesArgs.AddUnthreadedOnUseEvent =
					{
						FunctionName = "ErisCurseRewardTaken",
						Args = { RunNum = runIndex },
					}
					GiveRandomConsumables( giveConsumablesArgs )
				else
					local giveConsumablesArgs = ShallowCopyTable( args.TartarusGiveRandomConsumables )
					giveConsumablesArgs.DestinationId = spawnPointId
					giveConsumablesArgs.AddUnthreadedOnUseEvent =
					{
						FunctionName = "ErisCurseRewardTaken",
						Args = { RunNum = runIndex },
					}
					GiveRandomConsumables( giveConsumablesArgs )
				end
			end
		end
	end
end

function ErisCurseRewardTaken( source, args )
	GameState.ErisCurseRewardTaken[args.RunNum] = true
end

function CheckNewTraitManaReserveShrineUpgrade( newTrait, args )
	if newTrait == nil then
		return
	end
	local manaReservePerRarity = MetaUpgradeData.BoonManaReserveShrineUpgrade.ChangeValue
	if manaReservePerRarity > 0 then
		local getRarityRank = TraitRarityData.RarityValues[newTrait.Rarity] or 0
		if getRarityRank >= 2 then
			local manaReserveAmount = manaReservePerRarity * (getRarityRank - 1)
			newTrait.ShrineManaReserve = manaReserveAmount
			ReserveMana( manaReserveAmount, "BoonManaReserveShrineUpgrade" )
			thread( BoonManaReserveShrineUpgradePresentation, source, { Amount = manaReserveAmount } )
		end
	end
end

function CheckPrevTraitsManaReserveShrineUpgrade( hero, args )
	local totalManaReserve = 0
	for traitIndex, trait in ipairs( CurrentRun.Hero.Traits ) do
		totalManaReserve = totalManaReserve + (trait.ShrineManaReserve or 0)
	end
	if totalManaReserve > 0 then
		ReserveMana( totalManaReserve, "BoonManaReserveShrineUpgrade" )
	end
end

function ShrineLogicResetAll( screen, button )
	local components = screen.Components
	for itemIndex = 1, screen.NumItems do
		local button = components["ItemButton"..itemIndex]
		if (GameState.ShrineUpgrades[button.Data.Name] or 0) >= 1 then
			GameState.ShrineUpgrades[button.Data.Name] = 0
			ShrineScreenRankDownPresentation( screen, button )
			ShrineUpgradeExtractValues( button.Data.Name )
		end
	end
	screen.AnyChangeMade = true
	GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
	SetAlpha({ Id = components.ResetAllButton.Id, Fraction = 0.0, Duration = 0.2 })
end

function CheckBoonSkipShrineUpgrade( source, args )
	local currentRoom = CurrentRun.CurrentRoom
	local boonSkipRank = GetNumShrineUpgrades( "BoonSkipShrineUpgrade" )
	local roomSetName = currentRoom.RoomSetName
	if currentRoom.UsePreviousRoomSet then
		local previousRoom = GetPreviousRoom( CurrentRun ) or currentRoom
		roomSetName = previousRoom.RoomSetName
	end
	if boonSkipRank > (CurrentRun.BiomeBoonSkips[roomSetName] or 0) then
		CurrentRun.BiomeBoonSkips[roomSetName] = (CurrentRun.BiomeBoonSkips[roomSetName] or 0) + 1
		local consumableId = SpawnObstacle({ Name = "RoomRewardConsolationPrize", DestinationId = args.LootPointId, Group = "Standing", OffsetX = args.LootOffset.X, OffsetY = args.LootOffset.Y })
		local reward = CreateConsumableItem( consumableId, "RoomRewardConsolationPrize", 0, { IgnoreSounds = currentRoom.SuppressRewardSpawnSounds } )
		MapState.RoomRequiredObjects[reward.ObjectId] = reward
		thread( BoonSkipShrineUpgradePresentation, reward )
		return reward
	end
	return nil
end

function DisableBiomeSpeedShrineUpgrade( source, args )
	CurrentRun.ActiveBiomeTimer = false
end