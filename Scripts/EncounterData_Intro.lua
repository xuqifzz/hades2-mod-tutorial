OverwriteTableKeys( EncounterData,
{
	-- Intro Encounters

	-- NOTE(andrew): BaseIntroEncounter and anything that inherits from "GeneratedF"
	-- has been moved to EncounterData.lua for the Tech Test

	FishmanIntro =
	{
		AlwaysForce = true,
		DifficultyModifier = 120,
		
		ActiveEnemyCapBase = 6.0,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "FishmanIntro" },
			},
		},

		UnthreadedEvents = EncounterSets.EncounterEventsDefault,
		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "FishmanMelee",
						CountMin = 1,
						CountMax = 1,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "FishmanMelee",
						CountMin = 2,
						CountMax = 2,
					},
					{
						Name = "FishmanRanged",
						CountMin = 1,
						CountMax = 1,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "FishmanMelee",
						CountMin = 3,
						CountMax = 3,
					},
					{
						Name = "FishmanRanged",
						CountMin = 3,
						CountMax = 3,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
	},

	FishSwarmerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedG" },
		DifficultyModifier = 45,
		MinWaves = 2,
		MaxWaves = 2,

		ActiveEnemyCapBase = 5.0,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "FishSwarmerSquad",
						CountMin = 4,
						CountMax = 4,
					},
				},
				StartDelay = 0
			},
		},


		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "FishSwarmerSquad",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues =
			{
				SpawnIntervalMin = 0.175,
				SpawnIntervalMax = 0.225,
				RequireNearPlayerDistance = 750,
				SpawnAggroed = true,
				IgnoreSpawnPreferences = true,
			},
			RequireCompletedIntro = true,
		},
	},

	TurtleIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedG" },
		DifficultyModifier = 65,
		MinWaves = 3,
		MaxWaves = 3,
		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Turtle",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},


		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Turtle",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	WaterUnitIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedG" },
		DifficultyModifier = 45,
		MinWaves = 3,
		MaxWaves = 3,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "WaterUnit",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "WaterUnit",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},


	VampireIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedH" },

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "VampireIntro" },
			},

			{
				PathTrue = { "GameState", "EncountersOccurredCache", "MournerIntro" },
			},

			{
				PathTrue = { "GameState", "EncountersOccurredCache", "LovesickIntro" },
			},

			{
				PathTrue = { "GameState", "EncountersOccurredCache", "LamiaIntro" },
			},
		},

		PreSpawnEnemies = false,
		UnthreadedEvents = EncounterSets.EncounterEventsH,
		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMax = 5,
		MinWaves = 3,
		MaxWaves = 3,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Vampire",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Vampire",
						CountMin = 1,
						CountMax = 1,
					},
					{
						Name = "BrokenHearted",
						CountMin = 7,
						CountMax = 7,
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
					Name = "Vampire",
					Generated = true
				}
			},
			StartDelay = 0,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	LycanthropeIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedH" },

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "LycanthropeIntro" },
			},

			{
				PathTrue = { "GameState", "EncountersOccurredCache", "MournerIntro" },
			},

			{
				PathTrue = { "GameState", "EncountersOccurredCache", "LovesickIntro" },
			},

			{
				PathTrue = { "GameState", "EncountersOccurredCache", "LamiaIntro" },
			},
		},

		PreSpawnEnemies = false,
		UnthreadedEvents = EncounterSets.EncounterEventsH,
		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMax = 5,
		MinWaves = 3,
		MaxWaves = 3,
		DifficultyModifier = 150,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Lycanthrope",
						CountMin = 1,
						CountMax = 1,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Lycanthrope",
						CountMin = 3,
						CountMax = 3,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Lycanthrope_Elite",
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
					Name = "Lycanthrope",
					Generated = true
				}
			},
			StartDelay = 0,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	MournerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedH" },

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "MournerIntro" },
			},
		},

		PreSpawnEnemies = false,
		UnthreadedEvents = EncounterSets.EncounterEventsH,
		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMax = 5,
		MinWaves = 3,
		MaxWaves = 3,
		DifficultyModifier = 150,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Mourner",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Mourner",
						CountMin = 4,
						CountMax = 4,
					},
					{
						Name = "BrokenHearted",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Mourner_Elite",
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
					Name = "Mourner",
					Generated = true
				}
			},
			StartDelay = 0,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	LamiaIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedH" },

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "LamiaIntro" },
			},
		},

		PreSpawnEnemies = false,
		UnthreadedEvents = EncounterSets.EncounterEventsH,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMax = 6,
		MinWaves = 3,
		MaxWaves = 3,
		DifficultyModifier = 200,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Lamia",
						CountMin = 1,
						CountMax = 1,
					},
					{
						Name = "BrokenHearted",
						CountMin = 4,
						CountMax = 4,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Lamia",
						CountMin = 4,
						CountMax = 4,
					},
					{
						Name = "BrokenHearted",
						CountMin = 6,
						CountMax = 6,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Lamia_Elite",
						CountMin = 1,
						CountMax = 1,
					},
					{
						Name = "BrokenHearted",
						CountMin = 4,
						CountMax = 4,
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
					Name = "Lamia",
					Generated = true
				}
			},
			StartDelay = 0,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	LovesickIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedH" },

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "LovesickIntro" },
			},
		},
		
		PreSpawnEnemies = false,
		UnthreadedEvents = EncounterSets.EncounterEventsH,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMax = 6,
		MinWaves = 3,
		MaxWaves = 3,
		DifficultyModifier = 150,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Lovesick",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Lovesick",
						CountMin = 4,
						CountMax = 4,
					},
					{
						Name = "BrokenHearted",
						CountMin = 5,
						CountMax = 5,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Lovesick_Elite",
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
					Name = "Lovesick",
					Generated = true
				}
			},
			StartDelay = 0,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	MudmanIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedN" },
		DifficultyModifier = 60,
		MinWaves = 3,
		MaxWaves = 3,
		ActiveEnemyCapBase = 5,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Mudman",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Mudman",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},		
	},

	ZombieSpawnerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedN" },
		DifficultyModifier = 50,
		MinWaves = 3,
		MaxWaves = 3,
		ActiveEnemyCapBase = 7,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieSpawner",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "ZombieSpawner",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	ZombieHeavyRangedIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedN" },
		DifficultyModifier = 40,
		MinWaves = 3,
		MaxWaves = 3,
		ActiveEnemyCapBase = 6,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieHeavyRanged",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "ZombieHeavyRanged",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	ZombieAssassinIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedN" },
		DifficultyModifier = 40,
		MinWaves = 3,
		MaxWaves = 3,
		ActiveEnemyCapBase = 7,
		ActiveEnemyCapMax = 7,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieAssassin",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "ZombieAssassin",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	ScimiterrorIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedO" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.5,

		PreSpawnEnemies = false,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Scimiterror",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Scimiterror",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	HarpyCutterIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedO" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.5,

		PreSpawnEnemies = false,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "HarpyCutter",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "HarpyCutter",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	WaterElementalIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedO" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.5,

		PreSpawnEnemies = false,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "WaterElemental",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "WaterElemental",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	DrunkIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedO" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.5,

		PreSpawnEnemies = false,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Drunk",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},


		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Drunk",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	Mage2Intro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedO" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.5,

		PreSpawnEnemies = false,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Mage2",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Mage2",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	DragonIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedP" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		WaveStartUnthreadedEvents = {},

		PreSpawnEnemies = false,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Dragon",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Dragon",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	SapperIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedP" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		WaveStartUnthreadedEvents = {},

		PreSpawnEnemies = false,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "SatyrSapper",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	AutomatonBeamerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedP" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		WaveStartUnthreadedEvents = {},

		PreSpawnEnemies = false,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "AutomatonBeamer",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "AutomatonBeamer",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		DistanceTriggers =
		{
			{
				Name = "OlympusAutomatonSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = { GlobalVoiceLines = "AutomatonReactionLines" },
			}
		},
	},

	AutomatonEnforcerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedP" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		WaveStartUnthreadedEvents = {},

		PreSpawnEnemies = false,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "AutomatonEnforcer",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "AutomatonEnforcer",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		DistanceTriggers =
		{
			{
				Name = "OlympusAutomatonSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = { GlobalVoiceLines = "AutomatonReactionLines" },
			}
		},
	},

	MatiIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedQ" },
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		WaveStartUnthreadedEvents = {},

		PreSpawnEnemies = true,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Mati",
						CountMin = 2,
						CountMax = 2,
					},
					{
						Name = "Stalker",
						CountMin = 1,
						CountMax = 1,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Mati_Elite",
						CountMin = 2,
						CountMax = 2,
					},
					{
						Name = "Stalker",
						CountMin = 1,
						CountMax = 1,
					},
				},
				StartDelay = 0
			},
		},
	},

	BruteIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedQ" },
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		WaveStartUnthreadedEvents = {},

		PreSpawnEnemies = true,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Brute",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Brute_Elite",
						CountMin = 1,
						CountMax = 1,
					},
				},
				StartDelay = 0
			},
		},
	},

	StalkerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedQ" },
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		WaveStartUnthreadedEvents = {},

		PreSpawnEnemies = true,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Stalker",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Stalker_Elite",
						CountMin = 1,
						CountMax = 1,
					},
				},
				StartDelay = 0
			},
		},
	},

	OlympusIntro =
	{
		InheritFrom = { "GeneratedP_PreCombat" },
		AlwaysForce = true,

		EncounterRoomRewardOverride = "nil",
		
		ActiveEnemyCapBase = 10.0,
		ActiveEnemyCapMax = 10.0,
		ActiveEnemyCapDepthRamp = 1.0,

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "OlympusIntro" },
			},
		},

		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,

		RandomizeAmbientBattleDamagePerGroup =
		{
			GroupNames = { "ChronosForces" },
			BattleDamageDataOptions =
			{
				{ Min = 0.05, Max = 0.5 },
			},
		},
		SpawnOverrides = {},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "AutomatonEnforcer",
						TotalCount = 1,
						SpawnOnIds = { 763025, },
						SpawnOverrides = { AIOptions = { "AmbientBattleAggroAI" }, },
						ForceFirst = true,
					},
					{
						Name = "SentryBot",
						TotalCount = 3,
						SpawnOnIds = { 763068, 763069, 763070, },
						SpawnOverrides = { AIOptions = { "AmbientBattleAggroAI" }, },
						ForceFirst = true,
					},
					{
						Name = "AutomatonBeamer",
						TotalCount = 1,
						SpawnOnIds = { 763079, },
						SpawnOverrides = { AIOptions = { "AmbientBattleAggroAI" }, },
						ForceFirst = true,
					},
					{
						Name = "ZombieOlympus",
						TotalCount = 25,
						SpawnDefaultAIDataOverrides = { TeleportToBattleFoeChance = 0.0 },
						SpawnOnIds = { 763053, 763054, 763056, 763065, 763044, 763041, 763042, 763039, 763082, 763084, 763086, 763064, 763046, 763033, 763031, },
						SpawnOverrides = { AIOptions = { "AmbientBattleAggroAI" }, PreferredSpawnPoint = "EnemyPointRanged", },
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						TotalCount = 1,
						SpawnOverrides = { SpawnAggroed = true },
					},
					{
						Name = "ZombieOlympus",
						TotalCount = 6,
						SpawnOverrides = { SpawnAggroed = true },
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "SentryBot",
						TotalCount = 5,
						SpawnOverrides = { SpawnAggroed = true },
					},
					{
						Name = "AutomatonEnforcer",
						TotalCount = 2,
						SpawnOverrides = { SpawnAggroed = true },
					},

				},
				StartDelay = 0,
				EnableRoomTraps = true,
				StartGlobalVoiceLines = "AutomatonAttackReactionLines",
			},
		},

		ManualWaveTemplates = {},
	},

	TyphonIntro =
	{
		InheritFrom = { "GeneratedQ" },
		AlwaysForce = true,
		SkipIntroEncounterCheck = true,
		PreSpawnEnemies = false,
		ThreadedEvents = {},

		ActiveEnemyCapBase = 3,
		ActiveEnemyCapMax = 3,

		MinWaves = 2,
		MaxWaves = 2,

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "TyphonIntro" },
			},
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Stalker",
						TotalCount = 2,
					},
					{
						Name = "SimpleSquad",
						TotalCount = 1,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "SimpleSquad",
						TotalCount = 2,
					},
					{
						Name = "Stalker",
						TotalCount = 3,
					},
				},
				StartDelay = 0
			},
		},


		ManualWaveTemplates = {},
	},
})