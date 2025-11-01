function InventoryScreenOpenPresentation( screen )

	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract" })

	thread( PlayVoiceLines, GlobalVoiceLines.InventoryOpenedVoiceLines )

end

function InventoryScreenClosePresentation( screen, button )
	SetAnimation({ DestinationId = screen.Components.Background.Id, Name = screen.CloseAnimation })
	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract" })
end

function InventoryScreenChangeCategoryPresentation( screen, categoryIndex )
	PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuSwitch" })
end

function MouseOverResourceItem( button )

	local screen = button.Screen
	if screen.Closing then
		return
	end

	GenericMouseOverPresentation( button )

	local components = screen.Components

	if button.ResourceData ~= nil and CanShowResourceInInventory( button.ResourceData ) then
		if button.Viewable then
			if button.NewIcon ~= nil then
				Destroy({ Id = button.NewIcon.Id })
			end
			GameState.ResourcesViewed[button.ResourceData.Name] = true
		end

		screen.ClipboardText = button.ResourceData.Name

		SetAnimation({ DestinationId = button.Highlight.Id, Name = "InventoryScreenSlotIn" })
		
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
					if extraDescription.Requirements == nil or IsGameStateEligible( button.ResourceData, extraDescription.Requirements ) then
						ModifyTextBox({ Id = components.InfoBoxDetails.Id,
							Text = extraDescription.TextId,
							UseDescription = true,
							Append = true,
							NumLineBreaks = 2,
							FadeTarget = 1.0,
						})
					elseif not extraDescription.HideIfRequirementsFailed then
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
	if screen.Args.PlantTarget ~= nil and not screen.FirstPinPrompt and not GameState.Flags.HasMultiPlanted and GameState.WorldUpgrades.WorldUpgradeGardenMultiPlant and button.OnPressedFunctionName ~= nil then
		thread( PulseContextActionPresentation, components.PinButton, { ThreadName = "MultiPlantPulse" } )
		screen.FirstPinPrompt = true
	end
	screen.SelectedItem = button
end

function MouseOffResourceItem( button )
	SetAnimation({ DestinationId = button.Highlight.Id, Name = "InventoryScreenSlotOut" })
	local components = button.Screen.Components
	ModifyTextBox({ Id = components.InfoBoxName.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxDetails.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxFlavor.Id, FadeTarget = 0.0, })
	SetScale({ Id = button.Id, Fraction = button.ResourceData.IconScale or 1.0, Duration = 0.1, SkipGeometryUpdate = true })
	StopFlashing({ Id = button.Id })
	UpdateResourceInteractionText( button.Screen )
	button.Screen.SelectedItem = nil
end

function UpdateResourceInteractionText( screen, button )

	local components = screen.Components
	
	if components.SelectButton ~= nil then
		if button ~= nil and button.ContextualAction ~= nil then
			ModifyTextBox({ Id = components.SelectButton.Id, Text = button.ContextualAction })
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
	end

	if components.PinButton ~= nil then
		if button ~= nil and button.PinContextualAction ~= nil then
			ModifyTextBox({ Id = components.PinButton.Id, Text = button.PinContextualAction, LuaKey = "TempTextData", LuaValue = button })
			SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
			components.PinButton.Visible = true
		else
			SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
			components.PinButton.Visible = false
		end
	end
	
	if components.ScrollLeft ~= nil and components.ScrollRight ~= nil then
		if screen.NumCategories >= 2 then
			SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 1.0, Duration = 0.0 })
			SetAlpha({ Id = components.ScrollRight.Id, Fraction = 1.0, Duration = 0.0 })
		else
			SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.0 })
			SetAlpha({ Id = components.ScrollRight.Id, Fraction = 0.0, Duration = 0.0 })
		end
	end
	
end

function InventoryScreenMouseOverPin( button )
	local screen = button.Screen
	if screen.Closing then
		return
	end

	local components = screen.Components
	screen.SelectedPin = button
	SetAnimation({ Name = "InventoryScreenButtonForgetMeNotIn", DestinationId = button.Id })
	SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = button.Id })
	local itemData = button.ItemData
	local costDisplay = ShallowCopyTable( screen.CostDisplay )
	costDisplay.StartX = costDisplay.StartX + ScreenCenterNativeOffsetX

	if TraitData[itemData.Name] ~= nil and WeaponShopItemData[itemData.Name] == nil then
		CreateTraitRequirements( screen, itemData.Name )
	else
		AddResourceCostDisplay( screen, itemData.ResourceCost or itemData.Cost, costDisplay, itemData )
	end
