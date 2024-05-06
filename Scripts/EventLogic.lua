function RunEvents( eventSource, events )
	RunThreadedEvents( (events or eventSource).ThreadedEvents, eventSource )
	RunEventsGeneric( (events or eventSource).PreUnthreadedEvents, eventSource )
	RunEventsGeneric( (events or eventSource).UnthreadedEvents, eventSource )
	RunEventsGeneric( (events or eventSource).PostUnthreadedEvents, eventSource )
end

function RunThreadedEvents( events, eventSource )
	if events == nil then
		return
	end
	-- Back-compat
	if not events.Threaded then
		for k, event in ipairs( events ) do
			event.Threaded = true
		end
	end
	RunEventsGeneric( events, eventSource )
end

function RunEventsGeneric( events, eventSource, contextArgs )

	if events == nil then
		return
	end

	contextArgs = contextArgs or {}
	if events.Threaded and not contextArgs.AlreadyThreaded then
		contextArgs.AlreadyThreaded = true
		thread( RunEventsGeneric, events, eventSource, contextArgs )
		return
	end

	for k, event in ipairs( events ) do
		if event.FunctionName == nil then
			DebugAssert({ Condition = false, Text = "No event FunctionName defined on "..GetTableString( eventSource ) })
		end
		if event.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, event, event.GameStateRequirements, contextArgs ) then
			if event.Threaded then
				thread( CallFunctionName, event.FunctionName, eventSource, event.Args, contextArgs )
			else
				CallFunctionName( event.FunctionName, eventSource, event.Args, contextArgs )
			end
			if event.BreakIfPlayed then
				return
			end
		else
			if event.FailedFunctionName ~= nil then
				CallFunctionName( event.FailedFunctionName, eventSource, event.FailedFunctionArgs )
			end
		end
	end

	if verboseLogging then
		if events.FunctionName ~= nil then
			DebugAssert({ Condition = false, Text = "FunctionName "..events.FunctionName.." incorrectly used at top level in event defined on "..GetTableString( eventSource ) })
		end
	end

end

function CallFunctionName( functionName, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, ... )
	if functionName == nil then
		return
	end
	local func = _G[functionName]
	if func ~= nil then
		local args = { arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, ... }
		local funcReturn = func( unpackTableArgs( args ) )
		return funcReturn
	else
		DebugAssert({ Condition = false, Text = "Function "..tostring(functionName).." does not exist" })
	end
end

function ActivatePrePlaced( eventSource, args )

	if args.Types ~= nil then
		args.EventSourceName = eventSource.Name
		for k, type in pairs( args.Types ) do
			local typeIds = GetInactiveIdsByType({ Name = type })
			Activate({ Ids = typeIds })
			thread( SetupUnits, typeIds, args )
		end
		return
	end

	local currentRun = CurrentRun

	local toActivate = {}
	if args.Groups ~= nil then
		for k, groupName in pairs( args.Groups ) do
			local ids = GetInactiveIds({ Name = groupName })
			for j, id in pairs( ids ) do
				local name = GetName({ Id = id, CheckInactive = true })
				local enemyData = EnemyData[name]
				if IsActivationEligible( id, enemyData ) then
					toActivate[id] = enemyData
				end
			end
		end
	else
		for enemyName, enemyData in pairs( EnemyData ) do
			if not enemyData.IgnoreTypeAutoActivate then
				local enemyTypeIds = GetInactiveIdsByType({ Name = enemyName })
				if args.LegalTypes == nil or Contains( args.LegalTypes, enemyName ) then
					for k, id in pairs( enemyTypeIds ) do
						if IsActivationEligible( id, enemyData ) then
							toActivate[id] = enemyData
						end
					end
				end
			end
		end
	end

	local prePlacedFraction = RandomFloat( args.FractionMin or 1.0, args.FractionMax or 1.0 )
	local prePlacedCount = TableLength( toActivate )
	local activateCount = round( prePlacedCount * prePlacedFraction )

	local activatedUnits = {}
	for i = 1, activateCount, 1 do
		local enemyId = GetRandomKey( toActivate )
		local enemyData = toActivate[enemyId]
		local newEnemy = DeepCopyTable( enemyData )
		newEnemy.ObjectId = enemyId
		Activate({ Id = newEnemy.ObjectId })
		thread( SetupUnit, newEnemy, currentRun, args )
		activatedUnits[newEnemy.ObjectId] = newEnemy
		toActivate[enemyId] = nil

		if args.SpawnOverrides ~= nil then
			for key, value in pairs( args.SpawnOverrides ) do
				newEnemy[key] = value
			end
		end

		if args.RestoreObjectState then
			RestoreMapStateObject( evenSource.Name, newEnemy )
		end

	end
	return activatedUnits
end

function ActivatePrePlacedObstacles( eventSource, args )
	Activate({ Ids = args.Ids, Names = args.Groups })
end

function ActivatePrePlacedUnits( eventSource, args )
	for k, id in pairs( args.Ids ) do
		local name = GetName({ Id = id, CheckInactive = true })
		if name ~= nil then
			local enemyData = EnemyData[name]
			local newEnemy = DeepCopyTable( enemyData )
			newEnemy.ObjectId = id
			Activate({ Id = newEnemy.ObjectId })
			thread(SetupUnit, newEnemy, CurrentRun, args )
			if args.DistanceTrigger ~= nil then
				thread( CheckDistanceTrigger, args.DistanceTrigger, newEnemy )
			end
			if args.FadeInDuration ~= nil then
				SetAlpha({ Id = id, Fraction = 0 })
				SetAlpha({ Id = id, Fraction = 1, Duration = args.FadeInDuration })
			end
			if args.CheckConversations then
				CheckAvailableTextLines( newEnemy )
			end
			if args.AddEncounterEvent ~= nil then
				table.insert( CurrentRun.CurrentRoom.Encounter.UnthreadedEvents, args.AddEncounterEvent )
			end
		end
	end
end

function ActivateOneOfAPrePlacedGroupSet( eventSource, args )
	if args.ActivationChance then
		if not RandomChance( args.ActivationChance ) then
			return
		end
	end
	local randomGroup = RemoveRandomValue( args.Groups )
	Activate({ Name = randomGroup })
	local ids = GetIds({ Name = randomGroup })
	for k, id in pairs( ids ) do
		local unitName = GetName({ Id = id })
		local unitData = EnemyData[unitName]
		if unitData ~= nil then
			local newUnit = DeepCopyTable( unitData )
			newUnit.ObjectId = id
			thread(SetupUnit, newUnit, CurrentRun, args )
		end
	end
end

