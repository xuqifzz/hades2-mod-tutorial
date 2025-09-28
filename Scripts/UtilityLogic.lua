Import "RandomLogic.lua"
Import "LocalizationLogic.lua"

-- Utility Functions
function TableLength( table, nilIsZero )

	if table == nil then
		if nilIsZero then
			return 0
		else
			return
		end
	end

	local count = 0
	for _ in pairs( table ) do
		count = count + 1
	end
	return count + 0

end

function TableClear( table )
	for k,v in pairs(table) do
		table[k] = nil
	end
end

function CalcTotalNumEntries( table, trace )

	if table == nil then
		return 0
	end
	trace = trace or ""

	local count = 0
	for key, value in pairs( table ) do
		count = count + 1
		if type( value ) == "table" then
			local recursiveTrace = trace.."."..key
			local size = CalcTotalNumEntries( value, recursiveTrace )
			count = count + size
		end
	end

	if count > 100 then
		DebugPrint({ Text = trace.." = "..count, LogOnly = true })
	end

	return count

end

function ShallowCopyTable( table )

	if table == nil then
		return
	end

	local copy = {}
	for k, v in pairs( table ) do
		copy[k] = v
	end
	return copy
end

function DeepCopyTable( orig )
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		-- slightly more efficient to call next directly instead of using pairs
		for k,v in next, orig, nil do
			copy[k] = DeepCopyTable(v)
		end
	else
		copy = orig
	end

	return copy
end

function GetAllKeys( tableToGather )

	if tableToGather == nil then
		return
	end

	local keys = {}
	for k, v in pairs( tableToGather ) do
		table.insert( keys, k )
	end
	return keys
end

function GetAllValues( tableToGather )

	if tableToGather == nil then
		return
	end

	local values = {}
	for k, v in pairs( tableToGather ) do
		table.insert( values, v )
	end
	return values
end

function MergeTables( table1, table2 )

	if table1 == nil and table2 == nil then
		return
	end
	
	if table1 == nil then 
		return ShallowCopyTable( table2 )
	end
	
	if table2 == nil then
		return ShallowCopyTable( table1 )
	end
	
	local returnTable = ShallowCopyTable( table1 )
	for k, v in pairs( table2 ) do
		returnTable[k] = v
	end

	return returnTable
end

function DeepMergeTables( baseTable, incomingTable )

	-- incomingTable overwrites baseTable with any values incomingTable defines
	if baseTable == nil or incomingTable == nil then
		return
	end

	local returnTable = DeepCopyTable( baseTable )
	for k, v in pairs( incomingTable ) do
		if type(v) == "table" then
			if next(v) == nil then
				returnTable[k] = {}
			else
				returnTable[k] = DeepMergeTables( returnTable[k], v )
			end
		elseif v == "nil" then
			returnTable[k] = nil
		else
			returnTable[k] = v
		end
	end

	return returnTable
end

function MergeAllTables( tables )

	local returnTable = {}
	for s, table in pairs( tables ) do
		if table then
			for k, v in pairs( table ) do
				returnTable[k] = v
			end
		end
	end

	return returnTable
end


function CombineTables( table1, table2 )

	if table1 == nil or table2 == nil then
		return
	end

	local returnTable = ShallowCopyTable( table1 )
	for k, v in pairs( table2 ) do
		table.insert( returnTable, v )
	end

	return returnTable

end

function CombineTablesIPairs( table1, table2 )

	if table1 == nil or table2 == nil then
		return
	end

	local returnTable = {}
	for k,v in ipairs(table1) do
		table.insert( returnTable, v )
	end
	for k, v in ipairs( table2 ) do
		table.insert( returnTable, v )
	end

	return returnTable

end

function ConcatTableValues( baseTable, tableToAdd )

	if tableToAdd == nil then
		return baseTable
	end

	for key, value in pairs( tableToAdd ) do
		table.insert( baseTable, value )
	end

	return baseTable

end

function ConcatTableValuesIPairs( baseTable, tableToAdd )

	if tableToAdd == nil then
		return baseTable
	end

	for key, value in ipairs( tableToAdd ) do
		table.insert( baseTable, value )
	end

	return baseTable

