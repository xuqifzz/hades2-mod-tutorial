BadgeData =
{
	BaseBadge =
	{
		PanDuration = 2,
		DoVerticalPan = true,
		UseUnlockText = true,
		PreActivationHoldDuration = 1.0,
		PostActivationHoldDuration = 1.5,
		SetPlayerAnimation = "Melinoe_Witchcraft_Start",
		EndPlayerAnimation = "Melinoe_Witchcraft_End",
		RevealVoiceLines =
		{
			{ GlobalVoiceLines = "BadgeUpgradedVoiceLines" },
		},
	},

	-- Wraith (1-10)
	Badge_Rank01_Tier01 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerPBoss = 1,
			CosmeticsPoints = 1000,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_A1",
	},
	Badge_Rank01_Tier02 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerOBoss = 1,
			CosmeticsPoints = 1050,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_A2",
	},
	Badge_Rank01_Tier03 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerGBoss = 1,
			CosmeticsPoints = 1100,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_A3",
	},
	Badge_Rank01_Tier04 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerNBoss = 1,
			CosmeticsPoints = 1150,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_A4",
	},
	Badge_Rank01_Tier05 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			CardUpgradePoints = 1,
			CosmeticsPoints = 1200,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_A5",
	},
	Badge_Rank01_Tier06 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerFBoss = 1,
			CosmeticsPoints = 1250,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_A6",
	},
	Badge_Rank01_Tier07 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerHBoss = 1,
			CosmeticsPoints = 1300,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_A7",
	},
	Badge_Rank01_Tier08 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			WeaponPointsRare = 1,
			CosmeticsPoints = 1350,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_A8",
	},
	Badge_Rank01_Tier09 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerQBoss = 1,
			CosmeticsPoints = 1400,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_A9",
	},
	Badge_Rank01_Tier10 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerIBoss = 1,
			CosmeticsPoints = 1450,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_A10",
	},

	-- Specter (11-20)
	Badge_Rank02_Tier01 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerPBoss = 2,
			CosmeticsPoints = 1000,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_B1",
	},
	Badge_Rank02_Tier02 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerOBoss = 2,
			CosmeticsPoints = 1100,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_B2",
	},
	Badge_Rank02_Tier03 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerGBoss = 2,
			CosmeticsPoints = 1200,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_B3",
	},
	Badge_Rank02_Tier04 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerNBoss = 2,
			CosmeticsPoints = 1300,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_B4",
	},
	Badge_Rank02_Tier05 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			CardUpgradePoints = 2,
			CosmeticsPoints = 1400,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_B5",
	},
	Badge_Rank02_Tier06 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerFBoss = 2,
			CosmeticsPoints = 1500,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_B6",
	},
	Badge_Rank02_Tier07 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerHBoss = 2,
			CosmeticsPoints = 1600,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_B7",
	},
	Badge_Rank02_Tier08 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			WeaponPointsRare = 2,
			CosmeticsPoints = 1700,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_B8",
	},
	Badge_Rank02_Tier09 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerQBoss = 2,
			CosmeticsPoints = 1800,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_B9",
	},
	Badge_Rank02_Tier10 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerIBoss = 2,
			CosmeticsPoints = 1900,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_B10",
	},

	-- Revenant (21-30)
	Badge_Rank03_Tier01 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerPBoss = 3,
			CosmeticsPoints = 1000,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_C1",
	},
	Badge_Rank03_Tier02 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerOBoss = 3,
			CosmeticsPoints = 1150,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_C2",
	},
	Badge_Rank03_Tier03 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerGBoss = 3,
			CosmeticsPoints = 1300,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_C3",
	},
	Badge_Rank03_Tier04 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerNBoss = 3,
			CosmeticsPoints = 1450,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_C4",
	},
	Badge_Rank03_Tier05 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			CardUpgradePoints = 3,
			CosmeticsPoints = 1600,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_C5",
	},
	Badge_Rank03_Tier06 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerFBoss = 3,
			CosmeticsPoints = 1750,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_C6",
	},
	Badge_Rank03_Tier07 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerHBoss = 3,
			CosmeticsPoints = 1900,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_C7",
	},
	Badge_Rank03_Tier08 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			WeaponPointsRare = 3,
			CosmeticsPoints = 2050,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_C8",
	},
	Badge_Rank03_Tier09 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerQBoss = 3,
			CosmeticsPoints = 2200,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_C9",
	},
	Badge_Rank03_Tier10 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerIBoss = 3,
			CosmeticsPoints = 2350,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_C10",
	},

	-- Nightmare (31-40)
	Badge_Rank04_Tier01 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerPBoss = 4,
			CosmeticsPoints = 1000,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_D1",
	},
	Badge_Rank04_Tier02 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerOBoss = 4,
			CosmeticsPoints = 1200,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_D2",
	},
	Badge_Rank04_Tier03 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerGBoss = 4,
			CosmeticsPoints = 1400,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_D3",
	},
	Badge_Rank04_Tier04 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerNBoss = 4,
			CosmeticsPoints = 1600,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_D4",
	},
	Badge_Rank04_Tier05 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			CardUpgradePoints = 4,
			CosmeticsPoints = 1800,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_D5",
	},
	Badge_Rank04_Tier06 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerFBoss = 4,
			CosmeticsPoints = 2000,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_D6",
	},
	Badge_Rank04_Tier07 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerHBoss = 4,
			CosmeticsPoints = 2200,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_D7",
	},
	Badge_Rank04_Tier08 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			WeaponPointsRare = 4,
			CosmeticsPoints = 2400,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_D8",
	},
	Badge_Rank04_Tier09 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerQBoss = 4,
			CosmeticsPoints = 2600,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_D9",
	},
	Badge_Rank04_Tier10 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerIBoss = 4,
			CosmeticsPoints = 2800,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_D10",
	},

	-- Unseen (41-50)
	Badge_Rank05_Tier01 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerPBoss = 5,
			CosmeticsPoints = 1000,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_E1",
	},
	Badge_Rank05_Tier02 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerOBoss = 5,
			CosmeticsPoints = 1500,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_E2",
	},
	Badge_Rank05_Tier03 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerGBoss = 5,
			CosmeticsPoints = 2000,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_E3",
	},
	Badge_Rank05_Tier04 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerNBoss = 5,
			CosmeticsPoints = 2500,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_E4",
	},
	Badge_Rank05_Tier05 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			CardUpgradePoints = 5,
			CosmeticsPoints = 3000,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_E5",
	},
	Badge_Rank05_Tier06 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerFBoss = 5,
			CosmeticsPoints = 3500,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_E6",
	},
	Badge_Rank05_Tier07 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerHBoss = 5,
			CosmeticsPoints = 4000,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_E7",
	},
	Badge_Rank05_Tier08 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			WeaponPointsRare = 5,
			CosmeticsPoints = 4500,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_E8",
	},
	Badge_Rank05_Tier09 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerQBoss = 5,
			CosmeticsPoints = 5000,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_E9",
	},
	Badge_Rank05_Tier10 =
	{
		InheritFrom = { "BaseBadge" },
		ResourceCost =
		{
			MixerIBoss = 5,
			CosmeticsPoints = 5500,
		},
		Icon = "GUI\\Screens\\RankBadges\\RankBadges_E10",
	},
}

