function UseMusicPlayerScreenObject( usee, args )
	thread( PlayInteractAnimation, usee.ObjectId, { Animation = "MelTalkBrooding01" } )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenMusicPlayerScreen( usee )
	UseableOn({ Id = usee.ObjectId })
end

function OpenMusicPlayerScreen( openedFrom, args )

	args = args or {}

	AltAspectRatioFramesShow()

	AddInputBlock({ Name = "OpenMusicPlayerScreen" })
	local screen = DeepCopyTable( ScreenData.MusicPlayer )
	screen.OpenedFrom = openedFrom

	if IsScreenOpen( screen.Name ) then
		return
	end

	ZeroMouseTether( screen.Name )
	LockCamera({ Id = screen.OpenedFrom.ObjectId, Duration = 0.7, OffsetX = screen.CameraOffetX, OffsetY = screen.CameraOffetY, EaseIn = 0, EaseOut = 1.0 })
	HideCombatUI( screen.Name )
	if not args.SkipInitialDelay then
		wait( 0.35 )
	end

	OnScreenOpened( screen )
	CreateScreenFromData( screen, screen.ComponentData )
	
	screen.ItemStartX = screen.ItemStartX + ScreenCenterNativeOffsetX
	screen.ItemStartY = screen.ItemStartY + ScreenCenterNativeOffsetY
	screen.CostDisplay.StartX = screen.CostDisplay.StartX + ScreenCenterNativeOffsetX
	screen.CostDisplay.StartY = screen.CostDisplay.StartY + ScreenCenterNativeOffsetY
	if args.InitialScrollOffset ~= nil then
		screen.ScrollOffset = args.InitialScrollOffset
	end

	MusicPlayerDisplayItems( screen )
	GhostAdminUpdateVisibility( screen )

	UpdateMusicPlayerInteractionText( screen )
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "OpenMusicPlayerScreen" })

	thread( GenericScreenOpenEndPresentation, screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen

end

function MusicPlayerDisplayItems( screen )

	local components = screen.Components

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	screen.NumItems = 0

	local firstUseable = false

	for i, songName in ipairs( screen.Songs ) do
		local songData = WorldUpgradeData[songName]
		if songData.GameStateRequirements == nil or IsGameStateEligible( songData, songData.GameStateRequirements ) then
			
			screen.NumItems = screen.NumItems + 1
			local purchased = GameState.WorldUpgradesAdded[songName]

			local purchaseButtonKey = "PurchaseButton"..screen.NumItems
			components[purchaseButtonKey] = CreateScreenComponent({ Name = "BlankInteractableObstacle",
				X = itemLocationX,
				Y = itemLocationY,
				Group = screen.ComponentData.DefaultGroup,
				Animation = screen.ItemAvailableAnimation,
				ScaleY = screen.PurchaseButtonScaleY,
				Alpha = 0.0,
			})
			SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })
			local button = components[purchaseButtonKey]
			button.Animation = screen.ItemAvailableAnimation
			button.HighlightAnimation = screen.ItemAvailableHighlightAnimation
			AttachLua({ Id = button.Id, Table = button })
			button.Screen = screen
			SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
			SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY })

			local icon = songData.Icon
			local iconScale = screen.IconScale
			if purchased then
				if GameState.MusicPlayerSongName == songData.Name then
					icon = "MusicPlayerPauseButton"
				else
					icon = "MusicPlayerPlayButton"
				end
				iconScale = screen.PausePlayIconScale
			end

			local iconKey = "Icon"..screen.NumItems
			if icon ~= nil then
				components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle",
					X = itemLocationX + screen.IconOffsetX,
					Y = itemLocationY,
					Scale = iconScale,
					Group = screen.ComponentData.DefaultGroup,
					Animation = icon,
					Alpha = 0.0,
				})
				button.IconId = components[iconKey].Id
			end

			local format = nil
			if purchased then
				format = screen.ItemPurchasedNameFormat
			elseif HasResources( songData.Cost ) then
				format = screen.ItemAvailableAffordableNameFormat
			else
				format = screen.ItemAvailableUnaffordableNameFormat
			end

			local itemNameFormat = ShallowCopyTable( format )
			itemNameFormat.Id = button.Id
			itemNameFormat.Text = songData.Name
			CreateTextBox( itemNameFormat )

			button.OnMouseOverFunctionName = "MouseOverMusicPlayerItem"
			button.OnMouseOffFunctionName = "MouseOffMusicPlayerItem"
			if purchased then
				button.OnPressedFunctionName = "SelectMusicPlayerItem"
			else
				button.OnPressedFunctionName = "HandleMusicPlayerPurchase"
			end

			if not firstUseable then
				screen.CursorStartX = itemLocationX
				screen.CursorStartY = itemLocationY
				firstUseable = true
			end

			button.Data = songData
			button.Index = screen.NumItems
			button.DisplayName = songData.Name
			button.Purchased = purchased

			if not GameState.WorldUpgradesAdded[songName] then
				-- Pin icon
				local pinButtonKey = "PinIcon"..screen.NumItems
				components[pinButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Alpha = 0.0, Scale = screen.PurchaseButtonScaleY })
				Attach({ Id = components[pinButtonKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.PinOffsetX, OffsetY = UIData.PinIconListOffsetY * screen.PurchaseButtonScaleY })
				components[purchaseButtonKey].PinButtonId = components[pinButtonKey].Id
				if HasStoreItemPin( button.Data.Name ) then
					components[purchaseButtonKey].IsPinned = true
					SetAnimation({ Name = "StoreItemPin", DestinationId = components[purchaseButtonKey].PinButtonId })
					-- Silent toolip
					CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
				end

				-- New icon
				if not GameState.WorldUpgradesViewed[songData.Name] then
					local newIconKey = "NewIcon"..screen.NumItems
					components[newIconKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = screen.ComponentData.DefaultGroup, Alpha = 0.0, Animation = "MusicPlayerNewTrack" })
					Attach({ Id = components[newIconKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 300, OffsetY = 0 })
					components[purchaseButtonKey].NewButtonId = components[newIconKey].Id
				end
			end

			itemLocationY = itemLocationY + screen.ItemSpacingY

		end
	end

	SetAlpha({ Ids = { components.Scrollbar.Id, components.ScrollbarSlider.Id }, Fraction = 1.0, Duration = 0.1 })

end

function HandleMusicPlayerPurchase( screen, button )
	local songData = button.Data

	if not button.Free and not HasResources( songData.Cost ) then
		ScreenCantAffordPresentation( screen, button )
		return
	end

	MusicPlayerItemPurchasedPresentation( button )

	AddWorldUpgrade( songData.Name )
	RemoveStoreItemPin( songData.Name, { Purchase = true } )

	Destroy({ Id = screen.Components["PurchaseButton".. button.Index].Id })
	screen.Components["PurchaseButton".. button.Index] = nil

	if screen.Components["Icon".. button.Index] ~= nil then
		Destroy({ Id = screen.Components["Icon".. button.Index].Id })
		screen.Components["Icon".. button.Index] = nil
	end

	for i, button in pairs( screen.Components ) do
		if button.Data ~= nil and button.Data.ResourceCost ~= nil then
			local costColor = Color.CostAffordable
			if not HasResource( button.Data.ResourceName, button.Data.ResourceCost ) then
				costColor = Color.CostUnaffordable
			end
			ModifyTextBox({ Id = screen.Components["PurchaseButton"..button.Index].Id, Color = costColor })
		end
	end

	CloseGhostAdminScreen( screen, button )

	thread( DoMusicPlayerPurchase, screen, button )
end

function DoMusicPlayerPurchase( screen, button )
	local itemData = button.Data
	SpendResources( itemData.Cost, itemData.Name, { Silent = true } )
	MusicPlayerPurchasePreActivatePresentation( screen, button, itemData )
	GameState.MusicPlayerSongName = itemData.Name
	MusicianMusic( { SourceId = screen.OpenedFrom.ObjectId, TrackName = WorldUpgradeData[itemData.Name].TrackName } )
	MusicPlayerPurchasePostActivatePresentation( screen, button, itemData )
	OpenMusicPlayerScreen( screen.OpenedFrom, { InitialScrollOffset = screen.ScrollOffset, SkipInitialDelay = true } )
end

function MusicPlayerPurchaseSequenceFinished( source, args )
	args = args or {}
	UseableOn({ Ids = args.UseableOnIds })
	UpdateAffordabilityStatus()
end

function MusicPlayerScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	GhostAdminUpdateVisibility( screen, { AnimateSlider = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
end

function MusicPlayerScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	GhostAdminUpdateVisibility( screen, { AnimateSlider = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })
end

function SelectMusicPlayerItem( screen, button )
	local songName = button.Data.Name
	if songName == GameState.MusicPlayerSongName then
		SetAnimation({ DestinationId = button.IconId, Name = "MusicPlayerPlayButton" })
		StopMusicianMusic()
		GameState.MusicPlayerSongName = nil
		MusicPlayerStopSongPresentation( screen.OpenedFrom, button )
	else
		if GameState.MusicPlayerSongName ~= nil then
			for index = 1, screen.NumItems do
				local purchaseButtonKey = "PurchaseButton"..index
				if screen.Components[purchaseButtonKey].Data.Name == GameState.MusicPlayerSongName then
					SetAnimation({ DestinationId = screen.Components[purchaseButtonKey].IconId, Name = "MusicPlayerPlayButton" })
					break
				end
			end
		end
		SetAnimation({ DestinationId = button.IconId, Name = "MusicPlayerPauseButton" })
		GameState.MusicPlayerSongName = songName
		MusicianMusic( { SourceId = screen.OpenedFrom.ObjectId, TrackName = WorldUpgradeData[songName].TrackName } )
		MusicPlayerPlaySongPresentation( screen.OpenedFrom, button )
	end
	UpdateMusicPlayerInteractionText( screen, button )
end

function HasUnviewedMusicPlayerSong( source, args )
	return HasUnviewedWorldUpgrade( ScreenData.MusicPlayer.Songs )
end
