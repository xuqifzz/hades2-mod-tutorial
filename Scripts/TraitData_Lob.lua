OverwriteTableKeys( TraitData, {
	-- Lob
	LobHammerTrait = 
	{
		CodexWeapon = "WeaponLob",
		DebugOnly = true,
	},

	LobAmmoTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_02",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsNone = {"LobGunAspect", }
			},
		},
		WeaponAmmoModification = 
		{
			Name = "WeaponLob",
			AddMaxAmmo = { BaseValue = 2 },
			ReportValues = { ReportedAmmoBonus = "AddMaxAmmo"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedAmmoBonus",
				ExtractAs = "AmmoIncrease",
			},
		}
	},

	LobAmmoMagnetismTrait =
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_01",
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 2,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "LobPulseAmmoTrait" },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsNone = {"LobGunAspect", }
			}
		},
		MagnetismSpeedMultiplier = { BaseValue = 2, SourceIsMultiplier = true},
		AmmoMagnetismMultiplier = 100,
		ExtractValues = 
		{
			{
				Key = "MagnetismSpeedMultiplier",
				ExtractAs = "TooltipSpeed",
				Format = "PercentDelta",
			}
		}
	},

	LobRushArmorTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_08",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
		AddOutgoingDamageModifiers =
		{
			NonExFlatDamageToArmor = 600,
			ValidWeapons = { "WeaponLobSpecial" },
			ReportValues = { ReportedWeaponMultiplier = "NonExFlatDamageToArmor"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "ArmorDamageIncrease",
			},
		}
	},

	LobSpreadShotTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_10",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsNone = {"LobGunAspect", }
			},
		},
		ForceWeaponRefreshOnRemove = "WeaponLob",
		WeaponDataOverride =
		{
			WeaponLob =
			{
				OnChargeFunctionNames = { "DoWeaponCharge", "UpdateLobWeaponProjectileNum"},
			}
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			AddWeaponProperties = 
			{
				ProjectileAngleOffset = math.rad(25),
			}
		}
	},

	LobOneSideTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_05",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsNone = {"LobGunAspect", }
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

			ValidWeaponMultiplier =
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		
		PropertyChanges = 
		{
			--[[
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Fuse",
				ChangeValue = 2.5,
				ChangeType = "Multiply",
			},
			{
				--TraitName = "LobInOutSpecialExTrait",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Speed",
				ChangeValue = 2.5,
				ChangeType = "Multiply",
			},
			]]
			{
				WeaponName = "WeaponSkullImpulse",
				WeaponProperty = "SelfVelocity",
				ChangeValue = 1.25,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				WeaponProperty = "SelfVelocityCap",
				ChangeValue = 1.25,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "BlinkSpeed",
				ChangeValue = 1.5,
				ChangeType = "Multiply",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
		},	
	},
	LobSturdySpecialTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_12",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
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
				Multiplier = 40/30,
			},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponLobSpecial" },
			FunctionName = "StartLobSturdy",
			FunctionArgs =
			{
				DamageTakenModifier = 0.7,
				ReportValues = 
				{ 
					ReportedSturdyModifier = "DamageTakenModifier" 
				},
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponLobSpecial" },
			ValidBaseDamageAddition = 
			{ 
				BaseValue = 30,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidBaseDamageAddition" 
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSturdyModifier",
				ExtractAs = "SturdyModifier",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageIncrease",
			},
		},		
	},

	LobSpecialSpeedTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_09",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
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
				Multiplier = 0.45/0.35,
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.65,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
			},
		},
		
		WeaponSpeedMultiplier =
		{
			WeaponNames = { "WeaponLobSpecial" },
			Value = 
			{
				BaseValue = 0.65,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedSpeed = "Value" }
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedSpeed",
				ExtractAs = "SpeedIncrease",
				Format = "NegativePercentDelta",
				SkipAutoExtract = true
			},
		}
	},
	LobInOutSpecialExTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_04",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "ReverseAfterDuration",
				ChangeValue = 0.3,
			},
		}
	},

	LobPulseAmmoCollectTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_06",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsNone = {"LobGunAspect", }
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
				Multiplier = 20/25,
			},
		},
		PreEquipWeapons = { "WeaponLobChargedPulse" },
		OnCollectAmmoFunctionName = 
		{
			WeaponName = "WeaponLob",
			FunctionName = "FireAmmoCollectionPulse",
			FunctionArgs = 
			{
				PulseWeaponName = "WeaponLobChargedPulse",
				ManaCost = { BaseValue = 25 },
				ReportValues = { ReportedCost = "ManaCost" }
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedCost",
				ExtractAs = "Cost",
			}
		}
	},

	LobPulseAmmoTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_07",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "LobAmmoMagnetismTrait" },
			},

			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsNone = {"LobGunAspect", }
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
		PreEquipWeapons = { "WeaponLobPulse" },
		OnTouchdownFunction =
		{
			Name = "CheckLobPulse",
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponLobPulse",
				ProjectileProperty = "Damage",
				BaseValue = 1,
				ChangeType = "Multiply",
			},
		},
		
		LobBaseDamageBonusMultiplier = { BaseValue = 0.5 },
		ExtractValues =
		{
			{
				Key = "LobBaseDamageBonusMultiplier",
				ExtractAs = "TooltipDamage",
				Format = "Percent",
			},
		},	
	},

	LobGrowthTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_03",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsNone = {"LobGunAspect", }
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
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponLob",
				ProjectileProperties = 
				{
					MaxSize = 2,				-- Size of projectile
					SizeDuration = 0.7,
					BlastModifierDuration = 0.7,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLob",
				ProjectileProperty = "MaxBlastModifier",
				ChangeValue = 1.75,
			},
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperty = "MaxBlastModifier",
				ChangeValue = 1.25,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponLob" },
			LifetimeNonExMultiplier = { BaseValue = 0.50 },
			ReportValues = 
			{ 
				LifetimeMultiplier = "LifetimeNonExMultiplier" 
			},
			ExcludeLinked = true,
		},
		ExtractValues =
		{
			{
				Key = "LifetimeMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "Percent",
				IncludeSigns = true,
			},
		},
	},

	LobStraightShotTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_11",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsNone = {"LobGunAspect", }
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
				Multiplier = 20/15,
			},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponBlink", "WeaponLob", "WeaponLobSpecial"},
			FunctionName = "CheckDashVolley",
			FunctionArgs = 
			{
				SpeedMultiplier =  4,
				ReportValues = { ReportedSpeedMultiplier = "SpeedMultiplier"},
			},
			ExcludeLinked = true
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = {"WeaponLob"},
			DashVolleyBaseDamageAddition = { BaseValue = 15 },
			ReportValues = { ReportedWeaponMultiplier = "DashVolleyBaseDamageAddition"},
		},
		OnProjectileDeathDashVolley = 
		{
			Name = "RemoveDashVolley",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				IncludeSigns = true
			},
			{
				Key = "ReportedSpeedMultiplier",
				ExtractAs = "SpeedIncrease",
				Format = "PercentDelta"
			},
		},
	},
	LobGunOverheatTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_17",
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsAny = {"LobGunAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect" },
			},
		},
		OverheatDurationIncrease = { BaseValue = 3 },
		
		ExtractValues =
		{
			{
				Key = "OverheatDurationIncrease",
				ExtractAs = "DurationIncrease",
				IncludeSigns = true
			},
			
			{
				External  = true,
				BaseType = "TraitData",
				BaseName = "LobGunAspect",
				BaseProperty = { "OnWeaponFiredFunctions", "FunctionArgs", "EffectData", "Duration" }, 
				ExtractAs = "OverheatDuration",
				SkipAutoExtract = true,
			},
		}
	},
	LobGunBounceTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_18",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 25/15,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsAny = {"LobGunAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect" },
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = {"WeaponLob"},
			JumpMultiplier = { BaseValue = 0.15 },
			ReportValues = { ReportedWeaponMultiplier = "JumpMultiplier"},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponLob",
				ProjectileProperties = 
				{
					NumJumps = 1,
	  				JumpType = "UNIT_PREFERENCE",
      				JumpRange = 620,
      				JumpSpeedMultiplier = 1.1,
					NoJumpTargetRandomSpread = 90,
					ReportValues = { Jumps = "NumJumps"},
				},
				ExcludeLinked = true
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "Increase",
				Format = "Percent"
			},
		}
	},
	LobGunSpecialBounceTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_20",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsAny = {"LobGunAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect" },
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
				Multiplier = 25/15,
			},
		},
		AddOutgoingDamageModifiersArray =
		{
			{
				ValidWeapons = {"WeaponLobSpecial"},
				JumpMultiplier = { BaseValue = 0.15 },
				ReportValues = { ReportedWeaponMultiplier = "JumpMultiplier"},
			},
			{
				ValidWeapons = {"WeaponLobSpecial"},
				ValidProjectiles = {"ProjectileLobGunRift", "ProjectileThrowCharged"},
				LobGunSpecialHitMultiplier = { BaseValue = 0.15 },
			},
		},
		OnProjectileCreationFunction = 
		{
			ValidProjectiles = { "ProjectileLobGunRift" },
			Name = "OnGunRiftCreated",
		},
		OnProjectileDeathFunction = 
		{
			ValidProjectiles = { "ProjectileLobGunRift" },
			Name = "OnGunRiftDeath",
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = {"ProjectileLobGunRift", "ProjectileThrowCharged"},
			FunctionName = "OnGunRiftDamage",
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileProperties = 
				{
					JumpSpeedMultiplier = 1.1,
				},
				ExcludeLinked = true
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobSpecialBounce",
				ProjectileProperty = "Speed",
				ChangeValue = 300,
				ChangeType = "Add",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileLobGunRift",
				ProjectileProperty = "Speed",
				ChangeValue = 200,
				ChangeType = "Add",
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "Increase",
				Format = "Percent"
			},
		}
	},
	LobGunAttackRangeTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_21",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsAny = {"LobGunAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect" },
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
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ValidWeaponMultiplier = { BaseValue = 1.25, SourceIsMultiplier = true},
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		PropertyChanges =
		{
			{
				WeaponNames = WeaponSets.HeroPrimaryWeapons,
				ProjectileName = "ProjectileLobBullet",
				ProjectileProperty = "Range",
				ChangeValue = 200,
				ChangeType = "Add",
			},
			{
				WeaponNames = WeaponSets.HeroPrimaryWeapons,
				ProjectileName = "ProjectileLobBullet",
				WeaponProperty = "AutoLockRange",
				ChangeValue = 130,
				ChangeType = "Add",
			},
			{
				WeaponNames = WeaponSets.HeroPrimaryWeapons,
				ProjectileName = "ProjectileLobOverheat",
				ProjectileProperty = "Fuse",
				ChangeValue = 0.1,
				ChangeType = "Add",
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "Increase",
				Format = "PercentDelta"
			},
		}
	},
	LobGunAttackDoublerTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_22",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponLob", },
				IsAny = {"LobGunAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect" },
			},
		},
		ReportedCountIncrease = 2,
		ChargeStageModifiersArray = 
		{
			{
				ValidTrait = "DoubleExManaBoon",
				ValidWeapons = WeaponSets.HeroPrimaryWeapons,
				ExWeapons = true,
				AddWeaponProperties = 
				{
					NumProjectileWaves = 4,
					ProjectileWaveInterval = 0.15,
				},
			},
			{
				FalseTraitName = "DoubleExManaBoon",
				ValidWeapons = WeaponSets.HeroPrimaryWeapons,
				ExWeapons = true,
				AddWeaponProperties = 
				{
					NumProjectileWaves = 3,
					ProjectileWaveInterval = 0.15
				},
			},
		}
	}
})