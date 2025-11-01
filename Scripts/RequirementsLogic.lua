Import "RequirementsData.lua"

function DebugTestAllRequirements( source, requirements, args )
	for i = 1, #requirements do
		local debugResult = IsGameStateEligible( source, requirements, { ExclusiveTestIndex = i } )
	end
end

function IsGameStateEligible( source, requirements, args )

	args = args or {}
	source = source or { Name = "Unknown" }

	--if verboseLogging and requirements == nil then
		--DebugAssert({ Condition = false, Text = "IsGameStateEligible called with no requirements on "..tostring(source.Name), Owner = "Gavin" })
	--end

	if IsEmpty( requirements ) then
		return true
	end

	if requirements.Skip then
		args.FirstFailedRequirement = "Skip"
		return false
	end

	if requirements.Force then
		return true
	end

	if SessionMapState ~= nil then
		SessionMapState.RequirementChecksThisFrame = SessionMapState.RequirementChecksThisFrame + 1
	end

	if requirements.ChanceToPlay ~= nil then
		if not RandomChance( requirements.ChanceToPlay ) then
			args.FirstFailedRequirement = "ChanceToPlay = "..requirements.ChanceToPlay
			return false
		end
	end

	if requirements.NamedRequirements ~= nil then
		for k, name in ipairs( requirements.NamedRequirements ) do
			--DebugAssert({ Condition = NamedRequirementsData[name] ~= nil, Text = name.." is not a named requirement.", Owner = "Greg", })
			if not IsGameStateEligible( source, NamedRequirementsData[name], args ) then
				return false
			end
		end
	end
	if requirements.NamedRequirementsFalse ~= nil then
		for k, name in ipairs( requirements.NamedRequirementsFalse ) do
			--DebugAssert({ Condition = NamedRequirementsData[name] ~= nil, Text = name.." is not a named requirement.", Owner = "Greg", })
			if IsGameStateEligible( source, NamedRequirementsData[name], args ) then
				return false
			end
		end
	end

	if requirements.OrRequirements ~= nil then
		local anyTrue = false
		for k, orRequirement in ipairs( requirements.OrRequirements ) do
			if IsGameStateEligible( source, orRequirement, args ) then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	-- Generic state value checks

	--[[
	if verboseLogging then
		for key, value in pairs( DebugData.LegalGenericRequirementKeys ) do
			if requirements[key] then
				DebugAssert({ Condition = false, Text = key.." used at top level of GameStateRequirements on "..tostring(source.Name), Owner = "Gavin" })
			end
		end
		for key, value in pairs( requirements ) do
			if not DebugData.LegalNonGenericRequirementKeys[key] and type(key) ~= "number" then
				DebugAssert({ Condition = false, Text = key.." used at top level of GameStateRequirements on "..tostring(source.Name), Owner = "Gavin" })
			end
		end
	end
	]]

	for requirementIndex, requirement in ipairs( requirements ) do

		--[[
		if verboseLogging then
			for key, value in pairs( requirement ) do
				if not DebugData.LegalGenericRequirementKeys[key] then
					DebugAssert({ Condition = false, Text = "Unrecognized key ("..key..") used in generic GameStateRequirements on "..tostring(source.Name or source.ObjectId), Owner = "Greg" })
				end
			end
		end
		]]

		local expectedKeys = 1
		local valueToCheck = _G
		if requirement.PathFromSource then
			valueToCheck = source
			expectedKeys = expectedKeys + 1
		elseif requirement.PathFromArgs then
			valueToCheck = args
			expectedKeys = expectedKeys + 1
		elseif requirement.HintId then
			expectedKeys = expectedKeys + 1
		end

		--[[
		if verboseLogging and args.ExclusiveTestIndex ~= nil and requirementIndex ~= args.ExclusiveTestIndex then
			-- Continue
		else
		]]
		if requirement.FunctionName ~= nil then
			if not CallFunctionName( requirement.FunctionName, source, requirement.FunctionArgs, args ) then
				args.FirstFailedRequirement = requirement.FunctionName
				return false
			end
		elseif requirement.PathFalse ~= nil then
			--[[
			if verboseLogging and TableLength( requirement ) > expectedKeys then
				DebugPrintTable( requirement, true )
				DebugAssert({ Condition = false, Text = "Using PathFalse with other keys on "..tostring(source.Name), Owner = "Greg", })
			end
			]]
			for j, subTable in ipairs( requirement.PathFalse ) do
				--[[
				if verboseLogging and type(valueToCheck) == "string" then
					DebugAssert({ Condition = false, Text = "Using string "..valueToCheck.." inside PathFalse on "..tostring(source.Name), Owner = "Gavin", })
				end
				]]
				valueToCheck = valueToCheck[subTable]
				if valueToCheck == nil then
					break
				end
			end
			if valueToCheck then
				if verboseLogging then
					local keyString = ""
					if requirement.PathFromSource then
						keyString = source.Name
					end
					local firstTable = true
					for i, subTable in ipairs( requirement.PathFalse ) do
						if firstTable and not requirement.PathFromSource then
							keyString = subTable
							firstTable = false
						else
							keyString = keyString.."."..subTable
						end
					end
					args.FirstFailedRequirement = keyString.." == false (Current: "..tostring(valueToCheck)..")"
				end
				args.FailedRequirementIndex = requirementIndex
				return false
			end
		elseif requirement.PathTrue ~= nil then
			--[[
			if verboseLogging and TableLength( requirement ) > expectedKeys then
				DebugPrintTable( requirement, true )
				DebugAssert({ Condition = false, Text = "Using PathTrue with other keys on "..tostring(source.Name), Owner = "Greg", })
			end
			]]
			for j, subTable in ipairs( requirement.PathTrue ) do
				--[[
				if verboseLogging and type(valueToCheck) == "string" then
					DebugAssert({ Condition = false, Text = "Using string "..valueToCheck.." inside PathTrue on "..tostring(source.Name), Owner = "Gavin", })
				end
				]]
				valueToCheck = valueToCheck[subTable]
				if (not valueToCheck) or valueToCheck == 0 then
					if verboseLogging then
						local keyString = ""
						if requirement.PathFromSource then
							keyString = source.Name
						end
						local firstTable = true
						for i, subTable in ipairs( requirement.PathTrue ) do
							if firstTable and not requirement.PathFromSource then
								keyString = subTable
								firstTable = false
							else
								keyString = keyString.."."..subTable
							end
						end
						args.FirstFailedRequirement = keyString.." == true (Current: "..tostring(valueToCheck)..")"
					end
					args.FailedRequirementIndex = requirementIndex
					return false
				end
			end
		elseif requirement.PathEmpty ~= nil then
			if verboseLogging and requirement.Comparison ~= nil then
				DebugAssert({ Condition = false, Text = "Using Comparison with a PathEmpty requirement on "..tostring(source.Name), Owner = "Greg", })
			end
			for j, subTable in ipairs( requirement.PathEmpty ) do
				if verboseLogging and type(valueToCheck) == "string" then
					DebugAssert({ Condition = false, Text = "Using string "..valueToCheck.." inside PathEmpty on "..tostring(source.Name), Owner = "Gavin", })
				end
				valueToCheck = valueToCheck[subTable]
				if valueToCheck == nil then
					break
				end
			end
			if not IsEmpty( valueToCheck ) then
				if verboseLogging then
					local keyString = ""
					if requirement.PathFromSource then
						keyString = source.Name
					end
					local firstTable = true
					for i, subTable in ipairs( requirement.PathEmpty ) do
						if firstTable and not requirement.PathFromSource then
							keyString = subTable
							firstTable = false
						else
							keyString = keyString.."."..subTable
						end
					end
					args.FirstFailedRequirement = keyString.." IsEmpty() (Current Size: "..TableLength(valueToCheck)..")"
				end
				return false
			end
		elseif requirement.PathNotEmpty ~= nil then
			if verboseLogging and requirement.Comparison ~= nil then
				DebugAssert({ Condition = false, Text = "Using Comparison with a PathNotEmpty requirement on "..tostring(source.Name), Owner = "Greg", })
			end
			for j, subTable in ipairs( requirement.PathNotEmpty ) do
				valueToCheck = valueToCheck[subTable]
				if valueToCheck == nil then
					break
				end
			end
			if IsEmpty( valueToCheck ) then
				if verboseLogging then
					local keyString = ""
					if requirement.PathFromSource then
						keyString = source.Name
					end
					local firstTable = true
					for i, subTable in ipairs( requirement.PathNotEmpty ) do
						if firstTable and not requirement.PathFromSource then
							keyString = subTable
							firstTable = false
						else
							keyString = keyString.."."..subTable
						end
					end
					args.FirstFailedRequirement = keyString.." not IsEmpty() (Current Size: "..(TableLength(valueToCheck) or 0)..")"
				end
				return false
			end
		elseif requirement.Path ~= nil then

			for j, subTable in ipairs( requirement.Path ) do
				valueToCheck = valueToCheck[subTable]
				if valueToCheck == nil then
					break
				end
			end
			if requirement.UseLength then
				valueToCheck = TableLength( valueToCheck )
				--DebugPrint({ Text = "UseLength length = "..valueToCheck })
			elseif requirement.Modulo ~= nil then
				if valueToCheck ~= nil then
					valueToCheck = valueToCheck % requirement.Modulo
					--DebugPrint({ Text = "Modulo = "..valueToCheck })
				end
			elseif requirement.CountOf ~= nil then
				if verboseLogging and type(valueToCheck) ~= "table" then
					DebugAssert({ Condition = false, Text = "Using CountOf on a non-table value on "..tostring(source.Name), Owner = "Greg", })
				end
				local count = 0
				for i, keyToCount in ipairs( requirement.CountOf ) do
					if valueToCheck[keyToCount] then
						count = count + 1
					end
				end
				--DebugPrint({ Text = "CountOf count = "..count })
				valueToCheck = count
			elseif requirement.SumOf ~= nil then
				if verboseLogging and type(valueToCheck) ~= "table" then
					DebugAssert({ Condition = false, Text = "Using SumOf on a non-table value on "..tostring(source.Name), Owner = "Greg", })
				end
				local sum = 0
				for i, keyToSum in ipairs( requirement.SumOf ) do
					sum = sum + (valueToCheck[keyToSum] or 0)
				end
				--DebugPrint({ Text = "SumOf sum = "..sum })
				valueToCheck = sum
			elseif requirement.MaxOf ~= nil then
				local max = 0
				if requirement.MaxOf == "All" then
					for tableKey, tableValue in pairs( valueToCheck ) do
						max = math.max( max, tableValue )
					end
				else
					for i, keyToMax in ipairs( requirement.MaxOf ) do
						max = max + (valueToCheck[keyToMax] or 0)
					end
				end
				--DebugPrint({ Text = "MaxOf = "..max })
				valueToCheck = max
			end

			if requirement.SumPrevRooms ~= nil then
				local prevRoomSum = 0
				--DebugPrint({ Text = "Summing previous rooms" })
				for roomsBack = 0, requirement.SumPrevRooms - 1 do
					local prevRoom = nil
					if roomsBack == 0 then
						prevRoom = CurrentRun.CurrentRoom
					else
						local roomIndex = #CurrentRun.RoomHistory - (roomsBack - 1)
						--DebugPrint({ Text = "roomIndex = "..roomIndex })
						prevRoom = CurrentRun.RoomHistory[roomIndex]
					end
					if prevRoom == nil then
						-- No more rooms to check
						break
					end
					valueToCheck = prevRoom
					for k, subTable in ipairs( requirement.Path ) do
						valueToCheck = valueToCheck[subTable]
						if valueToCheck == nil then
							if verboseLogging and k == 1 and not requirement.CountPathTrue and requirement.ValuesToCount == nil then
								DebugAssert({ Condition = false, Text = "First key \""..subTable.."\" on SumPrevRooms is nil on "..tostring(source.Name), Owner = "Gavin", })
							end
							break
						end
					end
					--DebugPrint({ Text = "prevRoom Name = "..prevRoom.Name })
					--DebugPrint({ Text = "prevRoom valueToCheck = "..tostring(valueToCheck) })
					if requirement.TableValuesToCount ~= nil then
						if valueToCheck ~= nil then
							for k, valueToCount in ipairs( requirement.TableValuesToCount ) do
								if valueToCheck[valueToCount] then
									prevRoomSum = prevRoomSum + 1
								end
							end
						end
						--DebugPrint({ Text = "prevRoomSum = "..prevRoomSum })
					elseif requirement.ValuesToCount ~= nil then
						for k, valueToCount in ipairs( requirement.ValuesToCount ) do
							if valueToCheck == valueToCount then
								prevRoomSum = prevRoomSum + 1
								--DebugPrint({ Text = "prevRoomSum = prevRoomSum + 1" })
								break
							end
						end
					elseif requirement.CountPathTrue ~= nil then
						if valueToCheck ~= nil then
							prevRoomSum = prevRoomSum + 1
						end
					else
						prevRoomSum = prevRoomSum + (valueToCheck or 0)
					end
				end
				valueToCheck = prevRoomSum
				--DebugPrint({ Text = "prevRoomSum = "..prevRoomSum })
			end

			if requirement.SumPrevRuns ~= nil then
				if verboseLogging and requirement.SumPrevRuns >= 10 then
					DebugAssert({ Condition = false, Text = "SumPrevRuns ("..requirement.SumPrevRuns..") cannot exceed 10 on "..tostring(source.Name), Owner = "Gavin", })
				end
				local prevRunSum = 0
				--DebugPrint({ Text = "Summing previous runs" })
				local startingRunsBack = 0
				if requirement.IgnoreCurrentRun then
					startingRunsBack = 1
				end
				for runsBack = startingRunsBack, requirement.SumPrevRuns - 1 do
					local prevRun = nil
					if runsBack == 0 then
						prevRun = CurrentRun
					else
						local runIndex = #GameState.RunHistory - (runsBack - 1)
						--DebugPrint({ Text = "runIndex = "..runIndex })
						prevRun = GameState.RunHistory[runIndex]
					end
					if prevRun == nil then
						-- No more runs to check
						break
					end
					valueToCheck = prevRun
					for k, subTable in ipairs( requirement.Path ) do
						valueToCheck = valueToCheck[subTable]
						if valueToCheck == nil then
							if verboseLogging and k == 1 and subTable ~= "Cleared" and subTable ~= "ActiveBounty" and subTable ~= "UsedStoryReset" then
								DebugAssert({ Condition = false, Text = "First key ("..subTable..") on SumPrevRuns is nil on "..tostring(source.Name), Owner = "Gavin", })
							end
							break
						end
					end
					if requirement.TableValuesToCount ~= nil then
						if valueToCheck ~= nil then
							for k, valueToCount in ipairs( requirement.TableValuesToCount ) do
								if valueToCheck[valueToCount] then
									prevRunSum = prevRunSum + 1
								end
							end
						end
						--DebugPrint({ Text = "prevRunSum = "..prevRunSum })
					elseif requirement.ValuesToCount ~= nil then
						for k, valueToCount in ipairs( requirement.ValuesToCount ) do
							if valueToCheck == valueToCount then
								prevRunSum = prevRunSum + 1
								--DebugPrint({ Text = "prevRunSum = prevRunSum + 1" })
								break
							end
						end
					elseif requirement.CountPathTrue ~= nil then
						if valueToCheck ~= nil then
							prevRunSum = prevRunSum + 1
						end
					else
						if verboseLogging and valueToCheck ~= nil and type(valueToCheck) ~= "number" then
							local pathString = "{ "
							for i, subTable in ipairs( requirement.Path ) do
								pathString = pathString.."\""..subTable.."\","
							end
							pathString = pathString.." }"
							DebugAssert({ Condition = false, Text = "SumPrevRuns trying to count non-number value "..pathString.." on "..tostring(source.Name).." (needs CountPathTrue)", Owner = "Greg", })
						end
						prevRunSum = prevRunSum + (valueToCheck or 0)
					end
					--DebugPrint({ Text = "run valueToCheck = "..tostring(valueToCheck) })
				end
				valueToCheck = prevRunSum
				--DebugPrint({ Text = "prevRunSum = "..prevRunSum })
			end

			if verboseLogging then
				local keyString = ""
				if requirement.PathFromSource then
					keyString = source.Name
				end
				local firstTable = true
				for i, subTable in ipairs( requirement.Path ) do
					if firstTable and not requirement.PathFromSource then
						keyString = subTable
						firstTable = false
					else
						keyString = keyString.."."..subTable
					end
				end
				args.FirstFailedRequirement = keyString
			end
			
			if requirement.HasNone ~= nil then
				if valueToCheck ~= nil then
					for i, valueFalse in ipairs( requirement.HasNone ) do
						if verboseLogging and type(valueToCheck) ~= "table" then
							DebugAssert({ Condition = false, Text = "Using HasNone on a non-table value on "..tostring(source.Name), Owner = "Greg", })
						end
						if valueToCheck[valueFalse] then
							if verboseLogging then
								args.FirstFailedRequirement = args.FirstFailedRequirement.." HasNone (Does have: "..tostring(valueFalse)..")"
							end
							args.FailedRequirementIndex = requirementIndex
							return false
						end
					end
				end
			elseif requirement.HasAny ~= nil then
				if valueToCheck == nil then
					return false
				end
				local anyTrue = false
				if verboseLogging and type(valueToCheck) ~= "table" then
					DebugAssert({ Condition = false, Text = "Using HasAny on a non-table value on "..tostring(source.Name), Owner = "Greg", })
				end
				for i, valueTrue in ipairs( requirement.HasAny ) do
					if valueToCheck[valueTrue] then
						anyTrue = true
						break
					end
				end
				if not anyTrue then
					if verboseLogging then
						args.FirstFailedRequirement = args.FirstFailedRequirement.." HasAny"
					end
					return false
				end
			elseif requirement.HasAll ~= nil then
				if valueToCheck == nil then
					return false
				end
				if verboseLogging and type(valueToCheck) ~= "table" then
					DebugAssert({ Condition = false, Text = "Using HasAll on a non-table value on "..tostring(source.Name), Owner = "Greg", })
				end
				for i, valueTrue in ipairs( requirement.HasAll ) do
					if not valueToCheck[valueTrue] then
						if verboseLogging then
							args.FirstFailedRequirement = args.FirstFailedRequirement.." HasAll (Missing: "..tostring(valueTrue)..")"
						end
						return false
					end
				end
			elseif requirement.NotHasAll ~= nil then
				if valueToCheck ~= nil then
					if verboseLogging and type(valueToCheck) ~= "table" then
						DebugAssert({ Condition = false, Text = "Using NotHasAll on a non-table value on "..tostring(source.Name), Owner = "Greg", })
					end
					local hasAll = true
					for i, valueTrue in ipairs( requirement.NotHasAll ) do
						if not valueToCheck[valueTrue] then
							hasAll = false
							break
						end
					end
					if hasAll then
						if verboseLogging then
							args.FirstFailedRequirement = args.FirstFailedRequirement.." NotHasAll"
						end
						return false
					end
				end
			elseif requirement.IsNone ~= nil then
				if verboseLogging and type(valueToCheck) == "table" then
					DebugAssert({ Condition = false, Text = "Using IsNone on a table value on "..tostring(source.Name), Owner = "Greg", })
				end
				for i, valueFalse in ipairs( requirement.IsNone ) do
					if valueToCheck == valueFalse then
						if verboseLogging then
							args.FirstFailedRequirement = args.FirstFailedRequirement.." IsNone (Current: "..tostring(valueToCheck)..")"
						end
						args.FailedRequirementIndex = requirementIndex
						return false
					end
				end
			elseif requirement.IsAny ~= nil then
				if verboseLogging and type(valueToCheck) == "table" then
					DebugAssert({ Condition = false, Text = "Using IsAny on a table value on "..tostring(source.Name or source.Cue), Owner = "Greg", })
				end
				local anyTrue = false
				for i, valueTrue in ipairs( requirement.IsAny ) do
					if valueToCheck == valueTrue then
						anyTrue = true
						break
					end
				end
				if not anyTrue then
					if verboseLogging then
						args.FirstFailedRequirement = args.FirstFailedRequirement.." IsAny (Current: "..tostring(valueToCheck)..")"
					end
					return false
				end
			elseif requirement.Comparison ~= nil then
				local comparison = requirement.Comparison
				if comparison == nil then
					DebugAssert({ Condition = false, Text = "Requirement missing Comparison on "..tostring(source.Name), Owner = "Greg", })
					break
				end

				local value = requirement.Value
				if requirement.ValuePath ~= nil then
					value = _G
					for k, subTable in ipairs( requirement.ValuePath ) do
						value = value[subTable]
						if value == nil then
							value = 0
							break
						end
					end	
					if requirement.ValuePathAddition ~= nil then
						value = value + requirement.ValuePathAddition
					end
				end

				if verboseLogging then
					args.FirstFailedRequirement = args.FirstFailedRequirement.." "..comparison.." "..tostring(value).." (Current: "..tostring(valueToCheck)..")"
				end

				if valueToCheck == nil and type(value) == "number" then
					valueToCheck = 0
				end

				if comparison == nil or comparison == "==" or comparison == "=" then
					if (valueToCheck or 0) ~= value then
						args.FailedRequirementIndex = requirementIndex
						return false
					end
				elseif comparison == "~=" or comparison == "!=" then
					if (valueToCheck or 0) == value then
						args.FailedRequirementIndex = requirementIndex
						return false
					end
				elseif comparison == ">=" then
					if (valueToCheck or 0) < value then
						args.FailedRequirementIndex = requirementIndex
						return false
					end
				elseif comparison == ">" then
					if (valueToCheck or 0) <= value then
						args.FailedRequirementIndex = requirementIndex
						return false
					end
				elseif comparison == "<=" then
					if (valueToCheck or 0) > value then
						args.FailedRequirementIndex = requirementIndex
						return false
					end
				elseif comparison == "<" then
					if (valueToCheck or 0) >= value then
						args.FailedRequirementIndex = requirementIndex
						return false
					end
				else
					DebugAssert({ Condition = false, Text = "Invalid requirements comparison: "..tostring(comparison), Owner = "Greg", })
				end			
			else
				DebugAssert({ Condition = false, Text = "Requirement missing Value on "..tostring(source.Name), Owner = "Greg" })
			end
		else
			--[[
			if verboseLogging then
				if requirement.HasNone ~= nil or requirement.HasAny ~= nil or requirement.HasAll ~= nil or requirement.IsNone ~= nil  or requirement.IsAny ~= nil then
					DebugAssert({ Condition = false, Text = "Missing Path for requirement on "..GetTableString(source), Owner = "Greg", })
				end
			end
			]]
		end

	end

	return true
