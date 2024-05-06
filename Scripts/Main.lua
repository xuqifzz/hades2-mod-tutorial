-- global timers
_worldTime = 0
_worldTimeUnmodified = 0
_elapsedTimeMultiplier = 1

-- global threads table
_threads = {}
_workingThreads = {}
_eventListeners = {}
_eventTimeoutRecord = {}
_events = {}
_threadStack = nil
_activeThread = nil

_tagsToKill = {}

-- Global return tables
NotifyResultsTable = {}

-- syntactic sugar for yield
function wait( duration, tag, persist )
	if duration == nil or duration <= 0 then
		return
	end
	--ProfileZoneEnd({})
	coroutine.yield({ wait = duration, tag = tag or "Untagged", Persist = persist, threadInfo = lastGoodThreadInfo })
end

function waitUnmodified( duration, tag, persist )
	if duration == nil or duration <= 0 then
		return
	end
	--ProfileZoneEnd({})
	coroutine.yield({ wait = duration, unmodifiedTime = true, tag = tag or "Untagged", Persist = persist, threadInfo = lastGoodThreadInfo })
end

function waitUntil( event, tag, persist )
	assert( event )
	-- no need to wait, event already happened
	if _events[event] ~= nil then
		_events[event] = nil
		return
	end
	--ProfileZoneEnd({})
	coroutine.yield({ wait = -1, event = event, tag = tag, Persist = persist, threadInfo = lastGoodThreadInfo })
end

function ToLookup( table )
	local lookup = {}
	for key,value in pairs( table ) do
		lookup[value] = true
	end
	return lookup
end

function KeysToList( keysTable )
	local list = {}
	for key, value in pairs( keysTable ) do
		table.insert( list, key )
	end
	return list
end

function OrderedKeysToList( keysTable )
	local list = {}
	for key, value in orderedPairs( keysTable ) do
		table.insert( list, key )
	end
	return list
end

local function EndsWith( String, End )
	return End == '' or string.sub( String, -string.len(End) ) == End
end

DebugFunctionIgnores = ToLookup({
		"dispatch", "resume", "func", "push", "pop", "peek", "newvar",
		"rawset", "for iterator", "pairs", "yield", "on", "isrunning", "create",
		"cmp_multitype", "orderedPairs", "__genOrderedIndex", "orderedNext",
		"unpackTableArgs", "unpackTableArgsInternal",
		"DeepCopyTable",
		"GetStackLevel",
		"GetGlobalRng",
		"Random",
		"RandomNumber",
	})

MainFileFunctions = ToLookup({ "__newindex", "wait", "waitUnmodified", "waitUntil", "notify", "notifyExistingWaiters", "thread", "assert" })


function GetRecursiveTableString( object )
	if object == nil then
		return "nil"
	end
	local tableName = "{"
	for key, value in pairs( object ) do
		local valueString = nil
		if type(value) == "table" then
			valueString = GetRecursiveTableString( value )
		else
			valueString = tostring(value)
		end
		tableName = tableName.." "..key.." = "..valueString..","
	end
	tableName = tableName.." }"
	return tableName
end

function GetTableString( object, name )

	local tableName = "{"
	name = name or object.Name

	if name == "triggerArgs" or name == "args" then
		for key, value in pairs( object ) do
			tableName = tableName.." "..key.." = "..tostring(value)..","
		end
		tableName = tableName.." }"
		return tableName
	end

	local anyCustomInfo = false
	if object.Name ~= nil then
		tableName = tableName.." Name = "..object.Name..","
		anyCustomInfo = true
	end
	if object.ObjectId ~= nil then
		tableName = tableName.." ObjectId = "..object.ObjectId..","
		anyCustomInfo = true
	end
	if object.Id ~= nil then
		tableName = tableName.." Id = "..object.Id..","
		anyCustomInfo = true
	end

	if anyCustomInfo then
		tableName = tableName.." }"
		return tableName
	end

	return tostring( object )

end

