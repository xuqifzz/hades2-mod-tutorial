Import "UtilityLogic.lua"
Import "SaveLogic.lua"
Import "PatchLogic.lua"

Import "ColorData.lua"
Import "RunData.lua"

local fullGame = (GetConfigOptionValue({ Name = "DemoMode" }) == false)

Import "UIPresentation.lua"
Import "UILogic.lua"
Import "HUDLogic.lua"
Import "EventPresentation.lua"
Import "AudioLogic.lua"
Import "AudioPresentation.lua"
Import "NarrativeLogic.lua"
Import "GhostData.lua"
Import "CodexLogic.lua"
Import "CodexPresentation.lua"
Import "DebugData.lua"
Import "Debug.lua"

Import "EnemyAILogic.lua"
Import "UpgradeLogic.lua"
Import "HarvestLogic.lua"
Import "HarvestPresentation.lua"
Import "PowersPresentation.lua"
Import "GardenLogic.lua"
Import "GardenPresentation.lua"
Import "BiomeStateLogic.lua"
Import "BiomeStatePresentation.lua"
Import "KeepsakeLogic.lua"
Import "StoreLogic.lua"
Import "SurfaceShopLogic.lua"
Import "SurfaceShopPresentation.lua"
Import "SellTraitLogic.lua"
Import "MarketLogic.lua"
Import "MarketPromptScreenLogic.lua"
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
Import "FamiliarCostumeLogic.lua"
Import "FamiliarCostumePresentation.lua"
Import "QuestLogLogic.lua"
Import "QuestPresentation.lua"
Import "BountyLogic.lua"
Import "BountyPresentation.lua"
Import "GameStatsLogic.lua"
Import "GameStatsPresentation.lua"
Import "RunHistoryLogic.lua"
Import "RunHistoryPresentation.lua"
Import "MusicPlayerLogic.lua"
Import "MusicPlayerPresentation.lua"
Import "ShrineLogic.lua"
Import "ShrinePresentation.lua"
Import "AchievementLogic.lua"
Import "BadgeLogic.lua"
Import "BadgePresentation.lua"
Import "ResourcePresentation.lua"
Import "ResourceLogic.lua"
Import "SpellPresentation.lua"
Import "SpellLogic.lua"
Import "RunClearLogic.lua"
Import "RoomPresentation.lua"
Import "BiomeMapPresentation.lua"
Import "PresentationBiomeF.lua"
Import "PresentationBiomeG.lua"
Import "PresentationBiomeH.lua"
Import "PresentationBiomeI.lua"
Import "PresentationBiomeN.lua"
Import "PresentationBiomeO.lua"
Import "PresentationBiomeP.lua"
Import "PresentationBiomeQ.lua"
Import "EncounterPresentation.lua"
Import "EnemyPresentation.lua"
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
SessionState.AchievementsUnlocked = {}
SessionState.MapLoads = 0
SessionState.GlobalCooldowns = {}
SessionState.GlobalCounts = {}
SessionState.GameplaySlows = {}
SessionState.PlayerGameplaySlows = {}
SessionState.EarlyDetonationProjectileIds = {}
SessionState.FreeSeekProjectileIds = {}
SessionState.PoseidonExCastTarget = {}
SessionState.PropertyChangeList = { WeaponChanges = {}, ProjectileChanges = {}, EffectChanges = {} }
SessionState.ObjectiveSwaps = {}

if not _istool() then
	SetupFormatContainers({ })
end

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
		ResetUI()

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

		if CurrentRun.CurrentRoom ~= nil then
			if GetConfigOptionValue({ Name = "ForceUnflipMapThings" }) then
				CurrentRun.CurrentRoom.Flipped = false
			end
			if GetConfigOptionValue({ Name = "ForceFlipMapThings" }) then
				CurrentRun.CurrentRoom.Flipped = true
			end
		end
		if CurrentRun ~= nil and CurrentRun.CurrentRoom.Flipped ~= nil and CurrentRun.CurrentRoom.Name == mapName then
			SetConfigOption({ Name = "FlipMapThings", Value = CurrentRun.CurrentRoom.Flipped })
		end

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
		ValidateResourceCategories()
		ValidateCodexCategories()
		ValidateRoomSets()
		ValidateRequirements()
		ValidateTraitData()
		ValidateQuestData()

		local mapName = triggerArgs.name
		roomData = RoomData[mapName]

		if roomData ~= nil then
			RunEventsGeneric( roomData.PreObstacleSetupEvents, CurrentRun.CurrentRoom )
		end

		if DeferredObstacleInitialization ~= nil then
			SessionMapState.DeferredObstacleInitializationStarted = true
			for id, name in pairs( ShallowCopyTable( DeferredObstacleInitialization ) ) do -- Protection from OnSpawn triggering and being added to the table mid-iteration
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
			LoadCurrentRoomResources( CurrentRun.CurrentRoom )
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

		local hubRoomData = HubRoomData[mapName]
		if hubRoomData ~= nil then
			if hubRoomData.OnLoadEvents ~= nil then
				RunEventsGeneric( hubRoomData.OnLoadEvents, hubRoomData, triggerArgs )
			else
				DeathAreaRoomTransition( hubRoomData )
			end
		end

	end
}

function LoadCurrentRoomResources( currentRoom )
	local voiceBanks = { currentRoom.Name, currentRoom.ForceLootName, currentRoom.ChosenRewardType, currentRoom.Encounter.Name, currentRoom.Encounter.LootAName, currentRoom.Encounter.LootBName }
	for _, name in pairs(voiceBanks) do
		local speakerName = GetSpeakerName( name )
		LoadVoiceBanks( speakerName )
		if not GameData.MissingPackages[speakerName] then
			LoadPackages( { Name = speakerName } )
		end
	end


	local packages = { currentRoom.ForceLootName, currentRoom.Encounter.LootAName, currentRoom.Encounter.LootBName, currentRoom.ChosenRewardType }
	for _, name in pairs(packages) do
		if not GameData.MissingPackages[name] then
			LoadPackages({ Name = name })
		end
	end

	if CurrentRun.CurrentRoom.Store ~= nil and CurrentRun.CurrentRoom.Store.StoreOptions ~= nil then
		for i, data in pairs( CurrentRun.CurrentRoom.Store.StoreOptions ) do
			local itemData = ConsumableData[data.Name] or LootData[data.Name]
			if itemData ~= nil then
				if itemData.SpeakerName ~= nil then
					LoadVoiceBanks( itemData.SpeakerName )
				end
				if itemData.LoadPackages ~= nil then
					LoadPackages({ Names = itemData.LoadPackages })
				end
			end
		end
	end

end


function MapStateInit()

	if MapState ~= nil then
		if MapState.ProjectileSounds ~= nil then
			-- Cleanup any remaining old sounds before leaking the ids
			for projectileId, soundId in pairs( MapState.ProjectileSounds ) do
				StopSound({ Id = soundId, Duration = 0.2 })
			end
		end
	end

	MapState = {}
	MapState.SimSpeedChanges = {}
	MapState.PhasingFlags = {}
	MapState.BlockTimerFlags = {}
	MapState.BloomRequests = {}
	MapState.EquippedWeapons = {}
	MapState.HeroNotStopsProjectile = {}
	MapState.ManaChargeIndicatorIds = {}
	MapState.CastArmDisable = {}
	MapState.ProjectileSounds = {}
	MapState.ActiveObstacles = {}
	MapState.BloodDrops = {}
	MapState.AggroedUnits = {}
	MapState.OfferedExitDoors = {}
	MapState.OfferedRewardPreviewTypes = {}
	MapState.TauntTargetIds = MapState.TauntTargetIds or {}
	MapState.RewardPointsUsed = MapState.RewardPointsUsed or {}
	MapState.OptionalRewards = MapState.OptionalRewards or {}
	MapState.ShipWheels = MapState.ShipWheels or {}
	MapState.InspectPoints = MapState.InspectPoints or {}
	MapState.HealthBufferSources = MapState.HealthBufferSources or {}
	MapState.Flags = {}
	MapState.GroupHealthWaiters = {}
	MapState.CombatUIHide = {}
	MapState.ObjectiveUIHide = {}
	MapState.Reticles = {}
	MapState.SandwichCount = 0
	MapState.SprintShields = 0
	MapState.BossShieldTriggers = 0
	MapState.ExCastCount = 0
	MapState.ChargedManaWeapons = {}
	MapState.TorchFireIndex = 1
	MapState.LastBlinkTimeUnmodified = 0
	MapState.HexCooldownDodgeChance = 0
	MapState.UsedSafeZones = {}
	MapState.SpellSummons = {}
	MapState.TypeIdsCache = {}
	MapState.WeaponCharge = {}
	MapState.TemporaryHealthBufferSources = {}
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
	SessionMapState.DeferredUnitInitialization = {}
	SessionMapState.PresentationQueue = {}
	SessionMapState.DistanceCache = {}
	SessionMapState.SpawnPointsUsed = {}
	SessionMapState.OriginMarkers = {}
	SessionMapState.InvalidRepeatCastIds = {}
	SessionMapState.ValidSplitIds = {}
	SessionMapState.InvalidSplitIds = {}
	SessionMapState.CastAttachedProjectiles = {}
	SessionMapState.CurrentExAttachedProjectiles = {}
	SessionMapState.CurrentAttachedBaseProjectiles = {}
	SessionMapState.FirstBurnRecord = {}
	SessionMapState.ExSwordRecord = {}
	SessionMapState.SpawnKillRecord = {}
	SessionMapState.PulseAmmoVolleys = {}
	SessionMapState.DashVolleys = {}
	SessionMapState.AmmoVolleys = {}
	SessionMapState.TorchOrbitIds = {}
	SessionMapState.ExProjectileIds = {}
	SessionMapState.LobLock = {}
	SessionMapState.SpecialLock = {}
	SessionMapState.BlinkLock = {}
	SessionMapState.CastLock = {}
	SessionMapState.SuitLock = {}
	SessionMapState.ChargeStageManaSpend = {}
	SessionMapState.WaveHitRecord = {}
	SessionMapState.FirstHitRecord = {}
	SessionMapState.ProjectileChargeStageReached = {}
	SessionMapState.BurstCounter = 0
	SessionMapState.TimedBuff = 0
	SessionMapState.TimedBuffStartTimes = {}
	SessionMapState.ReadiedMassiveAttacks = {}
	SessionMapState.DaggerLastHit = 0
	SessionMapState.SpellMultiuseCount = 0
	SessionMapState.DamageShareRecord = {}
	SessionMapState.PerfectCritChance = {}
	SessionMapState.MarkedEnemies = {}
	SessionMapState.PlayerMoveBlocks = {}
	SessionMapState.PlayerControlBlocks = {}
	SessionMapState.QueuedVoiceLines = SessionMapState.QueuedVoiceLines or {}
	SessionMapState.SurfaceShopSpawnPointsUsed = {}
	SessionMapState.ProjectilesCarryingSpawns = {}
	SessionMapState.ProjectileSpawnRecord = {}
	SessionMapState.ExpireOldestProjectiles = {}
	SessionMapState.ExpireOldestProjectilesOrder = {}
	SessionMapState.QueuedProjectileDamageMultipliers = {}
	SessionMapState.EnemySpawnDelays = {}
	SessionMapState.SecondaryEffectsThisFrame = 0
	SessionMapState.OnHitsThisFrame = 0
	SessionMapState.RequirementChecksThisFrame = 0
	SessionMapState.DoorTextCount = 0
	SessionMapState.DestroyRequests = {}
	SessionMapState.PlayingCues = SessionMapState.PlayingCues or {}
	SessionMapState.BlockWeaponFailedToFire = {}
	SessionMapState.HUDTraitsShown = {}
	SessionMapState.SpellHealWindow = 0
	SessionMapState.LifeOnKillRecord = SessionMapState.LifeOnKillRecord or {}
	SessionMapState.FiredChillKill = SessionMapState.FiredChillKill or {}
	SessionMapState.PlayerControlBlocks = {}
	SessionMapState.PlayerMoveBlocks = {}
	SessionMapState.ElapsedTimeMultiplierIgnores = {}
	SessionMapState.DifferentOmegaVolleys = {}
	SessionMapState.DifferentOmegaProjectileIds = {}
	SessionMapState.SuitChargedAttackIds = {}
	SessionMapState.DrinkCritVolleys = {}
	SessionMapState.DrinkCritProjectileIds = {}
	SessionMapState.PendingStageManaRefund = {}
	SessionMapState.MarkImages = {}
	SessionMapState.MaxChargeStageReached = {}
	SessionMapState.OccupiedSpawnPoints = {}
	SessionMapState.HitSimSlowOverride = {}
	SessionMapState.ConsecutiveMissileHits = {}
	SessionMapState.ConsecutiveMoonBeamHits = {}
	SessionMapState.LeapCritVolleys = {}
	SessionMapState.LeapCritProjectileIds = {}
	SessionMapState.ClearBonusOnHitProjectileIds = {}
	SessionMapState.SprintBonusVolleys = {}
	SessionMapState.SprintBonusProjectiles = {}
	SessionMapState.ShownMetaUpgradeCardIds = {}
	SessionMapState.ExistingMissileTargetIds = {}
	SessionMapState.BlockStagedCharge = {}
	SessionMapState.LockCameraMotion = {}
	SessionMapState.ExSwaps = {}
	SessionMapState.AutoMagnetizeIds = {}
	SessionMapState.ApolloDevotionIds = {}
	SessionMapState.SprintBurnInflicted = {}
	SessionMapState.CosmeticsPurchased = {}
	SessionMapState.DarkSide = {}
	SessionMapState.DeathMarkers = {}
	SessionMapState.DeathSummons = {}
	SessionMapState.DisplayedLuckMultiplier = 0
	SessionMapState.InCombatTextStackCount = 0
	SessionMapState.MapSpeedMultiplier = 1
	SessionMapState.SummonFirstHitRecord = {}
	SessionMapState.CastDefense = {}
	SessionMapState.PotionCastIds = {}
	SessionMapState.OverheatConsecutiveHit = 0
	SessionMapState.GlobalAttackSpecialSpeed = {}
	SessionMapState.TempArmorPresentation = {}
	SessionMapState.TempArmorPresentationOut = {}
	SessionMapState.DuoTalentEligibleGender = {}
	SessionMapState.DuoTalentEligibleSpell = {}
	SessionMapState.LastAnubisProjectileIds = {}
	SessionMapState.AnubisShadeIds = {}
	SessionMapState.BulletCount = 1
	SessionMapState.LobGunSpecialHits = {}
	SessionMapState.ValidSuperchargeCastIds = {}
	SessionMapState.PolymorphIgnores = {}
	SessionMapState.SuitBonusProjectileId = {}
	SessionMapState.WrappingMoveSpeed = {}
	SessionMapState.DoubleStrikeProjectiles = {}

	FrameState = {}
end

function ValidateIdLeaks( trace, tableToCheck )
	if tableToCheck.ObjectId ~= nil or tableToCheck.Id ~= nil then
		DebugAssert({ Condition = false, Text = "Id leak found in "..trace })
	end
	local idLeakIgnores = ToLookup({ "InspectPoints", "RunHistory", "RoomHistory", "Hero", "PostLineFunctionArgs", "ChallengeSwitch", })
	for key, value in pairs( tableToCheck ) do
		if not idLeakIgnores[key] and type(value) == "table" then
			local recursiveTrace = trace.."."..key
			ValidateIdLeaks( recursiveTrace, value )
		end
	end
end

function ValidateLoops( trace, tableToCheck )
	if string.len( trace ) > 250 then
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
					IsGameStateEligible( textLines, textLines.GameStateRequirements )
				end
			end
		end
		if enemyData.GiftTextLineSets ~= nil then
			for textLinesName, textLines in pairs( enemyData.GiftTextLineSets ) do
				if textLines.GameStateRequirements ~= nil then
					IsGameStateEligible( textLines, textLines.GameStateRequirements )
				end
			end
		end
	end
end

