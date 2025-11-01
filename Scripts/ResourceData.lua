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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
				},

				{ Cue = "/VO/Melinoe_0703", Text = "Cinder.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0704", Text = "Some Cinder." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
				},

				{ Cue = "/VO/Melinoe_2736", Text = "A Pearl.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2737", Text = "Another Pearl." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MixerHBoss =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Boss\\MixerHBoss",
		TextIconPath = "Items\\Resources\\Boss\\MixerHBoss_Text",
		TooltipId = "MixerHBossIcon",
		CostTextId = "MixerHBoss_Short",

		OnAddedFunctionName = "OnMixerHBossAdded",

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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
				},

				{ Cue = "/VO/Melinoe_2732", Text = "Tears...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2733", Text = "Some Tears." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
					NamedRequirementsFalse = { "HecateMissing" },
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
				},

				{ Cue = "/VO/Melinoe_2832", Text = "Nothing but sand.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2833", Text = "Zodiac Sand." },
				{ Cue = "/VO/Melinoe_2834", Text = "Remains of Chronos..." },
				{ Cue = "/VO/Melinoe_2835", Text = "More of this Sand..." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},

		ExtraDescriptions =
		{
			{
				TextId = "MixerIBoss_ExtraDetails1",
				HideIfRequirementsFailed = true,
				Requirements =
				{
					{
						PathTrue = { "GameState", "ResourcesInEscrow", "MixerIBoss" },
					},
				},
			}
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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
				},

				{ Cue = "/VO/Melinoe_2533", Text = "Wool." },
				{ Cue = "/VO/Melinoe_2534", Text = "Some Wool.", PlayFirst = true },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
				},

				{ Cue = "/VO/Melinoe_3628", Text = "A Feather...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3629", Text = "Eagle's Feather..." },
				{ Cue = "/VO/Melinoe_3630", Text = "Feather." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MixerQBoss =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Boss\\MixerQBoss",
		TextIconPath = "Items\\Resources\\Boss\\MixerQBoss_Text",
		TooltipId = "MixerQBossIcon",
		CostTextId = "MixerQBoss_Short",

		ExtraDescriptions =
		{
			{
				TextId = "MixerQBoss_ExtraDetails1",
				HideIfRequirementsFailed = true,
				Requirements =
				{
					{
						PathTrue = { "GameState", "ResourcesInEscrow", "MixerQBoss" },
					},
				},
			}
		},

		OnAddVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "VoidLensPickupVO",
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "Resources", "MixerQBoss" },
						Comparison = ">=",
						Value = 2,
					},
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_5199", Text = "Few more of these and Gigaros can be put to the test...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "Resources", "HadesSpearPoints" },
						},
						{
							Path = { "GameState", "Resources", "MixerQBoss" },
							Comparison = "<=",
							Value = 2,
						},	
					},
				},
				{ Cue = "/VO/MelinoeField_5200", Text = "Closer to Disintegration of Monstrosity...",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
						},
						{
							PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeStormStop" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_5201", Text = "If only Zagreus could see me now...",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
						},
						{
							PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04_3" },
						},
					},
				},
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
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_4176" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
				},

				{ Cue = "/VO/Melinoe_3939", Text = "A Void Lens...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3940", Text = "Another Void Lens." },
				{ Cue = "/VO/Melinoe_3941", Text = "See that, Typhon?" },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
	BasePlant =
	{
		DebugOnly = true,
		AutoHarvestSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
	},

	PlantFMoly =
	{
		InheritFrom = { "BaseResource", "BasePlant" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0707", Text = "Moly.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0708", Text = "Another Moly." },
				{ Cue = "/VO/Melinoe_1906", Text = "More will grow in its stead." },
				{ Cue = "/VO/Melinoe_1907", Text = "For the cauldron." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantGLotus =
	{
		InheritFrom = { "BaseResource", "BasePlant" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2375", Text = "A Lotus flower." },
				{ Cue = "/VO/Melinoe_2376", Text = "Lotus." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantHMyrtle =
	{
		InheritFrom = { "BaseResource", "BasePlant" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" }
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2725", Text = "Myrtle.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2726", Text = "Some Myrtle." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantIShaderot =
	{
		InheritFrom = { "BaseResource", "BasePlant" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2824", Text = "Shaderot.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2825", Text = "Some Shaderot." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantNMoss =
	{
		InheritFrom = { "BaseResource", "BasePlant" },
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
				PreLineWait = 0.1,
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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2478", Text = "Moss." },
				{ Cue = "/VO/Melinoe_2479", Text = "Some Moss." },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlayAll = 0.15,
				ObjectTypes = { "NPC_Medea_01", "Medea" },
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MedeaSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/Medea_0311", Text = "Moss, was it?" },
				{ Cue = "/VO/Medea_0312", Text = "Fresh Moss..." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantODriftwood =
	{
		InheritFrom = { "BaseResource", "BasePlant" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3245", Text = "Driftwood." },
				{ Cue = "/VO/Melinoe_3246", Text = "Some Driftwood." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantPIris =
	{
		InheritFrom = { "BaseResource", "BasePlant" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3620", Text = "Iris." },
				{ Cue = "/VO/Melinoe_3621", Text = "An Iris.", PlayFirst = true },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantQFang =
	{
		InheritFrom = { "BaseResource", "BasePlant" },
		IconPath = "Items\\Resources\\Plant\\PlantQFang",
		TextIconPath = "Items\\Resources\\Plant\\PlantQFang_Text",
		TooltipId = "PlantQFangIcon",
		CostTextId = "PlantQFang_Short",

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3931", Text = "A Fang...!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3932", Text = "Another Fang." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	-- Plant (Grown)
	BaseSeed =
	{
		DebugOnly = true,
		AutoHarvestSound = "/SFX/ResourceGatherSFX",
	},

	PlantFNightshadeSeed =
	{
		InheritFrom = { "BaseResource", "BaseSeed" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				{ Cue = "/VO/Melinoe_2779", Text = "Nightshade Seeds.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2780", Text = "Some Nightshade Seeds." },
			},
			{ GlobalVoiceLines = "FoundSeedVoiceLines" },
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2781", Text = "Nightshade." },
				{ Cue = "/VO/Melinoe_2782", Text = "Some Nightshade." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantGCattailSeed =
	{
		InheritFrom = { "BaseResource", "BaseSeed" },
		IconPath = "Items\\Resources\\Plant\\PlantGCattailSeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantGCattailSeed_Text",
		TooltipId = "PlantGCattailSeedIcon",
		CostTextId = "PlantGCattailSeed_Short",
		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2384", Text = "Cattail seeds." },
			},
			{ GlobalVoiceLines = "FoundSeedVoiceLines" },
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},
	
	PlantHWheatSeed =
	{
		InheritFrom = { "BaseResource", "BaseSeed" },
		IconPath = "Items\\Resources\\Plant\\PlantHWheatSeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantHWheatSeed_Text",
		TooltipId = "PlantHWheatSeedIcon",
		CostTextId = "PlantHWheatSeed_Short",
		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" }
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2727", Text = "Wheat Seeds." },
			},
			{ GlobalVoiceLines = "FoundSeedVoiceLines" },
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" }
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2728", Text = "Some Wheat.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2729", Text = "Wheat for the harvest." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantIPoppySeed =
	{
		InheritFrom = { "BaseResource", "BaseSeed" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2826", Text = "Poppy-flower seeds...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2827", Text = "Seeds of the Poppy..." },
			},
			{ GlobalVoiceLines = "FoundSeedVoiceLines" },
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2828", Text = "Poppies.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2829", Text = "Fresh Poppies." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantNGarlicSeed =
	{
		InheritFrom = { "BaseResource", "BaseSeed" },
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
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlayAll = 0.15,
				ObjectTypes = { "NPC_Medea_01", "Medea" },
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MedeaSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/Medea_0309", Text = "Garlic, I think..." },
				{ Cue = "/VO/Medea_0310", Text = "{#Emph}Ooh{#Prev}, Garlic...", PlayFirst = true },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.1,
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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				{ Cue = "/VO/Melinoe_5788", Text = "A Garlic Bulb..." },
				{ Cue = "/VO/Melinoe_5789", Text = "A bulb of Garlic..." },
			},
			{ GlobalVoiceLines = "FoundSeedVoiceLines" },
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2476", Text = "Garlic." },
				{ Cue = "/VO/Melinoe_2477", Text = "Some Garlic." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantOMandrakeSeed =
	{
		InheritFrom = { "BaseResource", "BaseSeed" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3247", Text = "Mandrake Seeds." },
				{ Cue = "/VO/Melinoe_3248", Text = "Some Mandrake Seeds." },
			},
			{ GlobalVoiceLines = "FoundSeedVoiceLines" },
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0712", Text = "Mandrake Root." },
				{ Cue = "/VO/Melinoe_3249", Text = "Mandrake Root." },
				{ Cue = "/VO/Melinoe_3250", Text = "Some Mandrake Root." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantPOliveSeed =
	{
		InheritFrom = { "BaseResource", "BaseSeed" },
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3622", Text = "An Olive Branch...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3623", Text = "Another Branch..." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3624", Text = "Olives." },
				{ Cue = "/VO/Melinoe_3625", Text = "Some Olives." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantQSnakereedSeed =
	{
		InheritFrom = { "BaseResource", "BaseSeed" },
		IconPath = "Items\\Resources\\Plant\\PlantQSnakereedSeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantQSnakereedSeed_Text",
		TooltipId = "PlantQSnakereedSeedIcon",
		CostTextId = "PlantQSnakereedSeed_Short",

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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_2950", Text = "What is all this...?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "TyphonFirstResourceVO" },
				{ Cue = "/VO/Melinoe_3933", Text = "Plankton..." },
				{ Cue = "/VO/Melinoe_3934", Text = "Some Plankton..." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantQSnakereed =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Resources\\Plant\\PlantQSnakereed",
		TextIconPath = "Items\\Resources\\Plant\\PlantQSnakereed_Text",
		TooltipId = "PlantQSnakereedIcon",
		CostTextId = "PlantQSnakereed_Short",

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
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3935", Text = "A Snake-reed...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3936", Text = "Out, Snake-reed." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	PlantChaosThalamusSeed =
	{
		InheritFrom = { "BaseResource", "BaseSeed" },
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
						Comparison = "==",
						Value = 0,
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
				PreLineWait = 0.1,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2738", Text = "An Origin Seed..." },
				{ Cue = "/VO/Melinoe_2739", Text = "Some sort of Seed...", PlayFirst = true },
			},
			{ GlobalVoiceLines = "FoundSeedVoiceLines" },
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				SuccessiveChanceToPlay = 0.2,
				PreLineWait = 0.2,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2740", Text = "Thalamus..." },
				{ Cue = "/VO/Melinoe_2741", Text = "Born of Chaos...", PlayFirst = true },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	SeedMystery =
	{
		InheritFrom = { "BaseResource", "BaseSeed" },
		IconPath = "Items\\Resources\\Plant\\PlantMysterySeed",
		TextIconPath = "Items\\Resources\\Plant\\PlantMysterySeed_Text",
		TooltipId = "SeedMysteryIcon",
		CostTextId = "SeedMystery_Short",

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
			},
			{
				TextId = "SeedMystery_ExtraDetails2",
				Requirements =
				{
					{
						Path = { "GameState", "UseRecord" },
						HasAll =
						{
							"SeedMysteryRange",
						},
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			{ GlobalVoiceLines = "FoundSeedVoiceLines" },
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	-- Ores
	BaseOre =
	{
		DebugOnly = true,
		AutoHarvestSound = "/SFX/PickaxeHitSFX",
	},

	OreFSilver =
	{
		InheritFrom = { "BaseResource", "BaseOre" },

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
				-- SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0701", Text = "Silver.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0702", Text = "Some Silver." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreGLime =
	{
		InheritFrom = { "BaseResource", "BaseOre" },

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
				-- SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2377", Text = "Limestone." },
				{ Cue = "/VO/Melinoe_2378", Text = "Some Limestone." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreHGlassrock =
	{
		InheritFrom = { "BaseResource", "BaseOre" },

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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" }
					},
				},
				-- SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2730", Text = "Glassrock...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2731", Text = "Some Glassrock..." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreIMarble =
	{
		InheritFrom = { "BaseResource", "BaseOre" },

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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2830", Text = "Marble.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2831", Text = "Some Marble." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreNBronze =
	{
		InheritFrom = { "BaseResource", "BaseOre" },

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
				-- SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0705", Text = "Bronze." },
				{ Cue = "/VO/Melinoe_0795", Text = "Bronze.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0706", Text = "Some Bronze." },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlayAll = 0.15,
				ObjectTypes = { "NPC_Medea_01", "Medea" },
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MedeaSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/Medea_0313", Text = "The Bronze of the fallen...", PlayFirst = true },
				{ Cue = "/VO/Medea_0314", Text = "Leftover Bronze..." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},		
	},

	OreOIron =
	{
		InheritFrom = { "BaseResource", "BaseOre" },

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
				-- SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3251", Text = "Iron." },
				{ Cue = "/VO/Melinoe_3252", Text = "Some Iron." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OrePAdamant =
	{
		InheritFrom = { "BaseResource", "BaseOre" },

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
				-- SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3626", Text = "Adamant." },
				{ Cue = "/VO/Melinoe_3627", Text = "Some Adamant." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreQScales =
	{
		InheritFrom = { "BaseResource", "BaseOre" },

		IconPath = "Items\\Resources\\Ore\\OreQScales",
		TextIconPath = "Items\\Resources\\Ore\\OreQScales_Text",
		TooltipId = "OreQScalesIcon",
		CostTextId = "OreQScales_Short",

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
				-- SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_2950", Text = "What is all this...?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "TyphonFirstResourceVO" },
				{ Cue = "/VO/Melinoe_3937", Text = "Serpent Scales." },
				{ Cue = "/VO/Melinoe_3938", Text = "More Scales." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	OreChaosProtoplasm =
	{
		InheritFrom = { "BaseResource", "BaseOre" },

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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_4652", Text = "Flux.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_4653", Text = "Some Flux." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				TextId = "MetaCurrency_ExtraDetails2",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeUnusedWeaponBonus" },
					},
				},
			},
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
				TextId = "MetaCardPointsCommon_ExtraDetails3",
				Requirements =
				{
					{
						Path = { "GameState", "UseRecord" },
						HasAll =
						{
							"MetaCurrencyRange",
						},
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
			{
				TextId = "MetaCardPointsCommon_ExtraDetails2",
				Requirements =
				{
					{
						Path = { "GameState", "UseRecord" },
						HasAll =
						{
							"MetaCardPointsCommonRange",
						},
					},
				},
			},
			{
				TextId = "ResourceDetails_Mailbox",
				Requirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "Mailbox" }
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
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
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
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_1661", Text = "Ash of the Dead.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1662", Text = "Ashes." },
				{ Cue = "/VO/Melinoe_1663", Text = "More Ashes." },
				{ Cue = "/VO/Melinoe_1664", Text = "Ash for my Arcana.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
							Comparison = "<",
							Value = 25,
						},
					},
				},
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MemPointsCommon =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Common\\MemPointsCommon",
		TextIconPath = "Items\\Resources\\Common\\MemPointsCommon_Text",
		TooltipId = "MemPointsCommonIcon",
		CostTextId = "MemPointsCommon_Short",
		AutoHarvestSound = "/SFX/GhostEvaporate",

		ExtraDescriptions =
		{
			{
				TextId = "MemPointsCommon_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
			},
			{
				TextId = "ResourceDetails_Mailbox",
				Requirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "Mailbox" }
					},
				},
			},
			{
				TextId = "MemPointsCommon_ExtraDetails2",
				Requirements =
				{
					{
						Path = { "GameState", "TraitsTaken" },
						HasAll =
						{
							"NarcissusD",
						},
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
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_1657", Text = "Psyche.", PlayFirst = true, },
				{ Cue = "/VO/Melinoe_1658", Text = "More Psyche." },
				{ Cue = "/VO/Melinoe_1904", Text = "I'll just stash this away.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1660", Text = "The Spirits of the Dead..." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				TextId = "ResourceDetails_Mailbox",
				Requirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "Mailbox" }
					},
				},
			},
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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	CardUpgradePoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\CardUpgradePoints",
		TextIconPath = "Items\\Resources\\Other\\CardUpgradePoints_Text",
		TooltipId = "CardUpgradePointsIcon",
		CostTextId = "CardUpgradePoints_Short",
		MetaRewardStandPickupSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",

		ExtraDescriptions =
		{
			{
				TextId = "ResourceDetails_Mailbox",
				Requirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "CardUpgradePoints" },
						Comparison = ">=",
						Value = 8,
					},
					{
						PathTrue = { "GameState", "UseRecord", "Mailbox" }
					},
				},
			},
			{
				TextId = "CardUpgradePoints_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeCardUpgradePoints2" },
					}
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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
						HasNone = { "ErisGiftDecline01", "NemesisGiftDecline01", "NemesisGift02", "NyxGift02" },
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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
						HasNone = { "HecateBathHouseDecline01", "OdysseusBathHouseDecline01", "NemesisBathHouseDecline01", "ErisBathHouseDecline01", "MorosBathHouseDecline01", "SkellyBathHouseDecline01", "DoraBathHouseDecline01", "IcarusBathHouseDecline01" },
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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
						HasNone = { "HecateFishingDecline01", "OdysseusFishingDecline01", "NemesisFishingDecline01", "ErisFishingDecline01", "MorosFishingDecline01", "SkellyFishingDecline01", "DoraFishingDecline01", "IcarusFishingDecline01" },
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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeWakeHypnos" },
			},
		},

		ExtraDescriptions =
		{
			{
				TextId = "HypnosPoints_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGrantsHypnosSpell01" },
					},
				},
			},
			{
				TextId = "HypnosPoints_ExtraDetails2",
				Requirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGrantsHypnosSpell02" },
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			--
		},
	},

	MedeaPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Alchemy\\MedeaPoints",
		TextIconPath = "Items\\Resources\\Alchemy\\MedeaPoints_Text",
		TooltipId = "MedeaPointsIcon",
		CostTextId = "MedeaPoints_Short",
	},

	IcarusPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\IcarusPoints",
		TextIconPath = "Items\\Resources\\Other\\IcarusPoints_Text",
		TooltipId = "IcarusPointsIcon",
		CostTextId = "IcarusPoints_Short",

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeReviveIcarus" },
			},
		},

		OnAddVoiceLines =
		{
			--
		},
	},

	-- @ ending
	HadesSpearPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\HadesSpearPoints",
		TextIconPath = "Items\\Resources\\Other\\HadesSpearPoints_Text",
		TooltipId = "HadesSpearPointsIcon",
		-- CostTextId = "HadesSpearPoints_Short",
		AddTimerTicks = 16, -- used for text

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
			},
		},
		CostRevealRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
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
					PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
			},
			{ Cue = "/VO/Melinoe_5711", Text = "Father's spear... it has to work..." },
		},

		OnAddVoiceLines =
		{
			--
		},
	},
	DeathAreaPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\DeathAreaPoints",
		TextIconPath = "Items\\Resources\\Other\\DeathAreaPoints_Text",
		TooltipId = "DeathAreaPointsIcon",
		CostTextId = "DeathAreaPoints_Short",

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeWakeHypnosT3" },
			},
		},
		CostRevealRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeWakeHypnosT3" }
			},
		},

		InventoryVoiceLines =
		{
			PlayOnce = true,
			PreLineWait = 0.55,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "DeathAreaPoints" },
					Comparison = "<",
					Value = 1,
				},
			},
			{ Cue = "/VO/Melinoe_5713", Text = "No use searching for this now..." },
		},

		OnAddVoiceLines =
		{
			--
		},
	},

	-- Fish
	BaseFish =
	{
		DebugOnly = true,
		AutoHarvestSound = "/Leftovers/SFX/FishSpawnSplash",
	},

	FishFCommon =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishFCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishFCommon_Text",
		CostTextId = "FishFCommon_Short",
	},
	FishFRare =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishFRare",
		TextIconPath = "Items\\Resources\\Fish\\FishFRare_Text",
		CostTextId = "FishFRare_Short",
	},
	FishFLegendary =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishFLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishFLegendary_Text",
		CostTextId = "FishFLegendary_Short",
	},

	FishGCommon =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishGCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishGCommon_Text",
		CostTextId = "FishGCommon_Short",
	},
	FishGRare =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishGRare",
		TextIconPath = "Items\\Resources\\Fish\\FishGRare_Text",
		CostTextId = "FishGRare_Short",
	},
	FishGLegendary =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishGLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishGLegendary_Text",
		CostTextId = "FishGLegendary_Short",
	},

	FishHCommon =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishHCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishHCommon_Text",
		CostTextId = "FishHCommon_Short",
	},
	FishHRare =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishHRare",
		TextIconPath = "Items\\Resources\\Fish\\FishHRare_Text",
		CostTextId = "FishHRare_Short",
	},
	FishHLegendary =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishHLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishHLegendary_Text",
		CostTextId = "FishHLegendary_Short",
	},

	FishICommon =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishICommon",
		TextIconPath = "Items\\Resources\\Fish\\FishICommon_Text",
		CostTextId = "FishICommon_Short",
	},
	FishIRare =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishIRare",
		TextIconPath = "Items\\Resources\\Fish\\FishIRare_Text",
		CostTextId = "FishIRare_Short",
	},
	FishILegendary =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishILegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishILegendary_Text",
		CostTextId = "FishILegendary_Short",
	},

	FishNCommon =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishNCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishNCommon_Text",
		CostTextId = "FishNCommon_Short",
	},
	FishNRare =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishNRare",
		TextIconPath = "Items\\Resources\\Fish\\FishNRare_Text",
		CostTextId = "FishNRare_Short",
	},
	FishNLegendary =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishNLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishNLegendary_Text",
		CostTextId = "FishNLegendary_Short",
	},

	FishOCommon =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishOCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishOCommon_Text",
		CostTextId = "FishOCommon_Short",
	},
	FishORare =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishORare",
		TextIconPath = "Items\\Resources\\Fish\\FishORare_Text",
		CostTextId = "FishORare_Short",
	},
	FishOLegendary =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishOLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishOLegendary_Text",
		CostTextId = "FishOLegendary_Short",
	},

	FishPCommon =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishPCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishPCommon_Text",
		CostTextId = "FishPCommon_Short",
	},
	FishPRare =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishPRare",
		TextIconPath = "Items\\Resources\\Fish\\FishPRare_Text",
		CostTextId = "FishPRare_Short",
	},
	FishPLegendary =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishPLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishPLegendary_Text",
		CostTextId = "FishPLegendary_Short",
	},

	FishQCommon =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishQCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishQCommon_Text",
		CostTextId = "FishQCommon_Short",
	},
	FishQRare =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishQRare",
		TextIconPath = "Items\\Resources\\Fish\\FishQRare_Text",
		CostTextId = "FishQRare_Short",
	},
	FishQLegendary =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishQLegendary",
		TextIconPath = "Items\\Resources\\Fish\\FishQLegendary_Text",
		CostTextId = "FishQLegendary_Short",
	},

	FishChaosCommon =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishChaosCommon",
		TextIconPath = "Items\\Resources\\Fish\\FishChaosCommon_Text",
		CostTextId = "FishChaosCommon_Short",
	},
	FishChaosRare =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
		IconPath = "Items\\Resources\\Fish\\FishChaosRare",
		TextIconPath = "Items\\Resources\\Fish\\FishChaosRare_Text",
		CostTextId = "FishChaosRare_Short",
	},
	FishChaosLegendary =
	{
		InheritFrom = { "BaseResource", "BaseFish" },
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
		MetaRewardStandPickupSound = "/SFX/TitanBloodPickupSFX",

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
			{
				TextId = "ResourceDetails_Mailbox",
				Requirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonAboutCharonPoints01" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "Mailbox" }
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.25,
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
				{ Cue = "/VO/Melinoe_2954", Text = "From the Oath.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" }
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							IsNone = { "I_PreBoss01", "I_PreBoss02", "Q_PreBoss01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2955", Text = "A gift from Night.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" }
						},
					},
				},
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	Mixer5Common =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\Mixer5Common",
		TextIconPath = "Items\\Resources\\Other\\Mixer5Common_Text",
		TooltipId = "Mixer5CommonIcon",
		CostTextId = "Mixer5Common_Short",
		MetaRewardStandPickupSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",

		ExtraDescriptions =
		{
			{
				TextId = "Mixer5Common_ExtraDetails2",
				Requirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "Mixer5Common" },
						Comparison = ">=",
						Value = 9,
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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	Mixer6Common =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Ore\\Mixer6Common",
		TextIconPath = "Items\\Resources\\Ore\\Mixer6Common_Text",
		TooltipId = "Mixer6CommonIcon",
		CostTextId = "Mixer6Common_Short",
		AutoHarvestSound = "/SFX/KeyPickup",

		ExtraDescriptions =
		{
			{
				TextId = "Mixer6Common_ExtraDetails1",
				Requirements =
				{
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAny = { "ChaosGrantsDarkness01", "ChaosGrantsDarkness01_B" },
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
				SkipCooldownCheckIfNonePlayed = true,
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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeStormStop" },
			},
		},
		CostRevealRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeStormStop" },
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
					PathFalse = { "GameState", "ReachedTrueEnding" }
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
			},
			{ Cue = "/VO/Melinoe_5712", Text = "Negation from the present... for unraveling the past." },
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
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
				},

				{ Cue = "/VO/MelinoeField_4182", Text = "Typhon's essence... the power to stop Time...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_4180", Text = "Entropy..." },
				{ Cue = "/VO/MelinoeField_4181", Text = "This is Entropy..." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	FamiliarPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Alchemy\\FamiliarPoints",
		TextIconPath = "Items\\Resources\\Alchemy\\FamiliarPoints_Text",
		TooltipId = "FamiliarPointsIcon",
		CostTextId = "FamiliarPoints_Short",
		MetaRewardStandPickupSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",

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
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},		
	},

	MysteryResource =
	{
		InheritFrom = { "BaseResource" },
		IconPath = "Items\\Loot\\MysteryResource",
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

		ExtraDescriptions =
		{
			{
				TextId = "SuperGiftPoints_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeAmbrosia" },
					}
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
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						Path = { "CurrentRun", "HubTextLinesRecord" },
						HasNone = { "HecateTavernaDecline01", "OdysseusTavernaDecline01", "NemesisTavernaDecline01", "ErisTavernaDecline01", "MorosTavernaDecline01", "SkellyTavernaDecline01", "DoraTavernaDecline01", "IcarusTavernaDecline01", "HermesFieldGiftDecline01" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_0800", Text = "Ambrosia." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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

	GemPoints =
	{
		InheritFrom = { "BaseResource" },

		IconPath = "Items\\Resources\\Other\\GemPoints",
		TextIconPath = "Items\\Resources\\Other\\GemPoints_Text",
		TooltipId = "MysteryResourceIcon",
		CostTextId = "GemPoints_Short",
		MetaRewardStandPickupSound = "/SFX/GemPickup",

		ExtraDescriptions =
		{
			{
				TextId = "GemPoints_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeMetaRewardStands" },
					}
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.35,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_4408", Text = "Gemstones.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_4409", Text = "Some Gemstones." },
				{ Cue = "/VO/Melinoe_4410", Text = "More Gemstones." },
				{ Cue = "/VO/Melinoe_4411", Text = "Gemstones from the Earth." },
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
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
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.25,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 8 },
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
						{
							FunctionName = "RequiredQueuedTextLine",
							FunctionArgs = { IsNone = { "MorosWithEris01", "MorosWithEris02", "NemesisWithEris01", "NemesisWithEris02" }, },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2446", Text = "I'll just clean this up..." },
			},
			{
				PreLineWait = 0.25,
				BreakIfPlayed = true,
				PlayOnce = true,
				PlayOnceContext = "ErisMassTrashRemovalFirstVO",
				ObjectType = "NPC_Eris_01",
				RecheckRequirementsPostWait = true, -- force a requirement recheck once Eris is the VO "source"
				RequiredSourceValueFalse = "InPartnerConversation",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeErisTrashPickup" },
					},
				},
				TriggerCooldowns = { "ErisSpokeRecently" },

				{ Cue = "/VO/Eris_0443", Text = "No...!" },
			},
			{
				PreLineWait = 0.25,
				RandomRemaining = true,
				PlayOnceFromTableThisRun = true,
				SuccessiveChanceToPlay = 0.2,
				ObjectType = "NPC_Eris_01",
				RecheckRequirementsPostWait = true, -- force a requirement recheck once Eris is the VO "source"
				RequiredSourceValueFalse = "InPartnerConversation",
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = { "ErisAboutWeaponGun01", "ErisAboutRelationship01" }, },
					},
				},
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 6 },
				},
				TriggerCooldowns = { "MelinoeShadeInteractVoiceLines" },

				{ Cue = "/VO/Eris_0079", Text = "Don't bother!", PlayFirst = true },
				{ Cue = "/VO/Eris_0446", Text = "Help yourself!" },
				{ Cue = "/VO/Eris_0447", Text = "All yours." },
				{ Cue = "/VO/Eris_0449", Text = "Just leave it." },
				{ Cue = "/VO/Eris_0452", Text = "How'd {#Emph}that {#Prev}get there?" },
				{ Cue = "/VO/Eris_0453", Text = "How many is that?" },
				{ Cue = "/VO/Eris_0450", Text = "Leave it!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAll = { "/VO/Eris_0449" },
						},
					},
				},
				{ Cue = "/VO/Eris_0448", Text = "Missed a spot!",
					GameStateRequirements =
					{
						{
							PathNotEmpty = { "GameState", "ActiveLitter" },
						},
					},
				},
			},
		},

	},

	Money =
	{
		IconPath = "GUI\\Icons\\Currency",
		TradeIcon = "CurrencyIconTrade",
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

	"PlantQFang",
	"PlantQSnakereedSeed",
	"PlantQSnakereed",
	"OreQScales",
	"FishQCommon",
	"FishQRare",
	"FishQLegendary",
	"MixerQBoss",

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
	"IcarusPoints",
	"MedeaPoints",
	"HypnosPoints",
	"DeathAreaPoints",
	"MixerShadow",
	"WeaponPointsRare",
	"GemPoints",

	-- @ ending
	"HadesSpearPoints",
	"MixerMythic",

	"MysteryResource",
}

