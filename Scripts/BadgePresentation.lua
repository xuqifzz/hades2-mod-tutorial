function BadgePurchasePresentation( usee, badgeData )

	DebugPrint({ Text = "GameState.BadgeRank = "..GameState.BadgeRank })

	local args = { WaitTime = 0.5 }

	StopAnimation({ Name = badgeData.Icon, DestinationId = usee.ObjectId })
	DestroyTextBox({ Id = usee.ObjectId })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })

	FreezePlayerUnit( "BadgePurchasePresentation" )
	AddInputBlock({ Name = "BadgePurchasePresentation" })
	--ZeroMouseTether( "BadgePurchasePresentation" )

	MapState.CosmeticPresentationActive = true

	local ghostAdminId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "BartenderGhost01", Distance = 400 })
	PlaySound({ Name = "/SFX/GhostEvaporate", Id = ghostAdminId, Delay = 1.5 })

	thread( PostRevealTavernaPresentation )

	if badgeData.RevealGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[badgeData.RevealGlobalVoiceLines] )
		wait(0.25)
	elseif badgeData.RevealVoiceLines then
		thread( PlayVoiceLines, badgeData.RevealVoiceLines )
	end

	if badgeData.UseUnlockText then
		thread( DisplayInfoBanner, usee, {
			TitleText = badgeData.UnlockTextId or "BadgeSeller_Purchase",
			SubtitleText = badgeData.Name,
			TextOffsetY = 5,
			SubtitleOffsetY = 100,
			Icon = badgeData.Icon,
			TextRevealSound = "/SFX/Menu Sounds/WeaponUnlockBoom",
			Delay = 1.2,
			Duration = 3.5,
			FontScale = 1,
			IconMoveSpeed = 0.00001,
			IconScale = .58,
			IconOffsetX = badgeData.BadgeIconOffsetX,
			IconOffsetY = 25,
			AnimationName = "LocationBackingIrisSmallIn",
			AnimationOutName = "LocationBackingIrisSmallOut",
			AdditionalAnimation = "GodHoodRays",
		})
	end

	if badgeData.SetPlayerAnimation then
		SetAnimation({ Name = badgeData.SetPlayerAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end

	wait( badgeData.PreActivationHoldDuration or 0.5 )

	thread( PowerWordPresentationWorld )

	wait(1.0)

	if badgeData.ItemPreActivationVfx then
		CreateAnimation({ Name = badgeData.ItemPreActivationVfx, DestinationId = id })
	end

	wait(0.5)

	if badgeData.UseItemActivationVfx then
		CreateAnimation({ Name = badgeData.ItemActivationVfx or "CosmeticUnlockFx", DestinationId = badgeData.ItemActivationVfxId or id, OffsetY = badgeData.ItemActivationVfxOffsetY or 0 })
	end

	if badgeData.RevealReactionGlobalVoiceLines and not badgeData.SkipRevealReactionGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[badgeData.RevealReactionGlobalVoiceLines] )
	elseif badgeData.RevealReactionVoiceLines then
		thread ( PlayVoiceLines, badgeData.RevealReactionVoiceLines, true )
	end

	wait( badgeData.PostActivationHoldDuration or 0.5 )

	if badgeData.EndPlayerAnimation then
		SetAnimation({ Name = badgeData.EndPlayerAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end

	--PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0 })
	wait(0.35)
	RemoveInputBlock({ Name = "BadgePurchasePresentation" })
	MapState.CosmeticPresentationActive = false
	UnfreezePlayerUnit( "BadgePurchasePresentation" )
	--UnzeroMouseTether( "BadgePurchasePresentation" )

	thread( PlayEmote, { TargetId = usee.ObjectId, AnimationName = usee.MadeSaleEmote, OffsetZ = usee.EmoteOffsetZ } )

end

function BadgeResourceSpendPresentation( usee, resourceCost )
	PlayInteractAnimation( usee.ObjectId, { SkipInputBlock = true } )
	--local resourceData = ResourceData[resourceCost.Name]
	PlaySound({ Name = "/SFX/Menu Sounds/ContractorItemPurchase" })
	wait(0.35)
end

function BadgeCannotAffordPresentation( usee )
	CantAffordPresentation( usee )
end