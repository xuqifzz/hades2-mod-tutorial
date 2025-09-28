OverwriteTableKeys( EncounterData,
{
	-- Generated Encounters

	-- NOTE(andrew): Generated base and GeneratedF moved to 
	-- EncounterData.lua for the Tech Test

	GeneratedG =
	{
		InheritFrom = { "Generated" },
		CanEncounterSkip = true,
		BlockAthenaEncounterKeepsake = false,
		EnemySet = EnemySets.BiomeG,
		ActiveEnemyCapBase = 3.0,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,
		MinTypes = 1,
		MaxTypes = 2,
		MinWaves = 1,
		MaxWaves = 3,
		TypeCountDepthRamp = 0.10,
		MaxTypesCap = 3,
		BaseDifficulty = 140,
		DepthDifficultyRamp = 40,
		MaxEliteTypes = 2,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 25,
		MoneyDropCapDepthRamp = 0,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{

				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{

				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{

				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,

				StartThreadedEvents =
				{
					{ FunctionName = "FloodManager", GameStateRequirements = { ChanceToPlay = 1.0, }, Args = { Types = { "FloodTrap" }, IntervalMin = 12.0, IntervalMax = 25.0, FirstIntervalMin = 3.0, FirstIntervalMax = 6.0 } }
				}
			},
		},

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 30,
			MaxTypesCap = 4,
			ActiveEnemyCapDepthRamp = 0.60
			--EnemySet = EnemySets.BiomeG,
			--MaxEliteTypes = 5,
		},
	},

	GeneratedG_ExtraDoor =
	{
		InheritFrom = { "GeneratedG" },
		PreSpawnEnemies = false,
		EnemySet = EnemySets.BiomeGLockedDoor,
		UnthreadedEvents = EncounterSets.EncounterEventsExtraDoorUnlock,
		MinWaves = 1,
		MaxWaves = 1,
		ActiveEnemyCapBase = 3.0,
		--ExitsDontRequireCompleted = true,
		CanEncounterSkip = false,
		BlockAthenaEncounterKeepsake = true,
		BaseDifficulty = 38,
		DepthDifficultyRamp = 12,
		SpawnAggroed = true,
	},

	GeneratedH_Passive =
	{
		InheritFrom = { "Generated" },
		UnthreadedEvents = EncounterSets.EncounterEventsH,
		EnemySet = EnemySets.BiomeHPassive,
		BlockNextBiomeEnemyShrineUpgrade = true,
		BlockEliteAttributes = true,

		AggroRemainingEnemiesOnWaveStart = false,

		DelayedStart = true,
		NeverDelayStartFamiliar = true,
		NeverDelayManaRegen = true,
		NeverDelaySpellCharge = true,
		UseEncounterActiveCap = true,
		ActiveEnemyCapBase = 1.5,
		ActiveEnemyCapMax = 3,
		ActiveEnemyCapDepthRamp = 0.5,

		MinTypes = 2,
		MaxTypes = 2,
		MinWaves = 1,
		MaxWaves = 1,
		TypeCountDepthRamp = 0.5,
		MaxTypesCap = 4,
		BaseDifficulty = 180,
		DepthDifficultyRamp = 60,
		MaxEliteTypes = 3,
		MoneyDropCapMin = 10,
		MoneyDropCapMax = 30,
		MoneyDropCapDepthRamp = 0,
		CountsForRoomEncounterDepth = false,

		PreSpawnEnemies = true,
		RequireMinPlayerDistance = 1400,
		RequireNearPlayerDistance = 99999,
		SpawnAggroed = false,
		NoReinforcements = true,

		--SkipExitReadyCheckpoint = true,
		ExitsDontRequireCompleted = true,
		RecordActiveEnemies = true,

		SkipCombatBeginsVoiceLines = true,
		ExitsUnlockedThreadedEvents =
		{
			{
				FunctionName = "CheckFieldsExitIndicators",
			},
			{
				FunctionName = "FieldsExitsReadyPresentation",
			},
		},

		SpawnOverrides =
		{
			RequiredKill = false,
			BlocksLootInteraction = false,
		},
		RequiredSpawnPoint = "EnemyPointSupport",

		DistanceTriggers =
		{
			{
				TriggerGroup = "GroundEnemies",
				WithinDistance = 650,
				PreTriggerWait = 1.0,
				VoiceLines = { GlobalVoiceLines = "FieldsPassiveEnemiesSpottedVoiceLines" },
			}
		},
	},

	GeneratedH_PassiveSmall =
	{
		InheritFrom = { "GeneratedH_Passive" },

		ActiveEnemyCapBase = 1.0,
		ActiveEnemyCapMax = 1.5,
		ActiveEnemyCapDepthRamp = 0.2,

		BaseDifficulty = 60,
		DepthDifficultyRamp = 15,
		MaxEliteTypes = 1,
	},

	GeneratedH =
	{
		InheritFrom = { "Generated" },
		CanEncounterSkip = true,
		BlockAthenaEncounterKeepsake = false,
		ForceEncounterStart = true,
		UnthreadedEvents = EncounterSets.EncounterEventsH,
		EnemySet = EnemySets.BiomeH,

		UseEncounterActiveCap = true,
		ActiveEnemyCapBase = 4.5,
		ActiveEnemyCapMax = 7,
		ActiveEnemyCapDepthRamp = 0.5,

		MinTypes = 2.0,
		MaxTypes = 2.0,
		MaxTypesCap = 3,
		MinWaves = 1,
		MaxWaves = 1,
		TypeCountDepthRamp = 0.20,
		EscalateTypeCount = true, -- this is a difference from the 'randomized type count' we normally default to
		BaseDifficulty = 290,
		DepthDifficultyRamp = 82,
		UseEncounterDepth = true,
		MaxEliteTypes = 3,
		MoneyDropCapMin = 30,
		MoneyDropCapMax = 45,
		MoneyDropCapDepthRamp = 0,
		PreSpawnEnemies = false,
		RequireMinPlayerDistance = 600,
		RequireNearPlayerDistance = 2200,
		SpawnAggroed = true,
		RemoveDistanceReqsForReinforcements = false,
		NoFirstWaveStartDelay = true,
		DelayedStart = false,

		--[[
		SpawnIntervalMin = 0.04,
		SpawnIntervalMax = 0.08,
		]]
		SpawnIntervalMin = 0.75,
		SpawnIntervalMax = 0.95,

		SpawnOverrides =
		{
			ChainAggroAllEnemies = false,
		},

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 30,
			MaxTypesCap = 4,
			ActiveEnemyCapDepthRamp = 0.60
			--EnemySet = EnemySets.BiomeH,
			--MaxEliteTypes = 5,
		},

		DistanceTriggers =
		{
			{
				TriggerGroup = "GroundEnemies",
				WithinDistance = 650,
				VoiceLines = { GlobalVoiceLines = "FieldsEnemiesSpottedVoiceLines" },
			}
		},		
	},

	GeneratedH_Treant2 =
	{
		InheritFrom = { "GeneratedH", },
		BlockEliteAttributes = false,

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "GeneratedH_Treant2" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
		},

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 2,
		MaxTypes = 2,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 1,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Treant2",
						TotalCount = 1,
						ForceFirst = true,
					},
					{
						Generated = true
					},
				},
				SkipWaitForAllDead = true
			},
		},
	},

	GeneratedH_Screamer2 =
	{
		InheritFrom = { "GeneratedH", },
		BlockEliteAttributes = false,

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "GeneratedH_Screamer2" },
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ScreamerIntro" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
		},

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 2,
		MaxTypes = 2,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 1,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Screamer2",
						TotalCount = 1,
						ForceFirst = true,
					},
					{
						Generated = true
					},
				},
				SkipWaitForAllDead = true
			},
		},
	},

	GeneratedI =
	{
		InheritFrom = { "Generated" },
		CanEncounterSkip = true,
		BlockAthenaEncounterKeepsake = false,

		RequireNotRoomReward = { "ClockworkGoal" },

		EnemySet = EnemySets.BiomeI,
		ActiveEnemyCapBase = 2.0,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 1.0,
		MinTypes = 2,
		MaxTypes = 2,
		MaxTypesCap = 3,
		TypeCountDepthRamp = 0.25,
		MinWaves = 1,
		MaxWaves = 3,
		BaseDifficulty = 325,
		DepthDifficultyRamp = 105,
		MaxEliteTypes = 3,
		MoneyDropCapMin = 35,
		MoneyDropCapMax = 45,
		MoneyDropCapDepthRamp = 0,

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 30,
			MaxTypesCap = 4,
			ActiveEnemyCapDepthRamp = 0.60
			--EnemySet = EnemySets.BiomeI,
			--MaxEliteTypes = 5,
		},
	},

	GeneratedIChronosIntro =
	{
		InheritFrom = { "GeneratedI" },

		RequireNotRoomReward = { },
		DifficultyModifier = 85,

		AlwaysForce = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "==",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ClockworkIntro" },
			},
		},

		PreSpawnEnemies = false,

		SpeakerNames = { "Intercom", },
		ThreadedEvents =
		{
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				FunctionName = "HadesSpeakingPresentation",
				Args = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = { GlobalVoiceLines = "ChronosAlertVoiceLines" }, StartSound = "/SFX/TimeSlowStart", UseSurvivalPresentation = true, StartDelay = 1.0 },
			},
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				FunctionName = "HadesSpeakingPresentation",
				Args = { LineHistoryName = "NPC_LordHades_01", SubtitleColor = Color.HadesVoice, BlockColorGrade = true, OverlayAnim = "HadesOverlay", VoiceLines = { GlobalVoiceLines = "ChronosAlertVoiceLines" }, StartSound = "/SFX/SurvivalChallengeStart", UseSurvivalPresentation = true, StartDelay = 1.0 },
			},
		},

		UnthreadedEvents = ConcatTableValues(
		{
			{
				FunctionName = "GenericPresentation",
				Args = { PreWait = 2.2 },
			},
		},
		EncounterSets.EncounterEventsDefault),
	},

	GeneratedI_GoalReward =
	{
		InheritFrom = { "GeneratedI" },

		RequireAnyRoomReward = { "ClockworkGoal" },
		RequireNotRoomReward = { },

		BaseDifficulty = 250,
		DepthDifficultyRamp = 105,
		MaxEliteTypes = 3,
		EnemySet = EnemySets.BiomeI,
	},

	GeneratedI_Small =
	{
		InheritFrom = { "GeneratedI" },

		EnemySet = EnemySets.BiomeIOptional,

		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMax = 5,
		ActiveEnemyCapDepthRamp = 0,
		MinWaves = 2,
		MaxWaves = 3,
		DifficultyMultiplier = 0.85,
		MaxTypesCap = 2,
	},

	GeneratedI_Small_GoalReward =
	{
		InheritFrom = { "GeneratedI" },

		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMax = 5,
		ActiveEnemyCapDepthRamp = 0,
		MinWaves = 2,
		MaxWaves = 3,

		MaxTypesCap = 2,

		RequireAnyRoomReward = { "ClockworkGoal" },
		RequireNotRoomReward = { },

		DifficultyMultiplier = 0.85,
		EnemySet = EnemySets.BiomeI,
	},

	GeneratedI_SmallChronosIntro =
	{
		InheritFrom = { "GeneratedI_Small" },

		RequireNotRoomReward = { },

		AlwaysForce = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "==",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ClockworkIntro" },
			},
		},

		PreSpawnEnemies = false,

		SpeakerNames = { "Intercom", },
		ThreadedEvents =
		{
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				FunctionName = "HadesSpeakingPresentation",
				Args = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = { GlobalVoiceLines = "ChronosAlertVoiceLines" }, StartSound = "/SFX/TimeSlowStart", UseSurvivalPresentation = true, StartDelay = 1.0 },
			},
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				FunctionName = "HadesSpeakingPresentation",
				Args = { LineHistoryName = "NPC_LordHades_01", SubtitleColor = Color.HadesVoice, BlockColorGrade = true, OverlayAnim = "HadesOverlay", VoiceLines = { GlobalVoiceLines = "ChronosAlertVoiceLines" }, StartSound = "/SFX/SurvivalChallengeStart", UseSurvivalPresentation = true, StartDelay = 1.0 },
			},
		},

		UnthreadedEvents = ConcatTableValues(
		{
			{
				FunctionName = "GenericPresentation",
				Args = { PreWait = 3.0 },
			},
		},
		EncounterSets.EncounterEventsDefault),
	},

	GeneratedN =
	{
		InheritFrom = { "Generated" },
		CanEncounterSkip = true,
		BlockAthenaEncounterKeepsake = false,
		EnemySet = EnemySets.BiomeN,
		ActiveEnemyCapBase = 4.0,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 1,
		MinTypes = 2,
		MaxTypes = 2,
		MaxTypesCap = 3,
		TypeCountDepthRamp = 0.20,
		EscalateTypeCount = true,
		MinWaves = 1,
		MaxWaves = 2,
		--BaseDifficulty = 150,
		--DepthDifficultyRamp = 5,

		BaseDifficulty = 110,
		DepthDifficultyRamp = 25,
		UseEncounterDepth = true,
		UseEncounterDepthForTypes = true,

		MaxEliteTypes = 1,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 25,
		MoneyDropCapDepthRamp = 0,
	},

	GeneratedN_Smaller =
	{
		InheritFrom = { "GeneratedN" },
		MaxTypesCap = 2,
		BaseDifficulty = 85,
		DepthDifficultyRamp = 25,
	},

	GeneratedN_Bigger =
	{
		InheritFrom = { "GeneratedN" },
		BaseDifficulty = 135,
		MinWaves = 2,
		MaxWaves = 3,
		DepthDifficultyRamp = 25,
	},

	GeneratedNSubRoom =
	{
		InheritFrom = { "GeneratedN" },
		RequireCompletedIntro = true,
		ActiveEnemyCapBase = 2.0,
		ActiveEnemyCapMax = 4.0,
		ActiveEnemyCapDepthRamp = 0.45,
		MinTypes = 1,
		MaxTypes = 2,
		MinWaves = 1,
		MaxWaves = 1,
		TypeCountDepthRamp = 0,
		MaxTypesCap = 2,
		BaseDifficulty = 20,
		DepthDifficultyRamp = 5,
		
		BlockDionysusEncounterKeepsake = true,
		CountsForRoomEncounterDepth = false,

		MaxEliteTypes = 1,

		PreSpawnMinPlayerDistance = 0,

		PassiveRoomWeaponsChance = {},

		RequireNotRoomReward = RewardSets.SubroomEasyBans,

		Blacklist = { ZombieSpawner = true, ZombieSpawner_Elite = true },
	},

	GeneratedNSubRoom_Bigger =
	{
		InheritFrom = { "GeneratedNSubRoom" },
		ActiveEnemyCapBase = 3.0,
		ActiveEnemyCapMax = 5.0,
		ActiveEnemyCapDepthRamp = 0.45,
		MinTypes = 1,
		MaxTypes = 2,
		MinWaves = 1,
		MaxWaves = 1,
		TypeCountDepthRamp = 0,
		MaxTypesCap = 2,
		BaseDifficulty = 40,
		DepthDifficultyRamp = 5,

		MaxEliteTypes = 1,

		PreSpawnMinPlayerDistance = 0,

		PassiveRoomWeaponsChance = {},

		RequireNotRoomReward = RewardSets.SubroomHardBans,

		Blacklist = {  },
	},

	GeneratedO =
	{
		InheritFrom = { "Generated" },
		CanEncounterSkip = true,
		BlockAthenaEncounterKeepsake = false,
		PreSpawnEnemies = false,
		UnthreadedEvents = EncounterSets.EncounterEventsShipsCombat,
		EnemySet = EnemySets.BiomeO,
		SkipLastKillPresentation = true,

		DelayedStart = true,
		NeverDelayManaRegen = true,
		NeverDelaySpellCharge = true,

		SpawnAggroed = true,

		TwoRewardChoiceChance = 0.8,

		ActiveEnemyCapBase = 4.0,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 0.75,
		MinTypes = 1,
		MaxTypes = 2,
		MinWaves = 1,
		MaxWaves = 2,
		TypeCountDepthRamp = 0.35,
		EscalateTypeCount = true,
		MaxTypesCap = 2,
		BaseDifficulty = 115,
		DepthDifficultyRamp = 55,
		UseEncounterDepth = true,
		MaxEliteTypes = 2,
		MoneyDropCapMin = 20,
		MoneyDropCapMax = 30,
		MoneyDropCapDepthRamp = 0,

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 45,
			MaxTypesCap = 4,
			ActiveEnemyCapDepthRamp = 1.0
		},

		PostCombatAudioEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					SetSoundCueValues =
					{
						{
							Name = "Drums",
							Value = 0.0,
							AudioStateId = "MusicId",
							Duration = 0.75,
						},
					},
				},
			},
		},

		Using = { "ShipsBombardment" },
	},

	GeneratedO_Intro01 =
	{
		InheritFrom = { "GeneratedO" },
		EnemySet = EnemySets.BiomeOIntro,
		RequireCompletedIntro = true,
		
		CountsForRoomEncounterDepth = false,

		DelayedStart = false,
		
		BlockAthenaEncounterKeepsake = true,

		PreSpawnEnemies = true,
		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 2,
		MaxTypesCap = 2,
		BaseDifficulty = 50,
		DepthDifficultyRamp = 45,
		--DifficultyMultiplier = 0.5,
		
		EncounterRoomRewardOverride = "Empty",
		SkipShipsEncounterSetup = true,

		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "SpawnShipCaptainUnit", Args = { UnitOptions = { "ZombieCrewman" } },
			},
			{
				FunctionName = "HandleEncounterPreSpawns"
			}
		},

		PreSpawnSpawnOverrides =
		{
			WakeUpDelay = 3.0,
		},
	},

	GeneratedO_Intro01_First =
	{
		InheritFrom = { "GeneratedO_Intro01" },
		Generated = false,
		AlwaysForce = true,
		DifficultyModifier = 100,
		
		ActiveEnemyCapBase = 1.0,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "DeadSeaIntro" },
			},
		},

		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Swab",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
	},

	GeneratedP =
	{
		InheritFrom = { "Generated" },
		
		CanEncounterSkip = true,
		BlockAthenaEncounterKeepsake = false,
		CheckAthenaEncounterKeepsakeOnSkipEncounterStart = true,
		CanEncounterSkipIfNotFirst = false,
		UsePreviousStartTime = true,

		EnemySet = EnemySets.BiomeP,
		ActiveEnemyCapBase = 4.5,
		ActiveEnemyCapMax = 9, -- Lower to account for Eagle
		ActiveEnemyCapDepthRamp = 0.45,
		MinTypes = 1,
		MaxTypes = 2,
		MaxTypesCap = 3,
		MinWaves = 1,
		MaxWaves = 2,
		TypeCountDepthRamp = 0.33,
		BaseDifficulty = 430,
		DepthDifficultyRamp = 85,
		MaxEliteTypes = 3,
		MoneyDropCapMin = 25,
		MoneyDropCapMax = 35,
		MoneyDropCapDepthRamp = 0,

		PreSpawnEnemies = false,
		SpawnAggroed = true,

		MaxTypesPerGroup =
		{
			Automatons = 1,
			ChronosForces = 2,
		},

		--PrioritizeGroup = "Automatons",
		RandomPrioritizeGroup = { "Automatons", "ChronosForces" },
		PauseDurationAfterPriorityGroup = 1.0,

		WaveStartUnthreadedEvents =
		{
			{
				FunctionName = "OlympusEagleSpawn",
				GameStateRequirements =
				{
					ChanceToPlay = 0.33,
					{
						SumPrevRooms = 20,
						CountPathTrue = true,
						Path = { "OlympusEagleSpawn" },
						Comparison = "<=",
						Value = 0,
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "OlympusEagleSpawn" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "OlymplusIntro" },
					},
				},
			},
		},

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 50,
			MaxTypesCap = 3,
			ActiveEnemyCapDepthRamp = 0.60
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 10,
			},
		},
	},

	GeneratedP_Large =
	{
		InheritFrom = { "GeneratedP" },

		MinWaves = 3,
		MaxWaves = 3,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 9,
			},
		},
	},

	GeneratedP_PreCombat =
	{
		InheritFrom = { "GeneratedP" },
		CanEncounterSkip = true,
		BlockAthenaEncounterKeepsake = true,
		EnemySet = EnemySets.BiomePIntro,
		RequireCompletedIntro = true,
		SkipEndEncounterEffects = true,
		SkipLastKillPresentation = true,
		CountsForRoomEncounterDepth = false,
		BlockNextBiomeEnemyShrineUpgrade = true,

		DelayedStart = false,
		SkipOnAllEnemiesDeadCleanup = true,

		PreSpawnEnemies = true,
		SpawnAggroed = false,
		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 2,
		MaxTypes = 2,
		MaxTypesCap = 2,
		BaseDifficultyMin = 340,
		BaseDifficultyMax = 500,
		DepthDifficultyRamp = 0,
		--DifficultyMultiplier = 0.5,
		
		EncounterRoomRewardOverride = "Empty",

		AggroRemainingEnemiesOnWaveStart = false,

		MaxTypesPerGroup =
		{
			Automatons = 1,
			ChronosForces = 1,
		},

		RandomizeAmbientBattleDamagePerGroup =
		{
			GroupNames = { "Automatons", "ChronosForces" },
			BattleDamageDataOptions =
			{
				{ Min = 0.05, Max = 0.25 },
				{ Min = 0.8, Max = 0.9 },
			},
		},

		SpawnOverrides =
		{
			AIOptions = { "AmbientBattleAggroAI" },
			AmbientBattleAggroRange = 300,
			WakeUpDelay = 0.3,
			AggroReactionTimeMin = 0.15,
			AggroReactionTimeMax = 0.45,
		},

		SpawnDefaultAIDataOverrides =
		{
			
		},

		WaveStartUnthreadedEvents = {},

		GameStateRequirements = {},
	},

	GeneratedP_PreCombatAutomatons =
	{
		InheritFrom = { "GeneratedP_PreCombat" },
		EnemySet = EnemySets.Automatons,

		MaxTypesPerGroup = "nil",
		RandomizeAmbientBattleDamagePerGroup = "nil",
	},

	GeneratedP_PreCombatChronosForces =
	{
		InheritFrom = { "GeneratedP_PreCombat" },
		EnemySet = EnemySets.ChronosForces,

		MaxTypesPerGroup = "nil",
		RandomizeAmbientBattleDamagePerGroup = "nil",

		StartRoomUnthreadedEvents =
		{
			Append = true,
			{
				FunctionName = "SpawnOlympusCorpses",
				Args =
				{
					CountMin = 3,
					CountMax = 10,
					ObstacleOptions =
					{
						"OlympusCorpseAutomatonBeamerA",
						"OlympusCorpseAutomatonBeamerB",
						"OlympusCorpseAutomatonBeamerC",

						"OlympusCorpseAutomatonEnforcerA",
						"OlympusCorpseAutomatonEnforcerB",
						"OlympusCorpseAutomatonEnforcerC",

						"OlympusCorpseSentryBotA",
						"OlympusCorpseSentryBotA",
						"OlympusCorpseSentryBotB",
						"OlympusCorpseSentryBotB",
						"OlympusCorpseSentryBotC",
						"OlympusCorpseSentryBotC",
					}
				}
			}
		},
	},

	GeneratedQ =
	{
		InheritFrom = { "Generated" },

		CanEncounterSkip = true,
		BlockAthenaEncounterKeepsake = false,
		EnemySet = EnemySets.BiomeQ,
		ActiveEnemyCapBase = 3,
		ActiveEnemyCapMax = 7,
		ActiveEnemyCapDepthRamp = 0.25,
		MaxTypes = 2,
		MaxTypesCap = 2,
		TypeCountDepthRamp = 0.143,
		EscalateTypeCount = true,
		MinWaves = 1,
		MaxWaves = 1,
		BaseDifficulty = 150,
		DepthDifficultyRamp = 25,
		UseEncounterDepth = true,
		UseEncounterDepthForTypes = true,

		MaxEliteTypes = 2,
		MoneyDropCapMin = 60,
		MoneyDropCapMax = 85,
		MoneyDropCapDepthRamp = 0,

		ThreadedEvents =
		{
			{ FunctionName = "TyphonIncursion",
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "RoomCountCache", "Q_Intro" },
								Comparison = "<=",
								Value = 1,
							},
							{
								SumPrevRooms = 2,
								CountPathTrue = true,
								Path = { "TyphonIncursion" },
								Comparison = "==",
								Value = 0,
							},
						},
						{
							ChanceToPlay = 0.3,
							{
								SumPrevRooms = 2,
								CountPathTrue = true,
								Path = { "TyphonIncursion" },
								Comparison = "==",
								Value = 0,
							},
						},
					},
				},
				Args =
				{
					DelayMin = 2.0, DelayMax = 9.0,
					CameraMotion = true,
					IncursionOptions =
					{
						TyphonIncursionTailImpale = { SpawnGroup = "TyphonTailIncursion" },
						TyphonIncursionArmSlam = { SpawnGroup = "TyphonArmIncursion" },
						TyphonIncursionArmFlick = { SpawnGroup = "TyphonArmIncursion" },
					},
				},
			},
		}
	},

	GeneratedQ_Large =
	{
		InheritFrom = { "GeneratedQ" },

		ActiveEnemyCapDepthRamp = 0.5,
		ActiveEnemyCapBase = 6,

		BaseDifficulty = 525,
		DepthDifficultyRamp = 25,
	},

	GeneratedQ_Islands =
	{
		InheritFrom = { "GeneratedQ" },

		EnemySet = EnemySets.BiomeQIslands,
	},

})