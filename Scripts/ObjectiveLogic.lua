function CheckAutoObjectiveSets( currentRun, checkTrigger )
	local setToShow = nil
	for objectiveSetName, objectiveSetInfo in pairs( ObjectiveSetData ) do
		local showSet = true
		if showSet and objectiveSetInfo.ManualActivationOnly then
			showSet = false
		end
		if showSet and not IsObjectiveSetEligible( objectiveSetName, objectiveSetInfo, checkTrigger ) then
			showSet = false
		end
		if showSet and not IsGameStateEligible( currentRun, objectiveSetInfo, objectiveSetInfo.GameStateRequirements ) then
			showSet = false
		end

		if showSet then
			setToShow = objectiveSetName
		end
	end

	if setToShow ~= nil then
		thread( ShowObjectiveSet, setToShow )
	end
end

function CheckObjectiveSetSource( source, args )
	CheckObjectiveSet( args.ObjectiveSetName, nil, args.Delay )
end

function CheckObjectiveSet( objectiveSetName, checkTrigger, extraDelay )
	local objectiveSetInfo = ObjectiveSetData[objectiveSetName]
	if objectiveSetInfo == nil then
		--DebugPrint({ Text = "Objective Name: "..objectiveSetName.."does not exist!" })
		return false
	end

	if GameState.ActiveObjectiveSet ~= nil and not objectiveSetInfo.OverrideExistingObjective then
		return false
	end

	if not IsObjectiveSetEligible( objectiveSetName, objectiveSetInfo, checkTrigger ) then
		return false
	end

	if not IsGameStateEligible( CurrentRun, objectiveSetInfo, objectiveSetInfo.GameStateRequirements ) then
		return false
	end

	thread( ShowObjectiveSet, objectiveSetName, extraDelay )
	return true
end

function IsObjectiveSetEligible( objectiveSetName, objectiveSetInfo, checkTrigger )
	if GameState.CompletedObjectiveSets[objectiveSetName] and not objectiveSetInfo.AllowRepeat then
		return false
	end
	if objectiveSetInfo.RequiredFalseObjectiveTriggers and Contains( objectiveSetInfo.RequiredFalseObjectiveTriggers, checkTrigger ) then
		return false
	end
	return true
end

function ShowObjectiveSet( objectiveSetName, extraDelay )
	if GameState.ActiveObjectiveSet == objectiveSetName then
		return
	end

	ClearObjectives()

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	local objectiveSetData = ObjectiveSetData[objectiveSetName]
	if objectiveSetData == nil then
		return
	end

	if extraDelay ~= nil then
		objectiveSetData.StartDelay = objectiveSetData.StartDelay or 0
		objectiveSetData.StartDelay = objectiveSetData.StartDelay + extraDelay
	end
	if objectiveSetData.StartDelay ~= nil and objectiveSetData.ObjectiveIndex == nil then
		objectiveSetData.IsDelaying = true
		wait( objectiveSetData.StartDelay, RoomThreadName )
		objectiveSetData.IsDelaying = false
		if not IsObjectiveSetEligible(objectiveSetName, objectiveSetData) or not IsGameStateEligible(CurrentRun, objectiveSetData, objectiveSetData.GameStateRequirements) then
			return
		end
	end

	if objectiveSetData.ObjectiveIndex == nil then
		objectiveSetData.ObjectiveIndex = 1
	end

	DebugPrint({ Text = "Serving Objective Set: "..objectiveSetData.Name.." Step "..objectiveSetData.ObjectiveIndex })

	GameState.ActiveObjectiveSet = objectiveSetName
	for k, objectiveName in pairs( objectiveSetData.Objectives[objectiveSetData.ObjectiveIndex] ) do
		AddActiveObjective( objectiveName )
	end
	CreateObjectiveUI()
end

function ClearObjectives()
	ScreenAnchors.Objectives = nil
	HideObjectivesUI()
	CurrentRun.ActiveObjectives = {}
end

function ResetObjectives()
	ClearObjectives()
	if GameState.ActiveObjectiveSet ~= nil and ObjectiveSetData[GameState.ActiveObjectiveSet] ~= nil then
		ObjectiveSetData[GameState.ActiveObjectiveSet].ObjectiveIndex = 1
	end
	GameState.ActiveObjectiveSet = nil
end

