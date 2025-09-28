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

	MusicPlayerDisplayItems( screen )

	UpdateMusicPlayerInteractionText( screen )
	if GameState.WorldUpgrades.WorldUpgradeMusicPlayerShuffle then
		SetAlpha({ Id = screen.Components.ShuffleButton.Id, Fraction = 1.0, Duration = 0.2 })
		screen.Components.ShuffleButton.Visible = true
		if not GameState.Flags.HasShuffledMusicPlayer then
			thread( PulseContextActionPresentation, screen.Components.ShuffleButton, { ThreadName = "MusicPlayerShufflePulse", PulseOnce = true } )
		end
	else
		SetAlpha({ Id = screen.Components.ShuffleButton.Id, Fraction = 0.0 })
	end
	wait( 0.02 )
	ScreenResetCursorToStartLocation( screen )
	RemoveInputBlock({ Name = "OpenMusicPlayerScreen" })

	thread( GenericScreenOpenEndPresentation, screen )

	screen.KeepOpen = true
	HandleScreenInput( screen )
	return screen

end

function CloseMusicPlayerScreen( screen, button )
	killTaggedThreads( "MusicPlayerShufflePulse" )
	CloseGhostAdminScreen( screen, button )
end

function MusicPlayerUpdateButtonStatus( screen, button, args )
	args = args or {}

	if args.Playing and CurrentRun.SuppressAmbientMusic ~= "MusicPlayer" then
		SetAnimation({ DestinationId = button.IconId, Name = "MusicPlayerPauseButton" }) --nopkg
		button.NeutralAnimation = screen.ItemNowPlayingAnimation
		button.MouseOverAnimation = screen.ItemNowPlayingMouseOverAnimation
	else
		SetAnimation({ DestinationId = button.IconId, Name = "MusicPlayerPlayButton" }) --nopkg
		button.NeutralAnimation = screen.ItemAvailableAnimation
		button.MouseOverAnimation = screen.ItemAvailableMouseOverAnimation
	end

	if screen.SelectedItem == button then
		SetAnimation({ DestinationId = button.Id, Name = button.MouseOverAnimation })
	else
		SetAnimation({ DestinationId = button.Id, Name = button.NeutralAnimation })
	end

end

function MusicPlayerDisplayItems( screen )

	local components = screen.Components

	screen.AvailableItems = {}
	screen.NumItems = 0

	local playingSongIndex = 0
	for i, songName in ipairs( screen.Songs ) do
		local songData = WorldUpgradeData[songName]
		if songData.GameStateRequirements == nil or IsGameStateEligible( songData, songData.GameStateRequirements ) or GameState.WorldUpgradesAdded[songName] then
			screen.NumItems = screen.NumItems + 1
			if songData.Name == GameState.MusicPlayerSongName then
				playingSongIndex = screen.NumItems
			end
			table.insert( screen.AvailableItems, songData )
		end
	end

	if playingSongIndex > 0 then
		screen.ScrollOffset = MusicPlayerGetScrollOffsetForIndex( screen, playingSongIndex )
	end

	MusicPlayerUpdateVisibility( screen )

end

