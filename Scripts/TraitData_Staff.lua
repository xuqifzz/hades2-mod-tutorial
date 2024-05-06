OverwriteTableKeys( TraitData, {
	-- Staff
	StaffSecondStageTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_37",
		RequiredWeapon = "WeaponStaffSwing",
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponStaffBall", },
			AddChargeStage = 
			{ 
				ManaCost = 50,
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
	
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_31",
		RequiredWeapon = "WeaponStaffSwing",
		RequiredFalseTraits = { "StaffAttackRecoveryTrait", },
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_29",
		RequiredWeapon = "WeaponStaffSwing",
	
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3" },
				WeaponProperties = 
				{
					NumProjectiles = 2,
					ProjectileInterval = 0.12,
					ProjectileIntervalStart = 0.12,
				},
				ExcludeLinked = true,
			},
			--[[
			{
				WeaponName = "WeaponStaffSwing",
				ProjectileName = "ProjectileStaffSwing1",
				ProjectileProperty = "Range",
				ChangeValue = 0.6,
				ChangeType = "Multiply",
				ReportValues = { ReportedSlow = "ChangeValue"},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing2",
				ProjectileName = "ProjectileStaffSwing2",
				ProjectileProperty = "Range",
				ChangeValue = 0.6,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				ProjectileName = "ProjectileStaffSwing3",
				ProjectileProperty = "Range",
				ChangeValue = 0.6,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing5",
				ProjectileName = "ProjectileStaffSwing5",
				ProjectileProperty = "Range",
				ChangeValue = 0.6,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			
			{
				WeaponName = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3", "WeaponStaffSwing5" },
				WeaponProperty = "ChargeTime",
				ChangeValue = 1.5,
				ChangeType = "Multiply",
				ReportValues = { ReportedSlow = "ChangeValue"},
			},
			]]
		},
		ExtractValues =
		{
			{
				Key = "ReportedSlow",
				ExtractAs = "AttackSlow",
				Format = "PercentDelta",
			},
		}
	},
	StaffPowershotTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_36",
		RequiredWeapon = "WeaponStaffSwing",
		StagePerfectChargeWindow = 0.15,
		AddOutgoingDamageModifiers =
		{
			PerfectChargeMultiplier =
			{
				BaseValue = 1.2,
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
				ManaRefund = 5,
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_34",
		RequiredWeapon = "WeaponStaffSwing",
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
				Key = "ReportedRangeBonus",
				ExtractAs = "TooltipRangeBonus",
				Format = "PercentDelta"
			},
			{
				Key = "Jumps",
				ExtractAs = "NumJumps",
			},
			{
				Key = "JumpDamageBonus",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta"
			},
		}
	},
	StaffDashAttackTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_28",
		RequiredWeapon = "WeaponStaffSwing",
	
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_32",
		RequiredWeapon = "WeaponStaffSwing",
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponStaffBall" },
				BaseValue = 0.8,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileProperty = "Speed",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileProperty = "Damage",
				BaseValue = 5,
				ChangeType = "Add",
				ReportValues = { ReportedDamageChange = "ChangeValue" },
			},
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = { "WeaponStaffBall" },
			Value = 
			{
				BaseValue = 0.8,
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
			{
				Key = "ReportedDamageChange",
				ExtractAs = "TooltipDamageBonus",
			},
		},
	},
	StaffAttackRecoveryTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_27",
		RequiredWeapon = "WeaponStaffSwing",
		RequiredFalseTraits = { "StaffOneWayAttackTrait", "StaffExAoETrait", "StaffExHealTrait", "SlowExAttackBoon" },
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3", "WeaponStaffDash"},
				WeaponProperties = 
				{
					FullyAutomatic = true,
					AddOnFire = "null",
					ForceReleaseOnSwap = false,
					AllowExternalForceRelease = false,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffSwing3",
				WeaponProperty = "SwapOnFire",
				ChangeValue = "WeaponStaffSwing",
			},
			--[[
			{
				WeaponName = "WeaponStaffSwing",
				EffectName = "Swing1DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponStaffSwing2",
				EffectName = "Swing2DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponStaffSwing3",
				EffectName = "Swing3DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
			},
			]]
			{
				WeaponNames = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3", "WeaponStaffDash" },
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
				ExcludeLinked = true,
				ReportValues = { ReportedSpeedIncrease = "ChangeValue"},
			},
			{
				WeaponNames = { "WeaponStaffSwing5" },
				WeaponProperty = "Enabled",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_30",
		RequiredWeapon = "WeaponStaffSwing",
		RequiredFalseTraits = { "StaffAttackRecoveryTrait", },
		IsLastPriorityHammerTrait = true,
		PropertyChanges =
		{
			{
				FalseTraitName = "StaffOneWayAttackTrait",
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
			{
				TraitName = "StaffOneWayAttackTrait",
				WeaponName = "WeaponStaffSwing5",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					NumProjectiles = 27,
					ProjectileAngleOffsetScaleY = 0.6,
					AimLineAnimation = "AuraAimLineNoMovement",
					ProjectileOffsetStart = "LEFT",
					ProjectileAngleResetCount = 3,
					ProjectileAngleOffset = math.rad(90),
					ProjectileAngleStartOffset = math.rad(90),
					ProjectileOffset = 120,
					ProjectileSpacing = 0,
					ProjectileInterval = 0.005,
					AimLineCountOverride = 3,
					AimLineAngleOffsetOverride = math.rad(90),
					BarrelLength = 0,
				},
			},
		},
		
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.4,
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_35",
		RequiredWeapon = "WeaponStaffSwing",
		RequiredFalseTraits = { "StaffAttackRecoveryTrait", },
		PropertyChanges =
		{
			{
				WeaponName = "WeaponStaffSwing5",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					AimLineAnimation = "StaffAuraAimLineNoMovement",
					BarrelLength = 800,
					ProjectileOffsetStart = "LEFT",
					AimLineCountOverride = 1,
					NumProjectiles = 9,
					ProjectileWaveInterval = 0.2,
				},
			},
			{
				WeaponName = "WeaponStaffSwing5",
				ExcludeLinked = true,
				WeaponProperty = "NumProjectileWaves",
				ChangeValue = 2,
				ReportValues = { ReportedWaves = "ChangeValue" }
			}
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedWaves",
				ExtractAs = "Waves",
			},
		}
	},
	StaffJumpSpecialTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_33",
		RequiredWeapon = "WeaponStaffSwing",

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
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty  = "NumJumps",
				ChangeValue = 2,
				ChangeType = "Absolute",
				ExcludeLinked = true,
				ReportValues = { Jumps = "ChangeValue" },
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty  = "JumpDamageMultiplier",
				ChangeValue = 1.10,
				ChangeType = "Absolute",
				ExcludeLinked = true,
				ReportValues = { JumpDamageBonus = "ChangeValue" },
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Staff_38",
		RequiredWeapon = "WeaponStaffSwing",
	
		PropertyChanges =
		{
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				WeaponProperties = 
				{
					ProjectileInterval = 0.12,
					ProjectileAngleOffsetMin = math.rad(-5),
					ProjectileAngleOffsetMax = math.rad(5),
				},
				ProjectileProperties = 
				{
					MaxAdjustRate = 6,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "AdjustRateAcceleration",
				ChangeValue = 6,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffBall",
				WeaponProperty = "NumProjectiles",
				ChangeValue = 2.0,
				ChangeType = "Absolute",
				ReportValues = { ReportedProjectiles = "ChangeValue"},
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Fuse",
				ChangeValue = 1.1,
				ExcludeLinked = true,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedProjectiles",
				ExtractAs = "Projectiles",
			},
		}
	},
})