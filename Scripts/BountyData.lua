BountyData =
{
	-- Boss Encounter sets
	HecateEncounters =
	{
		DebugOnly = true,
		Encounters = { "BossHecate01", "BossHecate02" },
	},
	ScyllaEncounters =
	{
		DebugOnly = true,
		Encounters = { "BossScylla01", "BossScylla02" },
	},
	InfestedCerberusEncounters =
	{
		DebugOnly = true,
		Encounters = { "BossInfestedCerberus01", "BossInfestedCerberus02" },
	},
	ChronosEncounters =
	{
		DebugOnly = true,
		Encounters = { "BossChronos01", "BossChronos02" },
	},
	PolyphemusEncounters =
	{
		DebugOnly = true,
		Encounters = { "BossPolyphemus01", "BossPolyphemus02" },
	},
	ErisEncounters =
	{
		DebugOnly = true,
		Encounters = { "BossEris01", "BossEris02" },
	},
	PrometheusEncounters =
	{
		DebugOnly = true,
		Encounters = { "BossPrometheus01", "BossPrometheus02" },
	},
	TyphonEncounters =
	{
		DebugOnly = true,
		Encounters = { "BossTyphonHead01", "BossTyphonHead02" },
	},

	-- Package Bounties
	DefaultPackagedBounty =
	{
		DebugOnly = true,
		Category = "PackagedBounty",
		EndRunOnCompletion = true,
		IsPackagedBounty = true,
		RunOverrides =
		{
			DeepInheritance = true,
			TargetMetaRewardsRatio = 0,
			HarvestPointChanceMultiplier = 0,
			ShovelPointChanceMultiplier = 0,
			PickaxePointChanceMultiplier = 0,
			ExorcismPointChanceMultiplier = 0,
			FishingPointChanceMultiplier = 0,
		},
		StartingRoomOverrides =
		{
			ForcedEntranceFunctionName = "RoomEntranceBountyStart",
		},
		ForcedReward = "Mixer5CommonDrop",
		ForcedRewardRepeat = "MetaCurrencyDrop",
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	
	BountyPackageTest =
	{
		DebugOnly = true,
		InheritFrom = { "DefaultPackagedBounty", "HecateEncounters" },
		StartingBiome = "F",
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ZeusUpgrade",
				GameStateRequirements =
				{
					-- None
				},
			},
		},
		WeaponKitName = "WeaponDagger",
		-- WeaponUpgradeName = "",
		KeepsakeName = "BossPreDamageKeepsake",
		FamiliarName = "FrogFamiliar",

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "Boon",
					LootName = "PoseidonUpgrade",
					AllowDuplicates = true,
				},
				{
					Name = "Boon",
					LootName = "PoseidonUpgrade",
					AllowDuplicates = true,
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
				},
			},
			MetaProgress =
			{
				{
					Name = "MaxHealthDrop",
					AllowDuplicates = true,
				},
				{
					Name = "MaxHealthDrop",
					AllowDuplicates = true,
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"LastStand",
			"ChanneledCast",
			"MaxManaPerRoom",
		},

		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "GameState", "TraitsTaken", },
				HasAll = { "HealthFamiliar", "BossPreDamageKeepsake", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxManaPerRoom", "Unlocked", },
			},
		},
	},

	-- Base bounties
	BasePackageBountyBiomeF =
	{
		DebugOnly = true,
		InheritFrom = { "HecateEncounters" },
		StartingBiome = "F",
	},
	BasePackageBountyBiomeG =
	{
		DebugOnly = true,
		InheritFrom = { "ScyllaEncounters" },
		StartingBiome = "G",
		RunOverrides =
		{
			DeepInheritance = true,
			ClearedBiomes = 1,
			BiomesReached = { F = true, },
		},
	},
	BasePackageBountyBiomeH =
	{
		DebugOnly = true,
		InheritFrom = { "InfestedCerberusEncounters" },
		StartingBiome = "H",
		RunOverrides =
		{
			DeepInheritance = true,
			ClearedBiomes = 2,
			BiomesReached = { F = true, G = true, },
		},
	},
	BasePackageBountyBiomeI =
	{
		DebugOnly = true,
		InheritFrom = { "ChronosEncounters" },
		StartingBiome = "I",
		RunOverrides =
		{
			DeepInheritance = true,
			ClearedBiomes = 3,
			BiomesReached = { F = true, G = true, H = true },
		},
	},
	BasePackageBountyBiomeN =
	{
		DebugOnly = true,
		InheritFrom = { "PolyphemusEncounters" },
		StartingBiome = "N",
	},
	BasePackageBountyBiomeO =
	{
		DebugOnly = true,
		InheritFrom = { "ErisEncounters" },
		StartingBiome = "O",
		RunOverrides =
		{
			DeepInheritance = true,
			ClearedBiomes = 1,
			BiomesReached = { N = true, },
		},
	},
	BasePackageBountyBiomeP =
	{
		DebugOnly = true,
		InheritFrom = { "PrometheusEncounters" },
		StartingBiome = "P",
		RunOverrides =
		{
			DeepInheritance = true,
			ClearedBiomes = 2,
			BiomesReached = { N = true, O = true, },
		},
	},
	BasePackageBountyBiomeQ =
	{
		DebugOnly = true,
		InheritFrom = { "TyphonEncounters" },
		StartingBiome = "Q",
		RunOverrides =
		{
			DeepInheritance = true,
			ClearedBiomes = 3,
			BiomesReached = { N = true, O = true, P = true },
		},
	},

	-- Starter bounties
	PackageBountyChaosIntro =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },
		Text = "PackageBountyChaosIntro_Short",

		DifficultyRating = 1,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "TrialUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "ChaosWeaponBlessing",
						Rarity = "Heroic",
					},
					{
						Type = "Trait",
						ItemName = "ChaosSpecialBlessing",
						Rarity = "Heroic",
					},
					{
						Type = "Trait",
						ItemName = "ChaosCastBlessing",
						Rarity = "Heroic",
					},
				},
			},
		},

		StartingTraits =
		{
			{ Name = "ChaosManaOverTimeBlessing", Rarity = "Epic", },

			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },

			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },


			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		WeaponKitName = "WeaponStaffSwing",
		WeaponUpgradeName = "BaseStaffAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
		},

		UnlockGameStateRequirements =
		{
			NamedRequirements = { "PackageBountyBiomeF", },
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", },
			},
		},
	},
	PackageBountyOceanus =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },
		Text = "PackageBountyOceanus_Short",

		DifficultyRating = 2,

		RunOverrides =
		{
			MaxGodsPerRun = 1,
			LootTypeHistory =
			{
				PoseidonUpgrade = 5,
			},
		},

		StartingTraits =
		{
			{ Name = "PoseidonWeaponBoon", Rarity = "Epic", },
			{ Name = "PoseidonSprintBoon", Rarity = "Epic", },
			{ Name = "PoseidonManaBoon", Rarity = "Epic", },
			{ Name = "EncounterStartOffenseBuffBoon", Rarity = "Epic", },
			{ Name = "PoseidonStatusBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "Boon",
					AllowDuplicates = true,
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
				},
				{
					Name = "RoomMoneyDrop",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "LootTypeHistory", "PoseidonUpgrade", },
							Comparison = ">",
							Value = 5,
						},
					},
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
						{
							Path = { "CurrentRun", "LootTypeHistory", "PoseidonUpgrade", },
							Comparison = ">",
							Value = 5,
						},
					}
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
						{
							Path = { "CurrentRun", "LootTypeHistory", "PoseidonUpgrade", },
							Comparison = ">",
							Value = 5,
						},
					}
				},
			},
		},

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerBackstabAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"HealthRegen",
			"CastBuff",
			"BonusHealth",
			"LastStand",
		},

		UnlockGameStateRequirements =
		{
			NamedRequirements = { "PackageBountyBiomeG", },
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "PoseidonFirstPickUp", },
			},
			-- Meta Upgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
		},
	},
	PackageBountyStarter =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },
		Text = "PackageBountyStarter_Short",

		DifficultyRating = 4,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ApolloUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "ApolloWeaponBoon",
						Rarity = "Common",
					},
					{
						Type = "Trait",
						ItemName = "ApolloSprintBoon",
						Rarity = "Common",
					},
					{
						Type = "Trait",
						ItemName = "ApolloManaBoon",
						Rarity = "Common",
					},
				},
			},
		},

		WeaponKitName = "WeaponStaffSwing",
		WeaponUpgradeName = "BaseStaffAspect",
		RemoveFamiliar = true,

		MetaUpgradeStateEquipped =
		{
		},

		UnlockGameStateRequirements =
		{
			NamedRequirements = { "PackageBountyBiomeF", },
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", },
			},
		},
	},
	PackageBountyRevenge =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },
		Text = "PackageBountyRevenge_Short",

		DifficultyRating = 1,

		WeaponKitName = "WeaponLob",
		WeaponUpgradeName = "LobAmmoBoostAspect",
		KeepsakeName = "DeathVengeanceKeepsake",
		FamiliarName = "FrogFamiliar",

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HeraUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "HeraWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "HeraSpecialBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "HeraSprintBoon",
						Rarity = "Epic",
					},
				},
			},
		},

		RunOverrides =
		{
			LootTypeHistory =
			{
				ApolloUpgrade = 1,
				ZeusUpgrade = 1,
				AphroditeUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "ApolloRetaliateBoon", Rarity = "Heroic", },
			{ Name = "BoltRetaliateBoon", Rarity = "Heroic", },
			{ Name = "HighHealthOffenseBoon", Rarity = "Heroic", },
			{ Name = "DoorHealToFullBoon", Rarity = "Heroic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
		},

		MetaUpgradeStateEquipped =
		{
			"HealthRegen",
			"CastBuff",
			"BonusHealth",
			"BonusDodge",
			"LastStand",
		},

		ShrineUpgradesActive =
		{
			EnemySpeedShrineUpgrade = 2,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeN", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponLob", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "DeathVengeanceKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar", },
			},

			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", "ZeusFirstPickUp", },
			},
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt", },
			},

			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
		},
	},
	PackageBountyOneTouch =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },
		Text = "PackageBountyOneTouch_Short",

		DifficultyRating = 5,

		WeaponKitName = "WeaponAxe",
		WeaponUpgradeName = "AxePerfectCriticalAspect",
		KeepsakeName = "BlockDeathKeepsake",
		FamiliarName = "PolecatFamiliar",

		RunOverrides =
		{
			LootTypeHistory =
			{
				DemeterUpgrade = 1,
				ApolloUpgrade = 1,
				HestiaUpgrade = 1,
			}
		},

		StartingTraits =
		{
			{ Name = "DemeterWeaponBoon", Rarity = "Epic", },
			{ Name = "HestiaManaBoon", Rarity = "Heroic", },
			{ Name = "PerfectDamageBonusBoon", Rarity = "Heroic", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "RoomMoneyDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
					}
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
					}
				},
				{
					Name = "SpellDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "SpellDropRequirements", },
					},
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "TalentLegal", },
						{
							Path = { "CurrentRun", "ClearedBiomes" },
							Comparison = ">",
							Value = 1,
						},
						{
							PathFalse = { "CurrentRun", "BiomeUseRecord", "TalentDrop" },
						},
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"LowManaDamageBonus",
			"CastBuff",
			"StatusVulnerability",
			"ChanneledBlock",
			"BonusRarity",
			"ScreenReroll",
			"LowHealthBonus",
		},

		ShrineUpgradesActive =
		{
			EnemyDamageShrineUpgrade = 3,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeG", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponAxe", "AxePerfectCriticalAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "BlockDeathKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "PolecatFamiliar", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "DemeterFirstPickUp", "ApolloFirstPickUp", "HestiaFirstPickUp", },
			},

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked", },
			},
		},
	},
	PackageBountySpellCast =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },
		Text = "PackageBountySpellCast_Short",

		DifficultyRating = 2,

		WeaponKitName = "WeaponAxe",
		WeaponUpgradeName = "AxeArmCastAspect",
		KeepsakeName = "SpellTalentKeepsake",
		FamiliarName = "HoundFamiliar",

		ForcedRewards =
		{
			{
				Name = "SpellDrop",
			},
		},

		RunOverrides =
		{
			LootTypeHistory =
			{
				ApolloUpgrade = 1,
				ZeusUpgrade = 1,
				WeaponUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "ApolloCastAreaBoon", Rarity = "Epic", },
			{ Name = "CastAnywhereBoon", Rarity = "Epic", },
			{ Name = "AxeChargedSpecialTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "MaxHealthDrop",
				},
				{
					Name = "MaxManaDrop",
				},
				{
					Name = "MaxManaDrop",
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
					}
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "AllSpellInvestedCache", },
						},
					},
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "AllSpellInvestedCache", },
						},
					},
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "AllSpellInvestedCache", },
						},
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"LowManaDamageBonus",
			"CastCount",
			"SorceryRegenUpgrade",
			"CastBuff",
			"BonusHealth",
			"BonusDodge",
			"ManaOverTime",
			"LastStand",
			"MaxHealthPerRoom",
		},

		ShrineUpgradesActive =
		{
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeF", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponAxe", "AxeArmCastAspect" },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "SpellTalentKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "SeleneFirstPickUp", "ZeusFirstPickUp", "ApolloFirstPickUp" },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "HoundFamiliar", },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
		},
	},
	PackageBountyGold =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },
		Text = "PackageBountyGold_Short",

		DifficultyRating = 2,

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerHomingThrowAspect",
		KeepsakeName = "BonusMoneyKeepsake",
		RemoveFamiliar = true,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "EncounterStartOffenseBuffBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "DoubleRewardBoon",
						Rarity = "Heroic",
					},
					{
						Type = "Trait",
						ItemName = "RoomRewardBonusBoon",
						Rarity = "Heroic",
					},
				},
			},
		},

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				PoseidonUpgrade = 2,
				HeraUpgrade = 3,
				HermesUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "HeraWeaponBoon", Rarity = "Epic", },
			{ Name = "PoseidonSpecialBoon", Rarity = "Epic", },
			{ Name = "HeraCastBoon", Rarity = "Epic", },
			{ Name = "HeraSprintBoon", Rarity = "Epic", },
			{ Name = "PoseidonManaBoon", Rarity = "Epic", },
			{ Name = "MoneyMultiplierBoon", Rarity = "Heroic", },
			{ Name = "TimeStopLastStandBoon", Rarity = "Legendary", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "Boon",
					ForceLootName = "HeraUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- none
					},
				},
			},
			HubRewards =
			{
				{
					Name = "RoomMoneyDrop",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- none
					},
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
			SubRoomRewards =
			{
				{
					Name = "RoomMoneyTinyDrop",
				},
				{
					Name = "RoomMoneyDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
			},
			SubRoomRewardsHard =
			{
				{
					Name = "RoomMoneyDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"HealthRegen",
			"BonusHealth",
			"LastStand",
			"MaxHealthPerRoom",
			"StartingGold",
			"MetaToRunUpgrade",
			"BonusRarity",
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeN", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", "DaggerHomingThrowAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "BonusMoneyKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "PoseidonFirstPickUp", "HermesFirstPickUp", },
			},
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt", },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 3,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StartingGold", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MetaToRunUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
		},
	},
	PackageBountyHealer =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },
		Text = "PackageBountyHealer_Short",

		DifficultyRating = 2,

		WeaponKitName = "WeaponStaffSwing",
		WeaponUpgradeName = "StaffSelfHitAspect",
		KeepsakeName = "DamagedDamageBoostKeepsake",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				AresUpgrade = 3,
				HestiaUpgrade = 2,
				WeaponUpgrade = 2,
			}
		},

		StartingTraits =
		{
			{ Name = "AresWeaponBoon", Rarity = "Epic", },
			{ Name = "HestiaSpecialBoon", Rarity = "Epic", },
			{ Name = "AresSprintBoon", Rarity = "Epic", },
			{ Name = "HestiaManaBoon", Rarity = "Epic", },
			{ Name = "LowHealthLifestealBoon", Rarity = "Epic", },
			{ Name = "StaffExHealTrait", },
			{ Name = "StaffOneWayAttackTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
					},
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
					}
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"HealthRegen",
			"LowManaDamageBonus",
			"SorceryRegenUpgrade",
			"BonusHealth",
			"ManaOverTime",
			"LastStand",
			"StatusVulnerability",
			"BonusRarity",
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeG", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", "StaffSelfHitAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "DamagedDamageBoostKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AresFirstPickUp", "HestiaFirstPickUp" },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
		},
	},
	PackageBountyChaos =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeP", },
		Text = "PackageBountyChaos_Short",

		DifficultyRating = 5,

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerBackstabAspect",
		KeepsakeName = "RandomBlessingKeepsake",
		FamiliarName = "RavenFamiliar",

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				AresUpgrade = 4,
				ZeusUpgrade = 4,
				WeaponUpgrade = 2,
				HermesUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "AresWeaponBoon", Rarity = "Epic", },
			{ Name = "ZeusSpecialBoon", Rarity = "Epic", },
			{ Name = "ZeusManaBoon", Rarity = "Epic", },
			{ Name = "AresStatusDoubleDamageBoon", Rarity = "Epic", },
			{ Name = "AloneDamageBoon", Rarity = "Epic", },
			{ Name = "RendBloodDropBoon", Rarity = "Epic", },
			{ Name = "FocusLightningBoon", Rarity = "Epic", },
			{ Name = "BoltRetaliateBoon", Rarity = "Epic", },
			{ Name = "LuckyBoon", Rarity = "Heroic" },
			{ Name = "DodgeChanceBoon", Rarity = "Heroic" },
			{ Name = "DaggerBackstabTrait", },
			{ Name = "DaggerDashAttackTripleTrait" },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"HealthRegen",
			"BonusHealth",
			"LastStand",
			"MaxHealthPerRoom",
			"DoorReroll",
			"StartingGold",
			"BonusRarity",
			"TradeOff",
			"ScreenReroll",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{
			BanUnpickedBoonsShrineUpgrade = 1,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeP", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "RandomBlessingKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "RavenFamiliar", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AresFirstPickUp", "ZeusFirstPickUp" },
			},

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "DoorReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StartingGold", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "TradeOff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountyZeus =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },
		Text = "PackageBountyZeus_Short",

		DifficultyRating = 1,

		WeaponKitName = "WeaponTorch",
		WeaponUpgradeName = "TorchSpecialDurationAspect",
		KeepsakeName = "ForceZeusBoonKeepsake",
		RemoveFamiliar = true,
		ForcedBiomeState = "Rain",

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ZeusUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "ElementalDamageFloorBoon",
					},
					{
						Type = "Trait",
						ItemName = "SpawnKillBoon",
						Rarity = "Legendary",
					},
					{
						Type = "Trait",
						ItemName = "SuperSacrificeBoonZeus",
						Rarity = "Duo",
					},
				},
			},
		},

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				HeraUpgrade = 1,
				ZeusUpgrade = 7,
				WeaponUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "ZeusWeaponBoon", Rarity = "Epic", },
			{ Name = "ZeusSpecialBoon", Rarity = "Epic", },
			{ Name = "HeraCastBoon", Rarity = "Common" },
			{ Name = "ZeusManaBoon", Rarity = "Epic", },
			{ Name = "FocusLightningBoon", Rarity = "Epic", },
			{ Name = "ZeusManaBoltBoon", Rarity = "Epic", },
			{ Name = "DoubleBoltBoon", Rarity = "Epic", },
			{ Name = "LightningDebuffGeneratorBoon", Rarity = "Epic", },
			{ Name = "TorchDiscountExAttackTrait" },
			{ Name = "TorchAttackSpeedTrait" },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"CastCount",
			"SorceryRegenUpgrade",
			"BonusHealth",
			"ManaOverTime",
			"LastStand",
			"MaxHealthPerRoom",
		},

		ShrineUpgradesActive =
		{

		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeF", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponTorch", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForceZeusBoonKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ZeusFirstPickUp", },
			},
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt", },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 3,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
		},
	},
	PackageBountyHera =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeP", },
		Text = "PackageBountyHera_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponSuit",
		WeaponUpgradeName = "BaseSuitAspect",
		KeepsakeName = "ForceHeraBoonKeepsake",
		RemoveFamiliar = true,

		RunOverrides =
		{
			LootTypeHistory =
			{
				HeraUpgrade = 7,
				ZeusUpgrade = 1,
				WeaponUpgrade = 3,
			},
		},

		StartingTraits =
		{
			{ Name = "HeraWeaponBoon", Rarity = "Common", },
			{ Name = "ZeusCastBoon", Rarity = "Common", },
			{ Name = "HeraSprintBoon", Rarity = "Common", },
			{ Name = "HeraManaBoon", Rarity = "Common", },
			{ Name = "OmegaHeraProjectileBoon", Rarity = "Common", },
			{ Name = "DamageSharePotencyBoon", Rarity = "Common", },
			{ Name = "CommonGlobalDamageBoon", Rarity = "Heroic" },
			{ Name = "SuitFullChargeTrait" },
			{ Name = "SuitArmorTrait" },
			{ Name = "SuitSpecialAutoTrait" },
			{ Name = "ElementalRarityUpgradeBoon" },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AllElementalBoon" },
						},
					}
				},
				{
					Name = "Boon",
					ForceLootName = "HeraUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					ForceLootName = "ZeusUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "Elements", "Air" },
							Comparison = "<",
							Value = 2,
						},
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AllElementalBoon" },
						},
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AllElementalBoon" },
						},
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"SorceryRegenUpgrade",
			"BonusHealth",
			"MagicCrit",
			"SprintShield",
			"LastStand",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"ChanneledBlock",
			"DoorReroll",
			"RarityBoost",
			"BonusRarity",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{

		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeP", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponSuit", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForceHeraBoonKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt", },
			},
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ZeusFirstPickUp", },
			},

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "DoorReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountyDemeter =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeH", },
		Text = "PackageBountyDemeter_Short",

		DifficultyRating = 2,

		WeaponKitName = "WeaponLob",
		WeaponUpgradeName = "LobImpulseAspect",
		KeepsakeName = "ForceDemeterBoonKeepsake",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				DemeterUpgrade = 5,
				ApolloUpgrade = 2,
				HermesUpgrade = 2,
				WeaponUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "DemeterSpecialBoon", Rarity = "Heroic", },
			{ Name = "DemeterCastBoon", Rarity = "Epic", },
			{ Name = "CastNovaBoon", Rarity = "Epic", },
			{ Name = "CastAttachBoon", Rarity = "Epic", },
			{ Name = "ReserveManaHitShieldBoon", Rarity = "Epic", },
			{ Name = "ApolloExCastBoon", Rarity = "Epic", },
			{ Name = "ApolloManaBoon", Rarity = "Epic", },
			{ Name = "HermesWeaponBoon", Rarity = "Epic", },
			{ Name = "HermesCastDiscountBoon", Rarity = "Epic", },
			{ Name = "LobInOutSpecialExTrait", },
			{ Name = "LobSpecialSpeedTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"CastCount",
			"SorceryRegenUpgrade",
			"CastBuff",
			"BonusHealth",
			"BonusDodge",
			"ManaOverTime",
			"MagicCrit",
			"LastStand",
			"MaxHealthPerRoom",
		},

		ShrineUpgradesActive =
		{
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeH", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponLob", "LobImpulseAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForceDemeterBoonKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "DemeterFirstPickUp", "ApolloFirstPickUp", "HermesFirstPickUp" },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
		},
	},
	PackageBountyAphrodite =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeO", },
		Text = "PackageBountyAphrodite_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponTorch",
		WeaponUpgradeName = "TorchSprintRecallAspect",
		KeepsakeName = "ForceAphroditeBoonKeepsake",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 1,
			LootTypeHistory =
			{
				AphroditeUpgrade = 9,
				WeaponUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "AphroditeWeaponBoon", Rarity = "Epic", },
			{ Name = "AphroditeSprintBoon", Rarity = "Epic", },
			{ Name = "AphroditeManaBoon", Rarity = "Heroic", },
			{ Name = "FocusRawDamageBoon", Rarity = "Epic", },
			{ Name = "WeakVulnerabilityBoon", Rarity = "Epic", },
			{ Name = "HealthRewardBonusBoon", Rarity = "Heroic", },
			{ Name = "HighHealthOffenseBoon", Rarity = "Epic", },
			{ Name = "DoorHealToFullBoon", Rarity = "Epic", },
			{ Name = "WeakPotencyBoon", Rarity = "Epic", },
			{ Name = "TorchEnhancedAttackTrait", },
			{ Name = "TorchSpecialImpactTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "MaxHealthDrop",
					GameStateRequirements =
					{
						-- none
					},
				},
				{
					Name = "MaxHealthDrop",
					GameStateRequirements =
					{
						-- none
					},
				},
				{
					Name = "MaxHealthDrop",
					GameStateRequirements =
					{
						-- none
					},
				},
				{
					Name = "MaxHealthDrop",
					GameStateRequirements =
					{
						-- none
					},
				},
				{
					Name = "RoomMoneyDrop",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "MaxHealth", },
							Comparison = ">=",
							Value = 80,
						},
					},
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
						{
							Path = { "CurrentRun", "Hero", "MaxHealth", },
							Comparison = ">=",
							Value = 80,
						},
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
						{
							Path = { "CurrentRun", "Hero", "MaxHealth", },
							Comparison = ">=",
							Value = 80,
						},
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"HealthRegen",
			"LowManaDamageBonus",
			"CastCount",
			"SorceryRegenUpgrade",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"RarityBoost",
			"BonusRarity",
			"LowHealthBonus",
		},

		ShrineUpgradesActive =
		{
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeO", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponTorch", "TorchSprintRecallAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForceAphroditeBoonKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AphroditeFirstPickUp", },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked", },
			},
		},
	},
	PackageBountyHestia =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeH", },
		Text = "PackageBountyHestia_Short",

		DifficultyRating = 2,

		WeaponKitName = "WeaponTorch",
		WeaponUpgradeName = "TorchDetonateAspect",
		KeepsakeName = "ForceHestiaBoonKeepsake",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				PoseidonUpgrade = 3,
				HestiaUpgrade = 5,
				WeaponUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "PoseidonWeaponBoon", Rarity = "Epic", },
			{ Name = "HestiaSpecialBoon", Rarity = "Heroic", },
			{ Name = "PoseidonCastBoon", Rarity = "Epic", },
			{ Name = "HestiaSprintBoon", Rarity = "Heroic", },
			{ Name = "HestiaManaBoon", Rarity = "Heroic", },
			{ Name = "CastProjectileBoon", Rarity = "Heroic", },
			{ Name = "PoseidonStatusBoon", Rarity = "Epic", },
			{ Name = "BurnStackBoon", Rarity = "Heroic", },
			{ Name = "TorchExSpecialCountTrait", },
			{ Name = "TorchSpecialSpeedTrait", },			
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SteamBoon" },
						},
					},
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SteamBoon" },
						},
					}
				},
				{
					Name = "Boon",
					ForceLootName = "HestiaUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					ForceLootName = "HestiaUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SteamBoon" },
						},
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"HealthRegen",
			"BonusHealth",
			"SprintShield",
			"LastStand",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"ChanneledBlock",
			"StartingGold",
			"BonusRarity",
			"ScreenReroll",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{
			EnemyShieldShrineUpgrade = 2,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeH", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponTorch", "TorchDetonateAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForceHestiaBoonKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "HestiaFirstPickUp", "PoseidonFirstPickUp" },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StartingGold", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountyAres =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },
		Text = "PackageBountyAres_Short",

		DifficultyRating = 2,

		WeaponKitName = "WeaponAxe",
		WeaponUpgradeName = "AxeRecoveryAspect",
		KeepsakeName = "ForceAresBoonKeepsake",
		RemoveFamiliar = true,
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "AresUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "AresStatusDoubleDamageBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "MissingHealthCritBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "LowHealthLifestealBoon",
						Rarity = "Epic",
					},
				},
			},
		},

		RunOverrides =
		{
			MaxGodsPerRun = 1,
			LootTypeHistory =
			{
				AresUpgrade = 4,
			},
		},

		StartingTraits =
		{
			{ Name = "AresWeaponBoon", Rarity = "Epic", },
			{ Name = "AresManaBoon", Rarity = "Epic", },
			{ Name = "RendBloodDropBoon", Rarity = "Epic", },
			{ Name = "BloodDropRevengeBoon", Rarity = "Epic", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"HealthRegen",
			"LowManaDamageBonus",
			"CastCount",
			"SorceryRegenUpgrade",
			"BonusHealth",
			"BonusDodge",
			"ManaOverTime",
			"MagicCrit",
			"MaxHealthPerRoom",
			"ScreenReroll",
			"LowHealthBonus",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{

		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeN", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponAxe", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForceAresBoonKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AresFirstPickUp", },
			},

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountySpeed =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeH", },
		Text = "PackageBountySpeed_Short",

		DifficultyRating = 4,

		WeaponKitName = "WeaponSuit",
		WeaponUpgradeName = "BaseSuitAspect",
		KeepsakeName = "TimedBuffKeepsake",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				ApolloUpgrade = 6,
				PoseidonUpgrade = 2,
				HermesUpgrade = 2,
				WeaponUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "ApolloWeaponBoon", Rarity = "Epic", },
			{ Name = "PoseidonSpecialBoon", Rarity = "Epic", },
			{ Name = "ApolloSprintBoon", Rarity = "Heroic", },
			{ Name = "PoseidonManaBoon", Rarity = "Epic", },
			{ Name = "PerfectDamageBonusBoon", Rarity = "Epic", },
			{ Name = "DoubleStrikeChanceBoon", Rarity = "Epic", },
			{ Name = "BlindChanceBoon", Rarity = "Epic", },
			{ Name = "ApolloBlindBoon", Rarity = "Epic", },
			{ Name = "SprintShieldBoon", Rarity = "Heroic", },
			{ Name = "DodgeChanceBoon", Rarity = "Heroic", },
			{ Name = "SuitFullChargeTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "RoomMoneyDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
					}
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "LateHammerLootRequirements" },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						-- None
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						-- None
					}
				},
				{
					Name = "SpellDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "SpellDropRequirements", },
					},
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "TalentLegal", },
						{
							Path = { "CurrentRun", "ClearedBiomes" },
							Comparison = ">",
							Value = 1,
						},
						{
							PathFalse = { "CurrentRun", "BiomeUseRecord", "TalentDrop" },
						},
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"HealthRegen",
			"CastCount",
			"SorceryRegenUpgrade",
			"BonusHealth",
			"BonusDodge",
			"MagicCrit",
			"SprintShield",
			"LastStand",
			"MaxHealthPerRoom",
			"RarityBoost",
		},

		ShrineUpgradesActive =
		{
			BiomeSpeedShrineUpgrade = 3,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeH", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponSuit", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "TimedBuffKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "HermesFirstPickUp", "ApolloFirstPickUp", "PoseidonFirstPickUp", },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountyCriticalHealth =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeO", },
		Text = "PackageBountyCriticalHealth_Short",

		DifficultyRating = 4,

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerBlockAspect",
		KeepsakeName = "LowHealthCritKeepsake",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 3,
			LootTypeHistory =
			{
				AphroditeUpgrade = 4,
				PoseidonUpgrade = 1,
				DemeterUpgrade = 2,
			},
		},
		StartingTraits =
		{
			{ Name = "AphroditeWeaponBoon", Rarity = "Epic", },
			{ Name = "DemeterSpecialBoon", Rarity = "Epic", },
			{ Name = "AphroditeManaBoon", Rarity = "Epic", },
			{ Name = "EncounterStartOffenseBuffBoon", Rarity = "Epic", },
			{ Name = "WeakPotencyBoon", Rarity = "Epic", },
			{ Name = "HighHealthCritBoon", Rarity = "Epic", },
			{ Name = "ElementalDamageCapBoon", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"HealthRegen",
			"LowManaDamageBonus",
			"SorceryRegenUpgrade",
			"CastBuff",
			"MagicCrit",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"ChanneledBlock",
			"LowHealthBonus",
		},

		ShrineUpgradesActive =
		{
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				-- General
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "RoomMoneyDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
					}
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },

					}
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeO", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", "DaggerBlockAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "LowHealthCritKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AphroditeFirstPickUp", "PoseidonFirstPickUp", "DemeterFirstPickUp", },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked", },
			},
		},
	},
	PackageBountyHellChop =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },
		Text = "PackageBountyHellChop_Short",

		DifficultyRating = 1,

		WeaponKitName = "WeaponAxe",
		WeaponUpgradeName = "AxeRecoveryAspect",
		KeepsakeName = "DecayingBoostKeepsake",
		RemoveFamiliar = true,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HephaestusUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "ArmorBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "AntiArmorBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "EncounterStartDefenseBuffBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		RunOverrides =
		{
			LootTypeHistory =
			{
				ApolloUpgrade = 3,
				HestiaUpgrade = 1,
				WeaponUpgrade = 3,
			},
		},

		StartingTraits =
		{
			{ Name = "AxeThirdStrikeTrait", },
			{ Name = "AxeMassiveThirdStrikeTrait", },
			{ Name = "AxeAttackRecoveryTrait", },
			{ Name = "ApolloWeaponBoon", Rarity = "Heroic", },
			{ Name = "HestiaManaBoon", Rarity = "Heroic", },
			{ Name = "PerfectDamageBonusBoon", Rarity = "Epic", },
			{ Name = "DoubleStrikeChanceBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"HealthRegen",
			"LowManaDamageBonus",
			"BonusHealth",
			"LastStand",
		},

		ShrineUpgradesActive =
		{
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeF", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponAxe", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "DecayingBoostKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", "HestiaFirstPickUp", "HephaestusFirstPickUp", },
			},
			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
		},
	},
	PackageBountyLowMana =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },
		Text = "PackageBountyLowMana_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponSuit",
		WeaponUpgradeName = "SuitHexAspect",
		KeepsakeName = "ArmorGainKeepsake",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 3,
			LootTypeHistory =
			{
				HeraUpgrade = 3,
				HestiaUpgrade = 2,
				HephaestusUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "HestiaSpecialBoon", Rarity = "Epic", },
			{ Name = "HeraCastBoon", Rarity = "Epic", },
			{ Name = "HeraManaBoon", Rarity = "Epic", },
			{ Name = "OmegaHeraProjectileBoon", Rarity = "Epic", },
			{ Name = "FireballManaSpecialBoon", Rarity = "Epic", },
			{ Name = "HeavyArmorBoon", Rarity = "Epic", },
		},

		MetaUpgradeStateEquipped =
		{
			"LowManaDamageBonus",
			"CastCount",
			"SorceryRegenUpgrade",
			"BonusHealth",
			"LastStand",
			"StatusVulnerability",
			"BonusRarity",
			"ScreenReroll",
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "TalentLegal", },
					},
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "TalentLegal", },
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "ManaRestoreDamageBoon" },
						},
						{
							PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "ManaShieldBoon" },
						},
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "ManaRestoreDamageBoon" },
						},
						{
							PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "ManaShieldBoon" },
						},
					},
				},
			},
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeG", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponSuit", "SuitHexAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ArmorGainKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "HestiaFirstPickUp", "HephaestusFirstPickUp", },
			},
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt", },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
		},
	},
	PackageBountyHazard =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },
		Text = "PackageBountyHazard_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponLob",
		WeaponUpgradeName = "LobCloseAttackAspect",
		KeepsakeName = "TempHammerKeepsake",
		RemoveFamiliar = true,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ApolloUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "ApolloWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "ApolloCastBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PerfectDamageBonusBoon",
						Rarity = "Heroic",
					},
				},
			},
		},

		RunOverrides =
		{
			LootTypeHistory =
			{
				ApolloUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "ApolloCastAreaBoon", Rarity = "Epic" },
			{ Name = "ApolloManaBoon", Rarity = "Heroic" },
			{ Name = "CastHazardBoon", },
			{ Name = "OmegaCastVolleyBoon", Rarity = "Epic" },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "Boon",
					ForceLootName = "DemeterUpgrade",
					AllowDuplicates = true,
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"HealthRegen",
			"CastCount",
			"SorceryRegenUpgrade",
			"CastBuff",
			"BonusHealth",
			"BonusDodge",
			"ManaOverTime",
			"MagicCrit",
			"LastStand",
			"MaxHealthPerRoom",
		},

		ShrineUpgradesActive =
		{
			BoonManaReserveShrineUpgrade = 2,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeN", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponLob", "LobCloseAttackAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "TempHammerKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", "DemeterFirstPickUp", },
			},

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 5,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
		},
	},
	PackageBountyHecate =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },
		Text = "PackageBountyHecate_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponTorch",
		WeaponUpgradeName = "TorchSpecialDurationAspect",
		KeepsakeName = "ManaOverTimeRefundKeepsake",
		--RemoveFamiliar = true,

		ForcedRewards =
		{
			{
				Name = "SpellDrop",
			},
		},
		RunOverrides =
		{
			LootTypeHistory =
			{
				WeaponUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "TorchLongevityTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "MaxHealthDrop",
				},
				{
					Name = "MaxManaDrop",
				},
				{
					Name = "RoomMoneyDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
					}
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "TalentLegal", },
					},
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "TalentLegal", },
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"CastCount",
			"SorceryRegenUpgrade",
			"CastBuff",
			"BonusHealth",
			"ManaOverTime",
			"MagicCrit",
			"LastStand",
			"MaxHealthPerRoom",
			"ChanneledBlock",
			"DoorReroll",
		},

		ShrineUpgradesActive =
		{
			BossDifficultyShrineUpgrade = 1,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeF", "ShrineUnlocked" },
			-- Vow of Rivals
			{
				Path = { "GameState", "EncountersOccurredCache", "BossHecate02" },
				Comparison = ">=",
				Value = 1
			},
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponTorch", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ManaOverTimeRefundKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "SeleneFirstPickUp", },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "DoorReroll", "Unlocked", },
			},
		},
	},
	PackageBountyPolyphemus =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },
		Text = "PackageBountyPolyphemus_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponLob",
		WeaponUpgradeName = "LobAmmoBoostAspect",
		KeepsakeName = "ReincarnationKeepsake",
		RemoveFamiliar = true,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "AphroditeUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "ManaBurstBoon",
						Rarity = "Heroic",
					},
					{
						Type = "Trait",
						ItemName = "SlamManaBurstBoon",
						Rarity = "Duo",
					},
					{
						Type = "Trait",
						ItemName = "BloodManaBurstBoon",
						Rarity = "Duo",
					},
				},
			},
		},

		RunOverrides =
		{
			MaxGodsPerRun = 3,
			LootTypeHistory =
			{
				AphroditeUpgrade = 1,
				AresUpgrade = 1,
				HephaestusUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "AphroditeWeaponBoon", Rarity = "Epic" },
			{ Name = "HephaestusSpecialBoon", Rarity = "Epic" },
			{ Name = "AresManaBoon", Rarity = "Epic" },

		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"LowManaDamageBonus",
			"BonusHealth",
			"SprintShield",
			"LastStand",
			"MaxHealthPerRoom",
			"ChanneledBlock",
			"DoorReroll",
			"RarityBoost",
			"BonusRarity",
			"ScreenReroll",
		},

		ShrineUpgradesActive =
		{
			BossDifficultyShrineUpgrade = 1,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeN", "ShrineUnlocked", },
			-- Vow of Rivals
			{
				Path = { "GameState", "EncountersOccurredCache", "BossPolyphemus02" },
				Comparison = ">=",
				Value = 1
			},
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponLob", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ReincarnationKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AphroditeFirstPickUp", "AresFirstPickUp", "HephaestusFirstPickUp" },
			},

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "DoorReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
		},
	},
	PackageBountyScylla =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },
		Text = "PackageBountyScylla_Short",

		DifficultyRating = 4,

		WeaponKitName = "WeaponStaffSwing",
		WeaponUpgradeName = "StaffClearCastAspect",
		KeepsakeName = "BossPreDamageKeepsake",
		FamiliarName = "CatFamiliar",

		RunOverrides =
		{
			MaxGodsPerRun = 3,
			LootTypeHistory =
			{
				AresUpgrade = 3,
				ApolloUpgrade = 2,
				DemeterUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "DemeterCastBoon", Rarity = "Epic", },
			{ Name = "ApolloManaBoon", Rarity = "Epic", },
			{ Name = "ApolloCastAreaBoon", Rarity = "Epic", },
			{ Name = "AresExCastBoon", Rarity = "Epic", },
			{ Name = "OmegaDelayedDamageBoon", Rarity = "Epic", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"CastCount",
			"SorceryRegenUpgrade",
			"CastBuff",
			"BonusHealth",
			"SprintShield",
			"LastStand",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"ChanneledBlock",
			"BonusRarity",
			"ScreenReroll",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{
			BossDifficultyShrineUpgrade = 2,
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				-- General
				{
					Name = "MaxHealthDrop",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CastAttachBoon" },
						},
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DoubleSwordBoon" },
						},
					},
				},
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CastAttachBoon" },
						},
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DoubleSwordBoon" },
						},
					},
				},
				{
					Name = "RoomMoneyDrop",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CastAttachBoon" },
						},
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DoubleSwordBoon" },
						},
					},
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CastAttachBoon" },
						},
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DoubleSwordBoon" },
						},
					}
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeG", "ShrineUnlocked", },
			-- Vow of Rivals
			{
				Path = { "GameState", "EncountersOccurredCache", "BossScylla02" },
				Comparison = ">=",
				Value = 1
			},
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", "StaffClearCastAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "BossPreDamageKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AresFirstPickUp", "DemeterFirstPickUp", "ApolloFirstPickUp" },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountyStrife =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeO", },
		Text = "PackageBountyStrife_Short",

		DifficultyRating = 4,

		WeaponKitName = "WeaponSuit",
		WeaponUpgradeName = "SuitMarkCritAspect",
		KeepsakeName = "EscalatingKeepsake",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 3,
			LootTypeHistory =
			{
				HephaestusUpgrade = 2,
				DemeterUpgrade = 1,
				ZeusUpgrade = 1,
				WeaponUpgrade = 1,
			}
		},

		StartingTraits =
		{
			{ Name = "DemeterWeaponBoon", Rarity = "Epic", },
			{ Name = "HephaestusSprintBoon", Rarity = "Epic", },
			{ Name = "FocusLightningBoon", Rarity = "Epic", },
			{ Name = "MassiveKnockupBoon", Rarity = "Epic", },
			{ Name = "ManaToHealthBoon", Rarity = "Epic", },
			{ Name = "SuitDashAttackTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"LowManaDamageBonus",
			"SorceryRegenUpgrade",
			"BonusHealth",
			"ManaOverTime",
			"SprintShield",
			"LastStand",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"ChanneledBlock",
			"DoorReroll",
			"BonusRarity",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{
			BossDifficultyShrineUpgrade = 2,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeO", "ShrineUnlocked", },
			-- Vow of Rivals
			{
				Path = { "GameState", "EncountersOccurredCache", "BossEris02" },
				Comparison = ">=",
				Value = 1
			},
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponSuit", "SuitMarkCritAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "EscalatingKeepsake", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AresFirstPickUp", "HestiaFirstPickUp" },
			},
			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "DoorReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountyStaffLegendary =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },
		Text = "PackageBountyStaffLegendary_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponStaffSwing",
		WeaponUpgradeName = "StaffRaiseDeadAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ApolloUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "ApolloCastBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "ApolloSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "ApolloManaBoon",
						Rarity = "Epic",
					},
				},
			},
		},

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				ApolloUpgrade = 1,
				HeraUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "ApolloWeaponBoon", Rarity = "Epic" },
			{ Name = "HeraSpecialBoon", Rarity = "Epic" },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "SpellDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "SpellDropRequirements", },
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsNone = { "N_Opening01" },
						},
					},
				},
			},
			HubRewards =
			{
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
					}
				},
				{
					Name = "MaxHealthDropBig",
				},
				{
					Name = "Boon",
					ForceLootName = "HeraUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					ForceLootName = "HeraUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					ForceLootName = "ApolloUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					ForceLootName = "ApolloUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},

			SubRoomRewards =
			{
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "TalentLegal", },
					},
				},
				{
					Name = "MaxHealthDrop",
					GameStateRequirements =
					{
						NamedRequirementsFalse = { "TalentLegal", },
					},
				},
			},
			SubRoomRewardsHard =
			{
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "TalentLegal", },
					},
				},
				{
					Name = "MaxHealthDrop",
					GameStateRequirements =
					{
						NamedRequirementsFalse = { "TalentLegal", },
					},
				},
			},

		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"HealthRegen",
			"LowManaDamageBonus",
			"CastCount",
			"SorceryRegenUpgrade",
			"CastBuff",
			"ManaOverTime",
			"LastStand",
			"MaxHealthPerRoom",
			"ChanneledBlock",
			"RarityBoost",
			"BonusRarity",
			"ScreenReroll",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{
			NextBiomeEnemyShrineUpgrade = 2,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeN", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", "StaffRaiseDeadAspect", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", },
			},

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 15,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountyDaggerLegendary =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },
		Text = "PackageBountyDaggerLegendary_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerTripleAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		RunOverrides =
		{
			LootTypeHistory =
			{
				DemeterUpgrade = 1,
				HephaestusUpgrade = 3,
			},
		},

		StartingTraits =
		{
			{ Name = "DemeterWeaponBoon", Rarity = "Epic" },
			{ Name = "HephaestusSpecialBoon", Rarity = "Heroic" },
			{ Name = "EncounterStartDefenseBuffBoon", Rarity = "Epic" },
			{ Name = "MassiveDamageBoon", Rarity = "Epic" },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "MaxHealthDrop",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "WeaponUpgradeBoon" },
						},
					},
				},
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "WeaponUpgradeBoon" },
						},
					},
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "WeaponUpgradeBoon" },
						},
					}
				},
				{
					Name = "Boon",
					ForceLootName = "HephaestusUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					ForceLootName = "HephaestusUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					ForceLootName = "DemeterUpgrade",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ClearRootBoon" },
						},
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "WeaponUpgradeBoon" },
						},
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ClearRootBoon" },
						},
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "WeaponUpgradeBoon" },
						},
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"HealthRegen",
			"LowManaDamageBonus",
			"CastCount",
			"SorceryRegenUpgrade",
			"CastBuff",
			"BonusHealth",
			"ManaOverTime",
			"MagicCrit",
			"LastStand",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"MetaToRunUpgrade",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{
			EnemyShieldShrineUpgrade = 2,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeG", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", "DaggerTripleAspect", },
			},
			--[[ FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", },
			},]]

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 15,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MetaToRunUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountyAxeLegendary =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeO", },
		Text = "PackageBountyAxeLegendary_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponAxe",
		WeaponUpgradeName = "AxeRallyAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 3,
			LootTypeHistory =
			{
				AphroditeUpgrade = 2,
				DemeterUpgrade = 1,
				PoseidonUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "AphroditeWeaponBoon", Rarity = "Epic" },
			{ Name = "DemeterCastBoon", Rarity = "Epic" },
			{ Name = "HealthRewardBonusBoon", Rarity = "Epic" },
			{ Name = "HighHealthOffenseBoon", Rarity = "Epic" },
			{ Name = "DoorHealToFullBoon", Rarity = "Epic" },
			{ Name = "ElementalHealthBoon", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "MaxHealthDrop",
				},
				{
					Name = "MaxManaDrop",
				},
				{
					Name = "RoomMoneyDrop",
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"HealthRegen",
			"LowManaDamageBonus",
			"CastCount",
			"SorceryRegenUpgrade",
			"BonusHealth",
			"BonusDodge",
			"LastStand",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"MetaToRunUpgrade",
			"RarityBoost",
			"BonusRarity",
			"LowHealthBonus",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{
			BoonSkipShrineUpgrade = 1,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeO", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponAxe", "AxeRallyAspect", },
			},
			--[[ FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", },
			},]]

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 15,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MetaToRunUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountyTorchLegendary =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeH", },
		Text = "PackageBountyTorchLegendary_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponTorch",
		WeaponUpgradeName = "TorchAutofireAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				ZeusUpgrade = 3,
				PoseidonUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "PoseidonWeaponBoon", Rarity = "Epic" },
			{ Name = "ZeusSpecialBoon", Rarity = "Epic" },
			{ Name = "PoseidonStatusBoon", Rarity = "Epic" },
			{ Name = "ZeusSprintBoon", Rarity = "Epic" },
			{ Name = "ZeusManaBoon", Rarity = "Epic" },

			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
					}
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
					}
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "LateHammerLootRequirements" },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
					},
				},
				{
					Name = "SpellDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "SpellDropRequirements", },
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},

			FieldsOptionalRewards =
			{
				{
					Name = "MaxManaDrop",
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"LowManaDamageBonus",
			"SorceryRegenUpgrade",
			"CastBuff",
			"BonusDodge",
			"ManaOverTime",
			"MagicCrit",
			"SprintShield",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"MetaToRunUpgrade",
			"RarityBoost",
			"LowHealthBonus",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{
			EnemyCountShrineUpgrade = 3,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeH", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponTorch", "TorchAutofireAspect", },
			},
			--[[ FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", },
			},]]

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 15,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MetaToRunUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},
	PackageBountyLobLegendary =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },
		Text = "PackageBountyLobLegendary_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponLob",
		WeaponUpgradeName = "LobGunAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HestiaUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "HestiaManaBoon",
						Rarity = "Heroic",
					},
					{
						Type = "Trait",
						ItemName = "BurnStackBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "BurnConsumeBoon",
						Rarity = "Duo",
					},
				},
			},
		},

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				HestiaUpgrade = 1,
				DemeterUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "HestiaWeaponBoon", Rarity = "Epic" },
			{ Name = "DemeterSpecialBoon", Rarity = "Epic" },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				{
					Name = "MaxHealthDrop",
				},
				{
					Name = "MaxManaDrop",
				},
				{
					Name = "RoomMoneyDrop",
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
					},
				},
				{
					Name = "SpellDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "SpellDropRequirements", },
					},
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "TalentLegal", },
						{
							Path = { "CurrentRun", "ClearedBiomes" },
							Comparison = ">",
							Value = 1,
						},
						{
							PathFalse = { "CurrentRun", "BiomeUseRecord", "TalentDrop" },
						},
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"LowManaDamageBonus",
			"CastCount",
			"SorceryRegenUpgrade",
			"CastBuff",
			"BonusHealth",
			"ManaOverTime",
			"MagicCrit",
			"LastStand",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"ScreenReroll",
		},

		ShrineUpgradesActive =
		{
			EnemySpeedShrineUpgrade = 2,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeF", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponLob", "LobGunAspect", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "HestiaFirstPickUp", },
			},

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 15,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
		},
	},
	PackageBountySuitLegendary =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeP", },
		Text = "PackageBountySuitLegendary_Short",

		DifficultyRating = 3,

		WeaponKitName = "WeaponSuit",
		WeaponUpgradeName = "SuitComboAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		RunOverrides =
		{
			MaxGodsPerRun = 3,
			LootTypeHistory =
			{
				AresUpgrade = 5,
				HeraUpgrade = 2,
				HestiaUpgrade = 2,
				WeaponUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "AresWeaponBoon", Rarity = "Epic" },
			{ Name = "HeraSpecialBoon", Rarity = "Epic" },
			{ Name = "HestiaCastBoon", Rarity = "Epic" },
			{ Name = "AresManaBoon", Rarity = "Epic" },
			{ Name = "RendBloodDropBoon", Rarity = "Epic" },
			{ Name = "BloodDropRevengeBoon", Rarity = "Epic" },
			{ Name = "AresStatusDoubleDamageBoon", Rarity = "Epic" },
			{ Name = "CastProjectileBoon", Rarity = "Epic" },
			{ Name = "DamageShareRetaliateBoon", Rarity = "Epic" },
			{ Name = "SuitAttackSizeTrait", },

			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		RewardStoreOverrides =
		{
			RunProgress =
			{
				-- General
				{
					Name = "MaxHealthDrop",
				},
				{
					Name = "MaxManaDrop",
				},
				{
					Name = "RoomMoneyDrop",
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
					}
				},
				{
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "LateHammerLootRequirements" },
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HermesUpgradeRequirements", },
					},
				},
				{
					Name = "SpellDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "SpellDropRequirements", },
					},
				},
				{
					Name = "TalentDrop",
					GameStateRequirements =
					{
						NamedRequirements = { "TalentLegal", },
						{
							Path = { "CurrentRun", "ClearedBiomes" },
							Comparison = ">",
							Value = 1,
						},
						{
							PathFalse = { "CurrentRun", "BiomeUseRecord", "TalentDrop" },
						},
					},
				},
				{
					Name = "Boon",
					LootName = "AresUpgrade",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					LootName = "AresUpgrade",
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
				{
					Name = "Boon",
					AllowDuplicates = true,
					GameStateRequirements =
					{
						-- None
					},
				},
			},
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"HealthRegen",
			"LowManaDamageBonus",
			"CastCount",
			"SorceryRegenUpgrade",
			"CastBuff",
			"LastStand",
			"MaxHealthPerRoom",
			"StatusVulnerability",
			"ChanneledBlock",
			"RarityBoost",
			"BonusRarity",
			"LowHealthBonus",
			"EpicRarityBoost",
		},

		ShrineUpgradesActive =
		{
			EnemyHealthShrineUpgrade = 3,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeP", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "PackagedBountyClears" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponSuit", "SuitComboAspect", },
			},

			-- MetaUpgrades
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 15,
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked", },
			},
		},
	},


	-- Random Package Bounties
	BasePackageBountyRandom =
	{
		DebugOnly = true,
		Text = "BasePackageBountyRandom_Short",
		Category = "BountyRandom",
		IsPackagedBounty = true,
		RandomBountyStreakEligible = true,
		RunOverrides =
		{
			DeepInheritance = true,
			HarvestPointChanceMultiplier = 0,
			ShovelPointChanceMultiplier = 0,
			PickaxePointChanceMultiplier = 0,
			ExorcismPointChanceMultiplier = 0,
			FishingPointChanceMultiplier = 0,
		},

		LootOptions =
		{
			{
				Name = "GemPointsBigDrop",
				Overrides =
				{
					CanDuplicate = false,
				}
			},
		},

		StartingRoomOverrides =
		{
			ForcedEntranceFunctionName = "RoomEntranceBountyStart",
		},

		RandomWeaponKitNames = {  "WeaponStaffSwing", "WeaponAxe", "WeaponDagger", "WeaponTorch", "WeaponLob", "WeaponSuit" },
		UseRandomWeaponUpgrade = true,
		RandomFamiliarNames = { "FrogFamiliar", "CatFamiliar", "RavenFamiliar", "HoundFamiliar", "PolecatFamiliar", },
		RandomKeepsakeNames =
		{ 
			"ManaOverTimeRefundKeepsake",
			"BossPreDamageKeepsake",
			"ReincarnationKeepsake",
			"DoorHealReserveKeepsake",
			"DeathVengeanceKeepsake",
			"BlockDeathKeepsake",
			"EscalatingKeepsake",
			"BonusMoneyKeepsake",
			"TimedBuffKeepsake",
			"LowHealthCritKeepsake",
			"SpellTalentKeepsake",
			"ForceZeusBoonKeepsake",
			"ForceHeraBoonKeepsake",
			"ForcePoseidonBoonKeepsake",
			"ForceDemeterBoonKeepsake",
			"ForceApolloBoonKeepsake",
			"ForceAphroditeBoonKeepsake",
			"ForceHephaestusBoonKeepsake",
			"ForceHestiaBoonKeepsake",
			"ForceAresBoonKeepsake",
			"AthenaEncounterKeepsake",
			"SkipEncounterKeepsake",
			"ArmorGainKeepsake",
			"FountainRarityKeepsake",
			"UnpickedBoonKeepsake",
			"DecayingBoostKeepsake",
			"DamagedDamageBoostKeepsake",
			"BossMetaUpgradeKeepsake",
			"TempHammerKeepsake",
			"RandomBlessingKeepsake",
		},
		RandomFatedKeepsakeNames =
		{
			"RarifyKeepsake",
			"HadesAndPersephoneKeepsake",
			"GoldifyKeepsake",
		},

		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyRandomUnderworld_Difficulty1 =
	{
		InheritFrom = { "BasePackageBountyRandom", "ChronosEncounters" },
		Text = "PackageBountyRandomUnderworld_Difficulty1_Short",

		StartingBiome = "F",
		BiomeIcon = "GUI\\Screens\\BountyBoard\\Biome_Underworld",
		BiomeText = "BountyBoard_UnderworldRun",
		
		RandomMetaUpgradeCostTotal = 30,
		RandomShrineUpgradePointTotal = 0,

		LootOptions =
		{
			{
				Name = "GemPointsBigDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						GemPoints = 40,
					},
				},
			},
		},

		UnlockGameStateRequirements =
		{
			NamedRequirements = { "PackageBountyRandom" },
		},
	},
	PackageBountyRandomUnderworld_Difficulty2 =
	{
		InheritFrom = { "BasePackageBountyRandom", "ChronosEncounters" },
		Text = "PackageBountyRandomUnderworld_Difficulty2_Short",

		StartingBiome = "F",
		BiomeIcon = "GUI\\Screens\\BountyBoard\\Biome_Underworld",
		BiomeText = "BountyBoard_UnderworldRun",
		
		RandomMetaUpgradeCostTotal = 30,
		RandomShrineUpgradePointTotal = 20,

		UnlockGameStateRequirements =
		{
			NamedRequirements = { "PackageBountyRandom" },
			{
				Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
				Comparison = ">=",
				Value = 10,
			},
			{
				Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
				Comparison = ">=",
				Value = 10,
			},
		},
	},

	PackageBountyRandomSurface_Difficulty1 =
	{
		InheritFrom = { "BasePackageBountyRandom", "TyphonEncounters" },
		Text = "PackageBountyRandomSurface_Difficulty1_Short",

		StartingBiome = "N",
		BiomeIcon = "GUI\\Screens\\BountyBoard\\Biome_Surface",
		BiomeText = "BountyBoard_SurfaceRun",
		
		RandomMetaUpgradeCostTotal = 30,
		RandomShrineUpgradePointTotal = 0,

		LootOptions =
		{
			{
				Name = "GemPointsBigDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						GemPoints = 40,
					},
				},
			},
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyRandom" },
		},
	},
	PackageBountyRandomSurface_Difficulty2 =
	{
		InheritFrom = { "BasePackageBountyRandom", "TyphonEncounters" },
		Text = "PackageBountyRandomSurface_Difficulty2_Short",

		StartingBiome = "N",
		BiomeIcon = "GUI\\Screens\\BountyBoard\\Biome_Surface",
		BiomeText = "BountyBoard_SurfaceRun",
		
		RandomMetaUpgradeCostTotal = 30,
		RandomShrineUpgradePointTotal = 20,

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyRandom" },
			{
				Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
				Comparison = ">=",
				Value = 10,
			},
			{
				Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
				Comparison = ">=",
				Value = 10,
			},
		},
	},


	-- Boss Heat Bounties

	DefaultBossHeatBounty =
	{
		DebugOnly = true,
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 1,
					},
				}
			},
		},
		TitleText = "ShrineBountyCompleteMessage",
		SubtitleText = "ShrineBountyCompleteSubtitle",
	},

	ShrineBountyNameSwapMap =
	{
		-- Heat 1 Bounties
		BountyStaffHeat1FBoss = "BountyShrineStaffFBoss",
		BountyDaggerHeat1GBoss = "BountyShrineDaggerGBoss",
		BountyTorchHeat1OBoss = "BountyShrineTorchOBoss",
		BountyAxeHeat1NBoss = "BountyShrineAxeNBoss",
		BountyLobHeat1HBoss = "BountyShrineLobHBoss",
		BountySuitHeat1PBoss = "BountyShrineSuitPBoss",

		-- Heat 2 Bounties
		BountyStaffHeat2GBoss = "BountyShrineStaffGBoss",
		BountyDaggerHeat2NBoss = "BountyShrineDaggerNBoss",
		BountyTorchHeat2HBoss = "BountyShrineTorchHBoss",
		BountyAxeHeat2OBoss = "BountyShrineAxeOBoss",
		BountyLobHeat2PBoss = "BountyShrineLobPBoss",
		BountySuitHeat2FBoss = "BountyShrineSuitFBoss",

		-- Heat 4 Bounties
		BountyStaffHeat4NBoss = "BountyShrineStaffNBoss",
		BountyDaggerHeat4OBoss = "BountyShrineDaggerOBoss",
		BountyTorchHeat4PBoss = "BountyShrineTorchPBoss",
		BountyAxeHeat4HBoss = "BountyShrineAxeHBoss",
		BountyLobHeat4FBoss = "BountyShrineLobFBoss",
		BountySuitHeat4GBoss = "BountyShrineSuitGBoss",

		-- Heat 8 Bounties
		BountyStaffHeat8OBoss = "BountyShrineStaffOBoss",
		BountyDaggerHeat8HBoss = "BountyShrineDaggerHBoss",
		BountyTorchHeat8FBoss = "BountyShrineTorchFBoss",
		BountyAxeHeat8PBoss = "BountyShrineAxePBoss",
		BountyLobHeat8GBoss = "BountyShrineLobGBoss",
		BountySuitHeat8NBoss = "BountyShrineSuitNBoss",

		-- Heat 12 -> 10 Bounties
		BountyStaffHeat12HBoss = "BountyShrineStaffHBoss",
		BountyDaggerHeat12PBoss = "BountyShrineDaggerPBoss",
		BountyTorchHeat12GBoss = "BountyShrineTorchGBoss",
		BountyAxeHeat12FBoss = "BountyShrineAxeFBoss",
		BountyLobHeat12NBoss = "BountyShrineLobNBoss",
		BountySuitHeat12OBoss = "BountyShrineSuitOBoss",

		-- Heat 16 -> 12 Bounties
		BountyStaffHeat16PBoss = "BountyShrineStaffPBoss",
		BountyDaggerHeat16FBoss = "BountyShrineDaggerFBoss",
		BountyTorchHeat16NBoss = "BountyShrineTorchNBoss",
		BountyAxeHeat16GBoss = "BountyShrineAxeGBoss",
		BountyLobHeat16OBoss = "BountyShrineLobOBoss",
		BountySuitHeat16HBoss = "BountyShrineSuitHBoss",

		-- Heat 20 -> 16 Bounties
		BountyStaffHeat20IBoss = "BountyShrineStaffIBoss",
		BountyAxeHeat20IBoss = "BountyShrineAxeIBoss",
		BountyLobHeat20IBoss = "BountyShrineLobIBoss",

		-- Heat 24 -> 20 Bounties
		BountyDaggerHeat24IBoss = "BountyShrineDaggerIBoss",
		BountyTorchHeat24IBoss = "BountyShrineTorchIBoss",
		BountySuitHeat24IBoss = "BountyShrineSuitIBoss",
	},

	-- Staff Bounties
	BountyShrineStaffFBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "HecateEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponStaffSwing" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 1,
			},
		},	
	},
	BountyShrineStaffGBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ScyllaEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineStaffFBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponStaffSwing" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	BountyShrineStaffNBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PolyphemusEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineStaffFBoss",
					"BountyShrineStaffGBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponStaffSwing" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 4,
			},
		},
	},
	BountyShrineStaffOBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ErisEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
			},
			{
				PathTrue = { "GameState", "ShrineBountiesCompleted",  },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineStaffFBoss",
					"BountyShrineStaffGBoss",
					"BountyShrineStaffNBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponStaffSwing" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 8,
			},
		},
	},
	BountyShrineStaffHBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "InfestedCerberusEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineStaffFBoss",
					"BountyShrineStaffGBoss",
					"BountyShrineStaffNBoss",
					"BountyShrineStaffOBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponStaffSwing" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 10,
			},
		},
	},
	BountyShrineStaffPBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PrometheusEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPrometheus01", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineStaffFBoss",
					"BountyShrineStaffGBoss",
					"BountyShrineStaffNBoss",
					"BountyShrineStaffOBoss",
					"BountyShrineStaffHBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponStaffSwing" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 12,
			},
		},
	},
	BountyShrineStaffIBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ChronosEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineStaffFBoss",
					"BountyShrineStaffGBoss",
					"BountyShrineStaffNBoss",
					"BountyShrineStaffOBoss",
					"BountyShrineStaffHBoss",
					"BountyShrineStaffPBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponStaffSwing" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 16,
			},
		},
	},
	BountyShrineStaffQBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "TyphonEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossTyphonHead01" },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineStaffFBoss",
					"BountyShrineStaffGBoss",
					"BountyShrineStaffNBoss",
					"BountyShrineStaffOBoss",
					"BountyShrineStaffHBoss",
					"BountyShrineStaffPBoss",
					"BountyShrineStaffIBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponStaffSwing" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 20,
			},
		},
	},

	-- Dagger Bounties
	BountyShrineDaggerGBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ScyllaEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger", },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 1,
			},
		},
	},
	BountyShrineDaggerNBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PolyphemusEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineDaggerGBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	BountyShrineDaggerOBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ErisEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineDaggerGBoss",
					"BountyShrineDaggerNBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 4,
			},
		},
	},
	BountyShrineDaggerHBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "InfestedCerberusEncounters" },
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineDaggerGBoss",
					"BountyShrineDaggerNBoss",
					"BountyShrineDaggerOBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 8,
			},
		},
	},
	BountyShrineDaggerPBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PrometheusEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPrometheus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineDaggerGBoss",
					"BountyShrineDaggerNBoss",
					"BountyShrineDaggerOBoss",
					"BountyShrineDaggerHBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 10,
			},
		},
	},
	BountyShrineDaggerFBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "HecateEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineDaggerGBoss",
					"BountyShrineDaggerNBoss",
					"BountyShrineDaggerOBoss",
					"BountyShrineDaggerHBoss",
					"BountyShrineDaggerPBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 12,
			},
		},	
	},
	BountyShrineDaggerQBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "TyphonEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossTyphonHead01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineDaggerGBoss",
					"BountyShrineDaggerNBoss",
					"BountyShrineDaggerOBoss",
					"BountyShrineDaggerHBoss",
					"BountyShrineDaggerPBoss",
					"BountyShrineDaggerFBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 16,
			},
		},
	},
	BountyShrineDaggerIBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ChronosEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineDaggerGBoss",
					"BountyShrineDaggerNBoss",
					"BountyShrineDaggerOBoss",
					"BountyShrineDaggerHBoss",
					"BountyShrineDaggerPBoss",
					"BountyShrineDaggerFBoss",
					"BountyShrineDaggerQBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponDagger" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 20,
			},
		},
	},

	-- Axe Bounties
	BountyShrineAxeNBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PolyphemusEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe", },
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponAxe" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 1,
			},
		},
	},
	BountyShrineAxeOBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ErisEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineAxeNBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponAxe" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	BountyShrineAxeHBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "InfestedCerberusEncounters" },
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineAxeNBoss",
					"BountyShrineAxeOBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponAxe" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 4,
			},
		},
	},
	BountyShrineAxePBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PrometheusEncounters" },
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPrometheus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineAxeNBoss",
					"BountyShrineAxeOBoss",
					"BountyShrineAxeHBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponAxe" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 8,
			},
		},
	},
	BountyShrineAxeFBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "HecateEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineAxeNBoss",
					"BountyShrineAxeOBoss",
					"BountyShrineAxeHBoss",
					"BountyShrineAxePBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponAxe" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 10,
			},
		},	
	},
	BountyShrineAxeGBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ScyllaEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineAxeNBoss",
					"BountyShrineAxeOBoss",
					"BountyShrineAxeHBoss",
					"BountyShrineAxePBoss",
					"BountyShrineAxeFBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponAxe" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 12,
			},
		},
	},
	BountyShrineAxeIBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ChronosEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineAxeNBoss",
					"BountyShrineAxeOBoss",
					"BountyShrineAxeHBoss",
					"BountyShrineAxePBoss",
					"BountyShrineAxeFBoss",
					"BountyShrineAxeGBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponAxe" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 16,
			},
		},
	},
	BountyShrineAxeQBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "TyphonEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossTyphonHead01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineAxeNBoss",
					"BountyShrineAxeOBoss",
					"BountyShrineAxeHBoss",
					"BountyShrineAxePBoss",
					"BountyShrineAxeFBoss",
					"BountyShrineAxeGBoss",
					"BountyShrineAxeIBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponAxe" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 20,
			},
		},
	},
	
	-- Torch Bounties
	BountyShrineTorchOBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ErisEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponTorch", },
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponTorch" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 1,
			},
		},
	},
	BountyShrineTorchHBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "InfestedCerberusEncounters" },
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponTorch", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineTorchOBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponTorch" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	BountyShrineTorchPBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PrometheusEncounters" },
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPrometheus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponTorch", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineTorchOBoss",
					"BountyShrineTorchHBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponTorch" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 4,
			},
		},
	},
	BountyShrineTorchFBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "HecateEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponTorch", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineTorchOBoss",
					"BountyShrineTorchHBoss",
					"BountyShrineTorchPBoss",
				},
			},		
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponTorch" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 8,
			},
		},	
	},
	BountyShrineTorchGBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ScyllaEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponTorch", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineTorchOBoss",
					"BountyShrineTorchHBoss",
					"BountyShrineTorchPBoss",
					"BountyShrineTorchFBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponTorch" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 10,
			},
		},
	},
	BountyShrineTorchNBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PolyphemusEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponTorch", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineTorchOBoss",
					"BountyShrineTorchHBoss",
					"BountyShrineTorchPBoss",
					"BountyShrineTorchFBoss",
					"BountyShrineTorchGBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponTorch" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 12,
			},
		},
	},
	BountyShrineTorchQBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "TyphonEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossTyphonHead01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponTorch", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineTorchOBoss",
					"BountyShrineTorchHBoss",
					"BountyShrineTorchPBoss",
					"BountyShrineTorchFBoss",
					"BountyShrineTorchGBoss",
					"BountyShrineTorchNBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponTorch" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 16,
			},
		},
	},
	BountyShrineTorchIBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ChronosEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponTorch", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineTorchOBoss",
					"BountyShrineTorchHBoss",
					"BountyShrineTorchPBoss",
					"BountyShrineTorchFBoss",
					"BountyShrineTorchGBoss",
					"BountyShrineTorchNBoss",
					"BountyShrineTorchQBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponTorch" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 20,
			},
		},
	},

	-- Lob Bounties
	BountyShrineLobHBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "InfestedCerberusEncounters" },
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponLob", },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponLob" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 1,
			},
		},
	},
	BountyShrineLobPBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PrometheusEncounters" },
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPrometheus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponLob", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineLobHBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponLob" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	BountyShrineLobFBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "HecateEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponLob", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineLobHBoss",
					"BountyShrineLobPBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponLob" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 4,
			},
		},	
	},
	BountyShrineLobGBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ScyllaEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponLob", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineLobHBoss",
					"BountyShrineLobPBoss",
					"BountyShrineLobFBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponLob" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 8,
			},
		},
	},
	BountyShrineLobNBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PolyphemusEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponLob", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineLobHBoss",
					"BountyShrineLobPBoss",
					"BountyShrineLobFBoss",
					"BountyShrineLobGBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponLob" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 10,
			},
		},
	},
	BountyShrineLobOBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ErisEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponLob", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineLobHBoss",
					"BountyShrineLobPBoss",
					"BountyShrineLobFBoss",
					"BountyShrineLobGBoss",
					"BountyShrineLobNBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponLob" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 12,
			},
		},
	},
	BountyShrineLobIBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ChronosEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponLob", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineLobHBoss",
					"BountyShrineLobPBoss",
					"BountyShrineLobFBoss",
					"BountyShrineLobGBoss",
					"BountyShrineLobNBoss",
					"BountyShrineLobOBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponLob" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 16,
			},
		},
	},
	BountyShrineLobQBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "TyphonEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossTyphonHead01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponLob", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineLobHBoss",
					"BountyShrineLobPBoss",
					"BountyShrineLobFBoss",
					"BountyShrineLobGBoss",
					"BountyShrineLobNBoss",
					"BountyShrineLobOBoss",
					"BountyShrineLobIBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponLob" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 20,
			},
		},
	},

	-- Suit Bounties
	BountyShrineSuitPBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PrometheusEncounters" },
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPrometheus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit", },
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponSuit" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 1,
			},
		},
	},
	BountyShrineSuitFBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "HecateEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineSuitPBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponSuit" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	BountyShrineSuitGBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ScyllaEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineSuitPBoss",
					"BountyShrineSuitFBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponSuit" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 4,
			},
		},
	},
	BountyShrineSuitNBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "PolyphemusEncounters" },

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineSuitPBoss",
					"BountyShrineSuitFBoss",
					"BountyShrineSuitGBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponSuit" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 8,
			},
		},
	},
	BountyShrineSuitOBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ErisEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineSuitPBoss",
					"BountyShrineSuitFBoss",
					"BountyShrineSuitGBoss",
					"BountyShrineSuitNBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponSuit" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 10,
			},
		},
	},
	BountyShrineSuitHBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "InfestedCerberusEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 2,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineSuitPBoss",
					"BountyShrineSuitFBoss",
					"BountyShrineSuitGBoss",
					"BountyShrineSuitNBoss",
					"BountyShrineSuitOBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponSuit" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 12,
			},
		},
	},
	BountyShrineSuitQBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "TyphonEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossTyphonHead01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineSuitPBoss",
					"BountyShrineSuitFBoss",
					"BountyShrineSuitGBoss",
					"BountyShrineSuitNBoss",
					"BountyShrineSuitOBoss",
					"BountyShrineSuitHBoss",
				},
			},
			NamedRequirementsFalse = { "SurfaceBountyLockedByTyphonKill" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponSuit" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 16,
			},
		},
	},
	BountyShrineSuitIBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty", "ChronosEncounters" },
		LootOptions =
		{
			{
				Name = "WeaponPointsRareDrop",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						WeaponPointsRare = 3,
					},
				}
			},
		},
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit", },
			},
			{
				Path = { "GameState", "ShrineBountiesCompleted", },
				HasAll =
				{
					"BountyShrineSuitPBoss",
					"BountyShrineSuitFBoss",
					"BountyShrineSuitGBoss",
					"BountyShrineSuitNBoss",
					"BountyShrineSuitOBoss",
					"BountyShrineSuitHBoss",
					"BountyShrineSuitQBoss",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons" },
				HasAny = { "WeaponSuit" },
			},
			{
				Path = { "GameState", "SpentShrinePointsCache", },
				Comparison = ">=",
				Value = 20,
			},
		},
	},
}

