OverwriteTableKeys( TraitData, {
	-- Torch
	TorchHammerTrait = 
	{
		CodexWeapon = "WeaponTorch"
	},

	TorchSpecialImpactTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_34",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "NumProjectiles",
				ChangeValue = 2,
				ChangeType = "Add",
				ReportValues = { ReportedCount = "ChangeValue" }
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "ProjectileAngleOffset",
				ChangeValue = math.rad(-60),
				ChangeType = "Absolute",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
			},
		},
	},

	TorchExSpecialCountTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_30",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponTorchSpecial" },
			IncreaseNumProjectiles =
			{
				NumProjectiles = 1,
				ReportValues = { ReportedCount = "NumProjectiles" }
			},
			AddWeaponProperties = 
			{
				ProjectileAngleOffset = math.rad(120),
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
			},
		},
	},

	TorchSpecialSpeedTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_36",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = { "WeaponTorchSpecial" },
			Value = 0.8,
			ReportValues = { ReportedSpeedBonus = "Value" }
		},
		ManaCostModifiers = 
		{
			WeaponNames = WeaponSets.HeroSecondaryWeapons,
			ExWeapons = true,
			ManaCostAdd = -10,
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpeedBonus",
				ExtractAs = "SpeedBonus",
				Format = "NegativePercentDelta",
			},
			{
				Key = "ReportedCost",
				ExtractAs = "ManaDiscount",
			},
		},
	},

	TorchEnhancedAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_29",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		OnWeaponFiredFunctions = 
		{
			
			ValidWeapons = WeaponSets.HeroRushWeapons,
			FunctionName = "TorchSprintRecall",
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponTorch", },
				ProjectileProperties = 
				{
					ResetCollisionOutsideImpact = true,
					InheritOwnerVelocityMultiplier = 0,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileProperty = "TotalFuse",
				ChangeValue = 2,
				ChangeType = "Add",
				ReportValues = { ReportedDurationIncrease = "ChangeValue" }
			},
			{
				FalseTraitName = "TorchSprintRecallAspect",
				WeaponName = "WeaponTorch",
				ProjectileProperty = "ReturnToOwnerSpeed",
				ChangeValue = 1200,
			},
			{
				TraitName = "TorchSprintRecallAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "ReturnToOwnerSpeed",
				ChangeValue = 100,
			},
			{
				TraitName = "TorchSprintRecallAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "ReturnToOwnerRecallOnly",
				ChangeValue = true,
			},
			{
				TraitName = "TorchSprintRecallAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "ReturnToOwnerSpeed",
				ChangeValue = 1200,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDurationIncrease",
				ExtractAs = "DurationIncrease",
			},
		}
	},

	TorchDiscountExAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_28",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroPrimaryWeapons,
			Value = 0.5,
			ReportValues = { ReportedSpeedIncrease = "Value" }
		},
		ManaCostModifiers = 
		{
			WeaponNames = WeaponSets.HeroPrimaryWeapons,
			ExWeapons = true,
			ManaCostAdd = -1,
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipDiscount",
			},
			{
				Key = "ReportedSpeedIncrease",
				ExtractAs = "TooltipChargeSpeed",
				Format = "NegativePercentDelta",
			},
		},
	},
	TorchLongevityTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_31",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileProperties = 
				{
					MaxSize = 1.35,
					SizeDuration = 3,
				},
				ExcludeLinked = true,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponTorchSpecial" },
			LifetimeMultiplier = 0.25,
			ReportValues = 
			{ 
				LifetimeMultiplier = "LifetimeMultiplier" 
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
	TorchSplitAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_38",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "TorchDetonateAspect", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "TorchSprintRecallAspect", },
			},
		},
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponTorch",
				ProjectileProperties = 
				{
					UnlimitedUnitPenetration = false,
				},
				ExcludeLinked = true,
			},
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckProjectileSpawn",
			ValidProjectiles = {"ProjectileTorchBall", "ProjectileTorchBallLarge"},
			Args = 
			{
				UseOriginalProjectileForPropertyChanges = true,
				IgnoreImpactId = true,
				MatchProjectileName = false,
				IgnoreAdvancedSplitValidity = true,
				SpawnCount = 2,
				SpawnArc = 60,
				ProjectileNameMapIgnores = 
				{
					ProjectileTorchBallLarge = "TorchSprintRecallAspect",
				},
				ProjectileNameMap = 
				{
					ProjectileTorchBall = "ProjectileTorchBallSplit",
					ProjectileTorchBallLarge = "ProjectileTorchBallLargeSplit"
				},
			ReportValues = { ReportedSpawnCount = "SpawnCount"},
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpawnCount",
				ExtractAs = "SpawnCount",
			},
		}
	},

	TorchSpinAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_37",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponTorch" },
			ValidBaseDamageAddition = 10,
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidBaseDamageAddition" 
			},
			ExcludeLinked = true,
		},
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponTorch",
				ProjectileProperties = 
				{
					ImpactVelocity = 800,
				}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageAddition",
			},
		},
	},

	TorchSpinAttackAltTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_37",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},

		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponTorch" },
			ValidBaseDamageAddition = 10,
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidBaseDamageAddition" 
			},
			ExcludeLinked = true,
		},
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponTorch",
				ProjectileProperties = 
				{
					Speed = 1800,
					SpinRate = math.rad(360),
					SpinFromOwnerVelocityMultiplier = 0,
					InheritOwnerVelocityMultiplier = 0,
					TotalFuse = 2,
				}
			},

			{
				FalseTraitName = "TorchSprintRecallAspect",
				WeaponName = "WeaponTorch",
				ProjectileProperty = "Fuse",
				ChangeValue = 2,
				ChangeType = "Absolute",
			},
			{
				TraitName = "TorchSprintRecallAspect",
				WeaponName = "WeaponTorch",
				ProjectileProperty = "Fuse",
				ChangeValue = 4, --Match extended fuse of the aspect
				ChangeType = "Absolute",
			},
			{
				TraitName = "TorchDetonateAspect",
				WeaponName = "WeaponTorch",
				ProjectileProperty = "Fuse",
				ChangeValue = 6, --Match extended fuse of the aspect
				ChangeType = "Absolute",
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageAddition",
			},
		},
	}, 

	TorchOrbitPointTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_33",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Speed",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
				ReportValues = { ReportedMoveSpeedBonus = "ChangeValue"},
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Speed",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedMoveSpeedBonus",
				ExtractAs = "MoveSpeed",
				Format = "PercentDelta",
				IncludeSigns = true,
			},
		},
	},

	TorchSpecialLineTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_35",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		AddOutgoingDamageModifiers =
		{
			HealthBufferRemoval = 0.20,
			ValidWeapons = { "WeaponTorchSpecial" },
			ReportValues = { ReportedWeaponMultiplier = "HealthBufferRemoval"},
		},
		PropertyChanges =
		{	
			--[[
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "AutoLock",
				ChangeValue = true,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "AutoLockRange",
				ChangeValue = 838,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "AutoLockArcDistance",
				ChangeValue = 120,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "SpinRate",
				ChangeValue = 0,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Fuse",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Speed",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Acceleration",
				ChangeValue = 1.0,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "ProjectileAngleStartOffset",
				ChangeValue = 0,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "ProjectileAngleOffset",
				ChangeValue = 0,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "SetSpinFromMovement",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			]]
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageBonus",
				Format = "Percent",
				IncludeSigns = true,
			},
		},
	},

	TorchMoveSpeedTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_32",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.3,
				SourceIsMultiplier = true,
			},
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Speed",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedRangeIncrease = "ChangeValue" },
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Speed",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponTorch",
				WeaponProperty = "AutoLockRange",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta"
			},
			{
				Key = "ReportedRangeIncrease",
				ExtractAs = "TooltipRangeIncrease",
				Format = "PercentDelta"
			},
		},
	},

	TorchAttackSpeedTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_27",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponTorch",
				WeaponProperty = "Cooldown",
				ChangeValue = 0.8,
				ChangeType = "Multiply",
				ReportValues = { ReportedSpeedBonus = "ChangeValue" }
			},
			{
				WeaponName = "WeaponTorch",
				EffectName = "TorchAttackChargeSpeed",
				EffectProperty = "Modifier",
				BaseValue = 1.8,
				ChangeType = "Multiply",
				--ReportValues = { ReportedSpeedIncrease= "ChangeValue" }
			},
			{
				WeaponName = "WeaponTorch",
				EffectName = "TorchAttackFireSpeed",
				EffectProperty = "Modifier",
				BaseValue = 1.8,
				ChangeType = "Multiply",
			},
			--[[
			{
				WeaponName = "WeaponTorch",
				EffectName = "TorchAttackChargeSpeed",
				EffectProperty = "Modifier",
				BaseValue = 0.3,
				ChangeType = "Multiply",
				ReportValues = { ReportedSpeedPenalty= "ChangeValue" }
			},
			]]
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpeedBonus",
				ExtractAs = "TooltipSpeedBonus",
				Format = "NegativePercentDelta"
			},
		},
	},

	TorchHomingAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponTorch", },
				ProjectileProperties = 
				{
					MaxAdjustRate = math.rad(560),
					AdjustRateAcceleration = math.rad(-60),
					ImpactVelocity = 0,
				},
				ExcludeLinked = true,
			},
			{
				WeaponNames = {"WeaponTorch"},
				ProjectileProperty = "Speed",
				ChangeValue = 1.5,
				ChangeType = "Multiply",
			}
		}
	},

	TorchConsecutiveStrikeTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_35",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperties = 
				{
					ConsecutiveHitWindow = 1,
					DamagePerConsecutiveHit = 4,
					ReportValues = { ReportedDamage = "DamagePerConsecutiveHit"},
				},
			}
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
		}
	},

	TorchOrbitDistanceTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_33",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ExBaseDamageAddition = { BaseValue = 5 },
			ReportValues = 
			{ 
				ReportedDamage = "ExBaseDamageAddition"
			},
		},
		PropertyChanges =
		{	
			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Range",
				ChangeValue = 2,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedMoveSpeedBonus",
				ExtractAs = "MoveSpeed",
				Format = "PercentDelta",
				IncludeSigns = true,
			},
		},
	},
})