Import "UtilityLogic.lua"

Import "ColorData.lua"
Import "RunData.lua"

local fullGame = (GetConfigOptionValue({ Name = "DemoMode" }) == false)

Import "UIPresentation.lua"
Import "UILogic.lua"
Import "HUDLogic.lua"
Import "EventPresentation.lua"
if fullGame then
	Import "EventPresentation_Late.lua"
end
Import "AudioLogic.lua"
Import "AudioPresentation.lua"
Import "NarrativeLogic.lua"
Import "GhostData.lua"
Import "CodexLogic.lua"
Import "CodexPresentation.lua"
Import "Debug.lua"
Import "PlayerAIData.lua"
Import "LocalizationData.lua"

Import "EnemyAILogic.lua"
Import "UpgradeLogic.lua"
Import "FishingLogic.lua"
Import "FishingPresentation.lua"
Import "HarvestLogic.lua"
Import "HarvestPresentation.lua"
Import "PowersPresentation.lua"
Import "GardenLogic.lua"
Import "GardenPresentation.lua"
Import "GamePhaseLogic.lua"
Import "BiomeStateLogic.lua"
Import "BiomeStatePresentation.lua"
Import "KeepsakeLogic.lua"
Import "StoreLogic.lua"
Import "SurfaceShopLogic.lua"
Import "SurfaceShopPresentation.lua"
Import "SellTraitLogic.lua"
Import "MarketLogic.lua"
Import "MarketPresentation.lua"
Import "MailboxLogic.lua"
Import "MailboxPresentation.lua"
Import "GhostAdminLogic.lua"
Import "GhostAdminPresentation.lua"
Import "CosmeticsLogic.lua"
Import "CosmeticsPresentation.lua"
Import "CostumeLogic.lua"
Import "CostumePresentation.lua"
Import "WeaponShopLogic.lua"
Import "WeaponShopPresentation.lua"
Import "FamiliarShopLogic.lua"
Import "FamiliarShopPresentation.lua"
Import "QuestLogLogic.lua"
Import "QuestPresentation.lua"
Import "BountyLogic.lua"
Import "BountyPresentation.lua"
Import "GameStatsLogic.lua"
Import "GameStatsPresentation.lua"
Import "RunHistoryLogic.lua"
Import "RunHistoryPresentation.lua"
Import "ShrineLogic.lua"
Import "ShrinePresentation.lua"
Import "AchievementLogic.lua"
Import "BadgePresentation.lua"
Import "ResourcePresentation.lua"
Import "ResourceLogic.lua"
Import "SpellPresentation.lua"
Import "SpellLogic.lua"
Import "RunClearLogic.lua"
Import "RoomPresentation.lua"
if fullGame then
	Import "RoomPresentation_Late.lua"
end
Import "EncounterPresentation.lua"
if fullGame then
	Import "EncounterPresentation_Late.lua"
end
Import "RunLogic.lua"
Import "RewardLogic.lua"
Import "RewardPresentation.lua"
Import "CombatLogic.lua"
Import "EffectPresentation.lua"
Import "ManaPresentation.lua"
Import "MetaUpgradeCardScreenPresentation.lua"
Import "FamiliarPresentation.lua"
Import "CombatPresentation.lua"
Import "WeaponPresentation.lua"
Import "GhostLogic.lua"
Import "TraitTrayLogic.lua"
Import "WeaponUpgradeLogic.lua"
Import "BoonInfoLogic.lua"
Import "DeathLoopLogic.lua"
Import "HubPresentation.lua"
Import "FlashbackPresentation.lua"
Import "TradePresentation.lua"

-- Iris

RoomThreadName = "RoomThread"

-- SessionStateInit
SessionState = {}
SessionState.MapLoads = 0
SessionState.GlobalCooldowns = {}
SessionState.GlobalCounts = {}
SessionState.GameplaySlows = {}
SessionState.PlayerGameplaySlows = {}
SessionState.PlayerControlBlocks = {}
SessionState.PlayerMoveBlocks = {}
SessionState.ValidProjectileIds = {}
SessionState.PropertyChangeList = { WeaponChanges = {}, ProjectileChanges = {}, EffectChanges = {}}

OnPreThingCreation
{
	function( triggerArgs )

		--ValidateThreadLeaks()
		SessionState.MapLoads = SessionState.MapLoads + 1
		UpdateConfigOptionCache()
		if GetConfigOptionValue({ Name = "EditingMode" }) then
			SessionState.BlockSpawns = true
		end
		RandomInit()
		GameStateInit()
		RunStateInit()
		SessionMapStateInit()
		DoPatches()
		SetupMap()
		NarrativeInit()
		CodexInit()
		UnloadVoiceBanks({})

		local mapName = triggerArgs.name
		local roomData = RoomData[mapName]
		if GameState == nil then
			StartNewGame( mapName )
			if roomData == nil or not roomData.GameStart then
				GameState.IllegalConversationModification = true
				DebugPrint({ Text = "Illegal DirectLoad.  Saving disabled." })
			end
		end

		if roomData == nil then
			if CurrentRun.Hero.IsDead then 
				return
			else
				DebugAssert({ Text = "No RoomData definition for "..mapName })
			end
		end

		ResetUI()

		if CurrentRun.CurrentRoom ~= nil then
			if GetConfigOptionValue({ Name = "ResetRoomData" }) then
				CurrentRun.CurrentRoom.Flipped = false
			end
			if GetConfigOptionValue({ Name = "ForceFlipMapThings" }) then
				CurrentRun.CurrentRoom.Flipped = true
			end
		end
		if CurrentRun ~= nil and CurrentRun.CurrentRoom.Flipped ~= nil and CurrentRun.CurrentRoom.Name == mapName then
			SetConfigOption({ Name = "FlipMapThings", Value = CurrentRun.CurrentRoom.Flipped })
		end

		if GetConfigOptionValue({ Name = "DumpRunStatsOnLoad" }) then
			DumpGameStateToFile()
		end

		LoadActiveBountyPackages()

	end
}

OnAnyLoad
{
	function( triggerArgs )

		AudioStateInit( triggerArgs )
		MapStateInit()

		-- @todo Move into MapState
		ActiveEnemies = {}
		RequiredKillEnemies = {}
		ActiveGroupAIs = {}
		SurroundEnemiesAttacking = {}
		MapState.RoomRequiredObjects = {}
		LootObjects = {}
		CombatPresentationDeferredHealthBars = {}

		--ValidateIdLeaks( "_G", _G )
		--ValidateLoops( "_G", _G )
		ValidateItemCategories()
		ValidateRoomSets()
		ValidateRequirements()

		local mapName = triggerArgs.name
		roomData = RoomData[mapName]

		if roomData ~= nil then
			RunEventsGeneric( roomData.PreObstacleSetupEvents, CurrentRun.CurrentRoom )
		end

		if DeferredObstacleInitialization ~= nil then
			for id, name in pairs( DeferredObstacleInitialization ) do
				local obstacleData = ObstacleData[name]
				local obstacle = DeepCopyTable( obstacleData )
				obstacle.ObjectId = id
				SetupObstacle( obstacle, true )
			end
			DeferredObstacleInitialization = nil
		end
		SessionMapState.DeferredObstacleInitializationFinished = true

		CheckQuestStatus({ Silent = true })
		thread( CheckProgressAchievements )
		
		RemoveInputBlock({ Name = "MapLoad" })
		RemoveTimerBlock( CurrentRun, "MapLoad" )

		if roomData ~= nil then
			LoadCurrentRoomVoiceBanks( CurrentRun.CurrentRoom )
			if CurrentRun.CurrentRoom.ExitsUnlocked then
				RestoreUnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
			else
				StartRoom( CurrentRun, CurrentRun.CurrentRoom )
			end
			return
		end

		if GameState == nil then
			-- Support debug DirectLoad
			StartNewGame()  
			CurrentRun.Hero.IsDead = true
			GameState.IllegalConversationModification = true
		end

		if mapName == GameData.HubMapName then
			if CurrentHubRoom ~= nil and CurrentHubRoom.Name ~= GameData.HubMapName then
				DeathAreaRoomTransition( HubRoomData[mapName] )
			else
				StartDeathLoop( CurrentRun )
			end
		elseif HubRoomData[mapName] ~= nil then
			DeathAreaRoomTransition( HubRoomData[mapName] )
		end

	end
}

function LoadCurrentRoomVoiceBanks(currentRoom)
	LoadVoiceBanks("MelinoeField")
	local voiceBanks = { currentRoom.Name, currentRoom.ForceLootName, currentRoom.ChosenRewardType, currentRoom.Encounter.Name, currentRoom.Encounter.LootAName, currentRoom.Encounter.LootBName }
	for _, name in pairs(voiceBanks) do
		LoadVoiceBanks( GetSpeakerName( name ) )
	end
end


function MapStateInit()
	MapState = {}
	MapState.SimSpeedChanges = {}
	MapState.PhasingFlags = {}
	MapState.FullManaAtFireStart = {}
	MapState.FullManaVolleys = {}
	MapState.HeroNotStopsProjectile = {}
	MapState.ActiveObstacles = {}
	MapState.AggroedUnits = {}
	MapState.OfferedExitDoors = {}
	MapState.OfferedRewardPreviewTypes = {}
	MapState.TauntTargetIds = MapState.TauntTargetIds or {}
	MapState.RewardPointsUsed = MapState.RewardPointsUsed or {}
	MapState.OptionalRewards = MapState.OptionalRewards or {}
	MapState.ShipWheels = MapState.ShipWheels or {}
	MapState.Flags = {}
	MapState.GroupHealthWaiters = {}
	MapState.CombatUIHide = {}
	MapState.Reticles = {}
	MapState.SandwichCount = 0
	MapState.LeapCritVolleys = {}
	MapState.SprintShields = 0
	MapState.BossShieldTriggers = 0
	MapState.ExCastCount = 0
	MapState.ExShieldTriggers = 0
	MapState.ExShieldWeapons = {}
	MapState.ChargedManaWeapons = {}
	MapState.TorchFireIndex = 1
	MapState.LastBlinkTimeUnmodified = 0
	MapState.HexCooldownDodgeChance = 0
	MapState.InvisibleVolleys = {}
	MapState.SpellSummons = {}
	MapState.MapSpeedMultiplier = 1
	MapState.WeaponCharge = {}
	MapState.MoneyUI = 
	{ 	
		LastValue = GetResourceAmount( "Money" ),
		Floating = 0,
		RunningThreads = 0,
	}
	-- Hard-coded buckets
	MapState.SpawnPoints = GetIds({ Name = "SpawnPoints" })
end

function SessionMapStateInit()
	SessionMapState = {}
	SessionMapState.SpawnPointsUsed = {}
	SessionMapState.CastAttachedProjectiles = {}
	SessionMapState.AmmoVolleys = {}
	SessionMapState.LobLock = {}
	SessionMapState.SpecialLock = {}
	SessionMapState.BlinkLock = {}
	SessionMapState.WeaponSpeedMultipliers = {}
	SessionMapState.ChargeStageManaSpend = {}
	SessionMapState.FirstHitRecord = {}
	SessionMapState.ProjectileChargeStageReached = {}
	SessionMapState.BurstCounter = 0
	SessionMapState.TimedBuff = 0
	SessionMapState.DaggerLastHit = 0
	SessionMapState.SpellMultiuseCount = 0
	SessionMapState.DamageShareRecord = {}
	SessionMapState.WeaponSpawnPointsUsed = {}
	SessionMapState.PerfectCritChance = {}
	SessionMapState.MarkedEnemies = {}
	SessionMapState.QueuedVoiceLines = SessionMapState.QueuedVoiceLines or {}
	SessionMapState.SurfaceShopSpawnPointsUsed = {}
	SessionMapState.ProjectilesCarryingSpawns = {}
	SessionMapState.ProjectileSpawnRecord = {}
	SessionMapState.ExpireOldestProjectiles = {}
	SessionMapState.ExpireOldestProjectilesOrder = {}
	SessionMapState.SecondaryEffectsThisFrame = 0
	SessionMapState.OnHitsThisFrame = 0
	SessionMapState.RequirementChecksThisFrame = 0
	SessionMapState.DoorTextCount = 0
	SessionMapState.FrameFlags = {}
	SessionMapState.DestroyRequests = {}
	SessionMapState.PlayingCues = SessionMapState.PlayingCues or {}
	SessionMapState.BlockWeaponFailedToFire = {}
	SessionMapState.HUDTraitsShown = {}
	SessionMapState.SpellHealWindow = 0
	SessionMapState.LifeOnKillRecord = SessionMapState.LifeOnKillRecord or {}
	SessionMapState.DeferredTableWrite = {}
end

function ValidateIdLeaks( trace, tableToCheck )
	if tableToCheck.ObjectId ~= nil or tableToCheck.Id ~= nil then
		DebugAssert({ Condition = false, Text = "Id leak found in "..trace })
	end
	local idLeakIgnores = ToLookup({ "InspectPoints", "RunHistory", "RoomHistory", "Hero", "PostLineFunctionArgs", "AmbientMusicSource", "ChallengeSwitch", })
	for key, value in pairs( tableToCheck ) do
		if not idLeakIgnores[key] and type(value) == "table" then
			local recursiveTrace = trace.."."..key
			ValidateIdLeaks( recursiveTrace, value )
		end
	end
end

function ValidateLoops( trace, tableToCheck )
	if string.len( trace ) > 200 then
		DebugAssert({ Condition = false, Text = "Loop found in "..trace })
	end
	--local extraIgnores = ToLookup({ })
	for key, value in pairs( tableToCheck ) do
		if type(value) == "table" then
			local recursiveTrace = trace.."."..key
			ValidateLoops( recursiveTrace, value )
		end
	end
end

function ValidateThreadLeaks()
	local threadIgnores = ToLookup({ "MapLoad", "CombatUIHide" })
	for k, thread in pairs( _threads ) do
		if not threadIgnores[thread.tag] then
			DebugAssert({ false, Text = "thread still active: "..tostring(thread.tag) })
		end
	end
end

function ValidateRequirements()
	if not verboseLogging then
		return
	end

	for enemyName, enemyData in pairs( EnemyData ) do
		if enemyData.InteractTextLineSets ~= nil then
			for textLinesName, textLines in pairs( enemyData.InteractTextLineSets ) do
				if textLines.GameStateRequirements ~= nil then
					IsGameStateEligible( CurrentRun, textLines, textLines.GameStateRequirements )
				end
			end
		end
		if enemyData.GiftTextLineSets ~= nil then
			for textLinesName, textLines in pairs( enemyData.GiftTextLineSets ) do
				if textLines.GameStateRequirements ~= nil then
					IsGameStateEligible( CurrentRun, textLines, textLines.GameStateRequirements )
				end
			end
		end
	end
end

function DoPatches()

	if GameState ~= nil then

		InitializeMetaUpgradeState()
		DoMetaUpgradePatches()

		if not IsEmpty( GameState.RunHistory ) then
			PrevRun = GameState.RunHistory[#GameState.RunHistory]
			if PrevRun ~= nil then
				UpdateRunHistoryCache( PrevRun )
			end
		end

		for i = #GameState.RunHistory, math.max( #GameState.RunHistory - 10, 1 ), -1 do
			local prevRun = GameState.RunHistory[i]
			prevRun.BiomeStateChangeCount = prevRun.BiomeStateChangeCount or 0
			prevRun.EncountersOccurredCache = prevRun.EncountersOccurredCache or {}
			prevRun.BiomesReached = prevRun.BiomesReached or {}
		end

		if not GameState.BountyBackCompatChecked then
			for i = #GameState.RunHistory, 1, -1 do
				local run = GameState.RunHistory[i]
				if run.ActiveBounty ~= nil then
					if not DoesRunMatchBounty(run, run.ActiveBounty) then
						-- This bounty is bogus! Is it actually using the bounty from the last run?
						local prevActiveBounty = GameState.RunHistory[i-1].ActiveBounty
						if prevActiveBounty ~= nil and DoesRunMatchBounty(run, prevActiveBounty) then
							run.ActiveBounty = prevActiveBounty
						else
							-- Nope, it's just a regular run!
							run.ActiveBounty = nil
						end
					end
				end
			end
			GameState.BountyBackCompatChecked = true
		end

		GameState.CompletedRunsCache = GetCompletedRuns()
		if GameState.EquippedFamiliar and not GameState.FamiliarResourceSpawnChance then
			GameState.FamiliarResourceSpawnChance = FamiliarData[GameState.EquippedFamiliar].BaseResourceSpawnChance + GetFamiliarBonusResourceSpawnChance( GameState.EquippedFamiliar )
		end

		for itemName, value in pairs( GameState.WorldUpgradesViewed ) do
			GameState.WorldUpgradesRevealed[itemName] = true
		end

		for id, plot in pairs( GameState.GardenPlots ) do
			local plotData = ObstacleData[plot.Name]
			if plotData ~= nil then
				plot.SpecialInteractFunctionName = plotData.SpecialInteractFunctionName
			end
			local seedData = GardenData.Seeds[plot.SeedName]
			if seedData == nil then
				plot.StoredGrows = 0
				plot.StoredResources = 0
				plot.SeedName = nil
				plot.UseText = "UseGardenPlotPlant"
				plot.TalkOnlyIfNoGiftOrSpecial = true
			end
		end

		for bountyName, v in pairs( GameState.BountiesCompleted ) do
			local bountyData = BountyData[bountyName]
			if bountyData ~= nil and bountyData.IsPackagedBounty then
				GameState.PackagedBountyClears[bountyName] = GameState.PackagedBountyClears[bountyName] or 1
				GameState.PackagedBountyAttempts[bountyName] = GameState.PackagedBountyAttempts[bountyName] or 1
			end
		end

		local foundDupes = false
		local pinNames = {}
		for index, pin in pairs( GameState.StoreItemPins ) do
			if pinNames[pin.Name] then
				-- Found dupe
				foundDupes = true
				GameState.StoreItemPins[index] = nil
			else
				pinNames[pin.Name] = true
			end
		end
		if foundDupes then
			GameState.StoreItemPins = CollapseTable( GameState.StoreItemPins )
		end

		-- Patch for current Mailbox orders of Mixer3Common to MetaFabric
		for itemId, mailbox in pairs( GameState.MailboxStatus ) do
			if mailbox ~= nil and mailbox.LeftDisplayName == "Mixer3Common" then
				mailbox.LeftDisplayName = "MetaFabric"
				mailbox.BuyName = "MetaFabric"
			end
		end

		for weaponName, traitName in pairs( GameState.LastWeaponUpgradeName ) do
			if not TraitData[traitName] then
				GameState.LastWeaponUpgradeName[weaponName] = nil
			end
		end

		GameState.ShrineUpgrades.EnemyEliteShrineUpgrade = 0
		GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
	end

	if CurrentRun ~= nil then

		UpdateRunHistoryCache( CurrentRun )
		
		for i, roomData in pairs( CurrentRun.RoomHistory ) do
			if roomData.Store and roomData.Store.SpawnedStoreItems then
				for s, spawnedItemData in pairs (roomData.Store.SpawnedStoreItems) do
					CurrentRun.RoomHistory[i].Store.SpawnedStoreItems[s] =  { ObjectId = spawnedItemData.ObjectId, ResourceCost = spawnedItemData.ResourceCost }
				end
			end
		end
		CurrentRun.SpellCharge = CurrentRun.SpellCharge or 5000
		CurrentRun.BiomeStateChangeCount = CurrentRun.BiomeStateChangeCount or 0
		CurrentRun.ResourceNodesSeen = CurrentRun.ResourceNodesSeen or {}

		if CurrentRun.CurrentRoom ~= nil then
			CurrentRun.CurrentRoom.SpawnThreads = CurrentRun.CurrentRoom.SpawnThreads or {}
			CurrentRun.CurrentRoom.ActiveEncounters = CurrentRun.CurrentRoom.ActiveEncounters or {}
			CurrentRun.CurrentRoom.SpeechRecord = CurrentRun.CurrentRoom.SpeechRecord or {}
			CurrentRun.CurrentRoom.Kills = CurrentRun.CurrentRoom.Kills or {}
			CurrentRun.CurrentRoom.RoomCreations = CurrentRun.CurrentRoom.RoomCreations or {}
			CurrentRun.CurrentRoom.EncountersOccurredCache = CurrentRun.CurrentRoom.EncountersOccurredCache or {}
			CurrentRun.CurrentRoom.NemesisTakeExitRecord = CurrentRun.CurrentRoom.NemesisTakeExitRecord or {}
			CurrentRun.CurrentRoom.TraitUses = CurrentRun.CurrentRoom.TraitUses or {}
			if CurrentRun.CurrentRoom.ChallengeSwitch ~= nil and CurrentRun.CurrentRoom.ChallengeSwitch.RewardType == nil then
				CurrentRun.CurrentRoom.ChallengeSwitch = DeepCopyTable( ObstacleData.ChallengeSwitch )
			end
			if CurrentRun.CurrentRoom.SellOptions then
				local hasIndex = false
				for i, data in pairs( CurrentRun.CurrentRoom.SellOptions ) do
					if data.Index then
						hasIndex = true
					end
					if data.Value == 0 and data.Index and CurrentRun.Hero.Traits[data.Index] then
						data.Value = GetTraitValue(CurrentRun.Hero.Traits[data.Index])
					end
				end
				if hasIndex then
					CurrentRun.CurrentRoom.SellOptions = nil
				end
			end
			if CurrentRun.CurrentRoom.Store ~= nil and CurrentRun.CurrentRoom.Store.StoreOptions ~= nil then
				local giftDropIndex = nil
				for i, storeOption in pairs( CurrentRun.CurrentRoom.Store.StoreOptions ) do
					if storeOption.Type == "Cosmetic" then
						storeOption.Name = "HealDropRange"
						storeOption.Type = "Consumable"
					elseif not storeOption.Name then
						storeOption.Name = "HealDropRange"
						storeOption.Type = "Consumable"
					end
				end
			end
			CurrentRun.CurrentRoom.StoreDataName = CurrentRun.CurrentRoom.StoreDataName or RoomData[CurrentRun.CurrentRoom.Name].StoreDataName

			DebugAssert({ Condition = RoomData[CurrentRun.CurrentRoom.Name] ~= nil, Text = "Missing Room: "..tostring(CurrentRun.CurrentRoom.Name) })

			CurrentRun.CurrentRoom.SpawnRewardOnId = RoomData[CurrentRun.CurrentRoom.Name].SpawnRewardOnId
			CurrentRun.CurrentRoom.DisableRewardMagnetisim = RoomData[CurrentRun.CurrentRoom.Name].DisableRewardMagnetisim
			CurrentRun.CurrentRoom.FadeOutAnimation = RoomData[CurrentRun.CurrentRoom.Name].FadeOutAnimation
			CurrentRun.CurrentRoom.SkipLoadNextMap = RoomData[CurrentRun.CurrentRoom.Name].SkipLoadNextMap
			CurrentRun.CurrentRoom.ExitFunctionName = RoomData[CurrentRun.CurrentRoom.Name].ExitFunctionName
			CurrentRun.CurrentRoom.ZoomFraction = RoomData[CurrentRun.CurrentRoom.Name].ZoomFraction
			CurrentRun.CurrentRoom.NextHeroStartPoint = RoomData[CurrentRun.CurrentRoom.Name].NextHeroStartPoint
			CurrentRun.CurrentRoom.NextHeroEndPoint = RoomData[CurrentRun.CurrentRoom.Name].NextHeroEndPoint
			CurrentRun.CurrentRoom.HeroStartPointCameraLinkIds = RoomData[CurrentRun.CurrentRoom.Name].HeroStartPointCameraLinkIds
			CurrentRun.CurrentRoom.HeroEndPointCameraLinkIds = RoomData[CurrentRun.CurrentRoom.Name].HeroEndPointCameraLinkIds
			CurrentRun.CurrentRoom.HeroStartPointEndPointLinkIds = RoomData[CurrentRun.CurrentRoom.Name].HeroStartPointEndPointLinkIds
			CurrentRun.CurrentRoom.RushMaxRangeOverride = RoomData[CurrentRun.CurrentRoom.Name].RushMaxRangeOverride

			CurrentRun.CurrentRoom.PersistentExitDoorRewards = RoomData[CurrentRun.CurrentRoom.Name].PersistentExitDoorRewards
			CurrentRun.CurrentRoom.PersistentRoomForDoors = RoomData[CurrentRun.CurrentRoom.Name].PersistentRoomForDoors
			CurrentRun.CurrentRoom.LinkedRoom = RoomData[CurrentRun.CurrentRoom.Name].LinkedRoom
			CurrentRun.CurrentRoom.CollectShadeMercs = RoomData[CurrentRun.CurrentRoom.Name].CollectShadeMercs
			CurrentRun.CurrentRoom.ShadeMercsRequiredForBoss = RoomData[CurrentRun.CurrentRoom.Name].ShadeMercsRequiredForBoss
			
			CurrentRun.CurrentRoom.EntranceAnimation = RoomData[CurrentRun.CurrentRoom.Name].EntranceAnimation
			CurrentRun.CurrentRoom.ExitAnimation = RoomData[CurrentRun.CurrentRoom.Name].ExitAnimation
			CurrentRun.CurrentRoom.MaintainSpellCharge = RoomData[CurrentRun.CurrentRoom.Name].MaintainSpellCharge
			
			CurrentRun.CurrentRoom.LockExtraExitsWithEncounter = RoomData[CurrentRun.CurrentRoom.Name].LockExtraExitsWithEncounter

			CurrentRun.CurrentRoom.ObstacleData = DeepCopyTable(RoomData[CurrentRun.CurrentRoom.Name].ObstacleData)
			CurrentRun.CurrentRoom.WrappingData = DeepCopyTable(RoomData[CurrentRun.CurrentRoom.Name].WrappingData)
			CurrentRun.CurrentRoom.OnUseSetRunData = DeepCopyTable(RoomData[CurrentRun.CurrentRoom.Name].OnUseSetRunData)

			if CurrentRun.CurrentRoom.ObjectStates ~= nil then
				for k, objectState in pairs( CurrentRun.CurrentRoom.ObjectStates ) do
					if objectState.Animation == "DestructibleTreeStump" then
						objectState.Animation = "DestructibleTreeStumpA"
					elseif objectState.Animation == "Breakable_HighValue" then
						objectState.Animation = "BreakableHighValueChronosPot"
					end
				end
			end

			for npcName, value in pairs( CurrentRun.NPCInteractions ) do
				if type(value) == "boolean" then
					CurrentRun.NPCInteractions[npcName] = 1
				end
			end

			-- Patch for Hecate and Scylla boss rewards changing name from Mixer#Common to MixerXBoss
			if CurrentRun.CurrentRoom.ChosenRewardType == "Mixer2CommonDrop" then
				CurrentRun.CurrentRoom.ChosenRewardType = "MixerFBossDrop"
			end
			if CurrentRun.CurrentRoom.ChosenRewardType == "Mixer4CommonDrop" then
				CurrentRun.CurrentRoom.ChosenRewardType = "MixerGBossDrop"
			end

		end

		local gameStateRequirements =
		{
			NamedRequirements =  { "ShrineUnlocked" },
		}
		if not IsGameStateEligible( CurrentRun, {}, gameStateRequirements ) then
			GameState.SpentShrinePointsCache = 0
			GameState.ShrineUpgrades = {}
		end

		if CurrentRun.RewardStores == nil then
			InitializeRewardStores( CurrentRun )
		else
			for storeName, storeData in pairs( RewardStoreData ) do
				if CurrentRun.RewardStores[storeName] == nil then
					CurrentRun.RewardStores[storeName] = DeepCopyTable( storeData )
				end
			end
		end

		if CurrentRun.LastReward and not CurrentRun.LastReward.DisplayName then	
			CurrentRun.LastReward.DisplayName = CurrentRun.LastReward.Name
			if CurrentRun.LastReward.Type == "Consumable" then
			local consumableItem = ConsumableData[CurrentRun.LastReward.Name]
				if consumableItem and consumableItem.AddResources and TableLength(consumableItem.AddResources) == 1 then
					CurrentRun.LastReward.DisplayName = ResourceData[GetFirstKey(consumableItem.AddResources)].TooltipId
				end
			end
		end
		for ghostName, ghostData in pairs( GhostData ) do
			GameState.ExorcisedNames[ghostName] = nil
			CurrentRun.ExorcisedNames[ghostName] = nil
		end
		GameState.ExorcisedNames.ExorcismPoint = nil
		CurrentRun.ExorcisedNames.ExorcismPoint = nil

		if CurrentRun.Hero ~= nil then

			CurrentRun.Hero.InvulnerableFlags = CurrentRun.Hero.InvulnerableFlags or {}
			CurrentRun.Hero.LastStands = CurrentRun.Hero.LastStands or {}
			CurrentRun.Hero.MaxLastStands = CurrentRun.Hero.MaxLastStands or TableLength( CurrentRun.Hero.LastStands )
			CurrentRun.Hero.MaxHealth = CurrentRun.Hero.MaxHealth or HeroData.MaxHealth
			CurrentRun.Hero.Health = CurrentRun.Hero.Health or CurrentRun.Hero.MaxHealth
			CurrentRun.Hero.Health = math.ceil(CurrentRun.Hero.Health)
			CurrentRun.Hero.MaxMana = CurrentRun.Hero.MaxMana or HeroData.MaxMana
			CurrentRun.Hero.Mana = CurrentRun.Hero.Mana or CurrentRun.Hero.Mana
			CurrentRun.Hero.Mana = math.ceil(CurrentRun.Hero.Mana)
			CurrentRun.Hero.Ammo = CurrentRun.Hero.Ammo or {}
			CurrentRun.Hero.WeaponDataOverride = CurrentRun.Hero.WeaponDataOverride or {}
			CurrentRun.Hero.ManaDrain = {}
			CurrentRun.Hero.AnimOffsetZ = HeroData.AnimOffsetZ
			CurrentRun.Hero.LineHistoryName = CurrentRun.Hero.LineHistoryName or HeroData.LineHistoryName

			CurrentRun.Hero.VisibleTraitCount = CurrentRun.Hero.VisibleTraitCount or 0

			CurrentRun.Hero.Speaker = CurrentRun.Hero.Speaker or HeroData.Speaker
			CurrentRun.Hero.Portrait = CurrentRun.Hero.Portrait or HeroData.Portrait

			local removedWeapons = {}
			local validWeapons = ToLookup( WeaponSets.HeroAllWeapons )
			for weaponName in pairs( CurrentRun.Hero.Weapons ) do
				if WeaponData[weaponName] ~= nil and WeaponData[weaponName].SecondaryWeapon and not CurrentRun.Hero.Weapons[WeaponData[weaponName].SecondaryWeapon] then
					CurrentRun.Hero.Weapons[WeaponData[weaponName].SecondaryWeapon] = true
				end
				if not validWeapons[weaponName] then
					table.insert( removedWeapons, weaponName )
				end
			end

			for i, weaponName in pairs(removedWeapons) do
				CurrentRun.Hero.Weapons[weaponName] = nil
			end
			for weaponName in pairs(HeroData.Weapons ) do
				CurrentRun.Hero.Weapons[weaponName] = true
			end

			local weaponDataOverride = CurrentRun.Hero.WeaponDataOverride
			if weaponDataOverride ~= nil then
				for weaponName, weaponData in pairs( weaponDataOverride ) do
					if weaponData.OnHitFunctionNames ~= nil then
						for k, functionName in ipairs( weaponData.OnHitFunctionNames ) do
							if _G[functionName] == nil then
								weaponData.OnHitFunctionNames[k] = nil
							end
						end
					end
					if weaponData.UnarmedCastCompleteGraphic ~= nil then
						weaponData.UnarmedCastCompleteGraphic = WeaponData[weaponName].UnarmedCastCompleteGraphic
					end
					if WeaponData[weaponName] and WeaponData[weaponName].OnProjectileDeathFunctionArgs and weaponData.OnProjectileDeathFunctionArgs == nil then
						weaponData.OnProjectileDeathFunctionArgs = DeepCopyTable(WeaponData[weaponName].OnProjectileDeathFunctionArgs)
					end
				end
			end

			CurrentRun.Hero.DashManeuverTimeThreshold = CurrentRun.Hero.DashManeuverTimeThreshold or HeroData.DashManeuverTimeThreshold
			CurrentRun.Hero.InvulnerableFrameMinDamage = CurrentRun.Hero.InvulnerableFrameMinDamage or HeroData.InvulnerableFrameMinDamage
			CurrentRun.Hero.StackData.AllowRarityOverride  = HeroData.StackData.AllowRarityOverride

			if not IsEmpty(CurrentRun.Hero.ManaRegenSources) then
				for key in pairs(CurrentRun.Hero.ManaRegenSources) do
					if not CurrentRun.Hero.ManaRegenSources[key] or type(CurrentRun.Hero.ManaRegenSources[key]) ~= "table" then
						CurrentRun.Hero.ManaRegenSources[key] = { Value = CurrentRun.Hero.ManaRegenSources[key] or 0 }
					end
				end
			end

			if CurrentRun.Hero.IsDead and CurrentRun.ActiveBiomeTimer then
				CurrentRun.ActiveBiomeTimer = false
			end
			if CurrentRun.Hero.OutgoingCritModifiers then
				local condemnedIds = {}
				for i, modifierData in pairs(CurrentRun.Hero.OutgoingCritModifiers) do
					if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
						modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
					end
					if modifierData.Temporary then
						table.insert(condemnedIds, i)
					end
				end
				if not IsEmpty(condemnedIds) then
				
					for i, index in pairs(condemnedIds) do
						CurrentRun.Hero.OutgoingCritModifiers[index] = nil
					end
					CurrentRun.Hero.OutgoingCritModifiers = CollapseTable(CurrentRun.Hero.OutgoingCritModifiers)
				end
			end
			if CurrentRun.Hero.OutgoingDamageModifiers then
				local condemnedIds = {}
				for i, modifierData in pairs(CurrentRun.Hero.OutgoingDamageModifiers) do
					if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
						modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
					end
					if modifierData.Temporary then
						table.insert(condemnedIds, i)
					end
				end
				if not IsEmpty(condemnedIds) then
				
					for i, index in pairs(condemnedIds) do
						CurrentRun.Hero.OutgoingDamageModifiers[index] = nil
					end
					CurrentRun.Hero.OutgoingDamageModifiers = CollapseTable(CurrentRun.Hero.OutgoingDamageModifiers)
				end
			end
			if CurrentRun.Hero.IncomingDamageModifiers then
				local condemnedIds = {}
				for i, modifierData in pairs(CurrentRun.Hero.IncomingDamageModifiers) do
					if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
						modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
					end
					if modifierData.Temporary then
						table.insert(condemnedIds, i)
					end
				end
				if not IsEmpty(condemnedIds) then
					for i, index in pairs(condemnedIds) do
						CurrentRun.Hero.IncomingDamageModifiers[index] = nil
					end
					CurrentRun.Hero.IncomingDamageModifiers = CollapseTable(CurrentRun.Hero.IncomingDamageModifiers)
				end
			end

			if CurrentRun.Hero.RecentTraits ~= nil then
				if type(CurrentRun.Hero.RecentTraits[1]) ~= "table" then
					CurrentRun.Hero.RecentTraits = {}
				end
			else
				CurrentRun.Hero.RecentTraits = {}
			end

			local traitsToAdd = {}
			local traitsToRemove = {}
			SessionState.PatchingTraits = true

			if TableLength( CurrentRun.Hero.Traits ) ~= #CurrentRun.Hero.Traits then
				CurrentRun.Hero.Traits = CollapseTable( CurrentRun.Hero.Traits )
			end

			for i, trait in pairs(CurrentRun.Hero.Traits) do
				local traitData = TraitData[trait.Name]
				trait.AnchorId = nil
				trait.TraitIconOverlay = nil
				trait.TraitInfoCardId = nil
				trait.TraitInfoUsesId = nil
				trait.TraitActiveOverlay = nil
				trait.AdditionalDataAnchorId = nil
				trait.AdvancedTooltipFrame = nil
				trait.AdvancedTooltipIcon = nil
				trait.Id = trait.Id or GetTraitUniqueId()
				local addTraitToUpdate = function ( trait )
					if trait.OnExpire then
						trait.OnExpire = nil
						IncrementTableValue( traitsToRemove, trait.Name )
					else
						IncrementTableValue( traitsToAdd, trait.Name )
					end

				end
				local traitData = TraitData[trait.Name]
				if TraitData[trait.Name] and trait.Icon ~= TraitData[trait.Name].Icon then
					trait.Icon = TraitData[trait.Name].Icon 
				end
				if traitData == nil then
					IncrementTableValue(traitsToRemove, trait.Name)
				elseif TableLength(trait.PropertyChanges) ~= TableLength(TraitData[trait.Name].PropertyChanges) or
				   TableLength(trait.EnemyPropertyChanges) ~= TableLength(TraitData[trait.Name].EnemyPropertyChanges) or
				   TableLength( trait.LoadBinks ) ~= TableLength( TraitData[trait.Name].LoadBinks ) or 
				   TableLength( trait.PreEquipWeapons ) ~= TableLength( TraitData[trait.Name].PreEquipWeapons ) then
					addTraitToUpdate( trait )
				elseif trait.Name == "SupportingFireBoon" and trait.ExtractValues[1] and trait.ExtractValues[1].BaseName == "ArtemisLegendary" then
					addTraitToUpdate( trait )
				elseif trait.Name == "LastStandFamiliar" and trait.ExtractValues[1] and trait.ExtractValues[1].BaseName == "CatFamiliarBall" then
					addTraitToUpdate( trait )
				elseif trait.Name == "FamiliarCatCrit" and Revision <= 79800 then
					addTraitToUpdate( trait )
				elseif trait.Name == "LastStandFamiliar" and Revision <= 79800 then
					addTraitToUpdate( trait )
				elseif trait.Name == "DemeterSprintBoon" and trait.OnWeaponFiredFunctions and trait.OnWeaponFiredFunctions.FunctionArgs and IsEmpty( trait.OnWeaponFiredFunctions.FunctionArgs.ProjectileNames ) then
					addTraitToUpdate( trait )
				elseif trait.SetupFunction ~= nil and traitData.SetupFunction == nil then
					addTraitToUpdate( trait )
				else
					for key, data in pairs (TraitData[trait.Name]) do
						if trait[key] == nil and key ~= "RemainingUses" then
							addTraitToUpdate(  trait )
							break
						end
					end
				end

				if trait.PropertyChanges ~= nil then
					for k, propertyChange in pairs( trait.PropertyChanges ) do
						if propertyChange.ProjectileProperty == "DamagePerConescutiveHit" then
							addTraitToUpdate( trait )
						elseif propertyChange.WeaponProperty == "AdditionalProjectileDamageMultiplier" then
							addTraitToUpdate( trait )
						elseif propertyChange.LifeProperty == "MaxHealth" then
							addTraitToUpdate( trait )
						elseif propertyChange.LifeProperty == "Health" then
							addTraitToUpdate( trait )
						end
					end
				end

				if trait.SetupFunction ~= nil then
					if traitData ~= nil and traitData.SetupFunction ~= nil and traitData.SetupFunction.Threaded then
						trait.SetupFunction.Threaded = true
					end
				end

				if trait.ActivationRequirements ~= nil then
					for index, requirement in ipairs( trait.ActivationRequirements ) do
						if requirement.ReportValues ~= nil then
							addTraitToUpdate( trait )
							break
						end
					end
				end

				if trait.RoomsPerUpgrade and IsTraitActive(trait) then
					if trait.RoomsPerUpgrade and trait.RoomsPerUpgrade.Rarity and not IsEmpty(trait.HarvestBoons) then
						if not CurrentRun.Hero.UpgradeableTraitCountCache then
							local traitCount = 0
							if trait.DowngradeTraitNames ~= nil then
								for _, traitName in pairs( trait.DowngradeTraitNames ) do
									local targetTrait = GetHeroTrait( traitName )
									if GetUpgradedRarity(targetTrait.Rarity) ~= nil and targetTrait.RarityLevels[GetUpgradedRarity(targetTrait.Rarity)] ~= nil then
										traitCount = traitCount + 1
									end
								end
							end
							CurrentRun.Hero.UpgradeableTraitCountCache = traitCount	
						elseif CurrentRun.Hero.UpgradeableTraitCountCache == 0 then
							trait.CurrentRoom = 0
						end
					elseif trait.RoomsPerUpgrade and trait.RoomsPerUpgrade.DowngradeRarity and not IsEmpty(trait.DowngradeTraitNames) then
						if not CurrentRun.Hero.DowngradableTraitCountCache then
							local traitCount = 0
							for _, traitName in pairs( trait.DowngradeTraitNames ) do
								local targetTrait = GetHeroTrait( traitName )
								if GetDowngradedRarity(targetTrait.Rarity) ~= nil and targetTrait.RarityLevels[GetDowngradedRarity(targetTrait.Rarity)] ~= nil then
									traitCount = traitCount + 1
								end
							end
							CurrentRun.Hero.DowngradableTraitCountCache = traitCount
						elseif CurrentRun.Hero.DowngradableTraitCountCache == 0 then
							trait.CurrentRoom = 0
						end
					end
				end

				if trait.AddOutgoingDamageModifiers and trait.AddOutgoingDamageModifiers.ValidWeapons and not trait.AddOutgoingDamageModifiers.ValidWeaponsLookup then
					addTraitToUpdate( trait )
				end
				
				if not traitsToRemove[trait.Name] and not traitsToAdd[trait.Name] then			
					ExtractValues( CurrentRun.Hero, trait, trait )
				end

				if trait.Slot == "Spell" then
					local weaponName = trait.PreEquipWeapons[1]
					local data = GetWeaponData( CurrentRun.Hero, weaponName )
					if data and not data.ManaSpendCost and CurrentRun.Hero.WeaponDataOverride[weaponName] then
						CurrentRun.Hero.WeaponDataOverride[weaponName].ManaSpendCost = WeaponData[trait.PreEquipWeapons[1]].ManaSpendCost
					end
				end
			end

			if not IsEmpty( CurrentRun.TemporaryMetaUpgrades ) and GetNumShrineUpgrades( "NoMetaUpgradesShrineUpgrade" ) >= 1 then
				for metaUpgradeName in pairs( CurrentRun.TemporaryMetaUpgrades ) do
					GameState.MetaUpgradeState[metaUpgradeName].Equipped = false
					local metaUpgradeTraitName = MetaUpgradeCardData[metaUpgradeName].TraitName
					if metaUpgradeTraitName ~= nil then
						IncrementTableValue( traitsToRemove, metaUpgradeTraitName )
					end
				end
				CurrentRun.TemporaryMetaUpgrades = {}
			end

			local orderedTraitsToAdd = CollapseTableAsOrderedKeyValuePairs(traitsToAdd)
			for index, kvp in ipairs(orderedTraitsToAdd) do
				local traitName = kvp.Key
				local traitNumber = kvp.Value
				for i=1, traitNumber do
					DebugPrint({Text = " Removing " .. traitName })
					RemoveTrait( CurrentRun.Hero, traitName, { SkipActivatedTraitUpdate = true })
				end
				for i=1, traitNumber do
					DebugPrint({Text = " Readding " .. traitName })
					AddTraitToHero({ TraitName = traitName, Rarity = "Common", SkipActivatedTraitUpdate = true, FromLoot = TraitData[traitName].FromLootOnUpdate })
				end
			end

			local orderedTraitsToRemove = CollapseTableAsOrderedKeyValuePairs(traitsToRemove)
			for index, kvp in ipairs(orderedTraitsToRemove) do
				local traitName = kvp.Key
				local traitNumber = kvp.Value
				for i=1, traitNumber do
					DebugPrint({Text = " Removing " .. traitName })
					RemoveTrait( CurrentRun.Hero, traitName )
				end
			end			

			ValidateMaxHealth()
			ValidateMaxMana()
			CleanRecentTraitsRecord()
			UpdateTalentPointInvestedCache()
			
			SessionState.PatchingTraits = false
			CurrentRun.Hero.TargetMetaRewardsRatio = CurrentRun.Hero.TargetMetaRewardsRatio or HeroData.TargetMetaRewardsRatio
			CurrentRun.Hero.CanBeFrozen = CurrentRun.Hero.CanBeFrozen or HeroData.CanBeFrozen

		end	

		-- This fixes Fields passive spawn distributions on old saves
		if CurrentRun.CurrentRoom.Encounter ~= nil then
			local encounterData = EncounterData[CurrentRun.CurrentRoom.Encounter.Name]
			if encounterData ~= nil then
				CurrentRun.CurrentRoom.Encounter.RequireNearPlayerDistance = encounterData.RequireNearPlayerDistance
			end
		end

		if CurrentRun.CurrentRoom.Encounter.Name == "BossScylla01" then
			CurrentRun.CurrentRoom.Encounter.LastKillPresentationFunction = nil
		end

		if CurrentRun.ActiveBiomeTimer and CurrentRun.ShrineUpgradesDisabled["BiomeSpeedShrineUpgrade"] then
			CurrentRun.ActiveBiomeTimer = false
		end

		if CurrentRun.LootTypeHistory ~= nil then
			for lootName, i in pairs(CurrentRun.LootTypeHistory) do
				if not GameData.MissingPackages[lootName] then
					LoadPackages({ Name = lootName })
				end
			end
		end
		local traitPackageNames = {}
		for i, trait in pairs( CurrentRun.Hero.Traits ) do
			if trait.PackageName ~= nil and not GameData.MissingPackages[trait.PackageName] then
				traitPackageNames[trait.PackageName] = true
			end
		end
		for packageName, v in pairs( traitPackageNames ) do
			LoadPackages({ Name = packageName })
		end

	end
	DebugPrint({ Text = "Done patching." })
end

function GetMaxHealthUpgradeIncrement( value )
	local expectedMaxHealth = HeroData.MaxHealth
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.PropertyChanges ~= nil then
			for k, propertyChange in pairs( trait.PropertyChanges ) do
				if propertyChange.LuaProperty == "MaxHealth" then
					expectedMaxHealth = expectedMaxHealth + propertyChange.ChangeValue
				end
			end
		end
		if trait.ActivatedPropertyChanges ~= nil and IsGameStateEligible(CurrentRun, trait.ActivationRequirements) then
			for k, propertyChange in pairs( trait.ActivatedPropertyChanges ) do
				if propertyChange.LuaProperty == "MaxHealth" then
					expectedMaxHealth = expectedMaxHealth + propertyChange.ChangeValue
				end
			end
		end
		if trait.MaxManaToMaxHealthConversion then
			expectedMaxHealth = expectedMaxHealth + math.ceil(GetExpectedMaxMana()) * trait.MaxManaToMaxHealthConversion
		end
	end

	expectedMaxHealth = expectedMaxHealth + value
	expectedMaxHealth = math.max(1, round(expectedMaxHealth * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true })))

	return expectedMaxHealth - CurrentRun.Hero.MaxHealth