function CheckPriorityConversations( eventSource, args )
	local priorityRecord = {}
	for k, conversationName in ipairs( args.Conversations ) do
		-- Find the conversation data
		for enemyName, enemyData in pairs( EnemyData ) do
			local conversationData = nil
			if enemyData.InteractTextLineSets ~= nil then
				conversationData = enemyData.InteractTextLineSets[conversationName]
			end
			if enemyData.BossIntroTextLineSets ~= nil then
				conversationData = enemyData.BossIntroTextLineSets[conversationName]
			end

			if conversationData ~= nil and conversationData[1] ~= nil and not NeedsUseableOff( enemyData ) then -- Looking for the real conversation, not partner placeholder
				local partnerName = conversationData.Partner
				if not priorityRecord[enemyName] and (partnerName == nil or not priorityRecord[partnerName] ) then -- Not already involved in a previous priority conversation
					if IsTextLineEligible( CurrentRun, eventSource, conversationData, nil, nil, args ) then					
						DebugPrint({ Text = "Global priority conversation: "..conversationName })					
						local unit = ActivateForPriorityConversation( enemyName, enemyData, conversationName, args )
						priorityRecord[enemyName] = true					
						local partner = nil
						if partnerName ~= nil then
							partner = ActivateForPriorityConversation( partnerName, EnemyData[partnerName], conversationName, args )
							priorityRecord[partnerName] = true
						end
						-- Assign the conversation immediately
						unit.NextInteractLines = unit.InteractTextLineSets[conversationName]
						SetNextInteractLines( unit, unit.NextInteractLines )
						if partner ~= nil then
							partner.NextInteractLines = partner.InteractTextLineSets[conversationName]
							SetNextInteractLines( partner, partner.NextInteractLines )
							OnPartnerConversationSet( unit, partner )
						end
						break
					end
				end
			end
		end
	end
end

function ActivateForPriorityConversation( enemyName, enemyData, conversationName, args )
	local typeIds = GetInactiveIdsByType({ Name = enemyName })
	if IsEmpty( typeIds ) then
		typeIds = GetIdsByType({ Name = enemyName }) -- Sometimes true in EditingMode
	end
	local id = RemoveRandomValue( typeIds )
	Activate({ Id = id })
	local newUnit = DeepCopyTable( enemyData )
	newUnit.ObjectId = id
	thread( SetupUnit, newUnit, CurrentRun, args )
	RestoreMapStateObject( (CurrentHubRoom or CurrentRun.CurrentRoom).Name, newUnit )
	if CurrentRun.AnimationState[newUnit.ObjectId] ~= nil then
		SetAnimation({ DestinationId = newUnit.ObjectId, Name = CurrentRun.AnimationState[newUnit.ObjectId] })
	end
	if CurrentRun.EventState ~= nil then
		local eventState = CurrentRun.EventState[newUnit.ObjectId]
		if eventState ~= nil then
			thread( CallFunctionName, eventState.FunctionName, newUnit, eventState.Args )
		end
	end
	CurrentRun.ActivationRecord[id] = true
	return newUnit
end

function ActivateRotatingNPCs( eventSource, args )

	local numActivations = 0
	local ids = {}
	ConcatTableValues( ids, args.Ids )
	if args.Types ~= nil then
		for k, type in ipairs( args.Types ) do
			local typeIds = GetInactiveIdsByType({ Name = type })
			ConcatTableValues( ids, typeIds )
			local existingTypeIds = GetIdsByType({ Name = type })
			numActivations = numActivations + TableLength( existingTypeIds )
		end
	end
	--DebugPrint({ Text = "prev numActivations = "..numActivations })

	local eligible = {}
	for i, id in ipairs( ids ) do
		local name = GetName({ Id = id, CheckInactive = true })
		local unitData = EnemyData[name]
		if IsActivationEligible( id, unitData ) then
			table.insert( eligible, { Id = id, UnitData = unitData } )
		end
	end

	local leaveOut = 0
	if args.LeaveOutMin ~= nil then
		 leaveOut = RandomInt( args.LeaveOutMin, args.LeaveOutMax )
	end
	local numEligible = TableLength( eligible )
	DebugPrint({ Text = "ActivateRotatingNPCs numEligible = "..numEligible })
	local numToActivate = numEligible - leaveOut
	if numToActivate > args.ActivationsMax then
		numToActivate = args.ActivationsMax
	end
	if numToActivate < args.ActivationsMin then
		numToActivate = args.ActivationsMin
	end
	DebugPrint({ Text = "ActivateRotatingNPCs numToActivate = "..numToActivate })

	while not IsEmpty( eligible ) do
		
		local toActivate = RemoveRandomValue( eligible )
		local id = toActivate.Id
		local unitData = toActivate.UnitData

		if ShouldRotatorActivate( id, unitData, numActivations, numToActivate ) then

			Activate({ Ids = id })
			local newUnit = DeepCopyTable( unitData )
			DebugPrint({ Text = "ActivateRotatingNPCs newUnit.Name = "..newUnit.Name })
			newUnit.ObjectId = id
			thread( SetupUnit, newUnit, CurrentRun, args )
			RestoreMapStateObject( (CurrentHubRoom or CurrentRun.CurrentRoom).Name, newUnit )
			if CurrentRun.AnimationState[newUnit.ObjectId] ~= nil then
				SetAnimation({ DestinationId = newUnit.ObjectId, Name = CurrentRun.AnimationState[newUnit.ObjectId] })
			end
			if CurrentRun.EventState ~= nil then
				local eventState = CurrentRun.EventState[newUnit.ObjectId]
				if eventState ~= nil then
					if eventState.FunctionName ~= nil then
						thread( CallFunctionName, eventState.FunctionName, newUnit, eventState.Args )
					end
				end
			end

			CurrentRun.ActivationRecord[id] = true
			numActivations = numActivations + 1
		else
			DebugPrint({ Text = "ActivateRotatingNPCs leaveOut = "..unitData.Name })
			if unitData.MissingDistanceTrigger ~= nil then
				local missingUnit = {}
				missingUnit.Name = unitData.Name
				missingUnit.ObjectId = SpawnObstacle({ Name = "BlankObstacle" })
				local location = GetLocation({ Id = id, CheckInactive = true })
				Teleport({ Id = missingUnit.ObjectId, OffsetX = location.X, OffsetY = location.Y })
				thread( CheckDistanceTrigger, unitData.MissingDistanceTrigger, missingUnit )
			end
		end
	end

end

