OverwriteTableKeys( WorldUpgradeData,
{
	-- Cosmetics
	DefaultCosmeticItem =
	{
		DebugOnly = true,
		Icon = "Shop_BedroomDecor",
		PanDuration = 1.0,
		PreActivationHoldDuration = 0.5,
		PostActivationHoldDuration = 1.5,
		Removable = true,

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
			},
			{
				RandomRemaining = true,
				-- SuccessiveChanceToPlay = 0.75,
				ObjectType = "NPC_Dora_01",
				Queue = "Always",

				{ Cue = "/VO/Dora_0111", Text = "Yeah, sure." },
				{ Cue = "/VO/Dora_0112", Text = "Whatever you say!" },
				{ Cue = "/VO/Dora_0113", Text = "I mean, I guess?" },
				{ Cue = "/VO/Dora_0114", Text = "{#Emph}Eh{#Prev}, why not." },
				{ Cue = "/VO/Dora_0247", Text = "You got it." },
				{ Cue = "/VO/Dora_0248", Text = "They don't pay me to think." },
				{ Cue = "/VO/Dora_0249", Text = "Or we can just mess with things." },
				{ Cue = "/VO/Dora_0250", Text = "Though maybe we should?" },
				{ Cue = "/VO/Dora_0251", Text = "Whatever!" },
				{ Cue = "/VO/Dora_0252", Text = "It's your stuff." },
				{ Cue = "/VO/Dora_0253", Text = "All right hold on." },
				{ Cue = "/VO/Dora_0254", Text = "Why not indeed." },
				{ Cue = "/VO/Dora_0255", Text = "It shall be done." },
				{ Cue = "/VO/Dora_0256", Text = "If that is your will." },
			},			
		},

		RevealReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.33,
				PreLineWait = 0.35,

				--[[
				-- { Cue = "/VO/Melinoe_1401", Text = "Always wanted something like this in the tent...",
					GameStateRequirements =
					{
						{
							Path = { "CurrentHubRoom", "Name" },
							Comparison = "==",
							Value = "Hub_Main"
						}
					},
				},
				]]--
				{ Cue = "/VO/Melinoe_1402", Text = "Should fit the spirit of this place..." },
				{ Cue = "/VO/Melinoe_1403", Text = "No harm in having just a bit of luxury..." },
				{ Cue = "/VO/Melinoe_1404", Text = "That ought to raise the Shades' morale a bit..." },
				{ Cue = "/VO/Melinoe_1407", Text = "Let's try this on for size." },
				{ Cue = "/VO/Melinoe_1408", Text = "You know what, sure." },
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

				{ Cue = "/VO/Dora_0257", Text = "Pretty spiffy." },
				{ Cue = "/VO/Dora_0258", Text = "Guess it's OK...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1402" },
						},
					},
				},
				{ Cue = "/VO/Dora_0259", Text = "None whatsoever.",
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
				{ Cue = "/VO/Dora_0261", Text = "Not too shabby." },
				{ Cue = "/VO/Dora_0262", Text = "There we go." },
				{ Cue = "/VO/Dora_0263", Text = "All set." },
				{ Cue = "/VO/Dora_0264", Text = "Boom." },
			},
		},
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",
	},

	-- Tent Cosmetics
	Cosmetic_TentBlanket01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_SwatchTeal",
		Cost =
		{
			CosmeticsPointsCommon = 40,
		},
		GameStateRequirements =
		{
			-- None
		},
		ActivateIds =
		{
			560894,
		},
		DeactivateIds =
		{
			--560894,
			566380,
			566378,			
		},
		RemoveCosmetics =
		{
			"Cosmetic_TentBlanket01a",
			"Cosmetic_TentBlanket01b",
		},
		RotateOnly = true,
	},

	Cosmetic_TentBlanket01a =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_TentBlanket01", },
		Icon = "CosmeticIcon_SwatchRed",
		Cost =
		{
			CosmeticsPointsCommon = 50,
			CosmeticsPointsRare = 5,
		},
		GameStateRequirements =
		{
			-- None
		},
		ActivateIds =
		{
			566380,
		},
		DeactivateIds =
		{
			560894,
			--566380,
			566378,			
		},
		RemoveCosmetics =
		{
			"Cosmetic_TentBlanket01",
			"Cosmetic_TentBlanket01b",
		},
	},

	Cosmetic_TentBlanket01b =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_TentBlanket01", },
		Icon = "CosmeticIcon_SwatchGrey",
		Cost =
		{
			CosmeticsPointsCommon = 70,
			CosmeticsPointsRare = 10,
		},
		GameStateRequirements =
		{
			-- None
		},
		ActivateIds =
		{
			566378,
		},
		DeactivateIds =
		{
			560894,
			566380,
			--566378,
		},
		RemoveCosmetics =
		{
			"Cosmetic_TentBlanket01",
			"Cosmetic_TentBlanket01a",
		},
	},

	Cosmetic_TentMoodcrystal01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_SwatchGold",
		Cost =
		{
			CosmeticsPointsCommon = 90,
			CosmeticsPointsEpic = 5,
		},
		GameStateRequirements =
		{
			-- None
		},
		ActivateIds =
		{
			561038,
		},
	},

	--[[
	Cosmetic_TentRugBrown =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_SwatchGold",
		Cost =
		{
			CosmeticsPointsCommon = 20,
		},
		GameStateRequirements =
		{
			-- None
		},
		SetColorIds =
		{
			560911,
		},
		SetColorValue = { 148, 99, 27, 255 },
		RemoveCosmetics =
		{
			"Cosmetic_TentRugPurple",
			"Cosmetic_TentRugGrey",
			"Cosmetic_TentRugRed",
		},
		RotateOnly = true,
		RevealGlobalVoiceLines = "TrimColorResponseVoiceLines",
		RevealReactionGlobalVoiceLines = "HadesTrimColorReactionVoiceLines",
	},

	Cosmetic_TentRugPurple =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_TentRugBrown", },
		Icon = "CosmeticIcon_SwatchPurple",
		Cost =
		{
			MetaCurrency = 10,
		},
		GameStateRequirements =
		{
			-- None
		},
		SetColorValue = { 110, 105, 207, 255 },
		RemoveCosmetics =
		{
			"Cosmetic_TentRugBrown",
			"Cosmetic_TentRugGrey",
			"Cosmetic_TentRugRed",
		},
	},

	Cosmetic_TentRugGrey =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_TentRugBrown", },
		Icon = "CosmeticIcon_SwatchGrey",
		Cost =
		{
			MetaCurrency = 10,
		},
		GameStateRequirements =
		{
			-- None
		},
		SetColorValue = { 125, 125, 125, 255 },
		RemoveCosmetics =
		{
			"Cosmetic_TentRugBrown",
			"Cosmetic_TentRugPurple",
			"Cosmetic_TentRugRed",
		},
	},

	Cosmetic_TentRugRed =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_TentRugBrown" },
		Icon = "CosmeticIcon_SwatchRed",
		SetColorValue = { 194, 57, 45, 255 },
		Cost =
		{
			MetaCurrency = 10,
		},
		GameStateRequirements =
		{
			-- None
		},
		RemoveCosmetics =
		{
			"Cosmetic_TentRugBrown",
			"Cosmetic_TentRugGrey",
			"Cosmetic_TentRugPurple",
		},
	},
	]]

	-- Main Cosmetics
	Cosmetic_MainLantern01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_SwatchGrey",
		Cost =
		{
			CosmeticsPointsRare = 10,
			CosmeticsPointsEpic = 1,
		},
		GameStateRequirements =
		{
			-- None
		},
		SetAnimations =
		{
			CrossroadsLantern01 = "CrossroadsLantern01Float",
		},
		RemoveCosmetics =
		{
			"Cosmetic_MainLantern01a",
			"Cosmetic_MainLantern01b",
		},
		RotateOnly = true,
	},

	Cosmetic_MainLantern01a =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_MainLantern01", },
		Icon = "CosmeticIcon_SwatchPurple",
		Cost =
		{
			CosmeticsPointsCommon = 10,
		},
		GameStateRequirements =
		{
			-- None
		},
		SetAnimations =
		{
			CrossroadsLantern01 = "Tilesets\\Crossroads\\Crossroads_Lantern_01a",
		},
		RemoveCosmetics =
		{
			"Cosmetic_MainLantern01",
			"Cosmetic_MainLantern01b",
		},
	},

	Cosmetic_MainLantern01b =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_MainLantern01" },
		Icon = "CosmeticIcon_SwatchTeal",
		Cost =
		{
			CosmeticsPointsEpic = 1,
		},
		GameStateRequirements =
		{
			-- None
		},
		SetAnimations =
		{
			CrossroadsLantern01 = "Tilesets\\Crossroads\\Crossroads_Lantern_01b",
		},
		RemoveCosmetics =
		{
			"Cosmetic_MainLantern01",
			"Cosmetic_MainLantern01a",
		},
	},

	Cosmetic_MainCrystalBall01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_SwatchBone",
		Cost =
		{
			CosmeticsPointsRare = 40,
			CosmeticsPointsEpic = 20,
		},
		GameStateRequirements =
		{
			-- None
		},
		ActivateIds =
		{
			566330,
		},
	},

	-- PreRun Cosmetics

	Cosmetic_PreRunTerrainA =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_SwatchGrey",
		Cost =
		{
			CosmeticsPointsCommon = 50,
		},
		GameStateRequirements =
		{
			-- None
		},
		ActivateIds =
		{
			566376,
		},
		DeactivateIds =
		{
			--566376,
			566374,
			566373,			
		},
		RemoveCosmetics =
		{
			"Cosmetic_PreRunTerrainB",
			"Cosmetic_PreRunTerrainC",
		},
		RotateOnly = true,
	},

	Cosmetic_PreRunTerrainB =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_PreRunTerrainA", },
		Icon = "CosmeticIcon_SwatchPurple",
		Cost =
		{
			CosmeticsPointsCommon = 100,
		},
		GameStateRequirements =
		{
			-- None
		},
		ActivateIds =
		{
			566374,
		},
		DeactivateIds =
		{
			566376,
			--566374,
			566373,			
		},
		RemoveCosmetics =
		{
			"Cosmetic_PreRunTerrainA",
			"Cosmetic_PreRunTerrainC",
		},
	},

	Cosmetic_PreRunTerrainC =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_PreRunTerrainA", },
		Icon = "CosmeticIcon_SwatchBone",
		Cost =
		{
			CosmeticsPointsRare = 50,
		},
		GameStateRequirements =
		{
			-- None
		},
		ActivateIds =
		{
			566373,
		},
		DeactivateIds =
		{
			566376,
			566374,
			--566373,
		},
		RemoveCosmetics =
		{
			"Cosmetic_PreRunTerrainA",
			"Cosmetic_PreRunTerrainB",
		},
	},

	Cosmetic_PreRunFrogPond01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_SwatchGold",
		Cost =
		{
			CosmeticsPointsCommon = 60,
			CosmeticsPointsRare = 30,
			CosmeticsPointsEpic = 10,
		},
		GameStateRequirements =
		{
			-- None
		},
		ToggleCollision = true,
		ActivateIds =
		{
			588293,
		},
	},
})