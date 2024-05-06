OverwriteTableKeys( ResourceData, {
	-- Plant (Collect)
	PlantFMoly =
	{
		IconPath = "Items\\Resources\\Plant\\PlantFMoly_Text",
		TooltipId = "PlantFMolyIcon",
		CostTextId = "PlantFMoly_Short",

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0707", Text = "Moly.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0708", Text = "Another Moly." },
				{ Cue = "/VO/Melinoe_1906", Text = "More will grow in its stead." },
				{ Cue = "/VO/Melinoe_1907", Text = "For the Cauldron." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantGLotus =
	{
		IconPath = "Items\\Resources\\Plant\\PlantGLotus_Text",
		TooltipId = "PlantGLotusIcon",
		CostTextId = "PlantGLotus_Short",

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2375", Text = "A Lotus flower." },
				{ Cue = "/VO/Melinoe_2376", Text = "Lotus." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantHMyrtle =
	{
		IconPath = "Items\\Resources\\Plant\\PlantHMyrtle_Text",
		TooltipId = "PlantHMyrtleIcon",
		CostTextId = "PlantHMyrtle_Short",

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2725", Text = "Myrtle.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2726", Text = "Some Myrtle." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantIShaderot =
	{
		IconPath = "Items\\Resources\\Plant\\PlantIShaderot_Text",
		TooltipId = "PlantIShaderotIcon",
		CostTextId = "PlantIShaderot_Short",

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2824", Text = "Shaderot.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2825", Text = "Some Shaderot." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantNMoss =
	{
		IconPath = "Items\\Resources\\Plant\\PlantNMoss_Text",
		TooltipId = "PlantNMossIcon",
		CostTextId = "PlantNMoss_Short",

		RevealGameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesRevealed" },
				HasAll = { "WorldUpgradeAltRunDoor" },
			},
		},
		InventoryVoiceLines =
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "PlantNMoss" },
					Comparison = "<=",
					Value = 6,
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
			},
			{ Cue = "/VO/Melinoe_3387", Text = "The kind of Moss I need only grows on the surface..." },
		},

		OnAddVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "SurfacePenalty" },
					},
					{
						Path = { "CurrentRun", "Hero", "Health" },
						Comparison = ">=",
						Value = 6,
					},
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_1368", Text = "Needed... this..." },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "SurfacePenalty" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2478", Text = "Moss." },
				{ Cue = "/VO/Melinoe_2479", Text = "Some Moss." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantODriftwood =
	{
		IconPath = "Items\\Resources\\Plant\\PlantODriftwood_Text",
		TooltipId = "PlantODriftwoodIcon",
		CostTextId = "PlantODriftwood_Short",

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3245", Text = "Driftwood." },
				{ Cue = "/VO/Melinoe_3246", Text = "Some Driftwood." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantMoney =
	{
		IconPath = "Items\\Resources\\Plant\\PlantMoney_Text",
		TooltipId = "PlantMoneyIcon",
		CostTextId = "PlantMoney_Short",

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "SurfacePenalty" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2742", Text = "A Deathcap..." },
				{ Cue = "/VO/Melinoe_2743", Text = "It's a Deathcap...", PlayFirst = true },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	-- Plant (Grown)
	PlantFNightshadeSeed =
	{
		IconPath = "Items\\Resources\\Plant\\PlantFNightshadeSeed_Text",
		TooltipId = "PlantFNightshadeSeedIcon",
		CostTextId = "PlantFNightshadeSeed_Short",

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				{ Cue = "/VO/Melinoe_2779", Text = "Nightshade Seeds.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2780", Text = "Some Nightshade Seeds." },
			},
			[2] = GlobalVoiceLines.FoundSeedVoiceLines,
			[3] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
	PlantFNightshade =
	{
		IconPath = "Items\\Resources\\Plant\\PlantFNightshade_Text",
		TooltipId = "PlantFNightshadeIcon",
		CostTextId = "PlantFNightshade_Short",

		OnAddVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2781", Text = "Nightshade." },
				{ Cue = "/VO/Melinoe_2782", Text = "Some Nightshade." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantGCattailSeed =
	{
		IconPath = "Items\\Resources\\Plant\\PlantGCattailSeed_Text",
		TooltipId = "PlantGCattailSeedIcon",
		CostTextId = "PlantGCattailSeed_Short",
		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2384", Text = "Cattail seeds." },
			},
			[2] = GlobalVoiceLines.FoundSeedVoiceLines,
			[3] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
	PlantGCattail =
	{
		IconPath = "Items\\Resources\\Plant\\PlantGCattail_Text",
		TooltipId = "PlantGCattailIcon",
		CostTextId = "PlantGCattail_Short",
		OnAddVoiceLines =
		{
			[1] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
	
	PlantHWheatSeed =
	{
		IconPath = "Items\\Resources\\Plant\\PlantHWheatSeed_Text",
		TooltipId = "PlantHWheatSeedIcon",
		CostTextId = "PlantHWheatSeed_Short",
		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2727", Text = "Wheat Seeds." },
			},
			[2] = GlobalVoiceLines.FoundSeedVoiceLines,
			[3] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
	PlantHWheat =
	{
		IconPath = "Items\\Resources\\Plant\\PlantHWheat_Text",
		TooltipId = "PlantHWheatIcon",
		CostTextId = "PlantHWheat_Short",
		OnAddVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2728", Text = "Some Wheat.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2729", Text = "Wheat for the harvest." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantIPoppySeed =
	{
		IconPath = "Items\\Resources\\Plant\\PlantIPoppySeed_Text",
		TooltipId = "PlantIPoppySeedIcon",
		CostTextId = "PlantIPoppySeed_Short",
		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2826", Text = "Poppy-flower seeds..." },
				{ Cue = "/VO/Melinoe_2827", Text = "Seeds of the Poppy..." },
			},
			[2] = GlobalVoiceLines.FoundSeedVoiceLines,
			[3] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
	PlantIPoppy =
	{
		IconPath = "Items\\Resources\\Plant\\PlantIPoppy_Text",
		TooltipId = "PlantIPoppyIcon",
		CostTextId = "PlantIPoppy_Short",
		OnAddVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2828", Text = "Poppies.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2829", Text = "Fresh Poppies." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantNGarlicSeed =
	{
		IconPath = "Items\\Resources\\Plant\\PlantNGarlicSeed_Text",
		TooltipId = "PlantNGarlicSeedIcon",
		CostTextId = "PlantNGarlicSeed_Short",

		RevealGameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesRevealed" },
				HasAny = { "WorldUpgradeAltRunDoor", "WorldUpgradeTaverna" },
			},
		},

		OnAddVoiceLines =
		{
			[1] = GlobalVoiceLines.FoundSeedVoiceLines,
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
	PlantNGarlic =
	{
		IconPath = "Items\\Resources\\Plant\\PlantNGarlic_Text",
		TooltipId = "PlantNGarlicIcon",
		CostTextId = "PlantNGarlic_Short",

		RevealGameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesRevealed" },
				HasAny = { "WorldUpgradeAltRunDoor", "WorldUpgradeTaverna" },
			},
		},

		OnAddVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2476", Text = "Garlic." },
				{ Cue = "/VO/Melinoe_2477", Text = "Some Garlic." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantOMandrakeSeed =
	{
		IconPath = "Items\\Resources\\Plant\\PlantOMandrakeSeed_Text",
		TooltipId = "PlantOMandrakeSeedIcon",
		CostTextId = "PlantOMandrakeSeed_Short",

		RevealGameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny = { "WorldUpgradeErebusSafeZones", "WorldUpgradeBoonList" },
			},
			{
				Path = { "GameState", "WorldUpgradesRevealed" },
				HasAll = { "WorldUpgradeAltRunDoor" },
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3247", Text = "Mandrake Seeds." },
				{ Cue = "/VO/Melinoe_3248", Text = "Some Mandrake Seeds." },
			},
			[2] = GlobalVoiceLines.FoundSeedVoiceLines,
			[3] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
	PlantOMandrake =
	{
		IconPath = "Items\\Resources\\Plant\\PlantOMandrake_Text",
		TooltipId = "PlantOMandrakeIcon",
		CostTextId = "PlantOMandrake_Short",

		RevealGameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny = { "WorldUpgradeErebusSafeZones", "WorldUpgradeBoonList" },
			},
			{
				Path = { "GameState", "WorldUpgradesRevealed" },
				HasAll = { "WorldUpgradeAltRunDoor" },
			},
		},

		OnAddVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0712", Text = "Mandrake Root." },
				{ Cue = "/VO/Melinoe_3249", Text = "Mandrake Root." },
				{ Cue = "/VO/Melinoe_3250", Text = "Some Mandrake Root." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantChaosThalamusSeed =
	{
		IconPath = "Items\\Resources\\Plant\\PlantChaosThalamusSeed_Text",
		TooltipId = "PlantChaosThalamusSeedIcon",
		CostTextId = "PlantChaosThalamusSeed_Short",

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutSurface01" },
			},
		},
		InventoryVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantChaosThalamusSeed" },
						Comparison = "<=",
						Value = 6,
					},
					{
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
				},
				{ Cue = "/VO/Melinoe_3388", Text = "I have to search the depths of Chaos for this..." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "ThalamusAltHintVO",
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
				},
				{ Cue = "/VO/Melinoe_0811", Text = "Where...?" },
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2738", Text = "An Origin Seed..." },
				{ Cue = "/VO/Melinoe_2739", Text = "Some sort of Seed...", PlayFirst = true },
			},
			[2] = GlobalVoiceLines.FoundSeedVoiceLines,
			[3] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
	PlantChaosThalamus =
	{
		IconPath = "Items\\Resources\\Plant\\PlantChaosThalamus_Text",
		TooltipId = "PlantChaosThalamusIcon",
		CostTextId = "PlantChaosThalamus_Short",

		RevealGameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesRevealed" },
				HasAll = { "WorldUpgradeSurfacePenaltyCure" },
			},
		},
		InventoryVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantChaosThalamus" },
						Comparison = "<=",
						Value = 6,
					},
					{
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
				},
				{ Cue = "/VO/Melinoe_3388", Text = "I have to search the depths of Chaos for this..." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "ThalamusAltHintVO",
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
				},
				{ Cue = "/VO/Melinoe_0811", Text = "Where...?" },
			},
		},

		ExtraDescriptions =
		{
			{
				TextId = "PlantChaosThalamus_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutSurface01" },
					}
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2740", Text = "Thalamus..." },
				{ Cue = "/VO/Melinoe_2741", Text = "Born of Chaos...", PlayFirst = true },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	PlantGrowthAccelerant =
	{
		IconPath = "Items\\Resources\\Plant\\PlantGrowthAccelerant_Text",
		TooltipId = "SeedEpicIcon",		OnAddVoiceLines =
		{
			[1] = GlobalVoiceLines.FoundSeedVoiceLines,
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	SeedMystery =
	{
		IconPath = "Items\\Resources\\Plant\\PlantMysterySeed_Text",
		TooltipId = "SeedMysteryIcon",

		ExtraDescriptions =
		{
			{
				TextId = "SeedMystery_ExtraDetails1",
				Requirements =
				{
					{
						Path = { "GameState", "TraitsTaken" },
						HasAll =
						{
							"PlantHealthBoon",
						},
					},
				},
			}
		},

		OnAddVoiceLines =
		{
			[1] = GlobalVoiceLines.FoundSeedVoiceLines,
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
})