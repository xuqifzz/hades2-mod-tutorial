function MouseOverMusicPlayerItem( button )
	local screen = button.Screen
	if screen.Closing then
		return
	end

	GenericMouseOverPresentation( button )
	
	local components = button.Screen.Components
	screen.SelectedItem = button

	SetAnimation({ DestinationId = button.Id, Name = button.HighlightAnimation })
	PlaySound({ Id = button.Id, Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })

	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		Text = button.Data.Name,
		UseDescription = true,
		FadeTarget = 1.0,
	})
	--[[
	ModifyTextBox({ Id = components.InfoBoxFlavor.Id,
		Text = button.Data.Name.."_Flavor",
		UseDescription = true,
		FadeTarget = 1.0,
	})
	]]--

	if not button.Purchased then
		SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 1.0, Duration = 0.2 })
		AddResourceCostDisplay( button.Screen, button.Data.Cost, button.Screen.CostDisplay, button.Data )
	end

	local newButtonKey = "NewIcon"..button.Index
	SetAlpha({ Id = button.NewButtonId, Fraction = 0, Duration = 0.2 })
	CurrentRun.WorldUpgradesViewed[button.Data.Name] = true
	GameState.WorldUpgradesViewed[button.Data.Name] = true
	
	UpdateMusicPlayerInteractionText( button.Screen, button )
end

function MouseOffMusicPlayerItem( button )
	local screen = button.Screen
	local components = button.Screen.Components
	screen.SelectedItem = nil

	SetAnimation({ DestinationId = button.Id, Name = button.Animation })

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
	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = button.Screen.Components["PurchaseButton".. button.Index].Id, OffsetX = 0 })
end

function MusicPlayerPurchasePreActivatePresentation( screen, button, saleData )

	FreezePlayerUnit( "ActivateCosmeticPresentation" )
	AddInputBlock({ Name = "ActivateCosmeticPresentation" })
	MapState.CosmeticPresentationActive = true

	PanCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 1.0, EaseIn = 0.05, EaseOut = 0.3, Retarget = true, FromCurrentLocation = true })
	FocusCamera({ Fraction = 1.3, Duration = 1.0, ZoomType = "Ease" })

	thread( PlayVoiceLines, saleData.PreRevealVoiceLines or GlobalVoiceLines[saleData.PreRevealGlobalVoiceLines] or GlobalVoiceLines.MusicPlayerGlobalVoiceLines )
	--SetAnimation({ DestinationId = focusId, Name = "Bard_Begin_Song" })

	wait( 0.5 )
	
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
	
	if button ~= nil and button.Data ~= nil then

		if button.Purchased or ( button.Data.Cost ~= nil and HasResources( button.Data.Cost ) ) then
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
			if button.Purchased then
				if GameState.MusicPlayerSongName == button.Data.Name then
					ModifyTextBox({ Id = components.SelectButton.Id, Text = "Menu_MusicPlayerPause"})
				else
					ModifyTextBox({ Id = components.SelectButton.Id, Text = "Menu_MusicPlayerPlay"})
				end
			else
				ModifyTextBox({ Id = components.SelectButton.Id, Text = "Menu_MusicPlayerPurchase"})
			end
		else
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		end

		if not button.Purchased and GameState.WorldUpgrades.WorldUpgradePinning then
			SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
		end

	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
end

function MusicPlayerPlaySongPresentation( source, button )
	if button ~= nil then
		PlaySound({ Name = "/Leftovers/SFX/LightOn", Id = button.Id })
	end
	StopAnimation({ Name = "StatusSinging", DestinationId = source.ObjectId })
	CreateAnimation({ Name = "StatusSinging", DestinationId = source.ObjectId, OffsetX = -80, OffsetY = -120, })
end

function MusicPlayerStopSongPresentation( source, button )
	if button ~= nil then
		PlaySound({ Name = "/Leftovers/SFX/GeneralWhooshReverse2", Id = button.Id })
	end
	StopAnimation({ Name = "StatusSinging", DestinationId = source.ObjectId })
end