end

function DoesRunMatchBounty(run, bountyName)

	if BountyData[bountyName] == nil then
		return false
	end

	if run.WeaponsCache ~= nil and run.WeaponsCache[BountyData[bountyName].WeaponKitName] == nil then
		return false
	end

	if BountyData[bountyName].StartingTraits ~= nil then
		for i, startingTrait in ipairs( BountyData[bountyName].StartingTraits ) do
			if run.TraitCache[startingTrait.Name] == nil then
				return false
			end
		end
	end

	if run.BiomesReached ~= nil then
		local ignoreBiomes = { "Hub", "Chaos", "Anomaly", "N_SubRooms" }
		for biomeName, reached in pairs( run.BiomesReached ) do
			local forceReached = false
			if BountyData[bountyName].RunOverrides ~= nil and BountyData[bountyName].RunOverrides.BiomesReached ~= nil then
				forceReached = BountyData[bountyName].RunOverrides.BiomesReached[biomeName]
			end
			if biomeName ~= BountyData[bountyName].StartingBiome and not forceReached and not Contains( ignoreBiomes, biomeName) then
				return false
			end
		end
	end

	return true

end

function GetMaxManaUpgradeIncrement( value )
	local expectedMaxMana = HeroData.MaxMana
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.PropertyChanges ~= nil then
			for k, propertyChange in pairs( trait.PropertyChanges ) do
				if propertyChange.LuaProperty == "MaxMana" then
					expectedMaxMana = expectedMaxMana + propertyChange.ChangeValue
				end
			end
		end
		if trait.ActivatedPropertyChanges ~= nil and IsGameStateEligible(CurrentRun, trait.ActivationRequirements) then
			for k, propertyChange in pairs( trait.ActivatedPropertyChanges ) do
				if propertyChange.LuaProperty == "MaxMana" then
					expectedMaxMana = expectedMaxMana + propertyChange.ChangeValue
				end
			end
		end
		if trait.MaxManaToMaxManaConversion then
			expectedMaxMana = expectedMaxMana + math.ceil(GetExpectedMaxMana()) * trait.MaxManaToMaxManaConversion
		end
	end

	expectedMaxMana = expectedMaxMana + value
	expectedMaxMana = round(expectedMaxMana * GetTotalHeroTraitValue("MaxManaMultiplier", { IsMultiplier = true }))

	return expectedMaxMana - CurrentRun.Hero.MaxMana
end


function ValidateMaxHealth( blockDelta )
	local expectedMaxHealth = HeroData.MaxHealth
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.PropertyChanges ~= nil then
			for k, propertyChange in pairs( trait.PropertyChanges ) do
				if propertyChange.LuaProperty == "MaxHealth" then
					expectedMaxHealth = expectedMaxHealth + propertyChange.ChangeValue
				end
			end
		end
		local traitData = TraitData[trait.Name]
		if trait.ActivatedPropertyChanges ~= nil and ( traitData.ActivationRequirements == nil or IsGameStateEligible( CurrentRun, trait, traitData.ActivationRequirements ) ) then
			for k, propertyChange in pairs( trait.ActivatedPropertyChanges ) do
				if propertyChange.LuaProperty == "MaxHealth" then
					expectedMaxHealth = expectedMaxHealth + propertyChange.ChangeValue
				end
			end
		end
		if trait.MaxManaToMaxHealthConversion then
			expectedMaxHealth = expectedMaxHealth + math.ceil(GetExpectedMaxMana()) * trait.MaxManaToMaxHealthConversion
		end
	end
	expectedMaxHealth = math.max(1, round(expectedMaxHealth * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true })))
	if expectedMaxHealth ~= CurrentRun.Hero.MaxHealth then
		local delta = expectedMaxHealth - CurrentRun.Hero.MaxHealth
		CurrentRun.Hero.MaxHealth = math.max(1, round( CurrentRun.Hero.MaxHealth + delta ))
		if not blockDelta then
			CurrentRun.Hero.Health = round( CurrentRun.Hero.Health + delta )  
		end
	end
	CurrentRun.Hero.Health = math.max(1, math.min( CurrentRun.Hero.Health, CurrentRun.Hero.MaxHealth ))
end

function GetExpectedMaxMana()
	local expectedMaxMana = HeroData.MaxMana
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.PropertyChanges ~= nil then
			for k, propertyChange in pairs( trait.PropertyChanges ) do
				if propertyChange.LuaProperty == "MaxMana" then
					expectedMaxMana = expectedMaxMana + propertyChange.ChangeValue
				end
			end
		end
		local traitData = TraitData[trait.Name]
		if trait.ActivatedPropertyChanges ~= nil and ( traitData.ActivationRequirements == nil or IsGameStateEligible( CurrentRun, trait, traitData.ActivationRequirements ) ) then
			for k, propertyChange in pairs( trait.ActivatedPropertyChanges ) do
				if propertyChange.LuaProperty == "MaxMana" then
					expectedMaxMana = expectedMaxMana + propertyChange.ChangeValue
				end
			end
		end
	end
	expectedMaxMana = round(expectedMaxMana * GetTotalHeroTraitValue("MaxManaMultiplier", { IsMultiplier = true }))
	return expectedMaxMana
end

function ValidateMaxMana()
	local expectedMaxMana = GetExpectedMaxMana()
	if expectedMaxMana ~= CurrentRun.Hero.MaxMana then
		local delta = expectedMaxMana - CurrentRun.Hero.MaxMana
		CurrentRun.Hero.MaxMana = round( CurrentRun.Hero.MaxMana + delta ) 
	end
	CurrentRun.Hero.Mana = math.min( CurrentRun.Hero.Mana, GetHeroMaxAvailableMana() )
	CurrentRun.Hero.Mana = math.max( CurrentRun.Hero.Mana, 0 )
	UpdateWeaponMana()
end

function SetupMap()

	CreateGroup({ Name = "Standing" })

	CreateGroup({ Name = "FX_Standing", BlendMode = "Normal" })
	InsertGroupInFront({ Name = "FX_Standing", DestinationName = "Standing" })

	CreateGroup({ Name = "HeroLight" })
	InsertGroupBehind({ Name = "HeroLight", DestinationName = "Standing" })

	CreateGroup({ Name = "Standing_Back" })
	InsertGroupBehind({ Name = "Standing_Back", DestinationName = "Standing" })

	CreateGroup({ Name = "Standing_Back_Add", BlendMode = "Additive" })
	InsertGroupInFront({ Name = "Standing_Back_Add", DestinationName = "Standing_Back" })

	CreateGroup({ Name = "FX_Terrain", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "FX_Terrain", DestinationName = "Standing_Back" })

	CreateGroup({ Name = "FX_Terrain_Dark", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "FX_Terrain_Dark", DestinationName = "FX_Terrain" })

	CreateGroup({ Name = "FX_Terrain_Liquid", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "FX_Terrain_Liquid", DestinationName = "FX_Terrain" })

	CreateGroup({ Name = "FX_Terrain_Add", BlendMode = "Additive" })
	InsertGroupInFront({ Name = "FX_Terrain_Add", DestinationName = "FX_Terrain" })

	CreateGroup({ Name = "FX_Displacement", BlendMode = "DisplacementMerge" })
	InsertGroupInFront({ Name = "FX_Displacement", DestinationName = "Standing" })

	CreateGroup({ Name = "FX_Standing_Add", BlendMode = "AdditiveMerge" })
	InsertGroupInFront({ Name = "FX_Standing_Add", DestinationName = "FX_Displacement" })

	CreateGroup({ Name = "FX_Dark", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "FX_Dark", DestinationName = "Standing_Back" })

	CreateGroup({ Name = "FX_Terrain_Top", BlendMode = "Normal" })
	InsertGroupInFront({ Name = "FX_Terrain_Top", DestinationName = "FX_Terrain_Add" })

	CreateGroup({ Name = "Shadows" })
	InsertGroupBehind({ Name = "Shadows", DestinationName = "FX_Terrain_Add" })

	CreateGroup({ Name = "FX_Standing_Top", BlendMode = "Normal" })
	InsertGroupInFront({ Name = "FX_Standing_Top", DestinationName = "FX_Standing_Add" })

	CreateGroup({ Name = "FX_Add_Top", BlendMode = "Additive" })
	InsertGroupInFront({ Name = "FX_Add_Top", DestinationName = "FX_Standing_Top" })

	local vignetteBlendMode = "Overlay"
	if not GetConfigOptionValue({ Name = "DrawBloom" }) then
		vignetteBlendMode = "Additive"
	end
	CreateGroup({ Name = "Vignette", BlendMode = vignetteBlendMode })
	InsertGroupInFront({ Name = "Vignette", DestinationName = "MapArt" })

	local prevGroup = "ScreenOverlay"
	for i, groupData in ipairs( ScreenData.HUD.GroupOrder ) do
		CreateGroup( groupData )
		InsertGroupInFront({ Name = groupData.Name, DestinationName = prevGroup })
		prevGroup = groupData.Name
	end

end

function AttemptUseDoor( door, args )

	if door.InUse then
		return
	end

	args = args or {}
	
	if not door.ReadyToUse or not CheckRoomExitsReady( CurrentRun.CurrentRoom ) or CheckSpecialDoorRequirement( door ) ~= nil then
		thread( CallFunctionName, door.CannotUsePresentation or "CannotUseDoorPresentation", door, args )
		return
	end

	if door.EncounterCost ~= nil then
		if not IsEmpty(CurrentRun.CurrentRoom.ActiveEncounters) then
			thread( CannotUseDoorPresentation, door )
			return
		elseif not door.EncounterCostStarted then
			door.EncounterCostStarted = true

			if door.OnUsedEncounterCostPresentationFunctionName ~= nil then
				CallFunctionName(door.OnUsedEncounterCostPresentationFunctionName, door, args)
			end

			local doorEncounter = DeepCopyTable( EncounterData[door.EncounterCost] )
			GenerateEncounter(CurrentRun, CurrentRun.CurrentRoom, doorEncounter)
			StopAnimation({ DestinationId = door.ObjectId, Name = "LockedIconNoKey" })
			CreateAnimation({ DestinationId = door.ObjectId, Name = "LockedIconRelease", Group = "FX_Standing_Top" })
			RefreshUseButton(door.ObjectId, door)

			StartEncounter(CurrentRun, CurrentRun.CurrentRoom, doorEncounter)

			door.EncounterCost = nil
			door.CanBeRerolled = true
			CreateDoorRewardPreview( door )
			thread( ExitDoorUnlockedPresentation, door )
			if not IsEmpty( MapState.OfferedExitDoors ) then
				for id, door in pairs(MapState.OfferedExitDoors) do
					RefreshUseButton( id, door )
				end
			end
			return
		end
		return
	end

	door.InUse = true

	if door.HealthCost ~= nil then
		SacrificeHealth({ SacrificeHealthMin = door.HealthCost, SacrificeHealthMax = door.HealthCost, Silent = true, DeductHealth = true })
	end

	SetPlayerInvulnerable( "LeaveRoom" )
	AddTimerBlock( CurrentRun, "UseDoor" )

	if door.OnUsedPresentationFunctionName ~= nil then
		CallFunctionName( door.OnUsedPresentationFunctionName, door, door.OnUsedPresentationFunctionArgs )
	end

	RemoveTimerBlock( CurrentRun, "UseDoor" )
	SetPlayerVulnerable( "LeaveRoom" )

	PlaySound({ Name = door.UnlockedUseSound or RoomData.BaseRoom.UnlockedUseSound })

	if door.ReturnToPreviousRoom then
		local prevRoom = GetPreviousRoom( CurrentRun )
		door.Room = prevRoom
		door.Room.StartRoomPresentationOnReload = true
		door.Room.TimesVisited = door.Room.TimesVisited + 1
	end
	if door.ReturnToPreviousRoomName then
		local found = false
		for roomIndex = #CurrentRun.RoomHistory, 1, -1 do
			local prevRoom = CurrentRun.RoomHistory[roomIndex]
			if not found and door.ReturnToPreviousRoomName == prevRoom.Name then
				door.Room = prevRoom
				door.Room.TimesVisited = door.Room.TimesVisited + 1
				found = true
			end
		end
	end

	if door.CloseOnReturnAnimation ~= nil then
		CurrentRun.CurrentRoom.CloseDoorOnReturn = door.ObjectId
	end

	if CurrentRun.CurrentRoom.OnUseSetRunData ~= nil and CurrentRun.CurrentRoom.OnUseSetRunData[door.Name] ~= nil then
		OverwriteTableKeys( CurrentRun.CurrentRoom, CurrentRun.CurrentRoom.OnUseSetRunData[door.Name] )
	end

	LeaveRoom( CurrentRun, door )

end

function CheckSpecialDoorRequirement( door )

	if door == nil then
		return "ExitNotActive"
	end

	if door.HealthCost ~= nil and CurrentRun.Hero.Health <= door.HealthCost then
		return "ExitBlockedByHealthReq"
	end

	if door.ShrinePointReq ~= nil and GetTotalSpentShrinePoints() < door.ShrinePointReq then
		return "ExitBlockedByShrinePointReq"
	end

	return nil

end

function GetDoorHealAmount( currentRun )
	local maxHealth = currentRun.Hero.MaxHealth
	local healAmount = 0
	local roomHealFraction = GetTotalHeroTraitValue("DoorHeal")
	local roomHealFixed = GetTotalHeroTraitValue("DoorHealFixed")
	local roomHealFullThreshold = GetTotalHeroTraitValue("DoorFullHealThreshold", {IsMultiplier = true })
	if CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth >= roomHealFullThreshold then
		roomHealFixed = CurrentRun.Hero.MaxHealth - CurrentRun.Hero.Health
	end

	for i, traitData in pairs( GetHeroTraitValues("DoorHealThreshold")) do
		if traitData.FixedHeal then
			local healAmount = traitData.FixedHeal
			if traitData.HealthFraction and ( CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth ) <= traitData.HealthFraction then
				healAmount = healAmount * traitData.HealthFractionMultiplier
			end
			roomHealFixed = roomHealFixed + healAmount
		end
	end


	healAmount = roomHealFraction * maxHealth
	healAmount = healAmount + roomHealFixed

	if HeroHasTrait("DoorHealReserveKeepsake") then
		local missingHealth = CurrentRun.Hero.MaxHealth - CurrentRun.Hero.Health
		if missingHealth > healAmount then
			local remainingMissing = missingHealth - healAmount
			local trait = GetHeroTrait("DoorHealReserveKeepsake")
			local healReserve = trait.DoorHealReserve
			if healReserve > remainingMissing then
				healAmount = healAmount + remainingMissing
				trait.DoorHealReserve = trait.DoorHealReserve - remainingMissing
			else
				healAmount = healAmount + trait.DoorHealReserve
				trait.DoorHealReserve = 0
				trait.CustomTrayText = trait.ZeroBonusTrayText
				if healReserve ~= 0 then
					thread( DoorHealKeepsakeExpiredPresentation )
				end
				ReduceTraitUses( trait, { Force = true })
			end
		end
	end

	healAmount = round( healAmount * CalculateHealingMultiplier())
	return healAmount
end

function CheckDoorHealTrait( currentRun, door )
	local healAmount = GetDoorHealAmount( currentRun )
	local hasText = false
	if healAmount > 0 then
		local silent = false
		if door and door.HideDoorHealPresentation then
			silent = true
		else
			hasText = true
		end
		Heal( CurrentRun.Hero, { HealAmount = healAmount, Name = "DoorHeal", Silent = silent } )
	end
	if hasText then
		IncrementTableValue( SessionMapState, "DoorTextCount" )
	end

	thread( UpdateHealthUI )
end

function CheckUnusedWeaponBonusTrait()
	if HeroHasTrait( "UnusedWeaponBonusTrait" ) then
		wait( 0.43 )
		for name, amount in pairs( TraitData.UnusedWeaponBonusTrait.AddResources ) do
			thread( UnusedWeaponBonusPresentation ) 
			AddResource( name, amount, "UnusedWeaponBonusTrait",
				{
					StartId = HUDScreen.Components.InventoryIcon.Id,
					OffsetX = -120,
					AnchorOffsetY = -50,
					HoldOffsetY = -100,
					FontSize = 120,
					ShadowScale = 0.4,
					IgnoreAsLastResourceGained = true,
				}
				)
		end
	end
end

function CheckInspectPoints( currentRun, source )
	if source.InspectPoints == nil then
		return
	end

	local eligibleInspectPointData = {}
	for id, inspectPointData in pairs( source.InspectPoints ) do
		inspectPointData.ObjectId = id
		if IsInspectPointEligible( currentRun, source, inspectPointData ) then
			eligibleInspectPointData[id] = inspectPointData
		end
	end

	if source.InspectPointPriority ~= nil then
		for i, id in ipairs( source.InspectPointPriority ) do
			local priorityInspectPointData = eligibleInspectPointData[id]
			if priorityInspectPointData ~= nil then
				SetupInspectPoint( priorityInspectPointData )
				return
			end
		end
	end

	local randomInspectPointData = GetRandomValue( eligibleInspectPointData )
	if randomInspectPointData ~= nil then
		SetupInspectPoint( randomInspectPointData )
	end

end

function SetupInspectPoint( inspectPointData )
	inspectPointData = MergeTables( ObstacleData.InspectPoint, inspectPointData )
	local inspectPoint = DeepCopyTable( inspectPointData )
	ProcessTextLines( inspectPoint, inspectPoint.InteractTextLineSets )
	RunEventsGeneric( inspectPoint.SetupEvents, inspectPoint )
	Activate({ Id = inspectPoint.ObjectId })
	AttachLua({ Id = inspectPoint.ObjectId, Table = inspectPoint })
	MapState.ActiveObstacles[inspectPoint.ObjectId] = inspectPoint
end

