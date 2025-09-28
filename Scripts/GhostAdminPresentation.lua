
function GhostAdminSelectCategoryPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuSwitch" })
	SetAnimation({ DestinationId = screen.Components.BackgroundIllustration01.Id, Name = "GhostAdminScreenCauldronTab" }) --nopkg
	SetAlpha({ Ids = { screen.Components.Scrollbar.Id, screen.Components.ScrollbarSlider.Id, screen.Components.ScrollDown.Id, screen.Components.ScrollUp.Id }, Fraction = 0, Duration = 0.1 })
	SetAlpha({ Ids = screen.ButtonIds, Fraction = 0, Duration = 0.1 })
end

function GhostAdminScreenRevealNewItemsPresentation( screen, button )

	local components = screen.Components

	AddInputBlock({ Name = "GhostAdminScreenRevealNewItemsPresentation" })

	local incantationsRevealed = false
	for i, itemData in ipairs( screen.AvailableItems ) do
		if screen.ItemsToReveal[itemData.Name] then
			-- Auto-scroll for items on other pages
			local needScroll = false
			while (i > screen.ScrollOffset + screen.ItemsPerPage) do
				needScroll = true
				screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
			end
			if needScroll then
				wait( 0.1 )
				GenericScrollPresentation( screen )
				GhostAdminUpdateVisibility( screen, { AnimateSlider = true } )
				wait( 0.2 )
			end

			incantationsRevealed = true
			thread( PlayVoiceLines, HeroVoiceLines.CauldronTyphonHintVoiceLines )
			thread( PlayVoiceLines, itemData.OfferedVoiceLines or HeroVoiceLines.CauldronSpellsRevealingVoiceLines )

			local button = components[itemData.Name.."Button"]
			ModifyTextBox({ Id = button.Id, FadeOpacity = 0.0, FadeTarget = 1.0, FadeDuration = 1.3 })
			SetAlpha({ Id = button.Id, Fraction = 1.0, Duration = 0.0 })
			SetAlpha({ Ids = button.AssociatedIds, Fraction = 1.0, Duration = 0.6 })
			SetAnimation({ DestinationId = button.Id, Name = "CriticalItemShopButtonReveal" }) --nopkg
			CurrentRun.WorldUpgradesRevealed[itemData.Name] = true
			GameState.WorldUpgradesRevealed[itemData.Name] = true
			wait( 1.0 )
		end
	end
	screen.ItemsToReveal = {}

	if incantationsRevealed then
		thread( PlayVoiceLines, HeroVoiceLines.CauldronSpellDiscoveredVoiceLines, true )
		wait( 0.5 ) -- Need to wait for last reveal animation to fully finish
	end

	RemoveInputBlock({ Name = "GhostAdminScreenRevealNewItemsPresentation" })

end

function GhostAdminMouseOverScrollArrow( button )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu2" })
	SetScale({ Id = button.Id, Fraction = button.HighlightedScale, Duration = 0.1 })
end

function GhostAdminMouseOffScrollArrow( button )
	SetScale({ Id = button.Id, Fraction = 1.0, Duration = 0.1 })
end

function GhostAdminScreenClosedPresentation( screen, button )
	local components = screen.Components
	PlaySound({ Name = screen.CloseSound or "/SFX/Menu Sounds/CauldronMenuCloseNew" })
	SetAnimation({ DestinationId = components.InfoBoxBacking.Id, Name = "GhostAdminScreenCauldronScrollOut" }) --nopkg
	if button.Id == screen.Components.CloseButton.Id then
		if screen.Components.BackgroundIllustration01 ~= nil then
			SetAnimation({ DestinationId = screen.Components.BackgroundIllustration01.Id, Name = "GhostAdminScreenCauldronOut" }) --nopkg
		end
		SetAnimation({ Name = "MelTalkBrooding01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId })
		AddInteractBlock( screen.OpenedFrom, "GhostAdminScreenClosedPresentation" )
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.8, FromCurrentLocation = true, Retarget = true, EaseIn = 0, EaseOut = 1.0 })
		wait( 0.85 )
		RemoveInteractBlock( screen.OpenedFrom, "GhostAdminScreenClosedPresentation" )
	else
		if screen.Components.BackgroundIllustration01 ~= nil then
			SetAnimation({ DestinationId = screen.Components.BackgroundIllustration01.Id, Name = button.Data.IncantationBackgroundAnimation })
			SessionMapState.CauldronBackgroundIllustration = screen.Components.BackgroundIllustration01
			screen.Components.BackgroundIllustration01 = nil -- prevent destruction of this obstacle on screen close
			wait( 0.02 )
			SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 1.0 })
		end
	end
