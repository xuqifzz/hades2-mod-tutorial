function CreateNewHero( prevRun, args )
	local newHero = DeepCopyTable( HeroData )
	newHero.SpeakerId = 1
	newHero.Health = newHero.MaxHealth
	newHero.Mana = newHero.MaxMana
	newHero.ManaDrain = {}
	newHero.ManaRegenSources = {}
	newHero.HeroTraitValuesCache = {}
	newHero.FirstTraitWithPropertyCache = {}
	newHero.WeaponDataOverride = {}
	newHero.InvulnerableFlags = {}
	newHero.Ammo = {}

	if args ~= nil and args.WeaponName ~= nil then
		newHero.Weapons[args.WeaponName] = true
	elseif prevRun ~= nil then
		newHero.Weapons = ShallowCopyTable( prevRun.Hero.Weapons )
	else
		local defaultWeaponName = newHero.DefaultWeapon
		newHero.Weapons[defaultWeaponName] = true
		newHero.Weapons[WeaponData[defaultWeaponName].SecondaryWeapon] = true
		GameState.WeaponsUnlocked[defaultWeaponName] = true
		GameState.WeaponsTouched[defaultWeaponName] = true
	end

	AddIncomingDamageModifier( newHero,
	{
		Name = "EnemyDamageShrineUpgrade",
		NonTrapDamageTakenMultiplier = MetaUpgradeData.EnemyDamageShrineUpgrade.ChangeValue,
	})

	if args ~= nil and args.TraitNames ~= nil then
		for k, traitName in pairs( args.TraitNames ) do
			AddTrait( newHero, traitName )
		end
	end

	return newHero
end

function CalculateStartingMoney()
	return GetTotalHeroTraitValue( "BonusMoney" )
end

function InitHeroLastStands( newHero )
	for i = 1, GetNumMetaUpgradeLastStands() do
		AddLastStand({
			Unit = newHero,
			IncreaseMax = true,
			Icon = "ExtraLifeMel",
			ManaFraction = 0.4,
			HealFraction = 0.4,
			Silent = true
		})
	end
end
function HasTraitRequirements( traitName )
	local valid = false
	local dependencyTable = TraitRequirements[traitName]
	if dependencyTable.OneOf ~= nil then
		for j, dependentTraitName in ipairs(dependencyTable.OneOf) do
			if not valid and HeroHasTrait(dependentTraitName) then
				valid = true
			end
		end
	end

	if dependencyTable.TwoOf ~= nil then
		local numTraits = 0
		for j, dependentTraitName in ipairs(dependencyTable.TwoOf) do
			if HeroHasTrait(dependentTraitName) then
				numTraits = numTraits + 1
			end
		end
		if numTraits >= 2 then
			valid = true
		end
	end

	if not valid and dependencyTable.OneFromEachSet ~= nil then
		valid = true
		for i, traitSet in ipairs(dependencyTable.OneFromEachSet) do
			local foundInSet = false
			for j, dependentTraitName in ipairs(dependencyTable.OneFromEachSet[i]) do
				if not foundInSet and HeroHasTrait(dependentTraitName) then
					foundInSet = true
				end
			end
			if not foundInSet then
				valid = false
				break
			end
		end

	end
	return valid
end

function IsTraitEligible( traitData, args )
	if traitData == nil then
		return false
	end

	args = args or {}

	if traitData.MaxAmount ~= nil and traitData.MaxAmount <= GetTraitCount(CurrentRun.Hero, { Name = traitData.Name }) then
		return false
	end

	if traitData.IsLegacyTrait and not IsGameStateEligible( traitData, TraitRarityData.LegacyGameStateRequirements ) then
		return false
	end

	if traitData.IsElementalTrait and not IsGameStateEligible( traitData, TraitRarityData.ElementalGameStateRequirements ) then
		return false
	end

	if traitData.BlockOfferIfPreviouslyPicked and CurrentRun.PickedTraits[traitData.Name] then
		return false
	end

	if CurrentRun.BannedTraits[traitData.Name] and not args.AllowBannedTraits then
		return false
	end

	if traitData.GameStateRequirements ~= nil and not IsGameStateEligible( traitData, traitData.GameStateRequirements ) then
		return false
	end

	return true

end

function GameStateInit()

	if GameState == nil then
		return
	end

	GameState.AchievementsUnlocked = GameState.AchievementsUnlocked or {}
	GameState.TotalTime = GameState.TotalTime or 0
	GameState.GameplayTime = GameState.GameplayTime or 0
	GameState.WeaponHistory = GameState.WeaponHistory or {}
	GameState.WeaponsTouched = GameState.WeaponsTouched or {}
	GameState.WeaponsUnlocked = GameState.WeaponsUnlocked or {}
	GameState.FamiliarUpgrades = GameState.FamiliarUpgrades or {}
	GameState.FamiliarsUnlocked = GameState.FamiliarsUnlocked or {}
	GameState.FamiliarCostumes = GameState.FamiliarCostumes or {}
	GameState.RunHistory = GameState.RunHistory or {}
	GameState.ShrineUpgrades = GameState.ShrineUpgrades or {}
	GameState.SpentShrinePointsCache = GameState.SpentShrinePointsCache or 0
	GameState.WeaponKills = GameState.WeaponKills or {}
	GameState.LootPickups = GameState.LootPickups or {}
	GameState.UseRecord = GameState.UseRecord or {}
	GameState.SpecialInteractRecord = GameState.SpecialInteractRecord or {}
	GameState.SpellSummons = GameState.SpellSummons or {}
	--GameState.TriggerRecord = GameState.TriggerRecord or {}  -- Unused, wasting save space

	GameState.NPCInteractions = GameState.NPCInteractions or {}
	GameState.SpawnRecord = GameState.SpawnRecord or {}
	GameState.EnemyKills = GameState.EnemyKills or {}
	GameState.EnemyEliteAttributeKills = GameState.EnemyEliteAttributeKills or {}
	GameState.WeaponsFiredRecord = GameState.WeaponsFiredRecord or {}
	GameState.ProjectileRecord = GameState.ProjectileRecord or {}
	GameState.DamageTakenFromRecord = GameState.DamageTakenFromRecord or {}
	GameState.DamageDealtByHeroRecord = GameState.DamageDealtByHeroRecord or {}
	GameState.DamageDealtByEnemiesRecord = GameState.DamageDealtByEnemiesRecord or {}
	GameState.DamageDealtByCharmedEnemiesRecord = GameState.DamageDealtByCharmedEnemiesRecord or {}
	GameState.HealthRecord = GameState.HealthRecord or {}
	GameState.ActualHealthRecord = GameState.ActualHealthRecord or {}
	GameState.LastBossHealthBarRecord = GameState.LastBossHealthBarRecord or {}
	GameState.LastBossDifficultyRecord = GameState.LastBossDifficultyRecord or {}
	GameState.CompletedObjectiveSets = GameState.CompletedObjectiveSets or {}
	GameState.RecordLastClearedShrineReward = GameState.RecordLastClearedShrineReward or {}
	GameState.NemesisTakeExitRecord = GameState.NemesisTakeExitRecord or {}
	GameState.NemesisTakeRoomExitRecord = GameState.NemesisTakeRoomExitRecord or {}
	GameState.NPCShopItemStolenRecord = GameState.NPCShopItemStolenRecord or {}
	GameState.ErisCurseRewardTaken = GameState.ErisCurseRewardTaken or {}

	GameState.SpeechRecord = GameState.SpeechRecord or {}
	GameState.PlayedRandomLines = GameState.PlayedRandomLines or {}
	GameState.LastPlayedRandomLines = GameState.LastPlayedRandomLines or {}

	GameState.TextLinesRecord = GameState.TextLinesRecord or {}
	GameState.TextLinePanelCount = GameState.TextLinePanelCount or {}
	GameState.TextLinePanelSkipCount = GameState.TextLinePanelSkipCount or {}
	GameState.TextLinesChoiceRecord = GameState.TextLinesChoiceRecord or {}

	GameState.MusicRecord = GameState.MusicRecord or {}
	GameState.MusicEndRecord = GameState.MusicEndRecord or {}
	GameState.ScyllaDefeatMusicRecord = GameState.ScyllaDefeatMusicRecord or {}
	GameState.TraitUses = GameState.TraitUses or {}
	GameState.PlayedRandomTextLines = GameState.PlayedRandomTextLines or {}

	GameState.GiftRecord = GameState.GiftRecord or {}
	GameState.GiftTextLinesOrderRecord = GameState.GiftTextLinesOrderRecord or {}
	GameState.GiftResourceRecord = GameState.GiftResourceRecord or {}
	GameState.GiftPresentation = GameState.GiftPresentation or {}
	GameState.NewKeepsakeItem = GameState.NewKeepsakeItem or {}
	GameState.GardenPlots = GameState.GardenPlots or {}
	GameState.CookStatus = GameState.CookStatus or {}
	GameState.MailboxStatus = GameState.MailboxStatus or {}
	GameState.ActiveLitter = GameState.ActiveLitter or {}
	GameState.BiomeStateRecord = GameState.BiomeStateRecord or {} 
	GameState.BiomeVisits = GameState.BiomeVisits or {}
	GameState.BiomeMapRecord = GameState.BiomeMapRecord or {} 
	GameState.BiomeMusicPlayCounts = GameState.BiomeMusicPlayCounts or {}
	GameState.BiomeMusicLastFirstPlayed = GameState.BiomeMusicLastFirstPlayed or {}
	GameState.UnlockedMusicPlayerSongs = GameState.UnlockedMusicPlayerSongs or {}

	GameState.Flags = GameState.Flags or {}
	GameState.ReturnedRandomEligibleSourceNames = GameState.ReturnedRandomEligibleSourceNames or {}
	
	GameState.RunInterstitialRecord = GameState.RunInterstitialRecord or {}	
	GameState.PlayedRandomRunIntroData = GameState.PlayedRandomRunIntroData or {}	
	GameState.PlayedRunOutros = GameState.PlayedRunOutros or {}
	GameState.RemainingRunOutros = GameState.RemainingRunOutros or {}
	GameState.PlayedGhostEavesdroppers = GameState.PlayedGhostEavesdroppers or {}
	GameState.RemainingGhostEavesdroppers = GameState.RemainingGhostEavesdroppers or {}
	GameState.PlayedRunClearMessages = GameState.PlayedRunClearMessages or {}
	GameState.RemainingRunClearMessages = GameState.RemainingRunClearMessages or {}
	--GameState.LastPlayedRandomRunOutroData = GameState.LastPlayedRandomRunOutroData or {}

	GameState.FishCaught = GameState.FishCaught or {}
	GameState.ExorcisedNames = GameState.ExorcisedNames or {}
	GameState.MetaUpgradeState =  GameState.MetaUpgradeState or {}
	GameState.KeepsakeChambers = GameState.KeepsakeChambers or {}
	GameState.ClearedFullRunWithKeepsakes = GameState.ClearedFullRunWithKeepsakes or {}
	GameState.Resources = GameState.Resources or {}
	GameState.LifetimeResourcesGained = GameState.LifetimeResourcesGained or {}
	GameState.LifetimeResourcesSpent = GameState.LifetimeResourcesSpent or {}
	GameState.ResourcesViewed = GameState.ResourcesViewed or {}
	GameState.LayoutSetArtViewed = GameState.LayoutSetArtViewed or {}
	GameState.NextCharonPointCache = GameState.NextCharonPointCache or 0
	GameState.MoneySpentTowardCharonPoints = GameState.MoneySpentTowardCharonPoints or 0
	GameState.StoreItemPins = GameState.StoreItemPins or {}
	GameState.StoreItemPinsPurchased = GameState.StoreItemPinsPurchased or {}
	GameState.EnemyEliteAttributeKills = GameState.EnemyEliteAttributeKills or {}

	GameState.ClearedRunsCache = GameState.ClearedRunsCache or 0
	GameState.HighestShrinePointClearUnderworldCache = GameState.HighestShrinePointClearUnderworldCache or 0
	GameState.HighestShrinePointClearSurfaceCache = GameState.HighestShrinePointClearSurfaceCache or 0
	GameState.HighestRunDepthCache = GameState.HighestRunDepthCache or 0
	GameState.FastestUnderworldClearTimeCache = GameState.FastestUnderworldClearTimeCache or 0
	GameState.FastestSurfaceClearTimeCache = GameState.FastestSurfaceClearTimeCache or 0

	GameState.WeaponUnlocks = GameState.WeaponUnlocks or {}
	GameState.SeenWeaponUnlocks = GameState.SeenWeaponUnlocks or {}
	GameState.LastWeaponUpgradeName = GameState.LastWeaponUpgradeName or {}
	GameState.LifetimeTraitStats = GameState.LifetimeTraitStats or {}
	GameState.TraitsTaken = GameState.TraitsTaken or {}
	GameState.TraitsSeen = GameState.TraitsSeen or {}
	GameState.ClearedWithMetaUpgrades = GameState.ClearedWithMetaUpgrades or {}
	GameState.ClearedWithWeapons = GameState.ClearedWithWeapons or {}
	GameState.ClearedWithAspects = GameState.ClearedWithAspects or {}
	GameState.ClearedWithFamiliars = GameState.ClearedWithFamiliars or {}
	GameState.QuestsViewed = GameState.QuestsViewed or {}
	GameState.QuestsCompleted = GameState.QuestsCompleted or {}
	GameState.QuestStatus = GameState.QuestStatus or {}
	GameState.ShrineBountiesCompleted = GameState.ShrineBountiesCompleted or {}
	GameState.PackagedBountyClears = GameState.PackagedBountyClears or {}
	GameState.PackagedBountyAttempts = GameState.PackagedBountyAttempts or {}
	GameState.PackagedBountyClearRecordTime = GameState.PackagedBountyClearRecordTime or {}
	GameState.PackagedBountyClearStreak = GameState.PackagedBountyClearStreak or {}
	GameState.PackagedBountyHighestClearStreak = GameState.PackagedBountyHighestClearStreak or {}
	GameState.RandomBountyClearStreak = GameState.RandomBountyClearStreak or 0
	GameState.RandomBountyHighestClearStreak = GameState.RandomBountyHighestClearStreak or 0
	GameState.CodexEntriesViewed = GameState.CodexEntriesViewed or {}
	GameState.SpeechRecordContexts = GameState.SpeechRecordContexts or {}

	GameState.WorldUpgrades = GameState.WorldUpgrades or {}
	GameState.WorldUpgradesViewed = GameState.WorldUpgradesViewed or {}
	GameState.WorldUpgradesRevealed = GameState.WorldUpgradesRevealed or {}
	GameState.WorldUpgradesAdded = GameState.WorldUpgradesAdded or {}
	GameState.CosmeticsPurchasedCountCache = GameState.CosmeticsPurchasedCountCache or {}

	for i, upgradeName in ipairs( GameData.WorldUpgradeAutomaticUnlocks ) do
		UnlockWorldUpgrade( upgradeName )
	end

	GameState.ItemsViewed = GameState.ItemsViewed or {}
	GameState.ScreensViewed = GameState.ScreensViewed or {}

	GameState.ItemInteractions = GameState.ItemInteractions or {}
	GameState.CauseOfDeath = GameState.CauseOfDeath or "NoCauseOfDeath"
	GameState.CauseOfDeathDisplay = GameState.CauseOfDeathDisplay or GameState.CauseOfDeath or "NoCauseOfDeath"

	GameState.ObjectivesCompleted = GameState.ObjectivesCompleted or {}
	GameState.ObjectivesFailed = GameState.ObjectivesFailed or {}
	GameState.LastObjectiveFailedRun = GameState.LastObjectiveFailedRun or {}

	GameState.EncountersOccurredCache = GameState.EncountersOccurredCache or {}
	GameState.EncountersCompletedCache = GameState.EncountersCompletedCache or {}
	GameState.RoomCountCache = GameState.RoomCountCache or {}
	GameState.RoomsEntered = GameState.RoomsEntered or {}

	GameState.EasyModeLevel = GameState.EasyModeLevel or 0

	GameState.MaxMetaUpgradeCostCache = GameState.MaxMetaUpgradeCostCache or GetMaxMetaUpgradeCost()
	GameState.MetaUpgradeCostCache = GameState.MetaUpgradeCostCache or 0

	GameState.GamePhase = GameState.GamePhase or GamePhaseData.StartingGamePhase
	GameState.GamePhaseRunsRemaining = GameState.GamePhaseRunsRemaining or GamePhaseData.StartingGamePhaseRunsRemaining