function StartRoom( currentRun, currentRoom )
	
	local roomData = RoomData[currentRoom.Name] or currentRoom
	local encounterData = EncounterData[currentRoom.Encounter.Name] or currentRoom.Encounter

	if currentRoom.EncounterSpecificDataOverwrites ~= nil and currentRoom.EncounterSpecificDataOverwrites[currentRoom.Encounter.Name] ~= nil then
		OverwriteTableKeys(currentRoom, currentRoom.EncounterSpecificDataOverwrites[currentRoom.Encounter.Name])
	end

	if currentRoom.RunOverrides then
		OverwriteTableKeys(currentRun, currentRoom.RunOverrides)
	end

	currentRun.RunDepthCache = currentRun.RunDepthCache or GetRunDepth( currentRun )
	currentRun.BiomeDepthCache = currentRun.BiomeDepthCache or GetBiomeDepth( currentRun )
	if not currentRun.BiomesReached[currentRoom.RoomSetName] then
		GameState.BiomeVisits[currentRoom.RoomSetName] = (GameState.BiomeVisits[currentRoom.RoomSetName] or 0) + 1
	end
	currentRun.BiomesReached[currentRoom.RoomSetName] = true	
	currentRun.RoomsEntered[currentRoom.Name] = (currentRun.RoomsEntered[currentRoom.Name] or 0) + 1
	GameState.RoomsEntered[currentRoom.Name] = (GameState.RoomsEntered[currentRoom.Name] or 0) + 1

	DebugAssert({ Condition = not currentRun.Hero.IsDead, Text = "Starting a room with a dead hero!" })

	if currentRoom.RichPresence ~= nil then
		SetRichPresence({ Key = "status", Value = currentRoom.RichPresence })
		SetRichPresence({ Key = "steam_display", Value = currentRoom.RichPresence })
	end

	AddTimerBlock( currentRun, "StartRoom" )
	if roomData.TimerBlock ~= nil then
		AddTimerBlock( currentRun, roomData.TimerBlock )
	end
	if roomData.RemoveTimerBlock ~= nil then
		RemoveTimerBlock( currentRun, roomData.RemoveTimerBlock )
	end

	ForceNextRoom = nil
	ForceNextEncounter = nil

	DebugPrint({ Text = "StartRoom: "..currentRoom.Name.." (RunDepth = "..currentRun.RunDepthCache..")".." (BiomeDepth = "..currentRun.BiomeDepthCache..")".." (Seed = "..GetGlobalRng().seed..")" })

	local previousRoom = GetPreviousRoom(currentRun)
	if previousRoom ~= nil and previousRoom.StartTime ~= nil then
		local timeInPrev = _worldTime - previousRoom.StartTime
		--DebugPrint({ Text = "Time in previous: "..timeInPrev.." seconds" })
	end

	if currentRoom.CameraWalls then
		CreateCameraWalls({ })
	end
	
	AddInputBlock({ Name = "StartRoom" })
	local firstRoomOfRun = IsEmpty( currentRun.RoomHistory )
	SetupHeroObject( currentRoom, firstRoomOfRun )
	if firstRoomOfRun then
		ValidateMaxHealth()
		ValidateMaxMana()
	end
	currentRoom.StartTime = _worldTime

	local prevRoom = GetPreviousRoom( currentRun )
	if prevRoom ~= nil and prevRoom.CheckWeaponHistory then
		UpdateWeaponHistory(currentRun)
	end

	SwitchActiveUnit({ Id = currentRun.Hero.ObjectId })

	SetupPreActivatedEnemies( currentRoom )
	if encounterData.DisableTraps or SessionState.BlockSpawns then
		DisableRoomTraps()
	end
	AssignObstacles( currentRoom )

	LoadSpawnPackages( currentRoom.Encounter )
	HandleSecretSpawns( currentRun )
	CheckChallengeSwitchItemValidity( currentRun )
	StartRoomPreLoadBinks({
		Run = currentRun,
		Room = currentRoom,
		Encounter = currentRoom.Encounter,
		ChallengeEncounter = currentRoom.ChallengeEncounter
	})

	if currentRoom.CheckObjectStatesOnStartRoom then
		RestoreObjectStates(currentRoom)
	end

	GatherRoomPresentationObjects( currentRun, currentRoom )

	-- Active ExitDoors
	local exitDoorIds = GetInactiveIds({ Name = "ExitDoors" })
	local firstDoor = true
	while not IsEmpty( exitDoorIds ) do
		local doorId = RemoveRandomValue( exitDoorIds )
		if firstDoor or RandomChance( currentRun.CurrentRoom.ExtraDoorActivateChance or 1.0 ) then
			Activate({ Id = doorId })
			firstDoor = false
		end
	end

	ChooseNextRewardStore( currentRun )

	FadeOut({ Color =  Color.Black, Duration = 0 })

	if currentRoom.Encounter.SpawnWaves ~= nil and GetNumShrineUpgrades( "EnemyEliteShrineUpgrade" ) > 0 then
		PickRoomEliteTypeUpgrades(currentRoom)
	end
	
	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName ) 
		RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
	end

	RunThreadedEvents( RoomData[currentRoom.Name].StartThreadedEvents, currentRoom )
	RunEventsGeneric( RoomData[currentRoom.Name].StartUnthreadedEvents, currentRoom )
	RunEventsGeneric( RoomEventData.GlobalRoomStartEvents, currentRoom )
	RunThreadedEvents( encounterData.StartRoomThreadedEvents, currentRoom.Encounter )
	RunEventsGeneric( encounterData.StartRoomUnthreadedEvents, currentRoom.Encounter )	

	ApplyTraitSetupFunctions( CurrentRun.Hero, { Context = "StartRoom" } )
	ApplyTraitSetupFunctions( CurrentRun.Hero, { Context = "EnterRoom" } )

	local darknessEarned = 0
	for i, traitData in pairs(GetHeroTraitValues( "DarknessPerRoom" )) do
		darknessEarned = darknessEarned + traitData.Base + round(traitData.DepthMult * GetRunDepth( currentRun ))
	end
	AddResource( "MetaPoints", darknessEarned, "DarknessPerRoom", { Silent = true } )

	SetupRoomArt( currentRun, currentRoom )
	
	if GetNumShrineUpgrades( "BiomeSpeedShrineUpgrade" ) > 0 then
		if currentRoom.BiomeStartRoom then
			local rankIndex = GetNumShrineUpgrades("BiomeSpeedShrineUpgrade")
			local additionalTime = MetaUpgradeData.BiomeSpeedShrineUpgrade.ChangeValue
			if additionalTime then
				CurrentRun.BiomeTime = math.max( CurrentRun.BiomeTime, 0 ) + additionalTime
				thread( BiomeTimeCheckpointPresentation, CurrentRun, additionalTime )
			end
		end
		-- if we are in a erebus / chaos / postboss room reset the timer
		thread( BiomeSpeedTimerLoop )
	end

	local currentArea = CurrentRun.CurrentRoom.BiomeMapArea or CurrentRun.CurrentRoom.RoomSetName
	if currentRoom.BiomeStartRoom and HeroHasTrait("SpeedRunBossKeepsake") then
		trait = GetHeroTrait("SpeedRunBossKeepsake")
		if trait.Timers[currentArea] ~= nil then
			CurrentRun.ActiveBiomeTimerKeepsake = true
			CurrentRun.SpeedRunBossKeepsakeTriggered = nil
			CurrentRun.BiomeTimeKeepsake = trait.Timers[currentArea]
		else
			CurrentRun.ActiveBiomeTimerKeepsake = false
		end
	elseif not HeroHasTrait("SpeedRunBossKeepsake") then
		CurrentRun.ActiveBiomeTimerKeepsake = false
	end

	if currentRoom.BiomeStartRoom and HeroHasTrait("BonusMoneyKeepsake") then
		ReduceTraitUses( GetHeroTrait("BonusMoneyKeepsake"), {Force = true })
	end
	if currentRoom.BiomeStartRoom then
		IncrementTableValue( CurrentRun, "ClearedBiomes" )
	end

	if GetNumMetaUpgrades("ExtraChanceReplenishMetaUpgrade") > 0 then
		local numRegenerationLastStands = 0
		for i, lastStand in pairs(CurrentRun.Hero.LastStands) do
			if lastStand.Name == "ExtraChanceReplenishMetaUpgrade" then
				numRegenerationLastStands = numRegenerationLastStands + 1
			end
		end
		while GetNumMetaUpgrades("ExtraChanceReplenishMetaUpgrade") > numRegenerationLastStands do
			AddLastStand({
				Name = "ExtraChanceReplenishMetaUpgrade",
				Unit = CurrentRun.Hero,
				Icon = "ExtraLifeReplenish",
				WeaponName = "LastStandMetaUpgradeShield",
				HealFraction = MetaUpgradeData.ExtraChanceReplenishMetaUpgrade.HealPercent,
				Silent = true
			})
			numRegenerationLastStands = numRegenerationLastStands + 1
		end
		CurrentRun.Hero.MaxLastStands = TableLength(CurrentRun.Hero.LastStands)
	end

	StartRoomPresentation( currentRun, currentRoom, darknessEarned )

	RemoveInputBlock({ Name = "StartRoom" })
	RemoveTimerBlock( currentRun, "StartRoom" )

	StartTriggers( currentRoom, roomData.DistanceTriggers )
	RunEventsGeneric( RoomEventData.GlobalRoomInputUnblockedEvents, currentRoom )
	RunEvents( currentRoom, roomData )
	RunTraitThreads( currentRun.Hero )
	UpdateWeaponMana()
	CheckAutoObjectiveSets( currentRun, "RoomStart" )

	if currentRoom.Encounter.SpawnDelay ~= nil then
		wait( currentRoom.Encounter.SpawnDelay )
	end

	if currentRoom.DisableWeapons then
		ToggleCombatControl( CombatControlsDefaults, false, roomData.Name)
	elseif currentRoom.DisableWeaponsExceptDash then
		ToggleCombatControl( { "Shout", "Assist", "Attack2", "Attack1", "Attack3", "AutoLock" }, false, roomData.Name )
	else
		ToggleCombatControl( CombatControlsDefaults, true, roomData.Name )
	end

	if not currentRoom.HideCombatUI then
		ShowCombatUI()
	end

	--[[
	DebugAssert({ Condition = CurrentRun.Hero.IsDead or AudioState.MusicId ~= nil or AudioState.SecretMusicId ~= nil or AudioState.AmbientMusicId ~= nil or currentRoom.NoReward or
		string.match( currentRoom.Name, "Test" ) ~= nil or string.match( currentRoom.Name, "Reprieve" ) ~= nil or string.match( currentRoom.Name, "B_Story01" ) ~= nil or
		currentRoom.Encounter.StartGlobalVoiceLines == "PerfectClearStartVoiceLines" or currentRoom.EndMusicOnEnterDuration ~= nil,
		Text = "Room started with no music!" })
		--]]

	CheckDashOverride( currentRoom )

	-- Take the room's StartTriggerDistance, otherwise the encounter's
	local startTriggerDistance = currentRoom.OverrideStartTriggerDistance or currentRoom.Encounter.StartTriggerDistance
	if startTriggerDistance ~= nil and startTriggerDistance > 0 then
		local encounterStartIds = GetIdsByType({ Name = "EncounterStartPoint" })
		if not IsEmpty( encounterStartIds ) then
			local notifyName = "EncounterStartDistance"
			NotifyWithinDistanceAny({ Ids = { currentRun.Hero.ObjectId }, DestinationIds = encounterStartIds, Distance = startTriggerDistance, Notify = notifyName })
			waitUntil( notifyName )
		end
	end
	
	RefillMana()
	local roomStartManaChangeValue = GetShrineUpgradeChangeValue( "RoomStartManaShrineUpgrade" )
	if roomStartManaChangeValue < 1.0 then
		local missingMana = GetHeroMaxAvailableMana() * (1.0 - roomStartManaChangeValue)
		ManaDelta( -missingMana, { IgnoreSpend = true })

	end	

	if currentRoom.Encounters ~= nil then
		for i, encounter in ipairs(currentRoom.Encounters) do
			if i > 1 then
				currentRoom.Encounter = currentRoom.Encounters[i]
			end
			StartEncounter( currentRun, currentRoom, currentRoom.Encounter )
			CheckInspectPoints( currentRun, roomData )
			--wait( 1.0, RoomThreadName )
		end
		currentRoom.AllEncountersCompleted = true
		if CheckRoomExitsReady( currentRoom ) then
			UnlockRoomExits( currentRun, currentRoom )
		end
	else
		StartEncounter( currentRun, currentRoom, currentRoom.Encounter )
		CheckInspectPoints( currentRun, roomData )
	end	

	StartTriggers( currentRoom, roomData.PostCombatDistanceTriggers )

end

function SetupRoomArt( currentRun, currentRoom )

	local roomData = RoomData[currentRoom.Name] or currentRoom

	if roomData.FootstepAnimationL ~= nil then
		SwapAnimation({ Name = "FireFootstepL-Spawner", DestinationName = roomData.FootstepAnimationL })
	end
	if roomData.FootstepAnimationR ~= nil then
		SwapAnimation({ Name = "FireFootstepR-Spawner", DestinationName = roomData.FootstepAnimationR })
	end

	if roomData.SwapAnimations ~= nil then
		for fromAnim, toAnim in pairs( roomData.SwapAnimations ) do
			SwapAnimation({ Name = fromAnim, DestinationName = toAnim })
		end
	end

	if roomData.SwapSounds ~= nil then
		for fromSound, toSound in pairs( roomData.SwapSounds ) do
			SwapSound({ Name = fromSound, DestinationName = toSound })
		end
	end

end

function WaitForNextEncounterReady()
	while not IsEmpty( MapState.RoomRequiredObjects ) or IsScreenOpen( "UpgradeChoice" ) or IsScreenOpen( "BoonMenu" ) or IsScreenOpen( "Dialog" ) do
		wait( 0.5 )
	end
end

function ShipsEncounterSetup( encounter, args )	
	args = args or {}
	local wheelId = GetIdsByType({ Name = "ShipsSteeringWheel" })[1]
	local wheel = MapState.ActiveObstacles[wheelId]
	UseableOff({ Id = wheelId })
	RecordObjectState( CurrentRun.CurrentRoom, wheelId, "UseableOff", true )

	if EncounterData[encounter.Name].SkipShipsEncounterSetup then
		return
	end

	local wheelRewardObstacles = {}
	local twoRewardChoice = false
	MapState.ShipWheels = {}
	if RandomChance(EncounterData[encounter.Name].TwoRewardChoiceChance or 1) then
		twoRewardChoice = true

		local wheelLeft = DeepCopyTable( ObstacleData.ShipsSteeringWheelLeft )
		wheelLeft.ObjectId = SpawnObstacle({ Name = "ShipsSteeringWheelLeft", DestinationId = wheelId, Group = "Standing", OffsetX = -185, OffsetY = -105 })
		SetupObstacle( wheelLeft )
		wheelLeft.CanBeRerolled = true
		wheelLeft.ReadyToUse = true
		wheelLeft.WheelObstacleId = wheelId
		table.insert( wheelRewardObstacles, wheelLeft )
		MapState.ShipWheels[wheelLeft.ObjectId] = wheelLeft

		local wheelRight = DeepCopyTable( ObstacleData.ShipsSteeringWheelRight )
		wheelRight.ObjectId = SpawnObstacle({ Name = "ShipsSteeringWheelRight", DestinationId = wheelId, Group = "Standing", OffsetX = 175, OffsetY = 80 })
		SetupObstacle( wheelRight )
		wheelRight.CanBeRerolled = true
		wheelRight.ReadyToUse = true
		wheelRight.WheelObstacleId = wheelId
		table.insert( wheelRewardObstacles, wheelRight )
		MapState.ShipWheels[wheelRight.ObjectId] = wheelRight
	else
		table.insert( wheelRewardObstacles, wheel )
		wheel.CanBeRerolled = true
		wheel.ReadyToUse = true
		MapState.ShipWheels[wheel.ObjectId] = wheel
	end

	ShipsSteeringWheelChoicePresentation( wheel )

	local rewardsChosen = {}
	local rewardStoreName = ChooseNextRewardStore( CurrentRun )
	for k, wheelObstacle in pairs( wheelRewardObstacles ) do
		UseableOn({ Id = wheelObstacle.ObjectId })
		wheelObstacle.Room = CurrentRun.CurrentRoom
		wheelObstacle.RewardStoreName = rewardStoreName
		wheelObstacle.ChosenRewardType = ChooseRoomReward( CurrentRun, CurrentRun.CurrentRoom, rewardStoreName, rewardsChosen, { IgnoreForcedReward = true } )
		SetupRoomReward( CurrentRun, wheelObstacle.Room, rewardsChosen, { ChosenRewardType = wheelObstacle.ChosenRewardType, AlwaysSetupForceLootName = true } )
		wheelObstacle.ForceLootName = wheelObstacle.Room.ForceLootName
		table.insert( rewardsChosen, { RewardType = wheelObstacle.ChosenRewardType, ForceLootName = wheelObstacle.ForceLootName } )
		CreateDoorRewardPreview( wheelObstacle, wheelObstacle.ChosenRewardType, wheelObstacle.ForceLootName )
		thread( ExitDoorUnlockedPresentation, wheelObstacle )
		thread( DirectionHintPresentation, wheelObstacle, { Cooldown = 0.0, Delay = 0 } )
	end

	-- Wait for selection
	waitUntil("ShipsEncounterSelected")

	ShipsSteeringWheelSelectionPresentation( wheelId )

	StartEncounterEffects( CurrentRun )

	for k, wheelObstacle in pairs( wheelRewardObstacles ) do
		DestroyDoorRewardPresenation( wheelObstacle )
		if twoRewardChoice then
			Destroy({ Id = wheelObstacle.ObjectId })
		end
	end

end

function GetShipWheelUseText( useTarget, args )
	if useTarget.CanBeRerolled and useTarget.RerollFunctionName ~= nil and CurrentRun.NumRerolls > 0 and HasHeroTraitValue( "AllowDoorReroll" ) then
		return args.Reroll
	end
	return args.Default
end

function UseShipWheel( wheel )
	CurrentRun.CurrentRoom.Encounter.RewardStoreName = wheel.RewardStoreName
	CurrentRun.CurrentRoom.Encounter.EncounterRoomRewardOverride = wheel.ChosenRewardType
	CurrentRun.CurrentRoom.ForceLootName = wheel.ForceLootName
	notifyExistingWaiters( "ShipsEncounterSelected" )
end

function RestoreUnlockRoomExits( currentRun, currentRoom )

	DebugPrint({ Text = "RestoreUnlockRoomExits: "..currentRoom.Name.." (RunDepth = "..currentRun.RunDepthCache..")".." (BiomeDepth = "..currentRun.BiomeDepthCache..")".." (Seed = "..GetGlobalRng().seed..")" })
	currentRoom.RestoreUnlockRoomExits = true

	if currentRoom.CameraWalls then
		CreateCameraWalls({ })
	end

	AddInputBlock({ Name = "RestoreUnlockRoomExits" })
	AddTimerBlock( currentRun, "RestoreUnlockRoomExits" )
	SetupHeroObject( currentRoom )
	ApplyTraitSetupFunctions( CurrentRun.Hero, { Context = "StartRoom" } )
	
	for weaponName in pairs(currentRun.Hero.Weapons) do
		local weaponData = GetWeaponData( currentRun.Hero, weaponName ) 
		RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
	end
	SwitchActiveUnit({ Id = currentRun.Hero.ObjectId })

	currentRoom.ActiveEncounters = {}
	SetupPreActivatedEnemies( currentRoom )
	DisableRoomTraps()
	AssignObstacles( currentRoom )

	HandleSecretSpawns( currentRun )
	StartRoomPreLoadBinks({
		Run = currentRun,
		Room = currentRoom,
		Encounter = currentRoom.Encounter,
		ChallengeEncounter = currentRoom.ChallengeEncounter
	})

	RestoreObjectStates( currentRoom )

	if EncounterData[currentRoom.Encounter.Name].EnemiesToRestore ~= nil then
		for i, enemyToRestore in ipairs( EncounterData[currentRoom.Encounter.Name].EnemiesToRestore ) do
			RestoreEncounterSpawn( currentRoom.Encounter, enemyToRestore )
		end
	end

	if EncounterData[currentRoom.Encounter.Name].ObstaclesToRestore ~= nil then
		for i, obstacleToRestore in ipairs( EncounterData[currentRoom.Encounter.Name].ObstaclesToRestore ) do
			RestoreEncounterObstacle( currentRoom.Encounter, obstacleToRestore )
		end
	end

	if currentRoom.Encounter.RewardsToRestore ~= nil then
		for id, rewardToRestore in pairs( currentRoom.Encounter.RewardsToRestore ) do
			local reward = SpawnRoomReward( room, rewardToRestore )
			MapState.OptionalRewards[reward.ObjectId] = reward
		end
	end

	-- Active ExitDoors
	local exitDoorIds = GetInactiveIds({ Name = "ExitDoors" })
	local firstDoor = true
	while not IsEmpty( exitDoorIds ) do
		local doorId = RemoveRandomValue( exitDoorIds )
		if firstDoor or RandomChance( currentRun.CurrentRoom.ExtraDoorActivateChance or 1.0 ) then
			Activate({ Id = doorId })
			firstDoor = false
		end
	end

	FadeOut({ Color =  Color.Black, Duration = 0 })

	SetupRoomArt( currentRun, currentRoom )

	CheckDashOverride( currentRoom )

	wait(0.6) -- Let object restoration transitions finish before fade in
	
	RemoveInputBlock({ Name = "RestoreUnlockRoomExits" })

	if currentRoom.StartRoomPresentationOnReload then
		StartRoomPresentation( currentRun, currentRoom )
	else
		RestoreUnlockRoomExitsPresentation( currentRun, currentRoom )
	end

	RunEventsGeneric( RoomEventData.GlobalRoomPostCombatReloadInputUnblockedEvents, currentRoom )
	if currentRoom.DistanceTriggersPostCombatReload then
		StartTriggers( currentRoom, currentRoom.DistanceTriggers )
	end
	RunEventsGeneric( RoomData[currentRoom.Name].PostCombatReloadEvents, currentRoom )
	RunThreadedEvents( RoomData[currentRoom.Name].PostCombatReloadThreadedEvents, currentRoom )

	CheckInspectPoints( currentRun, currentRoom )

	StartTriggers( currentRoom, currentRoom.PostCombatDistanceTriggers )

	wait(0.1)

	DoUnlockRoomExits( currentRun, currentRoom )

	wait(0.1)

	
	RemoveTimerBlock(currentRun, "RestoreUnlockRoomExits")
	if currentRoom.DisableWeapons then
		ToggleCombatControl( CombatControlsDefaults, false )
	else
		ToggleCombatControl( CombatControlsDefaults, true )
	end

	if not currentRoom.HideCombatUI then
		ShowCombatUI()
	end

	if GetNumShrineUpgrades("BiomeSpeedShrineUpgrade") > 0 then
		thread( BiomeSpeedTimerLoop )
	end


end

function LoadSpawnPackages( encounter )

	for _, packageData in pairs(GetHeroTraitValues("LoadPackages")) do
		if type(packageData) == "table" then
			LoadPackages({ Names = packageData })
		else
			LoadPackages({ Name = packageData })
		end
	end

	if encounter.Spawns == nil then
		return
	end

	for k, spawnData in pairs( encounter.Spawns ) do
		LoadPackages({ Name = spawnData.Name })
	end
end

function LoadVoiceBanks( characters )
	if type(characters) == "table" then
		for _, value in pairs(characters) do
			LoadVoiceBanks(value)
		end
	elseif type(characters) == "string" then
		LoadVoiceBank({ Name = characters })
	end
end

function SetupPreActivatedEnemies( source )

	for enemyName, enemyData in pairs( EnemyData ) do
		if not enemyData.SkipDefaultSetup then
			local ids = GetIdsByType({ Name = enemyName })
			for k, id in pairs( ids ) do
				local unit = DeepCopyTable( enemyData )
				unit.ObjectId = id
				thread( SetupUnit, unit, CurrentRun, { SkipAISetup = source.PreActivatedSkipAISetup } )
			end
		end
	end

end

function SetupHeroObject( room, applyLuaUpgrades )

	local currentRun = CurrentRun	
	local heroIds = GetIdsByType({ Name = room.HeroUnitName or "_PlayerUnit" })
	DebugAssert({ Condition = #heroIds <= 1, Text = "Too many _PlayerUnit objects on map!" })
	currentRun.Hero.ObjectId = heroIds[1]
	AttachLua({ Id = currentRun.Hero.ObjectId, Table = currentRun.Hero })

	local hero = currentRun.Hero
	local roomData = RoomData[room.Name] or CurrentHubRoom

	if room.HeroOverwrites ~= nil then
		OverwriteSelf( hero, room.HeroOverwrites )
	end

	AddToGroup({ Id = currentRun.Hero.ObjectId, Name = "HeroTeam" })

	GatherAndEquipWeapons( currentRun )

	-- Laurel Crown VFX
	if currentRun.Hero.AttachedAnimationName ~= nil then
		CreateAnimation({ Name = currentRun.Hero.AttachedAnimationName, DestinationId = currentRun.Hero.ObjectId })
	end

	if roomData.HeroCreateAnimation ~= nil then
		CreateAnimation({ Name = roomData.HeroCreateAnimation, DestinationId = currentRun.Hero.ObjectId })
	end

	SetupHeroLight()

	-- Clear per-room state - consider moving to MapState if it doesn't need to be object specific
	CurrentRun.Hero.InvulnerableFlags = {}
	CurrentRun.Hero.UntargetableFlags = {}
	CurrentRun.Hero.ImmuneToForceFlags = {}
	currentRun.Hero.PlayingVoiceLine = nil
	currentRun.Hero.QueuedVoiceLines = {}
	currentRun.Hero.SpeechParams = currentRun.Hero.SpeechParams or {}
	currentRun.Hero.StatusAnimation = nil
	currentRun.Hero.PrevStatusAnimation = nil
	currentRun.Hero.BlockStatusAnimations = nil
	currentRun.Hero.ActiveEffects = {}
	currentRun.Hero.Frozen = false
	currentRun.Hero.Mute = false
	currentRun.Hero.Reloading = false
	currentRun.Hero.KillStealVictimId = nil
	currentRun.Hero.KillStolenFromId = nil
	currentRun.Hero.ComboCount = 0
	currentRun.Hero.ComboReady = false
	currentRun.Hero.VacuumRush = false
	if currentRun.Hero.ManaData and currentRun.Hero.ManaData.BaseManaRegen and currentRun.Hero.ManaData.BaseManaRegen > 0 then
		ManaRegenSetup( currentRun.Hero, { Name = "Innate", ManaRegenPerSecond = currentRun.Hero.ManaData.BaseManaRegen })
	end
	-- Easy mode Check
	if ConfigOptionCache.EasyMode then
		if not HeroHasTrait( "GodModeTrait") then
			AddTraitToHero({ TraitName = "GodModeTrait", SkipUIUpdate = true })
		end
	else
		RemoveTrait( currentRun.Hero, "GodModeTrait" )
	end
	-- Build all upgrades.
	UpdateHeroTraitDictionary()
	CheckActivatedTraits( CurrentRun.Hero, true )
	ApplyMetaUpgrades( currentRun.Hero, applyLuaUpgrades )
	ApplyTraitUpgrade( currentRun.Hero, applyLuaUpgrades )
	ApplyTraitSetupFunctions( currentRun.Hero )
	ApplyMetaModifierHeroUpgrades( currentRun.Hero, applyLuaUpgrades )
	ApplyAllTraitWeapons( currentRun.Hero )

	for k, trait in pairs( currentRun.Hero.Traits ) do
		if trait.RoomCooldown ~= nil then
			IncrementTraitCooldown( trait )
		end
		if trait.TimeCooldown ~= nil then
			IncrementTraitCooldown( trait, trait.TimeCooldown)
		end
	end
	
	SetupCostume()

	CheckAttachmentTextures( CurrentRun.Hero )

	SetLightBarColor({ PlayerIndex = 1, Color = currentRun.Hero.LightBarColor or HeroData.LightBarColor });
	
	RunEventsGeneric( HeroData.SetupEvents, hero, args )

end

function CheckAttachmentTextures( source, args )
	for itemName, itemData in pairs( WeaponShopItemData ) do
		if GameState.WorldUpgrades[itemName] and itemData.TextureData ~= nil then
			SetAnimation({ DestinationId = source.ObjectId, Name = itemData.TextureData.Animation })
			SetThingProperty({ Property = "GrannyTexture", AttachmentMeshName = itemData.TextureData.Model, Value = itemData.TextureData.Texture, DestinationId = source.ObjectId })
		end
	end
	SetAnimation({ DestinationId = source.ObjectId, Name = GetThingDataValue({ Id = source.ObjectId, Property = "Graphic" }) })
end

function SetupHeroLight()
	local currentRun = CurrentRun
	local roomData = RoomData[currentRun.CurrentRoom.Name] or currentRun.CurrentRoom
	if currentRun.Hero.AttachedLightName ~= nil and not roomData.BlockHeroLight then
		local heroGroup = GetGroupName({ Id = currentRun.Hero.ObjectId, DrawGroup = true })
		local heroLightGroup = "HeroLight"
		for i = 1, (HeroData.AttachedLightCount or 1) do
			local heroLightId = SpawnObstacle({ Name = HeroData.AttachedLightName, DestinationId = currentRun.Hero.ObjectId, Group = heroLightGroup })
			SetScale({ Id = heroLightId, Fraction = HeroData.AttachedLightScale })
			SetColor({ Id = heroLightId, Color = HeroData.AttachedLightColor })
			Attach({ Id = heroLightId, DestinationId = currentRun.Hero.ObjectId })
			currentRun.Hero.AttachedLightId = heroLightId
		end
		InsertGroupBehind({ Name = heroLightGroup, DestinationName = heroGroup })
	end
end

function StartRoomPreLoadBinks( args )

	local currentRun = args.Run
	local room = args.Room

	local binksToPreload = ShallowCopyTable( UIData.Binks )
	if room ~= nil and room.Binks ~= nil then
		ConcatTableValues( binksToPreload, room.Binks )
	end

	local dedupe = {}
	local finalBinksToPreload = {}
	for i, name in ipairs( binksToPreload ) do
		if dedupe[name] == nil then
			dedupe[name] = name
			table.insert( finalBinksToPreload, name )
		end
	end

	PreLoadBinks({ Names = finalBinksToPreload })

end

function BeginArachneEncounter()
	StartEncounterEffects( CurrentRun )
end

function BeginArtemisEncounter()
	StartEncounterEffects( CurrentRun )
end

function BeginIcarusEncounter()
	StartEncounterEffects( CurrentRun )
end

function BeginHeraclesEncounter(encounter)
	InvalidateCheckpoint()
	StartEncounterEffects( CurrentRun )
end

function BeginNemesisEncounter()
	InvalidateCheckpoint()
	StartEncounterEffects( CurrentRun )
end

function BeginPerfectClearEncounter()
	StartEncounterEffects( CurrentRun )
end

function BeginSurvivalEncounter()
	StartEncounterEffects( CurrentRun )
end

function BeginWrappingEncounter()
	StartEncounterEffects( CurrentRun )
end

function BeginOpeningEncounter()
	StartEncounterEffects( CurrentRun )
end

function StartEncounter( currentRun, currentRoom, encounter )

	if encounter.Completed then
		return
	end

	local roomData = RoomData[currentRoom.Name]
	local encounterData = EncounterData[encounter.Name] or encounter

	if CurrentRun.CurrentRoom.Encounter.EncounterType ~= "NonCombat" then
		if encounter.ForceEncounterStart or ( CurrentRun.CurrentRoom.Encounter == encounter and encounter ~= currentRoom.ChallengeEncounter and not CurrentRun.CurrentRoom.Encounter.DelayedStart ) then
			StartEncounterEffects( currentRun )
		end
	end

	if encounter.EncounterType == "Default" then
		DebugPrint({ Text = encounter.Name })
		local encounterDifficulty = encounter.DifficultyRating or "?"
		DebugPrint({ Text = "    Encounter Difficulty = "..encounterDifficulty })
		for waveIndex, wave in pairs(encounter.SpawnWaves) do
			DebugPrint({ Text = "        Wave #"..waveIndex })
			local waveDifficulty = wave.DifficultyRating or "?"
			DebugPrint({ Text = "        Wave Difficulty = "..waveDifficulty })
			if wave.TypeCount ~= nil then
				DebugPrint({ Text = "        Max Types: "..wave.TypeCount })
			end

			local totalActualDifficultyRating = 0
			for k, spawnEnemyArgs in pairs(wave.Spawns) do
				local enemyName = spawnEnemyArgs.Name or k or "?"
				local enemyCount = spawnEnemyArgs.TotalCount or spawnEnemyArgs.CountMax or "?"
				local enemyDifficultyRatingTotal = 0
				if enemyCount and spawnEnemyArgs.GeneratorData ~= nil then
					enemyDifficultyRatingTotal = ( enemyCount * spawnEnemyArgs.GeneratorData.DifficultyRating )
				end
				totalActualDifficultyRating = totalActualDifficultyRating + enemyDifficultyRatingTotal
				DebugPrint({ Text = "            "..enemyName.." "..enemyCount.." ("..enemyDifficultyRatingTotal..") " })
			end

			if wave.TypeCount ~= nil then
				DebugPrint({ Text = "    Spawned Difficulty Rating: "..totalActualDifficultyRating })
			end
		end
	end

	encounter.Completed = false
	encounter.InProgress = true
	currentRoom.EncountersOccurredCache[encounter.Name] = true
	if encounter.CountsForRoomEncounterDepth then
		currentRoom.EncounterDepth = (currentRoom.EncounterDepth or 1) + 1
		currentRun.BiomeEncounterDepth = (currentRun.BiomeEncounterDepth or 1) + 1
		currentRun.EncounterDepth = currentRun.EncounterDepth + 1
	end
	table.insert(currentRoom.ActiveEncounters, encounter)
	if encounter.TimerBlock ~= nil then
		AddTimerBlock( currentRun, encounter.TimerBlock )
	end
	if CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth <= HealthUI.LowHealthThreshold and not currentRoom.HideLowHealthShroud then
		HeroDamageLowHealthPresentation( true )
	end
	if CurrentRun.CurrentRoom.Encounter == encounter and encounter ~= currentRoom.ChallengeEncounter then
		local goldPerRoom = round( GetTotalHeroTraitValue("MoneyPerRoom") )
		if HasHeroTraitValue( "BlockMoney" ) then
			goldPerRoom = 0
		end
		if goldPerRoom > 0 then
			thread( PassiveGoldGainPresentation, goldPerRoom )
			AddResource( "Money", goldPerRoom, "HermesMoneyTrait" )
		end
	end

	StartTriggers( encounter, encounterData.DistanceTriggers )

	RunEvents( encounter, encounterData )

	StartTriggers( encounter, encounter.PostCombatDistanceTriggers )

	RemoveValue(currentRoom.ActiveEncounters, encounter)
	encounter.Completed = true
	if encounter.EncounterType == "Miniboss" or encounter.EncounterType == "Boss" then
		UpdateSpellActiveStatus()
	end
	currentRun.EncountersCompletedCache[encounter.Name] = (currentRun.EncountersCompletedCache[encounter.Name] or 0) + 1
	GameState.EncountersCompletedCache[encounter.Name] = (GameState.EncountersCompletedCache[encounter.Name] or 0) + 1

	-- Check for encounter-end effects
	if encounter and encounter.StartTime and not encounter.ClearTime then
		encounter.ClearTime = _worldTime - encounter.StartTime
	end
	EndEncounterEffects( currentRun, currentRoom, encounter )
	if not encounter.SkipDisableTrapsOnEnd then
		DisableRoomTraps()
	end

	if encounter ~= nil and encounter.RemoveUpgradeOnEnd ~= nil then
		RemoveEnemyUpgrade(encounter.RemoveUpgradeOnEnd, CurrentRun)
	end

	-- Check for encounter complete exit	
	wait( roomData.EncounterCompleteWait or 0.2, RoomThreadName )
	if CheckRoomExitsReady( currentRoom ) then
		UnlockRoomExits( currentRun, currentRoom )
	end

end

function GiveRandomConsumables( args )
	args = args or {}
	wait( args.Delay, RoomThreadName )

	local multiplier = args.LootMultiplier or 1
	local range = args.Range or 150
	local force = args.Force or RandomFloat( args.ForceMin or 75, args.ForceMax or 150 )
	local angle = args.Angle or RandomFloat( args.AngleMin or 0, args.AngleMax or 360 )
	local upwardAngle = args.UpwardAngle or RandomFloat( args.UpwardForceMin or 500, args.UpwardForceMax or 700 )
	local angleOffset = 0
	local destinationId = args.DestinationId or CurrentRun.Hero.ObjectId
	for i, lootData in ipairs( args.LootOptions ) do
		if lootData.Chance ~= nil then
			if RandomChance( lootData.Chance * multiplier) and ( IsEmpty( lootData.GameStateRequirements ) or IsGameStateEligible( CurrentRun, lootData.GameStateRequirements ) ) then
				local consumableId = SpawnObstacle({ Name = lootData.Name, DestinationId = destinationId, Group = "Standing",
					OffsetX = RandomFloat( -1 * range, range ),
					OffsetY = RandomFloat( -1 * range, range ),
					ForceToValidLocation = args.ForceToValidLocation })
				local consumable = CreateConsumableItem( consumableId, lootData.Name, 0 )
				if lootData.Overrides ~= nil then
					for key, value in pairs( lootData.Overrides ) do
						if consumable[key] ~= nil then
							consumable[key] = value
						end
					end
				end
				ApplyConsumableItemResourceMultiplier( {}, consumable )
				ExtractValues( CurrentRun.Hero, consumable, consumable )
				if not args.NotRequiredPickup then
					MapState.RoomRequiredObjects[consumable.ObjectId] = consumable
				end
				if not args.KeepCollision then
					SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = consumable.ObjectId })
					SetObstacleProperty({ Property = "CollidesWithObstacles", Value = false, DestinationId = consumable.ObjectId })
				end
				ApplyUpwardForce({ Id = consumableId, Speed = upwardAngle })
				ApplyForce({ Id = consumableId, Speed = force, Angle = angle + angleOffset, SelfApplied = true })
				angleOffset = angleOffset + (args.AngleIncrement or 0)
				if args.DropFunctionName ~= nil then
					CallFunctionName( args.DropFunctionName, consumable, args)
				end
				if args.AddUnthreadedOnUseEvent ~= nil then
					consumable.OnUseEvents = consumable.OnUseEvents or {}
					table.insert( consumable.OnUseEvents, args.AddUnthreadedOnUseEvent )
				end
			end
		else
			local amount = lootData.Amount or RandomInt( (lootData.MinAmount or 1) * multiplier , (lootData.MaxAmount or 1) * multiplier )
			if lootData.Name == "Currency" then
				if args.MultiplyMoney then
					amount = amount * GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )
				end
				thread( GushMoney, { Amount = amount, LocationId = destinationId, Source = "GiveRandomConsumables" } )
			else
				for i = 1, amount do
					local consumableId = SpawnObstacle({ Name = lootData.Name, DestinationId = destinationId, Group = "Standing",
						OffsetX = RandomFloat( -1 * range, range ),
						OffsetY = RandomFloat( -1 * range, range ),
						ForceToValidLocation = args.ForceToValidLocation })
					local consumable = CreateConsumableItem( consumableId, lootData.Name, 0, args )
					if lootData.Overrides ~= nil then
						for key, value in pairs( lootData.Overrides ) do
							if consumable[key] ~= nil then
								consumable[key] = value
							end
						end
					end
					ApplyConsumableItemResourceMultiplier( {}, consumable )
					ExtractValues( CurrentRun.Hero, consumable, consumable )
					SetupResourceText( consumable )
					if not args.NotRequiredPickup then
						MapState.RoomRequiredObjects[consumable.ObjectId] = consumable
					end
					if not args.KeepCollision then
						SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = consumable.ObjectId })
						SetObstacleProperty({ Property = "CollidesWithObstacles", Value = false, DestinationId = consumable.ObjectId })
					end
					ApplyUpwardForce({ Id = consumableId, Speed = upwardAngle })
					ApplyForce({ Id = consumableId, Speed = force, Angle = angle + angleOffset, SelfApplied = true })
					angleOffset = angleOffset + (args.AngleIncrement or 0)
					if args.DropFunctionName ~= nil then
						CallFunctionName( args.DropFunctionName, consumable, args)
					end
					if args.AddUnthreadedOnUseEvent ~= nil then
						consumable.OnUseEvents = consumable.OnUseEvents or {}
						table.insert( consumable.OnUseEvents, args.AddUnthreadedOnUseEvent )
					end
					if lootData.Interval ~= nil then
						wait( lootData.Interval )
					end	
				end
			end
		end
	end
