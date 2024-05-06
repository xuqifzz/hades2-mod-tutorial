function UseGhostInspectPoint( ghostInspectPoint, user )
	UseableOff({ Id = ghostInspectPoint.ObjectId })
	GhostInspectPointPresentation( ghostInspectPoint, user )
end

OnCollisionEnd{
	function( triggerArgs )
		local collidee = triggerArgs.CollideeTable
		if collidee ~= nil and collidee.EmoteReactionOnCollide then
			if RandomChance( 0.1 ) and ( CurrentHubRoom ~= nil and CurrentHubRoom.GhostCollisionEmote ~= nil ) then
				PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CandleBlow", Id = triggerArgs.triggeredById })
				PlayEmote( { TargetId = collidee.ObjectId, EmoteName = CurrentHubRoom.GhostCollisionEmote, Shake = false } )
			end
		end
	end
}

function GhostRecruitsPreRun( source, args )
	local numSpawns = 0
	for name, count in pairs( CurrentRun.ExorcisedNames ) do
		for i = 1, count do
			numSpawns = numSpawns + 1
			local spawnType = "GhostRecruit"
			local spawnPointId = args.SpawnPointIds[numSpawns]
			local spawnId = SpawnObstacle({ Name = spawnType, Group = args.GroupName or "Standing", DestinationId = spawnPointId })
			local spawn = DeepCopyTable( ObstacleData[spawnType] )
			spawn.ObjectId = spawnId
			spawn.Animation = spawn.RecruitedAnimation or name
			SetupObstacle( spawn )
			AngleTowardTarget({ Id = spawn.ObjectId, DestinationId = args.TargetId, Duration = 0.1 })
		end
	end
end

function GhostRecruitsMain( source, args )
	local numSpawns = 0
	for name, count in pairs( GameState.ExorcisedNames ) do
		for i = 1, count do
			if RandomChance( args.SpawnChance ) then
				local spawnType = "GhostRecruit"
				local spawnPointId = RemoveRandomValue( args.SpawnPointIds )
				if spawnPointId == nil then
					return
				end
				local spawnId = SpawnObstacle({ Name = spawnType, Group = args.GroupName or "Standing", DestinationId = spawnPointId })
				local spawn = DeepCopyTable( ObstacleData[spawnType] )
				spawn.ObjectId = spawnId
				spawn.Animation = spawn.RecruitedAnimation or name
				SetupObstacle( spawn )
				SetAngle({ Id = spawn.ObjectId, Angle = RandomFloat( 0, 360 ), Duration = 0.1 })
				numSpawns = numSpawns + 1
				if numSpawns >= args.MaxSpawns then
					return
				end
			end
		end
	end
end

function DisplayGhostQuote( ghost )	

	local fadeInDuration = 0.5
	local fadeOutDuration = 0.5
	local holdDuration = 2.0

	local ghostDataName = GetRandomKey( GhostData )
	local ghostData = GhostData[ghostDataName]

	local speechbubble = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay", DestinationId = ghost.ObjectId, OffsetY = -150 })
	SetAnimation({ Name = "GhostDialogue", DestinationId = speechbubble, Scale = 0.55 })
	CreateTextBox({ Id = speechbubble,
		Text = ghostDataName,
		UseDescription = true,
		FontSize = 21,
		Width = 356,
		OffsetX = -204,
		OffsetY = -12,
		Justification = "Left",
		Font = "LatoSemiboldItalic",
		Color = White,
		OutlineColor = {0.113, 0.113, 0.113, 1},
		OutlineThickness = 2,
		LineSpacingBottom = 2,
		})

	Move({ Id = speechbubble, Angle = 90, Distance = 30, Duration = fadeInDuration, SmoothStep = true })
	wait( fadeInDuration, RoomThreadName )

	wait( holdDuration, RoomThreadName )

	
	if ghostData.Reactions ~= nil then
		for i, reaction in pairs( ghostData.Reactions ) do
			thread( PlayEmote, { TargetId = ghost.ObjectId, AnimationName = reaction } )
		end
	end

	SetAlpha({ Id = speechbubble, Fraction = 0.0, Duration = fadeOutDuration })
	Move({ Id = speechbubble, Angle = 90, Distance = 30, Duration = fadeOutDuration, EaseOut = 1 })
	ModifyTextBox({ Id = speechbubble, FadeTarget = 0, FadeDuration = fadeOutDuration })
	wait( fadeOutDuration, RoomThreadName )
	Destroy({ Id = speechbubble })
end

function PatrolPath( source, args )

	local numPatrols = 0
	while args.MaxPatrols == nil or numPatrols < args.MaxPatrols do

		wait( args.SendPatrolInterval, RoomThreadName )
	
		local spawnType = GetRandomValue( args.SpawnTypes )

		local pathCopy = ShallowCopyTable( args.Path )
		local startingPathNode = nil
		while ( startingPathNode == nil or startingPathNode.Id == nil ) and not IsEmpty( pathCopy ) do
			startingPathNode = RemoveRandomValue( pathCopy )
		end
		local spawnOffset = CalcOffset( math.rad( RandomFloat( 0, 360 ) ), startingPathNode.OffsetRadius or 10 )
		local spawnId = SpawnObstacle({ Name = spawnType, Group = args.GroupName or "Standing", DestinationId = startingPathNode.Id, OffsetX = spawnOffset.X, OffsetY = spawnOffset.Y })
		local spawn = DeepCopyTable( ObstacleData[spawnType] )
		spawn.ObjectId = spawnId
		SetupObstacle( spawn )
		if args.Scale ~= nil or args.ScaleMin ~= nil then
			spawn.Scale = args.Scale or RandomFloat( args.ScaleMin, args.ScaleMax )
			SetScale({ Fraction = spawn.Scale, Id = spawn.ObjectId })
		end
		SetAngle({ Id = spawn.ObjectId, Angle = RandomFloat( 0, 360 ), Duration = 0.1 })

		spawn.Speed = RandomFloat( args.SpeedMin, args.SpeedMax )
		thread( FollowPath, spawn, args.Path, { Loop = true, StartNodeId = startingPathNode.Id } )
		numPatrols = numPatrols + 1
	end

