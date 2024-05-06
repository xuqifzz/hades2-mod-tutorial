function PreGenerateNextBiomeState( source, args )
	GameState.NextBiomeStateName = GameState.NextBiomeStateName or GetNextBiomeStateName()
	if GameState.NextBiomeStateName ~= nil then
		local biomeStateData = BiomeStateData.BiomeStates[GameState.NextBiomeStateName]
		if biomeStateData ~= nil then
			CallFunctionName( biomeStateData.PreGeneratePresentationFunctionName, args )
		end
	end
end

function GetNextBiomeStateName()

	local forceState = false
	if IsGameStateEligible( CurrentRun, BiomeStateData.ForceGameStateRequirements ) then
		forceState = true
	else		
		if not IsGameStateEligible( CurrentRun, BiomeStateData.GameStateRequirements ) then
			return BiomeStateData.DefaultBiomeState
		end	
	
		local runsWithoutStateChange = 0
		if (CurrentRun.BiomeStateChangeCount or 0) <= 0 then
			for i = #GameState.RunHistory, 1 , -1 do
				local prevRun = GameState.RunHistory[i]
				if (prevRun.BiomeStateChangeCount or 0) > 0 then
					break
				end
				runsWithoutStateChange = runsWithoutStateChange + 1
			end
		end
		DebugPrint({ Text = "runsWithoutStateChange = "..runsWithoutStateChange })
		local stateChangeChance = BiomeStateData.DefaultBiomeStateChance + (BiomeStateData.NoBiomeStateChanceIncrement * runsWithoutStateChange)
		if not RandomChance( stateChangeChance ) then
			return BiomeStateData.DefaultBiomeState
		end
	end

	local eligibleStates = {}
	for biomeStateName, biomeStateData in pairs( BiomeStateData.BiomeStates ) do
		if not biomeStateData.Skip and IsGameStateEligible( CurrentRun, biomeStateData, biomeStateData.GameStateRequirements ) then
			table.insert( eligibleStates, biomeStateName )
		end
	end

	if IsEmpty( eligibleStates ) then
		return BiomeStateData.DefaultBiomeState
	end

	local nextBiomeStateName = GetRandomValue( eligibleStates )
	return nextBiomeStateName
end


function CheckBiomeStateStart( currentRoom )

	if currentRoom.BiomeStartRoom then
		EndAllBiomeStates()
		local nextBiomeStateData = nil
		local nextBiomeStateName = GameState.NextBiomeStateName or GetNextBiomeStateName()
		if nextBiomeStateName ~= nil and nextBiomeStateName ~= BiomeStateData.DefaultBiomeState then
			nextBiomeStateData = BiomeStateData.BiomeStates[nextBiomeStateName]
		elseif IsGameStateEligible( CurrentRun, BiomeStateData.DefaultBiomeStateRequirements) then
			nextBiomeStateData = BiomeStateData.BiomeStates[BiomeStateData.DefaultBiomeState]
		end
		GameState.NextBiomeStateName = nil
		if nextBiomeStateData ~= nil then
			IncrementTableValue( GameState.BiomeStateRecord, nextBiomeStateData.Name )
			thread( CallFunctionName, nextBiomeStateData.BiomeInitialPresentationFunctionName )			
			if nextBiomeStateData.TraitGameStateRequirements == nil or IsGameStateEligible( CurrentRun, nextBiomeStateData.TraitGameStateRequirements ) then
				AddTraitToHero( { TraitName = nextBiomeStateData.TraitName, SkipUIUpdate = not hasValidState, SkipPriorityTray = true } )
			end
			UpdateHeroTraitDictionary()
			CurrentRun.BiomeStateName = nextBiomeStateData.Name
			if CurrentRun.BiomeStateName ~= BiomeStateData.DefaultBiomeState then
				CurrentRun.BiomeStateChangeCount = (CurrentRun.BiomeStateChangeCount or 0) + 1
			end
			thread( BiomeStateStartedPresentation, nextBiomeStateData )
		end
	end
end