end

function GiveLoot( args )
	args = args or {}
	local lootData = ChooseLoot( { args.ExcludeLootName }, args.ForceLootName )
	if lootData ~= nil then
		if not args.BoughtFromShop then
			for k, trait in pairs( CurrentRun.Hero.Traits ) do
				if trait.ForceBoonName == lootData.Name then
					ReduceTraitUses( trait )
				end
			end
		end
		local loot = CreateLoot(MergeTables({ Name = lootData.Name }, args))
        return loot
	end
end

function CreateStackLoot( args )
	args = args or {}
	if args.StackNum == nil then
		args.StackNum = 1
	end
	return CreateLoot( MergeTables( args, { Name = "StackUpgrade" } ) )
end

function CreateWeaponLoot( args )
	args = args or {}
	return CreateLoot( MergeTables( args, { Name = "WeaponUpgrade" } ) )
end


function CreateManaLoot( args )
	args = args or {}
	return CreateLoot( MergeTables( args, { Name = "ManaUpgrade" } ) )
end

function CreateHermesLoot( args )
	args = args or {}
	return CreateLoot( MergeTables( args, { Name = "HermesUpgrade" } ) )
end

function IsRarityForcedCommon( name, args )
	args = args or {}
	if CurrentRun.CurrentRoom.ForceCommonLootFirstRun and GetCompletedRuns() == 0 then
		return true
	end

	local referencedTable = "BoonData"
	if name == "StackUpgrade" then
		return true
	elseif name == "WeaponUpgrade" then
		return true
	end

	if CurrentRun.Hero[referencedTable] ~= nil and CurrentRun.Hero[referencedTable].AllowRarityOverride and CurrentRun.CurrentRoom.BoonRaritiesOverride then
		return false
	end

	if CurrentRun.Hero[referencedTable] == nil or CurrentRun.Hero[referencedTable].ForceCommon then
		return true
	end
	local referencedData = nil
	if LootData[name] then
		referencedData = LootData[name]
	elseif FieldLootData[name] then
		referencedData = FieldLootData[name]
	end
	if not args.IgnoreCurse and HeroHasTrait("ChaosCommonCurse") and referencedTable  == "BoonData" and 
		((referencedData.GodLoot or referencedData.TreatAsGodLootByShops) and not referencedData.BlockForceCommon ) then
		return true
	end
	return false
end

function GetRarityChances( loot )
	local name = loot.Name
	local ignoreTempRarityBonus = loot.IgnoreTempRarityBonus
	local referencedTable = "BoonData"
	if name == "StackUpgrade" then
		referencedTable = "StackData"
	elseif name == "WeaponUpgrade" then
		referencedTable = "WeaponData"
	elseif name == "HermesUpgrade" then
		referencedTable = "HermesData"
	end

	local rarityChances = ShallowCopyTable(CurrentRun.Hero[referencedTable].RarityChances) or {}
	for rarityName in pairs( TraitRarityData.RarityValues ) do
		rarityChances[rarityName] = rarityChances[rarityName] or 0
	end

	if CurrentRun.CurrentRoom.BoonRaritiesOverride then
		for rarityName in pairs( TraitRarityData.RarityValues ) do
			loot.AddBoostedAnimation = true
			rarityChances[rarityName] = CurrentRun.CurrentRoom.BoonRaritiesOverride[rarityName] or rarityChances[rarityName]
		end
	elseif loot.BoonRaritiesOverride then
		for rarityName in pairs( TraitRarityData.RarityValues ) do
			loot.AddBoostedAnimation = true
			rarityChances[rarityName] = loot.BoonRaritiesOverride[rarityName] or rarityChances[rarityName]
		end
	end

	local rarityTraits = GetHeroTraitValues("RarityBonus", { UnlimitedOnly = ignoreTempRarityBonus })
	for i, rarityTraitData in pairs(rarityTraits) do
		if ( rarityTraitData.RequiredGod == nil or rarityTraitData.RequiredGod == name ) 
			and ( rarityTraitData.GodLootOnly == nil or (rarityTraitData.GodLootOnly and ( loot.GodLoot or loot.TreatAsGodLootByShops ))) then
			for rarityName in pairs( TraitRarityData.RarityValues ) do
				if rarityTraitData[rarityName] then
					rarityChances[rarityName] = rarityChances[rarityName] + rarityTraitData[rarityName]
				end
			end
		end
	end
	return rarityChances
end

function AllAtLeastRarity( loot, baseRarity )
	if IsEmpty(loot.UpgradeOptions) then
		return false
	end
	for i, traitData in pairs( loot.UpgradeOptions ) do
		if GetRarityValue( traitData.Rarity ) < GetRarityValue( baseRarity ) then
			return false
		end
	end
	return true
end

function HasAtLeastRarity( loot, baseRarity )
	if IsEmpty(loot.UpgradeOptions) then
		return false
	end
	for i, traitData in pairs( loot.UpgradeOptions ) do
		if GetRarityValue( traitData.Rarity ) >= GetRarityValue( baseRarity ) then
			return true
		end
	end
	return false
end

function HasTraitOnLoot( loot, traitName )
	for i, traitData in pairs( loot.UpgradeOptions ) do
		if traitData.ItemName == traitName then
			return true
		end
	end
	return false
end

function HasExchangeOnLoot( loot )
	if loot == nil or loot.UpgradeOptions == nil then
		return
	end
	for i, traitData in pairs( loot.UpgradeOptions ) do
		if traitData.TraitToReplace ~= nil then
			return true
		end
	end
	return false
end

function HasTraitsOnLoot( loot, traitNames )
	if loot == nil or loot.UpgradeOptions == nil then
		return false
	end
	for i, traitData in pairs( loot.UpgradeOptions ) do
		if Contains(traitNames, traitData.ItemName) then
			return true
		end
	end
	return false
end

function CreateLoot( args )

	RandomSynchronize()
	local lootPointId = args.SpawnPoint or SelectLootSpawnPoint( CurrentRun.CurrentRoom, args )
	if lootPointId == nil then
		DebugAssert({ Text = "GiveLoot: trying to give loot but there are no eligible LootPoint objects in room.", Owner = "Eduardo" })
	end
	local lootData = args.LootData or LootData[args.Name]
	local loot = DeepCopyTable( lootData )
	local lootId = SpawnObstacle({ Name = lootData.Name, DestinationId = lootPointId, Group = "Standing", OffsetX = args.OffsetX, OffsetY = args.OffsetY })
	loot.ObjectId = lootId
	loot.BlockExitText = "ExitBlockedByBoon"
	loot.BoughtFromShop = args.BoughtFromShop
	loot.StackNum = args.StackNum or loot.StackNum
	loot.ExchangeOnlyFromLootName = args.ExchangeOnlyFromLootName

	if not GameData.MissingPackages[loot.Name] then
		LoadPackages({ Name = loot.Name })
	end
	if loot.SpeakerName then
		LoadVoiceBanks(loot.SpeakerName)
	end

	SetTraitsOnLoot( loot, args )

	if args.AddBoostedAnimation or loot.AddBoostedAnimation then
		CreateAnimation({ DestinationId = loot.ObjectId, Name = "RoomRewardAvailableRareSparkles" })
	end
	if args.SuppressFlares then
		StopAnimation({ DestinationId = loot.ObjectId, Names = { "BoonOrbSpawn", "BoonOrbSpawn2", "PickupFlare", "PickupFlareA", "PickupFlareA2", "PickupFlareB01", "PickupFlareB02" }, })
	end

	AddToGroup({ Id = lootId, Name = "Loot" })
	loot.MenuNotify = UIData.BoonMenuId
	if not args.DoesNotBlockExit then
		MapState.RoomRequiredObjects[lootId] = loot
	end
	LootObjects[lootId] = loot

	local lootId = loot.ObjectId
	AttachLua({ Id = lootId, Table = loot })
	SetColor({ Id = lootId, Color = loot.LootColor, Duration = 0 })
	LootSpawnPresentation( loot, args )

	if args.ResourceCosts ~= nil then
		loot.ResourceCosts = ShallowCopyTable( args.ResourceCosts )
		local costMultiplier = 1 + ( MetaUpgradeData.ShopPricesShrineUpgrade.ChangeValue - 1 )
		costMultiplier = costMultiplier * GetTotalHeroTraitValue("StoreCostMultiplier", {IsMultiplier = true, Multiplicative = true})
		if costMultiplier ~= 1 then
			for name, cost in pairs( loot.ResourceCosts ) do
				loot.ResourceCosts[name] = round( cost * costMultiplier )
			end
		end
		UpdateCostText( loot )
	end

	if loot.SetupEvents ~= nil then
		RunEventsGeneric( loot.SetupEvents, loot, args )
	end

	return loot
end

function SelectLootSpawnPoint( currentRoom, args )
	args = args or {}
	if currentRoom.SpawnPoints.Loot == nil or IsEmpty( currentRoom.SpawnPoints.Loot ) then
		currentRoom.SpawnPoints.Loot = GetIdsByType({ Name = "LootPoint" })
	end

	if args.IgnoreLootPoints or currentRoom.SpawnPoints.Loot == nil or IsEmpty( currentRoom.SpawnPoints.Loot ) then
		return SelectRoomRewardSpawnPoint( currentRoom )
	end

	return GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = currentRoom.SpawnPoints.Loot })
end

function SelectRoomRewardSpawnPoint( currentRoom )
	if currentRoom.SpawnRewardOnId then
		return currentRoom.SpawnRewardOnId
	end

	local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints" })
	if spawnPointId <= 0 then
		if currentRoom.SpawnPoints.Loot == nil or IsEmpty(currentRoom.SpawnPoints.Loot) then
			currentRoom.SpawnPoints.Loot = GetIdsByType({ Name = "LootPoint" })
		end
		spawnPointId = RemoveRandomValue(currentRoom.SpawnPoints.Loot) or -1
	end
	DebugAssert({ Condition = spawnPointId > 0, Text = "No spawn point found for RoomReward!", Owner = "Eduardo" })
	return spawnPointId
end

function CheckMoneyDrop( enemy, moneyDropData, attacker )

	if enemy == nil then
		return
	end

	if moneyDropData == nil then
		return
	end

	if moneyDropData.Chance == nil or not RandomChance( moneyDropData.Chance ) then
		return
	end

	if HasHeroTraitValue( "BlockMoney" ) then
		return
	end

	local recipient = nil

	local moneyMultiplier = GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )
	for key, upgradeName in pairs( CurrentRun.EnemyUpgrades ) do
		local upgradeData = EnemyUpgradeData[upgradeName]
		if upgradeData.MoneyMultiplierDelta then
			moneyMultiplier = moneyMultiplier + (upgradeData.MoneyMultiplier - 1)
		end
	end

	local currentEncounter = CurrentRun.CurrentRoom.Encounter
	if currentEncounter ~= nil and currentEncounter.MoneyDropStore and not moneyDropData.IgnoreRoomMoneyStore then
		if moneyDropData.MinParcels and moneyDropData.MaxParcels then
			local numDrops = RandomInt( moneyDropData.MinParcels, moneyDropData.MaxParcels )
			while( currentEncounter.MoneyDropStore > 0 and numDrops > 0 ) do
				local amount = RandomInt( moneyDropData.MinValue, moneyDropData.MaxValue ) or 1
				amount = amount * moneyMultiplier
				amount = round( amount )
				if amount <= 0 then
					amount = 1
				end
				DropMoney( amount, { LocationId = enemy.ObjectId, Radius = moneyDropData.Radius, Source = enemy.Name, Recipient = recipient } )
				numDrops = numDrops - amount
				currentEncounter.MoneyDropStore = currentEncounter.MoneyDropStore - amount
				--DebugPrint({ Text = "Money Store: "..tostring( currentEncounter.MoneyDropStore ) })
				if currentEncounter.MoneyDropStore <= 0 then
					--DebugPrint({ Text = "Money Store Maxed!" })
				end
			end
		end
	else
		local numDropParcels = RandomInt( moneyDropData.MinParcels, moneyDropData.MaxParcels )
		for index = 1, numDropParcels, 1 do

			local amount = RandomInt( moneyDropData.MinValue, moneyDropData.MaxValue ) or 1
			amount = amount * moneyMultiplier
			amount = round( amount )

			DropMoney( amount, { LocationId = enemy.ObjectId, Radius = moneyDropData.Radius, Source = enemy.Name } )
			--DebugPrint({ Text = "Money Other: "..tostring( amount ) })
		end
	end
	if enemy.MoneyDropGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[enemy.MoneyDropGlobalVoiceLines], true )
	end

end

function EscalateMagnetism( consumable )

	if consumable.MagnetismEscalateDelay == nil then
		return
	end
	wait( consumable.MagnetismEscalateDelay - consumable.MagnetismHintRemainingTime , RoomThreadName )
	if not IsAlive({ Id = consumable.ObjectId }) then
		return
	end
	CreateAnimation({ Name = "AmmoReturnTimer", DestinationId = consumable.ObjectId })
	wait( consumable.MagnetismHintRemainingTime, RoomThreadName )
	SetObstacleProperty({ Property = "Magnetism", Value = consumable.MagnetismEscalateAmount, DestinationId = consumable.ObjectId })

end

function RecordMapState( mapName, id, property, value )
	if CurrentRun.MapStates[mapName] == nil then
		CurrentRun.MapStates[mapName] = {}
	end
	if CurrentRun.MapStates[mapName][id] == nil then
		CurrentRun.MapStates[mapName][id] = {}
	end
	CurrentRun.MapStates[mapName][id][property] = value
end

function RestoreMapStateObject( mapName, object )
	local mapState = CurrentRun.MapStates[mapName]
	if mapState == nil then
		return
	end
	local objectState = mapState[object.ObjectId]
	if objectState == nil then
		return
	end		
	RestoreObjectState( object, objectState )
end

function RecordObjectState( room, id, property, value )
	if room.ObjectStates == nil then
		room.ObjectStates = {}
	end
	if room.ObjectStates[id] == nil then
		room.ObjectStates[id] = {}
	end
	room.ObjectStates[id][property] = value
end

function RestoreObjectStates( room )
	if room.ObjectStates == nil then
		return
	end
	for id, objectState in pairs( room.ObjectStates ) do
		local object = nil
		if id == CurrentRun.Hero.ObjectId then
			object = CurrentRun.Hero
		else
			object = ActiveEnemies[id] or MapState.ActiveObstacles[id]
		end
		if object ~= nil then
			RestoreObjectState( object, objectState )
		end
	end
end

function RestoreObjectState( object, objectState )

	local id = object.ObjectId

	for property, value in pairs( objectState ) do
		if value == "nil" then
			object[property] = nil
		else
			object[property] = value
		end
	end

	if objectState.PropertyChanges ~= nil then
		ApplyUnitPropertyChanges(object, objectState.PropertyChanges, true)
	end

	if objectState.Animation ~= nil then
		SetAnimation({ DestinationId = id, Name = objectState.Animation })
	end
	if objectState.FlipHorizontal then
		FlipHorizontal({ Id = id })
	end
	if objectState.Location ~= nil then
		Teleport({ Id = id, OffsetX = objectState.Location.X, OffsetY = objectState.Location.Y })
	end
	if objectState.Angle ~= nil then
		SetGoalAngle({ Id = id, Angle = objectState.Angle, CompleteAngle = true })
	end
	if objectState.UseableOff ~= nil then
		UseableOff({ Id = id })
	end
	if objectState.UseableOn ~= nil then
		UseableOn({ Id = id })
	end

	if objectState.StopsProjectiles ~= nil then
		SetThingProperty({ DestinationId = id, Property = "StopsProjectiles", Value = objectState.StopsProjectiles })
	end

	if objectState.Destroyed and not object.SkipDestroy then
		SetThingProperty({ DestinationId = id, Property = "SuppressSounds", Value = true, DataValue = false })
		Destroy({ Id = id })
	else
		if objectState.SwapData and ObstacleData[objectState.SwapData] then
			local newData = ObstacleData[objectState.SwapData]
			local newObject = DeepCopyTable( newData )
			newObject.ObjectId = id
			AttachLua({ Id = id, Table = newObject })
			if newObject.SpawnPropertyChanges ~= nil then
				ApplyUnitPropertyChanges( newObject, newObject.SpawnPropertyChanges, true )
			end
		end
	end

end

function HandleBreakableSwap( currentRoom, args )
	local roomBreakableData = RoomData[currentRoom.Name].BreakableValueOptions
	if roomBreakableData == nil then
		return
	end
	args = args or {}
	local legalBreakables = FindAllSwappableBreakables()
	local highValueLimit = roomBreakableData.MaxHighValueBreakables or 1
	if highValueLimit == 0 or IsEmpty( legalBreakables ) then
		return
	end
	if TableLength( legalBreakables ) < highValueLimit then
		highValueLimit = TableLength( legalBreakables )
	end

	local chanceMultiplier = 1.0
	if RoomData[currentRoom.Name].BreakableHighValueChanceMultiplier ~= nil then
		chanceMultiplier = chanceMultiplier * RoomData[currentRoom.Name].BreakableHighValueChanceMultiplier
	end

	for index = 0, highValueLimit, 1 do
		local breakable = RemoveRandomValue( legalBreakables )
		if breakable == nil then
			return
		end
		local valueOptions = breakable.ValueOptions
		for k, swapOption in ipairs( valueOptions ) do
			if swapOption.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, swapOption, swapOption.GameStateRequirements ) then
				if RandomChance( swapOption.Chance * chanceMultiplier ) then
					if swapOption.Animation ~= nil then
						SetAnimation({ DestinationId = breakable.ObjectId, Name = swapOption.Animation, OffsetY = swapOption.OffsetY or 0 })
					end
					RecordObjectState( currentRoom, breakable.ObjectId, "Animation", swapOption.Animation )
					breakable.MoneyDropOnDeath = ShallowCopyTable( swapOption.MoneyDropOnDeath )
					RecordObjectState( currentRoom, breakable.ObjectId, "MoneyDropOnDeath", breakable.MoneyDropOnDeath )
					DebugPrint({ Text = "HandleBreakableSwap: an up-valued breakable spawned at Id "..breakable.ObjectId })
					OverwriteTableKeys(breakable, swapOption.DataOverrides)
					for k, v in pairs(swapOption.DataOverrides) do
						RecordObjectState( CurrentRun.CurrentRoom, breakable.ObjectId, k, v )
					end
					if breakable.ValueOptions.SetupEvents ~= nil then
						RunEventsGeneric( breakable.ValueOptions.SetupEvents, breakable )
					end
					break
				end
			end
		end
	end
end

function FindAllSwappableBreakables()
	local legalBreakables = { }
	for id, enemy in pairs( ActiveEnemies ) do
		if enemy.ValueOptions ~= nil then
			legalBreakables[id] = enemy
		end
	end
	for id, obstacle in pairs( MapState.ActiveObstacles ) do
		if obstacle.ValueOptions ~= nil then
			legalBreakables[id] = obstacle
		end
	end
	return legalBreakables
end

Using "MoneyPileA"
Using "MoneyPileB"
Using "MoneyPileC"
function DropMoney( amount, args )
	if amount == nil then
		return
	end

	if args.Recipient ~= nil then
		args.Recipient.Money = args.Recipient.Money + amount
		return 
	end

	if args.LocationId == nil then
		args.LocationId = CurrentRun.Hero.ObjectId
	end
	args.Radius = args.Radius or 25
	local offset = CalcOffset( RandomFloat( 0, 360 ), args.Radius )
	if args.Offset ~= nil then
		offset.X = offset.X + args.Offset.X
		offset.Y = offset.Y + args.Offset.Y
	end
	if args.OffsetZ ~= nil then
		offset.Z = args.OffsetZ
	else
		offset.Z = 0
	end

	local moneySize = "MoneySmall"
	local moneyConsumeFx = "MoneyPileA-Out"

	if amount < 10 then
		moneySize = "MoneySmall"
		moneyConsumeFx = "MoneyPileA-Out"
	elseif amount < 25 then
		moneySize = "MoneyMedium"
		moneyConsumeFx = "MoneyPileB-Out"
	else
		moneySize = "MoneyLarge"
		moneyConsumeFx = "MoneyPileC-Out"
	end
	local moneyDrop = { Amount = amount, Source = args.Source or "GenericDrop" }
	moneyDrop.ObjectId = SpawnObstacle({ Name = moneySize, DestinationId = args.LocationId, OffsetX = offset.X, OffsetY = offset.Y, OffsetZ = offset.Z, Group = "Standing", TriggerOnSpawn = false, })	
	moneyDrop.ConsumeFx = moneyConsumeFx
	AttachLua({ Id = moneyDrop.ObjectId, Table = moneyDrop })
	moneyDrop.OnUsedFunctionName = "UseMoneyDrop"
	MoneyDropPresentation( moneyDrop, args )
end

function UseMoneyDrop( moneyDrop, user )

	if HasHeroTraitValue( "BlockMoney" ) then
		return
	end
	AddResource( "Money", moneyDrop.Amount, moneyDrop.Source )
	CreateAnimation({ Name = moneyDrop.ConsumeFx, DestinationId = moneyDrop.ObjectId })
	--[[if EncounterData[CurrentRun.CurrentRoom.Encounter.Name].TrackPlayerMoneyObjective then
		UpdateObjectiveDescription( "PlayerMoney", "Objective_PlayerMoney", "PlayerMoney", GameState.Resources.Money - CurrentRun.CurrentRoom.Encounter.StartPlayerMoney )
	end]]
end

function ClearUpgrades()
	CurrentRun.Hero.RecentTraits = {}
	CurrentRun.Hero.Traits = {}
	CurrentRun.Hero.OnFireWeapons = {}
	CurrentRun.Hero.OnDamageWeapons = {}
	CurrentRun.Hero.OnKillWeapons = {}
	CurrentRun.Hero.LastStands = {}
	CurrentRun.Hero.WeaponDataOverride = nil

	if CurrentRun.Hero.OutgoingDamageModifiers ~= nil then
		for i, modifier in pairs( CurrentRun.Hero.OutgoingDamageModifiers ) do
			if modifier.Name and MetaUpgradeData[modifier.Name] == nil then
				CurrentRun.Hero.OutgoingDamageModifiers[i] = nil
			end
		end
	end
	if CurrentRun.Hero.OutgoingCritModifiers ~= nil then
		for i, modifier in pairs( CurrentRun.Hero.OutgoingCritModifiers ) do
			if modifier.Name and MetaUpgradeData[modifier.Name] == nil then
				CurrentRun.Hero.OutgoingCritModifiers[i] = nil
			end
		end
	end
	for metaUpgradeName in pairs( CurrentRun.TemporaryMetaUpgrades ) do
		GameState.MetaUpgradeState[metaUpgradeName].Equipped = nil
	end

	
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if metaUpgradeData.Equipped and MetaUpgradeCardData[ metaUpgradeName ].TraitName and MetaUpgradeCardData[ metaUpgradeName ].ActiveWhileDead then
			AddTraitToHero({ TraitName = MetaUpgradeCardData[ metaUpgradeName ].TraitName })
		end
	end
end

function ProcessInterest( eventSource, args )
	if not IsMetaUpgradeActive("InterestMetaUpgrade") then
		return
	end
	args = args or {}
	local waitDelay = args.StartDelay or 0 
	local goldPerRoom = round( GetTotalHeroTraitValue("MoneyPerRoom") )
	if HasHeroTraitValue( "BlockMoney" ) then
		goldPerRoom = 0
	end
	if goldPerRoom > 0 then
		waitDelay = waitDelay + 0.5
	end
	wait( waitDelay)
	local interest = math.ceil( GetResourceAmount( "Money" ) )
	AddResource( "Money", interest, "InterestMetaupgrade" )
	thread( InCombatText, CurrentRun.Hero.ObjectId, "InterestGainedCombatText", 1.5 , {  LuaKey = "TempTextData", LuaValue = { Amount = interest }})
end

function OnMetaPointsAdded( name, amount, source, args )

	args = args or {}
	local healMultiplier = GetTotalHeroTraitValue("MetaPointHealMultiplier")
	healMultiplier = healMultiplier * CalculateHealingMultiplier() * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true })
	if healMultiplier > 0 and round( healMultiplier * amount ) > 0 then
		thread( DelayedHeal, 0.5,  round( healMultiplier * amount ), "MetaPointHeal" )
	end

end

function AddMaxHealth( healthGained, source, args )
	args = args or {}
	if args.Thread then
		args.Thread = false
		thread( AddMaxHealth, healthGained, source, args )
		return
	end
	local startingHealth = CurrentRun.Hero.MaxHealth
	wait( args.Delay )
	healthGained = round(healthGained)
	local traitName = "RoomRewardMaxHealthTrait"
	if args.NoHealing then
		traitName = "RoomRewardEmptyMaxHealthTrait"
	end

	local healthTraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName })
	healthTraitData.PropertyChanges[1].ChangeValue = healthGained
	AddTraitToHero({ TraitData = healthTraitData })
	healthGained = round(healthGained * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true }))
	if not( args.Silent ) then
		MaxHealthIncreaseText({ MaxHealthGained = CurrentRun.Hero.MaxHealth - startingHealth , SpecialText = "MaxHealthIncrease" })
	end
end

function AddMaxMana( manaGained, source, args )
	args = args or {}
	if args.Thread then
		args.Thread = false
		thread( AddMaxMana, manaGained, source, args )
		return
	end
	local startingMana = CurrentRun.Hero.MaxMana
	wait( args.Delay )
	manaGained = round(manaGained)
	local traitName = "RoomRewardMaxManaTrait"

	local manaTraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName })
	manaTraitData.PropertyChanges[1].ChangeValue = manaGained
	AddTraitToHero({ TraitData = manaTraitData })
	if not( args.Silent ) then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, PreDelay = args.Delay, Text = "MaxManaIncrease", Duration = 0.7, LuaKey = "TooltipData", ShadowScale = 0.7, OffsetY = -100,  LuaValue = { TooltipMana = manaGained }})
	end
end

function AddArmor( armorGained, args )
	args = args or {}
	if args.Thread then
		args.Thread = false
		thread( AddArmor, armorGained, args )
		return
	end
	wait( args.Delay )
	local traitName = "MinorArmorBoon"
	if not HeroHasTrait(traitName) then
		local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName })
		traitData.SetupFunction.Args.BaseAmount = armorGained
		AddTraitToHero({ TraitData = traitData })
	else
		local traitData = GetHeroTrait(traitName)
		traitData.CurrentArmor = traitData.CurrentArmor + armorGained
		AddHealthBuffer( traitData.CurrentArmor, traitData.Name, { Silent = true } )	
		thread(OnPlayerArmorGain, { Amount = armorGained } )
		thread( UpdateHealthUI )
	end
end

function AddHitShield( count )
	local traitName = "MinorHitShieldBoon"
	if not HeroHasTrait(traitName) then
		AddTraitToHero({ TraitName = traitName })
		if count > 1 then
			count = count - 1
		else
			return
		end
	end
	local traitData = GetHeroTrait(traitName)
	traitData.RemainingUses = traitData.RemainingUses + count
	UpdateTraitNumber( traitData )
end

function OnLockKeysAdded( name, amount, source, args )
	args = args or {}
	if amount > 0 then
		if not CurrentRun.Hero.IsDead and CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.ChallengeSwitch ~= nil then
			thread( UpdateLockedKeyPresentation, CurrentRun.CurrentRoom.ChallengeSwitch )
		end
	end
end

function StartEncounterEffects( currentRun )
	currentRun.CurrentRoom.Encounter.StartTime = _worldTime
	CurrentRun.Hero.HitShields = 0

	if MapState.FamiliarUnit ~= nil then
		ReenableFamiliar( MapState.FamiliarUnit )
	end
	if not currentRun.CurrentRoom.BlockClearRewards then
		notifyExistingWaiters("EncounterStart")
		for i, traitData in pairs( currentRun.Hero.Traits) do
			if traitData.PerfectClearDamageBonus or (traitData.AddOutgoingDamageModifiers and traitData.AddOutgoingDamageModifiers .UndamagedMultiplier ) then
				PerfectClearTraitStartPresentation( traitData )
			end
			if traitData.FastClearDodgeBonus then
				SetupDodgeBonus( currentRun.CurrentRoom.Encounter, traitData )
			end
			if traitData.EncounterStartWeapon then
				FireWeaponFromUnit({ Weapon = traitData.EncounterStartWeapon, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			end
			if traitData.EncounterStartEffect then
				local dataProperties = MergeTables( EffectData[traitData.EncounterStartEffect.Name].EffectData, traitData.EncounterStartEffect.EffectData )
				ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = traitData.EncounterStartEffect.Name, DataProperties = dataProperties })
			end
			if traitData.Slot == "Spell" then
				thread( SpellHintPresentation, GetWeaponData( CurrentRun.Hero, traitData.PreEquipWeapons[1]) )
			end
			if traitData.SetupFunction and traitData.SetupFunction.RepeatOnEncounterStart then
				thread( CallFunctionName, traitData.SetupFunction.Name, CurrentRun.Hero, traitData.SetupFunction.Args )
			end

			if currentRun.CurrentRoom.Encounter.EncounterType == "Boss"  then
				if traitData.BossSpeedTriggerEffect then
					thread(CheckSpeedKeepsakeTrigger, unit, traitData.BossSpeedTriggerEffect )
				end

				if traitData.BossEncounterShieldHits then
					MapState.BossShieldTriggers = traitData.BossEncounterShieldHits
					MapState.BossShieldFx = traitData.BossShieldFx
					if MapState.BossShieldFx then
						CreateAnimation({ Name = traitData.BossShieldFx, DestinationId = CurrentRun.Hero.ObjectId })
					end
				end
			end
		end
	end

	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		if traitData.EncounterPreDamage and IsTraitActive(traitData) then
			local validEnemy = false
			local damageData = traitData.EncounterPreDamage
			if damageData.EnemyType == "Boss" then
				for unitId, unit in pairs( ActiveEnemies ) do
					if  unit.IsBoss then
						thread( PreDamageBoss, unit, unit.MaxHealth * damageData.PreDamage, damageData )
						validEnemy = true
					end
				end
				if validEnemy then
					ReduceTraitUses( traitData )
				end
			end
		end
	end