end

function OverwriteSelf( source, args )
	if source == nil then
		return
	end
	for key, value in pairs( args ) do
		if value == "nil" then
			source[key] = nil
		else
			source[key] = value
		end
	end
	if args.Animation ~= nil then
		SetAnimation({ Name = args.Animation, DestinationId = source.ObjectId })
	end
	if args.InteractDistance ~= nil then
		SetInteractProperty({ DestinationId = source.ObjectId, Property = "Distance", Value = args.InteractDistance })
	end
	if args.StopAmbientSound then
		StopAmbientSound({ Id = source.ObjectId })
	end
end

function OverwriteTableKeys( tableToOverwrite, tableToTake )

	if tableToTake == nil then
		return
	end

	for key, value in pairs( tableToTake ) do
		if value == "nil" then
			tableToOverwrite[key] = nil
		else
			tableToOverwrite[key] = value
		end
	end
end

function OverwritePrimitiveTableKeys( tableToOverwrite, tableToTake )

	if tableToTake == nil then
		return
	end

	for key, value in pairs( tableToTake ) do
		if type(value) ~= "table" then
			if value == "nil" then
				tableToOverwrite[key] = nil
			else
				tableToOverwrite[key] = value
			end
		end
	end
end

function RemoveTableValues( tableToRemoveFrom, tableOfValues )
	for key, value in pairs( tableOfValues ) do
		tableToRemoveFrom[value] = nil
	end
end

function AddTableKeysCheckDupes( tableToOverwrite, tableToTake )

	if tableToTake == nil then
		return
	end

	for key, value in pairs( tableToTake ) do

		if verboseLogging and tableToOverwrite[key] ~= nil and not FinishedDataRead then -- @hack Gavin -- does not account for HotLoading
			DebugAssert({ false, Text = "Disallowed duplicate key: "..key })
		end

		if value == "nil" then
			tableToOverwrite[key] = nil
		else
			tableToOverwrite[key] = value
		end
	end
end

function ValidateDuplicateValues( table )
	
	if table == nil then
		return
	end

	local values = {}
	for key, value in pairs( table ) do
		if values[value] then
			DebugAssert({ false, Text = "Duplicate value found: "..value })
		end
		values[value] = true
	end

end

function CollapseTable( tableArg )

	if tableArg == nil then
		return
	end

	local collapsedTable = {}
	local index = 1
	for k, v in pairs( tableArg ) do
		collapsedTable[index] = v
		index = index + 1
	end

	return collapsedTable

end

function CollapseTableOrdered( tableArg )
	if tableArg == nil then
		return
	end
	local collapsed = CollapseTable( tableArg )
	table.sort(collapsed, cmp_multitype)
	return collapsed
end

function CollapseTableAsKeyValuePairs( tableArg )

	if tableArg == nil then
		return
	end

	local collapsedTable = {}
	local index = 1
	for k, v in pairs( tableArg ) do
		collapsedTable[index] =
		{
			Key = k,
			Value = v
		}
		index = index + 1
	end

	return collapsedTable

end

function CollapseTableAsOrderedKeyValuePairs( tableArg )
	if tableArg == nil then
		return
	end
	local collapsedTable = CollapseTableAsKeyValuePairs( tableArg )
	-- NOTE: Not using cmp_multitype since this is guaranteed to be an array of tables
	table.sort(collapsedTable, CompareGameDataTables)
	return collapsedTable
end

function OverwriteAndCollapseTable( tableArg )
	local collapsed = CollapseTable( tableArg )

	-- NOTE: pairs() is used here to make sure everything is
	-- deleted. We don't want any gaps in the original table
	for k, v in pairs(tableArg) do
		tableArg[k] = nil
	end
	for i, v in ipairs(collapsed) do
		tableArg[i] = v
	end

	return tableArg
end

function GetHighestIndex( tableArg )
	local highestIndex = 0
	for index, v in pairs( tableArg ) do
		if index > highestIndex then
			highestIndex = index
		end
	end
	return highestIndex
end

function GetIndex( tableArg, value )
	for index, tableValue in ipairs( tableArg ) do
		if tableValue == value then
			return index
		end
	end
	return 0
