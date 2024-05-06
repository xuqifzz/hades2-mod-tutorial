function MetaUpgradeCardScreenOpenPresentation( screen )

	if CanUpgradeCards() and not GameState.ScreensViewed.CardUpgradeInfoLayout then
		thread( PlayVoiceLines, GlobalVoiceLines.UnlockedUpgradeModeVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.OpenedCardScreenVoiceLines, true )
	end

end

function EquipMetaUpgradeCardPresentation( screen, button )

	local metaUpgradeName = button.CardName
	--SetAnimation({ Name = "DevCardSelected", DestinationId = button.Id })
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Green, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuStatIncrease", Id = button.Id })
	thread( PlayVoiceLines, MetaUpgradeCardData[metaUpgradeName].EquipVoiceLines or GlobalVoiceLines.UnlockedCardVoiceLines, true )
end

function UnequipMetaUpgradeCardPresentation( screen, button )
	SetAnimation({ Name = "DevCard", DestinationId = button.Id })
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuStatLower", Id = button.Id })
end

function EquipMetaUpgradeBonusCardPresentation( screen, button )
	--SetAnimation({ Name = "DevCardSelected", DestinationId = button.Id })
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Gold, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuStatIncrease", Id = button.Id })
end

function UnequipMetaUpgradeBonusCardPresentation( screen, button )
	SetAnimation({ Name = "DevCard", DestinationId = button.Id })
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Red, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuStatLower", Id = button.Id })
end

function InvalidMetaUpgradeCardAction( screen, button )
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Red, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( PlayVoiceLines, HeroVoiceLines.CannotInteractVoiceLines, true )
end