end

function EndEncounterEffects( currentRun, currentRoom, currentEncounter )
	if currentEncounter == nil or currentEncounter.EncounterType == "NonCombat" then
		return
	end
	if SessionMapState.LaserSpellDown then
		LaserHoldClear()
	end
	CurrentRun.Hero.HeroTraitValuesCache = {}
	if currentRoom.DestroyAssistUnitOnEncounterEndId then
		thread( CleanupRaiseDeadEncounter, currentRoom )
	end
	if currentEncounter == currentRoom.Encounter or currentEncounter == currentRoom.ChallengeEncounter or currentEncounter == MapState.EncounterOverride then
		ClearEffect({ Id = currentRun.Hero.ObjectId, Name = "KillDamageBonus"})
		MapState.ExCastCount = 0

		if currentRoom.DestroyAssistProjectilesOnEncounterEnd then
			ExpireProjectiles({ Name = currentRoom.DestroyAssistProjectilesOnEncounterEnd })
		end

		for chapterName, chapterData in pairs( CodexData ) do
			for entryName, entryData in pairs( chapterData.Entries ) do
				CheckCodexUnlock( chapterName, entryName, { DeferShowUpdate = true } )
			end
		end

		if MapState.PendingCodexUpdate then
			MapState.PendingCodexUpdate = false
			wait( 0.2, RoomThreadName )
			thread( ShowCodexUpdate )
			thread( CheckQuestStatus )
		end
	end

	if MapState.FamiliarUnit ~= nil then
		RunEventsGeneric( MapState.FamiliarUnit.EncounterEndEvents, MapState.FamiliarUnit )
	end

	if currentEncounter == currentRoom.Encounter or currentEncounter == MapState.EncounterOverride then
		local heroHealth = CurrentRun.Hero.Health
		local encounterHealAmount = GetTotalHeroTraitValue("CombatEncounterAbsoluteHeal")

		local healthFloor = round( CurrentRun.Hero.MaxHealth * GetTotalHeroTraitValue("CombatEncounterHealthPercentFloor") )
		if (heroHealth + encounterHealAmount) < healthFloor then
			encounterHealAmount = healthFloor - heroHealth
		end
		Heal( CurrentRun.Hero, { HealAmount = encounterHealAmount, Name = "EncounterHeal" } )

		local traitsToRemove = {}
		for k, trait in pairs( currentRun.Hero.Traits ) do
			if trait.EncounterEndFunctionName ~= nil then
				CallFunctionName( trait.EncounterEndFunctionName, trait, trait.EncounterEndFunctionArgs )
			end
			if currentRun.CurrentRoom.Encounter.EncounterType == "Boss"  then
				if trait.BossConvertArmor and IsTraitActive( trait ) then
					ConvertArmorToHealth( trait )
				end
				if trait.BossEncounterShieldHits and trait.BossShieldFx then
					StopAnimation({ Name = trait.BossShieldFx, DestinationId = CurrentRun.Hero })
					UpdateTraitNumber( trait )
				end
				if trait.UsesAsBosses then
					trait.RemainingUses = trait.RemainingUses - 1
					if trait.RemainingUses <= 0 then
						table.insert( traitsToRemove, trait )
					end
					TraitUIUpdateText( trait )
				end
			end
			if trait.RemainingUses ~= nil and trait.UsesAsEncounters and (not trait.UsesRequireSpawnMultiplier or ( trait.UsesRequireSpawnMultiplier and not currentEncounter.BlockSpawnMultipliers )) then
				if trait.HoldRemainingRooms ~= nil and trait.HoldRemainingRooms > 0 then
					trait.HoldRemainingRooms = trait.HoldRemainingRooms - 1
				else
					trait.RemainingUses = trait.RemainingUses - 1
					if trait.RemainingUses <= 0 then
						table.insert( traitsToRemove, trait )
					end
				end
				TraitUIUpdateText( trait )
			end
		end
		if not currentRoom.BlockClearRewards then
			for k, traitData in pairs(currentRun.Hero.Traits) do
				if not currentEncounter.PlayerTookDamage and traitData.PerfectClearDamageBonus then
					traitData.AccumulatedDamageBonus = traitData.AccumulatedDamageBonus + (traitData.PerfectClearDamageBonus - 1)
					PerfectClearTraitSuccessPresentation( traitData )
					CurrentRun.CurrentRoom.PerfectEncounterCleared = true
					CheckAchievement( { Name = "AchBuffedButterfly", CurrentValue = traitData.AccumulatedDamageBonus } )
				end
				
				if traitData.CurrentKeepsakeDamageBonus and traitData.CurrentKeepsakeDamageBonus > 1 then
					traitData.CurrentKeepsakeDamageBonus = traitData.CurrentKeepsakeDamageBonus - traitData.DecayRate
					if traitData.CurrentKeepsakeDamageBonus <= 1 then
						traitData.CustomTrayText = traitData.ZeroBonusTrayText
						traitData.CurrentKeepsakeDamageBonus = 1
						ReduceTraitUses( traitData, { Force = true })
					end
				end

				if traitData.FastClearThreshold then
					local clearTimeThreshold = currentEncounter.FastClearThreshold or traitData.FastClearThreshold
					if currentEncounter.ClearTime < clearTimeThreshold and traitData.FastClearDodgeBonus then
						local lastDodgeBonus = traitData.AccumulatedDodgeBonus
						SetLifeProperty({ Property = "DodgeChance", Value = -1 * lastDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
						SetUnitProperty({ Property = "Speed", Value = 1/( 1 + lastDodgeBonus ), ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
						traitData.AccumulatedDodgeBonus = traitData.AccumulatedDodgeBonus + traitData.FastClearDodgeBonus
						SetLifeProperty({ Property = "DodgeChance", Value = traitData.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
						SetUnitProperty({ Property = "Speed", Value = 1 + traitData.AccumulatedDodgeBonus, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
						thread( FastClearTraitSuccessPresentation, traitData )
						CheckAchievement( { Name = "AchBuffedPlume", CurrentValue = traitData.AccumulatedDodgeBonus } )
					end
				end
				if traitData.EscalatingKeepsakeValue then
					traitData.EscalatingKeepsakeValue = traitData.EscalatingKeepsakeValue + traitData.EscalatingKeepsakeGrowthPerRoom
				end
			end
		end

		for k, trait in pairs( traitsToRemove ) do
			RemoveTraitData( currentRun.Hero, trait )
		end
		AdvanceKeepsake()
		CheckChamberTraits()
		EncounterEndPresentation()
		
		if MapState.TransformArgs then
			EndSpellTransform()
		end
		
		MapState.UsedBlockDeath = nil
		MapState.EncounterOverride = nil
	end
end

function IsCombatEncounterActive( currentRun, args  )
	args = args or {}
	if currentRun.CurrentRoom == nil then
		return false
	end
	if currentRun.CurrentRoom.AlwaysInCombat then
		return true
	end

	if not currentRun.Hero.IsDead then
		if HasTimerBlock( currentRun ) then
			local hasExcludedTimer = false
			for _, name in pairs( TimerBlockCombatExcludes ) do
				if currentRun.BlockTimerFlags[ name ] then
					hasExcludedTimer = true
				end
			end
			if not hasExcludedTimer then
				return false
			end
		end

		if currentRun.CurrentRoom.StartedChallengeEncounter and not currentRun.CurrentRoom.ChallengeEncounter.Completed then
			return true
		end

		local encounter = currentRun.CurrentRoom.Encounter
		if encounter ~= nil and not args.IgnoreMainEncounter then
			if encounter.EncounterType == "NonCombat" then
				return false
			end
			if not encounter.InProgress then
				return false
			end
			if encounter.DelayedStart and not encounter.StartTime then
				return false
			end
			if not encounter.Completed then
				return true
			end
		end
	end
	return false
end

function CheckRoomExitsReadySource( source, args )
	return CheckRoomExitsReady( CurrentRun.CurrentRoom, args )
end

function CheckRoomExitsReady( currentRoom )

	if CurrentRun.Hero.IsDead then
		return
	end

	if not IsEmpty( MapState.RoomRequiredObjects ) then
		for id, object in pairs( MapState.RoomRequiredObjects ) do
			DebugPrint({ Text = "Exit Blocked By: "..GetTableString( object ) })
		end
		return false
	end

	if IsScreenOpen( "BoonMenu" ) then
		DebugPrint({ Text = "Exit Blocked By: Boon Menu" })
		return false
	end

	for k, encounter in pairs(currentRoom.ActiveEncounters) do
		if not encounter.ExitsDontRequireCompleted and not encounter.Completed then
			DebugPrint({ Text = "Exit Blocked By: "..encounter.Name.." Not Completed" })
			return false
		end
	end

	if currentRoom.MultipleEncountersData ~= nil and TableLength(currentRoom.MultipleEncountersData) > 1 and not currentRoom.AllEncountersCompleted == true then
		DebugPrint({ Text = "Exit Blocked By: MultipleEncounters Not Completed" })
		return false
	end

	return true

end

function GetRemainingSpawns( currentRun, currentRoom, currentEncounter )

	if currentRun.Hero.IsDead then
		return 0
	end

	if currentEncounter.Completed then
		return 0
	end

	if CheckCancelSpawns(currentRoom, currentEncounter) then
		return 0
	end

	local remainingSpawns = 0
	if currentEncounter.Spawns ~= nil then
		for k, spawnInfo in pairs( currentEncounter.Spawns ) do
			if spawnInfo.RemainingSpawns == nil then
				-- Spawn totals have not been generated yet. Somewhat of an ambiguous case, unsure how to best handle yet.
				remainingSpawns = remainingSpawns + 1
			else
				remainingSpawns = remainingSpawns + spawnInfo.RemainingSpawns
			end
		end
	end
	return remainingSpawns

end

function CheckCancelSpawns( room, encounter )
	if encounter.CancelSpawns then
		return true
	end

	local encounterData = EncounterData[encounter.Name] or encounter
	if encounterData.CancelSpawnsOnKill ~= nil then
		for k, unitName in pairs(encounterData.CancelSpawnsOnKill) do
			if room.Kills ~= nil and room.Kills[unitName] ~= nil and room.Kills[unitName] >= 1 then
				return true
			end
		end
	end

	if encounterData.CancelSpawnsOnKillAll ~= nil then
		local remainingSpawns = 0
		for k, spawnInfo in pairs( encounter.Spawns ) do
			if Contains(encounterData.CancelSpawnsOnKillAll, spawnInfo.Name) then
				local newRemainingSpawns = spawnInfo.RemainingSpawns or 1
				remainingSpawns = remainingSpawns + newRemainingSpawns
			end
		end
		if remainingSpawns == 0 then
			local killedAll = true
			for k, id in pairs(GetIdsByType({ Names = encounterData.CancelSpawnsOnKillAll })) do
				if ActiveEnemies[id] ~= nil and not ActiveEnemies[id].IsDead then
					killedAll = false
				end
			end
			if killedAll then
				return true
			end
		end
	end

	if encounterData.CancelSpawnsOnKillAllTypes ~= nil then
		local killCountGoal = TableLength(encounterData.CancelSpawnsOnKillAllTypes)
		local killCount = 0
		for k, unitName in pairs(encounterData.CancelSpawnsOnKillAllTypes) do
			if room.Kills ~= nil and room.Kills[unitName] ~= nil and room.Kills[unitName] >= 1 then
				killCount = killCount + 1
			end
		end

		if killCount >= killCountGoal then
			return true
		end
	end

	return false
end

function GetNextSpawn( currentEncounter )

	local forcedSpawn = nil
	local remainingSpawnInfo = {}
	local remainingPrioritySpawnInfo = {}
	for k, spawnInfo in orderedPairs( currentEncounter.Spawns ) do
		if spawnInfo.InfiniteSpawns or spawnInfo.RemainingSpawns > 0 then
			local enemyData = EnemyData[spawnInfo.Name]
			if enemyData ~= nil and enemyData.LargeUnitCap ~= nil and enemyData.LargeUnitCap > 0 then
				local largeUnitCount = 0
				-- @optimization Convert to buckets by type
				for enemyId, enemy in pairs( ActiveEnemies ) do
					if enemy.LargeUnitCap ~= nil and enemyData.LargeUnitCap > 0 then
						largeUnitCount = largeUnitCount + 1
					end
				end
				if largeUnitCount < enemyData.LargeUnitCap then
					table.insert( remainingSpawnInfo, spawnInfo )
					if spawnInfo.PrioritySpawn then
						table.insert( remainingPrioritySpawnInfo, spawnInfo )
					end
				else
					DebugPrint({ Text = "Avoiding LargeUnitCap: "..enemyData.Name })
				end
			else
				table.insert( remainingSpawnInfo, spawnInfo )
				if spawnInfo.PrioritySpawn then
					table.insert( remainingPrioritySpawnInfo, spawnInfo )
				end
			end

			if spawnInfo.ForceFirst then
				forcedSpawn = spawnInfo
			end
		end
	end

	if forcedSpawn ~= nil then
		return forcedSpawn
	end

	local randomSpawnInfo = GetRandomValue( remainingPrioritySpawnInfo ) or GetRandomValue( remainingSpawnInfo )
	return randomSpawnInfo

end

function SetupUnit( unit, currentRun, args )
	currentRun = currentRun or CurrentRun
	args = args or {}
	local currentRoom = currentRun.CurrentRoom
	local skipModifiers = unit.SkipModifiers
	local startedCharmed = IsCharmed({ Id = unit.ObjectId })
	if startedCharmed then
		unit.AlwaysTraitor = true
		unit.Charmed = true
		unit.RequiredKill = false
		unit.BlocksLootInteraction = false

		if unit.StartCharmedDataOverrides ~= nil then
			OverwriteTableKeys(unit, unit.StartCharmedDataOverrides)
		end
	end

	if unit.RequiredKill then
		RequiredKillEnemies[unit.ObjectId] = unit
		notifyExistingWaiters( "RequiredKillEnemyKilledOrSpawned" )
	end

	if unit.RoomRequiredObject then
		MapState.RoomRequiredObjects[unit.ObjectId] = unit
	end
	
	ActiveEnemies[unit.ObjectId] = unit
	SurroundEnemiesAttacking[unit.Name] = SurroundEnemiesAttacking[unit.Name] or {}
	AttachLua({ Id = unit.ObjectId, Table = unit })
	unit.AIThreadName = "AIThread_"..unit.Name.."_"..unit.ObjectId

	if unit.SetupEvents ~= nil then
		RunEventsGeneric( unit.SetupEvents, unit, args )
	end

	if args ~= nil and args.IgnoreAI then
		unit.SkipAISetupOnActivate = true
	end
	
	unit.Groups = unit.Groups or {}
	if unit.AddToEnemyTeam then
		table.insert( unit.Groups, "EnemyTeam" )
		if not unit.IgnoreTimeSlowEffects then
			SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = _elapsedTimeMultiplier, DataValue = false, ValueChangeType = "Multiply", DestinationId = unit.ObjectId })
		end
	end
	AddToGroup({ Id = unit.ObjectId, Names = unit.Groups })

		
	unit.ExpireProjectileIdsOnHitStun = {}
	unit.ExpireProjectileIdsOnFreeze = {}
	unit.ExpireProjectileIdsOnPolymorph = {}
	unit.ClearEffectsOnHitStun = {}
	unit.StopAnimationsOnHitStun = {}
	unit.StopSoundsOnHitStun = {}
	unit.DamageRadiusIdsByHealthPercent = {}
	unit.ActiveInputBlocks = {}
	unit.ActiveEffects = {}
	unit.IncomingDamageModifiers = unit.IncomingDamageModifiers or {}

	GameState.SpawnRecord[unit.Name] = (GameState.SpawnRecord[unit.Name] or 0) + 1
	CurrentRun.SpawnRecord[unit.Name] = (CurrentRun.SpawnRecord[unit.Name] or 0) + 1

	if unit.OccupyingSpawnPointId ~= nil then
		SessionMapState.SpawnPointsUsed[unit.OccupyingSpawnPointId] = unit.ObjectId
		thread( UnoccupySpawnPointOnDistance, unit, unit.OccupyingSpawnPointId, 400 )
	end

	unit.WeaponHistory = unit.WeaponHistory or {}

	if unit.IsElite and not unit.Charmed then
		unit.EliteAttributes = unit.EliteAttributes or {}
		if currentRoom.EliteAttributes[unit.Name] ~= nil then
			for k, attributeName in pairs( currentRoom.EliteAttributes[unit.Name] ) do
				ApplyEliteAttribute( unit, attributeName )
			end
		end
	end

	if unit.SpawnAngleMin ~= nil and unit.SpawnAngleMax ~= nil then
		SetGoalAngle({ Id = unit.ObjectId, Angle = RandomFloat(unit.SpawnAngleMin, unit.SpawnAngleMax) })
	end

	if unit.SpawnAngleTowardId then
		AngleTowardTarget({ Id = unit.ObjectId, DestinationId = unit.SpawnAngleTowardId })
	end

	if unit.BlockPolymorph then
		AddEffectBlock({ Id = unit.ObjectId, Name = "PolymorphTag"})
	end
	if not args.Silent then
		if unit.ActivatePresentationFunctionName ~= nil then
			CallFunctionName( unit.ActivatePresentationFunctionName, unit, args )
		elseif unit.UseActivatePresentation and not args.SkipPresentation then
			UnitActivatePresentation( unit, args )
		end
	end

	-- If they died during ActivatePresentation somehow
	if unit.IsDead then
		return
	end

	unit.ActivationFinished = true

	if unit.CreateProjectileOnActivationFinished ~= nil then
		CreateProjectileFromUnit({ Name = unit.CreateProjectileOnActivationFinished, Id = unit.ObjectId, DestinationId = unit.ObjectId })
	end

	if unit.PostActivateEvents ~= nil then
		RunEventsGeneric( unit.PostActivateEvents, unit, args )
	end

	if unit.AttachedAnimationName ~= nil then
		CreateAnimation({ Name = unit.AttachedAnimationName, DestinationId = unit.ObjectId, OffsetZ = unit.AttachedAnimationOffsetZ })
	end
	if unit.CreateAnimations ~= nil then
		for i, animName in ipairs( unit.CreateAnimations ) do
			CreateAnimation({ Name = animName , DestinationId = unit.ObjectId })
		end
	end

	if unit.SpawnObstaclesOnSpawn ~= nil then
		for k, spawnData in pairs(unit.SpawnObstaclesOnSpawn) do
			local offsetX = spawnData.OffsetX
			local offsetY = spawnData.OffsetY
			if spawnData.Radius ~= nil then
				offsetX = RandomFloat(-spawnData.Radius, spawnData.Radius)
				offsetY = RandomFloat(-spawnData.Radius, spawnData.Radius)
			end
			local spawnId = SpawnObstacle({ Name = spawnData.Name, Group = spawnData.GroupName or "Standing", DestinationId = unit.ObjectId, OffsetX = offsetX, OffsetY = offsetY })
			local spawn = DeepCopyTable( ObstacleData[spawnData.Name] ) or {}
			spawn.ObjectId = spawnId
			SetupObstacle(spawn)
			if spawnData.UpwardForce ~= nil and spawnData.UpwardForce > 0 then
				SetThingProperty({ Property = "OffsetZ", Value = 0, DestinationId = spawnId })
				SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationId = spawnId })
				SetThingProperty({ Property = "StopsUnits", Value = true, DestinationId = spawnId })
				ApplyUpwardForce({ Id = spawnId, Speed = spawnData.UpwardForce })
				ApplyForce({ Id = spawnId, Speed = RandomFloat( spawnData.RandomForceMin or 0, spawnData.RandomForceMax or 0 ), Angle = RandomFloat( 0, 360 ) })
			end
			if spawnData.HSV ~= nil then
				SetHSV({ Id = spawnId, HSV = spawnData.HSV })
			end
			if spawnData.Color ~= nil then
				SetColor({ Id = spawnId, Color = spawnData.Color })
			end
			if spawnData.Outline ~= nil then
				spawnData.Outline.Id = spawnId
				AddOutline( spawnData.Outline )
			end
			if spawnData.SyncOwnerAngle then
				SetAngle({ Id = spawnId, Angle = GetAngle({ Id = unit.ObjectId }) })
			end
		end
	end

	if unit.AddDumbFireWeaponsOnSpawn ~= nil then
		for k, weaponName in pairs( unit.AddDumbFireWeaponsOnSpawn ) do
			unit.DumbFireWeapons = unit.DumbFireWeapons or {}
			table.insert( unit.DumbFireWeapons, weaponName )
		end
	end

	if not skipModifiers then
		ApplyEnemyModifiers( unit, currentRun, args )
	end
	if unit.AlwaysTraitor and not startedCharmed then
		SwitchAllegiance({ Id = unit.ObjectId })
	end

	ApplyEnemyTraits( currentRun, unit )

	unit.BarXScale = 1

	local healthMultiplier = unit.HealthMultiplier or 1
	healthMultiplier = healthMultiplier + (MetaUpgradeData.EnemyHealthShrineUpgrade.ChangeValue - 1)
	--DebugPrint({ Text = "healthMultiplier = "..healthMultiplier })
	if healthMultiplier ~= 1 and unit.UseShrineUpgrades and unit.MaxHealth ~= nil then
		unit.MaxHealth = unit.MaxHealth * healthMultiplier
	end
	unit.Health = unit.MaxHealth

	if unit.HealthBuffer ~= nil and unit.HealthBuffer > 0 then
		local healthBufferMultiplier = unit.HealthBufferMultiplier or 1
		unit.HealthBuffer = unit.HealthBuffer * healthMultiplier * healthBufferMultiplier
		DoEnemyHealthBuffered( unit )
	end

	if unit.Phases ~= nil then
		unit.CurrentPhase = 1
	end
	unit.HitShields = 0
	unit.SpeedMultiplier = 1
	if unit.UseShrineUpgrades and not unit.IgnoreSpeedShrine then
		unit.HitShields = GetNumShrineUpgrades( "EnemyShieldShrineUpgrade" )
		local speedMultiplier = (MetaUpgradeData.EnemySpeedShrineUpgrade.ChangeValue - 1.0) + (unit.EliteAdditionalSpeedMultiplier or 0)
		--DebugPrint({ Text = "speedMultiplier = "..speedMultiplier })
		if speedMultiplier > 0.0 then		
			unit.SpeedMultiplier = unit.SpeedMultiplier + speedMultiplier
			--DebugPrint({ Text = "unit.SpeedMultiplier = "..unit.SpeedMultiplier })
			if unit.AIThreadName then
				SetElapsedTimeMultiplier( (unit.SpeedMultiplier + speedMultiplier) / unit.SpeedMultiplier, unit.AIThreadName)
			end
		end
	end
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = unit.SpeedMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationId = unit.ObjectId })

	if unit.SpeedMin ~= nil and unit.SpeedMax ~= nil then
		DebugAssert({ Condition = false, Text = "Using deprecated property", Owner = "Gavin" })
	end

	if unit.ScaleMin and unit.ScaleMax then
		DebugAssert({ Condition = false, Text = "Using deprecated property", Owner = "Gavin" })
	end

	if unit.Color ~= nil then
		SetColor({ Id = unit.ObjectId, Color = unit.Color, MultiplyBase = true })
	end

	if unit.SpawnFx ~= nil then
		CreateAnimation({ DestinationId = unit.ObjectId, Name = unit.SpawnFx })
	end

	if unit.SpawnAnimation ~= nil then
		SetAnimation({ DestinationId = unit.ObjectId, Name = unit.SpawnAnimation })
	end

	if unit.AddOutlineImmediately then
		if not unit.HasOutline and unit.Outline ~= nil and unit.HealthBuffer ~= nil and unit.HealthBuffer > 0 then
			unit.Outline.Id = unit.ObjectId
			AddOutline( unit.Outline )
			unit.HasOutline = true
		end
	end

	if unit.MoneyDropOnDeath and unit.MoneyDropOnDeath.ValuePerDifficulty and unit.MoneyDropOnDeath.ValuePerDifficulty > 0 then
		if unit.GeneratorData ~= nil then
			unit.MoneyDropOnDeath.MinValue = unit.MoneyDropOnDeath.ValuePerDifficulty * unit.GeneratorData.DifficultyRating
			unit.MoneyDropOnDeath.MaxValue = unit.MoneyDropOnDeath.ValuePerDifficulty * unit.GeneratorData.DifficultyRating * unit.MoneyDropOnDeath.ValuePerDifficultyMaxValueVariance
		else
			unit.MoneyDropOnDeath.MinValue = 1
			unit.MoneyDropOnDeath.MaxValue = 1
		end
	end

	local enemyVulnerability = 1.0
	if unit.RequiredRoomInteraction then
		MapState.RoomRequiredObjects[unit.ObjectId] = unit
	end

	if unit.DistanceTriggers ~= nil then
		for k, trigger in ipairs( unit.DistanceTriggers ) do
			thread( CheckDistanceTrigger, trigger, unit )
		end
	end

	if unit.RandomFlipHorizontal and CoinFlip() then
		DebugAssert({ Condition = false, Text = "Using deprecated property" })
	end

	if not args.SkipPresentation then
		thread( PlayVoiceLines, args.OnSpawnVoiceLines or unit.OnSpawnVoiceLines, nil, unit )
	end

	if unit.SpeakerName ~= nil then
		LoadVoiceBanks(unit.SpeakerName)
		if CurrentHubRoom == nil then
			LoadVoiceBanks(unit.SpeakerName.."Field")
		end
	end

	if not unit.SkipAISetupOnActivate and not args.SkipAISetup then
		SetupAI( unit )
	end

	if unit.SpawnEvents ~= nil then
		RunEventsGeneric( unit.SpawnEvents, unit, args )
	end

	if unit.OnSpawnFireFunctionName ~= nil then
		CallFunctionName( unit.OnSpawnFireFunctionName, unit )
	end

	if CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.Encounter ~= nil then
		local encounterData = EncounterData[CurrentRun.CurrentRoom.Encounter.Name] or CurrentRun.CurrentRoom.Encounter
		if encounterData.OnSpawnFunctionName ~= nil then
			CallFunctionName( encounterData.OnSpawnFunctionName, unit )
		end
	end

	CreateLevelDisplay( unit, CurrentRun )

	if unit.IgnoreTimeSlowEffects then
		AddEffectBlock({ Id = unit.ObjectId, Name = "ChillEffect" })	
		AddEffectBlock({ Id = unit.ObjectId, Name = "LegacyChillEffect" })	
	end
end

function ApplyEnemyModifiers(unit, currentRun, args )

	for k, enemyUpgradeName in pairs( CurrentRun.EnemyUpgrades ) do
		local upgradeData = EnemyUpgradeData[enemyUpgradeName]
		if upgradeData.AddDumbFireWeapons then
			EquipDumbFireWeapons( unit, upgradeData )
		end
		ApplyUnitPropertyChanges( unit, upgradeData.PropertyChanges, true )
	end

	-- for enemy on spawn traits
	for i, traitData in pairs( GetHeroTraitValues("AddOnEnemySpawnWeapon")) do
		if traitData.AffectChance == nil or RandomChance(traitData.AffectChance) then
			FireWeaponFromUnit({ Weapon = traitData.Weapon, Id = currentRun.Hero.ObjectId, DestinationId = unit.ObjectId, AutoEquip = true })
		end
	end
	for i, traitData in pairs( GetHeroTraitValues("OnEnemySpawnFunction")) do
		if traitData.Chance == nil or RandomChance(traitData.Chance) then
			thread(CallFunctionName, traitData.FunctionName, unit, traitData.Args)
		end
	end
	if CurrentRun.CurrentRoom.ElapsedTimeMultiplier then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = CurrentRun.CurrentRoom.ElapsedTimeMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationId = unit.ObjectId })
	end
end

function SetupAI( enemy, args )

	if enemy.AIBehavior ~= nil then
		return
	end

	if enemy.AIWakeDelay ~= nil then
		wait(enemy.AIWakeDelay)
	end

	if enemy.SupportUnitName ~= nil then
		SpawnSupportAI( enemy, CurrentRun )
	end

	if enemy.AIStages ~= nil then
		enemy.AIThreadName = "AIThread_"..enemy.Name.."_"..enemy.ObjectId
		thread( StagedAI, enemy )
		return
	end

	local aiBehaviorName = GetRandomValue( enemy.AIOptions )
	if aiBehaviorName ~= nil then
		thread( SetAI, aiBehaviorName, enemy, args )
	end

	if enemy.AdditionalAIFunctions ~= nil then
		for k, aiFunctionName in pairs(enemy.AdditionalAIFunctions) do
			thread( SetAI, aiFunctionName, enemy )
		end
	end

	ActivateDumbFireWeapons( CurrentRun, enemy )
end

function ActivateDumbFireWeapons( currentRun, enemy )

	if enemy.DumbFireWeapons ~= nil then
		for k, weaponData in pairs( enemy.DumbFireWeapons ) do
			if weaponData.Name == nil then
				weaponData = WeaponData[weaponData]
				thread( DumbFireAttack, enemy, weaponData )
			else
				thread( DumbFireAttack, enemy, weaponData )
			end
		end
	end
end

function CheckAvailableTextLines( source, args )

	args = args or {}

	if source.InteractTextLineSets == nil then
		return
	end

	local useableOff = NeedsUseableOff( source )
	if useableOff then
		return
	end

	if source.NextInteractLines ~= nil then
		-- Already has a conversation queued
		return
	end

	source.NextInteractLines = GetRandomEligibleTextLines( source, source.InteractTextLineSets, GetNarrativeDataValue( source, source.InteractTextLinePriorities or "InteractTextLinePriorities" ), args )
	if source.NextInteractLines ~= nil then
		if source.NextInteractLines.Partner ~= nil then
			CheckPartnerConversations( source )
		end
		SetNextInteractLines( source, source.NextInteractLines )
	end
end

function SetAvailableUseText( source )
	local canAssist = CanSpecialInteract( source )
	if source.NextInteractLines ~= nil or CanReceiveGift( source ) or canAssist or source.AlwaysShowDefaultUseText then
		RemoveInteractBlock( source, "SetAvailableUseText" )
		RefreshUseButton( source.ObjectId, source )
	else
		AddInteractBlock( source, "SetAvailableUseText" )
	end
end

function SetNextInteractLines( source, textLines )
	if textLines == nil then
		return
	end

	source.NextInteractLines = textLines

	if source.ForceKeepUseable then
		textLines.UseableOffSource = false
	end

	if source.NextInteractLines.UseText ~= nil then
		source.UseText = source.NextInteractLines.UseText
	end

	if source.NextInteractLines.InteractDistance ~= nil then
		SetInteractProperty({ DestinationId = source.ObjectId, Property = "Distance", Value = source.NextInteractLines.InteractDistance })
	end

	if textLines.TeleportToId ~= nil then
		Teleport({ Id = textLines.TeleportId or source.ObjectId, DestinationId = textLines.TeleportToId, OffsetX = textLines.TeleportOffsetX, OffsetY = textLines.TeleportOffsetY, OnlyIfDestinationExits = true, })
		source.ActiveNarrativeTeleportId = textLines.TeleportToId
	end
	if textLines.TeleportWithId ~= nil then
		Teleport({ Id = textLines.TeleportWithId, DestinationId = textLines.TeleportToId })
		Teleport({ Id = source.ObjectId, DestinationId = textLines.TeleportToId, OffsetX = textLines.TeleportOffsetX, OffsetY = textLines.TeleportOffsetY, OnlyIfDestinationExits = true, })
	end
	if textLines.AngleTowardTargetId ~= nil then
		AngleTowardTarget({ Id = textLines.AngleId or source.ObjectId, DestinationId = textLines.AngleTowardTargetId })
	end
	if textLines.OnQueuedFunctionName ~= nil then
		CallFunctionName( textLines.OnQueuedFunctionName, source, textLines.OnQueuedFunctionArgs )
	end
	if textLines.OnQueuedFunctions ~= nil then
		for k, onQueuedFunctionData in pairs( textLines.OnQueuedFunctions ) do
			if onQueuedFunctionData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, source, onQueuedFunctionData.GameStateRequirements ) then
				CallFunctionName( onQueuedFunctionData.Name, source, onQueuedFunctionData.Args )
			end
		end
	end
	if textLines.OnQueuedThreadedFunctionName ~= nil then
		thread( CallFunctionName, textLines.OnQueuedThreadedFunctionName, source, textLines.OnQueuedFunctionArgs )
	end
	if textLines.StatusAnimation then
		PlayStatusAnimation( source, { Animation = textLines.StatusAnimation } )
	end

end

function SetStatusAnimationFromTextLines( source, textLines )
	if not source or not textLines then
		return
	end

	if textLines.OnQueuedFunctionName ~= nil or textLines.OnQueuedThreadedFunctionName ~= nil then
		local onQueuedFunctionArgs = textLines.OnQueuedFunctionArgs
		if onQueuedFunctionArgs and onQueuedFunctionArgs.StatusAnimation then
			PlayStatusAnimation( source, { Animation = onQueuedFunctionArgs.StatusAnimation } )
		end
	end
	if textLines.OnQueuedFunctions ~= nil then
		for k, onQueuedFunctionData in pairs( textLines.OnQueuedFunctions ) do
			if onQueuedFunctionData.Args and onQueuedFunctionData.Args.StatusAnimation and ( onQueuedFunctionData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, source, onQueuedFunctionData.GameStateRequirements ) ) then
				PlayStatusAnimation( source, { Animation = onQueuedFunctionData.Args.StatusAnimation } )
			end
		end
	end

	if textLines.StatusAnimation then
		PlayStatusAnimation( source, { Animation = textLines.StatusAnimation } )
	end
end

