function OpenRunClearScreen()

	AltAspectRatioFramesShow()
	AddInputBlock({ Name = "OpenRunClearScreen" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm2" })
	LoadVoiceBank({ Name = "Chaos", IgnoreAssert = true })

	SessionMapState.PrevShowGameplayTimer = ConfigOptionCache.ShowGameplayTimer
	SetConfigOption({ Name = "ShowGameplayTimer", Value = false })

	local prevRecordTime = nil
	local prevRecordShrinePoints = nil
	if CurrentRun.BiomesReached.F then
		prevRecordTime = GameState.FastestUnderworldClearTimeCache
		prevRecordShrinePoints = GameState.HighestShrinePointClearUnderworldCache
	else
		prevRecordTime = GameState.FastestSurfaceClearTimeCache
		prevRecordShrinePoints = GameState.HighestShrinePointClearSurfaceCache
	end

	RecordRunCleared()

	thread( PlayVoiceLines, HeroVoiceLines.RunClearedVoiceLines )

	local screen = DeepCopyTable( ScreenData.RunClear )
	screen.DamageDealtStartX = ScreenWidth - screen.DamageDealtRightOffset
	screen.DamageDealtStartY = screen.DamageDealtStartY + (ScreenCenterNativeOffsetY * 2)
	screen.DamageTakenStartY = screen.DamageTakenStartY + (ScreenCenterNativeOffsetY * 2)
	if CurrentRun.BiomesReached.Q then
		screen.ComponentData.VictoryBackground.Animation = "VictoryScreenIllustration_Surface"
		screen.ComponentData.TitleText = screen.ComponentData.SurfaceTitleText
		screen.ComponentData.RunClearMessageText = screen.ComponentData.SurfaceRunClearMessageText
	else
		screen.ComponentData.TitleText = screen.ComponentData.UnderworldTitleText
		screen.ComponentData.RunClearMessageText = screen.ComponentData.UnderworldRunClearMessageText
	end

	screen.ComponentData.UnderworldTitleText = nil
	screen.ComponentData.UnderworldRunClearMessageText = nil
	screen.ComponentData.SurfaceTitleText = nil
	screen.ComponentData.SurfaceRunClearMessageText = nil

	local args = {}
	HideMoneyUI( args )
	HideRerollUI( args )
	HideResourceUIs( args )
	HideObjectivesUI()

	if MapState.FamiliarUnit ~= nil and MapState.FamiliarUnit.StopAIOnRunClear then
		CallFunctionName( MapState.FamiliarUnit.StopAIFunctionName, MapState.FamiliarUnit )
	end

	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	OnScreenOpened( screen )
	FrameState.RequestUpdateHealthUI = true

	local components = screen.Components

	-- Badge
	if GameState.BadgeRank ~= nil then
		local badgeData = BadgeData[BadgeOrderData[GameState.BadgeRank]]
		if badgeData ~= nil then
			SetAnimation({ DestinationId = components.BadgeRankIcon.Id, Name = badgeData.Icon })
		end
	end

	wait( 0.3 )

	local traitTrayScreen = OpenTraitTrayScreen( {
		DontDuckAudio = true,
		DisableTooltips = true,
		HideCloseButton = true,
		HideInfoButton = true,
		HideBounty = true,
		HideBackgroundTint = true,
		HideRoomCount = true,
		HideCategoryTitleText = true,
		AutoPin = true,
		SkipInputHandlers = true,
		OverwriteSelf = { IgnoreOtherScreenInput = false, },
	} )

	PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuSwitch" })
	SetConfigOption({ Name = "TooltipShowDelay", Value = 999999 })

	-- ClearTime
	ModifyTextBox({ Id = components.ClearTimeValue.Id, Text = GetTimerString( CurrentRun.GameplayTime, 2 ), })
	if CurrentRun.GameplayTime <= prevRecordTime then
		wait( 0.1 )
		SetAlpha({ Id = components.ClearTimeRecord.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 1.0 })
	end
	wait(0.05)

	-- ShrinePoints
	if (CurrentRun.ShrinePointsCache or 0) > 0 then
		SetAlpha({ Id = components.ShrinePointsLabel.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 1.0 })
		SetAlpha({ Id = components.ShrinePointsValue.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 1.0 })
		ModifyTextBox({ Id = components.ShrinePointsValue.Id, Text = CurrentRun.ShrinePointsCache })
		if CurrentRun.ShrinePointsCache > prevRecordShrinePoints then
			wait( 0.1 )
			SetAlpha({ Id = components.ShrinePointsRecord.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 1.0 })
		end
		wait(0.05)
	end

	-- Damage Dealt
	local damageLocationX = screen.DamageDealtStartX
	local damageLocationY = screen.DamageDealtStartY
	local mappedDamageDealtRecord = {}
	for sourceName, amount in pairs( CurrentRun.DamageDealtByHeroRecord ) do
		local mappedName = screen.DamageSourceMap[sourceName] or sourceName
		mappedDamageDealtRecord[mappedName] = (mappedDamageDealtRecord[mappedName] or 0) + amount
	end
	for sourceName, amount in pairs( CurrentRun.DamageDealtByCharmedEnemiesRecord ) do
		local mappedName = "RunClearScreen_DamageDealtAllies"
		mappedDamageDealtRecord[mappedName] = (mappedDamageDealtRecord[mappedName] or 0) + amount
	end
	local damageRecordItems = {}
	for sourceName, amount in pairs( mappedDamageDealtRecord ) do
		table.insert( damageRecordItems, { SourceName = sourceName, Amount = amount } )
	end
	table.sort( damageRecordItems, DamageRecordSort )
	for i, damageRecordItem in ipairs( damageRecordItems ) do
		if i > screen.MaxDamageDealtItems then
			break
		end

		local damageSourceComponent = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Text", X = damageLocationX, Y = damageLocationY })
		damageSourceComponent.Data = screen.DamageSourceFormat
		screen.Components["DamageDealtSource"..damageRecordItem.SourceName] = damageSourceComponent
		local damageSourceFormat = ApplyLocalizedProperties( ShallowCopyTable( screen.DamageSourceFormat ) )
		damageSourceFormat.Id = damageSourceComponent.Id
		damageSourceFormat.Text = screen.DamageSourceTextOverrides[damageRecordItem.SourceName] or damageRecordItem.SourceName
		CreateTextBox( damageSourceFormat )

		local damageAmountComponent = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Text", X = damageLocationX + screen.DamageDealtAmountOffsetX, Y = damageLocationY })
		damageAmountComponent.Data = screen.DamageAmountFormat
		screen.Components["DamageDealtAmount"..damageRecordItem.SourceName] = damageAmountComponent
		local damageAmountFormat = ShallowCopyTable( screen.DamageAmountFormat )
		damageAmountFormat.Id = damageAmountComponent.Id
		damageAmountFormat.Text = "{$TempTextData.DamageRecordAmount:N}"
		damageAmountFormat.LuaKey = "TempTextData"
		damageAmountFormat.LuaValue = { DamageRecordAmount = round(damageRecordItem.Amount) }
		CreateTextBox( damageAmountFormat )

		damageLocationY = damageLocationY + screen.DamageDealtSpacingY

		wait(0.05)
	end

	-- Damage Taken
	--SetAlpha({ Id = components.ShrinePointsLabel.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 1.0 })
	--SetAlpha({ Id = components.ShrinePointsValue.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 1.0 })
	damageLocationX = screen.DamageDealtStartX
	damageLocationY = screen.DamageTakenStartY
	local mappedDamageTakenRecord = {}
	for sourceName, amount in pairs( CurrentRun.DamageTakenFromRecord ) do
		if EnemyData[sourceName] ~= nil then
			sourceName = GetGenusName(EnemyData[sourceName])
		end
		local mappedName = screen.DamageSourceMap[sourceName] or sourceName
		mappedDamageTakenRecord[mappedName] = (mappedDamageTakenRecord[mappedName] or 0) + amount
	end
	damageRecordItems = {}
	for sourceName, amount in pairs( mappedDamageTakenRecord ) do
		table.insert( damageRecordItems, { SourceName = sourceName, Amount = amount } )
	end
	table.sort( damageRecordItems, DamageRecordSort )
	for i, damageRecordItem in ipairs( damageRecordItems ) do
		if i > screen.MaxDamageDealtItems then
			break
		end

		local damageSourceComponent = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Text", X = damageLocationX, Y = damageLocationY })
		damageSourceComponent.Data = screen.DamageSourceFormat
		screen.Components["DamageTakenSource"..damageRecordItem.SourceName] = damageSourceComponent
		local damageSourceFormat = ApplyLocalizedProperties( ShallowCopyTable( screen.DamageSourceFormat ) )
		damageSourceFormat.Id = damageSourceComponent.Id
		damageSourceFormat.Text = screen.DamageSourceTextOverrides[damageRecordItem.SourceName] or damageRecordItem.SourceName
		CreateTextBox( damageSourceFormat )

		local damageAmountComponent = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Text", X = damageLocationX + screen.DamageDealtAmountOffsetX, Y = damageLocationY })
		damageAmountComponent.Data = screen.DamageAmountFormat
		screen.Components["DamageTakenAmount"..damageRecordItem.SourceName] = damageAmountComponent
		local damageAmountFormat = ShallowCopyTable( screen.DamageAmountFormat )
		damageAmountFormat.Id = damageAmountComponent.Id
		damageAmountFormat.Text = round(damageRecordItem.Amount)
		CreateTextBox( damageAmountFormat )

		damageLocationY = damageLocationY + screen.DamageDealtSpacingY

		wait(0.05)
	end

	wait(0.05)

	-- Clear Message
	local message = nil
	if CurrentRun.ActiveBounty then
		message = CurrentRun.ActiveBounty
	else
		local messageData = GetRandomEligiblePrioritizedItem( GameData.RunClearMessageData, screen.MessagePriorities, GameState.PlayedRunClearMessages, GameState.RemainingRunClearMessages )
		if messageData ~= nil then
			message = messageData.Name
			GameState.PlayedRunClearMessages[message] = true
			CurrentRun.VictoryMessage = message
		end
	end
	RunClearMessagePresentation( screen, message )

	killTaggedThreads( CombatUI.HideThreadName )
	RemoveInputBlock({ Name = "OpenRunClearScreen" })

	thread( HandleScreenInput, traitTrayScreen )
	SetAlpha({ Id = components.CloseButton.Id, Duration = HUDScreen.FadeInDuration, Fraction = 1.0 })
	SetAlpha({ Id = traitTrayScreen.Components.ScrollLeft.Id, Duration = HUDScreen.FadeInDuration, Fraction = 1.0 })
	SetAlpha({ Id = traitTrayScreen.Components.ScrollRight.Id, Duration = HUDScreen.FadeInDuration, Fraction = 1.0 })
	HandleScreenInput( screen )

end

function CloseRunClearScreen( screen )
	AddInputBlock({ Name = "CloseRunClearScreen" })
	TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	AltAspectRatioFramesHide()
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ) )
	ShowMoneyUI()
	ShowRerollUI()
	ShowResourceUIs()
	SetConfigOption({ Name = "ShowGameplayTimer", Value = SessionMapState.PrevShowGameplayTimer  })
	SetConfigOption({ Name = "TooltipShowDelay", Value = "Default" })
	RemoveInputBlock({ Name = "CloseRunClearScreen" })
	OnScreenCloseFinished( screen )
end

function DamageRecordSort( itemA, itemB )
	return itemA.Amount > itemB.Amount
end

function ClearedBossEncountersWithNoDamage( source, args )
	for i, encounter in ipairs( args.Encounters ) do
		if CurrentRun.EncounterClearStats[encounter] ~= nil and CurrentRun.EncounterClearStats[encounter].TookDamage then
			return false
		end
	end
	return true
end