end


function RequiredQueuedTextLine( source, args )
	args = args or {}

	if args.IsAny ~= nil then
		local anyTrue = false
		for unitId, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
			for k, textLineSet in pairs( args.IsAny ) do
				if unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == textLineSet then
					anyTrue = true
					break
				end
			end
		end
		if not anyTrue then
			return false
		end
	elseif args.IsNone ~= nil then
		for unitId, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
			for k, textLineSet in pairs( args.IsNone ) do
				if unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == textLineSet then
					return false
				end
			end
		end
	else
		DebugAssert({ Condition = false, Text = "RequiredQueuedTextLine missing IsAny or IsNone on "..tostring(source.Name), Owner = "Greg" })
		return false
	end

	return true
end

function RequiredConsecutiveDeathsInRoom( source, args )

	if verboseLogging and args.Count >= 10 then
		DebugAssert({ Condition = false, Text = "RequiredConsecutiveDeathsInRoom args.Count = "..args.Count.." (Max is 10)", Owner = "Gavin" })
	end

	local roomNames = args.Names or { args.Name }
	local consecutiveDeathsInRoom = 0
	if ContainsAnyKey( CurrentRun.RoomCountCache, roomNames ) then
		if not CurrentRun.Cleared and not CurrentRun.BountyCleared and Contains( roomNames, CurrentRun.EndingRoomName ) then
			-- Saw the room this run and died in it, streak continues
			consecutiveDeathsInRoom = consecutiveDeathsInRoom + 1
		else
			-- Saw the room this run and didn't die in it, streak is 0
			return false
		end
	end
	for i = #GameState.RunHistory, 1, -1 do
		local run = GameState.RunHistory[i]
		if run.RoomsEntered ~= nil and run.EndingRoomName ~= nil and ContainsAnyKey( run.RoomsEntered, roomNames ) then
			if not run.Cleared and not run.BountyCleared and Contains( roomNames, run.EndingRoomName ) then
				-- Saw the room this run and died in it, streak continues
				consecutiveDeathsInRoom = consecutiveDeathsInRoom + 1
			else
				-- Saw the room this run and didn't die, streak is broken
				break
			end
		end
	end

	if consecutiveDeathsInRoom < args.Count then
		return false
	end

	return true