function CannotUpgradeMaxLevelMetaUpgradePresentation( screen, button )
	SetColor({ Id = button.CardArtId, Color = {0.1, 0.1, 0.1, 1.0}, Duration = 0 })
	SetColor({ Id = button.CardArtId, Color = {1,1,1,1}, Duration = 0.25 })
	CreateAnimation({ Name = "CardCannotUpgradeMaxLevelFlash", DestinationId = button.Id, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
	Flash({ Id = button.Id, Speed = 6, MinFraction = 0.5, MaxFraction = 0, Color = Color.White, Duration = 0.125, ExpireAfterCycle = true })
	thread(PulseText, {Id = button.Screen.Components.MetaUpgradeCardMaxLevel.Id, ScaleTarget = 1.25, ScaleDuration = 0.25, HoldDuration = 0.15, PulseBias = 0.05 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = button.Id })
end

function MetaUpgradeCardMaxLevelPresentation( button )
	CreateAnimation({ Name = "CardUpgradeMaxLevel", DestinationId = button.CardArtId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Gold, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( PlayVoiceLines, GlobalVoiceLines.ReachedMaxMemLimitVoiceLines, true )
end

function CannotAffordMetaUpgradeLimitPresentation( screen, button )
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Gold, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( PlayVoiceLines, GlobalVoiceLines.CannotAffordMemUpgradeVoiceLines, true )
end

function UpgradeMetaUpgradeLimitPresentation( screen, button )
	CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = screen.Components.MaxCostText.Id, GroupName = "Overlay" })
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Red, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash", Id = button.Id })
	thread( PlayVoiceLines, GlobalVoiceLines.UpgradedMemLimitVoiceLines, true )
end

function UnlockMetaUpgradeCardPresentation( screen, button, metaUpgradeData )
	SetHSV({ Id = button.CardArtId, HSV = {0, 0, 0}, ValueChangeType = "Absolute" })
	SetHSV({ Id = screen.Components.MetaUpgradeCardArt.Id, HSV = {0, 0, 0}, ValueChangeType = "Absolute"})
	SetAlpha({ Id = button.CardArtId, Fraction = 1.0 })
	SetAlpha({ Id = screen.Components.MetaUpgradeResourceCostBacking.Id, Fraction = 0.0 })
	CreateAnimation({ 
		Name = "MetaUpgradeCardUnlock", 
		DestinationId = button.Id,
		Group = "Combat_Menu_TraitTray_Overlay_Additive", 
		Scale = 5 / screen.ZoomLevel,
	})
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.White, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/SFX/Menu Sounds/HeartSlotUnlock", Id = button.Id })

	thread( PlayVoiceLines, metaUpgradeData.UnlockedCardVoiceLines or GlobalVoiceLines.UnlockedCardVoiceLines, true )
end

function RevealMetaUpgradeCardPresentation( screen, button, args )
		CreateAnimation({ 
			Name = "MetaUpgradeCardFlip", 
			DestinationId = button.Id,
			Group = "Combat_Menu_TraitTray_Overlay", 
			Scale = 5 / screen.ZoomLevel,
		})
		thread( MetaUpgradeCardRevealComplete, button, args )
		wait(0.12)
		SetAnimation({ Name = "Blank", DestinationId = button.CardArtId, Scale = screen.DefaultArtScale })
		PlaySound({ Name = "/SFX/Menu Sounds/HeartHighlightShimmer", Id = button.Id })
end

function MetaUpgradeCardRevealComplete( button, args )
	wait(1)
	CallFunctionName( args.CallFunctionNameOnComplete, args.Screen, args.Row, args.Column )
end

function MetaUpgradeCardOverLimitPresentation( screen, button )

	CreateAnimation({ Name = "CannotEquipCardOverLimit", DestinationId = button.Id, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })

	-- pulse current MEM total
	thread( PulseText, { Id = screen.Components.CurrentCostText.Id, ScaleTarget = 1.8, ScaleDuration = 0.1, HoldDuration = 0.1, PulseBias = 0.1 } )
	Flash({ Id = screen.Components.CurrentCostText.Id, Speed = 3, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, Duration = 0.2, ExpireAfterCycle = true })

	-- pulse current card MEM cost
	thread( PulseText, { Id = button.Id, ScaleTarget = 1.3, ScaleDuration = 0.1, HoldDuration = 0.1, PulseBias = 0.1 } )
	Flash({ Id = button.Id, Speed = 3, MinFraction = 0.8, MaxFraction = 0, Color = Color.Red, Duration = 0.2, ExpireAfterCycle = true })


	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCannotUpgrade", Id = button.Id })
	thread( PlayVoiceLines, GlobalVoiceLines.ReachedMemLimitVoiceLines, true )

end

function DoMetaUpgradeCardReveal( screen, args )
	args = args or {}
	local newZoom = GetZoomLevel()
	local zoomOutDelay = args.ZoomOutDelay
	local revealCardData = args.RevealedCardCoords
	local expandPsyche = args.AutoEquipFailed

	if newZoom ~= screen.ZoomLevel then
		wait( zoomOutDelay )
		DoScreenZoomOut( screen, revealCardData )
	end
	if not IsEmpty( revealCardData ) then
		for i, coordData in pairs( revealCardData ) do		
			local newButton = screen.Components[GetMetaUpgradeKey( coordData.Row, coordData.Column )]
			RevealMetaUpgradeCardPresentation( screen, newButton, { CallFunctionNameOnComplete = "UpdateMetaUpgradeCard", Screen = screen, Row = coordData.Row, Column = coordData.Column} )
		end
		if expandPsyche then
			-- Wait for card flip
			wait( 2 )
		end
	end
	if expandPsyche then
		OpenGraspLimitScreen( screen )
		thread( PlayVoiceLines, GlobalVoiceLines.ReachedMemLimitVoiceLines )
	end
end

function DoScreenZoomOut( screen, revealCoords )
	local components = screen.Components
	screen.ZoomLevel = GetZoomLevel()
	screen.ZoomInProgress = true
	local scale = 5 / screen.ZoomLevel

	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			if row <= screen.ZoomLevel and column <= screen.ZoomLevel then
				if row == screen.ZoomLevel or column == screen.ZoomLevel then
					-- In a newly revealed row or column
					 CreateMetaUpgradeCard( screen, row, column, cardName )
				end
			end
		end
	end
	MetaUpgradeCardZoomPresentation( screen, revealCoords )
	screen.ZoomInProgress = false
	if screen.SelectedButton then
		MouseOverMetaUpgrade( screen.SelectedButton )
	end
	SetAlpha({ Id = components.CardHoverFrame.Id, Fraction = 1, Duration = 0.25 })
end

function MetaUpgradeCardZoomPresentation( screen, revealCoords )

	local components = screen.Components
	local scale = 5 / screen.ZoomLevel
	local offsetX = screen.DefaultStartX + ScreenCenterNativeOffsetX / scale
	local offsetY = screen.DefaultStartY + ScreenCenterNativeOffsetY / scale
	local xSpacer = screen.DefaultTalentXSpacer
	local ySpacer = screen.DefaultTalentYSpacer
	local zoomDuration = 1
	local zoomEaseIn = 0
	local zoomEaseOut = 1
	SetScale({ Id = components.CardHoverFrame.Id, Fraction = scale, Duration = 0})
	SetAlpha({ Id = components.CardHoverFrame.Id, Fraction = 0, Duration = 0 })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomIn" })

	-- Shrink and fade, while creating new buttons
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			if row <= screen.ZoomLevel and column <= screen.ZoomLevel then
				local card = screen.Components[GetMetaUpgradeKey( row, column )]
				DestroyTextBox({ Id = card.Id })
				if row == screen.ZoomLevel or column == screen.ZoomLevel then
					SetAlpha({ Id = card.Id, Fraction = 0, Duration = 0 })
					SetAlpha({ Id = card.CardArtId, Fraction = 0, Duration = 0 })
					SetAlpha({ Id = card.CardCornersId, Fraction = 0, Duration = 0 })
					SetAlpha({ Id = card.TypeIconId, Fraction = 0, Duration = 0 })
					SetAlpha({ Id = card.EquippedHighlightId, Fraction = 0, Duration = 0 })
				else
					SetScale({ Id = card.Id, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.CardArtId, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.CardCornersId, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.TypeIconId, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.PinButtonId, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.EquippedHighlightId, Fraction = scale * 1.3, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					Move({ Id = card.Id, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut,
						OffsetX = (column - 1) * xSpacer * scale + offsetX * scale,
						OffsetY = (row - 1) * ySpacer * scale + offsetY * scale,
						})
				end
			end
		end
	end
	wait(zoomDuration)
	-- fade in newly revealed cards + recreate text
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			if row <= screen.ZoomLevel and column <= screen.ZoomLevel then
				local card = screen.Components[GetMetaUpgradeKey( row, column )]
				local newlyRevealed = false
				for i, coordData in pairs( revealCoords ) do
					if coordData.Row == row and coordData.Column == column then
						newlyRevealed = true
						break
					end
				end

				UpdateMetaUpgradeCard( screen, row, column )
				if newlyRevealed then 
					SetAnimation({ Name = "DevBacking", DestinationId = card.CardArtId, Scale = screen.DefaultArtScale })
					DestroyTextBox({ Id = card.Id })
						SetHSV({ Id = card.CardArtId, HSV = {0, 0, 0}, ValueChangeType = "Absolute" })
			
				end
				if row == screen.ZoomLevel or column == screen.ZoomLevel then
				
					SetAnimation({ Name = "DevBacking", DestinationId = card.CardArtId, Scale = screen.DefaultArtScale })

					SetAlpha({ Id = card.Id, Fraction = 1, Duration = 0.5 })
					SetAlpha({ Id = card.CardArtId, Fraction = 1, Duration = 0.5 })
					--SetAlpha({ Id = card.CardCornersId, Fraction = 1, Duration = 0.5 })
					SetAlpha({ Id = card.TypeIconId, Fraction = 1, Duration = 0.5 })
				end
			end
		end
	end
	wait(0.25)
end

function CloseMetaUpgradeCardScreenPresentation( screen )
	wait(0.15)
	if SessionState.MetaUpgradeChanges.HasChanged then
		thread( PlayVoiceLines, GlobalVoiceLines.ClosedCardScreenVoiceLines, true )
	end
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuClose" })
end

function ExitMetaUpgradeUpgradeModePresentation( screen )
	thread( PlayVoiceLines, GlobalVoiceLines.SwitchFromUpgradeCardModeVoiceLines, true )
	FullScreenFadeInAnimationReroll( {48, 25, 83, 255} , { PlaySpeed = 1 } )
end

function EnterMetaUpgradeUpgradeModePresentation( screen )
	thread( PlayVoiceLines, GlobalVoiceLines.SwitchToUpgradeCardModeVoiceLines, true )
	FullScreenFadeInAnimationReroll( {48, 25, 83, 255} , { PlaySpeed = 2 } )
end

function UpgradeMetaUpgradeCardPresentation( selectedButton )
	thread( PlayVoiceLines, GlobalVoiceLines.UpgradeCardVoiceLines, true )
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash2", Id = selectedButton.Id })
	CreateAnimation({ Name = "CardUpgrade", DestinationId = selectedButton.CardArtId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
end

function UpgradeModeAvailablePresentation( screen )
	-- thread( PlayVoiceLines, GlobalVoiceLines.UnlockedUpgradeModeVoiceLines, true )
	-- FullScreenFadeInAnimationReroll( {48, 25, 83, 255} , { PlaySpeed = 1 } )
end

function PulseMetaUpgradeMemCostDisplay( screen, button )
	local metaUpgradeName = button.CardName
	if not metaUpgradeName or not MetaUpgradeCardData[ metaUpgradeName ] then
		return
	end
	
	local cardCost = MetaUpgradeCardData[ metaUpgradeName ].Cost
	local currentCost = GetCurrentMetaUpgradeCost()
	local maxCost = GetMaxMetaUpgradeCost()
	if button.CardState == "HIDDEN" or button.CardState == "LOCKED" then
		for i, costRingId in ipairs( screen.CostRingIds ) do
			StopFlashing({ Id = costRingId })
		end
		return
	end
	
	if not MetaUpgradeCardEquipped(metaUpgradeName) then
		local overMax = currentCost + cardCost > maxCost
		if cardCost >= 0 then
			for i, costRingId in ipairs( screen.CostRingIds ) do
				local color = Color.Gold
				if i <= (currentCost + cardCost) and i > currentCost then
					Flash({ Id = costRingId, Speed = 1, MinFraction = 0, MaxFraction = 1, Color = color})
				elseif overMax and i <= currentCost and i > (currentCost - ((currentCost+cardCost) - maxCost)) then
					color = Color.CostUnaffordable
					Flash({ Id = costRingId, Speed = 1, MinFraction = 0.2, MaxFraction = 1, Color = color})
				else
					StopFlashing({ Id = costRingId })
				end
			end
			if overMax then
				thread(PulseText, ({ Id = screen.Components.MaxCostText.Id, ScaleTarget = 1.1, ScaleDuration = 0.1, HoldDuration = 0.25, PulseBias = 0.1, Color = Color.Red, OriginalColor = Color.LightGreen }))
			end
		end
	else
		local currentCost = GetCurrentMetaUpgradeCost()
		for i, costRingId in ipairs( screen.CostRingIds ) do
			local color = Color.White
			if i <= (currentCost) and i > (currentCost - cardCost) then
				Flash({ Id = costRingId, Speed = 1, MinFraction = 0, MaxFraction = 1, Color = color})
			else
				StopFlashing({ Id = costRingId })
			end
		end
	end
end