function MusicPlayerUpdateVisibility( screen, args )
	args = args or {}
	local components = screen.Components

	if screen.SelectedItem ~= nil then
		MouseOffMusicPlayerItem( screen.SelectedItem )
	end

	GhostAdminUpdateScrollbarPresentation( screen, args )

	-- Destroy all the buttons from the last screen
	Destroy({ Ids = screen.ButtonIds })
	screen.ButtonIds = {}

	-- Create the new batch of buttons
	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY
	local firstIndex = screen.ScrollOffset + 1
	local lastIndex = math.min( screen.NumItems, screen.ScrollOffset + screen.ItemsPerPage )
	for itemIndex = firstIndex, lastIndex, 1 do

		local itemData = screen.AvailableItems[itemIndex]
		local displayName = itemData.Name
		local purchased = GameState.WorldUpgrades[displayName]

		local button = CreateScreenComponent({
			Name = "BlankInteractableObstacle",
			X = itemLocationX,
			Y = itemLocationY,
			Group = screen.ComponentData.DefaultGroup,
			Animation = screen.ItemAvailableAnimation,
			Alpha = 0.0,
		})
		components[displayName.."Button"] = button
		button.AssociatedIds = {}
		button.Screen = screen
		button.OnMouseOverFunctionName = "MouseOverMusicPlayerItem"
		button.OnMouseOffFunctionName = "MouseOffMusicPlayerItem"
		if purchased then
			button.OnPressedFunctionName = "SelectMusicPlayerItem"
		else
			button.OnPressedFunctionName = "HandleMusicPlayerPurchase"
		end
		button.NeutralAnimation = screen.ItemAvailableAnimation
		button.MouseOverAnimation = screen.ItemAvailableMouseOverAnimation
		button.Data = itemData
		button.Purchased = purchased
		AttachLua({ Id = button.Id, Table = button })
		SetAnimation({ DestinationId = button.Id, Name = button.NeutralAnimation })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipX", Value = screen.TooltipX + ScreenCenterNativeOffsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipY", Value = screen.TooltipY + ScreenCenterNativeOffsetY })
		SetInteractProperty({ DestinationId = button.Id, Property = "FreeFormSelectOffsetX", Value = screen.FreeFormSelectOffsetX })

		local iconScale = screen.IconScale
		if purchased then
			iconScale = screen.PausePlayIconScale
		end
		local icon = CreateScreenComponent({
			Name = "BlankObstacle",
			X = itemLocationX + screen.IconOffsetX,
			Y = itemLocationY,
			Scale = screen.IconScale,
			Group = screen.ComponentData.DefaultGroup,
			Animation = itemData.Icon,
			Alpha = 0.0,
		})
		button.IconId = icon.Id
		table.insert( button.AssociatedIds, icon.Id )
		components[displayName.."Icon"] = icon

		local formatName = nil
		if purchased then
			formatName = "ItemPurchasedNameFormat"
		elseif HasResources( itemData.Cost ) then
			formatName = "ItemAvailableAffordableNameFormat"
		else
			formatName = "ItemAvailableUnaffordableNameFormat"
		end
		CreateTextBoxWithScreenFormat( screen, button, formatName, { Text = displayName } )

		-- Hidden description for tooltip
		CreateTextBox({ Id = button.Id,
			Text = displayName,
			UseDescription = true,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = itemData,
		})

		if purchased then
			MusicPlayerUpdateButtonStatus( screen, button, { Playing = GameState.MusicPlayerSongName == displayName } )
		else
			local pinIcon = CreateScreenComponent({
				Name = "BlankObstacle",
				Group = screen.ComponentData.DefaultGroup,
				Alpha = 0.0,
				Scale = screen.PinScale,
			})
			components[displayName.."PinIcon"] = pinIcon
			table.insert( button.AssociatedIds, pinIcon.Id )
			Attach({ Id = pinIcon.Id, DestinationId = button.Id, OffsetX = screen.PinOffsetX, OffsetY = UIData.PinIconListOffsetY + screen.PinOffsetY })
			button.PinButtonId = pinIcon.Id
			if HasStoreItemPin( displayName ) then
				button.IsPinned = true
				SetAnimation({ Name = "StoreItemPin", DestinationId = pinIcon.Id })
				-- Silent toolip
				CreateTextBox({ Id = button.Id, TextSymbolScale = 0, Text = "StoreItemPinTooltip", Color = Color.Transparent, })
			end

			if not GameState.WorldUpgradesViewed[displayName] then
				local newIcon = CreateScreenComponent({
					Name = "BlankObstacle",
					Group = screen.ComponentData.DefaultGroup,
					Animation = "MusicPlayerNewTrack",
					Alpha = 0.0,
				})
				components[displayName.."NewIcon"] = newIcon
				table.insert( button.AssociatedIds, newIcon.Id )
				Attach({ Id = newIcon.Id, DestinationId = button.Id, OffsetX = 300, OffsetY = 0 })
				button.NewIconId = newIcon.Id
			end
		end

		SetAlpha({ Id = button.Id, Fraction = 1.0, Duration = 0.1 })
		SetAlpha({ Ids = button.AssociatedIds, Fraction = 1.0, Duration = 0.1 })
		if args.PlaySequentialFade then
			wait( 0.05 )
		end

		if itemData.Name == GameState.MusicPlayerSongName or itemIndex == firstIndex then
			screen.CursorStartX = itemLocationX
			screen.CursorStartY = itemLocationY
		end

		table.insert( screen.ButtonIds, button.Id )
		screen.ButtonIds = CombineTables( screen.ButtonIds, button.AssociatedIds )

		itemLocationY = itemLocationY + screen.ItemSpacingY
	end
end

function HandleMusicPlayerPurchase( screen, button )
	local songData = button.Data

	if not button.Free and not HasResources( songData.Cost ) then
		ScreenCantAffordPresentation( screen, button )
		return
	end

	MusicPlayerItemPurchasedPresentation( button )

	AddWorldUpgrade( songData.Name )
	table.insert( GameState.UnlockedMusicPlayerSongs, songData.Name )
	RemoveStoreItemPin( songData.Name, { Purchase = true } )

	CloseMusicPlayerScreen( screen, button )

	thread( DoMusicPlayerPurchase, screen, button )
end

function DoMusicPlayerPurchase( screen, button )
	local itemData = button.Data
	GameState.MusicPlayerPlaylist = nil
	GameState.MusicPlayerSongName = itemData.Name
	MusicPlayerPurchasePreActivatePresentation( screen, button, itemData )
	MusicianMusic( WorldUpgradeData[itemData.Name].TrackName )
	CancelArtemisSinging()
	MusicPlayerPurchasePostActivatePresentation( screen, button, itemData )
	OpenMusicPlayerScreen( screen.OpenedFrom, { SkipInitialDelay = true } )