end

function StartNewGame( mapName )

	DebugAssert({ Condition = GameState == nil, "Overwriting existing game state!" })

	GameState = {}
	GameStateInit()
	
	InitializeMetaUpgradeState()

	if CurrentRun == nil then
		StartNewRun( nil, { RoomName = mapName, StartingBiome = "F" } )
	end

end

function RunStateInit()
	if CurrentRun == nil then
		return
	end
	CurrentRun.AnimationState = CurrentRun.AnimationState or {}
	CurrentRun.ShrineBountiesCompleted = CurrentRun.ShrineBountiesCompleted or {}
	CurrentRun.EventState = CurrentRun.EventState or {}
	CurrentRun.MapStates = CurrentRun.MapStates or {}
	CurrentRun.NPCInteractions = CurrentRun.NPCInteractions or {}
	CurrentRun.GiftRecord = CurrentRun.GiftRecord or {}
	CurrentRun.GiftResourceRecord = CurrentRun.GiftResourceRecord or {}
	CurrentRun.ActivationRecord = CurrentRun.ActivationRecord or {}
	CurrentRun.NPCLeaveOutRecord = CurrentRun.NPCLeaveOutRecord or {}
	CurrentRun.TriggerRecord = CurrentRun.TriggerRecord or {}
	CurrentRun.InvulnerableFlags = CurrentRun.InvulnerableFlags or {}
	CurrentRun.HealthRecord = CurrentRun.HealthRecord or {}
	CurrentRun.ActualHealthRecord = CurrentRun.ActualHealthRecord or {}
	CurrentRun.DamageTakenFromRecord = CurrentRun.DamageTakenFromRecord or {}
	CurrentRun.TotalDamageTaken = CurrentRun.TotalDamageTaken or 0
	CurrentRun.DamageDealtByHeroRecord = CurrentRun.DamageDealtByHeroRecord or {}
	CurrentRun.DamageDealtByEnemiesRecord = CurrentRun.DamageDealtByEnemiesRecord or {}
	CurrentRun.DamageDealtByCharmedEnemiesRecord = CurrentRun.DamageDealtByCharmedEnemiesRecord or {}
	CurrentRun.BossHealthBarRecord = CurrentRun.BossHealthBarRecord or {}
	CurrentRun.ConsumableRecord = CurrentRun.ConsumableRecord or {}
	CurrentRun.WeaponsFiredRecord = CurrentRun.WeaponsFiredRecord or {}
	CurrentRun.WeaponsUnlocked = CurrentRun.WeaponsUnlocked or {}
	CurrentRun.FamiliarsUnlocked = CurrentRun.FamiliarsUnlocked or {}
	CurrentRun.ProjectileRecord = CurrentRun.ProjectileRecord or {}
	CurrentRun.TotalTime = CurrentRun.TotalTime or 0
	CurrentRun.GameplayTime = CurrentRun.GameplayTime or 0
	CurrentRun.ClearedBiomes = CurrentRun.ClearedBiomes or 0
	CurrentRun.BiomeTotalTimes = CurrentRun.BiomeTotalTimes or {}
	CurrentRun.BiomeGameplayTimes = CurrentRun.BiomeGameplayTimes or {}
	CurrentRun.BiomeTime = CurrentRun.BiomeTime or 0
	CurrentRun.BiomeBoonSkipCount = CurrentRun.BiomeBoonSkipCount or 0
	CurrentRun.BiomeTimeKeepsake = CurrentRun.BiomeTimeKeepsake or 0
	CurrentRun.BiomeMusicPlayCounts = CurrentRun.BiomeMusicPlayCounts or {}
	CurrentRun.BiomeHarvestPointsSeen = CurrentRun.BiomeHarvestPointsSeen or {}
	CurrentRun.ToolElementsSpawned = CurrentRun.ToolElementsSpawned or {}
	CurrentRun.ExpiredKeepsakes = CurrentRun.ExpiredKeepsakes or {}
	CurrentRun.TraitUses = CurrentRun.TraitUses or {}
	CurrentRun.PickedTraits = CurrentRun.PickedTraits or {}
	CurrentRun.TraitCache = CurrentRun.TraitCache or {}
	CurrentRun.BannedTraits = CurrentRun.BannedTraits or {}
	CurrentRun.ShrineUpgradesCache = CurrentRun.ShrineUpgradesCache or {}
	CurrentRun.ShrineUpgrades = CurrentRun.ShrineUpgrades or {}
	CurrentRun.ShrineUpgradesDisabled = CurrentRun.ShrineUpgradesDisabled or {}
	CurrentRun.TemporaryMetaUpgrades = CurrentRun.TemporaryMetaUpgrades or {}
	CurrentRun.ViewableWorldUpgrades = CurrentRun.ViewableWorldUpgrades or {}
	CurrentRun.KeepsakeCache = CurrentRun.KeepsakeCache or {}
	CurrentRun.ScreenViewRecord = CurrentRun.ScreenViewRecord or {}
	CurrentRun.RewardPriorities = CurrentRun.RewardPriorities or {}
	CurrentRun.BlockedKeepsakes = CurrentRun.BlockedKeepsakes or {}

	CurrentRun.ResourcesSpent = CurrentRun.ResourcesSpent or {}
	CurrentRun.ResourcesGained = CurrentRun.ResourcesGained or {}
	CurrentRun.ObjectivesCompleted = CurrentRun.ObjectivesCompleted or {}
	CurrentRun.FishCaught = CurrentRun.FishCaught or {}
	CurrentRun.ExorcisedNames = CurrentRun.ExorcisedNames or {}
	CurrentRun.RelationshipsAdvanced = CurrentRun.RelationshipsAdvanced or {}
	CurrentRun.ShadeMercsCollected = CurrentRun.ShadeMercsCollected or 0
	CurrentRun.BiomeStateChangeCount = CurrentRun.BiomeStateChangeCount or 0

	CurrentRun.BlockTimerFlags = CurrentRun.BlockTimerFlags or {}

	CurrentRun.RoomHistory = CurrentRun.RoomHistory or {}
	CurrentRun.RoomCreations = CurrentRun.RoomCreations or {}
	CurrentRun.RoomsEntered = CurrentRun.RoomsEntered or {}
	CurrentRun.BiomesReached = CurrentRun.BiomesReached or {}
	CurrentRun.LootTypeHistory = CurrentRun.LootTypeHistory or {}
	CurrentRun.LootBiomeRecord = CurrentRun.LootBiomeRecord or {}
	CurrentRun.AnimationState = CurrentRun.AnimationState or {}
	CurrentRun.EventState = CurrentRun.EventState or {}
	CurrentRun.SpeechRecord = CurrentRun.SpeechRecord or {}
	CurrentRun.SpeechRecordContexts = CurrentRun.SpeechRecordContexts or {}
	CurrentRun.TextLinesRecord = CurrentRun.TextLinesRecord or {}
	CurrentRun.TextLinesChoiceRecord = CurrentRun.TextLinesChoiceRecord or {}
	CurrentRun.MusicRecord = CurrentRun.MusicRecord or {}
	CurrentRun.MusicEndRecord = CurrentRun.MusicEndRecord or {}
	CurrentRun.HubTextLinesRecord = CurrentRun.HubTextLinesRecord or {}
	CurrentRun.LineHistory = CurrentRun.LineHistory or {}
	CurrentRun.UseRecord = CurrentRun.UseRecord or {}
	CurrentRun.BiomeUseRecord = CurrentRun.BiomeUseRecord or {}
	CurrentRun.SpecialInteractRecord = CurrentRun.SpecialInteractRecord or {}
	CurrentRun.BlockedEncounters = CurrentRun.BlockedEncounters or {}
	CurrentRun.SpawnRecord = CurrentRun.SpawnRecord or {}
	CurrentRun.EnemyKills = CurrentRun.EnemyKills or {}
	CurrentRun.EncounterClearStats = CurrentRun.EncounterClearStats or {}

	CurrentRun.RunDepthCache = CurrentRun.RunDepthCache or 1
	CurrentRun.EncounterDepth = CurrentRun.EncounterDepth or 1
	CurrentRun.ClosedDoors = CurrentRun.ClosedDoors or {}
	CurrentRun.BannedEliteAttributes = CurrentRun.BannedEliteAttributes or {}
	CurrentRun.NemesisTakeExitRecord = CurrentRun.NemesisTakeExitRecord or {}
	CurrentRun.NemesisTakeRoomExitRecord = CurrentRun.NemesisTakeRoomExitRecord or {}
	CurrentRun.NPCShopItemStolenRecord = CurrentRun.NPCShopItemStolenRecord or {}

	CurrentRun.WorldUpgradesAdded = CurrentRun.WorldUpgradesAdded or {}
	CurrentRun.WorldUpgradesViewed = CurrentRun.WorldUpgradesViewed or {}
	CurrentRun.WorldUpgradesRevealed = CurrentRun.WorldUpgradesRevealed or {}
	CurrentRun.SpellCharge = CurrentRun.SpellCharge or 0

	if CurrentRun.Hero ~= nil then
		CurrentRun.Hero.ObjectId = nil
	end

end

function StartNewRun( prevRun, args )

	args = args or {}
	SetupRunData()
	ResetUI()

	CurrentRun = {}
	RunStateInit()
	CurrentRun.Revision = Revision

	if args.RunOverrides ~= nil then
		OverwriteTableKeys( CurrentRun, args.RunOverrides )
	end

	for name, value in pairs( GameState.ShrineUpgrades ) do
		ShrineUpgradeExtractValues( name )
	end
	
	CurrentRun.ActiveBounty = args.ActiveBounty
	CurrentRun.ForceNextEncounterData = args.Encounter
	CurrentRun.Hero = CreateNewHero( prevRun, args )
	
	if GameState.WorldUpgrades.WorldUpgradeUnusedWeaponBonus ~= nil then
		if prevRun ~= nil and prevRun.BonusUnusedWeaponName ~= nil and CurrentRun.Hero.Weapons[prevRun.BonusUnusedWeaponName] then
			if GameState.WorldUpgrades.WorldUpgradeUnusedWeaponBonusT2 then
				AddTrait( CurrentRun.Hero, "UnusedWeaponBonusTrait2" )
			else
				AddTrait( CurrentRun.Hero, "UnusedWeaponBonusTrait" )
			end
		end
	end

	local bountyData = BountyData[args.ActiveBounty]
	if bountyData ~= nil and bountyData.StartingTraits ~= nil then
		LoadActiveBountyPackages()
		for i, traitData in ipairs( bountyData.StartingTraits ) do
			AddTrait( CurrentRun.Hero, traitData.Name, traitData.Rarity, { FromLoot = true })
		end
	end
	
	GameState.FatedStatus = "Unknown"
	UpdateFateStatus()
	EquipKeepsake( CurrentRun.Hero, GameState.LastAwardTrait, { FromLoot = true, SkipNewTraitHighlight = true, AddToCache = true })
	EquipFamiliar( nil, { Unit = CurrentRun.Hero, FamiliarName = GameState.EquippedFamiliar } )
	EquipWeaponUpgrade( CurrentRun.Hero, { SkipNewTraitHighlight = true, SkipUIUpdate = true } )
	EquipMetaUpgrades( CurrentRun.Hero, { SkipNewTraitHighlight = true })
	UpdateRunHistoryCache( CurrentRun )

	CurrentRun.BonusUnusedWeaponName = GetRandomUnequippedWeapon( prevRun )
	CurrentRun.ActiveBiomeTimer = GetNumShrineUpgrades("BiomeSpeedShrineUpgrade") > 0
	CurrentRun.NumRerolls = GetTotalHeroTraitValue( "RerollCount" )
	CurrentRun.NumTalentPoints = GetTotalHeroTraitValue("TalentPointCount")
	CurrentRun.ActiveBountyClears = GameState.PackagedBountyClears[CurrentRun.ActiveBounty] or 0
	CurrentRun.ActiveBountyAttempts = GameState.PackagedBountyAttempts[CurrentRun.ActiveBounty] or 0
	CurrentRun.SpellCharge = 5000

	if ConfigOptionCache.EasyMode then
		CurrentRun.EasyModeLevel = GameState.EasyModeLevel
	end

	InitHeroLastStands( CurrentRun.Hero )
	UpdateHeroTraitDictionary()

	InitializeRewardStores( CurrentRun )
	--SelectBannedEliteAttributes( CurrentRun )

	if args.RoomName ~= nil then
		CurrentRun.CurrentRoom = CreateRoom( RoomData[args.RoomName], args )
	else
		CurrentRun.CurrentRoom = ChooseStartingRoom( CurrentRun, args )
	end
	if args.StartingRoomOverrides ~= nil then
		OverwriteTableKeys( CurrentRun.CurrentRoom, args.StartingRoomOverrides )
	end
	
	AddResource( "Money", CalculateStartingMoney(), "RunStart" )
	return CurrentRun

end

function UpdateWeaponHistory(currentRun)
	local eligibleMeleeWeapons = GetEligibleMeleeWeapons()
	for index, weaponData in pairs(eligibleMeleeWeapons) do
		local weaponName = weaponData.Name
		if GameState.WeaponHistory[weaponName] == nil then
			GameState.WeaponHistory[weaponName] = 0
		end

		if currentRun.Hero.Weapons[weaponName] then
			GameState.WeaponHistory[weaponName] = 0
		else
			GameState.WeaponHistory[weaponName] = GameState.WeaponHistory[weaponName] + 1
		end
	end
end

