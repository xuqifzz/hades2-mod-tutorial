function SetupHarvestPoints( currentRoom, args )

	args = args or {}
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		EditorActivateAllHarvestPoints()
	end

	-- HarvestPoints
	local harvestPoints = GetInactiveIdsByType({ Name = "HarvestPoint" })
	currentRoom.HarvestPointIds = ShallowCopyTable( harvestPoints )
	if (currentRoom.HarvestPointsAllowed or 0) > 0 then
		currentRoom.HarvestPointChoicesIds = currentRoom.HarvestPointChoicesIds or {}
		currentRoom.HarvestPointChoicesOptions = currentRoom.HarvestPointChoicesOptions or {}
		UseHeroTraitsWithValue( "ForceHarvestPoint", true )
		for i = 1, currentRoom.HarvestPointsAllowed do
			if IsEmpty( harvestPoints ) then
				break
			end
			local weightedList = {}
			for k, option in pairs( HarvestData.WeightedOptions ) do
				if IsGameStateEligible( option, option.GameStateRequirements ) then
					weightedList[k] = option.Weight
				end
			end

			if not IsEmpty( weightedList ) then
				local harvestPointId = currentRoom.HarvestPointChoicesIds[i] or RemoveRandomValue( harvestPoints )
				local choiceKey = currentRoom.HarvestPointChoicesOptions[i] or GetRandomValueFromWeightedList( weightedList )
				if MapState.ActiveObstacles[harvestPointId] == nil then
					local harvestPoint = DeepCopyTable( ObstacleData.HarvestPoint )
					harvestPoint.ObjectId = harvestPointId
					currentRoom.HarvestPointChoicesIds[i] = harvestPoint.ObjectId
					currentRoom.HarvestPointChoicesOptions[i] = choiceKey

					local chosenHarvestData = HarvestData.WeightedOptions[choiceKey]
					Activate({ Id = harvestPoint.ObjectId, TriggerOnSpawn = false })
					if chosenHarvestData.ConsumableName ~= nil then
						local consumableId = SpawnObstacle({ Name = chosenHarvestData.ConsumableName, DestinationId = harvestPoint.ObjectId, Group = "Standing"})
						local consumable = CreateConsumableItem( consumableId, chosenHarvestData.ConsumableName, 0 )
						Destroy({ Id = harvestPoint.ObjectId })
					else
						OverwriteTableKeys( harvestPoint, chosenHarvestData )
						SetupObstacle( harvestPoint )
						ChangeDrawGroup( harvestPoint.ObjectId, harvestPoint.DrawGroup or "Standing" )
					end
					currentRoom.NumHarvestPoints = (currentRoom.NumHarvestPoints or 0) + 1
					currentRoom.UseableHarvestPoint = true
				end
			end
		end
	end

	-- ShovelPoints
	local shovelPoints = GetInactiveIdsByType({ Name = "ShovelPoint" })
	if currentRoom.ShovelPointSuccess then
		currentRoom.ShovelPointChoices = currentRoom.ShovelPointChoices or {}
		for i = 1, currentRoom.ShovelPointsAllowed or 1 do
			if IsEmpty( shovelPoints ) then
				break
			end
			CurrentRun.ResourceNodesSeen.ToolShovel = (CurrentRun.ResourceNodesSeen.ToolShovel or 0) + 1
			UseHeroTraitsWithValue( "ForceShovelPoint", true )
			local shovelPointId = currentRoom.ShovelPointChoices[i] or RemoveRandomValue( shovelPoints )
			if MapState.ActiveObstacles[shovelPointId] == nil then
				local shovelPoint = DeepCopyTable( ObstacleData.ShovelPoint )
				shovelPoint.ObjectId = shovelPointId
				currentRoom.ShovelPointChoices[i] = shovelPoint.ObjectId
				Activate({ Id = shovelPoint.ObjectId, TriggerOnSpawn = false })
				SetupObstacle( shovelPoint )
				currentRoom.NumShovelPoints = (currentRoom.NumShovelPoints or 0) + 1
				if HasAccessToTool("ToolShovel") then
					currentRoom.UseableShovelPoint = true
				else
					shovelPoint.ExitsUnlockedFunctionName = nil
					shovelPoint.UseText = shovelPoint.NoToolUseText
					SetAnimation({ DestinationId = shovelPoint.ObjectId, Name = shovelPoint.UnavailableAnimation })
				end
			end
		end
	end

	-- PickaxePoints
	local pickaxePoints = GetInactiveIdsByType({ Name = "PickaxePoint" })
	if currentRoom.PickaxePointSuccess and not currentRoom.ExorcismPointUsed then
		currentRoom.PickaxePointChoices = currentRoom.PickaxePointChoices or {}
		for i = 1, currentRoom.PickaxePointsAllowed or 1 do
			if IsEmpty( pickaxePoints ) then
				break
			end	 
			CurrentRun.ResourceNodesSeen.ToolPickaxe = (CurrentRun.ResourceNodesSeen.ToolPickaxe or 0) + 1
			UseHeroTraitsWithValue( "ForcePickaxePoint", true )
			currentRoom.ChosenPickaxePointData = currentRoom.ChosenPickaxePointData or GetRandomEligibleValueFromWeightedList( PickaxePointData.WeightedOptions )
			if currentRoom.ChosenPickaxePointData == nil then
				DebugAssert({ Condition = false, Text = "No valid PickaxePointData", Owner = "James" })
			end
			local pickaxePointId = currentRoom.PickaxePointChoices[i] or RemoveRandomValue( pickaxePoints )
			if MapState.ActiveObstacles[pickaxePointId] == nil then
				local chosenOption = DeepCopyTable( currentRoom.ChosenPickaxePointData )
				local pickaxePoint = DeepCopyTable( ObstacleData.PickaxePoint )
				OverwriteTableKeys( pickaxePoint, chosenOption )
				pickaxePoint.ObjectId = pickaxePointId
				currentRoom.PickaxePointChoices[i] = pickaxePoint.ObjectId
				Activate({ Id = pickaxePoint.ObjectId, TriggerOnSpawn = false })
				SetupObstacle( pickaxePoint )
				currentRoom.NumPickaxePoints = (currentRoom.NumPickaxePoints or 0) + 1
				if HasAccessToTool( "ToolPickaxe" ) then
					currentRoom.UseablePickaxePoint = true
				else
					pickaxePoint.ExitsUnlockedFunctionName = nil
					pickaxePoint.UseText = pickaxePoint.NoToolUseText
					if pickaxePoint.UnavailableAnimation ~= nil then
						SetAnimation({ DestinationId = pickaxePoint.ObjectId, Name = pickaxePoint.UnavailableAnimation })
					end
				end
			end
		end
	end

	-- ExorcismPoints
	local exorcismPoints = GetInactiveIdsByType({ Name = "ExorcismPoint" })
	if currentRoom.ExorcismPointSuccess and not currentRoom.ExorcismPointUsed then
		currentRoom.ExorcismPointChoices = currentRoom.ExorcismPointChoices or {}
		for i = 1, currentRoom.ExorcismPointsAllowed or 1 do
			if IsEmpty( exorcismPoints ) then
				break
			end	
			CurrentRun.ResourceNodesSeen.ToolExorcismBook = (CurrentRun.ResourceNodesSeen.ToolExorcismBook or 0) + 1
			UseHeroTraitsWithValue( "ForceExorcismPoint", true )
			currentRoom.ChosenExorcismPointData = currentRoom.ChosenExorcismPointData or GetRandomEligibleValueFromWeightedList( ExorcismData.WeightedOptions )
			if currentRoom.ChosenExorcismPointData == nil then
				DebugAssert({ Condition = false, Text = "No valid ExorcismData", Owner = "James" })
			end

			local exorcismPointId = currentRoom.ExorcismPointChoices[i] or RemoveRandomValue( exorcismPoints )
			if MapState.ActiveObstacles[exorcismPointId] == nil then
				local exorcismPoint = DeepCopyTable( ObstacleData.ExorcismPoint )
				OverwriteTableKeys( exorcismPoint, currentRoom.ChosenExorcismPointData )
				exorcismPoint.ObjectId = exorcismPointId
				currentRoom.ExorcismPointChoices[i] = exorcismPoint.ObjectId
				Activate({ Id = exorcismPoint.ObjectId, TriggerOnSpawn = false })
				SetupObstacle( exorcismPoint )
				RestoreMapStateObject( CurrentRun.CurrentRoom.Name, exorcismPoint )
				currentRoom.NumExorcismPoints = (currentRoom.NumExorcismPoints or 0) + 1
				if HasAccessToTool( "ToolExorcismBook" ) then
					currentRoom.UseableExorcismPoint = true	
					ExorcismGenerateMoveSequence( exorcismPoint )
					ExorcismPointChosenPresentation( exorcismPoint )
				else
					exorcismPoint.ExitsUnlockedFunctionName = nil
					exorcismPoint.UseText = exorcismPoint.NoToolUseText
					SetAnimation({ DestinationId = exorcismPoint.ObjectId, Name = exorcismPoint.UnavailableAnimation })
				end
			end
		end
	end

	-- FishingPoints
	local fishingPointIds = GetInactiveIdsByType({ Name = "FishingPoint" })
	if currentRoom.FishingPointSuccess and not currentRoom.FishingPointUsed then
		currentRoom.FishingPointChoices = currentRoom.FishingPointChoices or {}
		for i = 1, currentRoom.FishingPointsAllowed or 1 do
			if IsEmpty( fishingPointIds ) then
				break
			end
			CurrentRun.ResourceNodesSeen.ToolFishingRod = (CurrentRun.ResourceNodesSeen.ToolFishingRod or 0) + 1
			UseHeroTraitsWithValue( "ForceFishingPoint", true )
			local fishingPointId = currentRoom.FishingPointChoices[i] or RemoveRandomValue( fishingPointIds )
			if MapState.ActiveObstacles[fishingPointId] == nil then
				local fishingPoint = DeepCopyTable( ObstacleData.FishingPoint )
				fishingPoint.ObjectId = fishingPointId
				currentRoom.FishingPointChoices[i] = fishingPoint.ObjectId
				Activate({ Id = fishingPoint.ObjectId, TriggerOnSpawn = false })
				SetupObstacle( fishingPoint )
				currentRoom.NumFishingPoints = (currentRoom.NumFishingPoints or 0) + 1
				if HasAccessToTool("ToolFishingRod") then
					local roomData = RoomData[currentRoom.Name] or currentRoom
					if roomData.AllowFishingPreExitsUnlock then
						SetAnimation({ Name = "FishingPointActive", DestinationId = fishingPoint.ObjectId })
					end
					currentRoom.UseableFishingPoint = true
				else
					fishingPoint.ExitsUnlockedFunctionName = nil
					fishingPoint.UseText = fishingPoint.NoToolUseText
				end
			end
		end
	end

