
function UseWeaponKit( weaponKit, args, user )
	args = args or {}
	if CurrentRun.Hero.Weapons[weaponKit.Name] ~= nil then
		if not HasAnyAspectUnlocked( weaponKit.Name ) then
			return
		else
			PreOpenWeaponUpgradeScreenPresentation( weaponKit )
			OpenWeaponUpgradeScreen({ WeaponName = weaponKit.Name })
			thread( SpawnSkelly, 1.0 )
		end
	else
		PickupWeaponKit( weaponKit, args )
		SetWeaponKitUseText( weaponKit )
		RefreshUseButton( weaponKit.ObjectId, weaponKit )
		if args.BonusUnusedWeapon then
			wait( 1.8 )
		else
			wait( 0.3 )
		end
		if not HasAnyAspectUnlocked( weaponKit.Name ) then
			CheckAutoObjectiveSets( CurrentRun, "WeaponPickup" )
		end
	end
end

function PickupWeaponKit( weaponKit, args )
	args = args or {}
	AddInputBlock({ Name = "PickupWeaponKit" })
	if GameState.ActiveObjectiveSet == nil or ObjectiveSetData[GameState.ActiveObjectiveSet] == nil or not ObjectiveSetData[GameState.ActiveObjectiveSet].BlockWeaponObjectives then
		ClearObjectives()
	end
	Halt({ Id = CurrentRun.Hero.ObjectId })
	EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
	wait( 0.02 )
	PickupWeaponKitInteractPresentation( weaponKit )
	local weaponUntouched = IsWeaponUntouched( weaponKit.Name )
	UnequipWeaponUpgrade()
	wait( 0.02 )-- Distribute workload
	EquipPlayerWeapon( weaponKit, args )
	wait( 0.02 )-- Distribute workload
	EquipWeaponUpgrade( CurrentRun.Hero )
	SelectCodexEntry( weaponKit.Name )

	local weaponData = GetWeaponData( CurrentRun.Hero, weaponKit.Name) 
	RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
	if weaponUntouched then
		FirstTimeWeaponPickupPresentation( weaponKit )
	else
		wait( 0.02 ) -- Distribute workload
	end

	thread( UpdateWeaponKits )
	wait( 0.02 )-- Distribute workload
	thread( SpawnSkelly, 1.0 )

	RemoveInputBlock({ Name = "PickupWeaponKit" })

end

function UseNPC( npc, args, user )

	if not CurrentRun.Hero.IsDead and npc.RequiresRoomCleared and not CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		thread( CannotUseLootPresentation, npc.ObjectId, npc )
		return
	end

	if npc.ReceivingGift then
		return
	end

	if npc.UnuseableWhenDead and npc.IsDead then
		return
	end

	if npc.AggroedEnemyUseText ~= nil then
		if not IsEmpty( RequiredKillEnemies ) or IsAggroedUnitBlockingInteract() then
			thread( InteractBlockedByEnemiesPresentation, npc, nil, user )
			return
		end
	end

	if npc.BlockedLootInteractionText and not CurrentRun.CurrentRoom.AlwaysAllowLootInteraction then
		for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
			if enemy.BlocksLootInteraction then
				DebugPrint({ Text = "Interact BlockedByEnemy = "..GetTableString( enemy ) })
				thread( InteractBlockedByEnemiesPresentation, npc, nil, user )
				return
			end
		end
	end

	if npc.NextInteractLines == nil then
		return
	end

	args = args or {}

	if npc.ManualRecordUse then
		RecordUse( npc.ObjectId, npc.Name )
	end

	local angleTowardTargetId = args.AngleTowardTargetId or npc.ObjectId
	if CalcArcDistance( GetAngleBetween({ Id = user.ObjectId, DestinationId = angleTowardTargetId }), GetAngle({ Id = user.ObjectId })) > ( user.TurnInPlaceAngleMin or 0 ) then
		AngleTowardTarget({ Id = user.ObjectId, DestinationId = angleTowardTargetId })
	end

	-- Cancel all partner conversations immediately
	local source = npc
	local partner = nil
	local textLinesToPlay = npc.NextInteractLines
	for id, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if unit ~= npc and unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == npc.NextInteractLines.Name then
			if textLinesToPlay[1] == nil and unit.NextInteractLines[1] ~= nil then
				-- Actually lines are contained on the partner
				textLinesToPlay = unit.NextInteractLines
				source = unit
				partner = npc
			else
				partner = unit
			end
			break
		end
	end
	if partner ~= nil then
		StopStatusAnimation( partner, StatusAnimations.WantsToTalk )
	end

	if partner == nil and not IsTextLineEligible( CurrentRun, source, textLinesToPlay ) then
		-- Previously selected conversation is no longer eligible, pick a different one just-in-time
		npc.NextInteractLines = nil
		CheckAvailableTextLines( npc, { RequireNoPartner = true, RequireNoTeleportToId = true, } )
		textLinesToPlay = npc.NextInteractLines
	end

	if textLinesToPlay == nil then
		return
	end

	PlayTextLines( source, textLinesToPlay, { PreLineFunctionName = "StartedEndVoiceLines", FinishedFunctionName = "FinishedEndVoiceLines", NPCSource = source, } )
	npc.NextInteractLines = nil
	npc.ActiveNarrativeTeleportId = nil
	npc.FieldsRewardFinderIgnores = true
	RemoveScreenEdgeIndicator( npc )
	if not npc.SkipNextTextLinesCheck and not textLinesToPlay.SkipNextTextLinesCheck then
		CheckAvailableTextLines( npc, { RequireNoPartner = true } )
	end
	if partner ~= nil then
		partner.NextInteractLines = nil
		CheckAvailableTextLines( partner, { RequireNoPartner = true } )
		StopStatusAnimation( partner, StatusAnimations.WantsToTalk )
		RefreshUseButton( partner.ObjectId, partner )
		AddInteractBlock( partner, "SetAvailableUseText" ) -- Will get unblocked by SetAvailableUseText() below if needed
	end

	UseNPCPostTextLines( source, partner, textLinesToPlay )
	if partner == nil then
		local sourceName = GetGenusName( source )
		CheckCodexUnlock( "ChthonicGods", sourceName )
		CheckCodexUnlock( "OtherDenizens", sourceName )
		CheckCodexUnlock( "EnemiesUW", sourceName )
		CheckCodexUnlock( "EnemiesSF", sourceName )
	end

	SetAvailableUseText( npc )
	if partner ~= nil then
		SetAvailableUseText( partner )
	end

end

function StartedEndVoiceLines( source, args, contextArgs )
	local npcSource = contextArgs.NPCSource or args.NPCSource
	if not npcSource.AllowInteractDuringEndVoiceLines then
		AddInteractBlock( npcSource, "EndVoiceLinePlaying" )
	end
end

function FinishedEndVoiceLines( source, args, contextArgs )
	local npcSource = contextArgs.NPCSource or args.NPCSource
	if not npcSource.AllowInteractDuringEndVoiceLines then
		RemoveInteractBlock( contextArgs.NPCSource or args.NPCSource, "EndVoiceLinePlaying" )
	end
end

function GetGenusName( source )
	if source.GenusName then
		return source.GenusName
	end
	return source.Name
end

function UseInspectPoint( inspectPoint, args, user )

	UseableOff({ Id = inspectPoint.ObjectId })
	SetAlpha({ Id = inspectPoint.ObjectId, Fraction = 0.0, Duration = 0.25 })
	BlockVfx({ DestinationId = inspectPoint.ObjectId })
	PlayFirstEligibleTextLines( inspectPoint, inspectPoint.InteractTextLineSets )

end

