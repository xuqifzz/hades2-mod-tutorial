OverwriteTableKeys( EncounterData,
{
	TimeChallenge =
	{
		EncounterType = "TimeChallenge",
		GroupReinforcements = false,
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		ExitsDontRequireCompleted = true,
		UnthreadedEvents = EncounterSets.EncounterEventsTimeChallenge,

		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,

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
		DecayStartDelay = 8.0,

		SpawnRadius = 1000,
		DifficultyModifier = 0,
		DepthDifficultyRamp = 0,

		RequireCompletedIntro = true,
		IgnoreSpawnPreferences = true,
		PreSpawnMinPlayerDistance = 0,

		TimedSpawnsVictoryText = "TimedChallenge_Victory",
		TimedSpawnsFailureText = "TimedChallenge_Failure",
	},

	TimeChallengeF =
	{
		InheritFrom = { "TimeChallenge", "GeneratedF" },
		BaseDifficulty = 130,
	},

	TimeChallengeG =
	{
		InheritFrom = { "TimeChallenge", "GeneratedG" },
		BaseDifficulty = 240,
	},

	TimeChallengeH =
	{
		InheritFrom = { "TimeChallenge", "GeneratedH" },
		--BaseDifficulty = 250,

		MinTypes = 2,
		MaxTypes = 3,
		MaxTypesCap = 3,
		TypeCountDepthRamp = 0,
		MinWaves = 1,
		MaxWaves = 1,

		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMin = 6,
		ActiveEnemyCapMax = 6,
	},

	TimeChallengeI =
	{
		InheritFrom = { "TimeChallenge", "GeneratedI" },
		MinTypes = 2,
		MaxTypes = 3,
		MaxTypesCap = 3,
		TypeCountDepthRamp = 0,
		BaseDifficulty = 380,
		DepthDifficultyRamp = 10,
		MinWaves = 1,
		MaxWaves = 1,
		MaxEliteTypes = 2,
	},

	TimeChallengeN =
	{
		InheritFrom = { "TimeChallenge", "GeneratedN" },
		BaseDifficulty = 150,
	},

	TimeChallengeO =
	{
		InheritFrom = { "TimeChallenge", "GeneratedO" },
		BaseDifficulty = 300,
	},

	TimeChallengeP =
	{
		InheritFrom = { "TimeChallenge", "GeneratedP" },
		BaseDifficulty = 400,
	},
})