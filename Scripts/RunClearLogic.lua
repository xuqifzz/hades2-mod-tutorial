function OpenRunClearScreen()

	AddInputBlock({ Name = "OpenRunClearScreen" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })

	RecordRunCleared()

	thread( PlayVoiceLines, HeroVoiceLines.RunClearedVoiceLines )

	local screen = DeepCopyTable( ScreenData.RunClear )
	screen.DamageDealtStartX = ScreenWidth - screen.DamageDealtRightOffset
	screen.DamageDealtStartY = screen.DamageDealtStartY + ScreenCenterNativeOffsetY
	screen.DamageTakenStartY = screen.DamageTakenStartY + ScreenCenterNativeOffsetY

	local args = {}
	HideMoneyUI( args )
	HideRerollUI( args )
	HideResourceUIs( args )

	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	OnScreenOpened( screen )
	
	local traitTrayScreen = OpenTraitTrayScreen( { DontDuckAudio = true, DisableTooltips = true, HideCloseButton = true, HideInfoButton = true, AutoPin = true, SkipInputHandlers = true, OverwriteSelf = { IgnoreOtherScreenInput = false, }, } )

	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelIn" })
	SetConfigOption({ Name = "TooltipShowDelay", Value = 999999 })

	local components = screen.Components
	
	local recordTime = GetFastestRunClearTime( CurrentRun )
	local prevRecordShrinePoints = GetHighestShrinePointRunClear()

	-- ClearTime
	ModifyTextBox({ Id = components.ClearTimeValue.Id, Text = GetTimerString( CurrentRun.GameplayTime, 2 ), })
	if CurrentRun.GameplayTime <= recordTime then
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
	--SetAlpha({ Id = components.ShrinePointsLabel.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 1.0 })
	--SetAlpha({ Id = components.ShrinePointsValue.Id, Duration = HUDScreen.FadeOutDuration, Fraction = 1.0 })
	local damageLocationX = screen.DamageDealtStartX
	local damageLocationY = screen.DamageDealtStartY
	local mappedDamageDealtRecord = {}
	for sourceName, amount in pairs( CurrentRun.DamageDealtRecord ) do
		local mappedName = screen.DamageSourceMap[sourceName] or sourceName
		if WeaponDataEnemies[mappedName] then
			mappedName = "RunClearScreen_DamageDealtAllies"
		end
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
		screen.Components["DamageDealtSource"..damageRecordItem.SourceName] = damageSourceComponent
		local damageSourceFormat = ShallowCopyTable( screen.DamageSourceFormat )
		damageSourceFormat.Id = damageSourceComponent.Id
		damageSourceFormat.Text = screen.DamageSourceTextOverrides[damageRecordItem.SourceName] or damageRecordItem.SourceName
		CreateTextBox( damageSourceFormat )

		local damageAmountComponent = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Text", X = damageLocationX + screen.DamageDealtAmountOffsetX, Y = damageLocationY })
		screen.Components["DamageDealtAmount"..damageRecordItem.SourceName] = damageAmountComponent
		local damageAmountFormat = ShallowCopyTable( screen.DamageAmountFormat )
		damageAmountFormat.Id = damageAmountComponent.Id
		damageAmountFormat.Text = round(damageRecordItem.Amount)
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
		screen.Components["DamageTakenSource"..damageRecordItem.SourceName] = damageSourceComponent
		local damageSourceFormat = ShallowCopyTable( screen.DamageSourceFormat )
		damageSourceFormat.Id = damageSourceComponent.Id
		damageSourceFormat.Text = screen.DamageSourceTextOverrides[damageRecordItem.SourceName] or damageRecordItem.SourceName
		CreateTextBox( damageSourceFormat )

		local damageAmountComponent = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Text", X = damageLocationX + screen.DamageDealtAmountOffsetX, Y = damageLocationY })
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
	local messageData = GetRandomEligiblePrioritizedItem( GameData.RunClearMessageData, screen.MessagePriorities, GameState.PlayedRunClearMessages, GameState.RemainingRunClearMessages )
	if messageData ~= nil then
		CurrentRun.RunClearMessageName = messageData.Name
		RunClearMessagePresentation( screen, messageData )
	end

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
	OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ) )
	ShowMoneyUI()
	ShowRerollUI()
	ShowResourceUIs()
	SetConfigOption({ Name = "TooltipShowDelay", Value = "Default" })
	RemoveInputBlock({ Name = "CloseRunClearScreen" })
	OnScreenCloseFinished( screen )
end

function DamageRecordSort( itemA, itemB )
	return itemA.Amount > itemB.Amount
end