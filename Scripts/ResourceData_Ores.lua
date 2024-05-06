OverwriteTableKeys( ResourceData, {
	-- Ores
	OreFSilver =
	{
		IconPath = "Items\\Resources\\Ore\\OreFSilver_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	OreGLime =
	{
		IconPath = "Items\\Resources\\Ore\\OreGLime_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	OreHGlassrock =
	{
		IconPath = "Items\\Resources\\Ore\\OreHGlassrock_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	OreIMarble =
	{
		IconPath = "Items\\Resources\\Ore\\OreIMarble_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	OreNBronze =
	{
		IconPath = "Items\\Resources\\Ore\\OreNBronze_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},		
	},

	OreOIron =
	{
		IconPath = "Items\\Resources\\Ore\\OreOIron_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	OreChaosProtoplasm =
	{
		IconPath = "Items\\Resources\\Ore\\OreChaosProtoplasm_Text",
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},
})