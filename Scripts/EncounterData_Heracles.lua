OverwriteTableKeys( EncounterData,
{
	BaseHeraclesCombat =
	{
		RequiredKillFunctionName = "TrackHeraclesChallengeProgress",
		OnSpawnFunctionName = "CheckHeraclesBounty",
		ObjectiveSets = "HeraclesChallenge",
		HeraclesBountyPerWaveMin = 2,
		HeraclesBountyPerWaveMax = 3,
		HeraclesBountyValue = 20,
		HeraclesBountyAttachedAnimation = "HeraclesBountyStatus",

		GameStateRequirements =
		{
			-- rule 1: have x or fewer of these encounters
			{
				Path = { "CurrentRun", "EncountersCompletedCache" },
				SumOf = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
				Comparison = "<=",
				Value = 0,
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "HeraclesCombatIntro" },
			},
			NamedRequirements = { "NoRecentHeraclesEncounter", "NoRecentFieldNPCEncounter" },
			NamedRequirementsFalse = { "StandardPackageBountyActive" },
		},

		RequireNotRoomReward = { "Devotion" },

		BlockAthenaEncounterKeepsake = true,

		BlockCodexBeforeStart = true,
		DelayedStart = true,
		SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		TimerBlock = "ThanatosEncounter",
		BlockHighlightEliteTypes = true,

		CanEncounterSkip = false,

		MinTypes = 2,
		MaxTypes = 3,
		MaxTypesCap = 3,
		MaxEliteTypes = 1,

		ActiveEnemyCapMax = 7, -- Give Heracles bone budget room.

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsHeraclesCombat,

		Using = { SpawnUnit = "NPC_Heracles_01", Animation = "HydraTouchdownGroundCracksFade" },
		SpeakerNames = { "Heracles", },
		LoadPackages = { "Heracles" },
	},

	HeraclesCombatN =
	{
		InheritFrom = { "BaseHeraclesCombat", "GeneratedN" },

		DifficultyModifier = 150,
		MinWaves = 3,
		MaxWaves = 3,

		HeraclesDummyUnitSet = EnemySets.HeraclesDummyUnitsN,
	},

	HeraclesCombatN2 =
	{
		InheritFrom = { "HeraclesCombatN" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 8,
				Path = { "EncountersOccurredCache" },
				TableValuesToCount = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
				Comparison = "<=",
				Value = 0,
			},
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "Shrine" },
			}
		},
	},

	HeraclesCombatIntro =
	{
		InheritFrom = { "HeraclesCombatN" },

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "HeraclesCombatIntro" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
			},
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "HeraclesFirstMeeting", "MedeaFirstMeeting" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},
	},

	HeraclesCombatO =
	{
		InheritFrom = { "BaseHeraclesCombat", "GeneratedO" },
		RequireCompletedIntro = true,

		UnthreadedEvents = EncounterSets.EncounterEventsHeraclesCombatO,
		SkipHeraclesSpawnPresentation = true,
		SkipShipsEncounterSetup = true,

		HeraclesDummyUnitSet = EnemySets.HeraclesDummyUnitsO,

		StartRoomThreadedEvents =
		{
			{ FunctionName = "HandleHeraclesSpawn" },
		},
		HeraclesSpawnWait = 1.0,

		DifficultyModifier = 155,
		MinWaves = 3,
		MaxWaves = 3,

		GameStateRequirements =
		{
			Append = true,
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "DeadSeaIntro" },
			},
			{
				Path = { "GameState", "UseRecord", "NPC_Heracles_01" },
				Comparison = ">=",
				Value = 4,
			},
		},
	},

	HeraclesCombatO2 =
	{
		InheritFrom = { "HeraclesCombatO" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 4,
				Path = { "EncountersOccurredCache" },
				TableValuesToCount = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
				Comparison = "<=",
				Value = 0,
			},
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "Shrine" },
			}
		},
	},	

	HeraclesCombatP =
	{
		InheritFrom = { "BaseHeraclesCombat", "GeneratedP" },

		BlockMultipleEncounters = true,

		RequireRoomTag = "Indoor",

		MoneyDropCapMin = 100,
		MoneyDropCapMax = 145,

		MinTypes = 4,
		MaxTypes = 4,
		MaxTypesCap = 4,
		MinWaves = 3,
		MaxWaves = 3,
		TypeCountDepthRamp = 0,
		BaseDifficulty = 600,
		DepthDifficultyRamp = 50,
		MaxEliteTypes = 3,

		HeraclesDummyUnitSet = EnemySets.BiomeP,

		GameStateRequirements =
		{
			Append = true,
			{
				Path = { "GameState", "UseRecord", "NPC_Heracles_01" },
				Comparison = ">=",
				Value = 5,
			},
			{
				Path = { "GameState", "EncountersOccurredCache" },
				HasAny = { "HeraclesCombatO", "HeraclesCombatO2" }
			},
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "AthenaFirstMeeting" }
			},
		},	
	},

	HeraclesCombatP2 =
	{
		InheritFrom = { "HeraclesCombatP" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 4,
				Path = { "EncountersOccurredCache" },
				TableValuesToCount = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
				Comparison = "<=",
				Value = 0,
			},
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "Shrine" },
			}
		},
	},
})