function InventoryScreenOpenPresentation( screen )

	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract" })

	thread( PlayVoiceLines, GlobalVoiceLines.InventoryOpenedVoiceLines )

end

function InventoryScreenClosePresentation( screen, button )

	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract" })

end

function InventoryScreenChangeCategoryPresentation( screen, categoryIndex )

	--PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })

end

function MouseOverResourceItem( button )

	local screen = button.Screen
	if screen.Closing then
		return
	end

	GenericMouseOverPresentation( button )

	local components = screen.Components

	if button.ResourceData ~= nil and
		( (GameState.LifetimeResourcesGained[button.ResourceData.Name] or 0) > 0 or
		( button.ResourceData.RevealGameStateRequirements ~= nil and IsGameStateEligible( CurrentRun, button.ResourceData, button.ResourceData.RevealGameStateRequirements ) ) ) then

		local buttonHighlight = CreateScreenComponent({ Name = "InventorySlotHighlight", Scale = 1.0, Group = "Combat_Menu_Overlay", DestinationId = button.Id })
		components.InventorySlotHighlight = buttonHighlight
		button.HighlightId = buttonHighlight.Id
		Attach({ Id = buttonHighlight.Id, DestinationId = button.Id })
		ModifyTextBox({ Id = components.InfoBoxName.Id,
			Text = button.MouseOverText or button.ResourceData.Name,
			UseDescription = false,
			FadeTarget = 1.0,
		})
		ModifyTextBox({ Id = components.InfoBoxDescription.Id,
			Text = button.MouseOverText or button.ResourceData.Name,
			UseDescription = true,
			FadeTarget = 1.0,
		})
		if button.MouseOverText == nil then
			ModifyTextBox({ Id = components.InfoBoxDetails.Id,
				Text = button.ResourceData.Name.."_Details",
				UseDescription = true,
				FadeTarget = 1.0,
			})
			if button.ResourceData.ExtraDescriptions ~= nil then
				for i, extraDescription in ipairs( button.ResourceData.ExtraDescriptions ) do
					if extraDescription.Requirements == nil or IsGameStateEligible( CurrentRun, button.ResourceData, extraDescription.Requirements ) then
						ModifyTextBox({ Id = components.InfoBoxDetails.Id,
							Text = extraDescription.TextId,
							UseDescription = true,
							Append = true,
							NumLineBreaks = 2,
							FadeTarget = 1.0,
						})
					else
						ModifyTextBox({ Id = components.InfoBoxDetails.Id,
							Text = "InventoryScreen_UnknownDetails",
							Append = true,
							NumLineBreaks = 2,
							FadeTarget = 1.0,
						})
					end
				end
			end
			ModifyTextBox({ Id = components.InfoBoxFlavor.Id,
				Text = button.ResourceData.Name.."_Flavor",
				UseDescription = true,
				FadeTarget = 1.0,
			})
		else
			ModifyTextBox({ Id = components.InfoBoxDetails.Id, FadeTarget = 0.0, })
			ModifyTextBox({ Id = components.InfoBoxFlavor.Id, FadeTarget = 0.0, })
		end
	else
		ModifyTextBox({ Id = components.InfoBoxName.Id,
			Text = button.MouseOverText or "InventoryScreen_ResourceNotFound",
			UseDescription = false,
			FadeTarget = 1.0,
		})
		ModifyTextBox({ Id = components.InfoBoxDescription.Id,
			Text = button.MouseOverText or "InventoryScreen_ResourceNotFound",
			UseDescription = true,
			FadeTarget = 1.0,
		})
		ModifyTextBox({ Id = components.InfoBoxDetails.Id, FadeTarget = 0.0, })
		ModifyTextBox({ Id = components.InfoBoxFlavor.Id, FadeTarget = 0.0, })
	end

	if button.ResourceData.InventoryVoiceLines then
		thread( PlayVoiceLines, button.ResourceData.InventoryVoiceLines )
	end

	SetScale({ Id = button.Id, Fraction = (button.ResourceData.IconScale or 1.0) * screen.IconMouseOverScale, Duration = 0.1, EaseIn = 0.9, EaseOut = 1.0, SkipGeometryUpdate = true })
	--StopFlashing({ Id = button.Id })
	UpdateResourceInteractionText( screen, button )
end