end

function RequiredConsecutiveClearsOfRoom( source, args )

	if verboseLogging and args.Count >= 10 then
		DebugAssert({ Condition = false, Text = "RequiredConsecutiveClearsOfRoom args.Count = "..args.Count.." (Max is 10)", Owner = "Gavin" })
	end

	local roomNames = args.Names or { args.Name }
	local consecutiveClearsOfRoom = 0
	if ContainsAnyKey( CurrentRun.RoomCountCache, roomNames ) then
		if CurrentRun.Cleared or CurrentRun.BountyCleared or not Contains( roomNames, CurrentRun.EndingRoomName ) then
			-- Saw the room this run and didn't die in it, streak continues
			consecutiveClearsOfRoom = consecutiveClearsOfRoom + 1
		else
			-- Saw the room this run and died in it, streak is 0
			return false
		end
	end
	for i = #GameState.RunHistory, 1, -1 do
		local run = GameState.RunHistory[i]
		if run.RoomsEntered ~= nil and run.EndingRoomName ~= nil and ContainsAnyKey( run.RoomsEntered, roomNames ) then
			if run.Cleared or CurrentRun.BountyCleared or not Contains( roomNames, run.EndingRoomName ) then
				-- Saw the room this run and didn't die in it, streak continues
				consecutiveClearsOfRoom = consecutiveClearsOfRoom + 1
			else
				-- Saw the room this run and died in it, streak is broken
				break
			end
		end
	end

	if consecutiveClearsOfRoom < args.Count then
		return false
	end

	return true
