function ShrinePointSpendPresentation( screen, spend, buttonId )
	CreateAnimation({ Name = "ShrinePointTransactionHighlight-Refund", GroupName = "Overlay", DestinationId = ScreenAnchors.ShrinePointIconId, OffsetX = -194, OffsetY = -88 })
	CreateAnimationsBetween({ Animation = "ShrinePointRefundStreak", DestinationId = ScreenAnchors.ShrinePointIconId, Id = buttonId,
		Stretch = true,
		WorldSpace = false,
		TargetXOffset = 50,
		--TargetYOffset = -88,
	})
end

function ShrinePointRefundPresentation( screen, refund, buttonId )
	CreateAnimation({ Name = "ShrinePointTransactionHighlight", DestinationId = buttonId, GroupName = "Overlay" })
	CreateAnimationsBetween({ Animation = "ShrinePointRefundStreakReverse", DestinationId = ScreenAnchors.ShrinePointIconId, Id = buttonId,
		Stretch = true,
		WorldSpace = false,
		TargetXOffset = 50,
		--TargetYOffset = -132,
	})
end

function ShrineScreenUpdateActivePoints( screen, button, args )
	args = args or {}
	local activeShrinePoints = GetTotalSpentShrinePoints()
	if activeShrinePoints >= 1 then
		SetAlpha({ Id = screen.Components.ResetAllButton.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = screen.Components.ResetAllButton.Id, Fraction = 0.0, Duration = 0.2 })
	end
	--ModifyTextBox({ Id = screen.Components.SpentShrinePoints.Id, LuaKey = "TempTextData", LuaValue = { CurrentAmount = activeShrinePoints } })

	local prevActiveBounty = screen.ActiveBounty
	screen.ActiveBounty = nil
	screen.HasBountyForWeapon = false
	local highestExcessShrinePoints = 0
	local maxBountiesShown = screen.MaxBountiesAvailable
	for i = 1, maxBountiesShown do
		local key = "BountyAvailable"..i
		--local button = screen.Components[key]
		local shrinePointItem = screen.Components[key.."ShrinePoints"]
		if shrinePointItem ~= nil then
			local backing = screen.Components[key.."Backing"]
			local weaponItem = screen.Components[key.."Weapon"]
			--local weaponLink = screen.Components[key.."WeaponLink"]
			local targetItem = screen.Components[key.."Target"]
			--local targetLink = screen.Components[key.."TargetLink"]
			local bountyData = shrinePointItem.BountyData
			if shrinePointItem.MatchedWeapon then
				screen.HasBountyForWeapon = true
			end
			if activeShrinePoints >= shrinePointItem.RequiredShrinePoints then
				ModifyTextBox({ Id = shrinePointItem.Id, ColorTarget = screen.BountyActiveColor })
			else
				ModifyTextBox({ Id = shrinePointItem.Id, ColorTarget = screen.BountyInactiveColor })
			end
			if shrinePointItem.MatchedWeapon then
				SetColor({ Id = weaponItem.Id, Color = screen.BountyActiveColor, Duration = args.Duration or 0.3 })
				--SetColor({ Id = weaponLink.Id, Color = screen.BountyActiveColor, Duration = args.Duration or 0.3 })
				--SetAlpha({ Id = weaponLink.Id, Fraction = 1.0, Duration = args.Duration or 0.3 })
			else
				SetColor({ Id = weaponItem.Id, Color = screen.BountyInactiveColor, Duration = args.Duration or 0.3 })
				--SetColor({ Id = weaponLink.Id, Color = screen.BountyInactiveColor, Duration = args.Duration or 0.3 })
				--SetAlpha({ Id = weaponLink.Id, Fraction = 0.0, Duration = args.Duration or 0.3 })
			end
			if activeShrinePoints >= shrinePointItem.RequiredShrinePoints and shrinePointItem.MatchedWeapon then
				SetColor({ Id = targetItem.Id, Color = screen.BountyActiveColor, Duration = args.Duration or 0.3 })
				--SetColor({ Id = targetLink.Id, Color = screen.BountyActiveColor, Duration = args.Duration or 0.3 })
				--SetAlpha({ Id = targetLink.Id, Fraction = 1.0, Duration = args.Duration or 0.3 })
				screen.ActiveBounty = bountyData.Name
				local excessShrinePoints = activeShrinePoints - shrinePointItem.RequiredShrinePoints
				if excessShrinePoints > highestExcessShrinePoints then
					highestExcessShrinePoints = excessShrinePoints
				end
				SetAnimation({ DestinationId = backing.Id, Name = "GUI\\Screens\\Shrine\\TestamentActive" })
				if prevActiveBounty ~= screen.ActiveBounty then
					PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash2", Id = backing })
				end
			else
				SetColor({ Id = targetItem.Id, Color = screen.BountyInactiveColor, Duration = args.Duration or 0.3 })
				--SetColor({ Id = targetLink.Id, Color = screen.BountyInactiveColor, Duration = args.Duration or 0.3 })
				--SetAlpha({ Id = targetLink.Id, Fraction = 0.0, Duration = args.Duration or 0.3 })
				SetAnimation({ DestinationId = backing.Id, Name = "GUI\\Screens\\Shrine\\Testament" })
			end
		end
	end
	--DebugPrint({ Text = "highestExcessShrinePoints = "..highestExcessShrinePoints })

	local text = nil
	if activeShrinePoints == GetMaxShrinePoints() then
		text = screen.MaxShrinePointsText
	elseif screen.HasBountyForWeapon then
		if screen.ActiveBounty ~= nil then
			if highestExcessShrinePoints == 0 then
				text = screen.ExactShrinePointsText
			else
				local highestExcessAmount = 0
				for excessAmount, excessText in pairs( screen.ExcessShrinePointsText ) do
					if highestExcessShrinePoints >= excessAmount and excessAmount > highestExcessAmount then
						text = excessText
						highestExcessAmount = excessAmount
					end
				end
			end
		else
			text = screen.BelowShrinePointsText
		end
	else
		text = screen.NoBountyAvailableText
	end
	if GameState.SpentShrinePointsCache == 0 then
		text = screen.ZeroShrinePointsText
	end
	ModifyTextBox({ Id = screen.Components.ThermometerText.Id, Text = text })

