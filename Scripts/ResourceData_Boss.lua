OverwriteTableKeys( ResourceData, {
	-- Boss
	MixerFBoss =
	{
		IconPath = "Items\\Resources\\Boss\\MixerFBoss_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	MixerGBoss =
	{
		IconPath = "Items\\Resources\\Boss\\MixerGBoss_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	MixerHBoss =
	{
		IconPath = "Items\\Resources\\Boss\\MixerHBoss_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	MixerIBoss =
	{
		IconPath = "Items\\Resources\\Boss\\MixerIBoss_Text",
		TooltipId = "MixerIBossIcon",
		CostTextId = "MixerIBoss_Short",

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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	MixerNBoss =
	{
		IconPath = "Items\\Resources\\Boss\\MixerNBoss_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	MixerOBoss =
	{
		IconPath = "Items\\Resources\\Boss\\MixerOBoss_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
})