TraitSetData.MetaUpgrade =
{

	-- Base MetaUpgradeTraits
	MetaUpgradeTrait = 
	{
		MetaUpgrade = true,
		Hidden = true,
		Icon = "Membership_Card",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 2
			},
			Epic =
			{
				Multiplier = 3
			},
			Heroic =
			{
				Multiplier = 4
			},
		},
	},
	
	ManaInsideCastTrait = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		Hidden = false,
		SetupFunction =
		{
			Name = "InCastCircleManaRegenSetup",
			RunOnce = true
		},
		CastCircleManaRegen = { BaseValue = 5 },
		ExtractValues =
		{
			{
				Key = "CastCircleManaRegen",
				ExtractAs = "TooltipManaRecovery",
				DecimalPlaces = 1,
			},
		
		},
		
	},

	--[[
	ManaOnCastTrapMetaUpgrade = 
	{
		InheritFrom = {"ManaTrait"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 2.0,
			},
			Rare =
			{
				Multiplier = 3.0,
			},
			Epic =
			{
				Multiplier = 4.0,
			},
			Heroic =
			{
				Multiplier = 5.0,
			},
		},
	
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckManaOnHit",
			Args = 
			{
				FirstHitOnly = true,
				ValidWeapons = WeaponSets.HeroNonPhysicalWeapons,
				ManaGain = { BaseValue = 1 },
				ReportValues = { ReportedManaRecovery = "ManaGain" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "TooltipManaRecovery",
				DecimalPlaces = 1,
			},
		}
	},
	]]

	--[[
	CastChannelSlowMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 1.17,
				MaxMultiplier = 1.17,
			},
			Epic =
			{
				MinMultiplier = 1.34,
				MaxMultiplier = 1.34,
			},
		},

		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				ExcludeProjectileName = "PoseidonPuddle",
				WeaponProperties = 
				{
					ChargeStartFx = "ShieldCharge",
					ChargeStartAnimation = "Melinoe_Cast_Start",
					FireGraphic = "Melinoe_Cast_Fire",
					FireOnRelease = true,
					FullyAutomatic = true,
					TargetReticleAnimation = "CastCircleReticle",
					ShowFreeAimLine = true,
					AimLineAnimation = "null",
					ManualAiming = true,
					ChargeTime = 0.1,
					ManualAimingInitialOffset = 0,
					AllowMultiFireRequest = false,
				},
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					UseStartLocation = false,
					Range = 360,
				}
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastAimSlow",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastStop",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastSelfSlow2",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
		},	
		OnWeaponChargeFunctions =
		{
			ValidWeapons = { "WeaponCast" },
			FunctionName = "CheckWeaponCastChannelSlow",
			FunctionArgs =
			{
				Modifier = { BaseValue = 0.4, SourceIsMultiplier = true },
				ReportValues = { ReportedSlow = "Modifier" }
			},
		},
		WeaponDataOverride =
		{
			WeaponCast =
			{

				HitScreenshake = {},
				HitSimSlowParameters =
				{
				},

				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/SFX/Player Sounds/MelMagicalCharge", StoppedBy = { "ChargeCancel", "Fired" } },
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteCasting" },
						{ Name = "/Leftovers/SFX/WyrmCastAttack" },
					},
				},
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSlow",
				ExtractAs = "TooltipSlow",
				Format = "NegativePercentDelta",
			},
		},
	},
	]]

	ChannelSlowMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{

			Common =
			{
				Multiplier = 1.0
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2.0
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},
		
		OnWeaponChargeFunctions =
		{
			ValidWeapons = { "WeaponStaffSwing5", "WeaponDagger5", "WeaponStaffBall", "WeaponDaggerThrow", "WeaponAxeSpin", "WeaponTorch", "WeaponTorchSpecial", "WeaponLob", "WeaponLobSpecial", "WeaponCastArm", "WeaponCastProjectileHades", "WeaponCastProjectile", "WeaponAnywhereCast" },
			FunctionName = "CheckWeaponCastChannelSlow",
			FunctionArgs =
			{
				Modifier = 0.20,
				Duration = { BaseValue = 2.0 },
				ReportValues = { ReportedSlow = "Modifier", ReportedSlowDuration = "Duration" }
			},
			ExcludeLinked = true,
		},
		
		--[[
		WeaponDataOverride =
		{
			WeaponStaffBall2 =
			{
				OnChargeFunctionName = "StartWeaponSlowMotion",
				OnChargeFunctionArgs = { Modifier = 0.1,  VignetteFadeInDuration = 0.15 },
			},
		},
		]]
		ExtractValues =
		{
			{
				Key = "ReportedSlow",
				ExtractAs = "TooltipSlow",
				Format = "NegativePercentDelta",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedSlowDuration",
				ExtractAs = "TooltipSlowDuration",
			},
		},
	},
	--[[
	RandomWitchMarkMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		Hidden = false,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 2,
			},
			Epic =
			{
				Multiplier = 3,
			}
		},
		OnExpire = 
		{
			FunctionName = "GrantRandomManaTrait",
			FunctionArgs = 
			{
				RarityBonus = { BaseValue = 1 },
				ReportValues = { ReportedRarityBonus = "RarityBonus" }
			}
		},
		RemainingUses = 3,
		UsesAsEncounters = true,
		ExtractValues =
		{
			{
				Key = "RemainingUses",
				ExtractAs = "Encounters",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedRarityBonus",
				ExtractAs = "RarityValue",
				Format = "Rarity",
			}
		},
	},
	]]
	ManaOverTimeMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait", "ManaOverTimeSource"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 3.0,
			},
		},
		SetupFunction =
		{
			Name = "ManaRegenSetup",
			Args =
			{
				Name = "ManaOverTimeMetaUpgrade",
				ManaRegenPerSecond = { BaseValue = 2 },
				ReportValues = { ReportedManaRecovery = "ManaRegenPerSecond" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "TooltipManaRecovery",
				DecimalPlaces = 1,
			},
		},
	},

	DoorHealMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		ShowLowHealthIndicator = true,
		DoorHealThreshold = 
		{
			FixedHeal = { BaseValue = 2 },
			HealthFraction = 0.3,
			HealthFractionMultiplier = 2,
			ReportValues = 
			{
				Heal = "FixedHeal",
				HealthThreshold = "HealthFraction",
				HealthThresholdMultiplier = "HealthFractionMultiplier",
			}
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},
		ExtractValues =
		{
			{
				Key = "Heal",
				ExtractAs = "TooltipHealthRecovery",
				DecimalPlaces = 1,
			},
			{
				Key = "HealthThreshold",
				ExtractAs = "TooltipThreshold",
				Format = "Percent",
				SkipAutoExtract = true,
			},
		},
	},
	InsideCastBuffMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.25
			},
			Epic =
			{
				Multiplier = 1.5
			},
			Heroic =
			{
				Multiplier = 1.75
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeaponMultiplier = { BaseValue = 1.2, SourceIsMultiplier = true },
			ValidActiveEffects = {"ImpactSlow"},
			ReportValues = { ReportedModifier = "ValidWeaponMultiplier" }
		},
		ExtractValues =
		{
			{
				Key = "ReportedModifier",
				ExtractAs = "TooltipMultiplier",
				Format = "PercentDelta"
			},
		},

	},

	--[[
	OnSpendManaBuffMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 1.34,
				MaxMultiplier = 1.34,
			},
			Epic =
			{
				MinMultiplier = 1.67,
				MaxMultiplier = 1.67,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			RequiredSelfEffectsMultiplier = { BaseValue = 1.3, SourceIsMultiplier = true },
			RequiredEffects = {"ManaSpendBuff"},
			ReportValues = { ReportedModifier = "RequiredSelfEffectsMultiplier" }
		},
		OnManaSpendAction = 
		{
			EffectName = "ManaSpendBuff",
			Args = {
				Duration = 7,
				ReportValues = { ReportedDuration = "Duration" }
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedModifier",
				ExtractAs = "TooltipMultiplier",
				Format = "PercentDelta"
			},
		},
	
	},
	]]

	SorcerySpeedMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		SpellModifier = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.25
			},
			Epic =
			{
				Multiplier = 1.5
			},
			Heroic =
			{
				Multiplier = 1.75
			},
		},
		PropertyChanges =
		{
			{
				WeaponNames = WeaponSets.HeroSpellWeapons,
				WeaponProperty = "ClipRegenInterval",
				BaseValue = 0.9,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				ReportValues = { ReportedReduction = "ChangeValue" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedReduction",
				ExtractAs = "TooltipMultiplier",
				Format = "NegativePercentDelta"
			},
		},
	},

	LowManaDamageMetaupgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0.6,
			},
			Rare =
			{
				Multiplier = 0.8,
			},
			Epic =
			{
				Multiplier = 1.0,
			},
			Heroic =
			{
				Multiplier = 1.2,
			},
		},
		
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			LowManaThreshold = 0.99,
			-- next line used for trait text
			FullManaThreshold = 100,
			NonExLowManaDamageMultiplier = 
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
			},
			ReportValues = 
			{ 
				ReportedThreshold = "LowManaThreshold",
				ReportedDamageBoost = "NonExLowManaDamageMultiplier",
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "DamageBoost",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedThreshold",
				ExtractAs = "ManaThreshold",
				Format = "Percent",
				SkipAutoExtract = true,
			},
		}
	},
	
	DashSpeedMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},

		PropertyChanges =
		{
			{
				WeaponName = "WeaponBlink",
				WeaponProperty = "ChargeTime",
				BaseValue = 0.9,
				ChangeType = "Multiply",
				SourceIsMultiplier = true,
				ReportValues = { ReportedSpeedBonus = "ChangeValue" }
			},
			{
				UnitProperty = "Speed",
				BaseValue = 1.1,
				ChangeType = "Multiply",
				SourceIsMultiplier = true,

			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedSpeedBonus",
				ExtractAs = "DashSpeed",
				Format = "NegativePercentDelta",
			},
		}
	},

	--[[
	SprintDodgeMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },

		OnWeaponChargeFunctions = 
		{
			ValidWeapons = { "WeaponBlink" },
			FunctionName = "StartWeaponSlowMotion",
			FunctionArgs =
			{
				Modifier = 0.4,
				Duration = 0.4,	
			},
		},	

		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.00,
				MaxMultiplier = 1.00,
			},
			Rare =
			{
				MinMultiplier = 1.5,
				MaxMultiplier = 1.5,
			},
			Epic =
			{
				MinMultiplier = 2,
				MaxMultiplier = 2,
			},
		},

		PropertyChanges =
		{
			
			{
				WeaponName = "WeaponSprint",
				EffectName = "SprintDodge",
				EffectProperty = "Active",
				ChangeValue = true,
			},
			{
				WeaponName = "WeaponSprint",
				EffectName = "SprintDodge",
				EffectProperty = "DodgeChance",
				BaseValue = 0.20,
				ReportValues = { ReportedDodgeChance = "ChangeValue" },
			},
			{
				WeaponNames = { "WeaponSprint"},
				WeaponProperty = "SelfVelocity",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ExcludeLinked = true,
				ReportValues = { ReportedSprintBonus = "ChangeValue" },
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocityCap",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponBlink",
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.0,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponBlink",
				WeaponProperty = "BlockMoveInput",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponBlink",
				WeaponProperty = "CancelMovement",
				ChangeValue = true,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponBlink",
				WeaponProperty = "ChargeCancelMovement",
				ChangeValue = true,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponBlink",
				EffectName = "DashAttackQueue",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSprint",
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.19,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSprint",
				WeaponProperty = "MinChargeToFire",
				ChangeValue = 1.0,
				ChangeType = "Absolute",
			},

		},
		ExtractValues = 
		{
			{
				Key = "ReportedDodgeChance",
				ExtractAs = "DodgeChance",
				Format = "Percent",
			},
			{
				Key = "ReportedSprintBonus",
				ExtractAs = "SprintSpeed",
				Format = "PercentDelta",
				SkipAutoExtract = true
			},
		}
	},
	]]

	StartingGoldMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait"},

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.25
			},
			Epic =
			{
				Multiplier = 1.5
			},
			Heroic =
			{
				Multiplier = 1.75
			},
		},

		BonusMoney = { BaseValue = 200 },
		
		ExtractValues = 
		{
			{
				Key = "BonusMoney",
				ExtractAs = "StartingGold",
				IncludeSigns = true,
			},
		}
	},

	SprintShieldMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		--SprintShields = 1,
		--ActiveVfx = "EurydiceDefenseFront",

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2.00
			},
			Heroic =
			{
				Multiplier = 2.25
			},
		},

		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponSprint"},
				WeaponProperty = "SelfVelocity",
				BaseValue = 99,
				ChangeType = "Add",
				ExcludeLinked = true,
				ReportValues = { ReportedBaseSpeed = "ChangeValue" },
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocityCap",
				BaseValue = 44.5,
				ChangeType = "Add",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponBlink" },
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.066,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponBlink" },
				WeaponProperty = "ChargeFx",
				ChangeValue = "null",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponSprint",
				EffectName = "SprintMetaUpgradeAddedControl",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},

		},
		ExtractValues = 
		{
			{
				Key = "ReportedBaseSpeed",
				ExtractAs = "SprintSpeed",
				Format = "PercentOfBase",
				BaseType = "Weapon",
				BaseName = "WeaponSprint",
				BaseProperty = "SelfVelocity",
				DecimalPlaces = 1,
				HideSigns = true,
			},
			--[[
			{
				Key = "SprintShields",
				ExtractAs = "ShieldNum",
				SkipAutoExtract = true,
			}
			]]
		}
	},

	BossShieldMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		BossEncounterShieldHits = { BaseValue = 1 },
		BossShieldFx = "EurydiceDefenseFront",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 2
			},
			Epic =
			{
				Multiplier = 3
			},
			Heroic =
			{
				Multiplier = 4
			},
		},

		ExtractValues = 
		{
			{
				Key = "BossEncounterShieldHits",
				ExtractAs = "ShieldNum",
			}
		}
	},
	LastStandSlowTimeMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		AddMetaUpgradeLastStands = { BaseValue = 1 },
		ExtractValues = 
		{
			{
				Key = "AddMetaUpgradeLastStands",
				ExtractAs = "ReportedLastStands",
			},
			{
				External = true,
				BaseType = "HeroData",
				BaseName = "LastStandData",
				BaseProperty = "Duration",
				ExtractAs = "LastStandDuration",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "HeroData",
				BaseName = "LastStandData",
				BaseProperty = "Modifier",
				Format = "NegativePercentDelta",
				ExtractAs = "LastStandSlow",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "HeroData",
				BaseName = "LastStandData",
				BaseProperty = "Heal",
				Format = "Percent",
				ExtractAs = "LastStandHeal",
				SkipAutoExtract = true,
			},
		}
	},
	CastDamageMetaUpgrade = 
	{
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},
		InheritFrom = { "MetaUpgradeTrait" },
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = { "PoseidonCast" },
			ValidBaseDamageAddition = { BaseValue = 50 },
			ReportValues = { ReportedBonus = "ValidBaseDamageAddition" }
		},
		PropertyChanges =
		{	
			{
				WeaponNames = { "WeaponCast" },
				ProjectileProperty = "ArmedExpirationDamage",
				BaseValue = 50,
				ChangeType = "Add",
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedBonus",
				ExtractAs = "BonusDamage",
				IncludeSigns = true,
			},
		}
	},
	CastCountMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
	
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponCastProjectileHades", "WeaponCastProjectile", "WeaponCast", "WeaponAnywhereCast" },
				WeaponProperty = "ActiveProjectileCap",
				BaseValue = 1,
				ChangeType = "Add",
				ReportValues = { ReportedBonus = "ChangeValue" },
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedBonus",
				ExtractAs = "BonusCasts",
			},
		}
	},

	MagicCritMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 4/3,
			},
			Epic =
			{
				Multiplier = 5/3,
			},
			Heroic = 
			{
				Multiplier = 2,
			}
		},
		AddOutgoingCritModifiers =
		{
			IsEx = true,
			Chance = { BaseValue = 0.03 },
			ReportValues = { ReportedCritBonus = "Chance"}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCritBonus",
				ExtractAs = "CritBonusAmount",
				Format = "Percent",
			},
		}
	},

	--[[
	CastProtectionMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CastModifier = true,
		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				EffectName = "CastInvulnerable",
				EffectProperty = "Active",
				ChangeValue = true,
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "CastInvulnerable",
				EffectProperty = "Duration",
				BaseValue = 0.5,
				ChangeType = "Absolute",
				ReportValues = { ReportedTime = "ChangeValue" },
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedTime",
				ExtractAs = "ShieldTime",
				DecimalPlaces = 1,
			},
		}
	},
	]]
	
	ChamberHealthMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		PriorityDisplay = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 4/3,
			},
			Epic =
			{
				Multiplier = 5/3,
			},
			Heroic = 
			{
				Multiplier = 2,
			}
		},
		SetupFunction = 
		{
			RequiredContext = "EnterRoom",
			Threaded = true,
			Name = "RoomStatGrowth",
			Args = 
			{
				Amount = 5,
				MaxHealth =  { BaseValue = 3 },
				MaxMana = { BaseValue = 3 },
				ReportValues = 
				{ 
					ReportedGrowth = "MaxHealth", 
					BonusAmount = "Amount",
				},

			}
		},
		CurrentRoom = 0,
		ExtractValues = 
		{
			{
				Key = "ReportedGrowth",
				ExtractAs = "GrowthValue",
				IncludeSigns = true,
			},
			{
				Key = "BonusAmount",
				ExtractAs = "RoomInterval",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "MetaUpgradeRequirement",
				BaseName = "MaxHealthPerRoom",
				BaseProperty = "HasCostsThrough",
				ExtractAs = "Requirement",
				SkipAutoExtract = true,
			},
		},
	},

	--[[
	ChamberManaMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		PriorityDisplay = true,
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 1.2,
				MaxMultiplier = 1.2,
			},
			Epic =
			{
				MinMultiplier = 1.4,
				MaxMultiplier = 1.4,
			},
		},
		RoomsPerUpgrade = 
		{ 
			Amount = 3,
			MaxMana = { BaseValue = 5 },
			ReportValues = 
			{ 
				BonusAmount = "Amount", 
				ReportedGrowth = "MaxMana", 
			},
		},
		CurrentRoom = 0,
		ExtractValues = 
		{
			{
				Key = "BonusAmount",
				ExtractAs = "RoomInterval",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedGrowth",
				ExtractAs = "GrowthValue"
			}
		},
	},
	]]

	GhostRegenMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		OnShadeMercActivate = 
		{
			Health = {BaseValue = 1},
			Mana = {BaseValue = 5},
			ReportValues = 
			{ 
				ReportedHealth = "Health", 
				ReportedMana = "Mana", 
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedHealth",
				ExtractAs = "HealthRestore"
			},
			{
				Key = "ReportedMana",
				ExtractAs = "ManaRestore"
			}
		},
	},
	DoorRerollMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 2
			},
			Epic =
			{
				Multiplier = 3
			},
			Heroic =
			{
				Multiplier = 4
			},
		},
		RerollCount = { BaseValue = 1 },
		AllowDoorReroll = true,
		ExtractValues = 
		{
			{
				Key = "RerollCount",
				ExtractAs = "Rerolls",
				IncludeSigns = true,
			}
		},
	},
	PanelRerollMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 2
			},
			Epic =
			{
				Multiplier = 3
			},
			Heroic =
			{
				Multiplier = 4
			},
		},
		RerollCount = { BaseValue = 1 },
		ExtractValues = 
		{
			{
				Key = "RerollCount",
				ExtractAs = "Rerolls",
				IncludeSigns = true,
			}
		},
	},
	RerollTradeOffMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},
		RerollCount = { BaseValue = 2 },
		--[[
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				ChangeValue = -15,
				ChangeType = "Add",
				ReportValues = { ReportedHealthPenalty = "ChangeValue"}
			},
			{
				LuaProperty = "MaxMana",
				ChangeValue = -15,
				ChangeType = "Add",
				ReportValues = { ReportedManaPenalty = "ChangeValue"}
			},
		},
		]]
		ExtractValues = 
		{
			{
				Key = "RerollCount",
				ExtractAs = "Rerolls",
				IncludeSigns = true,
			},
			--[[
			{
				Key = "ReportedManaPenalty",
				ExtractAs = "ManaPenalty",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedHealthPenalty",
				ExtractAs = "HealthPenalty",
				SkipAutoExtract = true,
			},
			]]
		},
	},

	RarityBoostMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.34,
			},
			Epic =
			{
				Multiplier = 1.67,
			},
			Heroic = 
			{
				Multiplier = 2.00,
			}
		},
		RarityBonus =
		{
			Rare = { BaseValue = 0.30 },
			--Epic = { BaseValue = 0.20 },
			--Duo = { BaseValue = 0.50 },
			--Legendary = { BaseValue = 0.50 },
			ReportValues = { ReportedRarityBonus = "Rare"}			
		},
		ExtractValues = 
		{
			{
				Key = "ReportedRarityBonus",
				ExtractAs = "RarityBonus",
				Format = "Percent",
			},
		}
	},
	DuoRarityBoostMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00
			},
			Rare =
			{
				Multiplier = 1.34
			},
			Epic =
			{
				Multiplier = 1.67
			},
			Heroic =
			{
				Multiplier = 2.00
			},
		},
		RarityBonus =
		{
			Duo = { BaseValue = 0.06 },
			ReportValues = { ReportedRarityBonus = "Duo"}			
		},
		ExtractValues = 
		{
			{
				Key = "ReportedRarityBonus",
				ExtractAs = "RarityBonus",
				Format = "Percent",
			},
		}
	},
	EpicRarityBoostMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2.0
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},
		RarityBonus =
		{
			Epic = { BaseValue = 0.10 },
			ReportValues = { ReportedRarityBonus = "Epic"}			
		},
		ExtractValues = 
		{
			{
				Key = "ReportedRarityBonus",
				ExtractAs = "RarityBonus",
				Format = "Percent",
			},
		}
	},
	
	CritBonusMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},

		AddOutgoingCritModifiers =
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			Chance = { BaseValue = 0.1 },
			ReportValues = { ReportedCritBonus = "Chance"}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCritBonus",
				ExtractAs = "CritBonus",
				Format = "Percent",
			},
		},
	},
	
	DodgeBonusMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.34
			},
			Epic =
			{
				Multiplier = 1.67,
			},
			Heroic =
			{
				Multiplier = 2.00,
			},
		},
		PropertyChanges =
		{
			{
				LifeProperty = "DodgeChance",
				BaseValue = 0.06,
				ChangeType = "Add",
				DataValue = false,
				ReportValues = { ReportedDodgeBonus = "ChangeValue"}
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDodgeBonus",
				ExtractAs = "DodgeBonus",
				Format = "Percent",
			},
		},
	},

	HealthManaBonusMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 20,
				ChangeType = "Add",
				ReportValues = { ReportedHealthBonus = "ChangeValue"}
			},
			{
				LuaProperty = "MaxMana",
				BaseValue = 20,
				ChangeType = "Add",
				ReportValues = { ReportedManaBonus = "ChangeValue"}
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedManaBonus",
				ExtractAs = "ManaBonus",
				IncludeSigns = true,
			},
			{
				Key = "ReportedHealthBonus",
				ExtractAs = "HealthBonus",
				IncludeSigns = true,
			},
			--[[
			{
				External = true,
				BaseType = "MetaUpgradeRequirement",
				BaseName = "BonusHealth",
				BaseProperty = "HasCostsThrough",
				ExtractAs = "Requirement",
				SkipAutoExtract = true,
			},
			]]
		},
	},
	
	EffectVulnerabilityMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},

		AddOutgoingDamageModifiers =
		{
			MinRequiredVulnerabilityEffects = 2,
			VulnerabilityMultiplier = 
			{
				BaseValue = 1.25,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedDamageBoost = "VulnerabilityMultiplier"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "DamageBoost",
				Format = "PercentDelta",
			},
		}
	},
	TalentPointMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		TalentPointCount = { BaseValue = 1 },
		ExtractValues = 
		{
			{
				Key = "TalentPointCount",
				ExtractAs = "TalentPoints"
			}
		},
	},

	SorceryRegenMetaUpgrade = 
	{
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		InheritFrom = { "MetaUpgradeTrait" },
		SetupFunction =
		{
			Threaded = true,
			Name = "SorceryChargeSetup",
			Args =
			{
				ChargePerSecond = { BaseValue = 2 },
				ReportValues = { ReportedCharge = "ChargePerSecond" }
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCharge",
				ExtractAs = "ChargePerSecond"
			}
		},
	},

	LowHealthBuffMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 0.4/0.3,
			},
			Epic =
			{
				Multiplier = 0.5/0.3,
			},
			Heroic =
			{
				Multiplier = 0.6/0.3,
			},
		},
		CustomUpgradeText = "LowHealthBonus_Upgrade",
		ShowLowHealthIndicator = true,
		AddIncomingDamageModifiers = 
		{
			LowHealthThreshold = 0.3,
			LowHealthDamageTakenMultiplier = { BaseValue = 0.7, SourceIsMultiplier = true },
			ReportValues = 
			{ 
				ReportedThreshold = "LowHealthThreshold",
				ReportedLowHealthResistance = "LowHealthDamageTakenMultiplier",
			}

		},
		AddOutgoingDamageModifiers = 
		{
			LowHealthThreshold = 0.3,
			LowHealthDamageOutputMultiplier = { BaseValue = 1.3, SourceIsMultiplier = true },
			ValidWeapons = WeaponSets.HeroAllWeapons,
			ReportValues = { ReportedModifier = "LowHealthDamageOutputMultiplier" }
		},
		ExtractValues = 
		{
			{
				Key = "ReportedModifier",
				ExtractAs = "EnhanceMultiplier",
				Format = "FlatPercentDelta",
			},
			{
				Key = "ReportedLowHealthResistance",
				ExtractAs = "BlockMultiplier",
				Format = "FlatPercentDelta",
			},
			{
				Key = "ReportedThreshold",
				ExtractAs = "Threshold",
				Format = "Percent",
				SkipAutoExtract = true,
			}
		},
	},
	MetaToRunMetaUpgrade = 
	{
		InheritFrom = {"MetaUpgradeTrait" },
		MetaConversionUses = { BaseValue = 1 },
		ExtractValues = 
		{
			{
				Key = "MetaConversionUses",
				ExtractAs = "MetaConversionUse",
			}
		},
	},
	BossProgressionMetaUpgrade = 
	{
		InheritFrom = {"MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 4/3,
			},
			Epic =
			{
				Multiplier = 5/3,
			},
			Heroic = 
			{
				Multiplier = 2,
			}
		},
		PostBossCards = { BaseValue = 3 },
		ExtractValues = 
		{
			{
				Key = "PostBossCards",
				ExtractAs = "CardNum",
			}
		},
	},
	DoublerMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomEnhancementMultiplier = { BaseValue = 0.25,  },
		ExtractValues = 
		{
			{
				Key = "CustomEnhancementMultiplier",
				ExtractAs = "EnhanceMultiplier",
				Format = "Percent",
			}
		},
	},
}


OverwriteTableKeys( TraitData, TraitSetData.MetaUpgrade )