function ChooseStartingRoom( currentRun, args )

	local eligibleRooms = {}
	local forcedRooms = {}
	for i, roomName in ipairs( RoomSets[args.StartingBiome] ) do
		local roomData = RoomData[roomName]
		if roomData.Starting and IsRoomEligible( currentRun, nil, roomData ) then
			table.insert( eligibleRooms, roomData )
			if IsRoomForced( currentRun, nil, roomData ) then
				table.insert( forcedRooms, roomData )
			end
		end
	end

	local startingRoomData = nil
	if not IsEmpty( forcedRooms ) then
		startingRoomData = GetRandomValue( forcedRooms )
	else
		startingRoomData = GetRandomValue( eligibleRooms )
	end

	local startingRoom = CreateRoom( startingRoomData, args )
	return startingRoom

end

function RoomInit( room )
	room.MusicRecord = room.MusicRecord or {}
	room.MusicEndRecord = room.MusicEndRecord or {}
	room.SpawnPoints = room.SpawnPoints or {}
	room.EliteAttributes = room.EliteAttributes or {}
	room.SpeechRecord = room.SpeechRecord or {}
	room.TextLinesRecord = room.TextLinesRecord or {}
	room.TraitUses = room.TraitUses or {}
	room.ExitDoorRooms = room.ExitDoorRooms or {}
	room.TimesVisited = room.TimesVisited or 0
	room.SpawnThreads = room.SpawnThreads or {}
	room.ActiveEncounters = room.ActiveEncounters or {}
	room.EncountersOccurredCache = room.EncountersOccurredCache or {}
	room.Kills = room.Kills or {}
	room.UnavailableDoors = room.UnavailableDoors or {}
	room.RoomCreations = room.RoomCreations or {}
	room.NemesisTakeExitRecord = room.NemesisTakeExitRecord or {}
	room.NemesisTakeRoomExitRecord = room.NemesisTakeRoomExitRecord or {}
	room.UseRecord = room.UseRecord or {}
	room.NumHarvestPoints = room.NumHarvestPoints or 0
	room.NumShovelPoints = room.NumShovelPoints or 0
	room.NumPickaxePoints = room.NumPickaxePoints or 0
	room.NumExorcismPoints = room.NumExorcismPoints or 0
	room.NumFishingPoints = room.NumFishingPoints or 0
	room.BloodDropCount = room.BloodDropCount or 0
	room.BloodDropBonus = room.BloodDropBonus or 0
	room.BloodDropRequirement = room.BloodDropRequirement or 1
	room.LastStandsUsed = room.LastStandsUsed or {}
	room.ForcedBoonNames = room.ForcedBoonNames or {}
end

function CreateRoom( roomData, args )
	
	args = args or {}

	local room = DeepCopyTable( roomData )
	RoomInit( room )
	if args.RoomOverrides ~= nil then
		for key, value in pairs( args.RoomOverrides ) do
			room[key] = value
		end
	end

	if args.RewardStoreName == nil then
		local roomName = room.GenusName or room.Name
		args.RewardStoreName = room.ForcedRewardStore or "RunProgress"
	end
	
	if not args.SkipChooseEncounter then
		if room.MultipleEncountersData ~= nil then
			SetupRoomMultipleEncountersData(room, args)
		else
			room.Encounter = ChooseEncounter( CurrentRun, room )
			RecordEncounter( CurrentRun, room.Encounter )
		end
	end

	if not args.SkipChooseReward then
		room.RewardStoreName = args.RewardStoreName
		room.ChosenRewardType = ChooseRoomReward( CurrentRun, room, args.RewardStoreName, args.PreviouslyChosenRewards, args )
		SetupRoomReward( CurrentRun, room, args.PreviouslyChosenRewards )
	end

	local secretChance = room.SecretSpawnChance or RoomData.BaseRoom.SecretSpawnChance
	room.SecretChanceSuccess = RandomChance( secretChance )

	local challengeChance = room.ChallengeSpawnChance or RoomData.BaseRoom.ChallengeSpawnChance
	room.ChallengeChanceSuccess = RandomChance( challengeChance )

	local wellShopChance = room.WellShopSpawnChance or RoomData.BaseRoom.WellShopSpawnChance
	room.WellShopChanceSuccess = RandomChance( wellShopChance )

	room.SellShopChanceSuccess = RandomChance( room.SellShopSpawnChance or 0.0 )

	local surfaceShopChance = room.SurfaceShopSpawnChance or RoomData.BaseRoom.SurfaceShopSpawnChance
	room.SurfaceShopChanceSuccess = RandomChance( surfaceShopChance )

	local metaRewardStandChance = room.MetaRewardStandSpawnChance or RoomData.BaseRoom.MetaRewardStandSpawnChance
	metaRewardStandChance = metaRewardStandChance + (room.MetaRewardStandSpawnChanceIncreasePerChamber or RoomData.BaseRoom.MetaRewardStandSpawnChanceIncreasePerChamber) * ( CurrentRun.BiomeDepthCache - 1 )
	room.MetaRewardStandSuccess = RandomChance( metaRewardStandChance )

	local anomalyDoorChance = roomData.AnomalyDoorChance or RoomData.BaseRoom.AnomalyDoorChance
	if anomalyDoorChance ~= nil and GameState.BiomeVisits ~= nil and ( GameState.BiomeVisits.Anomaly == nil or GameState.BiomeVisits.Anomaly < 1 ) then
		anomalyDoorChance = roomData.AnomalyDoorChanceFirstInstance or RoomData.BaseRoom.AnomalyDoorChanceFirstInstance
	end
	room.AnomalyDoorChanceSuccess = RandomChance( anomalyDoorChance )

	if room.LockExtraExitsChance ~= nil and not room.ChallengeChanceSuccess then
		room.LockExtraExits = RandomChance( room.LockExtraExitsChance )
	end

	room.HarvestPointsAllowed = 0
	if room.HasHarvestPoint and IsGameStateEligible( room, room.HarvestPointRequirements or HarvestData.DefaultGameStateRequirements ) then
		for k, spawnChance in ipairs( room.HarvestPointChances or HarvestData.DefaultSpawnChances ) do
			if HasFamiliarTool( "ToolHarvest" ) then
				spawnChance = spawnChance + GetTotalHeroTraitValue( "FamiliarResourceBonusChance" )
			end
			spawnChance = spawnChance * (CurrentRun.HarvestPointChanceMultiplier or 1.0)
			if RandomChance( spawnChance ) or ( k == 1 and room.HarvestPointForceRequirements ~= nil and IsGameStateEligible( room, room.HarvestPointForceRequirements ) ) then
				room.HarvestPointsAllowed = room.HarvestPointsAllowed + 1
			end
		end
	end

	local forceShovelPoint = false
	if room.HasShovelPoint then
		if room.ShovelPointForceRequirements ~= nil and IsGameStateEligible( room, room.ShovelPointForceRequirements ) then
			forceShovelPoint = true
			room.ShovelPointSuccess = true
		elseif IsGameStateEligible( room, room.ShovelPointRequirements or ShovelPointData.DefaultGameStateRequirements ) then
			local shovelPointChance = GetHarvestPointSpawnChance( ShovelPointData, room ) * (CurrentRun.ShovelPointChanceMultiplier or 1.0)
			room.ShovelPointSuccess = RandomChance( shovelPointChance )
		end
	end

	local forcePickaxePoint = false
	if room.HasPickaxePoint then
		if room.PickaxePointForceRequirements ~= nil and IsGameStateEligible( room, room.PickaxePointForceRequirements ) then
			forcePickaxePoint = true
			room.PickaxePointSuccess = true
		elseif IsGameStateEligible( room, room.PickaxePointRequirements or PickaxePointData.DefaultGameStateRequirements ) then
			local pickaxePointChance = GetHarvestPointSpawnChance( PickaxePointData, room ) * (CurrentRun.PickaxePointChanceMultiplier or 1.0)
			room.PickaxePointSuccess = RandomChance( pickaxePointChance )
		end
	end

	if room.HasExorcismPoint and IsGameStateEligible( room, room.ExorcismPointRequirements or ExorcismData.DefaultGameStateRequirements ) then
		local exorcismPointChance = GetHarvestPointSpawnChance( ExorcismData, room ) * (CurrentRun.ExorcismPointChanceMultiplier or 1.0)
		room.ExorcismPointSuccess = RandomChance( exorcismPointChance )
	end

	if room.HasFishingPoint and IsGameStateEligible( room, room.FishingPointRequirements or FishingData.DefaultGameStateRequirements ) then
		local fishingPointChance = GetHarvestPointSpawnChance( FishingData, room ) * (CurrentRun.FishingPointChanceMultiplier or 1.0)
		room.FishingPointSuccess = RandomChance( fishingPointChance )
	end

	if room.AllowOnlyOneToolHarvestableResource then
		local toolSuccesses = FYShuffle( { "ShovelPointSuccess", "PickaxePointSuccess", "ExorcismPointSuccess", "FishingPointSuccess" } )
		local choseHarvestPoint = false
		for i, toolSuccess in ipairs( toolSuccesses ) do
			if room[toolSuccess] then
				if choseHarvestPoint then
					room[toolSuccess] = false
				end
				choseHarvestPoint = true
			end
		end
	else
		-- Allow one simple harvest
		if room.ShovelPointSuccess and room.PickaxePointSuccess then
			-- forced points take priority
			if forceShovelPoint then
				room.PickaxePointSuccess = false
			elseif forcePickaxePoint then
				room.ShovelPointSuccess = false
			elseif CoinFlip() then
				room.ShovelPointSuccess = false
			else
				room.PickaxePointSuccess = false
			end
		end

		-- Allow one complex harvest
		if room.ExorcismPointSuccess and room.FishingPointSuccess then
			if CoinFlip() then
				room.ExorcismPointSuccess = false
			else
				room.FishingPointSuccess = false
			end
		end
	end

	CurrentRun.RoomCreations[room.Name] = (CurrentRun.RoomCreations[room.Name] or 0) + 1
	if CurrentRun.CurrentRoom ~= nil then
		CurrentRun.CurrentRoom.RoomCreations[room.Name] = (CurrentRun.CurrentRoom.RoomCreations[room.Name] or 0) + 1
	end

	return room
end

function CheckPreviousReward( currentRun, room, previouslyChosenRewards, args )
	if currentRun.CurrentRoom ~= nil then
		if currentRun.CurrentRoom.DeferReward then
			room.UseOptionalOverrides = currentRun.CurrentRoom.UseOptionalOverrides or currentRun.CurrentRoom.UseExitOverrides -- UseExitOverrides is for backwards compatability
			room.ForceLootName = currentRun.CurrentRoom.ForceLootName
		elseif currentRun.CurrentRoom.PersistentExitDoorRewards and args.Door ~= nil then
			for roomIndex = #CurrentRun.RoomHistory, 1, -1 do
				local prevRoom = CurrentRun.RoomHistory[roomIndex]
				if currentRun.CurrentRoom.Name == prevRoom.Name and prevRoom.OfferedRewards ~= nil and prevRoom.OfferedRewards[args.Door.ObjectId] ~= nil then
					room.UseOptionalOverrides = prevRoom.OfferedRewards[args.Door.ObjectId].UseOptionalOverrides or prevRoom.OfferedRewards[args.Door.ObjectId].UseExitOverrides -- UseExitOverrides is for backwards compatability
					room.ForceLootName = prevRoom.OfferedRewards[args.Door.ObjectId].ForceLootName
					return prevRoom.OfferedRewards[args.Door.ObjectId]
				end
			end
		end
	end
	return nil
end



function HandleSubRoomData(source, args)
	CurrentRun.CurrentRoom.HeroStartPoint = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetIdsByType({ Name = "HeroStart" }) })
	CurrentRun.CurrentRoom.HeroEndPoint = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetIdsByType({ Name = "HeroEnd" }) })
end

function HandleSubRoomReturnData(source, args)
	CurrentRun.CurrentRoom.StartRoomPresentationOnReload = true
end

function ChooseNextRoomData( currentRun, args, otherDoors )

	args = args or {}

	local currentRoom = currentRun.CurrentRoom
	local currentRoomData = RoomData[currentRoom.Name] or currentRoom
	local roomSetName = args.RoomSetName or currentRun.CurrentRoom.RoomSetName or "F"
	if args.ForceNextRoomSet ~= nil or currentRoom.ForceNextRoomSet ~= nil then
		roomSetName = args.ForceNextRoomSet or currentRoom.ForceNextRoomSet
	elseif currentRoom.NextRoomSet ~= nil then
		roomSetName = GetRandomValue( currentRoom.NextRoomSet )
	elseif currentRoom.UsePreviousRoomSet then
		local previousRoom = GetPreviousRoom( currentRun ) or currentRoom
		roomSetName = previousRoom.RoomSetName
	end

	local nextRoomData = nil
	if ForceNextRoom ~= nil and RoomData[ForceNextRoom] ~= nil then
		nextRoomData = RoomData[ForceNextRoom]
	elseif args.ForceNextRoom ~= nil and RoomData[args.ForceNextRoom] ~= nil then
		nextRoomData = RoomData[args.ForceNextRoom]
	elseif (currentRoomData.LinkedRoom ~= nil or currentRoomData.LinkedRooms ~= nil) and args.ForceNextRoomSet == nil then
		local nextRoomName = currentRoomData.LinkedRoom
		if currentRoomData.LinkedRooms ~= nil then
			local eligibleRoomNames = {}
			local forcedRoomNames = {}
			for i, linkedRoomName in ipairs( CollapseTableOrdered( currentRoomData.LinkedRooms ) ) do
				if IsRoomEligible( currentRun, currentRoomData, RoomData[linkedRoomName], args ) then
					table.insert( eligibleRoomNames, linkedRoomName )
					if IsRoomForced( currentRun, currentRoomData, RoomData[linkedRoomName], args, otherDoors ) then
						table.insert( forcedRoomNames, linkedRoomName )
					end
				end
			end
			if not IsEmpty( forcedRoomNames ) then
				nextRoomName = GetRandomValue( forcedRoomNames )
			else
				nextRoomName = GetRandomValue( eligibleRoomNames )
			end
		end

		if nextRoomName ~= nil then
			nextRoomData = RoomData[nextRoomName]
		end
	end

	if nextRoomData == nil then
		local eligibleRooms = {}
		local forcedRooms = {}
		local roomSet = RoomSets[roomSetName]
		for i, roomName in ipairs( roomSet ) do
			local roomData = RoomData[roomName]
			if IsRoomEligible( currentRun, currentRoom, roomData, args ) then
				table.insert( eligibleRooms, roomData )
				if IsRoomForced( currentRun, currentRoom, roomData, args, otherDoors ) then
					table.insert( forcedRooms, roomData )
				end
			end
		end
		if not IsEmpty( forcedRooms ) then
			nextRoomData = GetRandomValue( forcedRooms )
		else
			nextRoomData = GetRandomValue( eligibleRooms )
		end
	end

	if currentRoom.DoAnomalies and nextRoomData.AllowAnomalyReplacement then
		nextRoomData = ChooseNextRoomData( currentRun, { ForceNextRoomSet = "Anomaly" } )
		nextRoomData.PrevRoomExitFunctionName = "ExitToAnomalyPresentation"
		-- LoadPackages({ Names = "Chronos", IgnoreAssert = true })
	end

	DebugAssert({ Condition = nextRoomData ~= nil, Text = "No eligible rooms for exit door!", Owner = "Eduardo" })
	return nextRoomData

