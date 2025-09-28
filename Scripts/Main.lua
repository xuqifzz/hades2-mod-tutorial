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

_tagsToKill = {}

-- Global return tables
NotifyResultsTable = {}

_coroutinePool = {}

local function coroutineRunner( func, arg1, arg2, arg3, arg4, arg5 )

	while true do
		func( arg1, arg2, arg3, arg4, arg5 )
		func, arg1, arg2, arg3, arg4, arg5 = coroutine.yield( "task done" )
	end

end


local function getCoroutine()
	local co = nil
	if #_coroutinePool > 0 then
		co = table.remove( _coroutinePool )
	else
		co =  coroutine.create( coroutineRunner )
	end
	return co
end

local function returnCoroutine( co )
	assert( coroutine.status( co ) == "suspended" )
	table.insert( _coroutinePool, co )
end

-- syntactic sugar for yield
function wait( duration, tag, persist )
	if duration == nil or duration <= 0 then
		return
	end
	coroutine.yield({ wait = duration, tag = tag or "Untagged", Persist = persist, threadInfo = lastGoodThreadInfo })
end

function waitUnmodified( duration, tag, persist )
	if duration == nil or duration <= 0 then
		return
	end
	coroutine.yield({ wait = duration, unmodifiedTime = true, tag = tag or "Untagged", Persist = persist, threadInfo = lastGoodThreadInfo })
end

function waitUntil( event, tag, persist )
	if verboseLogging and event == nil then
		DebugAssert({ false, Text = "waitUntil called with no name" })
	end
	-- no need to wait, event already happened
	if _events[event] ~= nil then
		_events[event] = nil
		return
	end
	coroutine.yield({ wait = -1, event = event, tag = tag, Persist = persist, threadInfo = lastGoodThreadInfo })
end

function ToLookup( table )
	if table == nil then
		return nil
	end
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

function resume( thread, threadTable, func, arg1, arg2, arg3, arg4, arg5 )

	local status = nil
	local info = nil
	if func ~= nil then
		status, info = coroutine.resume( thread, func, arg1, arg2, arg3, arg4, arg5 )
	else
		status, info = coroutine.resume( thread )
	end
	
	if not status then
		DebugPrint({ Text = info })
		assert( status, info )
	end

	if status and info == "task done" then
		returnCoroutine( thread )
		return
	end
	
	local wait = info and info.wait
	local unmodifiedTime = info and info.unmodifiedTime
	local event = info and info.event

	assert( wait ~= nil, info )

	if status and wait ~= nil then
		if wait > 0 then
			local resumeTime
			if unmodifiedTime then
				resumeTime = wait + _worldTimeUnmodified
			else
				if not SessionMapState.ElapsedTimeMultiplierIgnores[info.tag] then
					wait = wait / _elapsedTimeMultiplier
				end
				resumeTime = wait + _worldTime
			end

			table.insert( threadTable, { resumeTime = resumeTime, unmodifiedTime = unmodifiedTime, thread = thread, tag = info.tag, Persist = info.Persist, threadInfo = info.threadInfo } )
			return
		elseif wait < 0 then
			assert( event )
			local eventListener = _eventListeners[event]
			if eventListener == nil then
				eventListener = {}
			end
			table.insert( eventListener, { Event = event, Thread = thread, Tag = info.tag, Persist = info.Persist, ThreadInfo = info.threadInfo } )
			_eventListeners[event] = eventListener
			return
		end
	end

end

function hurryUpWaitingThreads( tag )
	--debugprint( "hurryUpWaitingThreads("..tag..")" )
	for k,v in ipairs( _threads ) do
		if tag == v.tag then
			if v.unmodifiedTime then
				v.resumeTime = _worldTimeUnmodified
			else
				v.resumeTime = _worldTime
			end
		end
	end
end

local function comboHook( why, line )

	if why == "line" then
		allocTracker( why, line )
	else
		newFunctionCall( why )
	end

end

local function setupDebugHooks( co )
	if verboseLogging and allocTracker then
		debug.sethook( co, comboHook, "crl" )
	elseif verboseLogging then
		debug.sethook( co, newFunctionCall, "cr" )
	elseif allocTracker then
		debug.sethook( co, allocTracker, "l" )
	else
		debug.sethook()
	end
end

function dispatch( func, triggerArgs )
	local co = getCoroutine()
	setupDebugHooks( co )
	resume( co, _threads, func, triggerArgs )
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
	for k, threadInfo in ipairs( _threads ) do
		if threadInfo.tag == tag then
			return true
		end
	end
	return false
end

function HasWaitUntil( notifyName )
	return _eventListeners[notifyName] ~= nil
end