function AttemptUseChallengeSwitch( challengeSwitch, args, user )

	-- Same requirements as exit doors
	if not challengeSwitch.ReadyToUse or not CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		challengeSwitch.CannotUseTextOverride = RoomData[CurrentRun.CurrentRoom.Name].ChallengeSwitchCannotUseText
		thread( CannotUseDoorPresentation, challengeSwitch )
		return
	end

	local interactionBlocked = false
	if challengeSwitch.BlockDuringChallenge and CurrentRun.CurrentRoom.ChallengeEncounter ~= nil then
		if CurrentRun.CurrentRoom.ChallengeEncounter.InProgress then
			interactionBlocked = true
		end
	end

	if interactionBlocked then
		if CheckCooldown( challengeSwitch.CooldownNamePrefix..user.ObjectId, user.CooldownDuration) then
			if user.CannotUseText then
				thread( InCombatText, CurrentRun.Hero.ObjectId, user.CannotUseText, 1 )
				thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
			else
				thread( CannotUseObjectPresentation, challengeSwitch )
			end
		end
		CreateAnimation({ Name = "ShoutFlare", DestinationId = user.ObjectId })
		return
	elseif challengeSwitch.KeyCost ~= nil and challengeSwitch.KeyCost > 0 and not challengeSwitch.Purchased and not HasResource( "LockKeys", challengeSwitch.KeyCost ) then
		if CheckCooldown( challengeSwitch.CooldownNamePrefix..user.ObjectId, user.CooldownDuration) then
			if user.CannotAffordText then
				thread( InCombatText, CurrentRun.Hero.ObjectId, user.CannotAffordText, 1 )
				thread( PlayVoiceLines, HeroVoiceLines.NotEnoughLockKeysVoiceLines, true )
			else
				thread( CannotUseObjectPresentation, challengeSwitch )
			end
			CreateAnimation({ Name = "ShoutFlare", DestinationId = user.ObjectId })
		end
		return
	end

	if challengeSwitch.ChallengeSwitchUseFunctionName ~= nil then
		CallFunctionName( challengeSwitch.ChallengeSwitchUseFunctionName, challengeSwitch )
	end

end

function UseChallengeSwitch( challengeSwitch )
	if not CurrentRun.CurrentRoom.ChallengeEncounter.InProgress and not CurrentRun.CurrentRoom.ChallengeEncounter.Completed then
		challengeSwitch.ReadyToUse = false
		AddInputBlock({ Name = "UseChallengeSwitch" })
		PlayInteractAnimation( challengeSwitch.ObjectId )
		if not IsEmpty(SessionMapState.SkipEncounterIds) and CurrentRun.CurrentRoom.Encounter.SpawnsSkipped then
			thread( SkipEncounterEndPresentation )
		end

		if challengeSwitch.KeyCost ~= nil and challengeSwitch.KeyCost > 0 then
			SetAnimation({ DestinationId = challengeSwitch.TextAnchorId, Name = "LockedIconRelease" })
			wait(0.65)
			DestroyTextBox({ Id = challengeSwitch.TextAnchorId })
			SpendResource( "LockKeys", challengeSwitch.KeyCost, "ChallengeSwitch")
			challengeSwitch.Purchased = true
		end

		RemoveInputBlock({ Name = "UseChallengeSwitch" })
		StartChallengeEncounter( challengeSwitch )
		CheckCodexUnlock( "Items", "ChallengeSwitch" )
	else
		if not challengeSwitch.IsOpen then
			PlayInteractAnimation( challengeSwitch.ObjectId )
			HandleChallengeLoot( challengeSwitch, CurrentRun.CurrentRoom.ChallengeEncounter )
			challengeSwitch.IsOpen = true
			thread( MarkObjectiveComplete, "ChallengeReward" )
		end
	end
end

function UseWellShop( challengeSwitch )
	PlayInteractAnimation( challengeSwitch.ObjectId )
	StartUpStore()
end

function UseMetaRewardStand( challengeSwitch )
	PlayInteractAnimation( challengeSwitch.ObjectId )
	thread( PlayVoiceLines, GlobalVoiceLines.MetaRewardStandUsedVoiceLines, true )
	PlaySound({ Name = challengeSwitch.ResourceData.MetaRewardStandPickupSound, Id = challengeSwitch.DisplayItemId })
	AddResource( challengeSwitch.ResourceData.Name, challengeSwitch.RewardAmount, "MetaRewardStand" )
	Destroy({ Ids = { challengeSwitch.DisplayItemId, challengeSwitch.TextAnchorId } })
	UseableOff({ Id = challengeSwitch.ObjectId })
end

function RecordUse( id, name )

	if name ~= nil then
		GameState.UseRecord[name] = (GameState.UseRecord[name] or 0) + 1
		CurrentRun.UseRecord[name] = (CurrentRun.UseRecord[name] or 0) + 1
		CurrentRun.BiomeUseRecord[name] = (CurrentRun.BiomeUseRecord[name] or 0) + 1
		CurrentRun.CurrentRoom.UseRecord[name] = (CurrentRun.CurrentRoom.UseRecord[name] or 0) + 1
	end

end

OnUsed{
	function( triggerArgs )
		local usee = triggerArgs.TriggeredByTable
		local user = triggerArgs.UserTable
		if usee == nil then
			return
		end
		if usee.UnuseableWhenDead and usee.IsDead then
			return
		end

		if not usee.ManualRecordUse and usee.ObjectId ~= nil then -- Intentionally excluding screen components for now
			RecordUse( usee.ObjectId, usee.Name )
		end
		
		if not triggerArgs.DidAutoActivate and SessionMapState.SprintActive and SessionMapState.WaitUntilAutoSprintInput then
			EndAutoSprint({ Halt = true, EndWeapon = true })
		end

		RunEventsGeneric( usee.OnUseEvents, usee )

		if usee.OnUsedGameStateRequirements == nil or IsGameStateEligible( usee, usee.OnUsedGameStateRequirements ) then

			if usee.DisableOnUse then
				UseableOff({ Id = triggerArgs.triggeredById })
			end

			if usee.UseSound ~= nil then
				PlaySound({ Name = usee.UseSound, Id = triggerArgs.triggeredById })
			end
			if usee.ShakeSelf ~= nil then
				Shake({ Id = triggerArgs.triggeredById, Distance = 2, Speed = 300, Duration = 0.15 })
			end
			if usee.OnUsedVoiceLines ~= nil then
				thread( PlayVoiceLines, usee.OnUsedVoiceLines, true )
			end
			if usee.OnUsedGlobalVoiceLines ~= nil then
				thread( PlayVoiceLines, GlobalVoiceLines[usee.OnUsedGlobalVoiceLines], true )
			end
			if usee.OnUsedFunctionName ~= nil then
				CallFunctionName( usee.OnUsedFunctionName, usee, usee.OnUsedFunctionArgs, user )
			end

			if usee.NotifyName ~= nil then
				notifyExistingWaiters( usee.NotifyName )
			end
		else
			if usee.OnUsedFailedPresentation ~= nil then
				CallFunctionName(usee.OnUsedFailedPresentation, usee, usee.OnUsedFailedPresentationArgs, user)
			end
		end
	end
}

function UseNPCPostTextLines( npc, partner, textLinesPlayed )

	if npc.PostTextLinesFunctionName ~= nil then
		CallFunctionName( npc.PostTextLinesFunctionName, npc, partner, textLinesPlayed, npc.PostTextLinesFunctionArgs )
	end
	if npc.PostTextLineEvents ~= nil then
		RunEventsGeneric( npc.PostTextLineEvents, npc, { Partner = partner } )
	end

	if not textLinesPlayed.SkipClearRoomRequiredObject then
		MapState.RoomRequiredObjects[npc.ObjectId] = nil
		if partner ~= nil then
			MapState.RoomRequiredObjects[partner.ObjectId] = nil
		end
	end

	wait( 0.2, RoomThreadName )

	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function NPCRewardDropPreProcessArgs( rewardDropArgs, choice, postChoiceLine )
	
	if rewardDropArgs.SellTrait then
		GenerateSellTraitShop( CurrentRun.CurrentRoom, { SellOptionCount = 1 } )
		for traitName, sellData in pairs( CurrentRun.CurrentRoom.SellOptions ) do
			if postChoiceLine ~= nil then
				postChoiceLine.SellTraitName = sellData.Name
				local traitData = TraitData[sellData.Name]
				local iconAnim = GetTraitIcon( traitData )
				local iconPath = string.sub( iconAnim, 6 )
				postChoiceLine.SellTraitIcon = "GUI\\Screens\\BoonIcons\\"..iconPath
			end
		end
	end

	local consumables = rewardDropArgs.Consumables
	if consumables ~= nil then
		if consumables.RandomSelection then
			local availableIndicies = {}
			for index, consumable in ipairs( consumables ) do
				if consumable.GameStateRequirements == nil or IsGameStateEligible( consumable, consumable.GameStateRequirements ) then
					table.insert( availableIndicies, index )
				else
					--DebugPrint({ Text = "Failed inex = "..index })
				end
			end
			local selectedIndex = GetRandomValue( availableIndicies )
			--DebugPrint({ Text = "selectedIndex = "..selectedIndex })
			consumables.SelectedIndex = selectedIndex
		end
		for i, consumable in ipairs( consumables ) do
			if consumables.SelectedIndex == nil or i == consumables.SelectedIndex then
				if postChoiceLine ~= nil then
					postChoiceLine.BuyItemName = consumable.DisplayName or consumable.Name
				end
				if consumable.CostResourceName ~= nil then
					consumable.ResourceCost = {}
					local resourceAmount = RandomInt( consumable.CostResourceMin, consumable.CostResourceMax )
					consumable.ResourceCost[consumable.CostResourceName] = resourceAmount
					if postChoiceLine ~= nil then
						postChoiceLine.ResourceAmount = resourceAmount
						postChoiceLine.ResourceIconPath = ResourceData[consumable.CostResourceName].IconPath
						if choice ~= nil and not HasResources( consumable.ResourceCost ) then
							choice.Disabled = true
						end
					end
				end
				if consumable.DamageAmountMin ~= nil then
					consumable.DamageAmount = RandomInt( consumable.DamageAmountMin, consumable.DamageAmountMax )
					if postChoiceLine ~= nil then
						postChoiceLine.DamageAmount = consumable.DamageAmount
					end
				end
			end
		end
	end