end


function RequireSpellCharged( source, args )

	if not CurrentRun.Hero.SlottedSpell then
		return false
	elseif not SpellData[args.SpellName] then
		return false
	elseif SpellData[args.SpellName] and not HeroHasTrait( SpellData[args.SpellName].TraitName) then
		return false
	end
	local trait = GetHeroTrait( SpellData[args.SpellName].TraitName )
	local weaponData = GetWeaponData( CurrentRun.Hero, trait.PreEquipWeapons[1] )
	if CurrentRun.SpellCharge < GetManaSpendCost(weaponData) then
		return false
	end

	return true
end

function RequiredTraitCount( source, args )

	if args.Count > GetTotalTraitCount(CurrentRun.Hero) then
		return false
	end

	return true
end

function RequiredMinExits( source, args )

	if CurrentRun.CurrentRoom == nil then
		return false
	end

	local exitDoorsIPairs = CollapseTableOrdered( MapState.OfferedExitDoors )
	if #exitDoorsIPairs < args.Count then
		return false
	end

	return true
end

function RequiredAlive( source, args )

	if args.Alive == nil then
		args.Alive = true
	end

	if args.Ids ~= nil then
		for i, id in ipairs( args.Ids ) do
			if IsAlive({ Id = id }) ~= args.Alive then
				return false
			end
		end
	elseif args.Units ~= nil then
		for i, unit in ipairs( args.Units ) do
			local unitIsAlive = not IsEmpty( GetIdsByType({ Name = unit }) )
			if unitIsAlive ~= args.Alive then
				return false
			end
		end
	end

	return true