end

function GhostAdminItemPurchasedPresentation( button, upgradeData, args )
	SetAnimation({ DestinationId = button.Id, Name = "GhostAdminScreenCauldronButtonPurchase" }) --nopkg
	if button.Free then
		PlaySound({ Name = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY" })
	else
		PlaySound({ Name = "/SFX/Menu Sounds/CauldronSpellCastWithPoof" })
	end
end

function GhostAdminUpdateScrollbarPresentation( screen, args )
	local components = screen.Components

	if screen.NumItems > screen.ItemsPerPage then
		SetAlpha({ Ids = { components.Scrollbar.Id, components.ScrollbarSlider.Id }, Fraction = 1.0, Duration = 0.1 })
	end

	local maxScrollOffset = math.max( 1, math.floor( (screen.NumItems - 1) / screen.ItemsPerPage ) * screen.ItemsPerPage )
	local sliderTargetY = Lerp( screen.ScrollbarSliderTopY + ScreenCenterNativeOffsetY, screen.ScrollbarSliderBottomY + ScreenCenterNativeOffsetY, screen.ScrollOffset / maxScrollOffset )
	local slideDuration = 0.0
	if args.AnimateSlider then
		slideDuration = 0.2
	end
	Move({ Id = components.ScrollbarSlider.Id, OffsetX = components.ScrollbarSlider.X, OffsetY = sliderTargetY, Duration = slideDuration, EaseIn = 0.0, EaseOut = 1.0 })

	if screen.ScrollOffset <= 0 then
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
		UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
		UseableOn({ Id = components.ScrollUp.Id })
	end

	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
		UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1, Duration = 0.1 })
		UseableOn({ Id = components.ScrollDown.Id })
	end
end

function PreActivateCriticalItemBackgroundPresentation( saleData )
	wait( saleData.IncantationAspectRatioFramesHideDelay )
	AltAspectRatioFramesHide()
	wait( 1.3 )
	Destroy({ Id = SessionMapState.CauldronBackgroundIllustration.Id })
	SessionMapState.CauldronBackgroundIllustration = nil
end

function PreActivateCriticalItemPresentation( screen, saleData )
	
	local focusId = screen.OpenedFrom.ObjectId

	local reagentCount = 0
	for i, resourceName in ipairs( ResourceDisplayOrderData ) do
		if saleData.Cost[resourceName] then
			reagentCount = reagentCount + 1
		end
	end

	if saleData.CookTime ~= nil then
		screen.OpenedFrom.BlockStatusAnimations = true
	end

	thread( PreActivateCriticalItemBackgroundPresentation, saleData )

	CauldronSceneSetup( saleData, focusId, reagentCount )
	CauldronResourceSpendPresentation( screen, saleData, focusId )
	CauldronIncantationPresentation( screen, saleData, focusId )
end

function CauldronSceneSetup( saleData, focusId, reagentCount )
	FreezePlayerUnit( "ActivateCosmeticPresentation" )
	AddInputBlock({ Name = "ActivateCosmeticPresentation" })
	MapState.CosmeticPresentationActive = true

	PanCamera({ Id = focusId, Duration = saleData.IncantationCameraPanDuration, EaseIn = saleData.IncantationCameraPanEaseIn, EaseOut = saleData.IncantationCameraPanEaseOut, Retarget = true, FromCurrentLocation = true })
	FocusCamera({ Fraction = 1.15, Duration = saleData.IncantationCameraPanDuration, ZoomType = "Ease" })

	local animSpeedMultiplier = 0.55
	if reagentCount >= 2 then
		animSpeedMultiplier = animSpeedMultiplier - (0.075 * reagentCount)
	end
	SetAnimation({ Name = "MelTalkGifting01", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = animSpeedMultiplier })

	wait( 0.75 )
end

