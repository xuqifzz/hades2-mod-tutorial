OverwriteTableKeys( TraitData, {
	-- Torch
	TorchSpecialImpactTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_34",
		RequiredWeapon = "WeaponTorch",
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponTorchSpecial" },
			NonExBaseDamageAddition = 
			{ 
				BaseValue = 75,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "NonExBaseDamageAddition" 
			},
			ExcludeLinked = true,
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "UnlimitedUnitPenetration",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageBonus",
				IncludeSigns = true,
			},
		},
	},
	TorchExSpecialCountTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_30",
		RequiredWeapon = "WeaponTorch",
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_36",
		RequiredWeapon = "WeaponTorch",
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_29",
		RequiredWeapon = "WeaponTorch",
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
					CheckObstacleImpact = false
				},
				ExcludeLinked = true,
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
	},
	TorchDiscountExAttackTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_28",
		RequiredWeapon = "WeaponTorch",
		
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_31",
		RequiredWeapon = "WeaponTorch",
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_38",
		RequiredWeapon = "WeaponTorch",
		RequiredFalseTraits = {"TorchDetonateAspect"},
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_37",
		RequiredWeapon = "WeaponTorch",
		
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

	TorchOrbitPointTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_33",
		RequiredWeapon = "WeaponTorch",
		PropertyChanges =
		{	
			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "AttachToOwner",
				ChangeValue = false,
				ExcludeLinked = true,
			},
			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "UseStartLocation",
				ChangeValue = false,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Speed",
				ChangeValue = 1.6,
				ChangeType = "Multiply",
				ReportValues = { ReportedMoveSpeedBonus = "ChangeValue"},
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Speed",
				ChangeValue = 1.6,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchSpiral",
				ProjectileProperty = "Acceleration",
				ChangeValue = -330,
				ChangeType = "Absolute",
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
	--ForceRelease = true,
	TorchSpecialLineTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_35",
		RequiredWeapon = "WeaponTorch",
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_32",
		RequiredWeapon = "WeaponTorch",
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Torch_27",
		RequiredWeapon = "WeaponTorch",
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
			{
				Key = "ReportedSpeedPenalty",
				ExtractAs = "TooltipSpeedPenalty",
				Format = "NegativePercentDelta"
			},
		},
	},
})