end

function RequireUnrestrictedBoonChoices( source, args )
	
	if HasHeroTraitValue("RestrictBoonChoices") then
		return false
	end

	return true
end

function RequiredBossPhase( source, args )

	if ActiveEnemies[CurrentRun.CurrentRoom.BossId] ~= nil then
		local boss = ActiveEnemies[CurrentRun.CurrentRoom.BossId]
		if boss.CurrentPhase ~= args.Phase then
			return false
		end
	end

	return true
end

function RequiredHealthFraction( source, args )
	local currentHealthFraction = CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth
	return DoComparison( currentHealthFraction, args.Comparison, args.Value )
end

function RequiredShrineLevel( source, args )
	local numShrineUpgrades = GetNumShrineUpgrades( args.ShrineUpgradeName )
	return DoComparison( numShrineUpgrades, args.Comparison, args.Value )
end

function DoComparison( value1, comparison, value2 )
	if comparison == "==" then
		if value1 ~= value2 then
			return false
		end
	elseif comparison == "~=" then
		if value1 == value2 then
			return false
		end
	elseif comparison == ">=" then
		if value1 < value2 then
			return false
		end
	elseif comparison == ">" then
		if value1 <= value2 then
			return false
		end
	elseif comparison == "<=" then
		if value1 > value2 then
			return false
		end
	elseif comparison == "<" then
		if value1 >= value2 then
			return false
		end
	else
		DebugAssert({ Condition = false, Text = "Invalid requirements comparison: "..tostring(comparison), Owner = "Greg", })
	end
	return true
