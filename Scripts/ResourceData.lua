ResourceData =
{
	BaseResource =
	{
		DebugOnly = true,
		IconScale = 0.34,
	},

	-- Boss
	MixerFBoss =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Boss\\MixerFBoss",
		TextIconPath = "Items\\Resources\\Boss\\MixerFBoss_Text",
		TooltipId = "MixerFBossIcon",
		CostTextId = "MixerFBoss_Short",

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

				{ Cue = "/VO/Melinoe_0703", Text = "Cinder.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0704", Text = "Some Cinder." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MixerGBoss =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Boss\\MixerGBoss",
		TextIconPath = "Items\\Resources\\Boss\\MixerGBoss_Text",
		TooltipId = "MixerGBossIcon",
		CostTextId = "MixerGBoss_Short",

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

				{ Cue = "/VO/Melinoe_2736", Text = "A Pearl.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2737", Text = "Another Pearl." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MixerHBoss =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Boss\\MixerHBoss",
		TextIconPath = "Items\\Resources\\Boss\\MixerHBoss_Text",
		TooltipId = "MixerHBossIcon",
		CostTextId = "MixerHBoss_Short",

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

				{ Cue = "/VO/Melinoe_2732", Text = "Tears...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2733", Text = "Some Tears." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MixerIBoss =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Boss\\MixerIBoss",
		TextIconPath = "Items\\Resources\\Boss\\MixerIBoss_Text",
		TooltipId = "MixerIBossIcon",
		CostTextId = "MixerIBoss_Short",

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradePauseChronosFight" },
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

				{ Cue = "/VO/Melinoe_2832", Text = "Nothing but sand.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2833", Text = "Zodiac Sand." },
				{ Cue = "/VO/Melinoe_2834", Text = "Remains of Chronos..." },
				{ Cue = "/VO/Melinoe_2835", Text = "More of this Sand..." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MixerNBoss =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Boss\\MixerNBoss",
		TextIconPath = "Items\\Resources\\Boss\\MixerNBoss_Text",
		TooltipId = "MixerNBossIcon",
		CostTextId = "MixerNBoss_Short",

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

				{ Cue = "/VO/Melinoe_2533", Text = "Wool." },
				{ Cue = "/VO/Melinoe_2534", Text = "Some Wool.", PlayFirst = true },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MixerOBoss =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Boss\\MixerOBoss",
		TextIconPath = "Items\\Resources\\Boss\\MixerOBoss_Text",
		TooltipId = "MixerOBossIcon",
		CostTextId = "MixerOBoss_Short",

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

				{ Cue = "/VO/Melinoe_0713", Text = "Golden Apple...!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3253", Text = "A Golden Apple.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3254", Text = "Another Golden Apple.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAll = { "/VO/Melinoe_0713", "/VO/Melinoe_3253" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_3255", Text = "Where does she get all these...?" },
				{ Cue = "/VO/Melinoe_3256", Text = "Probably stolen...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAll = { "/VO/Melinoe_3255" },
						},
					},
				},
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MixerPBoss =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Boss\\MixerPBoss",
		TextIconPath = "Items\\Resources\\Boss\\MixerPBoss_Text",
		TooltipId = "MixerPBossIcon",
		CostTextId = "MixerPBoss_Short",

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

				{ Cue = "/VO/Melinoe_3628", Text = "A Feather...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3629", Text = "Eagle's Feather..." },
				{ Cue = "/VO/Melinoe_3630", Text = "Feather." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	-- Cosmetics
	CosmeticsPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Alchemy\\CosmeticsPointsPrestige",
		TextIconPath = "Items\\Resources\\Alchemy\\CosmeticsPointsPrestige_Text",
		TooltipId = "CosmeticsPointsIcon",
		CostTextId = "CosmeticsPoints_Short",

		RevealGameStateRequirements =
		{
			NamedRequirements = { "CosmeticsShopUnlocked" },
		},
	},

	-- Plant (Collect)
	PlantFMoly =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantFMoly",
		TextIconPath = "Items\\Resources\\Plant\\PlantFMoly_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantGLotus =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantGLotus",
		TextIconPath = "Items\\Resources\\Plant\\PlantGLotus_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantHMyrtle =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantHMyrtle",
		TextIconPath = "Items\\Resources\\Plant\\PlantHMyrtle_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantIShaderot =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantIShaderot",
		TextIconPath = "Items\\Resources\\Plant\\PlantIShaderot_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantNMoss =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantNMoss",
		TextIconPath = "Items\\Resources\\Plant\\PlantNMoss_Text",
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
				{
					Path = { "GameState", "WorldUpgradesRevealed" },
					HasAll = { "WorldUpgradeSurfacePenaltyCure" },
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantODriftwood =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantODriftwood",
		TextIconPath = "Items\\Resources\\Plant\\PlantODriftwood_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantPIris =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantPIris",
		TextIconPath = "Items\\Resources\\Plant\\PlantPIris_Text",
		TooltipId = "PlantPIrisIcon",
		CostTextId = "PlantPIris_Short",

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

				{ Cue = "/VO/Melinoe_3620", Text = "Iris." },
				{ Cue = "/VO/Melinoe_3621", Text = "An Iris.", PlayFirst = true },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantMoney =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantMoney",
		TextIconPath = "Items\\Resources\\Plant\\PlantMoney_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	-- Plant (Grown)
	PlantFNightshadeSeed =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantFNightshadeSeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantFNightshadeSeed_Text",
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
			[2] = { GlobalVoiceLines = "FoundSeedVoiceLines" },
			[3] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantFNightshade =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantFNightshade",
		TextIconPath = "Items\\Resources\\Plant\\PlantFNightshade_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantGCattailSeed =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantGCattailSeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantGCattailSeed_Text",
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
			[2] = { GlobalVoiceLines = "FoundSeedVoiceLines" },
			[3] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantGCattail =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantGCattail",
		TextIconPath = "Items\\Resources\\Plant\\PlantGCattail_Text",
		TooltipId = "PlantGCattailIcon",
		CostTextId = "PlantGCattail_Short",
		OnAddVoiceLines =
		{
			[1] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},
	
	PlantHWheatSeed =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantHWheatSeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantHWheatSeed_Text",
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
			[2] = { GlobalVoiceLines = "FoundSeedVoiceLines" },
			[3] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantHWheat =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantHWheat",
		TextIconPath = "Items\\Resources\\Plant\\PlantHWheat_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantIPoppySeed =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantIPoppySeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantIPoppySeed_Text",
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
			[2] = { GlobalVoiceLines = "FoundSeedVoiceLines" },
			[3] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantIPoppy =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantIPoppy",
		TextIconPath = "Items\\Resources\\Plant\\PlantIPoppy_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantNGarlicSeed =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantNGarlicSeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantNGarlicSeed_Text",
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
			[1] = { GlobalVoiceLines = "FoundSeedVoiceLines" },
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantNGarlic =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantNGarlic",
		TextIconPath = "Items\\Resources\\Plant\\PlantNGarlic_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantOMandrakeSeed =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantOMandrakeSeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantOMandrakeSeed_Text",
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
			[2] = { GlobalVoiceLines = "FoundSeedVoiceLines" },
			[3] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantOMandrake =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantOMandrake",
		TextIconPath = "Items\\Resources\\Plant\\PlantOMandrake_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantPOliveSeed =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantPOliveSeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantPOliveSeed_Text",
		TooltipId = "PlantPOliveSeedIcon",
		CostTextId = "PlantPOliveSeed_Short",

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

				{ Cue = "/VO/Melinoe_3622", Text = "An Olive Branch...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3623", Text = "Another Branch..." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantPOlive =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantPOlive",
		TextIconPath = "Items\\Resources\\Plant\\PlantPOlive_Text",
		TooltipId = "PlantPOliveIcon",
		CostTextId = "PlantPOlive_Short",

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

				{ Cue = "/VO/Melinoe_3624", Text = "Olives." },
				{ Cue = "/VO/Melinoe_3625", Text = "Some Olives." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantChaosThalamusSeed =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantChaosThalamusSeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantChaosThalamusSeed_Text",
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
			[2] = { GlobalVoiceLines = "FoundSeedVoiceLines" },
			[3] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantChaosThalamus =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantChaosThalamus",
		TextIconPath = "Items\\Resources\\Plant\\PlantChaosThalamus_Text",
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
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantGrowthAccelerant =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantGrowthAccelerant",
		TextIconPath = "Items\\Resources\\Plant\\PlantGrowthAccelerant_Text",
		TooltipId = "SeedEpicIcon",		OnAddVoiceLines =
		{
			[1] = { GlobalVoiceLines = "FoundSeedVoiceLines" },
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	SeedMystery =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantMysterySeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantMysterySeed_Text",
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
			[1] = { GlobalVoiceLines = "FoundSeedVoiceLines" },
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	-- Ores
	OreFSilver =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Ore\\OreFSilver",
		TextIconPath = "Items\\Resources\\Ore\\OreFSilver_Text",
		TooltipId = "OreFSilverIcon",
		CostTextId = "OreFSilver_Short",

		ExtraDescriptions =
		{
			{
				TextId = "OreFSilver_ExtraDetails1",
				Requirements =
				{
					{
						Path = { "GameState", "TraitsTaken" },
						HasAll =
						{
							"NarcissusC",
						},
					},
				},
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "F_Story01" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0701", Text = "Silver.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0702", Text = "Some Silver." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreGLime =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Ore\\OreGLime",
		TextIconPath = "Items\\Resources\\Ore\\OreGLime_Text",
		TooltipId = "OreGLimeIcon",
		CostTextId = "OreGLime_Short",

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

				{ Cue = "/VO/Melinoe_2377", Text = "Limestone." },
				{ Cue = "/VO/Melinoe_2378", Text = "Some Limestone." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreHGlassrock =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Ore\\OreHGlassrock",
		TextIconPath = "Items\\Resources\\Ore\\OreHGlassrock_Text",
		TooltipId = "OreHGlassrockIcon",
		CostTextId = "OreHGlassrock_Short",

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

				{ Cue = "/VO/Melinoe_2730", Text = "Glassrock...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2731", Text = "Some Glassrock..." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreIMarble =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Ore\\OreIMarble",
		TextIconPath = "Items\\Resources\\Ore\\OreIMarble_Text",
		TooltipId = "OreIMarbleIcon",
		CostTextId = "OreIMarble_Short",

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

				{ Cue = "/VO/Melinoe_2830", Text = "Marble.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2831", Text = "Some Marble." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreNBronze =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Ore\\OreNBronze",
		TextIconPath = "Items\\Resources\\Ore\\OreNBronze_Text",
		TooltipId = "OreNBronzeIcon",
		CostTextId = "OreNBronze_Short",

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
					Path = { "GameState", "LifetimeResourcesGained", "OreNBronze" },
					Comparison = "<=",
					Value = 8,
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
			},
			{ Cue = "/VO/Melinoe_3389", Text = "Should be no shortage of this on the surface..." },
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
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "SurfacePenalty" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0705", Text = "Bronze." },
				{ Cue = "/VO/Melinoe_0795", Text = "Bronze.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0706", Text = "Some Bronze." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},		
	},

	OreOIron =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Ore\\OreOIron",
		TextIconPath = "Items\\Resources\\Ore\\OreOIron_Text",
		TooltipId = "OreOIronIcon",
		CostTextId = "OreOIron_Short",

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

				{ Cue = "/VO/Melinoe_3251", Text = "Iron." },
				{ Cue = "/VO/Melinoe_3252", Text = "Some Iron." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OrePAdamant =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Ore\\OrePAdamant",
		TextIconPath = "Items\\Resources\\Ore\\OrePAdamant_Text",
		TooltipId = "OrePAdamantIcon",
		CostTextId = "OrePAdamant_Short",

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

				{ Cue = "/VO/Melinoe_3626", Text = "Adamant." },
				{ Cue = "/VO/Melinoe_3627", Text = "Some Adamant." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreChaosProtoplasm =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Ore\\OreChaosProtoplasm",
		TextIconPath = "Items\\Resources\\Ore\\OreChaosProtoplasm_Text",
		TooltipId = "OreChaosProtoplasmIcon",
		CostTextId = "OreChaosProtoplasm_Short",

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

				{ Cue = "/VO/Melinoe_2734", Text = "Plasma...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2735", Text = "Some Plasma..." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	-- Meta
	MetaCurrency =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Common\\MetaCurrency",
		TextIconPath = "Items\\Resources\\Common\\MetaCurrency_Text",

		TooltipId = "MetaCurrencyIcon",
		CostTextId = "MetaCurrency_Short",
		-- OnAddVoiceLines: using OnConsumedVoiceLines instead

		ExtraDescriptions =
		{
			{
				TextId = "MetaCurrency_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
			},
			{
				TextId = "MetaCurrency_ExtraDetails2",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeUnusedWeaponBonus" },
					},
				},
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
					Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
					Comparison = "<=",
					Value = 10,
				},
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
			},

			{ Cue = "/VO/Melinoe_3550", Text = "Always need Bones, just... not precisely now." },
		},

	},

	MetaCardPointsCommon =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Common\\MetaCardPointsCommon",
		TextIconPath = "Items\\Resources\\Common\\MetaCardPointsCommon_Text",
		TooltipId = "MetaCardPointsCommonIcon",
		CostTextId = "MetaCardPointsCommon_Short",

		ExtraDescriptions =
		{
			{
				TextId = "MetaCardPointsCommon_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
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
					PathFalse = { "GameState", "ScreensViewed", "MetaUpgradeCardLayout" }
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
			},
			{ Cue = "/VO/Melinoe_1903", Text = "I'll need these soon enough." },
		},
		OnAddVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
						Comparison = "<=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Melinoe_1903", Text = "I'll need these soon enough." },
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "ErisResourceGranted", Time = 8 }
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech", "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Melinoe_1661", Text = "Ash of the Dead.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1662", Text = "Ashes." },
				{ Cue = "/VO/Melinoe_1663", Text = "More Ashes." },
				{ Cue = "/VO/Melinoe_1664", Text = "Ash for my Arcana." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MemPointsCommon =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Common\\MemPointsCommon",
		TextIconPath = "Items\\Resources\\Common\\MemPointsCommon_Text",
		TooltipId = "MemPointsCommonIcon",
		CostTextId = "MemPointsCommon_Short",

		ExtraDescriptions =
		{
			{
				TextId = "MemPointsCommon_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
					},
				},
			},
			{
				TextId = "MemPointsCommon_ExtraDetails2",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
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
					PathFalse = { "GameState", "ScreensViewed", "MetaUpgradeCardLayout" }
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
			},
			{ Cue = "/VO/Melinoe_1659", Text = "Can use this at my Altar back home." },
		},

		ConsumedVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
						Comparison = "<=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Melinoe_1659", Text = "Can use this at my Altar back home." },
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "ErisResourceGranted", Time = 8 }
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN", "HeraclesCombatN" },
					},
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech", "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Melinoe_1657", Text = "Psyche.", PlayFirst = true, },
				{ Cue = "/VO/Melinoe_1658", Text = "More Psyche." },
				{ Cue = "/VO/Melinoe_1904", Text = "I'll just stash this away.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1660", Text = "The Spirits of the Dead..." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MetaFabric =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Common\\MetaFabric",
		TextIconPath = "Items\\Resources\\Common\\MetaFabric_Text",
		TooltipId = "MetaFabricIcon",
		CostTextId = "MetaFabric_Short",

		ExtraDescriptions =
		{
			{
				TextId = "MetaFabric_ExtraDetails1",
				Requirements =
				{
					{
						Path = { "GameState", "TraitsTaken" },
						HasAll =
						{
							"HighArmorCostume",
						},
					},
				},
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
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_1064", Text = "Fate Fabric.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1065", Text = "Some Fate Fabric." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	CardUpgradePoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\CardUpgradePoints",
		TextIconPath = "Items\\Resources\\Other\\CardUpgradePoints_Text",
		TooltipId = "CardUpgradePointsIcon",
		CostTextId = "CardUpgradePoints_Short",

		ExtraDescriptions =
		{
			{
				TextId = "CardUpgradePoints_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_1066", Text = "Moon Dust.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1067", Text = "Some Moon Dust." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	-- Gifts
	GiftPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\GiftDrop",
		TextIconPath = "Items\\Resources\\Other\\GiftDrop_Text",
		TooltipId = "GiftPointsIcon",
		CostTextId = "GiftPoints_Short",

		OnAddedFunctionName = "OnGiftPointsAdded",

		SpendSound = "/SFX/GiftAmbrosiaBottlePickup",
		BrokerSpentVoiceLines =
		{
			[1] = { GlobalVoiceLines = "SpentGiftPointsVoiceLines" },
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = { GlobalVoiceLines = "PurchasedGiftPointsVoiceLines" },
		},


		ExtraDescriptions =
		{
			{
				TextId = "GiftPoints_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
			},
			{
				TextId = "GiftPoints_ExtraDetails2",
				Requirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutNectar01" },
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.15,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "TestAllThings" },
					},
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ErisGiftDecline01", "NemesisGiftDecline01", "NemesisGift02" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "NemesisRandomEvent", "Story_Hades_01" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_0793", Text = "Nectar.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpeechRecord" },
							HasNone = { "/VO/Melinoe_0793", "/VO/Melinoe_0794" },
						},
					}
				},
				{ Cue = "/VO/Melinoe_0794", Text = "Some Nectar.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpeechRecord" },
							HasNone = { "/VO/Melinoe_0793", "/VO/Melinoe_0794" },
						},
					}
				},
				{ Cue = "/VO/Melinoe_1989", Text = "Could make a lovely gift.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1990", Text = "Who shall I give this to?", PlayFirst = true },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	GiftPointsRare =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\GiftPointsRare",
		TextIconPath = "Items\\Resources\\Other\\GiftPointsRare_Text",
		TooltipId = "GiftPointsRareIcon",
		CostTextId = "GiftPointsRare_Short",
		AddTimerTicks = 12, -- used for text

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
						Path = { "CurrentRun", "HubTextLinesRecord" },
						HasNone = { "HecateBathHouseDecline01", "OdysseusBathHouseDecline01", "NemesisBathHouseDecline01", "ErisBathHouseDecline01", "MorosBathHouseDecline01", "SkellyBathHouseDecline01", "DoraBathHouseDecline01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "NemesisRandomEvent" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_0796", Text = "Salt." },
				{ Cue = "/VO/Melinoe_0797", Text = "Some Salt.", PlayFirst = true },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	GiftPointsEpic =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\GiftPointsEpic",
		TextIconPath = "Items\\Resources\\Other\\GiftPointsEpic_Text",
		TooltipId = "GiftPointsEpicIcon",
		CostTextId = "GiftPointsEpic_Short",
		AddTimerTicks = 16, -- used for text

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
						Path = { "CurrentRun", "HubTextLinesRecord" },
						HasNone = { "ErisFishingDecline01", "HecateFishingDecline01", "NemesisFishingDecline01", "ErisFishingDecline01", "MorosFishingDecline01", "SkellyFishingDecline01", "DoraFishingDecline01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "NemesisRandomEvent" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_0798", Text = "Lures." },
				{ Cue = "/VO/Melinoe_0799", Text = "A set of Lures.", PlayFirst = true },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	HypnosPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\HypnosPoints",
		TextIconPath = "Items\\Resources\\Other\\HypnosPoints_Text",
		TooltipId = "HypnosPointsIcon",
		-- CostTextId = "HypnosPoints_Short",
		AddTimerTicks = 16, -- used for text

		OnAddVoiceLines =
		{
			--
		},
	},

	-- Fish
	FishFCommon =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishFCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishFCommon_Text",
		CostTextId = "FishFCommon_Short",
	},
	FishFRare =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishFRare",
		TextIconPath = "Items\\Resources\\Fish\\FishFRare_Text",
		CostTextId = "FishFRare_Short",
	},
	FishFLegendary =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishFLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishFLegendary_Text",
		CostTextId = "FishFLegendary_Short",
	},

	FishGCommon =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishGCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishGCommon_Text",
		CostTextId = "FishGCommon_Short",
	},
	FishGRare =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishGRare",
		TextIconPath = "Items\\Resources\\Fish\\FishGRare_Text",
		CostTextId = "FishGRare_Short",
	},
	FishGLegendary =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishGLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishGLegendary_Text",
		CostTextId = "FishGLegendary_Short",
	},

	FishHCommon =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishHCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishHCommon_Text",
		CostTextId = "FishHCommon_Short",
	},
	FishHRare =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishHRare",
		TextIconPath = "Items\\Resources\\Fish\\FishHRare_Text",
		CostTextId = "FishHRare_Short",
	},
	FishHLegendary =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishHLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishHLegendary_Text",
		CostTextId = "FishHLegendary_Short",
	},

	FishICommon =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishICommon",
		TextIconPath = "Items\\Resources\\Fish\\FishICommon_Text",
		CostTextId = "FishICommon_Short",
	},
	FishIRare =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishIRare",
		TextIconPath = "Items\\Resources\\Fish\\FishIRare_Text",
		CostTextId = "FishIRare_Short",
	},
	FishILegendary =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishILegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishILegendary_Text",
		CostTextId = "FishILegendary_Short",
	},

	FishNCommon =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishNCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishNCommon_Text",
		CostTextId = "FishNCommon_Short",
	},
	FishNRare =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishNRare",
		TextIconPath = "Items\\Resources\\Fish\\FishNRare_Text",
		CostTextId = "FishNRare_Short",
	},
	FishNLegendary =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishNLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishNLegendary_Text",
		CostTextId = "FishNLegendary_Short",
	},

	FishOCommon =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishOCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishOCommon_Text",
		CostTextId = "FishOCommon_Short",
	},
	FishORare =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishORare",
		TextIconPath = "Items\\Resources\\Fish\\FishORare_Text",
		CostTextId = "FishORare_Short",
	},
	FishOLegendary =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishOLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishOLegendary_Text",
		CostTextId = "FishOLegendary_Short",
	},

	FishPCommon =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishPCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishPCommon_Text",
		CostTextId = "FishPCommon_Short",
	},
	FishPRare =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishPRare",
		TextIconPath = "Items\\Resources\\Fish\\FishPRare_Text",
		CostTextId = "FishPRare_Short",
	},
	FishPLegendary =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishPLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishPLegendary_Text",
		CostTextId = "FishPLegendary_Short",
	},

	FishBCommon =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishBCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishBCommon_Text",
		CostTextId = "FishBCommon_Short",
	},
	FishBRare =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishBRare",
		TextIconPath = "Items\\Resources\\Fish\\FishBRare_Text",
		CostTextId = "FishBRare_Short",
	},
	FishBLegendary =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishBLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishBLegendary_Text",
		CostTextId = "FishBLegendary_Short",
	},

	FishChaosCommon =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishChaosCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishChaosCommon_Text",
		CostTextId = "FishChaosCommon_Short",
	},
	FishChaosRare =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishChaosRare",
		TextIconPath = "Items\\Resources\\Fish\\FishChaosRare_Text",
		CostTextId = "FishChaosRare_Short",
	},
	FishChaosLegendary =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Fish\\FishChaosLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishChaosLegendary_Text",
		CostTextId = "FishChaosLegendary_Short",
	},

	-- Misc
	WeaponPointsRare =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\WeaponPointsRare",
		TextIconPath = "Items\\Resources\\Other\\WeaponPointsRare_Text",
		TooltipId = "WeaponPointsRareIcon",
		CostTextId = "WeaponPointsRare_Short",

		SpendSound = "/SFX/TitanBloodPickupSFX",
		BrokerSpentVoiceLines =
		{
			[1] = { GlobalVoiceLines = "SpentSuperLockKeysVoiceLines" },
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = { GlobalVoiceLines = "PurchasedSuperLockKeysVoiceLines" },
		},

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},

		ExtraDescriptions =
		{
			{
				TextId = "WeaponPointsRare_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" }
					},
				},
			},
			{
				TextId = "WeaponPointsRare_ExtraDetails2",
				Requirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2952", Text = "Nightmare." },
				{ Cue = "/VO/Melinoe_2953", Text = "Some Nightmare." },
				{ Cue = "/VO/Melinoe_2954", Text = "From the Oath." },
				{ Cue = "/VO/Melinoe_2955", Text = "A gift from Night.", PlayFirst = true },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	Mixer5Common =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\Mixer5Common",
		TextIconPath = "Items\\Resources\\Other\\Mixer5Common_Text",
		TooltipId = "Mixer5CommonIcon",
		CostTextId = "Mixer5Common_Short",

		ExtraDescriptions =
		{
			{
				TextId = "Mixer5Common_ExtraDetails2",
				Requirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "Mixer5Common" },
						Comparison = ">=",
						Value = 3,
					},
				},
			},
			{
				TextId = "Mixer5Common_ExtraDetails1",
				Requirements =
				{
					{
						Path = { "GameState", "TraitsTaken" },
						HasAll =
						{
							"NarcissusG",
						},
					},
				},
			}
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

				{ Cue = "/VO/Melinoe_2381", Text = "Star Dust." },
				{ Cue = "/VO/Melinoe_2382", Text = "Some Star Dust." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	Mixer6Common =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Ore\\Mixer6Common",
		TextIconPath = "Items\\Resources\\Ore\\Mixer6Common_Text",
		TooltipId = "Mixer6CommonIcon",
		CostTextId = "Mixer6Common_Short",

		ExtraDescriptions =
		{
			{
				TextId = "Mixer6Common_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGrantsDarkness01" },
					},
				},
			}
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

				{ Cue = "/VO/Melinoe_0699", Text = "Darkness." },
				{ Cue = "/VO/Melinoe_0700", Text = "Some Darkness." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MixerShadow =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Alchemy\\Shadow",
		TextIconPath = "Items\\Resources\\Alchemy\\Shadow_Text",
		TooltipId = "MixerShadowIcon",
		CostTextId = "MixerShadow_Short",

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeAltRunDoor" },
			},
		},

		ExtraDescriptions =
		{
			{
				TextId = "MixerShadow_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeMixerShadow" },
					},
				},
			},
		},

		InventoryVoiceLines =
		{
			PlayOnce = true,
			PreLineWait = 0.55,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MixerShadow" },
					Comparison = "<",
					Value = 1,
				},
			},
			{ Cue = "/VO/Melinoe_2622", Text = "Must be a way I can extract pure Shadow..." },
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

				{ Cue = "/VO/Melinoe_2535", Text = "Shadow." },
				{ Cue = "/VO/Melinoe_2536", Text = "Some Shadow." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MixerMythic =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\MixerMythic",
		TextIconPath = "Items\\Resources\\Other\\MixerMythic_Text",
		TooltipId = "MixerMythicIcon",
		CostTextId = "MixerMythic_Short",

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeTimeStop" },
			},
		},

		InventoryVoiceLines =
		{
			PlayOnce = true,
			PreLineWait = 0.55,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MixerMythic" },
					Comparison = "<",
					Value = 1,
				},
			},
			-- { Cue = "/VO/Melinoe_2622", Text = "Must be a way I can extract pure Shadow..." },
		},

		OnAddVoiceLines =
		{
		},
	},

	FamiliarPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Alchemy\\FamiliarPoints",
		TextIconPath = "Items\\Resources\\Alchemy\\FamiliarPoints_Text",
		TooltipId = "FamiliarPointsIcon",
		CostTextId = "FamiliarPoints_Short",

		RevealGameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAny = { "/VO/Melinoe_0990" },
			},
			{
				Path = { "GameState", "WorldUpgradesRevealed" },
				HasAll = { "WorldUpgradeAltRunDoor" },
			},
		},

		ExtraDescriptions =
		{
			{
				TextId = "FamiliarPoints_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarSystem" }
					},
					{
						Path = { "GameState", "FamiliarsUnlocked" },
						UseLength = true,
						Comparison = ">=",
						Value = 1,
					},
				},
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

				{ Cue = "/VO/Melinoe_1068", Text = "Witch's Delight.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1069", Text = "Some Witch's Delight." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},		
	},

	MysteryResource =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "GUI\\Icons\\Status\\Startled",
		TooltipId = "MysteryResourceIcon",
	},

	SuperGiftPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\SuperGiftDrop",
		TextIconPath = "Items\\Resources\\Other\\SuperGiftDrop_Text",
		TooltipId = "SuperGiftPointsIcon",
		CostTextId = "SuperGiftPoints_Short",
		AddTimerTicks = 20, -- used for text

		SpendSound = "/SFX/SuperGiftAmbrosiaBottlePickup",
		BrokerSpentVoiceLines =
		{
			[1] = { GlobalVoiceLines = "SpentSuperGiftPointsVoiceLines" },
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = { GlobalVoiceLines = "PurchasedSuperGiftPointsVoiceLines" },
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
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_0800", Text = "Ambrosia." },
			},
			[2] = { GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	CharonPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\CharonPoints",
		TextIconPath = "Items\\Resources\\Other\\CharonPoints_Text",
		TooltipId = "MysteryResourceIcon",
		CostTextId = "CharonPoints_Short",

		OnAddedFunctionName = "SetupCharonPoints",

		InventoryVoiceLines =
		{
			PlayOnce = true,
			PreLineWait = 0.55,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "CharonGrantsMailbox01" }
				}
			},
			{ Cue = "/VO/Melinoe_2623", Text = "Exclusive access to Charon's premium wares..." },
		},
	},

	TrashPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\TrashPoints",
		TextIconPath = "Items\\Resources\\Other\\TrashPoints_Text",
		TooltipId = "TrashPointsIcon",
		CostTextId = "TrashPoints_Short",

		OnAddVoiceLines =
		{
			ObjectType = "NPC_Eris_01",
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.25,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
				},

				{ Cue = "/VO/Melinoe_2440", Text = "Disgusting...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2441", Text = "{#Emph}Eugh..." },
				{ Cue = "/VO/Melinoe_2442", Text = "Such a mess..." },
				{ Cue = "/VO/Melinoe_2443", Text = "More of this filth..." },
				{ Cue = "/VO/Melinoe_1721", Text = "Such a mess." },
				{ Cue = "/VO/Melinoe_1724", Text = "I'll just clean this up...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids = { 585573, }, },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2444", Text = "Eris...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2445", Text = "Looks like Eris is back...",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "UseRecord", "NPC_Eris_01" },
						},
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
						},
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids = { 585573, }, },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2446", Text = "I'll just clean this up..." },
			},
			{
				PreLineWait = 0.25,
				PlayOnceFromTableThisRun = true,
				SuccessiveChanceToPlay = 0.05,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = { "ErisAboutWeaponGun01", }, },
					},
					{
						FunctionName = "RequiredDistanceFromHero",
						FunctionArgs = { MaxDistance = 400, },
					},
				},
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 6 },
				},
				{ Cue = "/VO/Eris_0079", Text = "Don't bother!" },
			},
		},

	},

	Money =
	{
		IconPath = "GUI\\Icons\\Currency",
		TooltipId = "Currency",
		CostTextId = "Money_Short",
		RunResource = true,
		SkipFlyToInventory = true,
		SkipInventoryObjective = true,
		SkipResourceSpendPresentation = true,
		OnAddedFunctionName = "UpdateMoneyUI",
		OnSpentFunctionName = "UpdateMoneyUI",
		IgnoreAsLastResourceGained = true,
	},
}