end

function ContainsAny( tableToSearch, tableOfValues )

	for k, v in pairs( tableOfValues ) do
		if Contains( tableToSearch, v ) then
			return true
		end
	end

	return false

end

function ContainsAnyKey( tableToSearch, tableOfKeys )

	for k, key in pairs( tableOfKeys ) do
		if tableToSearch[key] then
			return true
		end
	end

	return false

end

function ContainsAll( tableToSearch, tableOfValues )
	for k, v in pairs(tableOfValues) do
		if not Contains(tableToSearch, v) then
			return false
		end
	end
	return true
end

function DebugContains( tableArg, value )

	if tableArg == nil or value == nil then
		DebugPrint{ Text = "nil table or value" }
		return
	end

	for key, tableValue in pairs( tableArg ) do

		DebugPrint({ Text = "Key = "..tostring(key).." Value = "..tostring(tableValue) })
		if tableValue == value then
			return true
		end

	end

	return false

end

function IsEmpty( tableArg )

	if tableArg == nil then
		return true
	end

	return next(tableArg) == nil
end

function GetFirstKey( tableArg )
	if type(tableArg) ~= "table" then
		return tableArg
	end

	if tableArg == nil then
		return
	end

	for key, value in pairs( tableArg ) do
		return key
	end
end

function GetFirstValue( tableArg )
	if type(tableArg) ~= "table" then
		return tableArg
	end

	if tableArg == nil then
		return
	end

	for index, value in ipairs( tableArg ) do
		return value
	end

	for key, value in pairs( tableArg ) do
		return value
	end
end

function RemoveFirstValue( tableArg )

	if tableArg == nil then
		return
	end

	for index, value in ipairs( tableArg ) do
		tableArg[index] = nil
		return value
	end

	for key, value in pairs( tableArg ) do
		tableArg[key] = nil
		return value
	end

end