end

function ShrineScreenMouseOverItem( button )

	GenericMouseOverPresentation( button )

	local screen = button.Screen
	local components = screen.Components
	screen.SelectedItem = button

	SetScale({ Id = button.Id, Fraction = screen.IconMouseOverScale, Duration = 0.1, EaseIn = 0.9, EaseOut = 1.0, SkipGeometryUpdate = true })
	SetAlpha({ Id = button.Highlight.Id, Fraction = 1.0, Duration = 0.1 })

	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 1.0, Duration = 0.2 })
	SetAnimation({ DestinationId = components.InfoBoxBacking.Id, Name = "ShrineSlotBase" })

	if button.TraitData ~= nil then
		SetAnimation({ Name = button.TraitData.Icon, DestinationId = components.InfoBoxIcon.Id })
		SetAlpha({ Id = components.InfoBoxIcon.Id, Fraction = 1.0, Duration = 0.2 })
		SetAlpha({ Id = components.InfoBoxFrame.Id, Fraction = 1.0, Duration = 0.2 })
	end

	local text = button.Data.Name
	local upgradedRarity = nil
	local metaUpgradeData = button.Data
	
	local rarityLevel = GetNumShrineUpgrades( text )
	local rarityName = TraitRarityData.WeaponRarityUpgradeOrder[rarityLevel]
	local raritText = TraitRarityData.ShrineRarityText[rarityLevel]
	local rarityColor = Color.White
	if rarityName ~= nil then
		rarityColor = Color["BoonPatch"..rarityName]
	else
		rarityColor = screen.InactiveColor
	end
	SetAlpha({ Id = components.InfoBoxRarity.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxRarity.Id,
		Text = raritText,
		FadeTarget = 1.0,
		Color = rarityColor,
	})

	ModifyTextBox({ Id = components.InfoBoxName.Id,
		Text = text,
		FadeTarget = 1.0,
		LuaKey = "TooltipData",
		LuaValue = button.Data,
		Color = rarityColor,
	})
	
	SetAlpha({ Id = components.InfoBoxDescription.Id, Fraction = 1.0, Duration = 0.2 })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id,
		Text = text,
		UseDescription = true,
		FadeTarget = 1.0,
		LuaKey = "TooltipData",
		LuaValue = metaUpgradeData,
	})

	if button.TraitData then
		local traitData = button.TraitData
		local statLine = traitData.StatLines[1]
		ModifyTextBox({ Id = components.InfoBoxStatLineLeft.Id, Text = statLine, LuaKey = "TooltipData", LuaValue = metaUpgradeData, FadeTarget = 1.0 })
		ModifyTextBox({ Id = components.InfoBoxStatLineRight.Id, Text = statLine, UseDescription = true, LuaKey = "TooltipData", LuaValue = metaUpgradeData, FadeTarget = 1.0})
		ModifyTextBox({ Id = components.InfoBoxFlavor.Id, Text = traitData.FlavorText or " ", FadeTarget = 1.0 })
	elseif button.Data and button.Data.FlavorText then
		ModifyTextBox({ Id = components.InfoBoxFlavor.Id, Text = button.Data.FlavorText or " ", FadeTarget = 1.0 })
	end

	ShrineScreenUpdateRankActions( button )

	if rarityLevel == 0 then
		ModifyFormatContainer({ Name = "ShrinePenaltyFormat", Color = screen.InactiveVariableColor })
	else
		ModifyFormatContainer({ Name = "ShrinePenaltyFormat", Color = screen.ActiveVariableColor })
	end

	--local newButtonKey = "NewIcon"..button.Index
	--SetAlpha({ Id = button.NewButtonId, Fraction = 0, Duration = 0.2 })
	GameState.WorldUpgradesViewed[button.Data.Name] = true
	--UpdateWeaponShopInteractionText( button.Screen, button )
