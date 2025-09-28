function SetupHarvestPoints( currentRoom, args )

	args = args or {}
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		EditorActivateAllHarvestPoints()
	end

	local requirementArgs = { RoomSetName = currentRoom.RoomSetName }
	local roomData = RoomData[currentRoom.Name] or currentRoom

	-- HarvestPoints
	local harvestPoints = GetInactiveIdsByType({ Name = "HarvestPoint" })
	if (currentRoom.HarvestPointsAllowed or 0) > 0 then
		local shouldTrackCount = ( currentRoom.NumHarvestPoints == 0 and not roomData.ResourcePointsIgnoredByBiomeRequirements )
		currentRoom.HarvestPointChoicesIds = currentRoom.HarvestPointChoicesIds or {}
		currentRoom.HarvestPointChoicesOptions = currentRoom.HarvestPointChoicesOptions or {}
		for i = 1, currentRoom.HarvestPointsAllowed do
			if IsEmpty( harvestPoints ) then
				break
			end
			local weightedList = {}
			for k, option in pairs( HarvestData.WeightedOptions ) do
				if IsGameStateEligible( option, option.GameStateRequirements, requirementArgs ) then
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
					if shouldTrackCount then
						currentRoom.NumHarvestPoints = currentRoom.NumHarvestPoints + 1
					end
					currentRoom.UseableHarvestPoint = true
				end
			end
		end
	end

	-- ShovelPoints
	local shovelPoints = GetInactiveIdsByType({ Name = "ShovelPoint" })
	if currentRoom.ShovelPointSuccess then
		local shouldTrackCount = ( currentRoom.NumShovelPoints == 0 and not roomData.ResourcePointsIgnoredByBiomeRequirements )
		currentRoom.ShovelPointChoices = currentRoom.ShovelPointChoices or {}
		for i = 1, currentRoom.ShovelPointsAllowed or 1 do
			if IsEmpty( shovelPoints ) then
				break
			end
			local shovelPointId = currentRoom.ShovelPointChoices[i] or RemoveRandomValue( shovelPoints )
			if MapState.ActiveObstacles[shovelPointId] == nil then
				local shovelPoint = DeepCopyTable( ObstacleData.ShovelPoint )
				shovelPoint.ObjectId = shovelPointId
				currentRoom.ShovelPointChoices[i] = shovelPoint.ObjectId
				Activate({ Id = shovelPoint.ObjectId, TriggerOnSpawn = false })
				SetupObstacle( shovelPoint )
				if shouldTrackCount then
					currentRoom.NumShovelPoints = currentRoom.NumShovelPoints + 1
					CurrentRun.BiomeHarvestPointsSeen.ShovelPoint = (CurrentRun.BiomeHarvestPointsSeen.ShovelPoint or 0) + 1
				end
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
	if currentRoom.PickaxePointSuccess then
		local shouldTrackCount = ( currentRoom.NumPickaxePoints == 0 and not roomData.ResourcePointsIgnoredByBiomeRequirements )
		currentRoom.PickaxePointChoices = currentRoom.PickaxePointChoices or {}
		for i = 1, currentRoom.PickaxePointsAllowed or 1 do
			if IsEmpty( pickaxePoints ) then
				break
			end
			currentRoom.ChosenPickaxePointData = currentRoom.ChosenPickaxePointData or GetRandomEligibleValueFromWeightedList( PickaxePointData.WeightedOptions, requirementArgs )
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
				if pickaxePoint.Geometry ~= nil then
					SetGeometry({ Id = pickaxePoint.ObjectId, Points = pickaxePoint.Geometry })
				end
				if shouldTrackCount then
					currentRoom.NumPickaxePoints = currentRoom.NumPickaxePoints + 1
					CurrentRun.BiomeHarvestPointsSeen.PickaxePoint = (CurrentRun.BiomeHarvestPointsSeen.PickaxePoint or 0) + 1
				end
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
		local shouldTrackCount = ( currentRoom.NumExorcismPoints == 0 and not roomData.ResourcePointsIgnoredByBiomeRequirements )
		currentRoom.ExorcismPointChoices = currentRoom.ExorcismPointChoices or {}
		for i = 1, currentRoom.ExorcismPointsAllowed or 1 do
			if IsEmpty( exorcismPoints ) then
				break
			end
			currentRoom.ChosenExorcismPointData = currentRoom.ChosenExorcismPointData or GetRandomEligibleValueFromWeightedList( ExorcismData.WeightedOptions, requirementArgs )
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
				CreateAnimation({ DestinationId = exorcismPoint.ObjectId, Name = "ExorcismPointAvailable" })
				if shouldTrackCount then
					currentRoom.NumExorcismPoints = currentRoom.NumExorcismPoints + 1
					CurrentRun.BiomeHarvestPointsSeen.ExorcismPoint = (CurrentRun.BiomeHarvestPointsSeen.ExorcismPoint or 0) + 1
				end
				if HasAccessToTool( "ToolExorcismBook" ) then
					currentRoom.UseableExorcismPoint = true	
					ExorcismGenerateMoveSequence( exorcismPoint )
					ExorcismPointChosenPresentation( exorcismPoint )
					SetAnimation({ DestinationId = exorcismPoint.ObjectId, Name = exorcismPoint.Animation })
				else
					exorcismPoint.ExitsUnlockedFunctionName = nil
					exorcismPoint.UseText = exorcismPoint.NoToolUseText
				end
			end
		end
	end

	-- FishingPoints
	local fishingPointIds = GetInactiveIdsByType({ Name = "FishingPoint" })
	if currentRoom.FishingPointSuccess and not currentRoom.FishingPointUsed then
		local shouldTrackCount = ( currentRoom.NumFishingPoints == 0 and not roomData.ResourcePointsIgnoredByBiomeRequirements )
		currentRoom.FishingPointChoices = currentRoom.FishingPointChoices or {}
		for i = 1, currentRoom.FishingPointsAllowed or 1 do
			if IsEmpty( fishingPointIds ) then
				break
			end
			local fishingPointId = currentRoom.FishingPointChoices[i] or RemoveRandomValue( fishingPointIds )
			if MapState.ActiveObstacles[fishingPointId] == nil then
				local fishingPoint = DeepCopyTable( ObstacleData.FishingPoint )
				fishingPoint.ObjectId = fishingPointId
				if roomData.FishingPointRadii ~= nil then
					fishingPoint.InteractDistance = roomData.FishingPointRadii[fishingPointId]
				end
				currentRoom.FishingPointChoices[i] = fishingPoint.ObjectId
				Activate({ Id = fishingPoint.ObjectId, TriggerOnSpawn = false })
				SetupObstacle( fishingPoint )
				if shouldTrackCount then
					currentRoom.NumFishingPoints = currentRoom.NumFishingPoints + 1
					CurrentRun.BiomeHarvestPointsSeen.FishingPoint = (CurrentRun.BiomeHarvestPointsSeen.FishingPoint or 0) + 1
				end
				if HasAccessToTool("ToolFishingRod") then
					local roomData = RoomData[currentRoom.Name] or currentRoom
					SetAnimation({ Name = "FishingPointActive", DestinationId = fishingPoint.ObjectId })
					currentRoom.UseableFishingPoint = true
				else
					fishingPoint.ExitsUnlockedFunctionName = nil
					fishingPoint.UseText = fishingPoint.NoToolUseText
				end
			end
		end
	end

