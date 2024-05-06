function InitializeGiftData()
	GameState.Gift = {}
	for key, value in pairs(GiftData) do
		GameState.Gift[key] = {}
		GameState.Gift[key].Value = GiftData[key].Value
	end
end

OnControlPressed{ "Gift",
	function( triggerArgs )
		local target = triggerArgs.UseTarget
		if target == nil then
			return
		end

		if not IsInputAllowed({}) then
			return
		end

		if CanReceiveGift( target ) then
			if target.MetaConversionEligible then
				UseableOff({ Id = target.ObjectId })
				target.MetaConversionEligible = false
				ConvertMetaRewardPresentation( target )
				local trait = GetHeroTrait("MetaToRunMetaUpgrade")
				if trait and trait.MetaConversionUses then
					trait.MetaConversionUses = trait.MetaConversionUses - 1
				end
				CurrentRun.CurrentRoom.ChosenRewardType = ChooseRoomReward( CurrentRun, CurrentRun.CurrentRoom, "RunProgress", { { RewardType = "Devotion" }}, { IgnoreForcedReward = true } )
				local previouslyRequired = false
				if MapState.RoomRequiredObjects[target.ObjectId] then
					MapState.RoomRequiredObjects[target.ObjectId] = nil
					previouslyRequired = true
				end
				local newReward = SpawnRoomReward( room, { SpawnRewardOnId = target.ObjectId ,RewardOverride = CurrentRun.CurrentRoom.ChosenRewardType })
				if previouslyRequired and newReward then
					MapState.RoomRequiredObjects[newReward.ObjectId] = newReward
				end
				HideUseButton( target.ObjectId, target )
				Destroy({ Id = target.ObjectId })
			else
				SelectGift( target )
			end
		end
	end
}

OnControlPressed{ "Reroll",
	function( triggerArgs )
		local target = triggerArgs.UseTarget
		if target == nil then
			return
		end

		if not IsInputAllowed({}) then
			return
		end

		if target.ReadyToUse then
			if target.CanBeRerolled then
				AttemptReroll( CurrentRun, target )
				return
			elseif CurrentRun.NumRerolls > 0 and target.RerollFunctionName ~= nil and HasHeroTraitValue( "AllowDoorReroll" ) then
				CannotRerollPresentation( run, target )
				return
			end
		end
	end
}

OnControlPressed{ "SpecialInteract",
	function( triggerArgs )

		if not IsEmpty( ActiveScreens ) then
			return
		end

		local target = triggerArgs.UseTarget
		if target ~= nil and CanSpecialInteract( target ) then
			GameState.SpecialInteractRecord[target.Name] = (GameState.SpecialInteractRecord[target.Name] or 0) + 1
			CurrentRun.SpecialInteractRecord[target.Name] = (CurrentRun.SpecialInteractRecord[target.Name] or 0) + 1
			TriggerCooldown( target.Name..target.ObjectId )
			CallFunctionName( target.SpecialInteractFunctionName, target )
		end

	end
}

function SelectGift( target )
	if target.PreSelectGiftFunctionName ~= nil then
		CallFunctionName( target.PreSelectGiftFunctionName, target )
	end
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })
	OpenInventoryScreen( { GiftTarget = target, DefaultCategoryIndex = target.GiftCategoryIndex or 3, CategoryLocked = true } )
end