end

function ShrineScreenMouseOffItem( button )

	local screen = button.Screen
	local components = screen.Components
	screen.SelectedItem = nil

	SetScale({ Id = button.Id, Fraction = screen.IconScale, Duration = 0.1, EaseIn = 0.9, EaseOut = 1.0, SkipGeometryUpdate = true })
	SetAlpha({ Id = button.Highlight.Id, Fraction = 0.0, Duration = 0.1 })

	ModifyTextBox({ Id = components.InfoBoxName.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxRarity.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxDescription.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxStatLineLeft.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxStatLineRight.Id, FadeTarget = 0.0, })
	ModifyTextBox({ Id = components.InfoBoxFlavor.Id, FadeTarget = 0.0, })

	--SetAlpha({ Id = components.ResourceCostBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxBacking.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxIcon.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.InfoBoxFrame.Id, Fraction = 0.0, Duration = 0.2 })

	SetAlpha({ Id = components.RankUp.Id, Fraction = 0.0, Duration = 0.2 })
	SetAlpha({ Id = components.RankDown.Id, Fraction = 0.0, Duration = 0.2 })

end

function ShrineScreenRankDownPresentation( screen, button )
	local components = screen.Components
	ShrineScreenUpdateItems( screen, button )
	ShrineScreenUpdateActivePoints( screen )
	ShrineScreenMouseOverItem( button )
	ShrineScreenUpdateNextRankText( button )
	ShrineScreenUpdateRankActions( button )
	PlaySound({ Name = screen.ToggleOnSound, Id = button.Id })
end