end

function IsRoomForced( currentRun, currentRoom, nextRoomData, args, otherDoors )
	if nextRoomData.AlwaysForce then
		return true
	end

	if nextRoomData.AlwaysForceRequirements ~= nil and IsGameStateEligible( nextRoomData, nextRoomData.AlwaysForceRequirements ) then
		return true
	end

	if nextRoomData.AlwaysForceOncePerRoom and otherDoors ~= nil then
		local roomAlreadyChosen = false
		for index, door in ipairs( otherDoors ) do
			if door.Room ~= nil and door.Room.Name == nextRoomData.Name then
				roomAlreadyChosen = true
			end
		end
		if not roomAlreadyChosen then
			return true
		end
	end

	if nextRoomData.ForceIfEncounterNotCompleted ~= nil and not HasEncounterBeenCompleted( nextRoomData.ForceIfEncounterNotCompleted ) then
		return true
	end

	if nextRoomData.ForceIfUnseenForRuns ~= nil and not HasSeenRoomInNumRuns( nextRoomData.Name, nextRoomData.ForceIfUnseenForRuns ) then
		DebugPrint({ Text = "Forcing = "..nextRoomData.Name })
		return true
	end

	args = args or{}

	local currentRunDepth = currentRun.RunDepthCache
	if nextRoomData.ForceAtRunDepth ~= nil and currentRunDepth == nextRoomData.ForceAtRunDepth then
		return true
	end
	if nextRoomData.ForceAtRunDepthMin ~= nil and currentRunDepth >= nextRoomData.ForceAtRunDepthMin then
		if currentRunDepth >= nextRoomData.ForceAtRunDepthMax then
			return true
		else
			local forcedChance = 1 / (nextRoomData.ForceAtRunDepthMax - currentRunDepth)
			if RandomChance( forcedChance ) then
				return true
			end
		end
	end
	local currentBiomeDepth = currentRun.BiomeDepthCache
	if nextRoomData.ForceAtBiomeDepth ~= nil and currentBiomeDepth == nextRoomData.ForceAtBiomeDepth then
		return true
	end
	if nextRoomData.ForceAtBiomeDepthMin ~= nil and currentBiomeDepth >= nextRoomData.ForceAtBiomeDepthMin then
		if currentBiomeDepth >= nextRoomData.ForceAtBiomeDepthMax then
			return true
		else
			local forcedChance = 1 / (nextRoomData.ForceAtBiomeDepthMax - currentBiomeDepth)
			if RandomChance( forcedChance ) then
				return true
			end
		end
	end

	return false

end

function IsRoomEligible( currentRun, currentRoom, nextRoomData, args )
	if args == nil then
		args = {}
	end

	if nextRoomData == nil then
		return false
	end

	local excludedNames = args.ExcludedNames
	local excludedTypes = args.ExcludedTypes
	local excludedRewards = args.ExcludedRewards

	if nextRoomData.DebugOnly then
		return false
	end

	if excludedNames ~= nil and excludedNames[nextRoomData.Name] then
		return false
	end

	if excludedTypes ~= nil and excludedTypes[nextRoomData.Type] then
		return false
	end

	if excludedRewards ~= nil and not IsEmpty(nextRoomData.RewardTypes) and ContainsAll(excludedRewards, nextRoomData.RewardTypes) then
		return false
	end

	if nextRoomData.ForceAtBiomeDepth ~= nil and currentRun.BiomeDepthCache ~= nextRoomData.ForceAtBiomeDepth then
		return false
	end
	if nextRoomData.ForceAtBiomeDepthMin ~= nil and currentRun.BiomeDepthCache < nextRoomData.ForceAtBiomeDepthMin then
		return false
	end

	if args.RequireTags ~= nil then
		nextRoomData.Tags = nextRoomData.Tags or {}

		if not ContainsAll(nextRoomData.Tags, args.RequireTags) then
			return false
		end
	end

	if currentRoom ~= nil then
		if nextRoomData.Name == currentRoom.Name then
			return false
		end
		if nextRoomData.RequiresLinked then
			if currentRoom.LinkedRoom ~= nextRoomData.Name and ( currentRoom.LinkedRooms == nil or not Contains( currentRoom.LinkedRooms, nextRoomData.Name ) ) then
				return false
			end
		end

		-- If in a MiniBoss wing and we are not a MiniBoss, we are ineligible (except Reprieve)
		if currentRoom.RequireWingEndMiniBoss and nextRoomData.WingEndRoom and not nextRoomData.WingEndMiniBoss and not nextRoomData.AllowAsAnyWingEnd then
			return false
		end

		-- If in a regular wing and we are a MiniBoss room, we are ineligible (except Reprieve)
		if not currentRoom.RequireWingEndMiniBoss and nextRoomData.WingEndRoom and nextRoomData.WingEndMiniBoss and not nextRoomData.AllowAsAnyWingEnd then
			return false
		end

		if args.OutdoorRequiresIndoorTag and currentRoom.Tags ~= nil and Contains(currentRoom.Tags, "Outdoor") then
			if not Contains(nextRoomData.Tags, "Indoor") then
				return false
			end
		end

		if nextRoomData.MaxCreationsPerRoom ~= nil and currentRoom.RoomCreations[nextRoomData.Name] ~= nil and currentRoom.RoomCreations[nextRoomData.Name] >= nextRoomData.MaxCreationsPerRoom then
			return false
		end
	end

	if nextRoomData.MaxAppearancesThisRun ~= nil and currentRun.RoomCountCache[nextRoomData.Name] ~= nil and currentRun.RoomCountCache[nextRoomData.Name] >= nextRoomData.MaxAppearancesThisRun then
		return false
	end
	if nextRoomData.MaxAppearancesThisBiome ~= nil and currentRun.BiomeRoomCountCache[nextRoomData.Name] ~= nil and currentRun.BiomeRoomCountCache[nextRoomData.Name] >= nextRoomData.MaxAppearancesThisBiome then
		return false
	end

	if nextRoomData.MaxCreationsThisRun ~= nil and currentRun.RoomCreations[nextRoomData.Name] ~= nil and currentRun.RoomCreations[nextRoomData.Name] >= nextRoomData.MaxCreationsThisRun then
		return false
	end

	if nextRoomData.GameStateRequirements ~= nil and not IsGameStateEligible( nextRoomData, nextRoomData.GameStateRequirements, args ) then
		return false
	end
	return true

end

function CheckReloadEncounters(room, args)
	local encounter = ChooseEncounter( CurrentRun, room, args )
	thread(StartEncounter, CurrentRun, room, encounter)
end

function ChooseEncounter( currentRun, room, args )
	args = args or {}

	DebugAssert({ Condition = room ~= nil, Text = "Choosing an encounter for a nil room!" })

	local encounterData = nil
	if ForceNextEncounter ~= nil then
		DebugPrint({ Text = "ForceNextEncounter = "..tostring(ForceNextEncounter) })
		encounterData = EncounterData[ForceNextEncounter]
		encounterData.SkipIntroEncounterCheck = true
		ForceNextEncounter = nil
	elseif currentRun.ForceNextEncounterData ~= nil then
		encounterData = currentRun.ForceNextEncounterData
	elseif HasHeroTraitValue( "ForceThanatosEncounter" ) then
		local legalEncounters = {}
		for i, encounterName in pairs( EncounterSets.ThanatosEncounters ) do
			if IsEncounterEligible( currentRun, room, EncounterData[encounterName], args ) then
				table.insert(legalEncounters, encounterName )
			end
		end
		if not IsEmpty( legalEncounters ) then
			UseHeroTraitsWithValue( "ForceThanatosEncounter", true )
			encounterData = EncounterData[legalEncounters[1]]
		end
	end

	if not encounterData then
		local eligibleEncounters = {}
		local forcedEncounters = {}
		local legalEncounters = args.LegalEncounters or room.LegalEncounters
		if legalEncounters ~= nil then
			for k, encounterName in pairs( legalEncounters ) do
				local encounterData = EncounterData[encounterName]
				if IsEncounterEligible( currentRun, room, encounterData, args ) then
					table.insert( eligibleEncounters, encounterData )
					if IsEncounterForced( currentRun, room, encounterData ) then
						table.insert( forcedEncounters, encounterData )
					end
				end
			end
		else
			for encounterName, encounterData in pairs( EncounterData ) do
				if IsEncounterEligible( currentRun, room, encounterData, args ) then
					table.insert( eligibleEncounters, encounterData )
					if IsEncounterForced( currentRun, room, encounterData ) then
						table.insert( forcedEncounters, encounterData )
					end
				end
			end
		end

		local roomName = room.Name
		if roomName == nil then
			roomName = GetKey(RoomData, room)
		end

		if roomName == nil then
			roomName = tostring(room.HelpTextId)..":"..tostring(room.Type)..":"..tostring(room.LegalEncounters[1])
		end

		DebugAssert({ Condition = not IsEmpty( eligibleEncounters ) or not IsEmpty(forcedEncounters), Text = "No encounters available for "..tostring(roomName).."!" })

		if not IsEmpty( forcedEncounters ) then
			encounterData = GetRandomValue( forcedEncounters )
		else
			encounterData = GetRandomValue( eligibleEncounters )
		end

		if encounterData.EnemySet ~= nil then
			for k, enemyName in pairs(encounterData.EnemySet) do
				if EnemyData[enemyName].ForceIntroduction and not HasEncounterBeenCompleted(EnemyData[enemyName].IntroEncounterName) then
					local introEncounter = EncounterData[EnemyData[enemyName].IntroEncounterName]
					if introEncounter ~= nil then
						encounterData = introEncounter
					else
						DebugAssert({ Condition = false, Text = "IntroEncounter does not exist for "..enemyName })
					end
				end
			end
		end
	end

	local encounter = SetupEncounter(encounterData, room)

	return encounter

end

function SetupEncounter( encounterData, room )
	local encounter = DeepCopyTable( encounterData )

	room = room or CurrentRun.CurrentRoom
	if room.RewardOverrides ~= nil and room.RewardOverrides.MakeHardEncounter then
		encounter.IsHardEncounter = true
	end

	if encounter.Generated then
		GenerateEncounter(CurrentRun, room, encounter)
	end

	if encounter.SetupEvents ~= nil then
		RunEventsGeneric( encounter.SetupEvents, encounter, room )
	end

	-- Check if enemies need to be introduced
	if encounter ~= nil and encounter.SpawnWaves ~= nil and not encounter.SkipIntroEncounterCheck then
		for k, wave in pairs(encounter.SpawnWaves) do
			for k, spawnData in pairs(wave.Spawns) do
				local introEncounterName = EnemyData[spawnData.Name].IntroEncounterName
				if introEncounterName ~= nil and not HasEncounterBeenCompleted(introEncounterName) then
					local introEncounterData = EncounterData[introEncounterName]
					if introEncounterData.GameStateRequirements == nil or IsGameStateEligible( introEncounterData, introEncounterData.GameStateRequirements ) then
						encounter = DeepCopyTable( introEncounterData )
						if encounter.SetupEvents ~= nil then
							RunEventsGeneric( encounter.SetupEvents, encounter, room )
						end
						if encounter.Generated then
							GenerateEncounter( CurrentRun, room, encounter )
							return encounter
						end
					end
				end
			end
		end
	end

	return encounter
end