function CheckConversations( source, args )
	args = args or {}
	local sortedUnits = {}
	for k, unitName in ipairs( NarrativeData.ConversationOrder ) do
		local unitIds = GetIdsByType({ Name = unitName })
		table.sort( unitIds )
		for k, unitId in ipairs( unitIds ) do
			local unit = ActiveEnemies[unitId]
			if unit ~= nil then
				table.insert( sortedUnits, unit )
			end
		end
	end
	for id, unit in ipairs( sortedUnits ) do
		CheckAvailableTextLines( unit )
		SetAvailableUseText( unit )
		if unit.NextInteractLines == nil and args.CheckNoConversationFunctions and unit.NoConversationFunctions ~= nil then
			for k, functionEntry in ipairs( unit.NoConversationFunctions ) do
				if functionEntry.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, unit, functionEntry.GameStateRequirements ) then
					CallFunctionName( functionEntry.Name, unit, functionEntry.Args )
				end
			end
		end
	end
end

function CalcTotalSpawns( currentRun, currentRoom, currentEncounter, spawnInfo )

	if spawnInfo.InfiniteSpawns then
		return 1
	end

	if spawnInfo.TotalCount == nil and (spawnInfo.CountMin == nil or spawnInfo.CountMax == nil) then
		return 0
	end

	if spawnInfo.RequiredMetaUpgrade ~= nil and GetNumMetaUpgrades(spawnInfo.RequiredMetaUpgrade) == 0 then
		return 0
	end

	if spawnInfo.RequiredFalseMetaUpgrade ~= nil and GetNumMetaUpgrades(spawnInfo.RequiredMetaUpgrade) > 0 then
		return 0
	end

	local totalSpawns = spawnInfo.TotalCount or RandomInt( spawnInfo.CountMin, spawnInfo.CountMax )
	if currentEncounter.EnemyCountDepthRamp ~= nil then
		totalSpawns = totalSpawns * ( 1.0 + ( (GetRunDepth( currentRun ) - 1) * currentEncounter.EnemyCountDepthRamp ) )
	end
	if currentEncounter.EnemyCountRunRamp ~= nil then
		totalSpawns = totalSpawns * ( 1.0 + ( GetCompletedRuns() * currentEncounter.EnemyCountRunRamp ) )
	end

	local spawnMultiplier = 1
	if not currentEncounter.BlockSpawnMultipliers then
		spawnMultiplier = GetTotalHeroTraitValue("SpawnMultiplier", { IsMultiplier = true })
	end

	totalSpawns = totalSpawns * spawnMultiplier

	return totalSpawns

end

function UnlockRoomExits( run, room, delay )

	if room.ExitsUnlocked then
		return
	end
	room.ExitsUnlocked = true

	thread( CheckQuestStatus )
	thread( CheckProgressAchievements )

	if CheckBounties( room ) then
		return
	end

	CheckUnusedWeaponBonusTrait()

	if IsEmpty( MapState.OfferedExitDoors ) then
		return
	end

	local roomData = RoomData[room.Name]
	local encounterData = nil
	if room.Encounter ~= nil then
		encounterData = EncounterData[room.Encounter.Name] or room.Encounter
	end

	wait( delay or roomData.UnlockExitsWait or 0.4 ) -- Must wait for post-reward presentation to complete

	local heroLocation = GetLocation({ Id = run.Hero.ObjectId })
	RecordObjectState( room, run.Hero.ObjectId, "Location", heroLocation )
	local heroAngle = GetAngle({ Id = run.Hero.ObjectId })
	RecordObjectState( room, run.Hero.ObjectId, "Angle", heroAngle )

	if encounterData.RecordActiveEnemies then
		local encounter = room.Encounter
		encounter.EnemiesToRestore = {}
		for id, v in pairs( encounter.ActiveSpawns ) do
			local enemy = ActiveEnemies[id]
			if enemy ~= nil then
				local enemyToRestore = { Name = enemy.Name, Location = GetLocation({ Id = enemy.ObjectId }) }
				table.insert( encounter.EnemiesToRestore, enemyToRestore )
			end
		end
	end

	if encounterData ~= nil and not encounterData.SkipExitReadyCheckpoint then
		DebugAssert({ Condition = encounterData.ExitsDontRequireCompleted or room.Encounter.Completed, Text = "Exits unlocked in incompleted encounter!" })
		room.CheckpointInvalidated = false
		RequestSave({ SaveName = "_Temp", DevSaveName = CreateDevSaveName( run, { PostReward = true } ) })
		ValidateCheckpoint({ Valid = true })
	end

	wait(0.02)

	DoUnlockRoomExits( run, room )

end

function ChooseNextRewardStore( run )

	RandomSynchronize()

	local rewardStoreName = nil
	local targetMetaRewardsRatio = (run.TargetMetaRewardsRatio or run.CurrentRoom.TargetMetaRewardsRatio or run.Hero.TargetMetaRewardsRatio)
	--DebugPrint({ Text = "targetMetaRewardsRatio = "..targetMetaRewardsRatio })
	local metaProgressChance = targetMetaRewardsRatio 
	local currentMetaProgressRatio = CalcMetaProgressRatio( run )
	if currentMetaProgressRatio ~= nil then
		metaProgressChance = metaProgressChance + (run.Hero.TargetMetaRewardsAdjustSpeed * (targetMetaRewardsRatio - currentMetaProgressRatio))
	end
	--DebugPrint({ Text = "metaProgressChance = "..metaProgressChance })
	if RandomChance( 0 ) then
		rewardStoreName = "MetaProgress"
	else
		rewardStoreName = "RunProgress"
	end
	--DebugPrint({ Text = "rewardStoreName = "..rewardStoreName })
	run.NextRewardStoreName = rewardStoreName
	return rewardStoreName

end

function DoUnlockRoomExits( run, room )

	-- Synchronize the RNG to its initial state. Makes room reward choices deterministic on save/load
	RandomSynchronize()

	local roomData = RoomData[room.Name] or room
	local encounterData = EncounterData[room.Encounter.Name] or room.Encounter

	local rewardsChosen = {}
	local rewardStoreName = run.NextRewardStoreName or ChooseNextRewardStore( run )
	local rewardStoreOverrides = {}
	local exitDoorsIPairs = CollapseTableOrdered( MapState.OfferedExitDoors )

	if room.UnavailableDoorIds ~= nil then
		for k, doorId in pairs(room.UnavailableDoorIds) do
			exitDoorsIPairs[doorId] = nil
		end
	end

	for index, door in ipairs( exitDoorsIPairs ) do
		if room.PersistentRoomForDoors and room.DoorRoomHistory ~= nil and room.DoorRoomHistory[door.ObjectId] ~= nil then 
			door.Room = run.RoomHistory[room.DoorRoomHistory[door.ObjectId]]
		end

		if door.Room == nil then
			if roomData.PredeterminedDoorRooms ~= nil and roomData.PredeterminedDoorRooms[door.ObjectId] ~= nil then
				door.ForceRoomName = roomData.PredeterminedDoorRooms[door.ObjectId]
			elseif room.PersistentRoomForDoors and room.ExitDoorRooms[door.ObjectId] ~= nil then
				door.ForceRoomName = room.ExitDoorRooms[door.ObjectId]
			end
			local roomForDoorData = nil
			if door.ForceRoomName ~= nil then
				roomForDoorData = RoomData[door.ForceRoomName]
			else
				roomForDoorData = ChooseNextRoomData( run, door.ChooseRoomArgs, exitDoorsIPairs )
			end
			local roomForDoor = CreateRoom( roomForDoorData, { SkipChooseReward = true, SkipChooseEncounter = true, })
			roomForDoor.NeedsReward = true
			door.Room = roomForDoor
		end

		local roomForDoorName = door.Room.GenusName or door.Room.Name
		if door.Room.ForcedRewardStore ~= nil then
			rewardStoreOverrides[index] = door.Room.ForcedRewardStore
		end
		if rewardStoreOverrides[index] and not Contains( RewardStoreData.InvalidOverrides, rewardStoreOverrides[index] ) then
			rewardStoreName = rewardStoreOverrides[index]
		end
		wait( 0.02 ) -- Distribute workload
	end

	if run.CurrentRoom.FirstAppearanceNumExitOverrides ~= nil and not HasSeenRoomEarlierInRun( run, run.CurrentRoom.Name ) then
		local randomDoors = ShallowCopyTable( exitDoorsIPairs )
		for i = 1, run.CurrentRoom.FirstAppearanceNumExitOverrides do
			local randomDoor = RemoveRandomValue( randomDoors )
			if randomDoor ~= nil and randomDoor.Room ~= nil then
				randomDoor.Room.UseOptionalOverrides = true
				for key, value in pairs( randomDoor.Room.OptionalOverrides ) do
					randomDoor.Room[key] = value
				end
			end
		end
	end

	--DebugAssert({ Condition = #exitDoorsIPairs == run.CurrentRoom.NumExits, Text = "NumExits data mismatched to actual exits for "..run.CurrentRoom.Name })

	if roomData.MinDoorCageRewards ~= nil and roomData.MaxDoorCageRewards ~= nil then
		local smallestCageAmount = roomData.MaxDoorCageRewards
		for index, door in ipairs( exitDoorsIPairs ) do
			if door.Room.MaxCageRewards ~= nil then
				smallestCageAmount = math.min(smallestCageAmount, door.Room.MaxCageRewards)
			end
		end
		room.MaxDoorCageRewards = smallestCageAmount
		if room.MaxDoorDepthChanceTable then
			room.NumDoorCageRewards = SelectFieldsDoorCageCount( run, room )
		else
			room.NumDoorCageRewards = RandomInt(room.MinDoorCageRewards, room.MaxDoorCageRewards)
		end
	end

	for index, door in ipairs( exitDoorsIPairs ) do
		local doorRoom = door.Room
		if doorRoom ~= nil and doorRoom.NeedsReward then
			if doorRoom.IndividualRewardStore ~= nil then
				doorRoom.RewardStoreName = doorRoom.IndividualRewardStore
			elseif rewardStoreOverrides[index] ~= nil and not Contains( RewardStoreData.InvalidOverrides, rewardStoreOverrides[index] ) then
				doorRoom.RewardStoreName = rewardStoreOverrides[index]
			else
				doorRoom.RewardStoreName = rewardStoreName
			end
			doorRoom.ChosenRewardType = ChooseRoomReward( CurrentRun, doorRoom, doorRoom.RewardStoreName, rewardsChosen, { Door = door } )
			if doorRoom.ChosenRewardType ~= nil then
				SetupRoomReward( CurrentRun, doorRoom, rewardsChosen, { Door = door, IgnoreForceLootName = doorRoom.IgnoreForceLootName } )
				table.insert( rewardsChosen, { RewardType = doorRoom.ChosenRewardType, ForceLootName = doorRoom.ForceLootName, } )
			end
			doorRoom.NeedsReward = false

			if doorRoom.MaxCageRewards ~= nil then
				doorRoom.CageRewards = {}
				for i = 1, room.NumDoorCageRewards or 2 do
					local cageRoom = DeepCopyTable(doorRoom)
					cageRoom.NeedsReward = true
					cageRoom.NoReward = false
					cageRoom.ChosenRewardType = ChooseRoomReward( CurrentRun, cageRoom, cageRoom.RewardStoreName, rewardsChosen )
					SetupRoomReward( CurrentRun, cageRoom, rewardsChosen, { Door = door, IgnoreForceLootName = cageRoom.IgnoreForceLootName } )
					local reward = { RewardType = cageRoom.ChosenRewardType, ForceLootName = cageRoom.ForceLootName, }
					table.insert( rewardsChosen, reward )
					table.insert( doorRoom.CageRewards, reward )
				end
			end
			--DebugPrint({ Text = "Door Cage Rewards:" })
			--DebugPrintTable( doorRoom.CageRewards, true )

			if doorRoom.UseOptionalOverrides then
				for key, value in pairs( doorRoom.OptionalOverrides ) do
					doorRoom[key] = value
				end
			end
			AssignRoomToExitDoor( door, doorRoom )
			wait( 0.02 ) -- Distribute workload
		end

	end

	wait( 0.02 ) -- Distribute workload

	RandomSynchronize( #exitDoorsIPairs )

	for index, door in ipairs( exitDoorsIPairs ) do
		if door.PreExitsUnlockedFunctionName ~= nil then
			thread( CallFunctionName, door.PreExitsUnlockedFunctionName, door, door.PreExitsUnlockedFunctionArgs )
		end
	end

	for index, door in ipairs( exitDoorsIPairs ) do
		if not door.SkipUnlock then
			CreateDoorRewardPreview( door )
			thread( ExitDoorUnlockedPresentation, door )
			door.ReadyToUse = true
			if door.OnUnlockThreadedFunctionName ~= nil then
				thread( CallFunctionName, door.OnUnlockThreadedFunctionName, door, door.OnUnlockThreadedFunctionArgs )
			end
		end
	end

	for id, obstacle in pairs( MapState.ActiveObstacles ) do
		if obstacle.ExitsUnlockedFunctionName ~= nil then
			thread( CallFunctionName, obstacle.ExitsUnlockedFunctionName, obstacle, obstacle.ExitsUnlockedFunctionArgs )
		end
	end

	if CurrentRun.CurrentRoom.ChallengeSwitch ~= nil then
		local challengeSwitch = CurrentRun.CurrentRoom.ChallengeSwitch
		local startingValue = challengeSwitch.StartingValue or 0
		if challengeSwitch.RewardType == "Health" then
			startingValue = startingValue * CalculateHealingMultiplier()
		end
		if challengeSwitch.RewardType == "Money" and HasHeroTraitValue("BlockMoney") then
			startingValue = 0
		end
		challengeSwitch.StartingValue = round( startingValue )
		challengeSwitch.ReadyToUse = true
		challengeSwitch.UseText = challengeSwitch.ChallengeAvailableUseText
		RefreshUseButton( challengeSwitch.ObjectId, challengeSwitch )
		SetAnimation({ Name = challengeSwitch.UnlockedAnimationName, DestinationId = challengeSwitch.ObjectId })
		PlaySound({ Name = "/SFX/ChallengeChestUnlocked", Id = challengeSwitch.ObjectId })
	end
	if CurrentRun.CurrentRoom.WellShop ~= nil then
		CurrentRun.CurrentRoom.WellShop.ReadyToUse = true
		CurrentRun.CurrentRoom.WellShop.UseText = CurrentRun.CurrentRoom.WellShop.AvailableUseText
		RefreshUseButton( CurrentRun.CurrentRoom.WellShop.ObjectId, CurrentRun.CurrentRoom.WellShop )
		SetAnimation({ Name = "WellShopUnlocked", DestinationId = CurrentRun.CurrentRoom.WellShop.ObjectId })
		PlaySound({ Name = "/SFX/WellShopUnlocked", Id = CurrentRun.CurrentRoom.WellShop.ObjectId })
	end
	if CurrentRun.CurrentRoom.SurfaceShop ~= nil then
		CurrentRun.CurrentRoom.SurfaceShop.ReadyToUse = true
		CurrentRun.CurrentRoom.SurfaceShop.UseText = CurrentRun.CurrentRoom.SurfaceShop.AvailableUseText
		RefreshUseButton( CurrentRun.CurrentRoom.SurfaceShop.ObjectId, CurrentRun.CurrentRoom.SurfaceShop )
		SetAnimation({ Name = "SurfaceShopUnlocked", DestinationId = CurrentRun.CurrentRoom.SurfaceShop.ObjectId })
		PlaySound({ Name = "/SFX/Menu Sounds/KeepsakeHermesFastClear", Id = CurrentRun.CurrentRoom.SurfaceShop.ObjectId })
	end

	StartTriggers( CurrentRun.CurrentRoom, roomData.ExitsUnlockedDistanceTriggers )

	RunThreadedEvents( encounterData.ExitsUnlockedThreadedEvents, room.Encounter )
	RunThreadedEvents( roomData.ExitsUnlockedThreadedEvents, room )

end

function AssignRoomToExitDoor( door, room )

	door.Room = room
	MapState.OfferedExitDoors[door.ObjectId] = door
	CurrentRun.CurrentRoom.ExitDoorRooms[door.ObjectId] = room.Name

	AddToGroup({ Id = door.ObjectId, Name = "ExitDoors" })

	CurrentRun.CurrentRoom.OfferedRewards = CurrentRun.CurrentRoom.OfferedRewards or {}
	if room.ChosenRewardType ~= nil then
		local offeredReward =
		{
			Type = room.ChosenRewardType,
			ForceLootName = room.ForceLootName,
			UseOptionalOverrides = room.UseOptionalOverrides,
		}
		if room.Encounter ~= nil then
			offeredReward.LootAName = room.Encounter.LootAName
			offeredReward.LootBName = room.Encounter.LootBName
		end
		CurrentRun.CurrentRoom.OfferedRewards[door.ObjectId] = offeredReward
	end
	if door.AllowReroll and not room.NoReroll and CheckSpecialDoorRequirement( door ) == nil and room.ChosenRewardType ~= "Shop" and HasHeroTraitValue( "AllowDoorReroll" ) then
		door.CanBeRerolled = true
	end
	RefreshUseButton( door.ObjectId, door )

end

function CheckExitPreUnlock( door, args )

	local currentRoom = CurrentRun.CurrentRoom
	currentRoom.FirstExitChosen = currentRoom.FirstExitChosen or false -- Make sure at least one exit opens

	if currentRoom.LockExtraExitsWithEncounter ~= nil and currentRoom.LockExtraExits and currentRoom.FirstExitChosen then

		if RandomChance(door.LockedWithEncounterChance) then
			door.SkipUnlock = true
			door.ReadyToUse = true
			door.CanBeRerolled = false
			door.EncounterCost = currentRoom.LockExtraExitsWithEncounter
			LockExtraExitsPresentation( door )
		end

	else
		currentRoom.FirstExitChosen = true
	end

end

function LeaveRoom( currentRun, door )

	local nextRoom = door.Room
	local currentRoomData = RoomData[CurrentRun.CurrentRoom.Name]
	if CurrentRun.CurrentRoom.TempHealth then
		Damage( CurrentRun.Hero, { SourceWeapon = "TempHealth", DamageAmount = CurrentRun.CurrentRoom.TempHealth, MinHealth = 1, PureDamage = true, Silent = true } )
	end
	if MapState.FamiliarUnit ~= nil then
		MapState.FamiliarUnit.DisableAIWhenReady = true
		--CleanupEnemy( MapState.FamiliarUnit )
	end

	CurrentRun.NextHeroStartPoint = CurrentRun.CurrentRoom.NextHeroStartPoint or CurrentRun.NextHeroStartPoint
	CurrentRun.NextHeroEndPoint = CurrentRun.CurrentRoom.NextHeroEndPoint or CurrentRun.NextHeroEndPoint

	CurrentRun.Hero.ReserveManaSources = {}
	ClearEffect({ Id = currentRun.Hero.ObjectId, All = true, BlockAll = true, })
	StopCurrentStatusAnimation( currentRun.Hero )
	currentRun.Hero.BlockStatusAnimations = true
	AddTimerBlock( currentRun, "LeaveRoom" )
	SetPlayerInvulnerable( "LeaveRoom" )
	EndSpellTransform()

	ClearGameplayElapsedTimeMultipliers()

	local ammoIds = GetIdsByType({ Name = "LobAmmoPack" })
	SetObstacleProperty({ Property = "Magnetism", Value = 3000, DestinationIds = ammoIds })
	SetObstacleProperty({ Property = "MagnetismSpeedMax", Value = 2000, DestinationIds = ammoIds })
	StopAnimation({ DestinationIds = ammoIds, Name = "AmmoReturnTimer" })

	RunEventsGeneric( currentRun.CurrentRoom.LeaveEvents, currentRun.CurrentRoom )
	if MapState.FamiliarUnit ~= nil then
		RunEventsGeneric( MapState.FamiliarUnit.LeaveEvents, MapState.FamiliarUnit )
	end

	GamePhaseTick()

	ResetObjectives()

	if currentRun.CurrentRoom.ChallengeEncounter ~= nil and currentRun.CurrentRoom.ChallengeEncounter.InProgress then
		currentRun.CurrentRoom.ChallengeEncounter.EndedEarly = true
		currentRun.CurrentRoom.ChallengeEncounter.InProgress = false
	end

	if currentRun.CurrentRoom.PersistentRoomForDoors then
		currentRun.CurrentRoom.DoorRoomHistory = currentRun.CurrentRoom.DoorRoomHistory or {}
		currentRun.CurrentRoom.DoorRoomHistory[door.ObjectId] = #currentRun.RoomHistory + 2 -- CurrentRoom has not been added, next room has not been added
	end

	if currentRun.CurrentRoom.CloseDoorsOnUse then
		CloseDoorForRun( currentRun, door )
	end

	LeaveRoomStartPresentation( door )

	if nextRoom.TimesVisited == 0 then
		if not nextRoom.BlockDoorHealFromPrevious then
			local leaveRoomFunctionNames = {}
			for _, value in pairs(GetHeroTraitValues("LeaveRoomFunctionName")) do
				leaveRoomFunctionNames[ value ] = true
			end

			for functionName in pairs( leaveRoomFunctionNames ) do
				thread( CallFunctionName, functionName, currentRun, door )
			end
		end
	end
	local removedTraits = {}
	for _, trait in pairs( currentRun.Hero.Traits ) do
		if trait.StatMultiplier then
			if trait.BlockDecay then
				trait.BlockDecay = false
			else
				trait.StatMultiplier = trait.StatMultiplier - trait.Decay
				if trait.StatMultiplier > 0 then
					local maxHealth = trait.StatMultiplier * trait.StartMaxHealth
					local maxMana = trait.StatMultiplier * trait.StartMaxMana
					trait.PropertyChanges[1].ChangeValue = maxMana
					trait.PropertyChanges[2].ChangeValue = maxHealth
					ValidateMaxHealth( true )
					ValidateMaxMana()
				else
					table.insert( removedTraits, trait )
				end
			end
		end
		if trait.RemainingUses ~= nil and trait.UsesAsRooms ~= nil and trait.UsesAsRooms then
			UseTraitData( currentRun.Hero, trait )
			if trait.RemainingUses ~= nil and trait.RemainingUses <= 0 then
				table.insert( removedTraits, trait )
			end
		end
	end
	for _, trait in pairs( removedTraits ) do
		RemoveTraitData( currentRun.Hero, trait )
	end
	if nextRoom.PauseBiomeState then
		EndAllBiomeStates()
	elseif currentRoomData.PauseBiomeState 
		and not nextRoom.PauseBiomeState 
		and CurrentRun.BiomeStateName 
		and BiomeStateData.BiomeStates[CurrentRun.BiomeStateName] 
		and BiomeStateData.BiomeStates[CurrentRun.BiomeStateName].TraitName 
		and not HeroHasTrait(BiomeStateData.BiomeStates[CurrentRun.BiomeStateName].TraitName) then
		
		AddTraitToHero({TraitName = BiomeStateData.BiomeStates[CurrentRun.BiomeStateName].TraitName, SkipUIUpdate = true, SkipPriorityTray = true })	
	end

	local heroExitPointId = GetClosest({ Id = door.ObjectId, DestinationIds = GetIdsByType({ Name = "HeroExit" }) })
	local angleToExit = GetAngleBetween({ Id = door.ObjectId, DestinationId = heroExitPointId })
	if currentRoomData.IgnoreExitDirection then
		-- Do nothing
	elseif RoomData[currentRun.CurrentRoom.Name].CardinalEntranceDirection then
		if angleToExit > 0 and angleToExit < 90 then
			currentRun.CurrentRoom.ExitDirection = "North"
		elseif angleToExit > 90 and angleToExit < 180 then
			currentRun.CurrentRoom.ExitDirection = "West"
		elseif angleToExit > 180 and angleToExit < 270 then
			currentRun.CurrentRoom.ExitDirection = "South"
		else
			currentRun.CurrentRoom.ExitDirection = "East"
		end
	else
		if angleToExit < 90 or angleToExit > 270 then
			currentRun.CurrentRoom.ExitDirection = "Right"
		else
			currentRun.CurrentRoom.ExitDirection = "Left"
		end
	end
	
	if CurrentRun.Hero.HealthBuffer then
		CurrentRun.Hero.HealthBuffer = 0
	end

	local exitFunctionName = currentRun.CurrentRoom.ExitFunctionName or door.Room.PrevRoomExitFunctionName or door.ExitFunctionName or "LeaveRoomPresentation"
	local exitFunctionArgs = currentRun.CurrentRoom.ExitFunctionArgs or door.Room.PrevRoomExitFunctionArgs or door.ExitFunctionArgs or {}
	for i, priority in ipairs( RoomEventData.ExitFunctionNamePriorities ) do
		if priority == door.ExitFunctionName then
			exitFunctionName = door.ExitFunctionName
			exitFunctionArgs = door.ExitFunctionArgs or {}
			break
		elseif priority == door.Room.PrevRoomExitFunctionName then
			exitFunctionName = door.Room.PrevRoomExitFunctionName
			exitFunctionArgs = door.Room.PrevRoomExitFunctionArgs or {}
			break
		elseif priority == currentRun.CurrentRoom.ExitFunctionName then
			exitFunctionName = currentRun.CurrentRoom.ExitFunctionName
			exitFunctionArgs = currentRun.CurrentRoom.ExitFunctionArgs or {}
			break
		end
	end
	CallFunctionName( exitFunctionName, currentRun, door, exitFunctionArgs )
	if currentRoomData.LeavePostPresentationEvents ~= nil then
		RunEventsGeneric( currentRoomData.LeavePostPresentationEvents, currentRoom )
	end

	SetThingProperty({ Property = "Ambient", Value = 0.0, DestinationId = currentRun.Hero.ObjectId })
	if not currentRun.Hero.IsDead then
		--On hero death cleanup is already processed
		CleanupEnemies()
	end

	RemoveTimerBlock( currentRun, "LeaveRoom" )
	if currentRoomData.TimerBlock ~= nil then
		RemoveTimerBlock( currentRun, currentRoomData.TimerBlock )
	end
	SetPlayerVulnerable( "LeaveRoom" )
	
	RefillMana()

	if currentRun.CurrentRoom.SkipLoadNextMap then
		return
	end

	MapState.OfferedExitDoors = {}

	local flipMap = false
	if nextRoom.Flipped == nil then
		if currentRun.CurrentRoom.ExitDirection ~= nil and nextRoom.EntranceDirection ~= nil and nextRoom.EntranceDirection ~= "LeftRight" then
			flipMap = nextRoom.EntranceDirection ~= currentRun.CurrentRoom.ExitDirection
		else
			flipMap = RandomChance( nextRoom.FlipHorizontalChance or 0.5 )
		end
		nextRoom.Flipped = flipMap
	end

	currentRun.CurrentRoom.EndingHealth = currentRun.Hero.Health
	table.insert( currentRun.RoomHistory, currentRun.CurrentRoom )
	UpdateRunHistoryCache( currentRun, currentRun.CurrentRoom )

	if nextRoom.Encounter == nil and nextRoom.Encounters == nil then
		if nextRoom.MultipleEncountersData ~= nil then
			SetupRoomMultipleEncountersData(nextRoom)
		else
			nextRoom.Encounter = ChooseEncounter( CurrentRun, nextRoom )
			RecordEncounter( CurrentRun, nextRoom.Encounter )
		end
	end
	if nextRoom.CageRewards ~= nil then
		for i, reward in pairs( nextRoom.CageRewards ) do
			reward.Encounter = ChooseEncounter( CurrentRun, nextRoom, { LegalEncounters = ObstacleData.FieldsRewardCage.LegalEncounters } )
			RecordEncounter( CurrentRun, reward.Encounter )
		end
	end

	local previousRoom = currentRun.CurrentRoom
	currentRun.CurrentRoom = nextRoom

	RunShopGeneration( currentRun.CurrentRoom )

	GameState.LocationName = nextRoom.SaveProfileLocationText
	RandomSetNextInitSeed()
	if not nextRoom.SkipSave then
		RequestSave({ StartNextMap = nextRoom.Name, SaveName = "_Temp", DevSaveName = CreateDevSaveName( currentRun ) })
		ValidateCheckpoint({ Value = true })
	end

	RemoveInputBlock({ Name = "MoveHeroToRoomPosition" })
	AddInputBlock({ Name = "MapLoad" })
	AddTimerBlock( CurrentRun, "MapLoad" )

	door.InUse = false
	nextRoom.TimesVisited = nextRoom.TimesVisited + 1

	LoadMap({ Name = nextRoom.Name, ResetBinks = previousRoom.ResetBinksOnExit or currentRun.CurrentRoom.ResetBinksOnEnter, LoadBackgroundColor = currentRun.CurrentRoom.LoadBackgroundColor })

end

function SetupRoomMultipleEncountersData(room, args)
	room.Encounters = {}
	args = args or {}
	for i = 1, #room.MultipleEncountersData do
		local multipleEncounterData = room.MultipleEncountersData[i]
		if IsGameStateEligible(CurrentRun, multipleEncounterData, multipleEncounterData.GameStateRequirements) then
			room.Encounters[i] = ChooseEncounter( CurrentRun, room, multipleEncounterData )
			room.Encounters[i].RoomChanges = room.MultipleEncountersData[i].RoomChanges
			RecordEncounter( CurrentRun, room.Encounters[i] )
		else
			break
		end
	end
	room.Encounters[#room.Encounters].LastEncounter = true
	room.Encounters[#room.Encounters].SkipLastKillPresentation = false
	room.Encounter = room.Encounters[1]
end


function RecordEncounter( run, encounter )

	run.EncountersOccurredCache[encounter.Name] = (run.EncountersOccurredCache[encounter.Name] or 0) + 1
	GameState.EncountersOccurredCache[encounter.Name] = (GameState.EncountersOccurredCache[encounter.Name] or 0) + 1

	run.EncountersOccurredBiomeCache[encounter.Name] = (run.EncountersOccurredBiomeCache[encounter.Name] or 0) + 1

	run.EncountersDepthCache[encounter.Name] = run.RunDepthCache

end

function StartTriggers( triggerSource, triggers )

	if triggerSource == nil or triggers == nil then
		return
	end

	for k, trigger in ipairs( triggers ) do
		thread( CheckDistanceTrigger, trigger, triggerSource )
	end

end

function CheckDistanceTriggerThread( source, args )
	args = args or {}
	if args.SetupFunctions ~= nil then
		for k, setupFunctionEntry in ipairs( args.SetupFunctions ) do
			if setupFunctionEntry.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, source, setupFunctionEntry.GameStateRequirements ) then
				CallFunctionName( setupFunctionEntry.Name, args, setupFunctionEntry.Args )
			end
		end
	end
	thread( CheckDistanceTrigger, args, source )
end

function DistanceTrigger( source, args )
	
	local triggerId = args.Id or source.ObjectId
	local sourceName = source.Name or ""
	local triggerName = args.TriggerName or "DistanceTrigger"..sourceName..triggerId

	if args.PreTriggerEvents ~= nil then
		RunEventsGeneric( args.PreTriggerEvents, source, args )
	end

	local triggeredOnce = false
	while not triggeredOnce or args.Repeat do

		triggeredOnce = true

		local notifiedById = 0
		if args.OutsideDistance ~= nil then
			local notifyName = args.NotifyName or "OutsideDistance"..triggerName
			NotifyOutsideDistanceAll({ Id = CurrentRun.Hero.ObjectId, DestinationId = triggerId, Distance = args.OutsideDistance, ScaleY = args.ScaleY, Notify = notifyName })
			waitUntil( notifyName )
			notifiedById = NotifyResultsTable[notifyName]
		end

		if args.WithinDistance ~= nil then
			local notifyName = args.NotifyName or "WithinDistance"..triggerName
			NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { triggerId }, Distance = args.WithinDistance, ScaleY = args.ScaleY, Notify = notifyName })
			waitUntil( notifyName )
			notifiedById = NotifyResultsTable[notifyName]
		end
		notifiedById = notifiedById or 0

		CurrentRun.TriggerRecord[triggerName] = (CurrentRun.TriggerRecord[triggerName] or 0) + 1
		GameState.TriggerRecord[triggerName] = (GameState.TriggerRecord[triggerName] or 0) + 1

		if args.PostTriggerEvents ~= nil then
			RunEventsGeneric( args.PostTriggerEvents, source, args )
		end

		if args.Repeat then

			wait( 0.01 )

			local repeatBufferDistance = args.RepeatBufferDistance or 10
			if args.OutsideDistance ~= nil then
				local notifyName = args.NotifyName or "OutsideDistanceRepeatBuffer"..triggerName
				NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { triggerId }, Distance = args.OutsideDistance - repeatBufferDistance, ScaleY = args.ScaleY, Notify = notifyName })
				waitUntil( notifyName )
			end
			if args.WithinDistance ~= nil then
				local notifyName = args.NotifyName or "WithinDistanceRepeatBuffer"..triggerName
				NotifyOutsideDistanceAll({ Id = CurrentRun.Hero.ObjectId, DestinationId = triggerId, Distance = args.WithinDistance + repeatBufferDistance, ScaleY = args.ScaleY, Notify = notifyName })
				waitUntil( notifyName )
 			end

			wait( 0.01 )

			if args.OnRepeatEvents ~= nil then
				RunEventsGeneric( args.OnRepeatEvents, source, args )
			end

		end
	end
end

