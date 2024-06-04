OverwriteTableKeys( TraitData, {
	-- Hephaestus
	HephaestusWeaponBoon = 
	{
		Icon = "Boon_Hephaestus_27",
		InheritFrom = { "BaseTrait", "FireBoon" },
		PriorityDisplay = true,
		Slot = "Melee",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 10/12,
			},
			Epic =
			{
				Multiplier = 8/12,
			},
			Heroic =
			{
				Multiplier = 6/12,
			}
		},
		SetupFunction =
		{
			Name = "MassiveAttackSetup",
			Args = 
			{
				TraitName = "HephaestusWeaponBoon",
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "CheckMassiveAttack",
			Args = 
			{
				Name = "MassiveAttack",
				TraitName = "HephaestusWeaponBoon",
				ProjectileName = "MassiveSlamBlast",
				Cooldown = 
				{ 
					BaseValue = 12,
					MinimumSourceValue = 2,
					AbsoluteStackValues =
					{
						[1] = -2,
						[2] = -1,
					},
				},
				BlastDelay = 0.08,
				DamageMultiplier = 1.0,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown"
				},
			},
		},
		StatLines =
		{
			"CooldownAltStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedCooldown",
					ExtractAs = "Cooldown",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "MassiveSlamBlast",
				BaseProperty = "Damage",
				SkipAutoExtract = true,
				DecimalPlaces = 1,
			},
		}
	},
	HephaestusSpecialBoon = 
	{
		Icon = "Boon_Hephaestus_30",
		InheritFrom = { "BaseTrait", "FireBoon" },
		PriorityDisplay = true,
		Slot = "Secondary",
		RarityLevels =
		{ 
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 18/20,
			},
			Epic =
			{
				Multiplier = 16/20,
			},
			Heroic =
			{
				Multiplier = 14/20,
			}
		},
		SetupFunction =
		{
			Name = "MassiveAttackSetup",
			Args = 
			{
				TraitName = "HephaestusSpecialBoon",
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			FunctionName = "CheckMassiveAttack",
			Args = 
			{
			
				ExcludeLinked = true,
				MultihitWeaponWhitelist = 
				{
					"WeaponTorchSpecial",
					"WeaponDaggerThrow"
				},
				Name = "MassiveSpecial",
				TraitName = "HephaestusSpecialBoon",
				ProjectileName = "MassiveSlamBlast",
				Cooldown = 
				{ 
					BaseValue = 20,
					MinimumSourceValue = 2,
					AbsoluteStackValues =
					{
						[1] = -2,
						[2] = -1,
					},
				},
				BlastDelay = 0.08,
				DamageMultiplier = 2.0,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown"
				},
			},
		},
		StatLines =
		{
			"CooldownAltStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedCooldown",
					ExtractAs = "Cooldown",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "MassiveSlamBlast",
				BaseProperty = "Damage",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
		}
	},
	HephaestusCastBoon =
	{
		Icon = "Boon_Hephaestus_29",
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Slot = "Ranged",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.4,
			},
			Epic =
			{
				Multiplier = 1.6,
			},
			Heroic =
			{
				Multiplier = 1.8,
			},
		},
		WeaponDataOverride =
		{
			WeaponCast =
			{
				FireScreenshake = { Distance = 3, Speed = 200, Duration = 0.5, FalloffSpeed = 3000 },
				HitScreenshake = { Distance = 0, Speed = 0, Duration = 0.0, FalloffSpeed = 0 },
				HitSimSlowParameters = { },
				OnFiredFunctionArgs = 
				{
					ProjectileDataProperties = { DamageRadius = true },
				},
			}
		},
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					Range = 600,
					DetonateFx = "HephMassiveHit",
					HideGraphicOnDetonate = false,
					FuseStart = 1.0,
					MultiDetonate = true,
					MaxDetonations = 3,
					ArmedImpactFx = "null",
					DeathFx = "CastCircleOut",
					ArmedDeathFx = "CastCircleOut",
				}
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "Damage",
				BaseValue = 50,
				ReportValues = {ReportedDamage = "ChangeValue"},
				AbsoluteStackValues =
				{
					[1] = 20,
					[2] = 15,
					[3] = 10,
					[4] = 5,
				},
				AsInt = true,
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "ArmedExpirationDamage",
				BaseValue = 50,
				ChangeType = "Add",
				IdenticalMultiplier =
				{
					Value = -0.6,
				},
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "Fuse",
				ChangeValue = 1.0,
				ReportValues = {ReportedFuse = "ChangeValue"}
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "DamageRadius",
				ChangeValue = 0.55,
				ChangeType = "Multiply",
				ReportValues = { ReportedRadius = "ChangeValue"}
			},

		},
		StatLines =
		{
			"CastDamageOverTimeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
			{
				Key = "ReportedFuse",
				ExtractAs = "Fuse",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "ChillDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "ChillEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "ChillActiveDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "ChillEffect",
				BaseProperty = "ActiveDuration",
			},
		}
	},
	HephaestusSprintBoon = 
	{
		Icon = "Boon_Hephaestus_28",
		InheritFrom = { "BaseTrait", "FireBoon" },
		Slot = "Rush",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
			}
		},
		WeaponDataOverride =
		{
			WeaponSprint =
			{		
				SkipManaIndicatorIfOutOfMana = true,
				OnChargeFunctionName = "DoWeaponCharge",
				ChargeWeaponData =
				{
					OnStageReachedFunctionName = "SprintChargeStage"
				},
				ShowManaIndicator = true,
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 10,
						SkipManaSpendOnFire = true,
						Wait = 1.0,
						ProjectileName = "HephSprintBlast",
						ReportValues = 
						{ 
							ReportedCooldown = "Wait"
						},
					},
				},
			}
		},
		SprintStrikeDamageMultiplier = 
		{ 
			BaseValue = 1, 
			MinMultiplier = 0.1,
			IdenticalMultiplier =
			{
				Value = -0.5,
			},
		},
				
		StatLines =
		{
			"AreaDamageAltStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedCooldown",
				ExtractAs = "ChargeDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "SprintStrikeDamageMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "HephSprintBlast",
				BaseProperty = "Damage",
			},
		}
	},
	HephaestusManaBoon =
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hephaestus_31",
		Slot = "Mana",
		RequiredFalseTraits = { "HeraManaShieldBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.50,
			},
			Epic =
			{
				Multiplier = 2.00,
			},
			Heroic =
			{
				Multiplier = 2.50,
			},
		},	
		OnDamagedManaConversionFlat = { 
			BaseValue = 50,
			MinMultiplier = 0.1,
			IdenticalMultiplier =
			{
				Value = -0.5,
				DiminishingReturnsMultiplier = 0.5,
			},
		},
		AddIncomingDamageModifiers =
		{
			ValidWeaponMultiplier = 0.9,
			ReportValues = 
			{
				ReportedMultiplier = "ValidWeaponMultiplier"
			},
		},
		StatLines =
		{
			"ManaRevengeRegenStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipDamageResistance",
				Format = "NegativePercentDelta",
				SkipAutoExtract = true
			},
			{
				Key = "OnDamagedManaConversionFlat",
				ExtractAs = "TooltipMana",
			},
		}
		--[[ from conversion version display
		StatLines =
		{
			"ManaRevengeRegenStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "OnDamagedManaConversion",
				ExtractAs = "TooltipMana",
				Format = "Percent"
			},
		}
		]]
	},

	ChargeCounterBoon = 
	{
		Icon = "Boon_Hephaestus_37",
		InheritFrom = { "BaseTrait", "FireBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.25,
			},
			Epic =
			{
				Multiplier = 1.50,
			},
			Heroic =
			{
				Multiplier = 1.75,
			}
		},
		OnSelfDamagedFunction = 
		{
			Name = "PrepOnHitEmpower",
			FunctionArgs = 
			{
				ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
				Vfx = "ErisPowerUpFx",
				BonusMultiplier = 
				{ 
					BaseValue = 1.0,
					AbsoluteStackValues =
					{
						[1] = 0.25,
						[2] = 0.15,
						[3] = 0.10,
					},
				}, 
				ReportValues = 
				{ 
					ReportedMultiplier = "BonusMultiplier"
				},
			}
		},
		StatLines = 
		{
			"BonusCounterDamageDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "BonusDamage",
				Format = "Percent",
			},
		}
	},
	AntiArmorBoon = 
	{
		InheritFrom = { "BaseTrait", "FireBoon" },
		Icon = "Boon_Hephaestus_39",
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
				Multiplier = 2.5,
			}
		},
		AddOutgoingDamageModifiers =
		{
			HealthBufferDamageMultiplier =
			{
				BaseValue = 1.2,
				SourceIsMultiplier = true,
				AbsoluteStackValues =
				{
					[1] = 1.2,
					[2] = 1.1,
					[3] = 1.05,
				},
			},
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "HealthBufferDamageMultiplier"},
		},
		StatLines =
		{
			"ArmorDamageIncreaseDisplay1",
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
	HeavyArmorBoon = 
	{
		InheritFrom = { "BaseTrait", "CostumeTrait", "EarthBoon" },
		Frame = "nil",
		Icon = "Boon_Hephaestus_38",
		BlockStacking = true,
		Invincible = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
			}
		},
		SetupFunctions =
		{
			{
				Name = "HeavyArmorSetup",
				Args = { Name = "HeavyArmor" },
			},
			{
				Name = "CostumeArmor",
				Args =
				{
					Source = "Tradeoff",
					Delay = 0.75,
					BaseAmount = 
					{ 
						BaseValue = 50,
					},
					ReportValues = 
					{ 
						ReportedArmor = "BaseAmount",
					}
				},
			},
		},
		StatLines =
		{
			"ArmorStatDisplay2",
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
			},
			--[[
			{
				Key = "ReportedSpeed",
				ExtractAs = "TooltipSpeedPenalty",
				Format = "NegativePercentDelta",
				HideSigns = true,
			}
			]]
		}
	},
	HeavyArmorExpired = 
	{
		Hidden = true,
	},
	ArmorBoon = 
	{
		InheritFrom = { "BaseTrait", "EarthBoon", "CostumeTrait"},
		Frame = "nil",
		Icon = "Boon_Hephaestus_32",
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
				Multiplier = 2.5,
			},
		},
		Invincible = true,
		SetupFunction =
		{
			Name = "HephaestusArmor",
			Args =
			{
				Source = "Renewable",
				Amount = 
				{ 
					BaseValue = 10, 
					AsInt = true,
					AbsoluteStackValues = 
					{
						[1] = 5,
						[2] = 3,
						[3] = 2,
						[4] = 2,
					}
				},
				ManaReservationCost = 30,
				ReportValues = 
				{ 
					ReportedArmor = "Amount",
					ReportedCost = "ManaReservationCost",
				}
			},
		},
		
		StatLines =
		{
			"StartingArmorStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
				IncludeSigns = true,
			},
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipCost",
				SkipAutoExtract = true,
			},
		}
	},
	EncounterStartDefenseBuffBoon =
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hephaestus_36",
		EncounterStartWeapon = "EncounterStartBuffWeapon",
		PreEquipWeapons = { "EncounterStartBuffWeapon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.25,
			},
			Epic =
			{
				Multiplier = 1.50,
			},
			Heroic =
			{
				Multiplier = 1.75,
			}
		},
		PropertyChanges =
		{
			{
				WeaponName = "EncounterStartBuffWeapon",
				EffectName = "EncounterStartInvulnerableBuff",
				EffectProperty = "Duration",
				BaseValue = 8,
				ReportValues = { ReportedDuration = "ChangeValue" },

				MinValue = 1,
				AbsoluteStackValues = 
				{
					[1] = 2,
					[2] = 1,
				},
			},
		},
		
		StatLines =
		{
			"InvulnerableDurationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipAmount",
				DecimalPlaces = 2,
			},
		}
	},
	ManaToHealthBoon = 
	{
		Icon = "Boon_Hephaestus_33",
		InheritFrom = { "BaseTrait", "EarthBoon" },
		MaxManaToMaxHealthConversion = { BaseValue = 0.2 },
		BlockStacking = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
			}
		},
		StatLines =
		{
			"BonusManaLifeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "MaxManaToMaxHealthConversion",
				ExtractAs = "BonusHealth",
				Format = "Percent",
			},
		}
	},
	MassiveKnockupBoon = 
	{
		Icon = "Boon_Hephaestus_35",
		InheritFrom = { "BaseTrait", "FireBoon" },
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
				Multiplier = 2.0,
			}
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast" },
			EffectName = "DelayedKnockbackEffect",
			Args = 
			{
				TriggerDamage = 
				{ 
					BaseValue = 300,
					AbsoluteStackValues = 
					{
						[1] = 50,
						[2] = 30,
						[3] = 20,
					},
				},
				ReportValues = 
				{ 
					ReportedDamage = "TriggerDamage",
				}
			},
		},
		StatLines = 
		{
			"DelayedKnockbackStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipDamage",
			},
			{
				ExtractAs = "DelayedKnockbackDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DelayedKnockbackEffect",
				BaseProperty = "Duration",
				DecimalPlaces = 1,
			},
		}
	},
	WeaponUpgradeBoon = -- Legendary
	{
		InheritFrom = { "LegendaryTrait", "EarthBoon" },
		Icon = "Boon_Hephaestus_40",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},
		AcquireFunctionName = "UpgradeAspect",
		AcquireFunctionArgs = 
		{
			UpgradeLevels = 1,
			ReportValues = { ReportedUpgrade = "UpgradeLevels" }
		},
		StatLines = 
		{
			"AspectRankStatDisplay",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrade",
				ExtractAs = "Rank",
				IncludeSigns = true,
			},
		}
	},
})