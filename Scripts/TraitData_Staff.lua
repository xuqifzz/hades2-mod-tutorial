OverwriteTableKeys( TraitData, {
	-- Staff
	StaffHammerTrait = 
	{
		CodexWeapon = "WeaponStaffSwing",
		DebugOnly = true,
	},

	StaffSecondStageTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_37",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Legendary = 
			{
				Multiplier = 1.333,
			},
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponStaffBall", },
			AddChargeStage = 
			{ 
				ManaCost = 40,
				ResetIndicator = true,
				Wait = 0.8, 
				ProjectileProperties = 
				{
					DamageRadius = 550,
					BlastSpeed = 2500,
				},
				ReportValues = 
				{
					ReportedManaCost = "ManaCost",
				}
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidProjectiles = { "ProjectileStaffBallCharged" },
			ChargeStageMultiplier = { BaseValue = 4, SourceIsMultiplier = true},
			RequiredChargeStage = 2,
			ReportValues = 
			{ 
				ReportedDamage = "ChargeStageMultiplier",
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
			{
				External = true,
				BaseType = "WeaponData",
				BaseName = "WeaponStaffBall",
				ChargeStage = 1,
				BaseProperty = "ChargeStageProperty",
				ChargeStageProperty = "ManaCost",
				ExtractAs = "BaseManaCost",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaCost",
				Subtractor = "BaseManaCost",
				IncludeSigns = true,
			},
		}
	},

	StaffExHealTrait = 
	{
	
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_31",
		
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
		},
		OnEnemyDeathFunction = 
		{
			Name = "StaffEXHitHeal",
			FunctionArgs = {
				RequiredWeapon = "WeaponStaffSwing5",
				CombatText = "StaffHeal",
				HealAmount = { BaseValue = 5 },
				ReportValues = 
				{ 
					ReportedHealAmount = "HealAmount",
				}
			}
		},
		ExtractValues =
		{

			{
				Key = "ReportedHealAmount",
				ExtractAs = "Heal",
			},
		}
	},

	StaffDoubleAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_29",
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponStaffSwing", },
				IsNone = {"StaffRaiseDeadAspect", }
			},
		},
	
		PropertyChanges =
		{
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileProperty = "Damage",
				BaseValue = 30,
				ChangeType = "Add",
				ReportValues = { ReportedDamageChange = "ChangeValue" },
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageChange",
				ExtractAs = "TooltipDamageBonus",
			},
		}
	},

	StaffPowershotTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_36",
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
				HasAll = { "WeaponStaffSwing", },
			},
		},
		StagePerfectChargeWindow = 0.275,
		AddOutgoingDamageModifiers =
		{
			PerfectChargeMultiplier =
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "PerfectChargeMultiplier"},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponStaffBall" },
			FunctionName = "CheckPerfectChargeRefund",
			FunctionArgs = 
			{
				ManaRefund = 20,
				ReportValues = { ReportedRefund = "ManaRefund"},
			},
			ExcludeLinked = true,
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedRefund",
				ExtractAs = "Refund",
				SkipAutoExtract = true,
			},
		},
	},

	StaffLongAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_34",
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
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponStaffSwing", },
				IsNone = {"StaffRaiseDeadAspect", }
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3", "WeaponStaffDash" },
			ExcludeLinked = true,
			DistanceThreshold = 400,
			DistanceMultiplier =
			{
				BaseValue = 2,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "DistanceMultiplier"},
		},
	
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3" },
				ProjectileProperty  = "Range",
				ChangeValue = 1.5,
				ChangeType = "Multiply",
				ExcludeLinked = true,
				ReportValues = { JumpDamageBonus = "ChangeValue" },
			},
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3" },
				WeaponProperty = "AutoLockRange",
				ChangeValue = 1.5,
				ChangeType = "Multiply",
			},
			--[[
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3" },
				ProjectileProperty  = "Speed",
				ChangeValue = 1.0,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3" },
				ProjectileProperty  = "NumJumps",
				ChangeValue = 1,
				ChangeType = "Absolute",
				ExcludeLinked = true,
				ReportValues = { Jumps = "NumJumps" },
			},
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3" },
				ProjectileProperty  = "JumpDamageMultiplier",
				ChangeValue = 2.0,
				ChangeType = "Absolute",
				ExcludeLinked = true,
				ReportValues = { JumpDamageBonus = "ChangeValue" },
			},
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3" },
				ProjectileProperty  = "JumpType",
				ChangeValue = "OBSTACLE_ONLY",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			]]
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta"
			},
		}
	},

	StaffDashAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_28",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponStaffSwing", },
				IsNone = {"StaffRaiseDeadAspect", }
			},
		},
	
		PropertyChanges =
		{
			{
				FalseTraitName = "StaffRaiseDeadAspect",
				WeaponName = "WeaponStaffDash",
				ExcludeLinked = true,
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 2
			},
			{
				TraitName = "StaffRaiseDeadAspect",
				WeaponName = "WeaponStaffDash",
				ExcludeLinked = true,
				WeaponProperty = "BlastRadiusMultiplier",
				ChangeValue = 0.15,
				ChangeType = "Add",
			}
		},
		AddOutgoingDamageModifiers =
		{
			FlatDamageToArmor = 900,
			ValidWeapons = { "WeaponStaffDash" },
			ReportValues = { ReportedWeaponMultiplier = "FlatDamageToArmor"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
			},
		}
	},

	StaffFastSpecialTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_32",
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
		},
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponStaffBall" },
				BaseValue = 0.75,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileProperty = "Speed",
				ChangeValue = 1.25,
				ChangeType = "Multiply",
			},
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = { "WeaponStaffBall" },
			Value = 
			{
				BaseValue = 0.75,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "Value" }
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipSpeed",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
		},
	},

	StaffAttackRecoveryTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_27",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 0.4/0.5,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
		},
		PropertyChanges =
		{	
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3", "WeaponStaffDash", "WeaponStaffSwing5" },
				WeaponProperty = "ChargeTime",
				BaseValue = 0.5,
				ChangeType = "Multiply",
				ExcludeLinked = true,
				ReportValues = { ReportedSpeedIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "ChargeStartAnimation",
				ChangeValue = "Melinoe_Staff_AttackEx1_Start_Fast",
				ChangeType = "Absolute",
			},
		},	
		ExtractValues =
		{
			{
				Key = "ReportedSpeedIncrease",
				ExtractAs = "SpeedIncrease",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
		}
	},

	StaffExAoETrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_30",
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
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponStaffSwing", },
				IsNone = {"StaffRaiseDeadAspect", }
			},
		}, 
		IsLastPriorityHammerTrait = true,
		PropertyChanges =
		{
			{
				WeaponName = "WeaponStaffSwing5",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					ProjectileAngleOffsetScaleY = 0.6,
					ProjectileAngleResetCount = 4,
					ProjectileAngleOffset = math.rad(90),
					ProjectileAngleStartOffset = 0,
					ProjectileOffset = 120,
					ProjectileSpacing = 0,
					AimLineCountOverride = 4,
					AimLineAngleOffsetOverride = math.rad(90),
				},
			},
			{
				FalseTraitName = "StaffOneWayAttackTrait",
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "NumProjectiles",
				ChangeType = "Absolute",
				ChangeValue = 4,
			},
			{
				FalseTraitName = "StaffOneWayAttackTrait",
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "ProjectileInterval",
				ChangeType = "Absolute",
				ChangeValue = 0.005,
			},
			{
				FalseTraitName = "StaffOneWayAttackTrait",
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "ProjectileIntervalStart",
				ChangeType = "Absolute",
				ChangeValue = 0.005,
			},
			{
				TraitName = "StaffOneWayAttackTrait",
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "NumProjectiles",
				ChangeType = "Absolute",
				ChangeValue = 8,
			},
			{
				TraitName = "StaffOneWayAttackTrait",
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "ProjectileIntervalResetCount",
				ChangeType = "Absolute",
				ChangeValue = 4,
			},
			{
				TraitName = "StaffOneWayAttackTrait",
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "ProjectileIntervalResetCountStart",
				ChangeType = "Absolute",
				ChangeValue = 1,
			},
			{
				TraitName = "StaffOneWayAttackTrait",
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "NumProjectiles",
				ChangeType = "Absolute",
				ChangeValue = 8,
			},
		},
		
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
			},
			ValidWeapons = { "WeaponStaffSwing5" },
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
		}
	},

	StaffOneWayAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_35",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponStaffSwing", },
				IsNone = {"StaffRaiseDeadAspect", }
			},
		},
		WeaponDataOverride = 
		{
			WeaponStaffSwing = 
			{
				ManaChanges = 
				{
					Disabled = 
					{
						NumProjectiles = 1,
					},
					Enabled = 
					{
						NumProjectiles = 2,
					},
				},
			},
			WeaponStaffSwing2 = 
			{
				ManaChanges = 
				{
					Disabled = 
					{
						NumProjectiles = 1,
					},
					Enabled = 
					{
						NumProjectiles = 2,
					},
				},
			},
			WeaponStaffDash = 
			{
				ManaChanges = 
				{
					Disabled = 
					{
						NumProjectiles = 1,
					},
					Enabled = 
					{
						NumProjectiles = 2,
					},
				},
			},
			WeaponStaffSwing3 = 
			{
				ManaChanges = 
				{
					Disabled = 
					{
						NumProjectiles = 1,
					},
					Enabled = 
					{
						NumProjectiles = 2,
					},
				},
			},
		},
		ManaCostModifiers = 
		{
			WeaponNames = WeaponSets.HeroPrimaryWeapons,
			ManaCostAdd = 5,
			ReportValues = { ReportedManaCost = "ManaCostAdd" }
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3", "WeaponStaffDash", },
				ExcludeLinked = true,
				WeaponProperties = 
				{
					NumProjectiles = 2,
					ProjectileInterval = 0.12,
					ProjectileIntervalStart = 0.12,
				},
			},
			{
				FalseTraitName = "StaffSelfHitAspect",
				WeaponName = "WeaponStaffSwing5",
				ExcludeLinked = true,
				WeaponProperty = "NumProjectileWaves",
				ChangeValue = 2,
				ReportValues = { ReportedWaves = "ChangeValue" }
			},
			{
				FalseTraitName = "StaffSelfHitAspect",
				WeaponName = "WeaponStaffSwing5",
				ExcludeLinked = true,
				WeaponProperty = "ProjectileInterval",
				ChangeValue = 0.12,
			},
			{
				FalseTraitName = "StaffSelfHitAspect",
				WeaponName = "WeaponStaffSwing5",
				ExcludeLinked = true,
				WeaponProperty = "ProjectileIntervalStart",
				ChangeValue = 0.12,
			},
			{
				TraitName = "StaffSelfHitAspect",
				WeaponName = "WeaponStaffSwing5",
				ExcludeLinked = true,
				WeaponProperty = "ProjectileWaveInterval",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
			}
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedWaves",
				ExtractAs = "Waves",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "Mana",
			},
		}
	},

	StaffJumpSpecialTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_33",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
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
				Multiplier = 2,
			},
		},
		WeaponDataOverride =
		{
			WeaponStaffBall = 
			{
				SimSlowDistanceThreshold = 0,
				HitSimSlowParameters =
				{

				},
			}
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = {"WeaponStaffBall"},
			ProjectileName = "ProjectileStaffBall",
			JumpMultiplier = { BaseValue = 0.1 },
			ReportValues = { JumpDamageBonus = "JumpMultiplier" }
		},
		PropertyChanges =
		{
		
			{
				WeaponName = "WeaponStaffBall",
				ProjectileProperty  = "NumJumps",
				ChangeValue = 2,
				ChangeType = "Add",
				ReportValues = { Jumps = "ChangeValue" },
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileProperty  = "JumpRange",
				ChangeValue = 490,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileProperty  = "JumpType",
				ChangeValue = "UNIT_PREFERENCE",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileProperty  = "NoJumpTargetRandomSpread",
				ChangeValue = 90,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileProperty  = "AllowRepeatedJumpHit",
				ChangeValue = false,
				ChangeType = "Absolute",
			},		
		},
		ExtractValues =
		{
			{
				Key = "Jumps",
				ExtractAs = "JumpCount",
			},
			{
				Key = "JumpDamageBonus",
				ExtractAs = "JumpDamage",
				Format = "Percent",
			},
		}
	},

	StaffTripleShotTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_38",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponStaffBall",
				--ProjectileName = "ProjectileStaffBall",
				WeaponProperties = 
				{
					ProjectileInterval = 0.12,
					ProjectileIntervalStart = 0.12,
					ProjectileAngleOffsetMin = math.rad(-5),
					ProjectileAngleOffsetMax = math.rad(5),
					FireSound = "null",
					ProjectileIntervalResetSound = "/SFX/Player Sounds/StaffSpecialNew"
				},
				ProjectileProperties = 
				{
				--	MaxAdjustRate = 6,
				},
				ExcludeLinked = true,
			},
			--[[
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AdjustRateAcceleration",
				ChangeValue = 6,
				ExcludeLinked = true,
			},
			]]
			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "NumProjectiles",
				ChangeValue = 2.0,
				ChangeType = "Absolute",
				ReportValues = { ReportedProjectiles = "ChangeValue"},
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Fuse",
				ChangeValue = 0.60,
				ChangeType = "Multiply",
				ReportValues = { ReportedRangePenalty = "ChangeValue"},
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Fuse",
				ChangeValue = 0.60,
				ChangeType = "Multiply"
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Range",
				ChangeValue = 0.60,
				ChangeType = "Multiply"
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Range",
				ChangeValue = 0.60,
				ChangeType = "Multiply"
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedProjectiles",
				ExtractAs = "Projectiles",
			},
			{
				Key = "ReportedRangePenalty",
				ExtractAs = "TooltipRange",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
		}
	},

	-- Anubis
	StaffRaiseDeadBigTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_43",
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponStaffSwing", },
				IsAny = {"StaffRaiseDeadAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffRaiseDeadAspect" },
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = { "WeaponStaffSwing", "WeaponStaffDash", "WeaponStaffSwing5"},
			ValidBaseDamageAddition = { BaseValue = 5 },
			ReportValues = { ReportedDamage = "ValidBaseDamageAddition" },
		},
	
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffDash", "WeaponStaffSwing5" },
				WeaponProperty  = "BlastRadiusMultiplier",
				ChangeValue = 1.15,
				ChangeType = "Multiply",
				ExcludeLinked = true,
				ReportValues = { RadiusChange = "ChangeValue" },
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipDamageBonus",
			},
		}
	},
	StaffRaiseDeadDoubleTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_44",
		
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponStaffSwing", },
				IsAny = {"StaffRaiseDeadAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffRaiseDeadAspect" },
			},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponStaffSwing5" },
			FunctionName = "CreateSecondAnubisWall",
			FunctionArgs = 
			{
				Distance = 700,
			},
			ExcludeLinked = true,

		}
	},
	StaffLoneShadeRespawnTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_45",
		
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
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponStaffSwing", },
				IsAny = {"StaffRaiseDeadAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffRaiseDeadAspect" },
			},
		},
		SetupFunction = 
		{
			Name = "SetupMercBaseDamageBonus",
			Args = 
			{
				BaseDamageAddition = { BaseValue = 5 },
				ReportedBaseDamageAddition = { BaseValue = 50 },
				ReportValues = { DamageIncrease = "ReportedBaseDamageAddition" },
			}
		},
		LoneShadeRespawnChance = 0.75,
		ExtractValues =
		{
			{
				Key = "DamageIncrease",
				ExtractAs = "TooltipDamageBonus",
			},
			{
				Key = "LoneShadeRespawnChance",
				ExtractAs = "RespawnChance",
				Format = "LuckModifiedPercent",
			},
		}
	},
	StaffLoneShadeRallyTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_46",
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.8,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponStaffSwing", },
				IsAny = {"StaffRaiseDeadAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffRaiseDeadAspect" },
			},
		},
		SetupFunction = 
		{
			Name = "SetupMercDamageBonus",
			Args = 
			{
				DamageMultiplier = { BaseValue = 0.5 },
				ReportValues = { DamageIncrease = "DamageMultiplier" },
			}
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "ProjectileStaffBallCharged" },
			
			FunctionName = "RallyAnubisShades",
		},
		ExtractValues =
		{
			{
				Key = "DamageIncrease",
				ExtractAs = "TooltipDamageBonus",
				Format = "Percent"
			},
		}
	}
})