function ShouldRotatorActivate( id, unitData, numActivations, activationCap )

	if activationCap == nil then
		return true
	end

	if numActivations < activationCap then
		return true
	end

	if not GameState.NPCInteractions[unitData.Name] then
		return true
	end

	if CurrentRun.ActivationRecord[id] then
		return true
	end

	if not IsEmpty( GameState.RunHistory ) then
		local prevRun = GameState.RunHistory[#GameState.RunHistory]
		if prevRun ~= nil and not prevRun.ActivationRecord[id] then
			return true
		end
	end

	return false

end

function IsActivationEligible( id, sourceData )

	if sourceData == nil then
		return false
	end

	if sourceData.ActivateRequirements ~= nil and not IsGameStateEligible( CurrentRun, sourceData.ActivateRequirements ) then
		return false
	end

	return true

end

function SetupPrePlacedUnits(room, args)
	local unitIds = args.Ids or {}
	if args.TypeNames ~= nil then
		for k, typeName in pairs(args.TypeNames) do
			ConcatTableValues(unitIds, GetIdsByType({ Name = typeName }))
		end
	end

	SetupUnits(unitIds, args)
end

function SetupUnits( ids, args )
	args = args or {}

	for k, id in pairs( ids ) do
		local name = GetName({ Id = id })
		local enemyData = EnemyData[name]
		if enemyData ~= nil then
			local newEnemy = DeepCopyTable( enemyData )
			newEnemy.ObjectId = id
			if args.OverwriteSelf ~= nil then
				OverwriteSelf( newEnemy, args.OverwriteSelf )
			end
			thread( SetupUnit, newEnemy, CurrentRun, args )
			if args.CheckConversations then
				CheckConversations( newEnemy )
			end
			if args.RestoreObjectState then
				RestoreMapStateObject( args.EventSourceName, newEnemy )
			end
		end
	end

end

function ActivateObjects( eventSource, args )
	if args.ObjectType == nil and args.ObjectTypes == nil then
		return nil
	end

	local ids = GetInactiveIdsByType({ Name = args.ObjectType, Names = args.ObjectTypes })
	Activate({ Ids = ids })

end

function SelectFieldsDoorCageCount( run, room )
	if run.FieldsMaxDoorsRolled == nil then
		run.FieldsMaxDoorsRolled = 0
	end
	local maxDoorData = room.MaxDoorDepthChanceTable[run.BiomeDepthCache]
	if maxDoorData == nil then
		DebugPrint({ Text = "Fields Max Door -- Max Door Data Not Found" })
		return
	end
	local maxDoorChance = maxDoorData.MaxDoorChance or 0
	local maxDoorSuccess = false
	DebugPrint({ Text = "Fields Max Door -- Fields Max Door Chance = "..maxDoorChance })
	if RandomChance( maxDoorChance ) then
		DebugPrint({ Text = "Fields Max Door -- Success" })
		maxDoorSuccess = true
	end
	if maxDoorSuccess and run.FieldsMaxDoorsRolled < room.MaxDoorCageCeiling then
		DebugPrint({ Text = "Fields Max Door -- Selected" })
		run.FieldsMaxDoorsRolled = run.FieldsMaxDoorsRolled + 1
		return room.MaxDoorCageRewards
	elseif not maxDoorSuccess and maxDoorData.CeilingCheck and run.FieldsMaxDoorsRolled < room.MaxDoorCageCeiling then
		DebugPrint({ Text = "Fields Max Door -- Door Selected Because of Ceiling Check" })
		run.FieldsMaxDoorsRolled = run.FieldsMaxDoorsRolled + 1
		return room.MaxDoorCageRewards
	else
		DebugPrint({ Text = "Fields Max Door -- Min Doors Selected" })
		return room.MinDoorCageRewards
	end

end

function HandleChallengeLoot( challengeSwitch, challengeEncounter )
	if challengeEncounter == nil then
		return
	end

	if challengeEncounter.EncounterType == "PerfectClear" and challengeEncounter.PlayerTookDamage then
		challengeSwitch.RewardType = "RoomRewardConsolationPrize"
	end

	Destroy({ Id = challengeSwitch.ValueTextAnchor })
	SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = "ChallengeSwitchOpen" })

	-- presentation
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ChestOpen", Id = challengeSwitch.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })
	local healingMultiplier = CalculateHealingMultiplier()
	if ( challengeSwitch.RewardType == "Health" and healingMultiplier == 0 ) or (challengeSwitch.RewardType == "Money" and HasHeroTraitValue("BlockMoney")) then
		thread( PlayVoiceLines, GlobalVoiceLines.ChallengeSwitchEmptyVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.ChallengeSwitchOpenedVoiceLines, true )
	end

	UseableOff({ Id = challengeSwitch.ObjectId })


	if not challengeEncounter.PlayerTookDamage then
		local lootPointId = CurrentRun.Hero.ObjectId
		--local angle = GetAngleBetween({ Id = challengeSwitch.ObjectId, DestinationId = lootPointId })
		local angle = GetAngleBetween({ Id = challengeSwitch.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		local distance = GetDistance({ Id = challengeSwitch.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		local dropOffset = CalcOffset(math.rad(angle), distance/2)

		for lootName, lootData in pairs(challengeEncounter.LootDrops) do
			if lootData.DropChance == nil or RandomChance(lootData.DropChance) then
				local minDrop = lootData.MinDrop or 1
				local maxDrop = lootData.MaxDrop or 1
				local dropCount = lootData.DropCount or RandomInt(minDrop, maxDrop)
				for index = 1, dropCount, 1 do
					local consumableId = SpawnObstacle({ Name = lootName, DestinationId = challengeEncounter.LootDestinationId or CurrentRun.Hero.ObjectId, Group = "Standing", ForceToValidLocation = true, })
					CreateConsumableItem( consumableId, lootName, 0 )
					ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( 500, 700 ) })
					ApplyForce({ Id = consumableId, Speed = RandomFloat( 50, 100 ), Angle = angle, SelfApplied = true })
				end
			end
		end
	end

	if challengeSwitch.RewardType == "Money" then
		local moneyMultiplier = GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )
		local amount = round( challengeSwitch.CurrentValue * moneyMultiplier )
		thread( GushMoney, { Amount = amount, LocationId = challengeSwitch.ObjectId, Radius = 50, Source = challengeSwitch.Name, Offset = dropOffset } )
	elseif challengeSwitch.RewardType == "Health" then
		Heal( CurrentRun.Hero, { HealAmount = challengeSwitch.CurrentValue, Name = "HealthChallengeSwitch" } )
	elseif challengeSwitch.RewardType == "MetaCurrency" then
		local consumableId = SpawnObstacle({ Name = "MetaCurrencyDrop", DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing", ForceToValidLocation = true, })
		local consumable = CreateConsumableItem( consumableId, "MetaCurrencyDrop", 0 )
		consumable.AddResources = consumable.AddResources or {}
		consumable.AddResources.MetaCurrency = round( challengeSwitch.CurrentValue * CalculateMetaPointMultiplier() )
		SetupResourceText( consumable )
		ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( 500, 700 ) })
		ApplyForce({ Id = consumableId, Speed = RandomFloat( 50, 100 ), Angle = angle, SelfApplied = true })
	elseif challengeSwitch.RewardType ~= nil then
		local consumableId = SpawnObstacle({ Name = challengeSwitch.RewardType, DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing", ForceToValidLocation = true })
		CreateConsumableItem( consumableId, challengeSwitch.RewardType, 0 )
		UseableOn({ Id = consumableId })
		ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( 500, 700 ) })
		ApplyForce({ Id = consumableId, Speed = RandomFloat( 50, 100 ), Angle = angle, SelfApplied = true })
	end
end

function HandleChallengeLootDecay( challengeSwitch, challengeEncounter )
	local rewardMultiplier = challengeSwitch.RewardMultiplier or 1
	local minValue = round( challengeEncounter.MinValue * rewardMultiplier )
	if challengeSwitch.RewardType == "Health" then
		minValue = round( minValue * CalculateHealingMultiplier())
	end
	if challengeSwitch.RewardType == "Money" and HasHeroTraitValue("BlockMoney") then
		minValue = 0
	end
	local decayMultiplier = challengeSwitch.DecayMultiplier or 1
	local decayAmount = challengeEncounter.ValueDecayAmount * decayMultiplier * GetTotalHeroTraitValue("ChallengeDecayIncrease", {IsMultiplier = true})

	local challengeSwitchId = challengeSwitch.ObjectId

	wait( challengeEncounter.DecayStartDelay, RoomThreadName )

	ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, ColorTarget = {1, 0.8, 0, 1}, ColorDuration = 0.2 })
	ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, ColorTarget = {1, 1, 1, 1}, ColorDuration = 2, Delay = 0.2 })
	thread(PulseText, {Id = challengeEncounter.ValueTextAnchor, ScaleTarget = 1.8, ScaleDuration = 0.15, HoldDuration = 0.0})
	ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", LuaValue = round(challengeSwitch.CurrentValue), Format = "LootFormat" })

	while( challengeSwitch.CurrentValue > minValue and challengeEncounter.InProgress and not CurrentRun.Hero.IsDead ) do

		challengeSwitch.CurrentValue = challengeSwitch.CurrentValue - decayAmount

		if challengeSwitch.CurrentValue < minValue then
			challengeSwitch.CurrentValue = minValue
		end
		ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", LuaValue = round(challengeSwitch.CurrentValue), Format = "LootFormat" })
		if challengeSwitch.CurrentValue % 10 == 0 then
			thread(PulseText, {Id = challengeEncounter.ValueTextAnchor, ScaleTarget = 1.5, ScaleDuration = 0.15, HoldDuration = 0.0})
			PlaySound({ Name = "/Leftovers/Menu Sounds/RosterPickup" })
		end

		local intervalMultiplier = challengeSwitch.IntervalMultiplier or 1
		local ticks = 10
		for i = 1, ticks do
			local tickTime = (challengeEncounter.LootDecayInterval * intervalMultiplier) / ticks
			if CurrentRun.CurrentRoom.ElapsedTimeMultiplier then
				tickTime  = tickTime / CurrentRun.CurrentRoom.ElapsedTimeMultiplier
			end
			wait( tickTime, RoomThreadName )
		end

	end