end

function InventoryScreenMouseOffPin( button )
	local screen = button.Screen
	screen.SelectedPin = nil
	SetAnimation({ Name = "InventoryScreenButtonForgetMeNotOut", DestinationId = button.Id })
	SetAlpha({ Id = screen.Components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	Destroy({ Ids = screen.CostIds })
	DestroyTextBox({ Id = screen.Components.RequirementsText.Id })
	Destroy({ Ids = screen.TraitRequirements })
	screen.TraitRequirements = {}
end

function InventoryScreenRemovePinPresentation( screen, button, pinButton )
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonUnpin", Id = pinButton.Id })
	if (screen.NumItems - 1) > screen.ScrollOffset or screen.NumItems == 1 then
		CreateAnimation({ DestinationId = pinButton.Id, Name = "InventoryScreenButtonForgetMeNotRemove" })
	end
end

function MoneyLossPresentation(amount, delta)
	MoneyGainPresentation( amount, delta )
end

function MoneyGainPresentation(amount, delta)
	if not ShowingCombatUI then
		MapState.MoneyUI.Floating = 0
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
			Alpha = ConfigOptionCache.HUDOpacity,
			})
		CreateTextBox({ Id = ScreenAnchors.MoneyDelta, Text = text,
			Font = "NumericP22UndergroundSCMedium", FontSize = 28, ShadowColor = { 0.1, 0.1, 0.1, 1.0 },
			Color = Color.White,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
			ShadowBlur = 0, ShadowOffset = { 0, 4 }, Justification = "Right", TextSymbolScale = 0.5,
			LuaKey = "TempTextData", LuaValue = { Amount = floatingMoney },
			AutoSetDataProperties = false,
			FadeTarget = 0.0, FadeOpacity = 0.0,
			})
	end

	-- Color pulse
	ModifyTextBox({ Id = ScreenAnchors.MoneyDelta, Color = lightColor, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0.1, AutoSetDataProperties = false, })
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

function RerollSpendPresentation( amount )
	if not ShowingCombatUI then
		return
	end

	local rerollIcon = HUDScreen.Components.RerollIcon

	local text = "NegativeMoneyAmount"
	local color = Color.White
	local lightColor = Color.LightGold

	local digitSpacer = MoneyUI.DigitSpacer
	if ScreenAnchors.RerollDelta ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.RerollDelta, Text = text, LuaKey = "TempTextData", LuaValue = { Amount = -amount }, AutoSetDataProperties = false })
	else
		ScreenAnchors.RerollDelta = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI",
			X = rerollIcon.Data.X + MoneyUI.StartSpacer + digitSpacer,
			Y = rerollIcon.Data.Y,
			Alpha = ConfigOptionCache.HUDOpacity,
			})
		CreateTextBox({ Id = ScreenAnchors.RerollDelta,
			Text = text,
			OffsetY = -2,
			Font = "NumericP22UndergroundSCMedium", FontSize = 28, ShadowColor = { 0.1, 0.1, 0.1, 1.0 },
			Color = Color.White,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
			ShadowBlur = 0, ShadowOffset = { 0, 4 }, Justification = "Right", TextSymbolScale = 0.5,
			LuaKey = "TempTextData", LuaValue = { Amount = -amount },
			AutoSetDataProperties = false,
			FadeTarget = 0.0, FadeOpacity = 0.0,
			})
	end

	-- Pulse icon
	ModifyTextBox({ Id = rerollIcon.Id, ScaleTarget = 1.2, ScaleDuration = 0.0, AutoSetDataProperties = false, })
	ModifyTextBox({ Id = rerollIcon.Id, Color = lightColor, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0, AutoSetDataProperties = false, })
	waitUnmodified( 0.05 )
	ModifyTextBox({ Id = rerollIcon.Id, ScaleTarget = 1.0, ScaleDuration = 1.0, Delay = 0.75, AutoSetDataProperties = false, })
	ModifyTextBox({ Id = rerollIcon.Id, ColorTarget = color, ColorDuration = 0.1, Delay = 0.65, AutoSetDataProperties = false, })
	waitUnmodified( 0.06 )
	ModifyTextBox({ Id = rerollIcon.Id, ColorTarget = Color.White, ColorDuration = 2.0, AutoSetDataProperties = false, })

	-- Pulse delta
	ModifyTextBox({ Id = ScreenAnchors.RerollDelta, Color = lightColor, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0.1, AutoSetDataProperties = false, })
	waitUnmodified( 0.05 )
	ModifyTextBox({ Id = ScreenAnchors.RerollDelta, ColorTarget = color, ColorDuration = 1.6, Delay = 0.65, AutoSetDataProperties = false, })
	waitUnmodified( 0.5 )

	-- Fade out delta
	ModifyTextBox({ Id = ScreenAnchors.RerollDelta, FadeTarget = 0, FadeDuration = 0.3, AutoSetDataProperties = false, })

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
		LuaKey = "TempTextData",
		LuaValue = args,
		DataProperties =
		{
			ScaleWithOwner = true,
		},
	})

	if not args.SkipShadow then
		SetAnimation({ Name = "InCombatTextShadow_ResourceGainBacking", DestinationId = textAnchorId, OffsetY = 10 + offsetY, Scale = args.ShadowScale or 0.6 })
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

	if not args.SkipResourceGainSound then
		PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", Id = args.EndId })
	end

	SetScale({ Id = args.EndId, Fraction = 1.0, Duration = 0.35, SmoothStep = true })

	if args.OnEndFunctionName ~= nil then
		CallFunctionName( args.OnEndFunctionName, source, args )
	end

