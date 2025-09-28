HarvestData =
{
	DefaultSpawnChances =
	{
		0.20,
		--0.10,
		--0.05,
	},
	DefaultGameStateRequirements =
	{
		{
			SumPrevRooms = 3,
			Path = { "NumHarvestPoints" },
			Comparison = "<=",
			Value = 0,
		},
	},

	WeightedOptions =
	{
		-- Erebus
		{
			Weight = 15,
			Animation = "HarvestPointMoly",
			EmptyAnimation = "HarvestPointMolyUsed",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "F", },
				},
			},
			AddResources =
			{
				PlantFMoly = 1,
			},
		},

		-- Oceanus
		{
			Weight = 15,
			Animation = "HarvestPointPlantGLotus",
			EmptyAnimation = "HarvestPointPlantGLotusUsed",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "G", },
				},
			},
			AddResources =
			{
				PlantGLotus = 1,
			},
		},

		-- Fields
		{
			Weight = 15,
			Animation = "HarvestPointPlantHMyrtle",
			EmptyAnimation = "HarvestPointPlantHMyrtleUsed",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "H", },
				},
			},
			AddResources =
			{
				PlantHMyrtle = 1,
			},
		},

		-- Tartarus
		{
			Weight = 15,
			Animation = "HarvestPointPlantIShaderot",
			EmptyAnimation = "HarvestPointPlantIShaderotUsed",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "I", },
				},
			},
			AddResources =
			{
				PlantIShaderot = 1,
			},
		},

		-- Ephyra
		{
			Weight = 15,
			Animation = "HarvestPointPlantNMoss",
			EmptyAnimation = "HarvestPointPlantNMossUsed",
			HarvestedDrawGroup = "Terrain_Gameplay",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "N", "N_SubRooms" },
				},
			},
			AddResources =
			{
				PlantNMoss = 1,
			},
		},

		-- Ships
		{
			Weight = 15,
			Animation = "HarvestPointPlantODriftwood",
			EmptyAnimation = "HarvestPointPlantODriftwoodUsed",
			UseText = "UseHarvestPointDriftwood",
			DrawGroup = "Terrain_Gameplay",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "O", },
				},
			},
			AddResources =
			{
				PlantODriftwood = 1,
			},
		},

		-- Olympus
		{
			Weight = 15,
			Animation = "HarvestPointPlantPIris",
			EmptyAnimation = "HarvestPointPlantPIrisUsed",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "P", },
				},
			},
			AddResources =
			{
				PlantPIris = 1,
			},
		},

		-- Typhon
		{
			Weight = 15,
			Animation = "HarvestPointPlantQFang",
			EmptyAnimation = "HarvestPointPlantQFangUsed",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "Q", },
				},
			},
			AddResources =
			{
				PlantQFang = 1,
			},

			SpawnPropertyChanges =
			{
				{
					ThingProperty = "StopsUnits",
					ChangeValue = true,
				},
			},
		},

		-- Chaos
		{
			Weight = 15,
			ConsumableName = "Mixer6CommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord", },
					HasAny = { "ChaosGrantsDarkness01", "ChaosGrantsDarkness01_B" },
				},
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "Chaos", },
				},
			},
		},
	},
}

ShovelPointData =
{
	SpawnChance = 0.20,
	SpawnLimitPerBiome = 1,
	ToolName = "ToolShovel",
	RoomChanceName = "ShovelPointChance",
	HarvestPointName = "ShovelPoint",
	DefaultGameStateRequirements =
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		{
			SumPrevRooms = 4,
			Path = { "NumShovelPoints" },
			Comparison = "<=",
			Value = 0,
		},
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
		},
	},
	ShovelPointBonusDrops =
	{
		{
			PresentationFunctionName = "ShovelPointBombPresentation",
			ProjectileName = "ShovelPointBomb",
			Chance = 0.02,
		},
		{
			HealthDropName = "HealDropMinor",
			Chance = 0.15,
		},
	},
	WeightedOptions =
	{
		-- Erebus
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "F", },
				},
			},
			AddResources =
			{
				PlantFNightshadeSeed = 1,
			},
		},

		-- Oceanus
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "G", },
				},
			},
			AddResources =
			{
				PlantGCattailSeed = 1,
			},
		},

		-- Fields
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "H", },
				},
			},
			AddResources =
			{
				PlantHWheatSeed = 1,
			},
		},

		-- Tartarus
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "I", },
				},
			},
			AddResources =
			{
				PlantIPoppySeed = 1,
			},
		},

		-- Ephyra
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "N", "N_SubRooms", },
				},
			},
			AddResources =
			{
				PlantNGarlicSeed = 1,
			},
		},

		-- Ships
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "O", },
				},
			},
			AddResources =
			{
				PlantOMandrakeSeed = 1,
			},
		},

		-- Olympus
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "P", },
				},
			},
			AddResources =
			{
				PlantPOliveSeed = 1,
			},
		},

		-- Typhon
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "Q", },
				},
			},
			AddResources =
			{
				PlantQSnakereedSeed = 1,
			},
		},

		-- Chaos
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "Chaos", },
				},
			},
			AddResources =
			{
				PlantChaosThalamusSeed = 1,
			},
		},
	},
}

