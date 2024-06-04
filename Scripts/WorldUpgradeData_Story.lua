-- story & major progression
OverwriteTableKeys( WorldUpgradeData, 
{	
	WorldUpgradeTimeStop =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_chronos",
		Cost =
		{
			MixerIBoss = 9999,
			MixerMythic = 9999,
		},
		CostAmountTextIds =
		{
			MixerIBoss = "MysteryResource",
			MixerMythic = "MysteryResource",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChronosBossWonAgainstHim01" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MixerIBoss" },
				Comparison = ">=",
				Value = 1,
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_2823", Text = "{#Emph}Death to Chronos... {#Prev}there has to be a way..." },
		},
	},
	WorldUpgradeAltRunDoor =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		AlwaysRevealImmediately = true,
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_ward",
		Cost =
		{
			PlantFMoly = 3,
			MixerFBoss = 1,
			MixerShadow = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "HecateAboutHermes01", "HecateBossAboutHermes02" },
			},
		},

		CannotAffordVoiceLines =
		{
			{
				PlayOnce = true,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "MixerShadow" },
						Comparison = "<",
						Value = 1,
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				{ Cue = "/VO/Melinoe_2622", Text = "Must be a way I can extract pure Shadow..." },
			},
			[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_1346", Text = "I need to make my own way to the surface..." },
		},

		SkipPreRevealVoiceLines = true,
		PreRevealVoiceLines =
		{
			{
				PreLineWait = 0.05,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1770", Text = "There..." },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_2575", Text = "{#Emph}The wards for my protection I dispel, \n {#Emph}For I am ready now for heaven as for hell!" },
			}
		},
	},
	WorldUpgradeSurfacePenaltyCure =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_melcurse",
		Cost =
		{
			PlantGLotus = 2,
			PlantFNightshade = 2,
			PlantNMoss = 2,
			PlantChaosThalamus = 2,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsSurfacePenaltyCure01" },
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_1347", Text = "Can I suppress my illness on the surface...?" },
		},

		PreRevealVoiceLines =
		{
			{
				PreLineWait = 0.05,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_2576", Text = "{#Emph}My blood is bound by fate, yet blood runs free; \n {#Emph}As it would spill upon the surface, I must be." },
			}
		},
	},
	WorldUpgradeNarcissusWaters =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "KeyItem_SealedDoc",
		Cost =
		{
			PlantFMoly = 3,
			PlantOMandrake = 3,
			MixerHBoss = 3,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NarcissusWithEcho01" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_3071", Text = "I owe Narcissus crystal clarity..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,

				{ Cue = "/VO/Melinoe_3072", Text = "{#Emph}Where once shone beautiful a flower's soul, \n {#Emph}Run clear again, you waters; make him whole." },
			},
		},
	},
})