-- @deprecated - Use function DistanceTrigger() above
function CheckDistanceTrigger( trigger, triggerSource, id )

	if trigger == nil then
		return
	end

	-- Converting to modern patterns
	local args = ShallowCopyTable( trigger )
	args.TriggerSource = triggerSource

	local currentRun = CurrentRun

	trigger.Name = trigger.Name or triggerSource.Name..(triggerSource.ObjectId or trigger.TriggerGroup or trigger.TriggerObjectType)..(id or "")

	local triggerIds = trigger.TriggerIds or { trigger.TriggerId }
	if triggerSource.ObjectId ~= nil then
		triggerIds = { triggerSource.ObjectId }
	end
	if trigger.TriggerGroup ~= nil or trigger.TriggerGroups ~= nil then
		triggerIds = GetIds({ Name = trigger.TriggerGroup, Names = trigger.TriggerGroups })
	elseif trigger.TriggerObjectType ~= nil then
		triggerIds = GetIdsByType({ Name = trigger.TriggerObjectType })
	end
	local actualSource = nil
	if triggerIds ~= nil then
		triggerId = triggerIds[1]
		if ActiveEnemies ~= nil then
			actualSource = ActiveEnemies[triggerId]
		end
	end

	if actualSource ~= nil and actualSource.NextInteractLines ~= nil and actualSource.NextInteractLines.BlockDistanceTriggers then
		return
	end

	wait( trigger.PreEligibilityWait )

	if not IsDistanceTriggerEligible( currentRun, trigger, trigger.GameStateRequirements ) then
		return
	end

	wait( trigger.PreTriggerWait )

	if trigger.PreTriggerAnimation ~= nil and not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAnimation({ Name = trigger.PreTriggerAnimation, DestinationId = triggerSource.ObjectId })
	end

	if trigger.PreTriggerAlpha ~= nil and not GetConfigOptionValue({ Name = "EditingMode" })  then
		SetAlpha({ Id = triggerSource.ObjectId, Fraction = trigger.PreTriggerAlpha, Duration = trigger.PreTriggerAlphaDuration or 1 })
	end

	if trigger.PreTriggerFunctionName ~= nil then
		CallFunctionName( trigger.PreTriggerFunctionName, actualSource or triggerSource, trigger.PreTriggerFunctionArgs )
	end

	local triggeredOnce = false
	while not triggeredOnce or trigger.Repeat do

		triggeredOnce = true

		if triggerSource.ObjectId ~= nil then
			triggerIds = { triggerSource.ObjectId }
		end
		if trigger.TriggerGroup ~= nil then
			triggerIds = GetIds({ Name = trigger.TriggerGroup })
		elseif trigger.TriggerObjectType ~= nil then
			triggerIds = GetIdsByType({ Name = trigger.TriggerObjectType })
		end

		local notifiedById = 0
		if trigger.OutsideDistance ~= nil then
			local notifyName = args.NotifyName or "OutsideDistance"..trigger.Name
			NotifyOutsideDistanceAll({ Id = currentRun.Hero.ObjectId, DestinationNames = trigger.TriggerGroup, DestinationIds = triggerIds, Distance = trigger.OutsideDistance, ScaleY = trigger.ScaleY, Notify = notifyName })
			waitUntil( notifyName )
			notifiedById = NotifyResultsTable[notifyName]
		end

		if trigger.WithinDistance ~= nil then
			local notifyName = args.NotifyName or "WithinDistance"..trigger.Name
			local destinationNames = { trigger.TriggerGroup }
			if trigger.TriggerGroups ~= nil then
				destinationNames = CombineTables( destinationNames, trigger.TriggerGroups )
			end
			NotifyWithinDistanceAny({ Ids = { currentRun.Hero.ObjectId }, DestinationNames = destinationNames, DestinationIds = triggerIds, Distance = trigger.WithinDistance, ScaleY = trigger.ScaleY, Notify = notifyName })
			waitUntil( notifyName )
			notifiedById = NotifyResultsTable[notifyName]
		end
		notifiedById = notifiedById or 0

		currentRun.TriggerRecord[trigger.Name] = (currentRun.TriggerRecord[trigger.Name] or 0) + 1
		GameState.TriggerRecord[trigger.Name] = (GameState.TriggerRecord[trigger.Name] or 0) + 1

		local triggeredBy = ActiveEnemies[notifiedById]

		if trigger.ChanceToTrigger ~= nil and not RandomChance( trigger.ChanceToTrigger ) then
			break
		end

		if trigger.VoiceLines ~= nil then
			thread( PlayVoiceLines, trigger.VoiceLines, nil, triggeredBy, args )
		end

		if trigger.GlobalVoiceLines ~= nil then
			thread( PlayVoiceLines, GlobalVoiceLines[trigger.GlobalVoiceLines], true, triggeredBy, args )
		end

		if trigger.LockToCharacter ~= nil then
			for k, id in pairs( triggerIds ) do
				thread( PanToTargetAndBack, id )
			end
		end

		if trigger.FunctionName ~= nil then
			CallFunctionName( trigger.FunctionName, actualSource or triggerSource, trigger.Args )
		end

		if trigger.PostTriggerAnimation ~= nil then
			SetAnimation({ Name = trigger.PostTriggerAnimation, DestinationId = triggerSource.ObjectId })
		end

		if trigger.PostTriggerAlpha ~= nil and not GetConfigOptionValue({ Name = "EditingMode" })  then
			SetAlpha({ Id = triggerSource.ObjectId, Fraction = trigger.PostTriggerAlpha, Duration = trigger.PostTriggerAlphaDuration or 1 })
		end

		if trigger.StatusAnimation ~= nil then
			PlayStatusAnimation( triggerSource, { Animation = trigger.StatusAnimation } )
		end
		if trigger.CheckTextLinesStatusAnimation and triggerSource.NextInteractLines ~= nil and triggerSource.NextInteractLines.StatusAnimation then
			PlayStatusAnimation( triggerSource, { Animation = triggerSource.NextInteractLines.StatusAnimation } )
		end

		if trigger.Emote ~= nil then
			PlayEmote( { TargetId = notifiedById, AnimationName = trigger.Emote, OffsetZ = triggerSource.EmoteOffsetZ } )
		end

		if trigger.PostTriggerFunctionName ~= nil then
			CallFunctionName( trigger.PostTriggerFunctionName, actualSource or triggerSource, trigger.PostTriggerFunctionArgs )
		end

		if trigger.Repeat then

			wait(0.01)

			local repeatBufferDistance = trigger.RepeatBufferDistance or 10
			if trigger.OutsideDistance ~= nil then
				local notifyName = args.NotifyName or "OutsideDistanceRepeatBuffer"..(trigger.Name or trigger.TriggerGroup or trigger.TriggerObjectType)
				NotifyWithinDistanceAny({ Ids = { currentRun.Hero.ObjectId }, DestinationNames = { trigger.TriggerGroup }, DestinationIds = triggerIds,
					Distance = trigger.OutsideDistance - repeatBufferDistance, ScaleY = trigger.ScaleY, Notify = notifyName })
				waitUntil( notifyName )
			end
			if trigger.WithinDistance ~= nil then
				local notifyName = args.NotifyName or "WithinDistanceRepeatBuffer"..(trigger.Name or trigger.TriggerGroup or trigger.TriggerObjectType)
				NotifyOutsideDistanceAll({ Id = currentRun.Hero.ObjectId, DestinationNames = trigger.TriggerGroup, DestinationIds = triggerIds,
					Distance = trigger.WithinDistance + repeatBufferDistance, ScaleY = trigger.ScaleY, Notify = notifyName })
				waitUntil( notifyName )
 			end

			wait(0.01)

			if trigger.OnRepeatAlpha ~= nil and not GetConfigOptionValue({ Name = "EditingMode" })  then
				SetAlpha({ Id = triggerSource.ObjectId, Fraction = trigger.OnRepeatAlpha, Duration = trigger.OnRepeatAlphaDuration or 1 })
			end

			if trigger.OnRepeatFunctionName ~= nil then
				CallFunctionName( trigger.OnRepeatFunctionName, actualSource or triggerSource, trigger.OnRepeatFunctionArgs )
			end

		elseif trigger.LeaveDistanceBuffer ~= nil then

			if trigger.OutsideDistance ~= nil then
				local notifyName = "OutsideDistanceRepeatBuffer"..(trigger.TriggerGroup or trigger.TriggerObjectType)
				NotifyWithinDistanceAny({ Ids = { currentRun.Hero.ObjectId }, DestinationNames = { trigger.TriggerGroup }, DestinationIds = triggerIds, Distance = trigger.OutsideDistance - trigger.LeaveDistanceBuffer, Notify = notifyName })
				waitUntil( notifyName )
			end
			if trigger.WithinDistance ~= nil then
				local notifyName = "WithinDistanceRepeatBuffer"..(trigger.TriggerGroup or trigger.TriggerObjectType)
				NotifyOutsideDistanceAll({ Ids = { currentRun.Hero.ObjectId }, DestinationNames = { trigger.TriggerGroup }, DestinationIds = triggerIds, Distance = trigger.WithinDistance + trigger.LeaveDistanceBuffer, Notify = notifyName })
				waitUntil( notifyName )
 			end

		end

	end

end

function IsDistanceTriggerEligible( currentRun, trigger, requirements )

	if trigger.TriggerOnceThisRun and currentRun.TriggerRecord[trigger.Name] then
		return false
	end

	if requirements ~= nil and not IsGameStateEligible( currentRun, trigger, requirements ) then
		return false
	end

	return true

end

function PanToTargetAndBack( targetId )
	PanCamera({ Ids = { targetId, CurrentRun.Hero.ObjectId }, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
	wait(3.0)
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
end

function AssignObstacles( eventSource )

	if eventSource.ObstacleData == nil then
		return
	end

	for id, obstacleData in pairs( eventSource.ObstacleData ) do
		if not obstacleData.SkipDefaultSetup then
			local obstacle = DeepCopyTable( obstacleData )
			obstacle.ObjectId = id
			if obstacle.Template ~= nil and ObstacleData[obstacle.Template] ~= nil then
				obstacle = MergeTables( ObstacleData[obstacle.Template], obstacle )
			end
			SetupObstacle( obstacle )
		end
	end

end

function PlayStatusAnimation( source, args )

	local animation = args.Animation

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if source.BlockStatusAnimations then
		return
	end

	if animation == source.StatusAnimation then
		-- Already playing this
		return
	end

	if not IsAlive({ Id = source.ObjectId }) then
		return
	end

	if source.StatusAnimation ~= nil then
		StopAnimation({ Name = source.StatusAnimation, DestinationId = source.ObjectId })
	end

	source.PrevStatusAnimation = source.StatusAnimation
	source.StatusAnimation = animation
	local group = nil
	if not source.StatusAnimUseOwnerGroup then
		group = source.StatusAnimGroup or "Combat_UI_World"
	end
	CreateAnimation({ Name = animation, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = args.AnimOffsetZ or source.AnimOffsetZ, Group = group })

end

function StopCurrentStatusAnimation( source )
	if source.StatusAnimation ~= nil then
		StopAnimation({ Name = source.StatusAnimation, DestinationId = source.ObjectId })
		source.StatusAnimation = nil
	end
end

function StopStatusAnimation( source, animation )

	if not ConfigOptionCache.ShowUIAnimations then
		return false
	end

	if source == nil then
		return false
	end

	if animation == nil then
		animation = source.StatusAnimation
	else
		if animation ~= source.StatusAnimation then
			-- Not the one currently playing
			if animation == source.PrevStatusAnimation then
				-- Stop the stored animation, so it isn't resumed
				source.PrevStatusAnimation = nil
			end
			return false
		end
	end

	if animation ~= nil then
		StopAnimation({ Name = animation, DestinationId = source.ObjectId })
	end
	source.StatusAnimation = nil

	if source.PrevStatusAnimation ~= nil and source.PrevStatusAnimation ~= source.StatusAnimation then
		source.StatusAnimation = source.PrevStatusAnimation
		if IsAlive({ Id = source.ObjectId }) then
			local group = nil
			if not source.StatusAnimUseOwnerGroup then
				group = source.StatusAnimGroup or "Combat_UI_World"
			end
			CreateAnimation({ Name = source.PrevStatusAnimation, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = group })
			source.PrevStatusAnimation = nil
		end
	end
	return true
end

function HandleSecretSpawns( currentRun )

	local currentRoom = currentRun.CurrentRoom

	if verboseLogging and currentRoom.ValidateSecretData then
		ValidateRoomSecretData( currentRoom )
	end

	RandomSynchronize( 13 )

	-- Secret Door
	local secretPointIds = GetIdsByType({ Name = "SecretPoint" })
	if not IsEmpty( secretPointIds ) and IsSecretDoorEligible( currentRun, currentRoom ) then
		currentRoom.ForceSecretDoor = true
		local forcedSecretDoor = HasHeroTraitValue("ForceSecretDoor")
		UseHeroTraitsWithValue( "ForceSecretDoor", true)
		local secretRoomData = ChooseNextRoomData( currentRun, { ForceNextRoomSet = "Chaos" } )
		if secretRoomData ~= nil then
			local secretPointId = RemoveRandomValue( secretPointIds )
			local secretDoor = DeepCopyTable( ObstacleData.SecretDoor )
			secretDoor.ObjectId = SpawnObstacle({ Name = "SecretDoor", Group = "FX_Terrain", DestinationId = secretPointId, AttachedTable = secretDoor })
			SetupObstacle( secretDoor )
			secretDoor.HealthCost = GetSecretDoorCost()
			if forcedSecretDoor then
				secretDoor.HealthCost = 0	
			end
			local secretRoom = CreateRoom( secretRoomData )
			AssignRoomToExitDoor( secretDoor, secretRoom )
			--AddToGroup({ Id = secretDoor.ObjectId, Name = "ExitDoors" })
		end
	end
	if not IsEmpty( secretPointIds ) and IsShrinePointDoorEligible( currentRun, currentRoom ) then
		currentRoom.ForceShrinePointDoor = true
		local shrinePointRoomOptions = currentRoom.ShrinePointRoomOptions or RoomSetData.Base.BaseRoom.ShrinePointRoomOptions
		local shrinePointRoomName = GetRandomValue(shrinePointRoomOptions)
		local shrinePointRoomData = RoomSetData.Base[shrinePointRoomName]
		if shrinePointRoomData ~= nil then
			local secretPointId = RemoveRandomValue( secretPointIds )
			local shrinePointDoor = DeepCopyTable( ObstacleData.ShrinePointDoor )
			shrinePointDoor.ObjectId = SpawnObstacle({ Name = "ShrinePointDoor", Group = "FX_Terrain", DestinationId = secretPointId, AttachedTable = shrinePointDoor })
			SetupObstacle( shrinePointDoor )
			shrinePointDoor.ShrinePointReq = currentRoom.ShrinePointDoorCost or ( shrinePointDoor.CostBase + ( shrinePointDoor.CostPerDepth * (currentRun.RunDepthCache - 1) ) )
			local activeShrinePoints = GetTotalSpentShrinePoints()
			local costFontColor = Color.CostAffordable
			if shrinePointDoor.ShrinePointReq > activeShrinePoints then
				costFontColor = Color.CostUnaffordable
			end
			local shrinePointRoom = CreateRoom( shrinePointRoomData, { SkipChooseReward = true } )
			shrinePointRoom.NeedsReward = true
			AssignRoomToExitDoor( shrinePointDoor, shrinePointRoom )
			currentRun.LastShrinePointDoorDepth = GetRunDepth( currentRun )
		end
	end

	local challengeBaseIds = GetIdsByType({ Name = "ChallengeSwitchBase" })

	-- Challenge Switch
	if not IsEmpty( challengeBaseIds ) and IsChallengeSwitchEligible( currentRun, TableLength( challengeBaseIds ), currentRoom.TimeChallengeChanceSuccess) then
		local hasForceTrait = HasHeroTraitValue("ForceChallengeSwitch")
		currentRoom.ForceChallengeSwitch = true
		UseHeroTraitsWithValue("ForceChallengeSwitch", true)
		local challengeBaseId = RemoveRandomValue( challengeBaseIds )
		local challengeOptions = {}
		for k, challengeName in pairs( EncounterSets.TimeChallengeOptions ) do
			local challengeData = ObstacleData[challengeName]
			if challengeData.Requirements == nil or IsGameStateEligible( CurrentRun, challengeData, challengeData.Requirements ) then
				table.insert( challengeOptions, challengeName )
			end
		end
		if not IsEmpty( challengeOptions ) then
			local challengeType = GetRandomValue( challengeOptions )
			local challengeSwitch = DeepCopyTable( ObstacleData[challengeType] )
			currentRoom.ChallengeSwitch = challengeSwitch
			challengeSwitch.ObjectId = challengeBaseId
			local offsetX = challengeSwitch.TextAnchorIdOffsetX
			if IsHorizontallyFlipped({ Id = challengeSwitch.ObjectId }) then
				offsetX = offsetX * -1
			end
			challengeSwitch.TextAnchorId = SpawnObstacle({ Name = "BlankObstacle", Group = "Standing", DestinationId = challengeBaseId })
			Attach({ Id = challengeSwitch.TextAnchorId, DestinationId = challengeBaseId, OffsetX = offsetX, OffsetY = challengeSwitch.TextAnchorIdOffsetY, OffsetZ = challengeSwitch.TextAnchorIdOffsetZ })
			SetThingProperty({ Property = "SortMode", Value = "FromParent", DestinationId = challengeSwitch.TextAnchorId })

			local challengeEncounter = ChooseChallengeEncounter(currentRoom, currentRoom.TimeChallengeEncounterOptions)
			currentRoom.ChallengeEncounter = challengeEncounter
			challengeEncounter.Switch = challengeSwitch
			challengeEncounter.SpawnNearId = challengeSwitch.ObjectId

			local rewardMultiplier = challengeSwitch.RewardMultiplier or 1
			local startingValue = rewardMultiplier * challengeEncounter.StartingValue * (1 + challengeEncounter.ValueDepthRamp * GetRunDepth(CurrentRun)) * GetTotalHeroTraitValue("ChallengeRewardIncrease", {IsMultiplier = true})
			challengeSwitch.StartingValue = round( startingValue )
			challengeSwitch.ValueTextAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = challengeSwitch.ObjectId })
			Attach({ Id = challengeSwitch.ValueTextAnchor, DestinationId = challengeSwitch.ObjectId })
			CreateTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", OffsetX = -40 , OffsetY = -220, LuaValue = startingValue, Font = challengeSwitch.OverheadTextFont, FontSize = 40, Color = Color.White, OutlineThickness = 1, OutlineColor = {0.0, 0.0, 0.0,1}, TextSymbolScale = challengeSwitch.OverheadTextSymbolScale, })
			ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, FadeTarget = 0, FadeDuration = 0 })

			if challengeSwitch.KeyCost == nil and challengeSwitch.KeyCostMin ~= nil and challengeSwitch.KeyCostMax ~= nil then
				challengeSwitch.KeyCost = RandomInt(challengeSwitch.KeyCostMin, challengeSwitch.KeyCostMax)
			end
			SetupObstacle( challengeSwitch )
			SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.LockedAnimationName })
			UseableOn({ Id = challengeSwitch.ObjectId })
			currentRun.LastChallengeDepth = currentRun.RunDepthCache
			challengeBaseId = nil
		end

	elseif not IsEmpty( challengeBaseIds ) and IsChallengeSwitchEligible( currentRun, TableLength( challengeBaseIds ), currentRoom.CapturePointChanceSuccess) then
	-- Capture Point Switch
		local hasForceTrait = HasHeroTraitValue("ForceCapturePointSwitch")
		currentRoom.ForceCapturePointSwitch = true
		UseHeroTraitsWithValue("ForceCapturePointSwitch", true)
		local challengeBaseId = RemoveRandomValue( challengeBaseIds )
		local challengeOptions = {}
		for k, challengeName in pairs( EncounterSets.CapturePointOptions ) do
			local challengeData = ObstacleData[challengeName]
			if challengeData.Requirements == nil or IsGameStateEligible( CurrentRun, challengeData, challengeData.Requirements ) then
				table.insert( challengeOptions, challengeName )
			end
		end
		if not IsEmpty( challengeOptions ) then
			local challengeType = GetRandomValue( challengeOptions )
			local challengeSwitch = DeepCopyTable( ObstacleData[challengeType] )
			currentRoom.ChallengeSwitch = challengeSwitch
			challengeSwitch.ObjectId = challengeBaseId

			if challengeSwitch.RewardTypeOptions ~= nil then
				challengeSwitch.RewardType = GetRandomValue(challengeSwitch.RewardTypeOptions)
			end

			local offsetX = challengeSwitch.TextAnchorIdOffsetX
			if IsHorizontallyFlipped({ Id = challengeSwitch.ObjectId }) then
				offsetX = offsetX * -1
			end
			challengeSwitch.TextAnchorId = SpawnObstacle({ Name = "BlankObstacle", Group = "Standing", DestinationId = challengeBaseId })
			Attach({ Id = challengeSwitch.TextAnchorId, DestinationId = challengeBaseId, OffsetX = offsetX, OffsetY = challengeSwitch.TextAnchorIdOffsetY, OffsetZ = challengeSwitch.TextAnchorIdOffsetZ })
			SetThingProperty({ Property = "SortMode", Value = "FromParent", DestinationId = challengeSwitch.TextAnchorId })

			local challengeEncounter = ChooseChallengeEncounter(currentRoom, currentRoom.CapturePointEncounterOptions)
			currentRoom.ChallengeEncounter = challengeEncounter
			challengeEncounter.Switch = challengeSwitch
			challengeEncounter.SpawnNearId = challengeSwitch.ObjectId

			local rewardMultiplier = challengeSwitch.RewardMultiplier or 1
			local startingValue = rewardMultiplier * challengeEncounter.StartingValue * (1 + GetTotalHeroTraitValue("ChallengeRewardIncrease", {IsMultiplier = true}))
			challengeSwitch.StartingValue = round( startingValue )
			challengeSwitch.ValueTextAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = challengeSwitch.ObjectId })
			Attach({ Id = challengeSwitch.ValueTextAnchor, DestinationId = challengeSwitch.ObjectId })
			CreateTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", OffsetX = -40 , OffsetY = -220, LuaValue = startingValue, Font = challengeSwitch.OverheadTextFont, FontSize = 40, Color = Color.White, OutlineThickness = 1, OutlineColor = {0.0, 0.0, 0.0,1}, TextSymbolScale = challengeSwitch.OverheadTextSymbolScale, })
			ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, FadeTarget = 0, FadeDuration = 0 })

			if challengeSwitch.KeyCost == nil and challengeSwitch.KeyCostMin ~= nil and challengeSwitch.KeyCostMax ~= nil then
				challengeSwitch.KeyCost = RandomInt(challengeSwitch.KeyCostMin, challengeSwitch.KeyCostMax)
			end
			SetupObstacle( challengeSwitch )
			SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.LockedAnimationName })
			SetColor({ Id = challengeSwitch.ObjectId, Color = { 1.0, 1.0, 0.0, 1.0 } })
			UseableOn({ Id = challengeSwitch.ObjectId })
			currentRun.LastChallengeDepth = currentRun.RunDepthCache
			challengeBaseId = nil
		end

	elseif not IsEmpty( challengeBaseIds ) and IsChallengeSwitchEligible( currentRun, TableLength( challengeBaseIds ), currentRoom.PerfectClearChanceSuccess) then
		-- Perfect Clear Switch
		local hasForceTrait = HasHeroTraitValue("ForcePerfectClearSwitch")
		currentRoom.ForcePerfectClearSwitch = true
		UseHeroTraitsWithValue("ForcePerfectClearSwitch", true)
		local challengeBaseId = RemoveRandomValue( challengeBaseIds )
		local challengeOptions = {}
		for k, challengeName in pairs( EncounterSets.PerfectClearOptions ) do
			local challengeData = ObstacleData[challengeName]
			if challengeData.Requirements == nil or IsGameStateEligible( CurrentRun, challengeData, challengeData.Requirements ) then
				table.insert( challengeOptions, challengeName )
			end
		end
		if not IsEmpty( challengeOptions ) then
			local challengeType = GetRandomValue( challengeOptions )
			local challengeSwitch = DeepCopyTable( ObstacleData[challengeType] )
			currentRoom.ChallengeSwitch = challengeSwitch
			challengeSwitch.ObjectId = challengeBaseId
			local offsetX = challengeSwitch.TextAnchorIdOffsetX
			if IsHorizontallyFlipped({ Id = challengeSwitch.ObjectId }) then
				offsetX = offsetX * -1
			end
			challengeSwitch.TextAnchorId = SpawnObstacle({ Name = "BlankObstacle", Group = "Standing", DestinationId = challengeBaseId })
			Attach({ Id = challengeSwitch.TextAnchorId, DestinationId = challengeBaseId, OffsetX = offsetX, OffsetY = challengeSwitch.TextAnchorIdOffsetY, OffsetZ = challengeSwitch.TextAnchorIdOffsetZ })
			SetThingProperty({ Property = "SortMode", Value = "FromParent", DestinationId = challengeSwitch.TextAnchorId })

			local challengeEncounter = ChooseChallengeEncounter(currentRoom, currentRoom.PerfectClearEncounterOptions)
			currentRoom.ChallengeEncounter = challengeEncounter
			challengeEncounter.Switch = challengeSwitch
			challengeEncounter.SpawnNearId = challengeSwitch.ObjectId

			local rewardMultiplier = challengeSwitch.RewardMultiplier or 1
			local startingValue = rewardMultiplier * challengeEncounter.StartingValue * (1 + GetTotalHeroTraitValue("ChallengeRewardIncrease", {IsMultiplier = true}))
			challengeSwitch.StartingValue = round( startingValue )
			challengeSwitch.ValueTextAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = challengeSwitch.ObjectId })
			Attach({ Id = challengeSwitch.ValueTextAnchor, DestinationId = challengeSwitch.ObjectId })
			CreateTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", OffsetX = -40 , OffsetY = -220, LuaValue = startingValue, Font = challengeSwitch.OverheadTextFont, FontSize = 40, Color = Color.White, OutlineThickness = 1, OutlineColor = {0.0, 0.0, 0.0,1}, TextSymbolScale = challengeSwitch.OverheadTextSymbolScale, })
			ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, FadeTarget = 0, FadeDuration = 0 })

			if challengeSwitch.KeyCost == nil and challengeSwitch.KeyCostMin ~= nil and challengeSwitch.KeyCostMax ~= nil then
				challengeSwitch.KeyCost = RandomInt(challengeSwitch.KeyCostMin, challengeSwitch.KeyCostMax)
			end
			SetupObstacle( challengeSwitch )
			SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.LockedAnimationName })
			SetColor({ Id = challengeSwitch.ObjectId, Color = { 1.0, 0.0, 1.0, 1.0 } })
			UseableOn({ Id = challengeSwitch.ObjectId })
			currentRun.LastChallengeDepth = currentRun.RunDepthCache
			challengeBaseId = nil
		end
	end

	-- Well Shop
	if not IsEmpty( challengeBaseIds ) and IsWellShopEligible( currentRun, currentRoom ) then
		currentRoom.ForceWellShop = true
		local challengeBaseId = RemoveRandomValue( challengeBaseIds )
		currentRoom.WellShop = DeepCopyTable( ObstacleData.WellShop )
		currentRoom.WellShop.ObjectId = challengeBaseId
		SetupObstacle( currentRoom.WellShop )
		SetAnimation({ DestinationId = currentRoom.WellShop.ObjectId, Name = "WellShopLocked" })
		UseableOn({ Id = currentRoom.WellShop.ObjectId })
		currentRun.LastWellShopDepth = currentRun.RunDepthCache
		challengeBaseId = nil
	end

	-- Surface Shop
	if not IsEmpty( challengeBaseIds ) and IsSurfaceShopEligible( currentRun, currentRoom ) then
		currentRoom.ForceSurfaceShop = true
		local challengeBaseId = RemoveRandomValue( challengeBaseIds )
		currentRoom.SurfaceShop = DeepCopyTable( ObstacleData.SurfaceShop )
		currentRoom.SurfaceShop.ObjectId = challengeBaseId
		SetupObstacle( currentRoom.SurfaceShop )
		SetAnimation({ DestinationId = currentRoom.SurfaceShop.ObjectId, Name = "SurfaceShopLocked" })
		UseableOn({ Id = currentRoom.SurfaceShop.ObjectId })
		challengeBaseId = nil
	end

	-- HarvestPoints
	local harvestPoints = GetInactiveIdsByType({ Name = "HarvestPoint" })
	if (currentRoom.HarvestPointsAllowed or 0) > 0 then
		currentRoom.HarvestPointIds = currentRoom.HarvestPointIds or {}
		UseHeroTraitsWithValue( "ForceHarvestPoint", true )
		for i = 1, currentRoom.HarvestPointsAllowed do
			if IsEmpty( harvestPoints ) then
				break
			end
			local weightedList = {}
			for k, option in pairs( HarvestData.WeightedOptions ) do
				if IsGameStateEligible( CurrentRun, option, option.GameStateRequirements ) then
					weightedList[k] = option.Weight
				end
			end

			if not IsEmpty( weightedList ) then
				local harvestPoint = DeepCopyTable( ObstacleData.HarvestPoint )

				local existingHarvestPoint = RemoveRandomValue( currentRoom.HarvestPointIds ) or {}
				harvestPoint.ObjectId = existingHarvestPoint.Id or RemoveRandomValue( harvestPoints )
				local choiceKey = existingHarvestPoint.ChoiceKey or GetRandomValueFromWeightedList( weightedList )
				table.insert( currentRoom.HarvestPointIds, { Id = harvestPoint.ObjectId, ChoiceKey = choiceKey } )

				local chosenHarvestData = HarvestData.WeightedOptions[choiceKey]
				Activate({ Id = harvestPoint.ObjectId, TriggerOnSpawn = false })
				if chosenHarvestData.ConsumableName ~= nil then
					local consumableId = SpawnObstacle({ Name = chosenHarvestData.ConsumableName, DestinationId = harvestPoint.ObjectId, Group = "Standing"})
					local consumable = CreateConsumableItem( consumableId, chosenHarvestData.ConsumableName, 0 )
					Destroy({ Id = harvestPoint.ObjectId })
				else
					OverwriteTableKeys( harvestPoint, chosenHarvestData )
					SetupObstacle( harvestPoint )
					ChangeDrawGroup( harvestPoint.ObjectId, harvestPoint.DrawGroup or "Standing" )
				end
				currentRoom.NumHarvestPoints = (currentRoom.NumHarvestPoints or 0) + 1
				currentRoom.UseableHarvestPoint = true
			end
		end
	end
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		DebugSetupHarvestPointAnims()
	end

	-- ShovelPoints
	local shovelPoints = GetInactiveIdsByType({ Name = "ShovelPoint" })
	if not IsEmpty( shovelPoints ) and currentRoom.ShovelPointSuccess then
		CurrentRun.ResourceNodesSeen.ToolShovel = (CurrentRun.ResourceNodesSeen.ToolShovel or 0) + 1
		UseHeroTraitsWithValue( "ForceShovelPoint", true )
		local shovelPoint = DeepCopyTable( ObstacleData.ShovelPoint )
		shovelPoint.ObjectId = currentRoom.ShovelPointId or RemoveRandomValue( shovelPoints )
		currentRoom.ShovelPointId = shovelPoint.ObjectId
		Activate({ Id = shovelPoint.ObjectId, TriggerOnSpawn = false })
		SetupObstacle( shovelPoint )
		currentRoom.NumShovelPoints = (currentRoom.NumShovelPoints or 0) + 1
		if HasAccessToTool("ToolShovel") then
			currentRoom.UseableShovelPoint = true
		else
			UseableOff({ Id = shovelPoint.ObjectId })
			shovelPoint.ExitsUnlockedFunctionName = nil
			SetAnimation({ DestinationId = shovelPoint.ObjectId, Name = shovelPoint.UnavailableAnimation })
		end
	end

	-- PickaxePoints
	local pickaxePoints = GetInactiveIdsByType({ Name = "PickaxePoint" })
	if not IsEmpty( pickaxePoints ) and currentRoom.PickaxePointSuccess and not CurrentRun.CurrentRoom.ExorcismPointUsed then
		CurrentRun.ResourceNodesSeen.ToolPickaxe = (CurrentRun.ResourceNodesSeen.ToolPickaxe or 0) + 1
		UseHeroTraitsWithValue( "ForcePickaxePoint", true )
		currentRoom.ChosenPickaxePointData = currentRoom.ChosenPickaxePointData or GetRandomEligibleValueFromWeightedList( PickaxePointData.WeightedOptions )
		if currentRoom.ChosenPickaxePointData == nil then
			DebugAssert({ Condition = false, Text = "No valid PickaxePointData" })
		end
		local chosenOption = DeepCopyTable( currentRoom.ChosenPickaxePointData )
		local pickaxePoint = DeepCopyTable( ObstacleData.PickaxePoint )
		OverwriteTableKeys( pickaxePoint, chosenOption )
		if GameState.WeaponsUnlocked.ToolPickaxe2 then
			pickaxePoint.MaxHealth = pickaxePoint.MaxHealth + WeaponShopItemData.ToolPickaxe2.MaxHealthBonus
		end
		pickaxePoint.ObjectId = currentRoom.PickaxePointId or RemoveRandomValue( pickaxePoints )
		currentRoom.PickaxePointId = pickaxePoint.ObjectId
		Activate({ Id = pickaxePoint.ObjectId, TriggerOnSpawn = false })
		SetupObstacle( pickaxePoint )
		currentRoom.NumPickaxePoints = (currentRoom.NumPickaxePoints or 0) + 1
		if HasAccessToTool("ToolPickaxe") then
			currentRoom.UseablePickaxePoint = true
		else
			--UseableOff({ Id = pickaxePoint.ObjectId })
			pickaxePoint.ExitsUnlockedFunctionName = nil
			pickaxePoint.UseText = pickaxePoint.NoToolUseText
			if pickaxePoint.UnavailableAnimation ~= nil then
				SetAnimation({ DestinationId = pickaxePoint.ObjectId, Name = pickaxePoint.UnavailableAnimation })
			end
		end
	end

	-- ExorcismPoints
	local exorcismPoints = GetInactiveIdsByType({ Name = "ExorcismPoint" })
	if not IsEmpty( exorcismPoints ) and CurrentRun.CurrentRoom.ExorcismPointSuccess and not CurrentRun.CurrentRoom.ExorcismPointUsed then
		CurrentRun.ResourceNodesSeen.ToolExorcismBook = (CurrentRun.ResourceNodesSeen.ToolExorcismBook or 0) + 1
		UseHeroTraitsWithValue( "ForceExorcismPoint", true )
		currentRoom.ChosenExorcismPointData = currentRoom.ChosenExorcismPointData or GetRandomEligibleValueFromWeightedList( ExorcismData.WeightedOptions )
		if currentRoom.ChosenExorcismPointData == nil then
			DebugAssert({ Condition = false, Text = "No valid ExorcismData" })
		end
		local exorcismPoint = DeepCopyTable( ObstacleData.ExorcismPoint )
		OverwriteTableKeys( exorcismPoint, currentRoom.ChosenExorcismPointData )
		exorcismPoint.ObjectId = currentRoom.ExorcismPointId or RemoveRandomValue( exorcismPoints )
		currentRoom.ExorcismPointId = exorcismPoint.ObjectId
		Activate({ Id = exorcismPoint.ObjectId, TriggerOnSpawn = false })
		SetupObstacle( exorcismPoint )
		RestoreMapStateObject( CurrentRun.CurrentRoom.Name, exorcismPoint )
		currentRoom.NumExorcismPoints = (currentRoom.NumExorcismPoints or 0) + 1
		if HasAccessToTool( "ToolExorcismBook" ) then
			currentRoom.UseableExorcismPoint = true	
			ExorcismGenerateMoveSequence( exorcismPoint )
			ExorcismPointChosenPresentation( exorcismPoint )
		else
			--UseableOff({ Id = exorcismPoint.ObjectId })
			exorcismPoint.ExitsUnlockedFunctionName = nil
			exorcismPoint.UseText = exorcismPoint.NoToolUseText
			SetAnimation({ DestinationId = exorcismPoint.ObjectId, Name = exorcismPoint.UnavailableAnimation })
		end
	end

	-- FishingPoints
	local fishingPointIds = GetInactiveIdsByType({ Name = "FishingPoint" })
	if not IsEmpty( fishingPointIds ) and currentRoom.FishingPointSuccess and not CurrentRun.CurrentRoom.FishingPointUsed then
		CurrentRun.ResourceNodesSeen.ToolFishingRod = (CurrentRun.ResourceNodesSeen.ToolFishingRod or 0) + 1
		UseHeroTraitsWithValue( "ForceFishingPoint", true )
		CurrentRun.CurrentRoom.FishingPointId = CurrentRun.CurrentRoom.FishingPointId or GetRandomValue( fishingPointIds )
		local fishingPoint = DeepCopyTable( ObstacleData.FishingPoint )
		fishingPoint.ObjectId = CurrentRun.CurrentRoom.FishingPointId
		Activate({ Id = fishingPoint.ObjectId, TriggerOnSpawn = false })
		SetupObstacle( fishingPoint )
		currentRoom.NumFishingPoints = (currentRoom.NumFishingPoints or 0) + 1
		if HasAccessToTool("ToolFishingRod") then
			currentRoom.UseableFishingPoint = true
		else
			--UseableOff({ Id = CurrentRun.CurrentRoom.FishingPointId })
			fishingPoint.ExitsUnlockedFunctionName = nil
			fishingPoint.UseText = fishingPoint.NoToolUseText
		end
	end

	-- Anomaly
	if currentRoom.AnomalyDoorChanceSuccess and IsGameStateEligible( currentRun, currentRoom, currentRoom.AnomalyDoorRequirements or RoomData.BaseRoom.AnomalyDoorRequirements ) then
		currentRoom.DoAnomalies = true
	end
