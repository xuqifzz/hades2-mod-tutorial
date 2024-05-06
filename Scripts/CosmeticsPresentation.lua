function GetCosmeticFocusId( saleData )
	local id = nil
	if saleData.CameraFocusId then
		id = saleData.CameraFocusId
	elseif saleData.SetAnimations then
		id = GetIdsByType({ Name = GetFirstKey( saleData.SetAnimations ) })[1]
	elseif saleData.ActivateIds then
		id = saleData.ActivateIds[1]
	elseif saleData.ActivateNames then
		id = GetInactiveIds({ Names = saleData.ActivateNames })[1]
	elseif saleData.ActivateObstacles then
		id = GetFirstKey( saleData.ActivateObstacles )
	elseif saleData.ActivateRoomObstacleIds then
		id = GetFirstKey( saleData.ActivateRoomObstacleIds )
	elseif saleData.SetHSVs then
		id = GetIdsByType({ Name = GetFirstKey( saleData.SetHSVs ) })[1]
	elseif saleData.SetColorIds then
		id = saleData.SetColorIds[1]
	elseif saleData.DestroyIds then
		id = saleData.DestroyIds[1]
	elseif saleData.DestroyNames then
		id = GetIdsByType({ Name = saleData.DestroyNames })[1]
	end
	return id
end

function CosmeticShopPostDisplayCategoryPresentation( screen )
	AddInputBlock({ Name = "CosmeticShopPostDisplayCategoryPresentation" })
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

	GhostAdminUpdateVisibility( screen, { IgnoreArrows = true } )

	--GhostAdminScreenRevealNewItemsPresentation( screen, button )
	
	RemoveInputBlock({ Name = "CosmeticShopPostDisplayCategoryPresentation" })
end

function PreActivateCosmeticPresentation( screen, button, saleData, args )

	args = args or {}

	FreezePlayerUnit( "ActivateCosmeticPresentation" )
	AddInputBlock({ Name = "ActivateCosmeticPresentation" })
	MapState.CosmeticPresentationActive = true

	thread( PlayVoiceLines, saleData.PreRevealVoiceLines or GlobalVoiceLines.CauldronCastStartingVoiceLines )

	if not button.Free and not args.Removal then
		local reagentCount = 0
		MapState.AddingReagents = true
		for i, resourceName in ipairs( ResourceDisplayOrderData ) do
			if saleData.Cost[resourceName] then
				reagentCount = reagentCount + 1
				SpendResource( resourceName, saleData.Cost[resourceName], saleData.Name )
				PlaySound({ Name = "/SFX/CauldronIngredientSizzle", Id = screen.OpenedFrom.ObjectId })
				wait( 0.75 )
			end
		end
		MapState.AddingReagents = nil
	end

	local focusId = GetCosmeticFocusId( saleData )
	PanCamera({ Id = focusId, Duration = saleData.PanDuration or 1.0, EaseIn = 0.05, EaseOut = 0.3, Retarget = true, FromCurrentLocation = true })

	CreateAnimation({ Name = saleData.ItemPreActivationVfx or "CosmeticUnlockFx", DestinationId = focusId })
	PlaySound({ Name = saleData.ItemPreActivationSound or "/Leftovers/Menu Sounds/EmoteExcitement" })

	wait( (saleData.PanDuration or 1.0) + (saleData.PreActivationHoldDuration or 0.5) )
	FullScreenFadeOutAnimation()
	PlaySound({ Name = saleData.ItemActivationSound or "/Leftovers/Menu Sounds/EmoteThoughtful" })
	wait( 0.5 )
end

function PostActivateCosmeticPresentation( button, saleData )

	if saleData.RevealReactionVoiceLines then
		thread( PlayVoiceLines, saleData.RevealReactionVoiceLines )
	end

	FullScreenFadeInAnimation()

	if saleData.RevealReactionGlobalVoiceLines and not saleData.SkipRevealReactionGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[saleData.RevealReactionGlobalVoiceLines] )
	elseif saleData.RevealReactionVoiceLines then
		thread ( PlayVoiceLines, saleData.RevealReactionVoiceLines, true )
	end

	wait( saleData.PostActivationHoldDuration or 0.5 )

	local inputReturnDelay = 0.7
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = inputReturnDelay, Retarget = true })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	wait( inputReturnDelay )

	UnfreezePlayerUnit( "ActivateCosmeticPresentation" )
	RemoveInputBlock({ Name = "ActivateCosmeticPresentation" })
	MapState.CosmeticPresentationActive = false

end