end

function NPCRewardDropPreProcess( source, args, line )
	RandomSynchronize( 5 )
	if line.PostLineFunctionArgs ~= nil then
		NPCRewardDropPreProcessArgs( line.PostLineFunctionArgs )
	end
	if line.Choices ~= nil then
		for i, choice in ipairs( line.Choices ) do
			local postChoiceLine = choice[1]
			local choicePostLineFunctionArgs = postChoiceLine.PostLineFunctionArgs
			if choicePostLineFunctionArgs ~= nil then
				NPCRewardDropPreProcessArgs( choicePostLineFunctionArgs, choice, postChoiceLine )
			end
		end
	end
end

function NPCRewardDrop( source, args )
	if args.ResourceDropName ~= nil then
		local consumableId = SpawnObstacle({ Name = args.ResourceDropName, DestinationId = source.ObjectId, Group = "Standing" })
		local consumable = CreateConsumableItem( consumableId, args.ResourceDropName, 0 )
		ApplyConsumableItemResourceMultiplier( CurrentRun.CurrentRoom, consumable )
		ApplyUpwardForce({ Id = consumableId, Speed = args.UpwardForce or 700 })
		local forceAngle = GetAngleBetween({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		ApplyForce({ Id = consumableId, Speed = args.Force or 100, Angle = forceAngle, SelfApplied = true })
		if args.RoomRequiredObject then
			MapState.RoomRequiredObjects[consumable.ObjectId] = consumable
		end
	end

	if args.SellTrait then
		for traitName, sellData in pairs( CurrentRun.CurrentRoom.SellOptions ) do
			RemoveWeaponTrait( sellData.Name )	
		end
		CurrentRun.CurrentRoom.SellOptions = {}
	end
	
	if args.Consumables ~= nil then

		if args.ConsumablePreDropFunctionName ~= nil then
			thread( CallFunctionName, args.ConsumablePreDropFunctionName, source, args )
			wait( args.ConsumablePreDropFunctionDelay or 0 )
		end

		for i, consumableData in ipairs( args.Consumables ) do
			if args.Consumables.SelectedIndex == nil or i == args.Consumables.SelectedIndex then
				
				SpendResources( consumableData.ResourceCost, source.Name )
				if consumableData.DamageAmount ~= nil then
					Damage( CurrentRun.Hero, { triggeredById = CurrentRun.Hero.ObjectId, DamageAmount = consumableData.DamageAmount, PureDamage = true, } )
				end

				if LootData[consumableData.Name] ~= nil then
					CreateLoot( consumableData )
				else
					local spawnId = args.DropSourceId or source.ObjectId
					local groupName = consumableData.Group or "Standing"
					local consumableId = SpawnObstacle({ Name = consumableData.Name, DestinationId = spawnId, Group = groupName })
					local consumable = CreateConsumableItem( consumableId, consumableData.Name, 0 )
					consumable.NPCDrop = true
					ApplyConsumableItemResourceMultiplier( CurrentRun.CurrentRoom, consumable )
					consumable.SpawnPointId = spawnId
					consumable.SpawnGroupName = groupName
					if args.ConsumableDropFunctionName ~= nil then
						thread( CallFunctionName, args.ConsumableDropFunctionName, source, consumable, args)
					end					
					if args.ResourceAmount ~= nil and consumable.AddResources ~= nil then
						local resourceName = GetFirstKey( consumable.AddResources )
						consumable.AddResources[resourceName] = args.ResourceAmount
					end
					SetupResourceText( consumable )
					if consumableData.OverwriteSelf ~= nil then
						OverwriteSelf( consumable, consumableData.OverwriteSelf )
					end
					ApplyUpwardForce({ Id = consumableId, Speed = args.UpwardForce or 700 })
					local forceAngle = consumableData.Angle or GetAngleBetween({ Id = spawnId, DestinationId = CurrentRun.Hero.ObjectId })
					if consumableData.AngleMin ~= nil then
						forceAngle = RandomFloat( consumableData.AngleMin, consumableData.AngleMax )
					end
					ApplyForce({ Id = consumableId, Speed = args.Force or 100, Angle = forceAngle, SelfApplied = true })
				end

				thread( PlayVoiceLines, source[args.SourceThreadedVoiceLines], nil, source )
				
				wait( args.Interval )
			end
		end
	end
	if args.DropMoney ~= nil then
		thread( GushMoney, { Amount = args.DropMoney, LocationId = CurrentRun.Hero.ObjectId, Radius = args.MoneyRadius or 100, Source = source.Name, } )
	end
end

function ArachneArmorApply( screen, args )
	ArachneCostumeStartPresentation( screen, args )
	SetupCostume()
	ArachneCostumeEndPresentation( screen, args )
end

function HandleNemesisEncounterReward( eventSource, args )
	local encounter = eventSource
	local nemesis = ActiveEnemies[encounter.NemesisId]

	if nemesis == nil then -- Most likely if the player died during reward sequence
		return
	end

	thread( PlayVoiceLines, nemesis.EncounterEndVoiceLines, nil, nemesis )

	wait(2.0, RoomThreadName)

	local betAmount = nemesis.MaxBetAmount or 100
	if GameState.Resources.Money < betAmount then
		betAmount = GameState.Resources.Money
	end

	if (encounter.NemesisKills or 0) > (encounter.PlayerKills or 0) then
		-- Player loss
		thread( MarkObjectiveComplete, "NemesisKills" )
		thread( MarkObjectiveFailed, "PlayerKills" )
		thread( MarkObjectiveFailed, "NemesisBet" )
		SpendResource("Money", betAmount)
		thread( NemesisBetPresentation, eventSource, { Sum = betAmount, Result = "playerloss" } )

		PlayVoiceLines( nemesis.EncounterLostVoiceLines, nil, nemesis )
	elseif (encounter.NemesisKills or 0) < (encounter.PlayerKills or 0) then
		-- Player win
		thread( MarkObjectiveFailed, "NemesisKills" )
		thread( MarkObjectiveComplete, "PlayerKills" )
		thread( MarkObjectiveComplete, "NemesisBet" )
		if not HasHeroTraitValue("BlockMoney") then
			local moneyMultiplier = GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )
			local amount = round( betAmount * moneyMultiplier )
			AddResource( "Money", amount , "NemesisBet" )
			GameState.NemesisBetWinnings = (GameState.NemesisBetWinnings or 0) + amount
		end
		thread( NemesisBetPresentation, eventSource, { Sum = -betAmount, Result = "playerwin" } )

		if encounter.PlayerKills / encounter.NemesisKills >= 4 then
			thread( PlayVoiceLines, nemesis.EncounterWonBigVoiceLines, nil, nemesis )
		else
			PlayVoiceLines( nemesis.EncounterWonVoiceLines, nil, nemesis )
		end

		CheckAchievement( nemesis, { Name = "AchNemesisCombat" } )
	else
		-- Tie
		thread( MarkObjectiveComplete, "NemesisKills" )
		thread( MarkObjectiveComplete, "PlayerKills" )
		thread( MarkObjectiveComplete, "NemesisBet" )
		PlayVoiceLines( nemesis.EncounterTiedVoiceLines, nil, nemesis )
	end

	ProcessTextLines( nemesis, nemesis.InteractTextLineSets )
	CheckAvailableTextLines( nemesis )
	if nemesis.NextInteractLines ~= nil then
		UseableOn({ Id = nemesis.ObjectId })
	else
		MapState.RoomRequiredObjects[nemesis.ObjectId] = nil
		wait( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end

		if nemesis.PostTextLineEvents ~= nil then
			RunEventsGeneric( nemesis.PostTextLineEvents, nemesis )
		end

	end
end

function UseLoot( usee, args, user )

	args = args or {}

	local interactionBlocked = false
	if not CurrentRun.CurrentRoom.AlwaysAllowLootInteraction then
		for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
			if enemy.BlocksLootInteraction then
				DebugPrint({ Text = "Interact BlockedByEnemy = "..GetTableString( enemy ) })
				interactionBlocked = true
				break
			end
		end
	end

	if interactionBlocked then
		thread( InteractBlockedByEnemiesPresentation, usee, args, user )
		return false
    elseif not AreScreensActive() then

		if usee.ResourceCosts ~= nil and not HasResources( usee.ResourceCosts ) then
			CantAffordPresentation( usee )
			return false
		end
		if HasResourceCost(usee.ResourceCosts) then
			usee.Purchased = true
			DestroyTextBox({ Id = usee.ObjectId })
			SpendResources( usee.ResourceCosts, usee.Name or "Loot" )
			RemoveStoreItem( { Id = usee.ObjectId, Name = usee.Name, IsBoon = true, BoonRaritiesOverride = usee.BoonRaritiesOverride, StackNum = usee.StackNum, ScreenName = UIData.BoonMenuId } )
			if (usee.ResourceCosts.Money or 0) > 0 then
				HandleCharonPurchase( "UseLoot", usee.ResourceCosts.Money )
			end
			PlaySound({ Name = "/Leftovers/Menu Sounds/StoreBuyingItem" })
			thread( PlayVoiceLines, GlobalVoiceLines.PurchasedConsumableVoiceLines, true )
		end

		AddInputBlock({ Name = "UseLoot" })
		usee.GoldConversionEligible = false
			
		CurrentRun.Hero.UntargetableFlags.UseLoot = true
		SetPlayerInvulnerable( "UseLoot" )
		AddPlayerImmuneToForce( "UseLoot" )

		if not args.SkipInteractAnim then
			if usee.GodLoot then
				PlayInteractAnimation( usee.ObjectId, { Animation = "MelinoeBoonPreInteract" } )
			else
				PlayInteractAnimation( usee.ObjectId )
			end
		else
			AngleTowardTarget({ Id = user.ObjectId, DestinationId = usee.ObjectId })
		end

		RemoveInputBlock({ Name = "UseLoot" })

        HandleLootPickup( CurrentRun, usee, args )
        
		CurrentRun.Hero.UntargetableFlags.UseLoot = nil
		SetPlayerVulnerable( "UseLoot" )
		RemovePlayerImmuneToForce( "UseLoot" )

		if args.ResetUseText then
			usee.NextInteractLines = nil
			usee.OnUsedFunctionName = nil
			SetAvailableUseText( usee )
		end

	end

	return true
end

function HandleLootPickup( currentRun, loot, args )

	SetPlayerInvulnerable( "HandleLootPickup" )
	AddTimerBlock( currentRun, "HandleLootPickup" )

	CurrentLootData = loot

	loot.HasDuoBoon = false
	if loot.UpgradeOptions ~= nil then
		for i, itemData in pairs(loot.UpgradeOptions) do
			if itemData.Type == "Trait" and TraitData[itemData.ItemName] and TraitData[itemData.ItemName].IsDuoBoon then
				loot.HasDuoBoon = true
			end
		end
	end

	GodLootPickupPresentation( loot, args )
	LootPickupPresentation( loot, args ) 

	AddInputBlock({ Name = "HandleLootPickup" })

	if loot.ManualRecordUse then
		RecordUse( loot.ObjectId, loot.Name )
	end
	currentRun.LootTypeHistory[loot.Name] = (currentRun.LootTypeHistory[loot.Name] or 0) + 1
	currentRun.LootBiomeRecord[loot.Name] = (currentRun.LootBiomeRecord[loot.Name] or 0) + 1

	if loot.RespawnAfterUse then
		local newLoot = CreateLoot({ Name = loot.Name, LootData = loot, SpawnPoint = loot.ObjectId })
		newLoot.UpgradeOptions = nil
	end
	if loot.WipeRecordsAfterUse then
		GameState.TextLinesRecord = {}
		CurrentRun.TextLinesRecord = {}
	end

	UseableOff({ Id = loot.ObjectId })
	RemoveInputBlock({ Name = "HandleLootPickup" })
	RemoveTimerBlock( currentRun, "HandleLootPickup" )
	
	OpenUpgradeChoiceMenu( loot, args )

	if loot.PostPickupFunctionName ~= nil then
		CallFunctionName( loot.PostPickupFunctionName, loot, loot.PostPickupFunctionArgs )
	end
	CheckAndAddOlympianDuo( loot )
	SetPlayerVulnerable( "HandleLootPickup" )

end

function UseHealthFountain( used, user )

	UseableOff({ Id = used.ObjectId })
	if used.RecordObjectState then
		RecordObjectState( CurrentRun.CurrentRoom, used.ObjectId, "UseableOff", true )
	end
	PlayInteractAnimation( used.ObjectId )

	if used.HealingSpentAnimation then
		SetAnimation({ Name = used.HealingSpentAnimation, DestinationId = used.ObjectId })
	end
	if used.RecordObjectState then
		RecordObjectState( CurrentRun.CurrentRoom, used.ObjectId, "Animation", used.HealingSpentAnimation )
	end

	Destroy({ Ids = GetIds({ Name = used.DestroyGroupOnUse or "WellLightsGroup"}) })

	MapState.RoomRequiredObjects[used.ObjectId] = nil
	
	local hasDamageBonus = false
	local fountainRarityTraits = {}
	local delay = 0
	for k, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.FountainDamageBonus then
			hasDamageBonus = true
			traitData.AccumulatedFountainDamageBonus = traitData.AccumulatedFountainDamageBonus + (traitData.FountainDamageBonus - 1)
			ExtractValues( CurrentRun.Hero, traitData, traitData )
		end
		if traitData.FountainRarity and traitData.Uses > 0 and HasRarifiableTraits( traitData.FountainRarity ) then
			ReduceTraitUses( traitData )
			local args = ShallowCopyTable( traitData.FountainRarity )
			args.Delay = delay
			thread( AddRarityToTraits, traitData, args )
			delay = delay + 1
		end
		if traitData.FountainRefreshUses then
			thread ( SpellPotionRefillPresentation, used, user, traitData, 0.2, delay)
			if HasHeroTraitValue("RolloverSpellUses") then
				traitData.RemainingUses = traitData.RemainingUses + traitData.MaxUses + GetTotalHeroTraitValue("BonusSpellUses")
			else
				traitData.RemainingUses = traitData.MaxUses + GetTotalHeroTraitValue("BonusSpellUses")
			end
			SetWeaponProperty({ WeaponName = traitData.PreEquipWeapons[1], DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			UpdateTraitNumber(traitData)
			TraitUIDeactivateTrait(traitData)
			delay = delay + 1
		end
	end
	if hasDamageBonus then
		FountainDamagePresentation()
	end

	wait(0.4)

	PlaySound({ Name = "/Leftovers/SFX/StaminaRefilled", Id = CurrentRun.Hero.ObjectId })

	if used.UsedText ~= nil then
		thread( InCombatText, CurrentRun.Hero.ObjectId, used.UsedText, 2.5, {Group = "Overlay" })
	end

	local healFraction = used.HealFraction + GetTotalHeroTraitValue( "FountainHealFractionBonus" )
	local healFractionOverride = GetTotalHeroTraitValue("FountainHealFractionOverride") 
	if healFractionOverride > 0 then
		healFraction = healFractionOverride
	end

	healFraction = healFraction * CalculateHealingMultiplier()
	Heal( CurrentRun.Hero, { HealFraction = healFraction, SourceName = "HealthFountain" } )
	FrameState.RequestUpdateHealthUI = true

	wait( 0.2, RoomThreadName )
	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end


end

function CreateConsumableItem( consumableId, consumableName, costOverride, args )
	if consumableName == nil then
		return
	end
	args = args or {}
	local consumableData = ConsumableData[consumableName] or LootData[consumableName] or ObstacleData[consumableName]
	if consumableData == nil then
		DebugAssert({ Condition = consumableData ~= nil, Text = "Missing ConsumableData for "..consumableName })
		return
	end
	if args.AutoLoadPackages and consumableData.SpeakerName ~= nil then
		LoadVoiceBanks( consumableData.SpeakerName, nil, args.IgnoreAssert )
	end
	local consumableItem = GetRampedConsumableData( consumableData, args )
	if consumableData ~= nil and consumableData.SpawnSound ~= nil and not args.IgnoreSounds then
		PlaySound({ Name = consumableData.SpawnSound, Id = consumableId })
	end
	return CreateConsumableItemFromData( consumableId, consumableItem, costOverride, args )
end

function SetupResourceText( consumable )
	-- Converting to single-cost lookups for text
	if consumable.AddResources == nil then
		return
	end
	for resourceName, resourceAmount in pairs( consumable.AddResources ) do
		consumable.ResourceIconPath = ResourceData[resourceName].TextIconPath or ResourceData[resourceName].IconPath
		consumable.ResourceAmount = resourceAmount
		break
	end
	if consumable.RunProgress ~= nil then
		local propertyChanges = consumable.RunProgress.PropertyChanges
		if propertyChanges.AddMaxHealth then
			local healthRewardMultiplier = GetTotalHeroTraitValue("HealthRewardBonus", { IsMultiplier = true })
			consumable.RunProgressResourceAmount = round( propertyChanges.AddMaxHealth * healthRewardMultiplier )
		else
			consumable.RunProgressResourceAmount = propertyChanges.AddMaxMana or propertyChanges.AddArmor or 0
		end
		consumable.RunProgressResourceIconPath = consumable.RunProgress.ResourceIcon
	end
end

function CreateConsumableItemFromData( consumableId, consumableItem, costOverride, args )
	args = args or {}
	consumableItem.ObjectId = consumableId
	AttachLua({ Id = consumableId, Table = consumableItem })
	MapState.ActiveObstacles[consumableItem.ObjectId] = consumableItem
	AddToGroup({ Id = consumableId, Name = "ConsumableItems" })
	if consumableItem.RunProgress ~= nil and args.RunProgressUpgradeEligible and IsGameStateEligible( consumableItem, consumableItem.RunProgress.GameStateRequirements ) then
		OverwriteSelf( consumableItem, consumableItem.RunProgress.PropertyChanges )
	end
	consumableItem.OnUsedFunctionName = consumableItem.OnUsedFunctionName or "UseConsumableItem"

	if consumableItem.ShowWorldText then
		CreateTextBox({ Id = consumableId, Font = "LatoMedium", Text = consumableItem.Name, FontSize = 20, OffsetY = 50, Color = Color.White, Justification = "CENTER" })
	end

	if costOverride then
		consumableItem.ResourceCosts = { Money = costOverride }
	end
	consumableItem.BaseResourceCosts = ShallowCopyTable( consumableItem.ResourceCosts )

	if consumableItem.AddResources ~= nil then
		SetupResourceText( consumableItem )
	end

	local costMultiplier = GetShopCostMultiplier()
	if consumableItem.ResourceCosts ~= nil and costMultiplier ~= 1 and ( consumableItem.IgnoreCostIncrease == nil or costMultiplier < 1 ) then
		for resourceName, resourceAmount in pairs( consumableItem.ResourceCosts ) do
			consumableItem.ResourceCosts[resourceName] = round( consumableItem.ResourceCosts[resourceName] * costMultiplier )
		end
	end

	if consumableItem.ResourceCosts ~= nil then
		consumableItem.ManualRecordUse = true
	end

	UpdateCostText( consumableItem )

	if args.AutoLoadPackages then
		if consumableItem.SpeakerName ~= nil then
			LoadVoiceBanks( consumableItem.SpeakerName, nil, args.IgnoreAssert )
		end
		if consumableItem.LoadPackages ~= nil then
			LoadPackages( { Names = consumableItem.LoadPackages, IgnoreAssert = args.IgnoreAssert } )
		end
	end

	if consumableItem.SetupEvents ~= nil then
		RunEventsGeneric( consumableItem.SetupEvents, consumableItem, args )
	end

	return consumableItem
end

function ApplyConsumableItemResourceMultiplier( currentRoom, reward )
	local coinRewardMultiplier = GetTotalHeroTraitValue("MoneyRewardBonus", { IsMultiplier = true })
	local healthRewardMultiplier = GetTotalHeroTraitValue("HealthRewardBonus", { IsMultiplier = true })
	local resourceBonuses = {}
	if reward.NPCDrop then
		coinRewardMultiplier = 1
		healthRewardMultiplier = 1
	else
		for i, data in pairs (GetHeroTraitValues("RoomRewardBonus")) do
			for resourceName, bonusValue in pairs( data ) do
				if not resourceBonuses[resourceName] then
					resourceBonuses[resourceName] = 1
				end
				resourceBonuses[resourceName] = resourceBonuses[resourceName] + (bonusValue - 1)
			end
		end


		if reward.AddResources ~= nil then
			for resourceName, value in pairs( reward.AddResources ) do
				if resourceBonuses[resourceName] then
					reward.AddResources[resourceName] = round( value * resourceBonuses[resourceName])
				end
			end
		end
	end
	SetupResourceText( reward )
	if reward.AddMaxHealth ~= nil then
		reward.AddMaxHealth = round( reward.AddMaxHealth * healthRewardMultiplier )
	end
	
	local rewardOverrides = currentRoom.RewardConsumableOverrides or currentRoom.RewardOverrides
	if rewardOverrides ~= nil and ( rewardOverrides.ValidRewardNames == nil or Contains( rewardOverrides.ValidRewardNames, reward.Name )) then
		for key, value in pairs( rewardOverrides ) do
			if reward[key] ~= nil then
				reward[key] = value
				if key == "AddMaxHealth" and reward.AddMaxHealth ~= nil then
					reward.AddMaxHealth = round( reward.AddMaxHealth * healthRewardMultiplier )
					if reward.ExtractValues ~= nil then
						ExtractValues( CurrentRun.Hero, reward, reward )
					end
				end
			end
		end
	end

	if reward.DropMoney ~= nil then
		local moneyMultiplier = GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )
		reward.DropMoney = round( reward.DropMoney * ( 1 + ( moneyMultiplier - 1 ) + ( coinRewardMultiplier - 1 )))
	end
end


function RecordConsumableItem( consumableItem )
	if consumableItem.IgnorePurchase then
	return
	end
	CheckCodexUnlock( "Items", GetGenusName( consumableItem ) )

	GameState.ItemInteractions[consumableItem.Name] = (GameState.ItemInteractions[consumableItem.Name] or 0) + 1
	CurrentRun.ConsumableRecord[consumableItem.Name] = (CurrentRun.ConsumableRecord[consumableItem.Name] or 0) + 1
end

function UseConsumableItem( consumableItem, args, user )

	args = args or {}

	local currentRun = CurrentRun
	if SessionMapState.HandlingDeath then
		return
	end

	if consumableItem.BlockUse then
		return
	end
	if not HasResources(consumableItem.ResourceCosts) then
		CantAffordPresentation( consumableItem )
		return
	end
	if not HasResources(consumableItem.ResourceCosts) or ( consumableItem.PurchaseRequirements ~= nil and not IsGameStateEligible( consumableItem, consumableItem.PurchaseRequirements )) then
		CantPurchaseWorldItemPresentation( consumableItem )
		return
	end

	if consumableItem.EnemiesBlockInteraction and not CurrentRun.CurrentRoom.AlwaysAllowLootInteraction then
		for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
			if enemy.BlocksLootInteraction then
				thread( InteractBlockedByEnemiesPresentation, consumableItem, args, user )
				return false
			end
		end
	end

	if consumableItem.ManualRecordUse then
		RecordUse( consumableItem.ObjectId, consumableItem.Name )
	end
	UseableOff({ Id = consumableItem.ObjectId })
	
	ConsumableUsedPresentation( currentRun, consumableItem, args )
	if not consumableItem.IgnorePurchase then
		local screenName = consumableItem.ScreenNameOnUse
		RemoveStoreItem( { Id = consumableItem.ObjectId, Name = consumableItem.Name, ScreenName = screenName } )
		RecordConsumableItem( consumableItem )

		SpendResources( consumableItem.ResourceCosts, consumableItem.Name )
		if consumableItem.ResourceCosts ~= nil and (consumableItem.ResourceCosts.Money or 0) > 0 then
			HandleCharonPurchase( "UseConsumableItem", consumableItem.ResourceCosts.Money )
		end
	end

	if consumableItem.AddAmmo ~= nil then
		local weaponName = consumableItem.AddAmmoWeapon or "RangedWeapon"
		AddAmmo( weaponName )
		AddAmmoPresentation()
	end

	if consumableItem.HealFraction ~= nil then
		local healFraction = consumableItem.HealFraction
		healFraction = healFraction * CalculateHealingMultiplier()
		Heal( CurrentRun.Hero, { HealFraction = healFraction, SourceName = consumableItem.Name or "Item" } )
		FrameState.RequestUpdateHealthUI = true
	end

	if consumableItem.HealFixed ~= nil then
		local healAmount = consumableItem.HealFixed * CalculateHealingMultiplier()
		healAmount = round( healAmount * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true }) )
		Heal( CurrentRun.Hero, { HealAmount = healAmount, SourceName = consumableItem.Name or "Item" } )
		FrameState.RequestUpdateHealthUI = true
	end

	if consumableItem.AddMana ~= nil then
		ManaDelta( consumableItem.AddMana )
	end

	if consumableItem.DestroyOnPickupId ~= nil and ActiveEnemies[consumableItem.DestroyOnPickupId] then
		thread( Kill, ActiveEnemies[consumableItem.DestroyOnPickupId], { ImpactAngle = 0, AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId })
	end
	RemoveScreenEdgeIndicator( consumableItem )

	if consumableItem.AddMaxHealth ~= nil then
		AddMaxHealth( consumableItem.AddMaxHealth, consumableItem, consumableItem.AddMaxHealthArgs )
	end
	
	if consumableItem.AddArmor ~= nil then
		AddArmor( consumableItem.AddArmor, consumableItem.AddArmorArgs )
	end

	if consumableItem.AddRerolls ~= nil then
		AddRerolls( consumableItem, { Amount = consumableItem.AddRerolls } )
	end
	if consumableItem.AddMaxMana ~= nil then
		AddMaxMana( consumableItem.AddMaxMana, consumableItem, consumableItem.AddMaxManaArgs )
	end

	if consumableItem.HealthCost ~= nil then
		SacrificeHealth({ SacrificeHealth = consumableItem.HealthCost, MinHealth = 1, DeductHealth = true})
		FrameState.RequestUpdateHealthUI = true
	end

	if consumableItem.DropMoney ~= nil then
		if consumableItem.DropMoneyDelay == 0 then
			AddResource( "Money", consumableItem.DropMoney, consumableItem.Name, { Silent = false } )
			if CurrentRun.CurrentRoom.Store and not IsEmpty(CurrentRun.CurrentRoom.Store.Buttons) then
				for i, button in pairs(CurrentRun.CurrentRoom.Store.Buttons) do
					UpdateCostButton( button )
				end
			end
		else
			thread( GushMoney, { Amount = consumableItem.DropMoney, LocationId = consumableItem.ObjectId, Source = consumableItem.Name, Delay = consumableItem.DropMoneyDelay, Radius = consumableItem.DropMoneyRadius, PickupDelay = consumableItem.DropMoneyPickupDelay } )
		end
	end

	if consumableItem.AddResources ~= nil then
		for resourceName, count in pairs( consumableItem.AddResources ) do
			AddResource( resourceName, count, consumableItem.Name, { Silent = false, ApplyMultiplier = true } )
		end
	end

	if consumableItem.AddStackTraits ~= nil then
		thread(AddStackToTraits, consumableItem, { NumTraits = consumableItem.AddStackTraits, NumStacks = 1, Thread = consumableItem.AddStackTraitsThread, Delay = consumableItem.AddStackTraitsDelay } )
	end

	if consumableItem.GiveObjectiveSet ~= nil then
		CheckObjectiveSet( consumableItem.GiveObjectiveSet )
	end

	if consumableItem.CompleteObjective ~= nil then
		thread(MarkObjectiveComplete, consumableItem.CompleteObjective )
	end

	if consumableItem.UseFunctionName ~= nil then
		CallFunctionName( consumableItem.UseFunctionName, consumableItem.UseFunctionArgs, consumableItem )
	end

	if consumableItem.ApplyEffect ~= nil then
		ApplyEffect({ DestinationId = user.ObjectId, Id = user.ObjectId, EffectName = consumableItem.ApplyEffect, DataProperties = EffectData[consumableItem.ApplyEffect].DataProperties })
	end

	if consumableItem.ReplaceWithRandomLoot ~= nil then
		thread( UnwrapRandomLoot, consumableItem )
	end

	if consumableItem.UseFunctionNames ~= nil then
		for i, functionName in ipairs( consumableItem.UseFunctionNames ) do
			CallFunctionName( functionName, consumableItem.UseFunctionArgs[i] )
		end
	end

	if consumableItem.UseThreadedFunctionNames ~= nil then
		for i, functionName in ipairs( consumableItem.UseThreadedFunctionNames ) do
			thread( CallFunctionName, functionName, consumableItem, consumableItem.UseThreadedFunctionArgs[i] )
		end
	end
	if (consumableItem.CanDuplicate and RandomChance( GetTotalHeroTraitValue("DoubleRewardChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true }))) or consumableItem.RespawnAfterUse then
		UseableOn({ Id = consumableItem.ObjectId })
		SetAlpha({ Id = consumableItem.ObjectId, Fraction = 1, Duration = 0 })
		thread( DoubleRewardPresentation, consumableItem.ObjectId )
		consumableItem.CanDuplicate = false	
	else
		MapState.RoomRequiredObjects[consumableItem.ObjectId] = nil
		MapState.ActiveObstacles[consumableItem.ObjectId] = nil
		if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.RewardsToRestore ~= nil then
			CurrentRun.CurrentRoom.Encounter.RewardsToRestore[consumableItem.ObjectId] = nil
		end
		Destroy({ Id = consumableItem.ObjectId })
	end

	if consumableItem.LastRewardEligible  then
		local displayName = consumableItem.Name
		if consumableItem.AddResources and TableLength(consumableItem.AddResources) == 1 then
			displayName = ResourceData[GetFirstKey(consumableItem.AddResources)].TooltipId
		end
		CurrentRun.LastReward = { Type = "Consumable", Name = consumableItem.Name, DisplayName = displayName }
		--[[
		DebugAssert({ 
			Condition = HasDisplayName({ Text = consumableItem.Name }) or HasDisplayName({ Text = displayName }), 
			Text = "Consumable is LastRewardEligible, but is missing DisplayName for "..displayName, 
			Owner = "Dexter" 
		})
		]]
	end

	wait( 0.2, "CheckRoomExitsReady" )
	if not consumableItem.SkipCheckRoomExitsReady and CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom, consumableItem.ExitUnlockDelay )
	end

end

function GushMoney( args )
	-- source might be destroyed after this is called so we create a target
	if args.Radius == nil then
		args.Radius = 100
	end
	local generatedSpawnId = nil
	if args.LocationId then
		generatedSpawnId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = args.LocationId, Group = "Standing" })
		args.LocationId = generatedSpawnId
	end

	wait( args.Delay )
	local money = round( args.Amount )
	local minDrop = math.max( 5, money / 10 )
	local maxDrop = math.max( 25, money / 4)
	while money > 0 do
		local moneyDrop = RandomInt( math.min( money, minDrop ), math.min( money, maxDrop ) )
		DropMoney( moneyDrop, args )
		money = money - moneyDrop
		wait( RandomFloat( 0.03, 0.07 ) )
	end

	if generatedSpawnId then
		Destroy({ Id = generatedSpawnId })
	end
end

function GetSecretDoorCost()
	local multiplier = 1
	local traitEffects = GetHeroTraitValues("SecretDoorCostMultiplier")
	for i, value in pairs(traitEffects) do
		multiplier = multiplier * value
	end
	local costBase = CurrentRun.Hero.SecretDoorCostBase or 10
	local costScalar = CurrentRun.Hero.SecretDoorCostDepthScalar or 0.5
	local costRamp = GetRunDepth( CurrentRun ) * costScalar
	return math.ceil( multiplier * ( costBase + costRamp ) )
end

function GetRampedConsumableData( consumableData, args )
	if consumableData == nil then
		return
	end
	args = args or {}
	local rampedData = DeepCopyTable( consumableData )
	local rarityMultiplier = 1

	if args.DataOverrides ~= nil then
		for key, value in pairs( args.DataOverrides ) do
			if rampedData[key] ~= nil then
				rampedData[key] = value
			end
		end
	end

	for key, value in pairs( rampedData ) do
		if not ProcessTraitDataBlacklist[key] and type( value ) == "table" then
			rampedData[key] = GetProcessedValue( value, { NumExisting = 0, RarityMultiplier = rarityMultiplier, ForceMin = args.ForceMin, ForceMax = args.ForceMax }, key )
		end
	end

	if rampedData.ExtractValues ~= nil then
		ExtractValues( CurrentRun.Hero, rampedData, rampedData )
	end
	if rampedData.HealCostPerPercent ~= nil then
		rampedData.ResourceCosts = { Money = round(rampedData.HealCostPerPercent * rampedData.HealFraction * 100) }
	end
	if rampedData.CostPerMetaCurrency ~= nil then
		rampedData.ResourceCosts = { Money = round(rampedData.CostPerMetaCurrency * rampedData.AddResources.MetaCurrency) }
	end
	if rampedData.CostPerMetaCardPointsCommon ~= nil then
		rampedData.ResourceCosts = { Money = round(rampedData.CostPerMetaCardPointsCommon * rampedData.AddResources.MetaCardPointsCommon) }
	end
	if rampedData.CostPerMemPointsCommon ~= nil then
		rampedData.ResourceCosts = { Money = round(rampedData.CostPerMemPointsCommon * rampedData.AddResources.MemPointsCommon) }
	end
	if rampedData.CostPerSeedMystery ~= nil then
		rampedData.ResourceCosts = { Money = round(rampedData.CostPerSeedMystery * rampedData.AddResources.SeedMystery) }
	end
	if rampedData.PayoutPerHealthPoint ~= nil then
		if HasHeroTraitValue("BlockMoney") then
			rampedData.DropMoney = 0
		else
			rampedData.DropMoney = round(rampedData.PayoutPerHealthPoint * rampedData.HealthCost)
		end
	end

	if rampedData.UseFunctionArgs ~= nil then
		if rampedData.UseFunctionName ~= nil then
			if rampedData.UseFunctionArgs.TraitName ~= nil then
				local processedTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = rampedData.UseFunctionArgs.TraitName })
				SetTraitTextData( processedTraitData )
				rampedData.TraitData = processedTraitData
			end
		end
		if rampedData.UseFunctionNames ~= nil then
			for i, data in pairs(rampedData.UseFunctionArgs) do
				if data.TraitName ~= nil then
					local processedTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = data.TraitName })
					SetTraitTextData( processedTraitData )
					rampedData.TraitData = processedTraitData
				end
			end
		end
	end

	return rampedData