PickaxePointData =
{
	SpawnChance = 0.25,
	SpawnLimitPerBiome = 1,
	ToolName = "ToolPickaxe",
	RoomChanceName = "PickaxePointChance",
	HarvestPointName = "PickaxePoint",
	DefaultGameStateRequirements =
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		{
			SumPrevRooms = 4,
			Path = { "NumPickaxePoints" },
			Comparison = "<=",
			Value = 0,
		},
	},
	WeightedOptions =
	{
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreFSilver",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointSilverUnavailable",
			Animation = "PickaxePointSilver",
			EmptyAnimation = "PickaxePointSilverEmpty",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "F", },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreGLime",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreGLimeUnavailable",
			Animation = "PickaxePointOreGLime",
			EmptyAnimation = "PickaxePointOreGLimeEmpty",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "G", },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreHGlassrock",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreHGlassrockUnavailable",
			Animation = "PickaxePointOreHGlassrock",
			EmptyAnimation = "PickaxePointOreHGlassrockEmpty",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "H", },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreIMarble",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreIMarbleUnavailable",
			Animation = "PickaxePointOreIMarble",
			EmptyAnimation = "PickaxePointOreIMarbleEmpty",
			Geometry =
			{
				{ X = 35, Y = -11 },
				{ X = -2, Y = -19 },
				{ X = -33, Y = -10 },
				{ X = -41, Y = 4 },
				{ X = -31, Y = 21 },
				{ X = 2, Y = 27 },
				{ X = 28, Y = 23 },
				{ X = 38, Y = 7 }
			},
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "I", },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreNBronze",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointBronzeUnavailable",
			Animation = "PickaxePointBronze",
			EmptyAnimation = "PickaxePointBronzeEmpty",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "N", "N_SubRooms" },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreOIron",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreOIronUnavailable",
			Animation = "PickaxePointOreOIron",
			EmptyAnimation = "PickaxePointOreOIronEmpty",
			Geometry =
			{
				{ X = -100, Y = -20 },
				{ X = 95, Y = -56 },
				{ X = 32, Y = 50 },
			},
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "O" },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OrePAdamant",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOrePAdamantUnavailable",
			Animation = "PickaxePointOrePAdamant",
			EmptyAnimation = "PickaxePointOrePAdamantEmpty",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "P" },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreQScales",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreQScalesUnavailable",
			Animation = "PickaxePointOreQScales",
			EmptyAnimation = "PickaxePointOreQScalesEmpty",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "Q" },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 1,
			ResourceName = "OreChaosProtoplasm",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreChaosProtoplasmUnavailable",
			Animation = "PickaxePointOreChaosProtoplasm",
			EmptyAnimation = "PickaxePointOreChaosProtoplasmEmpty",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "Chaos" },
				},
			},
		},
	},
}

