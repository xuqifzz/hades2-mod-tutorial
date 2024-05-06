OverwriteTableKeys( EncounterData,
{
	-- MiniBoss Encounters
	-- NOTE(andrew): Moved MiniBossEncounter base and inheriting from "GeneratedF"
	-- to EncounterData.lua for Tech Test

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

	MiniBossCrawler =
	{
		InheritFrom = { "MinibossEncounter" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

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

		SpawnAggroed = true,

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
					--[[
					{
						Name = "Mourner_Support",
						InfiniteSpawns = false,
						TotalCount = 1,
						SpawnOnIds = { 622331 },
					},
					]]
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
						Name = "Lamia_Support",
						TotalCount = 4,
						SpawnOnIds = { 622525, 622542, 622543, 622544, },
					},
					SpawnOverrides = {
						SpawnAngleTowardId = 565479,
					},
				},
				SkipWaitForAllDead = true
			},
		},

		PreSpawnSpawnOverrides = {},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "Lamia" },
		WipeEnemiesOnKill = "Lamia_Miniboss",
	},

	MiniBossSatyrCrossbow =
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
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 4,

		SpawnIntervalMin = 2.25,
		SpawnIntervalMax = 5.4,
		StartDelay = 2,

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
						Name = "Carrion",
						TotalCount = 5,
					},
				},
				StartDelay = 0.5,
			},
		},

		CancelSpawnsOnKill = { "SatyrCrossbow" },

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	MiniBossCharybdis =
	{
		InheritFrom = { "MinibossEncounter" },
		PreSpawnEnemies = true,
		SpawnAggroed = true,

		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		NextRoomResumeMusic = true,
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Charybdis", "CharybdisTentacle" }, IgnoreAI = true, SkipPresentation = true, } },
			{ FunctionName = "SetupGroupHealthBar", Args = { } }
		},

		UseGroupHealthBar = true,
		GroupHealthBarTypes = { "Charybdis", "CharybdisTentacle" },
		HealthBarTextId = "Charybdis_Full",

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKillAllTypes = { "CharybdisTentacle" },
		WipeEnemiesOnKillAllTypes = { "CharybdisTentacle" }
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

		SpawnIntervalMin = 5.0,
		SpawnIntervalMax = 10.0,

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
					--[[{
						Name = "SatyrLancer",
						InfiniteSpawns = true,
					},]]
				},
				SkipWaitForAllDead = true
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "SatyrRatCatcher_Miniboss" },
		--WipeEnemiesOnKill = "FogEmitter_Elite",
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

		SpawnIntervalMin = 2.0,
		SpawnIntervalMax = 6.0,

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
				},
				SkipWaitForAllDead = true
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "GoldElemental_MiniBoss" },
		--WipeEnemiesOnKill = "FogEmitter_Elite",
	},
})