function MouseOffResourceItem( button )
	Destroy({ Id = button.HighlightId })
	local components = button.Screen.Components
	components.InventorySlotHighlight = nil
	ModifyTextBox({ Id = components.InfoBoxName.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxDetails.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxFlavor.Id, FadeTarget = 0.0, })
	SetScale({ Id = button.Id, Fraction = button.ResourceData.IconScale or 1.0, Duration = 0.1, SkipGeometryUpdate = true })
	StopFlashing({ Id = button.Id })
	UpdateResourceInteractionText( button.Screen )
end

function UpdateResourceInteractionText( screen, button )

	local components = screen.Components
	
	if button ~= nil and button.ContextualAction ~= nil then
		ModifyTextBox({ Id = components.SelectButton.Id, Text = button.ContextualAction })
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

	if button ~= nil and button.ContextualAction ~= nil then
		ModifyTextBox({ Id = components.SelectButton.Id, Text = button.ContextualAction })
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
	
	if screen.NumCategories >= 2 then
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 1.0, Duration = 0.0 })
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 1.0, Duration = 0.0 })
	else
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 0.0, Duration = 0.0 })
	end	
	
end

function InventoryScreenMouseOverPin( button )
	local screen = button.Screen
	if screen.Closing then
		return
	end

	local components = screen.Components
	screen.SelectedPin = button
	SetAnimation({ Name = "GUI\\Screens\\Inventory\\ForgetMeNotButtonHighlight", DestinationId = button.Id })
	SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
	local itemData = button.ItemData
	local costDisplay = ShallowCopyTable( screen.CostDisplay )
	costDisplay.StartX = costDisplay.StartX + ScreenCenterNativeOffsetX
	AddResourceCostDisplay( screen, itemData.ResourceCost or itemData.Cost, costDisplay, itemData )
end

function InventoryScreenMouseOffPin( button )
	local screen = button.Screen
	local components = screen.Components
	screen.SelectedPin = nil
	SetAnimation({ Name = button.Animation, DestinationId = button.Id })
	SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })

	--[[
	for resourceNum = 1, TableLength( itemData.ResourceCost or itemData.Cost ) do
		local backingKey = "ResourceIconBacking"..itemNum..resourceNum
		local resourceBacking = screen.Components[backingKey]
		local iconKey = "ResourceIcon"..itemNum..resourceNum
		local resourceIcon = screen.Components[iconKey]
		--Teleport({ Id = buttonBacking.Id, OffsetX = screen.PinStartX, OffsetY = screen.PinStartY + ((visibleIndex - 1) * screen.PinSpacingY) })
		table.insert( onIds, resourceBacking.Id )
		--Teleport({ Id = icon.Id, OffsetX = screen.PinStartX + screen.PinIconOffsetX, OffsetY = screen.PinStartY + ((visibleIndex - 1) * screen.PinSpacingY) })
		table.insert( onIds, resourceIcon.Id )
	end
	]]

end

function MoneyLossPresentation(amount, delta)
	MoneyGainPresentation( amount, delta )
end

function MoneyGainPresentation(amount, delta)
	if not ShowingCombatUI then
		return
	end

	local text = "MoneyAmount"
	local color = Color.White
	local lightColor = Color.LightGold
	if MapState.MoneyUI.Floating < 0 then
		text = "NegativeMoneyAmount"
		lightColor = Color.CostUnaffordableLight
	end
	local floatingMoney = MapState.MoneyUI.Floating

	-- Color
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, ScaleTarget = 1.2, ScaleDuration = 0.0, AutoSetDataProperties = false, })
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, Color = lightColor, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0, AutoSetDataProperties = false, })
	waitUnmodified(0.05)
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, ScaleTarget = 1.0, ScaleDuration = 1.0, Delay = 0.75, AutoSetDataProperties = false, })
	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, ColorTarget = color, ColorDuration = 0.1, Delay = 0.65, AutoSetDataProperties = false, })

	-- Pulses the money text

	waitUnmodified(0.06)
	if not ShowingCombatUI then
		return
	end

	ModifyTextBox({ Id = HUDScreen.Components.MoneyIcon.Id, ColorTarget = Color.White, ColorDuration = 2.0, AutoSetDataProperties = false, })

	local digitSpacer = string.len( GetResourceAmount( "Money" ) ) * MoneyUI.DigitSpacer
	if ScreenAnchors.MoneyDelta ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.MoneyDelta, Text = text, LuaKey = "TempTextData", LuaValue = { Amount = floatingMoney }, AutoSetDataProperties = false })
	else
		ScreenAnchors.MoneyDelta = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI",
			X = HUDScreen.Components.MoneyIcon.Data.X + MoneyUI.StartSpacer + digitSpacer,
			Y = HUDScreen.Components.MoneyIcon.Data.Y,
			})
		CreateTextBox({ Id = ScreenAnchors.MoneyDelta, Text = text,
				Font = "NumericP22UndergroundSCMedium", FontSize = 28, ShadowColor = { 0.1, 0.1, 0.1, 1.0 },
				Color = Color.White,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
				ShadowBlur = 0, ShadowOffset = { 0, 4 }, Justification = "Right", TextSymbolScale = 0.5,
				LuaKey = "TempTextData", LuaValue = { Amount = floatingMoney },
				AutoSetDataProperties = false,
				})
	end

	-- Color pulse
	ModifyTextBox({ Id = ScreenAnchors.MoneyDelta, Color = lightColor, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0, AutoSetDataProperties = false, })
	waitUnmodified(0.05)
	ModifyTextBox({ Id = ScreenAnchors.MoneyDelta, ColorTarget = color, ColorDuration = 1.6, Delay = 0.65, AutoSetDataProperties = false, })

	thread(HideMoneyAfterDelay)
