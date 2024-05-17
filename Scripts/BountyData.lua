BountyData =
{
	-- Package Bounties
	DefaultPackagedBounty =
	{
		DebugOnly = true,
		Category = "PackagedBounty",
		RequireActiveForRun = true,
		EndRunOnCompletion = true,
		Repeatable = false,
		IsPackagedBounty = true,
		LootDelay = 2.0,
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
		ForcedReward = "Mixer5CommonDrop",
	},
	
	BountyPackageTest =
	{
		DebugOnly = true,
		InheritFrom = { "DefaultPackagedBounty" },
		Encounter = "BossHecate01",
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
		CompleteGameStateRequirements =
		{
			-- None
		},
	},

	-- Base bounties
	BasePackageBountyBiomeF =
	{
		DebugOnly = true,
		Encounter = "BossHecate01",
		StartingBiome = "F",
	},
	BasePackageBountyBiomeG =
	{
		DebugOnly = true,
		Encounter = "BossScylla01",
		StartingBiome = "G",
		RunOverrides =
		{
			DeepInheritance = true,
			BiomesReached = { F = true, },
		},
	},
	BasePackageBountyBiomeH =
	{
		DebugOnly = true,
		Encounter = "BossInfestedCerberus01",
		StartingBiome = "H",
		RunOverrides =
		{
			DeepInheritance = true,
			BiomesReached = { F = true, G = true, },
		},
	},
	BasePackageBountyBiomeI =
	{
		DebugOnly = true,
		Encounter = "BossChronos01",
		StartingBiome = "I",
		RunOverrides =
		{
			DeepInheritance = true,
			BiomesReached = { F = true, G = true, H = true },
		},
	},
	BasePackageBountyBiomeN =
	{
		DebugOnly = true,
		Encounter = "BossPolyphemus01",
		StartingBiome = "N",
	},
	BasePackageBountyBiomeO =
	{
		DebugOnly = true,
		Encounter = "BossEris01",
		StartingBiome = "O",
		RunOverrides =
		{
			DeepInheritance = true,
			BiomesReached = { N = true, },
		},
	},
	--[[
	BasePackageBountyBiomeP =
	{
		DebugOnly = true,
		Encounter = "Boss",
		StartingBiome = "P",
	},
	BasePackageBountyBiomeQ =
	{
		DebugOnly = true,
		Encounter = "Boss",
		StartingBiome = "Q",
	},
	]]


	-- Starter bounties
	PackageBountyChaosIntro =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },

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

		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyOceanus =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },

		DifficultyRating = 2,

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
			},
		},
		]]

		StartingTraits =
		{
			{ Name = "PoseidonWeaponBoon", Rarity = "Epic", },
			{ Name = "PoseidonSprintBoon", Rarity = "Epic", },
			{ Name = "PoseidonManaBoon", Rarity = "Epic", },
			{ Name = "EncounterStartOffenseBuffBoon", Rarity = "Epic", },
			{ Name = "SlamExplosionBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		RunOverrides =
		{
			MaxGodsPerRun = 1,
			LootTypeHistory =
			{
				PoseidonUpgrade = 5,
			},
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
		},

		UnlockGameStateRequirements =
		{
			NamedRequirements = { "PackageBountyBiomeG", },
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", },
			},
		},

		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyStarter =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },

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
		CompleteGameStateRequirements =
		{
			-- None
		},
	},

	-- Intermediate bounties
	--[[
	PackageBountyNightmare =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },

		DifficultyRating = 1,

		ForcedRewards =
		{
			{
				Name = "SpellDrop",
				-- force transform
			},
		},

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerBackstabAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		MetaUpgradeStateEquipped =
		{
		},

		UnlockGameStateRequirements =
		{
			NamedRequirements = { "PackageBountyBiomeF", },
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", },
			},
		},

		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountySouls =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },

		DifficultyRating = 1,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HermesUpgrade",
			},
		},

		WeaponKitName = "WeaponTorch",
		WeaponUpgradeName = "TorchSpecialDurationAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		MetaUpgradeStateEquipped =
		{
		},

		UnlockGameStateRequirements =
		{
			NamedRequirements = { "PackageBountyBiomeF", },
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponTorch", },
			},
		},

		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyEphyra =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },

		DifficultyRating = 1,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HestiaUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "HestiaWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "HestiaSpecialBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "HestiaCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},

		WeaponKitName = "WeaponLob",
		WeaponUpgradeName = "LobAmmoBoostAspect",
		--KeepsakeName = "None",
		RemoveFamiliar = true,

		MetaUpgradeStateEquipped =
		{
		},

		UnlockGameStateRequirements =
		{
			NamedRequirements = { "PackageBountyBiomeN", },
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponLob", },
			},
		},

		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]

	-- Character bounties
	--[[
	PackageBountyHecateMirror =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },

		DifficultyRating = 3,

		WeaponKitName = "WeaponTorch",
		WeaponUpgradeName = "TorchSpecialDurationAspect",
		KeepsakeName = "ManaOverTimeRefundKeepsake",
		FamiliarName = "CatFamiliar",

		ForcedRewards =
		{
			{
				Name = "SpellDrop",
			},
		},

		MetaUpgradeStateEquipped =
		{
		},

		ShrineUpgradesActive =
		{
			--BossDifficultyShrineUpgrade = 1,
		},	

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeF", }, --"ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
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
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "SeleneFirstPickUp", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	--[[
	PackageBountyControlFate =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeI", },

		DifficultyRating = 4,

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerBackstabAspect",
		KeepsakeName = "BossPreDamageKeepsake",
		FamiliarName = "CatFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ZeusUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]--[[

		StartingTraits =
		{
			{ Name = "PoseidonWeaponBoon", Rarity = "Epic", },
			{ Name = "ZeusSpecialBoon", Rarity = "Epic", },
			{ Name = "PoseidonManaBoon", Rarity = "Epic", },
			{ Name = "SlamExplosionBoon", Rarity = "Epic", },
			{ Name = "PoseidonStatusBoon", Rarity = "Epic", },
			{ Name = "DoubleBoltBoon", Rarity = "Epic", },
			{ Name = "FocusLightningBoon", Rarity = "Epic", },
			{ Name = "DaggerSpecialJumpTrait", },

			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
			"DoorReroll",
			"TradeOff",
			"ScreenReroll",
		},

		ShrineUpgradesActive =
		{
			BanUnpickedBoonsShrineUpgrade = 1,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeI", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "BossPreDamageKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ZeusFirstPickUp", },
			},
			]]

			-- MetaUpgrades
			--[[
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 7,
			},
			]]--[[
			{
				PathTrue = { "GameState", "MetaUpgradeState", "DoorReroll", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "TradeOff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	--[[
	PackageBountySoulHarvest =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeH", },

		DifficultyRating = 3,

		WeaponKitName = "WeaponAxe",
		WeaponUpgradeName = "AxePerfectCriticalAspect",
		KeepsakeName = "DoorHealReserveKeepsake",
		FamiliarName = "FrogFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HermesUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]--[[

		StartingTraits =
		{
			{ Name = "ApolloWeaponBoon", Rarity = "Epic", },
			{ Name = "ApolloCastBoon", Rarity = "Epic", },
			{ Name = "ApolloCastAreaBoon", Rarity = "Epic", },
			{ Name = "AphroditeManaBoon", Rarity = "Epic", },
			{ Name = "WeakVulnerabilityBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
		},

		ShrineUpgradesActive =
		{
			EnemyRespawnShrineUpgrade = 3,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeH", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponAxe", "AxePerfectCriticalAspect" },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "DoorHealReserveKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "HermesFirstPickUp", },
			},
			]]--[[
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	--[[
	PackageBountySchelemeus =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeO", },

		DifficultyRating = 2,

		WeaponKitName = "WeaponStaffSwing",
		WeaponUpgradeName = "StaffSelfHitAspect",
		KeepsakeName = "ReincarnationKeepsake",
		FamiliarName = "CatFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]--[[

		StartingTraits =
		{
			{ Name = "PoseidonSpecialBoon", Rarity = "Epic", },
			{ Name = "PoseidonCastBoon", Rarity = "Epic", },
			{ Name = "SlamExplosionBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
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
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", "StaffSelfHitAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ReincarnationKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "HermesFirstPickUp", },
			},
			--]]--[[
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	PackageBountyRevenge =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },

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
				HeraUpgrade = 1,
				ApolloUpgrade = 1,
				ZeusUpgrade = 1,
				AphroditeUpgrade = 1,
				PoseidonUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "DamageShareRetaliateBoon", Rarity = "Heroic", },
			{ Name = "ApolloRetaliateBoon", Rarity = "Heroic", },
			{ Name = "BoltRetaliateBoon", Rarity = "Heroic", },
			{ Name = "DoorHealToFullBoon", Rarity = "Heroic", },
			{ Name = "FocusDamageShaveBoon", Rarity = "Heroic", },
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
			"BonusHealth",
			"HealthRegen",
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
				Path = { "GameState", "BountiesCompleted" },
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
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			--[[ FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt", },
			},
			]]

			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyOneTouch =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },

		DifficultyRating = 5,

		WeaponKitName = "WeaponAxe",
		WeaponUpgradeName = "AxePerfectCriticalAspect",
		KeepsakeName = "BlockDeathKeepsake",
		FamiliarName = "CatFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "DemeterUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "DemeterWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "DemeterSpecialBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "ReserveManaHitShieldBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]

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
						-- unlock requirements
						{
							PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
						},

						-- run requirements				
						RequiredNotInStore = "ShopHermesUpgrade",
						{
							Path = { "CurrentRun", "BiomeUseRecord", },
							HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
						},
						{
							Path = { "CurrentRun", "EncounterDepth" },
							Comparison = ">=",
							Value = 8,
						},
						{
							Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
							Comparison = "<=",
							Value = 1,
						},

					}
				},
				{
					Name = "SpellDrop",
					GameStateRequirements =
					{
						-- unlock requirements
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "ArtemisFirstMeeting", "SeleneFirstPickUp" },
						},

						-- run requirements
						RequiredNotInStore = "SpellDrop",
						RequiredFalseRewardType = "SpellDrop",
						{
							PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
						},
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
			"ChanneledBlock",
		},

		ShrineUpgradesActive =
		{
			FirstDamageShrineUpgrade = 2,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeG", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
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
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			--[[ FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "DemeterFirstPickUp", },
			},
			]]
			-- Meta Upgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	--[[
	PackageBountyStrife =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeO", },

		DifficultyRating = 3,

		WeaponKitName = "WeaponLob",
		WeaponUpgradeName = "LobCloseAttackAspect",
		KeepsakeName = "EscalatingKeepsake",
		FamiliarName = "FrogFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "AphroditeUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]--[[

		StartingTraits =
		{
			{ Name = "AphroditeWeaponBoon", Rarity = "Epic", },
			{ Name = "AphroditeSpecialBoon", Rarity = "Epic", },
			{ Name = "AphroditeCastBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
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
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponLob", "LobCloseAttackAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "EscalatingKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AphroditeFirstPickUp", },
			},
			]]--[[
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	PackageBountySpellCast =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },

		DifficultyRating = 2,

		WeaponKitName = "WeaponAxe",
		WeaponUpgradeName = "AxeArmCastAspect",
		KeepsakeName = "SpellTalentKeepsake",
		FamiliarName = "FrogFamiliar",

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
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
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
						-- unlock requirements
						{
							PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
						},

						-- run requirements				
						RequiredNotInStore = "ShopHermesUpgrade",
						{
							Path = { "CurrentRun", "BiomeUseRecord", },
							HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
						},
						{
							Path = { "CurrentRun", "EncounterDepth" },
							Comparison = ">=",
							Value = 8,
						},
						{
							Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
							Comparison = "<=",
							Value = 1,
						},

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
			"MagicCrit",
			"SorceryRegenUpgrade",
			"CastCount",
			"ManaOverTime",
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
				Path = { "GameState", "BountiesCompleted" },
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
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			--[[ FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "SeleneFirstPickUp", },
			},
			]]

			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyGold =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },

		DifficultyRating = 2,

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerHomingThrowAspect",
		KeepsakeName = "BonusMoneyKeepsake",
		FamiliarName = "CatFamiliar",

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
						ItemName = "MinorLootBoon",
						Rarity = "Heroic",
					},
					{
						Type = "Trait",
						ItemName = "MoneyDamageBoon",
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
				PoseidonUpgrade = 4,
				HeraUpgrade = 3,
				HermesUpgrade = 1,
			},
		},

		StartingTraits =
		{
			{ Name = "HeraWeaponBoon", Rarity = "Epic", },
			{ Name = "PoseidonSpecialBoon", Rarity = "Epic", },
			{ Name = "HeraCastBoon", Rarity = "Epic", },
			{ Name = "HeraSprintBoon", Rarity = "Epic", },
			{ Name = "PoseidonManaBoon", Rarity = "Epic", },
			{ Name = "MoneyMultiplierBoon", },
			{ Name = "RoomRewardBonusBoon", Rarity = "Heroic", },
			{ Name = "DoubleRewardBoon", Rarity = "Heroic", },
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
			"StartingGold",
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
				Path = { "GameState", "BountiesCompleted" },
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
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "PoseidonFirstPickUp", },
			},
			]]
			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StartingGold", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyHealer =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },

		DifficultyRating = 2,

		WeaponKitName = "WeaponStaffSwing",
		WeaponUpgradeName = "StaffSelfHitAspect",
		KeepsakeName = "DamagedDamageBoostKeepsake",
		FamiliarName = "FrogFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ApolloUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "ApolloSpecialBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "ApolloManaBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PerfectDamageBonusBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				AphroditeUpgrade = 2,
				HephaestusUpgrade = 2,
				WeaponUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "HephaestusWeaponBoon", Rarity = "Epic", },
			{ Name = "AphroditeSpecialBoon", Rarity = "Heroic", },
			{ Name = "HephaestusCastBoon", Rarity = "Epic", },
			{ Name = "AphroditeSprintBoon", Rarity = "Epic", },
			{ Name = "HephaestusManaBoon", Rarity = "Epic", },
			{ Name = "HighHealthOffenseBoon", Rarity = "Heroic", },
			{ Name = "ArmorBoon", Rarity = "Epic", },
			{ Name = "StaffExHealTrait", },
			{ Name = "StaffPowershotTrait", },
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
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "FirstHitHealBoon" },
						},
					},
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "FirstHitHealBoon" },
						},
					},
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						-- unlock requirements
						{
							PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
						},

						-- run requirements				
						RequiredNotInStore = "ShopHermesUpgrade",
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "FirstHitHealBoon" },
						},
						{
							Path = { "CurrentRun", "BiomeUseRecord", },
							HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
						},
						{
							Path = { "CurrentRun", "EncounterDepth" },
							Comparison = ">=",
							Value = 8,
						},
						{
							Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
							Comparison = "<=",
							Value = 1,
						},

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
			"HealthRegen",
			"LastStand",
			"BonusRarity",
		},

		ShrineUpgradesActive =
		{
			EnemyDamageShrineUpgrade = 5,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeG", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
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
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			--[[ FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", },
			},]]
			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	--[[
	PackageBountyChance =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeQ", },

		DifficultyRating = 1,

		WeaponKitName = "WeaponStaffSwing",
		-- WeaponUpgradeName = "",
		--AspectName = "StaffSelfHitAspect",
		KeepsakeName = "DamagedDamageBoostKeepsake",
		--FamiliarName = "CatFamiliar",
		--RemoveFamiliar = true,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ApolloUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},

		StartingTraits =
		{
			{ Name = "PoseidonWeaponBoon", Rarity = "Epic", },
			{ Name = "PoseidonSprintBoon", Rarity = "Epic", },
			{ Name = "PoseidonManaBoon", Rarity = "Epic", },
			{ Name = "DoubleRewardBoon", Rarity = "Heroic", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"BonusHealth",
			"HealthRegen",
			"CastBuff",
			"LastStand",
			"ManaOverTime",
		},

		ShrineUpgradesActive =
		{
			EnemyDamageShrineUpgrade = 5,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeQ", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				-- Aspect here
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "DamagedDamageBoostKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "PoseidonFirstPickUp", },
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
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	--[[
	PackageBountyZeus =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeP", },

		DifficultyRating = 3,

		WeaponKitName = "WeaponDagger",
		-- WeaponUpgradeName = "",
		--AspectName = "StaffSelfHitAspect",
		KeepsakeName = "ForceZeusBoonKeepsake",
		--FamiliarName = "CatFamiliar",
		--RemoveFamiliar = true,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ZeusUpgrade",
				--[[
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},

		StartingTraits =
		{
			{ Name = "PoseidonWeaponBoon", Rarity = "Epic", },
			{ Name = "PoseidonSprintBoon", Rarity = "Epic", },
			{ Name = "PoseidonManaBoon", Rarity = "Epic", },
			{ Name = "DoubleRewardBoon", Rarity = "Heroic", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"BonusHealth",
			"HealthRegen",
			"CastBuff",
			"LastStand",
			"ManaOverTime",
		},

		ShrineUpgradesActive =
		{
			--EnemyDamageShrineUpgrade = 5,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeP", }, --"ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", },
			},
			{
				-- Aspect here
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForceZeusBoonKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ZeusFirstPickUp", },
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
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	--[[
	PackageBountyHera =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },

		DifficultyRating = 5,

		WeaponKitName = "WeaponTorch",
		WeaponUpgradeName = "TorchSpecialDurationAspect",
		KeepsakeName = "ForceHeraBoonKeepsake",
		FamiliarName = "FrogFamiliar",

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HeraUpgrade",
			},
		},

		MetaUpgradeStateEquipped =
		{
		},

		ShrineUpgradesActive =
		{
			NoMetaUpgradesShrineUpgrade = 1,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeN", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponTorch", "TorchSpecialDurationAspect" },
			},
			{
				-- Aspect here
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForceHeraBoonKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt", },
			},

			-- MetaUpgrades
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	--[[
	PackageBountyPoseidon =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeO", },

		DifficultyRating = 2,

		WeaponKitName = "WeaponLob",
		WeaponUpgradeName = "LobImpulseAspect",
		KeepsakeName = "ForcePoseidonBoonKeepsake",
		FamiliarName = "FrogFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]--[[

		StartingTraits =
		{
			{ Name = "PoseidonWeaponBoon", Rarity = "Epic", },
			{ Name = "PoseidonSpecialBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
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
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponLob", "LobImpulseAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForcePoseidonBoonKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "PoseidonFirstPickUp", },
			},
			]]--[[
			-- MetaUpgrades
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	--[[
	PackageBountyApollo =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },

		DifficultyRating = 1,

		WeaponKitName = "WeaponStaffSwing",
		WeaponUpgradeName = "BaseStaffAspect",
		KeepsakeName = "ForceApolloBoonKeepsake",
		FamiliarName = "FrogFamiliar",

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ApolloUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "ApolloSpecialBoon",
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

		StartingTraits =
		{
			{ Name = "ApolloCastBoon", Rarity = "Epic", },
			{ Name = "ZeusWeaponBoon", Rarity = "Epic", },
			{ Name = "ApolloCastAreaBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
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
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForceApolloBoonKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", },
			},
			-- MetaUpgrades
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	--[[
	PackageBountyDemeter =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeH", },

		DifficultyRating = 3,

		WeaponKitName = "WeaponLob",
		WeaponUpgradeName = "LobImpulseAspect",
		KeepsakeName = "ForceDemeterBoonKeepsake",
		FamiliarName = "CatFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "DemeterUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]--[[

		StartingTraits =
		{
			{ Name = "DemeterWeaponBoon", Rarity = "Epic", },
			{ Name = "ReserveManaHitShieldBoon", Rarity = "Epic", },
			{ Name = "RootDurationBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
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
				Path = { "GameState", "BountiesCompleted" },
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
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "DemeterFirstPickUp", },
			},
			]]--[[
			-- MetaUpgrades
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	PackageBountyAphrodite =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeO", },

		DifficultyRating = 3,

		WeaponKitName = "WeaponTorch",
		WeaponUpgradeName = "TorchSprintRecallAspect",
		KeepsakeName = "ForceAphroditeBoonKeepsake",
		FamiliarName = "FrogFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "AphroditeUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]

		RunOverrides =
		{
			MaxGodsPerRun = 1,
			LootTypeHistory =
			{
				AphroditeUpgrade = 5,
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
					Name = "WeaponUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "HammerLootRequirements" },
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
						-- unlock requirements
						{
							PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
						},

						-- run requirements				
						RequiredNotInStore = "ShopHermesUpgrade",
						{
							Path = { "CurrentRun", "BiomeUseRecord", },
							HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
						},
						{
							Path = { "CurrentRun", "EncounterDepth" },
							Comparison = ">=",
							Value = 8,
						},
						{
							Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
							Comparison = "<=",
							Value = 1,
						},
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
				Path = { "GameState", "BountiesCompleted" },
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
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AphroditeFirstPickUp", },
			},
			]]

			-- MetaUpgrades
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	--[[
	PackageBountyHephaestus =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeP", },

		DifficultyRating = 3,

		WeaponKitName = "WeaponDagger",
		-- WeaponUpgradeName = "",
		--AspectName = "TorchSprintRecallAspect",
		KeepsakeName = "ForceHephaestusBoonKeepsake",
		--FamiliarName = "CatFamiliar",
		--RemoveFamiliar = true,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HephaestusUpgrade",
				--[[
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},

		--[[
		StartingTraits =
		{
			{ Name = "PoseidonWeaponBoon", Rarity = "Epic", },
			{ Name = "PoseidonSprintBoon", Rarity = "Epic", },
			{ Name = "PoseidonManaBoon", Rarity = "Epic", },
			{ Name = "DoubleRewardBoon", Rarity = "Heroic", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"BonusHealth",
			"HealthRegen",
			"CastBuff",
			"LastStand",
			"ManaOverTime",
		},

		ShrineUpgradesActive =
		{
			EnemyHealthShrineUpgrade = 1,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeP", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", },
			},
			{
				-- Aspect here
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ForceHephaestusBoonKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "HephaestusFirstPickUp", },
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
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	PackageBountyHestia =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeH", },

		DifficultyRating = 2,

		WeaponKitName = "WeaponTorch",
		WeaponUpgradeName = "TorchDetonateAspect",
		KeepsakeName = "ForceHestiaBoonKeepsake",
		FamiliarName = "CatFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HestiaUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				PoseidonUpgrade = 3,
				HestiaUpgrade = 6,
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
			{ Name = "BurnConsumeBoon", Rarity = "Heroic", },
			{ Name = "BurnArmorBoon", Rarity = "Heroic", },
			{ Name = "TorchExSpecialCountTrait", },
			{ Name = "TorchSpecialSpeedTrait", },			
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
						-- unlock requirements
						{
							PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
						},

						-- run requirements				
						RequiredNotInStore = "ShopHermesUpgrade",
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SteamBoon" },
						},
						{
							Path = { "CurrentRun", "BiomeUseRecord", },
							HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
						},
						{
							Path = { "CurrentRun", "EncounterDepth" },
							Comparison = ">=",
							Value = 8,
						},
						{
							Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
							Comparison = "<=",
							Value = 1,
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
			"StatusVulnerability",
			"BonusRarity",
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
				Path = { "GameState", "BountiesCompleted" },
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
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "HestiaFirstPickUp", },
			},
			]]
			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked", },
			},

		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountySpeed =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeH", },

		DifficultyRating = 4,

		WeaponKitName = "WeaponStaffSwing",
		WeaponUpgradeName = "BaseStaffAspect",
		KeepsakeName = "TimedBuffKeepsake",
		FamiliarName = "CatFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HermesUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]
		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				HermesUpgrade = 2,
				ApolloUpgrade = 4,
				PoseidonUpgrade = 2,
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
			{ Name = "HermesWeaponBoon", Rarity = "Epic", },
			{ Name = "HermesSpecialBoon", Rarity = "Epic", },
			{ Name = "StaffOneWayAttackTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
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
						-- unlock requirements
						{
							PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
						},
						-- run requirements				
						RequiredNotInStore = "ShopHermesUpgrade",
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						-- unlock requirements
						{
							PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
						},
						-- run requirements				
						RequiredNotInStore = "ShopHermesUpgrade",
					}
				},
				{
					Name = "SpellDrop",
					GameStateRequirements =
					{
						-- unlock requirements
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "ArtemisFirstMeeting", "SeleneFirstPickUp" },
						},

						-- run requirements
						RequiredNotInStore = "SpellDrop",
						RequiredFalseRewardType = "SpellDrop",
						{
							PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
						},
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
			"SprintShield",
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
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "TimedBuffKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "HermesFirstPickUp", },
			},
			]]
			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyCriticalHealth =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeO", },

		DifficultyRating = 4,

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerBlockAspect",
		KeepsakeName = "LowHealthCritKeepsake",
		FamiliarName = "CatFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "TrialUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				AphroditeUpgrade = 4,
				PoseidonUpgrade = 1,
			},
		},
		StartingTraits =
		{
			{ Name = "AphroditeWeaponBoon", Rarity = "Epic", },
			{ Name = "AphroditeManaBoon", Rarity = "Epic", },
			{ Name = "WeakPotencyBoon", Rarity = "Epic", },
			{ Name = "HighHealthCritBoon", Rarity = "Epic", },
			{ Name = "FocusDamageShaveBoon", Rarity = "Heroic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
			"LowHealthBonus",
			"ChanneledBlock",
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
					Name = "MaxHealthDrop",
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
						-- unlock requirements
						{
							PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
						},

						-- run requirements				
						RequiredNotInStore = "ShopHermesUpgrade",
						{
							Path = { "CurrentRun", "BiomeUseRecord", },
							HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
						},
						{
							Path = { "CurrentRun", "EncounterDepth" },
							Comparison = ">=",
							Value = 8,
						},
						{
							Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
							Comparison = "<=",
							Value = 1,
						},

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
				Path = { "GameState", "BountiesCompleted" },
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
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			--[[ FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ChaosFirstPickUp", },
			},
			]]
			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyHellChop =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeF", },

		DifficultyRating = 1,

		WeaponKitName = "WeaponAxe",
		WeaponUpgradeName = "AxeRecoveryAspect",
		KeepsakeName = "DecayingBoostKeepsake",
		FamiliarName = "FrogFamiliar",

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
						ItemName = "ChargeCounterBoon",
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
				WeaponUpgrade = 3,
				ApolloUpgrade = 3,
				HestiaUpgrade = 1,
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
			--{ Name = "ElementalRallyBoon", },
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
		},

		MetaUpgradeStateEquipped =
		{
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
				Path = { "GameState", "BountiesCompleted" },
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
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt", },
			},
			]]
			-- MetaUpgrades
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	--[[
	PackageBountyArmor =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },

		DifficultyRating = 3,

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerBackstabAspect",
		KeepsakeName = "ArmorGainKeepsake",
		FamiliarName = "FrogFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "HephaestusUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]--[[

		StartingTraits =
		{
			{ Name = "ArmorBoon", Rarity = "Epic", },
			{ Name = "HeavyArmorBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledBlock",
		},

		ShrineUpgradesActive =
		{
			HealingReductionShrineUpgrade = 3,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeG", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", "DaggerBackstabAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "ArmorGainKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			-- FirstLoot
			--[[
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "HephaestusUpgrade", },
			},
			]]--[[
			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	--[[
	PackageBountyMusic =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },

		DifficultyRating = 2,

		WeaponKitName = "WeaponDagger",
		WeaponUpgradeName = "DaggerHomingThrowAspect",
		KeepsakeName = "UnpickedBoonKeepsake",
		FamiliarName = "CatFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ApolloUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonWeaponBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonSprintBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "PoseidonCastBoon",
						Rarity = "Epic",
					},
				},
			},
		},
		]]--[[

		StartingTraits =
		{
			{ Name = "ApolloWeaponBoon", Rarity = "Epic", },
			{ Name = "ApolloManaBoon", Rarity = "Epic", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
		},

		ShrineUpgradesActive =
		{
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeG", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponDagger", "DaggerHomingThrowAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "UnpickedBoonKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", },
			},
			-- MetaUpgrades
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	]]
	PackageBountyLowMana =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeG", },

		DifficultyRating = 3,

		WeaponKitName = "WeaponStaffSwing",
		WeaponUpgradeName = "StaffClearCastAspect",
		KeepsakeName = "BossMetaUpgradeKeepsake",
		FamiliarName = "CatFamiliar",

		--[[
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "AphroditeUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "AphroditeManaBoon",
						Rarity = "Common",
					},
					{
						Type = "Trait",
						ItemName = "HighHealthOffenseBoon",
						Rarity = "Epic",
					},
					{
						Type = "Trait",
						ItemName = "ManaBurstBoon",
						Rarity = "Heroic",
					},
				},
			},
		},
		]]

		RunOverrides =
		{
			MaxGodsPerRun = 2,
			LootTypeHistory =
			{
				ApolloUpgrade = 1,
				AphroditeUpgrade = 1,
				WeaponUpgrade = 2,
			},
		},

		StartingTraits =
		{
			{ Name = "ApolloSpecialBoon", Rarity = "Epic", },
			{ Name = "DoubleStrikeChanceBoon", Rarity = "Epic", },
			{ Name = "ManaBurstBoon", Rarity = "Epic", },
			{ Name = "StaffDoubleAttackTrait", },
			{ Name = "StaffSecondStageTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		},

		MetaUpgradeStateEquipped =
		{
			"ChanneledCast",
			"LowManaDamageBonus",
			"ManaOverTime",
			"MagicCrit",
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
							Path = { "CurrentRun", "LootTypeHistory", },
							SumOf = { "ApolloUpgrade", "AphroditeUpgrade", },
							Comparison = ">",
							Value = 2,
						},
					},
				},
				{
					Name = "MaxManaDrop",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "LootTypeHistory", },
							SumOf = { "ApolloUpgrade", "AphroditeUpgrade", },
							Comparison = ">",
							Value = 2,
						},
					},
				},
				{
					Name = "RoomMoneyDrop",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "LootTypeHistory", },
							SumOf = { "ApolloUpgrade", "AphroditeUpgrade", },
							Comparison = ">",
							Value = 2,
						},
					},
				},
				{
					Name = "StackUpgrade",
					GameStateRequirements =
					{
						NamedRequirements = { "StackUpgradeLegal", },
						{
							Path = { "CurrentRun", "LootTypeHistory", },
							SumOf = { "ApolloUpgrade", "AphroditeUpgrade", },
							Comparison = ">",
							Value = 2,
						},
					}
				},
				{
					Name = "HermesUpgrade",
					GameStateRequirements =
					{
						-- unlock requirements
						{
							PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
						},

						-- run requirements				
						RequiredNotInStore = "ShopHermesUpgrade",
						{
							Path = { "CurrentRun", "BiomeUseRecord", },
							HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
						},
						{
							Path = { "CurrentRun", "EncounterDepth" },
							Comparison = ">=",
							Value = 8,
						},
						{
							Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
							Comparison = "<=",
							Value = 1,
						},

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

		ShrineUpgradesActive =
		{
			RoomStartManaShrineUpgrade = 1,
		},

		UnlockGameStateRequirements =
		{
			-- Biome and Shrine unlocks
			NamedRequirements = { "PackageBountyBiomeG", "ShrineUnlocked", },
			-- Bounty progress
			{
				Path = { "GameState", "BountiesCompleted" },
				HasAny = { "PackageBountyChaosIntro", "PackageBountyOceanus", "PackageBountyStarter", },
			},
			-- Weapon
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll = { "WeaponStaffSwing", "StaffClearCastAspect", },
			},
			-- Keepsake
			{
				PathTrue = { "GameState", "GiftPresentation", "BossMetaUpgradeKeepsake", },
			},
			-- Familiar
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			-- FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "AphroditeFirstPickUp", },
			},
			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyHazard =
	{
		InheritFrom = { "DefaultPackagedBounty", "BasePackageBountyBiomeN", },

		DifficultyRating = 3,

		WeaponKitName = "WeaponLob",
		WeaponUpgradeName = "LobCloseAttackAspect",
		KeepsakeName = "TempHammerKeepsake",
		FamiliarName = "FrogFamiliar",

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
			{ Name = "OmegaCastVolleyBoon", Rarity = "Common" },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
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
			"CastBuff",
			"CastCount",
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
				Path = { "GameState", "BountiesCompleted" },
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
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			--[[ FirstLoot
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = { "ApolloFirstPickUp", },
			},
			]]

			-- MetaUpgrades
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked", },
			},
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},

	-- Random Package Bounties
	BasePackageBountyRandom =
	{
		DebugOnly = true,
		Category = "BountyRandom",
		RequireActiveForRun = true,
		Repeatable = true,
		IsPackagedBounty = true,
		LootDelay = 2.0,
		LootOptions =
		{
			{
				Name = "MetaCurrencyRange",
				Overrides =
				{
					CanDuplicate = false,
					AddResources =
					{
						MetaCurrency = 50,
					},
				},
			},
		},

		RandomWeaponKitNames = {  "WeaponStaffSwing", "WeaponAxe", "WeaponDagger", "WeaponTorch", "WeaponLob" },
		RandomFamiliarNames = { "FrogFamiliar", }, --"RavenFamiliar", "CatFamiliar", 
		RandomKeepsakeNames =
		{ 
			"ManaOverTimeRefundKeepsake",
			"BossPreDamageKeepsake",
			"DoorHealReserveKeepsake",
			"ReincarnationKeepsake",
			"DeathVengeanceKeepsake",
			"BlockDeathKeepsake",
			"EscalatingKeepsake",
			"SpellTalentKeepsake",
			"BonusMoneyKeepsake",
			"DamagedDamageBoostKeepsake",
			"RandomBlessingKeepsake",
			"ForceZeusBoonKeepsake",
			"ForceHeraBoonKeepsake",
			"ForcePoseidonBoonKeepsake",
			"ForceApolloBoonKeepsake",
			"ForceDemeterBoonKeepsake",
			"ForceAphroditeBoonKeepsake",
			"ForceHephaestusBoonKeepsake",
			"ForceHestiaBoonKeepsake",
			"TimedBuffKeepsake",
			"LowHealthCritKeepsake",
			"DecayingBoostKeepsake",
			"ArmorGainKeepsake",
			"FountainRarityKeepsake",
			"UnpickedBoonKeepsake",
			"BossMetaUpgradeKeepsake",
			"TempHammerKeepsake",
		},

		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "GiftPresentation" },
				HasAll =
				{
					"ManaOverTimeRefundKeepsake",
					"BossPreDamageKeepsake",
					"DoorHealReserveKeepsake",
					"ReincarnationKeepsake",
					"DeathVengeanceKeepsake",
					"BlockDeathKeepsake",
					"EscalatingKeepsake",
					"SpellTalentKeepsake",
					"BonusMoneyKeepsake",
					"DamagedDamageBoostKeepsake",
					"RandomBlessingKeepsake",
					"ForceZeusBoonKeepsake",
					"ForceHeraBoonKeepsake",
					"ForcePoseidonBoonKeepsake",
					"ForceApolloBoonKeepsake",
					"ForceDemeterBoonKeepsake",
					"ForceAphroditeBoonKeepsake",
					"ForceHephaestusBoonKeepsake",
					"ForceHestiaBoonKeepsake",
					"LowHealthCritKeepsake",
					"DecayingBoostKeepsake",
					"ArmorGainKeepsake",
					"FountainRarityKeepsake",
					"UnpickedBoonKeepsake",
					"BossMetaUpgradeKeepsake",
					"TempHammerKeepsake",
				},
			},
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll = { "WeaponStaffSwing", "WeaponAxe", "WeaponDagger", "WeaponTorch", "WeaponLob" },
			},
			{
				Path = { "GameState", "FamiliarStatus", },
				HasAll = {  "FrogFamiliar", } --"RavenFamiliar", "CatFamiliar",
			},
			NamedRequirements = { "ShrineUnlocked" },
		},
		CompleteGameStateRequirements =
		{
			-- None
		},
	},
	PackageBountyRandomUnderworld10Shrine =
	{
		InheritFrom = { "BasePackageBountyRandom" },

		StartingBiome = "F",
		Encounter = "BossChronos01",
		BiomeIcon = "GUI\\Screens\\BountyBoard\\Biome_Surface",
		BiomeText = "BountyBoard_UnderworldRun",
		
		RandomMetaUpgradeCostTotal = 15,
		RandomShrineUpgradePointTotal = 10,
	},
	PackageBountyRandomSurface10Shrine =
	{
		InheritFrom = { "BasePackageBountyRandom" },

		StartingBiome = "N",
		Encounter = "BossEris01",
		BiomeIcon = "GUI\\Screens\\BountyBoard\\Biome_Underworld",
		BiomeText = "BountyBoard_SurfaceRun",
		
		RandomMetaUpgradeCostTotal = 15,
		RandomShrineUpgradePointTotal = 10,
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

	-- Staff Bounties
	BountyStaffHeat1FBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossHecate01",

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
	BountyStaffHeat2GBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossScylla01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			},			
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyStaffHeat1FBoss" },
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
	BountyStaffHeat4NBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossPolyphemus01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyStaffHeat2GBoss" },
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
				Value = 4,
			},
		},
	},
	BountyStaffHeat8OBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossEris01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyStaffHeat4NBoss" },
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
				Value = 8,
			},
		},
	},
	BountyStaffHeat12HBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossInfestedCerberus01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyStaffHeat8OBoss" },
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
				Value = 12,
			},
		},
	},
	
	BountyStaffHeat20IBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossChronos01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				--PathTrue = { "GameState", "BountiesCompleted", "BountyStaffHeat16PBoss" },
				PathTrue = { "GameState", "BountiesCompleted", "BountyStaffHeat12HBoss" },
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
				Value = 20,
			},
		},
	},
	

	-- Dagger Bounties
	BountyDaggerHeat1GBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossScylla01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
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
	BountyDaggerHeat2NBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossPolyphemus01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyDaggerHeat1GBoss" },
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
				Value = 2,
			},
		},
	},
	BountyDaggerHeat4OBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossEris01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyDaggerHeat2NBoss" },
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
				Value = 4,
			},
		},
	},
	BountyDaggerHeat8HBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossInfestedCerberus01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyDaggerHeat4OBoss" },
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
	
	BountyDaggerHeat16FBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossHecate01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			},
			{
				--PathTrue = { "GameState", "BountiesCompleted", "BountyDaggerHeat12PBoss" },
				PathTrue = { "GameState", "BountiesCompleted", "BountyDaggerHeat8HBoss" },
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
				Value = 16,
			},
		},	
	},
	
	BountyDaggerHeat24IBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossChronos01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				--PathTrue = { "GameState", "BountiesCompleted", "BountyDaggerHeat20QBoss" },
				PathTrue = { "GameState", "BountiesCompleted", "BountyDaggerHeat16FBoss" },
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
				Value = 24,
			},
		},
	},

	-- Axe Bounties
	BountyAxeHeat1NBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossPolyphemus01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
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
				Value = 1,
			},
		},
	},
	BountyAxeHeat2OBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossEris01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyAxeHeat1NBoss" },
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
				Value = 2,
			},
		},
	},
	BountyAxeHeat4HBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossInfestedCerberus01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyAxeHeat2OBoss" },
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
	
	BountyAxeHeat12FBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossHecate01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			},			
			{
				--PathTrue = { "GameState", "BountiesCompleted", "BountyAxeHeat8PBoss" },
				PathTrue = { "GameState", "BountiesCompleted", "BountyAxeHeat4HBoss" },
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
	BountyAxeHeat16GBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossScylla01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			},				
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyAxeHeat12FBoss" },
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
	BountyAxeHeat20IBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossChronos01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyAxeHeat16GBoss" },
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
				Value = 20,
			},
		},
	},
	
	-- Torch Bounties
	BountyTorchHeat1OBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossEris01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
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
				Value = 1,
			},
		},
	},
	BountyTorchHeat2HBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossInfestedCerberus01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyTorchHeat1OBoss" },
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
	
	BountyTorchHeat8FBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossHecate01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			},			
			{
				--PathTrue = { "GameState", "BountiesCompleted", "BountyTorchHeat4PBoss" },
				PathTrue = { "GameState", "BountiesCompleted", "BountyTorchHeat2HBoss" },
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
	BountyTorchHeat12GBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossScylla01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			},				
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyTorchHeat8FBoss" },
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
				Value = 12,
			},
		},
	},
	BountyTorchHeat16NBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossPolyphemus01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyTorchHeat12GBoss" },
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
				Value = 16,
			},
		},
	},
	
	BountyTorchHeat24IBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossChronos01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				--PathTrue = { "GameState", "BountiesCompleted", "BountyTorchHeat20QBoss" },
				PathTrue = { "GameState", "BountiesCompleted", "BountyTorchHeat16NBoss" },
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
				Value = 24,
			},
		},
	},

	-- Lob Bounties
	BountyLobHeat1HBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossInfestedCerberus01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
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
	
	BountyLobHeat4FBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossHecate01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			},			
			{
				--PathTrue = { "GameState", "BountiesCompleted", "BountyLobHeat2PBoss" },
				PathTrue = { "GameState", "BountiesCompleted", "BountyLobHeat1HBoss" },
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
	BountyLobHeat8GBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossScylla01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			},				
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyLobHeat4FBoss" },
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
	BountyLobHeat12NBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossPolyphemus01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyLobHeat8GBoss" },
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
				Value = 12,
			},
		},
	},
	BountyLobHeat16OBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossEris01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossEris01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyLobHeat12NBoss" },
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
	BountyLobHeat20IBoss =
	{
		InheritFrom = { "DefaultBossHeatBounty" },
		Encounter = "BossChronos01",

		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			},
			{
				PathTrue = { "GameState", "BountiesCompleted", "BountyLobHeat16OBoss" },
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
				Value = 20,
			},
		},
	},
	
}