function ShrineScreenAlreadyAtMinPresentation( screen, button )
	thread( PulseText, { Id = button.Id, ScaleTarget = 1.3, ScaleDuration = 0.1, HoldDuration = 0.15, PulseBias = 0.1 } )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = button.Id })
end

function ShrineScreenRankUpPresentation( screen, button )
	local components = screen.Components
	ShrineScreenUpdateItems( screen, button )
	ShrineScreenUpdateActivePoints( screen )
	ShrineScreenMouseOverItem( button )
	ShrineScreenUpdateNextRankText( button )
	ShrineScreenUpdateRankActions( button )
	thread( PlayVoiceLines, button.Data.SelectedVoiceLines or GlobalVoiceLines.ShrineUpgradePickedVoiceLines, true )
	PlaySound({ Name = screen.ToggleOffSound, Id = button.Id })
end

function ShrineScreenAlreadyAtMaxPresentation( screen, button )
	--thread( PulseText, { Id = button.Id, Color = Color.Red, OriginalColor = screen.NextRankMaxColor, ScaleTarget = 1.3, ScaleDuration = 0.1, HoldDuration = 0.15, PulseBias = 0.1 } )
	Flash({ Id = button.Backing.Id, Speed = 1.5, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = button.Id })
	if CheckCountInWindow( "ShrineUpgradeMaxed", 2.0, 2 ) then
		thread( PlayVoiceLines, GlobalVoiceLines.ShrineUpgradeMaxedVoiceLines, true )
	end

end

function ShrineScreenUpdateRankActions( button )
	local components = button.Screen.Components
	local upgradeData = button.Data
	local rank = GetNumShrineUpgrades( upgradeData.Name )
	if rank < TableLength( upgradeData.Ranks ) then
		local text = components.RankUp.Data.AltText
		if rank >= 1 then
			text = components.RankUp.Data.Text
		end
		ModifyTextBox({ Id = components.RankUp.Id, Text = text })
		SetAlpha({ Id = components.RankUp.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.RankUp.Id, Fraction = 0.0, Duration = 0.2 })
	end
	if rank > 0 then
		SetAlpha({ Id = components.RankDown.Id, Fraction = 1.0, Duration = 0.2 })
	else
		SetAlpha({ Id = components.RankDown.Id, Fraction = 0.0, Duration = 0.2 })
	end
end

function ShrineScreenUpdateNextRankText( button )
	local screen = button.Screen
	--local color = button.Screen.NextRankMaxColor
	local upgradeData = button.Data
	local rank = GetNumShrineUpgrades( upgradeData.Name )
	if rank < TableLength( upgradeData.Ranks ) then
		upgradeData.NextRankPoints = upgradeData.Ranks[rank + 1].Points
		--color = Color.White
		ModifyTextBox({ Id = button.Id, LuaKey = "TempTextData", LuaValue = upgradeData, FadeTarget = 1.0 })
	else
		ModifyTextBox({ Id = button.Id, LuaKey = "TempTextData", LuaValue = upgradeData, FadeTarget = 0.0 })
	end
	
end