function GetMaxHealthUpgradeIncrement( value, ignoreCap )
	local expectedMaxHealth = HeroData.MaxHealth
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.PropertyChanges ~= nil then
			for k, propertyChange in pairs( trait.PropertyChanges ) do
				if propertyChange.LuaProperty == "MaxHealth" then
					expectedMaxHealth = expectedMaxHealth + propertyChange.ChangeValue
				end
			end
		end
		if trait.ActivatedPropertyChanges ~= nil and IsGameStateEligible( trait, trait.ActivationRequirements ) then
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
	if ignoreCap then
		local prevMaxHealth = expectedMaxHealth
		expectedMaxHealth = expectedMaxHealth + value
		prevMaxHealth = round(prevMaxHealth * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true }))
		expectedMaxHealth = round(expectedMaxHealth * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true }))
		return expectedMaxHealth - prevMaxHealth
	else
		expectedMaxHealth = expectedMaxHealth + value
		expectedMaxHealth = math.max(1, round(expectedMaxHealth * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true })))
	
		local capMaxHealthTrait = HasHeroTraitValue("CapMaxHealth")
		if capMaxHealthTrait and IsTraitActive(capMaxHealthTrait) and capMaxHealthTrait.CapMaxHealth > 0 then
			expectedMaxHealth = capMaxHealthTrait.CapMaxHealth
		end

		return expectedMaxHealth - CurrentRun.Hero.MaxHealth
	end
end

function GetMaxManaUpgradeIncrement( value )
	local expectedMaxMana = HeroData.MaxMana
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.PropertyChanges ~= nil then
			for k, propertyChange in pairs( trait.PropertyChanges ) do
				if propertyChange.LuaProperty == "MaxMana" then
					expectedMaxMana = expectedMaxMana + propertyChange.ChangeValue
				end
			end
		end
		if trait.ActivatedPropertyChanges ~= nil and IsGameStateEligible( trait, trait.ActivationRequirements ) then
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
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.PropertyChanges ~= nil then
			for k, propertyChange in pairs( trait.PropertyChanges ) do
				if propertyChange.LuaProperty == "MaxHealth" then
					expectedMaxHealth = expectedMaxHealth + propertyChange.ChangeValue
				end
			end
		end
		local traitData = TraitData[trait.Name]
		if trait.ActivatedPropertyChanges ~= nil and ( traitData.ActivationRequirements == nil or IsGameStateEligible( trait, traitData.ActivationRequirements ) ) then
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
	
	local capMaxHealthTrait = HasHeroTraitValue("CapMaxHealth")
	if capMaxHealthTrait and IsTraitActive(capMaxHealthTrait) and capMaxHealthTrait.CapMaxHealth > 0 then
		expectedMaxHealth = capMaxHealthTrait.CapMaxHealth
	end

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
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.PropertyChanges ~= nil then
			for k, propertyChange in pairs( trait.PropertyChanges ) do
				if propertyChange.LuaProperty == "MaxMana" then
					expectedMaxMana = expectedMaxMana + propertyChange.ChangeValue
				end
			end
		end
		local traitData = TraitData[trait.Name]
		if trait.ActivatedPropertyChanges ~= nil and ( traitData.ActivationRequirements == nil or IsGameStateEligible( trait, traitData.ActivationRequirements ) ) then
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
	UpdateWeaponMana( 0, { IgnoreHint = true, } )
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

	CreateGroup({ Name = "FX_Terrain_Decor", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "FX_Terrain_Decor", DestinationName = "Terrain_Gameplay" })

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
		if not IsEmpty( CurrentRun.CurrentRoom.ActiveEncounters ) then
			thread( CannotUseDoorPresentation, door )
			return
		elseif not door.EncounterCostStarted then
			door.EncounterCostStarted = true

			if door.OnUsedEncounterCostPresentationFunctionName ~= nil then
				CallFunctionName(door.OnUsedEncounterCostPresentationFunctionName, door, args)
			end
			if not IsEmpty(SessionMapState.SkipEncounterIds) and CurrentRun.CurrentRoom.Encounter.SpawnsSkipped then
				thread( SkipEncounterEndPresentation )
			end

			local doorEncounter = DeepCopyTable( EncounterData[door.EncounterCost] )
			GenerateEncounter(CurrentRun, CurrentRun.CurrentRoom, doorEncounter)
			StopAnimation({ DestinationId = door.ObjectId, Names = { "OceanusManholeLockIdleGlow", "OceanusManholeLockIdle", "OceanusManholeLockIdleIn" } })
			PlaySound({ Name = "/SFX/OceanusTrapDoorUnlock" })
			CreateAnimation({ DestinationId = door.ObjectId, Name = "OceanusManholeUnlock", Group = "FX_Terrain_Top" })
			RefreshUseButton(door.ObjectId, door)
			for id, offeredExitDoor in pairs( MapState.OfferedExitDoors ) do
				if offeredExitDoor ~= door then
					offeredExitDoor.PrevCanBeRerolled = offeredExitDoor.CanBeRerolled
					offeredExitDoor.CanBeRerolled = false
				end
			end

			StartEncounter(CurrentRun, CurrentRun.CurrentRoom, doorEncounter)

			door.EncounterCost = nil
			if door.Room ~= nil and door.Room.ChosenRewardType ~= "Shop" and HasHeroTraitValue( "AllowDoorReroll" ) then
				door.CanBeRerolled = true
			end
			CreateDoorRewardPreview( door )
			thread( ExitDoorUnlockedPresentation, door )
			for id, offeredExitDoor in pairs( MapState.OfferedExitDoors ) do
				if offeredExitDoor ~= door then
					offeredExitDoor.CanBeRerolled = offeredExitDoor.PrevCanBeRerolled
				end
				RefreshUseButton( id, offeredExitDoor )
			end
			return
		end
		return
	end

	door.InUse = true

	if door.HealthCost ~= nil then
		SacrificeHealth( { SacrificeHealthMin = door.HealthCost, SacrificeHealthMax = door.HealthCost, Silent = true, DeductHealth = true, AttackerName = "TrialUpgrade" } )
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
		door.Room = ShallowCopyTable( prevRoom )
		-- Restore any missing data that may have been stripped for saving
		local originalRoomData = RoomData[door.Room.Name]
		if originalRoomData ~= nil then
			for roomKey, roomValue in pairs( originalRoomData ) do
				if door.Room[roomKey] == nil then
					door.Room[roomKey] = roomValue
				end
			end
		end
		door.Room.StartRoomPresentationOnReload = true
		door.Room.TimesVisited = door.Room.TimesVisited + 1
	end
	if door.ReturnToPreviousRoomName then
		local found = false
		for roomIndex = #CurrentRun.RoomHistory, 1, -1 do
			local prevRoom = CurrentRun.RoomHistory[roomIndex]
			if not found and door.ReturnToPreviousRoomName == prevRoom.Name then
				door.Room = ShallowCopyTable( prevRoom )
				-- Restore any missing data that may have been stripped for saving
				local originalRoomData = RoomData[door.Room.Name]
				if originalRoomData ~= nil then
					for roomKey, roomValue in pairs( originalRoomData ) do
						if door.Room[roomKey] == nil then
							door.Room[roomKey] = roomValue
						end
					end
				end
				door.Room.TimesVisited = door.Room.TimesVisited + 1
				found = true
			end
		end
	end

	if door.CloseOnReturnAnimation ~= nil then
		CurrentRun.CurrentRoom.CloseDoorOnReturn = door.ObjectId
	end

	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom

	if roomData.OnUseSetRunData ~= nil and roomData.OnUseSetRunData[door.Name] ~= nil then
		OverwriteTableKeys( CurrentRun.CurrentRoom, roomData.OnUseSetRunData[door.Name] )
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

	return nil

end

function GetDoorHealAmount( currentRun, limitedOnly )
	local maxHealth = currentRun.Hero.MaxHealth
	local healAmount = 0
	local roomHealFraction = GetTotalHeroTraitValue("DoorHeal")
	local roomHealFixed = GetTotalHeroTraitValue("DoorHealFixed")
	local roomHealFullThreshold = GetTotalHeroTraitValue("DoorFullHealThreshold", {IsMultiplier = true })
	local roomHealIgnorePenalty = GetTotalHeroTraitValue("DoorHealIgnorePenaltyFixed")
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

	if limitedOnly then
		healAmount = 0
	end
	if HeroHasTrait("DoorHealReserveKeepsake") then
		local missingHealth = CurrentRun.Hero.MaxHealth - CurrentRun.Hero.Health
		if missingHealth > healAmount then
			local remainingMissing = missingHealth - healAmount
			local trait = GetHeroTrait("DoorHealReserveKeepsake")
			local healReserve = trait.DoorHealReserve
			if healReserve > remainingMissing then
				roomHealIgnorePenalty = roomHealIgnorePenalty + remainingMissing
				trait.DoorHealReserve = round( trait.DoorHealReserve - remainingMissing )
			else
				roomHealIgnorePenalty = roomHealIgnorePenalty + trait.DoorHealReserve
				trait.DoorHealReserve = 0
				trait.CustomName = trait.ZeroBonusTrayText
				if healReserve ~= 0 then
					thread( DoorHealKeepsakeExpiredPresentation )
				end
				ReduceTraitUses( trait, { Force = true })
			end
		end
	end
	
	local healingMultiplier = CalculateHealingMultiplier()
	if healingMultiplier < 1 then
		healAmount = round( healAmount * healingMultiplier)
		healAmount = healAmount + roomHealIgnorePenalty	
	else
		healAmount = healAmount + roomHealIgnorePenalty
		healAmount = round( healAmount * healingMultiplier)
	end
	return healAmount
end

function CheckDoorHealTrait( currentRun, door, limitedOnly )
	local healAmount = GetDoorHealAmount( currentRun, limitedOnly )
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

	FrameState.RequestUpdateHealthUI = true
end

function UnusedWeaponBonusReward()
	if CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.SkipUnusedWeaponBonusReward then
		return
	end
	if GameState.ClearedRunsCache <= 0 then
		wait( 0.43 )
	end
	for name, amount in pairs( TraitData.UnusedWeaponBonusTrait.AddResources ) do
		thread( UnusedWeaponBonusPresentation )
		AddResource( name, amount, "UnusedWeaponBonusTrait", {
			StartId = HUDScreen.Components.InventoryIcon.Id,
			OffsetX = -120,
			AnchorOffsetY = -50,
			HoldOffsetY = -100,
			FontSize = 120,
			ShadowScale = 0.5,
			IgnoreAsLastResourceGained = true,
		} )
	end
end

function UnusedWeaponBonusDropGems( source, args )
	local encounter = CurrentRun.CurrentRoom.Encounter
	if encounter == nil or encounter.EncounterType ~= "Boss" or encounter.SkipBossTraits then
		return
	end

	local consumableData = ConsumableData.GemPointsDrop
	local amount = consumableData.AddResources.GemPoints + consumableData.IncreasePerBiomeCleared * (CurrentRun.ClearedBiomes - 1)
	GiveRandomConsumables(
		{
			Delay = 0.35,
			ForceToValidLocation = true,
			KeepCollision = true,
			LootOptions =
			{
				{
					Name = "GemPointsDrop",
					Overrides =
					{
						CanDuplicate = false,
						AddResources =
						{
							GemPoints = amount,
						},
					},
				},
			},
		}
	)
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
	if verboseLogging then
		DebugAssert({ Condition = IdExists({ Id = inspectPoint.ObjectId }), Text = "InspectPoint Id "..inspectPoint.ObjectId.." does not exist.", Owner = "Greg" })
	end
	AttachLua({ Id = inspectPoint.ObjectId, Table = inspectPoint })
	MapState.ActiveObstacles[inspectPoint.ObjectId] = inspectPoint
	MapState.InspectPoints[inspectPoint.ObjectId] = inspectPoint
end