function GetStackLevel( startingLevel )

	local level = startingLevel or 1
	while true do
		local info = debug.getinfo(level, "S")
		if info == nil then
			break
		end
		level = level + 1
	end

	return level

end

function SetCurrentLine()

	local threadInfo = nil
	if _threadStack == nil or #_threadStack == 0 then
		threadInfo = debug.getinfo( 1, "Sl" )
		_currentStackLevel = GetStackLevel( 2 )
	else
		threadInfo = debug.getinfo( _activeThread, 1, "Sl" )
		_currentStackLevel = 1
		while true do
			local nextLevelInfo = debug.getinfo( _activeThread, _currentStackLevel + 1, "Sl" )
			if nextLevelInfo == nil then
				break
			end
			_currentStackLevel = _currentStackLevel + 1
		end
	end

	if threadInfo == nil then
		_currentLine = 0
		_currentFileName = ""
		return
	end

	_currentLine = threadInfo.currentline
	_currentFileName = threadInfo.source

end

function findGlobal( f )
	for k, v in pairs( _G ) do
		if v == f then
			return k
		end
	end
end

function resume( thread, threadTable )

	if _threadStack == nil then
		_threadStack = NewStack()
	end
	_threadStack:push( thread )
	_activeThread = thread

	--ProfileZoneStart({ Name = tostring(thread) })
	local status, info = coroutine.resume( thread )
	--ProfileZoneEnd({})
	if not status then
		DebugMessage({ Text = info })
		assert( status, info )
	end
	local wait = info and info.wait
	local unmodifiedTime = info and info.unmodifiedTime
	local event = info and info.event

	_threadStack:pop()
	_activeThread = _threadStack:peek()

	if status and wait ~= nil then
		if wait > 0 then
			local resumeTime
			if unmodifiedTime then
				resumeTime = wait + _worldTimeUnmodified
			else
				wait = wait / _elapsedTimeMultiplier
				resumeTime = wait + _worldTime
			end

			table.insert( threadTable, { resumeTime = resumeTime, unmodifiedTime = unmodifiedTime, thread = thread, tag = info.tag, Persist = info.Persist, threadInfo = info.threadInfo } )
			return "wait"
		elseif wait < 0 then
			assert( event )
			local eventListener = _eventListeners[event]
			if eventListener == nil then
				eventListener = {}
			end
			table.insert( eventListener, { Event = event, Thread = thread, Tag = info.tag, Persist = info.Persist, ThreadInfo = info.threadInfo } )
			_eventListeners[event] = eventListener
			return "waitUntil"
		end
	end

	return "done"

end

function hurryUpWaitingThreads( tag )
	--debugprint( "hurryUpWaitingThreads("..tag..")" )
	for k,v in pairs( _threads ) do
		if tag == v.tag then
			if v.unmodifiedTime then
				v.resumeTime = _worldTimeUnmodified
			else
				v.resumeTime = _worldTime
			end
		end
	end
end

function dispatch( func, triggerArgs )
	local co = coroutine.create( function () func( triggerArgs ) end )

	if verboseLogging then
		debug.sethook( co, newFunctionCall, "cr" )
	end
	local status = resume( co, _threads )

end

-- This will notify an event *and* store the fact that the event has already notified
-- If this event could ever fire more than once, consider Using "notifyExistingWaiters"
function notify( event, wasTimeout )

	_eventTimeoutRecord[event] = wasTimeout
	local eventListeners = _eventListeners[event]
	if eventListeners ~= nil then
		_eventListeners[event] = nil
		for index, listener in pairs( eventListeners ) do
			resume( listener.Thread, _workingThreads )
		end
	else
		_eventListeners[event] = nil
		-- no one is waiting, store it in case someone asks
		_events[event] = true
	end

end

function notifyExistingWaiters( event, wasTimeout )

	if event == nil then
		return
	end

	_eventTimeoutRecord[event] = wasTimeout
	local eventListeners = _eventListeners[event]
	if eventListeners ~= nil then
		_eventListeners[event] = nil
		for index, listener in pairs( eventListeners ) do
			resume( listener.Thread, _workingThreads )
		end
	end