function SetElapsedTimeMultiplier( newTimeMultiplier, tag, args )
	args = args or {}
	local threadTargets = { _threads, _workingThreads }
	for k, threadTarget in ipairs( threadTargets ) do
		for k, threadInfo in ipairs( threadTarget ) do
			if threadInfo.resumeTime then
				if not threadInfo.unmodifiedTime then
					threadInfo.processed = false
				end
				if tag ~= nil then
					threadInfo.processed = true
					if threadInfo.tag == tag then
						threadInfo.processed = false
					end
				end
			end
		end
	end
	for k, threadTarget in pairs( threadTargets ) do
		for k, threadInfo in pairs( threadTarget ) do
			if threadInfo.resumeTime then
				local remainingTime = nil
				if not threadInfo.unmodifiedTime and not threadInfo.processed then
					remainingTime = threadInfo.resumeTime - _worldTime
					if not SessionMapState.ElapsedTimeMultiplierIgnores[threadInfo.tag] then
						remainingTime = remainingTime / newTimeMultiplier
					end
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
	for k, threadInfo in ipairs( _threads ) do
		if threadInfo.tag == tag then
			local resumeTime
			if threadInfo.unmodifiedTime then
				resumeTime = _worldTimeUnmodified + duration
			else
				if SessionMapState.ElapsedTimeMultiplierIgnores[threadInfo.tag] then
					resumeTime = _worldTime + duration
				else
					resumeTime = _worldTime + ( duration / _elapsedTimeMultiplier )
				end
			end
			threadInfo.resumeTime = resumeTime
			foundThread = true
		end
	end

	return foundThread

end

function ManageThreads( source, args )
	killWaitUntilThreads( args.KillWaitUntilThread )
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

function KillNonPersistentThreads()
	for k, threadInfo in ipairs( _workingThreads ) do
		if not threadInfo.Persist then
			--DebugPrint({ Text = "_workingThreads threadInfo.tag = "..threadInfo.tag })
			_tagsToKill[threadInfo.tag] = true
		end
	end
	for k, threadInfo in ipairs( _threads ) do
		if not threadInfo.Persist then
			--DebugPrint({ Text = "_threads threadInfo.tag = "..threadInfo.tag })
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


function thread( func, arg1, arg2, arg3, arg4, arg5, arg6 )
	assert( arg6 == nil, "thread() called with too many arguments" )
	local co = getCoroutine()
	setupDebugHooks( co )
	resume( co, _threads, func, arg1, arg2, arg3, arg4, arg5 )
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

	-- Perf testing data
	--if SessionMapState.OnHitsThisFrame > 5 then
		--DebugPrint({ Text = "SessionMapState.OnHitsThisFrame = "..SessionMapState.OnHitsThisFrame })
	--end
	--if SessionMapState.OnHitsThisFrame > (CurrentRun.MaxFrameHits or 0) then
		--CurrentRun.MaxFrameHits = SessionMapState.OnHitsThisFrame
	--end
	--SessionMapState.OnHitsThisFrame = 0

	--if SessionMapState.RequirementChecksThisFrame > 20 then
		--DebugPrint({ Text = "SessionMapState.RequirementChecksThisFrame = "..SessionMapState.RequirementChecksThisFrame })
	--end
	--if SessionMapState.RequirementChecksThisFrame > (CurrentRun.MaxRequirementChecks or 0) then
		--CurrentRun.MaxRequirementChecks = SessionMapState.RequirementChecksThisFrame
	--end
	--SessionMapState.RequirementChecksThisFrame = 0

	if FrameState.RequestUpdateHealthUI then
		thread( UpdateHealthUI )
	end
	if FrameState.DeferredPresentation ~= nil then
		for functionName, args in pairs( FrameState.DeferredPresentation ) do
			--DebugPrint({ Text = "functionName = "..functionName })
			CallFunctionName( functionName, args )
		end
	end
	TableClear( FrameState )

	if UpdateTimers ~= nil then
		UpdateTimers( elapsed )
	end

	for screenName, screen in pairs( ActiveScreens ) do
		if screen.UpdateFunctionName ~= nil then
			CallFunctionName( screen.UpdateFunctionName, screen, screen.UpdateFunctionArgs, elapsed )
		end
	end

	for k, threadInfo in ipairs( _threads ) do

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

	local temp = _threads;
	_threads = _workingThreads
	_workingThreads = temp
	TableClear( _workingThreads )

	for tagToKill, v in pairs( _tagsToKill ) do
		for i = #_threads, 1, -1 do
			local threadInfo = _threads[i]
			if threadInfo ~= nil and threadInfo.tag == tagToKill then
				table.remove( _threads, i )
			end
		end
		_tagsToKill[tagToKill] = nil
	end

	draw( time, unmodifiedTime )

	local firstValue = RemoveFirstIndexValue( SessionMapState.PresentationQueue )
	if firstValue ~= nil then
		if firstValue.Threaded then
			thread( CallFunctionName, firstValue.FunctionName, firstValue.Source, firstValue.Args )
		else
			CallFunctionName( firstValue.FunctionName, firstValue.Source, firstValue.Args )
		end
	end

end

function draw( time, unmodifiedTime )
	--ProfileZoneStart({ Name = "lua_draw"})
	DeferredCombatPresentation()
	DeferredUIScripts()
	DeferredAudioScripts()
	if not IsEmpty( SessionMapState.DestroyRequests ) then
		Destroy({ Ids = SessionMapState.DestroyRequests })
		TableClear( SessionMapState.DestroyRequests )
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

-- http://snippets.luacode.org/snippets/stack_97
-- Stack (for Lua 5.1)
function NewStack( t )

	local Stack =
	{
		push = function( self, v )
			self[#self+1] = v
		end,

		pop = function( self )
			if #self == 0 then
				return nil
			else
				return table.remove(self)
			end
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
