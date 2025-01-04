OverwriteTableKeys( WorldUpgradeData,
{
	-- Cosmetics
	DefaultCosmeticItem =
	{
		DebugOnly = true,
		Icon = "CosmeticIcon_SwatchTeal",
		PanDuration = 1.0,
		PreActivationHoldDuration = 0.5,
		PostActivationHoldDuration = 1.5,
		Removable = true,

		GameStateRequirements =
		{
			-- None
		},
		Cost =
		{
			CosmeticsPoints = 50,
		},

		PreRevealVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				-- SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,
				Queue = "Always",

				{ Cue = "/VO/Melinoe_1397", Text = "This sounds good." },
				{ Cue = "/VO/Melinoe_1398", Text = "Let's do it." },
				{ Cue = "/VO/Melinoe_1399", Text = "Let's try this on." },
				{ Cue = "/VO/Melinoe_1400", Text = "Sure, why not." },
				{ Cue = "/VO/Melinoe_1402", Text = "Should fit the spirit of this place..." },
				{ Cue = "/VO/Melinoe_1407", Text = "Let's try this on for size." },
				{ Cue = "/VO/Melinoe_1408", Text = "You know what? Sure." },
				{ Cue = "/VO/Melinoe_3655", Text = "Let's make it happen.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3656", Text = "How about this." },
				{ Cue = "/VO/Melinoe_3657", Text = "This seems promising.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3658", Text = "It's decided.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3659", Text = "Next renewal!" },
			},
			{
				RandomRemaining = true,
				-- SuccessiveChanceToPlay = 0.75,
				ObjectType = "NPC_Dora_01",
				Queue = "Always",

				{ Cue = "/VO/Dora_0111", Text = "Yeah, sure.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0112", Text = "Whatever you say!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0113", Text = "I mean, I guess?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0114", Text = "{#Emph}Eh{#Prev}, why not.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0247", Text = "You got it.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0251", Text = "Whatever!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0252", Text = "It's your stuff.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0253", Text = "All right, hold on.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0377", Text = "I'm into it.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
				{ Cue = "/VO/Dora_0390", Text = "Yes ma'am.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0391", Text = "Sure.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0392", Text = "Not a problem.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0393", Text = "Got it.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0394", Text = "Say no more.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0395", Text = "OK.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0396", Text = "Yep.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0397", Text = "Gotcha.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0398", Text = "Uh-huh!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
				{ Cue = "/VO/Dora_0399", Text = "Can do.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},

				-- SGV
				{ Cue = "/VO/Dora_0255", Text = "{#Emph}It shall be done.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0256", Text = "{#Emph}If that is your will.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0400", Text = "{#Emph}Very well!",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0401", Text = "{#Emph}Yesss...!",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0402", Text = "{#Emph}It shall be.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0403", Text = "{#Emph}Excellent...",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},

			},			
		},

		RevealReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.1,
				PreLineWait = 0.35,

				{ Cue = "/VO/Melinoe_1403", Text = "No harm in having just a bit of luxury..." },
				{ Cue = "/VO/Melinoe_1401", Text = "Always wanted something like this in the tent...",
					GameStateRequirements =
					{
						{
							PathFromSource = true,
							Path = { "DefaultCategoryIndex" },
							Comparison = "==",
							Value = 1,
						},
					}
				},
				{ Cue = "/VO/Melinoe_1404", Text = "That ought to raise the Shades' morale a bit...",
					GameStateRequirements =
					{
						{
							PathFromSource = true,
							Path = { "DefaultCategoryIndex" },
							Comparison = "!=",
							Value = 1,
						},
					}
				},
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.75,
				ObjectType = "NPC_Skelly_01",
				Queue = "Always",

				{ Cue = "/VO/Skelly_0118", Text = "The path to perfection!" },
				{ Cue = "/VO/Skelly_0119", Text = "The path to perfection..." },
				{ Cue = "/VO/Skelly_0016", Text = "A fine choice." },
				{ Cue = "/VO/Skelly_0129", Text = "A fine selection!" },
				{ Cue = "/VO/Skelly_0130", Text = "A fine selection." },
				{ Cue = "/VO/Skelly_0063", Text = "Excellent!" },
			},
			{
				RandomRemaining = true,
				-- SuccessiveChanceToPlay = 0.75,
				ObjectType = "NPC_Dora_01",
				Queue = "Always",

				{ Cue = "/VO/Dora_0257", Text = "Pretty spiffy.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
				{ Cue = "/VO/Dora_0258", Text = "Guess it's OK...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1402" },
						},
					},
				},
				{ Cue = "/VO/Dora_0259", Text = "None whatsoever.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1403" },
						},
					},
				},
				{ Cue = "/VO/Dora_0260", Text = "I'm right here, Mel.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1404" },
						},
					},
				},
				{ Cue = "/VO/Dora_0261", Text = "Not too shabby.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
				{ Cue = "/VO/Dora_0262", Text = "There we go.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
				{ Cue = "/VO/Dora_0263", Text = "All set.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
				{ Cue = "/VO/Dora_0264", Text = "Boom.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
				-- { Cue = "/VO/Dora_0486", Text = "{#Emph}Oh{#Prev}, I've been looking forward to this thing!", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
		},
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",
	},

	-- Mel's Tent
	Cosmetic_TentBlanket01 =
	{
		Icon = "CosmeticIcon_BlanketBasic",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566738 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Blanket_01",
		RemoveCosmetics =
		{
			"Cosmetic_TentBlanket01a",
			"Cosmetic_TentBlanket01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
		FlavorText = "Cosmetic_TentBlanket01_Flavor",
	},

	Cosmetic_TentBlanket01a =
	{
		Icon = "CosmeticIcon_BlanketDiamond",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566738 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Blanket_01a",
		RemoveCosmetics =
		{
			"Cosmetic_TentBlanket01",
			"Cosmetic_TentBlanket01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 150,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0404", Text = "Looks pretty comfy, not that I would know.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TentBlanket01b =
	{
		Icon = "CosmeticIcon_BlanketMoon",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566738 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Blanket_01b",
		RemoveCosmetics =
		{
			"Cosmetic_TentBlanket01",
			"Cosmetic_TentBlanket01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 200,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0405", Text = "Like sleeping under the Moon. Only in here.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_ApolloLyre =
	{
		Icon = "CosmeticIcon_ApolloLyre",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738376, 738377 },

		GameStateRequirements =
		{
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1700,
			MixerPBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0408", Text = "Nothing impresses like a musical instrument in the corner.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TentHangingOrnaments01 =
	{
		Icon = "CosmeticIcon_TentHangingOrnaments",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 738412,
		ActivateIds =
		{
			738418, 738420, 738415, 738412, 738413,
			738439, 738416, 738434, 738414, 738417,
		},

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 50,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0406", Text = "A witch's tent could always use more dangly stuff.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_EmployeeOfTheMonth =
	{
		Icon = "CosmeticIcon_EmployeeOfTheMonth",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738441 },

		GameStateRequirements =
		{
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 650,
		},

		RevealReactionVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "UnlockedHouseCosmetic",
				PreLineWait = 0.35,
				-- SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3672", Text = "Any relic from the House of Hades ought to be preserved." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0407", Text = "Don't know why you need {#Emph}that {#Prev}old thing, but sure.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
		},
	},

	Cosmetic_ThanPoster =
	{
		Icon = "CosmeticIcon_ThanPoster",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738440 },

		GameStateRequirements =
		{
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1100,
			MixerHBoss = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "UnlockedHouseCosmetic",
				PreLineWait = 0.35,
				-- SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3672", Text = "Any relic from the House of Hades ought to be preserved." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0486", Text = "Oh I've been looking forward to this thing!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_WitchTrinkets01 =
	{
		Icon = "CosmeticIcon_WitchTrinketEast",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738457 },

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 90,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0409", Text = "Pretty sure you need a bunch of stuff like this to be a witch.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_WitchTrinkets02 =
	{
		Icon = "CosmeticIcon_WitchTrinketWest",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738458 },

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 110,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0410", Text = "Some more knickknacks you can organize, coming right up.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TentCandle01 =
	{
		Icon = "CosmeticIcon_CandleRed",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566716, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Candle_01",
		RemoveCosmetics =
		{
			"Cosmetic_TentCandle01a",
			"Cosmetic_TentCandle01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,

		CosmeticReAddedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "CosmeticChangeVoiceLines" },
			[2] =
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				SuccessiveChanceToPlay = 0.35,

				{ Cue = "/VO/Dora_0414", Text = "Want your old candle back, we've got it handy here.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
		},
	},

	Cosmetic_TentCandle01a =
	{
		Icon = "CosmeticIcon_CandleWaxy",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566716, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Candle_01a",
		RemoveCosmetics =
		{
			"Cosmetic_TentCandle01",
			"Cosmetic_TentCandle01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 70,
			MixerFBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			[1] = { GlobalVoiceLines = "PositiveReactionVoiceLines" },
			[2] =
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0412", Text = "Now this is a real top-of-the-line candle, Mel.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
		},
	},

	Cosmetic_TentCandle01b =
	{
		Icon = "CosmeticIcon_CandleFroggy",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566716, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Candle_01b",
		RemoveCosmetics =
		{
			"Cosmetic_TentCandle01",
			"Cosmetic_TentCandle01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 140,
			MixerFBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0413", Text = "More amphibian-themed stuff, I should have known...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TentQuilt =
	{
		Icon = "CosmeticIcon_TentQuilt",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738463 },

		GameStateRequirements =
		{
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 500,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0411", Text = "Doesn't do me any good but should be softer on your feet.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TentShelf01 =
	{
		Icon = "CosmeticIcon_ShelfWood",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566827 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Shelf_01",
		RemoveCosmetics =
		{
			"Cosmetic_TentShelf01a",
			"Cosmetic_TentShelf01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,

	},

	Cosmetic_TentShelf01a =
	{
		Icon = "CosmeticIcon_ShelfDisplay",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566827 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Shelf_01a",
		RemoveCosmetics =
		{
			"Cosmetic_TentShelf01",
			"Cosmetic_TentShelf01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 400,
			CardUpgradePoints = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0415", Text = "If you're trying to keep me out of your stuff... it's not gonna work.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TentShelf01b =
	{
		Icon = "CosmeticIcon_ShelfDrawers",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566827 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Shelf_01b",
		RemoveCosmetics =
		{
			"Cosmetic_TentShelf01",
			"Cosmetic_TentShelf01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 800,
			MixerOBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0416", Text = "Great! Now you can be even {#Emph}more {#Prev}organized...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_FanPoster01 =
	{
		Icon = "CosmeticIcon_PosterScylla",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738471 },
		SetAnimationIds = { 738471 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_FanPoster_01",
		RemoveCosmetics =
		{
			"Cosmetic_FanPoster01a",
			"Cosmetic_FanPoster01b",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "G_PostBoss01" },
				Comparison = ">=",
				Value = 5,
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 300,
			MixerGBoss = 3,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3668", Text = "This is only so that I can better study my opponent." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0417", Text = "What you like or listen to is no one's business but yours. And mine.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
		},
	},

	Cosmetic_FanPoster01a =
	{
		Icon = "CosmeticIcon_PosterSelene",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738471 },
		SetAnimationIds = { 738471 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_FanPoster_01a",
		RemoveCosmetics =
		{
			"Cosmetic_FanPoster01",
			"Cosmetic_FanPoster01b",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneGift02" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 350,
			MixerFBoss = 3,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3669", Text = "Could use a scroll of Great Selene to watch over me even in here." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0418", Text = "Want to see the Moon all the time, could always leave the tent to me.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
		},
	},

	Cosmetic_FanPoster01b =
	{
		Icon = "CosmeticIcon_PosterHeracles",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738471 },
		SetAnimationIds = { 738471 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_FanPoster_01b",
		RemoveCosmetics =
		{
			"Cosmetic_FanPoster01",
			"Cosmetic_FanPoster01a",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift02" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 450,
			MixerPBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3670", Text = "A scroll of Heracles ought to inspire me to greater feats of strength." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0419", Text = "Didn't know he was your type, but believe me I get it.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
		},
	},

	Cosmetic_TentRug =
	{
		Icon = "CosmeticIcon_TentRug",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738657 },

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 100,
			MixerNBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0423", Text = "You won't stop till every bit of ground is covered in rugs, huh.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Respawn Area

	Cosmetic_FrinosRock01 =
	{
		Icon = "CosmeticIcon_FrinosRockStandard",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 576128 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Stone_04",
		RemoveCosmetics =
		{
			"Cosmetic_FrinosRock01a",
			"Cosmetic_FrinosRock01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_FrinosRock01a =
	{
		Icon = "CosmeticIcon_FrinosRockLights",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 576128 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Frinos_Rock_01",
		RemoveCosmetics =
		{
			"Cosmetic_FrinosRock01",
			"Cosmetic_FrinosRock01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 600,
		},

		OnRevealFunctionName = "FrogFamiliarReaction",
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0424", Text = "You're really pampering that frog or toad or whatever it is.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_FrinosRock01b =
	{
		Icon = "CosmeticIcon_FrinosRockLilypad",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 576128 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Frinos_Rock_02",
		RemoveCosmetics =
		{
			"Cosmetic_FrinosRock01",
			"Cosmetic_FrinosRock01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 550,
			PlantGCattail = 1,
		},

		OnRevealFunctionName = "FrogFamiliarReaction",
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0425", Text = "You trying to turn this place into a zoo or what?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_RespawnCircleFlowers =
	{
		Icon = "CosmeticIcon_RespawnCircleFlowers",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 576076,
		ActivateIds =
		{
			738407, 738408, 738381, 738393, 738385,
			738390, 738383, 738402, 738388, 738394,
			738395, 738401, 738382, 738391, 738384,
			738389, 738392, 738397, 738398, 738399,
			738380, 738403, 738404, 738387, 738406,
			738379, 738386, 738405, 738396, 738400,
		},

		GameStateRequirements =
		{
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 750,
			MixerFBoss = 5,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0426", Text = "Waking up to a bunch of flowers, that sounds nice.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_FamiliarEffigy01 =
	{
		Icon = "CosmeticIcon_FamiliarEffigyFrinos",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738482 },
		SetAnimationIds = { 738482 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_StoneStatue_01",
		RemoveCosmetics =
		{
			"Cosmetic_FamiliarEffigy01a",
			"Cosmetic_FamiliarEffigy01b",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" },
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 850,
			GiftPoints = 1,
		},

		OnRevealFunctionName = "FrogFamiliarReaction",
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0420", Text = "A shrine to all amphibians, right in our own backyard.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_FamiliarEffigy01a =
	{
		Icon = "CosmeticIcon_FamiliarEffigyRaki",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738482 },
		SetAnimationIds = { 738482 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_StoneStatue_01a",
		RemoveCosmetics =
		{
			"Cosmetic_FamiliarEffigy01",
			"Cosmetic_FamiliarEffigy01b",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "RavenFamiliar" },
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 850,
			GiftPoints = 1,
		},

		--[[
		ActivatedData =
		{
			DistanceTriggers =
			{
				{
					Repeat = true,
					WithinDistance = 420,
					VoiceLines =
					{
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_1960", Text = "Oh..." },
					}
				},
			},
			InteractDistance = 250,
			OnUsedFunctionName = "UseLockedSystemObjectPresentation",
			OnUsedFunctionArgs = { VoiceLines = "DocksDoorShutVoiceLines", },
		},
		]]--

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0421", Text = "I like to think this one's a little statue of a giant bird.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_FamiliarEffigy01b =
	{
		Icon = "CosmeticIcon_FamiliarEffigyToula",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738482 },
		SetAnimationIds = { 738482 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_StoneStatue_01b",
		RemoveCosmetics =
		{
			"Cosmetic_FamiliarEffigy01",
			"Cosmetic_FamiliarEffigy01a",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 850,
			GiftPoints = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0422", Text = "Smart, a statue of a cat won't scratch up all your stuff.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Moros Corner

	Cosmetic_MorosChaise =
	{
		Icon = "CosmeticIcon_MorosChaise",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 591108 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosGift02" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 600,
			MetaFabric = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Moros_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Moros_0295_B", Text = "The Fates bestow a gift.", PreLineAnim = "Moros_Attention" },
				-- { Cue = "/VO/Moros_0202", Text = "Thank you." },
				-- { Cue = "/VO/Moros_0204", Text = "I appreciate it." },
				-- { Cue = "/VO/Moros_0213", Text = "It's an auspicious night!" },
				-- { Cue = "/VO/Moros_0214", Text = "It's an auspicious night." },
				-- { Cue = "/VO/Moros_0295", Text = "The Fates bestow a gift." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0427", Text = "I'm guessing Horns is too stuck-up to sit, but sure.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_MorosTentCanopy =
	{
		Icon = "CosmeticIcon_MorosTentCanopy",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 566627,
		ActivateIds = { 591135, 591134, 591133 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosGift02" },
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 550,
			MetaFabric = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Moros_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Moros_0204", Text = "I appreciate it.", PreLineAnim = "Moros_Attention" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0428", Text = "Oh, Horns is gonna love this... and if not I'll take it back.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},

	},

	Cosmetic_MorosScrolls =
	{
		Icon = "CosmeticIcon_MorosScrolls",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 591112, 591111 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosGift03" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 650,
			MetaFabric = 3,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Moros_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Moros_0202", Text = "Thank you.", PreLineAnim = "Moros_Attention" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0429", Text = "Horns {#Emph}does {#Prev}seem to like having lots of reading material...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_MorosRug =
	{
		Icon = "CosmeticIcon_MorosRug",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 591114 },


		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosGift02" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 350,
			MetaFabric = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Moros_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Moros_0209", Text = "Oh!", PreLineAnim = "Moros_Attention" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0430", Text = "Got to roll out the best rugs when we've got guests.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_MorosSpools =
	{
		Icon = "CosmeticIcon_MorosSpools",
		InheritFrom = { "DefaultCosmeticItem" },
		ToggleCollision = true,
		ActivateIds = { 591113 },

		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "MorosBathHouse01", "MorosFishing01" },
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1100,
			MetaFabric = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0431", Text = "This stuff should make old Horns feel right at home.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Moros_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Moros_0365", Text = "Indeed!", PreLineAnim = "Moros_Attention" },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Nemesis Corner

	Cosmetic_NemesisChair =
	{
		Icon = "CosmeticIcon_NemesisChair",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 591248, 591249 },
		DeactivateIds =
		{
			590901, 590903, 590902,
			585037, 585039, 585040,
			585036, 585041, 561306,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 700,
			MixerHBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Nemesis_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				-- { Cue = "/VO/Nemesis_0290", Text = "Oh." },
				-- { Cue = "/VO/Nemesis_0281", Text = "{#Emph}Hm." },
				-- { Cue = "/VO/Nemesis_0293", Text = "Hey." },
				-- { Cue = "/VO/Nemesis_0294", Text = "{#Emph}Ugh..." },
				{ Cue = "/VO/Nemesis_0296", Text = "Here?" },
				-- { Cue = "/VO/Nemesis_0298", Text = "Thanks." },
				-- { Cue = "/VO/Nemesis_0299", Text = "Please." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0432", Text = "Maybe with this thing Nemesis can finally give it a rest.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_NemesisRug =
	{
		Icon = "CosmeticIcon_NemesisRug",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 591250 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 400,
			MixerNBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Nemesis_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Nemesis_0290", Text = "Oh." },
				-- { Cue = "/VO/Nemesis_0281", Text = "{#Emph}Hm." },
				-- { Cue = "/VO/Nemesis_0293", Text = "Hey." },
				-- { Cue = "/VO/Nemesis_0294", Text = "{#Emph}Ugh..." },
				-- { Cue = "/VO/Nemesis_0296", Text = "Here?" },
				-- { Cue = "/VO/Nemesis_0298", Text = "Thanks." },
				-- { Cue = "/VO/Nemesis_0299", Text = "Please." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0433", Text = "Makes sense, Nemesis already steps on everything else.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_NemesisGrindstone =
	{
		Icon = "CosmeticIcon_NemesisGrindstone",
		InheritFrom = { "DefaultCosmeticItem" },
		ToggleCollision = true,
		ActivateIds = { 591260, 591261 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NemesisTaverna01" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 500,
			MixerHBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Nemesis_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				-- { Cue = "/VO/Nemesis_0290", Text = "Oh." },
				-- { Cue = "/VO/Nemesis_0281", Text = "{#Emph}Hm." },
				-- { Cue = "/VO/Nemesis_0293", Text = "Hey." },
				-- { Cue = "/VO/Nemesis_0294", Text = "{#Emph}Ugh..." },
				-- { Cue = "/VO/Nemesis_0296", Text = "Here?" },
				{ Cue = "/VO/Nemesis_0298", Text = "Thanks." },
				-- { Cue = "/VO/Nemesis_0299", Text = "Please." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0434", Text = "Something to help keep the big girl off your case, huh?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_NemesisBraziers =
	{
		Icon = "CosmeticIcon_NemesisBraziers",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds =
		{
			738461, 738460, 738487,
			738462, 738459, 738488,
		},
		DeactivateIds = { 590206, 590287 },

		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "NemesisBathHouse01", "NemesisFishing01" },
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 800,
			MixerFBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Nemesis_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				-- { Cue = "/VO/Nemesis_0290", Text = "Oh." },
				-- { Cue = "/VO/Nemesis_0281", Text = "{#Emph}Hm." },
				-- { Cue = "/VO/Nemesis_0293", Text = "Hey." },
				{ Cue = "/VO/Nemesis_0294", Text = "{#Emph}Ugh..." },
				-- { Cue = "/VO/Nemesis_0296", Text = "Here?" },
				-- { Cue = "/VO/Nemesis_0298", Text = "Thanks." },
				-- { Cue = "/VO/Nemesis_0299", Text = "Please." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0435", Text = "I guess this ought to heat things up out there a bit.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Odysseus Corner

	Cosmetic_OdysseusRug =
	{
		Icon = "CosmeticIcon_OdysseusRug",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 591259 },

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 200,
			MixerNBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Odysseus_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Odysseus_0112", Text = "{#Emph}Ah." },
				-- { Cue = "/VO/Odysseus_0117", Text = "Hello there." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0436", Text = "Must beat having to stand around on cold, hard earth.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_OdysseusTable01 =
	{
		Icon = "CosmeticIcon_OdysseusTable01",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 561464 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Odysseus_Table_01",
		RemoveCosmetics =
		{
			"Cosmetic_OdysseusTable01a",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_OdysseusTable01a =
	{
		Icon = "CosmeticIcon_OdysseusTable01a",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 561464 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Odysseus_WarTable_01",
		RemoveCosmetics =
		{
			"Cosmetic_OdysseusTable01",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "OdysseusBathHouse01", "OdysseusFishing01" }
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1000,
			MixerOBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Odysseus_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				-- { Cue = "/VO/Odysseus_0112", Text = "{#Emph}Ah." },
				{ Cue = "/VO/Odysseus_0117", Text = "Hello there." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0437", Text = "This thing should make whoever's near it even busier.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},

	},

	Cosmetic_OdysseusVase =
	{
		Icon = "CosmeticIcon_OdysseusVase",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738483 },
		DeactivateIds = { 585085, 585082 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift04" },
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 550,
			MetaCardPointsCommon = 10,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Odysseus_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Odysseus_0112", Text = "{#Emph}Ah." },
				-- { Cue = "/VO/Odysseus_0117", Text = "Hello there." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0439", Text = "I just can't stand ceramic jars somehow, but do your thing!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Eris Corner

	Cosmetic_ErisTrashcan =
	{
		Icon = "CosmeticIcon_ErisTrashbin",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 591131 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ErisGift02" }
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "TrashPoints" },
				Comparison = ">=",
				Value = 10,
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 400,
			MixerOBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Eris_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Eris_0074", Text = "{#Emph}Ahh, heh!" },
			},
			{
				PreLineWait = 0.35,
				-- SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3671", Text = "Perhaps this will compel Eris to dispose of her rubbish properly." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0440", Text = "That's big enough to dispose of an entire body. Just saying.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- General Hub

	Cosmetic_MainHangingTassles01 =
	{
		Icon = "CosmeticIcon_MainHangingTassles01",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 576000,
		SetAnimationIds = { 576011, 576000, 576010, 575999, 585293 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_TasselRope_01",
		RemoveCosmetics =
		{
			"Cosmetic_MainHangingTassles01a",
			"Cosmetic_MainHangingTassles01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0452", Text = "I'll get some Shades to hang those up for you.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_MainHangingTassles01a =
	{
		Icon = "CosmeticIcon_MainHangingTassles01a",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 576000,
		SetAnimationIds = { 576011, 576000, 576010, 575999, 585293 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_TasselRope_01a",
		RemoveCosmetics =
		{
			"Cosmetic_MainHangingTassles01",
			"Cosmetic_MainHangingTassles01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 200,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0453", Text = "Not enough stars in the sky for you as it is, huh Mel?",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_MainHangingTassles01b =
	{
		Icon = "CosmeticIcon_MainHangingTassles01b",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 576000,
		SetAnimationIds = { 576011, 576000, 576010, 575999, 585293 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_TasselRope_01b",
		RemoveCosmetics =
		{
			"Cosmetic_MainHangingTassles01",
			"Cosmetic_MainHangingTassles01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 150,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0454", Text = "A bit of old-world charm to spruce this place right up.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_MainHangingRope01 =
	{
		Icon = "CosmeticIcon_MainHangingRope01",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 567503,
		SetAnimationIds = { 567502, 567327, 576074, 567326, 567503, 589757, 576156, 589685, 589686, 567328, 589688, 589687, 586405, 589689, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Rope_01",
		RemoveCosmetics =
		{
			"Cosmetic_MainHangingRope01a",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_MainHangingRope01a =
	{
		Icon = "CosmeticIcon_MainHangingRope01a",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 567503,
		SetAnimationIds = { 567502, 567327, 576074, 567326, 567503, 589757, 576156, 589685, 589686, 567328, 589688, 589687, 586405, 589689, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Rope_01a",
		RemoveCosmetics =
		{
			"Cosmetic_MainHangingRope01",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 450,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0455", Text = "Could always use more stuff hanging from the trees.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_RiverLanterns =
	{
		Icon = "CosmeticIcon_RiverLanterns",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 591158,
		ActivateIds =
		{
			591146, 591177, 591164, 591143,
			591176, 591184, 591167, 591185,
			591190, 591144, 591141, 591174,
			591161, 591180, 591195, 591188,
			591189, 591165, 591171, 591150,
			591192, 591159, 591183, 591191,
			591175, 591186, 591145, 591158,
			591194, 591187, 591182, 591197,
			591196, 591162, 591142, 591160,
			591157, 591178, 591173, 591166,
			591193, 591179, 591172, 591163,
		},

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 550,
			MixerFBoss = 2,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0483", Text = "{#Emph}I shall permit merely the faintest flicker!",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_MainTeaLights =
	{
		Icon = "CosmeticIcon_MainTeaLights",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 738564,
		ActivateIds =
		{
			738591, 738551, 738559, 738520,
			738568, 738565, 738573, 738585,
			738526, 738590, 738577, 738569,
			738544, 738587, 738553, 738588,
			738537, 738570, 738578, 738545,
			738550, 738571, 738523, 738527,
			738549, 738538, 738539, 738584,
			738560, 738532, 738546, 738535,
			738576, 738581, 738556, 738582,
			738552, 738557, 738583, 738528,
			738572, 738567, 738524, 738548,
			738519, 738542, 738534, 738586,
			738547, 738558, 738529, 738555,
			738554, 738566, 738533, 738575,
			738541, 738536, 738531, 738530,
			738589, 738522, 738564, 738540,
		},

		GameStateRequirements =
		{
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1600,
			MixerFBoss = 1,
			Mixer5Common = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0481", Text = "This ought to liven up the place, or brighten it at least.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_MainLanterns01 =
	{
		Icon = "CosmeticIcon_MainLanterns01",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 561185,
		SetAnimationIds = { 576309, 585190, 561185, 561184, 588785, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Lantern_01",
		RemoveCosmetics =
		{
			"Cosmetic_MainLanterns01a",
			"Cosmetic_MainLanterns01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_MainLanterns01a =
	{
		Icon = "CosmeticIcon_MainLanterns01a",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 561185,
		SetAnimationIds = { 576309, 585190, 561185, 561184, 588785, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Lantern_02",
		RemoveCosmetics =
		{
			"Cosmetic_MainLanterns01",
			"Cosmetic_MainLanterns01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 450,
			MixerPBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0484", Text = "{#Emph}A pittance of a light within the infinite dark of existence!",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_MainLanterns01b =
	{
		Icon = "CosmeticIcon_MainLanterns01b",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 561185,
		SetAnimationIds = { 576309, 585190, 561185, 561184, 588785, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Lantern_03",
		RemoveCosmetics =
		{
			"Cosmetic_MainLanterns01",
			"Cosmetic_MainLanterns01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 400,
			CardUpgradePoints = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0457", Text = "Who needs the lights we've got when we can get new ones?",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_BrokerRug =
	{
		Icon = "CosmeticIcon_BrokerRug",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738485 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" }
			},
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 100,
			MixerNBoss = 1,
		},

		OnRevealFunctionName = "WretchedBrokerReaction",
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0458", Text = "Just so you know, the Broker's floating slightly aboveground.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Cauldron Area

	Cosmetic_Cauldron01 =
	{
		Icon = "CosmeticIcon_Cauldron01",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 558175 },
		SetAnimationValue = "CriticalItemWorldObject01",
		ActivateFunctionName = "ApplyCauldronCookTopGraphic",
		RemoveCosmetics =
		{
			"Cosmetic_Cauldron01a",
			"Cosmetic_Cauldron01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_Cauldron01a =
	{
		Icon = "CosmeticIcon_Cauldron01a",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 558175 },
		SetAnimationValue = "CriticalItemWorldObject01a",
		ActivateFunctionName = "ApplyCauldronCookTopGraphic",
		RemoveCosmetics =
		{
			"Cosmetic_Cauldron01",
			"Cosmetic_Cauldron01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 4200,
			Mixer5Common = 5,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Hecate_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Hecate_0739", Text = "The stars themselves..." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0441", Text = "This make your incantations any better, or just for show?",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_Cauldron01b =
	{
		Icon = "CosmeticIcon_Cauldron01b",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 558175 },
		SetAnimationValue = "CriticalItemWorldObject01b",
		ActivateFunctionName = "ApplyCauldronCookTopGraphic",
		RemoveCosmetics =
		{
			"Cosmetic_Cauldron01",
			"Cosmetic_Cauldron01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 4400,
			MixerShadow = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Hecate_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Hecate_0740", Text = "Rest well, Python..." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0442", Text = "Bet you can cook up some {#Emph}real {#Prev}nasty curses in this baby.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CauldronRing01 =
	{
		Icon = "CosmeticIcon_CauldronRing01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 575850 },
		DeactivateIds = { 738432, 738433 },
		RemoveCosmetics =
		{
			"Cosmetic_CauldronRing01a",
			"Cosmetic_CauldronRing01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_CauldronRing01a =
	{
		Icon = "CosmeticIcon_CauldronRing01a",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738432 },
		DeactivateIds = { 575850, 738433 },
		RemoveCosmetics =
		{
			"Cosmetic_CauldronRing01",
			"Cosmetic_CauldronRing01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 500,
			CardUpgradePoints = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Hecate_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Hecate_0741", Text = "Oh!" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0444", Text = "Just can't go wrong with Moon-themed stuff I guess.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CauldronRing01b =
	{
		Icon = "CosmeticIcon_CauldronRing01b",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738433 },
		DeactivateIds = { 575850, 738432 },
		RemoveCosmetics =
		{
			"Cosmetic_CauldronRing01",
			"Cosmetic_CauldronRing01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 550,
			MixerOBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Hecate_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Hecate_0742", Text = "A welcome change." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0445", Text = "Don't think the head witch is too big on flowers but... OK.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CauldronPillars01 =
	{
		Icon = "CosmeticIcon_CauldronPillars01",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 575873,
		SetAnimationIds = { 575834, 575871, 575872, 575874, 575873, 575832, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Pillar_01",
		RemoveCosmetics =
		{
			"Cosmetic_CauldronPillars01a",
			"Cosmetic_CauldronPillars01b",
			"Cosmetic_CauldronPillars01c",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_CauldronPillars01a =
	{
		Icon = "CosmeticIcon_CauldronPillars01a",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 575873,
		SetAnimationIds = { 575834, 575871, 575872, 575874, 575873, 575832, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Pillar_01b",
		RemoveCosmetics =
		{
			"Cosmetic_CauldronPillars01",
			"Cosmetic_CauldronPillars01b",
			"Cosmetic_CauldronPillars01c",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 600,
			Mixer6Common = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0446", Text = "We want to keep things nice and dark around here, right?",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CauldronPillars01b =
	{
		Icon = "CosmeticIcon_CauldronPillars01b",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 575873,
		SetAnimationIds = { 575834, 575871, 575872, 575874, 575873, 575832, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Pillar_01c",
		RemoveCosmetics =
		{
			"Cosmetic_CauldronPillars01",
			"Cosmetic_CauldronPillars01a",
			"Cosmetic_CauldronPillars01c",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 650,
			CardUpgradePoints = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0447", Text = "Should make things look a little classier maybe?",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CauldronPillars01c =
	{
		Icon = "CosmeticIcon_CauldronPillars01c",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 575873,
		SetAnimationIds = { 575834, 575871, 575872, 575874, 575873, 575832, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Pillar_01d",
		RemoveCosmetics =
		{
			"Cosmetic_CauldronPillars01",
			"Cosmetic_CauldronPillars01a",
			"Cosmetic_CauldronPillars01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 700,
			MixerIBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0448", Text = "Old architecture always has a certain charm, I guess!",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Hot Springs

	Cosmetic_BathChangingScreens =
	{
		Icon = "CosmeticIcon_BathChangingScreens",
		InheritFrom = { "DefaultCosmeticItem" },
		PanDuration = 1.5,
		CameraFocusId = 738446,
		ActivateIds = { 738456, 738451, 738446 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" }
			},
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 200,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0449", Text = "Not like anybody's gonna use these but they do look nice!",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_BathTowelRacks =
	{
		Icon = "CosmeticIcon_BathTowelRacks",
		InheritFrom = { "DefaultCosmeticItem" },
		PanDuration = 1.5,
		CameraFocusId = 738448,
		ActivateIds = { 738455, 738450, 738454, 738447, 738449, 738448 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" }
			},
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 250,
			MixerGBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0450", Text = "Who needs Shades to hold your towels when there's {#Emph}this?",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_BathSoaps =
	{
		Icon = "CosmeticIcon_BathSoaps",
		InheritFrom = { "DefaultCosmeticItem" },
		PanDuration = 1.5,
		ActivateIds = { 738659 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" }
			},
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 350,
			GiftPointsRare = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0451", Text = "If you're gonna bother with a bath, might as well go all out.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Hypnos Corner

	Cosmetic_HypnosLanterns01 =
	{
		Icon = "CosmeticIcon_HypnosLanterns01",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 590956,
		SetAnimationIds = { 586054, 585192, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Lantern_01",
		RemoveCosmetics =
		{
			"Cosmetic_HypnosLanterns01a",
			"Cosmetic_HypnosLanterns01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_HypnosLanterns01a =
	{
		Icon = "CosmeticIcon_HypnosLanterns01a",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 590956,
		SetAnimationIds = { 586054, 585192, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Hypnos_Lantern_01",
		RemoveCosmetics =
		{
			"Cosmetic_HypnosLanterns01",
			"Cosmetic_HypnosLanterns01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HypnosGift01" }
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 300,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0459", Text = "{#Emph}Ooh{#Prev}, I happen to like these. Good pick.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_HypnosLanterns01b =
	{
		Icon = "CosmeticIcon_HypnosLanterns01b",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 590956,
		SetAnimationIds = { 586054, 585192, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Hypnos_Lantern_02",
		RemoveCosmetics =
		{
			"Cosmetic_HypnosLanterns01",
			"Cosmetic_HypnosLanterns01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HypnosGift01" }
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 350,
			MixerOBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0460", Text = "The soft and delicate approach, don't see why not.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_HypnosPillars01 =
	{
		Icon = "CosmeticIcon_HypnosPillars01",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 370024,
		SetAnimationIds = { 575845, 575841, 585787, 575843, 575831, 586074, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Pillar_01",
		RemoveCosmetics =
		{
			"Cosmetic_HypnosPillars01a",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_HypnosPillars01a =
	{
		Icon = "CosmeticIcon_HypnosPillars01a",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 370024,
		SetAnimationIds = { 575845, 575841, 585787, 575843, 575831, 586074, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Pillar_01a",
		RemoveCosmetics =
		{
			"Cosmetic_HypnosPillars01",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HypnosGift01" }
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 650,
			MixerHBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0461", Text = "A bit of rustic elegance to spruce this place right up!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_HypnosRug =
	{
		Icon = "CosmeticIcon_HypnosRug",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738489 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HypnosGift01" }
			},
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 200,
			MixerNBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0462", Text = "Don't know why we need a rug there but OK.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Fishing Area

	Cosmetic_Aquarium =
	{
		Icon = "CosmeticIcon_Aquarium",
		InheritFrom = { "DefaultCosmeticItem" },
		PanDuration = 1.5,
		ToggleCollision = true,
		ActivateIds = { 738445, 738444 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" }
			},
			{
				Path = { "CurrentRun", "FishingSuccesses" },
				Comparison = ">=",
				Value = 5,
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1000,
			GiftPointsEpic = 1,
			MixerGBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0463", Text = "Seems like a good alternative to swimming in the river over there.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Taverna

	Cosmetic_TavernaTables01 =
	{
		Icon = "CosmeticIcon_TavernaTables01",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 585757, 585754, 585761, 566359, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_04",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaTables01a",
			"Cosmetic_TavernaTables01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_TavernaTables01a =
	{
		Icon = "CosmeticIcon_TavernaTables01a",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 585757, 585754, 585761, 566359, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_04a",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaTables01",
			"Cosmetic_TavernaTables01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" }
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1200,
			SuperGiftPoints = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0464", Text = "Not only do these {#Emph}look {#Prev}nice but they help with cleanup too.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TavernaTables01b =
	{
		Icon = "CosmeticIcon_TavernaTables01b",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 585757, 585754, 585761, 566359, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_04b",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaTables01",
			"Cosmetic_TavernaTables01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" }
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1400,
			CardUpgradePoints = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0465", Text = "The Shades in the taverna all the time are gonna {#Emph}love {#Prev}these.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TavernaChairs01 =
	{
		Icon = "CosmeticIcon_TavernaChairs01",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566374, 566377, 585764, 585753, 585756, 585760, 585763, 585759, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Chair_01",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaChairs01a",
			"Cosmetic_TavernaChairs01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_TavernaChairs01a =
	{
		Icon = "CosmeticIcon_TavernaChairs01a",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566374, 566377, 585764, 585753, 585756, 585760, 585763, 585759, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Chair_01a",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaChairs01",
			"Cosmetic_TavernaChairs01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" }
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 600,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0466", Text = "A good seat isn't just for sitting, it's for making a statement.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TavernaChairs01b =
	{
		Icon = "CosmeticIcon_TavernaChairs01b",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566374, 566377, 585764, 585753, 585756, 585760, 585763, 585759, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Chair_01b",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaChairs01",
			"Cosmetic_TavernaChairs01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" }
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 700,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0467", Text = "Should be easier to clean spills off of these, at least.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TavernaStarMosaic =
	{
		Icon = "CosmeticIcon_TavernaStarMosaic",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 738509 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" }
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1500,
			MixerFBoss = 1,
			MixerHBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0469", Text = "Going for more of a modern look in the old taverna, huh?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- PreRun

	Cosmetic_SkellyFloor01 =
	{
		Icon = "CosmeticIcon_SkellyFloor01",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 587209 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_CardAltar_03a",
		RemoveCosmetics =
		{
			"Cosmetic_SkellyFloor01a",
			"Cosmetic_SkellyFloor01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_SkellyFloor01a =
	{
		Icon = "CosmeticIcon_SkellyFloor01a",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 587209 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Terrain_Cobblestone_01",
		RemoveCosmetics =
		{
			"Cosmetic_SkellyFloor01",
			"Cosmetic_SkellyFloor01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 220,
			MixerHBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Skelly_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Skelly_0256", Text = "{#Emph}Ooh{#Prev}, scary..." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0470", Text = "A more-imposing place for the good Commander to stand.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_SkellyFloor01b =
	{
		Icon = "CosmeticIcon_SkellyFloor01b",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 587209 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Terrain_Cobblestone_02",
		RemoveCosmetics =
		{
			"Cosmetic_SkellyFloor01",
			"Cosmetic_SkellyFloor01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 240,
			MixerFBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Skelly_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Skelly_0200", Text = "Oh dang!" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0471", Text = "Old-world decor for an old-timer like the Commander there.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TrainingDummy01 =
	{
		Icon = "CosmeticIcon_TrainingDummy01",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 566610,
		SetAnimationIds = { 566610, 566612, 567196, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_TrainingDummy_01",
		RemoveCosmetics =
		{
			"Cosmetic_TrainingDummy01a",
			"Cosmetic_TrainingDummy01b",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_TrainingDummy01a =
	{
		Icon = "CosmeticIcon_TrainingDummy01a",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 566610,
		SetAnimationIds = { 566610, 566612, 567196, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_TrainingDummy_01a",
		RemoveCosmetics =
		{
			"Cosmetic_TrainingDummy01",
			"Cosmetic_TrainingDummy01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 5,
			},
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 4000,
			MixerIBoss = 3,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Skelly_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Skelly_0216", Text = "{#Emph}Ahh{#Prev}, yes!" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0472", Text = "If you can't beat up the real thing, these will have to do.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_TrainingDummy01b =
	{
		Icon = "CosmeticIcon_TrainingDummy01b",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 566610,
		SetAnimationIds = { 566610, 566612, 567196, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_TrainingDummy_01b",
		RemoveCosmetics =
		{
			"Cosmetic_TrainingDummy01",
			"Cosmetic_TrainingDummy01a",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SkellyGift06" },
			},
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 3000,
			MixerPBoss = 3,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Skelly_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Skelly_0157", Text = "Yeah!" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0473", Text = "Good luck figuring out which one's the real dummy now.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CatScratcher =
	{
		Icon = "CosmeticIcon_CatScratcher",
		InheritFrom = { "DefaultCosmeticItem" },
		ToggleCollision = true,
		ActivateIds = { 589855, 589856 },

		OnRevealFunctionName = "FamiliarCosmeticReaction",
		OnRevealFunctionArgs = { PreWait = 0.5, AngleTowardId = 589855 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1700,
			MixerNBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0474", Text = "No self-respecting cat has ever used one of these things...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},
	Cosmetic_BirdHouse =
	{
		Icon = "CosmeticIcon_BirdHouse",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 589857, 589858 },

		OnRevealFunctionName = "FamiliarCosmeticReaction",
		OnRevealFunctionArgs = { FamiliarType = "RavenFamiliar", PreWait = 0.5, AngleTowardId = 589857 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "RavenFamiliar" },
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1300,
			GiftPoints = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0475", Text = "Don't get too many birds around here but why not?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},
	Cosmetic_ExitCharm =
	{
		Icon = "CosmeticIcon_ExitCharm",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 589859, 589860 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" },
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 2000,
			WeaponPointsRare = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0476", Text = "Something to remember us by before you head out?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

})

ScreenData.CosmeticsShop =
{
	BlockPause = true,

	ItemCategories =
	{
		{
			-- NOTE: when adding, please also update GameData.AllPurchaseableCosmetics!!
			Name = "CosmeticsShop_Tent",
			GameStateRequirements =
			{
				-- None
			},

			-- Mel's Tent
			"Cosmetic_TentBlanket01",
			"Cosmetic_TentBlanket01a",
			"Cosmetic_TentBlanket01b",
			"Cosmetic_ApolloLyre",
			"Cosmetic_TentHangingOrnaments01",
			"Cosmetic_EmployeeOfTheMonth",
			"Cosmetic_ThanPoster",
			"Cosmetic_WitchTrinkets01",
			"Cosmetic_WitchTrinkets02",
			"Cosmetic_TentCandle01",
			"Cosmetic_TentCandle01a",
			"Cosmetic_TentCandle01b",
			"Cosmetic_TentQuilt",
			"Cosmetic_TentShelf01",
			"Cosmetic_TentShelf01a",
			"Cosmetic_TentShelf01b",
			"Cosmetic_FanPoster01",
			"Cosmetic_FanPoster01a",
			"Cosmetic_FanPoster01b",
			"Cosmetic_TentRug",

			-- Respawn Area
			"Cosmetic_FrinosRock01",
			"Cosmetic_FrinosRock01a",
			"Cosmetic_FrinosRock01b",
			"Cosmetic_RespawnCircleFlowers",
			"Cosmetic_FamiliarEffigy01",
			"Cosmetic_FamiliarEffigy01a",
			"Cosmetic_FamiliarEffigy01b",
		},		
		{
			Name = "CosmeticsShop_Main",
			GameStateRequirements =
			{
				-- None
			},

			-- Moros Corner
			"Cosmetic_MorosChaise",
			"Cosmetic_MorosTentCanopy",
			"Cosmetic_MorosScrolls",
			"Cosmetic_MorosRug",
			"Cosmetic_MorosSpools",

			-- Nemesis Corner
			"Cosmetic_NemesisChair",
			"Cosmetic_NemesisRug",
			"Cosmetic_NemesisGrindstone",
			"Cosmetic_NemesisBraziers",

			-- Odysseus Corner
			"Cosmetic_OdysseusRug",
			"Cosmetic_OdysseusTable01",
			"Cosmetic_OdysseusTable01a",
			"Cosmetic_OdysseusVase",

			-- Eris Corner
			"Cosmetic_ErisTrashcan",

			-- General
			"Cosmetic_MainHangingTassles01",
			"Cosmetic_MainHangingTassles01a",
			"Cosmetic_MainHangingTassles01b",
			"Cosmetic_MainHangingRope01",
			"Cosmetic_MainHangingRope01a",
			"Cosmetic_RiverLanterns",
			"Cosmetic_MainTeaLights",
			"Cosmetic_MainLanterns01",
			"Cosmetic_MainLanterns01a",
			"Cosmetic_MainLanterns01b",
			"Cosmetic_BrokerRug",

			-- Cauldron
			"Cosmetic_Cauldron01",
			"Cosmetic_Cauldron01a",
			"Cosmetic_Cauldron01b",
			"Cosmetic_CauldronRing01",
			"Cosmetic_CauldronRing01a",
			"Cosmetic_CauldronRing01b",
			"Cosmetic_CauldronPillars01",
			"Cosmetic_CauldronPillars01a",
			"Cosmetic_CauldronPillars01b",
			"Cosmetic_CauldronPillars01c",

			-- Hypnos Corner
			"Cosmetic_HypnosLanterns01",
			"Cosmetic_HypnosLanterns01a",
			"Cosmetic_HypnosLanterns01b",
			"Cosmetic_HypnosPillars01",
			"Cosmetic_HypnosPillars01a",
			"Cosmetic_HypnosRug",

			-- Hot Springs
			"Cosmetic_BathChangingScreens",
			"Cosmetic_BathTowelRacks",
			"Cosmetic_BathSoaps",

			-- Fishing Pier
			"Cosmetic_Aquarium",

			-- Taverna
			"Cosmetic_TavernaTables01",
			"Cosmetic_TavernaTables01a",
			"Cosmetic_TavernaTables01b",
			"Cosmetic_TavernaChairs01",
			"Cosmetic_TavernaChairs01a",
			"Cosmetic_TavernaChairs01b",
			"Cosmetic_TavernaStarMosaic",
		},
		{
			Name = "CosmeticsShop_PreRun",
			GameStateRequirements =
			{
				-- None
			},

			"Cosmetic_SkellyFloor01",
			"Cosmetic_SkellyFloor01a",
			"Cosmetic_SkellyFloor01b",
			"Cosmetic_TrainingDummy01",
			"Cosmetic_TrainingDummy01a",
			"Cosmetic_TrainingDummy01b",
			"Cosmetic_CatScratcher",
			"Cosmetic_BirdHouse",
			"Cosmetic_ExitCharm",
		},
	},

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 4,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	CategoryStartX = 130,
	CategoryStartY = 100,
	CategorySpacingX = 94,

	CategoryIconScale = 0.40,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	ItemStartX = 515,
	ItemStartY = 230,
	ItemSpacingY = 110,
	IconOffsetX = -388,
	IconOffsetY = -1,
	IconScale = 0.7,
	ItemsPerPage = 5,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = -470,
	ScrollbarSliderTopY = 210,
	ScrollbarSliderBottomY = 690,

	ItemAvailableAffordableNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = {85,202,152,255},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemAvailableUnaffordableNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = Color.CostUnffordableShop,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemPurchasedNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = {200,200,200,255},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemStateFormat =
	{
		OffsetX = 310,
		OffsetY = 0,
		FontSize = 28,
		Color = Color.White,
		Font = "LatoBold",
		Justification = "Center",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	PinOffsetX = 200,

	Components = {},

	SaleData = {},
	NumSales = 0,
	NumItemsOffered = 0,

	TooltipX = 1690,
	TooltipY = 700,

	CostDisplay =
	{
		StartX = 450,
		StartY = 848,
		SpacerX = 160,
		InventoryAmountOffsetY = 90,
		ResourceIconOffsetY = -5,
		ResourceIconScale = 1.1,
		InventoryIconOffsetX = -25,
		InventoryIconScale = 0.45,
	},

	ItemAvailableAnimation = "GUI\\Screens\\CriticalItemShop\\Button",
	ItemAvailableHighlightAnimation = "GUI\\Screens\\CriticalItemShop\\Button_Highlight",
	ItemPurchasedAnimation = "GUI\\Screens\\CriticalItemShop\\Button",
	ItemPurchasedHighlightAnimation = "GUI\\Screens\\CriticalItemShop\\Button_Highlight",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"ShopBackgroundDim",
			"ListBackground",
			"InfoBoxBacking",
			"Scrollbar",
			"ScrollbarSlider",
			"ScrollUp",
			"ScrollDown",
		},

		ShopBackgroundDim = 
		{
			Graphic = "rectangle01",
			AnimationName = "WeaponShopVignette",
			ScaleX = 30.0,
			ScaleY = 30.0,
			X = ScreenCenterX + 300,
			Y = ScreenCenterY,
			Color = { 1.0, 1.0, 1.0, 0.8 },
		},

		ListBackground = 
		{
			Graphic = "WeaponShopBacking",
			GroupName = "Combat_Menu",
			X = 400,
			Y = 430,
			ScaleY = 0.77,
		},

		ResourceCostBacking =
		{
			Graphic = "WeaponShopBacking",
			GroupName = "Combat_Menu",
			X = 300,
			Y = 860,
			ScaleY = 0.3,
			ScaleX = 0.6,
			Alpha = 0.0,
		},

		InfoBoxBacking = 
		{
			AnimationName = "GUI\\Screens\\CriticalItemShop\\Backing_Scroll",
			X = 1165,
			Y = 790,
			Alpha = 0.0,
			Children = 
			{
				InfoBoxDescription =
				{ 
					OffsetX = -282,
					OffsetY = -100,
					TextArgs =
					{
						FontSize = 20,
						Color = Color.Black,
						Font = "LatoMedium",
						VariableAutoFormat = "BoldFormatGraftDark",
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 568,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
						LineSpacingBottom = 5,
						TextSymbolScale = 0.8,
					}
				},

				InfoBoxFlavor =
				{
					OffsetX = -282,
					OffsetY = 20,
					TextArgs =
					{
						FontSize = 18,
						Color = Color.FlavorTextPurple,
						Font = "LatoItalic",
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 568,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
					}
				},

			},
		},

		CategoryTitleText = 
		{
			X = 80,
			Y = 50,
			TextArgs =
			{
				FontSize = 26,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		Scrollbar =
		{
			AnimationName = "PageScrollbar",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 450,
			Alpha = 0.0,
		},

		ScrollbarSlider =
		{
			AnimationName = "PageScrollbarSlider",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 210,
			Alpha = 0.0,
		},
		
		ScrollUp =
		{
			Graphic = "BlankInteractableObstacle",
			AnimationName = "CodexButton_Up",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 210,
			Alpha = 0.0,
			Scale = 0.85,
			HighlightedScale = 1.5, -- relative to Scale
			Data =
			{
				OnMouseOverFunctionName = "GhostAdminMouseOverScrollArrow",
				OnMouseOffFunctionName = "GhostAdminMouseOffScrollArrow",
				OnPressedFunctionName = "MusicPlayerScrollUp",
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
			Graphic = "BlankInteractableObstacle",
			AnimationName = "CodexButton_Down",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 695,
			Alpha = 0.0,
			Scale = 0.85,
			HighlightedScale = 1.5, -- relative to Scale
			Data =
			{
				OnMouseOverFunctionName = "GhostAdminMouseOverScrollArrow",
				OnMouseOffFunctionName = "GhostAdminMouseOffScrollArrow",
				OnPressedFunctionName = "MusicPlayerScrollDown",
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
			Y = UIData.ActionBarY,
		},

		ActionBar =
		{
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"SelectButton",
				"PinButton",
			},

			Children =
			{
				PinButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Hotkey only
						OnPressedFunctionName = "GhostAdminPinItem",
						ControlHotkeys = { "ItemPin", },
					},
					Text = "Menu_Pin",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				SelectButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Menu_CosmeticsUnlock",
					TextArgs = UIData.ContextualButtonFormatRight,
					AltTexts = { "Menu_CosmeticsReAdd", "Menu_CosmeticsRemove" },
				},

				CloseButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseGhostAdminScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			}
		}
	},

	AngleHeroTowardTarget = true,
	-- OpenPlayerAnimation = "MelTalkBrooding01",
	-- handled in GhostAdminScreenClosedPresentation()
	-- ClosePlayerAnimation = "MelTalkBrooding01ReturnToIdle",
	OpenSound = "/Leftovers/World Sounds/RonEnter",
	CloseSound = "/Leftovers/World Sounds/Caravan Interior/SteamAcidForage",
	CosmeticsOpenVoiceLines = 
	{
		Cooldowns =
		{
			{ Name = "MelCosmeticsOpenedSpeech", Time = 60 },
		},
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlayAll = 0.75,
				ObjectType = "NPC_Dora_01",
				GameStateRequirements =
				{
					NamedRequirements = { "CosmeticsShopHasNewItems" },
				},

				{ Cue = "/VO/Dora_0271", Text = "{#Emph}Mm{#Prev}, look at what we got.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0272", Text = "Got some new stuff here.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0273", Text = "Check this out.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0274", Text = "Here's the latest.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0275", Text = "{#Emph}Behold, my latest works.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0276", Text = "{#Emph}Witness my offerings!",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.66,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0108", Text = "So, {#Emph}uh, {#Prev}what's up?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0109", Text = "What's going on, Mel.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0239", Text = "What's it going to be?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0240", Text = "Any of these?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				  GameStateRequirements = { NamedRequirements = { "CosmeticsShopHasUnpurchasedItems" } },
				},
				{ Cue = "/VO/Dora_0241", Text = "What are we thinking?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0242", Text = "Want to... mix things up?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0243", Text = "Time to move stuff around?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0244", Text = "You know the drill.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0354", Text = "See anything you like?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
							},
				{ Cue = "/VO/Dora_0355", Text = "What are we thinking?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
							},
				{ Cue = "/VO/Dora_0356", Text = "Can I take your order?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
							},
				{ Cue = "/VO/Dora_0357", Text = "Want something?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
							},
				{ Cue = "/VO/Dora_0358", Text = "Anything jump out?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
							},
				{ Cue = "/VO/Dora_0359", Text = "Here's what we've got.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
							},
				{ Cue = "/VO/Dora_0360", Text = "Let's see here...",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
							},
				{ Cue = "/VO/Dora_0361", Text = "Have a gander.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
							},
				-- SGV
				{ Cue = "/VO/Dora_0245", Text = "{#Emph}What shall it be, Witch?",
					PlayFirst = true,
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0246", Text = "{#Emph}State your bidding.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0362", Text = "{#Emph}What do you require?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
							},
				{ Cue = "/VO/Dora_0363", Text = "{#Emph}Your wish?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
							},
				{ Cue = "/VO/Dora_0364", Text = "{#Emph}Your desire?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
							},
				{ Cue = "/VO/Dora_0365", Text = "{#Emph}What is your bidding?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
							},
				{ Cue = "/VO/Dora_0366", Text = "{#Emph}Forbidden artifacts...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
							},
				{ Cue = "/VO/Dora_0367", Text = "{#Emph}Pay tribute to me...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
							},
			},
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.8,
			SuccessiveChanceToPlay = 0.75,

			{ Cue = "/VO/Melinoe_1393", Text = "Let's see what we can do.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1394", Text = "What do you think, Dora?" },
			{ Cue = "/VO/Melinoe_1395", Text = "We can make things better." },
			{ Cue = "/VO/Melinoe_1396", Text = "We needn't settle for the way it is." },
			{ Cue = "/VO/Melinoe_3651", Text = "The Renewal Project..." },
			{ Cue = "/VO/Melinoe_3652", Text = "What's on the agenda?" },
			{ Cue = "/VO/Melinoe_3653", Text = "Anything stand out?" },
			{ Cue = "/VO/Melinoe_3654", Text = "Shall we liven things up?" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlay = 0.75,
			ObjectType = "NPC_Dora_01",

			{ Cue = "/VO/Dora_0247", Text = "You got it.",
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Melinoe_1393" },
					},
				},
				PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0248", Text = "They don't pay me to think.",
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Melinoe_1394" },
					},
				},
				PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0249", Text = "Or we can just mess with things.",
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Melinoe_1395" },
					},
				},
				PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0250", Text = "Though maybe we should?",
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Melinoe_1396" },
					},
				},
				PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
		},
	},
}