ResourceDisplayOrderData = 
{
	"CosmeticsPoints",

	"TrashPoints",
	"MetaCardPointsCommon",
	"MemPointsCommon",
	"MetaCurrency",

	"PlantMoney",
	"SeedMystery",
	"PlantFMoly",
	"PlantFNightshadeSeed",
	"PlantFNightshade",
	"OreFSilver",
	"FishFCommon",
	"FishFRare",
	"FishFLegendary",

	"MetaFabric",
	"GiftPoints",
	"GiftPointsRare",
	"GiftPointsEpic",
	"SuperGiftPoints",
	"PlantGrowthAccelerant",

	"MixerFBoss",

	"PlantNMoss",
	"PlantNGarlicSeed",
	"PlantNGarlic",
	"OreNBronze",
	"FishNCommon",
	"FishNRare",
	"FishNLegendary",
	"MixerNBoss",

	"PlantGLotus",
	"PlantGCattailSeed",
	"PlantGCattail",
	"OreGLime",
	"FishGCommon",
	"FishGRare",
	"FishGLegendary",
	"MixerGBoss",

	"FishBCommon",
	"FishBRare",
	"FishBLegendary",

	"PlantHMyrtle",
	"PlantHWheatSeed",
	"PlantHWheat",
	"OreHGlassrock",
	"FishHCommon",
	"FishHRare",
	"FishHLegendary",
	"MixerHBoss",

	"PlantODriftwood",
	"PlantOMandrakeSeed",
	"PlantOMandrake",
	"OreOIron",
	"FishOCommon",
	"FishORare",
	"FishOLegendary",
	"MixerOBoss",

	"PlantPIris",
	"PlantPOliveSeed",
	"PlantPOlive",
	"OrePAdamant",
	"FishPCommon",
	"FishPRare",
	"FishPLegendary",
	"MixerPBoss",

	"PlantIShaderot",
	"PlantIPoppySeed",
	"PlantIPoppy",
	"OreIMarble",
	"FishICommon",
	"FishIRare",
	"FishILegendary",
	"MixerIBoss",

	"OreChaosProtoplasm",
	"PlantChaosThalamusSeed",
	"PlantChaosThalamus",
	"FishChaosCommon",
	"FishChaosRare",
	"FishChaosLegendary",

	"CharonPoints",
	"FamiliarPoints",
	"CardUpgradePoints",
	"Mixer5Common",
	"Mixer6Common",
	"HypnosPoints",
	"MixerShadow",
	"WeaponPointsRare",
	"MixerMythic",

	"MysteryResource",
}