ScreenData.InventoryScreen =
{
	Components = {},
	BlockPause = true,
	SkipQuestStatusCheck = true,

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

	PinStartX = 614,
	PinStartY = 267,
	PinSpacingY = 116,
	PinResourcesOffsetX = 600,
	PinResourcesOffsetY = 0,
	PinIconOffsetX = -415,
	PinIconOffsetY = 0,
	PinIconScale = 0.7,
	PinTraitIconScale = 0.55,
	PinsPerPage = 6,
	ScrollOffset = 0,
	NumItems = 0,
	PinButtons = {},

	NoResourceIconAlpha = 0.15,

	SeedPinIconScale = 0.8,
	SeedPinIconOffsetX = -40,
	SeedPinIconOffsetY = -20,

	TabStarScale = 0.48,
	TabStarOffsetX = 28,
	TabStarOffsetY = -22,

	NewItemStarScale = 0.8,
	NewItemStarOffsetX = 42,
	NewItemStarOffsetY = -33,

	LineHistorySpacingY = 250,
	LineHistoryScrollbarSliderTopY = 280,
	LineHistoryScrollbarSliderBottomY = 844,

	NoRequirementsOffsetX = 224,

	IconMouseOverScale = 1.33,

	CloseAnimation = "InventoryScreenOutGrid",
	TransitionAnimationMap =
	{
		InventoryScreenOutGrid =
		{
			InventoryScreenOutLog = "InventoryScreenTransitionGridToLog",
			InventoryScreenOutBlank = "InventoryScreenTransitionGridToBlank",
		},
		InventoryScreenOutLog =
		{
			InventoryScreenOutGrid = "InventoryScreenTransitionLogToGrid",
			InventoryScreenOutBlank = "InventoryScreenTransitionLogToBlank",
		},
		InventoryScreenOutBlank =
		{
			InventoryScreenOutLog = "InventoryScreenTransitionBlankToLog",
			InventoryScreenOutGrid = "InventoryScreenTransitionBlankToGrid",
		},
	},
	FadeOutTime = 0.10,
	CloseDestroyWait = 0.35,
	
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
	LineHistoryScrollTick = 100,
	UpdateFunctionName = "InventoryScreenUpdate",

	ItemCategories =
	{
		{
			Name = "InventoryScreen_ResourcesTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Resources",
			OpenAnimation = "InventoryScreenInGrid",
			CloseAnimation = "InventoryScreenOutGrid",
			GameStateRequirements =
			{
				-- None
			},
			"MetaCurrency",
			"MetaCardPointsCommon",
			"MemPointsCommon",
			"MetaFabric",
			"GemPoints",

			"OreFSilver",
			"OreGLime",
			"OreHGlassrock",
			"OreIMarble",
			"OreNBronze",
			"OreOIron",
			"OrePAdamant",
			"PlantQFang",
			"OreQScales",
			"OreChaosProtoplasm",

			"MixerFBoss",
			"MixerGBoss",
			"MixerHBoss",
			"MixerIBoss",
			"MixerNBoss",
			"MixerPBoss",
			"MixerQBoss",

			"Mixer6Common",
			"MixerShadow",

			"CardUpgradePoints",
			"Mixer5Common",
			"WeaponPointsRare",

			"TrashPoints",
			"MysteryResource",

			-- @ ending
			"HadesSpearPoints",
			"MixerMythic",
			"DeathAreaPoints",
		},
		{
			Name = "InventoryScreen_GardenTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Reagents",
			OpenAnimation = "InventoryScreenInGrid",
			CloseAnimation = "InventoryScreenOutGrid",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained" },
					HasAny =
					{
						"PlantFNightshadeSeed",
						"PlantGCattailSeed",
						"PlantHWheatSeed",
						"PlantIPoppySeed",
						"PlantNGarlicSeed",
						"PlantOMandrakeSeed",
						"PlantPOliveSeed",
						"PlantQSnakereedSeed",
						"PlantChaosThalamusSeed",
						"PlantFMoly",
						"SeedMystery",
						"PlantGLotus",
						"PlantNMoss",
						"PlantODriftwood",
						"PlantPIris",
						"PlantQFang",
						"PlantHMyrtle",
						"PlantIShaderot",
						"PlantFNightshade",
						"PlantGCattail",
						"PlantHWheat",
						"PlantIPoppy",
						"PlantNGarlic",
						"PlantOMandrake",
						"PlantPOlive",
						"PlantQSnakereed",
						"PlantChaosThalamus",
					},
				}
			},
			"SeedMystery",
			"PlantFMoly",
			"PlantFNightshadeSeed",
			"PlantFNightshade",

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

			"MixerOBoss",

			"PlantPIris",
			"PlantPOliveSeed",
			"PlantPOlive",

			"PlantQSnakereedSeed",
			"PlantQSnakereed",

			"PlantChaosThalamusSeed",
			"PlantChaosThalamus",
		},
		{
			Name = "InventoryScreen_GiftsTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Gifts",
			OpenAnimation = "InventoryScreenInGrid",
			CloseAnimation = "InventoryScreenOutGrid",
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
			"MedeaPoints",
			"IcarusPoints",
			"HypnosPoints",
			"CosmeticsPoints",
		},
		{
			Name = "InventoryScreen_FishTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Fish",
			OpenAnimation = "InventoryScreenInGrid",
			CloseAnimation = "InventoryScreenOutGrid",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained" },
					HasAny = { "FishFCommon", "FishFRare", "FishFLegendary", "FishGCommon", "FishGRare", "FishGLegendary", "FishHCommon", "FishHRare", "FishHLegendary", "FishICommon", "FishIRare", "FishILegendary", "FishNCommon", "FishNRare", "FishNLegendary", "FishOCommon", "FishORare", "FishOLegendary", "FishPCommon", "FishPRare", "FishPLegendary", "FishQCommon", "FishQRare", "FishQLegendary", "FishChaosCommon", "FishChaosRare", "FishChaosLegendary", },	
				},
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
			"FishQCommon",
			"FishQRare",
			"FishQLegendary",
			"FishChaosCommon",
			"FishChaosRare",
			"FishChaosLegendary",
		},
		{
			Name = "InventoryScreen_PinTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-ForgetMeNots",
			OpenAnimation = "InventoryScreenInBlank",
			CloseAnimation = "InventoryScreenOutBlank",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePinning", },
				},
			},
			OpenFunctionName = "InventoryScreenDisplayPins",
			CloseFunctionName = "InventoryScreenHidePins",
			ShowPins = true,
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
			OpenAnimation = "InventoryScreenInLog",
			CloseAnimation = "InventoryScreenOutLog",
			GameStateRequirements =
			{
				{
					--PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePinning", },
				},
			},
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
		Color = {85,202,152,255},
		ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		OffsetX = -320, OffsetY = 0,
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
		Color = Color.CostUnffordableShop,
		ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		OffsetX = -320, OffsetY = 0,
		Justification = "Left",
		FadeTarget = 1.0, FadeOpacity = 1.0,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ListRequirementUnacquiredFormat =
	{
		Text = "BoonInfo_BulletPoint",
		FontSize = 22,
		OffsetX = 30,
		Color = { 72, 68, 78, 255 },
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 0},
		Justification = "Left",
		LuaKey = "TempTextData",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	CountRequirementUnacquiredFormat =
	{
		Text = "BoonInfo_CountRequirement",
		FontSize = 22,
		OffsetX = 30,
		Font = "P22UndergroundSCMedium",
		Color = { 72, 68, 78, 255 },
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 0},
		Justification = "Left",
		LuaKey = "TempTextData",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	NoRequirementsFormat =
	{
		Text = "BoonInfo_NoRequirements",
		FontSize = 24,
		Color = { 62, 58, 68, 255 },
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 0},
		Justification = "Center",
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

	FreeFormSelectOffsetX = -507,
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
			"BadgeRankIcon",
		},

		UseNativeScreenCenter = true,

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = NativeScreenCenterX,
			Y = NativeScreenCenterY,
			Color = Color.Black,
			Alpha = 0.0,
			AlphaTarget = 0.75,
			AlphaTargetDuration = 0.25,
		},

		Background = 
		{
			AnimationName = "InventoryScreenInGrid",
			X = NativeScreenCenterX,
			Y = NativeScreenCenterY,
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
						Width = 476,
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
					Alpha  = 0.0,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.6,
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

		BadgeRankIcon =
		{
			X = 1565,
			Y = 70,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.6,
			Scale = 0.67
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

		RequirementsText =
		{
			X = 1330,
			Y = 260,
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
			Graphic = "DraggableScrollBar",
			--AnimationName = "PageScrollbar",
			X = 96,
			Y = 556,
			ScaleY = 1.2,
			Alpha = 0.0,
		},

		LineHistoryScrollbarSlider =
		{
			AnimationName = "PageScrollbarSlider",
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
			},
			InteractProperties =
			{
				AutoActivateWithGamepad = true,
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = NativeScreenCenterX,
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
					Requirements =
					{
						{
							PathFromSource = true,
							PathFalse = { "Args", "CategoryLocked" },
						},
					},
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
					Requirements =
					{
						{
							PathFromSource = true,
							PathFalse = { "Args", "CategoryLocked" },
						},
					},
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
					Requirements =
					{
						{
							PathFromSource = true,
							PathTrue = { "Args", "CategoryLocked" },
						},
					},
				},

				PinButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Hotkey only
						OnPressedFunctionName = "InventoryScreenRemovePin",
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