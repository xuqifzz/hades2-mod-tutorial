OverwriteTableKeys( TraitData, {
	-- Suit
	SuitHammerTrait = 
	{
		CodexWeapon = "WeaponSuit",
		DebugOnly = true,
	},
	
	SuitArmorTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_04",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = { "WeaponSuit", "WeaponSuit2" },
			NonExFlatDamageToArmor = 250,
			ExcludeLinked = true,
			ReportValues = { ReportedWeaponMultiplier = "NonExFlatDamageToArmor"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
			},
		}
	},
	
	SuitAttackSpeedTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_05",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 0.45/0.35,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
		},
		WeaponSpeedMultiplier =
		{
				WeaponNames = WeaponSets.HeroPrimaryWeapons,
			Value = 
			{
				BaseValue = 0.65,
				SourceIsMultiplier = true,
			},
		},
		PropertyChanges = 
		{
			{
				WeaponNames = WeaponSets.HeroPrimaryWeapons,
				BaseValue = 0.65,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
				ExcludeLinked = true,
				ReportValues = { ReportedWeaponMultiplier = "ChangeValue" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "NegativePercentDelta",
			},
		}
	},
	
	SuitAttackSizeTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_06",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ValidBaseDamageAddition = 
			{ 
				BaseValue = 10,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidBaseDamageAddition" 
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSuit",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 0.4,
				ChangeType = "Add",
				ReportValues = 
				{ 
					ReportedSizeChange = "ChangeValue" 
				},
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "TooltipDamageBonus",
				IncludeSigns = true, -- doesn't work, so the + is in the string
			},
			{
				Key = "ReportedSizeChange",
				ExtractAs = "TooltipSize",
				Format = "Percent",
			},

		}
	},
	SuitAttackRangeTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_07",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
		},
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier = { BaseValue = 1.3, SourceIsMultiplier = true },
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponSuit","WeaponSuit2", "WeaponSuitDouble", "WeaponSuitCharged",},
				ProjectileProperty = "AttachToOwner",
				ChangeValue = false,
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSuit", "WeaponSuit2", "WeaponSuitDouble" },
				ProjectileProperty = "Speed",
				ChangeValue = 4000,
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSuit", "WeaponSuit2", "WeaponSuitDouble" },
				ProjectileProperty = "Acceleration",
				ChangeValue = -15000,
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSuit", "WeaponSuit2", "WeaponSuitDouble" },
				WeaponProperty = "SelfVelocity",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSuit", "WeaponSuit2", "WeaponSuitDouble" },
				WeaponProperty = "AutoLockRange",
				ChangeValue = 1.5,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSuitCharged",
				ProjectileProperty = "Speed",
				ChangeValue = 2000,
				ExcludeLinked = true,
			},
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "ReportedDamageBonus",
					Format = "PercentDelta",
			},
		}
	},
	
	SuitFullChargeTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_08",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.4,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponSuitCharged" },
			MaxChargeDamage = { BaseValue = 100 },
			ReportValues = 
			{ 
				ReportedDamageBonus = "MaxChargeDamage" 
			},
		},
		ExtractValues =
		{
			{
					Key = "ReportedDamageBonus",
					ExtractAs = "ReportedDamageBonus",
			},
		}
	},
	SuitDashAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_09",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsNone = {"SuitComboAspect", }
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSuitDash",
				ExcludeLinked = true,
				WeaponProperty = "NumProjectiles",
				ChangeValue = 3,
				ChangeType = "Add",
				ReportValues = {ReportedChange = "ChangeValue"}
			},
			{
				WeaponName = "WeaponSuitDash",
				ExcludeLinked = true,
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitNovaBurnRapid",
			},
		},
		ExtractValues =
		{
			{
					Key = "ReportedChange",
					ExtractAs = "ReportedStrikeBonus",
			},
		}
	},
	SuitSpecialJumpTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_10",
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsNone = {"SuitComboAspect", }
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "NumJumps",
				BaseValue = 2,
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "NumJumps",
				BaseValue = 2,
				ReportValues = {ReportedChange = "ChangeValue"}
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "BounceFx",
				ChangeValue = "SuitRocketExplosion",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedChange",
				ExtractAs = "Count",
			},
		}
	},
	SuitSpecialStartUpTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_11",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsNone = {"SuitComboAspect", }
			},
		},
		MissileStartupMultiplier = 0.2,
		MissileCooldownMultiplier = 0.5,
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedUnguided",
				ProjectileProperty = "Fuse",
				ChangeValue = 0.2,
				ReportValues = {ReportedChange = "ChangeValue"}
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "AdjustRateAcceleration",
				ChangeValue = math.rad(1200),
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "Speed",
				ChangeValue = 1.5,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "AdjustRateAcceleration",
				ChangeValue = math.rad(1200),
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "Speed",
				ChangeValue = 1.5,
				ChangeType = "Multiply",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedChange",
				ExtractAs = "RocketSpeed",
				Format = "NegativePercentDelta",
			},
		}
	},
	
	SuitSpecialAutoTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_12",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsNone = {"SuitComboAspect", }
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 0.35/0.25,
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "CheckMissileOnHit",
			FirstHitOnly = true,
			Args = 
			{
				Chance = { BaseValue = 0.25 },
				ProjectileCount = 2,
				ProjectileName = "ProjectileSuitRangedUnguided",
				ReportValues = {ReportedChance = "Chance"}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedChance",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent",
			},
		}
	},
	SuitSpecialBlockTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_13",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsNone = {"SuitComboAspect", }
			},
		},
		OnBlockDamageFunction = 
		{
			Name = "BlockLaunchMissile",
			Args = 
			{
				ProjectileName = "ProjectileSuitRangedUnguided",
				ProjectileCount = 5, -- Number of projectiles
				PerEnemyCooldown = 3, -- Flat cooldown per enemy
				Count = 2, -- number of retaliates per window
				Window = 1,
				ReportValues = 
				{ 
					ReportedCount = "ProjectileCount",
					ReportedCooldown = "PerEnemyCooldown",
				},
			}
		},
			ExtractValues =
			{
				{
					Key = "ReportedCount",
					ExtractAs = "TooltipCount",
				},
				{
					Key = "ReportedCooldown",
					ExtractAs = "TooltipCooldown",
				},
			}
	},
	SuitSpecialDiscountTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_14",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsNone = {"SuitComboAspect", }
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5,
			},
		},
		SeekIntervalMultiplier = 2/3,
		ManaCostModifiers = 
		{
			WeaponNames = { "WeaponSuitRanged" },
			ExWeapons = true,
			ManaCostMultiplier = { BaseValue = 0.80, SourceIsMultiplier = true },
			ReportValues = 
			{ 
				ReportedCost = "ManaCostMultiplier" 
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipDiscount",
				Format = "PercentDelta"
			},
		}
	},
	SuitSpecialConsecutiveHitTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_15",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsNone = {"SuitComboAspect", }
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 8/5,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = {"WeaponSuitRanged"},
			ConsecutiveBaseDamage = { BaseValue = 5 } ,
			MaxConsecutiveBaseDamage = { BaseValue = 25 },
			MaxConsecutiveStacks = 5, -- used for text only, to equal the above value
			ReportValues = { ReportedBaseDamage = "ConsecutiveBaseDamage", ReportedMaxDamage = "MaxConsecutiveBaseDamage"}
		},

		OnEnemyDamagedAction = 
		{
			ValidWeapons = {"WeaponSuitRanged"},
			FunctionName = "CheckConsecutiveDamage",
			Args = 
			{
				Window = 1,
				ReportValues = { ReportedWindow = "Window"}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedBaseDamage",
				ExtractAs = "Damage",
			},
			{
				Key = "ReportedMaxDamage",
				ExtractAs = "MaxDamage",
			},
			{
				Key = "ReportedWindow",
				ExtractAs = "DamageWindow",
			},
		}
	},
	
	SuitComboForwardRocketTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_18",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsAny = {"SuitComboAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect" },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ValidBaseDamageAddition = 
			{ 
				BaseValue = 30,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidBaseDamageAddition" 
			},
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponSuitRanged"},
			ExcludeLinked = true,
			AddWeaponProperties = 
			{
				Projectile = "ProjectileSuitBombStraight",
				TargetReticleAnimation = "null",
				ManualAiming = false,
				AimLineAnimation = "AuraAimLine",
			}
		},
		WeaponDataOverride = 
		{
			WeaponSuitRanged = 
			{
				BlockEarlySwap = true,
			}
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSuitRanged",
				WeaponProperty = "Projectile",
				ChangeValue = "ProjectileSuitGrenadeStraight",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "Increase",
			},
		}
	},
	SuitComboBlockBuffTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_19",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsAny = {"SuitComboAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect" },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 4/3,
			},
		},
		OnBlockDamageFunction = 
		{
			Name = "BlockSelfBuff",
			Args = 
			{
				Stacks = { BaseValue = 3 },
				ReportValues = 
				{ 
					ReportedCount = "Stacks",
				}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Stacks",
			},
			{
				External  = true,
				BaseType = "TraitData",
				BaseName = "SuitComboAspect",
				BaseProperty = { "OnWeaponFiredFunctions", "FunctionArgs", "SelfEffectStackMultiplier" },
				ExtractAs = "ExecuteBonus",
				Format = "Percent",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "TraitData",
				BaseName = "SuitComboAspect",
				BaseProperty = { "OnWeaponFiredFunctions", "FunctionArgs", "SelfEffectMaxStacks" },
				ExtractAs = "StackCount",
				SkipAutoExtract = true,
			},
		}
	},
	SuitComboDoubleSpecialTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_20",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsAny = {"SuitComboAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect" },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 0.6,
			},
		},
		SelfBuffBlastManaCost = { BaseValue = 10 },
		ExtractValues =
		{
			{
				Key = "SelfBuffBlastManaCost",
				ExtractAs = "Cost",
			},
		}
	},
	SuitComboDashAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_21",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsAny = {"SuitComboAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect" },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = {"WeaponSuitDash"},
			ValidWeaponMultiplier = 
			{ 
				BaseValue = 1.4,
				SourceIsMultiplier = true,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidWeaponMultiplier" 
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSuitDash",
				ExcludeLinked = true,
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 0.2,
				ChangeType = "Add",
			},
		},
		ExtractValues =
		{
			{
					Key = "ReportedDamageBonus",
					ExtractAs = "ReportedBonus",
					Format = "PercentDelta"
			},
		}
	},
	SuitPowershotTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_17",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5,
			}
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponSuit", },
				IsAny = {"SuitComboAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect" },
			},
		},
		StagePerfectChargeWindow = 0.4,
		AddOutgoingDamageModifiers =
		{
			PerfectChargeMultiplier =
			{
				BaseValue = 2.5,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "PerfectChargeMultiplier"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
			{
				External  = true,
				BaseType = "TraitData",
				BaseName = "SuitComboAspect",
				BaseProperty = { "OnWeaponFiredFunctions", "FunctionArgs", "SelfEffectStackMultiplier" },
				ExtractAs = "ExecuteBonus",
				Format = "Percent",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "TraitData",
				BaseName = "SuitComboAspect",
				BaseProperty = { "OnWeaponFiredFunctions", "FunctionArgs", "SelfEffectMaxStacks" },
				ExtractAs = "StackCount",
				SkipAutoExtract = true,
			},
		}
	},

})