end

function UseHarvestPoint( source, args, user )

	if not CheckCooldown( "UsedHarvestPoint", 0.75, true ) or MapState.HostilePolymorph then
		return
	end

	if source == nil or source.AddResources == nil then
		return
	end

	AddInputBlock({ Name = "UseHarvestPoint" })
	if CurrentRun.CurrentRoom.ExitsUnlocked then
		AddTimerBlock( CurrentRun, "UseHarvestPoint" )
	end
	HarvestStartPresentation( source, args, user )

	GameState.HarvestSuccesses = (GameState.HarvestSuccesses or 0) + 1
	CurrentRun.HarvestSuccesses = (CurrentRun.HarvestSuccesses or 0) + 1

	for resourceName, count in pairs( source.AddResources ) do
		AddResource( resourceName, count, source.Name )
	end

	if GameState.WorldUpgrades.WorldUpgradeHarvestUpgrade and RandomChance( WorldUpgradeData.WorldUpgradeHarvestUpgrade.BonusResourcesChance ) then
		thread( HarvestPointGiveBonusResource, source, args, user )
	end

	UseableOff({ Id = source.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", "Blank" )
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )
	HarvestEndPresentation( source, args, user )
	RemoveInputBlock({ Name = "UseHarvestPoint" })
	RemoveTimerBlock( CurrentRun, "UseHarvestPoint" )
end

function HarvestPointGiveBonusResource( source, args, user )
	HarvestBonusResourcePresentation( source, args, user )
	for resourceName, count in pairs( source.AddResources ) do
		AddResource( resourceName, WorldUpgradeData.WorldUpgradeHarvestUpgrade.BonusResourcesCount, source.Name, { Text = "GainBonusResource" } )
	end
end

function HarvestPointUseCanceled( user )
	killTaggedThreads( user.PreHarvestThreadName )
	RemoveInputBlock({ Name = "UseHarvestPoint" })
	RemoveTimerBlock( CurrentRun, "UseHarvestPoint" )
	RemoveOnDamagedFunction( user, "HarvestPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil
	DebugPrint({ Text = "Harvest canceled by damage" })
end

function UseShovelPoint( source, args, user )

	if not CheckCooldown( "UseShovelPoint", 0.75, true ) or MapState.HostilePolymorph or ( HasFamiliarTool( "ToolShovel" ) and not MapState.FamiliarUnit ) then
		return
	end

	if not HasAccessToTool( "ToolShovel" ) then
		HarvestNoToolPresentation( source, args, user, "ToolShovel" )
		return
	end

	if OnlyFamiliarHasAccessToTool( "ToolShovel" ) and not CurrentRun.CurrentRoom.ExitsUnlocked then
		HarvestBlockedPresentation( source, { Text = "UseBlockedByMisc" } )
		return
	end

	AddInputBlock({ Name = "UseShovelPoint" })
	if CurrentRun.CurrentRoom.ExitsUnlocked then
		AddTimerBlock( CurrentRun, "UseShovelPoint" )
	end
	local usedFamiliar = false
	local chosenOption = GetRandomEligibleValueFromWeightedList( ShovelPointData.WeightedOptions )
	if HasFamiliarTool( "ToolShovel" ) and CurrentRun.CurrentRoom.ExitsUnlocked then
		usedFamiliar = true
		FamiliarShovelStartPresentation( source, args, user, chosenOption )
	else
		ShovelStartPresentation( source, args, user, chosenOption )
	end

	GameState.ShovelSuccesses = (GameState.ShovelSuccesses or 0) + 1
	CurrentRun.ShovelSuccesses = (CurrentRun.ShovelSuccesses or 0) + 1
	if usedFamiliar then
		GameState.ShovelSuccessesFamiliar = (GameState.ShovelSuccessesFamiliar or 0) + 1
		CurrentRun.ShovelSuccessesFamiliar = (CurrentRun.ShovelSuccessesFamiliar or 0) + 1
	else
		GameState.ShovelSuccessesManual = (GameState.ShovelSuccessesManual or 0) + 1
		CurrentRun.ShovelSuccessesManual = (CurrentRun.ShovelSuccessesManual or 0) + 1
	end

	local resourceTimes = 1
	if RandomChance( GetTotalHeroTraitValue("DoubleToolRewardChance")) then
		resourceTimes = resourceTimes + 1
	end
	if resourceTimes > 1 then
		thread( ChaosRewardIncreasedPresentation, source.ObjectId )
		waitUnmodified(0.25, RoomThreadName )
	end
	if chosenOption.AddResources ~= nil then
		for resourceName, count in pairs( chosenOption.AddResources ) do
			AddResource( resourceName, count * resourceTimes, source.Name )
		end
	end
	while resourceTimes > 0 do
		CallFunctionName( chosenOption.OnChosenFunctionName, source, chosenOption.OnChosenFunctionArgs, user, chosenOption )
		resourceTimes = resourceTimes - 1
	end

	if ShovelPointData.ShovelPointBonusDrops ~= nil then
		for i, drop in ipairs( ShovelPointData.ShovelPointBonusDrops ) do
			if RandomChance( drop.Chance ) then
				if drop.PresentationFunctionName ~= nil then
					CallFunctionName( drop.PresentationFunctionName, source, args, user )
				end
				if drop.ProjectileName ~= nil then
					CreateProjectileFromUnit({ Name = drop.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, FireFromTarget = true })
				end
				if drop.HealthDropName ~= nil then
					DropMinorConsumable( drop.HealthDropName, source.ObjectId )
				end
				break
			end
		end
	end

	if usedFamiliar then
		local familiar = MapState.FamiliarUnit
		if ( CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth ) < familiar.HeroHealthPercentForDig then
			waitUnmodified( 0.25, RoomThreadName )
			DropMinorConsumable( familiar.HealthDigReward, familiar.ObjectId )
			thread( InCombatText, familiar.ObjectId, "HoundFamiliar_LifeItemDug", 1.65, { PreDelay = 0.35, OffsetY = -100 }  )
		end
	end

	CheckForToolElement( source.ObjectId, "ToolShovel2" )

	UseableOff({ Id = source.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", "ShovelPointUsed" )
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )
	ShovelEndPresentation( source, args, user, chosenOption )
	RemoveInputBlock({ Name = "UseShovelPoint" })
	RemoveTimerBlock( CurrentRun, "UseShovelPoint" )

	if usedFamiliar then
		thread( PlayVoiceLines, HeroVoiceLines.FamiliarThankingVoiceLines, true )
		wait( 0.3 )
		ReenableFamiliar( MapState.FamiliarUnit, { InitialDelay = 1.0 } )
	end

end

function ShovelPointUseCanceled( user )
	killTaggedThreads( user.PreHarvestThreadName )
	RemoveInputBlock({ Name = "UseShovelPoint" })
	RemoveTimerBlock( CurrentRun, "UseShovelPoint" )
	RemoveOnDamagedFunction( user, "ShovelPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil
	DebugPrint({ Text = "Harvest canceled by damage" })
end

function UsePickaxePoint( source, args, user )

	if not CheckCooldown( "UsePickaxePoint", 0.75, true ) or MapState.HostilePolymorph or ( HasFamiliarTool( "ToolPickaxe" ) and not MapState.FamiliarUnit ) then
		return
	end

	if source == nil or source.Health == nil then
		return
	end

	if not HasAccessToTool( "ToolPickaxe" ) then
		HarvestNoToolPresentation( source, args, user, "ToolPickaxe" )
		return
	end

	if OnlyFamiliarHasAccessToTool( "ToolPickaxe" ) and not CurrentRun.CurrentRoom.ExitsUnlocked then
		HarvestBlockedPresentation( source, { Text = "UseBlockedByMisc" } )
		return
	end

	CurrentRun.CurrentRoom.PickaxePointUsed = true

	AddInputBlock({ Name = "UsePickaxePoint" })
	if CurrentRun.CurrentRoom.ExitsUnlocked then
		AddTimerBlock( CurrentRun, "UsePickaxePoint" )
	end

	local usedFamiliar = false

	user.PreHarvestThreadName = "PickaxeStartPresentation"
	user.PickaxeDamageTaken = nil
	AddOnDamagedFunction( user, "PickaxePointUseCanceled" )
	user.OnHostilePolymorphFunctionName = "PickaxePointUseCanceled"

	waitUnmodified( 0.02, user.PreHarvestThreadName )

	local keepMining = true
	while keepMining do
	
		if HasFamiliarTool( "ToolPickaxe" ) and CurrentRun.CurrentRoom.ExitsUnlocked then
			usedFamiliar = true
			FamiliarPickaxeStartPresentation( source, args, user )
		else
			PickaxeStartPresentation( source, args, user )
		end

		local swingDamage = source.SwingDamage
		if usedFamiliar then
			-- familiar instantly kills it
			swingDamage = source.Health
		end
		local resourceCount = math.min( swingDamage, source.Health )
		source.Health = source.Health - swingDamage
		RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Health", source.Health )
		if source.Health > 0 then
			PickaxeDepositDamagedPresentation( source, args, user )
		else
			PickaxeDepositDestroyedPresentation( source, args, user )

			GameState.PickaxeSuccesses = (GameState.PickaxeSuccesses or 0) + 1
			CurrentRun.PickaxeSuccesses = (CurrentRun.PickaxeSuccesses or 0) + 1
			if usedFamiliar then
				GameState.PickaxeSuccessesFamiliar = (GameState.PickaxeSuccessesFamiliar or 0) + 1
				CurrentRun.PickaxeSuccessesFamiliar = (CurrentRun.PickaxeSuccessesFamiliar or 0) + 1
			else
				GameState.PickaxeSuccessesManual = (GameState.PickaxeSuccessesManual or 0) + 1
				CurrentRun.PickaxeSuccessesManual = (CurrentRun.PickaxeSuccessesManual or 0) + 1
			end

			CheckForToolElement( source.ObjectId, "ToolPickaxe2" )

			UseableOff({ Id = source.ObjectId })
			RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", source.EmptyAnimation )
			RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )
		end
		local resourceTimes = 1
		if RandomChance( GetTotalHeroTraitValue("DoubleToolRewardChance")) then
			resourceTimes = resourceTimes + 1
		end
	
		if resourceTimes > 1 then
			thread( ChaosRewardIncreasedPresentation, source.ObjectId )
			waitUnmodified( 0.25, RoomThreadName)
		end
		AddResource( source.ResourceName, resourceCount * resourceTimes, source.Name )

		keepMining = source.Health > 0 and IsControlDown({ Name = "Use" }) and not user.PickaxeDamageTaken

	end

	RemoveInputBlock({ Name = "UsePickaxePoint" })
	RemoveTimerBlock( CurrentRun, "UsePickaxePoint" )
	RemoveOnDamagedFunction( user, "PickaxePointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil
	
	if usedFamiliar then
		thread( PlayVoiceLines, HeroVoiceLines.FamiliarThankingVoiceLines, true )
		wait( 0.3 )
		ReenableFamiliar( MapState.FamiliarUnit, { InitialDelay = 1.0 } )
	end
end

function PickaxePointUseCanceled( user )
	killTaggedThreads( user.PreHarvestThreadName )
	RemoveInputBlock({ Name = "UsePickaxePoint" })
	RemoveTimerBlock( CurrentRun, "UsePickaxePoint" )
	RemoveOnDamagedFunction( user, "PickaxePointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil
	DebugPrint({ Text = "Harvest canceled by damage" })
	user.PickaxeDamageTaken = true
end

function ExorcismPointUseCanceled( user )
	killTaggedThreads( user.PreExorcismThreadName )
	RemoveInputBlock({ Name = "UseExorcismPoint" })
	RemoveTimerBlock( CurrentRun, "UseExorcismPoint" )
	RemoveOnDamagedFunction( user, "ExorcismPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil
	DebugPrint({ Text = "Exorcism canceled by damage" })
	user.ExorcismDamageTaken = true
end

function ExorcismGenerateMoveSequence( source )
	source.MoveSequence = {}
	local numMoves = RandomInt( source.NumMovesMin, source.NumMovesMax )
	local prevMove = nil
	for i = 1, numMoves do
		local move = {}
		while move.Duration == nil or (prevMove ~= nil and move.Left == prevMove.Left and move.Right == prevMove.Right) do -- Don't repeat moves, can just make duration longer
			local random = RandomInt(1, 3)
			if ( random == 1 ) then
				move.Left = true
				move.Right = true
			elseif ( random == 2 ) then
				move.Left = true
				move.Right = false
			else
				move.Left = false
				move.Right = true
			end
			move.Duration = RandomFloat( source.MoveDurationMin, source.MoveDurationMax )
			move.Index = i
			source.MoveSequence[i] = move
		end
		prevMove = move
	end
end

function IsAggoredUnitBlockingHarvest()
	for id, v  in pairs( ShallowCopyTable( MapState.AggroedUnits ) ) do
		local unit = ActiveEnemies[id]
		if unit ~= nil and not unit.AllowHarvestWhileAggored and not unit.AlwaysTraitor then
			return true
		end
	end
	return false
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

function UseExorcismPoint( source, args, user )

	if not CheckCooldown( "UseExorcismPoint", 0.75, true ) or MapState.HostilePolymorph or ( HasFamiliarTool( "ToolExorcismBook" ) and not MapState.FamiliarUnit ) then
		return
	end

	if not HasAccessToTool( "ToolExorcismBook" ) then
		HarvestNoToolPresentation( source, args, user, "ToolExorcismBook" )
		return
	end
		
	if not IsEmpty( RequiredKillEnemies ) or IsAggoredUnitBlockingHarvest() then
		HarvestBlockedPresentation( source, { Text = "UseBlockedByEnemies" } )
		return
	end

	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	if not CurrentRun.CurrentRoom.ExitsUnlocked and not roomData.AllowExorcismPreExitsUnlock then
		HarvestBlockedPresentation( source, { Text = roomData.HarvestBlockedText or RoomData.BaseRoom.HarvestBlockedText } )
		return
	end

	CurrentRun.CurrentRoom.ExorcismPointUsed = true

	AddInputBlock({ Name = "UseExorcismPoint" })
	if CurrentRun.CurrentRoom.ExitsUnlocked then
		AddTimerBlock( CurrentRun, "UseExorcismPoint" )
	end
	
	CurrentRun.Hero.UntargetableFlags.Exorcism = true
	SetPlayerInvulnerable( "Exorcism" )
	AddPlayerImmuneToForce( "Exorcism" )

	user.ExorcismDamageTaken = nil
	user.PreExorcismThreadName ="PreExorcismThread"

	source.AttemptsRemaining = (source.AttemptsRemaining or 0) - 1

	InvalidateCheckpoint()

	local usedFamiliar = false
	if HasFamiliarTool( "ToolExorcismBook" ) then
		usedFamiliar = true
		FamiliarExorcismStartPresentation( source, args, user )
	else
		ExorcismStartPresentation( source, args, user )
	end

	if HasFamiliarTool( "ToolExorcismBook" ) then
		GameState.ExorcismSuccessesFamiliar = (GameState.ExorcismSuccessesFamiliar or 0) + 1
		CurrentRun.ExorcismSuccessesFamiliar = (CurrentRun.ExorcismSuccessesFamiliar or 0) + 1
	else
		if ExorcismSequence( source, source, args, user ) then
			GameState.ExorcismSuccessesManual = (GameState.ExorcismSuccessesManual or 0) + 1
			CurrentRun.ExorcismSuccessesManual = (CurrentRun.ExorcismSuccessesManual or 0) + 1
		else
			GameState.ExorcismFails = (GameState.ExorcismFails or 0) + 1
			CurrentRun.ExorcismFails = (CurrentRun.ExorcismFails or 0) + 1

			if source.AttemptsRemaining <= 0 then
				UseableOff({ Id = source.ObjectId })
				RecordMapState( CurrentRun.CurrentRoom.Name, source.ObjectId, "Destroyed", true )
			end

			ExorcismFailPresentation( source, args, user, move )
			RemoveInputBlock({ Name = "UseExorcismPoint" })
			RemoveTimerBlock( CurrentRun, "UseExorcismPoint" )
			
			CurrentRun.Hero.UntargetableFlags.Exorcism = nil
			SetPlayerVulnerable( "Exorcism" )
			RemovePlayerImmuneToForce( "Exorcism" )

			return
		end
	end

	GameState.ExorcismSuccesses = (GameState.ExorcismSuccesses or 0) + 1
	CurrentRun.ExorcismSuccesses = (CurrentRun.ExorcismSuccesses or 0) + 1

	GameState.ExorcisedNames[source.Animation] = (GameState.ExorcisedNames[source.Animation] or 0) + 1
	CurrentRun.ExorcisedNames[source.Animation] = (CurrentRun.ExorcisedNames[source.Animation] or 0) + 1
	
	local resourceTimes = 1
	if RandomChance( GetTotalHeroTraitValue("DoubleToolRewardChance")) then
		resourceTimes = resourceTimes + 1
	end

	if resourceTimes > 1 then
		thread( ChaosRewardIncreasedPresentation, source.ObjectId )
		waitUnmodified( 0.25, RoomThreadName)
	end

	for resourceName, resourceAmount in pairs( source.AddResources ) do
		AddResource( resourceName, resourceAmount * resourceTimes, source.Name )
	end

	CheckForToolElement( source.ObjectId, "ToolExorcismBook2" )

	ExorcismSuccessPresentation( source, args, user )
	UseableOff({ Id = source.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", "Blank" )
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )
	
	RemoveInputBlock({ Name = "UseExorcismPoint" })
	RemoveTimerBlock( CurrentRun, "UseExorcismPoint" )
	
	CurrentRun.Hero.UntargetableFlags.Exorcism = nil
	SetPlayerVulnerable( "Exorcism" )
	RemovePlayerImmuneToForce( "Exorcism" )
	
	if usedFamiliar then
		ReenableFamiliar( MapState.FamiliarUnit )
	end
end

Using "Melinoe_Tablet_Both_Start"
Using "Melinoe_Tablet_Left_Start"
Using "Melinoe_Tablet_Right_Start"
Using "Melinoe_Tablet_Both_End"
Using "Melinoe_Tablet_Left_End"
Using "Melinoe_Tablet_Right_End"
Using "ExorcismSuccessHandLeft"
Using "ExorcismSuccessHandRight"
function ExorcismSequence( source, exorcismData, args, user )
	local totalCheckFails = 0
	local consecutiveCheckFails = 0
	local prevAnim = "Melinoe_Tablet_Idle"

	if exorcismData.MoveSequence == nil then
		return false
	end

	for i, move in ipairs( exorcismData.MoveSequence ) do
		DebugPrint({ Text = "Exorcism Move "..i.." (Left = "..tostring(move.Left)..", Right = "..tostring(move.Right)..")" })
		move.EndTime = _worldTime + move.Duration
		ExorcismNextMovePresentation( source, args, user, move )
		while _worldTime < move.EndTime do
			wait( exorcismData.InputCheckInterval or 0.1 )

			if user.ExorcismDamageTaken then
				return false
			end

			local isLeftDown = IsControlDown({ Name = "ExorcismLeft" })
			local isRightDown = IsControlDown({ Name = "ExorcismRight" })
			local targetAnim = nil
			if isLeftDown and isRightDown then
				targetAnim = "Melinoe_Tablet_Both_Start"
			elseif isLeftDown then
				targetAnim = "Melinoe_Tablet_Left_Start"
			elseif isRightDown then
				targetAnim = "Melinoe_Tablet_Right_Start"
			else
				if prevAnim == "Melinoe_Tablet_Both_Start" then
					targetAnim = "Melinoe_Tablet_Both_End"
				elseif prevAnim == "Melinoe_Tablet_Left_Start" then
					targetAnim = "Melinoe_Tablet_Left_End"					
				elseif prevAnim == "Melinoe_Tablet_Right_Start" then
					targetAnim = "Melinoe_Tablet_Right_End"
				end
			end

			local nextAnim = nil
			if targetAnim ~= nil and targetAnim ~= prevAnim then
				nextAnim = targetAnim
			end

			if nextAnim ~= nil then
				SetAnimation({ Name = nextAnim, DestinationId = user.ObjectId })
				prevAnim = nextAnim
			end

			local isLeftCorrect = move.Left == isLeftDown
			local isRightCorrect = move.Right == isRightDown

			ExorcismInputCheckPresentation( source, args, user, move, isLeftCorrect, isRightCorrect, isLeftDown, isRightDown, consecutiveCheckFails, exorcismData )

			if isLeftCorrect and isRightCorrect then
				consecutiveCheckFails = 0
			else
				move.EndTime = move.EndTime + (exorcismData.InputCheckInterval or 0.1)
				totalCheckFails = totalCheckFails + 1
				consecutiveCheckFails = consecutiveCheckFails + 1
				--DebugPrint({ Text = "Exorcism consecutiveCheckFails = "..consecutiveCheckFails })
				if totalCheckFails >= (exorcismData.TotalCheckFails or 99) or consecutiveCheckFails >= (exorcismData.ConsecutiveCheckFails or 14) then
					return false
				end
			end
		end
		if exorcismData.RequireCorrectAtMoveSwitch and consecutiveCheckFails > 0 then
			return false
		end

		local key = "MovePipId"..move.Index
		SetAnimation({ Name = "ExorcismPip_Full", DestinationId = source[key] })
		if move.Left and move.Right then
			CreateAnimation({ Name = "ExorcismSuccessHandLeft", DestinationId = CurrentRun.Hero.ObjectId })
			CreateAnimation({ Name = "ExorcismSuccessHandRight", DestinationId = CurrentRun.Hero.ObjectId })
		elseif move.Left then
			CreateAnimation({ Name = "ExorcismSuccessHandLeft", DestinationId = CurrentRun.Hero.ObjectId })
		elseif move.Right then
			CreateAnimation({ Name = "ExorcismSuccessHandRight", DestinationId = CurrentRun.Hero.ObjectId })
		end
		-- DebugPrint({ Text = "_AFTAR_ Exorcism Move "..i.." (Left = "..tostring(move.Left)..", Right = "..tostring(move.Right)..")" })
		
	end

	DebugPrint({ Text = "totalCheckFails = "..totalCheckFails })
	return true
end

function ActivateHarvestPointBase( source )
	local roomData = RoomData[CurrentRun.CurrentRoom.Name]
	if roomData.HarvestPointBase == nil then
		return
	end
	local baseIds = GetInactiveIdsByType({ Name = roomData.HarvestPointBase })
	local closestBaseId = GetClosestInactiveId({ Id = source.ObjectId, DestinationIds = baseIds, Distance = 200 })
	Activate({ Id = closestBaseId })
end

function GetResourceNodeSpawnChance( resourceData, roomChance, bonusTraitName )

	-- if a room is forcing a spawn chance of 0, we don't want to override that
	if roomChance ~= nil and roomChance == 0 then
		return 0
	end

	local baselineSpawnChance = 0
	local familiarSpawnChance = 0

	if GameState.EquippedFamiliar and FamiliarData[GameState.EquippedFamiliar].LinkedTool == resourceData.ToolName then
		familiarSpawnChance = GameState.FamiliarResourceSpawnChance
	end

	if resourceData.ToolName == GameState.EquippedToolName then
		if roomChance ~= nil then
			baselineSpawnChance = roomChance
		else
			baselineSpawnChance = resourceData.HasToolSpawnChance
		end
	else
		-- having a familiar equipped ignores the cap for its associated resource
		if familiarSpawnChance > 0 or ( CurrentRun.ResourceNodesSeen[resourceData.ToolName] or 0 ) < resourceData.DefaultSpawnCap then
			baselineSpawnChance = resourceData.DefaultSpawnChance
		end
	end
	
	if baselineSpawnChance ~= 0 then
		baselineSpawnChance = baselineSpawnChance + GetTotalHeroTraitValue( bonusTraitName )
	end

	return baselineSpawnChance + familiarSpawnChance

end

function CheckForToolElement( spawnPointId, toolName )
	if GameState.WeaponsUnlocked[toolName] and not CurrentRun.ToolElementsSpawned[toolName] and not CurrentRun.Hero.IsDead then
		local toolData = WeaponShopItemData[toolName]
		if RandomChance( toolData.ElementChance ) then
			thread( GrantElementFromTool, toolData )
		end
	end
end

function GrantElementFromTool( toolData )
	wait( toolData.ElementPopupDelay )
	AddOrIncreaseTrait( { TraitName = toolData.ElementName } )
	CurrentRun.ToolElementsSpawned[toolData.Name] = (CurrentRun.ToolElementsSpawned[toolData.Name] or 0) + 1
end