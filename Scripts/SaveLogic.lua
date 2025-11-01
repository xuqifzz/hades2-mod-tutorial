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
	"RevisionFirstSave",
	"NextSeeds",
}

PermanentRunSaveWhitelist = ToLookup(
{
	"RunResult",
})

MainRunSaveWhitelist = ToLookup(
{
	"WeaponsCache",
	"TraitCache",
	"MetaUpgradeCostCache",
	"ShrineUpgradesCache",
	"ShrinePointsCache",
	"KeepsakeCache",
	"KilledByName",
	"EasyModeLevel",
	"EndingRoomName",
	"GameplayTime",
	"ActiveBounty",
	"VictoryMessage",
	"UsedStoryReset",
})

RecentRunSaveWhitelist = ToLookup(
{
	"Cleared",
	"BountyCleared",
	"BiomeStateChangeCount",
})

RecentRunTablesSaveWhitelist = ToLookup(
{
	"EncountersOccurredCache",
	"RoomCountCache",
	"RoomsEntered",
	"SpawnRecord",
	"TextLinesRecord",
	"WorldUpgradesAdded",
	"UseRecord",
	"SpeechRecord",
	"EnemyKills",
	"EncounterClearStats",
	"BiomesReached",
	"ResourcesGained",
	"WeaponsUnlocked",
	"NemesisTakeExitRecord",
	"SpecialInteractRecord",
})

RoomSaveWhitelist = ToLookup(
{
	"Name",
	"NumHarvestPoints",
	"NumShovelPoints",
	"NumPickaxePoints",
	"NumExorcismPoints",
	"NumFishingPoints",
	"ForceSecretDoor",
	"EncountersOccurredCache",
	"UseRecord",
	"TextLinesRecord",
	"SurfaceShop",
	"OlympusEagleSpawn",
	"RoomSetName",
	"Reward",
	"RewardStoreName",
	"ChosenRewardType",
	"OfferedRewards",
	"ExitDoorRooms",
	"TimesVisited",
	"UnavailableDoors",
	"ExitsUnlocked",
	"NextRoomSet",
	"Encounter",
	"Encounters",
	"SaveWhitelist",
})

EncounterSaveWhitelist = ToLookup(
{
	"Name",
	"NemesisShopping",
	"HeraclesShopping",
	"RewardStoreName",
	"ObstaclesToRestore",
})

MapStateWhitelist = ToLookup(
{
	"OfferedExitDoors",
	"ShipWheels",
	"SpawnPoints",
})

AudioSaveWhitelist = ToLookup(
{
	"MusicName",
	"MusicSection",
	"MusicSectionStartDepth",
	"MusicActiveStems",
	"MusicMutedStems",
	"AmbientTrackName",
})

function StripRunForSave( run, runsBackFromCurrent )

	if runsBackFromCurrent <= 0 then
		return -- Don't strip prevRun
	end

	for key, value in pairs( run ) do
		if not PermanentRunSaveWhitelist[key] and ( runsBackFromCurrent > 500 or not MainRunSaveWhitelist[key] ) and ( runsBackFromCurrent > 10 or (not RecentRunSaveWhitelist[key] and not RecentRunTablesSaveWhitelist[key]) ) then
			run[key] = nil
		end
	end
end

function StripRoomsForSave( run, keepLastRoom )

	if run == nil then
		return
	end

	if run.RoomHistory ~= nil then
		for roomIndex, room in ipairs( run.RoomHistory ) do
			if not keepLastRoom or roomIndex ~= TableLength( run.RoomHistory ) then
				for roomKey, roomValue in pairs( room ) do
					if not RoomSaveWhitelist[roomKey] and ( room.SaveWhitelist == nil or not room.SaveWhitelist[roomKey] ) then
						room[roomKey] = nil
					end
				end
				if room.Encounter ~= nil then
					for encounterKey, encounterValue in pairs( room.Encounter ) do
						if not EncounterSaveWhitelist[encounterKey] then
							room.Encounter[encounterKey] = nil
						end
					end
				end
				if room.Encounters ~= nil then
					for encounterIndex, encounter in ipairs( room.Encounters ) do
						for encounterKey, encounterValue in pairs( encounter ) do
							if not EncounterSaveWhitelist[encounterKey] then
								encounter[encounterKey] = nil
							end
						end
					end
				end
			end
		end
	end
end


function Save()

	-- Iris specific stripping
	StripRoomsForSave( CurrentRun, true )
	local runCount = #GameState.RunHistory
	for runIndex, run in ipairs( GameState.RunHistory ) do
		StripRunForSave( run, runCount - runIndex )
		if run.RoomHistory ~= nil then
			StripRoomsForSave( run, false )
		end
	end

	local sessionMapState = MapState
	MapState = {}
	for key, value in ipairs( MapStateWhitelist ) do
		MapState[key] = sessionMapState[key]
	end

	local sessionAudioState = ShallowCopyTable( AudioState )
	for key, value in pairs( AudioState ) do
		if not AudioSaveWhitelist[key] then
			AudioState[key] = nil
		end
	end

	local saveTable = {}
	--local totalKeys = 0
	for i, key in ipairs( GlobalSaveWhitelist ) do
		local value = _G[key]
		if value ~= nil then
			local valueType = type(value)
			if valueType ~= "function" and valueType ~= "userdata" and valueType ~= "thread" then
				if verboseLogging and valueType == "table" then
					ValidateLoops( key, value )
					ValidateTypes( value, key, 1, tostring(key) )
					--totalKeys = totalKeys + CalcTotalNumEntries( value, key )
				end
				saveTable[key] = value
			end
		end
	end

	--DebugPrint({ Text = "totalKeys =  "..totalKeys })

	--_saveData = assert( luabins.save( saveTable ) )
	assert( savebinary( saveTable ))

	AudioState = sessionAudioState
	MapState = sessionMapState

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

function Load( data )
	local savedValues = eat_true( luabins.load( data ) )
	for key, value in pairs( savedValues ) do
		--DebugPrint({ Text = "loading key = "..key })
		_G[key] = value
	end
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
