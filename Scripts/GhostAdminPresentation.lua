
function GhostAdminScreenOpenFinishedPresentation( screen )

	if screen.OfferedVoiceLines ~= nil then
		if PlayVoiceLines( screen.OfferedVoiceLines, true ) then
			return
		end
	end

end

function GhostAdminSelectCategoryPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function GhostAdminPostDisplayCategoryPresentation( screen )
	AddInputBlock({ Name = "GhostAdminPostDisplayCategoryPresentation" })
	--[[
	if screen.NumItems == 0 then
		CreateTextBox({ Id =  screen.Components.InfoBoxName.Id,
			Text = "GhostAdmin_CategoryEmpty",
			FontSize = 34,
			OffsetX = -545, OffsetY = -20,
			Color = Color.White,
			Font = "P22UndergroundSCLight",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 1},
			Justification = "Center" })
	end
	]]

	GhostAdminUpdateVisibility( screen, { IgnoreArrows = true } )

	GhostAdminScreenRevealNewItemsPresentation( screen, button )
	
	RemoveInputBlock({ Name = "GhostAdminPostDisplayCategoryPresentation" })
end

function GhostAdminScreenRevealNewItemsPresentation( screen, button )

	AddInputBlock({ Name = "GhostAdminScreenRevealNewItemspResentation" })

	local components = screen.Components

	-- Reveal new items
	--for itemNum, item in ipairs( screen.AvailableItems ) do
	for itemNum = screen.ScrollOffset, screen.ScrollOffset + screen.ItemsPerPage do
		local item = screen.AvailableItems[itemNum]
		if item ~= nil and not GameState.WorldUpgradesRevealed[item.Name] then
			local purchaseButtonKey = "PurchaseButton"..itemNum
			SetAlpha({ Id = components[purchaseButtonKey].Id, Fraction = 0, Duration = 0 })
			local iconKey = "Icon"..itemNum
			SetAlpha({ Id = components[iconKey].Id, Fraction = 0, Duration = 0 })
			local newIconKey = "NewIcon"..itemNum
			SetAlpha({ Id = components[newIconKey].Id, Fraction = 0, Duration = 0 })
		end
	end
	for itemNum = screen.ScrollOffset, screen.ScrollOffset + screen.ItemsPerPage do
		local item = screen.AvailableItems[itemNum]
		if item ~= nil and not GameState.WorldUpgradesRevealed[item.Name] then
			local purchaseButtonKey = "PurchaseButton"..itemNum
			ModifyTextBox({ Id = components[purchaseButtonKey].Id, FadeOpacity = 0.0, FadeTarget = 1.0, FadeDuration = 1.3 })
			SetAlpha({ Id = components[purchaseButtonKey].Id, Fraction = 1, Duration = 0 })
			SetAnimation({ Name = "CriticalItemShopButtonReveal", DestinationId = components[purchaseButtonKey].Id, OffsetX = 0, })

			thread( PlayVoiceLines, item.OfferedVoiceLines or HeroVoiceLines.CauldronSpellDiscoveredVoiceLines, true )

			local iconKey = "Icon"..itemNum
			if components[iconKey] ~= nil then
				SetAlpha({ Id = components[iconKey].Id, Fraction = 1, Duration = 1.3 })
			end
			local newIconKey = "NewIcon"..itemNum
			if components[newIconKey] ~= nil then
				SetAlpha({ Id = components[newIconKey].Id, Fraction = 1, Duration = 1.3 })
			end
			CurrentRun.WorldUpgradesRevealed[item.Name] = true
			GameState.WorldUpgradesRevealed[item.Name] = true
			wait( 0.9 )
		end
	end
	wait( 0.5 ) -- Need to wait for last reveal animation to fully finish
	RemoveInputBlock({ Name = "GhostAdminScreenRevealNewItemspResentation" })
end

function GhostAdminScreenScrollPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
	GhostAdminScreenRevealNewItemsPresentation( screen, button )
end


function GhostAdminMouseOverScrollArrow( button )
	SetScale({ Id = button.Id, Fraction = button.HighlightedScale, Duration = 0.1 })
end

function GhostAdminMouseOffScrollArrow( button )
	SetScale({ Id = button.Id, Fraction = 1.0, Duration = 0.1 })
end

function GhostAdminScreenClosedPresentation( screen, button )
	PlaySound({ Name = screen.CloseSound or "/SFX/Menu Sounds/CauldronMenuOpenClose" })
	if button.Id == screen.Components.CloseButton.Id then
		SetAnimation({ Name = "MelTalkBrooding01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId })
		AddInteractBlock( screen.OpenedFrom, "GhostAdminScreenClosedPresentation" )
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.8, FromCurrentLocation = true, Retarget = true, EaseIn = 0, EaseOut = 1.0 })
		wait( 0.85 )
		RemoveInteractBlock( screen.OpenedFrom, "GhostAdminScreenClosedPresentation" )
	end
end


function GhostAdminSessionCompletePresentation( usee, screen )
	if screen == nil then
		return
	end
	if screen.NumSales == 0 then
		if CheckCooldown( "MarketNoSale", 60 ) then
			PlayEmote( { TargetId = usee.NoSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.NoSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	else
		if CheckCooldown( "MarketMadeSale", 60 ) then
			PlayEmote( { TargetId = usee.MadeSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.MadeSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	end
end

function GhostAdminItemPurchasedPresentation( button, upgradeData, args )
	if button.Free then
		PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteAffectionSFX" })
	else
		PlaySound({ Name = "/SFX/Menu Sounds/ContractorItemPurchase" })
	end
end

function PreActivateCriticalItemPresentation( screen, button, saleData, args )
	
	local focusId = screen.OpenedFrom.ObjectId
	args = args or {}

	local reagentCount = 0
	for i, resourceName in ipairs( ResourceDisplayOrderData ) do
		if saleData.Cost[resourceName] then
			reagentCount = reagentCount + 1
		end
	end
	
	CauldronSceneSetup( focusId, reagentCount )
	CauldronResourceSpendPresentation( screen, button, saleData, args, focusId )
	CauldronIncantationPresentation( screen, button, saleData, args, focusId )
	-- CauldronPostIncantationPresentation( screen, button, saleData, args, focusId )
end

function CauldronSceneSetup( focusId, reagentCount )
	FreezePlayerUnit( "ActivateCosmeticPresentation" )
	AddInputBlock({ Name = "ActivateCosmeticPresentation" })
	MapState.CosmeticPresentationActive = true

	PanCamera({ Id = focusId, Duration = 1.0, EaseIn = 0.05, EaseOut = 0.3, Retarget = true, FromCurrentLocation = true })
	FocusCamera({ Fraction = 1.15, Duration = 1.0, ZoomType = "Ease" })

	local animSpeedMultiplier = 0.55
	if reagentCount >= 2 then
		animSpeedMultiplier = animSpeedMultiplier - (0.075 * reagentCount)
	end
	SetAnimation({ Name = "MelTalkGifting01", DestinationId = CurrentRun.Hero.ObjectId, SpeedMultiplier = animSpeedMultiplier })

	wait( 0.75 )
end

function CauldronResourceSpendPresentation( screen, button, saleData, args, focusId )
	
	local user = CurrentRun.Hero
	if not saleData.SkipPreRevealVoiceLines then
		thread( PlayVoiceLines, saleData.PreRevealVoiceLines or GlobalVoiceLines.CauldronCastStartingVoiceLines )
	end

	local reagentCount = 0
	MapState.AddingReagents = true
	for i, resourceName in ipairs( ResourceDisplayOrderData ) do
		if saleData.Cost[resourceName] then
			local offsetY = screen.ResourceSpendTextInitialOffsetY + (reagentCount * screen.ResourceSpendTextSpacingY)
			reagentCount = reagentCount + 1
			SpendResource( resourceName, saleData.Cost[resourceName], saleData.Name, { Delay = 0.17, TargetId = focusId, HoldDuration = 1.7, OffsetY = offsetY, TextOffsetY = screen.ResourceSpendTextOffsetY, NoRandomOffset = true, StackDisplay = true } )
			PlaySound({ Name = "/SFX/CauldronIngredientSizzle", Id = focusId })			

	 		CreateAnimation({ Name = "CauldronLiquidSurfaceRipple", DestinationId = 558175, OffsetX = 0, OffsetY = 0 })
	 		CreateAnimation({ Name = "CauldronItemAddSmoke", DestinationId = 558175, OffsetX = 0, OffsetY = 0 })

	 		SetAlpha({ Id = 558701, Fraction = 0, Duration = 0.1 })
	 		SetAlpha({ Id = 558702, Fraction = 0, Duration = 0.1 })
			wait( 0.25 )
		end
	end

	SetAlpha({ Id = 558701, Fraction = 0.33, Duration = 1 })
	SetAlpha({ Id = 558702, Fraction = 0.33, Duration = 1 })

	MapState.AddingReagents = nil
end

function CauldronIncantationPresentation( screen, button, saleData, args, focusId )

	local user = CurrentRun.Hero

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
	thread( CauldronCastingPresentation, nil, { } )
	
	-- restore the scene
	AdjustFullscreenBloom({ Name = "Off", Duration = 3.0 })
	AdjustColorGrading({ Name = "Frozen", Duration = sceneDuration * 0.8 })

	-- display unlock text
	if not saleData.SkipUnlockText then
		wait( 0.6 )
		thread( PostIncantationPresentationUnlockText, saleData )
		wait( 1.4 )
	end

end

function PostIncantationPresentationUnlockText( saleData )
	DisplayInfoBanner( nil, {
		TitleText = saleData.UnlockTextId or "GhostAdminUnlock",
		FontScale = 0.82,
		-- Icon = saleData.Icon,
		-- IconScale = 0.7,
		-- IconMoveSpeed = 0.00001,
		-- IconOffsetY = 6,
		SubtitleText = saleData.Name,
		SubtitleOffsetY = -10,
		SubtitleDelay = 0.75,
		AnimationName = "LocationBackingIrisGenericIn",
		AnimationOutName = "LocationBackingIrisGenericOut",
	})
	PlaySound({ Name = saleData.ItemActivationSound or "/Leftovers/Menu Sounds/EmoteExcitement" })
end

function PostActivateCriticalItemPresentation( button, saleData )

	wait( saleData.PostActivationHoldDuration or 1.2 )

	if saleData.PanDuration ~= nil then
		local focusId = GetCosmeticFocusId( saleData )
		PanCamera({ Ids = saleData.ActivateIds or saleData.ActivateRoomObstacleIds or saleData.ActivateUnits or focusId, Duration = saleData.PanDuration, EaseIn = 0.05, EaseOut = 0.3, Retarget = true, FromCurrentLocation = true })
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
		PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = button.Id })
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

	SetAnimation({ DestinationId = button.Id, Name = button.HighlightAnimation })
	PlaySound({ Id = button.Id, Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })

	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		Text = button.Data.Name,
		UseDescription = true,
		FadeTarget = 1.0,
	})

	if not button.Purchased then
		SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 1.0, Duration = 0.2 })
		AddResourceCostDisplay( button.Screen, button.Data.Cost, button.Screen.CostDisplay, button.Data )
	end

	ModifyTextBox({ Id = components.InfoBoxFlavor.Id,
		Text = button.Data.Name.."_Flavor",
		UseDescription = true,
		FadeTarget = 1.0,
	})

	local newButtonKey = "NewIcon"..button.Index
	SetAlpha({ Id = button.NewButtonId, Fraction = 0, Duration = 0.2 })
	CurrentRun.WorldUpgradesViewed[button.Data.Name] = true
	GameState.WorldUpgradesViewed[button.Data.Name] = true
	
	UpdateGhostAdminInteractionText( button.Screen, button )