end

function IsAggroedUnitBlockingHarvest()
	for id, v  in pairs( ShallowCopyTable( MapState.AggroedUnits ) ) do
		local unit = ActiveEnemies[id]
		if unit ~= nil and not unit.AllowHarvestWhileAggroed and not unit.AlwaysTraitor then
			return true
		end
	end
	return false
end

function IsComplexHarvestAllowed()
	if IsCombatEncounterActive( CurrentRun, { IgnoreMainEncounter = CurrentRun.CurrentRoom.IgnoreMainEncounterForInventory, CheckBlockCodexBeforeStart = true } ) then
		return false
	end

	if not IsEmpty( RequiredKillEnemies ) then
		return false
	end

	if IsAggroedUnitBlockingHarvest() then
		return false
	end

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

function GetHarvestPointSpawnChance( resourceData, room )
	local spawnLimitPerBiome = resourceData.SpawnLimitPerBiome
	if HasFamiliarTool( resourceData.ToolName ) then
		spawnLimitPerBiome = spawnLimitPerBiome + 1
	end
	if not room.IgnoreHarvestBiomeSpawnLimit and ( CurrentRun.BiomeHarvestPointsSeen[resourceData.HarvestPointName] or 0 ) >= spawnLimitPerBiome then
		return 0
	end

	local roomChance = room[resourceData.RoomChanceName]
	if roomChance == 0 then
		return 0
	end

	local familiarSpawnChance = 0
	if HasFamiliarTool( resourceData.ToolName ) then
		familiarSpawnChance = GetTotalHeroTraitValue( "FamiliarResourceBonusChance" )
	end

	return (roomChance or resourceData.SpawnChance) + familiarSpawnChance
end

