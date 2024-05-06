OverwriteTableKeys( EncounterData,
{
	-- Intro Encounters

	-- NOTE(andrew): BaseIntroEncounter and anything that inherits from "GeneratedF"
	-- has been moved to EncounterData.lua for the Tech Test

	FishmanIntro =
	{
		AlwaysForce = true,
		DifficultyModifier = 120,
		
		ActiveEnemyCapBase = 5.0,
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
						CountMin = 1,
						CountMax = 1,
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
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},

		DistanceTriggers =
		{
			{
				Name = "FishmanMeleeSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.FishmanMelee.EnemyFirstEncounterVoiceLines,
			}
		},
	},

	FishSwarmerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedG" },
		DifficultyModifier = 20,
		MinWaves = 3,
		MaxWaves = 3,

		ActiveEnemyCapBase = 2.0,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "FishSwarmerSquad",
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

		DistanceTriggers =
		{
			{
				Name = "FishSwarmerSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.FishSwarmer.EnemyFirstEncounterVoiceLines,
			}
		},
	},

	TurtleIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedG" },
		DifficultyModifier = 65,
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

		DistanceTriggers =
		{
			{
				Name = "TurtleSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.Turtle.EnemyFirstEncounterVoiceLines,
			}
		},
	},

	WaterUnitIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedG" },
		DifficultyModifier = 70,
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

		DistanceTriggers =
		{
			{
				Name = "WaterUnitSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.WaterUnit.EnemyFirstEncounterVoiceLines,
			}
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

		--[[
		DistanceTriggers =
		{
			{
				Name = "GuardSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.Guard.EnemyFirstEncounterVoiceLines,
			}
		},
		]]
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

		DistanceTriggers =
		{
			{
				Name = "LycanthropeSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 800,
				VoiceLines = EnemyData.Lycanthrope.EnemyFirstEncounterVoiceLines,
			}
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

		DistanceTriggers =
		{
			{
				Name = "MournerSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 800,
				VoiceLines = EnemyData.Mourner.EnemyFirstEncounterVoiceLines,
			}
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

		DistanceTriggers =
		{
			{
				Name = "LamiaSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 800,
				VoiceLines = EnemyData.Lamia.EnemyFirstEncounterVoiceLines,
			}
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

		DistanceTriggers =
		{
			{
				Name = "LovesickSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 800,
				VoiceLines = EnemyData.Lovesick.EnemyFirstEncounterVoiceLines,
			}
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

		DistanceTriggers =
		{
			{
				Name = "MudmanSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.Mudman.EnemyFirstEncounterVoiceLines,
			}
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

		DistanceTriggers =
		{
			{
				Name = "ZombieSpawnerSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.ZombieSpawner.EnemyFirstEncounterVoiceLines,
			}
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

		DistanceTriggers =
		{
			{
				Name = "ZombieHeavyRangedSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.ZombieHeavyRanged.EnemyFirstEncounterVoiceLines,
			}
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

		DistanceTriggers =
		{
			{
				Name = "ZombieAssassinSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.ZombieAssassin.EnemyFirstEncounterVoiceLines,
			}
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
		ActiveEnemyCapDepthRamp = 1.0,

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

		--[[
		DistanceTriggers =
		{
			{
				Name = "ScimiterrorSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.Scimiterror.EnemyFirstEncounterVoiceLines,
			}
		},
		]]--
	},

	HarpyCutterIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedO" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

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

		--[[
		DistanceTriggers =
		{
			{
				Name = "HarpyCutterSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.HarpyCutter.EnemyFirstEncounterVoiceLines,
			}
		},
		]]--
	},

	WaterElementalIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedO" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

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

		--[[
		DistanceTriggers =
		{
			{
				Name = "WaterEleSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.WaterElemental.EnemyFirstEncounterVoiceLines,
			}
		},
		]]--
	},

	DrunkIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedO" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

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

		--[[
		DistanceTriggers =
		{
			{
				Name = "DrunkSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.Drunk.EnemyFirstEncounterVoiceLines,
			}
		},
		]]--
	},

	Mage2Intro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedO" },
		DifficultyModifier = 80,
		MinWaves = 2,
		MaxWaves = 2,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

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

		--[[
		DistanceTriggers =
		{
			{
				Name = "Mage2SightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.Mage2.EnemyFirstEncounterVoiceLines,
			}
		},
		]]--
	},
})