end

function MouseOffGhostAdminItem( button )

	local screen = button.Screen
	local components = button.Screen.Components
	screen.SelectedItem = nil

	SetAnimation({ DestinationId = button.Id, Name = button.Animation })

	--ModifyTextBox({ Id = components.InfoBoxName.Id, FadeTarget = 0.0, })
	SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 0.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxFlavor.Id, FadeTarget = 0.0, })
	SetAlpha({ Ids = screen.CostIds, Fraction = 0, Duration = 0.1 })
	DestroyTextBox({ Ids = screen.CostIds })

	UpdateGhostAdminInteractionText( button.Screen )
end


function UpdateGhostAdminInteractionText( screen, button )

	local components = screen.Components
	
	if button ~= nil and not button.Purchased then
		if button.Data ~= nil and button.Data.Cost ~= nil and HasResources( button.Data.Cost ) then
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
		if GameState.WorldUpgrades.WorldUpgradePinning then
			SetAlpha({ Id = components.PinButton.Id, Fraction = 1.0, Duration = 0.2 })
		else
			SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
		end
	else
		SetAlpha({ Id = components.SelectButton.Id, Fraction = 0.0, Duration = 0.2 })
		SetAlpha({ Id = components.PinButton.Id, Fraction = 0.0, Duration = 0.2 })
	end		
	
	if screen.NumCategories >= 2 then
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 1.0, Duration = 0.0 })
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 1.0, Duration = 0.0 })
	else
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 0.0, Duration = 0.0 })
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 0.0, Duration = 0.0 })
	end	

