OverwriteTableKeys( EncounterData,
{
	-- MiniBoss Encounters
	-- NOTE(andrew): Moved MiniBossEncounter base and inheriting from "GeneratedF"
	-- to EncounterData.lua for Tech Test

	MiniBossAssassin =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedF", },

		PreSpawnEnemies = false,
		SpawnAggroed = true,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMin = 10,
		ActiveEnemyCapMax = 10,

		SpawnIntervalMin = 0.3,
		SpawnIntervalMax = 0.7,

		EndMusicOnCombatOver = 20,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "ZombieAssassin_Miniboss",
						TotalCount = 1,
						SpawnOnIds = { 40191 },
						ForceFirst = true,
						SpawnOverrides =
						{
							AggroReactionTimeMin = 0.15,
							AggroReactionTimeMax = 0.45,
							SpawnAngleTowardId = 50059,
						},
					},
					{
						Name = "ZombieAssassin_Shadow",
						TotalCount = 2,
						RequiredMiniBossShrine = true,
						SpawnOverrides =
						{
							RequiredSpawnPointType = "EnemyPointMelee",
						},
					},

				},
				SkipWaitForAllDead = true
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "ZombieAssassin_Miniboss" },
		WipeEnemiesOnKill = "ZombieAssassin_Miniboss",
	},

	MiniBossWaterUnit =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedG" },

		PreSpawnEnemies = true,
		SpawnAggroed = true,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 2,
		ActiveEnemyCapMax = 3,

		SpawnIntervalMin = 1.0,
		SpawnIntervalMax = 1.0,

		NextRoomResumeMusic = true,

		MoneyDropCapMin = 25,
		MoneyDropCapMax = 25,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = false,

		UnthreadedEvents = EncounterSets.EncounterEventsMiniBossWaterUnit,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "WaterUnitMiniboss",
						TotalCount = 1,
						SpawnOnIds = { 568842 },
						ForceFirst = true,
					},
					{
						Name = "WaterUnitMiniboss_Shadow",
						TotalCount = 1,
						SpawnOnIds = { 568925 },
						ForceFirst = true,
						RequiredMiniBossShrine = true,
					},
					{
						Name = "Radiator2_Elite",
						InfiniteSpawns = false,
						TotalCount = 4,
						SpawnOnIds = { 612512, 568937, 568939, 568941, },
						SpawnOverrides = 
						{
							SpawnAngleTowardId = 568842,
						},
					},
				},
				--StartDelay = 1.2,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "WaterUnitMiniboss" },
		WipeEnemiesOnKill = "WaterUnitMiniboss",

		PreSpawnSpawnOverrides =
		{
			WakeUpDelay = 1.5,
		},
	},

	MiniBossJellyfish =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedG" },
		PreSpawnEnemies = true,
		SpawnAggroed = true,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMax = 8,

		SpawnIntervalMin = 1.0,
		SpawnIntervalMax = 1.0,

		NextRoomResumeMusic = true,

		MoneyDropCapMin = 25,
		MoneyDropCapMax = 25,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = false,

		UnthreadedEvents = EncounterSets.EncounterEventsMiniBossJellyfish,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Octofish_Miniboss",
						TotalCount = 1,
						ForceFirst = true,
						SpawnOnId = 737255,
					},
					{
						Name = "Octofish_Shadow",
						TotalCount = 1,
						SpawnOnId = 609813,
						RequiredMiniBossShrine = true,
					},
					{
						Name = "Jellyfish",
						TotalCount = 24,
						SpawnPointGroupName = "JellyfishSpawnPoints",
					},
				},
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "Octofish_Miniboss" },
		WipeEnemiesOnKill = "Octofish_Miniboss",
		ForceCombatResolvedAudio = true,

		PreSpawnSpawnOverrides =
		{
			WakeUpDelay = 1.5,
		},
	},

	MiniBossCrawler =
	{
		InheritFrom = { "MinibossEncounter" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,
		DelayedStart = true,

		BlockDionysusEncounterKeepsake = true,
		BlockAthenaEncounterKeepsake = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossWaterUnit" },
			},
		},
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "CrawlerMiniboss" }, IgnoreAI = true, SkipPresentation = true, } },
		},
		
		UnthreadedEvents = EncounterSets.EncounterEventsMiniBossCrawler,

		NextRoomResumeMusic = true,
		WipeEnemiesOnKill = "CrawlerMiniboss",
	},

	MiniBossVampire =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedH", },
		PreSpawnEnemies = true,
		SpawnAggroed = false,

		UnthreadedEvents = EncounterSets.EncounterEventsHMiniboss,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 4,
		MaxTypes = 4,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 4,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,

		SpawnIntervalMin = 0.02,
		SpawnIntervalMax = 0.02,

		EndMusicOnCombatOver = 20,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = false,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Vampire",
						TotalCount = 1,
						SpawnOnIds = { 621276 },
						ForceFirst = true,
					},
					{
						Name = "Mourner_Shadow",
						TotalCount = 1,
						SpawnOnIds = { 622331 },
						RequiredMiniBossShrine = true,
					},
					{
						Name = "CorruptedShadeSmall",
						TotalCount = 13,
						SpawnOnIds = { 622330, 622786, 622785, 622327, 622326, 622796, 622325, 622333, 622799, 622800, 622801, 622802, 622803 },
					},
				
					SpawnOverrides = 
					{
						--SpawnAngleTowardId = 621200,
						SpawnAngleTowardId = 565478,
					},
				},
				SkipWaitForAllDead = true
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "Vampire" },
		WipeEnemiesOnKill = "Vampire",
	},

	MiniBossLamia =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedH", },
		PreSpawnEnemies = true,
		SpawnAggroed = true,

		UnthreadedEvents = EncounterSets.EncounterEventsHMiniboss,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 99,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,

		SpawnIntervalMin = 0.25,
		SpawnIntervalMax = 0.5,

		EndMusicOnCombatOver = 20,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = false,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Lamia_Miniboss",
						TotalCount = 1,
						SpawnOnIds = { 621276 },
						ForceFirst = true,
					},
					{
						Name = "Lovesick_Shadow",
						TotalCount = 1,
						SpawnOnIds = { 622513, },
						RequiredMiniBossShrine = true,
					},
					{
						Name = "Lamia_Support",
						TotalCount = 4,
						SpawnOnIds = { 622525, 622542, 622543, 622544, },
					},
					SpawnOverrides =
					{
						SpawnAngleTowardId = 565479,
					},
				},
				SkipWaitForAllDead = true
			},
		},

		PreSpawnSpawnOverrides = {},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "Lamia_Miniboss" },
		WipeEnemiesOnKill = "Lamia_Miniboss",
	},

	MiniBossSatyrCrossbow =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedN", },
		PreSpawnEnemies = true,
		SpawnAggroed = true,

		MinWaves = 2,
		MaxWaves = 2,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 4,

		SpawnIntervalMin = 2.25,
		SpawnIntervalMax = 5.4,

		EndMusicOnCombatOver = 20,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "SatyrCrossbow",
						TotalCount = 1,
						SpawnOnIds = { 40191 },
						ForceFirst = true,
					},
					{
						Name = "SatyrCrossbow_Shadow",
						TotalCount = 1,
						SpawnOnIds = { 646548 },
						RequiredMiniBossShrine = true,
					},
				},
				StartDelay = 0.5,
				SkipWaitForAllDead = true,
			},
			[2] =
			{
				Spawns =
				{
					{
						Name = "Carrion",
						TotalCount = 5,
						RequiredMiniBossShrine = false,
					},
				},
			}
		},

		CancelSpawnsOnKill = { "SatyrCrossbow" },
		WipeEnemiesOnKill = "SatyrCrossbow",

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	MiniBossBoar =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedN", },
		PreSpawnEnemies = true,
		SpawnAggroed = true,

		MinWaves = 2,
		MaxWaves = 2,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMax = 6,

		SpawnIntervalMin = 2.25,
		SpawnIntervalMax = 5.4,

		EndMusicOnCombatOver = 20,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Boar",
						TotalCount = 1,
						SpawnOnIds = { 40191 },
						ForceFirst = true,
						SpawnOverrides =
						{
							SkipAISetupOnActivate = true,
						},
					},
					{
						Name = "Boar_Shadow",
						TotalCount = 3,
						SpawnOnIds = { 646641, 646634, 646695, },
						RequiredMiniBossShrine = true,
						SpawnOverrides =
						{
							SkipAISetupOnActivate = true,
						},
					},
				},
				StartDelay = 0.5,
				SkipWaitForAllDead = true
			},
			[2] =
			{
				Spawns =
				{
					{
						Name = "Zombie",
						TotalCount = 12,
					},
				},
				StartDelay = 5.0,
			}
		},

		CancelSpawnsOnKill = { "Boar" },
		WipeEnemiesOnKill = "Boar",
	},

	MiniBossCharybdis =
	{
		InheritFrom = { "MinibossEncounter" },
		PreSpawnEnemies = true,
		SpawnAggroed = true,

		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		NextRoomResumeMusic = true,
		
		BlockAthenaEncounterKeepsake = true,
		BlockDionysusEncounterKeepsake = true,
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Charybdis", "CharybdisTentacle" }, IgnoreAI = true, SkipPresentation = true, } },
			{ FunctionName = "SetupGroupHealthBar", Args = { } }
		},

		UseGroupHealthBar = true,
		GroupHealthBarTypes = { "Charybdis", "CharybdisTentacle" },
		HealthBarTextId = "Charybdis_Full",

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		BossKillGlobalVoiceLines = "MiniBossEncounterEndVoiceLines",
		CancelSpawnsOnKillAllTypes = { "CharybdisTentacle" },
		WipeEnemiesOnKillAllTypes = { "CharybdisTentacle" }
	},

	MiniBossCaptain =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedO" },
		PreSpawnEnemies = true,
		SpawnAggroed = true,
		Generated = false,
		SkipLastKillPresentation = false,
		
		BlockAthenaEncounterKeepsake = true,
		BlockDionysusEncounterKeepsake = true,
		DelayedStart = false,

		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Captain" }, SkipPresentation = true, } },
			{
				FunctionName = "HandleEncounterPreSpawns"
			},
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					UseableOffIds = { 566590 },
				},
			},
		},

		PreSpawnSpawnOverrides =
		{
			WakeUpDelay = 3.0,
			SpawnAngleTowardId = 723378,
		},

		MinWaves = 2,
		MaxWaves = 2,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMax = 6,

		SpawnIntervalMin = 3.0,
		SpawnIntervalMax = 5.0,

		SpawnWaves =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Captain_Shadow",
						TotalCount = 1,
						SpawnOnIds = { 723639 },
						RequiredMiniBossShrine = true,
						ForceFirst = true,
					},
					{
						Name = "ZombieCrewman",
						TotalCount = 14,
					},
				},
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		
		CancelSpawnsOnKill = { "Captain" },
		WipeEnemiesOnKill = "Captain",
	},

	MiniBossRatCatcher =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedI", },
		PreSpawnEnemies = false,
		SpawnAggroed = false,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,

		SpawnIntervalMin = 0.0,
		SpawnIntervalMax = 0.0,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = false,

		UnthreadedEvents = EncounterSets.EncounterEventsMiniBossRatCatcher,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "SatyrRatCatcher_Miniboss",
						TotalCount = 1,
						ForceFirst = true,
						SpawnOnIds = { 40191 },
					},
					{
						Name = "SatyrLancer_Shadow",
						TotalCount = 1,
						SpawnOnIds = { 626019 },
						RequiredMiniBossShrine = true,
					},
				},
				SkipWaitForAllDead = true
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "SatyrRatCatcher_Miniboss" },
		WipeEnemiesOnKill = "SatyrRatCatcher_Miniboss",
	},

	MiniBossGoldElemental =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedI", },
		PreSpawnEnemies = false,
		SpawnAggroed = false,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 2,
		ActiveEnemyCapMax = 2,

		SpawnIntervalMin = 0.0,
		SpawnIntervalMax = 0.0,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = false,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "GoldElemental_MiniBoss",
						TotalCount = 1,
						ForceFirst = true,
						SpawnOnIds = { 40191 },
					},
					{
						Name = "GoldElemental_Shadow",
						TotalCount = 2,
						RequiredMiniBossShrine = true,
					},
				},
				SkipWaitForAllDead = true
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "GoldElemental_MiniBoss" },
		WipeEnemiesOnKill = "GoldElemental_MiniBoss",
	},

	MiniBossTalos =
	{
		InheritFrom = { "MinibossEncounter" },
		PreSpawnEnemies = true,
		SpawnAggroed = true,
		DelayedStart = true,
		
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Talos" }, IgnoreAI = true, SkipPresentation = true, } },
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "AutomatonBeamer_Shadow", "AutomatonEnforcer_Shadow" }, SpawnOverrides = { AIWakeDelay = 1.5 }, IgnoreAI = true, SkipPresentation = true, },
				GameStateRequirements =
				{
					NamedRequirements = { "MinibossCountShrineUpgradeActive" },
				}
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		NextRoomResumeMusic = true,
		WipeEnemiesOnKill = "Talos",
		ForceCombatResolvedAudio = true,
	},

	MiniBossDragon =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedP", },
		PreSpawnEnemies = false,
		SpawnAggroed = true,
		DelayedStart = true,

		BlockDionysusEncounterKeepsake = true,
		BlockAthenaEncounterKeepsake = true,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,

		SpawnIntervalMin = 0.0,
		SpawnIntervalMax = 0.0,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 25,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = false,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Dragon_Shadow",
						TotalCount = 1,
						SpawnOnIds = { 745061 },
						RequiredMiniBossShrine = true,
					},
				},
				SkipWaitForAllDead = true
			},
		},
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Dragon_MiniBoss" }, IgnoreAI = true, SkipPresentation = true, } },
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "Dragon_MiniBoss" },
		WipeEnemiesOnKill = "Dragon_MiniBoss",

		PreSpawnSpawnOverrides =
		{
			WakeUpDelay = 2.1,
		},
	},

	MiniBossHarpy =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedP", },
		PreSpawnEnemies = false,
		SpawnAggroed = false,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,

		SpawnIntervalMin = 5.0,
		SpawnIntervalMax = 10.0,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = false,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "HarpyDropper_MiniBoss",
						TotalCount = 1,
						ForceFirst = true,
					},
				},
				SkipWaitForAllDead = true
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "HarpyDropper_MiniBoss" },
	},

	MiniBossBrute =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedQ" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,
		DelayedStart = true,
		SkipIntroEncounterCheck = true,
		
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,

		SpawnIntervalMin = 0.0,
		SpawnIntervalMax = 0.0,
		
		BlockAthenaEncounterKeepsake = true,
		BlockDionysusEncounterKeepsake = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Brute_Shadow",
						TotalCount = 1,
						SpawnOnIds = { 768962 },
						RequiredMiniBossShrine = true,
					},
				},
				SkipWaitForAllDead = true
			},
		},
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Brute_Miniboss" }, IgnoreAI = true, SkipPresentation = true, } },
		},

		NextRoomResumeMusic = true,
		WipeEnemiesOnKill = "Brute_Miniboss",
		BossKillGlobalVoiceLines = "MiniBossEncounterEndVoiceLines",
	},

	MiniBossStalker =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedQ" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,
		DelayedStart = true,
		SkipIntroEncounterCheck = true,
		Generated = false,
		
		BlockAthenaEncounterKeepsake = true,
		BlockDionysusEncounterKeepsake = true,

		UseGroupHealthBar = true,
		GroupHealthBarTypes = { "Stalker_Miniboss", },
		--HealthBarTextId = "Charybdis_Full",
		
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		MinWaves = 2,
		MaxWaves = 2,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 2.5,
		ActiveEnemyCapMax = 2.5,

		SpawnIntervalMin = 0.4,
		SpawnIntervalMax = 0.6,

		SpawnWaves =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "EarthElemental",
						TotalCount = 8,
						RequiredMiniBossShrine = false,
					},
					{
						Name = "EarthElemental_Shadow",
						TotalCount = 12,
						RequiredMiniBossShrine = true,
					},
				},
				StartDelay = 3.0,
			},
		},
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Stalker_Miniboss" }, IgnoreAI = true, SkipPresentation = true, } },
			{ FunctionName = "SetupGroupHealthBar", Args = { } },
		},

		NextRoomResumeMusic = true,
		WipeEnemiesOnKillAllTypes = { "Stalker_Miniboss" },
		CancelSpawnsOnKillAllTypes = { "Stalker_Miniboss" },
		BossKillGlobalVoiceLines = "MiniBossEncounterEndVoiceLines",
		HoldKillPresentationForUnitDeaths = { "Stalker_Miniboss" }
	},

	BossTyphonEye01 =
	{
		InheritFrom = { "MinibossEncounter", },
		SkipBossTraits = true,
		PreSpawnEnemies = false,
		SpawnAggroed = true,
		DelayedStart = true,
		SkipIntroEncounterCheck = true,
		
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,
		
		BlockAthenaEncounterKeepsake = true,
		BlockDionysusEncounterKeepsake = true,

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "TyphonEye" }, IgnoreAI = true, SkipPresentation = true, } },
		},

		WipeEnemiesOnKill = "TyphonEye",
		CancelSpawnsOnKill = { "TyphonEye" },
		SpawnThreadName = "TyphonSpawnThread",
		ForceCombatResolvedAudio = true,
	},

	BossTyphonTail01 =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedQ" },
		SkipBossTraits = true,
		PreSpawnEnemies = false,
		SpawnAggroed = true,
		DelayedStart = true,
		SkipIntroEncounterCheck = true,
		
		UnthreadedEvents = EncounterSets.EncounterEventsMiniBossTyphonTail,
		
		BlockAthenaEncounterKeepsake = true,
		BlockDionysusEncounterKeepsake = true,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 7,
		ActiveEnemyCapMax = 7,

		SpawnIntervalMin = 12.0,
		SpawnIntervalMax = 16.0,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "DragonBurrower_Shadow",
						TotalCount = 8,
						SpawnOnIds = { 779829, 779865, 779828, 779852, 779853, 779855 },
						RequiredMiniBossShrine = true,
					},
				},
				SkipWaitForAllDead = true
			},
		},

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "TyphonTail" }, IgnoreAI = true, SkipPresentation = true, } },
		},

		WipeEnemiesOnKill = "TyphonTail",
		CancelSpawnsOnKill = { "TyphonTail" },
		SpawnThreadName = "TyphonSpawnThread",

		-- VO handled in TyphonIncursionVoiceLines
		-- StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	BossTyphonArm01 =
	{
		InheritFrom = { "MinibossEncounter" },
		
		SkipBossTraits = true,
		BlockAthenaEncounterKeepsake = true,
		BlockDionysusEncounterKeepsake = true,

		DelayedStart = true,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "TyphonArm" }, IgnoreAI = true, SkipPresentation = true, } },
		},

		WipeEnemiesOnKill = "TyphonArm",
		CancelSpawnsOnKill = { "TyphonArm" },
		SpawnThreadName = "TyphonSpawnThread",
	},
})