end

function HasThread( tag )
	for k, threadInfo in pairs( _threads ) do
		if threadInfo.tag == tag then
			return true
		end
	end
	return false
end

function SetElapsedTimeMultiplier( newTimeMultiplier, tag )
	local threadTargets = {_threads, _workingThreads}
	for k, threadTarget in pairs( threadTargets ) do
		for k, threadInfo in pairs(threadTarget) do
			if threadInfo.resumeTime then
				if not threadInfo.unmodifiedTime then
					threadInfo.processed = false
				end
				if tag then
					threadInfo.processed = true
					if threadInfo.tag == tag then
						threadInfo.processed = false
					end
				end
			end
		end
	end
	for k, threadTarget in pairs( threadTargets ) do
		for k, threadInfo in pairs(threadTarget) do
			if threadInfo.resumeTime then
				local remainingTime
			
				if not threadInfo.unmodifiedTime and not threadInfo.processed then
					remainingTime = threadInfo.resumeTime - _worldTime
					remainingTime = remainingTime / newTimeMultiplier
					threadInfo.resumeTime = _worldTime + remainingTime
					threadInfo.processed = true
				end
			end
		end
	end
	if not tag then
		_elapsedTimeMultiplier = _elapsedTimeMultiplier * newTimeMultiplier
	end
end

function SetThreadWait( tag, duration )

	if tag == nil then
		return
	end
	local foundThread = false
	for k, threadInfo in pairs( _threads ) do
		if threadInfo.tag == tag then
			local resumeTime
			if threadInfo.unmodifiedTime then
				resumeTime = _worldTimeUnmodified + duration
			else
				resumeTime = _worldTime + ( duration / _elapsedTimeMultiplier )
			end
			threadInfo.resumeTime = resumeTime
			foundThread = true
		end
	end

	return foundThread

end

function killWaitUntilThreads( event )

	if event == nil then
		return
	end

	_eventListeners[event] = nil
end

function killTaggedThreads( tag )

	if tag == nil then
		return
	end

	-- Queue for after the next update
	_tagsToKill[tag] = true

end

function killAllWaitingThreads()
	_threads = {}
	_workingThreads = {}
	_eventListeners = {}
	_events = {}
end

function KillNonPersistentThreads()
	for k, threadInfo in pairs( _threads ) do
		if not threadInfo.Persist then
			_tagsToKill[threadInfo.tag] = true
		end
	end
	for k, eventListener in pairs( _eventListeners ) do
		for index, listener in pairs( eventListener ) do
			if not listener.Persist then
				_eventListeners[k] = nil
			end
		end
	end
end


function thread( func, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, ... )
	local args = { arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, ... }
	local co = coroutine.create( function () func( unpackTableArgs(args) ) end )

	if verboseLogging then
		debug.sethook( co, newFunctionCall, "cr" )
	end
	local status = resume( co, _threads )

end

-- Based off reference impl. from https://www.lua.org/pil/5.1.html
-- Handles tables with nil elements
function unpackTableArgs(tbl)
	local startIndex = 1
	local accumulator = 0
	local length = 0
	for _ in pairs(tbl) do
		length = length + 1
	end
	if length == 0 then
		return nil
	end
	return unpackTableArgsInternal(tbl, startIndex, accumulator, length)
end

function unpackTableArgsInternal(tbl, index, accumulator, tbl_count)
	if accumulator == tbl_count then
		return nil
	end
	if tbl[index] ~= nil then
		accumulator = accumulator + 1
	end
	return tbl[index], unpackTableArgsInternal(tbl, index + 1, accumulator, tbl_count)
end