end

function RequiredTraitNameInRoom( source, args )
	if args.Name == nil then
		DebugAssert({ Condition = false, Text = "Missing Trait name in RequiredTraitNameInRoom", Owner = "Greg", })
	end

	if source ~= nil and not HasTraitOnLoot( source, args.Name ) then
		return false
	end

	return true
end

function RequiredRarityInRoom( source, args )

	if source ~= nil then
		local meetsMinRarityRequirement = false
		local meetsHighestRarityRequirement = false
		if args.AllAtLeastRarity ~= nil and AllAtLeastRarity( source, args.AllAtLeastRarity ) then
			meetsMinRarityRequirement = true
		end
		if args.HasAtLeastRarity ~= nil and HasAtLeastRarity( source, args.HasAtLeastRarity ) then
			meetsHighestRarityRequirement = true
		end
		if not meetsMinRarityRequirement or not meetsHighestRarityRequirement then
			return false
		end
	end

	return true
end

function RequiredRewardTypeInRoom( source, args )

	if args.IsNone ~= nil then
		for i, roomObject in pairs( MapState.RoomRequiredObjects ) do
			if Contains( args.IsNone, roomObject.Name ) then
				return false
			end
		end
	end

	return true
end

function RequiredRewardCountInRoom( source, args )
	local count = 0
	for i, roomObject in pairs( MapState.RoomRequiredObjects ) do
		if not Contains( args.ExcludeNames, roomObject.Name ) then
			count = count + 1
		end
	end
	if count == args.Value then
		return true
	end
	return false
