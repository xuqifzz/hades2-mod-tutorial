function MouseOverMusicPlayerItem( button )
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

	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({
		Id = components.InfoBoxDescription.Id,
		Text = button.Data.Name,
		UseDescription = true,
		FadeTarget = 1.0,
	})

	if not button.Purchased then
		SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 1.0, Duration = 0.2 })
		AddResourceCostDisplay( button.Screen, button.Data.Cost, button.Screen.CostDisplay, button.Data )
	end

	SetAlpha({ Id = button.NewIconId, Fraction = 0, Duration = 0.2 })
	CurrentRun.WorldUpgradesViewed[button.Data.Name] = true
	GameState.WorldUpgradesViewed[button.Data.Name] = true
	
	UpdateMusicPlayerInteractionText( button.Screen, button )
end

function MouseOffMusicPlayerItem( button )

	local screen = button.Screen
	local components = button.Screen.Components

	SetAnimation({ DestinationId = button.Id, Name = button.NeutralAnimation })
	screen.SelectedItem = nil

	SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 0.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id, FadeTarget = 0.0, })
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })
	Destroy({ Ids = screen.CostIds })
	screen.CostIds = nil

	UpdateMusicPlayerInteractionText( button.Screen )
end

function MusicPlayerItemPurchasedPresentation( button )
	PlaySound({ Name = "/SFX/Menu Sounds/ContractorItemPurchase" })
	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = button.Id, OffsetX = 0 })
end

function MusicPlayerPurchasePreActivatePresentation( screen, button, saleData )

	FreezePlayerUnit( "ActivateCosmeticPresentation" )
	AddInputBlock({ Name = "ActivateCosmeticPresentation" })
	MapState.CosmeticPresentationActive = true

	PanCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 1.0, EaseIn = 0.03, EaseOut = 0.03, Retarget = true, FromCurrentLocation = true })
	FocusCamera({ Fraction = 1.3, Duration = 1.0, ZoomType = "Ease" })

	local artemisAlreadySuppressed = ( CurrentRun.SuppressAmbientMusic == "Artemis" )
	thread( PlayVoiceLines, saleData.PreRevealVoiceLines or GlobalVoiceLines.MusicPlayerGlobalVoiceLines, nil, nil, { PurchasingSong = true, ArtemisAlreadySuppressed = artemisAlreadySuppressed } )

	for i, resourceName in ipairs( ResourceDisplayOrderData ) do
		if saleData.Cost[resourceName] then
			SpendResource( resourceName, saleData.Cost[resourceName], saleData.Name, { TextOffsetY = screen.ResourceSpendTextOffsetY } )
			PlaySound({ Name = "/SFX/CauldronIngredientSizzle", Id = CurrentRun.Hero.ObjectId })
			wait( 0.6 )
		end
	end
	
end

function MusicPlayerPurchasePostActivatePresentation( screen, button, saleData )

	MusicPlayerPlaySongPresentation( screen.OpenedFrom, nil )

	wait( 1.5 )

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	local inputReturnDelay = 0.7
	PanCamera({ Id = screen.OpenedFrom.ObjectId, Duration = inputReturnDelay, Retarget = true })
	FocusCamera({ Fraction = CurrentHubRoom.ZoomFraction, Duration = 0.3, ZoomType = "Ease" })
	wait( inputReturnDelay * 0.5 )

	UnfreezePlayerUnit( "ActivateCosmeticPresentation" )
	RemoveInputBlock({ Name = "ActivateCosmeticPresentation" })
	MapState.CosmeticPresentationActive = false

end

function UpdateMusicPlayerInteractionText( screen, button )

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
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		if GameState.MusicPlayerSongName == button.Data.Name then
			ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.AltTexts[1] })
		else
			ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.AltTexts[2] })
		end
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

end

function MusicPlayerPlaySongPresentation( source, button )
	if button ~= nil then
		PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = button.Id })
	end

	StopAnimation({ Name = "StatusSingingMusicPlayer", DestinationId = source.ObjectId })
	CreateAnimation({ Name = "StatusSingingMusicPlayer", DestinationId = source.ObjectId, OffsetX = -80, OffsetY = -120, })

	local songData = WorldUpgradeData[GameState.MusicPlayerSongName]
	if songData ~= nil then
		if songData.Rocking then
			SetAnimation({ DestinationId = source.ObjectId, Name = "ShadeBard_Rocking_Start" })
		else
			SetAnimation({ DestinationId = source.ObjectId, Name = "ShadeBard_Playing_Start" })
		end
	end
end

function MusicPlayerStopSongPresentation( source, button )
	if button ~= nil then
		PlaySound({ Name = "/Leftovers/SFX/GeneralWhooshReverse2", Id = button.Id })
	end
	StopAnimation({ Name = "StatusSingingMusicPlayer", DestinationId = source.ObjectId })

	local songData = WorldUpgradeData[GameState.MusicPlayerSongName]
	if songData ~= nil then
		if songData.Rocking then
			SetAnimation({ DestinationId = source.ObjectId, Name = "ShadeBard_Rocking_End" })
		else
			SetAnimation({ DestinationId = source.ObjectId, Name = "ShadeBard_Playing_End" })
		end
	end
end

function MusicPlayerShufflePresentation( source, button )
	if button ~= nil then
		PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = button.Id })
	end
	CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = button.IconId })
	local artemisAlreadySuppressed = ( CurrentRun.SuppressAmbientMusic == "Artemis" )
	thread( PlayVoiceLines, HeroVoiceLines.PlayRandomMusicVoiceLines, true, nil, { ArtemisAlreadySuppressed = artemisAlreadySuppressed } )
	SetAlpha({ Id = source.Components.ShuffleButton.Id, Fraction = 0.0 })
	SetAlpha({ Id = source.Components.ShuffleButton.Id, Fraction = 1.0, Duration = 1.5, EaseOut = 1.0 })
end
