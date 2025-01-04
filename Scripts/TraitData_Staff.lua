OverwriteTableKeys( TraitData, {
	-- Staff
	StaffHammerTrait = 
	{
		CodexWeapon = "WeaponStaffSwing"
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
			ChargeStageMultiplier = 4,
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "StaffAttackRecoveryTrait" },
			},
		},
		OnEnemyDeathFunction = 
		{
			Name = "StaffEXHitHeal",
			FunctionArgs = {
				RequiredWeapon = "WeaponStaffSwing5",
				CombatText = "StaffHeal",
				HealAmount = 5,
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
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
		},
	
		PropertyChanges =
		{
			{
				WeaponName = "WeaponStaffDash",
				WeaponProperties = 
				{
      				ProjectileScaleMultiplier = 2.0,
				},
				ExcludeLinked = true,
			},
		},
		AddOutgoingDamageModifiers =
		{
			HealthBufferRemoval = 0.60,
			ValidWeapons = { "WeaponStaffDash" },
			ReportValues = { ReportedWeaponMultiplier = "HealthBufferRemoval"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "Percent",
			},
		}
	},

	StaffFastSpecialTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_32",
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "StaffOneWayAttackTrait", "StaffExAoETrait", "StaffExHealTrait", "SlowExAttackBoon" },
			},
		},
		PropertyChanges =
		{	
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3", "WeaponStaffDash", "WeaponStaffSwing5" },
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.5,
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

	StaffSlowExTrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_01",
		IsPriorityHammerModifierTrait = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "StaffAttackRecoveryTrait", },
			},
		},
		
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileProperty = "Damage",
				BaseValue = 25,
				ChangeType = "Add",
				ReportValues = { ReportedDamageChange = "ChangeValue" },
			},
			{
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "ProjectileInterval",
				ChangeValue = 0.1,
				ChangeType = "Absolute",
				ReportValues = { ReportedDamageChange = "ChangeValue" },
			},
		},
	},

	StaffExAoETrait = 
	{
		InheritFrom = { "WeaponTrait", "StaffHammerTrait" },
		Icon = "Hammer_Staff_30",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponStaffSwing", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "StaffAttackRecoveryTrait", },
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
					NumProjectiles = 36,
					ProjectileAngleOffsetScaleY = 0.6,
					ProjectileAngleResetCount = 4,
					ProjectileAngleOffset = math.rad(90),
					ProjectileAngleStartOffset = 0,
					ProjectileOffset = 120,
					ProjectileSpacing = 0,
					ProjectileInterval = 0.005,
					AimLineCountOverride = 4,
					AimLineAngleOffsetOverride = math.rad(90),
				},
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
					}
				}
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
					}
				}
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
					}
				}
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
					}
				}
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
		
		PropertyChanges =
		{
		
			{
				WeaponName = "WeaponStaffBall",
				--ProjectileName = "ProjectileStaffBall",
				ProjectileProperty  = "NumJumps",
				ChangeValue = 2,
				ChangeType = "Add",
				--ExcludeLinked = true,
				ReportValues = { Jumps = "ChangeValue" },
			},
			{
				WeaponName = "WeaponStaffBall",
				--ProjectileName = "ProjectileStaffBall",
				ProjectileProperty  = "JumpDamageMultiplier",
				ChangeValue = 1.10,
				ChangeType = "Absolute",
			--	ExcludeLinked = true,
				ReportValues = { JumpDamageBonus = "ChangeValue" },
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileProperty  = "JumpRange",
				ChangeValue = 400,
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
				Format = "PercentDelta",
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

	StaffReserveManaBoostTrait = 
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
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ExManaReserveConversion = 2,
		},
	},
})