function AddActiveObjective( objectiveName, objectiveSetName )
	local activeObjective = ShallowCopyTable( ObjectiveData[objectiveName] )

	activeObjective.Status = "Active"
	CurrentRun.ActiveObjectives[objectiveName] = activeObjective
end

function ShowObjective( objectiveData, objectId )
	local stringColor = Color.White
	if objectiveData.Status == "Complete" then
		stringColor = Color.DarkGray
	end

	local objectiveDistance = 480
	Teleport({ Id = objectId, UseCurrentLocation = true, DestinationIsScreenRelative = true, OffsetX = objectiveDistance })
	PlaySound({ Name = "/SFX/Menu Sounds/ObjectiveActivateShk", Id = objectId })
	SetAlpha({ Id = objectId, Fraction = 0, Duration = 0.0 })
	CreateTextBox({ Id = objectId, Text = objectiveData.Description, OffsetX = 20, Color = Color.Yellow,
					Font = "LatoBold", FontSize = 45, ShadowRed = 0, ShadowBlue = 0, ShadowGreen = 0,
					ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 3, ShadowOffsetX = 0, 
					OutlineColor = {0, 0, 0, 1}, OutlineThickness = 0,
					LuaKey = objectiveData.LuaKey, LuaValue = objectiveData.StartingLuaValue,
					TextSymbolScale = 0.80,
					Justification = "Left"})
	
	local scaleTarget = 0.45
	ModifyTextBox({ Id = objectId, ScaleTarget = objectiveData.StartingScaleTarget or scaleTarget, ScaleDuration = 0.2, ColorTarget = stringColor, ColorDuration = 0.5 })
	if IsEmpty( MapState.CombatUIHide ) then
		SetAlpha({ Id = objectId, Fraction = 1.0, Duration = 0.05 })
	end
	local postDisplayWait = objectiveData.PostDisplayWait or 1.2
	wait( postDisplayWait )
	ModifyTextBox({ Id = objectId, ScaleTarget = scaleTarget, ScaleDuration = 0.4, ColorTarget = stringColor, ColorDuration = 0.5 })
	PlaySound({ Name = "/SFX/Menu Sounds/ObjectiveActivateShk2", Id = objectId, Delay = 0.25 })
	Move({ Id = objectId, Distance = objectiveDistance, Angle = 180, Duration = 0.75, EaseIn = 0.0, EaseOut = 1.0 })

end

function UpdateObjective( objectiveName, luaKey, luaValue, args )

	local activeObjective = CurrentRun.ActiveObjectives[objectiveName]
	if activeObjective == nil then
		return
	end

	args = args or {}

	ModifyTextBox({ Id = activeObjective.ObjectId, LuaKey = luaKey, LuaValue = luaValue, })
	if args.Pulse then
		ModifyTextBox({ Id = activeObjective.ObjectId, ColorTarget = {1, 0.8, 0, 1}, ColorDuration = 0.2 })
		ModifyTextBox({ Id = activeObjective.ObjectId, ColorTarget = {1, 1, 1, 1}, ColorDuration = 0.5, Delay = 0.2 })
		if args.PulseSound then
			PlaySound({ Name = args.PulseSound })
		end
		thread(PulseText, {Id = activeObjective.ObjectId, ScaleOriginal = 0.4, ScaleTarget = 0.55, ScaleDuration = 0.5, HoldDuration = 0.0})
	end
	if args.PulseNegative then
		ModifyTextBox({ Id = activeObjective.ObjectId, ColorTarget = {1, 0.2, 0, 1}, ColorDuration = 0.2 })
		ModifyTextBox({ Id = activeObjective.ObjectId, ColorTarget = {1, 1, 1, 1}, ColorDuration = 0.5, Delay = 0.2 })
		PlaySound({ Name = args.PulseSound })
		thread(PulseText, {Id = activeObjective.ObjectId, ScaleOriginal = 0.4, ScaleTarget = 0.55, ScaleDuration = 0.5, HoldDuration = 0.0})
	end

end

function UpdateObjectiveDescription( objectiveName, newDescription, luaKey, luaValue )

	local activeObjective = CurrentRun.ActiveObjectives[objectiveName]
	if activeObjective == nil then
		return
	end

	ModifyTextBox({ Id = activeObjective.ObjectId, Text = newDescription, LuaKey = luaKey, LuaValue = luaValue, })

end

