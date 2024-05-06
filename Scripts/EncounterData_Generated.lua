OverwriteTableKeys( EncounterData,
{
	-- Generated Encounters

	-- NOTE(andrew): Generated base and GeneratedF moved to 
	-- EncounterData.lua for the Tech Test

	GeneratedFInvasion =
	{
		InheritFrom = { "GeneratedF" },

		UnthreadedEvents = EncounterSets.EncounterEventsInvasion,
		SpawnAggroed = true,
		RequireNearPlayerDistance = 600,
		PreSpawnEnemies = false,

		SpawnIntervalMin = 0.5,
		SpawnIntervalMax = 2.0,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 2,
		MaxTypes = 3,

		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Chronos_01" },
				Comparison = ">=",
				Value = 2,
			},
		},

		SpawnOverrides =
		{
			ActivateDuration = 0.5,
			--ActivateFx = "CerberusRockFall",
			CreateProjectileOnActivationFinished = "SkyInvaderTouchdown",
		},

		NoFirstWaveStartDelay = false,

		Blacklist = { FogEmitter = true },
	},

	GeneratedG =
	{
		InheritFrom = { "Generated" },
		EnemySet = EnemySets.BiomeG,
		ActiveEnemyCapBase = 1.0,
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

		DelayedStart = true,
		NeverDelayStartFamiliar = true,
		NeverDelayManaRegen = true,
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
				TriggerGroup = "GroundEnemies", WithinDistance = 650,
				VoiceLines = GlobalVoiceLines.FieldsPassiveEnemiesSpottedVoiceLines,
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
				VoiceLines = GlobalVoiceLines.FieldsEnemiesSpottedVoiceLines,
			}
		},		
	},

	GeneratedH_Treant2 =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedH", },

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
		MaxEliteTypes = 2,

		EndMusicOnCombatOver = 20,

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

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	GeneratedH_Screamer2 =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedH", },

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "GeneratedH_Screamer2" },
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
		MaxEliteTypes = 2,

		EndMusicOnCombatOver = 20,

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

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	GeneratedI =
	{
		InheritFrom = { "Generated" },

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
		BaseDifficulty = 375,
		DepthDifficultyRamp = 105,
		EnemySet = EnemySets.BiomeIOptional,
		MaxEliteTypes = 4,
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

		ThreadedEvents =
		{
			{
				FunctionName = "HadesSpeakingPresentation",
				Args = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = GlobalVoiceLines.ChronosAlertVoiceLines, StartSound = "/SFX/TimeSlowStart", UseSurvivalPresentation = true, StartDelay = 1.0 },
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
	},

	GeneratedI_Small_GoalReward =
	{
		InheritFrom = { "GeneratedI" },

		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMax = 5,
		ActiveEnemyCapDepthRamp = 0,
		MinWaves = 2,
		MaxWaves = 3,

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

		ThreadedEvents =
		{
			{
				FunctionName = "HadesSpeakingPresentation",
				Args = { SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = GlobalVoiceLines.ChronosAlertVoiceLines, StartSound = "/SFX/TimeSlowStart", UseSurvivalPresentation = true, StartDelay = 1.0 },
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
		PreSpawnEnemies = false,
		UnthreadedEvents = EncounterSets.EncounterEventsShipsCombat,
		EnemySet = EnemySets.BiomeO,
		SkipLastKillPresentation = true,

		DelayedStart = true,

		SpawnAggroed = true,

		TwoRewardChoiceChance = 0.8,

		ActiveEnemyCapBase = 4.0,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 0.45,
		MinTypes = 1,
		MaxTypes = 2,
		MinWaves = 1,
		MaxWaves = 2,
		TypeCountDepthRamp = 0.20,
		EscalateTypeCount = true,
		MaxTypesCap = 3,
		BaseDifficulty = 115,
		DepthDifficultyRamp = 35,
		UseEncounterDepth = true,
		MaxEliteTypes = 2,
		MoneyDropCapMin = 20,
		MoneyDropCapMax = 30,
		MoneyDropCapDepthRamp = 0,

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 30,
			MaxTypesCap = 4,
			ActiveEnemyCapDepthRamp = 0.60
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

		DelayedStart = false,

		PreSpawnEnemies = true,
		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 2,
		MaxTypesCap = 2,
		BaseDifficulty = 50,
		DepthDifficultyRamp = 30,
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
		BlockHighlightEncounter = true,
		EnemySet = EnemySets.BiomeP,
		ActiveEnemyCapBase = 5.0,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 0.45,
		MinTypes = 2,
		MaxTypes = 3,
		MinWaves = 1,
		TypeCountDepthRamp = 0.10,
		MaxTypesCap = 3,
		BaseDifficulty = 500,
		DepthDifficultyRamp = 50,
		MaxEliteTypes = 3,
		MoneyDropCapMin = 25,
		MoneyDropCapMax = 35,
		MoneyDropCapDepthRamp = 0,

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 50,
			MaxTypesCap = 4,
			ActiveEnemyCapDepthRamp = 0.60
		},
	},

})