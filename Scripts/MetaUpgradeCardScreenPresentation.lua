function MetaUpgradeCardScreenOpenPresentation( screen )

	if CanIncreaseMetaUpgradeCardLimit() then
		thread( PlayVoiceLines, GlobalVoiceLines.OpenedCardScreenHighPsycheLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.OpenedCardScreenVoiceLines, true )
	end

end

function EquipMetaUpgradeCardPresentation( screen, button )

	local metaUpgradeName = button.CardName
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Green, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuConfirm", Id = button.Id })
	thread( PlayVoiceLines, MetaUpgradeCardData[metaUpgradeName].EquipVoiceLines or GlobalVoiceLines.UnlockedCardVoiceLines, true )

	
	local cardCost = MetaUpgradeCardData[ metaUpgradeName ].Cost
	
	local newIds = {}
	if not IsEmpty(screen.CostRingIds) then
		for i = GetCurrentMetaUpgradeCost() + 1, GetCurrentMetaUpgradeCost() + cardCost do
			local currentRingId = screen.CostRingIds[i]
			table.insert(newIds, i)
		end
	end
	thread( NewBonePresentation, screen, newIds )
end

function NewBonePresentation( screen, buttonIds )
	--SetScale({ Ids = buttonIds, Fraction = 1.02, Duration = 0 })
	--SetScale({ Ids = buttonIds, Fraction = 1, Duration = 0.2 })
	for i, id in ipairs(buttonIds) do
		CreateAnimation({ DestinationId = screen.Components.CostTextRingTarget.Id, Name = "Mem_Bone_In_"..id })
	end
end

function UnequipMetaUpgradeCardPresentation( screen, button )
	--SetAnimation({ Name = "DevCard", DestinationId = button.Id })
	PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuBackLoud", Id = button.Id })
end

function EquipMetaUpgradeBonusCardPresentation( screen, button )
	CreateAnimation({ Name = "CardUpgrade", --nopkg
		ScaleX = 0.7975 * 0.55,
		ScaleY = 0.957 * 0.55,
		DestinationId = button.CardArtId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })

	Flash({ Id = button.CardArtId, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Gold, Duration = 0.125, ExpireAfterCycle = true })

	PlaySound({ Name = "/SFX/Menu Sounds/MenuMagicFlashLongQuiet", Id = button.Id })

end

function UnequipMetaUpgradeBonusCardPresentation( screen, button )
	Flash({ Id = button.CardArtId, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Red, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/PlayerRespawnNEW", Id = button.Id })
end

function InvalidMetaUpgradeCardAction( screen, button )
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Red, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( PlayVoiceLines, HeroVoiceLines.CannotInteractVoiceLines, true )
end

function CannotUpgradeMaxLevelMetaUpgradePresentation( screen, button )
end

function CannotAffordMetaUpgradeLimitPresentation( screen, button )
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Gold, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( PlayVoiceLines, GlobalVoiceLines.CannotAffordMemUpgradeVoiceLines, true )
end

function MouseOverMetaUpgradeLimitPresentation( screen, button )
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Gold, Duration = 0.125, ExpireAfterCycle = true })
	if CheckCooldown("MetaUpgradeScreenHoverFlash", 1) then
		PlaySound({ Name = "/SFX/Menu Sounds/MenuOpenIris", Id = button.Id })
		CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = button.Id, GroupName = "Overlay" })
	end
end

function UpgradeMetaUpgradeLimitPresentation( screen, button )
	local components = screen.Components
	CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = screen.Components.MaxCostText.Id, GroupName = "Overlay" })
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Red, Duration = 0.125, ExpireAfterCycle = true })
	local maxMetaUpgradeCost = GetMaxMetaUpgradeCost()
	if maxMetaUpgradeCost >= 29 then
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorCloseWithUpgrade", Id = button.Id })
	else
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash", Id = button.Id })
	end
	thread( PlayVoiceLines, GlobalVoiceLines.UpgradedMemLimitVoiceLines, true )

	local nextMetaUpgradeLevel = MetaUpgradeCostData.MetaUpgradeLevelData[GetCurrentMetaUpgradeLimitLevel() + 1 ]
	local costIncrease = nextMetaUpgradeLevel.CostIncrease
	
	for i = maxMetaUpgradeCost + 1, maxMetaUpgradeCost + costIncrease do
		CreateAnimation({ 
			Name = "ArcanaNewBoneFx", 
			DestinationId = screen.Components.CostTextRingTarget.Id, 
			OffsetX = ScreenData.MetaUpgradeCardLayout.BonePositions[i].X, 
			OffsetY = ScreenData.MetaUpgradeCardLayout.BonePositions[i].Y,
			GroupName = "Combat_Menu_Overlay_Additive" })
		wait(0.1)	
	end
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
		ScaleX = 0.7975 * 0.65,
		ScaleY = 0.957 * 0.65,
	})
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.White, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/SFX/Menu Sounds/HeartSlotUnlock", Id = button.Id })

	thread( PlayVoiceLines, metaUpgradeData.UnlockedCardVoiceLines or GlobalVoiceLines.UnlockedCardVoiceLines, true )