function CreateObjectiveUI()
	local room = CurrentHubRoom or CurrentRun.CurrentRoom
	if room == nil then
		return
	end
	if ScreenAnchors.Objectives == nil then
		ScreenAnchors.Objectives = {}
	end

	local startOffsetY = room.ObjectiveStartY or HUDScreen.ObjectiveStartY
	local k = 1
	local objectiveSet = ObjectiveSetData[GameState.ActiveObjectiveSet]
	for k, objectiveName in ipairs( objectiveSet.Objectives[objectiveSet.ObjectiveIndex] ) do
		local activeObjective = CurrentRun.ActiveObjectives[objectiveName]
		if ScreenAnchors.Objectives == nil or CurrentRun.ActiveObjectives[objectiveName] == nil then
			-- Requested hidden mid-loop
			break
		end
		if activeObjective.Status ~= nil and activeObjective.Status ~= "Complete" then
			startOffsetY = startOffsetY + HUDScreen.ObjectiveSpacingY
			ScreenAnchors.Objectives[k] = CreateScreenObstacle({ Name = "BlankObstacle", Group = "HUD_Main", X = (CurrentHubRoom or CurrentRun.CurrentRoom).ObjectiveStartX or HUDScreen.ObjectiveStartX, Y = startOffsetY })
			activeObjective.ObjectId = ScreenAnchors.Objectives[k]

			if activeObjective.Status == "Active" then
				SetAnimation({ DestinationId = ScreenAnchors.Objectives[k], Name = "ObjectiveBackground" })
				CreateAnimation({ DestinationId = ScreenAnchors.Objectives[k], Name = "NewObjectiveFlare" })
			else
				SetAnimation({ DestinationId = ScreenAnchors.Objectives[k], Name = "ObjectiveBackground_Fulfilled" })
			end
			thread( ShowObjective, activeObjective, ScreenAnchors.Objectives[k] )
			wait( 0.1, RoomThreadName )
			k = k + 1
		end
	end
end

function MarkObjectivesComplete( objectiveNames )
	if objectiveNames == nil then
		return
	end

	for i, objectiveName in pairs( objectiveNames ) do
		MarkObjectiveComplete( objectiveName )
	end
end

function MarkObjectiveComplete( objectiveName )
	local objectiveData = CurrentRun.ActiveObjectives[objectiveName]
	if objectiveData == nil then
		return
	end
	GameState.ObjectivesCompleted[objectiveName] = (GameState.ObjectivesCompleted[objectiveName] or 0) + 1
	CurrentRun.ObjectivesCompleted[objectiveName] = (CurrentRun.ObjectivesCompleted[objectiveName] or 0) + 1

	if objectiveData.Status == "Active" then
		--DebugPrint({ Text = "Let's complete "..objectiveData.Name })
		objectiveData.Status = "Complete"
		SetAnimation({ DestinationId = objectiveData.ObjectId, Name = "ObjectiveBackground_Fulfilled" })
		PlaySound({ Name = "/SFX/Menu Sounds/ObjectiveCompletedSparkles", Id = objectiveData.ObjectId })
		ModifyTextBox({ Id = objectiveData.ObjectId, ScaleTarget = 0.65, ScaleDuration = 0.15, ColorTarget = Color.Gold, ColorDuration = 0.15 })
		wait( 0.5, RoomThreadName )
		ModifyTextBox({ Id = objectiveData.ObjectId, ScaleTarget = 0.45, ScaleDuration = 1.25, ColorTarget = {100, 100, 100, 255}, ColorDuration = 1.25 })
	end
	wait( 0.52, RoomThreadName )
	CheckActiveObjectivesStatus()
end