function CauldronResourceSpendPresentation( screen, saleData, focusId )
	
	local user = CurrentRun.Hero
	if not saleData.SkipPreRevealVoiceLines then
		if saleData.UnthreadPreRevealVoiceLines then
			SetAnimation({ Name = "MelTalkGifting01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId })
			-- PlayVoiceLines( saleData.PreRevealVoiceLines or GlobalVoiceLines.CauldronCastStartingVoiceLines )
		else
			thread( PlayVoiceLines, saleData.PreRevealVoiceLines or GlobalVoiceLines.CauldronCastStartingVoiceLines )
		end
	end

	local reagentCount = 0
	for i, resourceName in ipairs( ResourceDisplayOrderData ) do
		if saleData.Cost[resourceName] then
			local offsetY = screen.ResourceSpendTextInitialOffsetY + (reagentCount * screen.ResourceSpendTextSpacingY)
			reagentCount = reagentCount + 1
			SpendResource( resourceName, saleData.Cost[resourceName], saleData.Name, { Delay = 0.17, TargetId = focusId, HoldDuration = 2.15, OffsetY = offsetY, TextOffsetY = screen.ResourceSpendTextOffsetY } )
			PlaySound({ Name = "/SFX/CauldronIngredientSizzle", Id = focusId })

	 		CreateAnimation({ Name = "CauldronLiquidSurfaceRipple", DestinationId = 558175, OffsetX = 0, OffsetY = 0 }) --nopkg
	 		CreateAnimation({ Name = "CauldronItemAddSmoke", DestinationId = 558175, OffsetX = 0, OffsetY = 0 })

	 		SetAlpha({ Id = 558701, Fraction = 0, Duration = 0.1 })
	 		SetAlpha({ Id = 558702, Fraction = 0, Duration = 0.1 })
			wait( 0.25 )
		end
	end
	if saleData.UnthreadPreRevealVoiceLines then
		PlayVoiceLines( saleData.PreRevealVoiceLines or GlobalVoiceLines.CauldronCastStartingVoiceLines )
	end

	SetAlpha({ Id = 558701, Fraction = 0.33, Duration = 1 })
	SetAlpha({ Id = 558702, Fraction = 0.33, Duration = 1 })
end

function CauldronIncantationPresentation( screen, saleData, focusId )

	local user = CurrentRun.Hero

	if saleData.StartIncantationThreadedFunctionName ~= nil then
		thread( CallFunctionName, saleData.StartIncantationThreadedFunctionName, saleData.StartIncantationThreadedFunctionArgs )
	end

	-- determine scene duration
	local sceneDuration = saleData.IncantationDuration or 23

	-- set Melinoe's animation
	local incantationAnimation = saleData.IncantationAnimation or "MelinoeCauldronIncantationComplete"
	local incantationAnimationPlaySpeed = saleData.IncantationAnimationSpeed or 1.0
	SetAnimation({ Name = incantationAnimation, DestinationId = user.ObjectId, SpeedMultiplier = incantationAnimationPlaySpeed })

	-- presentation go!
	local source = screen.OpenedFrom
	local offsetY = saleData.IncantationOffsetY or -190
	AdjustFullscreenBloom({ Name = "DesaturatedLight", Duration = 0.9 })
	CreateAnimation({ Name = saleData.ItemPreActivationVfx or "CauldronSmokeSmall", DestinationId = focusId })
	CreateAnimation({ Name = "CauldronFullscreenDarken", UseScreenLocation = true, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	ShakeScreen({ Speed = 300, Distance = 4, Duration = 1.0, FalloffSpeed = 1000 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedArthurChoir" })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.13, Duration = 1.0 }, } )
	PanCamera({ Id = source.ObjectId, Duration = sceneDuration * 0.8, FromCurrentLocation = true, Retarget = true, OffsetY = offsetY, EaseIn = 1.5 })
	--FocusCamera({ Fraction = 0.875, Duration = sceneDuration * 0.6 , ZoomType = "Ease"  })
	FocusCamera({ Fraction = 1.2, Duration = sceneDuration * 0.6 , ZoomType = "Ease"  })
	
	-- play voiceline
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	thread( PlayVoiceLines, saleData.IncantationVoiceLines or GlobalVoiceLines[saleData.RevealGlobalVoiceLines] )

	-- play cauldron casting punctuation at the correct part of the animation
	local activateNotify = "ActivateWaitForAnimation"..user.ObjectId
	local incantationPunctuation = saleData.IncantationPunctuation or 2.1
	NotifyOnAnimationTimeRemaining({ Id = user.ObjectId, Animation = incantationAnimation, Remaining = incantationPunctuation, Notify = activateNotify, Timeout = sceneDuration * 1.5 })	
	waitUntil( activateNotify )

	local voiceLines = GlobalVoiceLines[saleData.RevealReactionGlobalVoiceLines] or saleData.RevealReactionVoiceLines
	if voiceLines ~= nil then
		UseableOff({ Id = screen.OpenedFrom.ObjectId })
		voiceLines.PlayedNothingFunctionName = "GenericPresentation"
		voiceLines.PlayedNothingFunctionArgs =
		{
			UseableOnIds = { screen.OpenedFrom.ObjectId },
		}
		voiceLines.FinishedFunctionName = "GhostAdminPurchaseSequenceFinished"
		voiceLines.FinishedFunctionArgs =
		{
			UseableOnIds = { screen.OpenedFrom.ObjectId },
		}
		thread( PlayVoiceLines, voiceLines )
	end

	thread( CauldronCastingPresentation, nil, saleData )
	
	-- restore the scene
	AdjustFullscreenBloom({ Name = "Off", Duration = 3.0 })
	AdjustColorGrading({ Name = "Frozen", Duration = sceneDuration * 0.8 })

	-- display unlock text
	if not saleData.SkipUnlockText then
		wait( 0.6 )
		wait( saleData.ExtraHoldBeforeUnlockText or 0.0 )
		thread( PostIncantationPresentationUnlockText, saleData )
		wait( 1.4 )
	end

end

function PostIncantationPresentationUnlockText( saleData )
	DisplayInfoBanner( nil, {
		TitleText = saleData.UnlockTextId or "GhostAdminUnlock",
		FontScale = 0.82,
		Icon = saleData.Icon,
		IconScale = 1.3,
		IconMoveSpeed = 0.00001,
		IconOffsetY = 6,
		SubtitleText = saleData.Name,
		SubtitleOffsetY = 60,
		SubtitleDelay = 0.75,
		AnimationName = "InfoBannerCauldronIn",
		AnimationOutName = "InfoBannerCauldronOut",
		IconBackingAnimationName = "LocationBackingIrisSmallSubtitleIn",
		IconBackingAnimationOutName = "LocationBackingIrisSmallSubtitleOut",
		SubTextColor = { 141, 255, 217, 255 },
		HighlightIcon = true,

	})
	PlaySound({ Name = saleData.ItemActivationSound or "/Leftovers/Menu Sounds/EmoteExcitement" })
end

function PostActivateCriticalItemPresentation( saleData )

	wait( saleData.PostActivationHoldDuration or 1.2 )

	thread( CallFunctionName, saleData.PostActivationThreadedFunctionName, saleData.PostActivationThreadedFunctionArgs )

	if saleData.PanDuration ~= nil then
		local focusId = GetCosmeticFocusId( saleData )
		PanCamera({ Ids = saleData.ActivateIds or saleData.ActivateRoomObstacleIds or saleData.ActivateUnits or focusId, Duration = saleData.PanDuration, EaseIn = 0.05, EaseOut = 0.02, Retarget = true, FromCurrentLocation = true })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
		thread( PlayVoiceLines, saleData.PostRevealVoiceLines )
		wait( saleData.PanDuration + (saleData.PanHoldDuration or 0) )
	end

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	local inputReturnDelay = 0.7
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = inputReturnDelay, Retarget = true })
	wait( inputReturnDelay * 0.5 )

	UnfreezePlayerUnit( "ActivateCosmeticPresentation" )
	RemoveInputBlock({ Name = "ActivateCosmeticPresentation" })
	MapState.CosmeticPresentationActive = false

end

function MouseOverGhostAdminCategory( button )
	local screen = button.Screen
	if screen.ActiveCategoryIndex ~= button.CategoryIndex then
		SetAnimation({ Name = button.Animations.Highlight, DestinationId = button.Id })
		PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuToggle2", Id = button.Id })
	end
	local previousShift = not IsEmpty( button.IconShiftRequests )
	button.IconShiftRequests.MouseOver = true
	if not previousShift then
		Move({ Id = button.IconId, Angle = 90, Distance = screen.CategoryIconMouseOverShiftDistance, Speed = screen.CategoryIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
	end
end

function MouseOffGhostAdminCategory( button )
	local screen = button.Screen
	if screen.ActiveCategoryIndex ~= button.CategoryIndex then
		SetAnimation({ Name = button.Animations.Default, DestinationId = button.Id })
	end
	local previousShift = not IsEmpty( button.IconShiftRequests )
	button.IconShiftRequests.MouseOver = nil
	if previousShift and IsEmpty( button.IconShiftRequests ) then
		Move({ Id = button.IconId, Angle = 270, Distance = screen.CategoryIconMouseOverShiftDistance, Speed = screen.CategoryIconMouseOverShiftSpeed, SmoothStep = true, Additive = true })
	end
end

function MouseOverGhostAdminItem( button )

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

	SetAlpha({ Ids = { components.InfoBoxBacking.Id, components.InfoBoxDescription.Id, components.InfoBoxFlavor.Id }, Fraction = 1.0, Duration = 0.2 })
	if not screen.FirstInfoBoxShown then
		SetAnimation({ DestinationId = components.InfoBoxBacking.Id, Name = "GhostAdminScreenCauldronScrollIn" }) --nopkg
		screen.FirstInfoBoxShown = true
	end
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		Text = button.Data.Name,
		UseDescription = true,
	})

	if not button.Purchased then
		SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 1.0, Duration = 0.2 })
		AddResourceCostDisplay( button.Screen, button.Data.Cost, button.Screen.CostDisplay, button.Data )
	end

	if components.InfoBoxFlavor ~= nil then
		ModifyTextBox({ Id = components.InfoBoxFlavor.Id,
			Text = button.Data.Name.."_Flavor",
			UseDescription = true,
			FadeTarget = 1.0,
		})
	end

	SetAlpha({ Id = button.NewIconId, Fraction = 0, Duration = 0.2 })
	CurrentRun.WorldUpgradesViewed[button.Data.Name] = true
	GameState.WorldUpgradesViewed[button.Data.Name] = true
	
	UpdateGhostAdminInteractionText( button.Screen, button )
end

function MouseOffGhostAdminItem( button )

	local screen = button.Screen
	local components = button.Screen.Components

	SetAnimation({ DestinationId = button.Id, Name = button.MouseOffAnimation })
	screen.SelectedItem = nil

	SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 0.0, Duration = 0.1 })
	SetAlpha({ Ids = { components.InfoBoxBacking.Id, components.InfoBoxDescription.Id, components.InfoBoxFlavor.Id }, Fraction = 0.0, Duration = 0.2 })
	--SetAnimation({ DestinationId = components.InfoBoxBacking.Id, Name = "GhostAdminScreenCauldronScrollOut" })
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })
	Destroy({ Ids = screen.CostIds })
	screen.CostIds = nil

	UpdateGhostAdminInteractionText( button.Screen )
