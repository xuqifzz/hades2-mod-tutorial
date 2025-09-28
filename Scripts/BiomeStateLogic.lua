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
	if IsGameStateEligible( nil, BiomeStateData.ForceGameStateRequirements ) then
		forceState = true
	else		
		if not IsGameStateEligible( nil, BiomeStateData.GameStateRequirements ) then
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
		if not biomeStateData.Skip and IsGameStateEligible( biomeStateData, biomeStateData.GameStateRequirements ) then
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
		elseif IsGameStateEligible( nextBiomeStateData, BiomeStateData.DefaultBiomeStateRequirements) then
			nextBiomeStateData = BiomeStateData.BiomeStates[BiomeStateData.DefaultBiomeState]
		end
		GameState.NextBiomeStateName = nil
		if nextBiomeStateData ~= nil then
			IncrementTableValue( GameState.BiomeStateRecord, nextBiomeStateData.Name )
			thread( CallFunctionName, nextBiomeStateData.BiomeInitialPresentationFunctionName )			
			if nextBiomeStateData.TraitGameStateRequirements == nil or IsGameStateEligible( nextBiomeStateData, nextBiomeStateData.TraitGameStateRequirements ) then
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

function RemoveAllBiomeStateTraits()
	local condemnedTraits = {}
	for _, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.BiomeStateTrait then
			table.insert(condemnedTraits, traitData.Name )
		end
	end
	for _, condemnedTraitName in pairs( condemnedTraits ) do
		RemoveTrait( CurrentRun.Hero, condemnedTraitName )
		for _, biomeStateData in pairs( BiomeStateData.BiomeStates ) do
			if biomeStateData.TraitName == condemnedTraitName and biomeStateData.BiomeEndPresentationFunctionName then
				thread( CallFunctionName, biomeStateData.BiomeEndPresentationFunctionName )
			end
		end
	end
end

function EndAllBiomeStates()
	RemoveAllBiomeStateTraits()
	CurrentRun.BiomeStateName = nil
end