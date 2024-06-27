MetaUpgradeDefaultCardLayout = 
{
	{ "ChanneledCast",			"HealthRegen",			"LowManaDamageBonus",	"CastCount",			"SorceryRegenUpgrade", },
	{ "CastBuff",				"BonusHealth",			"BonusDodge",			"ManaOverTime",		"MagicCrit" },
	{ "SprintShield",			"LastStand",			"MaxHealthPerRoom",		"StatusVulnerability",	"ChanneledBlock" },
	{ "DoorReroll",				"StartingGold",			"MetaToRunUpgrade",	"RarityBoost", 			"BonusRarity" },
	{ "TradeOff",				"ScreenReroll",			"LowHealthBonus",		"EpicRarityBoost",		"CardDraw" },
}

MetaUpgradeSwapGameStateRequirement = 
{
	{
		PathTrue = { "LockedRequirement" },
		--PathTrue = { "GameState", "MetaUpgradeState", "BonusDoubler", "Unlocked", },
	},
}

MetaUpgradeCostData = 
{
	StartingMetaUpgradeLimit = 100,		-- Base metaupgrade 'MEM' limit
	MetaUpgradeLevelData = 
	{
		{ CostIncrease = 2, ResourceCost = { MemPointsCommon = 40 }},
		{ CostIncrease = 2, ResourceCost = { MemPointsCommon = 45 }},
		{ CostIncrease = 2, ResourceCost = { MemPointsCommon = 50 }},
		{ CostIncrease = 2, ResourceCost = { MemPointsCommon = 100 }},
		{ CostIncrease = 2, ResourceCost = { MemPointsCommon = 120 }},

		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 150 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 170 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 200 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 230 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 240 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 260 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 290 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 320 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 350 }},

		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 1000, Mixer6Common = 3, MixerShadow = 3 }},
	}
}

