ConstantsData.MinimumDifficulty = 10

WaveDifficultyPatterns =
{
	{ 1 },
	{ 0.5, 0.5 },
	{ 0.3, 0.15, 0.55 },
	{ 0.3, 0.1, 0.2, 0.4 },
	{ 0.25, 0.1, 0.15, 0.15, 0.35 },
}

TimerBlockCombatExcludes = 
{
	"ThanatosEncounter", "SurvivalEncounter", "ArtemisEncounter", "IcarusEncounter",
}

BaseWaveOverrideValues =
{
	RequireNearPlayerDistance = 1500,
	SpawnAggroed = true,
	IgnoreSpawnPreferences = true,
}

IntroWaveOverrideValues =
{
	ActiveEnemyCapBase = 2.3,
	ActiveEnemyCapMax = 8,
	ActiveEnemyCapDepthRamp = 0.35,
	SpawnIntervalMin = 0.175,
	SpawnIntervalMax = 0.225,
	RequireNearPlayerDistance = 750,
	SpawnAggroed = true,
	IgnoreSpawnPreferences = true,
}

EncounterData =
{
	NonCombat =
	{
		EncounterType = "NonCombat",
		SkipExitReadyCheckpoint = true,
		SkipLastKillPresentation = true,
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,
	},

	Empty =
	{
		InheritFrom = { "NonCombat" },
		SkipCombatBeginsVoiceLines = true,
		SkipLastKillPresentation = true,
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,
		ThreadedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "O_PostBoss01", "Q_Intro" },
					},
				},
				Args =
				{
					SetSoundCueValues =
					{
						{
							Name = "Drums",
							Value = 0.0,
							AudioStateId = "MusicId",
							Duration = 1.0,
						}
					},
				},
			},
		},
	},

	-- Generated Encounters
	Generated =
	{
		EncounterType = "Default",
		Generated = true,
		CountsForRoomEncounterDepth = true,
		PreSpawnEnemies = true,
		PreSpawnMinEndPointDistance = 750,
		GroupReinforcements = false,
		RemoveDistanceReqsForReinforcements = true,
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "HandleEncounterPreSpawns"
			}
		},

		EncounterSpawnsStartEvents =
		{
			{
				Threaded = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = GameData.BannedEnemySightedEncounters,
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "RanEncounterSpawnsStartEvents" },
					},
				},
				FunctionName = "DistanceTrigger",
				Args =
				{
					WithinDistance = 600,
					TriggerGroups = { "EnemyTeam", },
					PostTriggerEvents =
					{
						{
							FunctionName = "CheckEnemySightedVoiceLines",
						},
					},
				},
			},
		},

		WaveRequiredRemainingCount = 1,
		AggroRemainingEnemiesOnWaveStart = true,

		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,
		ActiveEnemyCapBase = 2.3,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,
		MinTypes = 1,
		MaxTypes = 2,
		MinWaves = 1,
		MaxWaves = 3,
		MaxTypesCap = 3,
		TypeCountDepthRamp = 0.20,
		BaseDifficulty = 30,
		DepthDifficultyRamp = 10,
		MoneyDropCapMin = 10,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0.5,
		EnemySet = EnemySets.BiomeF,
		WaveStartPresentationFunction = "StartWavePresentation",
		BlockTypesAcrossWaves = true,

		Spawns = {},
		SpawnWaves = {},
		WaveTemplate =
		{
			Spawns =
			{

			},
			OverrideValues = BaseWaveOverrideValues,
			StartDelay = 0.5,
		},
		NoFirstWaveStartDelay = true,

		ReinforcementsDataOverride =
		{
			RequireNearPlayerDistance = 750,
			SpawnAggroed = true,
		},

		PreSpawnSpawnOverrides =
		{
			WakeUpDelay = 0.3,
			--AggroReactionTimeMin = 1.15,
			--AggroReactionTimeMax = 1.35,
			AggroReactionTimeMin = 0.15,
			AggroReactionTimeMax = 0.45,
			IgnoreCurseDamage = true,
		},
	},

	GeneratedF =
	{
		InheritFrom = { "Generated" },
		CanEncounterSkip = true,
		BlockAthenaEncounterKeepsake = false,
		EnemySet = EnemySets.BiomeF,
		SpawnIntervalMin = 0.200,
		SpawnIntervalMax = 0.400,
		ActiveEnemyCapBase = 4.0,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 0.35,
		MinTypes = 2,
		MaxTypes = 2,
		MinWaves = 1,
		--TypeCountDepthRamp = 0.10,
		TypeCountDepthRamp = 0.20,
		MaxTypesCap = 3,
		BaseDifficulty = 55,
		DepthDifficultyRamp = 15,
		MaxEliteTypes = 1,

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 30,
			MaxTypesCap = 4,
			ActiveEnemyCapDepthRamp = 0.60
			--EnemySet = EnemySets.BiomeF,
			--MaxEliteTypes = 5,
		},
	},

	-- Intro Encounters
	BaseIntroEncounter =
	{
		SpawnIntervalMin = 0.0,
		SpawnIntervalMax = 0.0,

		Generated = true,
		PreSpawnEnemies = true,
		MinWaves = 2,
		MaxWaves = 2,
		MinTypes = 2,
		MaxTypes = 2,
		MaxTypesCap = 2,

		EnemyCountDepthRamp = 0.0,
		ActiveEnemyCapBase = 3,
		ActiveEnemyCapDepthRamp = 0.35,
		DifficultyModifier = 0,
		DifficultyMultiplier = 2.0, -- this is to bulk up the second wave, since the first wave always has only 2 units
	},

	GuardIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedF" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Guard",
						CountMin = 3,
						CountMax = 3,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Guard",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	RadiatorIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedF" },
		DifficultyModifier = 25,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Radiator",
						CountMin = 5,
						CountMax = 5,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Radiator",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues =
			{
				ActiveEnemyCapBase = 8,
				ActiveEnemyCapMax = 8,
				SpawnIntervalMin = 0.175,
				SpawnIntervalMax = 0.225,
				RequireNearPlayerDistance = 750,
				SpawnAggroed = true,
				IgnoreSpawnPreferences = true,
			},
			RequireCompletedIntro = true,
		},
	},

	ScreamerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedF" },
		DifficultyModifier = 20,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Screamer",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Screamer",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	SiegeVineIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedF" },
		DifficultyModifier = 45,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SiegeVine_Elite",
						CountMin = 1,
						CountMax = 1,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "SiegeVine_Elite",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	-- Opening Encounters
	OpeningEmpty =
	{
		InheritFrom = { "NonCombat" },
		AlwaysForce = true,

		OnSpawnFunctionName = "ArachneCombatDrumCheck",
		OnKillFunctionName = "ArachneCombatDrumCheck",

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "UseRecord", "ApolloUpgrade" },
			},
		},

		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "CheckPriorityConversations",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					Conversations =
					{
						"NemesisFieldFirstMeeting",
					},
				},
			},
		},

		UnthreadedEvents =
		{
			{ FunctionName = "EncounterAudio" },
			{ FunctionName = "PostCombatAudio" },
		}
	},

	OpeningGeneratedF =
	{
		InheritFrom = { "GeneratedF" },
		RequireCompletedIntro = true,
		CanEncounterSkip = false,
		BlockAthenaEncounterKeepsake = true,
		CatFamiliarTeleportToHero = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache", "OpeningEmpty" },
				Comparison = ">=",
				Value = 1,
			},
		},
		GroupReinforcements = false,
		MaxWaves = 1,
		DifficultyModifier = -20,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,
		DelayedStart = true,

		PreSpawnEnemies = false,
		
		UnthreadedEvents =
		{
			{
				FunctionName = "SpawnRoomReward",
				Args =
				{
					WaitUntilPickup = true,
				}
			},
			{ FunctionName = "EncounterAudio" },
			{ FunctionName = "BeginOpeningEncounter" },
			{ FunctionName = "HandleEnemySpawns" },
			{ FunctionName = "CheckForAllEnemiesDead" },
			{ FunctionName = "PostCombatAudio" },
		}
	},

	FIntroFight =
	{
		AlwaysForce = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasNone = { "ApolloFirstPickUp" },
			},
		},
		PreSpawnEnemies = true,

		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		SpawnWaves =
        {
            {
                Spawns =
                {
					{
						Name = "Brawler",
						CountMin = 1,
						CountMax = 1,
						SpawnOnId = 557598,
					},
                },
				StartDelay = 0,
				OverrideValues =
				{
					SpawnIntervalMin = 0.175,
					SpawnIntervalMax = 0.225,
				},
            },

			-- wave 2
			{
                Spawns =
                {
					{
						Name = "Guard",
						CountMin = 4,
						CountMax = 4,
						SpawnOnIds = { 557599, 557600, 557601, 557602, },
					},
                },
                StartDelay = 1,
				OverrideValues =
				{
					SpawnIntervalMin = 0.175,
					SpawnIntervalMax = 0.225,
				},
            },

			-- wave 3
			{
                Spawns =
                {
					{
						Name = "Mage",
						CountMin = 3,
						CountMax = 3,
						SpawnOnIds = { 557603, 557604, 557605, },
					},
                },
                StartDelay = 0.8,
				OverrideValues =
				{
					SpawnIntervalMin = 0.5,
					SpawnIntervalMax = 0.5,
				},
            },

			-- wave 4
			{
                Spawns =
                {
					{
						Name = "Brawler",
						CountMin = 1,
						CountMax = 1,
						SpawnOnId = 557604,
					},

					{
						Name = "Guard",
						CountMin = 3,
						CountMax = 3,
						SpawnOnIds = { 557606, 557608, 557607, },
					},

					{
						Name = "Mage",
						CountMin = 1,
						CountMax = 1,
						SpawnOnId = 557597,
					},
                },
                StartDelay = 0.9,
				OverrideValues =
				{
					SpawnIntervalMin = 0.225,
					SpawnIntervalMax = 0.275,
				},
            },
        },
	},

	FCastTutorialFight =
	{
		AlwaysForce = true,

		GameStateRequirements =
		{
            {
                Path = { "GameState", "EncountersCompletedCache", "OpeningEmpty" },
                Comparison = ">=",
                Value = 1,
            },
            {
                PathFalse = { "GameState", "EncountersCompletedCache", "FCastTutorialFight" },
            },
		},
        PreSpawnEnemies = false,

        ObjectiveSets = "FCastTutorialInCombat",

        UnthreadedEvents =
        {
            {
                FunctionName = "SpawnRoomReward",
                Args =
                {
                    WaitUntilPickup = true,
                }
            },
            { FunctionName = "EncounterAudio" },
            { FunctionName = "BeginOpeningEncounter" },
            { FunctionName = "HandleEnemySpawns" },
            { FunctionName = "CheckForAllEnemiesDead" },
            { FunctionName = "PostCombatAudio" },
        },

        SpawnIntervalMin = 0.175,
        SpawnIntervalMax = 0.225,
		SpawnWaves =
        {
            {
                Spawns =
                {
					{
						Name = "Guard",
						TotalCount = 10,
					},
                },
            },
        },

		StartVoiceLines =
		{
			PreLineWait = 2.6,
			PlayOnce = true,
			PlayOnceContext = "FCastTutorialVO",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "CurrentRoom", "/VO/Melinoe_0635" },
				},
			},

			{ Cue = "/VO/MelinoeField_2061", Text = "All of you, gather 'round..." },
		},
	},

	-- MiniBoss Encounters
	MinibossEncounter =
	{
		EncounterType = "Miniboss",
		BlockSpawnMultipliers = true,
		BlockEliteAttributes = true,
		BlockNextBiomeEnemyShrineUpgrade = true,

		BlockAthenaEncounterKeepsake = true,
	},

	MiniBossTreant =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedF" },

		GameStateRequirements =
		{
			NamedRequirementsFalse = { "MinibossCountShrineUpgradeActive" },
		},

		PreSpawnEnemies = false,
		SpawnAggroed = true,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMax = 5,

		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.05,

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
						Name = "Treant",
						TotalCount = 1,
						SpawnOnIds = { 40191 },
						ForceFirst = true,
					},
				},
				StartDelay = 0.7,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "Treant" },
		WipeEnemiesOnKill = "Treant",
	},

	MiniBossTreant_Shrine =
	{
		InheritFrom = { "MiniBossTreant", },

		GameStateRequirements =
		{
			NamedRequirements = { "MinibossCountShrineUpgradeActive" },
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Treant_Shadow",
						TotalCount = 1,
						SpawnOnIds = { 40191 },
						ForceFirst = true,
					},
				},
				StartDelay = 0.7,
			},
		},

		CancelSpawnsOnKill = { "Treant_Shadow" },
		WipeEnemiesOnKill = "Treant_Shadow",
	},

	MiniBossFogEmitter =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedF", },

		GameStateRequirements =
		{
			NamedRequirementsFalse = { "MinibossCountShrineUpgradeActive" },
		},

		PreSpawnEnemies = true,
		SpawnAggroed = true,

		MinWaves = 2,
		MaxWaves = 2,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMin = 10,
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
						Name = "FogEmitter_Elite",
						TotalCount = 1,
						SpawnOnIds = { 40191 },
						ForceFirst = true,
					},
				},
				SkipWaitForAllDead = true
			},
			[2] =
			{
				Spawns =
				{
					{
						Name = "SiegeVine",
						TotalCount = 3,
						SpawnOnIds = { 558168, 558195, 558169, 558165, 558194, 558166, },
					},
				},
				StartDelay = 1.2,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "FogEmitter_Elite" },
		--WipeEnemiesOnKill = "FogEmitter_Elite",
	},

	MiniBossFogEmitter_Shrine =
	{
		InheritFrom = { "MiniBossFogEmitter", },

		GameStateRequirements =
		{
			NamedRequirements = { "MinibossCountShrineUpgradeActive" },
		},

		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMin = 5,
		ActiveEnemyCapMax = 5,
		SpawnIntervalMin = 1.0,
		SpawnIntervalMax = 2.0,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "FogEmitter_Shadow",
						TotalCount = 1,
						SpawnOnIds = { 40191 },
						ForceFirst = true,
					},
				},
				SkipWaitForAllDead = true
			},
			[2] =
			{
				Spawns =
				{
					{
						Name = "Screamer_Shadow",
						InfiniteSpawns = true,
						SpawnOnIds = { 558168, 558195, 558169, 558165, 558194, 558166, },
					},
				},
				StartDelay = 0.5,
			},
		},

		CancelSpawnsOnKill = { "FogEmitter_Shadow" },
		WipeEnemiesOnKill = "FogEmitter_Shadow",
	},

	-- Boss Encounters
	BossEncounter =
	{
		EncounterType = "Boss",
		BlockSpawnMultipliers = true,
		BlockRespawnShrineUpgrade = true,
		ActiveEnemyCapMax = 7,
		
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		BlockAthenaEncounterKeepsake = true,
		RecordClearStats = true,
	},

	BossHecate01 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,
		WipeEnemiesOnKill = "Hecate",
		SkipLastKillPresentation = true,

		-- @ ending
		GameStateRequirements =
		{
			NamedRequirementsFalse = { "NearTrueEnding", "HecateMissing" },
		},
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Hecate" }, IgnoreAI = true, SkipPresentation = true, } },
		},
	},

	BossHecate02 =
	{
		InheritFrom = { "BossHecate01" },
	},

	HecateSpawns01 =
	{
		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		ActiveEnemyCapBase = 5,
		BlockSpawnMultipliers = true,

		SkipCleanupRaiseDead = true,

		UnthreadedEvents = EncounterSets.EncounterEventsBossSpawnedEncounter,

		UseRoomEncounterEnemySet = true,

		WaveStartPresentationFunction = "StartWavePresentation",
		SkipNextWaveVoicelines = true,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "LightRanged",
						TotalCount = 4,
						SpawnOnIds = { 566514, 566516, 566519, 566512, 566511, 566513, 566518, 566517, 566515, 566520, },
					},
				},
				StartDelay = 4.0, -- Need to give time for HecateCopys to clear (bones budget)
				StartGlobalVoiceLines = "HecateBossSpawnWaveVoiceLines",
			},
		},
	},

	HecateSpawns02 =
	{
		InheritFrom = { "HecateSpawns01" },

		ActiveEnemyCapBase = 10,
		AllAddsDeadGlobalVoiceLines = "HecateAddsDeadVoiceLines",

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "LightRanged",
						TotalCount = 8,
						SpawnOnIds = { 566514, 566516, 566519, 566512, 566511, 566513, 566518, 566517, 566515, 566520, },
					},
				},
				StartDelay = 4.0, -- Need to give time for HecateCopys to clear (bones budget)
				StartGlobalVoiceLines = "HecateBossSpawnWaveVoiceLines",
			},
		},
	},

	HecateEMSpawns01 =
	{
		InheritFrom = { "HecateSpawns01" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "LightRanged_Elite",
						TotalCount = 4,
						SpawnOnIds = { 594262, 594260, 594254, 594264, 594257, 594259, 594255, 594261, 594253, 594258, 594265, 594266, 594263, 594256, },
					},
				},
				StartDelay = 4.0, -- Need to give time for HecateCopys to clear (bones budget)
				StartGlobalVoiceLines = "HecateBossSpawnWaveVoiceLines",
			},
		},
	},

	HecateEMSpawns02 =
	{
		InheritFrom = { "HecateSpawns01" },

		ActiveEnemyCapBase = 10,
		AllAddsDeadGlobalVoiceLines = "HecateAddsDeadVoiceLines",

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "LightRanged_Elite",
						TotalCount = 6,
						SpawnOnIds = { 594262, 594260, 594254, 594264, 594257, 594259, 594255, 594261, 594253, 594258, 594265, 594266, 594263, 594256, },
					},
				},
				StartDelay = 4.0, -- Need to give time for HecateCopys to clear (bones budget)
				StartGlobalVoiceLines = "HecateBossSpawnWaveVoiceLines",
			},
		},
	},

	-- @ ending

	BossHecateKidnapping =
	{
		InheritFrom = { "Empty" },
		SkipBossTraits = true,
		GameStateRequirements =
		{
			NamedRequirements = { "NearTrueEnding" },
			NamedRequirementsFalse = { "HecateMissing" },
		},

		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					Types = { "Hecate" },
					IgnoreAI = true,
					SkipPresentation = true,
				},
			},
			{
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					Types = { "NPC_Chronos_01" },
					IgnoreAI = true,
					SkipPresentation = true,
				},
			},
			{ FunctionName = "HecateKidnappingEntrancePresentation", },
		},

		UnthreadedEvents =
		{
			{ FunctionName = "EncounterAudio" },
			{ FunctionName = "CheckForAllEnemiesDead" },
			{ FunctionName = "PostCombatAudio" },
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					PreWait = 1.0,
				},
			},
			{
				FunctionName = "TriggerPostBossEvents"
			}
		},
	},

	-- @ ending
	BossHecateMissing =
	{
		InheritFrom = { "Empty" },

		GameStateRequirements =
		{
			NamedRequirements = { "HecateMissing" },
		},

		UnthreadedEvents =
		{
			{
				FunctionName = "TriggerPostBossEvents"
			}
		},
	},

}