function GenerateEncounter( currentRun, room, encounter )
	local encounterData = EncounterData[encounter.Name]
	if encounter.IsHardEncounter and encounter.HardEncounterOverrideValues then
		DebugPrint({ Text = "Overwriting for hard encounter" })
		OverwriteTableKeys(encounter, encounter.HardEncounterOverrideValues)
	end

	if encounter.UseRoomEncounterEnemySet then
		encounter.EnemySet = room.Encounter.EnemySet
	end

	if encounter.PassiveRoomWeaponsChance ~= nil then
		encounter.SpawnPassiveRoomWeapons = encounter.SpawnPassiveRoomWeapons or {}
		for name, chance in pairs(encounter.PassiveRoomWeaponsChance) do
			if RandomChance(chance) then
				table.insert(encounter.SpawnPassiveRoomWeapons, name)
			end
		end
	end

	if encounter.RandomPrioritizeGroup then
		encounter.PrioritizeGroup = GetRandomValue(encounter.RandomPrioritizeGroup)
	end

	if encounter.RandomizeAmbientBattleDamagePerGroup ~= nil and encounter.AmbientBattleDamagePerGroup == nil then
		encounter.AmbientBattleDamagePerGroup = {}
		for k, groupName in pairs(encounter.RandomizeAmbientBattleDamagePerGroup.GroupNames) do
			encounter.AmbientBattleDamagePerGroup[groupName] = RemoveRandomValue(encounter.RandomizeAmbientBattleDamagePerGroup.BattleDamageDataOptions)
		end
	end

	-- Encounter Difficulty
	local depthDifficultyRamp = encounter.DepthDifficultyRamp or 10
	local difficultyModifer = encounter.DifficultyModifier or 0
	local depthDifficultyMultiplier = encounter.DepthDifficultyMultiplier or 1
	local difficultyMultiplier = encounter.DifficultyMultiplier or 1

	-- resources

	local moneyDropStoreRamp = encounter.MoneyDropCapDepthRamp or 0
	encounter.MoneyDropStore = ( RandomInt( encounterData.MoneyDropCapMin, encounterData.MoneyDropCapMax ) + currentRun.RunDepthCache * moneyDropStoreRamp ) or 0
	encounter.MoneyDropStore = math.ceil( encounter.MoneyDropStore * GetTotalHeroTraitValue("MoneyMultiplier", { IsMultiplier = true }))
	DebugPrint({ Text = "Encounter Money Store Cap: "..tostring( encounter.MoneyDropStore ) })

	local baseDifficulty = encounter.BaseDifficulty or EncounterData.Generated.BaseDifficulty
	if encounter.BaseDifficultyMin ~= nil and encounter.BaseDifficultyMax ~= nil then
		baseDifficulty = RandomInt(encounter.BaseDifficultyMin, encounter.BaseDifficultyMax)
	end
	local depth = currentRun.BiomeDepthCache or 0
	if encounter.UseRunDepth then
		depth = currentRun.RunDepthCache or 0
	elseif encounter.UseEncounterDepth then
		depth = currentRun.BiomeEncounterDepth or 0
	end
	local depthDifficulty = depth * depthDifficultyRamp * depthDifficultyMultiplier
	encounter.DifficultyRating = (baseDifficulty + depthDifficulty + difficultyModifer) * difficultyMultiplier

	DebugPrint({ Text= "Generating "..encounter.Name })
	DebugPrint({ Text= "DepthDifficulty "..depthDifficulty.." = "..depth.." (Depth) * "..depthDifficultyRamp.." (DepthDifficultyRamp) * "..depthDifficultyMultiplier.." (DepthDifficultyMultiplier)" })
	DebugPrint({ Text= "DifficultyRating "..encounter.DifficultyRating.." = "..baseDifficulty.." (BaseDifficulty) + "..depthDifficulty.." (DepthDifficulty) + "..difficultyModifer.." (DifficultyModifier) * "..difficultyMultiplier.." (DifficultyMultiplier)" })

	encounter.DifficultyRating = encounter.DifficultyRating * MetaUpgradeData.EnemyCountShrineUpgrade.ChangeValue

	local minDifficulty = encounter.MinimumDifficulty or ConstantsData.MinimumDifficulty
	encounter.DifficultyRating = math.max( minDifficulty, encounter.DifficultyRating )

	encounter.ActiveEnemyCap = CalculateActiveEnemyCap( currentRun, room, encounter )
	encounter.Blacklist = encounter.Blacklist or {}

	if encounter.BuildCustomEnemySet ~= nil then
		local customEnemySetFunction = _G[encounter.BuildCustomEnemySet]
		customEnemySetFunction( encounter )
	end

	-- Wave Count
	local minWaves = encounter.MinWaves or 1
	local maxWaves = encounter.MaxWaves or 1
	local waveCount = RandomInt(minWaves, maxWaves)
	encounter.WaveCount = waveCount

	-- Wave Setup
	local preExistingWaves = 0
	encounter.SpawnWaves = encounter.SpawnWaves or {}
	for waveIndex=1, waveCount do
		if encounter.SpawnWaves[waveIndex] == nil then
			local waveTemplate = encounter.WaveTemplate
			if encounter.ManualWaveTemplates ~= nil and encounter.ManualWaveTemplates[waveIndex] ~= nil then
				waveTemplate = encounter.ManualWaveTemplates[waveIndex]
			elseif encounter.ManualWaveTemplates ~= nil and encounter.ManualWaveTemplates[-1 * (waveCount - waveIndex)] then
				waveTemplate = encounter.ManualWaveTemplates[-1 * (waveCount - waveIndex)]
			end
			encounter.SpawnWaves[waveIndex] = DeepCopyTable(waveTemplate)
			local wave = encounter.SpawnWaves[waveIndex]
			wave.WaveIndex = waveIndex

			if encounter.NoFirstWaveStartDelay and waveIndex == 1 then
				wave.StartDelay = 0
				wave.OverrideValues = nil
			end

			if waveTemplate.AddAtTime ~= nil then
				wave.AddAtTime = encounter.TimeLimit - (encounter.AddAtTimeInterval * (waveIndex - 1))
			end

			-- Wave Difficulty
			wave.DifficultyRating = WaveDifficultyPatterns[waveCount][waveIndex] * encounter.DifficultyRating
		else
			local wave = encounter.SpawnWaves[waveIndex]
			wave.WaveIndex = waveIndex
			wave.DifficultyRating = WaveDifficultyPatterns[waveCount][waveIndex] * encounter.DifficultyRating
			preExistingWaves = preExistingWaves + 1
		end
	end

	local requireCompletedIntro = encounter.RequireCompletedIntro
	local minDepthBeforeIntros = RoomData.BaseRoom.MinDepthBeforeIntros
	if room ~= nil then
		requireCompletedIntro = encounter.RequireCompletedIntro or room.RequireCompletedIntro
		minDepthBeforeIntros = room.MinDepthBeforeIntros or RoomData.BaseRoom.MinDepthBeforeIntros
	end
	if GetBiomeDepth(CurrentRun) < minDepthBeforeIntros then
		requireCompletedIntro = true
	end


	if not encounter.BlockHighlightEncounter and preExistingWaves == 0 and waveCount > 1 and encounter.EncounterType ~= "SurvivalChallenge" then
		-- Highlight Encounter - Pick an enemy as the highlight in each wave
		DebugPrint({ Text = "Generating Highlght Encounter" })
		local eligibleEnemies = {}
		encounter.SpawnWaves[1].TypeCount = 1
		encounter.SpawnWaves[1].BlockEliteTypes = encounter.BlockHighlightEliteTypes
		encounter.SpawnWaves[1].RequireCompletedIntro = encounter.SpawnWaves[1].RequireCompletedIntro or requireCompletedIntro
		for k, enemyName in pairs( encounter.EnemySet ) do
			if IsEnemyEligible( enemyName, encounter, encounter.SpawnWaves[1] ) then
				table.insert( eligibleEnemies, enemyName )
			end
		end

		if IsEmpty( eligibleEnemies ) then
			DebugAssert({ Condition = true, Text = "No eligible enemies to highlight!" })
		else
			local highlightEnemy = RemoveRandomValue( eligibleEnemies )
			encounter.Blacklist[highlightEnemy] = true
			local waveTypeCount = 1
			for waveNum, wave in ipairs( encounter.SpawnWaves ) do
				AddToSpawnTable( wave.Spawns, highlightEnemy )
				local encounterMaxTypes = math.floor( encounter.MaxTypes + (encounter.TypeCountDepthRamp * GetBiomeDepth(CurrentRun)) )
				wave.TypeCount = math.min( waveTypeCount, encounterMaxTypes )
				waveTypeCount = waveTypeCount + 1

				wave.RequireCompletedIntro = wave.RequireCompletedIntro or requireCompletedIntro
				FillEnemyTypes( encounter, wave, room )
				FillEnemyCounts( encounter, wave, room )
			end
		end
	else
		-- Family Encounter
		DebugPrint({ Text = "Generating Family Encounter" })
		for waveNum, wave in ipairs( encounter.SpawnWaves ) do
			if waveNum > preExistingWaves then
				wave.RequireCompletedIntro = wave.RequireCompletedIntro or requireCompletedIntro
				FillEnemyTypes( encounter, wave, room )
				FillEnemyCounts( encounter, wave, room )
			end
		end
	end
end

function FillEnemyTypes( encounter, wave, room )
	local spawnTable = wave.Spawns

	local typeCountDepthRamp = encounter.TypeCountDepthRamp or 0
	local biomeDepth = GetBiomeDepth(CurrentRun)
	if encounter.UseEncounterDepthForTypes then
		biomeDepth = CurrentRun.BiomeEncounterDepth or 1
	end
	if encounter.EscalateTypeCount then
		local maxTypes = encounter.MaxTypes + (typeCountDepthRamp * biomeDepth)
		DebugPrint({ Text="Max Types Floored ("..math.floor(maxTypes)..") = EncounterMaxTypes ("..encounter.MaxTypes..") + (TypeCountDepthRamp ("..typeCountDepthRamp..") * BiomeDepth ("..biomeDepth.."))" })
		wave.TypeCount = math.floor(maxTypes)
	else
		local minTypes = wave.MinTypes or encounter.MinTypes
		local maxTypes = wave.MaxTypes or math.floor(encounter.MaxTypes + (typeCountDepthRamp * biomeDepth))
		wave.TypeCount = wave.TypeCount or RandomInt(minTypes, maxTypes)
	end
	if wave.TypeCount > encounter.MaxTypesCap then
		wave.TypeCount = encounter.MaxTypesCap
	end

	local eligibleEnemies = {}
	for k, enemyName in pairs( encounter.EnemySet ) do
		if IsEnemyEligible(enemyName, encounter, wave) then
			table.insert(eligibleEnemies, enemyName)
		end
	end

	local removeIndexes = {}
	local eliteCapReached = false
	local eliteTypeCount = 0
	for index, spawnData in pairs( spawnTable ) do
		if spawnData.Name and EnemyData[spawnData.Name] and EnemyData[spawnData.Name].IsElite then
			eliteTypeCount = eliteTypeCount + 1
		end
	end
	for k, index in pairs(removeIndexes) do
		table.remove(spawnTable, index)
	end
	CollapseTable(spawnTable)

	if encounter.MaxEliteTypes ~= nil and eliteTypeCount >= encounter.MaxEliteTypes then
		eliteCapReached = true
		for k, spawnName in pairs(eligibleEnemies) do
			if EnemyData[spawnName].IsElite then
				RemoveValue(eligibleEnemies, spawnName)
			end
		end
	end

	local typesToAdd = wave.TypeCount - TableLength(spawnTable)

	-- Make sure there are enough enemy types to choose from
	local eligibleEnemiesCount = TableLength(eligibleEnemies)
	DebugAssert({ Condition = eligibleEnemiesCount > 0, Text = "No eligible enemies. Did you direct load this map?" })
	if eligibleEnemiesCount < typesToAdd then
		typesToAdd = eligibleEnemiesCount
		DebugPrint({ Text = "Not enough eligible enemies. Reducing type count." })
	end

	for index, spawnData in ipairs( spawnTable ) do
		if spawnData.Generated and spawnData.Name == nil then
			if spawnData.EnemySet ~= nil then
				local uniqueEligibleEnemies = {}
				for k, enemyName in pairs( spawnData.EnemySet ) do
					if IsEnemyEligible(enemyName, encounter, wave) then
						table.insert(uniqueEligibleEnemies, enemyName)
					end
				end
				local newTypeName = RemoveRandomValue(uniqueEligibleEnemies)
				spawnData.Name = newTypeName
			else
				local newTypeName = RemoveRandomValue(eligibleEnemies)
				spawnData.Name = newTypeName
			end
		end
	end

	for i=1, typesToAdd do
		local newTypeName = RemoveRandomValue(eligibleEnemies)
		if newTypeName == nil then
			return
		end
		AddToSpawnTable(spawnTable, newTypeName)
		RemoveAllValues(eligibleEnemies, newTypeName)

		if not eliteCapReached and encounter.MaxEliteTypes ~= nil then
			eliteTypeCount = 0
			for k, spawnData in pairs(spawnTable) do
				if EnemyData[spawnData.Name].IsElite then
					eliteTypeCount = eliteTypeCount + 1
				end
			end

			if eliteTypeCount >= encounter.MaxEliteTypes then
				eliteCapReached = true
				for k, spawnName in pairs(eligibleEnemies) do
					if EnemyData[spawnName].IsElite then
						RemoveValue(eligibleEnemies, spawnName)
					end
				end
			end
		end

		if EnemyData[newTypeName].GeneratorData ~= nil and EnemyData[newTypeName].GeneratorData.BlockEnemyTypes ~= nil then
			for k, enemyType in pairs(EnemyData[newTypeName].GeneratorData.BlockEnemyTypes) do
				RemoveAllValues(eligibleEnemies, enemyType)
				if encounter.BlockTypesAcrossWaves then
					encounter.Blacklist[enemyType] = true
				end
			end
		end

		if encounter.MaxTypesPerGroup ~= nil then
			for allegianceName, maxTypes in pairs(encounter.MaxTypesPerGroup) do
				local allegianceTypeCount = 0
				for k, spawnData in pairs(spawnTable) do
					if Contains(EnemyData[spawnData.Name].Groups, allegianceName) then
						allegianceTypeCount = allegianceTypeCount + 1
					end
				end

				if allegianceTypeCount >= maxTypes then
					for k, spawnName in pairs(eligibleEnemies) do
						if Contains(EnemyData[spawnName].Groups, allegianceName) then
							RemoveValue(eligibleEnemies, spawnName)
						end
					end
				end
			end
		end

		if EnemyData[newTypeName].GeneratorData ~= nil and EnemyData[newTypeName].GeneratorData.ActiveEnemyCapBonus ~= nil then
			encounter.ActiveEnemyCapBonus = encounter.ActiveEnemyCapBonus or 0
			encounter.ActiveEnemyCapBonus = encounter.ActiveEnemyCapBonus + EnemyData[newTypeName].GeneratorData.ActiveEnemyCapBonus
		end

		if encounter.EncounterType == "SurvivalChallenge" then
			if EnemyData[newTypeName].GeneratorData ~= nil and EnemyData[newTypeName].GeneratorData.BlockEnemyTypesSurvival ~= nil then
				for k, enemyType in pairs(EnemyData[newTypeName].GeneratorData.BlockEnemyTypesSurvival) do
					RemoveAllValues(eligibleEnemies, enemyType)
					if encounter.BlockTypesAcrossWaves then
						encounter.Blacklist[enemyType] = true
					end
				end
			end
		end
	end
end

function AddToSpawnTable(spawnTable, newTypeName)
	local newTypeData = { Name = newTypeName, Generated = true }
	table.insert(spawnTable, newTypeData)
end

function CalculateEnemyDifficultyRating( enemyName, room )
	local difficultyRating = EnemyData[enemyName].GeneratorData.DifficultyRating

	if EnemyData[enemyName].IsElite and room.EliteAttributes ~= nil and room.EliteAttributes[enemyName] ~= nil then
		local difficultyRatingMultiplier = 1
		for k, attributeName in pairs(room.EliteAttributes[enemyName]) do
			if EnemyData[enemyName].EliteAttributeData[attributeName].DifficultyRatingMultiplier ~= nil then
				difficultyRatingMultiplier = difficultyRatingMultiplier + EnemyData[enemyName].EliteAttributeData[attributeName].DifficultyRatingMultiplier - 1
			end
		end
		difficultyRating = difficultyRating * difficultyRatingMultiplier
	end

	return difficultyRating

end

function FillEnemyCounts( encounter, wave, room )
	local spawnTable = wave.Spawns

	if encounter.InfiniteSpawns then
		for k, spawnData in ipairs( spawnTable ) do
			if spawnData.Generated or spawnData.CountMin == nil and spawnData.CountMax == nil and spawnData.TotalCount == nil then
				spawnData.InfiniteSpawns = true
			end
		end
		return
	end

	local accumulatedDifficulty = 0
	local generateCount = 0

	for k, spawnData in ipairs( spawnTable ) do
		DebugAssert({ Condition = spawnData.Name ~= nil, Text = "Enemy spawn  is nil. Probably did not have any eligible enemies (because of direct load?)." })

		-- Calculate how much difficulty the pre-made spawns have
		if not spawnData.Generated and ((spawnData.CountMin ~= nil and spawnData.CountMax ~= nil) or spawnData.TotalCount ~= nil) then
			local count = spawnData.TotalCount or spawnData.CountMax
			accumulatedDifficulty = accumulatedDifficulty + (CalculateEnemyDifficultyRating(spawnData.Name, room) * count)
		else
			spawnData.Generated = true
			spawnData.GeneratorData = EnemyData[spawnData.Name].GeneratorData
			generateCount = generateCount + 1
		end
	end

	-- Allot each enemy type their piece of the difficulty pie
	local spareDifficultySpawnData = nil
	for typesGenerated, spawnData in ipairs( spawnTable ) do
		if spawnData.Generated and spawnData.TotalCount == nil then
			spawnData.TotalCount = 0
			local remainingDifficulty = wave.DifficultyRating - accumulatedDifficulty
			local difficultySlice = 0

			if typesGenerated == generateCount then
				if remainingDifficulty < 0 then
					remainingDifficulty = 0
				end

				difficultySlice = remainingDifficulty
			else
				local mean = wave.DifficultyRating/generateCount
				local stddev = mean / 3
				difficultySlice = RandomNormal(mean, stddev)

				if difficultySlice > remainingDifficulty then
					difficultySlice = remainingDifficulty
				end
			end
			
			-- Spawn a minimum of one of each enemy type
			if difficultySlice < spawnData.GeneratorData.DifficultyRating then
				difficultySlice = spawnData.GeneratorData.DifficultyRating
			end

			local allowedCount = math.ceil(difficultySlice / spawnData.GeneratorData.DifficultyRating)

			-- Dont go over a types individual maximum
			if spawnData.GeneratorData.MaxCount ~= nil then
				if allowedCount > spawnData.GeneratorData.MaxCount then
					allowedCount = spawnData.GeneratorData.MaxCount
				end
				if spareDifficultySpawnData ~= nil then
					local spareDifficulty = difficultySlice - (allowedCount * spawnData.GeneratorData.DifficultyRating)
					if spareDifficulty > spareDifficultySpawnData.GeneratorData.DifficultyRating then
						local additionalCount = math.ceil(spareDifficulty / spareDifficultySpawnData.GeneratorData.DifficultyRating)
						spareDifficultySpawnData.TotalCount = spareDifficultySpawnData.TotalCount + additionalCount
						DebugPrint({ Text=spawnData.Name.." has MaxCount and therefore "..spareDifficulty.." spare difficulty." })
						DebugPrint({ Text="Adding "..additionalCount.." more "..spareDifficultySpawnData.Name })
					end
				end
			else
				spareDifficultySpawnData = spawnData
			end

			-- Spawn a minimum of one of each enemy type
			if allowedCount < 1 then
				allowedCount = 1
			end

			spawnData.TotalCount = spawnData.TotalCount + allowedCount

			local typeDifficulty = CalculateEnemyDifficultyRating(spawnData.Name, room) * allowedCount
			accumulatedDifficulty = accumulatedDifficulty + typeDifficulty
		end
	end
