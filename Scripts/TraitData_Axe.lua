OverwriteTableKeys( TraitData, {
	-- Axe
	AxeSturdyTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_38",
		RequiredWeapon = "WeaponAxe",
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_32",
		RequiredWeapon = "WeaponAxe",
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_36",
		RequiredWeapon = "WeaponAxe",
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
		
		--[[
		WeaponDataOverride =
		{
			WeaponAxeSpecialSwing = 
			{
				OnFiredFunctionName = "RevertWeaponChanges",
			},
			WeaponAxeBlock2 = 
			{
				OnChargeFunctionNames = { "DoWeaponCharge", "CheckAxeBlockThread" },
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 25,
						Wait = 1.25,
						SwapWeapon = "null",
						SkipManaSpendOnFire = true,
						DeferSwap = "WeaponAxeSpecialSwing",
						ChannelSlowEventOnStart = true,
						ForceRelease = false,
						ForceReleaseWithoutMana = true,
						ReportValues = 
						{
							ReportedBaseManaCost = "ManaCost",
						}					
					},
					{ 
						ManaCost = 40,
						Wait = 0.6,
						ResetIndicator = true,
						SkipManaSpendOnFire = true,
						SwapWeapon = "null",
						DeferSwap = "WeaponAxeSpecialSwing",
						ForceRelease = true,
						WeaponProperties = {
							NumProjectileWaves = 2,
							ProjectileWaveInterval = 0.2,
												
							ReportValues = 
							{
								ReportedWeaponWaves = "NumProjectileWaves",
							}
						},					
						ReportValues = 
						{
							ReportedManaCost = "ManaCost",
						}
					}
				},
			}
			]]
			PropertyChanges =
			{
				{
					WeaponName = "WeaponAxeSpecialSwing",
					WeaponProperty = "NumProjectileWaves",
					ChangeValue = 2,
					ChangeType = "Absolute",
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
				Key = "ReportedBaseManaCost",
				ExtractAs = "BaseManaCost",
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_29",
		RequiredWeapon = "WeaponAxe",
		OnBlockDamageFunction = 
		{
			Name = "AddBlockEmpower",
			Args =
			{
				WeaponName = "WeaponAxeBlock2",
				EffectName = "BlockEmpower",
				EffectData = 
				{
					Duration = 15,
					Modifier = 1.50,
					
					ReportValues = 
					{ 
						ReportedMultiplier = "Modifier", 
						ReportedDuration = "Duration" 
					},
				}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
		}
	},
	AxeConsecutiveStrikeTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_31",	
		RequiredWeapon = "WeaponAxe",
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileProperties = 
				{
					ConsecutiveHitWindow = 0.25,
					DamagePerConsecutiveHit = 2,
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
	AxeArmorTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_27",
		RequiredWeapon = "WeaponAxe",
		AddOutgoingDamageModifiers =
		{
			NonExHealthBufferRemoval = 0.20,
			ValidWeapons = { "WeaponAxeBlock2" },
			ReportValues = { ReportedWeaponMultiplier = "NonExHealthBufferRemoval"},
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
	AxeFreeSpinTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_33",	
		RequiredWeapon = "WeaponAxe",
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
			WeaponAxeBlock2 = 
			{
				ExpireProjectilesOnFire = {},
			},
			WeaponAxeDash = 
			{
				ExpireProjectilesOnFire = {},
			},
			WeaponSpellLeap = 
			{
				ExpireProjectilesOnFire = {},
			},
		},
		ChargeStageModifiers = 
		{
			WeaponNames = { "WeaponAxeSpin"},
			ChangeNumProjectilesToFuse = true,
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperties = 
				{
					FireGraphic = "Melinoe_Axe_AttackEx1_End",
					FireEndGraphic = "null",
					RemoveControlOnCharge = "null"
				},
				ProjectileProperties = 
				{
					ExpandBlastDuringDetonation = true,
					MultiDetonate = true,
					FuseStart = 0,
					TotalFuse = 20,
					Fuse = 0.22,
					IgnoreCancelAttachedProjectiles = true,
				},
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_35",
		RequiredWeapon = "WeaponAxe",
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.80,
				SourceIsMultiplier = true,
			},
			ValidWeapons = { "WeaponAxeSpin"},
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		AddRush = 
		{
			FunctionName = "BlockWhirlwindDisable",
		},
		ChargeStageModifiers = 
		{
			WeaponNames = { "WeaponAxeSpin"},
			ChangeNumProjectilesToFuse = true,
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxeSpin",
				ProjectileProperties = 
				{
					ExpandBlastDuringDetonation = true,
					MultiDetonate = true,
					Speed = 500,
					Acceleration = -200,
					Range = 900,
					AttachToOwner = false,
					FuseStart = 0,
					TotalFuse = 20,
					Fuse = 0.22,
				},
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
	AxeSpinSpeedTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_37",
		RequiredWeapon = "WeaponAxe",
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
				ChangeValue = 1.5,
				ChangeType = "Multiply",
				ReportValues = { ReportedSpeedIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "IndependentAxeSpinSelfFireSlow",
				EffectProperty = "Modifier",
				ChangeValue = 1.5,
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_30",
		RequiredWeapon = "WeaponAxe",
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
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.75,
				ChangeType = "Multiply",
				ReportValues = { ReportedSpeedIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "ProjectileInterval",
				ChangeValue = 0.75,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "ChargeStartAnimation",
				ChangeValue = "Melinoe_Axe_SpecialEx1_Start_Fast",
				ChangeType = "Absolute",
			},
			{
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_28",
		RequiredWeapon = "WeaponAxe",
		IsLastPriorityHammerTrait = true,
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponAxe", "WeaponAxe2", "WeaponAxe3", "WeaponAxeDash" },
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.7,
				ChangeType = "Multiply",
				ReportValues = { ReportedSpeedIncrease = "ChangeValue"},
			},
			{
				WeaponName = "WeaponAxe",
				WeaponProperty = "ChargeStartAnimation",
				ChangeValue = "Melinoe_Axe_Attack1_Start_Fast",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				WeaponProperty = "ChargeStartAnimation",
				ChangeValue = "Melinoe_Axe_Attack2_Start_Fast",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				WeaponProperty = "ChargeStartAnimation",
				ChangeValue = "Melinoe_Axe_Attack4_Start_Fast",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_39",
		RequiredWeapon = "WeaponAxe",
		SetupFunction =
		{
			Name = "PermanentSwitchWeapon",
			Args = "WeaponAxe3",
			RunOnce = true
		},
		ReplaceMeleeWeapon = "WeaponAxe3",
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
				ProjectileProperties = 
				{
					Damage = 300,
					ReportValues = { ReportedDamage = "Damage" },
				}
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
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Axe_34",
		RequiredWeapon = "WeaponAxe",
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxe3",
				WeaponProperties = 
				{
					NumProjectiles = 2,
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
})