Using "GiftNPC"
function GiveGift( target, resourceName, resourceQuantity, textLines )

	local name = GetGenusName( target )

	AddTimerBlock( CurrentRun, "Gifting" )
	AddInputBlock({ Name = "Gifting" })
	SetPlayerInvulnerable( "Gift" )
	target.ReceivingGift = true

	HideUseButton( target.ObjectId, target )
	FreezePlayerUnit( "Gift" )

	thread( MarkObjectiveComplete, "GiftPrompt" )

	local spending = {}
	spending[resourceName] = resourceQuantity

	-- Pay the cost
	SpendResources( spending, name, { SkipUpdateResourceUI = true, ShadowAnimName = "InCombatTextShadow_GiftBacking", } )

	for resourceName, resourceAmount in pairs( spending ) do
		-- Total gift amounts
		CurrentRun.GiftResourceRecord[resourceName] = (CurrentRun.GiftResourceRecord[resourceName] or 0) + resourceAmount
		GameState.GiftResourceRecord[resourceName] = (GameState.GiftResourceRecord[resourceName] or 0) + resourceAmount
		-- Gift amounts per character
		CurrentRun.GiftRecord[name] = CurrentRun.GiftRecord[name] or {}
		CurrentRun.GiftRecord[name][resourceName] = (CurrentRun.GiftRecord[name][resourceName] or 0) + resourceAmount
		GameState.GiftRecord[name] = GameState.GiftRecord[name] or {}
		GameState.GiftRecord[name][resourceName] = (GameState.GiftRecord[name][resourceName] or 0) + resourceAmount
		-- Gift order per character
		table.insert( CurrentRun.GiftRecord[name], resourceName )
		table.insert( GameState.GiftRecord[name], resourceName )
	end

	target.GiftedThisRun = true
	RecordMapState( (CurrentHubRoom or CurrentRun.CurrentRoom).Name, target.ObjectId, "GiftedThisRun", target.GiftedThisRun )

	ReceivedGiftPresentation( target, "GiftNPC" )
	RemoveInputBlock({ Name = "Gifting" })
	
	if target.GiftFunctionName ~= nil then
		CallFunctionName( target.GiftFunctionName, target, target.GiftFunctionArgs, resourceName )	
	else
		-- Find a conversation with the chosen cost (or use the one previously chosen during resource selection)
		textLines = textLines or GetRandomEligibleTextLines( target, target.GiftTextLineSets, GetNarrativeDataValue( target, "GiftTextLinePriorities" ), { Spending = spending } )
		-- Have the conversation - already determined eligibility above and now resources are spent
		PlayTextLines( target, textLines, { IgnoreRequirements = true } )
		if textLines and textLines.OnGiftTrack and not textLines.SkipGiftPresentationPost then
			ReceivedGiftPresentationPost( target )
		end

		SelectCodexEntry( name )

		CheckCodexUnlock( "OlympianGods", name )
		CheckCodexUnlock( "ChthonicGods", name )
		CheckCodexUnlock( "OtherDenizens", name )
		CheckCodexUnlock( "Familiars", name )

		SetAvailableUseText( target )

		if target.NextInteractLines and not target.StatusAnimation then
			SetStatusAnimationFromTextLines( target, target.NextInteractLines )
		end

		local giftData = GiftData[name]
		if giftData ~= nil then
			for giftLevel, giftLevelData in ipairs( giftData ) do
				if not GameState.GiftPresentation[giftLevelData.Gift] and IsGameStateEligible( CurrentRun, giftLevelData, giftLevelData.GameStateRequirements ) then
					GameState.GiftPresentation[giftLevelData.Gift] = true
					GameState.NewKeepsakeItem[giftLevelData.Gift] = true
					wait( 0.65, RoomThreadName )
					PlayerReceivedGiftPresentation( target, giftLevelData.Gift )
					CheckAchievement( { Name = "AchFoundKeepsakes" } )
					break
				end
			end
		end
	end

	SetPlayerVulnerable( "Gift" )
	UnfreezePlayerUnit( "Gift" )
	RemoveTimerBlock( CurrentRun, "Gifting" )
	ShowCombatUI( "GiveSelectedGift" )
	target.ReceivingGift = false

end

function GetGiftLevel( npcName )
	if GameState.Gift[npcName] == nil then
		return 0
	end

	return GameState.Gift[npcName].Value
end