function RemoveInspectPoints()
	local inspectPointIds = GetAllKeys( MapState.InspectPoints )
	Destroy({ Ids = inspectPointIds })
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

	if roomData.RichPresence ~= nil then
		SetRichPresence({ Key = "status", Value = roomData.RichPresence })
		SetRichPresence({ Key = "steam_display", Value = roomData.RichPresence })
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

	if currentRoom.Encounters ~= nil then
		for _, encounter in ipairs( currentRoom.Encounters ) do
			LoadSpawnPackages( encounter )
		end
	else
		LoadSpawnPackages( currentRoom.Encounter )
	end
	if currentRoom.CageRewards ~= nil then
		for i, cageReward in ipairs( currentRoom.CageRewards ) do
			if cageReward.Encounter ~= nil then
				LoadSpawnPackages( cageReward.Encounter )
			end
		end
	end
	LoadBountyPackages( currentRoom )
	if GameState.EquippedFamiliar ~= nil then
		LoadPackages({ Name = GameState.EquippedFamiliar })
	end

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

	if GetNumShrineUpgrades( "EnemyEliteShrineUpgrade" ) > 0 then
		PickRoomEliteAttributes(currentRoom)
	end
	
	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName ) 
		if weaponData ~= nil then
			RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
		end
	end

	RunThreadedEvents( RoomData[currentRoom.Name].StartThreadedEvents, currentRoom )
	RunEventsGeneric( RoomData[currentRoom.Name].StartUnthreadedEvents, currentRoom )
	RunEventsGeneric( RoomEventData.GlobalRoomStartEvents, currentRoom )
	RunThreadedEvents( encounterData.StartRoomThreadedEvents, currentRoom.Encounter )
	RunEventsGeneric( encounterData.StartRoomUnthreadedEvents, currentRoom.Encounter )	

	ApplyTraitSetupFunctions( CurrentRun.Hero, { Context = "StartRoom" } )
	ApplyTraitSetupFunctions( CurrentRun.Hero, { Context = "EnterRoom" } )

	SetupRoomArt( currentRun, currentRoom )
	
	if GetNumShrineUpgrades( "BiomeSpeedShrineUpgrade" ) > 0 then
		if currentRoom.BiomeStartRoom then
			-- if we are in a erebus / chaos / postboss room reset the timer
			local rankIndex = GetNumShrineUpgrades("BiomeSpeedShrineUpgrade")
			local additionalTime = MetaUpgradeData.BiomeSpeedShrineUpgrade.ChangeValue
			if additionalTime then
				CurrentRun.BiomeTime = math.max( CurrentRun.BiomeTime, 0 ) + additionalTime
				thread( BiomeTimeCheckpointPresentation, CurrentRun, additionalTime )
			end
		end
		thread( BiomeSpeedTimerLoop )
	end
	
	if currentRoom.BiomeStartRoom and HeroHasTrait("EchoRepeatKeepsakeBoon") then
		local traitData = GetHeroTrait("EchoRepeatKeepsakeBoon")
		local baseRepeatedTraitData = TraitData[traitData.RepeatedKeepsake]
		if baseRepeatedTraitData then
			if baseRepeatedTraitData.Permanent and HeroHasTrait(traitData.RepeatedKeepsake) then
				local trait = GetHeroTrait(traitData.RepeatedKeepsake)
				local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.RepeatedKeepsake, Rarity = "Common" })
				-- With only two cases I don't think it's worth making a generic solution
				if trait.Name == "GoldifyKeepsake" then
					trait.BoonConversionUses = trait.BoonConversionUses + traitData.BoonConversionUses
				elseif trait.Name == "RarifyKeepsake" then
					trait.RarityUpgradeData.Uses = trait.RarityUpgradeData.Uses + traitData.RarityUpgradeData.Uses
				end
			else
				EquipKeepsake( CurrentRun.Hero, traitData.RepeatedKeepsake, { ForceRarity = "Common", FromLoot = true, OverwriteSlot = true, SkipAddToHUD = true })
				traitData.CustomTrayText = traitData.ActivatedTrayText
				local newKeepsake = traitData.RepeatedKeepsake
				if newKeepsake == "BonusMoneyKeepsake" then
					local newTraitData = GetHeroTrait("BonusMoneyKeepsake") 
					AddResource( "Money", round(newTraitData.BonusMoney * GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )), "BonusMoneyKeepsake" )
				end
			end
		end
	end

	if currentRoom.BiomeStartRoom then
		if HeroHasTrait("BonusMoneyKeepsake") then
			local traitData = GetHeroTrait("BonusMoneyKeepsake") 
			ReduceTraitUses( traitData , {Force = true })

			if traitData.ZeroBonusTrayText then
				traitData.CustomTrayText = traitData.ZeroBonusTrayText
			end
		end
		if HeroHasTrait( "PersistentDionysusSkipKeepsake" ) then
			local traitData = GetHeroTrait("PersistentDionysusSkipKeepsake")
			traitData.ActivatedThisBiome = false
			traitData.CustomTrayText = "PersistentDionysusSkipKeepsake"
		end
		if HeroHasTrait("SkipEncounterKeepsake") then
			local traitData = GetHeroTrait("SkipEncounterKeepsake") 
			ReduceTraitUses( traitData , {Force = true })
			if traitData.ZeroBonusTrayText then
				traitData.CustomTrayText = traitData.ZeroBonusTrayText
			end
		end
		if HeroHasTrait( "DodgeFamiliar" ) then
			local traitData = GetHeroTrait( "DodgeFamiliar" )
			traitData.RemainingBlocks = TraitData.DodgeFamiliar.RemainingBlocks
		end
	end
	if currentRoom.BiomeStartRoom then
		IncrementTableValue( CurrentRun, "ClearedBiomes" )
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

	ToggleCombatControl( CombatControlsDefaults, true, roomData.Name )
	ShowCombatUI( nil, { IgnoreLifePips = ShowingCombatUI } ) -- Should probably be a general rule but keeping contained to this call for now

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

	if currentRoom.Encounters ~= nil then
		for i, encounter in ipairs(currentRoom.Encounters) do
			if i > 1 then
				local lastStartTime = currentRoom.Encounter.StartTime
				currentRoom.Encounter = currentRoom.Encounters[i]
				if EncounterData[currentRoom.Encounter.Name].UsePreviousStartTime then
					currentRoom.Encounter.StartTime = lastStartTime
				end
			end
			StartEncounter( currentRun, currentRoom, currentRoom.Encounter )
		end
		currentRoom.AllEncountersCompleted = true
		CheckInspectPoints( currentRun, roomData )
		if CheckRoomExitsReady( currentRoom ) then
			UnlockRoomExits( currentRun, currentRoom )
		end
	else	
		StartEncounter( currentRun, currentRoom, currentRoom.Encounter )
		CheckInspectPoints( currentRun, roomData )
	end

	RunEventsGeneric( RoomData[currentRoom.Name].PostCombatEvents, currentRoom )

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
	while not IsEmpty( MapState.RoomRequiredObjects ) or IsScreenOpen( "UpgradeChoice" ) or IsScreenOpen( "BoonMenu" ) or IsScreenOpen( "Dialog" ) or IsScreenOpen( "SpellScreen" ) or IsScreenOpen( "TalentScreen" ) do
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

	RandomSynchronize( 3 )

	local wheelRewardObstacles = {}
	local twoRewardChoice = false
	MapState.ShipWheels = {}
	if RandomChance( EncounterData[encounter.Name].TwoRewardChoiceChance or 1 ) then
		twoRewardChoice = true

		local wheelLeft = DeepCopyTable( ObstacleData.ShipsSteeringWheelLeft )
		wheelLeft.ObjectId = SpawnObstacle({ Name = "ShipsSteeringWheelLeft", DestinationId = wheelId, Group = "Standing", OffsetX = -185, OffsetY = -105 })
		SetupObstacle( wheelLeft )
		if HasHeroTraitValue( "AllowDoorReroll" ) then
			wheelLeft.CanBeRerolled = true
		end
		wheelLeft.ReadyToUse = true
		wheelLeft.WheelObstacleId = wheelId
		table.insert( wheelRewardObstacles, wheelLeft )
		MapState.ShipWheels[wheelLeft.ObjectId] = wheelLeft

		local wheelRight = DeepCopyTable( ObstacleData.ShipsSteeringWheelRight )
		wheelRight.ObjectId = SpawnObstacle({ Name = "ShipsSteeringWheelRight", DestinationId = wheelId, Group = "Standing", OffsetX = 175, OffsetY = 80 })
		SetupObstacle( wheelRight )
		if HasHeroTraitValue( "AllowDoorReroll" ) then
			wheelRight.CanBeRerolled = true
		end
		wheelRight.ReadyToUse = true
		wheelRight.WheelObstacleId = wheelId
		table.insert( wheelRewardObstacles, wheelRight )
		MapState.ShipWheels[wheelRight.ObjectId] = wheelRight
	else
		table.insert( wheelRewardObstacles, wheel )
		if HasHeroTraitValue( "AllowDoorReroll" ) then
			wheel.CanBeRerolled = true
		end
		wheel.ReadyToUse = true
		MapState.ShipWheels[wheel.ObjectId] = wheel
	end

	ShipsSteeringWheelChoicePresentation( wheel )

	local rewardsChosen = {}
	local rewardStoreName = ChooseNextRewardStore( CurrentRun )
	for k, wheelObstacle in ipairs( wheelRewardObstacles ) do
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
	waitUntil( "ShipsEncounterSelected" )

	ShipsSteeringWheelSelectionPresentation( wheelId )

	StartEncounterEffects( encounter )

	for k, wheelObstacle in ipairs( wheelRewardObstacles ) do
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

	local speakerName = ( LootData[wheel.ChosenRewardType] and LootData[wheel.ChosenRewardType].SpeakerName ) or ( LootData[wheel.ForceLootName] and LootData[wheel.ForceLootName].SpeakerName ) or nil
	LoadVoiceBanks( speakerName, false, true )
	if speakerName ~= nil and not GameData.MissingPackages[speakerName] then
		LoadPackages( { Name = speakerName, IgnoreAssert = true } )
	end

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

	LoadBountyPackages( currentRoom )
	if GameState.EquippedFamiliar ~= nil then
		LoadPackages({ Name = GameState.EquippedFamiliar })
	end
	HandleSecretSpawns( currentRun )
	StartRoomPreLoadBinks({
		Run = currentRun,
		Room = currentRoom,
		Encounter = currentRoom.Encounter,
		ChallengeEncounter = currentRoom.ChallengeEncounter
	})
	
	currentRoom.Leaving = false

	RestoreObjectStates( currentRoom )

	if EncounterData[currentRoom.Encounter.Name].EnemiesToRestore ~= nil then
		for i, enemyToRestore in ipairs( EncounterData[currentRoom.Encounter.Name].EnemiesToRestore ) do
			RestoreEncounterSpawn( currentRoom.Encounter, enemyToRestore )
		end
	end

	if currentRoom.Encounter.ObstaclesToRestore ~= nil then
		for i, obstacleToRestore in ipairs( currentRoom.Encounter.ObstaclesToRestore ) do
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
	if RoomData[currentRoom.Name].DistanceTriggersPostCombatReload then
		StartTriggers( currentRoom, currentRoom.DistanceTriggers )
	end
	RunEventsGeneric( RoomData[currentRoom.Name].PostCombatReloadEvents, currentRoom )
	RunThreadedEvents( RoomData[currentRoom.Name].PostCombatReloadThreadedEvents, currentRoom )

	CheckInspectPoints( currentRun, currentRoom )

	wait(0.1)

	DoUnlockRoomExits( currentRun, currentRoom )

	wait(0.1)

	RemoveTimerBlock(currentRun, "RestoreUnlockRoomExits")
	
	ToggleCombatControl( CombatControlsDefaults, true )
	ShowCombatUI()

	if GetNumShrineUpgrades("BiomeSpeedShrineUpgrade") > 0 then
		thread( BiomeSpeedTimerLoop )
	end


end

function LoadSpawnPackages( encounter )

	local encounterData = EncounterData[encounter.Name] or encounter
	if encounterData.SpeakerNames ~= nil then
		LoadVoiceBank({ Names = encounterData.SpeakerNames })
	end

	if encounterData.LoadPackages ~= nil then
		LoadPackages({ Names = encounterData.LoadPackages })
	end

	for _, packageNames in pairs( GetHeroTraitValues( "LoadPackages" ) ) do
		LoadPackages({ Names = packageNames })
	end

	if encounter.Spawns == nil then
		return
	end

	for k, spawnData in pairs( encounter.Spawns ) do
		LoadPackages({ Name = spawnData.Name })
	end

end

function LoadBountyPackages( currentRoom )
	local bountyData = BountyData[bountyName]
	if bountyData ~= nil and bountyData.Encounter == currentRoom.Encounter.Name then
		LoadVoiceBanks({ Name = "Chaos" })
	end
end

function LoadVoiceBanks( characters, persist, ignoreAssert )
	if type(characters) == "table" then
		for _, value in pairs(characters) do
			LoadVoiceBanks( value, persist, ignoreAssert )
		end
	elseif type(characters) == "string" then
		LoadVoiceBank({ Name = characters, Persist = persist, IgnoreAssert = ignoreAssert })
	end
end

function SetupPreActivatedEnemies( source )
	for id, name in pairs( SessionMapState.DeferredUnitInitialization ) do
		local enemyData = EnemyData[name]
		if not enemyData.SkipDefaultSetup then
			local unit = DeepCopyTable( enemyData )
			unit.ObjectId = id
			thread( SetupUnit, unit, CurrentRun, { SkipAISetup = source.PreActivatedSkipAISetup } )
		end
	end
	SessionMapState.DeferredUnitInitialization = nil
end