end

function HideMoneyAfterDelay()
	MapState.MoneyUI.RunningThreads = MapState.MoneyUI.RunningThreads + 1

	wait(MoneyUI.HideDelay)
	if ScreenAnchors.MoneyDelta ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.MoneyDelta, FadeTarget = 0, FadeDuration = MoneyUI.FadeDuration, AutoSetDataProperties = false, })
	end
	wait(MoneyUI.FadeDuration)

	MapState.MoneyUI.RunningThreads = MapState.MoneyUI.RunningThreads - 1
	if MapState.MoneyUI.RunningThreads == 0 then
		MapState.MoneyUI.Floating = 0
	end
end

function FlyTextToUI( source, args )
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	local startId = args.StartId or CurrentRun.Hero.ObjectId
	local amount = args.Amount
	local text = args.Text

	local randomOffsetX = RandomInt( -10, 10 )
	local randomFontSize = RandomInt( 170, 180 )
	local offsetY = args.OffsetY or 0

	waitUnmodified( args.Delay )
	
	local textAnchorId = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", DestinationId = startId, Group = "Overlay", OffsetX = args.OffsetX, OffsetY = args.AnchorOffsetY or -190, UseScreenLocation = true })
	local textHoldId = SpawnObstacle({ Name = "InvisibleTargetNoTimeModifier", DestinationId = startId, Group = "Overlay", OffsetX = (args.OffsetX or 0) + randomOffsetX, OffsetY = args.HoldOffsetY or -270, UseScreenLocation = true })

	CreateTextBox({
		Id = textAnchorId, Text = text, GroupName = "Overlay",
		Justification = "CENTER",
		ShadowBlur = 0, ShadowColor = {60,100,70,1}, ShadowOffset = {0, 5},
		OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
		Color = args.Color,
		Font = "NumericP22UndergroundSCMedium",
		FontSize = args.FontSize or randomFontSize,
		OffsetY = 20 + offsetY,
		OffsetX = 0,
		Scale = 0.6,
		ScaleTarget = 0.6,
		ScaleWithOwner = true,
		LuaKey = "TempTextData",
		LuaValue = args,
		AutoSetDataProperties = false,
	})

	if not args.SkipShadow then
		SetAnimation({  Name = "InCombatTextShadow_Short", DestinationId = textAnchorId, OffsetY = 10 + offsetY, Scale = args.ShadowScale or 0.6, Group = "Combat_UI_World" })
		SetScaleX({ Id = textAnchorId, Fraction = args.ShadowScaleX or 1.0 })
	end
	waitUnmodified( 0.1 )

	SetColor({ Id = textAnchorId, Color = Color.White, Duration = 0 })
	SetColor({ Id = textAnchorId, Color = color, Duration = 0.4, EaseIn = 0.99, EaseOut = 1.0 })
	Move({ Id = textAnchorId, DestinationId = textHoldId, Speed = 200, EaseIn = 0.99, EaseOut = 1.0, TimeModifierFraction = 0.0 })
	ModifyTextBox({ Id = textAnchorId, ScaleTarget = 0.3, ScaleDuration = 0.2, AutoSetDataProperties = false, })
	waitUnmodified( (args.PopDuration or 0.45) + (args.HoldDuration or 0) )

	local flyDuration = args.FlyDuration or 0.5
	Move({ Id = textAnchorId, DestinationId = args.EndId, OffsetX = args.EndOffsetX, Duration = flyDuration, SmoothStep = true, TimeModifierFraction = 0.0 })
	local fadeWait = 0.2
	waitUnmodified( fadeWait )

	SetScale({ Id = textAnchorId, Fraction = 0.0, Duration = flyDuration - fadeWait, SmoothStep = true })
	waitUnmodified( flyDuration - fadeWait - 0.065 )

	Destroy({ Ids = { textAnchorId, textHoldId } })

	waitUnmodified( 0.065 )

	SetScale({ Id = args.EndId, Fraction = 1.2, Duration = 0.02 })
	Flash({ Id = args.EndId, Speed = 1.5, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.Gold, ExpireAfterCycle = true })
	waitUnmodified( 0.02 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", Id = args.EndId })

	SetScale({ Id = args.EndId, Fraction = 1.0, Duration = 0.35, SmoothStep = true })

	if args.OnEndFunctionName ~= nil then
		CallFunctionName( args.OnEndFunctionName, source, args )
	end

end

function ResourceGainNewTotalPresentation( source, args )

	ScreenState.NewResourceTotalIds = ScreenState.NewResourceTotalIds or {}

	local threadName = "ResourceGainNewTotalPresentationThread"

	if ScreenState.NewResourceTotalIds[args.ResourceName] == nil then
		local numStacks = TableLength( ScreenState.NewResourceTotalIds )
		local offsetY = numStacks * -40
		ScreenState.NewResourceTotalIds[args.ResourceName] = CreateScreenObstacle({ Name = "BlankObstacle", Group = "HUD_Overlay", X = HUDScreen.Components.InventoryIcon.Data.X - 40, Y = HUDScreen.Components.InventoryIcon.Data.Y + offsetY })
		CreateTextBox({
			Id = ScreenState.NewResourceTotalIds[args.ResourceName],
			Text = "NewResourceTotal",
			Justification = "Right",
			ShadowBlur = 0, ShadowColor = {60,100,70,1}, ShadowOffset = {0, 5},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = Color.White,
			Font = "NumericP22UndergroundSCMedium",
			FontSize = 26,
			TextSymbolScale = 0.8,
			LuaKey = "TempTextData",
			LuaValue = args,
			AutoSetDataProperties = false,
			FadeOpacity = 0.0,
			FadeTarget = 1.0,
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		})
	else
		ModifyTextBox({ Id = ScreenState.NewResourceTotalIds[args.ResourceName], Text = "NewResourceTotal", LuaKey = "TempTextData", LuaValue = args })
	end

	local allIds = GetAllValues( ScreenState.NewResourceTotalIds )
	SetAlpha({ Ids = allIds, Fraction = 1.0, Duration = 0.25 })
	local holdDuration = 1.0
	if SetThreadWait( threadName, holdDuration ) then
		return
	end
	waitUnmodified( holdDuration, threadName )

	if CurrentHubRoom ~= nil and CurrentHubRoom.BlockCombatUI then
		SetAlpha({ Id = HUDScreen.Components.InventoryIcon.Id, Fraction = 0.0, Duration = HUDScreen.FadeOutDuration })
	end

	allIds = GetAllValues( ScreenState.NewResourceTotalIds )
	SetAlpha({ Ids = allIds, Fraction = 0.0, Duration = 0.3 })
	waitUnmodified( 0.3, threadName )

	allIds = GetAllValues( ScreenState.NewResourceTotalIds )
	Destroy({ Ids = allIds })
	ScreenState.NewResourceTotalIds = {}

end

function ResourceGainPresentation( resourceName, delta, args )

	args = args or {}

	wait( args.PresentationDelay )

	local resourceData = ResourceData[resourceName]

	if not args.SkipOverheadText and not resourceData.SkipFlyToInventory then
		SetAlpha({ Id = HUDScreen.Components.InventoryIcon.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = HUDScreen.FadeInDuration })
		thread( FlyTextToUI,
			nil,
			MergeTables(
			{
				Amount = delta,
				Text = resourceData.GainedText or "GainGenericResource",
				Color = resourceData.Color or Color.White,
				IconPath = resourceData.TextIconPath or resourceData.IconPath,				
				EndId = HUDScreen.Components.InventoryIcon.Id,
				ResourceName = resourceName,
				NewTotal = GameState.Resources[resourceName] or 0,
				OnEndFunctionName = "ResourceGainNewTotalPresentation",
			}, args )
		)
	end

	if ScreenAnchors.ResourceAnchorIds[resourceName] == nil then
		return
	end
	if not ScreenAnchors.ResourceShowing[resourceName] then
		return
	end

	local text = "GainGenericResource"
	local color = Color.Orange
	local lightColor = Color.LightGold
	if not ScreenPresentationData.ResourceFloating[resourceName] then
		ScreenPresentationData.ResourceFloating[resourceName] = 0
	end

	ScreenPresentationData.ResourceFloating[resourceName] = ScreenPresentationData.ResourceFloating[resourceName] + delta

	if ScreenPresentationData.ResourceFloating[resourceName] < 0 then
		text = "SpendGenericResource"
		color = Color.CostUnaffordableLight
		lightColor = Color.CostUnaffordableLight
	end
	local floatingMoney = ScreenPresentationData.ResourceFloating[resourceName]

	-- Color
	ModifyTextBox({ Id = ScreenAnchors.ResourceAnchorIds[resourceName], ScaleTarget = 1.8, ScaleDuration = 0.0, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0 })
	waitUnmodified(0.05)
	ModifyTextBox({ Id = ScreenAnchors.ResourceAnchorIds[resourceName], ScaleTarget = 1.0, ScaleDuration = 2, ColorTarget = color, ColorDuration = 0.1, AutoSetDataProperties = false, })

	if delta > 0 then
		CreateAnimation({ Name = "ResourceGainedHighlight", DestinationId = ScreenAnchors.ResourceAnchorIds[resourceName] })
	end

	waitUnmodified(0.06)
	if not ShowingCombatUI then
		return
	end
	ModifyTextBox({ Id = ScreenAnchors.ResourceAnchorIds[resourceName], ColorTarget = Color.White, ColorDuration = 2.0, AutoSetDataProperties = false, })
	local currentAmount = GameState.Resources[resourceName] or 0
	local digitSpacer = string.len(currentAmount) * MoneyUI.DigitSpacer

	if ScreenAnchors.ResourceDeltaIds[resourceName] ~= nil then
		Attach({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], DestinationId = ScreenAnchors.ResourceAnchorIds[resourceName], OffsetX = MoneyUI.StartSpacer + digitSpacer, OffsetY = 0 })
		ModifyTextBox({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], Text = text, LuaKey = "TempTextData", LuaValue = { Amount = math.abs( floatingMoney ) }, AutoSetDataProperties = false })
	else
		ScreenAnchors.ResourceDeltaIds[resourceName] = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI" })
		Attach({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], DestinationId = ScreenAnchors.ResourceAnchorIds[resourceName], OffsetX = MoneyUI.StartSpacer + digitSpacer, OffsetY = 0 })

		CreateTextBox({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], Text = text,
				Font = "P22UndergroundSCMedium", FontSize = 28, ShadowColor = { 0.1, 0.1, 0.1, 1.0 },
				Color = Color.White,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
				ShadowBlur = 0, ShadowOffset = { 0, 4 }, Justification = "Right", TextSymbolScale = 0.5,
				LuaKey = "TempTextData", LuaValue = { Amount = math.abs( floatingMoney ) },
				AutoSetDataProperties = false,
				})
	end

	-- Color pulse
	ModifyTextBox({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], Color = lightColor, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0, AutoSetDataProperties = false, })
	waitUnmodified(0.05)
	ModifyTextBox({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], ColorTarget = Color.White, ColorDuration = 1.6, AutoSetDataProperties = false, })

	thread( HideResourceAfterDelay, resourceName )