ScreenData.BountyBoard =
{
	BlockPause = true,
	ItemStartX = 350,
	ItemStartY = 290,
	ItemSpacingY = 52,
	ItemsPerPage = 10,
	ScrollOffset = 0,
	IconOffsetX = 10,
	IconOffsetY = 0,

	CategoryStartX = 540,
	CategoryStartY = 190,
	CategorySpacingX = 250,

	UnlockRequirementsOffsetY = 280,
	MaxEntriesPerColumn = 9,

	RewardAvailableColor = Color.White,
	RewardCashedOutColor = Color.Gray,

	NewIconOffsetX = 160,
	NewIconOffsetY = 0,

	ButtonName = "BountyButton",
	
	CloseSound = "/SFX/Menu Sounds/ChaosTrialMenuClose",

	UsingMouseOverSound = "/SFX/Menu Sounds/MirrorMenuToggle",

	InfoMessageId = "BountyIntro",

	Components = {},

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 1,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
	},

	ActiveFormat =
	{
		Color = { 245, 200, 47, 255 },
		FontSize = 22,
		OffsetX = -10, OffsetY = 0,
		Width = 900,
		Font = "P22UndergroundSCMedium",
		OutlineThickness = 0,
		OutlineColor = {255, 205, 52, 255},
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
		Justification = "Center",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ActiveFlash =
	{
		Speed = 0.8,
		MinFraction = 0.0,
		MaxFraction = 0.7,
		Color = Color.White,
	},

	CompletedFormat =
	{
		Color = { 215, 215, 215, 255 },
		FontSize = 22,
		OffsetX = -10, OffsetY = 0,
		Font = "P22UndergroundSCMedium",
		OutlineThickness = 0,
		OutlineColor = {0,0,0,0.5},
		ShadowBlur = 0, ShadowColor = {0,0,0,0.7}, ShadowOffset={0, 2},
		Justification = "Center",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	MouseOverScaleTarget = 1.05,
	MouseOverScaleDuration = 0.2,

	WeaponAnimationOverrides =
	{
		AxePerfectCriticalAspect = "WeaponAxeIdle_Thanatos",
		LobCloseAttackAspect = "WeaponLobIdle_Medea",
		StaffSelfHitAspect = "WeaponStaffIdle_Momus",
		AxeRallyAspect = "WeaponAxeIdle_Nergal",
		LobGunAspect = "WeaponLobIdle_Hel",
		TorchAutofireAspect = "WeaponTorchIdle_Aspect",
		TorchDetonateAspect = "WeaponTorchIdle_Aspect",
		TorchSprintRecallAspect = "WeaponTorchIdle_Aspect",
		LobImpulseAspect = "WeaponLobIdle_Persephone",
	},

	ItemCategories =
	{
		{
			Name = "BountyBoard_Packages",
			GameStateRequirements =
			{
				{
				},
			},

			-- Random Difficulty
			"PackageBountyRandomSurface_Difficulty2",
			"PackageBountyRandomSurface_Difficulty1",
			"PackageBountyRandomUnderworld_Difficulty2",
			"PackageBountyRandomUnderworld_Difficulty1",

			-- Intro Bounties
			"PackageBountyChaosIntro",
			"PackageBountyOceanus",
			"PackageBountyStarter",

			-- 1 Difficulty
			"PackageBountyHellChop",
			"PackageBountyRevenge",
			"PackageBountyZeus",

			-- 2 Difficulty
			"PackageBountySpellCast",
			"PackageBountyHealer",
			"PackageBountyHestia",
			"PackageBountyGold",
			"PackageBountyDemeter",
			"PackageBountyAres",

			-- 3 Difficulty
			"PackageBountyLowMana",
			"PackageBountyHazard",
			"PackageBountyAphrodite",
			"PackageBountyHera",
			"PackageBountyHecate",
			"PackageBountyPolyphemus",
			"PackageBountyStaffLegendary",
			"PackageBountyDaggerLegendary",
			"PackageBountyTorchLegendary",
			"PackageBountyAxeLegendary",
			"PackageBountyLobLegendary",
			"PackageBountySuitLegendary",

			-- 4 Difficulty
			"PackageBountySpeed",
			"PackageBountyCriticalHealth",
			"PackageBountyScylla",
			"PackageBountyStrife",

			-- 5 Difficulty
			"PackageBountyOneTouch",
			"PackageBountyChaos",
		},
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"ShopBackgroundDim",
			"ActionBarBackground",
			"ShopBackgroundSplatter",
			"ShopBackground",

			"LocationIconBacking",
			"LocationIcon",
			"WeaponIconBacking",
			"WeaponIcon",
			"KeepsakeIconBacking",
			"KeepsakeIcon",
		},

		ShopBackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 10.0,
			Color = { 0.090, 0.055, 0.157, 0.8 },
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		ShopBackgroundSplatter =
		{
			Graphic = "LevelUpBackground",
		},

		ShopBackground = 
		{
			AnimationName = "ChaosTrialIn",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				ScrollUp = 
				{
					Graphic = "ButtonBountyUp",
					OffsetX = -615,
					OffsetY = -315,
					Alpha = 0,
					InteractProperties =
					{
						FreeFormSelectable = true,
					},
					Data =
					{
						OnPressedFunctionName = "BountyScreenScrollUp",
						ControlHotkeys = { "MenuUp", },
					}
				},

				ScrollDown = 
				{
					Graphic = "ButtonBountyDown",
					OffsetX = -615,
					OffsetY = 285,
					Alpha = 0,
					InteractProperties =
					{
						FreeFormSelectable = true,
					},
					Data =
					{
						OnPressedFunctionName = "BountyScreenScrollDown",
						ControlHotkeys = { "MenuDown", },
					}
				},

				ClearMessage =
				{
					Text = "BountyBoard_ClearMessage_NonRepeatable",
					OffsetX = 165,
					OffsetY = 248,
					Alpha = 0.0,
					TextArgs =
					{
						Color = Color.UpgradeGreen,
						Width = 700,
						Height = 800,
						FontSize = 22,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
						VariableAutoFormat = "BoldFormatGraft",
						Justification = "Center",
						DataProperties =
						{
							OpacityWithOwner = true,
						},
					},
				},

			},
		},

		SelectionMarker =
		{
			AnimationName = "ChaosTrialMouseHighlightIn",
			Alpha = 0.0,
			--Scale = 0.7,
			ButtonOffsetX = 0,
			ButtonOffsetY = 0,
		},

		ItemTitleText =
		{
			X = 1132,
			Y = 152,
			Alpha = 0.0,
			Text = "PackageBountyDefault",
			TextArgs =
			{
				FontSize = 28,
				Color = Color.White,
				TextSymbolScale = 0.8,
				Font = "P22UndergroundSCHeavy",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		DescriptionText =
		{
			X = 1135,
			Y = 295,
			Alpha = 0.0,
			Text = "PackageBountyDefault",
			TextArgs =
			{
				UseDescription = true,
				Font = "LatoItalic",
				FontSize = 21,
				Width = 820,
				Color = { 140, 140, 140, 255 },
				TextSymbolScale = 0.85,
				Justification = "Center",
				LineSpacingBottom = 10,
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		LocationIconBacking =
		{
			X = 1132 - 340,
			Y = 565,
			Alpha = 0.0,
			AnimationName = "ChaosTrialDetailCardLoop",
		},
		LocationIcon =
		{
			X = 1132 - 340,
			Y = 540,
			Alpha = 0.0,
			Scale = 0.6,
			TextArgs =
			{
				OffsetY = 120,
				FontSize = 21,
				Width = 277,
				LineSpacingBottom = -15,
				Color = Color.White,
				TextSymbolScale = 0.8,
				Font = "P22UndergroundSCHeavy",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},
		LocationIconOverlay =
		{
			X = 1132 - 340,
			Y = 565,
			Alpha = 1.0,
			GroupName = "Combat_Menu_Overlay",
		},

		WeaponIconBacking =
		{
			X = 1132,
			Y = 565,
			Alpha = 0.0,
			AnimationName = "ChaosTrialDetailCardLoop",
			TextArgs =
			{
				OffsetY = 95,
				FontSize = 21,
				Width = 277,
				LineSpacingBottom = -15,
				Color = Color.White,
				TextSymbolScale = 0.8,
				Font = "P22UndergroundSCHeavy",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},
		WeaponIcon =
		{
			X = 1132,
			Y = 540,
			Alpha = 0.0,
		},
		WeaponIconOverlay =
		{
			X = 1132,
			Y = 565,
			Alpha = 1.0,
			GroupName = "Combat_Menu_Overlay",
		},

		KeepsakeIconBacking =
		{
			X = 1132 + 340,
			Y = 565,
			Alpha = 0.0,
			AnimationName = "ChaosTrialDetailCardLoop",
		},
		KeepsakeIcon =
		{
			X = 1132 + 340,
			Y = 540,
			Alpha = 0.0,
			Scale = 0.7,
			TextArgs =
			{
				OffsetY = 120,
				FontSize = 21,
				Width = 280,
				LangWidth = 
				{
					{ Code = "it", Value = 260 },
					{ Code = "de", Value = 290 },
				},
				LineSpacingBottom = -15,
				Color = Color.White,
				TextSymbolScale = 0.8,
				Font = "P22UndergroundSCHeavy",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},
		KeepsakeIconOverlay =
		{
			X = 1132 + 340,
			Y = 565,
			Alpha = 1.0,
			GroupName = "Combat_Menu_Overlay",
		},

		IntensityEye1 =
		{
			X = 1747,
			Y = 206,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AnimationName = "ChaosTrialIntensityEyeBall01Close",
			ActiveAnimationName = "ChaosTrialIntensityEyeBall01Open",
		},

		IntensityEye2 =
		{
			X = 1742,
			Y = 319,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AnimationName = "ChaosTrialIntensityEyeBall02Close",
			ActiveAnimationName = "ChaosTrialIntensityEyeBall02Open",
		},
		IntensityEye2Flame =
		{
			X = 1742,
			Y = 290,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AnimationName = "ChaosTrialIntensityFlame01",
			GroupName = "Combat_Menu_Overlay_Additive",
		},

		IntensityEye3 =
		{
			X = 1750,
			Y = 457,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AnimationName = "ChaosTrialIntensityEyeBall03Close",
			ActiveAnimationName = "ChaosTrialIntensityEyeBall03Open",
		},
		IntensityEye3Flame =
		{
			X = 1750,
			Y = 412,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AnimationName = "ChaosTrialIntensityFlame02",
			GroupName = "Combat_Menu_Overlay_Additive",
		},

		IntensityEye4 =
		{
			X = 1733,
			Y = 575,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AnimationName = "ChaosTrialIntensityEyeBall04Close",
			ActiveAnimationName = "ChaosTrialIntensityEyeBall04Open",
		},
		IntensityEye4Flame =
		{
			X = 1733,
			Y = 530,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AnimationName = "ChaosTrialIntensityFlame03",
			GroupName = "Combat_Menu_Overlay_Additive",
		},

		IntensityEye5 =
		{
			X = 1756,
			Y = 681,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AnimationName = "ChaosTrialIntensityEyeBall05Close",
			ActiveAnimationName = "ChaosTrialIntensityEyeBall05Open",
		},
		IntensityEye5Flame =
		{
			X = 1756,
			Y = 630,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AnimationName = "ChaosTrialIntensityFlame04",
			GroupName = "Combat_Menu_Overlay_Additive",
		},

		RewardText =
		{
			Text = "BountyBoard_Reward",
			CompletedText = "BountyBoard_RewardEarned",
			X = 1133,
			Y = 865,
			Alpha = 0.0,
			TextArgs =
			{
				FontSize = 26,
				TextSymbolScale = 0.8,
				LuaKey = "TempTextData",
				LuaValue = { Icon = "Dev\blank_invisible", Amount = 0 },
				Color = {245, 200, 47, 255},
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
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
				"InfoButton",
				"SelectButton",
			},

			Children = 
			{
				InfoButton = 
				{
					Graphic = "ContextualActionButton",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "GenericInfoPresentation",
						ControlHotkeys = { "MenuInfo", },
					},
					Text = "Menu_Info",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				SelectButton =
				{
					Graphic = "ContextualActionButton",
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "BountyBoard_StartChallenge",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				CloseButton = 
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseBountyBoardScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}

GlobalVoiceLines.StartPackagedBountyRunVoiceLines =
{
	GameStateRequirements =
	{
		{
			PathTrue = { "CurrentRun", "ActiveBounty" },
		},
		{
			Path = { "CurrentRun", "RunDepthCache" },
			Comparison = "<=",
			Value = 1
		},
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
		{ Name = "MelRunStartSpeech", Time = 12 },
	},
	{
		-- BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.66,
		SuccessiveChanceToPlayAll = 0.5,
		ThreadName = "RoomThread",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "F", "N" },
			},
		},

		{ Cue = "/VO/Melinoe_2630", Text = "The Pitch-Black Stone transported me...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2631", Text = "Already come this far..." },
		{ Cue = "/VO/MelinoeField_2108", Text = "Here already..." },
		{ Cue = "/VO/MelinoeField_2109", Text = "Skipped me ahead..." },
		{ Cue = "/VO/Melinoe_5503", Text = "...That's convenient." },
		{ Cue = "/VO/Melinoe_5504", Text = "...A bit disorienting..." },
	},
	{
		-- BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.66,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.25,
		ThreadName = "RoomThread",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBounty" },
				IsNone = { "PackageBountyChaosIntro" },
			},
		},

		{ Cue = "/VO/Melinoe_1427", Text = "My loadout's changed." },
		{ Cue = "/VO/Melinoe_1428", Text = "Feels different somehow.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2103", Text = "What happened to me..." },
		{ Cue = "/VO/MelinoeField_2104", Text = "Chaos..." },
		{ Cue = "/VO/MelinoeField_2105", Text = "Something's happened..." },
		{ Cue = "/VO/MelinoeField_2106", Text = "I feel... {#Emph}ungh..." },
		{ Cue = "/VO/MelinoeField_2107", Text = "Only temporary..." },
		{ Cue = "/VO/Melinoe_5505", Text = "...So strange..." },
		{ Cue = "/VO/Melinoe_5506", Text = "...All this power..." },
		{ Cue = "/VO/Melinoe_5507", Text = "...What do I have...?" },
		{ Cue = "/VO/Melinoe_5508", Text = "...I feel... strange." },
	},
	{
		PreLineWait = 0.66,
		SuccessiveChanceToPlayAll = 0.2,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBounty" },
				IsAny = { "PackageBountyChaosIntro" },
			},
		},

		{ Cue = "/VO/MelinoeField_2044", Text = "I feel... unstoppable..." },
	},
	-- 4+ losses
	{
		NoTarget = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.942,
		ThreadName = "RoomThread",
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBountyAttempts" },
				Comparison = ">=",
				ValuePath = { "CurrentRun", "ActiveBountyClears" },
				ValuePathAddition = 5,
			},
		},
		{ Cue = "/VO/Chaos_0248", Text = "Perhaps you should cease attempting this Trial for now." },
		{ Cue = "/VO/Chaos_0249", Text = "Perhaps if your weapon was stronger? Or perhaps not.", PlayFirst = true },
		{ Cue = "/VO/Chaos_0250", Text = "I have eternity for these attempts; do you?" },
		{ Cue = "/VO/Chaos_0251", Text = "Only continue with this Trial if that is your wish." },
	},
	-- 2 - 3 losses
	{
		NoTarget = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.942,
		ThreadName = "RoomThread",
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBountyAttempts" },
				Comparison = ">=",
				ValuePath = { "CurrentRun", "ActiveBountyClears" },
				ValuePathAddition = 3,
			},
		},
		{ Cue = "/VO/Chaos_0237", Text = "Repeated failure is acceptable to me, for it is amusing." },
		{ Cue = "/VO/Chaos_0239", Text = "Your prior failure in this Trial was quite interesting to observe." },
		{ Cue = "/VO/Chaos_0242", Text = "This Trial has been difficult, and yet you reattempt." },
		{ Cue = "/VO/Chaos_0243", Text = "I think this Trial may be far too difficult for you." },
		{ Cue = "/VO/Chaos_0244", Text = "Try all you like; your repeat attempts are interesting." },
		{ Cue = "/VO/Chaos_0247", Text = "We have been through this before, and shall do it again." },
	},
	-- 1 - 2 loss
	{
		NoTarget = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.942,
		ThreadName = "RoomThread",
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBountyAttempts" },
				Comparison = ">=",
				ValuePath = { "CurrentRun", "ActiveBountyClears" },
				ValuePathAddition = 2,
			},
		},
		{ Cue = "/VO/Chaos_0233", Text = "Repetition sometimes is required for success." },
		{ Cue = "/VO/Chaos_0236", Text = "I am curious to see if you shall fail this Trial once again." },
		{ Cue = "/VO/Chaos_0238", Text = "Shall this Trial prove too much for you again?" },
		{ Cue = "/VO/Chaos_0232", Text = "You are the variable in this Trial, Spawn of Hades." },
		{ Cue = "/VO/Chaos_0234", Text = "A Trial may require multiple attempts.", PlayFirst = true },
		{ Cue = "/VO/Chaos_0235", Text = "I have affected this night much like you experienced before." },
		{ Cue = "/VO/Chaos_0240", Text = "Perhaps you have a better sense of what to expect this time." },
		{ Cue = "/VO/Chaos_0241", Text = "I appreciate your willingness to reattempt this Trial." },
		{ Cue = "/VO/Chaos_0245", Text = "This is a Trial that you know; yet the outcome may change." },
		{ Cue = "/VO/Chaos_0246", Text = "I shall be interested to see what you do differently this time." },
	},
	-- initial attempts & general
	{
		NoTarget = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.66,
		PreLineWait = 0.876,
		ThreadName = "RoomThread",
		Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },

		{ Cue = "/VO/Chaos_0217", Text = "Our Trial thus begins, O Spawn of Hades.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyChaosIntro" },
				},
			},
		},

		{ Cue = "/VO/Chaos_0262", Text = "Vengeance is an impulse I would better understand.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRevenge" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0265", Text = "Gold flows freely throughout my domain; claim it.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyGold" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0268", Text = "Let us see the so-called Earth-Shaker live up to his title.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyOceanus" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0277", Text = "This is a Trial of strength, so please use it with care.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHellChop" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0271", Text = "The god of the forge knows something of creation himself.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHellChop" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0275", Text = "This is a Trial of destruction, so please see what you can do.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHazard" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0269", Text = "I have no wish to see the god of light, only his strength.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHazard" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0270", Text = "The cold brought on by the goddess of seasons, I know well.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyOneTouch" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0272", Text = "The goddess of love is well accustomed to being observed.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyAphrodite" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0273", Text = "The goddess of the hearth, and the potential of her flames...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHestia" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0276", Text = "This is a Trial of haste, so please do not hesitate.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountySpeed" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0224", Text = "You lack the power you accumulated; but not the knowledge.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyStarter" },
				},
				--[[
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "F", "N" },
				},
				]]--
			},
		},
		{ Cue = "/VO/Chaos_0225", Text = "I can take away your strength, but not your experience.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyStarter" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0264", Text = "You have a strong connection to the Moon; show it to me.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountySpellCast" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0267", Text = "The Queen of Olympus understands the bonds we share.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHera" },
				},
			},
		},
		--[[
		{ Cue = "/VO/Chaos_0278", Text = "I believe your magick shall be of little use in this Trial.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyLowMana" },
				},
			},
		},
		]]--
		{ Cue = "/VO/Chaos_0263", Text = "Do the Fates determine what transpires, or do you?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyCriticalHealth" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0266", Text = "The King of Olympus commands thunder, but I created it.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyZeus" },
				},
			},
		},

		{ Cue = "/VO/Chaos_0219", Text = "You have arrived here rather quickly, Spawn of Hades.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "F", "N" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0220", Text = "Let us begin our current Trial from this point.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "F", "N" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0221", Text = "Commence this Trial from this point, beginning now.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "F", "N" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0222", Text = "I have an interest in evaluating this domain.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "F", "N" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0223", Text = "You may proceed immediately, Spawn of Hades.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "F", "N" },
				},
			},
		},

		{ Cue = "/VO/Chaos_0226", Text = "This Trial shall attempt to break you, Spawn of Hades.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny =
					{
						"PackageBountyCriticalHealth",
						"PackageBountyOneTouch",
					},
				},
			},
		},
		{ Cue = "/VO/Chaos_0227", Text = "It is possible that this Trial is impossible, Spawn of Hades.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny =
					{
						"PackageBountyCriticalHealth",
						"PackageBountyOneTouch",
					},
				},
			},
		},
		{ Cue = "/VO/Chaos_0228", Text = "I do not think you shall complete this Trial, though please try.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny =
					{
						"PackageBountyCriticalHealth",
						"PackageBountyOneTouch",
					},
				},
			},
		},
		{ Cue = "/VO/Chaos_0229", Text = "The Fates themselves determine the details of this Trial.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny =
					{
						"PackageBountyRandomUnderworld_Difficulty1",
						"PackageBountyRandomUnderworld_Difficulty2",
						"PackageBountyRandomSurface_Difficulty1",
						"PackageBountyRandomSurface_Difficulty2",
					},
				},
			},
		},
		{ Cue = "/VO/Chaos_0230", Text = "I cede control of the details of this Trial to the Fates.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny =
					{
						"PackageBountyRandomUnderworld_Difficulty1",
						"PackageBountyRandomUnderworld_Difficulty2",
						"PackageBountyRandomSurface_Difficulty1",
						"PackageBountyRandomSurface_Difficulty2",
					},
				},
			},
		},
		{ Cue = "/VO/Chaos_0231", Text = "In choosing this Trial, all other choices shall be made for you.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny =
					{
						"PackageBountyRandomUnderworld_Difficulty1",
						"PackageBountyRandomUnderworld_Difficulty2",
						"PackageBountyRandomSurface_Difficulty1",
						"PackageBountyRandomSurface_Difficulty2",
					},
				},
			},
		},
		{ Cue = "/VO/Chaos_0298", Text = "The King of the Olympians relies upon his storms for shelter.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyZeus" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0299", Text = "Not much would survive if the goddess of seasons so chose.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyDemeter" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0300", Text = "Heed now the summons of the Queen of Olympus.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHera" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0301", Text = "The influence of Strife spreads rapidly, but can be slowed.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyStrife" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0302", Text = "One of your relatives devotes himself to war; this is for him.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyAres" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0274", Text = "This Trial shall compare you to the caretaker of your domain.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyHecate" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0304", Text = "I leave the details of this Trial for you to discover.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld_Difficulty1", "PackageBountyRandomUnderworld_Difficulty2", "PackageBountyRandomSurface_Difficulty1", "PackageBountyRandomSurface_Difficulty2" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0306", Text = "Whether this Trial goes as we expect, let us find out.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld_Difficulty1", "PackageBountyRandomUnderworld_Difficulty2", "PackageBountyRandomSurface_Difficulty1", "PackageBountyRandomSurface_Difficulty2" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0311", Text = "I chose each detail of this Trial arbitrarily.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld_Difficulty1", "PackageBountyRandomUnderworld_Difficulty2", "PackageBountyRandomSurface_Difficulty1", "PackageBountyRandomSurface_Difficulty2" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0312", Text = "There is no particular order to this Trial.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld_Difficulty1", "PackageBountyRandomUnderworld_Difficulty2", "PackageBountyRandomSurface_Difficulty1", "PackageBountyRandomSurface_Difficulty2" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0313", Text = "This shall not go the way it did last time.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld_Difficulty1", "PackageBountyRandomUnderworld_Difficulty2", "PackageBountyRandomSurface_Difficulty1", "PackageBountyRandomSurface_Difficulty2" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0314", Text = "You may attempt to find a pattern, but shall not.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld_Difficulty1", "PackageBountyRandomUnderworld_Difficulty2", "PackageBountyRandomSurface_Difficulty1", "PackageBountyRandomSurface_Difficulty2" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0315", Text = "This Trial has no constancy at all.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld_Difficulty1", "PackageBountyRandomUnderworld_Difficulty2", "PackageBountyRandomSurface_Difficulty1", "PackageBountyRandomSurface_Difficulty2" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0316", Text = "I have yet to consider all the possibilities herein.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld_Difficulty1", "PackageBountyRandomUnderworld_Difficulty2", "PackageBountyRandomSurface_Difficulty1", "PackageBountyRandomSurface_Difficulty2" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0306", Text = "Whether this Trial goes as we expect, let us find out.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld_Difficulty1", "PackageBountyRandomUnderworld_Difficulty2", "PackageBountyRandomSurface_Difficulty1", "PackageBountyRandomSurface_Difficulty2" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0305", Text = "I caution that this Trial likely is impossible for you.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyOneTouch", "PackageBountyChaos" },
				},
				{
					Path = { "GameState", "PackagedBountyClears" },
					HasNone = { "PackageBountyOneTouch", "PackageBountyChaos" }
				},
			},
		},
		{ Cue = "/VO/Chaos_0307", Text = "You are by now familiar with these depths.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasAny = { "G", "H", "I" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0308", Text = "The lowest reaches of your father's realm.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasAny = { "I" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0310", Text = "How quickly you have reached this mountain's summit...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasAny = { "Q" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0309", Text = "The summit of Olympus, beyond Time...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					Path = { "CurrentRun", "BiomesReached" },
					HasAny = { "Q" },
				},
			},
		},
		{ Cue = "/VO/Chaos_0105", Text = "This shall be interesting..." },
		{ Cue = "/VO/Chaos_0106", Text = "I have made some adjustments to reality..." },
		{ Cue = "/VO/Chaos_0107", Text = "Minor changes may have profound effects..." },
		{ Cue = "/VO/Chaos_0108", Text = "Some alterations to the fabric of reality..." },
		{ Cue = "/VO/Chaos_0109", Text = "Is all this in accordance with the Fates' design?" },
		{ Cue = "/VO/Chaos_0110", Text = "Of infinite possibilities, this was your choice." },
		{ Cue = "/VO/Chaos_0111", Text = "From my infinite depths rises an opportunity." },
		{ Cue = "/VO/Chaos_0112", Text = "I do appreciate your willingness..." },
		{ Cue = "/VO/Chaos_0113", Text = "So many minor details to adjust..." },
		{ Cue = "/VO/Chaos_0114", Text = "Another possibility to be explored..." },
		{ Cue = "/VO/Chaos_0218", Text = "All that you see is my domain, and I am everywhere." },
	},

}