function update( time, unmodifiedTime )

	local elapsed = time - _worldTime
	_worldTime = time
	_worldTimeUnmodified = unmodifiedTime

	SessionMapState.SecondaryEffectsThisFrame = 0
	if SessionMapState.OnHitsThisFrame > 5 then
		DebugPrint({ Text = "SessionMapState.OnHitsThisFrame = "..SessionMapState.OnHitsThisFrame })
	end
	if SessionMapState.OnHitsThisFrame > (CurrentRun.MaxFrameHits or 0) then
		CurrentRun.MaxFrameHits = SessionMapState.OnHitsThisFrame
	end
	SessionMapState.OnHitsThisFrame = 0

	if SessionMapState.RequirementChecksThisFrame > 20 then
		DebugPrint({ Text = "SessionMapState.RequirementChecksThisFrame = "..SessionMapState.RequirementChecksThisFrame })
	end
	if SessionMapState.RequirementChecksThisFrame > (CurrentRun.MaxRequirementChecks or 0) then
		CurrentRun.MaxRequirementChecks = SessionMapState.RequirementChecksThisFrame
	end
	SessionMapState.RequirementChecksThisFrame = 0

	SessionMapState.FrameFlags = {}

	for i, writeInfo in ipairs( SessionMapState.DeferredTableWrite ) do
		_G[writeInfo.TableName][writeInfo.Key] = writeInfo.Value
	end
	SessionMapState.DeferredTableWrite = {}

	if UpdateTimers ~= nil then
		UpdateTimers( elapsed )
	end

	for screenName, screen in pairs( ActiveScreens ) do
		if screen.UpdateFunctionName ~= nil then
			CallFunctionName( screen.UpdateFunctionName, screen, screen.UpdateFunctionArgs, elapsed )
		end
	end

	for k, threadInfo in pairs( _threads ) do

		local checkTime = _worldTime
		if threadInfo.unmodifiedTime then
			checkTime = _worldTimeUnmodified
		end

		if threadInfo ~= nil and threadInfo.tag ~= nil and _tagsToKill[threadInfo.tag] then
			-- Don't resume a thread that is already slated to be killed - simply leave it out of the next _workingThreads
		elseif coroutine.status( threadInfo.thread ) ~= "dead" and threadInfo.resumeTime < checkTime then
			resume( threadInfo.thread, _workingThreads )
		else
			table.insert( _workingThreads, threadInfo )
		end

	end

	_threads = _workingThreads
	_workingThreads = {}

	for tagToKill, v in pairs( _tagsToKill ) do
		for i = #_threads, 1, -1 do
			local threadInfo = _threads[i]
			if threadInfo ~= nil and threadInfo.tag == tagToKill then
				table.remove( _threads, i )
			end
		end
	end
	_tagsToKill = {}

	draw( time, unmodifiedTime )

end

function draw( time, unmodifiedTime )
	--ProfileZoneStart({ Name = "lua_draw"})
	DeferredCombatPresentation()
	DeferredUIScripts()
	DeferredAudioScripts()
	if not IsEmpty( SessionMapState.DestroyRequests ) then
		Destroy({ Ids = SessionMapState.DestroyRequests })
		SessionMapState.DestroyRequests = {}
	end
	--ProfileZoneEnd({})
end

--[[
	LoadMap needs to yield since the actual load doesn't happen until the next frame
	and we need to prevent following statements from executing until the map is loaded.
	C/C# functions can't yield (gives a metamethod/C-call boundary erro).  Instead, LoadMap
	is actually defined in Main.lua which calls LuaMapInternal and then wait(0.01).
]]--
function LoadMap( argTable )
	AddInputBlock({ Name = "LoadMap" })
	KillNonPersistentThreads()
	--for threadName, v in pairs( _tagsToKill ) do
		--DebugPrint({ Text = "PreKill: threadName = "..threadName })
	--end
	wait( 0.02, "KillNonPersistentThreads", true ) -- Need to let an update occur for the non-persistent threads to die before doing the map load and the kills don't leak into the next map
	--for threadName, v in pairs( _tagsToKill ) do
		--DebugPrint({ Text = "PostKill: threadName = "..threadName })
	--end
	LoadMapInternal( argTable )
	wait( 0.02, "MapLoad", true )
	--for threadName, v in pairs( _tagsToKill ) do
		--DebugPrint({ Text = "PostLoad threadName = "..threadName })
	--end
	RemoveInputBlock({ Name = "LoadMap" })
