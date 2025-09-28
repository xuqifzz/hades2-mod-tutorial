function FamiliarCostumeScreenOpenedPresentation( screen, args )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = screen.OpenedFrom.ObjectId })
	SetAnimation({ Name = GetEquippedWeaponValue( "UnequipAnimation" ), DestinationId = CurrentRun.Hero.ObjectId })	
	LockCamera({ Id = screen.OpenedFrom.ObjectId, OffsetX = -200, Duration = 0.42 })
	FocusCamera({ Fraction = 1.05, Duration = 0.42, ZoomType = "Ease" })

	thread( PlayVoiceLines, screen.OpenEndVoiceLines )

end

function FamiliarCostumeScreenCloseStartPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/RunHistoryClose" })
end

function FamiliarCostumeScreenCloseFinishedPresentation( screen, args )
	args = args or {}
	if not args.Purchasing then
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeEquip" })
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.75 })
		FocusCamera({ Fraction = CurrentHubRoom.ZoomFraction, Duration = 0.3 })
	end
end

function MouseOverFamiliarCostumeItem( button )

	local screen = button.Screen
	if screen.Closing then
		return
	end

	GenericMouseOverPresentation( button )

	local components = button.Screen.Components
	screen.SelectedItem = button
	screen.ClipboardText = button.Data.Name

	SetAnimation({ DestinationId = button.Id, Name = button.MouseOverAnimation })
	PlaySound({ Id = button.Id, Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })

	SetAlpha({ Ids = { components.InfoBoxBacking.Id, components.InfoBoxDescription.Id }, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		Text = button.Data.Name,
		UseDescription = true,
	})

	if not button.Purchased then
		SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 1.0, Duration = 0.2 })
		AddResourceCostDisplay( button.Screen, button.Data.Cost, button.Screen.CostDisplay, button.Data )
	end

	SetAlpha({ Id = button.NewIconId, Fraction = 0, Duration = 0.2 })
	CurrentRun.WorldUpgradesViewed[button.Data.Name] = true
	GameState.WorldUpgradesViewed[button.Data.Name] = true
	
	UpdateFamiliarCostumeInteractionText( button.Screen, button )
end

function MouseOffFamiliarCostumeItem( button )

	local screen = button.Screen
	local components = button.Screen.Components

	SetAnimation({ DestinationId = button.Id, Name = button.MouseOffAnimation })
	screen.SelectedItem = nil

	SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 0.0, Duration = 0.1 })
	SetAlpha({ Ids = { components.InfoBoxBacking.Id, components.InfoBoxDescription.Id }, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })
	Destroy({ Ids = screen.CostIds })
	screen.CostIds = nil

	UpdateFamiliarCostumeInteractionText( button.Screen )
end

function UpdateFamiliarCostumeInteractionText( screen, button )

	local components = screen.Components
	
	if button == nil or button.Data == nil then
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	elseif not button.Purchased then
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.Text })
		if GameState.WorldUpgrades.WorldUpgradePinning then
			SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
		end
	else
		if GameState.FamiliarCostumes[screen.OpenedFrom.Name] ~= button.Data.Name then
			ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.AltText })
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

end

function FamiliarCostumePurchasePresentation( screen, button, saleData )

	FreezePlayerUnit( "FamiliarCostumeActivate" )
	AddInputBlock({ Name = "FamiliarCostumeActivate" })
	MapState.CosmeticPresentationActive = true
	local familiar = screen.OpenedFrom

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })
	PanCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 1.0, OffsetX = 0, Retarget = true })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })

	SetAnimation({ Name = "MelTalkExplaining01", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, saleData.PreRevealVoiceLines )

	if not button.Free then
		for i, resourceName in ipairs( ResourceDisplayOrderData ) do
			if saleData.Cost[resourceName] then
				SpendResource( resourceName, saleData.Cost[resourceName], saleData.Name, { TextOffsetY = screen.ResourceSpendTextOffsetY } )
				PlaySound({ Name = "/SFX/CauldronIngredientSizzle", Id = CurrentRun.Hero.ObjectId })
				wait( 0.6 )
			end
		end
	end

	wait( 0.65 )

	CreateAnimation({ Name = "TeleportDisappearFamiliar", DestinationId = familiar.ObjectId, OffsetZ = -50, Scale = familiar.TeleportVfxScale })
	wait( 0.06 )

	PlaySound({ Name = saleData.ItemActivationSound or "/Leftovers/Menu Sounds/EmoteExcitement" })
	PlaySound({ Name = familiar.HappySound or "/EmptyCue", Id = familiar.ObjectId })
	SetupFamiliarCostume( familiar, { Animation = familiar.HappyAnimation } )
	PlaySound({ Name = familiar.HappySound or "/EmptyCue", Id = familiar.ObjectId })
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteAffectionSFX", Id = familiar.ObjectId })

	thread( PlayVoiceLines, saleData.PostRevealVoiceLines )
	SetAnimation({ Name = "MelTalkExplaining01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId })

	wait( 1.2 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeEquip" })
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.75 })
	FocusCamera({ Fraction = CurrentHubRoom.ZoomFraction, Duration = 0.3 })

	RunEventsGeneric( familiar.PostCostumeChangedEvents, familiar )

	wait( 0.5 )

	UnfreezePlayerUnit( "FamiliarCostumeActivate" )
	RemoveInputBlock({ Name = "FamiliarCostumeActivate" })
	MapState.CosmeticPresentationActive = false

end

function FamiliarCostumeReAddPresentation( screen, button, saleData )

	FreezePlayerUnit( "FamiliarCostumeActivate" )
	AddInputBlock({ Name = "FamiliarCostumeActivate" })
	MapState.CosmeticPresentationActive = true
	local familiar = screen.OpenedFrom

	thread( PlayVoiceLines, saleData.SwitchCostumeVoiceLines )

	wait( 0.25 )

	CreateAnimation({ Name = "TeleportDisappearFamiliar", DestinationId = familiar.ObjectId, OffsetZ = -50, Scale = familiar.TeleportVfxScale })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitementShort" })
	
	wait( 0.06 )

	PlaySound({ Name = familiar.HappySound or "/EmptyCue", Id = familiar.ObjectId })
	SetupFamiliarCostume( familiar, { Animation = familiar.HappyAnimation } )

	wait( 0.3 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "MelinoeEquip" })
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.75 })
	FocusCamera({ Fraction = CurrentHubRoom.ZoomFraction, Duration = 0.3 })

	RunEventsGeneric( familiar.PostCostumeChangedEvents, familiar )

	wait( 0.32 )

	UnfreezePlayerUnit( "FamiliarCostumeActivate" )
	RemoveInputBlock({ Name = "FamiliarCostumeActivate" })
	MapState.CosmeticPresentationActive = false

end

function FamiliarCostumeItemPurchasedPresentation( button, upgradeData )
	SetAnimation({ DestinationId = button.Id, Name = "GhostAdminScreenCauldronButtonPurchase" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY" })
end