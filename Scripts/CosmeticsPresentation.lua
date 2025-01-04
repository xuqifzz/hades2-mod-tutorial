function GetCosmeticFocusId( saleData )
	local id = nil
	if saleData.CameraFocusId then
		id = saleData.CameraFocusId
	elseif saleData.SetAnimationIds then
		id = saleData.SetAnimationIds[1]
	elseif saleData.ActivateIds then
		id = saleData.ActivateIds[1]
	elseif saleData.ActivateRoomObstacleIds then
		id = GetFirstKey( saleData.ActivateRoomObstacleIds )
	end
	return id
end

function PreActivateCosmeticPresentation( screen, button, saleData, args )

	FreezePlayerUnit( "ActivateCosmeticPresentation" )
	AddInputBlock({ Name = "ActivateCosmeticPresentation" })
	MapState.CosmeticPresentationActive = true

	if args.ReAdd then
		thread( PlayVoiceLines, saleData.CosmeticReAddedVoiceLines or GlobalVoiceLines.CosmeticReAddedVoiceLines )
	elseif args.Removal then
		thread( PlayVoiceLines, saleData.CosmeticRemovedVoiceLines or GlobalVoiceLines.CosmeticRemovedVoiceLines )
	else
		thread( PlayVoiceLines, saleData.PreRevealVoiceLines )
	end

	if not button.Free and not args.ReAdd and not args.Removal then
		local reagentCount = 0
		MapState.AddingReagents = true
		for i, resourceName in ipairs( ResourceDisplayOrderData ) do
			if saleData.Cost[resourceName] then
				reagentCount = reagentCount + 1
				SpendResource( resourceName, saleData.Cost[resourceName], saleData.Name )
				wait( 0.75 )
			end
		end
		MapState.AddingReagents = nil
	end

	local focusId = GetCosmeticFocusId( saleData )
	local panDuration = saleData.PanDuration or 1.0

	PanCamera({ Id = focusId, Duration = panDuration, EaseIn = 0.05, EaseOut = 0.3, Retarget = true, FromCurrentLocation = true })
	wait(0.3)
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = focusId })
	SetAnimation({ Name = "MelTalkPensive01", DestinationId = CurrentRun.Hero.ObjectId })

	if panDuration > 1.0 then
		wait( panDuration - 1.0 )
	end

	CreateAnimation({ Name = saleData.ItemPreActivationVfx or "CosmeticUnlockFx", DestinationId = focusId })

	wait( (saleData.PanDuration or 1.0) + (saleData.PreActivationHoldDuration or 0.5) )
	FullScreenFadeOutAnimation()
	PlaySound({ Name = saleData.ItemPreActivationSound or "/Leftovers/Menu Sounds/EmoteExcitement" })
	wait( 0.5 )
end

function PostActivateCosmeticPresentation( button, saleData, args )

	FullScreenFadeInAnimation()

	if not args.ReAdd and not args.Removal then
		if saleData.RevealReactionGlobalVoiceLines and not saleData.SkipRevealReactionGlobalVoiceLines then
			thread( PlayVoiceLines, GlobalVoiceLines[saleData.RevealReactionGlobalVoiceLines] )
		elseif saleData.RevealReactionVoiceLines then
			thread ( PlayVoiceLines, saleData.RevealReactionVoiceLines, true )
		end
	end
	if saleData.OnRevealFunctionName ~= nil then
		thread( CallFunctionName, saleData.OnRevealFunctionName, saleData.OnRevealFunctionArgs )
	end

	wait( saleData.PostActivationDuration or 0.5 )

	local focusId = GetCosmeticFocusId( saleData )
	CreateAnimation({ Name = saleData.ItemPostActivationVfx or "CosmeticUnlockFx", DestinationId = focusId })
	PlaySound({ Name = "/Leftovers/SFX/AuraThrowSmallASCENSION", Id = focusId })

	wait( saleData.PostActivationHoldDuration or 0.5 )

	local doraId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Dora_01" })
	SetAnimation({ Name = "MelTalkBrooding01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = doraId })

	local inputReturnDelay = 0.7
	PanCamera({ Id = doraId, Duration = inputReturnDelay, Retarget = true })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	wait( inputReturnDelay )

	UnfreezePlayerUnit( "ActivateCosmeticPresentation" )
	RemoveInputBlock({ Name = "ActivateCosmeticPresentation" })
	MapState.CosmeticPresentationActive = false

end