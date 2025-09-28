GardenData =
{
	JustPlantedAnimation = "GardenPlotJustPlanted",
	PlotOrder =
	{
		583640, -- top-left
		583641, -- top-right
		558335, -- middle-left
		583642, -- middle-right
		558337, -- bottom-left
		583643, -- bottom-right
	},

	Seeds =
	{
		SeedMystery =
		{
			GrowTimeMin = 11,
			GrowTimeMax = 11,
			RandomOutcomes =
			{
				{
					Weight = 4,
					AddResources =
					{
						PlantFNightshade = 1,
					},
					SproutedAnimation = "PlantFNightshadeSprouted",
					ReadyToHarvestAnimation = "PlantFNightshadeReadyToHarvest",
					BonusSeedName = "PlantFNightshadeSeed",
				},
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "PlantGCattailSeed" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Weight = 3,
					AddResources =
					{
						PlantGCattail = 1,
					},
					SproutedAnimation = "PlantGCattailSprouted",
					ReadyToHarvestAnimation = "PlantGCattailReadyToHarvest",
					BonusSeedName = "PlantGCattailSeed",
				},
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "PlantHWheatSeed" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Weight = 2,
					AddResources =
					{
						PlantHWheat = 1,
					},
					SproutedAnimation = "PlantHWheatSprouted",
					ReadyToHarvestAnimation = "PlantHWheatReadyToHarvest",
					BonusSeedName = "PlantHWheatSeed",
				},
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "PlantIPoppySeed" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Weight = 1,
					AddResources =
					{
						PlantIPoppy = 1,
					},
					SproutedAnimation = "PlantIPoppySprouted",
					ReadyToHarvestAnimation = "PlantIPoppyReadyToHarvest",
					BonusSeedName = "PlantIPoppySeed",
				},
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "PlantNGarlicSeed" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Weight = 4,
					AddResources =
					{
						PlantNGarlic = 1,
					},
					SproutedAnimation = "PlantNGarlicSprouted",
					ReadyToHarvestAnimation = "PlantNGarlicReadyToHarvest",
					BonusSeedName = "PlantNGarlicSeed",
				},
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "PlantOMandrakeSeed" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Weight = 3,
					AddResources =
					{
						PlantOMandrake = 1,
					},
					SproutedAnimation = "PlantOMandrakeSprouted",
					ReadyToHarvestAnimation = "PlantOMandrakeReadyToHarvest",
					BonusSeedName = "PlantOMandrakeSeed",
				},
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "PlantPOliveSeed" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Weight = 2,
					AddResources =
					{
						PlantPOlive = 1,
					},
					SproutedAnimation = "PlantPOliveSprouted",
					ReadyToHarvestAnimation = "PlantPOliveReadyToHarvest",
					BonusSeedName = "PlantPOliveSeed",
				},
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "PlantQSnakereedSeed" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Weight = 1,
					AddResources =
					{
						PlantQSnakereed = 1,
					},
					SproutedAnimation = "PlantQSnakereedSprouted",
					ReadyToHarvestAnimation = "PlantQSnakereedReadyToHarvest",
					BonusSeedName = "PlantQSnakereedSeed",
				},
			}
		},

		PlantFNightshadeSeed =
		{
			GrowTimeMin = 5,
			GrowTimeMax = 5,
			RandomOutcomes =
			{
				{
					Weight = 1,
					AddResources =
					{
						PlantFNightshade = 1,
					},
					SproutedAnimation = "PlantFNightshadeSprouted",
					ReadyToHarvestAnimation = "PlantFNightshadeReadyToHarvest",
				},
			},
		},

		PlantGCattailSeed =
		{
			GrowTimeMin = 9,
			GrowTimeMax = 9,
			RandomOutcomes =
			{
				{
					Weight = 1,
					AddResources =
					{
						PlantGCattail = 1,
					},
					SproutedAnimation = "PlantGCattailSprouted",
					ReadyToHarvestAnimation = "PlantGCattailReadyToHarvest",
				},
			},
		},
		
		PlantHWheatSeed =
		{
			GrowTimeMin = 13,
			GrowTimeMax = 13,
			RandomOutcomes =
			{
				{
					Weight = 1,
					AddResources =
					{
						PlantHWheat = 1,
					},
					SproutedAnimation = "PlantHWheatSprouted",
					ReadyToHarvestAnimation = "PlantHWheatReadyToHarvest",
				},
			},
		},

		PlantIPoppySeed =
		{
			GrowTimeMin = 41,
			GrowTimeMax = 41,
			RandomOutcomes =
			{
				{
					Weight = 1,
					AddResources =
					{
						PlantIPoppy = 1,
					},
					SproutedAnimation = "PlantIPoppySprouted",
					ReadyToHarvestAnimation = "PlantIPoppyReadyToHarvest",
				},
			},
		},
		PlantNGarlicSeed =
		{
			GrowTimeMin = 5,
			GrowTimeMax = 5,
			RandomOutcomes =
			{
				{
					Weight = 1,
					AddResources =
					{
						PlantNGarlic = 1,
					},
					SproutedAnimation = "PlantNGarlicSprouted",
					ReadyToHarvestAnimation = "PlantNGarlicReadyToHarvest",
				},
			},
		},

		PlantOMandrakeSeed =
		{
			GrowTimeMin = 19,
			GrowTimeMax = 19,
			RandomOutcomes =
			{
				{
					Weight = 1,
					AddResources =
					{
						PlantOMandrake = 1,
					},
					SproutedAnimation = "PlantOMandrakeSprouted",
					ReadyToHarvestAnimation = "PlantOMandrakeReadyToHarvest",
				},
			},
		},

		PlantPOliveSeed =
		{
			GrowTimeMin = 53,
			GrowTimeMax = 53,
			RandomOutcomes =
			{
				{
					Weight = 1,
					AddResources =
					{
						PlantPOlive = 1,
					},
					SproutedAnimation = "PlantPOliveSprouted",
					ReadyToHarvestAnimation = "PlantPOliveReadyToHarvest",
				},
			},
		},

		PlantQSnakereedSeed =
		{
			GrowTimeMin = 77,
			GrowTimeMax = 77,
			RandomOutcomes =
			{
				{
					Weight = 1,
					AddResources =
					{
						PlantQSnakereed = 1,
					},
					SproutedAnimation = "PlantQSnakereedSprouted",
					ReadyToHarvestAnimation = "PlantQSnakereedReadyToHarvest",
				},
			},
		},
		
		PlantChaosThalamusSeed =
		{
			GrowTimeMin = 7,
			GrowTimeMax = 7,
			RandomOutcomes =
			{
				{
					Weight = 1,
					AddResources =
					{
						PlantChaosThalamus = 2,
					},
					SproutedAnimation = "PlantChaosThalamusSprouted",
					ReadyToHarvestAnimation = "PlantChaosThalamusReadyToHarvest",
				},
			},
		},
	},
}