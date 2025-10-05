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
					IncrementTableValue( CurrentRun, "MetaConversionUses" )
				end 
				local rewardOverride = ChooseRoomReward( CurrentRun, CurrentRun.CurrentRoom, "RunProgress", { { RewardType = "Devotion" }, { RewardType = "SpellDrop" } }, { IgnoreForcedReward = true } )
				local previouslyRequired = false
				local previouslyCanDuplicate = target.CanDuplicate
				if MapState.RoomRequiredObjects[target.ObjectId] then
					MapState.RoomRequiredObjects[target.ObjectId] = nil
					previouslyRequired = true
				end
				local newReward = SpawnRoomReward( room, { SpawnRewardOnId = target.ObjectId, RewardOverride = rewardOverride, IgnoreRoomSpawnOnLootPoint = true })
				if newReward then
					if previouslyRequired then
						MapState.RoomRequiredObjects[newReward.ObjectId] = newReward
					end
					if newReward.CanDuplicate then
						newReward.CanDuplicate = previouslyCanDuplicate
					end
				end
				HideUseButton( target.ObjectId, target )
				if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.RewardsToRestore ~= nil then
					CurrentRun.CurrentRoom.Encounter.RewardsToRestore[target.ObjectId] = nil
				end
				Destroy({ Id = target.ObjectId })
			elseif target.ReceiveGiftFunctionName ~= nil then
				CallFunctionName( target.ReceiveGiftFunctionName, target )
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

		if not IsEmpty( ActiveScreens ) then
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
			EndAutoSprint({ Halt = true, EndWeapon = true })
			
			if CanGoldifyReward( target ) and IsUseable({ Id = target.ObjectId }) then
				UseableOff({ Id = target.ObjectId })
				target.GoldConversionEligible = false
				local previouslyRequired = false
				if MapState.RoomRequiredObjects[target.ObjectId] then
					MapState.RoomRequiredObjects[target.ObjectId] = nil
					previouslyRequired = true
				end
				HideUseButton( target.ObjectId, target )
				if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.RewardsToRestore ~= nil then
					CurrentRun.CurrentRoom.Encounter.RewardsToRestore[target.ObjectId] = nil
				end
					
				local goldGain = GetRewardGoldifyValue(target)
				GoldifyPresentation( target )
				thread( GushMoney, { Amount = goldGain, LocationId = target.ObjectId, Radius = 100, Source = "DebugSpawnMoney" } )
				Destroy({ Id = target.ObjectId })
				if HeroHasTrait("GoldifyKeepsake") then
					local trait = GetHeroTrait("GoldifyKeepsake")
					trait.BoonConversionUses = trait.BoonConversionUses - 1
					UpdateTraitNumber( trait )
					if trait.BoonConversionUses <= 0 and trait.ZeroBonusTrayText then
						trait.CustomTrayText = trait.ZeroBonusTrayText
						if not trait.Slot then 		
							RemoveTraitData( CurrentRun.Hero, trait, { SkipActivatedTraitUpdate =  true } )
						end
					end
				end 

				if target.MenuNotify then
					NotifyResultsTable[ target.MenuNotify ] = target.Name
					notifyExistingWaiters( target.MenuNotify )
				end
				if target.NotifyName then
					notifyExistingWaiters( target.NotifyName )
				end
				wait( 0.2 )
				if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
					UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
				end
			else
				GameState.SpecialInteractRecord[target.Name] = (GameState.SpecialInteractRecord[target.Name] or 0) + 1
				CurrentRun.SpecialInteractRecord[target.Name] = (CurrentRun.SpecialInteractRecord[target.Name] or 0) + 1
				TriggerCooldown( target.Name..target.ObjectId )
				CallFunctionName( target.SpecialInteractFunctionName, target )
			end
		end

	end
}

function SelectGift( target )
	SetUnitInvulnerable( target, "SelectGift", { Silent = true } )
	if target.PreSelectGiftFunctionName ~= nil then
		CallFunctionName( target.PreSelectGiftFunctionName, target )
	end
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })
	OpenInventoryScreen( { GiftTarget = target, DefaultCategoryIndex = target.GiftCategoryIndex or 3, CategoryLocked = true } )
	SetUnitVulnerable( target, "SelectGift" )
end