end

function SpawnAllLoot( eventSource, args )

	local lootPointIds = GetIdsByType({ Name = "LootPoint" })
	table.sort( lootPointIds )
	local lastLootPointId = lootPointIds[#lootPointIds]
	local lootNames = GetAllKeys( LootData )
	table.sort( lootNames )
	for k, lootName in ipairs( lootNames ) do
		local lootData = LootData[lootName]
		if not lootData.DebugOnly and ( lootData.PriorityUpgrades ~= nil or lootData.TransformingTraits ~= nil ) then
			local lootPointId =  GetLootPoint( lootPointIds, lastLootPointId )
			local loot = GiveLoot({ ForceLootName = lootName, SpawnPoint = lootPointId })
			SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = loot.ObjectId })
			loot.RespawnAfterUse = args.RespawnAfterUse
			loot.StripRequirements = args.StripInteractTextRequirements
			loot.WipeRecordsAfterUse = args.WipeRecordsAfterUse
			BlockVfx({ DestinationId = loot.ObjectId })
			if args.StopAnimations ~= nil then
				StopAnimation({ Names = args.StopAnimations, DestinationId = loot.ObjectId })
			end
			if args.StripInteractTextRequirements and loot.InteractTextLineSets ~= nil then
				for lineSetName, lineSet in pairs( loot.InteractTextLineSets ) do
					StripRequirements( lineSet )
				end
			end
		end
	end
	local weaponLoot = CreateWeaponLoot({ SpawnPoint =  GetLootPoint( lootPointIds, lastLootPointId )})
	weaponLoot.RespawnAfterUse = args.RespawnAfterUse
	weaponLoot.WipeRecordsAfterUse = args.WipeRecordsAfterUse
	weaponLoot.UpgradeOptions = nil
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = weaponLoot.ObjectId })

	local stackLoot = CreateStackLoot({ SpawnPoint =  GetLootPoint( lootPointIds, lastLootPointId )})
	stackLoot.RespawnAfterUse = args.RespawnAfterUse
	stackLoot.WipeRecordsAfterUse = args.WipeRecordsAfterUse
	stackLoot.StripRequirements = args.StripInteractTextRequirements
	stackLoot.UpgradeOptions = nil
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = stackLoot.ObjectId })
	
	lastLootPointId = GetLootPoint( lootPointIds, lastLootPointId )
	local talentLootId = SpawnObstacle({ Name = "TalentDrop", DestinationId = lastLootPointId})
	talentLoot = CreateConsumableItem( talentLootId, "TalentDrop", 0 )
	talentLoot.RespawnAfterUse = args.RespawnAfterUse
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = talentLoot.ObjectId })
	
	lastLootPointId = GetLootPoint( lootPointIds, lastLootPointId )
	local spellLootId = SpawnObstacle({ Name = "SpellDrop", DestinationId = lastLootPointId})
	spellLoot = CreateConsumableItem( spellLootId, "SpellDrop", 0 )
	spellLoot.RespawnAfterUse = args.RespawnAfterUse
	spellLoot.StripRequirements = args.StripInteractTextRequirements
	spellLoot.RotateAfterUse = true
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = spellLoot.ObjectId })
end

