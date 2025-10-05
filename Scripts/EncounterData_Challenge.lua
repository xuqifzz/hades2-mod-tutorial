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
		Using = { SpawnObstacle = "CapturePoint", },
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

		CanEncounterSkip = false,
		BlockAthenaEncounterKeepsake = true,
		BlockDionysusEncounterKeepsake = true,

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
					OverlayDeathFx = true,
					BlockScreenshake = true,
					VoiceLines = { GlobalVoiceLines = "ChronosDeathTauntVoiceLines" },
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

		CanEncounterSkip = false,
		BlockAthenaEncounterKeepsake = true,

		StartSound = "/Leftovers/Menu Sounds/EmoteAscendedLuciferChoir",
		
		ExitsDontRequireCompleted = true,

		SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,

		PlayerTookDamage = false,
		UnthreadedEvents = EncounterSets.EncounterEventsPerfectClear,

		Spawns = {},
		DestroyEnemyInterval = 0.05,

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
		ValueDepthRamp = 0.0,
	},

	PerfectClearChallenge =
	{
		InheritFrom = { "PerfectClear" },
		NextRoomResumeMusic = true, -- In case the player leaves before the music resumes
		UnthreadedEvents = EncounterSets.EncounterEventsPerfectClearChallenge,
	},

	PerfectClearChallengeF =
	{
		InheritFrom = { "PerfectClearChallenge", "GeneratedF" },
		EnemySet = EnemySets.BiomeF,
		
		ActiveEnemyCapBase = 5.1,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,
		DepthDifficultyRamp = 11,

		HardEncounterOverrideValues =
		{
		},

		BaseDifficulty = 60,
	},

	PerfectClearChallengeG =
	{
		InheritFrom = { "PerfectClearChallenge", "GeneratedG" },
		EnemySet = EnemySets.BiomeG,
		
		ActiveEnemyCapBase = 2.6,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,

		HardEncounterOverrideValues =
		{
		},
	},

	PerfectClearChallengeH =
	{
		InheritFrom = { "PerfectClearChallenge", "GeneratedH" },
		EnemySet = EnemySets.BiomeH,
		
		ActiveEnemyCapBase = 2.6,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,

		HardEncounterOverrideValues =
		{
		},
	},

	PerfectClearChallengeI =
	{
		InheritFrom = { "PerfectClearChallenge", "GeneratedI" },
		EnemySet = EnemySets.BiomeI,
		
		ActiveEnemyCapBase = 5.1,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,

		HardEncounterOverrideValues =
		{
		},
	},

	PerfectClearChallengeN =
	{
		InheritFrom = { "PerfectClearChallenge", "GeneratedN" },
		EnemySet = EnemySets.BiomeN,
		
		ActiveEnemyCapBase = 2.6,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,

		HardEncounterOverrideValues =
		{
		},
	},

	PerfectClearChallengeO =
	{
		InheritFrom = { "PerfectClearChallenge", "GeneratedO" },
		DelayedStart = false,
		EnemySet = EnemySets.BiomeO,
		
		ActiveEnemyCapBase = 2.6,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.55,

		HardEncounterOverrideValues =
		{
		},
	},

	PerfectClearChallengeP =
	{
		InheritFrom = { "PerfectClearChallenge", "GeneratedP" },
		EnemySet = EnemySets.BiomeP,
		
		ActiveEnemyCapBase = 4.1,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,

		HardEncounterOverrideValues =
		{
		},
	},

	PerfectClearChallengeQ =
	{
		InheritFrom = { "PerfectClearChallenge", "GeneratedQ" },
		EnemySet = EnemySets.BiomeQ,
		
		ActiveEnemyCapBase = 2.6,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,

		HardEncounterOverrideValues =
		{
		},
	},

	EliteChallenge =
	{
		EncounterType = "EliteChallenge",
		GroupReinforcements = false,
		PreSpawnEnemies = false,
		SpawnAggroed = true,
		
		CanEncounterSkip = false,
		BlockAthenaEncounterKeepsake = true,

		StartSound = "/Leftovers/Menu Sounds/EmoteAscendedGilgameshFlute",
		NextRoomResumeMusic = true, -- In case the player leaves before the music resumes

		ExitsDontRequireCompleted = true,
		UnthreadedEvents = EncounterSets.EncounterEventsEliteChallenge,

		ForceEliteAttrubuteCount = 2,
		BannedEliteAttributes = { "Metallic", "SpreadHitShields", "StasisDeath", "HeavyArmor", },

		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,

		MinTypes = 1,
		MaxTypes = 1,
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
		DecayStartDelay = 8.0,

		SpawnRadius = 1000,
		DifficultyModifier = 0,
		DepthDifficultyRamp = 0,

		RequireCompletedIntro = true,
		IgnoreSpawnPreferences = true,
		PreSpawnMinPlayerDistance = 0,

		BlockNextBiomeEnemyShrineUpgrade = true,

		SpawnOverrides =
		{
			HealthBufferMultiplier = 4,
			HealthBufferBonus = 2000,
			HealthBarType = "ExtraLarge",

			SpawnEvents =
			{
				{
					FunctionName = "EliteChallengeSpawnPresentation",
					Threaded = true,
				},
			},
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						TotalCount = 1,
						Generated = true
					},
				},
			},
		},

		TimedSpawnsVictoryText = "TimedChallenge_Victory",
		TimedSpawnsFailureText = "TimedChallenge_Failure",
	},

	EliteChallengeF =
	{
		InheritFrom = { "EliteChallenge", "GeneratedF" },
		EnemySet = EnemySets.BiomeF_EliteChallenge,
		BaseDifficulty = 130,
	},

	EliteChallengeG =
	{
		InheritFrom = { "EliteChallenge", "GeneratedG" },
		EnemySet = EnemySets.BiomeG_EliteChallenge,
		BaseDifficulty = 240,
	},

	EliteChallengeH =
	{
		InheritFrom = { "EliteChallenge", "GeneratedH" },
		EnemySet = EnemySets.BiomeH_EliteChallenge,
	},

	EliteChallengeI =
	{
		InheritFrom = { "EliteChallenge", "GeneratedI" },
		EnemySet = EnemySets.BiomeI_EliteChallenge,
		BaseDifficulty = 380,
	},

	EliteChallengeN =
	{
		InheritFrom = { "EliteChallenge", "GeneratedN" },
		EnemySet = EnemySets.BiomeN_EliteChallenge,
		BaseDifficulty = 150,
	},

	EliteChallengeO =
	{
		InheritFrom = { "EliteChallenge", "GeneratedO" },
		DelayedStart = false,
		EnemySet = EnemySets.BiomeO_EliteChallenge,
		BaseDifficulty = 300,
	},

	EliteChallengeP =
	{
		InheritFrom = { "EliteChallenge", "GeneratedP" },
		EnemySet = EnemySets.BiomeP_EliteChallenge,
		BaseDifficulty = 400,
	},

	EliteChallengeQ =
	{
		InheritFrom = { "EliteChallenge", "GeneratedQ" },
		EnemySet = EnemySets.BiomeQ_EliteChallenge,
	},
})