end

function SacrificeHealth( args )
	args = args or {}
	args.MinHealth = args.MinHealth or 1
	if args.SacrificeHealth == nil and ( args.SacrificeHealthMin == nil or args.SacrificeHealthMax == nil )then
		return 0
	end
	local randomDamageValue = args.SacrificeHealth
	if randomDamageValue == nil then
		randomDamageValue = RandomInt( args.SacrificeHealthMin, args.SacrificeHealthMax )
	end
	if randomDamageValue <= 0 then
		return randomDamageValue
	end
	if args.DeductHealth then
		CurrentRun.TotalDamageTaken = CurrentRun.TotalDamageTaken + randomDamageValue
		CurrentRun.Hero.Health = CurrentRun.Hero.Health - randomDamageValue
		if CurrentRun.Hero.Health < args.MinHealth then
			CurrentRun.Hero.Health = args.MinHealth
		end
		if args.AttackerName ~= nil then
			CurrentRun.DamageTakenFromRecord[args.AttackerName] = (CurrentRun.DamageTakenFromRecord[args.AttackerName] or 0) + randomDamageValue
		end
	else
		Damage( CurrentRun.Hero, { triggeredById = CurrentRun.Hero.ObjectId, DamageAmount = randomDamageValue, MinHealth = args.MinHealth, PureDamage = true, Silent = args.Silent, IgnoreCap = args.IgnoreCap, IgnoreHealthBuffer = args.IgnoreHealthBuffer, ManuallyTriggered = args.ManuallyTriggered, AttackerName = args.AttackerName } )
	end
	if not args.Silent and not CurrentRun.Hero.IsDead then
		CreateAnimation({ Name = "SacrificeHealthFx", DestinationId = CurrentRun.Hero.ObjectId })
	end
	return randomDamageValue