function SetupHeroObject( room, applyLuaUpgrades )

	local currentRun = CurrentRun	
	local heroIds = GetIdsByType({ Name = room.HeroUnitName or "_PlayerUnit" })
	DebugAssert({ Condition = #heroIds <= 1, Text = "Too many _PlayerUnit objects on map!" })
	DebugAssert({ Condition = ( currentRun.Hero.ObjectId == nil ), Text = "Hero.ObjectId should be nil in SetupHeroObject", Owner = "Caleb", })
	currentRun.Hero.ObjectId = heroIds[1]
	AttachLua({ Id = currentRun.Hero.ObjectId, Table = currentRun.Hero })

	local hero = currentRun.Hero
	local roomData = RoomData[room.Name] or CurrentHubRoom

	if room.HeroOverwrites ~= nil then
		OverwriteSelf( hero, room.HeroOverwrites )
	end

	AddToGroup({ Id = currentRun.Hero.ObjectId, Name = "HeroTeam" })

	GatherAndEquipWeapons( currentRun )
	if roomData.BlockCombat then
		DisableWeapons()
		if roomData.UnloadWeapons then
			UnloadPackages({ Names = WeaponPackages })
		end
	else
		HandleWeaponAnimSwaps()
	end

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
	CurrentRun.Hero.PhasingFlags = {}
	currentRun.Hero.PlayingVoiceLine = nil
	currentRun.Hero.QueuedVoiceLines = {}
	currentRun.Hero.SpeechParams = currentRun.Hero.SpeechParams or {}
	currentRun.Hero.ReserveManaSources = {}
	currentRun.Hero.ReserveHealthSources = {}
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
	currentRun.Hero.ReserveHealthExtra = currentRun.Hero.ReserveHealthExtra or 0
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
	CheckActivatedTraits( CurrentRun.Hero, { SkipPresentation = true } )
	ApplyTraitUpgrade( currentRun.Hero, applyLuaUpgrades )
	ApplyTraitSetupFunctions( currentRun.Hero )
	ApplyAllTraitWeapons( currentRun.Hero )

	for k, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.RoomCooldown ~= nil then
			IncrementTraitCooldown( trait )
		end
		if trait.TimeCooldown ~= nil then
			IncrementTraitCooldown( trait, trait.TimeCooldown)
		end
	end
	
	ClampSprintSpeed( currentRun.Hero )

	SetupCostume()

	if room.HeroUnitName == nil then
		CheckAttachmentTextures( CurrentRun.Hero )
	end

	SetLightBarColor({ PlayerIndex = 1, Color = currentRun.Hero.LightBarColor or HeroData.LightBarColor });
	
	CheckPrevTraitsManaReserveShrineUpgrade( currentRun.Hero )
	
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

	--[[
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
	]]

end

function BeginArachneEncounter(encounter)
	StartEncounterEffects( encounter )
end

function BeginArtemisEncounter(encounter)
	StartEncounterEffects( encounter )
end

function BeginAthenaEncounter( encounter )
	if CurrentRun.CurrentRoom and TableLength(CurrentRun.CurrentRoom.Encounters) == 1 then
		StartEncounterEffects( encounter )
	end
end

function BeginIcarusEncounter(encounter)
	StartEncounterEffects( encounter )
end

function BeginHeraclesEncounter(encounter)
	InvalidateCheckpoint()
	StartEncounterEffects( encounter )
end

function BeginNemesisEncounter(encounter)
	InvalidateCheckpoint()
	StartEncounterEffects( encounter )
end

function BeginCrawlerEncounter(encounter)
	StartEncounterEffects( encounter )
end

function BeginPerfectClearEncounter(encounter)
	StartEncounterEffects( encounter )
end

function BeginEliteChallenge(encounter)
	StartEncounterEffects( encounter )
end

function BeginSurvivalEncounter(encounter)
	StartEncounterEffects( encounter )
end

function BeginOpeningEncounter(encounter)
	StartEncounterEffects( encounter )
end

function StartEncounter( currentRun, currentRoom, encounter )

	if encounter.Completed then
		return
	end

	local roomData = RoomData[currentRoom.Name]
	local encounterData = EncounterData[encounter.Name] or encounter
	if not encounterData.SkipEncounterStart and (not encounter or not encounter.SkipEncounterStart) and ( CurrentRun.CurrentRoom.Encounter.EncounterType ~= "NonCombat" or encounterData.ForceEncounterStart ) then
		if encounterData.ForceEncounterStart or ( CurrentRun.CurrentRoom.Encounter == encounter and encounter ~= currentRoom.ChallengeEncounter and not encounterData.DelayedStart ) then
			StartEncounterEffects( encounter )
		end
	elseif encounterData.CheckAthenaEncounterKeepsakeOnSkipEncounterStart and HeroHasTrait("AthenaEncounterKeepsake") then
		local traitData = GetHeroTrait("AthenaEncounterKeepsake")
		if IsTraitActive(traitData) and traitData.UniqueEncounterArgs and IsGameStateEligible( traitData, traitData.UniqueEncounterArgs.GameStateRequirements) then
			thread( CallFunctionName, traitData.UniqueEncounterArgs.EncounterThreadedFunctions.FunctionName, encounter, traitData.UniqueEncounterArgs.EncounterThreadedFunctions.Args )
		end
	end

	if encounter.EncounterType == "Default" then
		--DebugPrint({ Text = encounter.Name })
		local encounterDifficulty = encounter.DifficultyRating or "?"
		--DebugPrint({ Text = "    Encounter Difficulty = "..encounterDifficulty })
		for waveIndex, wave in pairs(encounter.SpawnWaves) do
			--DebugPrint({ Text = "        Wave #"..waveIndex })
			local waveDifficulty = wave.DifficultyRating or "?"
			--DebugPrint({ Text = "        Wave Difficulty = "..waveDifficulty })
			if wave.TypeCount ~= nil then
				--DebugPrint({ Text = "        Max Types: "..wave.TypeCount })
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
				--DebugPrint({ Text = "            "..enemyName.." "..enemyCount.." ("..enemyDifficultyRatingTotal..") " })
			end

			if wave.TypeCount ~= nil then
				--DebugPrint({ Text = "    Spawned Difficulty Rating: "..totalActualDifficultyRating })
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
	table.insert( currentRoom.ActiveEncounters, encounter )
	if encounterData.TimerBlock ~= nil and ( encounterData.TimerBlockRequirements == nil or IsGameStateEligible( currentRoom, encounterData.TimerBlockRequirements ) ) then
		AddTimerBlock( currentRun, encounterData.TimerBlock )
	end
	if CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth <= HealthUI.LowHealthThreshold and not currentRoom.HideLowHealthShroud then
		HeroDamageLowHealthPresentation( true )
	end

	if encounter.ForceEliteAttrubuteCount ~= nil then
		PickEncounterEliteAttributes(encounter)
	end

	StartTriggers( encounter, encounterData.DistanceTriggers )

	RunEvents( encounter, encounterData )

	RemoveValueAndCollapse( currentRoom.ActiveEncounters, encounter )
	encounter.Completed = true
	if encounter.EncounterType == "Miniboss" or encounter.EncounterType == "Boss" then
		UpdateSpellActiveStatus()
	end
	currentRun.EncountersCompletedCache[encounter.Name] = (currentRun.EncountersCompletedCache[encounter.Name] or 0) + 1
	GameState.EncountersCompletedCache[encounter.Name] = (GameState.EncountersCompletedCache[encounter.Name] or 0) + 1

	-- Check for encounter-end effects
	RecordEncounterClearStats( encounter )
	EndEncounterEffects( currentRun, currentRoom, encounter )
	if not encounter.SkipDisableTrapsOnEnd then
		DisableRoomTraps()
	end

	-- Check for encounter complete exit	
	wait( roomData.EncounterCompleteWait or 0.2, RoomThreadName )
	if CheckRoomExitsReady( currentRoom ) then
		UnlockRoomExits( currentRun, currentRoom )
	end

end

function GiveRandomConsumables( args, trait, contextArgs )
	args = args or {}
	if contextArgs ~= nil and contextArgs.OverwriteArgs then
		OverwriteTableKeys( args, contextArgs.OverwriteArgs )
	end
	wait( args.Delay, RoomThreadName )

	if args.GlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[args.GlobalVoiceLines] )
	end
	local multiplier = args.LootMultiplier or 1
	local range = args.Range or 150
	local force = args.Force or RandomFloat( args.ForceMin or 75, args.ForceMax or 150 )
	local angle = args.Angle or RandomFloat( args.AngleMin or 0, args.AngleMax or 360 )
	local upwardAngle = args.UpwardAngle or RandomFloat( args.UpwardForceMin or 500, args.UpwardForceMax or 700 )
	local angleOffset = 0
	local destinationId = args.DestinationId or CurrentRun.Hero.ObjectId
	for i, lootData in ipairs( args.LootOptions ) do
		if lootData.Chance ~= nil then
			if RandomChance( lootData.Chance * multiplier) and ( IsEmpty( lootData.GameStateRequirements ) or IsGameStateEligible( lootData, lootData.GameStateRequirements ) ) then
				if args.UseSurfaceSpawnPoints then
					destinationId = SelectSurfaceItemSpawnPoint()
				end
				local consumableId = SpawnObstacle({ Name = lootData.Name, DestinationId = destinationId, Group = "Standing",
					OffsetX = args.OffsetX or RandomFloat( -1 * range, range ),
					OffsetY = args.OffsetY or RandomFloat( -1 * range, range ),
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
				if consumable.ExtractValues ~= nil then
					ExtractValues( CurrentRun.Hero, consumable, consumable )
				end
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
				thread( GushMoney, { Amount = amount, LocationId = args.DestinationId or CurrentRun.Hero.ObjectId, Source = "GiveRandomConsumables" } )
			else
				for i = 1, amount do
					if args.ReRandomizeForcePerItem then
						force = args.Force or RandomFloat( args.ForceMin or 75, args.ForceMax or 150 )
						upwardAngle = args.UpwardAngle or RandomFloat( args.UpwardForceMin or 500, args.UpwardForceMax or 700 )
					end
					angle = args.Angle or RandomFloat( args.AngleMin or 0, args.AngleMax or 360 )
					if args.UseSurfaceSpawnPoints then
						destinationId = SelectSurfaceItemSpawnPoint()
					end
					local consumableId = SpawnObstacle({ Name = lootData.Name, DestinationId = destinationId, Group = "Standing",
						OffsetX = args.OffsetX or RandomFloat( -1 * range, range ),
						OffsetY = args.OffsetY or RandomFloat( -1 * range, range ),
						ForceToValidLocation = args.ForceToValidLocation })
					local consumable = CreateConsumableItem( consumableId, lootData.Name, 0, args )
					if lootData.Overrides ~= nil then
						for key, value in pairs( lootData.Overrides ) do
							consumable[key] = value
						end
					end
					ApplyConsumableItemResourceMultiplier( {}, consumable )
					if consumable.ExtractValues ~= nil then
						ExtractValues( CurrentRun.Hero, consumable, consumable )
					end
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
					if lootData.Interval or args.Interval then
						wait( lootData.Interval or args.Interval )
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
			for k, trait in ipairs( CurrentRun.Hero.Traits ) do
				if trait.ForceBoonName == lootData.Name then
					ReduceTraitUses( trait )
				end
			end
		end
		local loot = CreateLoot(MergeTables({ Name = lootData.Name, AutoLoadPackages = true }, args))
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

function CreateHermesLoot( args )
	args = args or {}
	return CreateLoot( MergeTables( args, { Name = "HermesUpgrade", AutoLoadPackages = true } ) )
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
	local ignoreAllRarityBonus = loot.IgnoreAllRarityBonus 
	local ignoreRoomRarityBonus = loot.IgnoreRoomRarityBonus
	local referencedTable = "BoonData"
	if name == "StackUpgrade" then
		referencedTable = "StackData"
	elseif name == "WeaponUpgrade" then
		referencedTable = "WeaponData"
	elseif name == "HermesUpgrade" then
		referencedTable = "HermesData"
	end

	local rarityChances = ShallowCopyTable( HeroData[referencedTable].RarityChances ) or {}
	for rarityName in pairs( TraitRarityData.RarityValues ) do
		rarityChances[rarityName] = rarityChances[rarityName] or 0
	end

	if CurrentRun.CurrentRoom.BoonRaritiesOverride and not ignoreRoomRarityBonus then
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
	if ignoreAllRarityBonus then
		return rarityChances
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
	local rarityTraits = GetHeroTraitValues("MultiplicativeRarityBonus", { UnlimitedOnly = ignoreTempRarityBonus })
	for i, rarityTraitData in pairs(rarityTraits) do
		if ( rarityTraitData.RequiredGod == nil or rarityTraitData.RequiredGod == name ) 
			and ( rarityTraitData.GodLootOnly == nil or (rarityTraitData.GodLootOnly and ( loot.GodLoot or loot.TreatAsGodLootByShops ))) then
			for rarityName in pairs( TraitRarityData.RarityValues ) do
				if rarityTraitData[rarityName] then
					rarityChances[rarityName] = rarityChances[rarityName] * rarityTraitData[rarityName]
				end
			end
		end
	end
	return rarityChances
end

function PassRarityCheck( rarityName )
	if not rarityName or rarityName == "Common" then
		return true
	end
	local rarityChances = GetRarityChances({ IgnoreTempRarityBonus = true })
	if RandomChance(rarityChances[rarityName]) then
		return true
	end
	return false
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

	if args.AutoLoadPackages then
		if not GameData.MissingPackages[loot.Name] then
			LoadPackages({ Name = loot.Name, IgnoreAssert = true })
		end
		LoadPackages({ Name = loot.LoadPackages, IgnoreAssert = true })
		if loot.SpeakerName ~= nil then
			LoadVoiceBanks( loot.SpeakerName, false, true )
		end
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
		loot.BaseResourceCosts = ShallowCopyTable( loot.ResourceCosts )
		local costMultiplier = GetShopCostMultiplier()
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
		return SelectRoomRewardSpawnPoint( currentRoom, args )
	end

	return GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = currentRoom.SpawnPoints.Loot })
end

function SelectRoomRewardSpawnPoint( currentRoom, args )
	args = args or {}
	if currentRoom.SpawnRewardOnId and not args.IgnoreSpawnRewardOnId then
		return currentRoom.SpawnRewardOnId
	end

	local excludeId = nil
	if MapState.FamiliarUnit ~= nil then
		excludeId = MapState.FamiliarUnit.SpawnPointOccupiedId
	end
	local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints", ExcludeId = excludeId })
	if spawnPointId <= 0 then
		if currentRoom.SpawnPoints.Loot == nil or IsEmpty(currentRoom.SpawnPoints.Loot) then
			currentRoom.SpawnPoints.Loot = GetIdsByType({ Name = "LootPoint" })
		end
		spawnPointId = RemoveRandomValue(currentRoom.SpawnPoints.Loot) or -1
	end
	--DebugAssert({ Condition = spawnPointId > 0, Text = "No spawn point found for RoomReward!", Owner = "Eduardo" })
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

function UseableOnDelay( ids, delay )
	wait( delay, RoomThreadName )
	UseableOn({ Ids = ids })
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

	if objectState.SpawnInPlace ~= nil then
		SpawnObstacle({ Name = objectState.SpawnInPlace, DestinationId = id, Group = GetGroupName({ Id = id, DrawGroup = true }) })
	end

	if objectState.Destroyed and not object.SkipDestroy then
		SetThingProperty({ DestinationId = id, Property = "SuppressSounds", Value = true, DataValue = false })
		ActiveEnemies[id] = nil
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
	CurrentRun.CurrentRoom.HighValueBreakableIds = {}
	for index = 0, highValueLimit, 1 do
		local breakable = RemoveRandomValue( legalBreakables )
		if breakable == nil then
			return
		end
		local valueOptions = breakable.BreakableValueOptions
		for k, swapOption in ipairs( valueOptions ) do
			if swapOption.GameStateRequirements == nil or IsGameStateEligible( swapOption, swapOption.GameStateRequirements ) then
				if RandomChance( swapOption.Chance * chanceMultiplier ) then
					if swapOption.Animation ~= nil then
						SetAnimation({ DestinationId = breakable.ObjectId, Name = swapOption.Animation, OffsetY = swapOption.OffsetY or 0 })
					end
					table.insert( CurrentRun.CurrentRoom.HighValueBreakableIds, breakable.ObjectId )
					RecordObjectState( currentRoom, breakable.ObjectId, "Animation", swapOption.Animation )
					breakable.MoneyDropOnDeath = ShallowCopyTable( swapOption.MoneyDropOnDeath )
					RecordObjectState( currentRoom, breakable.ObjectId, "MoneyDropOnDeath", breakable.MoneyDropOnDeath )
					DebugPrint({ Text = "HandleBreakableSwap: an up-valued breakable spawned at Id "..breakable.ObjectId })
					OverwriteTableKeys(breakable, swapOption.DataOverrides)
					for k, v in pairs(swapOption.DataOverrides) do
						RecordObjectState( CurrentRun.CurrentRoom, breakable.ObjectId, k, v )
					end
					if breakable.BreakableValueOptions.SetupEvents ~= nil then
						RunEventsGeneric( breakable.BreakableValueOptions.SetupEvents, breakable )
					end
					break
				end
			end
		end
	end
end

function FindAllSwappableBreakables()
	local legalBreakables = { }
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if enemy.BreakableValueOptions ~= nil then
			legalBreakables[id] = enemy
		end
	end
	for id, obstacle in pairs( ShallowCopyTable( MapState.ActiveObstacles ) ) do
		if obstacle.BreakableValueOptions ~= nil then
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
	thread( UseMoneyDrop, moneyDrop, args )
	MoneyDropPresentation( moneyDrop, args )	
end

function UseMoneyDrop( moneyDrop, args )
	args = args or {}
	wait( args.PickupDelay or 1.2, "MoneyDropThread" )
	if CurrentRun.Hero.HeroTraitValuesCache.BlockMoney[1] == nil then
		AddResource( "Money", moneyDrop.Amount, moneyDrop.Source )
	end
	CreateAnimation({ Name = moneyDrop.ConsumeFx, DestinationId = moneyDrop.ObjectId })
	Destroy({ Id = moneyDrop.ObjectId })
end

function InstantUseMoneyDrops()
	SetThreadWait( "MoneyDropThread", 0.01 )
end

function ClearUpgrades( args )
	args = args or {}

	CurrentRun.Hero.Traits = {}
	CurrentRun.Hero.OnFireWeapons = {}
	CurrentRun.Hero.LastStands = {}
	CurrentRun.Hero.WeaponDataOverride = {}
	CurrentRun.Hero.ManaRegenSources = {}
	CurrentRun.SpellCharge = 0

	if CurrentRun.Hero.OutgoingDamageModifiers ~= nil then
		for i, modifier in ipairs( CurrentRun.Hero.OutgoingDamageModifiers ) do
			if modifier.Name and MetaUpgradeData[modifier.Name] == nil then
				CurrentRun.Hero.OutgoingDamageModifiers[i] = nil
			end
		end
		CurrentRun.Hero.OutgoingDamageModifiers = CollapseTable( CurrentRun.Hero.OutgoingDamageModifiers )
	end
	if CurrentRun.Hero.OutgoingCritModifiers ~= nil then
		for i, modifier in ipairs( CurrentRun.Hero.OutgoingCritModifiers ) do
			if modifier.Name and MetaUpgradeData[modifier.Name] == nil then
				CurrentRun.Hero.OutgoingCritModifiers[i] = nil
			end
		end
		CurrentRun.Hero.OutgoingCritModifiers = CollapseTable( CurrentRun.Hero.OutgoingCritModifiers )
	end
	for metaUpgradeName in pairs( CurrentRun.TemporaryMetaUpgrades ) do
		GameState.MetaUpgradeState[metaUpgradeName].Equipped = nil
	end
	
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if metaUpgradeData.Equipped and MetaUpgradeCardData[ metaUpgradeName ].TraitName and MetaUpgradeCardData[ metaUpgradeName ].ActiveWhileDead then
			AddTraitToHero({ 
				TraitName = MetaUpgradeCardData[ metaUpgradeName ].TraitName,
				Rarity = TraitRarityData.RarityUpgradeOrder[ GetMetaUpgradeLevel( metaUpgradeName )],})
		end
	end

	CurrentRun.Hero.PortraitOverrides = nil

	if args.ClearChipmunk then
		CurrentRun.Hero.SpeechParams.Chipmunk = nil
		SetAudioEffectState({ Name = "Chipmunk", Value = 0 })
	end

	if args.KeepFamiliarTraits and GameState.EquippedFamiliar ~= nil then
		local familiarData = FamiliarData[GameState.EquippedFamiliar]
		if familiarData ~= nil then
			for _, traitName in ipairs( familiarData.TraitNames ) do
				AddTraitToHero({ TraitName = traitName })
			end
		end
	end
end

function SetupHeroForEnding()
	CurrentRun.Hero.PreDeathTraits = CurrentRun.Hero.Traits
	ClearUpgrades( { KeepFamiliarTraits = true, ClearChipmunk = true } )
	CurrentRun.Hero.Health = CurrentRun.Hero.MaxHealth
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
		if args.NoHealing then
			MaxHealthIncreaseText({ MaxHealthGained = CurrentRun.Hero.MaxHealth - startingHealth , SpecialText = "EmptyMaxHealthIncrease" })
		else
		MaxHealthIncreaseText({ MaxHealthGained = CurrentRun.Hero.MaxHealth - startingHealth , SpecialText = "MaxHealthIncrease" })
		thread( UpdateHealthUI, { FalloffDelay = 0.0 } )
	end
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
	manaTraitData.Source = args.Source
	AddTraitToHero({ TraitData = manaTraitData })
	if not( args.Silent ) then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "MaxManaIncrease", PreDelay = args.PreDelay or 0, Duration = 0.7, LuaKey = "TooltipData", ShadowScale = 0.7, OffsetY = -100, LuaValue = { TooltipMana = manaGained }})
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
		traitData.SetupFunction.Args.Silent = args.Silent
		AddTraitToHero({ TraitData = traitData })
	else
		local traitData = GetHeroTrait(traitName)
		traitData.CurrentArmor = traitData.CurrentArmor + armorGained
		AddHealthBuffer( traitData.CurrentArmor, traitData.Name, { Silent = true } )	
		thread(OnPlayerArmorGain, { Amount = armorGained,  Silent = args.Silent } )
		FrameState.RequestUpdateHealthUI = true
	end
end