end

function ResourceSpendPresentation( resourceName, delta, args )

	args = args or {}
	if args.Silent then
		return
	end

	local resourceData = ResourceData[resourceName]
	if not args.SkipOverheadText then
		local text = resourceData.SpendText or "SpendGenericResource"
		local color = resourceData.Color or Color.White
		local stackDisplay = args.StackDisplay or false
		local randomOffsetX = args.NoRandomOffset or true

		thread( PopOverheadText, 
			{ 
				Amount = delta, 
				Text = text, 
				Color = color, 
				IconPath = resourceData.TextIconPath or resourceData.IconPath,
				Delay = args.Delay, 
				TargetId = args.TargetId, 
				HoldDuration = args.HoldDuration, 
				OffsetY = args.OffsetY,
				TextOffsetY = args.TextOffsetY,
				NoRandomOffset = randomOffsetX,
				StackDisplay = stackDisplay,
				ShadowAnimName = args.ShadowAnimName or "InCombatTextShadow_ResourceBacking",
			})
	end
end

function HideResourceAfterDelay( resourceName )
	ScreenPresentationData.ResourceRunningThreads[resourceName] = ScreenPresentationData.ResourceRunningThreads[resourceName] or 0
	ScreenPresentationData.ResourceRunningThreads[resourceName] = ScreenPresentationData.ResourceRunningThreads[resourceName] + 1

	wait(MoneyUI.HideDelay, RoomThreadName )
	if ScreenAnchors.ResourceDeltaIds[resourceName] ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], FadeTarget = 0, FadeDuration = MoneyUI.FadeDuration, AutoSetDataProperties = false, })
	end
	wait(MoneyUI.FadeDuration, RoomThreadName )

	ScreenPresentationData.ResourceRunningThreads[resourceName] = ScreenPresentationData.ResourceRunningThreads[resourceName] - 1
	if ScreenPresentationData.ResourceRunningThreads[resourceName] == 0 then
		ScreenPresentationData.ResourceFloating[resourceName] = 0
	end
