OverwriteTableKeys( EncounterData,
{
	-- Devotion Encounters
	BaseDevotion =
	{
		DifficultyModifier = 0,
		DepthDifficultyRamp = 0,
		BaseDifficulty = 140,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		SpawnAggroed = true,
		RequireNearPlayerDistance = 750,
		IgnoreSpawnPreferences = true,
		SpawnIntervalMin = 1.0,
		SpawnIntervalMax = 2.0,
		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0,
		TypeCountDepthRamp = 0,
		MinTypes = 3,
		MaxTypes = 4,
		MaxTypesCap = 4,
		MinWaves = 1,
		MaxWaves = 1,
		MoneyDropCapMin = 20,
		MoneyDropCapMax = 30,
		MoneyDropCapDepthRamp = 0,

		SkipIntroEncounterCheck = true,
		EncounterType = "Devotion",
		DelayedStart = true,

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "DisableRoomTraps" },
		},

		WaveTemplate =
		{
			Spawns =
			{

			},
			StartDelay = 1.0
		},
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,
		PreUnthreadedEvents =
		{
			{ FunctionName = "StartDevotionTest" },
			{
				FunctionName = "CheckAssistHint",
				Args =
				{
					Delay = 10.0,
				}
			},
		},

		RewardSpawnVoiceLines =
		{
			Cooldowns = { { Name = "LootDroppedSpeech", Time = 30 }, },
			-- Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SuccessiveChanceToPlayAll = 0.25,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestI", "DevotionTestN", "DevotionTestO", "DevotionTestP" },
					},
				},

				{ Cue = "/VO/Melinoe_1284", Text = "Satisfied?" },
				{ Cue = "/VO/Melinoe_1285", Text = "Let's all just take a breath.", PlayFirst = true },
			},	
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "LootPoint", WithinDistance = 700, GlobalVoiceLines = "DevotionChoicePresentedVoiceLines", FunctionName = "DevotionTestPresentation",
			},
			{
				TriggerGroup = "GroundEnemies", WithinDistance = 1000,
				VoiceLines =
				{
					UsePlayerSource = true,
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						SuccessiveChanceToPlayAll = 0.33,
						PreLineWait = 2.3,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
							}, 
							{
								Path = { "CurrentRun", "CurrentRoom", "RejectedLootData", "Gender" },
								IsAny = { "Female" },
							},
						},

						{ Cue = "/VO/Melinoe_1276", Text = "She's angry with me now..." },
						{ Cue = "/VO/Melinoe_1278", Text = "Now she's upset..." },
						{ Cue = "/VO/Melinoe_1280", Text = "I need to calm her down..." },
						{ Cue = "/VO/Melinoe_1282", Text = "She wants a fight, does she?" },
					},
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						SuccessiveChanceToPlayAll = 0.33,
						PreLineWait = 2.3,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
							},
							{
								Path = { "CurrentRun", "CurrentRoom", "RejectedLootData", "Gender" },
								IsAny = { "Male" },
							},
						},

						{ Cue = "/VO/Melinoe_1277", Text = "He's angry with me now..." },
						{ Cue = "/VO/Melinoe_1279", Text = "Now he's upset..." },
						{ Cue = "/VO/Melinoe_1281", Text = "I need to calm him down..." },
						{ Cue = "/VO/Melinoe_1283", Text = "He wants a fight, does he?" },
					},
				},
			},
		},
	},

	DevotionTestF =
	{
		InheritFrom = { "BaseDevotion", "GeneratedF" },
		--EnemySet = EnemySets.EnemiesBiome1Devotion,
		BaseDifficulty = 150,
		ActiveEnemyCapBase = 7,
		ActiveEnemyCapMax = 7,
	},

	DevotionTestG =
	{
		InheritFrom = { "BaseDevotion", "GeneratedG" },

		DifficultyModifier = 0,
		DepthDifficultyRamp = 0,
		
		MinTypes = 2,
		MaxTypes = 4,
		MinWaves = 2,
		MaxWaves = 3,
		MaxTypesCap = 3,
		BaseDifficulty = 200,
		MaxEliteTypes = 3,
	},

	DevotionTestH =
	{
		InheritFrom = { "BaseDevotion", "GeneratedH" },
	},

	DevotionTestI =
	{
		InheritFrom = { "BaseDevotion", "GeneratedI" },

		ActiveEnemyCapBase = 3.0,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 1.0,
		MinTypes = 2,
		MaxTypes = 3,
		MaxTypesCap = 3,
		MinWaves = 2,
		MaxWaves = 3,
		BaseDifficulty = 400,
		DepthDifficultyRamp = 110,
		EnemySet = EnemySets.BiomeIOptional,
		MaxEliteTypes = 4,
	},

	DevotionTestN =
	{
		InheritFrom = { "BaseDevotion", "GeneratedN" },

		MinTypes = 2,
		MaxTypes = 3,
		MaxTypesCap = 3,
		MinWaves = 2,
		MaxWaves = 3,
		BaseDifficulty = 100,
	},

	DevotionTestO =
	{
		InheritFrom = { "BaseDevotion", "GeneratedO" },
	},

	DevotionTestP =
	{
		InheritFrom = { "BaseDevotion", "GeneratedP" },
	},
})