function StartEncounterEffects( encounter )
	encounter = encounter or CurrentRun.CurrentRoom.Encounter
	encounter.StartTime = CurrentRun.GameplayTime
	CurrentRun.Hero.HitShields = 0
	SessionMapState.SpellUsed = nil
	
	if not IsEmpty(SessionMapState.SkipEncounterIds) and not encounter.SpawnsSkipped then
		thread( SkipEncounterEndPresentation )
	end

	if MapState.FamiliarUnit ~= nil then
		ReenableFamiliar( MapState.FamiliarUnit )
		RunEventsGeneric( MapState.FamiliarUnit.EncounterStartEvents, MapState.FamiliarUnit )
	end
	notifyExistingWaiters("EncounterStart")
	for i, traitData in pairs( CurrentRun.Hero.Traits) do
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
		if traitData.OnEncounterStartFunction then
			thread( CallFunctionName, traitData.OnEncounterStartFunction.Name, CurrentRun.Hero, traitData.OnEncounterStartFunction.Args )
		end
		if traitData.SetupFunction and traitData.SetupFunction.RepeatOnEncounterStart then
			thread( CallFunctionName, traitData.SetupFunction.Name, CurrentRun.Hero, traitData.SetupFunction.Args )
		end
		if IsTraitActive(traitData) and traitData.UniqueEncounterArgs and IsGameStateEligible( traitData, traitData.UniqueEncounterArgs.GameStateRequirements) then
			thread( CallFunctionName, traitData.UniqueEncounterArgs.EncounterThreadedFunctions.FunctionName, encounter, traitData.UniqueEncounterArgs.EncounterThreadedFunctions.Args )
		end
			

		if encounter.EncounterType == "Boss" and not encounter.SkipBossTraits then
			if traitData.BossEncounterShieldHits then
				MapState.BossShieldTriggers = traitData.BossEncounterShieldHits
				MapState.BossShieldFx = traitData.BossShieldFx
				if MapState.BossShieldFx then
					CreateAnimation({ Name = traitData.BossShieldFx, DestinationId = CurrentRun.Hero.ObjectId })
				end
			end
		end
	end

	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if not encounter.SkipBossTraits and traitData.EncounterPreDamage and IsTraitActive(traitData) then
			local validEnemy = false
			local damageData = traitData.EncounterPreDamage
			if damageData.EnemyType == "Boss" or Contains(damageData.ValidRooms, CurrentRun.CurrentRoom.Name) then
				for unitId, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
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
		if traitData.RepeatSpawnEffectOnBoss and traitData.OnEnemySpawnFunction then
			for unitId, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
				if  unit.IsBoss then
					thread(CallFunctionName, traitData.OnEnemySpawnFunction.FunctionName, unit, traitData.OnEnemySpawnFunction.Args, true)
				end
			end
		end
	end
end

function EndEncounterEffects( currentRun, currentRoom, currentEncounter )
	if currentEncounter == nil or currentEncounter.EncounterType == "NonCombat" or currentEncounter.SkipEndEncounterEffects then
		return
	end
	if SessionMapState.LaserSpellDown then
		LaserHoldClear()
	end
	UpdateHeroTraitDictionary()
	if currentRoom.DestroyAssistUnitOnEncounterEndId and not currentEncounter.SkipCleanupRaiseDead then
		thread( CleanupRaiseDeadEncounter, currentRoom )
	end
	
	if SessionMapState.ManaUrnIds ~= nil then
		for id in pairs( SessionMapState.ManaUrnIds ) do
			if ActiveEnemies[id] then
				thread( Kill, ActiveEnemies[id], { SkipOnDeathFunction = true } )
			end
		end
	end

	if currentEncounter == currentRoom.Encounter or currentEncounter == currentRoom.ChallengeEncounter or currentEncounter == MapState.EncounterOverride then
		ClearEffect({ Id = currentRun.Hero.ObjectId, Name = "KillDamageBonus"})
		MapState.ExCastCount = 0

		if SessionMapState.SpellDodge then
			SetLifeProperty({ Property = "DodgeChance", Value = -GetTotalHeroTraitValue("HexUsedDodgeBuff"), ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
		end

		if SessionMapState.SpellSpeed then
			local totalMoveSpeedChange = GetTotalHeroTraitValue( "HexUsedMoveSpeedBuff", {IsMultiplier = true })
			if not IsEmpty(MapState.HexMoveSpeedPropertyChanges) and totalMoveSpeedChange ~= 1 then
				ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.HexMoveSpeedPropertyChanges, true, true)
			end
		end

		if currentRoom.DestroyAssistProjectilesOnEncounterEnd then
			ExpireProjectiles({ Name = currentRoom.DestroyAssistProjectilesOnEncounterEnd })
		end

		for chapterName, chapterData in pairs( CodexData ) do
			for entryName, entryData in pairs( chapterData.Entries ) do
				CheckCodexUnlock( chapterName, entryName, { DeferShowUpdate = true, SkipEntriesUnlockedCacheUpdate = true } )
			end
		end
		GameState.CodexEntriesUnlockedCache = CalcNumCodexEntriesUnlocked()

		if MapState.PendingCodexUpdate then
			MapState.PendingCodexUpdate = false
			wait( 0.2, RoomThreadName )
			thread( ShowCodexUpdate )
			thread( CheckQuestStatus )
		end

		if MapState.FamiliarUnit ~= nil then
			RunEventsGeneric( MapState.FamiliarUnit.EncounterEndEvents, MapState.FamiliarUnit )
		end
	end

	if currentEncounter == currentRoom.Encounter or currentEncounter == MapState.EncounterOverride then
		local heroHealth = CurrentRun.Hero.Health
		local traitsToRemove = {}
		for k, trait in ipairs( CurrentRun.Hero.Traits ) do
			if trait.EncounterEndFunctionName ~= nil then
				thread( CallFunctionName, trait.EncounterEndFunctionName, trait, trait.EncounterEndFunctionArgs )
			end
			if currentRun.CurrentRoom.Encounter.EncounterType == "Boss" and not currentRun.CurrentRoom.Encounter.SkipBossTraits then
				if trait.BossEncounterShieldHits and trait.BossShieldFx then
					StopAnimation({ Name = trait.BossShieldFx, DestinationId = CurrentRun.Hero, IncludeCreatedAnimations = true })
					UpdateTraitNumber( trait )
				end
				if trait.UsesAsBosses then
					trait.RemainingUses = trait.RemainingUses - 1
					if trait.RemainingUses <= 0 then
						table.insert( traitsToRemove, trait )
					end
					TraitUIUpdateText( trait )
				end
				if trait.Name == "LowHealthCritKeepsake" and IsTraitActive( trait ) then
					trait.CustomName = trait.ZeroBonusTrayText
					ReduceTraitUses( trait, { Force = true })

					-- Usually we'd just remove the trait but keepsakes should stay equipped, hence...this.
					trait.MaxHealthMultiplier = 1
					trait.CapMaxHealth = -1
					if trait.PropertyChanges and trait.PropertyChanges[1] then
						ApplyUnitPropertyChange( CurrentRun.Hero, trait.PropertyChanges[1], true, true)
						trait.PropertyChanges[1].ChangeValue = 1
					end
					ValidateMaxHealth()
					FrameState.RequestUpdateHealthUI = true
					if not currentEncounter or not currentEncounter.BlockPostBossKeepsakeExpiration then
						thread( LowHealthCritKeepsakeExpiredPresentation, trait )
					end
				end
			end
			if not currentRoom.IgnoreEncounterUses and trait.RemainingUses ~= nil and trait.UsesAsEncounters and (not trait.UsesRequireSpawnMultiplier or ( trait.UsesRequireSpawnMultiplier and not currentEncounter.BlockSpawnMultipliers )) then
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
		if not currentRoom.SkipRoomsPerUpgrade then
			for k, traitData in ipairs( CurrentRun.Hero.Traits ) do
				if traitData.CurrentKeepsakeDamageBonus and traitData.CurrentKeepsakeDamageBonus > 1 then
					traitData.CurrentKeepsakeDamageBonus = traitData.CurrentKeepsakeDamageBonus - traitData.DecayRate
					if traitData.CurrentKeepsakeDamageBonus <= 1 then
						traitData.CustomTrayText = traitData.ZeroBonusTrayText
						traitData.CurrentKeepsakeDamageBonus = 1
						ReduceTraitUses( traitData, { Force = true })
						thread( DecayingBoostKeepsakeExpiredPresentation )
					end
				end
				if traitData.EscalatingKeepsakeValue then
					traitData.EscalatingKeepsakeValue = traitData.EscalatingKeepsakeValue + traitData.EscalatingKeepsakeGrowthPerRoom
				end
				if traitData.EscalatingCostumeValue then
					traitData.EscalatingCostumeValue = traitData.EscalatingCostumeValue + traitData.EscalatingCostumeValueGrowthPerRoom
				end
			end
		end

		for k, trait in pairs( traitsToRemove ) do
			RemoveTraitData( currentRun.Hero, trait )
		end
		AdvanceKeepsake()
		if not currentRoom.SkipRoomsPerUpgrade then
			CheckChamberTraits()
		end
		EncounterEndPresentation()
		
		if MapState.TransformArgs then
			EndSpellTransform()
		end
		
		MapState.UsedBlockDeath = nil
		MapState.EncounterOverride = nil
	end
end

function IsEncounterActiveCombat( encounter, args )
	local encounterData = EncounterData[encounter.Name] or encounter
	local ignoreDelayedStart = false
	if args.CheckBlockCodexBeforeStart then
		ignoreDelayedStart = encounterData.BlockCodexBeforeStart
	end

	if encounter.EncounterType == "NonCombat" then
		return false
	end
	if not encounter.InProgress then
		return false
	end
	if encounter.DelayedStart and not encounter.StartTime and not ignoreDelayedStart then
		return false
	end
	if encounter.Completed then
		return false
	end
	return true
end

function IsCombatEncounterActive( currentRun, args  )
	args = args or {}
	if currentRun.CurrentRoom == nil then
		return false
	end
	if currentRun.CurrentRoom.AlwaysInCombat then
		return true
	end
	if currentRun.Hero.IsDead then
		return false
	end

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

	local mainEncounter = currentRun.CurrentRoom.Encounter
	if mainEncounter ~= nil and not args.IgnoreMainEncounter then
		if IsEncounterActiveCombat( mainEncounter, args ) then
			return true
		end
	end

	for i, encounter in ipairs( currentRun.CurrentRoom.ActiveEncounters ) do
		if encounter ~= mainEncounter and IsEncounterActiveCombat( encounter, args ) then
			return true
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

	for screenName, screen in pairs( ActiveScreens ) do
		if screen.BlockExitsReady then
			DebugPrint({ Text = "Exit Blocked By: "..screen.Name })
			return false
		end
	end

	for k, encounter in ipairs( currentRoom.ActiveEncounters ) do
		if not encounter.ExitsDontRequireCompleted and not encounter.Completed then
			DebugPrint({ Text = "Exit Blocked By: "..encounter.Name.." Not Completed" })
			return false
		end
	end

	if currentRoom.MultipleEncountersData ~= nil and TableLength( currentRoom.MultipleEncountersData ) > 1 and not currentRoom.AllEncountersCompleted then
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

	if unit.GrannyTexture ~= nil then
		SetThingProperty({ Property = "GrannyTexture", Value = unit.GrannyTexture, DestinationId = unit.ObjectId })
	end

	if unit.GrannyAttachmentTexture ~= nil then
		SetThingProperty({ Property = "GrannyTexture", AttachmentMeshName = unit.GrannyAttachmentTexture.MeshName, Value = unit.GrannyAttachmentTexture.GrannyTexture, DestinationId = unit.ObjectId })
	end
		
	unit.ExpireProjectileIdsOnHitStun = {}
	unit.ExpireProjectileIdsOnFreeze = {}
	unit.ExpireProjectileIdsOnPolymorph = {}
	unit.ClearEffectsOnHitStun = {}
	unit.StopAnimationsOnHitStun = {}
	unit.StopSoundsOnHitStun = {}
	unit.DamageRadiusIdsByHealthPercent = {}
	unit.ActiveInputBlocks = {}
	unit.ActiveEffects = {}
	unit.ActiveEffectsAtDamageStart = {}
	unit.QueuedDamageMultipliers = {}
	unit.CreatedDisplayAnchors = {}
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
		local eliteAttributes = currentRoom.EliteAttributes[unit.Name]
		if unit.Encounter ~= nil and unit.Encounter.EliteAttributes ~= nil and unit.Encounter.EliteAttributes[unit.Name] ~= nil then
			eliteAttributes = unit.Encounter.EliteAttributes[unit.Name]
		end
		if eliteAttributes ~= nil then
			for k, attributeName in pairs(eliteAttributes) do
				ApplyEliteAttribute( unit, attributeName )
			end
		end
	end

	if unit.SpawnAngle ~= nil then
		SetAngle({ Id = unit.ObjectId, Angle = unit.SpawnAngle })
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

	unit.HitShields = 0
	unit.SpeedMultiplier = 1
	if unit.UseShrineUpgrades and not args.IgnoreShrineUpgrades then
		if not unit.IgnoreShieldShrine then
			unit.HitShields = GetNumShrineUpgrades( "EnemyShieldShrineUpgrade" )
		end
		if not unit.IgnoreSpeedShrine then
			local speedMultiplier = (MetaUpgradeData.EnemySpeedShrineUpgrade.ChangeValue - 1.0) + (unit.EliteAdditionalSpeedMultiplier or 0)
			--DebugPrint({ Text = "speedMultiplier = "..speedMultiplier })
			if speedMultiplier > 0.0 then		
				unit.SpeedMultiplier = unit.SpeedMultiplier + speedMultiplier
				--DebugPrint({ Text = "unit.SpeedMultiplier = "..unit.SpeedMultiplier })
				if unit.AIThreadName then
					SetElapsedTimeMultiplier( (unit.SpeedMultiplier + speedMultiplier) / unit.SpeedMultiplier, unit.AIThreadName )
				end
			end
		end
	end
	--DebugPrint({ Text = "unit.SpeedMultiplier = "..tostring(unit.SpeedMultiplier) })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = unit.SpeedMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationId = unit.ObjectId })

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
		local healthBufferBonus = unit.HealthBufferBonus or 0
		unit.HealthBuffer = unit.HealthBuffer + healthBufferBonus
		DoEnemyHealthBuffered( unit )
	end

	if unit.Phases ~= nil then
		unit.CurrentPhase = 1
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

	if not args.SkipPresentation then
		thread( PlayVoiceLines, args.OnSpawnVoiceLines or unit.OnSpawnVoiceLines, nil, unit )
	end

	if not args.IgnorePackages then
		if unit.SpeakerName ~= nil then
			LoadVoiceBanks( unit.SpeakerName, nil, args.IgnoreAssert )
			if CurrentHubRoom == nil and unit.FieldSpeakerName ~= nil then
				LoadVoiceBanks( unit.FieldSpeakerName, nil, args.IgnoreAssert )
			end
		end
		if unit.LoadPackages ~= nil then
			LoadPackages({ Names = unit.LoadPackages, IgnoreAssert = args.IgnoreAssert })
		end
	end

	if not unit.SkipAISetupOnActivate and not args.SkipAISetup then
		SetupAI( unit )
	end

	if unit.SetupGroupAI and unit.UnitGroupData ~= nil then
		thread(CallFunctionName, unit.UnitGroupData.GroupAI, unit)
	end

	if unit.SpawnEvents ~= nil then
		RunEventsGeneric( unit.SpawnEvents, unit, args )
	end

	if CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.Encounter ~= nil then
		local encounterData = EncounterData[CurrentRun.CurrentRoom.Encounter.Name] or CurrentRun.CurrentRoom.Encounter
		if encounterData.OnSpawnFunctionName ~= nil then
			CallFunctionName( encounterData.OnSpawnFunctionName, unit, CurrentRun.CurrentRoom.Encounter )
		end
	end

	CreateLevelDisplay( unit, CurrentRun )

	if unit.IgnoreTimeSlowEffects then
		AddEffectBlock({ Id = unit.ObjectId, Name = "LegacyChillEffect" })	
	end
	if unit.EffectBlocks then
		for _, effectName in ipairs( unit.EffectBlocks ) do
			AddEffectBlock({ Id = unit.ObjectId, Name = effectName })
		end
	end
