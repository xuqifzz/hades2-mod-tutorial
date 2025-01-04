OverwriteTableKeys( EncounterData,
{
	BaseHeraclesCombat =
	{
		ObjectiveSets = "HeraclesChallenge",
		RequiredKillFunctionName = "TrackHeraclesChallengeProgress",
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
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			NamedRequirements = { "NoRecentHeraclesEncounter", "NoRecentFieldNPCEncounter" },
		},

		RequireNotRoomReward = { "Devotion" },

		BlockAthenaEncounterKeepsake = true,

		BlockCodexBeforeStart = true,
		DelayedStart = true,
		SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		FastClearThreshold = 65,
		TimerBlock = "ThanatosEncounter",
		BlockHighlightEliteTypes = true,

		CanEncounterSkip = false,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsHeraclesCombat,
		TrackHeraclesMoneyObjective = true,

		BaseDifficulty = 220,
		DepthDifficultyRamp = 0,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 7,
		MinTypes = 3,
		MaxTypes = 4,
		MaxTypesCap = 4,
		MaxEliteTypes = 2,
		MinWaves = 3,
		MaxWaves = 3,
		Using = { "NPC_Heracles_01" },
		SpeakerNames = { "Heracles", "HeraclesField", },
	},

	HeraclesCombatN =
	{
		InheritFrom = { "BaseHeraclesCombat", "GeneratedN" },

		MoneyDropCapMin = 80,
		MoneyDropCapMax = 130,

		HeraclesDummyUnitSet = EnemySets.HeraclesDummyUnitsN,
	},

	HeraclesCombatN2 =
	{
		InheritFrom = { "HeraclesCombatN" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 4,
				Path = { "SpawnRecord", "NPC_Heracles_01" },
				Comparison = "<=",
				Value = 0,
			},
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

		MoneyDropCapMin = 80,
		MoneyDropCapMax = 130,
		HeraclesDummyUnitSet = EnemySets.HeraclesDummyUnitsO,

		StartRoomThreadedEvents =
		{
			{ FunctionName = "HandleHeraclesSpawn" },
		},
		HeraclesSpawnWait = 1.0,

		DifficultyModifier = 130,
		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMax = 8,

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
				Path = { "SpawnRecord", "NPC_Heracles_01" },
				Comparison = "<=",
				Value = 0,
			},
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
				Path = { "SpawnRecord", "NPC_Heracles_01" },
				Comparison = "<=",
				Value = 0,
			},
		},
	},
})