function RemoveFirstIndexValue( tableArg )

	-- Remove the value at index 1 and bump the rest of the table up

	if tableArg == nil or IsEmpty( tableArg ) then
		return
	end

	local returnValue = tableArg[1]
	for index, value in ipairs( tableArg ) do
		if tableArg[index + 1] ~= nil then
			tableArg[index] = tableArg[index + 1]
		end
	end
	tableArg[#tableArg] = nil

	return returnValue

end

function RemoveValue( tableArg, value )

	if tableArg == nil or value == nil then
		return
	end

	for key, tableValue in pairs( tableArg ) do

		if value == tableValue then
			tableArg[key] = nil
			return value
		end
	end

end

function RemoveIndexAndCollapse( tableArg, indexToRemove )

	if tableArg == nil or indexToRemove == nil then
		return
	end

	for index = indexToRemove, #tableArg do
		local nextIndex = index + 1
		if tableArg[nextIndex] ~= nil then
			tableArg[index] = tableArg[nextIndex]
		else
			-- Remove the final index that has now been moved up
			tableArg[index] = nil
		end
	end

end

function RemoveValueAndCollapse( tableArg, value )

	if tableArg == nil or value == nil then
		return false
	end

	local foundValue = false
	for index, tableValue in ipairs( tableArg ) do
		if not foundValue and value == tableValue then
			tableArg[index] = nil
			foundValue = true
		end
		if foundValue then
			local nextIndex = index + 1
			if tableArg[nextIndex] ~= nil then
				tableArg[index] = tableArg[nextIndex]
			else
				-- Remove the final index that has now been moved up
				tableArg[index] = nil
			end
		end
	end

	return foundValue

end

function RemoveAllValues( tableArg, value )

	if tableArg == nil or value == nil then
		return
	end

	for key, tableValue in pairs( tableArg ) do
		if tableValue == value then
			tableArg[key] = nil
		end
	end

end

function GetKey( tableArg, value )

	if tableArg == nil then
		return
	end

	for k, v in pairs( tableArg ) do

		if v == value then
			return k
		end
	end

end

function Lerp( start, finish, fraction )
      return start + (finish - start) * fraction
end

function GetRandomEligiblePrioritizedItem( items, priorities, playedStore, randomRemainingStore, args )

	if items == nil then
		return nil
	end

	local eligibleItems = {}
	local eligibleUnplayedItems = {}
	local eligibleOneTimeItems = {}
	local eligiblePlayFirstItems = {}
	
	args = args or {}

	for itemName, itemData in pairs( items ) do
		if not itemData.DebugOnly and ( not itemData.PlayOnce or not playedStore[itemData.Name] ) and ( itemData.GameStateRequirements == nil or IsGameStateEligible( itemData, itemData.GameStateRequirements ) ) then
			eligibleItems[itemData.Name] = true
			if not randomRemainingStore[itemData.Name] then
				table.insert( eligibleUnplayedItems, itemData )
				if itemData.PlayFirst and not playedStore[itemData.Name] then
					table.insert( eligiblePlayFirstItems, itemData )
				end
			end
			if itemData.PlayOnce then
				table.insert( eligibleOneTimeItems, itemData )
			end
		end
	end

	-- Priorities only apply to completely unplayed items
	if priorities ~= nil then
		for k, priority in ipairs( priorities ) do
			if type(priority) == "table" then
				local eligiblePriorityItems = {}
				for j, itemName in ipairs( priority ) do
					if not playedStore[itemName] and eligibleItems[itemName] then
						table.insert( eligiblePriorityItems, itemName )
					end
				end
				if not IsEmpty( eligiblePriorityItems ) then
					local randomPriorityConversation = GetRandomValue( eligiblePriorityItems )
					DebugPrint({ Text = "Random Priority Item: "..randomPriorityConversation })
					return items[randomPriorityConversation]
				end
			elseif not playedStore[priority] and eligibleItems[priority] then
				DebugPrint({ Text = "Priority Item: "..priority })
				return items[priority]
			end
		end
	end

	if not IsEmpty( eligibleOneTimeItems ) then
		return GetRandomValue( eligibleOneTimeItems )
	end

	local randomItem = nil
	if IsEmpty( eligibleUnplayedItems ) then
		-- All items played, start the record over
		for itemName, itemData in pairs( items ) do
			randomRemainingStore[itemName] = nil
		end
		local randomItemName = GetRandomKey( eligibleItems )
		randomItem = items[randomItemName]
	else
		if not IsEmpty( eligiblePlayFirstItems ) then
			randomItem = GetRandomValue( eligiblePlayFirstItems )
		else
			randomItem = GetRandomValue( eligibleUnplayedItems )
		end
	end
	if randomItem ~= nil then
		randomRemainingStore[randomItem.Name] = true
	end
	return randomItem

end

function CalcOffset( angle, distance )

	local offset = {}

	offset.X = math.cos( angle ) * distance
	offset.Y = -math.sin( angle ) * distance

	return offset

end

function round( num, idp )
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

function GetTimerString( totalSeconds, decimals )
	decimals = decimals or 0

	local minutes = math.floor( totalSeconds / 60 )
	local remainingSeconds = totalSeconds - (minutes * 60)
	local seconds = math.floor( remainingSeconds )
	local milliseconds = math.floor( (remainingSeconds - seconds) * 100 )
	
	local str = ""
	if minutes < 10 then
		str = str.."0"
	end
	str = str..minutes..":"
	if seconds < 10 then
		-- Pad leading zero
		str = str.."0"
	end
	str = str..seconds.."."
	if milliseconds < 10 then
		-- Pad leading zero
		str = str.."0"
	end
	str = str..milliseconds

	return str
end

function GetTwoDigitString( num )
	local string = ""
	if num <= 9 then
		string = string.."0"
	end
	string = string..num
	return string
end

function stringends(String,End)
	return End=='' or string.sub(String,-string.len(End))==End
end

function Clamp( number, low, high )

	if number < low then
		return low
	elseif number > high then
		return high
	end

	return number

end

function Contains( tableArg, value )

	if tableArg == nil or value == nil then
		return
	end

	for key, tableValue in pairs( tableArg ) do

		if tableValue == value then
			return true
		end
	end

	return false

end

-- Check if it's been at least time seconds since this was last called with name
function CheckCooldown( name, time, unmodified )

	if name == nil or time == nil or time <= 0.0 then
		return true
	end

	if SessionState.GlobalCooldowns[name] == nil then
		SessionState.GlobalCooldowns[name] = -999
	end
	if unmodified then
		if _worldTimeUnmodified > SessionState.GlobalCooldowns[name] + time then
			SessionState.GlobalCooldowns[name] = _worldTimeUnmodified
			return true
		end	
	else
		if _worldTime > SessionState.GlobalCooldowns[name] + time then
			SessionState.GlobalCooldowns[name] = _worldTime
			return true
		end
	end
	return false

end

function CheckCooldownNoTrigger( name, time, unmodified )

	if name == nil then
		return true
	end

	if time == nil then
		DebugAssert({ Condition = false, Text = "Cooldown "..name.." checked with no time value" })
		return true
	end

	if SessionState.GlobalCooldowns[name] == nil then
		return true
	end
	if unmodified then
		if _worldTimeUnmodified > SessionState.GlobalCooldowns[name] + time then
			return true
		end	
	else
		if _worldTime > SessionState.GlobalCooldowns[name] + time then
			return true
		end
	end

	return false

end

function TriggerCooldown( name )
	if name == nil then
		return
	end
	SessionState.GlobalCooldowns[name] = _worldTime
end


function ResetCooldown( name )
	if name == nil then
		return
	end
	SessionState.GlobalCooldowns[name] = nil
end

-- Check if this has been called with this name threshold times in the last window seconds
function CheckCountInWindow( name, window, threshold, args )
	args = args or {}
	if SessionState.GlobalCounts[name] == nil then
		SessionState.GlobalCounts[name] = {}
	end
	
	if not args.NoTrigger then
		table.insert( SessionState.GlobalCounts[name], _worldTime )
	end
	
	if args.TriggerOnly then
		return
	end
	
	local count = 0
	for k = #SessionState.GlobalCounts[name], 1, -1 do
		count = count + 1
		if count >= threshold and SessionState.GlobalCounts[name][k] + window > _worldTime then
			-- Hit the threshold count while still in the given window
			return true
		end

	end

	return false

end

function CompareGameDataTables( table1, table2 )

	local type1, type2 = type(table1), type(table2)

	if type1 == type2 and type1 == "table" then

		-- Some common key names to use to compare similar tables with similar data.
		-- The values compared should be primitive types.

		if table1.Name ~= nil and table2.Name ~= nil then
			return table1.Name < table2.Name
		elseif table1.Key ~= nil and table2.Key ~= nil then
			return tostring(table1.Key) < tostring(table2.Key)
		elseif table1.ItemName ~= nil and table2.ItemName ~= nil then
			return table1.ItemName < table2.ItemName
		elseif table1.Type ~= nil and table2.Type ~= nil then
			return table1.Type < table2.Type
		elseif table1.Cue ~= nil and table2.Cue ~= nil then
			return table1.Cue < table2.Cue
		end

		-- So long as we don't have circular table references, this shouldn't stack overflow
		-- This is a lazy way to handle arrays, but it works.
		return CompareGameDataTables(next(table1), next(table2))
	else
		return cmp_multitype(table1, table2)
	end

	--DebugPrint({ Text = "Nondeterministic sort warning!" })
	--for k1, v1 in pairs(table1) do
	--	for k2, v2 in pairs(table2) do
	--		if k1 == k2 then
	--			DebugPrint({ Text = "Found match: " .. tostring(k1) .. " with v1: "..tostring(v1).." and v2: "..tostring(v2) })
	--		end
	--	end
	--end
	--return tostring(table1) < tostring(table2)
end

function ChangeDrawGroup( objectId, drawGroup )
	local originalDrawGroup = GetGroupName({ Id = objectId, DrawGroup = true })
	if originalDrawGroup ~= drawGroup then
		RemoveFromGroup({ Id = objectId, Name = originalDrawGroup })
		AddToGroup({ Id = objectId, Name = drawGroup, DrawGroup = true })
	end
end

--[[
Ordered table iterator, allow to iterate on the natural order of the keys of a
table.

http://lua-users.org/wiki/SortedIteration
]]
function cmp_multitype(op1, op2)
    local type1, type2 = type(op1), type(op2)
    if type1 ~= type2 then --cmp by type
        return type1 < type2
    elseif type1 == "number" and type2 == "number"
        or type1 == "string" and type2 == "string" then
        return op1 < op2 --comp by default
    elseif type1 == "boolean" and type2 == "boolean" then
        return op1 == true
    else
        return CompareGameDataTables(op1, op2)
        --return tostring(op1) < tostring(op2) --cmp by address
    end
end

function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex, cmp_multitype ) --### CANGE ###
    return orderedIndex