function GrantElementFromTool( toolName, args )
	args = args or {}

	if not GameState.WeaponsUnlocked[toolName] then
		return
	end
	if CurrentRun.ToolElementsSpawned[toolName] then
		return
	end
	if CurrentRun.Hero.IsDead then
		return
	end

	local toolData = WeaponShopItemData[toolName]
	if RandomChance( toolData.ElementChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true }) ) then
		CurrentRun.ToolElementsSpawned[toolName] = (CurrentRun.ToolElementsSpawned[toolName] or 0) + 1
		if not args.SkipDelay then
			wait( toolData.ElementPopupDelay, "GrantElementFromTool" )
		end
		local toolData = WeaponShopItemData[toolName]
		AddTraitToHero( { TraitName = toolData.ElementName, SkipActivatedTraitUpdate = args.SkipActivatedTraitUpdate } )
		return toolData.ElementName
	end
end

function AutoHarvestOnExit()
	local addResources = {}
	local elements = {}
	local harvestPointIds = GetIdsByType({ Names = { "HarvestPoint", "ShovelPoint", "PickaxePoint", "ExorcismPoint", "FishingPoint", "Mixer6CommonDrop" } })
	for _, id in ipairs( harvestPointIds ) do
		if IsUseable({ Id = id }) then
			local harvestPoint = MapState.ActiveObstacles[id]
			CallFunctionName( harvestPoint.OnUsedOnExitFunctionName, harvestPoint, addResources, elements )
		end
	end

	local elementIconSpacing = 80
	local numElements = TableLength( elements )
	local elementOffsetX = elementIconSpacing * -0.5 * (numElements - 1)
	for elementName in pairs( elements ) do
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ElementGranted_CombatText", ShadowScaleX = 1.5, SkipRise = true, SkipFlash = false, Duration = 1.8, OffsetX = elementOffsetX, OffsetY = 80, LuaKey = "TempTextData", LuaValue = { Name = elementName } } )
		elementOffsetX = elementOffsetX + elementIconSpacing
	end

	local count = 0
	for resourceName, amount in pairs( addResources ) do
		local resourceData = ResourceData[resourceName]
		PlaySound({ Name = resourceData.AutoHarvestSound, DestinationId = HUDScreen.Components.InventoryIcon.Id, Delay = 0.1 + (count * 0.2) })
		AddResource( resourceName, amount, "AutoHarvestOnExit", {
			PresentationDelay = count * 0.2,
			SkipVoiceLines = true,
			SkipResourceGainSound = true,
			StartId = HUDScreen.Components.InventoryIcon.Id,
			OffsetX = -120,
			AnchorOffsetY = -50 - (count * 50),
			HoldOffsetY = -100 - (count * 50),
			FontSize = 120,
			ShadowScale = 0.5,
		} )
		count = count + 1
	end
end