end

function ApplyEnemyModifiers(unit, currentRun, args )
	-- for enemy on spawn traits
	for i, traitData in pairs( GetHeroTraitValues("OnEnemySpawnFunction")) do
		if traitData.Chance == nil or RandomChance(traitData.Chance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
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
		local wakeThreadName = "AIWakeDelay"..enemy.ObjectId
		SessionMapState.EnemySpawnDelays[wakeThreadName] = true
		wait(enemy.AIWakeDelay, wakeThreadName)
		SessionMapState.EnemySpawnDelays[wakeThreadName] = nil
	end

	if enemy.AIStages ~= nil then
		enemy.AIThreadName = "AIThread_"..enemy.Name.."_"..enemy.ObjectId
		thread( StagedAI, enemy )
		return
	end

	if enemy.PreAISetupFunctionName ~= nil then
		CallFunctionName(enemy.PreAISetupFunctionName, enemy)
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
		for k, weaponName in pairs( enemy.DumbFireWeapons ) do
			thread( DumbFireAttack, enemy, weaponName )
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
			local partnerUnit = CheckPartnerConversations( source )
			if partnerUnit ~= nil then
				-- Fill in the stub except for the lines themselves
				if source.NextInteractLines.CopyDataFromPartner then
					for i, key in ipairs( PartnerConversationDataShare ) do
						if source.NextInteractLines[key] == nil then
							source.NextInteractLines[key] = partnerUnit.NextInteractLines[key]
						end
					end
				end
			end
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
		if CurrentHubRoom == nil or CurrentHubRoom.Name == GameData.HubMapName then
			DebugAssert({ Condition = IdExists({ Id = textLines.TeleportToId }), Text = source.Name.." is being teleported to a non-existent id: "..textLines.TeleportToId, Owner = "Greg" })
		end
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
			if onQueuedFunctionData.GameStateRequirements == nil or IsGameStateEligible( source, onQueuedFunctionData.GameStateRequirements ) then
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
			if onQueuedFunctionData.Args and onQueuedFunctionData.Args.StatusAnimation and ( onQueuedFunctionData.GameStateRequirements == nil or IsGameStateEligible( source, onQueuedFunctionData.GameStateRequirements ) ) then
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
		CheckAvailableTextLines( unit, args )
		SetAvailableUseText( unit, args )
		
	end
	for id, unit in ipairs( sortedUnits ) do
		if unit.NextInteractLines == nil and not unit.InPartnerConversation and args.CheckNoConversationFunctions and unit.NoConversationFunctions ~= nil then
			for k, functionEntry in ipairs( unit.NoConversationFunctions ) do
				if functionEntry.GameStateRequirements == nil or IsGameStateEligible( unit, functionEntry.GameStateRequirements ) then
					CallFunctionName( functionEntry.Name, unit, functionEntry.Args )
				end
			end
		end
	end
end

function CalcTotalSpawns( currentRun, currentRoom, currentEncounter, spawnInfo )

	if spawnInfo.RequiredMiniBossShrine ~= nil and ( GetNumShrineUpgrades( "MinibossCountShrineUpgrade" ) <= 0 ) == spawnInfo.RequiredMiniBossShrine then
		spawnInfo.InfiniteSpawns = false
		return 0
	end

	if spawnInfo.InfiniteSpawns then
		return 1
	end

	if spawnInfo.TotalCount == nil and (spawnInfo.CountMin == nil or spawnInfo.CountMax == nil) then
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

	if CheckPackagedBountyCompletion() then
		return
	end

	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.PreExitsUnlockedFunctionName ~= nil then
			CallFunctionName( trait.PreExitsUnlockedFunctionName, trait, trait.PreExitsUnlockedFunctionArgs )
		end
	end

	if IsEmpty( MapState.OfferedExitDoors ) then
		return
	end

	local roomData = RoomData[room.Name]
	local encounterData = nil
	if room.Encounter ~= nil then
		encounterData = EncounterData[room.Encounter.Name] or room.Encounter
	end

	-- Must wait for post-reward presentation to complete
	local defaultWait = 0.4
	if GameState.ClearedRunsCache >= 1 then
		defaultWait = 0.2
	end
	wait( delay or roomData.UnlockExitsWait or defaultWait )
	InstantUseMoneyDrops()
	wait( 0.03 )

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
	--DebugPrint({ Text = "TargetMetaRewardsRatio = "..TargetMetaRewardsRatio })
	local minorRunProgressChance = targetMetaRewardsRatio 
	local currentMetaRunProgressRatio = CalcMetaProgressRatio( run )
	if currentMetaRunProgressRatio ~= nil then
		minorRunProgressChance = minorRunProgressChance + (run.Hero.TargetMetaRewardsAdjustSpeed * (targetMetaRewardsRatio - currentMetaRunProgressRatio))
	end
	--DebugPrint({ Text = "minorRunProgressChance = "..minorRunProgressChance })
	if RandomChance( minorRunProgressChance ) then
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
			door.Room = ShallowCopyTable( run.RoomHistory[room.DoorRoomHistory[door.ObjectId]] )
			-- Restore any missing data that may have been stripped for saving
			local originalRoomData = RoomData[door.Room.Name]
			if originalRoomData ~= nil then
				for roomKey, roomValue in pairs( originalRoomData ) do
					if door.Room[roomKey] == nil then
						door.Room[roomKey] = roomValue
					end
				end
			end
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
			local roomForDoor = CreateRoom( roomForDoorData, { SkipChooseReward = true, SkipChooseEncounter = true, RoomOverrides = room.NextRoomOverrides })
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
			thread( CallFunctionName, door.PreExitsUnlockedFunctionName, door, door.PreExitsUnlockedFunctionArgs, index )
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

	MapState.OfferedRewards = {}
	for i, doorData in pairs( MapState.OfferedExitDoors ) do
		if doorData and doorData.Room then
			local room = doorData.Room
			if room.CageRewards then
				for _, cageReward in pairs(room.CageRewards) do
					if cageReward.RewardType then
						MapState.OfferedRewards[cageReward.RewardType] = true
					end
				end
			end
			if room.ChosenRewardType then
				MapState.OfferedRewards[room.ChosenRewardType] = true
			end
		end
	end

	for id, obstacle in pairs( ShallowCopyTable( MapState.ActiveObstacles ) ) do
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
		if challengeSwitch.UnlockedFxAnimationName ~= nil then
			CreateAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.UnlockedFxAnimationName })
		end
		PlaySound({ Name = "/SFX/ChallengeChestUnlocked", Id = challengeSwitch.ObjectId })
	end
	
	if CurrentRun.CurrentRoom.WellShop ~= nil then
		CurrentRun.CurrentRoom.WellShop.ReadyToUse = true
		CurrentRun.CurrentRoom.WellShop.UseText = CurrentRun.CurrentRoom.WellShop.AvailableUseText
		RefreshUseButton( CurrentRun.CurrentRoom.WellShop.ObjectId, CurrentRun.CurrentRoom.WellShop )
		SetAnimation({ Name = "WellShopUnlocked", DestinationId = CurrentRun.CurrentRoom.WellShop.ObjectId })
		PlaySound({ Name = "/SFX/WellShopUnlocked", Id = CurrentRun.CurrentRoom.WellShop.ObjectId })
	end

	if CurrentRun.CurrentRoom.SellTraitShop ~= nil and not CurrentRun.CurrentRoom.SellTraitShop.BlockedByRequirements then
		CurrentRun.CurrentRoom.SellTraitShop.ReadyToUse = true
		CurrentRun.CurrentRoom.SellTraitShop.UseText = CurrentRun.CurrentRoom.SellTraitShop.AvailableUseText
		RefreshUseButton( CurrentRun.CurrentRoom.SellTraitShop.ObjectId, CurrentRun.CurrentRoom.SellTraitShop )
		SetAnimation({ Name = "SellTraitShopUnlocked", DestinationId = CurrentRun.CurrentRoom.SellTraitShop.ObjectId })
		PlaySound({ Name = "/SFX/WellShopUnlocked", Id = CurrentRun.CurrentRoom.SellTraitShop.ObjectId })
	end

	if CurrentRun.CurrentRoom.SurfaceShop ~= nil then
		CurrentRun.CurrentRoom.SurfaceShop.ReadyToUse = true
		CurrentRun.CurrentRoom.SurfaceShop.UseText = CurrentRun.CurrentRoom.SurfaceShop.AvailableUseText
		RefreshUseButton( CurrentRun.CurrentRoom.SurfaceShop.ObjectId, CurrentRun.CurrentRoom.SurfaceShop )
		SetAnimation({ Name = "SurfaceShopUnlocked", DestinationId = CurrentRun.CurrentRoom.SurfaceShop.ObjectId })
		PlaySound({ Name = "/SFX/Menu Sounds/KeepsakeHermesFastClear2", Id = CurrentRun.CurrentRoom.SurfaceShop.ObjectId })
	end

	if CurrentRun.CurrentRoom.MetaRewardStand ~= nil then
		if GameState.SpentShrinePointsCache >= CurrentRun.CurrentRoom.MetaRewardStand.RequiredShrinePoints then
			CurrentRun.CurrentRoom.MetaRewardStand.ReadyToUse = true
			CurrentRun.CurrentRoom.MetaRewardStand.UseText = CurrentRun.CurrentRoom.MetaRewardStand.AvailableUseText
			RefreshUseButton( CurrentRun.CurrentRoom.MetaRewardStand.ObjectId, CurrentRun.CurrentRoom.MetaRewardStand )
			StopAnimation({ Name = "MetaRewardStandLockedFx", DestinationId = CurrentRun.CurrentRoom.MetaRewardStand.ObjectId })
			SetAnimation({ Name = "MetaRewardStandUnlocked", DestinationId = CurrentRun.CurrentRoom.MetaRewardStand.ObjectId })
			PlaySound({ Name = "/SFX/WellShopUnlocked", Id = CurrentRun.CurrentRoom.MetaRewardStand.ObjectId })
		end
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
	if room.ForceDoorAllowReroll then
		door.AllowReroll = true
	end
	if RoomData[CurrentRun.CurrentRoom.Name].ForceCurrentRoomDoorsAllowReroll then
		door.AllowReroll = true
	end
	if door.AllowReroll and not room.NoReroll and CheckSpecialDoorRequirement( door ) == nil and room.ChosenRewardType ~= "Shop" and HasHeroTraitValue( "AllowDoorReroll" ) then
		door.CanBeRerolled = true
		if door == SessionMapState.ActiveUseTarget and CurrentRun.NumRerolls > 0 then
			AddControlBlock( "Shout", "ActiveUseTarget" )
		end
	end
	RefreshUseButton( door.ObjectId, door )

end

function CheckExitPreUnlock( door, args, doorIndex )

	RandomSynchronize( doorIndex )

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
	CurrentRun.CurrentRoom.Leaving = true
	local nextRoom = door.Room
	local currentRoomData = RoomData[CurrentRun.CurrentRoom.Name]
	if CurrentRun.CurrentRoom.TempHealth then
		Damage( CurrentRun.Hero, { SourceWeapon = "TempHealth", DamageAmount = CurrentRun.CurrentRoom.TempHealth, MinHealth = 1, PureDamage = true, Silent = true } )
	end
	for sourceName in pairs(MapState.TemporaryHealthBufferSources) do
		if HeroHasTrait( sourceName ) then	
			local trait = GetHeroTrait(sourceName)
			trait.CurrentArmor = 0
		end
		RemoveHealthBufferSource(sourceName)
	end
	if MapState.FamiliarUnit ~= nil then
		MapState.FamiliarUnit.DisableAIWhenReady = true
	end

	CurrentRun.NextHeroStartPoint = CurrentRun.CurrentRoom.NextHeroStartPoint or CurrentRun.NextHeroStartPoint
	CurrentRun.NextHeroEndPoint = CurrentRun.CurrentRoom.NextHeroEndPoint or CurrentRun.NextHeroEndPoint

	ClearHealthReserve()
	ClearEffect({ Id = currentRun.Hero.ObjectId, All = true, BlockAll = true, })
	StopCurrentStatusAnimation( currentRun.Hero )
	currentRun.Hero.BlockStatusAnimations = true
	AddTimerBlock( currentRun, "LeaveRoom" )
	SetPlayerInvulnerable( "LeaveRoom" )
	EndSpellTransform()
	InstantUseMoneyDrops()
	if GameState.WorldUpgrades.WorldUpgradeAutoHarvestOnExit then
		AutoHarvestOnExit()
	end
	SetThreadWait( "GrantElementFromTool", 0.01 )

	ClearGameplayElapsedTimeMultipliers()

	local ammoIds = GetIdsByType({ Name = "LobAmmoPack" })
	SetObstacleProperty({ Property = "Magnetism", Value = 3000, DestinationIds = ammoIds })
	SetObstacleProperty({ Property = "MagnetismSpeedMax", Value = 2000, DestinationIds = ammoIds })
	for i, ammoId in ipairs( ammoIds ) do
		StopAnimation({ DestinationId = ammoId, Name = "AmmoReturnTimer" })
	end

	RunEventsGeneric( currentRun.CurrentRoom.LeaveEvents, currentRun.CurrentRoom )
	if MapState.FamiliarUnit ~= nil then
		RunEventsGeneric( MapState.FamiliarUnit.LeaveEvents, MapState.FamiliarUnit )
	end

	if not CurrentRun.RoomsEntered[nextRoom.Name] and not nextRoom.SkipGamePhaseTick then
		GamePhaseTick()
	end

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
	elseif HasHeroTraitValue("DoorHealReserve") then
		thread( CallFunctionName, "CheckDoorHealTrait", currentRun, door, true )
	end
	local removedTraits = {}
	for _, trait in ipairs( CurrentRun.Hero.Traits ) do
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
		RemoveAllBiomeStateTraits()
	elseif currentRoomData.PauseBiomeState 
		and not nextRoom.PauseBiomeState 
		and CurrentRun.BiomeStateName 
		and BiomeStateData.BiomeStates[CurrentRun.BiomeStateName] 
		and BiomeStateData.BiomeStates[CurrentRun.BiomeStateName].TraitName 
		and not HeroHasTrait(BiomeStateData.BiomeStates[CurrentRun.BiomeStateName].TraitName) then
		
		AddTraitToHero( { TraitName = BiomeStateData.BiomeStates[CurrentRun.BiomeStateName].TraitName, SkipUIUpdate = true, SkipPriorityTray = true, SkipSetup = true } )	
	end

	local heroExitPointId = GetClosest({ Id = door.ObjectId, DestinationIds = GetIdsByType({ Name = "HeroExit" }) })
	local angleToExit = GetAngleBetween({ Id = door.ObjectId, DestinationId = heroExitPointId })
	if currentRoomData.IgnoreExitDirection then
		-- Do nothing
	elseif currentRoomData.CardinalEntranceDirection then
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

	if not IsEmpty( SessionMapState.TimedBuffStartTimes ) then
		nextRoom.TimedBuffStartTimes = ShallowCopyTable(SessionMapState.TimedBuffStartTimes)
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

	if SessionMapState.SkipEncounterIds ~= nil then
		Unattach({ Id = SessionMapState.SkipEncounterIds[1], DestinationId = CurrentRun.Hero.ObjectId })
	end

	CallFunctionName( exitFunctionName, currentRun, door, exitFunctionArgs )
	if currentRoomData.LeavePostPresentationEvents ~= nil then
		RunEventsGeneric( currentRoomData.LeavePostPresentationEvents, currentRun.CurrentRoom, { NextRoom = nextRoom } )
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
	if currentRun.CurrentRoom.Encounter ~= nil and currentRun.CurrentRoom.Encounter.TimerBlock ~= nil then
		RemoveTimerBlock( currentRun, currentRun.CurrentRoom.Encounter.TimerBlock )
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

	UnloadPackages({ Names = PortraitPackages })

	RemoveInputBlock({ Name = "MoveHeroToRoomPosition" })
	RemoveInputBlock({ Name = "LastKill" })
	AddInputBlock({ Name = "MapLoad" })
	AddTimerBlock( CurrentRun, "MapLoad" )

	door.InUse = false
	nextRoom.TimesVisited = nextRoom.TimesVisited + 1

	LoadMap({ Name = nextRoom.Name, ResetBinks = previousRoom.ResetBinksOnExit or currentRun.CurrentRoom.ResetBinksOnEnter, LoadBackgroundColor = door.LoadBackgroundColor or currentRun.CurrentRoom.LoadBackgroundColor })