Using "GiftNPC"
function GiveGift( target, resourceName, resourceQuantity, textLines )

	local name = GetGenusName( target )

	AddTimerBlock( CurrentRun, "Gifting" )
	AddInputBlock({ Name = "Gifting" })
	SetPlayerInvulnerable( "Gift" )
	AddPlayerImmuneToForce( "Gift" )
	CurrentRun.Hero.UntargetableFlags.Gift = true

	target.ReceivingGift = true

	HideUseButton( target.ObjectId, target )
	FreezePlayerUnit( "Gift" )

	thread( MarkObjectiveComplete, "GiftPrompt" )
	if ScreenState.ActiveObjectives ~= nil and ScreenState.ActiveObjectives.GiftMedeaPoints ~= nil then
		if resourceName == "MedeaPoints" then
			thread( MarkObjectiveComplete, "GiftMedeaPoints" )
		else
			ClearObjectives()
		end
	end

	local spending = {}
	spending[resourceName] = resourceQuantity

	-- Pay the cost
	SpendResources( spending, name, { ShadowAnimName = "InCombatTextShadow_GiftBacking", SkipQuestStatusCheck = true } )

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

		-- Gift conversation order per character
		GameState.GiftTextLinesOrderRecord[name] = GameState.GiftTextLinesOrderRecord[name] or {}
		table.insert( GameState.GiftTextLinesOrderRecord[name], textLines.Name )

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
				if not GameState.GiftPresentation[giftLevelData.Gift] and IsGameStateEligible( giftLevelData, giftLevelData.GameStateRequirements ) then
					GameState.GiftPresentation[giftLevelData.Gift] = true
					GameState.NewKeepsakeItem[giftLevelData.Gift] = true
					wait( 0.65, RoomThreadName )
					PlayerReceivedGiftPresentation( target, giftLevelData.Gift )
					CheckAchievement( target, { Name = "AchAllKeepsakes" } )
					break
				end
			end
		end
	end

	CurrentRun.Hero.UntargetableFlags.Gift = nil
	RemovePlayerImmuneToForce( "Gift" )
	SetPlayerVulnerable( "Gift" )
	UnfreezePlayerUnit( "Gift" )
	RemoveTimerBlock( CurrentRun, "Gifting" )
	ShowCombatUI( "GiveSelectedGift" )
	target.ReceivingGift = false

end

function GiveGiftDirectly( source, args )
	
	local name = source.GiftName or source.Name
	ReceivedGiftPresentationPost( source )

	local giftData = GiftData[name]
	if giftData ~= nil then
		for giftLevel, giftLevelData in ipairs( giftData ) do
			if not GameState.GiftPresentation[giftLevelData.Gift] and IsGameStateEligible( giftLevelData, giftLevelData.GameStateRequirements ) then
				GameState.GiftPresentation[giftLevelData.Gift] = true
				GameState.NewKeepsakeItem[giftLevelData.Gift] = true
				wait( 0.65, RoomThreadName )
				PlayerReceivedGiftPresentation( source, giftLevelData.Gift )
				CheckAchievement( source, { Name = "AchAllKeepsakes" } )
				break
			end
		end
	end
end

function CanReceiveGift( target )
	if not target then
		return false
	end

	if target.IsDead then
		return false
	end

	if target.MetaConversionEligible and GetTotalHeroTraitValue( "MetaConversionUses" ) > 0 and not HasResourceCost( target.ResourceCosts ) then
		return true
	end
	
	if not target.CanReceiveGift then
		return false
	end

	if target.RequireUseToGift and GameState.UseRecord[target.Name] == nil then
		return false
	end

	local name = GetGenusName( target )
	if not IsEmpty( CurrentRun.GiftRecord[name] ) and target.UnlimitedGifts == nil then
		return false
	end

	if target.GiftGameStateRequirements ~= nil and not IsGameStateEligible( target, target.GiftGameStateRequirements ) then
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

	if target.ReceiveGiftFunctionName ~= nil then
		return true
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
	if CanGoldifyReward( source ) then
		return true
	end
	if source.SpecialInteractFunctionName == nil then
		return false
	end	
	if source.SpecialInteractGameStateRequirements ~= nil and not IsGameStateEligible( source, source.SpecialInteractGameStateRequirements ) then
		return false
	end
	if source.SpecialInteractCooldown ~= nil and not CheckCooldownNoTrigger( source.Name..source.ObjectId, source.SpecialInteractCooldown ) then
		return false
	end
	if source.NextInteractLines ~= nil and source.NextInteractLines.PreBlockSpecialInteract then
		return false
	end
	if not source.AllowSpecialInteractInPartnerConversation and source.InPartnerConversation then
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

function GiftActivityFishing( source, args, textLines )
	RemoveInputBlock({ Name = "PlayTextLines" })
	RemoveControlBlock( "Use", "Gift" )
	RemoveControlBlock( "Use", "Dialog" )
	RemoveControlBlock( "Use", "PlayTextLines" )
	AddInteractBlock( source, "GiftActivityFishing" )
	GiftActivityFishingStartPresentation( source, args )
	args.Difficulty = args.Difficulty or "Gifting"
	FishingSequence( source, args )
	GiftActivityFishingEndPresentation( source, args )
	RemoveInteractBlock( source, "GiftActivityFishing" )
	AddInputBlock({ Name = "PlayTextLines" })
end

function RequireGiftTrackProgress( source, args )
	DebugAssert({ Condition = args.MinGifts ~= nil, Text = "RequireGiftTrackProgress must specify MinGifts", Owner = "Caleb" })
	for npcName, orderRecord in pairs( GameState.GiftTextLinesOrderRecord ) do
		local npcData = EnemyData[npcName] or LootData[npcName]
		if npcData ~= nil and ( args.AnyNPC or Contains( args.AnyOf, npcName ) ) then
			local total = 0
			for i, line in ipairs( orderRecord ) do
				if npcData.GiftTextLineSets[line] ~= nil and npcData.GiftTextLineSets[line].OnGiftTrack then
					total = total + 1
				end
			end
			if total >= args.MinGifts then
				return true
			end
		end
	end
	return false
end