function CanReceiveGift( target )
	if not target then
		return false
	end
	if GetTotalHeroTraitValue( "MetaConversionUses" ) > 0 and target.MetaConversionEligible and not HasResourceCost(target.ResourceCosts) then
		return true
	end
	
	if not target.CanReceiveGift then
		return false
	end

	local name = GetGenusName( target )
	if not IsEmpty( CurrentRun.GiftRecord[name] ) and target.UnlimitedGifts == nil then
		return false
	end

	if target.GiftGameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, target, target.GiftGameStateRequirements ) then
		return false
	end

	if target.NextInteractLines ~= nil and target.NextInteractLines.InitialGiftableOffSource ~= nil then
		return false
	end
	
	if target.InteractTextLineSets ~= nil then
		for k, textLineSet in pairs( target.InteractTextLineSets ) do
			if CurrentRun.TextLinesRecord[textLineSet.Name] and textLineSet.GiftableOffSource then
				return false
			end
		end
	end

	local hasEligibleTextLines = false
	if target.GiftTextLineSets ~= nil then
		for textLinesName, textLines in pairs( target.GiftTextLineSets ) do
			if textLines.Cost == nil then
				DebugAssert({ Condition = false, Text = "GiftTextLines have no Cost: "..textLines.Name, Owner = "Greg" })
			end
			if CurrentRun.TextLinesRecord[textLines.Name] and textLines.GiftableOffSource then
				return false
			end
			if not hasEligibleTextLines and IsTextLineEligible( CurrentRun, target, textLines ) then
				hasEligibleTextLines = true
			end
		end
	end

	if target.GiftOncePerRun and CurrentRun.GiftRecord[target.Name] then
		return false
	end

	if target.UnlimitedGifts ~= nil then
		for resourceName, value in pairs( target.UnlimitedGifts ) do
			if HasResource( resourceName, 1 ) then
				return true
			end
		end
	end

	return hasEligibleTextLines
end

function CanSpecialInteract( source )
	if source.ResourceCosts ~= nil and HasResourceCost( source.ResourceCosts ) then
		return false
	end
	if source.SpecialInteractFunctionName == nil then
		return false
	end	
	if source.SpecialInteractGameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, source, source.SpecialInteractGameStateRequirements ) then
		return false
	end
	if source.SpecialInteractCooldown ~= nil and not CheckCooldownNoTrigger( source.Name..source.ObjectId, source.SpecialInteractCooldown ) then
		return false
	end
	if source.NextInteractLines ~= nil and source.NextInteractLines.PreBlockSpecialInteract then
		return false
	end
	if source.InteractTextLineSets ~= nil then
		for k, textLineSet in pairs( source.InteractTextLineSets ) do
			if CurrentRun.TextLinesRecord[textLineSet.Name] and textLineSet.PostBlockSpecialInteract then
				return false
			end
		end
	end
	return true
end

function GetLockedLevel( npcName )
	if GiftData[npcName] then
		if ( CurrentRun and CurrentRun.CurrentRoom and string.match( CurrentRun.CurrentRoom.Name, "Test" ) ~= nil ) or ( GiftData[npcName].UnlockGameStateRequirements and IsGameStateEligible(CurrentRun, GiftData[npcName].UnlockGameStateRequirements )) then
			return GiftData[npcName].Maximum + 1
		end
		return GiftData[npcName].Locked
	end
end

function IsGiftBarCompletelyUnlocked( entryName )
	return ( GiftData[entryName].UnlockGameStateRequirements and IsGameStateEligible(CurrentRun, GiftData[entryName].UnlockGameStateRequirements ))
end

function GiftActivityFishing( source, args, textLines )
	RemoveInputBlock({ Name = "PlayTextLines" })
	RemoveControlBlock( "Use", "Gift" )
	RemoveControlBlock( "Use", "Dialog" )
	RemoveControlBlock( "Use", "PlayTextLines" )
	GiftActivityFishingStartPresentation( source, args )
	args.Difficulty = args.Difficulty or "Gifting"
	FishingSequence( source, args )
	GiftActivityFishingEndPresentation( source, args )
	AddInputBlock({ Name = "PlayTextLines" })
end