end

function IsEnemyEligible( enemyName, encounter, wave )

	local enemyData = EnemyData[enemyName]
	local encounter = encounter or CurrentRun.CurrentRoom.Encounter or {}

	if enemyData.IneligibleIfUncompletedIntroEncounter and enemyData.IntroEncounterName ~= nil and not HasEncounterBeenCompleted(enemyData.IntroEncounterName) then
		return false
	end
	if wave ~= nil and wave.RequireCompletedIntro and enemyData.IntroEncounterName ~= nil and not HasEncounterBeenCompleted(enemyData.IntroEncounterName) then
		return false
	end

	if wave ~= nil and wave.BlockEliteTypes	and EnemyData[enemyName	].IsElite then
		return false
	end

	if encounter.Blacklist ~= nil and encounter.Blacklist[enemyName] then
		return false
	end

	for i, traitValue in pairs( GetHeroTraitValues( "BlockedEnemyTypes" )) do
		if Contains( traitValue, enemyName ) then
			return false
		end
	end

	if wave ~= nil then
		if wave.TypeCount == 1 and enemyData.GeneratorData.BlockSolo then
			return false
		end

		local eliteTypeCount = 0
		for k, spawnData in pairs(wave.Spawns) do
			if spawnData.Name ~= nil and enemyName == spawnData.Name then
				return false
			end

			if spawnData.Name ~= nil and EnemyData[spawnData.Name].IsElite then
				eliteTypeCount = eliteTypeCount + 1
			end

			if spawnData.Name ~= nil and EnemyData[spawnData.Name].GeneratorData ~= nil and EnemyData[spawnData.Name].GeneratorData.BlockEnemyTypes ~= nil then
				for k, enemyType in pairs(EnemyData[spawnData.Name].GeneratorData.BlockEnemyTypes) do
					if enemyType == enemyName then
						return false
					end
				end
			end
		end

		if encounter.MaxEliteTypes ~= nil and eliteTypeCount >= encounter.MaxEliteTypes and enemyData.IsElite then
			return false
		end
	end

	if enemyData.GameStateRequirements ~= nil and not IsGameStateEligible( enemyData, enemyData.GameStateRequirements ) then
		return false
	end

	return true
end

function IsEncounterForced( currentRun, room, nextEncounterData )

	if nextEncounterData.AlwaysForce then
		return true
	end

	if nextEncounterData.ForceIfEncounterNotCompleted ~= nil and not HasEncounterBeenCompleted( nextEncounterData.ForceIfEncounterNotCompleted ) then
		return true
	end

	if nextEncounterData.ForceIfRoomReward ~= nil and nextEncounterData.ForceIfRoomReward == room.Reward then
		return true
	end

	return false

end

function IsEncounterEligible( currentRun, room, nextEncounterData, args )
	if args ~= nil and args.LegalEncounters ~= nil then
		if not Contains(args.LegalEncounters, nextEncounterData.Name) then
			return false
		end
	else
		if room.LegalEncounters ~= nil and not room.LegalEncountersDictionary[nextEncounterData.Name] then
			return false
		end
	end

	if room.IllegalEncounters ~= nil and room.IllegalEncountersDictionary[nextEncounterData.Name] then
		return false
	end

	if nextEncounterData.RequireRoomTag ~= nil and not Contains(room.Tags, nextEncounterData.RequireRoomTag) then
		return false
	end

	if nextEncounterData.RequireRoomReward ~= nil and nextEncounterData.RequireRoomReward ~= room.ChosenRewardType then
		return false
	end

	if nextEncounterData.RequireAnyRoomReward ~= nil and not ContainsAny(nextEncounterData.RequireAnyRoomReward, { room.ChosenRewardType }) then
		return false
	end

	if nextEncounterData.RequireNotRoomReward ~= nil and Contains(nextEncounterData.RequireNotRoomReward, room.ChosenRewardType) then
		return false
	end

	if nextEncounterData.MaxAppearancesThisRun ~= nil and currentRun.EncountersOccurredCache[nextEncounterData.Name] ~= nil and currentRun.EncountersOccurredCache[nextEncounterData.Name] >= nextEncounterData.MaxAppearancesThisRun then
		return false
	end
	if nextEncounterData.MaxAppearancesThisBiome ~= nil and currentRun.EncountersOccurredBiomeCache[nextEncounterData.Name] ~= nil and currentRun.EncountersOccurredBiomeCache[nextEncounterData.Name] >= nextEncounterData.MaxAppearancesThisBiome then
		return false
	end

	if nextEncounterData.MinRoomsBetweenType ~= nil and currentRun.EncountersDepthCache[nextEncounterData.Name] ~= nil then
		local roomsSinceType = currentRun.RunDepthCache - currentRun.EncountersDepthCache[nextEncounterData.Name]
		if roomsSinceType < nextEncounterData.MinRoomsBetweenType then
			return false
		end
	end

	if nextEncounterData.MinRunsSinceThanatosSpawn ~= nil then
		--DebugPrint({ Text = "nextEncounterData.MinRunsSinceThanatosSpawn = "..nextEncounterData.MinRunsSinceThanatosSpawn })
		local runsSinceOccurred = 0
		for runIndex = #GameState.RunHistory + 1, 1, -1 do
			local prevRun = GameState.RunHistory[runIndex] or currentRun
			if prevRun.ThanatosSpawns ~= nil and prevRun.ThanatosSpawns > 0 then
				if runsSinceOccurred < nextEncounterData.MinRunsSinceThanatosSpawn then
					--DebugPrint({ Text = "runsSinceOccurred = "..runsSinceOccurred })
					return false
				end
			end
			runsSinceOccurred = runsSinceOccurred + 1
			if runsSinceOccurred > nextEncounterData.MinRunsSinceThanatosSpawn then
				--DebugPrint({ Text = "runsSinceOccurred = "..runsSinceOccurred })
				break
			end
		end
	end

	if currentRun.BlockedEncounters[nextEncounterData.Name] then
		return false
	end

	if nextEncounterData.BlockedByPreviousEncountersThisRun ~= nil then
		for k, blockingEncounterName in pairs( nextEncounterData.BlockedByPreviousEncountersThisRun ) do
			if HasEncounterOccurred( currentRun, blockingEncounterName ) then
				return false
			end
		end
	end

	if nextEncounterData.GameStateRequirements ~= nil and not IsGameStateEligible( nextEncounterData, nextEncounterData.GameStateRequirements ) then
		return false
	end

	return true

end

function HasEncounterOccurred( currentRun, encounterName, requireCompleted )

	if requireCompleted then
		if currentRun.EncountersCompletedCache[encounterName] ~= nil then
			return true
		end
	else
		if currentRun.EncountersOccurredCache[encounterName] ~= nil then
			return true
		end
	end

	return false

end

function HasEncounterBeenCompleted( encounterName )

	if CurrentRun.EncountersCompletedCache[encounterName] ~= nil then
		return true
	end

	if GameState.EncountersCompletedCache[encounterName] ~= nil then
		return true
	end

	return false
end

function IsInspectPointEligible( currentRun, source, inspectPointData )

	if verboseLogging and inspectPointData.InteractTextLineSets ~= nil and TableLength( inspectPointData.InteractTextLineSets ) >= 2 then
		DebugAssert({ Condition = false, Text = "InspectPoint with more than 1 TextLine found ("..GetFirstKey( inspectPointData.InteractTextLineSets )..")", Owner = "Gavin" })
	end

	if inspectPointData.PlayOnce then
		if inspectPointData.InteractTextLineSets ~= nil then
			for textLineName, textLine in pairs( inspectPointData.InteractTextLineSets ) do
				if GameState.TextLinesRecord[textLineName] then
					return false
				end
			end
		end
	end

	if inspectPointData.PlayOnceThisRun then
		if inspectPointData.InteractTextLineSets ~= nil then
			for textLineName, textLine in pairs( inspectPointData.InteractTextLineSets ) do
				if CurrentRun.TextLinesRecord[textLineName] then
					return false
				end
			end
		end
	end

	if inspectPointData.SetupGameStateRequirements ~= nil and not IsGameStateEligible( inspectPointData, inspectPointData.SetupGameStateRequirements ) then
		return false
	end

	return true
end

function GetInteractedGods()
	local interactedGods = {}
	if GameState.LootPickups ~= nil then
		for lootName, amount in pairs( GameState.LootPickups ) do
			if amount >= 1 then
				table.insert( interactedGods, lootName )
			end
		end
	end
	return interactedGods
end

function GetEligibleInteractedGods( ignoredGod )
	local eligibleGods = GetEligibleLootNames( { ignoredGod } )
	local interactedGods = GetInteractedGods()
	local unionGods = {}
	for i, godName in pairs(eligibleGods) do
		if Contains(interactedGods, godName ) then
			table.insert( unionGods, godName )
		end
	end
	if IsEmpty(unionGods) then
		DebugPrint({ Text = "No god both eligible and interacted with! Probably a debug save?"})
		return eligibleGods
	end
	return unionGods
end

function GetEligibleInteractedGod( ignoredGod )
	return GetRandomValue(GetEligibleInteractedGods( ignoredGod ))
end

function GetInteractedGodsThisRun( ignoredGod )
	local interactedGods = {}
	if CurrentRun ~= nil then
		for lootName, i in pairs( CurrentRun.LootTypeHistory ) do
			if LootData[lootName] and LootData[lootName].GodLoot and (ignoredGod == nil or lootName ~= ignoredGod) then
				table.insert( interactedGods, lootName )
			end
		end
	end
	return interactedGods
end

function GetInteractedGodThisRun( ignoredGod )
	return GetRandomValue(GetInteractedGodsThisRun(ignoredGod))
end

function ReachedMaxGods( excludedGods )
	local gods = {}
	if excludedGods ~= nil then
		for i, godName in pairs( excludedGods ) do
			gods[godName] = true
		end
	end
	for i, godName in pairs( GetInteractedGodsThisRun() ) do
		gods[godName] = true
	end
	return TableLength( gods ) >= (CurrentRun.MaxGodsPerRun or HeroData.MaxGodsPerRun)
end

function EndRun( currentRun )
	CurrentRun.EndingRoomName = currentRun.CurrentRoom.Name
	table.insert( GameState.RunHistory, currentRun )
	GameState.CompletedRunsCache = TableLength( GameState.RunHistory )
	CurrentRun.CurrentRoom = nil
	PrevRun = CurrentRun
	CurrentRun = nil
end

function UpdateRunHistoryCache( run, roomAdded )

	run.RoomCountCache = run.RoomCountCache or {}
	run.BiomeRoomCountCache = run.BiomeRoomCountCache or {}

	run.EncountersOccurredCache = run.EncountersOccurredCache or {}
	run.EncountersOccurredBiomeCache = run.EncountersOccurredBiomeCache or {}
	run.EncountersCompletedCache = run.EncountersCompletedCache or {}
	run.EncountersDepthCache = run.EncountersDepthCache or {}

	if run.RoomHistory ~= nil and not IsEmpty( run.RoomHistory ) then
		run.RunDepthCache = GetRunDepth( run )
		run.BiomeDepthCache = GetBiomeDepth( run )
	else
		run.RunDepthCache = run.RunDepthCache or 0
		run.BiomeDepthCache = run.BiomeDepthCache or 0
	end

	if roomAdded ~= nil then
		run.RoomCountCache[roomAdded.Name] = (run.RoomCountCache[roomAdded.Name] or 0) + 1
		run.BiomeRoomCountCache[roomAdded.Name] = (run.BiomeRoomCountCache[roomAdded.Name] or 0) + 1
		GameState.RoomCountCache[roomAdded.Name] = (GameState.RoomCountCache[roomAdded.Name] or 0) + 1
	end

end

function GetRunDepth( currentRun )
	if currentRun.RoomHistory == nil then
		return 1
	end

	local depth = 1 + #currentRun.RoomHistory
	return depth

end

function GetBiomeDepth( currentRun )

	local depth = 1
	if currentRun.CurrentRoom == nil or currentRun.CurrentRoom.NextRoomSet ~= nil then
		-- @refactor Ambiguous point 'between' biomes?
		return depth
	end

	for roomIndex = #currentRun.RoomHistory, 1, -1 do
		local room = currentRun.RoomHistory[roomIndex]
		if room.NextRoomSet ~= nil then
			return depth
		end
		depth = depth + 1
	end
	return depth

end