ExorcismData =
{
	SpawnChance = 0.15,
	SpawnLimitPerBiome = 1,
	ToolName = "ToolExorcismBook",
	RoomChanceName = "ExorcismPointChance",
	HarvestPointName = "ExorcismPoint",
	DefaultGameStateRequirements =
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">=",
			Value = 2,
		},
		{
			SumPrevRooms = 6,
			Path = { "NumExorcismPoints" },
			Comparison = "<=",
			Value = 0,
		},
		{
			SumPrevRooms = 1,
			Path = { "NumFishingPoints" },
			Comparison = "<=",
			Value = 0,
		},
		{
			Path = { "CurrentRun", "BiomeDepthCache" },
			Comparison = ">=",
			Value = 2,
		},
	},

	WeightedOptions =
	{
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "F" },
				},
			},
			Animation = "ShadeErebusIdle",
			AttemptsRemaining = 2,
			NumMovesMin = 4,
			NumMovesMax = 4,
			MoveDurationMin = 1.5,
			MoveDurationMax = 2.0,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 13,
			AddResources =
			{
				MemPointsCommon = 30,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "G" },
				},
			},
			Animation = "ShadeOceanusSIdle",
			AttemptsRemaining = 2,
			NumMovesMin = 5,
			NumMovesMax = 5,
			MoveDurationMin = 1.0,
			MoveDurationMax = 1.4,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 10,
			AddResources =
			{
				MemPointsCommon = 35,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "H" },
				},
			},
			Animation = "ShadeFieldsGreyIdle",
			AttemptsRemaining = 2,
			NumMovesMin = 6,
			NumMovesMax = 6,
			MoveDurationMin = 0.6,
			MoveDurationMax = 0.8,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 9,
			AddResources =
			{
				MemPointsCommon = 40,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "I" },
				},
			},
			Animation = "ShadeClockworkIdle",
			AttemptsRemaining = 2,
			NumMovesMin = 7,
			NumMovesMax = 7,
			MoveDurationMin = 0.345,
			MoveDurationMax = 0.460,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 8,
			AddResources =
			{
				MemPointsCommon = 50,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "N", "N_SubRooms" },
				},
			},
			Animation = "ShadeEphyraIdle",
			AttemptsRemaining = 2,
			NumMovesMin = 5,
			NumMovesMax = 5,
			MoveDurationMin = 0.8,
			MoveDurationMax = 1.0,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 10,
			AddResources =
			{
				MemPointsCommon = 35,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "O" },
				},
			},
			Animation = "ShadeShipsOneIdle",
			AttemptsRemaining = 2,
			NumMovesMin = 6,
			NumMovesMax = 6,
			MoveDurationMin = 0.6,
			MoveDurationMax = 0.8,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 9,
			AddResources =
			{
				MemPointsCommon = 40,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "P" },
				},
			},
			Animation = "ShadeTyphonIdle",
			AttemptsRemaining = 2,
			NumMovesMin = 7,
			NumMovesMax = 7,
			MoveDurationMin = 0.5,
			MoveDurationMax = 0.7,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 8,
			AddResources =
			{
				MemPointsCommon = 45,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "RoomSetName" },
					IsAny = { "Q" },
				},
			},
			Animation = "ShadeTyphonIdle",
			AttemptsRemaining = 2,
			NumMovesMin = 7,
			NumMovesMax = 7,
			MoveDurationMin = 0.5,
			MoveDurationMax = 0.7,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 8,
			AddResources =
			{
				MemPointsCommon = 45,
			}
		},
	},
}