MetaUpgradeCardData = 
{
	BaseMetaUpgrade = 
	{
		DebugOnly = true,
		Cost = 1,
		Image = "Codex_Portrait_SurfaceBiome",
		IconScale = 0.2,
		ResourceCost = 
		{
			MetaCardPointsCommon = 10,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2, },
			{ CardUpgradePoints = 4, },
		}
	},

	BaseBonusMetaUpgrade =
	{
		Cost = 0,
		DebugOnly = true,
		Image = "CardArt_01",
		IconScale = 0.2,
		ResourceCost = 
		{
			MetaCardPointsCommon = 10,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2, },
			{ CardUpgradePoints = 4, },
		},
	},

	----------------------------------

	ChanneledCast = 
	{
		InheritFrom = { "BaseMetaUpgrade" },
		StartUnlocked = false,
		Cost = 1,
		Image = "CardArt_01",
		--StartEquipped = true,
		TraitName = "ChannelSlowMetaUpgrade",
		Type = "Time",

		ResourceCost = 
		{
			MetaCardPointsCommon = 1,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 1 },
			{ CardUpgradePoints = 3, PlantFMoly = 6 },
		},

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_0781", Text = "The Sorceress." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0781", Text = "The Sorceress." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "ChanneledCast_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	HealthRegen =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		StartUnlocked = false,
		Image = "CardArt_02",
		TraitName = "DoorHealMetaUpgrade",
		CustomTrayText = "DodgeBonusMetaUpgrade_Tray",
		Type = "Life",

		ResourceCost = 
		{
			MetaCardPointsCommon = 3,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2 },
			{ CardUpgradePoints = 3, OreFSilver = 10, },
		},

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2983", Text = "The Wayward Son." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2983", Text = "The Wayward Son." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "HealthRegen_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	LowManaDamageBonus = 
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "LowManaDamageMetaupgrade",

		Image = "CardArt_03",
		Cost = 2,
		ResourceCost = 
		{
			MetaCardPointsCommon = 10,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2 },
			{ CardUpgradePoints = 4, PlantGLotus = 8, },
		},

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_1147", Text = "The Huntress." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1147", Text = "The Huntress." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "LowManaDamageBonus_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	MagicCrit = 
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "MagicCritMetaUpgrade",
		Cost = 3,
		

		Image = "CardArt_10",
		ResourceCost = 
		{
			MetaCardPointsCommon = 30,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3, },
			{ CardUpgradePoints = 6, OreGLime = 15 },
		},

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_1455", Text = "Death." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1455", Text = "Death." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "MagicCrit_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	BonusDodge = 
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Cost = 1,
		Image = "CardArt_08",
		ResourceCost = 
		{
			MetaCardPointsCommon = 20,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 5, PlantGCattail = 10, },
		},
		--[[
		AutoEquipRequirements = 
		{
			MinDuplicateCount = 3,
		},
		]]
		TraitName = "DodgeBonusMetaUpgrade",
		CustomTrayText = "DodgeBonusMetaUpgrade_Tray",

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_0998", Text = "The Messenger." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0998", Text = "The Messenger." },
			},
		},

		--AutoEquipText = "BonusDodge_AutoEquip",
		FlavorTextData = 
		{
			{
				Name = "BonusDodge_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	----------------------------------

	CastBuff =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 2,
		Image = "CardArt_06",
		StartUnlocked = false,
		TraitName = "InsideCastBuffMetaUpgrade",
		Type = "Death",

		ResourceCost = 
		{
			MetaCardPointsCommon = 3,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2 },
			{ CardUpgradePoints = 4, PlantFNightshade = 10, },
		},

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2984", Text = "The Furies." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2984", Text = "The Furies." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "CastBuff_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	BonusHealth = 
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Cost = 2,
		Image = "CardArt_07",
		ResourceCost = 
		{
			MetaCardPointsCommon = 7,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2 },
			{ CardUpgradePoints = 4, OreNBronze = 6 },
		},
		TraitName = "HealthManaBonusMetaUpgrade",
		CustomTrayText = "HealthManaBonusMetaUpgrade_Tray",

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_1998", Text = "The Titan." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1998", Text = "The Titan." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "BonusHealth_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	ManaOverTime = 
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "ManaOverTimeMetaUpgrade",
		Type = "Soul",
		Cost = 5,
		Image = "CardArt_09",
		ResourceCost = 
		{
			MetaCardPointsCommon = 25,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 5 },
			{ CardUpgradePoints = 10, PlantHMyrtle = 8, },
		},

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2985", Text = "The Unseen." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2985", Text = "The Unseen." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "ManaOverTime_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	SorceryRegenUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "SorceryRegenMetaUpgrade",
		Cost = 0,
		Image = "CardArt_05",
		ResourceCost = 
		{
			MetaCardPointsCommon = 20,
			MixerGBoss = 1,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 6, MixerGBoss = 5, },
		},

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2791", Text = "The Moon." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1145", Text = "The Moon." },
				{ Cue = "/VO/Melinoe_2791", Text = "The Moon." },
			},
		},

		AutoEquipRequirements = 
		{
			SurroundEquipped = true,
			MetaUpgradeName = "SorceryRegenUpgrade"
		},
		AutoEquipText = "SorceryRegenUpgrade_AutoEquip",

		FlavorTextData = 
		{
			{
				Name = "SorceryRegenUpgrade_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	ChanneledBlock =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "BossShieldMetaUpgrade",
		Cost = 3,
		Image = "CardArt_15",
		ResourceCost = 
		{
			MetaCardPointsCommon = 35,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 8, OreOIron = 8 },
		},
		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_1459", Text = "The Lovers." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1459", Text = "The Lovers." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "ChanneledBlock_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	----------------------------------

	SprintShield =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 1,
		Image = "CardArt_11",
		ResourceCost = 
		{
			MetaCardPointsCommon = 10,
		},
		TraitName = "SprintShieldMetaUpgrade",
		ActiveWhileDead = true,
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 1, },
			{ CardUpgradePoints = 3, MixerNBoss = 3 },
		},

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_0996", Text = "The Swift Runner." },
			{ Cue = "/VO/Melinoe_0784", Text = "The Swift Runner." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0996", Text = "The Swift Runner." },
				{ Cue = "/VO/Melinoe_0784", Text = "The Swift Runner." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "DodgeSprint_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	LastStand = 
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 4,
		Image = "CardArt_12",
		ResourceCost = 
		{
			MetaCardPointsCommon = 20,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 6 },
			{ CardUpgradePoints = 12, Mixer5Common = 1 },
		},
		TraitName = "LastStandSlowTimeMetaUpgrade",
		OnGrantedFunctionName = "GrantMetaUpgradeLastStands",
		OnUpgradedFunctionName = "UpgradeMetaUpgradeLastStands",
		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_0997", Text = "Eternity." },
			{ Cue = "/VO/Melinoe_0785", Text = "Eternity." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0997", Text = "Eternity." },
				{ Cue = "/VO/Melinoe_0785", Text = "Eternity." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "LastStand_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	MaxHealthPerRoom =
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Cost = 0,
		Image = "CardArt_13",
		ResourceCost = 
		{
			MetaCardPointsCommon = 25,
			MixerFBoss = 1,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3, },
			{ CardUpgradePoints = 6, OreHGlassrock = 8 },
		},

		AutoEquipRequirements = 
		{
			HasCostsThrough = 5
		},
		TraitName = "ChamberHealthMetaUpgrade",

		AutoEquipText = "MaxHealthPerRoom_AutoEquip",

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2986", Text = "The Centaur." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2986", Text = "The Centaur." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "MaxHealthPerRoom_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	CastCount = 
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "CastDamageMetaUpgrade",
		Cost = 2,
		Image = "CardArt_04",
		ResourceCost = 
		{
			MetaCardPointsCommon = 15,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 4 },
			{ CardUpgradePoints = 8, PlantNMoss = 10 },
		},

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2987", Text = "Night." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2987", Text = "Night." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "CastCount_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	LowHealthBonus =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "LowHealthBuffMetaUpgrade",
		DamageResistancePlaceholder = -30,
		Cost = 4,
		Image = "CardArt_23",
		ResourceCost = 
		{
			MetaCardPointsCommon = 35,
		},

		UpgradeResourceCost = 
		{
			-- Replace with grown Olympus plant
			{ CardUpgradePoints = 8 },
			{ CardUpgradePoints = 15, PlantIPoppy = 8 },
		},

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2988", Text = "Strength." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2988", Text = "Strength." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "LowHealthBonus_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	----------------------------------
	
	DoorReroll =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 3,
		Image = "CardArt_16",
		ResourceCost = 
		{
			MetaCardPointsCommon = 15,
		},
		TraitName = "DoorRerollMetaUpgrade",
		OnGrantedFunctionName = "GrantMetaUpgradeRerolls",
		OnUpgradedFunctionName = "UpgradeMetaUpgradeRerolls",
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 6, MetaFabric = 12 },
		},

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_1456", Text = "The Fates." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1456", Text = "The Fates." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "DoorReroll_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	StartingGold =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 5,
		Image = "CardArt_17",
		ResourceCost = 
		{
			MetaCardPointsCommon = 25,
		},
		TraitName = "StartingGoldMetaUpgrade",
		OnGrantedFunctionName = "GrantMetaUpgradeCurrency",
		OnUpgradedFunctionName = "UpgradeMetaUpgradeCurrency",

		UpgradeResourceCost = 
		{
			-- Replace with Olympus Ore
			{ CardUpgradePoints = 6 },
			{ CardUpgradePoints = 12, OreIMarble = 10 },
		},

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2792", Text = "The Boatman." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2792", Text = "The Boatman." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "StartingGold_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	StatusVulnerability =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "EffectVulnerabilityMetaUpgrade",
		Cost = 5,
		Image = "CardArt_14",
		ResourceCost = 
		{
			MetaCardPointsCommon = 30,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 5, PlantNGarlic = 8, },
		},

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2789", Text = "Origination." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2789", Text = "Origination." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "StatusVulnerability_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},		
	},

	RarityBoost =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 5,
		Image = "CardArt_19",
		ResourceCost = 
		{
			MetaCardPointsCommon = 35,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 6, MetaFabric = 6 },
		},

		TraitName = "RarityBoostMetaUpgrade",

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_1460", Text = "Excellence." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1460", Text = "Excellence." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "RarityBoost_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	BonusRarity =
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Cost = 0,
		Image = "CardArt_20",
		ResourceCost = 
		{
			MetaCardPointsCommon = 40,
			MixerHBoss = 1,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2 },
			{ CardUpgradePoints = 4, MetaFabric = 12, },
		},
		AutoEquipRequirements = 
		{
			MaxDuplicateCount = 2,
			RequiredMetaUpgradesMin = 1,
		},
		TraitName = "DuoRarityBoostMetaUpgrade",
		CustomTrayText = "DuoRarityBoostMetaUpgrade_Tray",

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2790", Text = "The Queen." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2790", Text = "The Queen." },
			},
		},

		AutoEquipText = "BonusRarity_AutoEquip",
		FlavorTextData = 
		{
			{
				Name = "BonusRarity_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	----------------------------------

	TradeOff = 
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 0,
		Image = "CardArt_21",
		ResourceCost = 
		{
			MetaCardPointsCommon = 20,
			MixerNBoss = 1,
		},
		UpgradeResourceCost = 
		{
			-- Replace with picked Ships plant
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 5, MixerIBoss = 3, },
		},
		TraitName = "RerollTradeOffMetaUpgrade",
		OnGrantedFunctionName = "GrantMetaUpgradeRerolls",
		OnUpgradedFunctionName = "UpgradeMetaUpgradeRerolls",

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_0783", Text = "The Seer." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0783", Text = "The Seer." },
			},
		},

		AutoEquipRequirements = 
		{
			SurroundAllEquipped = true,
			MetaUpgradeName = "TradeOff"
		},

		AutoEquipText = "TradeOff_AutoEquip",
		FlavorTextData = 
		{
			{
				Name = "TradeOff_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	ScreenReroll =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 4,
		Image = "CardArt_22",
		ResourceCost = 
		{
			MetaCardPointsCommon = 30,
		},
		TraitName = "PanelRerollMetaUpgrade",
		OnGrantedFunctionName = "GrantMetaUpgradeRerolls",
		OnUpgradedFunctionName = "UpgradeMetaUpgradeRerolls",

		UpgradeResourceCost = 
		{
			-- Replace with Olympus picked plant
			{ CardUpgradePoints = 5 },
			{ CardUpgradePoints = 10, PlantIShaderot = 9, },
		},

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_1457", Text = "The Champions." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1457", Text = "The Champions." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "ScreenReroll_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	MetaToRunUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "MetaToRunMetaUpgrade",
		Cost = 3,
		Image = "CardArt_18",
		ResourceCost = 
		{
			MetaCardPointsCommon = 30,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 5, PlantOMandrake = 3 },
		},


		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2989", Text = "The Artificer." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2989", Text = "The Artificer." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "MetaToRunUpgrade_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	EpicRarityBoost =
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Image = "CardArt_24",
		ResourceCost = 
		{
			MetaCardPointsCommon = 40,
			MixerOBoss = 1,
		},
		TraitName = "EpicRarityBoostMetaUpgrade",
		
		AutoEquipText = "EpicRarity_AutoEquip_Alt",
		AutoEquipRequirements = 
		{
			MetaUpgradeName = "EpicRarityBoost",
			OtherRowOrColumnEquipped = true,
			CardsRequired = 5, -- used for text
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 5, MixerHBoss = 5, },
		},

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2990", Text = "Divinity." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2990", Text = "Divinity." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "EpicRarityBoost_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},

	CardDraw =
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Image = "CardArt_25",
		ResourceCost = 
		{
			MetaCardPointsCommon = 50,
			MixerIBoss = 1, -- Replace with MixerPBoss
		},
		TraitName = "BossProgressionMetaUpgrade",
		
		AutoEquipText = "CardDraw_AutoEquip",
		AutoEquipRequirements = 
		{
			RequiredMetaUpgradesMax = 3,
			RequiredMetaUpgradesMin = 1,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 10, PlantChaosThalamus = 2, MetaFabric = 10, MixerIBoss = 1 },
			{ CardUpgradePoints = 20, PlantChaosThalamus = 4, MetaFabric = 25, MixerIBoss = 3 },
		},

		UnlockedCardVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_2991", Text = "Judgment." },
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2991", Text = "Judgment." },
			},
		},

		FlavorTextData = 
		{
			{
				Name = "CardDraw_FlavorText01",
				GameStateRequirements =
				{
					{
						--
					}
				},
			}
		},
	},
}