end

function UpdateGhostAdminInteractionText( screen, button )

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
		if button.Data.Removable and not ( GameState.WorldUpgrades[button.Data.Name] and button.Data.RotateOnly ) then
			if button.Data.RotateOnly or not GameState.WorldUpgrades[button.Data.Name] then
				ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.AltTexts[1] })
			else
				ModifyTextBox({ Id = components.SelectButton.Id, Text = components.SelectButton.AltTexts[2] })
			end
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	end

	if screen.NumCategories ~= nil then
		if screen.NumCategories >= 2 then
			SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 1.0, Duration = 0.0 })
			SetAlpha({ Id = components.ScrollRight.Id, Fraction = 1.0, Duration = 0.0 })
		else
			SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.0 })
			SetAlpha({ Id = components.ScrollRight.Id, Fraction = 0.0, Duration = 0.0 })
		end
	end

end

function SetupCauldronLocked( source, args )
	SetAlpha({ Ids = { 558698, }, Fraction = 0.0, Duration = 0.0 })
	SessionMapState.CauldronCookTopId = SpawnObstacle({ Name = "CrossroadsCauldronLid01", Group = "FX_Standing_Top", DestinationId = source.ObjectId, OffsetZ = 160, }) -- nopkg
	ApplyCauldronCookTopGraphic()
	SetScale({ Id = SessionMapState.CauldronCookTopId, Fraction = 0.28 })
	OverwriteSelf( source, args )