end

function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

    local key = nil
    --print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
    else
        -- fetch the next value
        for i = 1, #t.__orderedIndex do
            if t.__orderedIndex[i] == state then
                key = t.__orderedIndex[i+1]
            end
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
    t.__orderedIndex = nil
    return
end

function orderedPairs(t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end

-- https://stackoverflow.com/questions/35572435/how-do-you-do-the-fisher-yates-shuffle-in-lua
function FYShuffle( tInput )
    local tReturn = {}
    for i = #tInput, 1, -1 do
        local j = RandomNumber(i)
        tInput[i], tInput[j] = tInput[j], tInput[i]
        table.insert(tReturn, tInput[i])
    end
    return tReturn
end

function GetRandomValue( tableArg, rng )

	if tableArg == nil then
		return
	end

	rng = rng or GetGlobalRng()

	local numItems = TableLength( tableArg )
	local randomIndex = rng:Random( numItems )

	-- CollapseTable implicitly makes a shallow copy
	local sortedTable = CollapseTableOrdered( tableArg )
	return sortedTable[randomIndex]

end

function GetRandomArrayValue( tableArg, rng )
	if tableArg == nil then
		return
	end
	if verboseLogging and #tableArg ~= TableLength(tableArg) then
		DebugAssert({ Condition = false , Text = "GetRandomArrayValue used with a non-array table", Owner = "Gavin" })
	end
	rng = rng or GetGlobalRng()
	local randomIndex = rng:Random( #tableArg )
	return tableArg[randomIndex]
end

function GetRandomKey( tableArg, rng )

	if tableArg == nil then
		return
	end

	rng = rng or GetGlobalRng()

	local numItems = TableLength( tableArg )
	local randomIndex = rng:Random( numItems )
	local sortedKeys = __genOrderedIndex(tableArg)
	return sortedKeys[randomIndex]

end

function RemoveRandomKey( tableArg, rng )

	if tableArg == nil then
		return
	end

	rng = rng or GetGlobalRng()

	local numItems = TableLength( tableArg )
	local randomIndex = rng:Random( numItems )

	local index = 0
	for key, value in orderedPairs( tableArg ) do

		index = index + 1
		if index == randomIndex then
			tableArg.__orderedIndex = nil
			tableArg[key] = nil
			return key
		end
	end

end

function RemoveRandomValue( tableArg, rng )

	local numItems = TableLength( tableArg )

	if tableArg == nil or numItems <= 0 then
		return
	end

	rng = rng or GetGlobalRng()
	local retVal = nil
	local randomIndex = 1
	tableArg = OverwriteAndCollapseTable( tableArg )

	if numItems > 1 then
		randomIndex = rng:Random( numItems )
	else
		retVal = tableArg[1]
		tableArg[1] = nil
		return retVal
	end

	table.sort(tableArg, cmp_multitype)

	retVal = tableArg[randomIndex]
	tableArg[randomIndex] = nil
	return retVal

end

function GetRandomEligibleValueFromWeightedList( tableArg, args )
	local weightedList = {}
	for k, option in pairs( tableArg ) do
		if option.GameStateRequirements == nil or IsGameStateEligible( option, option.GameStateRequirements, args ) then
			weightedList[k] = option.Weight
		end
	end
	local choiceKey = GetRandomValueFromWeightedList( weightedList )
	return tableArg[choiceKey]
end

function GetRandomValueFromWeightedList( tableArg, rng )

	if tableArg == nil then
		return
	end
	local totalWeight = 0
	for value, weight in pairs(tableArg) do
		totalWeight = totalWeight + weight
	end

	local randomWeight = RandomFloat( 0, totalWeight, rng )

	local accWeight = 0
	for value, weight in pairs( tableArg ) do
		if randomWeight >= accWeight and randomWeight < weight + accWeight then
			return value
		end
		accWeight = accWeight + weight
	end
	return nil
end

function IncrementTableValue( tableArg, key, amount )

	if amount == nil then
		amount = 1
	end

	if tableArg[key] == nil then
		tableArg[key] = 0
	end

	tableArg[key] = tableArg[key] + amount

end

function DecrementTableValue( tableArg, key, amount )

	if amount == nil then
		amount = 1
	end

	if tableArg[key] == nil then
		tableArg[key] = 0
	end

	tableArg[key] = tableArg[key] - amount

end

function SetPathValue( source, args )
	local tableToSet = _G
	for i, subTable in ipairs( args.TablePath ) do
		tableToSet = tableToSet[subTable]
	end
	if tableToSet ~= nil then
		if args.Value == "nil" then
			tableToSet[args.Key] = nil
		else
			tableToSet[args.Key] = args.Value
		end
	end
end

function CalcArcDistance( angle1, angle2 )
	local smallAngle = math.min( angle1, angle2 )
	local largeAngle = math.max( angle1, angle2 )
	local difference = largeAngle - smallAngle;
	local supplementOfDifference = 360 - difference;
	local arcDistance = math.min( difference, supplementOfDifference )
    return arcDistance;
end

function CalcAngleDifference( angle1, angle2)
	 return (( angle1 - angle2 + 180 * 3 ) % 360) - 180
end

function LuaGetAngleBetween( x1, y1, x2, y2 )
	local angle = math.atan2( y2 - y1, x2 - x1 )
	if angle < 0 then
		angle = angle + 2 * math.pi
	end
	return math.deg(angle)
end

-- Debug

function ValidateOrderData( dataSet, orderData )
	for itemName, itemData in pairs( dataSet ) do
		if not itemData.DebugOnly and not Contains( orderData, itemName ) then
			DebugAssert({ Text = itemName.." not added to its OrderData" })
		end
	end
end

function ValidatePriorityData( dataSet, priorityData )
	local allPriorities = {}
	for i, priority in ipairs( priorityData ) do
		if type(priority) == "table" then
			for j, subPriority in ipairs( priority ) do
				if not dataSet[subPriority] then
					DebugAssert({ Condition = false, Text = "Priority found with no data: "..subPriority, Owner = "Greg" })
				end
				if allPriorities[subPriority] then
					DebugAssert({ Condition = false, Text = "Duplicate priority found: "..subPriority, Owner = "Greg" })
				end
				allPriorities[subPriority] = true
			end
		else
			if not dataSet[priority] then
				DebugAssert({ Condition = false, Text = "Priority found with no data: "..priority, Owner = "Greg" })
			end
			if allPriorities[priority] then
				DebugAssert({ Condition = false, Text = "Duplicate priority found: "..priority, Owner = "Greg" })
			end
			allPriorities[priority] = true
		end
	end
	for itemName, itemData in pairs( dataSet ) do
		if not itemData.DebugOnly and not allPriorities[itemName] then
			DebugAssert({ Text = "Data found with no priority: "..itemName, Owner = "Greg" })
		end
	end
end

function ValidateRoomSecretData( room )
	local roomData = RoomData[room.Name]
	local objectTypes = { "FishingPoint", "HarvestPoint", "ShovelPoint", "PickaxePoint" }
	for k, objectType in pairs( objectTypes ) do
		local inactiveIds = GetInactiveIdsByType({ Name = objectType })
		local activeIds = GetIdsByType({ Name = objectType })
		local hasObjects = ( not IsEmpty( inactiveIds ) ) or ( not IsEmpty( activeIds ) )
		if hasObjects and not roomData["Has"..objectType] then
			DebugAssert({ Text = roomData.Name.." has a "..objectType.. " but RoomData says it doesn't", Owner = "Eduardo" })
		end
		if not hasObjects and roomData["Has"..objectType] then
			DebugAssert({ Text = roomData.Name.." does not have a "..objectType.. " but RoomData says it does", Owner = "Eduardo" })
		end
	end
end