end

function UnviewedLastResourceGainedPresentation( screen, button )
	Flash({ Id = button.Id, Speed = 1.0, MinFraction = 0.3, MaxFraction = 0.8, Color = Color.White })
end

function RoomRewardPreSpawnPresentation( source, args )
	if CurrentRun.CurrentRoom.SpawnRewardGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[CurrentRun.CurrentRoom.SpawnRewardGlobalVoiceLines], true )
	end
end

function LootSpawnPresentation( loot, args )
	if not args.SuppressSpawnSounds then
		PlaySound({ Name = loot.SpawnSound or "/Leftovers/SFX/AnnouncementPing4", Id = loot.ObjectId })
	end
end

function RoomRewardSpawnPresentation( reward, args )

	if reward.FirstSpawnVoiceLines ~= nil and (GameState.UseRecord[reward.Name] or 0) <= 0 then
		thread( PlayVoiceLines, reward.FirstSpawnVoiceLines, true )
	else
		local roomData = RoomData[CurrentRun.CurrentRoom.Name]
		if roomData.RewardSpawnVoiceLines ~= nil then
			thread( PlayVoiceLines, roomData.RewardSpawnVoiceLines, true )
		end
		local encounterData = EncounterData[CurrentRun.CurrentRoom.Encounter.Name] or CurrentRun.CurrentRoom.Encounter
		if encounterData.RewardSpawnVoiceLines ~= nil then
			thread( PlayVoiceLines, encounterData.RewardSpawnVoiceLines, true )
		end
		if args.GenericReward then
			thread( PlayRandomEligibleVoiceLines, { reward.OnSpawnVoiceLines, GlobalVoiceLines.MiscRewardGrantedVoiceLines }, true )
		else
			thread( PlayRandomEligibleVoiceLines, { reward.OnSpawnVoiceLines, GlobalVoiceLines.GenericLootGrantedVoiceLines }, true )
		end
	end
	
end

function AddStoreItemPinPresentation( selectedItem, args )
	args = args or {}
	selectedItem.IsPinned = true
	local animationName = args.AnimationName or "StoreItemPin"
	SetAnimation({ Name = animationName, DestinationId = selectedItem.PinButtonId })
	SetAlpha({ Id = selectedItem.PinButtonId, Fraction = 1.0, Duration = 0.2 })
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonPin", Id = selectedItem.PinButtonId })

	if not args.SkipVoice then
		thread( PlayVoiceLines, GlobalVoiceLines.PinnedItemVoiceLines, true )
	end

	-- Silent toolip if it wasn't already added
	CreateTextBox({ Id = selectedItem.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
end

function RemoveStoreItemPinPresentation( selectedItem )
	selectedItem.IsPinned = false
	SetAlpha({ Id = selectedItem.PinButtonId, Fraction = 0.0, Duration = 0.2 })
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonUnpin", Id = selectedItem.PinButtonId })
	DestroyTextBox({ Id = selectedItem.Id, AffectText = "StoreItemPinTooltip", RemoveTooltips = true })
end