function UseHarvestPoint( source, args, user )

	if not CheckCooldown( "UsedHarvestPoint", 0.75, true ) or MapState.HostilePolymorph or ( HasFamiliarTool( "ToolHarvest" ) and not MapState.FamiliarUnit ) then
		return
	end

	if source == nil or source.AddResources == nil then
		return
	end

	local usedFamiliar = false
	if HasFamiliarTool( "ToolHarvest" ) and IsComplexHarvestAllowed() then
		usedFamiliar = true
	end

	AddInputBlock({ Name = "UseHarvestPoint" })
	if CurrentRun.CurrentRoom.ExitsUnlocked or usedFamiliar then
		AddTimerBlock( CurrentRun, "UseHarvestPoint" )
	end

	if usedFamiliar then
		BeginFamiliarHarvestInvulnerability()
		FamiliarHarvestStartPresentation( source, args, user, chosenOption )
	else
		HarvestStartPresentation( source, args, user )
	end

	GameState.HarvestSuccesses = (GameState.HarvestSuccesses or 0) + 1
	CurrentRun.HarvestSuccesses = (CurrentRun.HarvestSuccesses or 0) + 1
	if usedFamiliar then
		GameState.HarvestSuccessesFamiliar = (GameState.HarvestSuccessesFamiliar or 0) + 1
		CurrentRun.HarvestSuccessesFamiliar = (CurrentRun.HarvestSuccessesFamiliar or 0) + 1
	else
		GameState.HarvestSuccessesManual = (GameState.HarvestSuccessesManual or 0) + 1
		CurrentRun.HarvestSuccessesManual = (CurrentRun.HarvestSuccessesManual or 0) + 1
	end

	for resourceName, count in pairs( source.AddResources ) do
		AddResource( resourceName, count, source.Name )
	end

	UseableOff({ Id = source.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", "Blank" )
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )
	HarvestEndPresentation( source, args, user )
	RemoveInputBlock({ Name = "UseHarvestPoint" })
	RemoveTimerBlock( CurrentRun, "UseHarvestPoint" )

	if usedFamiliar then
		EndFamiliarHarvestInvulnerability()
		thread( PlayVoiceLines, HeroVoiceLines.FamiliarThankingVoiceLines, true )
		wait( 0.3 )
		ReenableFamiliar( MapState.FamiliarUnit, { InitialDelay = 1.0 } )
	end

	local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
	if heal > 0 then
		Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
	end
end

function UseHarvestPointOnExit( source, resourceTable, elementTable )
	for resourceName, count in pairs( source.AddResources ) do
		resourceTable[resourceName] = (resourceTable[resourceName] or 0) + count
	end

	local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
	if heal > 0 then
		Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
	end

	UseableOff({ Id = source.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", "Blank" )
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )

	thread( UsedHarvestPointPresentation, source, { SkipVoiceLines = true } )
end

function HarvestPointUseCanceled( user, triggerArgs )
	killTaggedThreads( user.PreHarvestThreadName )
	RemoveInputBlock({ Name = "UseHarvestPoint" })
	RemoveTimerBlock( CurrentRun, "UseHarvestPoint" )
	RemoveOnDamagedFunction( user, "HarvestPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil
	if triggerArgs.Silent then
		SetAnimation({ Name = "MelinoeGatherReturnToIdle", DestinationId = user.ObjectId })
	end
end

function UseShovelPoint( source, args, user )

	if not CheckCooldown( "UseShovelPoint", 0.75, true ) or MapState.HostilePolymorph or ( HasFamiliarTool( "ToolShovel" ) and not MapState.FamiliarUnit ) then
		return
	end

	if not HasAccessToTool( "ToolShovel" ) then
		HarvestNoToolPresentation( source, args, user, "ToolShovel" )
		return
	end

	local usedFamiliar = false
	if HasFamiliarTool( "ToolShovel" ) and IsComplexHarvestAllowed() then
		usedFamiliar = true
	end

	AddInputBlock({ Name = "UseShovelPoint" })
	if CurrentRun.CurrentRoom.ExitsUnlocked or usedFamiliar then
		AddTimerBlock( CurrentRun, "UseShovelPoint" )
	end

	local chosenOption = GetRandomEligibleValueFromWeightedList( ShovelPointData.WeightedOptions, { RoomSetName = CurrentRun.CurrentRoom.RoomSetName } )
	if usedFamiliar then
		BeginFamiliarHarvestInvulnerability()
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
	if RandomChance( GetTotalHeroTraitValue("DoubleToolRewardChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
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

	if ShovelPointData.ShovelPointBonusDrops ~= nil then
		for i, drop in ipairs( ShovelPointData.ShovelPointBonusDrops ) do
			if RandomChance( drop.Chance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true }) ) then
				if drop.PresentationFunctionName ~= nil then
					CallFunctionName( drop.PresentationFunctionName, source, args, user )
				end
				if drop.ProjectileName ~= nil then
					local shovelTrap = DeepCopyTable( EnemyData.ShovelPointTrap )
					shovelTrap.ObjectId = SpawnUnit({ Name = "ShovelPointTrap", Group = "Standing", DestinationId = source.ObjectId })	
					thread(SetupUnit, shovelTrap, CurrentRun )
					CreateProjectileFromUnit({ Name = drop.ProjectileName, Id = shovelTrap.ObjectId, DestinationId = source.ObjectId, FireFromTarget = true })
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

	thread( GrantElementFromTool, "ToolShovel2" )

	UseableOff({ Id = source.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", "ShovelPointUsed" )
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )
	ShovelEndPresentation( source, args, user, chosenOption )
	RemoveInputBlock({ Name = "UseShovelPoint" })
	RemoveTimerBlock( CurrentRun, "UseShovelPoint" )

	if usedFamiliar then
		EndFamiliarHarvestInvulnerability()
		thread( PlayVoiceLines, HeroVoiceLines.FamiliarThankingVoiceLines, true )
		wait( 0.3 )
		ReenableFamiliar( MapState.FamiliarUnit, { InitialDelay = 1.0 } )
	end
	
	local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
	if heal > 0 then
		Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
	end
end

function UseShovelPointOnExit( source, resourceTable, elementTable )
	local chosenOption = GetRandomEligibleValueFromWeightedList( ShovelPointData.WeightedOptions, { RoomSetName = CurrentRun.CurrentRoom.RoomSetName } )
	for resourceName, count in pairs( chosenOption.AddResources ) do
		resourceTable[resourceName] = (resourceTable[resourceName] or 0) + count
	end

	local elementName = GrantElementFromTool( "ToolShovel2", { SkipDelay = true, SkipActivatedTraitUpdate = true } )
	if elementName ~= nil then
		elementTable[elementName] = true
	end

	local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
	if heal > 0 then
		Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
	end

	UseableOff({ Id = source.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", "ShovelPointUsed" )
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )

	thread( UsedShovelPointOnExitPresentation, source )
end

function ShovelPointUseCanceled( user, triggerArgs )
	killTaggedThreads( user.PreHarvestThreadName )
	RemoveInputBlock({ Name = "UseShovelPoint" })
	RemoveTimerBlock( CurrentRun, "UseShovelPoint" )
	RemoveOnDamagedFunction( user, "ShovelPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil
	if triggerArgs.Silent then
		SetAnimation({ Name = "Melinoe_Shovel_End", DestinationId = user.ObjectId })
	end
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

	local usedFamiliar = false
	if HasFamiliarTool( "ToolPickaxe" ) and IsComplexHarvestAllowed() then
		usedFamiliar = true
	end

	AddInputBlock({ Name = "UsePickaxePoint" })
	if CurrentRun.CurrentRoom.ExitsUnlocked or usedFamiliar then
		AddTimerBlock( CurrentRun, "UsePickaxePoint" )
	end

	user.PreHarvestThreadName = "PickaxeStartPresentation"
	user.PickaxeDamageTaken = nil
	AddOnDamagedFunction( user, "PickaxePointUseCanceled" )
	user.OnHostilePolymorphFunctionName = "PickaxePointUseCanceled"

	waitUnmodified( 0.02, user.PreHarvestThreadName )

	local keepMining = true
	while keepMining do
	
		if usedFamiliar then
			BeginFamiliarHarvestInvulnerability()
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
			PickaxeDepositDestroyedPresentation( source, { UsedFamiliar = usedFamiliar } )

			GameState.PickaxeSuccesses = (GameState.PickaxeSuccesses or 0) + 1
			CurrentRun.PickaxeSuccesses = (CurrentRun.PickaxeSuccesses or 0) + 1
			if usedFamiliar then
				GameState.PickaxeSuccessesFamiliar = (GameState.PickaxeSuccessesFamiliar or 0) + 1
				CurrentRun.PickaxeSuccessesFamiliar = (CurrentRun.PickaxeSuccessesFamiliar or 0) + 1
			else
				GameState.PickaxeSuccessesManual = (GameState.PickaxeSuccessesManual or 0) + 1
				CurrentRun.PickaxeSuccessesManual = (CurrentRun.PickaxeSuccessesManual or 0) + 1
			end

			thread( GrantElementFromTool, "ToolPickaxe2" )

			UseableOff({ Id = source.ObjectId })
			RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", source.EmptyAnimation )
			RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )
		end
		local resourceTimes = 1
		if RandomChance( GetTotalHeroTraitValue("DoubleToolRewardChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
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
		EndFamiliarHarvestInvulnerability()
		thread( PlayVoiceLines, HeroVoiceLines.FamiliarThankingVoiceLines, true )
		wait( 0.3 )
		ReenableFamiliar( MapState.FamiliarUnit, { InitialDelay = 1.0 } )
	end

	local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
	if heal > 0 and source.Health <= 0 then
		Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
	end
end

function UsePickaxePointOnExit( source, resourceTable, elementTable )
	resourceTable[source.ResourceName] = (resourceTable[source.ResourceName] or 0) + source.Health

	local elementName = GrantElementFromTool( "ToolPickaxe2", { SkipDelay = true, SkipActivatedTraitUpdate = true } )
	if elementName ~= nil then
		elementTable[elementName] = true
	end

	source.Health = 0
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Health", source.Health )

	local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
	if heal > 0 then
		Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
	end

	UseableOff({ Id = source.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", source.EmptyAnimation )
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )

	thread( PickaxeDepositDestroyedPresentation, source, { SkipVoiceLines = true, SkipSound = true } )
end

function PickaxePointUseCanceled( user, triggerArgs )
	killTaggedThreads( user.PreHarvestThreadName )
	RemoveInputBlock({ Name = "UsePickaxePoint" })
	RemoveTimerBlock( CurrentRun, "UsePickaxePoint" )
	RemoveOnDamagedFunction( user, "PickaxePointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil
	DebugPrint({ Text = "Harvest canceled by damage" })
	user.PickaxeDamageTaken = true
	if triggerArgs.Silent then
		SetAnimation({ Name = "MelinoePickAxeMineReturnToIdle", DestinationId = user.ObjectId })
	end
end

function UseExorcismPoint( source, args, user )
	args = args or {}

	if not CheckCooldown( "UseExorcismPoint", 0.75, true ) or MapState.HostilePolymorph or ( HasFamiliarTool( "ToolExorcismBook" ) and not MapState.FamiliarUnit ) then
		return
	end

	if not HasAccessToTool( "ToolExorcismBook" ) then
		HarvestNoToolPresentation( source, args, user, "ToolExorcismBook" )
		return
	end
		
	if not IsComplexHarvestAllowed() then
		HarvestBlockedPresentation( source, { Text = "UseBlockedByEnemies" } )
		return
	end

	CurrentRun.CurrentRoom.ExorcismPointUsed = true

	AddInputBlock({ Name = "UseExorcismPoint" })
	AddTimerBlock( CurrentRun, "UseExorcismPoint" )
	
	CurrentRun.Hero.UntargetableFlags.Exorcism = true
	SetPlayerInvulnerable( "Exorcism" )
	AddPlayerImmuneToForce( "Exorcism" )

	user.ExorcismDamageTaken = nil
	user.PreExorcismThreadName = "PreExorcismThread"

	source.AttemptsRemaining = (source.AttemptsRemaining or 0) - 1

	InvalidateCheckpoint()

	local usedFamiliar = false
	if HasFamiliarTool( "ToolExorcismBook" ) and not args.DisallowFamiliar then
		usedFamiliar = true
		FamiliarExorcismStartPresentation( source, args, user )
	else
		ExorcismStartPresentation( source, args, user )
	end

	if usedFamiliar then
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
	
	if not args.SkipResourceGain then
		local resourceTimes = 1
		if RandomChance( GetTotalHeroTraitValue("DoubleToolRewardChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
			resourceTimes = resourceTimes + 1
		end

		if resourceTimes > 1 then
			thread( ChaosRewardIncreasedPresentation, source.ObjectId )
			waitUnmodified( 0.25, RoomThreadName)
		end

		for resourceName, resourceAmount in pairs( source.AddResources ) do
			AddResource( resourceName, resourceAmount * resourceTimes, source.Name )
		end

		thread( GrantElementFromTool, "ToolExorcismBook2" )
		thread( CheckQuestStatus )
	end

	ExorcismSuccessPresentation( source, { UsedFamiliar = usedFamiliar, ShowSpecialEmote = args.ShowSpecialEmote }, user )
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

	if not args.SkipResourceGain then
		local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
		if heal > 0 then
			Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
		end
	end

end

function UseExorcismPointOnExit( source, resourceTable, elementTable )
	for resourceName, resourceAmount in pairs( source.AddResources ) do
		resourceTable[resourceName] = (resourceTable[resourceName] or 0) + resourceAmount
	end

	local elementName = GrantElementFromTool( "ToolExorcismBook2", { SkipDelay = true, SkipActivatedTraitUpdate = true } )
	if elementName ~= nil then
		elementTable[elementName] = true
	end

	local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
	if heal > 0 then
		Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
	end

	CurrentRun.CurrentRoom.ExorcismPointUsed = true
	UseableOff({ Id = source.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "Animation", "Blank" )
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )

	thread( ExorcismGhostDissipate, source )
end

function ExorcismPointUseCanceled( user, triggerArgs )
	killTaggedThreads( user.PreExorcismThreadName )
	RemoveInputBlock({ Name = "UseExorcismPoint" })
	RemoveTimerBlock( CurrentRun, "UseExorcismPoint" )
	RemoveOnDamagedFunction( user, "ExorcismPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil
	DebugPrint({ Text = "Exorcism canceled by damage" })
	user.ExorcismDamageTaken = true
	if triggerArgs.Silent then
		SetAnimation({ Name = "Melinoe_Tablet_ReturnToIdle", DestinationId = user.ObjectId })
	end
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
					thread( DoRumble, { { LeftTriggerStrengthFraction = 0.0,  RightTriggerStrengthFraction = 0.0, }, } )
					return false
				end
			end
		end
		if exorcismData.RequireCorrectAtMoveSwitch and consecutiveCheckFails > 0 then
			thread( DoRumble, { { LeftTriggerStrengthFraction = 0.0,  RightTriggerStrengthFraction = 0.0, }, } )
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
	thread( DoRumble, { { LeftTriggerStrengthFraction = 0.0,  RightTriggerStrengthFraction = 0.0, }, } )
	return true
end

function UseFishingPoint( fishingPoint, args, user )

	if not CheckCooldown( "UsedFishingPoint", 0.75, true ) or MapState.HostilePolymorph or ( HasFamiliarTool( "ToolFishingRod" ) and not MapState.FamiliarUnit ) then
		return
	end
	
	if not HasAccessToTool( "ToolFishingRod" ) then
		HarvestNoToolPresentation( fishingPoint, args, user, "ToolFishingRod" )
		return
	end

	if not IsComplexHarvestAllowed() then
		HarvestBlockedPresentation( fishingPoint, { Text = "UseBlockedByEnemies" } )
		return
	end

	if ScreenAnchors.LavaVignetteId ~= nil then
		HarvestBlockedPresentation( fishingPoint, { Text = "UseBlockedByLava" } )
		return
	end

	CurrentRun.CurrentRoom.FishingPointUsed = true
	CurrentRun.Hero.UntargetableFlags.Fishing = true
	SetPlayerInvulnerable( "Fishing" )
	AddPlayerImmuneToForce( "Fishing" )

	AddToGroup({ Id = fishingPoint.ObjectId, Name = "UsedFishingPoint" })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "UsedFishingPoint" })

	if HasFamiliarTool( "ToolFishingRod" ) then
		FamiliarFishingPresentation( fishingPoint )
		CurrentRun.Hero.FishingState = "Success"
		UseableOff({ Id = fishingPoint.ObjectId })
		SetAlpha({ Id = fishingPoint.ObjectId, Fraction = 0.0, Duration = 0.25 })
		BlockVfx({ DestinationId = fishingPoint.ObjectId })
		local caughtFishName = GetCaughtFishName( GetCurrentFishingBiomeName() )
		local caughtFishData = FishingData.FishValues[caughtFishName]
		FishingEndPresentation( caughtFishData, fishingPoint.ObjectId, { Success = true, UsedFamiliar = true, } )

		local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
		if GetTotalHeroTraitValue("ResourceGatherHeal") > 0 then
			Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
		end
	else
		CurrentRun.Hero.FishingStarted = true
		FreezePlayerUnit( "FishingStartUp", { DisableTray = true, DisableCodex = true, DisableInventory = true, } )
		AddTimerBlock( CurrentRun, "Fishing" )
		wait( 0.25, "FishingStartDelay" )
		UnfreezePlayerUnit("FishingStartUp")
		if CurrentRun.Hero.FishingStarted and ScreenAnchors.LavaVignetteId == nil then
			UseableOff({ Id = fishingPoint.ObjectId })
			SetAlpha({ Id = fishingPoint.ObjectId, Fraction = 0.0, Duration = 0.25 })
			StopAnimation({ Name = "FishingPointActiveSparkles", DestinationId = fishingPoint.ObjectId })
			BlockVfx({ DestinationId = fishingPoint.ObjectId })
			FishingSequence( nil, { FishingPointId = fishingPoint.ObjectId } )
		else
			RemoveTimerBlock( CurrentRun, "Fishing" )
		end
 	end

	RemoveFromGroup({ Id = fishingPoint.ObjectId, Name = "UsedFishingPoint" })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })

	CurrentRun.Hero.UntargetableFlags.Fishing = nil
	SetPlayerVulnerable( "Fishing" )
	RemovePlayerImmuneToForce( "Fishing" )
end

function FishingSequence( source, args )
	StartFishing( source, args )
	FishingCaughtPresentation( source, args )

	local fishingState = CurrentRun.Hero.FishingState
	local caughtFishName = nil

	if fishingState == "Success" then
		caughtFishName = GetCaughtFishName( GetCurrentFishingBiomeName() )
	end
	DebugPrint({ Text = "caughtFishName = "..tostring(caughtFishName) })
	FishingEndPresentation( FishingData.FishValues[caughtFishName], args.FishingAnimationPointId, { Success = true } )

	if fishingState == "Success" then
		local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
		if heal > 0 then
			Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
		end
	end
end

function GetCurrentFishingBiomeName()
	if CurrentHubRoom ~= nil then
		return CurrentHubRoom.FishBiome or "None"
	else
		return CurrentRun.CurrentRoom.FishBiome or CurrentRun.CurrentRoom.RoomSetName or "None"
	end
end

function StartFishing( source, args )
	args = args or {}
	InvalidateCheckpoint()
	FreezePlayerUnit( "Fishing", { DisableTray = true, DisableCodex = true, DisableInventory = true, } )
	CurrentRun.Hero.FishingInput = false
	CurrentRun.Hero.FishingState = "TooEarly"
	local fishingFailed = false
	args.FishingAnimationPointId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = args.FishingPointId, Group = GetGroupName({ Id = args.FishingPointId, DrawGroup = true }) })
	
	FishingStartPresentation( source, args )

	wait(1.5, "Fishing")
	thread( WaitForFishingInput, args )

	local difficultyData = FishingData.Difficulty[args.Difficulty or "Default"]
	
	local numFakeDunks = RandomInt( difficultyData.NumFakeDunks.Min, difficultyData.NumFakeDunks.Max )
	for i = 1, numFakeDunks do
		wait( RandomFloat( difficultyData.FakeDunkInterval.Min, difficultyData.FakeDunkInterval.Max ), "Fishing" )

		if CurrentRun.Hero.FishingInput then
			return
		end
		SetAnimation({ Name = "FishingBobberFakeDunkA", DestinationId = args.FishingAnimationPointId })
		thread( DoRumble, { { ScreenPreWait = 0.01, LeftFraction = 0.17, Duration = 0.17 }, } )
	end

	local warnTime = RandomFloat( difficultyData.WarnInterval.Min, difficultyData.WarnInterval.Max )
	wait( warnTime , "Fishing" )

	if CurrentRun.Hero.FishingInput then
		return
	end

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom

	SetAnimation({ Name = "FishingBobberDunk", DestinationId = args.FishingAnimationPointId })
	PlaySound({ Name = roomData.FishingDunkSound or "/Leftovers/SFX/FishingPlunk", DestinationId = args.FishingAnimationPointId })
	thread( DoRumble, { { ScreenPreWait = 0.01, RightFraction = 0.4, Duration = 0.3 }, } )
	CurrentRun.Hero.FishingState = "Success"
	wait( difficultyData.SuccessInterval, "Fishing" )

	if CurrentRun.Hero.FishingInput then
		return
	end

	CurrentRun.Hero.FishingState = "TooLate"
	SetAnimation({ Name = "FishingBobberResurface", DestinationId = args.FishingAnimationPointId })
	wait( difficultyData.WayLateInterval, "Fishing" )

	if CurrentRun.Hero.FishingInput then
		return
	end
	CurrentRun.Hero.FishingState = "WayLate"
	wait( difficultyData.GiveUpInterval, "Fishing" )

	notifyExistingWaiters( "FishingInput" )
end

function WaitForFishingInput( args )
	ToggleCombatControl( { "Use" }, true, "Fishing" )
	FishingReadyForInputPresentation( args.FishingAnimationPointId )
	NotifyOnControlPressed({ Names = { "Use", }, Notify = "FishingInput" })
	waitUntil( "FishingInput" )
	CurrentRun.Hero.FishingInput = true
	SetThreadWait( "Fishing", 0.01 )
end

function GetCaughtFishName( biome )
	local fishName = nil
	local biomeData = FishingData.BiomeFish.Defaults
	if FishingData.BiomeFish[biome] then
		biomeData = FishingData.BiomeFish[biome]
	end

	if biomeData then
		local fishingTable = {}
		for _, fishData in ipairs( biomeData ) do
			if fishData.GameStateRequirements == nil or IsGameStateEligible( fishData, fishData.GameStateRequirements ) then
				fishingTable[fishData.Name] = fishingTable.Weight or 1
			end
		end

		fishName = GetRandomValueFromWeightedList( fishingTable )
	end

	return fishName
end

function CancelFishing()
	if not CurrentRun.Hero.FishingStarted then
		return
	end
	CurrentRun.Hero.FishingStarted = false
	RemoveTimerBlock( CurrentRun, "Fishing" )
	UnblockCombatUI( "Fishing" )
	notifyExistingWaiters("FishingInput")
	if HasThread("FishingStartDelay") then
		killTaggedThreads( "FishingStartDelay")		
		UnfreezePlayerUnit("FishingStartUp")
	end
end

function UseFishingPointOnExit( source, resourceTable, elementTable )
	local caughtFishName = GetCaughtFishName( GetCurrentFishingBiomeName() )
	resourceTable[caughtFishName] = (resourceTable[caughtFishName] or 0) + 1

	local elementName = GrantElementFromTool( "ToolFishingRod2", { SkipDelay = true, SkipActivatedTraitUpdate = true } )
	if elementName ~= nil then
		elementTable[elementName] = true
	end

	local heal = GetTotalHeroTraitValue("ResourceGatherHeal") * CalculateHealingMultiplier()
	if heal > 0 then
		Heal( CurrentRun.Hero, { HealFraction = heal, SourceName = "ResourceHeal" })
	end

	CurrentRun.CurrentRoom.FishingPointUsed = true
	UseableOff({ Id = source.ObjectId })
	UsedFishingPointOnExitPresentation( source )
end

-- not technically a "harvest point" but still needs to be collected
function UseDarknessOnExit( source, resourceTable, elementTable )
	resourceTable.Mixer6Common = (resourceTable.Mixer6Common or 0) + source.AddResources.Mixer6Common
	CreateAnimation({ Name = source.ConsumeFx, DestinationId = source.ObjectId })
	Destroy({ Id = source.ObjectId })
end

function BeginFamiliarHarvestInvulnerability()
	CurrentRun.Hero.UntargetableFlags.FamiliarHarvest = true
	SetPlayerInvulnerable( "FamiliarHarvest" )
	AddPlayerImmuneToForce( "FamiliarHarvest" )
end

function EndFamiliarHarvestInvulnerability()
	CurrentRun.Hero.UntargetableFlags.FamiliarHarvest = nil
	SetPlayerVulnerable( "FamiliarHarvest" )
	RemovePlayerImmuneToForce( "FamiliarHarvest" )
end