end

function eat_true( t, ... )
	assert(t, ...)
	return ...
end

function printData( data, len )
	if len > #data then
		len = #data
	end

	local count = len-100
	for i = 1,count,100 do
		local e = i+100
		local str = "["..i.."-"..e.."]: "
		for j = i,e do
			str = str..data:byte(j,j).." "
		end
		debugprint( str )
	end

	local str = "["..count.."-"..len.."]: "
	for i = count,len do
		str = str..data:byte(i,i).." "
	end
	debugprint( str )
end

GlobalSaveWhitelist =
{
	"GameState",
	"StoredGameState",
	"CurrentRun",
	"MapState",
	"AudioState",
	"CurrentHubRoom",
	"CodexStatus",
	"_worldTime",
	"_worldTimeUnmodified",
	"Revision",
	"NextSeeds",
}

RunSaveWhitelist = ToLookup(
{
	"CurrentRoom",
	"EndingRoomName",
	"TotalTime",
	"GameplayTime",
	"EnemyUpgrades",
	"MetaPointsCache",
	"VisibleTraitCountCache",
	"MetaUpgradeCostCache",
	"ShrinePointsCache",
	"EasyModeLevel",
	"RunDepthCache",
	"BiomeDepthCache",
	"RoomCountCache",
	"Cleared",
	"ActiveBounty",
	"BountyCleared",
	"WeaponsCache",
	"TraitCache",
	"TraitRarityCache",
	"EndingKeepsakeName",
	"MetaUpgradeCache",
	"ShrineUpgradesCache",
	"BiomeStateChangeCount",
	"BiomesReached",
	"TextLinesRecord",
	"RunClearMessage",
	"SpawnRecord",
	"CauldronWitchcraftOccurred",
	"EncountersOccurredCache",
})

RoomSaveBlacklist = ToLookup(
{
	--"ObjectStates",
	"ThreadedEvents",
	"DistanceTriggers",
	"EnterVoiceLines",
	"ExitVoiceLines",
	"InspectPoints",
})

EncounterSaveBlacklist = ToLookup(
{
	--"SpawnWaves",
	"DistanceTriggers",
	"ExitVoiceLines",
	"StartRoomUnthreadedEvents",
	"WrappingData",
})

AudioSaveWhitelist = ToLookup(
{
	"MusicName",
	"MusicSection",
	"MusicSectionStartDepth",
	"MusicActiveStems",
	"MusicMutedStems",
	"AmbientTrackName",
	"AmbientMusicSource",
})

function StripRunForSave( run )

	for key, value in pairs( run ) do
		if not RunSaveWhitelist[key] then
			run[key] = nil
		end
	end
end

function StripRoomsForSave( run )

	if run.RoomHistory ~= nil then
		for roomIndex, room in pairs( run.RoomHistory ) do
			if roomIndex ~= TableLength( run.RoomHistory ) then -- Don't strip prevRoom
				for key, value in pairs( room ) do
					if RoomSaveBlacklist[key] then
						room[key] = nil
					end
				end
				if room.Encounter ~= nil then
					for encounterKey, encounterValue in pairs( room.Encounter ) do
						if EncounterSaveBlacklist[encounterKey] then
							room.Encounter[encounterKey] = nil
						end
					end
				end
			end
		end
	end

end