function ShrineScreenUpdateItems( screen )
	local components = screen.Components
	for index = 1, screen.NumItems do
		local backing = components["ItemBacking"..index]
		local nextRankBacking = components["NextRankBacking"..index]
		local item = components["ItemButton"..index]
		local rank = GetNumShrineUpgrades( item.Data.Name )
		if rank <= 0 then
			SetAnimation({ DestinationId = backing.Id, Name = "GUI\\Screens\\Shrine\\PactInactive" })
			SetAnimation({ DestinationId = nextRankBacking.Id, Name = "GUI\\Screens\\Shrine\\PactBadgeInactive" })
			SetAlpha({ Id = nextRankBacking.Id, Fraction = 1.0, Duration = 0.1 })
			SetColor({ Id = item.Id, Color = screen.IconInactiveColor })
		elseif rank >= TableLength( item.Data.Ranks ) then
			SetAnimation({ DestinationId = backing.Id, Name = "GUI\\Screens\\Shrine\\PactActiveMax" })
			SetAnimation({ DestinationId = nextRankBacking.Id, Name = "GUI\\Screens\\Shrine\\PactBadgeActive" })
			SetAlpha({ Id = nextRankBacking.Id, Fraction = 0.0, Duration = 0.1 })
			SetColor({ Id = item.Id, Color = screen.IconActiveColor })
		else
			SetAnimation({ DestinationId = backing.Id, Name = "GUI\\Screens\\Shrine\\PactActive" })
			SetAnimation({ DestinationId = nextRankBacking.Id, Name = "GUI\\Screens\\Shrine\\PactBadgeActive" })
			SetAlpha({ Id = nextRankBacking.Id, Fraction = 1.0, Duration = 0.1 })
			SetColor({ Id = item.Id, Color = screen.IconActiveColor })
		end
	end
	local fraction = GetTotalSpentShrinePoints() / GetMaxShrinePoints()
	SetAnimationFrameTarget({ Name = "ShrineMeterBarFill", Fraction = fraction, DestinationId = components.ThermometerForeground.Id, Instant = false })
	ModifyTextBox({ Id = components.ActiveShrinePoints.Id, ReReadTextImmediately = true, })
	thread( PulseText, { Id = components.ActiveShrinePoints.Id, Color = Color.GreenYellow, OriginalColor = screen.NextRankMaxColor, ScaleTarget = 1.2, ScaleDuration = 0.1, HoldDuration = 0.15, PulseBias = 0.1 } )

end

function BoonSkipShrineUpgradePresentation( reward )
	CreateAnimation({ DestinationId = reward.ObjectId, Name = "CauldronSmokeSmall", OffsetZ = -230 })
	wait( 0.5 )
	-- thread( InCombatText, reward.ObjectId, "BoonSkipShrineUpgrade_CombatText", 1.0 )
end

function FirstDamageShrineUpgradePresentation( victim, attacker )
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusCriticalFire", Id = victim.ObjectId })
	wait( 0.5 )
	PlaySound({ Name = "/Leftovers/Menu Sounds/TitanToggleLong", Id = victim.ObjectId })
	--thread( InCombatText, victim.ObjectId, "FirstDamageShrineUpgrade_CombatText", 1.0 )
end

