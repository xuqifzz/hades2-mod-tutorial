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

		BlockFishingBeforeStart = true,
		BlockCodexBeforeStart = true,
		DelayedStart = true,
		SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		FastClearThreshold = 65,
		TimerBlock = "ThanatosEncounter",
		BlockHighlightEliteTypes = true,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsHeraclesCombat,
		TrackHeraclesMoneyObjective = true,

		BaseDifficulty = 250,
		DepthDifficultyRamp = 0,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 7,
		MinTypes = 3,
		MaxTypes = 4,
		MaxTypesCap = 4,
		MaxEliteTypes = 2,
		MinWaves = 4,
		MaxWaves = 4,
		Using = { "NPC_Heracles_01" },
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
})