function UseFishingPoint( fishingPoint, args, user )
	
	if not HasAccessToTool( "ToolFishingRod" ) then
		HarvestNoToolPresentation( fishingPoint, args, user, "ToolFishingRod" )
		return
	end

	CurrentRun.CurrentRoom.FishingPointUsed = true
	CurrentRun.Hero.UntargetableFlags.Fishing = true
	SetPlayerInvulnerable( "Fishing" )
	AddPlayerImmuneToForce( "Fishing" )

	if CheckCooldown( "UsedFishingPoint", 0.75, true ) then
		local canFishInEncounter = true
		if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BlockFishingBeforeStart and not CurrentRun.CurrentRoom.Encounter.Completed then
			canFishInEncounter = false
		end
		if not CurrentRun.CurrentRoom.ExitsUnlocked or not canFishInEncounter or not IsEmpty( RequiredKillEnemies ) or IsAggoredUnitBlockingHarvest() then
			FishingBlockedByEncounterPresentation( fishingPoint, args, user )
		elseif CurrentRun.Hero.OnLava then
			FishingBlockedByLavaPresentation( fishingPoint, args, user )
		elseif HasFamiliarTool( "ToolFishingRod" ) then
			FamiliarFishingPresentation( fishingPoint )
			CurrentRun.Hero.FishingState = "Success"
			UseableOff({ Id = fishingPoint.ObjectId })
			SetAlpha({ Id = fishingPoint.ObjectId, Fraction = 0.0, Duration = 0.25 })
			BlockVfx({ DestinationId = fishingPoint.ObjectId })
			local caughtFishName = GetCaughtFishName( GetCurrentFishingBiomeName() )
			DebugPrint({ Text = "caughtFishName = "..tostring(caughtFishName) })
			local caughtFishData = FishingData.FishValues[caughtFishName]
			FishingEndPresentation( caughtFishData, fishingPoint.ObjectId, { Success = true, UsedFamiliar = true, } )
			GameState.FamiliarUses = GameState.FamiliarUses - 1
			UpdateFamiliarIconUses()
		else
			CurrentRun.Hero.FishingStarted = true
			FreezePlayerUnit( "FishingStartUp", { DisableTray = true, DisableCodex = true } )
			AddTimerBlock( CurrentRun, "Fishing" )
			wait( 0.25, "FishingStartDelay" )
			UnfreezePlayerUnit("FishingStartUp")
			if CurrentRun.Hero.FishingStarted and not CurrentRun.Hero.OnLava then
				UseableOff({ Id = fishingPoint.ObjectId })
				SetAlpha({ Id = fishingPoint.ObjectId, Fraction = 0.0, Duration = 0.25 })
				BlockVfx({ DestinationId = fishingPoint.ObjectId })
				FishingSequence( nil, { FishingPointId = fishingPoint.ObjectId } )
			else
				RemoveTimerBlock( CurrentRun, "Fishing" )
			end
 		end
 	end
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
	local caughtFishData = FishingData.FishValues[caughtFishName]

	if caughtFishData ~= nil and caughtFishData.ReelTime ~= nil then
		args.FishingReelPointId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = args.FishingAnimationPointId, Group = GetGroupName({ Id = args.FishingAnimationPointId, DrawGroup = true }) })
		FishingReelSequenceStartPresentation( source, args, caughtFishData )
		FishingReelSequence( source, args, caughtFishData )
	else
		FishingEndPresentation( caughtFishData, args.FishingAnimationPointId, { Success = true } )
	end
end

function GetCurrentFishingBiomeName()
	if CurrentHubRoom ~= nil then
		return CurrentHubRoom.FishBiome or "None"
	else
		return CurrentRun.CurrentRoom.FishBiome or CurrentRun.CurrentRoom.RoomSetName or "None"
	end
end