function RespawnEggCountdownTickPresentation( egg, args )
	local countdownRatio = (args.Ticks - (egg.TicksRemaining - 1)) / args.Ticks
	Shake({ Id = egg.ObjectId, Distance = 5 * countdownRatio, Speed = 500 * countdownRatio, Duration = 0.25 })
	Flash({ Id = egg.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.85 * countdownRatio, Color = Color.White, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/SaplingGrow", Id = egg.ObjectId })
end

function RespawnEggRespawnPresentation( egg, newEnemy )
	PlaySound({ Name = "/SFX/Enemy Sounds/HydraHead/HydraEggHatch", Id = egg.ObjectId })
	CreateAnimation({ Name = "RespawnEggRespawn", DestinationId = egg.ObjectId, })
	SetAlpha({ Id = egg.ObjectId, Fraction = 0.0, Duration = 0.5 })
	SetScale({ Id = egg.ObjectId, Fraction = 2.0, Duration = 0.7 })
end

function RespawnEggPickedUpPresentation( usee, args, user )	
	PlaySound({ Name = "/SFX/Enemy Sounds/HydraHead/HydraEggSpit", Id = usee.ObjectId })
	CreateAnimation({ Name = "ExorcismGhostDissipate", DestinationId = usee.ObjectId, })
end

function ShrineEliteAttributeManaDrainTickPresentation( enemy, args )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ShrineEliteManaDrain_Tick", Duration = 1.5, ShadowScale = 0.6, PreDelay = 0.1, Duration = 1.5, OffsetY = 80, LuaKey = "TempTextData", LuaValue = args } )
	DirectionHintPresentation( enemy, { Cooldown = 0.0, Delay = 0.0 } )
end

function ErisCurseAppliedPresentation( source, args )
	args = args or {}
	local erisId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Eris_01" })
	local eris = eris or ActiveEnemies[erisId]
	eris.Exiting = true

	if not args.SkipVoice then
		thread( PlayVoiceLines, eris.ExitVoiceLines, nil, eris, { IgnoreMute = true } )
	end

	local delay = 0
	if args.DelayMin ~= nil and args.DelayMax ~= nil then
		delay = RandomFloat( args.DelayMin, args.DelayMax )
	end

	AddInputBlock({ Name = "ErisCursePresentation" })

	UseableOff({ Id = eris.ObjectId })
	eris.SpecialInteractFunctionName = nil
	eris.CanReceiveGift = false

	SetAnimation({ Name = "Enemy_Eris_Hub_Toss", DestinationId = eris.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = eris.ObjectId })

	wait( delay or 2.5 )

	PlaySound({ Name = "/Leftovers/SFX/AuraCharge", Id = eris.ObjectId })

	wait( 1.0 )

	local preFountainBloom = GetBloomSettingName({ })

	HideCombatUI( "ErisCursePresentation" )
	
	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait( 0.05 )

	AdjustColorGrading({ Name = "Team03", Duration = 1.0 })
	SetAnimation({ Name = "MelinoeGetHitSurfacePenalty", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Music/Stingers/CurseSting" })

	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.85, MinFraction = 0.2, MaxFraction = 0.5, Color = Color.Purple, Duration = 1.5 })

	CreateAnimation({ Name = "PowerUpComboReady", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
	CreateAnimation({ Name = "ErisCurseFx", DestinationId = CurrentRun.Hero.ObjectId, })

	AdjustFullscreenBloom({ Name = "BlurryLight", Duration = 0.5 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.15, Duration = 2, ZoomType = "Ease" })

	Rumble({ Duration = 1.0, RightFraction = 0.17 })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 1.5 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.5 })

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteHurt", Id = CurrentRun.Hero.ObjectId, Delay = 0.8 })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteGasping", Id = CurrentRun.Hero.ObjectId, Delay = 1.1 })

	waitUnmodified( 1.25 )
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ErisCurseApplied", Duration = 1.5, ShadowScaleX = 1.2, PreDelay = 0.1, Duration = 1.5, } )
	PlaySound({ Name = "/SFX/CrappyRewardDrop", Id = CurrentRun.Hero.ObjectId })

	waitUnmodified( 0.2 )
	thread( ErisTakeOff, eris )

	waitUnmodified( 0.8 )

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 1. })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.0 })
	AdjustFullscreenBloom({ Name = preFountainBloom, Duration = 1.0 })
	AdjustColorGrading({ Name = "Off", Duration = 1.0 })

	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 1, ZoomType = "Ease" })

	wait( 0.4 )

	if eris.GiveRandomConsumables ~= nil then
		local giveConsumablesArgs = ShallowCopyTable( eris.GiveRandomConsumables )
		giveConsumablesArgs.DestinationId = eris.ObjectId
		giveConsumablesArgs.AddUnthreadedOnUseEvent =
		{
			FunctionName = "ErisCurseRewardTaken",
			Args = { RunNum = #GameState.RunHistory + 1 },
		}
		GiveRandomConsumables( giveConsumablesArgs )
	end

	RemoveInputBlock({ Name = "ErisCursePresentation" })
	ShowCombatUI( "ErisCursePresentation" )
end

function ErisTakeOff( eris )

	eris.Mute = true

	SetAnimation({ Name = "Enemy_Eris_HubToCombatIdle", DestinationId = eris.ObjectId, SpeedMultiplier = 2 })
	wait( 0.66 )
	SetAnimation({ Name = "Enemy_Eris_FlyUp_Start", DestinationId = eris.ObjectId })
	wait ( 0.45 )
	AdjustZLocation({ Id = eris.ObjectId, Distance = 800, Duration = 0.55 })
	wait ( 0.45 )
	SetAlpha({ Id = eris.ObjectId, Fraction = 0.0, Duration = 0.2 })
	SetUnitProperty({ DestinationId = eris.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = eris.ObjectId, Property = "CollideWithUnits", Value = false })
	SetThingProperty({ DestinationId = eris.ObjectId, Property = "StopsProjectiles", Value = false })	

end

function UpdateShrineRunDoorArrow( source, args )
	args = args or {}
	GameState.ActiveShrineBounty = nil
	local fadeDuration = 0.4
	local activeShrinePoints = GetTotalSpentShrinePoints()
	for i, bountyName in ipairs( ScreenData.Shrine.BountyOrder ) do
		local bountyData = BountyData[bountyName]
		local weaponName = nil
		local matchedWeapon = false
		local shrinePoints = nil
		if bountyData.CompleteGameStateRequirements ~= nil then
			for j, completeRequirement in ipairs( bountyData.CompleteGameStateRequirements ) do
				if completeRequirement.HasAny ~= nil then
					weaponName = completeRequirement.HasAny[1]
					if CurrentRun.Hero.Weapons[weaponName] then
						matchedWeapon = true
					end
				end
				if completeRequirement.Value ~= nil then
					shrinePoints = completeRequirement.Value
				end
			end
			if matchedWeapon and activeShrinePoints >= shrinePoints and not GameState.BountiesCompleted[bountyName] then
				if bountyData.UnlockGameStateRequirements == nil or IsGameStateEligible( CurrentRun, bountyData, bountyData.UnlockGameStateRequirements ) then		
					GameState.ActiveShrineBounty = bountyData.Name
					-- Eligible bounty	
					--DebugPrint({ Text = "bountyName = "..bountyName })
					-- Determine which door
					local shouldFlip = ScreenData.Shrine.BountyEncounterDoorFlipMap[bountyData.Encounter]
					local prevShouldFlip = SessionMapState.ShrineRunDoorFlipped or false
					if shouldFlip ~= prevShouldFlip then
						if not args.SkipPresentation then
							SetAlpha({ Id = ScreenData.Shrine.ShrineRunDoorArrowId, Fraction = 0.0, Duration = fadeDuration })
							wait( fadeDuration + 0.1 )
						end
						FlipHorizontal({ Id = ScreenData.Shrine.ShrineRunDoorArrowId })
						FlipVertical({ Id = ScreenData.Shrine.ShrineRunDoorArrowId })
					end
					SetAlpha({ Id = ScreenData.Shrine.ShrineRunDoorArrowId, Fraction = 1.0, Duration = fadeDuration })
					SessionMapState.ShrineRunDoorFlipped = shouldFlip
					return
				end
			end
		end
	end

	-- None eligible, fade out
	SetAlpha({ Id = ScreenData.Shrine.ShrineRunDoorArrowId, Fraction = 0.0, Duration = fadeDuration })

end

function BountyReadyConfirmPresentation( screen, button )
	SetAlpha({ Id = HUDScreen.Components.BountyReadyConfirm.Id, Fraction = 1.0, Duration = 0.0 })
	SetAlpha({ Id = HUDScreen.Components.BountyReadyConfirm.Id, Fraction = 1.0, Duration = 0.3 })
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCloseWithUpgrade", Id = HUDScreen.Components.BountyReadyConfirm.Id })
	wait( 2.6 )
	SetAlpha({ Id = HUDScreen.Components.BountyReadyConfirm.Id, Fraction = 0.0, Duration = 0.2 })
end

function BanUnpickedBoonPresentation( screen, upgradeButton )
	Flash({ Id = upgradeButton.Id, Speed = 4, MinFraction = 0.5, MaxFraction = 1.0, Color = Color.Red, Duration = 0.5, ExpireAfterCycle = true })
end

function BoonManaReserveShrineUpgradePresentation( source, args )
	PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "BoonManaReserveShrineUpgrade_CombatText", 1.0 )