end

function SacrificeHealthAndHeal( args )
	local healAmount = math.ceil(SacrificeHealth( args ) * args.HealMultiplier)
	wait(1.5)
	local currentHealthFraction = CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth
	if currentHealthFraction < 1.0 then
		Heal( CurrentRun.Hero, { HealAmount = healAmount, SourceName = "SacrificeHealthAndHeal" } )
		thread( InCombatText, CurrentRun.Hero.ObjectId, "PlayerHealed_Amount", 1.5 , { LuaKey = "TempTextData", LuaValue = {Amount = healAmount} })
		FrameState.RequestUpdateHealthUI = true
	end
end

function AttemptPanelReroll( screen, button )

	local cost = button.Cost
	if not cost then
		return
	end

	if ScreenState.InTransition then
		return
	end
	
	if (CurrentRun.NumRerolls or 0) < cost or cost < 0 then
		CannotRerollPanelPresentation( button )
		return
	end

	AddInputBlock({ Name = "AttemptPanelReroll" })
	HideTopMenuScreenTooltips({ })
	CurrentRun.NumRerolls = CurrentRun.NumRerolls - cost
	CurrentRun.CurrentRoom.SpentRerolls = CurrentRun.CurrentRoom.SpentRerolls or {}
	if button.RerollId then
		IncrementTableValue( CurrentRun.CurrentRoom.SpentRerolls, button.RerollId, RerollCosts.ReuseIncrement )
	end
	UpdateRerollUI( CurrentRun.NumRerolls )

	RandomSynchronize( CurrentRun.NumRerolls )
	InvalidateCheckpoint()

	if button and button.RerollFunctionName ~= nil then
		ScreenState.InTransition = true
		PreRerollPanelPresentation( screen, button )
		CallFunctionName( button.RerollFunctionName, screen, button )
		PostRerollPanelPresentation( screen, button )
	end
	wait( 0.1 )
	RemoveInputBlock({ Name = "AttemptPanelReroll" })
	wait( 0.95 )
	ScreenState.InTransition = false