end

function ApplyCauldronCookTopGraphic( source, args )
	if SessionMapState.CauldronCookTopId ~= nil then
		local lidAnimation = nil
		if GameState.WorldUpgrades.Cosmetic_Cauldron01 then
			lidAnimation = "Tilesets\\Crossroads\\Crossroads_Cauldron_Lid_01"
		elseif GameState.WorldUpgrades.Cosmetic_Cauldron01a then
			lidAnimation = "Tilesets\\Crossroads\\Crossroads_Cauldron_Lid_01a"
		else
			lidAnimation = "Tilesets\\Crossroads\\Crossroads_Cauldron_Lid_01b"
		end
		SetAnimation({ DestinationId = SessionMapState.CauldronCookTopId, Name = lidAnimation })
	end
end

function SetupCauldronCookActivePresentation( source, args )
	local cookStatus = GameState.CookStatus[source.ObjectId]
	local text = "CauldronCookStatus_CookActive"
	if cookStatus.TimeRemaining <= 0 then
		source.BlockStatusAnimations = false
		PlayStatusAnimation( source, { Animation = "StatusIconWantsToTalkImportant", OffsetZ = source.AnimOffsetZ } )
	end
	SetAlpha({ Ids = { 558698, }, Fraction = 0.0, Duration = 0.0 })
	if SessionMapState.CauldronCookTimerId ~= nil then
		ModifyTextBox({
			Id = SessionMapState.CauldronCookTimerId,
			Text = text,
			LuaKey = "TempTextData",
			LuaValue = cookStatus,
		})
	else
		SessionMapState.CauldronCookTopId = SpawnObstacle({ Name = "CrossroadsCauldronLid01", Group = "FX_Standing_Top", DestinationId = source.ObjectId, OffsetZ = 160, }) -- nopkg
		ApplyCauldronCookTopGraphic()
		SetScale({ Id = SessionMapState.CauldronCookTopId, Fraction = 0.28 })
		if args.PlayCauldronCloseSound then
			PlaySound({ Name = "/SFX/CauldronClose", Id = source.ObjectId })
		end
		SessionMapState.CauldronCookTimerId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI_World", DestinationId = source.ObjectId, OffsetY = -340 })
		SetAnimation({ Name = "CauldronCookTimeShadow", DestinationId = SessionMapState.CauldronCookTimerId })  --nopkg
		CreateTextBox({
			Id = SessionMapState.CauldronCookTimerId,
			Text = text,
			OffsetY = -4,
			Justification = "Center",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Font = "P22UndergroundSCMedium",
			FontSize = 34,
			LuaKey = "TempTextData",
			LuaValue = cookStatus,
			AutoSetDataProperties = false,
			TextSymbolScale = 0.8,
		})
	end
