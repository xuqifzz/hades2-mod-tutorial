function BadgePurchasePresentation( usee, badgeData )

	DebugPrint({ Text = "Badge level = "..GameState.BadgeRank })

	local args = { WaitTime = 0.5 }
	thread( PowerWordPresentationWorld )

	StopAnimation({ Name = badgeData.Icon, DestinationId = usee.ObjectId })
	DestroyTextBox({ Id = usee.ObjectId })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })

	FreezePlayerUnit( "BadgePurchasePresentation" )
	AddInputBlock({ Name = "BadgePurchasePresentation" })
	--ZeroMouseTether( "BadgePurchasePresentation" )

	MapState.CosmeticPresentationActive = true

	local ghostAdminId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "BartenderGhost01", Distance = 400 })
	PlaySound({ Name = "/SFX/GhostEvaporate", Id = ghostAdminId, Delay = 1.5 })

	--PlaySound({ Name = "/SFX/Menu Sounds/ContractorItemPurchase" }) -- moved to BadgeResourceSpendPresentation

	-- preactivate presentation
	--local cameraTarget = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -200 })
	--PanCamera({ Id = cameraTarget, Duration = badgeData.PanDuration or 1.0, Retarget = true, FromCurrentLocation = true })

	if badgeData.RevealGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[badgeData.RevealGlobalVoiceLines] )
		wait(0.25)
	elseif badgeData.RevealVoiceLines then
		thread( PlayVoiceLines, badgeData.RevealVoiceLines )
	end

	if badgeData.UseUnlockText then
		thread( DisplayInfoBanner, usee, {
			TitleText = badgeData.UnlockTextId or "BadgePurchased",
			SubtitleText = badgeData.Name,
			Icon = badgeData.Icon,
			TextRevealSound = "/SFX/Menu Sounds/WeaponUnlockBoom",
			Delay = 1.2,
			Duration = 3.5,
			FontScale = 1,
			IconMoveSpeed = 0.00001,
			IconScale = badgeData.BadgeIconScale or 0.4,
			IconOffsetX = badgeData.BadgeIconOffsetX or 0,
			IconOffsetY = badgeData.BadgeIconOffsetY or 14,
		})
	end
	if badgeData.SetPlayerAnimation then
		SetAnimation({ Name = badgeData.SetPlayerAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end

	wait( badgeData.PreActivationHoldDuration or 0.5 )

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

	--wait(0.25)

	--PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0 })
	wait(0.75)
	RemoveInputBlock({ Name = "BadgePurchasePresentation" })
	MapState.CosmeticPresentationActive = false
	UnfreezePlayerUnit( "BadgePurchasePresentation" )
	--UnzeroMouseTether( "BadgePurchasePresentation" )

	thread( PlayEmote, { TargetId = usee.ObjectId, AnimationName = usee.MadeSaleEmote, OffsetZ = usee.EmoteOffsetZ } )

end

function BadgeResourceSpendPresentation( usee, resourceCost )
	PlayInteractAnimation( usee.ObjectId, { SkipInputBlock = true })
	local resourceData = ResourceData[resourceCost.Name]
	PlaySound({ Name = resourceData.SpendSound or "/SFX/Menu Sounds/ContractorItemPurchase" })
	wait(0.35)
end

function BadgeCannotAffordPresentation( usee, nextBadgeData )

	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	Shake({ Id = usee.ObjectId, Distance = 1, Speed = 100, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	--thread( PlayVoiceLines,  GlobalVoiceLines.CannotAffordBadgeVoiceLines, true )
	if CheckCooldown( "FailedToBuyBadge", 4.0 ) then
		thread( PlayEmote, { TargetId = usee.ObjectId, AnimationName = usee.NoSaleEmote, OffsetZ = usee.EmoteOffsetZ, Delay = 0.4 } )
	end
	ModifyTextBox({ Id = usee.ObjectId, ColorTarget = Color.GhostWhite, ScaleTarget = 1.05 })
	wait( 0.1 )
	ModifyTextBox({ Id = usee.ObjectId, ColorTarget = Color.Red, ColorDuration = 0.2, ScaleTarget = 1.0 })

end