end

function SkellyStatueUnveil( source, args )

	AddInputBlock({ Name = "SkellyStatueUnveil" })
	thread( PlayVoiceLines, source.TrophyUnlockedVoiceLines, true, source )
	wait( 1.0 )
	LockCamera({ Id = args.StatueId, OffsetY = -300, Duration = 1.0, EaseIn = 1.0 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	wait( 1.7 )

	FullScreenFadeOutAnimation()
	wait( 0.5 )
	SetAnimation({ DestinationId = ScreenAnchors.DialogueBackgroundId, Name = "DialogueBackgroundOut" })
	SetAlpha({ Id = args.DrapeId, Fraction = 0.0, Duration = 1.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", Id = args.StatueId })
	wait( 0.3 )
	Destroy({ Id = ScreenAnchors.DialogueBackgroundId })
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter", Id = args.StatueId })
	wait( 0.2 )
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter", Id = args.StatueId })
	wait( 3.0 )
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	FullScreenFadeInAnimation()
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })

	thread( CrowdReactionPresentationEventSource, source, args )

	wait( 0.5 )

	DisplayInfoBanner( nil,
		{
			Text = args.Text or "SkellyStatue_Unlocked",
			SubtitleText = args.Subtitle,
			Delay = 0.75,
			TextColor = Color.Turquoise,
			Layer = "Overlay",
			FontScale = 0.9,
			AnimationName = "LocationBackingIrisGenericIn",
			AnimationOutName = "LocationBackingIrisGenericOut",
			Duration = 3.95
		}
	)
	CreateDialogueBackground()

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0, EaseIn = 1.0 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	wait( 1.0 )
	RemoveInputBlock({ Name = "SkellyStatueUnveil" })
	local statue = MapState.ActiveObstacles[args.StatueId]
	CheckSetupFunction( statue, "OverwriteSelf" )

end

function SkellyStatueAdmire( source, args )

	UseableOff({ Ids = { 589801, 589803, 589804, } })
	AddInputBlock({ Name = "AdmiringStatue" })
	FreezePlayerUnit("AdmiringStatue")

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.TrophyAdmirationVoiceLines, true )

	local unequipAnimation = GetEquippedWeaponValue("UnequipAnimation") or "MelinoeIdleWeaponless"
	SetAnimation({ Name = unequipAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	wait( 0.6 )
	SetAnimation({ Name = "MelTalkPensive01", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 2.0 )
	SetAnimation({ Name = "MelTalkPensive01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId })

	UnfreezePlayerUnit("AdmiringStatue")
	RemoveInputBlock({ Name = "AdmiringStatue" })

	wait( 8.0, RoomThreadName )
	UseableOn({ Ids = { 589801, 589803, 589804, } })

end

function StatueUnlockedPresentation( source, args, screen, line )
	wait(1.35)

	DisplayInfoBanner( nil,
		{
			Text = args.Text or "SkellyStatue_Unlocked",
			SubtitleText = args.Subtitle,
			Delay = 0.75,
			TextColor = Color.Turquoise,
			Layer = "Overlay",
			FontScale = 0.9,
			AnimationName = "LocationBackingIrisGenericIn",
			AnimationOutName = "LocationBackingIrisGenericOut",
			Duration = 3.95
		}
	)
	-- CheckAchievement( { Name = "AchBronzeSkellyTrophy" } )
	-- CheckAchievement( { Name = "AchSilverSkellyTrophy" } )
end

function StatueHitPresentation( source, triggerArgs, args )
	Shake({ Id = source.ObjectId, Distance = 1, Speed = 100, Duration = 0.15, })
	Shake({ Id = args.DrapeId, Distance = 1, Speed = 100, Duration = 0.15, })
	thread( PlayVoiceLines, GlobalVoiceLines.TrophyAttackReactionVoiceLines, true, source )
end