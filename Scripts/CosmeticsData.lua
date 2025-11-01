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
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
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
			"Cosmetic_TentBlanket01c",
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
			"Cosmetic_TentBlanket01c",
		},
		RotateOnly = true,

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
			"Cosmetic_TentBlanket01c",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 120,
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

	Cosmetic_TentBlanket01c =
	{
		Icon = "CosmeticIcon_BlanketFluffy",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566738 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Blanket_01c",
		RemoveCosmetics =
		{
			"Cosmetic_TentBlanket01",
			"Cosmetic_TentBlanket01a",
			"Cosmetic_TentBlanket01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "N_PostBoss01" }
			},
		},
		Cost =
		{
			CosmeticsPoints = 120,
			MixerNBoss = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4145", Text = "As long as it doesn't smell at all like sheep..." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
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
			CosmeticsPoints = 650,
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
			CosmeticsPoints = 350,
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
			CosmeticsPoints = 600,
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
			CosmeticsPoints = 100,
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
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0412", Text = "Now this is a real top-of-the-line candle, Mel.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
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
			CosmeticsPoints = 100,
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
			CosmeticsPoints = 100,
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
			CosmeticsPoints = 180,
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
			CosmeticsPoints = 300,
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
			CosmeticsPoints = 280,
			MixerGBoss = 1,
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
			CosmeticsPoints = 300,
			CardUpgradePoints = 1,
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
			CosmeticsPoints = 300,
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

	Cosmetic_TentTable01 =
	{
		Icon = "CosmeticIcon_TentTable01",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566758, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_01",
		RemoveCosmetics =
		{
			"Cosmetic_TentTable01a",
			"Cosmetic_TentTable01b",
			"Cosmetic_TentTable01c",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_TentTable01a =
	{
		Icon = "CosmeticIcon_TentTable01a",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566758, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_01a",
		RemoveCosmetics =
		{
			"Cosmetic_TentTable01",
			"Cosmetic_TentTable01b",
			"Cosmetic_TentTable01c",
		},
		RotateOnly = true,

		Cost =
		{
			CosmeticsPoints = 360,
		},

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4142", Text = "This seems well-suited for a haunted tent." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	Cosmetic_TentTable01b =
	{
		Icon = "CosmeticIcon_TentTable01b",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566758, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_01b",
		RemoveCosmetics =
		{
			"Cosmetic_TentTable01",
			"Cosmetic_TentTable01a",
			"Cosmetic_TentTable01c",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},

		Cost =
		{
			CosmeticsPoints = 180,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4143", Text = "Reminds me of the phases of the moon... well, one of them." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	Cosmetic_TentTable01c =
	{
		Icon = "CosmeticIcon_TentTable01c",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566758, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_01c",
		RemoveCosmetics =
		{
			"Cosmetic_TentTable01",
			"Cosmetic_TentTable01a",
			"Cosmetic_TentTable01b",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},

		Cost =
		{
			CosmeticsPoints = 180,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4144", Text = "Remnants of the Tree of Life make for fine furnishings." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	Cosmetic_ChronosHourglass =
	{
		Icon = "CosmeticIcon_ChronosHourglass",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780481 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift04" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 1000,
			MixerIBoss = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0700", Text = "A token from your nice and helpful grandpa, I like that.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_HermesShoes =
	{
		Icon = "CosmeticIcon_HermesShoes",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780484 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HermesGift08" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 700,
			MixerPBoss = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0701", Text = "I don't see you ever wearing those... can I have 'em?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_IcarusWings =
	{
		Icon = "CosmeticIcon_IcarusWings",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780483 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusGift10" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "IcarusGift10" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 900,
			MixerPBoss = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0702", Text = "I'd hate to meet a bird with {#Emph}that {#Prev}kind of wingspan...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_PandoraJar =
	{
		Icon = "CosmeticIcon_PandoraJar",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780489, 780490, 780492, 780493, 780494, },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DoraBathHouse03" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "DoraBathHouse03" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 700,
			MixerShadow = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0706", Text = "This one's definitely empty, but let's leave it, just in case.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
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
			CosmeticsPoints = 300,
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
			CosmeticsPoints = 280,
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
			CosmeticsPoints = 400,
			MixerFBoss = 1,
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
			CosmeticsPoints = 400,
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
			CosmeticsPoints = 400,
			GiftPoints = 1,
		},

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
			CosmeticsPoints = 450,
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
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 300,
			MetaFabric = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Moros_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Moros_0295_B", Text = "The Fates bestow a gift.", PreLineAnim = "Moros_Attention" },
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
			CosmeticsPoints = 280,
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
			CosmeticsPoints = 300,
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
			CosmeticsPoints = 200,
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
			CosmeticsPoints = 500,
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

	Cosmetic_MorosTerrain =
	{
		Icon = "CosmeticIcon_MorosTerrain",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780516, 780540, 780533, 780535, 780539, 780530, 780541, 780534, 780532, 780536, 780537, 780538, },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosTaverna02" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "MorosTaverna02" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 150,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Moros_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Moros_0575", Text = "Hm.", PreLineAnim = "Moros_Attention" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0707", Text = "A little something for Horns to rest his feet on.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
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
			CosmeticsPoints = 400,
			MixerHBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Nemesis_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Nemesis_0296", Text = "Here?" },
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
			CosmeticsPoints = 200,
			MixerNBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Nemesis_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Nemesis_0290", Text = "Oh." },
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
			CosmeticsPoints = 250,
			MixerHBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Nemesis_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Nemesis_0298", Text = "Thanks." },
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
			CosmeticsPoints = 400,
			MixerFBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Nemesis_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Nemesis_0294", Text = "{#Emph}Ugh..." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0435", Text = "I guess this ought to heat things up out there a bit.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_NemesisScales =
	{
		Icon = "CosmeticIcon_NemesisScales",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780496 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NemesisBathHouse03" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "NemesisBathHouse03" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 400,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Nemesis_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Nemesis_0364", Text = "{#Emph}Hrm?" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0708", Text = "Thinking {#Emph}this {#Prev}ought to tip the scales in your favor.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
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
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Odysseus_Rug_01",
		RemoveCosmetics =
		{
			"Cosmetic_OdysseusRug02"
		},

		GameStateRequirements =
		{
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 120,
			MixerNBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Odysseus_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				GameStateRequirements =
				{
					{
						PathFalse = { "SessionMapState", "OdysseusAtTaverna" },
					},
				},
				
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

	Cosmetic_OdysseusRug02 =
	{
		Icon = "CosmeticIcon_OdysseusRug02",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 591259 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Odysseus_Rug_02",
		RemoveCosmetics =
		{
			"Cosmetic_OdysseusRug",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "O_PostBoss01" }
			},
		},
		Cost =
		{
			CosmeticsPoints = 150,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Odysseus_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				GameStateRequirements =
				{
					{
						PathFalse = { "SessionMapState", "OdysseusAtTaverna" },
					},
				},

				{ Cue = "/VO/Odysseus_0489", Text = "What, for me?" },
				-- { Cue = "/VO/Odysseus_0490", Text = "This I can {#Emph}definitely {#Prev}use." },
				-- { Cue = "/VO/Odysseus_0491", Text = "Room for more reports!" },
				-- { Cue = "/VO/Odysseus_0492", Text = "Well look at that." },
				-- { Cue = "/VO/Odysseus_0493", Text = "Oh how very thoughtful!" },
				-- { Cue = "/VO/Odysseus_0494", Text = "Just what I sought." },
			},
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4146", Text = "Odysseus must have sailed far and wide on ships like that." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
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
			CosmeticsPoints = 500,
			MixerOBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Odysseus_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				GameStateRequirements =
				{
					{
						PathFalse = { "SessionMapState", "OdysseusAtTaverna" },
					},
				},

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
			CosmeticsPoints = 280,
			MetaCardPointsCommon = 10,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Odysseus_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				GameStateRequirements =
				{
					{
						PathFalse = { "SessionMapState", "OdysseusAtTaverna" },
					},
				},

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

	Cosmetic_OdysseusTrojanHorse =
	{
		Icon = "CosmeticIcon_OdysseusTrojanHorse",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780482 },
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "OdysseusFishing02" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "OdysseusFishing02" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 1000,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Odysseus_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				GameStateRequirements =
				{
					{
						PathFalse = { "SessionMapState", "OdysseusAtTaverna" },
					},
				},

				{ Cue = "/VO/Odysseus_0124", Text = "Seriously now." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0709", Text = "Figure this thing's empty but haven't bothered to check.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
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
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ErisGift02" }
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "TrashPoints" },
				Comparison = ">=",
				Value = 20,
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 200,
			MixerOBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Eris_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Eris_0192", Text = "What's {#Emph}that {#Prev}for?" },
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

	Cosmetic_ErisWarningSign01 =
	{
		Icon = "CosmeticIcon_ErisWarningSign01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 743387, 743386, 743197, 743203, },

		ActivateFunctionName = "SetupErisWarningSignCosmeticThread",
		ActivateFunctionArgs =
		{
			ErisGameStateRequirements =
			{
				{
					PathFromSource = true,
					Path = { "NextInteractLines", "Name" },
					IsNone = { "ErisWithHecate01" },
				},
			},
			SignIds = { 743197, 743203, },
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "O_PostBoss01" }
			},
			NamedRequirements = { "T3Cosmetic" },
		},

		Cost =
		{
			CosmeticsPoints = 450,
			MixerOBoss = 1,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Eris_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Eris_0441", Text = "Who is {#Emph}that?" },
			},
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4068", Text = "Just in case the rubbish Eris strews about isn't warning enough." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_ErisJerkyShelf =
	{
		Icon = "CosmeticIcon_ErisJerkyShelf",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780497 },
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ErisTaverna02" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ErisTaverna02" },
			},
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 150,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Eris_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Eris_0442", Text = "{#Emph}Ooh!" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0710", Text = "Bulk deal on Cyclops Jerky, though don't ask where we got it.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_ErisRug =
	{
		Icon = "CosmeticIcon_ErisRug",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800611 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ErisBecomingCloser01" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ErisBecomingCloser01" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 40,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Eris_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Eris_0444", Text = "Is that for {#Emph}us?" },
			},
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5396", Text = "A bit of added comfort there for Eris in her favored spot..." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
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
			CosmeticsPoints = 90,
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
			CosmeticsPoints = 80,
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
			CosmeticsPoints = 200,
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
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_RiverLantern_01",
		RemoveCosmetics =
		{
			"Cosmetic_RiverLanterns02",
		},

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 180,
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

	Cosmetic_RiverLanterns02 =
	{
		Icon = "CosmeticIcon_RiverLanterns02",
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
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_RiverLantern_02",
		RemoveCosmetics =
		{
			"Cosmetic_RiverLanterns",
		},

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 180,
			MixerFBoss = 1,
			CardUpgradePoints = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4147", Text = "The River of Lamentation could by nature use a little cheer." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0482", Text = "A little bright for my taste but you're the boss.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			-- { GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
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
			CosmeticsPoints = 800,
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
		SetAnimationIds = { 576309, 585190, 561185, 561184, 588785, 742460, 742260, 742474, 742472 },
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
		SetAnimationIds = { 576309, 585190, 561185, 561184, 588785, 742460, 742260, 742474, 742472 },
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
			CosmeticsPoints = 160,
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
		SetAnimationIds = { 576309, 585190, 561185, 561184, 588785, 742460, 742260, 742474, 742472 },
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
			CosmeticsPoints = 160,
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
			CosmeticsPoints = 90,
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

	Cosmetic_BrokerLantern01 =
	{
		Icon = "CosmeticIcon_BrokerLantern01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 743058, 743060, 743057, 743049, 743061, 743059, 743063 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" }
			},
			-- NamedRequirements = { "T1Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 120,
			MixerFBoss = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4137", Text = "I think a hanging light would go quite nicely over there." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

		OnRevealFunctionName = "WretchedBrokerReaction",
	},

	Cosmetic_BrokerWagon01 =
	{
		Icon = "CosmeticIcon_BrokerWagon01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateUniqueIds = { 743002 },
		ActivateIds = { 743085, 743083, 743084, },
		DeactivateIds = { 743079, 743080 },
		RemoveCosmetics =
		{
			"Cosmetic_BrokerWagon02",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" }
			},
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 800,
			GiftPoints = 4,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4138", Text = "This ought to help with storing all our precious wares, Broker!" },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

		OnRevealFunctionName = "WretchedBrokerReaction",
	},

	Cosmetic_BrokerWagon02 =
	{
		Icon = "CosmeticIcon_BrokerWagon02",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateUniqueIds = { 743004 },
		ActivateIds = { 743085, 743083, 743084, },
		DeactivateIds = { 743079, 743080 },
		RemoveCosmetics =
		{
			"Cosmetic_BrokerWagon01",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeMarket", "Cosmetic_BrokerWagon01" }
			},
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 900,
			PlantQSnakereed = 2,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4139", Text = "Behold, Broker! For all you've done for these Crossroads!" },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

		OnRevealFunctionName = "WretchedBrokerReaction",
	},

	Cosmetic_FallenLeaves01 =
	{
		Icon = "CosmeticIcon_FallenLeaves01",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Terrain_FallenLeaves_01",
		RemoveCosmetics = { "Cosmetic_FallenLeaves02" },
		ActivateIds = { 743698, 743740, 743700, 743706, 743702, 743649, 743681, 743660, 743732, 743647, 743760, 743738,
						743792, 743654, 743773, 743811, 743761, 743757, 743800, 743820, 743744, 743767, 743707, 743673,
						743791, 743815, 743802, 743795, 743776, 743739, 743683, 743663, 743784, 743759, 743676, 743763,
						743672, 743821, 743713, 743807, 743666, 743780, 743808, 743735, 743786, 743801, 743746, 743730,
						743793, 743755, 743749, 743687, 743750, 743636, 743818, 743805, 743747, 743797, 743699, 743682,
						743790, 743766, 743783, 743679, 743723, 743753, 743777, 743796, 743788, 743695, 743745, 743708,
						743728, 743684, 743646, 743694, 743712, 743803, 743782, 743806, 743798, 743697, 743787, 743693,
						743781, 743762, 743756, 743703, 743680, 743689, 743639, 743711, 743772, 743822, 743769, 743816,
						743640, 743718, 743701, 743721, 743799, 743686, 743789, 780412, 743685, 743737, 743717, 743653,
						743764, 743804, 743768, 743710, 743643, 743722, 743752, 743775, 743729, 743691, 743734, 743779,
						743778, 743742, 743657, 743690, 743675, 743814, 743813, 743662, 743825, 743828, 743765, 743667,
						743724, 743809, 743648, 743715, 743704, 743817, 743719, 743819, 743670, 743758, 743664, 743751,
						743671, 743812, 743774, 743705, 743650, 743771, 743785, 743748, 743678, 743726, 743741, 743810,
						780414, 743659, 743770, 743696, 743692, 743720, 743826, 743709, 743716, 743651, 743688, 743665,
						743714, 743725, 743754, 743727, 743645, 743731, 743829, 743668, 743743, 743733, 743677, 743827,
						743669, 743661, 743652, },

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
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

				{ Cue = "/VO/Dora_0711", Text = "Bunch of dead leaves should liven things up around here!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_FallenLeaves02 =
	{
		Icon = "CosmeticIcon_FallenLeaves02",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Terrain_FallenLeaves_02",
		RemoveCosmetics = { "Cosmetic_FallenLeaves01" },
		ActivateIds = { 743698, 743740, 743700, 743706, 743702, 743649, 743681, 743660, 743732, 743647, 743760, 743738,
						743792, 743654, 743773, 743811, 743761, 743757, 743800, 743820, 743744, 743767, 743707, 743673,
						743791, 743815, 743802, 743795, 743776, 743739, 743683, 743663, 743784, 743759, 743676, 743763,
						743672, 743821, 743713, 743807, 743666, 743780, 743808, 743735, 743786, 743801, 743746, 743730,
						743793, 743755, 743749, 743687, 743750, 743636, 743818, 743805, 743747, 743797, 743699, 743682,
						743790, 743766, 743783, 743679, 743723, 743753, 743777, 743796, 743788, 743695, 743745, 743708,
						743728, 743684, 743646, 743694, 743712, 743803, 743782, 743806, 743798, 743697, 743787, 743693,
						743781, 743762, 743756, 743703, 743680, 743689, 743639, 743711, 743772, 743822, 743769, 743816,
						743640, 743718, 743701, 743721, 743799, 743686, 743789, 780412, 743685, 743737, 743717, 743653,
						743764, 743804, 743768, 743710, 743643, 743722, 743752, 743775, 743729, 743691, 743734, 743779,
						743778, 743742, 743657, 743690, 743675, 743814, 743813, 743662, 743825, 743828, 743765, 743667,
						743724, 743809, 743648, 743715, 743704, 743817, 743719, 743819, 743670, 743758, 743664, 743751,
						743671, 743812, 743774, 743705, 743650, 743771, 743785, 743748, 743678, 743726, 743741, 743810,
						780414, 743659, 743770, 743696, 743692, 743720, 743826, 743709, 743716, 743651, 743688, 743665,
						743714, 743725, 743754, 743727, 743645, 743731, 743829, 743668, 743743, 743733, 743677, 743827,
						743669, 743661, 743652, },

		GameStateRequirements =
		{
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 180,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0712", Text = "Like it's springtime all the time! I think I remember springtime...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CharonOar =
	{
		Icon = "CosmeticIcon_CharonOar",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780485, 780526, },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CharonGift08" },
			},
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 400,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0713", Text = "Who needs an oar when you can just float aimlessly?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_ArachneTapestry =
	{
		Icon = "CosmeticIcon_ArachneTapestry",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780495 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArachneGift09" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 600,
			MetaFabric = 5,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0714", Text = "I'm no expert but that's some fine weaving right there!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Artemis Corner

	Cosmetic_ArtemisLyre =
	{
		Icon = "CosmeticIcon_ArtemisLyre",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780486 },
		ToggleShadows = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSingingEndTheme01" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ArtemisHubSingingEndTheme01" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 250,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0716", Text = "Some musical accompaniment for you, not that you'll ever need it.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_ArtemisTarget =
	{
		Icon = "CosmeticIcon_ArtemisTarget",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800649 },
		ToggleShadows = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift10" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 200,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5392", Text = "Artemis is restricted from target practice here but she can think about it." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_ArtemisFlowerCircle01 =
	{
		Icon = "CosmeticIcon_Artemis_TerrainDecor_01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800650 },
		DeactivateIds = { 742280, 742281 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Artemis_TerrainDecor_01",
		RemoveCosmetics =
		{
			"Cosmetic_ArtemisFlowerCircle01a",
			"Cosmetic_ArtemisFlowerCircle01b",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "ArtemisHubSinging01", "ArtemisGift02" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 150,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5393", Text = "Some lovely flowers there for Sister Artemis." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_ArtemisFlowerCircle01a =
	{
		Icon = "CosmeticIcon_Artemis_TerrainDecor_01a",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800650 },
		DeactivateIds = { 742280, 742281 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Artemis_TerrainDecor_01a",
		RemoveCosmetics =
		{
			"Cosmetic_ArtemisFlowerCircle01",
			"Cosmetic_ArtemisFlowerCircle01b",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "ArtemisHubSinging01", "ArtemisGift02" },
			},
			NamedRequirements = { "T2Cosmetic" },
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

				{ Cue = "/VO/Dora_0719", Text = "How come you need to make it comfortable way over {#Emph}there?", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_ArtemisFlowerCircle01b =
	{
		Icon = "CosmeticIcon_Artemis_TerrainDecor_01b",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800650 },
		DeactivateIds = { 742280, 742281 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Artemis_TerrainDecor_01b",
		RemoveCosmetics =
		{
			"Cosmetic_ArtemisFlowerCircle01",
			"Cosmetic_ArtemisFlowerCircle01a",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "ArtemisHubSinging01", "ArtemisGift02" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 200,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5394", Text = "Perhaps Artemis would prefer her flowers blood-colored." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_ArtemisAmaranthus =
	{
		Icon = "CosmeticIcon_ArtemisAmaranthus",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800655, 800617, 800639, 800640, 800619, 800621, 800618, 800638, 800651, 800636, 800641, 800637, 800620, 800622 },
		DeactivateIds = { 566673, 586778, 586832, 566477, 586535, 742156, 589518, 589521, 742158, 742157 },

		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "ArtemisHubSinging01", "ArtemisGift04" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 250,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5395", Text = "Sister Artemis loves having these around." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
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
			CosmeticsPoints = 1900,
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
			CosmeticsPoints = 2000,
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

	Cosmetic_HecateKey =
	{
		Icon = "CosmeticIcon_HecateKey",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780487 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateFishing02" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "HecateFishing02" },
			},
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 800,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Hecate_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Hecate_0580", Text = "{#Emph}Hmm." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0715", Text = "We probably could have used a banner like that {#Emph}before {#Prev}the war ended.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
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
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 250,
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
			CosmeticsPoints = 250,
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
			CosmeticsPoints = 300,
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
			CosmeticsPoints = 300,
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
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 400,
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
			{
				Path = { "GameState", "LifetimeResourcesSpent", "GiftPointsEpic" },
				Comparison = ">=",
				Value = 2,
			},
			NamedRequirements = { "T1HubMainCosmetic" },
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
			{
				Path = { "GameState", "LifetimeResourcesSpent", "GiftPointsEpic" },
				Comparison = ">=",
				Value = 2,
			},
			NamedRequirements = { "T1HubMainCosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 150,
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
			{
				Path = { "GameState", "LifetimeResourcesSpent", "GiftPointsEpic" },
				Comparison = ">=",
				Value = 3,
			},
			NamedRequirements = { "T1HubMainCosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 180,
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
			CosmeticsPoints = 100,
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
			CosmeticsPoints = 100,
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
		CameraFocusId = 800742,
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
		CameraFocusId = 800742,
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
			CosmeticsPoints = 300,
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
			CosmeticsPoints = 150,
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

	Cosmetic_HypnosPedestal01 =
	{
		Icon = "CosmeticIcon_HypnosPedestal01",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 800742,
		SetAnimationIds = { 590946, 590943, 590944, 590945, 590218, 590219, 590954, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_StonePillar_01",
		RemoveCosmetics =
		{
			"Cosmetic_HypnosPedestal01a",
			"Cosmetic_HypnosPedestal01b",
		},

		GameStateRequirements =
		{
			NamedRequirements = { "T2HubMainCosmetic" },
		},

		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_HypnosPedestal01a =
	{
		Icon = "CosmeticIcon_HypnosPedestal01a",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 800742,
		SetAnimationIds = { 590946, 590943, 590944, 590945, 590218, 590219, 590954, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Hypnos_Pedestal_01",
		RemoveCosmetics =
		{
			"Cosmetic_HypnosPedestal01",
			"Cosmetic_HypnosPedestal01b",
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
			CosmeticsPoints = 250,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},

				{ Cue = "/VO/Melinoe_4135", Text = "May these pillarets bring Lord Hypnos some comfort..." },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},

				{ Cue = "/VO/Dora_0720", Text = "What happened to that sleeping guy anyway? Is this him?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	Cosmetic_HypnosPedestal01b =
	{
		Icon = "CosmeticIcon_HypnosPedestal01b",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 800742,
		SetAnimationIds = { 590946, 590943, 590944, 590945, 590218, 590219, 590954, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Hypnos_Pedestal_02",
		RemoveCosmetics =
		{
			"Cosmetic_HypnosPedestal01",
			"Cosmetic_HypnosPedestal01a",
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
			CosmeticsPoints = 250,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4136", Text = "I wonder if Lord Hypnos would have chosen these himself..." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	-- Farm

	Cosmetic_FarmBench01 =
	{
		Icon = "CosmeticIcon_FarmBench01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 741514 },
		ToggleCollision = true,
		ToggleUseable = true,

		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpecialInteractRecord", "CrossroadsFountainWall01" },
				Comparison = ">=",
				Value = 2,
			},
			-- NamedRequirements = { "T2Cosmetic" },
		},

		Cost =
		{
			CosmeticsPoints = 120,
		},
		RevealReactionVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4128", Text = "Fine way for someone other than me to contemplate Father's fountain." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	Cosmetic_FarmPillars01 =
	{
		Icon = "CosmeticIcon_FarmPillars01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 741884, 741883, },
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpecialInteractRecord", "CrossroadsFountainWall01" },
				Comparison = ">=",
				Value = 2,
			},
			NamedRequirements = { "T2HubMainCosmetic" },
		},

		Cost =
		{
			CosmeticsPoints = 200,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4129", Text = "Should add a bit of solemn stateliness near to the Fountain of the Dead." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	Cosmetic_FarmWell01 =
	{
		Icon = "CosmeticIcon_FarmWell01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 741994, },
		DeactivateIds = { 743163 },
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpecialInteractRecord", "CrossroadsFountainWall01" },
				Comparison = ">=",
				Value = 1,
			},
			NamedRequirements = { "T3Cosmetic" },
		},

		Cost =
		{
			CosmeticsPoints = 450,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4130", Text = "We'd best not draw up water from this type of well, but sure." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	Cosmetic_FarmGardenTools01 =
	{
		Icon = "CosmeticIcon_FarmGardenTools01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 743164, 741515, 741517, },
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGardenT3" },
			},
		},

		Cost =
		{
			CosmeticsPoints = 110,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4131", Text = "Where did we even get old mortal tools like these?" },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	Cosmetic_SunMoonTimeSculpture01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800527 },
		DeactivateIds = { 800530 },
		ToggleUseable = true,
		Hidden = true, -- don't appear in Dora's shop; this is automatically rewarded on completion of the true ending
	},

	-- Icarus Corner

	Cosmetic_IcarusTable01 =
	{
		Icon = "CosmeticIcon_IcarusTable01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800391, 800397 },
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "IcarusHomeFirstMeeting" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusGift03" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 400,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Icarus_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Icarus_0489", Text = "No, for me?" },
			},
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5397", Text = "Some more knickknacks and such for Icarus to tinker with." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_IcarusRug01 =
	{
		Icon = "CosmeticIcon_IcarusRug01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800396 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "IcarusHomeFirstMeeting" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 100,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5398", Text = "Icarus needn't use his feet much at this point but just in case." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0704", Text = "Perfect for dropping important little pieces onto.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
		},
	},

	Cosmetic_IcarusRug02 =
	{
		Icon = "CosmeticIcon_IcarusRug02",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800657 },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "IcarusHomeFirstMeeting" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 150,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Icarus_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Icarus_0049", Text = "Hello...!" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0477", Text = "This almost makes me wish I still had feet.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_IcarusBombs01 =
	{
		Icon = "CosmeticIcon_IcarusBombs01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800393, 800392 },
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "IcarusHomeFirstMeeting" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusGift02" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 200,
		},

		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Icarus_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Icarus_0490", Text = "Oh, come on." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0705", Text = "These must be perfectly safe to store out in the open.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_IcarusMaps =
	{
		Icon = "CosmeticIcon_IcarusMaps",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800652, 800653 },
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "IcarusHomeFirstMeeting" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 250,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Icarus_01",
				RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Icarus_0489", Text = "No, for me?" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0703", Text = "Now that guy with the wings can work harder than ever!", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
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
		ToggleUseable = true,
		ActivateIds = { 738444, 738445 },
		ActivateFunctionName = "ActivateHubAquarium",
		DeactivateFunctionName = "DeactivateHubAquarium",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" }
			},
			{
				Path = { "GameState", "FishingSuccesses" },
				Comparison = ">=",
				Value = 5,
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 500,
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

	Cosmetic_FishingSign01 =
	{
		Icon = "CosmeticIcon_FishingSign01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 742950 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_FishSign_01",
		RemoveCosmetics =
		{
			"Cosmetic_FishingSign01a",
			"Cosmetic_FishingSign01b",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" }
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "FishHCommon" },
				Comparison = ">=",
				Value = 3,
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 400,
			MixerHBoss = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4132", Text = "A huge sign with a Soby on it seems quite appropriate." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_FishingSign01a =
	{
		Icon = "CosmeticIcon_FishingSign01a",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 742950 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_FishSign_01b",
		RemoveCosmetics =
		{
			"Cosmetic_FishingSign01",
			"Cosmetic_FishingSign01b",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" }
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "FishIRare" },
				Comparison = ">=",
				Value = 3,
			},
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 400,
			MixerIBoss = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4133", Text = "The only Goldfish I've seen are in Tartarus, but no more." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	Cosmetic_FishingSign01b =
	{
		Icon = "CosmeticIcon_FishingSign01b",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 742950 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_FishSign_01c",
		RemoveCosmetics =
		{
			"Cosmetic_FishingSign01",
			"Cosmetic_FishingSign01a",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" }
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "FishNCommon" },
				Comparison = ">=",
				Value = 3,
			},
			NamedRequirements = { "T3Cosmetic" },
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
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4134", Text = "A large sign with a Ribeye on it ought to fit the atmosphere." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	-- Taverna

	Cosmetic_TavernaTables01 =
	{
		Icon = "CosmeticIcon_TavernaTables01",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 585757, 585754, 585761, 566359, 742135, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_04",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaTables01a",
			"Cosmetic_TavernaTables01b",
			"Cosmetic_TavernaTables01c",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_TavernaTables01a =
	{
		Icon = "CosmeticIcon_TavernaTables01a",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 585757, 585754, 585761, 566359, 742135, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_04a",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaTables01",
			"Cosmetic_TavernaTables01b",
			"Cosmetic_TavernaTables01c",
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
			CosmeticsPoints = 500,
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
		SetAnimationIds = { 585757, 585754, 585761, 566359, 742135, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_04b",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaTables01",
			"Cosmetic_TavernaTables01a",
			"Cosmetic_TavernaTables01c",
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
			CosmeticsPoints = 600,
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

	Cosmetic_TavernaTables01c =
	{
		Icon = "CosmeticIcon_TavernaTables01c",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 585757, 585754, 585761, 566359, 742135, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Table_04c",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaTables01",
			"Cosmetic_TavernaTables01a",
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
			CosmeticsPoints = 500,
			CardUpgradePoints = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4141", Text = "These tables seem like they would fit the place quite well." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},

	},

	Cosmetic_TavernaChairs01 =
	{
		Icon = "CosmeticIcon_TavernaChairs01",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566374, 566377, 585764, 585753, 585756, 585760, 585763, 585759, 742136, 742137, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Chair_01",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaChairs01a",
			"Cosmetic_TavernaChairs01b",
			"Cosmetic_TavernaChairs01c",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_TavernaChairs01a =
	{
		Icon = "CosmeticIcon_TavernaChairs01a",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566374, 566377, 585764, 585753, 585756, 585760, 585763, 585759, 742136, 742137, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Chair_01a",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaChairs01",
			"Cosmetic_TavernaChairs01b",
			"Cosmetic_TavernaChairs01c",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" }
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 120,
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
		SetAnimationIds = { 566374, 566377, 585764, 585753, 585756, 585760, 585763, 585759, 742136, 742137, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Chair_01b",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaChairs01",
			"Cosmetic_TavernaChairs01a",
			"Cosmetic_TavernaChairs01c",
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
			CosmeticsPoints = 150,
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

	Cosmetic_TavernaChairs01c =
	{
		Icon = "CosmeticIcon_TavernaChairs01c",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 566374, 566377, 585764, 585753, 585756, 585760, 585763, 585759, 742136, 742137, },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Chair_01c",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaChairs01",
			"Cosmetic_TavernaChairs01a",
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
			CosmeticsPoints = 160,
			CardUpgradePoints = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4140", Text = "These seem comfortable and I quite like the colors too." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
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
			CosmeticsPoints = 800,
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

	Cosmetic_TavernaMusicStage01 =
	{
		Icon = "CosmeticIcon_TavernaMusicStage01",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800654 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Terrain_MusicMaker_01",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaMusicStage02",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll = GameData.AllHiddenAspects,
			},
			{
				Path = { "GameState", "WorldUpgrades" },
				CountOf = GameData.AllMusicPlayerTracks,
				Comparison = ">=",
				Value = 20,
			},
		},
		Cost =
		{
			CosmeticsPoints = 180,
			MixerOBoss = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5387", Text = "Perhaps a more-suitable stage for your performance, Music Maker!", PostLineFunctionName = "MusicMakerReaction" },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0717", Text = "Should really help with the acoustics, whatever those are.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
		},
	},

	Cosmetic_TavernaMusicStage02 =
	{
		Icon = "CosmeticIcon_TavernaMusicStage02",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800654 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_Terrain_MusicMaker_02",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaMusicStage01",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll = GameData.AllHiddenAspects,
			},
			{
				Path = { "GameState", "WorldUpgrades" },
				CountOf = GameData.AllMusicPlayerTracks,
				Comparison = ">=",
				Value = 20,
			},
		},
		Cost =
		{
			CosmeticsPoints = 200,
			MixerHBoss = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5388", Text = "Here's a new spot from which to regale us, Music Maker!", PostLineFunctionName = "MusicMakerReaction" },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_TavernaShrimpCocktails =
	{
		Icon = "CosmeticIcon_TavernaShrimpCocktails",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 800663, 800660, 800666, 800661, 800664, 800662, 800665 },

		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "FishOCommon" },
				Comparison = ">=",
				Value = 1,
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 110,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5389", Text = "These must take inspiration from the Shrimp of Lord Poseidon's seas..." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_TavernaCauldron01 =
	{
		Icon = "CosmeticIcon_TavernaCauldron01",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 586614 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_CauldronSet_01",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaCauldron02",
		},
		RotateOnly = true,
		AlwaysRevealImmediately = true,
	},

	Cosmetic_TavernaCauldron02 =
	{
		Icon = "CosmeticIcon_TavernaCauldron02",
		InheritFrom = { "DefaultCosmeticItem" },
		SetAnimationIds = { 586614 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_CauldronSet_02",
		RemoveCosmetics =
		{
			"Cosmetic_TavernaCauldron01",
		},
		RotateOnly = true,

		GameStateRequirements =
		{
			NamedRequirements = { "T3Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 180,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5391", Text = "Only the finest cauldron-like receptacles for our loyal Shades." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
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
			CosmeticsPoints = 120,
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
			CosmeticsPoints = 150,
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
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 1000,
			MixerIBoss = 1,
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
			CosmeticsPoints = 900,
			MixerPBoss = 1,
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
			CosmeticsPoints = 650,
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
		ToggleShadows = true,
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
			CosmeticsPoints = 650,
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
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_ExitCharm_01",
		RemoveCosmetics =
		{
			"Cosmetic_ExitCharm02",
			"Cosmetic_ExitCharm03",
			"Cosmetic_ExitCharm04",
			"Cosmetic_ExitCharm05",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll = GameData.AllFrogFamiliarUpgrades,
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 450,
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
	Cosmetic_ExitCharm02 =
	{
		Icon = "CosmeticIcon_ExitCharm02",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 589859, 589860 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_ExitCharm_02",
		RemoveCosmetics =
		{
			"Cosmetic_ExitCharm",
			"Cosmetic_ExitCharm03",
			"Cosmetic_ExitCharm04",
			"Cosmetic_ExitCharm05",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll = GameData.AllRavenFamiliarUpgrades,
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 450,
			WeaponPointsRare = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0738", Text = "I wouldn't come anywhere {#Emph}near {#Prev}this place with {#Emph}that {#Prev}thing up.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},
	Cosmetic_ExitCharm03 =
	{
		Icon = "CosmeticIcon_ExitCharm03",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 589859, 589860 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_ExitCharm_03",
		RemoveCosmetics =
		{
			"Cosmetic_ExitCharm",
			"Cosmetic_ExitCharm02",
			"Cosmetic_ExitCharm04",
			"Cosmetic_ExitCharm05",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll = GameData.AllCatFamiliarUpgrades,
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 450,
			WeaponPointsRare = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0737", Text = "May any cats you run into out there bless your journey, Mel.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},
	Cosmetic_ExitCharm04 =
	{
		Icon = "CosmeticIcon_ExitCharm04",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 589859, 589860 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_ExitCharm_04",
		RemoveCosmetics =
		{
			"Cosmetic_ExitCharm",
			"Cosmetic_ExitCharm02",
			"Cosmetic_ExitCharm03",
			"Cosmetic_ExitCharm05",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll = GameData.AllHoundFamiliarUpgrades,
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 450,
			WeaponPointsRare = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0736", Text = "If I was a dog I'd probably be a little weirded out by that.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},
	Cosmetic_ExitCharm05 =
	{
		Icon = "CosmeticIcon_ExitCharm05",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 589859, 589860 },
		SetAnimationValue = "Tilesets/Crossroads/Crossroads_ExitCharm_05",
		RemoveCosmetics =
		{
			"Cosmetic_ExitCharm",
			"Cosmetic_ExitCharm02",
			"Cosmetic_ExitCharm03",
			"Cosmetic_ExitCharm04",
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll = GameData.AllPolecatFamiliarUpgrades,
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 450,
			WeaponPointsRare = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0739", Text = "Is that a good-luck rat or something...? I like it!", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_SkellyZagreusStatue =
	{
		Icon = "CosmeticIcon_SkellyZagreusStatue",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780532 },
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EnemyKills", "Zagreus" },
			},
			NamedRequirements = { "T5Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 2000,
			Mixer6Common = 1,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0721", Text = "Original order for this got messed up so we got it at a major discount.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
			},
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- Ambient Animals

	Cosmetic_AmbientDogs =
	{
		Icon = "CosmeticIcon_AmbientDogs",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateGroups = { "Dogs_Cosmetic_HecubasPack" },
		ActivateFunctionName = "CosmeticCritterRandomizeAnimations",
		ActivateRoomObstacleIds = { 743399 },
		Removable = false,
		ToggleCollision = true,
		InspectPointId = 743479,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "HoundFamiliar" },
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 700,
			GiftPoints = 1,
		},

		OnRevealFunctionName = "AmbientDogsReaction",
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3916", Text = "Such loyal and trustworthy beasts are always welcome here." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0112", Text = "Whatever you say!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},

		CameraFocusId = 738944,
	},
	Cosmetic_AmbientCats =
	{
		Icon = "CosmeticIcon_AmbientCats",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateGroups = { "Cats_Cosmetic_TaveranEntrance" },
		ActivateFunctionName = "CosmeticCritterRandomizeAnimations",
		ActivateRoomObstacleIds = { 800610 },
		Removable = false,
		ToggleCollision = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
			},
			NamedRequirements = { "T4Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 600,
			GiftPoints = 1,
		},

		OnRevealFunctionName = "AmbientCatsReaction",
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3885", Text = "Beasts like going where they please; it may as well be here." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0485", Text = "Should add an extra something-something to this place!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},

		CameraFocusId = 576053, -- camera point near taverna entrance
	},
	Cosmetic_AmbientFrogs =
	{
		Icon = "CosmeticIcon_AmbientFrogs",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateGroups = { "Frogs_Cosmetic_NearArtemis" },
		Removable = false,
		ToggleShadows = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" },
			},
			NamedRequirements = { "T2Cosmetic" },
		},
		Cost =
		{
			CosmeticsPoints = 180,
			GiftPoints = 1,
		},

		OnRevealFunctionName = "AmbientFrogsReaction",
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3884", Text = "This can become a haven for more than just Shades." },
			},
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0113", Text = "I mean, I guess?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						},
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},

		CameraFocusId = 742307, -- central rock in frog area
	},

	-- Collectables

	Cosmetic_CollectableOdysseus =
	{
		Icon = "CosmeticIcon_CollectableOdysseus",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780521 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "OdysseusFishing02" },
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0725", Text = "Looks like that one guy by the table, what's-his-name.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableSkelly =
	{
		Icon = "CosmeticIcon_CollectableSkelly",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780522 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SkellyGift09" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "SkellyGift09" },
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0726", Text = "Who needs the real Commander when you have this little guy?", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableMoros =
	{
		Icon = "CosmeticIcon_CollectableMoros",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780515 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosTaverna02" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "MorosTaverna02" },
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0727", Text = "{#Emph}Aw{#Prev}, look at his tiny little horns. You think they're sharp?", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableHecate =
	{
		Icon = "CosmeticIcon_CollectableHecate",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780517 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateBathHouseEpilogue01" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "HecateBathHouseEpilogue01" },
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0728", Text = "It's the head witch! Can you take off her hat and mask?", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableNemesis =
	{
		Icon = "CosmeticIcon_CollectableNemesis",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780518 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NemesisBathHouse03" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "NemesisBathHouse03" },
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0729", Text = "Almost feels like I'm being judged just by looking at her.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableCharon =
	{
		Icon = "CosmeticIcon_CollectableCharon",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780520 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CharonGift08" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "CharonGift08" },
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0730", Text = "This that boatman guy the Shades go on about sometimes?", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableIcarus =
	{
		Icon = "CosmeticIcon_CollectableIcarus",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780528 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusGift10" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "IcarusGift10 "}
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0731", Text = "That one guy with the wings! I'd recognize him anywhere.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableArtemis =
	{
		Icon = "CosmeticIcon_CollectableArtemis",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780527 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift10" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ArtemisGift10" },
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0732", Text = "Hey it's that one who shows up singing every now and then.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableEris =
	{
		Icon = "CosmeticIcon_CollectableEris",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780523 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ErisTaverna02" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ErisTaverna02" },
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0733", Text = "Got a bad feeling about this one... probably nothing!", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableDora =
	{
		Icon = "CosmeticIcon_CollectableDora",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780525 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DoraBathHouse03" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "DoraBathHouse03" },
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0734", Text = "I see you got by far the rarest, most valuable one in the series.", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableSelene =
	{
		Icon = "CosmeticIcon_CollectableSelene",
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780529 },
		AutoUnlockCosmeticName = "Cosmetic_CollectableShelf",

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneGift09" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "SeleneGift09" },
			},
			NamedRequirements = { "T5Cosmetic", "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 799,
		},
		RevealReactionVoiceLines =
		{
			{
				PreLineWait = 0.35,
				ObjectType = "NPC_Dora_01",
				{ Cue = "/VO/Dora_0735", Text = "Could have sworn this one was supposed to come with a horse...", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
			},
			-- { GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	Cosmetic_CollectableShelf =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		ActivateIds = { 780519, 780590, 780589, 780585, 780586, 780516, 780552, 780592, 780571, 780572, 780559, 780557, 780558, },
		ToggleCollision = true,
		Hidden = true, -- don't appear in Dora's shop; this is automatically unlocked when purchasing any Collectable
	},

	-- Card Decks
	Cosmetic_CardDeck01 =
	{
		Icon = "CosmeticIcon_DecksMisc",
		InheritFrom = { "DefaultCosmeticItem" },
		CameraFocusId = 589766,
		Removable = false,
		SkipFade = true,
		NumBackings = 3, -- used only for text

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMetaUpgradeSaveLayout" },
			},
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeSurfacePenaltyCure" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 300,
		},

		RevealReactionVoiceLines = "nil",
		PreRevealVoiceLines =
		{
			Queue = "Interrupt",
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5379", Text = "How about a new look for the old Arcana..." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_CardDeck02 =
	{
		Icon = "CosmeticIcon_DecksWeapons",
		InheritFrom = { "Cosmetic_CardDeck01" },
		NumBackings = 6, -- used only for text

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_CardDeck01" },
			},
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 400,
			Mixer6Common = 1,
		},

		PreRevealVoiceLines =
		{
			Queue = "Interrupt",
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5380", Text = "The Arcana and the Arms of Night go hand in hand..." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_CardDeck03 =
	{
		Icon = "CosmeticIcon_DecksAspects1",
		InheritFrom = { "Cosmetic_CardDeck02" },
		NumBackings = 6, -- used only for text

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_CardDeck02" },
			},
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll =
				{
					"StaffClearCastAspect",
					"DaggerBlockAspect",
					"TorchDetonateAspect",
					"AxeArmCastAspect",
					"LobCloseAttackAspect",
					"SuitHexAspect",
				},
			}
		},
		Cost =
		{
			CosmeticsPoints = 500,
			CardUpgradePoints = 1,
		},
		PreRevealVoiceLines =
		{
			Queue = "Interrupt",
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5381", Text = "A reminder of the Aspects of the Arms closest to mine..." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},		
	},

	Cosmetic_CardDeck04 =
	{
		Icon = "CosmeticIcon_DecksAspects2",
		InheritFrom = { "Cosmetic_CardDeck01" },
		NumBackings = 6, -- used only for text

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_CardDeck03" },
			},
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll =
				{
					"StaffSelfHitAspect",
					"DaggerHomingThrowAspect",
					"TorchSprintRecallAspect",
					"AxePerfectCriticalAspect",
					"LobImpulseAspect",
					"SuitMarkCritAspect",
				},
			},
		},
		Cost =
		{
			CosmeticsPoints = 600,
			MixerIBoss = 1,
		},
		PreRevealVoiceLines =
		{
			Queue = "Interrupt",
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5382", Text = "Should pair well with certain Aspects I can use..." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_CardDeck05 =
	{
		Icon = "CosmeticIcon_DecksFamiliars",
		InheritFrom = { "Cosmetic_CardDeck01" },
		NumBackings = 5, -- used only for text
		
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_CardDeck01" },
			},
			{
				Path = { "GameState", "FamiliarsUnlocked" },
				HasAll = { "FrogFamiliar", "RavenFamiliar", "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
			},
		},
		Cost =
		{
			CosmeticsPoints = 900,
			FamiliarPoints = 1,
		},
		PreRevealVoiceLines =
		{
			Queue = "Interrupt",
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5383", Text = "There's one for each of my Familiars, isn't there...?" },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_CardDeck06 =
	{
		Icon = "CosmeticIcon_DecksOaths",
		InheritFrom = { "Cosmetic_CardDeck01" },
		NumBackings = 3, -- used only for text
		
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_CardDeck01" },
			},
			OrRequirements =
			{
				{
					{
						Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
						Comparison = ">=",
						Value = 8,
					},
				},
				{
					{
						Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
						Comparison = ">=",
						Value = 8,
					},
				},
			},
		},
		Cost =
		{
			CosmeticsPoints = 1000,
			MixerShadow = 1,
		},
		PreRevealVoiceLines =
		{
			Queue = "Interrupt",
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5384", Text = "If the will of Night is to be done, why not in style?" },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_CardDeck07 =
	{
		Icon = "CosmeticIcon_DecksAspects3",
		InheritFrom = { "Cosmetic_CardDeck01" },
		NumBackings = 6, -- used only for text
		
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_CardDeck04" },
			},
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll = GameData.AllHiddenAspects,
			},
		},
		Cost =
		{
			CosmeticsPoints = 2000,
			MixerShadow = 1,
		},
		PreRevealVoiceLines =
		{
			Queue = "Interrupt",
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5385", Text = "In honor of the gods and goddesses of distant realms..." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},

	Cosmetic_CardDeck08 =
	{
		Icon = "CosmeticIcon_DecksRelics",
		InheritFrom = { "Cosmetic_CardDeck01" },
		NumBackings = 4, -- used only for text
		
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_CardDeck01" },
			},
			NamedRequirements = { "HasEverReachedTrueEnding" },
		},
		Cost =
		{
			CosmeticsPoints = 700,
			MixerShadow = 1,
		},
		PreRevealVoiceLines =
		{
			Queue = "Interrupt",
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_5386", Text = "May the Arcana always remind me of my heritage." },
			},
			{ GlobalVoiceLines = "DoraCosmeticReactionVoiceLines" },
		},
	},


})

ScreenData.CosmeticsShop =
{
	BlockPause = true,

	ItemCategories =
	{
		-- Mel's Tent
		{
			Name = "CosmeticsShop_Tent",
			CacheName = "Tent",
			BackingAnimation = "CosmeticsShopBacking_Tent",
			GameStateRequirements =
			{
				-- None
			},
			"Cosmetic_TentBlanket01",
			"Cosmetic_TentBlanket01a",
			"Cosmetic_TentBlanket01b",
			"Cosmetic_TentBlanket01c",
			"Cosmetic_WitchTrinkets01",
			"Cosmetic_WitchTrinkets02",
			"Cosmetic_TentHangingOrnaments01",
			"Cosmetic_TentCandle01",
			"Cosmetic_TentCandle01a",
			"Cosmetic_TentCandle01b",
			"Cosmetic_TentQuilt",
			"Cosmetic_TentShelf01",
			"Cosmetic_TentShelf01a",
			"Cosmetic_TentShelf01b",
			"Cosmetic_TentRug",
			"Cosmetic_TentTable01",
			"Cosmetic_TentTable01a",
			"Cosmetic_TentTable01b",
			"Cosmetic_TentTable01c",

			"Cosmetic_ChronosHourglass",
			"Cosmetic_IcarusWings",
			"Cosmetic_PandoraJar",
			"Cosmetic_HermesShoes",
			"Cosmetic_EmployeeOfTheMonth",
			"Cosmetic_ThanPoster",
			"Cosmetic_FanPoster01",
			"Cosmetic_FanPoster01a",
			"Cosmetic_FanPoster01b",
			"Cosmetic_ApolloLyre",

			-- Respawn Area
			"Cosmetic_FrinosRock01",
			"Cosmetic_FrinosRock01a",
			"Cosmetic_FrinosRock01b",
			"Cosmetic_RespawnCircleFlowers",
			"Cosmetic_FamiliarEffigy01",
			"Cosmetic_FamiliarEffigy01a",
			"Cosmetic_FamiliarEffigy01b",
		},
		-- Crossroads Main Grounds & West
		{
			Name = "CosmeticsShop_Main",
			CacheName = "HubMain",
			BackingAnimation = "CosmeticsShopBacking_HubMain",
			GameStateRequirements =
			{
				-- None
			},
			-- Cauldron
			"Cosmetic_Cauldron01",
			"Cosmetic_Cauldron01a",
			"Cosmetic_Cauldron01b",
			"Cosmetic_HecateKey",
			"Cosmetic_CauldronRing01",
			"Cosmetic_CauldronRing01a",
			"Cosmetic_CauldronRing01b",
			"Cosmetic_CauldronPillars01",
			"Cosmetic_CauldronPillars01a",
			"Cosmetic_CauldronPillars01b",
			"Cosmetic_CauldronPillars01c",

			-- General
			"Cosmetic_RiverLanterns",
			"Cosmetic_RiverLanterns02",
			"Cosmetic_MainTeaLights",
			"Cosmetic_MainLanterns01",
			"Cosmetic_MainLanterns01a",
			"Cosmetic_MainLanterns01b",
			"Cosmetic_FallenLeaves01",
			"Cosmetic_FallenLeaves02",

			-- Odysseus Corner
			"Cosmetic_OdysseusTrojanHorse",
			"Cosmetic_OdysseusTable01",
			"Cosmetic_OdysseusTable01a",
			"Cosmetic_OdysseusVase",
			"Cosmetic_OdysseusRug02",
			"Cosmetic_OdysseusRug",

			-- Broker
			"Cosmetic_ArachneTapestry",
			"Cosmetic_CharonOar",
			"Cosmetic_BrokerWagon01",
			"Cosmetic_BrokerWagon02",
			"Cosmetic_BrokerRug",
			"Cosmetic_BrokerLantern01",

			-- Farm
			"Cosmetic_FarmWell01",
			"Cosmetic_FarmPillars01",
			"Cosmetic_FarmBench01",
			"Cosmetic_FarmGardenTools01",
			"Cosmetic_SunMoonTimeSculpture01",

			-- Hot Springs
			"Cosmetic_BathChangingScreens",
			"Cosmetic_BathTowelRacks",
			"Cosmetic_BathSoaps",

			-- Hypnos Corner
			"Cosmetic_HypnosLanterns01",
			"Cosmetic_HypnosLanterns01a",
			"Cosmetic_HypnosLanterns01b",
			"Cosmetic_HypnosPillars01",
			"Cosmetic_HypnosPillars01a",
			"Cosmetic_HypnosPedestal01",
			"Cosmetic_HypnosPedestal01a",
			"Cosmetic_HypnosPedestal01b",
			"Cosmetic_HypnosRug",

			-- Nemesis Corner
			"Cosmetic_NemesisScales",
			"Cosmetic_NemesisGrindstone",
			"Cosmetic_NemesisBraziers",
			"Cosmetic_NemesisChair",
			"Cosmetic_NemesisRug",

			-- Icarus Corner
			"Cosmetic_IcarusTable01",
			"Cosmetic_IcarusBombs01",
			"Cosmetic_IcarusMaps",
			"Cosmetic_IcarusRug01",
			"Cosmetic_IcarusRug02",
		},
		-- Taverna & Crossroads West
		{
			Name = "CosmeticsShop_Taverna",
			CacheName = "Taverna",
			BackingAnimation = "CosmeticsShopBacking_Taverna",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" }
				},
			},
			-- Taverna
			"Cosmetic_TavernaStarMosaic",
			"Cosmetic_TavernaTables01",
			"Cosmetic_TavernaTables01a",
			"Cosmetic_TavernaTables01b",
			"Cosmetic_TavernaTables01c",
			"Cosmetic_TavernaChairs01",
			"Cosmetic_TavernaChairs01a",
			"Cosmetic_TavernaChairs01b",
			"Cosmetic_TavernaChairs01c",
			"Cosmetic_TavernaMusicStage01",
			"Cosmetic_TavernaMusicStage02",
			"Cosmetic_TavernaShrimpCocktails",
			"Cosmetic_TavernaCauldron01",
			"Cosmetic_TavernaCauldron02",

			-- Main
			"Cosmetic_MainHangingTassles01",
			"Cosmetic_MainHangingTassles01a",
			"Cosmetic_MainHangingTassles01b",
			"Cosmetic_MainHangingRope01",
			"Cosmetic_MainHangingRope01a",

			-- Moros Corner
			"Cosmetic_MorosScrolls",
			"Cosmetic_MorosSpools",
			"Cosmetic_MorosTerrain",
			"Cosmetic_MorosTentCanopy",
			"Cosmetic_MorosChaise",
			"Cosmetic_MorosRug",

			-- Artemis Corner
			"Cosmetic_ArtemisLyre",
			"Cosmetic_ArtemisTarget",
			"Cosmetic_ArtemisAmaranthus",
			"Cosmetic_ArtemisFlowerCircle01",
			"Cosmetic_ArtemisFlowerCircle01a",
			"Cosmetic_ArtemisFlowerCircle01b",

			-- Critters
			"Cosmetic_AmbientDogs",
			"Cosmetic_AmbientCats",
			"Cosmetic_AmbientFrogs",

			-- Fishing Pier
			"Cosmetic_Aquarium",
			"Cosmetic_FishingSign01",
			"Cosmetic_FishingSign01b",
			"Cosmetic_FishingSign01a",

			-- Eris Corner
			"Cosmetic_ErisWarningSign01",
			"Cosmetic_ErisTrashcan",
			"Cosmetic_ErisJerkyShelf",
			"Cosmetic_ErisRug",
		},
		-- Training Grounds
		{
			Name = "CosmeticsShop_PreRun",
			CacheName = "PreRun",
			BackingAnimation = "CosmeticsShopBacking_PreRun",
			GameStateRequirements =
			{
				-- None
			},
			-- Card Decks
			"Cosmetic_CardDeck01",
			"Cosmetic_CardDeck02",
			"Cosmetic_CardDeck03",
			"Cosmetic_CardDeck04",
			"Cosmetic_CardDeck07",
			"Cosmetic_CardDeck05",
			"Cosmetic_CardDeck06",
			"Cosmetic_CardDeck08",

			"Cosmetic_SkellyFloor01",
			"Cosmetic_SkellyFloor01a",
			"Cosmetic_SkellyFloor01b",
			"Cosmetic_TrainingDummy01",
			"Cosmetic_TrainingDummy01a",
			"Cosmetic_TrainingDummy01b",
			"Cosmetic_CatScratcher",
			"Cosmetic_BirdHouse",
			"Cosmetic_ExitCharm",
			"Cosmetic_ExitCharm02",
			"Cosmetic_ExitCharm03",
			"Cosmetic_ExitCharm04",
			"Cosmetic_ExitCharm05",
			"Cosmetic_SkellyZagreusStatue",

			-- Collectable Figurines
			"Cosmetic_CollectableShelf",
			"Cosmetic_CollectableHecate",
			"Cosmetic_CollectableOdysseus",
			"Cosmetic_CollectableSkelly",
			"Cosmetic_CollectableDora",
			"Cosmetic_CollectableNemesis",
			"Cosmetic_CollectableCharon",
			"Cosmetic_CollectableMoros",
			"Cosmetic_CollectableEris",
			"Cosmetic_CollectableIcarus",
			"Cosmetic_CollectableArtemis",
			"Cosmetic_CollectableSelene",
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

	ResourceSpendTextOffsetY = 11,

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
		OffsetX = 295,
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

	TooltipX = 1690,
	TooltipY = 1280,

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

	ItemAvailableAnimation = "GhostAdminScreenCauldronButton",
	ItemAvailableMouseOverAnimation = "GhostAdminScreenCauldronButtonIn",
	ItemAvailableMouseOffAnimation = "GhostAdminScreenCauldronButtonOut",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		UseNativeScreenCenter = true,

		Order =
		{
			"ShopBackgroundDim",
			"BackgroundBack",
			"DoraPortrait",
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
			GroupName = "Combat_Menu",
			AnimationName = "WeaponShopVignette",
			ScaleX = 30.0,
			ScaleY = 30.0,
			X = ScreenCenterX + 300,
			Y = ScreenCenterY,
			Color = { 1.0, 1.0, 1.0, 0.8 },
		},

		BackgroundBack = 
		{
			AnimationName = "CosmeticsShopBacking_HubMain",
			GroupName = "Combat_Menu",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.2,
		},

		ListBackground = 
		{
			Graphic = "WeaponShopBacking",
			GroupName = "Combat_Menu",
			X = 400,
			Y = 430,
			ScaleY = 0.77,
		},

		DoraPortrait =
		{
			AnimationName = "Portrait_Dora_Hardhat",
			GroupName = "Combat_Menu",
			X = 1600,
			Y = 560,
			Scale = 1,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.2,
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
				OnPressedFunctionName = "CosmeticShopScrollUp",
				ControlHotkey = "MenuUp",
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
				OnPressedFunctionName = "CosmeticShopScrollDown",
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
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
			Alpha = 0.8 

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
						OnPressedFunctionName = "CloseCosmeticsShopScreen",
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
		Queue = "Never",
		Cooldowns =
		{
			{ Name = "MelCosmeticsOpenedSpeech", Time = 60 },
		},
		{
			{
				RandomRemaining = true,
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
				{ Cue = "/VO/Dora_0659", Text = "Just got this in.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0660", Text = "New stuff in stock.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0661", Text = "Some stuff you haven't seen.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0662", Text = "Some new commissions.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
				},
				{ Cue = "/VO/Dora_0275", Text = "{#Emph}Behold, my latest works.",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0276", Text = "{#Emph}Witness my offerings!",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0663", Text = "{#Emph}New releases...",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
				{ Cue = "/VO/Dora_0664", Text = "{#Emph}I grant you new decor...!",
					PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
				},
			},
			{
				RandomRemaining = true,
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
			{ Cue = "/VO/Dora_0250", Text = "Though maybe we {#Emph}should?",
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