function GetLootPoint( lootPointIds, lastLootPointId )
	if IsEmpty( lootPointIds ) then
		local newLootPointId =  SpawnObstacle({ Name = "BlankObstacle", DestinationId = lastLootPointId, OffsetX = 140, OffsetY = 130 })
		table.insert( lootPointIds, newLootPointId )
		local newLootPointId2 =  SpawnObstacle({ Name = "BlankObstacle", DestinationId = lastLootPointId, OffsetX = 140, OffsetY = 0 })
		table.insert( lootPointIds, newLootPointId2 )
	end
	return RemoveFirstIndexValue( lootPointIds )
end

function StripInteractTextRequirements( eventSource, args )

	for enemyId, enemy in pairs( ActiveEnemies ) do
		if enemy.InteractTextLineSets ~= nil then
			for lineSetName, lineSet in pairs( enemy.InteractTextLineSets ) do
				lineSet.UseableOffSource = false
				StripRequirements( lineSet )
			end
		end
	end

end

function StripRequirements( source )

	if not GetConfigOptionValue({ Name = "AllowStripRequirements" }) then
		return
	end
	source.GameStateRequirements = nil
end

function StartSkellyHitQuest( eventSource, args )
	eventSource.Hits = 0
	eventSource.OnHitFunctionName = "UpdateSkellyHitQuest"
	eventSource.OnDeathThreadedFunctionName = "EarlyEndSkellyHitQuest"
	CheckObjectiveSet( "SkellyHitQuest" )
end
function UpdateSkellyHitQuest( victim )
	UpdateObjective( "HitSkelly", "SkellyHits", victim.Hits )
	if victim.Hits >= ObjectiveData.HitSkelly.GoalValue then
		victim.OnHitFunctionName = nil
		thread( MarkObjectiveComplete, "HitSkelly" )
		thread( SkellyHitQuestCompletePresentation, victim )
	end
end
function EndSkellyHitQuest( victim )
	if CurrentRun.ActiveObjectives.HitSkelly then
		thread( MarkObjectiveComplete, "HitSkelly" )
	end
end
function EarlyEndSkellyHitQuest( victim, args )
	SkellyDeath( victim, args )
	wait(1.2)
	EndSkellyHitQuest( victim )
end
function StartSkellyCastQuest( eventSource, args )
	CheckObjectiveSet( "SkellyCastQuest" )
end
function StartSkellySprintQuest( eventSource, args )
	CheckObjectiveSet( "SkellySprintQuest" )
end
function StartSkellyShadeMercQuest( eventSource, args )
	CheckObjectiveSet( "SkellyShadeMercQuest" )
end
function StartSkellyWeaponTutorial( eventSource, args )
	CheckAutoObjectiveSets( CurrentRun, "WeaponPickup" )
end
function StartSkellyInventoryQuest( eventSource, args )
	CheckObjectiveSet( "SkellyInventoryQuest" )
end

function StartNemesisDamageContest( source, args )

	InvalidateCheckpoint()

	source.DamageContestAmount = 0
	source.DamageContestGreatSuccess = false
	source.MaxHealth = 99999
	source.Health = source.MaxHealth
	source.TriggersOnDamageEffects = true
	SetVulnerable({ Id = source.ObjectId })
	AddAutoLockTarget({ Id = source.ObjectId })
	--source.OnHitFunctionName = "NemesisDamageContestHit"
	source.OnDamagedFunctionName = "NemesisDamageContestHit"
	source.DamageContestArgs = args
	source.OnHitVoiceLines = nil
	RemoveIncomingDamageModifier( source, "Innate" )

	NemesisDamageContestStartPresentation( source, args )
	CheckObjectiveSet( "NemesisDamageContest" )
	source.CanReceiveGift = false
end

function NemesisDamageContestHit( victim, attacker, args )
	if victim.DamageContestAmount <= 0 then
		thread( NemesisDamageContestTimer, victim, args )
	end
	victim.DamageContestAmount = (victim.DamageContestAmount or 0) + args.DamageAmount
	UpdateObjective( "NemesisDamageContest", nil, nil, { Pulse = true } )
	if victim.DamageContestAmount < victim.DamageContestArgs.ExcessDamageGoal then
		NemesisDamageContestHitPresentation( victim, args )
	elseif not victim.DamageContestGreatSuccess then
		NemesisDamageContestFinalHitPresentation( victim, args )
		victim.DamageContestGreatSuccess = true
	end
end

function NemesisDamageContestTimer( source, args )
	local timeRemaining = source.DamageContestArgs.Timer
	while timeRemaining > 0.0 do
		NemesisDamageContestCountdownPresentation( source, args, timeRemaining )
		local interval = 1.0
		timeRemaining = timeRemaining - interval
		wait( interval )
	end
	SetInvulnerable({ Id = source.ObjectId })
	RemoveAutoLockTarget({ Id = source.ObjectId })
	source.OnDamagedFunctionName = nil
	if source.DamageContestAmount >= source.DamageContestArgs.DamageGoal then
		thread( MarkObjectiveComplete, "NemesisDamageContest" )
		source.DamageContestArgs.Consumables = source.DamageContestArgs.SuccessConsumables
		if source.DamageContestAmount >= source.DamageContestArgs.ExcessDamageGoal then
			NemesisDamageContestGreatSuccessPresentation( source, args )
		else
			NemesisDamageContestSuccessPresentation( source, args )
		end
		NPCRewardDropPreProcessArgs( source.DamageContestArgs )
		NPCRewardDrop( source, source.DamageContestArgs )
	else
		thread( MarkObjectiveFailed, "NemesisDamageContest" )
		source.DamageContestArgs.Consumables = source.DamageContestArgs.FailConsumables
		NemesisDamageContestFailPresentation( source, args )
		NPCRewardDropPreProcessArgs( source.DamageContestArgs )
		NPCRewardDrop( source, source.DamageContestArgs )
	end

	MapState.RoomRequiredObjects[source.ObjectId] = nil
	wait( 0.2 )
	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function EchoChoice( source, args, screen )

	RemoveInputBlock({ Name = "PlayTextLines" })

	source.UpgradeOptions = {}
	source.BlockReroll = true
	local options = ShallowCopyTable( args.UpgradeOptions )
	local eligibleOptions = {}
	for i, option in pairs(options) do
		if TraitData[option.ItemName] and IsTraitEligible( CurrentRun, TraitData[option.ItemName] ) then
			table.insert(eligibleOptions, option)
		end
	end
	if not CurrentRun.LastReward then
		CurrentRun.LastReward = { Type = "Consumable", Name = "MaxHealthDrop", DisplayName = "MaxHealthDrop" }
	end

	for i = 1, 3 do
		if not IsEmpty(eligibleOptions) then
			local option = RemoveRandomValue( eligibleOptions )
			table.insert( source.UpgradeOptions, option )
		end
	end
	if args.PortraitShift ~= nil then
		args.PortraitShift.Id = screen.PortraitId
		Move( args.PortraitShift )
	end
	MedeaCursePreChoicePresentation( source, args )
	OpenUpgradeChoiceMenu( source, args )
	screen.OnCloseFinishedFunctionName = "EchoPostChoicePresentation"

	AddInputBlock({ Name = "PlayTextLines" })