ScreenData.InventoryScreen =
{
	Components = {},
	BlockPause = true,

	CategoryStartX = 162,
	CategoryStartY = 149,
	CategorySpacingX = 94,

	CategoryIconScale = 0.45,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	GridStartX = 149,
	GridStartY = 252,
	GridSpacingX = 133.6,
	GridSpacingY = 143,
	GridWidth = 8,

	PinStartX = 637,
	PinStartY = 267,
	PinSpacingY = 116,
	PinResourcesOffsetX = 600,
	PinResourcesOffsetY = 0,
	PinIconOffsetX = -438,
	PinIconOffsetY = 0,
	PinIconScale = 0.7,
	PinsPerPage = 6,
	ScrollOffset = 0,
	NumItems = 0,
	PinButtons = {},

	TabStarScale = 0.75,
	TabStarOffsetY = -25,

	NewItemStarScale = 0.8,
	NewItemStarOffsetX = -42,
	NewItemStarOffsetY = -33,

	LineHistorySpacingY = 250,
	LineHistoryScrollbarSliderTopY = 280,
	LineHistoryScrollbarSliderBottomY = 844,

	IconMouseOverScale = 1.33,
	
	GamepadNavigation =
	{
		ExclusiveInteractGroup = "Combat_Menu_Overlay",
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 16,
		FreeFormSelectSuccessDistanceStep = 1,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval= 0.1,
	},

	LineHistoryScrollSpeed = 600,
	UpdateFunctionName = "InventoryScreenUpdate",

	ItemCategories =
	{
		{
			Name = "InventoryScreen_ResourcesTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Resources",
			GameStateRequirements =
			{
				-- None
			},
			"MetaCurrency",
			"MetaCardPointsCommon",
			"MemPointsCommon",
			"MetaFabric",

			"OreFSilver",
			"OreGLime",
			"OreHGlassrock",
			"OreIMarble",
			"OreNBronze",
			"OreOIron",
			"OrePAdamant",
			"OreChaosProtoplasm",

			"MixerFBoss",
			"MixerGBoss",
			"MixerHBoss",
			"MixerIBoss",
			"MixerNBoss",
			"MixerPBoss",

			"Mixer6Common",
			"MixerShadow",
			"MixerMythic",

			"CardUpgradePoints",
			"Mixer5Common",
			"WeaponPointsRare",

			"TrashPoints",
			"MysteryResource",
		},
		{
			Name = "InventoryScreen_GardenTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Reagents",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained" },
					HasAny =
					{
						"PlantMoney",
						"PlantFNightshadeSeed",
						"PlantGCattailSeed",
						"PlantHWheatSeed",
						"PlantIPoppySeed",
						"PlantNGarlicSeed",
						"PlantOMandrakeSeed",
						"PlantPOliveSeed",
						"PlantChaosThalamusSeed",
						"PlantGrowthAccelerant",
						"PlantFMoly",
						"SeedMystery",
						"PlantGLotus",
						"PlantNMoss",
						"PlantODriftwood",
						"PlantPIris",
						"PlantHMyrtle",
						"PlantIShaderot",
						"PlantFNightshade",
						"PlantGCattail",
						"PlantHWheat",
						"PlantIPoppy",
						"PlantNGarlic",
						"PlantOMandrake",
						"PlantPOlive",
						"PlantChaosThalamus",
					},
				}
			},
			"PlantFMoly",
			"PlantFNightshadeSeed",
			"PlantFNightshade",
			"PlantMoney",
			"SeedMystery",

			"PlantGLotus",
			"PlantGCattailSeed",
			"PlantGCattail",

			"PlantHMyrtle",
			"PlantHWheatSeed",
			"PlantHWheat",

			"PlantIShaderot",
			"PlantIPoppySeed",
			"PlantIPoppy",

			"PlantNMoss",
			"PlantNGarlicSeed",
			"PlantNGarlic",

			"PlantODriftwood",
			"PlantOMandrakeSeed",
			"PlantOMandrake",

			"PlantPIris",
			"PlantPOliveSeed",
			"PlantPOlive",

			"PlantChaosThalamusSeed",
			"PlantChaosThalamus",
			"PlantGrowthAccelerant",

			"MixerOBoss",
		},
		{
			Name = "InventoryScreen_GiftsTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Gifts",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained" },
					HasAny = { "GiftPoints", "GiftPointsRare", "GiftPointsEpic", "FamiliarPoints", "SuperGiftPoints", "CharonPoints" },
				}
			},
			"GiftPoints",
			"GiftPointsRare",
			"GiftPointsEpic",
			"SuperGiftPoints",
			"FamiliarPoints",
			"CharonPoints",
			"HypnosPoints",
			"CosmeticsPoints",
		},
		{
			Name = "InventoryScreen_FishTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Fish",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained" },
					HasAny = { "FishFCommon", "FishFRare", "FishFLegendary", "FishGCommon", "FishGRare", "FishGLegendary", "FishHCommon", "FishHRare", "FishHLegendary", "FishICommon", "FishIRare", "FishILegendary", "FishNCommon", "FishNRare", "FishNLegendary", "FishOCommon", "FishORare", "FishOLegendary", "FishPCommon", "FishPRare", "FishPLegendary", "FishBCommon", "FishBRare", "FishBLegendary", "FishChaosCommon", "FishChaosRare", "FishChaosLegendary", },		}
			},
			"FishFCommon",
			"FishFRare",
			"FishFLegendary",
			"FishGCommon",
			"FishGRare",
			"FishGLegendary",
			"FishHCommon",
			"FishHRare",
			"FishHLegendary",
			"FishICommon",
			"FishIRare",
			"FishILegendary",
			"FishNCommon",
			"FishNRare",
			"FishNLegendary",
			"FishOCommon",
			"FishORare",
			"FishOLegendary",
			"FishPCommon",
			"FishPRare",
			"FishPLegendary",
			"FishBCommon",
			"FishBRare",
			"FishBLegendary",
			"FishChaosCommon",
			"FishChaosRare",
			"FishChaosLegendary",
		},
		{
			Name = "InventoryScreen_PinTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-ForgetMeNots",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePinning", },
				},
			},
			Background = "GUI\\Screens\\Inventory\\Backing_ForgetMeNots",
			OpenFunctionName = "InventoryScreenDisplayPins",
			CloseFunctionName = "InventoryScreenHidePins",
			GamepadNavigation =
			{
				ExclusiveInteractGroup = "Combat_Menu_Overlay",
				FreeFormSelectWrapY = false,
				FreeFormSelectGridLock = true,
				FreeFormSelectStepDistance = 16,
				FreeFormSelectSuccessDistanceStep = 8,
				FreeFormSelectRepeatDelay = 0.6,
				FreeFormSelectRepeatInterval= 0.1,
			},
		},
		{
			Name = "InventoryScreen_LineHistoryTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Log",
			GameStateRequirements =
			{
				{
					--PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePinning", },
				},
			},
			Background = "GUI\\Screens\\Inventory\\Backing_Log",
			OpenFunctionName = "InventoryScreenDisplayLineHistory",
			CloseFunctionName = "InventoryScreenHideLineHistory",
			AlwaysShowScrollArrows = true,
			GamepadNavigation =
			{
				ExclusiveInteractGroup = "Combat_Menu_Overlay",
				FreeFormSelectWrapY = false,
				FreeFormSelectGridLock = true,
				FreeFormSelectStepDistance = 16,
				FreeFormSelectSuccessDistanceStep = 8,
				FreeFormSelectRepeatDelay = 0.6,
				FreeFormSelectRepeatInterval= 0.1,
			},
		},
	},

	ResourceCountFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		Color = Color.White,
		ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		OffsetX = 0, OffsetY = 58,
		Justification = "Center",
		FadeTarget = 1.0, FadeOpacity = 1.0,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	PinNameAffordableFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 26,
		Color = Color.CostAffordableShop,
		ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		OffsetX = -350, OffsetY = 0,
		Justification = "Left",
		FadeTarget = 1.0, FadeOpacity = 1.0,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	PinNameUnaffordableFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 26,
		Color = Color.CostUnaffordable,
		ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		OffsetX = -350, OffsetY = 0,
		Justification = "Left",
		FadeTarget = 1.0, FadeOpacity = 1.0,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	CostDisplay =
	{
		StartX = 1557,
		StartY = 540,
		SpacerX = 160,
		SpacerY = 250,
		ItemsPerRow = 2,
		InventoryAmountOffsetY = 90,
		ResourceIconOffsetY = -5,
		ResourceIconScale = 1.1,
		InventoryIconOffsetX = -25,
		InventoryIconScale = 0.45,
	},

	FreeFormSelectOffsetX = -530,
	FreeFormSelectOffsetY = 0,

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",

		Order =
		{
			"BackgroundTint",
			"ActionBarBackground",
			"Background",
			"MoonPhaseButton",
			"MoonPhaseButtonHighlight",
			"LineHistory",
			"LineHistoryGradient",
			"LineHistoryScrollbar",
			"LineHistoryScrollbarSlider",
		},

		UseNativeScreenCenter = true,

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = Color.Black,
			Alpha = 0.0,
			AlphaTarget = 0.75,
			AlphaTargetDuration = 0.25,
		},

		Background = 
		{
			AnimationName = "GUI\\Screens\\Inventory\\Backing",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				CategoryTitleText = 
				{
					TextArgs =
					{
						FontSize = 26,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						OffsetX = -830, OffsetY = -444,
						DataProperties =
						{
							OpacityWithOwner = true,
						},
					},
				},

				InfoBoxName =
				{
					OffsetX = 360,
					OffsetY = -390,
					TextArgs =
					{
						FontSize = 32,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 475,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
					}
				},
				InfoBoxDescription =
				{
					OffsetX = 360,
					OffsetY = -310,
					TextArgs =
					{
						FontSize = 24,
						Color = Color.White,
						Font = "LatoMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 475,
						LineSpacingBottom = 2,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
						VariableAutoFormat = "BoldFormatGraft",
						TextSymbolScale = 0.7,
					}
				},
				InfoBoxDetails =
				{
					OffsetX = 360,
					OffsetY = -170,
					TextArgs =
					{
						FontSize = 20,
						Color = Color.HecateVoice,
						Font = "LatoMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 475,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
						LineSpacingBottom = 2,
						VariableAutoFormat = "BoldFormatGraft",
						TextSymbolScale = 0.7,
					}
				},
				InfoBoxFlavor =
				{
					OffsetX = 360,
					OffsetY = 225,
					TextArgs =
					{
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 475,
						FontSize = 20,
						Color = Color.FlavorTextPurple,
						Font = "LatoItalic",
						ShadowBlur = 0, ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 2},
						Justification = "Left",
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
					}
				},
				
				MoonPhaseButton =
				{
					Graphic = "ButtonMoonPhase",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.5,
					OffsetX = 100,
					OffsetY = -435,
					Data =
					{
						OnMouseOverFunctionName = "InventoryScreenMoonPhaseButtonMouseOver",
						OnMouseOffFunctionName = "InventoryScreenMoonPhaseButtonMouseOff",
					},
					Text = "Inventory_MoonPhase",
					TextArgs =
					{
						Hide = true,
					},
					InteractProperties =
					{
						TooltipOffsetX = -300,
						TooltipOffsetY = 50,
					},
				},

				MoonPhaseButtonHighlight =
				{
					OffsetX = 100,
					OffsetY = -435,
					Alpha = 0.0,
					AnimationName = "GUI\\Screens\\MoonPhases\\MoonPhase_Highlight",
				},
			},
		},

		EmptyCategoryHint =
		{
			X = 620,
			Y = 480,
			Text = "InventoryScreen_NoPinsHint",
			TextArgs =
			{
				FontSize = 30,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Center",
				VerticalJustification = "Top",
				Width = 900,
				FadeOpacity = 0.0,
				FadeTarget = 0.0,
			}
		},

		LineHistory =
		{
			X = 160,
			Y = 250,
			TextArgs =
			{
				Color = Color.White,
				FontSize = 20,
				Width = 940,
				Height = 600,
				Font = "LatoMediumEventLog",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				VerticalJustification = "Top",
				DataProperties =
				{
					UseLineFading = true,
					OpacityWithOwner = true,
				},
			}
		},

		LineHistoryGradient =
		{
			AnimationName = "GUI\\Screens\\Inventory\\Text_Gradient",
			GroupName = "HUD_Backing",
			X = 621,
			Y = 406,
			Scale = 0.97,
			Alpha = 0.0,
		},

		LineHistoryScrollbar =
		{
			AnimationName = "PageScrollbar",
			--GroupName = "Combat_Menu_Overlay",
			X = 96,
			Y = 556,
			ScaleY = 1.2,
			Alpha = 0.0,
		},

		LineHistoryScrollbarSlider =
		{
			AnimationName = "PageScrollbarSlider",
			--GroupName = "Combat_Menu_Overlay",
			X = 96,
			Y = 560,
			Alpha = 0.0,
		},

		ScrollUp =
		{
			Graphic = "ButtonCodexUp",
			X = 95,
			Y = 238,
			Alpha = 0.0,
			Scale = 1.0,
			Data =
			{
				OnPressedFunctionName = "InventoryScreenScrollUp",
				ControlHotkey = "MenuUp",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
			InteractProperties =
			{
				AutoActivateWithGamepad = true,
			},
		},

		ScrollDown =
		{
			Graphic = "ButtonCodexDown",
			X = 95,
			Y = 875,
			Alpha = 0.0,
			Scale = 1.0,
			Data =
			{
				OnPressedFunctionName = "InventoryScreenScrollDown",
				ControlHotkey = "MenuDown",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
			InteractProperties =
			{
				AutoActivateWithGamepad = true,
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			BottomOffset = UIData.ActionBarBottomOffset,
			UseScreenScaleX = true,
		},

		ActionBar =
		{
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
			BottomOffset = UIData.ContextualButtonBottomOffset,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"ScrollRight",
				"ScrollLeft",
				"SelectButton",
				"PinButton",
			},

			Children = 
			{
				ScrollLeft = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "InventoryScreenPrevCategory",
						ControlHotkeys = { "MenuLeft", },
					},
					Text = "Menu_PrevCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollRight = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "InventoryScreenNextCategory",
						ControlHotkeys = { "MenuRight", },
					},
					Text = "Menu_NextCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				SelectButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						-- Dummy button
					},
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				PinButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Hotkey only
						OnPressedFunctionName = "InvenotryScreenRemovePin",
						ControlHotkeys = { "ItemPin", },
					},
					Text = "InventoryScreen_RemovePin",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				CloseButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseInventoryScreen",
						ControlHotkeys = { "Cancel", },
						MouseControlHotkeys  = { "Cancel", "Inventory", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}