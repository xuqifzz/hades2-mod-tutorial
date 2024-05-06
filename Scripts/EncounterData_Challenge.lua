OverwriteTableKeys( EncounterData,
{
	CapturePoint =
	{
		GroupReinforcements = false,
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		ExitsDontRequireCompleted = true,
		CapturePointTickAmountMultiplier = 2.0,
		CapturePointTickDuration = 0.6,
		StartingCaptureProgress = 20,

		UnthreadedEvents = EncounterSets.EncounterEventsCapturePoint,

		SpawnIntervalMin = 0.5,
		SpawnIntervalMax = 0.8,

		MinTypes = 2,
		MaxTypes = 3,
		MaxTypesCap = 3,
		TypeCountDepthRamp = 0,
		MinWaves = 1,
		MaxWaves = 1,

		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMin = 8,
		ActiveEnemyCapMax = 8,

		LootDrops =
		{
			GiftDrop =
			{
				DropChance = 0.05,
				DropCount = 1,
			},
		},
		StartingValue = 100,
		MinValue = 10,
		ValueDepthRamp = 0.0,
		ValueDecayAmount = 1,
		LootDecayInterval = 1.0,
		DecayStartDelay = 9.0,

		SpawnRadius = 1000,
		DifficultyModifier = 0,
		DepthDifficultyRamp = 0,

		RequireCompletedIntro = true,
		IgnoreSpawnPreferences = true,
		SkipLastKillPresentation = true,
		PreSpawnMinPlayerDistance = 0,
		RequireNearPlayerDistance = 750,
		DestroyEnemyInterval = 0.05,


		InfiniteSpawns = true,
		TimeLimit = 45,
		AddAtTimeInterval = 12,

		SpawnWaves =
		{
		},

		ManualWaveTemplates =
		{
			{
				AddAtTime = 45,
				Spawns = {},
				RequireCompletedIntro = true,
			}
		},

		WaveTemplate =
		{
			AddAtTime = 45,
			MinTypes = 1,
			MaxTypes = 1,
			Spawns = {},
			RequireCompletedIntro = true,
		},
		SpawnThreadName = "SurvivalSpawnThread",
	},

	CapturePointF =
	{
		InheritFrom = { "CapturePoint", "GeneratedF" },
		BaseDifficulty = 110,
	},

	GeneratedAnomalyBase =
	{
		InheritFrom = { "Generated" },
		GroupReinforcements = false,
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		-- for GameStateRequirements, search AnomalyDoorRequirements =

		CapturePointTickAmountMultiplier = 1.0,
		CapturePointTickDuration = 0.35,
		StartingCaptureProgress = 15,

		CapturePointMoveSearchDistance = 2000,
		CapturePointMoveTimeout = 8,
		CapturePointMoveSpeed = 120,
		CapturePointMoveSpeedMin = 140,
		CapturePointMoveSpeedMax = 300,
		CapturePointMoveChance = 0.80,
		CapturePointMoveWaitDuration = 2.0,
		CapturePointMoveSuccessWaitDuration = 2.0,

		UnthreadedEvents = EncounterSets.EncounterEventsAnomaly,

		HeroDeathEvents =
		{
			{
				FunctionName = "HadesSpeakingPresentation",
				Args =
				{
					OverlayAnim = "ChronosOverlay",
					BlockScreenshake = true,
					VoiceLines = GlobalVoiceLines.ChronosDeathTauntVoiceLines,
				},
				GameStateRequirements =
				{
					NamedRequirements = { "NightmarePresentationRequirements" },
				},
			},
		},

		SpawnIntervalMin = 3.65,
		SpawnIntervalMax = 4.85,

		MinTypes = 2,
		MaxTypes = 3,
		MaxTypesCap = 3,
		TypeCountDepthRamp = 0,
		MinWaves = 1,
		MaxWaves = 1,
		MaxEliteTypes = 1,

		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMin = 5,
		ActiveEnemyCapMax = 5,

		DifficultyModifier = 0,
		DepthDifficultyRamp = 0,

		RequireCompletedIntro = true,
		IgnoreSpawnPreferences = true,
		SkipLastKillPresentation = true,
		PreSpawnMinPlayerDistance = 0,
		RequireNearPlayerDistance = 750,
		DestroyEnemyInterval = 0.05,

		InfiniteSpawns = true,
		TimeLimit = 45,
		AddAtTimeInterval = 12,

		SpawnWaves =
		{
		},

		ManualWaveTemplates =
		{
			{
				AddAtTime = 45,
				Spawns = {},
				RequireCompletedIntro = true,
			}
		},

		WaveTemplate =
		{
			AddAtTime = 45,
			MinTypes = 1,
			MaxTypes = 1,
			Spawns = {},
			RequireCompletedIntro = true,
		},

		SkipExitReadyCheckpoint = true,
	},

	GeneratedAnomalyB =
	{
		InheritFrom = { "GeneratedAnomalyBase" },
		EnemySet = EnemySets.BiomeB,

		DistanceTriggers =
		{
			{
				TriggerObjectType = "CapturePointSwitch",
				PreTriggerWait = 1.0,
				WithinDistance = 700,
				VoiceLines =
				{
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						SuccessiveChanceToPlayAll = 0.33,
						Cooldowns =
						{
							{ Name = "AnomalyVOPlayed", Time = 4 },
						},

						{ Cue = "/VO/MelinoeField_0201", Text = "There's something..." },
						{ Cue = "/VO/MelinoeField_0202", Text = "Over there...", PlayFirst = true },
						{ Cue = "/VO/MelinoeField_0203", Text = "{#Emph}Ah-ha..." },
						{ Cue = "/VO/MelinoeField_0204", Text = "There's the rift..." },
					}
				}
			}
		},
	},

	PerfectClear =
	{
		EncounterType = "PerfectClear",
		GroupReinforcements = false,
		PreSpawnEnemies = false,
		SpawnAggroed = true,
		
		ExitsDontRequireCompleted = true,

		SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,

		PlayerTookDamage = false,
		AddTraitOnFirstPlayerTookDamage = "OnionCurse",
		UnthreadedEvents = EncounterSets.EncounterEventsPerfectClear,

		Spawns = {},
		DestroyEnemyInterval = 0.05,

		StartGlobalVoiceLines = "PerfectClearStartVoiceLines",
		EncounterResolvedGlobalVoiceLines = "PerfectClearCompleteVoiceLines",

		FastClearThreshold = 90,

		MinRoomsBetweenType = 0,
		MinTypes = 3,
		MaxTypes = 3,
		MaxTypesCap = 3,
		MinWaves = 1,
		MaxWaves = 1,
		
		LootDrops =
		{
			GiftDrop =
			{
				DropChance = 0.05,
				DropCount = 1,
			},
		},
		StartingValue = 100,
	},

	PerfectClearChallenge =
	{
		InheritFrom = { "PerfectClear" },
		UnthreadedEvents = EncounterSets.EncounterEventsPerfectClearChallenge,
	},

	PerfectClearChallengeF =
	{
		InheritFrom = { "PerfectClearChallenge", "GeneratedF" },
		EnemySet = EnemySets.BiomeF;
		--RequiredBiome = "F",
		
		ActiveEnemyCapBase = 2.3,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,
		DepthDifficultyRamp = 11,

		HardEncounterOverrideValues =
		{
		},

		BaseDifficulty = 60,
	},
})