end

function ArachneCostumeChoice( source, args, screen )

	RemoveInputBlock({ Name = "PlayTextLines" })

	source.UpgradeOptions = {}
	source.BlockReroll = true
	local options = ShallowCopyTable( args.UpgradeOptions )
	local eligibleOptions = {}
	for _, data in pairs(options) do
		if IsGameStateEligible( CurrentRun, data, data.GameStateRequirements ) then
			table.insert( eligibleOptions, data )
		end
	end
	for i = 1, 3 do
		if not IsEmpty(eligibleOptions) then
			local option = RemoveRandomValue( eligibleOptions )
			table.insert( source.UpgradeOptions, option )
		end
	end
	if args.PortraitShift ~= nil then
		args.PortraitShift.Id = screen.PortraitId
		Move( args.PortraitShift )
	end
	MedeaCursePreChoicePresentation( source, args )
	OpenUpgradeChoiceMenu( source, args )

	screen.OnCloseFinishedFunctionName = "ArachneArmorApply"

	AddInputBlock({ Name = "PlayTextLines" })

end

function NarcissusBenefitChoice( source, args, screen )

	RemoveInputBlock({ Name = "PlayTextLines" })

	source.UpgradeOptions = {}
	source.BlockReroll = true
	local options = ShallowCopyTable( args.UpgradeOptions )
	local eligibleOptions = {}
	local priorityOptions = {}
	for i, option in pairs( options ) do
		if option.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, source, option.GameStateRequirements ) then
			if option.PriorityRequirements ~= nil and IsGameStateEligible( CurrentRun, source, option.PriorityRequirements ) then
				table.insert( priorityOptions, option )
			else
				table.insert( eligibleOptions, option )
			end
		end
	end
	for i = 1, 3 do
		if not IsEmpty( priorityOptions ) then
			local option = RemoveRandomValue( priorityOptions )
			table.insert( source.UpgradeOptions, option )
			option.SlotEntranceAnimation = option.PrioritySlotEntranceAnimation
		else
			local option = RemoveRandomValue( eligibleOptions )
			table.insert( source.UpgradeOptions, option )
		end
	end
	if args.PortraitShift ~= nil then
		args.PortraitShift.Id = screen.PortraitId
		Move( args.PortraitShift )
	end
	-- NarcissusPreChoicePresentation( source, args )
	OpenUpgradeChoiceMenu( source, args )
	screen.OnCloseFinishedFunctionName = "NarcissusPostChoicePresentation"

	AddInputBlock({ Name = "PlayTextLines" })

end

function MedeaCurseChoice( source, args, screen )

	RemoveInputBlock({ Name = "PlayTextLines" })

	source.UpgradeOptions = {}
	source.BlockReroll = true
	local options = ShallowCopyTable( args.UpgradeOptions )
	for i = 1, 3 do
		local option = RemoveRandomValue( options )
		table.insert( source.UpgradeOptions, option )
	end
	if args.PortraitShift ~= nil then
		args.PortraitShift.Id = screen.PortraitId
		Move( args.PortraitShift )
	end
	MedeaCursePreChoicePresentation( source, args )
	OpenUpgradeChoiceMenu( source, args )

	screen.OnCloseFinishedFunctionName = "MedeaCursePostChoicePresentation"

	AddInputBlock({ Name = "PlayTextLines" })

end

function CirceBlessingChoice( source, args, screen )

	RemoveInputBlock({ Name = "PlayTextLines" })

	source.UpgradeOptions = {}
	source.BlockReroll = true
	local options = ShallowCopyTable( args.UpgradeOptions )
	local eligibleOptions = {}
	for i, option in pairs( options ) do
		if option.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, source, option.GameStateRequirements ) then
			table.insert( eligibleOptions, option )
		end
	end
	for i = 1, 3 do
		local option = RemoveRandomValue( eligibleOptions )
		table.insert( source.UpgradeOptions, option )
	end
	if args.PortraitShift ~= nil then
		args.PortraitShift.Id = screen.PortraitId
		Move( args.PortraitShift )
	end
	CirceBlessingPreChoicePresentation( source, args )
	OpenUpgradeChoiceMenu( source, args )

	screen.OnCloseFinishedFunctionName = "CirceBlessingPostChoicePresentation"

	AddInputBlock({ Name = "PlayTextLines" })

end

function IcarusBenefitChoice( source, args, screen )

	RemoveInputBlock({ Name = "PlayTextLines" })

	if source.PackageName ~= nil then
		LoadPackages({ Name = source.PackageName })
	end

	source.UpgradeOptions = {}
	source.BlockReroll = true
	local options = ShallowCopyTable( args.UpgradeOptions )
	local eligibleOptions = {}
	for i, option in pairs( options ) do
		if option.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, source, option.GameStateRequirements ) then
			table.insert( eligibleOptions, option )
		end
	end
	for i = 1, 3 do
		local option = RemoveRandomValue( eligibleOptions )
		table.insert( source.UpgradeOptions, option )
	end
	if args.PortraitShift ~= nil then
		args.PortraitShift.Id = screen.PortraitId
		Move( args.PortraitShift )
	end
	--MedeaCursePreChoicePresentation( source, args )
	OpenUpgradeChoiceMenu( source, args )
	screen.OnCloseFinishedFunctionName = "IcarusPostChoicePresentation"

	AddInputBlock({ Name = "PlayTextLines" })

	thread(IcarusExitPresentation, source, args)

end