function MarkObjectiveFailed( objectiveName, endSet )
	local objectiveData = CurrentRun.ActiveObjectives[objectiveName]
	if objectiveData == nil then
		return
	end
	GameState.ObjectivesFailed[objectiveName] = (GameState.ObjectivesFailed[objectiveName] or 0) + 1
	GameState.LastObjectiveFailedRun[objectiveName] = GetCompletedRuns() + 1

	if objectiveData.Status == "Active" then
		--DebugPrint({ Text = "Let's complete "..objectiveData.Name })
		objectiveData.Status = "Complete"
		SetAnimation({ DestinationId = objectiveData.ObjectId, Name = "RadioButton_Failed" })
		PlaySound({ Name = "/SFX/Menu Sounds/HadesLocationTextAppear", Id = objectiveData.ObjectId })
		ModifyTextBox({ Id = objectiveData.ObjectId, ScaleTarget = 0.65, ScaleDuration = 0.15, ColorTarget = Color.Red, ColorDuration = 0.15 })
		wait( 0.5, RoomThreadName )
		ModifyTextBox({ Id = objectiveData.ObjectId, ScaleTarget = 0.45, ScaleDuration = 1.25, ColorTarget = Color.Red, ColorDuration = 1.25 })
	end
	wait( 0.52, RoomThreadName )
	if ObjectiveSetData[GameState.ActiveObjectiveSet] == nil or ObjectiveSetData[GameState.ActiveObjectiveSet].HoldUntilEncounterOver then
		return
	end

	if endSet then
		ResetObjectives()
	else
		CheckActiveObjectivesStatus()
	end
end

function CheckActiveObjectivesStatus()
	local currentCompletedObjectives = 0
	local totalActiveObjectives = TableLength( CurrentRun.ActiveObjectives )
	for objectId, objectiveData in pairs( CurrentRun.ActiveObjectives ) do
		if objectiveData.Status == "Complete" then
			currentCompletedObjectives = currentCompletedObjectives + 1
		end
	end

	if currentCompletedObjectives == totalActiveObjectives then
		local objectiveSetName = GameState.ActiveObjectiveSet
		local objectiveSetData = ObjectiveSetData[objectiveSetName]
		if objectiveSetData == nil then
			ClearObjectives()
			return
		end
		if objectiveSetData.IsDelaying then
			return
		end
		ClearObjectives()
		if objectiveSetData.ObjectiveIndex == nil then
			objectiveSetData.ObjectiveIndex = 1
		end
		objectiveSetData.ObjectiveIndex = objectiveSetData.ObjectiveIndex + 1
		if objectiveSetData.ObjectiveIndex <= TableLength(objectiveSetData.Objectives) then
			ShowObjectiveSet(objectiveSetName)
		else
			GameState.CompletedObjectiveSets[objectiveSetName] = true
			if objectiveSetData.AllowRepeat then
				objectiveSetData.ObjectiveIndex = 1
			end
			ResetObjectives()
		end
	end
end

function HideObjectivesUI()
	for objectiveName, objectiveData in pairs( CurrentRun.ActiveObjectives ) do
		SetAlpha({ Id = objectiveData.ObjectId, Fraction = 0, Duration = 0.3 })
	end
end

function ShowObjectivesUI()
	for objectiveName, objectiveData in pairs( CurrentRun.ActiveObjectives ) do
		SetAlpha({ Id = objectiveData.ObjectId, Fraction = 1, Duration = 0.3 })
	end
end

function PulseObjectivePositive( objectiveName )
	local objectiveData = CurrentRun.ActiveObjectives[objectiveName]
	if objectiveData == nil then
		return
	end

	if objectiveData.Status == "Active" then
		PlaySound({ Name = "/SFX/Menu Sounds/ObjectiveCompletedSparkles", Id = objectiveData.ObjectId })
		ModifyTextBox({ Id = objectiveData.ObjectId, ScaleTarget = 0.65, ScaleDuration = 0.15, ColorTarget = Color.Gold, ColorDuration = 0.15 })
		wait( 0.5, RoomThreadName )
		ModifyTextBox({ Id = objectiveData.ObjectId, ScaleTarget = 0.45, ScaleDuration = 1.25, ColorTarget = {100, 100, 100, 255}, ColorDuration = 1.25 })
	end
end

function PulseObjectiveNegative( objectiveName )
	local objectiveData = CurrentRun.ActiveObjectives[objectiveName]
	if objectiveData == nil then
		return
	end

	if objectiveData.Status == "Active" then
		PlaySound({ Name = "/SFX/Menu Sounds/HadesLocationTextAppear", Id = objectiveData.ObjectId })
		ModifyTextBox({ Id = objectiveData.ObjectId, ScaleTarget = 0.65, ScaleDuration = 0.15, ColorTarget = Color.Red, ColorDuration = 0.15 })
		wait( 0.5, RoomThreadName )
		ModifyTextBox({ Id = objectiveData.ObjectId, ScaleTarget = 0.45, ScaleDuration = 1.25, ColorTarget = Color.Red, ColorDuration = 1.25 })
	end
end