end

function RequireQuestWithStatus( source, args )

	if args.Status ~= nil and not HasAnyQuestWithStatus( args.Status ) then
		return false
	end

	return true
end

function RequireQuestCount( source, args )

	local numQuests = 0
	if GameState.QuestStatus ~= nil then
		for questName, questStatus in pairs( GameState.QuestStatus ) do
			if questStatus == args.Status then
				numQuests = numQuests + 1
			end
		end
	end

	if args.Min ~= nil and numQuests < args.Min then
		return false
	end

	if args.Max ~= nil and numQuests > args.Max then
		return false
	end

	return true
end

function RequireAffordableItemInScreen( source, args )

	local canAffordAny = false
	local screenData = ScreenData[ args.Screen ]
	local itemCategories = screenData.ItemCategories
	local dataStore = _G[ args.DataStore ]

	if itemCategories ~= nil then
		for i, category in ipairs( itemCategories ) do
			if category.GameStateRequirements == nil or IsGameStateEligible( category, category.GameStateRequirements ) then
				for j, itemName in ipairs( category ) do
					local itemData = dataStore[itemName]
					if itemData ~= nil and not GameState.WorldUpgradesAdded[itemName] and not GameState.WeaponsUnlocked[itemName] and not itemData.IgnoreAffordable then
						local cost = itemData.ResourceCost or itemData.Cost
						if HasResources( cost ) then
							if GhostAdminAllowViewItem( screenData, category, itemData ) then
								--DebugPrint({ Text = "can afford: "..itemName })
								canAffordAny = true
								break
							end
						end
					end
				end
			end
		end
	end

	if not canAffordAny then
		return false
	end

	return true
end

function RequireAffordableMetaUpgrade( source, args )

	-- Account for first open pity
	if not GameState.ScreensViewed.MetaUpgradeCardLayout then
		return true
	end
	local canAffordAny = false
	if CanIncreaseMetaUpgradeCardLimit() then
		canAffordAny = true
	else
		local current = GetCurrentMetaUpgradeCost()
		local limit = GetMaxMetaUpgradeCost()
		for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
			for column, cardName in pairs( rowData ) do
				if not canAffordAny
					and GameState.MetaUpgradeState[cardName]
					and not GameState.MetaUpgradeState[cardName].Unlocked
					and not MetaUpgradeCardData[cardName].DebugOnly
					and MetaUpgradeCardData[cardName].ResourceCost
					and HasResources(MetaUpgradeCardData[cardName].ResourceCost)
					and (HasNeighboringUnlockedCards( row, column ) or (row == 1 and column == 1))
					and current + MetaUpgradeCardData[ cardName ].Cost <= limit
					then
					canAffordAny = true
				end
			end
		end
	end
	
	if not canAffordAny then
		return false
	end

	return true
end

function RequireAllMetaUpgradesAtMaxLevel( source, args )
	for row, rowData in pairs( GameState.MetaUpgradeCardLayout ) do
		for column, cardName in pairs( rowData ) do
			if not MetaUpgradeAtMaxLevel( cardName ) then
				return false
			end
		end
	end
	return true