MetaUpgradeData =
{
	BaseMetaUpgrade =
	{		
	},

	-- Shrine/Difficulty/Heat MetaUpgrades
	HealingReductionShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_HealingReduction",
		InactiveChangeValue = 1.0,
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				Multiply = 100,
				NewProperty = "DisplayValue",
			},
		},
		Ranks =
		{
			{ Points = 1, ChangeValue = 0.75 },
			{ Points = 1, ChangeValue = 0.50 },
			{ Points = 2, ChangeValue = 0.00 },
		},
		FlavorText = "HealingReductionShrineUpgrade_Flavor",
	},

	ShopPricesShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_ShopPrices",
		InactiveChangeValue = 1.0,
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				Multiply = 100,
				Add = -100,
				NewProperty = "DisplayValue",
			},
		},
		Ranks =
		{
			{ Points = 1, ChangeValue = 1.4 },
			{ Points = 1, ChangeValue = 1.8 },
		},
		FlavorText = "ShopPricesShrineUpgrade_Flavor",
	},

	EnemyHealthShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_EnemyHealth",
		InactiveChangeValue = 1.0,
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				Multiply = 100,
				Add = -100,
				NewProperty = "DisplayValue",
			},
		},
		Ranks =
		{
			{ Points = 1, ChangeValue = 1.1 },
			{ Points = 1, ChangeValue = 1.2 },
			{ Points = 1, ChangeValue = 1.3 },
		},
		FlavorText = "EnemyHealthShrineUpgrade_Flavor",
	},

	EnemyDamageShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_EnemyDamage",
		InactiveChangeValue = 1.0,
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				Multiply = 100,
				Add = -100,
				NewProperty = "DisplayValue",
			},
		},
		Ranks =
		{
			{ Points = 1, ChangeValue = 1.2 },
			{ Points = 2, ChangeValue = 1.6 },
			{ Points = 2, ChangeValue = 2.0 },
		},
		SelectedVoiceLines =
		{
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,
			SuccessiveChanceToPlay = 0.35,
			Cooldowns =
			{
				{ Name = "MelinoeShrineUpgradeSpeech", Time = 4 },
			},

			-- { Cue = "/VO/Melinoe_2893", Text = "{#Emph}Bask in Pain." },
		},
		FlavorText = "EnemyDamageShrineUpgrade_Flavor",
	},

	EnemySpeedShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_EnemySpeed",
		InactiveChangeValue = 1.0,
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				Multiply = 100,
				Add = -100,
				NewProperty = "DisplayValue",
			},
		},
		Ranks =
		{
			{ Points = 3, ChangeValue = 1.2 },
			{ Points = 3, ChangeValue = 1.4 },
		},
		FlavorText = "EnemySpeedShrineUpgrade_Flavor",
	},

	EnemyShieldShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_ShieldHealth",
		InactiveChangeValue = 0,
		Ranks =
		{
			{ Points = 1, ChangeValue = 1 },
			{ Points = 1, ChangeValue = 2 },
		},
		SelectedVoiceLines =
		{
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,
			SuccessiveChanceToPlay = 0.35,
			Cooldowns =
			{
				{ Name = "MelinoeShrineUpgradeSpeech", Time = 4 },
			},
			-- { Cue = "/VO/Melinoe_2894", Text = "{#Emph}Pierce the Skin." },
		},
		FlavorText = "EnemyShieldShrineUpgrade_Flavor",
	},

	EnemyCountShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_EnemyCount",
		InactiveChangeValue = 1.0,
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				Multiply = 100,
				Add = -100,
				NewProperty = "DisplayValue",
			},
		},
		Ranks =
		{
			{ Points = 1, ChangeValue = 1.2 },
			{ Points = 1, ChangeValue = 1.4 },
			{ Points = 1, ChangeValue = 1.6 },
		},
		FlavorText = "EnemyCountShrineUpgrade_Flavor",
	},

	EnemyRespawnShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_ForceSell",
		InactiveChangeValue = 0.0,
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				Multiply = 100,
				NewProperty = "DisplayValue",
			},
		},
		SpawnForceMin = 800,
		SpawnForceMax = 1200,
		UseableDelay = 0.5,
		Ranks =
		{
			{ Points = 1, ChangeValue = 0.25 },
			{ Points = 1, ChangeValue = 0.50 },
			--{ Points = 1, ChangeValue = 0.90 },
		},
		FlavorText = "EnemyRespawnShrineUpgrade_Flavor",
	},

	NextBiomeEnemyShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_NextBiomeEnemy",
		InactiveChangeValue = 0.0,
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				Multiply = 100,
				NewProperty = "DisplayValue",
			},
		},
		Ranks =
		{
			{ Points = 1, ChangeValue = 0.10 },
			{ Points = 2, ChangeValue = 0.25 },
		},
		BiomeEnemySets =
		{
			F = EnemySets.BiomeG,
			G = EnemySets.BiomeH,
			H = EnemySets.BiomeI,
			N = EnemySets.BiomeO,
		},
		SwapMap =
		{
			-- Erebus
			Guard = { Name = "Guard2", },
			Guard_Elite = { Name = "Guard2_Elite", },
			Brawler = { Name = "FishmanMelee", },
			Brawler_Elite = { Name = "FishmanMelee_Elite", },
			Radiator = { Name = "Radiator2", },
			Radiator_Elite = { Name = "Radiator2_Elite", },
			Screamer = { Name = "FishSwarmerSquad", },
			Screamer_Elite = { Name = "FishSwarmerSquad_Elite", },
			Mage = { Name = "FishmanRanged", },
			Mage_Elite = { Name = "FishmanRanged_Elite", },
			SiegeVine = { Name = "Turtle", },
			SiegeVine_Elite = { Name = "Turtle_Elite", },
			Wisp = { Name = "Guard2", },
			Wisp_Elite = { Name = "Guard2_Elite", },

			-- Oceanus
			FishmanMelee = { Name = "Mourner", RequiredSpawnPoint = "EnemyPoint", },
			FishmanMelee_Elite = { Name = "Mourner_Elite", RequiredSpawnPoint = "EnemyPoint", },
			FishmanRanged = { Name = "Lamia", RequiredSpawnPoint = "EnemyPoint", },
			FishmanRanged_Elite = { Name = "Lamia_Elite", RequiredSpawnPoint = "EnemyPoint", },
			FishSwarmerSquad = { Name = "LycanSwarmer", RequiredSpawnPoint = "EnemyPoint", },
			--FishSwarmerSquad_Elite = { Name = "LycanSwarmer_Elite", RequiredSpawnPoint = "EnemyPoint", },
			Turtle = { Name = "DespairElemental", RequiredSpawnPoint = "EnemyPoint", },
			Turtle_Elite = { Name = "DespairElemental_Elite", RequiredSpawnPoint = "EnemyPoint", },
			WaterUnit = { Name = "Lovesick", RequiredSpawnPoint = "EnemyPoint", },
			WaterUnit_Elite = { Name = "Lovesick_Elite", RequiredSpawnPoint = "EnemyPoint", },
			Guard2 = { Name = "CorruptedShadeMedium", RequiredSpawnPoint = "EnemyPoint", },
			Guard2_Elite = { Name = "CorruptedShadeMedium_Elite", RequiredSpawnPoint = "EnemyPoint", },
			Radiator2 = { Name = "CorruptedShadeSmall", RequiredSpawnPoint = "EnemyPoint", },
			Radiator2_Elite = { Name = "CorruptedShadeSmall_Elite", RequiredSpawnPoint = "EnemyPoint", },

			-- Fields
			BrokenHearted = { Name = "SwarmerClockwork", },
			BrokenHearted_Elite = { Name = "SwarmerClockwork_Elite", },
			Lovesick = { Name = "TimeElemental", },
			Lovesick_Elite = { Name = "TimeElemental_Elite", },
			--Lycanthrope = { Name = "ClockworkHeavyMelee", },
			--Lycanthrope_Elite banned
			Mourner = { Name = "ClockworkHeavyMelee", },
			Mourner_Elite = { Name = "ClockworkHeavyMelee_Elite", },
			Lamia = { Name = "SatyrLancer", },
			Lamia_Elite = { Name = "SatyrLancer_Elite", },
			--Screamer2 banned
			--FogEmitter2 banned

			-- Ephyra
			Carrion = { Name = "Scimiterror", },
			Carrion_Elite = { Name = "Scimiterror_Elite", },
			Mudman = { Name = "Stickler", },
			Mudman_Elite = { Name = "Stickler_Elite", },
			Zombie = { Name = "WaterElemental", },
			Zombie_Elite = { Name = "WaterElemental_Elite", },
			ZombieSpawner = { Name = "Swab", },
			ZombieSpawner_Elite = { Name = "Swab_Elite", },
			ZombieHeavyRanged = { Name = "HarpyCutter", },
			ZombieHeavyRanged_Elite = { Name = "HarpyCutter_Elite", },
			ZombieAssassin = { Name = "Drunk", },
			ZombieAssassin_Elite = { Name = "Drunk_Elite", },
		},
		FlavorText = "NextBiomeEnemyShrineUpgrade_Flavor",
	},

	BiomeSpeedShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_BiomeSpeed",
		InactiveChangeValue = 9999,
		InactiveDisplayValue = "Text_Infinity_Symbol",
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				UseTimeString = true,
				NewProperty = "DisplayValue",
			},
		},
		Ranks =
		{
			-- F = { 300, 240, 180, 150 },
			{ Points = 1, ChangeValue = 540 },
			{ Points = 2, ChangeValue = 420 },
			{ Points = 3, ChangeValue = 300 },
		},
		FlavorText = "BiomeSpeedShrineUpgrade_Flavor",
		OnDisabledFunctionName = "DisableBiomeSpeedShrineUpgrade",
	},

	MinibossCountShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_MinibossCount",
		InactiveChangeValue = 0,
		Ranks =
		{
			{ Points = 1, ChangeValue = 1 },
			{ Points = 1, ChangeValue = 2 },
		},
		FlavorText = "MinibossCountShrineUpgrade_Flavor",
	},

	--[[
	BossDifficultyShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_BossDifficulty",
		Starting = true,
		CostTable = { 1, 2, 3, 4 },
		ShortTotal = "BossDifficultyShrineUpgrade_ShortTotal",
		ChangeValue = 1,
		GameStateRequirements =
		{
			--RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" }
		},
		RankGameStateRequirements = 
		{
			[4] = { RequiredCosmetics = { "HadesEMFight"}}
		},
		FlavorText = "BossDifficultyShrineUpgrade_Flavor",
	},
	]]

	BoonSkipShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_NoInvulnerability",
		InactiveChangeValue = 0,
		Ranks =
		{
			{ Points = 3, ChangeValue = 1 },
		},
		FlavorText = "BoonSkipShrineUpgrade_Flavor",
	},

	BoonManaReserveShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_PrimeUpgrade",
		InactiveChangeValue = 0,
		Ranks =
		{
			{ Points = 1, ChangeValue = 5 },
			{ Points = 3, ChangeValue = 10 },
		},
		FlavorText = "BoonManaReserveShrineUpgrade_Flavor",
	},

	BanUnpickedBoonsShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_UnpickedUpgrade",
		InactiveChangeValue = 0,
		Ranks =
		{
			--{ Points = 1, ChangeValue = 1 },
			{ Points = 2, ChangeValue = 2 },
		},
		FlavorText = "BanUnpickedBoonsShrineUpgrade_Flavor",
	},

	FirstDamageShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_TrapDamage",
		InactiveChangeValue = 1.0,
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				Multiply = 100,
				Add = -100,
				NewProperty = "DisplayValue",
			},
		},
		Ranks =
		{
			{ Points = 2, ChangeValue = 2.0 },
			{ Points = 2, ChangeValue = 4.0 },
		},
		FlavorText = "FirstDamageShrineUpgrade_Flavor",
	},

	RoomStartManaShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_RoomStartMana",
		InactiveChangeValue = 1.0,
		SimpleExtractValues =
		{
			{
				Property = "ChangeValue",
				Multiply = 100,
				NewProperty = "DisplayValue",
			},
		},
		Ranks =
		{
			{ Points = 1, ChangeValue = 0.5 },
			--{ Points = 1, ChangeValue = 0.0 },
		},
		FlavorText = "RoomStartManaShrineUpgrade_Flavor",
	},

	NoMetaUpgradesShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_NoMetaUpgrades",
		InactiveChangeValue = 0,
		Ranks =
		{
			{ Points = 5, ChangeValue = 100 },
		},
		FlavorText = "NoMetaUpgradesShrineUpgrade_Flavor",
	},

	EnemyEliteShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_EnemyElites",
		InactiveChangeValue = 0,
		Ranks =
		{
			{ Points = 2, ChangeValue = 1 },
			{ Points = 3, ChangeValue = 2 },
		},
		FlavorText = "EnemyEliteShrineUpgrade_Flavor",
	},
}

MetaUpgradeLockOrder =
{
	BaseUnlocked = 4,
	LockedSetsCount = 2,
	LockedSetCosts = { 5, 10, 20, 30 }
}

RerollCosts =
{
	Boon = 1,
	Shop = 1,
	SellTrait = 1,
	Talent = 1,
	Hammer = -1, -- Disabled
	ReuseIncrement = 1,
}
