OverwriteTableKeys( TraitData, {
	-- Axe
	AxeHammerTrait = 
	{
		CodexWeapon = "WeaponAxe",
		DebugOnly = true,
	},
	AxeSturdyTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_38",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
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
		OnWeaponChargeFunctions = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "StartAxeSturdy",
			FunctionArgs =
			{
				DamageTakenModifier = 0.8,
				ReportValues = 
				{ 
					ReportedSturdyModifier = "DamageTakenModifier" 
				},
			},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "EndAxeSturdy",
		},
		OnWeaponChargeCanceledFunctions = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "EndAxeSturdy",
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
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageBonus",
			},
			{
				Key = "ReportedSturdyModifier",
				ExtractAs = "SturdyModifier",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
		},
	},

	AxeDashAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_32",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
			},
		},
		--[[
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 3.0,
				SourceIsMultiplier = true,
			},
			ValidWeapons = { "WeaponAxeDash" },
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		]]
		PropertyChanges =
		{	
			--[[
			{
				WeaponName = "WeaponAxeDash",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.5,
				ChangeType = "Multiply",
				ReportValues = { ReportedChange = "ChangeValue" }
			}
			]]
			{
				WeaponName = "WeaponAxeDash",
				WeaponProperty = "NumProjectiles",
				ChangeValue = 2,
				ChangeType = "Absolute",
				ReportValues = { ReportedChange = "ChangeValue" }
			},
			{
				WeaponName = "WeaponAxeDash",
				WeaponProperty = "ProjectileInterval",
				ChangeValue = 0.15,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeDash",
				WeaponProperty = "ProjectileIntervalStart",
				ChangeValue = 0.15,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeDash",
				ProjectileProperty = "DamageRadius",
				ChangeValue = 380,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeDash",
				ProjectileProperty = "BlastSpeed",
				ChangeValue = 3000,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeDash",
				ProjectileProperty = "Fuse",
				ChangeValue = 0,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponAxeDash",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "AxeNova_AxeDashAttack",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeDash",
				EffectName = "OnHitStunHeavy",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedChange",
				ExtractAs = "HitCount",
				--Format = "PercentDelta",
			},
		},
	},
	AxeSecondStageTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_36",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
			},
		},
		ManaCostModifiers = 
		{
			WeaponNames = { "WeaponAxeSpecialSwing" },
			ExWeapons = true,
			ManaCostAdd = { BaseValue = 15 },
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},

		NumWaves = 2, -- used only for text
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "NumProjectileWaves",
				ChangeValue = 1,
				ChangeType = "Add",
				ReportValues = { ReportedChange = "ChangeValue" }
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "ProjectileWaveInterval",
				ChangeValue = 0.2,
				ChangeType = "Absolute",
			},
		},

		ExtractValues =
		{
			{
				Key = "ReportedChange",
				ExtractAs = "Count",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedCost",
				ExtractAs = "ManaCost",
				--Subtractor = "BaseManaCost",
				IncludeSigns = true,
			},
		}
	},
	AxeBlockEmpowerTrait =
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_29",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
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
				Multiplier = 2.0/1.5,
			},
		},
		AddOutgoingDamageModifiers =
		{
			NonExMultiplier =
			{
				BaseValue = 2.5,
				SourceIsMultiplier = true,
			},
			ValidWeapons = { "WeaponAxeSpecial"},
			ReportValues = { ReportedWeaponMultiplier = "NonExMultiplier"},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxeSpecial",
				WeaponProperties = 
				{
					FireFx = "null",
				},
				ProjectileProperties = 
				{
					StartFx = "AxeSpinDouble",
					Speed = 3000,
					Acceleration = 0,
					Range = 1500,
					AttachToOwner = false,
				},
				ExcludeLinked = true
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta",
			},
		}
	},
	AxeArmorTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_27",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
			},
		},
		AddOutgoingDamageModifiers =
		{
			NonExFlatDamageToArmor = 300,
			ValidWeapons = { "WeaponAxeSpecial" },
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
	AxeFreeSpinTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_33",	
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
			},
		},
		WeaponDataOverride = 
		{
			WeaponBlink = 
			{
				ExpireProjectilesOnFire = {},
			},
			WeaponAxe = 
			{
				ExpireProjectilesOnFire = {},
			},
			WeaponAxe2 = 
			{
				ExpireProjectilesOnFire = {},
			},
			WeaponAxe3 = 
			{
				ExpireProjectilesOnFire = {},
			},
			WeaponAxe4 = 
			{
				ExpireProjectilesOnFire = {},
			},
			WeaponAxe5 = 
			{
				ExpireProjectilesOnFire = {},
			},
			WeaponAxeBlock2 = 
			{
				ExpireProjectilesOnFire = {},
			},
			WeaponAxeDash = 
			{
				ExpireProjectilesOnFire = {},
			},
			WeaponAxeSpin = 
			{
				ExpireProjectilesOnFire = {"ProjectileAxeSpin"},
			},
			WeaponSpellLeap = 
			{
				ExpireProjectilesOnFire = {},
			},
		},
		ChargeStageModifiers = 
		{
			FalseTraitName = "AxeRallyAspect",
			WeaponNames = { "WeaponAxeSpin"},
			ChangeNumProjectilesToFuse = true,
			AddWeaponProperties = 
			{
					FireEndGraphic = "null",
			}
		},
		PropertyChanges =
		{
			{
				FalseTraitName = "AxeRallyAspect",
				WeaponName = "WeaponAxeSpin",
				ProjectileProperties = 
				{
					ExpandBlastDuringDetonation = true,
					MultiDetonate = true,
					FuseStart = 0,
					TotalFuse = 20,
					Fuse = 0.22,
				},
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperties = 
				{
					FireGraphic = "Melinoe_Axe_AttackEx1_End",
					RemoveControlOnCharge = "null",
					RemoveControlOnCharge2 = "null",
				},
			},
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileProperty = "IgnoreCancelAttachedProjectiles",
				ChangeValue = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "AxeSpinAttackDisable",
				EffectProperty = "Active",
				ChangeValue = false,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "AxeSpinAttackDisableCancellable",
				EffectProperty = "Active",
				ChangeValue = false,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "AxeSpinMoveStop",
				EffectProperty = "Active",
				ChangeValue = false,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "AxeSpinSelfFireSlow",
				EffectProperty = "Active",
				ChangeValue = false,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "IndependentAxeSpinAttackDisable",
				EffectProperty = "Active",
				ChangeValue = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "IndependentAxeSpinAttackDisableCancellable",
				EffectProperty = "Active",
				ChangeValue = true,
			},
			--[[
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "IndependentAxeSpinMoveStop",
				EffectProperty = "Active",
				ChangeValue = true,
			},
			]]
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "IndependentAxeSpinSelfFireSlow",
				EffectProperty = "Active",
				ChangeValue = true,
			},
		}
	},
	AxeRangedWhirlwindTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_35",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
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
				Multiplier = 80/60,
			},
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = { "WeaponAxe", "WeaponAxe2", "WeaponAxe3", "WeaponAxe4" , "WeaponAxe5", "WeaponAxeDash"  },
			ExcludeLinked = true,
			FunctionName = "CheckAxeNova",
			FunctionArgs = 
			{
				ProjectileName = "HammerAxeNova",
				DamageMultiplier = { BaseValue = 1 },
			}
		},
		OnProjectileCreationFunction = 
		{
			ValidProjectiles = { "ProjectileAxeSpin" },
			Name = "CheckAxeNova",
			Args = 
			{
				ProjectileName = "HammerAxeNova",
				DamageMultiplier = { BaseValue = 1 },
				ReportValues = { ReportedMultiplier = "DamageMultiplier" }
			}
		},
		PropertyChanges = 
		{
			{
				TraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				ProjectileProperty = "SpawnOnDetonate",
				ChangeValue = "HammerAxeNova",
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "HammerAxeNova",
				BaseProperty = "Damage",
			},
		}
	},

	AxeSpinSpeedTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_37",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
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
				Multiplier = 0.6/0.5,
			},
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = { "WeaponAxeSpin" },
			Value = 
			{
				BaseValue = 0.5,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedSpinTime = "Value" }
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "AxeSpinSelfFireSlow",
				EffectProperty = "Modifier",
				BaseValue = 1.5,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				ReportValues = { ReportedSpeedIncrease = "ChangeValue" },
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "IndependentAxeSpinSelfFireSlow",
				EffectProperty = "Modifier",
				BaseValue = 1.5,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpinTime",
				ExtractAs = "SpinTime",
				Format = "NegativePercentDelta",
				SkipAutoExtract = true
			},
			{
				Key = "ReportedSpeedIncrease",
				ExtractAs = "SpeedIncrease",
				Format = "PercentDelta"
			},
		}
	},

	AxeChargedSpecialTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_30",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
			},
		},
		--[[
		WeaponSpeedMultiplier =
		{
			WeaponNames = { "WeaponAxeBlock2" },
			Value = 
			{
				BaseValue = 0.6,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedSpeedIncrease = "Value" }
		},
		]]
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Legendary = 
			{
				Multiplier = 0.70/0.75,
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "ChargeTime",
				BaseValue = 0.75,
				ChangeType = "Multiply",
				ReportValues = { ReportedSpeedIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "ProjectileInterval",
				BaseValue = 0.75,
				ChangeType = "Multiply",
			},
			{
				FalseTraitName = "AxeRallyAspect",
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "ChargeStartAnimation",
				ChangeValue = "Melinoe_Axe_SpecialEx1_Start_Fast",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "AxeRallyAspect",
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "FireGraphic",
				ChangeValue = "Melinoe_Axe_SpecialEx1_Fire_Fast",
				ChangeType = "Absolute",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpeedIncrease",
				ExtractAs = "SpeedIncrease",
				Format = "NegativePercentDelta"
			},
		},
	},
	AxeAttackRecoveryTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_28",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
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
				Multiplier = 0.6/0.7,
			},
		},
		IsLastPriorityHammerTrait = true,
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponAxe", "WeaponAxe2", "WeaponAxe3", "WeaponAxeDash" },
				WeaponProperty = "ChargeTime",
				BaseValue = 0.7,
				ChangeType = "Multiply",
				ReportValues = { ReportedSpeedIncrease = "ChangeValue"},
			},
			{
				FalseTraitName = "AxeRallyAspect",
				WeaponName = "WeaponAxe",
				WeaponProperty = "ChargeStartAnimation",
				ChangeValue = "Melinoe_Axe_Attack1_Start_Fast",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "AxeRallyAspect",
				WeaponName = "WeaponAxe2",
				WeaponProperty = "ChargeStartAnimation",
				ChangeValue = "Melinoe_Axe_Attack2_Start_Fast",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "AxeRallyAspect",
				WeaponName = "WeaponAxe3",
				WeaponProperty = "ChargeStartAnimation",
				ChangeValue = "Melinoe_Axe_Attack4_Start_Fast",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "AxeRallyAspect",
				WeaponName = "WeaponAxeDash",
				WeaponProperty = "ChargeStartAnimation",
				ChangeValue = "Melinoe_Axe_Attack3_Start_Fast",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxe2" },
				WeaponProperty = "ControlWindow",
				ChangeValue = 0.7,
				ChangeType = "Multiply",
			},
			{
				WeaponNames = { "WeaponAxe3" },
				WeaponProperty = "ControlWindow",
				ChangeValue = 0.7,
				ChangeType = "Multiply",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpeedIncrease",
				ExtractAs = "SpeedIncrease",
				Format = "NegativePercentDelta"
			},
		}
	},
	AxeThirdStrikeTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_39",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponAxe", },
				IsNone = {"AxeRallyAspect", }
			},
		},
		SetupFunction =
		{
			Name = "PermanentSwitchWeapon",
			Args = "WeaponAxe3",
			RunOnce = true
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 400/300,
			},
		},
		ReplaceMeleeWeapon = "WeaponAxe3",
		PrevNumStrikes = 3, -- used only for text
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxe3",
				WeaponProperties = 
				{
					ControlWindow = 0,
					FullyAutomatic = false,
				    AddOnFire = "WeaponAxeSpin"
				},
			},
			{
				WeaponName = "WeaponAxe3",
				ProjectileProperty = "Damage",
				BaseValue = "300",
				ExcludeLinked = true,
				ReportValues = { ReportedDamage = "ChangeValue" },
			},
			{
				WeaponName = "WeaponAxeDash",
				WeaponProperty = "SwapOnFire",
				ChangeValue = "WeaponAxe3",
				ExcludeLinked = true,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
		}
	},
	AxeMassiveThirdStrikeTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_34",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponAxe", },
				IsNone = {"AxeRallyAspect", }
			},
		},
		WeaponDataOverride = 
		{
			WeaponAxe3 = 
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
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxe3",
				WeaponProperties = 
				{
					NumProjectiles = 2,
					ProjectileIntervalStart = 0.08,
					ProjectileInterval = 0.08,
					ReportValues = { ProjectileCount = "NumProjectiles" },
					ChargeCancelGraphic = "Melinoe_Axe_Attack4_Cancel",
				},
				ExcludeLinked = true,
				
			},
		},
		ManaCostModifiers = 
		{
			ExcludeLinked = true,
			WeaponNames = { "WeaponAxe3" },
			ManaCostAdd = 20,
			ReportValues = { ReportedManaCost = "ManaCostAdd" }
		},
		ExtractValues =
		{
			{
				Key = "ProjectileCount",
				ExtractAs = "HitCount",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "Mana",
			},
		}
	},

	AxeRallyFirstStrikeTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_45",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponAxe", },
				IsAny = {"AxeRallyAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRallyAspect" }
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxe",
				WeaponProperties = 
				{
					NumProjectiles = 2,
					ProjectileIntervalStart = 0.08,
					ProjectileInterval = 0.08,
					SwapOnFire = "null"
				},
				ExcludeLinked = true,
			},
		},
		PrevNumStrikes = 5,
	},
	AxeRallyFrenzyTrait = 
	{
		InheritFrom = { "WeaponTrait", "AxeHammerTrait" },
		Icon = "Hammer_Axe_44",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponAxe", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponAxe", },
				IsAny = {"AxeRallyAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRallyAspect" }
			},
		},
		ReportedBaseLifeStealAmount = 1,
		FrenzyDurationBonus = { BaseValue = 2 },
		FrenzyLifestealBonus = { BaseValue = 1 },
		ExtractValues =
		{
			{
				Key = "FrenzyLifestealBonus",
				ExtractAs = "ReportedFrenzyBonusLifeStealAmount",
				SkipAutoExtract = true,
			},
			{
				Key = "FrenzyDurationBonus",
				ExtractAs = "ReportedBonusDuration",
				SkipAutoExtract = true,
			},
			{
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "Frenzy",
				BaseProperty = "BaseLifeSteal",
				ExtractAs = "FrenzyLifeStealAmount",
			},
			{
				ExtractAs = "FrenzyDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "Frenzy",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "ReportedSpeed",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "Frenzy",
				Format = "PercentReciprocalDelta",
				BaseProperty = "Modifier",
			},
		}
	},
})