end

function UseCauldronCookActivePresentation( usee, args )
	local cookStatus = GameState.CookStatus[usee.ObjectId]
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "MelUsedLockedCauldron" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
	Shake({ Id = usee.ObjectId, Distance = 1.0, Speed = 75, Duration = 0.15 })
	PlaySound({ Name = "/SFX/CauldronIngredientSizzle", Id = usee.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.CookingPendingVoiceLines, true )
	thread( InCombatText, usee.ObjectId, "CauldronCheckCookActive", 3.0, { LuaKey = "CookStatus", LuaValue = cookStatus, ShadowScaleX = 1.95 } )
	wait( 1.85 )
	RemoveInputBlock({ Name = "MelUsedLockedCauldron" })
	wait( 1.35, RoomThreadName )
	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end

end

function UseCauldronCookCompletePresentation( usee, args )

	AddInputBlock({ Name = "MelUsedCauldronCookComplete" })

	SetAnimation({ Name = "MelinoeInteract", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })

	SetAlpha({ Id = SessionMapState.CauldronCookTimerId, Fraction = 0, Duration = 0.1 })
	PlaySound({ Name = "/SFX/CauldronClose", Id = usee.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.2 }, } )
	Shake({ Id = SessionMapState.CauldronCookTopId, Distance = 3, Speed = 150, Duration = 0.3, Angle = 90 })
	wait( 0.3 )

	CreateAnimation({ Name = "CauldronSmokeLargeWithLid", DestinationId = usee.ObjectId, Group  = "Standing" })
	PlaySound({ Name = "/SFX/CauldronOpen", Id = usee.ObjectId })
	Move({ Id = SessionMapState.CauldronCookTopId, DestinationId = usee.ObjectId, OffsetY = -100, Duration = 0.3, EaseIn = 0.1, EaseOut = 0.99 })
	SetAlpha({ Id = SessionMapState.CauldronCookTopId, Fraction = 0.0, Duration = 0.3 })
	thread( PlayVoiceLines, GlobalVoiceLines.CookingCompleteVoiceLines, true )
	wait( 0.3 )

	SetAlpha({ Ids = { 558698, }, Fraction = 1.0, Duration = 0.2 })
	wait( 0.2 )

	RemoveInputBlock({ Name = "MelUsedCauldronCookComplete" })
end