function EndAllBiomeStates()
	local condemnedTraits = {}
	for _, traitData in pairs(CurrentRun.Hero.Traits) do
		if traitData.BiomeStateTrait then
			table.insert(condemnedTraits, traitData.Name )
		end
	end
	for _, condemnedTraitName in pairs( condemnedTraits ) do
		EndBiomeFromTraitName( condemnedTraitName )
	end
	CurrentRun.BiomeStateName = nil
end

function EndBiomeFromTraitName( traitName )
	RemoveTrait( CurrentRun.Hero, traitName )
	for biomeStateName, biomeStateData in pairs( BiomeStateData.BiomeStates ) do
		if biomeStateData.TraitName == traitName and biomeStateData.BiomeEndPresentationFunctionName then
			thread( CallFunctionName, biomeStateData.BiomeEndPresentationFunctionName )
		end
	end
end

function RainEffectApply( unit, args )
	
	if unit.IsBoss then
		return
	end
	wait(0.1)
	local effectName = (args and args.EffectName) or "WetRain"
	ApplyEffect({ DestinationId = unit.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData.WetRain.EffectData})
end

function SpawnHealDrops( unit, args )
	thread( SpawnHealDropsThread, args )
end

function SpawnHealDropsThread( args )
	local delay = RandomFloat( args.DelayMin, args.DelayMax )
	wait( delay, RoomThreadName )
	if not IsCombatEncounterActive( CurrentRun ) then
		return
	end

	local spawnPoints = FYShuffle(GetIdsByType({ Name = "EnemyPoint" }))
	local numDrops = RandomInt( args.MinDrops, args.MaxDrops )
	local minX = args.OffsetXMin or -100
	local maxX = args.OffsetXMax or 100
	local minY = args.OffsetYMin or -100
	local maxY = args.OffsetYMax or 100

	while numDrops > 0 do
		if spawnPoints[numDrops] then
			local consumableName = args.ConsumableName
			local offsetX = RandomFloat( minX, maxX )
			local offsetY = RandomFloat( minY, maxY )
			local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = spawnPoints[numDrops], Group = "Standing", OffsetX = offsetX, OffsetY = offsetY, OffsetZ = 2000 })
			local consumable = CreateConsumableItem( consumableId, consumableName, 0 )
		
			wait( RandomFloat(args.InProgressDelayMin, args.InProgressDelayMax), RoomThreadName )
		end
		numDrops = numDrops - 1
	end
end

function CinderMeteorWarning( unit, args )
	if RandomChance(args.Chance) then
		thread( CinderMeteorRoomThread, args )
	end
end

function CinderMeteorRoomThread( args )
	local delay = RandomFloat( args.DelayMin, args.DelayMax )
	wait( delay, RoomThreadName )
	if not IsCombatEncounterActive( CurrentRun ) then
		return
	end
	local numMeteors = RandomInt( args.MinQuantity, args.MaxQuantity )
	local spawnPoints = GetIdsByType({ Name = "EnemyPoint" })
	while numMeteors > 0 do
		table.insert( spawnPoints, CurrentRun.Hero.ObjectId )
		local randomTarget = GetRandomValue( spawnPoints )
	
		local tempObstacleId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = randomTarget })

		local damageRadius = 300
		CreateAnimation({ Name = "BiomeStateMeteorWarningDecal", DestinationId = tempObstacleId, ScaleRadius = damageRadius })
		wait( args.Fuse )
		CreateProjectileFromUnit({ Name = "CinderMeteorProjectile", Id = CurrentRun.Hero.ObjectId, DestinationId = tempObstacleId, FireFromTarget = true })

		local consumableName = args.ConsumableName
		local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = tempObstacleId, Group = "Standing", })
		local consumable = CreateConsumableItem( consumableId, consumableName, 0 )

		Destroy({ Id = tempObstacleId})
		numMeteors = numMeteors - 1
		wait( RandomFloat(args.InProgressDelayMin, args.InProgressDelayMax), RoomThreadName )
	end
end

function GoldStateRewardChange( unit, args )
	if IsGameStateEligible( CurrentRun, args.GameStateRequirements ) then
		CurrentRun.CurrentRoom.ChangeReward = args.RewardName
	end
end