end

function SetupRoomMultipleEncountersData(room, args)
	room.Encounters = {}
	args = args or {}
	for i = 1, #room.MultipleEncountersData do
		local multipleEncounterData = room.MultipleEncountersData[i]
		if multipleEncounterData.GameStateRequirements == nil or IsGameStateEligible( multipleEncounterData, multipleEncounterData.GameStateRequirements ) or (multipleEncounterData.ForceRequirements ~= nil and IsGameStateEligible( multipleEncounterData, multipleEncounterData.ForceRequirements )) then
			table.insert(room.Encounters, ChooseEncounter( CurrentRun, room, multipleEncounterData ))
			room.Encounters[#room.Encounters].RoomChanges = room.MultipleEncountersData[i].RoomChanges
			RecordEncounter( CurrentRun, room.Encounters[#room.Encounters] )

			if TableLength(room.Encounters) >  1 then
				room.Encounters[#room.Encounters].SkipEncounterStart = true
				if room.Encounters[#room.Encounters].CanEncounterSkipIfNotFirst ~= nil then
					room.Encounters[#room.Encounters].CanEncounterSkip = room.Encounters[#room.Encounters].CanEncounterSkipIfNotFirst
				end
			end

			if room.Encounters[#room.Encounters].BlockMultipleEncounters then
				break
			end
		elseif multipleEncounterData.ContinueIfInelligible then
			-- Continue
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
			if setupFunctionEntry.GameStateRequirements == nil or IsGameStateEligible( source, setupFunctionEntry.GameStateRequirements ) then
				CallFunctionName( setupFunctionEntry.Name, args, setupFunctionEntry.Args )
			end
		end
	end
	thread( CheckDistanceTrigger, args, source )
end

function DistanceTrigger( source, args )
	
	local triggerId = args.Id or source.ObjectId
	local sourceName = source.Name or ""
	local triggerName = args.TriggerName or "DistanceTrigger"..sourceName
	if triggerId ~= nil then
		triggerName = triggerName..triggerId
	end

	if args.PreTriggerEvents ~= nil then
		RunEventsGeneric( args.PreTriggerEvents, source, args )
	end

	local triggeredOnce = false
	while not triggeredOnce or args.Repeat do

		triggeredOnce = true

		args.NotifiedById = 0
		if args.OutsideDistance ~= nil then
			local notifyName = args.NotifyName or "OutsideDistance"..triggerName
			NotifyOutsideDistanceAll({ Id = CurrentRun.Hero.ObjectId, DestinationId = triggerId, DestinationNames = args.TriggerGroups, Distance = args.OutsideDistance, ScaleY = args.ScaleY, Notify = notifyName })
			waitUntil( notifyName )
			args.NotifiedById = NotifyResultsTable[notifyName]
		end

		if args.WithinDistance ~= nil then
			local notifyName = args.NotifyName or "WithinDistance"..triggerName
			NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { triggerId }, DestinationNames = args.TriggerGroups, Distance = args.WithinDistance, ScaleY = args.ScaleY, Notify = notifyName })
			waitUntil( notifyName )
			args.NotifiedById = NotifyResultsTable[notifyName]
		end
		args.NotifiedById = args.NotifiedById or 0

		CurrentRun.TriggerRecord[triggerName] = (CurrentRun.TriggerRecord[triggerName] or 0) + 1
		--GameState.TriggerRecord[triggerName] = (GameState.TriggerRecord[triggerName] or 0) + 1 -- Unused, wasting save space

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

	if not IsDistanceTriggerEligible( currentRun, trigger, trigger.GameStateRequirements ) then
		return
	end

	wait( trigger.PreTriggerWait )

	--DebugAssert({ Condition = ( currentRun.Hero.ObjectId ~= nil ), Text = "Hero.ObjectId is nil when setting up distance trigger for "..tostring(triggerSource.Name), Owner = "Caleb" })

	if trigger.PreTriggerAnimation ~= nil and not ConfigOptionCache.EditingMode then
		SetAnimation({ Name = trigger.PreTriggerAnimation, DestinationId = triggerSource.ObjectId })
	end

	if trigger.PreTriggerAlpha ~= nil and not ConfigOptionCache.EditingMode then
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
		--GameState.TriggerRecord[trigger.Name] = (GameState.TriggerRecord[trigger.Name] or 0) + 1 -- Unused, wasting save space

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

	if requirements ~= nil and not IsGameStateEligible( trigger, requirements ) then
		return false
	end

	return true

end

function PanToTargetAndBack( targetId )
	PanCamera({ Ids = { targetId, CurrentRun.Hero.ObjectId }, Duration = 1.5, EaseIn = 0.03, EaseOut = 0.03 })
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
	CreateAnimation({ Name = animation, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = args.AnimOffsetZ or source.AnimOffsetZ, Scale = args.Scale, Group = group })

end

function StopCurrentStatusAnimation( source )
	if source.StatusAnimation ~= nil then
		StopAnimation({ Name = source.StatusAnimation, DestinationId = source.ObjectId })
		source.StatusAnimation = nil
	end
end

function StopStatusAnimation( source, animation )

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
	local roomData = RoomData[currentRoom.Name] or currentRoom

	if verboseLogging and roomData.ValidateSecretData then
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
			secretDoor.HealthCost = currentRoom.SecretDoorHealthCost or GetSecretDoorCost()
			if forcedSecretDoor then
				secretDoor.HealthCost = 0	
			end
			currentRoom.SecretDoorHealthCost = secretDoor.HealthCost
			local secretRoom = CreateRoom( secretRoomData )
			AssignRoomToExitDoor( secretDoor, secretRoom )
			--AddToGroup({ Id = secretDoor.ObjectId, Name = "ExitDoors" })
		end
	end

	local challengeBaseIds = GetIdsByType({ Name = "ChallengeSwitchBase" })

	-- Well Shop
	if not IsEmpty( challengeBaseIds ) and IsWellShopEligible( currentRun, currentRoom ) then
		currentRoom.ForceWellShop = true
		local challengeBaseId = roomData.WellShopChallengeBaseId or RemoveRandomValue( challengeBaseIds )
		if roomData.WellShopChallengeBaseId ~= nil then
			RemoveValue( challengeBaseIds, roomData.WellShopChallengeBaseId )
		end
		currentRoom.WellShop = DeepCopyTable( ObstacleData.WellShop )
		currentRoom.WellShop.ObjectId = challengeBaseId
		SetupObstacle( currentRoom.WellShop )
		SetAnimation({ DestinationId = currentRoom.WellShop.ObjectId, Name = "WellShopLocked" })
		UseableOn({ Id = currentRoom.WellShop.ObjectId })
		currentRun.LastWellShopDepth = currentRun.RunDepthCache
	end

	-- Sell Trait Shop
	if not IsEmpty( challengeBaseIds ) and IsSellTraitShopEligible( currentRoom ) then
		currentRoom.ForceSellShop = true
		local challengeBaseId = RemoveRandomValue( challengeBaseIds )
		currentRoom.SellTraitShop = DeepCopyTable( ObstacleData.SellTraitShop )
		currentRoom.SellTraitShop.ObjectId = challengeBaseId
		SetupObstacle( currentRoom.SellTraitShop )
		-- animation set in ObstacleData
		UseableOn({ Id = currentRoom.SellTraitShop.ObjectId })
		GenerateSellTraitShop( currentRoom )
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
	end

	-- Challenge Switches
	local requirements = roomData.ChallengeSpawnRequirements or RoomData.BaseRoom.ChallengeSpawnRequirements
	if not IsEmpty( challengeBaseIds ) and IsGameStateEligible( currentRoom, requirements ) then
		local challengeOptions = {}
		local encounterOptions = {}

		-- Time Challenge
		requirements = roomData.TimeChallengeSwitchRequirements or RoomData.BaseRoom.TimeChallengeSwitchRequirements
		if IsGameStateEligible( currentRoom, requirements )  then
			if currentRoom.ChallengeChanceSuccess or IsTimeChallengeForced(currentRoom)  then
				UseHeroTraitsWithValue("ForceChallengeSwitch", true)

				for k, challengeName in pairs( EncounterSets.TimeChallengeOptions ) do
					local challengeData = ObstacleData[challengeName]
					if challengeData ~= nil and (challengeData.Requirements == nil or IsGameStateEligible( challengeData, challengeData.Requirements )) then
						table.insert( challengeOptions, challengeName )
					end
				end
			end
		end
		-- Perfect Clear
		requirements = roomData.PerfectClearSwitchRequirements or RoomData.BaseRoom.PerfectClearSwitchRequirements
		if IsGameStateEligible( currentRoom, requirements )  then
			if currentRoom.ChallengeChanceSuccess or IsPerfectClearChallengeForced(currentRoom)  then
				UseHeroTraitsWithValue("ForcePerfectClearSwitch", true)

				for k, challengeName in pairs( EncounterSets.PerfectClearOptions ) do
					local challengeData = ObstacleData[challengeName]
					if challengeData.Requirements == nil or IsGameStateEligible( challengeData, challengeData.Requirements ) then
						table.insert( challengeOptions, challengeName )
					end
				end
			end
		end
		-- Elite Switch
		requirements = roomData.EliteSwitchRequirements or RoomData.BaseRoom.EliteSwitchRequirements
		if IsGameStateEligible( currentRoom, requirements )  then
			if currentRoom.ChallengeChanceSuccess or IsEliteChallengeForced(currentRoom)  then
				UseHeroTraitsWithValue("ForceEliteSwitch", true)

				for k, challengeName in pairs( EncounterSets.EliteChallengeOptions ) do
					local challengeData = ObstacleData[challengeName]
					if challengeData.Requirements == nil or IsGameStateEligible( challengeData, challengeData.Requirements ) then
						table.insert( challengeOptions, challengeName )
					end
				end
			end
		end

		if not IsEmpty( challengeOptions ) then
			local challengeType = GetRandomValue( challengeOptions )
			local challengeSwitch = DeepCopyTable( ObstacleData[challengeType] )
			challengeSwitch.ObjectId = RemoveRandomValue( challengeBaseIds )
			currentRoom.ChallengeSwitch = challengeSwitch

			local encounterOptions = currentRoom[challengeSwitch.EncounterOptionsName]
			local challengeEncounter = DeepCopyTable( EncounterData[GetRandomValue(encounterOptions) ] )
			if challengeEncounter.Generated then
				GenerateEncounter(CurrentRun, currentRoom, challengeEncounter)
			end

			currentRoom.ChallengeEncounter = challengeEncounter
			challengeEncounter.Switch = challengeSwitch
			challengeEncounter.SpawnNearId = challengeSwitch.ObjectId

			-- Text
			local offsetX = challengeSwitch.TextAnchorIdOffsetX
			if IsHorizontallyFlipped({ Id = challengeSwitch.ObjectId }) then
				offsetX = offsetX * -1
			end
			challengeSwitch.TextAnchorId = SpawnObstacle({ Name = "BlankObstacle", Group = "Standing", DestinationId = challengeSwitch.ObjectId })
			Attach({ Id = challengeSwitch.TextAnchorId, DestinationId = challengeSwitch.ObjectId, OffsetX = offsetX, OffsetY = challengeSwitch.TextAnchorIdOffsetY, OffsetZ = challengeSwitch.TextAnchorIdOffsetZ })
			SetThingProperty({ Property = "SortMode", Value = "FromParent", DestinationId = challengeSwitch.TextAnchorId })
			
			if challengeEncounter.StartingValue ~= nil then
				local rewardMultiplier = challengeSwitch.RewardMultiplier or 1
				local valueDepthRamp = challengeEncounter.ValueDepthRamp or 0
				local startingValue = rewardMultiplier * challengeEncounter.StartingValue * (1 + valueDepthRamp * GetRunDepth(CurrentRun)) * GetTotalHeroTraitValue("ChallengeRewardIncrease", {IsMultiplier = true})
				challengeSwitch.StartingValue = round( startingValue )
			end

			offsetX = challengeSwitch.ValueTextAnchorOffsetX or 40
			if IsHorizontallyFlipped({ Id = challengeSwitch.ObjectId }) then
				offsetX = offsetX * -1
			end
			challengeSwitch.ValueTextAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = challengeSwitch.ObjectId })
			Attach({ Id = challengeSwitch.ValueTextAnchor, DestinationId = challengeSwitch.ObjectId, OffsetX = offsetX , OffsetY = challengeSwitch.ValueTextAnchorOffsetY or -220, })
			CreateTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", LuaValue = startingValue or 0, Font = challengeSwitch.OverheadTextFont, FontSize = 40, Color = Color.White, OutlineThickness = 1, OutlineColor = {0.0, 0.0, 0.0,1}, TextSymbolScale = challengeSwitch.OverheadTextSymbolScale, })
			ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, FadeTarget = 0, FadeDuration = 0 })

			if challengeSwitch.KeyCost == nil and challengeSwitch.KeyCostMin ~= nil and challengeSwitch.KeyCostMax ~= nil then
				challengeSwitch.KeyCost = RandomInt(challengeSwitch.KeyCostMin, challengeSwitch.KeyCostMax)
			end

			SetupObstacle( challengeSwitch )
			SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.LockedAnimationName })
			UseableOn({ Id = challengeSwitch.ObjectId })
			currentRun.LastChallengeDepth = currentRun.RunDepthCache
		end
	end

	-- Meta Reward Stands
	if not IsEmpty( challengeBaseIds ) and IsMetaRewardStandEligible( currentRun, currentRoom ) then
		currentRoom.ForceMetaRewardStand = true
		local challengeBaseId = RemoveRandomValue( challengeBaseIds )
		local metaRewardStand = DeepCopyTable( ObstacleData.MetaRewardStand )
		metaRewardStand.ObjectId = challengeBaseId
		SetupObstacle( metaRewardStand )
		SetAnimation({ DestinationId = challengeBaseId, Name = "MetaRewardStandLocked" })
		currentRoom.MetaRewardStand = metaRewardStand

		local rewardData = GetRandomEligibleValueFromWeightedList( MetaRewardStandData.WeightedOptions )
		local displayItemId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = challengeBaseId, Group = "Standing" })
		SetAnimation({ DestinationId = displayItemId, Name = rewardData.Animation })
		CreateAnimation({ Name = "MetaRewardStandItemShadow", DestinationId = displayItemId })
		SetScale({ Id = displayItemId, Fraction = metaRewardStand.RewardIconScale })
		Attach({ Id = displayItemId, DestinationId = challengeBaseId, OffsetY = -30, OffsetZ = 100 })
		SetThingProperty({ Property = "SortMode", Value = "FromParent", DestinationId = displayItemId })
		UseableOn({ Id = metaRewardStand.ObjectId })
		metaRewardStand.ResourceData = ResourceData[rewardData.Name]
		metaRewardStand.RewardAmount = rewardData.Amount
		metaRewardStand.DisplayItemId = displayItemId
		if GameState.SpentShrinePointsCache < metaRewardStand.RequiredShrinePoints then
			metaRewardStand.UseText = "UseMetaRewardStand_LockedByShrine"
			metaRewardStand.CannotUseText = "MetaRewardStandBlockedByShrine"
			metaRewardStand.ExitsUnlockedFunctionName = nil
			metaRewardStand.ExitsUnlockedFunctionArgs = nil
		end

		currentRun.LastMetaRewardStandDepth = currentRun.RunDepthCache
	end

	SetupHarvestPoints( currentRoom )

	-- Anomaly
	if currentRoom.AnomalyDoorChanceSuccess and IsGameStateEligible( currentRoom, currentRoom.AnomalyDoorRequirements or RoomData.BaseRoom.AnomalyDoorRequirements ) then
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

	if HasHeroTraitValue( "ForceSecretDoor" ) and IsGameStateEligible( currentRoom, NamedRequirementsData.ForceSecretDoorRequirements ) then
		return true
	end

	if not currentRoom.SecretChanceSuccess then
		return false
	end

	local requirements = currentRoom.SecretDoorRequirements or RoomData.BaseRoom.SecretDoorRequirements
	if requirements ~= nil and not IsGameStateEligible( currentRoom, requirements ) then
		return false
	end

	return true