function NemesisTradeChoice( source, args, screen )

	RemoveInputBlock({ Name = "PlayTextLines" })
	screen.AllowAdvancedTooltip = true
	
	local eligibleGiveOptions = {}
	for i, giveOption in ipairs( args.GiveOptions ) do
		if giveOption.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, giveOption, giveOption.GameStateRequirements ) then
			table.insert( eligibleGiveOptions, giveOption )
		end
	end
	local chosenGiveOption = GetRandomValue( eligibleGiveOptions )

	local eligibleGetOptions = {}
	for i, getOption in ipairs( args.GetOptions ) do
		if getOption.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, getOption, getOption.GameStateRequirements ) then
			table.insert( eligibleGetOptions, getOption )
		end
	end
	local chosenGetOption = GetRandomValue( eligibleGetOptions )

	--NemesisTradePreChoicePresentation( source, args )
	OpenTradeScreen( source, args, chosenGiveOption, chosenGetOption )
	AddInputBlock({ Name = "PlayTextLines" })
	screen.AllowAdvancedTooltip = false
	if source.Accepted then
		screen.OnCloseFinishedFunctionName = "TradeDoExchange"
		args.ChosenGiveOption = chosenGiveOption
		args.ChosenGetOption = chosenGetOption
		screen.OnCloseFinishedFunctionArgs = args
	end
end

function CollectRemainingMercenaries(eventSource, args)
	local mercIds = GetIdsByType({ Name = "ShadeMerc" })


	local collectIds = {}
	if CurrentRun.CurrentRoom.ShadeMercActiveIds ~= nil then
		for k, id in pairs( CurrentRun.CurrentRoom.ShadeMercActiveIds ) do
			if Contains( mercIds, id ) then
				table.insert( collectIds, id )
			end
		end
	end
	
	if IsEmpty(collectIds) then
		return
	end

	for k, mercId in pairs(collectIds) do
		killTaggedThreads(ActiveEnemies[mercId].AIThreadName)
		thread(CollectShadeMerc, ActiveEnemies[mercId])
		table.insert(CurrentRun.CurrentRoom.ShadeMercInactiveIds, mercId)
		RemoveValue(CurrentRun.CurrentRoom.ShadeMercActiveIds, mercId)
	end
	CollectRemainingMercenariesPresentation()
end

function SetupPauseMenuTakeover( source, args )
	SessionMapState.PauseMenuTakeoverCue = PlayVoiceLines( args.VoiceLines, false, nil, { ReturnOnly = true } )
	SessionMapState.PauseMenuTakeoverSource = source
	SessionMapState.PauseMenuTakeoverArgs = args
end

function PauseMenuTakeoverClosed()
	if SessionMapState.PauseMenuTakeoverCue ~= nil then
		CurrentRun.CurrentRoom.SpeechRecord[SessionMapState.PauseMenuTakeoverCue] = true
		GameState.SpeechRecord[SessionMapState.PauseMenuTakeoverCue] = true
		CurrentRun.SpeechRecord[SessionMapState.PauseMenuTakeoverCue] = true
	end	
	if SessionMapState.PauseMenuTakeoverArgs ~= nil then
		local threadName = "PauseMenuTakeover"
		if HasThread( threadName ) then
			return
		end
		if SessionMapState.PauseMenuTakeoverCue ~= nil then
			SessionMapState.PauseMenuTakeoverCue = nil
			wait( SessionMapState.PauseMenuTakeoverArgs.Cooldown, threadName )
		end
		SetupPauseMenuTakeover( SessionMapState.PauseMenuTakeoverSource, SessionMapState.PauseMenuTakeoverArgs )
	end
end

function ClearPauseMenuTakeover()
	SessionMapState.PauseMenuTakeoverCue = nil
	SessionMapState.PauseMenuTakeoverSource = nil
	SessionMapState.PauseMenuTakeoverArgs = nil
end

function OnionTransformation( source, args, user)
	AddInputBlock({ Name = "OnionPresentation" })
	if MapState.RoomRequiredObjects[source.ObjectId] then
		MapState.RoomRequiredObjects[source.ObjectId] = nil
	end
	OnionTransformationPresentation( source ) 
	local consumableId = SpawnObstacle({ Name = "RoomRewardConsolationPrize", DestinationId = source.ObjectId, Group = "Standing" })
	local reward = CreateConsumableItem( consumableId, "RoomRewardConsolationPrize", 0 )
	MapState.RoomRequiredObjects[reward.ObjectId] = reward
	Destroy({ Id = source.ObjectId })
	RemoveInputBlock({ Name = "OnionPresentation" })
end

function CirceRandomMetaUpgrade( args )
	AddRandomMetaUpgrades( args.Count )
end

function CirceMetaUpgradeRarity( args )
	args = args or {}
	local eligibleTraits = {}
	
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			if GameState.MetaUpgradeState[cardName].Equipped and MetaUpgradeCardData[ cardName ].TraitName and HeroHasTrait(MetaUpgradeCardData[ cardName ].TraitName ) then
				local traitData = GetHeroTrait(MetaUpgradeCardData[ cardName ].TraitName )
				if traitData.Rarity ~= nil and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil then
					table.insert(eligibleTraits, { TraitData = traitData, MetaUpgradeName = cardName })
				end
			end
		end
	end
	if IsEmpty(eligibleTraits) then
		return
	end
	local pickedTraits = {}
	local count = args.Count or 1
	while not IsEmpty(eligibleTraits) and count > 0 do
		local randomValue = RemoveRandomValue( eligibleTraits )
		local traitData = randomValue.TraitData
		local metaUpgradeName = randomValue.MetaUpgradeName
		RemoveWeaponTrait( traitData.Name )
		local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, Rarity = GetUpgradedRarity(traitData.Rarity) }) 
		AddTraitToHero({ TraitData = processedData })
		if MetaUpgradeCardData[metaUpgradeName].OnUpgradedFunctionName then
			CallFunctionName( MetaUpgradeCardData[metaUpgradeName].OnUpgradedFunctionName, traitData, processedData )
		end
		pickedTraits[traitData.Name] = true
		MapState.TraitTrayMetaUpgradePriorityHighlight = traitData.Name
		count = count - 1
	end
	thread( IncreasedTraitRarityPresentation, pickedTraits )
end

function CirceRemoveShrineUpgrades( args )
	local count = args.Count 
	local shrineOptions = {}
	for name, rank in pairs( GameState.ShrineUpgrades ) do
		if rank > 0 then
			shrineOptions[name] = true
		end
	end
	while count > 0 and not IsEmpty( shrineOptions ) do
		local shrineKey = GetRandomKey( shrineOptions )
		CurrentRun.ShrineUpgradesDisabled[shrineKey] = true
		if MetaUpgradeData[shrineKey].OnDisabledFunctionName ~= nil then
			CallFunctionName( MetaUpgradeData[shrineKey].OnDisabledFunctionName )
		end
		count = count - 1
		thread( CirceRemoveShrinePresentation, shrineKey, 1.0 )
	end
end