end

function RevealMetaUpgradeCardPresentation( screen, button, args )
	IncrementTableValue(screen, "RevealingCards")
	SetAlpha({ Id = button.CostTextId, Fraction = 0, Duration = 0 })
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
	SetAlpha({ Id = button.CardCornersId, Fraction = 1, Duration = 0.25})
	SetAlpha({ Id = button.CostTextId, Fraction = 1, Duration = 0.25 })
	local screen = button.Screen
	DecrementTableValue(screen, "RevealingCards")
	wait(1)
	if screen.RevealingCards <= 0 and screen.RestoreZoomButton then
		MetaupgradeUpdateCardZoom( screen, screen.RestoreZoomButton )
	end
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
		MetaupgradeUpdateCardZoom( screen )
		screen.RestoreZoomButton = args.SelectedButton
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
		MetaUpgradeCardScreenResetCursor( screen )
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
	local scaleLerp = 1 - (screen.ZoomLevel - 3) / 2 
	local offsetX = screen.DefaultStartX 
	local offsetY = screen.DefaultStartY + screen.ScaledStartY * ( scaleLerp )
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
				DestroyTextBox({ Id = card.CostTextId })
		
				if row == screen.ZoomLevel or column == screen.ZoomLevel then
					SetAlpha({ Id = card.Id, Fraction = 0, Duration = 0 })
					SetAlpha({ Id = card.CardArtId, Fraction = 0, Duration = 0 })
					SetAlpha({ Id = card.CardCornersId, Fraction = 0, Duration = 0 })
					SetAlpha({ Id = card.RarityBadgeId, Fraction = 0, Duration = 0 })
					SetAlpha({ Id = card.EquippedHighlightId, Fraction = 0, Duration = 0 })
					SetAlpha({ Id = card.CostTextId, Fraction = 0, Duration = 0 })
				else
					SetScale({ Id = card.Id, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.CardArtId, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.CardCornersId, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.RarityBadgeId, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.PinButtonId, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.EquippedHighlightId, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					SetScale({ Id = card.CostTextId, Fraction = scale, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut })
					Move({ Id = card.Id, Duration = zoomDuration, EaseIn = zoomEaseIn, EaseOut = zoomEaseOut,
						OffsetX = (column - 1) * xSpacer * scale + offsetX * scale + ScreenCenterNativeOffsetX,
						OffsetY = (row - 1) * ySpacer * scale + offsetY * scale + ScreenCenterNativeOffsetY ,
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
				Teleport({ Id = card.CostTextId, DestinationId = card.CardCornersId, OffsetX = 0, OffsetY = 0 })	
		
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
					SetAlpha({ Id = card.RarityBadgeId, Fraction = 1, Duration = 0.5 })
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
	PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuBack" })
end

function UpgradeMetaUpgradeCardPresentation( selectedButton )
	thread( PlayVoiceLines, GlobalVoiceLines.UpgradeCardVoiceLines, true )
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash2", Id = selectedButton.Id })
	CreateAnimation({ Name = "CardUpgrade", --nopkg
		ScaleX = 0.7975 * 0.55,
		ScaleY = 0.957 * 0.55,
		DestinationId = selectedButton.CardArtId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
	local components = selectedButton.Screen.Components
	local scale = 2
	CreateAnimation({ Name = "CardUnlockShineLarge", --nopkg
		ScaleX = 0.7975 * scale,
		ScaleY = 0.957 * scale,
		DestinationId = components.MetaUpgradeCardArt.Id, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })

end
function MetaUpgradeCardMaxLevelPresentation( button )
	CreateAnimation({ Name = "CardUpgradeMaxLevel", 
		ScaleX = 0.7975 * 0.55,
		ScaleY = 0.957 * 0.55,
		DestinationId = button.CardArtId, GroupName = "Combat_Menu_TraitTray_Overlay_Additive" })
	Flash({ Id = button.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 0, Color = Color.Gold, Duration = 0.125, ExpireAfterCycle = true })
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCloseWithUpgrade", Id = button.Id })
end

function UpgradeModeAvailablePresentation( screen )
end

function StopMetaUpgradeMemCostPulse( screen )

	local costRepresentations = { screen.CostRingIds, screen.CostPipIds }
	for i, representationIds in pairs( costRepresentations ) do
		for i, costRingId in ipairs( representationIds ) do
			StopFlashing({ Id = costRingId })
		end
	end
end

function PulseMetaUpgradeMemCostDisplay( screen, button )
	local metaUpgradeName = button.CardName
	if not metaUpgradeName or not MetaUpgradeCardData[ metaUpgradeName ] then
		return
	end
	if button.CardState == "HIDDEN" or button.CardState == "LOCKED" then
		StopMetaUpgradeMemCostPulse( screen )
		return
	end
	local cardCost = MetaUpgradeCardData[ metaUpgradeName ].Cost
	local currentCost = GetCurrentMetaUpgradeCost()
	local maxCost = GetMaxMetaUpgradeCost()
	local overMax = currentCost + cardCost > maxCost
	
	local costRepresentations = { screen.CostRingIds, screen.CostPipIds }
	for s, representationIds in pairs( costRepresentations ) do
		if not MetaUpgradeCardEquipped(metaUpgradeName) then
			if cardCost >= 0 then
				for i, costRingId in ipairs( representationIds ) do
					local color = Color.BonesNext
					if i <= (currentCost + cardCost) and i > currentCost and i <= maxCost then
						Flash({ Id = costRingId, Speed = 1, MinFraction = 0, MaxFraction = 1, Color = color})
					elseif s == 1 and i > currentCost and i <= (currentCost + cardCost) then
						color = Color.BonesUnaffordable
						Flash({ Id = costRingId, Speed = 1, MinFraction = 0.2, MaxFraction = 1, Color = color})
					elseif s ==2 and overMax and i <= currentCost and i > (currentCost - ((currentCost+cardCost) - maxCost)) then
						color = Color.BonesUnaffordable
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
			for i, costRingId in ipairs( representationIds ) do
				local color = Color.White
				if i <= (currentCost) and i > (currentCost - cardCost) then
					Flash({ Id = costRingId, Speed = 1, MinFraction = 0, MaxFraction = 1, Color = color})
				else
					StopFlashing({ Id = costRingId })
				end
			end
		end
	end
end

function MetaUpgradeCardScreenMouseOverLayout( button )
	local screen = button.Screen
	if screen.Closing then
		return
	end
	screen.LastMouseOverLayout = button.MetaUpgradeLayoutNum
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = screen.Components["LayoutSet3"].Id })
	MetaUpgradeCardScreenUpdateLayoutSets( screen, button )
	UpdateMetaUpgradeCardInteractionText( screen, button )
end

function MetaUpgradeCardScreenMouseOffLayout( button )
	local screen = button.Screen
	if screen.Closing then
		return
	end
	screen.LastMouseOverLayout = nil
	MetaUpgradeCardScreenUpdateLayoutSets( screen, button )
	UpdateMetaUpgradeCardInteractionText( screen, button )
end

function MetaUpgradeCardScreenUpdateLayoutSets( screen, button )
	if screen.Closing then
		return
	end
	for i = 1, MetaUpgradeSaveLayoutData.MaximumMetaUpgradeLayouts do
		local slotComponent = screen.Components["LayoutSet"..i]
		if slotComponent ~= nil then
						
			if screen.LastMouseOverLayout == i then
				SetAnimation({ DestinationId = slotComponent.Id, Name = "DeckArt_Mouseover_"..GetTwoDigitString( GameState.MetaUpgradeLayoutsArt[i] or 1 ) })
				SetScale({ Id = slotComponent.Id, Fraction = slotComponent.MouseOverScale, Duration = 0.05 })
			else
				SetAnimation({ DestinationId = slotComponent.Id, Name = "DeckArt_"..GetTwoDigitString( GameState.MetaUpgradeLayoutsArt[i] or 1 ) })
				SetScale({ Id = slotComponent.Id, Fraction = slotComponent.Scale, Duration = 0.05 })
			end

			if GameState.CurrentMetaUpgradeLayout == i then
				Teleport({ Id = screen.Components.LayoutSetSelectionHighlight.Id, DestinationId = slotComponent.Id })
				if screen.LastMouseOverLayout == i then
					SetAnimation({ DestinationId = screen.Components.LayoutSetSelectionHighlight.Id , Name = "DeckArt_Mouseover_Selected" })
					SetScale({ Id = screen.Components.LayoutSetSelectionHighlight.Id, Fraction = slotComponent.MouseOverScale, Duration = 0.05 })
				else
					SetAnimation({ DestinationId = screen.Components.LayoutSetSelectionHighlight.Id , Name = "DeckArt_Selected" })
					SetScale({ Id = screen.Components.LayoutSetSelectionHighlight.Id, Fraction = slotComponent.Scale, Duration = 0.05 })
				end
			end

		end
	end
end

function MetaUpgradeCardScreenLayoutChangeOut( screen, button )
	local deckButton = screen.Components["LayoutSet"..GameState.CurrentMetaUpgradeLayout]
	PlaySound({ Name = "/SFX/HadesPaperFinish", Id = screen.Components["LayoutSet3"].Id })
	Flash({ Id = deckButton.Id, Speed = 3.0, MinFraction = 0.1, MaxFraction = 1.0, Color = Color.White, ExpireAfterCycle = true })
end

function MetaUpgradeCardScreenLayoutChangeIn( screen, button )

end