end

function HasAccessToTool( toolName )
	if GameState.WeaponsUnlocked[toolName] then
		return true
	end
	if HasFamiliarTool( toolName ) then
		return true
	end
	return false
end

function OnlyFamiliarHasAccessToTool( toolName )
	if GameState.WeaponsUnlocked[toolName] then
		return false
	end
	if HasFamiliarTool( toolName ) then
		return true
	end
	return false
end

function HasFamiliarTool( toolName )
	if GameState.EquippedFamiliar and FamiliarData[GameState.EquippedFamiliar].LinkedTool == toolName then
		return true
	end
	return false
end

function IsSecretDoorEligible( currentRun, currentRoom )

	if currentRoom.ForceSecretDoor then
		return true
	end

	if HasHeroTraitValue( "ForceSecretDoor" ) and IsGameStateEligible( currentRun, currentRoom, NamedRequirementsData.ForceSecretDoorRequirements) then
		return true
	end

	if not currentRoom.SecretChanceSuccess then
		return false
	end

	local requirements = currentRoom.SecretDoorRequirements or RoomData.BaseRoom.SecretDoorRequirements
	if requirements ~= nil and not IsGameStateEligible( currentRun, currentRoom, requirements ) then
		return false
	end

	return true

end

function IsShrinePointDoorEligible( currentRun, currentRoom )

	if currentRoom.ForceShrinePointDoor then
		return true
	end

	if HasHeroTraitValue( "ForceShrinePointDoor" ) then
		return true
	end

	if not currentRoom.ShrinePointDoorChanceSuccess then
		return false
	end

	local requirements = currentRoom.ShrinePointDoorRequirements or RoomData.BaseRoom.ShrinePointDoorRequirements
	if not IsGameStateEligible( currentRun, requirements ) then
		return false
	end

	return true

end

function IsChallengeSwitchEligible( currentRun, numPedestals, chanceSuccess )

	local currentRoom = currentRun.CurrentRoom
	if numPedestals ~= nil then

		local reservedPedestals = 0
		if currentRoom.ForceWellShop then
			reservedPedestals = reservedPedestals + 1
		end

		if numPedestals <= reservedPedestals then
			return false
		end
	end

	if currentRoom.ForceChallengeSwitch then
		return true
	end

	if HasHeroTraitValue("ForceChallengeSwitch") then
		return true
	end

	if not chanceSuccess then
		return false
	end

	local requirements = currentRoom.TimeChallengeSwitchRequirements or RoomData.BaseRoom.TimeChallengeSwitchRequirements
	if not IsGameStateEligible( currentRun, requirements ) then
		return false
	end

	return true

end

function IsWellShopEligible( currentRun, currentRoom )
	if currentRoom.ForceWellShop then
		return true
	end
	local requirements = currentRoom.WellShopRequirements or RoomData.BaseRoom.WellShopRequirements
	if not IsGameStateEligible( currentRun, requirements ) then
		return false
	end
	if not currentRoom.WellShopChanceSuccess then
		return false
	end
	return true

end

function IsSurfaceShopEligible( currentRun, currentRoom )
	if currentRoom.ForceSurfaceShop then
		return true
	end
	local requirements = currentRoom.SurfaceShopRequirements or RoomData.BaseRoom.SurfaceShopRequirements
	if not IsGameStateEligible( currentRun, currentRoom, requirements ) then
		return false
	end
	if not currentRoom.SurfaceShopChanceSuccess then
		return false
	end
	return true

end

function CreateVignette()
	if not GetConfigOptionValue({ Name = "DrawBloom" }) then
		return
	end
	ScreenAnchors.Vignette = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Vignette", ScaleX = ScreenScaleX, ScaleY = ScreenScaleY, })
	SetAnimation({ Name = "VignetteOverlay", DestinationId = ScreenAnchors.Vignette })
end

function DestroyRequiredKills( args )
	args = args or {}
	local currentEnemies = ShallowCopyTable( RequiredKillEnemies )
	for k, enemy in pairs( currentEnemies ) do
		if args.SkipIds ~= nil and Contains( args.SkipIds, enemy.ObjectId ) then
			-- Skip
		else
			if args.BlockLoot then
				enemy.MoneyDropOnDeath = nil
				enemy.MetaPointDropOnDeath = nil
			end
			thread( Kill, enemy, { BlockRespawns = true } )
			wait( destroyInterval, RoomThreadName )
		end
	end

	if args.DestroyInterval ~= nil then
		DestroyRequiredKills( blockLoot ) -- Call again w/ no interval in case something spawned while waiting (from spawners)
	end
end

function DisableTrap( enemy )
	if enemy.ToggleTrap then
		if enemy.DisableImmediately then
			killTaggedThreads(enemy.AIThreadName)
			enemy.AIDisabled = true
		else
			enemy.DisableAIWhenReady = true
		end
		if enemy.DefaultAIData and enemy.DefaultAIData.DisabledAnimation ~= nil then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DefaultAIData.DisabledAnimation })
		end
	elseif enemy.DestroyOnTrapDisable then
		Kill( enemy )
	end
end

function EnableTrap( enemy )
	if enemy.ToggleTrap and enemy.AIDisabled then
		enemy.AIDisabled = false
		if enemy.AIOptions ~= nil and not IsEmpty(enemy.AIOptions) then
			thread(SetAI, GetRandomValue(enemy.AIOptions), enemy, CurrentRun)
		end
	elseif enemy.DisableAIWhenReady then
		local idleAnim = enemy.IdleAnimation or enemy.DefaultAIData.IdleAnimation
		if idleAnim ~= nil then
			SetAnimation({ Name = idleAnim, DestinationId = enemy.ObjectId })
		end
		enemy.DisableAIWhenReady = false
	end
end

function DisableRoomTraps()
	CurrentRun.CurrentRoom.BlockDisableTraps = true
	for enemyId, enemy in pairs( ActiveEnemies ) do
		DisableTrap( enemy )
	end
	ExpireProjectiles({ Name = "SmokeTrapWeapon" })
end
function EnableRoomTraps( )
	CurrentRun.CurrentRoom.BlockDisableTraps = false
	for enemyId, enemy in pairs( ActiveEnemies ) do
		EnableTrap(enemy)
	end
end

function PickRoomEliteTypeUpgrades( room )
	local roomEliteTypes = {}
	for k, wave in pairs(room.Encounter.SpawnWaves) do
		for index, spawnData in ipairs( wave.Spawns ) do
			if EnemyData[spawnData.Name].IsElite then
				table.insert(roomEliteTypes, spawnData.Name)
			end
		end
	end
	local eliteTypeUpgradeCount = room.EliteTypeUpgradeCount or 1
	for i = 1, eliteTypeUpgradeCount do
		local eliteType = RemoveRandomValue(roomEliteTypes)
		if eliteType ~= nil then
			PickEliteAttributes( room, EnemyData[eliteType] )
			RemoveAllValues(roomEliteTypes, eliteType)
		end
	end
end

function ShadeMercManager( room, args )

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end
	
	room.ShadeMercInactiveIds = GetInactiveIdsByType({ Names = args.ObjectNames })
	room.ShadeMercActiveIds = {}

	wait (0.2)

	local activeCount = args.MaxActive
	local startingCount = args.StartingCount or 0
	if args.StartingCountMin ~= nil and args.StartingCountMax ~= nil then
		startingCount = RandomInt( args.StartingCountMin, args.StartingCountMax )
	end
	startingCount = startingCount + GetTotalHeroTraitValue("ShadeMercCountBonus")
	activeCount = activeCount + GetTotalHeroTraitValue("ShadeMercCountBonus")
	for i=1,startingCount do
		if TableLength(room.ShadeMercActiveIds) < activeCount and not IsEmpty(room.ShadeMercInactiveIds) then
			local nextShadeId = RemoveRandomValue(room.ShadeMercInactiveIds)
			Activate({ Id = nextShadeId })
			local name = GetName({ Id = nextShadeId })
			local nextShade = DeepCopyTable( EnemyData[name] )
			nextShade.ObjectId = nextShadeId
			if args.RestoreObjectState then
				RestoreMapStateObject( room.Name, nextShade )
			end
			SetupUnit( nextShade, CurrentRun )
			table.insert( room.ShadeMercActiveIds, nextShadeId )
			if args.RequireForExit then
				MapState.RoomRequiredObjects[nextShadeId] = ActiveEnemies[nextShadeId]
			end
		end
	end

	if args.RespawnInterval == nil then
		return
	end

	while room.Encounter ~= nil and not room.Encounter.Completed do

		wait( args.RespawnInterval, RoomThreadName )

		local respawnCount = 1
		if args.ObjectsPerIntervalMin ~= nil and args.ObjectsPerIntervalMax ~= nil then
			respawnCount = RandomFloat( args.ObjectsPerIntervalMin, args.ObjectsPerIntervalMax )
		end

		for i=1,respawnCount do
			if TableLength(room.ShadeMercActiveIds) < activeCount then
				local nextShadeId = RemoveRandomValue(room.ShadeMercInactiveIds)
				thread(SetAI, "ShadeMercAI", ActiveEnemies[nextShadeId])
				table.insert(room.ShadeMercActiveIds, nextShadeId)
			else
				waitUntil( "ShadeMercDeath" )
			end
		end

	end
end

function PolyphemusBoulderManager( room, args )

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end

	local spawnIds = GetIds({ Name = "BoulderSpawnPoints" })
	local totalCount = RandomInt(args.TotalCountMin, args.TotalCountMax)
	local startingCount = RandomInt(args.StartingCountMin, args.StartingCountMax)

	for i = 1, startingCount, 1 do
		totalCount = totalCount - 1
		if totalCount < 0 or #spawnIds == 0 then
			return
		end
		
		local boulder = DeepCopyTable(ObstacleData.PolyphemusBoulder)
		boulder.ObjectId = SpawnObstacle({ Name = "PolyphemusBoulder", DestinationId = RemoveRandomValue(spawnIds), Group = "Standing" })
		SetupObstacle(boulder)
		if RandomChance(0.5) then
			FlipHorizontal({ Id = boulder.ObjectId })
		end
	end
	
	waitUntil("RequiredKillEnemyKilledOrSpawned")

	for i = 1, totalCount, 1 do
		if IsEmpty(spawnIds) then
			break
		end

		local interval = RandomFloat(args.IntervalMin, args.IntervalMax)
		wait( interval, RoomThreadName )

		if room.Encounter ~= nil and not room.Encounter.InProgress then
			return
		end
		
		local targetId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = spawnIds, Distance = 9999 })
		RemoveValue(spawnIds, targetId)

		if targetId == nil or targetId == 0 then
			return
		end

		if args.Fuse ~= nil and args.Fuse > 0 then
			LoadVoiceBanks({ Name = "Polyphemus" })
			local damageRadius = GetBaseDataValue({ Type = "Projectile", Name = args.ProjectileName, Property = "DamageRadius" })
			CreateAnimation({ Name = args.ReticleAnimation, DestinationId = targetId, ScaleRadius = damageRadius })
			thread( PolyphemusBoulderIncomingPresentation )
			wait( args.Fuse, "PolyphemusBoulderManager" )
		end

		if room.Encounter ~= nil and not room.Encounter.InProgress then
			StopAnimation({ Name = args.ReticleAnimation, DestinationId = targetId })
			StopAnimation({ Name = "PolyphemusBoulderWarningDecalFill", DestinationId = targetId })
			StopAnimation({ Name = "PolyphemusBoulderWarningDecalFill2", DestinationId = targetId })
			StopAnimation({ Name = "PolyphemusBoulderWarningDecalDarkHold", DestinationId = targetId })
			return
		end
		CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, FireFromTarget = true })
		StopAnimation({ Name = args.ReticleAnimation, DestinationId = targetId })
	end

end

function SpawnSoulPylon( room, args )

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end
	
	args = args or {}
	local spawnName = args.SpawnName or "SoulPylon"

	local pylonId = SpawnUnit({ Name = spawnName, Group = "Standing", DestinationId = GetRandomValue(GetIds({ Name = "SoulPylonSpawnPoints"}) or GetIds({Name = "SpawnPoints"})) })
	local pylon = DeepCopyTable( EnemyData[spawnName] )
	pylon.ObjectId = pylonId
	thread(SetupUnit, pylon, CurrentRun)
end

function RespawningCoverManager( room, args )

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end
	wait(0.05)
	
	room.RespawningCoverInactiveIds = GetIdsByType({ Names = args.CoverObjectNames })
	room.RespawningCoverActiveIds = {}

	local startingCount = args.StartingCount or 0
	if args.StartingCountMin ~= nil and args.StartingCountMax ~= nil then
		startingCount = RandomInt( args.StartingCountMin, args.StartingCountMax )
	end
	startingCount = math.max(startingCount, #room.RespawningCoverInactiveIds)

	for i=1, startingCount do
		if TableLength(room.RespawningCoverActiveIds) < args.MaxActive and not IsEmpty(room.RespawningCoverInactiveIds) then
			table.insert(room.RespawningCoverActiveIds, RemoveRandomValue(room.RespawningCoverInactiveIds))
		end
	end

	for k, objectId in pairs(room.RespawningCoverInactiveIds) do
		local obstacle = MapState.ActiveObstacles[objectId]
		if obstacle ~= nil then
			local obstacleData = ObstacleData[obstacle.Name]
			SetAnimation({ DestinationId = objectId, Name = "Blank" })
			ApplyUnitPropertyChanges( obstacle, obstacleData.ImpactReaction.PropertyChanges, true )
		end
	end

	--while room.Encounter ~= nil and not room.Encounter.Completed do
	while true do

		wait( args.RespawnInterval, RoomThreadName )

		local respawnCount = 1
		if args.ObjectsPerIntervalMin ~= nil and args.ObjectsPerIntervalMax ~= nil then
			respawnCount = RandomFloat( args.ObjectsPerIntervalMin, args.ObjectsPerIntervalMax )
		end

		for i=1,respawnCount do
			if TableLength(room.RespawningCoverActiveIds) < args.MaxActive then
				local nextObjectId = RemoveRandomValue(room.RespawningCoverInactiveIds)
				RespawnCover(nextObjectId, room)
			else
				waitUntil( "RespawningCoverDeath" )
			end
		end

	end
end

function RespawnCover(objectId, room)
	local obstacle = MapState.ActiveObstacles[objectId]
	if obstacle ~= nil then
		SetAnimation({ DestinationId = objectId, Name = obstacle.RespawnAnimation })
		ApplyUnitPropertyChanges( obstacle, obstacle.RespawnReaction.PropertyChanges, true )
		table.insert(room.RespawningCoverActiveIds, obstacle.ObjectId)
	end
end

function RespawningCoverDeath( object )
	if CurrentRun.CurrentRoom.RespawningCoverInactiveIds == nil or CurrentRun.CurrentRoom.RespawningCoverActiveIds == nil then
		return
	end
	
	table.insert(CurrentRun.CurrentRoom.RespawningCoverInactiveIds, object.ObjectId)
	RemoveValue(CurrentRun.CurrentRoom.RespawningCoverActiveIds, object.ObjectId)
	notifyExistingWaiters("RespawningCoverDeath")
end

function SetMapFlag(args)
	MapState.Flags[args.FlagName] = MapState.Flags[args.FlagName] or {}
	table.insert( MapState.Flags[args.FlagName], args.Id )
	if args.Duration ~= nil then
		wait(args.Duration, args.ThreadName)
		RemoveValue(MapState.Flags[args.FlagName], args.Id )
	end

	if IsEmpty(MapState.Flags[args.FlagName]) then
		notifyExistingWaiters(args.FlagName.."End")
	end
end

function ChooseAvailableN_HubDoors( room, args )

	if room.DoorsChosen then
		return
	end
	local roomData = RoomData[room.Name] or room

	local count = args.Count or 1
	if args.CountMin ~= nil and args.CountMax ~= nil then
		count = RandomInt(args.CountMin, args.CountMax)
	end

	local doorIds = GetAllKeys( roomData.PredeterminedDoorRooms )

	for doorId, roomName in pairs( roomData.PredeterminedDoorRooms ) do
		if not IsGameStateEligible( CurrentRun, RoomData[roomName], RoomData[roomName].GameStateRequirements ) then
			doorIds[doorId] = nil
			room.UnavailableDoors[doorId] = true
		end
	end

	-- Remove all doors which dont have a room assigned yet
	local allDoors = GetIdsByType({ Names = args.Types })
	for k, doorId in pairs(allDoors) do
		if not Contains(doorIds, doorId) then
			room.UnavailableDoors[doorId] = true
		end
	end

	for i = 1, count do
		RemoveRandomValue(doorIds)
	end
	for k, doorId in pairs(doorIds) do
		room.UnavailableDoors[doorId] = true
	end
	room.DoorsChosen = true
end

function UpdateHubRewardLookup()
	CurrentRun.HubRewardLookup = CurrentRun.HubRewardLookup or {}
	
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.OfferedRewards then
		for _, rewardData in pairs( CurrentRun.CurrentRoom.OfferedRewards ) do
			CurrentRun.HubRewardLookup [rewardData.Type] = true
		end
	end
end

function LockEphyraExits(room, args)
	for doorId, door in pairs(MapState.OfferedExitDoors) do
		if door.LockWhenEphyraBossExitReady then
			if door.ClosedForRunAnimation ~= nil then
				SetAnimation({ Name = door.ClosedForRunAnimation, DestinationId = doorId })
			end
			MapState.OfferedExitDoors[doorId] = nil
		end
	end
end

function HandlePylonObjective(room, args)

	args = args or {}

	if not IsGameStateEligible( CurrentRun, NamedRequirementsData.PylonObjectiveRevealed ) then
		return
	end

	wait( args.Delay, RoomThreadName )

	wait(1.3)

	CheckObjectiveSet("BiomeNBossUnlock")
	local objectiveText = 0
	local numPylons = CurrentRun.SpawnRecord.SoulPylon or 0

	numPylons = numPylons - #GetIdsByType({ Name ="SoulPylon" })

	UpdateObjectiveDescription( "BiomeNPylons", "Objective_BiomeNPylons", "Pylons", 6 - numPylons )

	wait(1.3)

	if numPylons >= 6 then
		MarkObjectiveComplete("BiomeNPylons")
	end

end

function SpawnRewardCages( room, args )
	local rewardSpawnPoints = GetIdsByType({ Name = "LootPoint" })
	if room.CageRewards ~= nil then
		for i = 1, #room.CageRewards do
			local spawnPointId = RemoveRandomValue(rewardSpawnPoints)
		
			local rewardCage = DeepCopyTable( ObstacleData.FieldsRewardCage )
			local obstacleName = "FieldsRewardCage"
			rewardCage.ObjectId = SpawnObstacle({ Name = obstacleName, DestinationId = spawnPointId, Group = "Standing" })
			rewardCage.SpawnPointId = spawnPointId
			
			SetupObstacle( rewardCage )
		
			local cageReward = RemoveRandomValue( room.CageRewards )
			rewardCage.Encounter = cageReward.Encounter
			local reward = SpawnRoomReward( room, { RewardOverride = cageReward.RewardType or ChooseRoomReward( CurrentRun, {}, room.RewardStoreName ), LootName = cageReward.ForceLootName, SpawnRewardOnId = spawnPointId } )
			rewardCage.RewardId = reward.ObjectId

			UseableOff({ Id = rewardCage.RewardId })
			--MapState.RoomRequiredObjects[rewardCage.RewardId] = nil
		end
	end

	-- bonus rewards
	local optionalRewardCount = 0
	local bonusRewardSpawnPoints = GetIds({ Name = "BonusRewardSpawnPoints" })

	if room.OptionalRewardChances ~= nil then
		for k, spawnChance in ipairs( room.OptionalRewardChances ) do
			if RandomChance( spawnChance ) then
				optionalRewardCount = optionalRewardCount + 1
			end
		end
	end
	if room.Encounter.BlockMaxBonusRewards and optionalRewardCount >= #bonusRewardSpawnPoints then
		optionalRewardCount = #bonusRewardSpawnPoints - 1
	end

	for i = 1, optionalRewardCount do
		local bonusRewardSpawnId = RemoveRandomValue( bonusRewardSpawnPoints )
		if bonusRewardSpawnId ~= nil then
			local rewardOverride = ChooseRoomReward( CurrentRun, {}, room.BonusRewardStoreName )
			local rewardSpawnData = { RewardOverride = rewardOverride, SpawnRewardOnId = bonusRewardSpawnId, NotRequiredPickup = true }
			local bonusReward = SpawnRoomReward( room, rewardSpawnData )
			MapState.OptionalRewards[bonusReward.ObjectId] = bonusReward
			if bonusReward ~= nil then
				room.Encounter.RewardsToRestore = room.Encounter.RewardsToRestore or {}
				room.Encounter.RewardsToRestore[bonusReward.ObjectId] = rewardSpawnData
			end
		end
	end

	-- cull some spawn points from unoccupued reward points
	if RoomData[room.Name].UnoccupiedRewardCullCount ~= nil then
		local passiveSpawnPoints = GetIdsByType({ Name = "EnemyPointSupport" })
		for k, rewardPointId in pairs(bonusRewardSpawnPoints) do
			local nearbyEnemyPoints = GetClosestIds({ Id = rewardPointId, DestinationIds = passiveSpawnPoints, Distance = 500 })
			for i = 1, RoomData[room.Name].UnoccupiedRewardCullCount do
				if not IsEmpty(nearbyEnemyPoints) then
					SessionMapState.SpawnPointsUsed[RemoveRandomValue(nearbyEnemyPoints)] = 1
				end
			end
		end
	end
end

function SpawnRewardCagesMiniboss( encounter, args )

	local spawnPointId = RemoveRandomValue(GetIdsByType({ Name = "LootPoint" }))

	local rewardCage = DeepCopyTable( ObstacleData.FieldsRewardCage )
	local obstacleName = "FieldsRewardCage"
	rewardCage.ObjectId = SpawnObstacle({ Name = obstacleName, DestinationId = spawnPointId, Group = "Standing" })
	rewardCage.SpawnPointId = spawnPointId
	
	SetupObstacle( rewardCage )

	rewardCage.RewardId = SpawnRoomReward( encounter, args ).ObjectId
	encounter.RewardCageId = rewardCage.ObjectId
	encounter.RewardId = rewardCage.RewardId

	UseableOff({ Id = rewardCage.RewardId })
	UseableOff({ Id = rewardCage.ObjectId })
	SetAnimation({ DestinationId = rewardCage.ObjectId, Name = rewardCage.OnUsedAnimation })
end

function UnlockRewardCagesMiniboss( encounter, args )
	UseableOn({ Id = encounter.RewardId })
	CreateAnimation({ DestinationId = encounter.RewardCageId, Name = "CorruptionCageDepleted" })
	Destroy({ Id = encounter.RewardCageId })
end

function SpawnPassiveFieldsEnemies(room, args)

	if true then
		return -- skip for now
	end

	-- Mega enemy
	local megaUnit = DeepCopyTable( EnemyData.DespairElemental )
	megaUnit.RequiredKill = false
	megaUnit.BlocksLootInteraction = false
	megaUnit.ObjectId = SpawnUnit({ Name = "DespairElemental", Group = "Standing", DestinationId = SelectSpawnPoint(room, megaUnit) })
	thread(SetupUnit, megaUnit, CurrentRun)

	-- Passive enemies
end

function CreateScreenEdgeIndicator( source, args )
	
	local indicatorBackingId = SpawnObstacle({ Name = "ScreenEdgeIndicator", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu_TraitTray_Overlay", SortById = true })
	local indicatorId = SpawnObstacle({ Name = "ScreenEdgeIndicator", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu_TraitTray_Overlay", SortById = true })
	if args.BackingAnimName ~= nil then
		SetAnimation({ DestinationId = indicatorBackingId, Name = args.BackingAnimName })
	end
	if args.AnimName ~= nil then
		SetAnimation({ DestinationId = indicatorId, Name = args.AnimName })
	end
	if IsHorizontallyFlipped({ Id = source.ObjectId }) then
		FlipHorizontal({ Id = indicatorId })
	end
	Move({ Ids = { indicatorBackingId, indicatorId }, ScreenEdgeTargetId = source.ObjectId })
	source.IndicatorBackingId = indicatorBackingId
	source.IndicatorId = indicatorId
	thread( ScreenEdgeIndicatorSpawnPresentation, source, args, indicatorBackingId, indicatorId )

end

function PreExitUnlockDoorSetup( source, args )
	if CurrentRun.CurrentRoom.RestoreUnlockRoomExits and args.RestoreUnlockedAnimation ~= nil and MapState.OfferedExitDoors[source.ObjectId] ~= nil then
		SetAnimation({ Name = args.RestoreUnlockedAnimation, DestinationId = source.ObjectId })
		source.UnlockedAnimation = nil
	end
end

function UseFieldsRewardFinder( source, args )
	if source.OnUsedPresentationFunctionName ~= nil then
		CallFunctionName( source.OnUsedPresentationFunctionName, source )
	end
	UseableOff({ Id = source.ObjectId })
	RecordObjectState( CurrentRun.CurrentRoom, source.ObjectId, "UseableOff", true )

	wait(1.0)

	if not CurrentRun.CurrentRoom.SpawnedRewardCageIndicators then
		for rewardId, reward in pairs( MapState.RoomRequiredObjects ) do
			if not reward.FieldsRewardFinderIgnores then
				local spellIcon = nil
				if SpellData[reward.LootName] ~= nil then
					spellIcon = SpellData[reward.LootName].DoorIcon
				end
				thread( DirectionHintPresentation, reward, { Cooldown = 0.0, Delay = 0 } )
				wait( 0.3 )
				CreateScreenEdgeIndicator( reward, { AnimName = reward.DoorIcon or reward.Icon or reward.IconPath or spellIcon or reward.Name } )
				CurrentRun.CurrentRoom.SpawnedRewardCageIndicators = true
				wait( args.Interval )
			end
		end
		for rewardId, reward in pairs( MapState.OptionalRewards ) do
			if IsAlive({ Id = rewardId }) then
				local spellIcon = nil
				if SpellData[reward.LootName] ~= nil then
					spellIcon = SpellData[reward.LootName].DoorIcon
				end
				thread( DirectionHintPresentation, reward, { Cooldown = 0.0, Delay = 0 } )
				wait( 0.3 )
				CreateScreenEdgeIndicator( reward, { AnimName = reward.DoorIcon or reward.Icon or reward.IconPath or spellIcon or reward.Name,
					BackingAnimName = "FieldsOptionalRewardFinderScreenEdgeIndicator", SoundName = "/SFX/Menu Sounds/MirrorFlash2" } )
				CurrentRun.CurrentRoom.SpawnedRewardCageIndicators = true
				wait( args.Interval )
			end
		end
		if CurrentRun.CurrentRoom.ExitsUnlocked then
			for index, door in pairs( MapState.OfferedExitDoors ) do
				CreateScreenEdgeIndicator( door, { AnimName = "FieldsExitRewardFinder" } )
			end
		end
	end
end

function CheckFieldsExitIndicators()
	if not CurrentRun.CurrentRoom.SpawnedRewardCageIndicators then
		return
	end
	for index, door in pairs( MapState.OfferedExitDoors ) do
		CreateScreenEdgeIndicator( door, { AnimName = "FieldsExitRewardFinder" } )
	end
	for rewardId, reward in pairs( MapState.OptionalRewards ) do
		if reward.IndicatorBackingId == nil then
			local spellIcon = nil
			if SpellData[reward.LootName] ~= nil then
				spellIcon = SpellData[reward.LootName].DoorIcon
			end
			CreateScreenEdgeIndicator( reward, { AnimName = reward.DoorIcon or reward.Icon or reward.IconPath or spellIcon or reward.Name,
				BackingAnimName = "FieldsOptionalRewardFinderScreenEdgeIndicator", SoundName = "/SFX/Menu Sounds/MirrorFlash2" } )
		end
	end
end

function SetupDefaultDoor( source, args )
	if IsDoorClosedForRun( CurrentRun, source ) then
		if source.ClosedForRunAnimation ~= nil then
			SetAnimation({ DestinationId = source.ObjectId, Name = source.ClosedForRunAnimation })
		end
	elseif CurrentRun.CurrentRoom.UnavailableDoors ~= nil and CurrentRun.CurrentRoom.UnavailableDoors[source.ObjectId] and not GetConfigOptionValue({ Name = "EditingMode" }) then
		if source.UnavailableAnimation ~= nil then
			SetAnimation({ DestinationId = source.ObjectId, Name = source.UnavailableAnimation })
		end
	elseif source.AvailableRequirements == nil or IsGameStateEligible( CurrentRun, source, source.AvailableRequirements ) then
		MapState.OfferedExitDoors[source.ObjectId] = source
	end
end

function CheckDoorUnavailable( source, args )
	if not CurrentRun.CurrentRoom.ExitsUnlocked and args.UnavailableChance ~= nil and not IsDoorClosedForRun( CurrentRun, source ) and RandomChance( args.UnavailableChance ) then
		CurrentRun.CurrentRoom.UnavailableDoors = CurrentRun.CurrentRoom.UnavailableDoors or {}
		CurrentRun.CurrentRoom.UnavailableDoors[source.ObjectId] = true
	end
end

function H_BossReloadCleanup( room, args )
	Destroy({ Ids = GetIds({ Name = "Phase1Obstacles" }) })
end

function HandleChronosPreSpawns( room, args )
	local activateEnemies = {}
	local chronos = nil
	for id, enemy in pairs(ActiveEnemies) do
		if enemy.Name ~= "Chronos" then
			activateEnemies[id] = enemy
		else
			chronos = enemy
		end
	end
	local activateCount = TableLength(activateEnemies)
	if chronos.DefaultAIData.SpawnCountDampenTraits ~= nil then
		for traitName in pairs(chronos.DefaultAIData.SpawnCountDampenTraits) do
			if HeroHasTrait(traitName) then
				local traitData = GetHeroTrait( traitName )
				if traitData and traitData.DebuffValue then
					activateCount = activateCount * traitData.DebuffValue 
				end
			end
		end
	end
	local count = 0
	for id, enemy in pairs(activateEnemies) do
		if count < activateCount then
			count = count + 1
		else
			thread( Kill, enemy, { SuppressSounds = true } )
		end
	end
end

function ValidateRoomSets()
	if not verboseLogging then
		return
	end
	local allRooms = {}
	for i, roomSet in pairs( RoomSets ) do
		for j, roomName in ipairs( roomSet ) do
			allRooms[roomName] = true
		end
	end
	for roomName, roomData in pairs( RoomData ) do
		if not roomData.DebugOnly and not roomData.TestRoom and not allRooms[roomName] then
			DebugAssert({ Condition = false, Text = roomData.Name.." is not listed in any RoomSet" })
		end
	end
end