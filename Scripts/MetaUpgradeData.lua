MetaUpgradeDefaultCardLayout = 
{
	{ "ChanneledCast",			"HealthRegen",			"LowManaDamageBonus",	"CastCount",			"SorceryRegenUpgrade", 	},
	{ "CastBuff",				"BonusHealth",			"BonusDodge",			"ManaOverTime",			"MagicCrit" 			},
	{ "SprintShield",			"LastStand",			"MaxHealthPerRoom",		"StatusVulnerability",	"ChanneledBlock" 		},
	{ "DoorReroll",				"StartingGold",			"MetaToRunUpgrade",		"RarityBoost", 			"BonusRarity" 			},
	{ "TradeOff",				"ScreenReroll",			"LowHealthBonus",		"EpicRarityBoost",		"CardDraw" 				},
}

MetaUpgradeSaveLayoutData = 
{
	MaximumMetaUpgradeLayouts = 6,
	GameStateRequirements = 
	{
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMetaUpgradeSaveLayout" },
		},
	}
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
	StartingMetaUpgradeLimit = 10,		-- Base metaupgrade 'MEM' limit
	MetaUpgradeLevelData = 
	{
		{ CostIncrease = 2, ResourceCost = { MemPointsCommon = 30 }},
		{ CostIncrease = 2, ResourceCost = { MemPointsCommon = 45 }},
		{ CostIncrease = 2, ResourceCost = { MemPointsCommon = 60 }},
		{ CostIncrease = 2, ResourceCost = { MemPointsCommon = 100 }},
		{ CostIncrease = 2, ResourceCost = { MemPointsCommon = 120 }},

		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 140 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 150 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 160 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 170 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 180 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 190 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 200 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 250 }},
		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 300 }},

		{ CostIncrease = 1, ResourceCost = { MemPointsCommon = 500, Mixer6Common = 2, MixerShadow = 2 }},
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

	------------ ROW 1 ----------------
	ChanneledCast = -- Sorceress, Medea
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
			{ CardUpgradePoints = 3, MixerHBoss = 1 },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	HealthRegen = -- Wayward Son, Zagreus
	{
		InheritFrom = { "BaseMetaUpgrade" },
		StartUnlocked = false,
		Image = "CardArt_02",
		TraitName = "DoorHealMetaUpgrade",
		CustomTrayText = "DodgeBonusMetaUpgrade_Tray",
		CustomTextWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			CardTitle = "HealthRegen_Vow",
		},
		Type = "Life",

		ResourceCost = 
		{
			MetaCardPointsCommon = 3,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2 },
			{ CardUpgradePoints = 3, MixerFBoss = 1, },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	LowManaDamageBonus = -- Huntress, Artemis
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "LowManaDamageMetaupgrade",

		Image = "CardArt_03",
		Cost = 2,
		ResourceCost = 
		{
			MetaCardPointsCommon = 15,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2 },
			{ CardUpgradePoints = 3, MixerNBoss = 2, },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	CastCount = -- Eternity, Chronos
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "CastDamageMetaUpgrade",
		Cost = 3,
		RandomDrawChance = 0.1,
		Image = "CardArt_12",
		ResourceCost = 
		{
			MetaCardPointsCommon = 25,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2 },
			{ CardUpgradePoints = 3, MixerHBoss = 2 },
		},

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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	SorceryRegenUpgrade = -- Moon, Selene
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "SorceryRegenMetaUpgrade",
		Cost = 0,
		Image = "CardArt_05",
		ResourceCost = 
		{
			MetaCardPointsCommon = 30,
			MixerGBoss = 1,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 6, MixerGBoss = 2, },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	------------ ROW 2 ----------------
	CastBuff = -- Furies, Megaera, Alecto, & Tisiphone
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
			{ CardUpgradePoints = 3, MixerFBoss = 1, },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	BonusHealth = -- Persistence, Prometheus
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Cost = 2,
		Image = "CardArt_07",
		ResourceCost = 
		{
			MetaCardPointsCommon = 10,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2 },
			{ CardUpgradePoints = 4, MixerPBoss = 1 },
		},
		TraitName = "HealthManaBonusMetaUpgrade",
		CustomTrayText = "HealthManaBonusMetaUpgrade_Tray",

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_4022", Text = "Persistence." },
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

				{ Cue = "/VO/Melinoe_4022", Text = "Persistence." },
			},
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	BonusDodge = -- Messenger, Hermes
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
			{ CardUpgradePoints = 1 },
			{ CardUpgradePoints = 3, MixerPBoss = 1, },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	ManaOverTime = -- Unseen, Hecate
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "ManaOverTimeMetaUpgrade",
		Type = "Soul",
		Cost = 5,
		Image = "CardArt_09",
		ResourceCost = 
		{
			MetaCardPointsCommon = 30,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 5 },
			{ CardUpgradePoints = 10, MixerHBoss = 2, },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	MagicCrit = -- Night, Nyx
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "MagicCritMetaUpgrade",
		Cost = 2,
		

		Image = "CardArt_04",
		ResourceCost = 
		{
			MetaCardPointsCommon = 35,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2, },
			{ CardUpgradePoints = 4, Mixer6Common = 1 },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	------------ ROW 3 ----------------
	SprintShield = -- Swift Runner, Achilles
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 1,
		Image = "CardArt_11",
		ResourceCost = 
		{
			MetaCardPointsCommon = 15,
		},
		TraitName = "SprintShieldMetaUpgrade",
		ActiveWhileDead = true,
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 1, },
			{ CardUpgradePoints = 3, MixerFBoss = 1 },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	LastStand = -- Death, Thanatos
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 4,
		Image = "CardArt_10",
		ResourceCost = 
		{
			MetaCardPointsCommon = 25,
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	MaxHealthPerRoom = -- Centaur, Chiron
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Cost = 0,
		Image = "CardArt_13",
		ResourceCost = 
		{
			MetaCardPointsCommon = 30,
			MixerFBoss = 1,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3, },
			{ CardUpgradePoints = 6, MixerOBoss = 1 },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	StatusVulnerability = -- Origination, Chaos
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "EffectVulnerabilityMetaUpgrade",
		Cost = 5,
		Image = "CardArt_14",
		ResourceCost = 
		{
			MetaCardPointsCommon = 35,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 5 },
			{ CardUpgradePoints = 10, MixerShadow = 1, },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	ChanneledBlock = -- Lovers, Orpheus & Eurydice
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "BossShieldMetaUpgrade",
		Cost = 3,
		Image = "CardArt_15",
		ResourceCost = 
		{
			MetaCardPointsCommon = 40,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 5, MixerHBoss = 2 },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	------------ ROW 4 ----------------
	DoorReroll = -- The Enchantress, Circe
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 3,
		Image = "CardArt_21",

		ResourceCost = 
		{
			MetaCardPointsCommon = 25,
		},
		TraitName = "DoorRerollMetaUpgrade",
		OnGrantedFunctionName = "GrantMetaUpgradeRerolls",
		OnUpgradedFunctionName = "UpgradeMetaUpgradeRerolls",
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 5, MixerGBoss = 2 },
		},

		UnlockedCardVoiceLines =
		{
			PreLineWait = 0.65,
			UsePlayerSource = true,
			SkipAnim = true,

			{ Cue = "/VO/Melinoe_4067", Text = "The Enchantress." },
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

				{ Cue = "/VO/Melinoe_4067", Text = "The Enchantress." },
			},
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	StartingGold = -- Boatman, Charon
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 5,
		Image = "CardArt_17",
		ResourceCost = 
		{
			MetaCardPointsCommon = 30,
		},
		TraitName = "StartingGoldMetaUpgrade",
		OnGrantedFunctionName = "GrantMetaUpgradeCurrency",
		OnUpgradedFunctionName = "UpgradeMetaUpgradeCurrency",

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 5 },
			{ CardUpgradePoints = 10, CharonPoints = 1 },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	MetaToRunUpgrade = -- Artificer, Daedalus
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "MetaToRunMetaUpgrade",
		Cost = 3,
		Image = "CardArt_18",
		ResourceCost = 
		{
			MetaCardPointsCommon = 35,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 5, MixerNBoss = 2 },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	RarityBoost = -- Excellence, Patroclus
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 5,
		Image = "CardArt_19",
		ResourceCost = 
		{
			MetaCardPointsCommon = 40,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 4 },
			{ CardUpgradePoints = 6, MixerNBoss = 2 },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	BonusRarity = -- Queen, Persephone
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Cost = 0,
		Image = "CardArt_20",
		ResourceCost = 
		{
			MetaCardPointsCommon = 45,
			MixerHBoss = 1,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 2 },
			{ CardUpgradePoints = 4, MixerGBoss = 2, },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	------------ ROW 5 ----------------
	TradeOff = -- The Fates, Three Fates
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 0,
		Image = "CardArt_16",
		ResourceCost = 
		{
			MetaCardPointsCommon = 30,
			MixerNBoss = 1,
		},
		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 3 },
			{ CardUpgradePoints = 6, MixerNBoss = 2, },
		},
		RequiredCardNames = { "ScreenReroll", "DoorReroll" },
		TraitName = "RerollTradeOffMetaUpgrade",
		OnGrantedFunctionName = "GrantMetaUpgradeRerolls",
		OnUpgradedFunctionName = "UpgradeMetaUpgradeRerolls",

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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	ScreenReroll = -- Champions, Theseus & Asterius
	{
		InheritFrom = { "BaseMetaUpgrade" },
		Cost = 4,
		Image = "CardArt_22",
		ResourceCost = 
		{
			MetaCardPointsCommon = 35,
		},
		TraitName = "PanelRerollMetaUpgrade",
		OnGrantedFunctionName = "GrantMetaUpgradeRerolls",
		OnUpgradedFunctionName = "UpgradeMetaUpgradeRerolls",

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 5 },
			{ CardUpgradePoints = 10, MixerOBoss = 2, },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	LowHealthBonus = -- Strength, Heracles
	{
		InheritFrom = { "BaseMetaUpgrade" },
		TraitName = "LowHealthBuffMetaUpgrade",
		Cost = 4,
		Image = "CardArt_23",
		ShowLastStandWarning = true,
		OnGrantedFunctionName = "GrantedLowHealthBonusBuffStatePresentation",
		ResourceCost = 
		{
			MetaCardPointsCommon = 40,
		},

		UpgradeResourceCost = 
		{
			{ CardUpgradePoints = 6 },
			{ CardUpgradePoints = 12, MixerPBoss = 2 },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	EpicRarityBoost = -- Divinity, Zeus & Hera
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Image = "CardArt_24",
		ResourceCost = 
		{
			MetaCardPointsCommon = 45,
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
			{ CardUpgradePoints = 5 },
			{ CardUpgradePoints = 10, MixerPBoss = 2, },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
	CardDraw = -- Judgment, Hades
	{
		InheritFrom = { "BaseBonusMetaUpgrade" },
		Image = "CardArt_25",
		ResourceCost = 
		{
			MetaCardPointsCommon = 50,
			MixerPBoss = 1,
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
			{ CardUpgradePoints = 10, },
			{ CardUpgradePoints = 20, MetaFabric = 20 },
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
			{ GlobalVoiceLines = "CardInspectVoiceLines" },
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
		InfoBackingAnimation = "ShrineSlotBase",
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
			{
				Property = "ChangeValue",
				NegativePercentDelta = true,
				NewProperty = "HealingReductionValue",
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
		OnDisabledFunctionName = "RemoveEnemyDamageShrineUpgrade",
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
			O = EnemySets.BiomeP,
			P = EnemySets.BiomeQ,
		},
		SwapMap =
		{
			-- Erebus
			Guard = { Name = "Guard2", },
			Guard_Elite = { Name = "Guard2_Elite", },
			Brawler = { Name = "FishmanMelee", ActiveCapWeight = 1.3, },
			Brawler_Elite = { Name = "FishmanMelee_Elite", ActiveCapWeight = 1.3 },
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
			FishSwarmerSquad_Elite = { Name = "LycanSwarmer_Elite", RequiredSpawnPoint = "EnemyPoint", },
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

			-- Ships
			Stickler = { Name = "AutomatonBeamer" },
			Stickler_Elite = { Name = "AutomatonBeamer_Elite" },
			Scimiterror = { Name = "SatyrSapper" },
			Scimiterror_Elite = { Name = "SatyrSapper_Elite" },
			Swab = { Name = "Dragon" },
			Swab_Elite = { Name = "Dragon_Elite" },
			Drunk = { Name = "AutomatonEnforcer" },
			Drunk_Elite = { Name = "AutomatonEnforcer_Elite" },
			HarpyCutter = { Name = "HarpyDropper" },
			HarpyCutter_Elite = { Name = "HarpyDropper_Elite" },
			WaterElemental = { Name = "SentryBot" },
			WaterElemental_Elite = { Name = "SentryBot_Elite" },
			Mage2 = { Name = "SatyrLancer2" },
			Mage2_Elite = { Name = "SatyrLancer2_Elite" },

			-- Olympus
			-- SentryBot is banned
			-- AutomatonBeamer is banned
			-- AutomatonEnforcer is banned
			Dragon = { Name = "Brute" },
			Dragon_Elite = { Name = "Brute_Elite" },
			HarpyDropper = { Name = "Stalker" },
			HarpyDropper_Elite = { Name = "Stalker_Elite" },
			-- SatyrSapper is banned
			SatyrLancer2 = { Name = "Mati" },
			SatyrLancer2_Elite = { Name = "Mati_Elite" },
			SatyrCrossbow2 = { Name = "DragonBurrower" },
			SatyrCrossbow2_Elite = { Name = "DragonBurrower_Elite" },
			ZombieOlympus = { Name = "Simple" },
			ZombieOlympus_Elite = { Name = "Simple_Elite" },
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
			{ Points = 2, ChangeValue = 1 },
		},
		FlavorText = "MinibossCountShrineUpgrade_Flavor",
	},

	BossDifficultyShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_BossDifficulty",
		InactiveChangeValue = 0,
		IneligibleForCirceRemoval = true,
		UseWideAnimations = true,
		RankRevealedFunctionName = "BossDifficultyShrineUpgradeRankRevealed",
		Ranks =
		{
			{
				Points = 2,
				ChangeValue = 1,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateBossGrantsShrineUpgrade01", "HecateGrantsShrineUpgrade01" }
					},
				},
			},
			{
				Points = 3,
				ChangeValue = 2,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBossDifficultyT2" },
					},
				},
			},
			{
				Points = 3,
				ChangeValue = 3,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBossDifficultyT3" },
					},
				},
			},
			{
				Points = 4,
				ChangeValue = 4,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBossDifficultyT4" },
					},
				},
			},
		},
		FlavorText = "BossDifficultyShrineUpgrade_Flavor",
		UsePluralizedForm = true,
	},

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
			{ Points = 1, ChangeValue = 3 },
			{ Points = 1, ChangeValue = 6 },
		},
		FlavorText = "BoonManaReserveShrineUpgrade_Flavor",
		
		OnDisabledFunctionName = "RemoveBoonManaReserve",
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

	LimitGraspShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_NoMetaUpgrades",
		InactiveChangeValue = 100,
		IgnoredByRandomBounties = true,
		Ranks =
		{
			{ Points = 1, ChangeValue = 60 },
			{ Points = 1, ChangeValue = 40 },
			{ Points = 1, ChangeValue = 20 },
			{ Points = 2, ChangeValue = 0 },
		},
		FlavorText = "LimitGraspShrineUpgrade_Flavor",
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

MetaUpgradeCardRarityIcons =
{
	Rare = "MetaRank2",
	Epic = "MetaRank3",
	Heroic = "MetaRank4",
}

FatedEnableKeepsakes = 
{
	RarifyKeepsake = true,
	HadesAndPersephoneKeepsake = true,
	GoldifyKeepsake = true,
}

FatedDisableKeepsakes = 
{
	ForceApolloBoonKeepsake = true,
	ForceZeusBoonKeepsake = true,
	ForceHeraBoonKeepsake = true,
	ForceHephaestusBoonKeepsake = true,
	ForceAphroditeBoonKeepsake = true,
	ForceDemeterBoonKeepsake = true,
	ForceAresBoonKeepsake = true,
	ForcePoseidonBoonKeepsake = true,
	ForceHestiaBoonKeepsake = true,
	AthenaEncounterKeepsake = true,
}

FatedDisableMetaUpgrades = 
{
	DoorReroll = true,
	ScreenReroll = true,
	TradeOff = true,
}