end

function SetupCauldronLocked( source, args )
	SetAlpha({ Ids = { 558698, }, Fraction = 0.0, Duration = 0.0 })
	SessionMapState.CauldronCookTopId = SpawnObstacle({ Name = "CrossroadsCauldronLid01", Group = "FX_Standing_Top", DestinationId = source.ObjectId, OffsetZ = 160, })
	SetScale({ Id = SessionMapState.CauldronCookTopId, Fraction = 0.28 })
	OverwriteSelf( source, args )
end

function SetupCauldronCookActivePresentation( source, args )
	local cookStatus = GameState.CookStatus[source.ObjectId]
	local text = "CauldronCookStatus_CookActive"
	if cookStatus.TimeRemaining <= 0 then
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
		SessionMapState.CauldronCookTopId = SpawnObstacle({ Name = "CrossroadsCauldronLid01", Group = "FX_Standing_Top", DestinationId = source.ObjectId, OffsetZ = 160, })
		SetScale({ Id = SessionMapState.CauldronCookTopId, Fraction = 0.28 })
		PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/DishesInteract", Id = source.ObjectId })
		SessionMapState.CauldronCookTimerId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI_World", DestinationId = source.ObjectId, OffsetY = -340 })
		SetAnimation({ Name = "CauldronCookTimeShadow", DestinationId = SessionMapState.CauldronCookTimerId })
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
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = interactableObjectId })

	SetAlpha({ Ids = { SessionMapState.CauldronCookTopId, SessionMapState.CauldronCookTimerId }, Fraction = 0.0, Duration = 0.3 })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/DishesInteract", Id = interactableObjectId })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.1 }, } )
	thread( PlayVoiceLines, GlobalVoiceLines.CookingCompleteVoiceLines, true )
	wait( 0.3 )

	SetAlpha({ Ids = { 558698, }, Fraction = 1.0, Duration = 0.2 })
	wait( 0.2 )

	RemoveInputBlock({ Name = "MelUsedCauldronCookComplete" })
end