function CircePetMultiplier( args )
	local upgradeTraits = {}
	for _, traitData in pairs( CurrentRun.Hero.Traits ) do
		if traitData.FamiliarTrait then
			table.insert( upgradeTraits, traitData )
		end
	end
	for _, traitData in pairs( upgradeTraits ) do
		if traitData.FamiliarLastStandHealAmount ~= nil then
			AddLastStand({
				Name = "LastStandFamiliar",
				Icon = "ExtraLifeCatFamiliar",
				InsertAtEnd = true,
				IncreaseMax = true,
				HealAmount = GetTotalHeroTraitValue( "FamiliarLastStandHealAmount" )
			})
			RecreateLifePips()
		else
			IncreaseTraitLevel( traitData, round(( traitData.StackNum or 1 ) * args.BonusMultiplier ))
		end
	end
	GameState.FamiliarUses = 2 * (1 + GetFamiliarBonusUses( GameState.EquippedFamiliar ))
	UpdateFamiliarIconUses()
end

function CirceHeal( args )
	Heal( CurrentRun.Hero, { HealFraction = args.HealFraction, Source = "CirceBoon" })
end

function CirceEnlarge( unit, args, roomArgs )
	roomArgs = roomArgs or {}
	local duration = args.Duration
	local skipPresentation = false
	if roomArgs.Grouped then
		duration = 0
	else
		thread( CirceEnlargePresentation )
	end
	SetAudioEffectState({ Name = "Chipmunk", Value = GetTotalHeroTraitValue("BaseChipmunkValue") })
	SetScale({ Id = unit.ObjectId, Fraction = args.ScaleMultiplier, Duration = 0.5 })	
end

function CirceShrink( unit, args, roomArgs )
	roomArgs = roomArgs or {}
	local duration = args.Duration
	local skipPresentation = false
	if roomArgs.Grouped then
		duration = 0
	else
		thread( CirceShrinkPresentation )
	end
	SetAudioEffectState({ Name = "Chipmunk", Value = GetTotalHeroTraitValue("BaseChipmunkValue") })
	SetScale({ Id = unit.ObjectId, Fraction = args.ScaleMultiplier, Duration = 0.5 })
	
end

function EchoLastReward( args )
	if not CurrentRun.LastReward then
		CurrentRun.LastReward = {Type = "Consumable", Name = "MaxHealthDrop", DisplayName = "MaxHealthDrop" }
	end

	local spawnPoint = args.LootSourceId or GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints" })
	if spawnPoint == 0 then
		spawnPoint = CurrentRun.Hero.ObjectId
	end

	if CurrentRun.LastReward.Type == "Consumable" then
		local consumableName = CurrentRun.LastReward.Name
		local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = spawnPoint, Group = "Standing", })
		local consumable = CreateConsumableItem( consumableId, consumableName, 0 )
		consumable.MetaConversionEligible = false
		MapState.RoomRequiredObjects[consumableId] = consumable
	else
		CreateLoot({ Name = CurrentRun.LastReward.Name, SpawnPoint = spawnPoint })
	end
end

function GetEchoLastRewardDescription( args )
	if not CurrentRun.LastReward then
		return args.DefaultId
	end
	local name = CurrentRun.LastReward.Name or CurrentRun.LastReward.DisplayName
	local lootData = LootData[name]
	local consumableData = ConsumableData[name]
	if lootData ~= nil and lootData.EchoLastRewardId then
		return lootData.EchoLastRewardId
	elseif consumableData ~= nil and consumableData.EchoLastRewardId then
		return consumableData.EchoLastRewardId
	elseif CurrentRun.LastReward.Type == "Boon" then
		return args.DefaultBoonId
	else
		return args.DefaultId
	end
end

function EchoLastRunBoon()
	local prevRun = GameState.RunHistory[#GameState.RunHistory]
	local eligibleTraits = {}
	for traitName, rarity in pairs( prevRun.TraitRarityCache or {} ) do
		local traitData = TraitData[traitName] 
		if not HeroHasTrait(traitName) and IsGodTrait( traitName, {ForShop = true, ForLastRunBoon = true } ) and IsTraitEligible( CurrentRun, traitData ) and ( not traitData.Slot or not HeroSlotFilled( traitData.Slot )) and not traitData.ExcludeTraitFromLastRunBoonPool then
			table.insert(eligibleTraits, {Name = traitName, Rarity = rarity })
		end
	end
	if not IsEmpty(eligibleTraits) then
		local randomTraitData = GetRandomValue( eligibleTraits )
		local lootSource = GetLootSourceName(randomTraitData.Name)
		if lootSource then
			LoadPackages( { Name = lootSource } )
			IncrementTableValue( CurrentRun.LootTypeHistory, lootSource )
		end
		AddTraitToHero( { FromLoot = true, TraitData = GetProcessedTraitData( { Unit = CurrentRun.Hero, TraitName = randomTraitData.Name, Rarity = randomTraitData.Rarity } ) } )

		thread( EchoLastRunBoonPresentation, randomTraitData.Name )
	end
end

function EchoRefillLastStands( args )
	if not CurrentRun.Hero.MaxLastStands then
		return	
	end
	args = args or {}
	local numLastStands = CurrentRun.Hero.MaxLastStands - TableLength( CurrentRun.Hero.LastStands )
	if numLastStands > 0 then
		local currentFraction = args.StartFraction or 0.5
		currentFraction = currentFraction - (numLastStands - 1) * args.Decay
		while numLastStands > 0 do
			AddLastStand({
				Name = "Echo",
				Icon = "ExtraLifeEcho",
				ManaFraction = math.max(currentFraction, 0.1),
				HealFraction = math.max(currentFraction, 0.1),
				Silent = true,
			})
			currentFraction = currentFraction + args.Decay
			numLastStands = numLastStands - 1
		end
		RecreateLifePips()
	end
end

function EchoIncreaseStats( args, traitData )
	local currentMaxHealth = CurrentRun.Hero.MaxHealth
	local currentMaxMana = CurrentRun.Hero.MaxMana
	local sourceTrait = nil
	traitData.StartMaxHealth = currentMaxHealth 
	traitData.StartMaxMana = currentMaxMana 
	traitData.StatMultiplier = args.StartFraction
	traitData.Decay = args.Decay
	traitData.BlockDecay = true

	traitData.PropertyChanges = 
	{
		{
			LuaProperty = "MaxMana",
			ChangeValue = traitData.StartMaxMana * args.StartFraction,
			ChangeType = "Add",	
			AsInt = true,
		},
		{
			LuaProperty = "MaxHealth",
			ChangeValue = traitData.StartMaxHealth * args.StartFraction,
			ChangeType = "Add",
			AsInt = true,
		}
	}
	ApplyUnitPropertyChanges( CurrentRun.Hero, traitData.PropertyChanges, true )
end
