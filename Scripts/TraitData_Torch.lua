OverwriteTableKeys( TraitData, {
	-- Torch
	TorchHammerTrait = 
	{
		CodexWeapon = "WeaponTorch",
		DebugOnly = true,
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
		
		AutofireSpecialDurationBonus = { BaseValue = 2 },
		PropertyChanges =
		{
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Fuse",
				ChangeType = "Add",
				BaseValue = 2,
				ExcludeLinked = true,
				ReportValues = { ReportedIncrease = "ChangeValue"}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedIncrease",
				ExtractAs = "Duration",
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
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponTorch", },
				IsNone = { "TorchSprintRecallAspect" }
			},
		},
		TorchSpecialCountIncrease = 1,
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
				ProjectileAngleOffset = math.rad(360/3),
			},
		},
		PropertyChanges = 
		{

			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "NumProjectiles",
				ChangeValue = 1,
				ChangeType = "Add",
			},
			{
				FalseTraitName = "TorchSprintRecallAspect",
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "ActiveProjectileCap2",
				ChangeValue = 3,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "ProjectileAngleOffset",
				ChangeValue = math.rad(-360/2),
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
			-- All aspects
			{
				WeaponNames = { "WeaponTorch", },
				ProjectileProperties = 
				{
					ResetCollisionOutsideImpact = true,
					InheritOwnerVelocityMultiplier = 0,
					UnlimitedUnitPenetration = true,
					UnlimitedObstaclePenetration = true,
					SilentImpactOnInvulnerable = true,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileProperty = "TotalFuse",
				BaseValue = 2,
				ChangeType = "Add",
				ReportValues = { ReportedDurationIncrease = "ChangeValue" }
			},
			{
				FalseTraitNames = { "TorchDetonateAspect", },
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "Acceleration",
				ChangeValue = -900,
			},
			{
				FalseTraitNames = { "TorchDetonateAspect", },
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "ReturnToOwnerSpeed",
				ChangeValue = 1200,
			},
			-- Base EX
			{
				FalseTraitNames = { "TorchDetonateAspect", "TorchSprintRecallAspect", "TorchAutofireAspect" },
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Acceleration",
				ChangeValue = -900,
			},
			{
				FalseTraitNames = { "TorchDetonateAspect", "TorchSprintRecallAspect", "TorchAutofireAspect" },
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "ReturnToOwnerSpeed",
				ChangeValue = 1200,
			},
			{
				FalseTraitNames = { "TorchDetonateAspect", "TorchSprintRecallAspect", "TorchAutofireAspect" },
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Fuse",
				ChangeValue = 2,
				ChangeType = "Add",
			},
			{
				FalseTraitNames = { "TorchDetonateAspect", "TorchSprintRecallAspect", "TorchAutofireAspect" },
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Speed",
				ChangeValue = 0.7,
				ChangeType = "Multiply",
			},
			{
				FalseTraitNames = { "TorchDetonateAspect", "TorchSprintRecallAspect", "TorchAutofireAspect" },
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn",
			},
			-- Moros
			{
				TraitName = "TorchDetonateAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "ReturnToOwnerSpeed",
				ChangeValue = 1200,
			},
			{
				TraitName = "TorchDetonateAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "ReturnToOwnerSpeed",
				ChangeValue = 1200,
			},
			{
				TraitName = "TorchDetonateAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhost",
				ProjectileProperty = "TotalFuse",
				ChangeValue = 2,
				ChangeType = "Add",
			},
			{
				TraitName = "TorchDetonateAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchGhostLarge",
				ProjectileProperty = "TotalFuse",
				ChangeValue = 2,
				ChangeType = "Add",
			},

			-- Eos
			{
				TraitName = "TorchSprintRecallAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallEos",
				ProjectileProperty = "ReturnToOwnerSpeed",
				ChangeValue = 1200,
			},
			{
				TraitName = "TorchSprintRecallAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallEos",
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
			-- Supay
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Acceleration",
				ChangeValue = -2000,
			},
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Speed",
				ChangeValue = 0.7,
				ChangeType = "Multiply",
			},
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "ReturnToOwnerSpeed",
				ChangeValue = 1200,
			},
			{
				TraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchSupayBallEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "ProjectileTorchWaveReturn_Supay",
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
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponTorch", },
				IsNone = {"TorchAutofireAspect", }
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
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponTorch", },
				IsNone = {"TorchAutofireAspect", }
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
				Multiplier = 35/25,
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
			LifetimeMultiplier = { BaseValue = 0.25 },
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
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponTorch", },
				IsNone = {"TorchDetonateAspect", "TorchSprintRecallAspect" }
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
			ValidProjectiles = { "ProjectileTorchBall", "ProjectileTorchWave", "ProjectileTorchGhost", "ProjectileTorchGhostLarge", "ProjectileTorchBallEos", "ProjectileTorchSupayBallEx", },
			Args = 
			{
				UseOriginalProjectileForPropertyChanges = true,
				IgnoreImpactId = true,
				MatchProjectileName = false,
				IgnoreAdvancedSplitValidity = true,
				SpawnCount = 2,
				SpawnArc = 60,
				ProjectileCapFunctionName = "GetTorchSplitProjectileCap",
				ProjectileNameMapIgnores = 
				{
					ProjectileTorchBallEos = "TorchSprintRecallAspect",
				},
				ProjectileNameMap = 
				{
					ProjectileTorchBall = "ProjectileTorchBallSplit",
					ProjectileTorchWave = "ProjectileTorchWaveSplit",
					ProjectileTorchGhost = "ProjectileTorchGhostSplit",
					ProjectileTorchGhostLarge = "ProjectileTorchGhostLargeSplit",
					ProjectileTorchSupayBallEx = "ProjectileTorchSupayBallExSplit",
				},
				TraitDependentProperties = 
				{
					TorchEnhancedAttackTrait = 
					{
						UnlimitedUnitPenetration = true
					}
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
			ValidWeapons = { "WeaponTorch" },
			ValidBaseDamageAddition = { BaseValue = 10 },
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
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_33",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
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
				WeaponName = "WeaponTorchSpecial",
				ProjectileProperty = "Speed",
				BaseValue = 1.2,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				ReportValues = { ReportedMoveSpeedBonus = "ChangeValue"},
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
			FlatDamageToArmor = 100,
			ValidWeapons = { "WeaponTorchSpecial" },
			ReportValues = { ReportedWeaponMultiplier = "FlatDamageToArmor"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageBonus",
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
				ProjectileProperty = "Speed",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedRangeIncrease = "ChangeValue" },
			},
			{
				WeaponName = "WeaponTorch",
				WeaponProperty = "AutoLockRange",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchWave",
				ProjectileProperty = "Fuse",
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
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponTorch", },
				IsNone = {"TorchAutofireAspect", }
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
		AutofireOmegaSpeedMultiplier = { BaseValue = 0.8, SourceIsMultiplier = true },
		PropertyChanges =
		{ 
			{
				FalseTraitName = "TorchAutofireAspect",
				WeaponName = "WeaponTorch",
				WeaponProperty = "Cooldown",
				BaseValue = 0.8,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponTorch",
				EffectName = "TorchAttackChargeSpeed",
				EffectProperty = "Modifier",
				BaseValue = 0.2,
				ChangeType = "Add",
				ReportValues = { ReportedSpeedBonus= "ChangeValue" }
			},
			{
				WeaponName = "WeaponTorch",
				EffectName = "TorchAttackFireSpeed",
				EffectProperty = "Modifier",
				BaseValue = 0.2,
				ChangeType = "Add",
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
				Format = "Percent"
			},
		},
	},

	TorchAutofireSprintTrait = 
	{
		InheritFrom = { "WeaponTrait", "TorchHammerTrait" },
		Icon = "Hammer_Torch_43",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponTorch", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponTorch", },
				IsAny = {"TorchAutofireAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchAutofireAspect" }
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
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			SprintActiveBaseDamage = { BaseValue = 5, AsInt = true},
			ReportValues = { ReportedDamage = "SprintActiveBaseDamage"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
		},

	}
})