function EndBiomeRecords( source, args )
	CurrentRun.LootBiomeRecord = {}
	CurrentRun.BiomeUseRecord = {}
	CurrentRun.BiomeRoomCountCache = {}
	CurrentRun.EncountersOccurredBiomeCache = {}
	CurrentRun.BiomeHarvestPointsSeen = {}
	local prevRoom = CurrentRun.RoomHistory[#CurrentRun.RoomHistory - 1]
	if prevRoom ~= nil then
		local prevBiomeName = prevRoom.RoomSetName
		if prevBiomeName ~= nil then
			CurrentRun.BiomeTotalTimes[prevBiomeName] = CurrentRun.TotalTime
			CurrentRun.BiomeGameplayTimes[prevBiomeName] = CurrentRun.GameplayTime
		end
	end
	CurrentRun.BiomeBoonSkipCount = 0
	CurrentRun.BiomeEncounterDepth = 1
	CurrentRun.BiomeRewardsSpawned = 0
end

function GetPreviousRoom( currentRun )
	if CurrentHubRoom ~= nil then
		return PreviousDeathAreaRoom
	end

	local prevRoomIndex = TableLength( currentRun.RoomHistory )
	return currentRun.RoomHistory[prevRoomIndex]
end

function GetCompletedRuns()
	GameState.CompletedRunsCache = TableLength( GameState.RunHistory )
	return GameState.CompletedRunsCache
end

function RecordRunStats()
	CurrentRun.RunResult = GetRunResult( CurrentRun )
	CurrentRun.EndingRoomName = CurrentRun.CurrentRoom.Name
	CurrentRun.WeaponsCache = DeepCopyTable( CurrentRun.Hero.Weapons )
	CurrentRun.TraitRarityCache = CurrentRun.TraitRarityCache or {}
	for k, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if not traitData.RecordCacheOnEquip then
			CurrentRun.TraitCache[traitData.Name] = (CurrentRun.TraitCache[traitData.Name] or 0) + 1
		end
		CurrentRun.TraitRarityCache[traitData.Name] = traitData.Rarity or "Common"
	end
	CurrentRun.ShrinePointsCache = GetTotalSpentShrinePoints()
	CurrentRun.ShrineUpgradesCache = DeepCopyTable( GameState.ShrineUpgrades ) 
	CurrentRun.MetaUpgradeCostCache = GameState.MetaUpgradeCostCache
	if GameState.HighestRunDepthCache < CurrentRun.RunDepthCache then
		GameState.HighestRunDepthCache = CurrentRun.RunDepthCache
	end

	-- send progression events before updating 'cleared' counts
	local roomNames = {}
	for k, room in ipairs( CurrentRun.RoomHistory ) do
		table.insert( roomNames, room.Name )
	end
	table.insert( roomNames, CurrentRun.CurrentRoom.Name )
	SendProgressionEvents({ Names = roomNames, CompletedRuns = GameState.CompletedRunsCache, ClearedUnderworldRuns = GameState.ClearedUnderworldRunsCache, ClearedSurfaceRuns = GameState.ClearedSurfaceRunsCache, Cleared = CurrentRun.Cleared, GameplayTime = GameState.GameplayTime, TotalTime = GameState.TotalTime })

	-- 'cleared' means achieved a victory condition as opposed to dying	
	local runsCleared = 0
	local underworldRunsCleared = 0
	local surfaceRunsCleared = 0
	if CurrentRun.Cleared then
		runsCleared = runsCleared + 1
		if WasUnderworldRun( CurrentRun ) then
			underworldRunsCleared = underworldRunsCleared + 1
			if GameState.HighestShrinePointClearUnderworldCache < CurrentRun.ShrinePointsCache then
				GameState.HighestShrinePointClearUnderworldCache = CurrentRun.ShrinePointsCache
			end
			if GameState.FastestUnderworldClearTimeCache > CurrentRun.GameplayTime then
				GameState.FastestUnderworldClearTimeCache = CurrentRun.GameplayTime
			end
		else
			surfaceRunsCleared = surfaceRunsCleared + 1
			if GameState.HighestShrinePointClearSurfaceCache < CurrentRun.ShrinePointsCache then
				GameState.HighestShrinePointClearSurfaceCache = CurrentRun.ShrinePointsCache
			end
			if GameState.FastestSurfaceClearTimeCache > CurrentRun.GameplayTime then
				GameState.FastestSurfaceClearTimeCache = CurrentRun.GameplayTime
			end
		end
	end
	for k, run in ipairs( GameState.RunHistory ) do
		if run.RunResult == RunResultData.UnderworldSuccess then
			runsCleared = runsCleared + 1
			underworldRunsCleared = underworldRunsCleared + 1
		elseif run.RunResult == RunResultData.SurfaceSuccess then
			runsCleared = runsCleared + 1
			surfaceRunsCleared = surfaceRunsCleared + 1
		end
	end
	GameState.ClearedRunsCache = runsCleared
	GameState.ClearedUnderworldRunsCache = underworldRunsCleared
	GameState.ClearedSurfaceRunsCache = surfaceRunsCleared

	UpdateLifetimeTraitRecords( CurrentRun )

	for bossName, healthFraction in pairs( CurrentRun.BossHealthBarRecord ) do
		GameState.LastBossHealthBarRecord[bossName] = healthFraction
	end

	for bossName, bossData in pairs( BossDifficultyShrineEncounterMap ) do
		if CurrentRun.EncountersOccurredCache[bossData.Encounter] then
			GameState.LastBossDifficultyRecord[bossName] = false
		elseif CurrentRun.EncountersOccurredCache[bossData.AltEncounter] then
			GameState.LastBossDifficultyRecord[bossName] = true
		end
	end
end

function RecordRunCleared()
	-- set current run to Cleared / victory achieved; used with GetNumRunsCleared()
	CurrentRun.Cleared = true
	if CurrentRun.ActiveBounty ~= nil then
		CurrentRun.BountyCleared = true
	end
	RecordRunStats()

	GameState.ClearedWithMetaUpgrades[CurrentRun.CurrentRoom.RoomSetName] = GameState.ClearedWithMetaUpgrades[CurrentRun.CurrentRoom.RoomSetName] or {}
	for metaUpgradeName, metaUpgradeData in pairs( GameState.MetaUpgradeState ) do
		if metaUpgradeData.Equipped then
			GameState.ClearedWithMetaUpgrades[CurrentRun.CurrentRoom.RoomSetName][metaUpgradeName] = true
		end
	end

	GameState.ClearedWithWeapons[CurrentRun.CurrentRoom.RoomSetName] = GameState.ClearedWithWeapons[CurrentRun.CurrentRoom.RoomSetName] or {}
	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		GameState.ClearedWithWeapons[weaponName] = true
		GameState.ClearedWithWeapons[CurrentRun.CurrentRoom.RoomSetName][weaponName] = true
	end

	for traitName in pairs( CurrentRun.TraitCache ) do
		local traitData = TraitData[traitName]
		if traitData ~= nil and traitData.Slot == "Aspect" then
			local actualTraitName = GetKey( ScreenData.GameStats.WeaponBaseAspectMapping, traitName ) or traitName
			GameState.ClearedWithAspects[actualTraitName] = true
		end
	end

	if GameState.EquippedFamiliar ~= nil then
		GameState.ClearedWithFamiliars[GameState.EquippedFamiliar] = true
	end

	if CurrentRun.ActiveBounty == nil and #CurrentRun.KeepsakeCache == 1 then
		GameState.ClearedFullRunWithKeepsakes[CurrentRun.KeepsakeCache[1]] = true
	end
end

function UpdateLifetimeTraitRecords( run )

	local clearCountRecordName = nil
	local fastestTimeRecordName = nil
	local shrinePointsRecordName = nil
	local isUnderworldRun = false

	if run.BiomesReached == nil or run.BiomesReached.F then
		clearCountRecordName = "ClearCountUnderworld"
		fastestTimeRecordName = "FastestTimeUnderworld"
		shrinePointsRecordName = "HighestShrinePointsUnderworld"
		isUnderworldRun = true
	else
		clearCountRecordName = "ClearCountSurface"
		fastestTimeRecordName = "FastestTimeSurface"
		shrinePointsRecordName = "HighestShrinePointsSurface"
	end

	if run.TraitCache ~= nil then
		for traitName in pairs( run.TraitCache ) do
			GameState.LifetimeTraitStats[traitName] = GameState.LifetimeTraitStats[traitName] or {}
			local stats = GameState.LifetimeTraitStats[traitName]
			stats.UseCount = (stats.UseCount or 0) + 1
			if run.Cleared and ( isUnderworldRun or run.BiomesReached.Q ) then
				stats[clearCountRecordName] = (stats[clearCountRecordName] or 0) + 1
				stats.ClearCount = (stats.ClearCount or 0) + 1
				if run.GameplayTime < (stats[fastestTimeRecordName] or 999999) then
					stats[fastestTimeRecordName] = run.GameplayTime
				end
				if run.ShrinePointsCache > (stats[shrinePointsRecordName] or 0) then
					stats[shrinePointsRecordName] = run.ShrinePointsCache
				end
			end
		end
	end
end

function HasSeenRoomInNumRuns( roomName, runCount )

	if CurrentRun.RoomsEntered[roomName] then
		return true
	end

	for runIndex = #GameState.RunHistory, #GameState.RunHistory - (runCount - 1), -1 do
		if runIndex <= 0 then
			return false
		end
		local prevRun = GameState.RunHistory[runIndex]
		if prevRun.RoomsEntered ~= nil and prevRun.RoomsEntered[roomName] then
			return true
		end
	end

	return false

end

function GetEligibleMeleeWeapons()
	local eligibleMeleeWeaponData = {}
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		local weaponData = WeaponData[weaponName]
		if IsWeaponEligible( CurrentRun, weaponData ) then
			table.insert( eligibleMeleeWeaponData, weaponData )
		end
	end
	return eligibleMeleeWeaponData
end

function IsWeaponEligible( currentRun, weaponData )

	if not weaponData.StartingWeapon then
		return false
	end

	if weaponData.GameStateRequirements ~= nil and not IsGameStateEligible( weaponData, weaponData.GameStateRequirements ) then
		return false
	end

	local itemData = WeaponShopItemData[weaponData.Name]
	if itemData == nil then
		return false
	end

	if itemData.GameStateRequirements ~= nil and not IsGameStateEligible( itemData, itemData.GameStateRequirements ) then
		return false
	end

	return true

end

OnSpawn{
	function( triggerArgs )
		local obstacleData = ObstacleData[triggerArgs.name]
		local enemyData = EnemyData[triggerArgs.name]
		if verboseLogging and obstacleData ~= nil and enemyData ~= nil then
			DebugAssert({ Condition = false, Text = triggerArgs.name.." has both ObstacleData and EnemeyData", Owner = "Eduardo" })
		end
		if obstacleData ~= nil then
			if not SessionMapState.DeferredObstacleInitializationFinished then
				DeferredObstacleInitialization = DeferredObstacleInitialization or {}
				if SessionMapState.DeferredObstacleInitializationStarted then
					DebugAssert({ Condition = false, Text = obstacleData.Name.." spawned after DeferredObstacleInitializationStarted", Owner = "Gavin" })
				end
				DeferredObstacleInitialization[triggerArgs.triggeredById] = triggerArgs.name
				return
			end
			if MapState.ActiveObstacles[triggerArgs.triggeredById] == nil or MapState.ActiveObstacles[triggerArgs.triggeredById].AllowResetup then
				local obstacle = DeepCopyTable( obstacleData )
				obstacle.ObjectId = triggerArgs.triggeredById
				SetupObstacle( obstacle, true )
			end
		elseif enemyData ~= nil then
			if triggerArgs.NeedsLuaInitialization then
				local enemy = DeepCopyTable( enemyData )
				enemy.ObjectId = triggerArgs.triggeredById
				enemy.SpawnedById = triggerArgs.SpawnedById
				SetupUnit( enemy, CurrentRun )
				if triggerArgs.SpawnedById ~= nil then
					local spawner = ActiveEnemies[triggerArgs.SpawnedById]
					if spawner ~= nil then
						spawner.Spawns = spawner.Spawns or {}
						spawner.Spawns[enemy.ObjectId] = enemy
					elseif enemy.ActivateFuseIfNoSpawner then
						ActivateFuse( enemy )
					end
				end
			elseif SessionMapState.DeferredUnitInitialization ~= nil then
				SessionMapState.DeferredUnitInitialization[triggerArgs.triggeredById] = triggerArgs.name
			end
		end
	end
}

function CloseDoorForRun( run, obstacle )
	run.ClosedDoors[run.CurrentRoom.Name] = run.ClosedDoors[run.CurrentRoom.Name] or {}
	run.ClosedDoors[run.CurrentRoom.Name][obstacle.ObjectId] = true
end

function IsDoorClosedForRun( run, obstacle )

	if run.ClosedDoors == nil then
		return false
	end

	local roomDoors = run.ClosedDoors[run.CurrentRoom.Name]
	if roomDoors == nil then
		return false
	end

	if not roomDoors[obstacle.ObjectId] then
		return false
	end

	return true

end

function RandomizeObject( object, args )

	if CurrentRun.CurrentRoom.ObjectStates ~= nil and CurrentRun.CurrentRoom.ObjectStates[object.ObjectId] ~= nil and CurrentRun.CurrentRoom.ObjectStates[object.ObjectId].Randomized then
		return
	end

	local randomizeData = args

	if randomizeData.RandomizeSets ~= nil then
		randomizeData = GetRandomValue(randomizeData.RandomizeSets)
	end

	if randomizeData.Graphic ~= nil then
		local graphicName = GetRandomValue(randomizeData.Graphic)
		SetThingProperty({ DestinationId = object.ObjectId, Value = graphicName, Property = "Graphic" })
		RecordObjectState( CurrentRun.CurrentRoom, object.ObjectId, "Animation", graphicName )
	end

	if randomizeData.Animation ~= nil then
		local animationName = GetRandomValue(randomizeData.Animation)
		SetAnimation({ DestinationId = object.ObjectId, Name = animationName })
		RecordObjectState( CurrentRun.CurrentRoom, object.ObjectId, "Animation", animationName )
	end

	if randomizeData.Flip and CoinFlip() then
		FlipHorizontal({ Id = object.ObjectId })
		RecordObjectState( CurrentRun.CurrentRoom, object.ObjectId, "FlipHorizontal", true )
	end

	if randomizeData.OverwriteData ~= nil then
		OverwriteTableKeys(object, randomizeData.OverwriteData)
		for k, v in pairs(randomizeData.OverwriteData) do
			RecordObjectState( CurrentRun.CurrentRoom, object.ObjectId, k, v )
		end
	end

	if randomizeData.PropertyChanges ~= nil then
		ApplyUnitPropertyChanges(object, randomizeData.PropertyChanges, true)
		RecordObjectState( CurrentRun.CurrentRoom, object.ObjectId, "PropertyChanges", randomizeData.PropertyChanges )
	end

	if randomizeData.ScaleMin ~= nil and randomizeData.ScaleMax ~= nil then
		SetScale({ Id = object.ObjectId, Fraction = RandomFloat(randomizeData.ScaleMin, randomizeData.ScaleMax) })
	end

	RecordObjectState( CurrentRun.CurrentRoom, object.ObjectId, "Randomized", true )
end

function SetupObstacle( obstacle, replaceOnlyNull, args )

	args = args or {}
	if obstacle.SetupGameStateRequirements ~= nil and not IsGameStateEligible( obstacle, obstacle.SetupGameStateRequirements ) then
		if obstacle.DestroyIfNotSetup then
			Destroy({ Id = obstacle.ObjectId })
		end
		return
	end

	if obstacle.Activate then
		Activate({ Id = obstacle.ObjectId, TriggerOnSpawn = false })
	end
	if obstacle.ActivateIds ~= nil then
		Activate({ Ids = obstacle.ActivateIds })
	end
	if not args.SkipAttachLua then
		AttachLua({ Id = obstacle.ObjectId, Table = obstacle, OnlyNullKeys = replaceOnlyNull })
	end
	MapState.ActiveObstacles[obstacle.ObjectId] = obstacle
	if obstacle.Buckets ~= nil then
		for k, bucketName in ipairs( obstacle.Buckets ) do
			MapState[bucketName] = MapState[bucketName] or {}
			MapState[bucketName][obstacle.ObjectId] = obstacle
		end
	end

	if obstacle.ExtractValues ~= nil then
		ExtractValues( CurrentRun.Hero, obstacle, obstacle )
	end

	obstacle.Health = obstacle.MaxHealth

	if obstacle.BlockExitUntilUsed then
		MapState.RoomRequiredObjects[obstacle.ObjectId] = obstacle
	end

	if obstacle.OccupyingSpawnPointId ~= nil then
		SessionMapState.SpawnPointsUsed[obstacle.OccupyingSpawnPointId] = obstacle.ObjectId
	end

	if obstacle.GrannyTexture ~= nil then
		SetThingProperty({ Property = "GrannyTexture", Value = obstacle.GrannyTexture, DestinationId = obstacle.ObjectId })
	end

	if obstacle.Animation ~= nil then
		SetAnimation({ DestinationId = obstacle.ObjectId, Name = obstacle.Animation })
	end

	if obstacle.SpawnPropertyChanges ~= nil then
		ApplyUnitPropertyChanges( obstacle, obstacle.SpawnPropertyChanges, true )
	end

	if obstacle.InteractDistance ~= nil then
		SetInteractProperty({ DestinationId = obstacle.ObjectId, Property = "Distance", Value = obstacle.InteractDistance })
	end
	if obstacle.InteractOffsetX ~= nil then
		SetInteractProperty({ DestinationId = obstacle.ObjectId, Property = "OffsetX", Value = obstacle.InteractOffsetX })
	end
	if obstacle.InteractOffsetY ~= nil then
		SetInteractProperty({ DestinationId = obstacle.ObjectId, Property = "OffsetY", Value = obstacle.InteractOffsetY })
	end
	if obstacle.AutoActivate ~= nil then
		SetInteractProperty({ DestinationId = obstacle.ObjectId, Property = "AutoActivate", Value = obstacle.AutoActivate })
	end

	if obstacle.DistanceTrigger ~= nil then
		thread( CheckDistanceTrigger, obstacle.DistanceTrigger, obstacle )
	end
	if obstacle.DistanceTriggers ~= nil then
		for k, trigger in ipairs( obstacle.DistanceTriggers ) do
			thread( CheckDistanceTrigger, trigger, obstacle, k )
		end
	end

	if obstacle.SpeakerName ~= nil then
		LoadVoiceBanks( obstacle.SpeakerName )
	end

	if obstacle.LoadPackages ~= nil then
		LoadPackages({ Names = obstacle.LoadPackages })
	end

	if obstacle.SetupEvents ~= nil then
		RunEventsGeneric( obstacle.SetupEvents, obstacle, args )
	end

	if obstacle.ValueOptions ~= nil and not obstacle.ValueOptionsProcessed then
		ProcessObjectValueOptions( obstacle )
	end

end

function ProcessObjectValueOptions( object )
	for k, swapOption in ipairs( object.ValueOptions ) do
		if swapOption.GameStateRequirements == nil or IsGameStateEligible( swapOption, swapOption.GameStateRequirements ) then
			if RandomChance( swapOption.Chance ) then
				if swapOption.Animation ~= nil then
					SetAnimation({ DestinationId = object.ObjectId, Name = swapOption.Animation, OffsetY = swapOption.OffsetY or 0 })
					RecordObjectState( CurrentRun.CurrentRoom, object.ObjectId, "Animation", swapOption.Animation )
				end
				object.MoneyDropOnDeath = swapOption.MoneyDropOnDeath
				RecordObjectState( CurrentRun.CurrentRoom, object.ObjectId, "MoneyDropOnDeath", object.MoneyDropOnDeath )
				OverwriteTableKeys(object, swapOption.DataOverrides)
				break
			end
		end
	end

	if object.SpawnUnitFromEnemySet ~= nil or object.SpawnUnitFromBiomeEnemySet ~= nil then
		local enemySet = EnemySets[object.SpawnUnitFromEnemySet] or EnemySets[object.SpawnUnitFromBiomeEnemySet]
		
		if object.SpawnUnitFromBiomeEnemySet ~= nil then
			enemySet = EnemySets[object.SpawnUnitFromBiomeEnemySet.."_"..CurrentRun.CurrentRoom.RoomSetName] or enemySet
		end

		local eligibleOptions = {}
		for k, unitName in pairs(enemySet) do
			if IsEnemyEligible(unitName) then
				table.insert(eligibleOptions, unitName)
			end
		end
		object.SpawnUnitOnDeath = GetRandomValue(eligibleOptions)
	end

	object.ValueOptionsProcessed = true
end

function HasEventFunctionName( events, functionName )
	if events ~= nil then
		for k, eventEntry in ipairs( events ) do
			if eventEntry.FunctionName == functionName then
				return true
			end
		end
	end
	return false
end

function CheckSetupFunction( object, functionName )
	if object.SetupEvents ~= nil then
		for k, setupEventEntry in ipairs( object.SetupEvents ) do
			if setupEventEntry.FunctionName == functionName then
				if setupEventEntry.GameStateRequirements == nil or IsGameStateEligible( object, setupEventEntry.GameStateRequirements ) then
					CallFunctionName( setupEventEntry.FunctionName, object, setupEventEntry.Args )
				end
			end
		end
	end
end

function UpdateConfigOptionCache()
	ConfigOptionCache = ConfigOptionCache or {}
	local optionsToCache =
	{
		"DamageTakenMultiplier",
		"DamageMultiplier",
		"DemoMode",
		"ShowDamageNumbers",
		"ShowUIAnimations",
		"LogCombatMultipliers",
		"ShowSpeechBubble",
		"EasyMode",
		"ShowGameplayTimer",
		"MusicVolume",
		"SprintAutoHold",
		"EasyModeResistanceCap",

	}
	for k, optionName in pairs( optionsToCache ) do
		ConfigOptionCache[optionName] = GetConfigOptionValue({ Name = optionName })
	end

	local nativeWidth = 1920
	local nativeHeight = 1080
	
	ScreenState.NativeAspetRatio = true
	ScreenState.NeedsLetterbox = false
	ScreenState.NeedsPillarbox = false
	ScreenCenterNativeOffsetX = 0.0
	ScreenCenterNativeOffsetY = 0.0
	ScreenScaleX = 1.0
	ScreenScaleY = 1.0
	ScreenState.PillarboxScaleX = 0.0
	ScreenState.PillarboxLeftX = 0.0
	ScreenState.PillarboxRightX = 0.0

	local actualWidth = GetConfigOptionValue({ Name = "X" })
	local actualHeight = GetConfigOptionValue({ Name = "Y" })
	local aspectRatio = actualWidth / actualHeight

	local scaleX = actualWidth / nativeWidth
	local scaleY = actualHeight / nativeHeight

	if scaleX ~= scaleY then
		if scaleY > scaleX then
			ScreenWidth = nativeWidth
			ScreenHeight = ScreenWidth / aspectRatio
			ScreenScaleY = ScreenHeight / nativeHeight
			ScreenState.NeedsLetterbox = true
		else
			ScreenHeight = nativeHeight
			ScreenWidth = ScreenHeight * aspectRatio
			ScreenScaleX = ScreenWidth / nativeWidth
			ScreenState.NeedsPillarbox = true
		end
		ScreenState.NativeAspetRatio = false
	end

	ScreenCenterNativeOffsetX = (ScreenWidth - nativeWidth) / 2
	local pillarBoxCanvasWidth = 380
	ScreenState.PillarboxLeftX = ScreenCenterNativeOffsetX / 2
	ScreenState.PillarboxRightX = ScreenWidth - (ScreenCenterNativeOffsetX / 2)
	local neededPillarWidth = ScreenCenterNativeOffsetX
	ScreenState.PillarboxScaleX = neededPillarWidth / pillarBoxCanvasWidth

	ScreenCenterNativeOffsetY = (ScreenHeight - nativeHeight) / 2

	ScreenCenterX = ScreenWidth / 2
	ScreenCenterY = ScreenHeight / 2

	if ConfigOptionCache.SprintAutoHold then
		SessionState.ObjectiveSwaps.WeaponBlink = "Objective_WeaponBlink_Auto"
	else
		SessionState.ObjectiveSwaps.WeaponBlink = nil
	end
		
	ConfigOptionCache.SecondaryEffectsFrameCap = GetConfigOptionValue({ Name = "SecondaryEffectsFrameCap" })
	ConfigOptionCache.GraphicsQualityPreset = GetConfigOptionValue({ Name = "GraphicsQualityPreset" })
	local prevHUDOpacity = ConfigOptionCache.HUDOpacity
	ConfigOptionCache.HUDOpacity = GetConfigOptionValue({ Name = "HUDOpacity" })
	if prevHUDOpacity ~= nil and prevHUDOpacity ~= ConfigOptionCache.HUDOpacity then
		HideCombatUI( "Settings" )
		ShowCombatUI( "Settings" )
	end
end

function AddTimerBlock( run, flag, args )
	args = args or {}
	if args.MapState then
		MapState.BlockTimerFlags[flag] = true
	else
		run.BlockTimerFlags[flag] = true
	end
	UpdateTimerDependentTraits()
end

function HasTimerBlock( run, excludes )
	local runFlags = run.BlockTimerFlags
	if excludes ~= nil then
		runFlags = ShallowCopyTable( run.BlockTimerFlags )
		for i, key in pairs( excludes ) do
			runFlags[key] = nil
		end
	end
	return not IsEmpty( runFlags ) or not IsEmpty( MapState.BlockTimerFlags )
end

function RemoveTimerBlock( run, flag )
	MapState.BlockTimerFlags[flag] = nil
	run.BlockTimerFlags[flag] = nil
	UpdateTimerDependentTraits()
end

function UpdateTimers( elapsed )

	if CurrentRun == nil then
		return
	end

	GameState.TotalTime = GameState.TotalTime + elapsed
	CurrentRun.TotalTime = CurrentRun.TotalTime + elapsed

	if CurrentRun.Hero.IsDead then
		return
	end

	if not IsEmpty( CurrentRun.BlockTimerFlags ) or not IsEmpty( MapState.BlockTimerFlags ) then
		return
	end

	GameState.GameplayTime = GameState.GameplayTime + elapsed
	CurrentRun.GameplayTime = CurrentRun.GameplayTime + elapsed

	if HeroHasTrait("TimedBuffKeepsake") then
		if  not IsBiomeTimerPaused() then
			local traitData = GetHeroTrait("TimedBuffKeepsake")
			traitData.CurrentTime = traitData.CurrentTime - elapsed
			if traitData.CurrentTime  <= 0 and (traitData.CurrentTime  + elapsed) > 0 then
				traitData.CustomName = traitData.ZeroBonusTrayText
				EndTimedBuff( traitData )
				thread( TimedBuffExpiredPresentation, traitData )
				ReduceTraitUses( traitData, {Force = true } )
			end
		end
	end
	
	if HeroHasTrait("ChaosTimeCurse") then
		if  not IsBiomeTimerPaused() then
			local traitData = GetHeroTrait("ChaosTimeCurse")
			traitData.CurrentTime = traitData.CurrentTime - elapsed
			local threshold = 30
			local criticalThreshold = 10
			if traitData.CurrentTime <= threshold and (traitData.CurrentTime  + elapsed) > threshold then
				ChaosTimerAboutToExpirePresentation(threshold )
			elseif traitData.CurrentTime  <= 0 and (traitData.CurrentTime  + elapsed) > 0 then
				if not CurrentRun.Hero.InvulnerableFlags.BlockDeath then
					CurrentRun.CurrentRoom.Encounter.TookChaosCurseDamage = true
					CurrentRun.CurrentRoom.KilledByChaosCurse = true
					thread( ChaosTimerExpirePresentation )
					thread( SacrificeHealth, { SacrificeHealthMin = traitData.Damage, SacrificeHealthMax = traitData.Damage, MinHealth = 0, AttackerName = "TrialUpgrade" } )
				end
				if not CurrentRun.Hero.IsDead then
					thread( RemoveTraitData, CurrentRun.Hero, traitData )
				end
			elseif traitData.CurrentTime <= criticalThreshold and (traitData.CurrentTime  + elapsed) > 0 then
				if (traitData.CurrentTime  + elapsed) > criticalThreshold then
					ChaosTimerReallyAboutToExpirePresentation(criticalThreshold )
				elseif math.floor(traitData.CurrentTime) ~= math.floor( traitData.CurrentTime + elapsed ) then
					ChaosTimerReallyAboutToExpirePing()
				end
			end
		end
	end
	
	if CurrentRun.ActiveBiomeTimer and not IsBiomeTimerPaused() then
		CurrentRun.BiomeTime = CurrentRun.BiomeTime - elapsed
		local threshold = 30
		if CurrentRun.BiomeTime <= threshold and (CurrentRun.BiomeTime + elapsed) > threshold then
			BiomeTimerAboutToExpirePresentation(threshold )
		elseif CurrentRun.BiomeTime <= 0 and (CurrentRun.BiomeTime + elapsed) > 0 then
			BiomeTimerExpiredPresentation()
		end
	end
end

function InvalidateCheckpoint()
	if CurrentRun.CurrentRoom ~= nil and not CurrentRun.CurrentRoom.CheckpointInvalidated then
		CurrentRun.CurrentRoom.CheckpointInvalidated = true
		ValidateCheckpoint({ Value = false })
	end
end

function SelectBannedEliteAttributes( run )
	local banCount = 2
	local banOptions = ShallowCopyTable( EnemySets.EliteAttributesRunBanOptions )

	for i = 1, banCount do
		local banChoice = RemoveRandomValue( banOptions )
		if banChoice ~= nil then
			run.BannedEliteAttributes[banChoice] = true
		end
	end
end

function RequestSave( args )
	if GameState.IllegalConversationModification then
		DebugPrint({ Text = "Illegal conversation modification made.  Skipping save.", Priority = true })
		return
	end
	SaveCheckpoint( args )
end

function GetRunResult( run )
	if run.ActiveBounty ~= nil then
		if run.BountyCleared then
			return RunResultData.BountySuccess
		else
			return RunResultData.BountyFail
		end
	end

	if run.BiomesReached ~= nil and run.BiomesReached.N then
		if run.Cleared then
			return RunResultData.SurfaceSuccess
		else
			return RunResultData.SurfaceFail
		end
	end

	if run.Cleared then
		return RunResultData.UnderworldSuccess
	else
		return RunResultData.UnderworldFail
	end
end

function WasUnderworldRun( run )
	return run.RunResult == RunResultData.UnderworldSuccess or run.RunResult == RunResultData.UnderworldFail
end

function WasSurfaceRun( run )
	return run.RunResult == RunResultData.SurfaceSuccess or run.RunResult == RunResultData.SurfaceFail
end

function WasBountyRun( run )
	return run.RunResult == RunResultData.BountySuccess or run.RunResult == RunResultData.BountyFail
end

function WasRunSuccess( run )
	return run.RunResult == RunResultData.UnderworldSuccess or run.RunResult == RunResultData.SurfaceSuccess or run.RunResult == RunResultData.BountySuccess
end