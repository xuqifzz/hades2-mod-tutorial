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
		local maxRank = GetShrineUpgradeMaxRank( upgradeData )
		if maxRank > 0 then
			if upgradeData.UseWideAnimations then
				itemLocationX = screen.ItemStartX + screen.WideItemOffsetX
			end

			local startOffsetY = 10

			local backing = CreateScreenComponent({
				Name = "BlankObstacle", 
				Group = screen.ComponentData.DefaultGroup,
				X = itemLocationX,
				Y = itemLocationY + startOffsetY,
				Scale = screen.IconBackingScale
			})

			local fadeDuration = index * 0.018
			Move({ Id = backing.Id, Duration = fadeDuration * 1.2 + 0.24, OffsetX = itemLocationX, OffsetY = itemLocationY, EaseIn = 0.9, EaseOut = 1})
			SetAlpha({ Id = backing.Id, Fraction = 0 })
			SetAlpha({ Id = backing.Id, Fraction = 1, Duration = fadeDuration, EaseIn = 0, EaseOut = 1 })
			SetScale({ Id = backing.Id, Fraction = 0.8 })
			SetScale({ Id = backing.Id, Fraction = 1, Duration = fadeDuration, EaseIn = 0, EaseOut = 1 })
			components["ItemBacking"..index] = backing
			AttachLua({ Id = backing.Id, Table = backing })
			backing.Screen = screen
			backing.Data = upgradeData

			local highlightAnimation = screen.SelectionHighlightAnimation
			if upgradeData.UseWideAnimations then
				highlightAnimation = screen.SelectionHighlightWideAnimation
			end
			local highlight = CreateScreenComponent({
				Name = "BlankObstacle",
				Group = screen.ComponentData.DefaultGroup,
				X = itemLocationX,
				Y = itemLocationY,
				Animation = highlightAnimation,
				Alpha = 0.0
			})
			components["ItemHighlight"..index] = highlight
			AttachLua({ Id = highlight.Id, Table = highlight })
			highlight.Screen = screen

			local buttonName = "ButtonShrineItem"
			local iconOffsetX = screen.IconOffsetX
			local iconOffsetY = screen.IconOffsetY
			if upgradeData.UseWideAnimations then
				buttonName = "ButtonShrineItemWide"
				iconOffsetX = iconOffsetX + screen.WideIconGroupShiftX
			end
			local button = CreateScreenComponent({
				Name = buttonName,
				Group = screen.ComponentData.DefaultGroup,
				X = itemLocationX + iconOffsetX,
				Y = itemLocationY + iconOffsetY,
				Animation = upgradeData.Icon,
				Scale = screen.IconScale
			})
			components["ItemButton"..index] = button
			AttachLua({ Id = button.Id, Table = button })
			button.Screen = screen
			button.Data = upgradeData
			button.Backing = backing
			button.Highlight = highlight
			if upgradeData.UseWideAnimations then
				button.GlintAnimationName = screen.SelectionHighlightWideGlintAnimation
			else
				button.GlintAnimationName = screen.SelectionHighlightGlintAnimation
			end
			button.OnMouseOverFunctionName = "ShrineScreenMouseOverItem"
			button.OnMouseOffFunctionName = "ShrineScreenMouseOffItem"
			button.OnPressedFunctionName = "ShrineScreenRankUp"

			local nextRankBackingOffsetX = screen.NextRankBackingOffsetX
			local nextRankBackingOffsetY = screen.NextRankBackingOffsetY
			if upgradeData.UseWideAnimations then
				nextRankBackingOffsetX = screen.NextRankBackingWideOffsetX
				nextRankBackingOffsetY = screen.NextRankBackingWideOffsetY
			end
			local nextRankBacking = CreateScreenComponent({
				Name = "BlankObstacle",
				Group = screen.ComponentData.DefaultGroup,
				X = itemLocationX + nextRankBackingOffsetX,
				Y = itemLocationY + nextRankBackingOffsetY,
				Alpha = 0.0
			})
			components["NextRankBacking"..index] = nextRankBacking
			AttachLua({ Id = nextRankBacking.Id, Table = nextRankBacking })
			nextRankBacking.Screen = screen
			nextRankBacking.Button = button
			button.NextRankBacking = nextRankBacking

			local nextRankFormat = ShallowCopyTable( screen.NextRankFormat )
			nextRankFormat.Id = nextRankBacking.Id
			CreateTextBox( nextRankFormat )

			button.RankPips = {}
			local pipOffsetX = screen.RankPipStartOffsetX
			local pipOffsetY = screen.RankPipStartOffsetY
			if upgradeData.UseWideAnimations then
				pipOffsetX = pipOffsetX + screen.WideIconGroupShiftX
			end
			for rank = 1, maxRank do
				local rankPip = CreateScreenComponent({
					Name = "BlankObstacle",
					Group = screen.ComponentData.DefaultGroup,
					Scale = screen.RankPipScale,
					X = itemLocationX + pipOffsetX,
					Y = itemLocationY + pipOffsetY
				})
				components["RankPips"..rank..index] = rankPip
				AttachLua({ Id = rankPip.Id, Table = rankPip })
				rankPip.Screen = screen
				button.RankPips[rank] = rankPip

				pipOffsetX = pipOffsetX + screen.RankPipSpacingX
				pipOffsetY = pipOffsetY + screen.RankPipSpacingY
			end

			ShrineScreenUpdateNextRankText( button, true )

			ShrineUpgradeExtractValues( upgradeName )

			local shortNameFormat = ShallowCopyTable( screen.ShortNameFormat )
			local currentRank = GetNumShrineUpgrades( upgradeData.Name )
			if currentRank > 0 then
				shortNameFormat = ShallowCopyTable( screen.ShortNameActiveFormat )
			end
			shortNameFormat.Id = button.Id
			shortNameFormat.Text = upgradeData.Name.."_Short"
			CreateTextBox( shortNameFormat )

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

			if index == 1 then
				TeleportCursor({ DestinationId = button.Id, ForceUseCheck = true })
			end

			if upgradeData.RankRevealedFunctionName ~= nil then
				local worldUpgradeName = upgradeName.."Rank"..maxRank
				if not GameState.WorldUpgradesRevealed[worldUpgradeName] then
					thread( CallFunctionName, upgradeData.RankRevealedFunctionName, screen, button, { Rank = maxRank } )
				end
				GameState.WorldUpgradesRevealed[worldUpgradeName] = true
			end

			if index % screen.ItemsPerRow == 0 then
				itemLocationX = screen.ItemStartX
				itemLocationY = itemLocationY + screen.ItemSpacingY
			else
				itemLocationX = itemLocationX + screen.ItemSpacingX
			end		

			screen.NumItems = screen.NumItems + 1
		end
	end

	screen.PrevShrineUpgrades = ShallowCopyTable( GameState.ShrineUpgrades )

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
			if GameState.ShrineBountiesCompleted[bountyName] then
				completeBountyNum = completeBountyNum + 1
			else
				if bountyData.UnlockGameStateRequirements ~= nil and IsGameStateEligible( bountyData, bountyData.UnlockGameStateRequirements ) then		
					availableBountyNum = availableBountyNum + 1
					local key = "BountyAvailable"..availableBountyNum
					if availableBountyNum <= screen.MaxBountiesAvailable then

						local targetItem = CreateScreenComponent({
							Name = "BlankObstacle",
							Group = screen.ComponentData.DefaultGroup,
							X = itemLocationX + screen.BountyTargetOffsetX,
							Y = itemLocationY + screen.BountyTargetOffsetY,
							Animation = screen.BountyTargetIcons[bountyData.Encounters[1]],
							Scale = screen.BountyBossIconScale
						})
						components[key.."Target"] = targetItem

						local bountyBacking = CreateScreenComponent({
							Name = "BlankObstacle",
							Group = screen.ComponentData.DefaultGroup,
							X = itemLocationX,
							Y = itemLocationY,
							Animation = "GUI\\Screens\\Shrine\\Testament",
							Scale = 1.0
						})
						components[key.."Backing"] = bountyBacking

						local shrinePointItem = CreateScreenComponent({
							Name = "BlankObstacle",
							Group = screen.ComponentData.DefaultGroup,
							X = itemLocationX + screen.BountyShrinePointsOffsetX,
							Y = itemLocationY + screen.BountyShrinePointsOffsetY
						})
						shrinePointItem.BountyData = bountyData
						shrinePointItem.MatchedWeapon = matchedWeapon
						shrinePointItem.WeaponName = weaponName
						shrinePointItem.RequiredShrinePoints = shrinePoints
						components[key.."ShrinePoints"] = shrinePointItem
						local bountyShrinePointsFormat = ShallowCopyTable( screen.BountyShrinePointsFormat )
						bountyShrinePointsFormat.Id = shrinePointItem.Id
						bountyShrinePointsFormat.Text = "ShrineScreen_BountyShrinePoints"
						bountyShrinePointsFormat.LuaKey = "TempTextData"
						bountyShrinePointsFormat.LuaValue = { RequiredShrinePoints = shrinePoints }
						CreateTextBox( bountyShrinePointsFormat )

						local weaponItem = CreateScreenComponent({
							Name = "BlankObstacle",
							Group = screen.ComponentData.DefaultGroup,
							X = itemLocationX + screen.BountyWeaponOffsetX,
							Y = itemLocationY + screen.BountyWeaponOffsetY,
							Animation = screen.BountyWeaponIcons[weaponName],
							Scale = screen.BountyWeaponIconScale
						})
						components[key.."Weapon"] = weaponItem

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
		local surfaceShrinePointRecord = GameState.HighestShrinePointClearSurfaceCache
		local underworldShrinePointRecord = GameState.HighestShrinePointClearUnderworldCache
		DebugAssert({ Condition = (#screen.UnderworldShrinePointThresholds == #screen.SurfaceShrinePointThresholds), Text = "Underworld and Surface do not have the same number of shrine point thresholds!", Owner = "Caleb" })
		for i=1,#screen.UnderworldShrinePointThresholds do
			local underworldThreshold = screen.UnderworldShrinePointThresholds[i]
			local surfaceThreshold = screen.SurfaceShrinePointThresholds[i]
			if surfaceShrinePointRecord >= surfaceThreshold and underworldShrinePointRecord >= underworldThreshold then
				-- Both runs complete, move to next threshold
			else
				screen.NextSurfaceSkellyShrinePointGoal = surfaceThreshold
				if surfaceShrinePointRecord >= surfaceThreshold then
					SetAnimation({ DestinationId = components.SkellyQuestSurface.Id, Name = "GUI\\Screens\\Shrine\\SkellyComplete" })
					ModifyTextBox({ Id = components.SkellyQuestSurface.Id, Text = "ShrineScreen_SkellyStatueSurface_Complete", FadeTarget = 1.0 })
					SetAlpha({ Id = components.SkellyQuestSurfaceStrikethrough.Id, Fraction = 1.0, Duration = 0.2 })
				end

				screen.NextUnderworldSkellyShrinePointGoal = underworldThreshold
				if underworldShrinePointRecord >= underworldThreshold then
					SetAnimation({ DestinationId = components.SkellyQuestUnderworld.Id, Name = "GUI\\Screens\\Shrine\\SkellyComplete" })
					ModifyTextBox({ Id = components.SkellyQuestUnderworld.Id, Text = "ShrineScreen_SkellyStatueUnderworld_Complete", FadeTarget = 1.0 })
					SetAlpha({ Id = components.SkellyQuestUnderworldStrikethrough.Id, Fraction = 1.0, Duration = 0.2 })
				end
				break
			end
		end
		if GameState.TyphonDefeatedWithStormStop and not GameState.ReachedTrueEnding then
			SetAlpha({ Ids = { components.SkellyQuestSurface.Id, components.SkellyQuestSurfaceStrikethrough.Id }, Fraction = 0 })
		end
		ShrineScreenUpdateSkellyText( screen )
	end

	if components.SkellyQuestCompleteIcon ~= nil then
		SetAlpha({ Id = components.SkellyQuestCompleteIcon.Id, Fraction = 1.0, Duration = 0.3 })
	end

	ShrineScreenUpdateActivePoints( screen, nil, { Duration = 0.0 } )
	screen.StartingBounty = screen.ActiveBounty
	ShrineScreenUpdateItems( screen )
	
	if showHint then
		GenericInfoPresentation( screen )
	end

	ShrineScreenOpenFinishedPresentation( screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )

end

function CloseShrineUpgradeScreen( screen, button )

	UpdateShrineAnimation( screen.ActiveBounty )
	UpdateEscapeDoorForLimitGraspShrineUpgrade( nil, { EscapeDoorIds = { 420947, 555784 } } )
	if screen.AnyChangeMade then
		RequestPreRunLoadoutChangeSave()
	end
	if screen.CloseAnimation ~= nil then
		SetAnimation({ DestinationId = screen.Components.Background.Id, Name = screen.CloseAnimation })
	end
	StopAnimation({ Name = "ShrinePactThermometerFxGlow", DestinationId = screen.Components.ThermometerFullFx.Id })
	StopAnimation({ Name = "ShrinePactThermometerFullGlints", DestinationId = screen.Components.ThermometerFullFx.Id })
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ) )
	AltAspectRatioFramesHide()
	ShowCombatUI( screen.Name )
	OnScreenCloseFinished( screen )

	if screen.AnyChangeMade then
		thread( PlayVoiceLines, screen.ChangeMadeCloseVoiceLines, true )
	end
	thread( MarkObjectiveComplete, "UseShrinePrompt" )

	ModifyFormatContainer({ Name = "ShrinePenaltyFormat", Color = screen.ActiveVariableColor })
	UpdateShrineRunDoorArrow()
	if screen.ActiveBounty ~= nil and screen.ActiveBounty ~= screen.StartingBounty and GameState.SpentShrinePointsCache ~= 0 then
		thread( BountyReadyConfirmPresentation, screen, button )
	end

end

function GetShrineUpgradeMaxRank( upgradeData )
	local maxRank = 0
	for i, rankData in ipairs( upgradeData.Ranks ) do
		if rankData.GameStateRequirements == nil or IsGameStateEligible( upgradeData, rankData.GameStateRequirements ) then
			maxRank = i
		end
	end
	return maxRank
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
	return total
end

function GetMaxShrinePoints()
	local total = 0
	for i, name in pairs( ShrineUpgradeOrder ) do
		local upgradeData = MetaUpgradeData[name]
		if upgradeData ~= nil then
			for rank, rankData in ipairs( upgradeData.Ranks ) do
				if rankData.GameStateRequirements == nil or IsGameStateEligible( rankData, rankData.GameStateRequirements ) then
					total = total + rankData.Points
				end
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
	ShrineScreenUpdateSkellyText( screen )
	ShrineScreenRankDownPresentation( screen, screen.SelectedItem )
end

function ShrineScreenRankUp( screen, button )
	if screen.SelectedItem == nil then
		return
	end
	local upgradeData = screen.SelectedItem.Data
	local upgradeName = upgradeData.Name
	local maxRank = GetShrineUpgradeMaxRank( upgradeData )
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
	ShrineScreenUpdateSkellyText( screen )
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
	if MapState.BlockRespawns then
		return false
	end
	local eggChance = GetShrineUpgradeChangeValue( "EnemyRespawnShrineUpgrade" )
	if RandomChance( eggChance ) and not IsLocationBlocked({ Id = victim.ObjectId }) then
		local egg = DeepCopyTable( ObstacleData.RespawnEgg )
		local eggId = SpawnObstacle({ Name = "RespawnEgg", DestinationId = victim.ObjectId, Group = "Standing", })
		egg.SpawnedFromName = victim.Name
		egg.ObjectId = eggId
		SetupObstacle( egg )
		RequiredKillEnemies[egg.ObjectId] = egg
		ActiveEnemies[egg.ObjectId] = egg
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
		if IsLocationBlocked({ Id = egg.ObjectId }) then
			RespawnEggPickedUp( egg )
			return
		end
	end

	local enemyData = EnemyData[egg.SpawnedFromName]
	local newEnemy = DeepCopyTable( enemyData )
	newEnemy.ObjectId = SpawnUnit({ Name = enemyData.Name, Group = "Standing", DestinationId = egg.ObjectId })
	newEnemy.BlockRespawnShrineUpgrade = true
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
	notifyExistingWaiters( "RequiredKillEnemyKilledOrSpawned" )
	notifyExistingWaiters( "RequiredEnemyKilled" )
	if egg.Encounter ~= nil then
		egg.Encounter.ActiveSpawns[egg.ObjectId] = nil
	end
	
	Destroy({ Id = egg.ObjectId })
	CheckAllRequiredKillEnemiesDead( egg.Encounter )

end

function ApplyEliteAttribute( enemy, attributeName )

	local attributeData = enemy.EliteAttributeData[attributeName]
	local enemyAIData = enemy.DefaultAIData or enemy

	if enemy.EliteAttributeData == nil or enemy.EliteAttributeData[attributeName] == nil then
		DebugPrint({ Text=enemy.Name.." does not have the attribute "..attributeName.." defined!" })
		return
	end

	if attributeData.MaxPerRoom ~= nil then
		CurrentRun.CurrentRoom.EliteAttributeCount = CurrentRun.CurrentRoom.EliteAttributeCount or {}
		CurrentRun.CurrentRoom.EliteAttributeCount[attributeName] = CurrentRun.CurrentRoom.EliteAttributeCount[attributeName] or 0

		if CurrentRun.CurrentRoom.EliteAttributeCount[attributeName] >= attributeData.MaxPerRoom then
			return
		else
			CurrentRun.CurrentRoom.EliteAttributeCount[attributeName] = CurrentRun.CurrentRoom.EliteAttributeCount[attributeName] + 1
		end
	end

	table.insert(enemy.EliteAttributes, attributeName)

	if enemy.IsClone and enemy.EliteAttributeData[attributeName].SkipApplyOnClones then
		return
	end

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

	if attributeData.ScaleMultiplier ~= nil then
		SetScale({ Id = enemy.ObjectId, Fraction = attributeData.ScaleMultiplier })
		enemy.HealthBarOffsetY = ( enemy.HealthBarOffsetY or -155 ) * attributeData.ScaleMultiplier
	end

	if attributeData.UnitPropertyChanges then
		ApplyUnitPropertyChanges(enemy, attributeData.UnitPropertyChanges)
	end

	if attributeData.AddAdditionalAIFunctions ~= nil then
		enemy.AdditionalAIFunctions = enemy.AdditionalAIFunctions or {}
		for k, functionName in pairs(attributeData.AddAdditionalAIFunctions) do
			table.insert(enemy.AdditionalAIFunctions, functionName)
		end
	end

	if attributeData.AddDumbFireWeaponsOnSpawn ~= nil then
		enemy.AddDumbFireWeaponsOnSpawn = enemy.AddDumbFireWeaponsOnSpawn or {}
		enemy.AddDumbFireWeaponsOnSpawn = CombineTables(enemy.AddDumbFireWeaponsOnSpawn, attributeData.AddDumbFireWeaponsOnSpawn)
	end

	if attributeData.AddDeathWeapons ~= nil then
		enemy.OnDeathFireWeapons = enemy.OnDeathFireWeapons or {}
		for k, weaponName in pairs(attributeData.AddDeathWeapons) do
			table.insert(enemy.OnDeathFireWeapons, weaponName)
		end
	end

	if attributeData.AddOutgoingDamageModifiers ~= nil then
		for s, damageModifierData in pairs( attributeData.AddOutgoingDamageModifiers ) do
			AddOutgoingDamageModifier( enemy, damageModifierData )
		end
	end

	if attributeData.ThreadedFunctionName ~= nil then
		thread( CallFunctionName, attributeData.ThreadedFunctionName, enemy, attributeData.ThreadedFunctionArgs )
	end
end

function PickEliteAttributes( encounter, enemyType )
	
	local enemyData = EnemyData[enemyType]
	if enemyData.EliteAttributeOptions == nil or IsEmpty(enemyData.EliteAttributeOptions) then
		return
	end

	encounter.EliteAttributes = encounter.EliteAttributes or {}
	local bannedAttributes = encounter.BannedEliteAttributes or {}
	
	local attributeOptions = {}
	for k, attributeName in pairs(enemyData.EliteAttributeOptions) do
		if not Contains(bannedAttributes, attributeName) and IsEliteAttributeEligible(enemyData, attributeName) then
			table.insert(attributeOptions, attributeName)
		end
	end

	for i=1, encounter.ForceEliteAttrubuteCount or GetNumShrineUpgrades( "EnemyEliteShrineUpgrade" ) do
		if IsEmpty(attributeOptions) then
			DebugPrint({ Text="RunLogic.lua:795 ".."Ran out of legal Elite Attribute options!" })
			break
		end
		local attributeName = RemoveRandomValue(attributeOptions)
		encounter.EliteAttributes[enemyData.Name] = encounter.EliteAttributes[enemyData.Name] or {}
		table.insert(encounter.EliteAttributes[enemyData.Name], attributeName)
		RemoveAllValues(attributeOptions, attributeName)
		if enemyData.EliteAttributeData[attributeName].BlockAttributes ~= nil then
			for k, blockedAttributeName in pairs(enemyData.EliteAttributeData[attributeName].BlockAttributes) do
				RemoveAllValues(attributeOptions, blockedAttributeName)
			end
		end
	end

end

function IsEliteAttributeEligible( enemyData, attributeName )
	local eliteAttributeData = enemyData.EliteAttributeData[attributeName]

	if eliteAttributeData.RequiresFalseSuperElite and enemyData.IsSuperElite then
		return false
	end

	if CurrentRun.BannedEliteAttributes[attributeName] then
		return false
	end

	if Contains( enemyData.BlockAttributes, attributeName ) then
		return false
	end

	if eliteAttributeData.GameStateRequirements ~= nil and not IsGameStateEligible( eliteAttributeData, eliteAttributeData.GameStateRequirements ) then
		return false
	end

	return true
end

function ShrineEliteAttributeManaDrain( triggerArgs, args )
	ManaDelta( args.Amount, { IgnoreSpend = true, ManaDrain = true } )
	thread( ShrineEliteAttributeManaDrainTickPresentation, args )
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

function EliteSpreadHitShields( triggerArgs )
	local victim = triggerArgs.Victim
	if not victim or victim == CurrentRun.Hero then
		return
	end
	if victim.Groups ~= nil and Contains(victim.Groups, "HeroTeam") then
		return
	end
	if victim.MaxHitShields == nil then
		return
	end
	local count = 1
	victim.HitShields = victim.HitShields or 0
	victim.HitShields = math.min(victim.HitShields + count, victim.MaxHitShields )
	if not victim.HasHealthBar then
		CreateHealthBar( victim )
	end
	UpdateHealthBar( victim, 0, { Force = true } )
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

function ErisCurseRewardTaken( source, args )
	GameState.ErisCurseRewardTaken[args.RunNum] = true
end

function CheckNewTraitManaReserveShrineUpgrade( newTrait, args )
	if CurrentRun.ShrineUpgradesDisabled and CurrentRun.ShrineUpgradesDisabled.BoonManaReserveShrineUpgrade then
		return
	end
	if newTrait == nil then
		return
	end
	if not args.IsGodLoot then
		return
	end
	local manaReservePerRarity = MetaUpgradeData.BoonManaReserveShrineUpgrade.ChangeValue
	if manaReservePerRarity > 0 then
		local getRarityRank = TraitRarityData.RarityValues[newTrait.Rarity] or 0
		if newTrait.IsElementalTrait then
			getRarityRank = 1
		end
		if getRarityRank >= 2 then
			local manaReserveAmount = manaReservePerRarity * (getRarityRank - 1)
			newTrait.ShrineManaReserve = manaReserveAmount
			ReserveMana( manaReserveAmount, "BoonManaReserveShrineUpgrade" )
			thread( BoonManaReserveShrineUpgradePresentation, source, { Amount = manaReserveAmount } )
		end
	end
end

function CheckPrevTraitsManaReserveShrineUpgrade( hero )
	if CurrentRun.ShrineUpgradesDisabled and CurrentRun.ShrineUpgradesDisabled.BoonManaReserveShrineUpgrade then
		return
	end
	local totalManaReserve = 0
	for traitIndex, trait in ipairs( hero.Traits ) do
		totalManaReserve = totalManaReserve + (trait.ShrineManaReserve or 0)
	end
	if totalManaReserve > 0 then
		ReserveMana( totalManaReserve, "BoonManaReserveShrineUpgrade" )
	end
end

function RemoveBoonManaReserve()
	UnreserveMana("BoonManaReserveShrineUpgrade")
	UpdateManaMeterUI()
end

function ShrineLogicResetAll( screen, button )
	if GameState.SpentShrinePointsCache == 0 then
		return
	end
	local components = screen.Components
	for itemIndex = 1, screen.NumItems do
		local button = components["ItemButton"..itemIndex]
		if (GameState.ShrineUpgrades[button.Data.Name] or 0) >= 1 then
			GameState.ShrineUpgrades[button.Data.Name] = 0
			ShrineScreenRankDownPresentation( screen, button, { Silent = true, RemoveNameHighlight = true } )
			ShrineUpgradeExtractValues( button.Data.Name )
		end
	end
	screen.AnyChangeMade = true
	GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
	SetAlpha({ Id = components.ResetAllButton.Id, Fraction = 0.0, Duration = 0.2 })
	ShrineScreenUpdateSkellyText( screen )
	ShrineScreenResetPresentation( screen )
end

function ShrineScreenUpdateSkellyText( screen )
	local components = screen.Components
	if components.SkellyQuestSurface == nil or screen.NextSurfaceSkellyShrinePointGoal == nil then
		return
	end

	if GameState.HighestShrinePointClearSurfaceCache < screen.NextSurfaceSkellyShrinePointGoal then
		if GameState.SpentShrinePointsCache < screen.NextSurfaceSkellyShrinePointGoal then
			ModifyTextBox({ Id = components.SkellyQuestSurface.Id, Text = "ShrineScreen_SkellyStatueSurface_Insufficient", FadeTarget = 1.0 })
		else
			ModifyTextBox({ Id = components.SkellyQuestSurface.Id, Text = "ShrineScreen_SkellyStatueSurface_Incomplete", FadeTarget = 1.0 })
		end
	end

	if GameState.HighestShrinePointClearUnderworldCache < screen.NextUnderworldSkellyShrinePointGoal then
		if GameState.SpentShrinePointsCache < screen.NextUnderworldSkellyShrinePointGoal then
			ModifyTextBox({ Id = components.SkellyQuestUnderworld.Id, Text = "ShrineScreen_SkellyStatueUnderworld_Insufficient", FadeTarget = 1.0 })
		else
			ModifyTextBox({ Id = components.SkellyQuestUnderworld.Id, Text = "ShrineScreen_SkellyStatueUnderworld_Incomplete", FadeTarget = 1.0 })
		end
	end
end

function CheckBoonSkipShrineUpgrade( source, args )
	local currentRoom = CurrentRun.CurrentRoom
	if GetNumShrineUpgrades( "BoonSkipShrineUpgrade" ) > CurrentRun.BiomeBoonSkipCount then
		CurrentRun.BiomeBoonSkipCount = CurrentRun.BiomeBoonSkipCount + 1
		local consumableId = SpawnObstacle({ Name = "RoomRewardConsolationPrize", DestinationId = args.LootPointId, Group = "Standing", OffsetX = args.LootOffset.X, OffsetY = args.LootOffset.Y })
		local reward = CreateConsumableItem( consumableId, "RoomRewardConsolationPrize", 0, { IgnoreSounds = currentRoom.SuppressRewardSpawnSounds } )
		MapState.RoomRequiredObjects[reward.ObjectId] = reward
		thread( BoonSkipShrineUpgradePresentation, reward, args )
		return reward
	end
	return nil
end

function DisableBiomeSpeedShrineUpgrade( source, args )
	CurrentRun.ActiveBiomeTimer = false
end

function RemoveEnemyDamageShrineUpgrade( source, args )
	RemoveIncomingDamageModifier( CurrentRun.Hero, "EnemyDamageShrineUpgrade" )
end