ScreenData.BountyBoard =
{
	BlockPause = true,
	ItemStartX = 350,
	ItemStartY = 300,
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
	
	OpenSound = "/SFX/Menu Sounds/FatedListOpen",
	CloseSound = "/SFX/Menu Sounds/FatedListClose",

	InfoMessageId = "BountyIntro",

	Components = {},

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 8,
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

	IneligibleFormat =
	{
		Color = Color.CostUnaffordableDark,
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

	ItemCategories =
	{
		{
			Name = "BountyBoard_Packages",
			GameStateRequirements =
			{
				{
				},
			},

			-- Intro Bounties
			"PackageBountyChaosIntro",
			"PackageBountyOceanus",
			"PackageBountyStarter",

			-- 1 Difficulty
			"PackageBountyHellChop",
			"PackageBountyRevenge",

			-- 2 Difficulty
			"PackageBountySpellCast",
			"PackageBountyHealer",
			"PackageBountyHestia",
			"PackageBountyGold",

			-- 3 Difficulty
			"PackageBountyLowMana",
			"PackageBountyHazard",
			"PackageBountyAphrodite",

			-- 4 Difficulty
			"PackageBountySpeed",
			"PackageBountyCriticalHealth",

			-- 5 Difficulty
			"PackageBountyOneTouch",

			-- Not yet implemented
			--"PackageBountyNightmare",
			--"PackageBountySouls",
			--"PackageBountyEphyra",
			--"PackageBountyHecateMirror",
			--"PackageBountyControlFate",
			--"PackageBountySoulHarvest",
			--"PackageBountySchelemeus",
			--"PackageBountyStrife",
			--"PackageBountyChance",
			--"PackageBountyZeus",
			--"PackageBountyHera",
			--"PackageBountyPoseidon",
			--"PackageBountyApollo",
			--"PackageBountyDemeter",
			--"PackageBountyHephaestus",
			--"PackageBountyArmor",
			--"PackageBountyRarity",
			--"PackageBountyMusic",

			-- random difficulty
			--"PackageBountyRandomUnderworld10Shrine",
			--"PackageBountyRandomSurface10Shrine",
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
			AnimationName = "GUI\\Screens\\BountyBoard\\Background",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				--[[
				TitleText = 
				{
					Text = "BountyLogScreen_Title",
					TextArgs =
					{
						FontSize = 34,
						OffsetX = 170, OffsetY = -460,
						Color = Color.White,
						Font = "SpectralSCLightTitling",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Center",
					},
				},

				FlavorText = 
				{
					Text = "BountyLogScreen_Flavor",
					TextArgs =
					{
						FontSize = 19,
						OffsetX = 0, OffsetY = -410,
						Width = 840,
						Color = {120, 120, 120, 0},
						Font = "LatoSemiboldItalic",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
						Justification = "Center",
					},
				},
				]]--

				ScrollUp = 
				{
					Graphic = "ButtonBountyUp",
					GroupName = "Combat_Menu",
					OffsetX = -615,
					OffsetY = -300,
					Alpha = 0,
					InteractProperties =
					{
						FreeFormSelectable = true,
					},
					Data =
					{
						OnPressedFunctionName = "QuestLogScrollUp",
						ControlHotkeys = { "MenuUp", },
					}
				},

				ScrollDown = 
				{
					Graphic = "ButtonBountyDown",
					GroupName = "Combat_Menu",
					OffsetX = -615,
					OffsetY = 285,
					Alpha = 0,
					InteractProperties =
					{
						FreeFormSelectable = true,
					},
					Data =
					{
						OnPressedFunctionName = "QuestLogScrollDown",
						ControlHotkeys = { "MenuDown", },
					}
				},

				UnlockHint =
				{
					Text = "BountyBoard_UnlockRequirements",
					OffsetX = 188,
					OffsetY = 240,
					Alpha = 0.0,
					TextArgs =
					{
						Color = { 155, 155, 155, 180 },
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

				ClearMessage =
				{
					Text = "BountyBoard_ClearMessage_NonRepeatable",
					OffsetX = 188,
					OffsetY = 240,
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
						LuaKey = "TempTextData", LuaValue = { BestClearTimeString = "99:59.99" },
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
			AnimationName = "BountySelect",
			Alpha = 0.0,
			Scale = 0.7,
			ButtonOffsetX = 0,
			ButtonOffsetY = 0,
		},

		ItemTitleText =
		{
			X = 1126,
			Y = 205,
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
			Y = 370,
			Alpha = 0.0,
			Text = "PackageBountyDefault",
			TextArgs =
			{
				UseDescription = true,
				Font = "LatoItalic",
				FontSize = 22,
				Width = 850,
				Color = { 140, 140, 140, 255 },
				TextSymbolScale = 0.85,
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		LocationIconBacking =
		{
			X = 1126 - 340,
			Y = 610,
			Alpha = 0.0,
			AnimationName = "GUI\\Screens\\BountyBoard\\Backing",
		},
		LocationIcon =
		{
			X = 1126 - 340,
			Y = 585,
			Alpha = 0.0,
			Scale = 0.6,
			TextArgs =
			{
				OffsetY = 100,
				FontSize = 22,
				Width = 305,
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

		WeaponIconBacking =
		{
			X = 1126,
			Y = 610,
			Alpha = 0.0,
			AnimationName = "GUI\\Screens\\BountyBoard\\Backing",
		},
		WeaponIcon =
		{
			X = 1126,
			Y = 585,
			Alpha = 0.0,
			Scale = 0.6,
			TextArgs =
			{
				OffsetY = 100,
				FontSize = 22,
				Width = 305,
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

		KeepsakeIconBacking =
		{
			X = 1126 + 340,
			Y = 610,
			Alpha = 0.0,
			AnimationName = "GUI\\Screens\\BountyBoard\\Backing",
		},
		KeepsakeIcon =
		{
			X = 1126 + 340,
			Y = 585,
			Alpha = 0.0,
			Scale = 0.6,
			TextArgs =
			{
				OffsetY = 100,
				FontSize = 22,
				Width = 305,
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

		--[[
		DifficultyText =
		{
			X = 1840,
			Y = 200,
			Alpha = 0.0,
			TextArgs =
			{
				Color = {161,161,161,255},
				Width = 700,
				Height = 800,
				FontSize = 22,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Right",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},
		]]

		IntensityEye1 =
		{
			X = 1748,
			Y = 258,
			Scale = 0.42,
			AnimationName = "GUI\\Screens\\BountyBoard\\Intensity\\Intensity_Closed01",
			ActiveAnimationName = "GUI\\Screens\\BountyBoard\\Intensity\\Intensity_Open01",
		},

		IntensityEye2 =
		{
			X = 1744,
			Y = 380,
			Scale = 0.42,
			AnimationName = "GUI\\Screens\\BountyBoard\\Intensity\\Intensity_Closed02",
			ActiveAnimationName = "GUI\\Screens\\BountyBoard\\Intensity\\Intensity_Open02",
		},

		IntensityEye3 =
		{
			X = 1755,
			Y = 502,
			Scale = 0.42,
			AnimationName = "GUI\\Screens\\BountyBoard\\Intensity\\Intensity_Closed03",
			ActiveAnimationName = "GUI\\Screens\\BountyBoard\\Intensity\\Intensity_Open03",
		},

		IntensityEye4 =
		{
			X = 1736,
			Y = 620,
			Scale = 0.42,
			AnimationName = "GUI\\Screens\\BountyBoard\\Intensity\\Intensity_Closed04",
			ActiveAnimationName = "GUI\\Screens\\BountyBoard\\Intensity\\Intensity_Open04",
		},

		IntensityEye5 =
		{
			X = 1758,
			Y = 726,
			Scale = 0.42,
			AnimationName = "GUI\\Screens\\BountyBoard\\Intensity\\Intensity_Closed05",
			ActiveAnimationName = "GUI\\Screens\\BountyBoard\\Intensity\\Intensity_Open05",
		},

		RewardText =
		{
			Text = "QuestLogReward",
			CompletedText = "QuestLogRewardEarned",
			X = 1140,
			Y = 855,
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
					GroupName = "Combat_Menu_Overlay",
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
					GroupName = "Combat_Menu_Overlay",
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