end

function AttemptReroll( run, target )

	if run.NumRerolls <= 0 then
		return
	end

	if target == nil or not target.CanBeRerolled then
		return
	end

	if target.RerollFunctionName == nil then
		return
	end

	local cost = 1
	run.NumRerolls = run.NumRerolls - cost
	UpdateRerollUI( run.NumRerolls )
	thread( RerollSpendPresentation, cost )

	RandomSynchronize( run.NumRerolls )

	local room = target.Room
	if room.CageRewards ~= nil then
		target.RerollIndex = RandomInt( 1, #room.CageRewards )
		target.RerollFunctionName = "AttemptRerollFieldsDoor"
	end

	AddInputBlock({ Name = "AttemptReroll" })
	PreRerollPresentation( run, target )
	CallFunctionName( target.RerollFunctionName, run, target )
	PostRerollPresentation( run, target )

	InvalidateCheckpoint()

	RemoveInputBlock({ Name = "AttemptReroll" })
end

function AttemptRerollDoor( run, door )

	local room = door.Room

	local rewardsChosen = {}
	if room.OriginalChosenRewardType == nil then
		room.OriginalChosenRewardType = room.ChosenRewardType
	end
	if room.OriginalForceLootName == nil then
		room.OriginalForceLootName = room.ForceLootName
	end
	table.insert( rewardsChosen, { RewardType = room.OriginalChosenRewardType, ForceLootName = room.OriginalForceLootName } )
	for index, offeredDoor in pairs( MapState.OfferedExitDoors ) do
		if offeredDoor.Room ~= nil then
			table.insert( rewardsChosen, { RewardType = offeredDoor.Room.ChosenRewardType, ForceLootName = offeredDoor.Room.ForceLootName } )
		end
	end

	-- Remove the existing reward
	room.PrevForceLootName = room.ForceLootName
	room.ForceLootName = nil
	room.RewardOverrides = nil
	if room.Encounter ~= nil then
		if room.Encounter.LootAName ~= nil then
			local animName = LootData[room.Encounter.LootAName].DoorIcon
			Destroy({ Id = door.AdditionalIcons[animName] })
			door.AdditionalIcons[animName] = nil
			room.Encounter.LootAName = nil
		end
		if room.Encounter.LootBName ~= nil then
			local animName = LootData[room.Encounter.LootBName].DoorIcon
			Destroy({ Id = door.AdditionalIcons[animName] })
			door.AdditionalIcons[animName] = nil
			room.Encounter.LootBName = nil
		end
		room.Encounter = nil
	end

	local prevChosenRewardType = room.ChosenRewardType

	run.CurrentRoom.DeferReward = false
	room.ChosenRewardType = ChooseRoomReward( run, room, room.RewardStoreName, rewardsChosen, { IgnoreGameStateRequirements = false, } )
	SetupRoomReward( run, room, rewardsChosen )
	run.CurrentRoom.OfferedRewards[door.ObjectId] = { Type = room.ChosenRewardType, ForceLootName = room.ForceLootName, UseOptionalOverrides = room.UseOptionalOverrides }

	if room.ChosenRewardType == "Devotion" and prevChosenRewardType ~= "Devotion" then
		SetScale({ Ids = door.RewardPreviewIconIds, Fraction = 0.0, Duration = 0.1 })
	else
		SetScale({ Ids = door.RewardPreviewIconIds, Fraction = 1.0, Duration = 0.1 })
	end

	CreateDoorRewardPreview( door, nil, nil, nil, { ReUseIds = true } )

	RefreshUseButton( door.ObjectId, door )

end

function AttemptRerollFieldsDoor( run, door )

	local room = door.Room

	if room.CageRewards == nil then
		AttemptRerollDoor( run, door )
		return
	end
	
	local cageRoom = DeepCopyTable( room )
	cageRoom.NeedsReward = true
	cageRoom.NoReward = false
	cageRoom.ChosenRewardType = ChooseRoomReward( CurrentRun, cageRoom, cageRoom.RewardStoreName, room.CageRewards )
	SetupRoomReward( CurrentRun, cageRoom, room.CageRewards, { Door = door, IgnoreForceLootName = cageRoom.IgnoreForceLootName } )
	local cageReward = { RewardType = cageRoom.ChosenRewardType, ForceLootName = cageRoom.ForceLootName, }
	room.CageRewards[door.RerollIndex] = cageReward

	CreateDoorRewardPreview( door, cageReward.RewardType, cageReward.ForceLootName, door.RerollIndex, { SkipCageRewards = true, ReUseIds = true, } )

	RefreshUseButton( door.ObjectId, door )

end

function AttemptRerollShipWheel( run, wheel )

	local rewardsChosen = {}
	if wheel.OriginalChosenRewardType == nil then
		wheel.OriginalChosenRewardType = wheel.ChosenRewardType
	end
	if wheel.OriginalForceLootName == nil then
		wheel.OriginalForceLootName = wheel.ForceLootName
	end
	table.insert( rewardsChosen, { RewardType = wheel.OriginalChosenRewardType, ForceLootName = wheel.OriginalForceLootName } )
	for id, wheel in pairs( MapState.ShipWheels ) do
		table.insert( rewardsChosen, { RewardType = wheel.ChosenRewardType, ForceLootName = wheel.ForceLootName } )
	end

	wheel.ChosenRewardType = ChooseRoomReward( CurrentRun, CurrentRun.CurrentRoom, wheel.RewardStoreName, rewardsChosen, { IgnoreForcedReward = true } )
	SetupRoomReward( CurrentRun, wheel.Room, rewardsChosen, { ChosenRewardType = wheel.ChosenRewardType, AlwaysSetupForceLootName = true } )
	wheel.ForceLootName = wheel.Room.ForceLootName

	CreateDoorRewardPreview( wheel, wheel.ChosenRewardType, wheel.ForceLootName, nil, { ReUseIds = true } )

	RefreshUseButton( wheel.ObjectId, wheel )

end

function AddKeepsakeCharge( args )
	args = args or {}
	if args.Thread then
		args.Thread = false
		thread( AddKeepsakeCharge, args )
		return
	end
	wait( args.Delay )
end

function AddControlBlock( controlName, flag )
	SessionMapState.PlayerControlBlocks[controlName] = SessionMapState.PlayerControlBlocks[controlName] or {}
	SessionMapState.PlayerControlBlocks[controlName][flag] = true
	ToggleControl({ Names = controlName, Enabled = false })
end

function RemoveControlBlock( controlName, flag )
	SessionMapState.PlayerControlBlocks[controlName] = SessionMapState.PlayerControlBlocks[controlName] or {}
	SessionMapState.PlayerControlBlocks[controlName][flag] = nil
	if IsEmpty( SessionMapState.PlayerControlBlocks[controlName] ) then
		ToggleControl({ Names = controlName, Enabled = true })
	end	
end

function ClearCombatControlBlock( flag )
	flag = flag or "Generic"
	local enabledControls = {}
	for controlName, data in pairs( SessionMapState.PlayerControlBlocks ) do
		if data[flag] then
			table.insert( enabledControls, controlName )
		end
	end
	if not IsEmpty( enabledControls ) then
		ToggleCombatControl( enabledControls, true, flag )
	end
end

function IsAggroedUnitBlockingInteract()
	for id, v  in pairs( ShallowCopyTable( MapState.AggroedUnits ) ) do
		local unit = ActiveEnemies[id]
		if unit ~= nil and not unit.AllowInteractWhileAggroed and not unit.AlwaysTraitor then
			return true
		end
	end
	return false
end

function TogglePlayerMove( enabled, flag )
	if enabled then
		SessionMapState.PlayerMoveBlocks[flag] = nil
	else
		SessionMapState.PlayerMoveBlocks[flag] = true
	end

	if IsEmpty( SessionMapState.PlayerMoveBlocks) then
		ToggleMove({ Enabled = true })
	else
		ToggleMove({ Enabled = false })
	end
end

function ToggleCombatControl( controlNames, enabled, flag )
	flag = flag or "Generic"
	local enabledControls = {}
	local disabledControls = {}
	for i, controlName in pairs( controlNames ) do
		local wasEnabled = not SessionMapState.PlayerControlBlocks[controlName] or IsEmpty( SessionMapState.PlayerControlBlocks[controlName] )
		SessionMapState.PlayerControlBlocks[controlName] = SessionMapState.PlayerControlBlocks[controlName] or {}
		if not enabled then 
			SessionMapState.PlayerControlBlocks[controlName][flag] = true
		else			
			SessionMapState.PlayerControlBlocks[controlName][flag] = nil
		end
		local isEnabled = not SessionMapState.PlayerControlBlocks[controlName] or IsEmpty( SessionMapState.PlayerControlBlocks[controlName] )
		if wasEnabled ~= isEnabled then
			if isEnabled then
				table.insert( enabledControls, controlName )
			else
				table.insert( disabledControls, controlName )
			end
		end
	end

	if not IsEmpty( enabledControls ) then
		ToggleControl({ Names = enabledControls , Enabled = true })
	end
	if not IsEmpty( disabledControls ) then
		ToggleControl({ Names = disabledControls , Enabled = false })
	end
end

function AddInteractBlock( object, flag )
	if object == nil then
		return
	end
	object.InteractBlocks = object.InteractBlocks or {}
	object.InteractBlocks[flag] = true
	UseableOff({ Id = object.ObjectId or object.Id })
end

function RemoveInteractBlock( object, flag )
	if object == nil then
		return
	end
	object.InteractBlocks = object.InteractBlocks or {}
	object.InteractBlocks[flag] = nil
	if IsEmpty( object.InteractBlocks ) then
		UseableOn({ Id = object.ObjectId or object.Id })
	end
end

function UsePoisonCure( fountain, args )
	if CheckCooldown(fountain.CooldownNamePrefix..fountain.ObjectId, fountain.CooldownDuration) then
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "MedeaPoison" })
		ExpireProjectiles({ Names = { "PoisonPuddle", "PoisonPuddleSmall" }, Range = fountain.ExpirePoisonPuddleRadius or 0, Id = fountain.ObjectId })
		CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = fountain.OnUsedConsumeFx })
		-- @ this should be in a presentation function
		if CurrentRun.Hero.CurrentlyPoisoned then
			PlaySound({ Name = "/Leftovers/SFX/StaminaRefilled", Id = CurrentRun.Hero.ObjectId })
			thread( PlayVoiceLines, HeroVoiceLines.PoisonCuredVoiceLines, true )
		end
		--BlockEffect({ Id = CurrentRun.Hero.ObjectId, Name = "MedeaPoison", Duration = 0.75 })
		SetAnimation({ DestinationId = fountain.ObjectId, Name = fountain.OnCooldownAnimation })
		UseableOff({ Id = fountain.ObjectId })
		PoisonCureReady( fountain )
	end
end


function PoisonCureReady(fountain)
	wait( fountain.CooldownDuration, RoomThreadName )
	SetAnimation({ DestinationId = fountain.ObjectId, Name = fountain.IdleAnimation })
	UseableOn({ Id = fountain.ObjectId })
end