end

function RequireRunsSinceTextLines( source, args )

	if verboseLogging and ( args.Min ~= nil and args.Min >= 10 ) or (args.Max ~= nil and args.Max >= 10 ) then
		DebugAssert({ Condition = false, Text = "RequireRunsSinceTextLines args.Min = ".. (args.Min or "nil") .."; args.Max = " .. (args.Max or "nil") .. " (Max is 10)", Owner = "Gavin" })
	end
	for k, textLines in pairs( args.TextLines ) do
		local runsSinceOccurred = 0
		for runIndex = #GameState.RunHistory + 1, 1, -1 do
			local prevRun = GameState.RunHistory[runIndex] or CurrentRun
			if prevRun.TextLinesRecord ~= nil and prevRun.TextLinesRecord[textLines] then

				if ( args.Min ~= nil and runsSinceOccurred < args.Min ) or ( args.Max ~= nil and runsSinceOccurred > args.Max ) then
					return false
				else
					-- voiceline was found and valid for both cases
					break
				end
			end
			runsSinceOccurred = runsSinceOccurred + 1
			if args.Max == nil and runsSinceOccurred >= args.Min then
				-- No max test and already past Min
				break
			elseif args.Min == nil and runsSinceOccurred >= args.Max then
				-- No min test and already past Max
				return false
			end
		end
	end

	return true
end


function RequiredConfigOptions( source, args )

	if args.HasOptions == nil then
		args.HasOptions = true
	end

	for k, configOption in pairs( args.ConfigOptions ) do
		if not ( GetConfigOptionValue({ Name = configOption }) == args.HasOptions ) then
			return false
		end
	end

	return true
end

function RequiredMissingLastStands( source, args )
	local currentLastStandNum = TableLength( CurrentRun.Hero.LastStands )
	local maxLastStands = CurrentRun.Hero.MaxLastStands or 0
	if HeroHasTrait("FocusLastStandBoon") then
		local hasAthenaLastStand = false
		for i, lastStand in ipairs( CurrentRun.Hero.LastStands ) do
			if lastStand.Name == "Athena"  then
				hasAthenaLastStand = true
				break
			end
		end
		if not hasAthenaLastStand then
			currentLastStandNum = currentLastStandNum + 1
		end
	end
	return currentLastStandNum < maxLastStands
end

function RequiredNotInStore( source, args )

	local currentRun = CurrentRun
	if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Store ~= nil and currentRun.CurrentRoom.Store.StoreOptions ~=nil then
		for i, value in pairs(currentRun.CurrentRoom.Store.StoreOptions) do
			if value.Name == args.Name then
				return false
			end
		end
	end

	return true
end

function RequiredMusicSectionRoomDuration( source, args )

	if AudioState.MusicSectionStartDepth ~= nil then
		local duration = GetRunDepth( CurrentRun ) - AudioState.MusicSectionStartDepth
		if duration < args.Value then
			return false
		end
	end

	return true
end

function RequiredSellableGodTraits( source, args )

	local hasSellable = false
	for index, traitData in pairs (CurrentRun.Hero.Traits) do
		if not hasSellable and IsGodTrait( traitData.Name, { ForShop = true }) and traitData.Rarity then
			hasSellable = true
		end
	end
	if not hasSellable then
		return false
	end

	return true
end

function RequiredUpgradeableGodTraits( source, args )

	if not UpgradableGodTraitCountAtLeast( args.Count ) then
		return false
	end

	return true
end


function RequiredDistanceFromHero( source, dataArgs, contextArgs )
	if source ~= nil and dataArgs.MaxDistance ~= nil then
		local distanceSource = contextArgs.CurrentSource or contextArgs.OriginalSource or source
		if GetDistance({ Id = distanceSource.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) > dataArgs.MaxDistance then
			return false
		end
	end
	return true
end

function RequiredOfferedDoorWitRoomSetName( source, args )
	for id, door in pairs( MapState.OfferedExitDoors ) do
		if door.Room ~= nil and door.Room.RoomSetName == args.RoomSetName then
			return true
		end
	end
	return false
end

function RequiredMinRoomsSinceEvent( source, args )

	local depthCheck = nil
	if args.Event == "Devotion" then
		depthCheck = "LastDevotionDepth"
	elseif args.Event == "WellShop" then
		depthCheck = "LastWellShopDepth"
	elseif args.Event == "ChallengeSwitch" then
		depthCheck = "LastChallengeDepth"
	elseif args.Event == "FishingPoint" then
		depthCheck = "LastFishingPointDepth"
	else
		DebugAssert({ Condition = false, Text = "No known event for RequiredMinRoomsSinceEvent: " .. args.Event, Owner = "Greg" })
	end

	local currentRun = CurrentRun
	if currentRun[depthCheck] ~= nil and currentRun[depthCheck] ~= currentRun.RunDepthCache and currentRun.RunDepthCache - args.Count < currentRun[depthCheck] then
		return false
	end

	return true
end