function Save()

	-- Iris specific stripping
	StripRoomsForSave( CurrentRun )
	for runIndex, run in pairs( GameState.RunHistory ) do
		StripRoomsForSave( run )
		if runIndex ~= TableLength( GameState.RunHistory ) then -- Don't strip prevRun
			StripRunForSave( run )
		end
	end

	local sessionAudioState = ShallowCopyTable( AudioState )
	for key, value in pairs( AudioState ) do
		if not AudioSaveWhitelist[key] then
			AudioState[key] = nil
		end
	end

	local saveTable = {}
	for i, key in ipairs( GlobalSaveWhitelist ) do

		local value = _G[key]
		if value ~= nil then
			local valueType = type(value)
			if valueType ~= "function" and valueType ~= "userdata" and valueType ~= "thread" then
				if verboseLogging and valueType == "table" then
					ValidateLoops( key, value )
					ValidateTypes( value, key, 1, tostring(key) )
					--CalcTotalNumEntries( value, key )
				end
				saveTable[key] = value
			end
		end

	end

	_saveData = assert( luabins.save( saveTable ) )

	AudioState = sessionAudioState

end

function ValidateTypes( table, tableName, depth, trace )

	for tableKey, tableValue in pairs( table ) do
		if type(tableValue) == "table" then
			--if depth > 50 then
				--DebugAssert({ Condition = false, Text = "trace = "..trace })
			--end
			ValidateTypes( tableValue, tableKey, depth + 1, trace.."."..tostring(tableKey) )
		elseif type(tableValue) == "number" or type(tableValue) == "boolean" or type(tableValue) == "string" then
			-- Fine primitive type
		else
			--table[tableKey] = nil
			trace = trace.."."..tostring(tableKey)
			DebugPrint({ Text = "Saving bad type: "..trace, LogOnly = true })
			DebugAssert({ Condition = false, Text = "Saving bad type: "..trace })
		end
	end

end

function DebugLoad( key, value )
	local t = type(value)
	if t == "boolean" then
		debugprint( "restoring "..key.." = "..(value and "true" or "false") )
	elseif t == "table" then
		debugprint( "restoring "..key.." = "..pickle(value) )
	elseif t == nil then
		debugprint( "restoring "..key.." = nil" )
	else
		debugprint( "restoring "..key.." = "..value )
	end
end

function Load( data )
	local savedValues = eat_true( luabins.load( data ) )
	for key, value in pairs( savedValues ) do
		--DebugPrint({ Text = "loading key = "..key })
				_G[key] = value
			end
		end


