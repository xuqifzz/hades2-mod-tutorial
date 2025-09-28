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

function CosmeticsShopScreenClosedPresentation( screen, button )
	local components = screen.Components
	PlaySound({ Name = screen.CloseSound or "/SFX/Menu Sounds/CauldronMenuCloseNew" })
	SetAnimation({ DestinationId = components.InfoBoxBacking.Id, Name = "GhostAdminScreenCauldronScrollOut" }) --nopkg
	SetAnimation({ DestinationId = screen.Components.DoraPortrait.Id, Name = "Portrait_Dora_Hardhat_Exit" })
	if button.Id == screen.Components.CloseButton.Id then
		SetAnimation({ Name = "MelTalkBrooding01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId })
		AddInteractBlock( screen.OpenedFrom, "CosmeticsShopScreenClosedPresentation" )
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.8, FromCurrentLocation = true, Retarget = true, EaseIn = 0, EaseOut = 1.0 })
		wait( 0.85 )
		RemoveInteractBlock( screen.OpenedFrom, "CosmeticsShopScreenClosedPresentation" )
	end
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
		for i, resourceName in ipairs( ResourceDisplayOrderData ) do
			if saleData.Cost[resourceName] then
				reagentCount = reagentCount + 1
				SpendResource( resourceName, saleData.Cost[resourceName], saleData.Name, { TextOffsetY = screen.ResourceSpendTextOffsetY } )
				wait( 0.75 )
			end
		end
	end

	local focusId = GetCosmeticFocusId( saleData )
	local panDuration = saleData.PanDuration or 1.0

	PanCamera({ Id = focusId, Duration = panDuration, EaseIn = 0.05, EaseOut = 0.03, Retarget = true, FromCurrentLocation = true })
	wait(0.3)
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = focusId })
	SetAnimation({ Name = "MelTalkPensive01", DestinationId = CurrentRun.Hero.ObjectId })

	if panDuration > 1.0 then
		wait( panDuration - 1.0 )
	end

	if not saleData.SkipFade then
		CreateAnimation({ Name = saleData.ItemPreActivationVfx or "CosmeticUnlockFx", DestinationId = focusId })

		wait( (saleData.PanDuration or 1.0) + (saleData.PreActivationHoldDuration or 0.5) )
		FullScreenFadeOutAnimation()
	end
	PlaySound({ Name = saleData.ItemPreActivationSound or "/Leftovers/Menu Sounds/EmoteExcitement" })
	if not saleData.SkipFade then
		wait( 0.5 )
	end
end

function PostActivateCosmeticPresentation( button, saleData, args )

	if not saleData.SkipFade then
		FullScreenFadeInAnimation()
	end

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

function CosmeticCritterRandomizeAnimations( source )
	local ids = GetIds({ Names = source.ActivateGroups })
	for _, id in ipairs( ids ) do
		local critter = MapState.ActiveObstacles[id]
		if critter ~= nil then
			local animations = critter.CosmeticAnimations or critter.AmbientAnimations
			if animations ~= nil then
				critter.ChosenCosmeticAnimation = GetRandomValue( animations )
				SetAnimation({ DestinationId = id, Name = critter.ChosenCosmeticAnimation })
			end
		end
	end
end

function CosmeticDogsApproachPresentation( source, args )

	local ids = GetIds({ Names = WorldUpgradeData.Cosmetic_AmbientDogs.ActivateGroups })
	for _, id in ipairs( ids ) do
		local critter = MapState.ActiveObstacles[id]
		if critter ~= nil and critter.ChosenCosmeticAnimation ~= nil then
			SetAnimation({ DestinationId = id, Name = critter.ChosenCosmeticAnimation.."_Greet" })
		end
		wait( RandomFloat( args.MinDelayBetweenDogs, args.MaxDelayBetweenDogs ) )
	end
	wait( args.Cooldown )

end