BadgeOrderData =
{
	"Badge_Rank01_Tier01",
	"Badge_Rank01_Tier02",
	"Badge_Rank01_Tier03",
	"Badge_Rank01_Tier04",
	"Badge_Rank01_Tier05",
	"Badge_Rank01_Tier06",
	"Badge_Rank01_Tier07",
	"Badge_Rank01_Tier08",
	"Badge_Rank01_Tier09",
	"Badge_Rank01_Tier10",

	"Badge_Rank02_Tier01",
	"Badge_Rank02_Tier02",
	"Badge_Rank02_Tier03",
	"Badge_Rank02_Tier04",
	"Badge_Rank02_Tier05",
	"Badge_Rank02_Tier06",
	"Badge_Rank02_Tier07",
	"Badge_Rank02_Tier08",
	"Badge_Rank02_Tier09",
	"Badge_Rank02_Tier10",

	"Badge_Rank03_Tier01",
	"Badge_Rank03_Tier02",
	"Badge_Rank03_Tier03",
	"Badge_Rank03_Tier04",
	"Badge_Rank03_Tier05",
	"Badge_Rank03_Tier06",
	"Badge_Rank03_Tier07",
	"Badge_Rank03_Tier08",
	"Badge_Rank03_Tier09",
	"Badge_Rank03_Tier10",

	"Badge_Rank04_Tier01",
	"Badge_Rank04_Tier02",
	"Badge_Rank04_Tier03",
	"Badge_Rank04_Tier04",
	"Badge_Rank04_Tier05",
	"Badge_Rank04_Tier06",
	"Badge_Rank04_Tier07",
	"Badge_Rank04_Tier08",
	"Badge_Rank04_Tier09",
	"Badge_Rank04_Tier10",

	"Badge_Rank05_Tier01",
	"Badge_Rank05_Tier02",
	"Badge_Rank05_Tier03",
	"Badge_Rank05_Tier04",
	"Badge_Rank05_Tier05",
	"Badge_Rank05_Tier06",
	"Badge_Rank05_Tier07",
	"Badge_Rank05_Tier08",
	"Badge_Rank05_Tier09",
	"Badge_Rank05_Tier10",
}