-- http://snippets.luacode.org/snippets/stack_97
-- Stack (for Lua 5.1)
function NewStack( t )

	local Stack =
	{
		push = function( self, ... )
			for _, v in ipairs{...} do
				self[#self+1] = v
			end
		end,

		pop = function( self, num )
			local num = num or 1
			if num > #self then
				error("underflow in NewStack-created stack")
			end
			local ret = {}
			for i = num, 1, -1 do
				ret[#ret+1] = table.remove(self)
			end
			return table.unpack(ret)
		end,

		peek = function( self )
			if #self == 0 then
				return nil
			else
				return self[#self]
			end
		end
	}

	return setmetatable( t or {}, {__index = Stack} )

end

----------------------------------------------
-- Pickle.lua
-- A table serialization utility for lua
-- Steve Dekorte, http://www.dekorte.com, Apr 2000
-- Freeware
----------------------------------------------

function pickle( t )
	return Pickle:clone():pickle_(t)
end

Pickle =
{
	clone = function (t) local nt={}; for i, v in pairs(t) do nt[i]=v end return nt end
	}

	function Pickle:pickle_( root )

		if type(root) ~= "table" then
			error("can only pickle tables, not ".. type(root).."s")
		end

		self._tableToRef = {}
		self._refToTable = {}
		local savecount = 0
		self:ref_(root)
		local s = ""

		for index, value in pairs( root ) do
			if type(value) ~= "function" then
				s = string.format( "%s[%s]=%s,\n", s, self:value_(index), self:value_(value) )
			end
		end

		return string.format("{%s}", s)

	end

	function Pickle:value_( value )

		local vtype = type( value )

		if vtype == "string" then
			return string.format("%q", value)
		elseif vtype == "number" then
			return value
		elseif vtype == "boolean" then
			if value then
				return "true"
			else
				return "false"
			end
		elseif vtype == "table" then
			return self:pickle_(value)
		else
			--error("pickle a "..type(value).." is not supported")
		end

	end

	function Pickle:ref_(t)
		local ref = self._tableToRef[t]
		if not ref then

			if t == self then
				error("can't pickle the pickle class")
			end

			table.insert(self._refToTable, t)
			ref = #self._refToTable
			self._tableToRef[t] = ref

		end
		return ref
	end

----------------------------------------------
-- unpickle
----------------------------------------------

	function unpickle(s)
		if type(s) ~= "string" then
			error("can't unpickle a "..type(s)..", only strings")
		end
		local gentables = load("return "..s)
		local tables = gentables()

		for tnum = 1, #tables do
			local t = tables[tnum]
			local tcopy = {}; for i, v in pairs(t) do tcopy[i] = v end
			for i, v in pairs(tcopy) do
				local ni, nv
				if type(i) == "table" then ni = tables[i[1]] else ni = i end
				if type(v) == "table" then nv = tables[v[1]] else nv = v end
				t[i] = nil
				t[ni] = nv
			end
		end
		return tables[1]
	end

----------------------------------------------
-- PickleTest.lua
-- Testing code for Pickle.lua
-- Steve Dekorte, http://www.dekorte.com, Apr 2000
----------------------------------------------

--dofile("Pickle.lua")

--[[
function test()
  local t = {
	name = "foo",
	ssn=123456789,
	contact = { phone = "555-1\r\n212", email = "foo@foo.com"},
  }
  t.t = { 1 }
  t.contact.loop = t
  t["a b"] = "zzz"
  t[10] = 11
  t[t] = 5
  t[t.t] = 10

  local s = pickle(t)
  print("pickled string:\n\n"..s)

  local ut = unpickle(s)
  print("pickled string:\n\n"..pickle( ut ))
  print("loop test:   "); eq(ut == ut.contact.loop)
  print("subitem test:"); eq(ut.contact.phone == t.contact.phone)
  print("number value:"); eq(ut.ssn == t.ssn)
  print("number index:"); eq(ut[10] == 11)
  print("table index: "); eq(ut[ut] == 5)
end
--]]

	function eq(b)
		if b then print(" succeeded") else print(" failed") end
	end

-- Function Serialization
-- http://lua-users.org/lists/lua-l/2009-11/msg00533.html

	function char( c )
		return ("\\%03d"):format(c:byte())
	end

	function serializeString( s )
		return ('"%s"'):format(s:gsub("[^ !#-~]", char))
	end

-- Split a string into a list of string with sep as seperator
	function string_split(str, sep)
		local sep, fields = sep or ":", {}
		local pattern = string.format("([^%s]+)", sep)
		str:gsub(pattern, function(c) fields[#fields+1] = c end)
		return fields
	end

-- Returns a new table with the same contents as the passed table.
	function shallow_copy(t)
		local t2 = {}
		for k,v in pairs(t) do
			t2[k] = v
		end
		return t2
	end

	function Using( usingName )
	end

	function print_r( t )

		local print_r_cache={}
		local function sub_print_r(t,indent)
			if (print_r_cache[tostring(t)]) then
				print(indent.."*"..tostring(t))
			else
				print_r_cache[tostring(t)]=true
				if (type(t)=="table") then
					for pos,val in pairs(t) do
						if (type(val)=="table") then
							print(indent.."["..pos.."] => "..tostring(t).." {")
							sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
							print(indent..string.rep(" ",string.len(pos)+6).."}")
						elseif (type(val)=="string") then
							print(indent.."["..pos..'] => "'..val..'"')
						else
							print(indent.."["..pos.."] => "..tostring(val))
						end
					end
				else
					print(indent..tostring(t))
				end
			end
		end
		if (type(t)=="table") then
			print(tostring(t).." {")
			sub_print_r(t,"  ")
			print("}")
		else
			sub_print_r(t,"  ")
		end
		print()
	end