FishingData =
{
	SpawnChance = 0.15,
	SpawnLimitPerBiome = 1,
	ToolName = "ToolFishingRod",
	RoomChanceName = "FishingPointChance",
	HarvestPointName = "FishingPoint",
	DefaultGameStateRequirements =
	{
		{
			SumPrevRooms = 5,
			Path = { "NumFishingPoints" },
			Comparison = "<=",
			Value = 0,
		},
		{
			SumPrevRooms = 1,
			Path = { "NumExorcismPoints" },
			Comparison = "<=",
			Value = 0,
		},
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
		},
	},

	FidgetInterval = { Min = 3, Max = 9 },

	Difficulty =
	{
		Default =
		{
			NumFakeDunks = { Min = 0, Max = 3 },
			FakeDunkInterval = { Min = 1, Max = 3 },
			WarnInterval = { Min = 1, Max = 2 },
			SuccessInterval = 0.68,
			WayLateInterval = 1,
			GiveUpInterval = 3,
		},

		Gifting =
		{
			NumFakeDunks = { Min = 2, Max = 6 },
			FakeDunkInterval = { Min = 1, Max = 5 },
			WarnInterval = { Min = 1, Max = 3 },
			SuccessInterval = 0.68,
			WayLateInterval = 1,
			GiveUpInterval = 3,
		},
	},

	BiomeFish =
	{
		Defaults =
		{

			{
				Weight = 1,
				Name = "FishFCommon",
			},
		},

		F =
		{
			{
				Weight = 3,
				Name = "FishFCommon",
			},
			{
				Weight = 2,
				Name = "FishFRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishFCommon" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 4,
				Name = "FishFRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishFCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishFRare" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishFLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishFRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 3,
				Name = "FishFLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishFRare" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishFLegendary" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
		},

		G =
		{
			{
				Weight = 3,
				Name = "FishGCommon",
			},
			{
				Weight = 2,
				Name = "FishGRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishGCommon" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 4,
				Name = "FishGRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishGCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishGRare" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishGLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishGRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 3,
				Name = "FishGLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishGRare" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishGLegendary" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
		},


		H =
		{
			{
				Weight = 3,
				Name = "FishHCommon",
			},
			{
				Weight = 2,
				Name = "FishHRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishHCommon" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 4,
				Name = "FishHRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishHCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishHRare" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishHLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishHRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 3,
				Name = "FishHLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishHRare" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishHLegendary" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
		},


		I =
		{
			{
				Weight = 3,
				Name = "FishICommon",
			},
			{
				Weight = 2,
				Name = "FishIRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishICommon" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 4,
				Name = "FishIRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishICommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishIRare" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishILegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishIRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 3,
				Name = "FishILegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishIRare" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishILegendary" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
		},

		N =
		{
			{
				Weight = 3,
				Name = "FishNCommon",
			},
			{
				Weight = 2,
				Name = "FishNRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishNCommon" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 4,
				Name = "FishNRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishNCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishNRare" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishNLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishNRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 3,
				Name = "FishNLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishNRare" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishNLegendary" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
		},


		O =
		{
			{
				Weight = 3,
				Name = "FishOCommon",
			},
			{
				Weight = 2,
				Name = "FishORare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishOCommon" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 4,
				Name = "FishORare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishOCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishORare" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishOLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishORare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 3,
				Name = "FishOLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishORare" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishOLegendary" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
		},


		P =
		{
			{
				Weight = 3,
				Name = "FishPCommon",
			},
			{
				Weight = 2,
				Name = "FishPRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishPCommon" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 4,
				Name = "FishPRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishPCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishPRare" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishPLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishPRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 3,
				Name = "FishPLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishPRare" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishPLegendary" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
		},

		Q =
		{
			{
				Weight = 3,
				Name = "FishQCommon",
			},
			{
				Weight = 2,
				Name = "FishQRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishQCommon" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 4,
				Name = "FishQRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishQCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishQRare" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishQLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishQRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 3,
				Name = "FishQLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishQRare" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishQLegendary" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
		},

		Chaos =
		{
			{
				Weight = 3,
				Name = "FishChaosCommon",
			},
			{
				Weight = 2,
				Name = "FishChaosRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishChaosCommon" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 4,
				Name = "FishChaosRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishChaosCommon" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishChaosRare" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
			{
				Weight = 1,
				Name = "FishChaosLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishChaosRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			{
				Weight = 3,
				Name = "FishChaosLegendary",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishChaosRare" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "FishChaosLegendary" },
						Comparison = "<",
						Value = 1,
					},
				},
			},
		},
	},

	FishValues =
	{
		BaseFish =
		{
			FishCaughtVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtVoiceLines" },
			},
			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Erebus
		FishFCommon =
		{
			InheritFrom = { "BaseFish" },
			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					AllowTalkOverTextLines = true,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/Melinoe_3527", Text = "I caught a Moper...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_3528", Text = "Another Moper.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishFCommon" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/Melinoe_3529", Text = "That's a Moper." },
					{ Cue = "/VO/Melinoe_3530", Text = "A Moper." },
					{ Cue = "/VO/Melinoe_3531", Text = "Cheer up, Moper." },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishFRare =
		{
			InheritFrom = { "BaseFish" },
			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					AllowTalkOverTextLines = true,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/Melinoe_3532", Text = "I caught a Figment...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_3533", Text = "It's a Figment!" },
					{ Cue = "/VO/Melinoe_3534", Text = "That's a Figment." },
					{ Cue = "/VO/Melinoe_3535", Text = "Looks like a Figment." },
					{ Cue = "/VO/Melinoe_3536", Text = "Another Figment.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishFRare" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishFLegendary=
		{
			InheritFrom = { "BaseFish" },
			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					AllowTalkOverTextLines = true,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/Melinoe_3537", Text = "I caught a Soulbelly?", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_3538", Text = "{#Emph}Ooh{#Prev}, a Soulbelly!" },
					{ Cue = "/VO/Melinoe_3539", Text = "It's a Soulbelly...!" },
					{ Cue = "/VO/Melinoe_3540", Text = "This is a Soulbelly!" },
					{ Cue = "/VO/Melinoe_3541", Text = "Soulbelly, I'm honored!" },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Oceanus
		FishGCommon =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2266", Text = "I caught a Chiton!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2267", Text = "It's a Chiton." },
					{ Cue = "/VO/MelinoeField_2268", Text = "Looks like a Chiton." },
					{ Cue = "/VO/MelinoeField_2269", Text = "Another Chiton.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishGCommon" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2270", Text = "Hey, a Chiton!" },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishGRare =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2641", Text = "I caught a Gutterpop...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2642", Text = "It's a Gutterpop." },
					{ Cue = "/VO/MelinoeField_2643", Text = "That's a Gutterpop." },
					{ Cue = "/VO/MelinoeField_2644", Text = "A Gutterpop." },
					{ Cue = "/VO/MelinoeField_2645", Text = "Hello, Gutterpop." },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishGLegendary=
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2276", Text = "This is a Stalkfin...!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2277", Text = "{#Emph}Ooh{#Prev}, a Stalkfin..." },
					{ Cue = "/VO/MelinoeField_2278", Text = "Another Stalkfin...?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishGLegendary" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2279", Text = "It's a Stalkfin!" },
					{ Cue = "/VO/MelinoeField_2280", Text = "Found you, Stalkfin!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Fields
		FishHCommon =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2281", Text = "I caught a Soby.", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2282", Text = "It's a Soby...", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2283", Text = "It's a little Soby..." },
					{ Cue = "/VO/MelinoeField_2284", Text = "Cheer up, Soby." },
					{ Cue = "/VO/MelinoeField_2285", Text = "Poor Soby..." },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishHRare =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2286", Text = "I caught an Anguish!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2287", Text = "This is an Anguish." },
					{ Cue = "/VO/MelinoeField_2288", Text = "It's an Anguish." },
					{ Cue = "/VO/MelinoeField_2289", Text = "It'll be OK, Anguish..." },
					{ Cue = "/VO/MelinoeField_2290", Text = "Come on, Anguish..." },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishHLegendary=
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2291", Text = "I caught a Tearjerker!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2292", Text = "It's a Tearjerker...!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2293", Text = "{#Emph}Ah{#Prev}, a Tearjerker!" },
					{ Cue = "/VO/MelinoeField_2294", Text = "{#Emph}<Sniff> {#Prev}A Tearjerker...!" },
					{ Cue = "/VO/MelinoeField_2295", Text = "{#Emph}<Sniff> {#Prev}Hi, Tearjerker...!" },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Clockwork Tartarus
		FishICommon =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2296", Text = "I caught a Jiffy!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2297", Text = "It's a Jiffy.", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2298", Text = "That's a Jiffy." },
					{ Cue = "/VO/MelinoeField_2299", Text = "Caught another Jiffy.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishICommon" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2300", Text = "Count me in, Jiffy." },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishIRare =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2301", Text = "I caught a Goldfish!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2302", Text = "It's a Goldfish.", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2303", Text = "Chronos must love these." },
					{ Cue = "/VO/MelinoeField_2304", Text = "Caught me a Goldfish!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2305", Text = "Come along, Goldfish!" },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishILegendary=
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2306", Text = "I caught a Styxeon!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2307", Text = "This is a Styxeon...!" },
					{ Cue = "/VO/MelinoeField_2308", Text = "Another Styxeon...?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishILegendary" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2309", Text = "{#Emph}Ah{#Prev}, a Styxeon!" },
					{ Cue = "/VO/MelinoeField_2310", Text = "Got you, Styxeon...!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Ephyra
		FishNCommon =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2626", Text = "I caught a Ribeye.", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2627", Text = "It's a Ribeye...", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2628", Text = "Another Ribeye...",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishNCommon" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2629", Text = "One more Ribeye...",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishNCommon" },
								Comparison = ">=",
								Value = 2,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2630", Text = "That's a Ribeye." },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishNRare =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2631", Text = "I caught a Zeel...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2632", Text = "It's a Zeel.", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2633", Text = "Hey, a Zeel!" },
					{ Cue = "/VO/MelinoeField_2634", Text = "Got me a Zeel." },
					{ Cue = "/VO/MelinoeField_2635", Text = "Another Zeel.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishNRare" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishNLegendary=
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2636", Text = "I caught a Neckbiter...!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2637", Text = "Another Neckbiter...?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishNLegendary" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2638", Text = "Whoa, a Neckbiter...!" },
					{ Cue = "/VO/MelinoeField_2639", Text = "This is a Neckbiter...!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2640", Text = "It's a Neckbiter...!" },

				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Ships
		FishOCommon =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2646", Text = "I caught a Shrimp...!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2647", Text = "It's a Shrimp.", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2648", Text = "Looks like a Shrimp." },
					{ Cue = "/VO/MelinoeField_2649", Text = "Hello, Shrimp." },
					{ Cue = "/VO/MelinoeField_2650", Text = "Another Shrimp.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishOCommon" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishORare =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2331", Text = "Is this a Chrab?", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2332", Text = "It's a Chrab...!" },
					{ Cue = "/VO/MelinoeField_2333", Text = "Looks like a Chrab." },
					{ Cue = "/VO/MelinoeField_2334", Text = "Don't pinch me, you." },
					{ Cue = "/VO/MelinoeField_2335", Text = "Come on, Chrab." },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishOLegendary=
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2651", Text = "I caught a Squid...!",
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2652", Text = "It's a Squid!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2653", Text = "Another Squid?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishOLegendary" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2654", Text = "Wow, a Squid..." },
					{ Cue = "/VO/MelinoeField_2655", Text = "Hey, a Squid!" },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Olympus
		FishPCommon =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2656", Text = "I caught a Pillartop!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2657", Text = "Hey, a Pillartop!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2658", Text = "It's a Pillartop." },
					{ Cue = "/VO/MelinoeField_2659", Text = "Another Pillartop.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishPCommon" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2660", Text = "Looks like a Pillartop." },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishPRare =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2661", Text = "I caught a Chrestle!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2662", Text = "This is a Chrestle!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2663", Text = "It's a Chrestle." },
					{ Cue = "/VO/MelinoeField_2664", Text = "Another Chrestle.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishPRare" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2665", Text = "With me, Chrestle.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishPRare" },
								Comparison = ">=",
								Value = 2,
							},
						},
					},
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishPLegendary=
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2666", Text = "I caught a Starsailor...!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2667", Text = "Wow, a Starsailor!", PlayFirst = true, },
					{ Cue = "/VO/MelinoeField_2668", Text = "This is a Starsailor!" },
					{ Cue = "/VO/MelinoeField_2669", Text = "A Starsailor, what an honor!" },
					{ Cue = "/VO/MelinoeField_2670", Text = "{#Emph}<Gasp> {#Prev}A Starsailor...!" },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Typhon
		FishQCommon =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					AllowTalkOverTextLines = true,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2978", Text = "This is a Lamprey.", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2979", Text = "It's a Lamprey." },
					{ Cue = "/VO/MelinoeField_2980", Text = "Looks like a Lamprey." },
					{ Cue = "/VO/MelinoeField_2981", Text = "Another Lamprey.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishQCommon" },
								Comparison = ">=",
								Value = 2,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2982", Text = "{#Emph}Eugh... {#Prev}a Lamprey." },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishQRare =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					AllowTalkOverTextLines = true,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2983", Text = "I caught a Stormgullet.", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2984", Text = "It's a Stormgullet.", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2985", Text = "That's a Stormgullet." },
					{ Cue = "/VO/MelinoeField_2986", Text = "A nasty Stormgullet." },
					{ Cue = "/VO/MelinoeField_2987", Text = "One more Stormgullet.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishQRare" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishQLegendary=
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					AllowTalkOverTextLines = true,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2988", Text = "It's a Chimaerid...!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2989", Text = "Another Chimaerid?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishQLegendary" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2990", Text = "Whoa, a Chimaerid...!" },
					{ Cue = "/VO/MelinoeField_2991", Text = "This is a Chimaerid..." },
					{ Cue = "/VO/MelinoeField_2992", Text = "A monster of a Chimaerid...",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishQLegendary" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

		-- Chaos 
		FishChaosCommon =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2341", Text = "I caught a Mati...", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2342", Text = "This is a Mati..." },
					{ Cue = "/VO/MelinoeField_2343", Text = "Another Mati." },
					{ Cue = "/VO/MelinoeField_2344", Text = "Looks like a Mati." },
					{ Cue = "/VO/MelinoeField_2345", Text = "In you go, Mati." },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishChaosRare =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2346", Text = "I caught a Projelly!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2347", Text = "This is a Projelly...!" },
					{ Cue = "/VO/MelinoeField_2348", Text = "It's a Projelly!" },
					{ Cue = "/VO/MelinoeField_2349", Text = "Another Projelly!" },
					{ Cue = "/VO/MelinoeField_2350", Text = "Hey, a Projelly!" },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},
		FishChaosLegendary =
		{
			InheritFrom = { "BaseFish" },

			FishIdentifiedVoiceLines =
			{
				{ GlobalVoiceLines = "FishCaughtByCatVoiceLines" },
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					Cooldowns =
					{
						{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
					},

					{ Cue = "/VO/MelinoeField_2351", Text = "I caught a Voidskate...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								PathFalse = { "UsedFamiliar" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2352", Text = "This is a Voidskate...!" },
					{ Cue = "/VO/MelinoeField_2353", Text = "Another Voidskate!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "FishCaught", "FishChaosLegendary" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2354", Text = "A Voidskate, of all things..." },
					{ Cue = "/VO/MelinoeField_2355", Text = "Incredible, a Voidskate!" },
				},
				{ GlobalVoiceLines = "FishIdentifiedVoiceLines" },
			},
		},

	},
}

GlobalVoiceLines = GlobalVoiceLines or {}

GlobalVoiceLines.AboutToFishVoiceLines =
{
	{
		PreLineWait = 0.5,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "OdysseusFishing02" },
			},
		},
		{ Cue = "/VO/Melinoe_0353", Text = "{#Emph}Heh!" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Hecate_01",
		AllowTalkOverTextLines = true,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "HecateFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Hecate_0379", Text = "Let's see what we can do." },
		{ Cue = "/VO/Hecate_0380", Text = "I much prefer to use a spear, myself...", PlayFirst = true },
		{ Cue = "/VO/Hecate_0381", Text = "Come on, you slippery wretches..." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Dora_01",
		AllowTalkOverTextLines = true,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "DoraFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Dora_0084", Text = "{#Emph}Ungh{#Prev}, this is going to be {#Emph}so {#Prev}fun..." },
		{ Cue = "/VO/Dora_0085", Text = "I'm starting to get why you hate fish so much..." },
		{ Cue = "/VO/Dora_0086", Text = "Seems like an awful lot of trouble for some weird fish...", PlayFirst = true },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Odysseus_01",
		AllowTalkOverTextLines = true,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "OdysseusFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Odysseus_0069", Text = "Harder to outsmart those little bastards than one might expect..." },
		{ Cue = "/VO/Odysseus_0070", Text = "These fish won't ridicule us again if I can help it!" },
		{ Cue = "/VO/Odysseus_0071", Text = "Poseidon can't help you here, little fish...", PlayFirst = true },
		{ Cue = "/VO/Odysseus_0759", Text = "Let's see what we can get our hands on..." },
		{ Cue = "/VO/Odysseus_0760", Text = "Something stirs there, just below the surface..." },
		{ Cue = "/VO/Odysseus_0761", Text = "Show them what we're made of, Goddess." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Nemesis_01",
		AllowTalkOverTextLines = true,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "NemesisFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Nemesis_0175", Text = "Just like guard duty..." },
		{ Cue = "/VO/Nemesis_0176", Text = "This what you had in mind?" },
		{ Cue = "/VO/Nemesis_0177", Text = "Make it a fair fight.", PlayFirst = true },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Moros_01",
		AllowTalkOverTextLines = true,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "MorosFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Moros_0345", Text = "Patience is a necessary skill in this pursuit...", PlayFirst = true },
		{ Cue = "/VO/Moros_0346", Text = "Perhaps there's something I can learn from your technique." },
		{ Cue = "/VO/Moros_0347", Text = "What lurks in the River Cocytus...?" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Eris_01",
		AllowTalkOverTextLines = true,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "ErisFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Eris_0221", Text = "Some poor fishie's about to have a really rotten night." },
		{ Cue = "/VO/Eris_0222", Text = "Know how much faster this would go if I could use the Rail?", PlayFirst = true },
		{ Cue = "/VO/Eris_0223", Text = "If the fish don't bite, I'm warning you, {#Emph}I {#Prev}will." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.85,
		ObjectType = "NPC_Icarus_01",
		AllowTalkOverTextLines = true,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "IcarusFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Icarus_0207", Text = "You cast the line into the water just like that..." },
		{ Cue = "/VO/Icarus_0208", Text = "A bit like scanning for targets from the sky...", PlayFirst = true },
		{ Cue = "/VO/Icarus_0209", Text = "This must be tougher than it looks..." },
	},
}
GlobalVoiceLines.FishCaughtVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		UsePlayerSource = true,
		Queue = "Interrupt",
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Melinoe_0758", Text = "Caught out." },
		{ Cue = "/VO/MelinoeField_1351", Text = "And, caught!" },
		{ Cue = "/VO/MelinoeField_1352", Text = "Come on out!" },
		{ Cue = "/VO/MelinoeField_1353", Text = "It's over!" },
		{ Cue = "/VO/MelinoeField_1354", Text = "Victory!" },
		{ Cue = "/VO/MelinoeField_1356", Text = "No escape!" },
		{ Cue = "/VO/Melinoe_0759", Text = "That's a bite!", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "UsedFamiliar" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1346", Text = "Got a bite!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "UsedFamiliar" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0757", Text = "Got you!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "UsedFamiliar" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1347", Text = "It's a bite!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "UsedFamiliar" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1348", Text = "Hooked one!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "UsedFamiliar" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1349", Text = "On the hook!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "UsedFamiliar" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0760", Text = "Mine!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "UsedFamiliar" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1355", Text = "To me!",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					PathFalse = { "UsedFamiliar" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Hecate_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "HecateFishing01", "HecateFishing02" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Hecate_0388", Text = "Got you!", PlayFirst = true },
		{ Cue = "/VO/Hecate_0389", Text = "Out with you!" },
		{ Cue = "/VO/Hecate_0387", Text = "Ensnared!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Dora_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "DoraFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Dora_0093", Text = "Now! I think?" },
		{ Cue = "/VO/Dora_0094", Text = "Swimtime's over!", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Odysseus_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "OdysseusFishing01", "OdysseusFishing02" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Odysseus_0078", Text = "Hah, caught out!" },
		{ Cue = "/VO/Odysseus_0079", Text = "Got you, you little...!" },
		{ Cue = "/VO/Odysseus_0764", Text = "Got one!" },
		{ Cue = "/VO/Odysseus_0766", Text = "Exposed!" },
		{ Cue = "/VO/Odysseus_0768", Text = "{#Emph}Hah!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Nemesis_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "NemesisFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Nemesis_0191", Text = "Got you." },
		{ Cue = "/VO/Nemesis_0192", Text = "You're mine." },
		{ Cue = "/VO/Nemesis_0193", Text = "Caught one...", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Moros_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "MorosFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Moros_0354", Text = "Come meet your fate!" },
		{ Cue = "/VO/Moros_0355", Text = "Your fate is sealed!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Queue = "Interrupt",
		ObjectType = "NPC_Eris_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord", },
				HasAny = { "ErisFishing01" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Eris_0228", Text = "All {#Emph}you{#Prev}, babe!", PlayFirst = true },
		{ Cue = "/VO/Eris_0229", Text = "{#Emph}Wha-ho-hoh!" },
	},
	{ GlobalVoiceLines = "IcarusFishCaughtReactionVoiceLines" },
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		UsePlayerSource = true,
		Queue = "Interrupt",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			}
		},

		{ Cue = "/VO/Melinoe_0350", Text = "{#Emph}<Laugh>" },
		{ Cue = "/VO/Melinoe_0351", Text = "{#Emph}<Laugh>" },
	},
}
GlobalVoiceLines.FishIdentifiedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 1.0,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		Cooldowns =
		{
			{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
		},

		{ Cue = "/VO/Melinoe_3542", Text = "I prevailed...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3543", Text = "It's something!" },
		{ Cue = "/VO/Melinoe_3544", Text = "It's something all right!" },
		{ Cue = "/VO/Melinoe_3545", Text = "Freshly caught." },
		{ Cue = "/VO/Melinoe_3546", Text = "Now come along." },
		{ Cue = "/VO/Melinoe_3547", Text = "Victory is mine." },
		{ Cue = "/VO/Melinoe_3548", Text = "Sweet victory..." },
		{ Cue = "/VO/Melinoe_3549", Text = "Glad you could join me.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1359", Text = "Hello.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1360", Text = "Figures.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1361", Text = "Come with me.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1362", Text = "A fine catch.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
	},
	{ GlobalVoiceLines = "FishIdentifiedReactionLines" },
}
GlobalVoiceLines.FishCaughtByCatVoiceLines =
{
	GameStateRequirements =
	{
		{
			PathFromArgs = true,
			PathTrue = { "UsedFamiliar" },
		},
	},
	{
		PlayOnceFromTableThisRun = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.5,
		Cooldowns =
		{
			{ Name = "MelGlobalFishCaughtVoiceLinesPlayed", Time = 10 },
		},

		{ Cue = "/VO/MelinoeField_2671", Text = "Fine work, Toula." },
		{ Cue = "/VO/MelinoeField_2672", Text = "Excellent catch, Toula." },
		{ Cue = "/VO/MelinoeField_2673", Text = "Look what we got, Toula!" },
		{ Cue = "/VO/MelinoeField_2674", Text = "Easy catch for Toula." },
		{ Cue = "/VO/MelinoeField_2675", Text = "You did it, Toula!" },
		{ Cue = "/VO/MelinoeField_2676", Text = "Toula never fails." },
		{ Cue = "/VO/MelinoeField_2677", Text = "She makes it look easy." },
		{ Cue = "/VO/MelinoeField_2678", Text = "Cheers for that, Toula." },
	},
	{ GlobalVoiceLines = "FishIdentifiedReactionLines" },
}