OverwriteTableKeys( TraitData, {
	-- Suit
	SuitHammerTrait = 
	{
		CodexWeapon = "WeaponSuit"
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
			HealthBufferRemoval = 0.20,
			ValidWeapons = { "WeaponSuit", "WeaponSuit2" },
			ExcludeLinked = true,
			ReportValues = { ReportedWeaponMultiplier = "HealthBufferRemoval"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "ArmorDamageIncrease",
				Format = "Percent",
			},
		}
	},
	
	SuitAttackSpeedTrait = 
	{
		InheritFrom = { "WeaponTrait", "SuitHammerTrait" },
		Icon = "Hammer_Suit_05",
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
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier = 1.3,
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSuit",
				ProjectileProperty = "AttachToOwner",
				ChangeValue = false,
			},
			{
				WeaponNames = { "WeaponSuit", "WeaponSuit2" },
				ProjectileProperty = "Speed",
				ChangeValue = 4000,
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSuit", "WeaponSuit2" },
				ProjectileProperty = "Acceleration",
				ChangeValue = -15000,
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSuit", "WeaponSuit2" },
				WeaponProperty = "SelfVelocity",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSuit", "WeaponSuit2" },
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
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponSuitCharged" },
			MaxChargeDamage = 100,
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
				ProjectileProperty = "StartFx",
				ChangeValue = "Null",
			},
			{
				WeaponName = "WeaponSuitDash",
				ExcludeLinked = true,
				ProjectileProperty = "DetonateFx",
				ChangeValue = "SuitNovaBurn",
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponSuit", },
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedGuided",
				ProjectileProperty = "NumJumps",
				ChangeValue = 2,
			},
			{
				WeaponName = "WeaponSuitRanged",
				ProjectileName = "ProjectileSuitRangedCharged",
				ProjectileProperty = "NumJumps",
				ChangeValue = 2,
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
				ProjectileProperty = "NumJumps",
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
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "CheckMissileOnHit",
			FirstHitOnly = true,
			Args = 
			{
				Chance = 0.25,
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
				Format = "Percent",
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
					ReportedCount = "ProjectileCount" 
				},
			}
		},
			ExtractValues =
			{
				{
					Key = "ReportedCount",
					ExtractAs = "TooltipCount",
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
		},
		SeekIntervalMultiplier = 2/3,
		ManaCostModifiers = 
		{
			WeaponNames = { "WeaponSuitRanged" },
			ExWeapons = true,
			ManaCostMultiplier = 0.80,
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
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = {"WeaponSuitRanged"},
			ConsecutiveBaseDamage = 5,
			MaxConsecutiveBaseDamage = 25,
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
	}
})