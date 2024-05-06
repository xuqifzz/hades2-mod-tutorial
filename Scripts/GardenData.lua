GardenData =
{
	JustPlantedAnimation = "GardenPlotJustPlanted",

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
					Weight = 3,
					AddResources =
					{
						PlantNGarlic = 1,
					},
					SproutedAnimation = "PlantNGarlicSprouted",
					ReadyToHarvestAnimation = "PlantNGarlicReadyToHarvest",
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
					Weight = 2,
					AddResources =
					{
						PlantOMandrake = 1,
					},
					SproutedAnimation = "PlantOMandrakeSprouted",
					ReadyToHarvestAnimation = "PlantOMandrakeReadyToHarvest",
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
			GrowTimeMin = 21,
			GrowTimeMax = 21,
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
			GrowTimeMin = 8,
			GrowTimeMax = 8,
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
			GrowTimeMin = 17,
			GrowTimeMax = 17,
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