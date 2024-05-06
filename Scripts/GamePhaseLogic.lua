function GamePhaseTick( args )
	args = args or {}
	if not args.SkipGarden then
		GardenTimeTick( args )
		CookTimeTick( args )
		MailboxTimeTick( args )
		FamiliarTimeTick( args )
	end
	if not IsGameStateEligible( CurrentRun, GamePhaseData.AdvancementGameStateRequirements ) then
		return
	end
	local ticks = args.Ticks or 1
	GameState.GamePhaseLifetimeTicks = GameState.GamePhaseLifetimeTicks + ticks
	IncrementTableValue( GameState, "GamePhaseTicks", ticks )
	if GameState.GamePhaseTicks >= GameState.GamePhaseTargetTicks then
		local overflow = GameState.GamePhaseTicks - GameState.GamePhaseTargetTicks 
		GameState.GamePhaseTicks = overflow
		IncrementTableValue( GameState, "GamePhase", 1 )
		GameState.GamePhaseTargetTicks = GetGamePhaseTargetTicks()
		if GameState.GamePhaseTicks >= GameState.GamePhaseTargetTicks then
			GameState.GamePhaseTicks = GameState.GamePhaseTargetTicks - 1
		end
		if GameState.GamePhase > GamePhaseData.MaxGamePhase then
			GameState.GamePhase = 1
		end
	end
end

function GetDeathGamePhaseTicks()
	return RandomInt( GamePhaseData.OnDeathTicksMin, GamePhaseData.OnDeathTicksMax )
end

function GetGamePhaseTargetTicks()
	if GamePhaseData.GamePhases[ GameState.GamePhase ] 
		and GamePhaseData.GamePhases[ GameState.GamePhase ].MinTicks 
		and GamePhaseData.GamePhases[ GameState.GamePhase ].MaxTicks then
		return RandomInt( GamePhaseData.GamePhases[ GameState.GamePhase ].MinTicks, GamePhaseData.GamePhases[ GameState.GamePhase ].MaxTicks)
	end
	return RandomInt( GamePhaseData.GamePhaseDefaultMinTicks, GamePhaseData.GamePhaseDefaultMaxTicks )
end