end

function IsTimeChallengeForced( currentRoom )

	if currentRoom.ForceChallengeSwitch then
		return true
	end

	if HasHeroTraitValue("ForceChallengeSwitch") then
		return true
	end

	return false
end

function IsPerfectClearChallengeForced( currentRoom )

	if currentRoom.ForcePerfectClearSwitch then
		return true
	end

	if HasHeroTraitValue("ForcePerfectClearSwitch") then
		return true
	end

	return false
end

function IsEliteChallengeForced( currentRoom )

	if currentRoom.ForceEliteSwitch then
		return true
	end

	if HasHeroTraitValue("ForcePerfectClearSwitch") then
		return true
	end

	return false
end

function IsWellShopEligible( currentRun, currentRoom )
	if currentRoom.ForceWellShop then
		return true
	end
	local requirements = currentRoom.WellShopRequirements or RoomData.BaseRoom.WellShopRequirements
	if not IsGameStateEligible( currentRoom, requirements ) then
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
	if not IsGameStateEligible( currentRoom, requirements ) then
		return false
	end
	if not currentRoom.SurfaceShopChanceSuccess then
		return false
	end
	return true
end

function IsMetaRewardStandEligible( currentRun, currentRoom )
	if currentRoom.ForceMetaRewardStand then
		return true
	end
	local requirements = roomData.MetaRewardStandRequirements or RoomData.BaseRoom.MetaRewardStandRequirements
	if not IsGameStateEligible( currentRoom, requirements ) then
		return false
	end
	if not currentRoom.MetaRewardStandSuccess then
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
			thread( Kill, enemy, { BlockRespawns = true, SkipDeathWeapons = true } )
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
	for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		DisableTrap( enemy )
	end
	ExpireProjectiles({ Name = "SmokeTrapWeapon" })
end
function EnableRoomTraps( )
	CurrentRun.CurrentRoom.BlockDisableTraps = false
	for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if enemy.ActivateGameStateRequirements == nil or IsGameStateEligible(enemy, enemy.ActivateGameStateRequirements) then
			EnableTrap(enemy)
		end
	end
end

function PickRoomEliteAttributes( room )
	local encounters = { room.Encounter }

	if room.Encounters then
		for k, encounter in pairs(room.Encounters) do
			if encounter ~= room.Encounter then
				table.insert( encounters, encounter )
			end
		end
	end
	if room.CageRewards ~= nil then
		for k, cageReward in pairs(room.CageRewards) do
			table.insert( encounters, cageReward.Encounter )
		end
	end

	for i, encounter in ipairs( encounters ) do
		local encounterData = EncounterData[encounter.Name] or encounter
		if encounterData ~= nil and not encounterData.BlockEliteAttributes then
			PickEncounterEliteAttributes( encounter )
		end
	end
end

function PickEncounterEliteAttributes( encounter )

	if encounter.SpawnWaves == nil then
		return
	end

	local encounterEliteTypes = {}
	for k, wave in pairs( encounter.SpawnWaves ) do
		for index, spawnData in ipairs( wave.Spawns ) do
			if EnemyData[spawnData.Name].IsElite then
				table.insert( encounterEliteTypes, spawnData.Name )
			end
		end
	end

	local eliteTypeUpgradeCount = encounter.EliteTypeUpgradeCount or 1
	for j = 1, eliteTypeUpgradeCount do
		local eliteType = RemoveRandomValue(encounterEliteTypes)
		if eliteType ~= nil then
			PickEliteAttributes( encounter, eliteType )
			RemoveAllValues(encounterEliteTypes, eliteType)
		end
	end
end

function ShadeMercManager( room, args )

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end
	
	room.ShadeMercInactiveIds = GetInactiveIdsByType({ Names = args.ObjectNames })
	room.ShadeMercActiveIds = {}

	wait( 0.2 )

	if SessionMapState.HandlingDeath then
		return
	end

	DoShadeMercActivations( room, args )

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

function DoShadeMercActivations( room, args )

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
		boulder.ObjectId = SpawnObstacle({ Name = "PolyphemusBoulder", DestinationId = RemoveRandomValue(spawnIds), Group = "Standing" }) -- nopkg
		SetupObstacle(boulder)
		if RandomChance(0.5) then
			FlipHorizontal({ Id = boulder.ObjectId })
		end
	end

	LoadVoiceBanks({ Name = "Polyphemus" })
	
	waitUntil("RequiredKillEnemyKilledOrSpawned")

	local passiveRoomUnit = nil
	if not IsEmpty(spawnIds) then
		passiveRoomUnit = DeepCopyTable( EnemyData.PolyphemusBoulders )
		passiveRoomUnit.ObjectId = SpawnUnit({ Name = "PolyphemusBoulders", Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId })	
		thread(SetupUnit, passiveRoomUnit, CurrentRun )
		passiveRoomUnit.Groups = passiveRoomUnit.Groups or {}
		table.insert( passiveRoomUnit.Groups, "RoomWeapon" )
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = _elapsedTimeMultiplier, DataValue = false, ValueChangeType = "Multiply", DestinationId = passiveRoomUnit.ObjectId })
		AddToGroup({ Id = passiveRoomUnit.ObjectId, Names = passiveRoomUnit.Groups })

		room.Encounter.PassiveRoomWeapons = room.Encounter.PassiveRoomWeapons or {}
		table.insert(room.Encounter.PassiveRoomWeapons, passiveRoomUnit.ObjectId)
	end

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
		CreateProjectileFromUnit({ Name = args.ProjectileName, Id = passiveRoomUnit.ObjectId, DestinationId = targetId, FireFromTarget = true })
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

		wait( args.RespawnInterval, "RespawningCoverManager" )

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

	-- Remove all doors which dont have a room assigned yet
	local allDoors = GetIdsByType({ Names = args.Types })
	for k, doorId in pairs(allDoors) do
		if not Contains(doorIds, doorId) then
			room.UnavailableDoors[doorId] = true
		end
	end

	if CoinFlip() then -- Make MiniBoss01 unavailable
		RemoveValue(doorIds, 617043)
		room.UnavailableDoors[617043] = true
	else  -- Make MiniBoss02 unavailable
		RemoveValue(doorIds, 560889)
		room.UnavailableDoors[560889] = true
	end

	for doorId, roomName in pairs( roomData.PredeterminedDoorRooms ) do
		if not IsGameStateEligible( RoomData[roomName], RoomData[roomName].GameStateRequirements ) then
			RemoveValue(doorIds, doorId)
			room.UnavailableDoors[doorId] = true
		elseif IsRoomForced( CurrentRun, room, RoomData[roomName] ) then -- if it is eligible, check if we should force it.
			RemoveValue(doorIds, doorId)
			count = count - 1
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

function LockEphyraExits( room, args )
	for doorId, door in pairs(MapState.OfferedExitDoors) do
		if door.LockWhenEphyraBossExitReady then
			if door.ClosedForRunAnimation ~= nil then
				SetAnimation({ Name = door.ClosedForRunAnimation, DestinationId = doorId })
			end
			MapState.OfferedExitDoors[doorId] = nil
		end
	end
end

function HandlePylonObjective( room, args )

	args = args or {}

	if not IsGameStateEligible( room, NamedRequirementsData.PylonObjectiveRevealed ) then
		return
	end

	wait( args.Delay, RoomThreadName )

	wait(1.3, RoomThreadName)

	if room.Leaving then
		return
	end

	CheckObjectiveSet("BiomeNBossUnlock")
	local objectiveText = 0
	local numPylons = CurrentRun.SpawnRecord.SoulPylon or 0

	numPylons = numPylons - #GetIdsByType({ Name ="SoulPylon" })

	UpdateObjectiveDescription( "BiomeNPylons", "Objective_BiomeNPylons", "Pylons", 6 - numPylons )

	wait(1.3, RoomThreadName)

	if numPylons >= 6 then
		MarkObjectiveComplete("BiomeNPylons")
	end

end

function SpawnRewardCages( room, args )

	RandomSynchronize( 3 )

	local rewardSpawnPoints = GetIdsByType({ Name = "LootPoint" })
	table.sort( rewardSpawnPoints )
	for index, cageReward in ipairs( room.CageRewards ) do
		local spawnPointId = RemoveRandomValue( rewardSpawnPoints )
		
		local obstacleName = "FieldsRewardCage"
		local rewardCage = DeepCopyTable( ObstacleData[obstacleName] )
		rewardCage.ObjectId = SpawnObstacle({ Name = obstacleName, DestinationId = spawnPointId, Group = "Standing", TriggerOnSpawn = false })
		rewardCage.SpawnPointId = spawnPointId			
		SetupObstacle( rewardCage )
		
		rewardCage.Encounter = cageReward.Encounter
		local rewardOverride = cageReward.RewardType or ChooseRoomReward( CurrentRun, {}, room.RewardStoreName )
		local reward = SpawnRoomReward( room, { RewardOverride = rewardOverride, LootName = cageReward.ForceLootName, SpawnRewardOnId = spawnPointId, AutoLoadPackages = true } )
		rewardCage.RewardId = reward.ObjectId

		for k, spawnPointId in ipairs( MapState.SpawnPoints ) do
			SessionMapState.DistanceCache[spawnPointId] = SessionMapState.DistanceCache[spawnPointId] or {}
			local distance = SessionMapState.DistanceCache[spawnPointId][rewardCage.ObjectId] or GetDistance({ Id = spawnPointId, DestinationId = rewardCage.ObjectId })
			SessionMapState.DistanceCache[spawnPointId][rewardCage.ObjectId] = distance
		end

		UseableOff({ Id = rewardCage.RewardId })
	end

	RandomSynchronize( 4 )

	-- bonus rewards
	local optionalRewardCount = 0
	local bonusRewardSpawnPoints = GetIds({ Name = "BonusRewardSpawnPoints" })
	table.sort( bonusRewardSpawnPoints )

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
		for k, rewardPointId in pairs( bonusRewardSpawnPoints ) do
			local nearbyEnemyPoints = GetClosestIds({ Id = rewardPointId, DestinationIds = passiveSpawnPoints, Distance = 500 })
			for i = 1, RoomData[room.Name].UnoccupiedRewardCullCount do
				if not IsEmpty( nearbyEnemyPoints ) then
					SessionMapState.SpawnPointsUsed[RemoveRandomValue(nearbyEnemyPoints)] = 1
				end
			end
		end
	end
end

function SpawnRewardCagesMiniboss( encounter, args )

	local spawnPointId = RemoveRandomValue(GetIdsByType({ Name = "LootPoint" }))

	local obstacleName = "FieldsRewardCage"
	local rewardCage = DeepCopyTable( ObstacleData[obstacleName] )
	rewardCage.ObjectId = SpawnObstacle({ Name = obstacleName, DestinationId = spawnPointId, Group = "Standing", TriggerOnSpawn = false })
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
		local requiredObjects = ShallowCopyTable( MapState.RoomRequiredObjects ) -- copying because the original table may change during iteration
		for rewardId, reward in pairs( requiredObjects ) do
			if IsAlive({ Id = rewardId }) and not reward.FieldsRewardFinderIgnores then
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
		local optionalRewards = ShallowCopyTable( MapState.OptionalRewards ) -- copying because the original table may change during iteration
		for rewardId, reward in pairs( optionalRewards ) do
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
				CreateScreenEdgeIndicator( door, { AnimName = door.RewardFinderAnimation or "FieldsExitRewardFinder" } )
			end
		end
	end
end

function CheckFieldsExitIndicators()
	if not CurrentRun.CurrentRoom.SpawnedRewardCageIndicators then
		return
	end
	for index, door in pairs( MapState.OfferedExitDoors ) do
		CreateScreenEdgeIndicator( door, { AnimName = door.RewardFinderAnimation or "FieldsExitRewardFinder" } )
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
	elseif source.AvailableRequirements == nil or IsGameStateEligible( source, source.AvailableRequirements ) then
		MapState.OfferedExitDoors[source.ObjectId] = source
	end
end

function CheckN_SubRoomDoorUnavailable( source, args )

	if not CurrentRun.CurrentRoom.ExitsUnlocked and args.AboveMinAvailableChance ~= nil and not IsDoorClosedForRun( CurrentRun, source ) then
		CurrentRun.NumSubRoomsSpawned = CurrentRun.NumSubRoomsSpawned or 0
		local soulPylonsSpawned = CurrentRun.SpawnRecord.SoulPylon or 0
		local minSubRooms = soulPylonsSpawned * args.MinSubRoomsPerPylon
		if CurrentRun.NumSubRoomsSpawned < minSubRooms or RandomChance( args.AboveMinAvailableChance ) then
			CurrentRun.NumSubRoomsSpawned = CurrentRun.NumSubRoomsSpawned + 1
		else
			CurrentRun.CurrentRoom.UnavailableDoors = CurrentRun.CurrentRoom.UnavailableDoors or {}
			CurrentRun.CurrentRoom.UnavailableDoors[source.ObjectId] = true
		end
	end
end

function H_BossReloadCleanup( room, args )
	Destroy({ Ids = GetIds({ Name = "Phase1Obstacles" }) })
end

function HandleChronosPreSpawns( room, args )
	local activateEnemies = {}
	local chronos = nil
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
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
			thread( Kill, enemy, { SuppressSounds = true, SkipDeathWeapons = true } )
		end
	end
end

function BlockExitUntilUsedIfElligible( source, args )
	if IsGameStateEligible( source, source.OnUsedGameStateRequirements ) then
		MapState.RoomRequiredObjects[source.ObjectId] = source
	end
end

function SetDepletedAnimIfUnuseable( source, args )
	if not IsGameStateEligible( source, source.OnUsedGameStateRequirements ) then
		SetAnimation({ DestinationId = source.ObjectId, Name = source.DepletedAnimation })
		UseableOff({ Id = source.ObjectId })
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
			DebugAssert({ Condition = false, Text = roomData.Name.." is not listed in any RoomSet", Owner = "Eduardo", })
		end
	end
end

function SetupComboPartners( unit )
	if unit.ComboPartnerName ~= nil then
		unit.ComboPartnerId = GetClosestUnitOfType({ Id = unit.ObjectId, DestinationName = unit.ComboPartnerName })
	end
end

function EraseRoomKeys( encounter, args, room )
	for i, key in pairs( args.EraseKeys ) do
		room[key] = nil
	end
end

function TyphonEyeEggFuser(room, args)

	wait(args.StartDelay)

	while room.Encounter.InProgress do

		local nextEggId = GetRandomValue( GetIdsByType({ Name = "TyphonEggLarge" }) )
		local nextEgg = ActiveEnemies[nextEggId]
		if nextEgg ~= nil and GetActiveEnemyCount() < args.ActiveEnemyCap then
			if GetNumShrineUpgrades("MinibossCountShrineUpgrade") >= 1 then
				nextEgg.SpawnUnitOnDeath = args.EggShadowSpawn
			else
				nextEgg.SpawnUnitOnDeath = args.EggSpawn
			end
			nextEgg.SkipSpawnOverActiveCap = args.ActiveEnemyCap
			nextEgg.OnDeathFireWeapons = { "TyphonEggDeathWeapon" }

			thread( ActivateFuse, nextEgg )
		end

		wait(args.Interval)
	end
end