end

function MusicPlayerScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	GenericScrollPresentation( screen, button )
	MusicPlayerUpdateVisibility( screen, { AnimateSlider = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.ItemSpacingY), ForceUseCheck = true })
end

function MusicPlayerScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	GenericScrollPresentation( screen, button )
	MusicPlayerUpdateVisibility( screen, { AnimateSlider = true } )
	wait(0.02)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })
end

function SelectMusicPlayerItem( screen, button )
	local songName = button.Data.Name
	if songName == GameState.MusicPlayerSongName and CurrentRun.SuppressAmbientMusic ~= "MusicPlayer" then
		MusicPlayerUpdateButtonStatus( screen, button, { Playing = false } )
		StopMusicianMusic( { Duration = 0 } )
		MusicPlayerStopSongPresentation( screen.OpenedFrom, button )
		GameState.MusicPlayerSongName = nil
	else
		if GameState.MusicPlayerSongName ~= nil then
			local prevButton = screen.Components[GameState.MusicPlayerSongName.."Button"]
			if prevButton ~= nil then
				MusicPlayerUpdateButtonStatus( screen, prevButton, { Playing = false } )
			end
		end
		GameState.MusicPlayerSongName = songName

		local artemisAlreadySuppressed = ( CurrentRun.SuppressAmbientMusic == "Artemis" )
		thread( PlayVoiceLines, GlobalVoiceLines.MelMusicChoiceVoiceLines, true, nil, { ArtemisAlreadySuppressed = artemisAlreadySuppressed } )
		CancelArtemisSinging()

		MusicPlayerUpdateButtonStatus( screen, button, { Playing = true } )
		MusicianMusic( WorldUpgradeData[songName].TrackName )
		MusicPlayerPlaySongPresentation( screen.OpenedFrom, button )
	end
	GameState.MusicPlayerPlaylist = nil
	UpdateMusicPlayerInteractionText( screen, button )
end

function HasUnviewedMusicPlayerSong( source, args )
	return HasUnviewedWorldUpgrade( ScreenData.MusicPlayer.Songs )
end

function MusicPlayerShuffle( screen, button )
	if not GameState.WorldUpgrades.WorldUpgradeMusicPlayerShuffle then
		return
	end

	GameState.Flags.HasShuffledMusicPlayer = true
	killTaggedThreads( "MusicPlayerShufflePulse" )

	if IsEmpty( GameState.MusicPlayerPlaylist ) then
		GameState.MusicPlayerPlaylist = MusicPlayerGetShuffledPlaylist()
	end
	local nextSong = RemoveFirstValue( GameState.MusicPlayerPlaylist )
	local prevSong = GameState.MusicPlayerSongName
	local nextSongIndex = nil
	for index = 1, screen.NumItems do
		local songData = screen.AvailableItems[index]
		if songData.Name == nextSong then
			nextSongIndex = index
			break
		end
	end

	local prevScrollOffset = screen.ScrollOffset
	screen.ScrollOffset = MusicPlayerGetScrollOffsetForIndex( screen, nextSongIndex )
	if screen.ScrollOffset ~= prevScrollOffset then
		MusicPlayerUpdateVisibility( screen, { AnimateSlider = true } )
		wait(0.02)
	end
	local nextSongButton = screen.Components[nextSong.."Button"]
	TeleportCursor({ DestinationId = nextSongButton.Id, ForceUseCheck = true })

	MusicPlayerShufflePresentation( screen, nextSongButton )

	GameState.MusicPlayerSongName = nextSong
	CurrentRun.HasAdvancedMusicPlayerPlaylist = true
	CancelArtemisSinging()

	MusicPlayerUpdateButtonStatus( screen, nextSongButton, { Playing = true } )
	if prevSong ~= nil then
		local prevSongButton = screen.Components[prevSong.."Button"]
		if prevSongButton ~= nil then
			MusicPlayerUpdateButtonStatus( screen, prevSongButton, { Playing = false } )
		end
	end

	MusicianMusic( WorldUpgradeData[GameState.MusicPlayerSongName].TrackName )
	MusicPlayerPlaySongPresentation( screen.OpenedFrom )

	UpdateMusicPlayerInteractionText( screen )
end

function MusicPlayerGetShuffledPlaylist()
	local playlist = ShallowCopyTable( GameState.UnlockedMusicPlayerSongs )
	local shuffled = FYShuffle( playlist )
	-- Prevent the same song from playing twice in a row
	if GameState.MusicPlayerSongName == shuffled[1] then
		local swapIndex = RandomInt( 2, #shuffled )
		shuffled[1] = shuffled[swapIndex]
		shuffled[swapIndex] = GameState.MusicPlayerSongName
	end
	return shuffled
end

function MusicPlayerGetScrollOffsetForIndex( screen, index )
	return math.floor( ( index - 1 ) / screen.ItemsPerPage ) * screen.ItemsPerPage
end