function FishingReelSequence( source, args, fishData )

	local timeRemaining = fishData.ReelTime
	args.ReelEndTime = _worldTime + fishData.ReelTime
	args.HitsRemaining = fishData.CatchZoneHits
	local nextDirectionChangeTime = _worldTime + RandomFloat( fishData.DirectionChangeTimeMin, fishData.DirectionChangeTimeMax )
	local randomSpeed = RandomFloat( fishData.MoveSpeedMin, fishData.MoveSpeedMax )
	local moveAngle = RandomFloat( 0, 360 )
	args.ReturnToCatchZoneChance = fishData.ReturnToCatchZoneChance
	Move({ Id = args.FishingAnimationPointId, Angle = moveAngle, Speed = 90 }) -- first move needs to be fast
	wait( 0.3 ) -- give time for bobble thing to leave the catch zoon
	thread( CheckFishingReelInput, source, args, fishData )
	local tickInterval = 0.02
	wait( tickInterval )
	while _worldTime < args.ReelEndTime and args.HitsRemaining > 0 do
		if _worldTime > nextDirectionChangeTime then
			nextDirectionChangeTime = _worldTime + RandomFloat( fishData.DirectionChangeTimeMin, fishData.DirectionChangeTimeMax )
			randomSpeed = RandomFloat( fishData.MoveSpeedMin, fishData.MoveSpeedMax )
			local tetherDistance = GetDistance({ Id = args.FishingReelPointId, DestinationId = args.FishingAnimationPointId })
			--DebugPrint({ Text = "tetherDistance = "..tetherDistance })
			--DebugPrint({ Text = "ReturnToCatchZoneChance = "..args.ReturnToCatchZoneChance })
			if tetherDistance > fishData.MoveRadius or RandomChance( args.ReturnToCatchZoneChance ) then
				local angleToCenter = GetAngleBetween({ Id = args.FishingAnimationPointId, DestinationId = args.FishingReelPointId })
				--DebugPrint({ Text = "angleToCenter = "..angleToCenter })
				moveAngle = angleToCenter + RandomFloat( -fishData.ReturnToCatchZoneVariance, fishData.ReturnToCatchZoneVariance )
			else
				moveAngle = RandomFloat( 0, 360 )
			end
			args.ReturnToCatchZoneChance = args.ReturnToCatchZoneChance + fishData.ReturnToCatchZoneChanceIncrement
			Move({ Id = args.FishingAnimationPointId, Angle = moveAngle, Speed = randomSpeed })
		end
		wait( tickInterval )
	end
	killWaitUntilThreads( "FishingReelSequenceInput" )
	StopAnimation({ Name = "FishCatchZone", DestinationId = args.FishingReelPointId })
	if args.HitsRemaining <= 0 then
		args.Success = true
	end
	FishingEndPresentation( fishData, args.FishingAnimationPointId, args )
end

function CheckFishingReelInput( source, args, fishData )
	ToggleCombatControl( { "Use" }, true, "Fishing" )
	FishingReadyForReelInputPresentation( source, args, fishData )
	while _worldTime < args.ReelEndTime and args.HitsRemaining > 0 do
		NotifyOnControlPressed({ Names = { "Use", }, Notify = "FishingReelSequenceInput" })
		waitUntil( "FishingReelSequenceInput" )
		local tetherDistance = GetDistance({ Id = args.FishingReelPointId, DestinationId = args.FishingAnimationPointId })
		local timeRemaining = args.ReelEndTime - _worldTime
		args.ReturnToCatchZoneChance = fishData.ReturnToCatchZoneChance
		if tetherDistance < fishData.CatchZoneRadius then
			args.HitsRemaining = args.HitsRemaining - 1
			DebugPrint({ Text = "ReelSequence Hit - HitsRemaining: "..args.HitsRemaining..", TimeRemaining: "..timeRemaining })
			FishingReelHitPresentation( source, args, fishData )
		else
			args.ReelEndTime = args.ReelEndTime - fishData.ReelMissTimePenalty
			DebugPrint({ Text = "ReelSequence Miss - HitsRemaining: "..args.HitsRemaining..", TimeRemaining: "..timeRemaining })
			FishingReelMissPresentation( source, args, fishData )
		end
		wait( fishData.ReelCooldown )
	end
end

function StartFishing( source, args )
	args = args or {}
	InvalidateCheckpoint()
	FreezePlayerUnit( "Fishing", { DisableTray = true, DisableCodex = true } )
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
	PlaySound({ Name = roomData.FishingDunkSound or "/Leftovers/SFX/BigFishSplash", DestinationId = args.FishingAnimationPointId })
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
	thread( FishingWayLatePresentation )
	wait( difficultyData.GiveUpInterval, "Fishing" )

	notify("FishingInput")
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
			if fishData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, fishData, fishData.GameStateRequirements ) then
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
	killWaitUntilThreads( "FishingReelSequenceInput" )
	if HasThread("FishingStartDelay") then
		killTaggedThreads( "FishingStartDelay")		
		UnfreezePlayerUnit("FishingStartUp")
	end
end