end

function ResourceGainNewTotalPresentation( source, args )

	ScreenState.NewResourceTotalIds = ScreenState.NewResourceTotalIds or {}

	if ScreenState.NewResourceTotalIds[args.ResourceName] == nil then
		local numStacks = TableLength( ScreenState.NewResourceTotalIds )
		if numStacks < 25 then
			local offsetY = numStacks * -40
			ScreenState.NewResourceTotalIds[args.ResourceName] = CreateScreenObstacle({
					Name = "BlankObstacle",
					Group = "HUD_Overlay",
					Alpha = ConfigOptionCache.HUDOpacity,
					X = HUDScreen.Components.InventoryIcon.Data.X - 40,
					Y = HUDScreen.Components.InventoryIcon.Data.Y + offsetY
				})
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
		end
	else
		ModifyTextBox({ Id = ScreenState.NewResourceTotalIds[args.ResourceName], Text = "NewResourceTotal", LuaKey = "TempTextData", LuaValue = args })
	end

	local threadName = "ResourceGainNewTotalPresentationThread"
	killTaggedThreads( threadName )
	waitUnmodified( 0.01 )

	local allIds = GetAllValues( ScreenState.NewResourceTotalIds )
	SetAlpha({ Ids = allIds, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.25 })
	SetAlpha({ Id = HUDScreen.Components.InventoryIcon.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = 0.25 })
	waitUnmodified( 1.0, threadName )

	--if SessionMapState.WeaponsDisabled then
		SetAlpha({ Id = HUDScreen.Components.InventoryIcon.Id, Fraction = 0.0, Duration = HUDScreen.FadeOutDuration })
	--end

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
		local shadowAnimName = args.ShadowAnimName
		if shadowAnimName == nil then
			if delta <= 99 then
				shadowAnimName = "InCombatTextShadow_ResourceSpendBacking"
			else
				shadowAnimName = "InCombatTextShadow_ResourceSpendBackingLong"
			end
		end

		PopOverheadText( {
			Amount = delta,
			Text = text,
			Color = color,
			IconPath = resourceData.TextIconPath or resourceData.IconPath,
			Delay = args.Delay,
			TargetId = args.TargetId,
			HoldDuration = args.HoldDuration,
			FadeOutDuration = args.FadeOutDuration,
			OffsetX = args.OffsetX,
			OffsetY = args.OffsetY,
			TextOffsetY = args.TextOffsetY,
			ShadowAnimName = shadowAnimName,
			UseScreenLocation = args.UseScreenLocation,
			TextAnchorOffsetY = args.TextAnchorOffsetY,
		} )
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

	if not args.SkipTooltip then
		-- Silent toolip if it wasn't already added
		CreateTextBox({ Id = selectedItem.Id, TextSymbolScale = 0, Text = args.Text or "StoreItemPinTooltip", Color = Color.Transparent, })
	end
end

function RemoveStoreItemPinPresentation( selectedItem, args )
	args = args or {}
	selectedItem.IsPinned = false
	SetAlpha({ Id = selectedItem.PinButtonId, Fraction = 0.0, Duration = 0.2 })
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonUnpin", Id = selectedItem.PinButtonId })
	DestroyTextBox({ Id = selectedItem.Id, AffectText = args.Text or "StoreItemPinTooltip", RemoveTooltips = true })
end