end

function FollowPath( mover, path, args )

	if mover == nil then
		return
	end

	args = args or {}

	mover.AIThreadName = "MoverAIThread"..mover.ObjectId

	for index, node in ipairs( path ) do

		--DebugPrint({ Text = "Checking node.Id = "..tostring(node.Id) })
		if args.StartNodeId ~= nil and node.Id ~= args.StartNodeId then
			-- Continue
		elseif node.MinUseInterval == nil or node.LastUsedTime == nil or _worldTime > node.LastUsedTime + node.MinUseInterval then

			node.LastUsedTime = _worldTime
			args.StartNodeId = nil

			if node.Id ~= nil then

				local startDelay = node.StartDelay
				wait( startDelay, mover.AIThreadName )

				if not IsAlive({ Id = mover.ObjectId }) then
					return
				end

				mover.LastVisitedPathId = node.Id

				local offset = {}
				if node.OffsetRadius ~= nil then
					offset = CalcOffset( RandomFloat( 0.0, math.pi * 2 ), RandomFloat( 0.0, node.OffsetRadius ) )
				end
				local speed = args.Speed or mover.Speed
				if node.SpeedMin ~= nil and node.SpeedMax ~= nil then
					speed = RandomFloat( node.SpeedMin, node.SpeedMax )
				end

				if node.MinDistanceForMove == nil or GetDistance({ Id = mover.ObjectId, DestinationId = node.Id }) > node.MinDistanceForMove then
					AngleTowardTarget({ Id = mover.ObjectId, DestinationId = node.Id, Duration = node.StartAngleDuration or 0.3, SmoothStep = true })			
					if mover.PreMoveAnimation ~= nil then
						SetAnimation({ Name = mover.PreMoveAnimation, DestinationId = mover.ObjectId })
						wait( mover.PreMoveDelay or 0.3 )
					end
					Move({ Id = mover.ObjectId, DestinationId = node.Id, OffsetX = offset.X, OffsetY = offset.Y, Speed = speed, EaseIn = node.EaseIn or 0.01, EaseOut = node.EaseOut or 1.0, SuccessDistance = node.SuccessDistance })
				end
				--DebugPrint({ Text = "Move to node.Id = "..node.Id.." (Distance = "..GetDistance({ Id = mover.ObjectId, DestinationId = node.Id })..")" })

				mover.AINotifyName = "OnStopped"..mover.ObjectId
				wait( 0.1, mover.AIThreadName )

				NotifyOnStopped({ Id = mover.ObjectId, Notify = mover.AINotifyName, Timeout = args.Timeout })
				waitUntil( mover.AINotifyName )

				if node.AngleTowardIdOnStop then
					AngleTowardTarget({ Id = mover.ObjectId, DestinationId = node.AngleTowardIdOnStop, Duration = node.StopAngleDuration or 0.3, SmoothStep = true })
					wait( 0.3, mover.AIThreadName )
				end

				if node.ArriveFunctionName ~= nil then
					CallFunctionName( node.ArriveFunctionName, mover, node.ArriveFunctionArgs, node )
				end

				if node.AngleTowardNodeOnStop then
					AngleTowardTarget({ Id = mover.ObjectId, DestinationId = node.Id, Duration = node.StopAngleDuration or 0.3, SmoothStep = true })
					wait( 0.3, mover.AIThreadName )
				end

				wait( node.PostArriveWait or 0.1, mover.AIThreadName )

				if node.EmoteOnEnd ~= nil then
					if node.EmoteOnEndChance ~= nil then
						if RandomChance( node.EmoteOnEndChance ) then
							PlayEmote( { Target = mover, EmoteName = node.EmoteOnEnd, PlaySound = node.PlaySound } )
						end
					else
						PlayEmote( { Target = mover, EmoteName = node.EmoteOnEnd, PlaySound = node.PlaySound } )
					end
				end

			end

			if node.Branch ~= nil then
				local eligibleBranchPaths = {}
				for i, branchPath in ipairs( node.Branch ) do
					if branchPath.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, mover, branchPath.GameStateRequirements ) then
						table.insert( eligibleBranchPaths, branchPath )
					end
				end
				local randomBranchPath = GetRandomValue( eligibleBranchPaths )
				--DebugPrint({ Text = "randomBranchPath = "..tostring(randomBranchPath.Id) })
				FollowPath( mover, randomBranchPath )
			end

		end

	end

	if args.Loop and IsAlive({ Id = mover.ObjectId }) then
		return FollowPath( mover, path, args )
	end

end

function ActivityInterrupt( source, args )
	killTaggedThreads( source.AIThreadName )
	killWaitUntilThreads( source.AINotifyName )
	Stop({ Id = source.ObjectId })
	if source.TurnInPlaceAnimation ~= nil then
		AngleNPCToHero( source )
	else
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end
end